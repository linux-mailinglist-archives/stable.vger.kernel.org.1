Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2646FA8C3
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjEHKpT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjEHKoy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:44:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88507A243
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:43:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0313B62870
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4474C433D2;
        Mon,  8 May 2023 10:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542612;
        bh=hJKjsrOyN9/5GVVjaDHcU1d3tLeZX/FlbR7DPHsRfys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ju0/V8sAWZWWDc+JivCbxf/xMuWtH/oYF3Ve+A15iW6P79Ky8dDhQBG2HVVDLYL/Z
         dDK3rst0hOMD//6PNuUfL8dGm9n0frHZO9vuU3LWlKAQFYbi+rRoaQCmCaJq2rm7zf
         mZJpR5tBMBOfbUcG50+JIecYbAi8v8VKxCjm5XL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 459/663] spi: qup: Dont skip cleanup in removes error path
Date:   Mon,  8 May 2023 11:44:45 +0200
Message-Id: <20230508094443.020376142@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 61f49171a43ab1f80c73c5c88c508770c461e0f2 ]

Returning early in a platform driver's remove callback is wrong. In this
case the dma resources are not released in the error path. this is never
retried later and so this is a permanent leak. To fix this, only skip
hardware disabling if waking the device fails.

Fixes: 64ff247a978f ("spi: Add Qualcomm QUP SPI controller support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20230330210341.2459548-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-qup.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 678dc51ef0174..205e54f157b4a 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1277,18 +1277,22 @@ static int spi_qup_remove(struct platform_device *pdev)
 	struct spi_qup *controller = spi_master_get_devdata(master);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret < 0)
-		return ret;
+	ret = pm_runtime_get_sync(&pdev->dev);
 
-	ret = spi_qup_set_state(controller, QUP_STATE_RESET);
-	if (ret)
-		return ret;
+	if (ret >= 0) {
+		ret = spi_qup_set_state(controller, QUP_STATE_RESET);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to reset controller (%pe)\n",
+				 ERR_PTR(ret));
 
-	spi_qup_release_dma(master);
+		clk_disable_unprepare(controller->cclk);
+		clk_disable_unprepare(controller->iclk);
+	} else {
+		dev_warn(&pdev->dev, "failed to resume, skip hw disable (%pe)\n",
+			 ERR_PTR(ret));
+	}
 
-	clk_disable_unprepare(controller->cclk);
-	clk_disable_unprepare(controller->iclk);
+	spi_qup_release_dma(master);
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.39.2



