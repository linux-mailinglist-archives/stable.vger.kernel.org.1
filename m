Return-Path: <stable+bounces-96015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9BD9E0253
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C0EB3C3FD
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0F41FECAC;
	Mon,  2 Dec 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pX/Zgsnh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C254B1FECBA
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142426; cv=none; b=daHSFs3CFnQrjlScSZ6b3vPhRHSSk20iBD8oZK+6w5KK+ClcTbClsWsqpCwLcdsEgL/6/n6Nz0RmW7jaBEvOIt65+1jXJQZ/8lZqy0wNsAXZrHmCdkFGhASPYvC7uiGb4xFnfz/mGr7C7lMP4AbbfEqmFoddBJ4rvDIFlj/Xw1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142426; c=relaxed/simple;
	bh=e46+p85yND9m0N5vSoNswYgyBX34k/lFHzXsgmS4mJk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kCADghFgHRbWzvDIHtgDcwP0AfMCjT+GP+nsXdHF3e9OhmvUW40dziWXphqmT39eyq7sQcnXCcjZfnN9LSaNaeOzosqcj+Bn2ilOyaIPqrCJZhHToy4TkTen8FbL+VcvUHwDQuPdVpXG65zzWR+jdxCQ2lGqGHHLQx7OqqsiqpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pX/Zgsnh; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d0d0a5ae15so1412003a12.0
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 04:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733142423; x=1733747223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTJSSrtzybIpdmC9B/jWY2zmUcGZ7/i3SMTo2rD0RbA=;
        b=pX/ZgsnhbuogVzK/i+5eiWQ1QE5cexC57n3/gZx8603U0SK2xQa5cckJG3nifC8ceS
         Cl6XA7z6RbBq9VxEmbiIOKuSe40kmxdUihC4+R4eiLxzgWuAglW1knwSfbqzI67zJkuh
         erBZ3oc7eCZ/feP1sScrtESnsO+OnZpKVyj7wdSOsewuCGwYcYQxZkHcdgBtrcwXInMw
         yK94cR5rwcDGU60tT1dzXGFB7Jz9iIFkrmcSIsUIdVNr+vz9m2oP5VD8++FfFmju6aQI
         bI5FDw91BmENF/9ahPanW6S1ua7Q+qMJs91xgGSLGluo7Of2QfoyPOe9cPNOBL9hVpzV
         QoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733142423; x=1733747223;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QTJSSrtzybIpdmC9B/jWY2zmUcGZ7/i3SMTo2rD0RbA=;
        b=MrfDuACWAlEYBCN8cm9fySC90r2yXPjvpWB8WrudaPOeVNmkuPGhhYdiU24gpoxmk6
         AG6x3B1QdXjLDS6lG9eyumxMJtMVfkQYvVOvxMF+SSTD9X4KKBUsQrulmdcNqbQ6y3kh
         jOE24vN4UsU7l0+PxnVeTo51ylmgdMAoR4gyeGsFxx1YnvKL78zRIEQjLqQj08tGZ46f
         Ypr10zeGtyY8CXuKUYhy6hW0Tg/mGwrO4NkIFOpGmUXKiDIkveIiR8edRFO4XwE/NDjJ
         vaO3AP/fQmHX71/yDyqhTRNRijhWtfir0d0dJQWeZW0iqc5JDg5x03by2ae620ZsNqZm
         sFGg==
X-Gm-Message-State: AOJu0YwPP9T42IJsqiR/+bW0taHxrFrRlahES+O2xHOUyuWkV8A9GjJa
	H/s2QiEaMRFEK2TOnG1nuUMHSBPengzkwEFO8hRYj9kYlyMm7unC97T4irLD/uYMpu0+wzwMRWE
	vFDV2AC7HHXc/ctcUBV7+GNaWfoInFF86y+qONq1vL8cUV5FUooGW4tAs4O5xu9JApjn1mdmTho
	m9WridkR98Pd3iCw7y5mzFtpXQOJP/WNXE1JjNhg==
X-Google-Smtp-Source: AGHT+IFvsZXrgFVHLl4eLD96/E5S4ozsXnok4deUMNZnQt+S51zMdApsWB+BCrFM6j3fQudfLc6VC99Iz2Go
X-Received: from edci5.prod.google.com ([2002:a05:6402:42c5:b0:5cf:e102:91f9])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:430e:b0:5d0:daa2:73c5
 with SMTP id 4fb4d7f45d1cf-5d0daa2768dmr7641089a12.24.1733142423220; Mon, 02
 Dec 2024 04:27:03 -0800 (PST)
Date: Mon,  2 Dec 2024 12:26:59 +0000
In-Reply-To: <2024120201-raving-freebase-0206@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024120201-raving-freebase-0206@gregkh>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202122659.2387604-1-bsevens@google.com>
Subject: [PATCH 6.1.y] ALSA: usb-audio: Fix potential out-of-bound accesses
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
 sound/usb/quirks.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index e96f5361e762..795c8aa6564b 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -553,6 +553,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_in=
terface *intf)
 {
 	struct usb_host_config *config =3D dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
=20
 	if (le16_to_cpu(get_cfg_desc(config)->wTotalLength) =3D=3D EXTIGY_FIRMWAR=
E_SIZE_OLD ||
@@ -564,10 +565,14 @@ static int snd_usb_extigy_boot_quirk(struct usb_devic=
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
@@ -899,6 +904,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *=
dev)
 static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config =3D dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
 	u8 bootresponse[0x12];
 	int fwsize;
@@ -934,10 +940,14 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device=
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
@@ -1251,6 +1261,7 @@ static void mbox3_setup_48_24_magic(struct usb_device=
 *dev)
 static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config =3D dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
 	int descriptor_size;
=20
@@ -1264,10 +1275,14 @@ static int snd_usb_mbox3_boot_quirk(struct usb_devi=
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


