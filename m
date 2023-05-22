Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B822670C6D5
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbjEVTXJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjEVTXD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:23:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B376DDC
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:22:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 338DC62858
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6A2C433EF;
        Mon, 22 May 2023 19:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783373;
        bh=CMJLFJuC3oN0rnxaiKW/UctQ/fuxUxqLIodqINICGlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EOyFYIXkTqZAq0H+WBlPuhLdgxHc9LXsXriwfG+3QbjVebK2Cve8ucgN0GXsfFWl6
         n7uZQ//+GbnOi/T4C4xTNqVgxn6UIKy4jokgix/E/nPfvbB/TytmvtMGMAEW48gMKJ
         djd8Jps4gIYBA8rT913ET6+yqM+yLQVZERWD927o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 004/292] net: skb_partial_csum_set() fix against transport header magic value
Date:   Mon, 22 May 2023 20:06:01 +0100
Message-Id: <20230522190405.996013577@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 424f8416bb39936df6365442d651ee729b283460 ]

skb->transport_header uses the special 0xFFFF value
to mark if the transport header was set or not.

We must prevent callers to accidentaly set skb->transport_header
to 0xFFFF. Note that only fuzzers can possibly do this today.

syzbot reported:

WARNING: CPU: 0 PID: 2340 at include/linux/skbuff.h:2847 skb_transport_offset include/linux/skbuff.h:2956 [inline]
WARNING: CPU: 0 PID: 2340 at include/linux/skbuff.h:2847 virtio_net_hdr_to_skb+0xbcc/0x10c0 include/linux/virtio_net.h:103
Modules linked in:
CPU: 0 PID: 2340 Comm: syz-executor.0 Not tainted 6.3.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:skb_transport_header include/linux/skbuff.h:2847 [inline]
RIP: 0010:skb_transport_offset include/linux/skbuff.h:2956 [inline]
RIP: 0010:virtio_net_hdr_to_skb+0xbcc/0x10c0 include/linux/virtio_net.h:103
Code: 41 39 df 0f 82 c3 04 00 00 48 8b 7c 24 10 44 89 e6 e8 08 6e 59 ff 48 85 c0 74 54 e8 ce 36 7e fc e9 37 f8 ff ff e8 c4 36 7e fc <0f> 0b e9 93 f8 ff ff 44 89 f7 44 89 e6 e8 32 38 7e fc 45 39 e6 0f
RSP: 0018:ffffc90004497880 EFLAGS: 00010293
RAX: ffffffff84fea55c RBX: 000000000000ffff RCX: ffff888120be2100
RDX: 0000000000000000 RSI: 000000000000ffff RDI: 000000000000ffff
RBP: ffffc90004497990 R08: ffffffff84fe9de5 R09: 0000000000000034
R10: ffffea00048ebd80 R11: 0000000000000034 R12: ffff88811dc2d9c8
R13: dffffc0000000000 R14: ffff88811dc2d9ae R15: 1ffff11023b85b35
FS: 00007f9211a59700(0000) GS:ffff8881f6c00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200002c0 CR3: 00000001215a5000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
packet_snd net/packet/af_packet.c:3076 [inline]
packet_sendmsg+0x4590/0x61a0 net/packet/af_packet.c:3115
sock_sendmsg_nosec net/socket.c:724 [inline]
sock_sendmsg net/socket.c:747 [inline]
__sys_sendto+0x472/0x630 net/socket.c:2144
__do_sys_sendto net/socket.c:2156 [inline]
__se_sys_sendto net/socket.c:2152 [inline]
__x64_sys_sendto+0xe5/0x100 net/socket.c:2152
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x2f/0x50 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9210c8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9211a59168 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f9210dabf80 RCX: 00007f9210c8c169
RDX: 000000000000ffed RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007f9210ce7ca1 R08: 0000000020000540 R09: 0000000000000014
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe135d65cf R14: 00007f9211a59300 R15: 0000000000022000

Fixes: 66e4c8d95008 ("net: warn if transport header was not set")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Willem de Bruijn <willemb@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skbuff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ccfd9053754a9..47660002cadaf 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5053,7 +5053,7 @@ bool skb_partial_csum_set(struct sk_buff *skb, u16 start, u16 off)
 	u32 csum_end = (u32)start + (u32)off + sizeof(__sum16);
 	u32 csum_start = skb_headroom(skb) + (u32)start;
 
-	if (unlikely(csum_start > U16_MAX || csum_end > skb_headlen(skb))) {
+	if (unlikely(csum_start >= U16_MAX || csum_end > skb_headlen(skb))) {
 		net_warn_ratelimited("bad partial csum: csum=%u/%u headroom=%u headlen=%u\n",
 				     start, off, skb_headroom(skb), skb_headlen(skb));
 		return false;
@@ -5061,7 +5061,7 @@ bool skb_partial_csum_set(struct sk_buff *skb, u16 start, u16 off)
 	skb->ip_summed = CHECKSUM_PARTIAL;
 	skb->csum_start = csum_start;
 	skb->csum_offset = off;
-	skb_set_transport_header(skb, start);
+	skb->transport_header = csum_start;
 	return true;
 }
 EXPORT_SYMBOL_GPL(skb_partial_csum_set);
-- 
2.39.2



