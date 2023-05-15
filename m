Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92813703AB6
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242574AbjEORyg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242528AbjEORyH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:54:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24543160B6
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:52:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E197262F5C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD649C4339B;
        Mon, 15 May 2023 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173040;
        bh=zkawMgiLWFQZm2zFEqmEjpuwR9XdrAII79rDwM3pPEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2dXaJSlfzx5F4jLQP928hJoaCeLJoSNnw85h94b7lkxNnvKVGCGhZFvMb/VWR2LQe
         fpzaFRApGi9GhDf6+sZH45utMU0PRQnKuUe5Xw/SrgTzHxlXvJWZJPFVjK5D9Nr4iE
         FBTt5kuOr1x/EE8yrOlSdjbHuS3iw5AxsyEK9XuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 321/381] af_packet: Dont send zero-byte data in packet_sendmsg_spkt().
Date:   Mon, 15 May 2023 18:29:32 +0200
Message-Id: <20230515161751.296403411@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 6a341729fb31b4c5df9f74f24b4b1c98410c9b87 ]

syzkaller reported a warning below [0].

We can reproduce it by sending 0-byte data from the (AF_PACKET,
SOCK_PACKET) socket via some devices whose dev->hard_header_len
is 0.

    struct sockaddr_pkt addr = {
        .spkt_family = AF_PACKET,
        .spkt_device = "tun0",
    };
    int fd;

    fd = socket(AF_PACKET, SOCK_PACKET, 0);
    sendto(fd, NULL, 0, 0, (struct sockaddr *)&addr, sizeof(addr));

We have a similar fix for the (AF_PACKET, SOCK_RAW) socket as
commit dc633700f00f ("net/af_packet: check len when min_header_len
equals to 0").

Let's add the same test for the SOCK_PACKET socket.

[0]:
skb_assert_len
WARNING: CPU: 1 PID: 19945 at include/linux/skbuff.h:2552 skb_assert_len include/linux/skbuff.h:2552 [inline]
WARNING: CPU: 1 PID: 19945 at include/linux/skbuff.h:2552 __dev_queue_xmit+0x1f26/0x31d0 net/core/dev.c:4159
Modules linked in:
CPU: 1 PID: 19945 Comm: syz-executor.0 Not tainted 6.3.0-rc7-02330-gca6270c12e20 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:skb_assert_len include/linux/skbuff.h:2552 [inline]
RIP: 0010:__dev_queue_xmit+0x1f26/0x31d0 net/core/dev.c:4159
Code: 89 de e8 1d a2 85 fd 84 db 75 21 e8 64 a9 85 fd 48 c7 c6 80 2a 1f 86 48 c7 c7 c0 06 1f 86 c6 05 23 cf 27 04 01 e8 fa ee 56 fd <0f> 0b e8 43 a9 85 fd 0f b6 1d 0f cf 27 04 31 ff 89 de e8 e3 a1 85
RSP: 0018:ffff8880217af6e0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc90001133000
RDX: 0000000000040000 RSI: ffffffff81186922 RDI: 0000000000000001
RBP: ffff8880217af8b0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888030045640
R13: ffff8880300456b0 R14: ffff888030045650 R15: ffff888030045718
FS:  00007fc5864da640(0000) GS:ffff88806cd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020005740 CR3: 000000003f856003 CR4: 0000000000770ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 dev_queue_xmit include/linux/netdevice.h:3085 [inline]
 packet_sendmsg_spkt+0xc4b/0x1230 net/packet/af_packet.c:2066
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0x1b4/0x200 net/socket.c:747
 ____sys_sendmsg+0x331/0x970 net/socket.c:2503
 ___sys_sendmsg+0x11d/0x1c0 net/socket.c:2557
 __sys_sendmmsg+0x18c/0x430 net/socket.c:2643
 __do_sys_sendmmsg net/socket.c:2672 [inline]
 __se_sys_sendmmsg net/socket.c:2669 [inline]
 __x64_sys_sendmmsg+0x9c/0x100 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3c/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7fc58791de5d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 9f 1b 00 f7 d8 64 89 01 48
RSP: 002b:00007fc5864d9cc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00000000004bbf80 RCX: 00007fc58791de5d
RDX: 0000000000000001 RSI: 0000000020005740 RDI: 0000000000000004
RBP: 00000000004bbf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fc58797e530 R15: 0000000000000000
 </TASK>
---[ end trace 0000000000000000 ]---
skb len=0 headroom=16 headlen=0 tailroom=304
mac=(16,0) net=(16,-1) trans=-1
shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
csum(0x0 ip_summed=0 complete_sw=0 valid=0 level=0)
hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
dev name=sit0 feat=0x00000006401d7869
sk family=17 type=10 proto=0

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/packet/af_packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 9b6f6a5e0b147..2e766490a739b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1996,7 +1996,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		goto retry;
 	}
 
-	if (!dev_validate_header(dev, skb->data, len)) {
+	if (!dev_validate_header(dev, skb->data, len) || !skb->len) {
 		err = -EINVAL;
 		goto out_unlock;
 	}
-- 
2.39.2



