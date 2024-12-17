Return-Path: <stable+bounces-104476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A85C9F4A7E
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821F516E8AD
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 11:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A034A1EF088;
	Tue, 17 Dec 2024 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rbq/PfQK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8931F130E
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436747; cv=none; b=PK5NaXN+iE/M8cDzxD/ivdXRbSlCSdiSR1ReZdzn2ylcUhrivyTNSoTaf4VH0povVnucI0YEFPn52Nc5leZxrNFZ6hJIg5KVK2M4wRRvcGnEcUJ9ZvgrTluGI/PxUzKcCeDlbHHRHMfHq5JuS2Jqy6yyWpBisvNDHCMlfp2nKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436747; c=relaxed/simple;
	bh=aNt2BwmLUct8rkd7o7tf0p+7iI751+elzouhI6CQ6cI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HNgyeXVFRuX9GFMh2VfoAete60dyNAuyHXu6/2TiJTBZjbKGoqfMOg2DeeQ7giYAAoeJtyEQenuTkoTs8QuZxba5UNp5hKoizqWhzXR8vVYPd4BkKKuPS2rEv4N1kJHZa/wZI5TMyyMYIz9EcPFyRK+D07D5JiCzdR6qoX9twTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rbq/PfQK; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa622312962so520513866b.2
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 03:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734436744; x=1735041544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFLG+Mz6+rXw/fKG095FB7K/CJc89nhaVW+lx+ctidE=;
        b=rbq/PfQKYNK4yvXYD9GhE2WJAG0DOH6iuW11CaBK5tUux1xOyOS/jTNrFQIui95vat
         XfQyO90tG5JIgD2bgqkPWwhF0itTNdsWbTQtpNbGBLdkEFpdYBN5cQzPvax6ayj8BOPI
         I4oZOy3WqVb2Li20JT206pLn9i0MsB44/EO9x21ThxIAwfB9MMDNNsuwJqNh/x86JJny
         UfowKpaqFKJkIggmlwm5goY7YtTRLUZamNcpD5DMrXhWGigItITGbrS9un7hlQs6wewx
         KfKwXmxIP9VUK48gOOGA0cmlZtuGw6MPHv4oINVeVMp1gmudbc+ywwjjRI4RkvMoHlza
         7yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436744; x=1735041544;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mFLG+Mz6+rXw/fKG095FB7K/CJc89nhaVW+lx+ctidE=;
        b=blt6iory5iV6NteUgYHo3jLDEoNGY/R+iRihy846961zkatxsKmo3kJ1BVvy2KdKSj
         s8XcJ6+tT/TS1pSODaIkFDj/M/sfqwb5dR8ghXPjE9EM/CjOJQUP2xtb8WIpiIT0ZEaH
         3valRSW4jHhY4qNC/CZ5W9wUqQ3BbFMuOcvjsaJWGhdoVQjManC1QvzdDQUUh5t/ZxbO
         LAvlp3QHHsjTyfQYJWGr/l9mDSyQ2H31gLZ/jxHr0OJD+cYy8blVS4nRz0/wI/C19rtB
         ryy19npZViFIVeR6X1kl3uywMmOdlyPzP6pJTjcOcSPyuhP0FWzZeA9vUysfvist42Hk
         fTug==
X-Gm-Message-State: AOJu0YyP7+GRPUVKeBXZ6wlbCoTI77QHIiG1s3Camyqg5jRi1GsQoD5L
	A+Mii0++ahi5K/WMKE3zSI1KFETWpXRlgqq0jFZt8myF+XqSWOLkV/9SxnKHodV+4r9DUGmM5GL
	HOR3R/p/c4wIJJERrBlDLuJmbpt2gB0uqRlzn4rw0DFyTUHpeeYo+61yOhHafx+QZmr4sI3RNpX
	278cGLy5RDMFTaTYRL3eRKbUApKwNIEAMufzpZRw==
X-Google-Smtp-Source: AGHT+IHs4hV8oyjrG6TDx1HwTMFLjdWMXF76XDWhmn78+b2F2wxOFkxuvDiKfzzKYvmD6a3+eqx09JlAM+ke
X-Received: from ejcla18.prod.google.com ([2002:a17:907:7812:b0:aa6:8676:3b2b])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3f23:b0:aa6:2a17:b54c
 with SMTP id a640c23a62f3a-aab778c32fcmr1850852266b.6.1734436743908; Tue, 17
 Dec 2024 03:59:03 -0800 (PST)
Date: Tue, 17 Dec 2024 11:58:58 +0000
In-Reply-To: <2024121038-scratch-explore-9597@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024121038-scratch-explore-9597@gregkh>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241217115858.688737-1-bsevens@google.com>
Subject: [PATCH 6.6.y] ALSA: usb-audio: Fix a DMA to stack memory bug
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
Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
---
 sound/usb/quirks.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 65c44649c067..6e970e61ce93 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -555,7 +555,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
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
@@ -566,15 +566,19 @@ static int snd_usb_extigy_boot_quirk(struct usb_devic=
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
@@ -906,7 +910,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *=
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
@@ -941,15 +945,19 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device=
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
@@ -1263,7 +1271,7 @@ static void mbox3_setup_48_24_magic(struct usb_device=
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
@@ -1276,15 +1284,19 @@ static int snd_usb_mbox3_boot_quirk(struct usb_devi=
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


