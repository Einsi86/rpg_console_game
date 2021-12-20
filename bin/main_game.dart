
import 'map.dart';
import 'descriptions.dart';
import 'ascii.dart';



void main(List<String> arguments) {

  splashScreen();               //prentar ASCII leikjanafnið
  gameStartText();              //prentar textann undir ASCii
  GameEngine ge = GameEngine(); //instance af GameEngine
  ge.splash();                  //startar splash hlutanum af GameEngine

}
