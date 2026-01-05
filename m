Return-Path: <stable+bounces-204770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC465CF3C95
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C33543009288
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1D928750C;
	Mon,  5 Jan 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Drpk1y+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD01F2868B0
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619150; cv=none; b=WYUfBMZdQ5ToXgvrslKRkx0O8DG0isywbL+/yXNleGFE2t2dqtl92lftyC+b9RZut5zKzz66qNWKONWQxo/XK+8G7TfWeyNtHU4xhwEQUSVBdz33S1vI0531YzhLBMMXf2yoNjh0VZ+4dDWnr6ZnvEihyltKn9WdMJQ6Oc7g02Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619150; c=relaxed/simple;
	bh=/V5gCu5+rPAybJx9Glz9oUKmg4+zVE4dngED2MurTqI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qUSTK3+MoZRYxoBDWH09lEB1pn+BjHd7Ua7KqDLl/+y4Odh4KwL1Y2RQT0VK27dKY/7ZQRMDUO3WAfJvhYLD3GyHZM1/31M9+5kMzWVmIMq6qT9Brw7uJDLvtEClBu9bfydK5acAVIiQephSGq1/ABYr4tqSuRaJQyXd+UFeiwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Drpk1y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E279C116D0;
	Mon,  5 Jan 2026 13:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619150;
	bh=/V5gCu5+rPAybJx9Glz9oUKmg4+zVE4dngED2MurTqI=;
	h=Subject:To:Cc:From:Date:From;
	b=1Drpk1y+R0V46815GHmjXOlczExGiD5VNWmHEeM1Zlo27TdNCCB/NTmNdWrKaVcbk
	 maDnkPCSyJZV07KyXYtU+xcN7XEsoU+X8O6EcbsSTKYFEL0aMr7dTB3Hs/4DlUHTQq
	 FYr/4AUL1W1E3ixiy1pvU+u0HAbPabGd6LymdIsk=
Subject: FAILED: patch "[PATCH] drm/amdgpu: add missing lock to amdgpu_ttm_access_memory_sdma" failed to apply to 6.1-stable tree
To: pierre-eric.pelloux-prayer@amd.com,alexander.deucher@amd.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:19:04 +0100
Message-ID: <2026010504-compacter-plow-0408@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4fa944255be521b1bbd9780383f77206303a3a5c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010504-compacter-plow-0408@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4fa944255be521b1bbd9780383f77206303a3a5c Mon Sep 17 00:00:00 2001
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Date: Tue, 25 Nov 2025 10:48:39 +0100
Subject: [PATCH] drm/amdgpu: add missing lock to amdgpu_ttm_access_memory_sdma
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Users of ttm entities need to hold the gtt_window_lock before using them
to guarantee proper ordering of jobs.

Cc: stable@vger.kernel.org
Fixes: cb5cc4f573e1 ("drm/amdgpu: improve debug VRAM access performance using sdma")
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5475f7117f10..1b799f895dbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1486,6 +1486,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	if (r)
 		goto out;
 
+	mutex_lock(&adev->mman.gtt_window_lock);
 	amdgpu_res_first(abo->tbo.resource, offset, len, &src_mm);
 	src_addr = amdgpu_ttm_domain_start(adev, bo->resource->mem_type) +
 		src_mm.start;
@@ -1500,6 +1501,7 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
 	WARN_ON(job->ibs[0].length_dw > num_dw);
 
 	fence = amdgpu_job_submit(job);
+	mutex_unlock(&adev->mman.gtt_window_lock);
 
 	if (!dma_fence_wait_timeout(fence, false, adev->sdma_timeout))
 		r = -ETIMEDOUT;


