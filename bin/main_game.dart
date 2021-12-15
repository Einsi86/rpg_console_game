

import 'dart:io';
import 'map.dart';
import 'player.dart';




void main(List<String> arguments) {

    Room emptyRoom = Room(0, 'Empty room', 'You wake up in a dark empty room', 1, null, null, null, null);
    Room house = Room(1, 'house', 'You enter a house', 4, 0, 2, 3, 'armor');
    Room pond = Room(2, 'pond', 'You enter a pond', null, null, null, 1, 'sword');
    Room garden = Room(3, 'garden', 'You enter a garden', null, null, 1, null, 'banana');
    Room bridge = Room(4, 'bridge', 'You enter a bridge', null, 1, null, null, 'key');

    List<Room> listOfRooms = [];
    listOfRooms.add(emptyRoom);
    listOfRooms.add(house);
    listOfRooms.add(pond);
    listOfRooms.add(garden);
    listOfRooms.add(bridge);

    Player.location = emptyRoom;
    Player.gameRunning = true;
    Player.firstTimeRunning = true;


  while(Player.gameRunning) {

      if(Player.firstTimeRunning) {
          print(Player.location.initialDescription);
          print('What do you want to do?');
      }
      String input = stdin.readLineSync();

      if (input.toLowerCase() == 'n') {
          if (Player.location.north != null) {
              Room nextRoom = listOfRooms.singleWhere((Room) =>
              Room.id == Player.location.north);
              Player.location = nextRoom;
          } else {
              print('You can not go this direction');
          }
      }

      if (input.toLowerCase() == 's') {
          if (Player.location.south != null) {
              Room nextRoom = listOfRooms.singleWhere((Room) =>
              Room.id == Player.location.south);
              Player.location = nextRoom;
          } else {
              print('You can not go this direction');
          }
      }

      if (input.toLowerCase() == 'w') {
          if (Player.location.west != null) {
              Room nextRoom = listOfRooms.singleWhere((Room) =>
              Room.id == Player.location.west);
              Player.location = nextRoom;
          } else {
              print('You can not go this direction');
          }
      }

      if (input.toLowerCase() == 'e') {
          if (Player.location.east != null) {
              Room nextRoom = listOfRooms.singleWhere((Room) =>
              Room.id == Player.location.east);
              Player.location = nextRoom;
          } else {
              print('You can not go this direction');
          }
      }

      if (input.contains('get'.toLowerCase())) {
          String itemName = input.replaceAll('get', '');
          itemName = itemName.trim();
          if (Player.location.item == itemName) {
              Player.location.item = null;
              Player.inventory.add(itemName);
              print('You pick up the $itemName');
          } else {
              print('There is no $itemName');
          }
      }

      if (input.toLowerCase() == 'i') {
          print(Player.inventory);
          if(!Player.inventory.isEmpty) {
              if (Player.inventory.first == 'armor') {
                  print(' i can use the armor');
              } }
           else {
              print('did not work');
          }
      }

  }
  }