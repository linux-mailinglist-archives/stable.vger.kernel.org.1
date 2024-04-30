Return-Path: <stable+bounces-42783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AF78B77A1
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 15:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9B71F22AC0
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD1B172790;
	Tue, 30 Apr 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCKIJLz+"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD19171E6E
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485238; cv=none; b=cHR6nmUH32WsmUowtHegVfymdfNCsyy2zhEmAYmVTbJ2YdWJ0gtAeuSdiBmiRgoELKC3PNSs3B2fcQ1FAcZcBRpx2ER9OauSlWBUusdu0vGS0GPD1fbYFaKJ09pB5pphIQ5+M6XLKpwVwXXwG5hxk6o8kHgNrNCmCiXRGmjMwYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485238; c=relaxed/simple;
	bh=GayRwVc4zvQcCHBxnfT4229pSFxE6o5yDc8ttfUWkWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aahfz+rD7At6QUHGxyk27jf2/Uh4tYPyEsMou6wnfLBf0dkCTMiceIxsbOOnE/JZ683tQKSKOVwQQmb7WxNI/iq/l1IYvUo6zI9ezBka81Y1s//dpELhRHl84NHvfRHunKKKKo8ql6ljKXRFH12P70oyam2KgmLAHwnoLCC4LrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCKIJLz+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r4nJwhQvfS0PdEqwGPIVWY/CtZ7P4PzMDdHM2yDybK4=;
	b=dCKIJLz+O7a1BYVIXoC72ZQ8SVTyfG9ygBE+7szwqWBAunZpgxQfLG71GwECfgTZcQ8kge
	ObaSr26g9kjMQMfGL/L75jEWb99bQo4QurShFuuhnrncUJTMPq+g5ndT9EqkHoMdEbYJUp
	BkLfclcT+0ezWHZ48S567/dwx3fS6NU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-xZxszuyzMYWL0Ny4EehoSg-1; Tue,
 30 Apr 2024 09:53:51 -0400
X-MC-Unique: xZxszuyzMYWL0Ny4EehoSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A32493C12826;
	Tue, 30 Apr 2024 13:53:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.174])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 53DB11121312;
	Tue, 30 Apr 2024 13:53:48 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	tipc-discussion@lists.sourceforge.net,
	Long Xin <lxin@redhat.com>,
	stable@vger.kernel.org,
	zdi-disclosures@trendmicro.com
Subject: [PATCH net] tipc: fix UAF in error path
Date: Tue, 30 Apr 2024 15:53:37 +0200
Message-ID: <752f1ccf762223d109845365d07f55414058e5a3.1714484273.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Sam Page (sam4k) working with Trend Micro Zero Day Initiative reported
a UAF in the tipc_buf_append() error path:

BUG: KASAN: slab-use-after-free in kfree_skb_list_reason+0x47e/0x4c0
linux/net/core/skbuff.c:1183
Read of size 8 at addr ffff88804d2a7c80 by task poc/8034

CPU: 1 PID: 8034 Comm: poc Not tainted 6.8.2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.0-debian-1.16.0-5 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack linux/lib/dump_stack.c:88
 dump_stack_lvl+0xd9/0x1b0 linux/lib/dump_stack.c:106
 print_address_description linux/mm/kasan/report.c:377
 print_report+0xc4/0x620 linux/mm/kasan/report.c:488
 kasan_report+0xda/0x110 linux/mm/kasan/report.c:601
 kfree_skb_list_reason+0x47e/0x4c0 linux/net/core/skbuff.c:1183
 skb_release_data+0x5af/0x880 linux/net/core/skbuff.c:1026
 skb_release_all linux/net/core/skbuff.c:1094
 __kfree_skb linux/net/core/skbuff.c:1108
 kfree_skb_reason+0x12d/0x210 linux/net/core/skbuff.c:1144
 kfree_skb linux/./include/linux/skbuff.h:1244
 tipc_buf_append+0x425/0xb50 linux/net/tipc/msg.c:186
 tipc_link_input+0x224/0x7c0 linux/net/tipc/link.c:1324
 tipc_link_rcv+0x76e/0x2d70 linux/net/tipc/link.c:1824
 tipc_rcv+0x45f/0x10f0 linux/net/tipc/node.c:2159
 tipc_udp_recv+0x73b/0x8f0 linux/net/tipc/udp_media.c:390
 udp_queue_rcv_one_skb+0xad2/0x1850 linux/net/ipv4/udp.c:2108
 udp_queue_rcv_skb+0x131/0xb00 linux/net/ipv4/udp.c:2186
 udp_unicast_rcv_skb+0x165/0x3b0 linux/net/ipv4/udp.c:2346
 __udp4_lib_rcv+0x2594/0x3400 linux/net/ipv4/udp.c:2422
 ip_protocol_deliver_rcu+0x30c/0x4e0 linux/net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x2e4/0x520 linux/net/ipv4/ip_input.c:233
 NF_HOOK linux/./include/linux/netfilter.h:314
 NF_HOOK linux/./include/linux/netfilter.h:308
 ip_local_deliver+0x18e/0x1f0 linux/net/ipv4/ip_input.c:254
 dst_input linux/./include/net/dst.h:461
 ip_rcv_finish linux/net/ipv4/ip_input.c:449
 NF_HOOK linux/./include/linux/netfilter.h:314
 NF_HOOK linux/./include/linux/netfilter.h:308
 ip_rcv+0x2c5/0x5d0 linux/net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core+0x199/0x1e0 linux/net/core/dev.c:5534
 __netif_receive_skb+0x1f/0x1c0 linux/net/core/dev.c:5648
 process_backlog+0x101/0x6b0 linux/net/core/dev.c:5976
 __napi_poll.constprop.0+0xba/0x550 linux/net/core/dev.c:6576
 napi_poll linux/net/core/dev.c:6645
 net_rx_action+0x95a/0xe90 linux/net/core/dev.c:6781
 __do_softirq+0x21f/0x8e7 linux/kernel/softirq.c:553
 do_softirq linux/kernel/softirq.c:454
 do_softirq+0xb2/0xf0 linux/kernel/softirq.c:441
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 linux/kernel/softirq.c:381
 local_bh_enable linux/./include/linux/bottom_half.h:33
 rcu_read_unlock_bh linux/./include/linux/rcupdate.h:851
 __dev_queue_xmit+0x871/0x3ee0 linux/net/core/dev.c:4378
 dev_queue_xmit linux/./include/linux/netdevice.h:3169
 neigh_hh_output linux/./include/net/neighbour.h:526
 neigh_output linux/./include/net/neighbour.h:540
 ip_finish_output2+0x169f/0x2550 linux/net/ipv4/ip_output.c:235
 __ip_finish_output linux/net/ipv4/ip_output.c:313
 __ip_finish_output+0x49e/0x950 linux/net/ipv4/ip_output.c:295
 ip_finish_output+0x31/0x310 linux/net/ipv4/ip_output.c:323
 NF_HOOK_COND linux/./include/linux/netfilter.h:303
 ip_output+0x13b/0x2a0 linux/net/ipv4/ip_output.c:433
 dst_output linux/./include/net/dst.h:451
 ip_local_out linux/net/ipv4/ip_output.c:129
 ip_send_skb+0x3e5/0x560 linux/net/ipv4/ip_output.c:1492
 udp_send_skb+0x73f/0x1530 linux/net/ipv4/udp.c:963
 udp_sendmsg+0x1a36/0x2b40 linux/net/ipv4/udp.c:1250
 inet_sendmsg+0x105/0x140 linux/net/ipv4/af_inet.c:850
 sock_sendmsg_nosec linux/net/socket.c:730
 __sock_sendmsg linux/net/socket.c:745
 __sys_sendto+0x42c/0x4e0 linux/net/socket.c:2191
 __do_sys_sendto linux/net/socket.c:2203
 __se_sys_sendto linux/net/socket.c:2199
 __x64_sys_sendto+0xe0/0x1c0 linux/net/socket.c:2199
 do_syscall_x64 linux/arch/x86/entry/common.c:52
 do_syscall_64+0xd8/0x270 linux/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77 linux/arch/x86/entry/entry_64.S:120
RIP: 0033:0x7f3434974f29
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d 37 8f 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007fff9154f2b8 EFLAGS: 00000212 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3434974f29
RDX: 00000000000032c8 RSI: 00007fff9154f300 RDI: 0000000000000003
RBP: 00007fff915532e0 R08: 00007fff91553360 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000212 R12: 000055ed86d261d0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

In the critical scenario, either the relevant skb is freed or its
ownership is transferred into a frag_lists. In both cases, the cleanup
code must not free it again: we need to clear the skb reference earlier.

Fixes: 1149557d64c9 ("tipc: eliminate unnecessary linearization of incoming buffers")
Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-23852
Acked-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/tipc/msg.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index 5c9fd4791c4b..9a6e9bcbf694 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -156,6 +156,11 @@ int tipc_buf_append(struct sk_buff **headbuf, struct sk_buff **buf)
 	if (!head)
 		goto err;
 
+	/* Either the input skb ownership is transferred to headskb
+	 * or the input skb is freed, clear the reference to avoid
+	 * bad access on error path.
+	 */
+	*buf = NULL;
 	if (skb_try_coalesce(head, frag, &headstolen, &delta)) {
 		kfree_skb_partial(frag, headstolen);
 	} else {
@@ -179,7 +184,6 @@ int tipc_buf_append(struct sk_buff **headbuf, struct sk_buff **buf)
 		*headbuf = NULL;
 		return 1;
 	}
-	*buf = NULL;
 	return 0;
 err:
 	kfree_skb(*buf);
-- 
2.43.2


