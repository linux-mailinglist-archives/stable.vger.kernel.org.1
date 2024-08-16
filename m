Return-Path: <stable+bounces-69341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31B89550EC
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 20:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE0C1F2125C
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523F01C379A;
	Fri, 16 Aug 2024 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XzLQCcZg"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B31BE873
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833219; cv=none; b=aruVK3vcGkBmdoW5jEPtPJqVT7XoBOdM6a32P28V/oNyqmcW2LKyRkeS3Eozo2tvbVAxdJHVGu82b+fvV6Y0MuLeTmocj8SQ2n4YdU+C6loS33rEvzF1sJeZ/LmlcJ07O9HStB2fsjISxtREtaQK1P/DGmHxmOo/STQKiC14P0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833219; c=relaxed/simple;
	bh=arvOACnnjHNV3OWr/0w3/025EUzeHIz3Md5uMhIKfII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7FpAi2/jGW4R+B3OMqHnYZbDDOQqOyd6vblvGrSlh6Qp9CPmJqvGA1MWDSQC/NT42xtpYDeaKw2rxt6bymN+uB00Ym5Lz2zpCIIpMgIXVysiroa2x8IeCDJ165UASXT1e+3/zRsb8qatQ4xqn3uvr7Wdy3N9kFO0XWfWcIWz6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XzLQCcZg; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5bb03fe42so1306851eaf.3
        for <stable@vger.kernel.org>; Fri, 16 Aug 2024 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723833216; x=1724438016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P95LtJB1nhFTYOUH2EZKp7MYs1daoi0KuRhYeJ4tGy4=;
        b=XzLQCcZg1aKOOKGL8eQkyRVyo6qQgsX51gyi/GSSFfuO43HczapEXFpQaYVNbiHBNj
         mDNWAywWMtiT1sjhlNtvqXNv2gSqcI+dUuX1LvWHtl1hP/Z67zPzy5IQ8eAQJmgcTpTh
         obZHQcfEB7FiZN5+U4XmkAkpgMBQZsrAqwxoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723833216; x=1724438016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P95LtJB1nhFTYOUH2EZKp7MYs1daoi0KuRhYeJ4tGy4=;
        b=bY1yM5LZCLXUwzY9UBXOK44GMCauvpC89kBZQwZescadoffEU1SpX89OUwdtYjV7Ej
         6u6qSU+OFtHrIOD9aV+WL2JyTSLjXBt++T0AtugnZIR4ds/7XSs78tY8WGPWHSxju/qH
         FrVtSqpv0xwNLkBydhroH/J2a/GWDr9tz3aMheCt+8LcN7j7ylZA0n//X/I0CFVxtYUM
         Lmrhqh5LqnQOHypaIvD7t95ejY8kp8a140V3OtolQeq/QMIHg3ZYci05yruyHQAiqODX
         hwpT/I6eWzdgfgqCdNaL6gEjdJj9pxXuBWo5lP/ebnP1yh2DgwN24cKVVx8zdmWMfFst
         y0QA==
X-Forwarded-Encrypted: i=1; AJvYcCX2s3xNu1nrw9tRcAYOF8+vqjfFVpfKmtU7eQDXqDKyw6V+e7S8UrKXTSMpICe5w4x+whu3PlMe3N9m5kOvxe6EHoJSyIH3
X-Gm-Message-State: AOJu0YxSOBtroMSviCKNsxZ+er1+cTiwKdzLHeLFwsdQeh25c5e0PZNl
	vcziuihIWOdlF3Y9qXlacQSSaR14yrMKJhzX5uV8HgBEchd0KWThYyh12PyX3w==
X-Google-Smtp-Source: AGHT+IGx0lop90/Dw2gUMjIutZqyQovKDw6FztnK7wDaypj8FZGYkH/MZWSNgxrxUCHCWkQw3OIX7w==
X-Received: by 2002:a05:6358:290b:b0:1b1:ac7f:51d5 with SMTP id e5c5f4694b2df-1b3a3b91aeamr69774255d.22.1723833216107;
        Fri, 16 Aug 2024 11:33:36 -0700 (PDT)
Received: from localhost.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe26c71sm20164106d6.61.2024.08.16.11.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:33:35 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] drm/vmwgfx: Prevent unmapping active read buffers
Date: Fri, 16 Aug 2024 14:32:05 -0400
Message-ID: <20240816183332.31961-2-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816183332.31961-1-zack.rusin@broadcom.com>
References: <20240816183332.31961-1-zack.rusin@broadcom.com>
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
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h |  3 +++
 2 files changed, 14 insertions(+), 2 deletions(-)

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
index 62b4342d5f7c..43b5439ec9f7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
@@ -71,6 +71,8 @@ struct vmw_bo_params {
  * @map: Kmap object for semi-persistent mappings
  * @res_tree: RB tree of resources using this buffer object as a backing MOB
  * @res_prios: Eviction priority counts for attached resources
+ * @map_count: The number of currently active maps. Will differ from the
+ * cpu_writers because it includes kernel maps.
  * @cpu_writers: Number of synccpu write grabs. Protected by reservation when
  * increased. May be decreased without reservation.
  * @dx_query_ctx: DX context if this buffer object is used as a DX query MOB
@@ -90,6 +92,7 @@ struct vmw_bo {
 	u32 res_prios[TTM_MAX_BO_PRIORITY];
 	struct xarray detached_resources;
 
+	atomic_t map_count;
 	atomic_t cpu_writers;
 	/* Not ref-counted.  Protected by binding_mutex */
 	struct vmw_resource *dx_query_ctx;
-- 
2.43.0


