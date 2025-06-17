Return-Path: <stable+bounces-153589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49064ADD57B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8E7194367E
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722C81BD9D3;
	Tue, 17 Jun 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DUdQrUg5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED412F2352;
	Tue, 17 Jun 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176450; cv=none; b=aFHF8GZwsLMOKpu8xoqSfEajvv+wegNviwVSAsY6dEdarPk6A5Lr1U8ochLI+KMVSIQAt4PQQAVYjj9D50cFKqgiQQIvc9bF5DGLMPmpK9G8uGTYO3WwbdGPA/Vg9cwt7SZgLAFaMT2K/P+/XWwAXiuDNYV2rp+oyxBW7ebV7Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176450; c=relaxed/simple;
	bh=jDCli2+AtRzS+5g52tJgXkeirR9QN2jsgdRAW02gO9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3m4knn/M7nLlYnX7LLIg7LSgQXUrnSG/TQnErtE5s/BGCHgrEA036Zv7Vw2Can8fHMixlSOgQ8FDMtOxy9lEazfNNVOr0PhtQ3bQs7WVXAtPvENl1ULf5aUEjC3SAjKji3MMxXRpQEqBhHIdtG2yMH659/HcU2gDhOaNB9jtvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DUdQrUg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FD9C4CEE3;
	Tue, 17 Jun 2025 16:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176450;
	bh=jDCli2+AtRzS+5g52tJgXkeirR9QN2jsgdRAW02gO9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DUdQrUg5dZGT4Wab1mX+YyQ6TQ7Mz8+6eRtouYFAbGuz/lc9r6bn+jPHxFXN0s/iU
	 8j4Tzo4KCurcgTaE1H5xJ5RvkNn4z/Xv9KEhnMZgyW+6l0Bn3FrZIe+USO7E6Bk5JW
	 SHgPP99D1fJtnTL5ZUP5mQ11K2Pr0eFjuE7nJN+o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vlad Dogaru <vdogaru@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 190/780] net/mlx5: HWS, Fix matcher action template attach
Date: Tue, 17 Jun 2025 17:18:18 +0200
Message-ID: <20250617152459.215059067@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlad Dogaru <vdogaru@nvidia.com>

[ Upstream commit 36ef2575e78d1a3c699dc3f1c9dee9be742c9bdd ]

The procedure of attaching an action template to an existing matcher had
a few issues:

1. Attaching accidentally overran the `at` array in bwc_matcher, which
   would result in memory corruption. This bug wasn't triggered, but it
   is possible to trigger it by attaching action templates beyond the
   initial buffer size of 8. Fix this by converting to a dynamically
   sized buffer and reallocating if needed.

2. Similarly, the `at` array inside the native matcher was never
   reallocated. Fix this the same as above.

3. The bwc layer treated any error in action template attach as a signal
   that the matcher should be rehashed to account for a larger number of
   action STEs. In reality, there are other unrelated errors that can
   arise and they should be propagated upstack. Fix this by adding a
   `need_rehash` output parameter that's orthogonal to error codes.

Fixes: 2111bb970c78 ("net/mlx5: HWS, added backward-compatible API handling")
Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Link: https://patch.msgid.link/1744312662-356571-2-git-send-email-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 55 ++++++++++++++++---
 .../mellanox/mlx5/core/steering/hws/bwc.h     |  9 ++-
 .../mellanox/mlx5/core/steering/hws/matcher.c | 48 +++++++++++++---
 .../mellanox/mlx5/core/steering/hws/matcher.h |  4 ++
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  5 +-
 5 files changed, 97 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 19dce1ba512d4..32de8bfc7644f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -90,13 +90,19 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
 	bwc_matcher->priority = priority;
 	bwc_matcher->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
 
+	bwc_matcher->size_of_at_array = MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM;
+	bwc_matcher->at = kcalloc(bwc_matcher->size_of_at_array,
+				  sizeof(*bwc_matcher->at), GFP_KERNEL);
+	if (!bwc_matcher->at)
+		goto free_bwc_matcher_rules;
+
 	/* create dummy action template */
 	bwc_matcher->at[0] =
 		mlx5hws_action_template_create(action_types ?
 					       action_types : init_action_types);
 	if (!bwc_matcher->at[0]) {
 		mlx5hws_err(table->ctx, "BWC matcher: failed creating action template\n");
-		goto free_bwc_matcher_rules;
+		goto free_bwc_matcher_at_array;
 	}
 
 	bwc_matcher->num_of_at = 1;
@@ -126,6 +132,8 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
 	mlx5hws_match_template_destroy(bwc_matcher->mt);
 free_at:
 	mlx5hws_action_template_destroy(bwc_matcher->at[0]);
+free_bwc_matcher_at_array:
+	kfree(bwc_matcher->at);
 free_bwc_matcher_rules:
 	kfree(bwc_matcher->rules);
 err:
@@ -192,6 +200,7 @@ int mlx5hws_bwc_matcher_destroy_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
 
 	for (i = 0; i < bwc_matcher->num_of_at; i++)
 		mlx5hws_action_template_destroy(bwc_matcher->at[i]);
+	kfree(bwc_matcher->at);
 
 	mlx5hws_match_template_destroy(bwc_matcher->mt);
 	kfree(bwc_matcher->rules);
@@ -520,6 +529,23 @@ hws_bwc_matcher_extend_at(struct mlx5hws_bwc_matcher *bwc_matcher,
 			  struct mlx5hws_rule_action rule_actions[])
 {
 	enum mlx5hws_action_type action_types[MLX5HWS_BWC_MAX_ACTS];
+	void *p;
+
+	if (unlikely(bwc_matcher->num_of_at >= bwc_matcher->size_of_at_array)) {
+		if (bwc_matcher->size_of_at_array >= MLX5HWS_MATCHER_MAX_AT)
+			return -ENOMEM;
+		bwc_matcher->size_of_at_array *= 2;
+		p = krealloc(bwc_matcher->at,
+			     bwc_matcher->size_of_at_array *
+				     sizeof(*bwc_matcher->at),
+			     __GFP_ZERO | GFP_KERNEL);
+		if (!p) {
+			bwc_matcher->size_of_at_array /= 2;
+			return -ENOMEM;
+		}
+
+		bwc_matcher->at = p;
+	}
 
 	hws_bwc_rule_actions_to_action_types(rule_actions, action_types);
 
@@ -777,6 +803,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	struct mlx5hws_rule_attr rule_attr;
 	struct mutex *queue_lock; /* Protect the queue */
 	u32 num_of_rules;
+	bool need_rehash;
 	int ret = 0;
 	int at_idx;
 
@@ -803,10 +830,14 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 		at_idx = bwc_matcher->num_of_at - 1;
 
 		ret = mlx5hws_matcher_attach_at(bwc_matcher->matcher,
-						bwc_matcher->at[at_idx]);
+						bwc_matcher->at[at_idx],
+						&need_rehash);
 		if (unlikely(ret)) {
-			/* Action template attach failed, possibly due to
-			 * requiring more action STEs.
+			hws_bwc_unlock_all_queues(ctx);
+			return ret;
+		}
+		if (unlikely(need_rehash)) {
+			/* The new action template requires more action STEs.
 			 * Need to attempt creating new matcher with all
 			 * the action templates, including the new one.
 			 */
@@ -942,6 +973,7 @@ hws_bwc_rule_action_update(struct mlx5hws_bwc_rule *bwc_rule,
 	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
 	struct mlx5hws_rule_attr rule_attr;
 	struct mutex *queue_lock; /* Protect the queue */
+	bool need_rehash;
 	int at_idx, ret;
 	u16 idx;
 
@@ -973,12 +1005,17 @@ hws_bwc_rule_action_update(struct mlx5hws_bwc_rule *bwc_rule,
 			at_idx = bwc_matcher->num_of_at - 1;
 
 			ret = mlx5hws_matcher_attach_at(bwc_matcher->matcher,
-							bwc_matcher->at[at_idx]);
+							bwc_matcher->at[at_idx],
+							&need_rehash);
 			if (unlikely(ret)) {
-				/* Action template attach failed, possibly due to
-				 * requiring more action STEs.
-				 * Need to attempt creating new matcher with all
-				 * the action templates, including the new one.
+				hws_bwc_unlock_all_queues(ctx);
+				return ret;
+			}
+			if (unlikely(need_rehash)) {
+				/* The new action template requires more action
+				 * STEs. Need to attempt creating new matcher
+				 * with all the action templates, including the
+				 * new one.
 				 */
 				ret = hws_bwc_matcher_rehash_at(bwc_matcher);
 				if (unlikely(ret)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index 47f7ed1415535..bb0cf4b922ceb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -10,9 +10,7 @@
 #define MLX5HWS_BWC_MATCHER_REHASH_BURST_TH 32
 
 /* Max number of AT attach operations for the same matcher.
- * When the limit is reached, next attempt to attach new AT
- * will result in creation of a new matcher and moving all
- * the rules to this matcher.
+ * When the limit is reached, a larger buffer is allocated for the ATs.
  */
 #define MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM 8
 
@@ -23,10 +21,11 @@
 struct mlx5hws_bwc_matcher {
 	struct mlx5hws_matcher *matcher;
 	struct mlx5hws_match_template *mt;
-	struct mlx5hws_action_template *at[MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM];
-	u32 priority;
+	struct mlx5hws_action_template **at;
 	u8 num_of_at;
+	u8 size_of_at_array;
 	u8 size_log;
+	u32 priority;
 	atomic_t num_of_rules;
 	struct list_head *rules;
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index b61864b320536..37a4497048a6f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -905,18 +905,48 @@ static int hws_matcher_uninit(struct mlx5hws_matcher *matcher)
 	return 0;
 }
 
+static int hws_matcher_grow_at_array(struct mlx5hws_matcher *matcher)
+{
+	void *p;
+
+	if (matcher->size_of_at_array >= MLX5HWS_MATCHER_MAX_AT)
+		return -ENOMEM;
+
+	matcher->size_of_at_array *= 2;
+	p = krealloc(matcher->at,
+		     matcher->size_of_at_array * sizeof(*matcher->at),
+		     __GFP_ZERO | GFP_KERNEL);
+	if (!p) {
+		matcher->size_of_at_array /= 2;
+		return -ENOMEM;
+	}
+
+	matcher->at = p;
+
+	return 0;
+}
+
 int mlx5hws_matcher_attach_at(struct mlx5hws_matcher *matcher,
-			      struct mlx5hws_action_template *at)
+			      struct mlx5hws_action_template *at,
+			      bool *need_rehash)
 {
 	bool is_jumbo = mlx5hws_matcher_mt_is_jumbo(matcher->mt);
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
 	u32 required_stes;
 	int ret;
 
-	if (!matcher->attr.max_num_of_at_attach) {
-		mlx5hws_dbg(ctx, "Num of current at (%d) exceed allowed value\n",
-			    matcher->num_of_at);
-		return -EOPNOTSUPP;
+	*need_rehash = false;
+
+	if (unlikely(matcher->num_of_at >= matcher->size_of_at_array)) {
+		ret = hws_matcher_grow_at_array(matcher);
+		if (ret)
+			return ret;
+
+		if (matcher->col_matcher) {
+			ret = hws_matcher_grow_at_array(matcher->col_matcher);
+			if (ret)
+				return ret;
+		}
 	}
 
 	ret = hws_matcher_check_and_process_at(matcher, at);
@@ -927,12 +957,11 @@ int mlx5hws_matcher_attach_at(struct mlx5hws_matcher *matcher,
 	if (matcher->action_ste.max_stes < required_stes) {
 		mlx5hws_dbg(ctx, "Required STEs [%d] exceeds initial action template STE [%d]\n",
 			    required_stes, matcher->action_ste.max_stes);
-		return -ENOMEM;
+		*need_rehash = true;
 	}
 
 	matcher->at[matcher->num_of_at] = *at;
 	matcher->num_of_at += 1;
-	matcher->attr.max_num_of_at_attach -= 1;
 
 	if (matcher->col_matcher)
 		matcher->col_matcher->num_of_at = matcher->num_of_at;
@@ -960,8 +989,9 @@ hws_matcher_set_templates(struct mlx5hws_matcher *matcher,
 	if (!matcher->mt)
 		return -ENOMEM;
 
-	matcher->at = kvcalloc(num_of_at + matcher->attr.max_num_of_at_attach,
-			       sizeof(*matcher->at),
+	matcher->size_of_at_array =
+		num_of_at + matcher->attr.max_num_of_at_attach;
+	matcher->at = kvcalloc(matcher->size_of_at_array, sizeof(*matcher->at),
 			       GFP_KERNEL);
 	if (!matcher->at) {
 		mlx5hws_err(ctx, "Failed to allocate action template array\n");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
index 020de70270c50..20b32012c418b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
@@ -23,6 +23,9 @@
  */
 #define MLX5HWS_MATCHER_ACTION_RTC_UPDATE_MULT 1
 
+/* Maximum number of action templates that can be attached to a matcher. */
+#define MLX5HWS_MATCHER_MAX_AT 128
+
 enum mlx5hws_matcher_offset {
 	MLX5HWS_MATCHER_OFFSET_TAG_DW1 = 12,
 	MLX5HWS_MATCHER_OFFSET_TAG_DW0 = 13,
@@ -72,6 +75,7 @@ struct mlx5hws_matcher {
 	struct mlx5hws_match_template *mt;
 	struct mlx5hws_action_template *at;
 	u8 num_of_at;
+	u8 size_of_at_array;
 	u8 num_of_mt;
 	/* enum mlx5hws_matcher_flags */
 	u8 flags;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
index 5121951f2778a..8ed8a715a2eb2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
@@ -399,11 +399,14 @@ int mlx5hws_matcher_destroy(struct mlx5hws_matcher *matcher);
  *
  * @matcher: Matcher to attach the action template to.
  * @at: Action template to be attached to the matcher.
+ * @need_rehash: Output parameter that tells callers if the matcher needs to be
+ * rehashed.
  *
  * Return: Zero on success, non-zero otherwise.
  */
 int mlx5hws_matcher_attach_at(struct mlx5hws_matcher *matcher,
-			      struct mlx5hws_action_template *at);
+			      struct mlx5hws_action_template *at,
+			      bool *need_rehash);
 
 /**
  * mlx5hws_matcher_resize_set_target - Link two matchers and enable moving rules.
-- 
2.39.5




