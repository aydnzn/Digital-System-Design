--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:18:11 04/07/2017
-- Design Name:   
-- Module Name:   C:/Xilinx/ee240lab4ff23desk07/lab4test.vhd
-- Project Name:  ee240lab4ff23desk07
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: lab4desk07ff23
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
 
ENTITY lab4test IS
END lab4test;
 
ARCHITECTURE behavior OF lab4test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT lab4desk07ff23
    PORT(
         wclock : IN  std_logic;
         clr : IN  std_logic;
         q : OUT  std_logic_vector(3 downto 0);
         co : OUT  std_logic;
         en : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal wclock : std_logic := '0';
   signal clr : std_logic := '0';
   signal en : std_logic := '0';

 	--Outputs
   signal q : std_logic_vector(3 downto 0);
   signal co : std_logic;

   -- Clock period definitions
 --  constant wclock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: lab4desk07ff23 PORT MAP (
          wclock => wclock,
          clr => clr,
          q => q,
          co => co,
          en => en
        );

   -- Clock process definitions
  -- wclock_process :process
  -- begin
	--	wclock <= '0';
	--	wait for wclock_period/2;
	--	--wclock <= '1';
	--	wait for wclock_period/2;
  -- end process;
 

      stim_proc: process

   begin		

    	EN <='1';

		CLR <= '0',

		'1' after 800 ns,

		'0' after 1000 ns;		

			wclock <= '0',

		'1' after 150 ns,

		'0' after 200 ns,

		'1' after 250 ns,

		'0' after 300 ns,

		'1' after 350 ns,

		'0' after 400 ns,

		'1' after 450 ns,

		'0' after 500 ns,

		'1' after 550 ns,

		'0' after 600 ns,

		'1' after 650 ns,

		'0' after 700 ns;




      wait;

   end process;
     
END;
