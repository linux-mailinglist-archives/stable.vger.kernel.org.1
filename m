Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513CC75D21B
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjGUS4G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjGUS4F (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7475C3586
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12CCE61D85
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25384C433C8;
        Fri, 21 Jul 2023 18:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965763;
        bh=5UWzVjExUpaguz9sjkC+Hv6zH81y76mv5ZV5XtxkQok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXMIGl0BE8a9oVStNXrysjeAL4ApPReS5KmW/6QyG7JmmmsdiXvGdn1xfhvgm7V0D
         +wDSz8lTfuLR0cyt75UK4umdI/ajZ7Esioyl7Bj1zhFQO9cUspjcTDC3+dS3aImenJ
         m4fBVnCbCD+Sl6VQWhN2+r54XZrLeGwC032vmInQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Edwin Peer <edwin.peer@broadcom.com>,
        Edwin Peer <espeer@gmail.com>, Gal Pressman <gal@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 067/532] rtnetlink: extend RTEXT_FILTER_SKIP_STATS to IFLA_VF_INFO
Date:   Fri, 21 Jul 2023 17:59:31 +0200
Message-ID: <20230721160618.257118012@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
index bc187289bf64b..0ab558501290b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -922,24 +922,27 @@ static inline int rtnl_vfinfo_size(const struct net_device *dev,
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
@@ -1214,7 +1217,8 @@ static noinline_for_stack int rtnl_fill_stats(struct sk_buff *skb,
 static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
 					       struct net_device *dev,
 					       int vfs_num,
-					       struct nlattr *vfinfo)
+					       struct nlattr *vfinfo,
+					       u32 ext_filter_mask)
 {
 	struct ifla_vf_rss_query_en vf_rss_query_en;
 	struct nlattr *vf, *vfstats, *vfvlanlist;
@@ -1320,33 +1324,35 @@ static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
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
 
@@ -1379,7 +1385,7 @@ static noinline_for_stack int rtnl_fill_vf(struct sk_buff *skb,
 		return -EMSGSIZE;
 
 	for (i = 0; i < num_vfs; i++) {
-		if (rtnl_fill_vfinfo(skb, dev, i, vfinfo))
+		if (rtnl_fill_vfinfo(skb, dev, i, vfinfo, ext_filter_mask))
 			return -EMSGSIZE;
 	}
 
-- 
2.39.2



