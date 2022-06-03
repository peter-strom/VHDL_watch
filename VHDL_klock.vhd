library IEEE;
library WORK;
use IEEE.std_logic_1164.all;
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



begin
    

   
--steg 1
-- skapa en räknare 
-- instansiera 3 gånger
--räknare 1 - sekunder upp till 60

--steg 2
--7-seg

--steg 3





end architecture ; -- arch
