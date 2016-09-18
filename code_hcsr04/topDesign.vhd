----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:13:52 07/25/2016 
-- Design Name: 
-- Module Name:    topDesign - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity topDesign is
    Port ( pulse_pin : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Trigger_pin : out  STD_LOGIC;
           topSelectDispA : out  STD_LOGIC;
           topSelectDispB : out  STD_LOGIC;
           topSelectDispC : out  STD_LOGIC;
           topSelectDispD : out  STD_LOGIC;
           topSegA : out  STD_LOGIC;
           topSegB : out  STD_LOGIC;
           topSegC : out  STD_LOGIC;
           topSegD : out  STD_LOGIC;
           topSegE : out  STD_LOGIC;
           topSegF : out  STD_LOGIC;
           topSegG : out  STD_LOGIC);
end topDesign;

architecture Behavioral of topDesign is

component Range_Sensor is
    Port ( hcsrClk : in  STD_LOGIC;
           pulse : in  STD_LOGIC;
           trigOut : out  STD_LOGIC;
           meters : out  STD_LOGIC_VECTOR (3 downto 0);
           decimeters : out  STD_LOGIC_VECTOR (3 downto 0);
           centimeters : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component segmentDriver is
    Port ( clk : in  STD_LOGIC;
			  display_A : in  STD_LOGIC_VECTOR (3 downto 0);
           display_B : in  STD_LOGIC_VECTOR (3 downto 0);
           display_C : in  STD_LOGIC_VECTOR (3 downto 0);
           display_D : in  STD_LOGIC_VECTOR (3 downto 0);
           segA : out  STD_LOGIC;
           segB : out  STD_LOGIC;
           segC : out  STD_LOGIC;
           segD : out  STD_LOGIC;
           segE : out  STD_LOGIC;
           segF : out  STD_LOGIC;
           segG : out  STD_LOGIC;
           select_Display_A : out  STD_LOGIC;
           select_Display_B : out  STD_LOGIC;
           select_Display_C : out  STD_LOGIC;
           select_Display_D : out  STD_LOGIC);
end component;

signal Ai :STD_LOGIC_VECTOR (3 downto 0);
signal Bi :STD_LOGIC_VECTOR (3 downto 0);
signal Ci :STD_LOGIC_VECTOR (3 downto 0);
signal Di :STD_LOGIC_VECTOR (3 downto 0);

signal sensor_meters : STD_LOGIC_VECTOR (3 downto 0);
signal sensor_decimeters : STD_LOGIC_VECTOR (3 downto 0);
signal sensor_centimeters : STD_LOGIC_VECTOR (3 downto 0);


begin
uut2: segmentDriver PORT MAP(
	display_A => Ai,
	display_B => Bi,
	display_C => Ci,
	display_D => Di,
	segA => topSegA,
	segB => topSegB,
	segC => topSegC,
	segD => topSegD,
	segE => topSegE,
	segF => topSegF,
	segG => topSegG,
	select_Display_A => topSelectDispA,
	select_Display_B => topSelectDispB,
	select_Display_C => topSelectDispC,
	select_Display_D => topSelectDispD,
	clk => clk
);

uut3: range_sensor PORT MAP(
	hcsrClk => clk,
	trigOut => Trigger_pin,
	pulse => pulse_pin,
	meters => sensor_meters,
	decimeters => sensor_decimeters,
	centimeters => sensor_centimeters
);

		Ai <= sensor_centimeters;
		Bi <= sensor_decimeters;
		Ci <= sensor_meters;
		Di <= "0000";

end Behavioral;

