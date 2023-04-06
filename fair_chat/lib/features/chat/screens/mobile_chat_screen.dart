import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fair_chat/common/utils/colors.dart';
import 'package:fair_chat/common/widgets/loader.dart';
import 'package:fair_chat/features/auth/controller/auth_controller.dart';
import 'package:fair_chat/features/call/controller/call_controller.dart';
import 'package:fair_chat/features/call/screens/call_pickup_screen.dart';
import 'package:fair_chat/features/chat/widgets/bottom_chat_field.dart';
import 'package:fair_chat/models/user_model.dart';
import 'package:fair_chat/features/chat/widgets/chat_list.dart';
import 'package:fair_chat/features/profile/screen/profileScreen.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  //TODO modify here
  final bool isGroupChat = false;
  final String profilePic = "";
  const MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
    //this.isGroupChat,
    //this.profilePic,
  }) : super(key: key);

  void makeCall(WidgetRef ref, BuildContext context) {
    ref.read(callControllerProvider).makeCall(
          context,
          name,
          uid,
          profilePic,
          isGroupChat,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String phone = "";
    UserModel? userModel;
    return CallPickupScreen(
      scaffold: Scaffold(
        backgroundColor: Colors.white38.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: isGroupChat
              ? Text(name)
              : StreamBuilder<UserModel>(
                  stream: ref.read(authControllerProvider).userDataById(uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }
                    phone = snapshot.data!.phoneNumber;
                    userModel = snapshot.data!;
                    return Column(
                      children: [
                        Text(name),
                        Text(
                          snapshot.data!.isOnline ? 'online' : 'offline',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  }),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () => makeCall(ref, context),
              icon: const Icon(Icons.video_call),
            ),
            IconButton(
              onPressed: () {
                UrlLauncher.launch("tel://" + phone);
              },
              icon: const Icon(Icons.call),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, ProfilePage.routeName, arguments: {
                  'usermodel': userModel,
                  'isme': false,
                  'function': () {
                    Navigator.pop(context);
                  },
                  'call': () {
                    UrlLauncher.launch("tel://" + phone);
                  },
                  'video': () => makeCall(ref, context),
                });
              },
              icon: const Icon(Icons.info),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatList(
                recieverUserId: uid,
                isGroupChat: isGroupChat,
              ),
            ),
            BottomChatField(
              recieverUserId: uid,
              isGroupChat: isGroupChat,
            ),
          ],
        ),
      ),
    );
  }
}
