Return-Path: <stable+bounces-89579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A679BA393
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 03:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFEE3B21DFA
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 02:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7710A70818;
	Sun,  3 Nov 2024 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JFHGXrMZ"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C4F67A0D
	for <stable@vger.kernel.org>; Sun,  3 Nov 2024 02:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730600915; cv=none; b=iXjbeughaOu3ei6HhA4i3d4bt9v6d9rwY2NLYBlDjPfbcwrYwkbRTgNlCKnXZnS2S91U9BgAPmxRvKMhVJA7RvIE1My6j5LcPNSMQEqVzIBLXNKlK3txfct7Y2ka1X/vWV+zeQwtzwGn4Yy3gDF7SFN1vo7QRHGYmPJGvfZDUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730600915; c=relaxed/simple;
	bh=06J6/m0jnYRXz+yUUnXWy8Iz6RF6czQufXKFJgqWj9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPhq9Z/SL3t3AEXuSFyxjxuR8EO6I7d5rHpcsB3oFlPhJbbXjJNTei3GGW3/WS4qJc4Y4D8BDhbZ9MMKOCfxkXzsYi/Bq4ls0BfjgasifgTq4meak8nWd+wdRniTaP8rApa1dGk79ZWCB4Yvt1DMVMy0yVlwRJf34187uLAHY4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JFHGXrMZ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9B4lvtXVj/PQ+0R5HZk+F2FoD9aZutv0ZXbyQAyP5Ao=; b=JFHGXrMZnUDiQLhfhARb7gE1ud
	COg6zVJjMpXX7X0Wy2sV75jwyR1DhrwD1jMTDEKI1RtrnNKLzlqMYddwA2BWVG9EP55juZOOB76Mr
	RxRfCdNpEV9cFQb/sl4gpQdeNSQLRXJNcbvUaH1oCiZDceVYVLpzHx0I4DEjtP9AD5hZGrkd9Fww+
	Si6WqHV0+A3HmlVGaeU2o2Yn+bnVhgy6Lq9RWaPhCGNhFdIx1uPx6ImMF7dKbfcD252AwZFvlBwCu
	qiBBM1sX0uGX8yUiJ8DZXOz7O4bZHEU88gwVwj2+H25srtGhH2LTFfZsYcyST1BRyUWDFeUNCL0j5
	yQg7EUlQ==;
Received: from [189.79.117.125] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t7QLu-0010FE-UK; Sun, 03 Nov 2024 03:28:31 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	sylv@sylv.io,
	andreyknvl@gmail.com,
	stern@rowland.harvard.edu,
	kernel@gpiccoli.net,
	kernel-dev@igalia.com
Subject: [PATCH 6.1.y / 6.6.y 4/4] USB: gadget: dummy-hcd: Fix "task hung" problem
Date: Sat,  2 Nov 2024 23:13:53 -0300
Message-ID: <20241103022812.1465647-5-gpiccoli@igalia.com>
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

From: Alan Stern <stern@rowland.harvard.edu>

commit 5189df7b8088268012882c220d6aca4e64981348 upstream.

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
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index ff7bee78bcc4..d5d89fadde43 100644
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
2.46.2


