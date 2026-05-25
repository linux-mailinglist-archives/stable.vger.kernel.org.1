Return-Path: <stable+bounces-254203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPTfACKwFGrRPQcAu9opvQ
	(envelope-from <stable+bounces-254203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:25:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 715ED5CE53C
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C292301AD0F
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 20:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9C138F232;
	Mon, 25 May 2026 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8h1ruv2"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B69A3939B9
	for <stable@vger.kernel.org>; Mon, 25 May 2026 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740663; cv=none; b=ZNy6KGHwgR8dMhnXdHMbBPv6Ye7kuZx9lCz+9MQqxxMjJhyW30TNs222ljfb4ZmPtwTWslFArAJw+6zL9bLru1R9lhFxbI/YA6L5MBBvT2mQvRAWJ0ndJBOtDAMq0akbZJzk9GcruJIpaUO6I4do9J4V+Mvvim+0lEEx9XsecYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740663; c=relaxed/simple;
	bh=0fGTtdOlj0OaFFj/juQWY2eIIWPMURqhon21vBu56EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fjor0j7lOn4sW6+1UPqtcBlP5uIjBIKTFvhCs7Kj/m0C3vIvUPiwFr1gwjXkaQHT9QZhKge7EEQJMBCBLnivMbMLyJG3wDCtMQBVIdRCMlVcUG41vqTtO7G6BC+0HrkEPzS8Io8qYJF1/9wo2+t+AzXeaIFsXKMBBi/hHafOyuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8h1ruv2; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4855e69a4c0so2594523b6e.1
        for <stable@vger.kernel.org>; Mon, 25 May 2026 13:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779740661; x=1780345461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rH2bOPxUTZ7jcp1ZJ8Ke8Qi27deWhvd2Eb9MPg+cVXs=;
        b=q8h1ruv2kCZ+F72CzBFlom71z6M0RFl0p3YWKBF1DVOTkROSe2luFX1s8NCuq8HUTy
         33KA6AXLk2dijHS4MefVPz4VkwmhIlgL/nh4ZpKrS+zVDpmfWlLHb3cfB0xGtH7EEu6L
         nNzNivkxKipQ6ERuq+aKm86DbkI+qOci9LIWxoYXIlNOz4q1DspL1BkAMNGep4/54rat
         X6yzNmE1yLeZ6YVcaRibilNSPOkGM6Yhy7kMBj0v0ig8XLRqSHEk+ryRe/lZMypVzVvX
         px2VBWrUGd1VoGi/chUtQAgJVZae5I8V2p3D/D+GW9K2f9UYryRoOZTfzSqhGkq7GSuc
         2vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779740661; x=1780345461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rH2bOPxUTZ7jcp1ZJ8Ke8Qi27deWhvd2Eb9MPg+cVXs=;
        b=qta+3M/mAktK/f+DMR+PWGZKVw9ZDZVYJ11s9HWPOisOMK0dqYCBtN3QmYfzo0rcNI
         OsJUzvHgBzdp4BtLLD+XUH1WI6spctBRabDK2VvMgr3Ibt3Z115fIZrNLV+inPQXjU8q
         fJETmtsWQ7Q33AfALtTbEPaUMzjYuWLybbHHjrxQ8H5lZGUvkPFExUmXxUGfHA/kxAR+
         t5IChB4a+3gn4iRCWJWFXLQw33NdjMANYev8KRLCrw4tdassuW8W7ObGtSdIpnvdR7Q6
         7F5GiPAkxOaV86UE8OcZ+rRZISoWmAsntWvGe7qvzjHmSe01BvGC2+tdgES89q8/w8Hx
         kstg==
X-Forwarded-Encrypted: i=1; AFNElJ9KssHBuO1nGo7YtlfkvUcwOFRcme6d8Czlx2qRTtS4ecEXuQ4spgApl0xNUW0fpsRzr9GsXQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmvq17nPUYyOCC3QsGvsM7yMvuMFHPtwF20GQ6+7y284v7pF0m
	OsBZXb24XnM8XrT1LELq9C2juA7eMZh1tqyk4DtzGyF9jfNVzR7Aqjwl2lo7NzcGJh4=
X-Gm-Gg: Acq92OGJaPbDdMApDQSlbJjRFiB/euPPx2Hrw4+R8zVnfqe44yNf9wukm/X47ZmNsPK
	DPKCrKjh9aYYY+s7SZHCYm3jlFxqlaO2e4xX3Rp0OOy8t6dD3CuOCWBr1NawADliJQlWWQGoFXI
	hRkVabYJ/Chyk5bTxnOhi1jYH5V6UqQ10CRaAXJCH7LvZIjKXq6ru75YaJIwTcGIGzH0Q7F/o1R
	OKSDcbWIsgcGfbLenBXSVYjyytwrsu7A3xuCTSGiT83CvhbkM3KEyXbPi+wJgY5bIS8dw35YltI
	1bV+2ejN08aHfMuzZZceJqN677XTIL+psC9Fh4eqNkts+Ny7ZETeVEIiK+ebTr6+97m4JiuxY3F
	xG/qE6pG/yoneyZ8xXhjj8w6ouZW21U6+FRg77OYMBVINiJ5cKUFvE/Eq53seMHoVFDHs4fslRb
	o7+IPn5rXFrMZh4mBMh6iicrykwH5gNv+PLkNhsgd7pEAl8MWfm+cY3Lrr46VL2xKb5SxPODI5I
	LRQYJcAHplmUP4kvS9vSOFpe3elesQTrT49VIDeQPY+vt8=
X-Received: by 2002:a05:6808:23c4:b0:479:eb19:6e6b with SMTP id 5614622812f47-48549ead75cmr11293528b6e.15.1779740661270;
        Mon, 25 May 2026 13:24:21 -0700 (PDT)
Received: from DESKTOP-J47FREO.mynetworksettings.com (171.sub-75-196-24.myvzw.com. [75.196.24.171])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48554757d5dsm5204305b6e.15.2026.05.25.13.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 13:24:21 -0700 (PDT)
From: Adrian Korwel <adriank20047@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	heikki.krogerus@linux.intel.com,
	Adrian Korwel <adriank20047@gmail.com>
Subject: [PATCH 3/4] usb: gadget: f_uac1_legacy: fix use-after-free caused by bound guard
Date: Mon, 25 May 2026 15:24:12 -0500
Message-ID: <20260525202414.602-6-adriank20047@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525202414.602-1-adriank20047@gmail.com>
References: <2026052517-undergrad-reformat-44bc@gregkh>
 <20260525202414.602-1-adriank20047@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,linux.intel.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-254203-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 715ED5CE53C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

f_audio_bind() guards gaudio_setup() with an 'audio_opts->bound' flag
to prevent re-initialization on repeated bind attempts. However the
fail: error path unconditionally calls gaudio_cleanup(). On repeated
bind attempts after failure, this closes file handles that were opened
in a previous bind invocation and already freed by RCU, causing a
use-after-free detected by KASAN:

  BUG: KASAN: slab-use-after-free in filp_flush+0x23/0x1b0
  Read of size 8 at addr ffff88810d5523a8 by task bash/306
  ...
  gaudio_cleanup+0x59/0x100
  f_audio_bind+0x4b0/0x590

Fix by removing the bound guard and calling gaudio_setup()
unconditionally in f_audio_bind(), making setup and cleanup a matched
pair within each bind invocation. Remove the now-unused 'bound' field
from struct f_uac1_legacy_opts.

Fixes: d355339eecd9 ("usb: gadget: function: make current f_uac1 implementation legacy")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/gadget/function/f_uac1_legacy.c | 11 ++++-------
 drivers/usb/gadget/function/u_uac1_legacy.h |  1 -
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 5d201a2e30e7..6ad4b16769b7 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -735,13 +735,10 @@ f_audio_bind(struct usb_configuration *c, struct usb_function *f)
 
 	audio_opts = container_of(f->fi, struct f_uac1_legacy_opts, func_inst);
 	audio->card.gadget = c->cdev->gadget;
-	/* set up ASLA audio devices */
-	if (!audio_opts->bound) {
-		status = gaudio_setup(&audio->card);
-		if (status < 0)
-			return status;
-		audio_opts->bound = true;
-	}
+	/* set up ALSA audio devices */
+	status = gaudio_setup(&audio->card);
+	if (status < 0)
+		return status;
 	us = usb_gstrings_attach(cdev, uac1_strings, ARRAY_SIZE(strings_uac1));
 	if (IS_ERR(us))
 		return PTR_ERR(us);
diff --git a/drivers/usb/gadget/function/u_uac1_legacy.h b/drivers/usb/gadget/function/u_uac1_legacy.h
index b5df9bcbbeba..fd22fd37fe53 100644
--- a/drivers/usb/gadget/function/u_uac1_legacy.h
+++ b/drivers/usb/gadget/function/u_uac1_legacy.h
@@ -61,7 +61,6 @@ struct f_uac1_legacy_opts {
 	char				*fn_play;
 	char				*fn_cap;
 	char				*fn_cntl;
-	unsigned			bound:1;
 	unsigned			fn_play_alloc:1;
 	unsigned			fn_cap_alloc:1;
 	unsigned			fn_cntl_alloc:1;
-- 
2.43.0


