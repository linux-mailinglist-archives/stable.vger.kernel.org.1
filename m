Return-Path: <stable+bounces-168739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1058B23691
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20EDF7BB725
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238692FA0DB;
	Tue, 12 Aug 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FfIOswcT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1732FF14D;
	Tue, 12 Aug 2025 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025175; cv=none; b=CKu9FvuczPXF4WrnSvTCztBEWeNFOMkpyvFMMdYjhGABIFCXs/0HvWPbGYXpifIa4ZHXc75Fjrr0nbXdJCntN5tjGEL6FEyxWfDw8vgbWRemgytZm+4oAjViZ0jZsiKjOttvvEwwDugpMrulVNKJ7WTjeCW3E33td2/M0/gyh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025175; c=relaxed/simple;
	bh=AibmYXpEstRADrdYFnoxtAFXGQZXQ4QzajGUF8eXjO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRtQNLfsddhbhuLFp1/5W5GW9qQKKh8njnvH7GmBAc8cYy+MTIEs5PyUicR2B8zeagIyxBak9/iFJaiFTH2Bm85ut87RwKqSpbxAW07eV996RAZ0ZXaOCus02gIAN0A6jmxAvZvCwOAi+3ve27/92iPSOhWMly/zXh5uFFui9aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FfIOswcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE62C4CEF0;
	Tue, 12 Aug 2025 18:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025175;
	bh=AibmYXpEstRADrdYFnoxtAFXGQZXQ4QzajGUF8eXjO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfIOswcT+nW4/6HMcRqwY1Xv8SYQwshIrwOILDAliksQsC0c2nngIpXODotiCcXB3
	 kGKiuDgcO91QOk3vaFXfakuO4QUdDKB3H6rYO+QNdVErZx8wyCYY1rfBUQVUz630Y9
	 3V0Y/eXjKPH3iESHFNS4lBchr19y/sJUy1+vqaPI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	tianshuo han <hantianshuo233@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.16 590/627] ksmbd: limit repeated connections from clients with the same IP
Date: Tue, 12 Aug 2025 19:34:45 +0200
Message-ID: <20250812173454.314175568@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -46,6 +46,7 @@ struct ksmbd_conn {
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



