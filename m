Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C67074C2A0
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjGILWs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjGILWr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:22:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5220C130
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:22:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3D2C60BB7
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76B0C433C8;
        Sun,  9 Jul 2023 11:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901765;
        bh=XOiepkwzMBJW4MFw08teIqhey++/Ws80B96dQ/1kiik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eT9VfDfJeWcogXY+3b9jTMhKQLM+c9tQthhSdOIErTgJYCP+b1IA//CaQy83OkE+X
         WBUyLxG+ByQbEcRdYvEcgU7s7ALUZSJ/MLC9RbH5Yf+m/J+vKovPQblukETYz6Q/M3
         sP2xS1xoexQDCwfHjW1eAQ9YARmfO3x7rXl0KtPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gilad Sever <gilad9366@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        Eyal Birger <eyal.birger@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Ahern <dsahern@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 137/431] bpf: Fix bpf socket lookup from tc/xdp to respect socket VRF bindings
Date:   Sun,  9 Jul 2023 13:11:25 +0200
Message-ID: <20230709111454.374305753@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gilad Sever <gilad9366@gmail.com>

[ Upstream commit 9a5cb79762e0eda17ca15c2a6eaca4622383c21c ]

When calling bpf_sk_lookup_tcp(), bpf_sk_lookup_udp() or
bpf_skc_lookup_tcp() from tc/xdp ingress, VRF socket bindings aren't
respoected, i.e. unbound sockets are returned, and bound sockets aren't
found.

VRF binding is determined by the sdif argument to sk_lookup(), however
when called from tc the IP SKB control block isn't initialized and thus
inet{,6}_sdif() always returns 0.

Fix by calculating sdif for the tc/xdp flows by observing the device's
l3 enslaved state.

The cg/sk_skb hooking points which are expected to support
inet{,6}_sdif() pass sdif=-1 which makes __bpf_skc_lookup() use the
existing logic.

Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
Signed-off-by: Gilad Sever <gilad9366@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Reviewed-by: Eyal Birger <eyal.birger@gmail.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Cc: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/bpf/20230621104211.301902-4-gilad9366@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netdevice.h |  9 +++++
 net/core/filter.c         | 69 ++++++++++++++++++++++-----------------
 2 files changed, 48 insertions(+), 30 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7ed63f5bbe056..02ac3a058c09f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5063,6 +5063,15 @@ static inline bool netif_is_l3_slave(const struct net_device *dev)
 	return dev->priv_flags & IFF_L3MDEV_SLAVE;
 }
 
+static inline int dev_sdif(const struct net_device *dev)
+{
+#ifdef CONFIG_NET_L3_MASTER_DEV
+	if (netif_is_l3_slave(dev))
+		return dev->ifindex;
+#endif
+	return 0;
+}
+
 static inline bool netif_is_bridge_master(const struct net_device *dev)
 {
 	return dev->priv_flags & IFF_EBRIDGE;
diff --git a/net/core/filter.c b/net/core/filter.c
index f43f86fc12356..ebbab8c24beaf 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6529,12 +6529,11 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 static struct sock *
 __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 		 struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
-		 u64 flags)
+		 u64 flags, int sdif)
 {
 	struct sock *sk = NULL;
 	struct net *net;
 	u8 family;
-	int sdif;
 
 	if (len == sizeof(tuple->ipv4))
 		family = AF_INET;
@@ -6546,10 +6545,12 @@ __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 	if (unlikely(flags || !((s32)netns_id < 0 || netns_id <= S32_MAX)))
 		goto out;
 
-	if (family == AF_INET)
-		sdif = inet_sdif(skb);
-	else
-		sdif = inet6_sdif(skb);
+	if (sdif < 0) {
+		if (family == AF_INET)
+			sdif = inet_sdif(skb);
+		else
+			sdif = inet6_sdif(skb);
+	}
 
 	if ((s32)netns_id < 0) {
 		net = caller_net;
@@ -6569,10 +6570,11 @@ __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 static struct sock *
 __bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 		struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
-		u64 flags)
+		u64 flags, int sdif)
 {
 	struct sock *sk = __bpf_skc_lookup(skb, tuple, len, caller_net,
-					   ifindex, proto, netns_id, flags);
+					   ifindex, proto, netns_id, flags,
+					   sdif);
 
 	if (sk) {
 		struct sock *sk2 = sk_to_full_sk(sk);
@@ -6612,7 +6614,7 @@ bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 	}
 
 	return __bpf_skc_lookup(skb, tuple, len, caller_net, ifindex, proto,
-				netns_id, flags);
+				netns_id, flags, -1);
 }
 
 static struct sock *
@@ -6704,12 +6706,13 @@ static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
 BPF_CALL_5(bpf_tc_skc_lookup_tcp, struct sk_buff *, skb,
 	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
 {
-	struct net *caller_net = dev_net(skb->dev);
-	int ifindex = skb->dev->ifindex;
+	struct net_device *dev = skb->dev;
+	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
+	struct net *caller_net = dev_net(dev);
 
 	return (unsigned long)__bpf_skc_lookup(skb, tuple, len, caller_net,
 					       ifindex, IPPROTO_TCP, netns_id,
-					       flags);
+					       flags, sdif);
 }
 
 static const struct bpf_func_proto bpf_tc_skc_lookup_tcp_proto = {
@@ -6727,12 +6730,13 @@ static const struct bpf_func_proto bpf_tc_skc_lookup_tcp_proto = {
 BPF_CALL_5(bpf_tc_sk_lookup_tcp, struct sk_buff *, skb,
 	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
 {
-	struct net *caller_net = dev_net(skb->dev);
-	int ifindex = skb->dev->ifindex;
+	struct net_device *dev = skb->dev;
+	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
+	struct net *caller_net = dev_net(dev);
 
 	return (unsigned long)__bpf_sk_lookup(skb, tuple, len, caller_net,
 					      ifindex, IPPROTO_TCP, netns_id,
-					      flags);
+					      flags, sdif);
 }
 
 static const struct bpf_func_proto bpf_tc_sk_lookup_tcp_proto = {
@@ -6750,12 +6754,13 @@ static const struct bpf_func_proto bpf_tc_sk_lookup_tcp_proto = {
 BPF_CALL_5(bpf_tc_sk_lookup_udp, struct sk_buff *, skb,
 	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
 {
-	struct net *caller_net = dev_net(skb->dev);
-	int ifindex = skb->dev->ifindex;
+	struct net_device *dev = skb->dev;
+	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
+	struct net *caller_net = dev_net(dev);
 
 	return (unsigned long)__bpf_sk_lookup(skb, tuple, len, caller_net,
 					      ifindex, IPPROTO_UDP, netns_id,
-					      flags);
+					      flags, sdif);
 }
 
 static const struct bpf_func_proto bpf_tc_sk_lookup_udp_proto = {
@@ -6787,12 +6792,13 @@ static const struct bpf_func_proto bpf_sk_release_proto = {
 BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
 	   struct bpf_sock_tuple *, tuple, u32, len, u32, netns_id, u64, flags)
 {
-	struct net *caller_net = dev_net(ctx->rxq->dev);
-	int ifindex = ctx->rxq->dev->ifindex;
+	struct net_device *dev = ctx->rxq->dev;
+	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
+	struct net *caller_net = dev_net(dev);
 
 	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len, caller_net,
 					      ifindex, IPPROTO_UDP, netns_id,
-					      flags);
+					      flags, sdif);
 }
 
 static const struct bpf_func_proto bpf_xdp_sk_lookup_udp_proto = {
@@ -6810,12 +6816,13 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_udp_proto = {
 BPF_CALL_5(bpf_xdp_skc_lookup_tcp, struct xdp_buff *, ctx,
 	   struct bpf_sock_tuple *, tuple, u32, len, u32, netns_id, u64, flags)
 {
-	struct net *caller_net = dev_net(ctx->rxq->dev);
-	int ifindex = ctx->rxq->dev->ifindex;
+	struct net_device *dev = ctx->rxq->dev;
+	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
+	struct net *caller_net = dev_net(dev);
 
 	return (unsigned long)__bpf_skc_lookup(NULL, tuple, len, caller_net,
 					       ifindex, IPPROTO_TCP, netns_id,
-					       flags);
+					       flags, sdif);
 }
 
 static const struct bpf_func_proto bpf_xdp_skc_lookup_tcp_proto = {
@@ -6833,12 +6840,13 @@ static const struct bpf_func_proto bpf_xdp_skc_lookup_tcp_proto = {
 BPF_CALL_5(bpf_xdp_sk_lookup_tcp, struct xdp_buff *, ctx,
 	   struct bpf_sock_tuple *, tuple, u32, len, u32, netns_id, u64, flags)
 {
-	struct net *caller_net = dev_net(ctx->rxq->dev);
-	int ifindex = ctx->rxq->dev->ifindex;
+	struct net_device *dev = ctx->rxq->dev;
+	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
+	struct net *caller_net = dev_net(dev);
 
 	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len, caller_net,
 					      ifindex, IPPROTO_TCP, netns_id,
-					      flags);
+					      flags, sdif);
 }
 
 static const struct bpf_func_proto bpf_xdp_sk_lookup_tcp_proto = {
@@ -6858,7 +6866,8 @@ BPF_CALL_5(bpf_sock_addr_skc_lookup_tcp, struct bpf_sock_addr_kern *, ctx,
 {
 	return (unsigned long)__bpf_skc_lookup(NULL, tuple, len,
 					       sock_net(ctx->sk), 0,
-					       IPPROTO_TCP, netns_id, flags);
+					       IPPROTO_TCP, netns_id, flags,
+					       -1);
 }
 
 static const struct bpf_func_proto bpf_sock_addr_skc_lookup_tcp_proto = {
@@ -6877,7 +6886,7 @@ BPF_CALL_5(bpf_sock_addr_sk_lookup_tcp, struct bpf_sock_addr_kern *, ctx,
 {
 	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len,
 					      sock_net(ctx->sk), 0, IPPROTO_TCP,
-					      netns_id, flags);
+					      netns_id, flags, -1);
 }
 
 static const struct bpf_func_proto bpf_sock_addr_sk_lookup_tcp_proto = {
@@ -6896,7 +6905,7 @@ BPF_CALL_5(bpf_sock_addr_sk_lookup_udp, struct bpf_sock_addr_kern *, ctx,
 {
 	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len,
 					      sock_net(ctx->sk), 0, IPPROTO_UDP,
-					      netns_id, flags);
+					      netns_id, flags, -1);
 }
 
 static const struct bpf_func_proto bpf_sock_addr_sk_lookup_udp_proto = {
-- 
2.39.2



