library IEEE;
library WORK;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.VHDL_klock_pkg.all;

entity VHDL_klock is
  port (
    clk       : in std_logic;
    key_n     : in std_logic;
    reset_n   : in std_logic;
    hex       : out std_logic_vector(6 downto 0)
  ) ;
end entity ;

architecture behaviour of VHDL_klock is

signal ticks_s   : natural := 0;
signal seconds_s : natural := 0;

begin
    

process(clk) is
begin
	if rising_edge(clk) then
		if ticks_s = 50000000 then
			ticks_s <= 0;
		else
			ticks_s <= ticks_s + 1;
		end if;
	end if;
end process;
--steg 1
-- skapa en räknare 
-- instansiera 3 gånger
--räknare 1 - sekunder upp till 60

--steg 2
--7-seg

--steg 3





end architecture ; -- arch
