Return-Path: <stable+bounces-211315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFhTMmyUcmksmQAAu9opvQ
	(envelope-from <stable+bounces-211315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 22:19:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D94D6DA9B
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 22:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 671483010D9C
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 21:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22573BE486;
	Thu, 22 Jan 2026 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFoEAKIm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6EB2D8396;
	Thu, 22 Jan 2026 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769116768; cv=none; b=GBlNvpx4W94tB9ZmTH+xYDUYHp3ckQb6L+WYIQslRRpsnDL6BPg5aKTu9vqPjphjtHS7b6g0o8hsAvQssk/95et6Mr4zAbOdaJGiILafvUWAUE+ZhVI0uXw6FUhzB2GV5x7avP2acR7U9jjacbjtp6ia2fgzHsDO5Wd/CUltXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769116768; c=relaxed/simple;
	bh=bystnSK/iqbWozZ7hbo6gpEx8M3AERXWdK58MlZ2V44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+YizOlLo2I28L8GwvV4dhZNDBjwY9+B1P4hql982dCTAapmjSHQf+q/vUprnKMaOxKAkxEYs/+uOzePk4o7rlvxkGwCQqEIV/63PII+qyExAYKuf+ALgftBkV3fuukHYBuBmDA0OH3jVqsYUvSNjHrdQkjI4NUL0waywGPaJcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFoEAKIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4ABC116C6;
	Thu, 22 Jan 2026 21:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769116768;
	bh=bystnSK/iqbWozZ7hbo6gpEx8M3AERXWdK58MlZ2V44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFoEAKImmRrF0iBubHmvI7C5xPKsb1k1+A5ekvmjLDN8EhFd3c3rntizCJzF5xE+V
	 4STZ5pqHpfeARb0FKKtL8x1Y4qyzOGohJyg2tfSdeVq/GCa8bAndc7GzDW00GoILfP
	 KNJTcgStKu3x5gJ3M1bLhCW+vXPY8/myr4+4mqGXyRjY3y04Fnlm0DQlh6bDHOLJMY
	 TM1kBWiCDmNbXFMscsoJaJoD5V6DuxLfad5eHMzJrrxeTaQ9dYCOj6g1AaIp58Il6w
	 zttkHAl2v82ITe2gQ8MeOkBpvZHMouJcU98wY9K/GSMduYgVxARcdaAJi2qH85YyH8
	 G15fO2RMNfL9Q==
Date: Thu, 22 Jan 2026 22:19:23 +0100
From: Niklas Cassel <cassel@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: dwc: Fix skipped index 0 in outbound ATU
 setup
Message-ID: <aXKUW8euDVaRJofR@ryzen>
References: <20251229-ecam_io_fix-v2-0-41a0e56a6faa@oss.qualcomm.com>
 <20251229-ecam_io_fix-v2-1-41a0e56a6faa@oss.qualcomm.com>
 <aXI8ByG3RlLpIRRa@ryzen>
 <alpine.DEB.2.21.2601221806080.6421@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PQqAQjSSbpBNymFr"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2601221806080.6421@angie.orcam.me.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211315-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,kernel.org,google.com,nxp.com,baikalelectronics.ru,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D94D6DA9B
X-Rspamd-Action: no action


--PQqAQjSSbpBNymFr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 22, 2026 at 06:16:11PM +0000, Maciej W. Rozycki wrote:
> On Thu, 22 Jan 2026, Niklas Cassel wrote:
> 
> > Also see my series here:
> > https://lore.kernel.org/linux-pci/20260122145411.453291-4-cassel@kernel.org/T/
> > 
> > That tries to clean up this mess.
> 
>  Is your patchset referred meant to replace this one or does it apply on 
> top?

This series does no longer apply, as it collides with a commit queued on
controller/dwc branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=e9a5415adb209f86a05e55b850127ada82e070f1

My patches are based on top of the above commit.
(I saw the big mess we currently have with regards to iatu indexing,
so I decided to clean it up, but making things consistent.)


So first of all, this series needs to be rebased.
If you ask me personally, I would prefer if Krishna could rebase on top
of my cleanups.


Patch 1/3 in this series is simply wrong, so it should be dropped.

Patch 2/3 in this series is similar to patch 1/3 in my series, but seems
to also have some extra prints that seem to be unrelated to fixing the issue
at hand. (Fine to add extra prints in some other function, but don't do it in
the fix patch itself that will be backported to stable releases.)

Patch 3/3 is the only patch that needs to be rebased, and seem to be the
patch that solves your issue.


I don't like the way that patch 3/3 is implemented.

ECAM will use two iATUs, one for PCIE_ATU_TYPE_CFG0 one for
PCIE_ATU_TYPE_CFG1. But this patch completely disregards that
this driver already reserves iATU index 0 for PCIE_ATU_TYPE_CFG0,
but for non-ECAM versions.

Now I understand why they have patch 1/3 in this series.

But it is still wrong. It has to change the indexing based on ECAM
is used or not.

Please try the attached patch on top of my series.

It avoids the need to introduce a new struct member.


Kind regards,
Niklas

--PQqAQjSSbpBNymFr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=0001-PCI-dwc-Fix-ECAM.patch

From b3d345d7075a4757c10b8fbf85154da66bccfebf Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Thu, 22 Jan 2026 22:05:39 +0100
Subject: [PATCH] PCI: dwc: Fix ECAM ...

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.c  |  6 ++++
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index eda94db04b63..ef66a031f0bb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -441,7 +441,7 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
 	/*
 	 * Root bus under the host bridge doesn't require any iATU configuration
 	 * as DBI region will be used to access root bus config space.
-	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
+	 * Immediate bus under Root Bus needs type 0 iATU configuration and
 	 * remaining buses need type 1 iATU configuration.
 	 */
 	atu.index = 0;
@@ -641,14 +641,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_free_msi;
 
-	if (pp->ecam_enabled) {
-		ret = dw_pcie_config_ecam_iatu(pp);
-		if (ret) {
-			dev_err(dev, "Failed to configure iATU in ECAM mode\n");
-			goto err_free_msi;
-		}
-	}
-
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
@@ -892,8 +884,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	struct resource_entry *entry;
-	int ob_iatu_index_to_use = 0;
-	int ib_iatu_index_to_use = 0;
+	int ob_iatu_index_to_use;
+	int ib_iatu_index_to_use;
 	int i, ret;
 
 	if (!pci->num_ob_windows) {
@@ -915,8 +907,20 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	 * NOTE: For outbound address translation, outbound iATU at index 0 is
 	 * reserved for CFG IOs (dw_pcie_other_conf_map_bus()), thus start at
 	 * index 1.
+	 *
+	 * If using ECAM, outbound iATU at index 0 and index 1 is reserved for
+	 * CFG IOs.
 	 */
-	ob_iatu_index_to_use++;
+	if (pp->ecam_enabled) {
+		ob_iatu_index_to_use = 2;
+		ret = dw_pcie_config_ecam_iatu(pp);
+		if (ret) {
+			dev_err(pci->dev, "Failed to configure iATU in ECAM mode\n");
+			return ret;
+		}
+	} else {
+		ob_iatu_index_to_use = 1;
+	}
 
 	resource_list_for_each_entry(entry, &pp->bridge->windows) {
 		resource_size_t res_size;
@@ -1002,6 +1006,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		}
 	}
 
+	ib_iatu_index_to_use = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
 		resource_size_t res_start, res_size, window_size;
 
@@ -1157,9 +1162,10 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	/*
 	 * If the platform provides its own child bus config accesses, it means
 	 * the platform uses its own address translation component rather than
-	 * ATU, so we should not program the ATU here.
+	 * ATU, so we should not program the ATU here. If ECAM is enabled,
+	 * config space access goes through ATU, so set up ATU here.
 	 */
-	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
+	if (pp->bridge->child_ops == &dw_child_pcie_ops || pp->ecam_enabled) {
 		ret = dw_pcie_iatu_setup(pp);
 		if (ret)
 			return ret;
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 2fa9f6ee149e..766df22fe46e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -531,6 +531,9 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	u32 retries, val;
 	u64 limit_addr;
 
+	if (atu->index > pci->num_ob_windows)
+		return -ENOSPC;
+
 	limit_addr = parent_bus_addr + atu->size - 1;
 
 	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
@@ -604,6 +607,9 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 	u64 limit_addr = pci_addr + size - 1;
 	u32 retries, val;
 
+	if (index > pci->num_ib_windows)
+		return -ENOSPC;
+
 	if ((limit_addr & ~pci->region_limit) != (pci_addr & ~pci->region_limit) ||
 	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
 	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
-- 
2.52.0


--PQqAQjSSbpBNymFr--

