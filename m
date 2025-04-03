Return-Path: <stable+bounces-127712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F30AA7A87D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C483816A98A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351512512FC;
	Thu,  3 Apr 2025 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WBTbU4M6"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386EA2512E2
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743700845; cv=none; b=ZYLFg4wMKcs/pf1NsKZGyqcVDFFU+AqQ2mRAjxJp5rg5ukRFWm1Xwo2YJNSK75E6MnF1b0aRfdOg5v8kwon3NIhadHL4tvmjzKn82BOcJMBWhrm9B7PBNarZIl1/6u2HhuBHgOcoSIRSUIVjGUqyD/CIbgzRf26E+l8uGS6XXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743700845; c=relaxed/simple;
	bh=3jzXXWpFDEVx7v1ct5zk98inyLnJAfSabp/I1ELpWzA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z3Z6UP50GkC7jgLPGLlrGSzspnIjZUR0KY+A0RqTkKGvrM/5Mk+E67iDuhRb+Nfa5JtFO7qpQqqZMSEukokjjOcWwHbYbGhtlLlS40YmiN+M4J5GbKXg0XmlPrj2RdY8F0xBbdJTRSJ/TjQXiApKuL4OF+tAmCevWYjv1P9RA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WBTbU4M6; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743700843; x=1775236843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7KmD+iiz847L8x/3qRGMBSNdyDdpdZzehPn+duSKnTo=;
  b=WBTbU4M6JqnmfvrELAmqHReJGozT6xOFscYYT7XQNGKzrHkmREp2R8+j
   3rVJqcZI2g6+mBEu5GDjywZwIGZ5NpA1+3VwPpTBN3Z+dBXfwP3hJLKJK
   d2muGS1Pp0Q776Kdz32aZWN1bemiTSGil+LpH1yNITJzTVt0zKPNQ64Lk
   E=;
X-IronPort-AV: E=Sophos;i="6.15,184,1739836800"; 
   d="scan'208";a="732651672"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 17:20:41 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:9068]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.63:2525] with esmtp (Farcaster)
 id 864fc565-d982-49ad-98ed-c13854cad612; Thu, 3 Apr 2025 17:20:40 +0000 (UTC)
X-Farcaster-Flow-ID: 864fc565-d982-49ad-98ed-c13854cad612
Received: from EX19D007UWB003.ant.amazon.com (10.13.138.28) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 3 Apr 2025 17:20:40 +0000
Received: from 6c7e67c92ceb.amazon.com (10.187.170.32) by
 EX19D007UWB003.ant.amazon.com (10.13.138.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 3 Apr 2025 17:20:39 +0000
From: Nathan Gao <zcgao@amazon.com>
To: <stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet
	<edumazet@google.com>, Martin KaFai Lau <martin.lau@kernel.org>, "Neal
 Cardwell" <ncardwell@google.com>, Nathan Gao <zcgao@amazon.com>, "Jakub
 Kicinski" <kuba@kernel.org>
Subject: [PATCH 5.4.y] tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
Date: Thu, 3 Apr 2025 10:20:23 -0700
Message-ID: <20250403172023.98206-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D007UWB003.ant.amazon.com (10.13.138.28)

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit e8c526f2bdf1845bedaf6a478816a3d06fa78b8f ]

Martin KaFai Lau reported use-after-free [0] in reqsk_timer_handler().

  """
  We are seeing a use-after-free from a bpf prog attached to
  trace_tcp_retransmit_synack. The program passes the req->sk to the
  bpf_sk_storage_get_tracing kernel helper which does check for null
  before using it.
  """

The commit 83fccfc3940c ("inet: fix potential deadlock in
reqsk_queue_unlink()") added timer_pending() in reqsk_queue_unlink() not
to call del_timer_sync() from reqsk_timer_handler(), but it introduced a
small race window.

Before the timer is called, expire_timers() calls detach_timer(timer, true)
to clear timer->entry.pprev and marks it as not pending.

If reqsk_queue_unlink() checks timer_pending() just after expire_timers()
calls detach_timer(), TCP will miss del_timer_sync(); the reqsk timer will
continue running and send multiple SYN+ACKs until it expires.

The reported UAF could happen if req->sk is close()d earlier than the timer
expiration, which is 63s by default.

The scenario would be

  1. inet_csk_complete_hashdance() calls inet_csk_reqsk_queue_drop(),
     but del_timer_sync() is missed

  2. reqsk timer is executed and scheduled again

  3. req->sk is accept()ed and reqsk_put() decrements rsk_refcnt, but
     reqsk timer still has another one, and inet_csk_accept() does not
     clear req->sk for non-TFO sockets

  4. sk is close()d

  5. reqsk timer is executed again, and BPF touches req->sk

Let's not use timer_pending() by passing the caller context to
__inet_csk_reqsk_queue_drop().

Note that reqsk timer is pinned, so the issue does not happen in most
use cases. [1]

[0]
BUG: KFENCE: use-after-free read in bpf_sk_storage_get_tracing+0x2e/0x1b0

Use-after-free read at 0x00000000a891fb3a (in kfence-#1):
bpf_sk_storage_get_tracing+0x2e/0x1b0
bpf_prog_5ea3e95db6da0438_tcp_retransmit_synack+0x1d20/0x1dda
bpf_trace_run2+0x4c/0xc0
tcp_rtx_synack+0xf9/0x100
reqsk_timer_handler+0xda/0x3d0
run_timer_softirq+0x292/0x8a0
irq_exit_rcu+0xf5/0x320
sysvec_apic_timer_interrupt+0x6d/0x80
asm_sysvec_apic_timer_interrupt+0x16/0x20
intel_idle_irq+0x5a/0xa0
cpuidle_enter_state+0x94/0x273
cpu_startup_entry+0x15e/0x260
start_secondary+0x8a/0x90
secondary_startup_64_no_verify+0xfa/0xfb

kfence-#1: 0x00000000a72cc7b6-0x00000000d97616d9, size=2376, cache=TCPv6

allocated by task 0 on cpu 9 at 260507.901592s:
sk_prot_alloc+0x35/0x140
sk_clone_lock+0x1f/0x3f0
inet_csk_clone_lock+0x15/0x160
tcp_create_openreq_child+0x1f/0x410
tcp_v6_syn_recv_sock+0x1da/0x700
tcp_check_req+0x1fb/0x510
tcp_v6_rcv+0x98b/0x1420
ipv6_list_rcv+0x2258/0x26e0
napi_complete_done+0x5b1/0x2990
mlx5e_napi_poll+0x2ae/0x8d0
net_rx_action+0x13e/0x590
irq_exit_rcu+0xf5/0x320
common_interrupt+0x80/0x90
asm_common_interrupt+0x22/0x40
cpuidle_enter_state+0xfb/0x273
cpu_startup_entry+0x15e/0x260
start_secondary+0x8a/0x90
secondary_startup_64_no_verify+0xfa/0xfb

freed by task 0 on cpu 9 at 260507.927527s:
rcu_core_si+0x4ff/0xf10
irq_exit_rcu+0xf5/0x320
sysvec_apic_timer_interrupt+0x6d/0x80
asm_sysvec_apic_timer_interrupt+0x16/0x20
cpuidle_enter_state+0xfb/0x273
cpu_startup_entry+0x15e/0x260
start_secondary+0x8a/0x90
secondary_startup_64_no_verify+0xfa/0xfb

Fixes: 83fccfc3940c ("inet: fix potential deadlock in reqsk_queue_unlink()")
Reported-by: Martin KaFai Lau <martin.lau@kernel.org>
Closes: https://lore.kernel.org/netdev/eb6684d0-ffd9-4bdc-9196-33f690c25824@linux.dev/
Link: https://lore.kernel.org/netdev/b55e2ca0-42f2-4b7c-b445-6ffd87ca74a0@linux.dev/ [1]
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20241014223312.4254-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Resolved conflicts due to context difference]
Signed-off-by: Nathan Gao <zcgao@amazon.com>
---
 net/ipv4/inet_connection_sock.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6766a154ff85..e1618cfd5e78 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -709,21 +709,31 @@ static bool reqsk_queue_unlink(struct request_sock *req)
 		found = __sk_nulls_del_node_init_rcu(req_to_sk(req));
 		spin_unlock(lock);
 	}
-	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
-		reqsk_put(req);
+
 	return found;
 }
 
-bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
+static bool __inet_csk_reqsk_queue_drop(struct sock *sk,
+					struct request_sock *req,
+					bool from_timer)
 {
 	bool unlinked = reqsk_queue_unlink(req);
 
+	if (!from_timer && timer_delete_sync(&req->rsk_timer))
+		reqsk_put(req);
+
 	if (unlinked) {
 		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
 		reqsk_put(req);
 	}
+
 	return unlinked;
 }
+
+bool inet_csk_reqsk_queue_drop(struct sock *sk, struct request_sock *req)
+{
+	return __inet_csk_reqsk_queue_drop(sk, req, false);
+}
 EXPORT_SYMBOL(inet_csk_reqsk_queue_drop);
 
 void inet_csk_reqsk_queue_drop_and_put(struct sock *sk, struct request_sock *req)
@@ -796,7 +806,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 		return;
 	}
 drop:
-	inet_csk_reqsk_queue_drop_and_put(sk_listener, req);
+	__inet_csk_reqsk_queue_drop(sk_listener, req, true);
+	reqsk_put(req);
 }
 
 static void reqsk_queue_hash_req(struct request_sock *req,
-- 
2.39.5 (Apple Git-154)


