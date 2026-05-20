Return-Path: <stable+bounces-251339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAZpAFkXDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:19:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B292599709
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 052F6320CE41
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFD536A376;
	Wed, 20 May 2026 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RMSiPUyp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F4366075;
	Wed, 20 May 2026 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297723; cv=none; b=QQLQ/u2/z+qV3xu0EXkcvrvqxL4Cnsq0RFHpAJZVrsjZdfMOFcVBQCrI5mmTcbvu7TWDOHMmrfRzb3L2k6YYdLq97gcjAFAptZA2N5CxNQkRjcIfmsZn/RZLGLbzkMOob5FZQvlCrNkF9p6ryVu1lmDxzKPSfdVb2ihzamK3dwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297723; c=relaxed/simple;
	bh=RC66k9Telz+lLovEjBHJiWJohi1aH1OSoxTEzrI7R9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+fG/TytNdam7phbkASHUTi5UEFFKqhhv/FmtrBZye+ouKihSCEaERiQ1XbQfHf5yydc75c2EOIftFva0VJgrPb7bM3fI8o5B79EvuOvly5I8AbnaPmafAwjYmepiyOi5oUNfOlJPJK5JoAYESQU7Vwcp35jWB31wQoo6RZt5qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RMSiPUyp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC361F000E9;
	Wed, 20 May 2026 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297722;
	bh=RzkEZ6pSt4naS3I/IOqSetfC0x0+Dr7TjejzpchNQQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RMSiPUypzRwVG0YyEVdElw5BD//brXSZoCB0Xkdwe+psMFLb/r+90mLYrTHg1/F2H
	 n4HRxRGuNXW3FR827CXggIkDKhUEO/OgTat+Bi9XobVGrBas2FjWnTto+Gjp8wEQiS
	 CkLRMhynEKZoqHjH+tHw05kY1TRP2JVSVlBOcqHY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mohsin Bashir <hmohsin@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 140/957] eth: fbnic: Use wake instead of start
Date: Wed, 20 May 2026 18:10:23 +0200
Message-ID: <20260520162137.591156082@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251339-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6B292599709
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohsin Bashir <hmohsin@meta.com>

[ Upstream commit 12ff2a4aee6c86746623d5aed24389dbf6dffded ]

fbnic_up() calls netif_tx_start_all_queues(), which only clears
__QUEUE_STATE_DRV_XOFF.  If qdisc backlog has accumulated on any TX
queue before the reconfiguration (e.g. ring resize via ethtool -G),
start does not call __netif_schedule() to kick the qdisc, so the
pending backlog is never drained and the queue stalls.

Switch to netif_tx_wake_all_queues(), which clears DRV_XOFF and also
calls __netif_schedule() on every queue, ensuring any backlog that
built up before the down/up cycle is promptly dequeued.

Fixes: bc6107771bb4 ("eth: fbnic: Allocate a netdevice and napi vectors with queues")
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
Link: https://patch.msgid.link/20260408002415.2963915-1-mohsin.bashr@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 698b8a85afb31..99b7c0718e80e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -139,7 +139,7 @@ void fbnic_up(struct fbnic_net *fbn)
 
 	/* Enable Tx/Rx processing */
 	fbnic_napi_enable(fbn);
-	netif_tx_start_all_queues(fbn->netdev);
+	netif_tx_wake_all_queues(fbn->netdev);
 
 	fbnic_service_task_start(fbn);
 }
-- 
2.53.0




