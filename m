Return-Path: <stable+bounces-238687-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNMPG7q15WkGnQEAu9opvQ
	(envelope-from <stable+bounces-238687-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:12:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5081426CD3
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3A3930179D7
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 05:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED16345CDA;
	Mon, 20 Apr 2026 05:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="YM4CLXf7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E32C326C
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 05:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776661939; cv=none; b=Sn8RTUHHIWiU9ZnQ96tRfbII7GGiYkc3KwoXoEuW6uEBG1xS2hyb5xJ7DLOP5KvckMbkueAKzoeX8NznRBsgo15DKj/4SgbH2LfsGVSfB3KB4KLwH4qYnCWlZQppm3XL0LWkbFpFjKEsWa02lqt/24OgmTUEOfX0fGZgm/wJd+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776661939; c=relaxed/simple;
	bh=01XNhHkfueCJ1FLR+EHojwXfn62aRxo9vj4McCxGw5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R8DN6jrobJ6aSvBLFNwC3adi6/hoyeI9NzL/PPWgBXZjFn9Vx/IFU5hufPVxUeUlBKIwxPog+vW7UduGMd1TLjFIE+yigS9tiCe9Ud/HXc54Va6TFHPGUYB0djPJBvpZSMiekyxOfMjpA4+t+3CDn9BTQ6cmH9OADu1KbCW/YiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=YM4CLXf7; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35e563b0ee7so1174819a91.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 22:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1776661936; x=1777266736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihcvVaBfQ28dquD5a+undc5jBXoT8T5VO4GMetOrvw0=;
        b=YM4CLXf7tE5vcsp2q7cS0fQV69670uuaBO5LvN3O7cgKAzVGfh8alb9VrsYH58lUWw
         4F31qiYsGW7B6iHqXUK3GIoAh1Sc/n7Sxu7cGc1OKjuPWDXurJUkyQ+oWA7wndL/RV13
         CEKWUhwGqddx61OIL+Pr6UimsIGsrV61Ugra8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776661936; x=1777266736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ihcvVaBfQ28dquD5a+undc5jBXoT8T5VO4GMetOrvw0=;
        b=XJdw3SmYG/7qoR6N2j76RWPDGEvmQHeESlkdy0OALxu3ZuwXF3GU3/1B8g44X+suIj
         OiWw3AwyfiAydUGliPA73rJ3j2x8xOvQo4Tgu1EvXNA/yPB9D3+KVvP6M20q3vyLD/fB
         GQc2Azb5dsmKarW+NrzQJPd19taa/9xbZN/4L9el4vbmNqSTmwNoVQJm8Gd5tdVFQeU5
         iUxtDoTSAVjpnd9mbryLThMAJuGEpPKdBz0PDPH/NHOS3xMGhES+IZlAY0P+ILEMYODu
         1EL2szlAFYz4MegYO88JIv/GIL9xMr6mgtohd/nE6swv0C7lhMijE2yWC39b0R8e41dw
         HZaQ==
X-Gm-Message-State: AOJu0YymRH1iZM6Be8ECO+TrrahaZoXn8zkECYHd31GG8+5ju+mIloDk
	VKz8aDhXtVLG1AUdmRuan6e+P9lsHfz0sWNCPJtV1z3QL52XfoAOojy5TmDbbrfIN0m5GgP7z3F
	T2//MZfw=
X-Gm-Gg: AeBDies5DdVNMzCXoetKdlseacKi4LA+UEEQ1OS43+HGuXpPYL76nlXwJDQJRrEr/Eg
	xsJMj6Cw9h+CzONtyU6arY4QpgZ05+s9NfELI9aProUPxH66miFV22EGbcvyuX7ulLaMErrI+Po
	1xUxtJFbnzPCjYGczj4P6uRcSX+PF36wSQki1PyP/vWzcQA2NtkblP9XMBeQktHr4noSck8WWQC
	ejVRedgMts0QMtPCxGJAQZIdM9uPkfIqqD1aLQ45VPfAAotUsdOStJLPxMiMTM8ICSWTSaS/bGM
	Dc6PcY07GXZuA1za0fA5DBrk3gcUpXTENo5rDAL/yX1mIpr4eFAAOZWG/UC1X4/h+I4ms5cgCGf
	hyH0SdQrkenMOWA8ntrwiA8TmSlHJBVFnm9MinP25NXK4B846jyhwvqjjelAqNJ04xiCWrphL3g
	z7ZMPEKpzWj80uo/P12RRq39dwfjyTaZ5CwWiV1oHzN5kSXCyj6MacNdy2OFJtBRgkPJwrKA==
X-Received: by 2002:a17:90b:3b86:b0:35f:b931:d1c0 with SMTP id 98e67ed59e1d1-361401f4ff0mr11031610a91.6.1776661935661;
        Sun, 19 Apr 2026 22:12:15 -0700 (PDT)
Received: from nunu.. (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fa8068csm3597638a91.2.2026.04.19.22.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 22:12:15 -0700 (PDT)
From: Sangyun Kim <sangyun.kim@snu.ac.kr>
To: sangyun.kim@snu.ac.kr
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] HID: appletb-kbd: run inactivity autodim from workqueues
Date: Mon, 20 Apr 2026 14:11:53 +0900
Message-Id: <20260420051153.1407382-3-sangyun.kim@snu.ac.kr>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[snu.ac.kr:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[snu.ac.kr:+];
	TAGGED_FROM(0.00)[bounces-238687-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sangyun.kim@snu.ac.kr,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5081426CD3
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


