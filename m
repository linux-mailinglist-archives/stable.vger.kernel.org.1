Return-Path: <stable+bounces-127466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CA9A799E2
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 04:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C673A8AE9
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 02:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA3A1514E4;
	Thu,  3 Apr 2025 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cPXG+7CP"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F6577104;
	Thu,  3 Apr 2025 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743646145; cv=none; b=YEX27/LvQiSsmo1ObK0jPLIeatMNOCatGi9nhzo60t8/W6MCmhPeg8dQlYLbpkS+C4Bz5Pt8LyHARAUskjYahrmVFOaJd2GTyiWLWNMQv7eAfUOlbCfkmxANmpT7qg63GHLq0GZfROHtZNMlbJW/6jk6sAUV0Gi228WCKnIy2Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743646145; c=relaxed/simple;
	bh=q/IRujMO1rg29vmA7hDV1kY8MtKgNDKlvr9gF8gYxzM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qyujRYI+s8ti8xkIJtYH7N64OhV4hil4Dmt0WDDf8OX09YUgbLnWWPP6uYLdmz/3Hg1yS3YhDfYK3fBx7iF0ZL+BTn2qMoOtWXU8Jy2wn159vUz/uyZ8HZXWaJ3JolcJVtLfQ6onmwdGAnu763G1vdjj/iJAk4RMzPvYkCGjNG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cPXG+7CP; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743646143; x=1775182143;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1Zpl1jkCr7Am49sDLEhWveV6QO5tukO+SlvvSCHAsGQ=;
  b=cPXG+7CPu8JZcd3rU9JSeWj4xs/MLyVMFPvgJnhKx15ZLL8rJgKIMvTk
   8h7lBNVYZIXRb4KufER1GSjIVB/Y6fyuvYkf6W1rEgeuklDIw+UGWw/Ke
   CthamtHQcRAMdABhdxn13FWX4Pyx10Ts1H/DWkdidXf7jO/TEONPBKjmp
   s=;
X-IronPort-AV: E=Sophos;i="6.15,183,1739836800"; 
   d="scan'208";a="477028485"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 02:08:59 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:33543]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.148:2525] with esmtp (Farcaster)
 id 36d19ca5-f621-42ce-8406-5398d9b5a9e0; Thu, 3 Apr 2025 02:08:58 +0000 (UTC)
X-Farcaster-Flow-ID: 36d19ca5-f621-42ce-8406-5398d9b5a9e0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 3 Apr 2025 02:08:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 3 Apr 2025 02:08:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Steve French <sfrench@samba.org>, Enzo Matsumiya <ematsumiya@suse.de>, "Wang
 Zhaolong" <wangzhaolong1@huawei.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH v1 net] net: Fix null-ptr-deref by sock_lock_init_class_and_name() and rmmod.
Date: Wed, 2 Apr 2025 19:07:30 -0700
Message-ID: <20250403020837.51664-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When I ran the repro [0] and waited a few seconds, I observed two
LOCKDEP splats: a warning immediately followed by a null-ptr-deref.  [1]

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
and it returns, the TCP socket does not immediately die to close the
connection gracefully.

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
and release it when the socket is freed in __sk_destruct().

[0]:
CIFS_SERVER="10.0.0.137"
CIFS_PATH="//${CIFS_SERVER}/Users/Administrator/Desktop/CIFS_TEST"
DEV="enp0s3"
CRED="/root/WindowsCredential.sh"

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
---
 include/net/sock.h | 17 +++++++++++++++--
 net/core/sock.c    |  6 ++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8daf1b3b12c6..5864c4c66c6d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -547,6 +547,10 @@ struct sock {
 	struct rcu_head		sk_rcu;
 	netns_tracker		ns_tracker;
 	struct xarray		sk_user_frags;
+
+#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
+	struct module		*sk_owner;
+#endif
 };
 
 struct sock_bh_locked {
@@ -1583,6 +1587,14 @@ static inline void sk_mem_uncharge(struct sock *sk, int size)
 	sk_mem_reclaim(sk);
 }
 
+static inline void sk_set_owner(struct sock *sk, struct module *owner)
+{
+#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
+	__module_get(owner);
+	sk->sk_owner = owner;
+#endif
+}
+
 /*
  * Macro so as to not evaluate some arguments when
  * lockdep is not enabled.
@@ -1592,13 +1604,14 @@ static inline void sk_mem_uncharge(struct sock *sk, int size)
  */
 #define sock_lock_init_class_and_name(sk, sname, skey, name, key)	\
 do {									\
+	sk_set_owner(sk, THIS_MODULE);					\
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
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 323892066def..b54f12faad1c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2324,6 +2324,12 @@ static void __sk_destruct(struct rcu_head *head)
 		__netns_tracker_free(net, &sk->ns_tracker, false);
 		net_passive_dec(net);
 	}
+
+#if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
+	if (sk->sk_owner)
+		module_put(sk->sk_owner);
+#endif
+
 	sk_prot_free(sk->sk_prot_creator, sk);
 }
 
-- 
2.48.1


