--pipeline añade registros entre las operaciones (multiplicación y suma)
-- para trabajar a altas velocidades 
--sin que el camino crítico sea demasiado largo.
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
        Clk      : in  std_logic;
        Reset    : in  std_logic;
        DataIn   : in  signed(7 downto 0);
        Enable   : in  std_logic;
        DataOut  : out signed(7 downto 0)
    );
end FILTER;

architecture Pipeline of FILTER is
 -- Metemos los generics en un array interno para poder usarlos en un bucle 'for'
    type t_coefs is array (0 to 9) of signed(7 downto 0);
    -- Enlazamos los generics con el array de coeficientes
    constant A : t_coefs := (
        to_signed(COEF_0, 8), to_signed(COEF_1, 8), to_signed(COEF_2, 8),
        to_signed(COEF_3, 8), to_signed(COEF_4, 8), to_signed(COEF_5, 8),
        to_signed(COEF_6, 8), to_signed(COEF_7, 8), to_signed(COEF_8, 8),
        to_signed(COEF_9, 8)
    );

    type t_shift_reg is array (0 to 9) of signed(7 downto 0);
    signal sX : t_shift_reg := (others => (others => '0'));

    type t_mult_reg is array (0 to 9) of signed(15 downto 0);
    signal sP : t_mult_reg := (others => (others => '0'));

begin
    process(Clk, Reset)
		--en el for de la suma de las muestras vamos sumando valores de 16 bits 
	--al sumar 2 necesitamos 17 bits para q no pierda ni el signo ni los datos
	--asi hasta la ultima iteracion donde sumamos 10 numeros de 16 bits x lo que
	--necesitaremos 20 bits
        variable v_sum : signed(19 downto 0);
    begin
        if Reset = '1' then
            sX <= (others => (others => '0'));
            sP <= (others => (others => '0'));
            DataOut <= (others => '0');
        elsif rising_edge(Clk) then
            if Enable = '1' then
                -- Etapa 1: Registros de entrada (Pipeline)  
				--Captura: Guarda la muestra actual y las anteriores en el Shift Register (sX).
                sX(0) <= DataIn;
                for i in 1 to 9 loop
                    sX(i) <= sX(i-1);
                end loop;

                -- Etapa 2:
				--Multiplicación: Multiplica cada muestra por su coeficiente correspondiente y guarda el resultado en registros intermedios (sP).
                for i in 0 to 9 loop
                    sP(i) <= sX(i) * A(i);
                end loop;

               -- Etapa 3: 
				--Suma: Suma todos los productos para obtener la salida final.
                v_sum := (others => '0');
                for i in 0 to 9 loop
                    v_sum := v_sum + resize(sP(i), 20);
                end loop;
                DataOut <= v_sum(16 downto 9);
            end if;
        end if;
    end process;
end Pipeline;