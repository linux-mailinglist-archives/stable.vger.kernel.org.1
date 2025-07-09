Return-Path: <stable+bounces-161417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B06AFE5BC
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 12:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A95D4823CA
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B852580DD;
	Wed,  9 Jul 2025 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Acjy2LpY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64408257AEE;
	Wed,  9 Jul 2025 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057030; cv=none; b=E6C3kVpatBKLSmJ+8DmnnPMiT8yLfsJP8YkvKKmFZxJKr6/n76e6ofl9F+QpG5pED+AbtIiAGtrQJVeSJKb1Os4iXplX19bo7AH1ORIJHl2DnlExRUhu0FyJ8Nlv74VRvQWMGxefAL/5DPAUEuTtxdjFSvesQu0JgWzuSXCyNSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057030; c=relaxed/simple;
	bh=Ty3nXIi4HmgfpzGYIeOEefnUtewrgna8f3Lra94ypwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=shzfmovRhgX5crPFzQv2cFqOnkvFAnW5z5HMs3CDzmINMUWWbPt+fYoXIroaLHRiDsAHv5+gVUAXXAMvF+Q3BVYScdsEVAPZb0lSvHqstMSW6b5QVn9ztrgKgkhfAj/lKs20MpnbOTLyD5vBAx5zyf39E/kqwrUBrHyxYeYChBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Acjy2LpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5600EC4CEEF;
	Wed,  9 Jul 2025 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057030;
	bh=Ty3nXIi4HmgfpzGYIeOEefnUtewrgna8f3Lra94ypwY=;
	h=From:To:Cc:Subject:Date:From;
	b=Acjy2LpYogics/rPMCgEe75vlwumy9gKZd2wnUZ5rzGIm9T47YcKUHxVhoR1UbT/+
	 uVM6qOYF8zlIza8edQkwLzvJs5pOc3b2btY94wlSpBsejC+9EXdguC+PBLyuJb9m8x
	 OGQUdzEdPQEiak4PiFlyILxpkJolNq+yBHrG9gi+U91pH/hSHH5a0Pbd4AmHjeWPcG
	 FxRJBneURIFy7MoDNrxfzKrQ9Bhx0MUUiOUP8lLU/OYHK79WII7vGmefKgsXnv2Fob
	 QWqykv+5sIMQV/oJsbI8laqtrTUhVEJbr0YmCHc2sdxIrv2gKsSP3+g1RDonmwTAFz
	 LfrlCxV/xpm+g==
From: Philipp Stanner <phasta@kernel.org>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panfrost: Fix scheduler workqueue bug
Date: Wed,  9 Jul 2025 12:29:58 +0200
Message-ID: <20250709102957.100849-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the GPU scheduler was ported to using a struct for its
initialization parameters, it was overlooked that panfrost creates a
distinct workqueue for timeout handling.

The pointer to this new workqueue is not initialized to the struct,
resulting in NULL being passed to the scheduler, which then uses the
system_wq for timeout handling.

Set the correct workqueue to the init args struct.

Cc: stable@vger.kernel.org # 6.15+
Fixes: 796a9f55a8d1 ("drm/sched: Use struct for drm_sched_init() params")
Reported-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Closes: https://lore.kernel.org/dri-devel/b5d0921c-7cbf-4d55-aa47-c35cd7861c02@igalia.com/
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 5657106c2f7d..15e2d505550f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -841,7 +841,6 @@ int panfrost_job_init(struct panfrost_device *pfdev)
 		.num_rqs = DRM_SCHED_PRIORITY_COUNT,
 		.credit_limit = 2,
 		.timeout = msecs_to_jiffies(JOB_TIMEOUT_MS),
-		.timeout_wq = pfdev->reset.wq,
 		.name = "pan_js",
 		.dev = pfdev->dev,
 	};
@@ -879,6 +878,7 @@ int panfrost_job_init(struct panfrost_device *pfdev)
 	pfdev->reset.wq = alloc_ordered_workqueue("panfrost-reset", 0);
 	if (!pfdev->reset.wq)
 		return -ENOMEM;
+	args.timeout_wq = pfdev->reset.wq;
 
 	for (j = 0; j < NUM_JOB_SLOTS; j++) {
 		js->queue[j].fence_context = dma_fence_context_alloc(1);
-- 
2.49.0


