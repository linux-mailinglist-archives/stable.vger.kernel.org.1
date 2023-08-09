Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11966775BF0
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjHILW0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjHILWY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:22:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3501FCE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 715F26320B
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3C9C433C7;
        Wed,  9 Aug 2023 11:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580127;
        bh=BD11UuCIQdcdhJQofuG088UlS/kBoOe9CUsI+FkSvEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HUd6rzoH4zzNsGqX7/af7aitSgndC6OnNa7968sPEiW3fNJZN1YkTU6niSfy7cZ4T
         /ascLBFzrYaZgD4aan4oG8MR6vV8ln5IDw+vmKpD5x9DSFWJp+sM30yQc/Y/aCnWy7
         Y9FO2C2GpVoYV6HXcAOJqoz+U1SPd/AnEERV/Ps4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 206/323] Revert "tcp: avoid the lookup process failing to get sk in ehash table"
Date:   Wed,  9 Aug 2023 12:40:44 +0200
Message-ID: <20230809103707.582336618@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 5a272d09b8248..c6d670cd872f0 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -579,20 +579,8 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
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
@@ -601,7 +589,6 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	if (ret)
 		__sk_nulls_add_node_rcu(sk, list);
 
-unlock:
 	spin_unlock(lock);
 
 	return ret;
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index fedd19c22b392..88c5069b5d20c 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -80,10 +80,10 @@ void inet_twsk_put(struct inet_timewait_sock *tw)
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
@@ -119,7 +119,7 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
 	spin_lock(lock);
 
-	inet_twsk_add_node_tail_rcu(tw, &ehead->chain);
+	inet_twsk_add_node_rcu(tw, &ehead->chain);
 
 	/* Step 3: Remove SK from hash chain */
 	if (__sk_nulls_del_node_init_rcu(sk))
-- 
2.39.2



