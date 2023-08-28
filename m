Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6622678AC4D
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjH1Kiz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjH1Ki1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:38:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F24B9
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:38:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A58A63F9E
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D826C433C8;
        Mon, 28 Aug 2023 10:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219101;
        bh=7lEjAI5w6yk287++WOYM1+4lyaVovJfT31+yby27oTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQlgzkWTYd7uMmPARnhmAxSeQQQg1IbyxqYRmGUkIyI+Ymp1pBxoWr1nt8WpdCisb
         STXLG2PruNT/wRA8XiSDCR1F1MSkCydFJEvveDRYVbeVnzCgVuuZ9xNp6CrcfKMLtK
         zbjSmNR2q0r5eVh2YIzNyWsZUk5GQw58hlVDV7UA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Xin Long <lucien.xin@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 074/158] net: do not allow gso_size to be set to GSO_BY_FRAGS
Date:   Mon, 28 Aug 2023 12:12:51 +0200
Message-ID: <20230828101159.779148348@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b616be6b97688f2f2bd7c4a47ab32f27f94fb2a9 ]

One missing check in virtio_net_hdr_to_skb() allowed
syzbot to crash kernels again [1]

Do not allow gso_size to be set to GSO_BY_FRAGS (0xffff),
because this magic value is used by the kernel.

[1]
general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
CPU: 0 PID: 5039 Comm: syz-executor401 Not tainted 6.5.0-rc5-next-20230809-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:skb_segment+0x1a52/0x3ef0 net/core/skbuff.c:4500
Code: 00 00 00 e9 ab eb ff ff e8 6b 96 5d f9 48 8b 84 24 00 01 00 00 48 8d 78 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e ea 21 00 00 48 8b 84 24 00 01
RSP: 0018:ffffc90003d3f1c8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 000000000001fffe RCX: 0000000000000000
RDX: 000000000000000e RSI: ffffffff882a3115 RDI: 0000000000000070
RBP: ffffc90003d3f378 R08: 0000000000000005 R09: 000000000000ffff
R10: 000000000000ffff R11: 5ee4a93e456187d6 R12: 000000000001ffc6
R13: dffffc0000000000 R14: 0000000000000008 R15: 000000000000ffff
FS: 00005555563f2380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020020000 CR3: 000000001626d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
udp6_ufo_fragment+0x9d2/0xd50 net/ipv6/udp_offload.c:109
ipv6_gso_segment+0x5c4/0x17b0 net/ipv6/ip6_offload.c:120
skb_mac_gso_segment+0x292/0x610 net/core/gso.c:53
__skb_gso_segment+0x339/0x710 net/core/gso.c:124
skb_gso_segment include/net/gso.h:83 [inline]
validate_xmit_skb+0x3a5/0xf10 net/core/dev.c:3625
__dev_queue_xmit+0x8f0/0x3d60 net/core/dev.c:4329
dev_queue_xmit include/linux/netdevice.h:3082 [inline]
packet_xmit+0x257/0x380 net/packet/af_packet.c:276
packet_snd net/packet/af_packet.c:3087 [inline]
packet_sendmsg+0x24c7/0x5570 net/packet/af_packet.c:3119
sock_sendmsg_nosec net/socket.c:727 [inline]
sock_sendmsg+0xd9/0x180 net/socket.c:750
____sys_sendmsg+0x6ac/0x940 net/socket.c:2496
___sys_sendmsg+0x135/0x1d0 net/socket.c:2550
__sys_sendmsg+0x117/0x1e0 net/socket.c:2579
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff27cdb34d9

Fixes: 3953c46c3ac7 ("sk_buff: allow segmenting based on frag sizes")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Link: https://lore.kernel.org/r/20230816142158.1779798-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/virtio_net.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index a960de68ac69e..6047058d67037 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -148,6 +148,10 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		if (gso_type & SKB_GSO_UDP)
 			nh_off -= thlen;
 
+		/* Kernel has a special handling for GSO_BY_FRAGS. */
+		if (gso_size == GSO_BY_FRAGS)
+			return -EINVAL;
+
 		/* Too small packets are not really GSO ones. */
 		if (skb->len - nh_off > gso_size) {
 			shinfo->gso_size = gso_size;
-- 
2.40.1



