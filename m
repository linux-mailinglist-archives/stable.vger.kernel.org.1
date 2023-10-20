Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DCA7D156A
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 20:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjJTSGB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 14:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjJTSF7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 14:05:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1034D5D
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 11:05:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE757C433C7;
        Fri, 20 Oct 2023 18:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697825156;
        bh=T/B8E1TJ1x6Jl7teX39cUEp7FTvpOBivKgJZDB6SX00=;
        h=Subject:To:Cc:From:Date:From;
        b=c5KdB4ytamcr1VFpboFsifDBXmAdTPnHirrsl+kpoHJ/a7q9atGRgioy322deNob+
         v6sD3tDdKxM2sgahnmODwuEm6NsFY/MVD/ydjeqYTBu/wVjslbIC7FV5JIGR4iytl4
         s+rp4MvuqdbUWD/1cE9dZBam+7/FgpxL9jSMQ+XU=
Subject: FAILED: patch "[PATCH] qed: fix LL2 RX buffer allocation" failed to apply to 4.14-stable tree
To:     manishc@marvell.com, davem@davemloft.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 20:04:30 +0200
Message-ID: <2023102030-strict-cake-e8e2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
git cherry-pick -x 2f3389c73832ad90b63208c0fc281ad080114c7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102030-strict-cake-e8e2@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2f3389c73832ad90b63208c0fc281ad080114c7a Mon Sep 17 00:00:00 2001
From: Manish Chopra <manishc@marvell.com>
Date: Fri, 13 Oct 2023 18:48:12 +0530
Subject: [PATCH] qed: fix LL2 RX buffer allocation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Driver allocates the LL2 rx buffers from kmalloc()
area to construct the skb using slab_build_skb()

The required size allocation seems to have overlooked
for accounting both skb_shared_info size and device
placement padding bytes which results into the below
panic when doing skb_put() for a standard MTU sized frame.

skbuff: skb_over_panic: text:ffffffffc0b0225f len:1514 put:1514
head:ff3dabceaf39c000 data:ff3dabceaf39c042 tail:0x62c end:0x566
dev:<NULL>
…
skb_panic+0x48/0x4a
skb_put.cold+0x10/0x10
qed_ll2b_complete_rx_packet+0x14f/0x260 [qed]
qed_ll2_rxq_handle_completion.constprop.0+0x169/0x200 [qed]
qed_ll2_rxq_completion+0xba/0x320 [qed]
qed_int_sp_dpc+0x1a7/0x1e0 [qed]

This patch fixes this by accouting skb_shared_info and device
placement padding size bytes when allocating the buffers.

Cc: David S. Miller <davem@davemloft.net>
Fixes: 0a7fb11c23c0 ("qed: Add Light L2 support")
Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index 717a0b3f89bd..ab5ef254a748 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -113,7 +113,10 @@ static void qed_ll2b_complete_tx_packet(void *cxt,
 static int qed_ll2_alloc_buffer(struct qed_dev *cdev,
 				u8 **data, dma_addr_t *phys_addr)
 {
-	*data = kmalloc(cdev->ll2->rx_size, GFP_ATOMIC);
+	size_t size = cdev->ll2->rx_size + NET_SKB_PAD +
+		      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	*data = kmalloc(size, GFP_ATOMIC);
 	if (!(*data)) {
 		DP_INFO(cdev, "Failed to allocate LL2 buffer data\n");
 		return -ENOMEM;
@@ -2589,7 +2592,7 @@ static int qed_ll2_start(struct qed_dev *cdev, struct qed_ll2_params *params)
 	INIT_LIST_HEAD(&cdev->ll2->list);
 	spin_lock_init(&cdev->ll2->lock);
 
-	cdev->ll2->rx_size = NET_SKB_PAD + ETH_HLEN +
+	cdev->ll2->rx_size = PRM_DMA_PAD_BYTES_NUM + ETH_HLEN +
 			     L1_CACHE_BYTES + params->mtu;
 
 	/* Allocate memory for LL2.

