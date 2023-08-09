Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED80577578F
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjHIKr3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjHIKr2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:47:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798041702
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:47:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03B086310A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FF3C433C8;
        Wed,  9 Aug 2023 10:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578046;
        bh=VaF7BlRvFIPGJyZfa56dFkQNvF05oIgHPZ1lsO0nStU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tAG7glBtbf2dpcEESnwYXvLhPOgsK71n8aUYCam4MLtf3NqPyMR/jYZ4zo6MiJMYZ
         2R8FmNMZk+zdm2BnUGHl0HOWKMdGhqbnfUGe6P2RMfQzNeggtPkrZ0HrqEnSzKjCfs
         31WW+F8bjuNa4QZhKn/e2haKWpE9Cbx+9m0zdtZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jianbo Liu <jianbol@nvidia.com>,
        Paul Blakey <paulb@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 086/165] net/mlx5: fs_core: Skip the FTs in the same FS_TYPE_PRIO_CHAINS fs_prio
Date:   Wed,  9 Aug 2023 12:40:17 +0200
Message-ID: <20230809103645.621467217@linuxfoundation.org>
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

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit c635ca45a7a2023904a1f851e99319af7b87017d ]

In the cited commit, new type of FS_TYPE_PRIO_CHAINS fs_prio was added
to support multiple parallel namespaces for multi-chains. And we skip
all the flow tables under the fs_node of this type unconditionally,
when searching for the next or previous flow table to connect for a
new table.

As this search function is also used for find new root table when the
old one is being deleted, it will skip the entire FS_TYPE_PRIO_CHAINS
fs_node next to the old root. However, new root table should be chosen
from it if there is any table in it. Fix it by skipping only the flow
tables in the same FS_TYPE_PRIO_CHAINS fs_node when finding the
closest FT for a fs_node.

Besides, complete the connecting from FTs of previous priority of prio
because there should be multiple prevs after this fs_prio type is
introduced. And also the next FT should be chosen from the first flow
table next to the prio in the same FS_TYPE_PRIO_CHAINS fs_prio, if
this prio is the first child.

Fixes: 328edb499f99 ("net/mlx5: Split FDB fast path prio to multiple namespaces")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Paul Blakey <paulb@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Link: https://lore.kernel.org/r/7a95754df479e722038996c97c97b062b372591f.1690803944.git.leonro@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 80 +++++++++++++++++--
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 852e265541d19..5f87c446d3d97 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -889,7 +889,7 @@ static struct mlx5_flow_table *find_closest_ft_recursive(struct fs_node  *root,
 	struct fs_node *iter = list_entry(start, struct fs_node, list);
 	struct mlx5_flow_table *ft = NULL;
 
-	if (!root || root->type == FS_TYPE_PRIO_CHAINS)
+	if (!root)
 		return NULL;
 
 	list_for_each_advance_continue(iter, &root->children, reverse) {
@@ -905,19 +905,42 @@ static struct mlx5_flow_table *find_closest_ft_recursive(struct fs_node  *root,
 	return ft;
 }
 
+static struct fs_node *find_prio_chains_parent(struct fs_node *parent,
+					       struct fs_node **child)
+{
+	struct fs_node *node = NULL;
+
+	while (parent && parent->type != FS_TYPE_PRIO_CHAINS) {
+		node = parent;
+		parent = parent->parent;
+	}
+
+	if (child)
+		*child = node;
+
+	return parent;
+}
+
 /* If reverse is false then return the first flow table next to the passed node
  * in the tree, else return the last flow table before the node in the tree.
+ * If skip is true, skip the flow tables in the same prio_chains prio.
  */
-static struct mlx5_flow_table *find_closest_ft(struct fs_node *node, bool reverse)
+static struct mlx5_flow_table *find_closest_ft(struct fs_node *node, bool reverse,
+					       bool skip)
 {
+	struct fs_node *prio_chains_parent = NULL;
 	struct mlx5_flow_table *ft = NULL;
 	struct fs_node *curr_node;
 	struct fs_node *parent;
 
+	if (skip)
+		prio_chains_parent = find_prio_chains_parent(node, NULL);
 	parent = node->parent;
 	curr_node = node;
 	while (!ft && parent) {
-		ft = find_closest_ft_recursive(parent, &curr_node->list, reverse);
+		if (parent != prio_chains_parent)
+			ft = find_closest_ft_recursive(parent, &curr_node->list,
+						       reverse);
 		curr_node = parent;
 		parent = curr_node->parent;
 	}
@@ -927,13 +950,13 @@ static struct mlx5_flow_table *find_closest_ft(struct fs_node *node, bool revers
 /* Assuming all the tree is locked by mutex chain lock */
 static struct mlx5_flow_table *find_next_chained_ft(struct fs_node *node)
 {
-	return find_closest_ft(node, false);
+	return find_closest_ft(node, false, true);
 }
 
 /* Assuming all the tree is locked by mutex chain lock */
 static struct mlx5_flow_table *find_prev_chained_ft(struct fs_node *node)
 {
-	return find_closest_ft(node, true);
+	return find_closest_ft(node, true, true);
 }
 
 static struct mlx5_flow_table *find_next_fwd_ft(struct mlx5_flow_table *ft,
@@ -969,21 +992,55 @@ static int connect_fts_in_prio(struct mlx5_core_dev *dev,
 	return 0;
 }
 
+static struct mlx5_flow_table *find_closet_ft_prio_chains(struct fs_node *node,
+							  struct fs_node *parent,
+							  struct fs_node **child,
+							  bool reverse)
+{
+	struct mlx5_flow_table *ft;
+
+	ft = find_closest_ft(node, reverse, false);
+
+	if (ft && parent == find_prio_chains_parent(&ft->node, child))
+		return ft;
+
+	return NULL;
+}
+
 /* Connect flow tables from previous priority of prio to ft */
 static int connect_prev_fts(struct mlx5_core_dev *dev,
 			    struct mlx5_flow_table *ft,
 			    struct fs_prio *prio)
 {
+	struct fs_node *prio_parent, *parent = NULL, *child, *node;
 	struct mlx5_flow_table *prev_ft;
+	int err = 0;
+
+	prio_parent = find_prio_chains_parent(&prio->node, &child);
+
+	/* return directly if not under the first sub ns of prio_chains prio */
+	if (prio_parent && !list_is_first(&child->list, &prio_parent->children))
+		return 0;
 
 	prev_ft = find_prev_chained_ft(&prio->node);
-	if (prev_ft) {
+	while (prev_ft) {
 		struct fs_prio *prev_prio;
 
 		fs_get_obj(prev_prio, prev_ft->node.parent);
-		return connect_fts_in_prio(dev, prev_prio, ft);
+		err = connect_fts_in_prio(dev, prev_prio, ft);
+		if (err)
+			break;
+
+		if (!parent) {
+			parent = find_prio_chains_parent(&prev_prio->node, &child);
+			if (!parent)
+				break;
+		}
+
+		node = child;
+		prev_ft = find_closet_ft_prio_chains(node, parent, &child, true);
 	}
-	return 0;
+	return err;
 }
 
 static int update_root_ft_create(struct mlx5_flow_table *ft, struct fs_prio
@@ -2194,12 +2251,19 @@ EXPORT_SYMBOL(mlx5_del_flow_rules);
 /* Assuming prio->node.children(flow tables) is sorted by level */
 static struct mlx5_flow_table *find_next_ft(struct mlx5_flow_table *ft)
 {
+	struct fs_node *prio_parent, *child;
 	struct fs_prio *prio;
 
 	fs_get_obj(prio, ft->node.parent);
 
 	if (!list_is_last(&ft->node.list, &prio->node.children))
 		return list_next_entry(ft, node.list);
+
+	prio_parent = find_prio_chains_parent(&prio->node, &child);
+
+	if (prio_parent && list_is_first(&child->list, &prio_parent->children))
+		return find_closest_ft(&prio->node, false, false);
+
 	return find_next_chained_ft(&prio->node);
 }
 
-- 
2.40.1



