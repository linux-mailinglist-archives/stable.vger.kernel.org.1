Return-Path: <stable+bounces-90882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8C19BEB77
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CFE1F277CA
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A213F1F757A;
	Wed,  6 Nov 2024 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BimWdf+y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D03B1EBA12;
	Wed,  6 Nov 2024 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897094; cv=none; b=Ezy2SyxOBcUxiAGKocRCa0fdSkD6oPQfNEjfpR3vi5LlY22/rvN2tMAhgfOAVxvErLPXKyZYRjWFyWRhopHy1HDoezwWT+AsO6/qiBr7+UANSumV6AEo6ZVA/v/xW8+v/oOh4rN6ozkpgN5x0Nc0A8BeibPHFB8TqRaLLpLFNSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897094; c=relaxed/simple;
	bh=HexVmnB7rFKbv/mH773j+x7/lMK7ItyVZrwlSxF1BXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjmFBQpcqk6+eiVrReFinqzI3XhX5hHhPwPlCfGktGNf+XoHTVwziiz1px1rHWHeT15Sawui/zgDMlKqlIgzFJi1KpeXJyUJOXQHrpR4It8MR4UK3MrouzNZSQmG21jvw4V5HC/oagdq8vfmFWqAXnxEP/anyWEfMnxg7Ra1Oh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BimWdf+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B91C4CECD;
	Wed,  6 Nov 2024 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897094;
	bh=HexVmnB7rFKbv/mH773j+x7/lMK7ItyVZrwlSxF1BXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BimWdf+yU5TGiQdJ2766ckhVdpelIh47vL855rj62/srdGYJzUa35wEq+DU3vEr3r
	 tMwYp4eCzjHU4LMqexTyuXXgEyr4/nL66u99agbg5utYe7yOeUO/oSR/BNxBskqPU1
	 HcTR56aA6liRg14mWUsjoMIpRCuDPE7p8nS/Nq8Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com,
	syzbot+17ca2339e34a1d863aad@syzkaller.appspotmail.com,
	syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com,
	syzbot+1e6e0b916b211bee1bd6@syzkaller.appspotmail.com,
	kernel test robot <oliver.sang@intel.com>,
	Marcello Sylvester Bauer <sylv@sylv.io>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 063/126] usb: gadget: dummy_hcd: execute hrtimer callback in softirq context
Date: Wed,  6 Nov 2024 13:04:24 +0100
Message-ID: <20241106120307.795228627@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120306.038154857@linuxfoundation.org>
References: <20241106120306.038154857@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Konovalov <andreyknvl@gmail.com>

[ Upstream commit 9313d139aa25e572d860f6f673b73a20f32d7f93 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 32a03de215d37..019e8f3007c94 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -1305,7 +1305,8 @@ static int dummy_urb_enqueue(
 
 	/* kick the scheduler, it'll do the rest */
 	if (!hrtimer_active(&dum_hcd->timer))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+				HRTIMER_MODE_REL_SOFT);
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1326,7 +1327,7 @@ static int dummy_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
 			!list_empty(&dum_hcd->urbp_list))
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
 
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
@@ -1996,7 +1997,8 @@ static enum hrtimer_restart dummy_timer(struct hrtimer *t)
 		dum_hcd->udev = NULL;
 	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
 		/* want a 1 msec delay here */
-		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS), HRTIMER_MODE_REL);
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+				HRTIMER_MODE_REL_SOFT);
 	}
 
 	spin_unlock_irqrestore(&dum->lock, flags);
@@ -2390,7 +2392,7 @@ static int dummy_bus_resume(struct usb_hcd *hcd)
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
 		if (!list_empty(&dum_hcd->urbp_list))
-			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL);
+			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);
@@ -2468,7 +2470,7 @@ static DEVICE_ATTR_RO(urbs);
 
 static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 {
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	dum_hcd->timer.function = dummy_timer;
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep = 0;
@@ -2498,7 +2500,7 @@ static int dummy_start(struct usb_hcd *hcd)
 		return dummy_start_ss(dum_hcd);
 
 	spin_lock_init(&dum_hcd->dum->lock);
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
 	dum_hcd->timer.function = dummy_timer;
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 
-- 
2.43.0




