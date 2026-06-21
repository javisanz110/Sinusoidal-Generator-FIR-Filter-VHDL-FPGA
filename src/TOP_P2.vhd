library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TOP_P2 is
    Port (
        Clk      : in  std_logic;
        Reset    : in  std_logic;
        per      : in  std_logic_vector(1 downto 0);
        dac_filt : out unsigned(7 downto 0);
        led_raw  : out signed(7 downto 0)
    );
end TOP_P2;

architecture behavioraltop of TOP_P2 is
    signal sig_sen        : signed(7 downto 0);
    signal sig_enable_10k : std_logic;
    signal sig_filt_out   : signed(7 downto 0);
begin

    Inst_GenSen: entity work.GenSen
        port map (
            Clk   => Clk,
            Reset => Reset,
            per   => per,
            led   => sig_sen,
            dac   => open
        );

    Inst_Sample: entity work.Sample_Gen
        port map (
            Clk    => Clk,
            Reset  => Reset,
            Enable => sig_enable_10k
        );

    -- MAPEO DE GENERICS
    Inst_Filter: entity work.FILTER
        generic map (
            COEF_0 => 1,  COEF_1 => 9,  COEF_2 => 38,  COEF_3 => 85, COEF_4 => 123,
            COEF_5 => 123, COEF_6 => 85, COEF_7 => 38,  COEF_8 => 9,  COEF_9 => 1
        )
        port map (
            Clk     => Clk,
            Reset   => Reset,
            DataIn  => sig_sen,
            Enable  => sig_enable_10k,
            DataOut => sig_filt_out
        );

    led_raw <= sig_sen;

    -- TRUCO PARA EL DAC: De signed (-128 a 127) a unsigned (0 a 255)
    -- Invertir el bit de signo es matemáticamente igual a sumar 128
    dac_filt <= unsigned(not sig_filt_out(7) & sig_filt_out(6 downto 0));

end behavioraltop;