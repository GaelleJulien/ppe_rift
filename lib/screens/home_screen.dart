import 'dart:async';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppe_rift_test/main.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  List<List<dynamic>> _data = [];


  // This function is triggered when the floating button is pressed
  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/routesTriees.csv");
    List<List<dynamic>> _listData =
    const CsvToListConverter().convert(_rawData);
    setState(() {
      _data = _listData;
    });
  }

  void _search(String enteredKeyword) async {
    final _rawData = await rootBundle.loadString("assets/routesTriees.csv");
    List<List<dynamic>> _listData =
    const CsvToListConverter().convert(_rawData);
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      _data = _listData;
    } else {
      _data = _listData
          .where((_data) =>
          _data[1].toString().toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _data = _listData;
    });
  }


  @override
  Widget build(BuildContext context) {
    _loadCSV();
    String search = "";
    return Scaffold(
      appBar: AppBar(
        title: const Center (child : Text ('Bip Boup')),
      ),

      bottomSheet : TextField(
        onChanged: (value) => search = value,
        decoration: const InputDecoration(
            labelText: 'Chercher une ligne',
            suffixIcon: Icon(Icons.search)),
      ),

      // Display the contents from the CSV file
      body:
      ListView.builder(
        itemCount: _data.length,
        itemBuilder: (_, index) {
          return Card(
            margin: const EdgeInsets.all(3),
            color: index == 0 ? Colors.white54 : Colors.white,
            child: ListTile(
              leading: Text(_data[index][0].toString()),
              title: Text(_data[index][1]
              ),
              trailing: Text(_data[index][2]),
            ),
          );
        },
      ),


      extendBody: true,
      bottomNavigationBar: const BottomNavBarRaisedInsetFb1(),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen ({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title : const Center (child : Text ('Bip Boup')),


      ),
      body: const Center(child: Text("placeholder"),),

      extendBody: true,
      bottomNavigationBar: const BottomNavBarRaisedInsetFb1(),

    );


  }
}

class BottomNavBarRaisedInsetFb1 extends StatefulWidget {
  const BottomNavBarRaisedInsetFb1({Key? key}) : super(key: key);

  @override
  _BottomNavBarRaisedInsetFb1State createState() => _BottomNavBarRaisedInsetFb1State();
}

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}
class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Page 2'),
          backgroundColor: Colors.blueAccent),
      body: Center(
        child: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage()));
        }
        ),
      ),
    );
  }
}

class _BottomNavBarRaisedInsetFb1State extends State<BottomNavBarRaisedInsetFb1> {

  //- - - - - - - - - instructions - - - - - - - - - - - - - - - - - -
  // WARNING! MUST ADD extendBody: true; TO CONTAINING SCAFFOLD
  //
  // Instructions:
  //
  // add this widget to the bottomNavigationBar property of a Scaffold, along with
  // setting the extendBody parameter to true i.e:
  //
  // Scaffold(
  //  extendBody: true,
  //  bottomNavigationBar: BottomNavBarRaisedInsetFb1()
  // )
  //
  // Properties such as color and height can be set by changing the properties at the top of the build method
  //
  // For help implementing this in a real app, watch https://www.youtube.com/watch?v=C0_3w0kd0nc. The style is different, but connecting it to navigation is the same.
  //
  //- - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - -

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = 56;

    final primaryColor = Color.fromARGB(255, 255, 23, 33);
    final secondaryColor = Colors.black54;
    final accentColor = const Color(0xffffffff);
    final backgroundColor = Colors.white;

    final shadowColor = Colors.grey; //color of Navbar shadow
    double elevation = 100; //Elevation of the bottom Navbar

    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, height),
            painter: BottomNavCurvePainter(backgroundColor: backgroundColor, shadowColor: shadowColor, elevation: elevation),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
                backgroundColor: primaryColor,
                child: Icon(Icons.map),
                elevation: 0.1,
                onPressed: () {}),
          ),
          Container(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavBarIcon(
                  text: "Home",
                  icon: Icons.home_outlined,
                  selected: false,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Screen2()));
                  },
                  defaultColor: secondaryColor,
                  selectedColor: primaryColor,
                ),
                NavBarIcon(
                  text: "Search",
                  icon: Icons.search_outlined,
                  selected: true,
                  onPressed: () {},
                  defaultColor: secondaryColor,
                  selectedColor: primaryColor,
                ),
                SizedBox(width: 56),
                NavBarIcon(
                    text: "Cart",
                    icon: Icons.emoji_transportation,
                    selected: false,
                    onPressed: () {},
                    defaultColor: secondaryColor,
                    selectedColor: primaryColor),
                NavBarIcon(
                  text: "Calendar",
                  icon: Icons.date_range_outlined,
                  selected: false,
                  onPressed: () {},
                  selectedColor: primaryColor,
                  defaultColor: secondaryColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavCurvePainter extends CustomPainter {
  BottomNavCurvePainter({this.backgroundColor = Colors.white, this.insetRadius = 38, this.shadowColor = Colors.grey, this.elevation = 100});

  Color backgroundColor;
  Color shadowColor;
  double elevation;
  double insetRadius;
  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    Path path = Path();

    double insetCurveBeginnningX = size.width / 2 - insetRadius;
    double insetCurveEndX = size.width / 2 + insetRadius;

    path.lineTo(insetCurveBeginnningX, 0);
    path.arcToPoint(Offset(insetCurveEndX, 0),
        radius: Radius.circular(41), clockwise: true);

    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height + 56);
    path.lineTo(
        0,
        size.height +
            56); //+56 here extends the navbar below app bar to include extra space on some screens (iphone 11)
    canvas.drawShadow(path, shadowColor, elevation, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class NavBarIcon extends StatelessWidget {
  const NavBarIcon(
      {Key? key,
        required this.text,
        required this.icon,
        required this.selected,
        required this.onPressed,
        this.selectedColor = const Color(0xffFF8527),
        this.defaultColor = Colors.black54})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  final Color defaultColor;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? selectedColor : defaultColor,
          ),
        ),
      ],
    );
  }
}
