Return-Path: <stable+bounces-235567-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKYcGe6D2GmMeQgAu9opvQ
	(envelope-from <stable+bounces-235567-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 07:00:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5A93D2334
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 07:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D3B33020FEA
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 05:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F95331A56;
	Fri, 10 Apr 2026 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9pJ5ri2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA22EE611
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 05:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775797226; cv=none; b=bftnCRvihcsuKR+wLl5D6dQ0pXbEX1GOYDIItD5T0tWdkGxXgqTwbzSidus93jwzclgtGVt42lCq4WcqkjXyZTgnh/RvQtTT3JK6A9f5b3EWgPD0tOWm/AEHz8EBXZ/wanQk7iGUEke3zN8rOfw4E3T5SLgP8gmWP/X6gL63nwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775797226; c=relaxed/simple;
	bh=BwLOMX36Z3otAQNyGKjCXVwDWH8R7e6eiQH3yP3tVug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OUTzA36NbSTbTrYBBsWxQRtzB7S16bU/v3LOIdNAlrOtu/Ol95x/ECUm3ikkBMTNkQ+VendnO1TMVUbQxvv16HWpD0XqPISJC3/oWs8bbH5sLJQ0tIslfdK9+668pCSveJI0+qYeOXn3PZ3YvW48i9iC9kYu5ga3NJiSeLYqaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9pJ5ri2; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d9923eec5so1020331a91.2
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 22:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775797224; x=1776402024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJaSDl2asy+QBwHUG5HTFQEuT3Wu+LftRP1raa/0B04=;
        b=N9pJ5ri2YadLpc115nVcok5/wMU9CCT3bsGHiCIE8f2kkH4ryCoruu8WLOo2L4XA3e
         m9w+3FcVJQkUaQZuiYkr+unb2wkK7qKEMlXGCZICbrLzV1Ml7Zmqc+VVM9PieRLkRkif
         oLVj5ue94mI33YWcAm1hnp2KljRXWBjDpiDNnhVExrDy9VYDdDHQCz9J9DvdRY4SrZCi
         U3RuBym6LTzKdX1Pr7SRiS2I37knd18VBC0QwzC8fW2i6FgEfUnOdCPh6gjATVPeI1+P
         RgW16XN3OOjlA+H+tIeaSYiceaWNxaVFoK++X/DQJ7C6TexoJXR8uZ1yCSOkCtgiYHPC
         H85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775797224; x=1776402024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UJaSDl2asy+QBwHUG5HTFQEuT3Wu+LftRP1raa/0B04=;
        b=S7AJtZbQxZsfpeX8r/vaje477TGAGiF3EDV4+HeN68RvM+IgEuufJCIL6UAi8ZCuyO
         mFXPdlYTk4NBgHFFvNm0KIMIGgTLosOZ+3sRNmOIfB1hcmHpQ4D2O1ZEVjIibug4GWVa
         yaWzhF52NvXo92w+YW409njl/nIhstIQWFaX0PoYVQshfsYS/RXdPISjsBthBgqkwfjy
         lmoEVti1u+LG5/uwiMptEKcwebJk2Zeqk7pzJaD3u01gb7JHB3YJIbfly8H0b5z6eX4U
         0Mn4b583gyvsDx6UD+kBtWt1k6NiES0h0dglfyFqW6NH3t7PK0Jq7rVJ78zPbQQdbfME
         YLLw==
X-Forwarded-Encrypted: i=1; AJvYcCUOv/eLzvaD0+Ba6SOV4nD1HSw1sWoec+0dfRIsQQpvVfKqFPtW8cVRB30tqH6slSLsMPxXFRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7YuZ7OD2bvmr1a8Xyf4wjIfqNscvQjhc/3jfCbtRxXqQKdN6X
	jwN1HCW+4M+e4aZgjcqKCO06mPo1uXf9mNLqjKEdjxJOtRJVKdbQ7Bgn
X-Gm-Gg: AeBDieumtgNYqeDSwBihV0i1u2QcjFmlHn58g94qxjSXO5jH0JD4M4FGkh61IkTNdvB
	LiOTv9JigJkSXaimle1SeEbnjDrU9EHgWAf/EwImD9kTJyWfubAbqYrsxrNxEZWwGlPAGkxtuTf
	Lra1dIJwZyuCddIG+tbNlC5B6Nyn+PQCLwc1E4ggLgpia30P7FvDQFFqVQDLeJmMkHYwl7hjQNl
	Nfn6+pwvqJYEkRnFqis114Xi+wAhjgR9DBRsURcEuwXhZQ5pQ+wFjf8it3oCfWgEDbczMYFMFDZ
	sw23ENua2sm84CVEW3MGhuxFEr9JboiYMTfHh/PhVpBDL5Ch3760Zi0B+zXYxDyfTEY8WrrVwH/
	3ahPrV8UxGL6uVQuV/ONSHBGSNA5z3gwXegtgCUtAafHknL8EDAXTiJotVe+Rcxv2JSJiOZTSj9
	7HN8NhgzTFPUcRqQb3vyiOLPNLWD9N3wbTk8kX/pwv9BKENLbpoIG+f17F8ADKDgOniB+aFBthG
	nwkvkyCICtH0A7b5Pq23BwqVqW5P+bujg==
X-Received: by 2002:a17:90b:28c8:b0:35d:9dc8:7191 with SMTP id 98e67ed59e1d1-35e4280cc32mr1907336a91.14.1775797223872;
        Thu, 09 Apr 2026 22:00:23 -0700 (PDT)
Received: from localhost.localdomain (59-190-207-251f1.hyg2.eonet.ne.jp. [59.190.207.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f2af90sm13532835ad.64.2026.04.09.22.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 22:00:23 -0700 (PDT)
From: Berk Cem Goksel <berkcgoksel@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Berk Cem Goksel <berkcgoksel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ALSA: caiaq: take a reference on the USB device in create_card()
Date: Fri, 10 Apr 2026 07:59:04 +0300
Message-Id: <20260410045904.1064020-3-berkcgoksel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410045904.1064020-1-berkcgoksel@gmail.com>
References: <20260410045904.1064020-1-berkcgoksel@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-235567-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[berkcgoksel@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE5A93D2334
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

Fixes: 523f1dce7096 ("ALSA: snd-usb-caiaq: add support for NI Audio Kontrol 1")
Cc: stable@vger.kernel.org
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Berk Cem Goksel <berkcgoksel@gmail.com>
---
 sound/usb/caiaq/device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -385,7 +385,8 @@
 	snd_usb_caiaq_input_free(cdev);
 #endif
 	snd_usb_caiaq_audio_free(cdev);
-	usb_reset_device(cdev->chip.dev);
+	if (cdev->chip.dev)
+		usb_put_dev(cdev->chip.dev);
 }

 static int create_card(struct usb_device *usb_dev,
@@ -411,7 +412,7 @@
 		return err;

 	cdev = caiaqdev(card);
-	cdev->chip.dev = usb_dev;
+	cdev->chip.dev = usb_get_dev(usb_dev);
 	cdev->chip.card = card;
 	cdev->chip.usb_id = USB_ID(le16_to_cpu(usb_dev->descriptor.idVendor),
 				  le16_to_cpu(usb_dev->descriptor.idProduct));

