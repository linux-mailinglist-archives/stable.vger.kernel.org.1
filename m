Return-Path: <stable+bounces-257511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHJuO34bG2pk/QgAu9opvQ
	(envelope-from <stable+bounces-257511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:16:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A4860F4A9
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DFBA3025900
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31E73A8730;
	Sat, 30 May 2026 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1M9QZIWP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713593148DA;
	Sat, 30 May 2026 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161249; cv=none; b=EqrurVZsliLM4yyBBZ0W7JONKG7zJdvBUBiLnXpBSyybB2KUpnj8OecOFwhRabSOkPh1p66opaaXsqxl/FVVUZvJpGy7Qd/L3WUEx3xA0TCnVccPnjI0NRQ3TdQ1FLD1HzcF4uVdVoeshng1TlFCp40hrP1z18DNgBx8+6XyxZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161249; c=relaxed/simple;
	bh=1jMxI0neExaElfFNnzqiMtKq/b+A63X/SuEiPGAoFb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irVYQJuNUYtIDFjXVJqais6xDzEVCsAFvTn/sF8l69ycPBw1qrd/LCCzzUojz1E1MsRcvzqq9h9y/2w3Q8tdn9xFMTXZD32YCInQr1tQ1TL81AgmeGCSfX2en0OlrRQ7wx1+DJDQpslLC1Da8G90GUozUWCquffHouyC6wYRDbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1M9QZIWP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672A51F00893;
	Sat, 30 May 2026 17:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161248;
	bh=x54VOdSP9YS9vI9aoWPQKJHI5JjCH8En0o2mTidoDuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1M9QZIWPya/e7f3XJSsKslXwdxnMtTh3r2Mm4V6pmHA9LXuNPzKREnAFuHh9Te4iY
	 n4M5jLNuhk3IrIn/LpEPnG6ZdUxRuVPwjBTaLy9JQd4/LtX02soinyaCAvbXNIH9Mq
	 f2Mck0o49CV55ibuR8y+q8dMwAYQsM5MxIftgUco=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Schmidt <alexs@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 538/969] PCI: Enable AtomicOps only if Root Port supports them
Date: Sat, 30 May 2026 18:01:02 +0200
Message-ID: <20260530160315.226970443@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257511-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E1A4860F4A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 2cb94c77df780..953646cd759b0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3910,8 +3910,7 @@ int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
  */
 int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 {
-	struct pci_bus *bus = dev->bus;
-	struct pci_dev *bridge;
+	struct pci_dev *root, *bridge;
 	u32 cap, ctl2;
 
 	/*
@@ -3941,35 +3940,35 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
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




