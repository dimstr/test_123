import 'package:flutter/material.dart';
import '../../api/images/image_model.dart';

class GridImages extends StatelessWidget {
  const GridImages({Key? key, required this.data}) : super(key: key);

  final List<ImageModel> data;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 1 / 1,
      ),
      shrinkWrap: true,
      primary: false,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return
          // ClipRRect(
          // borderRadius: BorderRadius.circular(12),
          // child:
          AspectRatio(
            aspectRatio: 487 / 451,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: FractionalOffset.center,
                  image: NetworkImage(data[index].urlToImage),
                ),
              // ),
            ),
          ),
        );
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(12),
        //   child: AspectRatio(
        //     aspectRatio: 1 / 1,
        //     child: Image.network(
        //       data[index].urlToImage,
        //     ),
        //   ),
        // );
      },
    );
  }
}
