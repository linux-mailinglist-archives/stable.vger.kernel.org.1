Return-Path: <stable+bounces-96033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F382C9E0378
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6549FB2E7EB
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178B01D86C4;
	Mon,  2 Dec 2024 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wIGIr1Rl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249011FECD6
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145264; cv=none; b=dYE0zWf9XeKDxpKoQ0XbZiG5PyA4RXq6Me7zuOEEJJPFmk88e7nMt5trKtfyiksN49198LtWaAknSbsWxX0n3ZS3TDLUK9qoKz0ctVPNosQJFyiBVohImc2cBHghFORrDXXW1cOgTO8S148HkBr0T/KTYmWxHwU/IU/avh4GjQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145264; c=relaxed/simple;
	bh=Z3RYQ3oBMUrab9Gh6uW4MZC2Gl1bIeME1IXQGmMl8UA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XriT+iRC3GlqoO6s7FYgKVpYjnEqiUpHNveChW/P5+c9O//BKsPrNupYO6uT0sFSQJrd8TDKdvWi5BkvbB9jRHj/TAMy4gco1rq/5rZTL7WZ3F4IjO/1H4HDR9XSm8wm4t2il0Bf2fCRSnV2cRcdEZgCITP5VSCiyI2Pe8CP3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wIGIr1Rl; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d0c06ca986so1743977a12.1
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 05:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733145261; x=1733750061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otPrZFMAOtJD8I9Je2S59+gAeQ6LCVImJngl7uNxuQ4=;
        b=wIGIr1Rlfj/2rizLw1aJRuppfyk2b4IgTK61XSfsNmLqLchwZDpVto0ritEdBwKmC+
         0FPakDArOJms87TQaUWrfGVSQ2DGKsZnhsr6WfJf6Nzl2A7zuElRYR7QqcZyhQqNtwtA
         LK7F+0WK3LTZaiZ6usClhZV8V8h+VEh82bSKYVP82dr+x1ydMgwx3JsYyOWn3Sc1zAZZ
         la1R9jZ85FDtjl5ivA++bErHPgVhIUEix4ppVAua3Mnubkp6cymhNrRtWzc7Jw6gL5I3
         fvG+ysp0OtO13fnaQ7zgUke+Ti1GOHweZi2W6427So3RAW1V4DC1WoYoKu/uu3bnBV0Y
         9NfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733145261; x=1733750061;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=otPrZFMAOtJD8I9Je2S59+gAeQ6LCVImJngl7uNxuQ4=;
        b=PEpra07NMxZGwzqC472CefeFjvs8zsxjEevEBztnZ4UjzRdCWGB0EyvywL4EJ7ka8a
         uPHPB/uTMcAL6F4PHhP24J9jFGNyfzQFkqsqkwTAF1Sg6E658xt2BBBCF/CYQcpww+Sp
         xGHJ1nvkBuWk5qUFFXFF7XJBV0r65VEr+0klPmRLGBK9w+EDuNd8ZrKPlIYZpCU2p7IL
         rk1bSlyMTnfXs981FWSultZaNePpu1sFjlFhDqwkhS2io+YF9Xs10dp0tWsZ2wx+Ffz/
         IGedyJWTumZF+HjEkev2FmdCceWuqzgkaZ1hhCl7uhi4+kt6vokIzNuq3tqJllK47F2j
         jj3Q==
X-Gm-Message-State: AOJu0YzLG9xnkx1b3UFTKasdRrfORUxTnlJJ7B7K1mz/H4v3uqtTPUND
	kxRYJB98hXL2lFEm3NHef3KaTNqzOyTN6hvoyASSHEFM9+w6ilAN/CZ75d84m2dHGzx1KT9+AAn
	dJroj7e8NocF7GV3EdpglYPAS0rxYl3RYro/YSOuN6IqXsiUGgw5REyIts3GtgsX53hBfof+8z9
	WOicdCIh+N9Myxwd+sCoKb/PTX8b39DeP2H1kpvA==
X-Google-Smtp-Source: AGHT+IHLiA1BIevCLaZegTRsJt3K42xVv41p3iRB51D0lObVPsPeV3cMJXWGdbSmIYnkQRlQrWNgtoxCsBn4
X-Received: from edce26.prod.google.com ([2002:a50:a69a:0:b0:5cf:fec8:3cae])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:360c:b0:5d0:e014:dee2
 with SMTP id 4fb4d7f45d1cf-5d0e014e01bmr7461410a12.27.1733145261467; Mon, 02
 Dec 2024 05:14:21 -0800 (PST)
Date: Mon,  2 Dec 2024 13:14:17 +0000
In-Reply-To: <2024120203-overstep-undying-88a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024120203-overstep-undying-88a6@gregkh>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202131417.2496201-1-bsevens@google.com>
Subject: [PATCH 4.19.y] ALSA: usb-audio: Fix potential out-of-bound accesses
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
 sound/usb/quirks.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 087eef5e249d..54055d12476b 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -596,6 +596,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_in=
terface *intf)
 {
 	struct usb_host_config *config =3D dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
=20
 	if (le16_to_cpu(get_cfg_desc(config)->wTotalLength) =3D=3D EXTIGY_FIRMWAR=
E_SIZE_OLD ||
@@ -607,10 +608,14 @@ static int snd_usb_extigy_boot_quirk(struct usb_devic=
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
@@ -826,6 +831,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *=
dev)
 static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config =3D dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
 	u8 bootresponse[0x12];
 	int fwsize;
@@ -861,10 +867,14 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device=
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
--=20
2.47.0.338.g60cca15819-goog


