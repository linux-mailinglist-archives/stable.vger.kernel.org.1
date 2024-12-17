Return-Path: <stable+bounces-104477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D879F4ABD
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0870D7A6238
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7CB1EF088;
	Tue, 17 Dec 2024 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4scJWJWR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921761E5708
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437509; cv=none; b=u2rwYXJxkB7xIPr1eBIafRTO3vo9RjliWo4WFb4isgCX0o0qvo2M+sCCPT8dLsCEkvEnBMXAVbvDGlQA4pwM5/t17qk/Vi68HUgPHQg+ZDv9gp6fCdOMO+DUiOEHANZUVG7TbRGiIi1s5CkLlaG516xJzdf1ZL71gfmZqvOM9gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437509; c=relaxed/simple;
	bh=YwSQgTlbZiKuHzI25d5rspAtGb3XB+T3Z0a0+MxrIuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EJ3spul/nsYaDqMQHZYM5WIgCpJ1LuQVPD/rx48RWQxXulrLbPO8Omh5uv1+7Mk8ZLstfG1pxJt74f3YgcGg4dOWDozTRy50okv1h/HNCL+Xh8lo0sqOS1sREm6cigPHpcWOyzGpc+II7JAq1Nf0HDU1cQNxq8bnLg6itlZlXI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4scJWJWR; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa6b69163caso495660666b.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 04:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734437506; x=1735042306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AWpS0t2/C/DS9xfl9Yt36s3W54Ea/1AL3kJYwxhuDg=;
        b=4scJWJWRrLp7CSOOjvco/8aTM2L1UriQy0ZxXXby87wA0hJFxOIosvAbElBVpxhCu1
         qIM9ePnw0fBIHRbefPyBbzlc68xfepkm2a4zx2/RXDqC90yzhR8WxA3qzg52vMDXjbmM
         9KQ1pf7TuRpFadVo3GkE1TIvD42s4ideT8qUZ5G/N8t4UylbrVUM4GzxA4b2m+TlTrBA
         NW9vZM1K7TNy7eE8dRpIag0QQ8NXvFsOZSmprjigZVdk97hW+aqzdCqzYsZnOVdrlr17
         ibxZjuL0Jj/sJEJEuk45hIr5wnalbVikLYydx3BgEGNX8jvkx6GDYTvh4l7C9zNn7jpZ
         np7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734437506; x=1735042306;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1AWpS0t2/C/DS9xfl9Yt36s3W54Ea/1AL3kJYwxhuDg=;
        b=ZHzLQEMXIJGQ98J5mWHfyeJNvd4EvDYkCFptGXtrWCgrsfPBtdaDsCsA9C8Zt64vJD
         JHySmu3TkSkd64DE7GsfJiGR7gC81KSLMRsXE73otz+yTT/0yB3CLePuF5ZEt4r6u87I
         2a1UXC7ZCM3/bk0RFRisGNHqR0mEDNqoyqZQGtKA5KAjHBTt3Rj8iYTmd3EiZsYtVURG
         1ZV4aytdh8+L60v+fFNhksSTcaXwvllYmsJrMuobBLGyAV8rgt25v2p0SkMXTQ4/8H/C
         2yQ9fZUYGRE5dBBoTSPXfnXNdCCVGTtGxnww6t1f+UugMRQJvVh0cWCRqtGiEFXZvY9g
         24GQ==
X-Gm-Message-State: AOJu0YydNp9/1mEGVNMIy9ctcU2GbDSaaHxIbXUg6FFSBDNCl+Nb7Mi/
	AujH4AkcO6Q0syWYqfUkRqWoOCY7aAwiK5gP5fBoVt+qDMLobhTcmV49kXS5wWF+kNdJW6QrKBK
	oX7nCQUNV3zV+V86whDb2iRi5aWhbZquMERo+jMyb0l3hmBX0jIV/6gUapOFWlYZNUR1C+qJAm8
	P5q1sQ7Pp76ri692vF8OATavbYW2rT9QIaKUVBqg==
X-Google-Smtp-Source: AGHT+IFuL/6HblwVKUpcNf2FDrmFQBgp2V46AH9ZoR0KYvNM2XpSmFkXBl66tXTWZgflOojnBrcDd7c/hH+R
X-Received: from ejcvs4.prod.google.com ([2002:a17:907:a584:b0:aa6:8566:9630])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:1ca7:b0:aa6:98c9:aadc
 with SMTP id a640c23a62f3a-aabdb3c0f6emr352420666b.31.1734437505717; Tue, 17
 Dec 2024 04:11:45 -0800 (PST)
Date: Tue, 17 Dec 2024 12:11:41 +0000
In-Reply-To: <2024121039-starch-convent-cb20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024121039-starch-convent-cb20@gregkh>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241217121141.705217-1-bsevens@google.com>
Subject: [PATCH 6.1.y] ALSA: usb-audio: Fix a DMA to stack memory bug
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
[Beno=C3=AEt: backport for changed error message format]
Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
---
 sound/usb/quirks.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index ecb49ba8432c..4efb9cb7382d 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -553,7 +553,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_in=
terface *intf)
 {
 	struct usb_host_config *config =3D dev->actconfig;
-	struct usb_device_descriptor new_device_descriptor;
+	struct usb_device_descriptor *new_device_descriptor __free(kfree) =3D NUL=
L;
 	int err;
=20
 	if (le16_to_cpu(get_cfg_desc(config)->wTotalLength) =3D=3D EXTIGY_FIRMWAR=
E_SIZE_OLD ||
@@ -564,15 +564,19 @@ static int snd_usb_extigy_boot_quirk(struct usb_devic=
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
 		err =3D usb_reset_configuration(dev);
 		if (err < 0)
 			dev_dbg(&dev->dev, "error usb_reset_configuration: %d\n", err);
@@ -904,7 +908,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *=
dev)
 static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config =3D dev->actconfig;
-	struct usb_device_descriptor new_device_descriptor;
+	struct usb_device_descriptor *new_device_descriptor __free(kfree) =3D NUL=
L;
 	int err;
 	u8 bootresponse[0x12];
 	int fwsize;
@@ -939,15 +943,19 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device=
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
=20
 	err =3D usb_reset_configuration(dev);
 	if (err < 0)
@@ -1261,7 +1269,7 @@ static void mbox3_setup_48_24_magic(struct usb_device=
 *dev)
 static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config =3D dev->actconfig;
-	struct usb_device_descriptor new_device_descriptor;
+	struct usb_device_descriptor *new_device_descriptor __free(kfree) =3D NUL=
L;
 	int err;
 	int descriptor_size;
=20
@@ -1274,15 +1282,19 @@ static int snd_usb_mbox3_boot_quirk(struct usb_devi=
ce *dev)
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
=20
 	err =3D usb_reset_configuration(dev);
 	if (err < 0)
--=20
2.47.1.613.gc27f4b7a9f-goog


