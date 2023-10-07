Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF237BC764
	for <lists+stable@lfdr.de>; Sat,  7 Oct 2023 14:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343680AbjJGMDx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 7 Oct 2023 08:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343899AbjJGMDx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Oct 2023 08:03:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5473B9
        for <stable@vger.kernel.org>; Sat,  7 Oct 2023 05:03:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EE6C433C7;
        Sat,  7 Oct 2023 12:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696680231;
        bh=8rRIsU8Mzz7MI627cDt3R3MJdYL2zfknzfjmOxtxodA=;
        h=Subject:To:Cc:From:Date:From;
        b=bgZQROOMpEfZltolwxGYYSUhBlJl7+NmMDV5pB498scR5M64czsCwD7Kfq1sAXtYI
         RZJmxNHPscD81J/VVimDJatHSVVbdNylq2yLR1/EpcyryXUJQRgZGq/fGgOH01oW+I
         qEE2jDxKSk79MsCS583gqHKpzHJYeED21MiY+T4A=
Subject: FAILED: patch "[PATCH] net: ethernet: mediatek: disable irq before schedule napi" failed to apply to 4.14-stable tree
To:     ansuelsmth@gmail.com, pabeni@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 07 Oct 2023 14:03:40 +0200
Message-ID: <2023100740-activism-switch-30a3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x fcdfc462881d8acf9db77f483b2c821e286ca97b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100740-activism-switch-30a3@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

fcdfc462881d ("net: ethernet: mediatek: disable irq before schedule napi")
160d3a9b1929 ("net: ethernet: mtk_eth_soc: introduce MTK_NETSYS_V2 support")
8cb42714cdc1 ("net: ethernet: mtk_eth_soc: introduce device register map")
72e27d3718ba ("net: ethernet: mtk_eth_soc: rely on rxd_size field in mtk_rx_alloc/mtk_rx_clean")
670ff7dabbb0 ("net: ethernet: mtk_eth_soc: add rxd_size to mtk_soc_data")
0e05744beda4 ("net: ethernet: mtk_eth_soc: rely on txd_size in mtk_tx_alloc/mtk_tx_clean")
eb067347aa87 ("net: ethernet: mtk_eth_soc: add txd_size to mtk_soc_data")
731f3fd6bc87 ("net: ethernet: mtk_eth_soc: move tx dma desc configuration in mtk_tx_set_dma_desc")
62dfb4cc4446 ("net: ethernet: mtk_eth_soc: rely on GFP_KERNEL for dma_alloc_coherent whenever possible")
c4f033d9e03e ("net: ethernet: mtk_eth_soc: rework hardware flow table management")
1ccc723b5829 ("net: ethernet: mtk_eth_soc: allocate struct mtk_ppe separately")
a333215e10cb ("net: ethernet: mtk_eth_soc: implement flow offloading to WED devices")
804775dfc288 ("net: ethernet: mtk_eth_soc: add support for Wireless Ethernet Dispatch (WED)")
d776a57e4a28 ("net: ethernet: mtk_eth_soc: add support for coherent DMA")
ad79fd2c42f7 ("net: ethernet: mtk_eth_soc: Fix packet statistics support for MT7628/88")
430bfe057612 ("net: ethernet: mtk_eth_soc: Fix DIM support for MT7628/88")
3bc8e0aff23b ("net: ethernet: mtk_eth_soc: use iopoll.h macro for DMA init")
fa817272c37e ("net: ethernet: mtk_eth_soc: set PPE flow hash as skb hash if present")
db2c7b353db3 ("net: ethernet: mtk_eth_soc: rework NAPI callbacks")
16769a8923fa ("net: ethernet: mtk_eth_soc: reduce unnecessary interrupts")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fcdfc462881d8acf9db77f483b2c821e286ca97b Mon Sep 17 00:00:00 2001
From: Christian Marangi <ansuelsmth@gmail.com>
Date: Mon, 2 Oct 2023 16:08:05 +0200
Subject: [PATCH] net: ethernet: mediatek: disable irq before schedule napi

While searching for possible refactor of napi_schedule_prep and
__napi_schedule it was notice that the mtk eth driver disable the
interrupt for rx and tx AFTER napi is scheduled.

While this is a very hard to repro case it might happen to have
situation where the interrupt is disabled and never enabled again as the
napi completes and the interrupt is enabled before.

This is caused by the fact that a napi driven by interrupt expect a
logic with:
1. interrupt received. napi prepared -> interrupt disabled -> napi
   scheduled
2. napi triggered. ring cleared -> interrupt enabled -> wait for new
   interrupt

To prevent this case, disable the interrupt BEFORE the napi is
scheduled.

Fixes: 656e705243fd ("net-next: mediatek: add support for MT7623 ethernet")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Link: https://lore.kernel.org/r/20231002140805.568-1-ansuelsmth@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 3cffd1bd3067..20afe79f380a 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3171,8 +3171,8 @@ static irqreturn_t mtk_handle_irq_rx(int irq, void *_eth)
 
 	eth->rx_events++;
 	if (likely(napi_schedule_prep(&eth->rx_napi))) {
-		__napi_schedule(&eth->rx_napi);
 		mtk_rx_irq_disable(eth, eth->soc->txrx.rx_irq_done_mask);
+		__napi_schedule(&eth->rx_napi);
 	}
 
 	return IRQ_HANDLED;
@@ -3184,8 +3184,8 @@ static irqreturn_t mtk_handle_irq_tx(int irq, void *_eth)
 
 	eth->tx_events++;
 	if (likely(napi_schedule_prep(&eth->tx_napi))) {
-		__napi_schedule(&eth->tx_napi);
 		mtk_tx_irq_disable(eth, MTK_TX_DONE_INT);
+		__napi_schedule(&eth->tx_napi);
 	}
 
 	return IRQ_HANDLED;

