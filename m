Return-Path: <stable+bounces-103795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 401639EF9B6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8422D18987D1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB56225A22;
	Thu, 12 Dec 2024 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pjbc0sBu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35400226547;
	Thu, 12 Dec 2024 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025626; cv=none; b=Vx9M7dMZIUVb4vj9LvVpV0qh6BoY1TrvG38SK9fZB0F3jMGZuYHWKm/SnTN2bXgMw9O9EGj5s5eZF87vRYcWt4zL4pENqj211jtvGvRoW7cKV4/Hfe5BIkjK2alXhxLR1a1MhOY6Dmi6loG7m7rQQb2ha7S6A8LYRDB+gG36OBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025626; c=relaxed/simple;
	bh=vvOCIcGJIiFSu5m97Qf0x9Zjuw3bqkZ8l1PAW1gadSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pyz1JYaLx8B+zLyk+rxt07xLpd5PlY0ktyGaRMYL6ijbheq16gMB2P/dIiMXTWzXO/pUbyGPNsG8D7d8HrjZcMwJ+IelDBQu+a45z6Wo1/UR88hY7L7YxsRCOFnLQUPUjAaL8rQIu1Tt/gbOwYmxMsPiNBLDPBFQSP52WsZyH1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pjbc0sBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449ACC4CED3;
	Thu, 12 Dec 2024 17:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025625;
	bh=vvOCIcGJIiFSu5m97Qf0x9Zjuw3bqkZ8l1PAW1gadSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pjbc0sBuqtTuXamCtc7VQfIxO/6///JZnYN1CiByJxujP0RrmjMDgbFSy0er8BpNw
	 HMwP7yfir/2VYs7mWeBDRXQZc0MIivH0ULiMGkuPvlmxz/dQO8pGm3Z5g4LduqE+18
	 AEH2MvPoP5cYEVzl38aHqTSf769c+ggZbmkNb4L4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzkaller <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 232/321] tipc: Fix use-after-free of kernel socket in cleanup_bearer().
Date: Thu, 12 Dec 2024 16:02:30 +0100
Message-ID: <20241212144239.139169483@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 6a2fa13312e51a621f652d522d7e2df7066330b6 ]

syzkaller reported a use-after-free of UDP kernel socket
in cleanup_bearer() without repro. [0][1]

When bearer_disable() calls tipc_udp_disable(), cleanup
of the UDP kernel socket is deferred by work calling
cleanup_bearer().

tipc_net_stop() waits for such works to finish by checking
tipc_net(net)->wq_count.  However, the work decrements the
count too early before releasing the kernel socket,
unblocking cleanup_net() and resulting in use-after-free.

Let's move the decrement after releasing the socket in
cleanup_bearer().

[0]:
ref_tracker: net notrefcnt@000000009b3d1faf has 1/1 users at
     sk_alloc+0x438/0x608
     inet_create+0x4c8/0xcb0
     __sock_create+0x350/0x6b8
     sock_create_kern+0x58/0x78
     udp_sock_create4+0x68/0x398
     udp_sock_create+0x88/0xc8
     tipc_udp_enable+0x5e8/0x848
     __tipc_nl_bearer_enable+0x84c/0xed8
     tipc_nl_bearer_enable+0x38/0x60
     genl_family_rcv_msg_doit+0x170/0x248
     genl_rcv_msg+0x400/0x5b0
     netlink_rcv_skb+0x1dc/0x398
     genl_rcv+0x44/0x68
     netlink_unicast+0x678/0x8b0
     netlink_sendmsg+0x5e4/0x898
     ____sys_sendmsg+0x500/0x830

[1]:
BUG: KMSAN: use-after-free in udp_hashslot include/net/udp.h:85 [inline]
BUG: KMSAN: use-after-free in udp_lib_unhash+0x3b8/0x930 net/ipv4/udp.c:1979
 udp_hashslot include/net/udp.h:85 [inline]
 udp_lib_unhash+0x3b8/0x930 net/ipv4/udp.c:1979
 sk_common_release+0xaf/0x3f0 net/core/sock.c:3820
 inet_release+0x1e0/0x260 net/ipv4/af_inet.c:437
 inet6_release+0x6f/0xd0 net/ipv6/af_inet6.c:489
 __sock_release net/socket.c:658 [inline]
 sock_release+0xa0/0x210 net/socket.c:686
 cleanup_bearer+0x42d/0x4c0 net/tipc/udp_media.c:819
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xcaf/0x1c90 kernel/workqueue.c:3310
 worker_thread+0xf6c/0x1510 kernel/workqueue.c:3391
 kthread+0x531/0x6b0 kernel/kthread.c:389
 ret_from_fork+0x60/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_free_hook mm/slub.c:2269 [inline]
 slab_free mm/slub.c:4580 [inline]
 kmem_cache_free+0x207/0xc40 mm/slub.c:4682
 net_free net/core/net_namespace.c:454 [inline]
 cleanup_net+0x16f2/0x19d0 net/core/net_namespace.c:647
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xcaf/0x1c90 kernel/workqueue.c:3310
 worker_thread+0xf6c/0x1510 kernel/workqueue.c:3391
 kthread+0x531/0x6b0 kernel/kthread.c:389
 ret_from_fork+0x60/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244

CPU: 0 UID: 0 PID: 54 Comm: kworker/0:2 Not tainted 6.12.0-rc1-00131-gf66ebf37d69c #7 91723d6f74857f70725e1583cba3cf4adc716cfa
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cleanup_bearer

Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20241127050512.28438-1-kuniyu@amazon.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/udp_media.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 4db2185a32aec..696a21208b24b 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -805,10 +805,10 @@ static void cleanup_bearer(struct work_struct *work)
 		kfree_rcu(rcast, rcu);
 	}
 
-	atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
 	dst_cache_destroy(&ub->rcast.dst_cache);
 	udp_tunnel_sock_release(ub->ubsock);
 	synchronize_net();
+	atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
 	kfree(ub);
 }
 
-- 
2.43.0




