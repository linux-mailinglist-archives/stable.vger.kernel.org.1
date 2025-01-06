Return-Path: <stable+bounces-107185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FBEA02A9B
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED5A164FF9
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268F31607AA;
	Mon,  6 Jan 2025 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iRcktV4k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15B8154C04;
	Mon,  6 Jan 2025 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177709; cv=none; b=CwD7ydaise+FRlCwNsMTWk8tHmmL9l2m287O3hHGLWyjF7mO39uylomHCY2ys0nhLU6HxQSTRCsaHOFVqhxMGO9fkSEJi+i4N7020vsFsqggQFDPrgIyIxWdJPsAQbJMxQO5R2DeKB8iDGdsDyQoc82nuuxw7UTuMt8eMkYMpM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177709; c=relaxed/simple;
	bh=Nikp8+q6on0RnMQdnAWgiEL68dDGRxYfbi3qtb4oB6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Chw1co3wW81duBTLhdhLx8Rrf3tAk/Is80yHZ5YJQVgl1+sQpCmKZAYpbyu7IrxlShn9Np1pcLIcVypVNspf1Y7NAHbpHsw39SSaLpIuro7J4ZtBlNexRNSxpfUOGQY1xtERVl+ktKK+DHivOKrqqgXokd6RrFhoSVV7jpJKRU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iRcktV4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0965EC4CED2;
	Mon,  6 Jan 2025 15:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177709;
	bh=Nikp8+q6on0RnMQdnAWgiEL68dDGRxYfbi3qtb4oB6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRcktV4km6fAaI+IhVYHfXO7YX1/BaLlCV56uwUTPau4HP/PpRqzdObPbr7I5ftfX
	 /0WfdVG6303GQ6uAg1pL7BI9dZQDvmyMJBTaJOuQsVwyqvFHbMDuoDZ1Z7WzsG1vYk
	 J6irGSyoLtivEeT7rRPuk3aCXwK9J7mxa3yAsKBc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 031/156] net: phy: micrel: Dynamically control external clock of KSZ PHY
Date: Mon,  6 Jan 2025 16:15:17 +0100
Message-ID: <20250106151142.911286323@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151141.738050441@linuxfoundation.org>
References: <20250106151141.738050441@linuxfoundation.org>
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

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit 25c6a5ab151fb9c886552bf5aa7cbf2a5c6e96af ]

On the i.MX6ULL-14x14-EVK board, enet1_ref and enet2_ref are used as the
clock sources for two external KSZ PHYs. However, after closing the two
FEC ports, the clk_enable_count of the enet1_ref and enet2_ref clocks is
not 0. The root cause is that since the commit 985329462723 ("net: phy:
micrel: use devm_clk_get_optional_enabled for the rmii-ref clock"), the
external clock of KSZ PHY has been enabled when the PHY driver probes,
and it can only be disabled when the PHY driver is removed. This causes
the clock to continue working when the system is suspended or the network
port is down.

Although Heiko explained in the commit message that the patch was because
some clock suppliers need to enable the clock to get the valid clock rate
, it seems that the simple fix is to disable the clock after getting the
clock rate to solve the current problem. This is indeed true, but we need
to admit that Heiko's patch has been applied for more than a year, and we
cannot guarantee whether there are platforms that only enable rmii-ref in
the KSZ PHY driver during this period. If this is the case, disabling
rmii-ref will cause RMII on these platforms to not work.

Secondly, commit 99ac4cbcc2a5 ("net: phy: micrel: allow usage of generic
ethernet-phy clock") just simply enables the generic clock permanently,
which seems like the generic clock may only be enabled in the PHY driver.
If we simply disable the generic clock, RMII may not work. If we keep it
as it is, the platform using the generic clock will have the same problem
as the i.MX6ULL platform.

To solve this problem, the clock is enabled when phy_driver::resume() is
called, and the clock is disabled when phy_driver::suspend() is called.
Since phy_driver::resume() and phy_driver::suspend() are not called in
pairs, an additional clk_enable flag is added. When phy_driver::suspend()
is called, the clock is disabled only if clk_enable is true. Conversely,
when phy_driver::resume() is called, the clock is enabled if clk_enable
is false.

The changes that introduced the problem were only a few lines, while the
current fix is about a hundred lines, which seems out of proportion, but
it is necessary because kszphy_probe() is used by multiple KSZ PHYs and
we need to fix all of them.

Fixes: 985329462723 ("net: phy: micrel: use devm_clk_get_optional_enabled for the rmii-ref clock")
Fixes: 99ac4cbcc2a5 ("net: phy: micrel: allow usage of generic ethernet-phy clock")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20241217063500.1424011-1-wei.fang@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/micrel.c | 114 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 101 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 65b0a3115e14..64926240b007 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -432,10 +432,12 @@ struct kszphy_ptp_priv {
 struct kszphy_priv {
 	struct kszphy_ptp_priv ptp_priv;
 	const struct kszphy_type *type;
+	struct clk *clk;
 	int led_mode;
 	u16 vct_ctrl1000;
 	bool rmii_ref_clk_sel;
 	bool rmii_ref_clk_sel_val;
+	bool clk_enable;
 	u64 stats[ARRAY_SIZE(kszphy_hw_stats)];
 };
 
@@ -2052,6 +2054,46 @@ static void kszphy_get_stats(struct phy_device *phydev,
 		data[i] = kszphy_get_stat(phydev, i);
 }
 
+static void kszphy_enable_clk(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+
+	if (!priv->clk_enable && priv->clk) {
+		clk_prepare_enable(priv->clk);
+		priv->clk_enable = true;
+	}
+}
+
+static void kszphy_disable_clk(struct phy_device *phydev)
+{
+	struct kszphy_priv *priv = phydev->priv;
+
+	if (priv->clk_enable && priv->clk) {
+		clk_disable_unprepare(priv->clk);
+		priv->clk_enable = false;
+	}
+}
+
+static int kszphy_generic_resume(struct phy_device *phydev)
+{
+	kszphy_enable_clk(phydev);
+
+	return genphy_resume(phydev);
+}
+
+static int kszphy_generic_suspend(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_suspend(phydev);
+	if (ret)
+		return ret;
+
+	kszphy_disable_clk(phydev);
+
+	return 0;
+}
+
 static int kszphy_suspend(struct phy_device *phydev)
 {
 	/* Disable PHY Interrupts */
@@ -2061,7 +2103,7 @@ static int kszphy_suspend(struct phy_device *phydev)
 			phydev->drv->config_intr(phydev);
 	}
 
-	return genphy_suspend(phydev);
+	return kszphy_generic_suspend(phydev);
 }
 
 static void kszphy_parse_led_mode(struct phy_device *phydev)
@@ -2092,7 +2134,9 @@ static int kszphy_resume(struct phy_device *phydev)
 {
 	int ret;
 
-	genphy_resume(phydev);
+	ret = kszphy_generic_resume(phydev);
+	if (ret)
+		return ret;
 
 	/* After switching from power-down to normal mode, an internal global
 	 * reset is automatically generated. Wait a minimum of 1 ms before
@@ -2114,6 +2158,24 @@ static int kszphy_resume(struct phy_device *phydev)
 	return 0;
 }
 
+/* Because of errata DS80000700A, receiver error following software
+ * power down. Suspend and resume callbacks only disable and enable
+ * external rmii reference clock.
+ */
+static int ksz8041_resume(struct phy_device *phydev)
+{
+	kszphy_enable_clk(phydev);
+
+	return 0;
+}
+
+static int ksz8041_suspend(struct phy_device *phydev)
+{
+	kszphy_disable_clk(phydev);
+
+	return 0;
+}
+
 static int ksz9477_resume(struct phy_device *phydev)
 {
 	int ret;
@@ -2161,7 +2223,10 @@ static int ksz8061_resume(struct phy_device *phydev)
 	if (!(ret & BMCR_PDOWN))
 		return 0;
 
-	genphy_resume(phydev);
+	ret = kszphy_generic_resume(phydev);
+	if (ret)
+		return ret;
+
 	usleep_range(1000, 2000);
 
 	/* Re-program the value after chip is reset. */
@@ -2179,6 +2244,11 @@ static int ksz8061_resume(struct phy_device *phydev)
 	return 0;
 }
 
+static int ksz8061_suspend(struct phy_device *phydev)
+{
+	return kszphy_suspend(phydev);
+}
+
 static int kszphy_probe(struct phy_device *phydev)
 {
 	const struct kszphy_type *type = phydev->drv->driver_data;
@@ -2219,10 +2289,14 @@ static int kszphy_probe(struct phy_device *phydev)
 	} else if (!clk) {
 		/* unnamed clock from the generic ethernet-phy binding */
 		clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, NULL);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
 	}
 
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	clk_disable_unprepare(clk);
+	priv->clk = clk;
+
 	if (ksz8041_fiber_mode(phydev))
 		phydev->port = PORT_FIBRE;
 
@@ -5292,6 +5366,21 @@ static int lan8841_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int lan8804_resume(struct phy_device *phydev)
+{
+	return kszphy_resume(phydev);
+}
+
+static int lan8804_suspend(struct phy_device *phydev)
+{
+	return kszphy_generic_suspend(phydev);
+}
+
+static int lan8841_resume(struct phy_device *phydev)
+{
+	return kszphy_generic_resume(phydev);
+}
+
 static int lan8841_suspend(struct phy_device *phydev)
 {
 	struct kszphy_priv *priv = phydev->priv;
@@ -5300,7 +5389,7 @@ static int lan8841_suspend(struct phy_device *phydev)
 	if (ptp_priv->ptp_clock)
 		ptp_cancel_worker_sync(ptp_priv->ptp_clock);
 
-	return genphy_suspend(phydev);
+	return kszphy_generic_suspend(phydev);
 }
 
 static struct phy_driver ksphy_driver[] = {
@@ -5360,9 +5449,8 @@ static struct phy_driver ksphy_driver[] = {
 	.get_sset_count = kszphy_get_sset_count,
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
-	/* No suspend/resume callbacks because of errata DS80000700A,
-	 * receiver error following software power down.
-	 */
+	.suspend	= ksz8041_suspend,
+	.resume		= ksz8041_resume,
 }, {
 	.phy_id		= PHY_ID_KSZ8041RNLI,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
@@ -5438,7 +5526,7 @@ static struct phy_driver ksphy_driver[] = {
 	.soft_reset	= genphy_soft_reset,
 	.config_intr	= kszphy_config_intr,
 	.handle_interrupt = kszphy_handle_interrupt,
-	.suspend	= kszphy_suspend,
+	.suspend	= ksz8061_suspend,
 	.resume		= ksz8061_resume,
 }, {
 	.phy_id		= PHY_ID_KSZ9021,
@@ -5509,8 +5597,8 @@ static struct phy_driver ksphy_driver[] = {
 	.get_sset_count	= kszphy_get_sset_count,
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
-	.suspend	= genphy_suspend,
-	.resume		= kszphy_resume,
+	.suspend	= lan8804_suspend,
+	.resume		= lan8804_resume,
 	.config_intr	= lan8804_config_intr,
 	.handle_interrupt = lan8804_handle_interrupt,
 }, {
@@ -5528,7 +5616,7 @@ static struct phy_driver ksphy_driver[] = {
 	.get_strings	= kszphy_get_strings,
 	.get_stats	= kszphy_get_stats,
 	.suspend	= lan8841_suspend,
-	.resume		= genphy_resume,
+	.resume		= lan8841_resume,
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
 }, {
-- 
2.39.5




