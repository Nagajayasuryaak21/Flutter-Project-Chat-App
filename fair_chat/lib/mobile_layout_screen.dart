import 'dart:io';
import 'package:fair_chat/features/auth/repository/auth_repository.dart';
import 'package:fair_chat/features/auth/screens/user_information_screen.dart';
import 'package:fair_chat/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fair_chat/common/utils/colors.dart';
import 'package:fair_chat/common/utils/utils.dart';
import 'package:fair_chat/features/auth/controller/auth_controller.dart';
import 'package:fair_chat/features/group/screens/create_group_screen.dart';
import 'package:fair_chat/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:fair_chat/features/chat/widgets/contacts_list.dart';
import 'package:fair_chat/features/status/screens/confirm_status_screen.dart';
import 'package:fair_chat/features/status/screens/status_contacts_screen.dart';
import 'package:fair_chat/features/profile/screen/profileScreen.dart';
import 'features/landing/screens/landing_screen.dart';

class MobileLayoutScreen extends ConsumerStatefulWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabBarController;
  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addObserver(this);
    ref.read(authControllerProvider).setUserState(true);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appBarColor,
          centerTitle: false,
          title: Row(
            children: [
              Image.asset(
                'assets/logo3.png',
                height: 30,
              ),
              const Text(
                'Fair Chat',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: const Text(
                      'Create Group',
                    ),
                    onTap: () {}),
                //   onTap: () => Future(
                //     () => Navigator.pushNamed(
                //         context, CreateGroupScreen.routeName),
                //   ),
                // ),
                PopupMenuItem(
                  child: const Text(
                    'My Account',
                  ),
                  onTap: () async {
                    UserModel? umodel =
                        await ref.read(authControllerProvider).getUserData();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage(
                                udata: umodel!,
                                function: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UserInformationScreen(umodel: umodel),
                                    ),
                                    (route) => false,
                                  );
                                },
                                isme: true)));
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         UserInformationScreen(umodel: umodel),
                    //   ),
                    //   (route) => false,
                    // );
                  },
                ),
                PopupMenuItem(
                  child: const Text(
                    'Logout',
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (contex) {
                      return const LandingScreen();
                    }));
                  },
                )
              ],
            ),
          ],
          bottom: TabBar(
            controller: tabBarController,
            indicatorColor: Colors.white,
            indicatorWeight: 4,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'STATUS',
              ),
              Tab(
                text: 'CALLS',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabBarController,
          children: const [
            ContactsList(),
            StatusContactsScreen(),
            Text('Calls')
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (tabBarController.index == 0) {
              Navigator.pushNamed(context, SelectContactsScreen.routeName);
            } else {
              File? pickedImage = await pickImageFromGallery(context);
              if (pickedImage != null) {
                Navigator.pushNamed(
                  context,
                  ConfirmStatusScreen.routeName,
                  arguments: pickedImage,
                );
              }
            }
          },
          backgroundColor: Colors.deepOrangeAccent,
          child: const Icon(
            Icons.comment,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
