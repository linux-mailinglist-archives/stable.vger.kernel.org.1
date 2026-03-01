Return-Path: <stable+bounces-221419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJomBX+Vo2lPHgUAu9opvQ
	(envelope-from <stable+bounces-221419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:25:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4011CA817
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8427A301CC91
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B027CCF2;
	Sun,  1 Mar 2026 01:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQfD7LWE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B7274B28;
	Sun,  1 Mar 2026 01:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328213; cv=none; b=pCc+FGIPQCxxL/hSbZzORwS67J+aqYawiPU9plK2N0jg4rPEx4gms7oZvNcdPrZ7nBfAvOfAzoMJP4wgX8ubTPhpNs133su9T4LRjn0c28syqA0RdLRZHCfdgcb9a/ecUZZXJYxfCpVS2bzvm6g/dB4256I8vPBGpt0mhmjEf2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328213; c=relaxed/simple;
	bh=//5SP2/0CvP9KuTPcyCOrHd1vJ29R6pkFffPXu3YoZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fh3AgBCFjtaepV8d/Ep1k52AZ7hrJH4TqxAZoWbV1ZSrmXXg4547fwDEwZGCeGtq36j60wyI2CuX0jpI+vUOf9Ogi6ywGiPwTt6b+tqoip7epFq7QP41pQJxoDb4/Kc6eeCyGKDFRDfLo0uLF2QBiag8nLnNBNY2W+SWGxWaPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQfD7LWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F06C4AF09;
	Sun,  1 Mar 2026 01:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328213;
	bh=//5SP2/0CvP9KuTPcyCOrHd1vJ29R6pkFffPXu3YoZ4=;
	h=From:To:Cc:Subject:Date:From;
	b=IQfD7LWE8E5la/xBF7sVPKmPGClvqRm7LWPOqhzoL0h4m/v4PIMSw6liE+PW5RUA4
	 YhxGE6Otggc18c0DQwPZkHwfNnf/9VyHIz7QZlYsL2C3dyiZb02L+EO8cL9hzJvmG9
	 2OTeB8vFqGRIC+y9etEyIgsq9w5ijf0A76ljn+ityHMPVc65YUECvsTCmo6qqxBgwN
	 gRFW1sFPDPU6Azqti6vuscoKAprxSFHR8Jv/S4+oM0W1m+10knN3rxb/y85+WhKkWU
	 HFyPgt7Ec7HCFE3M1t4KxWN9aduvFIUt+fPbXDR/F5lrh7BYBbAaMxbGVKNjvPYJE9
	 aIky1cagd7xLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mmaddireddy@nvidia.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "PCI: endpoint: Fix swapped parameters in pci_{primary/secondary}_epc_epf_unlink() functions" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:23:30 -0500
Message-ID: <20260301012331.1680247-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221419-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,nxp.com:email]
X-Rspamd-Queue-Id: 8E4011CA817
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
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





