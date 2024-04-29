Return-Path: <stable+bounces-41643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35A88B566E
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BB7284295
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1F53FBA3;
	Mon, 29 Apr 2024 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oevZSeS5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8663FBAF
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389853; cv=none; b=iWiiDzFeUS5hsgCOHbpsOjCTV4qVITcOiqLObfe9h/FOBAb0mzCWKUiy280N7uw+LrdAOVY4hF8kFT8+qAAVMRffeWf05cM8BjyGM8ZsnSZNfnk5red2bZF7B+kRjpu4wJO54YnQtBMAlJKttwAlwDNBWTYeO543awq0c0jyNXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389853; c=relaxed/simple;
	bh=by/p0VSkZVx1idGO2KT/ng4lkvOCDuJ/gcViIiaG5F0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=auwolBDgVjDJuiwx4yGgaeuMDxUuj7wAayLATrXC//KlwlpGL6RjuW0MEypQr6jvaBX8OezoR05VOckP7C8snn4Ha3oJ+81HrrP8Yxv0J7oUxvJljhqggnUngTtKU4IPUQayMF4+Env0C0xiE/YHba5PpJgfSIaf0V9uRny6Lps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oevZSeS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD9FC113CD;
	Mon, 29 Apr 2024 11:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714389853;
	bh=by/p0VSkZVx1idGO2KT/ng4lkvOCDuJ/gcViIiaG5F0=;
	h=Subject:To:Cc:From:Date:From;
	b=oevZSeS5dUL61F2oyxbtWoU8R/jGJVThH6a7Sf2EkNhGrR15t3er9jZUogmuLxIpx
	 ZjJzgr3nXdra6FlVmndXAIE5p60c4B9AIbVqj15y06u60DiQ9OdSXgm4nce5f+8MqD
	 V+Og498/jol/tLRvziYU73IfBHnUhIsDcyM00cK0=
Subject: FAILED: patch "[PATCH] mmc: sdhci-msm: pervent access to suspended controller" failed to apply to 5.10-stable tree
To: mantas@8devices.com,adrian.hunter@intel.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:24:10 +0200
Message-ID: <2024042910-obnoxious-sleep-f776@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f8def10f73a516b771051a2f70f2f0446902cb4f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042910-obnoxious-sleep-f776@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

f8def10f73a5 ("mmc: sdhci-msm: pervent access to suspended controller")
c93767cf64eb ("mmc: sdhci-msm: add Inline Crypto Engine support")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f8def10f73a516b771051a2f70f2f0446902cb4f Mon Sep 17 00:00:00 2001
From: Mantas Pucka <mantas@8devices.com>
Date: Thu, 21 Mar 2024 14:30:01 +0000
Subject: [PATCH] mmc: sdhci-msm: pervent access to suspended controller

Generic sdhci code registers LED device and uses host->runtime_suspended
flag to protect access to it. The sdhci-msm driver doesn't set this flag,
which causes a crash when LED is accessed while controller is runtime
suspended. Fix this by setting the flag correctly.

Cc: stable@vger.kernel.org
Fixes: 67e6db113c90 ("mmc: sdhci-msm: Add pm_runtime and system PM support")
Signed-off-by: Mantas Pucka <mantas@8devices.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20240321-sdhci-mmc-suspend-v1-1-fbc555a64400@8devices.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 668e0aceeeba..e113b99a3eab 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2694,6 +2694,11 @@ static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	host->runtime_suspended = true;
+	spin_unlock_irqrestore(&host->lock, flags);
 
 	/* Drop the performance vote */
 	dev_pm_opp_set_rate(dev, 0);
@@ -2708,6 +2713,7 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	unsigned long flags;
 	int ret;
 
 	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
@@ -2726,7 +2732,15 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
 
 	dev_pm_opp_set_rate(dev, msm_host->clk_rate);
 
-	return sdhci_msm_ice_resume(msm_host);
+	ret = sdhci_msm_ice_resume(msm_host);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&host->lock, flags);
+	host->runtime_suspended = false;
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return ret;
 }
 
 static const struct dev_pm_ops sdhci_msm_pm_ops = {


