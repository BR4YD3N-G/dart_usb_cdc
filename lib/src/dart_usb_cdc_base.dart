import 'dart:async';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'dart:io' show Platform;

abstract class DartUsbCdc {
  DynamicLibrary libusb;
  Pointer<Void> _ctx;
  Pointer<Void> _devHandle;

  DartUsbCdc(String libraryPath) {
    libusb = DynamicLibrary.open(libraryPath);
    _ctx = malloc<Pointer<Void>>();
    int result = _libusbInit(_ctx);
    if (result != 0) {
      throw Exception('Failed to initialize libusb');
    }
  }

  int _libusbInit(Pointer<Pointer<Void>> ctx);
  Pointer<Void> _libusbOpenDeviceWithVidPid(Pointer<Void> ctx, int vendorId, int productId);
  void _libusbClose(Pointer<Void> devHandle);
  int _libusbControlTransfer(Pointer<Void> devHandle, int requestType, int request, int value, int index, Pointer<Uint8> data, int length, int timeout);
  int _libusbBulkTransfer(Pointer<Void> devHandle, int endpoint, Pointer<Uint8> data, int length, Pointer<Int32> transferred, int timeout);

  Future<void> open(int vendorId, int productId) async {
    _devHandle = _libusbOpenDeviceWithVidPid(_ctx, vendorId, productId);
    if (_devHandle.address == 0) {
      throw Exception('Failed to open device');
    }
 
