Return-Path: <stable+bounces-240952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAcxFm9162kQNAAAu9opvQ
	(envelope-from <stable+bounces-240952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:51:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C323745FC70
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81B81307921B
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D233E3D75AD;
	Fri, 24 Apr 2026 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KHmCZ5yO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9677D3D75D9;
	Fri, 24 Apr 2026 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038261; cv=none; b=EwYNhx3pb1gcB8hTX93dTB7kELu5Gz0n2Dle3laHy+/YUzsCEVu3zGXurvy6XfBaBFMKXjAOmQHZk/6Ub6HyjbpvVwQY3aqsdsaGigzElCTk98mvLOa0dUTKHWjr0GkK8ImuU2dxg98uMiIxBIjvhcO9vnfnH4vrnAcMpVtDEjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038261; c=relaxed/simple;
	bh=9Y933KnfbHMy3juAdJyeA80xi9ebUpk9OXZvo+ZppPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4Po5TQ433iuXv2iGJZrybek4GvxLIyNsWnnpz4Ol8gJ5xtg43TqKKhQkqyx06apUuGiGkufOzXV+Icoah4bCCEJSCZLqoaukqBZzaLigccYE/CdR5R0V93M/TIbT5TiAD/LWg1m3Pk7NkR8kcaf6YHh51FwRkoDU7zqCDFM04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KHmCZ5yO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED45C19425;
	Fri, 24 Apr 2026 13:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777038261;
	bh=9Y933KnfbHMy3juAdJyeA80xi9ebUpk9OXZvo+ZppPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHmCZ5yOUlTO4K1H3UOUi2SKBkYzSfQdNDN6mGeGOOdgQvi/bxK8O/qVpf1v14w1g
	 3hb0kleplix95FyEG5cV9viKy1uHo1hmphkEx1rKvqZvwaPHAT83Mr8z555ndaj/wy
	 qqP1rLdR/5Zx5/6YFMqyN09cdSn+1fx+Ye1LSbag=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Berk Cem Goksel <berkcgoksel@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.12 30/35] ALSA: caiaq: take a reference on the USB device in create_card()
Date: Fri, 24 Apr 2026 15:31:37 +0200
Message-ID: <20260424132418.090438321@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132411.427029259@linuxfoundation.org>
References: <20260424132411.427029259@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C323745FC70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240952-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,suse.de:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Berk Cem Goksel <berkcgoksel@gmail.com>

commit 80bb50e2d459213cccff3111d5ef98ed4238c0d5 upstream.

The caiaq driver stores a pointer to the parent USB device in
cdev->chip.dev but never takes a reference on it. The card's
private_free callback, snd_usb_caiaq_card_free(), can run
asynchronously via snd_card_free_when_closed() after the USB
device has already been disconnected and freed, so any access to
cdev->chip.dev in that path dereferences a freed usb_device.

On top of the refcounting issue, the current card_free implementation
calls usb_reset_device(cdev->chip.dev). A reset in a free callback
is inappropriate: the device is going away, the call takes the
device lock in a teardown context, and the reset races with the
disconnect path that the callback is already cleaning up after.

Take a reference on the USB device in create_card() with
usb_get_dev(), drop it with usb_put_dev() in the free callback,
and remove the usb_reset_device() call.

Fixes: b04dcbb7f7b1 ("ALSA: caiaq: Use snd_card_free_when_closed() at disconnection")
Cc: stable@vger.kernel.org
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Berk Cem Goksel <berkcgoksel@gmail.com>
Link: https://patch.msgid.link/20260413034941.1131465-3-berkcgoksel@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/caiaq/device.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -384,7 +384,7 @@ static void card_free(struct snd_card *c
 	snd_usb_caiaq_input_free(cdev);
 #endif
 	snd_usb_caiaq_audio_free(cdev);
-	usb_reset_device(cdev->chip.dev);
+	usb_put_dev(cdev->chip.dev);
 }
 
 static int create_card(struct usb_device *usb_dev,
@@ -410,7 +410,7 @@ static int create_card(struct usb_device
 		return err;
 
 	cdev = caiaqdev(card);
-	cdev->chip.dev = usb_dev;
+	cdev->chip.dev = usb_get_dev(usb_dev);
 	cdev->chip.card = card;
 	cdev->chip.usb_id = USB_ID(le16_to_cpu(usb_dev->descriptor.idVendor),
 				  le16_to_cpu(usb_dev->descriptor.idProduct));



