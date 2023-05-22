Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41B670C89B
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbjEVTkM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjEVTkK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:40:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F8CC1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B023862300
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA54C433D2;
        Mon, 22 May 2023 19:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784406;
        bh=3T3cntzTrxU6c9m0DKzk/TT69ChLsVuaS71qWQv+5tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L99usxQa1/vHdOCBgajHJt3+ZspS5BUQRj4NzM4XylrUOglM0uMqa8urwd6BG8GpE
         /rWlnR4JXghYintqA5by+EaJwLbpl0dWpwxFiW31aZ6UCq5qTnkTsZJUQlexvVGKlW
         yPTj+4fvfo8gwdjw1THv8Optnnq9avvRiHBlZmYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Eric Dumazet <edumazet@google.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 030/364] af_unix: Fix data races around sk->sk_shutdown.
Date:   Mon, 22 May 2023 20:05:35 +0100
Message-Id: <20230522190413.587061852@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit e1d09c2c2f5793474556b60f83900e088d0d366d ]

KCSAN found a data race around sk->sk_shutdown where unix_release_sock()
and unix_shutdown() update it under unix_state_lock(), OTOH unix_poll()
and unix_dgram_poll() read it locklessly.

We need to annotate the writes and reads with WRITE_ONCE() and READ_ONCE().

BUG: KCSAN: data-race in unix_poll / unix_release_sock

write to 0xffff88800d0f8aec of 1 bytes by task 264 on cpu 0:
 unix_release_sock+0x75c/0x910 net/unix/af_unix.c:631
 unix_release+0x59/0x80 net/unix/af_unix.c:1042
 __sock_release+0x7d/0x170 net/socket.c:653
 sock_close+0x19/0x30 net/socket.c:1397
 __fput+0x179/0x5e0 fs/file_table.c:321
 ____fput+0x15/0x20 fs/file_table.c:349
 task_work_run+0x116/0x1a0 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x174/0x180 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1a/0x30 kernel/entry/common.c:297
 do_syscall_64+0x4b/0x90 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

read to 0xffff88800d0f8aec of 1 bytes by task 222 on cpu 1:
 unix_poll+0xa3/0x2a0 net/unix/af_unix.c:3170
 sock_poll+0xcf/0x2b0 net/socket.c:1385
 vfs_poll include/linux/poll.h:88 [inline]
 ep_item_poll.isra.0+0x78/0xc0 fs/eventpoll.c:855
 ep_send_events fs/eventpoll.c:1694 [inline]
 ep_poll fs/eventpoll.c:1823 [inline]
 do_epoll_wait+0x6c4/0xea0 fs/eventpoll.c:2258
 __do_sys_epoll_wait fs/eventpoll.c:2270 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2265 [inline]
 __x64_sys_epoll_wait+0xcc/0x190 fs/eventpoll.c:2265
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

value changed: 0x00 -> 0x03

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 222 Comm: dbus-broker Not tainted 6.3.0-rc7-02330-gca6270c12e20 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014

Fixes: 3c73419c09a5 ("af_unix: fix 'poll for write'/ connected DGRAM sockets")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0a54959e5b944..29c6083a37daf 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -603,7 +603,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	/* Clear state */
 	unix_state_lock(sk);
 	sock_orphan(sk);
-	sk->sk_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 	path	     = u->path;
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
@@ -628,7 +628,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 		if (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET) {
 			unix_state_lock(skpair);
 			/* No more writes */
-			skpair->sk_shutdown = SHUTDOWN_MASK;
+			WRITE_ONCE(skpair->sk_shutdown, SHUTDOWN_MASK);
 			if (!skb_queue_empty(&sk->sk_receive_queue) || embrion)
 				skpair->sk_err = ECONNRESET;
 			unix_state_unlock(skpair);
@@ -3008,7 +3008,7 @@ static int unix_shutdown(struct socket *sock, int mode)
 	++mode;
 
 	unix_state_lock(sk);
-	sk->sk_shutdown |= mode;
+	WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | mode);
 	other = unix_peer(sk);
 	if (other)
 		sock_hold(other);
@@ -3028,7 +3028,7 @@ static int unix_shutdown(struct socket *sock, int mode)
 		if (mode&SEND_SHUTDOWN)
 			peer_mode |= RCV_SHUTDOWN;
 		unix_state_lock(other);
-		other->sk_shutdown |= peer_mode;
+		WRITE_ONCE(other->sk_shutdown, other->sk_shutdown | peer_mode);
 		unix_state_unlock(other);
 		other->sk_state_change(other);
 		if (peer_mode == SHUTDOWN_MASK)
@@ -3160,16 +3160,18 @@ static __poll_t unix_poll(struct file *file, struct socket *sock, poll_table *wa
 {
 	struct sock *sk = sock->sk;
 	__poll_t mask;
+	u8 shutdown;
 
 	sock_poll_wait(file, sock, wait);
 	mask = 0;
+	shutdown = READ_ONCE(sk->sk_shutdown);
 
 	/* exceptional events? */
 	if (sk->sk_err)
 		mask |= EPOLLERR;
-	if (sk->sk_shutdown == SHUTDOWN_MASK)
+	if (shutdown == SHUTDOWN_MASK)
 		mask |= EPOLLHUP;
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
+	if (shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
 
 	/* readable? */
@@ -3203,18 +3205,20 @@ static __poll_t unix_dgram_poll(struct file *file, struct socket *sock,
 	struct sock *sk = sock->sk, *other;
 	unsigned int writable;
 	__poll_t mask;
+	u8 shutdown;
 
 	sock_poll_wait(file, sock, wait);
 	mask = 0;
+	shutdown = READ_ONCE(sk->sk_shutdown);
 
 	/* exceptional events? */
 	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR |
 			(sock_flag(sk, SOCK_SELECT_ERR_QUEUE) ? EPOLLPRI : 0);
 
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
+	if (shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
-	if (sk->sk_shutdown == SHUTDOWN_MASK)
+	if (shutdown == SHUTDOWN_MASK)
 		mask |= EPOLLHUP;
 
 	/* readable? */
-- 
2.39.2



