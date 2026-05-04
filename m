Return-Path: <stable+bounces-242838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILqAO2As+Gm/rAIAu9opvQ
	(envelope-from <stable+bounces-242838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 07:19:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 524894B87A8
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 07:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E4993007AC7
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 05:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822962264D3;
	Mon,  4 May 2026 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugGZUbg6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C0199931
	for <stable@vger.kernel.org>; Mon,  4 May 2026 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777871965; cv=none; b=VlUVyvGMTLTsnSI7gmG/frNl9an3Srb97CTqTE5GKW+oIHlE/U+KprO+eFMtq8Dlnhj5pLQu/U2y929zXxDEAk8qpOoEomixV+Dq9vmuEsNIM1LgDfi7uXqFwNcU/0KPdmo64mO9NVgV2YJ+M+kns3dBfG3sYLnGTnOfY8eI18M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777871965; c=relaxed/simple;
	bh=04sOCgauFm8q86BhgEY9t6oyx0s/X3yghawyobBSP6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzN+8xW32cPAxh0mcEQTJJWiGZ9TslSN2avYVcpSWa/Dj5//JUxS7TpigZQM7ySKanAJIgPspaP13fHKUxUKRt3rG1oYJlfYT77lCpU3BTImAXoVb2D0LzVh6Fg4Hd79nDmFzkQfs3AOtrwZFXMoRqB3lRZiT/usFT+6451jN7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugGZUbg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C43FC2BCB8;
	Mon,  4 May 2026 05:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777871965;
	bh=04sOCgauFm8q86BhgEY9t6oyx0s/X3yghawyobBSP6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ugGZUbg6Kd8Gm4jnxjzSPyKP+P3V9MEefHtQuLpz8fmuSM3qHPyhMYONylTFMih7+
	 RhgvcsGvmQ6omh7+YMSCAyCb/qE5ip3mkop09MJqUJtB67s9CFTpg4yk1VJvUvfpIG
	 Cdk8tYN5x+Xua7iOMozCooRLQaCyIMC/YWLYrSeLYkzp+WfUxuKSFhtse9I9xZzrdG
	 19Tl1IbzY8hCya7V33AoeN0DGb9H8MaWJgWulYCbc+F//X2YG3eF2psShhJu8vubfF
	 8xJpgvErHPN8lWcvRzIsMFhIu8Zohwg7i7RV/byY+CNkBqBibFi+1PthvyW3gX92UI
	 TxrKrsqj1YhWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vignesh Viswanathan <quic_viswanat@quicinc.com>,
	Chris Lew <quic_clew@quicinc.com>,
	Simon Horman <simon.horman@corigine.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] net: qrtr: ns: Change servers radix tree to xarray
Date: Mon,  4 May 2026 01:19:18 -0400
Message-ID: <20260504051919.1726114-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050140-unneeded-foster-afe0@gregkh>
References: <2026050140-unneeded-foster-afe0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 524894B87A8
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
	TAGGED_FROM(0.00)[bounces-242838-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,quicinc.com:email,corigine.com:email]

From: Vignesh Viswanathan <quic_viswanat@quicinc.com>

[ Upstream commit 608a147a88728f84bbd2efdde3d4984339f1d872 ]

There is a use after free scenario while iterating through the servers
radix tree despite the ns being a single threaded process. This can
happen when the radix tree APIs are not synchronized with the
rcu_read_lock() APIs.

Convert the radix tree for servers to xarray to take advantage of the
built in rcu lock usage provided by xarray.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 68efba36446a ("net: qrtr: ns: Free the node during ctrl_cmd_bye()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/qrtr/ns.c | 133 +++++++++-----------------------------------------
 1 file changed, 24 insertions(+), 109 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 3c513e7ca2d5c..e3b16bd0d2081 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -65,7 +65,7 @@ struct qrtr_server {
 
 struct qrtr_node {
 	unsigned int id;
-	struct radix_tree_root servers;
+	struct xarray servers;
 };
 
 static struct qrtr_node *node_get(unsigned int node_id)
@@ -82,6 +82,7 @@ static struct qrtr_node *node_get(unsigned int node_id)
 		return NULL;
 
 	node->id = node_id;
+	xa_init(&node->servers);
 
 	if (radix_tree_insert(&nodes, node_id, node)) {
 		kfree(node);
@@ -192,40 +193,23 @@ static void lookup_notify(struct sockaddr_qrtr *to, struct qrtr_server *srv,
 
 static int announce_servers(struct sockaddr_qrtr *sq)
 {
-	struct radix_tree_iter iter;
 	struct qrtr_server *srv;
 	struct qrtr_node *node;
-	void __rcu **slot;
+	unsigned long index;
 	int ret;
 
 	node = node_get(qrtr_ns.local_node);
 	if (!node)
 		return 0;
 
-	rcu_read_lock();
 	/* Announce the list of servers registered in this node */
-	radix_tree_for_each_slot(slot, &node->servers, &iter, 0) {
-		srv = radix_tree_deref_slot(slot);
-		if (!srv)
-			continue;
-		if (radix_tree_deref_retry(srv)) {
-			slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-		slot = radix_tree_iter_resume(slot, &iter);
-		rcu_read_unlock();
-
+	xa_for_each(&node->servers, index, srv) {
 		ret = service_announce_new(sq, srv);
 		if (ret < 0) {
 			pr_err("failed to announce new service\n");
 			return ret;
 		}
-
-		rcu_read_lock();
 	}
-
-	rcu_read_unlock();
-
 	return 0;
 }
 
@@ -255,14 +239,17 @@ static struct qrtr_server *server_add(unsigned int service,
 		goto err;
 
 	/* Delete the old server on the same port */
-	old = radix_tree_lookup(&node->servers, port);
+	old = xa_store(&node->servers, port, srv, GFP_KERNEL);
 	if (old) {
-		radix_tree_delete(&node->servers, port);
-		kfree(old);
+		if (xa_is_err(old)) {
+			pr_err("failed to add server [0x%x:0x%x] ret:%d\n",
+			       srv->service, srv->instance, xa_err(old));
+			goto err;
+		} else {
+			kfree(old);
+		}
 	}
 
-	radix_tree_insert(&node->servers, port, srv);
-
 	trace_qrtr_ns_server_add(srv->service, srv->instance,
 				 srv->node, srv->port);
 
@@ -279,11 +266,11 @@ static int server_del(struct qrtr_node *node, unsigned int port, bool bcast)
 	struct qrtr_server *srv;
 	struct list_head *li;
 
-	srv = radix_tree_lookup(&node->servers, port);
+	srv = xa_load(&node->servers, port);
 	if (!srv)
 		return -ENOENT;
 
-	radix_tree_delete(&node->servers, port);
+	xa_erase(&node->servers, port);
 
 	/* Broadcast the removal of local servers */
 	if (srv->node == qrtr_ns.local_node && bcast)
@@ -343,13 +330,12 @@ static int ctrl_cmd_hello(struct sockaddr_qrtr *sq)
 static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 {
 	struct qrtr_node *local_node;
-	struct radix_tree_iter iter;
 	struct qrtr_ctrl_pkt pkt;
 	struct qrtr_server *srv;
 	struct sockaddr_qrtr sq;
 	struct msghdr msg = { };
 	struct qrtr_node *node;
-	void __rcu **slot;
+	unsigned long index;
 	struct kvec iv;
 	int ret;
 
@@ -360,22 +346,9 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 	if (!node)
 		return 0;
 
-	rcu_read_lock();
 	/* Advertise removal of this client to all servers of remote node */
-	radix_tree_for_each_slot(slot, &node->servers, &iter, 0) {
-		srv = radix_tree_deref_slot(slot);
-		if (!srv)
-			continue;
-		if (radix_tree_deref_retry(srv)) {
-			slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-		slot = radix_tree_iter_resume(slot, &iter);
-		rcu_read_unlock();
+	xa_for_each(&node->servers, index, srv)
 		server_del(node, srv->port, true);
-		rcu_read_lock();
-	}
-	rcu_read_unlock();
 
 	/* Advertise the removal of this client to all local servers */
 	local_node = node_get(qrtr_ns.local_node);
@@ -386,18 +359,7 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 	pkt.cmd = cpu_to_le32(QRTR_TYPE_BYE);
 	pkt.client.node = cpu_to_le32(from->sq_node);
 
-	rcu_read_lock();
-	radix_tree_for_each_slot(slot, &local_node->servers, &iter, 0) {
-		srv = radix_tree_deref_slot(slot);
-		if (!srv)
-			continue;
-		if (radix_tree_deref_retry(srv)) {
-			slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-		slot = radix_tree_iter_resume(slot, &iter);
-		rcu_read_unlock();
-
+	xa_for_each(&local_node->servers, index, srv) {
 		sq.sq_family = AF_QIPCRTR;
 		sq.sq_node = srv->node;
 		sq.sq_port = srv->port;
@@ -410,11 +372,7 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 			pr_err("failed to send bye cmd\n");
 			return ret;
 		}
-		rcu_read_lock();
 	}
-
-	rcu_read_unlock();
-
 	return 0;
 }
 
@@ -422,7 +380,6 @@ static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,
 			       unsigned int node_id, unsigned int port)
 {
 	struct qrtr_node *local_node;
-	struct radix_tree_iter iter;
 	struct qrtr_lookup *lookup;
 	struct qrtr_ctrl_pkt pkt;
 	struct msghdr msg = { };
@@ -431,7 +388,7 @@ static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,
 	struct qrtr_node *node;
 	struct list_head *tmp;
 	struct list_head *li;
-	void __rcu **slot;
+	unsigned long index;
 	struct kvec iv;
 	int ret;
 
@@ -476,18 +433,7 @@ static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,
 	pkt.client.node = cpu_to_le32(node_id);
 	pkt.client.port = cpu_to_le32(port);
 
-	rcu_read_lock();
-	radix_tree_for_each_slot(slot, &local_node->servers, &iter, 0) {
-		srv = radix_tree_deref_slot(slot);
-		if (!srv)
-			continue;
-		if (radix_tree_deref_retry(srv)) {
-			slot = radix_tree_iter_retry(&iter);
-			continue;
-		}
-		slot = radix_tree_iter_resume(slot, &iter);
-		rcu_read_unlock();
-
+	xa_for_each(&local_node->servers, index, srv) {
 		sq.sq_family = AF_QIPCRTR;
 		sq.sq_node = srv->node;
 		sq.sq_port = srv->port;
@@ -500,11 +446,7 @@ static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,
 			pr_err("failed to send del client cmd\n");
 			return ret;
 		}
-		rcu_read_lock();
 	}
-
-	rcu_read_unlock();
-
 	return 0;
 }
 
@@ -577,13 +519,12 @@ static int ctrl_cmd_del_server(struct sockaddr_qrtr *from,
 static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
 			       unsigned int service, unsigned int instance)
 {
-	struct radix_tree_iter node_iter;
 	struct qrtr_server_filter filter;
-	struct radix_tree_iter srv_iter;
 	struct qrtr_lookup *lookup;
+	struct qrtr_server *srv;
 	struct qrtr_node *node;
-	void __rcu **node_slot;
-	void __rcu **srv_slot;
+	unsigned long node_idx;
+	unsigned long srv_idx;
 
 	/* Accept only local observers */
 	if (from->sq_node != qrtr_ns.local_node)
@@ -602,40 +543,14 @@ static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
 	filter.service = service;
 	filter.instance = instance;
 
-	rcu_read_lock();
-	radix_tree_for_each_slot(node_slot, &nodes, &node_iter, 0) {
-		node = radix_tree_deref_slot(node_slot);
-		if (!node)
-			continue;
-		if (radix_tree_deref_retry(node)) {
-			node_slot = radix_tree_iter_retry(&node_iter);
-			continue;
-		}
-		node_slot = radix_tree_iter_resume(node_slot, &node_iter);
-
-		radix_tree_for_each_slot(srv_slot, &node->servers,
-					 &srv_iter, 0) {
-			struct qrtr_server *srv;
-
-			srv = radix_tree_deref_slot(srv_slot);
-			if (!srv)
-				continue;
-			if (radix_tree_deref_retry(srv)) {
-				srv_slot = radix_tree_iter_retry(&srv_iter);
-				continue;
-			}
-
+	xa_for_each(&nodes, node_idx, node) {
+		xa_for_each(&node->servers, srv_idx, srv) {
 			if (!server_match(srv, &filter))
 				continue;
 
-			srv_slot = radix_tree_iter_resume(srv_slot, &srv_iter);
-
-			rcu_read_unlock();
 			lookup_notify(from, srv, true);
-			rcu_read_lock();
 		}
 	}
-	rcu_read_unlock();
 
 	/* Empty notification, to indicate end of listing */
 	lookup_notify(from, NULL, true);
-- 
2.53.0


