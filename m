Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB09672BFB3
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbjFLKqh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbjFLKqM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:46:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0113FCB5
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ABCD60C2D
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF3CC4339B;
        Mon, 12 Jun 2023 10:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565849;
        bh=Y9A18VFjOpcgWNPZntt3b++kFwTWUM2d0hejm18dXBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=01za/pyLJOAWhFKklfHnSSNiSBBqLQEn7YwxR/E78hBB1Zp6NT/MTDGefgdNWnelc
         /e324IMdNfooyCqCYHbUwUyNiDrG5xvMZzsr+qJbPHpE8Fu3jrsb/PkHsfL1LiOdFH
         OqaJCLWtpfjoBxwXot2yJnDUZ+jXhvhhPfgugUS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 05/45] spi: qup: Request DMA before enabling clocks
Date:   Mon, 12 Jun 2023 12:25:59 +0200
Message-ID: <20230612101654.848203415@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101654.644983109@linuxfoundation.org>
References: <20230612101654.644983109@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit 0c331fd1dccfba657129380ee084b95c1cedfbef ]

It is usually better to request all necessary resources (clocks,
regulators, ...) before starting to make use of them. That way they do
not change state in case one of the resources is not available yet and
probe deferral (-EPROBE_DEFER) is necessary. This is particularly
important for DMA channels and IOMMUs which are not enforced by
fw_devlink yet (unless you use fw_devlink.strict=1).

spi-qup does this in the wrong order, the clocks are enabled and
disabled again when the DMA channels are not available yet.

This causes issues in some cases: On most SoCs one of the SPI QUP
clocks is shared with the UART controller. When using earlycon UART is
actively used during boot but might not have probed yet, usually for
the same reason (waiting for the DMA controller). In this case, the
brief enable/disable cycle ends up gating the clock and further UART
console output will halt the system completely.

Avoid this by requesting the DMA channels before changing the clock
state.

Fixes: 612762e82ae6 ("spi: qup: Add DMA capabilities")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Link: https://lore.kernel.org/r/20230518-spi-qup-clk-defer-v1-1-f49fc9ca4e02@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-qup.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index ebcf9f4d5679e..94aa51d91b067 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1030,23 +1030,8 @@ static int spi_qup_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	ret = clk_prepare_enable(cclk);
-	if (ret) {
-		dev_err(dev, "cannot enable core clock\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(iclk);
-	if (ret) {
-		clk_disable_unprepare(cclk);
-		dev_err(dev, "cannot enable iface clock\n");
-		return ret;
-	}
-
 	master = spi_alloc_master(dev, sizeof(struct spi_qup));
 	if (!master) {
-		clk_disable_unprepare(cclk);
-		clk_disable_unprepare(iclk);
 		dev_err(dev, "cannot allocate master\n");
 		return -ENOMEM;
 	}
@@ -1092,6 +1077,19 @@ static int spi_qup_probe(struct platform_device *pdev)
 	spin_lock_init(&controller->lock);
 	init_completion(&controller->done);
 
+	ret = clk_prepare_enable(cclk);
+	if (ret) {
+		dev_err(dev, "cannot enable core clock\n");
+		goto error_dma;
+	}
+
+	ret = clk_prepare_enable(iclk);
+	if (ret) {
+		clk_disable_unprepare(cclk);
+		dev_err(dev, "cannot enable iface clock\n");
+		goto error_dma;
+	}
+
 	iomode = readl_relaxed(base + QUP_IO_M_MODES);
 
 	size = QUP_IO_M_OUTPUT_BLOCK_SIZE(iomode);
@@ -1121,7 +1119,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	ret = spi_qup_set_state(controller, QUP_STATE_RESET);
 	if (ret) {
 		dev_err(dev, "cannot set RESET state\n");
-		goto error_dma;
+		goto error_clk;
 	}
 
 	writel_relaxed(0, base + QUP_OPERATIONAL);
@@ -1145,7 +1143,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, irq, spi_qup_qup_irq,
 			       IRQF_TRIGGER_HIGH, pdev->name, controller);
 	if (ret)
-		goto error_dma;
+		goto error_clk;
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
@@ -1160,11 +1158,12 @@ static int spi_qup_probe(struct platform_device *pdev)
 
 disable_pm:
 	pm_runtime_disable(&pdev->dev);
+error_clk:
+	clk_disable_unprepare(cclk);
+	clk_disable_unprepare(iclk);
 error_dma:
 	spi_qup_release_dma(master);
 error:
-	clk_disable_unprepare(cclk);
-	clk_disable_unprepare(iclk);
 	spi_master_put(master);
 	return ret;
 }
-- 
2.39.2



