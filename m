Return-Path: <stable+bounces-95981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA8F9DFF87
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A45281464
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAA71F9407;
	Mon,  2 Dec 2024 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lD03mrz8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA31FBC9E
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137223; cv=none; b=G2kq4y3YUMKpcQSUcIs+ToYR+LWnpo7luMY4eYN5v5JyLhIlOfT1GjP6AqESsFtiGcSQtQbzGJeXmZbZzSQaenCqFWIdf7XnPUsMDC0Vi83t7egU3ha5kgCbQjmfMbw4wJa4PqTZdZn0B5KyIdWVLucKYgA0AUO5av5eq6ZE4x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137223; c=relaxed/simple;
	bh=yNWs/oew7i9BEDSV3iwAmAO22FxbkwZ8R4ignpOBq3k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KeUhEq2NkX8IgSC2IvFPV5HxE16hwMH1HPdgl+6cWGuM2kiAx4i1MxeyXTO7JgZ/wXmevHHiA15bBS+COUdId/uUfQFmmXnLZYNzo+7u0tisPp7KhOCceeJ63VKmC+N68yMp0Lp81xCALkqzC7gpuUKb5HEtA3oYTwxsQcJx3aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lD03mrz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1515C4CED1;
	Mon,  2 Dec 2024 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733137223;
	bh=yNWs/oew7i9BEDSV3iwAmAO22FxbkwZ8R4ignpOBq3k=;
	h=Subject:To:Cc:From:Date:From;
	b=lD03mrz86CYUXG/Ri53TuQ+7Kz8aA3YhX+rgkhbR8MbX8a1wN29h5my3Y5Y5H/sHE
	 mVyVCL89t/A68GzDAnhT9+Hz32apes6YdffG+vjI5RKQb0bXKg9T056OTAMFUYaVEk
	 CybBY8WMYY5zhLiMQpLRvx5TqicwHQPKWKEae7rs=
Subject: FAILED: patch "[PATCH] ALSA: usb-audio: Fix potential out-of-bound accesses for" failed to apply to 4.19-stable tree
To: bsevens@google.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 12:00:03 +0100
Message-ID: <2024120203-overstep-undying-88a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x b909df18ce2a998afef81d58bbd1a05dc0788c40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120203-overstep-undying-88a6@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


