Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C037A399E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbjIQTwA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbjIQTvc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:51:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549FB12F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:51:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838E5C433C7;
        Sun, 17 Sep 2023 19:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980286;
        bh=jKpJZIi0QLb84HiPsYwdr5+LSl2xwbRqFozdHBZVC74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ac3gcKEysn0OHa/F1Q9k86lo4jbUYxQOK3VpTbl26KfFc35Gobqj3T/VLMVP+Agor
         661dVtcxbBXt/0Lwcs3UoZoUDwqZSF7gHh6qGAbF725kcAnct/6eAc6Zwrd5bN0L1b
         IiH8loE/HVFV+zPMhH99nlehCHQtqXp2a6OoZwss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jianbo Liu <jianbol@nvidia.com>,
        Vlad Buslov <vladbu@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 148/285] net/mlx5e: Clear mirred devices array if the rule is split
Date:   Sun, 17 Sep 2023 21:12:28 +0200
Message-ID: <20230917191056.811248208@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit b7558a77529fef60e7992f40fb5353fed8be0cf8 ]

In the cited commit, the mirred devices are recorded and checked while
parsing the actions. In order to avoid system crash, the duplicate
action in a single rule is not allowed.

But the rule is actually break down into several FTEs in different
tables, for either mirroring, or the specified types of actions which
use post action infrastructure.

It will reject certain action list by mistake, for example:
    actions:enp8s0f0_1,set(ipv4(ttl=63)),enp8s0f0_0,enp8s0f0_1.
Here the rule is split to two FTEs because of pedit action.

To fix this issue, when parsing the rule actions, reset if_count to
clear the mirred devices array if the rule is split to multiple
FTEs, and then the duplicate checking is restarted.

Fixes: 554fe75c1b3f ("net/mlx5e: Avoid duplicating rule destinations")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c        | 4 +++-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c    | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c     | 4 +++-
 .../ethernet/mellanox/mlx5/core/en/tc/act/redirect_ingress.c  | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c      | 1 +
 .../net/ethernet/mellanox/mlx5/core/en/tc/act/vlan_mangle.c   | 4 +++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c               | 1 +
 7 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c
index 92d3952dfa8b7..feeb41693c176 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c
@@ -17,8 +17,10 @@ tc_act_parse_ct(struct mlx5e_tc_act_parse_state *parse_state,
 	if (err)
 		return err;
 
-	if (mlx5e_is_eswitch_flow(parse_state->flow))
+	if (mlx5e_is_eswitch_flow(parse_state->flow)) {
 		attr->esw_attr->split_count = attr->esw_attr->out_count;
+		parse_state->if_count = 0;
+	}
 
 	attr->flags |= MLX5_ATTR_FLAG_CT;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c
index 291193f7120d5..f63402c480280 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c
@@ -294,6 +294,7 @@ parse_mirred_ovs_master(struct mlx5e_tc_act_parse_state *parse_state,
 	if (err)
 		return err;
 
+	parse_state->if_count = 0;
 	esw_attr->out_count++;
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c
index 3b272bbf4c538..368a95fa77d32 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c
@@ -98,8 +98,10 @@ tc_act_parse_pedit(struct mlx5e_tc_act_parse_state *parse_state,
 
 	attr->action |= MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
 
-	if (ns_type == MLX5_FLOW_NAMESPACE_FDB)
+	if (ns_type == MLX5_FLOW_NAMESPACE_FDB) {
 		esw_attr->split_count = esw_attr->out_count;
+		parse_state->if_count = 0;
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/redirect_ingress.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/redirect_ingress.c
index ad09a8a5f36e0..2d1d4a04501b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/redirect_ingress.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/redirect_ingress.c
@@ -66,6 +66,7 @@ tc_act_parse_redirect_ingress(struct mlx5e_tc_act_parse_state *parse_state,
 	if (err)
 		return err;
 
+	parse_state->if_count = 0;
 	esw_attr->out_count++;
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c
index c8a3eaf189f6a..a13c5e707b83c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c
@@ -166,6 +166,7 @@ tc_act_parse_vlan(struct mlx5e_tc_act_parse_state *parse_state,
 		return err;
 
 	esw_attr->split_count = esw_attr->out_count;
+	parse_state->if_count = 0;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan_mangle.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan_mangle.c
index 310b992307607..f17575b09788d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan_mangle.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan_mangle.c
@@ -65,8 +65,10 @@ tc_act_parse_vlan_mangle(struct mlx5e_tc_act_parse_state *parse_state,
 	if (err)
 		return err;
 
-	if (ns_type == MLX5_FLOW_NAMESPACE_FDB)
+	if (ns_type == MLX5_FLOW_NAMESPACE_FDB) {
 		attr->esw_attr->split_count = attr->esw_attr->out_count;
+		parse_state->if_count = 0;
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 31708d5aa6087..4b22a91482cec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -3939,6 +3939,7 @@ parse_tc_actions(struct mlx5e_tc_act_parse_state *parse_state,
 			}
 
 			i_split = i + 1;
+			parse_state->if_count = 0;
 			list_add(&attr->list, &flow->attrs);
 		}
 
-- 
2.40.1



