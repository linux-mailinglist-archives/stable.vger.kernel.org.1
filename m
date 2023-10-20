Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267AC7D16E4
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 22:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjJTUXL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjJTUXK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 16:23:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE10D63
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 13:23:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD4BC433C8;
        Fri, 20 Oct 2023 20:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697833387;
        bh=4ERxc0zdNHqB3z2BGzTLvLJV4STXbUpaJ9OCHj6XKfs=;
        h=Subject:To:Cc:From:Date:From;
        b=cYPGLEZbcTAJPOah5er7yFNGgG2+CBFvclRjjwB85Te3hnG2Y6woC6LLZQkvJm5rM
         LxbvewG/yUMoAxhcK7dq7cTd9KtMVXTu6zgHWZ4BaBzH/MCUyT1k8lAMyz9v5GOspJ
         VEqrDKn1Z/dUi2n0sw/bcjCSO0n1tOzcKCuOAwyM=
Subject: FAILED: patch "[PATCH] net: xfrm: skip policies marked as dead while reinserting" failed to apply to 5.15-stable tree
To:     dongchenchen2@huawei.com, steffen.klassert@secunet.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 22:23:03 +0200
Message-ID: <2023102003-shank-happiness-527c@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6d41d4fe28724db16ca1016df0713a07e0cc7448
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102003-shank-happiness-527c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6d41d4fe28724db16ca1016df0713a07e0cc7448 Mon Sep 17 00:00:00 2001
From: Dong Chenchen <dongchenchen2@huawei.com>
Date: Tue, 15 Aug 2023 22:18:34 +0800
Subject: [PATCH] net: xfrm: skip policies marked as dead while reinserting
 policies

BUG: KASAN: slab-use-after-free in xfrm_policy_inexact_list_reinsert+0xb6/0x430
Read of size 1 at addr ffff8881051f3bf8 by task ip/668

CPU: 2 PID: 668 Comm: ip Not tainted 6.5.0-rc5-00182-g25aa0bebba72-dirty #64
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x72/0xa0
 print_report+0xd0/0x620
 kasan_report+0xb6/0xf0
 xfrm_policy_inexact_list_reinsert+0xb6/0x430
 xfrm_policy_inexact_insert_node.constprop.0+0x537/0x800
 xfrm_policy_inexact_alloc_chain+0x23f/0x320
 xfrm_policy_inexact_insert+0x6b/0x590
 xfrm_policy_insert+0x3b1/0x480
 xfrm_add_policy+0x23c/0x3c0
 xfrm_user_rcv_msg+0x2d0/0x510
 netlink_rcv_skb+0x10d/0x2d0
 xfrm_netlink_rcv+0x49/0x60
 netlink_unicast+0x3fe/0x540
 netlink_sendmsg+0x528/0x970
 sock_sendmsg+0x14a/0x160
 ____sys_sendmsg+0x4fc/0x580
 ___sys_sendmsg+0xef/0x160
 __sys_sendmsg+0xf7/0x1b0
 do_syscall_64+0x3f/0x90
 entry_SYSCALL_64_after_hwframe+0x73/0xdd

The root cause is:

cpu 0			cpu1
xfrm_dump_policy
xfrm_policy_walk
list_move_tail
			xfrm_add_policy
			... ...
			xfrm_policy_inexact_list_reinsert
			list_for_each_entry_reverse
				if (!policy->bydst_reinsert)
				//read non-existent policy
xfrm_dump_policy_done
xfrm_policy_walk_done
list_del(&walk->walk.all);

If dump_one_policy() returns err (triggered by netlink socket),
xfrm_policy_walk() will move walk initialized by socket to list
net->xfrm.policy_all. so this socket becomes visible in the global
policy list. The head *walk can be traversed when users add policies
with different prefixlen and trigger xfrm_policy node merge.

The issue can also be triggered by policy list traversal while rehashing
and flushing policies.

It can be fixed by skip such "policies" with walk.dead set to 1.

Fixes: 9cf545ebd591 ("xfrm: policy: store inexact policies in a tree ordered by destination address")
Fixes: 12a169e7d8f4 ("ipsec: Put dumpers on the dump list")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index d6b405782b63..113fb7e9cdaf 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -851,7 +851,7 @@ static void xfrm_policy_inexact_list_reinsert(struct net *net,
 		struct hlist_node *newpos = NULL;
 		bool matches_s, matches_d;
 
-		if (!policy->bydst_reinsert)
+		if (policy->walk.dead || !policy->bydst_reinsert)
 			continue;
 
 		WARN_ON_ONCE(policy->family != family);
@@ -1256,8 +1256,11 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 		struct xfrm_pol_inexact_bin *bin;
 		u8 dbits, sbits;
 
+		if (policy->walk.dead)
+			continue;
+
 		dir = xfrm_policy_id2dir(policy->index);
-		if (policy->walk.dead || dir >= XFRM_POLICY_MAX)
+		if (dir >= XFRM_POLICY_MAX)
 			continue;
 
 		if ((dir & XFRM_POLICY_MASK) == XFRM_POLICY_OUT) {
@@ -1823,9 +1826,11 @@ int xfrm_policy_flush(struct net *net, u8 type, bool task_valid)
 
 again:
 	list_for_each_entry(pol, &net->xfrm.policy_all, walk.all) {
+		if (pol->walk.dead)
+			continue;
+
 		dir = xfrm_policy_id2dir(pol->index);
-		if (pol->walk.dead ||
-		    dir >= XFRM_POLICY_MAX ||
+		if (dir >= XFRM_POLICY_MAX ||
 		    pol->type != type)
 			continue;
 
@@ -1862,9 +1867,11 @@ int xfrm_dev_policy_flush(struct net *net, struct net_device *dev,
 
 again:
 	list_for_each_entry(pol, &net->xfrm.policy_all, walk.all) {
+		if (pol->walk.dead)
+			continue;
+
 		dir = xfrm_policy_id2dir(pol->index);
-		if (pol->walk.dead ||
-		    dir >= XFRM_POLICY_MAX ||
+		if (dir >= XFRM_POLICY_MAX ||
 		    pol->xdo.dev != dev)
 			continue;
 

