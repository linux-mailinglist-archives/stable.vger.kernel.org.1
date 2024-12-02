Return-Path: <stable+bounces-96021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 293919E02FE
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC24B26649
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D2FA95C;
	Mon,  2 Dec 2024 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w+grWBqI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7372D8F6B
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144772; cv=none; b=ltU/vr9oGxGYoPxGqNw26vRxcdh+eHRG4BQTULGgvy90IKiPNlLmN2EeA+IAZw21RycDK1OjGUe0h0Ejv69bkDWaIgKvMZ4vdjs/k6MXiMeAs+kFFemxmVNaYozd/XPCNWTVU43viI9SATTEoBPl9MYw+yLn/5zatIj8KvcIM8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144772; c=relaxed/simple;
	bh=TqyNHQRithNCYMpstn6Fg2+qaRInNSt2ce3lCWue93s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X69FUAsL5ZpaPmnM4sSsTup2H4mmrHzpfMDqV6GhXnH+LAsDB4CKlRZPaObAeOzkMPYaStZqYCKe2EurkBWYwhYC+1LVwHjMonql5WI8vDA3L+Qd0LA9MHbb2iH9kVPU9yTtwV1JBJU6LVflBlgjBrd84UM6S2W7PBiLxDIdCl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w+grWBqI; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d0ccbbc4a7so1321526a12.0
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 05:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733144769; x=1733749569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uo4fr4yb7FL+7HhC+2wLdt090BKs2/sDKup7ScdkV6E=;
        b=w+grWBqI58owYctUwlQRanFnqk8MWDCaj/k7S4WyMOK9BtGZLzMnJYnzT7GVnNhi2l
         s23hb+rKxByIsuFSJSV3sBhpJureMz+rJ7XaR/pE0RzUVTkOYGAv21FCwuqU+9NtRIRf
         xziOd7iWeZ7B4VL1iU8TMQfvYWZ5YophAJDwZ0EeS/kreyoUYy9ohkrPzwIkuSh7bqEo
         G7JJeZ0yCLeREc19CQarnQwDFwx+tYODG9WXkQ0n6oLETbsfpSGJ0jt+ftBd6MEhWyFP
         k/x+n23DuHQTMflTHAxiZfEPgKOTIfdkXI7v15WcqDeIlj/SMyUvRtmao2989in4w4Bh
         D6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733144769; x=1733749569;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uo4fr4yb7FL+7HhC+2wLdt090BKs2/sDKup7ScdkV6E=;
        b=i/HQxcXE0LtbLzw4LH0Z/i6EhmmWFEqh7q2Qhfba5HOTB+VqYbT9n7Eq14JX55QXl4
         LCWTxZHRPrnGTjmPqdgjTGTUGqQEBCVtasoMH93edOjWJTdo0NVXhcPmdOV74ffP0hYU
         gJbGifDeSTE2BFnTyTdVBXutA/5htEapSSVzWJxnH4agnpVBSRe0q7/wK+kpVcdven5w
         /4v6AFIlhtiGywXQQuHzTIahIXtGOH0iqkrUxzJjMbumCfxXc8rwXsiWsIoZOgf5+rdf
         lK9ZgyXNoYruITcrudp/skbR18OG2Vl2xqvDD3FQR8X3ibJ/iqp8HYfhqgoQvVhz9w8j
         8XaQ==
X-Gm-Message-State: AOJu0Ywm+Z2SfOyI5ihsAdmIda+3M1eTBT1FFZkI4YuCviITdXes3BxF
	HnDYM75cGxyoFPqKyS0LRahB5A+ZbXjWn65Tiw4jMWFSXotFM0BSUc3ZxdAIJeAtCLi1Azg8rAh
	aW+D9UMJYKI3462mxKtadJWOdkU5KuZJkXX8101fcVmGG9Vt4397ylJU4eUF8xBTAdZFI/r5AiS
	bV/YZEfNEi8H+Qbcwef14Fw+oeOFceDAJvqcIHgA==
X-Google-Smtp-Source: AGHT+IGlrc9YWAakHzcwMOpMq+8xVmqo+oRMIe3Y1Q4sjKoYPGeeMLiq6fBi89iIr/UZO/0LKdXV2kKaM5r4
X-Received: from edwf11.prod.google.com ([2002:a05:6402:150b:b0:5d0:2a22:1cc1])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:354f:b0:5d0:214b:9343
 with SMTP id 4fb4d7f45d1cf-5d080b7c8bfmr22617063a12.4.1733144768751; Mon, 02
 Dec 2024 05:06:08 -0800 (PST)
Date: Mon,  2 Dec 2024 13:06:04 +0000
In-Reply-To: <2024120202-waltz-skid-0e47@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024120202-waltz-skid-0e47@gregkh>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202130605.2475446-1-bsevens@google.com>
Subject: [PATCH 5.10.y] ALSA: usb-audio: Fix potential out-of-bound accesses
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
index 752422147fb3..18c879ddc076 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -595,6 +595,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_in=
terface *intf)
 {
 	struct usb_host_config *config =3D dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
=20
 	if (le16_to_cpu(get_cfg_desc(config)->wTotalLength) =3D=3D EXTIGY_FIRMWAR=
E_SIZE_OLD ||
@@ -606,10 +607,14 @@ static int snd_usb_extigy_boot_quirk(struct usb_devic=
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
@@ -941,6 +946,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *=
dev)
 static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config =3D dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
 	u8 bootresponse[0x12];
 	int fwsize;
@@ -976,10 +982,14 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device=
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


