Return-Path: <stable+bounces-270999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9/TMHmaWRmowZQsAu9opvQ
	(envelope-from <stable+bounces-270999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:48:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 604B86FA950
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:48:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=qy8Ea668;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270999-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-270999-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D7C9304591E
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B4033B6E8;
	Thu,  2 Jul 2026 16:40:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4347230EF95;
	Thu,  2 Jul 2026 16:40:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010404; cv=none; b=CrqHj2dnEeFIJI7FEa3PyX/e462zuRmAmCC+KsPix3pu7bySyKgMgdVABGCpfMJSwDC2/QHHa+6Rdd5tbbyLgvYWH7hESK011bvRKblL7Ic/yVK1yjytXTXuLV2V25dbux6UNCi9Ue1r4QUaV8k+DFKjgYnBsmQbsc6EDYNieks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010404; c=relaxed/simple;
	bh=TYBoyq86w7UpTkm9FWcS/eWSCnHYqfJhhInYOYjolrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gg5no0huKK69JL8wd5IjnbTLWAEuTKW6jkCVMVOI4gxI7Zt1owLW63btmMm75BU5p+HMq+tcWgTNadtcMwYsPhsoTWk8vHWD77Er8vdLpiSbZXMvbohxPLMyl2IgxiVTx6in7mlcmyH3eXb9Ks7/f/cjqPIrzzDxywOSK6dTH7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qy8Ea668; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99381F000E9;
	Thu,  2 Jul 2026 16:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010403;
	bh=h06zTveyNsHTYAAPWg6HzSjSt5qTXtZ5z3ixUzkEwG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qy8Ea668uOrqW/Hs95r9Dp3sx7OejKhYenKkEotYqWSoyi9VfaOIJkZaDjYZ5GZvc
	 LKxNn0XKmXm1gVo9kivUwevHoxe4GZGZWMrYGfZmf83qyuLqIRJTXn8nSbkmDNDrfl
	 FiW3+7bBDASCqmxfkGARCCL/aXMomh5TIjHwwxYc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 095/204] Revert "PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support"
Date: Thu,  2 Jul 2026 18:19:12 +0200
Message-ID: <20260702155120.657837749@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270999-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 604B86FA950

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit 480c94d3affbc11b9e98ca223a9fa19d90b84fbb.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ae0f36e270baa1..5d27cd149f5120 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -329,20 +329,15 @@ static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
-static void qcom_pcie_set_slot_nccs(struct dw_pcie *pci)
+static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
-	/*
-	 * Qcom PCIe Root Ports do not support generating command completion
-	 * notifications for the Hot-Plug commands. So set the NCCS field to
-	 * avoid waiting for the completions.
-	 */
 	val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
-	val |= PCI_EXP_SLTCAP_NCCS;
+	val &= ~PCI_EXP_SLTCAP_HPC;
 	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
@@ -537,7 +532,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	writel(CFG_BRIDGE_SB_INIT,
 	       pci->dbi_base + AXI_MSTR_RESP_COMP_CTRL1);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
@@ -617,7 +612,7 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
@@ -710,7 +705,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	val |= EN;
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
@@ -1014,7 +1009,7 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 		writel(WR_NO_SNOOP_OVERIDE_EN | RD_NO_SNOOP_OVERIDE_EN,
 				pcie->parf + PARF_NO_SNOOP_OVERIDE);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
-- 
2.53.0




