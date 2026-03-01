Return-Path: <stable+bounces-221468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFVaACGWo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:28:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E961CAACD
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AEB630269C3
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02780284693;
	Sun,  1 Mar 2026 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uw6gADA+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B92727EB;
	Sun,  1 Mar 2026 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328339; cv=none; b=WUKj9UHoYOfe44EEAhZ1pkiRiOq4E0DhMKGhzA/AXrU8xdY61fUfYR6Kf6iCMVmN+4v1SaIj9QGbavRlWATh+D980OBqgRNEjhGK8IRIu4t6uH5aB8Pm0pkvMAfb4W6rHKsMShZjLRpAevwFwdWxIdEOvlLz2+9tsPNl/RuEQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328339; c=relaxed/simple;
	bh=+HdMuB34N0LsxYZj8bVKBorISNoOvGunSXYL0NbAFDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TO8BWZoaLIXDr2ZFScJMFVmR3nUORPbQDJ2eaW3afB+JqUprlzuPmEnB3ALwuUKqY6uyQ/uuzJHXFOu1IdMb7FHOxDG7nPZ7zWqwCcbcibgs6e97gnaeDtV2MfoHrkrpu2o5Kgw5w6w5R2yAHK4Wpi2fPU7cil09DlTaSslpYYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uw6gADA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94CBC19421;
	Sun,  1 Mar 2026 01:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328339;
	bh=+HdMuB34N0LsxYZj8bVKBorISNoOvGunSXYL0NbAFDc=;
	h=From:To:Cc:Subject:Date:From;
	b=uw6gADA+u2VqB7GjYxf2h78NZifuUx++ne9SpDa9wBzBycNN8LOH2QLxsE0lNXJfZ
	 u3MAyW2oWkYOOVMEnuRkfH/r+opsptnhAxEqreuq/lEM6TzONyk0Nmhicn7wvcDCgq
	 GPw6GWNvNjQBgtjEZ4o3tcSQFkUOX+vj+tP3OmMLAk2PEEy+s4aZ3Ota+O+0p5af+H
	 wAzkVXbtrRY6rM5ByMtk1IdVTOTlic1uYqIdbTtBK5r1oajyhTCkPbRcTzAJ93qdus
	 EoTdsvqqB9e1A1wFHI9p8qXSdxAVmLhKqh4Z/JsPknUJQSfdvxz6PDJvtGzQgN8fZ/
	 Jip9/8yy98eRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cassel@kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <zhanghuabing@ecosda.com>,
	Frank Li <Frank.Li@nxp.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "PCI: dwc: Fix msg_atu_index assignment" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:25:37 -0500
Message-ID: <20260301012537.1682778-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-221468-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,rock-chips.com:email,nxp.com:email,orcam.me.uk:email]
X-Rspamd-Queue-Id: 53E961CAACD
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 58fbf08935d9c4396417e5887df89a4e681fa7e3 Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Tue, 27 Jan 2026 16:10:39 +0100
Subject: [PATCH] PCI: dwc: Fix msg_atu_index assignment

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
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index b3d6a474fd16a..d7f57d77bdf55 100644
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
2.51.0





