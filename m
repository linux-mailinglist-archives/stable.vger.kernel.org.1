Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6E57039D4
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244677AbjEORqQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244679AbjEORp7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:45:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEFD11624
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:43:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11FA962E94
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FF2C433D2;
        Mon, 15 May 2023 17:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172632;
        bh=81kQAN+x/AjDnTJwE638OXy+B90Tkgjsop+chHdMsns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVLjfHR0ktX9FovDWLC6hgua+Fv/3a4rUykoNS+XVZJjM1xaYZe/yjjJBCRvTUCPh
         XiCKwfQhA1rwKvLcODkuCW8TEKsVC/sdFGS9ESSN8ACaN0vg8JZ2g5+O46GTvG/UrI
         W+QCT4NIWm5Y0d7qec89Fb2AkYM1NzLhdYfJpTbY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dhruva Gole <d-gole@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 216/381] spi: cadence-quadspi: fix suspend-resume implementations
Date:   Mon, 15 May 2023 18:27:47 +0200
Message-Id: <20230515161746.530517630@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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
 drivers/spi/spi-cadence-quadspi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 2e1255bf1b429..23d50a19ae271 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1355,17 +1355,30 @@ static int cqspi_remove(struct platform_device *pdev)
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



