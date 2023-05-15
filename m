Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81957039E2
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244630AbjEORqh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244696AbjEORqP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:46:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27361B8
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:44:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6861462E9A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6BBC433D2;
        Mon, 15 May 2023 17:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172669;
        bh=QL0hAO1p78yp1XQA+GY/u8sQwfkMOqVpqCaeCpuuR1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x3Eph2wefaSbcFoRsdUObaCewaPh8FEXHZmi2eTrdlRy56ZwknrnX/Nk6UUtOK5wu
         H6bBuqI+H767CbONIuq45cSHh5TCAzQht34YfYXA1ptzuEsizmbCyQ5VI0gKgy4Lme
         hCSwEJ/V3vrSlVjrWDYBVSHT0iF0I/f8weHnarkM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 191/381] tcp/udp: Fix memleaks of sk and zerocopy skbs with TX timestamp.
Date:   Mon, 15 May 2023 18:27:22 +0200
Message-Id: <20230515161745.445921288@linuxfoundation.org>
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

[ Upstream commit 50749f2dd6854a41830996ad302aef2ffaf011d8 ]

syzkaller reported [0] memory leaks of an UDP socket and ZEROCOPY
skbs.  We can reproduce the problem with these sequences:

  sk = socket(AF_INET, SOCK_DGRAM, 0)
  sk.setsockopt(SOL_SOCKET, SO_TIMESTAMPING, SOF_TIMESTAMPING_TX_SOFTWARE)
  sk.setsockopt(SOL_SOCKET, SO_ZEROCOPY, 1)
  sk.sendto(b'', MSG_ZEROCOPY, ('127.0.0.1', 53))
  sk.close()

sendmsg() calls msg_zerocopy_alloc(), which allocates a skb, sets
skb->cb->ubuf.refcnt to 1, and calls sock_hold().  Here, struct
ubuf_info_msgzc indirectly holds a refcnt of the socket.  When the
skb is sent, __skb_tstamp_tx() clones it and puts the clone into
the socket's error queue with the TX timestamp.

When the original skb is received locally, skb_copy_ubufs() calls
skb_unclone(), and pskb_expand_head() increments skb->cb->ubuf.refcnt.
This additional count is decremented while freeing the skb, but struct
ubuf_info_msgzc still has a refcnt, so __msg_zerocopy_callback() is
not called.

The last refcnt is not released unless we retrieve the TX timestamped
skb by recvmsg().  Since we clear the error queue in inet_sock_destruct()
after the socket's refcnt reaches 0, there is a circular dependency.
If we close() the socket holding such skbs, we never call sock_put()
and leak the count, sk, and skb.

TCP has the same problem, and commit e0c8bccd40fc ("net: stream:
purge sk_error_queue in sk_stream_kill_queues()") tried to fix it
by calling skb_queue_purge() during close().  However, there is a
small chance that skb queued in a qdisc or device could be put
into the error queue after the skb_queue_purge() call.

In __skb_tstamp_tx(), the cloned skb should not have a reference
to the ubuf to remove the circular dependency, but skb_clone() does
not call skb_copy_ubufs() for zerocopy skb.  So, we need to call
skb_orphan_frags_rx() for the cloned skb to call skb_copy_ubufs().

[0]:
BUG: memory leak
unreferenced object 0xffff88800c6d2d00 (size 1152):
  comm "syz-executor392", pid 264, jiffies 4294785440 (age 13.044s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 cd af e8 81 00 00 00 00  ................
    02 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
  backtrace:
    [<0000000055636812>] sk_prot_alloc+0x64/0x2a0 net/core/sock.c:2024
    [<0000000054d77b7a>] sk_alloc+0x3b/0x800 net/core/sock.c:2083
    [<0000000066f3c7e0>] inet_create net/ipv4/af_inet.c:319 [inline]
    [<0000000066f3c7e0>] inet_create+0x31e/0xe40 net/ipv4/af_inet.c:245
    [<000000009b83af97>] __sock_create+0x2ab/0x550 net/socket.c:1515
    [<00000000b9b11231>] sock_create net/socket.c:1566 [inline]
    [<00000000b9b11231>] __sys_socket_create net/socket.c:1603 [inline]
    [<00000000b9b11231>] __sys_socket_create net/socket.c:1588 [inline]
    [<00000000b9b11231>] __sys_socket+0x138/0x250 net/socket.c:1636
    [<000000004fb45142>] __do_sys_socket net/socket.c:1649 [inline]
    [<000000004fb45142>] __se_sys_socket net/socket.c:1647 [inline]
    [<000000004fb45142>] __x64_sys_socket+0x73/0xb0 net/socket.c:1647
    [<0000000066999e0e>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<0000000066999e0e>] do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80
    [<0000000017f238c1>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888017633a00 (size 240):
  comm "syz-executor392", pid 264, jiffies 4294785440 (age 13.044s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 2d 6d 0c 80 88 ff ff  .........-m.....
  backtrace:
    [<000000002b1c4368>] __alloc_skb+0x229/0x320 net/core/skbuff.c:497
    [<00000000143579a6>] alloc_skb include/linux/skbuff.h:1265 [inline]
    [<00000000143579a6>] sock_omalloc+0xaa/0x190 net/core/sock.c:2596
    [<00000000be626478>] msg_zerocopy_alloc net/core/skbuff.c:1294 [inline]
    [<00000000be626478>] msg_zerocopy_realloc+0x1ce/0x7f0 net/core/skbuff.c:1370
    [<00000000cbfc9870>] __ip_append_data+0x2adf/0x3b30 net/ipv4/ip_output.c:1037
    [<0000000089869146>] ip_make_skb+0x26c/0x2e0 net/ipv4/ip_output.c:1652
    [<00000000098015c2>] udp_sendmsg+0x1bac/0x2390 net/ipv4/udp.c:1253
    [<0000000045e0e95e>] inet_sendmsg+0x10a/0x150 net/ipv4/af_inet.c:819
    [<000000008d31bfde>] sock_sendmsg_nosec net/socket.c:714 [inline]
    [<000000008d31bfde>] sock_sendmsg+0x141/0x190 net/socket.c:734
    [<0000000021e21aa4>] __sys_sendto+0x243/0x360 net/socket.c:2117
    [<00000000ac0af00c>] __do_sys_sendto net/socket.c:2129 [inline]
    [<00000000ac0af00c>] __se_sys_sendto net/socket.c:2125 [inline]
    [<00000000ac0af00c>] __x64_sys_sendto+0xe1/0x1c0 net/socket.c:2125
    [<0000000066999e0e>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<0000000066999e0e>] do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80
    [<0000000017f238c1>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: f214f915e7db ("tcp: enable MSG_ZEROCOPY")
Fixes: b5947e5d1e71 ("udp: msg_zerocopy")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skbuff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 09cdefe5e1c83..fb6b3f2ae1921 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4750,6 +4750,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 			skb = alloc_skb(0, GFP_ATOMIC);
 	} else {
 		skb = skb_clone(orig_skb, GFP_ATOMIC);
+
+		if (skb_orphan_frags_rx(skb, GFP_ATOMIC))
+			return;
 	}
 	if (!skb)
 		return;
-- 
2.39.2



