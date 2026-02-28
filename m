Return-Path: <stable+bounces-220766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCsGH4RBo2lC+wQAu9opvQ
	(envelope-from <stable+bounces-220766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:27:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0805F1C7001
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD0E030B9987
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D4E33EAF8;
	Sat, 28 Feb 2026 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2Xp63cX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4328D406D57;
	Sat, 28 Feb 2026 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300646; cv=none; b=t6tCBKuvEFzQ2GFjRWezNwKuF2Lsma1mtIc8v6iSKBmAhy4rwqn3O3jVqFNs7mK7sP6gp8fBIDjO/SjUmsls1SFnLSHUEERVVsdaQdHTCvcZ/Cj/9afosazPMU5NnAvjT6gUQq5DyeltpM0sG7zgjl5XN07eRRMdpanyNp0GVrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300646; c=relaxed/simple;
	bh=uywr7CSIBVJdzBj0/d7eb/WIoGhpGFKanqhG09sqgeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0444jgVJMwQLkg6o54D1x6+Cp2duXXfxb5uUtgysZ6ERVr7NO2s+0eHYUldXM1nyVNGjKZC2fmF7e6dU5c4Kt9hfWmUJM76eebMmFn0TyCfWlKR5mmf+3Y1hacWEmItyPvx1+ooh746IEI5zDP5i3uObkP8Hx8xACfMmtdm46k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2Xp63cX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E5AC19423;
	Sat, 28 Feb 2026 17:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300646;
	bh=uywr7CSIBVJdzBj0/d7eb/WIoGhpGFKanqhG09sqgeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2Xp63cX/kgJLz/L2EMBRbb4sBY6rO+HWw+e3r4306O2LAwcKH2zOUEu1DqCzfW7s
	 PdZZ6BsrGCr/x5UJav5AgbVVdFoHEJcQm4nh0lVwoYsRVOtV0F2KKjnmfEpmtQ76HS
	 dPeNne4sDH2uliG1tDoeStszT5lZSzMn5+ltnOi2MFax5eajNqATL5ALYANCXmzUaq
	 93kbA96SsOuG7buWA2I5qo5i2kGIw0gZPp3nT9hSIsrV6zcpBOjULddhex+a5LdZs3
	 JZVIjahXPO7R1BDr/HnuHaQ9ZEogdB8Zp77qko4Uf30o57nVgZBtfWOHNJvxaYfzV1
	 qYX9bUXKOTGaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 687/844] PCI: endpoint: Fix swapped parameters in pci_{primary/secondary}_epc_epf_unlink() functions
Date: Sat, 28 Feb 2026 12:30:00 -0500
Message-ID: <20260228173244.1509663-688-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220766-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nvidia.com:email]
X-Rspamd-Queue-Id: 0805F1C7001
X-Rspamd-Action: no action

From: Manikanta Maddireddy <mmaddireddy@nvidia.com>

[ Upstream commit 8754dd7639ab0fd68c3ab9d91c7bdecc3e5740a8 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


