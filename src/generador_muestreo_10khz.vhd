library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sample_Gen is
    port (
        Clk    : in  std_logic;
        Reset  : in  std_logic;
        Enable : out std_logic
    );
end Sample_Gen;

architecture Behavioral of Sample_Gen is
    signal counter : integer range 0 to 9999 := 0;
begin
    process(Clk, Reset)
    begin
        if Reset = '1' then
            counter <= 0;
            Enable <= '0';
        elsif rising_edge(Clk) then
            if counter = 9999 then
                counter <= 0;
                Enable <= '1';
            else
                counter <= counter + 1;
                Enable <= '0';
            end if;
        end if;
    end process;
end Behavioral;