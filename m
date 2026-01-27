Return-Path: <stable+bounces-211843-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAdbGbzYeGmftgEAu9opvQ
	(envelope-from <stable+bounces-211843-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:24:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F6C96A11
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C28C319AACF
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E076362128;
	Tue, 27 Jan 2026 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdePxxiy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D4E35EDCF;
	Tue, 27 Jan 2026 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526660; cv=none; b=Uy1MwajoZn2BH3yeJ0O39O2tA4m/FzYx5eDylLNME4lk7BdkfrveyR0ZmKY0QU4zP/hYjSyrdLRm4ydsmdyX2Y/MwZFYCzzpAI9cHlKXyPHURZyzo/KRqWsY8DYIR9j9vbp021+9kOMH/XJGfvSaxoUAKaIAmcXPO7YxoSU/EjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526660; c=relaxed/simple;
	bh=tmnHHyktYtkZZnXHfsHHrgH0b7Jn5yEbu456uezyJ+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6SIJxHlnTlceAtDUcg3wHxsHIt8Y0uN0Imqe2JYF9H+VQSbqKUg5kSM4MJi+Pluue+3Y69GoXZoNBBFhYTs6+Q/7JNhL6r+UddBRmxmcW5PglJd3p/ZMB9TMY3s3oQxGcMTL7Q3TNe3R/4Ids6Urt+xilzT69M+2lJWXnikei0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdePxxiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04221C4AF0C;
	Tue, 27 Jan 2026 15:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769526660;
	bh=tmnHHyktYtkZZnXHfsHHrgH0b7Jn5yEbu456uezyJ+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdePxxiymC0M1a2LflGAIdeHHXV3T/AISfyr5rThr6yvpT49ThPQLIGA8OGtbZM33
	 v5/ad1AA4E8FtCTQx4O97P2OP3SvGmhF31nE8+n8tdnJlVDH3wUCms6a9PZM2v3sft
	 sTEUWYzycku/+gdjqEVG+MHaGE4M2eqjvqIhD3LVIZ8YwaRJ7+YsZDgryKDqpRD7n+
	 KqBUfB82kB9u8oTp0sWF9g/CDk4GFyFwu7XdRNOZJcwJmfopcgDkFiHw+Sr6FfJKO3
	 JMxMJCKVDkaIJ9KZKR0Mow31HZgYcbVkiRbaEYWntC6YhqpsvNVNeonnt3swnrnbYT
	 B3fYqcTSBSegA==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>,
	tim609@andestech.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	dlemoal@kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 1/3] PCI: dwc: Fix msg_atu_index assignment
Date: Tue, 27 Jan 2026 16:10:39 +0100
Message-ID: <20260127151038.1484881-6-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127151038.1484881-5-cassel@kernel.org>
References: <20260127151038.1484881-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2236; i=cassel@kernel.org; h=from:subject; bh=tmnHHyktYtkZZnXHfsHHrgH0b7Jn5yEbu456uezyJ+0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDIrrhYFhazeYWETK7+cX65pZpL3ghPGUc05AVnL1A+ta XpS1/Ouo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABPZ9pCR4fnOSuHwXa12tRav 7qez7RH+9TRlb/LJ/BqfW+3r5s/kvczwz4BF/PDZjb4uf1a25N3+Upwisf6HkOb2+9IhoksyJ75 fwwAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211843-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,google.com,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 98F6C96A11
X-Rspamd-Action: no action

When dw_pcie_iatu_setup() configures outbound address translation for both
type PCIE_ATU_TYPE_MEM and PCIE_ATU_TYPE_IO, the iATU index to use is
incremented before calling dw_pcie_prog_outbound_atu().

However, for msg_atu_index the index is not incremented before use,
causing the iATU index to be the same as the last configured iATU index,
which means that it will incorrectly use the same iATU index that is
already in use, breaking outbound address translation.

In total there are three problems with this code:
-It assigns msg_atu_index the same index that was used for the last
 outbound address translation window, rather than incrementing the index
 before assignment.
-The index should only be incremented (and msg_atu_index assigned) if the
 use_atu_msg feature is actually requested/in use (pp->use_atu_msg is set).
-If the use_atu_msg feature is requested/in use, and there are no outbound
 iATUs available, the code should return an error, as otherwise when this
 this feature is used, it will use an iATU index that is out of bounds.

Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index b3d6a474fd16..d7f57d77bdf5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -982,7 +982,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
-	pp->msg_atu_index = i;
+	if (pp->use_atu_msg) {
+		if (pci->num_ob_windows > ++i) {
+			pp->msg_atu_index = i;
+		} else {
+			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
+			return -ENOMEM;
+		}
+	}
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
-- 
2.52.0


