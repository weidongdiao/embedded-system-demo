----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:51:50 02/15/2016 
-- Design Name: 
-- Module Name:    counter - Behavioral 
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

entity counter is
    Port ( clk : in  STD_LOGIC;
           firstSignal : out  STD_LOGIC;
           SecondSignal : out  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (15 downto 0);
           address : out  STD_LOGIC_VECTOR (31 downto 0);
           data_out : out  STD_LOGIC_VECTOR (15 downto 0));
end counter;

architecture Behavioral of counter is

      signal counter: std_logic_vector (31 downto 0) := x"00000000";

begin

    counterP: process(clk)
	 begin
	     if (clk'event and clk = '1') then
		      counter <= counter + 1;
				end if;
	 end process;
	 
	 sendSignalAtp: Process(counter)
	 begin
	     if (counter = x"00000001") then
		      firstSignal <= '1';
				
				elsif (counter = x"00000002") then
				SecondSignal <= '1';
				
				end if;
	 end process;
	 
	 address <= counter;
end Behavioral;

