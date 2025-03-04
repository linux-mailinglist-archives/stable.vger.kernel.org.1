Return-Path: <stable+bounces-120372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A13A4EC41
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 19:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 587297AF677
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0590323645F;
	Tue,  4 Mar 2025 18:35:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EC01F4196
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.31.26.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113356; cv=none; b=FPep+gzWgoWYa40ViSIuTq4Vj3fLR6iE3nowJAfdnS8OLXosWFXvU0AlgI5VKbNTRK/idzUvtvx7Jv08nVePzS/Wv1mr0W1eNUDv5rN1kdVcUIlHqUBDfzHH6+5orKwlCcoSkFmBLvgU0l1glqMZ2pIGpmioHlnipecrZ7Ed3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113356; c=relaxed/simple;
	bh=j4LCiia9yAigKkc7sm9DrEDm0J2g4fl17M45w/r2wI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CK8n3tBUTE5xOGhUPYVyaN5EKBMB1YKam2d2X8qiN3ZnoNFRmD0mBJZhO9fz10nTCDcvBB92Ly+PEshzRYpfgIltsB4rQIRoXcHycQsDK1ghX0PhGcpqkZRP1o0KwuvWlCo27FzDtSfRwHMBznbL5ZHP+Jq4iQbQJQADu8qD/f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com; spf=pass smtp.mailfrom=rudorff.com; arc=none smtp.client-ip=193.31.26.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from buildkiste.. (dynamic-2a02-3102-8418-1620-0000-0000-0000-02b9.310.pool.telefonica.de [IPv6:2a02:3102:8418:1620::2b9])
	by rudorff.com (Postfix) with ESMTPSA id 2CFA04097C;
	Tue,  4 Mar 2025 19:35:51 +0100 (CET)
From: "chr[]" <chris@rudorff.com>
To: stable@vger.kernel.org
Cc: "chr[]" <chris@rudorff.com>,
	"Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6.y] resume and irq handler happily races in set_power_state()
Date: Tue,  4 Mar 2025 19:35:41 +0100
Message-Id: <20250304183541.3810-1-chris@rudorff.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025030458-lying-nintendo-f777@gregkh>
References: <2025030458-lying-nintendo-f777@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* amdgpu_legacy_dpm_compute_clocks() needs lock
* protect irq work handler
* fix dpm_enabled usage

commit 91dcc66b34beb72dde8412421bdc1b4cd40e4fb8 upstream

v2: fix clang build, integrate Lijo's comments (Alex)

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2524
Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in amdgpu_dpm.c")
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name> # on Oland PRO
Signed-off-by: chr[] <chris@rudorff.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a940d204d1fddd7fd867a9b6f83030671f83978b)
(cherry picked from commit 111735ad5bb76d5f9cc05c63a45190fffdabb412)
---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    | 25 +++++++++++++-----
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  8 ++++--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 26 ++++++++++++++-----
 3 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index c8586cb7d0fe..4d193313a6d6 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3043,6 +3043,7 @@ static int kv_dpm_hw_init(void *handle)
 	if (!amdgpu_dpm)
 		return 0;
 
+	mutex_lock(&adev->pm.mutex);
 	kv_dpm_setup_asic(adev);
 	ret = kv_dpm_enable(adev);
 	if (ret)
@@ -3050,6 +3051,8 @@ static int kv_dpm_hw_init(void *handle)
 	else
 		adev->pm.dpm_enabled = true;
 	amdgpu_legacy_dpm_compute_clocks(adev);
+	mutex_unlock(&adev->pm.mutex);
+
 	return ret;
 }
 
@@ -3067,32 +3070,42 @@ static int kv_dpm_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_work_sync(&adev->pm.dpm.thermal.work);
+
 	if (adev->pm.dpm_enabled) {
+		mutex_lock(&adev->pm.mutex);
+		adev->pm.dpm_enabled = false;
 		/* disable dpm */
 		kv_dpm_disable(adev);
 		/* reset the power state */
 		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
+		mutex_unlock(&adev->pm.mutex);
 	}
 	return 0;
 }
 
 static int kv_dpm_resume(void *handle)
 {
-	int ret;
+	int ret = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->pm.dpm_enabled) {
+	if (!amdgpu_dpm)
+		return 0;
+
+	if (!adev->pm.dpm_enabled) {
+		mutex_lock(&adev->pm.mutex);
 		/* asic init will reset to the boot state */
 		kv_dpm_setup_asic(adev);
 		ret = kv_dpm_enable(adev);
-		if (ret)
+		if (ret) {
 			adev->pm.dpm_enabled = false;
-		else
+		} else {
 			adev->pm.dpm_enabled = true;
-		if (adev->pm.dpm_enabled)
 			amdgpu_legacy_dpm_compute_clocks(adev);
+		}
+		mutex_unlock(&adev->pm.mutex);
 	}
-	return 0;
+	return ret;
 }
 
 static bool kv_dpm_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index 60377747bab4..48ad413d72af 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -1018,9 +1018,12 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
 	enum amd_pm_state_type dpm_state = POWER_STATE_TYPE_INTERNAL_THERMAL;
 	int temp, size = sizeof(temp);
 
-	if (!adev->pm.dpm_enabled)
-		return;
+	mutex_lock(&adev->pm.mutex);
 
+	if (!adev->pm.dpm_enabled) {
+		mutex_unlock(&adev->pm.mutex);
+		return;
+	}
 	if (!pp_funcs->read_sensor(adev->powerplay.pp_handle,
 				   AMDGPU_PP_SENSOR_GPU_TEMP,
 				   (void *)&temp,
@@ -1042,4 +1045,5 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
 	adev->pm.dpm.state = dpm_state;
 
 	amdgpu_legacy_dpm_compute_clocks(adev->powerplay.pp_handle);
+	mutex_unlock(&adev->pm.mutex);
 }
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 99dde52a4290..e7b1fa2feb92 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7789,6 +7789,7 @@ static int si_dpm_hw_init(void *handle)
 	if (!amdgpu_dpm)
 		return 0;
 
+	mutex_lock(&adev->pm.mutex);
 	si_dpm_setup_asic(adev);
 	ret = si_dpm_enable(adev);
 	if (ret)
@@ -7796,6 +7797,7 @@ static int si_dpm_hw_init(void *handle)
 	else
 		adev->pm.dpm_enabled = true;
 	amdgpu_legacy_dpm_compute_clocks(adev);
+	mutex_unlock(&adev->pm.mutex);
 	return ret;
 }
 
@@ -7813,32 +7815,44 @@ static int si_dpm_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_work_sync(&adev->pm.dpm.thermal.work);
+
 	if (adev->pm.dpm_enabled) {
+		mutex_lock(&adev->pm.mutex);
+		adev->pm.dpm_enabled = false;
 		/* disable dpm */
 		si_dpm_disable(adev);
 		/* reset the power state */
 		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
+		mutex_unlock(&adev->pm.mutex);
 	}
+
 	return 0;
 }
 
 static int si_dpm_resume(void *handle)
 {
-	int ret;
+	int ret = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	if (adev->pm.dpm_enabled) {
+	if (!amdgpu_dpm)
+		return 0;
+
+	if (!adev->pm.dpm_enabled) {
 		/* asic init will reset to the boot state */
+		mutex_lock(&adev->pm.mutex);
 		si_dpm_setup_asic(adev);
 		ret = si_dpm_enable(adev);
-		if (ret)
+		if (ret) {
 			adev->pm.dpm_enabled = false;
-		else
+		} else {
 			adev->pm.dpm_enabled = true;
-		if (adev->pm.dpm_enabled)
 			amdgpu_legacy_dpm_compute_clocks(adev);
+		}
+		mutex_unlock(&adev->pm.mutex);
 	}
-	return 0;
+
+	return ret;
 }
 
 static bool si_dpm_is_idle(void *handle)
-- 
2.39.5


