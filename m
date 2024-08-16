Return-Path: <stable+bounces-69342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE119550ED
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 20:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FCA287463
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F141C2316;
	Fri, 16 Aug 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NbiayB3H"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A71C231F
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833220; cv=none; b=svGJ82htxenPHwzaR2BlEglrgoKByQWAy3lqQ6qN1NEXO8TOmMr4ttzrBCEB2/FIMolUvl4BvYR3TfD00WUFZ7qdg+KTSEc4rOrJxBrP0euSb1ZWgcJB09GuTQhzR8BSVabgLLaHfhOlynhAV257iJ4kkLAQ4UTnAJXapZlxDKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833220; c=relaxed/simple;
	bh=xwMc7Eh8MiNew8dnynRxHIq1PUJZfnMn5ka8o0LA+JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6Ont9/TWJhDfLWPi9bYc2PRosmfbFI4ysHWtDIE5mNBJL+sLttcUbT7oPAFnIGKacy/Qa72oaWmxaTMw3s0T4kypjUbspYQYzuT1uvTQB3kMcEdNEWxao5HcPb33J9yID+XzGif3kwVtpXDVC+ytl7Bp5jArqrPQkVqs903AXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NbiayB3H; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-842fc587553so612301241.1
        for <stable@vger.kernel.org>; Fri, 16 Aug 2024 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723833217; x=1724438017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYWUUg7NqfFpMWHrS5ST33hphvYoId+HX6paVNnT26A=;
        b=NbiayB3HUeaASsIWWh5ALnbUz+iFk3UvEmJIsni7D1CJFPmyFndgd6LBqh5XIsOHtD
         rHiWFagvleJBYLV4Q1XD9ieQgVhaz2mHzMKRQEX5OON75d+JM1YFjiA7QLH/iFzjSoM4
         ZX5pP4mIIDxsjQf0C7a/sOYpCqiXWUtdE7nkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723833217; x=1724438017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYWUUg7NqfFpMWHrS5ST33hphvYoId+HX6paVNnT26A=;
        b=kLtoAl7IbCGEik4A+/kzpjJGY3JEANLSrKmINUtEmgZLmJQt9fXcHrvKhZBvOCJZlh
         ycKmWDqY2JRO8cpVPTLWnfXjG6kG/ToYwfvK4txZggKtnMJsVoG9y5VMOar5oe+jr9fw
         3dxKaSFgD1ebxlIPMUEwcz+XPntytCDJg3aEogScvJlEz5dieigM223jvcPXRUX6juwC
         WlKMsyPDkaS/xldFb+G6Iay4BrOEv4a6JO5N7fGGVRyBNzdT2tnD1EEKvgv0W7K25idw
         UZonOu8F4Z9EoTrN7gOSTLWic2FSePo4+9VIDQcyF8LwAGp2WcSxEzYP2IYMyyvomDC0
         uDuw==
X-Forwarded-Encrypted: i=1; AJvYcCXgtugS+O6rPH3XmLEHo9Rq0dPHDbhy62F49ug9dXUvRhoZNUzqOhZVPKNV4H+Gi1FgXCWE4RBKK9MfDks+qdbFRXqd7vzu
X-Gm-Message-State: AOJu0YzbQDCTCEmmnL6NMJ02+uqmjZfwDm6fqIGU+mBQbJD3YB+9u067
	7t0sRlyjaOf1Ps0dowgIhfUGPPfsiL5DNO4JSy6gLh9dps5/7Tc1qGyhN148iQ==
X-Google-Smtp-Source: AGHT+IEJN6SqabK0hXe4/wuk8ON4Xn26kMUnOPhCQagh51AfPPmbe9A1X5WVVFoIJIGC62rF+8iWRw==
X-Received: by 2002:a05:6122:3189:b0:4f5:cd00:e492 with SMTP id 71dfb90a1353d-4fc6c981e94mr4519312e0c.7.1723833216756;
        Fri, 16 Aug 2024 11:33:36 -0700 (PDT)
Received: from localhost.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe26c71sm20164106d6.61.2024.08.16.11.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:33:36 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] drm/vmwgfx: Fix prime with external buffers
Date: Fri, 16 Aug 2024 14:32:06 -0400
Message-ID: <20240816183332.31961-3-zack.rusin@broadcom.com>
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

Make sure that for external buffers mapping goes through the dma_buf
interface instead of trying to access pages directly.

External buffers might not provide direct access to readable/writable
pages so to make sure the bo's created from external dma_bufs can be
read dma_buf interface has to be used.

Fixes crashes in IGT's kms_prime with vgem. Regular desktop usage won't
trigger this due to the fact that virtual machines will not have
multiple GPUs but it enables better test coverage in IGT.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: b32233acceff ("drm/vmwgfx: Fix prime import/export")
Cc: <stable@vger.kernel.org> # v6.6+
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.9+
---
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c | 114 ++++++++++++++++++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h  |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |  12 +--
 3 files changed, 118 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
index 717d624e9a05..890a66a2361f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
@@ -27,6 +27,8 @@
  **************************************************************************/
 
 #include "vmwgfx_drv.h"
+
+#include "vmwgfx_bo.h"
 #include <linux/highmem.h>
 
 /*
@@ -420,13 +422,105 @@ static int vmw_bo_cpu_blit_line(struct vmw_bo_blit_line_data *d,
 	return 0;
 }
 
+static void *map_external(struct vmw_bo *bo, struct iosys_map *map)
+{
+	struct vmw_private *vmw =
+		container_of(bo->tbo.bdev, struct vmw_private, bdev);
+	void *ptr = NULL;
+	int ret;
+
+	if (bo->tbo.base.import_attach) {
+		ret = dma_buf_vmap(bo->tbo.base.dma_buf, map);
+		if (ret) {
+			drm_dbg_driver(&vmw->drm,
+				       "Wasn't able to map external bo!\n");
+			goto out;
+		}
+		ptr = map->vaddr;
+	} else {
+		ptr = vmw_bo_map_and_cache(bo);
+	}
+
+out:
+	return ptr;
+}
+
+static void unmap_external(struct vmw_bo *bo, struct iosys_map *map)
+{
+	if (bo->tbo.base.import_attach)
+		dma_buf_vunmap(bo->tbo.base.dma_buf, map);
+	else
+		vmw_bo_unmap(bo);
+}
+
+static int vmw_external_bo_copy(struct vmw_bo *dst, u32 dst_offset,
+				u32 dst_stride, struct vmw_bo *src,
+				u32 src_offset, u32 src_stride,
+				u32 width_in_bytes, u32 height,
+				struct vmw_diff_cpy *diff)
+{
+	struct vmw_private *vmw =
+		container_of(dst->tbo.bdev, struct vmw_private, bdev);
+	size_t dst_size = dst->tbo.resource->size;
+	size_t src_size = src->tbo.resource->size;
+	struct iosys_map dst_map = {0};
+	struct iosys_map src_map = {0};
+	int ret, i;
+	int x_in_bytes;
+	u8 *vsrc;
+	u8 *vdst;
+
+	vsrc = map_external(src, &src_map);
+	if (!vsrc) {
+		drm_dbg_driver(&vmw->drm, "Wasn't able to map src\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	vdst = map_external(dst, &dst_map);
+	if (!vdst) {
+		drm_dbg_driver(&vmw->drm, "Wasn't able to map dst\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	vsrc += src_offset;
+	vdst += dst_offset;
+	if (src_stride == dst_stride) {
+		dst_size -= dst_offset;
+		src_size -= src_offset;
+		memcpy(vdst, vsrc,
+		       min(dst_stride * height, min(dst_size, src_size)));
+	} else {
+		WARN_ON(dst_stride < width_in_bytes);
+		for (i = 0; i < height; ++i) {
+			memcpy(vdst, vsrc, width_in_bytes);
+			vsrc += src_stride;
+			vdst += dst_stride;
+		}
+	}
+
+	x_in_bytes = (dst_offset % dst_stride);
+	diff->rect.x1 =  x_in_bytes / diff->cpp;
+	diff->rect.y1 = ((dst_offset - x_in_bytes) / dst_stride);
+	diff->rect.x2 = diff->rect.x1 + width_in_bytes / diff->cpp;
+	diff->rect.y2 = diff->rect.y1 + height;
+
+	ret = 0;
+out:
+	unmap_external(src, &src_map);
+	unmap_external(dst, &dst_map);
+
+	return ret;
+}
+
 /**
  * vmw_bo_cpu_blit - in-kernel cpu blit.
  *
- * @dst: Destination buffer object.
+ * @vmw_dst: Destination buffer object.
  * @dst_offset: Destination offset of blit start in bytes.
  * @dst_stride: Destination stride in bytes.
- * @src: Source buffer object.
+ * @vmw_src: Source buffer object.
  * @src_offset: Source offset of blit start in bytes.
  * @src_stride: Source stride in bytes.
  * @w: Width of blit.
@@ -444,13 +538,15 @@ static int vmw_bo_cpu_blit_line(struct vmw_bo_blit_line_data *d,
  * Neither of the buffer objects may be placed in PCI memory
  * (Fixed memory in TTM terminology) when using this function.
  */
-int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
+int vmw_bo_cpu_blit(struct vmw_bo *vmw_dst,
 		    u32 dst_offset, u32 dst_stride,
-		    struct ttm_buffer_object *src,
+		    struct vmw_bo *vmw_src,
 		    u32 src_offset, u32 src_stride,
 		    u32 w, u32 h,
 		    struct vmw_diff_cpy *diff)
 {
+	struct ttm_buffer_object *src = &vmw_src->tbo;
+	struct ttm_buffer_object *dst = &vmw_dst->tbo;
 	struct ttm_operation_ctx ctx = {
 		.interruptible = false,
 		.no_wait_gpu = false
@@ -460,6 +556,11 @@ int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
 	int ret = 0;
 	struct page **dst_pages = NULL;
 	struct page **src_pages = NULL;
+	bool src_external = (src->ttm->page_flags & TTM_TT_FLAG_EXTERNAL) != 0;
+	bool dst_external = (dst->ttm->page_flags & TTM_TT_FLAG_EXTERNAL) != 0;
+
+	if (WARN_ON(dst == src))
+		return -EINVAL;
 
 	/* Buffer objects need to be either pinned or reserved: */
 	if (!(dst->pin_count))
@@ -479,6 +580,11 @@ int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
 			return ret;
 	}
 
+	if (src_external || dst_external)
+		return vmw_external_bo_copy(vmw_dst, dst_offset, dst_stride,
+					    vmw_src, src_offset, src_stride,
+					    w, h, diff);
+
 	if (!src->ttm->pages && src->ttm->sg) {
 		src_pages = kvmalloc_array(src->ttm->num_pages,
 					   sizeof(struct page *), GFP_KERNEL);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 32f50e595809..3f4719b3c268 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -1353,9 +1353,9 @@ void vmw_diff_memcpy(struct vmw_diff_cpy *diff, u8 *dest, const u8 *src,
 
 void vmw_memcpy(struct vmw_diff_cpy *diff, u8 *dest, const u8 *src, size_t n);
 
-int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
+int vmw_bo_cpu_blit(struct vmw_bo *dst,
 		    u32 dst_offset, u32 dst_stride,
-		    struct ttm_buffer_object *src,
+		    struct vmw_bo *src,
 		    u32 src_offset, u32 src_stride,
 		    u32 w, u32 h,
 		    struct vmw_diff_cpy *diff);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 5106413c14b7..3cc664384b66 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -502,7 +502,7 @@ static void vmw_stdu_bo_cpu_commit(struct vmw_kms_dirty *dirty)
 		container_of(dirty->unit, typeof(*stdu), base);
 	s32 width, height;
 	s32 src_pitch, dst_pitch;
-	struct ttm_buffer_object *src_bo, *dst_bo;
+	struct vmw_bo *src_bo, *dst_bo;
 	u32 src_offset, dst_offset;
 	struct vmw_diff_cpy diff = VMW_CPU_BLIT_DIFF_INITIALIZER(stdu->cpp);
 
@@ -517,11 +517,11 @@ static void vmw_stdu_bo_cpu_commit(struct vmw_kms_dirty *dirty)
 
 	/* Assume we are blitting from Guest (bo) to Host (display_srf) */
 	src_pitch = stdu->display_srf->metadata.base_size.width * stdu->cpp;
-	src_bo = &stdu->display_srf->res.guest_memory_bo->tbo;
+	src_bo = stdu->display_srf->res.guest_memory_bo;
 	src_offset = ddirty->top * src_pitch + ddirty->left * stdu->cpp;
 
 	dst_pitch = ddirty->pitch;
-	dst_bo = &ddirty->buf->tbo;
+	dst_bo = ddirty->buf;
 	dst_offset = ddirty->fb_top * dst_pitch + ddirty->fb_left * stdu->cpp;
 
 	(void) vmw_bo_cpu_blit(dst_bo, dst_offset, dst_pitch,
@@ -1143,7 +1143,7 @@ vmw_stdu_bo_populate_update_cpu(struct vmw_du_update_plane  *update, void *cmd,
 	struct vmw_diff_cpy diff = VMW_CPU_BLIT_DIFF_INITIALIZER(0);
 	struct vmw_stdu_update_gb_image *cmd_img = cmd;
 	struct vmw_stdu_update *cmd_update;
-	struct ttm_buffer_object *src_bo, *dst_bo;
+	struct vmw_bo *src_bo, *dst_bo;
 	u32 src_offset, dst_offset;
 	s32 src_pitch, dst_pitch;
 	s32 width, height;
@@ -1157,11 +1157,11 @@ vmw_stdu_bo_populate_update_cpu(struct vmw_du_update_plane  *update, void *cmd,
 
 	diff.cpp = stdu->cpp;
 
-	dst_bo = &stdu->display_srf->res.guest_memory_bo->tbo;
+	dst_bo = stdu->display_srf->res.guest_memory_bo;
 	dst_pitch = stdu->display_srf->metadata.base_size.width * stdu->cpp;
 	dst_offset = bb->y1 * dst_pitch + bb->x1 * stdu->cpp;
 
-	src_bo = &vfbbo->buffer->tbo;
+	src_bo = vfbbo->buffer;
 	src_pitch = update->vfb->base.pitches[0];
 	src_offset = bo_update->fb_top * src_pitch + bo_update->fb_left *
 		stdu->cpp;
-- 
2.43.0


