Return-Path: <stable+bounces-222111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBaIEJ2do2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:59:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEE81CC8BB
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50D1A30E3EE9
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05EF305047;
	Sun,  1 Mar 2026 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3z3mEad"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F632FD681;
	Sun,  1 Mar 2026 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329927; cv=none; b=qp5XRbHL7USvITKP2M57vBZ0BZ7HG+Yd4A2GMP/YHv6aJbFuUFZ7Ql1WMLmylOSDvCZDHPgNKDe7ZPuGG16hpDdEn+KLIw28vQsNBMIDayxfd5V2AyK9eiF4FQoTfDFxQ9Umga0gbzKIu2+Nk8+2qN9nS0IS9kmp0CDQkkORCJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329927; c=relaxed/simple;
	bh=LHfIDL0Od71IQy3hvBFo2VaqVj3BGoqhdpEsekWeTP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pvp+kN6zOiV6nwYe/CO9yLXpImY4Gr3TKpEeHxxq0UsM3lJo//vt/X88zlV1LbmxJXspjx3xPn1gx/E9KtCenoBCSpxYRWcwib2ujdubfMRgLtuxX18Xy0o6Sh0DwgsYma1O+alT7A4egDMhh9IILVGHoQnz7W0SdIDMr+zahfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3z3mEad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA455C19421;
	Sun,  1 Mar 2026 01:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329927;
	bh=LHfIDL0Od71IQy3hvBFo2VaqVj3BGoqhdpEsekWeTP4=;
	h=From:To:Cc:Subject:Date:From;
	b=O3z3mEadgsZM05alBUe0KLPmyx+MuJ+ELLWGYNiGYS8RE0FcfNcESXAqm5yupBuj/
	 gAem9SRzBPnsDkRxo05EuQyQ3oQMuq+4Rvfr0urZ9Jv9L9BabLBdGQ24FM9oaoDz4S
	 WMImLrh9eRawhLnojGh2+vl6UZTZuzwVZYBBC4PyTfrV7FSiNZyWUp6JYqvKaJ5avD
	 yywsNuFgFlB7Yg7JiXHRGaWXHId2OvxgH0CAFsQpULmMUXtKmWMM69G8kfUOMK9qdz
	 716tXEqgQEiRD3xSZzr5giJ+xxHZOD37gFguUxlsAPVeYR0vdq72VCEUQJicZy2XzK
	 vtoRzqBbXjSNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mmaddireddy@nvidia.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "PCI: endpoint: Fix swapped parameters in pci_{primary/secondary}_epc_epf_unlink() functions" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:52:05 -0500
Message-ID: <20260301015205.1718530-1-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222111-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,msgid.link:url,nxp.com:email]
X-Rspamd-Queue-Id: DAEE81CC8BB
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8754dd7639ab0fd68c3ab9d91c7bdecc3e5740a8 Mon Sep 17 00:00:00 2001
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Date: Thu, 8 Jan 2026 11:57:47 +0530
Subject: [PATCH] PCI: endpoint: Fix swapped parameters in
 pci_{primary/secondary}_epc_epf_unlink() functions

struct configfs_item_operations callbacks are defined like the following:

  int (*allow_link)(struct config_item *src, struct config_item *target);
  void (*drop_link)(struct config_item *src, struct config_item *target);

While pci_primary_epc_epf_link() and pci_secondary_epc_epf_link() specify
the parameters in the correct order, pci_primary_epc_epf_unlink() and
pci_secondary_epc_epf_unlink() specify the parameters in the wrong order,
leading to the below kernel crash when using the unlink command in
configfs:

  Unable to handle kernel paging request at virtual address 0000000300000857
  Mem abort info:
  ...
  pc : string+0x54/0x14c
  lr : vsnprintf+0x280/0x6e8
  ...
  string+0x54/0x14c
  vsnprintf+0x280/0x6e8
  vprintk_default+0x38/0x4c
  vprintk+0xc4/0xe0
  pci_epf_unbind+0xdc/0x108
  configfs_unlink+0xe0/0x208+0x44/0x74
  vfs_unlink+0x120/0x29c
  __arm64_sys_unlinkat+0x3c/0x90
  invoke_syscall+0x48/0x134
  do_el0_svc+0x1c/0x30prop.0+0xd0/0xf0

Fixes: e85a2d783762 ("PCI: endpoint: Add support in configfs to associate two EPCs with EPF")
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
[mani: cced stable, changed commit message as per https://lore.kernel.org/linux-pci/aV9joi3jF1R6ca02@ryzen]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260108062747.1870669-1-mmaddireddy@nvidia.com
---
 drivers/pci/endpoint/pci-ep-cfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 43feb6139fa36..8b392a8363bb1 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -68,8 +68,8 @@ static int pci_secondary_epc_epf_link(struct config_item *epf_item,
 	return 0;
 }
 
-static void pci_secondary_epc_epf_unlink(struct config_item *epc_item,
-					 struct config_item *epf_item)
+static void pci_secondary_epc_epf_unlink(struct config_item *epf_item,
+					 struct config_item *epc_item)
 {
 	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item->ci_parent);
 	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
@@ -132,8 +132,8 @@ static int pci_primary_epc_epf_link(struct config_item *epf_item,
 	return 0;
 }
 
-static void pci_primary_epc_epf_unlink(struct config_item *epc_item,
-				       struct config_item *epf_item)
+static void pci_primary_epc_epf_unlink(struct config_item *epf_item,
+				       struct config_item *epc_item)
 {
 	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item->ci_parent);
 	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
-- 
2.51.0





