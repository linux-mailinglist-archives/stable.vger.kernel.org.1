Return-Path: <stable+bounces-91036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 715FF9BEC25
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FAA02854AD
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA7F1FB3C0;
	Wed,  6 Nov 2024 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tONd4pr+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F21E00AF;
	Wed,  6 Nov 2024 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897551; cv=none; b=X+pTgF1oC7cf8aqLFAls+T4rGHCR+DHQZ9Habln3iZDqeXwwhY0jiHWHjMm5zFMpNvB6dd77Kx9EU7hZljcxp11Pob6kONoOsGlQgZVUAM+B+YOKjwFD+ZsmyLU0AaLsnyo5bL9xVpu0wTkyhxU+6+ieui/y8HEuwz3r8Xsc1Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897551; c=relaxed/simple;
	bh=a1oGouZm+owF+YeDcJr385s8DDEUnDJ/7UlE1hbU9Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UC4HYv5xeXPYqsHI6/F6Na5ZwahJ90ukqJJOSzGvUgr0sob2ztGePlmxD6b/R2iTzr+UWSq6LU6eJIy1PfNDk6rgKAiuBgMCmt7swVPbwNiAgCijTgkF+U1RRjo5XL2FQSN09xgKPXLYpKQyZ4ixTiD9iy/8L4SY8XzF085SMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tONd4pr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F27C4CECD;
	Wed,  6 Nov 2024 12:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897551;
	bh=a1oGouZm+owF+YeDcJr385s8DDEUnDJ/7UlE1hbU9Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tONd4pr+lpNRyJHgUIciR6t9+/KOMdIQnjZ/2KyUl28qxGF9FnesfKroE81y+TZ97
	 NslvFfzlJ1csjd/qvpulmNwJk8DABLC8RmbsjDREYc+ZyMuEpoYbHnA2Nj6C6zZ5o3
	 rAuXKTtEOILBBZRM6TlGupBOYn/pFYeaWFX7tuas=
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
Subject: [PATCH 6.6 074/151] usb: gadget: dummy_hcd: execute hrtimer callback in softirq context
Date: Wed,  6 Nov 2024 13:04:22 +0100
Message-ID: <20241106120310.885706497@linuxfoundation.org>
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
index f37b0d8386c1a..ff7bee78bcc49 100644
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
2.43.0




