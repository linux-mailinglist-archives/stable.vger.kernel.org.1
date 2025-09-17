Return-Path: <stable+bounces-180389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2A6B7FA33
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AE9620335
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282BC328977;
	Wed, 17 Sep 2025 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWtbEuTF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C032341C
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117306; cv=none; b=OxiuUz+8s9nro5D74kM7fRkVkS4Nwqb24sKmmETo9T2bDi3kWfkdsCK/8Kcvg8UOE8DZxaw9iHnOZcUFhL7+Pjkn07pw04x4XOrAhIWDKttIZn0E95+25UYSciBjc3ddoZzVDjug6kPxPWyghrT+15tWapGGu+wU61R7aY0DICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117306; c=relaxed/simple;
	bh=McRlF58UUwZdpdPSlm7NP+9M8PshMvAenuqLPjsBhl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojXR71aE/uGUzur/I0iebrrRhxbGdQss7Uvtp1cqX4A1faCuWiSaPvQX0/S4lmYo0IJB6sZZ8NdQpadxDVLXPtETcVdipmvnkt0rihxAu1eNUG5vlZjy8z07EydrPUcynctk0Q5yx9Jwd7ON9Ps+RZ67CNgNIvdO0prkDJhmOvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWtbEuTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB15DC4CEE7;
	Wed, 17 Sep 2025 13:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758117306;
	bh=McRlF58UUwZdpdPSlm7NP+9M8PshMvAenuqLPjsBhl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWtbEuTF0PHSQDhe9cdOAXwkFeDYl7hYkOZVOVjJN6P3FP1BkmNwq8kJAJwUSMsOo
	 XTBjyjFb0O9ctXEvqnmWJbR49/1q0WvmJUgWFvSnBIB7/0S+4UxfXoLOG3ZzJHazKD
	 h2j1f5Dg1AB6MzAxYbL1kGpGvpCDzcV0U3HU/g2dLWs4P7q5QIrTtrdeD6sOhtFeAj
	 b3qZfZcii3cZ/We+DtJArztSQrQDTdJ13u/Q5kkrXOc5QQRo3kEv2Qs1DjwWEDPfPd
	 JsWkmN0U9UqtfAH41XT+YhAH/8GV2WSlnLn54cxvyF2rIUDzh17KF5O0DDVkSvW6DP
	 zjcTjKwYSPpnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Al Cooper <alcooperx@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/6] phy: broadcom: convert to devm_platform_ioremap_resource(_byname)
Date: Wed, 17 Sep 2025 09:54:57 -0400
Message-ID: <20250917135502.565547-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091752-daycare-art-9e78@gregkh>
References: <2025091752-daycare-art-9e78@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

[ Upstream commit f669bc8b9f7beb6b1936882a2c3670dc1bd985ba ]

Use devm_platform_ioremap_resource(_byname) to simplify code

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Al Cooper <alcooperx@gmail.com>
Link: https://lore.kernel.org/r/1604642930-29019-3-git-send-email-chunfeng.yun@mediatek.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 64961557efa1 ("phy: ti: omap-usb2: fix device leak at unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/broadcom/phy-bcm-cygnus-pcie.c |  4 +---
 drivers/phy/broadcom/phy-bcm-kona-usb2.c   |  4 +---
 drivers/phy/broadcom/phy-bcm-ns-usb2.c     |  4 +---
 drivers/phy/broadcom/phy-bcm-ns-usb3.c     |  7 ++-----
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c  | 13 ++++---------
 drivers/phy/broadcom/phy-bcm-sr-pcie.c     |  5 +----
 drivers/phy/broadcom/phy-bcm-sr-usb.c      |  4 +---
 drivers/phy/broadcom/phy-brcm-sata.c       |  8 ++------
 8 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c b/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
index b074682d9dd88..548e467761008 100644
--- a/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
+++ b/drivers/phy/broadcom/phy-bcm-cygnus-pcie.c
@@ -126,7 +126,6 @@ static int cygnus_pcie_phy_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node, *child;
 	struct cygnus_pcie_phy_core *core;
 	struct phy_provider *provider;
-	struct resource *res;
 	unsigned cnt = 0;
 	int ret;
 
@@ -141,8 +140,7 @@ static int cygnus_pcie_phy_probe(struct platform_device *pdev)
 
 	core->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	core->base = devm_ioremap_resource(dev, res);
+	core->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(core->base))
 		return PTR_ERR(core->base);
 
diff --git a/drivers/phy/broadcom/phy-bcm-kona-usb2.c b/drivers/phy/broadcom/phy-bcm-kona-usb2.c
index 6459296d9bf93..e9cc5f2cb89af 100644
--- a/drivers/phy/broadcom/phy-bcm-kona-usb2.c
+++ b/drivers/phy/broadcom/phy-bcm-kona-usb2.c
@@ -94,7 +94,6 @@ static int bcm_kona_usb2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct bcm_kona_usb *phy;
-	struct resource *res;
 	struct phy *gphy;
 	struct phy_provider *phy_provider;
 
@@ -102,8 +101,7 @@ static int bcm_kona_usb2_probe(struct platform_device *pdev)
 	if (!phy)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	phy->regs = devm_ioremap_resource(&pdev->dev, res);
+	phy->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(phy->regs))
 		return PTR_ERR(phy->regs);
 
diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb2.c b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
index 9f2f84d65dcd3..4b015b8a71c35 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb2.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
@@ -83,7 +83,6 @@ static int bcm_ns_usb2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct bcm_ns_usb2 *usb2;
-	struct resource *res;
 	struct phy_provider *phy_provider;
 
 	usb2 = devm_kzalloc(&pdev->dev, sizeof(*usb2), GFP_KERNEL);
@@ -91,8 +90,7 @@ static int bcm_ns_usb2_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	usb2->dev = dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmu");
-	usb2->dmu = devm_ioremap_resource(dev, res);
+	usb2->dmu = devm_platform_ioremap_resource_byname(pdev, "dmu");
 	if (IS_ERR(usb2->dmu)) {
 		dev_err(dev, "Failed to map DMU regs\n");
 		return PTR_ERR(usb2->dmu);
diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb3.c b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
index 47b029fbebbdc..42baf4d6dd5d9 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb3.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
@@ -305,7 +305,6 @@ static int bcm_ns_usb3_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *of_id;
 	struct bcm_ns_usb3 *usb3;
-	struct resource *res;
 	struct phy_provider *phy_provider;
 
 	usb3 = devm_kzalloc(dev, sizeof(*usb3), GFP_KERNEL);
@@ -319,15 +318,13 @@ static int bcm_ns_usb3_probe(struct platform_device *pdev)
 		return -EINVAL;
 	usb3->family = (enum bcm_ns_family)of_id->data;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmp");
-	usb3->dmp = devm_ioremap_resource(dev, res);
+	usb3->dmp = devm_platform_ioremap_resource_byname(pdev, "dmp");
 	if (IS_ERR(usb3->dmp)) {
 		dev_err(dev, "Failed to map DMP regs\n");
 		return PTR_ERR(usb3->dmp);
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ccb-mii");
-	usb3->ccb_mii = devm_ioremap_resource(dev, res);
+	usb3->ccb_mii = devm_platform_ioremap_resource_byname(pdev, "ccb-mii");
 	if (IS_ERR(usb3->ccb_mii)) {
 		dev_err(dev, "Failed to map ChipCommon B MII regs\n");
 		return PTR_ERR(usb3->ccb_mii);
diff --git a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
index 9630ac127366d..65a399acc845e 100644
--- a/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
+++ b/drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c
@@ -293,7 +293,6 @@ static int ns2_drd_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ns2_phy_driver *driver;
 	struct ns2_phy_data *data;
-	struct resource *res;
 	int ret;
 	u32 val;
 
@@ -307,23 +306,19 @@ static int ns2_drd_phy_probe(struct platform_device *pdev)
 	if (!driver->data)
 		return -ENOMEM;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "icfg");
-	driver->icfgdrd_regs = devm_ioremap_resource(dev, res);
+	driver->icfgdrd_regs = devm_platform_ioremap_resource_byname(pdev, "icfg");
 	if (IS_ERR(driver->icfgdrd_regs))
 		return PTR_ERR(driver->icfgdrd_regs);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rst-ctrl");
-	driver->idmdrd_rst_ctrl = devm_ioremap_resource(dev, res);
+	driver->idmdrd_rst_ctrl = devm_platform_ioremap_resource_byname(pdev, "rst-ctrl");
 	if (IS_ERR(driver->idmdrd_rst_ctrl))
 		return PTR_ERR(driver->idmdrd_rst_ctrl);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "crmu-ctrl");
-	driver->crmu_usb2_ctrl = devm_ioremap_resource(dev, res);
+	driver->crmu_usb2_ctrl = devm_platform_ioremap_resource_byname(pdev, "crmu-ctrl");
 	if (IS_ERR(driver->crmu_usb2_ctrl))
 		return PTR_ERR(driver->crmu_usb2_ctrl);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "usb2-strap");
-	driver->usb2h_strap_reg = devm_ioremap_resource(dev, res);
+	driver->usb2h_strap_reg = devm_platform_ioremap_resource_byname(pdev, "usb2-strap");
 	if (IS_ERR(driver->usb2h_strap_reg))
 		return PTR_ERR(driver->usb2h_strap_reg);
 
diff --git a/drivers/phy/broadcom/phy-bcm-sr-pcie.c b/drivers/phy/broadcom/phy-bcm-sr-pcie.c
index 96a3af126a78d..8a4aadf166cf9 100644
--- a/drivers/phy/broadcom/phy-bcm-sr-pcie.c
+++ b/drivers/phy/broadcom/phy-bcm-sr-pcie.c
@@ -217,7 +217,6 @@ static int sr_pcie_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct sr_pcie_phy_core *core;
-	struct resource *res;
 	struct phy_provider *provider;
 	unsigned int phy_idx = 0;
 
@@ -226,9 +225,7 @@ static int sr_pcie_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	core->dev = dev;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	core->base = devm_ioremap_resource(core->dev, res);
+	core->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(core->base))
 		return PTR_ERR(core->base);
 
diff --git a/drivers/phy/broadcom/phy-bcm-sr-usb.c b/drivers/phy/broadcom/phy-bcm-sr-usb.c
index c3e99ad174874..0002da3b5b5d7 100644
--- a/drivers/phy/broadcom/phy-bcm-sr-usb.c
+++ b/drivers/phy/broadcom/phy-bcm-sr-usb.c
@@ -300,14 +300,12 @@ static int bcm_usb_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *dn = dev->of_node;
 	const struct of_device_id *of_id;
-	struct resource *res;
 	void __iomem *regs;
 	int ret;
 	enum bcm_usb_phy_version version;
 	struct phy_provider *phy_provider;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(dev, res);
+	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
index 18251f232172b..53942973f508d 100644
--- a/drivers/phy/broadcom/phy-brcm-sata.c
+++ b/drivers/phy/broadcom/phy-brcm-sata.c
@@ -726,7 +726,6 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 	struct device_node *dn = dev->of_node, *child;
 	const struct of_device_id *of_id;
 	struct brcm_sata_phy *priv;
-	struct resource *res;
 	struct phy_provider *provider;
 	int ret, count = 0;
 
@@ -739,8 +738,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, priv);
 	priv->dev = dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
-	priv->phy_base = devm_ioremap_resource(dev, res);
+	priv->phy_base = devm_platform_ioremap_resource_byname(pdev, "phy");
 	if (IS_ERR(priv->phy_base))
 		return PTR_ERR(priv->phy_base);
 
@@ -751,9 +749,7 @@ static int brcm_sata_phy_probe(struct platform_device *pdev)
 		priv->version = BRCM_SATA_PHY_STB_28NM;
 
 	if (priv->version == BRCM_SATA_PHY_IPROC_NS2) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "phy-ctrl");
-		priv->ctrl_base = devm_ioremap_resource(dev, res);
+		priv->ctrl_base = devm_platform_ioremap_resource_byname(pdev, "phy-ctrl");
 		if (IS_ERR(priv->ctrl_base))
 			return PTR_ERR(priv->ctrl_base);
 	}
-- 
2.51.0


