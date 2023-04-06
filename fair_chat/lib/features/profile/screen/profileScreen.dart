import 'package:agora_uikit/models/agora_rtm_mute_request.dart';
import 'package:fair_chat/models/liked_users.dart';
import 'package:fair_chat/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../common/widgets/loader.dart';
import '../../../models/chat_contact.dart';
import '../../../screens/mobile_chat_screen.dart';
import '../../chat/controller/chat_controller.dart';

class ProfilePage extends ConsumerStatefulWidget {
  static const String routeName = '/Profile-screen';
  UserModel udata;
  VoidCallback function;
  VoidCallback? call;
  VoidCallback? video;
  bool isme;
  ProfilePage(
      {required this.udata,
      required this.function,
      required this.isme,
      this.call,
      this.video});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  Widget _getButtoons() {
    if (widget.isme) {
      return ElevatedButton(
        onPressed: widget.function != null ? widget.function : () {},
        //padding: EdgeInsets.all(0.0),
        child: Material(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(50.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0), color: Colors.blue),
            child: Text(
              widget.isme ? "Edit" : "Message",
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else {
      return Row(
        children: [
          ElevatedButton(
            onPressed: widget.call,
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange,
              elevation: 0,
            ),
            //padding: EdgeInsets.all(0.0),
            child: Material(
              elevation: 5,
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.white),
                child: Icon(
                  Icons.call,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: widget.video,
            //padding: EdgeInsets.all(0.0),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange,
              elevation: 0,
            ),
            child: Material(
              elevation: 5,
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.white),
                child: Icon(
                  Icons.video_call,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: widget.function != null ? widget.function : () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.deepOrange,
              elevation: 0,
            ),
            //padding: EdgeInsets.all(0.0),
            child: Material(
              elevation: 5,
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.green),
                child: Text(
                  widget.isme ? "Edit" : "Message",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          elevation: 0,
        ),
        backgroundColor: Colors.deepOrange,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(widget.udata.profilePic),
                      //backgroundColor: Colors.red,
                    ),
                    Text(
                      widget.udata.name,
                      style: TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Pacifico',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.white.withOpacity(0.8),
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          widget.udata.phoneNumber,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            fontFamily: 'Source San Pro',
                            color: Colors.white.withOpacity(0.8),
                            letterSpacing: 2.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                      width: 150.0,
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    _getButtoons(),
                    SizedBox(
                      width: double.infinity,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50.0),
                          topLeft: Radius.circular(50.0)),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 50.0,
                        ),
                        CircularPercentIndicator(
                          radius: 70.0,
                          lineWidth: 10.0,
                          animation: true,
                          percent: widget.udata.percentage / 100,
                          center: new Text(
                            widget.udata.percentage.toString() + "%",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.deepOrange,
                          backgroundColor: Colors.grey.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          "TOXIC",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 20.0,
                          width: 30.0,
                          child: Divider(
                            color: Colors.grey.shade500,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "LOVE TODAY",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        StreamBuilder<List<ChatContact>>(
                            stream: ref
                                .watch(chatControllerProvider)
                                .likeContact(widget.udata.uid),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Loader();
                              }
                              if (!snapshot.hasData) {
                                print("Null");
                              }
                              print(
                                  "LENGTH" + snapshot.data!.length.toString());
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  var chatContactData = snapshot.data![index];
                                  print(chatContactData.name);

                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 8.0),
                                          child: ListTile(
                                            title: Text(
                                              chatContactData.name,
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            subtitle: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 6.0),
                                              child: Text(
                                                chatContactData.contactId,
                                                style: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                            ),
                                            leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                chatContactData.profilePic,
                                              ),
                                              radius: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
