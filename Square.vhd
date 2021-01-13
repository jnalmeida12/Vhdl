----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:25:58 11/22/2020 
-- Design Name: 
-- Module Name:    Square - Behavioral 
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

entity Square is
    Port ( clk : in  STD_LOGIC;
           rst_n : in  STD_LOGIC;
	   	   ready: in STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (16 downto 0);
           Result : out  STD_LOGIC_VECTOR (16 downto 0));
end ;

architecture Structural of Square is
	signal Sclk, Srst, Srdy			: STD_LOGIC;
	Signal SMxctrl1, SMxctrl2		: STD_LOGIC;
	Signal SMxrdy				: STD_LOGIC;
	signal Sinpt, Srt, Ss_2, Ssqr		: STD_LOGIC;
	signal Sres, Sv1			: STD_LOGIC;
	signal SNegative			: STD_LOGIC;
	signal Sresult, Sinput			: STD_LOGIC_VECTOR(16 downto 0);
begin
	
	Sinput <= input;
	
	Control : entity work.Controlpath
		port map( 
			rst 		=> rst_n,
    		clk 		=> clk,
     		Mxctrl1 	=> SMxctrl1,
     		Mxctrl2 	=> SMxctrl2,
        	Mxrdy 		=> SMxrdy,
         	inpt 		=> Sinpt,
			rt			=> Srt,
		    s_2 		=> Ss_2,
		    values 		=> Ssqr,
		    res 		=> Sres,
			v1 			=> Sv1,
			ready		=> ready,
			negative	=> Snegative
		);
	Structural: entity work.StructuralLogic
		port map(
			input 	 	=> Sinput,
			Mxctrl1  	=> SMxctrl1,
			Mxctrl2  	=> SMxctrl2,
			Mxrdy    	=> SMxrdy,
			inpt     	=> Sinpt,
			rt       	=> Srt,
			s_2      	=> Ss_2,
			sqr      	=> Ssqr,
			v1       	=> Sv1,
			Result   	=> Sresult,
			clk      	=> clk,
			rst      	=> rst_n,
			negative 	=> Snegative
		);
		
	Result <= Sresult;
end Structural;

