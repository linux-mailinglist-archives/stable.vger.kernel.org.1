Return-Path: <stable+bounces-120309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DE0A4E801
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A528D461FC6
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6E3280CC6;
	Tue,  4 Mar 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NcAWkYhd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6E20B1E4
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106352; cv=none; b=uI5S+g1VdWkduVOc+m9FkSC5sIcJUHckxuw/agNtuKP8dPdjyRlXtzwVQHZzzlcjO67JEihB/sDSNNmhlLKEu4zzrFlG1CvGBdVt9Ceo64997PwMj216pMOBLYfii9BofMRRUgNqgwMZFFS7OVFi7Q76DvK96Xk5kmwzAdiZGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106352; c=relaxed/simple;
	bh=U9RF4YWOmxDbVlPMtmWCRgzbNUgyZFhHypqrF9U4YUA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gprIYiwCe7zvzHx+SZLAv0gD7L6H3xlAmoK9gS48X+xy6RaaXW77viaIwoWdyn2Q2LEc5LcJjGv+Xm8o6lhQ5ngvV/uIoqMoykGc6wust9QZhHi2e9ny7yj3I74w+c0r8155Dj3/5JR+/RPjtmu3pHYeE1VsN3YptWb/HP6A7NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NcAWkYhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927B1C4CEE7;
	Tue,  4 Mar 2025 16:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106351;
	bh=U9RF4YWOmxDbVlPMtmWCRgzbNUgyZFhHypqrF9U4YUA=;
	h=Subject:To:Cc:From:Date:From;
	b=NcAWkYhdviMrsI8XIHX/CUNckQ5NA4QK5OVgSakHrRlQh9ai0s3S6Nr9mJsayF0uu
	 iwm0ki27P3WpLWTUi6qcwIUJua0X3BOeTSXF6dTDbTqQJ29En1Qt+n42LQ8FQrQGO3
	 uXcFxYv02Rwgs/WSSAf98fyaBsnxluH7rv5vajfo=
Subject: FAILED: patch "[PATCH] amdgpu/pm/legacy: fix suspend/resume issues" failed to apply to 6.1-stable tree
To: chris@rudorff.com,alexander.deucher@amd.com,lijo.lazar@amd.com,mail@maciej.szmigiero.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:38:59 +0100
Message-ID: <2025030458-properly-playroom-8207@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 91dcc66b34beb72dde8412421bdc1b4cd40e4fb8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030458-properly-playroom-8207@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 91dcc66b34beb72dde8412421bdc1b4cd40e4fb8 Mon Sep 17 00:00:00 2001
From: "chr[]" <chris@rudorff.com>
Date: Wed, 12 Feb 2025 16:51:38 +0100
Subject: [PATCH] amdgpu/pm/legacy: fix suspend/resume issues

resume and irq handler happily races in set_power_state()

* amdgpu_legacy_dpm_compute_clocks() needs lock
* protect irq work handler
* fix dpm_enabled usage

v2: fix clang build, integrate Lijo's comments (Alex)

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2524
Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in amdgpu_dpm.c")
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name> # on Oland PRO
Signed-off-by: chr[] <chris@rudorff.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ee3dc9e204d271c9c7a8d4d38a0bce4745d33e71)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 67a8e22b1126..e237ea1185a7 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3042,6 +3042,7 @@ static int kv_dpm_hw_init(struct amdgpu_ip_block *ip_block)
 	if (!amdgpu_dpm)
 		return 0;
 
+	mutex_lock(&adev->pm.mutex);
 	kv_dpm_setup_asic(adev);
 	ret = kv_dpm_enable(adev);
 	if (ret)
@@ -3049,6 +3050,8 @@ static int kv_dpm_hw_init(struct amdgpu_ip_block *ip_block)
 	else
 		adev->pm.dpm_enabled = true;
 	amdgpu_legacy_dpm_compute_clocks(adev);
+	mutex_unlock(&adev->pm.mutex);
+
 	return ret;
 }
 
@@ -3066,32 +3069,42 @@ static int kv_dpm_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
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
 
 static int kv_dpm_resume(struct amdgpu_ip_block *ip_block)
 {
-	int ret;
+	int ret = 0;
 	struct amdgpu_device *adev = ip_block->adev;
 
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
index e861355ebd75..c7518b13e787 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -1009,9 +1009,12 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
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
@@ -1033,4 +1036,5 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
 	adev->pm.dpm.state = dpm_state;
 
 	amdgpu_legacy_dpm_compute_clocks(adev->powerplay.pp_handle);
+	mutex_unlock(&adev->pm.mutex);
 }
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index a87dcf0974bc..d6dfe2599ebe 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7786,6 +7786,7 @@ static int si_dpm_hw_init(struct amdgpu_ip_block *ip_block)
 	if (!amdgpu_dpm)
 		return 0;
 
+	mutex_lock(&adev->pm.mutex);
 	si_dpm_setup_asic(adev);
 	ret = si_dpm_enable(adev);
 	if (ret)
@@ -7793,6 +7794,7 @@ static int si_dpm_hw_init(struct amdgpu_ip_block *ip_block)
 	else
 		adev->pm.dpm_enabled = true;
 	amdgpu_legacy_dpm_compute_clocks(adev);
+	mutex_unlock(&adev->pm.mutex);
 	return ret;
 }
 
@@ -7810,32 +7812,44 @@ static int si_dpm_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
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
 
 static int si_dpm_resume(struct amdgpu_ip_block *ip_block)
 {
-	int ret;
+	int ret = 0;
 	struct amdgpu_device *adev = ip_block->adev;
 
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


