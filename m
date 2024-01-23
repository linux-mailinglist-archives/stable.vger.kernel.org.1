Return-Path: <stable+bounces-15300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFB18384B3
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FAF1C27528
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBF574E00;
	Tue, 23 Jan 2024 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wLdE4lzk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEFA745D6;
	Tue, 23 Jan 2024 02:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975462; cv=none; b=WHtffkCZDUDY4UFPAGDNlDIyE2zECVZZRYcGHmzA5SIhNDQPTMOlYOhU1LC8d6Boni0mGVGb4mqJ7WK3b6nQfMEJBmpKyKpCX+tbo7gymaTSvZ7JkJTcGs2U1T16GfbE4sGOrhyJL7p4oIf8i7utPkbBZfkcw96ljBEcz0vIOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975462; c=relaxed/simple;
	bh=kVSw27/vRYf7zFQJ2c3UbKwzD9BL2MFYUdg7bwocrww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDD5vbi7BCMq+R6RBNcNI/2kJHl+hD0JDYZQOLAXdKjuLluQxGHvY69kDosADyqRHKXa7roADbFyFQCRZ76BEaIzeLf7akQ/6WMkdOsHdzvlLDFm0v62oiwZKEXtsd/fw++HCZiI9d9lbjdf+qmxJsUNlfgd7M+zwvFlxMcqh1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wLdE4lzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524E1C43399;
	Tue, 23 Jan 2024 02:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975462;
	bh=kVSw27/vRYf7zFQJ2c3UbKwzD9BL2MFYUdg7bwocrww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wLdE4lzk1a5ENQKHmkxxX665VeUgR2SVblKNoCQu2Xe7PSAdAxf/9U0bycYRt5v6f
	 WXMtj8uLGLXTPprLd4kwCgfTZ074c5zkY9wDzQxScisH5mObTYlwhPfLViO94Dv63W
	 NrG29k82KAaFt54zYQ38OKncGR3GFKnf7NNNGbes=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	zdi-disclosures@trendmicro.com
Subject: [PATCH 6.6 384/583] ksmbd: fix UAF issue in ksmbd_tcp_new_connection()
Date: Mon, 22 Jan 2024 15:57:15 -0800
Message-ID: <20240122235823.747261159@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 38d20c62903d669693a1869aa68c4dd5674e2544 upstream.

The race is between the handling of a new TCP connection and
its disconnection. It leads to UAF on `struct tcp_transport` in
ksmbd_tcp_new_connection() function.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-22991
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/connection.c     |    6 ------
 fs/smb/server/connection.h     |    1 -
 fs/smb/server/transport_rdma.c |   11 ++++++-----
 fs/smb/server/transport_tcp.c  |   13 +++++++------
 4 files changed, 13 insertions(+), 18 deletions(-)

--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -415,13 +415,7 @@ static void stop_sessions(void)
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
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -135,7 +135,6 @@ struct ksmbd_transport_ops {
 struct ksmbd_transport {
 	struct ksmbd_conn		*conn;
 	struct ksmbd_transport_ops	*ops;
-	struct task_struct		*handler;
 };
 
 #define KSMBD_TCP_RECV_TIMEOUT	(7 * HZ)
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -2039,6 +2039,7 @@ static bool rdma_frwr_is_supported(struc
 static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
 {
 	struct smb_direct_transport *t;
+	struct task_struct *handler;
 	int ret;
 
 	if (!rdma_frwr_is_supported(&new_cm_id->device->attrs)) {
@@ -2056,11 +2057,11 @@ static int smb_direct_handle_connect_req
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
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -185,6 +185,7 @@ static int ksmbd_tcp_new_connection(stru
 	struct sockaddr *csin;
 	int rc = 0;
 	struct tcp_transport *t;
+	struct task_struct *handler;
 
 	t = alloc_transport(client_sk);
 	if (!t) {
@@ -199,13 +200,13 @@ static int ksmbd_tcp_new_connection(stru
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



