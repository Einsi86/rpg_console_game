//Help og GameStartText geymdir hér til þess að sækja

void help () {
  print('''
S = start game
Q = quit game

Look around = Look around in the current room to see what direction
you can go and to find objects to interact with.

Pick up "item name" = Pick up an item and add to inventory.

Read "item name" = Read an item in inventory.

open "item name" = open an item in inventory.

break "item name" = break an item.

map = open a map if available.

N = go north
S = go south
E = go east
W = go west

''');
}

void gameStartText () {
  print('''
  Explore the Creepy Mansion to find a way out.
  
  Enter "s" to start the game.
  Enter "h" for at any point for a list of commands.
  Enter "q" to quit the game.''');
}

