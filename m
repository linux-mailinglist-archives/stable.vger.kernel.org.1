Return-Path: <stable+bounces-250487-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKFDMkTzDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-250487-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:45:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2278E5947EB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B9CF3795757
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88113368B6;
	Wed, 20 May 2026 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ubp5cLGe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1631E7660;
	Wed, 20 May 2026 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295538; cv=none; b=C9XqH7p3piN3zR4Kh12WhPzMVs/LclNiddVs+k+aHjHjkj+L35F76C0SrHyWL1eawJykBwHFVwZG0lVX7e0VAXIwtKphxA5W4rTHKDi08Ac8Y4whkNhs+NmN0s7rw0j+z+im3Qh0Qg3VEpdVvHtHCPrrlRbm6HSJU0o77fP2Lc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295538; c=relaxed/simple;
	bh=WV0M7INqI4upggCFLs90o2LMNEwH/afODk4YqexQFGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njT0LJatJGLFxpNYCxbNMbMSYH9Rtr/CNjON4OcknD3YEijL8hH3BGF/Evgf82DNSx4dowOkCc9rqIiEnxJh3qpNwaw5tiyqkSmoa6GGTOpz6onvrg5cETsyL/cCJcSKDhbUdRA8bhaxMzNigJJmrGvpCWogW5MHSwBa2HjXpZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ubp5cLGe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C401F000E9;
	Wed, 20 May 2026 16:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295537;
	bh=hVdBfl9KSqdXBr3Hehx76pxNTmTFQ0+IQKk/hS+UveA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ubp5cLGehw6SdIqQcf0GvbThxHLWe9NXP19NNXUsq0YhYLxdFmNhmNVln0ZIz9V3X
	 7OeFN/+6ayJbL1etaRmHIiMMuvFfJN9ZLvJPaOCg/wYAr3KS7Ynrg9tbEJt4KyjDKx
	 HH6yEExFJmsoMSti7oCZUgdZkBiXWf6pvodODZLw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yao Zi <me@ziyao.cc>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Han Gao <gaohan@iscas.ac.cn>,
	Chen Wang <unicorn_wang@outlook.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0430/1146] PCI: cadence: Add flags for disabling ASPM capability for broken Root Ports
Date: Wed, 20 May 2026 18:11:20 +0200
Message-ID: <20260520162157.922002336@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,ziyao.cc,kernel.org,google.com,iscas.ac.cn,outlook.com];
	TAGGED_FROM(0.00)[bounces-250487-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,iscas.ac.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:email]
X-Rspamd-Queue-Id: 2278E5947EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yao Zi <me@ziyao.cc>

[ Upstream commit 5ccc76a87f1ec2422811e61be44165bfc9e7cf54 ]

Add flags for disabling the ASPM L0s/L1 capability for broken Root Ports
by clearing the corresponding bits in Link Capabilities Register through
the local management bus. This allows ASPM to be disabled on platforms
which don't support it.

Signed-off-by: Yao Zi <me@ziyao.cc>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Han Gao <gaohan@iscas.ac.cn>
Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Link: https://patch.msgid.link/20260405154154.46829-2-me@ziyao.cc
Stable-dep-of: 988ef706cdd8 ("PCI: sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe Root Ports")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../controller/cadence/pcie-cadence-host.c    |  7 +++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index db3154c1eccbf..0bc9e6e90e0e0 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -147,6 +147,13 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
 	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
 
+	value = cdns_pcie_rp_readl(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP);
+	if (rc->quirk_broken_aspm_l0s)
+		value &= ~PCI_EXP_LNKCAP_ASPM_L0S;
+	if (rc->quirk_broken_aspm_l1)
+		value &= ~PCI_EXP_LNKCAP_ASPM_L1;
+	cdns_pcie_rp_writel(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP, value);
+
 	return 0;
 }
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 277f3706a4f47..574e9cf4d003f 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -115,6 +115,8 @@ struct cdns_pcie {
  * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
  * @ecam_supported: Whether the ECAM is supported
  * @no_inbound_map: Whether inbound mapping is supported
+ * @quirk_broken_aspm_l0s: Disable ASPM L0s support as quirk
+ * @quirk_broken_aspm_l1: Disable ASPM L1 support as quirk
  */
 struct cdns_pcie_rc {
 	struct cdns_pcie	pcie;
@@ -127,6 +129,8 @@ struct cdns_pcie_rc {
 	unsigned int		quirk_detect_quiet_flag:1;
 	unsigned int            ecam_supported:1;
 	unsigned int            no_inbound_map:1;
+	unsigned int            quirk_broken_aspm_l0s:1;
+	unsigned int            quirk_broken_aspm_l1:1;
 };
 
 /**
@@ -338,6 +342,21 @@ static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
 	return cdns_pcie_read_sz(addr, 0x2);
 }
 
+static inline void cdns_pcie_rp_writel(struct cdns_pcie *pcie,
+				       u32 reg, u32 value)
+{
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
+
+	cdns_pcie_write_sz(addr, 0x4, value);
+}
+
+static inline u32 cdns_pcie_rp_readl(struct cdns_pcie *pcie, u32 reg)
+{
+	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
+
+	return cdns_pcie_read_sz(addr, 0x4);
+}
+
 static inline void cdns_pcie_hpa_rp_writeb(struct cdns_pcie *pcie,
 					   u32 reg, u8 value)
 {
-- 
2.53.0




