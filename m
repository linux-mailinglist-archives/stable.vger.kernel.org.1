Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AF57CAC23
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjJPOt4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbjJPOtz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:49:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEB295
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:49:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF126C433C9;
        Mon, 16 Oct 2023 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467794;
        bh=UuP3EA/FEdeIPTYKFqoMWl/FVkGBYz+VT0KahhM0gSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VX+hMS0kDGZS51ZgJ/LH02XEDo6XtmV1g7zdHDLSmra5rRrW1v/NdNYkpv0jEyrPw
         V1a8sAFxCHtxO0dmX63W89txf7+OenwcMFYvC5crLzBX9A030gpO37Q5uop2Z0PWhX
         nuXZ85l1IpoPqAPaUk+KSAnDf8F0sHtLW2n80CDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.5 096/191] dmaengine: stm32-dma: fix residue in case of MDMA chaining
Date:   Mon, 16 Oct 2023 10:41:21 +0200
Message-ID: <20231016084017.632902383@linuxfoundation.org>
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

commit 67e13e89742c3b21ce177f612bf9ef32caae6047 upstream.

In case of MDMA chaining, DMA is configured in Double-Buffer Mode (DBM)
with two periods, but if transfer has been prepared with _prep_slave_sg(),
the transfer is not marked cyclic (=!chan->desc->cyclic). However, as DBM
is activated for MDMA chaining, residue computation must take into account
cyclic constraints.

With only two periods in MDMA chaining, and no update due to Transfer
Complete interrupt masked, n_sg is always 0. If DMA current memory address
(depending on SxCR.CT and SxM0AR/SxM1AR) does not correspond, it means n_sg
should be increased.
Then, the residue of the current period is the one read from SxNDTR and
should not be overwritten with the full period length.

Fixes: 723795173ce1 ("dmaengine: stm32-dma: add support to trigger STM32 MDMA")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231004155024.2609531-2-amelie.delaunay@foss.st.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/stm32-dma.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1389,11 +1389,12 @@ static size_t stm32_dma_desc_residue(str
 
 	residue = stm32_dma_get_remaining_bytes(chan);
 
-	if (chan->desc->cyclic && !stm32_dma_is_current_sg(chan)) {
+	if ((chan->desc->cyclic || chan->trig_mdma) && !stm32_dma_is_current_sg(chan)) {
 		n_sg++;
 		if (n_sg == chan->desc->num_sgs)
 			n_sg = 0;
-		residue = sg_req->len;
+		if (!chan->trig_mdma)
+			residue = sg_req->len;
 	}
 
 	/*
@@ -1403,7 +1404,7 @@ static size_t stm32_dma_desc_residue(str
 	 * residue = remaining bytes from NDTR + remaining
 	 * periods/sg to be transferred
 	 */
-	if (!chan->desc->cyclic || n_sg != 0)
+	if ((!chan->desc->cyclic && !chan->trig_mdma) || n_sg != 0)
 		for (i = n_sg; i < desc->num_sgs; i++)
 			residue += desc->sg_req[i].len;
 


