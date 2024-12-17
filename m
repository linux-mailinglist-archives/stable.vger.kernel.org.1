Return-Path: <stable+bounces-104479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C184A9F4B1A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99A516F1E0
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04A31F1912;
	Tue, 17 Dec 2024 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0PIKFiCZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51D11F1900
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439180; cv=none; b=CbgP3rfHWpqTZL3c/fPqEuFSGEorzYBZ4T9JAnwC+/7lECElYn3SR+mAq32yyDm4EaKfeO7/+PLncT57gMqoTDsiIV2u2HjKWo4NnyRR67ghZz9HQQmjA7oCa8KR0AxlK7z6gjQRIP27TJoRPb6tzFOK5GRE8MnrGKAO40tHpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439180; c=relaxed/simple;
	bh=a8FTJTKerNuaYUcz5rCfjyET+Z8O0zvNZAucGdvLb08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BXty1TZ/hUWi1LPgsYeFXe5mcN5I4LP4CX3k6hUZyiIXJ5Cbz2qcEDlodD1ug7HcaZFpeTGkXroSem/z0jZrb7B/YqUrubuCt3xmclrLaqTRjW3eLHPKWbuoTMNoH6ny5+/mBDChqpjuC611HmrqIyYuf+tedZU25UKYYIKL730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0PIKFiCZ; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aab954d1116so352005066b.3
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 04:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734439177; x=1735043977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1ejDxSm2pT+9gWXhCf+eZckwW9qMfSKtyf8F/apAIw=;
        b=0PIKFiCZPtbhSIDP5CJNdGzF3uWicd2yWKgVbTK+14wf8k3uoQktlNrFF0CNGrxIuh
         rr1k5r6O5RvRqN41TDKGkAUrrRW7NJPeICVWOIPfy//4glhi6U0iZ041AreGhOvnjxdO
         qeI19NAbDDFdenLBuiD6lZzRc6ITLrNgzyrJUM9fGFK7SEvUcdWeH2aTtcy+nbKdhaSy
         u0AXJT4kyv7O6Us4+YL4u4iyjPIEXGy72O+NoUibqxFahZCKIOkS/RUK/Oj49np7lDfw
         i824CuCX0LYL9g6q7WKHxVqQDiD/SYADoFlDfwkw7uC11Q4IzrMeoUY52UBWEyhVMZPi
         wCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734439177; x=1735043977;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T1ejDxSm2pT+9gWXhCf+eZckwW9qMfSKtyf8F/apAIw=;
        b=bKS62yELcIiEGymV9ogIqLKl2gO6IUqif0TvWaGt16HQdkW42sDHtcUn9XyCZjJuNl
         yViOYdajvve7S3YzZ1d7OTIaJYYB/L8zEN3kjeTv+VmoTdaCIVxeGtbeJ88NThc0iK2t
         XBQDj5CgxyOYfUQJCPputT0egCmUTEovNFUudh/wkXrL5UkRf7xGf1dzqqSBRXrGlBoN
         mEYigH7LLYMvHg9zYCBqcl2/6EXe98r8kI7uv1vqrW4mb4kI8q1rMYf3MNy1CGoLFusH
         dNztHhDu821dC+VAgfyLjN0FQAsPv17cORzSXW+PrehaXzvyZYiK8CQldvX5CsmSmVM5
         1HLg==
X-Gm-Message-State: AOJu0Yxaxqq0MjdtqFiFWFhhdoNdkpMMVAaK9w/Nj2CgDrM99ET1+Q7y
	7dvwHXDxMANQmej/xVMLji/8LKFSwJ/Ltgf+P5RWpgF1RtWaiZ+ukZudFBTozR/C7mjio8xngHD
	aX4ptL6yzIQSN2Pjn8mItOeRjEw1tT7hbLfAelJa8rsbeMq5JDpWrZ5J23J026Mh3aIxYmqWNZJ
	vg7UhugK+6UKwqTWCclSp8BcUlVH3PuT1zFLGC1g==
X-Google-Smtp-Source: AGHT+IGoq05jFMqOtoq92MlkIZ0YnCkq9cAzJy+wJmBG8edWczh3bTM9Pz9wn4DijOabNQtbgvElKV4KYEMH
X-Received: from ejclb20.prod.google.com ([2002:a17:907:7854:b0:aa6:3046:c75e])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:dc89:b0:aa6:6ea7:e5a7
 with SMTP id a640c23a62f3a-aab779c7dc7mr1735342366b.28.1734439177123; Tue, 17
 Dec 2024 04:39:37 -0800 (PST)
Date: Tue, 17 Dec 2024 12:39:33 +0000
In-Reply-To: <2024121040-distant-throng-b534@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024121040-distant-throng-b534@gregkh>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241217123933.732180-1-bsevens@google.com>
Subject: [PATCH 5.15.y] ALSA: usb-audio: Fix a DMA to stack memory bug
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
 sound/usb/quirks.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 9d98a0e6a9f4..4c28a27aafdf 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -591,7 +591,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
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
@@ -602,15 +602,19 @@ static int snd_usb_extigy_boot_quirk(struct usb_devic=
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
@@ -942,7 +946,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *=
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
@@ -977,15 +981,19 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device=
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
--=20
2.47.1.613.gc27f4b7a9f-goog


