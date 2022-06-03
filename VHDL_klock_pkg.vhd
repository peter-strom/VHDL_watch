library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


package VHDL_klock_pkg is

    type time_array_t is array (0 to 5) of std_logic_vector (3 downto 0);
    function seconds_to_time_array(seconds : in natural) return time_array_t;
		component counter is
        generic (
            CNT_1S_G : natural := 50000000;
            CNT_LIM_G : natural := 86400 -- 3600 * 24 
        );
        port (
            clk : in std_logic;
            rst_n : in std_logic;
            key_n : in std_logic;
            out_time : out time_array_t
        );
    end component;
    

end package;

package body VHDL_klock_pkg is
	
		

    function seconds_to_time_array(seconds : in natural) return time_array_t is
        variable hh : natural;
        variable mm : natural;
        variable ss : natural;
		variable h_H : natural;
        variable h_L : natural;
        variable m_H : natural;
        variable m_L : natural;
        variable s_H : natural;
        variable s_L : natural;

    begin
        hh := seconds / 3600;
        mm := (seconds mod 3600) / 60;
        ss := (seconds mod 3600) mod 60;

        h_H := hh / 10;
        h_L := hh - h_H;
        m_H := mm / 10;
        m_L := mm - m_H;
        s_H := ss / 10;
        s_L := ss - s_H;

        return (std_logic_vector(to_unsigned(h_H, 4)),
					std_logic_vector(to_unsigned(h_L, 4)),
					std_logic_vector(to_unsigned(m_H, 4)),
					std_logic_vector(to_unsigned(m_L, 4)),
					std_logic_vector(to_unsigned(s_H, 4)),
					std_logic_vector(to_unsigned(s_L, 4))
					);
    end function;
end package body;