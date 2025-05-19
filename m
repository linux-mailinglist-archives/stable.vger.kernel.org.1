Return-Path: <stable+bounces-144814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2688ABBE50
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695F817DBCB
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B6827934A;
	Mon, 19 May 2025 12:52:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE21274673;
	Mon, 19 May 2025 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747659139; cv=none; b=LYhGUZQ/hNNIpblSnmYr5I1r8s5WHLlWN0ru6FmK/TYkNTOFUpPA/9vbKprBKuPZpQr3kya1g4F65OKfQaR3Az9pQAjIbaUwo4Lfcr88YORKe1Hm2uvYUYbHkLbb3j8FRq9iWp8W5mOYd8Yjo952ImQ6kna9kpxLR4cstvTivOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747659139; c=relaxed/simple;
	bh=H87jqFivD1yS3UpW7CFdgXBtmZBcpMDV90WIyQSSJ30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yj7COGzEhcwkN92TBLhouXFpWcHhK8PdNLT8vw0x4IDPKWbm1zCUEcj/Lu7dgzWO4bkDFksG0CR9tfJVIqD81uhaE2xqnmf5/lLEseYrSwU7lDLW9mODmEF+6F6063GPejKu4DgjVWZstnLuxSKRsAn42KXVzSNRn7pdWLX4sKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowADXJfF4KStoWP5kAQ--.17254S2;
	Mon, 19 May 2025 20:52:09 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: adrian.hunter@intel.com,
	vigneshr@ti.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: sdhci-omap: Add error handling for sdhci_runtime_suspend_host()
Date: Mon, 19 May 2025 20:51:43 +0800
Message-ID: <20250519125143.2331-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADXJfF4KStoWP5kAQ--.17254S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tryftFy7ZFyDKw47tF4kCrg_yoW8XF1fpa
	nFqrWjkr4UWw1FkF4DK3Z2vr1F934rKrWjk3s5Kw18uw47trWrKanrCFyYyFy8KryrGa1k
	XF1jqrWxWFyrAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUv_M-UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwwHA2gq8-HMVwAAsU

The sdhci_omap_runtime_suspend() calls sdhci_runtime_suspend_host() but
does not handle the return value. A proper implementation can be found
in sdhci_am654_runtime_suspend().

Add error handling for sdhci_runtime_suspend_host(). Return the error
code if the suspend fails.

Fixes: f433e8aac6b9 ("mmc: sdhci-omap: Implement PM runtime functions")
Cc: stable@vger.kernel.org # v5.16
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/mmc/host/sdhci-omap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 54d795205fb4..69b2e4e5cb20 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1438,6 +1438,7 @@ static int __maybe_unused sdhci_omap_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
+	int ret;
 
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
@@ -1445,7 +1446,9 @@ static int __maybe_unused sdhci_omap_runtime_suspend(struct device *dev)
 	if (omap_host->con != -EINVAL)
 		sdhci_runtime_suspend_host(host);
 
-	sdhci_omap_context_save(omap_host);
+	ret = sdhci_omap_context_save(omap_host);
+	if (ret)
+		return ret;
 
 	pinctrl_pm_select_idle_state(dev);
 
-- 
2.42.0.windows.2


