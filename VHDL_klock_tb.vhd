library IEEE;
library WORK;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use WORK.VHDL_klock_pkg.all;

entity VHDL_klock_tb is
end entity;

architecture tb of VHDL_Klock_tb is

    signal clk_s : std_logic := '0';
    signal rst_n_s : std_logic := '1';
    signal key_n_s : std_logic := '1';
    signal out_time_s : time_array_t := (others => (others => '0'));

    constant CLK_PERIOD : time := 20 ns;
    constant SIM_TIME : time := 1000 * CLK_PERIOD;

begin
    uut : counter
    generic map(CNT_1S_G => 5, CNT_LIM_G => 86399)
    port map(
        clk => clk_s,
        rst_n => rst_n_s,
        key_n => key_n_s,
        out_time => out_time_s
    );

    clk_proc : process
    begin
        clk_s <= not clk_s;
        wait for CLK_PERIOD/2;
        if (now > SIM_TIME) then
            wait;
        end if;
    end process;

    stimuli : process
    begin
        
        rst_n_s <= '0';
        wait for 3 * CLK_PERIOD;
        rst_n_s <= '1';
        wait;
    end process;

end architecture;