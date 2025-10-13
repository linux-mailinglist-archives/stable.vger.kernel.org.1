Return-Path: <stable+bounces-184199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D421BD23A8
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 11:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C4D44EBEB0
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 09:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E7D2FC01E;
	Mon, 13 Oct 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ulDQrkz8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726B62FC015
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346942; cv=none; b=PpolKGpmqAwQEcCySa1FR8DYGsliZDDPNgzHXbqfrpWMDO8cevcpRFYj1n+dMv1M2IHV1IwlNyAejUGBuaVcJfrNfiZAeo1vvRAYYpB8m9VNKdOdl7avhXS4GAvmXdcI3rIeAwoG85y6Ez7n42+RTY5CkOnLAqjdq0nR05M9Qhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346942; c=relaxed/simple;
	bh=zIeEC+1Tw1pk3aP2ZrRopmIdxptYi++jYTaavesrbBQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mzEVa97BqB0LrxGJDGXVjHUAHVZ56SmYYSqXvG+wxymnxTikC7ijAkuMJyiVu5S98r/G6OAnwkHBLRoXn/8xXuVgmzjllflrA4aMGmlPYOmkWQwDQlnkBbsTk8ybtO3ndUghfQ2NbJeV85ma2LcKhWvMjPcua9Xe/zBiAJNgYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ulDQrkz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E99CC4CEE7;
	Mon, 13 Oct 2025 09:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760346941;
	bh=zIeEC+1Tw1pk3aP2ZrRopmIdxptYi++jYTaavesrbBQ=;
	h=Subject:To:Cc:From:Date:From;
	b=ulDQrkz8HxzoTS/dg9gpCdkxFGY+RnUhRKrPjBwsya8k1ArV1HiBwuxKF2YnKhYKz
	 XXcjKwG216bRDHQ4UcLjfU+Eoo2bhKM8uH2YCWC+XBS9v+P0+MnT7fJCsuvBw3ArDs
	 ZlYEalPD8KzWuaK0o9qyOoTPbJvk1yef5dpxJxys=
Subject: FAILED: patch "[PATCH] ksmbd: add max ip connections parameter" failed to apply to 6.6-stable tree
To: linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 11:15:39 +0200
Message-ID: <2025101339-refocus-negotiate-7718@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d8b6dc9256762293048bf122fc11c4e612d0ef5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101339-refocus-negotiate-7718@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d8b6dc9256762293048bf122fc11c4e612d0ef5d Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 1 Oct 2025 09:25:35 +0900
Subject: [PATCH] ksmbd: add max ip connections parameter

This parameter set the maximum number of connections per ip address.
The default is 8.

Cc: stable@vger.kernel.org
Fixes: c0d41112f1a5 ("ksmbd: extend the connection limiting mechanism to support IPv6")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/ksmbd_netlink.h b/fs/smb/server/ksmbd_netlink.h
index 3f07a612c05b..8ccd57fd904b 100644
--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -112,10 +112,11 @@ struct ksmbd_startup_request {
 	__u32	smbd_max_io_size;	/* smbd read write size */
 	__u32	max_connections;	/* Number of maximum simultaneous connections */
 	__s8	bind_interfaces_only;
-	__s8	reserved[503];		/* Reserved room */
+	__u32	max_ip_connections;	/* Number of maximum connection per ip address */
+	__s8	reserved[499];		/* Reserved room */
 	__u32	ifc_list_sz;		/* interfaces list size */
 	__s8	____payload[];
-};
+} __packed;
 
 #define KSMBD_STARTUP_CONFIG_INTERFACES(s)	((s)->____payload)
 
diff --git a/fs/smb/server/server.h b/fs/smb/server/server.h
index 995555febe7d..b8a7317be86b 100644
--- a/fs/smb/server/server.h
+++ b/fs/smb/server/server.h
@@ -43,6 +43,7 @@ struct ksmbd_server_config {
 	unsigned int		auth_mechs;
 	unsigned int		max_connections;
 	unsigned int		max_inflight_req;
+	unsigned int		max_ip_connections;
 
 	char			*conf[SERVER_CONF_WORK_GROUP + 1];
 	struct task_struct	*dh_task;
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 2a3e2b0ce557..2aa1b29bea08 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -335,6 +335,9 @@ static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
 	if (req->max_connections)
 		server_conf.max_connections = req->max_connections;
 
+	if (req->max_ip_connections)
+		server_conf.max_ip_connections = req->max_ip_connections;
+
 	ret = ksmbd_set_netbios_name(req->netbios_name);
 	ret |= ksmbd_set_server_string(req->server_string);
 	ret |= ksmbd_set_work_group(req->work_group);
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 7440a2fd1126..e9ecb43db9d9 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -225,6 +225,7 @@ static int ksmbd_kthread_fn(void *p)
 	struct interface *iface = (struct interface *)p;
 	struct ksmbd_conn *conn;
 	int ret;
+	unsigned int max_ip_conns;
 
 	while (!kthread_should_stop()) {
 		mutex_lock(&iface->sock_release_lock);
@@ -242,34 +243,38 @@ static int ksmbd_kthread_fn(void *p)
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


