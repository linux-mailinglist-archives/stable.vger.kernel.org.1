Return-Path: <stable+bounces-89577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3DF9BA390
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 03:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0D1282E09
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 02:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B377080D;
	Sun,  3 Nov 2024 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="R6i9A2oI"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB80E67A0D
	for <stable@vger.kernel.org>; Sun,  3 Nov 2024 02:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730600912; cv=none; b=fFjvNYM1zfLDQWz0IB0SLwOyIffz8YJFKmNNYa9+a3bEiTQH0YvUtmD5KRpezH5CB/dGGOYqW4et1byU2z+KJ0zoKht/W6vWorY4So3cCcKW7xAhjTVPHsMgsqTFJ8uKR+LjWDNN9vEEDMsBCzMWx35deuf6hUlok2QchTj3BCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730600912; c=relaxed/simple;
	bh=ckqJ6h6Z5OAmClGY9sHuUdT1DOXuZNaeGo8gjFFJq7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtqpbZ844CHGUWETwe7rMCNL1GkjHJ5pydKZxlgFNDj/nFnlG9C9anId17ewT5/atqY6vgdcaByVgmo9VZoSpM9chKdG0PzT+pZfEYbbgYPw6lS1dv91MSFqtCpIa+tWP2N1Jl9OKylHFcs3BtT/IHs4PbAPzB6TUdRZj/01nF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=R6i9A2oI; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pHLu7P2Jeh7hstxV8LV/pkzSz4PPGL4NmwnnHChdgb8=; b=R6i9A2oIf4EIyY4ig2q07YFt33
	kNEXJhF/7Ztbe/i0u5oep8itW//WMkkypS7Azsus4/yoFE4CIhszgFm+DIiU5Hy1YE+iNatMQbjQk
	lqK1tDEuixcdU/KBioM69vAtsW4LbhZj+nv7iXc/f9CVq02Ku7ynREffrsPqaE/pUER0fjQmyhWwi
	BmeQWcQ6N565b0X+N7cXbZKrfaAOqlm6jjX7QPzzHl6QoK1UR/YyGxkl9T3UumWrb8LVf1WvLKp4w
	FD3yQV2mNxpWxJ/Pwxq6YRA8o/G4Dqkmv6Pu0RIUZSSkWXJFfewMFW59TGhDOwHjGuVskKChsDkVl
	MmR4VHDw==;
Received: from [189.79.117.125] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t7QLr-0010F3-7r; Sun, 03 Nov 2024 03:28:27 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	sylv@sylv.io,
	andreyknvl@gmail.com,
	stern@rowland.harvard.edu,
	kernel@gpiccoli.net,
	kernel-dev@igalia.com
Subject: [PATCH 6.1.y / 6.6.y 3/4] usb: gadget: dummy_hcd: execute hrtimer callback in softirq context
Date: Sat,  2 Nov 2024 23:13:52 -0300
Message-ID: <20241103022812.1465647-4-gpiccoli@igalia.com>
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

From: Andrey Konovalov <andreyknvl@gmail.com>

commit 9313d139aa25e572d860f6f673b73a20f32d7f93 upstream.

Commit a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer transfer
scheduler") switched dummy_hcd to use hrtimer and made the timer's
callback be executed in the hardirq context.

With that change, __usb_hcd_giveback_urb now gets executed in the hardirq
context, which causes problems for KCOV and KMSAN.

One problem is that KCOV now is unable to collect coverage from
the USB code that gets executed from the dummy_hcd's timer callback,
as KCOV cannot collect coverage in the hardirq context.

Another problem is that the dummy_hcd hrtimer might get triggered in the
middle of a softirq with KCOV remote coverage collection enabled, and that
causes a WARNING in KCOV, as reported by syzbot. (I sent a separate patch
to shut down this WARNING, but that doesn't fix the other two issues.)

Finally, KMSAN appears to ignore tracking memory copying operations
that happen in the hardirq context, which causes false positive
kernel-infoleaks, as reported by syzbot.

Change the hrtimer in dummy_hcd to execute the callback in the softirq
context.

Reported-by: syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2388cdaeb6b10f0c13ac
Reported-by: syzbot+17ca2339e34a1d863aad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=17ca2339e34a1d863aad
Reported-by: syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c793a7eca38803212c61
Reported-by: syzbot+1e6e0b916b211bee1bd6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1e6e0b916b211bee1bd6
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202406141323.413a90d2-lkp@intel.com
Fixes: a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler")
Cc: stable@vger.kernel.org
Acked-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
Reported-by: syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=edd9fe0d3a65b14588d5
Link: https://lore.kernel.org/r/20240904013051.4409-1-andrey.konovalov@linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index f37b0d8386c1..ff7bee78bcc4 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -1304,7 +1304,8 @@ static int dummy_urb_enqueue(
 
 	/* kick the scheduler, it'll do the rest */
 	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+				HRTIMER_MODE_REL_SOFT);
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1325,7 +1326,7 @@ static int dummy_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
 			!list_empty(&dum_hcd->urbp_list))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
 
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
@@ -1995,7 +1996,8 @@ static enum hrtimer_restart dummy_timer(struct hrtimer *t)
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
 		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+				HRTIMER_MODE_REL_SOFT);
 	}
 
 	spin_unlock_irqrestore(&dum->lock, flags);
@@ -2389,7 +2391,7 @@ static int dummy_bus_resume(struct usb_hcd *hcd)
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
 		if (!list_empty(&dum_hcd->urbp_list))
-			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
+			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);
@@ -2467,7 +2469,7 @@ static DEVICE_ATTR_RO(urbs);
 
 static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 {
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	dum_hcd->timer.function = dummy_timer;
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep = 0;
@@ -2497,7 +2499,7 @@ static int dummy_start(struct usb_hcd *hcd)
 		return dummy_start_ss(dum_hcd);
 
 	spin_lock_init(&dum_hcd->dum->lock);
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	dum_hcd->timer.function = dummy_timer;
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 
-- 
2.46.2


