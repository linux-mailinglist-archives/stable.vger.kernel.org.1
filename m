Return-Path: <stable+bounces-204734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A0ECF3580
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E54A3004791
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5787F314A78;
	Mon,  5 Jan 2026 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2UjU9hMr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178562F0C7F
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613734; cv=none; b=nKxwiXZ7Wpgk45XntZfMbU0UoEHDT8Bl/7VvOfmH3cEc3J+qauJIICZilKBom5D6Qvi1qNbsqwuwESQbNCgrq9gk22YSg9ybzEkenhqOnC/QnLs4pwgIK+AyaNP4I63Jf+DmPcqgeMOPkTTkWBRWZv41Ju576xkNEHjIIPxmXfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613734; c=relaxed/simple;
	bh=VvmjaJOsqUnZhMLhu5gEYC1q6M58ftUo6T9ZJ78e0lg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=apeJsmUn/o0KbzDx1PKMqsO8k4BoLCvkyfPqz84hSrptGaiKYfGKwG3jxBqUeJrthXpqz/mX65MXKTQpUhQRE2HWpSKd92sZMBN3OKczadJNTAuTdz17LliK2lhNkd/PPAjVg6JvQsWIvLkVJjyqR7n1e9aAjUs5hEp/FNum0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2UjU9hMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D0DC116D0;
	Mon,  5 Jan 2026 11:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767613733;
	bh=VvmjaJOsqUnZhMLhu5gEYC1q6M58ftUo6T9ZJ78e0lg=;
	h=Subject:To:Cc:From:Date:From;
	b=2UjU9hMrLGkPCym+0yAke8aWP7gqdwMPgeAht6cyPtvZvMxuyn6BdFtQuvGh228cL
	 +xyCQ8CsAHfRHKZiGE5I6CDA28ny3uQC3tey5nsz2X8Z2agLNaiEbdXKo2URMI64KJ
	 7fEcOPrygfMonu+p97/3zr4EDfkUSF/M2E0BS+Y4=
Subject: FAILED: patch "[PATCH] mptcp: fallback earlier on simult connection" failed to apply to 6.1-stable tree
To: pabeni@redhat.com,matttbe@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:48:40 +0100
Message-ID: <2026010540-smuggler-passably-11d2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 71154bbe49423128c1c8577b6576de1ed6836830
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010540-smuggler-passably-11d2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 71154bbe49423128c1c8577b6576de1ed6836830 Mon Sep 17 00:00:00 2001
From: Paolo Abeni <pabeni@redhat.com>
Date: Fri, 12 Dec 2025 13:54:03 +0100
Subject: [PATCH] mptcp: fallback earlier on simult connection

Syzkaller reports a simult-connect race leading to inconsistent fallback
status:

  WARNING: CPU: 3 PID: 33 at net/mptcp/subflow.c:1515 subflow_data_ready+0x40b/0x7c0 net/mptcp/subflow.c:1515
  Modules linked in:
  CPU: 3 UID: 0 PID: 33 Comm: ksoftirqd/3 Not tainted syzkaller #0 PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
  RIP: 0010:subflow_data_ready+0x40b/0x7c0 net/mptcp/subflow.c:1515
  Code: 89 ee e8 78 61 3c f6 40 84 ed 75 21 e8 8e 66 3c f6 44 89 fe bf 07 00 00 00 e8 c1 61 3c f6 41 83 ff 07 74 09 e8 76 66 3c f6 90 <0f> 0b 90 e8 6d 66 3c f6 48 89 df e8 e5 ad ff ff 31 ff 89 c5 89 c6
  RSP: 0018:ffffc900006cf338 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ffff888031acd100 RCX: ffffffff8b7f2abf
  RDX: ffff88801e6ea440 RSI: ffffffff8b7f2aca RDI: 0000000000000005
  RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000007
  R10: 0000000000000004 R11: 0000000000002c10 R12: ffff88802ba69900
  R13: 1ffff920000d9e67 R14: ffff888046f81800 R15: 0000000000000004
  FS:  0000000000000000(0000) GS:ffff8880d69bc000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000560fc0ca1670 CR3: 0000000032c3a000 CR4: 0000000000352ef0
  Call Trace:
   <TASK>
   tcp_data_queue+0x13b0/0x4f90 net/ipv4/tcp_input.c:5197
   tcp_rcv_state_process+0xfdf/0x4ec0 net/ipv4/tcp_input.c:6922
   tcp_v6_do_rcv+0x492/0x1740 net/ipv6/tcp_ipv6.c:1672
   tcp_v6_rcv+0x2976/0x41e0 net/ipv6/tcp_ipv6.c:1918
   ip6_protocol_deliver_rcu+0x188/0x1520 net/ipv6/ip6_input.c:438
   ip6_input_finish+0x1e4/0x4b0 net/ipv6/ip6_input.c:489
   NF_HOOK include/linux/netfilter.h:318 [inline]
   NF_HOOK include/linux/netfilter.h:312 [inline]
   ip6_input+0x105/0x2f0 net/ipv6/ip6_input.c:500
   dst_input include/net/dst.h:471 [inline]
   ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
   NF_HOOK include/linux/netfilter.h:318 [inline]
   NF_HOOK include/linux/netfilter.h:312 [inline]
   ipv6_rcv+0x264/0x650 net/ipv6/ip6_input.c:311
   __netif_receive_skb_one_core+0x12d/0x1e0 net/core/dev.c:5979
   __netif_receive_skb+0x1d/0x160 net/core/dev.c:6092
   process_backlog+0x442/0x15e0 net/core/dev.c:6444
   __napi_poll.constprop.0+0xba/0x550 net/core/dev.c:7494
   napi_poll net/core/dev.c:7557 [inline]
   net_rx_action+0xa9f/0xfe0 net/core/dev.c:7684
   handle_softirqs+0x216/0x8e0 kernel/softirq.c:579
   run_ksoftirqd kernel/softirq.c:968 [inline]
   run_ksoftirqd+0x3a/0x60 kernel/softirq.c:960
   smpboot_thread_fn+0x3f7/0xae0 kernel/smpboot.c:160
   kthread+0x3c2/0x780 kernel/kthread.c:463
   ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
   </TASK>

The TCP subflow can process the simult-connect syn-ack packet after
transitioning to TCP_FIN1 state, bypassing the MPTCP fallback check,
as the sk_state_change() callback is not invoked for * -> FIN_WAIT1
transitions.

That will move the msk socket to an inconsistent status and the next
incoming data will hit the reported splat.

Close the race moving the simult-fallback check at the earliest possible
stage - that is at syn-ack generation time.

About the fixes tags: [2] was supposed to also fix this issue introduced
by [3]. [1] is required as a dependence: it was not explicitly marked as
a fix, but it is one and it has already been backported before [3]. In
other words, this commit should be backported up to [3], including [2]
and [1] if that's not already there.

Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous connect().") [1]
Fixes: 4fd19a307016 ("mptcp: fix inconsistent state on fastopen race") [2]
Fixes: 1e777f39b4d7 ("mptcp: add MSG_FASTOPEN sendmsg flag support") [3]
Cc: stable@vger.kernel.org
Reported-by: syzbot+0ff6b771b4f7a5bce83b@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/586
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251212-net-mptcp-subflow_data_ready-warn-v1-1-d1f9fd1c36c8@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index f24ae7d40e88..43df4293f58b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -408,6 +408,16 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 	 */
 	subflow->snd_isn = TCP_SKB_CB(skb)->end_seq;
 	if (subflow->request_mptcp) {
+		if (unlikely(subflow_simultaneous_connect(sk))) {
+			WARN_ON_ONCE(!mptcp_try_fallback(sk, MPTCP_MIB_SIMULTCONNFALLBACK));
+
+			/* Ensure mptcp_finish_connect() will not process the
+			 * MPC handshake.
+			 */
+			subflow->request_mptcp = 0;
+			return false;
+		}
+
 		opts->suboptions = OPTION_MPTCP_MPC_SYN;
 		opts->csum_reqd = mptcp_is_checksum_enabled(sock_net(sk));
 		opts->allow_join_id0 = mptcp_allow_join_id0(sock_net(sk));
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9c0d17876b22..bed0c9aa28b6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1337,10 +1337,8 @@ static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	return (1 << sk->sk_state) &
-	       (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING) &&
-	       is_active_ssk(subflow) &&
-	       !subflow->conn_finished;
+	/* Note that the sk state implies !subflow->conn_finished. */
+	return sk->sk_state == TCP_SYN_RECV && is_active_ssk(subflow);
 }
 
 #ifdef CONFIG_SYN_COOKIES
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 86ce58ae533d..96d54cb2cd93 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1878,12 +1878,6 @@ static void subflow_state_change(struct sock *sk)
 
 	__subflow_state_change(sk);
 
-	if (subflow_simultaneous_connect(sk)) {
-		WARN_ON_ONCE(!mptcp_try_fallback(sk, MPTCP_MIB_SIMULTCONNFALLBACK));
-		subflow->conn_finished = 1;
-		mptcp_propagate_state(parent, sk, subflow, NULL);
-	}
-
 	/* as recvmsg() does not acquire the subflow socket for ssk selection
 	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
 	 * the data available machinery here.


