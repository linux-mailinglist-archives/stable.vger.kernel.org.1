Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0B07B8179
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 15:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjJDN47 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 09:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242696AbjJDN47 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 09:56:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084BEAB
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 06:56:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F260C433C7;
        Wed,  4 Oct 2023 13:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696427815;
        bh=5ie6WXV6uohJ4b68HqDLFzh5o9+XDk36KmXnJMYU4tw=;
        h=Subject:To:Cc:From:Date:From;
        b=jW+RY58NUSCDdQnmvRkutP+bjRCJau6hoO0ironMpXyrLh9eEb+xg7xYo7yXIyXxy
         e6DnzrCRkXQttC7AQhqf7n9b81KIeatoC7c9/ck9idxYbnhdvrt9zdw5F0fsFiVMUg
         VydBAlkOr8OS9v+dzWl8kh0srzcC6HLKthSgjWmQ=
Subject: FAILED: patch "[PATCH] spi: zynqmp-gqspi: fix clock imbalance on probe failure" failed to apply to 6.1-stable tree
To:     johan+linaro@kernel.org, broonie@kernel.org,
        naga.sureshkumar.relli@xilinx.com, shubhrajyoti.datta@xilinx.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 15:56:52 +0200
Message-ID: <2023100450-unnamable-reemerge-dcef@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1527b076ae2cb6a9c590a02725ed39399fcad1cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100450-unnamable-reemerge-dcef@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

1527b076ae2c ("spi: zynqmp-gqspi: fix clock imbalance on probe failure")
3ffefa1d9c9e ("spi: zynqmp-gqspi: Convert to platform remove callback returning void")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1527b076ae2cb6a9c590a02725ed39399fcad1cf Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Thu, 22 Jun 2023 10:24:35 +0200
Subject: [PATCH] spi: zynqmp-gqspi: fix clock imbalance on probe failure

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

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index fb2ca9b90eab..c309dedfd602 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1342,9 +1342,9 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
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
@@ -1368,11 +1368,15 @@ static void zynqmp_qspi_remove(struct platform_device *pdev)
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
 }
 
 MODULE_DEVICE_TABLE(of, zynqmp_qspi_of_match);

