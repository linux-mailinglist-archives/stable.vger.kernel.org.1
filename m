Return-Path: <stable+bounces-222026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC1lK4yro2myJgUAu9opvQ
	(envelope-from <stable+bounces-222026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:59:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2141CE1DA
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 007E7323D372
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BAA302147;
	Sun,  1 Mar 2026 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR6i3nOI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E72BD0B;
	Sun,  1 Mar 2026 01:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329722; cv=none; b=Ww2oYEdqEDGGMzXsn+aT76YHdtshHAi8Pv4hmYu4k+vS0VGLrNBQZqddEuul+NCRwCAK8kEJNwjMQGuHtoeWGP/ePPOhm9dpYoR5csbQmxbpkY0Byhtig6cmIbh1B4ruld8jUlafI4OEAxkt/LPv6SdFFcmsMvhOOwcV3v+k+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329722; c=relaxed/simple;
	bh=DG2PuekhDjZ2af+Hd/YGaH9MnWlwH/V4v1bjIUcShc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VGlPK3k2LSnRBeuRRi7LsYGXij3TtCyM5xi0JcoJa9R2W9AApOpoy06HBpWZs/gVNzd/dkGhNGnJfBjJeiLdLc1WbTk0wwmsDZbN/6ZUOWjMP9AV7dudwUZQsHDdIpl4imV2vDU97A9QvvlEi5ymGGLVAV8a/MYKdL1UEknWXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AR6i3nOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF9BC19421;
	Sun,  1 Mar 2026 01:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329721;
	bh=DG2PuekhDjZ2af+Hd/YGaH9MnWlwH/V4v1bjIUcShc8=;
	h=From:To:Cc:Subject:Date:From;
	b=AR6i3nOIRNFiCVasxY+MOfvYI5b/44FxfZza/FBUJtGlihmKgNCn2WO30MLd2xzfT
	 J/18e8ASHUGbb4KfQ3fQyBXLaS0vf8bzqNlI10Xw3uBr1KzSwt0nzYHZjjAw/7YNFt
	 xGvCmMT1c1DfbPcnWZl5/VG+0KEEEr2iVf2qzxLv5oi7a3F5+SEYWTsRBMREFzr7pf
	 N+YX49KY+BNdLA+x3OSnJPaozvcuC/AYny0BLkFHl3OV5zQsx89TGNgQ8bSTqHdquK
	 k1roQ/mgVuT46pXEIjf3uLCpYiZ9grd1TWjusJvzEUTf33fuhhQiwaBykb+7LDpkTP
	 NWbp6EwJpZ1Jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cassel@kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: FAILED: Patch "Revert "PCI: dw-rockchip: Enumerate endpoints based on dll_link_up IRQ"" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:48:39 -0500
Message-ID: <20260301014839.1712906-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222026-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1C2141CE1DA
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 180c3cfe36786d261a55da52a161f9e279b19a6f Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Mon, 22 Dec 2025 07:42:09 +0100
Subject: [PATCH] Revert "PCI: dw-rockchip: Enumerate endpoints based on
 dll_link_up IRQ"

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
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 59 +------------------
 1 file changed, 3 insertions(+), 56 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index ca808d8f79753..352f513ebf036 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -508,34 +508,6 @@ static const struct dw_pcie_ops dw_pcie_ops = {
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
@@ -568,29 +540,14 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
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
@@ -602,17 +559,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
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
@@ -731,7 +678,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	switch (data->mode) {
 	case DW_PCIE_RC_TYPE:
-		ret = rockchip_pcie_configure_rc(pdev, rockchip);
+		ret = rockchip_pcie_configure_rc(rockchip);
 		if (ret)
 			goto deinit_clk;
 		break;
-- 
2.51.0





