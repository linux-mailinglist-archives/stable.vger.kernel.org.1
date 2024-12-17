Return-Path: <stable+bounces-104484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD8C9F4B45
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E979F1886D4E
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3B91F3D3D;
	Tue, 17 Dec 2024 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4splDKxY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959451F3D2E
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439946; cv=none; b=XAFbqEJjtz4yGd19Cpf7yAXtiTHDyEo7/GiwFEvZ8V/M9GWQ904IhhDjxsw7MVDKyMZkF5WUoKSwMMNrJ3KQRaMCt7eHizCQppZtGCIyNTuz66/fmlsMy6h+0qBCnd3BOHy2tH4X7e6V10rxPrRj99No3LjP/U6u3kQwEkWPaoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439946; c=relaxed/simple;
	bh=hkmwoVXvQ1nhmJPr92d6ah/Rh8Kv+6Cmxd6xJG9/ZDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PSeRWt747u73l+WkLaCUdDzsGOF6qNcM26FAeQvqw6Ex6kt7+WgM9cxE163aYWbJ1LSP2uye/E5CzlNnN3G4H8OTGLAYjANW7E0D/iO1/TZLi1FSVSPF7FJEV3M+mJPQ1cr56XINduZbrry71aYJNbrZ4Kp+6nOU+Y1DWpejlcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4splDKxY; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aab9f30ac00so227375066b.3
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 04:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734439943; x=1735044743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPK+Xtb63xj+eAlrB7VIAPqUn4Jqc5z2h0cW4Rcl1gE=;
        b=4splDKxY4RixhHqzMBPzmTaj5/2QqHWHEMdZJ7r0vH0r5jttfxMAmJH+WrvdwW3H26
         f+tI/Ntow4Lpv5svueVXKH93ny3PIByIMargdKRxeW/18y49sw/W8JQvl0f4pqTogp3i
         ntwdvHbi4ulew5FyIcBQnxcgB8IgPFhNp9MVAMCtbfFVvESWPOfzSsg1NnKcE0AMJbmn
         U0K0KBW4EXQ4Oo10lQoWLHMrYoPerDHxj9jK5T91SJpS/gRtPBMaWZva8WCqKI9LbXhl
         3LmTuWY90C4ngxt+Mgag18FFr9yfGgpgMrCZtxkBqECScnw/Cgmzl0bxTNvoHB2tegjV
         vNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734439943; x=1735044743;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mPK+Xtb63xj+eAlrB7VIAPqUn4Jqc5z2h0cW4Rcl1gE=;
        b=vX6Ygs3Xo9sg6DpRoFu/d2YpztrDaFNE1b7gAyEDwizk1dsfNn9RdIfAf+IHBAXEs+
         9e1bRP0ynr9UnJqxLduZjZPr34snZ+rCQS8MNkNwRiA/yHLS7jashWRQPZ5fhI8LcCVb
         VIuMqaBnmKcP38DrDxcLp1kaM48A9viRgwzBqkpKq/RANJq16EpX0khHa9iXMm2v455y
         b5Ce5jhoxNLbUTEAjJtZpJxNrBBUe5NecuJFIUcDiKfrQT/+6yAVuuNVdL32oobPSmDY
         DMwwsyfZ/sgrKoCxrbDI7YfDt7aacJL5h2vYtQf9sNSCobwCGwf6I4p/d3hI4cPX92Yo
         XTzQ==
X-Gm-Message-State: AOJu0YxRPL39r8fvDfd/HbZ3gvAx9ypsK+yDuHferFnNVEZB37cRm7hV
	J3B65+GoNGiTWMtCxnGWtkJLsand3rHRAY3vtMfJhFPcENkHW5nd/D+H9JIWnXaZ/eb/GePT7wb
	SWMVLwDXJm8Ea0AfXnAO1r9+A5l6uRfve+wJcd2jVa//VQ9xeuob21aFhSD69HCiTbmKYxkaRDe
	oryvhLcPMgrvthSWwrS5Z0nQ1UhK8TGZ7f+j9Smw==
X-Google-Smtp-Source: AGHT+IFz4Xc4NiNf9iMP8F6UlBmbwaYQ1EDcebErlMrR3FeQZAE7l6SzlHa3UqJdM2IKJlNRfUgB7aZ4qknD
X-Received: from ejuv2.prod.google.com ([2002:a17:906:4e82:b0:aa6:9b02:7fd2])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:dc8e:b0:aa6:78f3:47e5
 with SMTP id a640c23a62f3a-aab778df975mr1751755666b.6.1734439943101; Tue, 17
 Dec 2024 04:52:23 -0800 (PST)
Date: Tue, 17 Dec 2024 12:52:19 +0000
In-Reply-To: <2024121041-floss-compactor-3b56@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024121041-floss-compactor-3b56@gregkh>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241217125219.747509-1-bsevens@google.com>
Subject: [PATCH 5.4.y] ALSA: usb-audio: Fix a DMA to stack memory bug
From: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>
To: stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>, stable@kernel.org, 
	Takashi Iwai <tiwai@suse.de>, "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Dan Carpenter <dan.carpenter@linaro.org>

The usb_get_descriptor() function does DMA so we're not allowed
to use a stack buffer for that.  Doing DMA to the stack is not portable
all architectures.  Move the "new_device_descriptor" from being stored
on the stack and allocate it with kmalloc() instead.

Fixes: b909df18ce2a ("ALSA: usb-audio: Fix potential out-of-bound accesses =
for Extigy and Mbox devices")
Cc: stable@kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://patch.msgid.link/60e3aa09-039d-46d2-934c-6f123026c2eb@stanley=
.mountain
Signed-off-by: Takashi Iwai <tiwai@suse.de>
(cherry picked from commit f7d306b47a24367302bd4fe846854e07752ffcd9)
[Beno=C3=AEt: there is no mbox3 suppport and no __free macro in 5.4]
Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
---
 sound/usb/quirks.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 5f5075087401..df0a1d1721a7 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -585,7 +585,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_in=
terface *intf)
 {
 	struct usb_host_config *config =3D dev->actconfig;
-	struct usb_device_descriptor new_device_descriptor;
+	struct usb_device_descriptor *new_device_descriptor =3D NULL;
 	int err;
=20
 	if (le16_to_cpu(get_cfg_desc(config)->wTotalLength) =3D=3D EXTIGY_FIRMWAR=
E_SIZE_OLD ||
@@ -596,15 +596,20 @@ static int snd_usb_extigy_boot_quirk(struct usb_devic=
e *dev, struct usb_interfac
 				      0x10, 0x43, 0x0001, 0x000a, NULL, 0);
 		if (err < 0)
 			dev_dbg(&dev->dev, "error sending boot message: %d\n", err);
+
+		new_device_descriptor =3D kmalloc(sizeof(*new_device_descriptor), GFP_KE=
RNEL);
+		if (!new_device_descriptor)
+			return -ENOMEM;
 		err =3D usb_get_descriptor(dev, USB_DT_DEVICE, 0,
-				&new_device_descriptor, sizeof(new_device_descriptor));
+				new_device_descriptor, sizeof(*new_device_descriptor));
 		if (err < 0)
 			dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
-		if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfi=
gurations)
+		if (new_device_descriptor->bNumConfigurations > dev->descriptor.bNumConf=
igurations)
 			dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
-				new_device_descriptor.bNumConfigurations);
+				new_device_descriptor->bNumConfigurations);
 		else
-			memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor=
));
+			memcpy(&dev->descriptor, new_device_descriptor, sizeof(dev->descriptor)=
);
+		kfree(new_device_descriptor);
 		err =3D usb_reset_configuration(dev);
 		if (err < 0)
 			dev_dbg(&dev->dev, "error usb_reset_configuration: %d\n", err);
@@ -938,7 +943,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *=
dev)
 static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config =3D dev->actconfig;
-	struct usb_device_descriptor new_device_descriptor;
+	struct usb_device_descriptor *new_device_descriptor =3D NULL;
 	int err;
 	u8 bootresponse[0x12];
 	int fwsize;
@@ -973,15 +978,20 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device=
 *dev)
=20
 	dev_dbg(&dev->dev, "device initialised!\n");
=20
+	new_device_descriptor =3D kmalloc(sizeof(*new_device_descriptor), GFP_KER=
NEL);
+	if (!new_device_descriptor)
+		return -ENOMEM;
+
 	err =3D usb_get_descriptor(dev, USB_DT_DEVICE, 0,
-		&new_device_descriptor, sizeof(new_device_descriptor));
+		new_device_descriptor, sizeof(*new_device_descriptor));
 	if (err < 0)
 		dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
-	if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfig=
urations)
+	if (new_device_descriptor->bNumConfigurations > dev->descriptor.bNumConfi=
gurations)
 		dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
-			new_device_descriptor.bNumConfigurations);
+			new_device_descriptor->bNumConfigurations);
 	else
-		memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor)=
);
+		memcpy(&dev->descriptor, new_device_descriptor, sizeof(dev->descriptor))=
;
+	kfree(new_device_descriptor);
=20
 	err =3D usb_reset_configuration(dev);
 	if (err < 0)
--=20
2.47.1.613.gc27f4b7a9f-goog


