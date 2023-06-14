Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E14D726B18
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjFGUW1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjFGUW0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:22:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749C32717
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05056643C6
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD44C433A0;
        Wed,  7 Jun 2023 20:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169308;
        bh=ceQJ4DJh59LPKvMBnHywMxnBmYOzeCwlUk1qDq86Yfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KxkIBKqxoviejxJiPJ1xavXlnwWdb9+YEiX3cRvBE6k1iUQphCRxaGIwo6JbkOvFj
         IbY0/jftuk2yZk27CasJ7wjBvUSk9E6oiKOIydk4Aay6m2zai2rxlVHW/9xXJonLok
         S4jxrjR7bLJkod/C4NVa+n7UPZYpoUoxT617cPDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Blakey <paulb@nvidia.com>,
        Roi Dayan <roid@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 030/286] net/mlx5e: CT: Use per action stats
Date:   Wed,  7 Jun 2023 22:12:09 +0200
Message-ID: <20230607200924.000779109@linuxfoundation.org>
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

From: Paul Blakey <paulb@nvidia.com>

[ Upstream commit 13aca17b450e87a8de4e4a3b3ad454efbc576740 ]

CT action can miss in a middle of an action list, use
per action stats to correctly report stats for missed
packets.

Signed-off-by: Paul Blakey <paulb@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Stable-dep-of: 5d862ec631f3 ("net/mlx5: Fix post parse infra to only parse every action once")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/en/tc/act/act.h        |  2 ++
 .../mellanox/mlx5/core/en/tc/act/ct.c         |  9 ++++++++-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 19 +++++++++++++++++--
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/act.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/act.h
index 8346557eeaf63..cdcddf6e1b08b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/act.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/act.h
@@ -56,6 +56,8 @@ struct mlx5e_tc_act {
 				   const struct flow_action_entry *act,
 				   struct mlx5_flow_attr *attr);
 
+	bool (*is_missable)(const struct flow_action_entry *act);
+
 	int (*offload_action)(struct mlx5e_priv *priv,
 			      struct flow_offload_action *fl_act,
 			      struct flow_action_entry *act);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c
index a829c94289c10..fce1c0fd24535 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c
@@ -95,10 +95,17 @@ tc_act_is_multi_table_act_ct(struct mlx5e_priv *priv,
 	return true;
 }
 
+static bool
+tc_act_is_missable_ct(const struct flow_action_entry *act)
+{
+	return !(act->ct.action & TCA_CT_ACT_CLEAR);
+}
+
 struct mlx5e_tc_act mlx5e_tc_act_ct = {
 	.can_offload = tc_act_can_offload_ct,
 	.parse_action = tc_act_parse_ct,
-	.is_multi_table_act = tc_act_is_multi_table_act_ct,
 	.post_parse = tc_act_post_parse_ct,
+	.is_multi_table_act = tc_act_is_multi_table_act_ct,
+	.is_missable = tc_act_is_missable_ct,
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index b5d23b159f345..82b76dcc05ac1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -3974,7 +3974,9 @@ parse_tc_actions(struct mlx5e_tc_act_parse_state *parse_state,
 	enum mlx5_flow_namespace_type ns_type;
 	struct mlx5e_priv *priv = flow->priv;
 	struct flow_action_entry *act, **_act;
+	struct mlx5_flow_attr *prev_attr;
 	struct mlx5e_tc_act *tc_act;
+	bool is_missable;
 	int err, i;
 
 	flow_action_reorder.num_entries = flow_action->num_entries;
@@ -3991,6 +3993,9 @@ parse_tc_actions(struct mlx5e_tc_act_parse_state *parse_state,
 	flow_action_for_each(i, _act, &flow_action_reorder) {
 		jump_state.jump_target = false;
 		act = *_act;
+		is_missable = false;
+		prev_attr = attr;
+
 		tc_act = mlx5e_tc_act_get(act->id, ns_type);
 		if (!tc_act) {
 			NL_SET_ERR_MSG_MOD(extack, "Not implemented offload action");
@@ -4014,14 +4019,14 @@ parse_tc_actions(struct mlx5e_tc_act_parse_state *parse_state,
 			goto out_free;
 
 		parse_state->actions |= attr->action;
-		if (!tc_act->stats_action)
-			attr->tc_act_cookies[attr->tc_act_cookies_count++] = act->cookie;
 
 		/* Split attr for multi table act if not the last act. */
 		if (jump_state.jump_target ||
 		    (tc_act->is_multi_table_act &&
 		    tc_act->is_multi_table_act(priv, act, attr) &&
 		    i < flow_action_reorder.num_entries - 1)) {
+			is_missable = tc_act->is_missable ? tc_act->is_missable(act) : false;
+
 			err = mlx5e_tc_act_post_parse(parse_state, flow_action, attr, ns_type);
 			if (err)
 				goto out_free;
@@ -4034,6 +4039,16 @@ parse_tc_actions(struct mlx5e_tc_act_parse_state *parse_state,
 
 			list_add(&attr->list, &flow->attrs);
 		}
+
+		if (is_missable) {
+			/* Add counter to prev, and assign act to new (next) attr */
+			prev_attr->action |= MLX5_FLOW_CONTEXT_ACTION_COUNT;
+			flow_flag_set(flow, USE_ACT_STATS);
+
+			attr->tc_act_cookies[attr->tc_act_cookies_count++] = act->cookie;
+		} else if (!tc_act->stats_action) {
+			prev_attr->tc_act_cookies[prev_attr->tc_act_cookies_count++] = act->cookie;
+		}
 	}
 
 	kfree(flow_action_reorder.entries);
-- 
2.39.2



