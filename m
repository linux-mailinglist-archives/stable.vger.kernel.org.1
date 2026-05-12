Return-Path: <stable+bounces-245383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIdSJ8iRAmpUugEAu9opvQ
	(envelope-from <stable+bounces-245383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 04:34:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 468DA518F93
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 04:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55B78301C37D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71A53630A4;
	Tue, 12 May 2026 02:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MZmqxA3A"
X-Original-To: stable@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60172383304;
	Tue, 12 May 2026 02:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778553285; cv=none; b=aF8vUN4SX76gknSDGCb7uDuUzs5NsxqoSdaO8/SeaUb9q3tJCsN4MmJtRSG3Sbl7ZAlIGN9Tl3kuvpkvAkdKnt7BaBqKjJAb1UE6KcszX3V7UdwLrArG8NrANKF+Ypk4GfFHuqlC2e4FVUhyqfYOcRoBmpDcXZ0srW2dOqGPu+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778553285; c=relaxed/simple;
	bh=/+wS7oDnBR8IRSjxCIOqapgFelhDjKLgk/pmP4lyEao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RIEsNTcnBVBl/0hbif4/YUZDvqt1duQkhpH5/wCPsYEcJPxiW3fK6u/Xsu3yDVFBjJoxElb3x3tVVDEvQSbt7g76ylmFT51tAubJ6NZbh5MlYUwvzsrNpqu9+ZW5Upu4VG2vX9jAqydzlHnOdFLDGK5RBphEfDrdXsrKUGXfsjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MZmqxA3A; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778553272; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lVEthr3OjyLWgfe3fW1E9XiL6UTLbnwbkazBNrYN0nE=;
	b=MZmqxA3A5Qqby4Fzc37zK01B66aO+jZMuqo7ceuYLQbB+Mmp73V6B5dKE29Mpv82t5sNm+Y6jLA9qMY1t19RP+y6t3u4LAZSfz03a9RN5GRBi+yVjnElUB8GuJCzorXkwSe7QLEJCfpdejv11dSnjIxWrY1wXqljdxdRENfoIA0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X2opqSE_1778553269;
Received: from localhost(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0X2opqSE_1778553269 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 May 2026 10:34:32 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH v2 6.12.y,6.6.y] ksmbd: make ksmbd thread names distinct by client IP
Date: Tue, 12 May 2026 10:34:27 +0800
Message-Id: <20260512023427.90371-1-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 468DA518F93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-245383-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mengferry@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email]
X-Rspamd-Action: no action

From: Namjae Jeon <linkinjeon@kernel.org>

commit 5da92a251e41f824d7e6b4d54d65dcdcfd69fda3 upstream.

This patch makes ksmbd thread names distinct by client IP address.

100943 ?        S      0:00 [ksmbd:::ffff:10.177.110.57]
 or
101752 ?        S      0:00 [ksmbd:10.177.110.57]

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 77ffbcac4e56 ("smb: server: fix leak of active_num_conn in ksmbd_tcp_new_connection()")
Stable-dep-of: 97f8d2648ef4 ("smb: server: fix active_num_conn leak on transport allocation failure")
Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
v2: Replace verbose [backport ...] description with standard
    Stable-dep-of: tags per stable tree convention.
 
 fs/smb/server/transport_tcp.c | 39 ++++++++++++-----------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index e55afd0c9bf4..f04aa8c504ff 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -173,17 +173,6 @@ static struct kvec *get_conn_iovec(struct tcp_transport *t, unsigned int nr_segs
 	return new_iov;
 }
 
-static unsigned short ksmbd_tcp_get_port(const struct sockaddr *sa)
-{
-	switch (sa->sa_family) {
-	case AF_INET:
-		return ntohs(((struct sockaddr_in *)sa)->sin_port);
-	case AF_INET6:
-		return ntohs(((struct sockaddr_in6 *)sa)->sin6_port);
-	}
-	return 0;
-}
-
 /**
  * ksmbd_tcp_new_connection() - create a new tcp session on mount
  * @client_sk:	socket associated with new connection
@@ -195,7 +184,6 @@ static unsigned short ksmbd_tcp_get_port(const struct sockaddr *sa)
  */
 static int ksmbd_tcp_new_connection(struct socket *client_sk)
 {
-	struct sockaddr *csin;
 	int rc = 0;
 	struct tcp_transport *t;
 	struct task_struct *handler;
@@ -208,27 +196,26 @@ static int ksmbd_tcp_new_connection(struct socket *client_sk)
 		return -ENOMEM;
 	}
 
-	csin = KSMBD_TCP_PEER_SOCKADDR(KSMBD_TRANS(t)->conn);
-	if (kernel_getpeername(client_sk, csin) < 0) {
-		pr_err("client ip resolution failed\n");
-		rc = -EINVAL;
-		goto out_error;
-	}
-
+#if IS_ENABLED(CONFIG_IPV6)
+	if (client_sk->sk->sk_family == AF_INET6)
+		handler = kthread_run(ksmbd_conn_handler_loop,
+				KSMBD_TRANS(t)->conn, "ksmbd:%pI6c",
+				&KSMBD_TRANS(t)->conn->inet6_addr);
+	else
+		handler = kthread_run(ksmbd_conn_handler_loop,
+				KSMBD_TRANS(t)->conn, "ksmbd:%pI4",
+				&KSMBD_TRANS(t)->conn->inet_addr);
+#else
 	handler = kthread_run(ksmbd_conn_handler_loop,
-			      KSMBD_TRANS(t)->conn,
-			      "ksmbd:%u",
-			      ksmbd_tcp_get_port(csin));
+			KSMBD_TRANS(t)->conn, "ksmbd:%pI4",
+			&KSMBD_TRANS(t)->conn->inet_addr);
+#endif
 	if (IS_ERR(handler)) {
 		pr_err("cannot start conn thread\n");
 		rc = PTR_ERR(handler);
 		ksmbd_tcp_disconnect(KSMBD_TRANS(t));
 	}
 	return rc;
-
-out_error:
-	free_transport(t);
-	return rc;
 }
 
 /**
-- 
2.43.5


