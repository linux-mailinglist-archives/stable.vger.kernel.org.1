Return-Path: <stable+bounces-252396-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM4YNJAkDmr26QUAu9opvQ
	(envelope-from <stable+bounces-252396-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:16:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4037D59A9E5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFAFD35C37D8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9D73F86FB;
	Wed, 20 May 2026 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N/Z5zHQK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977273F8896;
	Wed, 20 May 2026 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300567; cv=none; b=U5BLZeQoqAI30krn7iHdbz+x83iVDlQD36DRiwcJKs5ajtahVLereuj7S6jHJh8/5ym6odJQsoiNbaiA40kzXeEbX2+igTFX8xNbvR4k+GdN16hgsSIITwHROXgcVLrt3+mEHaTE9mVm6QKR1H+Rl+glXgghLpxJneCQFvmnIuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300567; c=relaxed/simple;
	bh=EV+Q7LTXtnS2aTaJvUsZAFRGvX8bILK0DeFvsBSQfWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doeJgXuXYw530Uat5dFCJMAdK4Fzq/3XzPkUSl+Cb+RBsy6ZTsX43C69zDwp6y3HXaiNEsIbK87v319ZTjK8G8M+j3ArscPL0wEYOsifz/TMkR04Dc1VgTiZ4+Ar7ZNFG1thwt9XbR4Hi2EcT5dxfsNVsP0Mzh8vxwSFE0lHC1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N/Z5zHQK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5001F00893;
	Wed, 20 May 2026 18:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300564;
	bh=5bA2mzGSGuEUrKnN7p1wiHSTYcTe9BKEb2XC6WMcSh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N/Z5zHQK9fjDkitnBy7Fr0qHj5OwYyd22nMeY3B4lqZBiP0p32BYh/E4gTITorfUF
	 J+THN1SD6OMFq4Lvud8tZ+0q47xYpQbFb8dSr2+oBFsDTk5WLAIrFD64zsJcxR0sTe
	 3vTanhD1hAQaxSGmWWGUrs3kuVN3Yto+HsnY6a6U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Schmidt <alexs@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 224/666] PCI: Enable AtomicOps only if Root Port supports them
Date: Wed, 20 May 2026 18:17:15 +0200
Message-ID: <20260520162116.068343394@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252396-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 4037D59A9E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gerd Bayer <gbayer@linux.ibm.com>

[ Upstream commit 1ae8c4ce157037e266184064a182af9ef9af278b ]

When inspecting the config space of a Connect-X physical function in an
s390 system after it was initialized by the mlx5_core device driver, we
found the function to be enabled to request AtomicOps despite the Root Port
lacking support for completing them:

  00:00.1 Ethernet controller: Mellanox Technologies MT2894 Family [ConnectX-6 Lx]
          Subsystem: Mellanox Technologies Device 0002
          DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                   AtomicOpsCtl: ReqEn+

On s390 and many virtualized guests, the Endpoint is visible but the Root
Port is not.  In this case, pci_enable_atomic_ops_to_root() previously
enabled AtomicOps in the Endpoint even though it can't tell whether the
Root Port supports them as a completer.

Change pci_enable_atomic_ops_to_root() to fail if there's no Root Port or
the Root Port doesn't support AtomicOps.

Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
[bhelgaas: commit log, check RP first to simplify flow]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20260330-fix_pciatops-v7-2-f601818417e8@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2c8d0c1c317e4..d44c07bb0a229 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3850,8 +3850,7 @@ int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
  */
 int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 {
-	struct pci_bus *bus = dev->bus;
-	struct pci_dev *bridge;
+	struct pci_dev *root, *bridge;
 	u32 cap, ctl2;
 
 	/*
@@ -3881,35 +3880,35 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 		return -EINVAL;
 	}
 
-	while (bus->parent) {
-		bridge = bus->self;
+	root = pcie_find_root_port(dev);
+	if (!root)
+		return -EINVAL;
 
-		pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
+	pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
+	if ((cap & cap_mask) != cap_mask)
+		return -EINVAL;
 
+	bridge = pci_upstream_bridge(dev);
+	while (bridge != root) {
 		switch (pci_pcie_type(bridge)) {
-		/* Ensure switch ports support AtomicOp routing */
 		case PCI_EXP_TYPE_UPSTREAM:
-		case PCI_EXP_TYPE_DOWNSTREAM:
-			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
-				return -EINVAL;
-			break;
-
-		/* Ensure root port supports all the sizes we care about */
-		case PCI_EXP_TYPE_ROOT_PORT:
-			if ((cap & cap_mask) != cap_mask)
-				return -EINVAL;
-			break;
-		}
-
-		/* Ensure upstream ports don't block AtomicOps on egress */
-		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_UPSTREAM) {
+			/* Upstream ports must not block AtomicOps on egress */
 			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2,
 						   &ctl2);
 			if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK)
 				return -EINVAL;
+			fallthrough;
+
+		/* All switch ports need to route AtomicOps */
+		case PCI_EXP_TYPE_DOWNSTREAM:
+			pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2,
+						   &cap);
+			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
+				return -EINVAL;
+			break;
 		}
 
-		bus = bus->parent;
+		bridge = pci_upstream_bridge(bridge);
 	}
 
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
-- 
2.53.0




