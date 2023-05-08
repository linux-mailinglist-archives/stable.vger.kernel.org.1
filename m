Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B476FAEA2
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbjEHLq2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbjEHLqL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:46:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D223710A21
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0A79637DE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85C8C4339B;
        Mon,  8 May 2023 11:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546343;
        bh=hvy8rfSeVxD3+5+rqgbYGlgTYzY0tDkqr26MXkbvD7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QBWtglSs7JHl7SnEaEEQtIPmlJPkY1ofZR2c9hc97a7x7GcTzhceP9xGkx/fzNNHv
         mmBKXhVNUbCmjn5U7xs4yFJrEinZhr10CR8vVbSNb/oQmuTJLKC8WoDhC6889Aos8K
         WJGoTl8V4h9QMIpNCBsKQE07hYt4dZBtqBri3P9A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 337/371] dmaengine: at_xdmac: Fix concurrency over chans completed_cookie
Date:   Mon,  8 May 2023 11:48:58 +0200
Message-Id: <20230508094825.505200830@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/at_xdmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index c5638afe94368..c6b200f0145ba 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1710,11 +1710,10 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
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



