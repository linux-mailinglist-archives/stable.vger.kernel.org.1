Return-Path: <stable+bounces-188421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 234FABF849C
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1AB19C3703
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD262727E0;
	Tue, 21 Oct 2025 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnRdVfD6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A234271A7C
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075806; cv=none; b=lDT5FfAaG7wOimbg2XI9TGwjah1VZaUOWNt14/scZDwY1t0cEzcnARF2CI1A5b8+VEEmeiciOZofKPHOKEzsZjyJhIjPW8BjL5KqD3K4Ne0/jc+eAxGrzXuZSIXZ5BO6HpzedPEyX81yaFlrlwVmb6rRWqZAD3PTu2gIZuOs3zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075806; c=relaxed/simple;
	bh=AnPvGikO4EDhWWp5YyscAe0u5BXT3ggW9pF9ucV4i9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOtAydIKOudYmwBAYcwxSy7bdKEfKYVpqlF1I/SfX+d2313N+UM02B3vaNqoi5/6e8Nt4qNlkN8AgScjs2kwmNydTNqXq6AUQ/AyIEJa54CO+9/9MxKNIH091xzy7WUe5caF94NSSnYkPd6X73ei5FDmivbaV4RrnvXB836KGNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnRdVfD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03687C4CEF1;
	Tue, 21 Oct 2025 19:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761075805;
	bh=AnPvGikO4EDhWWp5YyscAe0u5BXT3ggW9pF9ucV4i9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qnRdVfD6YrZGGJdVt6Jl7gqarVKotKc3psIeBhCBqrFIfZA4QolZAws0JZaZnSEzq
	 NkwDQpCrYdVlwJeOchB04tUDWUf77p01qD+Aw/hmRSMf1asl2Q2NNd/DxaG7dv8tbz
	 lrQL5jkFDYP4wvjKoSXlcymHa8nUU5cj+T8OEbkYD6TKT5aSgJK/LsLUrKnwXXB4/i
	 GJ46JXO6tNPA27Bzov4NFJ5fRnKPLkx7uTU6Sl3Q4nOSBdK+FvjzqyO5ccUP+AU9G9
	 eXNdqAfRsjvcN+2/ig4ts1VtgXp9v+31fs8mUDg7GWlDIfe9H5u8qVxo1ECqZKqphz
	 9Kl3P3UeNRr9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] PCI: tegra194: Reset BARs when running in PCIe endpoint mode
Date: Tue, 21 Oct 2025 15:43:23 -0400
Message-ID: <20251021194323.2906923-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101639-january-preheated-6487@gregkh>
References: <2025101639-january-preheated-6487@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit 42f9c66a6d0cc45758dab77233c5460e1cf003df ]

Tegra already defines all BARs except BAR0 as BAR_RESERVED.  This is
sufficient for pci-epf-test to not allocate backing memory and to not call
set_bar() for those BARs. However, marking a BAR as BAR_RESERVED does not
mean that the BAR gets disabled.

The host side driver, pci_endpoint_test, simply does an ioremap for all
enabled BARs and will run tests against all enabled BARs, so it will run
tests against the BARs marked as BAR_RESERVED.

After running the BAR tests (which will write to all enabled BARs), the
inbound address translation is broken. This is because the tegra controller
exposes the ATU Port Logic Structure in BAR4, so when BAR4 is written, the
inbound address translation settings get overwritten.

To avoid this, implement the dw_pcie_ep_ops .init() callback and start off
by disabling all BARs (pci-epf-test will later enable/configure BARs that
are not defined as BAR_RESERVED).

This matches the behavior of other PCIe endpoint drivers: dra7xx, imx6,
layerscape-ep, artpec6, dw-rockchip, qcom-ep, rcar-gen4, and uniphier-ep.

With this, the PCI endpoint kselftest test case CONSECUTIVE_BAR_TEST (which
was specifically made to detect address translation issues) passes.

Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250922140822.519796-7-cassel@kernel.org
[ changed dw_pcie_ep_ops .init to .ep_init and exported dw_pcie_ep_reset_bar ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c |  1 +
 drivers/pci/controller/dwc/pcie-tegra194.c      | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5502751334cc6..9e5d50de5f5e7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -84,6 +84,7 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 	for (func_no = 0; func_no < funcs; func_no++)
 		__dw_pcie_ep_reset_bar(pci, func_no, bar, 0);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_ep_reset_bar);
 
 static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no,
 		u8 cap_ptr, u8 cap)
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0046983e5ab89..bd1a40a5b9071 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1825,6 +1825,15 @@ static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void tegra_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
+};
+
 static int tegra_pcie_ep_raise_legacy_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
 	/* Tegra194 supports only INTA */
@@ -1898,6 +1907,7 @@ tegra_pcie_ep_get_features(struct dw_pcie_ep *ep)
 }
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
+	.ep_init = tegra_pcie_ep_init,
 	.raise_irq = tegra_pcie_ep_raise_irq,
 	.get_features = tegra_pcie_ep_get_features,
 };
-- 
2.51.0


