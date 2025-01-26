Return-Path: <stable+bounces-110569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5571AA1C9FA
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27F9188703F
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E45C1FCCF4;
	Sun, 26 Jan 2025 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2stPh/r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062821D5AAD;
	Sun, 26 Jan 2025 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903378; cv=none; b=TVfHcJttO9BcDVc2Lm9cvEK6QYbcPXS5sZghgFT0ZyR1cynj+aCp4f4TD9j6HwpiyEA5mFbJ2YlRrQ84D3qB2CQOUyfYmwxgYGX2SlyfgnyOlFnzSMUxqaQP4GrIzp53D2puGMItB7O7FIOV29gqxeDDsnAXJTwvRflLf1/I+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903378; c=relaxed/simple;
	bh=iDFms1I5hEBtyBWy0DYGk9/eU8/v/WiCVIyvJEol4oY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t1RE7ZFARcS+MrfRCDmLUSsX7yRmKP9Mx1SYOc3wwsprqt3B7Kckdyzd0qGRUdnxohQpr6FwqtiR8jRU0/jDbOKlQlvUjCXSQdxwle0H2Gn4zy1XB7F4xca6/LxM8YV9EJW95dnpxSSb0aU12zChBVa2sA5m4erEzEmNml69n5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2stPh/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BB3C4CED3;
	Sun, 26 Jan 2025 14:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903375;
	bh=iDFms1I5hEBtyBWy0DYGk9/eU8/v/WiCVIyvJEol4oY=;
	h=From:To:Cc:Subject:Date:From;
	b=R2stPh/rvTJ7pCTpe/U59tuZ2g5ESjjQkidSOLRGgWjk1lbpozkfDf5ax8WczfYC8
	 jG+MNWKunWWrejMVcSfUCT5RxuHH4+DENr0emU0VK+165c6o8pLYHvKcp+uAIRGNud
	 VfQY9rynbGtsvrJ15hBIY9inOQ4tsvLdA9r1g1zI9BjTX+IlJYLaVQIuucGBPGNxJk
	 ts/R0Ciniub6zDMwS2hxi05YtHtlkTGTNByP15GFqNIvwYyBd0UMeK58lQen820fD5
	 0zbUjP3DZ0IgQiEU/K/qXBfq8W/qi9oawH0zWFAf/KRVFxxEEZDvf2GFPR5EyeRGrF
	 nLxUYd9t59AVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dongwon Kim <dongwon.kim@intel.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Rob Clark <robdclark@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	airlied@redhat.com,
	kraxel@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 01/17] drm/virtio: New fence for every plane update
Date: Sun, 26 Jan 2025 09:55:56 -0500
Message-Id: <20250126145612.937679-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
Content-Transfer-Encoding: 8bit

From: Dongwon Kim <dongwon.kim@intel.com>

[ Upstream commit d3c55b8ab6fe5fa2e7ab02efd36d09c39ee5022f ]

Having a fence linked to a virtio_gpu_framebuffer in the plane update
sequence would cause conflict when several planes referencing the same
framebuffer (e.g. Xorg screen covering multi-displays configured for an
extended mode) and those planes are updated concurrently. So it is needed
to allocate a fence for every plane state instead of the framebuffer.

Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
[dmitry.osipenko@collabora.com: rebase, fix up, edit commit message]
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Reviewed-by: Rob Clark <robdclark@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241020230803.247419-2-dmitry.osipenko@collabora.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  7 ++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 58 +++++++++++++++++---------
 2 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 4126c384286bf..61fd37f95fbd9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -191,6 +191,13 @@ struct virtio_gpu_framebuffer {
 #define to_virtio_gpu_framebuffer(x) \
 	container_of(x, struct virtio_gpu_framebuffer, base)
 
+struct virtio_gpu_plane_state {
+	struct drm_plane_state base;
+	struct virtio_gpu_fence *fence;
+};
+#define to_virtio_gpu_plane_state(x) \
+	container_of(x, struct virtio_gpu_plane_state, base)
+
 struct virtio_gpu_queue {
 	struct virtqueue *vq;
 	spinlock_t qlock;
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a1ef657eba077..36de73e03bbfa 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -66,11 +66,28 @@ uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
 	return format;
 }
 
+static struct
+drm_plane_state *virtio_gpu_plane_duplicate_state(struct drm_plane *plane)
+{
+	struct virtio_gpu_plane_state *new;
+
+	if (WARN_ON(!plane->state))
+		return NULL;
+
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	__drm_atomic_helper_plane_duplicate_state(plane, &new->base);
+
+	return &new->base;
+}
+
 static const struct drm_plane_funcs virtio_gpu_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.reset			= drm_atomic_helper_plane_reset,
-	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+	.atomic_duplicate_state = virtio_gpu_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 };
 
@@ -138,11 +155,13 @@ static void virtio_gpu_resource_flush(struct drm_plane *plane,
 	struct drm_device *dev = plane->dev;
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_plane_state *vgplane_st;
 	struct virtio_gpu_object *bo;
 
 	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
+	vgplane_st = to_virtio_gpu_plane_state(plane->state);
 	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
-	if (vgfb->fence) {
+	if (vgplane_st->fence) {
 		struct virtio_gpu_object_array *objs;
 
 		objs = virtio_gpu_array_alloc(1);
@@ -151,13 +170,11 @@ static void virtio_gpu_resource_flush(struct drm_plane *plane,
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
 		virtio_gpu_array_lock_resv(objs);
 		virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle, x, y,
-					      width, height, objs, vgfb->fence);
+					      width, height, objs,
+					      vgplane_st->fence);
 		virtio_gpu_notify(vgdev);
-
-		dma_fence_wait_timeout(&vgfb->fence->f, true,
+		dma_fence_wait_timeout(&vgplane_st->fence->f, true,
 				       msecs_to_jiffies(50));
-		dma_fence_put(&vgfb->fence->f);
-		vgfb->fence = NULL;
 	} else {
 		virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle, x, y,
 					      width, height, NULL, NULL);
@@ -247,20 +264,23 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 	struct drm_device *dev = plane->dev;
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_plane_state *vgplane_st;
 	struct virtio_gpu_object *bo;
 
 	if (!new_state->fb)
 		return 0;
 
 	vgfb = to_virtio_gpu_framebuffer(new_state->fb);
+	vgplane_st = to_virtio_gpu_plane_state(new_state);
 	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
 	if (!bo || (plane->type == DRM_PLANE_TYPE_PRIMARY && !bo->guest_blob))
 		return 0;
 
-	if (bo->dumb && (plane->state->fb != new_state->fb)) {
-		vgfb->fence = virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context,
+	if (bo->dumb) {
+		vgplane_st->fence = virtio_gpu_fence_alloc(vgdev,
+						     vgdev->fence_drv.context,
 						     0);
-		if (!vgfb->fence)
+		if (!vgplane_st->fence)
 			return -ENOMEM;
 	}
 
@@ -270,15 +290,15 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 static void virtio_gpu_plane_cleanup_fb(struct drm_plane *plane,
 					struct drm_plane_state *state)
 {
-	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_plane_state *vgplane_st;
 
 	if (!state->fb)
 		return;
 
-	vgfb = to_virtio_gpu_framebuffer(state->fb);
-	if (vgfb->fence) {
-		dma_fence_put(&vgfb->fence->f);
-		vgfb->fence = NULL;
+	vgplane_st = to_virtio_gpu_plane_state(state);
+	if (vgplane_st->fence) {
+		dma_fence_put(&vgplane_st->fence->f);
+		vgplane_st->fence = NULL;
 	}
 }
 
@@ -291,6 +311,7 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_output *output = NULL;
 	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_plane_state *vgplane_st;
 	struct virtio_gpu_object *bo = NULL;
 	uint32_t handle;
 
@@ -303,6 +324,7 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 
 	if (plane->state->fb) {
 		vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
+		vgplane_st = to_virtio_gpu_plane_state(plane->state);
 		bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
 		handle = bo->hw_res_handle;
 	} else {
@@ -322,11 +344,9 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 			(vgdev, 0,
 			 plane->state->crtc_w,
 			 plane->state->crtc_h,
-			 0, 0, objs, vgfb->fence);
+			 0, 0, objs, vgplane_st->fence);
 		virtio_gpu_notify(vgdev);
-		dma_fence_wait(&vgfb->fence->f, true);
-		dma_fence_put(&vgfb->fence->f);
-		vgfb->fence = NULL;
+		dma_fence_wait(&vgplane_st->fence->f, true);
 	}
 
 	if (plane->state->fb != old_state->fb) {
-- 
2.39.5


