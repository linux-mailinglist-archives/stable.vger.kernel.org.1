Return-Path: <stable+bounces-117170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76DAA3B531
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F4017C03E
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15981DE8A6;
	Wed, 19 Feb 2025 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wQIZeHEh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F61BE23E;
	Wed, 19 Feb 2025 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954421; cv=none; b=pgq6VAhGXf3l6KTLTCX4a1Hk6PHDl8yhJHogd4kceAV/D2jeMgAM6fMhXse6xbkC1AJg9vmc1pLofLwQiDaZMXhGplve1HpwFHXGNRKZYRbLvlnEUKByYVpQXhlLAqvLBHj1oCMA56zcwoDTXKlyzQ/kJSZ416O+c46QeXslhVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954421; c=relaxed/simple;
	bh=iKCjXJhKArnWRi/kF3Es/NGuCimWvLXQEmrub/9e08E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0viElB8AZ6+0WFNCj656eVfAxQtB463wlNYg2LcKfy0L78XLqJ1JI2KKq5MSO/fTZ+WYOS7vqjNgPlwSwIreVoKoyaqtmdHzFKXBBK7SAwM8mp2FA9OOva8TTwx2lf6An8eIKgbM5EgHcTwu9ev60PBeGZTTQRvGrdmG9Z1lqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wQIZeHEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C93C4CEE6;
	Wed, 19 Feb 2025 08:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739954421;
	bh=iKCjXJhKArnWRi/kF3Es/NGuCimWvLXQEmrub/9e08E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wQIZeHEhekCrLc9bdBJ4fnMRKG7FTiBmQt11meKJ2J4umWN5ORi3VepuJp7ef1lXo
	 gw3TrTIXJ9a1Nd3JezrXGDf0cV+faEcyhe1+dWaEhBEviZJpCrRpSRlCpgXBh/6p/S
	 fg1kLydxpey66j+7T28hLxoyXekVAWGi8M6xHD/Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 199/274] drm/xe/oa/uapi: Make OA buffer size configurable
Date: Wed, 19 Feb 2025 09:27:33 +0100
Message-ID: <20250219082617.370608249@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082609.533585153@linuxfoundation.org>
References: <20250219082609.533585153@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>

[ Upstream commit 720f63a838731d25ab34c306db59c12834ce09b4 ]

Add a new property called DRM_XE_OA_PROPERTY_OA_BUFFER_SIZE to
allow OA buffer size to be configurable from userspace.

With this OA buffer size can be configured to any power of 2
size between 128KB and 128MB and it would default to 16MB in case
the size is not supplied.

v2:
  - Rebase
v3:
  - Add oa buffer size to capabilities [Ashutosh]
  - Address several nitpicks [Ashutosh]
  - Fix commit message/subject [Ashutosh]

BSpec: 61100, 61228
Signed-off-by: Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>
Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241205041913.883767-2-sai.teja.pottumuttu@intel.com
Stable-dep-of: 990d35edc5d3 ("drm/xe/oa: Set stream->pollin in xe_oa_buffer_check_unlocked")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/regs/xe_oa_regs.h |  9 +----
 drivers/gpu/drm/xe/xe_oa.c           | 55 ++++++++++++++++++++++------
 drivers/gpu/drm/xe/xe_oa_types.h     |  2 +-
 drivers/gpu/drm/xe/xe_query.c        |  3 +-
 include/uapi/drm/xe_drm.h            |  9 +++++
 5 files changed, 56 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/xe/regs/xe_oa_regs.h b/drivers/gpu/drm/xe/regs/xe_oa_regs.h
index 6d31573ed1765..a79ad2da070c2 100644
--- a/drivers/gpu/drm/xe/regs/xe_oa_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_oa_regs.h
@@ -41,14 +41,6 @@
 
 #define OAG_OABUFFER		XE_REG(0xdb08)
 #define  OABUFFER_SIZE_MASK	REG_GENMASK(5, 3)
-#define  OABUFFER_SIZE_128K	REG_FIELD_PREP(OABUFFER_SIZE_MASK, 0)
-#define  OABUFFER_SIZE_256K	REG_FIELD_PREP(OABUFFER_SIZE_MASK, 1)
-#define  OABUFFER_SIZE_512K	REG_FIELD_PREP(OABUFFER_SIZE_MASK, 2)
-#define  OABUFFER_SIZE_1M	REG_FIELD_PREP(OABUFFER_SIZE_MASK, 3)
-#define  OABUFFER_SIZE_2M	REG_FIELD_PREP(OABUFFER_SIZE_MASK, 4)
-#define  OABUFFER_SIZE_4M	REG_FIELD_PREP(OABUFFER_SIZE_MASK, 5)
-#define  OABUFFER_SIZE_8M	REG_FIELD_PREP(OABUFFER_SIZE_MASK, 6)
-#define  OABUFFER_SIZE_16M	REG_FIELD_PREP(OABUFFER_SIZE_MASK, 7)
 #define  OAG_OABUFFER_MEMORY_SELECT		REG_BIT(0) /* 0: PPGTT, 1: GGTT */
 
 #define OAG_OACONTROL				XE_REG(0xdaf4)
@@ -67,6 +59,7 @@
 #define OAG_OA_DEBUG XE_REG(0xdaf8, XE_REG_OPTION_MASKED)
 #define  OAG_OA_DEBUG_DISABLE_MMIO_TRG			REG_BIT(14)
 #define  OAG_OA_DEBUG_START_TRIGGER_SCOPE_CONTROL	REG_BIT(13)
+#define  OAG_OA_DEBUG_BUF_SIZE_SELECT			REG_BIT(12)
 #define  OAG_OA_DEBUG_DISABLE_START_TRG_2_COUNT_QUAL	REG_BIT(8)
 #define  OAG_OA_DEBUG_DISABLE_START_TRG_1_COUNT_QUAL	REG_BIT(7)
 #define  OAG_OA_DEBUG_INCLUDE_CLK_RATIO			REG_BIT(6)
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index d8af82dcdce4b..dd9d2d374b2d4 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -90,6 +90,7 @@ struct xe_oa_open_param {
 	struct drm_xe_sync __user *syncs_user;
 	int num_syncs;
 	struct xe_sync_entry *syncs;
+	size_t oa_buffer_size;
 };
 
 struct xe_oa_config_bo {
@@ -397,11 +398,19 @@ static int xe_oa_append_reports(struct xe_oa_stream *stream, char __user *buf,
 
 static void xe_oa_init_oa_buffer(struct xe_oa_stream *stream)
 {
-	struct xe_mmio *mmio = &stream->gt->mmio;
 	u32 gtt_offset = xe_bo_ggtt_addr(stream->oa_buffer.bo);
-	u32 oa_buf = gtt_offset | OABUFFER_SIZE_16M | OAG_OABUFFER_MEMORY_SELECT;
+	int size_exponent = __ffs(stream->oa_buffer.bo->size);
+	u32 oa_buf = gtt_offset | OAG_OABUFFER_MEMORY_SELECT;
+	struct xe_mmio *mmio = &stream->gt->mmio;
 	unsigned long flags;
 
+	/*
+	 * If oa buffer size is more than 16MB (exponent greater than 24), the
+	 * oa buffer size field is multiplied by 8 in xe_oa_enable_metric_set.
+	 */
+	oa_buf |= REG_FIELD_PREP(OABUFFER_SIZE_MASK,
+		size_exponent > 24 ? size_exponent - 20 : size_exponent - 17);
+
 	spin_lock_irqsave(&stream->oa_buffer.ptr_lock, flags);
 
 	xe_mmio_write32(mmio, __oa_regs(stream)->oa_status, 0);
@@ -863,15 +872,12 @@ static void xe_oa_stream_destroy(struct xe_oa_stream *stream)
 	xe_file_put(stream->xef);
 }
 
-static int xe_oa_alloc_oa_buffer(struct xe_oa_stream *stream)
+static int xe_oa_alloc_oa_buffer(struct xe_oa_stream *stream, size_t size)
 {
 	struct xe_bo *bo;
 
-	BUILD_BUG_ON_NOT_POWER_OF_2(XE_OA_BUFFER_SIZE);
-	BUILD_BUG_ON(XE_OA_BUFFER_SIZE < SZ_128K || XE_OA_BUFFER_SIZE > SZ_16M);
-
 	bo = xe_bo_create_pin_map(stream->oa->xe, stream->gt->tile, NULL,
-				  XE_OA_BUFFER_SIZE, ttm_bo_type_kernel,
+				  size, ttm_bo_type_kernel,
 				  XE_BO_FLAG_SYSTEM | XE_BO_FLAG_GGTT);
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
@@ -1049,6 +1055,13 @@ static u32 oag_report_ctx_switches(const struct xe_oa_stream *stream)
 			     0 : OAG_OA_DEBUG_DISABLE_CTX_SWITCH_REPORTS);
 }
 
+static u32 oag_buf_size_select(const struct xe_oa_stream *stream)
+{
+	return _MASKED_FIELD(OAG_OA_DEBUG_BUF_SIZE_SELECT,
+			     stream->oa_buffer.bo->size > SZ_16M ?
+			     OAG_OA_DEBUG_BUF_SIZE_SELECT : 0);
+}
+
 static int xe_oa_enable_metric_set(struct xe_oa_stream *stream)
 {
 	struct xe_mmio *mmio = &stream->gt->mmio;
@@ -1081,6 +1094,7 @@ static int xe_oa_enable_metric_set(struct xe_oa_stream *stream)
 	xe_mmio_write32(mmio, __oa_regs(stream)->oa_debug,
 			_MASKED_BIT_ENABLE(oa_debug) |
 			oag_report_ctx_switches(stream) |
+			oag_buf_size_select(stream) |
 			oag_configure_mmio_trigger(stream, true));
 
 	xe_mmio_write32(mmio, __oa_regs(stream)->oa_ctx_ctrl, stream->periodic ?
@@ -1222,6 +1236,17 @@ static int xe_oa_set_prop_syncs_user(struct xe_oa *oa, u64 value,
 	return 0;
 }
 
+static int xe_oa_set_prop_oa_buffer_size(struct xe_oa *oa, u64 value,
+					 struct xe_oa_open_param *param)
+{
+	if (!is_power_of_2(value) || value < SZ_128K || value > SZ_128M) {
+		drm_dbg(&oa->xe->drm, "OA buffer size invalid %llu\n", value);
+		return -EINVAL;
+	}
+	param->oa_buffer_size = value;
+	return 0;
+}
+
 static int xe_oa_set_prop_ret_inval(struct xe_oa *oa, u64 value,
 				    struct xe_oa_open_param *param)
 {
@@ -1242,6 +1267,7 @@ static const xe_oa_set_property_fn xe_oa_set_property_funcs_open[] = {
 	[DRM_XE_OA_PROPERTY_NO_PREEMPT] = xe_oa_set_no_preempt,
 	[DRM_XE_OA_PROPERTY_NUM_SYNCS] = xe_oa_set_prop_num_syncs,
 	[DRM_XE_OA_PROPERTY_SYNCS] = xe_oa_set_prop_syncs_user,
+	[DRM_XE_OA_PROPERTY_OA_BUFFER_SIZE] = xe_oa_set_prop_oa_buffer_size,
 };
 
 static const xe_oa_set_property_fn xe_oa_set_property_funcs_config[] = {
@@ -1256,6 +1282,7 @@ static const xe_oa_set_property_fn xe_oa_set_property_funcs_config[] = {
 	[DRM_XE_OA_PROPERTY_NO_PREEMPT] = xe_oa_set_prop_ret_inval,
 	[DRM_XE_OA_PROPERTY_NUM_SYNCS] = xe_oa_set_prop_num_syncs,
 	[DRM_XE_OA_PROPERTY_SYNCS] = xe_oa_set_prop_syncs_user,
+	[DRM_XE_OA_PROPERTY_OA_BUFFER_SIZE] = xe_oa_set_prop_ret_inval,
 };
 
 static int xe_oa_user_ext_set_property(struct xe_oa *oa, enum xe_oa_user_extn_from from,
@@ -1515,7 +1542,7 @@ static long xe_oa_status_locked(struct xe_oa_stream *stream, unsigned long arg)
 
 static long xe_oa_info_locked(struct xe_oa_stream *stream, unsigned long arg)
 {
-	struct drm_xe_oa_stream_info info = { .oa_buf_size = XE_OA_BUFFER_SIZE, };
+	struct drm_xe_oa_stream_info info = { .oa_buf_size = stream->oa_buffer.bo->size, };
 	void __user *uaddr = (void __user *)arg;
 
 	if (copy_to_user(uaddr, &info, sizeof(info)))
@@ -1601,7 +1628,7 @@ static int xe_oa_mmap(struct file *file, struct vm_area_struct *vma)
 	}
 
 	/* Can mmap the entire OA buffer or nothing (no partial OA buffer mmaps) */
-	if (vma->vm_end - vma->vm_start != XE_OA_BUFFER_SIZE) {
+	if (vma->vm_end - vma->vm_start != stream->oa_buffer.bo->size) {
 		drm_dbg(&stream->oa->xe->drm, "Wrong mmap size, must be OA buffer size\n");
 		return -EINVAL;
 	}
@@ -1745,9 +1772,10 @@ static int xe_oa_stream_init(struct xe_oa_stream *stream,
 	if (GRAPHICS_VER(stream->oa->xe) >= 20 &&
 	    stream->hwe->oa_unit->type == DRM_XE_OA_UNIT_TYPE_OAG && stream->sample)
 		stream->oa_buffer.circ_size =
-			XE_OA_BUFFER_SIZE - XE_OA_BUFFER_SIZE % stream->oa_buffer.format->size;
+			param->oa_buffer_size -
+			param->oa_buffer_size % stream->oa_buffer.format->size;
 	else
-		stream->oa_buffer.circ_size = XE_OA_BUFFER_SIZE;
+		stream->oa_buffer.circ_size = param->oa_buffer_size;
 
 	if (stream->exec_q && engine_supports_mi_query(stream->hwe)) {
 		/* If we don't find the context offset, just return error */
@@ -1790,7 +1818,7 @@ static int xe_oa_stream_init(struct xe_oa_stream *stream,
 		goto err_fw_put;
 	}
 
-	ret = xe_oa_alloc_oa_buffer(stream);
+	ret = xe_oa_alloc_oa_buffer(stream, param->oa_buffer_size);
 	if (ret)
 		goto err_fw_put;
 
@@ -2087,6 +2115,9 @@ int xe_oa_stream_open_ioctl(struct drm_device *dev, u64 data, struct drm_file *f
 		drm_dbg(&oa->xe->drm, "Using periodic sampling freq %lld Hz\n", oa_freq_hz);
 	}
 
+	if (!param.oa_buffer_size)
+		param.oa_buffer_size = DEFAULT_XE_OA_BUFFER_SIZE;
+
 	ret = xe_oa_parse_syncs(oa, &param);
 	if (ret)
 		goto err_exec_q;
diff --git a/drivers/gpu/drm/xe/xe_oa_types.h b/drivers/gpu/drm/xe/xe_oa_types.h
index fea9d981e414f..df77939156288 100644
--- a/drivers/gpu/drm/xe/xe_oa_types.h
+++ b/drivers/gpu/drm/xe/xe_oa_types.h
@@ -15,7 +15,7 @@
 #include "regs/xe_reg_defs.h"
 #include "xe_hw_engine_types.h"
 
-#define XE_OA_BUFFER_SIZE SZ_16M
+#define DEFAULT_XE_OA_BUFFER_SIZE SZ_16M
 
 enum xe_oa_report_header {
 	HDR_32_BIT = 0,
diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
index 170ae72d1a7bb..1cda6cbd9b795 100644
--- a/drivers/gpu/drm/xe/xe_query.c
+++ b/drivers/gpu/drm/xe/xe_query.c
@@ -670,7 +670,8 @@ static int query_oa_units(struct xe_device *xe,
 			du->oa_unit_id = u->oa_unit_id;
 			du->oa_unit_type = u->type;
 			du->oa_timestamp_freq = xe_oa_timestamp_frequency(gt);
-			du->capabilities = DRM_XE_OA_CAPS_BASE | DRM_XE_OA_CAPS_SYNCS;
+			du->capabilities = DRM_XE_OA_CAPS_BASE | DRM_XE_OA_CAPS_SYNCS |
+					   DRM_XE_OA_CAPS_OA_BUFFER_SIZE;
 
 			j = 0;
 			for_each_hw_engine(hwe, gt, hwe_id) {
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 4a8a4a63e99ca..0383b52cbd869 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -1486,6 +1486,7 @@ struct drm_xe_oa_unit {
 	__u64 capabilities;
 #define DRM_XE_OA_CAPS_BASE		(1 << 0)
 #define DRM_XE_OA_CAPS_SYNCS		(1 << 1)
+#define DRM_XE_OA_CAPS_OA_BUFFER_SIZE	(1 << 2)
 
 	/** @oa_timestamp_freq: OA timestamp freq */
 	__u64 oa_timestamp_freq;
@@ -1651,6 +1652,14 @@ enum drm_xe_oa_property_id {
 	 * to the VM bind case.
 	 */
 	DRM_XE_OA_PROPERTY_SYNCS,
+
+	/**
+	 * @DRM_XE_OA_PROPERTY_OA_BUFFER_SIZE: Size of OA buffer to be
+	 * allocated by the driver in bytes. Supported sizes are powers of
+	 * 2 from 128 KiB to 128 MiB. When not specified, a 16 MiB OA
+	 * buffer is allocated by default.
+	 */
+	DRM_XE_OA_PROPERTY_OA_BUFFER_SIZE,
 };
 
 /**
-- 
2.39.5




