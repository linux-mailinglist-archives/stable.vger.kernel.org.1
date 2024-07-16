Return-Path: <stable+bounces-60264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F19932E1F
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE431F218C2
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A6319B59C;
	Tue, 16 Jul 2024 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ecSBKapz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CBA1DDCE;
	Tue, 16 Jul 2024 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146375; cv=none; b=V2diMjcqhKxFxYwSENSN4jx86jRGohwkclvSnMRiQmP2n6JRbUbbq8mTR5m+w7g01GLv3/fchIrmDjQfAZ/p7Hstjz0tazgwCBVMu3rHDp+tgaa31qriv4znhSd3KkShgP+3ptpMKGdaZnyBZUnWXzfd6uIxTpuwdcDu0Ie1bHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146375; c=relaxed/simple;
	bh=n/kIe0etPFvgLe+rZ+XOTDfcT/u41g6+24aLZm87xk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvcW9ZO3vAYD012RlWhabjtIpQvD9n6fSTaJTPYC8NyP1NKHszHtzjNyvLmic/GQi0PiUwwcbbpDXODN3PAOV8CABw+00pu6YTy42RuHjlYEpsNUqKwl0vRziploWEL25qdQ6dXCrbx21eFFcpVvBxIh5p9XOoUkckLKkG71ofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ecSBKapz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E413C116B1;
	Tue, 16 Jul 2024 16:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721146375;
	bh=n/kIe0etPFvgLe+rZ+XOTDfcT/u41g6+24aLZm87xk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ecSBKapze/6SdmGno8KoNak02xHF2Tq9PZkGpa0zMwPjhVXwAxK+mizKEk4jPbLWZ
	 k8QR1bWzYVQDJoEq7RT4ZuTDxF8+2WL6D4R6ToAvOx93spVNmvEgxcB9WVnnEU5wRE
	 XE/FBaxE4zsZSAB4qHawfoTtqcLAXbjo6OQtZKC0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 128/144] wireguard: send: annotate intentional data race in checking empty queue
Date: Tue, 16 Jul 2024 17:33:17 +0200
Message-ID: <20240716152757.437604805@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152752.524497140@linuxfoundation.org>
References: <20240716152752.524497140@linuxfoundation.org>
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



