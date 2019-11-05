LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY clock_divider IS
    GENERIC (clock_period : TIME);
    PORT (clk : OUT std_logic);
END clock_divider;
ARCHITECTURE Behavioral OF clock_divider
    IS
BEGIN
    clock_divider_proc : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR clock_period;
        clk <= '1';
        WAIT FOR clock_period;
    END PROCESS;
END Behavioral;