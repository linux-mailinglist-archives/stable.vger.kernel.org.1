Return-Path: <stable+bounces-74828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEA197319E
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED07328AE65
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F436197A76;
	Tue, 10 Sep 2024 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HT2yduGb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D46D190667;
	Tue, 10 Sep 2024 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962949; cv=none; b=JDJMafWUm/UoWOChwGknNWOb9vfoZG5D4R/xUkuuqePK+yxxNPKSeRh2B9Rc8y9/nl07nZquBJda5g13si3gelPpKNxFJ3CFR7y3hf9UNbntkX0IWxwrKMYcZdJA+pskb6TTXuhGxKUvqhDEpg1QF/ZEN7wmEbgZ4I2vZA4q1+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962949; c=relaxed/simple;
	bh=lW8UScFNXWVZNNEVjQq/wYsc8+wrJ7Dss0h2h9XzGzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRkSgsdIH42WPKY3umcnwoPIkvhVyy4Z2NJn152LdrUGzcgE4Iz2KYeVO+cgswrHapd9M/EdhLgRzJAWgAbVmLhh8zA11DgisP7M7BqiZIrYOIyjI+wYLR6YLCALmHjnBEHvgQu1yqNmb5pPtXHepiL++nuRTeY1jxwsfcbbOn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HT2yduGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F7CC4CEC3;
	Tue, 10 Sep 2024 10:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962949;
	bh=lW8UScFNXWVZNNEVjQq/wYsc8+wrJ7Dss0h2h9XzGzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HT2yduGbHGfAvdjApZ7vvz0zd/SSJoMe16U3YXrfjR+423+/Bx577bb3ppCUXheZl
	 4//ZGrsKhhDZ54N3EHCxzafgkHWvG9LfHRZZrfbEk723kZmVBLNsonv3r3jRNQlxDr
	 a2q1sctVAdAQ3/Nc0gXAneSwj+3BDwK2eWOnVR6w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alphonse Kurian <alkurian@amazon.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 085/192] fou: Fix null-ptr-deref in GRO.
Date: Tue, 10 Sep 2024 11:31:49 +0200
Message-ID: <20240910092601.493946137@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092557.876094467@linuxfoundation.org>
References: <20240910092557.876094467@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 7e4196935069947d8b70b09c1660b67b067e75cb ]

We observed a null-ptr-deref in fou_gro_receive() while shutting down
a host.  [0]

The NULL pointer is sk->sk_user_data, and the offset 8 is of protocol
in struct fou.

When fou_release() is called due to netns dismantle or explicit tunnel
teardown, udp_tunnel_sock_release() sets NULL to sk->sk_user_data.
Then, the tunnel socket is destroyed after a single RCU grace period.

So, in-flight udp4_gro_receive() could find the socket and execute the
FOU GRO handler, where sk->sk_user_data could be NULL.

Let's use rcu_dereference_sk_user_data() in fou_from_sock() and add NULL
checks in FOU GRO handlers.

[0]:
BUG: kernel NULL pointer dereference, address: 0000000000000008
 PF: supervisor read access in kernel mode
 PF: error_code(0x0000) - not-present page
PGD 80000001032f4067 P4D 80000001032f4067 PUD 103240067 PMD 0
SMP PTI
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.10.216-204.855.amzn2.x86_64 #1
Hardware name: Amazon EC2 c5.large/, BIOS 1.0 10/16/2017
RIP: 0010:fou_gro_receive (net/ipv4/fou.c:233) [fou]
Code: 41 5f c3 cc cc cc cc e8 e7 2e 69 f4 0f 1f 80 00 00 00 00 0f 1f 44 00 00 49 89 f8 41 54 48 89 f7 48 89 d6 49 8b 80 88 02 00 00 <0f> b6 48 08 0f b7 42 4a 66 25 fd fd 80 cc 02 66 89 42 4a 0f b6 42
RSP: 0018:ffffa330c0003d08 EFLAGS: 00010297
RAX: 0000000000000000 RBX: ffff93d9e3a6b900 RCX: 0000000000000010
RDX: ffff93d9e3a6b900 RSI: ffff93d9e3a6b900 RDI: ffff93dac2e24d08
RBP: ffff93d9e3a6b900 R08: ffff93dacbce6400 R09: 0000000000000002
R10: 0000000000000000 R11: ffffffffb5f369b0 R12: ffff93dacbce6400
R13: ffff93dac2e24d08 R14: 0000000000000000 R15: ffffffffb4edd1c0
FS:  0000000000000000(0000) GS:ffff93daee800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 0000000102140001 CR4: 00000000007706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 ? show_trace_log_lvl (arch/x86/kernel/dumpstack.c:259)
 ? __die_body.cold (arch/x86/kernel/dumpstack.c:478 arch/x86/kernel/dumpstack.c:420)
 ? no_context (arch/x86/mm/fault.c:752)
 ? exc_page_fault (arch/x86/include/asm/irqflags.h:49 arch/x86/include/asm/irqflags.h:89 arch/x86/mm/fault.c:1435 arch/x86/mm/fault.c:1483)
 ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:571)
 ? fou_gro_receive (net/ipv4/fou.c:233) [fou]
 udp_gro_receive (include/linux/netdevice.h:2552 net/ipv4/udp_offload.c:559)
 udp4_gro_receive (net/ipv4/udp_offload.c:604)
 inet_gro_receive (net/ipv4/af_inet.c:1549 (discriminator 7))
 dev_gro_receive (net/core/dev.c:6035 (discriminator 4))
 napi_gro_receive (net/core/dev.c:6170)
 ena_clean_rx_irq (drivers/amazon/net/ena/ena_netdev.c:1558) [ena]
 ena_io_poll (drivers/amazon/net/ena/ena_netdev.c:1742) [ena]
 napi_poll (net/core/dev.c:6847)
 net_rx_action (net/core/dev.c:6917)
 __do_softirq (arch/x86/include/asm/jump_label.h:25 include/linux/jump_label.h:200 include/trace/events/irq.h:142 kernel/softirq.c:299)
 asm_call_irq_on_stack (arch/x86/entry/entry_64.S:809)
</IRQ>
 do_softirq_own_stack (arch/x86/include/asm/irq_stack.h:27 arch/x86/include/asm/irq_stack.h:77 arch/x86/kernel/irq_64.c:77)
 irq_exit_rcu (kernel/softirq.c:393 kernel/softirq.c:423 kernel/softirq.c:435)
 common_interrupt (arch/x86/kernel/irq.c:239)
 asm_common_interrupt (arch/x86/include/asm/idtentry.h:626)
RIP: 0010:acpi_idle_do_entry (arch/x86/include/asm/irqflags.h:49 arch/x86/include/asm/irqflags.h:89 drivers/acpi/processor_idle.c:114 drivers/acpi/processor_idle.c:575)
Code: 8b 15 d1 3c c4 02 ed c3 cc cc cc cc 65 48 8b 04 25 40 ef 01 00 48 8b 00 a8 08 75 eb 0f 1f 44 00 00 0f 00 2d d5 09 55 00 fb f4 <fa> c3 cc cc cc cc e9 be fc ff ff 66 66 2e 0f 1f 84 00 00 00 00 00
RSP: 0018:ffffffffb5603e58 EFLAGS: 00000246
RAX: 0000000000004000 RBX: ffff93dac0929c00 RCX: ffff93daee833900
RDX: ffff93daee800000 RSI: ffff93daee87dc00 RDI: ffff93daee87dc64
RBP: 0000000000000001 R08: ffffffffb5e7b6c0 R09: 0000000000000044
R10: ffff93daee831b04 R11: 00000000000001cd R12: 0000000000000001
R13: ffffffffb5e7b740 R14: 0000000000000001 R15: 0000000000000000
 ? sched_clock_cpu (kernel/sched/clock.c:371)
 acpi_idle_enter (drivers/acpi/processor_idle.c:712 (discriminator 3))
 cpuidle_enter_state (drivers/cpuidle/cpuidle.c:237)
 cpuidle_enter (drivers/cpuidle/cpuidle.c:353)
 cpuidle_idle_call (kernel/sched/idle.c:158 kernel/sched/idle.c:239)
 do_idle (kernel/sched/idle.c:302)
 cpu_startup_entry (kernel/sched/idle.c:395 (discriminator 1))
 start_kernel (init/main.c:1048)
 secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:310)
Modules linked in: udp_diag tcp_diag inet_diag nft_nat ipip tunnel4 dummy fou ip_tunnel nft_masq nft_chain_nat nf_nat wireguard nft_ct curve25519_x86_64 libcurve25519_generic nf_conntrack libchacha20poly1305 nf_defrag_ipv6 nf_defrag_ipv4 nft_objref chacha_x86_64 nft_counter nf_tables nfnetlink poly1305_x86_64 ip6_udp_tunnel udp_tunnel libchacha crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper mousedev psmouse button ena ptp pps_core crc32c_intel
CR2: 0000000000000008

Fixes: d92283e338f6 ("fou: change to use UDP socket GRO")
Reported-by: Alphonse Kurian <alkurian@amazon.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20240902173927.62706-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/fou.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
index 358bff068eef..7bcc933103e2 100644
--- a/net/ipv4/fou.c
+++ b/net/ipv4/fou.c
@@ -48,7 +48,7 @@ struct fou_net {
 
 static inline struct fou *fou_from_sock(struct sock *sk)
 {
-	return sk->sk_user_data;
+	return rcu_dereference_sk_user_data(sk);
 }
 
 static int fou_recv_pull(struct sk_buff *skb, struct fou *fou, size_t len)
@@ -231,9 +231,15 @@ static struct sk_buff *fou_gro_receive(struct sock *sk,
 				       struct sk_buff *skb)
 {
 	const struct net_offload __rcu **offloads;
-	u8 proto = fou_from_sock(sk)->protocol;
+	struct fou *fou = fou_from_sock(sk);
 	const struct net_offload *ops;
 	struct sk_buff *pp = NULL;
+	u8 proto;
+
+	if (!fou)
+		goto out;
+
+	proto = fou->protocol;
 
 	/* We can clear the encap_mark for FOU as we are essentially doing
 	 * one of two possible things.  We are either adding an L4 tunnel
@@ -261,14 +267,24 @@ static int fou_gro_complete(struct sock *sk, struct sk_buff *skb,
 			    int nhoff)
 {
 	const struct net_offload __rcu **offloads;
-	u8 proto = fou_from_sock(sk)->protocol;
+	struct fou *fou = fou_from_sock(sk);
 	const struct net_offload *ops;
-	int err = -ENOSYS;
+	u8 proto;
+	int err;
+
+	if (!fou) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	proto = fou->protocol;
 
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
-	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
+	if (WARN_ON(!ops || !ops->callbacks.gro_complete)) {
+		err = -ENOSYS;
 		goto out;
+	}
 
 	err = ops->callbacks.gro_complete(skb, nhoff);
 
@@ -318,6 +334,9 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 	struct gro_remcsum grc;
 	u8 proto;
 
+	if (!fou)
+		goto out;
+
 	skb_gro_remcsum_init(&grc);
 
 	off = skb_gro_offset(skb);
-- 
2.43.0




