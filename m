Return-Path: <stable+bounces-220374-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJmYNOg4o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220374-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:50:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5711C64F7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C64C732256A2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D452A3A441E;
	Sat, 28 Feb 2026 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS2RLEMR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964FC3A4414;
	Sat, 28 Feb 2026 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300269; cv=none; b=UaaXqZCOevlnOwOkeaNl1z7/3jf8+XQEwXDwKNFOuL82dMUTEz2mZtfMv23lGEVUHrmZllqwEt/YkDjp7jZPLKZBCfMIWNoy27HfkEGV3waLjkV5eITsp065PWRybYfGDsHKyf7PabM1wE4ffloNJFvPBuO151GQS3zU92fwLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300269; c=relaxed/simple;
	bh=1q1EO47DTeDmZ2QDAtWP7XcJKLHjRpu8B3ciVouXU6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7XMT6KXz0CUtwGpe19Lvd95MlRt07/AaJ6QXa8omxdiobHYoFfQznxMGV5lWhv3GDCNZq+ZrIfdk57vsaWsyT5AXNql9Pp4uUEJYqWyIpJArppaxw/AztZQa8RWc+fd/HU99aVPWGzFIUvvkR/X+GmjKNY/gfWk2EHafxAqrNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS2RLEMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF68C19425;
	Sat, 28 Feb 2026 17:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300269;
	bh=1q1EO47DTeDmZ2QDAtWP7XcJKLHjRpu8B3ciVouXU6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NS2RLEMRZrAAzn26OQH99fe5AtmI803rzoA2R46yVAlKr2Foac45G+rP/5nKCIUm5
	 ryQiMooSN3UHoqNJa9kfsFNcEmGT1oye8YzrkUg0eHaRVlnedY2pTx6D2vRIuZcbZD
	 v45Ls7B5ZFTjanvwuGmikfuPkw49148kReK5hrdxlETfVnie5+IAqxkc2Ui6GiYkMS
	 t9Gj4qCy3IF6B1rLfxi7WPFi6ePvKEi6ONNtqZPz031XLxHyfNtrQMgGWUSeZhZwQ8
	 xXoyiniu9i1fpHMQCD63LohywrOG29Ot9PjAgMf/pFCa4NiXGkNqoB6Ohj4+zu0Dfa
	 r3qb63Pgc1KHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 295/844] PCI: imx6: Add CLKREQ# override to enable REFCLK for i.MX95 PCIe
Date: Sat, 28 Feb 2026 12:23:28 -0500
Message-ID: <20260228173244.1509663-296-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220374-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EB5711C64F7
X-Rspamd-Action: no action

From: Richard Zhu <hongxing.zhu@nxp.com>

[ Upstream commit 27a064aba2da6bc58fc36a6b8e889187ae3bf89d ]

The CLKREQ# is an open drain, active low signal that is driven low by
the card to request reference clock. It's an optional signal added in
PCIe CEM r4.0, sec 2. Thus, this signal wouldn't be driven low if it's
not exposed on the slot.

On the i.MX95 EVK board, REFCLK to the host and endpoint is gated by this
CLKREQ# signal. So if the CLKREQ# signal is not driven by the endpoint, it
will gate the REFCLK to host too, leading to operational failure.

Hence, enable the REFCLK on this SoC by enabling the CLKREQ# override using
imx95_pcie_clkreq_override() helper during probe. This override should only
be cleared when the CLKREQ# signal is exposed on the slot.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
[mani: reworded description]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20251015030428.2980427-11-hongxing.zhu@nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index f28e335bbbfaf..dd69af0f195ff 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -52,6 +52,8 @@
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
 #define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
+#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
 #define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
 
 #define IMX95_PE0_GEN_CTRL_1			0x1050
@@ -706,6 +708,22 @@ static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 	return 0;
 }
 
+static void imx95_pcie_clkreq_override(struct imx_pcie *imx_pcie, bool enable)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_EN,
+			   enable ? IMX95_PCIE_CLKREQ_OVERRIDE_EN : 0);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
+			   enable ? IMX95_PCIE_CLKREQ_OVERRIDE_VAL : 0);
+}
+
+static int imx95_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	imx95_pcie_clkreq_override(imx_pcie, enable);
+	return 0;
+}
+
 static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 {
 	struct dw_pcie *pci = imx_pcie->pci;
@@ -1916,6 +1934,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
+		.enable_ref_clk = imx95_pcie_enable_ref_clk,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
@@ -1972,6 +1991,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.core_reset = imx95_pcie_core_reset,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
 		.epc_features = &imx95_pcie_epc_features,
+		.enable_ref_clk = imx95_pcie_enable_ref_clk,
 		.mode = DW_PCIE_EP_TYPE,
 	},
 };
-- 
2.51.0


