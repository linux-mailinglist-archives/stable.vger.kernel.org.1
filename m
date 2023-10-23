Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939817D332C
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjJWL11 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjJWL10 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:27:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B2992
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:27:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A94C433C9;
        Mon, 23 Oct 2023 11:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060442;
        bh=HNmHE/yWoKjc1ZTlM+AFIppfzACFHpG8O14uLhKGG50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xPg0joR22MkfH/itRuFwA/wnZhTTuX3xtYDi6g9qyTrJG70F3Ze4imshpq6eFmCVu
         ZZ9LmjjiLYYLu2XfIYx+Vuk97Xvjhb0OKOOgZ9b2OYiE6yKrXYl3mGWcMwfpIrglzQ
         ylvKn53LOudB7OtaQapGUR4mwu5wY43SbHINRf2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Deseyn <tdeseyn@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 136/196] tcp: allow again tcp_disconnect() when threads are waiting
Date:   Mon, 23 Oct 2023 12:56:41 +0200
Message-ID: <20231023104832.331189116@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 419ce133ab928ab5efd7b50b2ef36ddfd4eadbd2 ]

As reported by Tom, .NET and applications build on top of it rely
on connect(AF_UNSPEC) to async cancel pending I/O operations on TCP
socket.

The blamed commit below caused a regression, as such cancellation
can now fail.

As suggested by Eric, this change addresses the problem explicitly
causing blocking I/O operation to terminate immediately (with an error)
when a concurrent disconnect() is executed.

Instead of tracking the number of threads blocked on a given socket,
track the number of disconnect() issued on such socket. If such counter
changes after a blocking operation releasing and re-acquiring the socket
lock, error out the current operation.

Fixes: 4faeee0cf8a5 ("tcp: deny tcp_disconnect() when threads are waiting")
Reported-by: Tom Deseyn <tdeseyn@redhat.com>
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=1886305
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../chelsio/inline_crypto/chtls/chtls_io.c    | 36 +++++++++++++++----
 include/net/sock.h                            | 10 +++---
 net/core/stream.c                             | 12 ++++---
 net/ipv4/af_inet.c                            | 10 ++++--
 net/ipv4/inet_connection_sock.c               |  1 -
 net/ipv4/tcp.c                                | 16 ++++-----
 net/ipv4/tcp_bpf.c                            |  4 +++
 net/mptcp/protocol.c                          |  7 ----
 net/tls/tls_main.c                            | 10 ++++--
 net/tls/tls_sw.c                              | 19 ++++++----
 10 files changed, 80 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
index a4256087ac828..5e45bef4fd34f 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
@@ -911,7 +911,7 @@ static int csk_wait_memory(struct chtls_dev *cdev,
 			   struct sock *sk, long *timeo_p)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
-	int err = 0;
+	int ret, err = 0;
 	long current_timeo;
 	long vm_wait = 0;
 	bool noblock;
@@ -942,10 +942,13 @@ static int csk_wait_memory(struct chtls_dev *cdev,
 
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		sk->sk_write_pending++;
-		sk_wait_event(sk, &current_timeo, sk->sk_err ||
-			      (sk->sk_shutdown & SEND_SHUTDOWN) ||
-			      (csk_mem_free(cdev, sk) && !vm_wait), &wait);
+		ret = sk_wait_event(sk, &current_timeo, sk->sk_err ||
+				    (sk->sk_shutdown & SEND_SHUTDOWN) ||
+				    (csk_mem_free(cdev, sk) && !vm_wait),
+				    &wait);
 		sk->sk_write_pending--;
+		if (ret < 0)
+			goto do_error;
 
 		if (vm_wait) {
 			vm_wait -= current_timeo;
@@ -1438,6 +1441,7 @@ static int chtls_pt_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int copied = 0;
 	int target;
 	long timeo;
+	int ret;
 
 	buffers_freed = 0;
 
@@ -1513,7 +1517,11 @@ static int chtls_pt_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		if (copied >= target)
 			break;
 		chtls_cleanup_rbuf(sk, copied);
-		sk_wait_data(sk, &timeo, NULL);
+		ret = sk_wait_data(sk, &timeo, NULL);
+		if (ret < 0) {
+			copied = copied ? : ret;
+			goto unlock;
+		}
 		continue;
 found_ok_skb:
 		if (!skb->len) {
@@ -1608,6 +1616,8 @@ static int chtls_pt_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 	if (buffers_freed)
 		chtls_cleanup_rbuf(sk, copied);
+
+unlock:
 	release_sock(sk);
 	return copied;
 }
@@ -1624,6 +1634,7 @@ static int peekmsg(struct sock *sk, struct msghdr *msg,
 	int copied = 0;
 	size_t avail;          /* amount of available data in current skb */
 	long timeo;
+	int ret;
 
 	lock_sock(sk);
 	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
@@ -1675,7 +1686,12 @@ static int peekmsg(struct sock *sk, struct msghdr *msg,
 			release_sock(sk);
 			lock_sock(sk);
 		} else {
-			sk_wait_data(sk, &timeo, NULL);
+			ret = sk_wait_data(sk, &timeo, NULL);
+			if (ret < 0) {
+				/* here 'copied' is 0 due to previous checks */
+				copied = ret;
+				break;
+			}
 		}
 
 		if (unlikely(peek_seq != tp->copied_seq)) {
@@ -1746,6 +1762,7 @@ int chtls_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int copied = 0;
 	long timeo;
 	int target;             /* Read at least this many bytes */
+	int ret;
 
 	buffers_freed = 0;
 
@@ -1837,7 +1854,11 @@ int chtls_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		if (copied >= target)
 			break;
 		chtls_cleanup_rbuf(sk, copied);
-		sk_wait_data(sk, &timeo, NULL);
+		ret = sk_wait_data(sk, &timeo, NULL);
+		if (ret < 0) {
+			copied = copied ? : ret;
+			goto unlock;
+		}
 		continue;
 
 found_ok_skb:
@@ -1906,6 +1927,7 @@ int chtls_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	if (buffers_freed)
 		chtls_cleanup_rbuf(sk, copied);
 
+unlock:
 	release_sock(sk);
 	return copied;
 }
diff --git a/include/net/sock.h b/include/net/sock.h
index 4c988b981d6e1..579c89eb7c5ca 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -333,7 +333,7 @@ struct sk_filter;
   *	@sk_cgrp_data: cgroup data for this cgroup
   *	@sk_memcg: this socket's memory cgroup association
   *	@sk_write_pending: a write to stream socket waits to start
-  *	@sk_wait_pending: number of threads blocked on this socket
+  *	@sk_disconnects: number of disconnect operations performed on this sock
   *	@sk_state_change: callback to indicate change in the state of the sock
   *	@sk_data_ready: callback to indicate there is data to be processed
   *	@sk_write_space: callback to indicate there is bf sending space available
@@ -426,7 +426,7 @@ struct sock {
 	unsigned int		sk_napi_id;
 #endif
 	int			sk_rcvbuf;
-	int			sk_wait_pending;
+	int			sk_disconnects;
 
 	struct sk_filter __rcu	*sk_filter;
 	union {
@@ -1185,8 +1185,7 @@ static inline void sock_rps_reset_rxhash(struct sock *sk)
 }
 
 #define sk_wait_event(__sk, __timeo, __condition, __wait)		\
-	({	int __rc;						\
-		__sk->sk_wait_pending++;				\
+	({	int __rc, __dis = __sk->sk_disconnects;			\
 		release_sock(__sk);					\
 		__rc = __condition;					\
 		if (!__rc) {						\
@@ -1196,8 +1195,7 @@ static inline void sock_rps_reset_rxhash(struct sock *sk)
 		}							\
 		sched_annotate_sleep();					\
 		lock_sock(__sk);					\
-		__sk->sk_wait_pending--;				\
-		__rc = __condition;					\
+		__rc = __dis == __sk->sk_disconnects ? __condition : -EPIPE; \
 		__rc;							\
 	})
 
diff --git a/net/core/stream.c b/net/core/stream.c
index 5b05b889d31af..051aa71a8ad0f 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -117,7 +117,7 @@ EXPORT_SYMBOL(sk_stream_wait_close);
  */
 int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 {
-	int err = 0;
+	int ret, err = 0;
 	long vm_wait = 0;
 	long current_timeo = *timeo_p;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
@@ -142,11 +142,13 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		sk->sk_write_pending++;
-		sk_wait_event(sk, &current_timeo, READ_ONCE(sk->sk_err) ||
-						  (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) ||
-						  (sk_stream_memory_free(sk) &&
-						  !vm_wait), &wait);
+		ret = sk_wait_event(sk, &current_timeo, READ_ONCE(sk->sk_err) ||
+				    (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) ||
+				    (sk_stream_memory_free(sk) && !vm_wait),
+				    &wait);
 		sk->sk_write_pending--;
+		if (ret < 0)
+			goto do_error;
 
 		if (vm_wait) {
 			vm_wait -= current_timeo;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 04853c83c85c4..5d379df90c826 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -589,7 +589,6 @@ static long inet_wait_for_connect(struct sock *sk, long timeo, int writebias)
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	sk->sk_write_pending += writebias;
-	sk->sk_wait_pending++;
 
 	/* Basic assumption: if someone sets sk->sk_err, he _must_
 	 * change state of the socket from TCP_SYN_*.
@@ -605,7 +604,6 @@ static long inet_wait_for_connect(struct sock *sk, long timeo, int writebias)
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
 	sk->sk_write_pending -= writebias;
-	sk->sk_wait_pending--;
 	return timeo;
 }
 
@@ -634,6 +632,7 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 			return -EINVAL;
 
 		if (uaddr->sa_family == AF_UNSPEC) {
+			sk->sk_disconnects++;
 			err = sk->sk_prot->disconnect(sk, flags);
 			sock->state = err ? SS_DISCONNECTING : SS_UNCONNECTED;
 			goto out;
@@ -688,6 +687,7 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		int writebias = (sk->sk_protocol == IPPROTO_TCP) &&
 				tcp_sk(sk)->fastopen_req &&
 				tcp_sk(sk)->fastopen_req->data ? 1 : 0;
+		int dis = sk->sk_disconnects;
 
 		/* Error code is set above */
 		if (!timeo || !inet_wait_for_connect(sk, timeo, writebias))
@@ -696,6 +696,11 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		err = sock_intr_errno(timeo);
 		if (signal_pending(current))
 			goto out;
+
+		if (dis != sk->sk_disconnects) {
+			err = -EPIPE;
+			goto out;
+		}
 	}
 
 	/* Connection was closed by RST, timeout, ICMP error
@@ -717,6 +722,7 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 sock_error:
 	err = sock_error(sk) ? : -ECONNABORTED;
 	sock->state = SS_UNCONNECTED;
+	sk->sk_disconnects++;
 	if (sk->sk_prot->disconnect(sk, flags))
 		sock->state = SS_DISCONNECTING;
 	goto out;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 62a3b103f258a..80ce0112e24b4 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1143,7 +1143,6 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 	if (newsk) {
 		struct inet_connection_sock *newicsk = inet_csk(newsk);
 
-		newsk->sk_wait_pending = 0;
 		inet_sk_set_state(newsk, TCP_SYN_RECV);
 		newicsk->icsk_bind_hash = NULL;
 		newicsk->icsk_bind2_hash = NULL;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 96fdde6e42b1b..288678f17ccaf 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -827,7 +827,9 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 			 */
 			if (!skb_queue_empty(&sk->sk_receive_queue))
 				break;
-			sk_wait_data(sk, &timeo, NULL);
+			ret = sk_wait_data(sk, &timeo, NULL);
+			if (ret < 0)
+				break;
 			if (signal_pending(current)) {
 				ret = sock_intr_errno(timeo);
 				break;
@@ -2549,7 +2551,11 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 			__sk_flush_backlog(sk);
 		} else {
 			tcp_cleanup_rbuf(sk, copied);
-			sk_wait_data(sk, &timeo, last);
+			err = sk_wait_data(sk, &timeo, last);
+			if (err < 0) {
+				err = copied ? : err;
+				goto out;
+			}
 		}
 
 		if ((flags & MSG_PEEK) &&
@@ -3073,12 +3079,6 @@ int tcp_disconnect(struct sock *sk, int flags)
 	int old_state = sk->sk_state;
 	u32 seq;
 
-	/* Deny disconnect if other threads are blocked in sk_wait_event()
-	 * or inet_wait_for_connect().
-	 */
-	if (sk->sk_wait_pending)
-		return -EBUSY;
-
 	if (old_state != TCP_CLOSE)
 		tcp_set_state(sk, TCP_CLOSE);
 
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index f53380fd89bcf..cb4549db8bcfc 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -302,6 +302,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		}
 
 		data = tcp_msg_wait_data(sk, psock, timeo);
+		if (data < 0)
+			return data;
 		if (data && !sk_psock_queue_empty(psock))
 			goto msg_bytes_ready;
 		copied = -EAGAIN;
@@ -346,6 +348,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 		data = tcp_msg_wait_data(sk, psock, timeo);
+		if (data < 0)
+			return data;
 		if (data) {
 			if (!sk_psock_queue_empty(psock))
 				goto msg_bytes_ready;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9d67f2e4d4a6e..e061091edb394 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3101,12 +3101,6 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	/* Deny disconnect if other threads are blocked in sk_wait_event()
-	 * or inet_wait_for_connect().
-	 */
-	if (sk->sk_wait_pending)
-		return -EBUSY;
-
 	/* We are on the fastopen error path. We can't call straight into the
 	 * subflows cleanup code due to lock nesting (we are already under
 	 * msk->firstsocket lock).
@@ -3174,7 +3168,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 		inet_sk(nsk)->pinet6 = mptcp_inet6_sk(nsk);
 #endif
 
-	nsk->sk_wait_pending = 0;
 	__mptcp_init_sock(nsk);
 
 	msk = mptcp_sk(nsk);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index f2e7302a4d96b..338a443fa47b2 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -96,8 +96,8 @@ void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 
 int wait_on_pending_writer(struct sock *sk, long *timeo)
 {
-	int rc = 0;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
+	int ret, rc = 0;
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	while (1) {
@@ -111,9 +111,13 @@ int wait_on_pending_writer(struct sock *sk, long *timeo)
 			break;
 		}
 
-		if (sk_wait_event(sk, timeo,
-				  !READ_ONCE(sk->sk_write_pending), &wait))
+		ret = sk_wait_event(sk, timeo,
+				    !READ_ONCE(sk->sk_write_pending), &wait);
+		if (ret) {
+			if (ret < 0)
+				rc = ret;
 			break;
+		}
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
 	return rc;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index c5c8fdadc05e8..2af72d349192e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1296,6 +1296,7 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
+	int ret = 0;
 	long timeo;
 
 	timeo = sock_rcvtimeo(sk, nonblock);
@@ -1307,6 +1308,9 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		if (sk->sk_err)
 			return sock_error(sk);
 
+		if (ret < 0)
+			return ret;
+
 		if (!skb_queue_empty(&sk->sk_receive_queue)) {
 			tls_strp_check_rcv(&ctx->strp);
 			if (tls_strp_msg_ready(ctx))
@@ -1325,10 +1329,10 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		released = true;
 		add_wait_queue(sk_sleep(sk), &wait);
 		sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
-		sk_wait_event(sk, &timeo,
-			      tls_strp_msg_ready(ctx) ||
-			      !sk_psock_queue_empty(psock),
-			      &wait);
+		ret = sk_wait_event(sk, &timeo,
+				    tls_strp_msg_ready(ctx) ||
+				    !sk_psock_queue_empty(psock),
+				    &wait);
 		sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 		remove_wait_queue(sk_sleep(sk), &wait);
 
@@ -1855,6 +1859,7 @@ static int tls_rx_reader_acquire(struct sock *sk, struct tls_sw_context_rx *ctx,
 				 bool nonblock)
 {
 	long timeo;
+	int ret;
 
 	timeo = sock_rcvtimeo(sk, nonblock);
 
@@ -1864,14 +1869,16 @@ static int tls_rx_reader_acquire(struct sock *sk, struct tls_sw_context_rx *ctx,
 		ctx->reader_contended = 1;
 
 		add_wait_queue(&ctx->wq, &wait);
-		sk_wait_event(sk, &timeo,
-			      !READ_ONCE(ctx->reader_present), &wait);
+		ret = sk_wait_event(sk, &timeo,
+				    !READ_ONCE(ctx->reader_present), &wait);
 		remove_wait_queue(&ctx->wq, &wait);
 
 		if (timeo <= 0)
 			return -EAGAIN;
 		if (signal_pending(current))
 			return sock_intr_errno(timeo);
+		if (ret < 0)
+			return ret;
 	}
 
 	WRITE_ONCE(ctx->reader_present, 1);
-- 
2.40.1



