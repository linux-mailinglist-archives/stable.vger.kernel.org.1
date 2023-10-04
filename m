Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E267B880C
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243952AbjJDSMU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243974AbjJDSMU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:12:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E96F1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:12:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D102C433C9;
        Wed,  4 Oct 2023 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443132;
        bh=vyPEplgyJ3iyPCH57LYY8JzaYZ0D66lgKKYFQyW1gkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2nFBiJA6H0verAPQY4yevtYV7ACpmqommm7wPrZhLzUFU3R4iRkt5PZ5tQg37oYo
         ZYOTw/2WCQwb7nF4hdvLphiEUuTN/3/x5Yd9/SVRoi8cJkl/U4q/5TX7ZopI3/IUhC
         5F6CENqcQfwvgaY61mCLlgOK5kpHiINrH6Aj525o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shinas Rasheed <srasheed@marvell.com>,
        Simon Horman <horms@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 048/259] octeon_ep: fix tx dma unmap len values in SG
Date:   Wed,  4 Oct 2023 19:53:41 +0200
Message-ID: <20231004175219.646234949@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shinas Rasheed <srasheed@marvell.com>

[ Upstream commit 350db8a59eb392bf42e62b6b2a37d56b5833012b ]

Lengths of SG pointers are kept in the following order in
the SG entries in hardware.
 63      48|47     32|31     16|15       0
 -----------------------------------------
 |  Len 0  |  Len 1  |  Len 2  |  Len 3  |
 -----------------------------------------
 |                Ptr 0                  |
 -----------------------------------------
 |                Ptr 1                  |
 -----------------------------------------
 |                Ptr 2                  |
 -----------------------------------------
 |                Ptr 3                  |
 -----------------------------------------
Dma pointers have to be unmapped based on their
respective lengths given in this format.

Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeon_ep/octep_main.c  |  8 ++++----
 .../net/ethernet/marvell/octeon_ep/octep_tx.c    |  8 ++++----
 .../net/ethernet/marvell/octeon_ep/octep_tx.h    | 16 +++++++++++++++-
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index d4ec46d1c8cfb..61354f7985035 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -726,13 +726,13 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
 dma_map_sg_err:
 	if (si > 0) {
 		dma_unmap_single(iq->dev, sglist[0].dma_ptr[0],
-				 sglist[0].len[0], DMA_TO_DEVICE);
-		sglist[0].len[0] = 0;
+				 sglist[0].len[3], DMA_TO_DEVICE);
+		sglist[0].len[3] = 0;
 	}
 	while (si > 1) {
 		dma_unmap_page(iq->dev, sglist[si >> 2].dma_ptr[si & 3],
-			       sglist[si >> 2].len[si & 3], DMA_TO_DEVICE);
-		sglist[si >> 2].len[si & 3] = 0;
+			       sglist[si >> 2].len[3 - (si & 3)], DMA_TO_DEVICE);
+		sglist[si >> 2].len[3 - (si & 3)] = 0;
 		si--;
 	}
 	tx_buffer->gather = 0;
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
index 5a520d37bea02..d0adb82d65c31 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
@@ -69,12 +69,12 @@ int octep_iq_process_completions(struct octep_iq *iq, u16 budget)
 		compl_sg++;
 
 		dma_unmap_single(iq->dev, tx_buffer->sglist[0].dma_ptr[0],
-				 tx_buffer->sglist[0].len[0], DMA_TO_DEVICE);
+				 tx_buffer->sglist[0].len[3], DMA_TO_DEVICE);
 
 		i = 1; /* entry 0 is main skb, unmapped above */
 		while (frags--) {
 			dma_unmap_page(iq->dev, tx_buffer->sglist[i >> 2].dma_ptr[i & 3],
-				       tx_buffer->sglist[i >> 2].len[i & 3], DMA_TO_DEVICE);
+				       tx_buffer->sglist[i >> 2].len[3 - (i & 3)], DMA_TO_DEVICE);
 			i++;
 		}
 
@@ -131,13 +131,13 @@ static void octep_iq_free_pending(struct octep_iq *iq)
 
 		dma_unmap_single(iq->dev,
 				 tx_buffer->sglist[0].dma_ptr[0],
-				 tx_buffer->sglist[0].len[0],
+				 tx_buffer->sglist[0].len[3],
 				 DMA_TO_DEVICE);
 
 		i = 1; /* entry 0 is main skb, unmapped above */
 		while (frags--) {
 			dma_unmap_page(iq->dev, tx_buffer->sglist[i >> 2].dma_ptr[i & 3],
-				       tx_buffer->sglist[i >> 2].len[i & 3], DMA_TO_DEVICE);
+				       tx_buffer->sglist[i >> 2].len[3 - (i & 3)], DMA_TO_DEVICE);
 			i++;
 		}
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
index 2ef57980eb47b..21e75ff9f5e71 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.h
@@ -17,7 +17,21 @@
 #define TX_BUFTYPE_NET_SG        2
 #define NUM_TX_BUFTYPES          3
 
-/* Hardware format for Scatter/Gather list */
+/* Hardware format for Scatter/Gather list
+ *
+ * 63      48|47     32|31     16|15       0
+ * -----------------------------------------
+ * |  Len 0  |  Len 1  |  Len 2  |  Len 3  |
+ * -----------------------------------------
+ * |                Ptr 0                  |
+ * -----------------------------------------
+ * |                Ptr 1                  |
+ * -----------------------------------------
+ * |                Ptr 2                  |
+ * -----------------------------------------
+ * |                Ptr 3                  |
+ * -----------------------------------------
+ */
 struct octep_tx_sglist_desc {
 	u16 len[4];
 	dma_addr_t dma_ptr[4];
-- 
2.40.1



