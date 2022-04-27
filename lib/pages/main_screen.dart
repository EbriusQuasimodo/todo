import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[200],
        appBar: AppBar(
          backgroundColor: Colors.brown[600],
          title: Text('Типо ежедневник',
            style: TextStyle(
              fontFamily: 'Avant Garde',
              fontSize: 25,
          ),),
          centerTitle: true,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green[600],
                    //minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/todo');
                    },
                  child: Text('Список дел', style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Avant Garde',
                  ),),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green[600],
                    //minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/shoppingFood');
                    },
                  child: Text('Список покупок (еда)', style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Avant Garde',
                  ),),
                ),
              ],
            ),
          ],
        ),
    );
  }
}
