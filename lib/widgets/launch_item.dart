import 'package:flutter/material.dart';
import 'package:spacex/models/launch.dart';
import 'package:spacex/screens/launch_detail.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:intl/intl.dart';

class LaunchItem extends StatelessWidget {
  const LaunchItem({
    super.key,
    required this.launch,
    required this.onToggleFavorite,
  });

  final Launch launch;
  final void Function(Launch launch) onToggleFavorite;

  ImageProvider getImageProvider() {
    if (launch.links.patch?.smallImagURL != null) {
      return NetworkImage(launch.links.patch!.smallImagURL!);
    } else {
      return AssetImage(launch.defaultRocketImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('EEEE, MMMM d, yyyy').format(launch.dateLocal);

    return Card(
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => LaunchDetailScreen(
                launch: launch,
                onToggleFavorite: onToggleFavorite,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: getImageProvider(),
              fit: BoxFit.cover,
              height: 110,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    Text(
                      launch.name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // ...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      formattedDate,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // ...
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
