library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
entity counter is
    port
    (
        clk  : in std_logic;
      rst_n  : in std_logic;
        ce   : in std_logic;
      cnt  : out std_logic_vector(3 downto 0)
    );
end entity;

architecture behaviour of counter is
signal cnt_s : std_logic_vector(3 downto 0);

begin

    process (clk, rst_n) is
    begin
		if (rst_n = '0') then
			cnt_s <= (others => '0');
		
		elsif (rising_edge(clk)) then
			if (ce = '1') then
				if cnt_s = 2 then
					cnt_s <= (others => '0');
				else
					cnt_s <= cnt_s + 1;
				end if;
			end if;
		end if;
    end process;
	 
	 cnt <= cnt_s;
end architecture;