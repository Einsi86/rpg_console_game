
import 'dart:io';
import 'dart:math';
import 'player.dart';
import 'descriptions.dart';
import 'ascii.dart';

/*
Classi fyrir öll herbergin.
Mismunandi lýsingar á herbergi eftir því hvort maður sé þar í fyrsta skipti,
hefur verið þar áður eða notar look around skipunina.
4 áttir notaðar til að setja upp hvaða herbergi liggja við hvort annað.
bool rofi til að merkja herbergið eftir hvort maður hafi verið áður eða ekki.
*/

class Room  {

  int id;
  String name;
  String initialDescription;
  String beenBeforeDescription;
  String lookAroundDescription;
  int north;
  int south;
  int east;
  int west;
  String item;
  bool roomEnteredBefore = false;
  bool firstTimeInRoom;
  String itemToAccess;

  Room(this.id, this.name, this.initialDescription, this.beenBeforeDescription,
      this.lookAroundDescription, this.north, this.south, this.east, this.west,
      this.item, this.roomEnteredBefore, this.firstTimeInRoom, this.itemToAccess);


//Function til að accessa læsta herbergið ef maður er með lykilinn.

  bool playerCanAccess (Player player, Room nextRoom) {
    if(player.inventory.contains(nextRoom.itemToAccess)) {
      return true;
    } else {
      return false;
    }
  }


}


class GameEngine {
  String input;
  List<Room> listOfRooms = [];
  Player player = Player();

  GameEngine(){

    //Öll herbergin definuð

    Room emptyRoom = Room(
        0,
        'emptyRoom',
        'You wake up in an empty room',
        'You are in the empty room',
        'The room is windowless and empty with only an old lamp providing a small bit of light. '
            '\nThere is a door to the north',
        1,
        null,
        null,
        null,
        'map',
        false,
        true,
        null);
    Room hallway = Room(
        1,
        'hallway',
        'You enter a hallway',
        'You are in the hallway',
        'There are doors to the north, south, west and east',
        4,
        0,
        2,
        3,
        'vase',
        false,
        true,
        null);
    Room kitchen = Room(
        2,
        'kitchen',
        'You enter a kitchen',
        'You are in the kitchen',
        'The kitchen looks like it has not been in use for a long time. No food or cookware. \nThere are doors to the south and west',
        null,
        5,
        null,
        1,
        null,
        false,
        true,
        null);
    Room livingRoom = Room(
        3,
        'livingRoom',
        'You enter a large living room',
        'You are in the large living room',
        'The Living room is quite large with some dusty old furniture. \nThere is a door to the east',
        null,
        null,
        1,
        null,
        'book',
        false,
        true,
        null);
    Room strangeRoom = Room(
        4,
        'strangeRoom',
        'You enter a strange room',
        'You are in the strange room',
        'empty \n There is a door to the south and what looks like a dark tunnel to the north',
        null,
        1,
        null,
        null,
        null,
        false,
        true,
        'key');
    Room pantry = Room(
        5,
        'pantry',
        'You enter a pantry',
        'You are in the pantry',
        'The pantry is not very big. It is mostly empty. \nThere is a door to the north',
        2,
        null,
        null,
        null,
        'small box',
        false,
        true,
        null);

    /*Herbergjunum addað í lista sem er svo notaður þegar er navigateað. S.s leitað
      af room id í listOfRooms til þess að sjá hvort það sé herbergi í áttina sem er
      reynt að fara í.*/

    listOfRooms.add(emptyRoom);
    listOfRooms.add(hallway);
    listOfRooms.add(kitchen);
    listOfRooms.add(livingRoom);
    listOfRooms.add(strangeRoom);
    listOfRooms.add(pantry);

    //Byrjunarstaðsetning á player

    player.location = emptyRoom;
    player.gameRunning = true;

  }

  /*Sennilega óþarfi, en bara til þess að aðeins fleirri orð virki fyrir skipanir.
    annars er alltaf hægt að opna help og sjá hvaða skipanir eru í boði*/
  String inputTranslator (String input) {

    input = input.replaceAll('get', 'pick up');
    input = input.replaceAll('take', 'pick up');

    input = input.replaceAll('smash', 'break');
    input = input.replaceAll('kick', 'break');
    input = input.replaceAll('hit', 'break');

    input = input.replaceAll('open map', 'map');
    input = input.replaceAll('look at map', 'map');
    input = input.replaceAll('see map', 'map');

    input = input.replaceAll('north', 'n');
    input = input.replaceAll('south', 's');
    input = input.replaceAll('west', 'w');
    input = input.replaceAll('east', 'e');

    input = input.replaceAll('help', 'h');
    return input;
  }

  //sýnir ASCII með nafninu á leiknum og start, help, quit möguleika.

  void splash() {


    do {input = stdin.readLineSync().toLowerCase();

    if(input == 's') {
      start();
    } else if(input == 'q') {
      print('Thank you for playing Creepy Mansion!');
    }
    else if(input == 'h') {
      help();

    } else {
      print('Enter a valid command');
    }
    } while(input != 'q');

  }

  void start() {


    while (player.gameRunning) {

      /*Check fyrir hvort player sé í fyrsta skipti í herbergi eða ekki.
      prentar bara room descriptionið ef áttirnar eru notaðar(en ekki ef t.d
      map eða inventory er opnað)*/

      if(input == 'n' || input == 's' || input == 'w' || input == 'e') {
        if (player.location.firstTimeInRoom) {
          print(player.location.initialDescription);
          player.location.firstTimeInRoom = false;
        } else if (player.location.roomEnteredBefore &&
            !player.location.firstTimeInRoom) {
          print(player.location.beenBeforeDescription);
        } else {
          print(player.location.beenBeforeDescription);
        }
      }
      print ('What do you want to do? \n');
      input = stdin.readLineSync().toLowerCase();
      input = inputTranslator(input);


      //opnar map ef búið er að ná í það

    if(input == 'map') {
      if(player.inventory.contains('map')) {
        map();
      } else {
        print('You do not have a map');
      }
    }

    //Bara yrir loka exit. Þarf flashlight til þess að geta komist út.

    if(input == 'n' && player.location.id == 4) {
      if(player.inventory.contains('flashlight')) {
        print('You enter the dark tunnel. You see nothing so you use the flashlight you found.');
        print('After a while navigating the tunnel, you find your way out!');
        print('Thank you for playing Creepy Mansion!');
        stdin.readLineSync();
        exit(0);
      } else {
        print('The tunnel is too dark to navigate. Maybe you can find something to light the way');
      }
    }

    //Quit með yes, no og maybe með random breytu svona bara afþví bara :P

    if(input == 'q') {
      print('Are you sure you want to quit?');
      print('y = yes, n = no, m = maybe');
      String quit = stdin.readLineSync();
      if(quit == 'y') {
        exit(0);
      } else if(quit == 'n') {
        break;
      } else if(quit == 'm') {
        Random random = Random();
        int r = random.nextInt(100);
        if(r < 50) {
          exit(0);
        }

      }
    }

    //Help textinn

    if(input == 'h') {
      help();
    }

    //Hardcoded til að brjóta vasann sem droppar vasaljósinu.

      if(input == 'break vase') {
        if(player.location.item == 'vase') {
          print('You kick the vase so it falls down and breaks. You notice something falling out of the broken vase');
          player.location.item = 'flashlight';
        } else {
          print('There is no vase');
        }
      }

    //Hardcoded til að opna boxið með combination úr bók í öðru herbergi. droppar lykli.

    if(input == 'open small box') {
      if(player.inventory.contains('small box')) {
        print('The small box has a 3-digit combination lock');
        print('Enter 3 digits to open:');
        String combination = stdin.readLineSync();
        if (combination == '246') {
          print('This combination is right');
          print('The small box starts to glow and then disintegrates and something falls to the ground. Better look at what it is');
          player.inventory.remove('small box');
          player.location.item = 'key';
        } else {
          print('This combination is wrong');
        }
      } else {
        print('There is no small box');
      }
    }

    //Hardcoded til að lesa bókina

    if (input == 'read book') {
      if(player.inventory.contains('book')) {
        print('The book only contains 3 sentences \n');
        print('First  : More than one, less than three.');
        print('Second : Half of eight.');
        print('Third  : Add first and the second.');
      } else {
        print('You do not have a book');
    }
    }

    /*look around sem prentar bæði viðeigandi lýsingu fyrir það herbergi sem maður
      er í og og hvaða hlutur er í herberginu*/

    if (input == 'look around') {
      print(player.location.lookAroundDescription);
      if(player.location.item != null) {
        print('You see a ${player.location.item}');
      }
    }

    /* north, south, east, west sem leitar í listOfRooms af Room.id í Room classanum
      hvort það sé herbergi í áttina sem er reynt að fara í.
      Setti bara í 'north' checkið fyrir læstu hurðina því það á bara við einusinni
      og í þá átt, en mætti allveg vera inn í hinum áttunum líka*/

    if (input == 'n') {
      if (player.location.north != null) {
        Room nextRoom = listOfRooms.singleWhere((Room) =>
        Room.id == player.location.north);
        if (nextRoom.itemToAccess == null) {
          player.location = nextRoom;
        } else if (nextRoom.playerCanAccess(player, nextRoom)) {
          print('You use the ${nextRoom.itemToAccess} to access the room');
          player.location = nextRoom;
        } else {
          print('You need a ${nextRoom.itemToAccess} to access this room');
        }
        //   }
      } else {
        print('You can not go this direction');
      }
    }

    if (input == 's') {
      if (player.location.south != null) {
        Room nextRoom = listOfRooms.singleWhere((Room) =>
        Room.id == player.location.south);
        player.location = nextRoom;
      } else {
        print('You can not go this direction');
      }
    }

    if (input == 'w') {
      if (player.location.west != null) {
        Room nextRoom = listOfRooms.singleWhere((Room) =>
        Room.id == player.location.west);
        player.location = nextRoom;
      } else {
        print('You can not go this direction');
      }
    }

    if (input == 'e') {
      if (player.location.east != null) {
        Room nextRoom = listOfRooms.singleWhere((Room) =>
        Room.id == player.location.east);
        player.location = nextRoom;
      } else {
        print('You can not go this direction');
      }
    }

    //Pick up skipun sem bætir hlut í inventory og removar úr herberginu.

    if (input == 'pick up ${player.location.item}') {
      String itemName = player.location.item;
      if (player.location.item == itemName) {
        player.location.item = null;
        player.inventory.add(itemName);
        print('You pick up the $itemName');
      }
    } else if (input.contains('pick up')) {
        print('There is no ${input.replaceAll('pick up', '')}');
    }

    //Opnar inventory, nema það sé tómt.

    if (input == 'i') {
      if (!player.inventory.isNotEmpty) {
        print(player.inventory);
      } else {
        print('Your inventory is empty');
      }
    }
  }
  }
}
