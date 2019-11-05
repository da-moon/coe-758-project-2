LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY rgb_multiplexer_tb IS
END rgb_multiplexer_tb;
ARCHITECTURE testbench OF rgb_multiplexer_tb IS
    SIGNAL clk_sig : std_logic := '0';
    SIGNAL internal_clock_sig : std_logic:='0';
    SIGNAL red_out_sig : std_logic:='0';
    SIGNAL green_out_sig : std_logic:='0';
    SIGNAL blue_out_sig : std_logic:='0';

    COMPONENT rgb_multiplexer
        PORT (
            clk : IN std_logic;
            red_out : OUT std_logic;
            green_out : OUT std_logic;
            blue_out : OUT std_logic;
            -- debug
            internal_clock : OUT std_logic);
    END COMPONENT;

BEGIN
    clockProcess : PROCESS
    BEGIN
        clk_sig <= '1';
        WAIT FOR 40 ns;
        clk_sig <= '0';
        WAIT FOR 40 ns;
    END PROCESS;
    uut : rgb_multiplexer
    PORT MAP(
        clk => clk_sig,
        red_out =>red_out_sig,
        green_out =>green_out_sig,
        blue_out => blue_out_sig,
        internal_clock => internal_clock_sig
    );
    PROCESS

    BEGIN
        REPORT "testing frequency of internal clock ... "SEVERITY NOTE;
        REPORT "Starting clock value of " & STD_LOGIC'IMAGE(clk_sig) SEVERITY NOTE;
        WAIT UNTIL rising_edge(clk_sig);
        WAIT UNTIL falling_edge(clk_sig);
        WAIT FOR 1 ns;
        IF internal_clock_sig = '1' THEN
            REPORT "Global frequency was successfully halfved for internal frequency" SEVERITY NOTE;
        ELSE
            REPORT "wrong half period value of " & STD_LOGIC'IMAGE(internal_clock_sig) SEVERITY FAILURE;
        END IF;

        WAIT UNTIL rising_edge(clk_sig);
        WAIT UNTIL falling_edge(clk_sig);
        WAIT FOR 1 ns;
        IF internal_clock_sig = '0' THEN
            REPORT "In period was successfully halved" SEVERITY NOTE;
        ELSE
            REPORT "wrong half period value of " & STD_LOGIC'IMAGE(internal_clock_sig) SEVERITY FAILURE;
        END IF;
        WAIT UNTIL rising_edge(clk_sig);
        WAIT UNTIL falling_edge(clk_sig);
        WAIT FOR 1 ns;
        IF internal_clock_sig = '1' THEN
            REPORT "In period was successfully halved" SEVERITY NOTE;
        ELSE
            REPORT "wrong half period value of " & STD_LOGIC'IMAGE(internal_clock_sig) SEVERITY FAILURE;
        END IF;
        WAIT UNTIL rising_edge(clk_sig);
        WAIT UNTIL falling_edge(clk_sig);
        WAIT FOR 1 ns;
        IF internal_clock_sig = '0' THEN
            REPORT "In period was successfully halved" SEVERITY NOTE;
        ELSE
            REPORT "wrong half period value of " & STD_LOGIC'IMAGE(internal_clock_sig) SEVERITY FAILURE;
        END IF;
        WAIT;
    END PROCESS;
END testbench;