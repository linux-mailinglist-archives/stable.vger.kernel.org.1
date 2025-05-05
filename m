Return-Path: <stable+bounces-140516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22068AAA986
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6BD1890E31
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED7E29953D;
	Mon,  5 May 2025 22:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWdN+UBb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632B729A3D1;
	Mon,  5 May 2025 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485030; cv=none; b=AOfrHnuxUiAkE4geB9mZrrdBBmDv3gCNN/IbmzU3WqIO29dkGscSa7nKbfzijEtR/s1dAG+3A6wCxKlu8wmPZddBZy1mo3RK63Un29yFv/njYEJZf5jYscYBiXVfSMjGg0n3ysIk0ZE4+BqGCRY8ZWlsiezct7hpwR3zqy6vlgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485030; c=relaxed/simple;
	bh=3aAHfYkGn/uWA+36sIzIVJUpFsAi5/yTC//H7Q5td7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OPCseG4P7sicC745J3cBGjXUwISBfyfS4oD8bb6/HEsOOTCz+DrOfiUMYKV2q4LmbTa2kDTDjLMN/jjMQwW4ByQY+dRLhoOHzytlYM7kAeAHjf8tbZZy355j1hyozbGGqDRwLsG9an/7suaokvmby+GwoVHrJeh0DZ6oqnnu6yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWdN+UBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF93AC4CEED;
	Mon,  5 May 2025 22:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485028;
	bh=3aAHfYkGn/uWA+36sIzIVJUpFsAi5/yTC//H7Q5td7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWdN+UBbQH/SeI8q6G25cA3c2v+6rxyhwNt/tIPcpvHoJZlssWTI4IG8ZECvsKl0x
	 CgWhQbHntmYZ8wpBYee+1QviEbK3wlSBwnI1qb26eRGoRuWupvdxt7COnIf0TE5hPp
	 /Zw5J0KENNDYGwnrZn2xniFwnPl05e2GPSzvs8e9npjjI9wrNtXuWWe7nBGYTA+ORd
	 R7OAFu+xCa/L9U6iMYignMjFhJsf3dDO3NbaVYgmeNVk6r+kcW4zgkyiou/UN2xqc9
	 6KGqX1bd73jpmGkfTmQVrtQ5tnS4PBLQilq5b2kBakRSu28nzPLKVLN8Tu6w7hxUnv
	 mbo7PfQacXr0Q==
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
	wens@csie.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 131/486] net: stmmac: dwmac-rk: Validate GRF and peripheral GRF during probe
Date: Mon,  5 May 2025 18:33:27 -0400
Message-Id: <20250505223922.2682012-131-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 50073bdade46e..8f90eae937741 100644
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
@@ -1263,6 +1264,7 @@ static const struct rk_gmac_ops rk3576_ops = {
 	.set_rgmii_speed = rk3576_set_gmac_speed,
 	.set_rmii_speed = rk3576_set_gmac_speed,
 	.set_clock_selection = rk3576_set_clock_selection,
+	.php_grf_required = true,
 	.regs_valid = true,
 	.regs = {
 		0x2a220000, /* gmac0 */
@@ -1410,6 +1412,7 @@ static const struct rk_gmac_ops rk3588_ops = {
 	.set_rgmii_speed = rk3588_set_gmac_speed,
 	.set_rmii_speed = rk3588_set_gmac_speed,
 	.set_clock_selection = rk3588_set_clock_selection,
+	.php_grf_required = true,
 	.regs_valid = true,
 	.regs = {
 		0xfe1b0000, /* gmac0 */
@@ -1830,8 +1833,22 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 
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


