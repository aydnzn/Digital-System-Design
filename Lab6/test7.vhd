--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:01:53 04/13/2017
-- Design Name:   
-- Module Name:   C:/proj/ee240_bcdcounter/test7.vhd
-- Project Name:  ee240_bcdcounter
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ee240_bcdcounter
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
 
ENTITY test7 IS
END test7;
 
ARCHITECTURE behavior OF test7 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ee240_bcdcounter
    PORT(
         board_clk : IN  std_logic;
         upcount : IN  std_logic;
         downcount : IN  std_logic;
         pload : IN  std_logic;
         pdata : IN  std_logic_vector(7 downto 0);
         SSEG_CA : OUT  std_logic_vector(7 downto 0);
         SSEG_AN : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal board_clk : std_logic := '0';
   signal upcount : std_logic := '0';
   signal downcount : std_logic := '0';
   signal pload : std_logic := '0';
   signal pdata : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal SSEG_CA : std_logic_vector(7 downto 0);
   signal SSEG_AN : std_logic_vector(3 downto 0);
	

   -- Clock period definitions
   constant board_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ee240_bcdcounter PORT MAP (
          board_clk => board_clk,
          upcount => upcount,
          downcount => downcount,
          pload => pload,
          pdata => pdata,
          SSEG_CA => SSEG_CA,
          SSEG_AN => SSEG_AN
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
    	stimuli: process
   begin
		
	
		
		pload <= '0',
		'1' after 20 ms,
		'0' after 70 ms,
		'1' after 340 ms,
			'0' after 390 ms,
			'1' after 1600 ms,
			'0' after 1650 ms;
		
		
		
		
		
		pdata <= "00000010",
		"10000011" after 310 ms,
		"10011001" after 1550 ms;
			
		upcount <= '0',
		'1' after 400 ms,
		'0' after 500 ms,
		'1' after 1200 ms,
		'0' after 1300 ms,
		'1' after 1400 ms,
		'0' after 1500 ms,
		'1' after 1700 ms,
		'0' after 1780 ms,
		'1' after 1860 ms,
		'0' after 1950 ms;
		
		downcount <= '0',
		'1' after 90 ms,
		'0' after 150 ms,
		'1' after 230 ms,
		'0' after 310 ms,
		'1' after 600 ms,
		'0' after 700 ms,
		'1' after 800 ms,
		'0' after 900 ms,
		'1' after 1000 ms,
		'0' after 1100 ms,
		'1' after 2050 ms,
		'0' after 2150 ms;
		
		
		
		
        wait;
	end process;
END;