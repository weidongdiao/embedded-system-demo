----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:06:20 07/25/2016 
-- Design Name: 
-- Module Name:    Trigger_Generator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Trigger_Generator is
    Port ( clk : in  STD_LOGIC;
           Trig : out  STD_LOGIC);
end Trigger_Generator;

architecture Behavioral of Trigger_Generator is

component Counter is
	generic(n : POSITIVE := 10);
    Port ( clk : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           reset : in  STD_LOGIC; --Active Low
           counter_output : out  STD_LOGIC_VECTOR (n-1 downto 0));
end component;

signal resetCounter: STD_LOGIC;
signal outputCounter:  STD_LOGIC_VECTOR(23 downto 0);

begin
	trigger: Counter generic map(24) port map(clk,'1',resetCounter,outputCounter);
	process(clk)
		constant ms250 : STD_LOGIC_VECTOR(23 downto 0) :="101111101011110000100000"; --to generate 250ms pulse width, 1/250ms = 4Hz, fpga board is 50MHz and divide 4Hz and equal to 12500000
		constant ms250And100us : STD_LOGIC_VECTOR(23 downto 0) :="101111101100111110101000"; -- to generate 250ms+100us pulse width,...
	  begin	
			if(outputCounter > ms250 and outputCounter < ms250And100us) then
				Trig <= '1';
			   else
					Trig <= '0';
			end if;
			if(outputCounter = ms250And100us or outputCounter = "XXXXXXXXXXXXXXXXXXXXXXXX") then
				resetCounter <= '0';
				else
					resetCounter <= '1';
				end if;
		end process;

end Behavioral;

