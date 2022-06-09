library IEEE;
library WORK;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.VHDL_klock_pkg.all;
entity VHDL_klock is
	generic(MASTER_CNT_1S_G : natural := FREQUENCY_1HZ);
	port (
		clk          : in std_logic;
		rst_n        : in std_logic;
		func_sw      : in std_logic;
		start_key_n  : in std_logic;
		h_key_n      : in std_logic;
		m_key_n      : in std_logic;
		s_key_n      : in std_logic;
		hex          : out seven_seg_array_t
	);
end entity;

architecture behaviour of VHDL_klock is
	--w_ = watch
	--t_ = timer

	signal out_time_s                                  : time_array_t;
	signal cnt_s, w_cnt_s, t_cnt_s                     : natural;
	signal start_key_n_f, w_start_key_s, t_start_key_s : std_logic;
	signal h_key_n_f, w_h_key_s, t_h_key_s             : std_logic;
	signal m_key_n_f, w_m_key_s, t_m_key_s             : std_logic;
	signal s_key_n_f, w_s_key_s, t_s_key_s             : std_logic;
	

begin

	watch : counter
	generic map(
		CNT_1S_G    => MASTER_CNT_1S_G,
		CNT_LIM_G   => 86399,
		PAUSED_G    => '1',
		COUNT_UP_G  => '1'
	)
	port map(
		clk         => clk,
		rst_n       => rst_n,
		start_key   => w_start_key_s,
		h_key       => w_h_key_s,
		m_key       => w_m_key_s,
		s_key       => w_s_key_s,
		cnt         => w_cnt_s
	);

	timer : counter
	generic map(
		CNT_1S_G    => MASTER_CNT_1S_G,
		CNT_LIM_G   => 86399,
		PAUSED_G    => '1',
		COUNT_UP_G  => '0'
	)
	port map(
		clk         => clk,
		rst_n       => rst_n,
		start_key   => t_start_key_s,
		h_key       => t_h_key_s,
		m_key       => t_m_key_s,
		s_key       => t_s_key_s,
		cnt         => t_cnt_s
	);

	h_H : seven_seg
	port map(
		n_in => out_time_s(0),
		X    => hex(0)
	);
	h_L : seven_seg
	port map(
		n_in => out_time_s(1),
		X    => hex(1)
	);
	m_H : seven_seg
	port map(
		n_in => out_time_s(2),
		X    => hex(2)
	);
	m_L : seven_seg
	port map(
		n_in => out_time_s(3),
		X    => hex(3)
	);
	s_H : seven_seg
	port map(
		n_in => out_time_s(4),
		X    => hex(4)
	);
	s_L : seven_seg
	port map(
		n_in => out_time_s(5),
		X    => hex(5)
	);

	process (clk) is
		variable start_key_flank_v : std_logic;
		variable h_key_flank_v     : std_logic;
		variable m_key_flank_v     : std_logic;
		variable s_key_flank_v     : std_logic;
	begin
		if rising_edge(clk) then
			start_key_n_f <= start_key_n;
			h_key_n_f     <= h_key_n;
			m_key_n_f     <= m_key_n;
			s_key_n_f     <= s_key_n;

			if (start_key_n_f = '0' and start_key_n = '1') then
				start_key_flank_v := '1';
			else
				start_key_flank_v := '0';
			end if;

			if (h_key_n_f = '0' and h_key_n = '1') then
				h_key_flank_v := '1';
			else
				h_key_flank_v := '0';
			end if;

			if (m_key_n_f = '0' and m_key_n = '1') then
				m_key_flank_v := '1';
			else
				m_key_flank_v := '0';
			end if;

			if (s_key_n_f = '0' and s_key_n = '1') then
				s_key_flank_v := '1';
			else
				s_key_flank_v := '0';
			end if;
			if (func_sw = '1') then -- wach
				cnt_s         <= w_cnt_s;
				w_start_key_s <= start_key_flank_v;
				w_h_key_s     <= h_key_flank_v;
				w_m_key_s     <= m_key_flank_v;
				w_s_key_s     <= s_key_flank_v;
			else -- timer
				cnt_s         <= t_cnt_s;
				t_start_key_s <= start_key_flank_v;
				t_h_key_s     <= h_key_flank_v;
				t_m_key_s     <= m_key_flank_v;
				t_s_key_s     <= s_key_flank_v;
			end if;
			out_time_s <= seconds_to_time_array(cnt_s);
			
		end if;

	end process;

end architecture; -- arch