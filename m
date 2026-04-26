Return-Path: <stable+bounces-241151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lg8jHyda7WkniQAAu9opvQ
	(envelope-from <stable+bounces-241151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 02:19:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C627B46871F
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 02:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E81A2301A381
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 00:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7141EB9E3;
	Sun, 26 Apr 2026 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5P7sgqR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C61187346
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 00:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777162783; cv=none; b=P9KmmlnlJ8PSlKowxhDbGupcqxeFNp13ljeU0AIAB4Zl+bVKq4SXhjc16ZqtdCMhSyGdAeIMejvOwOmjPzz0t0es0qbJQncwRzX3Ui4sTrLUZRwjKKilq86fq9ojIKWi9GPmIXhcsj7+6quqXbZNuIwaqhpc7kzpHvX5oX6cBwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777162783; c=relaxed/simple;
	bh=TBZBNRjL9300EGgXJeR2jH8eTHBcpmzXD9vi8+6FltE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pCamwLI9REeMPxlZhBcXeBTDxiysZByp4a51UTXtR15ndeV2QvDCFxooyf7M6ZZXQsLaKu59NP+PNHcKclrSKnD3u8fuOahXz8mRqphKlIQtqtM6S4KBaJ7m/UuYhu47FNxmFBnrc/XMTNNtCHb/ilXKLo6n2znsJi8FNyZt33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5P7sgqR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b788a98557so40209285ad.2
        for <stable@vger.kernel.org>; Sat, 25 Apr 2026 17:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777162782; x=1777767582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YJeUWXBvIXV4hGGcorLW+ig5QZrccjQ1ULdApherGFU=;
        b=P5P7sgqReIRck1shXjABa0fnDHslNR6Y/tEeHH/PJsGCVAI619MlEHQ8qq/mhFEt0w
         CVcI/zg2npHFINd1aLphMN+L4H0VAD0rBv5Bg11vhbQ1NhbQoNc14rV1BcojmsAnHdN/
         DqSdXQQatJkLcxUfRqerSivUdKYCLXP2lwHbYutacwlyRtoKLnGnJQ2bTUCO2QaZ2Tdh
         HP5zSIK9QHxCgLMRrT4GDdK+rYWNaxMmAt347Qhzbv73pzXsOsXXo2PoBcLHhy25JQYU
         uydHtXCFPDJ5TCJ2Llgyc4ut7nI6KOanPazgxyIpkzElHi8vCOFIRqx/iPX2AFPVsz/K
         B+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777162782; x=1777767582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJeUWXBvIXV4hGGcorLW+ig5QZrccjQ1ULdApherGFU=;
        b=X/Iiyfs2/e/XELdE7ZPFokNrx4DUw0ZlzfAwGmewxckXuiTaDSVDe0Cju+Expf4xfV
         l0Hjx71IOvJCpsU2vIIY+sgKd0Cy8iOg25/65Nm/w85d0DfXKv2bw8rvGKzzysNLD9Qd
         DMuuia7ShHGhMHpwl7QOSohmcnSF51UQfbLwT1zKr76yvfPhm/kBlQGM1SqSsHC7oD9c
         BjbPmiLLcLsTAk+3vi+9yM2x2HKaJJEpS7urzCBvC5fEOo7Fc0vO2/WTOWpencvJDGt4
         1Ll5ANvDQRDPPQm5KieiXD9IkRsIOhe37G//fQo0r/uxNDr4Ew5wJ37KIRSG4OSwfPK7
         vodA==
X-Forwarded-Encrypted: i=1; AFNElJ/292kr/ulnPlQi/LZyYR+yq/q/NUXlWazoidX4z8f0HYAuFtss+8lFImwIxvJcA+taGG7QlVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUz+JR5z+giOSH2Au4DNn8S/vdGTQ01ywA+B7C4Ahgk6O5/TiT
	DNDxP5JXVyboTmQyliRiTiop7VL2m+ufH0zJkewmoILTZH7oTeTG2EU3
X-Gm-Gg: AeBDiesX+y8Up+hf2yJ+BQc90Xc+A0nr7kUfnneww7yoPqqmemnyo/dxya7mM6KscMy
	Dz1OtwdUPs6+Yn67lW0LIhD1AwTLNcF/e68ww2PmBVQRg5qdhCLoxppuSHvrlSIq7wrqVwXTXFW
	wFacqSvfD2OlB1QR8/56fW0rsHUIhxHF2fPyYugCBjnRP1T5aRAtROw8rZeR0OQHu9lyL5+gOKP
	xoeFJ/fcVxedGD+9D5c+sTCg6XRuVfJiaSTs+Zsd8hAlRzGBzAJx9GY+6DGhMbK0CT6VuOWRjDC
	b3mI6+n/hG0p+ivEVddpyaiFuMHy+sYSc/KDuIpVgPPxpMDM1XhAqJcUO8jJ6rQGAicIJUOza0I
	snWSXr4ZMCTxMS4UuLHKXQ2pCXRfWZxbnWLLyvhPP/+bttwBCjEuBBodwyrIm9yVeQMtiseHopL
	lHX/AKch8o92wzjd7/mjWMhNZySN7q+zxbBlSbvzWnQdXnBoy2g+g5hGwdB4Mj62855X5qnjrTn
	45JwG1YN925ZNcfBQ==
X-Received: by 2002:a17:90b:1e0b:b0:35d:a542:2dcb with SMTP id 98e67ed59e1d1-3614048a731mr37189556a91.16.1777162781878;
        Sat, 25 Apr 2026 17:19:41 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:421f:2607:ad77:4337])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fae178fsm10212835a91.7.2026.04.25.17.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 17:19:41 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: zonque@gmail.com,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+2afd7e71155c7e241560@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: caiaq: fix usb_dev refcount leak on probe failure
Date: Sun, 26 Apr 2026 05:49:34 +0530
Message-ID: <20260426001934.70813-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C627B46871F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,perex.cz,suse.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241151-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,2afd7e71155c7e241560];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

create_card() takes a reference on the USB device with usb_get_dev()
and stores the matching usb_put_dev() in card_free(), which is
installed as the snd_card's ->private_free destructor.

However, ->private_free is only assigned near the end of init_card(),
after several failure points (usb_set_interface(), EP type checks,
usb_submit_urb(), the EP1_CMD_GET_DEVICE_INFO exchange, and its
timeout). When any of those fail, init_card() returns an error to
snd_probe(), which calls snd_card_free(card). Because ->private_free
is still NULL, card_free() never runs, the usb_get_dev() reference
is not dropped, and the struct usb_device leaks along with its
descriptor allocations and device_private.

syzbot reproduces this with a malformed UAC3 device whose only valid
altsetting is 0; init_card()'s usb_set_interface(usb_dev, 0, 1) call
fails with -EIO and triggers the leak.

Move the ->private_free assignment into create_card(), immediately
after usb_get_dev(), so that every error path reaching snd_card_free()
balances the reference. card_free()'s callees (snd_usb_caiaq_input_free,
free_urbs, kfree) already tolerate the partially-initialized state
because the chip private area is zero-initialized by snd_card_new().

Reported-by: syzbot+2afd7e71155c7e241560@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2afd7e71155c7e241560
Tested-by: syzbot+2afd7e71155c7e241560@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 sound/usb/caiaq/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 8af0c04041ee..ad9f744b496b 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -423,6 +423,7 @@ static int create_card(struct usb_device *usb_dev,
 
 	cdev = caiaqdev(card);
 	cdev->chip.dev = usb_get_dev(usb_dev);
+	card->private_free = card_free;
 	cdev->chip.card = card;
 	cdev->chip.usb_id = USB_ID(le16_to_cpu(usb_dev->descriptor.idVendor),
 				  le16_to_cpu(usb_dev->descriptor.idProduct));
@@ -511,7 +512,6 @@ static int init_card(struct snd_usb_caiaqdev *cdev)
 	scnprintf(card->longname, sizeof(card->longname), "%s %s (%s)",
 		       cdev->vendor_name, cdev->product_name, usbpath);
 
-	card->private_free = card_free;
 	err = setup_card(cdev);
 	if (err < 0)
 		return err;
-- 
2.43.0


