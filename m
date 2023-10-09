Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7697BDECD
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376436AbjJINXS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376435AbjJINXR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:23:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EFDD3
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:23:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA246C433C7;
        Mon,  9 Oct 2023 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857795;
        bh=5AuoBdCsQANOVM3sow6EfjXnhZV8yITNGDgRPi+laSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0sYFPBwLhQ2f/TeD58FySbUrxXGlmiD1yt0r4cZqlmhMtTHTJsFT+wp9mm+yxDwGW
         depyRpr5othclGegK/HvgGbjkjFNx0QaG+iLF6nES2q1HGaK4UtMxxr+86isbjvWpz
         m+a12Z1cGxg/4Bt+fGl/gZ7GWgbnUUChU+Vci3iY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 158/162] ipv6: remove nexthop_fib6_nh_bh()
Date:   Mon,  9 Oct 2023 15:02:19 +0200
Message-ID: <20231009130127.276853995@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit ef1148d4487438a3408d6face2a8360d91b4af70 upstream.

After blamed commit, nexthop_fib6_nh_bh() and nexthop_fib6_nh()
are the same.

Delete nexthop_fib6_nh_bh(), and convert /proc/net/ipv6_route
to standard rcu to avoid this splat:

[ 5723.180080] WARNING: suspicious RCU usage
[ 5723.180083] -----------------------------
[ 5723.180084] include/net/nexthop.h:516 suspicious rcu_dereference_check() usage!
[ 5723.180086]
other info that might help us debug this:

[ 5723.180087]
rcu_scheduler_active = 2, debug_locks = 1
[ 5723.180089] 2 locks held by cat/55856:
[ 5723.180091] #0: ffff9440a582afa8 (&p->lock){+.+.}-{3:3}, at: seq_read_iter (fs/seq_file.c:188)
[ 5723.180100] #1: ffffffffaac07040 (rcu_read_lock_bh){....}-{1:2}, at: rcu_lock_acquire (include/linux/rcupdate.h:326)
[ 5723.180109]
stack backtrace:
[ 5723.180111] CPU: 14 PID: 55856 Comm: cat Tainted: G S        I        6.3.0-dbx-DEV #528
[ 5723.180115] Call Trace:
[ 5723.180117]  <TASK>
[ 5723.180119] dump_stack_lvl (lib/dump_stack.c:107)
[ 5723.180124] dump_stack (lib/dump_stack.c:114)
[ 5723.180126] lockdep_rcu_suspicious (include/linux/context_tracking.h:122)
[ 5723.180132] ipv6_route_seq_show (include/net/nexthop.h:?)
[ 5723.180135] ? ipv6_route_seq_next (net/ipv6/ip6_fib.c:2605)
[ 5723.180140] seq_read_iter (fs/seq_file.c:272)
[ 5723.180145] seq_read (fs/seq_file.c:163)
[ 5723.180151] proc_reg_read (fs/proc/inode.c:316 fs/proc/inode.c:328)
[ 5723.180155] vfs_read (fs/read_write.c:468)
[ 5723.180160] ? up_read (kernel/locking/rwsem.c:1617)
[ 5723.180164] ksys_read (fs/read_write.c:613)
[ 5723.180168] __x64_sys_read (fs/read_write.c:621)
[ 5723.180170] do_syscall_64 (arch/x86/entry/common.c:?)
[ 5723.180174] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
[ 5723.180177] RIP: 0033:0x7fa455677d2a

Fixes: 09eed1192cec ("neighbour: switch to standard rcu, instead of rcu_bh")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20230510154646.370659-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/nexthop.h |   23 -----------------------
 net/ipv6/ip6_fib.c    |   16 ++++++++--------
 2 files changed, 8 insertions(+), 31 deletions(-)

--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -497,29 +497,6 @@ static inline struct fib6_nh *nexthop_fi
 	return NULL;
 }
 
-/* Variant of nexthop_fib6_nh().
- * Caller should either hold rcu_read_lock(), or RTNL.
- */
-static inline struct fib6_nh *nexthop_fib6_nh_bh(struct nexthop *nh)
-{
-	struct nh_info *nhi;
-
-	if (nh->is_group) {
-		struct nh_group *nh_grp;
-
-		nh_grp = rcu_dereference_rtnl(nh->nh_grp);
-		nh = nexthop_mpath_select(nh_grp, 0);
-		if (!nh)
-			return NULL;
-	}
-
-	nhi = rcu_dereference_rtnl(nh->nh_info);
-	if (nhi->family == AF_INET6)
-		return &nhi->fib6_nh;
-
-	return NULL;
-}
-
 static inline struct net_device *fib6_info_nh_dev(struct fib6_info *f6i)
 {
 	struct fib6_nh *fib6_nh;
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2492,7 +2492,7 @@ static int ipv6_route_native_seq_show(st
 	const struct net_device *dev;
 
 	if (rt->nh)
-		fib6_nh = nexthop_fib6_nh_bh(rt->nh);
+		fib6_nh = nexthop_fib6_nh(rt->nh);
 
 	seq_printf(seq, "%pi6 %02x ", &rt->fib6_dst.addr, rt->fib6_dst.plen);
 
@@ -2557,14 +2557,14 @@ static struct fib6_table *ipv6_route_seq
 
 	if (tbl) {
 		h = (tbl->tb6_id & (FIB6_TABLE_HASHSZ - 1)) + 1;
-		node = rcu_dereference_bh(hlist_next_rcu(&tbl->tb6_hlist));
+		node = rcu_dereference(hlist_next_rcu(&tbl->tb6_hlist));
 	} else {
 		h = 0;
 		node = NULL;
 	}
 
 	while (!node && h < FIB6_TABLE_HASHSZ) {
-		node = rcu_dereference_bh(
+		node = rcu_dereference(
 			hlist_first_rcu(&net->ipv6.fib_table_hash[h++]));
 	}
 	return hlist_entry_safe(node, struct fib6_table, tb6_hlist);
@@ -2594,7 +2594,7 @@ static void *ipv6_route_seq_next(struct
 	if (!v)
 		goto iter_table;
 
-	n = rcu_dereference_bh(((struct fib6_info *)v)->fib6_next);
+	n = rcu_dereference(((struct fib6_info *)v)->fib6_next);
 	if (n)
 		return n;
 
@@ -2620,12 +2620,12 @@ iter_table:
 }
 
 static void *ipv6_route_seq_start(struct seq_file *seq, loff_t *pos)
-	__acquires(RCU_BH)
+	__acquires(RCU)
 {
 	struct net *net = seq_file_net(seq);
 	struct ipv6_route_iter *iter = seq->private;
 
-	rcu_read_lock_bh();
+	rcu_read_lock();
 	iter->tbl = ipv6_route_seq_next_table(NULL, net);
 	iter->skip = *pos;
 
@@ -2646,7 +2646,7 @@ static bool ipv6_route_iter_active(struc
 }
 
 static void ipv6_route_native_seq_stop(struct seq_file *seq, void *v)
-	__releases(RCU_BH)
+	__releases(RCU)
 {
 	struct net *net = seq_file_net(seq);
 	struct ipv6_route_iter *iter = seq->private;
@@ -2654,7 +2654,7 @@ static void ipv6_route_native_seq_stop(s
 	if (ipv6_route_iter_active(iter))
 		fib6_walker_unlink(net, &iter->w);
 
-	rcu_read_unlock_bh();
+	rcu_read_unlock();
 }
 
 #if IS_BUILTIN(CONFIG_IPV6) && defined(CONFIG_BPF_SYSCALL)


