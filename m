Return-Path: <stable+bounces-18184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6991B8481B6
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25368283A38
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3028D1804F;
	Sat,  3 Feb 2024 04:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HTB6uV87"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4096F9EB;
	Sat,  3 Feb 2024 04:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933609; cv=none; b=uYMnv6xvKqjCPoM2cVluPrKipRltF+k2podoNN7L/XyAiFRCWtyKP8XPiqE86/k7R67av9FLdFo5PkwvGpRgHJ7yOG+G31Ca4MY+raDh76qsShOi2wAsefaaZ7VOlV6k1lzM0Pk13i/1QpX/Xdslk25r67yjj4zI3+ZPiI8dLrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933609; c=relaxed/simple;
	bh=JdMO/qYaCT+sseXxpkRrJ/HJ5WU6x2VvAHOsgmHLGEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMnAXX7ruIHHlmdJGPrx3++fmU03ReZZ7Iunvp824AaTwlbzcDSKAJuFdl5eodOqhTATwQ41CxCVWKpoXe6YSPpoqB4AkTrQlX6y+COa1mWnjfu4+2GWHOEVnp9HWygvVKvlt2+8HUKbbpZDIpCxOlrnuASEfZ+YuPvc9uo3Iyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HTB6uV87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE718C433F1;
	Sat,  3 Feb 2024 04:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933608;
	bh=JdMO/qYaCT+sseXxpkRrJ/HJ5WU6x2VvAHOsgmHLGEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HTB6uV87J3iED+Cy30kVtmjvhws+KeA4/0jmTA6tU8j5aBNa915MIvW2eZwvKTLtg
	 dHFfV2tn6x2Vyz/o6XLF2Xv+Rkos4yIA2aq5chQhum6OqROnpdxSYTX+QHXA0PB46O
	 doRB3Uc1mUFOpRLupmCS82UcFjOcOxm2GylNy9UA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yunke Cao <yunkec@chromium.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 179/322] media: uvcvideo: Fix power line control for SunplusIT camera
Date: Fri,  2 Feb 2024 20:04:36 -0800
Message-ID: <20240203035405.036163718@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
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

[ Upstream commit 6180056b0e0c097dad5d1569dcd661eaf509ea43 ]

The device does not implement the power line frequency control
correctly. It is a UVC 1.5 device, but implements the control as a UVC
1.1 device.

Add the corresponding control mapping override.

Bus 003 Device 002: ID 2b7e:b752 SunplusIT Inc HD Camera
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.01
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x2b7e
  idProduct          0xb752
  bcdDevice            0.04
  iManufacturer           1 SunplusIT Inc
  iProduct                2 HD Camera
  iSerial                 3 01.00.00
  bNumConfigurations      1

Cc: Yunke Cao <yunkec@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 4b5ea3501753..bbd90123a4e7 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -3003,6 +3003,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_BPP) },
+	/* SunplusIT Inc HD Camera */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x2b7e,
+	  .idProduct		= 0xb752,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
+	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_uvc11 },
 	/* Lenovo Integrated Camera */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
-- 
2.43.0




