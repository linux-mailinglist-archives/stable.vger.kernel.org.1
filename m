Return-Path: <stable+bounces-223351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELNvNirtqmmOYAEAu9opvQ
	(envelope-from <stable+bounces-223351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:05:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CF5223686
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9148300361C
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 15:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9F93B3BE6;
	Fri,  6 Mar 2026 15:05:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0403AE70A
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809511; cv=none; b=BpRJbZeJiD7wXolEG6qOaLrVb9xcgn51PltcNmGt4uBMjHATFOV4VoXE3aFT5RMvreADCPO5aDShMIlItEV7JBohny7lckU+0WaWg/DvNl3w7BOrONWUJltP/MoyJ6t54DpL8ZpQv0mlLbZ2TJkn9zgzZmeGYOq8JDrUHhAE51Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809511; c=relaxed/simple;
	bh=trDOJu4mFHCbvhBMY/tOcFi4iK7zKvUX1Gb3GzYMhSg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGNiku0Mfz+OzSfxfrSRlpR6JCQw2mtjyeks/Qfm8VP2GZQjLluA3ioLTchRzkckXE4xdwg1u88DyXb80w/n2H3ISmEPUA/OhXre2gR7uDh37eq3ftUHAfFeVOuFPH6sinkU/VEYexjF08coR6IG11Ki3cMpd1GJylRbTBVdoBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: CcjgCPbRS1uXYI7fxloiDw==
X-CSE-MsgGUID: fa2z+ZDKSX69iTL/ntwd6w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Mar 2026 00:05:05 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.247])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 541F041C07C8
	for <stable@vger.kernel.org>; Sat,  7 Mar 2026 00:05:05 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 1/1] net: stmmac: remove support for lpi_intr_o
Date: Fri,  6 Mar 2026 15:05:02 +0000
Message-ID: <20260306150502.23713-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306150502.23713-1-ovidiu.panait.rb@renesas.com>
References: <20260306150502.23713-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 78CF5223686
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-223351-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.088];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,renesas.com:mid,renesas.com:email,armlinux.org.uk:email]
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
index 23ec3a59ca8f..9e012720a69f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -381,7 +381,6 @@ enum request_irq_err {
 	REQ_IRQ_ERR_SFTY,
 	REQ_IRQ_ERR_SFTY_UE,
 	REQ_IRQ_ERR_SFTY_CE,
-	REQ_IRQ_ERR_LPI,
 	REQ_IRQ_ERR_WOL,
 	REQ_IRQ_ERR_MAC,
 	REQ_IRQ_ERR_NO,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index b2194e414ec1..47fda982d6b1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -759,7 +759,6 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 
 	/* Setup MSI vector offset specific to Intel mGbE controller */
 	plat->msi_mac_vec = 29;
-	plat->msi_lpi_vec = 28;
 	plat->msi_sfty_ce_vec = 27;
 	plat->msi_sfty_ue_vec = 26;
 	plat->msi_rx_base_vec = 0;
@@ -1217,8 +1216,6 @@ static int stmmac_config_multi_msi(struct pci_dev *pdev,
 		res->irq = pci_irq_vector(pdev, plat->msi_mac_vec);
 	if (plat->msi_wol_vec < STMMAC_MSI_VEC_MAX)
 		res->wol_irq = pci_irq_vector(pdev, plat->msi_wol_vec);
-	if (plat->msi_lpi_vec < STMMAC_MSI_VEC_MAX)
-		res->lpi_irq = pci_irq_vector(pdev, plat->msi_lpi_vec);
 	if (plat->msi_sfty_ce_vec < STMMAC_MSI_VEC_MAX)
 		res->sfty_ce_irq = pci_irq_vector(pdev, plat->msi_sfty_ce_vec);
 	if (plat->msi_sfty_ue_vec < STMMAC_MSI_VEC_MAX)
@@ -1334,7 +1331,6 @@ static int intel_eth_pci_probe(struct pci_dev *pdev,
 	 */
 	plat->msi_mac_vec = STMMAC_MSI_VEC_MAX;
 	plat->msi_wol_vec = STMMAC_MSI_VEC_MAX;
-	plat->msi_lpi_vec = STMMAC_MSI_VEC_MAX;
 	plat->msi_sfty_ce_vec = STMMAC_MSI_VEC_MAX;
 	plat->msi_sfty_ue_vec = STMMAC_MSI_VEC_MAX;
 	plat->msi_rx_base_vec = STMMAC_MSI_VEC_MAX;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 47bc3aeee857..ab431bf9b25f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -465,13 +465,6 @@ static int loongson_dwmac_dt_config(struct pci_dev *pdev,
 		res->wol_irq = res->irq;
 	}
 
-	res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
-	if (res->lpi_irq < 0) {
-		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
-		ret = -ENODEV;
-		goto err_put_node;
-	}
-
 	ret = device_get_phy_mode(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "phy_mode not found\n");
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7ca5477be390..c42cead28de9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -29,7 +29,6 @@ struct stmmac_resources {
 	void __iomem *addr;
 	u8 mac[ETH_ALEN];
 	int wol_irq;
-	int lpi_irq;
 	int irq;
 	int sfty_irq;
 	int sfty_ce_irq;
@@ -291,7 +290,6 @@ struct stmmac_priv {
 	int wol_irq;
 	u32 gmii_address_bus_config;
 	struct timer_list eee_ctrl_timer;
-	int lpi_irq;
 	u32 tx_lpi_timer;
 	bool tx_lpi_clk_stop;
 	bool eee_enabled;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 46299b7925b4..754b36e733eb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3579,10 +3579,6 @@ static void stmmac_free_irq(struct net_device *dev,
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
@@ -3640,24 +3636,6 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
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
 	/* Request the common Safety Feature Correctible/Uncorrectible
 	 * Error line in case of another line is used
 	 */
@@ -3797,19 +3775,6 @@ static int stmmac_request_irq_single(struct net_device *dev)
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
 	/* Request the common Safety Feature Correctible/Uncorrectible
 	 * Error line in case of another line is used
 	 */
@@ -7445,7 +7410,6 @@ int stmmac_dvr_probe(struct device *device,
 
 	priv->dev->irq = res->irq;
 	priv->wol_irq = res->wol_irq;
-	priv->lpi_irq = res->lpi_irq;
 	priv->sfty_irq = res->sfty_irq;
 	priv->sfty_ce_irq = res->sfty_ce_irq;
 	priv->sfty_ue_irq = res->sfty_ue_irq;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index fbb92cc6ab59..0cb51935c405 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -761,14 +761,6 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
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
 	stmmac_res->sfty_irq =
 		platform_get_irq_byname_optional(pdev, "sfty");
 	if (stmmac_res->sfty_irq < 0) {
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 151c81c560c8..7e989d0edead 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -296,7 +296,6 @@ struct plat_stmmacenet_data {
 	int int_snapshot_num;
 	int msi_mac_vec;
 	int msi_wol_vec;
-	int msi_lpi_vec;
 	int msi_sfty_ce_vec;
 	int msi_sfty_ue_vec;
 	int msi_rx_base_vec;
-- 
2.34.1


