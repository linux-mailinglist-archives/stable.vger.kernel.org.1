Return-Path: <stable+bounces-167169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC53B22B91
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52C462A6F05
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF382ED86F;
	Tue, 12 Aug 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MJPIlTsO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B332C85
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012129; cv=none; b=CyAjmr+9JHikfeNm2WgnJSbSldaxqpAfr8u7i9QEYgDArDgeyzRFhFimPyF37zI0nG6YkWFrNMV68VqweRjlJAamOm/4R3Hw7MQY9fAfWKwQkjuAAaImTpTuOosvLp2inwN0JNRzPxZZkX+j15wtNkW/ugW+beodWgh53js00HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012129; c=relaxed/simple;
	bh=q5LfXF/L0ToE8HBkFgkpXWrVH1wJZho7BoAHGrINNls=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WSVMF90E7PPhyywFz7Q7ms5eALwRkN/9ax6ZYPQ3NlWljPwsQgLhYCtWxLdyZTgqbqHgq3TNy0x9gGQdUK+N8a5Chb8mXT3a56Cndinidu/ABLVfadAWLW6N0tzb2ZlC5Mw54rKjlYpnNqMPgRwshjwh58MRK8RLuJg7BYcwa04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MJPIlTsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428ACC4CEF0;
	Tue, 12 Aug 2025 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755012128;
	bh=q5LfXF/L0ToE8HBkFgkpXWrVH1wJZho7BoAHGrINNls=;
	h=Subject:To:Cc:From:Date:From;
	b=MJPIlTsO7CF7aO2HR7e/b+pmp9+vUoGwk5OSspn7dZZe4lDIq22GvCkcm4DrO1GDg
	 a7KEIM5CK8dkZrfb8Tcq18czBKkg9IKrjMaVH/l0r3K1mbcl6+bKlOEik5DXA1vaGZ
	 5iszA4DhIRnZ8yzDc6sw7fDVAPLlCxu0em78rHKw=
Subject: FAILED: patch "[PATCH] net: usbnet: Avoid potential RCU stall on LINK_CHANGE event" failed to apply to 5.4-stable tree
To: john.ernberg@actia.se,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 17:21:59 +0200
Message-ID: <2025081259-headset-swinger-4805@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 0d9cfc9b8cb17dbc29a98792d36ec39a1cf1395f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081259-headset-swinger-4805@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0d9cfc9b8cb17dbc29a98792d36ec39a1cf1395f Mon Sep 17 00:00:00 2001
From: John Ernberg <john.ernberg@actia.se>
Date: Wed, 23 Jul 2025 10:25:35 +0000
Subject: [PATCH] net: usbnet: Avoid potential RCU stall on LINK_CHANGE event

The Gemalto Cinterion PLS83-W modem (cdc_ether) is emitting confusing link
up and down events when the WWAN interface is activated on the modem-side.

Interrupt URBs will in consecutive polls grab:
* Link Connected
* Link Disconnected
* Link Connected

Where the last Connected is then a stable link state.

When the system is under load this may cause the unlink_urbs() work in
__handle_link_change() to not complete before the next usbnet_link_change()
call turns the carrier on again, allowing rx_submit() to queue new SKBs.

In that event the URB queue is filled faster than it can drain, ending up
in a RCU stall:

    rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 0-.... } 33108 jiffies s: 201 root: 0x1/.
    rcu: blocking rcu_node structures (internal RCU debug):
    Sending NMI from CPU 1 to CPUs 0:
    NMI backtrace for cpu 0

    Call trace:
     arch_local_irq_enable+0x4/0x8
     local_bh_enable+0x18/0x20
     __netdev_alloc_skb+0x18c/0x1cc
     rx_submit+0x68/0x1f8 [usbnet]
     rx_alloc_submit+0x4c/0x74 [usbnet]
     usbnet_bh+0x1d8/0x218 [usbnet]
     usbnet_bh_tasklet+0x10/0x18 [usbnet]
     tasklet_action_common+0xa8/0x110
     tasklet_action+0x2c/0x34
     handle_softirqs+0x2cc/0x3a0
     __do_softirq+0x10/0x18
     ____do_softirq+0xc/0x14
     call_on_irq_stack+0x24/0x34
     do_softirq_own_stack+0x18/0x20
     __irq_exit_rcu+0xa8/0xb8
     irq_exit_rcu+0xc/0x30
     el1_interrupt+0x34/0x48
     el1h_64_irq_handler+0x14/0x1c
     el1h_64_irq+0x68/0x6c
     _raw_spin_unlock_irqrestore+0x38/0x48
     xhci_urb_dequeue+0x1ac/0x45c [xhci_hcd]
     unlink1+0xd4/0xdc [usbcore]
     usb_hcd_unlink_urb+0x70/0xb0 [usbcore]
     usb_unlink_urb+0x24/0x44 [usbcore]
     unlink_urbs.constprop.0.isra.0+0x64/0xa8 [usbnet]
     __handle_link_change+0x34/0x70 [usbnet]
     usbnet_deferred_kevent+0x1c0/0x320 [usbnet]
     process_scheduled_works+0x2d0/0x48c
     worker_thread+0x150/0x1dc
     kthread+0xd8/0xe8
     ret_from_fork+0x10/0x20

Get around the problem by delaying the carrier on to the scheduled work.

This needs a new flag to keep track of the necessary action.

The carrier ok check cannot be removed as it remains required for the
LINK_RESET event flow.

Fixes: 4b49f58fff00 ("usbnet: handle link change")
Cc: stable@vger.kernel.org
Signed-off-by: John Ernberg <john.ernberg@actia.se>
Link: https://patch.msgid.link/20250723102526.1305339-1-john.ernberg@actia.se
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index c04e715a4c2a..bc1d8631ffe0 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1122,6 +1122,9 @@ static void __handle_link_change(struct usbnet *dev)
 		 * tx queue is stopped by netcore after link becomes off
 		 */
 	} else {
+		if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
+			netif_carrier_on(dev->net);
+
 		/* submitting URBs for reading packets */
 		tasklet_schedule(&dev->bh);
 	}
@@ -2009,10 +2012,12 @@ EXPORT_SYMBOL(usbnet_manage_power);
 void usbnet_link_change(struct usbnet *dev, bool link, bool need_reset)
 {
 	/* update link after link is reseted */
-	if (link && !need_reset)
-		netif_carrier_on(dev->net);
-	else
+	if (link && !need_reset) {
+		set_bit(EVENT_LINK_CARRIER_ON, &dev->flags);
+	} else {
+		clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags);
 		netif_carrier_off(dev->net);
+	}
 
 	if (need_reset && link)
 		usbnet_defer_kevent(dev, EVENT_LINK_RESET);
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index 0b9f1e598e3a..4bc6bb01a0eb 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -76,6 +76,7 @@ struct usbnet {
 #		define EVENT_LINK_CHANGE	11
 #		define EVENT_SET_RX_MODE	12
 #		define EVENT_NO_IP_ALIGN	13
+#		define EVENT_LINK_CARRIER_ON	14
 /* This one is special, as it indicates that the device is going away
  * there are cyclic dependencies between tasklet, timer and bh
  * that must be broken


