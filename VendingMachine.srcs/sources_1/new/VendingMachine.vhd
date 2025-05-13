library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity VendingMachine is
    Port (
        nickel_in   : in  STD_LOGIC;
        dime_in     : in  STD_LOGIC;
        quarter_in  : in  STD_LOGIC;
        Clock_System: in  STD_LOGIC;
        Reset       : in  STD_LOGIC;
        candy_out   : out STD_LOGIC;
        nickel_out  : out STD_LOGIC;
        dime_out    : out STD_LOGIC
    );
end VendingMachine;

architecture Behavioral of VendingMachine is

    component Frequency_Divider is
        Port (
            Clock_System : in  STD_LOGIC;
            Clock_2ms    : out STD_LOGIC
        );
    end component;

    type state_type is (st0, st5, st10, st15, st20, st25, st30, st35, st40, st45);
    signal state : state_type := st0;

    signal Clk_2ms : std_logic := '0';

    signal prev_nickel, prev_dime, prev_quarter : std_logic := '0';
    signal nickel_edge, dime_edge, quarter_edge : std_logic := '0';
    signal candy_latch, nickel_latch, dime_latch : std_logic := '0';

begin

    freqDiv: Frequency_Divider port map (
        Clock_System => Clock_System,
        Clock_2ms    => Clk_2ms);

candy_out  <= candy_latch;
nickel_out <= nickel_latch;
dime_out   <= dime_latch;

edgeDetect: process(Clk_2ms)
begin
    if rising_edge(Clk_2ms) then
        if (nickel_in = '1' and prev_nickel = '0') then
            nickel_edge <= '1';
        else
            nickel_edge <= '0';
        end if;

        if (dime_in = '1' and prev_dime = '0') then
            dime_edge <= '1';
        else
            dime_edge <= '0';
        end if;

        if (quarter_in = '1' and prev_quarter = '0') then
            quarter_edge <= '1';
        else
            quarter_edge <= '0';
        end if;

        prev_nickel  <= nickel_in;
        prev_dime    <= dime_in;
        prev_quarter <= quarter_in;
    end if;
end process;

    vendingFSM: process(Clk_2ms, Reset)
    begin
        if Reset = '1' then
            state <= st0;
            candy_latch  <= '0';
            nickel_latch <= '0';
            dime_latch   <= '0';
        elsif rising_edge(Clk_2ms) then
            case state is
                when st0 =>
                    if nickel_edge = '1' then state <= st5;
                    elsif dime_edge = '1' then state <= st10;
                    elsif quarter_edge = '1' then state <= st25;
                    end if;

                when st5 =>
                    if nickel_edge = '1' then state <= st10;
                    elsif dime_edge = '1' then state <= st15;
                    elsif quarter_edge = '1' then state <= st30;
                    end if;

                when st10 =>
                    if nickel_edge = '1' then state <= st15;
                    elsif dime_edge = '1' then state <= st20;
                    elsif quarter_edge = '1' then state <= st35;
                    end if;

                when st15 =>
                    if nickel_edge = '1' then state <= st20;
                    elsif dime_edge = '1' then state <= st25;
                    elsif quarter_edge = '1' then state <= st40;
                    end if;

                when st20 =>
                    if nickel_edge = '1' then state <= st25;
                    elsif dime_edge = '1' then state <= st30;
                    elsif quarter_edge = '1' then state <= st45;
                    end if;

                when st25 =>
                    candy_latch <= '1';
                    state <= st0;

                when st30 =>
                    candy_latch  <= '1';
                    nickel_latch <= '1';
                    state <= st5;

                when st35 =>
                    candy_latch <= '1';
                    dime_latch  <= '1';
                    state <= st10;

                when st40 =>
                    candy_latch  <= '1';
                    nickel_latch <= '1';
                    dime_latch   <= '1';
                    state <= st15;

                when st45 =>
                    candy_latch <= '1';
                    dime_latch  <= '1';
                    state <= st20;

            end case;
        end if;
    end process;

end Behavioral;
