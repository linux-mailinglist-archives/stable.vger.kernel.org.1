Return-Path: <stable+bounces-60227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91673932DF5
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84C6B23387
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2EA19B3C4;
	Tue, 16 Jul 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fm9fgpQf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A71DDCE;
	Tue, 16 Jul 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146270; cv=none; b=eNPbE7yB+bs7dD8+k5k+3oyFmW7G5YIqgUz39Q/bkbLyZ+tvIIYxPngJNAhAp3V1xZ6oZyjqSrJS9KzrmdE++ugiJYTgAu3eHEuZ4/pDl72tBaxLe5WJTbIx3g4OL1Q5+HDDgM2wQ/BVuWZKR28EnHPA+Puej0XNe/T+tIWBlXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146270; c=relaxed/simple;
	bh=tN5TueRPqO4WFAV+80ves3hRQd6ItiEfzbaDZPTFYOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKDvVAA9e4jaOqengX83He+P/w3DFSrCf9dPwS903s3BQXkX7eYHvCYJGCrxyMlFwvS4b2oP493v8gTmRoUftFOmEbJRvdXgHheAKINnuopy6cwxJVqDRDh0Gd7vj3/05RXO3FxJD945STQxvWBXJuIiRjZSD4ldoAqi5ogvNt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fm9fgpQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873EDC116B1;
	Tue, 16 Jul 2024 16:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721146269;
	bh=tN5TueRPqO4WFAV+80ves3hRQd6ItiEfzbaDZPTFYOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fm9fgpQfxiDWVdtaPpdfYmMKYGRSY+/0iERLTrEVZV+ULvgIHFrJu6I8Mf5FOE15F
	 XVmVXdNpeyK8LlgNZsNsKcbgrpZrz2OBjR9FBUGt0Ohz7dIDRxCN641F0IG9K4uVqR
	 ZvuD7tjWl3gwRZUh1KrvunL2ZJEAollBzvb2ZZnE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzkaller <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 093/144] udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
Date: Tue, 16 Jul 2024 17:32:42 +0200
Message-ID: <20240716152756.114907579@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152752.524497140@linuxfoundation.org>
References: <20240716152752.524497140@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 5c0b485a8c6116516f33925b9ce5b6104a6eadfd ]

syzkaller triggered the warning [0] in udp_v4_early_demux().

In udp_v[46]_early_demux() and sk_lookup(), we do not touch the refcount
of the looked-up sk and use sock_pfree() as skb->destructor, so we check
SOCK_RCU_FREE to ensure that the sk is safe to access during the RCU grace
period.

Currently, SOCK_RCU_FREE is flagged for a bound socket after being put
into the hash table.  Moreover, the SOCK_RCU_FREE check is done too early
in udp_v[46]_early_demux() and sk_lookup(), so there could be a small race
window:

  CPU1                                 CPU2
  ----                                 ----
  udp_v4_early_demux()                 udp_lib_get_port()
  |                                    |- hlist_add_head_rcu()
  |- sk = __udp4_lib_demux_lookup()    |
  |- DEBUG_NET_WARN_ON_ONCE(sk_is_refcounted(sk));
                                       `- sock_set_flag(sk, SOCK_RCU_FREE)

We had the same bug in TCP and fixed it in commit 871019b22d1b ("net:
set SOCK_RCU_FREE before inserting socket into hashtable").

Let's apply the same fix for UDP.

[0]:
WARNING: CPU: 0 PID: 11198 at net/ipv4/udp.c:2599 udp_v4_early_demux+0x481/0xb70 net/ipv4/udp.c:2599
Modules linked in:
CPU: 0 PID: 11198 Comm: syz-executor.1 Not tainted 6.9.0-g93bda33046e7 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:udp_v4_early_demux+0x481/0xb70 net/ipv4/udp.c:2599
Code: c5 7a 15 fe bb 01 00 00 00 44 89 e9 31 ff d3 e3 81 e3 bf ef ff ff 89 de e8 2c 74 15 fe 85 db 0f 85 02 06 00 00 e8 9f 7a 15 fe <0f> 0b e8 98 7a 15 fe 49 8d 7e 60 e8 4f 39 2f fe 49 c7 46 60 20 52
RSP: 0018:ffffc9000ce3fa58 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8318c92c
RDX: ffff888036ccde00 RSI: ffffffff8318c2f1 RDI: 0000000000000001
RBP: ffff88805a2dd6e0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0001ffffffffffff R12: ffff88805a2dd680
R13: 0000000000000007 R14: ffff88800923f900 R15: ffff88805456004e
FS:  00007fc449127640(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc449126e38 CR3: 000000003de4b002 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
PKRU: 55555554
Call Trace:
 <TASK>
 ip_rcv_finish_core.constprop.0+0xbdd/0xd20 net/ipv4/ip_input.c:349
 ip_rcv_finish+0xda/0x150 net/ipv4/ip_input.c:447
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip_rcv+0x16c/0x180 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core+0xb3/0xe0 net/core/dev.c:5624
 __netif_receive_skb+0x21/0xd0 net/core/dev.c:5738
 netif_receive_skb_internal net/core/dev.c:5824 [inline]
 netif_receive_skb+0x271/0x300 net/core/dev.c:5884
 tun_rx_batched drivers/net/tun.c:1549 [inline]
 tun_get_user+0x24db/0x2c50 drivers/net/tun.c:2002
 tun_chr_write_iter+0x107/0x1a0 drivers/net/tun.c:2048
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x76f/0x8d0 fs/read_write.c:590
 ksys_write+0xbf/0x190 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x41/0x50 fs/read_write.c:652
 x64_sys_call+0xe66/0x1990 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x4b/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7fc44a68bc1f
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 e9 cf f5 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 3c d0 f5 ff 48
RSP: 002b:00007fc449126c90 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004bc050 RCX: 00007fc44a68bc1f
RDX: 0000000000000032 RSI: 00000000200000c0 RDI: 00000000000000c8
RBP: 00000000004bc050 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000032 R11: 0000000000000293 R12: 0000000000000000
R13: 000000000000000b R14: 00007fc44a5ec530 R15: 0000000000000000
 </TASK>

Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20240709191356.24010-1-kuniyu@amazon.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 53d7a81d62584..138fef35e7071 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -317,6 +317,8 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 			goto fail_unlock;
 		}
 
+		sock_set_flag(sk, SOCK_RCU_FREE);
+
 		sk_add_node_rcu(sk, &hslot->head);
 		hslot->count++;
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
@@ -333,7 +335,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 		hslot2->count++;
 		spin_unlock(&hslot2->lock);
 	}
-	sock_set_flag(sk, SOCK_RCU_FREE);
+
 	error = 0;
 fail_unlock:
 	spin_unlock_bh(&hslot->lock);
-- 
2.43.0




