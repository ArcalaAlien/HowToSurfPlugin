#include <sourcemod>

public Plugin:myinfo =
{
	name = "Speedometer",
	author = "Arcala the Gyiyg",
	description = "Plugin that displays a message to the player explaining how to surf.",
	version = "1.0.0",
	url = "https://github.com/ArcalaAlien/HowToSurfPlugin"
}

public void OnPluginStart()
{
    RegConsoleCmd("sm_howtosurf", CMD_HOWTOSURF, "[SM] Usage: /howtosurf");
    CreateTimer(120.0, Timer_Message, 3, TIMER_REPEAT | TIMER_FLAG_NO_MAPCHANGE);
}

public Action:CMD_HOWTOSURF(int client, int args)
{
    if(args > 0)
    {
        PrintToChat(client, "[SM] Usage: /howtosurf");
    }
    PrintToChat(client, "[HTS]: Imagine '◢◣' is a ramp");
    PrintToChat(client, "[HTS]: Hold your strafe keys depending on what side of the ramp you're on, D◢◣A Like so.");
    PrintToChat(client, "[HTS]: Then use the mouse to guide where you want to go.");

    return Plugin_Handled;
}

public Action Timer_Message(Handle timer, any data)
{
    PrintToChatAll("[HTS]: If you're new to surfing you can use /howtosurf to get a short tutorial!");
    return Plugin_Continue;
}