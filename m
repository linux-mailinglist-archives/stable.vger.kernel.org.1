Return-Path: <stable+bounces-112719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7096A28E13
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50424164F14
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526EB1494DF;
	Wed,  5 Feb 2025 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AgXGyH2J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E161F510;
	Wed,  5 Feb 2025 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764515; cv=none; b=JTW2rlQmgC834h4YK9S87Hj5bAP2rjE5o9jAdSXwJvl8fRY/dvo7+bJ2x66dpCZ8eiHRk8uSTza1nVKkzTEGYgFLcCLTdIA1nM7mVD/BzH7ZJVbdjSqA3D+UyKJooGLbS8GVI+vhsH9IbzeDlGIn96eJXBhSJksKOjHin6fLxns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764515; c=relaxed/simple;
	bh=Q8ZVTManJTRiADgkbFILOCdgq876nDowtuEluvTAob4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llGjzZgn9wZgbJHrPoP3z1YmxDTG+I23jYZB6tto8QXuif6ffSV1NRkyQjdX01cu1rSXiDw4pQeBEMR9p4DRws8/W1ZeCw1qWJ7qr7KN2LAMtKHs6EOdJexABS09HVgoCUkf9bnJMRWWXeES34ce+/VNh5SHjT6huzFzebI5BtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AgXGyH2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A250C4CED1;
	Wed,  5 Feb 2025 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738764514;
	bh=Q8ZVTManJTRiADgkbFILOCdgq876nDowtuEluvTAob4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AgXGyH2JsUnQQvWb2E9FkNuFWrlcs0XoMABRpDlZuOF7ivnahnM1QoWfEbnYQbN1W
	 7VIOCJLxy0O/YgmBXMoAJpI+/PU62hwoxOT7wCwBT3z6a0ikU8qwirHFmvSni4tGlJ
	 b43JJFyuEABt23nesO4qQ5hmL2V4DGEYhIZMin+U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 134/590] ax25: rcu protect dev->ax25_ptr
Date: Wed,  5 Feb 2025 14:38:09 +0100
Message-ID: <20250205134500.393910070@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 95fc45d1dea8e1253f8ec58abc5befb71553d666 ]

syzbot found a lockdep issue [1].

We should remove ax25 RTNL dependency in ax25_setsockopt()

This should also fix a variety of possible UAF in ax25.

[1]

WARNING: possible circular locking dependency detected
6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0 Not tainted
------------------------------------------------------
syz.5.1818/12806 is trying to acquire lock:
 ffffffff8fcb3988 (rtnl_mutex){+.+.}-{4:4}, at: ax25_setsockopt+0xa55/0xe90 net/ax25/af_ax25.c:680

but task is already holding lock:
 ffff8880617ac258 (sk_lock-AF_AX25){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1618 [inline]
 ffff8880617ac258 (sk_lock-AF_AX25){+.+.}-{0:0}, at: ax25_setsockopt+0x209/0xe90 net/ax25/af_ax25.c:574

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (sk_lock-AF_AX25){+.+.}-{0:0}:
        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
        lock_sock_nested+0x48/0x100 net/core/sock.c:3642
        lock_sock include/net/sock.h:1618 [inline]
        ax25_kill_by_device net/ax25/af_ax25.c:101 [inline]
        ax25_device_event+0x24d/0x580 net/ax25/af_ax25.c:146
        notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
       __dev_notify_flags+0x207/0x400
        dev_change_flags+0xf0/0x1a0 net/core/dev.c:9026
        dev_ifsioc+0x7c8/0xe70 net/core/dev_ioctl.c:563
        dev_ioctl+0x719/0x1340 net/core/dev_ioctl.c:820
        sock_do_ioctl+0x240/0x460 net/socket.c:1234
        sock_ioctl+0x626/0x8e0 net/socket.c:1339
        vfs_ioctl fs/ioctl.c:51 [inline]
        __do_sys_ioctl fs/ioctl.c:906 [inline]
        __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (rtnl_mutex){+.+.}-{4:4}:
        check_prev_add kernel/locking/lockdep.c:3161 [inline]
        check_prevs_add kernel/locking/lockdep.c:3280 [inline]
        validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
        __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
        __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
        ax25_setsockopt+0xa55/0xe90 net/ax25/af_ax25.c:680
        do_sock_setsockopt+0x3af/0x720 net/socket.c:2324
        __sys_setsockopt net/socket.c:2349 [inline]
        __do_sys_setsockopt net/socket.c:2355 [inline]
        __se_sys_setsockopt net/socket.c:2352 [inline]
        __x64_sys_setsockopt+0x1ee/0x280 net/socket.c:2352
        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
        do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_AX25);
                               lock(rtnl_mutex);
                               lock(sk_lock-AF_AX25);
  lock(rtnl_mutex);

 *** DEADLOCK ***

1 lock held by syz.5.1818/12806:
  #0: ffff8880617ac258 (sk_lock-AF_AX25){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1618 [inline]
  #0: ffff8880617ac258 (sk_lock-AF_AX25){+.+.}-{0:0}, at: ax25_setsockopt+0x209/0xe90 net/ax25/af_ax25.c:574

stack backtrace:
CPU: 1 UID: 0 PID: 12806 Comm: syz.5.1818 Not tainted 6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:94 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
  print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
  check_prev_add kernel/locking/lockdep.c:3161 [inline]
  check_prevs_add kernel/locking/lockdep.c:3280 [inline]
  validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
  __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
  __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
  ax25_setsockopt+0xa55/0xe90 net/ax25/af_ax25.c:680
  do_sock_setsockopt+0x3af/0x720 net/socket.c:2324
  __sys_setsockopt net/socket.c:2349 [inline]
  __do_sys_setsockopt net/socket.c:2355 [inline]
  __se_sys_setsockopt net/socket.c:2352 [inline]
  __x64_sys_setsockopt+0x1ee/0x280 net/socket.c:2352
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7b62385d29

Fixes: c433570458e4 ("ax25: fix a use-after-free in ax25_fillin_cb()")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250103210514.87290-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netdevice.h |  2 +-
 include/net/ax25.h        | 10 +++++-----
 net/ax25/af_ax25.c        | 12 ++++++------
 net/ax25/ax25_dev.c       |  4 ++--
 net/ax25/ax25_ip.c        |  3 ++-
 net/ax25/ax25_out.c       | 22 +++++++++++++++++-----
 net/ax25/ax25_route.c     |  2 ++
 7 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8896705ccd638..02d3bafebbe77 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2222,7 +2222,7 @@ struct net_device {
 	void 			*atalk_ptr;
 #endif
 #if IS_ENABLED(CONFIG_AX25)
-	void			*ax25_ptr;
+	struct ax25_dev	__rcu	*ax25_ptr;
 #endif
 #if IS_ENABLED(CONFIG_CFG80211)
 	struct wireless_dev	*ieee80211_ptr;
diff --git a/include/net/ax25.h b/include/net/ax25.h
index cb622d84cd0cc..4ee141aae0a29 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -231,6 +231,7 @@ typedef struct ax25_dev {
 #endif
 	refcount_t		refcount;
 	bool device_up;
+	struct rcu_head		rcu;
 } ax25_dev;
 
 typedef struct ax25_cb {
@@ -290,9 +291,8 @@ static inline void ax25_dev_hold(ax25_dev *ax25_dev)
 
 static inline void ax25_dev_put(ax25_dev *ax25_dev)
 {
-	if (refcount_dec_and_test(&ax25_dev->refcount)) {
-		kfree(ax25_dev);
-	}
+	if (refcount_dec_and_test(&ax25_dev->refcount))
+		kfree_rcu(ax25_dev, rcu);
 }
 static inline __be16 ax25_type_trans(struct sk_buff *skb, struct net_device *dev)
 {
@@ -335,9 +335,9 @@ void ax25_digi_invert(const ax25_digi *, ax25_digi *);
 extern spinlock_t ax25_dev_lock;
 
 #if IS_ENABLED(CONFIG_AX25)
-static inline ax25_dev *ax25_dev_ax25dev(struct net_device *dev)
+static inline ax25_dev *ax25_dev_ax25dev(const struct net_device *dev)
 {
-	return dev->ax25_ptr;
+	return rcu_dereference_rtnl(dev->ax25_ptr);
 }
 #endif
 
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index d6f9fae06a9d8..aa6c714892ec9 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -467,7 +467,7 @@ static int ax25_ctl_ioctl(const unsigned int cmd, void __user *arg)
 	goto out_put;
 }
 
-static void ax25_fillin_cb_from_dev(ax25_cb *ax25, ax25_dev *ax25_dev)
+static void ax25_fillin_cb_from_dev(ax25_cb *ax25, const ax25_dev *ax25_dev)
 {
 	ax25->rtt     = msecs_to_jiffies(ax25_dev->values[AX25_VALUES_T1]) / 2;
 	ax25->t1      = msecs_to_jiffies(ax25_dev->values[AX25_VALUES_T1]);
@@ -677,22 +677,22 @@ static int ax25_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		rtnl_lock();
-		dev = __dev_get_by_name(&init_net, devname);
+		rcu_read_lock();
+		dev = dev_get_by_name_rcu(&init_net, devname);
 		if (!dev) {
-			rtnl_unlock();
+			rcu_read_unlock();
 			res = -ENODEV;
 			break;
 		}
 
 		ax25->ax25_dev = ax25_dev_ax25dev(dev);
 		if (!ax25->ax25_dev) {
-			rtnl_unlock();
+			rcu_read_unlock();
 			res = -ENODEV;
 			break;
 		}
 		ax25_fillin_cb(ax25, ax25->ax25_dev);
-		rtnl_unlock();
+		rcu_read_unlock();
 		break;
 
 	default:
diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index 9efd6690b3443..3733c0254a508 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -90,7 +90,7 @@ void ax25_dev_device_up(struct net_device *dev)
 
 	spin_lock_bh(&ax25_dev_lock);
 	list_add(&ax25_dev->list, &ax25_dev_list);
-	dev->ax25_ptr     = ax25_dev;
+	rcu_assign_pointer(dev->ax25_ptr, ax25_dev);
 	spin_unlock_bh(&ax25_dev_lock);
 
 	ax25_register_dev_sysctl(ax25_dev);
@@ -125,7 +125,7 @@ void ax25_dev_device_down(struct net_device *dev)
 		}
 	}
 
-	dev->ax25_ptr = NULL;
+	RCU_INIT_POINTER(dev->ax25_ptr, NULL);
 	spin_unlock_bh(&ax25_dev_lock);
 	netdev_put(dev, &ax25_dev->dev_tracker);
 	ax25_dev_put(ax25_dev);
diff --git a/net/ax25/ax25_ip.c b/net/ax25/ax25_ip.c
index 36249776c021e..215d4ccf12b91 100644
--- a/net/ax25/ax25_ip.c
+++ b/net/ax25/ax25_ip.c
@@ -122,6 +122,7 @@ netdev_tx_t ax25_ip_xmit(struct sk_buff *skb)
 	if (dev == NULL)
 		dev = skb->dev;
 
+	rcu_read_lock();
 	if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL) {
 		kfree_skb(skb);
 		goto put;
@@ -202,7 +203,7 @@ netdev_tx_t ax25_ip_xmit(struct sk_buff *skb)
 	ax25_queue_xmit(skb, dev);
 
 put:
-
+	rcu_read_unlock();
 	ax25_route_lock_unuse();
 	return NETDEV_TX_OK;
 }
diff --git a/net/ax25/ax25_out.c b/net/ax25/ax25_out.c
index 3db76d2470e95..8bca2ace98e51 100644
--- a/net/ax25/ax25_out.c
+++ b/net/ax25/ax25_out.c
@@ -39,10 +39,14 @@ ax25_cb *ax25_send_frame(struct sk_buff *skb, int paclen, const ax25_address *sr
 	 * specified.
 	 */
 	if (paclen == 0) {
-		if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL)
+		rcu_read_lock();
+		ax25_dev = ax25_dev_ax25dev(dev);
+		if (!ax25_dev) {
+			rcu_read_unlock();
 			return NULL;
-
+		}
 		paclen = ax25_dev->values[AX25_VALUES_PACLEN];
+		rcu_read_unlock();
 	}
 
 	/*
@@ -53,13 +57,19 @@ ax25_cb *ax25_send_frame(struct sk_buff *skb, int paclen, const ax25_address *sr
 		return ax25;		/* It already existed */
 	}
 
-	if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL)
+	rcu_read_lock();
+	ax25_dev = ax25_dev_ax25dev(dev);
+	if (!ax25_dev) {
+		rcu_read_unlock();
 		return NULL;
+	}
 
-	if ((ax25 = ax25_create_cb()) == NULL)
+	if ((ax25 = ax25_create_cb()) == NULL) {
+		rcu_read_unlock();
 		return NULL;
-
+	}
 	ax25_fillin_cb(ax25, ax25_dev);
+	rcu_read_unlock();
 
 	ax25->source_addr = *src;
 	ax25->dest_addr   = *dest;
@@ -358,7 +368,9 @@ void ax25_queue_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	unsigned char *ptr;
 
+	rcu_read_lock();
 	skb->protocol = ax25_type_trans(skb, ax25_fwd_dev(dev));
+	rcu_read_unlock();
 
 	ptr  = skb_push(skb, 1);
 	*ptr = 0x00;			/* KISS */
diff --git a/net/ax25/ax25_route.c b/net/ax25/ax25_route.c
index b7c4d656a94b7..69de75db0c9c2 100644
--- a/net/ax25/ax25_route.c
+++ b/net/ax25/ax25_route.c
@@ -406,6 +406,7 @@ int ax25_rt_autobind(ax25_cb *ax25, ax25_address *addr)
 		ax25_route_lock_unuse();
 		return -EHOSTUNREACH;
 	}
+	rcu_read_lock();
 	if ((ax25->ax25_dev = ax25_dev_ax25dev(ax25_rt->dev)) == NULL) {
 		err = -EHOSTUNREACH;
 		goto put;
@@ -442,6 +443,7 @@ int ax25_rt_autobind(ax25_cb *ax25, ax25_address *addr)
 	}
 
 put:
+	rcu_read_unlock();
 	ax25_route_lock_unuse();
 	return err;
 }
-- 
2.39.5




