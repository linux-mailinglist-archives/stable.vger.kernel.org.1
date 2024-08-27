Return-Path: <stable+bounces-70296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3250796005D
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 06:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41C91F227CE
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 04:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FC63A27E;
	Tue, 27 Aug 2024 04:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IXiHthNx"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DEAF507
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 04:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733557; cv=none; b=Mu9zZUpoSixf6QcxyC8X0K7tHH26wTRQCGtPpnNHpPF22+aSHAEUTjf5wT9Dc3S6GLnGgXEQ4ttlcs3n9pdTDreDYJaZrwxpY2UnyoY3PxKTh4LBV6GjWivrcMDITmt6iL3vlS3z9SMGhPfiKn5yeMyT+KCQfMLqP0td+17OBw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733557; c=relaxed/simple;
	bh=7efmavAVYDFr6/k+ei6YAwD77NodNyNJUHAEEg6TgxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+AYxn0g+SyehHTBoanZYd6JIs9b3ojfyiDE0AsuedWUhVmkiq+l1KFzMN/JT8bODiyzGi8bHQldZksU3NBpjiUSb1AVJuNY3wPvxpaKkDy5aIV7vcpFGWAk5Bi6bAGBziE/sCOQxW+81pB//okZqcFrwEV+3dWPg4fPHdyGSfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IXiHthNx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-45006bcb482so25471641cf.3
        for <stable@vger.kernel.org>; Mon, 26 Aug 2024 21:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724733555; x=1725338355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1bocdzyvmHkkepK3+LJbzi9IWUaQMoy+e/hXMzNP8MY=;
        b=IXiHthNxfGJ/bkVO5UjGgOawU/DoJbW7ZOCqXd6US2R7WNHYBiVXVbLC7FfCeaS22A
         GnQk32mW7k8idqyl2A/1jQswimnfNHSnRhGm6pzpzusmtaB30o5EMHpMZakW4cv6i677
         T5ObJlxzvvIDjo06I08Laq3CZ27XZ/j1o/5lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724733555; x=1725338355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bocdzyvmHkkepK3+LJbzi9IWUaQMoy+e/hXMzNP8MY=;
        b=j8GdvzmsblKSkDIkkcy6XK76tFSu+RclFuI0EEOyx5MPXsy+Ob5/skyftykMoOvNYG
         lvLtgP11A5NqL3oZkpwVdyuwZ8E/k762MbPcTy4Y77jPo+iUm4tkNA2SOUhFf4n59jrF
         heSurHp/vw8788eV0Hj8aJtEbQMuUKxc+HAI596Qei3+O87f5LunIc/sYwb9W+y3us6z
         sKD9a1Bjq5qyRW7/V0EECJGROaPpxI47jbw7+7RbDNo/Wyom2dtHy20ikHgPTVlVeN+k
         vZ4IKcXT2K14ZTD2ifkKdnmXvt1uRLasV8kAPDR2cURW8A0eojszVRu81JqS4hAseoim
         lJhA==
X-Forwarded-Encrypted: i=1; AJvYcCWmZJsvXevcuHKWSwpOah43j5evFyGj0mVTGfu5sMzNwqtm5FjBLlh+u1849OTv/l9tRFIdNyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLrA7KoLC0NDK22Oz5lql3YO2B1nYadBwuS/SdlzhVhdlWU4vY
	riq20d8brfZAvyFhWfTdPnT0cMDzBgsPdroISucVYzJcFnci0zgPJQWyLWf1cw==
X-Google-Smtp-Source: AGHT+IGd4XZ9D7c9hn/Cx4gBCjZy0Tf59omb8CgUBnisLTa8ZI7ofU9G/JgaupnYRIs4Br6+p1oj+A==
X-Received: by 2002:ac8:7f94:0:b0:456:45d8:2f08 with SMTP id d75a77b69052e-45645d83036mr109629691cf.46.1724733554679;
        Mon, 26 Aug 2024 21:39:14 -0700 (PDT)
Received: from localhost.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe0dba78sm49731841cf.35.2024.08.26.21.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 21:39:14 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/vmwgfx: Cleanup kms setup without 3d
Date: Tue, 27 Aug 2024 00:39:05 -0400
Message-ID: <20240827043905.472825-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not validate format equality for the non 3d cases to allow xrgb to
argb copies and make sure the dx binding flags are only used
on dx compatible surfaces.

Fixes basic 2d kms setup on configurations without 3d. There's little
practical benefit to it because kms framebuffer coherence is disabled
on configurations without 3d but with those changes the code actually
makes sense.

v2: Remove the now unused format variable

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: d6667f0ddf46 ("drm/vmwgfx: Fix handling of dumb buffers")
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.9+
Cc: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Cc: Martin Krastev <martin.krastev@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c     | 29 -------------------------
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |  9 +++++---
 2 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 288ed0bb75cb..282b6153bcdd 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1283,7 +1283,6 @@ static int vmw_kms_new_framebuffer_surface(struct vmw_private *dev_priv,
 {
 	struct drm_device *dev = &dev_priv->drm;
 	struct vmw_framebuffer_surface *vfbs;
-	enum SVGA3dSurfaceFormat format;
 	struct vmw_surface *surface;
 	int ret;
 
@@ -1320,34 +1319,6 @@ static int vmw_kms_new_framebuffer_surface(struct vmw_private *dev_priv,
 		return -EINVAL;
 	}
 
-	switch (mode_cmd->pixel_format) {
-	case DRM_FORMAT_ARGB8888:
-		format = SVGA3D_A8R8G8B8;
-		break;
-	case DRM_FORMAT_XRGB8888:
-		format = SVGA3D_X8R8G8B8;
-		break;
-	case DRM_FORMAT_RGB565:
-		format = SVGA3D_R5G6B5;
-		break;
-	case DRM_FORMAT_XRGB1555:
-		format = SVGA3D_A1R5G5B5;
-		break;
-	default:
-		DRM_ERROR("Invalid pixel format: %p4cc\n",
-			  &mode_cmd->pixel_format);
-		return -EINVAL;
-	}
-
-	/*
-	 * For DX, surface format validation is done when surface->scanout
-	 * is set.
-	 */
-	if (!has_sm4_context(dev_priv) && format != surface->metadata.format) {
-		DRM_ERROR("Invalid surface format for requested mode.\n");
-		return -EINVAL;
-	}
-
 	vfbs = kzalloc(sizeof(*vfbs), GFP_KERNEL);
 	if (!vfbs) {
 		ret = -ENOMEM;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 1625b30d9970..5721c74da3e0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -2276,9 +2276,12 @@ int vmw_dumb_create(struct drm_file *file_priv,
 	const struct SVGA3dSurfaceDesc *desc = vmw_surface_get_desc(format);
 	SVGA3dSurfaceAllFlags flags = SVGA3D_SURFACE_HINT_TEXTURE |
 				      SVGA3D_SURFACE_HINT_RENDERTARGET |
-				      SVGA3D_SURFACE_SCREENTARGET |
-				      SVGA3D_SURFACE_BIND_SHADER_RESOURCE |
-				      SVGA3D_SURFACE_BIND_RENDER_TARGET;
+				      SVGA3D_SURFACE_SCREENTARGET;
+
+	if (vmw_surface_is_dx_screen_target_format(format)) {
+		flags |= SVGA3D_SURFACE_BIND_SHADER_RESOURCE |
+			 SVGA3D_SURFACE_BIND_RENDER_TARGET;
+	}
 
 	/*
 	 * Without mob support we're just going to use raw memory buffer
-- 
2.43.0


