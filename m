Return-Path: <stable+bounces-238689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBnhDWe25WkGnQEAu9opvQ
	(envelope-from <stable+bounces-238689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:15:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1CE426D25
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B126304523F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 05:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDDB33C532;
	Mon, 20 Apr 2026 05:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="HuMfC8Sb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE22B2D8DB0
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 05:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776662019; cv=none; b=D3otgM11IZoQWx97TqTEPL+3o98dQyxqOqge5IFe1YtomFMCK6AG3YjWQ3q8zBFZlMVanmxxJ3NYyXIm4EsTzBLTKx48ZKpX1BI7ksVL9BbVYcEoqyeAr5Z3mY5fpCyTSlT2h6Qp8MC2AXo2gOemkYpFIGPwBqqK2PRlvdVNR8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776662019; c=relaxed/simple;
	bh=01XNhHkfueCJ1FLR+EHojwXfn62aRxo9vj4McCxGw5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R6gY0DYchSTlNBtgzOxoYz7/h/4STcdGbst7pPMK6dbbkxHiaNfOl4kiPkvLPnmvnHRtFUqQu3QqM27kBoDdM/779lbZXTaq+nM0lURPigl9zTH/ZIGSSJnJZAAEX0pC+BJWr27y28dYuPmPB0HI1PrilNzoJK4DZ1zI2diFoQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=HuMfC8Sb; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3614826eca4so1951129a91.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 22:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1776662016; x=1777266816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihcvVaBfQ28dquD5a+undc5jBXoT8T5VO4GMetOrvw0=;
        b=HuMfC8Sb6MUTOKhVtSxg1rTxT1Na0uAILTOuiS0j6Trhjwa15yfIW24PGflLcc5PPH
         mVs0dz9ib6An92AkW6I/NwzHw2HnPddAFafV6xF5r62UL9atJ6nRznT1vYBnCgSpS/CQ
         W4PAl2jldLE+jEcGTDc6KihXrOIKf3iN9ITFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776662016; x=1777266816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ihcvVaBfQ28dquD5a+undc5jBXoT8T5VO4GMetOrvw0=;
        b=M5uMFO1iQOweqMApRpp9fZmYzXJU8qakuJea+xGhqF/7ti2tM4eKfM2m9Mq7GdtST/
         fNA8zEme5ryn5HDVeWdVSCSUAQr3gzjF4kX8t8Z6BfwZoXMf7itP5EQHriVxdM63ehke
         EQg4tpegnRWvYQHR9UU4TJ4u+1GT2YEB5KuTFCDFlrZux9sBL3wEqGtHCDCbk3dJy/+C
         XiNAUBDDWcpjPNHikM3ICPXmJy0NBHg71vhpgJ/9ekWZdCLEreY1ueQ5tkyq3PX5wytL
         8P8hDAumlJnwLPRjv3cg2erhw5B3X3SIkCTX/9I80HiR/X/V0Jq/+U7ekll4Bj03Pw9L
         6WQA==
X-Forwarded-Encrypted: i=1; AFNElJ8fL/pRXTBuRQrnnZ8eedWIW3icSf+RIIG3JgjIPDSdP6RD24ThFL7uQlu8L+15a7IQ48tzUpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Ln/nQ+SIwLH3tz9+50HTmm0nAkhd9ZZgkblaJVRQCyegxaG4
	yZBtOK82Y80woj9eVfwdtPG2uzfiWIB+k+snE7+ng1SI2o3aOod7lT0rv+RsjHxvZJs=
X-Gm-Gg: AeBDietbGpksEpwi2m3l3YwK1/SgoP48EOSBUuHQsY3c0BnEOhLnhc38RpSO2UEj5Qu
	4pJdHp38Mq9qwW4GAS2KpTCNGcNtmfvhU40SZJuhzLiQx93U0d/V1/wOMNUKTDNVkDHwBbkulLD
	4r9eXUeVp4LlIFET9DXpxOs0B6+EQFk1G1oszWitIpmEbXBYwYKNNfweZqIuxz4zcxK/+44uT73
	ULT519VOsEF9ztUEUa9AjczgkSGrrsMzRLgpMJLFectFUFwPwImwZOiqRhwM8a74+d2Ow/fWGd3
	Tt/p09VxZQqFG4r+jorQKrGhbjYlBz2Fie8BWcc4/un5SCHGCuRkAbDeY6haUPmkXtNV3ZROLrP
	mBWbkeoGENsK/F+BdbRsLUWOJhWLbsnm3A1UXTiFbQxLUbHuS4ldjGXFW9PuBn8eBAsa88/N9fg
	ybdzjT3Mo6LROCoSX93cifm8SUPtmGme+AzigDO3Kq7WPPEba7iFXVdPt+H8k1f5gYS/ZCRQ==
X-Received: by 2002:a17:90b:5865:b0:35e:27ec:dea with SMTP id 98e67ed59e1d1-36140493410mr13257104a91.23.1776662016114;
        Sun, 19 Apr 2026 22:13:36 -0700 (PDT)
Received: from nunu.. (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614186a52csm11032591a91.4.2026.04.19.22.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 22:13:35 -0700 (PDT)
From: Sangyun Kim <sangyun.kim@snu.ac.kr>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: qasdev00@gmail.com,
	gargaditya08@live.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] HID: appletb-kbd: run inactivity autodim from workqueues
Date: Mon, 20 Apr 2026 14:13:18 +0900
Message-Id: <20260420051318.1411671-3-sangyun.kim@snu.ac.kr>
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
	TAGGED_FROM(0.00)[bounces-238689-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 9A1CE426D25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The autodim code in hid-appletb-kbd takes backlight_device->ops_lock
via backlight_device_set_brightness() -> mutex_lock() from two
different atomic contexts:

 * appletb_inactivity_timer() is a struct timer_list callback, so it
   runs in softirq context.  Every expiry triggers

     BUG: sleeping function called from invalid context at kernel/locking/mutex.c:591
     Call Trace:
      <IRQ>
      __might_resched
      __mutex_lock
      backlight_device_set_brightness
      appletb_inactivity_timer
      call_timer_fn
      run_timer_softirq

 * reset_inactivity_timer() is called from appletb_kbd_hid_event() and
   appletb_kbd_inp_event().  On real USB hardware these run in
   softirq/IRQ context (URB completion and input-event dispatch).
   When the Touch Bar has already been dimmed or turned off, the
   reset path calls backlight_device_set_brightness() directly to
   restore brightness, producing the same warning.

Both call sites hit the same mutex_lock()-from-atomic bug.  Fix them
together by moving the blocking work onto the system workqueue:

 * Convert the inactivity timer from struct timer_list to
   struct delayed_work; the callback (appletb_inactivity_work) now
   runs in process context where mutex_lock() is legal.
 * Add a dedicated struct work_struct restore_brightness_work and have
   reset_inactivity_timer() schedule it instead of calling
   backlight_device_set_brightness() directly.

Cancel both works synchronously during driver tear-down alongside the
existing backlight reference drop.

The semantics are unchanged (same delays, same state transitions on
dim, turn-off and user activity); only the execution context of the
sleeping call changes.  The timer field and callback are renamed to
match their new type; reset_inactivity_timer() keeps its name because
it is invoked from input event paths that read naturally as "reset
the inactivity timer".

Fixes: 93a0fc489481 ("HID: hid-appletb-kbd: add support for automatic brightness control while using the touchbar")
Cc: stable@vger.kernel.org
Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
---
 drivers/hid/hid-appletb-kbd.c | 44 ++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
index 8feac9e3589b..462010a75899 100644
--- a/drivers/hid/hid-appletb-kbd.c
+++ b/drivers/hid/hid-appletb-kbd.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/backlight.h>
-#include <linux/timer.h>
+#include <linux/workqueue.h>
 #include <linux/input/sparse-keymap.h>
 
 #include "hid-ids.h"
@@ -62,7 +62,8 @@ struct appletb_kbd {
 	struct input_handle kbd_handle;
 	struct input_handle tpd_handle;
 	struct backlight_device *backlight_dev;
-	struct timer_list inactivity_timer;
+	struct delayed_work inactivity_work;
+	struct work_struct restore_brightness_work;
 	bool has_dimmed;
 	bool has_turned_off;
 	u8 saved_mode;
@@ -164,16 +165,18 @@ static int appletb_tb_key_to_slot(unsigned int code)
 	}
 }
 
-static void appletb_inactivity_timer(struct timer_list *t)
+static void appletb_inactivity_work(struct work_struct *work)
 {
-	struct appletb_kbd *kbd = timer_container_of(kbd, t, inactivity_timer);
+	struct appletb_kbd *kbd = container_of(to_delayed_work(work),
+					       struct appletb_kbd,
+					       inactivity_work);
 
 	if (kbd->backlight_dev && appletb_tb_autodim) {
 		if (!kbd->has_dimmed) {
 			backlight_device_set_brightness(kbd->backlight_dev, 1);
 			kbd->has_dimmed = true;
-			mod_timer(&kbd->inactivity_timer,
-				jiffies + secs_to_jiffies(appletb_tb_idle_timeout));
+			mod_delayed_work(system_wq, &kbd->inactivity_work,
+					 secs_to_jiffies(appletb_tb_idle_timeout));
 		} else if (!kbd->has_turned_off) {
 			backlight_device_set_brightness(kbd->backlight_dev, 0);
 			kbd->has_turned_off = true;
@@ -181,16 +184,25 @@ static void appletb_inactivity_timer(struct timer_list *t)
 	}
 }
 
+static void appletb_restore_brightness_work(struct work_struct *work)
+{
+	struct appletb_kbd *kbd = container_of(work, struct appletb_kbd,
+					       restore_brightness_work);
+
+	if (kbd->backlight_dev)
+		backlight_device_set_brightness(kbd->backlight_dev, 2);
+}
+
 static void reset_inactivity_timer(struct appletb_kbd *kbd)
 {
 	if (kbd->backlight_dev && appletb_tb_autodim) {
 		if (kbd->has_dimmed || kbd->has_turned_off) {
-			backlight_device_set_brightness(kbd->backlight_dev, 2);
 			kbd->has_dimmed = false;
 			kbd->has_turned_off = false;
+			schedule_work(&kbd->restore_brightness_work);
 		}
-		mod_timer(&kbd->inactivity_timer,
-			jiffies + secs_to_jiffies(appletb_tb_dim_timeout));
+		mod_delayed_work(system_wq, &kbd->inactivity_work,
+				 secs_to_jiffies(appletb_tb_dim_timeout));
 	}
 }
 
@@ -408,9 +420,11 @@ static int appletb_kbd_probe(struct hid_device *hdev, const struct hid_device_id
 		dev_err_probe(dev, -ENODEV, "Failed to get backlight device\n");
 	} else {
 		backlight_device_set_brightness(kbd->backlight_dev, 2);
-		timer_setup(&kbd->inactivity_timer, appletb_inactivity_timer, 0);
-		mod_timer(&kbd->inactivity_timer,
-			jiffies + secs_to_jiffies(appletb_tb_dim_timeout));
+		INIT_DELAYED_WORK(&kbd->inactivity_work, appletb_inactivity_work);
+		INIT_WORK(&kbd->restore_brightness_work,
+			  appletb_restore_brightness_work);
+		mod_delayed_work(system_wq, &kbd->inactivity_work,
+				 secs_to_jiffies(appletb_tb_dim_timeout));
 	}
 
 	kbd->inp_handler.event = appletb_kbd_inp_event;
@@ -444,7 +458,8 @@ static int appletb_kbd_probe(struct hid_device *hdev, const struct hid_device_id
 stop_hw:
 	hid_hw_stop(hdev);
 	if (kbd->backlight_dev) {
-		timer_delete_sync(&kbd->inactivity_timer);
+		cancel_delayed_work_sync(&kbd->inactivity_work);
+		cancel_work_sync(&kbd->restore_brightness_work);
 		put_device(&kbd->backlight_dev->dev);
 	}
 	return ret;
@@ -461,7 +476,8 @@ static void appletb_kbd_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 
 	if (kbd->backlight_dev) {
-		timer_delete_sync(&kbd->inactivity_timer);
+		cancel_delayed_work_sync(&kbd->inactivity_work);
+		cancel_work_sync(&kbd->restore_brightness_work);
 		put_device(&kbd->backlight_dev->dev);
 	}
 }
-- 
2.34.1


