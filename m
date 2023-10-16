Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70077CA331
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjJPJCT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjJPJCE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:02:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C8D10B
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:02:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73BAC433C8;
        Mon, 16 Oct 2023 09:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446920;
        bh=C05dGbU4YkjewGXgds54XisJtOCaclPoQhJo42w4rOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCxq0IRKmwcd/F+TmsrDYXm92cI0vbsUBVfW0g2D/onIQx5HES00330YiejUpI/9n
         LqrAKZzmsCuTh9UmcyV3uWkgMqwaHvFAAN7r7EEvda1DHXkWN1XZs37esG5PtYOhfN
         OIGJJK0MCQ2yPKx7VMIfDMaDFHBa1wrkM9Z27Di4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.1 069/131] dmaengine: stm32-dma: fix stm32_dma_prep_slave_sg in case of MDMA chaining
Date:   Mon, 16 Oct 2023 10:40:52 +0200
Message-ID: <20231016084001.780406628@linuxfoundation.org>
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
 drivers/dma/stm32-dma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index 5c36811aa134..7427acc82259 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1113,8 +1113,10 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 		chan->chan_reg.dma_scr &= ~STM32_DMA_SCR_PFCTRL;
 
 	/* Activate Double Buffer Mode if DMA triggers STM32 MDMA and more than 1 sg */
-	if (chan->trig_mdma && sg_len > 1)
+	if (chan->trig_mdma && sg_len > 1) {
 		chan->chan_reg.dma_scr |= STM32_DMA_SCR_DBM;
+		chan->chan_reg.dma_scr &= ~STM32_DMA_SCR_CT;
+	}
 
 	for_each_sg(sgl, sg, sg_len, i) {
 		ret = stm32_dma_set_xfer_param(chan, direction, &buswidth,
-- 
2.42.0



