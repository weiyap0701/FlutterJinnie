import 'package:flutter/material.dart';

//non-library
import 'package:jinnie/API/ApiHandler.dart';

import 'package:jinnie/Model/WishModel.dart';
import 'package:jinnie/Model/WishComment.dart';

class PostCell extends StatelessWidget {

  final WishModel wishModel;
  final BuildContext context;
  List<WishComment> wishCommentArray;

  PostCell({this.wishModel, this.context});

  _performGetWishComment(String wishId) {
    WishApiHandler.getWishComment(wishId).then((comments){
      this.wishCommentArray = comments;
      _buildCommentList();
    });
  }

  CircleAvatar _buildProfileImage() {
    if (this.wishModel.user.userProfileImageName != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(this.wishModel.user.userProfileImageName)
      );
    }
    else {
      return CircleAvatar(
        backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2017/07/18/23/23/user-2517433_960_720.png")
      );
    }
  }

  Future _buildCommentList() async {
    await showDialog(
      context: this.context,
      child: Dialog(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ListTile(
              title: new Text("Commented By", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
            ),
            Divider(),
            new ListView.builder(
              shrinkWrap: true,
              itemCount: this.wishCommentArray != null ? this.wishCommentArray.length : 0,
              itemBuilder: (buildContext, i){
                var comment = this.wishCommentArray[i];
                return _buildComments(comment);
              },
            ),
          ],
        ),
      )
    );
  }

  Column _buildComments(WishComment comment) {
    var profileImageUrl = comment.user.userProfileImageName != null ? comment.user.userProfileImageName : "https://cdn.pixabay.com/photo/2017/07/18/23/23/user-2517433_960_720.png";
    return new Column(
      children: <Widget>[
        new ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(profileImageUrl)
          ),
          title: Row(
            children: <Widget>[
              new Text(
                comment.user.firstName + " " + comment.user.lastName, 
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey
              )),
              Padding(padding: const EdgeInsets.only(left: 2, right: 2)),
              new Text(
                "@" + comment.user.alias, 
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey
              ))
          ]),
        subtitle: new Text("12w"),
      ),
      new ListTile(
        title: new Text(comment.message),
      ),
      Divider()
    ]);
  }

  Row _buildName() {
    return Row(
      children: <Widget>[
        new Text(this.wishModel.user.firstName + " " + this.wishModel.user.lastName, style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.blueGrey
        )),
        Padding(padding: const EdgeInsets.only(left: 2, right: 2),),
        new Text("@" + this.wishModel.user.alias, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.grey
        ))
      ],
    );
  }

  Container _buildWishImage() {

    if (this.wishModel.images.length > 0) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Image.network(this.wishModel.images.first.imageUrl)
      );
    }
    else {
      return Container();
    }
  }

  Widget _buildCommentButton() {
    if (this.wishModel.totalComment != null && this.wishModel.totalComment > 0) {
      var text = this.wishModel.totalComment == 1 ? " Comment" : " Comments";
      return 
      MaterialButton(
        minWidth: 60.0,
        padding: const EdgeInsets.all(2.0),
        onPressed: () {
          _performGetWishComment(this.wishModel.wishId);
        },
        child: Text(this.wishModel.totalComment.toString() + text,
          style: TextStyle(
          fontSize: 12.0,
          color: Colors.grey,
          )),
      );
    }
    else {
      return Container();
    }
  }

  Widget _buildOfferButton() {
    if (this.wishModel.totalOffer != null && this.wishModel.totalOffer > 0) {
      var text = this.wishModel.totalOffer == 1 ? " Offer" : " Offers";
      return
      MaterialButton(
        minWidth: 60.0,
        padding: const EdgeInsets.all(2.0),
        onPressed: () {},
        child: Text(this.wishModel.totalOffer.toString() + text,
          style: TextStyle(
          fontSize: 12.0,
          color: Colors.grey,
          )),
      );
    }
    else {
      return Container();
    }
  }

  Row _buildCountButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildCommentButton(),
        _buildOfferButton()
      ],
    );
  }

  Row _buildActionButtons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.comment, color: Colors.grey, size: 18.0),
                Padding(padding: const EdgeInsets.only(left: 5.0, right: 5.0)),
                Text("Comment", style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(2.0),
          height: 25.0,
          width: 0.3,
          color: Colors.grey,
        ),
        Expanded(
          child: FlatButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.local_offer, color: Colors.grey, size: 18.0),
                Padding(padding: const EdgeInsets.only(left: 5.0, right: 5.0)),
                Text("Offer", style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
      onTap: () {},
      child: new Column(
        children: <Widget>[
          ListTile(
            leading: _buildProfileImage(),
            title: _buildName(),
            subtitle: new Text("4w"),
          ),
          ListTile(
            title: new Text(this.wishModel.message)
          ),
          _buildWishImage(),
          // ListTile(title: _buildWishImage()),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 12.0),
            leading: new PostStatusView(wishModel: this.wishModel),
          ),
          ListTile(trailing: _buildCountButtons()),
          Divider(),
          _buildActionButtons()
        ],
      ),
    ));
  }
}

class PostStatusView extends StatelessWidget {
  
  final WishModel wishModel;
  PostStatusView({this.wishModel});

  Row _buildStatusRow(IconData icon, String text) {
    return Row(
      children: <Widget>[
        new Icon(
          icon,
          size: 15.0,
        ),
        new Padding(padding: const EdgeInsets.only(left: 3.0, right: 3.0)),
        new Expanded(
          child: new Text(text),
        )
      ],
    );
  }

  Row _buildAddressRow() {
    if (this.wishModel.destinationName != null) {
      return _buildStatusRow(Icons.location_on, this.wishModel.destinationName);
    }
    else {
      return Row();
    }
  }

  Row _buildItemName() {
    if (this.wishModel.itemName != null) {
      return _buildStatusRow(Icons.cake, this.wishModel.itemName);
    }
    else {
      return Row();
    }
  }

  Row _buildPriceRow() {
    if (this.wishModel.minPrice != null && this.wishModel.maxPrice != null) {
      var text = this.wishModel.minPrice.toString() + " ~ " + this.wishModel.maxPrice.toString();
      return _buildStatusRow(Icons.attach_money, text);
    }
    else if (this.wishModel.maxPrice != null) {
      return _buildStatusRow(Icons.attach_money, this.wishModel.maxPrice.toString());
    }
    else if (this.wishModel.minPrice != null) {
      return _buildStatusRow(Icons.attach_money, this.wishModel.minPrice.toString());
    }
    else {
      return Row();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildAddressRow(),
        _buildItemName(),
        _buildPriceRow()
      ],
    );
  }
}
