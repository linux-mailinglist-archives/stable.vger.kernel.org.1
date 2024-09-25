Return-Path: <stable+bounces-77275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAEC985B5B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2E0285DC0
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99131BD4FD;
	Wed, 25 Sep 2024 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwerk5/6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3A1917C2;
	Wed, 25 Sep 2024 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264898; cv=none; b=W9MsI5iEs9A4Z+73v/c2LO/mIaw5p1UqgeXu2QLYGyXsjBbrXOHvIxfnuM7A3m2fp68wW2fEhMSizJp3HVJ5kTcodt9JqUgb7JC2NodbkZqDYshc+eXGHzyf5xhPbP62FOkqOXiBLdiDa4zzFTGQsJ4eQ0irrY6PoniCCrJw3N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264898; c=relaxed/simple;
	bh=n90fJc+OXdT4oVyDP1R+/rKw9pp9dmoKGuJpxpmeC4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckDxXppAYXGHhsD3bjdcR/CJpih+9N9A5lleFUdO0ZB1rcbgL2uccuko7DnjL4/EfSl97HZuRrkpk8XNrukt1iamTQRMc7531h0g5/r0Bo5YcTa3eoqoE6lx16Vhv6/eAIVBcAXwJdNZ8HD4smW+8L3VXCHVhYVtYf+sAuXkMK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwerk5/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1B1C4CEC3;
	Wed, 25 Sep 2024 11:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264898;
	bh=n90fJc+OXdT4oVyDP1R+/rKw9pp9dmoKGuJpxpmeC4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwerk5/643WdtttLWJYNQl3od1D8KyZOIu4L83to9YUz0WjUXSdcpeIwYnuUPJr4T
	 nkl160njbTsM8OS9BJEIPlp1QfypBOTERKr8GwlYOJs6vwcFS54rhQBDw/HRxstEQy
	 aJHuNW1znsbTw0EtiF6wZQHdRrV5dE2rjarLoLjqAu3PJYdmCpOzTERaNcoy4PJQ3Y
	 Y23ZIME82mnkk2ntfzFVOexQipI6gtjxc2BQJjWkhRQ1dTiLnV/jzZdFJWs/VKnWdq
	 6ZcM++R4lCq39sGwqr6+QOQXyKr2sVKlwNEq5Jsq+pJyG/jGRphvr0Xs1Pyd8LWa9B
	 rDqL9Euu5kCtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uma Shankar <uma.shankar@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	thomas.hellstrom@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 177/244] drm/xe/fbdev: Limit the usage of stolen for LNL+
Date: Wed, 25 Sep 2024 07:26:38 -0400
Message-ID: <20240925113641.1297102-177-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Uma Shankar <uma.shankar@intel.com>

[ Upstream commit 775d0adc01a55fe0458139330415d86bb3533efe ]

As per recommendation in the workarounds:
WA_22019338487

There is an issue with accessing Stolen memory pages due a
hardware limitation. Limit the usage of stolen memory for
fbdev for LNL+. Don't use BIOS FB from stolen on LNL+ and
assign the same from system memory.

v2: Corrected the WA Number, limited WA to LNL and
    Adopted XE_WA framework as suggested by Lucas and Matt.

v3: Introduced the waxxx_display to implement display side
    of WA changes on Lunarlake. Used xe_root_mmio_gt and
    avoid the for loop (Suggested by Lucas)

v4: Fixed some nits (Luca)

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Uma Shankar <uma.shankar@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240717082252.3875909-1-uma.shankar@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/display/intel_fbdev_fb.c   | 6 +++++-
 drivers/gpu/drm/xe/display/xe_plane_initial.c | 6 ++++++
 drivers/gpu/drm/xe/xe_wa_oob.rules            | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/display/intel_fbdev_fb.c b/drivers/gpu/drm/xe/display/intel_fbdev_fb.c
index 816ad13821a83..cd8948c08661b 100644
--- a/drivers/gpu/drm/xe/display/intel_fbdev_fb.c
+++ b/drivers/gpu/drm/xe/display/intel_fbdev_fb.c
@@ -10,6 +10,9 @@
 #include "xe_bo.h"
 #include "xe_gt.h"
 #include "xe_ttm_stolen_mgr.h"
+#include "xe_wa.h"
+
+#include <generated/xe_wa_oob.h>
 
 struct intel_framebuffer *intel_fbdev_fb_alloc(struct drm_fb_helper *helper,
 					       struct drm_fb_helper_surface_size *sizes)
@@ -37,7 +40,7 @@ struct intel_framebuffer *intel_fbdev_fb_alloc(struct drm_fb_helper *helper,
 	size = PAGE_ALIGN(size);
 	obj = ERR_PTR(-ENODEV);
 
-	if (!IS_DGFX(xe)) {
+	if (!IS_DGFX(xe) && !XE_WA(xe_root_mmio_gt(xe), 22019338487_display)) {
 		obj = xe_bo_create_pin_map(xe, xe_device_get_root_tile(xe),
 					   NULL, size,
 					   ttm_bo_type_kernel, XE_BO_FLAG_SCANOUT |
@@ -48,6 +51,7 @@ struct intel_framebuffer *intel_fbdev_fb_alloc(struct drm_fb_helper *helper,
 		else
 			drm_info(&xe->drm, "Allocated fbdev into stolen failed: %li\n", PTR_ERR(obj));
 	}
+
 	if (IS_ERR(obj)) {
 		obj = xe_bo_create_pin_map(xe, xe_device_get_root_tile(xe), NULL, size,
 					   ttm_bo_type_kernel, XE_BO_FLAG_SCANOUT |
diff --git a/drivers/gpu/drm/xe/display/xe_plane_initial.c b/drivers/gpu/drm/xe/display/xe_plane_initial.c
index 5eccd6abb3ef5..a50ab9eae40ae 100644
--- a/drivers/gpu/drm/xe/display/xe_plane_initial.c
+++ b/drivers/gpu/drm/xe/display/xe_plane_initial.c
@@ -18,6 +18,9 @@
 #include "intel_frontbuffer.h"
 #include "intel_plane_initial.h"
 #include "xe_bo.h"
+#include "xe_wa.h"
+
+#include <generated/xe_wa_oob.h>
 
 static bool
 intel_reuse_initial_plane_obj(struct intel_crtc *this,
@@ -104,6 +107,9 @@ initial_plane_bo(struct xe_device *xe,
 		phys_base = base;
 		flags |= XE_BO_FLAG_STOLEN;
 
+		if (XE_WA(xe_root_mmio_gt(xe), 22019338487_display))
+			return NULL;
+
 		/*
 		 * If the FB is too big, just don't use it since fbdev is not very
 		 * important and we should probably use that space with FBC or other
diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
index d4c33dbc14c7a..24a5b7d7cdcc1 100644
--- a/drivers/gpu/drm/xe/xe_wa_oob.rules
+++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
@@ -29,6 +29,7 @@
 13011645652	GRAPHICS_VERSION(2004)
 22019338487	MEDIA_VERSION(2000)
 		GRAPHICS_VERSION(2001)
+22019338487_display	PLATFORM(LUNARLAKE)
 16023588340	GRAPHICS_VERSION(2001)
 14019789679	GRAPHICS_VERSION(1255)
 		GRAPHICS_VERSION_RANGE(1270, 2004)
-- 
2.43.0


