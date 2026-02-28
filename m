Return-Path: <stable+bounces-220822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH+hGIFDo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:35:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D03251C7281
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A14630AF87B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662FA414BFB;
	Sat, 28 Feb 2026 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/8dahUg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279DE414BFE;
	Sat, 28 Feb 2026 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300708; cv=none; b=Y4WpGkb/oaoz9t9gsMYLMIAf1yH7MF0ntiU9TZpofAly8GeCr2h3k3ntf5/7B4XXBCSYBwFAcA71K8GXRD/nM0m8WTjriQeJVjaRvybJUxHAS3PnPV7jZk6PC/7mfG12iVLe8OCfKdb/DEYWL9qF79NNhTxg87wtLHhmZK2d29M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300708; c=relaxed/simple;
	bh=0okS24yR1p0q9G0akiBZoBKuecrrZL4S4vPF8LVJtuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ax0IIQGdkIrpzQDzRl1Pm+R4z5EEWC9a2V5uyxObKrcQFYAboyJNXTSnYvYtAJKb6hyxLGNOjI/ffUctookGkhWxSQWOaTMIrdBjdlWTvr1kO+Y3BNwRJt7PNdJuo+QKiqrWNcVk+Qb8hBSxRkUSbbU5AZzxZO5WVRILbb+nnE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/8dahUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0308DC19423;
	Sat, 28 Feb 2026 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300708;
	bh=0okS24yR1p0q9G0akiBZoBKuecrrZL4S4vPF8LVJtuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/8dahUgb2Bv3+HqdTNo8x3GjGgoG+d9Q45IB0R/sHkWDT+ONSworfbTprfpm0qPv
	 PjnkY/R7KwzU6jjdEbC6TI6LhIn+30PonjLRdqOTCfJzz4+XKvW/RL3hGLN45oSRrq
	 1qt5nqleypQ+FyZ5WAL9pkvzDA/kFRqu+oZB75BtQZ7KwdOhLHvdBC8BYAFOH8ACpm
	 fWBTXj9ofzYdrumAV41/R9EgcpJ0ilDFcLzvieo6yIQJzuT7Kqli7NXktkPVh5ByDP
	 fsM0cD2rnRbVdj3yaPyjWfExgxR2ffOx1S7GY2sSDvjn4cz9tLKFNRGy0ntYye51y8
	 tzVT/AQRuFybg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <zhanghuabing@ecosda.com>,
	Frank Li <Frank.Li@nxp.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 743/844] PCI: dwc: Fix msg_atu_index assignment
Date: Sat, 28 Feb 2026 12:30:56 -0500
Message-ID: <20260228173244.1509663-744-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220822-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,msgid.link:url,rock-chips.com:email,ecosda.com:email]
X-Rspamd-Queue-Id: D03251C7281
X-Rspamd-Action: no action

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit 58fbf08935d9c4396417e5887df89a4e681fa7e3 ]

When dw_pcie_iatu_setup() configures outbound address translation for both
type PCIE_ATU_TYPE_MEM and PCIE_ATU_TYPE_IO, the iATU index to use is
incremented before calling dw_pcie_prog_outbound_atu().

However for msg_atu_index, the index is not incremented before use,
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
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hans Zhang <zhanghuabing@ecosda.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260127151038.1484881-6-cassel@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index af2eeed55f9e5..53125b97530b6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -946,7 +946,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
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
2.51.0


