Return-Path: <stable+bounces-141120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18217AAB61F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C7C17A5BA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BAC322ABF;
	Tue,  6 May 2025 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIr6N989"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816C736DD4A;
	Mon,  5 May 2025 22:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485201; cv=none; b=atQE+BRLNi6BsNUYUtJcK6XxFMVkapWqsSWqtpHnyXkl9M/ESrpQnXp0f1vTWqeCagjwJrAzKqAbpblnFsIt2RlwSZ0E4XFJO/fVpBFZiE9ljQnIa9q+KGFjyUGJSvXQOnkurxLQplQjawe75PQ0zeiH50YL3jRrdnPtxse3fuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485201; c=relaxed/simple;
	bh=yuXGiFMgftvcB/kFfE2afuFLtedFU/p8/E+RKzxHC2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LUykHMS3UTKjEnyEXOC9tryB/xgNBpccw9za06STduk5kJAKuhQpwY8zWBzDEWfeMMcEvfueSQAsi8DCemgf81N2MxfFVPniw3CH2HmCaBRuth0rJQH5QaYWlX+x93VMMNZe8J/o2bTNQAnsI6G96LJOnwBOMhmvyW62W2PKaBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIr6N989; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8AFC4CEEF;
	Mon,  5 May 2025 22:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485201;
	bh=yuXGiFMgftvcB/kFfE2afuFLtedFU/p8/E+RKzxHC2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OIr6N989MIzujB2dKup1LZBgszKzoi1mP+YtMYgY9GTHFUbHqEvnhAUKdpwtQL3ZC
	 JZQCT8jzrKDvHTrdhICzZNUBdAxqRjabzaHFcQ+Rybo+zQX6OhwAg9C9F9Q0Uvr+rv
	 p/aQYnVeFqcK7sSsttUD63RT3qF6sVymV8nuEYmXix/7F4bnxzYnrPvV4FJxHiyEEq
	 HOX6yShL4my9BmhW4xA2QJ3/hxhAO5DMw94jPK/9TNDdMl987427lgZfzTwbtoBpwB
	 L9fyE625ymhTfiTsS4XQVP01hslKQA+drCnxheyAx/chA7HM/ztGq4+JfbmY72UHPi
	 tmGTVWSeUjXCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrei Botila <andrei.botila@oss.nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	sd@queasysnail.net,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 207/486] net: phy: nxp-c45-tja11xx: add match_phy_device to TJA1103/TJA1104
Date: Mon,  5 May 2025 18:34:43 -0400
Message-Id: <20250505223922.2682012-207-sashal@kernel.org>
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

From: Andrei Botila <andrei.botila@oss.nxp.com>

[ Upstream commit a06a868a0cd96bc51401cdea897313a3f6ad01a0 ]

Add .match_phy_device for the existing TJAs to differentiate between
TJA1103 and TJA1104.
TJA1103 and TJA1104 share the same PHY_ID but TJA1104 has MACsec
capabilities while TJA1103 doesn't.

Signed-off-by: Andrei Botila <andrei.botila@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250228154320.2979000-2-andrei.botila@oss.nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 54 +++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 9788b820c6be7..99a5eee77bec1 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* NXP C45 PHY driver
- * Copyright 2021-2023 NXP
+ * Copyright 2021-2025 NXP
  * Author: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
  */
 
@@ -18,6 +18,8 @@
 
 #include "nxp-c45-tja11xx.h"
 
+#define PHY_ID_MASK			GENMASK(31, 4)
+/* Same id: TJA1103, TJA1104 */
 #define PHY_ID_TJA_1103			0x001BB010
 #define PHY_ID_TJA_1120			0x001BB031
 
@@ -1930,6 +1932,30 @@ static void tja1120_nmi_handler(struct phy_device *phydev,
 	}
 }
 
+static int nxp_c45_macsec_ability(struct phy_device *phydev)
+{
+	bool macsec_ability;
+	int phy_abilities;
+
+	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				     VEND1_PORT_ABILITIES);
+	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
+
+	return macsec_ability;
+}
+
+static int tja1103_match_phy_device(struct phy_device *phydev)
+{
+	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1103, PHY_ID_MASK) &&
+	       !nxp_c45_macsec_ability(phydev);
+}
+
+static int tja1104_match_phy_device(struct phy_device *phydev)
+{
+	return phy_id_compare(phydev->phy_id, PHY_ID_TJA_1103, PHY_ID_MASK) &&
+	       nxp_c45_macsec_ability(phydev);
+}
+
 static const struct nxp_c45_regmap tja1120_regmap = {
 	.vend1_ptp_clk_period	= 0x1020,
 	.vend1_event_msg_filt	= 0x9010,
@@ -2000,7 +2026,6 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 
 static struct phy_driver nxp_c45_driver[] = {
 	{
-		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
 		.name			= "NXP C45 TJA1103",
 		.get_features		= nxp_c45_get_features,
 		.driver_data		= &tja1103_phy_data,
@@ -2022,6 +2047,31 @@ static struct phy_driver nxp_c45_driver[] = {
 		.get_sqi		= nxp_c45_get_sqi,
 		.get_sqi_max		= nxp_c45_get_sqi_max,
 		.remove			= nxp_c45_remove,
+		.match_phy_device	= tja1103_match_phy_device,
+	},
+	{
+		.name			= "NXP C45 TJA1104",
+		.get_features		= nxp_c45_get_features,
+		.driver_data		= &tja1103_phy_data,
+		.probe			= nxp_c45_probe,
+		.soft_reset		= nxp_c45_soft_reset,
+		.config_aneg		= genphy_c45_config_aneg,
+		.config_init		= nxp_c45_config_init,
+		.config_intr		= tja1103_config_intr,
+		.handle_interrupt	= nxp_c45_handle_interrupt,
+		.read_status		= genphy_c45_read_status,
+		.suspend		= genphy_c45_pma_suspend,
+		.resume			= genphy_c45_pma_resume,
+		.get_sset_count		= nxp_c45_get_sset_count,
+		.get_strings		= nxp_c45_get_strings,
+		.get_stats		= nxp_c45_get_stats,
+		.cable_test_start	= nxp_c45_cable_test_start,
+		.cable_test_get_status	= nxp_c45_cable_test_get_status,
+		.set_loopback		= genphy_c45_loopback,
+		.get_sqi		= nxp_c45_get_sqi,
+		.get_sqi_max		= nxp_c45_get_sqi_max,
+		.remove			= nxp_c45_remove,
+		.match_phy_device	= tja1104_match_phy_device,
 	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),
-- 
2.39.5


