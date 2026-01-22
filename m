Return-Path: <stable+bounces-211319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM9qHM6kcmmMoQAAu9opvQ
	(envelope-from <stable+bounces-211319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 23:29:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6456E284
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 23:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F7B03007B83
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 22:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECF639C651;
	Thu, 22 Jan 2026 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MU16GE2N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4629938B98C;
	Thu, 22 Jan 2026 22:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769120968; cv=none; b=gZfY91au4r4y2lLj8iIWzQexyFKISMN7dfnBOl354tF2813nUXt4DVQEozjngb+9jDbAgm4G2mk/m38Sq6HhNSCPTFqWHCTTeeiAhAT0Gu+s0dHvExNHECnaqtp85TTNseKfSBCxBWNFDqmyQulqGO0aeQp3fb+78J7ECQTvHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769120968; c=relaxed/simple;
	bh=Yxl5fH6pZiKvvdH6XLY3IbMNLdfPd0tP9z3ZB2J7L0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alf/xdrBEmCacIsSZAUseK0A9d1GP3wkHRP4Xy0mp8CL5sXhYbVfLHkwV3lJxqJ8ZW1K0yMuqPklIzBrt/nsurrsWQCuSlsU3E9BTpqxDxRGnaC5vS3liSwZYMpSIfh4PhDbi42G9RFlbCEjZhXcWSQYYawgQshr6a5OdH9IqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MU16GE2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBB4C116C6;
	Thu, 22 Jan 2026 22:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769120966;
	bh=Yxl5fH6pZiKvvdH6XLY3IbMNLdfPd0tP9z3ZB2J7L0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MU16GE2Nj2oboA5zTD19wgMw77bBLr2NlK9TpSvp02WGqmbIjs9NGmQ0ZwptRCWLW
	 ZQYTc66OcOxhH4OSRQOi1wVrUsVAVT0qfbdVpy15Iv8YfThT0QSkQJSEGA51ODZO/e
	 2d37NkTVeFlGPKlfeTz9YFYi+3FjdER9SS3ME0y3fJVBGAwqVfZ8Q8v+7K44qrmn/O
	 iNYVAE/k6B4OZbgWxpDQ1jSGTzNLbRdxLhOLdPTPRDCk7byCQITeGFb/bARd+4Y+uI
	 hFn0B+4JW4rpk3iJUhMNyIjxQBJ9DOU9QU+gdXhTM9s2djPBUc0jsPeATrKgAyq87J
	 k7MFKOgKZRNnw==
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
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 1/4] PCI: dwc: Fix msg_atu_index assignment
Date: Thu, 22 Jan 2026 23:29:15 +0100
Message-ID: <20260122222914.523238-7-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122222914.523238-6-cassel@kernel.org>
References: <20260122222914.523238-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=cassel@kernel.org; h=from:subject; bh=Yxl5fH6pZiKvvdH6XLY3IbMNLdfPd0tP9z3ZB2J7L0Q=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKLluxqtU5iedTLXnrqWc0uS4XJAlILf7l8dE/7YbbX5 uTfM5PedpSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAi9nsZGTrnXinjt1xutMcq cwvPEa/UTaHGVi9urFqhVjlHzMFj2hlGhmURl84Jx4XzB9k5c2guZ3jibRD+0XvSoZVVfXej3+k s5AQA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211319-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,google.com,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D6456E284
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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
-- 
2.52.0


