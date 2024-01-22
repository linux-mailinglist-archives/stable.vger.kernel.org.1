Return-Path: <stable+bounces-12755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A7E8372A0
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70036B2F577
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E281EF12;
	Mon, 22 Jan 2024 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="enVJmeUV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814263F8C7
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705950967; cv=none; b=VhXexcUNQIp7pit21yh2cYuk/y1BjriOKGWcRKx6yNzFqHUjpoxR4kZ7Z+vs5Jx/SQ6URe2a2V0iFGeDHhayYW8zWZgiZV/y8mN991GrlUUD508ODaZNS5OL/dHcwpDvB5T0N94TZ9g6MC0+ZX8ChfM6GhxpTYMdZl70hnnYWiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705950967; c=relaxed/simple;
	bh=CEdJKtH+itB6wzAIJ6e6ENlQoelPVYNc8JjSiFYAHF4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oE2P2RLnMe5JkImqsKn5d1RhCiVRLo8PpaqkYQOjRN61rdVIBvMyVG/uzqdOK7JvkDNL/VuVHQlsrxfYDGJF2/s4MUmsAqOcCwZtBqkLlV/16bxVQee+963GaUEmS2W/5fCau1pswYLkC0kS3vzac89njAmINjIsm6fduO8nMYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=enVJmeUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8B3C433C7;
	Mon, 22 Jan 2024 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705950966;
	bh=CEdJKtH+itB6wzAIJ6e6ENlQoelPVYNc8JjSiFYAHF4=;
	h=Subject:To:Cc:From:Date:From;
	b=enVJmeUVXdifUFjrEBlHJi4H43+rTIcoR1a7m3GHI58tJNQaGYHjn+Zz0Tq9QtLoe
	 pteeMB+ySZlQCjWMuMpMjJ5ZsDT3LVxRQbrrLvJD6XIhHTYirvDvz4XTBzbTxUQb9T
	 7e3X8MHeb1GqovvNsxCtFTy8nyCO9hvtEZD+R0dA=
Subject: FAILED: patch "[PATCH] ksmbd: fix UAF issue in ksmbd_tcp_new_connection()" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 11:15:53 -0800
Message-ID: <2024012253-reoccupy-reliance-043c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 38d20c62903d669693a1869aa68c4dd5674e2544
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012253-reoccupy-reliance-043c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

38d20c62903d ("ksmbd: fix UAF issue in ksmbd_tcp_new_connection()")
38c8a9a52082 ("smb: move client and server files to common directory fs/smb")
f5c779b7ddbd ("ksmbd: fix racy issue from session setup and logoff")
1d9c4172110e ("ksmbd: Implements sess->ksmbd_chann_list as xarray")
62c487b53a7f ("ksmbd: limit pdu length size according to connection status")
abdb1742a312 ("cifs: get rid of mount options string parsing")
9fd29a5bae6e ("cifs: use fs_context for automounts")
5dd8ce24667a ("cifs: missing directory in MAINTAINERS file")
332019e23a51 ("Merge tag '5.20-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 38d20c62903d669693a1869aa68c4dd5674e2544 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 13 Jan 2024 15:30:07 +0900
Subject: [PATCH] ksmbd: fix UAF issue in ksmbd_tcp_new_connection()

The race is between the handling of a new TCP connection and
its disconnection. It leads to UAF on `struct tcp_transport` in
ksmbd_tcp_new_connection() function.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-22991
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index d311c2ee10bd..09e1e7771592 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -416,13 +416,7 @@ static void stop_sessions(void)
 again:
 	down_read(&conn_list_lock);
 	list_for_each_entry(conn, &conn_list, conns_list) {
-		struct task_struct *task;
-
 		t = conn->transport;
-		task = t->handler;
-		if (task)
-			ksmbd_debug(CONN, "Stop session handler %s/%d\n",
-				    task->comm, task_pid_nr(task));
 		ksmbd_conn_set_exiting(conn);
 		if (t->ops->shutdown) {
 			up_read(&conn_list_lock);
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index 342f935f5770..0e04cf8b1d89 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -135,7 +135,6 @@ struct ksmbd_transport_ops {
 struct ksmbd_transport {
 	struct ksmbd_conn		*conn;
 	struct ksmbd_transport_ops	*ops;
-	struct task_struct		*handler;
 };
 
 #define KSMBD_TCP_RECV_TIMEOUT	(7 * HZ)
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index c5629a68c8b7..8faa25c6e129 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -2039,6 +2039,7 @@ static bool rdma_frwr_is_supported(struct ib_device_attr *attrs)
 static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
 {
 	struct smb_direct_transport *t;
+	struct task_struct *handler;
 	int ret;
 
 	if (!rdma_frwr_is_supported(&new_cm_id->device->attrs)) {
@@ -2056,11 +2057,11 @@ static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
 	if (ret)
 		goto out_err;
 
-	KSMBD_TRANS(t)->handler = kthread_run(ksmbd_conn_handler_loop,
-					      KSMBD_TRANS(t)->conn, "ksmbd:r%u",
-					      smb_direct_port);
-	if (IS_ERR(KSMBD_TRANS(t)->handler)) {
-		ret = PTR_ERR(KSMBD_TRANS(t)->handler);
+	handler = kthread_run(ksmbd_conn_handler_loop,
+			      KSMBD_TRANS(t)->conn, "ksmbd:r%u",
+			      smb_direct_port);
+	if (IS_ERR(handler)) {
+		ret = PTR_ERR(handler);
 		pr_err("Can't start thread\n");
 		goto out_err;
 	}
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index eff7a1d793f0..9d4222154dcc 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -185,6 +185,7 @@ static int ksmbd_tcp_new_connection(struct socket *client_sk)
 	struct sockaddr *csin;
 	int rc = 0;
 	struct tcp_transport *t;
+	struct task_struct *handler;
 
 	t = alloc_transport(client_sk);
 	if (!t) {
@@ -199,13 +200,13 @@ static int ksmbd_tcp_new_connection(struct socket *client_sk)
 		goto out_error;
 	}
 
-	KSMBD_TRANS(t)->handler = kthread_run(ksmbd_conn_handler_loop,
-					      KSMBD_TRANS(t)->conn,
-					      "ksmbd:%u",
-					      ksmbd_tcp_get_port(csin));
-	if (IS_ERR(KSMBD_TRANS(t)->handler)) {
+	handler = kthread_run(ksmbd_conn_handler_loop,
+			      KSMBD_TRANS(t)->conn,
+			      "ksmbd:%u",
+			      ksmbd_tcp_get_port(csin));
+	if (IS_ERR(handler)) {
 		pr_err("cannot start conn thread\n");
-		rc = PTR_ERR(KSMBD_TRANS(t)->handler);
+		rc = PTR_ERR(handler);
 		free_transport(t);
 	}
 	return rc;


