Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B747997B2
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 13:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345079AbjIILl5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 07:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjIILl5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 07:41:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F8FE46
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 04:41:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8392C433C7;
        Sat,  9 Sep 2023 11:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694259712;
        bh=4X2O6fCkobutyTDl7BGjUv66DS7sYYkohEnv9igP+PI=;
        h=Subject:To:Cc:From:Date:From;
        b=0Yj+hqgkyf2z7VI+qoy1zf217JV0mcvv3uVjw33FatUUpeNZISGVyxppJrsOKqWG2
         1WJew7QaR7PyDi7J4XsvjWy0G0LdFMjr5mfRo8kzpDmBR/5uiEaK2halY1GKl8VB2R
         9Zboy7f0LbOcCb21izjyHb8hEgyCf1X2x2vHLJOU=
Subject: FAILED: patch "[PATCH] net: deal with integer overflows in kmalloc_reserve()" failed to apply to 6.1-stable tree
To:     edumazet@google.com, davem@davemloft.net, keescook@chromium.org,
        syzkaller@googlegroups.com, vbabka@suse.cz, zengyhkyle@gmail.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 09 Sep 2023 12:41:47 +0100
Message-ID: <2023090947-ream-vagrantly-7b88@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 915d975b2ffa58a14bfcf16fafe00c41315949ff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090947-ream-vagrantly-7b88@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

915d975b2ffa ("net: deal with integer overflows in kmalloc_reserve()")
559ae55cfc33 ("net: skbuff: remove special handling for SLOB")
880ce5f20033 ("net: avoid skb end_offset change in __skb_unclone_keeptruesize()")
0b34d68049b0 ("net: enable usercopy for skb_small_head_cache")
bf9f1baa279f ("net: add dedicated kmem_cache for typical/small skb->head")
5c0e820cbbbe ("net: factorize code in kmalloc_reserve()")
65998d2bf857 ("net: remove osize variable in __alloc_skb()")
115f1a5c42bd ("net: add SKB_HEAD_ALIGN() helper")
12d6c1d3a2ad ("skbuff: Proactively round up to kmalloc bucket size")
4727bab4e9bb ("net: skb: move skb_pp_recycle() to skbuff.c")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 915d975b2ffa58a14bfcf16fafe00c41315949ff Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 31 Aug 2023 18:37:50 +0000
Subject: [PATCH] net: deal with integer overflows in kmalloc_reserve()

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

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 17caf4ea67da..4eaf7ed0d1f4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -550,7 +550,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 			     bool *pfmemalloc)
 {
 	bool ret_pfmemalloc = false;
-	unsigned int obj_size;
+	size_t obj_size;
 	void *obj;
 
 	obj_size = SKB_HEAD_ALIGN(*size);
@@ -567,7 +567,13 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
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

