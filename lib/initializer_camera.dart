import 'package:camera/camera.dart';

Future<void> initializeCameraController(CameraDescription camera, CameraController? controller) async {
  controller = CameraController(
    camera,
    ResolutionPreset.high,
  );

  try {
    await controller?.initialize();
  } catch (e) {
    print(e);
  }
}