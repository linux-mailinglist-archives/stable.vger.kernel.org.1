Return-Path: <stable+bounces-169398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBFAB24B29
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 15:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC39567008
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4F12EB5CD;
	Wed, 13 Aug 2025 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5Vo9BYe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3572ED159
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092976; cv=none; b=jQeAbT+2pHYv/Eak44QgEyv758FbtkAeJ2JhiPq/6Hj470IK5pdOH1eqwE2khP/poPjdMIuTA3MO83eHHWpPTTCRWBMTgHO8Um8mBU3/rBgKF0hANeA6L3AmALcCW234vzP6TLzEtFceOaYNCXetNh2ILv636d5rOY3fBUiDFfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092976; c=relaxed/simple;
	bh=j+9gjRNLR/A6RtIPYTYKsARAx+3bl2FoKC/cPIyIR6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nTeR7Z9SaGoxaHdIBs+3VGs9PAZkGUzxVWPkjRheY+P/1tAHDmmfKt0mKbjtE6DgdysuQ0/0B0CK8Z4UE6nQeCyTgzt5HE99BUL4h/ue0ctF+uFH7fCEbJWTUaeXGG5YZf6KysLQs/S6LJtI3tmmmkiLtJIF6gO7Z3hIS1hbFX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5Vo9BYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37066C4CEEB;
	Wed, 13 Aug 2025 13:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755092975;
	bh=j+9gjRNLR/A6RtIPYTYKsARAx+3bl2FoKC/cPIyIR6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q5Vo9BYePuqZJEW7qb7hhgUApdipJj3CRE1RX9goCLeVkuxY+8uB84J7tJVjBHXGo
	 VSE+Pnzz4gPMFrd2+Gn0JAo/7GAvC/H10fbQH1xMiGwgTbTCHCG5Mn1jKMGxUP3Yhy
	 zRxyFNsUi6CKKXAjfJSPDAQy91lyUwhNkRh3vmq08numj9fuS44WfXBBnAx647TSWf
	 s0KIiW4X5eXVk9MVwy3/Ynjv7rj2dAPaYM5WqSfIk6+YtfMb52JVbDDk6JoF331I8H
	 NkH2R//BLI5B4I4gZ7tlGqXoQkE3IivEcOi/kc4BScI6Q/NV3xP07y3KPyXendJOWy
	 It11rRYznNpyA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Ernberg <john.ernberg@actia.se>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] net: usbnet: Avoid potential RCU stall on LINK_CHANGE event
Date: Wed, 13 Aug 2025 09:49:32 -0400
Message-Id: <20250813134932.2037778-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025081259-headset-swinger-4805@gregkh>
References: <2025081259-headset-swinger-4805@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Ernberg <john.ernberg@actia.se>

[ Upstream commit 0d9cfc9b8cb17dbc29a98792d36ec39a1cf1395f ]

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
[ adjust context in header ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/usbnet.c   | 11 ++++++++---
 include/linux/usb/usbnet.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 1e8f395c8639..2957e3a0080c 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1106,6 +1106,9 @@ static void __handle_link_change(struct usbnet *dev)
 		 * tx queue is stopped by netcore after link becomes off
 		 */
 	} else {
+		if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
+			netif_carrier_on(dev->net);
+
 		/* submitting URBs for reading packets */
 		tasklet_schedule(&dev->bh);
 	}
@@ -1978,10 +1981,12 @@ EXPORT_SYMBOL(usbnet_manage_power);
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
index fc6ed1311589..83ca77818822 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -83,6 +83,7 @@ struct usbnet {
 #		define EVENT_LINK_CHANGE	11
 #		define EVENT_SET_RX_MODE	12
 #		define EVENT_NO_IP_ALIGN	13
+#		define EVENT_LINK_CARRIER_ON	14
 	u32			rx_speed;	/* in bps - NOT Mbps */
 	u32			tx_speed;	/* in bps - NOT Mbps */
 };
-- 
2.39.5


