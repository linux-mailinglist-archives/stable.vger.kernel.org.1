Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C845B7B89A8
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244239AbjJDS2A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244237AbjJDS17 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:27:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFE2CE
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:27:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65CAC433CB;
        Wed,  4 Oct 2023 18:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444075;
        bh=R0106IOBrom4y9jVn0luk06r5b0Q5lLsZkZZsdARZjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jz2CaWGA1zffckLSvxQBGWMBL7CHOYtIteMZUDEF7M82r+UOQ+6gh6wCCiLW+WSK8
         EkpyAcWyCUYcQQltm28dSXVe3zJbLWPSWL0eXyVW9mBjgwPjDsa7hRqIwkt1Dq9tIT
         0HPfND95jf/ondSSNJWqd69zscsxef0stt4Fti5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kyle Zeng <zengyhkyle@gmail.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 093/321] netfilter: ipset: Fix race between IPSET_CMD_CREATE and IPSET_CMD_SWAP
Date:   Wed,  4 Oct 2023 19:53:58 +0200
Message-ID: <20231004175233.530747503@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jozsef Kadlecsik <kadlec@netfilter.org>

[ Upstream commit 7433b6d2afd512d04398c73aa984d1e285be125b ]

Kyle Zeng reported that there is a race between IPSET_CMD_ADD and IPSET_CMD_SWAP
in netfilter/ip_set, which can lead to the invocation of `__ip_set_put` on a
wrong `set`, triggering the `BUG_ON(set->ref == 0);` check in it.

The race is caused by using the wrong reference counter, i.e. the ref counter instead
of ref_netlink.

Fixes: 24e227896bbf ("netfilter: ipset: Add schedule point in call_ad().")
Reported-by: Kyle Zeng <zengyhkyle@gmail.com>
Closes: https://lore.kernel.org/netfilter-devel/ZPZqetxOmH+w%2Fmyc@westworld/#r
Tested-by: Kyle Zeng <zengyhkyle@gmail.com>
Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipset/ip_set_core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 0b68e2e2824e1..58608460cf6df 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -682,6 +682,14 @@ __ip_set_put(struct ip_set *set)
 /* set->ref can be swapped out by ip_set_swap, netlink events (like dump) need
  * a separate reference counter
  */
+static void
+__ip_set_get_netlink(struct ip_set *set)
+{
+	write_lock_bh(&ip_set_ref_lock);
+	set->ref_netlink++;
+	write_unlock_bh(&ip_set_ref_lock);
+}
+
 static void
 __ip_set_put_netlink(struct ip_set *set)
 {
@@ -1693,11 +1701,11 @@ call_ad(struct net *net, struct sock *ctnl, struct sk_buff *skb,
 
 	do {
 		if (retried) {
-			__ip_set_get(set);
+			__ip_set_get_netlink(set);
 			nfnl_unlock(NFNL_SUBSYS_IPSET);
 			cond_resched();
 			nfnl_lock(NFNL_SUBSYS_IPSET);
-			__ip_set_put(set);
+			__ip_set_put_netlink(set);
 		}
 
 		ip_set_lock(set);
-- 
2.40.1



