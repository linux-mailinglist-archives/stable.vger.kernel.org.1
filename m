Return-Path: <stable+bounces-164504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31855B0FA7E
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 20:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5827D1891C51
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8916D221DB7;
	Wed, 23 Jul 2025 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljdflfa4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4832A1E9B2A
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296568; cv=none; b=KQKO+rX4yAOWVTZRMQQFxvZtXo4WIh59W+y/j1TN1luLbC5T7POpOJ1ImTEUBqvJpOZ8N43GOqqFulER4pdx/fPSteXjwhaCNiyUU3gUAfdCIxcLGUnZtY1Esok7grihOi6Xd6jSedcQMe4jW8x4dqvb7gYPVRpp5ZrLuKBlrV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296568; c=relaxed/simple;
	bh=/Cqm3OWuV1frDuCE7UD4SCVpM4YqobP1uPuTQeYHDJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HTCf/kImnrKVzkTNf1qZs2RoSRBVU8pGuCjD6KJf8DvBqLXHptvqxJjgQdPdpDmb0JU47XShpYH0dwuM8QSF+Ak0x0fk9HjP+uh1cWtZg8wxzlfstZnAxIF5sT/awB2XHhw96rPcols6PDu+X0JY1pvAiZ/j5N+AvKJIWBzsSdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljdflfa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2249C4CEF1;
	Wed, 23 Jul 2025 18:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753296567;
	bh=/Cqm3OWuV1frDuCE7UD4SCVpM4YqobP1uPuTQeYHDJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ljdflfa4XF7rLF1bHChwauixvrZXqAl1J+2mxlU5Fk8VXKpskfm6pC8NeQ+4dgc/Z
	 YdVwau9qzaaV7QfP8m+k+oXHd6SrSsL78kuMvU73xx8gylHS9LnYV5vwYMZu1K+3K/
	 tvdYoNIVMXSpWP1VNU479DvnxzQ21ArIY3oYiyzSkibODppBqZlNfv1kw7UL4gUHhc
	 /PMGbKgGTLIg31m399txgm/h7G5I+XHs/9OBqcMFjS1rYxznwKKxLBC9LPa2nkA6Nl
	 LKxW5MFEi1WLj3QLJjE3VTfJIsp9gg0eqFvaFGPz8yGei4JQGilUwMKq1GZJ0GSo3U
	 96B+g1xFxKGQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Jesse Zhang <jesse.zhang@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 2/3] drm/amdgpu: Implement SDMA soft reset directly for v5.x
Date: Wed, 23 Jul 2025 14:42:41 -0400
Message-Id: <20250723184242.1098689-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250723184242.1098689-1-sashal@kernel.org>
References: <2025063022-wham-parachute-8574@gregkh>
 <20250723184242.1098689-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

[ Upstream commit 5c3e7c49538e2ddad10296a318c225bbb3d37d20 ]

This patch introduces a new function `amdgpu_sdma_soft_reset` to handle SDMA soft resets directly,
rather than relying on the DPM interface.

1. **New `amdgpu_sdma_soft_reset` Function**:
   - Implements a soft reset for SDMA engines by directly writing to the hardware registers.
   - Handles SDMA versions 4.x and 5.x separately:
     - For SDMA 4.x, the existing `amdgpu_dpm_reset_sdma` function is used for backward compatibility.
     - For SDMA 5.x, the driver directly manipulates the `GRBM_SOFT_RESET` register to reset the specified SDMA instance.

2. **Integration into `amdgpu_sdma_reset_engine`**:
   - The `amdgpu_sdma_soft_reset` function is called during the SDMA reset process, replacing the previous call to `amdgpu_dpm_reset_sdma`.

v2: r should default to an error (Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 09b585592fa4 ("drm/amdgpu: Fix SDMA engine reset with logical instance ID")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 38 +++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 529c9696c2f32..b80e80d7ff557 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -26,6 +26,8 @@
 #include "amdgpu_sdma.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
+#include "gc/gc_10_1_0_offset.h"
+#include "gc/gc_10_3_0_sh_mask.h"
 
 #define AMDGPU_CSA_SDMA_SIZE 64
 /* SDMA CSA reside in the 3rd page of CSA */
@@ -561,6 +563,40 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
 	list_add_tail(&funcs->list, &adev->sdma.reset_callback_list);
 }
 
+static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
+{
+	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
+	int r = -EOPNOTSUPP;
+
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(4, 4, 2):
+	case IP_VERSION(4, 4, 4):
+	case IP_VERSION(4, 4, 5):
+		/* For SDMA 4.x, use the existing DPM interface for backward compatibility */
+		r = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+		break;
+	case IP_VERSION(5, 0, 0):
+	case IP_VERSION(5, 0, 1):
+	case IP_VERSION(5, 0, 2):
+	case IP_VERSION(5, 0, 5):
+	case IP_VERSION(5, 2, 0):
+	case IP_VERSION(5, 2, 2):
+	case IP_VERSION(5, 2, 4):
+	case IP_VERSION(5, 2, 5):
+	case IP_VERSION(5, 2, 6):
+	case IP_VERSION(5, 2, 3):
+	case IP_VERSION(5, 2, 1):
+	case IP_VERSION(5, 2, 7):
+		if (sdma_instance->funcs->soft_reset_kernel_queue)
+			r = sdma_instance->funcs->soft_reset_kernel_queue(adev, instance_id);
+		break;
+	default:
+		break;
+	}
+
+	return r;
+}
+
 /**
  * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
  * @adev: Pointer to the AMDGPU device
@@ -611,7 +647,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	}
 
 	/* Perform the SDMA reset for the specified instance */
-	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+	ret = amdgpu_sdma_soft_reset(adev, instance_id);
 	if (ret) {
 		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
 		goto exit;
-- 
2.39.5


