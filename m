Return-Path: <stable+bounces-204893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E81FCF5519
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 20:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E09A303ADCD
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 19:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00F4335579;
	Mon,  5 Jan 2026 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+gnk4c0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718263090FB
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767640484; cv=none; b=OT1m1bTsLbXJSgZH1d4lnvJUUuSn4ea3r+qs1JJdD3QkbNBKD6xq2sh37NsM2rQ3ihzDOc5d/Ce7jHt7L96VfdqkIekVSV2Ghs6hO0yYn5HVQItMVPJTr0k/AOblcZgJNO1cxYYojc9FcZ5OtCd7WSONpkLTi8VRHMVwjlf5Kiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767640484; c=relaxed/simple;
	bh=+Ufcg20RCWDqBTe/tYXkmoIi9v/RjaDRLGFPbv8iwzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqYSwkeSVJNaBh6ptVHKr2tQu5Fofs+MaW1cp2raklTuwV3xm6eUYEsp+GBPLIG6nmgghBd9XtdppdLq63UiPLZ8GcSJbQ9X5zwRUbBMUxZ9O0acmmhRMHTgMSOJLnn0CZUYvKsXqnPTjaRF/pZtGcf7OWFE9Zta1V8/Oo1PSe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+gnk4c0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59969C116D0;
	Mon,  5 Jan 2026 19:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767640484;
	bh=+Ufcg20RCWDqBTe/tYXkmoIi9v/RjaDRLGFPbv8iwzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+gnk4c0puaQHaG5oO+DSwUmAAeb6N+S3HK+gKPe8SUNAFTjUNEy6Ylh2Q0Nm4tE+
	 OYZd/2GctGSyRgRDIOgU6RQe6FXrf2MN/+upibg+zo7MJR6kMtsA9F0TWVTMRUmyOT
	 YwVCmb4NTLewMUcmMgPGBKgNzEjRelFiPuqQwFhF5FjfMQslbBGsw6E1bO5+BJeMEy
	 FBzpnhHtRoxHS4X/f3xINE1dhcRlzJc1+ZRs6YsoqjV1R9TvPC8WV4PibyMkyUHVVi
	 7fOA+Co2QrhCPDDIff9JP/9w1FUZjk1sWJ5jTscNa7i3JyTu7LhsQpZ8o0yrgUtvOy
	 XDnNSEgy/CxNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jim Quinlan <james.quinlan@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] PCI: brcmstb: Fix disabling L0s capability
Date: Mon,  5 Jan 2026 14:14:41 -0500
Message-ID: <20260105191441.2731420-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010521-illicitly-quality-35f4@gregkh>
References: <2026010521-illicitly-quality-35f4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Quinlan <james.quinlan@broadcom.com>

[ Upstream commit 9583f9d22991d2cfb5cc59a2552040c4ae98d998 ]

caab002d5069 ("PCI: brcmstb: Disable L0s component of ASPM if requested")
set PCI_EXP_LNKCAP_ASPM_L1 and (optionally) PCI_EXP_LNKCAP_ASPM_L0S in
PCI_EXP_LNKCAP (aka PCIE_RC_CFG_PRIV1_LINK_CAPABILITY in brcmstb).

But instead of using PCI_EXP_LNKCAP_ASPM_L1 and PCI_EXP_LNKCAP_ASPM_L0S
directly, it used PCIE_LINK_STATE_L1 and PCIE_LINK_STATE_L0S, which are
Linux-created values that only coincidentally matched the PCIe spec.
b478e162f227 ("PCI/ASPM: Consolidate link state defines") later changed
them so they no longer matched the PCIe spec, so the bits ended up in the
wrong place in PCI_EXP_LNKCAP.

Use PCI_EXP_LNKCAP_ASPM_L0S to clear L0s support when there's an
'aspm-no-l0s' property.  Rely on brcmstb hardware to advertise L0s and/or
L1 support otherwise.

Fixes: caab002d5069 ("PCI: brcmstb: Disable L0s component of ASPM if requested")
Reported-by: Bjorn Helgaas <bhelgaas@google.com>
Closes: https://lore.kernel.org/linux-pci/20250925194424.GA2197200@bhelgaas
Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
[mani: reworded subject and description, added closes tag and CCed stable]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251003170436.1446030-1-james.quinlan@broadcom.com
[ adapted context due to missing link width negotiation defines and variables ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c89ad1f92a07..692d295030f9 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -45,7 +45,6 @@
 #define  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK	0xffffff
 
 #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
-#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
 
 #define PCIE_RC_DL_MDIO_ADDR				0x1100
 #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
@@ -869,7 +868,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	void __iomem *base = pcie->base;
 	struct pci_host_bridge *bridge;
 	struct resource_entry *entry;
-	u32 tmp, burst, aspm_support;
+	u32 tmp, burst;
 	int num_out_wins = 0;
 	int ret, memc;
 
@@ -963,12 +962,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	writel(tmp, base + PCIE_MISC_RC_BAR3_CONFIG_LO);
 
 	/* Don't advertise L0s capability if 'aspm-no-l0s' */
-	aspm_support = PCIE_LINK_STATE_L1;
-	if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
-		aspm_support |= PCIE_LINK_STATE_L0S;
 	tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
-	u32p_replace_bits(&tmp, aspm_support,
-		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
+	if (of_property_read_bool(pcie->np, "aspm-no-l0s"))
+		tmp &= ~PCI_EXP_LNKCAP_ASPM_L0S;
 	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
 
 	/*
-- 
2.51.0


