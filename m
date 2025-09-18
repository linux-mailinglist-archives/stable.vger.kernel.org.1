Return-Path: <stable+bounces-168068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6989B23351
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35BE118935BA
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884DF2F5481;
	Tue, 12 Aug 2025 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x0l0cOa4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E702ED17F;
	Tue, 12 Aug 2025 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022930; cv=none; b=s3KNZPu+2lx+aylv/bpFycdDZ9JJQhq1L3cxTYHzwIRauJaSS/jynNXXlPJSzY7qT25o1edsMJhHha3B1BS9d0QGD8lTU2MT5qN12sY/ezXesWbnc734g38mXS/DjZOEUDPRJm6SC/fS3b7JmMq3r3bngqhhBpiOPK47Vpb+TS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022930; c=relaxed/simple;
	bh=dg4mZHsxlhUazvqBZ/cXoEoivQm26AoY/ckYpCGSXbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Io0izn+HCb2bg0eGKnx2ewUo/c2eKMnoU0twUi7jgTsyk2OQ1PQyLC7exA+EyIDDfWze5T6Pg4coT+FdjncMh+PmIgrSnCDf2krG40c76CPW05dEKZ3Fb4VyMSZUkBnB/lGT3x+dJKgcKohIIRpYfSFQWpTc79Wb9xRKPWQnaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x0l0cOa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76DFC4CEF0;
	Tue, 12 Aug 2025 18:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022930;
	bh=dg4mZHsxlhUazvqBZ/cXoEoivQm26AoY/ckYpCGSXbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x0l0cOa4urW5guqUoAXMqjlv38/R9z0KdABY0g3vcgJjt1PxP3i1Re0gO4CeVy9YJ
	 Z9cYn0tumQql1+UAd0DeWla4cI3/qpN40VpjiOTGVtmiKTC9sLj9V5DM4LQqddLFYr
	 IRJTUwlBlunMz/gaI3o7x9JIT4j287xKpptSKUx0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Wang Liang <wangliang74@huawei.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 301/369] net: drop UFO packets in udp_rcv_segment()
Date: Tue, 12 Aug 2025 19:29:58 +0200
Message-ID: <20250812173028.054949908@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Liang <wangliang74@huawei.com>

[ Upstream commit d46e51f1c78b9ab9323610feb14238d06d46d519 ]

When sending a packet with virtio_net_hdr to tun device, if the gso_type
in virtio_net_hdr is SKB_GSO_UDP and the gso_size is less than udphdr
size, below crash may happen.

  ------------[ cut here ]------------
  kernel BUG at net/core/skbuff.c:4572!
  Oops: invalid opcode: 0000 [#1] SMP NOPTI
  CPU: 0 UID: 0 PID: 62 Comm: mytest Not tainted 6.16.0-rc7 #203 PREEMPT(voluntary)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
  RIP: 0010:skb_pull_rcsum+0x8e/0xa0
  Code: 00 00 5b c3 cc cc cc cc 8b 93 88 00 00 00 f7 da e8 37 44 38 00 f7 d8 89 83 88 00 00 00 48 8b 83 c8 00 00 00 5b c3 cc cc cc cc <0f> 0b 0f 0b 66 66 2e 0f 1f 84 00 000
  RSP: 0018:ffffc900001fba38 EFLAGS: 00000297
  RAX: 0000000000000004 RBX: ffff8880040c1000 RCX: ffffc900001fb948
  RDX: ffff888003e6d700 RSI: 0000000000000008 RDI: ffff88800411a062
  RBP: ffff8880040c1000 R08: 0000000000000000 R09: 0000000000000001
  R10: ffff888003606c00 R11: 0000000000000001 R12: 0000000000000000
  R13: ffff888004060900 R14: ffff888004050000 R15: ffff888004060900
  FS:  000000002406d3c0(0000) GS:ffff888084a19000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000020000040 CR3: 0000000004007000 CR4: 00000000000006f0
  Call Trace:
   <TASK>
   udp_queue_rcv_one_skb+0x176/0x4b0 net/ipv4/udp.c:2445
   udp_queue_rcv_skb+0x155/0x1f0 net/ipv4/udp.c:2475
   udp_unicast_rcv_skb+0x71/0x90 net/ipv4/udp.c:2626
   __udp4_lib_rcv+0x433/0xb00 net/ipv4/udp.c:2690
   ip_protocol_deliver_rcu+0xa6/0x160 net/ipv4/ip_input.c:205
   ip_local_deliver_finish+0x72/0x90 net/ipv4/ip_input.c:233
   ip_sublist_rcv_finish+0x5f/0x70 net/ipv4/ip_input.c:579
   ip_sublist_rcv+0x122/0x1b0 net/ipv4/ip_input.c:636
   ip_list_rcv+0xf7/0x130 net/ipv4/ip_input.c:670
   __netif_receive_skb_list_core+0x21d/0x240 net/core/dev.c:6067
   netif_receive_skb_list_internal+0x186/0x2b0 net/core/dev.c:6210
   napi_complete_done+0x78/0x180 net/core/dev.c:6580
   tun_get_user+0xa63/0x1120 drivers/net/tun.c:1909
   tun_chr_write_iter+0x65/0xb0 drivers/net/tun.c:1984
   vfs_write+0x300/0x420 fs/read_write.c:593
   ksys_write+0x60/0xd0 fs/read_write.c:686
   do_syscall_64+0x50/0x1c0 arch/x86/entry/syscall_64.c:63
   </TASK>

To trigger gso segment in udp_queue_rcv_skb(), we should also set option
UDP_ENCAP_ESPINUDP to enable udp_sk(sk)->encap_rcv. When the encap_rcv
hook return 1 in udp_queue_rcv_one_skb(), udp_csum_pull_header() will try
to pull udphdr, but the skb size has been segmented to gso size, which
leads to this crash.

Previous commit cf329aa42b66 ("udp: cope with UDP GRO packet misdirection")
introduces segmentation in UDP receive path only for GRO, which was never
intended to be used for UFO, so drop UFO packets in udp_rcv_segment().

Link: https://lore.kernel.org/netdev/20250724083005.3918375-1-wangliang74@huawei.com/
Link: https://lore.kernel.org/netdev/20250729123907.3318425-1-wangliang74@huawei.com/
Fixes: cf329aa42b66 ("udp: cope with UDP GRO packet misdirection")
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Wang Liang <wangliang74@huawei.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20250730101458.3470788-1-wangliang74@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/udp.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 61222545ab1c..0b2e3a5e01d8 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -461,6 +461,16 @@ static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
 {
 	netdev_features_t features = NETIF_F_SG;
 	struct sk_buff *segs;
+	int drop_count;
+
+	/*
+	 * Segmentation in UDP receive path is only for UDP GRO, drop udp
+	 * fragmentation offload (UFO) packets.
+	 */
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP) {
+		drop_count = 1;
+		goto drop;
+	}
 
 	/* Avoid csum recalculation by skb_segment unless userspace explicitly
 	 * asks for the final checksum values
@@ -484,16 +494,18 @@ static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
 	 */
 	segs = __skb_gso_segment(skb, features, false);
 	if (IS_ERR_OR_NULL(segs)) {
-		int segs_nr = skb_shinfo(skb)->gso_segs;
-
-		atomic_add(segs_nr, &sk->sk_drops);
-		SNMP_ADD_STATS(__UDPX_MIB(sk, ipv4), UDP_MIB_INERRORS, segs_nr);
-		kfree_skb(skb);
-		return NULL;
+		drop_count = skb_shinfo(skb)->gso_segs;
+		goto drop;
 	}
 
 	consume_skb(skb);
 	return segs;
+
+drop:
+	atomic_add(drop_count, &sk->sk_drops);
+	SNMP_ADD_STATS(__UDPX_MIB(sk, ipv4), UDP_MIB_INERRORS, drop_count);
+	kfree_skb(skb);
+	return NULL;
 }
 
 static inline void udp_post_segment_fix_csum(struct sk_buff *skb)
-- 
2.39.5




