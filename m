Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA12A761427
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjGYLQw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbjGYLQh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:16:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91771FD3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:16:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36F8E61693
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406BDC433C7;
        Tue, 25 Jul 2023 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283782;
        bh=G0M+tr1FVBkF1wsEQnNR+DDsvXX3KI8zKCXkk1w8e0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CXauLUeYJVTMaOr263AUpPB9ZBifvIIWbcNifsgsYxJdtMdv/6qCLQ6SdtXpNiKR7
         pw/5MDbOK/w2Ysca8r9HiOCCYHwo3qbpbXmSIHqTcqRFb4Km7N37tHvjsPLlI/POJL
         OVK9lsb4PjSCIV+0JlwfaCnhHYyUN1kIaKRHG2K4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+5da61cf6a9bc1902d422@syzkaller.appspotmail.com,
        Eric Dumazet <edumazet@google.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 092/509] netlink: Add __sock_i_ino() for __netlink_diag_dump().
Date:   Tue, 25 Jul 2023 12:40:31 +0200
Message-ID: <20230725104557.927314104@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 25a9c8a4431c364f97f75558cb346d2ad3f53fbb ]

syzbot reported a warning in __local_bh_enable_ip(). [0]

Commit 8d61f926d420 ("netlink: fix potential deadlock in
netlink_set_err()") converted read_lock(&nl_table_lock) to
read_lock_irqsave() in __netlink_diag_dump() to prevent a deadlock.

However, __netlink_diag_dump() calls sock_i_ino() that uses
read_lock_bh() and read_unlock_bh().  If CONFIG_TRACE_IRQFLAGS=y,
read_unlock_bh() finally enables IRQ even though it should stay
disabled until the following read_unlock_irqrestore().

Using read_lock() in sock_i_ino() would trigger a lockdep splat
in another place that was fixed in commit f064af1e500a ("net: fix
a lockdep splat"), so let's add __sock_i_ino() that would be safe
to use under BH disabled.

[0]:
WARNING: CPU: 0 PID: 5012 at kernel/softirq.c:376 __local_bh_enable_ip+0xbe/0x130 kernel/softirq.c:376
Modules linked in:
CPU: 0 PID: 5012 Comm: syz-executor487 Not tainted 6.4.0-rc7-syzkaller-00202-g6f68fc395f49 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:__local_bh_enable_ip+0xbe/0x130 kernel/softirq.c:376
Code: 45 bf 01 00 00 00 e8 91 5b 0a 00 e8 3c 15 3d 00 fb 65 8b 05 ec e9 b5 7e 85 c0 74 58 5b 5d c3 65 8b 05 b2 b6 b4 7e 85 c0 75 a2 <0f> 0b eb 9e e8 89 15 3d 00 eb 9f 48 89 ef e8 6f 49 18 00 eb a8 0f
RSP: 0018:ffffc90003a1f3d0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000201 RCX: 1ffffffff1cf5996
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff8805c6f3
RBP: ffffffff8805c6f3 R08: 0000000000000001 R09: ffff8880152b03a3
R10: ffffed1002a56074 R11: 0000000000000005 R12: 00000000000073e4
R13: dffffc0000000000 R14: 0000000000000002 R15: 0000000000000000
FS:  0000555556726300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 000000007c646000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sock_i_ino+0x83/0xa0 net/core/sock.c:2559
 __netlink_diag_dump+0x45c/0x790 net/netlink/diag.c:171
 netlink_diag_dump+0xd6/0x230 net/netlink/diag.c:207
 netlink_dump+0x570/0xc50 net/netlink/af_netlink.c:2269
 __netlink_dump_start+0x64b/0x910 net/netlink/af_netlink.c:2374
 netlink_dump_start include/linux/netlink.h:329 [inline]
 netlink_diag_handler_dump+0x1ae/0x250 net/netlink/diag.c:238
 __sock_diag_cmd net/core/sock_diag.c:238 [inline]
 sock_diag_rcv_msg+0x31e/0x440 net/core/sock_diag.c:269
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2547
 sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:280
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 ____sys_sendmsg+0x71c/0x900 net/socket.c:2503
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2557
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2586
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5303aaabb9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc7506e548 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5303aaabb9
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00007f5303a6ed60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5303a6edf0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Fixes: 8d61f926d420 ("netlink: fix potential deadlock in netlink_set_err()")
Reported-by: syzbot+5da61cf6a9bc1902d422@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=5da61cf6a9bc1902d422
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20230626164313.52528-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h |  1 +
 net/core/sock.c    | 17 ++++++++++++++---
 net/netlink/diag.c |  2 +-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 03e7f7581559d..1fb5c535537c1 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1934,6 +1934,7 @@ static inline void sock_graft(struct sock *sk, struct socket *parent)
 }
 
 kuid_t sock_i_uid(struct sock *sk);
+unsigned long __sock_i_ino(struct sock *sk);
 unsigned long sock_i_ino(struct sock *sk);
 
 static inline kuid_t sock_net_uid(const struct net *net, const struct sock *sk)
diff --git a/net/core/sock.c b/net/core/sock.c
index 9b013d052a722..4e00c6e2cb431 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2175,13 +2175,24 @@ kuid_t sock_i_uid(struct sock *sk)
 }
 EXPORT_SYMBOL(sock_i_uid);
 
-unsigned long sock_i_ino(struct sock *sk)
+unsigned long __sock_i_ino(struct sock *sk)
 {
 	unsigned long ino;
 
-	read_lock_bh(&sk->sk_callback_lock);
+	read_lock(&sk->sk_callback_lock);
 	ino = sk->sk_socket ? SOCK_INODE(sk->sk_socket)->i_ino : 0;
-	read_unlock_bh(&sk->sk_callback_lock);
+	read_unlock(&sk->sk_callback_lock);
+	return ino;
+}
+EXPORT_SYMBOL(__sock_i_ino);
+
+unsigned long sock_i_ino(struct sock *sk)
+{
+	unsigned long ino;
+
+	local_bh_disable();
+	ino = __sock_i_ino(sk);
+	local_bh_enable();
 	return ino;
 }
 EXPORT_SYMBOL(sock_i_ino);
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index 4143b2ea4195a..e4f21b1067bcc 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -168,7 +168,7 @@ static int __netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 				 NETLINK_CB(cb->skb).portid,
 				 cb->nlh->nlmsg_seq,
 				 NLM_F_MULTI,
-				 sock_i_ino(sk)) < 0) {
+				 __sock_i_ino(sk)) < 0) {
 			ret = 1;
 			break;
 		}
-- 
2.39.2



