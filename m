Return-Path: <stable+bounces-180390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38252B7FA90
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 16:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE0B1884C57
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C675319615;
	Wed, 17 Sep 2025 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3rsm5V4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFD831B12A
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117307; cv=none; b=CJvPN31UipfPx+kznMsxyyhO3Ak25hxlSyFAlQKUX1jlxoND8cRK/evr9MsZ8WEBRM3yAvCqp2/w4L8Xag0Y16q4cnpB5yiGZfKFQs4V9yN0u9CwuEoBnifhZkY6md27bBR2H+bmBgKMhSmXbBBclEZ9VHAAv/Rc3FVhdeuanF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117307; c=relaxed/simple;
	bh=cd3KJJGgQppwxQpj/M4aorAt+kkZqv1JQFIuMISv3As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYWFi64GxA3bL9ieof2qTn+g9Ozr9XXroJwqIqrFyMFMpI2mOeqK5w2yXYZNQwUssX/+EH/0Ccmfpk+cU2ji7qWO29jy4y2nCVXEuae4NOutrFXZZAwYA41xcAEdw8hUVP03QB2iMsWlVvlbCnObg4vAR8geuwzbUFmLFdx22ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3rsm5V4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FBCC4CEF0;
	Wed, 17 Sep 2025 13:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758117307;
	bh=cd3KJJGgQppwxQpj/M4aorAt+kkZqv1JQFIuMISv3As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b3rsm5V4Wlfe81h0jktY6s3YBBJEY98u+4JSKtNl4docOq6oKZi4XjfUcN+BzuuBR
	 6bBcjgHhB8a2SL9ns5ICRKHYvyW73tHDWjamD5jJMYLg67yp/u2647MxN6354orI7P
	 2QLWYm1zYB2tlHy8fgonaiHQl0EtyiX+l+zvJpYkQbHC759SUmi1iNn8Ge5055+LYL
	 xvSjG9/EVhfukrhkIV1RsRZoTPhX5mZkz8ExV0DoWmrFbyWHAbrOYSW/UknVJDSfcO
	 iegSKr+djcEs03uRzzHGNiZBHWzDar+tf/PqfLKeIA9kr7d/GyASRp2qqqqDEUN7MJ
	 4FOjoEkwtZ2Dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/6] phy: ti: convert to devm_platform_ioremap_resource(_byname)
Date: Wed, 17 Sep 2025 09:54:58 -0400
Message-ID: <20250917135502.565547-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917135502.565547-1-sashal@kernel.org>
References: <2025091752-daycare-art-9e78@gregkh>
 <20250917135502.565547-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

[ Upstream commit 79caf207d6699419e83ac150accc5c80c5719b47 ]

Use devm_platform_ioremap_resource(_byname) to simplify code

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Link: https://lore.kernel.org/r/1604642930-29019-17-git-send-email-chunfeng.yun@mediatek.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 64961557efa1 ("phy: ti: omap-usb2: fix device leak at unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/ti/phy-omap-control.c | 17 ++++++-----------
 drivers/phy/ti/phy-omap-usb2.c    |  4 +---
 drivers/phy/ti/phy-ti-pipe3.c     | 15 ++++-----------
 3 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/ti/phy-omap-control.c b/drivers/phy/ti/phy-omap-control.c
index ccd0e4e00451a..47482f106fab3 100644
--- a/drivers/phy/ti/phy-omap-control.c
+++ b/drivers/phy/ti/phy-omap-control.c
@@ -268,7 +268,6 @@ MODULE_DEVICE_TABLE(of, omap_control_phy_id_table);
 
 static int omap_control_phy_probe(struct platform_device *pdev)
 {
-	struct resource	*res;
 	const struct of_device_id *of_id;
 	struct omap_control_phy *control_phy;
 
@@ -285,16 +284,13 @@ static int omap_control_phy_probe(struct platform_device *pdev)
 	control_phy->type = *(enum omap_control_phy_type *)of_id->data;
 
 	if (control_phy->type == OMAP_CTRL_TYPE_OTGHS) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-			"otghs_control");
-		control_phy->otghs_control = devm_ioremap_resource(
-			&pdev->dev, res);
+		control_phy->otghs_control =
+			devm_platform_ioremap_resource_byname(pdev, "otghs_control");
 		if (IS_ERR(control_phy->otghs_control))
 			return PTR_ERR(control_phy->otghs_control);
 	} else {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-				"power");
-		control_phy->power = devm_ioremap_resource(&pdev->dev, res);
+		control_phy->power =
+			devm_platform_ioremap_resource_byname(pdev, "power");
 		if (IS_ERR(control_phy->power)) {
 			dev_err(&pdev->dev, "Couldn't get power register\n");
 			return PTR_ERR(control_phy->power);
@@ -312,9 +308,8 @@ static int omap_control_phy_probe(struct platform_device *pdev)
 	}
 
 	if (control_phy->type == OMAP_CTRL_TYPE_PCIE) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "pcie_pcs");
-		control_phy->pcie_pcs = devm_ioremap_resource(&pdev->dev, res);
+		control_phy->pcie_pcs =
+			devm_platform_ioremap_resource_byname(pdev, "pcie_pcs");
 		if (IS_ERR(control_phy->pcie_pcs))
 			return PTR_ERR(control_phy->pcie_pcs);
 	}
diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index 95e72f7a3199d..59d3a692c7255 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -366,7 +366,6 @@ static int omap_usb2_probe(struct platform_device *pdev)
 {
 	struct omap_usb	*phy;
 	struct phy *generic_phy;
-	struct resource *res;
 	struct phy_provider *phy_provider;
 	struct usb_otg *otg;
 	struct device_node *node = pdev->dev.of_node;
@@ -403,8 +402,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 
 	omap_usb2_init_errata(phy);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	phy->phy_base = devm_ioremap_resource(&pdev->dev, res);
+	phy->phy_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(phy->phy_base))
 		return PTR_ERR(phy->phy_base);
 
diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index e9332c90f75f5..2cbc91e535d46 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -745,35 +745,28 @@ static int ti_pipe3_get_sysctrl(struct ti_pipe3 *phy)
 
 static int ti_pipe3_get_tx_rx_base(struct ti_pipe3 *phy)
 {
-	struct resource *res;
 	struct device *dev = phy->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "phy_rx");
-	phy->phy_rx = devm_ioremap_resource(dev, res);
+	phy->phy_rx = devm_platform_ioremap_resource_byname(pdev, "phy_rx");
 	if (IS_ERR(phy->phy_rx))
 		return PTR_ERR(phy->phy_rx);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "phy_tx");
-	phy->phy_tx = devm_ioremap_resource(dev, res);
+	phy->phy_tx = devm_platform_ioremap_resource_byname(pdev, "phy_tx");
 
 	return PTR_ERR_OR_ZERO(phy->phy_tx);
 }
 
 static int ti_pipe3_get_pll_base(struct ti_pipe3 *phy)
 {
-	struct resource *res;
 	struct device *dev = phy->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 
 	if (phy->mode == PIPE3_MODE_PCIE)
 		return 0;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "pll_ctrl");
-	phy->pll_ctrl_base = devm_ioremap_resource(dev, res);
+	phy->pll_ctrl_base =
+		devm_platform_ioremap_resource_byname(pdev, "pll_ctrl");
 	return PTR_ERR_OR_ZERO(phy->pll_ctrl_base);
 }
 
-- 
2.51.0


