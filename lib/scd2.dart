import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Scroller(screenHeight: screenHeight, screenWidth: screenWidth),
    );
  }
}

class Scroller extends StatefulWidget {
  double screenWidth;
  double screenHeight;

  Scroller({required this.screenHeight, required this.screenWidth});

  @override
  State<Scroller> createState() => _ScrollerState();
}

class _ScrollerState extends State<Scroller> {
  ScrollPhysics stop = NeverScrollableScrollPhysics();
  ScrollPhysics move = ScrollPhysics();

  ScrollController mainScroller = ScrollController();
  List<ScrollController> subScroller = [
    ScrollController(),
    ScrollController(),
    ScrollController()
  ];

  ScrollController horizantalScroll = ScrollController();

  double mainScrollerRead = 0;
  double _mainScrollerRead = 0;
  List<double> subScrollerRead = [0, 0, 0];
  List<double> _subScrollerRead = [0, 0, 0];

  int scrollTurn = 0;

  // mainScroller.positions.last.pixels

  late Image image1;
  late Image image2;
  late Image image3;
  late Image image4;
  late Image image5;

  double total = 0;
  double _total = 0;

  void fun() {
    print('totoal$total');
    print('_total$_total');
    print('turn$scrollTurn');
    print(mainScroller.position.maxScrollExtent);
    print(subScroller[0].position.maxScrollExtent);
    print(subScroller[1].position.maxScrollExtent);
    print(subScroller[2].position.maxScrollExtent);

    if (total - _total >= 0) {
      if (total >
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent / 2 -
                  20 &&
          total <
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent / 2 +
                  20)
        mainScroller.jumpTo(mainScroller.position.maxScrollExtent / 2);
      else if (total >
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent +
                  subScroller[1].position.maxScrollExtent -
                  20 &&
          total <
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent +
                  subScroller[1].position.maxScrollExtent +
                  20) {
        mainScroller.jumpTo(mainScroller.position.maxScrollExtent);
      }
      /////////////////////////////////////////////

      if (total >= 0 && total < subScroller[0].position.maxScrollExtent)
        setState(() {
          scrollTurn = 0;
        });
      else if (total >= subScroller[0].position.maxScrollExtent &&
          total <
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent / 2)
        setState(() {
          scrollTurn = 10;
        });
      else if (total >=
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent / 2 &&
          total <
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent / 2 +
                  subScroller[1].position.maxScrollExtent)
        setState(() {
          scrollTurn = 1;
        });
      else if (total >=
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent / 2 +
                  subScroller[1].position.maxScrollExtent &&
          total <
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent +
                  subScroller[1].position.maxScrollExtent)
        setState(() {
          scrollTurn = 10;
        });
      else if (total >=
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent +
                  subScroller[1].position.maxScrollExtent &&
          total <
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent +
                  subScroller[1].position.maxScrollExtent +
                  subScroller[2].position.maxScrollExtent)
        setState(() {
          scrollTurn = 2;
        });
      else
        print('error');
    }

    if (total - _total < 0) {
      if (total > mainScroller.position.maxScrollExtent / 2 - 20 &&
          total < mainScroller.position.maxScrollExtent / 2 + 20)
        mainScroller.jumpTo(0);
      else if (total > mainScroller.position.maxScrollExtent - 20 &&
          total < mainScroller.position.maxScrollExtent + 20) {
        mainScroller.jumpTo(mainScroller.position.maxScrollExtent / 2);
      }
      /////////////////////////////////////////////////////////////////
      if (total > 0 && total <= subScroller[0].position.maxScrollExtent)
        setState(() {
          scrollTurn = 0;
        });
      else if (total > subScroller[0].position.maxScrollExtent &&
          total <=
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent / 2)
        setState(() {
          scrollTurn = 10;
        });
      else if (total >
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent / 2 &&
          total <=
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent / 2 +
                  subScroller[1].position.maxScrollExtent)
        setState(() {
          scrollTurn = 1;
        });
      else if (total >
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent / 2 +
                  subScroller[1].position.maxScrollExtent &&
          total <=
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent +
                  subScroller[1].position.maxScrollExtent)
        setState(() {
          scrollTurn = 10;
        });
      else if (total >
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent +
                  subScroller[1].position.maxScrollExtent &&
          total <=
              subScroller[0].position.maxScrollExtent +
                  mainScroller.position.maxScrollExtent +
                  subScroller[1].position.maxScrollExtent +
                  subScroller[2].position.maxScrollExtent)
        setState(() {
          scrollTurn = 2;
        });
      else
        print('error2');
    }
  }

  void scrollsRead() {
    mainScroller.addListener(() {
      setState(() {
        _mainScrollerRead = mainScrollerRead;
        mainScrollerRead = mainScroller.positions.last.pixels;
        _total = total;
        total += mainScrollerRead - _mainScrollerRead;
      });
      fun();
    });
    subScroller[0].addListener(() {
      setState(() {
        _subScrollerRead[0] = subScrollerRead[0];
        subScrollerRead[0] = subScroller[0].positions.last.pixels;
        _total = total;
        total += subScrollerRead[0] - _subScrollerRead[0];
      });
      fun();
    });
    subScroller[1].addListener(() {
      setState(() {
        _subScrollerRead[1] = subScrollerRead[1];
        subScrollerRead[1] = subScroller[1].positions.last.pixels;
        horizantalScroll.jumpTo(subScroller[1].positions.last.pixels * 2);
        _total = total;
        total += subScrollerRead[1] - _subScrollerRead[1];
      });
      fun();
    });
    subScroller[2].addListener(() {
      setState(() {
        _subScrollerRead[2] = subScrollerRead[2];
        subScrollerRead[2] = subScroller[2].positions.last.pixels;
        _total = total;
        total += subScrollerRead[2] - _subScrollerRead[2];
      });
      fun();
    });
  }

  @override
  void initState() {
    scrollsRead();

    super.initState();

    image1 = Image.asset("images/fstPage.jpg");
    image2 = Image.asset("images/scdPage.jpg");
    image3 = Image.asset("images/thirdPage.jpg");
    image4 = Image.asset("images/g3.png");
    image5 = Image.asset("images/g4.png");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(image1.image, context);
    precacheImage(image2.image, context);
    precacheImage(image3.image, context);
    precacheImage(image4.image, context);
    precacheImage(image5.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            cacheExtent: 500000,
            controller: mainScroller,
            physics: scrollTurn == 10
                ? ScrollPhysics()
                : NeverScrollableScrollPhysics(),
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image5.image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Opacity(
                  opacity: min(total / 1000, 0.9),
                  child: Container(
                    width: widget.screenWidth,
                    height: widget.screenHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: image4.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            controller: subScroller[0],
                            physics: scrollTurn == 0
                                ? ScrollPhysics()
                                : NeverScrollableScrollPhysics(),
                            children: [
                              Container(
                                height: widget.screenHeight,
                              ),
                              Container(
                                height: widget.screenHeight,
                                child: Center(
                                  child: Text(
                                    "An Easier Life For\nThe Blind",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 120,
                                        fontFamily: 'test1',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 1000,
                    child: ListView(
                      controller: horizantalScroll,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          height: widget.screenHeight,
                          width: widget.screenWidth,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: image1.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: widget.screenHeight,
                          width: widget.screenWidth,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: image2.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: widget.screenWidth,
                    height: widget.screenHeight,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            controller: subScroller[1],
                            physics: scrollTurn == 1
                                ? ScrollPhysics()
                                : NeverScrollableScrollPhysics(),
                            children: [
                              Container(
                                height: widget.screenHeight,
                              ),
                              Container(
                                height: widget.screenHeight,
                                child: Center(
                                  child: Text(
                                    "Reading Anywhere,\nAnytime",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 120,
                                        fontFamily: 'test1',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: widget.screenWidth,
                height: widget.screenHeight,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: image3.image,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    ListView(
                      controller: subScroller[2],
                      physics: scrollTurn == 2
                          ? ScrollPhysics()
                          : NeverScrollableScrollPhysics(),
                      children: [
                        Container(
                          height: widget.screenHeight,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Image(
                                image: AssetImage('images/screen.png'),
                                height: 400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 50.0, left: 220.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Image(
                                    image: AssetImage('images/iphone.png'),
                                    height: 200,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 300),
                                  Image(
                                    image: AssetImage('images/labtob.png'),
                                    height: 200,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image(
                          image: AssetImage('images/boook.png'),
                          height: 400,
                        ),
                      ],
                    ),
                    Container(
                      height: widget.screenHeight,
                      child: Center(
                        child: Text(
                          "Anything",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 120,
                              fontFamily: 'test1',
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 80,
                  child: Row(
                    children: [
                      Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // color: Color(0xffBDBCBF).withOpacity(0.3),
                          ),
                          child: Center(
                              child: Image(
                            image: AssetImage('images/logo.png'),
                            width: 110,
                          )))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Button(
                      onPress: () {},
                      text: "Light",
                    ),
                    Button(
                      onPress: () {},
                      text: "Air",
                    ),
                    Button(
                      onPress: () {},
                      text: "Nebula",
                    ),
                    Button(
                      onPress: () {},
                      text: "Developer",
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xffBDBCBF).withOpacity(0.5),
                            ),
                            child: Icon(
                              Icons.account_circle_outlined,
                              color: Colors.white,
                              size: 20,
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xffBDBCBF).withOpacity(0.5),
                            ),
                            child: Icon(
                              Icons.translate_rounded,
                              color: Colors.white,
                              size: 20,
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  Function() onPress;
  String text;

  Button({required this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xffBDBCBF).withOpacity(0.5),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
