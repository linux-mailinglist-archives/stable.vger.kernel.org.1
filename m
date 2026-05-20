Return-Path: <stable+bounces-250261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNmVJ43lDWpz4gUAu9opvQ
	(envelope-from <stable+bounces-250261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:47:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 284135926D9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43A8530AB9DE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428823EF0A1;
	Wed, 20 May 2026 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tKg33129"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C416B371056;
	Wed, 20 May 2026 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294950; cv=none; b=R2IVWZCDs1G2qnTdCI+TEL/f/H+W7ONJmPFulrWQKcxDrI/HZNrPVBU2RmxkFc5UlZGHOVS1ep81nx9B12gu+mYql6JVh1nPce0IOI4maJeuOsucBrst+rQOrgN8vpAh+4OQ9LWGCdzdvXeYfbfjcgXg2/G+HRM5XxEHaGHHGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294950; c=relaxed/simple;
	bh=bWDcgmYb9qD6eZ/5aSCmUIqQT0inRaXQ1KWaUuU4lO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9Mh0xEjhpXf9TeR2H2Wpaw/oQAE6/heJ+6Xe82Z2kSsYLxSid727rUK07evVNy8b1c90FGtO7uYyEN2WC6Y/i2zngYtElPn9xbWZ+8Bbbufi0CDMar+6d690CH/r2iACcK6ha0TNsj0UfDCx3dyQDe/gxQwIJeiQmzccF9gjGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tKg33129; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739221F000E9;
	Wed, 20 May 2026 16:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294948;
	bh=bZ0RwZY4RJ+IjcKBnWPCcuThh1hwkhbhYJjA/4PSrOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tKg33129jwWGZvPKLJtsIheQCX/KnJHYul2SsuFfjuP6Xq3QMc0CuBuG2E2citkTf
	 jkVT2h+EEL1qtBVmsQ4jPrN2Ju6LmEMNi4+CU/hh7mIhVJ9GJPB1w6uiE0qSWoiUlg
	 QZbJ0wdPPetv1ZS1oEg4avVJ0F4uoEN3x9LMzmOU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Koichiro Den <den@valinux.co.jp>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0233/1146] PCI: endpoint: pci-epf-vntb: Fix MSI doorbell IRQ unwind
Date: Wed, 20 May 2026 18:08:03 +0200
Message-ID: <20260520162153.522307420@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250261-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,nxp.com:email,msgid.link:url,valinux.co.jp:email]
X-Rspamd-Queue-Id: 284135926D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Koichiro Den <den@valinux.co.jp>

[ Upstream commit cc04f2bfb9dae60b6e34d6bff75c26d4ec3237ce ]

epf_ntb_db_bar_init_msi_doorbell() requests ntb->db_count doorbell IRQs
and then performs additional MSI doorbell setup that may still fail.
The error path unwinds the requested IRQs, but it uses a loop variable
that is reused later in the function. When a later step fails, the
unwind can run with an unexpected index value and leave some IRQs
requested.

Track the number of successfully requested IRQs separately and use that
counter for the unwind so all previously requested IRQs are freed on
failure.

Fixes: dc693d606644 ("PCI: endpoint: pci-epf-vntb: Add MSI doorbell support")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Link: https://patch.msgid.link/20260217063856.3759713-2-den@valinux.co.jp
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 65f5bbf28480d..c9c7b50587dd2 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -527,20 +527,20 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 	struct msi_msg *msg;
 	size_t sz;
 	int ret;
-	int i;
+	int i, req;
 
 	ret = pci_epf_alloc_doorbell(epf,  ntb->db_count);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < ntb->db_count; i++) {
-		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
+	for (req = 0; req < ntb->db_count; req++) {
+		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
 				  0, "pci_epf_vntb_db", ntb);
 
 		if (ret) {
 			dev_err(&epf->dev,
 				"Failed to request doorbell IRQ: %d\n",
-				epf->db_msg[i].virq);
+				epf->db_msg[req].virq);
 			goto err_free_irq;
 		}
 	}
@@ -598,8 +598,8 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 	return 0;
 
 err_free_irq:
-	for (i--; i >= 0; i--)
-		free_irq(epf->db_msg[i].virq, ntb);
+	for (req--; req >= 0; req--)
+		free_irq(epf->db_msg[req].virq, ntb);
 
 	pci_epf_free_doorbell(ntb->epf);
 	return ret;
-- 
2.53.0




