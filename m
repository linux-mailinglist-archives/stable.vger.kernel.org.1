Return-Path: <stable+bounces-249773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMBeC2pnDWoKxAUAu9opvQ
	(envelope-from <stable+bounces-249773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:48:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D6558925F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 360A4301CFB7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 07:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E22837D11E;
	Wed, 20 May 2026 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="xjt6SYZH"
X-Original-To: stable@vger.kernel.org
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1423783C0
	for <stable@vger.kernel.org>; Wed, 20 May 2026 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263089; cv=none; b=JYELtuTD5ZKFP1Z8hcHNNpHvKjaB8WvI73RXQI3mzlmVixmhBZJSYTCcCvdbARrKjC9pkPxoUXdMRs4qW98NI19StDawFexA3p52BmypjTAZc3zxqAQ8QOYBZRKlx+tj5i3pDrUCA9ipOeiLAOoeJqh3lhNl5Z48wD+TXn1SJk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263089; c=relaxed/simple;
	bh=uXkYFxdaAETwxJgpORJBxdQY2Eu+hISiH3UitJQD50c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KR2R8FImPUcWflZrcD2HCF/gb005dPrSS6vtj2e3kqznJRBhc+CRMGHuXiFFk7RnTXRbJWzRTTTgKLNqjWDU2t4ILO3MtWtcc0rqHeuue9H3sy8iRY+f9Dx15f+bdBjkzK6MpAE1cEy9h56IGMvhzmKh35mkdycD6ML+MHz7I/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=xjt6SYZH; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1779263085;
	bh=VbljUZZ+f3x/ZX7/096BB0jO8aeqIRyL8nsBVLH0DC4=;
	h=From:Subject:Date:Message-Id;
	b=xjt6SYZHxbJaafOHHmzxONuBsJfJlFPKWCQSDHNKDcqtyXKWVMGfy93WaAJYmNAMw
	 86NFaUelYtMPDsJndojYHnQUCUXFA2PHYYcmOLsYf6JUk+cAhkJrDDdCQntt9cxKzB
	 c1xN5zfdA0MhFqbUvxt7hYKwe016jx2ZBBIG7T/E=
X-SMAIL-HELO: NTT-kernel-dev
Received: from unknown (HELO NTT-kernel-dev)([60.247.85.88])
	by sina.cn (10.185.250.23) with ESMTP
	id 6A0D666000000184; Wed, 20 May 2026 15:44:34 +0800 (CST)
X-Sender: jianqkang@sina.cn
X-Auth-ID: jianqkang@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=jianqkang@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=jianqkang@sina.cn
X-SMAIL-MID: 9922928912952
X-SMAIL-UIID: 28CF97DE4ACC47EE977A656367876B80-20260520-154434-1
From: Jianqiang kang <jianqkang@sina.cn>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	berkcgoksel@gmail.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zonque@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH 6.1.y] ALSA: caiaq: take a reference on the USB device in create_card()
Date: Wed, 20 May 2026 15:44:33 +0800
Message-Id: <20260520074433.3784952-1-jianqkang@sina.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.cn,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sina.cn:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,perex.cz,suse.com,alsa-project.org,suse.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-249773-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianqkang@sina.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.cn:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[sina.cn];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sina.cn:email,sina.cn:mid,sina.cn:dkim,msgid.link:url,suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 91D6558925F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Berk Cem Goksel <berkcgoksel@gmail.com>

[ Upstream commit 80bb50e2d459213cccff3111d5ef98ed4238c0d5 ]

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
Signed-off-by: Jianqiang kang <jianqkang@sina.cn>
---
 sound/usb/caiaq/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 910b2ee83a17..b66737792ebd 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -384,7 +384,7 @@ static void card_free(struct snd_card *card)
 	snd_usb_caiaq_input_free(cdev);
 #endif
 	snd_usb_caiaq_audio_free(cdev);
-	usb_reset_device(cdev->chip.dev);
+	usb_put_dev(cdev->chip.dev);
 }
 
 static int create_card(struct usb_device *usb_dev,
@@ -410,7 +410,7 @@ static int create_card(struct usb_device *usb_dev,
 		return err;
 
 	cdev = caiaqdev(card);
-	cdev->chip.dev = usb_dev;
+	cdev->chip.dev = usb_get_dev(usb_dev);
 	cdev->chip.card = card;
 	cdev->chip.usb_id = USB_ID(le16_to_cpu(usb_dev->descriptor.idVendor),
 				  le16_to_cpu(usb_dev->descriptor.idProduct));
-- 
2.34.1


