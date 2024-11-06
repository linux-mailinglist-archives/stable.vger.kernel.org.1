Return-Path: <stable+bounces-91047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F629BEC31
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207F61C23904
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAD81FB3D5;
	Wed,  6 Nov 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dlgY4cz4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859A1F12EA;
	Wed,  6 Nov 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897583; cv=none; b=QsIsgEu+0n9ykhOfRKaiRB3LIdF1nOsJiEzRV1puZCAFFBBnqW9lu/0z6LSxbIw24eobTBry56a5zL7AWawAsjy3TfwzROw1vXkI7WsjIMGSLs4zoDMxwBIabQ5MC0RrokPSxzG19ZH1EuFgFzaUEGr75eyvRaDdYui4S8wm6Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897583; c=relaxed/simple;
	bh=66v7k2MLyHEgEUSwOhlRRh1xpcaO7Qjet/hOU1nO8Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NW3lUemF5Gj1KXy/3M00jdizymKMWwFelkzxm8T3WS/o2eYJ+bXmCWW2HVNs2oTVZANulhYdAMj58P8iEnlT44np3Drnly9fDP/6R1mTHDEP7RyXkMi5OMHxRlsSdi25dKo7EamdGH4wMsZKroTaCb3DWB4BbaiIlmgYMjD9MI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dlgY4cz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E284C4CECD;
	Wed,  6 Nov 2024 12:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897583;
	bh=66v7k2MLyHEgEUSwOhlRRh1xpcaO7Qjet/hOU1nO8Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dlgY4cz4S+5HR7Wy5kqHLmXf4/4k9nLJ/UeGwj9ICZRnwfc9i7BWFy3KnFZlcOaPY
	 O0lFl4G99N8j+nGInbGrlx4+O1T0JKtV4H7igH/KxGISaGNfX6FbFGg0vrQlJfYPdL
	 DHBiXOFMHoquueBENHj+x8n2dALE0aDdjJsgc4+Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com,
	Alan Stern <stern@rowland.harvard.edu>,
	Marcello Sylvester Bauer <sylv@sylv.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 075/151] USB: gadget: dummy-hcd: Fix "task hung" problem
Date: Wed,  6 Nov 2024 13:04:23 +0100
Message-ID: <20241106120310.914366776@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

[ Upstream commit 5189df7b8088268012882c220d6aca4e64981348 ]

The syzbot fuzzer has been encountering "task hung" problems ever
since the dummy-hcd driver was changed to use hrtimers instead of
regular timers.  It turns out that the problems are caused by a subtle
difference between the timer_pending() and hrtimer_active() APIs.

The changeover blindly replaced the first by the second.  However,
timer_pending() returns True when the timer is queued but not when its
callback is running, whereas hrtimer_active() returns True when the
hrtimer is queued _or_ its callback is running.  This difference
occasionally caused dummy_urb_enqueue() to think that the callback
routine had not yet started when in fact it was almost finished.  As a
result the hrtimer was not restarted, which made it impossible for the
driver to dequeue later the URB that was just enqueued.  This caused
usb_kill_urb() to hang, and things got worse from there.

Since hrtimers have no API for telling when they are queued and the
callback isn't running, the driver must keep track of this for itself.
That's what this patch does, adding a new "timer_pending" flag and
setting or clearing it at the appropriate times.

Reported-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-usb/6709234e.050a0220.3e960.0011.GAE@google.com/
Tested-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Fixes: a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler")
Cc: Marcello Sylvester Bauer <sylv@sylv.io>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/2dab644e-ef87-4de8-ac9a-26f100b2c609@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index ff7bee78bcc49..d5d89fadde433 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -254,6 +254,7 @@ struct dummy_hcd {
 	u32				stream_en_ep;
 	u8				num_stream[30 / 2];
 
+	unsigned			timer_pending:1;
 	unsigned			active:1;
 	unsigned			old_active:1;
 	unsigned			resuming:1;
@@ -1303,9 +1304,11 @@ static int dummy_urb_enqueue(
 		urb->error_count = 1;		/* mark as a new urb */
 
 	/* kick the scheduler, it'll do the rest */
-	if (!hrtimer_active(&dum_hcd->timer))
+	if (!dum_hcd->timer_pending) {
+		dum_hcd->timer_pending = 1;
 		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
 				HRTIMER_MODE_REL_SOFT);
+	}
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1324,9 +1327,10 @@ static int dummy_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	spin_lock_irqsave(&dum_hcd->dum->lock, flags);
 
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
-	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
-			!list_empty(&dum_hcd->urbp_list))
+	if (rc == 0 && !dum_hcd->timer_pending) {
+		dum_hcd->timer_pending = 1;
 		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
+	}
 
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
@@ -1813,6 +1817,7 @@ static enum hrtimer_restart dummy_timer(struct hrtimer *t)
 
 	/* look at each urb queued by the host side driver */
 	spin_lock_irqsave(&dum->lock, flags);
+	dum_hcd->timer_pending = 0;
 
 	if (!dum_hcd->udev) {
 		dev_err(dummy_dev(dum_hcd),
@@ -1994,8 +1999,10 @@ static enum hrtimer_restart dummy_timer(struct hrtimer *t)
 	if (list_empty(&dum_hcd->urbp_list)) {
 		usb_put_dev(dum_hcd->udev);
 		dum_hcd->udev = NULL;
-	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
+	} else if (!dum_hcd->timer_pending &&
+			dum_hcd->rh_state == DUMMY_RH_RUNNING) {
 		/* want a 1 msec delay here */
+		dum_hcd->timer_pending = 1;
 		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
 				HRTIMER_MODE_REL_SOFT);
 	}
@@ -2390,8 +2397,10 @@ static int dummy_bus_resume(struct usb_hcd *hcd)
 	} else {
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
-		if (!list_empty(&dum_hcd->urbp_list))
+		if (!list_empty(&dum_hcd->urbp_list)) {
+			dum_hcd->timer_pending = 1;
 			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
+		}
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);
@@ -2522,6 +2531,7 @@ static void dummy_stop(struct usb_hcd *hcd)
 	struct dummy_hcd	*dum_hcd = hcd_to_dummy_hcd(hcd);
 
 	hrtimer_cancel(&dum_hcd->timer);
+	dum_hcd->timer_pending = 0;
 	device_remove_file(dummy_dev(dum_hcd), &dev_attr_urbs);
 	dev_info(dummy_dev(dum_hcd), "stopped\n");
 }
-- 
2.43.0




