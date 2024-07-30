Return-Path: <stable+bounces-63714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CC2941A44
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6745B282216
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF13184535;
	Tue, 30 Jul 2024 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V0UiVSzm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870D1A619E;
	Tue, 30 Jul 2024 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357718; cv=none; b=IE6jXAp4y7JG3y6hkqSaDaaAII30hKRs+OkaHYAye6yG69RFmdJjrPwxYijNvQu35ExA+6MLYVvK5hLTurGyMROdA16VQGtcxO/6geRMzcAnnKouQ5XqHtO3E5ivMiZe4WhfJfuG63TJyjEK3QNCWLiZ4k2p5EuYvU7Tade+6Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357718; c=relaxed/simple;
	bh=Qv9PXlEzIVe2NMOjKCao2wfra3napqpPwmSCdWlL1Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3BBaaoPuXu9laEEssDeijhjl8K7tGiGAuLBxTqRHeAdjCWB4+4+Nxz1R4ng35DKPMMsgry+ZZ3p/owFeuefoDaXLTfhD/tJBoapY862sec9bUDVR4c6AXN+uweDdtAgNR6kP/W0agXK8Iodv20V3jP2BvVGl2sKGKgO6ksgnRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V0UiVSzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B09CC4AF0C;
	Tue, 30 Jul 2024 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357718;
	bh=Qv9PXlEzIVe2NMOjKCao2wfra3napqpPwmSCdWlL1Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0UiVSzmelCzPE5NuI0/gyL6KlRo8V66zxlxAChxsd+aV3YIYCLZ3R5KoX335v0dd
	 3mo8gIuFi0bhJm+6IG4DedSS6FImKm2dV9+F3ODDFP9TeKKxNZ+73008lNrQWYnCVQ
	 jNfm7ERvpCQvVCo12eSVwrJsb8mEImFoPVhsMZZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzkaller <syzkaller@googlegroups.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 264/809] tcp: Dont access uninit tcp_rsk(req)->ao_keyid in tcp_create_openreq_child().
Date: Tue, 30 Jul 2024 17:42:20 +0200
Message-ID: <20240730151735.018832002@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 3f45181358e4df50a40ea1bb51b00a1f295f915e ]

syzkaller reported KMSAN splat in tcp_create_openreq_child(). [0]

The uninit variable is tcp_rsk(req)->ao_keyid.

tcp_rsk(req)->ao_keyid is initialised only when tcp_conn_request() finds
a valid TCP AO option in SYN.  Then, tcp_rsk(req)->used_tcp_ao is set
accordingly.

Let's not read tcp_rsk(req)->ao_keyid when tcp_rsk(req)->used_tcp_ao is
false.

[0]:
BUG: KMSAN: uninit-value in tcp_create_openreq_child+0x198b/0x1ff0 net/ipv4/tcp_minisocks.c:610
 tcp_create_openreq_child+0x198b/0x1ff0 net/ipv4/tcp_minisocks.c:610
 tcp_v4_syn_recv_sock+0x18e/0x2170 net/ipv4/tcp_ipv4.c:1754
 tcp_check_req+0x1a3e/0x20c0 net/ipv4/tcp_minisocks.c:852
 tcp_v4_rcv+0x26a4/0x53a0 net/ipv4/tcp_ipv4.c:2265
 ip_protocol_deliver_rcu+0x884/0x1270 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x30f/0x530 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x230/0x4c0 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_sublist_rcv_finish net/ipv4/ip_input.c:580 [inline]
 ip_list_rcv_finish net/ipv4/ip_input.c:631 [inline]
 ip_sublist_rcv+0x10f7/0x13e0 net/ipv4/ip_input.c:639
 ip_list_rcv+0x952/0x9c0 net/ipv4/ip_input.c:674
 __netif_receive_skb_list_ptype net/core/dev.c:5703 [inline]
 __netif_receive_skb_list_core+0xd92/0x11d0 net/core/dev.c:5751
 __netif_receive_skb_list net/core/dev.c:5803 [inline]
 netif_receive_skb_list_internal+0xd8f/0x1350 net/core/dev.c:5895
 gro_normal_list include/net/gro.h:515 [inline]
 napi_complete_done+0x3f2/0x990 net/core/dev.c:6246
 e1000_clean+0x1fa4/0x5e50 drivers/net/ethernet/intel/e1000/e1000_main.c:3808
 __napi_poll+0xd9/0x990 net/core/dev.c:6771
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x90f/0x17e0 net/core/dev.c:6962
 handle_softirqs+0x152/0x6b0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0x5d/0x120 kernel/softirq.c:649
 common_interrupt+0x83/0x90 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
 __msan_instrument_asm_store+0xd6/0xe0
 arch_atomic_inc arch/x86/include/asm/atomic.h:53 [inline]
 raw_atomic_inc include/linux/atomic/atomic-arch-fallback.h:992 [inline]
 atomic_inc include/linux/atomic/atomic-instrumented.h:436 [inline]
 page_ref_inc include/linux/page_ref.h:153 [inline]
 folio_ref_inc include/linux/page_ref.h:160 [inline]
 filemap_map_order0_folio mm/filemap.c:3596 [inline]
 filemap_map_pages+0x11c7/0x2270 mm/filemap.c:3644
 do_fault_around mm/memory.c:4879 [inline]
 do_read_fault mm/memory.c:4912 [inline]
 do_fault mm/memory.c:5051 [inline]
 do_pte_missing mm/memory.c:3897 [inline]
 handle_pte_fault mm/memory.c:5381 [inline]
 __handle_mm_fault mm/memory.c:5524 [inline]
 handle_mm_fault+0x3677/0x6f00 mm/memory.c:5689
 do_user_addr_fault+0x1373/0x2b20 arch/x86/mm/fault.c:1338
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x54/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

Uninit was stored to memory at:
 tcp_create_openreq_child+0x1984/0x1ff0 net/ipv4/tcp_minisocks.c:611
 tcp_v4_syn_recv_sock+0x18e/0x2170 net/ipv4/tcp_ipv4.c:1754
 tcp_check_req+0x1a3e/0x20c0 net/ipv4/tcp_minisocks.c:852
 tcp_v4_rcv+0x26a4/0x53a0 net/ipv4/tcp_ipv4.c:2265
 ip_protocol_deliver_rcu+0x884/0x1270 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x30f/0x530 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x230/0x4c0 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_sublist_rcv_finish net/ipv4/ip_input.c:580 [inline]
 ip_list_rcv_finish net/ipv4/ip_input.c:631 [inline]
 ip_sublist_rcv+0x10f7/0x13e0 net/ipv4/ip_input.c:639
 ip_list_rcv+0x952/0x9c0 net/ipv4/ip_input.c:674
 __netif_receive_skb_list_ptype net/core/dev.c:5703 [inline]
 __netif_receive_skb_list_core+0xd92/0x11d0 net/core/dev.c:5751
 __netif_receive_skb_list net/core/dev.c:5803 [inline]
 netif_receive_skb_list_internal+0xd8f/0x1350 net/core/dev.c:5895
 gro_normal_list include/net/gro.h:515 [inline]
 napi_complete_done+0x3f2/0x990 net/core/dev.c:6246
 e1000_clean+0x1fa4/0x5e50 drivers/net/ethernet/intel/e1000/e1000_main.c:3808
 __napi_poll+0xd9/0x990 net/core/dev.c:6771
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x90f/0x17e0 net/core/dev.c:6962
 handle_softirqs+0x152/0x6b0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0x5d/0x120 kernel/softirq.c:649
 common_interrupt+0x83/0x90 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693

Uninit was created at:
 __alloc_pages_noprof+0x82d/0xcb0 mm/page_alloc.c:4706
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page mm/slub.c:2265 [inline]
 allocate_slab mm/slub.c:2428 [inline]
 new_slab+0x2af/0x14e0 mm/slub.c:2481
 ___slab_alloc+0xf73/0x3150 mm/slub.c:3667
 __slab_alloc mm/slub.c:3757 [inline]
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3990 [inline]
 kmem_cache_alloc_noprof+0x53a/0x9f0 mm/slub.c:4009
 reqsk_alloc_noprof net/ipv4/inet_connection_sock.c:920 [inline]
 inet_reqsk_alloc+0x63/0x700 net/ipv4/inet_connection_sock.c:951
 tcp_conn_request+0x339/0x4860 net/ipv4/tcp_input.c:7177
 tcp_v4_conn_request+0x13b/0x190 net/ipv4/tcp_ipv4.c:1719
 tcp_rcv_state_process+0x2dd/0x4a10 net/ipv4/tcp_input.c:6711
 tcp_v4_do_rcv+0xbee/0x10d0 net/ipv4/tcp_ipv4.c:1932
 tcp_v4_rcv+0x3fad/0x53a0 net/ipv4/tcp_ipv4.c:2334
 ip_protocol_deliver_rcu+0x884/0x1270 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x30f/0x530 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x230/0x4c0 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_sublist_rcv_finish net/ipv4/ip_input.c:580 [inline]
 ip_list_rcv_finish net/ipv4/ip_input.c:631 [inline]
 ip_sublist_rcv+0x10f7/0x13e0 net/ipv4/ip_input.c:639
 ip_list_rcv+0x952/0x9c0 net/ipv4/ip_input.c:674
 __netif_receive_skb_list_ptype net/core/dev.c:5703 [inline]
 __netif_receive_skb_list_core+0xd92/0x11d0 net/core/dev.c:5751
 __netif_receive_skb_list net/core/dev.c:5803 [inline]
 netif_receive_skb_list_internal+0xd8f/0x1350 net/core/dev.c:5895
 gro_normal_list include/net/gro.h:515 [inline]
 napi_complete_done+0x3f2/0x990 net/core/dev.c:6246
 e1000_clean+0x1fa4/0x5e50 drivers/net/ethernet/intel/e1000/e1000_main.c:3808
 __napi_poll+0xd9/0x990 net/core/dev.c:6771
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x90f/0x17e0 net/core/dev.c:6962
 handle_softirqs+0x152/0x6b0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0x5d/0x120 kernel/softirq.c:649
 common_interrupt+0x83/0x90 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693

CPU: 0 PID: 239 Comm: modprobe Tainted: G    B              6.10.0-rc7-01816-g852e42cc2dd4 #3 1107521f0c7b55c9309062382d0bda9f604dbb6d
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014

Fixes: 06b22ef29591 ("net/tcp: Wire TCP-AO to request sockets")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Dmitry Safonov <0x7f454c46@gmail.com>
Link: https://patch.msgid.link/20240714161719.6528-1-kuniyu@amazon.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_minisocks.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 538c06f95918d..0fbebf6266e91 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -515,9 +515,6 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	const struct tcp_sock *oldtp;
 	struct tcp_sock *newtp;
 	u32 seq;
-#ifdef CONFIG_TCP_AO
-	struct tcp_ao_key *ao_key;
-#endif
 
 	if (!newsk)
 		return NULL;
@@ -608,10 +605,14 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 #endif
 #ifdef CONFIG_TCP_AO
 	newtp->ao_info = NULL;
-	ao_key = treq->af_specific->ao_lookup(sk, req,
-				tcp_rsk(req)->ao_keyid, -1);
-	if (ao_key)
-		newtp->tcp_header_len += tcp_ao_len_aligned(ao_key);
+
+	if (tcp_rsk_used_ao(req)) {
+		struct tcp_ao_key *ao_key;
+
+		ao_key = treq->af_specific->ao_lookup(sk, req, tcp_rsk(req)->ao_keyid, -1);
+		if (ao_key)
+			newtp->tcp_header_len += tcp_ao_len_aligned(ao_key);
+	}
  #endif
 	if (skb->len >= TCP_MSS_DEFAULT + newtp->tcp_header_len)
 		newicsk->icsk_ack.last_seg_size = skb->len - newtp->tcp_header_len;
-- 
2.43.0




