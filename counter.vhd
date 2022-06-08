library IEEE;
library WORK;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use WORK.VHDL_klock_pkg.all;
entity counter is
	generic (
		CNT_1S_G : natural := FREQUENCY_1HZ;
		CNT_LIM_G : natural := 86399 -- 3600 * 24 
	);
	port (
		clk : in std_logic;
		rst_n : in std_logic;
		start_key_n : in std_logic;
		h_key_n : in std_logic;
		m_key_n : in std_logic;
		s_key_n : in std_logic;
		out_time : out time_array_t
	);
end entity;

architecture behaviour of counter is
signal cnt_s : natural := 0;

begin

    process (clk, rst_n) is
    begin
		if (rst_n = '0') then
			cnt_s <= 0;
			
		
		elsif (rising_edge(clk)) then
			
				if (cnt_s = CNT_LIM_G) then
					cnt_s <= 0;
				else
					cnt_s <= cnt_s + 1;
				end if;
			
		end if;
    end process;
	 
	out_time <= seconds_to_time_array(cnt_s);
end architecture;

