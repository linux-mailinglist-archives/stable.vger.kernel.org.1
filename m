Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA9B7D3504
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjJWLoq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbjJWLol (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:44:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC26D10E0
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:44:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D2FC433CA;
        Mon, 23 Oct 2023 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061474;
        bh=jKAGsqXOfjXJ7M67HDVh7ZBpHgAHZ3l58D6qThMWHGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lM/XGm3WJ+9FGnSdaNMN1fFce2G+mb+bC+V2VjR8ZT5R7T0zIjZtctqUhIQpJEHmP
         H58nvf2qx6p8o71AVtRWfVSFw3p8vHfvgDi69xNGt4G7hzo0EfCyl7+k5f676V4c0j
         LlxwRidxC4hbxpbhVrwNjWso79j2zExAynpahg/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Duoming Zhou <duoming@zju.edu.cn>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 059/202] dmaengine: mediatek: Fix deadlock caused by synchronize_irq()
Date:   Mon, 23 Oct 2023 12:56:06 +0200
Message-ID: <20231023104828.286475366@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 01f1ae2733e2bb4de92fefcea5fda847d92aede1 ]

The synchronize_irq(c->irq) will not return until the IRQ handler
mtk_uart_apdma_irq_handler() is completed. If the synchronize_irq()
holds a spin_lock and waits the IRQ handler to complete, but the
IRQ handler also needs the same spin_lock. The deadlock will happen.
The process is shown below:

          cpu0                        cpu1
mtk_uart_apdma_device_pause() | mtk_uart_apdma_irq_handler()
  spin_lock_irqsave()         |
                              |   spin_lock_irqsave()
  //hold the lock to wait     |
  synchronize_irq()           |

This patch reorders the synchronize_irq(c->irq) outside the spin_lock
in order to mitigate the bug.

Fixes: 9135408c3ace ("dmaengine: mediatek: Add MediaTek UART APDMA support")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Reviewed-by: Eugen Hristev <eugen.hristev@collabora.com>
Link: https://lore.kernel.org/r/20230806032511.45263-1-duoming@zju.edu.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/mediatek/mtk-uart-apdma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index a1517ef1f4a01..0acf6a92a4ad3 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -451,9 +451,8 @@ static int mtk_uart_apdma_device_pause(struct dma_chan *chan)
 	mtk_uart_apdma_write(c, VFF_EN, VFF_EN_CLR_B);
 	mtk_uart_apdma_write(c, VFF_INT_EN, VFF_INT_EN_CLR_B);
 
-	synchronize_irq(c->irq);
-
 	spin_unlock_irqrestore(&c->vc.lock, flags);
+	synchronize_irq(c->irq);
 
 	return 0;
 }
-- 
2.40.1



