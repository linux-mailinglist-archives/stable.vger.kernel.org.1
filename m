Return-Path: <stable+bounces-76368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 944AD97A16B
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 14:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B7DB2418A
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 12:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD42153573;
	Mon, 16 Sep 2024 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PkLL2U4r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B6F13DB9F;
	Mon, 16 Sep 2024 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488393; cv=none; b=TypSjlVM7cneeFt+HhGoBEswJVDj0/tNyd1uBOKtrwZGQtdaPFF3dK9n2US0zGswcEsqKoZYb4gEUwUvxT752sSsZ2Y51nb1YY4Ru1mYpAk53OFXRYkRmY8Q5IiIu6SuZtlLSoiQ90nYSbzjtb37DB+i6115ATjMNwRIIRKRfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488393; c=relaxed/simple;
	bh=cFMGUYybDizoze6Fkhi70RlfLbhy2fy3uAGRBTkbiCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2L0jofJeXc8d1A5l3rCOvWqewoxJtZzipoi6x+ilfuD/JFaZMf2heiwSNEJdoRyce5jgL3/70DKmjBJrdVngcERym21SBCbAa3Kn5Nbm9B6/AuP90/vSZYn3f79TW/xzeEUGidvZU+yYqAZMbJ14J+Rx9j0xjSNR3ej+J0fU24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PkLL2U4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6919C4CEC4;
	Mon, 16 Sep 2024 12:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726488393;
	bh=cFMGUYybDizoze6Fkhi70RlfLbhy2fy3uAGRBTkbiCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PkLL2U4rAWDdEGmizadfQHCsdjte94OXZk2csHLA8Ln3bFbBUoKt6zip/jknTl7V1
	 MfnUupskArjFwiWpEIUu7pbXm3zraNATlC3lElpdmsqswxXz5P19xAWqj+bcguAwOl
	 73kEre53tEjmV3LS36DpgyPLZ7WIW8ZRqktTlOhE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 070/121] net: hsr: remove seqnr_lock
Date: Mon, 16 Sep 2024 13:44:04 +0200
Message-ID: <20240916114231.491947235@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114228.914815055@linuxfoundation.org>
References: <20240916114228.914815055@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b3c9e65eb227269ed72a115ba22f4f51b4e62b4d ]

syzbot found a new splat [1].

Instead of adding yet another spin_lock_bh(&hsr->seqnr_lock) /
spin_unlock_bh(&hsr->seqnr_lock) pair, remove seqnr_lock
and use atomic_t for hsr->sequence_nr and hsr->sup_sequence_nr.

This also avoid a race in hsr_fill_info().

Also remove interlink_sequence_nr which is unused.

[1]
 WARNING: CPU: 1 PID: 9723 at net/hsr/hsr_forward.c:602 handle_std_frame+0x247/0x2c0 net/hsr/hsr_forward.c:602
Modules linked in:
CPU: 1 UID: 0 PID: 9723 Comm: syz.0.1657 Not tainted 6.11.0-rc6-syzkaller-00026-g88fac17500f4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
 RIP: 0010:handle_std_frame+0x247/0x2c0 net/hsr/hsr_forward.c:602
Code: 49 8d bd b0 01 00 00 be ff ff ff ff e8 e2 58 25 00 31 ff 89 c5 89 c6 e8 47 53 a8 f6 85 ed 0f 85 5a ff ff ff e8 fa 50 a8 f6 90 <0f> 0b 90 e9 4c ff ff ff e8 cc e7 06 f7 e9 8f fe ff ff e8 52 e8 06
RSP: 0018:ffffc90000598598 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffc90000598670 RCX: ffffffff8ae2c919
RDX: ffff888024e94880 RSI: ffffffff8ae2c926 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
R13: ffff8880627a8cc0 R14: 0000000000000000 R15: ffff888012b03c3a
FS:  0000000000000000(0000) GS:ffff88802b700000(0063) knlGS:00000000f5696b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020010000 CR3: 00000000768b4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
  hsr_fill_frame_info+0x2c8/0x360 net/hsr/hsr_forward.c:630
  fill_frame_info net/hsr/hsr_forward.c:700 [inline]
  hsr_forward_skb+0x7df/0x25c0 net/hsr/hsr_forward.c:715
  hsr_handle_frame+0x603/0x850 net/hsr/hsr_slave.c:70
  __netif_receive_skb_core.constprop.0+0xa3d/0x4330 net/core/dev.c:5555
  __netif_receive_skb_list_core+0x357/0x950 net/core/dev.c:5737
  __netif_receive_skb_list net/core/dev.c:5804 [inline]
  netif_receive_skb_list_internal+0x753/0xda0 net/core/dev.c:5896
  gro_normal_list include/net/gro.h:515 [inline]
  gro_normal_list include/net/gro.h:511 [inline]
  napi_complete_done+0x23f/0x9a0 net/core/dev.c:6247
  gro_cell_poll+0x162/0x210 net/core/gro_cells.c:66
  __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6772
  napi_poll net/core/dev.c:6841 [inline]
  net_rx_action+0xa92/0x1010 net/core/dev.c:6963
  handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
  do_softirq kernel/softirq.c:455 [inline]
  do_softirq+0xb2/0xf0 kernel/softirq.c:442
 </IRQ>
 <TASK>

Fixes: 06afd2c31d33 ("hsr: Synchronize sending frames to have always incremented outgoing seq nr.")
Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_device.c  | 35 ++++++++++-------------------------
 net/hsr/hsr_forward.c |  4 +---
 net/hsr/hsr_main.h    |  6 ++----
 net/hsr/hsr_netlink.c |  2 +-
 4 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index e4cc6b78dcfc..ac56784c327c 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -231,9 +231,7 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		skb->dev = master->dev;
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);
-		spin_lock_bh(&hsr->seqnr_lock);
 		hsr_forward_skb(skb, master);
-		spin_unlock_bh(&hsr->seqnr_lock);
 	} else {
 		dev_core_stats_tx_dropped_inc(dev);
 		dev_kfree_skb_any(skb);
@@ -314,14 +312,10 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 	set_hsr_stag_HSR_ver(hsr_stag, hsr->prot_version);
 
 	/* From HSRv1 on we have separate supervision sequence numbers. */
-	spin_lock_bh(&hsr->seqnr_lock);
-	if (hsr->prot_version > 0) {
-		hsr_stag->sequence_nr = htons(hsr->sup_sequence_nr);
-		hsr->sup_sequence_nr++;
-	} else {
-		hsr_stag->sequence_nr = htons(hsr->sequence_nr);
-		hsr->sequence_nr++;
-	}
+	if (hsr->prot_version > 0)
+		hsr_stag->sequence_nr = htons(atomic_inc_return(&hsr->sup_sequence_nr));
+	else
+		hsr_stag->sequence_nr = htons(atomic_inc_return(&hsr->sequence_nr));
 
 	hsr_stag->tlv.HSR_TLV_type = type;
 	/* TODO: Why 12 in HSRv0? */
@@ -343,13 +337,11 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
 		ether_addr_copy(hsr_sp->macaddress_A, hsr->macaddress_redbox);
 	}
 
-	if (skb_put_padto(skb, ETH_ZLEN)) {
-		spin_unlock_bh(&hsr->seqnr_lock);
+	if (skb_put_padto(skb, ETH_ZLEN))
 		return;
-	}
 
 	hsr_forward_skb(skb, port);
-	spin_unlock_bh(&hsr->seqnr_lock);
+
 	return;
 }
 
@@ -374,9 +366,7 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 	set_hsr_stag_HSR_ver(hsr_stag, (hsr->prot_version ? 1 : 0));
 
 	/* From HSRv1 on we have separate supervision sequence numbers. */
-	spin_lock_bh(&hsr->seqnr_lock);
-	hsr_stag->sequence_nr = htons(hsr->sup_sequence_nr);
-	hsr->sup_sequence_nr++;
+	hsr_stag->sequence_nr = htons(atomic_inc_return(&hsr->sup_sequence_nr));
 	hsr_stag->tlv.HSR_TLV_type = PRP_TLV_LIFE_CHECK_DD;
 	hsr_stag->tlv.HSR_TLV_length = sizeof(struct hsr_sup_payload);
 
@@ -384,13 +374,10 @@ static void send_prp_supervision_frame(struct hsr_port *master,
 	hsr_sp = skb_put(skb, sizeof(struct hsr_sup_payload));
 	ether_addr_copy(hsr_sp->macaddress_A, master->dev->dev_addr);
 
-	if (skb_put_padto(skb, ETH_ZLEN)) {
-		spin_unlock_bh(&hsr->seqnr_lock);
+	if (skb_put_padto(skb, ETH_ZLEN))
 		return;
-	}
 
 	hsr_forward_skb(skb, master);
-	spin_unlock_bh(&hsr->seqnr_lock);
 }
 
 /* Announce (supervision frame) timer function
@@ -621,11 +608,9 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 	if (res < 0)
 		return res;
 
-	spin_lock_init(&hsr->seqnr_lock);
 	/* Overflow soon to find bugs easier: */
-	hsr->sequence_nr = HSR_SEQNR_START;
-	hsr->sup_sequence_nr = HSR_SUP_SEQNR_START;
-	hsr->interlink_sequence_nr = HSR_SEQNR_START;
+	atomic_set(&hsr->sequence_nr, HSR_SEQNR_START);
+	atomic_set(&hsr->sup_sequence_nr, HSR_SUP_SEQNR_START);
 
 	timer_setup(&hsr->announce_timer, hsr_announce, 0);
 	timer_setup(&hsr->prune_timer, hsr_prune_nodes, 0);
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 960ef386bc3a..9254037e9436 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -599,9 +599,7 @@ static void handle_std_frame(struct sk_buff *skb,
 	if (port->type == HSR_PT_MASTER ||
 	    port->type == HSR_PT_INTERLINK) {
 		/* Sequence nr for the master/interlink node */
-		lockdep_assert_held(&hsr->seqnr_lock);
-		frame->sequence_nr = hsr->sequence_nr;
-		hsr->sequence_nr++;
+		frame->sequence_nr = atomic_inc_return(&hsr->sequence_nr);
 	}
 }
 
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index ab1f8d35d9dc..6f7bbf01f3e4 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -202,11 +202,9 @@ struct hsr_priv {
 	struct timer_list	prune_timer;
 	struct timer_list	prune_proxy_timer;
 	int announce_count;
-	u16 sequence_nr;
-	u16 interlink_sequence_nr; /* Interlink port seq_nr */
-	u16 sup_sequence_nr;	/* For HSRv1 separate seq_nr for supervision */
+	atomic_t sequence_nr;
+	atomic_t sup_sequence_nr;	/* For HSRv1 separate seq_nr for supervision */
 	enum hsr_version prot_version;	/* Indicate if HSRv0, HSRv1 or PRPv1 */
-	spinlock_t seqnr_lock;	/* locking for sequence_nr */
 	spinlock_t list_lock;	/* locking for node list */
 	struct hsr_proto_ops	*proto_ops;
 #define PRP_LAN_ID	0x5     /* 0x1010 for A and 0x1011 for B. Bit 0 is set
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index f6ff0b61e08a..8aea4ff5f49e 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -163,7 +163,7 @@ static int hsr_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	if (nla_put(skb, IFLA_HSR_SUPERVISION_ADDR, ETH_ALEN,
 		    hsr->sup_multicast_addr) ||
-	    nla_put_u16(skb, IFLA_HSR_SEQ_NR, hsr->sequence_nr))
+	    nla_put_u16(skb, IFLA_HSR_SEQ_NR, atomic_read(&hsr->sequence_nr)))
 		goto nla_put_failure;
 	if (hsr->prot_version == PRP_V1)
 		proto = HSR_PROTOCOL_PRP;
-- 
2.43.0




