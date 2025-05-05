Return-Path: <stable+bounces-140528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32344AAA994
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96823172DB7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5AF35AEA1;
	Mon,  5 May 2025 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3yK4O11"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B8B29A3F4;
	Mon,  5 May 2025 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485041; cv=none; b=UOpmWKT2ACQHCbGdB+760U8rrOM+ke3/JffZVA/iIstn6o6WiNcHP0QCwTtbxROvTIhpXmiv97n7q9NxyZOmBiqXz+SMdChhs50hJjhu46qQVcC+veL2WGp8YrzSV0RjMzhTwa1rDjj1AM30DCsDPS2XVNNrm+of5NHxgO339Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485041; c=relaxed/simple;
	bh=vuGAH76yVNoA6UsmNpp/0fHm5dZYlv92C+/rbmGG6oA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tb/7R6GxGuxTPFD3ZL0jNRGgcNHVtYnMvoffOdkirUFMl8wnlnt2ydNF8KoC5n+oulTtffuDYwqNxJ8dChkiuVoj/TiW492jcG72IbjgVyKdmKYwidel0TcNQMYJLeYBmip+6UbmyVn2OVP7Tq0b7FfuWt6gtlNkBwu0uiO2IFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3yK4O11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7242C4CEE4;
	Mon,  5 May 2025 22:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485041;
	bh=vuGAH76yVNoA6UsmNpp/0fHm5dZYlv92C+/rbmGG6oA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G3yK4O11ZrGQ18ta+igIvQa2aBdqEKe0F0btHHNr+89IxpwUCmnWJDhcTy+mpQWKA
	 uqdftIM6yVBqsfspF5hZaiUrnvkwndVpM+fqPfXArrXw5qv8aYp0NUeTAvuZIh8WHS
	 crvIg9vr9WUwahNdLdBBjAFrioRN0KrDJya19o4ovevpb4/m2Hxls4IzVH4NYP87C2
	 QeYJtcwNf2D2ZxJeoIPWD5sdJ7ERybFArozRzP8g4D6BbEjQXD7gbjw5Xx7MK22uWq
	 HcZaBT8P3NhDyCb61mzzqEuvpzNQSUhYArCM5JIwT3bJoBFUR5l452TLO591dJOont
	 5jtPiIZiqKzJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Yan <andy.yan@rock-chips.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kishon@kernel.org,
	heiko@sntech.de,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 137/486] phy: rockchip: usbdp: Only verify link rates/lanes/voltage when the corresponding set flags are set
Date: Mon,  5 May 2025 18:33:33 -0400
Message-Id: <20250505223922.2682012-137-sashal@kernel.org>
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

From: Andy Yan <andy.yan@rock-chips.com>

[ Upstream commit 969a38be437b68dc9e12e3c3f08911c9f9c8be73 ]

According documentation of phy_configure_opts_dp, at the configure
stage, link rates should only be verify/configure when set_rate
flag is set, the same applies to lanes and voltage.

So do it as the documentation says.
Because voltage setting depends on the lanes, link rates set
previously, so record the link rates and lanes at it's verify stage.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Link: https://lore.kernel.org/r/20250312080041.524546-1-andyshrk@163.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 87 ++++++++++++++---------
 1 file changed, 53 insertions(+), 34 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index f5c6d264d89ed..d2021f7941e3e 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -187,6 +187,8 @@ struct rk_udphy {
 	u32 dp_aux_din_sel;
 	bool dp_sink_hpd_sel;
 	bool dp_sink_hpd_cfg;
+	unsigned int link_rate;
+	unsigned int lanes;
 	u8 bw;
 	int id;
 
@@ -1102,15 +1104,19 @@ static int rk_udphy_dp_phy_power_off(struct phy *phy)
 	return 0;
 }
 
-static int rk_udphy_dp_phy_verify_link_rate(unsigned int link_rate)
+/*
+ * Verify link rate
+ */
+static int rk_udphy_dp_phy_verify_link_rate(struct rk_udphy *udphy,
+					    struct phy_configure_opts_dp *dp)
 {
-	switch (link_rate) {
+	switch (dp->link_rate) {
 	case 1620:
 	case 2700:
 	case 5400:
 	case 8100:
+		udphy->link_rate = dp->link_rate;
 		break;
-
 	default:
 		return -EINVAL;
 	}
@@ -1118,45 +1124,44 @@ static int rk_udphy_dp_phy_verify_link_rate(unsigned int link_rate)
 	return 0;
 }
 
-static int rk_udphy_dp_phy_verify_config(struct rk_udphy *udphy,
-					 struct phy_configure_opts_dp *dp)
+static int rk_udphy_dp_phy_verify_lanes(struct rk_udphy *udphy,
+					struct phy_configure_opts_dp *dp)
 {
-	int i, ret;
-
-	/* If changing link rate was required, verify it's supported. */
-	ret = rk_udphy_dp_phy_verify_link_rate(dp->link_rate);
-	if (ret)
-		return ret;
-
-	/* Verify lane count. */
 	switch (dp->lanes) {
 	case 1:
 	case 2:
 	case 4:
 		/* valid lane count. */
+		udphy->lanes = dp->lanes;
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
-	/*
-	 * If changing voltages is required, check swing and pre-emphasis
-	 * levels, per-lane.
-	 */
-	if (dp->set_voltages) {
-		/* Lane count verified previously. */
-		for (i = 0; i < dp->lanes; i++) {
-			if (dp->voltage[i] > 3 || dp->pre[i] > 3)
-				return -EINVAL;
+	return 0;
+}
 
-			/*
-			 * Sum of voltage swing and pre-emphasis levels cannot
-			 * exceed 3.
-			 */
-			if (dp->voltage[i] + dp->pre[i] > 3)
-				return -EINVAL;
-		}
+/*
+ * If changing voltages is required, check swing and pre-emphasis
+ * levels, per-lane.
+ */
+static int rk_udphy_dp_phy_verify_voltages(struct rk_udphy *udphy,
+					   struct phy_configure_opts_dp *dp)
+{
+	int i;
+
+	/* Lane count verified previously. */
+	for (i = 0; i < udphy->lanes; i++) {
+		if (dp->voltage[i] > 3 || dp->pre[i] > 3)
+			return -EINVAL;
+
+		/*
+		 * Sum of voltage swing and pre-emphasis levels cannot
+		 * exceed 3.
+		 */
+		if (dp->voltage[i] + dp->pre[i] > 3)
+			return -EINVAL;
 	}
 
 	return 0;
@@ -1196,9 +1201,23 @@ static int rk_udphy_dp_phy_configure(struct phy *phy,
 	u32 i, val, lane;
 	int ret;
 
-	ret = rk_udphy_dp_phy_verify_config(udphy, dp);
-	if (ret)
-		return ret;
+	if (dp->set_rate) {
+		ret = rk_udphy_dp_phy_verify_link_rate(udphy, dp);
+		if (ret)
+			return ret;
+	}
+
+	if (dp->set_lanes) {
+		ret = rk_udphy_dp_phy_verify_lanes(udphy, dp);
+		if (ret)
+			return ret;
+	}
+
+	if (dp->set_voltages) {
+		ret = rk_udphy_dp_phy_verify_voltages(udphy, dp);
+		if (ret)
+			return ret;
+	}
 
 	if (dp->set_rate) {
 		regmap_update_bits(udphy->pma_regmap, CMN_DP_RSTN_OFFSET,
@@ -1243,9 +1262,9 @@ static int rk_udphy_dp_phy_configure(struct phy *phy,
 	}
 
 	if (dp->set_voltages) {
-		for (i = 0; i < dp->lanes; i++) {
+		for (i = 0; i < udphy->lanes; i++) {
 			lane = udphy->dp_lane_sel[i];
-			switch (dp->link_rate) {
+			switch (udphy->link_rate) {
 			case 1620:
 			case 2700:
 				regmap_update_bits(udphy->pma_regmap,
-- 
2.39.5


