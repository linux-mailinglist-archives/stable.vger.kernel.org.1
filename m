Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D754C7CA334
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjJPJC2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjJPJCO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:02:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3F1111
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:02:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64977C433C7;
        Mon, 16 Oct 2023 09:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446932;
        bh=Znsvx5aQvIBd9OH4W0W/roDbyiR/Ux+oCDX9LGfndTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGya0ix9gn1MtvETCK72watCqZnNhRG3Qai0/j7SrWTu38vV+SthjCJh4ZOhjfQ6g
         mAkk2X/a42dYB6xPBiEzqp5aGy0WsBLbNZUVWdVMUcaICXZXBtDF04JJnBXMSVbJ25
         oGSy0h97zMOd8donPRCqjynRlvw1R0KNDSfUh0WI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.1 072/131] dmaengine: stm32-mdma: set in_flight_bytes in case CRQA flag is set
Date:   Mon, 16 Oct 2023 10:40:55 +0200
Message-ID: <20231016084001.851364831@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

commit 584970421725b7805db84714b857851fdf7203a9 upstream.

CRQA flag is set by hardware when the channel request become active and
the channel is enabled. It is cleared by hardware, when the channel request
is completed.
So when it is set, it means MDMA is transferring bytes.
This information is useful in case of STM32 DMA and MDMA chaining,
especially when the user pauses DMA before stopping it, to trig one last
MDMA transfer to get the latest bytes of the SRAM buffer to the
destination buffer.
STM32 DCMI driver can then use this to know if the last MDMA transfer in
case of chaining is done.

Fixes: 696874322771 ("dmaengine: stm32-mdma: add support to be triggered by STM32 DMA")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231004163531.2864160-3-amelie.delaunay@foss.st.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/stm32-mdma.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1319,7 +1319,8 @@ static int stm32_mdma_slave_config(struc
 
 static size_t stm32_mdma_desc_residue(struct stm32_mdma_chan *chan,
 				      struct stm32_mdma_desc *desc,
-				      u32 curr_hwdesc)
+				      u32 curr_hwdesc,
+				      struct dma_tx_state *state)
 {
 	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
 	struct stm32_mdma_hwdesc *hwdesc;
@@ -1343,6 +1344,10 @@ static size_t stm32_mdma_desc_residue(st
 	cbndtr = stm32_mdma_read(dmadev, STM32_MDMA_CBNDTR(chan->id));
 	residue += cbndtr & STM32_MDMA_CBNDTR_BNDT_MASK;
 
+	state->in_flight_bytes = 0;
+	if (chan->chan_config.m2m_hw && (cisr & STM32_MDMA_CISR_CRQA))
+		state->in_flight_bytes = cbndtr & STM32_MDMA_CBNDTR_BNDT_MASK;
+
 	if (!chan->mem_burst)
 		return residue;
 
@@ -1372,11 +1377,10 @@ static enum dma_status stm32_mdma_tx_sta
 
 	vdesc = vchan_find_desc(&chan->vchan, cookie);
 	if (chan->desc && cookie == chan->desc->vdesc.tx.cookie)
-		residue = stm32_mdma_desc_residue(chan, chan->desc,
-						  chan->curr_hwdesc);
+		residue = stm32_mdma_desc_residue(chan, chan->desc, chan->curr_hwdesc, state);
 	else if (vdesc)
-		residue = stm32_mdma_desc_residue(chan,
-						  to_stm32_mdma_desc(vdesc), 0);
+		residue = stm32_mdma_desc_residue(chan, to_stm32_mdma_desc(vdesc), 0, state);
+
 	dma_set_residue(state, residue);
 
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);


