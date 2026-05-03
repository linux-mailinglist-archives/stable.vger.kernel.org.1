Return-Path: <stable+bounces-242814-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA1HGpGe92nmjgIAu9opvQ
	(envelope-from <stable+bounces-242814-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 21:14:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9217F4B7146
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 21:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C643B300878A
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 19:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA8734846A;
	Sun,  3 May 2026 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVyBautY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7A82BDC29
	for <stable@vger.kernel.org>; Sun,  3 May 2026 19:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777835658; cv=none; b=D00CIRyeFgzxpyiUi0cUYfiNTsGoqVdrMHWbe0f0ovZAazlhmNbJLmucAPliiBWOWNwxcBVWyTnyFKtlZLyQQR8hFd76/cD/KJXC36INHy8Ka3wkSGCAKQYhkbT5L/PI04ivOqEGPLyUkjC/nLaAsYEp3+Vb5T1oMDziMnO/hPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777835658; c=relaxed/simple;
	bh=gW0czXoY+lMhFLZ8xa+BDABQoOc2gfYhNVVNvbxihmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEZhn8RrYR9gQvTaSSFGmcCN4ftP3tr01QZMTL0r200W7jnjEqlusUTRlJzxI1C4yUPtgVJvKMc6Lz0d9710/EDAu9MapWnwFtgT/4M/y8KhnuWEUN7jN//NRqvdHtWBT346owkUJGCxrbrrQgmDxxxCpPLN5uQkcgn9/a3hV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVyBautY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBB8C2BCB4;
	Sun,  3 May 2026 19:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777835657;
	bh=gW0czXoY+lMhFLZ8xa+BDABQoOc2gfYhNVVNvbxihmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GVyBautYVAu/Q29t4SoEwdhq25ne7RN3KQu8GJ56//SBTMPEJCH+XEOZJPOHsVQ43
	 NMrCAtaZlU90FZE8N9AabQHuRzP6hvD9g/uPxN0fB2aRNK14J3PXhpW88veUHYWAAl
	 ipj2ru5HW4Kue+V0CwP0azrL/QpeKiQU+hx2OOG7oilum0nMw8wiHD0LPN7R0coBMq
	 d7X0HZBAOQLes+XYCzWsKHRymAWEhbs8/tavLDqW4oXExd6UpxBpTsrMTTic/s238r
	 NoDWE37yBZYwMHSC8JUTr61jm+7T/Qu9OhCBdTOyepu4biM8C5YssTwDyjIgpXF2hx
	 4cXs0y9DKRMiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Yiming Qian <yimingqian591@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net: qrtr: ns: Limit the maximum server registration per node
Date: Sun,  3 May 2026 15:14:12 -0400
Message-ID: <20260503191412.1286176-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050101-unreal-tribute-c694@gregkh>
References: <2026050101-unreal-tribute-c694@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9217F4B7146
X-Rspamd-Action: no action
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
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242814-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

[ Upstream commit d5ee2ff98322337951c56398e79d51815acbf955 ]

Current code does no bound checking on the number of servers added per
node. A malicious client can flood NEW_SERVER messages and exhaust memory.

Fix this issue by limiting the maximum number of server registrations to
256 per node. If the NEW_SERVER message is received for an old port, then
don't restrict it as it will get replaced. While at it, also rate limit
the error messages in the failure path of qrtr_ns_worker().

Note that the limit of 256 is chosen based on the current platform
requirements. If requirement changes in the future, this limit can be
increased.

Cc: stable@vger.kernel.org
Fixes: 0c2204a4ad71 ("net: qrtr: Migrate nameservice to kernel from userspace")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Link: https://patch.msgid.link/20260409-qrtr-fix-v3-1-00a8a5ff2b51@oss.qualcomm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/qrtr/ns.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 3de9350cbf307..9166c26349259 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -67,8 +67,14 @@ struct qrtr_server {
 struct qrtr_node {
 	unsigned int id;
 	struct xarray servers;
+	u32 server_count;
 };
 
+/* Max server limit is chosen based on the current platform requirements. If the
+ * requirement changes in the future, this value can be increased.
+ */
+#define QRTR_NS_MAX_SERVERS 256
+
 static struct qrtr_node *node_get(unsigned int node_id)
 {
 	struct qrtr_node *node;
@@ -229,6 +235,17 @@ static struct qrtr_server *server_add(unsigned int service,
 	if (!service || !port)
 		return NULL;
 
+	node = node_get(node_id);
+	if (!node)
+		return NULL;
+
+	/* Make sure the new servers per port are capped at the maximum value */
+	old = xa_load(&node->servers, port);
+	if (!old && node->server_count >= QRTR_NS_MAX_SERVERS) {
+		pr_err_ratelimited("QRTR client node %u exceeds max server limit!\n", node_id);
+		return NULL;
+	}
+
 	srv = kzalloc(sizeof(*srv), GFP_KERNEL);
 	if (!srv)
 		return NULL;
@@ -238,10 +255,6 @@ static struct qrtr_server *server_add(unsigned int service,
 	srv->node = node_id;
 	srv->port = port;
 
-	node = node_get(node_id);
-	if (!node)
-		goto err;
-
 	/* Delete the old server on the same port */
 	old = xa_store(&node->servers, port, srv, GFP_KERNEL);
 	if (old) {
@@ -252,6 +265,8 @@ static struct qrtr_server *server_add(unsigned int service,
 		} else {
 			kfree(old);
 		}
+	} else {
+		node->server_count++;
 	}
 
 	trace_qrtr_ns_server_add(srv->service, srv->instance,
@@ -292,6 +307,7 @@ static int server_del(struct qrtr_node *node, unsigned int port, bool bcast)
 	}
 
 	kfree(srv);
+	node->server_count--;
 
 	return 0;
 }
@@ -670,7 +686,7 @@ static void qrtr_ns_worker(struct work_struct *work)
 		}
 
 		if (ret < 0)
-			pr_err("failed while handling packet from %d:%d",
+			pr_err_ratelimited("failed while handling packet from %d:%d",
 			       sq.sq_node, sq.sq_port);
 	}
 
-- 
2.53.0


