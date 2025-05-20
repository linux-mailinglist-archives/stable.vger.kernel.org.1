Return-Path: <stable+bounces-145162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4E7ABDA48
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CA31BA3452
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80988242D94;
	Tue, 20 May 2025 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jpogKpLV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADA122C325;
	Tue, 20 May 2025 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749349; cv=none; b=LBVUV4D3TX2gKpRAZ1EF46YgxXEYzwUoKfHbFQcmP7ruS1Git9FYTRwL5kUunI9gCUeCLGhgkiokN49g855P+qSZx0w/7Mqho8tU45lJCEMN2FLqcD5hQ8N2DojwlKIIF92uRX4hs9sj5XZUSdAPqYt/a71yGuqAsgm3wRxMZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749349; c=relaxed/simple;
	bh=GpvWLnivWj1JYB5xX8vmvCL8RCuaXaD4dbmoiMCSyJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJEpJJvb/Zw4N+B076aHiBWK7Ow5cVu74DI0HrUgdXjFxicIt4IeS087ZZSFDIZnyWUCum38oyv7tR8kkhjBTZn+YtZOfS5jx2PzFbRub1EQKw2mvLHiwgsGxkw3Yc8TGbsYh37e1wEnRRJ13D6rTR6EA3bsrf3jJG05MmBcE7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jpogKpLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A632CC4CEE9;
	Tue, 20 May 2025 13:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749349;
	bh=GpvWLnivWj1JYB5xX8vmvCL8RCuaXaD4dbmoiMCSyJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jpogKpLV48e23xecc94sKAjy0o2ahrfp/nM/XQqm+C5viF97hn3QLhZyYF7JX4bqo
	 bi+t8crk0RFcSUMt+R6NTD2NGrHMr3LXd7BjUDWuvI44iNsywKU2n+qIsnd7CCWcjt
	 23wNdptcsah1FMiQzJ5AY9OTNkwy6gdzZ81fgrBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhigang Luo <Zhigang.Luo@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 16/97] drm/amdgpu: trigger flr_work if reading pf2vf data failed
Date: Tue, 20 May 2025 15:49:41 +0200
Message-ID: <20250520125801.299160059@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125800.653047540@linuxfoundation.org>
References: <20250520125800.653047540@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhigang Luo <Zhigang.Luo@amd.com>

[ Upstream commit ab66c832847fcdffc97d4591ba5547e3990d9d33 ]

if reading pf2vf data failed 30 times continuously, it means something is
wrong. Need to trigger flr_work to recover the issue.

also use dev_err to print the error message to get which device has
issue and add warning message if waiting IDH_FLR_NOTIFICATION_CMPL
timeout.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
Acked-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: d0ce1aaa8531 ("Revert "drm/amd: Stop evicting resources on APUs in suspend"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 29 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  3 +++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  2 ++
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  2 ++
 5 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 52f4ef4e8b4b0..aac0e49f77c7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -139,6 +139,8 @@ const char *amdgpu_asic_name[] = {
 	"LAST",
 };
 
+static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
+
 /**
  * DOC: pcie_replay_count
  *
@@ -4638,6 +4640,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 retry:
 	amdgpu_amdkfd_pre_reset(adev);
 
+	amdgpu_device_stop_pending_resets(adev);
+
 	if (from_hypervisor)
 		r = amdgpu_virt_request_full_gpu(adev, true);
 	else
@@ -5509,11 +5513,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			tmp_adev->asic_reset_res = r;
 		}
 
-		/*
-		 * Drop all pending non scheduler resets. Scheduler resets
-		 * were already dropped during drm_sched_stop
-		 */
-		amdgpu_device_stop_pending_resets(tmp_adev);
+		if (!amdgpu_sriov_vf(tmp_adev))
+			/*
+			* Drop all pending non scheduler resets. Scheduler resets
+			* were already dropped during drm_sched_stop
+			*/
+			amdgpu_device_stop_pending_resets(tmp_adev);
 	}
 
 	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index d7b76a3d2d558..6174bef0ecb88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -32,6 +32,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 #include "vi.h"
 #include "soc15.h"
 #include "nv.h"
@@ -456,7 +457,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	if (pf2vf_info->size > 1024) {
-		DRM_ERROR("invalid pf2vf message size\n");
+		dev_err(adev->dev, "invalid pf2vf message size: 0x%x\n", pf2vf_info->size);
 		return -EINVAL;
 	}
 
@@ -467,7 +468,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
 			adev->virt.fw_reserve.checksum_key, checksum);
 		if (checksum != checkval) {
-			DRM_ERROR("invalid pf2vf message\n");
+			dev_err(adev->dev,
+				"invalid pf2vf message: header checksum=0x%x calculated checksum=0x%x\n",
+				checksum, checkval);
 			return -EINVAL;
 		}
 
@@ -481,7 +484,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			adev->virt.fw_reserve.p_pf2vf, pf2vf_info->size,
 			0, checksum);
 		if (checksum != checkval) {
-			DRM_ERROR("invalid pf2vf message\n");
+			dev_err(adev->dev,
+				"invalid pf2vf message: header checksum=0x%x calculated checksum=0x%x\n",
+				checksum, checkval);
 			return -EINVAL;
 		}
 
@@ -517,7 +522,7 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
 			((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
 		break;
 	default:
-		DRM_ERROR("invalid pf2vf version\n");
+		dev_err(adev->dev, "invalid pf2vf version: 0x%x\n", pf2vf_info->version);
 		return -EINVAL;
 	}
 
@@ -617,8 +622,21 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
 	int ret;
 
 	ret = amdgpu_virt_read_pf2vf_data(adev);
-	if (ret)
+	if (ret) {
+		adev->virt.vf2pf_update_retry_cnt++;
+		if ((adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
+		    amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev)) {
+			if (amdgpu_reset_domain_schedule(adev->reset_domain,
+							  &adev->virt.flr_work))
+				return;
+			else
+				dev_err(adev->dev, "Failed to queue work! at %s", __func__);
+		}
+
 		goto out;
+	}
+
+	adev->virt.vf2pf_update_retry_cnt = 0;
 	amdgpu_virt_write_vf2pf_data(adev);
 
 out:
@@ -639,6 +657,7 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 	adev->virt.fw_reserve.p_pf2vf = NULL;
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
+	adev->virt.vf2pf_update_retry_cnt = 0;
 
 	if (adev->mman.fw_vram_usage_va != NULL) {
 		/* go through this logic in ip_init and reset to init workqueue*/
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index dc6aaa4d67be7..fc2859726f0a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -51,6 +51,8 @@
 /* tonga/fiji use this offset */
 #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503
 
+#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 30
+
 enum amdgpu_sriov_vf_mode {
 	SRIOV_VF_MODE_BARE_METAL = 0,
 	SRIOV_VF_MODE_ONE_VF,
@@ -250,6 +252,7 @@ struct amdgpu_virt {
 	/* vf2pf message */
 	struct delayed_work vf2pf_work;
 	uint32_t vf2pf_update_interval_ms;
+	int vf2pf_update_retry_cnt;
 
 	/* multimedia bandwidth config */
 	bool     is_mm_bw_enabled;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 12906ba74462f..d39c6baae007a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -276,6 +276,8 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 		timeout -= 10;
 	} while (timeout > 1);
 
+	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+
 flr_done:
 	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
 	up_write(&adev->reset_domain->sem);
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index e07757eea7adf..a311a2425ec01 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -300,6 +300,8 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 		timeout -= 10;
 	} while (timeout > 1);
 
+	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
+
 flr_done:
 	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
 	up_write(&adev->reset_domain->sem);
-- 
2.39.5




