Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DAD726E2E
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjFGUsl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbjFGUsZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9DC26B2
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB75D60C6D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EA9C4339B;
        Wed,  7 Jun 2023 20:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170890;
        bh=RnTWit3fIlmdLqZWT+SREnqj6/o9Z0xdnUlpsu4GJtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJMuV32W0zsgWoX29HnEpyslb9FmTf+XpSXyDRECuToehJbnoXnpjBQ3Nb2VL3N9N
         tGp5ofNG9WZWXOOkBJdnmu891Cc0LYDMq878WB+jfaRbUTxEKShch/hgVntwGUOsbq
         GfotGJ5U/9bH2/5yZ8xu/cg/+30oDO3S5m9V6EVQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 004/120] dmaengine: at_xdmac: Fix concurrency over chans completed_cookie
Date:   Wed,  7 Jun 2023 22:15:20 +0200
Message-ID: <20230607200901.057845937@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

[ Upstream commit 506875c30fc5bf92246060bc3b4c38799646266b ]

Caller of dma_cookie_complete is expected to hold a lock to prevent
concurrency over the channel's completed cookie marker. Call
dma_cookie_complete() with the lock held.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Link: https://lore.kernel.org/r/20211215110115.191749-5-tudor.ambarus@microchip.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 4d43acb145c3 ("dmaengine: at_xdmac: fix potential Oops in at_xdmac_prep_interleaved()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/at_xdmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 1fe006cc643e7..501196d8c4881 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1651,11 +1651,10 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 		}
 
 		txd = &desc->tx_dma_desc;
-
+		dma_cookie_complete(txd);
 		at_xdmac_remove_xfer(atchan, desc);
 		spin_unlock_irq(&atchan->lock);
 
-		dma_cookie_complete(txd);
 		if (txd->flags & DMA_PREP_INTERRUPT)
 			dmaengine_desc_get_callback_invoke(txd, NULL);
 
-- 
2.39.2



