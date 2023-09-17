Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDAE7A399B
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbjIQTwA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbjIQTv2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:51:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6B39F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:51:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15C9C433C8;
        Sun, 17 Sep 2023 19:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980282;
        bh=tSzQp5jA4h/Deqdoq9SXcek2W+aBc75MIksXdz1YMYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LkDcgFBG0065ckE40xKFD1kYVI/iWv5b85w5dTRYlhjj6smsAqfcdLKCF/S2zLIoE
         la5fWxfFo6UDnUizM79TgtQvAqJyE2WSbKumoVRwUf/V19cRuwvU/bYkwb1GGVG7iY
         ovJh5TRi9wA1x9w+X9Y/TSEkA3REoewusEQQDvQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 147/285] ip_tunnels: use DEV_STATS_INC()
Date:   Sun, 17 Sep 2023 21:12:27 +0200
Message-ID: <20230917191056.771057919@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 9b271ebaf9a2c5c566a54bc6cd915962e8241130 ]

syzbot/KCSAN reported data-races in iptunnel_xmit_stats() [1]

This can run from multiple cpus without mutual exclusion.

Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.

[1]
BUG: KCSAN: data-race in iptunnel_xmit / iptunnel_xmit

read-write to 0xffff8881353df170 of 8 bytes by task 30263 on cpu 1:
iptunnel_xmit_stats include/net/ip_tunnels.h:493 [inline]
iptunnel_xmit+0x432/0x4a0 net/ipv4/ip_tunnel_core.c:87
ip_tunnel_xmit+0x1477/0x1750 net/ipv4/ip_tunnel.c:831
__gre_xmit net/ipv4/ip_gre.c:469 [inline]
ipgre_xmit+0x516/0x570 net/ipv4/ip_gre.c:662
__netdev_start_xmit include/linux/netdevice.h:4889 [inline]
netdev_start_xmit include/linux/netdevice.h:4903 [inline]
xmit_one net/core/dev.c:3544 [inline]
dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3560
__dev_queue_xmit+0xeee/0x1de0 net/core/dev.c:4340
dev_queue_xmit include/linux/netdevice.h:3082 [inline]
__bpf_tx_skb net/core/filter.c:2129 [inline]
__bpf_redirect_no_mac net/core/filter.c:2159 [inline]
__bpf_redirect+0x723/0x9c0 net/core/filter.c:2182
____bpf_clone_redirect net/core/filter.c:2453 [inline]
bpf_clone_redirect+0x16c/0x1d0 net/core/filter.c:2425
___bpf_prog_run+0xd7d/0x41e0 kernel/bpf/core.c:1954
__bpf_prog_run512+0x74/0xa0 kernel/bpf/core.c:2195
bpf_dispatcher_nop_func include/linux/bpf.h:1181 [inline]
__bpf_prog_run include/linux/filter.h:609 [inline]
bpf_prog_run include/linux/filter.h:616 [inline]
bpf_test_run+0x15d/0x3d0 net/bpf/test_run.c:423
bpf_prog_test_run_skb+0x77b/0xa00 net/bpf/test_run.c:1045
bpf_prog_test_run+0x265/0x3d0 kernel/bpf/syscall.c:3996
__sys_bpf+0x3af/0x780 kernel/bpf/syscall.c:5353
__do_sys_bpf kernel/bpf/syscall.c:5439 [inline]
__se_sys_bpf kernel/bpf/syscall.c:5437 [inline]
__x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5437
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read-write to 0xffff8881353df170 of 8 bytes by task 30249 on cpu 0:
iptunnel_xmit_stats include/net/ip_tunnels.h:493 [inline]
iptunnel_xmit+0x432/0x4a0 net/ipv4/ip_tunnel_core.c:87
ip_tunnel_xmit+0x1477/0x1750 net/ipv4/ip_tunnel.c:831
__gre_xmit net/ipv4/ip_gre.c:469 [inline]
ipgre_xmit+0x516/0x570 net/ipv4/ip_gre.c:662
__netdev_start_xmit include/linux/netdevice.h:4889 [inline]
netdev_start_xmit include/linux/netdevice.h:4903 [inline]
xmit_one net/core/dev.c:3544 [inline]
dev_hard_start_xmit+0x11b/0x3f0 net/core/dev.c:3560
__dev_queue_xmit+0xeee/0x1de0 net/core/dev.c:4340
dev_queue_xmit include/linux/netdevice.h:3082 [inline]
__bpf_tx_skb net/core/filter.c:2129 [inline]
__bpf_redirect_no_mac net/core/filter.c:2159 [inline]
__bpf_redirect+0x723/0x9c0 net/core/filter.c:2182
____bpf_clone_redirect net/core/filter.c:2453 [inline]
bpf_clone_redirect+0x16c/0x1d0 net/core/filter.c:2425
___bpf_prog_run+0xd7d/0x41e0 kernel/bpf/core.c:1954
__bpf_prog_run512+0x74/0xa0 kernel/bpf/core.c:2195
bpf_dispatcher_nop_func include/linux/bpf.h:1181 [inline]
__bpf_prog_run include/linux/filter.h:609 [inline]
bpf_prog_run include/linux/filter.h:616 [inline]
bpf_test_run+0x15d/0x3d0 net/bpf/test_run.c:423
bpf_prog_test_run_skb+0x77b/0xa00 net/bpf/test_run.c:1045
bpf_prog_test_run+0x265/0x3d0 kernel/bpf/syscall.c:3996
__sys_bpf+0x3af/0x780 kernel/bpf/syscall.c:5353
__do_sys_bpf kernel/bpf/syscall.c:5439 [inline]
__se_sys_bpf kernel/bpf/syscall.c:5437 [inline]
__x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5437
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x0000000000018830 -> 0x0000000000018831

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 30249 Comm: syz-executor.4 Not tainted 6.5.0-syzkaller-11704-g3f86ed6ec0b3 #0

Fixes: 039f50629b7f ("ip_tunnel: Move stats update to iptunnel_xmit()")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip_tunnels.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index ed4b6ad3fcac8..cd0e2744f66f3 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -482,15 +482,14 @@ static inline void iptunnel_xmit_stats(struct net_device *dev, int pkt_len)
 		u64_stats_inc(&tstats->tx_packets);
 		u64_stats_update_end(&tstats->syncp);
 		put_cpu_ptr(tstats);
+		return;
+	}
+
+	if (pkt_len < 0) {
+		DEV_STATS_INC(dev, tx_errors);
+		DEV_STATS_INC(dev, tx_aborted_errors);
 	} else {
-		struct net_device_stats *err_stats = &dev->stats;
-
-		if (pkt_len < 0) {
-			err_stats->tx_errors++;
-			err_stats->tx_aborted_errors++;
-		} else {
-			err_stats->tx_dropped++;
-		}
+		DEV_STATS_INC(dev, tx_dropped);
 	}
 }
 
-- 
2.40.1



