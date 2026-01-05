Return-Path: <stable+bounces-204642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A5FCF31BC
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B694F30F3165
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F32330647;
	Mon,  5 Jan 2026 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f7tFcgDj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3204B330643
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610538; cv=none; b=A+Fjk7EpbSZwLtto63LCvH2jzNj0+4/ZeIoxXGb0ofso1LNl4HNS5JifVLrFsweCqkMuMlBkIQr1H7wDNdPEcVceNVxA46FY/h47nyvmSDQCRjXMQy/+bud9KiuQy+gDNwFYw5q0rfDZBAvuu4b0PyQyYMg2pxYCoCSuViUImiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610538; c=relaxed/simple;
	bh=TyuEh6Oiw2uRLDg2UENtoq6kY6yXpFYqTsMaFfLaoM4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YbfrFXpssxoplRxRwjrP+QkwHZgIaazqGBWPkYYtqI+S6Zsc8h/TUhdQ5Fd2F4J82VgphoekbyEIdODaJw2vmBo9+0pJSJ/tmZuVVGbhvUjXmx2Cs3ql+yOqFxuGB50WvXqfqdAVzrpGM/tpuhtn07i+JgIZaLMbmpyQLRJe+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f7tFcgDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90875C116D0;
	Mon,  5 Jan 2026 10:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610538;
	bh=TyuEh6Oiw2uRLDg2UENtoq6kY6yXpFYqTsMaFfLaoM4=;
	h=Subject:To:Cc:From:Date:From;
	b=f7tFcgDjTY5lzEQq2cKUJpk2iDcAg9Gxj2Lnc0759C2mLqQMB0H8mHwpWWV+QA8y3
	 aH61v8v1XEO1wvS8fDJsxnwXMU3xFWR8RvnrDk5iLTGLQLpCff1mTVLXn/zfVe+kVh
	 YPc+hMZxmbLmIREVXKS0LQHUk6iYahWpi/MNFkRI=
Subject: FAILED: patch "[PATCH] PCI: brcmstb: Fix disabling L0s capability" failed to apply to 6.1-stable tree
To: james.quinlan@broadcom.com,bhelgaas@google.com,florian.fainelli@broadcom.com,mani@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:55:21 +0100
Message-ID: <2026010521-illicitly-quality-35f4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9583f9d22991d2cfb5cc59a2552040c4ae98d998
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010521-illicitly-quality-35f4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


