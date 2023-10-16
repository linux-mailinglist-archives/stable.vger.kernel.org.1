Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AED7CAC22
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjJPOtz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjJPOty (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:49:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEC6B9
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:49:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D221AC433C7;
        Mon, 16 Oct 2023 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467791;
        bh=62Q2FucbjdVPpd4Ah7nSGS93+lk8/5S4NuB1QxptyaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GJHzl2aIe4L3hwI5geK855MLJiR4Lp9af0BAGjRBQhrsDb5V9VcRslyaVoB6x1D7v
         iQEDWXWRQWnr/L424G7dPNGWfAPUuA522/NDUyjM2BjmMsZ/rnXvTX7mqjfCKxKYjY
         Aa/shkYPAxjHgjwEv1hOID5q8bQeGxVPkT0cKZ4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.5 095/191] dmaengine: stm32-dma: fix stm32_dma_prep_slave_sg in case of MDMA chaining
Date:   Mon, 16 Oct 2023 10:41:20 +0200
Message-ID: <20231016084017.610470587@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

commit 2df467e908ce463cff1431ca1b00f650f7a514b4 upstream.

Current Target (CT) have to be reset when starting an MDMA chaining use
case, as Double Buffer mode is activated. It ensures the DMA will start
processing the first memory target (pointed with SxM0AR).

Fixes: 723795173ce1 ("dmaengine: stm32-dma: add support to trigger STM32 MDMA")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231004155024.2609531-1-amelie.delaunay@foss.st.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/stm32-dma.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1113,8 +1113,10 @@ static struct dma_async_tx_descriptor *s
 		chan->chan_reg.dma_scr &= ~STM32_DMA_SCR_PFCTRL;
 
 	/* Activate Double Buffer Mode if DMA triggers STM32 MDMA and more than 1 sg */
-	if (chan->trig_mdma && sg_len > 1)
+	if (chan->trig_mdma && sg_len > 1) {
 		chan->chan_reg.dma_scr |= STM32_DMA_SCR_DBM;
+		chan->chan_reg.dma_scr &= ~STM32_DMA_SCR_CT;
+	}
 
 	for_each_sg(sgl, sg, sg_len, i) {
 		ret = stm32_dma_set_xfer_param(chan, direction, &buswidth,


