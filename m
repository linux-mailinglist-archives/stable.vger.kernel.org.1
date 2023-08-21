Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED7F78334F
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjHUUKH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjHUUKG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:10:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288B4131
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:10:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3B2A64AC6
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3356C433C8;
        Mon, 21 Aug 2023 20:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648604;
        bh=CfeFDhCIAOBaxxXEcvHBEmT7Oy1DtkZM5jpIhnh3JMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ul7Qr0bZKVhGHgj5alB7rXT8sSCIpGErtnLaryRXYQZtA2/9pzUvo3UkegWo7myHm
         fHfNvIxSnR1Uw7Z+++RNjJn0881zvijOt/8sJOpzNo2w4kJX2c1Ej2DFMLfoMakq2J
         d7TaaRl20PiaTE+32hysZBJ1/kbDad9Hk68bpglA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Chen <harperchen1110@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.4 218/234] mmc: sunplus: fix return value check of mmc_add_host()
Date:   Mon, 21 Aug 2023 21:43:01 +0200
Message-ID: <20230821194138.515290311@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Wei Chen <harperchen1110@gmail.com>

commit dce6d8f985fa1ef5c2af47f4f86ea65511b78656 upstream.

mmc_add_host() may return error, if we ignore its return value,
1. the memory allocated in mmc_alloc_host() will be leaked
2. null-ptr-deref will happen when calling mmc_remove_host()
in remove function spmmc_drv_remove() because deleting not
added device.

Fix this by checking the return value of mmc_add_host(). Moreover,
I fixed the error handling path of spmmc_drv_probe() to clean up.

Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Link: https://lore.kernel.org/r/20230622090233.188539-1-harperchen1110@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sunplus-mmc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
index db5e0dcdfa7f..a55a87f64d2a 100644
--- a/drivers/mmc/host/sunplus-mmc.c
+++ b/drivers/mmc/host/sunplus-mmc.c
@@ -902,7 +902,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-		goto probe_free_host;
+		goto clk_disable;
 
 	mmc->ops = &spmmc_ops;
 	mmc->f_min = SPMMC_MIN_CLK;
@@ -911,7 +911,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
-		goto probe_free_host;
+		goto clk_disable;
 
 	if (!mmc->ocr_avail)
 		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
@@ -927,9 +927,17 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 	host->tuning_info.enable_tuning = 1;
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-	mmc_add_host(mmc);
+	ret = mmc_add_host(mmc);
+	if (ret)
+		goto pm_disable;
 
-	return ret;
+	return 0;
+
+pm_disable:
+	pm_runtime_disable(&pdev->dev);
+
+clk_disable:
+	clk_disable_unprepare(host->clk);
 
 probe_free_host:
 	if (mmc)
-- 
2.41.0



