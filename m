Return-Path: <stable+bounces-104481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3699F4B2E
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C63116F17F
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857781F37BF;
	Tue, 17 Dec 2024 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0FLYgymr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3C51F2C23
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439407; cv=none; b=qcXjQiylxOh4XrfIvmetJ4IVIJNgrpMfzWLHwqhR0DUVTHp0IE1qosp8vgaQinoAT8rJHMtWnq0aT3GSCnpP7YEXJLowE8QywfoqCwbanxTq0iolQUjaaYZKqSHXjxPlESXjFmFvBosYEWVovTx+SOApmilW6AOUNNoo2T95EpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439407; c=relaxed/simple;
	bh=raFTyJlHNr0tFW1uld1VtwSUKqXpLi2xg/yVMVHoFuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SiTUGSqJIDJZFBOPfE0eHZkq2+AHQYUKcoopK1VK/1hROS8k0RQmf4MMaZGkaDyXI6Fjnii7sgg8r2J9WU67xZQBnCHjd7eiX2qozwK5JrCuNyY/3KYuP6/TZfEcGbAgZGnuVImWB69wC4STt3LQfL750rAXiQ+uNvNilu/qDjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0FLYgymr; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa68b4b957fso55927866b.3
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 04:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734439404; x=1735044204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CvH5yGVU8Hklsh/ZTDiMWlBPiLTi9uMIocC/SzJMXg=;
        b=0FLYgymrgu8DQ/iZp+QKFbopF9VnKfa/gjxYCiOoSjFqubL4r5DeOKyIBNPcRtL1bH
         4kjgls7YZoVKBy25FEGxvP+IjPx54ju+A16Q5fsLS72+f6o8rbI/DGIKL+sqvGbjzNyI
         GBthv0M6Qra1+n4Hg0WcRptp0w8oJhH7iSKJvxvqqpGpyNwETf/rcOyzVnmBvKt6GuZz
         2Z8/BXPM3tmHxZ2tMyf2iGYb3VkrO9J4Up7yyj5rJCZQbyzWsv9JUjRgwbAYK4AZU/KI
         rB0TUV+2NEHscwuroz20hGL7GyVWVX9mbzcvV3PyWJjAqfmE21FLqlck2J97b4zGUvRR
         V9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734439404; x=1735044204;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7CvH5yGVU8Hklsh/ZTDiMWlBPiLTi9uMIocC/SzJMXg=;
        b=RtFxvptL6LYP1kpqQnxkq9r95o9Z3MegvnuH7JZqzxghgxjiVRPW85Y3ZjTUTrdJh4
         rZm6gUNFXbpP6BS0c/GUdYdI84gVb+GNGlBaMzIB+4oVt94vizQZEUS7ZpbSiwYs1YV2
         uznm/0pEmaX5eNWJNpy+frzH6obgYdcZomAD+GOrtT/ubf73QYr9XEqiVkVoZV1xKH3b
         rhpvpTpKEdYc+EXQACK2JEef7n4AsUKV0O4r3/03ksgkw2m3Q4AgdYnyVQ5tLqeEIVKl
         Y9ZIV1PkJ+J1a6JSnd6Eni1mIpyHzSut4jNAwdGEt/kQGWmjaVNosKrEhow2rTwsjJyi
         42hQ==
X-Gm-Message-State: AOJu0YyRweSo0L0OsRvrstBIX1h2wg8/RJ3Lhaot3yT6+fgDng3peVxo
	tvW4RXm8DhtzO6+BlAeY+vU4BRXVBfZuEh+ocpRmOJfTEA317o2Wk2fplypzRQj+9CpJ4Rzv3TA
	kyXDDaO42P65LqfZCKz3wi0rzt/U/jUBwCIFfoqOKrr/y8BAWimavAaaklHrcD47nBOUwmq+Nw7
	M9iSImtZX9HT4IDdzNw9OmbSUdsCJ75//aUV4IgQ==
X-Google-Smtp-Source: AGHT+IE1ulpLvq4irs47ZqGF0pOzKxlh1OY0sNSqgJQgqfb5yWWvtN41/DVjRsksqpH9xtS+vxJg7ZH9nmTJ
X-Received: from ejbsi6.prod.google.com ([2002:a17:906:cec6:b0:aa8:75c2:8c3])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:6d0d:b0:aa6:a572:49fd
 with SMTP id a640c23a62f3a-aab77ebca50mr1487117666b.54.1734439403668; Tue, 17
 Dec 2024 04:43:23 -0800 (PST)
Date: Tue, 17 Dec 2024 12:43:18 +0000
In-Reply-To: <2024121040-distant-throng-b534@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024121040-distant-throng-b534@gregkh>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241217124318.734250-1-bsevens@google.com>
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


