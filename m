Return-Path: <stable+bounces-104499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FE59F4C1F
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 14:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265D21790A6
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B0D1F4721;
	Tue, 17 Dec 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qm84QJbG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D411F1917
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441233; cv=none; b=myQtNvV9RkxBtJO1VPHhv79IRqXXy6wzxJj35wlF5oZ0eIr8ryVR7DGXfIlS+4iFEFR9YL2ETZNZsRBh+ZsmlmA9xpEbMhbARFp+KOxuHWUa14Gc3CZyRGhpJWUrXKkS5DCLAJSbfaWmaAnjTs0z9qIKNMrLffFnwZ2XEzEf7l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441233; c=relaxed/simple;
	bh=3l5fUmecd2rvQLPwn9lMIiuCS2xYl7anCxCVXOzjJQw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wri6IEPwkR/WGuqX9hEObuefk69DNK89ULiLW5j03Bnnz94kG+CfHAGACyGF2KRuQQT15+GV10L8rI3DBrABMdojZ/vo8R3NIayKwz55gkrExiWjSerRNPkSmfYtNKKbYQVzCfAYuUt/q2oB6czQpFCXm3UK1FXG803BQe3LMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qm84QJbG; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d3d6d924c1so2286775a12.2
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 05:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734441230; x=1735046030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QX1nkQV8Jjpe9LnApgX2X54HXTwzsLxsNfd9yFCpkac=;
        b=Qm84QJbGob7fIe+zIGXdZcj1HbDSPoRHBh3TXx5wrPZj7P2j/aXLpOi0rMEQ38RI49
         mYlZYWfbp4zQGIkVLaFbwlPKGFttAzq71Omt9IPyn8A7nRLsahdLJWqTilYZDqjEQAx7
         HkQZ0qBK3qYrT7WcV4/iu7HCOB5JCicZ4u9oCcprvDPpS0bSdieV4TCpN1zyPx7993sc
         51zDLkfRox/5fqlPcTZNk/6xl9EMkVS+jYMgZSvsys0RfMpxZ4c7lwD3Cwwpr4KOvV/u
         rSOhO9XLkJ3DoxHtYrV2yUU9ueOlAkfSycKB83pTOzX9eXmzdp3tBbde7BfamMr05ybS
         VtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734441230; x=1735046030;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QX1nkQV8Jjpe9LnApgX2X54HXTwzsLxsNfd9yFCpkac=;
        b=Pl8ICJrRImfk5UQCHOcNENV4FkbOJimgJKIq5+QdxEuwn+1Y5/T+1gj8o+UAh7t+Mr
         YzExE3EcLDQ5tqHUOlwuF7kcWnZcmDVG0fVeeaSS0XuUVB3HCfj6YN1Brp8NpI0gfHUe
         iSpGCTTNEvOrZ0ONhYtDiSfEeIKPlVJ3m6lfcTydkO5f/KU6hTtY1dLem5RawgfENoXw
         APDLmW+jL6rJ0NoeWHYnP5641xrdh5flxs7goLXuJs+7mCZjTNhVZ6cdjbzW+ioe1/+t
         eUUR4XZEicfXQoCYF/9cN8OYRgIdXADLMSt4mujxUgkHZgz56XEXy7+NROEizUPytIpj
         Qb4w==
X-Gm-Message-State: AOJu0YzK3Dndf8z/6uja5cJbn47HSlTBtpu7qX9Yd5BH1+wzOz5wHH/E
	+QOO9A5ugX8RSVVrclkVKX90i7wbCQMtTiViTAw0o+/LkvQDJKjFPlwW5z3rMsJ1BRmtRpanTDQ
	9i1jZdx98m8ofmYLysxCRz+O3pqgE2PST9oCHhBf7dekY0AuK29uIwVJfy8Lc/96D+uUH+7tbqq
	Hv9/8kGaYi13zJ8ZXgf9SlV5xq+HueTNIZ9+h4QA==
X-Google-Smtp-Source: AGHT+IFcoPckbiaibhRmAG+hYB5ocH/tteuPQhuXu7Ut108uKcEShfQFDHGgcU3EjRsJDWJVLyTNox9g8XMc
X-Received: from eda15.prod.google.com ([2002:a05:6402:a00f:b0:5c9:4adc:9cf8])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:354f:b0:5d0:d9e6:fea1
 with SMTP id 4fb4d7f45d1cf-5d63c33b6b1mr17001445a12.19.1734441229810; Tue, 17
 Dec 2024 05:13:49 -0800 (PST)
Date: Tue, 17 Dec 2024 13:13:39 +0000
In-Reply-To: <2024121040-distant-throng-b534@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024121040-distant-throng-b534@gregkh>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241217131343.763822-1-bsevens@google.com>
Subject: [PATCH 5.15.y v2] ALSA: usb-audio: Fix a DMA to stack memory bug
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
Changes:
- v2: Remove usage of __free macro which is not yet available in 5.15

 sound/usb/quirks.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 9d98a0e6a9f4..9f182c448d04 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -591,7 +591,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
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
@@ -602,15 +602,20 @@ static int snd_usb_extigy_boot_quirk(struct usb_devic=
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
@@ -942,7 +947,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *=
dev)
 static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config =3D dev->actconfig;
-	struct usb_device_descriptor new_device_descriptor;
+	struct usb_device_descriptor *new_device_descriptor =3D NULL;
 	int err;
 	u8 bootresponse[0x12];
 	int fwsize;
@@ -977,15 +982,21 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device=
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


