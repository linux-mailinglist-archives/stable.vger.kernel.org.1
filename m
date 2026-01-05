Return-Path: <stable+bounces-204891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40529CF5470
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 19:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4F86300A9B2
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 18:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E663161BF;
	Mon,  5 Jan 2026 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJwMRcBo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A28254AFF
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767639359; cv=none; b=WRyarQz/Tk1qF97REsYZQkFY7CPfgMa1Ct/Dgg9p9ni7tPAtX2T2nAdZKYXOtRLpatVxPhduqSbUY04l1bHODQe4EfOd/z0TaBGpVUzP5BssB+v80TqH7yf6JKzI/Ls6/BuajpIYZx1tcOqWjxkp8xiQDx98OMjJEW7KuvW4aH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767639359; c=relaxed/simple;
	bh=gdc+wcMC9/I93JITTmQKnUSZCA/j1jP/LOT8KlvQ990=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZQyn45cAzZkC46CHESCCM7iF4Kk8Hwsn8Jrf6XMyFlNaB9nkC79ZUa1i79d4JvDAHioQm9x4UilcCyitdDS4NpHcJ83y30H4IB7ow5V6lGqUvc/Yvn9Wg5qT1SkDvJ56kt7kf6yXGgTwGniqeekyeH8D9OCH5FPDhK0oUkKLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJwMRcBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507EBC19422;
	Mon,  5 Jan 2026 18:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767639359;
	bh=gdc+wcMC9/I93JITTmQKnUSZCA/j1jP/LOT8KlvQ990=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJwMRcBo5pTV9YvStqccdYwi78R0j8uvziKvcCVdgX40LEUw4dTLE8FuXBLOsS6uo
	 rLeFttk4z4ZBc3FJx70oh3EQB4Ga81/9IKp5yyXQm9Ju9Fvk2lh5BxI9bIlMqE44FN
	 kKAYKmBIVqUySjN2qxraBJahPkNoE0AeWhwPUOnYGg+75q85sUFO1+lfAtGYDmz4Ya
	 v+aSGjBspccjWTP0SNcZm74ivcYXN8gto/7tDrUaSIe6gjGWCZVgaSzmcPdaAo5Elw
	 A668bYt9ywmZauRSm/K9FF4mQDa7bTbMxS5xRmU64HeYmqwRUMjVi6GkXm6wokP+Uu
	 gegzRVpiRd+UQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jim Quinlan <james.quinlan@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] PCI: brcmstb: Fix disabling L0s capability
Date: Mon,  5 Jan 2026 13:55:56 -0500
Message-ID: <20260105185556.2726479-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010520-wreckage-quantum-ba65@gregkh>
References: <2026010520-wreckage-quantum-ba65@gregkh>
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
index 9bcf4c68058e..8850a15b0aec 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -46,7 +46,6 @@
 #define  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK	0xffffff
 
 #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
-#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
 
 #define PCIE_RC_DL_MDIO_ADDR				0x1100
 #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
@@ -867,7 +866,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	void __iomem *base = pcie->base;
 	struct pci_host_bridge *bridge;
 	struct resource_entry *entry;
-	u32 tmp, burst, aspm_support;
+	u32 tmp, burst;
 	int num_out_wins = 0;
 	int ret, memc;
 
@@ -971,12 +970,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
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


