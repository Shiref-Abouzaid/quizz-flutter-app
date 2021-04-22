import 'package:flutter/material.dart';
import './quize_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    
    return MaterialApp(
      
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {


  List<Icon> scoreKeeper = []; //list of icons

  //get all qustions objects
  QuizeBrain quizeBrain = new QuizeBrain(); 


  void answerQustion(bool answer) { //method to answer
    bool correct = quizeBrain.getAnswer();
    if(!quizeBrain.getIsLast()) {
      if(answer == correct) {//this is true
        scoreKeeper.add(
          Icon(
            Icons.check,
            size:25,
            color: Colors.green,
          )
        );
      } else { // this is false
        scoreKeeper.add(
          Icon(
            Icons.close,
            size:25,
            color: Colors.red,
          )
        );
      }
    } else {

      Alert(
        context: context,
        type: AlertType.success,
        title: "Finished",
        desc: "Thank You You have finished the quize.",
        buttons: [
          DialogButton(

            child: Text(
              "Ok",
              
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }


    //to increase number of qustion
    setState(() {
      quizeBrain.nextQustion();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizeBrain.getQustion(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green
                ),
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  
                  ),
                ),
                onPressed: () {
                  answerQustion(true);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red
                ),
                child: Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  answerQustion(false);


                },
              ),
            ),
          ),

          Row(
            children: scoreKeeper
          ),

        ],
      ),
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
