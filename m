Return-Path: <stable+bounces-145782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F989ABEE1B
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 10:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773F24E2069
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 08:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D212376F4;
	Wed, 21 May 2025 08:39:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E983B2367C0;
	Wed, 21 May 2025 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816768; cv=none; b=Y/ok+5i+tBx6fWLnY1P66yvQ1j00799DbhqMqqHgcTBnJlUkEsCQTy5lPl7GI5S6K8PWxw4+8lh7+fk0XzfnAEHpClGIa05Af+TIDSIVx5epnSPSXTnhj15MiKppezAejA+8J0SqAVpR/v5o4kSOH69edSUHqQCWUA/MxfrkctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816768; c=relaxed/simple;
	bh=7zLmzQ7OpMriiPhIS/LNVnD+rTOcckAQUownjGSaiS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sMaBu76wrO4PXMsW07aXz2xoBTrAUKz4OzeAvKmoWt88xaSAEUPalmmixkeGZJfEHz2rYO4u/TRS4e4yA3FYU+xMvKQdYK1MY2b/uV5FDdh//K1sVgrE+EYhPiT+wG5wI5G6O0HHFiaGzHESQN6D56AOsSz0Jgp1dKOwfGnOUNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowAAXf74pkS1oZuXmAQ--.4439S2;
	Wed, 21 May 2025 16:39:11 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: adrian.hunter@intel.com,
	vigneshr@ti.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci-omap: Add error handling for sdhci_runtime_suspend_host()
Date: Wed, 21 May 2025 16:38:46 +0800
Message-ID: <20250521083846.718-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAXf74pkS1oZuXmAQ--.4439S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tryftFy7ZFyDKw47tF4kCrg_yoW8Gw13pa
	n0grW29r48Ww1FkF4kJan2vryFg345KrWjy3s8Xw1ruw4IkrW5KFsrCFyYvF1UKr13Ganr
	XF18XayUCFyYyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUej
	jgDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAUJA2gtfVNegQABs2

The sdhci_omap_runtime_suspend() calls sdhci_runtime_suspend_host() but
does not handle the return value. A proper implementation can be found
in sdhci_am654_runtime_suspend().

Add error handling for sdhci_runtime_suspend_host(). Return the error
code if the suspend fails.

Fixes: 51189eb9ddc8 ("mmc: sdhci-omap: Fix a lockdep warning for PM runtime init")
Cc: stable@vger.kernel.org # 5.19
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
v2: Fix code error.

 drivers/mmc/host/sdhci-omap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 54d795205fb4..f09f78cf244d 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1438,12 +1438,16 @@ static int __maybe_unused sdhci_omap_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
+	int ret;
 
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
 
-	if (omap_host->con != -EINVAL)
-		sdhci_runtime_suspend_host(host);
+	if (omap_host->con != -EINVAL) {
+		ret = sdhci_runtime_suspend_host(host);
+		if (ret)
+			return ret;
+	}
 
 	sdhci_omap_context_save(omap_host);
 
-- 
2.42.0.windows.2


