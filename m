Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E337BDE10
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376908AbjJINPf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376968AbjJINP3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:15:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2529E8F
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:15:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60005C433C8;
        Mon,  9 Oct 2023 13:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857325;
        bh=XhlJtom1cxwQhHLyJhlFE1H9uqAAneUxuy+SxlFyFPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YuhvhUcHKYTFst8WkC+NvN3pn0ToNn6eXsbiYFxNJlIq8NuDEr4FN/l5pWHiitPf/
         fr3esiU8VK3PIllwxKBOx03ukF+tc4a1lkF5k1NNYbtncGRWGaex1X/tlt57ZYk8Wf
         NY3nl5PTnNTNVOaVCYa7QUCfd98AdrVFnMdj9sOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 001/162] spi: zynqmp-gqspi: Convert to platform remove callback returning void
Date:   Mon,  9 Oct 2023 14:59:42 +0200
Message-ID: <20231009130122.990256512@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 3ffefa1d9c9eba60c7f8b4a9ce2df3e4c7f4a88e ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230303172041.2103336-88-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 1527b076ae2c ("spi: zynqmp-gqspi: fix clock imbalance on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-zynqmp-gqspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index c760aac070e54..876a41c5d1664 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1240,7 +1240,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
  *
  * Return:	0 Always
  */
-static int zynqmp_qspi_remove(struct platform_device *pdev)
+static void zynqmp_qspi_remove(struct platform_device *pdev)
 {
 	struct zynqmp_qspi *xqspi = platform_get_drvdata(pdev);
 
@@ -1249,8 +1249,6 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 	clk_disable_unprepare(xqspi->pclk);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static const struct of_device_id zynqmp_qspi_of_match[] = {
@@ -1262,7 +1260,7 @@ MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);
 
 static struct platform_driver zynqmp_qspi_driver = {
 	.probe = zynqmp_qspi_probe,
-	.remove = zynqmp_qspi_remove,
+	.remove_new = zynqmp_qspi_remove,
 	.driver = {
 		.name = "zynqmp-qspi",
 		.of_match_table = zynqmp_qspi_of_match,
-- 
2.40.1



