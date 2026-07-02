Return-Path: <stable+bounces-271330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ou/TALSZRmoXZwsAu9opvQ
	(envelope-from <stable+bounces-271330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:02:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDEE6FAE6F
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:02:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=esDo1o7q;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271330-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271330-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C2AA302F27A
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6261F33BBCD;
	Thu,  2 Jul 2026 16:54:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD02D0602;
	Thu,  2 Jul 2026 16:54:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011261; cv=none; b=bTrzEqNmFFKMRLf46rn1pBhHq9Kf6N8zanPCv/r8QYv4DivPz04F1iM3RquSbMYI6SjQtMAuq8ceC0JGX9fkkGoQGtuhJlzkfwxyF3qSYhhkkjs0soa4Fi85Kc810wFsbYBCu8Ndjlhk3+Lt46Jub35rcJHYubXCjd85nx/ekLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011261; c=relaxed/simple;
	bh=NvIY7DxCTTzEMrfHAem4Sb5+txFXa2uctcCv8pYqH/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZQ621lL9OQIAaSw8rqdFizb3Y4dOIwNDQOJ602eFxLFIgQJXf9pKy5CXPy8YyrnXua+OI0PHUbSpZxirom/pTJ+JaXS4aAiYZMYmbVuBZ24tpn1SVQ91D33j7IK/FTDPg7dQ8rksYnUunWanxhTWIuAZczwstmjrbTUlRPDrc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=esDo1o7q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC801F000E9;
	Thu,  2 Jul 2026 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011260;
	bh=H44btbK2g/Rd3Maymyva8NopC3nK5OqIMLQaPK4Yck0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=esDo1o7qNZMZs7ep/rRgYnLGSWM4AEwAzlxmNqixX5LBcWTFKmoZGEwgnvsLF8wod
	 2YJRJ16+D7URxSIDN4lEJ5KIjSb43iHVTVk9Yl9z08QUISNuKqUs6NC1EETf9i87yE
	 2Mqg3UDoydgjGvzAgngZH195Dwis2NprGacwDHfk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 004/108] Revert "PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support"
Date: Thu,  2 Jul 2026 18:20:01 +0200
Message-ID: <20260702155112.205662540@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.110058792@linuxfoundation.org>
References: <20260702155112.110058792@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-271330-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBDEE6FAE6F

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit f176c47683bf6365e2f6d580d557fae49169a703.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 43555ad9e5dcf5..789cc0e3c10da9 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -341,20 +341,15 @@ static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
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
@@ -554,7 +549,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	writel(CFG_BRIDGE_SB_INIT,
 	       pci->dbi_base + AXI_MSTR_RESP_COMP_CTRL1);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
@@ -634,7 +629,7 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
@@ -727,7 +722,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	val |= EN;
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
@@ -1033,7 +1028,7 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
 				pcie->parf + PARF_NO_SNOOP_OVERRIDE);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
-- 
2.53.0




