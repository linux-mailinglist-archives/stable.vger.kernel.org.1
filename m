Return-Path: <stable+bounces-211245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL1iF7tEcmnpfAAAu9opvQ
	(envelope-from <stable+bounces-211245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:39:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C29AD690A3
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 505008CCA1D
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7F347BC7;
	Thu, 22 Jan 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0AVLy1W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FED352FBC;
	Thu, 22 Jan 2026 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093758; cv=none; b=hzMVlb5fMXP/Ow1+wcvNaLDKsWd2eXp5QczBpoohlhRAzd4n4yzuMH0Xbc5oUE8OjNyzJEIbTjp2OHFhYZxoI4TZW4bsX8uCxZf2jIwhYlhSlMVqOQNDVpzWNuT3XutuzEnZAjkzH82FQ73ZuujnjkEE4AHV1jmtmWbpnbQ1V8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093758; c=relaxed/simple;
	bh=+1Q7gO3prk+8BEJeWfMGZVuTfWAJGRfH9gKD0e7Odgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzlJs5Qh3m3Khy6q4bmb5qybX9MakgEb8g37RC/UMx8N54fQ5UJtIx1cxaFHmwi7jSvScxJIOTzMma18cwn2geJec8txm4YJcxuIK5cg1yMuANk3pahxibMmbs4Rd6cNRRqjtzuCo/jf5rcF5G+9GHrUVzJaPbvo5LhDVg7xqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0AVLy1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE36C116C6;
	Thu, 22 Jan 2026 14:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769093757;
	bh=+1Q7gO3prk+8BEJeWfMGZVuTfWAJGRfH9gKD0e7Odgc=;
	h=From:To:Cc:Subject:Date:From;
	b=i0AVLy1Wzlpqkac1GbteNla4ykwSmm6mggY69VbpR1EDWyvIzeGnxmsD+InP7rLjs
	 EzDd8akTWuiO4NMOnrljvmFgQV0juqlGauY9wTYanJMCujCJ7b27JBRoZ0oBbAx2vm
	 afjy/lpppZpD83bA+nqxKgwIXL/YeEUwChN0U3a4FZmQ7Oh3IRzlQZYOzt1RKavKjh
	 wPQ4ohyAPy1a2lGhlCkvDtzPx9t/h2G34zxSeb644sSuB08hbjkJSzphuxPgg9Dh1l
	 NNW5NEy+ax01TEMNNXrv+ULJMtTHltkwS8guKsFwV8hgH+3xz0RbF99B5+TdhdPA21
	 b1pq/VnXWE5Hg==
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
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/3] PCI: dwc: Fix msg_atu_index assignment
Date: Thu, 22 Jan 2026 15:54:12 +0100
Message-ID: <20260122145411.453291-4-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422; i=cassel@kernel.org; h=from:subject; bh=+1Q7gO3prk+8BEJeWfMGZVuTfWAJGRfH9gKD0e7Odgc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKLrIRjbvKuEeu4JMDUIFWbPD9zqUJmpsW9WemHJ0p83 v3TiH1jRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACbyeSsjw96YCAbtntkHFjKm 2zrl3v/MoJX77tccl/37bsxiYPGO8GNkOJP2cy276oZ7tQK9ct/nnGpsYZinU6UyK0dH6OHmP6e X8gIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211245-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,google.com,nxp.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: C29AD690A3
X-Rspamd-Action: no action

When dw_pcie_iatu_setup() configures outbound address translation
for both type PCIE_ATU_TYPE_MEM and PCIE_ATU_TYPE_IO, the iatu index
to use is incremented before calling dw_pcie_prog_outbound_atu().

However, for msg_atu_index the index is not incremented before use,
causing the iATU index to be the same as the last configured iatu
index, which means that it will incorrectly use the same iatu index
that is already in use, breaking outbound address translation.

Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ab17549af518..cca5fc886409 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -982,7 +982,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
-	pp->msg_atu_index = i;
+	pp->msg_atu_index = ++i;
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {

base-commit: e9a5415adb209f86a05e55b850127ada82e070f1
-- 
2.52.0


