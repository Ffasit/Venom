database = dofile("./library/redis.lua").connect("127.0.0.1", 6379)
https = require ("ssl.https") 
serpent = dofile("./library/serpent.lua") 
json = dofile("./library/JSON.lua") 
JSON  = dofile("./library/dkjson.lua")
URL = require('socket.url')  
http = require("socket.http")
Server_Done = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_Write = function() 
local Create_Info = function(Token,Sudo,user)  
local Write_Info_Sudo = io.open("Info.lua", 'w')
Write_Info_Sudo:write([[

token = "]]..Token..[["
SUDO = "]]..Sudo..[["
UserName = "]]..user..[["
botUserName = "]]..UserNamebot..[["

]])
Write_Info_Sudo:close()
end  
if not database:get(Server_Done.."Token_Write") then
print('\27[0;31m\n ارسل لي توكن البوت الان ↓ :\na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n\27')
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\27[0;31m┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n التوكن غير صحيح تاكد منه ثم ارسله')
else
local json = JSON.decode(url)
io.write('\27[0;31m تم حفظ التوكن بنجاح \na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n27[0;39;49m')
database:set(Server_Done..":token_username",json.result.username)
database:set(Server_Done..":token",token)
end 
else
io.write('\27[0;35m┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n لم يتم حفظ التوكن ارسل لي التوكن الان')
end 
os.execute('lua install.lua')
end 
end
if not database:get(Server_Done.."UserSudo_Write") then
print('\27[0;35m\n ارسل لي ايدي المطور الاساسي ↓ :\na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n\27[0;33;49m')
local Id = io.read():gsub(' ','') 
if tostring(Id):match('%d+') then
io.write('\27[1;35m تم حفظ ايدي المطور الاساسي \na┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n27[0;39;49m')
database:set(Server_Done.."UserSudo_Write",Id)
else
io.write('\27[0;31m┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n لم يتم حفظ ايدي المطور الاساسي ارسله مره اخره')
end
os.execute('lua install.lua')
end 
if not database:get(Server_Done.."User_Write") then
print('\27[1;31m ↓ ارسل معرف المطور الاساسي :\n SEND ID FOR SIDO : \27[0;39;49m')
local User = io.read():gsub('@','') 
if User ~= '' then
io.write('\n\27[1;34m تم حفظ معرف المطور :\n\27[0;39;49m')
database:set(Server_Done.."User_Write",User)
else
io.write('\n\27[1;34m لم يتم حفظ معرف المطور :')
end
os.execute('lua install.lua')
end
local function Files_Info_Get()
Create_Info(database:get(Server_Done.."Token_Write"),database:get(Server_Done.."UserSudo_Write"),database:get(Server_Done.."User_Write"),database:get(Server_Done..":token_username")) 
local RunBot = io.open("TELAND", 'w')
RunBot:write([[
#!/usr/bin/env bash
cd $HOME/TELAND
token="]]..database:get(Server_Done.."Token_Write")..[["
while(true) do
rm -fr ../.telegram-cli
./tg -s ./TELAND.lua -p PROFILE --bot=$token
done
]])
RunBot:close()
local RunTs = io.open("Run", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/TELAND
while(true) do
rm -fr ../.telegram-cli
screen -S TELAND -X kill
screen -S TELAND ./TELAND
done
]])
RunTs:close()
end
Files_Info_Get()
database:del(Server_Done.."User_Write");database:del(Server_Done.."Token_Write");database:del(Server_Done.."UserSudo_Write");database:del(Server_Done..":token_username")
sudos = dofile('Info.lua')
os.execute('./install.sh ok')
end 
local function Load_File()  
local f = io.open("./Info.lua", "r")  
if not f then   
AutoFiles_Write()  
var = true
else   
f:close()  
database:del(Server_Done.."User_Write");database:del(Server_Done.."Token_Write");database:del(Server_Done.."UserSudo_Write");database:del(Server_Done..":token_username")
sudos = dofile('Info.lua')
os.execute('./install.sh ok')
var = false
end  
return var
end
Load_File()
