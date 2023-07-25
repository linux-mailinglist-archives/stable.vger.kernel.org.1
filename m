Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D45761238
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjGYLAT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjGYK7y (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AD13C0F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBF0561682
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A53C433C8;
        Tue, 25 Jul 2023 10:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282628;
        bh=lr5SBft2HyWfjTIMJdMDdBSxdhyEArlnj2K+0xvoVsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NgL2boZrDVABBFCgPRRt+wWvbFBh9xw+X7ecXpI8y/EHNVNpIDIOYf2xvd+HBOkxK
         y8MiX5WhgJ6cZ8T5MR1aytn7oa3CEa/yoQ3twlZejCltMq2BBCLrJQA3x4PsUgQPEV
         5XbQ5XXJBoEsB3ejAjvqUyjif4yOQMqFvK4qAO4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 190/227] Revert "tcp: avoid the lookup process failing to get sk in ehash table"
Date:   Tue, 25 Jul 2023 12:45:57 +0200
Message-ID: <20230725104522.666836633@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 81b3ade5d2b98ad6e0a473b0e1e420a801275592 ]

This reverts commit 3f4ca5fafc08881d7a57daa20449d171f2887043.

Commit 3f4ca5fafc08 ("tcp: avoid the lookup process failing to get sk in
ehash table") reversed the order in how a socket is inserted into ehash
to fix an issue that ehash-lookup could fail when reqsk/full sk/twsk are
swapped.  However, it introduced another lookup failure.

The full socket in ehash is allocated from a slab with SLAB_TYPESAFE_BY_RCU
and does not have SOCK_RCU_FREE, so the socket could be reused even while
it is being referenced on another CPU doing RCU lookup.

Let's say a socket is reused and inserted into the same hash bucket during
lookup.  After the blamed commit, a new socket is inserted at the end of
the list.  If that happens, we will skip sockets placed after the previous
position of the reused socket, resulting in ehash lookup failure.

As described in Documentation/RCU/rculist_nulls.rst, we should insert a
new socket at the head of the list to avoid such an issue.

This issue, the swap-lookup-failure, and another variant reported in [0]
can all be handled properly by adding a locked ehash lookup suggested by
Eric Dumazet [1].

However, this issue could occur for every packet, thus more likely than
the other two races, so let's revert the change for now.

Link: https://lore.kernel.org/netdev/20230606064306.9192-1-duanmuquan@baidu.com/ [0]
Link: https://lore.kernel.org/netdev/CANn89iK8snOz8TYOhhwfimC7ykYA78GA3Nyv8x06SZYa1nKdyA@mail.gmail.com/ [1]
Fixes: 3f4ca5fafc08 ("tcp: avoid the lookup process failing to get sk in ehash table")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20230717215918.15723-1-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_hashtables.c    | 17 ++---------------
 net/ipv4/inet_timewait_sock.c |  8 ++++----
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index e7391bf310a75..0819d6001b9ab 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -650,20 +650,8 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	spin_lock(lock);
 	if (osk) {
 		WARN_ON_ONCE(sk->sk_hash != osk->sk_hash);
-		ret = sk_hashed(osk);
-		if (ret) {
-			/* Before deleting the node, we insert a new one to make
-			 * sure that the look-up-sk process would not miss either
-			 * of them and that at least one node would exist in ehash
-			 * table all the time. Otherwise there's a tiny chance
-			 * that lookup process could find nothing in ehash table.
-			 */
-			__sk_nulls_add_node_tail_rcu(sk, list);
-			sk_nulls_del_node_init_rcu(osk);
-		}
-		goto unlock;
-	}
-	if (found_dup_sk) {
+		ret = sk_nulls_del_node_init_rcu(osk);
+	} else if (found_dup_sk) {
 		*found_dup_sk = inet_ehash_lookup_by_sk(sk, list);
 		if (*found_dup_sk)
 			ret = false;
@@ -672,7 +660,6 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	if (ret)
 		__sk_nulls_add_node_rcu(sk, list);
 
-unlock:
 	spin_unlock(lock);
 
 	return ret;
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 40052414c7c71..2c1b245dba8e8 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -88,10 +88,10 @@ void inet_twsk_put(struct inet_timewait_sock *tw)
 }
 EXPORT_SYMBOL_GPL(inet_twsk_put);
 
-static void inet_twsk_add_node_tail_rcu(struct inet_timewait_sock *tw,
-					struct hlist_nulls_head *list)
+static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
+				   struct hlist_nulls_head *list)
 {
-	hlist_nulls_add_tail_rcu(&tw->tw_node, list);
+	hlist_nulls_add_head_rcu(&tw->tw_node, list);
 }
 
 static void inet_twsk_add_bind_node(struct inet_timewait_sock *tw,
@@ -144,7 +144,7 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
 	spin_lock(lock);
 
-	inet_twsk_add_node_tail_rcu(tw, &ehead->chain);
+	inet_twsk_add_node_rcu(tw, &ehead->chain);
 
 	/* Step 3: Remove SK from hash chain */
 	if (__sk_nulls_del_node_init_rcu(sk))
-- 
2.39.2



