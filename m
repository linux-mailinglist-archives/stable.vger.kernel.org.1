Return-Path: <stable+bounces-235568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BCjBhSH2GmoeggAu9opvQ
	(envelope-from <stable+bounces-235568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 07:13:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE7B3D23D3
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 07:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CAA5300DD5F
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 05:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED123290C2;
	Fri, 10 Apr 2026 05:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOsDZn0V"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2662E8DEF
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 05:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775798031; cv=none; b=Ms8maOoIQeeCaF9kntrajQtttSdkVhhbC1au/01vj+uPUSjoC8WCCB7S2nmILs12ae6Fk+RV8K+Y5ke3yP0w85uhBRdlsYmzMZgeaWF1Tfg+6jdH4lWpRLaBWitE9qZW3+7bZV+QgCFQY7cKfe7nAWrUAU0h8LwQ0ek8RSuc48k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775798031; c=relaxed/simple;
	bh=s5fpXjIkhtlnDKMlfUjkhC0TSxbru1oy54/jPyduY7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NpPftUKoEEZRKoo8jZVUOUc+L3nl82O9h7nfy5bkg/JkYb4N9YywKURefAT4nwH7TaAcp7M5ZwCCnOmuop9Hz9rzJnqwUGjYj0OW2Es/XkrZnlPBu4aByNmV1/aKwPFAbR/4hN8CeL0l40+NMMwsH5NvbFi7+DPflay4paWz4KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOsDZn0V; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82735a41920so611490b3a.2
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 22:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775798029; x=1776402829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip96ksr0TNIaLn5SBuG1rHY2Vx5CuZDHx4f8G1URE3U=;
        b=kOsDZn0V8BiixpdX/R5//HWQmoLmutwBGzL2zrtirzc6Lj0n8BrNIXjLGnXK6NkC84
         /qsbN2wVtnrscTdqoTmFq2Kz7bCEvi0rGtQPfR0Gs9Pbe12CKgo7ovsGgO7EhmRwJVLm
         99GcaADJce2S+TyL5lFyw4X2q128r5CXb5VbHaJsslHFzDUDS/deSvjRt/IHSCAoP+ST
         xo5B+8q/HahZzqEXvUTDqpJ/SKu31znGvNq7GASmS8DVuqKREC3nlLclDtejoEckuG2F
         5rQmdZLG3pHqeDhE/Vh1P/gqB9XaR59eGzk190o0f04kaTY50azoRMA9AHg2aMeH2WGY
         rlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775798029; x=1776402829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip96ksr0TNIaLn5SBuG1rHY2Vx5CuZDHx4f8G1URE3U=;
        b=rnVY/emGw2XRUdhZSTRDvPZ3Uf7mqtDMCyib1tlM1W1WPVhwlp4WYel7J6M6a0ixW0
         csu2mkmCBJtK/XlFvjV+hhTJ8jU0mbBz8RhkSNYaroAcmLxcCBhhoDh8G1zb4lDGAd5O
         lVHYYhlS0267qjNPiN5jgJCm6LgL3X0AUa4enpa3u+9uvy41fpyCR1DGhdsKYzUCtAMr
         kU5Y4r2wry4lybyesLOIB5OrzdtJShO+taQoEogvrs/vRT9IuKbuF/oZHH26p8yldCF/
         5KioDShsjB/nFRt5hZImzun5UJyBgtK0nkObGKHVbTNCB5eirs+OM45qfNKCl7DCgz/4
         JOsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU88zD1aaC8e31QSKkzMp5Kgn971bljcuYOv3xf60njOmvYRz31j9KNd4bgMnlX1OXVFyfNLd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKEgwG4qz+y+72Z5oXht+59ZjnR+1uX3bexHNuEqUK1+By+Wf
	Zc0Uju1FixR1+dZqNtKEcdk6Ogz7Pt89GY9I7RyHEUbY2XFUtRuqKFDf
X-Gm-Gg: AeBDiev7G7zBscz5oED2+XQkrSgbmlo9sTmFXelTYiggemFjnt9kwB45cvARVqNqNVe
	DKiq/md1a/lF46UEXC9ZCWR7RQ2hiyxZ90Ym0sf4Nkb+e2wVYay0RqSLgkR8GSD9mHoLdm13jHQ
	7w5lejuwyC9hb2neZG2uwietaTArrWhTb49Hz0CAibOVRxZh61Rz09/mbIOaSzyodnJQ/peggQk
	Kqg1anS/ItsUz0BUp6/uRKgcEkgQBD7fTCSUlBoDYaYtkPnoWy234j94CyUsF/XuigtoCXiLrv8
	bYxpoLvJkqJfoOSDXRUdPI8k11VgmiaKTzwqWlLl2E4OgmzQsJyUuHjZtuOgZPZlYibcdtz3tvK
	iMQP+bLjqv8YJM6IJfJooUFEDD999FRxusGVI0DeNVPmdGY29MIc1+484bTCOdOOTdmD/hJU+WX
	MycyGd/vW2lNxFWDqhQRX9Y1+f9gykCMh/DnFoz40m3cFSUCt276G5NwvVB9RYclO841n2sGQQV
	A4gHo5uaOxIUJIl0vXWqDTiyq/lxSMFaQ==
X-Received: by 2002:a05:6a00:124a:b0:81f:be3c:9c9e with SMTP id d2e1a72fcca58-82f0c297e11mr1989065b3a.33.1775798028953;
        Thu, 09 Apr 2026 22:13:48 -0700 (PDT)
Received: from localhost.localdomain (59-190-207-251f1.hyg2.eonet.ne.jp. [59.190.207.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c33de57sm1295283b3a.21.2026.04.09.22.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 22:13:48 -0700 (PDT)
From: Berk Cem Goksel <berkcgoksel@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	stable@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: 6fire: fix use-after-free on disconnect
Date: Fri, 10 Apr 2026 08:13:41 +0300
Message-Id: <20260410051341.1069716-1-berkcgoksel@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235568-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[berkcgoksel@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FE7B3D23D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In usb6fire_chip_abort(), the chip struct is allocated as the card's
private data (via snd_card_new with sizeof(struct sfire_chip)).  When
snd_card_free_when_closed() is called and no file handles are open, the
card and embedded chip are freed synchronously.  The subsequent
chip->card = NULL write then hits freed slab memory.

Call trace:
  usb6fire_chip_abort sound/usb/6fire/chip.c:59 [inline]
  usb6fire_chip_disconnect+0x348/0x358 sound/usb/6fire/chip.c:182
  usb_unbind_interface+0x1a8/0x88c drivers/usb/core/driver.c:458
  ...
  hub_event+0x1a04/0x4518 drivers/usb/core/hub.c:5953

Fix by moving the card lifecycle out of usb6fire_chip_abort() and into
usb6fire_chip_disconnect().  The card pointer is saved in a local
before any teardown, snd_card_disconnect() is called first to prevent
new opens, URBs are aborted while chip is still valid, and
snd_card_free_when_closed() is called last so chip is never accessed
after the card may be freed.

Fixes: a0810c3d6dd2 ("ALSA: 6fire: Release resources at card release")
Cc: stable@vger.kernel.org
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Berk Cem Goksel <berkcgoksel@gmail.com>
---
Patch applies to 7.0-rc6 (upstream master 5619b098e2fb).
Tested on 7.0.0-rc5 (arm64) with KASAN:

[   11.274798] BUG: KASAN: slab-use-after-free in usb6fire_chip_abort sound/usb/6fire/chip.c:59 [inline]
[   11.274798] BUG: KASAN: slab-use-after-free in usb6fire_chip_disconnect+0x348/0x358 sound/usb/6fire/chip.c:182
[   11.275503] Write of size 8 at addr ffff000013230a98 by task kworker/0:1/12
[   11.276469] CPU: 0 UID: 0 PID: 12 Comm: kworker/0:1 Not tainted 7.0.0-rc5-g663cf2b1ad64-dirty #10 PREEMPT
[   11.276485] Hardware name: linux,dummy-virt (DT)
[   11.276504] Workqueue: usb_hub_wq hub_event
[   11.276562] Call trace:
[   11.276582]  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
[   11.276616]  dump_stack_lvl+0x138/0x1c8 lib/dump_stack.c:120
[   11.276666]  print_report+0x118/0x5d4 mm/kasan/report.c:482
[   11.276669]  kasan_report+0xc0/0x100 mm/kasan/report.c:595
[   11.276678]  __asan_report_store8_noabort+0x20/0x2c mm/kasan/report_generic.c:386
[   11.276684]  usb6fire_chip_abort sound/usb/6fire/chip.c:59 [inline]
[   11.276688]  usb6fire_chip_disconnect+0x348/0x358 sound/usb/6fire/chip.c:182
[   11.276692]  usb_unbind_interface+0x1a8/0x88c drivers/usb/core/driver.c:458
[   11.276697]  device_release_driver_internal+0x450/0x63c drivers/base/dd.c:1367
[   11.276699]  bus_remove_device+0x2a0/0x4f4 drivers/base/bus.c:657
[   11.276701]  device_del+0x31c/0x870 drivers/base/core.c:3880
[   11.276720]  usb_disable_device+0x2e8/0x6ec drivers/usb/core/message.c:1476
[   11.276737]  usb_disconnect+0x294/0x8d8 drivers/usb/core/hub.c:2345
[   11.276776]  hub_event+0x1a04/0x4518 drivers/usb/core/hub.c:5953
[   11.276836]  process_one_work+0x8a4/0x1dc0 kernel/workqueue.c:3276
[   11.276850]  worker_thread+0x57c/0xcac kernel/workqueue.c:3440
[   11.276888]  kthread+0x3e4/0x494 kernel/kthread.c:436
[   11.276890]  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

[   11.339324] Allocated by task 12:
[   11.339765]  kasan_save_stack+0x3c/0x64 mm/kasan/common.c:57
[   11.340193]  kasan_save_track+0x20/0x3c mm/kasan/common.c:78
[   11.340615]  __kasan_kmalloc+0xb8/0xbc mm/kasan/common.c:415
[   11.341108]  snd_card_new+0x70/0x11c sound/core/init.c:184
[   11.341555]  usb6fire_chip_probe+0x298/0x864 sound/usb/6fire/chip.c:120

[   11.353835] Freed by task 12:
[   11.354171]  kasan_save_stack+0x3c/0x64 mm/kasan/common.c:57
[   11.354599]  kasan_save_track+0x20/0x3c mm/kasan/common.c:78
[   11.355023]  kasan_save_free_info+0x4c/0x78 mm/kasan/generic.c:584
[   11.355505]  __kasan_slab_free+0x5c/0x88 mm/kasan/common.c:285
[   11.355945]  kfree+0x164/0x61c mm/slub.c:6483
[   11.356285]  snd_card_do_free sound/core/init.c:597 [inline]
[   11.356778]  release_card_device+0x16c/0x1fc sound/core/init.c:153
[   11.357221]  snd_card_free_when_closed+0x30/0x44 sound/core/init.c:612
[   11.357696]  usb6fire_chip_abort sound/usb/6fire/chip.c:58 [inline]
[   11.358103]  usb6fire_chip_disconnect+0x298/0x358 sound/usb/6fire/chip.c:182

 sound/usb/6fire/chip.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
index 5ff78814e687..874f6cd503ca 100644
--- a/sound/usb/6fire/chip.c
+++ b/sound/usb/6fire/chip.c
@@ -53,11 +53,6 @@ static void usb6fire_chip_abort(struct sfire_chip *chip)
 			usb6fire_comm_abort(chip);
 		if (chip->control)
 			usb6fire_control_abort(chip);
-		if (chip->card) {
-			snd_card_disconnect(chip->card);
-			snd_card_free_when_closed(chip->card);
-			chip->card = NULL;
-		}
 	}
 }
 
@@ -168,6 +163,7 @@ static int usb6fire_chip_probe(struct usb_interface *intf,
 static void usb6fire_chip_disconnect(struct usb_interface *intf)
 {
 	struct sfire_chip *chip;
+	struct snd_card *card;
 
 	chip = usb_get_intfdata(intf);
 	if (chip) { /* if !chip, fw upload has been performed */
@@ -178,8 +174,19 @@ static void usb6fire_chip_disconnect(struct usb_interface *intf)
 				chips[chip->regidx] = NULL;
 			}
 
+			/*
+			 * Save card pointer before teardown.
+			 * snd_card_free_when_closed() may free card (and
+			 * the embedded chip) immediately, so it must be
+			 * called last and chip must not be accessed after.
+			 */
+			card = chip->card;
 			chip->shutdown = true;
+			if (card)
+				snd_card_disconnect(card);
 			usb6fire_chip_abort(chip);
+			if (card)
+				snd_card_free_when_closed(card);
 		}
 	}
 }
-- 
2.34.1


