----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:27:51 07/25/2016 
-- Design Name: 
-- Module Name:    BCD_Converter - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCD_Converter is
    Port ( Distance_Input : in  STD_LOGIC_VECTOR (8 downto 0);
           hundreds : out  STD_LOGIC_VECTOR (3 downto 0);
           tens : out  STD_LOGIC_VECTOR (3 downto 0);
           unit : out  STD_LOGIC_VECTOR (3 downto 0));
end BCD_Converter;

architecture Behavioral of BCD_Converter is

begin

	process(Distance_Input)
		variable i: integer := 0;
		variable bcd: STD_LOGIC_VECTOR (20 downto 0);
	begin
		bcd:= (others =>'0');
		bcd(8 downto 0):=Distance_Input;
		
--Convert distance in binary
		for i in 0 to 8 loop
			--left shift one bit
			bcd(19 downto 0) := bcd(18 downto 0) & '0';
			--Check Phase
			if(i < 8 and bcd(12 downto 9)> "0100") then
				bcd(12 downto 9) := bcd(12 downto 9) + "0011";
				end if;
			if(i < 8 and bcd(16 downto 13)> "0100") then
				bcd(16 downto 13) := bcd(16 downto 13) + "0011";
				end if;
			if(i < 8 and bcd(20 downto 17)> "0100") then
				bcd(20 downto 17) := bcd(20 downto 17) + "0011";
				end if;
		  end loop;
		 hundreds <= bcd(20 downto 17);
		 tens <= bcd(16 downto 13);
		 unit <= bcd(12 downto 9);
	end process;
end Behavioral;

