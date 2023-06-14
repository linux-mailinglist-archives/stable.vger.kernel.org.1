Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805E2713ED1
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjE1TjL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjE1TjK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:39:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACB2A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:39:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D196061E8C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB78C433EF;
        Sun, 28 May 2023 19:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302748;
        bh=A4waAL9MxczKJridCbNjChRcVNKrUMwYnJJGiEIFniI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjrvgT0THKlOq6pw8AGbZwX2U2Je6jWzepZWF0b/QlY61aJt56e1c5pKqO7lhyJh9
         XmubRp7SO3caKwoY56Vf8CNF8/A5gOZqQtU6vNocOXpLHD+LpRVxP7Sh+HwEPngCKX
         KpXv2zgvv0WW2WmL//EIEhQGYZsCZ7MkFGmeDQ0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 010/211] net: deal with most data-races in sk_wait_event()
Date:   Sun, 28 May 2023 20:08:51 +0100
Message-Id: <20230528190843.778835720@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit d0ac89f6f9879fae316c155de77b5173b3e2c9c9 ]

__condition is evaluated twice in sk_wait_event() macro.

First invocation is lockless, and reads can race with writes,
as spotted by syzbot.

BUG: KCSAN: data-race in sk_stream_wait_connect / tcp_disconnect

write to 0xffff88812d83d6a0 of 4 bytes by task 9065 on cpu 1:
tcp_disconnect+0x2cd/0xdb0
inet_shutdown+0x19e/0x1f0 net/ipv4/af_inet.c:911
__sys_shutdown_sock net/socket.c:2343 [inline]
__sys_shutdown net/socket.c:2355 [inline]
__do_sys_shutdown net/socket.c:2363 [inline]
__se_sys_shutdown+0xf8/0x140 net/socket.c:2361
__x64_sys_shutdown+0x31/0x40 net/socket.c:2361
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff88812d83d6a0 of 4 bytes by task 9040 on cpu 0:
sk_stream_wait_connect+0x1de/0x3a0 net/core/stream.c:75
tcp_sendmsg_locked+0x2e4/0x2120 net/ipv4/tcp.c:1266
tcp_sendmsg+0x30/0x50 net/ipv4/tcp.c:1484
inet6_sendmsg+0x63/0x80 net/ipv6/af_inet6.c:651
sock_sendmsg_nosec net/socket.c:724 [inline]
sock_sendmsg net/socket.c:747 [inline]
__sys_sendto+0x246/0x300 net/socket.c:2142
__do_sys_sendto net/socket.c:2154 [inline]
__se_sys_sendto net/socket.c:2150 [inline]
__x64_sys_sendto+0x78/0x90 net/socket.c:2150
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00000000 -> 0x00000068

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/stream.c   | 12 ++++++------
 net/ipv4/tcp_bpf.c  |  2 +-
 net/llc/af_llc.c    |  8 +++++---
 net/smc/smc_close.c |  4 ++--
 net/smc/smc_rx.c    |  4 ++--
 net/smc/smc_tx.c    |  4 ++--
 net/tipc/socket.c   |  4 ++--
 net/tls/tls_main.c  |  3 ++-
 8 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/net/core/stream.c b/net/core/stream.c
index cd60746877b1e..422ee97e4f2be 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -73,8 +73,8 @@ int sk_stream_wait_connect(struct sock *sk, long *timeo_p)
 		add_wait_queue(sk_sleep(sk), &wait);
 		sk->sk_write_pending++;
 		done = sk_wait_event(sk, timeo_p,
-				     !sk->sk_err &&
-				     !((1 << sk->sk_state) &
+				     !READ_ONCE(sk->sk_err) &&
+				     !((1 << READ_ONCE(sk->sk_state)) &
 				       ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)), &wait);
 		remove_wait_queue(sk_sleep(sk), &wait);
 		sk->sk_write_pending--;
@@ -87,9 +87,9 @@ EXPORT_SYMBOL(sk_stream_wait_connect);
  * sk_stream_closing - Return 1 if we still have things to send in our buffers.
  * @sk: socket to verify
  */
-static inline int sk_stream_closing(struct sock *sk)
+static int sk_stream_closing(const struct sock *sk)
 {
-	return (1 << sk->sk_state) &
+	return (1 << READ_ONCE(sk->sk_state)) &
 	       (TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK);
 }
 
@@ -142,8 +142,8 @@ int sk_stream_wait_memory(struct sock *sk, long *timeo_p)
 
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		sk->sk_write_pending++;
-		sk_wait_event(sk, &current_timeo, sk->sk_err ||
-						  (sk->sk_shutdown & SEND_SHUTDOWN) ||
+		sk_wait_event(sk, &current_timeo, READ_ONCE(sk->sk_err) ||
+						  (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) ||
 						  (sk_stream_memory_free(sk) &&
 						  !vm_wait), &wait);
 		sk->sk_write_pending--;
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 926e29e84b40b..d0ca1fc325cd6 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -262,7 +262,7 @@ static int tcp_bpf_wait_data(struct sock *sk, struct sk_psock *psock,
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	ret = sk_wait_event(sk, &timeo,
 			    !list_empty(&psock->ingress_msg) ||
-			    !skb_queue_empty(&sk->sk_receive_queue), &wait);
+			    !skb_queue_empty_lockless(&sk->sk_receive_queue), &wait);
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	remove_wait_queue(sk_sleep(sk), &wait);
 	return ret;
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 99a37c411323e..01e26698285a0 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -582,7 +582,8 @@ static int llc_ui_wait_for_disc(struct sock *sk, long timeout)
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	while (1) {
-		if (sk_wait_event(sk, &timeout, sk->sk_state == TCP_CLOSE, &wait))
+		if (sk_wait_event(sk, &timeout,
+				  READ_ONCE(sk->sk_state) == TCP_CLOSE, &wait))
 			break;
 		rc = -ERESTARTSYS;
 		if (signal_pending(current))
@@ -602,7 +603,8 @@ static bool llc_ui_wait_for_conn(struct sock *sk, long timeout)
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	while (1) {
-		if (sk_wait_event(sk, &timeout, sk->sk_state != TCP_SYN_SENT, &wait))
+		if (sk_wait_event(sk, &timeout,
+				  READ_ONCE(sk->sk_state) != TCP_SYN_SENT, &wait))
 			break;
 		if (signal_pending(current) || !timeout)
 			break;
@@ -621,7 +623,7 @@ static int llc_ui_wait_for_busy_core(struct sock *sk, long timeout)
 	while (1) {
 		rc = 0;
 		if (sk_wait_event(sk, &timeout,
-				  (sk->sk_shutdown & RCV_SHUTDOWN) ||
+				  (READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN) ||
 				  (!llc_data_accept_state(llc->state) &&
 				   !llc->remote_busy_flag &&
 				   !llc->p_flag), &wait))
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 84102db5bb314..149a59ecd299f 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -64,8 +64,8 @@ static void smc_close_stream_wait(struct smc_sock *smc, long timeout)
 
 		rc = sk_wait_event(sk, &timeout,
 				   !smc_tx_prepared_sends(&smc->conn) ||
-				   sk->sk_err == ECONNABORTED ||
-				   sk->sk_err == ECONNRESET ||
+				   READ_ONCE(sk->sk_err) == ECONNABORTED ||
+				   READ_ONCE(sk->sk_err) == ECONNRESET ||
 				   smc->conn.killed,
 				   &wait);
 		if (rc)
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index 7f7e983e42b1f..3757aff6c2f00 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -203,9 +203,9 @@ int smc_rx_wait(struct smc_sock *smc, long *timeo,
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 	add_wait_queue(sk_sleep(sk), &wait);
 	rc = sk_wait_event(sk, timeo,
-			   sk->sk_err ||
+			   READ_ONCE(sk->sk_err) ||
 			   cflags->peer_conn_abort ||
-			   sk->sk_shutdown & RCV_SHUTDOWN ||
+			   READ_ONCE(sk->sk_shutdown) & RCV_SHUTDOWN ||
 			   conn->killed ||
 			   fcrit(conn),
 			   &wait);
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 52ef1fca0b604..2429f9fc7e0e7 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -110,8 +110,8 @@ static int smc_tx_wait(struct smc_sock *smc, int flags)
 			break; /* at least 1 byte of free & no urgent data */
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		sk_wait_event(sk, &timeo,
-			      sk->sk_err ||
-			      (sk->sk_shutdown & SEND_SHUTDOWN) ||
+			      READ_ONCE(sk->sk_err) ||
+			      (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) ||
 			      smc_cdc_rxed_any_close(conn) ||
 			      (atomic_read(&conn->sndbuf_space) &&
 			       !conn->urg_tx_pend),
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 8f3c9fbb99165..7cf9b40b5c73b 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -300,9 +300,9 @@ static void tsk_rej_rx_queue(struct sock *sk, int error)
 		tipc_sk_respond(sk, skb, error);
 }
 
-static bool tipc_sk_connected(struct sock *sk)
+static bool tipc_sk_connected(const struct sock *sk)
 {
-	return sk->sk_state == TIPC_ESTABLISHED;
+	return READ_ONCE(sk->sk_state) == TIPC_ESTABLISHED;
 }
 
 /* tipc_sk_type_connectionless - check if the socket is datagram socket
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 54863e68f3040..7ee3c8b03a39e 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -92,7 +92,8 @@ int wait_on_pending_writer(struct sock *sk, long *timeo)
 			break;
 		}
 
-		if (sk_wait_event(sk, timeo, !sk->sk_write_pending, &wait))
+		if (sk_wait_event(sk, timeo,
+				  !READ_ONCE(sk->sk_write_pending), &wait))
 			break;
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
-- 
2.39.2



