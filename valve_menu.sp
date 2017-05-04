/*  Valve items menu
 *
 *  Copyright (C) 2017 Francisco 'Franc1sco' García, hadesownage
 * 
 * This program is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option) 
 * any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT 
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS 
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with 
 * this program. If not, see http://www.gnu.org/licenses/.
 */

#include <sourcemod>

public Plugin myinfo = 
{
	name = "Valve items menu",
	author = "Franc1sco franug",
	description = "",
	version = "1.0",
	url = "http://steamcommunity.com/id/franug"
};

public void OnPluginStart()
{
	RegConsoleCmd("sm_valve", Command_OpenMenu, "opens the menu that show valve items");
	RegConsoleCmd("buyammo1", Command_OpenMenu, "opens the menu depends on players team/rank");
}

public Action Command_OpenMenu(int client, int args)
{
	Menu menu = new Menu(Menu_select);
	menu.SetTitle("Menu with all the valve items");
	
	if(CommandExists("sm_ws"))menu.AddItem("ws", "Weapon Paints");
	if(CommandExists("sm_knife"))menu.AddItem("knife", "Valve knives");
	if(CommandExists("sm_gloves"))menu.AddItem("gloves", "Valve Gloves");
	if(CommandExists("sm_music"))menu.AddItem("music", "Valve music kits");
	if(CommandExists("sm_mm"))menu.AddItem("mm", "Elo Ranks");
	if(CommandExists("sm_coin"))menu.AddItem("coin", "Coins");
	if(CommandExists("sm_profile"))menu.AddItem("profile", "Profile ranks");
	if(FindConVar("sm_franugvalvesprays_version") != null)menu.AddItem("sprays", "Valve Sprays");
	
	
	SetMenuPagination(menu, MENU_NO_PAGINATION);
	menu.ExitButton = true;
	menu.Display(client, MENU_TIME_FOREVER);
}

public int Menu_select(Menu menu, MenuAction action, int client, int param)
{
	if (action == MenuAction_Select)
	{
		char selection[128];
		menu.GetItem(param, selection, sizeof(selection));
		
		if (StrEqual(selection, "ws"))FakeClientCommand(client, "sm_ws");
		else if (StrEqual(selection, "gloves"))FakeClientCommand(client, "sm_gloves");
		else if (StrEqual(selection, "knife"))FakeClientCommand(client, "sm_knife");
		else if (StrEqual(selection, "music"))FakeClientCommand(client, "sm_music");
		else if (StrEqual(selection, "sprays"))FakeClientCommand(client, "sm_sprays");
		else if (StrEqual(selection, "mm"))FakeClientCommand(client, "sm_mm");
		else if (StrEqual(selection, "coin"))FakeClientCommand(client, "sm_coin");
		else if (StrEqual(selection, "profile"))FakeClientCommand(client, "sm_profile");
		
	}
	else if (action == MenuAction_End)
	{
		delete menu;
	}
}