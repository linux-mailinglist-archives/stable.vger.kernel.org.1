Return-Path: <stable+bounces-147702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FA5AC58CE
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B274C0DF5
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA5327FB10;
	Tue, 27 May 2025 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0A8sutfC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7742A9B;
	Tue, 27 May 2025 17:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368166; cv=none; b=SLu7zHRCjNTB6nNKlGlCQrV1sBZT6HincKyQWunj8pjX955cwJlEjTjSyPM6323ygN7cVjmoU0Hsl2TVSIrN5GS1U5t8kwnhwrJrUOJmHT5j0Us7TMb5JvTNyMSYMyIIK+2Zy+q+lxq9cAY7wpg7OHX1Q4IWNPAw4nZC6Zgl2oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368166; c=relaxed/simple;
	bh=xdoeLbVIXFbxt1SgQI3sJH/+h1Fyoo6ev92bElcOT18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3Ql30GjxI+hY/4V3vEy9boZGGOQNh3G8IzzBOQxCtGJRIIGKoSBYOI6hsRiXH9e8tuiIwdOrKrAWFR/YDZ3YHbs+nu4SQRmOicvi+dit3Deowabhsm8ZM0fZI/1HkzG2feXZGWGKLJZKxVJZ2/N98h5X9hiJGrFNib/jaxT8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0A8sutfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51DEC4CEE9;
	Tue, 27 May 2025 17:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748368166;
	bh=xdoeLbVIXFbxt1SgQI3sJH/+h1Fyoo6ev92bElcOT18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0A8sutfCMe+dUu+7MYlfVTUeM6QDaauj85kxKjIVnVaM+XvDU1Fa9BlHufPq0vaBz
	 cMqOD4YjNubuPdbv1IFV9GG/rI14k6sjy0b9pePxXRzOSSnUjuFfGQ0IgZ+Z58JlfZ
	 NQ1m/R8QlkqbflPJzZ1xAkffnXx2F08fxWjxxWkk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 620/783] drm/xe/sa: Always call drm_suballoc_manager_fini()
Date: Tue, 27 May 2025 18:26:57 +0200
Message-ID: <20250527162538.402062233@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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




