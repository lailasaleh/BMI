import 'package:bmi_app/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMale = true;
  double heightVal = 170;
  int weight = 55;
  int age = 18;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Body Mass Index"),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Center(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      genderCard(context, 'male'),
                      SizedBox(
                        width: 15,
                      ),
                      genderCard(context, 'female'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      heightCard(context, 'weight'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      weightAgeCard(context, 'weight'),
                      SizedBox(
                        width: 15,
                      ),
                      weightAgeCard(context, 'age'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(8)),
                    child: TextButton(
                        onPressed: () {
                          var result = weight / pow(heightVal / 100, 2);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Result(
                                      result: result,
                                      isMale: isMale,
                                      age: age)));
                        },
                        child: Text(
                          "Calculate",
                          style: Theme.of(context).textTheme.headline2,
                        ))),
              )
            ],
          ),
        )));
  }

  Expanded genderCard(BuildContext context, String type) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            type == 'male' ? isMale = true : isMale = false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: ((isMale == true && type == 'male') ||
                    (isMale == false && type == 'female'))
                ? Colors.teal
                : Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(type == 'male' ? Icons.male : Icons.female),
              SizedBox(
                height: 20,
              ),
              Text(
                type == 'male' ? 'Male' : 'Female',
                style: Theme.of(context).textTheme.headline2,
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded heightCard(BuildContext context, String type) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Height",
              style: Theme.of(context).textTheme.headline2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  heightVal.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  "CM",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
            Slider(
                min: 90,
                max: 220,
                value: heightVal,
                onChanged: (newVal) {
                  setState(() {
                    heightVal = newVal;
                  });
                })
          ],
        ),
      ),
    );
  }

  Expanded weightAgeCard(BuildContext context, String type) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              type == 'weight' ? 'Weight' : 'Age',
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              type == 'weight' ? '$weight' : '$age',
              style: Theme.of(context).textTheme.headline1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      type == 'weight' ? weight-- : age--;
                    });
                  },
                  child: Icon(Icons.remove),
                  mini: true,
                  heroTag: type == 'weight' ? 'removeWeigth' : 'removeAge',
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      type == 'weight' ? weight++ : age++;
                    });
                  },
                  child: Icon(Icons.add),
                  mini: true,
                  heroTag: type == 'weight' ? 'addWeight' : 'addAge',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
