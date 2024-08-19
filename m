Return-Path: <stable+bounces-69578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7835956976
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 13:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB48D1C218E6
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A45166F01;
	Mon, 19 Aug 2024 11:38:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E915B140
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067506; cv=none; b=Un+D9mrirD7w6vbJZXGuYDIqNFDwP6IziccpVmOhthDTn8e4JJsqIvmUBEuSshpgWe1h3u0iYkVLBObUUHzCzsARd2pMbG+GPjKpXYfJmy2wQa/nRtA41/7aqN2RMcA1AK8F42XlzuP1SSLLYrOE1Vl0Y7ldeVsj3BQurtUozmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067506; c=relaxed/simple;
	bh=q0tDTuQqC+RLJZKgkt/FGpQU4V25k7lyPC5Owm4XBxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4Fqidhoqcgxgwp91HeL+BWm1R+0shsIga8CdrVTYWNxZsy4lGXKbbE0MkYhravqNHzUW6iL6kE42Is0xQx4WpElH3n5yRod/jDCG0hLO7sOzDckpRz7e+1Ldq3CMCOVjeniqi6D3MWUSMu7gcQgbf1RpG1SmAajkgRknc81w1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=mblankhorst.nl; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mblankhorst.nl
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/5] drm/xe/display: Make display suspend/resume work on discrete
Date: Mon, 19 Aug 2024 13:32:52 +0200
Message-ID: <20240819113254.82286-4-maarten.lankhorst@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819113254.82286-1-maarten.lankhorst@linux.intel.com>
References: <20240819113254.82286-1-maarten.lankhorst@linux.intel.com>
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
index 7a1d39e1bbd7d..76a834b72d384 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -286,6 +286,27 @@ static bool suspend_to_idle(void)
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
@@ -306,6 +327,8 @@ void xe_display_pm_suspend(struct xe_device *xe, bool runtime)
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


