Return-Path: <stable+bounces-95474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9E59D9072
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 03:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02115287870
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 02:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F3E383A5;
	Tue, 26 Nov 2024 02:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DGBhc2tT"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185978C91
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 02:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732588934; cv=none; b=Cpf3JypycUpr+a3SiiktAC244fWn99XcBilNr55OA2XG+OQXwDwCCJYgLxgAzM0LUt3ICCXO5urezW+FFODUz2ozy6aMkvHLIGPirMUykZqRo6Oc/6lirxaheqrl2FGper8xFwvmTsPbAU4k2RWuIMNy4h8csKxMTwoVYu0P8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732588934; c=relaxed/simple;
	bh=ov6j6a+rpUQkKiwIQkdfg9+KJBNg3PZuS7ehubBfjG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ukZZKykpqivjmnyM8SG1wus+3jVpFtYIxrEgIcAwYSa18Qh/8XGJ3N08pqlYZZAvV/9paSPPKHdlZWVa4hkYLviZFoy9ZC2xhZzIN6L/iCwBQItBhtr5OyQkVsnP/EZ3zpfEkQghzFYWPkmGY64SISooKWKVMZs1EeztvG6GXpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DGBhc2tT; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ACD513F8D9
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 02:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732588929;
	bh=mbL3Bmv9PI/6ncowedJq/PJe4Lh/2HhsYHyOclRLeUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=DGBhc2tTCllwFZgJEy8UVRBTsD/2OkpiHNecXoADdc86+tpj/L1+uz1sA4OtsEa27
	 YCUMHlD3S4CV63fI/sqJKKb6zp43lh1DrOA2EXdrwLC4PYkbL5qG/7ydBcQA7tRnZH
	 lLWSfsy+DYPE9WmXnOceHidDCKwMt1yFNk/6CahNQGQpxhP6udq2r7bZLy44DV3RLY
	 R6YIiA9j5RVH1XZ/SzF1kA5lk8ob/v7vp8EpkZS4zqSPatNAoPBJlSblW9fYhsYUfK
	 wZKMaWa/rk9UnHlbR86f1g1jjiFdBpDW4CC6y06lT+NWngQuaxcjgTr17uQoh1cTKD
	 KbQihioHVTazA==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7ee3c2a2188so4530082a12.3
        for <stable@vger.kernel.org>; Mon, 25 Nov 2024 18:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732588928; x=1733193728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbL3Bmv9PI/6ncowedJq/PJe4Lh/2HhsYHyOclRLeUI=;
        b=fHGcGrI90+GOBLUsYCu3+gbfMAMXQ7CGPMPvtGOJpVghRQX+kz5JcvBK+YA+gdiaJY
         pkyiLR4HeyCXtaGp/JpKpjf4ozxH8gofnMS+9vxmAcd7WHYhsg92phYIG7KKuPuBslwo
         PGqzHKRc4fptaQIzjJq9oeFR+nO24anJRxup9WuqNeHI3lPqUX2XJkNpYyRGikJNfRcG
         iwU1hTRWrlwYGLmM+f3hqlVnFkuuUpPgd83yO8xn2tyzr18UFEr99QNhpY03ThemSKfV
         VK16dP0DMHBM3inwHmvEPPM+/zTrAz88p1JzLvrAHfQp1P2CU+2OxJDp3RV8AUbo+PgL
         kIeg==
X-Forwarded-Encrypted: i=1; AJvYcCWlZ0PJ2vMVt9ogL0H+7HJy3JAGyG7nx5YIT8Fyy+I/k4LHElTEFEKKeNmuzAq2Fl4nWzjiLOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNrNesSokvlScEayICYCmrtkd99g4evwYQaJm5HvK5VGr8lHZY
	EdnuaMLqLh4DhVrzNdOHiGbXV0m9pKWOCrBrWXU7bRsTSp4aqUJ+jsAsboVA8Gk2AgXpzcxG209
	b8dEY+jCWr81p+ZJuTcZAHVS5OfIBVQetG8vb2GG7k3qnZ7txw2knS91y+CGkbkMsb1USig==
X-Gm-Gg: ASbGnctnDDi1hzEkwCYHphb597+aKdzdXJd2yGOo2hOmZr4fV/jvbs4vcMFu+Vj0tOC
	YVdd5o4ajheaxuYVuhLHInSvA6ZSqGzxR6rKWRG56o/5ZKl4FQYc5c1juAhRt5neUpVt2thcoPZ
	5wYIdiLLYsG1Yizd2Cx0enRpTHWCtS3AMBdxxigjARC2esSVZDftSH7Eoqne2x6Ql9yU+qad5kC
	/d3ZtQWGg77H/06HGKlN80yxiXGg2USUzWYp64UDqcICRV9MBs=
X-Received: by 2002:a05:6a21:7884:b0:1e0:d105:1f42 with SMTP id adf61e73a8af0-1e0d1052575mr5665343637.15.1732588927477;
        Mon, 25 Nov 2024 18:42:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5I3rXTJWvEsI0HdqPFFX2Kymtbrs6HmfIIbhD1eM0M/3lvN5B1wKlBY+xgWvX/fyfWiM2UA==
X-Received: by 2002:a05:6a21:7884:b0:1e0:d105:1f42 with SMTP id adf61e73a8af0-1e0d1052575mr5665310637.15.1732588927109;
        Mon, 25 Nov 2024 18:42:07 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:d0ce:70aa:e9cc:688d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de48de67sm7238116b3a.81.2024.11.25.18.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 18:42:06 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] virtio_net: drain unconsumed tx completions if any before dql_reset
Date: Tue, 26 Nov 2024 11:42:00 +0900
Message-ID: <20241126024200.2371546-1-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When virtnet_close is followed by virtnet_open, there is a slight chance
that some TX completions remain unconsumed. Those are handled during the
first NAPI poll, but since dql_reset occurs just beforehand, it can lead
to a crash [1].

This issue can be reproduced by running: `while :; do ip l set DEV down;
ip l set DEV up; done` under heavy network TX load from inside of the
machine.

To fix this, drain unconsumed TX completions if any before dql_reset,
allowing BQL to start cleanly.

------------[ cut here ]------------
kernel BUG at lib/dynamic_queue_limits.c:99!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 7 UID: 0 PID: 1598 Comm: ip Tainted: G    N 6.12.0net-next_main+ #2
Tainted: [N]=TEST
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), \
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:dql_completed+0x26b/0x290
Code: b7 c2 49 89 e9 44 89 da 89 c6 4c 89 d7 e8 ed 17 47 00 58 65 ff 0d
4d 27 90 7e 0f 85 fd fe ff ff e8 ea 53 8d ff e9 f3 fe ff ff <0f> 0b 01
d2 44 89 d1 29 d1 ba 00 00 00 00 0f 48 ca e9 28 ff ff ff
RSP: 0018:ffffc900002b0d08 EFLAGS: 00010297
RAX: 0000000000000000 RBX: ffff888102398c80 RCX: 0000000080190009
RDX: 0000000000000000 RSI: 000000000000006a RDI: 0000000000000000
RBP: ffff888102398c00 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000000ca R11: 0000000000015681 R12: 0000000000000001
R13: ffffc900002b0d68 R14: ffff88811115e000 R15: ffff8881107aca40
FS:  00007f41ded69500(0000) GS:ffff888667dc0000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556ccc2dc1a0 CR3: 0000000104fd8003 CR4: 0000000000772ef0
PKRU: 55555554
Call Trace:
 <IRQ>
 ? die+0x32/0x80
 ? do_trap+0xd9/0x100
 ? dql_completed+0x26b/0x290
 ? dql_completed+0x26b/0x290
 ? do_error_trap+0x6d/0xb0
 ? dql_completed+0x26b/0x290
 ? exc_invalid_op+0x4c/0x60
 ? dql_completed+0x26b/0x290
 ? asm_exc_invalid_op+0x16/0x20
 ? dql_completed+0x26b/0x290
 __free_old_xmit+0xff/0x170 [virtio_net]
 free_old_xmit+0x54/0xc0 [virtio_net]
 virtnet_poll+0xf4/0xe30 [virtio_net]
 ? __update_load_avg_cfs_rq+0x264/0x2d0
 ? update_curr+0x35/0x260
 ? reweight_entity+0x1be/0x260
 __napi_poll.constprop.0+0x28/0x1c0
 net_rx_action+0x329/0x420
 ? enqueue_hrtimer+0x35/0x90
 ? trace_hardirqs_on+0x1d/0x80
 ? kvm_sched_clock_read+0xd/0x20
 ? sched_clock+0xc/0x30
 ? kvm_sched_clock_read+0xd/0x20
 ? sched_clock+0xc/0x30
 ? sched_clock_cpu+0xd/0x1a0
 handle_softirqs+0x138/0x3e0
 do_softirq.part.0+0x89/0xc0
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xa7/0xb0
 virtnet_open+0xc8/0x310 [virtio_net]
 __dev_open+0xfa/0x1b0
 __dev_change_flags+0x1de/0x250
 dev_change_flags+0x22/0x60
 do_setlink.isra.0+0x2df/0x10b0
 ? rtnetlink_rcv_msg+0x34f/0x3f0
 ? netlink_rcv_skb+0x54/0x100
 ? netlink_unicast+0x23e/0x390
 ? netlink_sendmsg+0x21e/0x490
 ? ____sys_sendmsg+0x31b/0x350
 ? avc_has_perm_noaudit+0x67/0xf0
 ? cred_has_capability.isra.0+0x75/0x110
 ? __nla_validate_parse+0x5f/0xee0
 ? __pfx___probestub_irq_enable+0x3/0x10
 ? __create_object+0x5e/0x90
 ? security_capable+0x3b/0x70
 rtnl_newlink+0x784/0xaf0
 ? avc_has_perm_noaudit+0x67/0xf0
 ? cred_has_capability.isra.0+0x75/0x110
 ? stack_depot_save_flags+0x24/0x6d0
 ? __pfx_rtnl_newlink+0x10/0x10
 rtnetlink_rcv_msg+0x34f/0x3f0
 ? do_syscall_64+0x6c/0x180
 ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
 ? __pfx_rtnetlink_rcv_msg+0x10/0x10
 netlink_rcv_skb+0x54/0x100
 netlink_unicast+0x23e/0x390
 netlink_sendmsg+0x21e/0x490
 ____sys_sendmsg+0x31b/0x350
 ? copy_msghdr_from_user+0x6d/0xa0
 ___sys_sendmsg+0x86/0xd0
 ? __pte_offset_map+0x17/0x160
 ? preempt_count_add+0x69/0xa0
 ? __call_rcu_common.constprop.0+0x147/0x610
 ? preempt_count_add+0x69/0xa0
 ? preempt_count_add+0x69/0xa0
 ? _raw_spin_trylock+0x13/0x60
 ? trace_hardirqs_on+0x1d/0x80
 __sys_sendmsg+0x66/0xc0
 do_syscall_64+0x6c/0x180
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f41defe5b34
Code: 15 e1 12 0f 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00
f3 0f 1e fa 80 3d 35 95 0f 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00
f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
RSP: 002b:00007ffe5336ecc8 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f41defe5b34
RDX: 0000000000000000 RSI: 00007ffe5336ed30 RDI: 0000000000000003
RBP: 00007ffe5336eda0 R08: 0000000000000010 R09: 0000000000000001
R10: 00007ffe5336f6f9 R11: 0000000000000202 R12: 0000000000000003
R13: 0000000067452259 R14: 0000556ccc28b040 R15: 0000000000000000
 </TASK>
[...]
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 64c87bb48a41..3e36c0470600 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -513,7 +513,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
 					       struct sk_buff *curr_skb,
 					       struct page *page, void *buf,
 					       int len, int truesize);
-static void virtnet_xsk_completed(struct send_queue *sq, int num);
+static void virtnet_xsk_completed(struct send_queue *sq, int num, bool drain);
 
 enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
@@ -580,7 +580,8 @@ static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len)
 }
 
 static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
-			    bool in_napi, struct virtnet_sq_free_stats *stats)
+			    bool in_napi, struct virtnet_sq_free_stats *stats,
+			    bool drain)
 {
 	struct xdp_frame *frame;
 	struct sk_buff *skb;
@@ -620,7 +621,8 @@ static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
 			break;
 		}
 	}
-	netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);
+	if (!drain)
+		netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);
 }
 
 static void virtnet_free_old_xmit(struct send_queue *sq,
@@ -628,10 +630,21 @@ static void virtnet_free_old_xmit(struct send_queue *sq,
 				  bool in_napi,
 				  struct virtnet_sq_free_stats *stats)
 {
-	__free_old_xmit(sq, txq, in_napi, stats);
+	__free_old_xmit(sq, txq, in_napi, stats, false);
 
 	if (stats->xsk)
-		virtnet_xsk_completed(sq, stats->xsk);
+		virtnet_xsk_completed(sq, stats->xsk, false);
+}
+
+static void virtnet_drain_old_xmit(struct send_queue *sq,
+				   struct netdev_queue *txq)
+{
+	struct virtnet_sq_free_stats stats = {0};
+
+	__free_old_xmit(sq, txq, false, &stats, true);
+
+	if (stats.xsk)
+		virtnet_xsk_completed(sq, stats.xsk, true);
 }
 
 /* Converting between virtqueue no. and kernel tx/rx queue no.
@@ -1499,7 +1512,8 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	/* Avoid to wakeup napi meanless, so call __free_old_xmit instead of
 	 * free_old_xmit().
 	 */
-	__free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq), true, &stats);
+	__free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq), true,
+			&stats, false);
 
 	if (stats.xsk)
 		xsk_tx_completed(sq->xsk_pool, stats.xsk);
@@ -1556,10 +1570,13 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 	return 0;
 }
 
-static void virtnet_xsk_completed(struct send_queue *sq, int num)
+static void virtnet_xsk_completed(struct send_queue *sq, int num, bool drain)
 {
 	xsk_tx_completed(sq->xsk_pool, num);
 
+	if (drain)
+		return;
+
 	/* If this is called by rx poll, start_xmit and xdp xmit we should
 	 * wakeup the tx napi to consume the xsk tx queue, because the tx
 	 * interrupt may not be triggered.
@@ -3041,6 +3058,7 @@ static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
 
 static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 {
+	struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, qp_index);
 	struct net_device *dev = vi->dev;
 	int err;
 
@@ -3054,7 +3072,10 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
-	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
+	/* Drain any unconsumed TX skbs transmitted before the last virtnet_close */
+	virtnet_drain_old_xmit(&vi->sq[qp_index], txq);
+
+	netdev_tx_reset_queue(txq);
 	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
 	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
 
-- 
2.43.0


