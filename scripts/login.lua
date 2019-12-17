-- Login System
-- Written by Brainless243
-- Posted to The Tekkit Wiki on 10/24/2012

-- Edited by Marumaru352

os.pullEvent = os.pullEventRaw -- Prevents CTRL+T shortcut

term.clear() -- Clears the screen
term.setCursorPos(1, 1) -- This places the print position to the top of screen

username = {"CaptRanger", "tannertoby", "d"}  -- Here you need to define all usernames available
password = {"enterNow", "44dwarves", "cooldudes"}  -- Here you define what password each user has, remember to put user1's password in the first row and so on.

write("Username: ")
user = read()

write("Password: ")
pass = read('*') -- This prevents people from reading the password as you put it in

for i=1, #username do -- Starts a loop
 if user == username[i] and pass == password[i] then
   access = true
 end
end

if access == true then
print("Logging in...")
sleep(1)
print("Welcome "..user)
else
print("Incorrect username and password combination")
sleep(20)
--os.reboot()
end
