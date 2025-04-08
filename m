Return-Path: <stable+bounces-131480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4224EA80A7B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A7217FD27
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C9F26B943;
	Tue,  8 Apr 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W6isLC20"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A679D278151;
	Tue,  8 Apr 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116513; cv=none; b=MJNkIUh/NY7ljViWRLPfasEcKtY191b8rEg5oE0CRKwitObEQw2v8PSO4GBfZ2ah4yVveMmbqnjI/tzd/SCE63iSJhVPEGnVZhwCpdPysX00BGvQyifQrFO/5X26gXxLp0ikk45+UzNuP7nArl4oo5XpZH9E90UUQrtZfJSacUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116513; c=relaxed/simple;
	bh=DhcnPidyw1XawgHuFIf/h3g1sO0t1XvERLbbI1v8qek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwbq+VqItSl/YH9FUDFzJ2lktwZEjKaTAzx9ugA4yrlxYVC4YzqBv107iZjKDI61cMCzkXzvQ7OjmG6iXjxp3jca0Wi6jAVeFnVj46FCbgU73tSXRxMZi0oerXTDbmKlrcmaw/H3q9EEWQDrxCVYSrFKvGHCMjKQtbypb7kPKWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W6isLC20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2F0C4CEEC;
	Tue,  8 Apr 2025 12:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116513;
	bh=DhcnPidyw1XawgHuFIf/h3g1sO0t1XvERLbbI1v8qek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6isLC209wPozB67U5aHmzXr3CSVzN8B3MGun8AoRic1rHgyEKoPJhe8NJ4UaeSmD
	 BYEaenPXxrs9h2GVUKx2Wa5cBxlUkp6Td2KRgVHloy3LzvDn3k4sK8p6/E1d9gz9B6
	 SHDAvsdvmhrNW70ktfKSLQqBBsZQSBXZTg7bjbgk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 166/423] phy: phy-rockchip-samsung-hdptx: Dont use dt aliases to determine phy-id
Date: Tue,  8 Apr 2025 12:48:12 +0200
Message-ID: <20250408104849.605490008@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Stuebner <heiko.stuebner@cherry.de>

[ Upstream commit f08d1c08563846f9be79a4859e912c8795d690fd ]

The phy needs to know its identity in the system (phy0 or phy1 on rk3588)
for some actions and the driver currently contains code abusing of_alias
for that.

Devicetree aliases are always optional and should not be used for core
device functionality, so instead keep a list of phys on a soc in the
of_device_data and find the phy-id by comparing against the mapped
register-base.

Fixes: c4b09c562086 ("phy: phy-rockchip-samsung-hdptx: Add clock provider support")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20241206103401.1780416-3-heiko@sntech.de
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../phy/rockchip/phy-rockchip-samsung-hdptx.c | 50 ++++++++++++++++---
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 69c3ec0938f74..be6f1ca9095aa 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -266,11 +266,22 @@ enum rk_hdptx_reset {
 	RST_MAX
 };
 
+#define MAX_HDPTX_PHY_NUM	2
+
+struct rk_hdptx_phy_cfg {
+	unsigned int num_phys;
+	unsigned int phy_ids[MAX_HDPTX_PHY_NUM];
+};
+
 struct rk_hdptx_phy {
 	struct device *dev;
 	struct regmap *regmap;
 	struct regmap *grf;
 
+	/* PHY const config */
+	const struct rk_hdptx_phy_cfg *cfgs;
+	int phy_id;
+
 	struct phy *phy;
 	struct phy_config *phy_cfg;
 	struct clk_bulk_data *clks;
@@ -1019,15 +1030,14 @@ static int rk_hdptx_phy_clk_register(struct rk_hdptx_phy *hdptx)
 	struct device *dev = hdptx->dev;
 	const char *name, *pname;
 	struct clk *refclk;
-	int ret, id;
+	int ret;
 
 	refclk = devm_clk_get(dev, "ref");
 	if (IS_ERR(refclk))
 		return dev_err_probe(dev, PTR_ERR(refclk),
 				     "Failed to get ref clock\n");
 
-	id = of_alias_get_id(dev->of_node, "hdptxphy");
-	name = id > 0 ? "clk_hdmiphy_pixel1" : "clk_hdmiphy_pixel0";
+	name = hdptx->phy_id > 0 ? "clk_hdmiphy_pixel1" : "clk_hdmiphy_pixel0";
 	pname = __clk_get_name(refclk);
 
 	hdptx->hw.init = CLK_HW_INIT(name, pname, &hdptx_phy_clk_ops,
@@ -1070,8 +1080,9 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
 	struct rk_hdptx_phy *hdptx;
+	struct resource *res;
 	void __iomem *regs;
-	int ret;
+	int ret, id;
 
 	hdptx = devm_kzalloc(dev, sizeof(*hdptx), GFP_KERNEL);
 	if (!hdptx)
@@ -1079,11 +1090,27 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 
 	hdptx->dev = dev;
 
-	regs = devm_platform_ioremap_resource(pdev, 0);
+	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(regs))
 		return dev_err_probe(dev, PTR_ERR(regs),
 				     "Failed to ioremap resource\n");
 
+	hdptx->cfgs = device_get_match_data(dev);
+	if (!hdptx->cfgs)
+		return dev_err_probe(dev, -EINVAL, "missing match data\n");
+
+	/* find the phy-id from the io address */
+	hdptx->phy_id = -ENODEV;
+	for (id = 0; id < hdptx->cfgs->num_phys; id++) {
+		if (res->start == hdptx->cfgs->phy_ids[id]) {
+			hdptx->phy_id = id;
+			break;
+		}
+	}
+
+	if (hdptx->phy_id < 0)
+		return dev_err_probe(dev, -ENODEV, "no matching device found\n");
+
 	ret = devm_clk_bulk_get_all(dev, &hdptx->clks);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to get clocks\n");
@@ -1147,8 +1174,19 @@ static const struct dev_pm_ops rk_hdptx_phy_pm_ops = {
 		       rk_hdptx_phy_runtime_resume, NULL)
 };
 
+static const struct rk_hdptx_phy_cfg rk3588_hdptx_phy_cfgs = {
+	.num_phys = 2,
+	.phy_ids = {
+		0xfed60000,
+		0xfed70000,
+	},
+};
+
 static const struct of_device_id rk_hdptx_phy_of_match[] = {
-	{ .compatible = "rockchip,rk3588-hdptx-phy", },
+	{
+		.compatible = "rockchip,rk3588-hdptx-phy",
+		.data = &rk3588_hdptx_phy_cfgs
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, rk_hdptx_phy_of_match);
-- 
2.39.5




