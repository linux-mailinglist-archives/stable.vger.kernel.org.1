Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FF07A7E75
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbjITMSE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjITMSD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:18:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A4EE8
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:17:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835E1C433CB;
        Wed, 20 Sep 2023 12:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212268;
        bh=KU79ytpd8WHCx5HqB+2AuFXW5VaDtPNEIGMsbGLUh34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HePbV43VKH3ivbZbdOBB4oRNRpulkbXweN95fjQXV4HbCSYGMQGv8YuBdWwgPiH19
         FfsccFczxht+GRL63V/AzBV4JNPq2ehzalfbG7XJE763uVWE5xI4R0lsowD4lfUIVh
         9mvtWO5DfWfY1krX3MSAnlFjY9L04pnWJ2buLpPQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzkaller <syzkaller@googlegroups.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Willy Tarreau <w@1wt.eu>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 214/273] af_unix: Fix data-races around user->unix_inflight.
Date:   Wed, 20 Sep 2023 13:30:54 +0200
Message-ID: <20230920112853.070100912@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 0bc36c0650b21df36fbec8136add83936eaf0607 ]

user->unix_inflight is changed under spin_lock(unix_gc_lock),
but too_many_unix_fds() reads it locklessly.

Let's annotate the write/read accesses to user->unix_inflight.

BUG: KCSAN: data-race in unix_attach_fds / unix_inflight

write to 0xffffffff8546f2d0 of 8 bytes by task 44798 on cpu 1:
 unix_inflight+0x157/0x180 net/unix/scm.c:66
 unix_attach_fds+0x147/0x1e0 net/unix/scm.c:123
 unix_scm_to_skb net/unix/af_unix.c:1827 [inline]
 unix_dgram_sendmsg+0x46a/0x14f0 net/unix/af_unix.c:1950
 unix_seqpacket_sendmsg net/unix/af_unix.c:2308 [inline]
 unix_seqpacket_sendmsg+0xba/0x130 net/unix/af_unix.c:2292
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0x148/0x160 net/socket.c:748
 ____sys_sendmsg+0x4e4/0x610 net/socket.c:2494
 ___sys_sendmsg+0xc6/0x140 net/socket.c:2548
 __sys_sendmsg+0x94/0x140 net/socket.c:2577
 __do_sys_sendmsg net/socket.c:2586 [inline]
 __se_sys_sendmsg net/socket.c:2584 [inline]
 __x64_sys_sendmsg+0x45/0x50 net/socket.c:2584
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

read to 0xffffffff8546f2d0 of 8 bytes by task 44814 on cpu 0:
 too_many_unix_fds net/unix/scm.c:101 [inline]
 unix_attach_fds+0x54/0x1e0 net/unix/scm.c:110
 unix_scm_to_skb net/unix/af_unix.c:1827 [inline]
 unix_dgram_sendmsg+0x46a/0x14f0 net/unix/af_unix.c:1950
 unix_seqpacket_sendmsg net/unix/af_unix.c:2308 [inline]
 unix_seqpacket_sendmsg+0xba/0x130 net/unix/af_unix.c:2292
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0x148/0x160 net/socket.c:748
 ____sys_sendmsg+0x4e4/0x610 net/socket.c:2494
 ___sys_sendmsg+0xc6/0x140 net/socket.c:2548
 __sys_sendmsg+0x94/0x140 net/socket.c:2577
 __do_sys_sendmsg net/socket.c:2586 [inline]
 __se_sys_sendmsg net/socket.c:2584 [inline]
 __x64_sys_sendmsg+0x45/0x50 net/socket.c:2584
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

value changed: 0x000000000000000c -> 0x000000000000000d

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 44814 Comm: systemd-coredum Not tainted 6.4.0-11989-g6843306689af #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014

Fixes: 712f4aad406b ("unix: properly account for FDs passed over unix sockets")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Willy Tarreau <w@1wt.eu>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/scm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/unix/scm.c b/net/unix/scm.c
index a07b2efbf8b5e..ac206bfdbbe3c 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -59,7 +59,7 @@ void unix_inflight(struct user_struct *user, struct file *fp)
 		/* Paired with READ_ONCE() in wait_for_unix_gc() */
 		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + 1);
 	}
-	user->unix_inflight++;
+	WRITE_ONCE(user->unix_inflight, user->unix_inflight + 1);
 	spin_unlock(&unix_gc_lock);
 }
 
@@ -80,7 +80,7 @@ void unix_notinflight(struct user_struct *user, struct file *fp)
 		/* Paired with READ_ONCE() in wait_for_unix_gc() */
 		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - 1);
 	}
-	user->unix_inflight--;
+	WRITE_ONCE(user->unix_inflight, user->unix_inflight - 1);
 	spin_unlock(&unix_gc_lock);
 }
 
@@ -94,7 +94,7 @@ static inline bool too_many_unix_fds(struct task_struct *p)
 {
 	struct user_struct *user = current_user();
 
-	if (unlikely(user->unix_inflight > task_rlimit(p, RLIMIT_NOFILE)))
+	if (unlikely(READ_ONCE(user->unix_inflight) > task_rlimit(p, RLIMIT_NOFILE)))
 		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
 	return false;
 }
-- 
2.40.1



