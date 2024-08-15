Return-Path: <stable+bounces-69222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0723195375F
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 17:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ACE41C25300
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797381AD402;
	Thu, 15 Aug 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DrMmFI0a"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BEA1AD3F7
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736067; cv=none; b=q8qD6kPvKpKQd6W1uMfXBFoNr9B3jz8cUdPOzfYShMcsPjtVIAl7lfzAGVl+RwuNlSQ4GlhHPsHVb6R1RXChTSjlYpmTRm5fYMM4rxH8SgoJkz1Azp5qOsSljv2YKH5v4YKRmpLW8qKEEgN3UTXL+1WCFruRO76uwEg81b0WcaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736067; c=relaxed/simple;
	bh=0MROcCt+nQSrxdz0OvgnZx5v4RGLu8OHee6YyDvosBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akwgvWU2doQ0u3HTV4Jv5XvxixWoRuZGklYGe/oPu9DLw5CSbkpZ4MBpkFgZQsqnfKgduIs58XisYbVXcV5reowZ3NmxoZqRLXMeQ0H2IXDDLhu8gOqVjTvgG8DX5+v3z21GxxaN0BWDVx4LcZWMYanJk7Iz6x0HWaYY3AndwBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DrMmFI0a; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1df0a9281so67241885a.1
        for <stable@vger.kernel.org>; Thu, 15 Aug 2024 08:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723736064; x=1724340864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK3JbzctTHfwicXPcY7hery4h5ZjZSeNvYcllvsZxtM=;
        b=DrMmFI0aBBofb2RiheEq1NrQkEnOrbrG/SJblb7gYt401v58WcS2ZEnGkKUEjfyFy1
         obrVGcqDGikiXrIJdBPrgtwoL9UKNlNPNbNfCQvemhmjcM1ilbVliH0ObsIvGQy+/4MO
         tNoERr6LFosT32zMjdcr5YnZs4c1zqONrTPo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723736064; x=1724340864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oK3JbzctTHfwicXPcY7hery4h5ZjZSeNvYcllvsZxtM=;
        b=LKCclBtA31VM0XasBrUefvY1Xsxibd/3WU1QPZIywdvyk9s84LuF66TUthVhwCluzJ
         grDpFl3Z7cGP4+1APvgQZJ6QO/zL7r5rjPcegcYmLDIEW9g0wM5fJkdFJ5dU/kz3IXZr
         bbQAQpaKqaC6lad9YGrefIkqjNDv8ueVhE4Sj8ufsOIH7TLw28SbS++zoGZEzzcvwHFi
         +GosD/98zXmglO3jLTDNM0Vfx0CE4P2/6+QqbmHExLiBacRo23XC8hUZlbaIN1o8rl81
         zwPzXrZgVzDe5oJGa6DmN/faJH3JYx7N6Q0uZH7DX6mUe2F+iCWclH8I87SWT4Ohdlt1
         ZO1g==
X-Forwarded-Encrypted: i=1; AJvYcCWQDrQ5xlRiDWpiqITZxQxgXvahJJAjFrHGMiWojqlBVuHp0Z0ChQ1MY6RpkzpXenev8Jlc0cYDCCB0GVIb/v+Eg6OQbQy/
X-Gm-Message-State: AOJu0YwB78N4emSoALG83Rbb0tYjX5iU+FVK8o/rBP/GN6kBMgAQTZoo
	Z+UWpV/jDW4HfrvmflmMFS5RT47a92XErNmdJB/SsFT075Obapn2Gi1+KpgTzw==
X-Google-Smtp-Source: AGHT+IGgCdKzPdlrYPScVLRqYIfHAJWGQrevVdXllayGM1UtNeoJIDtu10x1+O85iKpyQe9U512YIg==
X-Received: by 2002:a05:620a:d96:b0:79f:b89:455e with SMTP id af79cd13be357-7a50693b684mr281485a.20.1723736064067;
        Thu, 15 Aug 2024 08:34:24 -0700 (PDT)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff02505dsm72986685a.13.2024.08.15.08.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 08:34:23 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] drm/vmwgfx: Fix prime with external buffers
Date: Thu, 15 Aug 2024 11:31:43 -0400
Message-ID: <20240815153404.630214-2-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815153404.630214-1-zack.rusin@broadcom.com>
References: <20240815153404.630214-1-zack.rusin@broadcom.com>
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

v2: Fix the diff rectangle computation

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: b32233acceff ("drm/vmwgfx: Fix prime import/export")
Cc: <stable@vger.kernel.org> # v6.6+
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.9+
---
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c | 112 ++++++++++++++++++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h  |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |  12 +--
 3 files changed, 116 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
index 717d624e9a05..4049447d211c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
@@ -27,6 +27,8 @@
  **************************************************************************/
 
 #include "vmwgfx_drv.h"
+
+#include "vmwgfx_bo.h"
 #include <linux/highmem.h>
 
 /*
@@ -420,13 +422,103 @@ static int vmw_bo_cpu_blit_line(struct vmw_bo_blit_line_data *d,
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
+	diff->rect.x1 = (dst_offset % dst_stride) / diff->cpp;
+	diff->rect.y1 = floor(dst_offset / dst_stride);
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
@@ -444,13 +536,15 @@ static int vmw_bo_cpu_blit_line(struct vmw_bo_blit_line_data *d,
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
@@ -460,6 +554,11 @@ int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
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
@@ -479,6 +578,11 @@ int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
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


