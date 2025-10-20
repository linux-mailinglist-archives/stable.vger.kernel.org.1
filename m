Return-Path: <stable+bounces-188093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A138CBF168D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC00A18841B7
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12806314A78;
	Mon, 20 Oct 2025 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGq0K1Jj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3943317702
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965204; cv=none; b=CMOMYMOMRbYb7tm7JEX8WQp8gkJz8tsWLzfYceS1nKlNMVk8H1EGwgjojugW7ny4LLbf5bFlo0WhPZQyOtp1CkgCU12odBLg3dK7znKDTfVC4w19N2Onl6FErK08u/vvDEF95VXLmUw6cR416O2/In2bBvrZXsjyb27SFqjtNt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965204; c=relaxed/simple;
	bh=wukLYNlXl2wx/01UQZmPmm5N0vyR9FuLcIyUq7QIlOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lutLkaCe61A7jtWn/fPoqrucKtcnQNaAL1PeTeWEGNeXWCHsHfdcgAOWFn1zIwEsmPJbLB6HMe2p95O1a/4MpGKmkllPMrh4pVVoAnW71nyPyY4biWnD/4bGjYXz0FRDyvPXmhhUoTsqyVyvhNaotS198SdivvNd2Hbq2szLbAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGq0K1Jj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59FDC116C6;
	Mon, 20 Oct 2025 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965204;
	bh=wukLYNlXl2wx/01UQZmPmm5N0vyR9FuLcIyUq7QIlOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AGq0K1JjSdynhiCmMjtGzuJuTH6JFB86G3fNT2PuzAECdxfIQWizB6GgbLxikVzXU
	 1t+A7SBCvKjeKBkkGh7B5KK9K26kE0yJ8ZFNTD2ec9Gk9LY8or57GJaggU3OmZNAYQ
	 DEtO5Wlx4OwKT0h0oAhnfF96W9AgCElbinkQmqyLQ2EeGtk6AZOlHgzdXtPJlA0EFk
	 HLIKvKFnsK7Tm2+KqFMTlxI2SCmibDlTpIPpsAVcjccWPiL1yBxMaS+F3d13cp7pjk
	 o9HpnoqiP0wrlPVHV+DMmaRs6dd/ZcmRF20alcOKmoEJSMLbaFqvRCTBUxIimDAVzI
	 KPc3VQr7arvcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Devarsh Thakkar <devarsht@ti.com>,
	Harikrishna Shenoy <h-shenoy@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] phy: cadence: cdns-dphy: Fix PLL lock and O_CMN_READY polling
Date: Mon, 20 Oct 2025 08:59:59 -0400
Message-ID: <20251020125959.1763029-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020125959.1763029-1-sashal@kernel.org>
References: <2025101614-sphere-flagman-052d@gregkh>
 <20251020125959.1763029-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Devarsh Thakkar <devarsht@ti.com>

[ Upstream commit 284fb19a3ffb1083c3ad9c00d29749d09dddb99c ]

PLL lockup and O_CMN_READY assertion can only happen after common state
machine gets enabled by programming DPHY_CMN_SSM register, but driver was
polling them before the common state machine was enabled which is
incorrect.  This is as per the DPHY initialization sequence as mentioned in
J721E TRM [1] at section "12.7.2.4.1.2.1 Start-up Sequence Timing Diagram".
It shows O_CMN_READY polling at the end after common configuration pin
setup where the common configuration pin setup step enables state machine
as referenced in "Table 12-1533. Common Configuration-Related Setup
mentions state machine"

To fix this :
- Add new function callbacks for polling on PLL lock and O_CMN_READY
  assertion.
- As state machine and clocks get enabled in power_on callback only, move
  the clock related programming part from configure callback to power_on
callback and poll for the PLL lockup and O_CMN_READY assertion after state
machine gets enabled.
- The configure callback only saves the PLL configuration received from the
  client driver which will be applied later on in power_on callback.
- Add checks to ensure configure is called before power_on and state
  machine is in disabled state before power_on callback is called.
- Disable state machine in power_off so that client driver can re-configure
  the PLL by following up a power_off, configure, power_on sequence.

[1]: https://www.ti.com/lit/zip/spruil1

Cc: stable@vger.kernel.org
Fixes: 7a343c8bf4b5 ("phy: Add Cadence D-PHY support")
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Tested-by: Harikrishna Shenoy <h-shenoy@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://lore.kernel.org/r/20250704125915.1224738-2-devarsht@ti.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/cadence/cdns-dphy.c | 124 +++++++++++++++++++++++---------
 1 file changed, 92 insertions(+), 32 deletions(-)

diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index 23ab48671b79c..3d62553a630d6 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -101,6 +101,8 @@ struct cdns_dphy_ops {
 	void (*set_pll_cfg)(struct cdns_dphy *dphy,
 			    const struct cdns_dphy_cfg *cfg);
 	unsigned long (*get_wakeup_time_ns)(struct cdns_dphy *dphy);
+	int (*wait_for_pll_lock)(struct cdns_dphy *dphy);
+	int (*wait_for_cmn_ready)(struct cdns_dphy *dphy);
 };
 
 struct cdns_dphy {
@@ -110,6 +112,8 @@ struct cdns_dphy {
 	struct clk *pll_ref_clk;
 	const struct cdns_dphy_ops *ops;
 	struct phy *phy;
+	bool is_configured;
+	bool is_powered;
 };
 
 /* Order of bands is important since the index is the band number. */
@@ -196,6 +200,16 @@ static unsigned long cdns_dphy_get_wakeup_time_ns(struct cdns_dphy *dphy)
 	return dphy->ops->get_wakeup_time_ns(dphy);
 }
 
+static int cdns_dphy_wait_for_pll_lock(struct cdns_dphy *dphy)
+{
+	return dphy->ops->wait_for_pll_lock ? dphy->ops->wait_for_pll_lock(dphy) : 0;
+}
+
+static int cdns_dphy_wait_for_cmn_ready(struct cdns_dphy *dphy)
+{
+	return  dphy->ops->wait_for_cmn_ready ? dphy->ops->wait_for_cmn_ready(dphy) : 0;
+}
+
 static unsigned long cdns_dphy_ref_get_wakeup_time_ns(struct cdns_dphy *dphy)
 {
 	/* Default wakeup time is 800 ns (in a simulated environment). */
@@ -237,7 +251,6 @@ static unsigned long cdns_dphy_j721e_get_wakeup_time_ns(struct cdns_dphy *dphy)
 static void cdns_dphy_j721e_set_pll_cfg(struct cdns_dphy *dphy,
 					const struct cdns_dphy_cfg *cfg)
 {
-	u32 status;
 
 	/*
 	 * set the PWM and PLL Byteclk divider settings to recommended values
@@ -254,13 +267,6 @@ static void cdns_dphy_j721e_set_pll_cfg(struct cdns_dphy *dphy,
 
 	writel(DPHY_TX_J721E_WIZ_LANE_RSTB,
 	       dphy->regs + DPHY_TX_J721E_WIZ_RST_CTRL);
-
-	readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_PLL_CTRL, status,
-			   (status & DPHY_TX_WIZ_PLL_LOCK), 0, POLL_TIMEOUT_US);
-
-	readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_STATUS, status,
-			   (status & DPHY_TX_WIZ_O_CMN_READY), 0,
-			   POLL_TIMEOUT_US);
 }
 
 static void cdns_dphy_j721e_set_psm_div(struct cdns_dphy *dphy, u8 div)
@@ -268,6 +274,23 @@ static void cdns_dphy_j721e_set_psm_div(struct cdns_dphy *dphy, u8 div)
 	writel(div, dphy->regs + DPHY_TX_J721E_WIZ_PSM_FREQ);
 }
 
+static int cdns_dphy_j721e_wait_for_pll_lock(struct cdns_dphy *dphy)
+{
+	u32 status;
+
+	return readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_PLL_CTRL, status,
+			       status & DPHY_TX_WIZ_PLL_LOCK, 0, POLL_TIMEOUT_US);
+}
+
+static int cdns_dphy_j721e_wait_for_cmn_ready(struct cdns_dphy *dphy)
+{
+	u32 status;
+
+	return readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_STATUS, status,
+			       status & DPHY_TX_WIZ_O_CMN_READY, 0,
+			       POLL_TIMEOUT_US);
+}
+
 /*
  * This is the reference implementation of DPHY hooks. Specific integration of
  * this IP may have to re-implement some of them depending on how they decided
@@ -283,6 +306,8 @@ static const struct cdns_dphy_ops j721e_dphy_ops = {
 	.get_wakeup_time_ns = cdns_dphy_j721e_get_wakeup_time_ns,
 	.set_pll_cfg = cdns_dphy_j721e_set_pll_cfg,
 	.set_psm_div = cdns_dphy_j721e_set_psm_div,
+	.wait_for_pll_lock = cdns_dphy_j721e_wait_for_pll_lock,
+	.wait_for_cmn_ready = cdns_dphy_j721e_wait_for_cmn_ready,
 };
 
 static int cdns_dphy_config_from_opts(struct phy *phy,
@@ -340,21 +365,36 @@ static int cdns_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
 static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 {
 	struct cdns_dphy *dphy = phy_get_drvdata(phy);
-	struct cdns_dphy_cfg cfg = { 0 };
-	int ret, band_ctrl;
-	unsigned int reg;
+	int ret;
 
-	ret = cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
-	if (ret)
-		return ret;
+	ret = cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &dphy->cfg);
+	if (!ret)
+		dphy->is_configured = true;
+
+	return ret;
+}
+
+static int cdns_dphy_power_on(struct phy *phy)
+{
+	struct cdns_dphy *dphy = phy_get_drvdata(phy);
+	int ret;
+	u32 reg;
+
+	if (!dphy->is_configured || dphy->is_powered)
+		return -EINVAL;
+
+	clk_prepare_enable(dphy->psm_clk);
+	clk_prepare_enable(dphy->pll_ref_clk);
 
 	/*
 	 * Configure the internal PSM clk divider so that the DPHY has a
 	 * 1MHz clk (or something close).
 	 */
 	ret = cdns_dphy_setup_psm(dphy);
-	if (ret)
-		return ret;
+	if (ret) {
+		dev_err(&dphy->phy->dev, "Failed to setup PSM with error %d\n", ret);
+		goto err_power_on;
+	}
 
 	/*
 	 * Configure attach clk lanes to data lanes: the DPHY has 2 clk lanes
@@ -369,40 +409,60 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 	 * Configure the DPHY PLL that will be used to generate the TX byte
 	 * clk.
 	 */
-	cdns_dphy_set_pll_cfg(dphy, &cfg);
+	cdns_dphy_set_pll_cfg(dphy, &dphy->cfg);
 
-	band_ctrl = cdns_dphy_tx_get_band_ctrl(opts->mipi_dphy.hs_clk_rate);
-	if (band_ctrl < 0)
-		return band_ctrl;
+	ret = cdns_dphy_tx_get_band_ctrl(dphy->cfg.hs_clk_rate);
+	if (ret < 0) {
+		dev_err(&dphy->phy->dev, "Failed to get band control value with error %d\n", ret);
+		goto err_power_on;
+	}
 
-	reg = FIELD_PREP(DPHY_BAND_CFG_LEFT_BAND, band_ctrl) |
-	      FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, band_ctrl);
+	reg = FIELD_PREP(DPHY_BAND_CFG_LEFT_BAND, ret) |
+	      FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, ret);
 	writel(reg, dphy->regs + DPHY_BAND_CFG);
 
-	return 0;
-}
-
-static int cdns_dphy_power_on(struct phy *phy)
-{
-	struct cdns_dphy *dphy = phy_get_drvdata(phy);
-
-	clk_prepare_enable(dphy->psm_clk);
-	clk_prepare_enable(dphy->pll_ref_clk);
-
 	/* Start TX state machine. */
 	writel(DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
 	       dphy->regs + DPHY_CMN_SSM);
 
+	ret = cdns_dphy_wait_for_pll_lock(dphy);
+	if (ret) {
+		dev_err(&dphy->phy->dev, "Failed to lock PLL with error %d\n", ret);
+		goto err_power_on;
+	}
+
+	ret = cdns_dphy_wait_for_cmn_ready(dphy);
+	if (ret) {
+		dev_err(&dphy->phy->dev, "O_CMN_READY signal failed to assert with error %d\n",
+			ret);
+		goto err_power_on;
+	}
+
+	dphy->is_powered = true;
+
 	return 0;
+
+err_power_on:
+	clk_disable_unprepare(dphy->pll_ref_clk);
+	clk_disable_unprepare(dphy->psm_clk);
+
+	return ret;
 }
 
 static int cdns_dphy_power_off(struct phy *phy)
 {
 	struct cdns_dphy *dphy = phy_get_drvdata(phy);
+	u32 reg;
 
 	clk_disable_unprepare(dphy->pll_ref_clk);
 	clk_disable_unprepare(dphy->psm_clk);
 
+	/* Stop TX state machine. */
+	reg = readl(dphy->regs + DPHY_CMN_SSM);
+	writel(reg & ~DPHY_CMN_SSM_EN, dphy->regs + DPHY_CMN_SSM);
+
+	dphy->is_powered = false;
+
 	return 0;
 }
 
-- 
2.51.0


