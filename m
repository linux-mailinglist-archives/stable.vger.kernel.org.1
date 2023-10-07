Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A6D7BC78A
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 14:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343972AbjJGMdD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 08:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343995AbjJGMdC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 08:33:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ABCBC
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 05:33:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCBEC433C9;
        Sat,  7 Oct 2023 12:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696681980;
        bh=qMHsF44Q5fluIvn5Yqo1HFOVqvGJ6sgp2r+jdo3zaFE=;
        h=Subject:To:Cc:From:Date:From;
        b=SfFls6ILbrEI2LTeK4fDPkPfBgtV7pacD8Va3EOd3oiFy7B6tyTH24Pz11rEZtgl5
         OJEPKMCshO8057ykG0a+fWaw5rxXZ/w5RG6g5mQMD4hWOIBGR4xuXQJTxJdPr0tErc
         ibKbPZtEXUM4yfXWNpLjQSb2bcFNaWd+IO6gNRhI=
Subject: FAILED: patch "[PATCH] net: stmmac: remove unneeded stmmac_poll_controller" failed to apply to 6.5-stable tree
To:     repk@triplefau.lt, horms@kernel.org, kuba@kernel.org,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 07 Oct 2023 14:32:55 +0200
Message-ID: <2023100755-strenuous-friday-268e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 3eef8555891026628aa1cc6dbc01db86df88aa26
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100755-strenuous-friday-268e@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:

3eef85558910 ("net: stmmac: remove unneeded stmmac_poll_controller")
956c3f09b9c4 ("net: stmmac: replace the multi_msi_en field with a flag")
fc02152bdbb2 ("net: stmmac: replace the vlan_fail_q_en field with a flag")
efe92571bfc3 ("net: stmmac: replace the serdes_up_after_phy_linkup field with a flag")
68861a3bcc1c ("net: stmmac: replace the tso_en field with a flag")
d8daff284e30 ("net: stmmac: replace the has_sun8i field with a flag")
fd1d62d80ebc ("net: stmmac: replace the use_phy_wol field with a flag")
309efe6eb499 ("net: stmmac: replace the sph_disable field with a flag")
d26979f1cef7 ("net: stmmac: replace the has_integrated_pcs field with a flag")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3eef8555891026628aa1cc6dbc01db86df88aa26 Mon Sep 17 00:00:00 2001
From: Remi Pommarel <repk@triplefau.lt>
Date: Wed, 4 Oct 2023 16:33:56 +0200
Subject: [PATCH] net: stmmac: remove unneeded stmmac_poll_controller

Using netconsole netpoll_poll_dev could be called from interrupt
context, thus using disable_irq() would cause the following kernel
warning with CONFIG_DEBUG_ATOMIC_SLEEP enabled:

  BUG: sleeping function called from invalid context at kernel/irq/manage.c:137
  in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 10, name: ksoftirqd/0
  CPU: 0 PID: 10 Comm: ksoftirqd/0 Tainted: G        W         5.15.42-00075-g816b502b2298-dirty #117
  Hardware name: aml (r1) (DT)
  Call trace:
   dump_backtrace+0x0/0x270
   show_stack+0x14/0x20
   dump_stack_lvl+0x8c/0xac
   dump_stack+0x18/0x30
   ___might_sleep+0x150/0x194
   __might_sleep+0x64/0xbc
   synchronize_irq+0x8c/0x150
   disable_irq+0x2c/0x40
   stmmac_poll_controller+0x140/0x1a0
   netpoll_poll_dev+0x6c/0x220
   netpoll_send_skb+0x308/0x390
   netpoll_send_udp+0x418/0x760
   write_msg+0x118/0x140 [netconsole]
   console_unlock+0x404/0x500
   vprintk_emit+0x118/0x250
   dev_vprintk_emit+0x19c/0x1cc
   dev_printk_emit+0x90/0xa8
   __dev_printk+0x78/0x9c
   _dev_warn+0xa4/0xbc
   ath10k_warn+0xe8/0xf0 [ath10k_core]
   ath10k_htt_txrx_compl_task+0x790/0x7fc [ath10k_core]
   ath10k_pci_napi_poll+0x98/0x1f4 [ath10k_pci]
   __napi_poll+0x58/0x1f4
   net_rx_action+0x504/0x590
   _stext+0x1b8/0x418
   run_ksoftirqd+0x74/0xa4
   smpboot_thread_fn+0x210/0x3c0
   kthread+0x1fc/0x210
   ret_from_fork+0x10/0x20

Since [0] .ndo_poll_controller is only needed if driver doesn't or
partially use NAPI. Because stmmac does so, stmmac_poll_controller
can be removed fixing the above warning.

[0] commit ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")

Cc: <stable@vger.kernel.org> # 5.15.x
Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/1c156a6d8c9170bd6a17825f2277115525b4d50f.1696429960.git.repk@triplefau.lt
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 83c567a89a46..ed1a5a31a491 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6002,33 +6002,6 @@ static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-/* Polling receive - used by NETCONSOLE and other diagnostic tools
- * to allow network I/O with interrupts disabled.
- */
-static void stmmac_poll_controller(struct net_device *dev)
-{
-	struct stmmac_priv *priv = netdev_priv(dev);
-	int i;
-
-	/* If adapter is down, do nothing */
-	if (test_bit(STMMAC_DOWN, &priv->state))
-		return;
-
-	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN) {
-		for (i = 0; i < priv->plat->rx_queues_to_use; i++)
-			stmmac_msi_intr_rx(0, &priv->dma_conf.rx_queue[i]);
-
-		for (i = 0; i < priv->plat->tx_queues_to_use; i++)
-			stmmac_msi_intr_tx(0, &priv->dma_conf.tx_queue[i]);
-	} else {
-		disable_irq(dev->irq);
-		stmmac_interrupt(dev->irq, dev);
-		enable_irq(dev->irq);
-	}
-}
-#endif
-
 /**
  *  stmmac_ioctl - Entry point for the Ioctl
  *  @dev: Device pointer.
@@ -6989,9 +6962,6 @@ static const struct net_device_ops stmmac_netdev_ops = {
 	.ndo_get_stats64 = stmmac_get_stats64,
 	.ndo_setup_tc = stmmac_setup_tc,
 	.ndo_select_queue = stmmac_select_queue,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller = stmmac_poll_controller,
-#endif
 	.ndo_set_mac_address = stmmac_set_mac_address,
 	.ndo_vlan_rx_add_vid = stmmac_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = stmmac_vlan_rx_kill_vid,

