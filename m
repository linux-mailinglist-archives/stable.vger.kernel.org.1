Return-Path: <stable+bounces-236578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OmlH5wb3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:36:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B703EF5D5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C5D430A163C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2074726CE32;
	Mon, 13 Apr 2026 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bk5sT5u3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84BE2EBB8C;
	Mon, 13 Apr 2026 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097267; cv=none; b=Amoaac4mbnJFXwPBTcxqOfK11LaGI86nGWLz8eal+j65VIoVAAL+57oB53yXS5IBolXPcshHXxJkE9RJioaIibDfXN3+AVQ5xGJTT1Xt4vMg1SPIRixnBkWC0PyKpdIoKCRYJrRu6EQM0lUCxeGtBEOfNzTbEj8U5R4wCLyOA/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097267; c=relaxed/simple;
	bh=VB3KFvYicXrSr0gZk+cUF/dyWAuN1SMaEiaF9MWCcJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNNrEiTRbuuTCgwfpOICGTtkvrHCL6oHvoahIw14cp49V0BMTSdRu7YXAJVoVyF/UVuyUcND9t4DYbXjul5m4ut0d98KXr35GfTwG4D0r/Zr/F7JzghYt3u79N389A2f18D0GUBrDJUJphuO3EOm+S6bM8kMT7JVOfFC3rpcbWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bk5sT5u3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB4FC2BCAF;
	Mon, 13 Apr 2026 16:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097267;
	bh=VB3KFvYicXrSr0gZk+cUF/dyWAuN1SMaEiaF9MWCcJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bk5sT5u3ipJXhcIZPY7U9wfBi86ak09Z8GUfE271zGdnU+LMUTxVx/FN+G/5wdm7+
	 g8Zq3Un9G+siAkpylBxwBGQfMBPYtSzhgzb0w+mj3KHhm2EsGN4aXcqKwhTrdOOBdg
	 JAkpXyde0WKtwU5PEh1sD75UB1yReE2Rm4B4MH0U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junrui Luo <moonafterrain@outlook.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 070/570] dpaa2-switch: Fix interrupt storm after receiving bad if_id in IRQ handler
Date: Mon, 13 Apr 2026 17:53:21 +0200
Message-ID: <20260413155833.065505206@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,roeck-us.net,nxp.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-236578-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,roeck-us.net:email,outlook.com:email]
X-Rspamd-Queue-Id: 85B703EF5D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 74badb9c20b1a9c02a95c735c6d3cd6121679c93 ]

Commit 31a7a0bbeb00 ("dpaa2-switch: add bounds check for if_id in IRQ
handler") introduces a range check for if_id to avoid an out-of-bounds
access. If an out-of-bounds if_id is detected, the interrupt status is
not cleared. This may result in an interrupt storm.

Clear the interrupt status after detecting an out-of-bounds if_id to avoid
the problem.

Found by an experimental AI code review agent at Google.

Fixes: 31a7a0bbeb00 ("dpaa2-switch: add bounds check for if_id in IRQ handler")
Cc: Junrui Luo <moonafterrain@outlook.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://patch.msgid.link/20260227055812.1777915-1-linux@roeck-us.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 9713d04238138..3cc844a61cb88 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1532,7 +1532,7 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 	if_id = (status & 0xFFFF0000) >> 16;
 	if (if_id >= ethsw->sw_attr.num_ifs) {
 		dev_err(dev, "Invalid if_id %d in IRQ status\n", if_id);
-		goto out;
+		goto out_clear;
 	}
 	port_priv = ethsw->ports[if_id];
 
@@ -1555,6 +1555,7 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 		rtnl_unlock();
 	}
 
+out_clear:
 	err = dpsw_clear_irq_status(ethsw->mc_io, 0, ethsw->dpsw_handle,
 				    DPSW_IRQ_INDEX_IF, status);
 	if (err)
-- 
2.51.0




