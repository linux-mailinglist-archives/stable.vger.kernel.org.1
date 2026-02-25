Return-Path: <stable+bounces-218826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A94DJNWnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-218826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5992919034C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76FCA30AAC89
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456EB26561A;
	Wed, 25 Feb 2026 01:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FQjXyYKb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EC11E2834;
	Wed, 25 Feb 2026 01:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983707; cv=none; b=rh1dTFPeyztHNj8SdhvGEojBoRhuY8b4u05ZKgtOLG3S4XS8lXSX+9U7qPuiZwTpHfAyBnQci5cxJL8OnLNPMtUL/w+Egf03GO9o7bWO/R5LBC70CnRR7Unzb/+z4+w7oa3bByBIsj3hCn1A9JbOAYnYcWVxAabrozfbyIL1lo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983707; c=relaxed/simple;
	bh=H3Es8cx2qoR/XkfVBxMpMqIMsTKZYtUI7ty9DLj5dSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sr4qYjWQWjePFy1H/s1GX2L1tD+yBf75wMmCjvZf5P2zdDswhVQSxfJMv52nRsXBadRk4PoNcYHM15XK1sen8rwaL5ZhhQkwxHM6+cYXkcW0y2DtnOMgVkJ/VN/9Bw8Cwwa00OPlUTVhxkUUgwkBPnuEI2d20R5i68Hwn0BTGmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FQjXyYKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F2BC116D0;
	Wed, 25 Feb 2026 01:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983706;
	bh=H3Es8cx2qoR/XkfVBxMpMqIMsTKZYtUI7ty9DLj5dSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FQjXyYKbSGjrzOJH1n2Ts9Zvchm+IDu8rjp+iC+s7e1MAWMaiDfQMLbziWgL7MlWG
	 Y8j0kWUI1atA7OIxldRWzmOBOmsW/SulT/UsI/qpArJpCdLY2LWxHSpiju+Ghzn/dC
	 JmQiF+4W/ZSLsKN/3vzjpVx36+xzGuJTeM6TuoWQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Koichiro Den <den@valinux.co.jp>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 750/781] PCI: dwc: ep: Always clear IB maps on BAR update
Date: Tue, 24 Feb 2026 17:24:19 -0800
Message-ID: <20260225012418.116379904@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218826-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,valinux.co.jp:email]
X-Rspamd-Queue-Id: 5992919034C
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Koichiro Den <den@valinux.co.jp>

[ Upstream commit 8c746e22096579897d1f8f74dbb6b17a6862fb6d ]

dw_pcie_ep_set_bar() currently tears down existing inbound mappings only
when either the previous or the new struct pci_epf_bar uses submaps
(num_submap != 0). If both the old and new mappings are BAR Match Mode,
reprogramming the same ATU index is sufficient, so no explicit teardown
was needed.

However, some callers may reuse the same struct pci_epf_bar instance and
update it in place before calling set_bar() again. In that case
ep_func->epf_bar[bar] and the passed-in epf_bar can point to the same
object, so we cannot reliably distinguish BAR Match Mode -> BAR Match Mode
from Address Match Mode -> BAR Match Mode. As a result, the conditional
teardown based on num_submap becomes unreliable and existing inbound maps
may be left active.

Call dw_pcie_ep_clear_ib_maps() unconditionally before reprogramming the
BAR so that in-place updates are handled correctly.

This introduces a behavioral change in a corner case: if a BAR
reprogramming attempt fails (especially for the long-standing BAR Match
Mode -> BAR Match Mode update case), the previously programmed inbound
mapping will already have been torn down. This should be acceptable, since
the caller observes the error and should not use the BAR for any real
transactions in that case.

While at it, document that the existing update parameter check is
best-effort for in-place updates.

Fixes: cc839bef7727 ("PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match Mode iATU")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Link: https://patch.msgid.link/20260202145407.503348-3-den@valinux.co.jp
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 6d3c35dd280f3..59fd6ebf01489 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -518,6 +518,12 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		/*
 		 * We can only dynamically change a BAR if the new BAR size and
 		 * BAR flags do not differ from the existing configuration.
+		 *
+		 * Note: this safety check only works when the caller uses
+		 * a new struct pci_epf_bar in the second set_bar() call.
+		 * If the same instance is updated in place and passed in,
+		 * we cannot reliably detect invalid barno/size/flags
+		 * changes here.
 		 */
 		if (ep_func->epf_bar[bar]->barno != bar ||
 		    ep_func->epf_bar[bar]->size != size ||
@@ -526,10 +532,12 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 		/*
 		 * When dynamically changing a BAR, tear down any existing
-		 * mappings before re-programming.
+		 * mappings before re-programming. This is redundant when
+		 * both the old and new mappings are BAR Match Mode, but
+		 * required to handle in-place updates and match-mode
+		 * changes reliably.
 		 */
-		if (ep_func->epf_bar[bar]->num_submap || epf_bar->num_submap)
-			dw_pcie_ep_clear_ib_maps(ep, func_no, bar);
+		dw_pcie_ep_clear_ib_maps(ep, func_no, bar);
 
 		/*
 		 * When dynamically changing a BAR, skip writing the BAR reg, as
-- 
2.51.0




