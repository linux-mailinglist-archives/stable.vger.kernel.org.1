Return-Path: <stable+bounces-35588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2758950D4
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 12:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617331C232A3
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 10:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B3465BB7;
	Tue,  2 Apr 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXpEDWed"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADED5D749
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055017; cv=none; b=U8XkKU21ttJZrETOYeqodEylHP7AbEzKUt8ekr6inghumEC2f+bYJ9Wp9PXKPXsabLY/6HxWHq+YbjbdPzx9Q/vQIQRGKC2u6DfZo5sopPotg56z9HXsJsreLPTDxH5C3GvUlqluS0WJPAHtLMID8bXHZwpuZPTeehdLDnYVQVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055017; c=relaxed/simple;
	bh=cl/Ll5zdwKjg2SJbM46mMQgW9zJsaGI+yiH8oBrZcas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQxLVvFDP4Y0RNNyMBnPgS1onHu4yMb9raVGWfiRGbAxSvIHtMOzXfwTx8TI+pxwnj9rujtkBbaQ3HSheIMcZgHCMxFO/JzVdbj5N4mu4zYNJpIvaRGHPtOjU1Kazu8IKF5BySJU4KJNYngd8g/xG1kuiTR1aLypIghSME+CWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXpEDWed; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712055016; x=1743591016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cl/Ll5zdwKjg2SJbM46mMQgW9zJsaGI+yiH8oBrZcas=;
  b=fXpEDWedudeGUJHeWIFaFhcKQVMcwPM8hRKS8pylgtDhsntQF4ZnnDON
   SZoWxN7CJEe4foEbwOC0DXg0l7JVZchMKIVOMSp676ub1eblLGZSvR6Gk
   qg0blHhwJ58RpqqidxWX+s/Dh8+llRJAdWQsZiLmap0YKH7ZPgOosqMQK
   6qc5aBB3ZybFQgoZrvyQR0olFAUq6UN0wsoLxQO1pgYJr/v2lrpxFIURh
   H02SkwlkIe+QTRj8rIdMiGR+oHG74zn6+miTLkGTv/RpWIt25f97iUkX/
   ex8JngCHx+4wHlbB9VT6fP54F+1tp610xapWDIFinljedlQriNAVkT5h9
   A==;
X-CSE-ConnectionGUID: e0uHUxrlQpiWOCwTljFerA==
X-CSE-MsgGUID: 5ZV1vtSRSDGXOUWFB2zzkA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="17944446"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="17944446"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:50:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18002524"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:50:14 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	quic_jhugo@quicinc.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 6/8] accel/ivpu: Return max freq for DRM_IVPU_PARAM_CORE_CLOCK_RATE
Date: Tue,  2 Apr 2024 12:49:27 +0200
Message-ID: <20240402104929.941186-7-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240402104929.941186-1-jacek.lawrynowicz@linux.intel.com>
References: <20240402104929.941186-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DRM_IVPU_PARAM_CORE_CLOCK_RATE returned current NPU frequency which
could be 0 if device was sleeping. This value wasn't really useful to
the user space, so return max freq instead which can be used to estimate
NPU performance.

Fixes: c39dc15191c4 ("accel/ivpu: Read clock rate only if device is up")
Cc: <stable@vger.kernel.org> # v6.7
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.c     | 18 +-----------------
 drivers/accel/ivpu/ivpu_hw.h      |  6 ++++++
 drivers/accel/ivpu/ivpu_hw_37xx.c |  7 ++++---
 drivers/accel/ivpu/ivpu_hw_40xx.c |  6 ++++++
 4 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 303d92753387..77283daaedd1 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -131,22 +131,6 @@ static int ivpu_get_capabilities(struct ivpu_device *vdev, struct drm_ivpu_param
 	return 0;
 }
 
-static int ivpu_get_core_clock_rate(struct ivpu_device *vdev, u64 *clk_rate)
-{
-	int ret;
-
-	ret = ivpu_rpm_get_if_active(vdev);
-	if (ret < 0)
-		return ret;
-
-	*clk_rate = ret ? ivpu_hw_reg_pll_freq_get(vdev) : 0;
-
-	if (ret)
-		ivpu_rpm_put(vdev);
-
-	return 0;
-}
-
 static int ivpu_get_param_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 {
 	struct ivpu_file_priv *file_priv = file->driver_priv;
@@ -170,7 +154,7 @@ static int ivpu_get_param_ioctl(struct drm_device *dev, void *data, struct drm_f
 		args->value = vdev->platform;
 		break;
 	case DRM_IVPU_PARAM_CORE_CLOCK_RATE:
-		ret = ivpu_get_core_clock_rate(vdev, &args->value);
+		args->value = ivpu_hw_ratio_to_freq(vdev, vdev->hw->pll.max_ratio);
 		break;
 	case DRM_IVPU_PARAM_NUM_CONTEXTS:
 		args->value = ivpu_get_context_count(vdev);
diff --git a/drivers/accel/ivpu/ivpu_hw.h b/drivers/accel/ivpu/ivpu_hw.h
index b2909168a0a6..094c659d2800 100644
--- a/drivers/accel/ivpu/ivpu_hw.h
+++ b/drivers/accel/ivpu/ivpu_hw.h
@@ -21,6 +21,7 @@ struct ivpu_hw_ops {
 	u32 (*profiling_freq_get)(struct ivpu_device *vdev);
 	void (*profiling_freq_drive)(struct ivpu_device *vdev, bool enable);
 	u32 (*reg_pll_freq_get)(struct ivpu_device *vdev);
+	u32 (*ratio_to_freq)(struct ivpu_device *vdev, u32 ratio);
 	u32 (*reg_telemetry_offset_get)(struct ivpu_device *vdev);
 	u32 (*reg_telemetry_size_get)(struct ivpu_device *vdev);
 	u32 (*reg_telemetry_enable_get)(struct ivpu_device *vdev);
@@ -130,6 +131,11 @@ static inline u32 ivpu_hw_reg_pll_freq_get(struct ivpu_device *vdev)
 	return vdev->hw->ops->reg_pll_freq_get(vdev);
 };
 
+static inline u32 ivpu_hw_ratio_to_freq(struct ivpu_device *vdev, u32 ratio)
+{
+	return vdev->hw->ops->ratio_to_freq(vdev, ratio);
+}
+
 static inline u32 ivpu_hw_reg_telemetry_offset_get(struct ivpu_device *vdev)
 {
 	return vdev->hw->ops->reg_telemetry_offset_get(vdev);
diff --git a/drivers/accel/ivpu/ivpu_hw_37xx.c b/drivers/accel/ivpu/ivpu_hw_37xx.c
index 5e2865f9f7d6..bd25e2d9fb0f 100644
--- a/drivers/accel/ivpu/ivpu_hw_37xx.c
+++ b/drivers/accel/ivpu/ivpu_hw_37xx.c
@@ -803,12 +803,12 @@ static void ivpu_hw_37xx_profiling_freq_drive(struct ivpu_device *vdev, bool ena
 	/* Profiling freq - is a debug feature. Unavailable on VPU 37XX. */
 }
 
-static u32 ivpu_hw_37xx_pll_to_freq(u32 ratio, u32 config)
+static u32 ivpu_hw_37xx_ratio_to_freq(struct ivpu_device *vdev, u32 ratio)
 {
 	u32 pll_clock = PLL_REF_CLK_FREQ * ratio;
 	u32 cpu_clock;
 
-	if ((config & 0xff) == PLL_RATIO_4_3)
+	if ((vdev->hw->config & 0xff) == PLL_RATIO_4_3)
 		cpu_clock = pll_clock * 2 / 4;
 	else
 		cpu_clock = pll_clock * 2 / 5;
@@ -827,7 +827,7 @@ static u32 ivpu_hw_37xx_reg_pll_freq_get(struct ivpu_device *vdev)
 	if (!ivpu_is_silicon(vdev))
 		return PLL_SIMULATION_FREQ;
 
-	return ivpu_hw_37xx_pll_to_freq(pll_curr_ratio, vdev->hw->config);
+	return ivpu_hw_37xx_ratio_to_freq(vdev, pll_curr_ratio);
 }
 
 static u32 ivpu_hw_37xx_reg_telemetry_offset_get(struct ivpu_device *vdev)
@@ -1050,6 +1050,7 @@ const struct ivpu_hw_ops ivpu_hw_37xx_ops = {
 	.profiling_freq_get = ivpu_hw_37xx_profiling_freq_get,
 	.profiling_freq_drive = ivpu_hw_37xx_profiling_freq_drive,
 	.reg_pll_freq_get = ivpu_hw_37xx_reg_pll_freq_get,
+	.ratio_to_freq = ivpu_hw_37xx_ratio_to_freq,
 	.reg_telemetry_offset_get = ivpu_hw_37xx_reg_telemetry_offset_get,
 	.reg_telemetry_size_get = ivpu_hw_37xx_reg_telemetry_size_get,
 	.reg_telemetry_enable_get = ivpu_hw_37xx_reg_telemetry_enable_get,
diff --git a/drivers/accel/ivpu/ivpu_hw_40xx.c b/drivers/accel/ivpu/ivpu_hw_40xx.c
index e4eddbf5d11c..b0b88d4c8926 100644
--- a/drivers/accel/ivpu/ivpu_hw_40xx.c
+++ b/drivers/accel/ivpu/ivpu_hw_40xx.c
@@ -980,6 +980,11 @@ static u32 ivpu_hw_40xx_reg_pll_freq_get(struct ivpu_device *vdev)
 	return PLL_RATIO_TO_FREQ(pll_curr_ratio);
 }
 
+static u32 ivpu_hw_40xx_ratio_to_freq(struct ivpu_device *vdev, u32 ratio)
+{
+	return PLL_RATIO_TO_FREQ(ratio);
+}
+
 static u32 ivpu_hw_40xx_reg_telemetry_offset_get(struct ivpu_device *vdev)
 {
 	return REGB_RD32(VPU_40XX_BUTTRESS_VPU_TELEMETRY_OFFSET);
@@ -1230,6 +1235,7 @@ const struct ivpu_hw_ops ivpu_hw_40xx_ops = {
 	.profiling_freq_get = ivpu_hw_40xx_profiling_freq_get,
 	.profiling_freq_drive = ivpu_hw_40xx_profiling_freq_drive,
 	.reg_pll_freq_get = ivpu_hw_40xx_reg_pll_freq_get,
+	.ratio_to_freq = ivpu_hw_40xx_ratio_to_freq,
 	.reg_telemetry_offset_get = ivpu_hw_40xx_reg_telemetry_offset_get,
 	.reg_telemetry_size_get = ivpu_hw_40xx_reg_telemetry_size_get,
 	.reg_telemetry_enable_get = ivpu_hw_40xx_reg_telemetry_enable_get,
-- 
2.43.2


