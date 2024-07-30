Return-Path: <stable+bounces-63474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5157B94191C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757131C23622
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A8B1A618E;
	Tue, 30 Jul 2024 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F1K77YcD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743C51A6161;
	Tue, 30 Jul 2024 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356944; cv=none; b=sTeC4Iy2FeKzBbF4KVM0Hi2oVDp3PtoHxwTsXQtn66IDeXmuknZYaKH4/U1kAlfIhNVVOpC4ZGN3ifBiKKC1CbPVad67an9CdS8CnCcPjYRIKuy5a1k0MJikGgCyB0XsTZH6F1DPPDQpYBsOGNlvofBiYswZfwxpnB1FhTEz8pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356944; c=relaxed/simple;
	bh=qw1iVqArI1PVtFtbH5V8IywPGeS8+ajV6QKl4xDb50o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdxZAQnxNxnCGfEHoQcUBoaw8KnzhkCAR0Iun2f7QNa+4d8nJ/le3asMku4M56sHTdlLtq7wsXrWIvdMOqG6lfZHhpQOFv/1aLX111kFwD/ZvbVaft2IIrfAy/TNgLNVitjVXZVZQbUTC6GpGamjzrg985VuIrgKHO7qRU3QItg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F1K77YcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E85C4AF0E;
	Tue, 30 Jul 2024 16:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356944;
	bh=qw1iVqArI1PVtFtbH5V8IywPGeS8+ajV6QKl4xDb50o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F1K77YcD0PgVp089G6bcFclHtTNppJRlMzg/Vbrc7rQk40GvoBnNMS9PxfMbP7biu
	 U3Bk7ztgi4t6Wt5a0J8ehC885i35tN1yqXe9Kdn05MyR4fpca+5gj/IoR+YiNsMi+t
	 /qaAsamfI+qwuBmLXHlwc4U1PkAcxLj+e8a2iXcM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Oleksandr Natalenko <oleksandr@natalenko.name>,
	Tomasz Figa <tfiga@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 203/568] media: uvcvideo: Quirk for invalid dev_sof in Logitech C922
Date: Tue, 30 Jul 2024 17:45:10 +0200
Message-ID: <20240730151647.809763057@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit 9183c6f1a21e0da4415762c504e2d7f784304d12 ]

Logitech C922 internal SOF does not increases at a stable rate of 1kHz.
This causes that the device_sof and the host_sof run at different rates,
breaking the clock domain conversion algorithm. Eg:

30 (6) [-] none 30 614400 B 21.245557 21.395214 34.133 fps ts mono/SoE
31 (7) [-] none 31 614400 B 21.275327 21.427246 33.591 fps ts mono/SoE
32 (0) [-] none 32 614400 B 21.304739 21.459256 34.000 fps ts mono/SoE
33 (1) [-] none 33 614400 B 21.334324 21.495274 33.801 fps ts mono/SoE
* 34 (2) [-] none 34 614400 B 21.529237 21.527297 5.130 fps ts mono/SoE
* 35 (3) [-] none 35 614400 B 21.649416 21.559306 8.321 fps ts mono/SoE
36 (4) [-] none 36 614400 B 21.678789 21.595320 34.045 fps ts mono/SoE
...
99 (3) [-] none 99 614400 B 23.542226 23.696352 33.541 fps ts mono/SoE
100 (4) [-] none 100 614400 B 23.571578 23.728404 34.069 fps ts mono/SoE
101 (5) [-] none 101 614400 B 23.601425 23.760420 33.504 fps ts mono/SoE
* 102 (6) [-] none 102 614400 B 23.798324 23.796428 5.079 fps ts mono/SoE
* 103 (7) [-] none 103 614400 B 23.916271 23.828450 8.478 fps ts mono/SoE
104 (0) [-] none 104 614400 B 23.945720 23.860479 33.957 fps ts mono/SoE

Instead of disabling completely the hardware timestamping for such
hardware we take the assumption that the packet handling jitter is
under 2ms and use the host_sof as dev_sof.

We can think of the UVC hardware clock as a system with a coarse clock
(the SOF) and a fine clock (the PTS). The coarse clock can be replaced
with a clock on the same frequency, if the jitter of such clock is
smaller than its sampling rate. That way we can save some of the
precision of the fine clock.

To probe this point we have run three experiments on the Logitech C922.
On that experiment we run the camera at 33fps and we analyse the
difference in msec between a frame and its predecessor. If we display
the histogram of that value, a thinner histogram will mean a better
meassurement. The results for:
- original hw timestamp: https://ibb.co/D1HJJ4x
- pure software timestamp: https://ibb.co/QC9MgVK
- modified hw timestamp: https://ibb.co/8s9dBdk

This bug in the camera firmware has been confirmed by the vendor.

lsusb -v

Bus 001 Device 044: ID 046d:085c Logitech, Inc. C922 Pro Stream Webcam
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x046d Logitech, Inc.
  idProduct          0x085c C922 Pro Stream Webcam
  bcdDevice            0.16
  iManufacturer           0
  iProduct                2 C922 Pro Stream Webcam
  iSerial                 1 80B912DF
  bNumConfigurations      1

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Link: https://lore.kernel.org/r/20240323-resend-hwtimestamp-v10-3-b08e590d97c7@chromium.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Stable-dep-of: 85fbe91a7c92 ("media: uvcvideo: Add quirk for invalid dev_sof in Logitech C920")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_driver.c |  9 +++++++++
 drivers/media/usb/uvc/uvc_video.c  | 11 +++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 69602f2ed51d8..664a1b7314197 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2581,6 +2581,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT) },
+	/* Logitech HD Pro Webcam C922 */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x085c,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_INVALID_DEVICE_SOF) },
 	/* Logitech Rally Bar Huddle */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 28dde08ec6c5d..860a21446529a 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -529,6 +529,17 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	stream->clock.last_sof = dev_sof;
 
 	host_sof = usb_get_current_frame_number(stream->dev->udev);
+
+	/*
+	 * On some devices, like the Logitech C922, the device SOF does not run
+	 * at a stable rate of 1kHz. For those devices use the host SOF instead.
+	 * In the tests performed so far, this improves the timestamp precision.
+	 * This is probably explained by a small packet handling jitter from the
+	 * host, but the exact reason hasn't been fully determined.
+	 */
+	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
+		dev_sof = host_sof;
+
 	time = uvc_video_get_time();
 
 	/*
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 3653b2c8a86cb..e5b12717016fa 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -75,6 +75,7 @@
 #define UVC_QUIRK_WAKE_AUTOSUSPEND	0x00002000
 #define UVC_QUIRK_NO_RESET_RESUME	0x00004000
 #define UVC_QUIRK_DISABLE_AUTOSUSPEND	0x00008000
+#define UVC_QUIRK_INVALID_DEVICE_SOF	0x00010000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001
-- 
2.43.0




