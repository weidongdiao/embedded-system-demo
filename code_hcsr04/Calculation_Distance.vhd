----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:48:46 07/25/2016 
-- Design Name: 
-- Module Name:    Calculation_Distance - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Calculation_Distance is
    Port ( clk : in  STD_LOGIC;
           Calculation_Reset : in  STD_LOGIC;
           pulse : in  STD_LOGIC;
           distance : out  STD_LOGIC_VECTOR (8 downto 0));
end Calculation_Distance;

architecture Behavioral of Calculation_Distance is

component Counter is
	generic(n : POSITIVE := 10);
    Port ( clk : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           reset : in  STD_LOGIC; --Active Low
           counter_output : out  STD_LOGIC_VECTOR (n-1 downto 0));
end component;

signal pulse_width : STD_LOGIC_VECTOR (21 downto 0);

begin
CounterPulse : Counter generic map(22) port map(clk,pulse,not Calculation_Reset,pulse_width);

Calculation_Distance : process(pulse)
				variable Result : integer;
				variable multiplier : STD_LOGIC_VECTOR(23 downto 0);
					begin
						if(pulse = '0') then 
							multiplier := pulse_width * "11";
							Result := to_integer(unsigned(multiplier(23 downto 13)));
							if(Result > 458) then
								distance <= "111111111";
								else 
									distance <= STD_LOGIC_VECTOR(to_unsigned(Result,9));
								end if;
							end if;
		end process;
				
end Behavioral;

