Return-Path: <stable+bounces-220607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPPSAcFQo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:32:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA7A1C8699
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEF1B3694D03
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E163C3E3A95;
	Sat, 28 Feb 2026 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffVoYd7d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC163E3A8B;
	Sat, 28 Feb 2026 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300490; cv=none; b=LIaqC+JDkaldL/irc+/TOrXVGJbkMSeNH2lasj+YlSvljT8L3tC1LQ9QaWWfPnbMM92L5V7w8l8QsqG4NrJFkjg3IqbTjTAufB9GlCXkVVW4e2qv0MOgQc/WcURQT8TLgWwyYJLC9sGHUUPr9mHhwssaw1tKMp47GZoRow+tyAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300490; c=relaxed/simple;
	bh=1HFjrmqa8ATchi2ivor7YSEZP5uNiuSb79PfGecaPss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKA/Qfqcbzani2xb4CXDWe3M+qypmj//6wFMZZM6Aw4Y24A9SldcrycwS4vT6my2y4tp0Oc4Dqa5EYtYfVZBu29AsSgp4bG7gLJSedJQL2nqvEJ0lszUQsI4WKGo/bvchgU0uGdYgecKob3DqzPE1Iv6wDwkiw5MBPiJc4nKbXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffVoYd7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D90C116D0;
	Sat, 28 Feb 2026 17:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300490;
	bh=1HFjrmqa8ATchi2ivor7YSEZP5uNiuSb79PfGecaPss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ffVoYd7dvN6NJZqd3fdNpeGsiwOJtCrEVUPsoJ5OImG5/WHrhiYvT8P6L3XyMS+4H
	 So9ARtBMMv+OmyI1pCOr+kZsY8JzPGdlpsnMHnxPTmweZvgP6JanABORRPvqosvBy0
	 vo21a/43Uo1nFd2RCenxog4HhfzkcdZ5TcW9hvPd6UntaGwJXoNre/VRyM+YXgkmLz
	 /rCLeu9kNY6MPClTiiAhEN7xsm9Ce36eUrho7lihVV1abb1M0Q/PW8GNozKcPnInH7
	 hCd2FEAzWvZ3oTXAwfJbUn0BoJcGJ6mNwC4aTvfftmyM5rGwueRS7ZcpUGa8p6emto
	 od2Lya5RQsP2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 528/844] Revert "PCI: dw-rockchip: Enumerate endpoints based on dll_link_up IRQ"
Date: Sat, 28 Feb 2026 12:27:21 -0500
Message-ID: <20260228173244.1509663-529-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220607-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,rock-chips.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EA7A1C8699
X-Rspamd-Action: no action

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit 180c3cfe36786d261a55da52a161f9e279b19a6f ]

This reverts commit 0e0b45ab5d770a748487ba0ae8f77d1fb0f0de3e.

While this fake hotplugging was a nice idea, it has shown that this feature
does not handle PCIe switches correctly:
pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46

During the initial scan, PCI core doesn't see the switch and since the Root
Port is not hot plug capable, the secondary bus number gets assigned as the
subordinate bus number. This means, the PCI core assumes that only one bus
will appear behind the Root Port since the Root Port is not hot plug
capable.

This works perfectly fine for PCIe endpoints connected to the Root Port,
since they don't extend the bus. However, if a PCIe switch is connected,
then there is a problem when the downstream busses starts showing up and
the PCI core doesn't extend the subordinate bus number and bridge resources
after initial scan during boot.

The long term plan is to migrate this driver to the upcoming pwrctrl APIs
that are supposed to handle this problem elegantly.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251222064207.3246632-10-cassel@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 59 +------------------
 1 file changed, 3 insertions(+), 56 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 0ec12e5edf62f..5b17da63151d5 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -516,34 +516,6 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.get_ltssm = rockchip_pcie_get_ltssm,
 };
 
-static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
-{
-	struct rockchip_pcie *rockchip = arg;
-	struct dw_pcie *pci = &rockchip->pci;
-	struct dw_pcie_rp *pp = &pci->pp;
-	struct device *dev = pci->dev;
-	u32 reg;
-
-	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
-	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
-
-	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
-	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm_reg(rockchip));
-
-	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
-		if (rockchip_pcie_link_up(pci)) {
-			msleep(PCIE_RESET_CONFIG_WAIT_MS);
-			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
-			/* Rescan the bus to enumerate endpoint devices */
-			pci_lock_rescan_remove();
-			pci_rescan_bus(pp->bridge->bus);
-			pci_unlock_rescan_remove();
-		}
-	}
-
-	return IRQ_HANDLED;
-}
-
 static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 {
 	struct rockchip_pcie *rockchip = arg;
@@ -576,29 +548,14 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int rockchip_pcie_configure_rc(struct platform_device *pdev,
-				      struct rockchip_pcie *rockchip)
+static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
 {
-	struct device *dev = &pdev->dev;
 	struct dw_pcie_rp *pp;
-	int irq, ret;
 	u32 val;
 
 	if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_HOST))
 		return -ENODEV;
 
-	irq = platform_get_irq_byname(pdev, "sys");
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_threaded_irq(dev, irq, NULL,
-					rockchip_pcie_rc_sys_irq_thread,
-					IRQF_ONESHOT, "pcie-sys-rc", rockchip);
-	if (ret) {
-		dev_err(dev, "failed to request PCIe sys IRQ\n");
-		return ret;
-	}
-
 	/* LTSSM enable control mode */
 	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
@@ -610,17 +567,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 	pp = &rockchip->pci.pp;
 	pp->ops = &rockchip_pcie_host_ops;
 
-	ret = dw_pcie_host_init(pp);
-	if (ret) {
-		dev_err(dev, "failed to initialize host\n");
-		return ret;
-	}
-
-	/* unmask DLL up/down indicator */
-	val = FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0);
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
-
-	return ret;
+	return dw_pcie_host_init(pp);
 }
 
 static int rockchip_pcie_configure_ep(struct platform_device *pdev,
@@ -739,7 +686,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	switch (data->mode) {
 	case DW_PCIE_RC_TYPE:
-		ret = rockchip_pcie_configure_rc(pdev, rockchip);
+		ret = rockchip_pcie_configure_rc(rockchip);
 		if (ret)
 			goto deinit_clk;
 		break;
-- 
2.51.0


