Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B7E7BE028
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376377AbjJINiH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377239AbjJINiG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:38:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2649C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:38:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44CDC433C9;
        Mon,  9 Oct 2023 13:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858684;
        bh=LTsg5uqiHL8IZMCQcdsqf1TqhVzLLt6/JA4XQF3YnDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9jxJNZ6vJGbqe54NPwOn/TdCDuRzINdnZAwXT4GNNYjnBKnEUh7LLYLEOpSCU1jS
         /4hQxMWoTlxxnMiVT0II6+r0bHR3tZCpXDCPRLoq2z0sdQfcySkYTm5snRPC4Xi5kH
         4qIRMUSfyvLQRkSkHE1PWrtAbG8k3cOLPGUjS+7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 068/226] mmc: tmio: support custom irq masks
Date:   Mon,  9 Oct 2023 15:00:29 +0200
Message-ID: <20231009130128.559156482@linuxfoundation.org>
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

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 0d856c4c68c639f96cb12c26aaeb906353b9a76e ]

SDHI Gen2+ has a different value for TMIO_MASK_ALL, so add a member to
support that. If the member is not used, the previous default value is
applied.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20210223100830.25125-2-wsa+renesas@sang-engineering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: 74f45de394d9 ("mmc: renesas_sdhi: register irqs before registering controller")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/tmio_mmc.h      | 1 +
 drivers/mmc/host/tmio_mmc_core.c | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 9546e542619cb..d6ed5e1f8386e 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -161,6 +161,7 @@ struct tmio_mmc_host {
 	u32			sdio_irq_mask;
 	unsigned int		clk_cache;
 	u32			sdcard_irq_setbit_mask;
+	u32			sdcard_irq_mask_all;
 
 	spinlock_t		lock;		/* protect host private data */
 	unsigned long		last_req_ts;
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index ac4e7874a3f13..abf36acb2641f 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1158,7 +1158,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	tmio_mmc_reset(_host);
 
 	_host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
-	tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
+	if (!_host->sdcard_irq_mask_all)
+		_host->sdcard_irq_mask_all = TMIO_MASK_ALL;
+	tmio_mmc_disable_mmc_irqs(_host, _host->sdcard_irq_mask_all);
 
 	if (_host->native_hotplug)
 		tmio_mmc_enable_mmc_irqs(_host,
@@ -1212,7 +1214,7 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 	cancel_work_sync(&host->done);
 	cancel_delayed_work_sync(&host->delayed_reset_work);
 	tmio_mmc_release_dma(host);
-	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
+	tmio_mmc_disable_mmc_irqs(host, host->sdcard_irq_mask_all);
 
 	if (host->native_hotplug)
 		pm_runtime_put_noidle(&pdev->dev);
@@ -1242,7 +1244,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 {
 	struct tmio_mmc_host *host = dev_get_drvdata(dev);
 
-	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
+	tmio_mmc_disable_mmc_irqs(host, host->sdcard_irq_mask_all);
 
 	if (host->clk_cache)
 		host->set_clock(host, 0);
-- 
2.40.1



