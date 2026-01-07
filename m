Return-Path: <stable+bounces-206134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C295FCFD855
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 13:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A532308953D
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 11:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B753128AB;
	Wed,  7 Jan 2026 11:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIt4p55x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4EA13D539
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786869; cv=none; b=q9da8QUPr5lAQ7q4ie/LKt7jylm+RmShbTqFGnzULAfpxRzqkt8JoV3YDqpv0Mj2rBPlNQaObJ88zfZT5GI41LXHC4um/UKnRTckWmU0/FteJVVBiwsxC/AP6drpkT5Jo7Bb+eJuUFUCoLGIqFzXIFbg5ZV3bG1kiYHb/EmzRWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786869; c=relaxed/simple;
	bh=g2ZA7IxcZ/9xz+8DvQTwI0y8A6UcHGbXuWRBhWI0xCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cu1gBjAknEhUegBdiSLiRul0dDzhAIZaeAm5wsz3RUs5/rwjI49XfZkDl4cLyrz69tU0CTrXIz3FZdQqlBRoffVMLn770A6JAQa7/R5F7cqtoxSnVQuyGfMTQytkKGVo/5hl3w0BtV9Rn/ZVa+8oC+f+t92BLp/stiBN5BWw4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIt4p55x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BFBC4CEF7;
	Wed,  7 Jan 2026 11:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767786869;
	bh=g2ZA7IxcZ/9xz+8DvQTwI0y8A6UcHGbXuWRBhWI0xCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GIt4p55xTfSmYElWd3kg0T0EahEyDBB0y5QUoyNyqZs2aYlcs9tLaHpUVPbpB0+Ra
	 q7igvSgrernvSD4SuYWVPXPd2L0BNG3asjjouQzJG++5PNPVg+6nqE3UEaG3r33AFp
	 vLBVJpaNjTYgP+6YiDf4lAiNaHRbgpGBI4lVSfSegUKlnxSw98fAOjYpmXOPW1QYjr
	 h23HzgRINVptcw6awLePHgJ6myZPb1rdwwb9pEoMX0ITq+1hwXbTMBi8K2K966g+Gd
	 wrwd2HGOpVdGaq7EQDH8bhxkdiPIyOZiOj0/DjaYFbZYYBR0+VamuXrwND+2SKxHs4
	 bHxlBCxvOBxAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] drm/amdgpu: add missing lock to amdgpu_ttm_access_memory_sdma
Date: Wed,  7 Jan 2026 06:54:26 -0500
Message-ID: <20260107115426.3985494-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260107115426.3985494-1-sashal@kernel.org>
References: <2026010504-compacter-plow-0408@gregkh>
 <20260107115426.3985494-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

[ Upstream commit 4fa944255be521b1bbd9780383f77206303a3a5c ]

Users of ttm entities need to hold the gtt_window_lock before using them
to guarantee proper ordering of jobs.

Cc: stable@vger.kernel.org
Fixes: cb5cc4f573e1 ("drm/amdgpu: improve debug VRAM access performance using sdma")
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3870179acc58..4133afde22b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1425,6 +1425,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	if (r)
 		goto out;
 
+	mutex_lock(&adev->mman.gtt_window_lock);
 	amdgpu_res_first(abo->tbo.resource, offset, len, &src_mm);
 	src_addr = amdgpu_ttm_domain_start(adev, bo->resource->mem_type) +
 		src_mm.start;
@@ -1439,6 +1440,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	WARN_ON(job->ibs[0].length_dw > num_dw);
 
 	fence = amdgpu_job_submit(job);
+	mutex_unlock(&adev->mman.gtt_window_lock);
 
 	if (!dma_fence_wait_timeout(fence, false, adev->sdma_timeout))
 		r = -ETIMEDOUT;
-- 
2.51.0


