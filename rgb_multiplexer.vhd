LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

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
    SIGNAL internal_clock_sig : std_logic := 'X';
    SIGNAL hcounter : unsigned (9 DOWNTO 0) := to_unsigned(0, 10);
    SIGNAL vcounter : unsigned (9 DOWNTO 0) := to_unsigned(0, 10);

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
    red_proc : PROCESS (internal_clock_sig)
    BEGIN
        IF internal_clock_sig'event AND internal_clock_sig = '1' THEN
            IF vcounter < 480 THEN
                IF hcounter < 320 THEN
                    red_out <= '1';
                ELSE
                    red_out <= '0';
                END IF;
            ELSE
                red_out <= '0';
            END IF;
        END IF;
        -- linking signals to outputs
        internal_clock <= internal_clock_sig;
    END PROCESS;
    green_proc : PROCESS (internal_clock_sig)
    BEGIN
        IF internal_clock_sig'event AND internal_clock_sig = '1' THEN
            IF hcounter < 640 THEN
                IF vcounter <= 120 AND vcounter >= 360 THEN
                    green_out <= '1';
                ELSE
                    green_out <= '0';
                END IF;
            ELSE
                green_out <= '0';
            END IF;
        END IF;
        -- linking signals to outputs
        internal_clock <= internal_clock_sig;
    END PROCESS;
    blue_proc : PROCESS (internal_clock_sig)
    BEGIN
        IF internal_clock_sig'event AND internal_clock_sig = '1' THEN
            IF hcounter < 640 THEN
                IF vcounter < 240 THEN
                    blue_out <= '1';
                ELSE
                    blue_out <= '0';
                END IF;
            ELSE
                blue_out <= '0';
            END IF;
        END IF;
        -- linking signals to outputs
        internal_clock <= internal_clock_sig;
    END PROCESS;
END Behavioral;