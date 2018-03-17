local event = {}
local event_ref = setmetatable({}, {__mode = 'k'})

event.new = function(t)
	local self = {}
	event_ref[self] = {}
	
	setmetatable(self, {
		__index = t;
		__newindex = function(self, k, v)
			if t[k] ~= v then
				t[k] = v 
				if type(event_ref[self][k]) == 'function' then
					event_ref[self][k](v)
				end
			end
		end;
		__metatable = 'Metatable is locked';
	})
	
	function self:connect(k, f)
		event_ref[self][k] = f
	end
	
	return self
end

local Car = event.new{
	['MaxSpeed'] = 35;
	['Colour'] = 'Blue';
	['Type'] = 'Racing';
	['Invincible'] = false;
}

Car:connect('MaxSpeed', function(speed)
	if speed > 60 then
		print'Your car is very fast!'
	end
end)

Car:connect('Type', function(Type)
	if Type == 'Admin' then
		print'An Admin is in the game!'
	end
end)

Car:connect('Invincible', function(bool)
	if bool then
		print'Your car is invincible!'
	end
end)

Car.Invincible = true
Car.Type = 'Admin'
Car.MaxSpeed = 100
