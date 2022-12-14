library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity videoGen is
port(
      vgaclk     : in  std_logic;
       x         : in  std_logic_vector( 9 downto 0); -----to video DAC
       y         : in  std_logic_vector( 9 downto 0);
       r         : out std_logic_vector( 7 downto 0);         
       g         : out std_logic_vector( 7 downto 0);         
       b         : out std_logic_vector( 7 downto 0)
       );        
               
end entity;

architecture rtl of videoGen is
------------------------------------------------------------
-- chargenrom
------------------------------------------------------------
component chargenrom is
port(
       vgaclk    : in std_logic;
       ch        : in std_logic_vector(7 downto 0); -----to video DAC
       xoff      : in std_logic_vector(2 downto 0);
       yoff      : in std_logic_vector(2 downto 0);         
       pixell    : out std_logic);         
 
end component;
-----------------------------------------------------------------
-- rectgen
--------------------------------------------------------------
component rectgen is
port(
       x         : in std_logic_vector(9 downto 0);
       y         : in std_logic_vector(9 downto 0); 
       leftt     : in std_logic_vector(9 downto 0); -----to video DAC
       top       : in std_logic_vector(9 downto 0);
       rightt    : in std_logic_vector(9 downto 0);         
       bot       : in std_logic_vector(9 downto 0); 
       inrect    : out std_logic
       );
 
end component;

       ---vertical back porch
signal pixell        : std_logic;
signal inrect         : std_logic;

begin

------------------------------------------------------------
-- chargenrom
------------------------------------------------------------
 chargenrom1:chargenrom
port map(
       vgaclk    => vgaclk,
       ch        => y(3 downto 0) + x"41",
       xoff      => x(2 downto 0),
       yoff      => y(2 downto 0),         
       pixell    =>  pixell  
   );     
 
------------------------------------------------------------
-- rectgen
------------------------------------------------------------
 rectgen1 : rectgen
port map(
       x         => x,
       y         => y,
       leftt     => "00" & x"78",
       top       => "00" & x"96",
       rightt    => "00" & x"C8",      
       bot       => "00" & x"E6",
       inrect    => inrect
       );
process (vgaclk)begin
   if rising_edge(vgaclk) then
	
      if y(3)='1' then 
         r <= "0000000" & pixell;
         b <= (others=>'0');
      else
         r <=(others=>'0');
         b <= "0000000" & pixell;
      end if;
  
      if inrect='1' then 
         g <= "11111111";
      else
         g <=(others=>'0');
      end if;
   end if;
 end process;
 
end rtl;