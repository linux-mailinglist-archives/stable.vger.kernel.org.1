Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62347D3104
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjJWLEe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjJWLEd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:04:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6909B10C0
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:04:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA350C433C9;
        Mon, 23 Oct 2023 11:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059071;
        bh=C3YOnnqnLG0pHxvz6N8Hr5knuMuj+duSu3ZGDjRP+00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDTCrF2WdswhCtZb4nrWiHZss+TiFFJguI2a/u0pFfBkgN68qJYAT26i4S4c/kHql
         wR8RKKh3dPtip/+DMkgFohCWLYDGRXqbXz7Gw3+PrQioWEHG2vDaOIwx0vl1rcYota
         3ak7xVMwAdE6/4m5zCaMGUCPmVdcpHCVoX5tfZR8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
        Manish Chopra <manishc@marvell.com>
Subject: [PATCH 6.5 053/241] qed: fix LL2 RX buffer allocation
Date:   Mon, 23 Oct 2023 12:53:59 +0200
Message-ID: <20231023104835.201321107@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manish Chopra <manishc@marvell.com>

commit 2f3389c73832ad90b63208c0fc281ad080114c7a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_ll2.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -113,7 +113,10 @@ static void qed_ll2b_complete_tx_packet(
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
@@ -2589,7 +2592,7 @@ static int qed_ll2_start(struct qed_dev
 	INIT_LIST_HEAD(&cdev->ll2->list);
 	spin_lock_init(&cdev->ll2->lock);
 
-	cdev->ll2->rx_size = NET_SKB_PAD + ETH_HLEN +
+	cdev->ll2->rx_size = PRM_DMA_PAD_BYTES_NUM + ETH_HLEN +
 			     L1_CACHE_BYTES + params->mtu;
 
 	/* Allocate memory for LL2.


