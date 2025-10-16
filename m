Return-Path: <stable+bounces-186100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1252ABE3941
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF26F5088A3
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E72334393;
	Thu, 16 Oct 2025 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Imrzt9j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BBE1CD1F
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619657; cv=none; b=pwfiqakA9HMJUDfPao6EsPGUemqCGa/IKl0eea1TnEzbJzYHAmk+g78KFPsQDRIOmiVNRRt8hiELDIbS8e2EljPcP6KfmXrMFeDHTCV2KyvtOVesKP2h4JMGCCTA9MxviA4VG49QDpJ/7/uG0a7OPHa/ZGSlJyhE2zmKBOXXKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619657; c=relaxed/simple;
	bh=zdG+9cyt0t5adMEbOng9xQG5f8Jz5fSlEhI2vA5pnV8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZlmtrSsQYv2p9fIOpFfEdaqziSm5myvmwDXI3jtTA0svXnIWxmo9zoXphZv1G1b4Slu2kCfX9zhNJYgPf/2tiHkvAm7EquSphwsF7Vmfye9NWsXsPoUM3qFPa2ksfuYirbYe96JORyxWCxt6UIAqjoTe1hjkMXhBHGY/iR1zT9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Imrzt9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60931C113D0;
	Thu, 16 Oct 2025 13:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619656;
	bh=zdG+9cyt0t5adMEbOng9xQG5f8Jz5fSlEhI2vA5pnV8=;
	h=Subject:To:Cc:From:Date:From;
	b=0Imrzt9jKP2LSMTdJftbr8ncqRqj9zaLhPi+rmydsLDE/fK0akTziaPZ1wk8C6XNa
	 oC0rbt29Goc0Hv8MAZcFBAWkqrRlFkE++2VwrWBuoiH+CQeMt2OGHGFmeoe3/C8Axi
	 T1aksHh49KkWU++wbDQn8jzD8XIf3Wp/joKLkiN0=
Subject: FAILED: patch "[PATCH] PCI: tegra194: Reset BARs when running in PCIe endpoint mode" failed to apply to 5.10-stable tree
To: cassel@kernel.org,bhelgaas@google.com,mani@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 15:00:40 +0200
Message-ID: <2025101640-scouring-earthworm-26af@gregkh>
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
git cherry-pick -x 42f9c66a6d0cc45758dab77233c5460e1cf003df
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101640-scouring-earthworm-26af@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 42f9c66a6d0cc45758dab77233c5460e1cf003df Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Mon, 22 Sep 2025 16:08:25 +0200
Subject: [PATCH] PCI: tegra194: Reset BARs when running in PCIe endpoint mode

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

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index fe418b9bfbb4..359d92dca86a 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1941,6 +1941,15 @@ static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
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
 static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
 	/* Tegra194 supports only INTA */
@@ -2016,6 +2025,7 @@ tegra_pcie_ep_get_features(struct dw_pcie_ep *ep)
 }
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
+	.init = tegra_pcie_ep_init,
 	.raise_irq = tegra_pcie_ep_raise_irq,
 	.get_features = tegra_pcie_ep_get_features,
 };


