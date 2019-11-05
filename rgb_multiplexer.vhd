LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY rgb_multiplexer IS
    PORT (
        clk : IN std_logic;
        red_out : OUT std_logic;
        green_out : OUT std_logic;
        blue_out : OUT std_logic;
        -- debug
        internal_clock : OUT std_logic);
END rgb_multiplexer;
ARCHITECTURE Behavioral OF rgb_multiplexer
    IS
    SIGNAL internal_clock_sig : std_logic:='0';
    COMPONENT clock_divider
        PORT (
            clk_in : IN std_logic;
            clk_out : OUT std_logic
        );
    END COMPONENT;

    BEGIN
        clock_divider_instl : clock_divider
        PORT MAP(
            clk_in => clk,
            clk_out => internal_clock_sig
        );
        rgb_multiplexer_proc : PROCESS (internal_clock_sig)
        BEGIN
            IF internal_clock_sig'event AND internal_clock_sig = '1' THEN
            END IF;
            -- linking signals to outputs
            internal_clock <= internal_clock_sig;
        END PROCESS;
END Behavioral;