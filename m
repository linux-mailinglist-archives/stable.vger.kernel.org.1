Return-Path: <stable+bounces-85413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762DD99E738
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27768285833
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F18D1E766D;
	Tue, 15 Oct 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w6SHHmNb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B11E764A;
	Tue, 15 Oct 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993032; cv=none; b=tM/eYXAbSJ9rMo2K5DPRTJu6ntQb5GL3WGGudSoPL8GLeN8mofT/WqKlGvp20C2nel9z+f9Zpv7ZFNg4HmssAvTT+FMHPwHjPGrFmHZIWwkiDUWXUDZ616SlqMkVwhrM+6rWfmAg5y4C9YRe2Y+G8gwAbFNo0NYhJloteyBkmHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993032; c=relaxed/simple;
	bh=W0WKNaUjnTnghVkYpdj6GwVsrkkMMmbG5rc3NM1b4xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtTL61k4GooSw2PI2spUjvzEGzKaTVl457EjdWsIhbSqN2phbDll6gBctfB+p2Uk+eXW+rNiF4RqvFmk3afuzYdFjmOzBOL0cI+JoLQGMPeX8+xAt+bNrNbM2vatoBvtIq7nIQK5JkeOzYz7u0WcKeDMs7q+No5pg3mCa2LTeEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w6SHHmNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B420C4CEC6;
	Tue, 15 Oct 2024 11:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993032;
	bh=W0WKNaUjnTnghVkYpdj6GwVsrkkMMmbG5rc3NM1b4xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w6SHHmNbf4HtfIROxPGTCPBrASUAkIIqGY2dPv7qHfauxPpPVoDMDLGbT5YtzGhj8
	 6US3ttO+XN6H+6sZDTXNR7UGK6BpWaD8v58E4/lOTo2ubrLzZtPeAokmfixC51X/Q2
	 fX4zAs08f3ZRXTC7Nh2xN1cOjwqPj1D/UtT8s8Nw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 291/691] netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()
Date: Tue, 15 Oct 2024 13:23:59 +0200
Message-ID: <20241015112451.896137710@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9c778fe48d20ef362047e3376dee56d77f8500d4 ]

syzbot reported that nf_reject_ip6_tcphdr_put() was possibly sending
garbage on the four reserved tcp bits (th->res1)

Use skb_put_zero() to clear the whole TCP header,
as done in nf_reject_ip_tcphdr_put()

BUG: KMSAN: uninit-value in nf_reject_ip6_tcphdr_put+0x688/0x6c0 net/ipv6/netfilter/nf_reject_ipv6.c:255
  nf_reject_ip6_tcphdr_put+0x688/0x6c0 net/ipv6/netfilter/nf_reject_ipv6.c:255
  nf_send_reset6+0xd84/0x15b0 net/ipv6/netfilter/nf_reject_ipv6.c:344
  nft_reject_inet_eval+0x3c1/0x880 net/netfilter/nft_reject_inet.c:48
  expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
  nft_do_chain+0x438/0x22a0 net/netfilter/nf_tables_core.c:288
  nft_do_chain_inet+0x41a/0x4f0 net/netfilter/nft_chain_filter.c:161
  nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
  nf_hook_slow+0xf4/0x400 net/netfilter/core.c:626
  nf_hook include/linux/netfilter.h:269 [inline]
  NF_HOOK include/linux/netfilter.h:312 [inline]
  ipv6_rcv+0x29b/0x390 net/ipv6/ip6_input.c:310
  __netif_receive_skb_one_core net/core/dev.c:5661 [inline]
  __netif_receive_skb+0x1da/0xa00 net/core/dev.c:5775
  process_backlog+0x4ad/0xa50 net/core/dev.c:6108
  __napi_poll+0xe7/0x980 net/core/dev.c:6772
  napi_poll net/core/dev.c:6841 [inline]
  net_rx_action+0xa5a/0x19b0 net/core/dev.c:6963
  handle_softirqs+0x1ce/0x800 kernel/softirq.c:554
  __do_softirq+0x14/0x1a kernel/softirq.c:588
  do_softirq+0x9a/0x100 kernel/softirq.c:455
  __local_bh_enable_ip+0x9f/0xb0 kernel/softirq.c:382
  local_bh_enable include/linux/bottom_half.h:33 [inline]
  rcu_read_unlock_bh include/linux/rcupdate.h:908 [inline]
  __dev_queue_xmit+0x2692/0x5610 net/core/dev.c:4450
  dev_queue_xmit include/linux/netdevice.h:3105 [inline]
  neigh_resolve_output+0x9ca/0xae0 net/core/neighbour.c:1565
  neigh_output include/net/neighbour.h:542 [inline]
  ip6_finish_output2+0x2347/0x2ba0 net/ipv6/ip6_output.c:141
  __ip6_finish_output net/ipv6/ip6_output.c:215 [inline]
  ip6_finish_output+0xbb8/0x14b0 net/ipv6/ip6_output.c:226
  NF_HOOK_COND include/linux/netfilter.h:303 [inline]
  ip6_output+0x356/0x620 net/ipv6/ip6_output.c:247
  dst_output include/net/dst.h:450 [inline]
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ip6_xmit+0x1ba6/0x25d0 net/ipv6/ip6_output.c:366
  inet6_csk_xmit+0x442/0x530 net/ipv6/inet6_connection_sock.c:135
  __tcp_transmit_skb+0x3b07/0x4880 net/ipv4/tcp_output.c:1466
  tcp_transmit_skb net/ipv4/tcp_output.c:1484 [inline]
  tcp_connect+0x35b6/0x7130 net/ipv4/tcp_output.c:4143
  tcp_v6_connect+0x1bcc/0x1e40 net/ipv6/tcp_ipv6.c:333
  __inet_stream_connect+0x2ef/0x1730 net/ipv4/af_inet.c:679
  inet_stream_connect+0x6a/0xd0 net/ipv4/af_inet.c:750
  __sys_connect_file net/socket.c:2061 [inline]
  __sys_connect+0x606/0x690 net/socket.c:2078
  __do_sys_connect net/socket.c:2088 [inline]
  __se_sys_connect net/socket.c:2085 [inline]
  __x64_sys_connect+0x91/0xe0 net/socket.c:2085
  x64_sys_call+0x27a5/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:43
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
  nf_reject_ip6_tcphdr_put+0x60c/0x6c0 net/ipv6/netfilter/nf_reject_ipv6.c:249
  nf_send_reset6+0xd84/0x15b0 net/ipv6/netfilter/nf_reject_ipv6.c:344
  nft_reject_inet_eval+0x3c1/0x880 net/netfilter/nft_reject_inet.c:48
  expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
  nft_do_chain+0x438/0x22a0 net/netfilter/nf_tables_core.c:288
  nft_do_chain_inet+0x41a/0x4f0 net/netfilter/nft_chain_filter.c:161
  nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
  nf_hook_slow+0xf4/0x400 net/netfilter/core.c:626
  nf_hook include/linux/netfilter.h:269 [inline]
  NF_HOOK include/linux/netfilter.h:312 [inline]
  ipv6_rcv+0x29b/0x390 net/ipv6/ip6_input.c:310
  __netif_receive_skb_one_core net/core/dev.c:5661 [inline]
  __netif_receive_skb+0x1da/0xa00 net/core/dev.c:5775
  process_backlog+0x4ad/0xa50 net/core/dev.c:6108
  __napi_poll+0xe7/0x980 net/core/dev.c:6772
  napi_poll net/core/dev.c:6841 [inline]
  net_rx_action+0xa5a/0x19b0 net/core/dev.c:6963
  handle_softirqs+0x1ce/0x800 kernel/softirq.c:554
  __do_softirq+0x14/0x1a kernel/softirq.c:588

Uninit was stored to memory at:
  nf_reject_ip6_tcphdr_put+0x2ca/0x6c0 net/ipv6/netfilter/nf_reject_ipv6.c:231
  nf_send_reset6+0xd84/0x15b0 net/ipv6/netfilter/nf_reject_ipv6.c:344
  nft_reject_inet_eval+0x3c1/0x880 net/netfilter/nft_reject_inet.c:48
  expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
  nft_do_chain+0x438/0x22a0 net/netfilter/nf_tables_core.c:288
  nft_do_chain_inet+0x41a/0x4f0 net/netfilter/nft_chain_filter.c:161
  nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
  nf_hook_slow+0xf4/0x400 net/netfilter/core.c:626
  nf_hook include/linux/netfilter.h:269 [inline]
  NF_HOOK include/linux/netfilter.h:312 [inline]
  ipv6_rcv+0x29b/0x390 net/ipv6/ip6_input.c:310
  __netif_receive_skb_one_core net/core/dev.c:5661 [inline]
  __netif_receive_skb+0x1da/0xa00 net/core/dev.c:5775
  process_backlog+0x4ad/0xa50 net/core/dev.c:6108
  __napi_poll+0xe7/0x980 net/core/dev.c:6772
  napi_poll net/core/dev.c:6841 [inline]
  net_rx_action+0xa5a/0x19b0 net/core/dev.c:6963
  handle_softirqs+0x1ce/0x800 kernel/softirq.c:554
  __do_softirq+0x14/0x1a kernel/softirq.c:588

Uninit was created at:
  slab_post_alloc_hook mm/slub.c:3998 [inline]
  slab_alloc_node mm/slub.c:4041 [inline]
  kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4084
  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:583
  __alloc_skb+0x363/0x7b0 net/core/skbuff.c:674
  alloc_skb include/linux/skbuff.h:1320 [inline]
  nf_send_reset6+0x98d/0x15b0 net/ipv6/netfilter/nf_reject_ipv6.c:327
  nft_reject_inet_eval+0x3c1/0x880 net/netfilter/nft_reject_inet.c:48
  expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
  nft_do_chain+0x438/0x22a0 net/netfilter/nf_tables_core.c:288
  nft_do_chain_inet+0x41a/0x4f0 net/netfilter/nft_chain_filter.c:161
  nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
  nf_hook_slow+0xf4/0x400 net/netfilter/core.c:626
  nf_hook include/linux/netfilter.h:269 [inline]
  NF_HOOK include/linux/netfilter.h:312 [inline]
  ipv6_rcv+0x29b/0x390 net/ipv6/ip6_input.c:310
  __netif_receive_skb_one_core net/core/dev.c:5661 [inline]
  __netif_receive_skb+0x1da/0xa00 net/core/dev.c:5775
  process_backlog+0x4ad/0xa50 net/core/dev.c:6108
  __napi_poll+0xe7/0x980 net/core/dev.c:6772
  napi_poll net/core/dev.c:6841 [inline]
  net_rx_action+0xa5a/0x19b0 net/core/dev.c:6963
  handle_softirqs+0x1ce/0x800 kernel/softirq.c:554
  __do_softirq+0x14/0x1a kernel/softirq.c:588

Fixes: c8d7b98bec43 ("netfilter: move nf_send_resetX() code to nf_reject_ipvX modules")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>
Link: https://patch.msgid.link/20240913170615.3670897-1-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/netfilter/nf_reject_ipv6.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index c0057edd84cfc..8208490e05a38 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -223,33 +223,23 @@ void nf_reject_ip6_tcphdr_put(struct sk_buff *nskb,
 			      const struct tcphdr *oth, unsigned int otcplen)
 {
 	struct tcphdr *tcph;
-	int needs_ack;
 
 	skb_reset_transport_header(nskb);
-	tcph = skb_put(nskb, sizeof(struct tcphdr));
+	tcph = skb_put_zero(nskb, sizeof(struct tcphdr));
 	/* Truncate to length (no data) */
 	tcph->doff = sizeof(struct tcphdr)/4;
 	tcph->source = oth->dest;
 	tcph->dest = oth->source;
 
 	if (oth->ack) {
-		needs_ack = 0;
 		tcph->seq = oth->ack_seq;
-		tcph->ack_seq = 0;
 	} else {
-		needs_ack = 1;
 		tcph->ack_seq = htonl(ntohl(oth->seq) + oth->syn + oth->fin +
 				      otcplen - (oth->doff<<2));
-		tcph->seq = 0;
+		tcph->ack = 1;
 	}
 
-	/* Reset flags */
-	((u_int8_t *)tcph)[13] = 0;
 	tcph->rst = 1;
-	tcph->ack = needs_ack;
-	tcph->window = 0;
-	tcph->urg_ptr = 0;
-	tcph->check = 0;
 
 	/* Adjust TCP checksum */
 	tcph->check = csum_ipv6_magic(&ipv6_hdr(nskb)->saddr,
-- 
2.43.0




