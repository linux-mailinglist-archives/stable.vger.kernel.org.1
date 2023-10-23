Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344E37D3447
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjJWLiG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjJWLiF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:38:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F9FE8
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:38:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B8CC433C8;
        Mon, 23 Oct 2023 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061082;
        bh=4/KJynZSiGGNp5ApYtvqixupYI2VLACAQEI0xAVC0So=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w7iZM9rcZQ4uN9k6451AhFdW1Bip51R2SO3XhZ9WNorN5dQdf1dgQ5S4aAvdH21OJ
         1/O1aN6eVfY3rA9nHtuEmeNZ9Q9TpLjzT00BrLtrYrcFCQXyyU/5iOhSXANnQ+p7Hl
         ZF30eMiVV4hJn+dNzCo7DFlhsQkw3dgNDdzcRQgE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yanguo Li <yanguo.li@corigine.com>,
        Louis Peens <louis.peens@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 066/137] nfp: flower: avoid rmmod nfp crash issues
Date:   Mon, 23 Oct 2023 12:57:03 +0200
Message-ID: <20231023104823.183372943@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yanguo Li <yanguo.li@corigine.com>

[ Upstream commit 14690995c14109852c7ba6e316045c02e4254272 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/netronome/nfp/flower/cmsg.c  | 10 ++++----
 .../ethernet/netronome/nfp/flower/conntrack.c | 19 ++++++++++-----
 .../net/ethernet/netronome/nfp/flower/main.h  |  2 ++
 .../ethernet/netronome/nfp/flower/metadata.c  |  2 ++
 .../ethernet/netronome/nfp/flower/offload.c   | 24 ++++++++++++++-----
 .../ethernet/netronome/nfp/flower/qos_conf.c  | 20 ++++++++++------
 6 files changed, 54 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/cmsg.c b/drivers/net/ethernet/netronome/nfp/flower/cmsg.c
index f21cf1f40f987..153533cd8f086 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/cmsg.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/cmsg.c
@@ -210,6 +210,7 @@ nfp_flower_cmsg_merge_hint_rx(struct nfp_app *app, struct sk_buff *skb)
 	unsigned int msg_len = nfp_flower_cmsg_get_data_len(skb);
 	struct nfp_flower_cmsg_merge_hint *msg;
 	struct nfp_fl_payload *sub_flows[2];
+	struct nfp_flower_priv *priv;
 	int err, i, flow_cnt;
 
 	msg = nfp_flower_cmsg_get_data(skb);
@@ -228,14 +229,15 @@ nfp_flower_cmsg_merge_hint_rx(struct nfp_app *app, struct sk_buff *skb)
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
 
@@ -244,8 +246,8 @@ nfp_flower_cmsg_merge_hint_rx(struct nfp_app *app, struct sk_buff *skb)
 	if (err == -ENOMEM)
 		nfp_flower_cmsg_warn(app, "Flow merge memory fail.\n");
 
-err_rtnl_unlock:
-	rtnl_unlock();
+err_mutex_unlock:
+	mutex_unlock(&priv->nfp_fl_lock);
 }
 
 static void
diff --git a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
index 7e9fcc16286e2..fc17e9b11d19d 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -1665,8 +1665,6 @@ nfp_fl_ct_offload_nft_flow(struct nfp_fl_ct_zone_entry *zt, struct flow_cls_offl
 	struct nfp_fl_ct_flow_entry *ct_entry;
 	struct netlink_ext_ack *extack = NULL;
 
-	ASSERT_RTNL();
-
 	extack = flow->common.extack;
 	switch (flow->command) {
 	case FLOW_CLS_REPLACE:
@@ -1709,9 +1707,13 @@ int nfp_fl_ct_handle_nft_flow(enum tc_setup_type type, void *type_data, void *cb
 
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
@@ -1739,6 +1741,7 @@ int nfp_fl_ct_del_flow(struct nfp_fl_ct_map_entry *ct_map_ent)
 	struct nfp_fl_ct_flow_entry *ct_entry;
 	struct nfp_fl_ct_zone_entry *zt;
 	struct rhashtable *m_table;
+	struct nf_flowtable *nft;
 
 	if (!ct_map_ent)
 		return -ENOENT;
@@ -1755,8 +1758,12 @@ int nfp_fl_ct_del_flow(struct nfp_fl_ct_map_entry *ct_map_ent)
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
diff --git a/drivers/net/ethernet/netronome/nfp/flower/main.h b/drivers/net/ethernet/netronome/nfp/flower/main.h
index 917c450a7aadd..f5222e3c8ce56 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/main.h
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.h
@@ -196,6 +196,7 @@ struct nfp_fl_internal_ports {
  * @ct_zone_table:	Hash table used to store the different zones
  * @ct_zone_wc:		Special zone entry for wildcarded zone matches
  * @ct_map_table:	Hash table used to referennce ct flows
+ * @nfp_fl_lock:	Lock to protect the flow offload operation
  */
 struct nfp_flower_priv {
 	struct nfp_app *app;
@@ -233,6 +234,7 @@ struct nfp_flower_priv {
 	struct rhashtable ct_zone_table;
 	struct nfp_fl_ct_zone_entry *ct_zone_wc;
 	struct rhashtable ct_map_table;
+	struct mutex nfp_fl_lock; /* Protect the flow operation */
 };
 
 /**
diff --git a/drivers/net/ethernet/netronome/nfp/flower/metadata.c b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
index 2af9faee96c5c..a515bd89defea 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/metadata.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
@@ -530,6 +530,8 @@ int nfp_flower_metadata_init(struct nfp_app *app, u64 host_ctx_count,
 	if (err)
 		goto err_free_stats_ctx_table;
 
+	mutex_init(&priv->nfp_fl_lock);
+
 	err = rhashtable_init(&priv->ct_zone_table, &nfp_zone_table_params);
 	if (err)
 		goto err_free_merge_table;
diff --git a/drivers/net/ethernet/netronome/nfp/flower/offload.c b/drivers/net/ethernet/netronome/nfp/flower/offload.c
index 64c0ef57ad426..d165098c457e7 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -1009,8 +1009,6 @@ int nfp_flower_merge_offloaded_flows(struct nfp_app *app,
 	u64 parent_ctx = 0;
 	int err;
 
-	ASSERT_RTNL();
-
 	if (sub_flow1 == sub_flow2 ||
 	    nfp_flower_is_merge_flow(sub_flow1) ||
 	    nfp_flower_is_merge_flow(sub_flow2))
@@ -1662,19 +1660,30 @@ static int
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
@@ -1713,6 +1722,7 @@ static int nfp_flower_setup_tc_block(struct net_device *netdev,
 	repr_priv = repr->app_priv;
 	repr_priv->block_shared = f->block_shared;
 	f->driver_block_list = &nfp_block_cb_list;
+	f->unlocked_driver_cb = true;
 
 	switch (f->command) {
 	case FLOW_BLOCK_BIND:
@@ -1811,6 +1821,8 @@ nfp_flower_setup_indr_tc_block(struct net_device *netdev, struct Qdisc *sch, str
 	     nfp_flower_internal_port_can_offload(app, netdev)))
 		return -EOPNOTSUPP;
 
+	f->unlocked_driver_cb = true;
+
 	switch (f->command) {
 	case FLOW_BLOCK_BIND:
 		cb_priv = nfp_flower_indr_block_cb_priv_lookup(app, netdev);
diff --git a/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c b/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
index 784c6dbf8bc47..577a7a534b472 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
@@ -421,23 +421,29 @@ int nfp_flower_setup_qos_offload(struct nfp_app *app, struct net_device *netdev,
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
-- 
2.40.1



