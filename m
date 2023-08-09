Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A80F775B97
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjHILS7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjHILS7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:18:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE02ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:18:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EA0663193
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E38EC433C7;
        Wed,  9 Aug 2023 11:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579937;
        bh=IZHb1zt9D0xRB5bklRHdIbvHTe+HbSuKK2gMtrmcaUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QNjeV0vCnE+IpZwynV2A4A6b1O9Oc2HdzaKcDdR8OHDowhcystVuwxqzEokqrTWS5
         qMD1dRMXh+CxUEp6ZyzfFRt8+u0BiNTXDBVwVpPeP9K3hx5VbLFsKp4Pg9DtpAJsBH
         MqBNaS1jQGnDvqjsiVrBfyRktlG/ZYWu/OHkTc5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephen Suryaputra <ssuryaextr@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 139/323] vrf: Increment Icmp6InMsgs on the original netdev
Date:   Wed,  9 Aug 2023 12:39:37 +0200
Message-ID: <20230809103704.504527435@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stephen Suryaputra <ssuryaextr@gmail.com>

[ Upstream commit e1ae5c2ea4783b1fd87be250f9fcc9d9e1a6ba3f ]

Get the ingress interface and increment ICMP counters based on that
instead of skb->dev when the the dev is a VRF device.

This is a follow up on the following message:
https://www.spinics.net/lists/netdev/msg560268.html

v2: Avoid changing skb->dev since it has unintended effect for local
    delivery (David Ahern).
Signed-off-by: Stephen Suryaputra <ssuryaextr@gmail.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 2aaa8a15de73 ("icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev in icmp6_dev().")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/addrconf.h | 16 ++++++++++++++++
 net/ipv6/icmp.c        | 17 +++++++++++------
 net/ipv6/reassembly.c  |  4 ++--
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index db2a87981dd46..9583d3bbab039 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -340,6 +340,22 @@ static inline struct inet6_dev *__in6_dev_get(const struct net_device *dev)
 	return rcu_dereference_rtnl(dev->ip6_ptr);
 }
 
+/**
+ * __in6_dev_stats_get - get inet6_dev pointer for stats
+ * @dev: network device
+ * @skb: skb for original incoming interface if neeeded
+ *
+ * Caller must hold rcu_read_lock or RTNL, because this function
+ * does not take a reference on the inet6_dev.
+ */
+static inline struct inet6_dev *__in6_dev_stats_get(const struct net_device *dev,
+						    const struct sk_buff *skb)
+{
+	if (netif_is_l3_master(dev))
+		dev = dev_get_by_index_rcu(dev_net(dev), inet6_iif(skb));
+	return __in6_dev_get(dev);
+}
+
 /**
  * __in6_dev_get_safely - get inet6_dev pointer from netdevice
  * @dev: network device
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index fbc8746371b6d..1b86a2e03d049 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -395,23 +395,28 @@ static struct dst_entry *icmpv6_route_lookup(struct net *net,
 	return ERR_PTR(err);
 }
 
-static int icmp6_iif(const struct sk_buff *skb)
+static struct net_device *icmp6_dev(const struct sk_buff *skb)
 {
-	int iif = skb->dev->ifindex;
+	struct net_device *dev = skb->dev;
 
 	/* for local traffic to local address, skb dev is the loopback
 	 * device. Check if there is a dst attached to the skb and if so
 	 * get the real device index. Same is needed for replies to a link
 	 * local address on a device enslaved to an L3 master device
 	 */
-	if (unlikely(iif == LOOPBACK_IFINDEX || netif_is_l3_master(skb->dev))) {
+	if (unlikely(dev->ifindex == LOOPBACK_IFINDEX || netif_is_l3_master(skb->dev))) {
 		const struct rt6_info *rt6 = skb_rt6_info(skb);
 
 		if (rt6)
-			iif = rt6->rt6i_idev->dev->ifindex;
+			dev = rt6->rt6i_idev->dev;
 	}
 
-	return iif;
+	return dev;
+}
+
+static int icmp6_iif(const struct sk_buff *skb)
+{
+	return icmp6_dev(skb)->ifindex;
 }
 
 /*
@@ -800,7 +805,7 @@ void icmpv6_notify(struct sk_buff *skb, u8 type, u8 code, __be32 info)
 static int icmpv6_rcv(struct sk_buff *skb)
 {
 	struct net *net = dev_net(skb->dev);
-	struct net_device *dev = skb->dev;
+	struct net_device *dev = icmp6_dev(skb);
 	struct inet6_dev *idev = __in6_dev_get(dev);
 	const struct in6_addr *saddr, *daddr;
 	struct icmp6hdr *hdr;
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 60dfd0d118512..b596727f04978 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -302,7 +302,7 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 			   skb_network_header_len(skb));
 
 	rcu_read_lock();
-	__IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_REASMOKS);
+	__IP6_INC_STATS(net, __in6_dev_stats_get(dev, skb), IPSTATS_MIB_REASMOKS);
 	rcu_read_unlock();
 	fq->q.fragments = NULL;
 	fq->q.rb_fragments = RB_ROOT;
@@ -317,7 +317,7 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 	net_dbg_ratelimited("ip6_frag_reasm: no memory for reassembly\n");
 out_fail:
 	rcu_read_lock();
-	__IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_REASMFAILS);
+	__IP6_INC_STATS(net, __in6_dev_stats_get(dev, skb), IPSTATS_MIB_REASMFAILS);
 	rcu_read_unlock();
 	inet_frag_kill(&fq->q);
 	return -1;
-- 
2.39.2



