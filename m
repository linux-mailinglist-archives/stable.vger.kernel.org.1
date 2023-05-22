Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1039770C5E4
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjEVTNO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjEVTNM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:13:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49590103
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:13:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3C5462704
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0085DC433A1;
        Mon, 22 May 2023 19:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684782788;
        bh=2fWM5LCcdumWClARgJZ5IjQjv4aCz0egXsYVljFvtGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IpSQ4CZFlgVGMK6F27L4pQhobTuB0digyFnq1tRblXRZ9YhbCBRCU8xBMxuk4QwBC
         G1zQ3Qqd0lFVa2wRG1EBk4a1Qg8IsxlihXxSpTDeCm6MiwTa151bZQD+28m13Mup2D
         gl8WDiDG6PG2wIBxW5oc2OpAy6ZdBS7eQvuVIqj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Eric Dumazet <edumazet@google.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 020/203] af_unix: Fix a data race of sk->sk_receive_queue->qlen.
Date:   Mon, 22 May 2023 20:07:24 +0100
Message-Id: <20230522190355.511651469@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

[ Upstream commit 679ed006d416ea0cecfe24a99d365d1dea69c683 ]

KCSAN found a data race of sk->sk_receive_queue->qlen where recvmsg()
updates qlen under the queue lock and sendmsg() checks qlen under
unix_state_sock(), not the queue lock, so the reader side needs
READ_ONCE().

BUG: KCSAN: data-race in __skb_try_recv_from_queue / unix_wait_for_peer

write (marked) to 0xffff888019fe7c68 of 4 bytes by task 49792 on cpu 0:
 __skb_unlink include/linux/skbuff.h:2347 [inline]
 __skb_try_recv_from_queue+0x3de/0x470 net/core/datagram.c:197
 __skb_try_recv_datagram+0xf7/0x390 net/core/datagram.c:263
 __unix_dgram_recvmsg+0x109/0x8a0 net/unix/af_unix.c:2452
 unix_dgram_recvmsg+0x94/0xa0 net/unix/af_unix.c:2549
 sock_recvmsg_nosec net/socket.c:1019 [inline]
 ____sys_recvmsg+0x3a3/0x3b0 net/socket.c:2720
 ___sys_recvmsg+0xc8/0x150 net/socket.c:2764
 do_recvmmsg+0x182/0x560 net/socket.c:2858
 __sys_recvmmsg net/socket.c:2937 [inline]
 __do_sys_recvmmsg net/socket.c:2960 [inline]
 __se_sys_recvmmsg net/socket.c:2953 [inline]
 __x64_sys_recvmmsg+0x153/0x170 net/socket.c:2953
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

read to 0xffff888019fe7c68 of 4 bytes by task 49793 on cpu 1:
 skb_queue_len include/linux/skbuff.h:2127 [inline]
 unix_recvq_full net/unix/af_unix.c:229 [inline]
 unix_wait_for_peer+0x154/0x1a0 net/unix/af_unix.c:1445
 unix_dgram_sendmsg+0x13bc/0x14b0 net/unix/af_unix.c:2048
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0x148/0x160 net/socket.c:747
 ____sys_sendmsg+0x20e/0x620 net/socket.c:2503
 ___sys_sendmsg+0xc6/0x140 net/socket.c:2557
 __sys_sendmmsg+0x11d/0x370 net/socket.c:2643
 __do_sys_sendmmsg net/socket.c:2672 [inline]
 __se_sys_sendmmsg net/socket.c:2669 [inline]
 __x64_sys_sendmmsg+0x58/0x70 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

value changed: 0x0000000b -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 49793 Comm: syz-executor.0 Not tainted 6.3.0-rc7-02330-gca6270c12e20 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a96026dbdf94e..230e20cd986e2 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1307,7 +1307,7 @@ static long unix_wait_for_peer(struct sock *other, long timeo)
 
 	sched = !sock_flag(other, SOCK_DEAD) &&
 		!(other->sk_shutdown & RCV_SHUTDOWN) &&
-		unix_recvq_full(other);
+		unix_recvq_full_lockless(other);
 
 	unix_state_unlock(other);
 
-- 
2.39.2



