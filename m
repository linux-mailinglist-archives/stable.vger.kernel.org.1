Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B987BE0B3
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346505AbjJINnL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346443AbjJINnK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:43:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067B19D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:43:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4665AC433C8;
        Mon,  9 Oct 2023 13:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858988;
        bh=K+ffzTyNcnb+xea8TclQM5gI2ZkdJSnE1cgmrCYM9YU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fxTpau99uJ4Z2z1eF99EUHq/MpQ8/qrcIsOC+M/gG8O4kTE1W7YusdHyTiNBSjfjT
         frBlTszeh53vik8vESYNm5kX2PPkIb1ThcwrLLBJxx4PLb4Yb6Oj7NU2UB8l4Xu7sV
         CbbBEZ3zP4mtjSW1Jlc3wB5Tmb++gLMZPvNjn1mE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 164/226] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe
Date:   Mon,  9 Oct 2023 15:02:05 +0200
Message-ID: <20231009130130.959156677@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit a21fbc42807b15b74b0891bd557063e6acf4fcae ]

When platform_get_irq() fails, a pairing PM usage counter
increment is needed to keep the counter balanced. It's the
same for the following error paths.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Link: https://lore.kernel.org/r/20210408092559.3824-1-dinghao.liu@zju.edu.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 1527b076ae2c ("spi: zynqmp-gqspi: fix clock imbalance on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-zynqmp-gqspi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 3d3ac48243ebd..ed68e237314fb 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1147,11 +1147,16 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to pm_runtime_get_sync: %d\n", ret);
+		goto clk_dis_all;
+	}
+
 	/* QSPI controller initializations */
 	zynqmp_qspi_init_hw(xqspi);
 
-	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq <= 0) {
 		ret = -ENXIO;
@@ -1178,6 +1183,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 			    SPI_TX_DUAL | SPI_TX_QUAD;
 	ctlr->dev.of_node = np;
+	ctlr->auto_runtime_pm = true;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
@@ -1185,9 +1191,13 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 clk_dis_all:
+	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
-- 
2.40.1



