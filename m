Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752187C9AB9
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 20:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjJOSWp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 14:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOSWo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 14:22:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7401AB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 11:22:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C58C433C7;
        Sun, 15 Oct 2023 18:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697394162;
        bh=HEWCf1xW+UtdACfzU2NZNxPQXCJi1Tqsz0Fe+t3AJoI=;
        h=Subject:To:Cc:From:Date:From;
        b=Jxa4Q5CVd/8CYny2/dTttp3WqNLmKh8nj7MhJMaHq/+jwUR5O7FiZgIJvRElSY3xO
         Ke1ziAY7h7Jqd+A/11r9unLAq4od9w9pFzXh/60U5WZLIYI6eNNB06oyqbTY7A56XU
         SQAdvndjtgkDNlvCBvKlnyIatrUjSIeQs/HBpGF0=
Subject: FAILED: patch "[PATCH] mctp: perform route lookups under a RCU read-side lock" failed to apply to 5.15-stable tree
To:     jk@codeconstruct.com.au, edumazet@google.com, kuba@kernel.org,
        rootlab@huawei.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 15 Oct 2023 20:22:35 +0200
Message-ID: <2023101535-sake-scratch-0e76@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 5093bbfc10ab6636b32728e35813cbd79feb063c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101535-sake-scratch-0e76@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

5093bbfc10ab ("mctp: perform route lookups under a RCU read-side lock")
1f6c77ac9e6e ("mctp: Allow local delivery to the null EID")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5093bbfc10ab6636b32728e35813cbd79feb063c Mon Sep 17 00:00:00 2001
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 9 Oct 2023 15:56:45 +0800
Subject: [PATCH] mctp: perform route lookups under a RCU read-side lock

Our current route lookups (mctp_route_lookup and mctp_route_lookup_null)
traverse the net's route list without the RCU read lock held. This means
the route lookup is subject to preemption, resulting in an potential
grace period expiry, and so an eventual kfree() while we still have the
route pointer.

Add the proper read-side critical section locks around the route
lookups, preventing premption and a possible parallel kfree.

The remaining net->mctp.routes accesses are already under a
rcu_read_lock, or protected by the RTNL for updates.

Based on an analysis from Sili Luo <rootlab@huawei.com>, where
introducing a delay in the route lookup could cause a UAF on
simultaneous sendmsg() and route deletion.

Reported-by: Sili Luo <rootlab@huawei.com>
Fixes: 889b7da23abf ("mctp: Add initial routing framework")
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/29c4b0e67dc1bf3571df3982de87df90cae9b631.1696837310.git.jk@codeconstruct.com.au
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mctp/route.c b/net/mctp/route.c
index ab62fe447038..7a47a58aa54b 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -737,6 +737,8 @@ struct mctp_route *mctp_route_lookup(struct net *net, unsigned int dnet,
 {
 	struct mctp_route *tmp, *rt = NULL;
 
+	rcu_read_lock();
+
 	list_for_each_entry_rcu(tmp, &net->mctp.routes, list) {
 		/* TODO: add metrics */
 		if (mctp_rt_match_eid(tmp, dnet, daddr)) {
@@ -747,21 +749,29 @@ struct mctp_route *mctp_route_lookup(struct net *net, unsigned int dnet,
 		}
 	}
 
+	rcu_read_unlock();
+
 	return rt;
 }
 
 static struct mctp_route *mctp_route_lookup_null(struct net *net,
 						 struct net_device *dev)
 {
-	struct mctp_route *rt;
+	struct mctp_route *tmp, *rt = NULL;
 
-	list_for_each_entry_rcu(rt, &net->mctp.routes, list) {
-		if (rt->dev->dev == dev && rt->type == RTN_LOCAL &&
-		    refcount_inc_not_zero(&rt->refs))
-			return rt;
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(tmp, &net->mctp.routes, list) {
+		if (tmp->dev->dev == dev && tmp->type == RTN_LOCAL &&
+		    refcount_inc_not_zero(&tmp->refs)) {
+			rt = tmp;
+			break;
+		}
 	}
 
-	return NULL;
+	rcu_read_unlock();
+
+	return rt;
 }
 
 static int mctp_do_fragment_route(struct mctp_route *rt, struct sk_buff *skb,

