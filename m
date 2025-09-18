Return-Path: <stable+bounces-167741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517B2B231D8
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F543169F08
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4022ECE9F;
	Tue, 12 Aug 2025 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V9u0GTrd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B112F5E;
	Tue, 12 Aug 2025 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021836; cv=none; b=Lhlfd2RnKzyioIr/LHzXr131N04ItS0mt6j/HWmTW02IWX/2vg1sTG9G3kS7SLqx276gSfsdWniw5kOjopXnZoDlCUDAQwbR2DFEsYvMQ3lbtWTsXvKH1zoXv0Vu1qHnWrlr7+1tbEfvgZH19uiB8Y5B64suefiJOhEXNPYLvcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021836; c=relaxed/simple;
	bh=a+3VDvmoFH/A2C95Xg4+dKYGBS4jmaH2glQV7W3eym4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apaloNIZ33WyMxV5S0IA5zGMKq0y2ALRBYilMcUWOZu65KIMLxsDx8umjUOS5c7CwqZjwm3akSbzJpA3BpkZuDzYpGzwJdf0WXe3n6wvGqdFsvwFxt6evbelArtdZa9vNlW+dC6TLRPtbBKkYRM15QUErO1g+qlvR4G+Rnk9BX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V9u0GTrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B349DC4CEF0;
	Tue, 12 Aug 2025 18:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021836;
	bh=a+3VDvmoFH/A2C95Xg4+dKYGBS4jmaH2glQV7W3eym4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9u0GTrdMCHQ8wDd432mGrnneReA8MvFpAqAHHHT+DT8cR5Bm6cX2KittpI2MkIaZ
	 VEyteR9pF3gTWw1tj/IHtgrA9qsNPRYyuwCgcbad75mX/lzR9lr3AJ3f4PEVMyCc15
	 bNqBOk5tOWgIDn7ZfUyXG22bCte0qHfIt7N/RN6Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	tianshuo han <hantianshuo233@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 240/262] ksmbd: limit repeated connections from clients with the same IP
Date: Tue, 12 Aug 2025 19:30:28 +0200
Message-ID: <20250812173003.370695651@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
User-Agent: quilt/0.68
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

commit e6bb9193974059ddbb0ce7763fa3882bd60d4dc3 upstream.

Repeated connections from clients with the same IP address may exhaust
the max connections and prevent other normal client connections.
This patch limit repeated connections from clients with the same IP.

Reported-by: tianshuo han <hantianshuo233@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/connection.h    |    1 +
 fs/smb/server/transport_tcp.c |   17 +++++++++++++++++
 2 files changed, 18 insertions(+)

--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -45,6 +45,7 @@ struct ksmbd_conn {
 	struct mutex			srv_mutex;
 	int				status;
 	unsigned int			cli_cap;
+	__be32				inet_addr;
 	char				*request_buf;
 	struct ksmbd_transport		*transport;
 	struct nls_table		*local_nls;
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -87,6 +87,7 @@ static struct tcp_transport *alloc_trans
 		return NULL;
 	}
 
+	conn->inet_addr = inet_sk(client_sk->sk)->inet_daddr;
 	conn->transport = KSMBD_TRANS(t);
 	KSMBD_TRANS(t)->conn = conn;
 	KSMBD_TRANS(t)->ops = &ksmbd_tcp_transport_ops;
@@ -230,6 +231,8 @@ static int ksmbd_kthread_fn(void *p)
 {
 	struct socket *client_sk = NULL;
 	struct interface *iface = (struct interface *)p;
+	struct inet_sock *csk_inet;
+	struct ksmbd_conn *conn;
 	int ret;
 
 	while (!kthread_should_stop()) {
@@ -248,6 +251,20 @@ static int ksmbd_kthread_fn(void *p)
 			continue;
 		}
 
+		/*
+		 * Limits repeated connections from clients with the same IP.
+		 */
+		csk_inet = inet_sk(client_sk->sk);
+		down_read(&conn_list_lock);
+		list_for_each_entry(conn, &conn_list, conns_list)
+			if (csk_inet->inet_daddr == conn->inet_addr) {
+				ret = -EAGAIN;
+				break;
+			}
+		up_read(&conn_list_lock);
+		if (ret == -EAGAIN)
+			continue;
+
 		if (server_conf.max_connections &&
 		    atomic_inc_return(&active_num_conn) >= server_conf.max_connections) {
 			pr_info_ratelimited("Limit the maximum number of connections(%u)\n",



