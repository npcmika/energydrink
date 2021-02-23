-- Shiloh Energy Drink
-- Discord @shiloh#8000

--================================--
--                                --
--            HOW TO USE          --
--       /energydrink <amount>    --     
--         Source Credits to      --
--          WadL-cmd-drugs        --
--             @WadL#9829         --
--                                --
--================================--      

--Config

--Enable overdose
local OD = true

--Enable killcaffeine command?
local kc = true

--Duration of caffeine effect 
local ShilohEnergyDura = 40*1000


--START OF CODE
prefix = "^4Shiloh Energy^4 "
high = false 
DisabledRun = false

Citizen.CreateThread(function()
		Citizen.Wait(0)
		if DisabledRun == true then
			DisableControlAction(0,21,true)
		end
end)


RegisterCommand("energydrink", function(source, args, rawCommand)
	if #args < 1 then
	    -- Too low args
	    TriggerEvent('chat:addMessage', {
			color = { 255, 0, 0},
			multiline = true,
			args = {"^4Shiloh Energy", "^7Correct usage of command is ^*/energydrink <amount>"}
		})
	    return;
	end
	if high == false then
		local amount = tonumber(args[1])
		TriggerEvent('chat:addMessage', {
			color = { 255, 0, 0},
			multiline = true,
			args = {"^4Shiloh Energy", "^7You have taken ".. amount.." sips of your energy drink"}
		})
		-- CAFFEINE EFFECTS START HERE
		ShakeGameplayCam(', 1.00')
		SetPedMotionBlur(GetPlayerPed(-1), true)
		--runAnim("move_m@drunk@moderatedrunk")
		local FadeTime = (ShilohEnergyDura/10)
		--SetPedMoveRateOverride(source, 5.0)
		SetRunSprintMultiplierForPlayer(source, 1.49)
		high = true
		SetTimecycleModifier('StuntFastLight')
		--Coming Down
		DisabledRun = true
		Citizen.Wait(ShilohEnergyDura*amount)
		SetRunSprintMultiplierForPlayer(source, 1.01)
		--SetPedMoveRateOverride(source, 0)
		runAnim("move_m@JOG@")
		Citizen.Wait(15000)
		local r = math.random(1,30)
		if r == 1 then
			SetEntityHealth(PlayerPedId(), 0)
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"^4Shiloh Energy", "^7^*Your body cannot take that much caffeine. You died"}
			})	
		end
		--ENDING THE CAFFEINE
		DisabledRun = false
		high = false
		StopGameplayCamShaking(true)
		resetAnims()
		SetPedMotionBlur(GetPlayerPed(-1), false)
		SetTransitionTimecycleModifier('default', 0.35)
		-- OVERDOSE
		if amount == 15 or amount > 15 and OD == true then
			SetEntityHealth(PlayerPedId(), 0)
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"^4Shiloh Energy", "^7^*You have died to an overdose of caffeine"}
			})
		end
	else 
	TriggerEvent('chat:addMessage', {
		color = { 255, 0, 0},
		multiline = true,
		args = {"^4Shiloh Energy", "^7^*You have already drank all the energy drinks"}
	})
	end
end)


RegisterCommand("killcaffeine", function(source, args, rawCommand)
	if kc == true then
		TriggerEvent('chat:addMessage', {
			color = { 255, 0, 0},
			multiline = true,
			args = {"^4Shiloh Energy", "^7You have succefully killed your caffeine high"}
		})
		StopGameplayCamShaking(true)
		resetAnims()
		SetTransitionTimecycleModifier('default', 0.35)
		--SetPedMoveRateOverride(source, 0)
		SetRunSprintMultiplierForPlayer(source, 1.01)
		SetEntityMaxHealth(GetPlayerPed(-1), 200)
	else
	TriggerEvent('chat:addMessage', {
		color = { 255, 0, 0},
		multiline = true,
		args = {"^4Shiloh Energy", "^7^*Kill Caffeine has been disabled on this server"}
	})
	end
end)

function PlayEmote()
    local playerped = GetPlayerPed(-1)
    RequestAnimDict('anim@amb@casino@hangout@ped_male@stand_withdrink@01a@idles')
        TaskPlayAnim(playerped, 'anim@amb@casino@hangout@ped_male@stand_withdrink@01a@idles', 'idle_a', 8.0, 8.0, 800, 16, 0, false, false, false)
    end 

function runAnim(anim)
	RequestAnimSet(anim)
	SetPedMovementClipset(GetPlayerPed(-1), anim, true)
end

function resetAnims()
	ResetPedMovementClipset(GetPlayerPed(-1))
	ResetPedWeaponMovementClipset(GetPlayerPed(-1))
	ResetPedStrafeClipset(GetPlayerPed(-1))
end

TriggerEvent('chat:addSuggestion', '/energydrink', '/energydrink <amount>')
TriggerEvent('chat:addSuggestion', 'killcaffeine', 'kills your current caffeine high')