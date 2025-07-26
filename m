Return-Path: <stable+bounces-164833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 957F4B12B44
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 17:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DF31C22178
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0A7241103;
	Sat, 26 Jul 2025 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwe1hVaZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787971EBA07
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753545142; cv=none; b=IVx+CFothWGJb2/fwj2FjGdIrJElAulg3klG9UOLKofi/gZ79K0DPpPD8EoOB9npFqI9CxtiUESAm43PSo7zbypZg9A3DrCE85NByMlOlFuDMBWMPG9cYvKtqnGp4i0AFsYv+CIQEM6FHkL2Be7UekwRyrgVELfxZnGz0pOjqQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753545142; c=relaxed/simple;
	bh=6h5ooq/hv/yDzATq+weSo8fo1Qw4MsPiDjJGtxxIRj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k6XqomEYRftI+GLuf7IrXmWUIP0XD3eZV/UNWZ+YyzABCIG5lB2IBEo6M+TyI8I4krpkLHtvkNC6tJz+CSG2jjCvqcId8+HlLK7V5iPtehM1drZ8GFiIucmFL4p4kkvf5nv/gepWMCLD1x+BNEqWA4i1xrv/1P5mVnAxUnWTsz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwe1hVaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E71C4CEED;
	Sat, 26 Jul 2025 15:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753545142;
	bh=6h5ooq/hv/yDzATq+weSo8fo1Qw4MsPiDjJGtxxIRj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bwe1hVaZvbXDTq7Ep7PqpqbX18mTRfcgoOAJ/j4C8vHtR0mrJOsfZ2t0ZjhM+UJD7
	 BcyBKCAf0r2h5vzBHpeAtETJ7WU87n1RJmKgeEEqi8b0S9tTVg3wQDAvZDCxaZR1fn
	 GzRjjtUB2ZBLlb4Dryxq408Ygop/QKxZSBxA+Jw+vw4hvpuRARzEy0Hd1TfhZiE/SM
	 C0IIhWyZ7pJlIRsa6soyq5UlgGkqxqKB8QqLVX3J74px056pns3XYK+L8TB7y1oInG
	 h1mZMOIgN9d+vnaMl0pQkp+YRWol4DId0ND3iuS3MBHDOt2DcECCOxsHzGxVZb0Sv/
	 /v9cRYv5xNteg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Norbert Szetei <norbert@doyensec.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: fix use-after-free in __smb2_lease_break_noti()
Date: Sat, 26 Jul 2025 11:52:17 -0400
Message-Id: <20250726155217.2083648-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025042109-embroider-consoling-20d9@gregkh>
References: <2025042109-embroider-consoling-20d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 21a4e47578d44c6b37c4fc4aba8ed7cc8dbb13de ]

Move tcp_transport free to ksmbd_conn_free. If ksmbd connection is
referenced when ksmbd server thread terminates, It will not be freed,
but conn->tcp_transport is freed. __smb2_lease_break_noti can be performed
asynchronously when the connection is disconnected. __smb2_lease_break_noti
calls ksmbd_conn_write, which can cause use-after-free
when conn->ksmbd_transport is already freed.

Cc: stable@vger.kernel.org
Reported-by: Norbert Szetei <norbert@doyensec.com>
Tested-by: Norbert Szetei <norbert@doyensec.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ Removed declaration of non-existent function ksmbd_find_netdev_name_iface_list() from transport_tcp.h. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/connection.c    |  4 +++-
 fs/smb/server/transport_tcp.c | 14 +++++++++-----
 fs/smb/server/transport_tcp.h |  1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index e7bcc3830031..abbf756891a9 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -39,8 +39,10 @@ void ksmbd_conn_free(struct ksmbd_conn *conn)
 	xa_destroy(&conn->sessions);
 	kvfree(conn->request_buf);
 	kfree(conn->preauth_info);
-	if (atomic_dec_and_test(&conn->refcnt))
+	if (atomic_dec_and_test(&conn->refcnt)) {
+		ksmbd_free_transport(conn->transport);
 		kfree(conn);
+	}
 }
 
 /**
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 2ce7f75059cb..c27f0cef3b59 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -93,17 +93,21 @@ static struct tcp_transport *alloc_transport(struct socket *client_sk)
 	return t;
 }
 
-static void free_transport(struct tcp_transport *t)
+void ksmbd_free_transport(struct ksmbd_transport *kt)
 {
-	kernel_sock_shutdown(t->sock, SHUT_RDWR);
-	sock_release(t->sock);
-	t->sock = NULL;
+	struct tcp_transport *t = TCP_TRANS(kt);
 
-	ksmbd_conn_free(KSMBD_TRANS(t)->conn);
+	sock_release(t->sock);
 	kfree(t->iov);
 	kfree(t);
 }
 
+static void free_transport(struct tcp_transport *t)
+{
+	kernel_sock_shutdown(t->sock, SHUT_RDWR);
+	ksmbd_conn_free(KSMBD_TRANS(t)->conn);
+}
+
 /**
  * kvec_array_init() - initialize a IO vector segment
  * @new:	IO vector to be initialized
diff --git a/fs/smb/server/transport_tcp.h b/fs/smb/server/transport_tcp.h
index e338bebe322f..5925ec5df475 100644
--- a/fs/smb/server/transport_tcp.h
+++ b/fs/smb/server/transport_tcp.h
@@ -7,6 +7,7 @@
 #define __KSMBD_TRANSPORT_TCP_H__
 
 int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz);
+void ksmbd_free_transport(struct ksmbd_transport *kt);
 int ksmbd_tcp_init(void);
 void ksmbd_tcp_destroy(void);
 
-- 
2.39.5


