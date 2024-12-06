Return-Path: <stable+bounces-98967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8D39E6A8D
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BBB16BE5D
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F161F12F9;
	Fri,  6 Dec 2024 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rZpyyE0u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C301F03F6
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477983; cv=none; b=oM4g6D5nKwptv/E5g72PKoC5xn09XyXZA43x61x21NdkrS7sFdf8WZgF7wpTFk7QYQTOB1gN7DxPPVXriWwo1GbFZTuYSx3bjC3jFU2xbSoTay+fhuB3ivVZk5Hl15YTjDUMS0WJuvLG3kd91MpuC8KUtCn5Y6/ZpJmOeq8mQ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477983; c=relaxed/simple;
	bh=eAiYsS7S5d7CdTlBfQfM8hL1Y/4MHbubOxWne6ZCKME=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YKksGFy8iKP5IplclTPyh2Ff4gG5gnOzQye4nTa9mgybVZKdPHmziLrA2zphBM2EEeKgp3CrA3oRLebd9pvl6bS4Sxii5zYE0crFCKsDCrGRpxx5Rxm/1QaLdUv2RwsbLpV/8dGNaTSCHtwB3vUNGukxka3+B/WB5YEqXa7dNjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rZpyyE0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79E7C4CED1;
	Fri,  6 Dec 2024 09:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733477983;
	bh=eAiYsS7S5d7CdTlBfQfM8hL1Y/4MHbubOxWne6ZCKME=;
	h=Subject:To:Cc:From:Date:From;
	b=rZpyyE0uAOnxLeTQhXzGPOsuPNLKt4ZHoR9asDVdR4wcerARIX+y0JcY2KHDzhDOB
	 lyrbDmG5wc2mx46KG2hVfAPW3kPpzuC5Z9T0t8iFsHwVBrzwlm1DCMt36dgfeuDFmr
	 GX8F9ZrLnBk2l0tJn7j6+iNWM9LTEnpqmD0G+mfc=
Subject: FAILED: patch "[PATCH] mmc: mtk-sd: Fix error handle of probe function" failed to apply to 6.1-stable tree
To: andy-ld.lu@mediatek.com,angelogioacchino.delregno@collabora.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 10:39:31 +0100
Message-ID: <2024120631-silencer-campsite-c49e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 291220451c775a054cedc4fab4578a1419eb6256
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120631-silencer-campsite-c49e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 291220451c775a054cedc4fab4578a1419eb6256 Mon Sep 17 00:00:00 2001
From: Andy-ld Lu <andy-ld.lu@mediatek.com>
Date: Thu, 7 Nov 2024 20:11:21 +0800
Subject: [PATCH] mmc: mtk-sd: Fix error handle of probe function

In the probe function, it goes to 'release_mem' label and returns after
some procedure failure. But if the clocks (partial or all) have been
enabled previously, they would not be disabled in msdc_runtime_suspend,
since runtime PM is not yet enabled for this case.

That cause mmc related clocks always on during system suspend and block
suspend flow. Below log is from a SDCard issue of MT8196 chromebook, it
returns -ETIMEOUT while polling clock stable in the msdc_ungate_clock()
and probe failed, but the enabled clocks could not be disabled anyway.

[  129.059253] clk_chk_dev_pm_suspend()
[  129.350119] suspend warning: msdcpll is on
[  129.354494] [ck_msdc30_1_sel : enabled, 1, 1, 191999939,   ck_msdcpll_d2]
[  129.362787] [ck_msdcpll_d2   : enabled, 1, 1, 191999939,         msdcpll]
[  129.371041] [ck_msdc30_1_ck  : enabled, 1, 1, 191999939, ck_msdc30_1_sel]
[  129.379295] [msdcpll         : enabled, 1, 1, 383999878,          clk26m]

Add a new 'release_clk' label and reorder the error handle functions to
make sure the clocks be disabled after probe failure.

Fixes: ffaea6ebfe9c ("mmc: mtk-sd: Use readl_poll_timeout instead of open-coded polling")
Fixes: 7a2fa8eed936 ("mmc: mtk-sd: use devm_mmc_alloc_host")
Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: stable@vger.kernel.org
Message-ID: <20241107121215.5201-1-andy-ld.lu@mediatek.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index a2750a45c1b7..022526a1f754 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -3007,7 +3007,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	ret = msdc_ungate_clock(host);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot ungate clocks!\n");
-		goto release_mem;
+		goto release_clk;
 	}
 	msdc_init_hw(host);
 
@@ -3017,14 +3017,14 @@ static int msdc_drv_probe(struct platform_device *pdev)
 					     GFP_KERNEL);
 		if (!host->cq_host) {
 			ret = -ENOMEM;
-			goto release_mem;
+			goto release;
 		}
 		host->cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
 		host->cq_host->mmio = host->base + 0x800;
 		host->cq_host->ops = &msdc_cmdq_ops;
 		ret = cqhci_init(host->cq_host, mmc, true);
 		if (ret)
-			goto release_mem;
+			goto release;
 		mmc->max_segs = 128;
 		/* cqhci 16bit length */
 		/* 0 size, means 65536 so we don't have to -1 here */
@@ -3064,9 +3064,10 @@ static int msdc_drv_probe(struct platform_device *pdev)
 end:
 	pm_runtime_disable(host->dev);
 release:
-	platform_set_drvdata(pdev, NULL);
 	msdc_deinit_hw(host);
+release_clk:
 	msdc_gate_clock(host);
+	platform_set_drvdata(pdev, NULL);
 release_mem:
 	if (host->dma.gpd)
 		dma_free_coherent(&pdev->dev,


