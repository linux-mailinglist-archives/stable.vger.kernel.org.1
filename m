Return-Path: <stable+bounces-96026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F23EF9E06D7
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55071B27B02
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E741D8A14;
	Mon,  2 Dec 2024 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Weikc4dK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AC8A95C
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145005; cv=none; b=i0K2Z+tbtFsUCJOQO/zLmobGdydOJsMxKMHFJQJWsbLCs1eVxMSkGoMccWedekJJcZ0vLEc51IDVBkFp+Hj9Vz3weDJOUF0NuNUoiJsoNLD6XUkF5XJmrAkQIeH+jhKFdL9NF6S3wVO/1+4EbZKoAaGThF5oxSyg9qUlvqCfqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145005; c=relaxed/simple;
	bh=ny0srfoQSpZdsmvp5QUPgTgpA77JM/Idw3qKyXj522o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ijsSliNy44mAvnXq9pwb9R7P+pe8fO892U3kn3nqi+JSqi6OWgxLB511XyhtwWVizvrJsRPY6nSONfoYni9kWSUi5lPwkpqNmeJdAhoPlEKGKfvwoH6qsJX6iQQfhGRPHsY+4tTCHK8ZcFssnmpCDnLRQUWBxPYdXYfBro90ty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Weikc4dK; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d0b6f3770eso2222667a12.3
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 05:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733145002; x=1733749802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+lLCHM1vOyHYl0h093xslTP47AY+kUL+LxjN1lf4jw=;
        b=Weikc4dKFdX3JNI4KeskggnFwvCBNy/LqpnTPrjfYZW6r+H+rBZFTN1+QIGX8gmtUw
         tGzdGmitfMNqdQoAf7VDucH/ID2BcUxlLkxvHfCHY2teuE4rvIoIN8pSa9rBLooQzpzy
         9LMiIbeDvKFRTmAIms5Df+5N4CS+1qIdi2BxxJSFoBVisM/iM64zemGQhso8Pjv/q6Qe
         oAOwd4f3UiMIh608yDjn603zXY/zYlJuj2FYHrRit9fpM4ZDptihy1h6x9xHHue4CS8A
         OX0V+vCsJkXqI23X2IJTig7hrVpFGE7pDoXBn5RFIrSmL33U8OEZi+h/KSIwdMCvFrnG
         lSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733145002; x=1733749802;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y+lLCHM1vOyHYl0h093xslTP47AY+kUL+LxjN1lf4jw=;
        b=jBa08q2NVp9ybk2F2rJQDp18vyN8GWwWT5Yii8i3YfDoLVLNjLKHGTHOOlzk8nsRI1
         BdQfqER31hlQ/Fv7Iv1JOm+2wN5x3AL9OG6czgaIvAZ/4KrGLOWSdcciq/fLQBTdcgtf
         MjTXosrcByVkAjo8Zw2p/IaGlG9+GVY2u3dWhY2LMhAXy75fK3e1GtsLvP8LGQL/h+Qk
         z5ae2cXVt/8LyK1hxZ/kK7MuX5Oh+07/pFBn0nm8AbHzhun31PhLweHS0kTQWUDOyVMu
         iS//VTe17RB1cvVQcvJW7+Wosvmxxd70/kn8ZXeX/4kDiSV7bXD6SAMxgxtmqm9NNoGE
         vg9w==
X-Gm-Message-State: AOJu0Yy4zLM7MyKg6Gbe//6sUIb/wcTWASevcbIs3/lBgPBLMMbLN+AY
	l73jVWJBYElvKEh+803oKPn6vfECmfcHCyebx+O2u+xci8psSUOej07joDEeyNtxeLVvSgPZSzB
	uBnDOwJph7iFxdrCrsXHosZGu1ynHbL55SxhSnz1RhwWAtG0ZOAQ7/UFVXF2lyc24JeS9wtwPLi
	NBnjMjzV5bVphhEuAmbOVsbUbDv+s91TEFzThHeQ==
X-Google-Smtp-Source: AGHT+IFvBPK0Sp3soNL1T5sZGgO4c4z9FJfdG+f6UYoWKOqaCBCqPsZRrWYAtwgLqSVWEFy25MDfNDDcQm0L
X-Received: from edbdn15.prod.google.com ([2002:a05:6402:22ef:b0:5d0:ae45:62ec])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:d07:b0:5cf:9e5:7d20
 with SMTP id 4fb4d7f45d1cf-5d080bd3c69mr24158180a12.17.1733145002007; Mon, 02
 Dec 2024 05:10:02 -0800 (PST)
Date: Mon,  2 Dec 2024 13:09:17 +0000
In-Reply-To: <2024120202-underling-virtuous-1940@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024120202-underling-virtuous-1940@gregkh>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202130917.2486019-1-bsevens@google.com>
Subject: [PATCH 5.4.y] ALSA: usb-audio: Fix potential out-of-bound accesses
 for Extigy and Mbox devices
From: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>
To: stable@vger.kernel.org
Cc: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>, stable@kernel.org, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A bogus device can provide a bNumConfigurations value that exceeds the
initial value used in usb_get_configuration for allocating dev->config.

This can lead to out-of-bounds accesses later, e.g. in
usb_destroy_configuration.

Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@kernel.org
Link: https://patch.msgid.link/20241120124144.3814457-1-bsevens@google.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
(cherry picked from commit b909df18ce2a998afef81d58bbd1a05dc0788c40)
Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
---
 sound/usb/quirks.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index d7136f6f9440..2aea0b54ddbc 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -585,6 +585,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_in=
terface *intf)
 {
 	struct usb_host_config *config =3D dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
=20
 	if (le16_to_cpu(get_cfg_desc(config)->wTotalLength) =3D=3D EXTIGY_FIRMWAR=
E_SIZE_OLD ||
@@ -596,10 +597,14 @@ static int snd_usb_extigy_boot_quirk(struct usb_devic=
e *dev, struct usb_interfac
 		if (err < 0)
 			dev_dbg(&dev->dev, "error sending boot message: %d\n", err);
 		err =3D usb_get_descriptor(dev, USB_DT_DEVICE, 0,
-				&dev->descriptor, sizeof(dev->descriptor));
-		config =3D dev->actconfig;
+				&new_device_descriptor, sizeof(new_device_descriptor));
 		if (err < 0)
 			dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
+		if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfi=
gurations)
+			dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
+				new_device_descriptor.bNumConfigurations);
+		else
+			memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor=
));
 		err =3D usb_reset_configuration(dev);
 		if (err < 0)
 			dev_dbg(&dev->dev, "error usb_reset_configuration: %d\n", err);
@@ -933,6 +938,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *=
dev)
 static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config =3D dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
 	u8 bootresponse[0x12];
 	int fwsize;
@@ -968,10 +974,14 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device=
 *dev)
 	dev_dbg(&dev->dev, "device initialised!\n");
=20
 	err =3D usb_get_descriptor(dev, USB_DT_DEVICE, 0,
-		&dev->descriptor, sizeof(dev->descriptor));
-	config =3D dev->actconfig;
+		&new_device_descriptor, sizeof(new_device_descriptor));
 	if (err < 0)
 		dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
+	if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfig=
urations)
+		dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
+			new_device_descriptor.bNumConfigurations);
+	else
+		memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor)=
);
=20
 	err =3D usb_reset_configuration(dev);
 	if (err < 0)
--=20
2.47.0.338.g60cca15819-goog


