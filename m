Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9553726E1F
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbjFGUsT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbjFGUsE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:48:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBAD2726
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:47:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ABC6646AD
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBDCC433D2;
        Wed,  7 Jun 2023 20:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170858;
        bh=p/tvNWXirCDWcYY56wpoFac2wuwR8Oni5/EH/+WhzAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gzjmQLc7k2xq2zQY7wOtxpGk6TwJBU/hzk7s9roViD1cyKGvYGXSw8C5DH7561Lsw
         jCrDwVt65k7ju28dmIHS+goGQU7rk658YhJhr9ovWmORg0R/Sx4J6o4CzUPP9BHtV3
         5UgLnD/QB5ZwJcYsG1RuVQgOKb5urgPoxJDp+bJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 019/120] tcp: deny tcp_disconnect() when threads are waiting
Date:   Wed,  7 Jun 2023 22:15:35 +0200
Message-ID: <20230607200901.522127231@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 4faeee0cf8a5d88d63cdbc3bab124fb0e6aed08c ]

Historically connect(AF_UNSPEC) has been abused by syzkaller
and other fuzzers to trigger various bugs.

A recent one triggers a divide-by-zero [1], and Paolo Abeni
was able to diagnose the issue.

tcp_recvmsg_locked() has tests about sk_state being not TCP_LISTEN
and TCP REPAIR mode being not used.

Then later if socket lock is released in sk_wait_data(),
another thread can call connect(AF_UNSPEC), then make this
socket a TCP listener.

When recvmsg() is resumed, it can eventually call tcp_cleanup_rbuf()
and attempt a divide by 0 in tcp_rcv_space_adjust() [1]

This patch adds a new socket field, counting number of threads
blocked in sk_wait_event() and inet_wait_for_connect().

If this counter is not zero, tcp_disconnect() returns an error.

This patch adds code in blocking socket system calls, thus should
not hurt performance of non blocking ones.

Note that we probably could revert commit 499350a5a6e7 ("tcp:
initialize rcv_mss to TCP_MIN_MSS instead of 0") to restore
original tcpi_rcv_mss meaning (was 0 if no payload was ever
received on a socket)

[1]
divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 13832 Comm: syz-executor.5 Not tainted 6.3.0-rc4-syzkaller-00224-g00c7b5f4ddc5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:tcp_rcv_space_adjust+0x36e/0x9d0 net/ipv4/tcp_input.c:740
Code: 00 00 00 00 fc ff df 4c 89 64 24 48 8b 44 24 04 44 89 f9 41 81 c7 80 03 00 00 c1 e1 04 44 29 f0 48 63 c9 48 01 e9 48 0f af c1 <49> f7 f6 48 8d 04 41 48 89 44 24 40 48 8b 44 24 30 48 c1 e8 03 48
RSP: 0018:ffffc900033af660 EFLAGS: 00010206
RAX: 4a66b76cbade2c48 RBX: ffff888076640cc0 RCX: 00000000c334e4ac
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000001
RBP: 00000000c324e86c R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880766417f8
R13: ffff888028fbb980 R14: 0000000000000000 R15: 0000000000010344
FS: 00007f5bffbfe700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32f25000 CR3: 000000007ced0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
tcp_recvmsg_locked+0x100e/0x22e0 net/ipv4/tcp.c:2616
tcp_recvmsg+0x117/0x620 net/ipv4/tcp.c:2681
inet6_recvmsg+0x114/0x640 net/ipv6/af_inet6.c:670
sock_recvmsg_nosec net/socket.c:1017 [inline]
sock_recvmsg+0xe2/0x160 net/socket.c:1038
____sys_recvmsg+0x210/0x5a0 net/socket.c:2720
___sys_recvmsg+0xf2/0x180 net/socket.c:2762
do_recvmmsg+0x25e/0x6e0 net/socket.c:2856
__sys_recvmmsg net/socket.c:2935 [inline]
__do_sys_recvmmsg net/socket.c:2958 [inline]
__se_sys_recvmmsg net/socket.c:2951 [inline]
__x64_sys_recvmmsg+0x20f/0x260 net/socket.c:2951
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5c0108c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5bffbfe168 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007f5c011ac050 RCX: 00007f5c0108c0f9
RDX: 0000000000000001 RSI: 0000000020000bc0 RDI: 0000000000000003
RBP: 00007f5c010e7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000122 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5c012cfb1f R14: 00007f5bffbfe300 R15: 0000000000022000
</TASK>

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Reported-by: Paolo Abeni <pabeni@redhat.com>
Diagnosed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Tested-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20230526163458.2880232-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h              | 4 ++++
 net/ipv4/af_inet.c              | 2 ++
 net/ipv4/inet_connection_sock.c | 1 +
 net/ipv4/tcp.c                  | 6 ++++++
 4 files changed, 13 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 651dc0a7bbd58..3da0601b573ed 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -326,6 +326,7 @@ struct bpf_local_storage;
   *	@sk_cgrp_data: cgroup data for this cgroup
   *	@sk_memcg: this socket's memory cgroup association
   *	@sk_write_pending: a write to stream socket waits to start
+  *	@sk_wait_pending: number of threads blocked on this socket
   *	@sk_state_change: callback to indicate change in the state of the sock
   *	@sk_data_ready: callback to indicate there is data to be processed
   *	@sk_write_space: callback to indicate there is bf sending space available
@@ -410,6 +411,7 @@ struct sock {
 	unsigned int		sk_napi_id;
 #endif
 	int			sk_rcvbuf;
+	int			sk_wait_pending;
 
 	struct sk_filter __rcu	*sk_filter;
 	union {
@@ -1095,6 +1097,7 @@ static inline void sock_rps_reset_rxhash(struct sock *sk)
 
 #define sk_wait_event(__sk, __timeo, __condition, __wait)		\
 	({	int __rc;						\
+		__sk->sk_wait_pending++;				\
 		release_sock(__sk);					\
 		__rc = __condition;					\
 		if (!__rc) {						\
@@ -1104,6 +1107,7 @@ static inline void sock_rps_reset_rxhash(struct sock *sk)
 		}							\
 		sched_annotate_sleep();					\
 		lock_sock(__sk);					\
+		__sk->sk_wait_pending--;				\
 		__rc = __condition;					\
 		__rc;							\
 	})
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 800c2c7607e1a..acb4887351daf 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -584,6 +584,7 @@ static long inet_wait_for_connect(struct sock *sk, long timeo, int writebias)
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	sk->sk_write_pending += writebias;
+	sk->sk_wait_pending++;
 
 	/* Basic assumption: if someone sets sk->sk_err, he _must_
 	 * change state of the socket from TCP_SYN_*.
@@ -599,6 +600,7 @@ static long inet_wait_for_connect(struct sock *sk, long timeo, int writebias)
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
 	sk->sk_write_pending -= writebias;
+	sk->sk_wait_pending--;
 	return timeo;
 }
 
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index e05dd87848f78..406305aaec904 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -839,6 +839,7 @@ struct sock *inet_csk_clone_lock(const struct sock *sk,
 	if (newsk) {
 		struct inet_connection_sock *newicsk = inet_csk(newsk);
 
+		newsk->sk_wait_pending = 0;
 		inet_sk_set_state(newsk, TCP_SYN_RECV);
 		newicsk->icsk_bind_hash = NULL;
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index eecce63ba25e3..edb743bcbc391 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2748,6 +2748,12 @@ int tcp_disconnect(struct sock *sk, int flags)
 	int old_state = sk->sk_state;
 	u32 seq;
 
+	/* Deny disconnect if other threads are blocked in sk_wait_event()
+	 * or inet_wait_for_connect().
+	 */
+	if (sk->sk_wait_pending)
+		return -EBUSY;
+
 	if (old_state != TCP_CLOSE)
 		tcp_set_state(sk, TCP_CLOSE);
 
-- 
2.39.2



