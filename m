Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76405726E2F
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjFGUs4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjFGUsc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:48:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7912717
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B2216468F
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F903C4339B;
        Wed,  7 Jun 2023 20:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170895;
        bh=nM5ePi1h+JRSvaC293yImKZ2ZI0prd4ezlOA/cVnu+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XgHK10gThecVfn3JMHD4JUxxf3yyJ3+rAXGoof9swvMa1MQk6RSRmWn7gnYNOZBNZ
         l0X+3Jm1mxIX9hpV4Vrc9wt0ZcvlENAySNLHQQpaEM6OvwgHAU1nh2V76pfdrrudVO
         OljZZk8vWGXPgER/BpirJt8M0Pnw8D2SYbsjnE80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 006/120] dmaengine: at_xdmac: Move the free desc to the tail of the desc list
Date:   Wed,  7 Jun 2023 22:15:22 +0200
Message-ID: <20230607200901.120378020@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

[ Upstream commit 801db90bf294f647b967e8d99b9ae121bea63d0d ]

Move the free desc to the tail of the list, so that the sequence of
descriptors is more track-able in case of debug. One would know which
descriptor should come next and could easier catch concurrency over
descriptors for example. virt-dma uses list_splice_tail_init() as well,
follow the core driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Link: https://lore.kernel.org/r/20211215110115.191749-7-tudor.ambarus@microchip.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 4d43acb145c3 ("dmaengine: at_xdmac: fix potential Oops in at_xdmac_prep_interleaved()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/at_xdmac.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 8af1c0fd3a736..96559c5df944d 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -678,7 +678,8 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		if (!desc) {
 			dev_err(chan2dev(chan), "can't get descriptor\n");
 			if (first)
-				list_splice_init(&first->descs_list, &atchan->free_descs_list);
+				list_splice_tail_init(&first->descs_list,
+						      &atchan->free_descs_list);
 			goto spin_unlock;
 		}
 
@@ -766,7 +767,8 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 		if (!desc) {
 			dev_err(chan2dev(chan), "can't get descriptor\n");
 			if (first)
-				list_splice_init(&first->descs_list, &atchan->free_descs_list);
+				list_splice_tail_init(&first->descs_list,
+						      &atchan->free_descs_list);
 			spin_unlock_irqrestore(&atchan->lock, irqflags);
 			return NULL;
 		}
@@ -998,8 +1000,8 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 							       src_addr, dst_addr,
 							       xt, chunk);
 			if (!desc) {
-				list_splice_init(&first->descs_list,
-						 &atchan->free_descs_list);
+				list_splice_tail_init(&first->descs_list,
+						      &atchan->free_descs_list);
 				return NULL;
 			}
 
@@ -1077,7 +1079,8 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		if (!desc) {
 			dev_err(chan2dev(chan), "can't get descriptor\n");
 			if (first)
-				list_splice_init(&first->descs_list, &atchan->free_descs_list);
+				list_splice_tail_init(&first->descs_list,
+						      &atchan->free_descs_list);
 			return NULL;
 		}
 
@@ -1251,8 +1254,8 @@ at_xdmac_prep_dma_memset_sg(struct dma_chan *chan, struct scatterlist *sgl,
 						   sg_dma_len(sg),
 						   value);
 		if (!desc && first)
-			list_splice_init(&first->descs_list,
-					 &atchan->free_descs_list);
+			list_splice_tail_init(&first->descs_list,
+					      &atchan->free_descs_list);
 
 		if (!first)
 			first = desc;
@@ -1649,7 +1652,8 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 
 		spin_lock_irq(&atchan->lock);
 		/* Move the xfer descriptors into the free descriptors list. */
-		list_splice_init(&desc->descs_list, &atchan->free_descs_list);
+		list_splice_tail_init(&desc->descs_list,
+				      &atchan->free_descs_list);
 		at_xdmac_advance_work(atchan);
 		spin_unlock_irq(&atchan->lock);
 	}
@@ -1798,7 +1802,8 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
 	/* Cancel all pending transfers. */
 	list_for_each_entry_safe(desc, _desc, &atchan->xfers_list, xfer_node) {
 		list_del(&desc->xfer_node);
-		list_splice_init(&desc->descs_list, &atchan->free_descs_list);
+		list_splice_tail_init(&desc->descs_list,
+				      &atchan->free_descs_list);
 	}
 
 	clear_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
-- 
2.39.2



