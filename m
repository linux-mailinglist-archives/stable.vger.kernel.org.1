Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FC778AAD2
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjH1KZ3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjH1KY6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:24:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3AF122
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:24:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0657963998
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CA2C433C7;
        Mon, 28 Aug 2023 10:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218294;
        bh=7KBXY8PHmyPTRjK33b1o89lkKocSRR5pzVWjrukTyes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nd+RDwj5re0KY1nNiEI58TD2cfiEocmcrldIkTQ3iHFfI2+yaWH4A6Ulpisjw/I6+
         FGU4iXN2aNHHp2qJNfyRu/MUFJwgBhlSMNXJpCgWhGW/Tu2uw7eixtjFIDJeyYPPBW
         UcMZO7XngstpHbsv1QMafwXRy/5cUqBVG17v7Ebg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jerome Brunet <jbrunet@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 036/129] mmc: meson-gx: remove useless lock
Date:   Mon, 28 Aug 2023 12:12:10 +0200
Message-ID: <20230828101154.454216895@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 83076d2268c72d123f3d1eaf186a9f56ec1b943a ]

The spinlock is only used within the irq handler so it does not
seem very useful.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: 3c40eb814532 ("mmc: meson-gx: remove redundant mmc_request_done() call from irq context")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/meson-gx-mmc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index dba98c2886f26..313aff92b97c9 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -26,7 +26,6 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/ioport.h>
-#include <linux/spinlock.h>
 #include <linux/dma-mapping.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -159,7 +158,6 @@ struct meson_host {
 	struct	mmc_host	*mmc;
 	struct	mmc_command	*cmd;
 
-	spinlock_t lock;
 	void __iomem *regs;
 	struct clk *core_clk;
 	struct clk *mmc_clk;
@@ -1042,8 +1040,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (WARN_ON(!host) || WARN_ON(!host->cmd))
 		return IRQ_NONE;
 
-	spin_lock(&host->lock);
-
 	cmd = host->cmd;
 	data = cmd->data;
 	cmd->error = 0;
@@ -1093,7 +1089,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 	if (ret == IRQ_HANDLED)
 		meson_mmc_request_done(host->mmc, cmd->mrq);
 
-	spin_unlock(&host->lock);
 	return ret;
 }
 
@@ -1246,8 +1241,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	host->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, host);
 
-	spin_lock_init(&host->lock);
-
 	/* Get regulators and the supported OCR mask */
 	host->vqmmc_enabled = false;
 	ret = mmc_regulator_get_supply(mmc);
-- 
2.40.1



