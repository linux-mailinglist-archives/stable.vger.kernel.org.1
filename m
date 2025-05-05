Return-Path: <stable+bounces-139995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E01B1AAA38E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09DA23B0FA1
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350462F403C;
	Mon,  5 May 2025 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZhEVazT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F7A2F4034;
	Mon,  5 May 2025 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483850; cv=none; b=ujpprMmd5ypw9+HGCqZIHkT/CfMQbvhjpNRDJs/SdSRU8bZh8DiHzO75KKqW0TH7YP88MsH9zwA147jKJGMumaHicGoA4b3mP/LoHicRRSV3aZS8GmX3GxWJMUPbmxjkKVF2Bf7zmvr6kY8gNRjWSM6HH8Xe+IFzrrelO2l2VI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483850; c=relaxed/simple;
	bh=Ld3pKOgFN8CKZPNvrJcEJx12Xz3TyuwsxI61Z8Vrn7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CeSU+K932rtNI4SSkQpYVI7OLapJZcAfkLnw1QG8ciOwXPsoP+Ag9+xZ1udR1yyqjJvwoHGHwNYvitKbZUIGz/6nE22KVfXOoN69N9tAP0wQdVY/jv+mv6hWAAKPIrpgEaUIM3VBBse7A8gAWxkXf1E/lgbK7jeSOLhOItZ2va0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZhEVazT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D33C4CEE4;
	Mon,  5 May 2025 22:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483849;
	bh=Ld3pKOgFN8CKZPNvrJcEJx12Xz3TyuwsxI61Z8Vrn7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZhEVazT+/r0+6nSU2G9fbU+Y9TZPyR4nWrjBNia328LuXEXjW2teoikwYY3ZoJqo
	 qsLznRMoiohFOPd6/qxSmISs9goWvs6t0Lhlcl3PQdwuJsPpuLu2SMResFyMO1TnDb
	 pBTI9kqrRfH/iy276ySZf+b92Ci70MfjlBTxv0V9kxMeFuCTLlpiaJQZdqNsAp4tM3
	 TcvqZzMvSRgh53b/tdWL/aVZ0i5E0CpBblVQCsIDGfxCuwnFHL1hs2sTYeZtxCY/tc
	 cd++q9qpGQjw4uM6FI8NSOEBHag7/52dQqJM2CNQwBFUJUVRFECcOMefzNQFWvJFYf
	 PDVm1tlsPhGow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexandre Demers <alexandre.f.demers@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sunil.khatri@amd.com,
	boyuan.zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 248/642] drm/amdgpu: add dce_v6_0_soft_reset() to DCE6
Date: Mon,  5 May 2025 18:07:44 -0400
Message-Id: <20250505221419.2672473-248-sashal@kernel.org>
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

From: Alexandre Demers <alexandre.f.demers@gmail.com>

[ Upstream commit ab23db6d08efdda5d13d01a66c593d0e57f8917f ]

DCE6 was missing soft reset, but it was easily identifiable under radeon.
This should be it, pretty much as it is done under DCE8 and DCE10.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 53 ++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 915804a6a1d7d..ed5e06b677df1 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -370,13 +370,41 @@ static u32 dce_v6_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
 	return mmDC_GPIO_HPD_A;
 }
 
+static bool dce_v6_0_is_display_hung(struct amdgpu_device *adev)
+{
+	u32 crtc_hung = 0;
+	u32 crtc_status[6];
+	u32 i, j, tmp;
+
+	for (i = 0; i < adev->mode_info.num_crtc; i++) {
+		if (RREG32(mmCRTC_CONTROL + crtc_offsets[i]) & CRTC_CONTROL__CRTC_MASTER_EN_MASK) {
+			crtc_status[i] = RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
+			crtc_hung |= (1 << i);
+		}
+	}
+
+	for (j = 0; j < 10; j++) {
+		for (i = 0; i < adev->mode_info.num_crtc; i++) {
+			if (crtc_hung & (1 << i)) {
+				tmp = RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
+				if (tmp != crtc_status[i])
+					crtc_hung &= ~(1 << i);
+			}
+		}
+		if (crtc_hung == 0)
+			return false;
+		udelay(100);
+	}
+
+	return true;
+}
+
 static void dce_v6_0_set_vga_render_state(struct amdgpu_device *adev,
 					  bool render)
 {
 	if (!render)
 		WREG32(mmVGA_RENDER_CONTROL,
 			RREG32(mmVGA_RENDER_CONTROL) & VGA_VSTATUS_CNTL);
-
 }
 
 static int dce_v6_0_get_num_crtc(struct amdgpu_device *adev)
@@ -2872,7 +2900,28 @@ static bool dce_v6_0_is_idle(void *handle)
 
 static int dce_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	DRM_INFO("xxxx: dce_v6_0_soft_reset --- no impl!!\n");
+	u32 srbm_soft_reset = 0, tmp;
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (dce_v6_0_is_display_hung(adev))
+		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_DC_MASK;
+
+	if (srbm_soft_reset) {
+		tmp = RREG32(mmSRBM_SOFT_RESET);
+		tmp |= srbm_soft_reset;
+		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		WREG32(mmSRBM_SOFT_RESET, tmp);
+		tmp = RREG32(mmSRBM_SOFT_RESET);
+
+		udelay(50);
+
+		tmp &= ~srbm_soft_reset;
+		WREG32(mmSRBM_SOFT_RESET, tmp);
+		tmp = RREG32(mmSRBM_SOFT_RESET);
+
+		/* Wait a little for things to settle down */
+		udelay(50);
+	}
 	return 0;
 }
 
-- 
2.39.5


