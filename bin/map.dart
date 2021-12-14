
import 'player.dart';


class Room  {

  int id;
  String name;
  String initialDescription;
  //String beenBeforeDescription;
  //String lookAroundDescription;
  int north;
  int south;
  int east;
  int west;
  String item;


  Room(this.id, this.name, this.initialDescription, /*this.beenBeforeDescription,
      this.lookAroundDescription*/ this.north, this.south, this.east, this.west, this.item);


}


// List<Room> mapInitialize (rooms) {
//
//   Room forest = Room(0, 'forest', 'You wake up in a dark forest', 1, null, null, null, null);
//   Room house = Room(1, 'house', 'You enter a house', 4, 0, 2, 3, 'armor');
//   Room pond = Room(2, 'pond', 'You enter a pond', null, null, null, 1, 'sword');
//   Room garden = Room(3, 'garden', 'You enter a garden', null, null, 1, null, 'banana');
//   Room bridge = Room(4, 'bridge', 'You enter a bridge', null, 1, null, null, 'key');
//
//   List<Room> listOfRooms = [];
//   listOfRooms.add(forest);
//   listOfRooms.add(house);
//   listOfRooms.add(pond);
//   listOfRooms.add(garden);
//   listOfRooms.add(bridge);
//
//   Player.location = forest;
//   Player.gameRunning = true;
//
// }

