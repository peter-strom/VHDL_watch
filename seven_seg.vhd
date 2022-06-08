library IEEE;
use IEEE.std_logic_1164.all;

entity seven_seg is
	port
	(
		n_in : in  std_logic_vector(3 downto 0);
		X    : out std_logic_vector(6 downto 0)
	);
end entity;

architecture rtl of seven_seg is
begin
	X(6) <= (not n_in(3) and not n_in(2) and not n_in(1)) or
			  (not n_in(3) and n_in(2) and n_in(1) and n_in(0));
	X(5) <= (not n_in(3) and not n_in(2) and n_in(1)) or
			  (not n_in(3) and not n_in(2) and n_in(0)) or
			  (not n_in(3) and n_in(1) and n_in(0)) or
			  (not n_in(2) and n_in(1) and not n_in(0)) or
			  (n_in(3) and n_in(2) and not n_in(1));
	X(4) <= (not n_in(3) and n_in(0)) or
			  (not n_in(3) and n_in(2) and not n_in(1)) or
			  (not n_in(2) and not n_in(1) and n_in(0));
	X(3) <= (not n_in(3) and not n_in(2) and not n_in(1) and n_in(0)) or
			  (not n_in(3) and n_in(2) and not n_in(1) and not n_in(0)) or
			  (n_in(2) and n_in(1) and n_in(0));
	X(2) <= (not n_in(3) and not n_in(2) and n_in(1) and not n_in(0)) or
			  (n_in(3) and n_in(2) and not n_in(0)) or
			  (n_in(3) and n_in(2) and n_in(1));
	X(1) <= (not n_in(3) and n_in(2) and not n_in(1) and n_in(0)) or
			  (n_in(3) and n_in(2) and not n_in(0)) or
			  (n_in(2) and n_in(1) and not n_in(0)) or
			  (n_in(3) and n_in(1));
	X(0) <= (not n_in(3) and not n_in(2) and not n_in(1) and n_in(0)) or
			  (n_in(2) and not n_in(1) and not n_in(0)) or
			  (n_in(3) and n_in(2) and not n_in(1)) or
			  (n_in(3) and not n_in(2) and n_in(1));   
end architecture;