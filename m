Return-Path: <stable+bounces-87880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 621FB9ACCD6
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C111F256A7
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A40200B84;
	Wed, 23 Oct 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il3Z4s9v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B892010FA;
	Wed, 23 Oct 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693901; cv=none; b=u7BJjja6JY4ntCfNi+7duSKlyY+J2nO1fVLiRMxQXGyNQCi2G/BlN6Wq21ax3y6Y3/KKn+slMbP/Y8R+jvIVyuUr1Ip18n5sQ2j0KhZgB/4+KbLa5zqlrbx6gcjddUHF2kGni9nJjfkFSCylJtEQDyNxirBe6dasVF9gjeBBnG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693901; c=relaxed/simple;
	bh=sBr3t9fmz/wcVVK1ENSP6wBPaqExySg/lxrmMffacOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MU1LMbP4wfGpH+G+y3Ba/Q+ChKCYVoWXkyRF8vmkcIOc71c/JacDhuhyVQX4bHgZqNTU9ZYdspzUR/MCyd86pFpzV7JGK9HPHkG7C2A7lTjHUr4CsROz8lS3VZp27ByhGjvVEzxP5cCSlQY62fCgvJXi0hCYQj+dL6k+3M3Wp0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il3Z4s9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4826DC4CEE4;
	Wed, 23 Oct 2024 14:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693901;
	bh=sBr3t9fmz/wcVVK1ENSP6wBPaqExySg/lxrmMffacOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Il3Z4s9vQ7EgVOQPfAX53yigYVglTX12oiPn+l/uPNQkeHo/kkDvo2NosMJdGpMIc
	 Q5i3EqrAKW8BbSBFb0drBXkr/S2PjquVgqIlSRkuAfZ8hHZKdaMNnsPiDbd/TlWltZ
	 KFv3WXhlMnZO5Qe+WlHWUtW/lB/YXZZ1JQsATmhHPLSPaGSVbTq75RJppvNVjEU7si
	 Y1UL8EAgoRZU/z6+2ENoha0l0uUocaaKE7+8hgthVlN3TeHYtl+BmmKfV1SjTff2KD
	 3Ux0sHT1IYrBwVlMS+VNdvu6lUE3EqwwMitvfBNg1F7TBSTdPXSj/EElpO6+SWOn+G
	 2SEtkBq0RJA+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Forbes <ian.forbes@broadcom.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Martin Krastev <martin.krastev@broadcom.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 15/23] drm/vmwgfx: Limit display layout ioctl array size to VMWGFX_NUM_DISPLAY_UNITS
Date: Wed, 23 Oct 2024 10:30:59 -0400
Message-ID: <20241023143116.2981369-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
Content-Transfer-Encoding: 8bit

From: Ian Forbes <ian.forbes@broadcom.com>

[ Upstream commit 28a5dfd4f615539fb22fb6d5c219c199c14e6eb6 ]

Currently the array size is only limited by the largest kmalloc size which
is incorrect. This change will also return a more specific error message
than ENOMEM to userspace.

Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240808200634.1074083-1-ian.forbes@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h | 4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 4 +++-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h | 3 ---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index ac3d7ff3f5bb9..def98d868deb4 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -61,7 +61,7 @@
 #define VMWGFX_DRIVER_MINOR 20
 #define VMWGFX_DRIVER_PATCHLEVEL 0
 #define VMWGFX_FIFO_STATIC_SIZE (1024*1024)
-#define VMWGFX_MAX_DISPLAYS 16
+#define VMWGFX_NUM_DISPLAY_UNITS 8
 #define VMWGFX_CMD_BOUNCE_INIT_SIZE 32768
 
 #define VMWGFX_MIN_INITIAL_WIDTH 1280
@@ -81,7 +81,7 @@
 #define VMWGFX_NUM_GB_CONTEXT 256
 #define VMWGFX_NUM_GB_SHADER 20000
 #define VMWGFX_NUM_GB_SURFACE 32768
-#define VMWGFX_NUM_GB_SCREEN_TARGET VMWGFX_MAX_DISPLAYS
+#define VMWGFX_NUM_GB_SCREEN_TARGET VMWGFX_NUM_DISPLAY_UNITS
 #define VMWGFX_NUM_DXCONTEXT 256
 #define VMWGFX_NUM_DXQUERY 512
 #define VMWGFX_NUM_MOB (VMWGFX_NUM_GB_CONTEXT +\
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 08f2470edab27..823ed3d9bff2b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -2326,7 +2326,7 @@ int vmw_kms_update_layout_ioctl(struct drm_device *dev, void *data,
 	struct drm_mode_config *mode_config = &dev->mode_config;
 	struct drm_vmw_update_layout_arg *arg =
 		(struct drm_vmw_update_layout_arg *)data;
-	void __user *user_rects;
+	const void __user *user_rects;
 	struct drm_vmw_rect *rects;
 	struct drm_rect *drm_rects;
 	unsigned rects_size;
@@ -2338,6 +2338,8 @@ int vmw_kms_update_layout_ioctl(struct drm_device *dev, void *data,
 					    VMWGFX_MIN_INITIAL_HEIGHT};
 		vmw_du_update_layout(dev_priv, 1, &def_rect);
 		return 0;
+	} else if (arg->num_outputs > VMWGFX_NUM_DISPLAY_UNITS) {
+		return -E2BIG;
 	}
 
 	rects_size = arg->num_outputs * sizeof(struct drm_vmw_rect);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 19a843da87b78..ec86f92517a14 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -198,9 +198,6 @@ struct vmw_kms_dirty {
 	s32 unit_y2;
 };
 
-#define VMWGFX_NUM_DISPLAY_UNITS 8
-
-
 #define vmw_framebuffer_to_vfb(x) \
 	container_of(x, struct vmw_framebuffer, base)
 #define vmw_framebuffer_to_vfbs(x) \
-- 
2.43.0


