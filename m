Return-Path: <stable+bounces-164958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 015F7B13C9E
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 16:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE3F3AA397
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB06270577;
	Mon, 28 Jul 2025 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plTT1x7h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561B27055A
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711195; cv=none; b=bgPqbPPxY1Kz0w9S+mkHClX+kHm33rVy4iBjyCH69jmRzJw8i2W6V4p3KitKzVqIKlBXHgy/CX7c7vcrW2gwux2eSlWYYSgu1v/ahpC+V0/EL5dacTcLqbsFmWIq9huxp+zFKDW8Z2QP1MkH9UPygzBbfj45CkPS0sWoPOruyeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711195; c=relaxed/simple;
	bh=uff0+fPqv17IZjgVx89Pl+uS4ku4A+tRe5saup/XLm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojDIllMjDWHBTn0/mzU4Z2TJ94PO0XcH08hhOQ3wapzGlzTO2y5DIHqB9HgQ0vs398UGbLTanMqCyarcrADfwx6WeZQIOYfC7VCHSuTWjf0kS8KO8OyUZR0IPzzgAur7x8EWJ1FY3gVVw69rHU02Lx8eCPMExn6BLw+djtSC/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plTT1x7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CB2C4CEF9;
	Mon, 28 Jul 2025 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753711195;
	bh=uff0+fPqv17IZjgVx89Pl+uS4ku4A+tRe5saup/XLm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plTT1x7heA0nF0uyRXW/OQAXhiQnJzvooeg+EiIqLkmSGJaK+7Cimo1V7RTaNawsm
	 U81XxjpzYzDw3BhkJyEnlId/B451HeZn8ZPS/m2kmWiY7mwKyE/WfPsnsdJ3414iC/
	 S69GSAwRRON7oXKISyfGiJa8CkcAvnd9JoaM1O6TnMpRXnLv4s6jKPj8ct1NwDAt2o
	 ibWGLHCnjRU7VJQE9pT21C2rtakFBUTH0XzUYuDrVdoJ+urQ9HLr/5JFJ0rYrmyOIj
	 D1zOr6R7ZCoHk6covT4WnJtiWEQGnDwcv3PdG1tV9a3AuBX6+S0hPQbxRIxWuqYnBS
	 BGS5kMX8j7Eww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 2/2] Revert "drm/gem-shmem: Use dma_buf from GEM object instance"
Date: Mon, 28 Jul 2025 09:59:47 -0400
Message-Id: <20250728135947.2330347-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728135947.2330347-1-sashal@kernel.org>
References: <2025072830-reveler-drop-down-d571@gregkh>
 <20250728135947.2330347-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 6d496e9569983a0d7a05be6661126d0702cf94f7 ]

This reverts commit 1a148af06000e545e714fe3210af3d77ff903c11.

The dma_buf field in struct drm_gem_object is not stable over the
object instance's lifetime. The field becomes NULL when user space
releases the final GEM handle on the buffer object. This resulted
in a NULL-pointer deref.

Workarounds in commit 5307dce878d4 ("drm/gem: Acquire references on
GEM handles for framebuffers") and commit f6bfc9afc751 ("drm/framebuffer:
Acquire internal references on GEM handles") only solved the problem
partially. They especially don't work for buffer objects without a DRM
framebuffer associated.

Hence, this revert to going back to using .import_attach->dmabuf.

v3:
- cc stable

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Cc: <stable@vger.kernel.org> # v6.15+
Link: https://lore.kernel.org/r/20250715155934.150656-7-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index de197a932852..37333aadd550 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -339,7 +339,7 @@ int drm_gem_shmem_vmap(struct drm_gem_shmem_object *shmem,
 	int ret = 0;
 
 	if (drm_gem_is_imported(obj)) {
-		ret = dma_buf_vmap(obj->dma_buf, map);
+		ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
 	} else {
 		pgprot_t prot = PAGE_KERNEL;
 
@@ -399,7 +399,7 @@ void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem,
 	struct drm_gem_object *obj = &shmem->base;
 
 	if (drm_gem_is_imported(obj)) {
-		dma_buf_vunmap(obj->dma_buf, map);
+		dma_buf_vunmap(obj->import_attach->dmabuf, map);
 	} else {
 		dma_resv_assert_held(shmem->base.resv);
 
-- 
2.39.5


