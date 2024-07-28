Return-Path: <stable+bounces-62200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A597093E6DF
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 17:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31671C21082
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 15:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0C682D70;
	Sun, 28 Jul 2024 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+KvkAAu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA55FB8A;
	Sun, 28 Jul 2024 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181694; cv=none; b=CF23TBX6t9Jj5iPwnSt9bm9OfNC2WOg+3JNzsjwiZGUa6jZWWi4a3dqOnFAwIsvfSmd7gXzgRshXyhalJcJ2d1KD8IPlPCZ92pn7tnj+/jCoC3RGuozHvvTDCWAbupVukJbUWg2ahE55xu3oxLj83jtyc1S6aJ1UcqVfD93IeDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181694; c=relaxed/simple;
	bh=JkaxF1m42hKaCYNt+wvv/CFDHHF5IK/4NiM8C7bcxR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKO1VGo4Ft3DfLd69d2I18u3zZ7W4Xn+NEJbDayRepN3GOEAovupfMoWAE5MkNgi1mziPlhmwyx0BAtIn4o5wk80W8Nxc2lUDbKaXWxgwgrLjz3TaWMSJLa5/8pyD6QnHqCaDTC7w7EZTT7UPXgXoG0uCx1Zbm+4AW6YXfSo4Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+KvkAAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62578C4AF0E;
	Sun, 28 Jul 2024 15:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722181693;
	bh=JkaxF1m42hKaCYNt+wvv/CFDHHF5IK/4NiM8C7bcxR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H+KvkAAu6bH+/9uNiZO1+eN4T/E8Lkjf9wdKB5xmOMbbsv6bMaQ014ScHl7ejXuma
	 N8szYJIBNHGG0Wm8S+p2QnUVbaDKjem1Eqn0lJ2X7OMBxz+ce8H5JspSA/T56LhFkY
	 JE7EI0xa+mjRvSWbB1zLWqcFokELOWJkEEgLA2vYBKrJB4fbIiafVuOlQIn3UxBgPJ
	 h05n1Fnka3qklPOCV340T+aqWHjCgDpogUXThzkoR8+GdEz9s/89jhhHmGNnQUxQ6j
	 LrqAzWZ/W2zRliMIPHep78CGs7rOPHyQPvQFcfeS6IIPHHJpmDDuiWtCWyJG655/wA
	 ww5jMFYOCTLKg==
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
	lijo.lazar@amd.com,
	sunran001@208suo.com,
	alexious@zju.edu.cn,
	ruanjinjie@huawei.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 02/17] drm/amdgpu/pm: Fix the null pointer dereference for smu7
Date: Sun, 28 Jul 2024 11:47:12 -0400
Message-ID: <20240728154805.2049226-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728154805.2049226-1-sashal@kernel.org>
References: <20240728154805.2049226-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index 5e9410117712c..9f2f3f6a79adb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2970,6 +2970,7 @@ static int smu7_update_edc_leakage_table(struct pp_hwmgr *hwmgr)
 
 static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 {
+	struct amdgpu_device *adev = hwmgr->adev;
 	struct smu7_hwmgr *data;
 	int result = 0;
 
@@ -3006,40 +3007,37 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
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


