Return-Path: <stable+bounces-158047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ED5AE56B6
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1062A7B3310
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A78223DE5;
	Mon, 23 Jun 2025 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A89kKJ6Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC1A15ADB4;
	Mon, 23 Jun 2025 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717353; cv=none; b=j7TyyjWcPsvAQB587+WSFRZUfZpy/SAO+bJPZrb66pGdOWpq/dwuY4P3F44doxlfNtMiSUihxaEWj2cUMwGBskBnochVABeQI0aM0r79cs0d/qkc/jmqD9JUBYY8jrQAs/mv4hLdiLVEGRKnFcFD8A6OJeu6UldLLbM0r5IgSYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717353; c=relaxed/simple;
	bh=BhaPLvGr6/TaHmbvYP33KfahTlAavMZJvl/veEgWMjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPnB67dP/EuanDqb4bMgAE1mSR8hTLpjn62BePltTvkNR9iPjskfoR3z+dwrBrzBOm87su8PJi9rikZv4yUS9K5A3oSo8vYx6ivXbQfrt3LElbUpbOcwr4Vii1zuJHOKD3QmtgoG4USKG0FeZIs6D7OC9ktWtWgRf96igtg3AX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A89kKJ6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA01C4CEEA;
	Mon, 23 Jun 2025 22:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717353;
	bh=BhaPLvGr6/TaHmbvYP33KfahTlAavMZJvl/veEgWMjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A89kKJ6Z9M4I/n33UZVcddZBmQxkyEeMai48frZN1DhK83+HNfTdXmnVspfAVrqmc
	 Cf2fpGVtRJ1XF1Gsnx54oP9yTUaAwvaxFg3EcoXU75newWdciEo/GLNrUvIwb52axb
	 npMkylXLPKpIGuT4ybGjp+VebnYV7NRlG/OsFTCk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Metzmacher <metze@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 371/414] ksmbd: add free_transport ops in ksmbd connection
Date: Mon, 23 Jun 2025 15:08:28 +0200
Message-ID: <20250623130651.231712754@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit a89f5fae998bdc4d0505306f93844c9ae059d50c ]

free_transport function for tcp connection can be called from smbdirect.
It will cause kernel oops. This patch add free_transport ops in ksmbd
connection, and add each free_transports for tcp and smbdirect.

Fixes: 21a4e47578d4 ("ksmbd: fix use-after-free in __smb2_lease_break_noti()")
Reviewed-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/connection.c     |  2 +-
 fs/smb/server/connection.h     |  1 +
 fs/smb/server/transport_rdma.c | 10 ++++++++--
 fs/smb/server/transport_tcp.c  |  3 ++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 7aaea71a4f206..9eb3e6010aa68 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -40,7 +40,7 @@ void ksmbd_conn_free(struct ksmbd_conn *conn)
 	kvfree(conn->request_buf);
 	kfree(conn->preauth_info);
 	if (atomic_dec_and_test(&conn->refcnt)) {
-		ksmbd_free_transport(conn->transport);
+		conn->transport->ops->free_transport(conn->transport);
 		kfree(conn);
 	}
 }
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index 14620e147dda5..572102098c108 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -132,6 +132,7 @@ struct ksmbd_transport_ops {
 			  void *buf, unsigned int len,
 			  struct smb2_buffer_desc_v1 *desc,
 			  unsigned int desc_len);
+	void (*free_transport)(struct ksmbd_transport *kt);
 };
 
 struct ksmbd_transport {
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 7c5a0d712873d..6921d62934bcb 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -158,7 +158,8 @@ struct smb_direct_transport {
 };
 
 #define KSMBD_TRANS(t) ((struct ksmbd_transport *)&((t)->transport))
-
+#define SMBD_TRANS(t)	((struct smb_direct_transport *)container_of(t, \
+				struct smb_direct_transport, transport))
 enum {
 	SMB_DIRECT_MSG_NEGOTIATE_REQ = 0,
 	SMB_DIRECT_MSG_DATA_TRANSFER
@@ -409,6 +410,11 @@ static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
 	return NULL;
 }
 
+static void smb_direct_free_transport(struct ksmbd_transport *kt)
+{
+	kfree(SMBD_TRANS(kt));
+}
+
 static void free_transport(struct smb_direct_transport *t)
 {
 	struct smb_direct_recvmsg *recvmsg;
@@ -454,7 +460,6 @@ static void free_transport(struct smb_direct_transport *t)
 
 	smb_direct_destroy_pools(t);
 	ksmbd_conn_free(KSMBD_TRANS(t)->conn);
-	kfree(t);
 }
 
 static struct smb_direct_sendmsg
@@ -2300,4 +2305,5 @@ static const struct ksmbd_transport_ops ksmbd_smb_direct_transport_ops = {
 	.read		= smb_direct_read,
 	.rdma_read	= smb_direct_rdma_read,
 	.rdma_write	= smb_direct_rdma_write,
+	.free_transport = smb_direct_free_transport,
 };
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index abedf510899a7..4e9f98db9ff40 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -93,7 +93,7 @@ static struct tcp_transport *alloc_transport(struct socket *client_sk)
 	return t;
 }
 
-void ksmbd_free_transport(struct ksmbd_transport *kt)
+static void ksmbd_tcp_free_transport(struct ksmbd_transport *kt)
 {
 	struct tcp_transport *t = TCP_TRANS(kt);
 
@@ -656,4 +656,5 @@ static const struct ksmbd_transport_ops ksmbd_tcp_transport_ops = {
 	.read		= ksmbd_tcp_read,
 	.writev		= ksmbd_tcp_writev,
 	.disconnect	= ksmbd_tcp_disconnect,
+	.free_transport = ksmbd_tcp_free_transport,
 };
-- 
2.39.5




