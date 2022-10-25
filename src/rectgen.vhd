library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity rectgen is
port(
       x         : in std_logic_vector(9 downto 0);
       y         : in std_logic_vector(9 downto 0); 
       leftt     : in std_logic_vector(9 downto 0); -----to video DAC
       top       : in std_logic_vector(9 downto 0);
		 rightt    : in std_logic_vector(9 downto 0);         
       bot       : in std_logic_vector(9 downto 0); 
       inrect    : out std_logic
       );
 
end entity;

architecture rtl of rectgen is
signal LR : std_logic_vector(9 downto 0);
signal TB : std_logic_vector(9 downto 0);
begin
	inrect <=  '1' when ((x >= leftt) and ( x < rightt) and (y >= top ) and ( y < bot)) else '0';
	
end rtl;