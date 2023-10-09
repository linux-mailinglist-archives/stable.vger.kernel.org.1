Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3447BE004
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377208AbjJINgr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377210AbjJINgq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:36:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454E3ED
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:36:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F8FC433C8;
        Mon,  9 Oct 2023 13:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858601;
        bh=bbQ/wO90+Vl/snSRbrqRiJ31qxAmwIoceV5oCJsH2Qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b/KUhtAbwazGjkWTqRvezXmw/PPmddl8tQNwraPZkDH8pu7wPfZU5LZdivB5Qbzjp
         wUce01hQV5xGRpx/gB3KzCQ7IEtzDNyN+oyO3A36kLy64xzMzVAISgnWp5o/ro+UZ5
         p67chMZ1tG8UbaImcGOr0tMSeCG1QbqZ1l1mub7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 042/226] dccp: fix dccp_v4_err()/dccp_v6_err() again
Date:   Mon,  9 Oct 2023 15:00:03 +0200
Message-ID: <20231009130127.897780421@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

[ Upstream commit 6af289746a636f71f4c0535a9801774118486c7a ]

dh->dccph_x is the 9th byte (offset 8) in "struct dccp_hdr",
not in the "byte 7" as Jann claimed.

We need to make sure the ICMP messages are big enough,
using more standard ways (no more assumptions).

syzbot reported:
BUG: KMSAN: uninit-value in pskb_may_pull_reason include/linux/skbuff.h:2667 [inline]
BUG: KMSAN: uninit-value in pskb_may_pull include/linux/skbuff.h:2681 [inline]
BUG: KMSAN: uninit-value in dccp_v6_err+0x426/0x1aa0 net/dccp/ipv6.c:94
pskb_may_pull_reason include/linux/skbuff.h:2667 [inline]
pskb_may_pull include/linux/skbuff.h:2681 [inline]
dccp_v6_err+0x426/0x1aa0 net/dccp/ipv6.c:94
icmpv6_notify+0x4c7/0x880 net/ipv6/icmp.c:867
icmpv6_rcv+0x19d5/0x30d0
ip6_protocol_deliver_rcu+0xda6/0x2a60 net/ipv6/ip6_input.c:438
ip6_input_finish net/ipv6/ip6_input.c:483 [inline]
NF_HOOK include/linux/netfilter.h:304 [inline]
ip6_input+0x15d/0x430 net/ipv6/ip6_input.c:492
ip6_mc_input+0xa7e/0xc80 net/ipv6/ip6_input.c:586
dst_input include/net/dst.h:468 [inline]
ip6_rcv_finish+0x5db/0x870 net/ipv6/ip6_input.c:79
NF_HOOK include/linux/netfilter.h:304 [inline]
ipv6_rcv+0xda/0x390 net/ipv6/ip6_input.c:310
__netif_receive_skb_one_core net/core/dev.c:5523 [inline]
__netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5637
netif_receive_skb_internal net/core/dev.c:5723 [inline]
netif_receive_skb+0x58/0x660 net/core/dev.c:5782
tun_rx_batched+0x83b/0x920
tun_get_user+0x564c/0x6940 drivers/net/tun.c:2002
tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
call_write_iter include/linux/fs.h:1985 [inline]
new_sync_write fs/read_write.c:491 [inline]
vfs_write+0x8ef/0x15c0 fs/read_write.c:584
ksys_write+0x20f/0x4c0 fs/read_write.c:637
__do_sys_write fs/read_write.c:649 [inline]
__se_sys_write fs/read_write.c:646 [inline]
__x64_sys_write+0x93/0xd0 fs/read_write.c:646
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Uninit was created at:
slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
slab_alloc_node mm/slub.c:3478 [inline]
kmem_cache_alloc_node+0x577/0xa80 mm/slub.c:3523
kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:559
__alloc_skb+0x318/0x740 net/core/skbuff.c:650
alloc_skb include/linux/skbuff.h:1286 [inline]
alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6313
sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2795
tun_alloc_skb drivers/net/tun.c:1531 [inline]
tun_get_user+0x23cf/0x6940 drivers/net/tun.c:1846
tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
call_write_iter include/linux/fs.h:1985 [inline]
new_sync_write fs/read_write.c:491 [inline]
vfs_write+0x8ef/0x15c0 fs/read_write.c:584
ksys_write+0x20f/0x4c0 fs/read_write.c:637
__do_sys_write fs/read_write.c:649 [inline]
__se_sys_write fs/read_write.c:646 [inline]
__x64_sys_write+0x93/0xd0 fs/read_write.c:646
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

CPU: 0 PID: 4995 Comm: syz-executor153 Not tainted 6.6.0-rc1-syzkaller-00014-ga747acc0b752 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023

Fixes: 977ad86c2a1b ("dccp: Fix out of bounds access in DCCP error handler")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jann Horn <jannh@google.com>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/dccp/ipv4.c | 9 ++-------
 net/dccp/ipv6.c | 9 ++-------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 398dc3e47d0c8..f2a0a4e6dd748 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -243,13 +243,8 @@ static int dccp_v4_err(struct sk_buff *skb, u32 info)
 	int err;
 	struct net *net = dev_net(skb->dev);
 
-	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
-	 * which is in byte 7 of the dccp header.
-	 * Our caller (icmp_socket_deliver()) already pulled 8 bytes for us.
-	 *
-	 * Later on, we want to access the sequence number fields, which are
-	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
-	 */
+	if (!pskb_may_pull(skb, offset + sizeof(*dh)))
+		return -EINVAL;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
 		return -EINVAL;
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index bfe11e96af7c9..6d6bbd43a1419 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -76,13 +76,8 @@ static int dccp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	__u64 seq;
 	struct net *net = dev_net(skb->dev);
 
-	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
-	 * which is in byte 7 of the dccp header.
-	 * Our caller (icmpv6_notify()) already pulled 8 bytes for us.
-	 *
-	 * Later on, we want to access the sequence number fields, which are
-	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
-	 */
+	if (!pskb_may_pull(skb, offset + sizeof(*dh)))
+		return -EINVAL;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
 		return -EINVAL;
-- 
2.40.1



