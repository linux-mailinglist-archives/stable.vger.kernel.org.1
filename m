Return-Path: <stable+bounces-223357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EZ8C0PuqmmOYAEAu9opvQ
	(envelope-from <stable+bounces-223357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:09:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC2E22382D
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59780307D622
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCF33AEF2C;
	Fri,  6 Mar 2026 15:07:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016A43AE70A
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809647; cv=none; b=ri6nhuvroq68kp+hdPrRNqLg9IebjMdjZpKLvAstbHivij9++EGya0LTytoDvuUs+SAMSlyIa5UK203F300pPf7KmmR241/q03AKLXZL17SqMHEvMfG7JwDy162CJ0EAbbrrrTvX0d2Ied9Cki0CXkscBRjCNSJytcQj7V8vRkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809647; c=relaxed/simple;
	bh=NiOiKU4kiaSK20u5TSFHxKmorp0gMAbdS92gzx1FFjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhrz8LJIOky1m8DigyhnNN26kcoYXvoe+9G8xx3+xwGJQWdsZMeUaupQxY77dGyKyHLuJvy+kNY+/hD9s5qAcsaW3XBo1hHxi+2OhAvozKNJoZDUnNLRF+R4QFaAzt7yDcOk/bqtGf0JxQLJlLEO0TFN++hGxI70F7LJRomQIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: YGFVpjApR9uszQjtg65Y8Q==
X-CSE-MsgGUID: HjEoU57dR6yG/UKNjUjHLA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 Mar 2026 00:07:24 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.247])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 39FEA40061A7;
	Sat,  7 Mar 2026 00:07:22 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: stable@vger.kernel.org
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 1/1] net: stmmac: remove support for lpi_intr_o
Date: Fri,  6 Mar 2026 15:07:18 +0000
Message-ID: <20260306150718.23811-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306150718.23811-1-ovidiu.panait.rb@renesas.com>
References: <20260306150718.23811-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7BC2E22382D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223357-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.825];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:mid,renesas.com:email,armlinux.org.uk:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

commit 14eb64db8ff07b58a35b98375f446d9e20765674 upstream.

The dwmac databook for v3.74a states that lpi_intr_o is a sideband
signal which should be used to ungate the application clock, and this
signal is synchronous to the receive clock. The receive clock can run
at 2.5, 25 or 125MHz depending on the media speed, and can stop under
the control of the link partner. This means that the time it takes to
clear is dependent on the negotiated media speed, and thus can be 8,
40, or 400ns after reading the LPI control and status register.

It has been observed with some aggressive link partners, this clock
can stop while lpi_intr_o is still asserted, meaning that the signal
remains asserted for an indefinite period that the local system has
no direct control over.

The LPI interrupts will still be signalled through the main interrupt
path in any case, and this path is not dependent on the receive clock.

This, since we do not gate the application clock, and the chances of
adding clock gating in the future are slim due to the clocks being
ill-defined, lpi_intr_o serves no useful purpose. Remove the code which
requests the interrupt, and all associated code.

Reported-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Tested-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com> # Renesas RZ/V2H board
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/E1vnJbt-00000007YYN-28nm@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 -
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 ---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  |  7 ----
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 --
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 36 -------------------
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 -----
 include/linux/stmmac.h                        |  1 -
 7 files changed, 59 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 09db9d52f98c..517b2e24d2f8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -346,7 +346,6 @@ enum request_irq_err {
 	REQ_IRQ_ERR_RX,
 	REQ_IRQ_ERR_SFTY_UE,
 	REQ_IRQ_ERR_SFTY_CE,
-	REQ_IRQ_ERR_LPI,
 	REQ_IRQ_ERR_WOL,
 	REQ_IRQ_ERR_MAC,
 	REQ_IRQ_ERR_NO,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index ab9f876b6df7..4f508426a871 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -614,7 +614,6 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 
 	/* Setup MSI vector offset specific to Intel mGbE controller */
 	plat->msi_mac_vec = 29;
-	plat->msi_lpi_vec = 28;
 	plat->msi_sfty_ce_vec = 27;
 	plat->msi_sfty_ue_vec = 26;
 	plat->msi_rx_base_vec = 0;
@@ -999,8 +998,6 @@ static int stmmac_config_multi_msi(struct pci_dev *pdev,
 		res->irq = pci_irq_vector(pdev, plat->msi_mac_vec);
 	if (plat->msi_wol_vec < STMMAC_MSI_VEC_MAX)
 		res->wol_irq = pci_irq_vector(pdev, plat->msi_wol_vec);
-	if (plat->msi_lpi_vec < STMMAC_MSI_VEC_MAX)
-		res->lpi_irq = pci_irq_vector(pdev, plat->msi_lpi_vec);
 	if (plat->msi_sfty_ce_vec < STMMAC_MSI_VEC_MAX)
 		res->sfty_ce_irq = pci_irq_vector(pdev, plat->msi_sfty_ce_vec);
 	if (plat->msi_sfty_ue_vec < STMMAC_MSI_VEC_MAX)
@@ -1082,7 +1079,6 @@ static int intel_eth_pci_probe(struct pci_dev *pdev,
 	 */
 	plat->msi_mac_vec = STMMAC_MSI_VEC_MAX;
 	plat->msi_wol_vec = STMMAC_MSI_VEC_MAX;
-	plat->msi_lpi_vec = STMMAC_MSI_VEC_MAX;
 	plat->msi_sfty_ce_vec = STMMAC_MSI_VEC_MAX;
 	plat->msi_sfty_ue_vec = STMMAC_MSI_VEC_MAX;
 	plat->msi_rx_base_vec = STMMAC_MSI_VEC_MAX;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 472ea1bb454c..598b9774cf70 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -135,13 +135,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		res.wol_irq = res.irq;
 	}
 
-	res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
-	if (res.lpi_irq < 0) {
-		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
-		ret = -ENODEV;
-		goto err_disable_msi;
-	}
-
 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
 	if (ret)
 		goto err_disable_msi;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b9b41dd18cde..0b9cc3fbf5d6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -28,7 +28,6 @@ struct stmmac_resources {
 	void __iomem *addr;
 	u8 mac[ETH_ALEN];
 	int wol_irq;
-	int lpi_irq;
 	int irq;
 	int sfty_ce_irq;
 	int sfty_ue_irq;
@@ -254,7 +253,6 @@ struct stmmac_priv {
 	bool wol_irq_disabled;
 	int clk_csr;
 	struct timer_list eee_ctrl_timer;
-	int lpi_irq;
 	int eee_enabled;
 	int eee_active;
 	int tx_lpi_timer;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b5de07b84f77..07278f116782 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3497,10 +3497,6 @@ static void stmmac_free_irq(struct net_device *dev,
 			free_irq(priv->sfty_ce_irq, dev);
 		fallthrough;
 	case REQ_IRQ_ERR_SFTY_CE:
-		if (priv->lpi_irq > 0 && priv->lpi_irq != dev->irq)
-			free_irq(priv->lpi_irq, dev);
-		fallthrough;
-	case REQ_IRQ_ERR_LPI:
 		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
 			free_irq(priv->wol_irq, dev);
 		fallthrough;
@@ -3555,24 +3551,6 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		}
 	}
 
-	/* Request the LPI IRQ in case of another line
-	 * is used for LPI
-	 */
-	if (priv->lpi_irq > 0 && priv->lpi_irq != dev->irq) {
-		int_name = priv->int_name_lpi;
-		sprintf(int_name, "%s:%s", dev->name, "lpi");
-		ret = request_irq(priv->lpi_irq,
-				  stmmac_mac_interrupt,
-				  0, int_name, dev);
-		if (unlikely(ret < 0)) {
-			netdev_err(priv->dev,
-				   "%s: alloc lpi MSI %d (error: %d)\n",
-				   __func__, priv->lpi_irq, ret);
-			irq_err = REQ_IRQ_ERR_LPI;
-			goto irq_error;
-		}
-	}
-
 	/* Request the Safety Feature Correctible Error line in
 	 * case of another line is used
 	 */
@@ -3696,19 +3674,6 @@ static int stmmac_request_irq_single(struct net_device *dev)
 		}
 	}
 
-	/* Request the IRQ lines */
-	if (priv->lpi_irq > 0 && priv->lpi_irq != dev->irq) {
-		ret = request_irq(priv->lpi_irq, stmmac_interrupt,
-				  IRQF_SHARED, dev->name, dev);
-		if (unlikely(ret < 0)) {
-			netdev_err(priv->dev,
-				   "%s: ERROR: allocating the LPI IRQ %d (%d)\n",
-				   __func__, priv->lpi_irq, ret);
-			irq_err = REQ_IRQ_ERR_LPI;
-			goto irq_error;
-		}
-	}
-
 	return 0;
 
 irq_error:
@@ -7249,7 +7214,6 @@ int stmmac_dvr_probe(struct device *device,
 
 	priv->dev->irq = res->irq;
 	priv->wol_irq = res->wol_irq;
-	priv->lpi_irq = res->lpi_irq;
 	priv->sfty_ce_irq = res->sfty_ce_irq;
 	priv->sfty_ue_irq = res->sfty_ue_irq;
 	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index e81f54a4ac9b..8ea3fa917568 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -758,14 +758,6 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 		stmmac_res->wol_irq = stmmac_res->irq;
 	}
 
-	stmmac_res->lpi_irq =
-		platform_get_irq_byname_optional(pdev, "eth_lpi");
-	if (stmmac_res->lpi_irq < 0) {
-		if (stmmac_res->lpi_irq == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
-	}
-
 	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
 
 	return PTR_ERR_OR_ZERO(stmmac_res->addr);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 7c7553efa698..06e879cdbff8 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -284,7 +284,6 @@ struct plat_stmmacenet_data {
 	bool multi_msi_en;
 	int msi_mac_vec;
 	int msi_wol_vec;
-	int msi_lpi_vec;
 	int msi_sfty_ce_vec;
 	int msi_sfty_ue_vec;
 	int msi_rx_base_vec;
-- 
2.34.1


