Return-Path: <stable+bounces-238686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B4CALe15WkGnQEAu9opvQ
	(envelope-from <stable+bounces-238686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:12:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C4E426CCC
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAC0B30158B4
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 05:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4998233C532;
	Mon, 20 Apr 2026 05:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="z7X/rX8e"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B063D17DFE7
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 05:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776661938; cv=none; b=OLfiZScJObWzSoG9wWo5265ZdcuSGHCwGsA3aFj3Nto2PNgj4a2GkSwv+Y00Ovjp/aM7zpN6RrBgufYwqHvh91N3wNM3S6oc02CfLEtkGerwlDsu/36AIJzLDixN7LHWWHlM5w3dwnE/JNdBpSKxW4HRJL+EM7qdwSbEKTqpLFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776661938; c=relaxed/simple;
	bh=Itt2y7GTnHVJrFtAaPeXswkX8rW4RyB7vpTnRm0B4uU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FCG2nzNpI/elQ3+8DD+LftB7J77TZz+TDGcYuvdokOSkcr6xrazKnRnVXPHbTWwbNFKjfGdz6Ri+zG4mIQgAPMxXWVyoByvrS3dC0nQv+VwSUFz7kE890M6HSckiLUBOD88cuD4LM4kpxUHemz9Q7PsbpH1VAdScKr6gSIaz3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=z7X/rX8e; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35fc258aaa4so1502063a91.2
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 22:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1776661934; x=1777266734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=panaAxBG+Oj8O67g22hba7g+kj4UgFC78OIsOhVGnTk=;
        b=z7X/rX8esHhHDicOC8pPSnPYW1wKx1HrTD/7Rc0rg7iNHqk+PoYzu/bu0L8u0ACphT
         7kHheHD9HO8TjCcXW3zIAN9YkA0EVH4qiVIGb6KB0YDDoyH7ygDWGaGd5atXKO/i+o7P
         gMzXLb80TORCLcuAvoaCvJi+ckK+JqjhJda8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776661934; x=1777266734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=panaAxBG+Oj8O67g22hba7g+kj4UgFC78OIsOhVGnTk=;
        b=aPc1LaO11cQ4GZOAp8fixpBUhsaVy+n1IigRBPVy02mFKDGc2hP7aT69dRvRcHzVUx
         K2+bHC6WBUNA1EwMun+esyyqt8cZNgD9+4ES7a9XQqNYqoTYoifkYwrJn5ajGhO3aVsM
         Bw6vXYUQZSRu22yTOGpi1PTN+V4dZWEtMxpWKB/odkwEPXCUXb5D0x9BVBajxAdcdr3K
         ysQZKch/4OKCWJ3ZTseuwyiNmT5D0aDIPtnhSIRv6B/XGV4DFycZvpXvgH8r2WOdpry+
         1zSf2TpaRTGE+N7/UM0OR1xwj4uFyG2h1KfzifAm1xjMukNCGr2MDPLUAU8YC610Ia1E
         FY0A==
X-Gm-Message-State: AOJu0YwtGLjCaIrm3oZaqr3fzdw2UzBCTjK6fdrk9xhAQILq2zGzDTP8
	0wy4O2k7RihWEVk/PXjEn6BgKcTyQV3tjbX5C8RaFUhhymYqKOmXwmZVhrO1DgFKxnQ=
X-Gm-Gg: AeBDievB5ZoBzVIiKa/0ZxrLa5Vwqj8Z7gaWvbSwpWCrpBP/6G4ypfS2qUXHtnSkyKn
	2O2bIo4Hw9PLZul2mDj5eWcZtp8EBe95v4JzyCCe2gCmU/BMGmjrz/nuEztGM0Ak6TJsbEsLYRH
	3jJ2meg2Dr3lkuO7HamZCjGEokzDtSyFm2l/spqI7D9l7+ctdF5pZX4ew29TrJ1AuIIGxmnoEkL
	LqZCLCmarNTzgjmyyEQXWmCiIei3mjRkIbQAaM5P0J433Hxc/k8k9P4TSx8bOF4Wy5pJg9mRife
	+IxslWE2F45ORVV3cGAsrhVYeUWlDPkjUIYX5Nk5UkbhxhDf99Sqyl17ZybVD6q1jmhmTZMgIeJ
	UAfUgmfkGi1ZppfxmIOSD9+obGytwDc9pi14yTwhMj/wQORdtHoAo5vXKmDt0S6NPhyk8DG30Ga
	d6a3gfDn/XuePkotpCu4AYiq1c8LfpgWxFW7/QtcBnkPTQyqVkBtHZ07vt6/mjQ7DFv1Kv2Q==
X-Received: by 2002:a17:90b:5286:b0:35f:9ab2:a5a6 with SMTP id 98e67ed59e1d1-361403d5b55mr11288413a91.2.1776661934050;
        Sun, 19 Apr 2026 22:12:14 -0700 (PDT)
Received: from nunu.. (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fa8068csm3597638a91.2.2026.04.19.22.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 22:12:13 -0700 (PDT)
From: Sangyun Kim <sangyun.kim@snu.ac.kr>
To: sangyun.kim@snu.ac.kr
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] HID: appletb-kbd: fix UAF in inactivity-timer cleanup path
Date: Mon, 20 Apr 2026 14:11:52 +0900
Message-Id: <20260420051153.1407382-2-sangyun.kim@snu.ac.kr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420051153.1407382-1-sangyun.kim@snu.ac.kr>
References: <20260420051153.1407382-1-sangyun.kim@snu.ac.kr>
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
	DMARC_POLICY_ALLOW(-0.50)[snu.ac.kr,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[snu.ac.kr:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[snu.ac.kr:+];
	TAGGED_FROM(0.00)[bounces-238686-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sangyun.kim@snu.ac.kr,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14C4E426CCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 38224c472a03 ("HID: appletb-kbd: fix slab use-after-free bug in
appletb_kbd_probe") added timer_delete_sync(&kbd->inactivity_timer) to
both the probe close_hw error path and appletb_kbd_remove(), but the
way it was wired in left the inactivity timer reachable during driver
tear-down via two distinct windows.

Window A -- put_device() before timer_delete_sync():

	put_device(&kbd->backlight_dev->dev);
	timer_delete_sync(&kbd->inactivity_timer);

The inactivity_timer softirq reads kbd->backlight_dev and calls
backlight_device_set_brightness() -> mutex_lock(&ops_lock).  If a
concurrent hid_appletb_bl unbind drops the last devm reference
between these two calls, the backlight_device is freed and the
mutex_lock() touches freed memory.

Window B -- backlight cleanup before hid_hw_stop():

	if (kbd->backlight_dev) {
		timer_delete_sync(...);
		put_device(...);
	}
	hid_hw_close(hdev);
	hid_hw_stop(hdev);

Even after Window A is closed, hid_hw_close()/hid_hw_stop() still run
afterwards, so a late ".event" callback from the HID core (USB URB
completion on real Apple hardware) can arrive after
timer_delete_sync() drained the softirq but before put_device() drops
the reference.  That callback reaches reset_inactivity_timer(), which
calls mod_timer() and re-arms the timer.  The freshly re-armed timer
can then fire on the about-to-be-freed backlight_device.

Both windows produce the same KASAN slab-use-after-free:

  BUG: KASAN: slab-use-after-free in __mutex_lock+0x1aab/0x21c0
  Read of size 8 at addr ffff88803ee9a108 by task swapper/0/0
  Call Trace:
   <IRQ>
   __mutex_lock
   backlight_device_set_brightness
   appletb_inactivity_timer
   call_timer_fn
   run_timer_softirq
   handle_softirqs
  Allocated by task N:
   devm_backlight_device_register
   appletb_bl_probe
  Freed by task M:
   (concurrent hid_appletb_bl unbind path)

Close both windows at once by reworking the tear-down in
appletb_kbd_remove() and in the probe close_hw error path so that

 1) hid_hw_close()/hid_hw_stop() run before the backlight cleanup,
    guaranteeing no further .event callback can fire and re-arm the
    timer, and
 2) inside the "if (kbd->backlight_dev)" block, timer_delete_sync()
    runs before put_device(), so the softirq is drained before the
    final reference is dropped.

Fixes: 38224c472a03 ("HID: appletb-kbd: fix slab use-after-free bug in appletb_kbd_probe")
Cc: stable@vger.kernel.org
Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
---
 drivers/hid/hid-appletb-kbd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
index 0fdc0968b9ef..8feac9e3589b 100644
--- a/drivers/hid/hid-appletb-kbd.c
+++ b/drivers/hid/hid-appletb-kbd.c
@@ -440,13 +440,13 @@ static int appletb_kbd_probe(struct hid_device *hdev, const struct hid_device_id
 unregister_handler:
 	input_unregister_handler(&kbd->inp_handler);
 close_hw:
-	if (kbd->backlight_dev) {
-		put_device(&kbd->backlight_dev->dev);
-		timer_delete_sync(&kbd->inactivity_timer);
-	}
 	hid_hw_close(hdev);
 stop_hw:
 	hid_hw_stop(hdev);
+	if (kbd->backlight_dev) {
+		timer_delete_sync(&kbd->inactivity_timer);
+		put_device(&kbd->backlight_dev->dev);
+	}
 	return ret;
 }
 
@@ -457,13 +457,13 @@ static void appletb_kbd_remove(struct hid_device *hdev)
 	appletb_kbd_set_mode(kbd, APPLETB_KBD_MODE_OFF);
 
 	input_unregister_handler(&kbd->inp_handler);
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+
 	if (kbd->backlight_dev) {
-		put_device(&kbd->backlight_dev->dev);
 		timer_delete_sync(&kbd->inactivity_timer);
+		put_device(&kbd->backlight_dev->dev);
 	}
-
-	hid_hw_close(hdev);
-	hid_hw_stop(hdev);
 }
 
 static int appletb_kbd_suspend(struct hid_device *hdev, pm_message_t msg)
-- 
2.34.1


