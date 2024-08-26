Return-Path: <stable+bounces-70165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FB395EFE9
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 13:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827A0281596
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 11:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B14E153BED;
	Mon, 26 Aug 2024 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bD9YKETa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1711482E3
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672340; cv=none; b=suKPWT7rnyno6h04WOrL+0BKMv/ov0T9/Ko4VQpRnMCOinIfu9Lj2nyzw9dR58ctlf95BWfL4qSG+btzS9oXMk32XoSEnXE9qg1LSH2a6vw2VhdEjNV2rfTslZsJIYkKQKA7w2hd+VeNbrhbtV3PbJwI2+cIOUxFbfz4gNot6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672340; c=relaxed/simple;
	bh=ywlG7gciBlVm25WgKJWPbngTCj4Ecfrfrs/uJcHxBmY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mQcfj+a39R+m+Ku6ZUDU4tUrCw1pWTfWBqBplWuY2MnVOvQ5zj8tORoJo9qXABGMhFeePqWXkU3tcXVfl5B/Nd3i9IZhibHym5gV+PJwDYH/hdm9JUo56RW75ZNP3QItJG67nnm5xc1DAdlzbC2lnzaSRt8rD3mluaFDIACYnUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bD9YKETa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3276C5140E;
	Mon, 26 Aug 2024 11:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724672340;
	bh=ywlG7gciBlVm25WgKJWPbngTCj4Ecfrfrs/uJcHxBmY=;
	h=Subject:To:Cc:From:Date:From;
	b=bD9YKETaAfFx/JEntrPpz0YxM8lyFnPIhHRDEcgGVemhAj/3b5rSvnI4b13SmHeYJ
	 mO2Xlthi8PXnDv/LLQID0HgFUa4uNc02rmvzHvsDAqJkTk1yue5y6YwiPbVCiT2/n3
	 Lz3V7/ek04QynkFtuuTLq3HbHwgSPrKUDVxwnEsc=
Subject: FAILED: patch "[PATCH] drm/xe/display: Make display suspend/resume work on discrete" failed to apply to 6.10-stable tree
To: maarten.lankhorst@linux.intel.com,rodrigo.vivi@intel.com,uma.shankar@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Aug 2024 13:38:56 +0200
Message-ID: <2024082656-unexposed-simply-c596@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x ddf6492e0e508b7c2b42c8d5a4ac82bd38ef0dd5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082656-unexposed-simply-c596@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

ddf6492e0e50 ("drm/xe/display: Make display suspend/resume work on discrete")
e7b180b22022 ("drm/xe: Prepare display for D3Cold")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ddf6492e0e508b7c2b42c8d5a4ac82bd38ef0dd5 Mon Sep 17 00:00:00 2001
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Date: Tue, 6 Aug 2024 12:50:44 +0200
Subject: [PATCH] drm/xe/display: Make display suspend/resume work on discrete

We should unpin before evicting all memory, and repin after GT resume.
This way, we preserve the contents of the framebuffers, and won't hang
on resume due to migration engine not being restored yet.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org # v6.8+
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240806105044.596842-3-maarten.lankhorst@linux.intel.com
Signed-off-by: Maarten Lankhorst,,, <maarten.lankhorst@linux.intel.com>
(cherry picked from commit cb8f81c1753187995b7a43e79c12959f14eb32d3)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index ca4468c82078..49de4e4f8a75 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -283,6 +283,27 @@ static bool suspend_to_idle(void)
 	return false;
 }
 
+static void xe_display_flush_cleanup_work(struct xe_device *xe)
+{
+	struct intel_crtc *crtc;
+
+	for_each_intel_crtc(&xe->drm, crtc) {
+		struct drm_crtc_commit *commit;
+
+		spin_lock(&crtc->base.commit_lock);
+		commit = list_first_entry_or_null(&crtc->base.commit_list,
+						  struct drm_crtc_commit, commit_entry);
+		if (commit)
+			drm_crtc_commit_get(commit);
+		spin_unlock(&crtc->base.commit_lock);
+
+		if (commit) {
+			wait_for_completion(&commit->cleanup_done);
+			drm_crtc_commit_put(commit);
+		}
+	}
+}
+
 void xe_display_pm_suspend(struct xe_device *xe, bool runtime)
 {
 	bool s2idle = suspend_to_idle();
@@ -300,6 +321,8 @@ void xe_display_pm_suspend(struct xe_device *xe, bool runtime)
 	if (!runtime)
 		intel_display_driver_suspend(xe);
 
+	xe_display_flush_cleanup_work(xe);
+
 	intel_dp_mst_suspend(xe);
 
 	intel_hpd_cancel_work(xe);
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index de3b5df65e48..9a3f618d22dc 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -91,13 +91,13 @@ int xe_pm_suspend(struct xe_device *xe)
 	for_each_gt(gt, xe, id)
 		xe_gt_suspend_prepare(gt);
 
+	xe_display_pm_suspend(xe, false);
+
 	/* FIXME: Super racey... */
 	err = xe_bo_evict_all(xe);
 	if (err)
 		goto err;
 
-	xe_display_pm_suspend(xe, false);
-
 	for_each_gt(gt, xe, id) {
 		err = xe_gt_suspend(gt);
 		if (err) {
@@ -151,11 +151,11 @@ int xe_pm_resume(struct xe_device *xe)
 
 	xe_irq_resume(xe);
 
-	xe_display_pm_resume(xe, false);
-
 	for_each_gt(gt, xe, id)
 		xe_gt_resume(gt);
 
+	xe_display_pm_resume(xe, false);
+
 	err = xe_bo_restore_user(xe);
 	if (err)
 		goto err;
@@ -363,10 +363,11 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 	mutex_unlock(&xe->mem_access.vram_userfault.lock);
 
 	if (xe->d3cold.allowed) {
+		xe_display_pm_suspend(xe, true);
+
 		err = xe_bo_evict_all(xe);
 		if (err)
 			goto out;
-		xe_display_pm_suspend(xe, true);
 	}
 
 	for_each_gt(gt, xe, id) {


