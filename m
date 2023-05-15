Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28324703C14
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245138AbjEOSJS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244976AbjEOSIw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B939186C1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 846B6630E1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F75C433D2;
        Mon, 15 May 2023 18:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173998;
        bh=EsP/qXGx08YRLEF5BUPij2KeMUNNe9dami6uLoMtnkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e0LTGgR0cUtLM2mqU5GyQncuDVkvBUZ0IPEcSNMjc++DGlI1vy+HW44CxMHzfeGg7
         P4xXzsBqenPIQkMx7hNC49sUA8YTr6aBNfswzTYAVOb24igvPQ3fSLWVdAdvzbe9L/
         +cikEzy7NU73WamAq1sCqG/QhCCSESt0hbxA9470=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Christian Eggers <ceggers@arri.de>
Subject: [PATCH 5.4 275/282] spi: imx: fix runtime pm support for !CONFIG_PM
Date:   Mon, 15 May 2023 18:30:53 +0200
Message-Id: <20230515161730.617027240@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Sascha Hauer <s.hauer@pengutronix.de>

commit 43b6bf406cd0319e522638f97c9086b7beebaeaa upstream.

525c9e5a32bd introduced pm_runtime support for the i.MX SPI driver. With
this pm_runtime is used to bring up the clocks initially. When CONFIG_PM
is disabled the clocks are no longer enabled and the driver doesn't work
anymore. Fix this by enabling the clocks in the probe function and
telling pm_runtime that the device is active using
pm_runtime_set_active().

Fixes: 525c9e5a32bd spi: imx: enable runtime pm support
Tested-by: Christian Eggers <ceggers@arri.de> [tested for !CONFIG_PM only]
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://lore.kernel.org/r/20201021104513.21560-1-s.hauer@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-imx.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1676,15 +1676,18 @@ static int spi_imx_probe(struct platform
 		goto out_master_put;
 	}
 
-	pm_runtime_enable(spi_imx->dev);
+	ret = clk_prepare_enable(spi_imx->clk_per);
+	if (ret)
+		goto out_master_put;
+
+	ret = clk_prepare_enable(spi_imx->clk_ipg);
+	if (ret)
+		goto out_put_per;
+
 	pm_runtime_set_autosuspend_delay(spi_imx->dev, MXC_RPM_TIMEOUT);
 	pm_runtime_use_autosuspend(spi_imx->dev);
-
-	ret = pm_runtime_get_sync(spi_imx->dev);
-	if (ret < 0) {
-		dev_err(spi_imx->dev, "failed to enable clock\n");
-		goto out_runtime_pm_put;
-	}
+	pm_runtime_set_active(spi_imx->dev);
+	pm_runtime_enable(spi_imx->dev);
 
 	spi_imx->spi_clk = clk_get_rate(spi_imx->clk_per);
 	/*
@@ -1721,8 +1724,12 @@ static int spi_imx_probe(struct platform
 
 out_runtime_pm_put:
 	pm_runtime_dont_use_autosuspend(spi_imx->dev);
-	pm_runtime_put_sync(spi_imx->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(spi_imx->dev);
+
+	clk_disable_unprepare(spi_imx->clk_ipg);
+out_put_per:
+	clk_disable_unprepare(spi_imx->clk_per);
 out_master_put:
 	spi_master_put(master);
 


