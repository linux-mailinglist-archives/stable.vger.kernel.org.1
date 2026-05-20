Return-Path: <stable+bounces-251529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICt/EiMbDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:35:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9274599CFE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29FF93693B1A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9CC3EDAC6;
	Wed, 20 May 2026 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PqK9xUMq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513083EAC83;
	Wed, 20 May 2026 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298216; cv=none; b=oME3PcTdVuUO5LjtZsfzMaQ2ew25vb4jPabeQg+o42qP07t6L8G2v7Y9+hPFhvoqMseOfnJrV/+ijml6MLlpulz9rG0ZgNUIF4+2CtrEy+AN6cNcICuQt2imSVs2+cmdxyn3fM+EjNK0Azji/H1bBrw00z1EvKQgbWAW7LLZQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298216; c=relaxed/simple;
	bh=IXdzBtqvIgYyJFpsAaBPbRK9te46yKiOQs4PlhlOkBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSlPPGo7h1Wir9y49j5v8cmh1h4a8oDUtmxxiM3DSEMhSYdKiQbffw9PpOuwCRr7L1DwPgD6txmkDXec37Dybncac5RYtdGwMFjt7m4fVi3AjlAO7uKn7ZoSOIo0Mh4h21f5dyYPuT1xgV3sogSKeP3GjIlHlDsJ/VQNCwlfD50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PqK9xUMq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7621F00893;
	Wed, 20 May 2026 17:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298215;
	bh=9WKLz+nmuPgRpOgXYU5H+zYDszaeRNR6DtA21xUyre8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PqK9xUMqdVlbqnuM5C7dVUH6hxytHBlYN9RF0txHJwEulzYZ67oUupWqtflNOoP0t
	 d2h/MIdh6pBvGhBF3N6QPCksqekYwW/xeJ8UkV1QWVmEwjmMkatUW0/oj/gKAVQMw7
	 W+65YjT+60AUHFKEZ8udR+Cah8NJRWSQpGWdm3Nc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vidya Sagar <vidyas@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 326/957] PCI: tegra194: Allow system suspend when the Endpoint link is not up
Date: Wed, 20 May 2026 18:13:29 +0200
Message-ID: <20260520162141.600799493@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251529-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D9274599CFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vidya Sagar <vidyas@nvidia.com>

[ Upstream commit c76f8eae7d4695b1176c4ea5eb93c17e16a20272 ]

Host software initiates the L2 sequence. PCIe link is kept in L2 state
during suspend. If Endpoint mode is enabled and the link is up, the
software cannot proceed with suspend. However, when the PCIe Endpoint
driver is probed, but the PCIe link is not up, Tegra can go into suspend
state. So, allow system to suspend in this case.

Fixes: de2bbf2b71bb ("PCI: tegra194: Don't allow suspend when Tegra PCIe is in EP mode")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Link: https://patch.msgid.link/20260324190755.1094879-10-mmaddireddy@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 31 +++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 7d3ea4309e9bb..f4784945c04bb 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2304,16 +2304,28 @@ static void tegra_pcie_dw_remove(struct platform_device *pdev)
 		gpiod_set_value(pcie->pex_refclk_sel_gpiod, 0);
 }
 
-static int tegra_pcie_dw_suspend_late(struct device *dev)
+static int tegra_pcie_dw_suspend(struct device *dev)
 {
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
-	u32 val;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-		dev_err(dev, "Failed to Suspend as Tegra PCIe is in EP mode\n");
-		return -EPERM;
+		if (pcie->ep_state == EP_STATE_ENABLED) {
+			dev_err(dev, "Tegra PCIe is in EP mode, suspend not allowed\n");
+			return -EPERM;
+		}
+
+		disable_irq(pcie->pex_rst_irq);
+		return 0;
 	}
 
+	return 0;
+}
+
+static int tegra_pcie_dw_suspend_late(struct device *dev)
+{
+	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+	u32 val;
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2333,6 +2345,9 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 {
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2347,6 +2362,9 @@ static int tegra_pcie_dw_resume_noirq(struct device *dev)
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
 	int ret;
 
+	if (pcie->of_data->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
 	if (!pcie->link_state)
 		return 0;
 
@@ -2379,8 +2397,8 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 	u32 val;
 
 	if (pcie->of_data->mode == DW_PCIE_EP_TYPE) {
-		dev_err(dev, "Suspend is not supported in EP mode");
-		return -ENOTSUPP;
+		enable_irq(pcie->pex_rst_irq);
+		return 0;
 	}
 
 	if (!pcie->link_state)
@@ -2485,6 +2503,7 @@ static const struct of_device_id tegra_pcie_dw_of_match[] = {
 };
 
 static const struct dev_pm_ops tegra_pcie_dw_pm_ops = {
+	.suspend = tegra_pcie_dw_suspend,
 	.suspend_late = tegra_pcie_dw_suspend_late,
 	.suspend_noirq = tegra_pcie_dw_suspend_noirq,
 	.resume_noirq = tegra_pcie_dw_resume_noirq,
-- 
2.53.0




