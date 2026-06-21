library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FILTER is
    generic (
        COEF_0 : integer; COEF_1 : integer; COEF_2 : integer;
        COEF_3 : integer; COEF_4 : integer; COEF_5 : integer;
        COEF_6 : integer; COEF_7 : integer; COEF_8 : integer;
        COEF_9 : integer
    );
    port (
        Clk     : in  STD_LOGIC;
        Reset   : in  STD_LOGIC;
        DataIn  : in  SIGNED(7 downto 0);
        Enable  : in  STD_LOGIC;
        DataOut : out SIGNED(7 downto 0)
    );
end FILTER;

architecture parallel of FILTER is

	type t_shift_reg is array (0 to 9) of signed(7 downto 0);
    signal sX : t_shift_reg := (others => (others => '0'));

    -- Productos (8 bits entrada * coef -> usamos 23 bits para margen)
    signal p0, p1, p2, p3, p4, p5, p6, p7, p8, p9 : signed( 23 downto 0);

    -- Suma total
    signal sum_total : signed(27 downto 0);

begin

   
    -- Desplaza las muestras 
 
    process(Clk, Reset)
    begin
        if Reset = '1' then
            sX(0) <= (others => '0');
            sX(1) <= (others => '0');
            sX(2) <= (others => '0');
            sX(3) <= (others => '0');
            sX(4) <= (others => '0');
            sX(5) <= (others => '0');
            sX(6) <= (others => '0');
            sX(7) <= (others => '0');
            sX(8) <= (others => '0');
			sX(9) <= (others => '0');
        elsif rising_edge(Clk) then
            if Enable = '1' then
               sX(0) <= DataIn;
                for i in 1 to 9 loop
                    sX(i) <= sX(i-1);
                end loop;
            end if;
        end if;
    end process;

 
    -- Multiplicaciones 
   
    p0 <= resize(sX(0) * to_signed(COEF_0, 16), 24);
    p1 <= resize(sX(1) * to_signed(COEF_1, 16), 24);
    p2 <= resize(sX(2) * to_signed(COEF_2, 16), 24);
    p3 <= resize(sX(3) * to_signed(COEF_3, 16), 24);
    p4 <= resize(sX(4) * to_signed(COEF_4, 16), 24);
    p5 <= resize(sX(5) * to_signed(COEF_5, 16), 24);
    p6 <= resize(sX(6) * to_signed(COEF_6, 16), 24);
    p7 <= resize(sX(7) * to_signed(COEF_7, 16), 24);
    p8 <= resize(sX(8) * to_signed(COEF_8, 16), 24);
	p9 <= resize(sX(9) * to_signed(COEF_9, 16), 24);
 
    -- Suma 
	
    sum_total <= p0 + p1 + p2 + p3 + p4 + p5 + p6 + p7 + p8 + p9;

  
    -- Salida: dividir por 256 (desplazar 8 bits a la derecha)
    -- y recortar a 8 bits con signo
 
    DataOut <= sum_total(23 downto 15);

end parallel;