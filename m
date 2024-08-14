Return-Path: <stable+bounces-67705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 797149522A6
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 21:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D57B1C21483
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 19:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35C21BE864;
	Wed, 14 Aug 2024 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GHHGYT3G"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB331BE84E
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723663730; cv=none; b=evu/nV7TaY+/4UPL5YODuwWLSDdBtVpLjeJgVv9RoGyjgm/1/CQuXOpuKqHMGI2E/7iHQNLh4A3KOySK757hBgK2gkOszn9mgc46BFyuIGy13i9tH/7ketmSAoZWbAj1Zf0ccujssOuea5mGC1rE0yjtOGqvchz6uHMcopaRyXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723663730; c=relaxed/simple;
	bh=bGWCnnR/4i5YZP0njH/LPxdX82m9rmD4s7mFWS5zTiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YlnffMqqckdSBrBlviQZ7O+Q6orBMGlOK34mTV5sGZq/sgm7KEeyprSVldj5/KJn1E6YGJIraN/Hov8CDZ5dtMYrmDsdWZBbUQg5g0wch3mOK395Pg3Gmv43p7Z1xf+vjfcLUugWFD2/vbr2TEcZVJwXYjWgDvR/J6z+5d6yHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GHHGYT3G; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b7a4668f1fso1133716d6.3
        for <stable@vger.kernel.org>; Wed, 14 Aug 2024 12:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723663727; x=1724268527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2kGcJSbkmwivszXfrnvHRLGl+Xm4jBx0fR1WLjpBERQ=;
        b=GHHGYT3GstMazoMei8qHdbIcJdOqsyy23KqMjzwpwAvE+g+lbF4crKpnl3W2MlaBti
         Z8qq3tYl7ycaxCyrU+TpRdAHqL66gcRK79f/uZNWFctgeF0McC9GfxKGcvjw+phcTQW7
         nVRmwWjUdc+DN1aXK2rwva9ckVvwT4U5J0jec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723663727; x=1724268527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kGcJSbkmwivszXfrnvHRLGl+Xm4jBx0fR1WLjpBERQ=;
        b=BsDAGMvullA7HGvJqaAQAjny/7migg/LHHpx4DOxBoM0fkOfsW8tSGcWQeTrFNvV1r
         JSgR45UGdH3LjSRwEbxtBLME3ZN+7tnauNOuezd6GUP9V/2rXhW6b53xphSAthsJaeXO
         kFShEb3UDb6RZQsLdFxw+lCRFfIJ4qKR/BCy51gHpG1Oflgod+n702bQ1lc9eLpP+nd8
         hT04jVqfEJS2VwUGH7Vd4bO8tG3eWczGCBRyzFpuyEYHhkYPc8gw/TEP1tPUL54DyjqL
         ymWi3PvisesUYhHr99gQLpcycTFFG/8Ug+hLjaQvwZvsu7JhYZZD4wj0AZwUyoN5BdLd
         I9GQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9E8whpyGiYdvYt1AuD4QBzMLa8LJOwqdqH6rb3DoVFk82t6/1FRFv7hsCQUNBLNL/a5zgF7LuG3Nfv2+1+sl8RGqx3+mo
X-Gm-Message-State: AOJu0YzbfXF6+94ac/wDi0AQfwGjdMIhEmN8yYktNn9im88BzUgcfkTv
	8lsJZUpqanLFvk1snqOqATLulunrZitTdyEiNx4dnoZYgqjYQyHjGLS+ddnw6g==
X-Google-Smtp-Source: AGHT+IG8b5osBujmbU9Eqa4kkoATG/ukAt8sZRngeOd+97Hz5ZKIY5B7NmFVvLKCrkMsVZw80DsrBQ==
X-Received: by 2002:a05:6214:3291:b0:6b5:49c9:ed4f with SMTP id 6a1803df08f44-6bf5d1e5c76mr38029936d6.34.1723663727478;
        Wed, 14 Aug 2024 12:28:47 -0700 (PDT)
Received: from localhost.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e68277sm46902976d6.134.2024.08.14.12.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 12:28:47 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/vmwgfx: Prevent unmapping active read buffers
Date: Wed, 14 Aug 2024 15:27:59 -0400
Message-ID: <20240814192824.56750-1-zack.rusin@broadcom.com>
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

v2: Update doc strings

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


