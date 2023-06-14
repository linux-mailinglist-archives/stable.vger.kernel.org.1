Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D3D726B0A
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjFGUWH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjFGUVx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:21:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F652689
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C9BA63632
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33436C433EF;
        Wed,  7 Jun 2023 20:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169284;
        bh=BGZGNcYlX0nMl5+QDVwH6wVLNFx2RivL9h68NlDw8F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYHNmwIH5XZADg273xbETjML8r2BRruvpPasAu/WtNI0Nm6lJxAkIbAAuVs2Xv4bd
         ROFTsiFPF9pUSrVhzJJsMD8jVRDQUp/95aka8khfnZAcq8aLnxpBkjI3mKJ7KgmlHu
         Ocf7SZM+eWmQrMsz7AvfzB/CDR0pNhE72TaNylVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Mi <cmi@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 022/286] net/mlx5e: Extract remaining tunnel encap code to dedicated file
Date:   Wed,  7 Jun 2023 22:12:01 +0200
Message-ID: <20230607200923.740496737@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chris Mi <cmi@nvidia.com>

[ Upstream commit e2ab5aa11f191b54514f063a5b5c29f3559f4ab7 ]

Move set_encap_dests() and clean_encap_dests() to the tunnel encap
dedicated file. And rename them to mlx5e_tc_tun_encap_dests_set()
and mlx5e_tc_tun_encap_dests_unset().

No functional change in this patch. It is needed in the next patch.

Signed-off-by: Chris Mi <cmi@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Stable-dep-of: 37c3b9fa7ccf ("net/mlx5e: Prevent encap offload when neigh update is running")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/en/tc_tun_encap.c      | 83 +++++++++++++++++
 .../mellanox/mlx5/core/en/tc_tun_encap.h      |  9 ++
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 89 +------------------
 3 files changed, 94 insertions(+), 87 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index fbb392d54fa51..7655526222570 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -985,6 +985,89 @@ int mlx5e_attach_decap(struct mlx5e_priv *priv,
 	return err;
 }
 
+int mlx5e_tc_tun_encap_dests_set(struct mlx5e_priv *priv,
+				 struct mlx5e_tc_flow *flow,
+				 struct mlx5_flow_attr *attr,
+				 struct netlink_ext_ack *extack,
+				 bool *vf_tun)
+{
+	struct mlx5e_tc_flow_parse_attr *parse_attr;
+	struct mlx5_esw_flow_attr *esw_attr;
+	struct net_device *encap_dev = NULL;
+	struct mlx5e_rep_priv *rpriv;
+	struct mlx5e_priv *out_priv;
+	int out_index;
+	int err = 0;
+
+	if (!mlx5e_is_eswitch_flow(flow))
+		return 0;
+
+	parse_attr = attr->parse_attr;
+	esw_attr = attr->esw_attr;
+	*vf_tun = false;
+
+	for (out_index = 0; out_index < MLX5_MAX_FLOW_FWD_VPORTS; out_index++) {
+		struct net_device *out_dev;
+		int mirred_ifindex;
+
+		if (!(esw_attr->dests[out_index].flags & MLX5_ESW_DEST_ENCAP))
+			continue;
+
+		mirred_ifindex = parse_attr->mirred_ifindex[out_index];
+		out_dev = dev_get_by_index(dev_net(priv->netdev), mirred_ifindex);
+		if (!out_dev) {
+			NL_SET_ERR_MSG_MOD(extack, "Requested mirred device not found");
+			err = -ENODEV;
+			goto out;
+		}
+		err = mlx5e_attach_encap(priv, flow, attr, out_dev, out_index,
+					 extack, &encap_dev);
+		dev_put(out_dev);
+		if (err)
+			goto out;
+
+		if (esw_attr->dests[out_index].flags &
+		    MLX5_ESW_DEST_CHAIN_WITH_SRC_PORT_CHANGE &&
+		    !esw_attr->dest_int_port)
+			*vf_tun = true;
+
+		out_priv = netdev_priv(encap_dev);
+		rpriv = out_priv->ppriv;
+		esw_attr->dests[out_index].rep = rpriv->rep;
+		esw_attr->dests[out_index].mdev = out_priv->mdev;
+	}
+
+	if (*vf_tun && esw_attr->out_count > 1) {
+		NL_SET_ERR_MSG_MOD(extack, "VF tunnel encap with mirroring is not supported");
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+out:
+	return err;
+}
+
+void mlx5e_tc_tun_encap_dests_unset(struct mlx5e_priv *priv,
+				    struct mlx5e_tc_flow *flow,
+				    struct mlx5_flow_attr *attr)
+{
+	struct mlx5_esw_flow_attr *esw_attr;
+	int out_index;
+
+	if (!mlx5e_is_eswitch_flow(flow))
+		return;
+
+	esw_attr = attr->esw_attr;
+
+	for (out_index = 0; out_index < MLX5_MAX_FLOW_FWD_VPORTS; out_index++) {
+		if (!(esw_attr->dests[out_index].flags & MLX5_ESW_DEST_ENCAP))
+			continue;
+
+		mlx5e_detach_encap(flow->priv, flow, attr, out_index);
+		kfree(attr->parse_attr->tun_info[out_index]);
+	}
+}
+
 static int cmp_route_info(struct mlx5e_route_key *a,
 			  struct mlx5e_route_key *b)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.h
index 8ad273dde40ee..5d7d67687cbcd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.h
@@ -30,6 +30,15 @@ int mlx5e_attach_decap_route(struct mlx5e_priv *priv,
 void mlx5e_detach_decap_route(struct mlx5e_priv *priv,
 			      struct mlx5e_tc_flow *flow);
 
+int mlx5e_tc_tun_encap_dests_set(struct mlx5e_priv *priv,
+				 struct mlx5e_tc_flow *flow,
+				 struct mlx5_flow_attr *attr,
+				 struct netlink_ext_ack *extack,
+				 bool *vf_tun);
+void mlx5e_tc_tun_encap_dests_unset(struct mlx5e_priv *priv,
+				    struct mlx5e_tc_flow *flow,
+				    struct mlx5_flow_attr *attr);
+
 struct ip_tunnel_info *mlx5e_dup_tun_info(const struct ip_tunnel_info *tun_info);
 
 int mlx5e_tc_set_attr_rx_tun(struct mlx5e_tc_flow *flow,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 3827dbc2b39c5..b5d23b159f345 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1727,91 +1727,6 @@ int mlx5e_tc_query_route_vport(struct net_device *out_dev, struct net_device *ro
 	return mlx5_eswitch_vhca_id_to_vport(esw, vhca_id, vport);
 }
 
-static int
-set_encap_dests(struct mlx5e_priv *priv,
-		struct mlx5e_tc_flow *flow,
-		struct mlx5_flow_attr *attr,
-		struct netlink_ext_ack *extack,
-		bool *vf_tun)
-{
-	struct mlx5e_tc_flow_parse_attr *parse_attr;
-	struct mlx5_esw_flow_attr *esw_attr;
-	struct net_device *encap_dev = NULL;
-	struct mlx5e_rep_priv *rpriv;
-	struct mlx5e_priv *out_priv;
-	int out_index;
-	int err = 0;
-
-	if (!mlx5e_is_eswitch_flow(flow))
-		return 0;
-
-	parse_attr = attr->parse_attr;
-	esw_attr = attr->esw_attr;
-	*vf_tun = false;
-
-	for (out_index = 0; out_index < MLX5_MAX_FLOW_FWD_VPORTS; out_index++) {
-		struct net_device *out_dev;
-		int mirred_ifindex;
-
-		if (!(esw_attr->dests[out_index].flags & MLX5_ESW_DEST_ENCAP))
-			continue;
-
-		mirred_ifindex = parse_attr->mirred_ifindex[out_index];
-		out_dev = dev_get_by_index(dev_net(priv->netdev), mirred_ifindex);
-		if (!out_dev) {
-			NL_SET_ERR_MSG_MOD(extack, "Requested mirred device not found");
-			err = -ENODEV;
-			goto out;
-		}
-		err = mlx5e_attach_encap(priv, flow, attr, out_dev, out_index,
-					 extack, &encap_dev);
-		dev_put(out_dev);
-		if (err)
-			goto out;
-
-		if (esw_attr->dests[out_index].flags &
-		    MLX5_ESW_DEST_CHAIN_WITH_SRC_PORT_CHANGE &&
-		    !esw_attr->dest_int_port)
-			*vf_tun = true;
-
-		out_priv = netdev_priv(encap_dev);
-		rpriv = out_priv->ppriv;
-		esw_attr->dests[out_index].rep = rpriv->rep;
-		esw_attr->dests[out_index].mdev = out_priv->mdev;
-	}
-
-	if (*vf_tun && esw_attr->out_count > 1) {
-		NL_SET_ERR_MSG_MOD(extack, "VF tunnel encap with mirroring is not supported");
-		err = -EOPNOTSUPP;
-		goto out;
-	}
-
-out:
-	return err;
-}
-
-static void
-clean_encap_dests(struct mlx5e_priv *priv,
-		  struct mlx5e_tc_flow *flow,
-		  struct mlx5_flow_attr *attr)
-{
-	struct mlx5_esw_flow_attr *esw_attr;
-	int out_index;
-
-	if (!mlx5e_is_eswitch_flow(flow))
-		return;
-
-	esw_attr = attr->esw_attr;
-
-	for (out_index = 0; out_index < MLX5_MAX_FLOW_FWD_VPORTS; out_index++) {
-		if (!(esw_attr->dests[out_index].flags & MLX5_ESW_DEST_ENCAP))
-			continue;
-
-		mlx5e_detach_encap(priv, flow, attr, out_index);
-		kfree(attr->parse_attr->tun_info[out_index]);
-	}
-}
-
 static int
 verify_attr_actions(u32 actions, struct netlink_ext_ack *extack)
 {
@@ -1848,7 +1763,7 @@ post_process_attr(struct mlx5e_tc_flow *flow,
 	if (err)
 		goto err_out;
 
-	err = set_encap_dests(flow->priv, flow, attr, extack, &vf_tun);
+	err = mlx5e_tc_tun_encap_dests_set(flow->priv, flow, attr, extack, &vf_tun);
 	if (err)
 		goto err_out;
 
@@ -4439,7 +4354,7 @@ mlx5_free_flow_attr_actions(struct mlx5e_tc_flow *flow, struct mlx5_flow_attr *a
 	if (attr->post_act_handle)
 		mlx5e_tc_post_act_del(get_post_action(flow->priv), attr->post_act_handle);
 
-	clean_encap_dests(flow->priv, flow, attr);
+	mlx5e_tc_tun_encap_dests_unset(flow->priv, flow, attr);
 
 	if (attr->action & MLX5_FLOW_CONTEXT_ACTION_COUNT)
 		mlx5_fc_destroy(counter_dev, attr->counter);
-- 
2.39.2



