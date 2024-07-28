Return-Path: <stable+bounces-62152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE91F93E622
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E468A1C20E04
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C130A7711F;
	Sun, 28 Jul 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKvEaEHq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91E77114;
	Sun, 28 Jul 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181390; cv=none; b=ilEZVrQrcoezgfMD4jWGAbKyJUTeXRbt5f0m6JK2N3DYnf/8NIWuWXh8921ypPi1wx9hkZyCgpovvjAc85oUSCEz2gBiHySzmErI9Tp4Z41A9PUJNFtQ3lguImcl/L83L+8PvrLtollZOITvhFzlf8TApAi7Kg3fmd1KA0LV7yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181390; c=relaxed/simple;
	bh=g7y97FzCmiZUCCDQ0x+h5Ka4uP5omYittfRZ4EklZZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6FjiGglu2ytijZFSlTvkoQMGJgWQW6L0DD7uR7JjjeZyFtgZa0KqBJDgoA8bl+Z4ijLXXHHWpqT76Oz7fG7EHbdTBJQjq6B9dxrOpVjfptmToNjPIlO66z3aOvvY/eY+QIkOu7k5lZr5GXUsbgkoKz2HwmYRFPeDRk608FW7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKvEaEHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B80CC116B1;
	Sun, 28 Jul 2024 15:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181390;
	bh=g7y97FzCmiZUCCDQ0x+h5Ka4uP5omYittfRZ4EklZZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BKvEaEHqOGVI0WXKUZmI/wcrL6nyIrB/BI4gzUwcrnJt4xMzSpaK2+pSp41amS6W7
	 Tjr/ZDijCWE3V6zvqLv0+h4wjGBV86mOFg87Ww3g5MH4yeyGerDnHLA3opCXBPh2PG
	 on2u0JtJu9VR8Mg/DkGF5LHu8bFzfWdgaSD0DohWe7obKVe03RSO8bAuLJei9aBQmR
	 jqxUmfVLBtQCG9sNSJBSySFC65R6YKe+dCnKdH6fqlHnhn7eTUn1WOtpmg0OEoYNif
	 pciBqJwelXeuguqu2qc84fjjf4K6Ww0nUs+B9ZPml6/UrwhN/hmF68ua9OvO5x4cok
	 8JfH3uDOtWe1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Jun <Jun.Ma2@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	evan.quan@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mario.limonciello@amd.com,
	ruanjinjie@huawei.com,
	sunran001@208suo.com,
	alexious@zju.edu.cn,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 08/34] drm/amdgpu/pm: Fix the null pointer dereference for smu7
Date: Sun, 28 Jul 2024 11:40:32 -0400
Message-ID: <20240728154230.2046786-8-sashal@kernel.org>
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

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit c02c1960c93eede587576625a1221205a68a904f ]

optimize the code to avoid pass a null pointer (hwmgr->backend)
to function smu7_update_edc_leakage_table.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 50 +++++++++----------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 1fcd4451001fa..5d0c281f2378c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2957,6 +2957,7 @@ static int smu7_update_edc_leakage_table(struct pp_hwmgr *hwmgr)
 
 static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 {
+	struct amdgpu_device *adev = hwmgr->adev;
 	struct smu7_hwmgr *data;
 	int result = 0;
 
@@ -2993,40 +2994,37 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 	/* Initalize Dynamic State Adjustment Rule Settings */
 	result = phm_initializa_dynamic_state_adjustment_rule_settings(hwmgr);
 
-	if (0 == result) {
-		struct amdgpu_device *adev = hwmgr->adev;
+	if (result)
+		goto fail;
 
-		data->is_tlu_enabled = false;
+	data->is_tlu_enabled = false;
 
-		hwmgr->platform_descriptor.hardwareActivityPerformanceLevels =
+	hwmgr->platform_descriptor.hardwareActivityPerformanceLevels =
 							SMU7_MAX_HARDWARE_POWERLEVELS;
-		hwmgr->platform_descriptor.hardwarePerformanceLevels = 2;
-		hwmgr->platform_descriptor.minimumClocksReductionPercentage = 50;
+	hwmgr->platform_descriptor.hardwarePerformanceLevels = 2;
+	hwmgr->platform_descriptor.minimumClocksReductionPercentage = 50;
 
-		data->pcie_gen_cap = adev->pm.pcie_gen_mask;
-		if (data->pcie_gen_cap & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
-			data->pcie_spc_cap = 20;
-		else
-			data->pcie_spc_cap = 16;
-		data->pcie_lane_cap = adev->pm.pcie_mlw_mask;
-
-		hwmgr->platform_descriptor.vbiosInterruptId = 0x20000400; /* IRQ_SOURCE1_SW_INT */
-/* The true clock step depends on the frequency, typically 4.5 or 9 MHz. Here we use 5. */
-		hwmgr->platform_descriptor.clockStep.engineClock = 500;
-		hwmgr->platform_descriptor.clockStep.memoryClock = 500;
-		smu7_thermal_parameter_init(hwmgr);
-	} else {
-		/* Ignore return value in here, we are cleaning up a mess. */
-		smu7_hwmgr_backend_fini(hwmgr);
-	}
+	data->pcie_gen_cap = adev->pm.pcie_gen_mask;
+	if (data->pcie_gen_cap & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
+		data->pcie_spc_cap = 20;
+	else
+		data->pcie_spc_cap = 16;
+	data->pcie_lane_cap = adev->pm.pcie_mlw_mask;
+
+	hwmgr->platform_descriptor.vbiosInterruptId = 0x20000400; /* IRQ_SOURCE1_SW_INT */
+	/* The true clock step depends on the frequency, typically 4.5 or 9 MHz. Here we use 5. */
+	hwmgr->platform_descriptor.clockStep.engineClock = 500;
+	hwmgr->platform_descriptor.clockStep.memoryClock = 500;
+	smu7_thermal_parameter_init(hwmgr);
 
 	result = smu7_update_edc_leakage_table(hwmgr);
-	if (result) {
-		smu7_hwmgr_backend_fini(hwmgr);
-		return result;
-	}
+	if (result)
+		goto fail;
 
 	return 0;
+fail:
+	smu7_hwmgr_backend_fini(hwmgr);
+	return result;
 }
 
 static int smu7_force_dpm_highest(struct pp_hwmgr *hwmgr)
-- 
2.43.0


