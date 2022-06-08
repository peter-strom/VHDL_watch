library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

package VHDL_klock_pkg is
    type seven_seg_array_t is array (0 to 5) of std_logic_vector (6 downto 0);
    type time_array_t is array (0 to 5) of std_logic_vector (3 downto 0);
    
	impure function set_sim_comment(sim_comment : string) return string;
    function seconds_to_time_array(seconds : in natural) return time_array_t;

    constant FREQUENCY_1HZ   : natural := 50000000;
    constant FREQUENCY_2HZ   : natural := 25000000;
    constant FREQUENCY_4HZ   : natural := 12500000;
    constant FREQUENCY_8HZ   : natural := 6250000;
    constant FREQUENCY_16HZ  : natural := 3125000;
    constant FREQUENCY_32HZ  : natural := 1562500;
    constant FREQUENCY_64HZ  : natural := 781250;
    constant FREQUENCY_128HZ : natural := 6250000;
    constant FREQUENCY_TEST  : natural := 1;

    constant COMMENT_LENGTH  : natural := 15;


    component counter is
        generic (
            
            CNT_1S_G    : natural   := 50000000;
            CNT_LIM_G   : natural   := 86399; -- 3600 * 24
            PAUSED_G    : std_logic := '0';
            COUNT_UP_G  : std_logic := '1'
        );
        port (
            clk         : in std_logic;
            rst_n       : in std_logic;
            start_key_n : in std_logic;
            h_key_n     : in std_logic;
            m_key_n     : in std_logic;
            s_key_n     : in std_logic;
            cnt         : out natural
        );
    end component;
    
    component seven_seg is
        port
        (
            n_in        : in  std_logic_vector(3 downto 0);
            X	        : out std_logic_vector(6 downto 0)
        );
    end component;

end package;
    
package body VHDL_klock_pkg is
	
	impure function set_sim_comment(sim_comment : string) return string is
        variable retval : string(1 to COMMENT_LENGTH);
        begin
            write( std.textio.output, sim_comment & LF);
            if sim_comment'length < COMMENT_LENGTH then
                for i in sim_comment'length to COMMENT_LENGTH loop
                    retval(i) := ' ';
                end loop;
                retval(1 to sim_comment'length) := sim_comment; 
            else
                retval := sim_comment(1 to COMMENT_LENGTH);
            end if;
            return retval;
    end function;	

    function seconds_to_time_array(seconds : in natural) return time_array_t is
        variable hh  : natural range 0 to 23;
        variable mm  : natural range 0 to 59;
        variable ss  : natural range 0 to 59;
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
        h_L := hh - h_H*10;
        m_H := mm / 10;
        m_L := mm - m_H*10;
        s_H := ss / 10;
        s_L := ss - s_H*10;

        return (std_logic_vector(to_unsigned(h_H, 4)),
				std_logic_vector(to_unsigned(h_L, 4)),
				std_logic_vector(to_unsigned(m_H, 4)),
				std_logic_vector(to_unsigned(m_L, 4)),
				std_logic_vector(to_unsigned(s_H, 4)),
				std_logic_vector(to_unsigned(s_L, 4))
				);
    end function;
end package body;