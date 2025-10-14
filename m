Return-Path: <stable+bounces-185692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A874DBDA60A
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 17:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52CAB502DA8
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAA32FFFB5;
	Tue, 14 Oct 2025 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZL2B6sH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2397A2FFFAB
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455543; cv=none; b=jOebkgpWCFnj7hz0QQwJLs9z+lCuvFf2Ayc4qn9dGwDxKitmxVtX/g3htR2CHLDMDnAyUQWp1NSYXVLoY+NUwaPudm/yt6OmLM3/nEzI9+9HqyLf+C5IXQSR1t1oEI9SUlTaUsUog3pVB3gTTXslbhYsxvcK/oYIV7Xg58QmN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455543; c=relaxed/simple;
	bh=l0gG3iNF0rcrsWcjAWTNV2MLTjfVXBKkpEN3kIxUPKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDpwv1BSstp2cCc26TSbR+Li6pzh6Sc93MwCkRQd2k5qCcSO295eKQ8F5g5Qk4owrrIWvUwldJP2OQua5jBqdHAhe6xRTr4C9i6iqtCA5gnR9wHR6CCeTxeBY/7G7gWO6Eg/EsLEUrGyTi8N58I9CLLrvJ64/LD64blKFonBqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZL2B6sH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13102C116C6;
	Tue, 14 Oct 2025 15:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760455542;
	bh=l0gG3iNF0rcrsWcjAWTNV2MLTjfVXBKkpEN3kIxUPKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZL2B6sHXOkDMxK6OfzLOYJyQ/vZgAkr7F88esbjl2WxUJRl7gPbIjwT+DanlqSm6
	 IAci0JM6/V7VjNYP2LeNhnD7i0zUzfvwCsgxAvSJmGeq9X6uVlmnIjILzLPqmDOcS9
	 Ml0b92+F5mnubVaQxoOL+BqKm2ufqcitlVB73tX2NEH1pXHfqb1QJkmBNXMLSh85BS
	 5ZkE5xI+L9Qv1rAwHJIz0/T6t9+dDy4U+K57Uiu4EtKoi9pxrEkaEIyofudoW64v/T
	 7ZhOkvrp9PQw7CJMecZLcs0cCV32JtnOGtJwiaONoM/pNLtABWTX56fQqEAawgN3L7
	 V8kbVbaThPW2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: add max ip connections parameter
Date: Tue, 14 Oct 2025 11:25:39 -0400
Message-ID: <20251014152539.122137-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101339-chunk-hassle-3d8e@gregkh>
References: <2025101339-chunk-hassle-3d8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit d8b6dc9256762293048bf122fc11c4e612d0ef5d ]

This parameter set the maximum number of connections per ip address.
The default is 8.

Cc: stable@vger.kernel.org
Fixes: c0d41112f1a5 ("ksmbd: extend the connection limiting mechanism to support IPv6")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ adjust reserved room ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/ksmbd_netlink.h |  5 +++--
 fs/smb/server/server.h        |  1 +
 fs/smb/server/transport_ipc.c |  3 +++
 fs/smb/server/transport_tcp.c | 27 ++++++++++++++++-----------
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/fs/smb/server/ksmbd_netlink.h b/fs/smb/server/ksmbd_netlink.h
index 4464a62228cf3..d3c0b985eb8c1 100644
--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -107,10 +107,11 @@ struct ksmbd_startup_request {
 	__u32	smb2_max_credits;	/* MAX credits */
 	__u32	smbd_max_io_size;	/* smbd read write size */
 	__u32	max_connections;	/* Number of maximum simultaneous connections */
-	__u32	reserved[126];		/* Reserved room */
+	__u32	max_ip_connections;	/* Number of maximum connection per ip address */
+	__u32	reserved[125];		/* Reserved room */
 	__u32	ifc_list_sz;		/* interfaces list size */
 	__s8	____payload[];
-};
+} __packed;
 
 #define KSMBD_STARTUP_CONFIG_INTERFACES(s)	((s)->____payload)
 
diff --git a/fs/smb/server/server.h b/fs/smb/server/server.h
index db72781817603..2cb1b855a39e2 100644
--- a/fs/smb/server/server.h
+++ b/fs/smb/server/server.h
@@ -42,6 +42,7 @@ struct ksmbd_server_config {
 	struct smb_sid		domain_sid;
 	unsigned int		auth_mechs;
 	unsigned int		max_connections;
+	unsigned int		max_ip_connections;
 
 	char			*conf[SERVER_CONF_WORK_GROUP + 1];
 };
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 7fc4b33b89e36..3ca820d0b8d62 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -318,6 +318,9 @@ static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
 	if (req->max_connections)
 		server_conf.max_connections = req->max_connections;
 
+	if (req->max_ip_connections)
+		server_conf.max_ip_connections = req->max_ip_connections;
+
 	ret = ksmbd_set_netbios_name(req->netbios_name);
 	ret |= ksmbd_set_server_string(req->server_string);
 	ret |= ksmbd_set_work_group(req->work_group);
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index a4e7d1a5d64d7..4ef032e737f37 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -236,6 +236,7 @@ static int ksmbd_kthread_fn(void *p)
 	struct interface *iface = (struct interface *)p;
 	struct ksmbd_conn *conn;
 	int ret;
+	unsigned int max_ip_conns;
 
 	while (!kthread_should_stop()) {
 		mutex_lock(&iface->sock_release_lock);
@@ -253,34 +254,38 @@ static int ksmbd_kthread_fn(void *p)
 			continue;
 		}
 
+		if (!server_conf.max_ip_connections)
+			goto skip_max_ip_conns_limit;
+
 		/*
 		 * Limits repeated connections from clients with the same IP.
 		 */
+		max_ip_conns = 0;
 		down_read(&conn_list_lock);
-		list_for_each_entry(conn, &conn_list, conns_list)
+		list_for_each_entry(conn, &conn_list, conns_list) {
 #if IS_ENABLED(CONFIG_IPV6)
 			if (client_sk->sk->sk_family == AF_INET6) {
 				if (memcmp(&client_sk->sk->sk_v6_daddr,
-					   &conn->inet6_addr, 16) == 0) {
-					ret = -EAGAIN;
-					break;
-				}
+					   &conn->inet6_addr, 16) == 0)
+					max_ip_conns++;
 			} else if (inet_sk(client_sk->sk)->inet_daddr ==
-				 conn->inet_addr) {
-				ret = -EAGAIN;
-				break;
-			}
+				 conn->inet_addr)
+				max_ip_conns++;
 #else
 			if (inet_sk(client_sk->sk)->inet_daddr ==
-			    conn->inet_addr) {
+			    conn->inet_addr)
+				max_ip_conns++;
+#endif
+			if (server_conf.max_ip_connections <= max_ip_conns) {
 				ret = -EAGAIN;
 				break;
 			}
-#endif
+		}
 		up_read(&conn_list_lock);
 		if (ret == -EAGAIN)
 			continue;
 
+skip_max_ip_conns_limit:
 		if (server_conf.max_connections &&
 		    atomic_inc_return(&active_num_conn) >= server_conf.max_connections) {
 			pr_info_ratelimited("Limit the maximum number of connections(%u)\n",
-- 
2.51.0


