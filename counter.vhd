library IEEE;
library WORK;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use WORK.VHDL_klock_pkg.all;
entity counter is
	generic (
		CNT_1S_G    : natural := 50000000;
		CNT_LIM_G   : natural := 86399;
		PAUSED_G    : std_logic := '0';
		COUNT_UP_G  : std_logic := '1'
	);
	port (
		clk         : in std_logic;
		rst_n       : in std_logic;
		start_key   : in std_logic;
		h_key       : in std_logic;
		m_key       : in std_logic;
		s_key       : in std_logic;
		cnt         : out natural

	);
end entity;

architecture behaviour of counter is
	signal cnt_s    : natural := 0;
	signal tick_s   : natural := 0;
	signal paused   : std_logic := PAUSED_G;
begin

	process (clk, rst_n) is
	begin
		if (rst_n = '0') then
			cnt_s <= 0;
			paused <= PAUSED_G;
		elsif (rising_edge(clk)) then
			if (start_key = '1') then
				paused <= not paused;
			end if;
			if (paused = '0') then
				tick_s <= tick_s + 1;
			end if;
			if (h_key = '1') then
				cnt_s <= cnt_s + 3600;
			end if;
			if (m_key = '1') then
				cnt_s <= cnt_s + 60;
			end if;
			if (s_key = '1') then
				cnt_s <= cnt_s + 1;
			end if;
			if (tick_s = CNT_1S_G) then
				tick_s <= 0;
				if (COUNT_UP_G = '1') then
					cnt_s <= cnt_s + 1;
				else
					cnt_s <= cnt_s - 1;
				end if;
			end if;
			if (cnt_s >= CNT_LIM_G) then
				cnt_s <= 0;
			end if;

		end if;
	end process;

	cnt <= cnt_s;
end architecture;