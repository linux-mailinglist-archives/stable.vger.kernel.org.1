Return-Path: <stable+bounces-95982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D039DFF88
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F6EAB21EFB
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774BB1F9EA4;
	Mon,  2 Dec 2024 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ov43hbJn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DA7156C40
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137227; cv=none; b=sVsPRHIQkRHE0QlcU+TYinXRSVmHgA0Pqwod2nRTXnT7pg8EnqhN1h5zGBlQsxhdam6BBLL70+gnA+v8UCGf99P/j12o4OMuXw6kKV+YTZpOM5WmXCDY5eUoolwo56c2AEQCABs28IY5uTHy2YI91ipTInbAk4br2VgYNunNVsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137227; c=relaxed/simple;
	bh=82OyjrZtbMtP2CYJP83GV6trGb8PG8mMhs7dt1s/ZW4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=peu6PZD3yABr59dxPHEJLQcewxQNhqpA+Oy3UbAtAn515aQdMsyrpQXso8iItL2Vtv6rFElBYKINCAhCxu5AOgq3Awjv9LSZtdilAALEnnJbunonRZYoidJWzPHfmJl/yV/vLVH4nfEe6uKL+G5LSkQ7n2PlBJ/kQoblPxO1pYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ov43hbJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AF3C4CED1;
	Mon,  2 Dec 2024 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733137226;
	bh=82OyjrZtbMtP2CYJP83GV6trGb8PG8mMhs7dt1s/ZW4=;
	h=Subject:To:Cc:From:Date:From;
	b=ov43hbJnXDltm0ZPmaGkPpI3bty76PK+ospjTltKNzly+3fLMQwAQxeGBxXx5TElP
	 x9Kri0YMP9EbDA9UeXYQO44d5PNBU4HWgXLokunm1dml2ynJIFOTV/n2GikTY8q6mH
	 WAWPaotJW+c3PoEe2E4T5/EAZFzLBAymCUCScldY=
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Fix potential out-of-bound accesses for" failed to apply to 5.4-stable tree
To: bsevens@google.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 12:00:03 +0100
Message-ID: <2024120202-underling-virtuous-1940@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x b909df18ce2a998afef81d58bbd1a05dc0788c40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120202-underling-virtuous-1940@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b909df18ce2a998afef81d58bbd1a05dc0788c40 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Beno=C3=AEt=20Sevens?= <bsevens@google.com>
Date: Wed, 20 Nov 2024 12:41:44 +0000
Subject: [PATCH] ALSA: usb-audio: Fix potential out-of-bound accesses for
 Extigy and Mbox devices
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A bogus device can provide a bNumConfigurations value that exceeds the
initial value used in usb_get_configuration for allocating dev->config.

This can lead to out-of-bounds accesses later, e.g. in
usb_destroy_configuration.

Signed-off-by: Benoît Sevens <bsevens@google.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@kernel.org
Link: https://patch.msgid.link/20241120124144.3814457-1-bsevens@google.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index cbfbb064a9c2..8bc959b60be3 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -555,6 +555,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_interface *intf)
 {
 	struct usb_host_config *config = dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
 
 	if (le16_to_cpu(get_cfg_desc(config)->wTotalLength) == EXTIGY_FIRMWARE_SIZE_OLD ||
@@ -566,10 +567,14 @@ static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_interfac
 		if (err < 0)
 			dev_dbg(&dev->dev, "error sending boot message: %d\n", err);
 		err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
-				&dev->descriptor, sizeof(dev->descriptor));
-		config = dev->actconfig;
+				&new_device_descriptor, sizeof(new_device_descriptor));
 		if (err < 0)
 			dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
+		if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
+			dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
+				new_device_descriptor.bNumConfigurations);
+		else
+			memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
 		err = usb_reset_configuration(dev);
 		if (err < 0)
 			dev_dbg(&dev->dev, "error usb_reset_configuration: %d\n", err);
@@ -901,6 +906,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *dev)
 static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config = dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
 	u8 bootresponse[0x12];
 	int fwsize;
@@ -936,10 +942,14 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 	dev_dbg(&dev->dev, "device initialised!\n");
 
 	err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
-		&dev->descriptor, sizeof(dev->descriptor));
-	config = dev->actconfig;
+		&new_device_descriptor, sizeof(new_device_descriptor));
 	if (err < 0)
 		dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
+	if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
+		dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
+			new_device_descriptor.bNumConfigurations);
+	else
+		memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
 
 	err = usb_reset_configuration(dev);
 	if (err < 0)
@@ -1249,6 +1259,7 @@ static void mbox3_setup_defaults(struct usb_device *dev)
 static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config = dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
 	int descriptor_size;
 
@@ -1262,10 +1273,14 @@ static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
 	dev_dbg(&dev->dev, "MBOX3: device initialised!\n");
 
 	err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
-		&dev->descriptor, sizeof(dev->descriptor));
-	config = dev->actconfig;
+		&new_device_descriptor, sizeof(new_device_descriptor));
 	if (err < 0)
 		dev_dbg(&dev->dev, "MBOX3: error usb_get_descriptor: %d\n", err);
+	if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
+		dev_dbg(&dev->dev, "MBOX3: error too large bNumConfigurations: %d\n",
+			new_device_descriptor.bNumConfigurations);
+	else
+		memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
 
 	err = usb_reset_configuration(dev);
 	if (err < 0)


