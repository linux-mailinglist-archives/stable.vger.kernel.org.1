Return-Path: <stable+bounces-34707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0790C894076
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387A31C21461
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F51228DC0;
	Mon,  1 Apr 2024 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="le4CrF90"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD491E895;
	Mon,  1 Apr 2024 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989026; cv=none; b=gm4QaYub0VReAzk2/0cJUmxt1PeGpzkiQhQxe/95ZGl1402nod3JKsnpURUxypcDGF31UEdrSto+mIhlJCoPZTmgapt5nKnBBr4cgA0Yilw/Kdx0gKzhSgFeq2s/tAOfaPw3M+0NJKUf5tT6ue5ibKSizxIXND+o6FcuktOTxtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989026; c=relaxed/simple;
	bh=XMCXttr31Sub386wh6tw2QiUGYptidUatY/cO77uR3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0qzua8EpN+8sO14fRrcJ1EPQndUyFOLZBgeNT0hWV5XNNp63DNsM7j3rjKoCStqfKxJfuyo38B+9ZKh9FM8Zuw29MfgqMco1maJJqQJvSvNQjvWk0+d2uSY6DRg/xTP+UrRuMTAlTLr6Skg1OFLzKCsYdEyeUdfhFb0ZsbREvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=le4CrF90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2A6C433F1;
	Mon,  1 Apr 2024 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989026;
	bh=XMCXttr31Sub386wh6tw2QiUGYptidUatY/cO77uR3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=le4CrF90dNRDjwcMS4cJBm1b16xjgGBNEUwXu6Py4cBIQvD9MIIdZcNARWHhYjsS0
	 p3cvtsK8B5PuvpVMWa41Ry8tCiq3iuGqEyUyJVDmODzDKaQXpVlZVhSdSpGhHhYfOz
	 2WnoQAfjcBc684xUEPyK09f+H3AejbfJcBf27AnQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Thompson <davthompson@nvidia.com>,
	Liming Sun <limings@nvidia.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.7 360/432] sdhci-of-dwcmshc: disable PM runtime in dwcmshc_remove()
Date: Mon,  1 Apr 2024 17:45:47 +0200
Message-ID: <20240401152604.005737151@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liming Sun <limings@nvidia.com>

commit 03749309909935070253accab314288d332a204d upstream.

This commit disables PM runtime in dwcmshc_remove() to avoid the
error message below when reloading the sdhci-of-dwcmshc.ko

  sdhci-dwcmshc MLNXBF30:00: Unbalanced pm_runtime_enable!

Fixes: 48fe8fadbe5e ("mmc: sdhci-of-dwcmshc: Add runtime PM operations")
Reviewed-by: David Thompson <davthompson@nvidia.com>
Signed-off-by: Liming Sun <limings@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/b9155963ffb12d18375002bf9ac9a3f98b727fc8.1710854108.git.limings@nvidia.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -584,6 +584,17 @@ free_pltfm:
 	return err;
 }
 
+static void dwcmshc_disable_card_clk(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	if (ctrl & SDHCI_CLOCK_CARD_EN) {
+		ctrl &= ~SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
+	}
+}
+
 static void dwcmshc_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
@@ -591,8 +602,14 @@ static void dwcmshc_remove(struct platfo
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	struct rk35xx_priv *rk_priv = priv->priv;
 
+	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
 	sdhci_remove_host(host, 0);
 
+	dwcmshc_disable_card_clk(host);
+
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
 	if (rk_priv)
@@ -683,17 +700,6 @@ static void dwcmshc_enable_card_clk(stru
 		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
 	}
 }
-
-static void dwcmshc_disable_card_clk(struct sdhci_host *host)
-{
-	u16 ctrl;
-
-	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	if (ctrl & SDHCI_CLOCK_CARD_EN) {
-		ctrl &= ~SDHCI_CLOCK_CARD_EN;
-		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
-	}
-}
 
 static int dwcmshc_runtime_suspend(struct device *dev)
 {



