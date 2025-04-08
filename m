Return-Path: <stable+bounces-129389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F9A7FEA0
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 203B97A1E24
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAAB2676C0;
	Tue,  8 Apr 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BBKyvsxV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693D5265CAF;
	Tue,  8 Apr 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110892; cv=none; b=f9YeHV6LuEqtmLu3589gqBnluB9B1EbNZYVp0lgn+QQ9rd5uFchg6Y1h2CrT5K4ZC6/2CheIYInYgDHMbkGDg8/BdxmxD8xYHLxnFE8eugvKTJ0IheAc1TFA3TyrydzEf7DAVRTcq3ETQsfDtalhuaby4F4tv8eHFWkFFKmG7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110892; c=relaxed/simple;
	bh=kBfFw8GKRLoeU0R4X6bN3nu0FR92v46eu63V1aVxKi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzIMS1hDGjsZa6xQSCnsQUujtZZdFbUFE/JFptdh74ixkuDM7mqsuvJVwEaQPHTsyxtPuMKVNNhyQPdANT3KSPFSU236iQLlbJ5vfaKM1qLrlVQWajnwchsoA/tD+R67PRS/t0kDLYGtbDvIri+WJL2yexznSdiChgmlt8RmOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BBKyvsxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEE5C4CEE5;
	Tue,  8 Apr 2025 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744110892;
	bh=kBfFw8GKRLoeU0R4X6bN3nu0FR92v46eu63V1aVxKi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBKyvsxVB0jnOlQ1P3+juQxDwmmp/LTO7rygDYwj/kxR+23wk4j5QgbxoWw43G6PL
	 Of5wmWMX1rGYYsn6f+Pv+4+KJcwHACxDZz3pB4kBRWkTI0GgcaAGm7V6f1upRxc4yX
	 IzsZ7qJkbdXlOsOFnDizQcG3FVZabHRa5PVESIA0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+33841dc6aa3e1d86b78a@syzkaller.appspotmail.com,
	Murad Masimov <m.masimov@mt-integration.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 233/731] ax25: Remove broken autobind
Date: Tue,  8 Apr 2025 12:42:10 +0200
Message-ID: <20250408104919.701382930@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Murad Masimov <m.masimov@mt-integration.ru>

[ Upstream commit 2f6efbabceb6b2914ee9bafb86d9a51feae9cce8 ]

Binding AX25 socket by using the autobind feature leads to memory leaks
in ax25_connect() and also refcount leaks in ax25_release(). Memory
leak was detected with kmemleak:

================================================================
unreferenced object 0xffff8880253cd680 (size 96):
backtrace:
__kmalloc_node_track_caller_noprof (./include/linux/kmemleak.h:43)
kmemdup_noprof (mm/util.c:136)
ax25_rt_autobind (net/ax25/ax25_route.c:428)
ax25_connect (net/ax25/af_ax25.c:1282)
__sys_connect_file (net/socket.c:2045)
__sys_connect (net/socket.c:2064)
__x64_sys_connect (net/socket.c:2067)
do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
================================================================

When socket is bound, refcounts must be incremented the way it is done
in ax25_bind() and ax25_setsockopt() (SO_BINDTODEVICE). In case of
autobind, the refcounts are not incremented.

This bug leads to the following issue reported by Syzkaller:

================================================================
ax25_connect(): syz-executor318 uses autobind, please contact jreuter@yaina.de
------------[ cut here ]------------
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 0 PID: 5317 at lib/refcount.c:31 refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
Modules linked in:
CPU: 0 UID: 0 PID: 5317 Comm: syz-executor318 Not tainted 6.14.0-rc4-syzkaller-00278-gece144f151ac #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
...
Call Trace:
 <TASK>
 __refcount_dec include/linux/refcount.h:336 [inline]
 refcount_dec include/linux/refcount.h:351 [inline]
 ref_tracker_free+0x6af/0x7e0 lib/ref_tracker.c:236
 netdev_tracker_free include/linux/netdevice.h:4302 [inline]
 netdev_put include/linux/netdevice.h:4319 [inline]
 ax25_release+0x368/0x960 net/ax25/af_ax25.c:1080
 __sock_release net/socket.c:647 [inline]
 sock_close+0xbc/0x240 net/socket.c:1398
 __fput+0x3e9/0x9f0 fs/file_table.c:464
 __do_sys_close fs/open.c:1580 [inline]
 __se_sys_close fs/open.c:1565 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1565
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 ...
 </TASK>
================================================================

Considering the issues above and the comments left in the code that say:
"check if we can remove this feature. It is broken."; "autobinding in this
may or may not work"; - it is better to completely remove this feature than
to fix it because it is broken and leads to various kinds of memory bugs.

Now calling connect() without first binding socket will result in an
error (-EINVAL). Userspace software that relies on the autobind feature
might get broken. However, this feature does not seem widely used with
this specific driver as it was not reliable at any point of time, and it
is already broken anyway. E.g. ax25-tools and ax25-apps packages for
popular distributions do not use the autobind feature for AF_AX25.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+33841dc6aa3e1d86b78a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=33841dc6aa3e1d86b78a
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ax25.h    |  1 -
 net/ax25/af_ax25.c    | 30 ++++++------------
 net/ax25/ax25_route.c | 74 -------------------------------------------
 3 files changed, 10 insertions(+), 95 deletions(-)

diff --git a/include/net/ax25.h b/include/net/ax25.h
index 4ee141aae0a29..a7bba42dde153 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -418,7 +418,6 @@ void ax25_rt_device_down(struct net_device *);
 int ax25_rt_ioctl(unsigned int, void __user *);
 extern const struct seq_operations ax25_rt_seqops;
 ax25_route *ax25_get_route(ax25_address *addr, struct net_device *dev);
-int ax25_rt_autobind(ax25_cb *, ax25_address *);
 struct sk_buff *ax25_rt_build_path(struct sk_buff *, ax25_address *,
 				   ax25_address *, ax25_digi *);
 void ax25_rt_free(void);
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 9f3b8b682adb2..3ee7dba343100 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1270,28 +1270,18 @@ static int __must_check ax25_connect(struct socket *sock,
 		}
 	}
 
-	/*
-	 *	Must bind first - autobinding in this may or may not work. If
-	 *	the socket is already bound, check to see if the device has
-	 *	been filled in, error if it hasn't.
-	 */
+	/* Must bind first - autobinding does not work. */
 	if (sock_flag(sk, SOCK_ZAPPED)) {
-		/* check if we can remove this feature. It is broken. */
-		printk(KERN_WARNING "ax25_connect(): %s uses autobind, please contact jreuter@yaina.de\n",
-			current->comm);
-		if ((err = ax25_rt_autobind(ax25, &fsa->fsa_ax25.sax25_call)) < 0) {
-			kfree(digi);
-			goto out_release;
-		}
+		kfree(digi);
+		err = -EINVAL;
+		goto out_release;
+	}
 
-		ax25_fillin_cb(ax25, ax25->ax25_dev);
-		ax25_cb_add(ax25);
-	} else {
-		if (ax25->ax25_dev == NULL) {
-			kfree(digi);
-			err = -EHOSTUNREACH;
-			goto out_release;
-		}
+	/* Check to see if the device has been filled in, error if it hasn't. */
+	if (ax25->ax25_dev == NULL) {
+		kfree(digi);
+		err = -EHOSTUNREACH;
+		goto out_release;
 	}
 
 	if (sk->sk_type == SOCK_SEQPACKET &&
diff --git a/net/ax25/ax25_route.c b/net/ax25/ax25_route.c
index 69de75db0c9c2..10577434f40bf 100644
--- a/net/ax25/ax25_route.c
+++ b/net/ax25/ax25_route.c
@@ -373,80 +373,6 @@ ax25_route *ax25_get_route(ax25_address *addr, struct net_device *dev)
 	return ax25_rt;
 }
 
-/*
- *	Adjust path: If you specify a default route and want to connect
- *      a target on the digipeater path but w/o having a special route
- *	set before, the path has to be truncated from your target on.
- */
-static inline void ax25_adjust_path(ax25_address *addr, ax25_digi *digipeat)
-{
-	int k;
-
-	for (k = 0; k < digipeat->ndigi; k++) {
-		if (ax25cmp(addr, &digipeat->calls[k]) == 0)
-			break;
-	}
-
-	digipeat->ndigi = k;
-}
-
-
-/*
- *	Find which interface to use.
- */
-int ax25_rt_autobind(ax25_cb *ax25, ax25_address *addr)
-{
-	ax25_uid_assoc *user;
-	ax25_route *ax25_rt;
-	int err = 0;
-
-	ax25_route_lock_use();
-	ax25_rt = ax25_get_route(addr, NULL);
-	if (!ax25_rt) {
-		ax25_route_lock_unuse();
-		return -EHOSTUNREACH;
-	}
-	rcu_read_lock();
-	if ((ax25->ax25_dev = ax25_dev_ax25dev(ax25_rt->dev)) == NULL) {
-		err = -EHOSTUNREACH;
-		goto put;
-	}
-
-	user = ax25_findbyuid(current_euid());
-	if (user) {
-		ax25->source_addr = user->call;
-		ax25_uid_put(user);
-	} else {
-		if (ax25_uid_policy && !capable(CAP_NET_BIND_SERVICE)) {
-			err = -EPERM;
-			goto put;
-		}
-		ax25->source_addr = *(ax25_address *)ax25->ax25_dev->dev->dev_addr;
-	}
-
-	if (ax25_rt->digipeat != NULL) {
-		ax25->digipeat = kmemdup(ax25_rt->digipeat, sizeof(ax25_digi),
-					 GFP_ATOMIC);
-		if (ax25->digipeat == NULL) {
-			err = -ENOMEM;
-			goto put;
-		}
-		ax25_adjust_path(addr, ax25->digipeat);
-	}
-
-	if (ax25->sk != NULL) {
-		local_bh_disable();
-		bh_lock_sock(ax25->sk);
-		sock_reset_flag(ax25->sk, SOCK_ZAPPED);
-		bh_unlock_sock(ax25->sk);
-		local_bh_enable();
-	}
-
-put:
-	rcu_read_unlock();
-	ax25_route_lock_unuse();
-	return err;
-}
 
 struct sk_buff *ax25_rt_build_path(struct sk_buff *skb, ax25_address *src,
 	ax25_address *dest, ax25_digi *digi)
-- 
2.39.5




