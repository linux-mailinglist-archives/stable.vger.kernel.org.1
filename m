Return-Path: <stable+bounces-140222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C77AAA63E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415AB17FC74
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C024D28FFFE;
	Mon,  5 May 2025 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr/yDJhB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96828FFEF;
	Mon,  5 May 2025 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484423; cv=none; b=VlstkP59VU4W/h3mUZ0sWjdqCXww3GNpFFc6o9ExZWvex8FVcqy9yDUjxwATg3R/qI2nTZ3ktZs/H5OUtko/BnkuC32eO2/8KXR4wZAz6NlNcpEJftK9qwCeXa55qyYt4XvzA6Ej/KgR00hUiEIDxu04NW8VkdZFDo1SPM6+UYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484423; c=relaxed/simple;
	bh=FhclLGWzK85HJ6Ozo0Lv6Z24S9nYh6StXcO62cH3zAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCiWq/WlTslbgqSWjyQPIpXFpwRqW3KExtQXQEE1SvuYhhSmBSn2zOLcy1FiyqGKMKVCf6qUmptk/smGBWaXvtx07i7v20IKsGoy1Vj3dSAGMxYut9g83sRWoURe3MViB1FVzUihWJKopQdYRlcxwimvj7HkRqLVfOAfyoybtWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr/yDJhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D49C4CEED;
	Mon,  5 May 2025 22:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484423;
	bh=FhclLGWzK85HJ6Ozo0Lv6Z24S9nYh6StXcO62cH3zAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vr/yDJhB/V7jJPDk7jzwH/bH1geFIUOzu/Yk9PW8TzGRPRjIqpvjIExIBl087xwjn
	 UvzRCekb/6S4vqblvRrYyqQBg/wKa5l+zLql0V6GmGupmH+sKPLMLP/ClKF95TmeJL
	 YuGW5IVfH99OVHmlLmHqfshnrFh/g+vLZ9X3avPJVHcxcLNaTlh6vwCV7NRU0hwTaB
	 UBjACxIb3TIwNQNOYstzAb4/yq5lMJlZXp3/efLr8MQOnpdzgDOSTdWiP48FxNGutb
	 GIWPDPFdcPgsSMrlfBH0P65yBln3gID55JqIe2hKzE+BQ2yR4nzVVXfB5g543lyLK3
	 yOaUFsmjIHxCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Victor Skvortsov <victor.skvortsov@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	tao.zhou1@amd.com,
	kevinyang.wang@amd.com,
	YiPeng.Chai@amd.com,
	lijo.lazar@amd.com,
	ganglxie@amd.com,
	zhigang.luo@amd.com,
	Yunxiang.Li@amd.com,
	Jack.Xiao@amd.com,
	mtodorovac69@gmail.com,
	lincao12@amd.com,
	Tony.Yi@amd.com,
	Vignesh.Chander@amd.com,
	shaoyun.liu@amd.com,
	Emily.Deng@amd.com,
	srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 474/642] drm/amdgpu: Skip err_count sysfs creation on VF unsupported RAS blocks
Date: Mon,  5 May 2025 18:11:30 -0400
Message-Id: <20250505221419.2672473-474-sashal@kernel.org>
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

From: Victor Skvortsov <victor.skvortsov@amd.com>

[ Upstream commit 04893397766a2b2f1bc7fe5c6414e4c0846ed171 ]

VFs are not able to query error counts for all RAS blocks. Rather than
returning error for queries on these blocks, skip sysfs the creation
all together.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 ++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index f0924aa3f4e48..0c338dcdde48a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1864,6 +1864,9 @@ int amdgpu_ras_sysfs_create(struct amdgpu_device *adev,
 	if (!obj || obj->attr_inuse)
 		return -EINVAL;
 
+	if (amdgpu_sriov_vf(adev) && !amdgpu_virt_ras_telemetry_block_en(adev, head->block))
+		return 0;
+
 	get_obj(obj);
 
 	snprintf(obj->fs_data.sysfs_name, sizeof(obj->fs_data.sysfs_name),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 13e5709ea1caa..e6f0152e5b087 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1247,7 +1247,8 @@ amdgpu_ras_block_to_sriov(struct amdgpu_device *adev, enum amdgpu_ras_block bloc
 	case AMDGPU_RAS_BLOCK__MPIO:
 		return RAS_TELEMETRY_GPU_BLOCK_MPIO;
 	default:
-		dev_err(adev->dev, "Unsupported SRIOV RAS telemetry block 0x%x\n", block);
+		DRM_WARN_ONCE("Unsupported SRIOV RAS telemetry block 0x%x\n",
+			      block);
 		return RAS_TELEMETRY_GPU_BLOCK_COUNT;
 	}
 }
@@ -1332,3 +1333,17 @@ int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+bool amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,
+					enum amdgpu_ras_block block)
+{
+	enum amd_sriov_ras_telemetry_gpu_block sriov_block;
+
+	sriov_block = amdgpu_ras_block_to_sriov(adev, block);
+
+	if (sriov_block >= RAS_TELEMETRY_GPU_BLOCK_COUNT ||
+	    !amdgpu_sriov_ras_telemetry_block_en(adev, sriov_block))
+		return false;
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 0ca73343a7689..0f3ccae5c1ab3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -407,4 +407,6 @@ bool amdgpu_virt_get_ras_capability(struct amdgpu_device *adev);
 int amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum amdgpu_ras_block block,
 				  struct ras_err_data *err_data);
 int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev);
+bool amdgpu_virt_ras_telemetry_block_en(struct amdgpu_device *adev,
+					enum amdgpu_ras_block block);
 #endif
-- 
2.39.5


