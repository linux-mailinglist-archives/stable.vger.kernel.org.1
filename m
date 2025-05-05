Return-Path: <stable+bounces-139911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3564AAA227
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CF03AD19B
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8772D643A;
	Mon,  5 May 2025 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOvtKib+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C885D2D5CFC;
	Mon,  5 May 2025 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483656; cv=none; b=FzQn7S328sXYI1IhG1/t95q094BTT92d54qY4XQQeBeL7Z7uQGQ1eVcvdGz7Rpe85s8wQdt65c3dyLssCB3DBjcqCPjaKAHOrcp1yGpsu0+0WdxN/W9IeWRCOm+Bsoy+YnJkBD3PIPXmGNx4/BoMMh1RY/M2/KitGnF9ZsDXhLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483656; c=relaxed/simple;
	bh=Xxz2tIz/4P+u+7QlDgItXN3a//ztEs89nkHyGmaAR98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cuFXyWKSfquVyxMjJv+f3p7iYF/h/szZEqokN3lFCLutGBcuMuRp3xQXc7q5qpyIBM1NvCABGRoD7n9s07as9bnaxnYKfxNOB6oR5sLwm3FbBmrBW0e7WMfyETcVFvq1W6uU0HESw5WesJFIoAf8XU1xghQPEPTm4GThDbH98xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOvtKib+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2807C4CEE4;
	Mon,  5 May 2025 22:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483656;
	bh=Xxz2tIz/4P+u+7QlDgItXN3a//ztEs89nkHyGmaAR98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AOvtKib+beqExThN3Xy24dsOlQXrXMgzW0kuBmQGOsu3+2RnPUnkB4+pO8AuXXYG8
	 lrkSRtB5O7BsjhNeU1LL7aRrN0djBtT7ceZ2jGkv6V1tFM4da3wTWgOO2G9nFXT7wm
	 0/KM3Vo7uc8Zrhd/qmnbSm4bcar3gyo0szkIKojtvMGlBtxWGXinkmsYSRX9GHTaxs
	 XfWbDT2bKqdNFBUXSSFP9mYCwIQ+NSxnoNYyXeSlhULSI6vRZJWbUbj7fvdUIJ2yrh
	 Yc4QV31lUzQpJxZy1USNuAWkDuDQkQLWLY9+Bk3M2SMl/pQH0zcZdTthcTjFtObdmZ
	 a/dJoohsiaSDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonas Karlman <jonas@kwiboo.se>,
	Simon Horman <horms@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	david.wu@rock-chips.com,
	jan.petrous@oss.nxp.com,
	detlev.casanova@collabora.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 164/642] net: stmmac: dwmac-rk: Validate GRF and peripheral GRF during probe
Date: Mon,  5 May 2025 18:06:20 -0400
Message-Id: <20250505221419.2672473-164-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Jonas Karlman <jonas@kwiboo.se>

[ Upstream commit 247e84f66a3d1946193d739fec5dc3d69833fd00 ]

All Rockchip GMAC variants typically write to GRF regs to control e.g.
interface mode, speed and MAC rx/tx delay. Newer SoCs such as RK3576 and
RK3588 use a mix of GRF and peripheral GRF regs. These syscon regmaps is
located with help of a rockchip,grf and rockchip,php-grf phandle.

However, validating the rockchip,grf and rockchip,php-grf syscon regmap
is deferred until e.g. interface mode or speed is configured, inside the
individual SoC specific operations.

Change to validate the rockchip,grf and rockchip,php-grf syscon regmap
at probe time to simplify all SoC specific operations.

This should not introduce any backward compatibility issues as all
GMAC nodes have been added together with a rockchip,grf phandle (and
rockchip,php-grf where required) in their initial commit.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250308213720.2517944-3-jonas@kwiboo.se
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index a4dc89e23a68e..a33be23121b35 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -33,6 +33,7 @@ struct rk_gmac_ops {
 	void (*set_clock_selection)(struct rk_priv_data *bsp_priv, bool input,
 				    bool enable);
 	void (*integrated_phy_powerup)(struct rk_priv_data *bsp_priv);
+	bool php_grf_required;
 	bool regs_valid;
 	u32 regs[];
 };
@@ -1254,6 +1255,7 @@ static const struct rk_gmac_ops rk3576_ops = {
 	.set_rgmii_speed = rk3576_set_gmac_speed,
 	.set_rmii_speed = rk3576_set_gmac_speed,
 	.set_clock_selection = rk3576_set_clock_selection,
+	.php_grf_required = true,
 	.regs_valid = true,
 	.regs = {
 		0x2a220000, /* gmac0 */
@@ -1401,6 +1403,7 @@ static const struct rk_gmac_ops rk3588_ops = {
 	.set_rgmii_speed = rk3588_set_gmac_speed,
 	.set_rmii_speed = rk3588_set_gmac_speed,
 	.set_clock_selection = rk3588_set_clock_selection,
+	.php_grf_required = true,
 	.regs_valid = true,
 	.regs = {
 		0xfe1b0000, /* gmac0 */
@@ -1812,8 +1815,22 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 
 	bsp_priv->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
 							"rockchip,grf");
-	bsp_priv->php_grf = syscon_regmap_lookup_by_phandle(dev->of_node,
-							    "rockchip,php-grf");
+	if (IS_ERR(bsp_priv->grf)) {
+		dev_err_probe(dev, PTR_ERR(bsp_priv->grf),
+			      "failed to lookup rockchip,grf\n");
+		return ERR_CAST(bsp_priv->grf);
+	}
+
+	if (ops->php_grf_required) {
+		bsp_priv->php_grf =
+			syscon_regmap_lookup_by_phandle(dev->of_node,
+							"rockchip,php-grf");
+		if (IS_ERR(bsp_priv->php_grf)) {
+			dev_err_probe(dev, PTR_ERR(bsp_priv->php_grf),
+				      "failed to lookup rockchip,php-grf\n");
+			return ERR_CAST(bsp_priv->php_grf);
+		}
+	}
 
 	if (plat->phy_node) {
 		bsp_priv->integrated_phy = of_property_read_bool(plat->phy_node,
-- 
2.39.5


