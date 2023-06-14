Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EAA713EE3
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjE1Tjz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjE1Tjy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:39:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144B0BB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:39:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C81661EA9
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9F2C433EF;
        Sun, 28 May 2023 19:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302792;
        bh=0Hs1swrjMP1w+mWt1ScLb5Q6T1YTrGJgywyqzGoRsuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUUPouB/xrs5xRK7MyDAcSUozGGHl0VrK5gDZ9SauxrFKsgWo9KUykfRsvAtWT+fv
         WZgA70/f+MILT/MJtpBbCl0aO40y7PoD5rUCr5yWcS0Y4MZuw/mPnt5iT7lCzngVZv
         hppLgFNaywipIV2wf979xN3VZN09X3D4nw5tB8eQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 008/211] netlink: annotate accesses to nlk->cb_running
Date:   Sun, 28 May 2023 20:08:49 +0100
Message-Id: <20230528190843.729277963@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a939d14919b799e6fff8a9c80296ca229ba2f8a4 ]

Both netlink_recvmsg() and netlink_native_seq_show() read
nlk->cb_running locklessly. Use READ_ONCE() there.

Add corresponding WRITE_ONCE() to netlink_dump() and
__netlink_dump_start()

syzbot reported:
BUG: KCSAN: data-race in __netlink_dump_start / netlink_recvmsg

write to 0xffff88813ea4db59 of 1 bytes by task 28219 on cpu 0:
__netlink_dump_start+0x3af/0x4d0 net/netlink/af_netlink.c:2399
netlink_dump_start include/linux/netlink.h:308 [inline]
rtnetlink_rcv_msg+0x70f/0x8c0 net/core/rtnetlink.c:6130
netlink_rcv_skb+0x126/0x220 net/netlink/af_netlink.c:2577
rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:6192
netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
netlink_unicast+0x56f/0x640 net/netlink/af_netlink.c:1365
netlink_sendmsg+0x665/0x770 net/netlink/af_netlink.c:1942
sock_sendmsg_nosec net/socket.c:724 [inline]
sock_sendmsg net/socket.c:747 [inline]
sock_write_iter+0x1aa/0x230 net/socket.c:1138
call_write_iter include/linux/fs.h:1851 [inline]
new_sync_write fs/read_write.c:491 [inline]
vfs_write+0x463/0x760 fs/read_write.c:584
ksys_write+0xeb/0x1a0 fs/read_write.c:637
__do_sys_write fs/read_write.c:649 [inline]
__se_sys_write fs/read_write.c:646 [inline]
__x64_sys_write+0x42/0x50 fs/read_write.c:646
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff88813ea4db59 of 1 bytes by task 28222 on cpu 1:
netlink_recvmsg+0x3b4/0x730 net/netlink/af_netlink.c:2022
sock_recvmsg_nosec+0x4c/0x80 net/socket.c:1017
____sys_recvmsg+0x2db/0x310 net/socket.c:2718
___sys_recvmsg net/socket.c:2762 [inline]
do_recvmmsg+0x2e5/0x710 net/socket.c:2856
__sys_recvmmsg net/socket.c:2935 [inline]
__do_sys_recvmmsg net/socket.c:2958 [inline]
__se_sys_recvmmsg net/socket.c:2951 [inline]
__x64_sys_recvmmsg+0xe2/0x160 net/socket.c:2951
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00 -> 0x01

Fixes: 16b304f3404f ("netlink: Eliminate kmalloc in netlink dump operation.")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlink/af_netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index eedb16517f16a..651f8ca912af0 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1992,7 +1992,7 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	skb_free_datagram(sk, skb);
 
-	if (nlk->cb_running &&
+	if (READ_ONCE(nlk->cb_running) &&
 	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf / 2) {
 		ret = netlink_dump(sk);
 		if (ret) {
@@ -2304,7 +2304,7 @@ static int netlink_dump(struct sock *sk)
 	if (cb->done)
 		cb->done(cb);
 
-	nlk->cb_running = false;
+	WRITE_ONCE(nlk->cb_running, false);
 	module = cb->module;
 	skb = cb->skb;
 	mutex_unlock(nlk->cb_mutex);
@@ -2367,7 +2367,7 @@ int __netlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 			goto error_put;
 	}
 
-	nlk->cb_running = true;
+	WRITE_ONCE(nlk->cb_running, true);
 	nlk->dump_done_errno = INT_MAX;
 
 	mutex_unlock(nlk->cb_mutex);
@@ -2653,7 +2653,7 @@ static int netlink_native_seq_show(struct seq_file *seq, void *v)
 			   nlk->groups ? (u32)nlk->groups[0] : 0,
 			   sk_rmem_alloc_get(s),
 			   sk_wmem_alloc_get(s),
-			   nlk->cb_running,
+			   READ_ONCE(nlk->cb_running),
 			   refcount_read(&s->sk_refcnt),
 			   atomic_read(&s->sk_drops),
 			   sock_i_ino(s)
-- 
2.39.2



