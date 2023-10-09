Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EAA7BE0B4
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346516AbjJINnN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346443AbjJINnN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:43:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3083C9C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:43:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0EAC433C9;
        Mon,  9 Oct 2023 13:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858991;
        bh=m7R3ndbJ7hgMlk5u5F7a2HpxFy+MMILcSuRr3aN8cCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PdKV+TJxZVsARfNE7zB7Q1qX98MTrtfsmCPE3Ih6BMj3aravSG+udhqKN/gBhrO7P
         +V/KZGEr7sWHG52z0dpOC26vFSA7o+Xe9km8D/3fVd8ubg8DOlLaV823vpqXJjdsBl
         rwCsoy2KpeL6VDxX4AZLUFNJnyDPsFMdOpF4wR9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 165/226] spi: zynqmp-gqspi: fix clock imbalance on probe failure
Date:   Mon,  9 Oct 2023 15:02:06 +0200
Message-ID: <20231009130130.982390382@linuxfoundation.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit 1527b076ae2cb6a9c590a02725ed39399fcad1cf ]

Make sure that the device is not runtime suspended before explicitly
disabling the clocks on probe failure and on driver unbind to avoid a
clock enable-count imbalance.

Fixes: 9e3a000362ae ("spi: zynqmp: Add pm runtime support")
Cc: stable@vger.kernel.org	# 4.19
Cc: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/Message-Id: <20230622082435.7873-1-johan+linaro@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-zynqmp-gqspi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index ed68e237314fb..12d9c5d6b9e26 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1197,9 +1197,9 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	return 0;
 
 clk_dis_all:
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 clk_dis_pclk:
 	clk_disable_unprepare(xqspi->pclk);
@@ -1223,11 +1223,15 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 {
 	struct zynqmp_qspi *xqspi = platform_get_drvdata(pdev);
 
+	pm_runtime_get_sync(&pdev->dev);
+
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
+
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 	clk_disable_unprepare(xqspi->pclk);
-	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
-- 
2.40.1



