library IEEE;
library WORK;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use WORK.VHDL_klock_pkg.all;

entity VHDL_klock_tb is
end entity;

architecture tb of VHDL_Klock_tb is

    component VHDL_klock is
        generic(MASTER_CNT_1S_G : natural := FREQUENCY_1HZ);
        port (
            clk              : in std_logic;
            rst_n            : in std_logic;
            func_sw          : in std_logic;
            start_key_n      : in std_logic;
            h_key_n          : in std_logic;
            m_key_n          : in std_logic;
            s_key_n          : in std_logic;
            hex              : out seven_seg_array_t
        );
    end component;

    signal clk_s             : std_logic         := '0';
    signal rst_n_s           : std_logic         := '1';
    signal func_sw_s         : std_logic         := '1';
    signal start_key_n_s     : std_logic         := '1';
    signal h_key_n_s         : std_logic         := '1';
    signal m_key_n_s         : std_logic         := '1';
    signal s_key_n_S         : std_logic         := '1';
    signal hex_s             : seven_seg_array_t := (others => (others => '0'));
    signal sim_comment_s    : string(1 to COMMENT_LENGTH);
    
    constant CLK_PERIOD      : time := 20 ns;
    constant SIM_TIME        : time := 100 * CLK_PERIOD;

    procedure modify_inputs(
        values               : in std_logic_vector(4 downto 0);
        signal func_sw_s     : out std_logic;
        signal start_key_n_s : out std_logic;
        signal h_key_n_s     : out std_logic;
        signal m_key_n_s     : out std_logic;
        signal s_key_n_s     : out std_logic
    ) is
    begin
        func_sw_s            <= values(4);
        start_key_n_s        <= values(3);
        h_key_n_s            <= values(2);
        m_key_n_s            <= values(1);
        s_key_n_s            <= values(0);
        wait for 3 * CLK_PERIOD;
        func_sw_s            <= '0';
        start_key_n_s        <= '0';
        h_key_n_s            <= '0';
        m_key_n_s            <= '0';
        s_key_n_s            <= '0';
        wait for 5 * CLK_PERIOD;

    end procedure;

begin
    uut : VHDL_klock
    generic map(MASTER_CNT_1S_G => FREQUENCY_TEST)
    port map(
        clk         => clk_s,
        rst_n       => rst_n_s,
        func_sw     => func_sw_s,
        start_key_n => start_key_n_s,
        h_key_n     => h_key_n_s,
        m_key_n     => m_key_n_s,
        s_key_n     => s_key_n_s,
        hex         => hex_s
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
       sim_comment_s <= set_sim_comment("reset");
       rst_n_s <= '0';
       wait for 2*CLK_PERIOD;
       rst_n_s <= '1';
       
       wait for 5*CLK_PERIOD;

       sim_comment_S <= set_sim_comment("timer: 1h 1m 1s");
	   modify_inputs("00111", func_sw_s, start_key_n_s, h_key_n_s, m_key_n_s, s_key_n_s);

       sim_comment_s <= set_sim_comment("timer: start");
	   modify_inputs("01000", func_sw_s, start_key_n_s, h_key_n_s, m_key_n_s, s_key_n_s);

       sim_comment_s <= set_sim_comment("timer: byt till klocka");
	   modify_inputs("10000", func_sw_s, start_key_n_s, h_key_n_s, m_key_n_s, s_key_n_s);

       sim_comment_s <= set_sim_comment("klocka: starta klockan");
	   modify_inputs("11000", func_sw_s, start_key_n_s, h_key_n_s, m_key_n_s, s_key_n_s);

       sim_comment_s <= set_sim_comment("klocka: byt till timer");
	   modify_inputs("00000", func_sw_s, start_key_n_s, h_key_n_s, m_key_n_s, s_key_n_s);
       wait;
    end process;

end architecture;