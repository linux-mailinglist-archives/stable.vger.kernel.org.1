Return-Path: <stable+bounces-168743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD9CB23673
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DCB3B905C
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2E92FF164;
	Tue, 12 Aug 2025 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EuvZ5QVp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8D02C21E3;
	Tue, 12 Aug 2025 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025189; cv=none; b=GJI+xzfNApefZ52Q/mztVctOeUZGqSOEU5Mg3W3Zah8aW/1+3BzrUZbVwxsFGbCPVY/2h4kuvZoFQMRWNzQEdCHlgTrKYe3OzD6NRCNqq2+HCqIu/av6vsMd1tQ1Eu14Quk8ZVLkyeT9V2tr89OvmeMtJdnVAIj66sfmTzPt+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025189; c=relaxed/simple;
	bh=d8OvN96MGMqY1G7z8+P5KunEfdcTw/hRrwS1Oh49awE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y97Ji41ps8iKxkaqTxZlWPyuXJXAmCsTzsH8XLY+tEpsfa62uVSnxSTACjWXB1pZuwl2rMbeZizaygFso46Om3crey9erWkC+q1B1GiHrpJEShvUdaWm9mXK3qCJe6ADB8Zo3MhA/h5hCiieLoWp8paLCq0AfyMGfhilx3tS/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EuvZ5QVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B01C4CEF0;
	Tue, 12 Aug 2025 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025189;
	bh=d8OvN96MGMqY1G7z8+P5KunEfdcTw/hRrwS1Oh49awE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EuvZ5QVpfYb31PW5rCLos+eVCPG+Y/3nlv/PzGdVH77Ulj9gA2kGQA0iaKWLOyJ8D
	 FIq55pcsfWw60HN/iT6H1PlGr1f6s4oL7PAW8IEnp+CufD2zzLXzYOfEKSE+/7wEaD
	 Rydn7lNCl3W/f1hSFBa4MdGXXYRpDeDKQ0ps0BVg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Ernberg <john.ernberg@actia.se>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.16 594/627] net: usbnet: Avoid potential RCU stall on LINK_CHANGE event
Date: Tue, 12 Aug 2025 19:34:49 +0200
Message-ID: <20250812173454.462827923@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Ernberg <john.ernberg@actia.se>

commit 0d9cfc9b8cb17dbc29a98792d36ec39a1cf1395f upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/usbnet.c   |   11 ++++++++---
 include/linux/usb/usbnet.h |    1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1122,6 +1122,9 @@ static void __handle_link_change(struct
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



