Return-Path: <stable+bounces-88294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF229B2551
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA3D1F21C24
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C66918E047;
	Mon, 28 Oct 2024 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JJAMByiO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD4018CC1F;
	Mon, 28 Oct 2024 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730096872; cv=none; b=haaTW7kdm3rRL5vv1ApN1zN4Cu+vrxUiq5iwEm2Zg8emRxuIJyNDocveNqt9TA5pgnRjE8T16AzxZkFqV6oNjJFXNKJEgoYGk3bxZgdapZa43bcjndYQKipTl3Wo0VRv4c2Fg0bYXqL3yFC3VscFkYBLyB1X9oU9wn5iJNhvgKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730096872; c=relaxed/simple;
	bh=Qx+xVRoU52rxlfqLEV8J4l4cwuPGnnIlb6ziwAHwZcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYAcknzzd4ETurbGYF2h7Yby1Fqn4PS+S2+RZAVdQyX3OdsYlUTKvmiigCDfM+99cG+cCluCthbV94tdRf57WAH/hSiQh/wSr06oDlzuIhhxvB3hYxwfwdx35J5Shv0JdEqJ6ab4zVGtpt6fkucPblCq7XDHqLnSeu7sDwYoEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JJAMByiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7002FC4CEC3;
	Mon, 28 Oct 2024 06:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730096872;
	bh=Qx+xVRoU52rxlfqLEV8J4l4cwuPGnnIlb6ziwAHwZcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJAMByiOKZ1ATXw69lc7OphRyQoF5LGTg89oPWA/ICof90OaGFkR7HIcK+/wsN7jQ
	 4Bebmd9FNlRA6VIoScMc80rQdcH4CtLjhynqyDbpW8yn7r4t7HsWFaFYN7//GFNxam
	 CrihYWTQgBWesZy59mRxEcUtBuTZTlI+V2g0FPaQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 23/80] tcp/dccp: Dont use timer_pending() in reqsk_queue_unlink().
Date: Mon, 28 Oct 2024 07:25:03 +0100
Message-ID: <20241028062253.271792074@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062252.611837461@linuxfoundation.org>
References: <20241028062252.611837461@linuxfoundation.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_connection_sock.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 75c2f7ffe5be4..63e5aa6d4b0bc 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -791,21 +791,31 @@ static bool reqsk_queue_unlink(struct request_sock *req)
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
@@ -898,7 +908,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 
 		if (!inet_ehash_insert(req_to_sk(nreq), req_to_sk(oreq), NULL)) {
 			/* delete timer */
-			inet_csk_reqsk_queue_drop(sk_listener, nreq);
+			__inet_csk_reqsk_queue_drop(sk_listener, nreq, true);
 			goto no_ownership;
 		}
 
@@ -924,7 +934,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 	}
 
 drop:
-	inet_csk_reqsk_queue_drop_and_put(oreq->rsk_listener, oreq);
+	__inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
+	reqsk_put(req);
 }
 
 static bool reqsk_queue_hash_req(struct request_sock *req,
-- 
2.43.0




