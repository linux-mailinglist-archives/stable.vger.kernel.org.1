Return-Path: <stable+bounces-133575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD6AA9265E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5019188E41E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB35256C62;
	Thu, 17 Apr 2025 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eicRwa17"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D16B2566E9;
	Thu, 17 Apr 2025 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913490; cv=none; b=QzTpCpKaiMLNm3+r8ci9IeF5vexi4FZJcheT296noebO6FN29aZ3ikdt9aSYzvGLzzB47jzCBZQ/7zavu5oAi5syKHXSuU2N08w+StbFyDD1rL8+R2wK8IRgx3xbG9UbeHlZFZokU96kArg0jkevDPVCSm8K64YtDnzsMd/QZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913490; c=relaxed/simple;
	bh=KT6F84c5Q6AHwKEHdj/jjSicaeaWvm/9iWL3Gx6nQ3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GurufEcaZ+ItyMeSnX34SlMapqjZ3iK8pTCn0svCsy4gCUfAKIpaIZYgnvkNxweMkClZxkMCjQ46q5Wa1yvHHzvMmKB+k/TNDAvt2UuPiU0lbdjR5c8TIZQMnT4KA8VK7pDlbmseDA5h11k66oCPXMTeuwH+vq4+mOYF6hy2MUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eicRwa17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAA0C4CEE4;
	Thu, 17 Apr 2025 18:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913490;
	bh=KT6F84c5Q6AHwKEHdj/jjSicaeaWvm/9iWL3Gx6nQ3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eicRwa17ts+5iHzVwVjfl+4ZMzF91A4mcXTK/z1WUA7ENw4hqHM6aNpQTP95JUBxv
	 aE4MWcDCY36lociYoUUsVNTPo+o22ePr2yWOUsOJj9w6mR6ZZBuPWsWCVEb1cGavTn
	 Bb6hIfeh8Bsk2j39k9DDqmo3IOcSI2qWDU6F42vU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.14 355/449] net: Fix null-ptr-deref by sock_lock_init_class_and_name() and rmmod.
Date: Thu, 17 Apr 2025 19:50:43 +0200
Message-ID: <20250417175132.513707020@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>

commit 0bb2f7a1ad1f11d861f58e5ee5051c8974ff9569 upstream.

When I ran the repro [0] and waited a few seconds, I observed two
LOCKDEP splats: a warning immediately followed by a null-ptr-deref. [1]

Reproduction Steps:

  1) Mount CIFS
  2) Add an iptables rule to drop incoming FIN packets for CIFS
  3) Unmount CIFS
  4) Unload the CIFS module
  5) Remove the iptables rule

At step 3), the CIFS module calls sock_release() for the underlying
TCP socket, and it returns quickly.  However, the socket remains in
FIN_WAIT_1 because incoming FIN packets are dropped.

At this point, the module's refcnt is 0 while the socket is still
alive, so the following rmmod command succeeds.

  # ss -tan
  State      Recv-Q Send-Q Local Address:Port  Peer Address:Port
  FIN-WAIT-1 0      477        10.0.2.15:51062   10.0.0.137:445

  # lsmod | grep cifs
  cifs                 1159168  0

This highlights a discrepancy between the lifetime of the CIFS module
and the underlying TCP socket.  Even after CIFS calls sock_release()
and it returns, the TCP socket does not die immediately in order to
close the connection gracefully.

While this is generally fine, it causes an issue with LOCKDEP because
CIFS assigns a different lock class to the TCP socket's sk->sk_lock
using sock_lock_init_class_and_name().

Once an incoming packet is processed for the socket or a timer fires,
sk->sk_lock is acquired.

Then, LOCKDEP checks the lock context in check_wait_context(), where
hlock_class() is called to retrieve the lock class.  However, since
the module has already been unloaded, hlock_class() logs a warning
and returns NULL, triggering the null-ptr-deref.

If LOCKDEP is enabled, we must ensure that a module calling
sock_lock_init_class_and_name() (CIFS, NFS, etc) cannot be unloaded
while such a socket is still alive to prevent this issue.

Let's hold the module reference in sock_lock_init_class_and_name()
and release it when the socket is freed in sk_prot_free().

Note that sock_lock_init() clears sk->sk_owner for svc_create_socket()
that calls sock_lock_init_class_and_name() for a listening socket,
which clones a socket by sk_clone_lock() without GFP_ZERO.

[0]:
CIFS_SERVER="10.0.0.137"
CIFS_PATH="//${CIFS_SERVER}/Users/Administrator/Desktop/CIFS_TEST"
DEV="enp0s3"
CRED="/root/WindowsCredential.txt"

MNT=$(mktemp -d /tmp/XXXXXX)
mount -t cifs ${CIFS_PATH} ${MNT} -o vers=3.0,credentials=${CRED},cache=none,echo_interval=1

iptables -A INPUT -s ${CIFS_SERVER} -j DROP

for i in $(seq 10);
do
    umount ${MNT}
    rmmod cifs
    sleep 1
done

rm -r ${MNT}

iptables -D INPUT -s ${CIFS_SERVER} -j DROP

[1]:
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 10 PID: 0 at kernel/locking/lockdep.c:234 hlock_class (kernel/locking/lockdep.c:234 kernel/locking/lockdep.c:223)
Modules linked in: cifs_arc4 nls_ucs2_utils cifs_md4 [last unloaded: cifs]
CPU: 10 UID: 0 PID: 0 Comm: swapper/10 Not tainted 6.14.0 #36
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:hlock_class (kernel/locking/lockdep.c:234 kernel/locking/lockdep.c:223)
...
Call Trace:
 <IRQ>
 __lock_acquire (kernel/locking/lockdep.c:4853 kernel/locking/lockdep.c:5178)
 lock_acquire (kernel/locking/lockdep.c:469 kernel/locking/lockdep.c:5853 kernel/locking/lockdep.c:5816)
 _raw_spin_lock_nested (kernel/locking/spinlock.c:379)
 tcp_v4_rcv (./include/linux/skbuff.h:1678 ./include/net/tcp.h:2547 net/ipv4/tcp_ipv4.c:2350)
...

BUG: kernel NULL pointer dereference, address: 00000000000000c4
 PF: supervisor read access in kernel mode
 PF: error_code(0x0000) - not-present page
PGD 0
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 10 UID: 0 PID: 0 Comm: swapper/10 Tainted: G        W          6.14.0 #36
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:__lock_acquire (kernel/locking/lockdep.c:4852 kernel/locking/lockdep.c:5178)
Code: 15 41 09 c7 41 8b 44 24 20 25 ff 1f 00 00 41 09 c7 8b 84 24 a0 00 00 00 45 89 7c 24 20 41 89 44 24 24 e8 e1 bc ff ff 4c 89 e7 <44> 0f b6 b8 c4 00 00 00 e8 d1 bc ff ff 0f b6 80 c5 00 00 00 88 44
RSP: 0018:ffa0000000468a10 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ff1100010091cc38 RCX: 0000000000000027
RDX: ff1100081f09ca48 RSI: 0000000000000001 RDI: ff1100010091cc88
RBP: ff1100010091c200 R08: ff1100083fe6e228 R09: 00000000ffffbfff
R10: ff1100081eca0000 R11: ff1100083fe10dc0 R12: ff1100010091cc88
R13: 0000000000000001 R14: 0000000000000000 R15: 00000000000424b1
FS:  0000000000000000(0000) GS:ff1100081f080000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000c4 CR3: 0000000002c4a003 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 lock_acquire (kernel/locking/lockdep.c:469 kernel/locking/lockdep.c:5853 kernel/locking/lockdep.c:5816)
 _raw_spin_lock_nested (kernel/locking/spinlock.c:379)
 tcp_v4_rcv (./include/linux/skbuff.h:1678 ./include/net/tcp.h:2547 net/ipv4/tcp_ipv4.c:2350)
 ip_protocol_deliver_rcu (net/ipv4/ip_input.c:205 (discriminator 1))
 ip_local_deliver_finish (./include/linux/rcupdate.h:878 net/ipv4/ip_input.c:234)
 ip_sublist_rcv_finish (net/ipv4/ip_input.c:576)
 ip_list_rcv_finish (net/ipv4/ip_input.c:628)
 ip_list_rcv (net/ipv4/ip_input.c:670)
 __netif_receive_skb_list_core (net/core/dev.c:5939 net/core/dev.c:5986)
 netif_receive_skb_list_internal (net/core/dev.c:6040 net/core/dev.c:6129)
 napi_complete_done (./include/linux/list.h:37 ./include/net/gro.h:519 ./include/net/gro.h:514 net/core/dev.c:6496)
 e1000_clean (drivers/net/ethernet/intel/e1000/e1000_main.c:3815)
 __napi_poll.constprop.0 (net/core/dev.c:7191)
 net_rx_action (net/core/dev.c:7262 net/core/dev.c:7382)
 handle_softirqs (kernel/softirq.c:561)
 __irq_exit_rcu (kernel/softirq.c:596 kernel/softirq.c:435 kernel/softirq.c:662)
 irq_exit_rcu (kernel/softirq.c:680)
 common_interrupt (arch/x86/kernel/irq.c:280 (discriminator 14))
  </IRQ>
 <TASK>
 asm_common_interrupt (./arch/x86/include/asm/idtentry.h:693)
RIP: 0010:default_idle (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:92 arch/x86/kernel/process.c:744)
Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d c3 2b 15 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffa00000000ffee8 EFLAGS: 00000202
RAX: 000000000000640b RBX: ff1100010091c200 RCX: 0000000000061aa4
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff812f30c5
RBP: 000000000000000a R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 ? do_idle (kernel/sched/idle.c:186 kernel/sched/idle.c:325)
 default_idle_call (./include/linux/cpuidle.h:143 kernel/sched/idle.c:118)
 do_idle (kernel/sched/idle.c:186 kernel/sched/idle.c:325)
 cpu_startup_entry (kernel/sched/idle.c:422 (discriminator 1))
 start_secondary (arch/x86/kernel/smpboot.c:315)
 common_startup_64 (arch/x86/kernel/head_64.S:421)
 </TASK>
Modules linked in: cifs_arc4 nls_ucs2_utils cifs_md4 [last unloaded: cifs]
CR2: 00000000000000c4

Fixes: ed07536ed673 ("[PATCH] lockdep: annotate nfs/nfsd in-kernel sockets")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250407163313.22682-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/sock.h |   40 ++++++++++++++++++++++++++++++++++++++--
 net/core/sock.c    |    5 +++++
 2 files changed, 43 insertions(+), 2 deletions(-)

--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -338,6 +338,8 @@ struct sk_filter;
   *	@sk_txtime_unused: unused txtime flags
   *	@ns_tracker: tracker for netns reference
   *	@sk_user_frags: xarray of pages the user is holding a reference on.
+  *	@sk_owner: reference to the real owner of the socket that calls
+  *		   sock_lock_init_class_and_name().
   */
 struct sock {
 	/*
@@ -544,6 +546,10 @@ struct sock {
 	struct rcu_head		sk_rcu;
 	netns_tracker		ns_tracker;
 	struct xarray		sk_user_frags;
+
+#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
+	struct module		*sk_owner;
+#endif
 };
 
 struct sock_bh_locked {
@@ -1592,6 +1598,35 @@ static inline void sk_mem_uncharge(struc
 	sk_mem_reclaim(sk);
 }
 
+#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
+static inline void sk_owner_set(struct sock *sk, struct module *owner)
+{
+	__module_get(owner);
+	sk->sk_owner = owner;
+}
+
+static inline void sk_owner_clear(struct sock *sk)
+{
+	sk->sk_owner = NULL;
+}
+
+static inline void sk_owner_put(struct sock *sk)
+{
+	module_put(sk->sk_owner);
+}
+#else
+static inline void sk_owner_set(struct sock *sk, struct module *owner)
+{
+}
+
+static inline void sk_owner_clear(struct sock *sk)
+{
+}
+
+static inline void sk_owner_put(struct sock *sk)
+{
+}
+#endif
 /*
  * Macro so as to not evaluate some arguments when
  * lockdep is not enabled.
@@ -1601,13 +1636,14 @@ static inline void sk_mem_uncharge(struc
  */
 #define sock_lock_init_class_and_name(sk, sname, skey, name, key)	\
 do {									\
+	sk_owner_set(sk, THIS_MODULE);					\
 	sk->sk_lock.owned = 0;						\
 	init_waitqueue_head(&sk->sk_lock.wq);				\
 	spin_lock_init(&(sk)->sk_lock.slock);				\
 	debug_check_no_locks_freed((void *)&(sk)->sk_lock,		\
-			sizeof((sk)->sk_lock));				\
+				   sizeof((sk)->sk_lock));		\
 	lockdep_set_class_and_name(&(sk)->sk_lock.slock,		\
-				(skey), (sname));				\
+				   (skey), (sname));			\
 	lockdep_init_map(&(sk)->sk_lock.dep_map, (name), (key), 0);	\
 } while (0)
 
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2115,6 +2115,8 @@ lenout:
  */
 static inline void sock_lock_init(struct sock *sk)
 {
+	sk_owner_clear(sk);
+
 	if (sk->sk_kern_sock)
 		sock_lock_init_class_and_name(
 			sk,
@@ -2211,6 +2213,9 @@ static void sk_prot_free(struct proto *p
 	cgroup_sk_free(&sk->sk_cgrp_data);
 	mem_cgroup_sk_free(sk);
 	security_sk_free(sk);
+
+	sk_owner_put(sk);
+
 	if (slab != NULL)
 		kmem_cache_free(slab, sk);
 	else



