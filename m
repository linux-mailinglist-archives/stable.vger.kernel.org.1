Return-Path: <stable+bounces-65475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC01948D31
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 12:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7768C287AA8
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 10:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE481BF339;
	Tue,  6 Aug 2024 10:50:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F11BF321
	for <stable@vger.kernel.org>; Tue,  6 Aug 2024 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941454; cv=none; b=g0xk/UZuBPaSQwN7MGgLBaD6CN2gjFCncUU20USCCidpO0ctyAaG8LRtQ1PZ3jYmibHO6yhWwf4HoHZJz4qOqMpvl6iJX3LCC1wLB2Tl0HQbRIkhkLT/+MB4nvk4BaKUHwQzNcS3f/MKpR5MjcbDAtECJ1cmz5wDxRD3moQ1qHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941454; c=relaxed/simple;
	bh=cC4B+hvw6askto5FkqoOzswBBUFt9KKsfAOX1kNG664=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TazcqoPAdj11XaxKbxEKmhswiLyRGpbSXAika1W0gvMKhAHqzqNQy8xIkDblh+rTFg5ggWwaJLru2P6g/98Ws9xnzn5C4B04mWuVN90NjerZ8dcw8924w20CkNDdYnbwWRQ51ky98glTvjO0IZWqewH/3gN7Ws1DoyC+MV8VUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] drm/xe/display: Make display suspend/resume work on discrete
Date: Tue,  6 Aug 2024 12:50:44 +0200
Message-ID: <20240806105044.596842-3-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806105044.596842-1-maarten.lankhorst@linux.intel.com>
References: <20240806105044.596842-1-maarten.lankhorst@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should unpin before evicting all memory, and repin after GT resume.
This way, we preserve the contents of the framebuffers, and won't hang
on resume due to migration engine not being restored yet.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/xe/display/xe_display.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_pm.c              | 11 ++++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index d544d18ad1ecc..4b9ce1f34f4c7 100644
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
@@ -303,6 +324,8 @@ void xe_display_pm_suspend(struct xe_device *xe, bool runtime)
 	if (!runtime)
 		intel_display_driver_suspend(xe);
 
+	xe_display_flush_cleanup_work(xe);
+
 	intel_dp_mst_suspend(xe);
 
 	intel_hpd_cancel_work(xe);
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 9f3c14fd9f337..fcfb49af8c891 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -93,13 +93,13 @@ int xe_pm_suspend(struct xe_device *xe)
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
@@ -154,11 +154,11 @@ int xe_pm_resume(struct xe_device *xe)
 
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
@@ -367,10 +367,11 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
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
-- 
2.45.2


