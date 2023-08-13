#include <sourcemod>

public Plugin:myinfo =
{
	name = "Info Plugin",
	author = "Arcala the Gyiyg",
	description = "Opens a menu for users to get more info about server features.",
	version = "1.0.1",
	url = "https://github.com/ArcalaAlien/HowToSurfPlugin"
}

public Action Timer_Message(Handle timer, any data)
{
    PrintToChatAll("\x04[INFO]: \x01If you're new to the server, use /info to view server features, access the discord, and learn how to surf!");
    return Plugin_Continue;
}

public void OnPluginStart()
{
    LoadTranslations("infoplugin.phrases");
    RegConsoleCmd("sm_info", CMD_INFO, "Opens the info menu.");
    RegConsoleCmd("sm_infomenu", CMD_INFO, "Opens the info menu.");
    CreateTimer(360.0, Timer_Message, 3, TIMER_REPEAT | TIMER_FLAG_NO_MAPCHANGE);
}

public int Info_Menu_Handler(Menu menu, MenuAction action, int param1, int param2)
{
    switch(action)
    {
        case MenuAction_Select:
        {
            PrintToServer("Menu Choice %d", param2);
            char menuItemBuffer[32];
            menu.GetItem(param2, menuItemBuffer, sizeof(menuItemBuffer));
            PrintToServer("Menu Item %s", menuItemBuffer);
            if (strcmp(menuItemBuffer, "OPT_DISCORD") == 0)
            {
                PrintToChat(param1, "\x04[INFO]: \x01%t", "DISCORD_LINK");
            }
            else if (strcmp(menuItemBuffer, "OPT_STEAM") == 0)
            {
                PrintToChat(param1, "\x04[INFO]: \x01%t", "STEAM_LINK");
            }
            else if (strcmp(menuItemBuffer, "OPT_STAFF") == 0)
            {
                PrintToChat(param1, "\x04[INFO]: \x01%t", "STAFF_LIST1");
                PrintToChat(param1, "\x04[INFO]: \x01%t", "STAFF_LIST2");
                PrintToChat(param1, "\x04[INFO]: \x01%t", "STAFF_LIST3");
            }
            else if(strcmp(menuItemBuffer, "OPT_TAGS") == 0)
            {
                PrintToChat(param1, "\x04[INFO]: \x01%t", "TAG_MSG1");
                PrintToChat(param1, "\x04[INFO]: \x01%t", "TAG_MSG2");
                PrintToChat(param1, "\x04[INFO]: \x01%t", "TAG_MSG3");
            }
            else if (strcmp(menuItemBuffer, "OPT_SURF") == 0)
            {
                PrintToChat(param1, "\x04[INFO]: \x01%t", "HOWTO_SURF1");
                PrintToChat(param1, "\x04[INFO]: \x01%t", "HOWTO_SURF2");
                PrintToChat(param1, "\x04[INFO]: \x01%t", "HOWTO_SURF3");
            }
        }
        case MenuAction_Cancel:
        {

        }
        case MenuAction_End:
        {
            delete menu;
        }
    }
    return 0;
}

public Action CMD_INFO(int client, int args)
{
    if(args > 0)
    {
        PrintToChat(client, "\x04[INFO] Usage: \x01/info or /infomenu");
    }
    Menu m_InfoMenu = new Menu(Info_Menu_Handler, MENU_ACTIONS_DEFAULT);
    m_InfoMenu.SetTitle("Surf'n'Turf Info Menu");
    m_InfoMenu.AddItem("OPT_DISCORD", "Discord Server");
    m_InfoMenu.AddItem("OPT_STEAM", "Steam Group");
    m_InfoMenu.AddItem("OPT_STAFF", "Current staff members");
    m_InfoMenu.AddItem("OPT_TAGS", "How to equip a tag");
    m_InfoMenu.AddItem("OPT_SURF", "How To Surf");
    m_InfoMenu.Display(client, MENU_TIME_FOREVER);
    return Plugin_Handled;
}
