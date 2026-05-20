Return-Path: <stable+bounces-251533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HGpD8QbDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:38:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B773C599DE3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A9753370ABA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B352356773;
	Wed, 20 May 2026 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JCaIq6O5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA142628D;
	Wed, 20 May 2026 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298226; cv=none; b=Ab4a7pzen1qgZhQ9XUWQc4z/lCeS+W283wOCTU1KKNHMYbmuRUmmbZCSdXkPpuFBbOP+DMpYu/LRE7O44p0U74p+agWRSSKL+TlJQVJCsN6M+P3ne3BJkIsskF7j7tbTkqz8X0JzrOpHaW2HW8pq/QnpjeA/y14CTcN2HKa56NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298226; c=relaxed/simple;
	bh=/MXjhUwxpU043ozgETia3ug6An5j7Irl17uE8rzLwVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXqCBK5K4F6NsLTfsWKlJbIFUbfeFjJqTRev1R5L5+EVdvHcsIpYP2vkIVceiIJKifP8vMcen++a7i+cykvxOUdm3r9ex3qP41f8GbAhKa/UcZS2jUvGVU0jc7/djgc2e8RaPNOCWIMNy8AKSoTGnjD2LBMSvhSqXJyj8Yguv64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JCaIq6O5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBC31F000E9;
	Wed, 20 May 2026 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298225;
	bh=wx75Pd1q62jmbAxKkpIOTABfYEJUOj1rOPZrmasSNkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JCaIq6O5B69NTHtiIqFpU6FMyWCM7c0AfZgPe6Mc3G7yb4JJ7GNUyEAmJDJM77yGS
	 NpbIhUxIvzHguLwx3sNxFnaHNKoeHBsCgJ88TV83btPirl8NACZGmTW5zuK6ec9PR0
	 ZVSthDFW7FVMucoP3zcv16LNxyA+3mUTzQsw1JI8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 330/957] PCI: tegra194: Remove unnecessary L1SS disable code
Date: Wed, 20 May 2026 18:13:33 +0200
Message-ID: <20260520162141.687160386@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251533-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B773C599DE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 07c99eac0bc2c1fe962e56d8b5dc5b1152d421bf ]

The DWC core clears the L1 Substates Supported bits unless the driver sets
the "dw_pcie.l1ss_support" flag.

The tegra194 init_host_aspm() sets "dw_pcie.l1ss_support" if the platform
has the "supports-clkreq" DT property.  If "supports-clkreq" is absent,
"dw_pcie.l1ss_support" is not set, and the DWC core will clear the L1
Substates Supported bits.

The tegra194 code to clear the L1 Substates Supported bits is unnecessary,
so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20251118214312.2598220-3-helgaas@kernel.org
Stable-dep-of: f59df1d9e6bd ("PCI: tegra194: Disable L1.2 capability of Tegra234 EP")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 45 +++-------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index f740e0afafa94..257965ada3bd0 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -263,7 +263,6 @@ struct tegra_pcie_dw {
 	u32 msi_ctrl_int;
 	u32 num_lanes;
 	u32 cid;
-	u32 cfg_link_cap_l1sub;
 	u32 ras_des_cap;
 	u32 pcie_cap_base;
 	u32 aspm_cmrt;
@@ -478,8 +477,7 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 		return IRQ_HANDLED;
 
 	/* If EP doesn't advertise L1SS, just return */
-	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
-	if (!(val & (PCI_L1SS_CAP_ASPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_2)))
+	if (!pci->l1ss_support)
 		return IRQ_HANDLED;
 
 	/* Check if BME is set to '1' */
@@ -602,24 +600,6 @@ static struct pci_ops tegra_pci_ops = {
 };
 
 #if defined(CONFIG_PCIEASPM)
-static void disable_aspm_l11(struct tegra_pcie_dw *pcie)
-{
-	u32 val;
-
-	val = dw_pcie_readl_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub);
-	val &= ~PCI_L1SS_CAP_ASPM_L1_1;
-	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
-}
-
-static void disable_aspm_l12(struct tegra_pcie_dw *pcie)
-{
-	u32 val;
-
-	val = dw_pcie_readl_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub);
-	val &= ~PCI_L1SS_CAP_ASPM_L1_2;
-	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
-}
-
 static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
 {
 	u32 val;
@@ -676,10 +656,9 @@ static int aspm_state_cnt(struct seq_file *s, void *data)
 static void init_host_aspm(struct tegra_pcie_dw *pcie)
 {
 	struct dw_pcie *pci = &pcie->pci;
-	u32 val;
+	u32 l1ss, val;
 
-	val = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
-	pcie->cfg_link_cap_l1sub = val + PCI_L1SS_CAP;
+	l1ss = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
 
 	pcie->ras_des_cap = dw_pcie_find_ext_capability(&pcie->pci,
 							PCI_EXT_CAP_ID_VNDR);
@@ -691,11 +670,11 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 			   PCIE_RAS_DES_EVENT_COUNTER_CONTROL, val);
 
 	/* Program T_cmrt and T_pwr_on values */
-	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
+	val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
 	val &= ~(PCI_L1SS_CAP_CM_RESTORE_TIME | PCI_L1SS_CAP_P_PWR_ON_VALUE);
 	val |= (pcie->aspm_cmrt << 8);
 	val |= (pcie->aspm_pwr_on_t << 19);
-	dw_pcie_writel_dbi(pci, pcie->cfg_link_cap_l1sub, val);
+	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
 
 	if (pcie->supports_clkreq)
 		pci->l1ss_support = true;
@@ -723,8 +702,6 @@ static void init_debugfs(struct tegra_pcie_dw *pcie)
 				    aspm_state_cnt);
 }
 #else
-static inline void disable_aspm_l12(struct tegra_pcie_dw *pcie) { return; }
-static inline void disable_aspm_l11(struct tegra_pcie_dw *pcie) { return; }
 static inline void init_host_aspm(struct tegra_pcie_dw *pcie) { return; }
 static inline void init_debugfs(struct tegra_pcie_dw *pcie) { return; }
 #endif
@@ -928,12 +905,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 
 	init_host_aspm(pcie);
 
-	/* Disable ASPM-L1SS advertisement if there is no CLKREQ routing */
-	if (!pcie->supports_clkreq) {
-		disable_aspm_l11(pcie);
-		disable_aspm_l12(pcie);
-	}
-
 	if (!pcie->of_data->has_l1ss_exit_fix) {
 		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
 		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
@@ -1848,12 +1819,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	init_host_aspm(pcie);
 
-	/* Disable ASPM-L1SS advertisement if there is no CLKREQ routing */
-	if (!pcie->supports_clkreq) {
-		disable_aspm_l11(pcie);
-		disable_aspm_l12(pcie);
-	}
-
 	if (!pcie->of_data->has_l1ss_exit_fix) {
 		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
 		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-- 
2.53.0




