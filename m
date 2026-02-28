Return-Path: <stable+bounces-220606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOrCM+w/o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:20:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FFE1C6D90
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D279232BABEF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E787B3E3A79;
	Sat, 28 Feb 2026 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Obx1wkq8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF723E3A6B;
	Sat, 28 Feb 2026 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300489; cv=none; b=nezvvLUt7bRYh5jV6gNlSp0dZ34Wy1Y9XjhBcstdUcEsA5oy7CDKmKlrcFeiSR9qHfpiKmIoS6ufSc5xmFnTz19Rz5TQu7uMu3lWBu0wMGZPkscqhyZDbj8WphLll9FEtuKIiOt05dpByZCBDHO7qiT7SPwhj2LV3eWcmYlumPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300489; c=relaxed/simple;
	bh=nGxuxuVtz//C45ppm+cQRTzhofN5GXlYDTDFuBNsmtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWF5M2E3Z5aOy3Tq/wkfWorXKDRt0kLfBmIJl7FjtmSkk1t54C9XET4dy/OLGa8u3ipZYEDrvzCcQXbwrjLraV8Thj0FcYeit1ncsa7urw9P46lp+fH4elLLkScyiTgPWYQH7lwGGAGa7MBnHBQuQJrtpwfBm1pBkWVtMN7eGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Obx1wkq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB457C19425;
	Sat, 28 Feb 2026 17:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300489;
	bh=nGxuxuVtz//C45ppm+cQRTzhofN5GXlYDTDFuBNsmtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Obx1wkq8sEcyqCkyZ5uQNHFkYFn4+Hy1EulE/aa9dSRrYiQh3wmvzHzF3rB1zoMKF
	 yBzPRqbR1903xstJc0EdAryicf7os7iW9k9OWoC129d24YZIkiRBKuwWa0d4c7lSlv
	 UuvclK0h3WEagBnYr+YKytdS6N3az/3i0t9th07kE+UIYQ1D8NjcnfO7rnxFUrBpgA
	 PEVLwkCskCr4oNPO/zbmOKoD1064lKIIcsuArZlgbDPDgt3Qmp4p4g+V5wqVc61vc5
	 8AH4wdvZ27/AoB0kq22uV6nCPkTp5BOquSPqVBW9ICR+z+F+EgNiAVGLarXua8NRbq
	 h77NLLJMtWZzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 527/844] PCI: dw-rockchip: Change get_ltssm() to provide L1 Substates info
Date: Sat, 28 Feb 2026 12:27:20 -0500
Message-ID: <20260228173244.1509663-528-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220606-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url]
X-Rspamd-Queue-Id: C2FFE1C6D90
X-Rspamd-Action: no action

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit f994bb8f1c94726e0124356ccd31c3c23a8a69f4 ]

Rename rockchip_pcie_get_ltssm() to rockchip_pcie_get_ltssm_reg() and add
rockchip_pcie_get_ltssm() to get_ltssm() callback in order to show the
proper L1 Substates. The PCIE_CLIENT_LTSSM_STATUS[5:0] register returns
the same LTSSM layout as enum dw_pcie_ltssm. So the driver just need to
convey L1 PM Substates by returning the proper value defined in
pcie-designware.h.

  cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
  L1_2 (0x142)

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/1765503205-22184-2-git-send-email-shawn.lin@rock-chips.com
Stable-dep-of: 180c3cfe3678 ("Revert "PCI: dw-rockchip: Enumerate endpoints based on dll_link_up IRQ"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 29 ++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 59396db3f4812..0ec12e5edf62f 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -68,6 +68,11 @@
 #define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
 #define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
 
+/* RASDES TBA information */
+#define PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN	0x154
+#define  PCIE_CLIENT_CDM_RASDES_TBA_L1_1	BIT(4)
+#define  PCIE_CLIENT_CDM_RASDES_TBA_L1_2	BIT(5)
+
 /* Hot Reset Control Register */
 #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
 #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
@@ -183,11 +188,26 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
 	return 0;
 }
 
-static u32 rockchip_pcie_get_ltssm(struct rockchip_pcie *rockchip)
+static u32 rockchip_pcie_get_ltssm_reg(struct rockchip_pcie *rockchip)
 {
 	return rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
 }
 
+static enum dw_pcie_ltssm rockchip_pcie_get_ltssm(struct dw_pcie *pci)
+{
+	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
+	u32 val = rockchip_pcie_readl_apb(rockchip,
+			PCIE_CLIENT_CDM_RASDES_TBA_INFO_CMN);
+
+	if (val & PCIE_CLIENT_CDM_RASDES_TBA_L1_1)
+		return DW_PCIE_LTSSM_L1_1;
+
+	if (val & PCIE_CLIENT_CDM_RASDES_TBA_L1_2)
+		return DW_PCIE_LTSSM_L1_2;
+
+	return rockchip_pcie_get_ltssm_reg(rockchip) & PCIE_LTSSM_STATUS_MASK;
+}
+
 static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
 {
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
@@ -203,7 +223,7 @@ static void rockchip_pcie_disable_ltssm(struct rockchip_pcie *rockchip)
 static bool rockchip_pcie_link_up(struct dw_pcie *pci)
 {
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
-	u32 val = rockchip_pcie_get_ltssm(rockchip);
+	u32 val = rockchip_pcie_get_ltssm_reg(rockchip);
 
 	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
 }
@@ -493,6 +513,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = rockchip_pcie_link_up,
 	.start_link = rockchip_pcie_start_link,
 	.stop_link = rockchip_pcie_stop_link,
+	.get_ltssm = rockchip_pcie_get_ltssm,
 };
 
 static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
@@ -507,7 +528,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
 	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
 
 	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
-	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
+	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm_reg(rockchip));
 
 	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
 		if (rockchip_pcie_link_up(pci)) {
@@ -534,7 +555,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
 
 	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
-	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
+	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm_reg(rockchip));
 
 	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
 		dev_dbg(dev, "hot reset or link-down reset\n");
-- 
2.51.0


