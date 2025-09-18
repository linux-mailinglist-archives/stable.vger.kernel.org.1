Return-Path: <stable+bounces-175070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 441C0B36637
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B441C24529
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9729734DCFA;
	Tue, 26 Aug 2025 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HjyzeTry"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C9343218;
	Tue, 26 Aug 2025 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216061; cv=none; b=WmYophuuAK1KHrBx7lVFdrmwcLPWoTaSgOw2pSK4+V+hJTY1AnLwm6WDG4lZQ6Hh90mYS6coOqYfiJxbw9UgVjv19+x5K8m+1yQS9Po4XX+PkCsKtv+dr8LpxFSLpFvG42KnOZUdR0O0pfdk+SnW6tD1ZHSFp4DFYFWM4KmgEJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216061; c=relaxed/simple;
	bh=Bzba8qs0Vhne503+/UmImnpn+FH9dhGZl1OvPJXHfsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWQnC8E/ZsC7iCz/7E6++5dCC0f79Anvt9MKazJvMWZtSDcUiplzpYoAwDludxlibb7UsYc7W6Oe1n43AL3TlKOepEkczyXWuVsmXux0xEIiXdZhMesIXU4wI2KW4ebcbLYrWHXAvyiEavwynEMvKb19yLfsDAXUHindGjTdmVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HjyzeTry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93B1C4CEF1;
	Tue, 26 Aug 2025 13:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216061;
	bh=Bzba8qs0Vhne503+/UmImnpn+FH9dhGZl1OvPJXHfsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HjyzeTryEIWeJy/TIK4QkicYRWutK+6+83xZsJeTeB9lcOb0CTyTSJgVQ8yl5HZ6C
	 3gaBVzRN3LFiCtR7r3/NpP9a34yfuU8Ye8kc/xk2xM2YcPVLi3zWT3ranBjIyBO0Og
	 76y2VayXK0hGPaDmCaHSbV/3HR9Lij5eZ4GdbG3s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 262/644] netlink: avoid infinite retry looping in netlink_unicast()
Date: Tue, 26 Aug 2025 13:05:53 +0200
Message-ID: <20250826110952.868207408@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

commit 759dfc7d04bab1b0b86113f1164dc1fec192b859 upstream.

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
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250728080727.255138-1-pchelkin@ispras.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlink/af_netlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1217,7 +1217,7 @@ int netlink_attachskb(struct sock *sk, s
 	nlk = nlk_sk(sk);
 	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
 
-	if ((rmem == skb->truesize || rmem < READ_ONCE(sk->sk_rcvbuf)) &&
+	if ((rmem == skb->truesize || rmem <= READ_ONCE(sk->sk_rcvbuf)) &&
 	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
 		netlink_skb_set_owner_r(skb, sk);
 		return 0;



