Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C456FA8CB
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjEHKpa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbjEHKpK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:45:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D5929FC2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:43:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FD6B6287C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CBFC433EF;
        Mon,  8 May 2023 10:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542637;
        bh=43666/G+TnWCxHh4nVKlMFL5r4vj5+R7krXVU1tnewo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7YSRSJM01Vugs5cZuv7I0iB/gQ4910o8b7QL3szwxM+7oyUp+Fe6ozUFJxDZ8lvI
         Rg+/zTHy6epbeHmBQlQFAprYi3RuADLqbk02gGxM13i2izaQzZOrETMwBUJ53al4wL
         nJi5i7DascXS0tjMx492tq3e+ZeVVxyx5KuNQve8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dhruva Gole <d-gole@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 500/663] spi: bcm63xx: remove PM_SLEEP based conditional compilation
Date:   Mon,  8 May 2023 11:45:26 +0200
Message-Id: <20230508094444.763317964@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

[ Upstream commit 25f0617109496e1aff49594fbae5644286447a0f ]

Get rid of conditional compilation based on CONFIG_PM_SLEEP because
it may introduce build issues with certain configs where it maybe disabled
This is because if above config is not enabled the suspend-resume
functions are never part of the code but the bcm63xx_spi_pm_ops struct
still inits them to non-existent suspend-resume functions.

Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")

Signed-off-by: Dhruva Gole <d-gole@ti.com>
Link: https://lore.kernel.org/r/20230420121615.967487-1-d-gole@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm63xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 3686d78c44a6d..974c96c27a602 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -629,7 +629,6 @@ static int bcm63xx_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int bcm63xx_spi_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
@@ -656,7 +655,6 @@ static int bcm63xx_spi_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops bcm63xx_spi_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(bcm63xx_spi_suspend, bcm63xx_spi_resume)
-- 
2.39.2



