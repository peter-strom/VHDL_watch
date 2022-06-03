library IEEE;
use IEEE.std_logic_1164.all;

entity seven_seg is
	port
	(
		A, B, C, D : in  std_logic;
		X			  : out std_logic_vector(6 downto 0)
	);
end entity;

architecture rtl of seven_seg is
begin
	X(6) <= (not A and not B and not C) or
			  (not A and B and C and D);
	X(5) <= (not A and not B and C) or
			  (not A and not B and D) or
			  (not A and C and D) or
			  (not B and C and not D) or
			  (A and B and not C);
	X(4) <= (not A and D) or
			  (not A and B and not C) or
			  (not B and not C and D);
	X(3) <= (not A and not B and not C and D) or
			  (not A and B and not C and not D) or
			  (B and C and D);
	X(2) <= (not A and not B and C and not D) or
			  (A and B and not D) or
			  (A and B and C);
	X(1) <= (not A and B and not C and D) or
			  (A and B and not D) or
			  (B and C and not D) or
			  (A and C);
	X(0) <= (not A and not B and not C and D) or
			  (B and not C and not D) or
			  (A and B and not C) or
			  (A and not B and C);   
end architecture;