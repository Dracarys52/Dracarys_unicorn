 ----MENU f6 UNICORN

 local annonces = {
    "~g~Ouvert",
    "~r~Fermer"
  }
  
  
  function startScenario(anim)
    TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
end


    function OpenBillingMenu()

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'billing',
          {
            title = "Facture"
          },
          function(data, menu)
            local amount = tonumber(data.value)

            if amount == nil or amount <= 0 then
                ESX.ShowNotification('~h~~r~Montant invalide !')
            else
                menu.close()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                if closestPlayer == -1 or closestDistance > 2.0 then
                    ESX.ShowNotification('~h~~r~Personne à proximité !')
                else
                    local playerPed = GetPlayerPed(-1)
                    Citizen.CreateThread(function()
                        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
                        Citizen.Wait(5000)
                        ClearPedTasks(playerPed)
                        TriggerServerEvent('esx_billing:sendBill1', GetPlayerServerId(closestPlayer), 'society_unicorn', 'Unicorn', amount)
                        ESX.ShowNotification('~h~~b~Facture ~g~envoyé ~s~!')                         
                    end)
                end
            end
        end,
            function(data, menu)
            menu.close()
        end)
    end
     

    


    Citizen.CreateThread(function()
      while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
      end
    
      while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
      end
    
      PlayerData = ESX.GetPlayerData() 
    end)
    function startAnim(lib, anim)
      ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(plyPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
      end)
    end
    
    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)  
      PlayerData.job = job
    
      Citizen.Wait(5000)
    
    end)


function startScenario(anim)
    TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
end

function startAttitude(lib, anim)
	ESX.Streaming.RequestAnimSet(lib, function()
		SetPedMovementClipset(PlayerPedId(), anim, true)
	end)
end

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
	end)
end



Citizen.CreateThread(function()
  while true do
	Citizen.Wait(0)
	if ragdoll then
	  SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
	end
  end
end)
  local objet = {
    
    "~b~Verre",
    "~b~Prendre note",
  }
  local danse = {
    "~o~Dj",
    "~p~Danse 1",
    "~b~Guitar",
    "~v~Danse 2",
    "~r~Danse 3",
  
  }
    local f5 = {
      Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 0, 0}, Title = "Unicorn" },
      Data = { currentMenu = "~r~Menu interactions", GetPlayerName() }, 
        Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
          PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
          local slide = btn.slidenum
          local btn = btn.name
          local check = btn.unkCheckbox
          local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
          local playerPed = PlayerPedId()
          local coords = GetEntityCoords(playerPed)
          
          
        if btn == "~b~Facture" then                                      
          OpenBillingMenu()	 
        elseif slide == 1 and btn == "~o~Annonces" then                                      
          TriggerServerEvent('Announceunicorno') 
      elseif slide == 2 and btn == "~o~Annonces" then                                     
          TriggerServerEvent('Announceu')  
        elseif slide == 1 and btn == "~r~Objets" then
          ExecuteCommand('e champagne')

            elseif slide == 2 and btn == "~r~Objets" then
              ExecuteCommand('e notepad')
                
    elseif btn == "~r~Mettre fin a l'annimation" then                                      			
      ClearPedTasksImmediately(PlayerPedId())
      ESX.ShowNotification("Animation ~r~stopper~s~ !")
    

    elseif slide == 2 and btn == "~y~Petite danse pour les clients" then
      ExecuteCommand('e dance2')
      print('dracarys')

    elseif slide == 1 and btn == "~y~Petite danse pour les clients" then   
      startAnim('anim@mp_player_intcelebrationmale@dj', 'dj')
      
    elseif slide == 3 and btn == "~y~Petite danse pour les clients" then
      ExecuteCommand('e guitar')
      
    elseif slide == 4 and btn == "~y~Petite danse pour les clients" then
      ExecuteCommand('e dance9')

    elseif slide == 5 and btn == "~y~Petite danse pour les clients" then
      ExecuteCommand('e dancef4')

    elseif btn == "~g~Fermer le menu" then
      print('dracarys')
      CloseMenu('')
    

    end
    end

      },
      
      Menu = { 
        ["~r~Menu interactions"] = { 
          b = { 
  
      
                     {name = "~b~Facture", ask = "→→", askX = true}, 
                     {name = "~o~Annonces", slidemax = annonces}, 
                     {name = "~r~Objets", slidemax = objet}, 
                     {name = "~y~Petite danse pour les clients", slidemax = danse}, 
                     {name = "~p~---------------------------------------------------------------------", ask = "", askX = true},
                     {name = "~r~Mettre fin a l'annimation", ask = "→→", askX = true}, 
                     {name = "~p~---------------------------------------------------------------------", ask = "", askX = true}, 
                     {name = "~g~Fermer le menu", ask = "", askX = true}, 
          }
            },
        
      }
    }
  
    Citizen.CreateThread(function()
        while true do
            Wait(1)
            if IsControlJustPressed(1,167) and PlayerData.job and PlayerData.job.name == 'unicorn' then
                CreateMenu(f5)
            end  
        end
      end)


      -- --------------------------GARDE DU CORP + coffre deposer armes etc----------- FAUT BIEN LAISSER ESX_POLICEJOB


  Citizen.CreateThread(function()
    local hash = GetHashKey("cs_fbisuit_01")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end 
    ped = CreatePed("cs_old_man1a", "cs_fbisuit_01", 128.297, -1299.87, 28.32, 304.146, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true) 
    FreezeEntityPosition(ped, true)
  end)
  
  


local Shop = {   
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_Green}, HeaderColor = {0, 0, 0}, --[[R, G, B   R = red G = Green B = Blue ]]Title = 'UNICORN'},
	Data = { currentMenu = "Coffre :", GetPlayerName()},
    Events = { 
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
      PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
      local btn = btn.name
          if btn == "Jäger Cerbère" then  
 TriggerServerEvent('youtube:test', 5, 'jagercerbere', 1)
           elseif btn == "Déposer Armes" then
            print('dracarys')
             OpenPutWeaponMenu()
             CloseMenu('')
            elseif btn == "Prendre Armes" then
              OpenGetWeaponMenu()
              CloseMenu('')
                  
             end 
	        end,     
	},    

	Menu = {  
		["Coffre :"] = { 
			b = { 
        {name = "Déposer Armes", ask = "", askX = true},
        {name = "Prendre Armes", ask = "", askX = true},
        {name = "~p~---------------------------------------------------------------------", ask = "", askX = true},
        {name = "~r~Fermer le Menu~s~", ask = "", askX = true}
     
			}  
		},
	}
}    


local template = {
  {x = 128.297, y= -1299.87, z=28.32}
}

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0) 
      for k in pairs(template) do
          local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
          local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, template[k].x, template[k].y, template[k].z)
          if dist <= 2.0 then 
              ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour déposez vos armes")
              if IsControlJustPressed(1,38) then 			
               CreateMenu(Shop)    
                  end
              end 
          end
      end
  end)
  
  function OpenPutWeaponMenu()
    local elements   = {}
    local playerPed  = PlayerPedId()
    local weaponList = ESX.GetWeaponList()
  
    for i=1, #weaponList, 1 do
      local weaponHash = GetHashKey(weaponList[i].name)
  
      if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
        table.insert(elements, {
          label = weaponList[i].label,
          value = weaponList[i].name
        })
      end
    end
  
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon',
    {
      title    =  ('Déposer vos armes'),
      align    = 'top-left',
      elements = elements
    }, function(data, menu)
  
      menu.close()
  
      ESX.TriggerServerCallback('esx_policejob:addArmoryWeapon', function()
        OpenPutWeaponMenu()
      end, data.current.value, true)
  
    end, function(data, menu)
      menu.close()
    end)
  end

  
function OpenGetWeaponMenu()

	ESX.TriggerServerCallback('esx_policejob:getArmoryWeapons', function(weapons)
		local elements = {}

		for i=1, #weapons, 1 do
			if weapons[i].count > 0 then
				table.insert(elements, {
					label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name),
					value = weapons[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon',
		{
			title    =  ('Prendre vos armes'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)

			menu.close()

			ESX.TriggerServerCallback('esx_policejob:removeArmoryWeapon', function()
				OpenGetWeaponMenu()
			end, data.current.value)

		end, function(data, menu)
			menu.close()
		end)
	end)

end


-------- VESTIAIRE --------


-- Vestaire

  
local Shop = {   
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_Green}, HeaderColor = {0, 0, 0}, --[[R, G, B   R = red G = Green B = Blue ]]Title = 'UNICORN'},
	Data = { currentMenu = "Coffre :", GetPlayerName()},
    Events = { 
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
      PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
      local btn = btn.name
          if btn == "Jäger Cerbère" then  
 TriggerServerEvent('youtube:test', 5, 'jagercerbere', 1)
           elseif btn == "Tenue Patron" then
            tenupatron()
          elseif btn == "Tenue Civil" then
            print('dracarys')
            civil()
          elseif btn == "Tenue danseure" then
            print('dracarys')
            danseure()
   
             end 
	        end,     
	},    

	Menu = {  
		["Coffre :"] = { 
			b = { 
        {name = "Tenue Civil", ask = "", askX = true},
        {name = "Tenue danseure", ask = "", askX = true},
        {name = "Tenue Patron", ask = "", askX = true},
        {name = "                          ↓ ------------------------ ↓                          ", ask = "", askX = true}, 
        {name = "~r~Fermer le Menu~s~", ask = "", askX = true}
     
			}  
		},
	}
}    
local template = {
  {x = 105.491, y= -1302.81, z=28.768}
}

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0) 
      for k in pairs(template) do
          local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
          local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, template[k].x, template[k].y, template[k].z)
          if dist <= 2.0 then 
              ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour te changer")
              if IsControlJustPressed(1,38) then 			
               CreateMenu(Shop)    
                  end
              end 
          end
      end
  end)
  function  danseure()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
          clothesSkin = {
            ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 62,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 14,
            ['pants_1'] = 4,    ['pants_2'] = 0,
            ['shoes_1'] = 34,   ['shoes_2'] = 0,
            ['chain_1'] = 118,  ['chain_2'] = 0
          }
      else
          clothesSkin = {
            ['tshirt_1'] = 68,  ['tshirt_2'] = 0,
            ['torso_1'] = 37,   ['torso_2'] = 0, 
            ['arms'] = 4,
            ['pants_1'] = 25,   ['pants_2'] = 0,
            ['shoes_1'] = 6,   ['shoes_2'] = 0,  
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0
          }
      end
      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
  end)
end

  function  tenupatron()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
              ['tshirt_1'] = 75,  ['tshirt_2'] = 3,
              ['torso_1'] = 29,   ['torso_2'] = 0,
              ['arms'] = 4,
              ['pants_1'] = 24,   ['pants_2'] = 0,
              ['shoes_1'] = 10,   ['shoes_2'] = 0,
              ['helmet_1'] = -1,  ['helmet_2'] = 0,
              ['chain_1'] = 0,    ['chain_2'] = 0,
              ['ears_1'] = -1,     ['ears_2'] = 0
            }
        else
            clothesSkin = {
              ['tshirt_1'] = 68,  ['tshirt_2'] = 0,
              ['torso_1'] = 37,   ['torso_2'] = 0, 
              ['arms'] = 4,
              ['pants_1'] = 25,   ['pants_2'] = 0,
              ['shoes_1'] = 6,   ['shoes_2'] = 0,  
              ['helmet_1'] = -1,  ['helmet_2'] = 0,
              ['chain_1'] = 0,    ['chain_2'] = 0,
              ['ears_1'] = -1,     ['ears_2'] = 0
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end

function civil()
  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
      TriggerEvent('skinchanger:loadSkin', skin)
     end)
  end

  -- Stock ****** TOUJOURS LAISSER ESX_police

  
local Shop = {   
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_Green}, HeaderColor = {0, 0, 0}, --[[R, G, B   R = red G = Green B = Blue ]]Title = 'UNICORN'},
	Data = { currentMenu = "UNICORN shop :", GetPlayerName()},
    Events = { 
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
      PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
      local btn = btn.name
          if btn == "Jäger Cerbère" then  
 TriggerServerEvent('youtube:test', 5, 'jagercerbere', 1)
          elseif btn == "~y~Déposer boisons/nourritures" then
            OpenPutStocksMenu()
            CloseMenu('')
          elseif btn == "~b~Prendre stock" then
            OpenGetStocksMenu()
            CloseMenu('')
             end 
	        end,     
	},    

	Menu = {  
		["UNICORN shop :"] = { 
			b = { 
        {name = "~y~Déposer boisons/nourritures", ask = "→→", askX = true},   
        {name = "~b~Prendre stock", ask = "→→", askX = true},   
        {name = "    ~p~                      ↓ ------------------------ ↓                ~p~           ", ask = "", askX = true}, 
        {name = "~r~Fermer le Menu~s~", ask = "", askX = true}
     
			}  
		},

	}
}    

function OpenGetStocksMenu()

	ESX.TriggerServerCallback('esx_policejob:getStockItems', function(items)

		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = ('Stock Unicorn'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = ('quantity')
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_policejob:getStockItem', itemName, count)

					Citizen.Wait(300)
					OpenGetStocksMenu()
				end

			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)

	end)

end


function OpenPutStocksMenu()

	ESX.TriggerServerCallback('esx_policejob:getPlayerInventory', function(inventory)

		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = ('inventory'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title =  ('quantity')
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_policejob:putStockItems', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksMenu()
				end

			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)
	end)

end

local template = {
  {x = 129.57, y= -1281.39, z=29.26}
}

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0) 
      for k in pairs(template) do
          local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
          local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, template[k].x, template[k].y, template[k].z)
          if dist <= 2.0 then 
              ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ au frigo")
              if IsControlJustPressed(1,38) then 			
               CreateMenu(Shop)    
                  end
              end 
          end
      end
  end)

   -- Garage Voitures 
      
local garage = {   
	Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_Green}, HeaderColor = {0, 0, }, --[[R, G, B   R = red G = Green B = Blue ]]Title = 'Garage'},
	Data = { currentMenu = "Action Garage :", GetPlayerName()},
    Events = { 
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
      PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
      local btn = btn.name
          if btn == "Pain" then  
 TriggerServerEvent('youtube:test', 5, 'bread', 20)
         elseif btn == "~r~Limousine~r~" then
          spawnCar('stretch')
        elseif btn == "~b~Supprimer la voiture" then 
          TriggerEvent('esx:deleteVehicle')
        elseif btn == "~g~Range Rover~g~" then 
          spawnCar('baller')
        elseif btn == "~o~Range Rover~o~" then 
          spawnCar('baller2')
          elseif btn == "~r~Close Menu" then
            CloseMenu('')
             end 
	        end,     
	},    
	Menu = {  
		["Action Garage :"] = { 
			b = { 
        {name = "~r~Limousine~r~", ask = '', askX = true},       
        {name = "~g~Range Rover~g~", ask = 'n°1', askX = true},       
        {name = "~o~Range Rover~o~", ask = 'n°2', askX = true}, 
        {name = "~p~---------------------------------------------------------------------", ask = "", askX = true},
        {name = "~b~Supprimer la voiture",  ask = ">", askX = true}, 
        {name = "~p~---------------------------------------------------------------------", ask = "", askX = true},
        {name = "~r~Close Menu", ask = ">", askX = true},           
			}  
		}

	}
}    

function spawnCar(car)
  local car = GetHashKey(car)
  RequestModel(car)
  while not HasModelLoaded(car) do
      RequestModel(car)
      Citizen.Wait(50)   
  end
  local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
  local vehicle = CreateVehicle(car, 146.035, -1287.17, 29.30, 288.284, false, false)   ---- spawn postion 
  if checkboxnotif == false then 
  else
      ESX.ShowNotification('~g~Garage¦~s~\nVous avez sorti ~h~~b~un/une~s~ ~y~'..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))..'')
  end
end

local template = {
  {x = 142.007, y= -1281.86, z=29.33}
}

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0) 
      for k in pairs(template) do
          local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
          local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, template[k].x, template[k].y, template[k].z)
          if dist <= 2.0 then 
              ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour accéder au garage")
              if IsControlJustPressed(1,38) and PlayerData.job and PlayerData.job.name == 'unicorn' then		
                print('dracarys')
               CreateMenu(garage)    
                  end
              end 
          end
      end
  end)
  