Return-Path: <stable+bounces-16121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CFA83F0B8
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B2F1C21312
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF8A1DDCF;
	Sat, 27 Jan 2024 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IIBhqLHQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF3914AB8
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394731; cv=none; b=gqYRqnAfDcdIUu0LVKEVSJYB49PqIO5nYCkQqyIMZ6CmF9ET2LjV052scsMB/aR9nkhc309jMBZsAfp8yvOhlv+aJTCiPfseIzArRZ8Ff81Yd0/1C32pb+FfUCk5p4QfO9X1RLLltjeKdrkkVtuS5e0YChhC8j/jyr7JaDdRBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394731; c=relaxed/simple;
	bh=NoU+QwfnGbRa6GgP+2dIBc6cUXXC+s4O1Icsu8PEqzk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fJkFHA1Go4g1jdFEs7+RAjfCiUQZ3F0VkNGSudCIl0KGVkVg/+nleat1DWjO7EPxUHhJyyJfeckXiFsc3SImvIm+VLXTDmrQ6FuJ791hcdeAA96zPjK25JhginpeJEOIsojlSO71AIQv8lDjp6TTYCMfomMHgKCdC6BmXK2S/ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IIBhqLHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7008C433C7;
	Sat, 27 Jan 2024 22:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706394730;
	bh=NoU+QwfnGbRa6GgP+2dIBc6cUXXC+s4O1Icsu8PEqzk=;
	h=Subject:To:Cc:From:Date:From;
	b=IIBhqLHQdY8tGw/rpTMEFR/EzTEC4x8AQxLVsL2c1ozM5xIk57z5vVOsk0GG1Ch/t
	 SiNHpnuHT6ciXuqjIQlMPBDVzbQvxAYggwq6eksoJbQK2QBEBJEBYjNRZN/m1jJn9s
	 HJDUWxzBR07PMAq/Fy4Bls9rxoP2a8A+55spqHrg=
Subject: FAILED: patch "[PATCH] drm: Disable the cursor plane on atomic contexts with" failed to apply to 5.10-stable tree
To: zackr@vmware.com,airlied@linux.ie,airlied@redhat.com,contact@emersion.fr,daniel@ffwll.ch,gurchetansingh@chromium.org,hdegoede@redhat.com,javierm@redhat.com,kraxel@redhat.com,maarten.lankhorst@linux.intel.com,mripard@kernel.org,olvaffe@gmail.com,pekka.paalanen@collabora.com,stable@vger.kernel.org,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:32:09 -0800
Message-ID: <2024012709-unengaged-existing-bf24@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4e3b70da64a53784683cfcbac2deda5d6e540407
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012709-unengaged-existing-bf24@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

4e3b70da64a5 ("drm: Disable the cursor plane on atomic contexts with virtualized drivers")
7cb8d1ab8cbd ("drm/virtio: Support sync objects")
e6303f323b1a ("drm: manager to keep track of GPUs VA mappings")
70d1ace56db6 ("drm/virtio: Conditionally allocate virtio_gpu_fence")
eba57fb5498f ("drm/virtio: Wait for each dma-fence of in-fence array individually")
e4812ab8e6b1 ("drm/virtio: Refactor and optimize job submission code path")
a1eccc574f97 ("Merge drm/drm-next into drm-misc-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e3b70da64a53784683cfcbac2deda5d6e540407 Mon Sep 17 00:00:00 2001
From: Zack Rusin <zackr@vmware.com>
Date: Mon, 23 Oct 2023 09:46:05 +0200
Subject: [PATCH] drm: Disable the cursor plane on atomic contexts with
 virtualized drivers

Cursor planes on virtualized drivers have special meaning and require
that the clients handle them in specific ways, e.g. the cursor plane
should react to the mouse movement the way a mouse cursor would be
expected to and the client is required to set hotspot properties on it
in order for the mouse events to be routed correctly.

This breaks the contract as specified by the "universal planes". Fix it
by disabling the cursor planes on virtualized drivers while adding
a foundation on top of which it's possible to special case mouse cursor
planes for clients that want it.

Disabling the cursor planes makes some kms compositors which were broken,
e.g. Weston, fallback to software cursor which works fine or at least
better than currently while having no effect on others, e.g. gnome-shell
or kwin, which put virtualized drivers on a deny-list when running in
atomic context to make them fallback to legacy kms and avoid this issue.

Signed-off-by: Zack Rusin <zackr@vmware.com>
Fixes: 681e7ec73044 ("drm: Allow userspace to ask for universal plane list (v2)")
Cc: <stable@vger.kernel.org> # v5.4+
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: virtualization@lists.linux-foundation.org
Cc: spice-devel@lists.freedesktop.org
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Simon Ser <contact@emersion.fr>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231023074613.41327-2-aesteve@redhat.com

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 24e7998d1731..c6bbb0c209f4 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -678,6 +678,19 @@ int drm_mode_getplane_res(struct drm_device *dev, void *data,
 		    !file_priv->universal_planes)
 			continue;
 
+		/*
+		 * If we're running on a virtualized driver then,
+		 * unless userspace advertizes support for the
+		 * virtualized cursor plane, disable cursor planes
+		 * because they'll be broken due to missing cursor
+		 * hotspot info.
+		 */
+		if (plane->type == DRM_PLANE_TYPE_CURSOR &&
+		    drm_core_check_feature(dev, DRIVER_CURSOR_HOTSPOT) &&
+		    file_priv->atomic &&
+		    !file_priv->supports_virtualized_cursor_plane)
+			continue;
+
 		if (drm_lease_held(file_priv, plane->base.id)) {
 			if (count < plane_resp->count_planes &&
 			    put_user(plane->base.id, plane_ptr + count))
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 46de4f171970..beee5563031a 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -285,7 +285,7 @@ static const struct drm_ioctl_desc qxl_ioctls[] = {
 };
 
 static struct drm_driver qxl_driver = {
-	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_CURSOR_HOTSPOT,
 
 	.dumb_create = qxl_mode_dumb_create,
 	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.c b/drivers/gpu/drm/vboxvideo/vbox_drv.c
index 047b95812334..cd9e66a06596 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_drv.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_drv.c
@@ -182,7 +182,7 @@ DEFINE_DRM_GEM_FOPS(vbox_fops);
 
 static const struct drm_driver driver = {
 	.driver_features =
-	    DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
+	    DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC | DRIVER_CURSOR_HOTSPOT,
 
 	.fops = &vbox_fops,
 	.name = DRIVER_NAME,
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 4334c7608408..f8e9abe647b9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -177,7 +177,7 @@ static const struct drm_driver driver = {
 	 * out via drm_device::driver_features:
 	 */
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIVER_ATOMIC |
-			   DRIVER_SYNCOBJ | DRIVER_SYNCOBJ_TIMELINE,
+			   DRIVER_SYNCOBJ | DRIVER_SYNCOBJ_TIMELINE | DRIVER_CURSOR_HOTSPOT,
 	.open = virtio_gpu_driver_open,
 	.postclose = virtio_gpu_driver_postclose,
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 8b24ecf60e3e..d3e308fdfd5b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1611,7 +1611,7 @@ static const struct file_operations vmwgfx_driver_fops = {
 
 static const struct drm_driver driver = {
 	.driver_features =
-	DRIVER_MODESET | DRIVER_RENDER | DRIVER_ATOMIC | DRIVER_GEM,
+	DRIVER_MODESET | DRIVER_RENDER | DRIVER_ATOMIC | DRIVER_GEM | DRIVER_CURSOR_HOTSPOT,
 	.ioctls = vmw_ioctls,
 	.num_ioctls = ARRAY_SIZE(vmw_ioctls),
 	.master_set = vmw_master_set,
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index e2640dc64e08..ea36aa79dca2 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -110,6 +110,15 @@ enum drm_driver_feature {
 	 * Driver supports user defined GPU VA bindings for GEM objects.
 	 */
 	DRIVER_GEM_GPUVA		= BIT(8),
+	/**
+	 * @DRIVER_CURSOR_HOTSPOT:
+	 *
+	 * Driver supports and requires cursor hotspot information in the
+	 * cursor plane (e.g. cursor plane has to actually track the mouse
+	 * cursor and the clients are required to set hotspot in order for
+	 * the cursor planes to work correctly).
+	 */
+	DRIVER_CURSOR_HOTSPOT           = BIT(9),
 
 	/* IMPORTANT: Below are all the legacy flags, add new ones above. */
 
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index e1b5b4282f75..8f35dcea82d3 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -226,6 +226,18 @@ struct drm_file {
 	 */
 	bool is_master;
 
+	/**
+	 * @supports_virtualized_cursor_plane:
+	 *
+	 * This client is capable of handling the cursor plane with the
+	 * restrictions imposed on it by the virtualized drivers.
+	 *
+	 * This implies that the cursor plane has to behave like a cursor
+	 * i.e. track cursor movement. It also requires setting of the
+	 * hotspot properties by the client on the cursor plane.
+	 */
+	bool supports_virtualized_cursor_plane;
+
 	/**
 	 * @master:
 	 *


