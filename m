Return-Path: <stable+bounces-41999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1D78B70D6
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630471C221FE
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F0B12C49E;
	Tue, 30 Apr 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DsX/vQ0V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8485A12C46B;
	Tue, 30 Apr 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474227; cv=none; b=WEi0mt1AtkTthcFQHhYiIV9IanVRpyyV8hPQEEFI7y+htaJNEebROV9Dnwb/YuZAfysOGlot4S8ablkzX32Y/cVkIG0REI/76igIS0lN06oAyZMTxD4WV1WlwarioXgPrMMpP0s9JW0GZuLO/zjFW+huUk9S2dzAgkHyn749B/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474227; c=relaxed/simple;
	bh=5BtDaDKgUWIFgwuBrKb2+mA3VLHmvLDfZ3jO/nF9itk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPnALt1D/1Ho40yZPL1poYyJ0gQmyo8sDUizxYj5Ha+IA5ZslleC2J5KlvPdPyFsg7kGFJqLzUFJUlIBYEqDcLujlbvuXwlO0PHbUr74y24C6lEwhpUoBR9bTQdScxMXfONeopwFTJVfo0wIBzfJpqzqSlIx1CIQ2RjGyjRiG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DsX/vQ0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C88C2BBFC;
	Tue, 30 Apr 2024 10:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474227;
	bh=5BtDaDKgUWIFgwuBrKb2+mA3VLHmvLDfZ3jO/nF9itk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DsX/vQ0VNyJmaOyCHwB/GN/Q5pk8OP4QG+6QE9qoOkO8RAo7HyKDV/kCTH06xnGf9
	 TSt09Q2dCc2QAvgobNuYitk8DuK1cjUXomj9kYX6ZAPmDdKpdiRHtNzIM+MGaYGIFW
	 F+sGNbHhfTq/iwDYXi1zk3ivGwHG0fZBtiMT0bIs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amit Cohen <amcohen@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 094/228] mlxsw: Use refcount_t for reference counting
Date: Tue, 30 Apr 2024 12:37:52 +0200
Message-ID: <20240430103106.514188111@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amit Cohen <amcohen@nvidia.com>

[ Upstream commit 1267f7223bec186dc26ef4e6075496c6217355de ]

mlxsw driver uses 'unsigned int' for reference counters in several
structures. Instead, use refcount_t type which allows us to catch overflow
and underflow issues. Change the type of the counters and use the
appropriate API.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 627f9c1bb882 ("mlxsw: spectrum_acl_tcam: Fix race in region ID allocation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlxsw/core_acl_flex_actions.c      | 16 ++++++++--------
 .../mellanox/mlxsw/core_acl_flex_keys.c         |  9 +++++----
 .../net/ethernet/mellanox/mlxsw/spectrum_acl.c  | 11 ++++++-----
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 17 +++++++++--------
 .../ethernet/mellanox/mlxsw/spectrum_router.c   | 15 ++++++++-------
 .../mellanox/mlxsw/spectrum_switchdev.c         |  8 ++++----
 6 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
index faa63ea9b83e1..1915fa41c6224 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
@@ -95,7 +95,7 @@ struct mlxsw_afa_set {
 		      */
 	   has_trap:1,
 	   has_police:1;
-	unsigned int ref_count;
+	refcount_t ref_count;
 	struct mlxsw_afa_set *next; /* Pointer to the next set. */
 	struct mlxsw_afa_set *prev; /* Pointer to the previous set,
 				     * note that set may have multiple
@@ -120,7 +120,7 @@ struct mlxsw_afa_fwd_entry {
 	struct rhash_head ht_node;
 	struct mlxsw_afa_fwd_entry_ht_key ht_key;
 	u32 kvdl_index;
-	unsigned int ref_count;
+	refcount_t ref_count;
 };
 
 static const struct rhashtable_params mlxsw_afa_fwd_entry_ht_params = {
@@ -282,7 +282,7 @@ static struct mlxsw_afa_set *mlxsw_afa_set_create(bool is_first)
 	/* Need to initialize the set to pass by default */
 	mlxsw_afa_set_goto_set(set, MLXSW_AFA_SET_GOTO_BINDING_CMD_TERM, 0);
 	set->ht_key.is_first = is_first;
-	set->ref_count = 1;
+	refcount_set(&set->ref_count, 1);
 	return set;
 }
 
@@ -330,7 +330,7 @@ static void mlxsw_afa_set_unshare(struct mlxsw_afa *mlxsw_afa,
 static void mlxsw_afa_set_put(struct mlxsw_afa *mlxsw_afa,
 			      struct mlxsw_afa_set *set)
 {
-	if (--set->ref_count)
+	if (!refcount_dec_and_test(&set->ref_count))
 		return;
 	if (set->shared)
 		mlxsw_afa_set_unshare(mlxsw_afa, set);
@@ -350,7 +350,7 @@ static struct mlxsw_afa_set *mlxsw_afa_set_get(struct mlxsw_afa *mlxsw_afa,
 	set = rhashtable_lookup_fast(&mlxsw_afa->set_ht, &orig_set->ht_key,
 				     mlxsw_afa_set_ht_params);
 	if (set) {
-		set->ref_count++;
+		refcount_inc(&set->ref_count);
 		mlxsw_afa_set_put(mlxsw_afa, orig_set);
 	} else {
 		set = orig_set;
@@ -564,7 +564,7 @@ mlxsw_afa_fwd_entry_create(struct mlxsw_afa *mlxsw_afa, u16 local_port)
 	if (!fwd_entry)
 		return ERR_PTR(-ENOMEM);
 	fwd_entry->ht_key.local_port = local_port;
-	fwd_entry->ref_count = 1;
+	refcount_set(&fwd_entry->ref_count, 1);
 
 	err = rhashtable_insert_fast(&mlxsw_afa->fwd_entry_ht,
 				     &fwd_entry->ht_node,
@@ -607,7 +607,7 @@ mlxsw_afa_fwd_entry_get(struct mlxsw_afa *mlxsw_afa, u16 local_port)
 	fwd_entry = rhashtable_lookup_fast(&mlxsw_afa->fwd_entry_ht, &ht_key,
 					   mlxsw_afa_fwd_entry_ht_params);
 	if (fwd_entry) {
-		fwd_entry->ref_count++;
+		refcount_inc(&fwd_entry->ref_count);
 		return fwd_entry;
 	}
 	return mlxsw_afa_fwd_entry_create(mlxsw_afa, local_port);
@@ -616,7 +616,7 @@ mlxsw_afa_fwd_entry_get(struct mlxsw_afa *mlxsw_afa, u16 local_port)
 static void mlxsw_afa_fwd_entry_put(struct mlxsw_afa *mlxsw_afa,
 				    struct mlxsw_afa_fwd_entry *fwd_entry)
 {
-	if (--fwd_entry->ref_count)
+	if (!refcount_dec_and_test(&fwd_entry->ref_count))
 		return;
 	mlxsw_afa_fwd_entry_destroy(mlxsw_afa, fwd_entry);
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
index 0d5e6f9b466ec..947500f8ed714 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
@@ -5,6 +5,7 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/errno.h>
+#include <linux/refcount.h>
 
 #include "item.h"
 #include "core_acl_flex_keys.h"
@@ -107,7 +108,7 @@ EXPORT_SYMBOL(mlxsw_afk_destroy);
 
 struct mlxsw_afk_key_info {
 	struct list_head list;
-	unsigned int ref_count;
+	refcount_t ref_count;
 	unsigned int blocks_count;
 	int element_to_block[MLXSW_AFK_ELEMENT_MAX]; /* index is element, value
 						      * is index inside "blocks"
@@ -334,7 +335,7 @@ mlxsw_afk_key_info_create(struct mlxsw_afk *mlxsw_afk,
 	if (err)
 		goto err_picker;
 	list_add(&key_info->list, &mlxsw_afk->key_info_list);
-	key_info->ref_count = 1;
+	refcount_set(&key_info->ref_count, 1);
 	return key_info;
 
 err_picker:
@@ -356,7 +357,7 @@ mlxsw_afk_key_info_get(struct mlxsw_afk *mlxsw_afk,
 
 	key_info = mlxsw_afk_key_info_find(mlxsw_afk, elusage);
 	if (key_info) {
-		key_info->ref_count++;
+		refcount_inc(&key_info->ref_count);
 		return key_info;
 	}
 	return mlxsw_afk_key_info_create(mlxsw_afk, elusage);
@@ -365,7 +366,7 @@ EXPORT_SYMBOL(mlxsw_afk_key_info_get);
 
 void mlxsw_afk_key_info_put(struct mlxsw_afk_key_info *key_info)
 {
-	if (--key_info->ref_count)
+	if (!refcount_dec_and_test(&key_info->ref_count))
 		return;
 	mlxsw_afk_key_info_destroy(key_info);
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
index 7c59c8a135840..b01b000bc71c1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
@@ -9,6 +9,7 @@
 #include <linux/rhashtable.h>
 #include <linux/netdevice.h>
 #include <linux/mutex.h>
+#include <linux/refcount.h>
 #include <net/net_namespace.h>
 #include <net/tc_act/tc_vlan.h>
 
@@ -55,7 +56,7 @@ struct mlxsw_sp_acl_ruleset {
 	struct rhash_head ht_node; /* Member of acl HT */
 	struct mlxsw_sp_acl_ruleset_ht_key ht_key;
 	struct rhashtable rule_ht;
-	unsigned int ref_count;
+	refcount_t ref_count;
 	unsigned int min_prio;
 	unsigned int max_prio;
 	unsigned long priv[];
@@ -99,7 +100,7 @@ static bool
 mlxsw_sp_acl_ruleset_is_singular(const struct mlxsw_sp_acl_ruleset *ruleset)
 {
 	/* We hold a reference on ruleset ourselves */
-	return ruleset->ref_count == 2;
+	return refcount_read(&ruleset->ref_count) == 2;
 }
 
 int mlxsw_sp_acl_ruleset_bind(struct mlxsw_sp *mlxsw_sp,
@@ -176,7 +177,7 @@ mlxsw_sp_acl_ruleset_create(struct mlxsw_sp *mlxsw_sp,
 	ruleset = kzalloc(alloc_size, GFP_KERNEL);
 	if (!ruleset)
 		return ERR_PTR(-ENOMEM);
-	ruleset->ref_count = 1;
+	refcount_set(&ruleset->ref_count, 1);
 	ruleset->ht_key.block = block;
 	ruleset->ht_key.chain_index = chain_index;
 	ruleset->ht_key.ops = ops;
@@ -222,13 +223,13 @@ static void mlxsw_sp_acl_ruleset_destroy(struct mlxsw_sp *mlxsw_sp,
 
 static void mlxsw_sp_acl_ruleset_ref_inc(struct mlxsw_sp_acl_ruleset *ruleset)
 {
-	ruleset->ref_count++;
+	refcount_inc(&ruleset->ref_count);
 }
 
 static void mlxsw_sp_acl_ruleset_ref_dec(struct mlxsw_sp *mlxsw_sp,
 					 struct mlxsw_sp_acl_ruleset *ruleset)
 {
-	if (--ruleset->ref_count)
+	if (!refcount_dec_and_test(&ruleset->ref_count))
 		return;
 	mlxsw_sp_acl_ruleset_destroy(mlxsw_sp, ruleset);
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index 50ea1eff02b2f..f20052776b3f2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -9,6 +9,7 @@
 #include <linux/rhashtable.h>
 #include <linux/netdevice.h>
 #include <linux/mutex.h>
+#include <linux/refcount.h>
 #include <net/devlink.h>
 #include <trace/events/mlxsw.h>
 
@@ -155,7 +156,7 @@ struct mlxsw_sp_acl_tcam_vregion {
 		struct mlxsw_sp_acl_tcam_rehash_ctx ctx;
 	} rehash;
 	struct mlxsw_sp *mlxsw_sp;
-	unsigned int ref_count;
+	refcount_t ref_count;
 };
 
 struct mlxsw_sp_acl_tcam_vchunk;
@@ -176,7 +177,7 @@ struct mlxsw_sp_acl_tcam_vchunk {
 	unsigned int priority; /* Priority within the vregion and group */
 	struct mlxsw_sp_acl_tcam_vgroup *vgroup;
 	struct mlxsw_sp_acl_tcam_vregion *vregion;
-	unsigned int ref_count;
+	refcount_t ref_count;
 };
 
 struct mlxsw_sp_acl_tcam_entry {
@@ -769,7 +770,7 @@ mlxsw_sp_acl_tcam_vregion_create(struct mlxsw_sp *mlxsw_sp,
 	vregion->tcam = tcam;
 	vregion->mlxsw_sp = mlxsw_sp;
 	vregion->vgroup = vgroup;
-	vregion->ref_count = 1;
+	refcount_set(&vregion->ref_count, 1);
 
 	vregion->key_info = mlxsw_afk_key_info_get(afk, elusage);
 	if (IS_ERR(vregion->key_info)) {
@@ -856,7 +857,7 @@ mlxsw_sp_acl_tcam_vregion_get(struct mlxsw_sp *mlxsw_sp,
 			 */
 			return ERR_PTR(-EOPNOTSUPP);
 		}
-		vregion->ref_count++;
+		refcount_inc(&vregion->ref_count);
 		return vregion;
 	}
 
@@ -871,7 +872,7 @@ static void
 mlxsw_sp_acl_tcam_vregion_put(struct mlxsw_sp *mlxsw_sp,
 			      struct mlxsw_sp_acl_tcam_vregion *vregion)
 {
-	if (--vregion->ref_count)
+	if (!refcount_dec_and_test(&vregion->ref_count))
 		return;
 	mlxsw_sp_acl_tcam_vregion_destroy(mlxsw_sp, vregion);
 }
@@ -924,7 +925,7 @@ mlxsw_sp_acl_tcam_vchunk_create(struct mlxsw_sp *mlxsw_sp,
 	INIT_LIST_HEAD(&vchunk->ventry_list);
 	vchunk->priority = priority;
 	vchunk->vgroup = vgroup;
-	vchunk->ref_count = 1;
+	refcount_set(&vchunk->ref_count, 1);
 
 	vregion = mlxsw_sp_acl_tcam_vregion_get(mlxsw_sp, vgroup,
 						priority, elusage);
@@ -1008,7 +1009,7 @@ mlxsw_sp_acl_tcam_vchunk_get(struct mlxsw_sp *mlxsw_sp,
 		if (WARN_ON(!mlxsw_afk_key_info_subset(vchunk->vregion->key_info,
 						       elusage)))
 			return ERR_PTR(-EINVAL);
-		vchunk->ref_count++;
+		refcount_inc(&vchunk->ref_count);
 		return vchunk;
 	}
 	return mlxsw_sp_acl_tcam_vchunk_create(mlxsw_sp, vgroup,
@@ -1019,7 +1020,7 @@ static void
 mlxsw_sp_acl_tcam_vchunk_put(struct mlxsw_sp *mlxsw_sp,
 			     struct mlxsw_sp_acl_tcam_vchunk *vchunk)
 {
-	if (--vchunk->ref_count)
+	if (!refcount_dec_and_test(&vchunk->ref_count))
 		return;
 	mlxsw_sp_acl_tcam_vchunk_destroy(mlxsw_sp, vchunk);
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 7164f9e6370fb..87617df694ab2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -501,7 +501,7 @@ struct mlxsw_sp_rt6 {
 
 struct mlxsw_sp_lpm_tree {
 	u8 id; /* tree ID */
-	unsigned int ref_count;
+	refcount_t ref_count;
 	enum mlxsw_sp_l3proto proto;
 	unsigned long prefix_ref_count[MLXSW_SP_PREFIX_COUNT];
 	struct mlxsw_sp_prefix_usage prefix_usage;
@@ -578,7 +578,7 @@ mlxsw_sp_lpm_tree_find_unused(struct mlxsw_sp *mlxsw_sp)
 
 	for (i = 0; i < mlxsw_sp->router->lpm.tree_count; i++) {
 		lpm_tree = &mlxsw_sp->router->lpm.trees[i];
-		if (lpm_tree->ref_count == 0)
+		if (refcount_read(&lpm_tree->ref_count) == 0)
 			return lpm_tree;
 	}
 	return NULL;
@@ -654,7 +654,7 @@ mlxsw_sp_lpm_tree_create(struct mlxsw_sp *mlxsw_sp,
 	       sizeof(lpm_tree->prefix_usage));
 	memset(&lpm_tree->prefix_ref_count, 0,
 	       sizeof(lpm_tree->prefix_ref_count));
-	lpm_tree->ref_count = 1;
+	refcount_set(&lpm_tree->ref_count, 1);
 	return lpm_tree;
 
 err_left_struct_set:
@@ -678,7 +678,7 @@ mlxsw_sp_lpm_tree_get(struct mlxsw_sp *mlxsw_sp,
 
 	for (i = 0; i < mlxsw_sp->router->lpm.tree_count; i++) {
 		lpm_tree = &mlxsw_sp->router->lpm.trees[i];
-		if (lpm_tree->ref_count != 0 &&
+		if (refcount_read(&lpm_tree->ref_count) &&
 		    lpm_tree->proto == proto &&
 		    mlxsw_sp_prefix_usage_eq(&lpm_tree->prefix_usage,
 					     prefix_usage)) {
@@ -691,14 +691,15 @@ mlxsw_sp_lpm_tree_get(struct mlxsw_sp *mlxsw_sp,
 
 static void mlxsw_sp_lpm_tree_hold(struct mlxsw_sp_lpm_tree *lpm_tree)
 {
-	lpm_tree->ref_count++;
+	refcount_inc(&lpm_tree->ref_count);
 }
 
 static void mlxsw_sp_lpm_tree_put(struct mlxsw_sp *mlxsw_sp,
 				  struct mlxsw_sp_lpm_tree *lpm_tree)
 {
-	if (--lpm_tree->ref_count == 0)
-		mlxsw_sp_lpm_tree_destroy(mlxsw_sp, lpm_tree);
+	if (!refcount_dec_and_test(&lpm_tree->ref_count))
+		return;
+	mlxsw_sp_lpm_tree_destroy(mlxsw_sp, lpm_tree);
 }
 
 #define MLXSW_SP_LPM_TREE_MIN 1 /* tree 0 is reserved */
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 6c749c148148d..6397ff0dc951c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -61,7 +61,7 @@ struct mlxsw_sp_bridge_port {
 	struct mlxsw_sp_bridge_device *bridge_device;
 	struct list_head list;
 	struct list_head vlans_list;
-	unsigned int ref_count;
+	refcount_t ref_count;
 	u8 stp_state;
 	unsigned long flags;
 	bool mrouter;
@@ -495,7 +495,7 @@ mlxsw_sp_bridge_port_create(struct mlxsw_sp_bridge_device *bridge_device,
 			     BR_MCAST_FLOOD;
 	INIT_LIST_HEAD(&bridge_port->vlans_list);
 	list_add(&bridge_port->list, &bridge_device->ports_list);
-	bridge_port->ref_count = 1;
+	refcount_set(&bridge_port->ref_count, 1);
 
 	err = switchdev_bridge_port_offload(brport_dev, mlxsw_sp_port->dev,
 					    NULL, NULL, NULL, false, extack);
@@ -531,7 +531,7 @@ mlxsw_sp_bridge_port_get(struct mlxsw_sp_bridge *bridge,
 
 	bridge_port = mlxsw_sp_bridge_port_find(bridge, brport_dev);
 	if (bridge_port) {
-		bridge_port->ref_count++;
+		refcount_inc(&bridge_port->ref_count);
 		return bridge_port;
 	}
 
@@ -558,7 +558,7 @@ static void mlxsw_sp_bridge_port_put(struct mlxsw_sp_bridge *bridge,
 {
 	struct mlxsw_sp_bridge_device *bridge_device;
 
-	if (--bridge_port->ref_count != 0)
+	if (!refcount_dec_and_test(&bridge_port->ref_count))
 		return;
 	bridge_device = bridge_port->bridge_device;
 	mlxsw_sp_bridge_port_destroy(bridge_port);
-- 
2.43.0




