Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940A86FAE9D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbjEHLqY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbjEHLqD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:46:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF0F10A0C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1132D63854
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D836EC4339B;
        Mon,  8 May 2023 11:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546346;
        bh=gKIOR95WUef8LKZ/cNkTQg9yqfyMyVk7dx8MwJU4g1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aND0/2gWknRJgvLyEQKMSntxnSWizggwpNvLAkbu5vlNz51av/5zA/VPLfkF/LdNx
         JNBUbjFIuxoE38n8Xp9Y6DKK7zYklYgeI3nWeukMYHvWY/u8JaleEzyVzmAUM5zo+x
         FDw2gON4Owkzw9VQNcdixuHPIZp60Z8PZ7FbUHmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 338/371] dmaengine: at_xdmac: Fix race for the tx desc callback
Date:   Mon,  8 May 2023 11:48:59 +0200
Message-Id: <20230508094825.542387929@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

[ Upstream commit b63e5cb94ad6947ab5fe38b5a9417dcfd0bc6122 ]

The transfer descriptors were wrongly moved to the free descriptors list
before calling the tx desc callback. As the DMA engine drivers drop any
locks before calling the callback function, txd could be taken again,
resulting in its callback called prematurely. Fix the race for the tx desc
callback by moving the xfer desc into the free desc list after the
callback is invoked.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Link: https://lore.kernel.org/r/20211215110115.191749-6-tudor.ambarus@microchip.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/at_xdmac.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index c6b200f0145ba..f7b0de4f4667d 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1586,20 +1586,6 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	return ret;
 }
 
-/* Call must be protected by lock. */
-static void at_xdmac_remove_xfer(struct at_xdmac_chan *atchan,
-				    struct at_xdmac_desc *desc)
-{
-	dev_dbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
-
-	/*
-	 * Remove the transfer from the transfer list then move the transfer
-	 * descriptors into the free descriptors list.
-	 */
-	list_del(&desc->xfer_node);
-	list_splice_init(&desc->descs_list, &atchan->free_descs_list);
-}
-
 static void at_xdmac_advance_work(struct at_xdmac_chan *atchan)
 {
 	struct at_xdmac_desc	*desc;
@@ -1711,7 +1697,8 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 
 		txd = &desc->tx_dma_desc;
 		dma_cookie_complete(txd);
-		at_xdmac_remove_xfer(atchan, desc);
+		/* Remove the transfer from the transfer list. */
+		list_del(&desc->xfer_node);
 		spin_unlock_irq(&atchan->lock);
 
 		if (txd->flags & DMA_PREP_INTERRUPT)
@@ -1720,6 +1707,8 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 		dma_run_dependencies(txd);
 
 		spin_lock_irq(&atchan->lock);
+		/* Move the xfer descriptors into the free descriptors list. */
+		list_splice_init(&desc->descs_list, &atchan->free_descs_list);
 		at_xdmac_advance_work(atchan);
 		spin_unlock_irq(&atchan->lock);
 	}
@@ -1866,8 +1855,10 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
 		cpu_relax();
 
 	/* Cancel all pending transfers. */
-	list_for_each_entry_safe(desc, _desc, &atchan->xfers_list, xfer_node)
-		at_xdmac_remove_xfer(atchan, desc);
+	list_for_each_entry_safe(desc, _desc, &atchan->xfers_list, xfer_node) {
+		list_del(&desc->xfer_node);
+		list_splice_init(&desc->descs_list, &atchan->free_descs_list);
+	}
 
 	clear_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
 	clear_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status);
-- 
2.39.2



