Return-Path: <stable+bounces-219109-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBRJDIZXnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-219109-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:59:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8E719056B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 174DA31ECB1B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455AC2882B4;
	Wed, 25 Feb 2026 01:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KZ2FT4iO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A09281357;
	Wed, 25 Feb 2026 01:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984043; cv=none; b=JwSA248/oPYzsxxmnxHQZ2qGr72K2tZvy4xZAIYjy735omQTcZS8t4CDkr8zrdV1k5JZjLj2kNatSDAsMjmVHEcUBneEmhoDaEulbzqFW6X1YUGNVGpyPU/tJFxxgliqHmSquz7OYnPO5WRvZi7WuUdD2RtqFDnv+hP9GACIwyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984043; c=relaxed/simple;
	bh=smSHnupjDVKXrQdNWBSfk1PCtc+7SOTV5h6jYnNSMOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irOI9Y+t0oEg5v6rq9Wmrkl9vEr+5EOepHpLL34JZe/iyfzLUAwXsWg7PBUhSh+6iFNllK0kI2WItnHn9W1PSZp/MSYFwxvdxeGbZqA/f7DVf6hioE11h1HMpNzV8FBJ9ww0jHL/O8uPsYkyycgbaalnoJ6/3d/Gx8giit0DUzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KZ2FT4iO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5847C116D0;
	Wed, 25 Feb 2026 01:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771984042;
	bh=smSHnupjDVKXrQdNWBSfk1PCtc+7SOTV5h6jYnNSMOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZ2FT4iOuisOKBTcDNjlMYxJ63XPGeqNImg5Dnv6z1p+uSBt9DQMUKjceLIgaNhuy
	 awcc9YhucQ2FM8CKkt26mlr1VbdOCnYMn2/2EW8aB0FoVozxOp72HjNZmAbbK/gDJS
	 qeHfG2qcxX1htejp4vfcpQQsSQ9efWBtYrs2VCj0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Han Gao <gaohan@iscas.ac.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 243/641] PCI: sophgo: Disable L0s and L1 on Sophgo 2044 PCIe Root Ports
Date: Tue, 24 Feb 2026 17:19:29 -0800
Message-ID: <20260225012354.757324035@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,iscas.ac.cn];
	TAGGED_FROM(0.00)[bounces-219109-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 8F8E719056B
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Inochi Amaoto <inochiama@gmail.com>

[ Upstream commit 613f3255a35a95f52575dd8c60b7ac9d711639ce ]

Sophgo 2044 Root Ports advertise L0 and L1 capabilities without supporting
them. Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
states for devicetree platforms") force enabled ASPM on all device tree
platforms, the issue became evident and the SG2044 Root Port started
breaking.

Hence, disable the L0s and L1 capabilities in the LINKCAP register for the
SG2044 Root Ports, so that these states won't get enabled.

Fixes: 467d9c0348d6 ("PCI: dwc: Add Sophgo SG2044 PCIe controller driver in Root Complex mode")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
[mani: reworded description and corrected fixes tag]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Han Gao <gaohan@iscas.ac.cn>
Link: https://patch.msgid.link/20260109040756.731169-1-inochiama@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-sophgo.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-sophgo.c b/drivers/pci/controller/dwc/pcie-sophgo.c
index ad4baaa34ffa1..044088898819e 100644
--- a/drivers/pci/controller/dwc/pcie-sophgo.c
+++ b/drivers/pci/controller/dwc/pcie-sophgo.c
@@ -161,6 +161,22 @@ static void sophgo_pcie_msi_enable(struct dw_pcie_rp *pp)
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
+static void sophgo_pcie_disable_l0s_l1(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	u32 offset, val;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = dw_pcie_readl_dbi(pci, PCI_EXP_LNKCAP + offset);
+	val &= ~(PCI_EXP_LNKCAP_ASPM_L0S | PCI_EXP_LNKCAP_ASPM_L1);
+	dw_pcie_writel_dbi(pci, PCI_EXP_LNKCAP + offset, val);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
 static int sophgo_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	int irq;
@@ -171,6 +187,8 @@ static int sophgo_pcie_host_init(struct dw_pcie_rp *pp)
 
 	irq_set_chained_handler_and_data(irq, sophgo_pcie_intx_handler, pp);
 
+	sophgo_pcie_disable_l0s_l1(pp);
+
 	sophgo_pcie_msi_enable(pp);
 
 	return 0;
-- 
2.51.0




