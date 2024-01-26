Return-Path: <stable+bounces-15923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A8183E311
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 21:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1835287542
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 20:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEE922616;
	Fri, 26 Jan 2024 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OMpsoMLn"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8A225DA
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299699; cv=none; b=KpFNKAsTeu+AfgjJLyvHgZNbUaLkvbU4RB+Nv7TGCth2wz+VxVrmtVGYgSEH4VZZMShR/Ob3MgjOhQoJyeG7Q/8FKcdyJ1b0DcNfj7RgMMwwHW+3HDKChlcpAKr4Zw4ZwMu+L7kNruZMuN/5Kadrz2r8eHMHQQP9MqkYQ2SphXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299699; c=relaxed/simple;
	bh=OK1s9zI11suzpS7gWQsadmQvqCVXInfyZCMHnlk1Ho0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W6g5d8m8RDGzWnM0U8rC4e8t+398Fq+8myBU9Tge2vdTuP72OdNaxNL5n5Mq/eKNzAeGN5/BY1oZvaoxnXQqsI395NCDsbuXvQCRJ2Ec6Os8Xyu+MqKM3vbSugEFhoi2Xnf3rT5/I2FLcndnETddp1PPoyKE9XKjjcQuRD33s+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OMpsoMLn; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5988e55ede0so422165eaf.2
        for <stable@vger.kernel.org>; Fri, 26 Jan 2024 12:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706299697; x=1706904497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNaPGeyKlKQ94ax58bojymvRs406SDq+X0qIIGYQv8Y=;
        b=OMpsoMLnkNxx7kr6oTcEfTgV/MNIDIzjfS/s52xRedIZE6WjwbU41NpVuifG68jQj5
         71pfjAblga5DbV3khgxVHJBEQQQPJFGWgkKzuwkxAHZgzULIUVHzWxsw5LHtbTqLQIVx
         BlfN5RbYoQyBA6A9j5yXSFqDViY9UNTMto8oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706299697; x=1706904497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNaPGeyKlKQ94ax58bojymvRs406SDq+X0qIIGYQv8Y=;
        b=H7IkuAJzCuihuly4KzCmD1kF7fNCPRPnyZ9geIIx7s0nsJtn6hXCAA4aLOxeQhOcnT
         CrrptYcDJhKPaykhPjFEE1b78kZk4SjvZv5vDjfwfnMGj58lHbWsIsxVvNP7ESSHYA7W
         tUwbcIvb0v5/AqmxxEmwyXvhduklgtN1UZ4V5iFie8c84RWoHYe9Hf4rSnIXEPSgQt5/
         bXxci8Z2AyoxofIQRQGVtUbkBWwrO9va3MXmFjiCq8RP0ZdFVbtMNrQYBAjQSz06vSD0
         vanolgW/Q9lAsdlLxhImzu/mEvYEdd4bAwWvgVh3ZuAEA9QLCAzDXXdljXCY6nc3bKGV
         FAgg==
X-Gm-Message-State: AOJu0YzqKRV5/aA9/EqPhzu2QNSGUZfzJvqDhb8g6X4HotF3BPN7ZeUi
	suSg5QiyQBhgpugENFXbYtgL3Sn56jgHvfB9ycodDCtbeI7Bz8v6ygJ7iqS4oA==
X-Google-Smtp-Source: AGHT+IH39b86p7OqPsmMTO5ocOSpZNAU7+xTWrB4e1H9kvKTfsrMeuXyzi31u0AJH0P4OBY3fkLt2Q==
X-Received: by 2002:a4a:bd8c:0:b0:59a:161e:ed64 with SMTP id k12-20020a4abd8c000000b0059a161eed64mr191671oop.8.1706299696997;
        Fri, 26 Jan 2024 12:08:16 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id k7-20020a4abd87000000b00599f5c2c052sm358161oop.8.2024.01.26.12.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 12:08:16 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/5] drm/vmwgfx: Fix the lifetime of the bo cursor memory
Date: Fri, 26 Jan 2024 15:08:04 -0500
Message-Id: <20240126200804.732454-6-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240126200804.732454-1-zack.rusin@broadcom.com>
References: <20240126200804.732454-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cleanup can be dispatched while the atomic update is still active,
which means that the memory acquired in the atomic update needs to
not be invalidated by the cleanup. The buffer objects in vmw_plane_state
instead of using the builtin map_and_cache were trying to handle
the lifetime of the mapped memory themselves, leading to crashes.

Use the map_and_cache instead of trying to manage the lifetime of the
buffer objects held by the vmw_plane_state.

Fixes kernel oops'es in IGT's kms_cursor_legacy forked-bo.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: bb6780aa5a1d ("drm/vmwgfx: Diff cursors when using cmds")
Cc: <stable@vger.kernel.org> # v6.2+
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index e2bfaf4522a6..cd4925346ed4 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -185,13 +185,12 @@ static u32 vmw_du_cursor_mob_size(u32 w, u32 h)
  */
 static u32 *vmw_du_cursor_plane_acquire_image(struct vmw_plane_state *vps)
 {
-	bool is_iomem;
 	if (vps->surf) {
 		if (vps->surf_mapped)
 			return vmw_bo_map_and_cache(vps->surf->res.guest_memory_bo);
 		return vps->surf->snooper.image;
 	} else if (vps->bo)
-		return ttm_kmap_obj_virtual(&vps->bo->map, &is_iomem);
+		return vmw_bo_map_and_cache(vps->bo);
 	return NULL;
 }
 
@@ -653,22 +652,12 @@ vmw_du_cursor_plane_cleanup_fb(struct drm_plane *plane,
 {
 	struct vmw_cursor_plane *vcp = vmw_plane_to_vcp(plane);
 	struct vmw_plane_state *vps = vmw_plane_state_to_vps(old_state);
-	bool is_iomem;
 
 	if (vps->surf_mapped) {
 		vmw_bo_unmap(vps->surf->res.guest_memory_bo);
 		vps->surf_mapped = false;
 	}
 
-	if (vps->bo && ttm_kmap_obj_virtual(&vps->bo->map, &is_iomem)) {
-		const int ret = ttm_bo_reserve(&vps->bo->tbo, true, false, NULL);
-
-		if (likely(ret == 0)) {
-			ttm_bo_kunmap(&vps->bo->map);
-			ttm_bo_unreserve(&vps->bo->tbo);
-		}
-	}
-
 	vmw_du_cursor_plane_unmap_cm(vps);
 	vmw_du_put_cursor_mob(vcp, vps);
 
-- 
2.40.1


