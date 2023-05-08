Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842D36FAEA1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbjEHLq1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbjEHLqK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:46:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4232106FF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:45:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D456563703
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4A1C433EF;
        Mon,  8 May 2023 11:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546352;
        bh=1ovJvShgBjYO84Fe5FrWxN2iG65GwYqS3xSFMDHGwxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sv0+jGPvb2ok845q3if1bMmmqScse/QrHUjucTIhCFZ9++j1fhU9Lyqq+KminUOos
         cuqoOae9i4PyPF4wCutQbpCHe98EAI4Kf0vqBwXxaQydFT8HNT2XQfgcn21SKHPMSm
         D9O2abvGvtO+IqTVKItnZSdhDRBTVIvzVkKUWfqI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 339/371] dmaengine: at_xdmac: do not enable all cyclic channels
Date:   Mon,  8 May 2023 11:49:00 +0200
Message-Id: <20230508094825.581663683@linuxfoundation.org>
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

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit f8435befd81dd85b7b610598551fadf675849bc1 ]

Do not global enable all the cyclic channels in at_xdmac_resume(). Instead
save the global status in at_xdmac_suspend() and re-enable the cyclic
channel only if it was active before suspend.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230214151827.1050280-6-claudiu.beznea@microchip.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/at_xdmac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index f7b0de4f4667d..80c609aa2a91c 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -243,6 +243,7 @@ struct at_xdmac {
 	int			irq;
 	struct clk		*clk;
 	u32			save_gim;
+	u32			save_gs;
 	struct dma_pool		*at_xdmac_desc_pool;
 	const struct at_xdmac_layout	*layout;
 	struct at_xdmac_chan	chan[];
@@ -1984,6 +1985,7 @@ static int atmel_xdmac_suspend(struct device *dev)
 		}
 	}
 	atxdmac->save_gim = at_xdmac_read(atxdmac, AT_XDMAC_GIM);
+	atxdmac->save_gs = at_xdmac_read(atxdmac, AT_XDMAC_GS);
 
 	at_xdmac_off(atxdmac);
 	clk_disable_unprepare(atxdmac->clk);
@@ -2023,7 +2025,8 @@ static int atmel_xdmac_resume(struct device *dev)
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, atchan->save_cndc);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CIE, atchan->save_cim);
 			wmb();
-			at_xdmac_write(atxdmac, AT_XDMAC_GE, atchan->mask);
+			if (atxdmac->save_gs & atchan->mask)
+				at_xdmac_write(atxdmac, AT_XDMAC_GE, atchan->mask);
 		}
 	}
 	return 0;
-- 
2.39.2



