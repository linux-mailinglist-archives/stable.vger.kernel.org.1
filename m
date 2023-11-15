Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AB17ECFDE
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjKOTvY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbjKOTvW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:51:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4833419E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:51:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D545C433C9;
        Wed, 15 Nov 2023 19:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077879;
        bh=5IsOMevhfcUrMSNUhyQy+w7LpohO6m/y9+fXK92qfkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QHZAtoKLyFE7L9CykwcBMFZDvHF8f6Irs9Zf3K5tNW1G6yZOQc1MML63zSjnamxG9
         65BUkkyEqV2I9LQ0lSyUkWkevc/qgRrPDsgpVsUOG8cHz0fXDEDwXphmwS3w0oMVR/
         eHoA/eFEcXxn0GGZ12DT5Nj0QbnufdJVBCSakWVk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Blakey <paulb@nvidia.com>,
        Vlad Buslov <vladbu@nvidia.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 576/603] net/sched: act_ct: Always fill offloading tuple iifidx
Date:   Wed, 15 Nov 2023 14:18:41 -0500
Message-ID: <20231115191651.325682190@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlad Buslov <vladbu@nvidia.com>

[ Upstream commit 9bc64bd0cd765f696fcd40fc98909b1f7c73b2ba ]

Referenced commit doesn't always set iifidx when offloading the flow to
hardware. Fix the following cases:

- nf_conn_act_ct_ext_fill() is called before extension is created with
nf_conn_act_ct_ext_add() in tcf_ct_act(). This can cause rule offload with
unspecified iifidx when connection is offloaded after only single
original-direction packet has been processed by tc data path. Always fill
the new nf_conn_act_ct_ext instance after creating it in
nf_conn_act_ct_ext_add().

- Offloading of unidirectional UDP NEW connections is now supported, but ct
flow iifidx field is not updated when connection is promoted to
bidirectional which can result reply-direction iifidx to be zero when
refreshing the connection. Fill in the extension and update flow iifidx
before calling flow_offload_refresh().

Fixes: 9795ded7f924 ("net/sched: act_ct: Fill offloading tuple iifidx")
Reviewed-by: Paul Blakey <paulb@nvidia.com>
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Fixes: 6a9bad0069cf ("net/sched: act_ct: offload UDP NEW connections")
Link: https://lore.kernel.org/r/20231103151410.764271-1-vladbu@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_conntrack_act_ct.h | 30 ++++++++++++---------
 net/openvswitch/conntrack.c                 |  2 +-
 net/sched/act_ct.c                          | 15 ++++++++++-
 3 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_act_ct.h b/include/net/netfilter/nf_conntrack_act_ct.h
index 078d3c52c03f9..e5f2f0b73a9a0 100644
--- a/include/net/netfilter/nf_conntrack_act_ct.h
+++ b/include/net/netfilter/nf_conntrack_act_ct.h
@@ -20,7 +20,22 @@ static inline struct nf_conn_act_ct_ext *nf_conn_act_ct_ext_find(const struct nf
 #endif
 }
 
-static inline struct nf_conn_act_ct_ext *nf_conn_act_ct_ext_add(struct nf_conn *ct)
+static inline void nf_conn_act_ct_ext_fill(struct sk_buff *skb, struct nf_conn *ct,
+					   enum ip_conntrack_info ctinfo)
+{
+#if IS_ENABLED(CONFIG_NET_ACT_CT)
+	struct nf_conn_act_ct_ext *act_ct_ext;
+
+	act_ct_ext = nf_conn_act_ct_ext_find(ct);
+	if (dev_net(skb->dev) == &init_net && act_ct_ext)
+		act_ct_ext->ifindex[CTINFO2DIR(ctinfo)] = skb->dev->ifindex;
+#endif
+}
+
+static inline struct
+nf_conn_act_ct_ext *nf_conn_act_ct_ext_add(struct sk_buff *skb,
+					   struct nf_conn *ct,
+					   enum ip_conntrack_info ctinfo)
 {
 #if IS_ENABLED(CONFIG_NET_ACT_CT)
 	struct nf_conn_act_ct_ext *act_ct = nf_ct_ext_find(ct, NF_CT_EXT_ACT_CT);
@@ -29,22 +44,11 @@ static inline struct nf_conn_act_ct_ext *nf_conn_act_ct_ext_add(struct nf_conn *
 		return act_ct;
 
 	act_ct = nf_ct_ext_add(ct, NF_CT_EXT_ACT_CT, GFP_ATOMIC);
+	nf_conn_act_ct_ext_fill(skb, ct, ctinfo);
 	return act_ct;
 #else
 	return NULL;
 #endif
 }
 
-static inline void nf_conn_act_ct_ext_fill(struct sk_buff *skb, struct nf_conn *ct,
-					   enum ip_conntrack_info ctinfo)
-{
-#if IS_ENABLED(CONFIG_NET_ACT_CT)
-	struct nf_conn_act_ct_ext *act_ct_ext;
-
-	act_ct_ext = nf_conn_act_ct_ext_find(ct);
-	if (dev_net(skb->dev) == &init_net && act_ct_ext)
-		act_ct_ext->ifindex[CTINFO2DIR(ctinfo)] = skb->dev->ifindex;
-#endif
-}
-
 #endif /* _NF_CONNTRACK_ACT_CT_H */
diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 0b9a785dea459..3019a4406ca4f 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -985,7 +985,7 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
 		if (err)
 			return err;
 
-		nf_conn_act_ct_ext_add(ct);
+		nf_conn_act_ct_ext_add(skb, ct, ctinfo);
 	} else if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
 		   labels_nonzero(&info->labels.mask)) {
 		err = ovs_ct_set_labels(ct, key, &info->labels.value,
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index fb52d6f9aff93..3922d825ef2d8 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -376,6 +376,17 @@ static void tcf_ct_flow_tc_ifidx(struct flow_offload *entry,
 	entry->tuplehash[dir].tuple.tc.iifidx = act_ct_ext->ifindex[dir];
 }
 
+static void tcf_ct_flow_ct_ext_ifidx_update(struct flow_offload *entry)
+{
+	struct nf_conn_act_ct_ext *act_ct_ext;
+
+	act_ct_ext = nf_conn_act_ct_ext_find(entry->ct);
+	if (act_ct_ext) {
+		tcf_ct_flow_tc_ifidx(entry, act_ct_ext, FLOW_OFFLOAD_DIR_ORIGINAL);
+		tcf_ct_flow_tc_ifidx(entry, act_ct_ext, FLOW_OFFLOAD_DIR_REPLY);
+	}
+}
+
 static void tcf_ct_flow_table_add(struct tcf_ct_flow_table *ct_ft,
 				  struct nf_conn *ct,
 				  bool tcp, bool bidirectional)
@@ -671,6 +682,8 @@ static bool tcf_ct_flow_table_lookup(struct tcf_ct_params *p,
 	else
 		ctinfo = IP_CT_ESTABLISHED_REPLY;
 
+	nf_conn_act_ct_ext_fill(skb, ct, ctinfo);
+	tcf_ct_flow_ct_ext_ifidx_update(flow);
 	flow_offload_refresh(nf_ft, flow, force_refresh);
 	if (!test_bit(IPS_ASSURED_BIT, &ct->status)) {
 		/* Process this flow in SW to allow promoting to ASSURED */
@@ -1030,7 +1043,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		tcf_ct_act_set_labels(ct, p->labels, p->labels_mask);
 
 		if (!nf_ct_is_confirmed(ct))
-			nf_conn_act_ct_ext_add(ct);
+			nf_conn_act_ct_ext_add(skb, ct, ctinfo);
 
 		/* This will take care of sending queued events
 		 * even if the connection is already confirmed.
-- 
2.42.0



