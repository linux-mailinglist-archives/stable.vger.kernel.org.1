Return-Path: <stable+bounces-42000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1C28B70D7
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E85D1C219DA
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F345512C53F;
	Tue, 30 Apr 2024 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jeiTvh6u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00FD12C49F;
	Tue, 30 Apr 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474231; cv=none; b=W145uptgfUN1dK3ddBE4vyGDkUPQ23JeejKd+Z1jh5hNnYafPjGd05Fj7v0IfnIEiEHOgimELqlZx5fIEn3YoOgH3BWmMWvyOamzzMgLJbXgTHyX0OGkadmH7NxXoR9Zru7TTsMq0JXglYsOv81EObCriYNvq1OSRfMMG/fCyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474231; c=relaxed/simple;
	bh=1VZoNoooSxGauXvFdla9H4gL3zkXTwCGgi65/pKXsBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F14akCBjNLCShGj1kWVI1fXRSj/TRF2U5hNEqPT6PAk16DdVKoI909UKAdzIuqLmQCIjhxj4hYmuLdFCqA7lCDDcs4oYcrncJtlVYkLV2/YaK8UGcNT6D9CJyq0VebpZ/70ZwHuNJu+s9EXrvJRwEe2TMo1AtfDUBnNVf+9T/W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jeiTvh6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684E6C4AF18;
	Tue, 30 Apr 2024 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474230;
	bh=1VZoNoooSxGauXvFdla9H4gL3zkXTwCGgi65/pKXsBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jeiTvh6uCbhRSJ6bguljMBCgwklJs81W6aFtevFQp4AxzXztuULYjLlqZiNh2w6vp
	 mDzpG7Vyd+yns+grakWdatYLgp7LULC0SSvrtn2TBhNIBDKkscTv9ap7GyYPUxgQVo
	 jILH2+NNANnWg1JDAtHYyLHvIUqbaIZuj60nv9Jc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amit Cohen <amcohen@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexander Zubkov <green@qrator.net>,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 095/228] mlxsw: spectrum_acl_tcam: Fix race in region ID allocation
Date: Tue, 30 Apr 2024 12:37:53 +0200
Message-ID: <20240430103106.542540025@linuxfoundation.org>
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

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 627f9c1bb882765a84aa78015abbacd783d429be ]

Region identifiers can be allocated both when user space tries to insert
a new tc filter and when filters are migrated from one region to another
as part of the rehash delayed work.

There is no lock protecting the bitmap from which these identifiers are
allocated from, which is racy and leads to bad parameter errors from the
device's firmware.

Fix by converting the bitmap to IDA which handles its own locking. For
consistency, do the same for the group identifiers that are part of the
same structure.

Fixes: 2bffc5322fd8 ("mlxsw: spectrum_acl: Don't take mutex in mlxsw_sp_acl_tcam_vregion_rehash_work()")
Reported-by: Amit Cohen <amcohen@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/ce494b7940cadfe84f3e18da7785b51ef5f776e3.1713797103.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlxsw/spectrum_acl_tcam.c        | 61 ++++++++-----------
 .../mellanox/mlxsw/spectrum_acl_tcam.h        |  5 +-
 2 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index f20052776b3f2..b6a4652a6475a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -10,6 +10,7 @@
 #include <linux/netdevice.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
+#include <linux/idr.h>
 #include <net/devlink.h>
 #include <trace/events/mlxsw.h>
 
@@ -58,41 +59,43 @@ int mlxsw_sp_acl_tcam_priority_get(struct mlxsw_sp *mlxsw_sp,
 static int mlxsw_sp_acl_tcam_region_id_get(struct mlxsw_sp_acl_tcam *tcam,
 					   u16 *p_id)
 {
-	u16 id;
+	int id;
 
-	id = find_first_zero_bit(tcam->used_regions, tcam->max_regions);
-	if (id < tcam->max_regions) {
-		__set_bit(id, tcam->used_regions);
-		*p_id = id;
-		return 0;
-	}
-	return -ENOBUFS;
+	id = ida_alloc_max(&tcam->used_regions, tcam->max_regions - 1,
+			   GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	*p_id = id;
+
+	return 0;
 }
 
 static void mlxsw_sp_acl_tcam_region_id_put(struct mlxsw_sp_acl_tcam *tcam,
 					    u16 id)
 {
-	__clear_bit(id, tcam->used_regions);
+	ida_free(&tcam->used_regions, id);
 }
 
 static int mlxsw_sp_acl_tcam_group_id_get(struct mlxsw_sp_acl_tcam *tcam,
 					  u16 *p_id)
 {
-	u16 id;
+	int id;
 
-	id = find_first_zero_bit(tcam->used_groups, tcam->max_groups);
-	if (id < tcam->max_groups) {
-		__set_bit(id, tcam->used_groups);
-		*p_id = id;
-		return 0;
-	}
-	return -ENOBUFS;
+	id = ida_alloc_max(&tcam->used_groups, tcam->max_groups - 1,
+			   GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	*p_id = id;
+
+	return 0;
 }
 
 static void mlxsw_sp_acl_tcam_group_id_put(struct mlxsw_sp_acl_tcam *tcam,
 					   u16 id)
 {
-	__clear_bit(id, tcam->used_groups);
+	ida_free(&tcam->used_groups, id);
 }
 
 struct mlxsw_sp_acl_tcam_pattern {
@@ -1549,19 +1552,11 @@ int mlxsw_sp_acl_tcam_init(struct mlxsw_sp *mlxsw_sp,
 	if (max_tcam_regions < max_regions)
 		max_regions = max_tcam_regions;
 
-	tcam->used_regions = bitmap_zalloc(max_regions, GFP_KERNEL);
-	if (!tcam->used_regions) {
-		err = -ENOMEM;
-		goto err_alloc_used_regions;
-	}
+	ida_init(&tcam->used_regions);
 	tcam->max_regions = max_regions;
 
 	max_groups = MLXSW_CORE_RES_GET(mlxsw_sp->core, ACL_MAX_GROUPS);
-	tcam->used_groups = bitmap_zalloc(max_groups, GFP_KERNEL);
-	if (!tcam->used_groups) {
-		err = -ENOMEM;
-		goto err_alloc_used_groups;
-	}
+	ida_init(&tcam->used_groups);
 	tcam->max_groups = max_groups;
 	tcam->max_group_size = MLXSW_CORE_RES_GET(mlxsw_sp->core,
 						  ACL_MAX_GROUP_SIZE);
@@ -1575,10 +1570,8 @@ int mlxsw_sp_acl_tcam_init(struct mlxsw_sp *mlxsw_sp,
 	return 0;
 
 err_tcam_init:
-	bitmap_free(tcam->used_groups);
-err_alloc_used_groups:
-	bitmap_free(tcam->used_regions);
-err_alloc_used_regions:
+	ida_destroy(&tcam->used_groups);
+	ida_destroy(&tcam->used_regions);
 	mlxsw_sp_acl_tcam_rehash_params_unregister(mlxsw_sp);
 err_rehash_params_register:
 	mutex_destroy(&tcam->lock);
@@ -1591,8 +1584,8 @@ void mlxsw_sp_acl_tcam_fini(struct mlxsw_sp *mlxsw_sp,
 	const struct mlxsw_sp_acl_tcam_ops *ops = mlxsw_sp->acl_tcam_ops;
 
 	ops->fini(mlxsw_sp, tcam->priv);
-	bitmap_free(tcam->used_groups);
-	bitmap_free(tcam->used_regions);
+	ida_destroy(&tcam->used_groups);
+	ida_destroy(&tcam->used_regions);
 	mlxsw_sp_acl_tcam_rehash_params_unregister(mlxsw_sp);
 	mutex_destroy(&tcam->lock);
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
index 462bf448497d3..79a1d86065125 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
@@ -6,15 +6,16 @@
 
 #include <linux/list.h>
 #include <linux/parman.h>
+#include <linux/idr.h>
 
 #include "reg.h"
 #include "spectrum.h"
 #include "core_acl_flex_keys.h"
 
 struct mlxsw_sp_acl_tcam {
-	unsigned long *used_regions; /* bit array */
+	struct ida used_regions;
 	unsigned int max_regions;
-	unsigned long *used_groups;  /* bit array */
+	struct ida used_groups;
 	unsigned int max_groups;
 	unsigned int max_group_size;
 	struct mutex lock; /* guards vregion list */
-- 
2.43.0




