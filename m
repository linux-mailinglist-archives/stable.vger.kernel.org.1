Return-Path: <stable+bounces-156484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3843AE4FC0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD7A3ABDFC
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28A421B9C9;
	Mon, 23 Jun 2025 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FjpGtJkx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7494C62;
	Mon, 23 Jun 2025 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713526; cv=none; b=WtdfPKZ6MqECcGLIYTGdoVM0GfUxlscOk5rOVCq5b7s9A3Sfl7A7kkfeXf84BIYN/qJJf8qezN9P1zbKOl6ag9pDqVWlXgpU0J3/z+5J6E4kFtWlQVEKx5AhScJnLnPlOcHdbLqgGE9G/AEJ4GoAtQZn56gTcgnR0T2Gqctw0gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713526; c=relaxed/simple;
	bh=X61JaxI46L9+I9Ely0ZrLQI2Q1MyTPoIXxHHMCf+jDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n48h9qq+kbn6Pyr0A3lIdgDHUOvCr7G0w6ReRzf2HgaR/XTIEKV3A4E8YV2YTtBwBiDm+hLgxvcg6SBVjO8+ZoYt5Wa+Rx0IsTxMvq0/Rk2dE5VzTX3mOURsBKPkEDrYxUUVAdVAcwrG+Qm8TGmmRd3X2MASU7vwV2ljsRxcx4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FjpGtJkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB362C4CEEA;
	Mon, 23 Jun 2025 21:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713526;
	bh=X61JaxI46L9+I9Ely0ZrLQI2Q1MyTPoIXxHHMCf+jDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjpGtJkxdRnO4RIyuK4PBO6kgtTtNbxQaprjiqKXMdyRrrB1aTBGRXz44CZDy2j3g
	 a6vYL4NgzhZVlxL+59gWFwbauyoDMaE4rieH86vwai6AJpc5cKtGZqDJKSBc1i/aDG
	 vpYRZHA/PXYLX5uORECM4HE8VB8rnQuQzKeoUjhI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 352/592] net: phy: marvell-88q2xxx: Enable temperature measurement in probe again
Date: Mon, 23 Jun 2025 15:05:10 +0200
Message-ID: <20250623130708.816494344@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dimitri Fedrau <dima.fedrau@gmail.com>

[ Upstream commit 10465365f3b094ba9a9795f212d13dee594bcfe7 ]

Enabling of the temperature sensor was moved from mv88q2xxx_hwmon_probe to
mv88q222x_config_init with the consequence that the sensor is only
usable when the PHY is configured. Enable the sensor in
mv88q2xxx_hwmon_probe as well to fix this.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
Link: https://patch.msgid.link/20250512-marvell-88q2xxx-hwmon-enable-at-probe-v4-1-9256a5c8f603@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/marvell-88q2xxx.c | 103 +++++++++++++++++-------------
 1 file changed, 57 insertions(+), 46 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 23e1f0521f549..65f31d3c34810 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -119,7 +119,6 @@
 #define MV88Q2XXX_LED_INDEX_GPIO			1
 
 struct mv88q2xxx_priv {
-	bool enable_temp;
 	bool enable_led0;
 };
 
@@ -482,49 +481,6 @@ static int mv88q2xxx_config_aneg(struct phy_device *phydev)
 	return phydev->drv->soft_reset(phydev);
 }
 
-static int mv88q2xxx_config_init(struct phy_device *phydev)
-{
-	struct mv88q2xxx_priv *priv = phydev->priv;
-	int ret;
-
-	/* The 88Q2XXX PHYs do have the extended ability register available, but
-	 * register MDIO_PMA_EXTABLE where they should signalize it does not
-	 * work according to specification. Therefore, we force it here.
-	 */
-	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
-
-	/* Configure interrupt with default settings, output is driven low for
-	 * active interrupt and high for inactive.
-	 */
-	if (phy_interrupt_is_valid(phydev)) {
-		ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
-				       MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
-				       MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
-		if (ret < 0)
-			return ret;
-	}
-
-	/* Enable LED function and disable TX disable feature on LED/TX_ENABLE */
-	if (priv->enable_led0) {
-		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PCS,
-					 MDIO_MMD_PCS_MV_RESET_CTRL,
-					 MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE);
-		if (ret < 0)
-			return ret;
-	}
-
-	/* Enable temperature sense */
-	if (priv->enable_temp) {
-		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
-				     MDIO_MMD_PCS_MV_TEMP_SENSOR2,
-				     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-
 static int mv88q2xxx_get_sqi(struct phy_device *phydev)
 {
 	int ret;
@@ -667,6 +623,12 @@ static int mv88q2xxx_resume(struct phy_device *phydev)
 }
 
 #if IS_ENABLED(CONFIG_HWMON)
+static int mv88q2xxx_enable_temp_sense(struct phy_device *phydev)
+{
+	return phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
+			      MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
+}
+
 static const struct hwmon_channel_info * const mv88q2xxx_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_ALARM),
 	NULL
@@ -762,11 +724,13 @@ static const struct hwmon_chip_info mv88q2xxx_hwmon_chip_info = {
 
 static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 {
-	struct mv88q2xxx_priv *priv = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
 	struct device *hwmon;
+	int ret;
 
-	priv->enable_temp = true;
+	ret = mv88q2xxx_enable_temp_sense(phydev);
+	if (ret < 0)
+		return ret;
 
 	hwmon = devm_hwmon_device_register_with_info(dev, NULL, phydev,
 						     &mv88q2xxx_hwmon_chip_info,
@@ -776,6 +740,11 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 }
 
 #else
+static int mv88q2xxx_enable_temp_sense(struct phy_device *phydev)
+{
+	return 0;
+}
+
 static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 {
 	return 0;
@@ -853,6 +822,48 @@ static int mv88q222x_probe(struct phy_device *phydev)
 	return mv88q2xxx_hwmon_probe(phydev);
 }
 
+static int mv88q2xxx_config_init(struct phy_device *phydev)
+{
+	struct mv88q2xxx_priv *priv = phydev->priv;
+	int ret;
+
+	/* The 88Q2XXX PHYs do have the extended ability register available, but
+	 * register MDIO_PMA_EXTABLE where they should signalize it does not
+	 * work according to specification. Therefore, we force it here.
+	 */
+	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
+
+	/* Configure interrupt with default settings, output is driven low for
+	 * active interrupt and high for inactive.
+	 */
+	if (phy_interrupt_is_valid(phydev)) {
+		ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
+				       MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
+				       MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Enable LED function and disable TX disable feature on LED/TX_ENABLE */
+	if (priv->enable_led0) {
+		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PCS,
+					 MDIO_MMD_PCS_MV_RESET_CTRL,
+					 MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Enable temperature sense again. There might have been a hard reset
+	 * of the PHY and in this case the register content is restored to
+	 * defaults and we need to enable it again.
+	 */
+	ret = mv88q2xxx_enable_temp_sense(phydev);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int mv88q2110_config_init(struct phy_device *phydev)
 {
 	int ret;
-- 
2.39.5




