----------------------------------------------------------------------------------
-- Company: USAFA/DFEC
-- Engineer: Spence
-- 
-- Create Date:    	10:33:47 07/07/2012 
-- Design Name:		Lab3
-- Module Name:    	Morefloors - Behavioral 
-- Description: 		Lab3
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

entity Morefloors is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           up_down : in  STD_LOGIC;
           floor : out  STD_LOGIC_VECTOR (3 downto 0);
			  digit : OUT std_logic_vector(3 downto 0)
			  );
end Morefloors;

architecture Behavioral of Morefloors is

--Below you create a new variable type! You also define what values that 
--variable type can take on. Now you can assign a signal as 
--"floor_state_type" the same way you'd assign a signal as std_logic 
type floor_state_type is (floor2, floor3, floor5, floor7, floor11, floor13, floor17, floor19);

--Here you create a variable "floor_state" that can take on the values
--defined above. Neat-o!
signal floor_state : floor_state_type;

begin
---------------------------------------------
--Below you will code your next-state process
---------------------------------------------

--This line will set up a process that is sensitive to the clock
floor_state_machine: process(clk)
begin
	--clk'event and clk='1' is VHDL-speak for a rising edge
	--if clk'event and clk='1' then
	if rising_edge(clk) then
		--reset is active high and will return the elevator to floor1
		--Question: is reset synchronous or asynchronous?
		if reset='1' then
			floor_state <= floor2;
		else
			case floor_state is
				when floor2 =>
					
					if (up_down='1' and stop='0') then 
						floor_state <= floor3;
					else
						floor_state <= floor2;
					end if;
				when floor3 =>	
					if (up_down='1' and stop='0') then 
						floor_state <= floor5; 			
					
					elsif (up_down='0' and stop='0') then 
						floor_state <= floor2;
					
					else
						floor_state <= floor3;
					end if;
				

				when floor5 =>
					if (up_down='0' and stop='0') then 
						floor_state <= floor3;
					elsif (up_down='1' and stop='0') then 
						floor_state <= floor7;	
					else
						floor_state <= floor5;	
					end if;
				when floor7 =>
					if (up_down='0' and stop='0') then 
						floor_state <= floor5;	
					elsif (up_down='1' and stop='0') then 
						floor_state <= floor11;	
					else 
						floor_state <= floor7;	
					end if;
				when floor11 =>
					if (up_down='0' and stop='0') then 
						floor_state <= floor7;
					elsif (up_down='1' and stop='0') then 
						floor_state <= floor13;	
					else
						floor_state <= floor11;	
					end if;
				
				when floor13 =>
					if (up_down='0' and stop='0') then 
						floor_state <= floor11;
               elsif (up_down='1' and stop='0') then 
						floor_state <= floor17;							
					else 
						floor_state <= floor13;	
					end if;
					
				when floor17 =>
					if (up_down='0' and stop='0') then 
						floor_state <= floor13;
					elsif (up_down='1' and stop='0') then 
						floor_state <= floor19;	
					else
						floor_state <= floor17;	
					end if;
				
				when floor19 =>
					if (up_down='0' and stop='0') then 
						floor_state <= floor17;	
					else 
						floor_state <= floor19;	
					end if;
				--This line accounts for phantom states
				when others =>
					floor_state <= floor2;
			end case;
		end if;
	end if;
end process;

-- Here you define your output logic. Finish the statements below
floor <= "0010" when (floor_state = floor2 ) else
			"0011" when (floor_state = floor3 ) else
			"0101" when (floor_state = floor5 ) else
			"0111" when (floor_state = floor7 ) else
			"0001" when (floor_state = floor11 ) else
			"0011" when (floor_state = floor13 ) else
			"0111" when (floor_state = floor17 ) else
			"1001" when (floor_state = floor19 ) else
			"0010";
digit <= "0000"when (floor_state = floor2 ) else
			"0000" when (floor_state = floor3 ) else
			"0000" when (floor_state = floor5 ) else
			"0000" when (floor_state = floor7 ) else
			"0001" when (floor_state = floor11 ) else
			"0001" when (floor_state = floor13 ) else
			"0001" when (floor_state = floor17 ) else
			"0001" when (floor_state = floor19 ) else
			"0000";
end Behavioral;

