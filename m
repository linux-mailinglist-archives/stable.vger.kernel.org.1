Return-Path: <stable+bounces-36132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C517089A16C
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 17:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B11288858
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 15:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68D16FF4A;
	Fri,  5 Apr 2024 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmPF85Ju"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE416FF28;
	Fri,  5 Apr 2024 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331440; cv=none; b=F8jnDCAi9pnpCY6ldlDeaXqxtD6w+ySf7nHiUxUxv9pz1EN0ajTV6op7a7nVfINF+87r+LjHHu/m01miUkK8K0LSIbDI9H0V/NflSOPBO//5Xg+xOjjTGTQnaHip4vftQ1O4Tkm9x5lvnD48ZcV0aEkuRfCAcFoAyqJJijTHA9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331440; c=relaxed/simple;
	bh=m+g/1J67zio9wN0NfuO0O4dSo48GL8W4ydJEVJMQ1lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifuOs9P/NymkCuBlLbXoF0hspRRCjUTwL6ymylRjtAeBogbVXVm6yfnf/KdgMF7AVnG2XOFRIER6wFEhPTj/GqRemMT6ogRYrLDK45Tpcu2EeDHckOb3igYl/vBmk/WSEs5t+n89nnViWF3IYZZRGFBGjjuyAJ27qRy86im8czg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmPF85Ju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FBCC43390;
	Fri,  5 Apr 2024 15:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712331440;
	bh=m+g/1J67zio9wN0NfuO0O4dSo48GL8W4ydJEVJMQ1lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AmPF85Jukps3pnnrAPZB0ycLTnaWDSPtSevdEpRvUH23Rqs9HWNh+6XreAsTIkhoz
	 TpTtl0XZ0/2m2W7iQvSX84QzyZKSHds4TgdTHAJXWjJkcLC+twhBENLu+RVa3c7cB9
	 3whtJsjAGcPbxhIjfNEfPVZCOwO0Yf6PAdlhK7AXrpkOhM6FiKwRQVTRqL7vkxMeq4
	 f2B0xl2Vt4QvA/3IN6CNcxVc3VOOgRBXewe8DmcAQMakK8b3qvLEkWqkjEPLhHkHop
	 pd5IdSemHFoS+3HK8k0+gQDM95zhY61FdEd5AaKjV2z86nnicl7Bfxzz4dNGeDZXjA
	 0mL7Fh9x5Et8A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Davide Caratti <dcaratti@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.6.y 4/5] mptcp: don't overwrite sock_ops in mptcp_is_tcpsk()
Date: Fri,  5 Apr 2024 17:36:41 +0200
Message-ID: <20240405153636.958019-11-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024040520-unselect-antitrust-a41b@gregkh>
References: <2024040520-unselect-antitrust-a41b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5927; i=matttbe@kernel.org; h=from:subject; bh=iTs5xbAk9YwWpx5D9PysrNCF3YRBpxZzHd0QEqWsR4A=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmEBqFvQUXso8lcDC2qbkiaf+1ck9HNJM4Lb2+D XCQ2UoUOGKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhAahQAKCRD2t4JPQmmg c/lKD/9Av/51tUvNE51/Ph63liQnuRvtHu3cgbHstjk7zG6PT+KMuE5wqCX4yp3zgkndTU95oDu PsIYDirpZIgbyQzsP9g07vqkxArXuEh3SItsQCTlXPW31RJEHE72vMlkoF+aWJIS+ja1AiybtY0 G7jSYm3lRkjq1Psovd8vKc6148Ipr5wwEEIhAhbg1RGtTtJOYF+0FtA1cQvIAXUeJVbrrE22hfx 1xuhPnvDrNVjsFzECDumAEEjol8g/2TOALaIQfPp493DRv0uWO9RfHyjp6GprGOLXZeTcXnSnzs 3ZBLKPeNm7E8RmgIOo10YWVJksvj9Y366UqcQPBY+SjVse3Ar8YWNO60RIwqjz24YfOTDfmoAlG 1QCu0O5n9/aslYfADUOKlaHiDmzlBbbqKpC0wqZ7VihydXIXCEe/H6Vc5ryZzzEbrF7xWX3Vr4k PCnc+ta0nsVmw8KcO7vjWNQMiE+SNENSI0cJS1bZsnwwNhyueN7WhBCccccA38i5C4X/WYlfIxU twSjWy39RnY12wUd86OPg/sxj8GMGY1TLtmNvwL3pvtYjB+9aPr7XXuSCxzWfgqE0UGg6x37kKC OM9pGIjSFfKHKT85TY+jgs5Rq8FQ3K7niEgBAnGdFWdLOZs+KGXtM4hzfu4Y/emZ3mXn/djupBS Z9Uep6zoz0O4rHw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Davide Caratti <dcaratti@redhat.com>

Eric Dumazet suggests:

 > The fact that mptcp_is_tcpsk() was able to write over sock->ops was a
 > bit strange to me.
 > mptcp_is_tcpsk() should answer a question, with a read-only argument.

re-factor code to avoid overwriting sock_ops inside that function. Also,
change the helper name to reflect the semantics and to disambiguate from
its dual, sk_is_mptcp(). While at it, collapse mptcp_stream_accept() and
mptcp_accept() into a single function, where fallback / non-fallback are
separated into a single sk_is_mptcp() conditional.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/432
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 8e2b8a9fa512709e6fee744dcd4e2a20ee7f5c56)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 108 ++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 64 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b54951ae07aa..35f9d59c8ded 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -55,28 +55,14 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 	return READ_ONCE(msk->wnd_end);
 }
 
-static bool mptcp_is_tcpsk(struct sock *sk)
+static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
 {
-	struct socket *sock = sk->sk_socket;
-
-	if (unlikely(sk->sk_prot == &tcp_prot)) {
-		/* we are being invoked after mptcp_accept() has
-		 * accepted a non-mp-capable flow: sk is a tcp_sk,
-		 * not an mptcp one.
-		 *
-		 * Hand the socket over to tcp so all further socket ops
-		 * bypass mptcp.
-		 */
-		WRITE_ONCE(sock->ops, &inet_stream_ops);
-		return true;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	} else if (unlikely(sk->sk_prot == &tcpv6_prot)) {
-		WRITE_ONCE(sock->ops, &inet6_stream_ops);
-		return true;
+	if (sk->sk_prot == &tcpv6_prot)
+		return &inet6_stream_ops;
 #endif
-	}
-
-	return false;
+	WARN_ON_ONCE(sk->sk_prot != &tcp_prot);
+	return &inet_stream_ops;
 }
 
 static int __mptcp_socket_create(struct mptcp_sock *msk)
@@ -3328,44 +3314,6 @@ void mptcp_rcv_space_init(struct mptcp_sock *msk, const struct sock *ssk)
 		msk->rcvq_space.space = TCP_INIT_CWND * TCP_MSS_DEFAULT;
 }
 
-static struct sock *mptcp_accept(struct sock *ssk, int flags, int *err,
-				 bool kern)
-{
-	struct sock *newsk;
-
-	pr_debug("ssk=%p, listener=%p", ssk, mptcp_subflow_ctx(ssk));
-	newsk = inet_csk_accept(ssk, flags, err, kern);
-	if (!newsk)
-		return NULL;
-
-	pr_debug("newsk=%p, subflow is mptcp=%d", newsk, sk_is_mptcp(newsk));
-	if (sk_is_mptcp(newsk)) {
-		struct mptcp_subflow_context *subflow;
-		struct sock *new_mptcp_sock;
-
-		subflow = mptcp_subflow_ctx(newsk);
-		new_mptcp_sock = subflow->conn;
-
-		/* is_mptcp should be false if subflow->conn is missing, see
-		 * subflow_syn_recv_sock()
-		 */
-		if (WARN_ON_ONCE(!new_mptcp_sock)) {
-			tcp_sk(newsk)->is_mptcp = 0;
-			goto out;
-		}
-
-		newsk = new_mptcp_sock;
-		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
-	} else {
-		MPTCP_INC_STATS(sock_net(ssk),
-				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
-	}
-
-out:
-	newsk->sk_kern_sock = kern;
-	return newsk;
-}
-
 void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
@@ -3802,7 +3750,6 @@ static struct proto mptcp_prot = {
 	.connect	= mptcp_connect,
 	.disconnect	= mptcp_disconnect,
 	.close		= mptcp_close,
-	.accept		= mptcp_accept,
 	.setsockopt	= mptcp_setsockopt,
 	.getsockopt	= mptcp_getsockopt,
 	.shutdown	= mptcp_shutdown,
@@ -3912,18 +3859,36 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 	if (!ssk)
 		return -EINVAL;
 
-	newsk = mptcp_accept(ssk, flags, &err, kern);
+	pr_debug("ssk=%p, listener=%p", ssk, mptcp_subflow_ctx(ssk));
+	newsk = inet_csk_accept(ssk, flags, &err, kern);
 	if (!newsk)
 		return err;
 
-	lock_sock(newsk);
-
-	__inet_accept(sock, newsock, newsk);
-	if (!mptcp_is_tcpsk(newsock->sk)) {
-		struct mptcp_sock *msk = mptcp_sk(newsk);
+	pr_debug("newsk=%p, subflow is mptcp=%d", newsk, sk_is_mptcp(newsk));
+	if (sk_is_mptcp(newsk)) {
 		struct mptcp_subflow_context *subflow;
+		struct sock *new_mptcp_sock;
+
+		subflow = mptcp_subflow_ctx(newsk);
+		new_mptcp_sock = subflow->conn;
+
+		/* is_mptcp should be false if subflow->conn is missing, see
+		 * subflow_syn_recv_sock()
+		 */
+		if (WARN_ON_ONCE(!new_mptcp_sock)) {
+			tcp_sk(newsk)->is_mptcp = 0;
+			goto tcpfallback;
+		}
+
+		newsk = new_mptcp_sock;
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEPASSIVEACK);
+
+		newsk->sk_kern_sock = kern;
+		lock_sock(newsk);
+		__inet_accept(sock, newsock, newsk);
 
 		set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
+		msk = mptcp_sk(newsk);
 		msk->in_accept_queue = 0;
 
 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
@@ -3945,6 +3910,21 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 			if (unlikely(list_is_singular(&msk->conn_list)))
 				mptcp_set_state(newsk, TCP_CLOSE);
 		}
+	} else {
+		MPTCP_INC_STATS(sock_net(ssk),
+				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
+tcpfallback:
+		newsk->sk_kern_sock = kern;
+		lock_sock(newsk);
+		__inet_accept(sock, newsock, newsk);
+		/* we are being invoked after accepting a non-mp-capable
+		 * flow: sk is a tcp_sk, not an mptcp one.
+		 *
+		 * Hand the socket over to tcp so all further socket ops
+		 * bypass mptcp.
+		 */
+		WRITE_ONCE(newsock->sk->sk_socket->ops,
+			   mptcp_fallback_tcp_ops(newsock->sk));
 	}
 	release_sock(newsk);
 
-- 
2.43.0


