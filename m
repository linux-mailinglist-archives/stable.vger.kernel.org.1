Return-Path: <stable+bounces-120115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73916A4C76C
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E96188A519
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925AE23C8A8;
	Mon,  3 Mar 2025 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt30NuGa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487F923AE60;
	Mon,  3 Mar 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019434; cv=none; b=QVCAgHrqMdejO0cL5r37i+Nxt5QA2uGLG/aYInkpPZh67roWZD5vIW8F0fUL35fpuTmLMuJ6Iw/FGBw/D/WwLNSA0G8UXYkIv7IWnS7ikTn4LTWVVm4iPljyVGVSlSclR8jpX0jQEA+8FxTtrKgX9RlTVxspjC1aus+7ZTu9WRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019434; c=relaxed/simple;
	bh=wTFypdAzIqZeFYswuOLBZsENvscfswT3WAEBeEYt4+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sOvHnbUbFbZi9CH0zfEpihnXTXyNUUUpVGh3lxKq3+1Fnrvv/qjNMcE/czIVR+jK7hPBtcVzSeeiWMBGVfiSLcdSgNZdx4nmgDRbUioprk/HBlJtlKtggG/9OJCTGqIGqmo7nmFn+1ji34wZQUbtjDcuZicjzca5dJTMe41BZfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pt30NuGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6C0C4CEEA;
	Mon,  3 Mar 2025 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019433;
	bh=wTFypdAzIqZeFYswuOLBZsENvscfswT3WAEBeEYt4+o=;
	h=From:To:Cc:Subject:Date:From;
	b=Pt30NuGaAar/9GspoWMpmv3lkvqiWxv9ZE2ky1dppAhhe+9lBin9atIeAeZPu2Frh
	 zxuTf20LNevc2vccB73Fpk3N1efmwHgtf09gE75/78TaKKzlc9mhUX6mXmGhaJvtbu
	 QNuJ61oMZkLgTrufMRw8vYsDSKgfily5yF+ArIDxSHxQmQAEsCJrQFUynlZfE7ZAK9
	 Tgg8Fk4//aBx7Ya47IrpleXrzr1EAOjn0R0ow7F6c+KP5fwfOSJCdtxaEdIqYSO4yF
	 ZsvhAiQEhWNDdw3LhoKyQBgpp/9msqIU3DM06mQSmliQVK46sjUjqasjf1EWIfET8r
	 8ZSNH1rHmxb3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Davis <afd@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kishon@kernel.org,
	krzysztof.kozlowski@linaro.org,
	rogerq@kernel.org,
	s-vadapalli@ti.com,
	linux-phy@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 01/17] phy: ti: gmii-sel: Do not use syscon helper to build regmap
Date: Mon,  3 Mar 2025 11:30:13 -0500
Message-Id: <20250303163031.3763651-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.17
Content-Transfer-Encoding: 8bit

From: Andrew Davis <afd@ti.com>

[ Upstream commit 5ab90f40121a9f6a9b368274cd92d0f435dc7cfa ]

The syscon helper device_node_to_regmap() is used to fetch a regmap
registered to a device node. It also currently creates this regmap
if the node did not already have a regmap associated with it. This
should only be used on "syscon" nodes. This driver is not such a
device and instead uses device_node_to_regmap() on its own node as
a hacky way to create a regmap for itself.

This will not work going forward and so we should create our regmap
the normal way by defining our regmap_config, fetching our memory
resource, then using the normal regmap_init_mmio() function.

Signed-off-by: Andrew Davis <afd@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Link: https://lore.kernel.org/r/20250123182234.597665-1-afd@ti.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/ti/phy-gmii-sel.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index 103b266fec771..2c2256fe5a3b6 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -423,6 +423,12 @@ static int phy_gmii_sel_init_ports(struct phy_gmii_sel_priv *priv)
 	return 0;
 }
 
+static const struct regmap_config phy_gmii_sel_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
 static int phy_gmii_sel_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -467,7 +473,14 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
 
 	priv->regmap = syscon_node_to_regmap(node->parent);
 	if (IS_ERR(priv->regmap)) {
-		priv->regmap = device_node_to_regmap(node);
+		void __iomem *base;
+
+		base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(base))
+			return dev_err_probe(dev, PTR_ERR(base),
+					     "failed to get base memory resource\n");
+
+		priv->regmap = regmap_init_mmio(dev, base, &phy_gmii_sel_regmap_cfg);
 		if (IS_ERR(priv->regmap))
 			return dev_err_probe(dev, PTR_ERR(priv->regmap),
 					     "Failed to get syscon\n");
-- 
2.39.5


