Return-Path: <stable+bounces-5799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BDC80D71B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADA9281F9B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414C2537EA;
	Mon, 11 Dec 2023 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NLDlZxEi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F044252F89;
	Mon, 11 Dec 2023 18:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7293CC433C9;
	Mon, 11 Dec 2023 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319692;
	bh=5LsfLEoMswwG0I7TSMnzTF02KDV/6BIB//cYPpFpNO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NLDlZxEiRvaxKLhYQ5dWbFtTYv2B+GacncMvByVJmdO6aYz8YSuiNy3AVzPQjoYb6
	 CmdvWae5salvDWMMIiYF86UhsC+8/zImYBF0MTaDSAyklVERq+6894smQhVipC4njF
	 J45YDpJIWGgOkoo7ueJPGBvcUxZ1oToI+Fu1ynQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alyssa Ross <hi@alyssa.is>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 6.6 172/244] drm/atomic-helpers: Invoke end_fb_access while owning plane state
Date: Mon, 11 Dec 2023 19:21:05 +0100
Message-ID: <20231211182053.626264623@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

commit e0f04e41e8eedd4e5a1275f2318df7e1841855f2 upstream.

Invoke drm_plane_helper_funcs.end_fb_access before
drm_atomic_helper_commit_hw_done(). The latter function hands over
ownership of the plane state to the following commit, which might
free it. Releasing resources in end_fb_access then operates on undefined
state. This bug has been observed with non-blocking commits when they
are being queued up quickly.

Here is an example stack trace from the bug report. The plane state has
been free'd already, so the pages for drm_gem_fb_vunmap() are gone.

Unable to handle kernel paging request at virtual address 0000000100000049
[...]
 drm_gem_fb_vunmap+0x18/0x74
 drm_gem_end_shadow_fb_access+0x1c/0x2c
 drm_atomic_helper_cleanup_planes+0x58/0xd8
 drm_atomic_helper_commit_tail+0x90/0xa0
 commit_tail+0x15c/0x188
 commit_work+0x14/0x20

Fix this by running end_fb_access immediately after updating all planes
in drm_atomic_helper_commit_planes(). The existing clean-up helper
drm_atomic_helper_cleanup_planes() now only handles cleanup_fb.

For aborted commits, roll back from drm_atomic_helper_prepare_planes()
in the new helper drm_atomic_helper_unprepare_planes(). This case is
different from regular cleanup, as we have to release the new state;
regular cleanup releases the old state. The new helper also invokes
cleanup_fb for all planes.

The changes mostly involve DRM's atomic helpers. Only two drivers, i915
and nouveau, implement their own commit function. Update them to invoke
drm_atomic_helper_unprepare_planes(). Drivers with custom commit_tail
function do not require changes.

v4:
	* fix documentation (kernel test robot)
v3:
	* add drm_atomic_helper_unprepare_planes() for rolling back
	* use correct state for end_fb_access
v2:
	* fix test in drm_atomic_helper_cleanup_planes()

Reported-by: Alyssa Ross <hi@alyssa.is>
Closes: https://lore.kernel.org/dri-devel/87leazm0ya.fsf@alyssa.is/
Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Fixes: 94d879eaf7fb ("drm/atomic-helper: Add {begin,end}_fb_access to plane helpers")
Tested-by: Alyssa Ross <hi@alyssa.is>
Reviewed-by: Alyssa Ross <hi@alyssa.is>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org> # v6.2+
Link: https://patchwork.freedesktop.org/patch/msgid/20231204083247.22006-1-tzimmermann@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_atomic_helper.c          |   78 ++++++++++++++++++---------
 drivers/gpu/drm/i915/display/intel_display.c |    2 
 drivers/gpu/drm/nouveau/dispnv50/disp.c      |    2 
 include/drm/drm_atomic_helper.h              |    2 
 4 files changed, 56 insertions(+), 28 deletions(-)

--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -2012,7 +2012,7 @@ int drm_atomic_helper_commit(struct drm_
 			return ret;
 
 		drm_atomic_helper_async_commit(dev, state);
-		drm_atomic_helper_cleanup_planes(dev, state);
+		drm_atomic_helper_unprepare_planes(dev, state);
 
 		return 0;
 	}
@@ -2072,7 +2072,7 @@ int drm_atomic_helper_commit(struct drm_
 	return 0;
 
 err:
-	drm_atomic_helper_cleanup_planes(dev, state);
+	drm_atomic_helper_unprepare_planes(dev, state);
 	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit);
@@ -2650,6 +2650,39 @@ fail_prepare_fb:
 }
 EXPORT_SYMBOL(drm_atomic_helper_prepare_planes);
 
+/**
+ * drm_atomic_helper_unprepare_planes - release plane resources on aborts
+ * @dev: DRM device
+ * @state: atomic state object with old state structures
+ *
+ * This function cleans up plane state, specifically framebuffers, from the
+ * atomic state. It undoes the effects of drm_atomic_helper_prepare_planes()
+ * when aborting an atomic commit. For cleaning up after a successful commit
+ * use drm_atomic_helper_cleanup_planes().
+ */
+void drm_atomic_helper_unprepare_planes(struct drm_device *dev,
+					struct drm_atomic_state *state)
+{
+	struct drm_plane *plane;
+	struct drm_plane_state *new_plane_state;
+	int i;
+
+	for_each_new_plane_in_state(state, plane, new_plane_state, i) {
+		const struct drm_plane_helper_funcs *funcs = plane->helper_private;
+
+		if (funcs->end_fb_access)
+			funcs->end_fb_access(plane, new_plane_state);
+	}
+
+	for_each_new_plane_in_state(state, plane, new_plane_state, i) {
+		const struct drm_plane_helper_funcs *funcs = plane->helper_private;
+
+		if (funcs->cleanup_fb)
+			funcs->cleanup_fb(plane, new_plane_state);
+	}
+}
+EXPORT_SYMBOL(drm_atomic_helper_unprepare_planes);
+
 static bool plane_crtc_active(const struct drm_plane_state *state)
 {
 	return state->crtc && state->crtc->state->active;
@@ -2784,6 +2817,17 @@ void drm_atomic_helper_commit_planes(str
 
 		funcs->atomic_flush(crtc, old_state);
 	}
+
+	/*
+	 * Signal end of framebuffer access here before hw_done. After hw_done,
+	 * a later commit might have already released the plane state.
+	 */
+	for_each_old_plane_in_state(old_state, plane, old_plane_state, i) {
+		const struct drm_plane_helper_funcs *funcs = plane->helper_private;
+
+		if (funcs->end_fb_access)
+			funcs->end_fb_access(plane, old_plane_state);
+	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_planes);
 
@@ -2911,40 +2955,22 @@ EXPORT_SYMBOL(drm_atomic_helper_disable_
  * configuration. Hence the old configuration must be perserved in @old_state to
  * be able to call this function.
  *
- * This function must also be called on the new state when the atomic update
- * fails at any point after calling drm_atomic_helper_prepare_planes().
+ * This function may not be called on the new state when the atomic update
+ * fails at any point after calling drm_atomic_helper_prepare_planes(). Use
+ * drm_atomic_helper_unprepare_planes() in this case.
  */
 void drm_atomic_helper_cleanup_planes(struct drm_device *dev,
 				      struct drm_atomic_state *old_state)
 {
 	struct drm_plane *plane;
-	struct drm_plane_state *old_plane_state, *new_plane_state;
+	struct drm_plane_state *old_plane_state;
 	int i;
 
-	for_each_oldnew_plane_in_state(old_state, plane, old_plane_state, new_plane_state, i) {
+	for_each_old_plane_in_state(old_state, plane, old_plane_state, i) {
 		const struct drm_plane_helper_funcs *funcs = plane->helper_private;
 
-		if (funcs->end_fb_access)
-			funcs->end_fb_access(plane, new_plane_state);
-	}
-
-	for_each_oldnew_plane_in_state(old_state, plane, old_plane_state, new_plane_state, i) {
-		const struct drm_plane_helper_funcs *funcs;
-		struct drm_plane_state *plane_state;
-
-		/*
-		 * This might be called before swapping when commit is aborted,
-		 * in which case we have to cleanup the new state.
-		 */
-		if (old_plane_state == plane->state)
-			plane_state = new_plane_state;
-		else
-			plane_state = old_plane_state;
-
-		funcs = plane->helper_private;
-
 		if (funcs->cleanup_fb)
-			funcs->cleanup_fb(plane, plane_state);
+			funcs->cleanup_fb(plane, old_plane_state);
 	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_cleanup_planes);
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -7279,7 +7279,7 @@ int intel_atomic_commit(struct drm_devic
 		for_each_new_intel_crtc_in_state(state, crtc, new_crtc_state, i)
 			intel_color_cleanup_commit(new_crtc_state);
 
-		drm_atomic_helper_cleanup_planes(dev, &state->base);
+		drm_atomic_helper_unprepare_planes(dev, &state->base);
 		intel_runtime_pm_put(&dev_priv->runtime_pm, state->wakeref);
 		return ret;
 	}
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2310,7 +2310,7 @@ nv50_disp_atomic_commit(struct drm_devic
 
 err_cleanup:
 	if (ret)
-		drm_atomic_helper_cleanup_planes(dev, state);
+		drm_atomic_helper_unprepare_planes(dev, state);
 done:
 	pm_runtime_put_autosuspend(dev->dev);
 	return ret;
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -97,6 +97,8 @@ void drm_atomic_helper_commit_modeset_en
 
 int drm_atomic_helper_prepare_planes(struct drm_device *dev,
 				     struct drm_atomic_state *state);
+void drm_atomic_helper_unprepare_planes(struct drm_device *dev,
+					struct drm_atomic_state *state);
 
 #define DRM_PLANE_COMMIT_ACTIVE_ONLY			BIT(0)
 #define DRM_PLANE_COMMIT_NO_DISABLE_AFTER_MODESET	BIT(1)



