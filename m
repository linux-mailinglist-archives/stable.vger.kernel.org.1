Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38647D315B
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjJWLIT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjJWLIT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:08:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF3FA4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:08:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D9BC433C8;
        Mon, 23 Oct 2023 11:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059295;
        bh=RD206V00s4ofQqR8pOp6/XunmHn5ango40h90eo0p+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=onX9wCoT2xW+S1Ta1pWz4JNDIiq1AAzxNYvAQ/phFyvWY4kCQXar2y76kbLt0+zDa
         TJyPRdChzOUu0oDRMC60kq4Dm8eD10pszpU1mNaCtIkb2Yg34H234g73sqJX3XR7qM
         4JHRvNxjb55CRfM/fLM13HHfldELlDHuQgGoaXOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Haller <thaller@redhat.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        David Ahern <dsahern@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 130/241] ipv4/fib: send notify when delete source address routes
Date:   Mon, 23 Oct 2023 12:55:16 +0200
Message-ID: <20231023104837.036652512@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 4b2b606075e50cdae62ab2356b0a1e206947c354 ]

After deleting an interface address in fib_del_ifaddr(), the function
scans the fib_info list for stray entries and calls fib_flush() and
fib_table_flush(). Then the stray entries will be deleted silently and no
RTM_DELROUTE notification will be sent.

This lack of notification can make routing daemons, or monitor like
`ip monitor route` miss the routing changes. e.g.

+ ip link add dummy1 type dummy
+ ip link add dummy2 type dummy
+ ip link set dummy1 up
+ ip link set dummy2 up
+ ip addr add 192.168.5.5/24 dev dummy1
+ ip route add 7.7.7.0/24 dev dummy2 src 192.168.5.5
+ ip -4 route
7.7.7.0/24 dev dummy2 scope link src 192.168.5.5
192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
+ ip monitor route
+ ip addr del 192.168.5.5/24 dev dummy1
Deleted 192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
Deleted broadcast 192.168.5.255 dev dummy1 table local proto kernel scope link src 192.168.5.5
Deleted local 192.168.5.5 dev dummy1 table local proto kernel scope host src 192.168.5.5

As Ido reminded, fib_table_flush() isn't only called when an address is
deleted, but also when an interface is deleted or put down. The lack of
notification in these cases is deliberate. And commit 7c6bb7d2faaf
("net/ipv6: Add knob to skip DELROUTE message on device down") introduced
a sysctl to make IPv6 behave like IPv4 in this regard. So we can't send
the route delete notify blindly in fib_table_flush().

To fix this issue, let's add a new flag in "struct fib_info" to track the
deleted prefer source address routes, and only send notify for them.

After update:
+ ip monitor route
+ ip addr del 192.168.5.5/24 dev dummy1
Deleted 192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
Deleted broadcast 192.168.5.255 dev dummy1 table local proto kernel scope link src 192.168.5.5
Deleted local 192.168.5.5 dev dummy1 table local proto kernel scope host src 192.168.5.5
Deleted 7.7.7.0/24 dev dummy2 scope link src 192.168.5.5

Suggested-by: Thomas Haller <thaller@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/20230922075508.848925-1-liuhangbin@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip_fib.h     | 1 +
 net/ipv4/fib_semantics.c | 1 +
 net/ipv4/fib_trie.c      | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index f0c13864180e2..15de07d365405 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -154,6 +154,7 @@ struct fib_info {
 	int			fib_nhs;
 	bool			fib_nh_is_v6;
 	bool			nh_updated;
+	bool			pfsrc_removed;
 	struct nexthop		*nh;
 	struct rcu_head		rcu;
 	struct fib_nh		fib_nh[];
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 894d8ac6b9d0e..5eb1b8d302bbd 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1891,6 +1891,7 @@ int fib_sync_down_addr(struct net_device *dev, __be32 local)
 			continue;
 		if (fi->fib_prefsrc == local) {
 			fi->fib_flags |= RTNH_F_DEAD;
+			fi->pfsrc_removed = true;
 			ret++;
 		}
 	}
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index d13fb9e76b971..9bdfdab906fe0 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2027,6 +2027,7 @@ void fib_table_flush_external(struct fib_table *tb)
 int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 {
 	struct trie *t = (struct trie *)tb->tb_data;
+	struct nl_info info = { .nl_net = net };
 	struct key_vector *pn = t->kv;
 	unsigned long cindex = 1;
 	struct hlist_node *tmp;
@@ -2089,6 +2090,9 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 
 			fib_notify_alias_delete(net, n->key, &n->leaf, fa,
 						NULL);
+			if (fi->pfsrc_removed)
+				rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
+					  KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
 			hlist_del_rcu(&fa->fa_list);
 			fib_release_info(fa->fa_info);
 			alias_free_mem_rcu(fa);
-- 
2.40.1



