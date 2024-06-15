import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:spacex/models/launch.dart';
import 'package:spacex/widgets/launch_detail_text.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchDetailScreen extends StatefulWidget {
  LaunchDetailScreen({
    super.key,
    required this.launch,
    required this.onToggleFavorite,
  });

  final Launch launch;
  final void Function(Launch launch) onToggleFavorite;

  @override
  State<StatefulWidget> createState() {
    return _LaunchDetailState();
  }
}

class _LaunchDetailState extends State<LaunchDetailScreen> {
  final logger = Logger();

  late final Launch _launch;
  late final Function(Launch launch) _onToggleFavorite;

  Color? favoriteButtonColor;

  @override
  void initState() {
    super.initState();
    _launch = widget.launch;
    _onToggleFavorite = widget.onToggleFavorite;
  }

  ImageProvider getImageProvider() {
    if (_launch.links.patch?.smallImagURL != null) {
      return NetworkImage(_launch.links.patch!.smallImagURL!);
    } else {
      return AssetImage(_launch.defaultRocketImage);
    }
  }

  String getDescription() {
    if (_launch.details != null) {
      return _launch.details!;
    } else {
      return 'The personal is too lazy to write up the detail about this launch ...';
    }
  }

  String getRocketName() {
    if (_launch.rocket?.name != null) {
      return _launch.rocket!.name;
    } else {
      return 'No rocket info in record ...';
    }
  }

  String getLaunchpadName() {
    if (_launch.launchpad?.fullName != null) {
      return _launch.launchpad!.fullName;
    } else {
      return 'No launchpad info in record ...';
    }
  }

  String getLaunchSuccessOrFail() {
    if (_launch.success != null) {
      if (_launch.success!) {
        return 'success';
      } else {
        return 'fail';
      }
    } else {
      return 'TBD ...';
    }
  }

  _launchURL(String url) async {
    Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      logger.d('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('EEEE, MMMM d, yyyy').format(_launch.dateLocal);

    return Scaffold(
      appBar: AppBar(
        title: Text(_launch.name),
        actions: [
          IconButton(
            onPressed: () {
              _onToggleFavorite(_launch);
              setState(() {
                favoriteButtonColor = Colors.amberAccent;
              });
            },
            color: favoriteButtonColor,
            icon: const Icon(Icons.star),
            highlightColor: Colors.amberAccent,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: getImageProvider(),
              fit: BoxFit.fill,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LaunchDetailText(
                  title: 'Launch Date: ',
                  description: formattedDate,
                ),
                LaunchDetailText(
                  title: 'Description: ',
                  description: getDescription(),
                ),
                LaunchDetailText(
                  title: 'Rocket: ',
                  description: getRocketName(),
                ),
                LaunchDetailText(
                  title: 'Launchpad: ',
                  description: getLaunchpadName(),
                ),
                LaunchDetailText(
                  title: 'Launch Status: ',
                  description: getLaunchSuccessOrFail(),
                ),
                Visibility(
                  visible: _launch.links.wikipedia != null,
                  child: GestureDetector(
                    onTap: () => _launchURL(_launch.links.wikipedia!),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Learn More',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
