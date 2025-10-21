Return-Path: <stable+bounces-188399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F030BF80A3
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FAB64EC70A
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D796C351FB3;
	Tue, 21 Oct 2025 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YY9/cXjW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97833351FAF
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071106; cv=none; b=ig7RBTPDUcj/bprbz1/c3+Jr6LzQpU1Am6NH1MQkUc7SvXVOJVcPyPVZPuJQfrVYTl/hdN5cNyaqpQqOWKtdoVQOenNu4TQA5dR8lOOWGgYDG5HHD+G141fnfOmmQF1FqV4jy5n9PAKROM2DlKF+vlRcR0Bcuywe/4Gawf2g3EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071106; c=relaxed/simple;
	bh=pvKApyvNwWC5VsNGnNn5TUTFHX4lRRoZCyqPMiuqUmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hstBJ3e9qRADwZHk1FHRXSgavbpOH6uLltA/49552TqAk+0hTvBes+kUcuixL2Dyklq/3wi87OGyp8LzNRJ7Hmy/0YYrtJtjNkGkFjE0E/LvVW4ThxaP6jFZkupKqHls9K8UvSnHVGJUsYklEiwmIJlRjArlnPq2j7PEEVUrmYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YY9/cXjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633FAC4CEF1;
	Tue, 21 Oct 2025 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761071105;
	bh=pvKApyvNwWC5VsNGnNn5TUTFHX4lRRoZCyqPMiuqUmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YY9/cXjWCUdMoTK1Xvt8EWXmq2HIzPB6c3cqOE3mapqOilktoa1pCN0DwXP7ta1N9
	 osboNiMFHsBTeb6Akdd/VCdKRmnBv3f2sozM6hFQYVM9OoDEsUKAoVrLG8JwIeRAQj
	 Hu8gcqe0t+SN/0tzfaCp5UHUnRSt5+gmkB6d10w10WzmzsRcSK9JIjg3JGrsIpgyy+
	 2jITF6e6hOlcN47B+RDf4OjkabHdXgrkwWzwbIk+x42+X31WxYNaZPDEGv2E9F7iLM
	 oHQsf6d176WRMcCmjCrlqJC9e+tYYR+cxRKsJZm6qhVVkA8bOtQyuI+3es8o5RTu93
	 xRB8yQtw5QFwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] PCI: tegra194: Reset BARs when running in PCIe endpoint mode
Date: Tue, 21 Oct 2025 14:25:01 -0400
Message-ID: <20251021182501.2509096-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101638-carry-unwashed-bba6@gregkh>
References: <2025101638-carry-unwashed-bba6@gregkh>
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
[ changed .init field to .ep_init in pcie_ep_ops struct ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index c7d3e248a59a2..ce2a7a6dab90c 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1963,6 +1963,15 @@ static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
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
@@ -2036,6 +2045,7 @@ tegra_pcie_ep_get_features(struct dw_pcie_ep *ep)
 }
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
+	.ep_init = tegra_pcie_ep_init,
 	.raise_irq = tegra_pcie_ep_raise_irq,
 	.get_features = tegra_pcie_ep_get_features,
 };
-- 
2.51.0


