LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE std.textio.ALL;

ENTITY clock_divider_tb IS
END clock_divider_tb;
ARCHITECTURE testbench OF clock_divider_tb IS
    SIGNAL clk : std_logic := '0';
    CONSTANT clock_period : TIME := 80 ns;

    COMPONENT clock_divider
        GENERIC (clock_period : TIME);
        PORT (
            clk : OUT std_logic
        );
    END COMPONENT;

BEGIN
    uut : clock_divider
    GENERIC MAP(clock_period => clock_period)
    PORT MAP(
        clk => clk
    );
    PROCESS
        VARIABLE time_spent : TIME := 0 ns;

    BEGIN
        WAIT UNTIL rising_edge(clk);
        time_spent := time_spent + clock_period/4;
        IF time_spent = 20 ns THEN
            REPORT "In half a period, 20 nano seconds passed" SEVERITY NOTE;
        ELSE
            REPORT "wrong half period value" SEVERITY FAILURE;
        END IF;
        WAIT UNTIL falling_edge(clk);
        time_spent := time_spent + clock_period/4;
        IF time_spent = 40 ns THEN
            REPORT "In full period 40 nano seconds passed" SEVERITY NOTE;
        ELSE
            REPORT "wrong full period value" SEVERITY FAILURE;
        END IF;
        WAIT;
    END PROCESS;
END testbench;