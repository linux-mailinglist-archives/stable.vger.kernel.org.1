Return-Path: <stable+bounces-257496-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN0AORobG2pk/QgAu9opvQ
	(envelope-from <stable+bounces-257496-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:15:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5A260F39E
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3F44300E01F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2935634EF07;
	Sat, 30 May 2026 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tfe2kRrN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BBB3016E1;
	Sat, 30 May 2026 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161197; cv=none; b=WLtli+hmLhwH41pB3cReVEvSNhJkYFIzSD7vvy8bmihPrXXMLiWIY7VxW1cq79XY4aiVMicfHDD7T4r3m1I3skMl8ez3dclcrz/Prlb0EvgwUY36n6AzCDBiBvrUBiteANWaZegqWK5ht9xL40rBVmbjd5n+ErPp7iKBkTwOmYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161197; c=relaxed/simple;
	bh=RxIOT7Sm+6RfUrHsYeKB9YMogB4KO2EZz3PQZ4CtafM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXmUb2KO1rMG2RLyPGxvFBmV1//1sxQYkPZW8FvL9KKfjsbvJ2y1llG9rZJ2Fw4F0/6qchkruHL0sdQgxcOaBO0qvfNqUYLPycfM/VClHRrXrxO4eT4WZyPEu4WoKelYie8k7J9AGvo5t7DRZleJStxgFV4ZodPJW0jpn26o+xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tfe2kRrN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4522F1F00893;
	Sat, 30 May 2026 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161195;
	bh=RJoIiR8uWZxykP1HcHpFosdSrRAkR3BQvz4ymaLB0QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tfe2kRrNOFWdsnJdvz9sfqCoFTDtXaU8S/vLs4sQvPk95H7CCkhpfJvTw4YEyYQGm
	 z/cgLDsp0obwxs9drPgknDPPPPI+wsAJ2oX+0t6FvUSKz1ILvvmemmDi+nS0m28bIR
	 dacDR0VyhhwAYAvzwK6emf1r5T3LKGqlv9RCLGpI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 553/969] PCI: tegra194: Rename root_bus to root_port_bus in tegra_pcie_downstream_dev_to_D0()
Date: Sat, 30 May 2026 18:01:17 +0200
Message-ID: <20260530160315.654130781@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257496-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8A5A260F39E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

[ Upstream commit e1bd928479fb1fa60e9034b0fdb1ab9f3fa92f33 ]

In tegra_pcie_downstream_dev_to_D0(), PCI devices are transitioned to D0
state. For iterating over the devices, first the downstream bus of the Root
Port is searched from the root bus. But the name of the variable that holds
the Root Port downstream bus is named as 'root_bus', which is wrong.

Rename the variable to 'root_port_bus'. Also, move the comment on 'bringing
the devices to D0' to where the state is set exactly.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20250922081057.15209-1-mani@kernel.org
Stable-dep-of: 71d9f67701e1 ("PCI: tegra194: Don't force the device into the D0 state before L2")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index b6899d1f80fb5..46fe5abfad8c1 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1277,7 +1277,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
 {
 	struct dw_pcie_rp *pp = &pcie->pci.pp;
-	struct pci_bus *child, *root_bus = NULL;
+	struct pci_bus *child, *root_port_bus = NULL;
 	struct pci_dev *pdev;
 
 	/*
@@ -1290,19 +1290,19 @@ static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
 	 */
 
 	list_for_each_entry(child, &pp->bridge->bus->children, node) {
-		/* Bring downstream devices to D0 if they are not already in */
 		if (child->parent == pp->bridge->bus) {
-			root_bus = child;
+			root_port_bus = child;
 			break;
 		}
 	}
 
-	if (!root_bus) {
-		dev_err(pcie->dev, "Failed to find downstream devices\n");
+	if (!root_port_bus) {
+		dev_err(pcie->dev, "Failed to find downstream bus of Root Port\n");
 		return;
 	}
 
-	list_for_each_entry(pdev, &root_bus->devices, bus_list) {
+	/* Bring downstream devices to D0 if they are not already in */
+	list_for_each_entry(pdev, &root_port_bus->devices, bus_list) {
 		if (PCI_SLOT(pdev->devfn) == 0) {
 			if (pci_set_power_state(pdev, PCI_D0))
 				dev_err(pcie->dev,
-- 
2.53.0




