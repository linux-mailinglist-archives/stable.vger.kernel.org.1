Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117B474C2B5
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjGILXt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjGILXr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:23:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4834913D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7E3260B86
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB7FC433C7;
        Sun,  9 Jul 2023 11:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901825;
        bh=2UyzTTlTNK8wzDU/ggil5t1LtwXk2SZLmxD5TqTyWpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2A9CjtAQNvLU56V25rx6ROC1S+d30qzFEpd8rzWFXmirkpPEIPD3G7tn1dLJrEuh4
         RqaGIi/JP46tPhg5rxN16D9ihHHOpVnzK2MjSM4GjPBW4Axk6JJNppeLHGLz+uif+v
         cryFENHEWlSn5u/WT5vFqwH/wFBHBiXb/WmGXDQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Edwin Peer <edwin.peer@broadcom.com>,
        Edwin Peer <espeer@gmail.com>, Gal Pressman <gal@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 120/431] rtnetlink: extend RTEXT_FILTER_SKIP_STATS to IFLA_VF_INFO
Date:   Sun,  9 Jul 2023 13:11:08 +0200
Message-ID: <20230709111453.972105720@linuxfoundation.org>
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

From: Edwin Peer <edwin.peer@broadcom.com>

[ Upstream commit fa0e21fa44438a0e856d42224bfa24641d37b979 ]

This filter already exists for excluding IPv6 SNMP stats. Extend its
definition to also exclude IFLA_VF_INFO stats in RTM_GETLINK.

This patch constitutes a partial fix for a netlink attribute nesting
overflow bug in IFLA_VFINFO_LIST. By excluding the stats when the
requester doesn't need them, the truncation of the VF list is avoided.

While it was technically only the stats added in commit c5a9f6f0ab40
("net/core: Add drop counters to VF statistics") breaking the camel's
back, the appreciable size of the stats data should never have been
included without due consideration for the maximum number of VFs
supported by PCI.

Fixes: 3b766cd83232 ("net/core: Add reading VF statistics through the PF netdevice")
Fixes: c5a9f6f0ab40 ("net/core: Add drop counters to VF statistics")
Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
Cc: Edwin Peer <espeer@gmail.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Link: https://lore.kernel.org/r/20230611105108.122586-1-gal@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c | 96 +++++++++++++++++++++++---------------------
 1 file changed, 51 insertions(+), 45 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f235cc6832767..bbecc31a2703f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -958,24 +958,27 @@ static inline int rtnl_vfinfo_size(const struct net_device *dev,
 			 nla_total_size(sizeof(struct ifla_vf_rate)) +
 			 nla_total_size(sizeof(struct ifla_vf_link_state)) +
 			 nla_total_size(sizeof(struct ifla_vf_rss_query_en)) +
-			 nla_total_size(0) + /* nest IFLA_VF_STATS */
-			 /* IFLA_VF_STATS_RX_PACKETS */
-			 nla_total_size_64bit(sizeof(__u64)) +
-			 /* IFLA_VF_STATS_TX_PACKETS */
-			 nla_total_size_64bit(sizeof(__u64)) +
-			 /* IFLA_VF_STATS_RX_BYTES */
-			 nla_total_size_64bit(sizeof(__u64)) +
-			 /* IFLA_VF_STATS_TX_BYTES */
-			 nla_total_size_64bit(sizeof(__u64)) +
-			 /* IFLA_VF_STATS_BROADCAST */
-			 nla_total_size_64bit(sizeof(__u64)) +
-			 /* IFLA_VF_STATS_MULTICAST */
-			 nla_total_size_64bit(sizeof(__u64)) +
-			 /* IFLA_VF_STATS_RX_DROPPED */
-			 nla_total_size_64bit(sizeof(__u64)) +
-			 /* IFLA_VF_STATS_TX_DROPPED */
-			 nla_total_size_64bit(sizeof(__u64)) +
 			 nla_total_size(sizeof(struct ifla_vf_trust)));
+		if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS) {
+			size += num_vfs *
+				(nla_total_size(0) + /* nest IFLA_VF_STATS */
+				 /* IFLA_VF_STATS_RX_PACKETS */
+				 nla_total_size_64bit(sizeof(__u64)) +
+				 /* IFLA_VF_STATS_TX_PACKETS */
+				 nla_total_size_64bit(sizeof(__u64)) +
+				 /* IFLA_VF_STATS_RX_BYTES */
+				 nla_total_size_64bit(sizeof(__u64)) +
+				 /* IFLA_VF_STATS_TX_BYTES */
+				 nla_total_size_64bit(sizeof(__u64)) +
+				 /* IFLA_VF_STATS_BROADCAST */
+				 nla_total_size_64bit(sizeof(__u64)) +
+				 /* IFLA_VF_STATS_MULTICAST */
+				 nla_total_size_64bit(sizeof(__u64)) +
+				 /* IFLA_VF_STATS_RX_DROPPED */
+				 nla_total_size_64bit(sizeof(__u64)) +
+				 /* IFLA_VF_STATS_TX_DROPPED */
+				 nla_total_size_64bit(sizeof(__u64)));
+		}
 		return size;
 	} else
 		return 0;
@@ -1267,7 +1270,8 @@ static noinline_for_stack int rtnl_fill_stats(struct sk_buff *skb,
 static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
 					       struct net_device *dev,
 					       int vfs_num,
-					       struct nlattr *vfinfo)
+					       struct nlattr *vfinfo,
+					       u32 ext_filter_mask)
 {
 	struct ifla_vf_rss_query_en vf_rss_query_en;
 	struct nlattr *vf, *vfstats, *vfvlanlist;
@@ -1373,33 +1377,35 @@ static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
 		goto nla_put_vf_failure;
 	}
 	nla_nest_end(skb, vfvlanlist);
-	memset(&vf_stats, 0, sizeof(vf_stats));
-	if (dev->netdev_ops->ndo_get_vf_stats)
-		dev->netdev_ops->ndo_get_vf_stats(dev, vfs_num,
-						&vf_stats);
-	vfstats = nla_nest_start_noflag(skb, IFLA_VF_STATS);
-	if (!vfstats)
-		goto nla_put_vf_failure;
-	if (nla_put_u64_64bit(skb, IFLA_VF_STATS_RX_PACKETS,
-			      vf_stats.rx_packets, IFLA_VF_STATS_PAD) ||
-	    nla_put_u64_64bit(skb, IFLA_VF_STATS_TX_PACKETS,
-			      vf_stats.tx_packets, IFLA_VF_STATS_PAD) ||
-	    nla_put_u64_64bit(skb, IFLA_VF_STATS_RX_BYTES,
-			      vf_stats.rx_bytes, IFLA_VF_STATS_PAD) ||
-	    nla_put_u64_64bit(skb, IFLA_VF_STATS_TX_BYTES,
-			      vf_stats.tx_bytes, IFLA_VF_STATS_PAD) ||
-	    nla_put_u64_64bit(skb, IFLA_VF_STATS_BROADCAST,
-			      vf_stats.broadcast, IFLA_VF_STATS_PAD) ||
-	    nla_put_u64_64bit(skb, IFLA_VF_STATS_MULTICAST,
-			      vf_stats.multicast, IFLA_VF_STATS_PAD) ||
-	    nla_put_u64_64bit(skb, IFLA_VF_STATS_RX_DROPPED,
-			      vf_stats.rx_dropped, IFLA_VF_STATS_PAD) ||
-	    nla_put_u64_64bit(skb, IFLA_VF_STATS_TX_DROPPED,
-			      vf_stats.tx_dropped, IFLA_VF_STATS_PAD)) {
-		nla_nest_cancel(skb, vfstats);
-		goto nla_put_vf_failure;
+	if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS) {
+		memset(&vf_stats, 0, sizeof(vf_stats));
+		if (dev->netdev_ops->ndo_get_vf_stats)
+			dev->netdev_ops->ndo_get_vf_stats(dev, vfs_num,
+							  &vf_stats);
+		vfstats = nla_nest_start_noflag(skb, IFLA_VF_STATS);
+		if (!vfstats)
+			goto nla_put_vf_failure;
+		if (nla_put_u64_64bit(skb, IFLA_VF_STATS_RX_PACKETS,
+				      vf_stats.rx_packets, IFLA_VF_STATS_PAD) ||
+		    nla_put_u64_64bit(skb, IFLA_VF_STATS_TX_PACKETS,
+				      vf_stats.tx_packets, IFLA_VF_STATS_PAD) ||
+		    nla_put_u64_64bit(skb, IFLA_VF_STATS_RX_BYTES,
+				      vf_stats.rx_bytes, IFLA_VF_STATS_PAD) ||
+		    nla_put_u64_64bit(skb, IFLA_VF_STATS_TX_BYTES,
+				      vf_stats.tx_bytes, IFLA_VF_STATS_PAD) ||
+		    nla_put_u64_64bit(skb, IFLA_VF_STATS_BROADCAST,
+				      vf_stats.broadcast, IFLA_VF_STATS_PAD) ||
+		    nla_put_u64_64bit(skb, IFLA_VF_STATS_MULTICAST,
+				      vf_stats.multicast, IFLA_VF_STATS_PAD) ||
+		    nla_put_u64_64bit(skb, IFLA_VF_STATS_RX_DROPPED,
+				      vf_stats.rx_dropped, IFLA_VF_STATS_PAD) ||
+		    nla_put_u64_64bit(skb, IFLA_VF_STATS_TX_DROPPED,
+				      vf_stats.tx_dropped, IFLA_VF_STATS_PAD)) {
+			nla_nest_cancel(skb, vfstats);
+			goto nla_put_vf_failure;
+		}
+		nla_nest_end(skb, vfstats);
 	}
-	nla_nest_end(skb, vfstats);
 	nla_nest_end(skb, vf);
 	return 0;
 
@@ -1432,7 +1438,7 @@ static noinline_for_stack int rtnl_fill_vf(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	for (i = 0; i < num_vfs; i++) {
-		if (rtnl_fill_vfinfo(skb, dev, i, vfinfo))
+		if (rtnl_fill_vfinfo(skb, dev, i, vfinfo, ext_filter_mask))
 			return -EMSGSIZE;
 	}
 
-- 
2.39.2



