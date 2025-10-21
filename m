Return-Path: <stable+bounces-188409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E25BF81D5
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E04BB3576DC
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D379134D938;
	Tue, 21 Oct 2025 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dufUkqpK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9321B34D90E
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 18:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072061; cv=none; b=gb4hI15pqd8GpEJUMrzR+eSiiMTLfYmLtuQAhzPvygkc338JnPDaFC6ih03kZEr3KEECh67brMIb5wvF1EuSZmVe8vYuLGbTxZZumiG/436KWNfOCNm3MZGPuSKvxXXjCL+r2/bdWzlg3MSUWPRO3LMSx1Dnzt5lh5UQgLls6LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072061; c=relaxed/simple;
	bh=lYcPAgzJpddIGC1WiW2AsVWGJox/i6/vUek1YmtD8ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJAp/dG3A0Ya09QxVAan7hTqogKd8XiQ1dQ5KRynaslZZI+3x+U4QotJ0p1GpMazt+Xq3/PzI1DzN7mKuRESsxbW0zctMgIO7lMhQDeA6CQhhOTLUzQYbghgZXdKgB9LFCEDe7dSCzqUV3Yv9+W6JEYH8kf8fdU2iqEwTwBPLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dufUkqpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE339C4CEF1;
	Tue, 21 Oct 2025 18:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761072061;
	bh=lYcPAgzJpddIGC1WiW2AsVWGJox/i6/vUek1YmtD8ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dufUkqpKWUlJoMwBqMhYBgFTXI94z+45RRLvOo/8/+7tLzWqtGa7yhr4Q782YPzWw
	 p+sQAvvjudLWvOFgmzqsTr/dMbZv8UhJfvHaLs6ZHhdGuJkQo8zwNaDnh2K04D2lEV
	 GXPIDpqrVaqhVqb4WN9kZzHmqpSsedaTm/+1d+pmRg4bxax7H4dmQSxqZnODbT7Ime
	 NnkPlHrbY4O+I3pLzXIEg9sOHFX1Tql+Nok2RqInfDqekRVAfP5xV56igrNon4wx3o
	 dZE092va0Q4/DbOur+gGdTHNZUedVHPBk8h8bQC2vSguoYgulnDusfGeCMzcl9DRAz
	 c1kAiFmkr+K9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] PCI: tegra194: Reset BARs when running in PCIe endpoint mode
Date: Tue, 21 Oct 2025 14:40:59 -0400
Message-ID: <20251021184059.2524869-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101638-slider-outlying-148b@gregkh>
References: <2025101638-slider-outlying-148b@gregkh>
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
index 55bbc75c660b2..0dca4baad0dac 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1949,6 +1949,15 @@ static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
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
@@ -2022,6 +2031,7 @@ tegra_pcie_ep_get_features(struct dw_pcie_ep *ep)
 }
 
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
+	.ep_init = tegra_pcie_ep_init,
 	.raise_irq = tegra_pcie_ep_raise_irq,
 	.get_features = tegra_pcie_ep_get_features,
 };
-- 
2.51.0


