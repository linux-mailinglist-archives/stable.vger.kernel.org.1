Return-Path: <stable+bounces-204870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B37CF507C
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D01373047911
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 17:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2B6337B8C;
	Mon,  5 Jan 2026 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANOqIV/h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A7320A2C
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634464; cv=none; b=cIdEBxawJW7Cpv1h70nzPBZv1I+o0eEUSmpaUpFr+o5ZgbCc0p7x1woafI2Sb87HXiQC3wzzaL8U2mTi70E+WKD1mNOy1xEDHaMIUS6bz2F4zgc6SIou339V2Hrmhz4fCAKpiGEVQkzAn58W4oBG6d3X5CzpOn4YYkhlGiLtVNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634464; c=relaxed/simple;
	bh=tzJjOuk8+y9A+NwikQdvSYbtuZrD6PGFbmXXZcZYerg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7txJoswGecQ+IesbHKIdD/h9hvW8Z5X4z+MbMDO9LLbzmwdBtsOeReHSALoBytzT5B9bnspuYo/fseq6A3knpIx0RuasCPHSwDiM8p6XULI1M+0XSFcKc/i+goPI+p/1Z8pDxwZrbnPDArr7haLpe9p/rv78Yqg+ohmKHXkQEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANOqIV/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994FEC19421;
	Mon,  5 Jan 2026 17:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767634464;
	bh=tzJjOuk8+y9A+NwikQdvSYbtuZrD6PGFbmXXZcZYerg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ANOqIV/hTqL1pgv2AV1csH9TLQ8ukFhja3DaZ0qhvvAEE6u9CGiaF2umKvJOYm7rh
	 Uj2JrUkWqU3zqUQGmfQ80iD4ua3RcSZE19CoLunVBt49KuwXJJtm/KCDZurQX05SGe
	 tJRX6Yb8EQWWeVKVVl0C2HwYvMJy8p9pCadThGsyZLFdzqlqUSKq7M03SK/Mhy+xxq
	 oXHSBZffvPrNbFW+Qg6ajkQoa9U2K1i9t55ZN98yvn6kWqC7u+8uwW9RIvbnOXGkUq
	 0PRKbRjQRDpiom0Z7q1+X+zjy/BIQT+N6vArbw+9vya93/MI7/rWmCDwGPSq43QnOM
	 Ti6W6FNXy3zEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanimir Varbanov <svarbanov@suse.de>,
	Florian Fainelil <florian.fainelli@broadcom.com>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	"Ivan T. Ivanov" <iivanov@suse.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] PCI: brcmstb: Reuse pcie_cfg_data structure
Date: Mon,  5 Jan 2026 12:34:18 -0500
Message-ID: <20260105173420.2692565-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010519-syndrome-eccentric-90f2@gregkh>
References: <2026010519-syndrome-eccentric-90f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stanimir Varbanov <svarbanov@suse.de>

[ Upstream commit 10dbedad3c8188ce8b68559d43b7aaee7dafba25 ]

Instead of copying fields from the pcie_cfg_data structure to
brcm_pcie, reference it directly.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelil <florian.fainelli@broadcom.com>
Reviewed-by: Jim Quinlan <james.quinlan@broadcom.com>
Tested-by: Ivan T. Ivanov <iivanov@suse.de>
Link: https://lore.kernel.org/r/20250224083559.47645-6-svarbanov@suse.de
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Stable-dep-of: 9583f9d22991 ("PCI: brcmstb: Fix disabling L0s capability")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 72 ++++++++++++---------------
 1 file changed, 32 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 81f085cebf62..62e1d661ee0b 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -191,11 +191,11 @@
 #define SSC_STATUS_PLL_LOCK_MASK	0x800
 #define PCIE_BRCM_MAX_MEMC		3
 
-#define IDX_ADDR(pcie)			((pcie)->reg_offsets[EXT_CFG_INDEX])
-#define DATA_ADDR(pcie)			((pcie)->reg_offsets[EXT_CFG_DATA])
-#define PCIE_RGR1_SW_INIT_1(pcie)	((pcie)->reg_offsets[RGR1_SW_INIT_1])
-#define HARD_DEBUG(pcie)		((pcie)->reg_offsets[PCIE_HARD_DEBUG])
-#define INTR2_CPU_BASE(pcie)		((pcie)->reg_offsets[PCIE_INTR2_CPU_BASE])
+#define IDX_ADDR(pcie)			((pcie)->cfg->offsets[EXT_CFG_INDEX])
+#define DATA_ADDR(pcie)			((pcie)->cfg->offsets[EXT_CFG_DATA])
+#define PCIE_RGR1_SW_INIT_1(pcie)	((pcie)->cfg->offsets[RGR1_SW_INIT_1])
+#define HARD_DEBUG(pcie)		((pcie)->cfg->offsets[PCIE_HARD_DEBUG])
+#define INTR2_CPU_BASE(pcie)		((pcie)->cfg->offsets[PCIE_INTR2_CPU_BASE])
 
 /* Rescal registers */
 #define PCIE_DVT_PMU_PCIE_PHY_CTRL				0xc700
@@ -276,8 +276,6 @@ struct brcm_pcie {
 	int			gen;
 	u64			msi_target_addr;
 	struct brcm_msi		*msi;
-	const int		*reg_offsets;
-	enum pcie_soc_base	soc_base;
 	struct reset_control	*rescal;
 	struct reset_control	*perst_reset;
 	struct reset_control	*bridge_reset;
@@ -285,17 +283,14 @@ struct brcm_pcie {
 	int			num_memc;
 	u64			memc_size[PCIE_BRCM_MAX_MEMC];
 	u32			hw_rev;
-	int			(*perst_set)(struct brcm_pcie *pcie, u32 val);
-	int			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	struct subdev_regulators *sr;
 	bool			ep_wakeup_capable;
-	bool			has_phy;
-	u8			num_inbound_wins;
+	const struct pcie_cfg_data	*cfg;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
 {
-	return pcie->soc_base == BCM7435 || pcie->soc_base == BCM7425;
+	return pcie->cfg->soc_base == BCM7435 || pcie->cfg->soc_base == BCM7425;
 }
 
 /*
@@ -855,7 +850,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 	 * security considerations, and is not implemented in our modern
 	 * SoCs.
 	 */
-	if (pcie->soc_base != BCM7712)
+	if (pcie->cfg->soc_base != BCM7712)
 		add_inbound_win(b++, &n, 0, 0, 0);
 
 	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
@@ -872,10 +867,10 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 		 * That being said, each BARs size must still be a power of
 		 * two.
 		 */
-		if (pcie->soc_base == BCM7712)
+		if (pcie->cfg->soc_base == BCM7712)
 			add_inbound_win(b++, &n, size, cpu_start, pcie_start);
 
-		if (n > pcie->num_inbound_wins)
+		if (n > pcie->cfg->num_inbound_wins)
 			break;
 	}
 
@@ -889,7 +884,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 	 * that enables multiple memory controllers.  As such, it can return
 	 * now w/o doing special configuration.
 	 */
-	if (pcie->soc_base == BCM7712)
+	if (pcie->cfg->soc_base == BCM7712)
 		return n;
 
 	ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
@@ -1012,7 +1007,7 @@ static void set_inbound_win_registers(struct brcm_pcie *pcie,
 		 * 7712:
 		 *     All of their BARs need to be set.
 		 */
-		if (pcie->soc_base == BCM7712) {
+		if (pcie->cfg->soc_base == BCM7712) {
 			/* BUS remap register settings */
 			reg_offset = brcm_ubus_reg_offset(i);
 			tmp = lower_32_bits(cpu_addr) & ~0xfff;
@@ -1036,15 +1031,15 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	int memc, ret;
 
 	/* Reset the bridge */
-	ret = pcie->bridge_sw_init_set(pcie, 1);
+	ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
 	if (ret)
 		return ret;
 
 	/* Ensure that PERST# is asserted; some bootloaders may deassert it. */
-	if (pcie->soc_base == BCM2711) {
-		ret = pcie->perst_set(pcie, 1);
+	if (pcie->cfg->soc_base == BCM2711) {
+		ret = pcie->cfg->perst_set(pcie, 1);
 		if (ret) {
-			pcie->bridge_sw_init_set(pcie, 0);
+			pcie->cfg->bridge_sw_init_set(pcie, 0);
 			return ret;
 		}
 	}
@@ -1052,7 +1047,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-	ret = pcie->bridge_sw_init_set(pcie, 0);
+	ret = pcie->cfg->bridge_sw_init_set(pcie, 0);
 	if (ret)
 		return ret;
 
@@ -1072,9 +1067,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	 */
 	if (is_bmips(pcie))
 		burst = 0x1; /* 256 bytes */
-	else if (pcie->soc_base == BCM2711)
+	else if (pcie->cfg->soc_base == BCM2711)
 		burst = 0x0; /* 128 bytes */
-	else if (pcie->soc_base == BCM7278)
+	else if (pcie->cfg->soc_base == BCM7278)
 		burst = 0x3; /* 512 bytes */
 	else
 		burst = 0x2; /* 512 bytes */
@@ -1199,7 +1194,7 @@ static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
 	u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */
 
 	/* 7712 does not have this (RGR1) timer */
-	if (pcie->soc_base == BCM7712)
+	if (pcie->cfg->soc_base == BCM7712)
 		return;
 
 	/* Each unit in timeout register is 1/216,000,000 seconds */
@@ -1281,7 +1276,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 		brcm_pcie_set_gen(pcie, pcie->gen);
 
 	/* Unassert the fundamental reset */
-	ret = pcie->perst_set(pcie, 0);
+	ret = pcie->cfg->perst_set(pcie, 0);
 	if (ret)
 		return ret;
 
@@ -1465,12 +1460,12 @@ static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
 
 static inline int brcm_phy_start(struct brcm_pcie *pcie)
 {
-	return pcie->has_phy ? brcm_phy_cntl(pcie, 1) : 0;
+	return pcie->cfg->has_phy ? brcm_phy_cntl(pcie, 1) : 0;
 }
 
 static inline int brcm_phy_stop(struct brcm_pcie *pcie)
 {
-	return pcie->has_phy ? brcm_phy_cntl(pcie, 0) : 0;
+	return pcie->cfg->has_phy ? brcm_phy_cntl(pcie, 0) : 0;
 }
 
 static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
@@ -1481,7 +1476,7 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	if (brcm_pcie_link_up(pcie))
 		brcm_pcie_enter_l23(pcie);
 	/* Assert fundamental reset */
-	ret = pcie->perst_set(pcie, 1);
+	ret = pcie->cfg->perst_set(pcie, 1);
 	if (ret)
 		return ret;
 
@@ -1496,7 +1491,7 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	writel(tmp, base + HARD_DEBUG(pcie));
 
 	/* Shutdown PCIe bridge */
-	ret = pcie->bridge_sw_init_set(pcie, 1);
+	ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
 
 	return ret;
 }
@@ -1584,7 +1579,7 @@ static int brcm_pcie_resume_noirq(struct device *dev)
 		goto err_reset;
 
 	/* Take bridge out of reset so we can access the SERDES reg */
-	pcie->bridge_sw_init_set(pcie, 0);
+	pcie->cfg->bridge_sw_init_set(pcie, 0);
 
 	/* SERDES_IDDQ = 0 */
 	tmp = readl(base + HARD_DEBUG(pcie));
@@ -1805,12 +1800,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie = pci_host_bridge_priv(bridge);
 	pcie->dev = &pdev->dev;
 	pcie->np = np;
-	pcie->reg_offsets = data->offsets;
-	pcie->soc_base = data->soc_base;
-	pcie->perst_set = data->perst_set;
-	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
-	pcie->has_phy = data->has_phy;
-	pcie->num_inbound_wins = data->num_inbound_wins;
+	pcie->cfg = data;
 
 	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
@@ -1845,7 +1835,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
 
-	pcie->bridge_sw_init_set(pcie, 0);
+	pcie->cfg->bridge_sw_init_set(pcie, 0);
 
 	if (pcie->swinit_reset) {
 		ret = reset_control_assert(pcie->swinit_reset);
@@ -1884,7 +1874,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		goto fail;
 
 	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
-	if (pcie->soc_base == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
+	if (pcie->cfg->soc_base == BCM4908 &&
+	    pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
 		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
 		ret = -ENODEV;
 		goto fail;
@@ -1904,7 +1895,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	bridge->ops = pcie->soc_base == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
+	bridge->ops = pcie->cfg->soc_base == BCM7425 ?
+				&brcm7425_pcie_ops : &brcm_pcie_ops;
 	bridge->sysdata = pcie;
 
 	platform_set_drvdata(pdev, pcie);
-- 
2.51.0


