--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:58:50 04/07/2017
-- Design Name:   
-- Module Name:   C:/Xilinx/lab5ff23desk07/test2.vhd
-- Project Name:  lab5ff23desk07
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: lab5ff23desk07
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test2 IS
END test2;
 
ARCHITECTURE behavior OF test2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT lab5ff23desk07
    PORT(
         FP : IN  std_logic_vector(5 downto 0);
         My_clk : IN  std_logic;
         SSEG_CA : OUT  std_logic_vector(7 downto 0);
         SSEG_AN : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal FP : std_logic_vector(5 downto 0) := (others => '0');
   signal My_clk : std_logic := '0';

 	--Outputs
   signal SSEG_CA : std_logic_vector(7 downto 0);
   signal SSEG_AN : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant My_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: lab5ff23desk07 PORT MAP (
          FP => FP,
          My_clk => My_clk,
          SSEG_CA => SSEG_CA,
          SSEG_AN => SSEG_AN
        );

   -- Clock process definitions
   My_clk_process :process
   begin
		My_clk <= '0';
		wait for My_clk_period/2;
		My_clk <= '1';
		wait for My_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	
	fp<="010011";
	wait for 30ms;
	fp<="011111";
      -- hold reset state for 100 ns.
      --wait for 100 ns;	

    --  wait for My_clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
