Return-Path: <stable+bounces-204643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17876CF314C
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 11:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5794D300F182
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B9732E136;
	Mon,  5 Jan 2026 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l28Ikj2R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499A330656
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610541; cv=none; b=Y2g6SRv7pfMNa3w4h+i0e5lpPFGdGHPwkNfG++LWG/TgjROt7QHMqkldpx5nAviI1veH6Kys5Erg8L2xLGaIhLYrkyVcAcSRDq53lRwTlGHMTQAJF7yde8y0RXZ4sT97Qlrf6HIebx1gcqBg/oBFxNsZ4hofEQSW+tNXLSp08ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610541; c=relaxed/simple;
	bh=zy520mkTyx5DX5kX38wVXmFVGg+x9u2p8YPbEaBeep8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eAUsBWw1XvaCUxPT4i3crwYlSv9KSFmpPW+U7Pnl3Plev+0kRjWjL9p4cskZ+ZYaPd54gu2JwEy0qLhYZWZjcGTIw57lO9OhbZINyH646sYlkuVE27KFq9lZhgkFj+Oamch5AoZIS9KEb8LmNZs96ZlzfndZx1hMgsRYm/1qugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l28Ikj2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8EDC116D0;
	Mon,  5 Jan 2026 10:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610541;
	bh=zy520mkTyx5DX5kX38wVXmFVGg+x9u2p8YPbEaBeep8=;
	h=Subject:To:Cc:From:Date:From;
	b=l28Ikj2R8UYvb160dxwtIG1oIkYSI1ZqHryEag1IoCKFcVDQn5yaPIlXurO56NaBQ
	 2Nq65W89Ck84qiUgLui+iKms+GyVdRakaal8sXcgvVj1vZKdgO1q7kbM8zacNPwr7x
	 rgcNlJuLCqehc5OiE7Bt2XdkWhhegNAuD21k2DYI=
Subject: FAILED: patch "[PATCH] PCI: brcmstb: Fix disabling L0s capability" failed to apply to 5.10-stable tree
To: james.quinlan@broadcom.com,bhelgaas@google.com,florian.fainelli@broadcom.com,mani@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:55:22 +0100
Message-ID: <2026010522-salami-progeny-1e6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9583f9d22991d2cfb5cc59a2552040c4ae98d998
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010522-salami-progeny-1e6e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9583f9d22991d2cfb5cc59a2552040c4ae98d998 Mon Sep 17 00:00:00 2001
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Fri, 3 Oct 2025 13:04:36 -0400
Subject: [PATCH] PCI: brcmstb: Fix disabling L0s capability

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

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9afbd02ded35..7e9b2f6a604a 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -48,7 +48,6 @@
 
 #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
 #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_MAX_LINK_WIDTH_MASK	0x1f0
-#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
 
 #define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
 #define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK	0xf8
@@ -1075,7 +1074,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	void __iomem *base = pcie->base;
 	struct pci_host_bridge *bridge;
 	struct resource_entry *entry;
-	u32 tmp, burst, aspm_support, num_lanes, num_lanes_cap;
+	u32 tmp, burst, num_lanes, num_lanes_cap;
 	u8 num_out_wins = 0;
 	int num_inbound_wins = 0;
 	int memc, ret;
@@ -1175,12 +1174,9 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 
 
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
 
 	/* 'tmp' still holds the contents of PRIV1_LINK_CAPABILITY */


