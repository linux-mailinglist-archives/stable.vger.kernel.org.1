Return-Path: <stable+bounces-82668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D9F994DDF
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1300528320D
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5E71DEFD7;
	Tue,  8 Oct 2024 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cm4nDc93"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271F61DE8A0;
	Tue,  8 Oct 2024 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393023; cv=none; b=BMx7mxHGq2iS6Njs3Ku2FXWdAomhBFbQV6ag3aayNiTyQGtkdga7jVlCE9y4XcV/KWMTaiLS9DxE+RPHeAUUE1iXQj939vs+cv6GbAB88eqduW9fdv5nNbHKbRgeEI4FVaY5KKgBqrRd9uhxO9bj3eiIEEd6SnYyDlFLm8BXO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393023; c=relaxed/simple;
	bh=3qiSEv3BMZpIXXQaFYKGqrmh6g6RR6we7NuNFIYph3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+A2RRAW+tO2BkU/deUkWG6x0s/u0vWAHwXPWSlS/ZtpbbM9G5dFT4xfkhNFAHDE47vjZnS0VD41GzpPoFnjh3IGNv/3R8/tw68hMjILscPcCa3gpGFmj6D14sMVTjrnHWjD0xFkpULZ2R6Xrbjg0DG6zpN7xjSCSOqkR1qJtcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cm4nDc93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB36C4CEC7;
	Tue,  8 Oct 2024 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728393023;
	bh=3qiSEv3BMZpIXXQaFYKGqrmh6g6RR6we7NuNFIYph3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cm4nDc93Ids+Ef1zkjX65mFjT+zuh609LSaNlxKsUq/WWEncQ0n8isiNBvpUoq5J+
	 Uz7TMP7vtRd7p1jejnLW3mG5W3hGk2D7mnFtmvcA83RVhTTCJkTvAZMjIC63H6J3Oj
	 P4rL48S0tgymGAvT00NBKRWtYD5kuuIGgI1sQZXc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Jonathan Davies <jonathan.davies@nutanix.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 030/386] net: avoid potential underflow in qdisc_pkt_len_init() with UFO
Date: Tue,  8 Oct 2024 14:04:35 +0200
Message-ID: <20241008115630.665076549@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit c20029db28399ecc50e556964eaba75c43b1e2f1 ]

After commit 7c6d2ecbda83 ("net: be more gentle about silly gso
requests coming from user") virtio_net_hdr_to_skb() had sanity check
to detect malicious attempts from user space to cook a bad GSO packet.

Then commit cf9acc90c80ec ("net: virtio_net_hdr_to_skb: count
transport header in UFO") while fixing one issue, allowed user space
to cook a GSO packet with the following characteristic :

IPv4 SKB_GSO_UDP, gso_size=3, skb->len = 28.

When this packet arrives in qdisc_pkt_len_init(), we end up
with hdr_len = 28 (IPv4 header + UDP header), matching skb->len

Then the following sets gso_segs to 0 :

gso_segs = DIV_ROUND_UP(skb->len - hdr_len,
                        shinfo->gso_size);

Then later we set qdisc_skb_cb(skb)->pkt_len to back to zero :/

qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;

This leads to the following crash in fq_codel [1]

qdisc_pkt_len_init() is best effort, we only want an estimation
of the bytes sent on the wire, not crashing the kernel.

This patch is fixing this particular issue, a following one
adds more sanity checks for another potential bug.

[1]
[   70.724101] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   70.724561] #PF: supervisor read access in kernel mode
[   70.724561] #PF: error_code(0x0000) - not-present page
[   70.724561] PGD 10ac61067 P4D 10ac61067 PUD 107ee2067 PMD 0
[   70.724561] Oops: Oops: 0000 [#1] SMP NOPTI
[   70.724561] CPU: 11 UID: 0 PID: 2163 Comm: b358537762 Not tainted 6.11.0-virtme #991
[   70.724561] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   70.724561] RIP: 0010:fq_codel_enqueue (net/sched/sch_fq_codel.c:120 net/sched/sch_fq_codel.c:168 net/sched/sch_fq_codel.c:230) sch_fq_codel
[ 70.724561] Code: 24 08 49 c1 e1 06 44 89 7c 24 18 45 31 ed 45 31 c0 31 ff 89 44 24 14 4c 03 8b 90 01 00 00 eb 04 39 ca 73 37 4d 8b 39 83 c7 01 <49> 8b 17 49 89 11 41 8b 57 28 45 8b 5f 34 49 c7 07 00 00 00 00 49
All code
========
   0:	24 08                	and    $0x8,%al
   2:	49 c1 e1 06          	shl    $0x6,%r9
   6:	44 89 7c 24 18       	mov    %r15d,0x18(%rsp)
   b:	45 31 ed             	xor    %r13d,%r13d
   e:	45 31 c0             	xor    %r8d,%r8d
  11:	31 ff                	xor    %edi,%edi
  13:	89 44 24 14          	mov    %eax,0x14(%rsp)
  17:	4c 03 8b 90 01 00 00 	add    0x190(%rbx),%r9
  1e:	eb 04                	jmp    0x24
  20:	39 ca                	cmp    %ecx,%edx
  22:	73 37                	jae    0x5b
  24:	4d 8b 39             	mov    (%r9),%r15
  27:	83 c7 01             	add    $0x1,%edi
  2a:*	49 8b 17             	mov    (%r15),%rdx		<-- trapping instruction
  2d:	49 89 11             	mov    %rdx,(%r9)
  30:	41 8b 57 28          	mov    0x28(%r15),%edx
  34:	45 8b 5f 34          	mov    0x34(%r15),%r11d
  38:	49 c7 07 00 00 00 00 	movq   $0x0,(%r15)
  3f:	49                   	rex.WB

Code starting with the faulting instruction
===========================================
   0:	49 8b 17             	mov    (%r15),%rdx
   3:	49 89 11             	mov    %rdx,(%r9)
   6:	41 8b 57 28          	mov    0x28(%r15),%edx
   a:	45 8b 5f 34          	mov    0x34(%r15),%r11d
   e:	49 c7 07 00 00 00 00 	movq   $0x0,(%r15)
  15:	49                   	rex.WB
[   70.724561] RSP: 0018:ffff95ae85e6fb90 EFLAGS: 00000202
[   70.724561] RAX: 0000000002000000 RBX: ffff95ae841de000 RCX: 0000000000000000
[   70.724561] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
[   70.724561] RBP: ffff95ae85e6fbf8 R08: 0000000000000000 R09: ffff95b710a30000
[   70.724561] R10: 0000000000000000 R11: bdf289445ce31881 R12: ffff95ae85e6fc58
[   70.724561] R13: 0000000000000000 R14: 0000000000000040 R15: 0000000000000000
[   70.724561] FS:  000000002c5c1380(0000) GS:ffff95bd7fcc0000(0000) knlGS:0000000000000000
[   70.724561] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   70.724561] CR2: 0000000000000000 CR3: 000000010c568000 CR4: 00000000000006f0
[   70.724561] Call Trace:
[   70.724561]  <TASK>
[   70.724561] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434)
[   70.724561] ? page_fault_oops (arch/x86/mm/fault.c:715)
[   70.724561] ? exc_page_fault (./arch/x86/include/asm/irqflags.h:26 ./arch/x86/include/asm/irqflags.h:87 ./arch/x86/include/asm/irqflags.h:147 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
[   70.724561] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623)
[   70.724561] ? fq_codel_enqueue (net/sched/sch_fq_codel.c:120 net/sched/sch_fq_codel.c:168 net/sched/sch_fq_codel.c:230) sch_fq_codel
[   70.724561] dev_qdisc_enqueue (net/core/dev.c:3784)
[   70.724561] __dev_queue_xmit (net/core/dev.c:3880 (discriminator 2) net/core/dev.c:4390 (discriminator 2))
[   70.724561] ? irqentry_enter (kernel/entry/common.c:237)
[   70.724561] ? sysvec_apic_timer_interrupt (./arch/x86/include/asm/hardirq.h:74 (discriminator 2) arch/x86/kernel/apic/apic.c:1043 (discriminator 2) arch/x86/kernel/apic/apic.c:1043 (discriminator 2))
[   70.724561] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:58 (discriminator 4))
[   70.724561] ? asm_sysvec_apic_timer_interrupt (./arch/x86/include/asm/idtentry.h:702)
[   70.724561] ? virtio_net_hdr_to_skb.constprop.0 (./include/linux/virtio_net.h:129 (discriminator 1))
[   70.724561] packet_sendmsg (net/packet/af_packet.c:3145 (discriminator 1) net/packet/af_packet.c:3177 (discriminator 1))
[   70.724561] ? _raw_spin_lock_bh (./arch/x86/include/asm/atomic.h:107 (discriminator 4) ./include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) ./include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) ./include/asm-generic/qspinlock.h:111 (discriminator 4) ./include/linux/spinlock.h:187 (discriminator 4) ./include/linux/spinlock_api_smp.h:127 (discriminator 4) kernel/locking/spinlock.c:178 (discriminator 4))
[   70.724561] ? netdev_name_node_lookup_rcu (net/core/dev.c:325 (discriminator 1))
[   70.724561] __sys_sendto (net/socket.c:730 (discriminator 1) net/socket.c:745 (discriminator 1) net/socket.c:2210 (discriminator 1))
[   70.724561] ? __sys_setsockopt (./include/linux/file.h:34 net/socket.c:2355)
[   70.724561] __x64_sys_sendto (net/socket.c:2222 (discriminator 1) net/socket.c:2218 (discriminator 1) net/socket.c:2218 (discriminator 1))
[   70.724561] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1))
[   70.724561] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   70.724561] RIP: 0033:0x41ae09

Fixes: cf9acc90c80ec ("net: virtio_net_hdr_to_skb: count transport header in UFO")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jonathan Davies <jonathan.davies@nutanix.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jonathan Davies <jonathan.davies@nutanix.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index decfa7cbba50a..877ebaff95586 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3746,7 +3746,7 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
 						sizeof(_tcphdr), &_tcphdr);
 			if (likely(th))
 				hdr_len += __tcp_hdrlen(th);
-		} else {
+		} else if (shinfo->gso_type & SKB_GSO_UDP_L4) {
 			struct udphdr _udphdr;
 
 			if (skb_header_pointer(skb, hdr_len,
-- 
2.43.0




