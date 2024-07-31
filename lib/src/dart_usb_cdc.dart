export 'dart_usb_cdc_mac.dart'
    if (dart.library.io) 'native/dart_usb_cdc_windows.dart'
    if (dart.library.html) 'native/dart_usb_cdc_linux.dart';

abstract class DartUsbCdc {
  Future<void> open(int vendorId, int productId);
  Future<void> close();
  Future<void> configure(int baudRate, int dataBits, int stopBits, int parity);
  Future<void> sendData(List<int> data);
  Future<List<int>> receiveData();
}
