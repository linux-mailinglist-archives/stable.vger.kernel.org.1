Return-Path: <stable+bounces-140649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A6DAAAA62
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8EE188497D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5540E2DDCF5;
	Mon,  5 May 2025 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmOSFkrg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEE236AAE6;
	Mon,  5 May 2025 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485779; cv=none; b=Lo2j0hK/QVgP8bEgdrqe1jUaNOu/ofEHkj3i5zfUPsyMYmrFNdCmJ2rqLG2vd/zEWiXIejjLQhmrnEyBfk73aLYRPNEjpdUPriP3RS2vqREjC/+1R0ZfTyDihIutdDBJHC0b0b48qD/NYdnCs7uszCo4UbXGprgLrHN9T/Y2Sjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485779; c=relaxed/simple;
	bh=0WlM3M273eukAcoWZ4glCnJUCRC1U7yZ6IfN33uD3Sc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P2sSsdfKMtLmKPgx4Ipk6sIq6kepRMEgS5X+wHmFy6zRA8fYH1ilHTq50CbwgrynCcUgf4j2UG/ZHtwqUw1+EdNgobdjkZ5oVWh9XqlY8LCsu5MvP5Q9tCdSbyGiH8AUVz78scRFW4qvfC1pMLkPG2GJtD9aV7lnoELi5XJ0tnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmOSFkrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FFBC4CEE4;
	Mon,  5 May 2025 22:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485779;
	bh=0WlM3M273eukAcoWZ4glCnJUCRC1U7yZ6IfN33uD3Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kmOSFkrgvFXvieK0cqBHazs+1AWyDiI/vg117ldHXx7Re2ubMwAHP4daVdNBx4RqJ
	 YWH5V3/lOZ+lW360xarryhsif1gimce8gi99bF2A1lLEwzz825FM0pREjX9AXTWviV
	 9+pVxYNrsSTF7oMRVOGVOacw3IY43LKsjhP/PUNBM6INwWhOM1kcF1QwfX7t9RHyAh
	 UUo6sNF8IAPJTN3rJZaxPKSnnPh1K3c03Td6QZcFneXhrhPShYMDmrOAYU8J3NdDXI
	 Sj+VwbQA5DOHMe72wGnuwyK1Ep1UxZGOfDR8HCc60O+bWyLU7lVe4Kc462hkW6AkUU
	 m+sPMH5L9prEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 480/486] drm/xe/sa: Always call drm_suballoc_manager_fini()
Date: Mon,  5 May 2025 18:39:16 -0400
Message-Id: <20250505223922.2682012-480-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit 9cd3f4efc870463f17f6c29114c61fb6bfcaa291 ]

After successful call to drm_suballoc_manager_init() we should
make sure to call drm_suballoc_manager_fini() as it may include
some cleanup code even if we didn't start using it for real.

As we can abort init() early due to kvzalloc() failure, we should
either explicitly call drm_suballoc_manager_fini() or, even better,
postpone drm_suballoc_manager_init() once we finish all other
preparation steps, so we can rely on fini() that will do cleanup.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241220194205.995-2-michal.wajdeczko@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_sa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_sa.c b/drivers/gpu/drm/xe/xe_sa.c
index fe2cb2a96f788..1d42547590067 100644
--- a/drivers/gpu/drm/xe/xe_sa.c
+++ b/drivers/gpu/drm/xe/xe_sa.c
@@ -57,8 +57,6 @@ struct xe_sa_manager *xe_sa_bo_manager_init(struct xe_tile *tile, u32 size, u32
 	}
 	sa_manager->bo = bo;
 	sa_manager->is_iomem = bo->vmap.is_iomem;
-
-	drm_suballoc_manager_init(&sa_manager->base, managed_size, align);
 	sa_manager->gpu_addr = xe_bo_ggtt_addr(bo);
 
 	if (bo->vmap.is_iomem) {
@@ -72,6 +70,7 @@ struct xe_sa_manager *xe_sa_bo_manager_init(struct xe_tile *tile, u32 size, u32
 		memset(sa_manager->cpu_ptr, 0, bo->ttm.base.size);
 	}
 
+	drm_suballoc_manager_init(&sa_manager->base, managed_size, align);
 	ret = drmm_add_action_or_reset(&xe->drm, xe_sa_bo_manager_fini,
 				       sa_manager);
 	if (ret)
-- 
2.39.5


