Return-Path: <stable+bounces-106909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D77A02949
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0183A4D14
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1352B14900B;
	Mon,  6 Jan 2025 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qSOo3y8k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF18136E09;
	Mon,  6 Jan 2025 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176877; cv=none; b=WbWg2v+NQtZ3xahs/inP0gimpXbVpGd063llZrmH/ma1TGKfuOTN1gbgj8+9pYzC6JntElmHU3VQjdikRRMbn6UZzP4YCr720yhg43avpIaLYW9dTt1GrjIZQK6aitul3VWNde9c7U6o7dBCED6PlBnqfRS3JZ6CyoJ+B6raisE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176877; c=relaxed/simple;
	bh=2gFief8vLeOr+4ci3sYDNeKlDYLRILCBRoJM77oKhsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ly2XxjauYg8DV6iY5NOxr1Dq0W6zRPldu5QL36Dsk4fV/bVXjsq4v30ErfFibFXc0zS2YAgnH8lU8uk5e0K8faM30E1InQ9luXP7i5Q7wOF4HsNRtWdi+cabgujiAVMzBlul3YaVE9pkN/5QRHBbxq5qLJ0DRY8XBTyWv189rUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qSOo3y8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B11C4CEDF;
	Mon,  6 Jan 2025 15:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736176877;
	bh=2gFief8vLeOr+4ci3sYDNeKlDYLRILCBRoJM77oKhsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSOo3y8kNnLcy5ezWwrIDNfVqBsKYfzwwh4C+4NNmrfQL0BjhBtrbY3/kOJTSLwlk
	 PQRQU/ArM07l3RketkNUz1Cs1PUrzX2oUVs+L3oaFEyXLaAPOgWOMsr4aYm+3kICUD
	 AEYT1kjGbA22vWUfeBfgWGmc9VeaxyNmG3bcafq0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 28/81] net: stmmac: restructure the error path of stmmac_probe_config_dt()
Date: Mon,  6 Jan 2025 16:16:00 +0100
Message-ID: <20250106151130.501327358@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151129.433047073@linuxfoundation.org>
References: <20250106151129.433047073@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

[ Upstream commit 2b6ffcd7873b7e8a62c3e15a6f305bfc747c466b ]

Current implementation of stmmac_probe_config_dt() does not release the
OF node reference obtained by of_parse_phandle() in some error paths.
The problem is that some error paths call stmmac_remove_config_dt() to
clean up but others use and unwind ladder.  These two types of error
handling have not kept in sync and have been a recurring source of bugs.
Re-write the error handling in stmmac_probe_config_dt() to use an unwind
ladder. Consequently, stmmac_remove_config_dt() is not needed anymore,
thus remove it.

This bug was found by an experimental verification tool that I am
developing.

Fixes: 4838a5405028 ("net: stmmac: Fix wrapper drivers not detecting PHY")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Link: https://patch.msgid.link/20241219024119.2017012-1-joe@pf.is.s.u-tokyo.ac.jp
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index e7e7d388399d..c368ef3cd9cb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -473,8 +473,10 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
 
 	rc = stmmac_mdio_setup(plat, np, &pdev->dev);
-	if (rc)
-		return ERR_PTR(rc);
+	if (rc) {
+		ret = ERR_PTR(rc);
+		goto error_put_phy;
+	}
 
 	of_property_read_u32(np, "tx-fifo-depth", &plat->tx_fifo_size);
 
@@ -560,8 +562,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*dma_cfg),
 			       GFP_KERNEL);
 	if (!dma_cfg) {
-		stmmac_remove_config_dt(pdev, plat);
-		return ERR_PTR(-ENOMEM);
+		ret = ERR_PTR(-ENOMEM);
+		goto error_put_mdio;
 	}
 	plat->dma_cfg = dma_cfg;
 
@@ -589,8 +591,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 
 	rc = stmmac_mtl_setup(pdev, plat);
 	if (rc) {
-		stmmac_remove_config_dt(pdev, plat);
-		return ERR_PTR(rc);
+		ret = ERR_PTR(rc);
+		goto error_put_mdio;
 	}
 
 	/* clock setup */
@@ -642,6 +644,10 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	clk_disable_unprepare(plat->pclk);
 error_pclk_get:
 	clk_disable_unprepare(plat->stmmac_clk);
+error_put_mdio:
+	of_node_put(plat->mdio_node);
+error_put_phy:
+	of_node_put(plat->phy_node);
 
 	return ret;
 }
@@ -650,16 +656,17 @@ static void devm_stmmac_remove_config_dt(void *data)
 {
 	struct plat_stmmacenet_data *plat = data;
 
-	/* Platform data argument is unused */
-	stmmac_remove_config_dt(NULL, plat);
+	clk_disable_unprepare(plat->stmmac_clk);
+	clk_disable_unprepare(plat->pclk);
+	of_node_put(plat->mdio_node);
+	of_node_put(plat->phy_node);
 }
 
 /**
  * devm_stmmac_probe_config_dt
  * @pdev: platform_device structure
  * @mac: MAC address to use
- * Description: Devres variant of stmmac_probe_config_dt(). Does not require
- * the user to call stmmac_remove_config_dt() at driver detach.
+ * Description: Devres variant of stmmac_probe_config_dt().
  */
 struct plat_stmmacenet_data *
 devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
-- 
2.39.5




