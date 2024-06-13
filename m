Return-Path: <stable+bounces-50626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 956F7906B9B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7761F242C8
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7371448EB;
	Thu, 13 Jun 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c+fvz+Rj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E7143871;
	Thu, 13 Jun 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278917; cv=none; b=ZBhMdjB6gCr/4ee6TZORyNOWjMROeYpSEGPs6YHHUvY3u1Inq2WMTArIeHfN/4xmM6PC/wXxi2n13hVWCzOk63uIsXE5eWqIlNDt5fEQQnXrTN/x/7LcjPykppJvE1M6bXB2jEEFJg7/C1r0zacQ1NPrqYmDIX9F1elo9vVrJmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278917; c=relaxed/simple;
	bh=JVoyw09LjbgOXUEjPiiaFj6Xs6RiLYhrnXqsQloTtaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyaKGWo8mVZsgwL4hI3L6V5eO4cUTdSlDJdyHcXyYMA56fxz+nc3TkDwF2NsWLqd/3n2CTd95a7+nSEYPQvoBzW4WPXlB9vB14OWbratyDHu1bpc9WtgUcA/JzRR+r+0KIJGvcuWC0lawlvhAKiFzNB851D0XhTMWoSPzO2Uj1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c+fvz+Rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0E1C2BBFC;
	Thu, 13 Jun 2024 11:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718278917;
	bh=JVoyw09LjbgOXUEjPiiaFj6Xs6RiLYhrnXqsQloTtaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+fvz+RjNJPb87DAo67HlKDfzuRM1qCNl9sx9YEUms5xRsj2LuOQGtmAOTmJxMe5m
	 fmhbAArmCvUnbJTjLSL4G6V4OmMzZnjKj5Fta21p+zIbGrijHe1ev9137pebdPcIWk
	 n3YiRioB3eLs84S7D0inx+hCMVhgUJYTq+gc4ERg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 083/213] netrom: fix possible dead-lock in nr_rt_ioctl()
Date: Thu, 13 Jun 2024 13:32:11 +0200
Message-ID: <20240613113231.212691289@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
References: <20240613113227.969123070@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit e03e7f20ebf7e1611d40d1fdc1bde900fd3335f6 ]

syzbot loves netrom, and found a possible deadlock in nr_rt_ioctl [1]

Make sure we always acquire nr_node_list_lock before nr_node_lock(nr_node)

[1]
WARNING: possible circular locking dependency detected
6.9.0-rc7-syzkaller-02147-g654de42f3fc6 #0 Not tainted
------------------------------------------------------
syz-executor350/5129 is trying to acquire lock:
 ffff8880186e2070 (&nr_node->node_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 ffff8880186e2070 (&nr_node->node_lock){+...}-{2:2}, at: nr_node_lock include/net/netrom.h:152 [inline]
 ffff8880186e2070 (&nr_node->node_lock){+...}-{2:2}, at: nr_dec_obs net/netrom/nr_route.c:464 [inline]
 ffff8880186e2070 (&nr_node->node_lock){+...}-{2:2}, at: nr_rt_ioctl+0x1bb/0x1090 net/netrom/nr_route.c:697

but task is already holding lock:
 ffffffff8f7053b8 (nr_node_list_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 ffffffff8f7053b8 (nr_node_list_lock){+...}-{2:2}, at: nr_dec_obs net/netrom/nr_route.c:462 [inline]
 ffffffff8f7053b8 (nr_node_list_lock){+...}-{2:2}, at: nr_rt_ioctl+0x10a/0x1090 net/netrom/nr_route.c:697

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (nr_node_list_lock){+...}-{2:2}:
        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
        __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
        _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
        spin_lock_bh include/linux/spinlock.h:356 [inline]
        nr_remove_node net/netrom/nr_route.c:299 [inline]
        nr_del_node+0x4b4/0x820 net/netrom/nr_route.c:355
        nr_rt_ioctl+0xa95/0x1090 net/netrom/nr_route.c:683
        sock_do_ioctl+0x158/0x460 net/socket.c:1222
        sock_ioctl+0x629/0x8e0 net/socket.c:1341
        vfs_ioctl fs/ioctl.c:51 [inline]
        __do_sys_ioctl fs/ioctl.c:904 [inline]
        __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:890
        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&nr_node->node_lock){+...}-{2:2}:
        check_prev_add kernel/locking/lockdep.c:3134 [inline]
        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
        __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
        _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
        spin_lock_bh include/linux/spinlock.h:356 [inline]
        nr_node_lock include/net/netrom.h:152 [inline]
        nr_dec_obs net/netrom/nr_route.c:464 [inline]
        nr_rt_ioctl+0x1bb/0x1090 net/netrom/nr_route.c:697
        sock_do_ioctl+0x158/0x460 net/socket.c:1222
        sock_ioctl+0x629/0x8e0 net/socket.c:1341
        vfs_ioctl fs/ioctl.c:51 [inline]
        __do_sys_ioctl fs/ioctl.c:904 [inline]
        __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:890
        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(nr_node_list_lock);
                               lock(&nr_node->node_lock);
                               lock(nr_node_list_lock);
  lock(&nr_node->node_lock);

 *** DEADLOCK ***

1 lock held by syz-executor350/5129:
  #0: ffffffff8f7053b8 (nr_node_list_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
  #0: ffffffff8f7053b8 (nr_node_list_lock){+...}-{2:2}, at: nr_dec_obs net/netrom/nr_route.c:462 [inline]
  #0: ffffffff8f7053b8 (nr_node_list_lock){+...}-{2:2}, at: nr_rt_ioctl+0x10a/0x1090 net/netrom/nr_route.c:697

stack backtrace:
CPU: 0 PID: 5129 Comm: syz-executor350 Not tainted 6.9.0-rc7-syzkaller-02147-g654de42f3fc6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
  check_prev_add kernel/locking/lockdep.c:3134 [inline]
  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
  validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
  __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
  _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
  spin_lock_bh include/linux/spinlock.h:356 [inline]
  nr_node_lock include/net/netrom.h:152 [inline]
  nr_dec_obs net/netrom/nr_route.c:464 [inline]
  nr_rt_ioctl+0x1bb/0x1090 net/netrom/nr_route.c:697
  sock_do_ioctl+0x158/0x460 net/socket.c:1222
  sock_ioctl+0x629/0x8e0 net/socket.c:1341
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:904 [inline]
  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:890
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240515142934.3708038-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_route.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 744c19a7a469c..41c45b4d4b18c 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -287,22 +287,14 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 	return 0;
 }
 
-static inline void __nr_remove_node(struct nr_node *nr_node)
+static void nr_remove_node_locked(struct nr_node *nr_node)
 {
+	lockdep_assert_held(&nr_node_list_lock);
+
 	hlist_del_init(&nr_node->node_node);
 	nr_node_put(nr_node);
 }
 
-#define nr_remove_node_locked(__node) \
-	__nr_remove_node(__node)
-
-static void nr_remove_node(struct nr_node *nr_node)
-{
-	spin_lock_bh(&nr_node_list_lock);
-	__nr_remove_node(nr_node);
-	spin_unlock_bh(&nr_node_list_lock);
-}
-
 static inline void __nr_remove_neigh(struct nr_neigh *nr_neigh)
 {
 	hlist_del_init(&nr_neigh->neigh_node);
@@ -341,6 +333,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 		return -EINVAL;
 	}
 
+	spin_lock_bh(&nr_node_list_lock);
 	nr_node_lock(nr_node);
 	for (i = 0; i < nr_node->count; i++) {
 		if (nr_node->routes[i].neighbour == nr_neigh) {
@@ -354,7 +347,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 			nr_node->count--;
 
 			if (nr_node->count == 0) {
-				nr_remove_node(nr_node);
+				nr_remove_node_locked(nr_node);
 			} else {
 				switch (i) {
 				case 0:
@@ -368,12 +361,14 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 				nr_node_put(nr_node);
 			}
 			nr_node_unlock(nr_node);
+			spin_unlock_bh(&nr_node_list_lock);
 
 			return 0;
 		}
 	}
 	nr_neigh_put(nr_neigh);
 	nr_node_unlock(nr_node);
+	spin_unlock_bh(&nr_node_list_lock);
 	nr_node_put(nr_node);
 
 	return -EINVAL;
-- 
2.43.0




