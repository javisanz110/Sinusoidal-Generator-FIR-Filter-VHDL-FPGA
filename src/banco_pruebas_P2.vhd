library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TOP_P2_TB is
end TOP_P2_TB;

architecture Behavioral of TOP_P2_TB is
    signal clk_tb      : std_logic := '0';
    signal reset_tb    : std_logic := '0';
    signal per_tb      : std_logic_vector(1 downto 0) := "00";
    signal dac_filt_tb : unsigned(7 downto 0);
    signal led_raw_tb  : signed(7 downto 0);

    constant clk_period : time := 10 ns; -- 100 MHz
begin

    uut: entity work.TOP_P2 --con work evitamos escribir component , más rapido.
        port map (
            Clk      => clk_tb,
            Reset    => reset_tb,
            per      => per_tb,
            dac_filt => dac_filt_tb,
            led_raw  => led_raw_tb
        );

    -- Generación de reloj
    clk_process : process
    begin
        clk_tb <= '0'; wait for clk_period/2;
        clk_tb <= '1'; wait for clk_period/2;
    end process;

    -- Proceso de estímulos para ver 2 ciclos de cada frecuencia
    stim_proc: process
    begin		
        reset_tb <= '1'; wait for 100 ns;
        reset_tb <= '0'; wait for 100 ns;

        -- 1. 500 Hz (T=2ms) -> 4ms
        per_tb <= "00"; wait for 4 ms;

        -- 2. 1000 Hz (T=1ms) -> 2ms
        per_tb <= "01"; wait for 2 ms;

        -- 3. 2200 Hz (T=0.45ms) -> 1 ms
        per_tb <= "10"; wait for 1 ms;

        -- 4. 4000 Hz (T=0.25ms) -> 1 ms
        per_tb <= "11"; wait for 1 ms;

        wait;
    end process;
end Behavioral;