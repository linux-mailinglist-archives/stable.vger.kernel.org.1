Return-Path: <stable+bounces-165101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6BAB1519C
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 18:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15983A96C0
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57936289E36;
	Tue, 29 Jul 2025 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqQt2qye"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B522D4E2
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807624; cv=none; b=b8/5dEeCtETdzxdyIXkN9CByiQ8yrpVrJ2B1mlm3qgQeBQQsXVKfCTQF5K15Z9YH1tT7xuaBVFcM6zK+HU6M+OWstL2jwyK5atPly09qgGFji58Mt6yA/n/xtWFdEd7s83zvpmpt7V9SYjiz0VKiLKtolXWwCjV6wbYdysuyYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807624; c=relaxed/simple;
	bh=oR6Msj0yTmzafN3GEkDft5Di23BPxXgLw8uOOtZiPFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XSk4gqy4/d3QdBaEd3BTC/arTNCelnsoqHqmP/xGX5bInrdNnp+3e+367Kg6S9x+M1d/gl1TZiQSKTm0XHQppmq9EQkQg0rMBHh1f+ibekuOuBe+8utYW2WQFU643XmJHhBVlOxl9VD+a1S/HR3MgOYvl5/byLhufKn2dqVdFb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqQt2qye; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753807621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnYIkwN4XUGoVdMlEbsN9yzCfY5YHPQ+7DJ/sKW+a7Q=;
	b=dqQt2qyeclqwwKCgT75BkS2xluvYVyPIQ5NxQo4Xs2dviRJ8Pjm4J5CDhXZ7MrykjJM+kh
	X5Pq9ZxWosy6Ho7zcVNqpgvGz7tqoz27Dfv7J5Dl8UrbR5yk/G7SFWyL33+bOQzkGlSQly
	l5VqnTaOSbZBb+XCufTs2mERQnZgdqM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-tqIQQtxIMPGe7Qegk8kC9A-1; Tue,
 29 Jul 2025 12:46:58 -0400
X-MC-Unique: tqIQQtxIMPGe7Qegk8kC9A-1
X-Mimecast-MFC-AGG-ID: tqIQQtxIMPGe7Qegk8kC9A_1753807618
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF671180045C;
	Tue, 29 Jul 2025 16:46:57 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.66.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B55A81800286;
	Tue, 29 Jul 2025 16:46:56 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: smayhew@redhat.com
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Stable@vger.kernel.org
Subject: [PATCH 2/4] sunrpc: fix client side handling of tls alerts
Date: Tue, 29 Jul 2025 12:46:47 -0400
Message-Id: <20250729164649.46703-3-okorniev@redhat.com>
In-Reply-To: <20250729164649.46703-1-okorniev@redhat.com>
References: <20250729164649.46703-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

A security exploit was discovered in NFS over TLS in tls_alert_recv
due to its assumption that there is valid data in the msghdr's
iterator's kvec.

Instead, this patch proposes the rework how control messages are
setup and used by sock_recvmsg().

If no control message structure is setup, kTLS layer will read and
process TLS data record types. As soon as it encounters a TLS control
message, it would return an error. At that point, NFS can setup a kvec
backed control buffer and read in the control message such as a TLS
alert. Msg iterator can advance the kvec pointer as a part of the copy
process thus we need to revert the iterator before calling into the
tls_alert_recv.

Fixes: dea034b963c8 ("SUNRPC: Capture CMSG metadata on client-side receive")
Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 net/sunrpc/xprtsock.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 04ff66758fc3..c5f7bbf5775f 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -358,7 +358,7 @@ xs_alloc_sparse_pages(struct xdr_buf *buf, size_t want, gfp_t gfp)
 
 static int
 xs_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
-		     struct cmsghdr *cmsg, int ret)
+		     unsigned int *msg_flags, struct cmsghdr *cmsg, int ret)
 {
 	u8 content_type = tls_get_record_type(sock->sk, cmsg);
 	u8 level, description;
@@ -371,7 +371,7 @@ xs_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
 		 * record, even though there might be more frames
 		 * waiting to be decrypted.
 		 */
-		msg->msg_flags &= ~MSG_EOR;
+		*msg_flags &= ~MSG_EOR;
 		break;
 	case TLS_RECORD_TYPE_ALERT:
 		tls_alert_recv(sock->sk, msg, &level, &description);
@@ -386,19 +386,33 @@ xs_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
 }
 
 static int
-xs_sock_recv_cmsg(struct socket *sock, struct msghdr *msg, int flags)
+xs_sock_recv_cmsg(struct socket *sock, unsigned int *msg_flags, int flags)
 {
 	union {
 		struct cmsghdr	cmsg;
 		u8		buf[CMSG_SPACE(sizeof(u8))];
 	} u;
+	u8 alert[2];
+	struct kvec alert_kvec = {
+		.iov_base = alert,
+		.iov_len = sizeof(alert),
+	};
+	struct msghdr msg = {
+		.msg_flags = *msg_flags,
+		.msg_control = &u,
+		.msg_controllen = sizeof(u),
+	};
 	int ret;
 
-	msg->msg_control = &u;
-	msg->msg_controllen = sizeof(u);
-	ret = sock_recvmsg(sock, msg, flags);
-	if (msg->msg_controllen != sizeof(u))
-		ret = xs_sock_process_cmsg(sock, msg, &u.cmsg, ret);
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
+		      alert_kvec.iov_len);
+	ret = sock_recvmsg(sock, &msg, flags);
+	if (ret > 0 &&
+	    tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
+		iov_iter_revert(&msg.msg_iter, ret);
+		ret = xs_sock_process_cmsg(sock, &msg, msg_flags, &u.cmsg,
+					   -EAGAIN);
+	}
 	return ret;
 }
 
@@ -408,7 +422,13 @@ xs_sock_recvmsg(struct socket *sock, struct msghdr *msg, int flags, size_t seek)
 	ssize_t ret;
 	if (seek != 0)
 		iov_iter_advance(&msg->msg_iter, seek);
-	ret = xs_sock_recv_cmsg(sock, msg, flags);
+	ret = sock_recvmsg(sock, msg, flags);
+	/* Handle TLS inband control message lazily */
+	if (msg->msg_flags & MSG_CTRUNC) {
+		msg->msg_flags &= ~(MSG_CTRUNC | MSG_EOR);
+		if (ret == 0 || ret == -EIO)
+			ret = xs_sock_recv_cmsg(sock, &msg->msg_flags, flags);
+	}
 	return ret > 0 ? ret + seek : ret;
 }
 
@@ -434,7 +454,7 @@ xs_read_discard(struct socket *sock, struct msghdr *msg, int flags,
 		size_t count)
 {
 	iov_iter_discard(&msg->msg_iter, ITER_DEST, count);
-	return xs_sock_recv_cmsg(sock, msg, flags);
+	return xs_sock_recvmsg(sock, msg, flags, 0);
 }
 
 #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
-- 
2.47.1


