import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reach_me/providers/user_provider.dart';
import 'package:reach_me/utils/colors.dart';
import 'package:reach_me/widgets/like_animation.dart';

import '../models/user.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4,horizontal: 16).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    widget.snap['profImage'],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            widget.snap['username'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(onPressed: (){
                  showDialog(context: context, builder: (context) => Dialog(
                    child: ListView(
                      padding: EdgeInsets.symmetric(vertical: 16,),
                      shrinkWrap: true,
                      children: [
                        'Delete',
                      ].map((e) => InkWell(
                        onTap: (){},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                          child: Text(e),
                        ),
                      ),
                      ).toList(),
                    ),
                  ));
                }, icon: const Icon(Icons.more_vert),),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: (){
              setState((){
                isLikeAnimating = true;
              });
            },
            child: Stack(
              children: [
                SizedBox(
                   height: MediaQuery.of(context).size.height*0.35,
                   width: double.infinity,
                   child: Image.network(
                      widget.snap['postUrl'],
                      fit: BoxFit.cover,),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 120.0,),
                      isAnimating: isLikeAnimating,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                        setState((){
                          isLikeAnimating = false;
                        });
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,

                child: IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),
              IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.comment_outlined,
                  //color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.send,
                  //color: Colors.red,
                ),
              ),
              Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.bookmark_border)),
                  ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                  child: Text(
                    '${widget.snap['likes'].length} likes',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: primaryColor),
                        children: [
                          TextSpan(
                            text: widget.snap['username'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "  ${widget.snap['description']}",
                          ),
                        ],
                      ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'View all 200 comments',
                      style: const TextStyle(fontSize: 16,color: secondaryColor),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    DateFormat.yMMMd().format(
                      widget.snap['datePublished'].toDate(),
                    ),
                    style: const TextStyle(fontSize: 16,color: secondaryColor),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
