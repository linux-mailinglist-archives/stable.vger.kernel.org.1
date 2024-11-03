Return-Path: <stable+bounces-89575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A74A49BA38F
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 03:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A411C20E48
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 02:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EBE70807;
	Sun,  3 Nov 2024 02:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VjjMcPYI"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A13C2FB
	for <stable@vger.kernel.org>; Sun,  3 Nov 2024 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730600910; cv=none; b=iSqg561/MZKLoVoXCJ01R5TwkHHSyY0DSNhH9GRSNhx/kreaxhkwghaca+u2pIAddU8F+0cpXuYwnB1nk5FVom3yWg3L3oTthnskxb5gvsLzQHh0m9MPHWsx/IqbrB8w6o8yfYB7lqCAot60ajf9AFjHRfedRpvG/r1UtXCjiZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730600910; c=relaxed/simple;
	bh=2lOPUEz/VvLIMvmkPDtVgTUP5nUStzqcRe4x29/PFrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIML7Imr6iISFz/kgG8L7gelT0uLMXKOnuZWzJIQQxSTpxhNqjogAlYA5olTlxxr49LigtQByDIp8IPQkyHS0HsiCqdJa7skHiHjZxP+vCeXpEhKLscnHhoQPXbjXJ2LECH3hVV2zSxHWcHGUcspTVwSwudAYpnEKatJQoEwLuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VjjMcPYI; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CTT96+xBfeGKBld4taxN2SFTe+E8R+GqSG1F/WZX3BY=; b=VjjMcPYI52UM+UZvV9AoqQ/cVo
	SyuQkuUMtyalYpfRjcHNjfZd5yhFjaPEzT1WxylbF4z+DtyZpRnl0o+3gOlda4LVSZQ5PyO04KquF
	y3SE8zYTPr1rVLvxvxilLXgEyzWqQpe/zEcdm4VXqQgpt2D99d6RziEvYffQmTzvBurwzOoqIyIOC
	2DTQRYllTGOyM6vsHYdG8SYXN8ahOyAjZrSnYo8t1JjHKG+sou5QiqsoyTcGSqB1cwPqSrwNLa5cj
	/OtmH3/SctiMg61Fpy0CEHvja6eY3oMewM+X/NtDJQfQ8sgMHXGi1swxnGpSBn1e54zgkFRET8ukC
	7YYF/xwQ==;
Received: from [189.79.117.125] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t7QLj-0010Er-PH; Sun, 03 Nov 2024 03:28:20 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	sylv@sylv.io,
	andreyknvl@gmail.com,
	stern@rowland.harvard.edu,
	kernel@gpiccoli.net,
	kernel-dev@igalia.com
Subject: [PATCH 6.1.y / 6.6.y 1/4] usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler
Date: Sat,  2 Nov 2024 23:13:50 -0300
Message-ID: <20241103022812.1465647-2-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241103022812.1465647-1-gpiccoli@igalia.com>
References: <20241103022812.1465647-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcello Sylvester Bauer <sylv@sylv.io>

commit a7f3813e589fd8e2834720829a47b5eb914a9afe upstream.

The dummy_hcd transfer scheduler assumes that the internal kernel timer
frequency is set to 1000Hz to give a polling interval of 1ms. Reducing
the timer frequency will result in an anti-proportional reduction in
transfer performance. Switch to a hrtimer to decouple this association.

Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/57a1c2180ff74661600e010c234d1dbaba1d0d46.1712843963.git.sylv@sylv.io
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 35 +++++++++++++++++-------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 0953e1b5c030..dab559d8ee8c 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -30,7 +30,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/timer.h>
+#include <linux/hrtimer.h>
 #include <linux/list.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
@@ -240,7 +240,7 @@ enum dummy_rh_state {
 struct dummy_hcd {
 	struct dummy			*dum;
 	enum dummy_rh_state		rh_state;
-	struct timer_list		timer;
+	struct hrtimer			timer;
 	u32				port_status;
 	u32				old_status;
 	unsigned long			re_timeout;
@@ -1301,8 +1301,8 @@ static int dummy_urb_enqueue(
 		urb->error_count = 1;		/* mark as a new urb */
 
 	/* kick the scheduler, it'll do the rest */
-	if (!timer_pending(&dum_hcd->timer))
-		mod_timer(&dum_hcd->timer, jiffies + 1);
+	if (!hrtimer_active(&dum_hcd->timer))
+		hrtimer_start(&dum_hcd->timer, ms_to_ktime(1), HRTIMER_MODE_REL);
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1323,7 +1323,7 @@ static int dummy_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
 			!list_empty(&dum_hcd->urbp_list))
-		mod_timer(&dum_hcd->timer, jiffies);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
 
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
@@ -1777,7 +1777,7 @@ static int handle_control_request(struct dummy_hcd *dum_hcd, struct urb *urb,
  * drivers except that the callbacks are invoked from soft interrupt
  * context.
  */
-static void dummy_timer(struct timer_list *t)
+static enum hrtimer_restart dummy_timer(struct hrtimer *t)
 {
 	struct dummy_hcd	*dum_hcd = from_timer(dum_hcd, t, timer);
 	struct dummy		*dum = dum_hcd->dum;
@@ -1808,8 +1808,6 @@ static void dummy_timer(struct timer_list *t)
 		break;
 	}
 
-	/* FIXME if HZ != 1000 this will probably misbehave ... */
-
 	/* look at each urb queued by the host side driver */
 	spin_lock_irqsave(&dum->lock, flags);
 
@@ -1817,7 +1815,7 @@ static void dummy_timer(struct timer_list *t)
 		dev_err(dummy_dev(dum_hcd),
 				"timer fired with no URBs pending?\n");
 		spin_unlock_irqrestore(&dum->lock, flags);
-		return;
+		return HRTIMER_NORESTART;
 	}
 	dum_hcd->next_frame_urbp = NULL;
 
@@ -1995,10 +1993,12 @@ static void dummy_timer(struct timer_list *t)
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
 		/* want a 1 msec delay here */
-		mod_timer(&dum_hcd->timer, jiffies + msecs_to_jiffies(1));
+		hrtimer_start(&dum_hcd->timer, ms_to_ktime(1), HRTIMER_MODE_REL);
 	}
 
 	spin_unlock_irqrestore(&dum->lock, flags);
+
+	return HRTIMER_NORESTART;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -2387,7 +2387,7 @@ static int dummy_bus_resume(struct usb_hcd *hcd)
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
 		if (!list_empty(&dum_hcd->urbp_list))
-			mod_timer(&dum_hcd->timer, jiffies);
+			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);
@@ -2465,7 +2465,8 @@ static DEVICE_ATTR_RO(urbs);
 
 static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 {
-	timer_setup(&dum_hcd->timer, dummy_timer, 0);
+	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	dum_hcd->timer.function = dummy_timer;
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep = 0;
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
@@ -2494,7 +2495,8 @@ static int dummy_start(struct usb_hcd *hcd)
 		return dummy_start_ss(dum_hcd);
 
 	spin_lock_init(&dum_hcd->dum->lock);
-	timer_setup(&dum_hcd->timer, dummy_timer, 0);
+	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	dum_hcd->timer.function = dummy_timer;
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
@@ -2513,8 +2515,11 @@ static int dummy_start(struct usb_hcd *hcd)
 
 static void dummy_stop(struct usb_hcd *hcd)
 {
-	device_remove_file(dummy_dev(hcd_to_dummy_hcd(hcd)), &dev_attr_urbs);
-	dev_info(dummy_dev(hcd_to_dummy_hcd(hcd)), "stopped\n");
+	struct dummy_hcd	*dum_hcd = hcd_to_dummy_hcd(hcd);
+
+	hrtimer_cancel(&dum_hcd->timer);
+	device_remove_file(dummy_dev(dum_hcd), &dev_attr_urbs);
+	dev_info(dummy_dev(dum_hcd), "stopped\n");
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.46.2


