Return-Path: <stable+bounces-69136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC34795359C
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CBA281EBA
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1FE2772A;
	Thu, 15 Aug 2024 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SJcpLzxp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA581AC893;
	Thu, 15 Aug 2024 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732785; cv=none; b=Pl22v+50gg3qlMd8zxXBTD15PxTX1eLnopBVtxkF7VhVzDuhLZFmE+0kwyOdF/D4CdT7m+6InX4wGDC5r4yqLJuI/Fy85+QXAOh/pJ96w8WxDxwsiN5UUu/Jm1ACuX934BIRqr5gqPPU54OUcai5RocE/kE3x0e6SA8105WqKHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732785; c=relaxed/simple;
	bh=EJ61rU1tdH35pHsMgX7FKk/L4Ecfys2yAw1KgPWBM0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLF98W3HEijKV2nY3SGxFaUvaODmG89bJidkPA8YTehnuxHfmGPKYnEVoDkm1R843F1hTaO8rPhdFGe1w+E3i1M3C39nnfCYUE2rHplAvaWvg2vf+JRoGvi/V04fH7QydZRnxMmSQgOn4nR0z52WMk57VgpMfOPvXdS8wt07TFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SJcpLzxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20451C32786;
	Thu, 15 Aug 2024 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732785;
	bh=EJ61rU1tdH35pHsMgX7FKk/L4Ecfys2yAw1KgPWBM0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJcpLzxpFuSgFoXwyRIyQEjmdIKL+rjFBpsCtkOO4DhkPwaayWdJ/iGwSyZPPAdPV
	 9AtQjiSDqMmY4KF6nErB0GwoDAtHrowNtTO0xC6ic5WqSuRwwZ+L9808lJOkGrbiW3
	 ZecNFaPziG+CC/nMzwdxC9SwQXYrQ9HPpEHnJj14=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 254/352] sctp: Fix null-ptr-deref in reuseport_add_sock().
Date: Thu, 15 Aug 2024 15:25:20 +0200
Message-ID: <20240815131929.255874463@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 9ab0faa7f9ffe31296dbb9bbe6f76c72c14eea18 ]

syzbot reported a null-ptr-deref while accessing sk2->sk_reuseport_cb in
reuseport_add_sock(). [0]

The repro first creates a listener with SO_REUSEPORT.  Then, it creates
another listener on the same port and concurrently closes the first
listener.

The second listen() calls reuseport_add_sock() with the first listener as
sk2, where sk2->sk_reuseport_cb is not expected to be cleared concurrently,
but the close() does clear it by reuseport_detach_sock().

The problem is SCTP does not properly synchronise reuseport_alloc(),
reuseport_add_sock(), and reuseport_detach_sock().

The caller of reuseport_alloc() and reuseport_{add,detach}_sock() must
provide synchronisation for sockets that are classified into the same
reuseport group.

Otherwise, such sockets form multiple identical reuseport groups, and
all groups except one would be silently dead.

  1. Two sockets call listen() concurrently
  2. No socket in the same group found in sctp_ep_hashtable[]
  3. Two sockets call reuseport_alloc() and form two reuseport groups
  4. Only one group hit first in __sctp_rcv_lookup_endpoint() receives
      incoming packets

Also, the reported null-ptr-deref could occur.

TCP/UDP guarantees that would not happen by holding the hash bucket lock.

Let's apply the locking strategy to __sctp_hash_endpoint() and
__sctp_unhash_endpoint().

[0]:
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 UID: 0 PID: 10230 Comm: syz-executor119 Not tainted 6.10.0-syzkaller-12585-g301927d2d2eb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:reuseport_add_sock+0x27e/0x5e0 net/core/sock_reuseport.c:350
Code: 00 0f b7 5d 00 bf 01 00 00 00 89 de e8 1b a4 ff f7 83 fb 01 0f 85 a3 01 00 00 e8 6d a0 ff f7 49 8d 7e 12 48 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 4b 02 00 00 41 0f b7 5e 12 49 8d 7e 14
RSP: 0018:ffffc9000b947c98 EFLAGS: 00010202
RAX: 0000000000000002 RBX: ffff8880252ddf98 RCX: ffff888079478000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000012
RBP: 0000000000000001 R08: ffffffff8993e18d R09: 1ffffffff1fef385
R10: dffffc0000000000 R11: fffffbfff1fef386 R12: ffff8880252ddac0
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f24e45b96c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcced5f7b8 CR3: 00000000241be000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __sctp_hash_endpoint net/sctp/input.c:762 [inline]
 sctp_hash_endpoint+0x52a/0x600 net/sctp/input.c:790
 sctp_listen_start net/sctp/socket.c:8570 [inline]
 sctp_inet_listen+0x767/0xa20 net/sctp/socket.c:8625
 __sys_listen_socket net/socket.c:1883 [inline]
 __sys_listen+0x1b7/0x230 net/socket.c:1894
 __do_sys_listen net/socket.c:1902 [inline]
 __se_sys_listen net/socket.c:1900 [inline]
 __x64_sys_listen+0x5a/0x70 net/socket.c:1900
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f24e46039b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f24e45b9228 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
RAX: ffffffffffffffda RBX: 00007f24e468e428 RCX: 00007f24e46039b9
RDX: 00007f24e46039b9 RSI: 0000000000000003 RDI: 0000000000000004
RBP: 00007f24e468e420 R08: 00007f24e45b96c0 R09: 00007f24e45b96c0
R10: 00007f24e45b96c0 R11: 0000000000000246 R12: 00007f24e468e42c
R13: 00007f24e465a5dc R14: 0020000000000001 R15: 00007ffcced5f7d8
 </TASK>
Modules linked in:

Fixes: 6ba845740267 ("sctp: process sk_reuseport in sctp_get_port_local")
Reported-by: syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e6979a5d2f10ecb700e4
Tested-by: syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/20240731234624.94055-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/input.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index 17df756418eae..8fe1a74f0618d 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -723,15 +723,19 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
 	struct sock *sk = ep->base.sk;
 	struct net *net = sock_net(sk);
 	struct sctp_hashbucket *head;
+	int err = 0;
 
 	ep->hashent = sctp_ep_hashfn(net, ep->base.bind_addr.port);
 	head = &sctp_ep_hashtable[ep->hashent];
 
+	write_lock(&head->lock);
 	if (sk->sk_reuseport) {
 		bool any = sctp_is_ep_boundall(sk);
 		struct sctp_endpoint *ep2;
 		struct list_head *list;
-		int cnt = 0, err = 1;
+		int cnt = 0;
+
+		err = 1;
 
 		list_for_each(list, &ep->base.bind_addr.address_list)
 			cnt++;
@@ -749,24 +753,24 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
 			if (!err) {
 				err = reuseport_add_sock(sk, sk2, any);
 				if (err)
-					return err;
+					goto out;
 				break;
 			} else if (err < 0) {
-				return err;
+				goto out;
 			}
 		}
 
 		if (err) {
 			err = reuseport_alloc(sk, any);
 			if (err)
-				return err;
+				goto out;
 		}
 	}
 
-	write_lock(&head->lock);
 	hlist_add_head(&ep->node, &head->chain);
+out:
 	write_unlock(&head->lock);
-	return 0;
+	return err;
 }
 
 /* Add an endpoint to the hash. Local BH-safe. */
@@ -791,10 +795,9 @@ static void __sctp_unhash_endpoint(struct sctp_endpoint *ep)
 
 	head = &sctp_ep_hashtable[ep->hashent];
 
+	write_lock(&head->lock);
 	if (rcu_access_pointer(sk->sk_reuseport_cb))
 		reuseport_detach_sock(sk);
-
-	write_lock(&head->lock);
 	hlist_del_init(&ep->node);
 	write_unlock(&head->lock);
 }
-- 
2.43.0




