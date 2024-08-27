Return-Path: <stable+bounces-70295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA34960055
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 06:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D033D1C21033
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 04:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254911BF54;
	Tue, 27 Aug 2024 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HgMXzBdz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1B179A8
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 04:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733209; cv=none; b=kc7+p5hJeTv2XqKFJNTgWgepQ+PL22JUlPIh3kln3OJEgBoJnf3Hxy5CwmGsMzJaVje1ODFs22tuOLuhjeLPGPvyXmF8A+ziW2ty+CNZT3SbkRtDflSq+YEyf1XFgqq+spovRBSmG/8tsKcUPep3BaviJfIy7lUO3iUjqcuD9p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733209; c=relaxed/simple;
	bh=+RktWthfz65ZKT4TmGsanaWrbJYzNQm599AuaRM8psE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OkxpkWyVG0NfUArp4WZEGoAW0VhOOG08NfiWsD85zY7/MSIAa2whNzcXgf+06m+Rjnx3Cs6HYcMtl8qxJVNs6rxlw5/XHhA/8eF3f1Assx0HFQsQAT7JRm9HaQljs4O9jxvLKpWCKw22F2LlItIE6PuS9d1Mc2LP3CyF0I7gjH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HgMXzBdz; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a3574acafeso328280185a.1
        for <stable@vger.kernel.org>; Mon, 26 Aug 2024 21:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724733207; x=1725338007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jO3b/HQbgIsaJ6GcQxLwnZeZj3dlyeqCaKQpgY4bypg=;
        b=HgMXzBdzwjk/BfU8H29f6c77AVuRNoI72QiUurNABnInlDqIBR7lVC9sNORsVVw3zH
         Ja2FwZo0CZcSBB/M6uHm01ILvcZNSnDoYj6/Qeoad8Sf/V1LrUTQqUm5EnfryaojSaDv
         TsNVpbW7adVTpPIvneeq+WoIZPmGKx/rpEHTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724733207; x=1725338007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jO3b/HQbgIsaJ6GcQxLwnZeZj3dlyeqCaKQpgY4bypg=;
        b=eurPPP20QxfS3KVt+/BqAevMV+paKX6IAMi/TluSOIzRfZ4vkkSxBudr6R9WZ4VUKo
         MPYaa8c/2mVH1TTLWA3Kb2iEZdRdNgHV6UUvM07FQgd4Nu6QYddyWO2mRb+qpdkT2vSA
         BJkbxE0PU+tW7ARqKS9UmpmF1HYIzbOi5oTK7m2XeAcrNPMalimXqBQ7yxo6O5s0R+dE
         Ex8bSP3x4h4qo+hZAS2VttMnldTIzwte/rfUNhGzWBZ4NGSXXLKazQrR2GM42qOG3ep+
         FfoiHClHSiCWLDVohpP8922dr0D/OIY0GRiUYUPpupKooBqUqfHZYXjkrZICu5Sf2kJH
         663Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlcL/lPraLQDK02GdveIeZgDZHMx0JgF+A8Qat1spVRQ62789i0vtBbcbUwA4YceHEHtCc9F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysxDyZSx+TNDfA5kWvbnPVmAiEJHYjJKWnseFtU9Kq/UYBz/QG
	66ICcRhzTwd+YRb9gud+JDVXFTiBpRrbAdUtD5JDYpHJ+ckOxTzm3lfpqOqZAQ==
X-Google-Smtp-Source: AGHT+IH8jM3t0qpSTWzftDdR4vyON6uBqO9e4LDu0vWeptUBNKXD6dZnd+MukBUEVgPdQFuVaWU7xQ==
X-Received: by 2002:a05:620a:4096:b0:79d:6169:7ab9 with SMTP id af79cd13be357-7a7e4e717aemr197587485a.68.1724733206628;
        Mon, 26 Aug 2024 21:33:26 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f341e14sm518060585a.30.2024.08.26.21.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 21:33:26 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Cleanup kms setup without 3d
Date: Tue, 27 Aug 2024 00:33:19 -0400
Message-ID: <20240827043319.466910-1-zack.rusin@broadcom.com>
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

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: d6667f0ddf46 ("drm/vmwgfx: Fix handling of dumb buffers")
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.9+
Cc: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Cc: Martin Krastev <martin.krastev@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c     | 9 ---------
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 9 ++++++---
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 288ed0bb75cb..b5fc5a9e123a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1339,15 +1339,6 @@ static int vmw_kms_new_framebuffer_surface(struct vmw_private *dev_priv,
 		return -EINVAL;
 	}
 
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


