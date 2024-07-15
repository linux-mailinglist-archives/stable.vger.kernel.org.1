Return-Path: <stable+bounces-59286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE2E93109A
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 10:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163C9282D74
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FAF185E43;
	Mon, 15 Jul 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZKvJR3Jc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D26E185613
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033487; cv=none; b=eu1EjROcthIu4Wp1zpIosNgQTcK1Y10T6BWJPnYX9a0ch1wsZVe5pmtTYkk6WnpvcKvnm9SWu1x2ulhnW6NcF4zYwir6QgoBny5mIkPj5OYanFXGYvbogWXsk6x2dSium4wMlYMqBhegPUyrO3sRwnv1lnURVqFUg0uT4w/0Xfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033487; c=relaxed/simple;
	bh=K1s6VDEpNGh1h9pvMmm7GndYgaMN7cf0izqWFplMW/I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Lh9M0fTu3r5CO+IV2IngjIl2vOAH2uMV8Pf9qVm1Va2XpBrc23FmWJa7s2gaoxfHtIJaIwfUORW1CqEGXi4J118TuY4v0SvsR/Bw1vKmM57AZ7klNLs2nrnu+spbsp9E6blkG+aiNOn7TG4wx8dz9C5SoSSjlgioZTzR/ub9erM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZKvJR3Jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5030BC32782;
	Mon, 15 Jul 2024 08:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721033486;
	bh=K1s6VDEpNGh1h9pvMmm7GndYgaMN7cf0izqWFplMW/I=;
	h=Subject:To:Cc:From:Date:From;
	b=ZKvJR3JcEPbgHyl1BdEa/TVTkOyH0GW7OkJJwMjUHEozmOEjd6Z+toYbICBEhx3U/
	 aKSVg8H4h4UFCcBYrup8x09/P+xhrcBFTmaoLR61LTi00Y+hBBwGmA5sej9oOB4YuV
	 ilKLi+1My9jDCvr/UfBlQMiInkmWA7LUZvFZBCAs=
Subject: FAILED: patch "[PATCH] net: ks8851: Fix deadlock with the SPI chip variant" failed to apply to 5.15-stable tree
To: ronald.wahl@raritan.com,davem@davemloft.net,edumazet@google.com,horms@kernel.org,kuba@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 10:51:23 +0200
Message-ID: <2024071523-slate-cobweb-d1a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0913ec336a6c0c4a2b296bd9f74f8e41c4c83c8c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071523-slate-cobweb-d1a8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

0913ec336a6c ("net: ks8851: Fix deadlock with the SPI chip variant")
317a215d4932 ("net: ks8851: Fix another TX stall caused by wrong ISR flag handling")
e0863634bf9f ("net: ks8851: Queue RX packets in IRQ handler instead of disabling BHs")
be0384bf599c ("net: ks8851: Handle softirqs at the end of IRQ thread to fix hang")
f96f700449b6 ("net: ks8851: Inline ks8851_rx_skb()")
3dc5d4454545 ("net: ks8851: Fix TX stall caused by TX buffer overrun")
90f77c1c512f ("net: ethernet: Use netif_rx().")
2dc95a4d30ed ("net: Add dm9051 driver")
47aeea0d57e8 ("net: lan966x: Implement the callback SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED")
2e49761e4fd1 ("net: lan966x: Add support for multiple bridge flags")
e14f72398df4 ("net: lan966x: Extend switchdev bridge flags")
6d2c186afa5d ("net: lan966x: Add vlan support.")
cf2f60897e92 ("net: lan966x: Add support to offload the forwarding.")
5ccd66e01cbe ("net: lan966x: add support for interrupts from analyzer")
2f207cbf0dd4 ("net: vertexcom: Add MSE102x SPI support")
12c2d0a5b8e2 ("net: lan966x: add ethtool configuration and statistics")
e18aba8941b4 ("net: lan966x: add mactable support")
d28d6d2e37d1 ("net: lan966x: add port module support")
db8bcaad5393 ("net: lan966x: add the basic lan966x driver")
a97c69ba4f30 ("net: ax88796c: ASIX AX88796C SPI Ethernet Adapter Driver")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0913ec336a6c0c4a2b296bd9f74f8e41c4c83c8c Mon Sep 17 00:00:00 2001
From: Ronald Wahl <ronald.wahl@raritan.com>
Date: Sat, 6 Jul 2024 12:13:37 +0200
Subject: [PATCH] net: ks8851: Fix deadlock with the SPI chip variant

When SMP is enabled and spinlocks are actually functional then there is
a deadlock with the 'statelock' spinlock between ks8851_start_xmit_spi
and ks8851_irq:

    watchdog: BUG: soft lockup - CPU#0 stuck for 27s!
    call trace:
      queued_spin_lock_slowpath+0x100/0x284
      do_raw_spin_lock+0x34/0x44
      ks8851_start_xmit_spi+0x30/0xb8
      ks8851_start_xmit+0x14/0x20
      netdev_start_xmit+0x40/0x6c
      dev_hard_start_xmit+0x6c/0xbc
      sch_direct_xmit+0xa4/0x22c
      __qdisc_run+0x138/0x3fc
      qdisc_run+0x24/0x3c
      net_tx_action+0xf8/0x130
      handle_softirqs+0x1ac/0x1f0
      __do_softirq+0x14/0x20
      ____do_softirq+0x10/0x1c
      call_on_irq_stack+0x3c/0x58
      do_softirq_own_stack+0x1c/0x28
      __irq_exit_rcu+0x54/0x9c
      irq_exit_rcu+0x10/0x1c
      el1_interrupt+0x38/0x50
      el1h_64_irq_handler+0x18/0x24
      el1h_64_irq+0x64/0x68
      __netif_schedule+0x6c/0x80
      netif_tx_wake_queue+0x38/0x48
      ks8851_irq+0xb8/0x2c8
      irq_thread_fn+0x2c/0x74
      irq_thread+0x10c/0x1b0
      kthread+0xc8/0xd8
      ret_from_fork+0x10/0x20

This issue has not been identified earlier because tests were done on
a device with SMP disabled and so spinlocks were actually NOPs.

Now use spin_(un)lock_bh for TX queue related locking to avoid execution
of softirq work synchronously that would lead to a deadlock.

Fixes: 3dc5d4454545 ("net: ks8851: Fix TX stall caused by TX buffer overrun")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20240706101337.854474-1-rwahl@gmx.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 6453c92f0fa7..13462811eaae 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -352,11 +352,11 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 		netif_dbg(ks, intr, ks->netdev,
 			  "%s: txspace %d\n", __func__, tx_space);
 
-		spin_lock(&ks->statelock);
+		spin_lock_bh(&ks->statelock);
 		ks->tx_space = tx_space;
 		if (netif_queue_stopped(ks->netdev))
 			netif_wake_queue(ks->netdev);
-		spin_unlock(&ks->statelock);
+		spin_unlock_bh(&ks->statelock);
 	}
 
 	if (status & IRQ_SPIBEI) {
@@ -635,14 +635,14 @@ static void ks8851_set_rx_mode(struct net_device *dev)
 
 	/* schedule work to do the actual set of the data if needed */
 
-	spin_lock(&ks->statelock);
+	spin_lock_bh(&ks->statelock);
 
 	if (memcmp(&rxctrl, &ks->rxctrl, sizeof(rxctrl)) != 0) {
 		memcpy(&ks->rxctrl, &rxctrl, sizeof(ks->rxctrl));
 		schedule_work(&ks->rxctrl_work);
 	}
 
-	spin_unlock(&ks->statelock);
+	spin_unlock_bh(&ks->statelock);
 }
 
 static int ks8851_set_mac_address(struct net_device *dev, void *addr)
diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethernet/micrel/ks8851_spi.c
index 670c1de966db..3062cc0f9199 100644
--- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -340,10 +340,10 @@ static void ks8851_tx_work(struct work_struct *work)
 
 	tx_space = ks8851_rdreg16_spi(ks, KS_TXMIR);
 
-	spin_lock(&ks->statelock);
+	spin_lock_bh(&ks->statelock);
 	ks->queued_len -= dequeued_len;
 	ks->tx_space = tx_space;
-	spin_unlock(&ks->statelock);
+	spin_unlock_bh(&ks->statelock);
 
 	ks8851_unlock_spi(ks, &flags);
 }


