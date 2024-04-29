Return-Path: <stable+bounces-41644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 406CB8B5671
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB03B2341C
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA56C3FB9B;
	Mon, 29 Apr 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NwVRAXl/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8113DB8E
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389862; cv=none; b=NWoMEYSH085ur9zrfuvR06pHhYEHe1Utrd852ZaMlZR7XrWfSV/YKoAB69HCQimT91TwDwVoQSVHgNTwkb4i7Ca2/adpm9fEeiqTbDGtzD6+5+FRRZxIckwDj9S9Oc1vBSOkJ+aKaiuPdFcBUxTC2b1C+6+S2zm5gIzhpRPcWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389862; c=relaxed/simple;
	bh=8qQmGZzccPlXDRW/CRcPw0ObSwEyjkuwNgfKWTa8Y/I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CnPAJ+YmX9Y4dLTFlhuxFHZd+RTdpVM6rZFvNHC8K5c3siQrie/vEDSWfPZZ878mWwxO77xl1xqo9o8NhPMcIq9JdmoxJIuqqEZ+eVMcsPHcHd/mYS3ay6/qc/7OV1OcTZyUfTmOFND1qyPgl4E0btKp1DELLqcXM+irRxx44bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NwVRAXl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01266C113CD;
	Mon, 29 Apr 2024 11:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714389862;
	bh=8qQmGZzccPlXDRW/CRcPw0ObSwEyjkuwNgfKWTa8Y/I=;
	h=Subject:To:Cc:From:Date:From;
	b=NwVRAXl/iLbFJlTCr9ZrFQy4Rc8gwbQjGOVi4ya0xZk5aR2dLexfCmsxFZHBWAB1k
	 I0NzKFnN0wfxMIGRdxU12CtxLB2Bmg76UZkOKxqH9AwldZpKNeiosFsLG6dDa2RC4k
	 fK1xfaK8pHimOKkczSNCDKX1sfxNB5wKbrfA67T4=
Subject: FAILED: patch "[PATCH] mmc: sdhci-msm: pervent access to suspended controller" failed to apply to 5.4-stable tree
To: mantas@8devices.com,adrian.hunter@intel.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:24:11 +0200
Message-ID: <2024042911-librarian-armory-e9db@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x f8def10f73a516b771051a2f70f2f0446902cb4f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042911-librarian-armory-e9db@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

f8def10f73a5 ("mmc: sdhci-msm: pervent access to suspended controller")
c93767cf64eb ("mmc: sdhci-msm: add Inline Crypto Engine support")
0472f8d3c054 ("mmc: sdhci-msm: Use OPP API to set clk/perf state")
9051db381fab ("mmc: sdhci-msm: Mark sdhci_msm_cqe_disable static")
87a8df0dce6a ("mmc: sdhci-msm: Add CQHCI support for sdhci-msm")

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


