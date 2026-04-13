Return-Path: <stable+bounces-235885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLfBKBBo3GnoQQkAu9opvQ
	(envelope-from <stable+bounces-235885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:50:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E723E7070
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A0E123003634
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 03:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8052337C11C;
	Mon, 13 Apr 2026 03:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5LjrD+j"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C135F612
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 03:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776052238; cv=none; b=eaY1m30/YqWa1qfo40kgs7voXMO6HZxbha+Ac3rf5gBzsmSgpBC8DXZVNXbAs7Eik+UlTAfdxN0F7Hbr9sJQZdExA0bCrWOnndcqV2CXq5kU5dohPBQcdbbOGbLathA2i4CqcanYaLIWCXxXvcY33lnAD/JhcnI3QOF8FuYpVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776052238; c=relaxed/simple;
	bh=Wrj+gdpP6ITRJA8dSWGbh5zoUNshnIIubPM7stoPbPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PiEkpPuQgG8rDISmZIMeAUumdiv4PTMtC4g8oL6N4W20asB+37Kh6wmN5GTdn3M6LolxcYlHvj/P9r4nIFTh3Y0rDc8YojoFZYIFlx2/Was92PJH8XqTSTOgaa8WxhBPCPTqz6uYX6PVvt82Q6g4QygtUYTANXNHr+ritBFxfCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5LjrD+j; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so2466216a91.2
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 20:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776052237; x=1776657037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5SGpOXoxl9RjzaYVEFaZVgctA66UXg9R08vi8wYY78=;
        b=X5LjrD+joWY6G4BF5W2RDofpPng1J0woMsnwEf9gMgwc+3vJJaBfYumhv6yaWlBmYF
         E//PCVfm75W1mis95sxzVK6dqLPZ+XsBlHNC6Pqls9IterP0m0HtHpH4rz3QgR8TPI8Q
         9XbTxmunvAg5nfCIpcGiW228Ry4FSrHzgdGjbkTaX8V9Jta/Js7iTiLwq/d/cldAsbrm
         Owe+stzvrBud4svOGH0WAm/E0T+td99F7gn/ljryW7u+Ctr/u5QR0mTh4cnksUo8ogaO
         7Y9XZ+9zisNxX8yCp8Gm3BqcKi5tUc5Wqjudxf7fozWV3NqVhLNTWyRIDb9DQ0aM18aO
         LhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776052237; x=1776657037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T5SGpOXoxl9RjzaYVEFaZVgctA66UXg9R08vi8wYY78=;
        b=Paub1nh86KqLVHTfa/QaZwWZwY1ssUpH2yq2nYuM3PjAwLwazsuQtWoZ7CBF2kyi0M
         DNnCIg3y4l9UryH6EvQapcD9Sh7epQwU8lvg3k4SCZ8idXfd0S/LFmlcGeQ28Pj3/JXp
         1i7bR9GfjgU5QoesRLGPsAEJKvAuN+hUuvSZM719BsXo2d+1ZoJgE1MqanC/OEPnT0hc
         DqM/62F2lA+NgGTJPYiVCwjdKGWWZvPeGxvE+a+Ptsbz3dWxzLnvWQbkpV3QFbu3RpQ4
         FSBh8DQ8+8Mn2YjX0aC0fBnpr3wEAoP+ZArv1TpO9hOJeX49DDh+/w5uO17Y27Q5IrEm
         +8Pw==
X-Forwarded-Encrypted: i=1; AFNElJ+eFXka0sYmvr3yFDUCWZvgz4O192zc8xM2WO8dBodzVP5d8igWsuk1h/ly7WSn/dA7K7UO7bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxipUFZ5DcuWR4xkaeBv+WqWc7kpAOWcM3HCQ7RbOU8XGHL0j+U
	bUUrKHR8ab2+o6I2olc46EavP4VWDQh7wAhh+V9ZD6xtzGDT3KzvQF0v
X-Gm-Gg: AeBDietZYv0Qw8AnFzniJ4+QEDZhHzioEWnC1JVG8wsxVIklG+yRafOtnO3M7iFNxV5
	CLufTx2Zzo0sH3I65BcIj5UH+4TomBv8HBnP2wo0x4QAn3viC8GRzOyuixfdRsoyejansMkGggw
	FZMwWLWpUGrQ6BUqusHosVpqx36nH1J9nEHtLjVOUX5Es005SK+jAoZAyILJrDcBsQqBVqF6WQ6
	PMch5tLUoKc2uAj3wWOjY9QoH5Qi04WYRJLzv9isG1AbJUbDAsIVTlKOcyfTlFlTLpY3+GNiBe0
	+dOo8bNEuW8Zfts3wd6uJd1jhI6geGVLcqplIoz3+9xaS24+srMzqZ9HwNOLuSdr18/aWSspTAF
	WSWbY/eKAfw2xWIomsQ2HpYdfiznNMBzkeaUJdPcoWJXyZ0h7CeUp/ePldYU/VI+345e5isNFqR
	vOOfKnY29gZkmIlJMT8416dUP16gLKQAZeoHlmwx0TxTOdPv2rYfYA36JvfbHQ4/PT3R+hhz3gN
	A==
X-Received: by 2002:a17:90b:5185:b0:35a:18b1:c245 with SMTP id 98e67ed59e1d1-35e4250f241mr11933562a91.3.1776052236668;
        Sun, 12 Apr 2026 20:50:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:6580:9cc0:8700:96ae:8c3d:9c98:97d9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e4e2dbf47sm7030644a91.0.2026.04.12.20.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 20:50:36 -0700 (PDT)
From: Berk Cem Goksel <berkcgoksel@gmail.com>
To: zonque@gmail.com,
	tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andreyknvl@gmail.com,
	stable@vger.kernel.org,
	Berk Cem Goksel <berkcgoksel@gmail.com>
Subject: [PATCH v2 2/2] ALSA: caiaq: take a reference on the USB device in create_card()
Date: Mon, 13 Apr 2026 06:49:41 +0300
Message-Id: <20260413034941.1131465-3-berkcgoksel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413034941.1131465-1-berkcgoksel@gmail.com>
References: <20260413034941.1131465-1-berkcgoksel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235885-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,suse.com,perex.cz];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[berkcgoksel@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76E723E7070
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
v2:
 - Correct "Fixes:" tag
 - Remove null check before the usb_put_dev() call in card_free()

 sound/usb/caiaq/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index d52f3b9a2bac..fa734fa61052 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -385,7 +385,7 @@ static void card_free(struct snd_card *card)
 	snd_usb_caiaq_input_free(cdev);
 #endif
 	snd_usb_caiaq_audio_free(cdev);
-	usb_reset_device(cdev->chip.dev);
+	usb_put_dev(cdev->chip.dev);
 }
 
 static int create_card(struct usb_device *usb_dev,
@@ -411,7 +411,7 @@ static int create_card(struct usb_device *usb_dev,
 		return err;
 
 	cdev = caiaqdev(card);
-	cdev->chip.dev = usb_dev;
+	cdev->chip.dev = usb_get_dev(usb_dev);
 	cdev->chip.card = card;
 	cdev->chip.usb_id = USB_ID(le16_to_cpu(usb_dev->descriptor.idVendor),
 				  le16_to_cpu(usb_dev->descriptor.idProduct));
-- 
2.34.1


