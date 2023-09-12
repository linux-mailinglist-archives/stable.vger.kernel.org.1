Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AC179B89F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjIKWtN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbjIKOVB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:21:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFDADE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:20:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAD2C433C8;
        Mon, 11 Sep 2023 14:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442056;
        bh=hm0zgMzLeMOXRJmsxmb7wtkWiTPG8vzY+txwRzADx9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6KGDgeMf5jnXsKQwSXTcCZvLRDZR+VbDLNBGwHJZXOBh+EbTU09G60v9djZ6yEz4
         SIm39bnrzTvD3ps8RblS2Wh9vnFbVrCSNA3yX4nKo7T/swqQnCEsEC96fvk6V7hlop
         amyc/n1niPgfXruxACDFNyIhv5NlOEWSNDVrK0T8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Kyle Zeng <zengyhkyle@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.5 630/739] net: deal with integer overflows in kmalloc_reserve()
Date:   Mon, 11 Sep 2023 15:47:09 +0200
Message-ID: <20230911134708.691319449@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 915d975b2ffa58a14bfcf16fafe00c41315949ff upstream.

Blamed commit changed:
    ptr = kmalloc(size);
    if (ptr)
      size = ksize(ptr);

to:
    size = kmalloc_size_roundup(size);
    ptr = kmalloc(size);

This allowed various crash as reported by syzbot [1]
and Kyle Zeng.

Problem is that if @size is bigger than 0x80000001,
kmalloc_size_roundup(size) returns 2^32.

kmalloc_reserve() uses a 32bit variable (obj_size),
so 2^32 is truncated to 0.

kmalloc(0) returns ZERO_SIZE_PTR which is not handled by
skb allocations.

Following trace can be triggered if a netdev->mtu is set
close to 0x7fffffff

We might in the future limit netdev->mtu to more sensible
limit (like KMALLOC_MAX_SIZE).

This patch is based on a syzbot report, and also a report
and tentative fix from Kyle Zeng.

[1]
BUG: KASAN: user-memory-access in __build_skb_around net/core/skbuff.c:294 [inline]
BUG: KASAN: user-memory-access in __alloc_skb+0x3c4/0x6e8 net/core/skbuff.c:527
Write of size 32 at addr 00000000fffffd10 by task syz-executor.4/22554

CPU: 1 PID: 22554 Comm: syz-executor.4 Not tainted 6.1.39-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call trace:
dump_backtrace+0x1c8/0x1f4 arch/arm64/kernel/stacktrace.c:279
show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:286
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x120/0x1a0 lib/dump_stack.c:106
print_report+0xe4/0x4b4 mm/kasan/report.c:398
kasan_report+0x150/0x1ac mm/kasan/report.c:495
kasan_check_range+0x264/0x2a4 mm/kasan/generic.c:189
memset+0x40/0x70 mm/kasan/shadow.c:44
__build_skb_around net/core/skbuff.c:294 [inline]
__alloc_skb+0x3c4/0x6e8 net/core/skbuff.c:527
alloc_skb include/linux/skbuff.h:1316 [inline]
igmpv3_newpack+0x104/0x1088 net/ipv4/igmp.c:359
add_grec+0x81c/0x1124 net/ipv4/igmp.c:534
igmpv3_send_cr net/ipv4/igmp.c:667 [inline]
igmp_ifc_timer_expire+0x1b0/0x1008 net/ipv4/igmp.c:810
call_timer_fn+0x1c0/0x9f0 kernel/time/timer.c:1474
expire_timers kernel/time/timer.c:1519 [inline]
__run_timers+0x54c/0x710 kernel/time/timer.c:1790
run_timer_softirq+0x28/0x4c kernel/time/timer.c:1803
_stext+0x380/0xfbc
____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:891
do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:84
invoke_softirq kernel/softirq.c:437 [inline]
__irq_exit_rcu+0x1c0/0x4cc kernel/softirq.c:683
irq_exit_rcu+0x14/0x78 kernel/softirq.c:695
el0_interrupt+0x7c/0x2e0 arch/arm64/kernel/entry-common.c:717
__el0_irq_handler_common+0x18/0x24 arch/arm64/kernel/entry-common.c:724
el0t_64_irq_handler+0x10/0x1c arch/arm64/kernel/entry-common.c:729
el0t_64_irq+0x1a0/0x1a4 arch/arm64/kernel/entry.S:584

Fixes: 12d6c1d3a2ad ("skbuff: Proactively round up to kmalloc bucket size")
Reported-by: syzbot <syzkaller@googlegroups.com>
Reported-by: Kyle Zeng <zengyhkyle@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -550,7 +550,7 @@ static void *kmalloc_reserve(unsigned in
 			     bool *pfmemalloc)
 {
 	bool ret_pfmemalloc = false;
-	unsigned int obj_size;
+	size_t obj_size;
 	void *obj;
 
 	obj_size = SKB_HEAD_ALIGN(*size);
@@ -567,7 +567,13 @@ static void *kmalloc_reserve(unsigned in
 		obj = kmem_cache_alloc_node(skb_small_head_cache, flags, node);
 		goto out;
 	}
-	*size = obj_size = kmalloc_size_roundup(obj_size);
+
+	obj_size = kmalloc_size_roundup(obj_size);
+	/* The following cast might truncate high-order bits of obj_size, this
+	 * is harmless because kmalloc(obj_size >= 2^32) will fail anyway.
+	 */
+	*size = (unsigned int)obj_size;
+
 	/*
 	 * Try a regular allocation, when that fails and we're not entitled
 	 * to the reserves, fail.


