Return-Path: <stable+bounces-63266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E5394187D
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30757B25587
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845AA1898EE;
	Tue, 30 Jul 2024 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PsHeAWLv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307A189516;
	Tue, 30 Jul 2024 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356266; cv=none; b=hWsZerkh0fmywRjWNcwkKXQWU4T6h37YLidQ7mCQtoLbTEOuOHUMBbgcPPRn2uKx6QQXRtWhC7mIiEsOeEVPl9FZ9DdBwEFCHqmi2iNAgZWT7EHqQ8CNYQc0bk0K8xsTSjwofz9BZ0wvc48NcZuO0MuSpv+Y2sG0h9Vsu6qYH7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356266; c=relaxed/simple;
	bh=xZBwNyrauNHo6abpz6ppf2LFYlgOLZIbV3rnKAw0vGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puFg9B6sHurKJLqafiDVg6cdsFz4IfFA7WT82scZfdKqtgtMjg078pXtaWaxgi88SdVpk2GGCb+Ivn4qSU/HQ+03hEsTBc3GZ+x5uuOuAyRGP43bEzYUfkvUxUJvo7Iqyu5LRs/dzAu4zPHEGgKgTzj0rOVovw3Rwg6JGBi+N04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PsHeAWLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF73AC32782;
	Tue, 30 Jul 2024 16:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356266;
	bh=xZBwNyrauNHo6abpz6ppf2LFYlgOLZIbV3rnKAw0vGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PsHeAWLvzBuGx8rg0ec4CU4PPaD0fR0m2aWPzEuUsP1qOnUvmw1IUJxep0OaA1XEk
	 J0sl2mQtHW4Sqpj0OlTVikr5zVAladIaqSn9gmN7hYtH8dz+Ne9BcIBzC4YqBgXhzT
	 Vsn7Y8zcAe4l3EdaoV+iLV8kuTV9K6K7pyy+7CG0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Alexander Zubkov <green@qrator.net>,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 129/568] mlxsw: spectrum_acl_erp: Fix object nesting warning
Date: Tue, 30 Jul 2024 17:43:56 +0200
Message-ID: <20240730151644.913720695@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 97d833ceb27dc19f8777d63f90be4a27b5daeedf ]

ACLs in Spectrum-2 and newer ASICs can reside in the algorithmic TCAM
(A-TCAM) or in the ordinary circuit TCAM (C-TCAM). The former can
contain more ACLs (i.e., tc filters), but the number of masks in each
region (i.e., tc chain) is limited.

In order to mitigate the effects of the above limitation, the device
allows filters to share a single mask if their masks only differ in up
to 8 consecutive bits. For example, dst_ip/25 can be represented using
dst_ip/24 with a delta of 1 bit. The C-TCAM does not have a limit on the
number of masks being used (and therefore does not support mask
aggregation), but can contain a limited number of filters.

The driver uses the "objagg" library to perform the mask aggregation by
passing it objects that consist of the filter's mask and whether the
filter is to be inserted into the A-TCAM or the C-TCAM since filters in
different TCAMs cannot share a mask.

The set of created objects is dependent on the insertion order of the
filters and is not necessarily optimal. Therefore, the driver will
periodically ask the library to compute a more optimal set ("hints") by
looking at all the existing objects.

When the library asks the driver whether two objects can be aggregated
the driver only compares the provided masks and ignores the A-TCAM /
C-TCAM indication. This is the right thing to do since the goal is to
move as many filters as possible to the A-TCAM. The driver also forbids
two identical masks from being aggregated since this can only happen if
one was intentionally put in the C-TCAM to avoid a conflict in the
A-TCAM.

The above can result in the following set of hints:

H1: {mask X, A-TCAM} -> H2: {mask Y, A-TCAM} // X is Y + delta
H3: {mask Y, C-TCAM} -> H4: {mask Z, A-TCAM} // Y is Z + delta

After getting the hints from the library the driver will start migrating
filters from one region to another while consulting the computed hints
and instructing the device to perform a lookup in both regions during
the transition.

Assuming a filter with mask X is being migrated into the A-TCAM in the
new region, the hints lookup will return H1. Since H2 is the parent of
H1, the library will try to find the object associated with it and
create it if necessary in which case another hints lookup (recursive)
will be performed. This hints lookup for {mask Y, A-TCAM} will either
return H2 or H3 since the driver passes the library an object comparison
function that ignores the A-TCAM / C-TCAM indication.

This can eventually lead to nested objects which are not supported by
the library [1].

Fix by removing the object comparison function from both the driver and
the library as the driver was the only user. That way the lookup will
only return exact matches.

I do not have a reliable reproducer that can reproduce the issue in a
timely manner, but before the fix the issue would reproduce in several
minutes and with the fix it does not reproduce in over an hour.

Note that the current usefulness of the hints is limited because they
include the C-TCAM indication and represent aggregation that cannot
actually happen. This will be addressed in net-next.

[1]
WARNING: CPU: 0 PID: 153 at lib/objagg.c:170 objagg_obj_parent_assign+0xb5/0xd0
Modules linked in:
CPU: 0 PID: 153 Comm: kworker/0:18 Not tainted 6.9.0-rc6-custom-g70fbc2c1c38b #42
Hardware name: Mellanox Technologies Ltd. MSN3700C/VMOD0008, BIOS 5.11 10/10/2018
Workqueue: mlxsw_core mlxsw_sp_acl_tcam_vregion_rehash_work
RIP: 0010:objagg_obj_parent_assign+0xb5/0xd0
[...]
Call Trace:
 <TASK>
 __objagg_obj_get+0x2bb/0x580
 objagg_obj_get+0xe/0x80
 mlxsw_sp_acl_erp_mask_get+0xb5/0xf0
 mlxsw_sp_acl_atcam_entry_add+0xe8/0x3c0
 mlxsw_sp_acl_tcam_entry_create+0x5e/0xa0
 mlxsw_sp_acl_tcam_vchunk_migrate_one+0x16b/0x270
 mlxsw_sp_acl_tcam_vregion_rehash_work+0xbe/0x510
 process_one_work+0x151/0x370

Fixes: 9069a3817d82 ("lib: objagg: implement optimization hints assembly and use hints for object creation")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/mellanox/mlxsw/spectrum_acl_erp.c    | 13 -------------
 include/linux/objagg.h                            |  1 -
 lib/objagg.c                                      | 15 ---------------
 3 files changed, 29 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
index d231f4d2888be..9eee229303cce 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
@@ -1217,18 +1217,6 @@ static bool mlxsw_sp_acl_erp_delta_check(void *priv, const void *parent_obj,
 	return err ? false : true;
 }
 
-static int mlxsw_sp_acl_erp_hints_obj_cmp(const void *obj1, const void *obj2)
-{
-	const struct mlxsw_sp_acl_erp_key *key1 = obj1;
-	const struct mlxsw_sp_acl_erp_key *key2 = obj2;
-
-	/* For hints purposes, two objects are considered equal
-	 * in case the masks are the same. Does not matter what
-	 * the "ctcam" value is.
-	 */
-	return memcmp(key1->mask, key2->mask, sizeof(key1->mask));
-}
-
 static void *mlxsw_sp_acl_erp_delta_create(void *priv, void *parent_obj,
 					   void *obj)
 {
@@ -1308,7 +1296,6 @@ static void mlxsw_sp_acl_erp_root_destroy(void *priv, void *root_priv)
 static const struct objagg_ops mlxsw_sp_acl_erp_objagg_ops = {
 	.obj_size = sizeof(struct mlxsw_sp_acl_erp_key),
 	.delta_check = mlxsw_sp_acl_erp_delta_check,
-	.hints_obj_cmp = mlxsw_sp_acl_erp_hints_obj_cmp,
 	.delta_create = mlxsw_sp_acl_erp_delta_create,
 	.delta_destroy = mlxsw_sp_acl_erp_delta_destroy,
 	.root_create = mlxsw_sp_acl_erp_root_create,
diff --git a/include/linux/objagg.h b/include/linux/objagg.h
index 78021777df462..6df5b887dc547 100644
--- a/include/linux/objagg.h
+++ b/include/linux/objagg.h
@@ -8,7 +8,6 @@ struct objagg_ops {
 	size_t obj_size;
 	bool (*delta_check)(void *priv, const void *parent_obj,
 			    const void *obj);
-	int (*hints_obj_cmp)(const void *obj1, const void *obj2);
 	void * (*delta_create)(void *priv, void *parent_obj, void *obj);
 	void (*delta_destroy)(void *priv, void *delta_priv);
 	void * (*root_create)(void *priv, void *obj, unsigned int root_id);
diff --git a/lib/objagg.c b/lib/objagg.c
index 90f3aa68c30a0..1608895b009c8 100644
--- a/lib/objagg.c
+++ b/lib/objagg.c
@@ -906,20 +906,6 @@ static const struct objagg_opt_algo *objagg_opt_algos[] = {
 	[OBJAGG_OPT_ALGO_SIMPLE_GREEDY] = &objagg_opt_simple_greedy,
 };
 
-static int objagg_hints_obj_cmp(struct rhashtable_compare_arg *arg,
-				const void *obj)
-{
-	struct rhashtable *ht = arg->ht;
-	struct objagg_hints *objagg_hints =
-			container_of(ht, struct objagg_hints, node_ht);
-	const struct objagg_ops *ops = objagg_hints->ops;
-	const char *ptr = obj;
-
-	ptr += ht->p.key_offset;
-	return ops->hints_obj_cmp ? ops->hints_obj_cmp(ptr, arg->key) :
-				    memcmp(ptr, arg->key, ht->p.key_len);
-}
-
 /**
  * objagg_hints_get - obtains hints instance
  * @objagg:		objagg instance
@@ -958,7 +944,6 @@ struct objagg_hints *objagg_hints_get(struct objagg *objagg,
 				offsetof(struct objagg_hints_node, obj);
 	objagg_hints->ht_params.head_offset =
 				offsetof(struct objagg_hints_node, ht_node);
-	objagg_hints->ht_params.obj_cmpfn = objagg_hints_obj_cmp;
 
 	err = rhashtable_init(&objagg_hints->node_ht, &objagg_hints->ht_params);
 	if (err)
-- 
2.43.0




