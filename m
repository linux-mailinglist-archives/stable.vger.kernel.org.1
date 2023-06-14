Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641F6719D8E
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjFANYY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjFANYU (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:24:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F68818D
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AC2E6447B
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28217C433D2;
        Thu,  1 Jun 2023 13:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625843;
        bh=B6MC9oxD00Vtij0IFY+9rSaqc/4TxjZQC9CwsFybzno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kALlwo69h6eJYdguwNoY860Yz0zLsVzxbSd2BYxDzaAA1JcSxx6PZ6F/GWXQG2BKw
         bT49AIt3D2dAUO5pwZPPQNIkdVPxLBlFIjxPTM13pYDWlS7ATYtp2ThhdD73mBqsQ+
         uoYznslfxK/MJDm+9Etld5HnNnUt8kD6gWS4rkZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 15/42] dmaengine: at_xdmac: Remove a level of indentation in at_xdmac_tasklet()
Date:   Thu,  1 Jun 2023 14:21:02 +0100
Message-Id: <20230601131937.409173281@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131936.699199833@linuxfoundation.org>
References: <20230601131936.699199833@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

[ Upstream commit a61210cae80cac0701d5aca9551466a389717fd2 ]

Apart of making the code easier to read, this patch is a prerequisite for
a functional change: tasklets run with interrupts enabled, so we need to
protect atchan->irq_status with spin_lock_irq() otherwise the tasklet can
be interrupted by the IRQ that modifies irq_status. atchan->irq_status
will be protected in a further patch.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Link: https://lore.kernel.org/r/20211215110115.191749-12-tudor.ambarus@microchip.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 44fe8440bda5 ("dmaengine: at_xdmac: do not resume channels paused by consumers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/at_xdmac.c | 66 ++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index b45437aab1434..f9aa5396c0f8e 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1670,53 +1670,51 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 {
 	struct at_xdmac_chan	*atchan = from_tasklet(atchan, t, tasklet);
 	struct at_xdmac_desc	*desc;
+	struct dma_async_tx_descriptor *txd;
 	u32			error_mask;
 
 	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08x\n",
 		__func__, atchan->irq_status);
 
-	error_mask = AT_XDMAC_CIS_RBEIS
-		     | AT_XDMAC_CIS_WBEIS
-		     | AT_XDMAC_CIS_ROIS;
+	if (at_xdmac_chan_is_cyclic(atchan))
+		return at_xdmac_handle_cyclic(atchan);
 
-	if (at_xdmac_chan_is_cyclic(atchan)) {
-		at_xdmac_handle_cyclic(atchan);
-	} else if ((atchan->irq_status & AT_XDMAC_CIS_LIS)
-		   || (atchan->irq_status & error_mask)) {
-		struct dma_async_tx_descriptor  *txd;
+	error_mask = AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS |
+		AT_XDMAC_CIS_ROIS;
 
-		if (atchan->irq_status & error_mask)
-			at_xdmac_handle_error(atchan);
+	if (!(atchan->irq_status & AT_XDMAC_CIS_LIS) &&
+	    !(atchan->irq_status & error_mask))
+		return;
 
-		spin_lock_irq(&atchan->lock);
-		desc = list_first_entry(&atchan->xfers_list,
-					struct at_xdmac_desc,
-					xfer_node);
-		dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
-		if (!desc->active_xfer) {
-			dev_err(chan2dev(&atchan->chan), "Xfer not active: exiting");
-			spin_unlock_irq(&atchan->lock);
-			return;
-		}
+	if (atchan->irq_status & error_mask)
+		at_xdmac_handle_error(atchan);
 
-		txd = &desc->tx_dma_desc;
-		dma_cookie_complete(txd);
-		/* Remove the transfer from the transfer list. */
-		list_del(&desc->xfer_node);
+	spin_lock_irq(&atchan->lock);
+	desc = list_first_entry(&atchan->xfers_list, struct at_xdmac_desc,
+				xfer_node);
+	dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
+	if (!desc->active_xfer) {
+		dev_err(chan2dev(&atchan->chan), "Xfer not active: exiting");
 		spin_unlock_irq(&atchan->lock);
+		return;
+	}
 
-		if (txd->flags & DMA_PREP_INTERRUPT)
-			dmaengine_desc_get_callback_invoke(txd, NULL);
+	txd = &desc->tx_dma_desc;
+	dma_cookie_complete(txd);
+	/* Remove the transfer from the transfer list. */
+	list_del(&desc->xfer_node);
+	spin_unlock_irq(&atchan->lock);
 
-		dma_run_dependencies(txd);
+	if (txd->flags & DMA_PREP_INTERRUPT)
+		dmaengine_desc_get_callback_invoke(txd, NULL);
 
-		spin_lock_irq(&atchan->lock);
-		/* Move the xfer descriptors into the free descriptors list. */
-		list_splice_tail_init(&desc->descs_list,
-				      &atchan->free_descs_list);
-		at_xdmac_advance_work(atchan);
-		spin_unlock_irq(&atchan->lock);
-	}
+	dma_run_dependencies(txd);
+
+	spin_lock_irq(&atchan->lock);
+	/* Move the xfer descriptors into the free descriptors list. */
+	list_splice_tail_init(&desc->descs_list, &atchan->free_descs_list);
+	at_xdmac_advance_work(atchan);
+	spin_unlock_irq(&atchan->lock);
 }
 
 static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
-- 
2.39.2



