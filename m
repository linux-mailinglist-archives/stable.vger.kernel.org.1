Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A649377576A
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjHIKpp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjHIKpo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:45:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30341999
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:45:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8658563125
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DC2C433C9;
        Wed,  9 Aug 2023 10:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577942;
        bh=IdPYxE3rnXKGD8RBOgRnnTEWuyQ3GLKbnwT/hrjUSR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otOlt00XsIqys4omQ96HN+50DFHP/1jzzPnNDSbPYj9awRMwTI1OLV2act3E6mwzF
         xDlgLu2Vp7oZ0EPJIcaO7QXAHC/DMOkTAhzYpFCF+kmelnUiiX5cGBg2YAkw24x225
         yBPsSJ1bKySlFoo4cDKxeDBFoORu2ZH4tPATZsKs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gal Pressman <gal@nvidia.com>,
        Richard Gobert <richardbgobert@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 050/165] net: gro: fix misuse of CB in udp socket lookup
Date:   Wed,  9 Aug 2023 12:39:41 +0200
Message-ID: <20230809103644.458629235@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
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

From: Richard Gobert <richardbgobert@gmail.com>

[ Upstream commit 7938cd15436873f649f31cb867bac2d88ca564d0 ]

This patch fixes a misuse of IP{6}CB(skb) in GRO, while calling to
`udp6_lib_lookup2` when handling udp tunnels. `udp6_lib_lookup2` fetch the
device from CB. The fix changes it to fetch the device from `skb->dev`.
l3mdev case requires special attention since it has a master and a slave
device.

Fixes: a6024562ffd7 ("udp: Add GRO functions to UDP socket")
Reported-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/gro.h      | 43 ++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/udp.c         |  8 ++++++--
 net/ipv4/udp_offload.c |  7 +++++--
 net/ipv6/udp.c         |  8 ++++++--
 net/ipv6/udp_offload.c |  7 +++++--
 5 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 972ff42d3a829..d3d318e7d917b 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -446,6 +446,49 @@ static inline void gro_normal_one(struct napi_struct *napi, struct sk_buff *skb,
 		gro_normal_list(napi);
 }
 
+/* This function is the alternative of 'inet_iif' and 'inet_sdif'
+ * functions in case we can not rely on fields of IPCB.
+ *
+ * The caller must verify skb_valid_dst(skb) is false and skb->dev is initialized.
+ * The caller must hold the RCU read lock.
+ */
+static inline void inet_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif)
+{
+	*iif = inet_iif(skb) ?: skb->dev->ifindex;
+	*sdif = 0;
+
+#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
+	if (netif_is_l3_slave(skb->dev)) {
+		struct net_device *master = netdev_master_upper_dev_get_rcu(skb->dev);
+
+		*sdif = *iif;
+		*iif = master ? master->ifindex : 0;
+	}
+#endif
+}
+
+/* This function is the alternative of 'inet6_iif' and 'inet6_sdif'
+ * functions in case we can not rely on fields of IP6CB.
+ *
+ * The caller must verify skb_valid_dst(skb) is false and skb->dev is initialized.
+ * The caller must hold the RCU read lock.
+ */
+static inline void inet6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif)
+{
+	/* using skb->dev->ifindex because skb_dst(skb) is not initialized */
+	*iif = skb->dev->ifindex;
+	*sdif = 0;
+
+#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
+	if (netif_is_l3_slave(skb->dev)) {
+		struct net_device *master = netdev_master_upper_dev_get_rcu(skb->dev);
+
+		*sdif = *iif;
+		*iif = master ? master->ifindex : 0;
+	}
+#endif
+}
+
 extern struct list_head offload_base;
 
 #endif /* _NET_IPV6_GRO_H */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c6b790001aa77..6d327d6d978c5 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -114,6 +114,7 @@
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
 #include <net/udp_tunnel.h>
+#include <net/gro.h>
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ipv6_stubs.h>
 #endif
@@ -555,10 +556,13 @@ struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
 {
 	const struct iphdr *iph = ip_hdr(skb);
 	struct net *net = dev_net(skb->dev);
+	int iif, sdif;
+
+	inet_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp4_lib_lookup(net, iph->saddr, sport,
-				 iph->daddr, dport, inet_iif(skb),
-				 inet_sdif(skb), net->ipv4.udp_table, NULL);
+				 iph->daddr, dport, iif,
+				 sdif, net->ipv4.udp_table, NULL);
 }
 
 /* Must be called under rcu_read_lock().
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index f402946da344b..0f46b3c2e4ac5 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -609,10 +609,13 @@ static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 {
 	const struct iphdr *iph = skb_gro_network_header(skb);
 	struct net *net = dev_net(skb->dev);
+	int iif, sdif;
+
+	inet_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp4_lib_lookup(net, iph->saddr, sport,
-				 iph->daddr, dport, inet_iif(skb),
-				 inet_sdif(skb), net->ipv4.udp_table, NULL);
+				 iph->daddr, dport, iif,
+				 sdif, net->ipv4.udp_table, NULL);
 }
 
 INDIRECT_CALLABLE_SCOPE
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index d594a0425749b..27292d44df654 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -51,6 +51,7 @@
 #include <net/inet6_hashtables.h>
 #include <net/busy_poll.h>
 #include <net/sock_reuseport.h>
+#include <net/gro.h>
 
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -300,10 +301,13 @@ struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
 {
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
 	struct net *net = dev_net(skb->dev);
+	int iif, sdif;
+
+	inet6_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp6_lib_lookup(net, &iph->saddr, sport,
-				 &iph->daddr, dport, inet6_iif(skb),
-				 inet6_sdif(skb), net->ipv4.udp_table, NULL);
+				 &iph->daddr, dport, iif,
+				 sdif, net->ipv4.udp_table, NULL);
 }
 
 /* Must be called under rcu_read_lock().
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 09fa7a42cb937..6b95ba241ebe2 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -118,10 +118,13 @@ static struct sock *udp6_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 {
 	const struct ipv6hdr *iph = skb_gro_network_header(skb);
 	struct net *net = dev_net(skb->dev);
+	int iif, sdif;
+
+	inet6_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp6_lib_lookup(net, &iph->saddr, sport,
-				 &iph->daddr, dport, inet6_iif(skb),
-				 inet6_sdif(skb), net->ipv4.udp_table, NULL);
+				 &iph->daddr, dport, iif,
+				 sdif, net->ipv4.udp_table, NULL);
 }
 
 INDIRECT_CALLABLE_SCOPE
-- 
2.40.1



