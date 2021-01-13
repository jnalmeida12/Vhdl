																 ----------------------------------------------------------------------------------
-- Company: Universidade Federal De Santa Maria
-- Engineer: Jonathan Homercher De Almeida
-- 
-- Create Date:    18:01:34 11/21/2020 
-- Design Name: 
-- Module Name:    StructuralLogic - Structural 
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

entity StructuralLogic is
	 generic(
        DATA_WIDTH       : integer := 17
    );
    Port ( 
			input : in  STD_LOGIC_VECTOR (16 downto 0);
         Mxctrl1  : in  STD_LOGIC;
         Mxctrl2  : in  STD_LOGIC;
         Mxrdy    : in  STD_LOGIC;
         inpt     : in  STD_LOGIC;
         rt       : in  STD_LOGIC;
         s_2      : in  STD_LOGIC;
         sqr      : in  STD_LOGIC;
         v1       : in  STD_LOGIC;
         Result   : out STD_LOGIC_VECTOR (16 downto 0);
         clk      : in  STD_LOGIC;
         rst      : in  STD_LOGIC;
		 negative : out STD_LOGIC);
end StructuralLogic;

architecture Structural of StructuralLogic is
    signal Sadd1, sadd2			                    : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
    signal Smx1, Smx2 , Smx3, Saddmx1		        : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
    signal Sript, Srrt, Srs_2, Srsqr                : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
    signal Ssub1                                    : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
begin


    -- Muxes dos registradores
    mcrt1A: Entity work.mux_2_1 
        generic map(
            DATA_WIDTH => DATA_WIDTH
        )
        port map(
	    A0	    =>  Sadd1,
	    A1	    =>  "00000000000000001",
            s0	    =>  Mxctrl1,
            Result =>  Smx1
        );
    mcrt1B: Entity work.mux_2_1 
        generic map(
            DATA_WIDTH => DATA_WIDTH
        )
        port map(
            A0	    =>  Sadd2,
	    A1	    =>  "00000000000000010",
            s0	    =>  Mxctrl1,
            result  =>  Smx2
        );
    mcrt1C: Entity work.mux_2_1 
        generic map(
            DATA_WIDTH => DATA_WIDTH
        )
        port map(
	        A0	    =>  Sadd2,
	        A1	    =>  "00000000000000100",
            s0	    =>  Mxctrl1,
            result  =>  Smx3
        );
    
    -- Registradores de Data
    reginpt: Entity work.gen_Reg 
        generic map(
            REG_WIDTH => DATA_WIDTH
        )
        port map(
            datain  =>  input,
            set     =>  '0',
            reset   =>  rst,
            enable  =>  inpt,
            clock   =>  clk,
            dataout =>  Sript
        );
    regroot: Entity work.gen_Reg
        generic map(
            REG_WIDTH => DATA_WIDTH
        )
        port map(
            datain   =>  Smx1,
            set     =>  '0', 
            reset   =>  rst,
            enable  =>  rt,
            clock   =>  clk,
            dataout =>  Srrt
        );
    regSum2: Entity work.gen_Reg
        generic map(
            REG_WIDTH => DATA_WIDTH
        )
        port map(
            datain   =>  Smx2,
            set     =>  '0', 
            reset   =>  rst,
            enable  =>  s_2,
            clock   =>  clk,
            dataout =>  Srs_2
        );
    regSqur: Entity work.gen_Reg 
        generic map(
            REG_WIDTH => DATA_WIDTH
        )
        port map(
            datain     =>  Smx3,
            set     =>  '0', 
            reset   =>  rst,
            enable  =>  sqr,
            clock   =>  clk,
            dataout =>  Srsqr
        );

    -- Somadores
    Adder1: Entity work.Adder 
        generic map(
            ADDER_WIDTH => DATA_WIDTH
        )
        port map(
            input0      => Srrt,
            input1      => "00000000000000001",
            carry_in    => '0',
            result      => Sadd1
        );
    Adder2: Entity work.Adder 
        generic map(
            ADDER_WIDTH => DATA_WIDTH
        )
        port map(
            input0      => Srs_2,
            input1      => Saddmx1,
            carry_in    => v1,
            result      => Sadd2
        );
    -- mux adder
    mxadd: Entity work.mux_2_1 
        generic map(
            DATA_WIDTH => DATA_WIDTH
        )
        port map(
	    A0	    =>  Srsqr,
	    A1	    =>  "00000000000000010",
            s0	    =>  Mxctrl2,
            Result  =>  Saddmx1
        );

    -- subtractor
    Sub1: Entity work.addsub 
        generic map(
            ADDSUB_WIDTH => DATA_WIDTH
        )
        port map(
            input0    =>    Sript,
	    input1    =>    Srsqr,
	    carry_in  =>    '0',
	    ctrl      =>    '1',
	    result    =>    Ssub1
        );
	negative <= ssub1(16);
    -- Result
    Result <= Srrt;
	

end Structural;