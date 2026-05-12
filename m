Return-Path: <stable+bounces-245385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC4YK6yUAmqJugEAu9opvQ
	(envelope-from <stable+bounces-245385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 04:47:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BB651906B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 04:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A676303464D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0F0373BF4;
	Tue, 12 May 2026 02:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ahg90acV"
X-Original-To: stable@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A55921CC5C
	for <stable@vger.kernel.org>; Tue, 12 May 2026 02:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778553998; cv=none; b=SrMpaB7jYoVSST7hjUVeO8NgTU1j1RJSsxnETTPa5AqpGoOnVvbYAyJndinHsOjmMsTABBQP8Gkx/vFeOQl+07WDwXv6LAgDHPdR2HI0fsPlXSTj1JzGwpdvhZ8zPfsiilY+mdj4aWX4zut0sJC4pEeqhlLuc34cDivt0gQXyLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778553998; c=relaxed/simple;
	bh=9qdyljLRWkoWnmQ0e/PdcdUE5tB3r963oAi9InDvKsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YkaKBOqhqDXNFFf5Og0U5nVBIiSiO/aH3fEf27HPET/nFftUgCOP2BwD2KoDFeK7Z7cT7iQYd93W/W+n0litc0WfgvQqsOE5/hlpkQTmY7MDVoYmcQGwuRdEI/065qtt6hWRcwMc7DwH159rJY+Str6gR4qbT8NusKdcI7sE6/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ahg90acV; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778553993; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=k7FaQHQYtgE/MLsbbKjKISTxY0rgZI2kaatE+3BeR+8=;
	b=ahg90acVqk+p+KPAf9VTvuzpQvgV8YHl+RZkPxL3vX7NMGb/zAyhrhscDu7Xn/Rjgnb5A0leVsvZhL9sF/aLvBI1oJHS3TFV2EDpvycm/iYSg6yYmtMC3jXMRqPOKdujYMWZQXgsXDnhl4yglwRM6J1ULFFzvUVH2VjB+zwXiXI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X2opB6U_1778553988;
Received: from localhost(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0X2opB6U_1778553988 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 May 2026 10:46:33 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 1/2] ksmbd: make ksmbd thread names distinct by client IP
Date: Tue, 12 May 2026 10:46:23 +0800
Message-Id: <9e0abf5f39fbbec16dbbe8ae2c27d385f5e2ca68.1778553684.git.mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <cover.1778553684.git.mengferry@linux.alibaba.com>
References: <cover.1778553684.git.mengferry@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12BB651906B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245385-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[mengferry@linux.alibaba.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email]
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
 fs/smb/server/transport_tcp.c | 39 ++++++++++++-----------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 8a1a61d22dac..179b0985645e 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -169,17 +169,6 @@ static struct kvec *get_conn_iovec(struct tcp_transport *t, unsigned int nr_segs
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
@@ -191,7 +180,6 @@ static unsigned short ksmbd_tcp_get_port(const struct sockaddr *sa)
  */
 static int ksmbd_tcp_new_connection(struct socket *client_sk)
 {
-	struct sockaddr *csin;
 	int rc = 0;
 	struct tcp_transport *t;
 	struct task_struct *handler;
@@ -202,27 +190,26 @@ static int ksmbd_tcp_new_connection(struct socket *client_sk)
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


