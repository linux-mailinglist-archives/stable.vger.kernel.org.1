Return-Path: <stable+bounces-59877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E60932C35
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D96D284EF4
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC72019DF75;
	Tue, 16 Jul 2024 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YkQZHnaM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A90E17C9E9;
	Tue, 16 Jul 2024 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145177; cv=none; b=KbhbUtqiomA+2XbSldE8IsJesZw/Qp0Y7+RxwF0ZzggbL3vi/F2Y2XuB5QA2SWANtD+5dburMgQ7B2RKs07pxI4wgTWoMvBoMyNX5EEfztNj2L3u9Kw7Uq1dd1VIz/RmPMMYlaAN/CqIyZhjMieLii2VrZ4cLcBJ9Sc3SjBdc74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145177; c=relaxed/simple;
	bh=ojsUbNv1HrvKdXYpPstqwgq0Q9H8ms2Yl60FAwK/W+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGtxHiV7mbYPE9wjHsnXkG+HUoRaJbvzxnsab7eC+5qd1BO0BpgKD/nA360I3JSUMKOwHRvENGLjieaXq0hGvG1KDbFLymK7dkJRlVGwFV4iVQk5wM67lK2mDtvBhDwdfarEyWdL3Fw9hU5j75wEpHx55rhMnSKKNR2KP+zfxQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YkQZHnaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD0DC4AF0E;
	Tue, 16 Jul 2024 15:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145177;
	bh=ojsUbNv1HrvKdXYpPstqwgq0Q9H8ms2Yl60FAwK/W+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YkQZHnaMTQnJIwpZxkqu6dk/u6vaugAnOY+QoyTT9yYZbIZCUmq6ZY3IInyqa/r8n
	 /7cZoe1zXNpVRQMG2EzFuQRD6yX0V/VpsF7wrSzNEjtty3dmWdV+UmNDs2Eh/um0Pi
	 A73PJog4S0AmNUpImcZGv/gzohffDiZYKsODJ+Tc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.9 123/143] wireguard: send: annotate intentional data race in checking empty queue
Date: Tue, 16 Jul 2024 17:31:59 +0200
Message-ID: <20240716152800.714415312@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152755.980289992@linuxfoundation.org>
References: <20240716152755.980289992@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 381a7d453fa2ac5f854a154d3c9b1bbb90c4f94f upstream.

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
Link: https://patch.msgid.link/20240704154517.1572127-5-Jason@zx2c4.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireguard/send.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireguard/send.c
+++ b/drivers/net/wireguard/send.c
@@ -222,7 +222,7 @@ void wg_packet_send_keepalive(struct wg_
 {
 	struct sk_buff *skb;
 
-	if (skb_queue_empty(&peer->staged_packet_queue)) {
+	if (skb_queue_empty_lockless(&peer->staged_packet_queue)) {
 		skb = alloc_skb(DATA_PACKET_HEAD_ROOM + MESSAGE_MINIMUM_LENGTH,
 				GFP_ATOMIC);
 		if (unlikely(!skb))



