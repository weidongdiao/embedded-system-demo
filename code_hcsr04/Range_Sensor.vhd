----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:43:50 07/25/2016 
-- Design Name: 
-- Module Name:    Range_Sensor - Behavioral 
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

entity Range_Sensor is
    Port ( hcsrClk : in  STD_LOGIC;
           pulse : in  STD_LOGIC;
           trigOut : out  STD_LOGIC;
           meters : out  STD_LOGIC_VECTOR (3 downto 0);
           decimeters : out  STD_LOGIC_VECTOR (3 downto 0);
           centimeters : out  STD_LOGIC_VECTOR (3 downto 0));
end Range_Sensor;

architecture Behavioral of Range_Sensor is
component Calculation_Distance is
    Port ( clk : in  STD_LOGIC;
           Calculation_Reset : in  STD_LOGIC;
           pulse : in  STD_LOGIC;
           distance : out  STD_LOGIC_VECTOR (8 downto 0));
end component;

component Trigger_Generator is
    Port ( clk : in  STD_LOGIC;
           Trig : out  STD_LOGIC);
end component;

component BCD_Converter is
    Port ( Distance_Input : in  STD_LOGIC_VECTOR (8 downto 0);
           hundreds : out  STD_LOGIC_VECTOR (3 downto 0);
           tens : out  STD_LOGIC_VECTOR (3 downto 0);
           unit : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

signal distanceOut : STD_LOGIC_VECTOR (8 downto 0);
signal triggerOut : STD_LOGIC;

begin

trigg_gen : Trigger_Generator port map(hcsrClk,triggerOut);
pulseWidth: Calculation_Distance port map(hcsrClk,triggerOut,pulse,distanceOut);
bcdConverter: BCD_Converter port map(distanceOut,meters,decimeters,centimeters);

trigOut <= triggerOut;


end Behavioral;

