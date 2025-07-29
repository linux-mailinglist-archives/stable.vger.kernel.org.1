Return-Path: <stable+bounces-165096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F2CB1517F
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 18:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D39D17E613
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9519E28ECD8;
	Tue, 29 Jul 2025 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OfrT2wBf"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96080186295
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807260; cv=none; b=Hh0xwm56bF1QPrClJ8Tn+j8rAdFIIK/QMK0hUqBblxmKoXRNLRz8F5MQU99UxbEW1lVjo/QDmhv7eqRxyUtof20I3mzexPMoT3lr42I2IO8t3hrHytnsQBfQUU6x2wr56osjATvpnLPfltj6/ieHwCWDgLzyz0f+a/YdZEaX6+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807260; c=relaxed/simple;
	bh=jCmG0deurB4t4U55rNmg5gcxseoibrPdL3GCr8SGyMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rcc+P7qQ2EaDbAcHgzF+4EMYk2oIzo0InQmZWABDh7Uh42tWAVMb/nTyjpJcNnCBlCFoLvNXz0A8lmGSEPYduzzy4vOOqlqaVL7qxE4wjjYkOhGj/hMjEPt16tyFnW/LcG6sKNDKonOE06fByKrc4CYPdg/9HRI4kdnodaxPr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OfrT2wBf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753807257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSD6XhJwJF7zUQM/KUYQkwYdMgfmU5OnuieBSTOHr8I=;
	b=OfrT2wBfjA8dJV580BGb7yAa26nIA91zCqKZUINH57hwn9r0ysRPzWoU6urPz/l33LG1yN
	J4P6DCFiYe84inBlC0SIx0uIkgqDt6lDy9sBLnNez6qfPoW+p+bQFhkk/jVISKN/J//TVX
	POxuPlS0MQG80kngF3CVRvP7ezklsRQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-cgL5vTYCMn206Re6D1NDDA-1; Tue,
 29 Jul 2025 12:40:52 -0400
X-MC-Unique: cgL5vTYCMn206Re6D1NDDA-1
X-Mimecast-MFC-AGG-ID: cgL5vTYCMn206Re6D1NDDA_1753807251
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8870519560B0;
	Tue, 29 Jul 2025 16:40:51 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.66.37])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9740630001B1;
	Tue, 29 Jul 2025 16:40:49 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	trondmy@hammerspace.com,
	anna.schumaker@oracle.com,
	hare@suse.de
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Scott Mayhew <smayhew@redhat.com>,
	Stable@vger.kernel.org
Subject: [PATCH 1/4] sunrpc: fix handling of server side tls alerts
Date: Tue, 29 Jul 2025 12:40:20 -0400
Message-Id: <20250729164023.46643-2-okorniev@redhat.com>
In-Reply-To: <20250729164023.46643-1-okorniev@redhat.com>
References: <20250729164023.46643-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Scott Mayhew discovered a security exploit in NFS over TLS in
tls_alert_recv() due to its assumption it can read data from
the msg iterator's kvec..

kTLS implementation splits TLS non-data record payload between
the control message buffer (which includes the type such as TLS
aler or TLS cipher change) and the rest of the payload (say TLS
alert's level/description) which goes into the msg payload buffer.

This patch proposes to rework how control messages are setup and
used by sock_recvmsg().

If no control message structure is setup, kTLS layer will read and
process TLS data record types. As soon as it encounters a TLS control
message, it would return an error. At that point, NFS can setup a
kvec backed msg buffer and read in the control message such as a
TLS alert. Msg iterator can advance the kvec pointer as a part of
the copy process thus we need to revert the iterator before calling
into the tls_alert_recv.

Reported-by: Scott Mayhew <smayhew@redhat.com>
Fixes: 5e052dda121e ("SUNRPC: Recognize control messages in server-side TCP socket code")
Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 net/sunrpc/svcsock.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 46c156b121db..e2c5e0e626f9 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -257,20 +257,47 @@ svc_tcp_sock_process_cmsg(struct socket *sock, struct msghdr *msg,
 }
 
 static int
-svc_tcp_sock_recv_cmsg(struct svc_sock *svsk, struct msghdr *msg)
+svc_tcp_sock_recv_cmsg(struct socket *sock, unsigned int *msg_flags)
 {
 	union {
 		struct cmsghdr	cmsg;
 		u8		buf[CMSG_SPACE(sizeof(u8))];
 	} u;
-	struct socket *sock = svsk->sk_sock;
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
+	int ret;
+
+	iov_iter_kvec(&msg.msg_iter, ITER_DEST, &alert_kvec, 1,
+		      alert_kvec.iov_len);
+	ret = sock_recvmsg(sock, &msg, MSG_DONTWAIT);
+	if (ret > 0 &&
+	    tls_get_record_type(sock->sk, &u.cmsg) == TLS_RECORD_TYPE_ALERT) {
+		iov_iter_revert(&msg.msg_iter, ret);
+		ret = svc_tcp_sock_process_cmsg(sock, &msg, &u.cmsg, -EAGAIN);
+	}
+	return ret;
+}
+
+static int
+svc_tcp_sock_recvmsg(struct svc_sock *svsk, struct msghdr *msg)
+{
 	int ret;
+	struct socket *sock = svsk->sk_sock;
 
-	msg->msg_control = &u;
-	msg->msg_controllen = sizeof(u);
 	ret = sock_recvmsg(sock, msg, MSG_DONTWAIT);
-	if (unlikely(msg->msg_controllen != sizeof(u)))
-		ret = svc_tcp_sock_process_cmsg(sock, msg, &u.cmsg, ret);
+	if (msg->msg_flags & MSG_CTRUNC) {
+		msg->msg_flags &= ~(MSG_CTRUNC | MSG_EOR);
+		if (ret == 0 || ret == -EIO)
+			ret = svc_tcp_sock_recv_cmsg(sock, &msg->msg_flags);
+	}
 	return ret;
 }
 
@@ -321,7 +348,7 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
 		iov_iter_advance(&msg.msg_iter, seek);
 		buflen -= seek;
 	}
-	len = svc_tcp_sock_recv_cmsg(svsk, &msg);
+	len = svc_tcp_sock_recvmsg(svsk, &msg);
 	if (len > 0)
 		svc_flush_bvec(bvec, len, seek);
 
@@ -1018,7 +1045,7 @@ static ssize_t svc_tcp_read_marker(struct svc_sock *svsk,
 		iov.iov_base = ((char *)&svsk->sk_marker) + svsk->sk_tcplen;
 		iov.iov_len  = want;
 		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &iov, 1, want);
-		len = svc_tcp_sock_recv_cmsg(svsk, &msg);
+		len = svc_tcp_sock_recvmsg(svsk, &msg);
 		if (len < 0)
 			return len;
 		svsk->sk_tcplen += len;
-- 
2.47.1


