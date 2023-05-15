Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EE87033E7
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242891AbjEOQmt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242883AbjEOQms (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:42:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0EB49CD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14391628AC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04846C433D2;
        Mon, 15 May 2023 16:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168956;
        bh=z5BKu/m3p22eDF8lFsgJC456G83HtzdywNYcJohi4GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dH9qfGCUZcaG882XeQNFk3tGlV4dwwoD7SuqH16O+rJAd3KfynVIZ4u2WRT8ihpGc
         sMO7x1VdNeZ6rAt9mz2Qy+foXR5plmPA9MmUvFzyNa48ExYmS4Lk8MvizEMJqdbwvc
         aGjzi8DjaRXEtCDwoAUU2br5sHKqaU/go1oArlFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dhruva Gole <d-gole@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 096/191] spi: cadence-quadspi: fix suspend-resume implementations
Date:   Mon, 15 May 2023 18:25:33 +0200
Message-Id: <20230515161710.768034154@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
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

From: Dhruva Gole <d-gole@ti.com>

[ Upstream commit 2087e85bb66ee3652dafe732bb9b9b896229eafc ]

The cadence QSPI driver misbehaves after performing a full system suspend
resume:
...
spi-nor spi0.0: resume() failed
...
This results in a flash connected via OSPI interface after system suspend-
resume to be unusable.
fix these suspend and resume functions.

Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")
Signed-off-by: Dhruva Gole <d-gole@ti.com>
Link: https://lore.kernel.org/r/20230417091027.966146-3-d-gole@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 16ac2e3c351df..d5c6b91fd1139 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -1412,17 +1412,30 @@ static int cqspi_remove(struct platform_device *pdev)
 static int cqspi_suspend(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
+	struct spi_master *master = dev_get_drvdata(dev);
+	int ret;
 
+	ret = spi_master_suspend(master);
 	cqspi_controller_enable(cqspi, 0);
-	return 0;
+
+	clk_disable_unprepare(cqspi->clk);
+
+	return ret;
 }
 
 static int cqspi_resume(struct device *dev)
 {
 	struct cqspi_st *cqspi = dev_get_drvdata(dev);
+	struct spi_master *master = dev_get_drvdata(dev);
 
-	cqspi_controller_enable(cqspi, 1);
-	return 0;
+	clk_prepare_enable(cqspi->clk);
+	cqspi_wait_idle(cqspi);
+	cqspi_controller_init(cqspi);
+
+	cqspi->current_cs = -1;
+	cqspi->sclk = 0;
+
+	return spi_master_resume(master);
 }
 
 static const struct dev_pm_ops cqspi__dev_pm_ops = {
-- 
2.39.2



