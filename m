Return-Path: <stable+bounces-58078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6144927A6A
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 17:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62374B26385
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4F61B1401;
	Thu,  4 Jul 2024 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e9WtA3S/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459221BC23;
	Thu,  4 Jul 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107947; cv=none; b=Wwr5nhyVGtk9lEHVvYt9NonbtHogJ6h7hf6Omg25qooSamlw3ECR20WsJ4F5PQy5sQLN9EdOAMoKZ1KlvpxDk+kU7ZZLcLum3I8lWauLRlTGKlDP0BNZE5fGnuc6NhduhH2+tze346CKortsXl8ll7x1zicNobmvk7a1MZw7+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107947; c=relaxed/simple;
	bh=N5AkLMKAj0SpjYMWLW+TY358kBxOwj9aAQ2DTIVzOWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBehUHK8UPE0gvixkErmJviFnPtnLYV1aLGFS876OPyxIgU/OYV8+Yo/sdhgEdC21ZdUfYlIyG/ZHHJSQpYeu3iga31PfIAUaNMMRh/CYcCdcAzt1GSHyNKkR4hu9GKt9gBGN8n+T7eePbXlgdR5DvNoR88nUuQBOnoj+m5hnL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=e9WtA3S/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA14C4AF0C;
	Thu,  4 Jul 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e9WtA3S/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720107945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2UjGiL+UGoWpQUK5mIzDE+VPqWH2b/EH1cM5yf2OCQ=;
	b=e9WtA3S/rQ0zTi+DCGL23euj1kVtBz5jB5pAw9P/DM8pfR6t39hkw4kSM3RRAX3qYKrQQY
	GP0Y+S7Fj1P6hxKdBlfu6mPlFaPYDo4B+u2dPVvAOf0F3iygVB94evjyBxSAYPNKq0nfuL
	KxdWJEEaVdz38oFBsgUUIJpQI4Gu/5M=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d2486546 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jul 2024 15:45:45 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	stable@vger.kernel.org
Subject: [PATCH net 4/4] wireguard: send: annotate intentional data race in checking empty queue
Date: Thu,  4 Jul 2024 17:45:17 +0200
Message-ID: <20240704154517.1572127-5-Jason@zx2c4.com>
In-Reply-To: <20240704154517.1572127-1-Jason@zx2c4.com>
References: <20240704154517.1572127-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCSAN reports a race in wg_packet_send_keepalive, which is intentional:

    BUG: KCSAN: data-race in wg_packet_send_keepalive / wg_packet_send_staged_packets

    write to 0xffff88814cd91280 of 8 bytes by task 3194 on cpu 0:
     __skb_queue_head_init include/linux/skbuff.h:2162 [inline]
     skb_queue_splice_init include/linux/skbuff.h:2248 [inline]
     wg_packet_send_staged_packets+0xe5/0xad0 drivers/net/wireguard/send.c:351
     wg_xmit+0x5b8/0x660 drivers/net/wireguard/device.c:218
     __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
     netdev_start_xmit include/linux/netdevice.h:4954 [inline]
     xmit_one net/core/dev.c:3548 [inline]
     dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3564
     __dev_queue_xmit+0xeff/0x1d80 net/core/dev.c:4349
     dev_queue_xmit include/linux/netdevice.h:3134 [inline]
     neigh_connected_output+0x231/0x2a0 net/core/neighbour.c:1592
     neigh_output include/net/neighbour.h:542 [inline]
     ip6_finish_output2+0xa66/0xce0 net/ipv6/ip6_output.c:137
     ip6_finish_output+0x1a5/0x490 net/ipv6/ip6_output.c:222
     NF_HOOK_COND include/linux/netfilter.h:303 [inline]
     ip6_output+0xeb/0x220 net/ipv6/ip6_output.c:243
     dst_output include/net/dst.h:451 [inline]
     NF_HOOK include/linux/netfilter.h:314 [inline]
     ndisc_send_skb+0x4a2/0x670 net/ipv6/ndisc.c:509
     ndisc_send_rs+0x3ab/0x3e0 net/ipv6/ndisc.c:719
     addrconf_dad_completed+0x640/0x8e0 net/ipv6/addrconf.c:4295
     addrconf_dad_work+0x891/0xbc0
     process_one_work kernel/workqueue.c:2633 [inline]
     process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2706
     worker_thread+0x525/0x730 kernel/workqueue.c:2787
     kthread+0x1d7/0x210 kernel/kthread.c:388
     ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
     ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

    read to 0xffff88814cd91280 of 8 bytes by task 3202 on cpu 1:
     skb_queue_empty include/linux/skbuff.h:1798 [inline]
     wg_packet_send_keepalive+0x20/0x100 drivers/net/wireguard/send.c:225
     wg_receive_handshake_packet drivers/net/wireguard/receive.c:186 [inline]
     wg_packet_handshake_receive_worker+0x445/0x5e0 drivers/net/wireguard/receive.c:213
     process_one_work kernel/workqueue.c:2633 [inline]
     process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2706
     worker_thread+0x525/0x730 kernel/workqueue.c:2787
     kthread+0x1d7/0x210 kernel/kthread.c:388
     ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
     ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

    value changed: 0xffff888148fef200 -> 0xffff88814cd91280

Mark this race as intentional by using the skb_queue_empty_lockless()
function rather than skb_queue_empty(), which uses READ_ONCE()
internally to annotate the race.

Cc: stable@vger.kernel.org
Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireguard/send.c b/drivers/net/wireguard/send.c
index 0d48e0f4a1ba..26e09c30d596 100644
--- a/drivers/net/wireguard/send.c
+++ b/drivers/net/wireguard/send.c
@@ -222,7 +222,7 @@ void wg_packet_send_keepalive(struct wg_peer *peer)
 {
 	struct sk_buff *skb;
 
-	if (skb_queue_empty(&peer->staged_packet_queue)) {
+	if (skb_queue_empty_lockless(&peer->staged_packet_queue)) {
 		skb = alloc_skb(DATA_PACKET_HEAD_ROOM + MESSAGE_MINIMUM_LENGTH,
 				GFP_ATOMIC);
 		if (unlikely(!skb))
-- 
2.45.2


