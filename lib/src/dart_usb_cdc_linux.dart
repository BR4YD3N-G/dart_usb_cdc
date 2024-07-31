import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'dart_usb_cdc_base.dart';

class UsbCdcCommunicatorLinux extends DartUsbCdc {
  UsbCdcCommunicatorLinux() : super('/usr/lib/x86_64-linux-gnu/libusb-1.0.so.0');

  @override
  int _libusbInit(Pointer<Pointer<Void>> ctx) {
    final libusbInit = libusb.lookupFunction<Int32 Function(Pointer<Pointer<Void>>), int Function(Pointer<Pointer<Void>>)>("libusb_init");
    return libusbInit(ctx);
  }

  @override
  Pointer<Void> _libusbOpenDeviceWithVidPid(Pointer<Void> ctx, int vendorId, int productId) {
    final libusbOpenDeviceWithVidPid = libusb.lookupFunction<Pointer<Void> Function(Pointer<Void>, Uint16, Uint16), Pointer<Void> Function(Pointer<Void>, int, int)>("libusb_open_device_with_vid_pid");
    return libusbOpenDeviceWithVidPid(ctx, vendorId, productId);
  }

  @override
  void _libusbClose(Pointer<Void> devHandle) {
    final libusbClose = libusb.lookupFunction<Void Function(Pointer<Void>), void Function(Pointer<Void>)>("libusb_close");
    return libusbClose(devHandle);
  }

  @override
  int _libusbControlTransfer(Pointer<Void> devHandle, int requestType, int request, int value, int index, Pointer<Uint8> data, int length, int timeout) {
    final libusbControlTransfer = libusb.lookupFunction<Int32 Function(Pointer<Void>, Uint8, Uint8, Uint16, Uint16, Pointer<Uint8>, Uint16, Uint32), int Function(Pointer<Void>, int, int, int, int, Pointer<Uint8>, int, int)>("libusb_control_transfer");
    return libusbControlTransfer(devHandle, requestType, request, value, index, data, length, timeout);
  }

  @override
  int _libusbBulkTransfer(Pointer<Void> devHandle, int endpoint, Pointer<Uint8> data, int length, Pointer<Int32> transferred, int timeout) {
    final libusbBulkTransfer = libusb.lookupFunction<Int32 Function(Pointer<Void>, Uint8, Pointer<Uint8>, Int32, Pointer<Int32>, Uint32), int Function(Pointer<Void>, int, Pointer<Uint8>, int, Pointer<Int32>, int)>("libusb_bulk_transfer");
    return libusbBulkTransfer(devHandle, endpoint, data, length, transferred, timeout);
  }
}
