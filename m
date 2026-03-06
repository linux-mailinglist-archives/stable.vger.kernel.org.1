Return-Path: <stable+bounces-223355-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAdlAN3uqmmOYAEAu9opvQ
	(envelope-from <stable+bounces-223355-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:12:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 736882238D1
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 16:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C845306151C
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 15:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21803AE6FB;
	Fri,  6 Mar 2026 15:07:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19B02C11FA
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809626; cv=none; b=hjiEIPwjJVLWJyQ8Mm1UrerYuSR+jDJGFrsiOu4s4k2NgO+60XS+3CW9usG1Hzc+7zb6OYdkUkWQEmhw0Ezqdz1In0BQdCpUCZBYE56G9d+UckFe4EziQQlbzatFmXzU8NYuKwp2qpak829kyQhhczDnj8GvWmEXr4TPH5xeCxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809626; c=relaxed/simple;
	bh=EkF9kUSWsXcJ0i9cqsXgzSD+goz3CH85iitP2PSRPZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSQJgL7D6/1PZBcY7o2QUBAxYgjTnJbyYcyUPI6TC8vCqTcnv6SVo/4imRARH7sGv9PQ4Kf4IczHR3eNFdkHs7mxvDv28VrmEoXxke1voOkJyNsHNeoWTxi0rocnMZyxkJjkXZ6f0CopunKtkTa8xf7sWdRN80fvyg3LWSpRORE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 72Xd1KuOSMybYrZyqbmmKg==
X-CSE-MsgGUID: Eqj4VwQJTBOwySxC48G5+w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Mar 2026 00:07:03 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.247])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 795CC41C17FF;
	Sat,  7 Mar 2026 00:07:02 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: stable@vger.kernel.org
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 1/1] net: stmmac: remove support for lpi_intr_o
Date: Fri,  6 Mar 2026 15:06:56 +0000
Message-ID: <20260306150656.23781-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306150656.23781-1-ovidiu.panait.rb@renesas.com>
References: <20260306150656.23781-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 736882238D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[renesas.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223355-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.821];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable,kernel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,armlinux.org.uk:email]
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
index 4dbc076f72d6..c74de09181c6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -371,7 +371,6 @@ enum request_irq_err {
 	REQ_IRQ_ERR_RX,
 	REQ_IRQ_ERR_SFTY_UE,
 	REQ_IRQ_ERR_SFTY_CE,
-	REQ_IRQ_ERR_LPI,
 	REQ_IRQ_ERR_WOL,
 	REQ_IRQ_ERR_MAC,
 	REQ_IRQ_ERR_NO,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index a3a249c63598..dbe3b12d3f17 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -612,7 +612,6 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 
 	/* Setup MSI vector offset specific to Intel mGbE controller */
 	plat->msi_mac_vec = 29;
-	plat->msi_lpi_vec = 28;
 	plat->msi_sfty_ce_vec = 27;
 	plat->msi_sfty_ue_vec = 26;
 	plat->msi_rx_base_vec = 0;
@@ -998,8 +997,6 @@ static int stmmac_config_multi_msi(struct pci_dev *pdev,
 		res->irq = pci_irq_vector(pdev, plat->msi_mac_vec);
 	if (plat->msi_wol_vec < STMMAC_MSI_VEC_MAX)
 		res->wol_irq = pci_irq_vector(pdev, plat->msi_wol_vec);
-	if (plat->msi_lpi_vec < STMMAC_MSI_VEC_MAX)
-		res->lpi_irq = pci_irq_vector(pdev, plat->msi_lpi_vec);
 	if (plat->msi_sfty_ce_vec < STMMAC_MSI_VEC_MAX)
 		res->sfty_ce_irq = pci_irq_vector(pdev, plat->msi_sfty_ce_vec);
 	if (plat->msi_sfty_ue_vec < STMMAC_MSI_VEC_MAX)
@@ -1081,7 +1078,6 @@ static int intel_eth_pci_probe(struct pci_dev *pdev,
 	 */
 	plat->msi_mac_vec = STMMAC_MSI_VEC_MAX;
 	plat->msi_wol_vec = STMMAC_MSI_VEC_MAX;
-	plat->msi_lpi_vec = STMMAC_MSI_VEC_MAX;
 	plat->msi_sfty_ce_vec = STMMAC_MSI_VEC_MAX;
 	plat->msi_sfty_ue_vec = STMMAC_MSI_VEC_MAX;
 	plat->msi_rx_base_vec = STMMAC_MSI_VEC_MAX;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index bdeec098309a..729f989cfe58 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -138,13 +138,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
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
index 85a55f459af0..61c8fc97a421 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -29,7 +29,6 @@ struct stmmac_resources {
 	void __iomem *addr;
 	u8 mac[ETH_ALEN];
 	int wol_irq;
-	int lpi_irq;
 	int irq;
 	int sfty_ce_irq;
 	int sfty_ue_irq;
@@ -260,7 +259,6 @@ struct stmmac_priv {
 	bool wol_irq_disabled;
 	int clk_csr;
 	struct timer_list eee_ctrl_timer;
-	int lpi_irq;
 	int eee_enabled;
 	int eee_active;
 	int tx_lpi_timer;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7a8861d77e04..17e7f6e0a3b6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3496,10 +3496,6 @@ static void stmmac_free_irq(struct net_device *dev,
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
@@ -3554,24 +3550,6 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
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
@@ -3695,19 +3673,6 @@ static int stmmac_request_irq_single(struct net_device *dev)
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
@@ -7426,7 +7391,6 @@ int stmmac_dvr_probe(struct device *device,
 
 	priv->dev->irq = res->irq;
 	priv->wol_irq = res->wol_irq;
-	priv->lpi_irq = res->lpi_irq;
 	priv->sfty_ce_irq = res->sfty_ce_irq;
 	priv->sfty_ue_irq = res->sfty_ue_irq;
 	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 6c684f6ee84b..1888a549983c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -762,14 +762,6 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
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
index 42ff5a4de8ee..a0c28b8d6c51 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -306,7 +306,6 @@ struct plat_stmmacenet_data {
 	int ext_snapshot_num;
 	int msi_mac_vec;
 	int msi_wol_vec;
-	int msi_lpi_vec;
 	int msi_sfty_ce_vec;
 	int msi_sfty_ue_vec;
 	int msi_rx_base_vec;
-- 
2.34.1


