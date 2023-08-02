--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:24:40 05/05/2017
-- Design Name:   
-- Module Name:   C:/proj/lab7_1/test2.vhd
-- Project Name:  lab7_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ee240_vgadriver
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
 
    COMPONENT ee240_vgadriver
    PORT(
         nreset : IN  std_logic;
         board_clk : IN  std_logic;
         vsync : OUT  std_logic;
         hsync : OUT  std_logic;
         red : OUT  std_logic_vector(2 downto 0);
         green : OUT  std_logic_vector(2 downto 0);
         blue : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal nreset : std_logic := '0';
   signal board_clk : std_logic := '0';

 	--Outputs
   signal vsync : std_logic;
   signal hsync : std_logic;
   signal red : std_logic_vector(2 downto 0);
   signal green : std_logic_vector(2 downto 0);
   signal blue : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant board_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ee240_vgadriver PORT MAP (
          nreset => nreset,
          board_clk => board_clk,
          vsync => vsync,
          hsync => hsync,
          red => red,
          green => green,

          blue => blue
        );

   -- Clock process definitions
   board_clk_process :process
   begin
		board_clk <= '0';
		wait for board_clk_period/2;
		board_clk <= '1';
		wait for board_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
    
			nreset <= '0';
		  wait for 30 us;
		  nreset <= '1';
		  wait for 5 us;
		  nreset <= '0';
		  wait for 30 us;
		  nreset <= '1';
		    wait for 5 us;
		  nreset <= '0';
		    wait for 30 us;
		  nreset <= '1';

      wait;
   end process;

END;
