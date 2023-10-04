Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C877B817E
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 15:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbjJDN5a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 09:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242713AbjJDN53 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 09:57:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CEDA1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 06:57:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0DBC433C8;
        Wed,  4 Oct 2023 13:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696427846;
        bh=FCii/F77an7eBrawsy9uAxnEvceV3AE5XnWjsu7vUW4=;
        h=Subject:To:Cc:From:Date:From;
        b=y2ecUX33uU4k36g4UMNeFIlzt56NcGgNG9EO7nD4Sck2AGNZmJIOXBGl0PdvncXMN
         j4qn5cmDSDShq+H2i3pQVZHQtAjh09mLjLSPLuZYIsSfQih7dKRXonqnsHKMW7qTwc
         cdHUnzvykpIGgnBYDJxte8WzHO5bcX5T4mDu6Vus=
Subject: FAILED: patch "[PATCH] spi: zynqmp-gqspi: fix clock imbalance on probe failure" failed to apply to 4.19-stable tree
To:     johan+linaro@kernel.org, broonie@kernel.org,
        naga.sureshkumar.relli@xilinx.com, shubhrajyoti.datta@xilinx.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 15:57:22 +0200
Message-ID: <2023100421-tribute-plausible-7fed@gregkh>
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 1527b076ae2cb6a9c590a02725ed39399fcad1cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100421-tribute-plausible-7fed@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

1527b076ae2c ("spi: zynqmp-gqspi: fix clock imbalance on probe failure")
3ffefa1d9c9e ("spi: zynqmp-gqspi: Convert to platform remove callback returning void")
58eaa7b2d07d ("spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe")
1c26372e5aa9 ("spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework")
91af6eb04a6b ("spi: spi-zynqmp-gqspi: Fix kernel-doc warnings")
4b42b0b49812 ("spi: spi-zynqmp-gqspi: Correct a couple of misspellings in kerneldoc")
4db8180ffe7c ("firmware: xilinx: Remove eemi ops for fpga related APIs")
bc86f9c54616 ("firmware: xilinx: Remove eemi ops for aes engine")
cbbbda71fe37 ("firmware: xilinx: Remove eemi ops for set_requirement")
07fb1a4619fc ("firmware: xilinx: Remove eemi ops for release_node")
bf8b27ed2324 ("firmware: xilinx: Remove eemi ops for request_node")
951d0a97e41c ("firmware: xilinx: Remove eemi ops for set_suspend_mode")
9474da950d1e ("firmware: xilinx: Remove eemi ops for init_finalize")
1b413581fe26 ("firmware: xilinx: Remove eemi ops for reset_get_status")
cf23ec353146 ("firmware: xilinx: Remove eemi ops for reset_assert")
426c8d85df7a ("firmware: xilinx: Use APIs instead of IOCTLs")
70c0d36462ca ("firmware: xilinx: Remove eemi ops for clock set/get parent")
7a1e10621a21 ("firmware: xilinx: Remove eemi ops for clock set/get rate")
0667a8d144bc ("firmware: xilinx: Remove eemi ops for clock_getdivider")
fc9fb8fb985c ("firmware: xilinx: Remove eemi ops for clock_setdivider")

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

