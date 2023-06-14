Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF7D713CA5
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjE1TRI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjE1TRH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:17:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DCFC7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:17:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C37D6619F4
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC3FC433EF;
        Sun, 28 May 2023 19:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301425;
        bh=bN2OnKpDZZ9+CrI4lHmo5+AvQeqTs36xvbLCCHBIB3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GyV9J9fA9tZfCQMInHlSiYk75Z1kk+F8QCJ5rVbASNkU2dHkpE7tEluP4wGYUPT6y
         DGfq5dRvisxAzH9w+fJMQ4PF42ixw+bvIR/+KwEnLnV2bzTyF+89+X3m0UTU/NG75m
         4RV+c+k0728sQ6uD+jWuydKY6zXub/WAlL8InoDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 007/132] tcp: add annotations around sk->sk_shutdown accesses
Date:   Sun, 28 May 2023 20:09:06 +0100
Message-Id: <20230528190833.796784836@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
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

[ Upstream commit e14cadfd80d76f01bfaa1a8d745b1db19b57d6be ]

Now sk->sk_shutdown is no longer a bitfield, we can add
standard READ_ONCE()/WRITE_ONCE() annotations to silence
KCSAN reports like the following:

BUG: KCSAN: data-race in tcp_disconnect / tcp_poll

write to 0xffff88814588582c of 1 bytes by task 3404 on cpu 1:
tcp_disconnect+0x4d6/0xdb0 net/ipv4/tcp.c:3121
__inet_stream_connect+0x5dd/0x6e0 net/ipv4/af_inet.c:715
inet_stream_connect+0x48/0x70 net/ipv4/af_inet.c:727
__sys_connect_file net/socket.c:2001 [inline]
__sys_connect+0x19b/0x1b0 net/socket.c:2018
__do_sys_connect net/socket.c:2028 [inline]
__se_sys_connect net/socket.c:2025 [inline]
__x64_sys_connect+0x41/0x50 net/socket.c:2025
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff88814588582c of 1 bytes by task 3374 on cpu 0:
tcp_poll+0x2e6/0x7d0 net/ipv4/tcp.c:562
sock_poll+0x253/0x270 net/socket.c:1383
vfs_poll include/linux/poll.h:88 [inline]
io_poll_check_events io_uring/poll.c:281 [inline]
io_poll_task_func+0x15a/0x820 io_uring/poll.c:333
handle_tw_list io_uring/io_uring.c:1184 [inline]
tctx_task_work+0x1fe/0x4d0 io_uring/io_uring.c:1246
task_work_run+0x123/0x160 kernel/task_work.c:179
get_signal+0xe64/0xff0 kernel/signal.c:2635
arch_do_signal_or_restart+0x89/0x2a0 arch/x86/kernel/signal.c:306
exit_to_user_mode_loop+0x6f/0xe0 kernel/entry/common.c:168
exit_to_user_mode_prepare+0x6c/0xb0 kernel/entry/common.c:204
__syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:297
do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x03 -> 0x00

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/af_inet.c   |  2 +-
 net/ipv4/tcp.c       | 14 ++++++++------
 net/ipv4/tcp_input.c |  4 ++--
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 4b26ae525d6d2..fb142ea730060 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -865,7 +865,7 @@ int inet_shutdown(struct socket *sock, int how)
 		   EPOLLHUP, even on eg. unconnected UDP sockets -- RR */
 		/* fall through */
 	default:
-		sk->sk_shutdown |= how;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | how);
 		if (sk->sk_prot->shutdown)
 			sk->sk_prot->shutdown(sk, how);
 		break;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 9200e7330b7d6..b51e0a1e15b67 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -515,6 +515,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 	__poll_t mask;
 	struct sock *sk = sock->sk;
 	const struct tcp_sock *tp = tcp_sk(sk);
+	u8 shutdown;
 	int state;
 
 	sock_poll_wait(file, sock, wait);
@@ -557,9 +558,10 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 	 * NOTE. Check for TCP_CLOSE is added. The goal is to prevent
 	 * blocking on fresh not-connected or disconnected socket. --ANK
 	 */
-	if (sk->sk_shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
+	shutdown = READ_ONCE(sk->sk_shutdown);
+	if (shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
 		mask |= EPOLLHUP;
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
+	if (shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	/* Connected or passive Fast Open socket? */
@@ -575,7 +577,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 		if (tcp_stream_is_readable(tp, target, sk))
 			mask |= EPOLLIN | EPOLLRDNORM;
 
-		if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
+		if (!(shutdown & SEND_SHUTDOWN)) {
 			if (__sk_stream_is_writeable(sk, 1)) {
 				mask |= EPOLLOUT | EPOLLWRNORM;
 			} else {  /* send SIGIO later */
@@ -2344,7 +2346,7 @@ void __tcp_close(struct sock *sk, long timeout)
 	int data_was_unread = 0;
 	int state;
 
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if (sk->sk_state == TCP_LISTEN) {
 		tcp_set_state(sk, TCP_CLOSE);
@@ -2598,7 +2600,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK))
 		inet_reset_saddr(sk);
 
-	sk->sk_shutdown = 0;
+	WRITE_ONCE(sk->sk_shutdown, 0);
 	sock_reset_flag(sk, SOCK_DONE);
 	tp->srtt_us = 0;
 	tp->rcv_rtt_last_tsecr = 0;
@@ -3807,7 +3809,7 @@ void tcp_done(struct sock *sk)
 	if (req)
 		reqsk_fastopen_remove(sk, req, false);
 
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if (!sock_flag(sk, SOCK_DEAD))
 		sk->sk_state_change(sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 11716780667c7..bd921fa7b9ab4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4130,7 +4130,7 @@ void tcp_fin(struct sock *sk)
 
 	inet_csk_schedule_ack(sk);
 
-	sk->sk_shutdown |= RCV_SHUTDOWN;
+	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 	sock_set_flag(sk, SOCK_DONE);
 
 	switch (sk->sk_state) {
@@ -6209,7 +6209,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			break;
 
 		tcp_set_state(sk, TCP_FIN_WAIT2);
-		sk->sk_shutdown |= SEND_SHUTDOWN;
+		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | SEND_SHUTDOWN);
 
 		sk_dst_confirm(sk);
 
-- 
2.39.2



