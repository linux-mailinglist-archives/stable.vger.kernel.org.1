Return-Path: <stable+bounces-77725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C03598668C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 20:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007A01F24BCF
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 18:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66276127E01;
	Wed, 25 Sep 2024 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="ltWCszGJ"
X-Original-To: stable@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05731D5ADC;
	Wed, 25 Sep 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727290345; cv=none; b=riAl8Os3PdLxIBYMFBcGIyYFtr+Eoy1S0OPe1SmcawUFM++tGToZ9Cmzs4HHiCpk7nFmF/dKvGTH4UTJUQSY32ckgxPmJEXlODCRHHt9V3pIWGkigx7CUcMwelyhXGOYSgS3PQJWDHPqyJBkCg0W8M6HD5yhjsI/pPbPE+jYRBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727290345; c=relaxed/simple;
	bh=nG5opVv7ZDVyKdL5pMZWoYGAOsg3kaxOzrAySOKYDAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TzBEMVw15VnkkIZNpgMgwVo52JTQVqSZzF6G+FNFlbHWBif+Xc4TkvAde5JL8hxqFrJGtooAil1JeVCaVspF3P1gNb51TrBcvBZJYSdPVXYTdN81x03OeWuDxvvgh7NYQOUmm0jCIaoBijfbrbBs6x7M7bF1vo9wHQAKMGtjfIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=ltWCszGJ; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E9AB7C0006D;
	Wed, 25 Sep 2024 18:52:20 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 5BEBE13C2B0;
	Wed, 25 Sep 2024 11:52:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5BEBE13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1727290340;
	bh=nG5opVv7ZDVyKdL5pMZWoYGAOsg3kaxOzrAySOKYDAw=;
	h=From:To:Cc:Subject:Date:From;
	b=ltWCszGJ7kFRBijocMhPGPsR3b+TyV/ym1Fqh3+aTZmvw/f2qywF+VvNPXvyekj3d
	 Li1BR87BgjIv9GdgIbZLiwAtkUNviWZP/YIJwy9BZ3pY9s0ANHx46tRmC0h+cpPQ4j
	 f7dac8UkQ874FDcmGneBV7lRoAs6EByut/2rj774=
From: greearb@candelatech.com
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2] Revert "vrf: Remove unnecessary RCU-bh critical section"
Date: Wed, 25 Sep 2024 11:52:16 -0700
Message-ID: <20240925185216.1990381-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1727290341-F5v1dfTop0YS
X-MDID-O:
 us5;ut7;1727290341;F5v1dfTop0YS;<greearb@candelatech.com>;d8e40e63ee4d65c981bd03b298aac33b

From: Ben Greear <greearb@candelatech.com>

This reverts commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853.

dev_queue_xmit_nit needs to run with bh locking, otherwise
it conflicts with packets coming in from a nic in softirq
context and packets being transmitted from user context.

================================
WARNING: inconsistent lock state
6.11.0 #1 Tainted: G        W
--------------------------------
inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
btserver/134819 [HC0[0]:SC0[0]:HE1:SE1] takes:
ffff8882da30c118 (rlock-AF_PACKET){+.?.}-{2:2}, at: tpacket_rcv+0x863/0x3b30
{IN-SOFTIRQ-W} state was registered at:
  lock_acquire+0x19a/0x4f0
  _raw_spin_lock+0x27/0x40
  packet_rcv+0xa33/0x1320
  __netif_receive_skb_core.constprop.0+0xcb0/0x3a90
  __netif_receive_skb_list_core+0x2c9/0x890
  netif_receive_skb_list_internal+0x610/0xcc0
  napi_complete_done+0x1c0/0x7c0
  igb_poll+0x1dbb/0x57e0 [igb]
  __napi_poll.constprop.0+0x99/0x430
  net_rx_action+0x8e7/0xe10
  handle_softirqs+0x1b7/0x800
  __irq_exit_rcu+0x91/0xc0
  irq_exit_rcu+0x5/0x10
  [snip]

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(rlock-AF_PACKET);
  <Interrupt>
    lock(rlock-AF_PACKET);

 *** DEADLOCK ***

Call Trace:
 <TASK>
 dump_stack_lvl+0x73/0xa0
 mark_lock+0x102e/0x16b0
 __lock_acquire+0x9ae/0x6170
 lock_acquire+0x19a/0x4f0
 _raw_spin_lock+0x27/0x40
 tpacket_rcv+0x863/0x3b30
 dev_queue_xmit_nit+0x709/0xa40
 vrf_finish_direct+0x26e/0x340 [vrf]
 vrf_l3_out+0x5f4/0xe80 [vrf]
 __ip_local_out+0x51e/0x7a0
[snip]

Fixes: 504fc6f4f7f6 ("vrf: Remove unnecessary RCU-bh critical section")
Link: https://lore.kernel.org/netdev/05765015-f727-2f30-58da-2ad6fa7ea99f@candelatech.com/T/

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v2:  Edit patch description.

 drivers/net/vrf.c | 2 ++
 net/core/dev.c    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 4d8ccaf9a2b4..4087f72f0d2b 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -608,7 +608,9 @@ static void vrf_finish_direct(struct sk_buff *skb)
 		eth_zero_addr(eth->h_dest);
 		eth->h_proto = skb->protocol;
 
+		rcu_read_lock_bh();
 		dev_queue_xmit_nit(skb, vrf_dev);
+		rcu_read_unlock_bh();
 
 		skb_pull(skb, ETH_HLEN);
 	}
diff --git a/net/core/dev.c b/net/core/dev.c
index cd479f5f22f6..566e69a38eed 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2285,6 +2285,7 @@ EXPORT_SYMBOL_GPL(dev_nit_active);
 /*
  *	Support routine. Sends outgoing frames to any network
  *	taps currently in use.
+ *	BH must be disabled before calling this.
  */
 
 void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
-- 
2.42.0


