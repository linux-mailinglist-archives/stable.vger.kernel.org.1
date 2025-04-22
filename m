Return-Path: <stable+bounces-134949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2099CA95B8A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6C8167712
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CC725F7A1;
	Tue, 22 Apr 2025 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWtgd1eg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BECA25F799;
	Tue, 22 Apr 2025 02:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288260; cv=none; b=J45iC292x68pFW5MMxob0czKrz1CbmfJdyjzw1S0FUsxnyM3ZOwDz8UmtWHm4FSdsIKrSwU74OYpR+xRsYapICca+UaRYf8J+haqJPRCd4Feyrp4SiZJl0yO5ymXhrkMVpSGnzgrfWHx1ZHQ7cVCl7uq6WZeS8lsAguP6flG8aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288260; c=relaxed/simple;
	bh=Iqc5H+me3bMBKriWpZEstR3sZpUWhp5y+/MdyUL4fJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctdnRC4o8WyPUUQXG10wVEHIH8tyFu16LjeXXOgFoObp0r4txSvws/zY4eFyPJNCYkbvoelvuPkBpbcSYnqmDOdWjh/q0cfrrkmpxdnDr5HxPIksbdlF9O+EI4MbycW1gm/mUmSPxxe6RXS1K4Hm72EaIWdZ6klM2wRKSslzHPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWtgd1eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF64C4CEE4;
	Tue, 22 Apr 2025 02:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288260;
	bh=Iqc5H+me3bMBKriWpZEstR3sZpUWhp5y+/MdyUL4fJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AWtgd1eguofUYE5LEIHILAkp70aHee5OuWYy+x5kUKhpO3t5K8Ef7Yz/SXgn1UIBF
	 WhH4zbDxxyGV9ENkW79+ii+M9xD6ahMYf2sfDew3l0k+t1BJHpLvHmMaqAPmtLXDit
	 MWntUx7t4ybPUFfisciN7ha6PjJjw/SGtHPaKPFGvTDgCA0Ex+zw9K7s+5Edk0/74F
	 mWGySRa3wiy4QR+ejCgBxWla2OI9Bl1HZbJAkVodc63gpUkilyzgjG82KzXnYbsu/8
	 Nt0QTu406JjCyVc7Dsuo3cGK2UgTdpTT2mqvO7yhZ7qIkQUrssIvucow0pycJV8UOT
	 isYh53m8QvhhQ==
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
Subject: [PATCH AUTOSEL 6.12 21/23] drm/amdgpu: use a dummy owner for sysfs triggered cleaner shaders v4
Date: Mon, 21 Apr 2025 22:17:01 -0400
Message-Id: <20250422021703.1941244-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021703.1941244-1-sashal@kernel.org>
References: <20250422021703.1941244-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.24
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
index 05ebb8216a55a..3c2ac5f4e814b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1426,9 +1426,11 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
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
@@ -1439,9 +1441,15 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
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


