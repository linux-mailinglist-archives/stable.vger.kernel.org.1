Return-Path: <stable+bounces-69221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EBE953752
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 17:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFAC1C2409D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74BC1A01D4;
	Thu, 15 Aug 2024 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fVvS50u9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD253365
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736050; cv=none; b=YxFm0hRO2yW5zHljAqSEC6ntWGOUogrOy08U8jcZo9O8kR8seh1AnDE06wpDQhsL/zf4xFPy79PNmVJ7Zkh3riwBTC5zw78F/JteqYOMIVlzkK7BPR9H9IryqTiuOoxqUiQEUdfbRikmOSUGUn0hk2deuITfSbkDpNG06bqyzX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736050; c=relaxed/simple;
	bh=bGWCnnR/4i5YZP0njH/LPxdX82m9rmD4s7mFWS5zTiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQ+dCziM0crJuUhJIEPzVfczGQ1yURc/+0/vmEIj9iRkH8hJDS7e4rGXvMKfmSEWfqHNazpziOqz070VzJFoSIH7N0gflOJVQIqjgLVeucrT1Hr+xg9fy0KEuwM7QSzi+wuz2oM0uXxZu/BLeateRJuKp1e9Binz3xwwauhBaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fVvS50u9; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1da036d35so68515685a.0
        for <stable@vger.kernel.org>; Thu, 15 Aug 2024 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723736047; x=1724340847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2kGcJSbkmwivszXfrnvHRLGl+Xm4jBx0fR1WLjpBERQ=;
        b=fVvS50u9oZLHNpvhHFMY8V73XNzKlfKytmz1XCyAwSOXqt36EuqjwWpNSXafIADWEh
         f8zXnLV1+xSGx1y9iDIPEIdPBuyuayyN5OBtZknWFWVRxNECuspIbmqmd9sIPu8lS9kh
         QPrQnvkK/4IFz6zQ4DyQ4VYvg6B80fNgGsXoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723736047; x=1724340847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kGcJSbkmwivszXfrnvHRLGl+Xm4jBx0fR1WLjpBERQ=;
        b=JdHDSSKHD6Pc6TE2nbtFrInk+f045xTtzzrgCool0gX3JhIDQBzeJma+/9uFsJ5144
         BJbBf2AvxVbyzQkLz88Ri02a81En4sojmK9+d2cQWxhRxNkQIlHQ5i/+V1Z3y8v5hoKh
         NIWDnPlBHuSACx3AyGxo02c8P+1sm9N5GgL4qOclebvbzKaMLnwCgj01hSVK5QfRD+/d
         +Dhs/qITdIURDOQEpTm6l9a2YLmIh9u35rq7CojBhGp42CeeIR16IDziZpttemDMtr2W
         Wd/GLjOhPECPZAwm/QBNYJvSo/7BDdkweUVz8/wCv2x9HJFFhegWvrMcuX/+sngfhCb0
         aeRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9ZHNld2J3eCTnVMCRGHAl3Kobl704qmjK8rayTYLj+TRd8mostddOzxg+a90lk9lyrrPrj3lMkU9h6GTurAL5KibhQ3U
X-Gm-Message-State: AOJu0YwTCjlNZNoILXXyEslAF7wYafjzbTIoksOorjZX769BrZTrhmie
	I76BO5hJMQdpLGdEy8uv0uGENM3c/mH3WyEKS61WG3zHQrJCq2WyG4zTuAnzOD7m/QDnWcQM5Bs
	=
X-Google-Smtp-Source: AGHT+IEHYhbT5LyPlrcL34vFzMMa/O0rVG5EQedkcQjdAaBMbZ+QDe4eS24p55RQiI83VfnN1uFUKQ==
X-Received: by 2002:a05:620a:244d:b0:79f:523:ac97 with SMTP id af79cd13be357-7a50693e157mr217285a.27.1723736047421;
        Thu, 15 Aug 2024 08:34:07 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff02505dsm72986685a.13.2024.08.15.08.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 08:34:07 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] drm/vmwgfx: Prevent unmapping active read buffers
Date: Thu, 15 Aug 2024 11:31:42 -0400
Message-ID: <20240815153404.630214-1-zack.rusin@broadcom.com>
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


