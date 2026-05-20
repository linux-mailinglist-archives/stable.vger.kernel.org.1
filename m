Return-Path: <stable+bounces-251535-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHF8Hs8bDmrP6AUAu9opvQ
	(envelope-from <stable+bounces-251535-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:38:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB004599E02
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FC1533D7C4A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1243A3825;
	Wed, 20 May 2026 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sZGprU1d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0219B30675C;
	Wed, 20 May 2026 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298232; cv=none; b=Th3VVxTfWQChc7DILjrsYxn9ELGRDjPgUruDx3i6gR7fYE6MGxOheBFAoqdnuOlNEzbL8VvTaIFuyUQstVEjwW+A9cY0WuuDFvbXBC7RNC63hIHBLafViTocXqKqVfhDT2AXMZSae6Hkclh5MsK0tBoe7/zUhZWPM0w5SQMJ0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298232; c=relaxed/simple;
	bh=gqKIEatqJ9IF3Oh2LtGs3X9gCxFfrf2e88V6KvXRu/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhrElYYJAo5Y23mRDbz5qP3f73qjbP3LE1wttAwSkQbFnxkOoWwH2IDJ7fYEM/srBW8SW4+F8eNIrZ9e53f4tHf4oZFMU4wvRip3vM8PRIgdZL/QKqcVaB7wt6HjhxpiH8CavHtZ+1oFpwOktCURLT/i8NxC5bp5YlB0os/GV3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sZGprU1d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8581F000E9;
	Wed, 20 May 2026 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298230;
	bh=9iXLPD00G1KcpDHtctyYgvNXzbFGQOYoEVqxx5OJiFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sZGprU1d8Lr67uyB2M7W4d/lFek9wLqjuP2o+6IqdLKpqN2rSW0XO4liZ9egTf28R
	 dpa+h8Q9qmx46+pfWBnJiD+6RTBpwQoQkIv6hn8J/LwsIlJCPvIVho4jDGKovQyUa6
	 qT03d0cOV8KJHqtNt9RP6hSYlIFTPw2xsDiM+XHQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 332/957] PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
Date: Wed, 20 May 2026 18:13:35 +0200
Message-ID: <20260520162141.730905094@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251535-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DB004599E02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manikanta Maddireddy <mmaddireddy@nvidia.com>

[ Upstream commit 34b3eef48d980cd37b876e128bbf314f69fb5d70 ]

When PERST# is deasserted twice (assert -> deassert -> assert -> deassert),
a CBB (Control Backbone) timeout occurs at DBI register offset 0x8bc
(PCIE_MISC_CONTROL_1_OFF). This happens because pci_epc_deinit_notify()
and dw_pcie_ep_cleanup() are called before reset_control_deassert() powers
on the controller core.

The call chain that causes the timeout:

  pex_ep_event_pex_rst_deassert()
    pci_epc_deinit_notify()
      pci_epf_test_epc_deinit()
        pci_epf_test_clear_bar()
          pci_epc_clear_bar()
            dw_pcie_ep_clear_bar()
              __dw_pcie_ep_reset_bar()
                dw_pcie_dbi_ro_wr_en()      <- Accesses 0x8bc DBI register
    reset_control_deassert(pcie->core_rst)  <- Core powered on HERE

The DBI registers, including PCIE_MISC_CONTROL_1_OFF (0x8bc), are only
accessible after the controller core is powered on via
reset_control_deassert(pcie->core_rst). Accessing them before this point
results in a CBB timeout because the hardware is not yet operational.

Fix this by moving pci_epc_deinit_notify() and dw_pcie_ep_cleanup() to
after reset_control_deassert(pcie->core_rst), ensuring the controller is
fully powered on before any DBI register accesses occur.

Fixes: 40e2125381dc ("PCI: tegra194: Move controller cleanups to pex_ep_event_pex_rst_deassert()")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Link: https://patch.msgid.link/20260324190755.1094879-15-mmaddireddy@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index c37be61f2b90a..fdbf440fb3819 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1750,10 +1750,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		goto fail_phy;
 	}
 
-	/* Perform cleanup that requires refclk */
-	pci_epc_deinit_notify(pcie->pci.ep.epc);
-	dw_pcie_ep_cleanup(&pcie->pci.ep);
-
 	/* Clear any stale interrupt statuses */
 	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L0);
 	appl_writel(pcie, 0xFFFFFFFF, APPL_INTR_STATUS_L1_0_0);
@@ -1823,6 +1819,10 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	reset_control_deassert(pcie->core_rst);
 
+	/* Perform cleanup that requires refclk and core reset deasserted */
+	pci_epc_deinit_notify(pcie->pci.ep.epc);
+	dw_pcie_ep_cleanup(&pcie->pci.ep);
+
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	val &= ~PORT_LOGIC_SPEED_CHANGE;
 	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
-- 
2.53.0




