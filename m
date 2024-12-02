Return-Path: <stable+bounces-96017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76269E0252
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0282283045
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38831FE471;
	Mon,  2 Dec 2024 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XqDaGtwH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDD31D86C9
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733143147; cv=none; b=LoITbw4gBg9unSTgxQ3ttsr3MwZFrdGa5KOFghYKD+I8fJfLpPJYvz3YgFfThY7N3ulrSEGFzk1EpkueF4Fw6SIuXGIdDxP0EpBkOzWmYlNwx4h/spXrlPd7pqsS6R3hUIK1psGLQM6FCuwMCsIo74mMaU0sVzkKtr68GPWNXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733143147; c=relaxed/simple;
	bh=aDOzvkys3oGGtRD2VKs9112rEHoEMNs2jAAMLzXi6J0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HVssLFSD+dR+zbq9/IRXT+hN9A7oYreY5Qy0o/5k1/xXrenY5GHSjSGGgyMLGql2um/76OrumaOMRq20eDg1r1F/PammEf15WuyMrUdpq5/O/tUvMMTk7aC0rt/+PaZ8I6sc7YcqHUDpqlVWVEH0ZrXlTsO8zfpVuLbn3B3n95g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XqDaGtwH; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa543b13532so247463566b.3
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 04:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733143144; x=1733747944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kh1s6/GDKuS9xD7IKJfrRPXbQZCd5TWgKgyl2lIkhxg=;
        b=XqDaGtwHCTw67sbqowsvLjQbfP0BacFXjUVANmRmiCLRYgGLLfGeAVivwO2GK2EMQc
         P9/smS9xp7agCzLV0HjrSYbCS5a9oKEgmug+P72yeoL7Fis04ykN/ClxUf5KAu3C0jSw
         88QqZSMAIxFDoklyrXjM82P3rQKRqHqprNyxiT56D1vWTkbOPC2kG5oZ8LTRnC3LG2nH
         A4t+4+a6bey/duMhSM4oxGqahHiB3h89hGVA3a9K8tc8V2bU7GttiIXtm3Y2mA41iAi7
         +K4V9cTpAIMr2gAu8Tqcjlgc8yZgqr27veSb/NuinFF5y13j5de7mAnT1WH6q0g+02gk
         l9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733143144; x=1733747944;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kh1s6/GDKuS9xD7IKJfrRPXbQZCd5TWgKgyl2lIkhxg=;
        b=TgyPZ4sx5xYCMN7L9dUMZchMqUO/kNJwHKXUtFJUvU69vmFpe8fC1oaWiheqt2ZBuq
         nfdT9QJccpynJqTtDrnek+EAEJZjJTDXZ0/sFAg5e8iIB95LqWtM5Aev+b0DNFc3rVP8
         XdKcneCx1VJrBDeJiiA571FbWE1ko2u2H6p1imlFX5zYVu47hBelbR7XLNgFEdKUpNlv
         E5lMiRXiaa5gIJKVU+kVwFp4CwpPy0mCzYzXhlcnu3EALo9pC3CDlJ3qsthQUDyMe3zs
         A8D4oKx7sLhjBynzfvEMR+YOROwguEZ/NXWZ2KQKnyIE2Sn35cxRS9Ol6kQ2kiq23rji
         Xl1A==
X-Gm-Message-State: AOJu0YwWeHwEFd5lw7h+JMs5JTYmQtvfyK5o8Lx9CkbYLbCzFcwI8hLe
	aGVK1lEgh1Fg/dDKButKftmaiWj6raicBpjAQBdGfXgphphq4uTapYvS5/KDU5C1RC/23OL4T5C
	TPdU98hiczJuAganpZ0kcJ9t/+ET0VDAcKW7pv+AolF+Ez5SMQXzCoIbEIxAG0smqg/tkqSPG/w
	WfaczmaLFywvMmqCw1/JeThVg3D5WSpYg+2G9MDQ==
X-Google-Smtp-Source: AGHT+IEijTSGqDuRc9oWcdCJcmFINK5QFXCwO86XShoJhGICS7Q4QudObVMNy4hBQOp4reKTOof+I5jnOXA8
X-Received: from edrd15.prod.google.com ([2002:aa7:d68f:0:b0:5cf:bef9:b656])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5179:b0:5d0:e826:f10a
 with SMTP id 4fb4d7f45d1cf-5d0e826f2dbmr4661231a12.6.1733143144237; Mon, 02
 Dec 2024 04:39:04 -0800 (PST)
Date: Mon,  2 Dec 2024 12:39:00 +0000
In-Reply-To: <2024120201-prudishly-enticing-cb97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024120201-prudishly-enticing-cb97@gregkh>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202123900.2397922-1-bsevens@google.com>
Subject: [PATCH 5.15.y] ALSA: usb-audio: Fix potential out-of-bound accesses
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
 sound/usb/quirks.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 1d620c2f41a3..9d98a0e6a9f4 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -591,6 +591,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_in=
terface *intf)
 {
 	struct usb_host_config *config =3D dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
=20
 	if (le16_to_cpu(get_cfg_desc(config)->wTotalLength) =3D=3D EXTIGY_FIRMWAR=
E_SIZE_OLD ||
@@ -602,10 +603,14 @@ static int snd_usb_extigy_boot_quirk(struct usb_devic=
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
@@ -937,6 +942,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *=
dev)
 static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config =3D dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
 	u8 bootresponse[0x12];
 	int fwsize;
@@ -972,10 +978,14 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device=
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
@@ -1020,7 +1030,6 @@ static int snd_usb_axefx3_boot_quirk(struct usb_devic=
e *dev)
 	return 0;
 }
=20
-
 #define MICROBOOK_BUF_SIZE 128
=20
 static int snd_usb_motu_microbookii_communicate(struct usb_device *dev, u8=
 *buf,
--=20
2.47.0.338.g60cca15819-goog


