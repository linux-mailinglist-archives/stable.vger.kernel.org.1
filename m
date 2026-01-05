Return-Path: <stable+bounces-204871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF03CF507F
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2076630519FF
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 17:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E052D339B3C;
	Mon,  5 Jan 2026 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX3cuX26"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1490320A2C
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634465; cv=none; b=HHvWpSpvPOlYGeYyPtfiNoW3CphSQl3WUr6MWVePU+fOAKy8k3SDsvhfQFbAmfgZjyW4aseP9vZSWpD5OdtA0SjVnWAiVeLdN+5pu87e9RBAo08Hq97gTwq1rZYezzL2NzOpY8Q+fKDlvhi6jYIp0BTQNETk7Z6iQ0OewldPBPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634465; c=relaxed/simple;
	bh=rCADN311Ydf2a6eYmwH30EFjEy+14ONeqP6EDj5rG0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FF8Rmwwde6P8d59znCPeN5OnBiMR2ZBj4TQXdtjUjDwYapDJAAuEgBb5WIYPHKGSW23F5z4KUpMSWAqhmzg58P9sXuwYdm0wDGJvRg0OkY1c1vD1SY5DnOnvo9XdG6hIXmLsKi3BYPTL+JdNGa5aMVw6SXU1fNuiVLqoiAwluBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qX3cuX26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B52C19425;
	Mon,  5 Jan 2026 17:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767634465;
	bh=rCADN311Ydf2a6eYmwH30EFjEy+14ONeqP6EDj5rG0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qX3cuX268w0tlr5Nt204rIAR88CsH4k/BFC4UqCDkIOheIIc0rTr1gCkXjAWFN1Yl
	 R6ZXywpFWFqNsGQbhuyl878jXue14tNtJsGylZFfDGminC5wTYZkMvhzg9mZbrD4ru
	 sEVtQa23QTh5Yu4gSx/UsCrgU6h9aDcG6JbLSra3nPURqWMBNmkBWHfpOT/ShZndPB
	 eeWhVU6PISw3qJEw9Lz5BsUxysnow8lAZypA0O0U6J9KQSLpHkwmAlOkk1CPMQKHdF
	 qimRwd2NQY5A/RSUvkJqVHf5oNWQ30CQw3l6k1YBfRh6xJaObU0RWQJc+ZeUuzhkoA
	 AUdAuOPPP33/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jim Quinlan <james.quinlan@broadcom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] PCI: brcmstb: Set MLW based on "num-lanes" DT property if present
Date: Mon,  5 Jan 2026 12:34:19 -0500
Message-ID: <20260105173420.2692565-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105173420.2692565-1-sashal@kernel.org>
References: <2026010519-syndrome-eccentric-90f2@gregkh>
 <20260105173420.2692565-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Quinlan <james.quinlan@broadcom.com>

[ Upstream commit a364d10ffe361fb34c3838d33604da493045de1e ]

By default, the driver relies on the default hardware defined value for the
Max Link Width (MLW) capability. But if the "num-lanes" DT property is
present, assume that the chip's default capability information is incorrect
or undesired, and use the specified value instead.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
[mani: reworded the description and comments]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20250530224035.41886-3-james.quinlan@broadcom.com
Stable-dep-of: 9583f9d22991 ("PCI: brcmstb: Fix disabling L0s capability")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 62e1d661ee0b..29f0da00c729 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -46,6 +46,7 @@
 #define  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK	0xffffff
 
 #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
+#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK	0x1f0
 #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
 
 #define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
@@ -55,6 +56,9 @@
 #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
 #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
 
+#define PCIE_RC_PL_REG_PHY_CTL_1			0x1804
+#define  PCIE_RC_PL_REG_PHY_CTL_1_REG_P2_POWERDOWN_ENA_NOSYNC_MASK	0x8
+
 #define PCIE_MISC_MISC_CTRL				0x4008
 #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK	0x80
 #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK	0x400
@@ -1025,7 +1029,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	void __iomem *base = pcie->base;
 	struct pci_host_bridge *bridge;
 	struct resource_entry *entry;
-	u32 tmp, burst, aspm_support;
+	u32 tmp, burst, aspm_support, num_lanes, num_lanes_cap;
 	u8 num_out_wins = 0;
 	int num_inbound_wins = 0;
 	int memc, ret;
@@ -1133,6 +1137,27 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
 	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
+	/* 'tmp' still holds the contents of PRIV1_LINK_CAPABILITY */
+	num_lanes_cap = u32_get_bits(tmp, PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK);
+	num_lanes = 0;
+
+	/*
+	 * Use hardware negotiated Max Link Width value by default.  If the
+	 * "num-lanes" DT property is present, assume that the chip's default
+	 * link width capability information is incorrect/undesired and use the
+	 * specified value instead.
+	 */
+	if (!of_property_read_u32(pcie->np, "num-lanes", &num_lanes) &&
+	    num_lanes && num_lanes <= 4 && num_lanes_cap != num_lanes) {
+		u32p_replace_bits(&tmp, num_lanes,
+			PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK);
+		writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
+		tmp = readl(base + PCIE_RC_PL_REG_PHY_CTL_1);
+		u32p_replace_bits(&tmp, 1,
+			PCIE_RC_PL_REG_PHY_CTL_1_REG_P2_POWERDOWN_ENA_NOSYNC_MASK);
+		writel(tmp, base + PCIE_RC_PL_REG_PHY_CTL_1);
+	}
+
 	/*
 	 * For config space accesses on the RC, show the right class for
 	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
-- 
2.51.0


