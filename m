Return-Path: <stable+bounces-96013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8A19E020A
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508DB16B742
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E986F1FECCA;
	Mon,  2 Dec 2024 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0LE0wrkj"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83EA1E521
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141769; cv=none; b=A2hOtfBBqyWPpvbLSgzWffNS0RaBa2vGxahG+K7jMxHCyuQ6/IP8lt1WJLdW0POkr/Z4G9z7bUpNm/3aYUeWaUhtyslWtXVV+oN/v0LyXSnKOF9ysNzz6VT20TrPoNdbh3oJZGC7eW2lbTh94+lJT07ae1tzD0pp+DH8FMeEIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141769; c=relaxed/simple;
	bh=0ucm/u82Y5vZj33WP+6fb5v67AUFdU7ufvb4CxYJWqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fZb3Wi+kWrPdyqcmtbRKM6owP2xb/eovSFGa+s2jSgSB1RAuxZBM00IbbL7LBQuQwYMrh3DSfMFXsY6KPit48Ly+XFT+Z/DyLy6ye+X2Qc34+Qn0bXuzVx9+vCQYFGX3iGTeSCZYG+aNrQ4Pn9IdbLLCo1k3e4i+rIKLdq4yQt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0LE0wrkj; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2ffcd95e405so23511281fa.2
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 04:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733141766; x=1733746566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9ulxpPotFvQrIhnmEgu/0vQJ18jO7Bqdy5M34HWEUU=;
        b=0LE0wrkjIa+5iAnocInxkCgSP5Na5TL9l1e+tFe9nDWbwfvx+EMYL5wGu4w1PeeF5/
         OJeDZjnmW1pQLMQ1gSLNirgysuorVQ/SJFYu1cff9gps1AbkI4FbZ1iUBr2mI8mXarft
         VQ5rtGCve40fz7DMynzNUZIBY1KUXRkjHqim8WN9g8eb+GF+lZ8nNPlgf8Bx6SbX0Mmi
         fDRVakWo//hjRwViSs0oxqShZ80TlZ7PVu55F9FKjLpr5/G+ImyvomBfihz+24RXQ0Gh
         q+w1W8TI05Vh3exyew0Xd0brlnz5wjM3BXdUM6f6I5Vbd268zKmfwU5YbpAZSfKkb8D0
         tIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733141766; x=1733746566;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C9ulxpPotFvQrIhnmEgu/0vQJ18jO7Bqdy5M34HWEUU=;
        b=DEJIm761d0gr6zIfYbQf3oAtTg5QP9rspfbFqI6OyfU/OuTIIHQU2d81riegrk3qeD
         rvvvP6rIilSlAaakL3edrtgHmqYTqWSDL859R36KcWYsP179dcCeYzEv/tNNvAwAup59
         mFTSU0NK/YF/rWYun+671VVGNZFND53RuvHJDImgApojD5UD6BjYPPYLb2JENo8azVmT
         fvWBuZoiR3m9RZOCkNLyWYguK7AJqGigoPT4WLKxKl/zMu7wvhq77Rxzzpru3KwzcpBF
         gqaIBe/kr735Kg2qO4lOyW7+NYOtXPTpY2iGslN3xWZLCogjlJQxHmJL5YghG3PJa1PV
         wGAg==
X-Gm-Message-State: AOJu0YxnofRbPk3dQSEyfuINmCu4H16lPkrjR5FCiTle6gsRUYLQjiVa
	RmCrenXE9XKvheq3If0adnU59+utca3OXyeKDq+3IhbTSCefxAZ1K/ir2q88v4PN7zt5s5GRPsL
	1mI/d5Lc3Ngt8ZqHCgr6KLGp6qoSRq/qdzDf8tmbDboSBYIV2s99zCTegXu+Gp4hsBHntDAg/g8
	/xHWGERNO8tKbiOXZG21cqGMXicBXjPvRv2FgVGA==
X-Google-Smtp-Source: AGHT+IGJmkm6KnPLp+UTKizUdFiKvVvxzvVp2kp6B1GpRmBHlDHXtMGM4LlpZWvto5tTJUw/jfGxHgiTXLbB
X-Received: from edvd13.prod.google.com ([2002:aa7:ce0d:0:b0:5cf:d5e0:dd10])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a05:651c:b24:b0:2ff:cfbb:c893
 with SMTP id 38308e7fff4ca-2ffd5fcc60amr119008041fa.6.1733141766053; Mon, 02
 Dec 2024 04:16:06 -0800 (PST)
Date: Mon,  2 Dec 2024 12:15:46 +0000
In-Reply-To: <2024120200-dangling-delegate-dfab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024120200-dangling-delegate-dfab@gregkh>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202121546.2369555-1-bsevens@google.com>
Subject: [PATCH 6.6.y] ALSA: usb-audio: Fix potential out-of-bound accesses
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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@kernel.org
Link: https://patch.msgid.link/20241120124144.3814457-1-bsevens@google.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
(cherry picked from commit b909df18ce2a998afef81d58bbd1a05dc0788c40)
Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
---
 sound/usb/quirks.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 37211ad31ec8..30a4d2deefda 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -555,6 +555,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_in=
terface *intf)
 {
 	struct usb_host_config *config =3D dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
=20
 	if (le16_to_cpu(get_cfg_desc(config)->wTotalLength) =3D=3D EXTIGY_FIRMWAR=
E_SIZE_OLD ||
@@ -566,10 +567,14 @@ static int snd_usb_extigy_boot_quirk(struct usb_devic=
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
@@ -901,6 +906,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *=
dev)
 static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config =3D dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
 	u8 bootresponse[0x12];
 	int fwsize;
@@ -936,10 +942,14 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device=
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
@@ -1253,6 +1263,7 @@ static void mbox3_setup_48_24_magic(struct usb_device=
 *dev)
 static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config =3D dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
 	int descriptor_size;
=20
@@ -1266,10 +1277,14 @@ static int snd_usb_mbox3_boot_quirk(struct usb_devi=
ce *dev)
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


