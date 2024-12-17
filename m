Return-Path: <stable+bounces-104493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA499F4B5C
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3D0162FFC
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6A51F37D7;
	Tue, 17 Dec 2024 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYpvp2hg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFCD1F03FC
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440201; cv=none; b=TZKUQRYrJDnE9/Ao+Ni9+KVJxP9+WSjnsXQccuGoI1bGglMNiaRbe9vJT20mElzBgTYJ2/1vshdhZU69OD8NM/PpVGTi5wi0hkQNUrzQ6t/g1J3WTDNqf150AWK7BV3iC6QamDpbzZlI2DaModZ7Rwit/wEF0HuUx0nsUR7Z+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440201; c=relaxed/simple;
	bh=jzlYZGfIdGbJw+nNohM7CbQ5qowXcv5C8ts+t6bZrp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XLuRHT9/shU/gqIslRMT2/FSCvREx1xn4ibDMkaBQueojR2Q/PGKl3bv1eioDVImdS8Z2HOARPxz9AweehufZS3ITZIjKCXH7ztqsb/se8XtrV95iOSTxOdSR7JyqH34/PooSgDBmt3B2xBy3nYdYdEwZnWgNYiCY1+DUT18A+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AYpvp2hg; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa6b69163caso499144866b.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 04:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734440197; x=1735044997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUHqbH0jmGE2OiijWK/wca8+H/1v9mkyPvVlU2CQpRU=;
        b=AYpvp2hg1W34pUEA0Lq6202jL6coNzUjBmmRUpWZtNpUhx1ZAgbvDqCUliEfriFiQ+
         O/dix9fmhuKeCM3/upUWfWobb7gq8ceE6EeFjBlpe70CMS02mPGOkFDZFy5AgtBP/KGd
         iSoVAQB6Cb76jOLvuk2gIzWX/T7wbDmIAmdb/KUL2cm6/sVh09KxhwAqcHPID0DpKSbO
         wSR1wZHFiL8/un+mnEa0xSg0q8RDEuXYAEFGdG1U61SM1a/8uScUm2MLhpipzqbtMdXv
         OpjqypdOhlRKuF5196Z1/UrJcOMsnt83ehNX1LGRO94KYlC45VrN6KmqSoq+DKya4on+
         M9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734440197; x=1735044997;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kUHqbH0jmGE2OiijWK/wca8+H/1v9mkyPvVlU2CQpRU=;
        b=JCk5eAsgVscXgJpi4h6SWfSpFx+oaSjuZIr9osjVyPGLFvn2g+4mt8x4pk85ecoCuS
         7X7FmaS8MiD/tSKNlmd69xEaP68B6uGZBCrlTHhNXvGirMFr+rBm2xlixaSkQc06lwVB
         5Dne+aEutF98oZYZ+BYQo0eDlp9GKUFnqxEBprpVyuEvrZGbx93Vx0kyu8sJCvXUgRaq
         8mTxhwl5LsZ2I2FqnQBQGT6JMnXvgDIwbwY5l1ziAJgvEndYBtG0egO5bc0scTdld196
         uj3wG5mY4Wh6iXzbVIW5Weq8Ky1rAIcIAstCDynQoSqeXkgbi9DNvO1BSwcRETjTheHb
         wR6Q==
X-Gm-Message-State: AOJu0YwALEFXLdBr8MiqcQ8jlb5AA71JmQbtyMtgbWMqRAVEWtySrO4Y
	KZ+yY3yoyi4N1Ksd3lf6XFRF3XJBjh32ORPnD71FdxR5wAPJWIMkbYu2PfIjFVOqwxMsyjEzbL0
	XTeCDQkffnBCgeL9hFK5A2rUcZJNbWjm+fDvgUd+6QTnvX2drErBzqi4bk2iMlujUDWMs6bSWgR
	Tnm6TJBsWtKBp63TrBi7gcVqsF8cTE1t1W8ocHZQ==
X-Google-Smtp-Source: AGHT+IHUsOFgyzI8K4LjGrkENON+9DOJk2oNQd4EzuaoNXYTQQaT3SEdP6maZrY8L7/8pi30bEgraX5lp9WH
X-Received: from ejcvt5.prod.google.com ([2002:a17:907:a605:b0:aab:7499:55a])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:7314:b0:aab:9f69:2769
 with SMTP id a640c23a62f3a-aabdb887b72mr333716966b.44.1734440197571; Tue, 17
 Dec 2024 04:56:37 -0800 (PST)
Date: Tue, 17 Dec 2024 12:56:33 +0000
In-Reply-To: <2024121041-unread-utilize-cae6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024121041-unread-utilize-cae6@gregkh>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241217125633.759793-1-bsevens@google.com>
Subject: [PATCH 5.10.y] ALSA: usb-audio: Fix a DMA to stack memory bug
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
[Beno=C3=AEt: there is no mbox3 suppport and no __free macro in 5.15]
Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
---
 sound/usb/quirks.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 9590c16501ef..eed155f12a1f 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -595,7 +595,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
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
@@ -606,15 +606,20 @@ static int snd_usb_extigy_boot_quirk(struct usb_devic=
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
@@ -946,7 +951,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *=
dev)
 static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config =3D dev->actconfig;
-	struct usb_device_descriptor new_device_descriptor;
+	struct usb_device_descriptor *new_device_descriptor =3D NULL;
 	int err;
 	u8 bootresponse[0x12];
 	int fwsize;
@@ -981,15 +986,21 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device=
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
+
+	kfree(new_device_descriptor);
=20
 	err =3D usb_reset_configuration(dev);
 	if (err < 0)
--=20
2.47.1.613.gc27f4b7a9f-goog


