Return-Path: <stable+bounces-62156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D94E93E635
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06D41F2163A
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EFB6BFC7;
	Sun, 28 Jul 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CagLrVLN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA21E487;
	Sun, 28 Jul 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181417; cv=none; b=GkYPmSce7bS4WxsghGzKS5aTEOa6G45NWOFT3fC2Btqql5AGELD2h75ORFMg3zMlz5jSi/tvUd48LdAV1bQ6OIOjqJAWu3P0xc7CWVWByzl8v1V0KMnkhhdH2CSZn4EST/audZXoxct/scwbvB6pxKe/kKli4jCkVg2KAy7h1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181417; c=relaxed/simple;
	bh=0GsaY9VrGRPabn9WDS9d3XvtsMkIwTkH0atVIZJV17s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7HJvOkE4JTHEKHLMwgN5N2X0s9dCi9gW62hUViZK6KSpgx5mx/HYpuH+lhjjwFNnagE8mIT8mvrjdKCsa0+6yv2Yz6wuvSO50Xzh9n+WozD64+b1U8+WB3781IgEuJ89Pd5b4KguVy/vfDf91xeSfImwl8KvvJ5pDF3uoDQE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CagLrVLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88010C116B1;
	Sun, 28 Jul 2024 15:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181416;
	bh=0GsaY9VrGRPabn9WDS9d3XvtsMkIwTkH0atVIZJV17s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CagLrVLNKYZO5NLAuSiNC1EJfJ5IbPWGrPkrhiCzy+BEDPUNLtxWIjyok/DVLKMQP
	 7NXiXLKeeNPrkhf5Jy/4GDf7X9dSGAXwyuSFrDUGMQxsCTtAloFSWUriw2+ZR3Qnxv
	 RbmLm0m2pxbQaB8X+FhXKc0uhQNB1T4axmAAWHM6fsMYVfEkeCd7f+op6edW0kOx9j
	 9bI1eOOJLZdItbF1cfRzK+qJxvfqlsky6STi/L/UAudz4DjfxFioh9TF3aCe41mL2U
	 U/us1wNxJoVo1xJXVOcaEr8FN+Q2OqVYIWFvRKM1NSo0+IqfSEjkUdg4/zdAiJ48mP
	 QOr5DPZ60cNtg==
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
	surbhi.kakarya@amd.com,
	sunran001@208suo.com,
	chongli2@amd.com,
	danijel.slivka@amd.com,
	Jingwen.Chen2@amd.com,
	YiPeng.Chai@amd.com,
	bokun.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 12/34] drm/amdgpu: Add lock around VF RLCG interface
Date: Sun, 28 Jul 2024 11:40:36 -0400
Message-ID: <20240728154230.2046786-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154230.2046786-1-sashal@kernel.org>
References: <20240728154230.2046786-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 33f791d92ddf3..eb4a1f4318333 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4048,6 +4048,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->grbm_idx_mutex);
 	mutex_init(&adev->mn_lock);
 	mutex_init(&adev->virt.vf_errors.lock);
+	mutex_init(&adev->virt.rlcg_reg_lock);
 	hash_init(adev->mn_hash);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 54ab51a4ada77..972a58f0f4924 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -980,6 +980,9 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 	scratch_reg1 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg1;
 	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
 	scratch_reg3 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg3;
+
+	mutex_lock(&adev->virt.rlcg_reg_lock);
+
 	if (reg_access_ctrl->spare_int)
 		spare_int = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spare_int;
 
@@ -1036,6 +1039,9 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 	}
 
 	ret = readl(scratch_reg0);
+
+	mutex_unlock(&adev->virt.rlcg_reg_lock);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 642f1fd287d83..0ec246c74570c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -272,6 +272,8 @@ struct amdgpu_virt {
 
 	/* the ucode id to signal the autoload */
 	uint32_t autoload_ucode_id;
+
+	struct mutex rlcg_reg_lock;
 };
 
 struct amdgpu_video_codec_info;
-- 
2.43.0


