Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059FB7CA333
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjJPJC0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjJPJCL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:02:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2D6118
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:02:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B927C433C7;
        Mon, 16 Oct 2023 09:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446929;
        bh=yGHRDJmF+TNSGBd1Dm8votEx6BuNR8h03JDvo/ZLcN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=11/83vkcDPdoUBE0FmKGkkJYWfBCegOzll+fg/+5R1a3RO3hnqA7jS4jNN5nBW5ee
         j7DY6xEJU3V4Nw5QkQ9UHKM0omhCKy8yhdl+ZHrVP1W2UJWIr325FGgOuGo8Cbud0E
         6H8r7faklJhu+0fkMzN93MgNww7p1haTNds8AUeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.1 071/131] dmaengine: stm32-mdma: use Link Address Register to compute residue
Date:   Mon, 16 Oct 2023 10:40:54 +0200
Message-ID: <20231016084001.828078621@linuxfoundation.org>
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

commit a4b306eb83579c07b63dc65cd5bae53b7b4019d0 upstream.

Current implementation relies on curr_hwdesc index. But to keep this index
up to date, Block Transfer interrupt (BTIE) has to be enabled.
If it is not, curr_hwdesc is not updated, and then residue is not reliable.
Rely on Link Address Register instead. And disable BTIE interrupt
in stm32_mdma_setup_xfer() because it is no more needed in case of
_prep_slave_sg() to maintain curr_hwdesc up to date.
It avoids extra interrupts and also ensures a reliable residue. These
improvements are required for STM32 DCMI camera capture use case, which
need STM32 DMA and MDMA chaining for good performance.

Fixes: 696874322771 ("dmaengine: stm32-mdma: add support to be triggered by STM32 DMA")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231004163531.2864160-2-amelie.delaunay@foss.st.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/stm32-mdma.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -778,8 +778,6 @@ static int stm32_mdma_setup_xfer(struct
 	/* Enable interrupts */
 	ccr &= ~STM32_MDMA_CCR_IRQ_MASK;
 	ccr |= STM32_MDMA_CCR_TEIE | STM32_MDMA_CCR_CTCIE;
-	if (sg_len > 1)
-		ccr |= STM32_MDMA_CCR_BTIE;
 	desc->ccr = ccr;
 
 	return 0;
@@ -1325,12 +1323,21 @@ static size_t stm32_mdma_desc_residue(st
 {
 	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
 	struct stm32_mdma_hwdesc *hwdesc;
-	u32 cbndtr, residue, modulo, burst_size;
+	u32 cisr, clar, cbndtr, residue, modulo, burst_size;
 	int i;
 
+	cisr = stm32_mdma_read(dmadev, STM32_MDMA_CISR(chan->id));
+
 	residue = 0;
-	for (i = curr_hwdesc + 1; i < desc->count; i++) {
+	/* Get the next hw descriptor to process from current transfer */
+	clar = stm32_mdma_read(dmadev, STM32_MDMA_CLAR(chan->id));
+	for (i = desc->count - 1; i >= 0; i--) {
 		hwdesc = desc->node[i].hwdesc;
+
+		if (hwdesc->clar == clar)
+			break;/* Current transfer found, stop cumulating */
+
+		/* Cumulate residue of unprocessed hw descriptors */
 		residue += STM32_MDMA_CBNDTR_BNDT(hwdesc->cbndtr);
 	}
 	cbndtr = stm32_mdma_read(dmadev, STM32_MDMA_CBNDTR(chan->id));


