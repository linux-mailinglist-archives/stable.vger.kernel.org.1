Return-Path: <stable+bounces-238688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DIUDy225WkGnQEAu9opvQ
	(envelope-from <stable+bounces-238688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:14:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B37A7426D00
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD2F83032058
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 05:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE28345CDA;
	Mon, 20 Apr 2026 05:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="WEPV4znX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA937F8C1
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 05:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776662015; cv=none; b=ZHyKyGp2WxN3GSRdANcGEHiyu6a+vVi0lfygjcbgxzGHb0Ls3Sjy3xcPWltt/9QWTPFnXEHg35oQQ6pPwyoFghN5UyJcmdRdJKVTaGANRY3HHE4IAuKZ4eKPVRTIlSDP2f1e/3iaOLBv8vQ1fWYADZqLIPfx/UcJUJSiE4K4wtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776662015; c=relaxed/simple;
	bh=Itt2y7GTnHVJrFtAaPeXswkX8rW4RyB7vpTnRm0B4uU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DGqncDZa4CexBP3K6u2k1uHVbT9hedZpj8GuTrLoe6ICOhVKbxp82ZHb0UpR7zysYrPbiBil4oiX0dgUCKP0JzJamHtZnbU/6KpeYCC9nN08BnDo8DkQc9GUqBD6QIlxCd+lOcinnTwZbdKoOX1XmiXPJK88zKcP7HBVgPcFrDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=WEPV4znX; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so2522983a91.2
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 22:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1776662013; x=1777266813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=panaAxBG+Oj8O67g22hba7g+kj4UgFC78OIsOhVGnTk=;
        b=WEPV4znXk5QBV4avjqTQ+t11JCv0KYVG8TWzjgKFwzJc7HiS+VYJ3KJDeyA03iSUbz
         bkKhucH/gH7dFD4ytiP1q36T3Om1jvW6J73PWaNtFiEOfwcNd7+cnGIwlKHPCkRt3Rti
         +2fqnSjxLJqSqE2XD3DCEq7XnrCpnpb1pttTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776662013; x=1777266813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=panaAxBG+Oj8O67g22hba7g+kj4UgFC78OIsOhVGnTk=;
        b=hfuvf4ysuUUnm1XCipPJEgCQ2khBE3zUzPoBgXj8kc3D2kjCV6z8qdvqJbkPgTyWNh
         4WFVf+KeW08sHo4hhxAt6QT02BJl4CnmN0gWKFnylFV8D7aevd36OYS+MKg8Wm471vVp
         9Qr/D5gvyiWhlva5IpUI0NLF1/iDSGnRGBhZq4Bdd+JYxTbH3FkoHMVlD3k3/RU96q6v
         nHadA3VyTUIwGQA0QrJ7Y3E1iWKAuykPm+1L+GFldSCJMq3Grc8K/wAk4GnNetoZ25r/
         TnhRUcnfxXFDz+CasAWnOm8jgsIrA1Gk1pByu3XgmU4sGNOkpJVJKYS5lG4tv59tTbio
         mQIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yuY2XPsj3GqDRnDu5TlvIzw7TxVtXqvq9H0TdQ9DeehphtCjlkefvV3PLFIf2eAb0Kinpn28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmNx+xd3PBdqXe/FvFRaWICdLoY3u/nUrpEd98NxE3zgOQ+5R4
	De5VXBmt+3Uv9tVoBQTnkILDqAZ0Kj01FTw6KhClQPlv1JRu4ujiMU5eaEugtbAD+ZDn48mBXTF
	88N970k0=
X-Gm-Gg: AeBDiesl17emNAhMDoyIAMOEioiv8ckwvW4SdGrf235wtQusac6Cijfn9u48Qka9uhy
	UXNeQL/i0Mnk/0O7RKHAKeHwnsyjejLjPGslgaoyIGmRF+aZ9kLPFdMc1jfWVNoQ7mVn36dEQjm
	wHChzwmR5wQUwtdOqKRXvkJnV7klK3whH0mAMmomaDjhyOS/4KYU1TXATuUy6Q8Ogq3ttkKF+ly
	9afKhYH5u8Cx+vu42WJpJAWKIT0F1Xe6uAveKceJ51/dO5QZS66zzuckb/V3xPcurHuHc5+Smhs
	cNA0H3E4Te9pdOIPpaUWjh6FaO4s/YWz6oFj0yD5CF08m+CqwWYGxjle3nrvViZTmlObZkJoIDz
	EmIDxAsbQ3U1m23iBtEFRkIYaE5y2s7zGhPVX4x6FaFbxmKP+pIK/F7gYYXUlobnGTZlE0CX7UT
	v0SXZ9bV+T1rfTaJx5EBX9kkXgMWZkgtXnwMDDrJRBtt0THQ14FjG7t+Cl7gWV+NWn//h68A==
X-Received: by 2002:a17:90b:5106:b0:35d:93ff:2855 with SMTP id 98e67ed59e1d1-361403e159amr11563269a91.8.1776662013426;
        Sun, 19 Apr 2026 22:13:33 -0700 (PDT)
Received: from nunu.. (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614186a52csm11032591a91.4.2026.04.19.22.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 22:13:33 -0700 (PDT)
From: Sangyun Kim <sangyun.kim@snu.ac.kr>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: qasdev00@gmail.com,
	gargaditya08@live.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] HID: appletb-kbd: fix UAF in inactivity-timer cleanup path
Date: Mon, 20 Apr 2026 14:13:17 +0900
Message-Id: <20260420051318.1411671-2-sangyun.kim@snu.ac.kr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420051318.1411671-1-sangyun.kim@snu.ac.kr>
References: <20260420051318.1411671-1-sangyun.kim@snu.ac.kr>
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
	R_DKIM_ALLOW(-0.20)[snu.ac.kr:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,live.com,vger.kernel.org];
	DKIM_TRACE(0.00)[snu.ac.kr:+];
	TAGGED_FROM(0.00)[bounces-238688-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sangyun.kim@snu.ac.kr,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[snu.ac.kr:email,snu.ac.kr:dkim,snu.ac.kr:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B37A7426D00
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


