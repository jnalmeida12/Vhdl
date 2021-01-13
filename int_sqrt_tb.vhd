

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_signed.all;
 
 
ENTITY int_sqrt_tb IS
END int_sqrt_tb;
 
ARCHITECTURE behavior OF int_sqrt_tb IS 
 
    COMPONENT int_sqrt
    PORT(
         clk     : IN  std_logic;
         rst     : IN  std_logic;
         input   : IN  std_logic_vector(16 downto 0);
         result  : OUT  std_logic_vector(16 downto 0);
         ready   : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   --signal input : std_logic_vector(16 downto 0) := "00011001100110011";
	 signal input : std_logic_vector(16 downto 0) := "01111111111111111";
	 --signal input : std_logic_vector(16 downto 0) := "00000000000001001";

 	--Outputs
   signal result : std_logic_vector(16 downto 0);
   signal ready : std_logic;

   -- clk period definitions
   constant clock_period : time := 10 ns;
	
	signal count : std_logic_vector(7 downto 0) := "00000000";
 
BEGIN

   rst <= '1', '0' after 15 ns;
   clk <= not clk after 10 ns;
   ready <= '0','1' after 35 ns, '0' after  55 ns;

   uut: entity work.Square PORT MAP (
          clk => clk,
          rst_n => rst,
          input => input,
          result => result,
          ready => ready
        );

   CYCLE_COUNT: process(clk, rst)
   begin
    
       if rst = '1' then
		 
		     count <= "00000000";
               
       elsif rising_edge(clk) then
		 
		     if ready = '0' then
			  
			     count <= count + "00000001";
				  
		     end if; 
		 
		 end if;
		 
	end process;

END;
