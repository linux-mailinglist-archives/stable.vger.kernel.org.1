Return-Path: <stable+bounces-144796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8ACABBDF9
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F02189F5A8
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B04278E42;
	Mon, 19 May 2025 12:35:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4468F278E7B;
	Mon, 19 May 2025 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658149; cv=none; b=nNxKQYQMejuUTRdDQVlUkBAZXoa4ySw0G9Zvt658dFH22XxFlbGXMU6sQyP2bT8y8zxng3d6inwNtwvRK86ImeQ0vE4wjrf/89+A25h8pTMnAxnlnzjpapRyX7B6quFKa9U9BIgls0PDO3qL7trvXWZ7UYPxHtmk5ary5+DYBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658149; c=relaxed/simple;
	bh=tQcVxlLI9bM+pe7af0fXzLng2vNzXhJRM2jTEWPjDFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mUHlCOsmxWPOJQdl8/7/p0g5RpH+BYoOGpHFLogppskGtB3cRiZNdIGlGWSduHDx4V9ARkpNBZDzoMpsxKHJk4P7dj5SRnb/7rS0tRWLkF2bSCuXyvOuhkbmdxRmawX7vi8hO2MT7eP/1BZOHHzs191mRfIsh8Z+gG0u2CtfDhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowABXa_aZJStow+1jAQ--.14873S2;
	Mon, 19 May 2025 20:35:41 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	orsonzhai@gmail.com,
	baolin.wang@linux.alibaba.com,
	zhang.lyra@gmail.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: sdhci-sprd: Add error handling for sdhci_runtime_suspend_host()
Date: Mon, 19 May 2025 20:33:47 +0800
Message-ID: <20250519123347.2242-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXa_aZJStow+1jAQ--.14873S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZF1UCw4DJF4xKw1UGr4rKrg_yoW8JF18pa
	yagrW29w1UWw1FkF1DG3WkZr1rW34rKrWUKrZ8Xw18Wa1UK34rKrW3CFyjqFyjkr9xGa1U
	XF1qq3y5CFyUAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFylc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUlApnUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoHA2gq8-Gx-wABsG

The dhci_sprd_runtime_suspend() calls sdhci_runtime_suspend_host() but
does not handle the return value. A proper implementation can be found
in sdhci_am654_runtime_suspend().

Add error handling for sdhci_runtime_suspend_host(). Return the error
code if the suspend fails.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
Cc: stable@vger.kernel.org # v4.20
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/mmc/host/sdhci-sprd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index db5e253b0f79..dd41427e973a 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -922,9 +922,12 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
+	int ret;
 
 	mmc_hsq_suspend(host->mmc);
-	sdhci_runtime_suspend_host(host);
+	ret = sdhci_runtime_suspend_host(host);
+	if (ret)
+		return ret;
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
 	clk_disable_unprepare(sprd_host->clk_enable);
-- 
2.42.0.windows.2


