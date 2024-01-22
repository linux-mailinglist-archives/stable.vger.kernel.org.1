Return-Path: <stable+bounces-12785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB89837392
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EB61F2C604
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92194405EC;
	Mon, 22 Jan 2024 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MxbVDvFM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE941233
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954452; cv=none; b=cG7+YvnGttqAhR1lbfc5qq4ih5H4DDVEedINOTW5GEzuRk9rJ/r4aHSnPNCCob1siyX9UvoYtsYiPJbStQtsLUnWljKBo624ro+RrG19IVAoEIIA25jQZAtBg4ApsV9xSnW2w/985FY1rdXHvYNwSE9nAaN21nKzgqGEXOkryMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954452; c=relaxed/simple;
	bh=WAswLKrBaUe9egn1eBq8rnn+Prg1GChfzQdB69l6Ys4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CfDPwttiO/34oLF3u29JV2oaIvRjSfQTzOtBWNOTPJuWMVdWoGwiLj39viJ2drBrYGFVWKfG5J3TOVwOfAkttG7KQJdXaQvX0Hyran3VsK+9H3TC3KvwN1FZ5258iBhFiioMdvyVXpSnV/TANzycqu+JJVjdQDwERjkIUJ4drlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MxbVDvFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B13AC433C7;
	Mon, 22 Jan 2024 20:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705954451;
	bh=WAswLKrBaUe9egn1eBq8rnn+Prg1GChfzQdB69l6Ys4=;
	h=Subject:To:Cc:From:Date:From;
	b=MxbVDvFMiZlWR1/vdONPskf+9cvIhPY4FYE2Xmuvtvegu21aT9ooqjZunr9t60r2n
	 udi2vgcS6iZl3T3B5vCRzp+SHPAH3vZt7aBMPJKIO0AfzpZUEeUFCVlrm2bTFEhAO/
	 lghN1frmfd8mphTcisy2N0OqSr0Kxqi8MFyLgIOc=
Subject: FAILED: patch "[PATCH] drm/amdgpu: revert "Adjust removal control flow for smu" failed to apply to 6.6-stable tree
To: christian.koenig@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:14:01 -0800
Message-ID: <2024012200-chapter-graph-3e80@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fb1c93c2e9604a884467a773790016199f78ca08
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012200-chapter-graph-3e80@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

fb1c93c2e960 ("drm/amdgpu: revert "Adjust removal control flow for smu v13_0_2"")
53dd920c1f47 ("drm/amdgpu : Add hive ras recovery check")
4e8303cf2c4d ("drm/amdgpu: Use function for IP version check")
6b7d211740da ("drm/amdgpu: Fix refclk reporting for SMU v13.0.6")
1b8e56b99459 ("drm/amdgpu: Restrict bootloader wait to SMUv13.0.6")
983ac45a06ae ("drm/amdgpu: update SET_HW_RESOURCES definition for UMSCH")
822f7808291f ("drm/amdgpu/discovery: enable UMSCH 4.0 in IP discovery")
3488c79beafa ("drm/amdgpu: add initial support for UMSCH")
2da1b04a2096 ("drm/amdgpu: add UMSCH 4.0 api definition")
3ee8fb7005ef ("drm/amdgpu: enable VPE for VPE 6.1.0")
9d4346bdbc64 ("drm/amdgpu: add VPE 6.1.0 support")
e370f8f38976 ("drm/amdgpu: Add bootloader wait for PSP v13")
aba2be41470a ("drm/amdgpu: add mmhub 3.3.0 support")
15e7cbd91de6 ("drm/amdgpu/gfx11: initialize gfx11.5.0")
f56c1941ebb7 ("drm/amdgpu: use 6.1.0 register offset for HDP CLK_CNTL")
15c5c5f57514 ("drm/amdgpu: Add bootloader status check")
3cce0bfcd0f9 ("drm/amd/display: Enable Replay for static screen use cases")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fb1c93c2e9604a884467a773790016199f78ca08 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Wed, 10 Jan 2024 15:19:29 +0100
Subject: [PATCH] drm/amdgpu: revert "Adjust removal control flow for smu
 v13_0_2"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Calling amdgpu_device_ip_resume_phase1() during shutdown leaves the
HW in an active state and is an unbalanced use of the IP callbacks.

Using the IP callbacks like this can lead to memory leaks, double
free and imbalanced reference counters.

Leaving the HW in an active state can lead to DMA accesses to memory now
freed by the driver.

Both is a complete no-go for driver unload so completely revert the
workaround for now.

This reverts commit f5c7e7797060255dbc8160734ccc5ad6183c5e04.

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ecbc58269951..b158d27d0a71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5246,7 +5246,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 	struct amdgpu_device *tmp_adev = NULL;
 	bool need_full_reset, skip_hw_reset, vram_lost = false;
 	int r = 0;
-	bool gpu_reset_for_dev_remove = 0;
 
 	/* Try reset handler method first */
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
@@ -5266,10 +5265,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 	skip_hw_reset = test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->flags);
 
-	gpu_reset_for_dev_remove =
-		test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context->flags) &&
-			test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
-
 	/*
 	 * ASIC reset has to be done on all XGMI hive nodes ASAP
 	 * to allow proper links negotiation in FW (within 1 sec)
@@ -5312,18 +5307,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 		amdgpu_ras_intr_cleared();
 	}
 
-	/* Since the mode1 reset affects base ip blocks, the
-	 * phase1 ip blocks need to be resumed. Otherwise there
-	 * will be a BIOS signature error and the psp bootloader
-	 * can't load kdb on the next amdgpu install.
-	 */
-	if (gpu_reset_for_dev_remove) {
-		list_for_each_entry(tmp_adev, device_list_handle, reset_list)
-			amdgpu_device_ip_resume_phase1(tmp_adev);
-
-		goto end;
-	}
-
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
 		if (need_full_reset) {
 			/* post card */
@@ -5560,11 +5543,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	int i, r = 0;
 	bool need_emergency_restart = false;
 	bool audio_suspended = false;
-	bool gpu_reset_for_dev_remove = false;
-
-	gpu_reset_for_dev_remove =
-			test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context->flags) &&
-				test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 
 	/*
 	 * Special case: RAS triggered and full reset isn't supported
@@ -5602,7 +5580,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1)) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			list_add_tail(&tmp_adev->reset_list, &device_list);
-			if (gpu_reset_for_dev_remove && adev->shutdown)
+			if (adev->shutdown)
 				tmp_adev->shutdown = true;
 		}
 		if (!list_is_first(&adev->reset_list, &device_list))
@@ -5687,10 +5665,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 retry:	/* Rest of adevs pre asic reset from XGMI hive. */
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-		if (gpu_reset_for_dev_remove) {
-			/* Workaroud for ASICs need to disable SMC first */
-			amdgpu_device_smu_fini_early(tmp_adev);
-		}
 		r = amdgpu_device_pre_asic_reset(tmp_adev, reset_context);
 		/*TODO Should we stop ?*/
 		if (r) {
@@ -5722,9 +5696,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		r = amdgpu_do_asic_reset(device_list_handle, reset_context);
 		if (r && r == -EAGAIN)
 			goto retry;
-
-		if (!r && gpu_reset_for_dev_remove)
-			goto recover_end;
 	}
 
 skip_hw_reset:
@@ -5780,7 +5751,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		amdgpu_ras_set_error_query_ready(tmp_adev, true);
 	}
 
-recover_end:
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 					    reset_list);
 	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5c9caf5fa075..cc69005f5b46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2337,38 +2337,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 		pm_runtime_forbid(dev->dev);
 	}
 
-	if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 2) &&
-	    !amdgpu_sriov_vf(adev)) {
-		bool need_to_reset_gpu = false;
-
-		if (adev->gmc.xgmi.num_physical_nodes > 1) {
-			struct amdgpu_hive_info *hive;
-
-			hive = amdgpu_get_xgmi_hive(adev);
-			if (hive->device_remove_count == 0)
-				need_to_reset_gpu = true;
-			hive->device_remove_count++;
-			amdgpu_put_xgmi_hive(hive);
-		} else {
-			need_to_reset_gpu = true;
-		}
-
-		/* Workaround for ASICs need to reset SMU.
-		 * Called only when the first device is removed.
-		 */
-		if (need_to_reset_gpu) {
-			struct amdgpu_reset_context reset_context;
-
-			adev->shutdown = true;
-			memset(&reset_context, 0, sizeof(reset_context));
-			reset_context.method = AMD_RESET_METHOD_NONE;
-			reset_context.reset_req_dev = adev;
-			set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-			set_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context.flags);
-			amdgpu_device_gpu_recover(adev, NULL, &reset_context);
-		}
-	}
-
 	amdgpu_driver_unload_kms(dev);
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index b0335a1c5e90..19899f6b9b2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -32,7 +32,6 @@ enum AMDGPU_RESET_FLAGS {
 
 	AMDGPU_NEED_FULL_RESET = 0,
 	AMDGPU_SKIP_HW_RESET = 1,
-	AMDGPU_RESET_FOR_DEVICE_REMOVE = 2,
 };
 
 struct amdgpu_reset_context {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 6cab882e8061..1592c63b3099 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -43,7 +43,6 @@ struct amdgpu_hive_info {
 	} pstate;
 
 	struct amdgpu_reset_domain *reset_domain;
-	uint32_t device_remove_count;
 	atomic_t ras_recovery;
 };
 


