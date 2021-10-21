ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    PlayerData = ESX.GetPlayerData()
    if PlayerData.job.name == 'police' then
        arme = true
    end
    if PlayerData.job.name == 'unemployed' then
        arme = true
    end
    if PlayerData.job.name == 'gruppe6' then
        gruppe6 = true
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    
    if PlayerData.job.name == 'police' then
        arme = true
    end
    if PlayerData.job.name == 'unemployed' then
        arme = true
    end
    if PlayerData.job.name == 'gruppe6' then
        gruppe6 = true
    end
end)

RMenu.Add('LSPD', 'main', RageUI.CreateMenu("Menu Props", " "))
RMenu:Get('LSPD', 'main'):SetSubtitle("Catégories :")
RMenu:Get('LSPD', 'main').EnableMouse = false
RMenu:Get('LSPD', 'main').Closed = function()
    -- TODO Perform action
end;


RMenu.Add('LSPD', 'object', RageUI.CreateSubMenu(RMenu:Get('LSPD', 'main'), "Props", "Appuyer sur [~g~E~w~] pour poser les objet"))
RMenu.Add('LSPD', 'object2', RageUI.CreateSubMenu(RMenu:Get('LSPD', 'main'), "Props", "Appuyer sur [~g~E~w~] pour poser les objet"))
RMenu.Add('LSPD', 'object3', RageUI.CreateSubMenu(RMenu:Get('LSPD', 'main'), "Props", "Appuyer sur [~g~E~w~] pour poser les objet"))
RMenu.Add('LSPD', 'object4', RageUI.CreateSubMenu(RMenu:Get('LSPD', 'main'), "Props", "Appuyer sur [~g~E~w~] pour poser les objet"))
RMenu.Add('LSPD', 'object5', RageUI.CreateSubMenu(RMenu:Get('LSPD', 'main'), "Props", "Appuyer sur [~g~E~w~] pour poser les objet"))
RMenu.Add('LSPD', 'object6', RageUI.CreateSubMenu(RMenu:Get('LSPD', 'main'), "Props", "Appuyer sur [~g~E~w~] pour poser les objet"))
RMenu.Add('LSPD', 'object7', RageUI.CreateSubMenu(RMenu:Get('LSPD', 'main'), "Props", "Appuyer sur [~g~E~w~] pour poser les objet"))
RMenu.Add('LSPD', 'object8', RageUI.CreateSubMenu(RMenu:Get('LSPD', 'main'), "Props", "Appuyer sur [~g~E~w~] pour poser les objet"))
RMenu.Add('LSPD', 'object9', RageUI.CreateSubMenu(RMenu:Get('LSPD', 'main'), "Props", "Appuyer sur [~g~E~w~] pour poser les objet"))
RMenu.Add('LSPD', 'objectlist', RageUI.CreateSubMenu(RMenu:Get('LSPD', 'object'), "Suppression d'objets", "~b~Suppression d'objets"))

object = {}
OtherItems = {}local inventaire = false
local status = true

RageUI.CreateWhile(1.0, function()
    if IsControlJustPressed(1, 344) then
		if PlayerData.job.name == 'organisateur' or PlayerData.job.name == 'oneil' then
			RageUI.Visible(RMenu:Get('LSPD', 'main'), not RageUI.Visible(RMenu:Get('LSPD', 'main')))
		end
    end

    if RageUI.Visible(RMenu:Get('LSPD', 'main')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("O'neil", "Appuyer sur [~g~E~w~] pour poser les objet", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('LSPD', 'object8'))

            RageUI.Button("Mariage", "Appuyer sur [~g~E~w~] pour poser les objet", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('LSPD', 'object9'))

            RageUI.Button("Civil", "Appuyer sur [~g~E~w~] pour poser les objet", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('LSPD', 'object'))

            RageUI.Button("LSPD", "Appuyer sur [~g~E~w~] pour poser les objet", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('LSPD', 'object4'))

            RageUI.Button("EMS", "Appuyer sur [~g~E~w~] pour poser les objet", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('LSPD', 'object2'))

            RageUI.Button("Mecano", "Appuyer sur [~g~E~w~] pour poser les objet", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('LSPD', 'object7'))

            RageUI.Button("Gang", "Appuyer sur [~g~E~w~] pour poser les objet", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('LSPD', 'object3'))

            RageUI.Button("Armes", "Appuyer sur [~g~E~w~] pour poser les objet", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('LSPD', 'object5'))

            RageUI.Button("Drogue", "Appuyer sur [~g~E~w~] pour poser les objet", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('LSPD', 'object6'))

            RageUI.Button("Mode suppression", "Supprimer des objets", { RightLabel = "XXX" }, true, function(Hovered, Active, Selected)
            end, RMenu:Get('LSPD', 'objectlist'))

        end, function()
            ---Panels
        end)
    end

    --Mariage

    if RageUI.Visible(RMenu:Get('LSPD', 'object9')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()
    
            RageUI.Button("v_ret_flowers", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_ret_flowers")
                end
            end)
            RageUI.Button("v_ret_ps_flowers_02", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_ret_ps_flowers_02")
                end
            end)
            RageUI.Button("vw_prop_flowers_vase_01a", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("vw_prop_flowers_vase_01a")
                end
            end)
            RageUI.Button("vw_prop_flowers_vase_02a", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("vw_prop_flowers_vase_02a")
                end
            end)

            RageUI.Button("Table", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_table_05")
                end
            end)
            RageUI.Button("Chaise", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_table_05_chr")
                end
            end)
            RageUI.Button("Buffet", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("apa_mp_h_din_table_06")
                end
            end)
            RageUI.Button("Cake", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_res_cakedome")
                end
            end)
            RageUI.Button("Champagne", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("ch_prop_champagne_01a")
                end
            end)
            RageUI.Button("Flute Champagne", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("lux_p_champ_flute_s")
                end
            end)
            RageUI.Button("Fruit", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_res_fh_fruitbowl")
                end
            end)
            RageUI.Button("Assiette Remplie", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_cs_plate_01")
                end
            end)
            RageUI.Button("Assiette vide", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_res_tt_platepile")
                end
            end)
            RageUI.Button("Ballon", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("vw_vwint02_pent_baloons_col")
                end
            end)
           
        end, function()
            ---Panels
        end)
    end
    

-- O'neil

if RageUI.Visible(RMenu:Get('LSPD', 'object8')) then
    RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

        RageUI.Button("Box électrique", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("lts_prop_lts_elecbox_24")
            end
        end)

        RageUI.Button("Tas de briques", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_pile_dirt_02")
            end
        end)

        RageUI.Button("Tas de cailloux", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_pile_dirt_01")
            end
        end)

        RageUI.Button("Tas de gros déchets", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_pile_dirt_03")
            end
        end)

        RageUI.Button("Gros tas de cailloux", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_pile_dirt_04")
            end
        end)

        RageUI.Button("Petit ralentisseur", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("stt_prop_track_slowdown")
            end
        end)

        RageUI.Button("Ralentiseur 2 bandes", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("stt_prop_track_slowdown_t1")
            end
        end)

        RageUI.Button("Oeuf d'alien", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_alien_egg_01")
            end
        end)

        RageUI.Button("Amplificateur", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_amp_01")
            end
        end)

        RageUI.Button("Asteroide", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_asteroid_01")
            end
        end)

        RageUI.Button("longue barrière uniee", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_barier_conc_05b")
            end
        end)

        RageUI.Button("Long barrière rouge et blanche", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_barier_conc_05b")
            end
        end)

        RageUI.Button("Cone rond", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_barrier_wat_03b")
            end
        end)

        RageUI.Button("Cone", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_byard_net02")
            end
        end)

        RageUI.Button("tuyau de jardin", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_byard_pipe_01")
            end
        end)

        RageUI.Button("Rouleau de cable jaune", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_cablespool_02")
            end
        end)

        RageUI.Button("Rouleau de cable noir", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_cablespool_06")
            end
        end)

        RageUI.Button("Malaxeuse", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_cementmixer_01a")
            end
        end)

        RageUI.Button("Malaxeuse 2", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_cementmixer_02a")
            end
        end)  

        RageUI.Button("Pile de sac", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_conc_sacks_02a")
            end
        end)

        RageUI.Button("Mur de bois ? ", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_const_fence03b_cr")
            end
        end)

        RageUI.Button("Container", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_container_03b")
            end
        end)

        RageUI.Button("Trolley de outils", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_cs_trolley_01")
            end
        end)

        RageUI.Button("Box electrique", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_elecbox_14")
            end
        end)

        RageUI.Button("Générateur", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_generator_02a")
            end
        end)

        RageUI.Button("Ecran géant", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_huge_display_01")
            end
        end)
        
        RageUI.Button("Tuyau simple", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_Id_pipe_single_01")
            end
        end)

        RageUI.Button("Barrière flèche", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_mp_arrow_barrier_01")
            end
        end)

        RageUI.Button("Barrière R.W.A", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_mp_barrier_02")
            end
        end)

        RageUI.Button("Long Cone", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_mp_cone_04")
            end
        end)

        RageUI.Button("Long tuyaux", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_pipes_01a")
            end
        end)

        RageUI.Button("Tuyau 1", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_pipes_conc_01")
            end
        end)

        RageUI.Button("Pile tuyaux", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_pipes_conc_02")
            end
        end)

        RageUI.Button("Barrière rouge en plastique", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_plas_barier_01a")
            end
        end)

        RageUI.Button("Scie electrique", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_tool_consaw")
            end
        end)

        RageUI.Button("Perf", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_tool_jackham")
            end
        end)

        RageUI.Button("Eau", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_watercrate_01")
            end
        end)

        RageUI.Button("Brouette", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_wheelbarrow02a")
            end
        end)

        RageUI.Button("Cicuit de lumiere", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("v_ilev_carmod3lamp")
            end
        end)

        RageUI.Button("Cone lumiere", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_air_conelight")
            end
        end)

        RageUI.Button("Palette de sac ciment", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_cementbags01")
            end
        end)

        RageUI.Button("Palette de blocs 1", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_conc_blocks01a")
            end
        end)

        RageUI.Button("Palette de blocs 2", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_conc_blocks01b")
            end
        end)

        RageUI.Button("Palette de blocs 3", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_conc_blocks01c")
            end
        end)

        RageUI.Button("Filet", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_fnc_omesh_02a")
            end
        end)

        RageUI.Button("Grand Spot", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_worklight_03b")
            end
        end)

    end, function()
        ---Panels
    end)
end
    
-- Civil
    if RageUI.Visible(RMenu:Get('LSPD', 'object')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

        	RageUI.Button("Chaise", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("apa_mp_h_din_chair_12")
                end
            end)

        	RageUI.Button("Carton", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_cardbordbox_04a")
                end
            end)

            RageUI.Button("Sac", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_cs_heist_bag_02")
                end
            end)

            RageUI.Button("Table 1", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_rub_table_02")
                end
            end)

            RageUI.Button("Table 2", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_table_04")
                end
            end)

            RageUI.Button("Table 3", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_table_01b")
                end
            end)

            RageUI.Button("Petite Chaise", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_clubhouse_chair_01")
                end
            end)

            RageUI.Button("Ordinateur", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_clubhouse_laptop_01a")
                end
            end)

            RageUI.Button("Chaise Bureau", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_clubhouse_offchair_01a")
                end
            end)

            RageUI.Button("Lit Bunker", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("gr_prop_bunker_bed_01")
                end
            end)

            RageUI.Button("Lit Biker", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("gr_prop_gr_campbed_01")
                end
            end)

            RageUI.Button("Chaise Peche", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("hei_prop_hei_skid_chair")
                end
            end)

        end, function()
            ---Panels
        end)
    end

-- Mecano
if RageUI.Visible(RMenu:Get('LSPD', 'object7')) then
    RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

        RageUI.Button("Outils", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_cs_trolley_01")
            end
        end)
        
        RageUI.Button("Outils mecano", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_carcreeper")
            end
        end)

        RageUI.Button("Sac à outils", nil, {}, true, function(Hovered, Active, Selected)
            if Selected then
                SpawnObj("prop_cs_heist_bag_02")
            end
        end)

    end, function()
        ---Panels
    end)
end

-- EMS
    if RageUI.Visible(RMenu:Get('LSPD', 'object2')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("Sac mortuaire", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("xm_prop_body_bag")
                end
            end)

            RageUI.Button("Trousse médical 1", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("xm_prop_smug_crate_s_medical")
                end
            end)

            RageUI.Button("Trousse médical 2", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("xm_prop_x17_bag_med_01a")
                end
            end)

        end, function()
            ---Panels
        end)
    end

-- Gang
    if RageUI.Visible(RMenu:Get('LSPD', 'object3')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("Chaise", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_chair_01a")
                end
            end)

            RageUI.Button("Sac pour arme", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_gun_case_01")
                end
            end)

            RageUI.Button("Cash", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("hei_prop_cash_crate_half_full")
                end
            end)

            RageUI.Button("Valise de cash", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_cash_case_02")
                end
            end)

            RageUI.Button("Petite pile de cash", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_cash_crate_01")
                end
            end)

            RageUI.Button("Poubelle", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_cs_dumpster_01a")
                end
            end)

            RageUI.Button("Canapé", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_tre_sofa_mess_c_s")
                end
            end)

            RageUI.Button("Canapé 2", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("v_res_tre_sofa_mess_a")
                end
            end)

            RageUI.Button("Pile de cash", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_bkr_cashpile_04")
                end
            end)

            RageUI.Button("Pile de cash 2", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_bkr_cashpile_05")
                end
            end)
            
        end, function()
            ---Panels
        end)
    end

-- LSPD
    if RageUI.Visible(RMenu:Get('LSPD', 'object4')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("Cone", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_roadcone02a")
                end
            end)
            RageUI.Button("Barrière", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_barrier_work05")
                end
            end)
            
            RageUI.Button("Gros carton", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("prop_boxpile_07d")
                end
            end)

            RageUI.Button("Herse", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("p_ld_stinger_s")
                end
            end)

        end, function()
            ---Panels
        end)
    end

-- Armes
    if RageUI.Visible(RMenu:Get('LSPD', 'object5')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()
            
            RageUI.Button("Malette Armes", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_biker_gcase_s")
                end
            end)

            RageUI.Button("Caisse Batteuses", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("ex_office_swag_guns04")
                end
            end)

            RageUI.Button("Caisse Armes", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("ex_prop_crate_ammo_bc")
                end
            end)

            RageUI.Button("Caisse Batteuses 2", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("ex_prop_crate_ammo_sc")
                end
            end)

            RageUI.Button("Caisse Fermé", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("ex_prop_adv_case_sm_03")
                end
            end)

            RageUI.Button("Petite Caisse", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("ex_prop_adv_case_sm_flash")
                end
            end)

            RageUI.Button("Caisse Explosif", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("ex_prop_crate_expl_bc")
                end
            end)

            RageUI.Button("Caisse Vetements", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("ex_prop_crate_expl_sc")
                end
            end)

            RageUI.Button("Caisse Chargeurs", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("gr_prop_gr_crate_mag_01a")
                end
            end)

            RageUI.Button("Grosse Caisse Armes", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("gr_prop_gr_crates_rifles_01a")
                end
            end)

            RageUI.Button("Grosse Caisse Armes 2", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("gr_prop_gr_crates_weapon_mix_01a")
                end
            end)

        end, function()
            ---Panels
        end)
    end

-- Drogue
    if RageUI.Visible(RMenu:Get('LSPD', 'object6')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            RageUI.Button("Cocaine Block", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_block_01a")
                end
            end)

            RageUI.Button("Cocaine Pallet", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_pallet_01a")
                end
            end)

            RageUI.Button("Balance Cocaine", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_scale_01")
                end
            end)

            RageUI.Button("Spatule Cocaine", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_spatula_04")
                end
            end)

            RageUI.Button("Table Cocaine", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_table01a")
                end
            end)

            RageUI.Button("Caisse", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_crate_set_01a")
                end
            end)

            RageUI.Button("Palette Weed", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_fertiliser_pallet_01a")
                end
            end)

            RageUI.Button("Palette 1", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_fertiliser_pallet_01b")
                end
            end)

            RageUI.Button("Palette 2", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_fertiliser_pallet_01c")
                end
            end)

            RageUI.Button("Palette 3", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_fertiliser_pallet_01d")
                end
            end)

            RageUI.Button("Acetone Meth", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_acetone")
                end
            end)

            RageUI.Button("Bidon Meth", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_ammonia")
                end
            end)

            RageUI.Button("Bac Meth", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_bigbag_01a")
                end
            end)

            RageUI.Button("Bac Meth 2", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_bigbag_02a")
                end
            end)

            RageUI.Button("Bac Meth 3", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_bigbag_03a")
                end
            end)

            RageUI.Button("Lithium Meth", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_lithium")
                end
            end)

            RageUI.Button("Phosphorus Meth", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_phosphorus")
                end
            end)

            RageUI.Button("Pseudoephedrine", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_pseudoephedrine")
                end
            end)

            RageUI.Button("Meth Smash", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_smashedtray_01")
                end
            end)

            RageUI.Button("Machine a sous", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_money_counter")
                end
            end)

            RageUI.Button("Acetone Meth", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_acetone")
                end
            end)

            RageUI.Button("Pot Weed", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_01_small_01b")
                end
            end)

            RageUI.Button("Packet Weed", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_bigbag_03a")
                end
            end)

            RageUI.Button("Packet Weed Ouvert", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_bigbag_open_01a")
                end
            end)

            RageUI.Button("Pot Weed 2", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_bucket_01d")
                end
            end)

            RageUI.Button("Weed", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_drying_01a")
                end
            end)

            RageUI.Button("Weed Plante", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_lrg_01b")
                end
            end)

            RageUI.Button("Weed Plante 2", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_med_01b")
                end
            end)

            RageUI.Button("Table Weed", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_drying_01a")
                end
            end)

            RageUI.Button("Weed Pallet", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("hei_prop_heist_weed_pallet")
                end
            end)

            RageUI.Button("Coke", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("imp_prop_impexp_boxcoke_01")
                end
            end)

            RageUI.Button("Coke en bouteille", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_bottle_01a")
                end
            end)

            RageUI.Button("Coke coupé", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_cut_01")
                end
            end)

            RageUI.Button("Bol de coke", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_fullmetalbowl_02")
                end
            end)

            RageUI.Button("Prop meth", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_pseudoephedrine")
                end
            end)

            RageUI.Button("Sac de meth ouvert", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_openbag_01a")
                end
            end)

            RageUI.Button("Gros sac de meth", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_meth_bigbag_04a")
                end
            end)

            RageUI.Button("Gros sac de weed", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_bigbag_03a")
                end
            end)

            RageUI.Button("Weed plante", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_01_small_01a")
                end
            end)

            RageUI.Button("Weed", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_dry_02b")
                end
            end)

            RageUI.Button("Table de weed", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_weed_table_01a")
                end
            end)

            RageUI.Button("Block de coke", nil, {}, true, function(Hovered, Active, Selected)
                if Selected then
                    SpawnObj("bkr_prop_coke_block_01a")
                end
            end)
            
        end, function()
            ---Panels
        end)
    end

    if RageUI.Visible(RMenu:Get('LSPD', 'objectlist')) then
        RageUI.DrawContent({ header = true, glare = true, instructionalButton = false }, function()

            for k,v in pairs(object) do
                if GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))) == 0 then table.remove(object, k) end
                RageUI.Button("Object: "..GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))).." ["..v.."]", nil, {}, true, function(Hovered, Active, Selected)
                    if Active then
                        local entity = NetworkGetEntityFromNetworkId(v)
                        local ObjCoords = GetEntityCoords(entity)
                        DrawMarker(0, ObjCoords.x, ObjCoords.y, ObjCoords.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)
                    end
                    if Selected then
                        RemoveObj(v, k)
                    end
                end)
            end
            
        end, function()
            ---Panels
        end)
    end

end, 1)

RegisterCommand('props', function()
    RageUI.Visible(RMenu:Get('LSPD', 'main'), true)
end, true)