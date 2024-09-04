Return-Path: <stable+bounces-72953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0BF96ADE9
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 03:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB21F257F0
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 01:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CEE8479;
	Wed,  4 Sep 2024 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KUlzZgiJ"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462B567D;
	Wed,  4 Sep 2024 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413467; cv=none; b=MQOEt4w1VNcwacMx4jzMj962q9pvy8XHZmZb+VM8BbMN3m6N//nE0xuuQ0wWUz+lr6My0DdzcAbUbHMxzQU3Gt41bdvkRleQRDPNSgxDEXPNYgkpr1zhjmzUdprAz76C4Pb3pe5gQa2YMtKE3QNtUz312lCzwWjotM0TiHMKZ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413467; c=relaxed/simple;
	bh=LIUyycDvROy5iNOtTz3M482W+u8Sd2xZz+Xs2pvi8mE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pbTF26MEoUQ3Y/4fJeAX1PqNQxJscje0wBUO1OB9gHqUk7Qv/H4A24AoleBd5TWyRQadt6rbZAyW83aPpzFuPx35aq9wj4FSvAbi9SmPxz+tMqezKcHb5ctP4sqSW5ecoqtnSGhv9nTD09U59wUVeqiQUzOMBOCZ2K7RVG9vE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KUlzZgiJ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725413463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WL9bEn+qeDafnFmH2mu2935t12N8fCu85vsLBSg/BdU=;
	b=KUlzZgiJuJSYHN+i7rnldF1DXMLALcV5cP8B74rvHYdqcgDTYYan8dRZQCvsclGrJshFeM
	YB8GHLB/CSUWZ4TYvL/xb9go8Z76o/l2YvTsaFs6C6f0CdYdI/EuwMUavGD3hzLAtRjQZR
	kImfUL3RcfUylpBB/OCSB/vcbskOMqs=
From: andrey.konovalov@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	kasan-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Marcello Sylvester Bauer <sylv@sylv.io>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com,
	syzbot+17ca2339e34a1d863aad@syzkaller.appspotmail.com,
	syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com,
	syzbot+1e6e0b916b211bee1bd6@syzkaller.appspotmail.com,
	kernel test robot <oliver.sang@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] usb: gadget: dummy_hcd: execute hrtimer callback in softirq context
Date: Wed,  4 Sep 2024 03:30:51 +0200
Message-Id: <20240904013051.4409-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@gmail.com>

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

---

No difference to v1 except a few more tags.
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
2.25.1


