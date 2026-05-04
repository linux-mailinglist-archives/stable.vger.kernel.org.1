Return-Path: <stable+bounces-242831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFwgE4Yc+GnCpwIAu9opvQ
	(envelope-from <stable+bounces-242831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 06:11:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FFE4B84EC
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 06:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52FA9301651D
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 04:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CC5244692;
	Mon,  4 May 2026 04:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGg6XNjj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2835DCA6F
	for <stable@vger.kernel.org>; Mon,  4 May 2026 04:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777867881; cv=none; b=Q2gmdoC75PY51PlwSTQpaxugxWOsRLA69iYnSNgL8WESGHtf/DFNFCM9KvUFLRyefcJxUTBHrNqvAo/fMS09+7b1BhElEH0DMXOnSveXV0i8PXohDyQG/5guFcMg3wfAsMr59S4jtJqGl4rw5Ji20419s1ydkIh4919vQl7rABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777867881; c=relaxed/simple;
	bh=gQ4zNok8QPUHos3CiNt+rpKdmym5vX5I0nC48fJVGb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHZzQSEQf3AYBJgrbakDv15n/QUbcNXBDRVwqFVQkpz7Yq4Hk12CdxVLuzgGEN4plcPIsAHaUxM3nemJ8SXKszzaEKBfB3LrP18TSKZJzrbEwYfwnE+GSNlWsdH9/M9Wv08Scmb+NjTaJx56AhKMK8r7FxGmzvjGGVqLgMqaj50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGg6XNjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC7FC2BCF6;
	Mon,  4 May 2026 04:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777867880;
	bh=gQ4zNok8QPUHos3CiNt+rpKdmym5vX5I0nC48fJVGb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGg6XNjjVehhVOZhPKHovNdAksfERpQTsKX+o8jQhfijZKyqHKdCnMKPShqs33m4B
	 +3jG1hiG5I3oS67JLn5Ur+0qjq3J/CkGh6npmItfau0HHzY4Kl6sYsxBPTucj/0CqJ
	 /RrMGpeHzP/f9G6eV++ZRA8Pp0frDf1KnfCgXT9/hBoGEy48M2hrDy8Osr71mcm+El
	 Ie6Xqm24CV743RDcMspuZkFcPSGyN814qzekWCvEt0dJx+WRG/8QXsYjtBRPLZ8PzI
	 XM8Ng00rm3AuHF6PwY8SZGfRQC4uuTsg/nRtswabkKv+kpBwCK030hqLYBFjbwmRh+
	 TgEqp8vz+fXYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Yiming Qian <yimingqian591@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: qrtr: ns: Limit the maximum server registration per node
Date: Mon,  4 May 2026 00:11:15 -0400
Message-ID: <20260504041115.1425803-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050102-deeply-shush-8321@gregkh>
References: <2026050102-deeply-shush-8321@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A3FFE4B84EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242831-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,msgid.link:url]

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
index 654a3cc0d3479..f6534840c4236 100644
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
@@ -226,6 +232,17 @@ static struct qrtr_server *server_add(unsigned int service,
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
@@ -235,10 +252,6 @@ static struct qrtr_server *server_add(unsigned int service,
 	srv->node = node_id;
 	srv->port = port;
 
-	node = node_get(node_id);
-	if (!node)
-		goto err;
-
 	/* Delete the old server on the same port */
 	old = xa_store(&node->servers, port, srv, GFP_KERNEL);
 	if (old) {
@@ -249,6 +262,8 @@ static struct qrtr_server *server_add(unsigned int service,
 		} else {
 			kfree(old);
 		}
+	} else {
+		node->server_count++;
 	}
 
 	trace_qrtr_ns_server_add(srv->service, srv->instance,
@@ -289,6 +304,7 @@ static int server_del(struct qrtr_node *node, unsigned int port, bool bcast)
 	}
 
 	kfree(srv);
+	node->server_count--;
 
 	return 0;
 }
@@ -667,7 +683,7 @@ static void qrtr_ns_worker(struct work_struct *work)
 		}
 
 		if (ret < 0)
-			pr_err("failed while handling packet from %d:%d",
+			pr_err_ratelimited("failed while handling packet from %d:%d",
 			       sq.sq_node, sq.sq_port);
 	}
 
-- 
2.53.0


