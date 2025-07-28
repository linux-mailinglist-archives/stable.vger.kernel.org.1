Return-Path: <stable+bounces-164888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1C1B1361C
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 10:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6B918993E1
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 08:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C97223335;
	Mon, 28 Jul 2025 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="jssV+K4G"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB8A28DD0;
	Mon, 28 Jul 2025 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690417; cv=none; b=iPb66SEUP1xiP8XVXKynzmOARm1Zsl6JNl/HR3C8h1xSVgqa+2wN3EnKNTPePt1xlvOfHLFlt3lOFysqGherQemkN8z6QI+EfNDTDyv44cNei16RJ5cAu2YOdxbAntVv1SrNLiVNA+Rb/3Ix0Jq5Ktjmwdesg4BLVUzBngesz4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690417; c=relaxed/simple;
	bh=bspyMyfXSuZW3FNveNcAHk2ud17hz9PySexk26AC+cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YN2May3p5eNMrU3z6afXl5UCvstSR83D7NKhrvbhI0d3ttB0n2UmNcthDTqn5xbeMKJdHQ2fRkdDfPNQMBQUOX65pYnMOxI25k8nevhxZGGHteMKAKByUdjyBimWnPKVYH13qtpa6ikiNIMw2vDrfYdQd2BxmCbQ6zUDXoWtLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=jssV+K4G; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.5])
	by mail.ispras.ru (Postfix) with ESMTPSA id F044C552F527;
	Mon, 28 Jul 2025 08:07:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru F044C552F527
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1753690056;
	bh=/vuzXHoV461VpNRzvkTf8kRcfq0lz2FOYbCpEU5ub5I=;
	h=From:To:Cc:Subject:Date:From;
	b=jssV+K4GZbG+RkiBKu8vbd7rShwzQ7Gfnt2aiSizA2k1k71I0y3b3fowxzEz7UhvR
	 Ff5bGkHEO9hk8FLPBDssrWXQlHeHBXt6I9FrcelDhjY91loj9O8eiuBJYCNCwrATDJ
	 UWVJ1BlxQDJjkUXx026QPeoWH54AMPQ6v9oTEky0=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH net] netlink: avoid infinite retry looping in netlink_unicast()
Date: Mon, 28 Jul 2025 11:06:47 +0300
Message-ID: <20250728080727.255138-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netlink_attachskb() checks for the socket's read memory allocation
constraints. Firstly, it has:

  rmem < READ_ONCE(sk->sk_rcvbuf)

to check if the just increased rmem value fits into the socket's receive
buffer. If not, it proceeds and tries to wait for the memory under:

  rmem + skb->truesize > READ_ONCE(sk->sk_rcvbuf)

The checks don't cover the case when skb->truesize + sk->sk_rmem_alloc is
equal to sk->sk_rcvbuf. Thus the function neither successfully accepts
these conditions, nor manages to reschedule the task - and is called in
retry loop for indefinite time which is caught as:

  rcu: INFO: rcu_sched self-detected stall on CPU
  rcu:     0-....: (25999 ticks this GP) idle=ef2/1/0x4000000000000000 softirq=262269/262269 fqs=6212
  (t=26000 jiffies g=230833 q=259957)
  NMI backtrace for cpu 0
  CPU: 0 PID: 22 Comm: kauditd Not tainted 5.10.240 #68
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc42 04/01/2014
  Call Trace:
  <IRQ>
  dump_stack lib/dump_stack.c:120
  nmi_cpu_backtrace.cold lib/nmi_backtrace.c:105
  nmi_trigger_cpumask_backtrace lib/nmi_backtrace.c:62
  rcu_dump_cpu_stacks kernel/rcu/tree_stall.h:335
  rcu_sched_clock_irq.cold kernel/rcu/tree.c:2590
  update_process_times kernel/time/timer.c:1953
  tick_sched_handle kernel/time/tick-sched.c:227
  tick_sched_timer kernel/time/tick-sched.c:1399
  __hrtimer_run_queues kernel/time/hrtimer.c:1652
  hrtimer_interrupt kernel/time/hrtimer.c:1717
  __sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1113
  asm_call_irq_on_stack arch/x86/entry/entry_64.S:808
  </IRQ>

  netlink_attachskb net/netlink/af_netlink.c:1234
  netlink_unicast net/netlink/af_netlink.c:1349
  kauditd_send_queue kernel/audit.c:776
  kauditd_thread kernel/audit.c:897
  kthread kernel/kthread.c:328
  ret_from_fork arch/x86/entry/entry_64.S:304

Restore the original behavior of the check which commit in Fixes
accidentally missed when restructuring the code.

Found by Linux Verification Center (linuxtesting.org).

Fixes: ae8f160e7eb2 ("netlink: Fix wraparounds of sk->sk_rmem_alloc.")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

Similar rmem and sk->sk_rcvbuf comparing pattern in
netlink_broadcast_deliver() accepts these values being equal, while
the netlink_dump() case does not - but it goes all the way down to
f9c2288837ba ("netlink: implement memory mapped recvmsg()") and looks
like an irrelevant issue without any real consequences. Though might be
cleaned up if needed.

Updated sk->sk_rmem_alloc vs sk->sk_rcvbuf checks throughout the kernel
diverse in treating the corner case of them being equal.

 net/netlink/af_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 6332a0e06596..0fc3f045fb65 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1218,7 +1218,7 @@ int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
 	nlk = nlk_sk(sk);
 	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
 
-	if ((rmem == skb->truesize || rmem < READ_ONCE(sk->sk_rcvbuf)) &&
+	if ((rmem == skb->truesize || rmem <= READ_ONCE(sk->sk_rcvbuf)) &&
 	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
 		netlink_skb_set_owner_r(skb, sk);
 		return 0;
-- 
2.50.1


