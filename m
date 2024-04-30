Return-Path: <stable+bounces-42391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374098B72D0
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6BC1C233FF
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBEA12D214;
	Tue, 30 Apr 2024 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E5JDCU/V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFBD12D761;
	Tue, 30 Apr 2024 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475516; cv=none; b=qsAiCX749WJINjFYK8uIxsmBMADY/yGA6vsKXqqEDsBoAPRHdYvtEz9oJMwYFkv6EQJIAyF8YMWXFJlaVuT+n5Z4IjoNYrDtDYhZ6ADF/JWaYokEI2IosFMUFqeLGg8noZXLNf4oFfXatZctBseviw8LCJbtspUU8f/jTnluek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475516; c=relaxed/simple;
	bh=d3JHN5+0gsv4AExkA3HzS8wwS6nnOZsNXVL/Q1aEvWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvUNjuQmf4M8JS3iWhxeh9ymqgWETbFnl+w5aHlyVHj4PgMF3gHV56xLUL/BIaa676T4Vk05814lJAhmZH4zTYc8I3g/yLwx6XvryPQdrHnf17k5GMnLLowC05g7Pgc2jhhoPgV71YoEMXVR4Aaf1PzepZ8WY2hDMsZDrR5BhSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E5JDCU/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1ACAC2BBFC;
	Tue, 30 Apr 2024 11:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475516;
	bh=d3JHN5+0gsv4AExkA3HzS8wwS6nnOZsNXVL/Q1aEvWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E5JDCU/Vx7+K8iFXnweOUZL0CQV8CEyxeuW2feyNPgagcPSzZ5pJkjEVKs9zhHNQb
	 bfHsCZSoDFYIijDc46GloclWvdUVhy9k+2vqUSpZYkRCk4hq8RKLWJQe0FIJ9OndYE
	 WLQaEw1qvfvwuuTnqd+4V/K8jtHV/2pdV3LqXogY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ido Schimmel <idosch@nvidia.com>,
	Alexander Zubkov <green@qrator.net>,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 081/186] mlxsw: spectrum_acl_tcam: Fix warning during rehash
Date: Tue, 30 Apr 2024 12:38:53 +0200
Message-ID: <20240430103100.386995228@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103058.010791820@linuxfoundation.org>
References: <20240430103058.010791820@linuxfoundation.org>
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

[ Upstream commit 743edc8547a92b6192aa1f1b6bb78233fa21dc9b ]

As previously explained, the rehash delayed work migrates filters from
one region to another. This is done by iterating over all chunks (all
the filters with the same priority) in the region and in each chunk
iterating over all the filters.

When the work runs out of credits it stores the current chunk and entry
as markers in the per-work context so that it would know where to resume
the migration from the next time the work is scheduled.

Upon error, the chunk marker is reset to NULL, but without resetting the
entry markers despite being relative to it. This can result in migration
being resumed from an entry that does not belong to the chunk being
migrated. In turn, this will eventually lead to a chunk being iterated
over as if it is an entry. Because of how the two structures happen to
be defined, this does not lead to KASAN splats, but to warnings such as
[1].

Fix by creating a helper that resets all the markers and call it from
all the places the currently only reset the chunk marker. For good
measures also call it when starting a completely new rehash. Add a
warning to avoid future cases.

[1]
WARNING: CPU: 7 PID: 1076 at drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c:407 mlxsw_afk_encode+0x242/0x2f0
Modules linked in:
CPU: 7 PID: 1076 Comm: kworker/7:24 Tainted: G        W          6.9.0-rc3-custom-00880-g29e61d91b77b #29
Hardware name: Mellanox Technologies Ltd. MSN3700/VMOD0005, BIOS 5.11 01/06/2019
Workqueue: mlxsw_core mlxsw_sp_acl_tcam_vregion_rehash_work
RIP: 0010:mlxsw_afk_encode+0x242/0x2f0
[...]
Call Trace:
 <TASK>
 mlxsw_sp_acl_atcam_entry_add+0xd9/0x3c0
 mlxsw_sp_acl_tcam_entry_create+0x5e/0xa0
 mlxsw_sp_acl_tcam_vchunk_migrate_all+0x109/0x290
 mlxsw_sp_acl_tcam_vregion_rehash_work+0x6c/0x470
 process_one_work+0x151/0x370
 worker_thread+0x2cb/0x3e0
 kthread+0xd0/0x100
 ret_from_fork+0x34/0x50
 </TASK>

Fixes: 6f9579d4e302 ("mlxsw: spectrum_acl: Remember where to continue rehash migration")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/cc17eed86b41dd829d39b07906fec074a9ce580e.1713797103.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlxsw/spectrum_acl_tcam.c        | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index 0902eb7651e14..e8c6078866213 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -730,6 +730,17 @@ static void mlxsw_sp_acl_tcam_vregion_rehash_work(struct work_struct *work)
 		mlxsw_sp_acl_tcam_vregion_rehash_work_schedule(vregion);
 }
 
+static void
+mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(struct mlxsw_sp_acl_tcam_rehash_ctx *ctx)
+{
+	/* The entry markers are relative to the current chunk and therefore
+	 * needs to be reset together with the chunk marker.
+	 */
+	ctx->current_vchunk = NULL;
+	ctx->start_ventry = NULL;
+	ctx->stop_ventry = NULL;
+}
+
 static void
 mlxsw_sp_acl_tcam_rehash_ctx_vchunk_changed(struct mlxsw_sp_acl_tcam_vchunk *vchunk)
 {
@@ -752,7 +763,7 @@ mlxsw_sp_acl_tcam_rehash_ctx_vregion_changed(struct mlxsw_sp_acl_tcam_vregion *v
 	 * the current chunk pointer to make sure all chunks
 	 * are properly migrated.
 	 */
-	vregion->rehash.ctx.current_vchunk = NULL;
+	mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(&vregion->rehash.ctx);
 }
 
 static struct mlxsw_sp_acl_tcam_vregion *
@@ -1220,7 +1231,7 @@ mlxsw_sp_acl_tcam_vchunk_migrate_end(struct mlxsw_sp *mlxsw_sp,
 {
 	mlxsw_sp_acl_tcam_chunk_destroy(mlxsw_sp, vchunk->chunk2);
 	vchunk->chunk2 = NULL;
-	ctx->current_vchunk = NULL;
+	mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(ctx);
 }
 
 static int
@@ -1252,6 +1263,8 @@ mlxsw_sp_acl_tcam_vchunk_migrate_one(struct mlxsw_sp *mlxsw_sp,
 		ventry = list_first_entry(&vchunk->ventry_list,
 					  typeof(*ventry), list);
 
+	WARN_ON(ventry->vchunk != vchunk);
+
 	list_for_each_entry_from(ventry, &vchunk->ventry_list, list) {
 		/* During rollback, once we reach the ventry that failed
 		 * to migrate, we are done.
@@ -1343,7 +1356,7 @@ mlxsw_sp_acl_tcam_vregion_migrate(struct mlxsw_sp *mlxsw_sp,
 		 * to vregion->region.
 		 */
 		swap(vregion->region, vregion->region2);
-		ctx->current_vchunk = NULL;
+		mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(ctx);
 		ctx->this_is_rollback = true;
 		err2 = mlxsw_sp_acl_tcam_vchunk_migrate_all(mlxsw_sp, vregion,
 							    ctx, credits);
@@ -1402,6 +1415,7 @@ mlxsw_sp_acl_tcam_vregion_rehash_start(struct mlxsw_sp *mlxsw_sp,
 
 	ctx->hints_priv = hints_priv;
 	ctx->this_is_rollback = false;
+	mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(ctx);
 
 	return 0;
 
-- 
2.43.0




