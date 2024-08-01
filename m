Return-Path: <stable+bounces-65262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB4F945255
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 19:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA511F23038
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 17:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9581B4C49;
	Thu,  1 Aug 2024 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VC94o7R/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147761B32D9
	for <stable@vger.kernel.org>; Thu,  1 Aug 2024 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534960; cv=none; b=q4zs6J/UM1DbPMV5NZSaN/2bDbNGsP980ck4zjMrVvozQRbu0unCBYS0t+1qkqxCEtBG1RfE2+tniLohXeJjexrT6aX5hTkWODoLBi5tiJRFOn9UkmxiEngpbBPWJTubE7K5ZiCnZ9Ph7HM2w+etQ0yd72FSCA+bcDif6e3Mc7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534960; c=relaxed/simple;
	bh=ql+eDrfAcu/Zdnp4XJgV4jt+bF0Yq8Z/VW0hlH6g9Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J0J0ids+zsIllJbN7dnkSnqKrSGH9M+J+2ZYNKgWSiTgtBLY0dyAx0EUOVY+9gptLBCrMIid7HHWSUuMILHPiU44HqvzWV19Qo1Kw6ZytegIYsibnDZZMhSsawaSEd0ejkL+Q/awJVJPWpal9TRa6cNLeobjfGSOAw2az9QLVHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VC94o7R/; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-70b2421471aso4632343a12.0
        for <stable@vger.kernel.org>; Thu, 01 Aug 2024 10:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722534958; x=1723139758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3fdN3/DLiamzo5QjdRkCvIbvGru1UX7f39kFhf5XVSE=;
        b=VC94o7R/dKGr0eHoeWjzG7Tkk71IJ0icYs7SIkp5vZ3uFUH+4l3iQ3BPDhKR/vgzHj
         J4RHpjQYeLQOYcfAyiItMWUcEBVgXR9/zMhvnLdhAvzcsya4fcU/Y7Mfk/pyWox/melM
         xtaqBpO8V6Rr0Bm7J1uid0xYDEWhGlh/tWFsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534958; x=1723139758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fdN3/DLiamzo5QjdRkCvIbvGru1UX7f39kFhf5XVSE=;
        b=kOO+yh7x2Hj3V7S9sMlE22wqDIXjkYtSHpU055QAv6O6+8Esxvm6ghsQmFnKG5i33R
         qIiTh/MWaG++cfpFx2akAkmJChoQxmipDaL2TCQUp8ah21z9KvHd1297tjStpc7bKxTt
         /0uKFhsdHytvAmm349esSr0swulVF5dHUk23WIe+o1t+8oUBD8UdGDP46O3eFYR03Cps
         Qkvoc9aiTDyJLRQlJOH17EC41dxMpjl8VmOgBBURmUGlZ8ALx6buyCihCIdFtGiOi3Hx
         sv+ZPaDvwGxmgoLIj5L68x9ZbnykpB3FCKOfc3MctbxmLjQY2v5V1uwRk/QFpPFlw8jV
         mDHw==
X-Forwarded-Encrypted: i=1; AJvYcCVGou8e/4OQBHsCojoV29TLE72H2nK05l6KNyuwQMygq+QtUJzvvcqvh3UAVZmf5/3Y/NR064FZRXsxpFtjE8izx6iPMe5x
X-Gm-Message-State: AOJu0YwXCiSKBQeNqdeZMueL9ib6ogrlNFgO6yVZccBCpQnahl1rsacM
	P3+bs3+8vO4JqM3EBF9SiYcJ/BqN5PafO1/fzFAWYtttJeONMc1x0A4hXcgeEff7I7SZwCb0iCI
	=
X-Google-Smtp-Source: AGHT+IGztRaX8jV6rVIE8EZ+NclDD0ImAVKFb7YTdV4ZG6l/jeJGfvm3NGI+86rosOyO2gUT6yHYGA==
X-Received: by 2002:a05:6a20:840b:b0:1c3:ff33:24b9 with SMTP id adf61e73a8af0-1c69954a34fmr1412376637.3.1722534958139;
        Thu, 01 Aug 2024 10:55:58 -0700 (PDT)
Received: from vertex.vmware.com (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ece3c19sm103321b3a.134.2024.08.01.10.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:55:57 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/vmwgfx: Prevent unmapping active read buffers
Date: Thu,  1 Aug 2024 13:55:46 -0400
Message-ID: <20240801175548.17185-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kms paths keep a persistent map active to read and compare the cursor
buffer. These maps can race with each other in simple scenario where:
a) buffer "a" mapped for update
b) buffer "a" mapped for compare
c) do the compare
d) unmap "a" for compare
e) update the cursor
f) unmap "a" for update
At step "e" the buffer has been unmapped and the read contents is bogus.

Prevent unmapping of active read buffers by simply keeping a count of
how many paths have currently active maps and unmap only when the count
reaches 0.

Fixes: 485d98d472d5 ("drm/vmwgfx: Add support for CursorMob and CursorBypass 4")
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.19+
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 13 +++++++++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index f42ebc4a7c22..a0e433fbcba6 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -360,6 +360,8 @@ void *vmw_bo_map_and_cache_size(struct vmw_bo *vbo, size_t size)
 	void *virtual;
 	int ret;
 
+	atomic_inc(&vbo->map_count);
+
 	virtual = ttm_kmap_obj_virtual(&vbo->map, &not_used);
 	if (virtual)
 		return virtual;
@@ -383,11 +385,17 @@ void *vmw_bo_map_and_cache_size(struct vmw_bo *vbo, size_t size)
  */
 void vmw_bo_unmap(struct vmw_bo *vbo)
 {
+	int map_count;
+
 	if (vbo->map.bo == NULL)
 		return;
 
-	ttm_bo_kunmap(&vbo->map);
-	vbo->map.bo = NULL;
+	map_count = atomic_dec_return(&vbo->map_count);
+
+	if (!map_count) {
+		ttm_bo_kunmap(&vbo->map);
+		vbo->map.bo = NULL;
+	}
 }
 
 
@@ -421,6 +429,7 @@ static int vmw_bo_init(struct vmw_private *dev_priv,
 	vmw_bo->tbo.priority = 3;
 	vmw_bo->res_tree = RB_ROOT;
 	xa_init(&vmw_bo->detached_resources);
+	atomic_set(&vmw_bo->map_count, 0);
 
 	params->size = ALIGN(params->size, PAGE_SIZE);
 	drm_gem_private_object_init(vdev, &vmw_bo->tbo.base, params->size);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
index 62b4342d5f7c..dc13f1e996c1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
@@ -90,6 +90,7 @@ struct vmw_bo {
 	u32 res_prios[TTM_MAX_BO_PRIORITY];
 	struct xarray detached_resources;
 
+	atomic_t map_count;
 	atomic_t cpu_writers;
 	/* Not ref-counted.  Protected by binding_mutex */
 	struct vmw_resource *dx_query_ctx;
-- 
2.43.0


