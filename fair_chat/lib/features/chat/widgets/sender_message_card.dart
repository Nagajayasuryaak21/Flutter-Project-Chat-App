import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:fair_chat/features/chat/repositories/chat_repository.dart';
import 'package:fair_chat/common/utils/colors.dart';
import 'package:fair_chat/common/enums/message_enum.dart';
import 'package:fair_chat/features/chat/widgets/display_text_image_gif.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SenderMessageCard extends StatefulWidget {
  //const SenderMessageCard({Key? key}) : super(key: key);
  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
    required this.onRightSwipe,
    required this.repliedText,
    required this.username,
    required this.repliedMessageType,
  }) : super(key: key);
  final String message;
  final String date;
  final MessageEnum type;
  final VoidCallback onRightSwipe;
  final String repliedText;
  final String username;
  final MessageEnum repliedMessageType;

  @override
  State<SenderMessageCard> createState() => _SenderMessageCardState();
}

class _SenderMessageCardState extends State<SenderMessageCard> {
  String? msg = '...';
  Future<void> getmsg() async {
    var result = await ChatRepository(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
    ).getTranslated(widget.message, "Tamil");
    print(result);
    setState(() {
      msg = result.text;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    msg = widget.message;
    getmsg();
  }

  @override
  Widget build(BuildContext context) {
    final isReplying = widget.repliedText.isNotEmpty;
    return SwipeTo(
      onRightSwipe: widget.onRightSwipe,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 100.0,
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            )),
            color: Colors.grey,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                  padding: widget.type == MessageEnum.text
                      ? const EdgeInsets.only(
                          left: 10,
                          right: 30,
                          top: 5,
                          bottom: 20,
                        )
                      : const EdgeInsets.only(
                          left: 5,
                          top: 5,
                          right: 5,
                          bottom: 25,
                        ),
                  child: Column(
                    children: [
                      if (isReplying) ...[
                        Text(
                          widget.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: backgroundColor.withOpacity(0.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                5,
                              ),
                            ),
                          ),
                          child: DisplayTextImageGIF(
                            message: widget.repliedText,
                            type: widget.repliedMessageType,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                      DisplayTextImageGIF(
                        message: msg != null ? msg! : widget.message,
                        type: widget.type,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 10,
                  child: Text(
                    widget.date,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class SenderMessageCard extends StatelessWidget {
//   const SenderMessageCard({
//     Key? key,
//     required this.message,
//     required this.date,
//     required this.type,
//     required this.onRightSwipe,
//     required this.repliedText,
//     required this.username,
//     required this.repliedMessageType,
//   }) : super(key: key);
//   final String message;
//   final String date;
//   final MessageEnum type;
//   final VoidCallback onRightSwipe;
//   final String repliedText;
//   final String username;
//   final MessageEnum repliedMessageType;
//
//   @override
//   Widget build(BuildContext context) {
//     final isReplying = repliedText.isNotEmpty;
//
//     return SwipeTo(
//       onRightSwipe: onRightSwipe,
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             minWidth: 100.0,
//             maxWidth: MediaQuery.of(context).size.width - 45,
//           ),
//           child: Card(
//             elevation: 1,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//               topRight: Radius.circular(15),
//               bottomRight: Radius.circular(15),
//               bottomLeft: Radius.circular(15),
//             )),
//             color: Colors.grey,
//             margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//             child: Stack(
//               children: [
//                 Padding(
//                   padding: type == MessageEnum.text
//                       ? const EdgeInsets.only(
//                           left: 10,
//                           right: 30,
//                           top: 5,
//                           bottom: 20,
//                         )
//                       : const EdgeInsets.only(
//                           left: 5,
//                           top: 5,
//                           right: 5,
//                           bottom: 25,
//                         ),
//                   child: Column(
//                     children: [
//                       if (isReplying) ...[
//                         Text(
//                           username,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black54,
//                           ),
//                         ),
//                         const SizedBox(height: 3),
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: backgroundColor.withOpacity(0.5),
//                             borderRadius: const BorderRadius.all(
//                               Radius.circular(
//                                 5,
//                               ),
//                             ),
//                           ),
//                           child: DisplayTextImageGIF(
//                             message: repliedText,
//                             type: repliedMessageType,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                       ],
//                       DisplayTextImageGIF(
//                         message: message,
//                         type: type,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 2,
//                   right: 10,
//                   child: Text(
//                     date,
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.black45,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
