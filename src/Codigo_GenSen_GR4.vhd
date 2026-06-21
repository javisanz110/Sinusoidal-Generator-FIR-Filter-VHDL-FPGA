-- GRUPO 4: Frecuencias personalizadas
-- "00" -> 500 Hz  (Max: 12500)
-- "01" -> 1000 Hz (Max: 6250)
-- "10" -> 2200 Hz (Max: 2841)
-- "11" -> 4000 Hz (Max: 1562)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GenSen is
    Port (
        Clk   : in  std_logic;
        Reset : in  std_logic;
        per   : in  std_logic_vector(1 downto 0);
        led   : out signed (7 downto 0);
        dac   : out unsigned(7 downto 0)
    );
end GenSen;

architecture Behavioral of GenSen is
  --Mapeo de la ROM
  component ROM
        port(
            address : in  integer range 0 to 15;
            data_o  : out std_logic_vector (7 downto 0)
        );
    end component;

    signal maximo   : integer := 12500;
    signal contador : integer range 0 to 15 := 0;
    signal auxiliar : integer range 0 to 13000 := 0; -- Rango ajustado
    
    signal rom_direccion : integer range 0 to 15 := 0;
    signal rom_datos     : std_logic_vector (7 downto 0);

begin
    ROM_valores : ROM port map (address => rom_direccion, data_o => rom_datos);

    process(per)
    begin
        case per is 
            when "00" => maximo <= 12500; -- 500 Hz
            when "01" => maximo <= 6250;  -- 1000 Hz
            when "10" => maximo <= 2841;  -- 2200 Hz
            when "11" => maximo <= 1562;  -- 4000 Hz
            when others => maximo <= 12500;
        end case;
    end process;

    process (Clk, Reset)
    begin 
        if Reset = '1' then
            auxiliar <= 0;
            contador <= 0;
        elsif rising_edge(Clk) then 
            if auxiliar >= maximo - 1 then 
                auxiliar <= 0;
                if contador = 15 then
                    contador <= 0;
                else 
                    contador <= contador + 1;
                end if;
            else 
                auxiliar <= auxiliar + 1;
            end if; 
			-- Actualizamos la dirección de la ROM sincronizada con el reloj
            rom_direccion <= contador;
        end if;
    end process;

 -- El LED muestra el valor tal cual (complemento a 2)
    led <= signed(rom_datos);
	-- El DAC suma 128 para convertir a binario natural 
    dac <= unsigned(signed(rom_datos) + 128);--realiza la conversión de "signed" a "binario natural" sumando el offset necesario para que el valor más bajo ($ -127$) se represente cerca de 0 y el más alto (+127) cerca de 255
end Behavioral;