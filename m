Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAB87CA349
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjJPJEC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjJPJEC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:04:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8B695
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:04:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52686C433C8;
        Mon, 16 Oct 2023 09:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697447040;
        bh=5oWpfM3i+GqZLikG6KqG8xhNf9gPrljuhFAhi4hxmPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJCbnLOWrc5/boqWYfL3H3jLrdzr7NGgwVvnDks/HtBDtjrjXQfSLAI1Ktpe5WfZC
         t5raQLROHZkIr7C1qf8wGG87e2PzLIttOC+DvXQCH4+5KQz2JHzOth7zyE0ZvLO8Wa
         OkdAHkc/DUTfRfsVNAL6EOqAXobqc+jrBAV/y5yI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yanguo Li <yanguo.li@corigine.com>,
        Louis Peens <louis.peens@corigine.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 113/131] nfp: flower: avoid rmmod nfp crash issues
Date:   Mon, 16 Oct 2023 10:41:36 +0200
Message-ID: <20231016084002.874269602@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yanguo Li <yanguo.li@corigine.com>

commit 14690995c14109852c7ba6e316045c02e4254272 upstream.

When there are CT table entries, and you rmmod nfp, the following
events can happen:

task1：
    nfp_net_pci_remove
          ↓
    nfp_flower_stop->(asynchronous)tcf_ct_flow_table_cleanup_work(3)
          ↓
    nfp_zone_table_entry_destroy(1)

task2：
    nfp_fl_ct_handle_nft_flow(2)

When the execution order is (1)->(2)->(3), it will crash. Therefore, in
the function nfp_fl_ct_del_flow, nf_flow_table_offload_del_cb needs to
be executed synchronously.

At the same time, in order to solve the deadlock problem and the problem
of rtnl_lock sometimes failing, replace rtnl_lock with the private
nfp_fl_lock.

Fixes: 7cc93d888df7 ("nfp: flower-ct: remove callback delete deadlock")
Cc: stable@vger.kernel.org
Signed-off-by: Yanguo Li <yanguo.li@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/cmsg.c      |   10 ++++---
 drivers/net/ethernet/netronome/nfp/flower/conntrack.c |   19 +++++++++-----
 drivers/net/ethernet/netronome/nfp/flower/main.h      |    2 +
 drivers/net/ethernet/netronome/nfp/flower/metadata.c  |    2 +
 drivers/net/ethernet/netronome/nfp/flower/offload.c   |   24 +++++++++++++-----
 drivers/net/ethernet/netronome/nfp/flower/qos_conf.c  |   20 +++++++++------
 6 files changed, 54 insertions(+), 23 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/flower/cmsg.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/cmsg.c
@@ -210,6 +210,7 @@ nfp_flower_cmsg_merge_hint_rx(struct nfp
 	unsigned int msg_len = nfp_flower_cmsg_get_data_len(skb);
 	struct nfp_flower_cmsg_merge_hint *msg;
 	struct nfp_fl_payload *sub_flows[2];
+	struct nfp_flower_priv *priv;
 	int err, i, flow_cnt;
 
 	msg = nfp_flower_cmsg_get_data(skb);
@@ -228,14 +229,15 @@ nfp_flower_cmsg_merge_hint_rx(struct nfp
 		return;
 	}
 
-	rtnl_lock();
+	priv = app->priv;
+	mutex_lock(&priv->nfp_fl_lock);
 	for (i = 0; i < flow_cnt; i++) {
 		u32 ctx = be32_to_cpu(msg->flow[i].host_ctx);
 
 		sub_flows[i] = nfp_flower_get_fl_payload_from_ctx(app, ctx);
 		if (!sub_flows[i]) {
 			nfp_flower_cmsg_warn(app, "Invalid flow in merge hint\n");
-			goto err_rtnl_unlock;
+			goto err_mutex_unlock;
 		}
 	}
 
@@ -244,8 +246,8 @@ nfp_flower_cmsg_merge_hint_rx(struct nfp
 	if (err == -ENOMEM)
 		nfp_flower_cmsg_warn(app, "Flow merge memory fail.\n");
 
-err_rtnl_unlock:
-	rtnl_unlock();
+err_mutex_unlock:
+	mutex_unlock(&priv->nfp_fl_lock);
 }
 
 static void
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -1971,8 +1971,6 @@ nfp_fl_ct_offload_nft_flow(struct nfp_fl
 	struct nfp_fl_ct_flow_entry *ct_entry;
 	struct netlink_ext_ack *extack = NULL;
 
-	ASSERT_RTNL();
-
 	extack = flow->common.extack;
 	switch (flow->command) {
 	case FLOW_CLS_REPLACE:
@@ -2015,9 +2013,13 @@ int nfp_fl_ct_handle_nft_flow(enum tc_se
 
 	switch (type) {
 	case TC_SETUP_CLSFLOWER:
-		rtnl_lock();
+		while (!mutex_trylock(&zt->priv->nfp_fl_lock)) {
+			if (!zt->nft) /* avoid deadlock */
+				return err;
+			msleep(20);
+		}
 		err = nfp_fl_ct_offload_nft_flow(zt, flow);
-		rtnl_unlock();
+		mutex_unlock(&zt->priv->nfp_fl_lock);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -2045,6 +2047,7 @@ int nfp_fl_ct_del_flow(struct nfp_fl_ct_
 	struct nfp_fl_ct_flow_entry *ct_entry;
 	struct nfp_fl_ct_zone_entry *zt;
 	struct rhashtable *m_table;
+	struct nf_flowtable *nft;
 
 	if (!ct_map_ent)
 		return -ENOENT;
@@ -2061,8 +2064,12 @@ int nfp_fl_ct_del_flow(struct nfp_fl_ct_
 		nfp_fl_ct_clean_flow_entry(ct_entry);
 		kfree(ct_map_ent);
 
-		if (!zt->pre_ct_count) {
-			zt->nft = NULL;
+		if (!zt->pre_ct_count && zt->nft) {
+			nft = zt->nft;
+			zt->nft = NULL; /* avoid deadlock */
+			nf_flow_table_offload_del_cb(nft,
+						     nfp_fl_ct_handle_nft_flow,
+						     zt);
 			nfp_fl_ct_clean_nft_entries(zt);
 		}
 		break;
--- a/drivers/net/ethernet/netronome/nfp/flower/main.h
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.h
@@ -281,6 +281,7 @@ struct nfp_fl_internal_ports {
  * @predt_list:		List to keep track of decap pretun flows
  * @neigh_table:	Table to keep track of neighbor entries
  * @predt_lock:		Lock to serialise predt/neigh table updates
+ * @nfp_fl_lock:	Lock to protect the flow offload operation
  */
 struct nfp_flower_priv {
 	struct nfp_app *app;
@@ -323,6 +324,7 @@ struct nfp_flower_priv {
 	struct list_head predt_list;
 	struct rhashtable neigh_table;
 	spinlock_t predt_lock; /* Lock to serialise predt/neigh table updates */
+	struct mutex nfp_fl_lock; /* Protect the flow operation */
 };
 
 /**
--- a/drivers/net/ethernet/netronome/nfp/flower/metadata.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
@@ -528,6 +528,8 @@ int nfp_flower_metadata_init(struct nfp_
 	if (err)
 		goto err_free_stats_ctx_table;
 
+	mutex_init(&priv->nfp_fl_lock);
+
 	err = rhashtable_init(&priv->ct_zone_table, &nfp_zone_table_params);
 	if (err)
 		goto err_free_merge_table;
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -1009,8 +1009,6 @@ int nfp_flower_merge_offloaded_flows(str
 	u64 parent_ctx = 0;
 	int err;
 
-	ASSERT_RTNL();
-
 	if (sub_flow1 == sub_flow2 ||
 	    nfp_flower_is_merge_flow(sub_flow1) ||
 	    nfp_flower_is_merge_flow(sub_flow2))
@@ -1727,19 +1725,30 @@ static int
 nfp_flower_repr_offload(struct nfp_app *app, struct net_device *netdev,
 			struct flow_cls_offload *flower)
 {
+	struct nfp_flower_priv *priv = app->priv;
+	int ret;
+
 	if (!eth_proto_is_802_3(flower->common.protocol))
 		return -EOPNOTSUPP;
 
+	mutex_lock(&priv->nfp_fl_lock);
 	switch (flower->command) {
 	case FLOW_CLS_REPLACE:
-		return nfp_flower_add_offload(app, netdev, flower);
+		ret = nfp_flower_add_offload(app, netdev, flower);
+		break;
 	case FLOW_CLS_DESTROY:
-		return nfp_flower_del_offload(app, netdev, flower);
+		ret = nfp_flower_del_offload(app, netdev, flower);
+		break;
 	case FLOW_CLS_STATS:
-		return nfp_flower_get_stats(app, netdev, flower);
+		ret = nfp_flower_get_stats(app, netdev, flower);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+	mutex_unlock(&priv->nfp_fl_lock);
+
+	return ret;
 }
 
 static int nfp_flower_setup_tc_block_cb(enum tc_setup_type type,
@@ -1778,6 +1787,7 @@ static int nfp_flower_setup_tc_block(str
 	repr_priv = repr->app_priv;
 	repr_priv->block_shared = f->block_shared;
 	f->driver_block_list = &nfp_block_cb_list;
+	f->unlocked_driver_cb = true;
 
 	switch (f->command) {
 	case FLOW_BLOCK_BIND:
@@ -1876,6 +1886,8 @@ nfp_flower_setup_indr_tc_block(struct ne
 	     nfp_flower_internal_port_can_offload(app, netdev)))
 		return -EOPNOTSUPP;
 
+	f->unlocked_driver_cb = true;
+
 	switch (f->command) {
 	case FLOW_BLOCK_BIND:
 		cb_priv = nfp_flower_indr_block_cb_priv_lookup(app, netdev);
--- a/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
@@ -523,25 +523,31 @@ int nfp_flower_setup_qos_offload(struct
 {
 	struct netlink_ext_ack *extack = flow->common.extack;
 	struct nfp_flower_priv *fl_priv = app->priv;
+	int ret;
 
 	if (!(fl_priv->flower_ext_feats & NFP_FL_FEATS_VF_RLIM)) {
 		NL_SET_ERR_MSG_MOD(extack, "unsupported offload: loaded firmware does not support qos rate limit offload");
 		return -EOPNOTSUPP;
 	}
 
+	mutex_lock(&fl_priv->nfp_fl_lock);
 	switch (flow->command) {
 	case TC_CLSMATCHALL_REPLACE:
-		return nfp_flower_install_rate_limiter(app, netdev, flow,
-						       extack);
+		ret = nfp_flower_install_rate_limiter(app, netdev, flow, extack);
+		break;
 	case TC_CLSMATCHALL_DESTROY:
-		return nfp_flower_remove_rate_limiter(app, netdev, flow,
-						      extack);
+		ret = nfp_flower_remove_rate_limiter(app, netdev, flow, extack);
+		break;
 	case TC_CLSMATCHALL_STATS:
-		return nfp_flower_stats_rate_limiter(app, netdev, flow,
-						     extack);
+		ret = nfp_flower_stats_rate_limiter(app, netdev, flow, extack);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+	mutex_unlock(&fl_priv->nfp_fl_lock);
+
+	return ret;
 }
 
 /* Offload tc action, currently only for tc police */


