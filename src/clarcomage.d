/*
 * Copyright © 2011, 2014 GreatEmerald
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import std.stdio;
import std.string;
import arco;
import cards;

int main()
{
    int SelectedCard;
    string Discarding;
    bool CanPlayCard;
    bool Debug;

    InitArcomage(); //GE: We initialise the library first. Perhaps it will auto init later.
    /*FrontendFunctions.Sound_Play = function(SoundTypes){}; //GE: Init all the frontend functions. Frontends must do that, although I guess it could be in the library and then overridden.
    FrontendFunctions.RedrawScreenFull = function(){};
    FrontendFunctions.PrecacheCard = function(const char*, int){};*/
    FrontendFunctions.PlayCardAnimation = function(int CardPlace, char bDiscarded, char bSameTurn)
    {
        if (!bDiscarded)
        {
            writeln("> Player ", Turn, " just played ", Player[Turn].Hand[CardPlace].Name, " <");
            writeln("------------");
            writeln(Player[Turn].Hand[CardPlace].Description);
            writeln("------------");
            writefln("%s, %s/%s/%s", Player[Turn].Hand[CardPlace].Colour, Player[Turn].Hand[CardPlace].BrickCost, Player[Turn].Hand[CardPlace].GemCost, Player[Turn].Hand[CardPlace].RecruitCost);
            writeln("============");
        }
        else
        {
            writeln("> Player ", Turn, " just discarded ", Player[Turn].Hand[CardPlace].Name, " <");
            writeln("------------");
            writeln(Player[Turn].Hand[CardPlace].Description);
            writeln("------------");
            writefln("%s, %s/%s/%s", Player[Turn].Hand[CardPlace].Colour, Player[Turn].Hand[CardPlace].BrickCost, Player[Turn].Hand[CardPlace].GemCost, Player[Turn].Hand[CardPlace].RecruitCost);
            writeln("============");
        }
    };
    initGame();

    writeln("Welcome to CLArcomage, the Command Line Arcomage! This is the prerelease version, made entirely in D by GreatEmerald. Have a good game!");
    writeln("Would you like to have control of player no. 0? If not, it will be assigned to an AI.");
    readf(" ");
    Player[Turn].AI = !stringToBool(chomp(readln())); //GE: First player setup.
    writeln("Would you like to have control of player no. 1? If not, it will be assigned to an AI. If both are AIs, you will have a demo match. If both are players, you will have a hotseat game.");
    readf(" ");
    Player[GetEnemy()].AI = !stringToBool(chomp(readln())); //GE: First player setup.

    do
    {


        writeln("Current turn is: Player ", Turn); //GE: Print all the info about the game.
        if (!Player[Turn].AI && !Debug)
        {
            foreach(int i, CardInfo CI; Player[Turn].Hand)
            {
                writeln(i, ": ", CI.Name, ":");
                writeln("------------");
                writeln(CI.Description);
                writeln("------------");
                writefln("%s, %s/%s/%s", CI.Colour, CI.BrickCost, CI.GemCost, CI.RecruitCost);
                writeln("============");
            }
            writeln("Player ", GetEnemy(), " has the following resources:");
            writefln("| %s quarry and %s bricks", Player[GetEnemy()].Quarry, Player[GetEnemy()].Bricks);
            writefln("| %s magic and %s gems", Player[GetEnemy()].Magic, Player[GetEnemy()].Gems);
            writefln("| %s dungeon and %s recruits", Player[GetEnemy()].Dungeon, Player[GetEnemy()].Recruits);
            writefln("| %s tower and %s wall", Player[GetEnemy()].Tower, Player[GetEnemy()].Wall);
        }
        writeln("Player ", Turn, " has the following resources:");
        writefln("| %s quarry and %s bricks", Player[Turn].Quarry, Player[Turn].Bricks);
        writefln("| %s magic and %s gems", Player[Turn].Magic, Player[Turn].Gems);
        writefln("| %s dungeon and %s recruits", Player[Turn].Dungeon, Player[Turn].Recruits);
        writefln("| %s tower and %s wall", Player[Turn].Tower, Player[Turn].Wall);
        if (!Player[Turn].AI)
        {
            writeln("Select the card to use!");
            readf("%s", &SelectedCard);
            writeln("Would you like to discard this card?");
            readf(" ");//GE: Workaround of the silly D reading process.
            Discarding = chomp(readln());
            if (!stringToBool(Discarding) && !CanAffordCard(Player[Turn].Hand[SelectedCard], Turn))
            {
                writeln("This card is too expensive!");
                readln();
                continue;
            }
            CanPlayCard = PlayCard(SelectedCard, stringToBool(Discarding));
            if (!CanPlayCard)
            {
                writeln("You are prevented from using that card! It's either cursed or you're in a discard round.");
                readln();
            }
        }
        else
            AIPlay();
        if (IsVictorious(Turn) || IsVictorious(GetEnemy()))
        {
            writeln(">>> Player ", GetEnemy(), " is victorious! <<<"); //GE: After PlayCard() the turn is already over
            break;
        }
        writeln("Now it's Player ", Turn, " turn. Press Return to continue.");
        if (Discarding == "debug") //GE: Cheat codes yay!
            Debug = true;
        readln();
    } while (Discarding != "quit");
    writeln("The match is over! To start a new one, restart the application.");
    writeln("CLArcomage is copyright (c) GreatEmerald, 2011, 2014, under the GPL license.");
    readln();
    return 0;
}

bool stringToBool(string Source)
{
    switch (Source)
    {
         case "Yes":
         case "yes":
         case "y":
         case "True":
         case "true":
         case "1":
            return true;
        default:
            return false;
    }
}
