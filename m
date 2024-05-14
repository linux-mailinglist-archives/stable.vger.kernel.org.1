Return-Path: <stable+bounces-43930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE108C5048
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E62D1F21194
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C334E139D15;
	Tue, 14 May 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cdxdBTtV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0BA54903;
	Tue, 14 May 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683147; cv=none; b=AHvFoWEP65v2nTxbIgn/jpjFo9Q5ornNMpCxIyXXMpI4vrQTogtleqecZvmBnkOMzc9fduGHQ1Jyn75ycKk5sc4iqMuMXAtcuyB7ClCju+mliaR2iuxkZWan8xo9PXeWWwYNd1lGbRxpe6QCDeTisuCQ/6N9VY2txFdAI9ROkVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683147; c=relaxed/simple;
	bh=PmozrRCC5Z1H/EqG8qQzNh/tTdxtaek/OkyTTJm0FxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAtQfgI81vukVTdTw3DmQ5/hVbklv7aFCbJjTxxfOTSfih6DrmEWok8n6mGMqfLXiS4dx09eyf62hNp4tjCEM3PJiK/hXBEtXA17HtnfWGjxvGUG5fEVK06TufMPeT4IbeWV8vDkS0fOFMfaBKQiZQwGjUvp/82ksBP8BaqCcJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cdxdBTtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6DCC2BD10;
	Tue, 14 May 2024 10:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683147;
	bh=PmozrRCC5Z1H/EqG8qQzNh/tTdxtaek/OkyTTJm0FxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdxdBTtVfpG2zWHN0aBz7o81R7xCvp9qBPClWNB24bL8ucptpb4anMSuUqwZqv+YC
	 SHzEckIKZgL7gGEZnYVM5x3WOnYYmWpaN+udEi8sObCy6eCIy7whhIZRIdJ7YoJ5kk
	 9YcatwyBnVDt5cFYuBUUYlUFAPEmfxDJd6mEZTOo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 173/336] drm/xe/xe_migrate: Cast to output precision before multiplying operands
Date: Tue, 14 May 2024 12:16:17 +0200
Message-ID: <20240514101045.134419295@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

[ Upstream commit 9cb46b31f3d08ed3fce86349e8c12f96d7c88717 ]

Addressing potential overflow in result of  multiplication of two lower
precision (u32) operands before widening it to higher precision
(u64).

-v2
Fix commit message and description. (Rodrigo)

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240401175300.3823653-1-himal.prasad.ghimiray@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit 34820967ae7b45411f8f4f737c2d63b0c608e0d7)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_migrate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index 70480c3056021..7a6ad3469d748 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -216,7 +216,7 @@ static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
 		if (vm->flags & XE_VM_FLAG_64K && level == 1)
 			flags = XE_PDE_64K;
 
-		entry = vm->pt_ops->pde_encode_bo(bo, map_ofs + (level - 1) *
+		entry = vm->pt_ops->pde_encode_bo(bo, map_ofs + (u64)(level - 1) *
 						  XE_PAGE_SIZE, pat_index);
 		xe_map_wr(xe, &bo->vmap, map_ofs + XE_PAGE_SIZE * level, u64,
 			  entry | flags);
@@ -224,7 +224,7 @@ static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
 
 	/* Write PDE's that point to our BO. */
 	for (i = 0; i < num_entries - num_level; i++) {
-		entry = vm->pt_ops->pde_encode_bo(bo, i * XE_PAGE_SIZE,
+		entry = vm->pt_ops->pde_encode_bo(bo, (u64)i * XE_PAGE_SIZE,
 						  pat_index);
 
 		xe_map_wr(xe, &bo->vmap, map_ofs + XE_PAGE_SIZE +
@@ -280,7 +280,7 @@ static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
 #define VM_SA_UPDATE_UNIT_SIZE		(XE_PAGE_SIZE / NUM_VMUSA_UNIT_PER_PAGE)
 #define NUM_VMUSA_WRITES_PER_UNIT	(VM_SA_UPDATE_UNIT_SIZE / sizeof(u64))
 	drm_suballoc_manager_init(&m->vm_update_sa,
-				  (map_ofs / XE_PAGE_SIZE - NUM_KERNEL_PDE) *
+				  (size_t)(map_ofs / XE_PAGE_SIZE - NUM_KERNEL_PDE) *
 				  NUM_VMUSA_UNIT_PER_PAGE, 0);
 
 	m->pt_bo = bo;
@@ -479,7 +479,7 @@ static void emit_pte(struct xe_migrate *m,
 	struct xe_vm *vm = m->q->vm;
 	u16 pat_index;
 	u32 ptes;
-	u64 ofs = at_pt * XE_PAGE_SIZE;
+	u64 ofs = (u64)at_pt * XE_PAGE_SIZE;
 	u64 cur_ofs;
 
 	/* Indirect access needs compression enabled uncached PAT index */
-- 
2.43.0




