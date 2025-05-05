Return-Path: <stable+bounces-140359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1060AAA7E2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E351888DD7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E5734223D;
	Mon,  5 May 2025 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmTj0zgv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9482342239;
	Mon,  5 May 2025 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484692; cv=none; b=i8aFzq9GG0bnOq9J1XVQggNPjP/oUQgmUOElySqrkju04IqE4GJgmqramoJuQDkdNnjMzJdLn4OOXT52de/lwENMmLePijHiUQJSxcVfQRJNoDFUpO9fadiFk8ts/B+Fd3uKxOhIKZx0BUzQVRAJu4ZZ8vrg3Rj1VRSeMuEEnKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484692; c=relaxed/simple;
	bh=iBWhV5CuJOIPXHIt9qKCHprpvJOEyFDNns6Oue+GIqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ewNxemid2Fl0imV9DJk7eint/VuP57C1pwIvvUWtrVfs6DDevlP4fsBvbJKwihKHtfyVj3y+AeJ2ET4Ugd7QIQcWUnkZPxquNBl0dq6CfW7v6g6s1vDg7sLIIsUQ9guSA6qbNn4BRJmCuc3a5hBNqaLF2OVPq7RruJV1ZgpvnnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmTj0zgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E2DC4CEF1;
	Mon,  5 May 2025 22:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484692;
	bh=iBWhV5CuJOIPXHIt9qKCHprpvJOEyFDNns6Oue+GIqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AmTj0zgvao64tIZyAPu6uOzwalQeyAqpDBBUmjWnnQYsW3tFsgx0Q/DVici6eNm7T
	 AQyzF8ZeEvohpylmfmsMWc+vp+jBeoEPrCtctiTk4NwoXQB4NxAgZ3Q2XqjwD0CrFY
	 lrmWD0nzt8qb2y95modXQqD+2Muk7y4W2tMdO8qRh4c3Ael3preKhZJ7wE4o5MgTbm
	 o118Waf7J+WVkMyMqjljrcd6zbonKRZhkMarzuHTT2JRz+TWjz5l5ZG8QXxQyVCf/c
	 n2Yu+UmCyCs9FYN6dXZAkXlK/uH/0D+2IRIRaLPqDgKAXWe5ybBK6E4bhDyeIeshCl
	 RKfc0mNkXXzdQ==
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
Subject: [PATCH AUTOSEL 6.14 610/642] drm/xe/sa: Always call drm_suballoc_manager_fini()
Date: Mon,  5 May 2025 18:13:46 -0400
Message-Id: <20250505221419.2672473-610-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index e055bed7ae555..4e7aba445ebc8 100644
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


