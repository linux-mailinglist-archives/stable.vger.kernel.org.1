Return-Path: <stable+bounces-104651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1FF9F5260
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CD01894473
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55261F8AD9;
	Tue, 17 Dec 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NbcbKfbq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD581F8ADA;
	Tue, 17 Dec 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455694; cv=none; b=C9Y19n1Nu0EnpHda8SmTW2H9+EHMNwmWU6AYFoUuJMlnsHuTUnUVU3aInutgI1Mv6M/mgaz9C2ytT827QHpca32repqg5Rxam3XXveo7S9bqEpX0bwa7avhY3jiGczpdb+peH55JYxBDV+LoCjRQYj9y7oQEcPRIPy1iL5TiKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455694; c=relaxed/simple;
	bh=jXVHZVdKrsnU3V5+W2sNNraEaIgHqqxegrfAMErZ064=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZQTb/4M9YiLKg0asi/3Xp2dOVSTianE9Od5paRvNnWJ5nYXc6lcPBAf2RMhJiGZPJTQKxqLgerJJBpbK+masTkfIxfsc9tRztzLlgYyZAiB0foBx9tEC0iyRq8rsupXI67cD5GMwhA80hmvdA6He+LH6TFyWuVbsZxcxUCl+xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NbcbKfbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28619C4CED3;
	Tue, 17 Dec 2024 17:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734455694;
	bh=jXVHZVdKrsnU3V5+W2sNNraEaIgHqqxegrfAMErZ064=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbcbKfbqRE82k1nqA1XjdETQ6cR4UqgAwxkL5+nTN9DIAqk7ujGkAhL+/PYN7plIN
	 c5PtCCYxac2tIS8riWZqruTEFysSkBWQBy22NU5/ItVvJucO9n3JErydgZ6d0YCFvw
	 7EpXnfnAnyc50ZLs+a12npKzH5JxE7lS20t77DnY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+46aa5474f179dacd1a3b@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 22/51] tipc: fix NULL deref in cleanup_bearer()
Date: Tue, 17 Dec 2024 18:07:15 +0100
Message-ID: <20241217170521.204160057@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170520.301972474@linuxfoundation.org>
References: <20241217170520.301972474@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b04d86fff66b15c07505d226431f808c15b1703c ]

syzbot found [1] that after blamed commit, ub->ubsock->sk
was NULL when attempting the atomic_dec() :

atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);

Fix this by caching the tipc_net pointer.

[1]

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 0 UID: 0 PID: 5896 Comm: kworker/0:3 Not tainted 6.13.0-rc1-next-20241203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events cleanup_bearer
 RIP: 0010:read_pnet include/net/net_namespace.h:387 [inline]
 RIP: 0010:sock_net include/net/sock.h:655 [inline]
 RIP: 0010:cleanup_bearer+0x1f7/0x280 net/tipc/udp_media.c:820
Code: 18 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 3c f7 99 f6 48 8b 1b 48 83 c3 30 e8 f0 e4 60 00 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 1a f7 99 f6 49 83 c7 e8 48 8b 1b
RSP: 0018:ffffc9000410fb70 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: ffff88802fe45a00
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffc9000410f900
RBP: ffff88807e1f0908 R08: ffffc9000410f907 R09: 1ffff92000821f20
R10: dffffc0000000000 R11: fffff52000821f21 R12: ffff888031d19980
R13: dffffc0000000000 R14: dffffc0000000000 R15: ffff88807e1f0918
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556ca050b000 CR3: 0000000031c0c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Fixes: 6a2fa13312e5 ("tipc: Fix use-after-free of kernel socket in cleanup_bearer().")
Reported-by: syzbot+46aa5474f179dacd1a3b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67508b5f.050a0220.17bd51.0070.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20241204170548.4152658-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/udp_media.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 3f5a12b85b2d..f5bd75d931c1 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -811,6 +811,7 @@ static void cleanup_bearer(struct work_struct *work)
 {
 	struct udp_bearer *ub = container_of(work, struct udp_bearer, work);
 	struct udp_replicast *rcast, *tmp;
+	struct tipc_net *tn;
 
 	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
 		dst_cache_destroy(&rcast->dst_cache);
@@ -818,10 +819,14 @@ static void cleanup_bearer(struct work_struct *work)
 		kfree_rcu(rcast, rcu);
 	}
 
+	tn = tipc_net(sock_net(ub->ubsock->sk));
+
 	dst_cache_destroy(&ub->rcast.dst_cache);
 	udp_tunnel_sock_release(ub->ubsock);
+
+	/* Note: could use a call_rcu() to avoid another synchronize_net() */
 	synchronize_net();
-	atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
+	atomic_dec(&tn->wq_count);
 	kfree(ub);
 }
 
-- 
2.39.5




