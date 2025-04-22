Return-Path: <stable+bounces-134923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F7BA95B3A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0783B4757
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5C2254AF3;
	Tue, 22 Apr 2025 02:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3iJo5uw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B495254AED;
	Tue, 22 Apr 2025 02:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288197; cv=none; b=ZrtzKyQbr8KuafXza59zk9tfk0d54UkEkQcbJsMI5Wp0dYmxYinf103zStA6ipIyoQOvQnnPgbk5XMxnim15/IF4T0oi5xOQGWUr4xgcUglChpU95xUmi/kdeyUuWEl+lQ+iwi9yHThcgpmy3SxAzNs8n7yfRg6JTbVQ2+PNOH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288197; c=relaxed/simple;
	bh=167VzBc/6G/IIdA/VUKDCBRnVuwCe9wGIn4ON4F9ugs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sVcE7NZv1UUIbfXVe/qLYwNV4hOACpnyxtksVi8wAAA3BRk38h9mGhtXcjJx8g6UlB04zMFlQt9Kykhfv0VDHcKyYiCzKH1LSFJZ9m7VFI/u1R415lGemoSZFqDnrHtjRxjIX/+PKhKqzMgwbFiwJIR57M/SlA/vwAE2J4udosU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3iJo5uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7408AC4CEE4;
	Tue, 22 Apr 2025 02:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288197;
	bh=167VzBc/6G/IIdA/VUKDCBRnVuwCe9wGIn4ON4F9ugs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3iJo5uwwzRX07gtly7MleKIElv2iN0h21x/vD+Sz20PvsODw/61qmAXJjAHgLL+T
	 fUH2wqMfmXFQB1lP139u6Cfb4MGk464Jvae5sqzfB5/SuXqIlxeh292OXXyhJzOzE5
	 PyMwnyLD7mkIDqrrbB/XtJsFvAX4BiRVOSQUgxFVV9QDtK5kO9CIdp7Tjwdb3i8AuP
	 4yJcEKtv9XQPbXLTzyBWbmx+LMEDNjrKSiTyQRjwUobAK/AZRPnwphJNopUx0KWfV4
	 JHtQk3szPKzsAq/oXLJ5MnNEBMEbetRY4p+JZvUNdvlGxKQ6Krqiqi5rOPURn73U1Y
	 zTFBytpYONnzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	airlied@gmail.com,
	simona@ffwll.ch,
	Hawking.Zhang@amd.com,
	lijo.lazar@amd.com,
	Jack.Xiao@amd.com,
	Jesse.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 25/30] drm/amdgpu: use a dummy owner for sysfs triggered cleaner shaders v4
Date: Mon, 21 Apr 2025 22:15:45 -0400
Message-Id: <20250422021550.1940809-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021550.1940809-1-sashal@kernel.org>
References: <20250422021550.1940809-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.3
Content-Transfer-Encoding: 8bit

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 447fab30955cf7dba7dd563f42b67c02284860c8 ]

Otherwise triggering sysfs multiple times without other submissions in
between only runs the shader once.

v2: add some comment
v3: re-add missing cast
v4: squash in semicolon fix

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 8b2ae7d492675e8af8902f103364bef59382b935)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c1f35ded684e8..506786784e32d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1411,9 +1411,11 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct drm_gpu_scheduler *sched = &ring->sched;
 	struct drm_sched_entity entity;
+	static atomic_t counter;
 	struct dma_fence *f;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
+	void *owner;
 	int i, r;
 
 	/* Initialize the scheduler entity */
@@ -1424,9 +1426,15 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 		goto err;
 	}
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, NULL,
-				     64, 0,
-				     &job);
+	/*
+	 * Use some unique dummy value as the owner to make sure we execute
+	 * the cleaner shader on each submission. The value just need to change
+	 * for each submission and is otherwise meaningless.
+	 */
+	owner = (void *)(unsigned long)atomic_inc_return(&counter);
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
+				     64, 0, &job);
 	if (r)
 		goto err;
 
-- 
2.39.5


