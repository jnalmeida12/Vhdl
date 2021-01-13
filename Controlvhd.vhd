----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:15:05 11/22/2020 
-- Design Name: 
-- Module Name:    Controlpath - Structural 
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

entity Controlpath is
    Port ( rst 		: in  STD_LOGIC;
           clk 		: in  STD_LOGIC;
           Mxctrl1 	: out  STD_LOGIC;
           Mxctrl2 	: out  STD_LOGIC;
           Mxrdy 	: out  STD_LOGIC;
           inpt 	: out  STD_LOGIC;
		   rt		: out  STD_LOGIC;
           s_2 		: out  STD_LOGIC;
           values 		: out  STD_LOGIC;
           res 		: out  STD_LOGIC;
           v1 		: out  STD_LOGIC;
           ready	: in   STD_LOGIC;
           negative 	: in   STD_LOGIC);
end Controlpath;

architecture Structural of Controlpath is
    type State is (S0, S1, S2, S3);
    signal currentState: State;
begin
	
    process(clk, rst, negative)
        begin

            if rst = '1' then
                currentState <= S0;
                
            elsif rising_edge(clk) then
            
                case currentState is
                    when S0 =>
			
                        if ready = '1' then
                            currentState <= S1;
                        else
                            currentState <= S0;
                        end if;
                    
                    when S1 =>
                        
                        currentState <= S2;

                    when S2 =>
                        
                        if negative = '0' then
                            currentState <= S1;
                        else
                            currentState <= S3;
                        end if;
                        
                    when S3 =>

                        if rst = '1' then 
                            currentState <= S0;
                        else
                            currentState <= S3;
                        end if;

                    when others =>
                        currentState <= S0;
                
                end case;
            end if;
        end process;
        
        Mxctrl1 <= '1' when currentState = S0 else '0'; 
        Mxctrl2 <= '1' when currentState = S0 or currentState = S2 else '0';
        Mxrdy   <= '1' when currentState = S0 or currentState = S2 else '0';
        inpt    <= '1' when currentState = S0 else '0';
	    rt      <= '1' when currentState = S0 or currentState = S2 else '0';
        s_2     <= '1' when currentState = S0 or currentState = S2 else '0';
        -- sqr     <= '1' when currentState = S0 or currentState = S1 else '0';
        values    <= '1' when currentState = S0 or currentState = S1 else '0';
        res     <= '1' when currentState = S3 else '0';
        v1      <= '1' when currentState = S2 else '0';
end Structural;