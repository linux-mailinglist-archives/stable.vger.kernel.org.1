Return-Path: <stable+bounces-87854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1BC9ACC8F
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA231C2061C
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6A2146018;
	Wed, 23 Oct 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1LRo0za"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560AD1D016A;
	Wed, 23 Oct 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693844; cv=none; b=OXu5aqYtBHkkWf3wr6NmsyuOFRRcZ5j3Oho9eb75Ndipx8Sm7SrHubexCD6k84hZ4i/mDQd/MUSuBbegGXHFHvUBjRNi4CFtn85MkRWAjgxGtIWsVIAXDQKPXDrbEEc2fm4IgPy7mGbYO798MKQfIjwDzLYfOOChyMrSqd0+6og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693844; c=relaxed/simple;
	bh=Tmr6J5mJFH6Iy72xJOrNjejVaHARmkj7o5RpsJk38m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8rH7qL/D68BYndFKJafYCZfahTMsS7kfeq+4Mp9IecA0ebltrdQTm8x3Wm36Jtdqrs/0G1HZVqAo91Bdyl2UKDM1BwpFQNKNkw5CWidVCYXke/K9r5B9kEFBQ01IhqpVJQu21Te+zCrWw+YmJ2Ikb6baYUDU7QM0gO6eAgM0v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1LRo0za; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E5FC4CEE4;
	Wed, 23 Oct 2024 14:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693844;
	bh=Tmr6J5mJFH6Iy72xJOrNjejVaHARmkj7o5RpsJk38m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1LRo0zacq+GRRzV9UxekgPXqtoIK5e9ti+7vCXQfNyVTGtx4UN0lGyBSYhQoSXrQ
	 eCoGLaceXEmFhlj/rf/RzXo50adB2a9hMaEi3D8agddAHIL52kpj48ZOdiA+Ga/WiT
	 e4W4bXjqO8ogczb9hWtxEAozvd2IZqGOy3Ekv3GQ9FIctIXm0pUfknoGQdwHTHch3N
	 lAa3gcmPB/3/DACIk6/ORVX77qws1bBgD0zTM7UKm6GVIGy4/q1WpeqOxASnBP82DC
	 3AkYdnF+eYD8QRhDsdreODn3sCyJ7wRkigHxikEvfYDIp/fpyOPNSvIkKdl669+PK9
	 gf7r8oHo1P0uw==
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
Subject: [PATCH AUTOSEL 6.11 19/30] drm/vmwgfx: Limit display layout ioctl array size to VMWGFX_NUM_DISPLAY_UNITS
Date: Wed, 23 Oct 2024 10:29:44 -0400
Message-ID: <20241023143012.2980728-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
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
index 3f4719b3c2681..4e2807f5f94cf 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -62,7 +62,7 @@
 #define VMWGFX_DRIVER_MINOR 20
 #define VMWGFX_DRIVER_PATCHLEVEL 0
 #define VMWGFX_FIFO_STATIC_SIZE (1024*1024)
-#define VMWGFX_MAX_DISPLAYS 16
+#define VMWGFX_NUM_DISPLAY_UNITS 8
 #define VMWGFX_CMD_BOUNCE_INIT_SIZE 32768
 
 #define VMWGFX_MIN_INITIAL_WIDTH 1280
@@ -82,7 +82,7 @@
 #define VMWGFX_NUM_GB_CONTEXT 256
 #define VMWGFX_NUM_GB_SHADER 20000
 #define VMWGFX_NUM_GB_SURFACE 32768
-#define VMWGFX_NUM_GB_SCREEN_TARGET VMWGFX_MAX_DISPLAYS
+#define VMWGFX_NUM_GB_SCREEN_TARGET VMWGFX_NUM_DISPLAY_UNITS
 #define VMWGFX_NUM_DXCONTEXT 256
 #define VMWGFX_NUM_DXQUERY 512
 #define VMWGFX_NUM_MOB (VMWGFX_NUM_GB_CONTEXT +\
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 288ed0bb75cb9..884804274dfb1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -2225,7 +2225,7 @@ int vmw_kms_update_layout_ioctl(struct drm_device *dev, void *data,
 	struct drm_mode_config *mode_config = &dev->mode_config;
 	struct drm_vmw_update_layout_arg *arg =
 		(struct drm_vmw_update_layout_arg *)data;
-	void __user *user_rects;
+	const void __user *user_rects;
 	struct drm_vmw_rect *rects;
 	struct drm_rect *drm_rects;
 	unsigned rects_size;
@@ -2237,6 +2237,8 @@ int vmw_kms_update_layout_ioctl(struct drm_device *dev, void *data,
 					    VMWGFX_MIN_INITIAL_HEIGHT};
 		vmw_du_update_layout(dev_priv, 1, &def_rect);
 		return 0;
+	} else if (arg->num_outputs > VMWGFX_NUM_DISPLAY_UNITS) {
+		return -E2BIG;
 	}
 
 	rects_size = arg->num_outputs * sizeof(struct drm_vmw_rect);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 6141fadf81efe..2a6c6d6581e02 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -199,9 +199,6 @@ struct vmw_kms_dirty {
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


