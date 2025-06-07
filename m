Return-Path: <stable+bounces-151753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8292EAD0C72
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 12:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3061892F42
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 10:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD9721B185;
	Sat,  7 Jun 2025 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="slaHNp2D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F23217F26;
	Sat,  7 Jun 2025 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749290899; cv=none; b=nwixTRcZ1R65zQauCRFr9llTFbOTjvgm5lOm+igUpUynMirUlaUJStf1euEXUvs7IMOoc5TJBvXPAD6+wEF22R24GREVKCHC0DV4Pek+c5Ntl3hmJEuJFiL4+NLKzutePxSWs0tuxBpxUjFdUm0CxPyC6lNnJDNHiq/o6qjUBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749290899; c=relaxed/simple;
	bh=TIBtdRCs2zaQCJJSYPemko1bkeOgJKcjlUkNQ+KSJd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWPRiNXt/ln9KuRKr7PqiDXUf+fcB65E8LZf9Ef5XQn9Dww9EFTR/niMnedegCstRw9F6MpRXH1zodgKjZ1HIzLrXDGXCYG4FFZpm9H4icvhg1ohzRIy9owpmfLxmCierMRb3y8PhUfs+BpCHbMvKQe5EdIYU/QFXCaozJoZNp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=slaHNp2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8340DC4CEED;
	Sat,  7 Jun 2025 10:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749290897;
	bh=TIBtdRCs2zaQCJJSYPemko1bkeOgJKcjlUkNQ+KSJd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slaHNp2DdUeojqE6kIx8zu03CmCtKbOeZGmobp0rdFn/5esuAKmDUuj+5rRswwi3s
	 0NcMGfaoqlTD2B1aqDgEgd12ji9Rhemb1wyV0KkvJFir6DjnoVLuNtd2lXjydAmlRa
	 iza0wEO+mNh2bF/rlIA4z2qiei2zF82nl8uGlj2c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hongyu Xie <xiehongyu1@kylinos.cn>,
	stable <stable@kernel.org>
Subject: [PATCH 6.12 15/24] usb: storage: Ignore UAS driver for SanDisk 3.2 Gen2 storage device
Date: Sat,  7 Jun 2025 12:07:46 +0200
Message-ID: <20250607100718.500046947@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607100717.910797456@linuxfoundation.org>
References: <20250607100717.910797456@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hongyu Xie <xiehongyu1@kylinos.cn>

commit a541acceedf4f639f928f41fbb676b75946dc295 upstream.

SanDisk 3.2 Gen2 storage device(0781:55e8) doesn't work well with UAS.
Log says,
[    6.507865][ 3] [  T159] usb 2-1.4: new SuperSpeed Gen 1 USB device number 4 using xhci_hcd
[    6.540314][ 3] [  T159] usb 2-1.4: New USB device found, idVendor=0781, idProduct=55e8, bcdDevice= 0.01
[    6.576304][ 3] [  T159] usb 2-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    6.584727][ 3] [  T159] usb 2-1.4: Product: SanDisk 3.2 Gen2
[    6.590459][ 3] [  T159] usb 2-1.4: Manufacturer: SanDisk
[    6.595845][ 3] [  T159] usb 2-1.4: SerialNumber: 03021707022525140940
[    7.230852][ 0] [  T265] usbcore: registered new interface driver usb-storage
[    7.251247][ 0] [  T265] scsi host3: uas
[    7.255280][ 0] [  T265] usbcore: registered new interface driver uas
[    7.270498][ 1] [  T192] scsi 3:0:0:0: Direct-Access     SanDisk  Extreme Pro DDE1 0110 PQ: 0 ANSI: 6
[    7.299588][ 3] [  T192] scsi 3:0:0:1: Enclosure         SanDisk  SES Device       0110 PQ: 0 ANSI: 6
[    7.321681][ 3] [  T192] sd 3:0:0:0: Attached scsi generic sg1 type 0
[    7.328185][ 3] [  T192] scsi 3:0:0:1: Attached scsi generic sg2 type 13
[    7.328804][ 0] [  T191] sd 3:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    7.343486][ 0] [  T191] sd 3:0:0:0: [sda] 4096-byte physical blocks
[    7.364611][ 0] [  T191] sd 3:0:0:0: [sda] Write Protect is off
[    7.370524][ 0] [  T191] sd 3:0:0:0: [sda] Mode Sense: 3d 00 10 00
[    7.390655][ 0] [  T191] sd 3:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[    7.401363][ 0] [  T191] sd 3:0:0:0: [sda] Optimal transfer size 1048576 bytes
[    7.436010][ 0] [  T191]  sda: sda1
[    7.450850][ 0] [  T191] sd 3:0:0:0: [sda] Attached SCSI disk
[    7.470218][ 4] [  T262] scsi 3:0:0:1: Failed to get diagnostic page 0x1
[    7.474869][ 0] [    C0] sd 3:0:0:0: [sda] tag#0 data cmplt err -75 uas-tag 2 inflight: CMD
[    7.476911][ 4] [  T262] scsi 3:0:0:1: Failed to bind enclosure -19
[    7.485330][ 0] [    C0] sd 3:0:0:0: [sda] tag#0 CDB: Read(10) 28 00 00 00 00 28 00 00 10 00
[    7.491593][ 4] [  T262] ses 3:0:0:1: Attached Enclosure device
[   38.066980][ 4] [  T192] sd 3:0:0:0: [sda] tag#4 uas_eh_abort_handler 0 uas-tag 5 inflight: CMD IN
[   38.076012][ 4] [  T192] sd 3:0:0:0: [sda] tag#4 CDB: Read(10) 28 00 00 00 01 08 00 00 f8 00
[   38.086485][ 4] [  T192] sd 3:0:0:0: [sda] tag#3 uas_eh_abort_handler 0 uas-tag 1 inflight: CMD IN
[   38.095515][ 4] [  T192] sd 3:0:0:0: [sda] tag#3 CDB: Read(10) 28 00 00 00 00 10 00 00 08 00
[   38.104122][ 4] [  T192] sd 3:0:0:0: [sda] tag#2 uas_eh_abort_handler 0 uas-tag 4 inflight: CMD IN
[   38.113152][ 4] [  T192] sd 3:0:0:0: [sda] tag#2 CDB: Read(10) 28 00 00 00 00 88 00 00 78 00
[   38.121761][ 4] [  T192] sd 3:0:0:0: [sda] tag#1 uas_eh_abort_handler 0 uas-tag 3 inflight: CMD IN
[   38.130791][ 4] [  T192] sd 3:0:0:0: [sda] tag#1 CDB: Read(10) 28 00 00 00 00 48 00 00 30 00
[   38.139401][ 4] [  T192] sd 3:0:0:0: [sda] tag#0 uas_eh_abort_handler 0 uas-tag 2 inflight: CMD
[   38.148170][ 4] [  T192] sd 3:0:0:0: [sda] tag#0 CDB: Read(10) 28 00 00 00 00 28 00 00 10 00
[   38.178980][ 2] [  T304] scsi host3: uas_eh_device_reset_handler start
[   38.901540][ 2] [  T304] usb 2-1.4: reset SuperSpeed Gen 1 USB device number 4 using xhci_hcd
[   38.936791][ 2] [  T304] scsi host3: uas_eh_device_reset_handler success

Device decriptor is below,
Bus 002 Device 006: ID 0781:55e8 SanDisk Corp. SanDisk 3.2 Gen2
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.20
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         9
  idVendor           0x0781 SanDisk Corp.
  idProduct          0x55e8
  bcdDevice            0.01
  iManufacturer           1 SanDisk
  iProduct                2 SanDisk 3.2 Gen2
  iSerial                 3 03021707022525140940
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0079
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              896mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk-Only
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       1
      bNumEndpoints           4
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     98
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               0
        Command pipe (0x01)
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
        MaxStreams             32
        Status pipe (0x02)
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
        MaxStreams             32
        Data-in pipe (0x03)
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
        MaxStreams             32
        Data-out pipe (0x04)
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength       0x002a
  bNumDeviceCaps          3
  USB 2.0 Extension Device Capability:
    bLength                 7
    bDescriptorType        16
    bDevCapabilityType      2
    bmAttributes   0x0000f41e
      BESL Link Power Management (LPM) Supported
    BESL value     1024 us
    Deep BESL value    61440 us
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x00
    wSpeedsSupported   0x000e
      Device can operate at Full Speed (12Mbps)
      Device can operate at High Speed (480Mbps)
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   1
      Lowest fully-functional device speed is Full Speed (12Mbps)
    bU1DevExitLat          10 micro seconds
    bU2DevExitLat        2047 micro seconds
  SuperSpeedPlus USB Device Capability:
    bLength                20
    bDescriptorType        16
    bDevCapabilityType     10
    bmAttributes         0x00000001
      Sublink Speed Attribute count 1
      Sublink Speed ID count 0
    wFunctionalitySupport   0x1100
    bmSublinkSpeedAttr[0]   0x000a4030
      Speed Attribute ID: 0 10Gb/s Symmetric RX SuperSpeedPlus
    bmSublinkSpeedAttr[1]   0x000a40b0
      Speed Attribute ID: 0 10Gb/s Symmetric TX SuperSpeedPlus
Device Status:     0x0000
  (Bus Powered)

So ignore UAS driver for this device.

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20250519023328.1498856-1-xiehongyu1@kylinos.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/unusual_uas.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -52,6 +52,13 @@ UNUSUAL_DEV(0x059f, 0x1061, 0x0000, 0x99
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_REPORT_OPCODES | US_FL_NO_SAME),
 
+/* Reported-by: Zhihong Zhou <zhouzhihong@greatwall.com.cn> */
+UNUSUAL_DEV(0x0781, 0x55e8, 0x0000, 0x9999,
+		"SanDisk",
+		"",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_UAS),
+
 /* Reported-by: Hongling Zeng <zenghongling@kylinos.cn> */
 UNUSUAL_DEV(0x090c, 0x2000, 0x0000, 0x9999,
 		"Hiksemi",



