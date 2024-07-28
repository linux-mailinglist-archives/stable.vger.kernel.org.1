Return-Path: <stable+bounces-62186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2A993E6B8
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB741C20410
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CCD77114;
	Sun, 28 Jul 2024 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2Xzk5PD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C764F80BEC;
	Sun, 28 Jul 2024 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181613; cv=none; b=GKzQxxykvD4ASXcBoAwYljSdofCu7g8d2QwOPtIc1wNv2mpv/Vc8lBopCUHWOzL23DxiCAq9YS76zHRYr9W5Ara6+O+xLATkW5rM4eVpUUpnbkjCPrdRjFt1ePn84kkzSoT6KlzqhXTJAKw6P+8h1F8MBi1dXQZBCTAJ4AkbB+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181613; c=relaxed/simple;
	bh=TqmSdvR3Q5ttZfbcV4H5I4Vci47hGan+zqVVas42Tw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdFXVmE9f49BWY+hQVPydF4RlftEkaCvHm/alonzos3neSneKPYnlv3nVLXgJFhVfu0bb+M8T56Ro+Y8Z2r/4cpLwAJ8c6BN5Nyza2mbaGfSzrYFjZgfDhtBmitjEwkuykjQC9/46f/9Njc6t+PgaZHjyMeyAIooWgNB88i/27I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2Xzk5PD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C54C116B1;
	Sun, 28 Jul 2024 15:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181613;
	bh=TqmSdvR3Q5ttZfbcV4H5I4Vci47hGan+zqVVas42Tw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2Xzk5PDxoCglwd9WSYiIHt71W3qYnBa1XvkddukzMy/2r5L7DWy7VwqOOpt0XFPG
	 sfKQYkZOskq7XvcQjXXC8SnbDqN+j/HaDMeBYJA7m9Wf3vmleeTZ1EwU6j2N3ovCKF
	 PV+6haQrj8IiuvaCh4qtDUb84vFWVS1xvfLsU++ziUos78hEtCa3pFGjAFePV1DsKx
	 xtHvd97Yz49nWf+SCPkVPN7ArhcH68NPgv1GyzFColG3fiKulXL/cMKuuHb3kNJShx
	 fw5mBxRSoHoZKhj9VcLRgSYpK0AmmlYQhhAS/mEbWDy7w/LZXqEMWmRex5w8GMhXzp
	 a9q813VmvaN+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Victor Skvortsov <victor.skvortsov@amd.com>,
	Zhigang Luo <zhigang.luo@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	mario.limonciello@amd.com,
	lijo.lazar@amd.com,
	Jun.Ma2@amd.com,
	candice.li@amd.com,
	victorchengchi.lu@amd.com,
	andrealmeid@igalia.com,
	hamza.mahfooz@amd.com,
	Zhigang.Luo@amd.com,
	sunran001@208suo.com,
	surbhi.kakarya@amd.com,
	chongli2@amd.com,
	danijel.slivka@amd.com,
	Jingwen.Chen2@amd.com,
	YiPeng.Chai@amd.com,
	bokun.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 08/20] drm/amdgpu: Add lock around VF RLCG interface
Date: Sun, 28 Jul 2024 11:45:06 -0400
Message-ID: <20240728154605.2048490-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154605.2048490-1-sashal@kernel.org>
References: <20240728154605.2048490-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Victor Skvortsov <victor.skvortsov@amd.com>

[ Upstream commit e864180ee49b4d30e640fd1e1d852b86411420c9 ]

flush_gpu_tlb may be called from another thread while
device_gpu_recover is running.

Both of these threads access registers through the VF
RLCG interface during VF Full Access. Add a lock around this interface
to prevent race conditions between these threads.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Reviewed-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e1227b7c71b16..4770ab5e773ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3561,6 +3561,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->grbm_idx_mutex);
 	mutex_init(&adev->mn_lock);
 	mutex_init(&adev->virt.vf_errors.lock);
+	mutex_init(&adev->virt.rlcg_reg_lock);
 	hash_init(adev->mn_hash);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 96857ae7fb5bc..ff4f52e07cc0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1003,6 +1003,9 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 	scratch_reg1 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg1;
 	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
 	scratch_reg3 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg3;
+
+	mutex_lock(&adev->virt.rlcg_reg_lock);
+
 	if (reg_access_ctrl->spare_int)
 		spare_int = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spare_int;
 
@@ -1058,6 +1061,9 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v
 	}
 
 	ret = readl(scratch_reg0);
+
+	mutex_unlock(&adev->virt.rlcg_reg_lock);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index fabb83e9d9aec..23b6efa9d25df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -263,6 +263,8 @@ struct amdgpu_virt {
 
 	/* the ucode id to signal the autoload */
 	uint32_t autoload_ucode_id;
+
+	struct mutex rlcg_reg_lock;
 };
 
 struct amdgpu_video_codec_info;
-- 
2.43.0


