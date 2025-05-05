Return-Path: <stable+bounces-140051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C702CAAA475
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78361882F7E
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC4D2FF2AB;
	Mon,  5 May 2025 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOYExHC7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE42FF2A5;
	Mon,  5 May 2025 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483984; cv=none; b=EkHsPkTOeFPhizpDKBAP48E3AEv4OAIu5ahn7O62OLlPRV1kqAMFgc1CiRNK8Cg42bJ6E/klwg3Kaj2drZQuF5gZuOlRVwmm5Ud2yTsTOdT9tNa4B7/ia85kULCEk+hlUFX7RvYN5jt9b3jmTvID1Q+gmlS0wpN8mm3EgjPmHQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483984; c=relaxed/simple;
	bh=Dk8StzUec+MbyD2uE5mGEHh1S7+RVKjI5W7HqedHPTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VVaaez55BLnQr9KZ/e4EblcgwALMimRBgZWt/lK0p/ua1zZHffc8q+4loHA6XJdIJ2EYK0neOnRRfTUXUaUZSYdFt9xRKKTlEea1hoVktpTewxrVCgJYxolQn/4VeMVOYTbGFQI9pHpOu4qEIjkDe1bMwhBLjgenz7IZMir/sb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOYExHC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533FEC4CEEE;
	Mon,  5 May 2025 22:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483983;
	bh=Dk8StzUec+MbyD2uE5mGEHh1S7+RVKjI5W7HqedHPTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FOYExHC7buwDFyXfOotpRHXm5rzuAq/mvqVGdEDSoV3oHW4loE/7RgyoXFuG6EIel
	 wR/e/VTqL7trzK1AJekfE6quamdvKsebAOBz5+riOJHvMtmTDWqHHQS6Zo4Xvxx+HY
	 92XLV45nk7xWDGG4UzHKishArYrRE2LLQhf+JXsMd5EHxL4MaHPBcyPQXc61VM/6u5
	 6VFk3mJIQqts46b/lTM6E0p0tsEs84qOvVy/JKyiwhRCwrSLKs8xIiIl8AUq5AW0e8
	 rVPva0c6qDxwIB1TdqcqKj74Q37IQXjYX5JA0dP05ShDenX1HqoYW75EKreM/bWoaX
	 KEzlz9bY75d5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 304/642] drm/amdkfd: KFD release_work possible circular locking
Date: Mon,  5 May 2025 18:08:40 -0400
Message-Id: <20250505221419.2672473-304-sashal@kernel.org>
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

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 1b9366c601039d60546794c63fbb83ce8e53b978 ]

If waiting for gpu reset done in KFD release_work, thers is WARNING:
possible circular locking dependency detected

  #2  kfd_create_process
        kfd_process_mutex
          flush kfd release work

  #1  kfd release work
        wait for amdgpu reset work

  #0  amdgpu_device_gpu_reset
        kgd2kfd_pre_reset
          kfd_process_mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((work_completion)(&p->release_work));
                  lock((wq_completion)kfd_process_wq);
                  lock((work_completion)(&p->release_work));
   lock((wq_completion)amdgpu-reset-dev);

To fix this, KFD create process move flush release work outside
kfd_process_mutex.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index c3f2c0428e013..c9cbc0ecd9cb2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -842,6 +842,14 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 		return ERR_PTR(-EINVAL);
 	}
 
+	/* If the process just called exec(3), it is possible that the
+	 * cleanup of the kfd_process (following the release of the mm
+	 * of the old process image) is still in the cleanup work queue.
+	 * Make sure to drain any job before trying to recreate any
+	 * resource for this process.
+	 */
+	flush_workqueue(kfd_process_wq);
+
 	/*
 	 * take kfd processes mutex before starting of process creation
 	 * so there won't be a case where two threads of the same process
@@ -862,14 +870,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	if (process) {
 		pr_debug("Process already found\n");
 	} else {
-		/* If the process just called exec(3), it is possible that the
-		 * cleanup of the kfd_process (following the release of the mm
-		 * of the old process image) is still in the cleanup work queue.
-		 * Make sure to drain any job before trying to recreate any
-		 * resource for this process.
-		 */
-		flush_workqueue(kfd_process_wq);
-
 		process = create_process(thread);
 		if (IS_ERR(process))
 			goto out;
-- 
2.39.5


