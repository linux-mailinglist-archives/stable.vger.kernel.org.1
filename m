Return-Path: <stable+bounces-243119-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJUyAFim+GkExgIAu9opvQ
	(envelope-from <stable+bounces-243119-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:59:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 726E24BE471
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FD27303F07C
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF7F3DDDBC;
	Mon,  4 May 2026 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cju7FQPP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18372E2F0E;
	Mon,  4 May 2026 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903067; cv=none; b=JGd3q/vVArl+oIjLkWBwrrBfP2iFdr47M9y+sa9zLU/P71ejjoArKdDo6a8uce8HzdCU3M6/TTcsdCqBJjkMMhPh9TlZfTGyxbQyt+ZqNamDAIMtAyHolGgJdhuG6SiSCkw9KtbaEo494B5GKabw09wuAELtF5s7YYcRKxEStLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903067; c=relaxed/simple;
	bh=yFbQYF4G54rBF2G8XCIdaYZIDpJWwf04TaAKMzi9Pvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWuE9cE2cdcezJ8I3iYTLnLRdfb5tA/VD6+S/VTvuVfgoNK3O/OKj41GxfCYJDzk9ft1jRfr0OFDBEhAZ1fpAvntbL/Rq0dCE8O722jksy0uq8/AjK3zuyBFqH74ySBQ4urWcb1vWTpG3ivGLptmPUkdpB/OLoiaddwxp8y4syU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cju7FQPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369C5C2BCC4;
	Mon,  4 May 2026 13:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903066;
	bh=yFbQYF4G54rBF2G8XCIdaYZIDpJWwf04TaAKMzi9Pvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cju7FQPPe2fB1dJeM0LgSG0BGYbDonrV/TDZ+hyhX1oJ542PAOfkWjUQX1mBB8Grh
	 GSN/ojirZz1YzDoUJShQvlI93p6o2hLSlSBz4e58A8HuTeEY/7GaYT3mj5n7/F8EI/
	 +7xUTSor8fXhyXtc7fuZX/VWdn1LIAR16v4WcyWs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aksh Garg <a-garg7@ti.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 7.0 090/307] PCI: cadence: Use cdns_pcie_read_sz() for byte or word read access
Date: Mon,  4 May 2026 15:49:35 +0200
Message-ID: <20260504135146.201830703@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 726E24BE471
X-Rspamd-Action: no action
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243119-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aksh Garg <a-garg7@ti.com>

commit d9cf7154deed71a4f23e81101571c79cdc77be00 upstream.

The commit 18ac51ae9df9 ("PCI: cadence: Implement capability search
using PCI core APIs") assumed all the platforms using Cadence PCIe
controller support byte and word register accesses. This is not true
for all platforms (e.g., TI J721E SoC, which only supports dword
register accesses).

This causes capability searches via cdns_pcie_find_capability() to fail
on such platforms.

Fix this by using cdns_pcie_read_sz() for config read functions, which
properly handles size-aligned accesses. Remove the now-unused byte and
word read wrapper functions (cdns_pcie_readw and cdns_pcie_readb).

Fixes: 18ac51ae9df9 ("PCI: cadence: Implement capability search using PCI core APIs")
Signed-off-by: Aksh Garg <a-garg7@ti.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260402085545.284457-1-a-garg7@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/cadence/pcie-cadence.h |   56 +++++++++++---------------
 1 file changed, 25 insertions(+), 31 deletions(-)

--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -249,37 +249,6 @@ static inline u32 cdns_pcie_hpa_readl(st
 	return readl(pcie->reg_base + reg);
 }
 
-static inline u16 cdns_pcie_readw(struct cdns_pcie *pcie, u32 reg)
-{
-	return readw(pcie->reg_base + reg);
-}
-
-static inline u8 cdns_pcie_readb(struct cdns_pcie *pcie, u32 reg)
-{
-	return readb(pcie->reg_base + reg);
-}
-
-static inline int cdns_pcie_read_cfg_byte(struct cdns_pcie *pcie, int where,
-					  u8 *val)
-{
-	*val = cdns_pcie_readb(pcie, where);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static inline int cdns_pcie_read_cfg_word(struct cdns_pcie *pcie, int where,
-					  u16 *val)
-{
-	*val = cdns_pcie_readw(pcie, where);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static inline int cdns_pcie_read_cfg_dword(struct cdns_pcie *pcie, int where,
-					   u32 *val)
-{
-	*val = cdns_pcie_readl(pcie, where);
-	return PCIBIOS_SUCCESSFUL;
-}
-
 static inline u32 cdns_pcie_read_sz(void __iomem *addr, int size)
 {
 	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
@@ -320,6 +289,31 @@ static inline void cdns_pcie_write_sz(vo
 	writel(val, aligned_addr);
 }
 
+static inline int cdns_pcie_read_cfg_byte(struct cdns_pcie *pcie, int where,
+					  u8 *val)
+{
+	void __iomem *addr = pcie->reg_base + where;
+
+	*val = cdns_pcie_read_sz(addr, 0x1);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static inline int cdns_pcie_read_cfg_word(struct cdns_pcie *pcie, int where,
+					  u16 *val)
+{
+	void __iomem *addr = pcie->reg_base + where;
+
+	*val = cdns_pcie_read_sz(addr, 0x2);
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static inline int cdns_pcie_read_cfg_dword(struct cdns_pcie *pcie, int where,
+					   u32 *val)
+{
+	*val = cdns_pcie_readl(pcie, where);
+	return PCIBIOS_SUCCESSFUL;
+}
+
 /* Root Port register access */
 static inline void cdns_pcie_rp_writeb(struct cdns_pcie *pcie,
 				       u32 reg, u8 value)



