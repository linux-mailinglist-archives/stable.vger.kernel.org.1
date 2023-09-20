Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381AA7A802F
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbjITMdk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjITMdk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:33:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00D2AB
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:33:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E186FC433C7;
        Wed, 20 Sep 2023 12:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213211;
        bh=cK0mBvJoxtKDSRQylpNuod2RMnqinbhkb61/jN92DFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMHyVRv6nR+JaJzj037ZSKjAKqA+LCLpuwZm5JdhHvuy7xMRd+Gg+l/GsQXTSAXR8
         2HW0v0SkeUFPvZILEwpnWtQogu1bE2S14EH6IWSxbCS2YMqvizlDbRXGKku8q+xmrS
         f6FMkzPiSoMSyPZSKyMupak9JFb3bAxDJoJM6vqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ruan Jinjie <ruanjinjie@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 201/367] dmaengine: ste_dma40: Add missing IRQ check in d40_probe
Date:   Wed, 20 Sep 2023 13:29:38 +0200
Message-ID: <20230920112903.828512887@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ruanjinjie <ruanjinjie@huawei.com>

[ Upstream commit c05ce6907b3d6e148b70f0bb5eafd61dcef1ddc1 ]

Check for the return value of platform_get_irq(): if no interrupt
is specified, it wouldn't make sense to call request_irq().

Fixes: 8d318a50b3d7 ("DMAENGINE: Support for ST-Ericssons DMA40 block v3")
Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20230724144108.2582917-1-ruanjinjie@huawei.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ste_dma40.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 6671bfe084895..96a808b487cbe 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3599,6 +3599,10 @@ static int __init d40_probe(struct platform_device *pdev)
 	spin_lock_init(&base->lcla_pool.lock);
 
 	base->irq = platform_get_irq(pdev, 0);
+	if (base->irq < 0) {
+		ret = base->irq;
+		goto destroy_cache;
+	}
 
 	ret = request_irq(base->irq, d40_handle_interrupt, 0, D40_NAME, base);
 	if (ret) {
-- 
2.40.1



