--debemos ajustarlo para que almacene exactamente los 16 puntos 
--por periodo que exige el enunciado. He incluido la librería NUMERIC_STD
-- para que la función to_signed funcione correctamente 
--y he calculado los valores siguiendo la fórmula f(t)=127⋅sin(ωt)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Necesaria para usar to_signed 

entity ROM is
    port (
        -- Reducimos el rango a 15 ya que solo necesitamos 16 puntos 
        address : in integer range 0 to 15; 
        data_o  : out std_logic_vector(7 downto 0)
    );
end ROM;

architecture behavioral of ROM is
    -- Definimos el array para 16 valores de 8 bits
    type rom_t is array (0 to 15) of std_logic_vector(7 downto 0);
    
    -- Valores calculados como: f(t)=127 * sin(n * 2 * pi / 16)  (360∘/16=22.5∘ por paso)
    signal rom : rom_t := (
        std_logic_vector(to_signed(0, 8)),    -- Punto 0: 0°
        std_logic_vector(to_signed(49, 8)),   -- Punto 1: 22.5°     127*22.5=49
        std_logic_vector(to_signed(90, 8)),   -- Punto 2: 45°       127*45=90
        std_logic_vector(to_signed(117, 8)),  -- Punto 3: 67.5°
        std_logic_vector(to_signed(127, 8)),  -- Punto 4: 90° (Máximo)
        std_logic_vector(to_signed(117, 8)),  -- Punto 5: 112.5°
        std_logic_vector(to_signed(90, 8)),   -- Punto 6: 135°
        std_logic_vector(to_signed(49, 8)),   -- Punto 7: 157.5°
        std_logic_vector(to_signed(0, 8)),    -- Punto 8: 180°
        std_logic_vector(to_signed(-49, 8)),  -- Punto 9: 202.5°
        std_logic_vector(to_signed(-90, 8)),  -- Punto 10: 225°
        std_logic_vector(to_signed(-117, 8)), -- Punto 11: 247.5°
        std_logic_vector(to_signed(-127, 8)), -- Punto 12: 270° (Mínimo)
        std_logic_vector(to_signed(-117, 8)), -- Punto 13: 292.5°
        std_logic_vector(to_signed(-90, 8)),  -- Punto 14: 315°
        std_logic_vector(to_signed(-49, 8))   -- Punto 15: 337.5°
    );

begin
    -- Lectura asíncrona de la memoria
    data_o <= rom(address);
end behavioral;