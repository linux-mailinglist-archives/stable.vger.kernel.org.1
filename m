Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6477D354C
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjJWLrF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjJWLqz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:46:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA8410D7
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:46:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7373C433C7;
        Mon, 23 Oct 2023 11:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061613;
        bh=UyYJRIaf/479rXWd3OscNRnQBAuD71gFWBuD2OxOpEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUF5eEI6oLjDbaELpFf5mNYLtuLbq2w2EEOZoSDMvH0ZUSJRx7/qo/4U/kcrbe75d
         OiEdZy2YtPwT9saYZadzu+AZCdQOkM59ATmOkQBbxhARdAJob//Y15AmYAwQAc8UJn
         MMP0V1I34Yy96CEF+uzsk1OX4zeWa5f4hY4MgP5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 5.10 106/202] xfrm: interface: use DEV_STATS_INC()
Date:   Mon, 23 Oct 2023 12:56:53 +0200
Message-ID: <20231023104829.634809538@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit f7c4e3e5d4f6609b4725a97451948ca2e425379a upstream.

syzbot/KCSAN reported data-races in xfrm whenever dev->stats fields
are updated.

It appears all of these updates can happen from multiple cpus.

Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.

BUG: KCSAN: data-race in xfrmi_xmit / xfrmi_xmit

read-write to 0xffff88813726b160 of 8 bytes by task 23986 on cpu 1:
xfrmi_xmit+0x74e/0xb20 net/xfrm/xfrm_interface_core.c:583
__netdev_start_xmit include/linux/netdevice.h:4889 [inline]
netdev_start_xmit include/linux/netdevice.h:4903 [inline]
xmit_one net/core/dev.c:3544 [inline]
dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3560
__dev_queue_xmit+0xeee/0x1de0 net/core/dev.c:4340
dev_queue_xmit include/linux/netdevice.h:3082 [inline]
neigh_connected_output+0x231/0x2a0 net/core/neighbour.c:1581
neigh_output include/net/neighbour.h:542 [inline]
ip_finish_output2+0x74a/0x850 net/ipv4/ip_output.c:230
ip_finish_output+0xf4/0x240 net/ipv4/ip_output.c:318
NF_HOOK_COND include/linux/netfilter.h:293 [inline]
ip_output+0xe5/0x1b0 net/ipv4/ip_output.c:432
dst_output include/net/dst.h:458 [inline]
ip_local_out net/ipv4/ip_output.c:127 [inline]
ip_send_skb+0x72/0xe0 net/ipv4/ip_output.c:1487
udp_send_skb+0x6a4/0x990 net/ipv4/udp.c:963
udp_sendmsg+0x1249/0x12d0 net/ipv4/udp.c:1246
inet_sendmsg+0x63/0x80 net/ipv4/af_inet.c:840
sock_sendmsg_nosec net/socket.c:730 [inline]
sock_sendmsg net/socket.c:753 [inline]
____sys_sendmsg+0x37c/0x4d0 net/socket.c:2540
___sys_sendmsg net/socket.c:2594 [inline]
__sys_sendmmsg+0x269/0x500 net/socket.c:2680
__do_sys_sendmmsg net/socket.c:2709 [inline]
__se_sys_sendmmsg net/socket.c:2706 [inline]
__x64_sys_sendmmsg+0x57/0x60 net/socket.c:2706
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read-write to 0xffff88813726b160 of 8 bytes by task 23987 on cpu 0:
xfrmi_xmit+0x74e/0xb20 net/xfrm/xfrm_interface_core.c:583
__netdev_start_xmit include/linux/netdevice.h:4889 [inline]
netdev_start_xmit include/linux/netdevice.h:4903 [inline]
xmit_one net/core/dev.c:3544 [inline]
dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3560
__dev_queue_xmit+0xeee/0x1de0 net/core/dev.c:4340
dev_queue_xmit include/linux/netdevice.h:3082 [inline]
neigh_connected_output+0x231/0x2a0 net/core/neighbour.c:1581
neigh_output include/net/neighbour.h:542 [inline]
ip_finish_output2+0x74a/0x850 net/ipv4/ip_output.c:230
ip_finish_output+0xf4/0x240 net/ipv4/ip_output.c:318
NF_HOOK_COND include/linux/netfilter.h:293 [inline]
ip_output+0xe5/0x1b0 net/ipv4/ip_output.c:432
dst_output include/net/dst.h:458 [inline]
ip_local_out net/ipv4/ip_output.c:127 [inline]
ip_send_skb+0x72/0xe0 net/ipv4/ip_output.c:1487
udp_send_skb+0x6a4/0x990 net/ipv4/udp.c:963
udp_sendmsg+0x1249/0x12d0 net/ipv4/udp.c:1246
inet_sendmsg+0x63/0x80 net/ipv4/af_inet.c:840
sock_sendmsg_nosec net/socket.c:730 [inline]
sock_sendmsg net/socket.c:753 [inline]
____sys_sendmsg+0x37c/0x4d0 net/socket.c:2540
___sys_sendmsg net/socket.c:2594 [inline]
__sys_sendmmsg+0x269/0x500 net/socket.c:2680
__do_sys_sendmmsg net/socket.c:2709 [inline]
__se_sys_sendmmsg net/socket.c:2706 [inline]
__x64_sys_sendmmsg+0x57/0x60 net/socket.c:2706
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00000000000010d7 -> 0x00000000000010d8

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 23987 Comm: syz-executor.5 Not tainted 6.5.0-syzkaller-10885-g0468be89b3fa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023

Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_interface_core.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -274,8 +274,8 @@ static int xfrmi_rcv_cb(struct sk_buff *
 	skb->dev = dev;
 
 	if (err) {
-		dev->stats.rx_errors++;
-		dev->stats.rx_dropped++;
+		DEV_STATS_INC(dev, rx_errors);
+		DEV_STATS_INC(dev, rx_dropped);
 
 		return 0;
 	}
@@ -309,7 +309,6 @@ static int
 xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net_device_stats *stats = &xi->dev->stats;
 	struct dst_entry *dst = skb_dst(skb);
 	unsigned int length = skb->len;
 	struct net_device *tdev;
@@ -335,7 +334,7 @@ xfrmi_xmit2(struct sk_buff *skb, struct
 	tdev = dst->dev;
 
 	if (tdev == dev) {
-		stats->collisions++;
+		DEV_STATS_INC(dev, collisions);
 		net_warn_ratelimited("%s: Local routing loop detected!\n",
 				     dev->name);
 		goto tx_err_dst_release;
@@ -378,13 +377,13 @@ xmit:
 		tstats->tx_packets++;
 		u64_stats_update_end(&tstats->syncp);
 	} else {
-		stats->tx_errors++;
-		stats->tx_aborted_errors++;
+		DEV_STATS_INC(dev, tx_errors);
+		DEV_STATS_INC(dev, tx_aborted_errors);
 	}
 
 	return 0;
 tx_err_link_failure:
-	stats->tx_carrier_errors++;
+	DEV_STATS_INC(dev, tx_carrier_errors);
 	dst_link_failure(skb);
 tx_err_dst_release:
 	dst_release(dst);
@@ -394,7 +393,6 @@ tx_err_dst_release:
 static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net_device_stats *stats = &xi->dev->stats;
 	struct dst_entry *dst = skb_dst(skb);
 	struct flowi fl;
 	int ret;
@@ -411,7 +409,7 @@ static netdev_tx_t xfrmi_xmit(struct sk_
 			dst = ip6_route_output(dev_net(dev), NULL, &fl.u.ip6);
 			if (dst->error) {
 				dst_release(dst);
-				stats->tx_carrier_errors++;
+				DEV_STATS_INC(dev, tx_carrier_errors);
 				goto tx_err;
 			}
 			skb_dst_set(skb, dst);
@@ -427,7 +425,7 @@ static netdev_tx_t xfrmi_xmit(struct sk_
 			fl.u.ip4.flowi4_flags |= FLOWI_FLAG_ANYSRC;
 			rt = __ip_route_output_key(dev_net(dev), &fl.u.ip4);
 			if (IS_ERR(rt)) {
-				stats->tx_carrier_errors++;
+				DEV_STATS_INC(dev, tx_carrier_errors);
 				goto tx_err;
 			}
 			skb_dst_set(skb, &rt->dst);
@@ -446,8 +444,8 @@ static netdev_tx_t xfrmi_xmit(struct sk_
 	return NETDEV_TX_OK;
 
 tx_err:
-	stats->tx_errors++;
-	stats->tx_dropped++;
+	DEV_STATS_INC(dev, tx_errors);
+	DEV_STATS_INC(dev, tx_dropped);
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
 }


