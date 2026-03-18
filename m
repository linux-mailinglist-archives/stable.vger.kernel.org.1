Return-Path: <stable+bounces-226947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE5fHH3/uWlBQQIAu9opvQ
	(envelope-from <stable+bounces-226947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 02:27:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3B32B4F37
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 02:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F3CB30A307A
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D0724468B;
	Wed, 18 Mar 2026 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkLfNeTB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B155323C4F3
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773797225; cv=none; b=hAkTyJPG/ttMGTNAwyxKDV1iN/WUxmDBcZCl2vbHvLneF4rcpvzrk0ALfWs5kHLE+KyVQu9xMMLgiggd80ti+DC0WEUldBEhSu9FoKFaRvyVQp98gYvpcKItjkVy4ztfKOQPNaNzRAeii+DkCMLOr9feffqvN8zHny7qsg9xnUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773797225; c=relaxed/simple;
	bh=ixYXi+/k0hGdcXem8PCM6XaaEWN9flbdQPgnzunHPV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WodaJWXwjvWr8oH+Ea8vW6E0eCIegh+rd8CYwDtDMmEwdYd+Iz04NeDxvJd8x38U9rbzC5exVH6F/ib3+Ovwf8Rfl8WWCOytmboYFch4VNrxUOFuyDXbilxZ0nd3dW8gv7M33nsZE6W9e8va/N0f2qwbbhc7aBzGwNg0sf7jMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkLfNeTB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-667de793310so176762a12.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 18:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773797222; x=1774402022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WNXLkEoBDNGwPbjZ/vooPOcdheELOMB3ucg5AbTB558=;
        b=SkLfNeTB/iEONLq+RVNYOrVMLfy1DJ4eX2cbMt/kMzmwn5B3ZcnAOiRZug0oiJNyDz
         83lFcgCILXjtN1+iQt2gWBvSiT7Zt7Ft8MpspummkBE+j4C+vqUx/P9eetn+aJII5lsK
         Y8aABM+mWc3gQuo/0qQBuwKXfkE56o3CMWW5WjYcxCIlW5gwPo9lrKdKz/vJTpY/GVWU
         8H2RvMENNN0yXYd80qdUMvdSr6joiIX6Zy3FAClJr7YvRrFKibtGe2TdABpOKWTp8jES
         KcCW7vnCk/YQCT9ECxjZftFqswHYXQM7j460mnjjQA9IwyOO/SlW2KVeflDkXOEGbHtV
         veeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773797222; x=1774402022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNXLkEoBDNGwPbjZ/vooPOcdheELOMB3ucg5AbTB558=;
        b=E/3YCSF1MgQkVyt75zLGBgk8Z/MCOvWXF5oon+r7gTY6HlFI1mY+4SzijtkqtQ/+ZR
         rmmA1X2ekMpANbwlEEWPwiWzZgVVJDREPJaLWlmF8iAvu+CUrQTZ0DR+D4QpxaL+TzWW
         Rr3HaRVLOz15fCOdU66Iyo2TVuWoEp8EHpB7mG2ORGXZszP7CEUWFRK0n2A8dpknj76L
         ks9qqp9ajvSf7yD10ZI6ZFONXN3wILgxbWAdY+nioNke1YBhVy2nUY4UoJXOq+xRExgo
         b3X7wDqRPGcMKYHg6IIRwDxAlFnLCGeG66ITft0FLIa4laQCcfelcVjxKMeFFcdsDKWR
         CvKA==
X-Gm-Message-State: AOJu0YwLeFGN9IvmR42R9P5Rt4c1GDm7x/BJMrt56e+s7F0+3xk7NvFz
	VdvkFXt7V1BtloFt2YUjPH0wGrj45Bb4QXeNPfby+chCGbOA+HuGdq3GZg8ubduqc78=
X-Gm-Gg: ATEYQzzsQx4IG9KUwXkpqNA/4M3bneWF5x8ZJT2OW5Ywr0YRXcq6snb+yqFvM5gUyDs
	rFu1T7vnmZZtiStwGduTxw8PADejecDbD6KflzlP9evpJ7geFA3Pi/sbqThk2tpYjAq993AxUbF
	0W1hvZaLc4tWJ42XarTqP1KhFWks7DlyrYXR5zIp8tGBqefANxvvhYiUofiYqRs0uZnYEDOKTuc
	Zv68Pilcp+PtDGVtPEd6pbzw8haqz0VBTQNoMnyWkgCJWxwTjCFbwT+TG/SYiAAaNEHfx41P+C4
	2yh9iaEiXyZ6TRt7V5MtCNH8ATodoLR0k0gIaT4lW4krh6+tbV3njSl5c9OqGhro4RT4DHxbjNm
	pnJUxcQc+F2CKF8QPFCgMrDiQLsZoE7E52wOV7b2FHovk+g4iouHZlc+scRQSLgmE7Zi757p6
X-Received: by 2002:a17:907:2da7:b0:b97:4e42:23e7 with SMTP id a640c23a62f3a-b97f484fb15mr100629266b.24.1773797221520;
        Tue, 17 Mar 2026 18:27:01 -0700 (PDT)
Received: from gmail.com ([2a09:bac1:5520::49b:45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f168c141sm91922766b.40.2026.03.17.18.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 18:27:00 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: stable@vger.kernel.org
Cc: linux-ppp@vger.kernel.org,
	James Chapman <jchapman@katalix.com>,
	Guillaume Nault <gnault@redhat.com>,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH 6.6.y 6.1.y 5.15.y 5.10.y] l2tp: fix ppp_dev_name() use-after-free
Date: Wed, 18 Mar 2026 09:26:53 +0800
Message-ID: <20260318012653.232518-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226947-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE3B32B4F37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit 9b8c88f875c04d4cb9111bd5dd9291c7e9691bf5 ]

ppp_dev_name() directly returns netdev->name to the caller. The caller
must hold either RCU or RTNL lock, in order to prevent the netdev from
being freed while still being used.

The upstream commit expanded the RCU critical section to include
ppp_dev_name(), which inadvertently fixed the problem. So backport the
commit to fix the UAF in older stable versions.

Fixes: ee40fb2e1eb5 ("l2tp: protect sock pointer of struct pppol2tp_session with RCU")
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
 net/l2tp/l2tp_ppp.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 6146e4e67bbb..34d8582c0c07 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -130,22 +130,12 @@ static const struct ppp_channel_ops pppol2tp_chan_ops = {
 
 static const struct proto_ops pppol2tp_ops;
 
-/* Retrieves the pppol2tp socket associated to a session.
- * A reference is held on the returned socket, so this function must be paired
- * with sock_put().
- */
+/* Retrieves the pppol2tp socket associated to a session. */
 static struct sock *pppol2tp_session_get_sock(struct l2tp_session *session)
 {
 	struct pppol2tp_session *ps = l2tp_session_priv(session);
-	struct sock *sk;
 
-	rcu_read_lock();
-	sk = rcu_dereference(ps->sk);
-	if (sk)
-		sock_hold(sk);
-	rcu_read_unlock();
-
-	return sk;
+	return rcu_dereference(ps->sk);
 }
 
 /* Helpers to obtain tunnel/session contexts from sockets.
@@ -211,14 +201,13 @@ static int pppol2tp_recvmsg(struct socket *sock, struct msghdr *msg,
 
 static void pppol2tp_recv(struct l2tp_session *session, struct sk_buff *skb, int data_len)
 {
-	struct pppol2tp_session *ps = l2tp_session_priv(session);
-	struct sock *sk = NULL;
+	struct sock *sk;
 
 	/* If the socket is bound, send it in to PPP's input queue. Otherwise
 	 * queue it on the session socket.
 	 */
 	rcu_read_lock();
-	sk = rcu_dereference(ps->sk);
+	sk = pppol2tp_session_get_sock(session);
 	if (!sk)
 		goto no_sock;
 
@@ -528,13 +517,14 @@ static void pppol2tp_show(struct seq_file *m, void *arg)
 	struct l2tp_session *session = arg;
 	struct sock *sk;
 
+	rcu_read_lock();
 	sk = pppol2tp_session_get_sock(session);
 	if (sk) {
 		struct pppox_sock *po = pppox_sk(sk);
 
 		seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
-		sock_put(sk);
 	}
+	rcu_read_unlock();
 }
 
 static void pppol2tp_session_init(struct l2tp_session *session)
@@ -1540,6 +1530,7 @@ static void pppol2tp_seq_session_show(struct seq_file *m, void *v)
 		port = ntohs(inet->inet_sport);
 	}
 
+	rcu_read_lock();
 	sk = pppol2tp_session_get_sock(session);
 	if (sk) {
 		state = sk->sk_state;
@@ -1575,8 +1566,8 @@ static void pppol2tp_seq_session_show(struct seq_file *m, void *v)
 		struct pppox_sock *po = pppox_sk(sk);
 
 		seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
-		sock_put(sk);
 	}
+	rcu_read_unlock();
 }
 
 static int pppol2tp_seq_show(struct seq_file *m, void *v)
-- 
2.43.0


