import 'package:flutter/material.dart';
import 'package:wiki_vault/src/views/widgets/bookmark/bookmark_group.dart';
import 'package:wiki_vault/src/views/widgets/bookmark/bookmark_item.dart';
import '../../../models/article.dart';
import '../../../models/article_group.dart';

class BookmarkList extends StatelessWidget {
  const BookmarkList(this.groupList, this.articleList, {Key? key, required }) : super(key: key);

  final List<ArticleGroup> groupList;
  final List<Article> articleList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: groupList.length + articleList.length,
      itemBuilder: (BuildContext context, int index) {
        return index <= groupList.length ? BookmarkGroup(groupList[index]) : BookmarkItem(articleList[index - groupList.length]);
      },
      separatorBuilder: (_, index) {
        return const Divider(color: Colors.grey);
      },
      controller: ScrollController(),
    );
  }
}