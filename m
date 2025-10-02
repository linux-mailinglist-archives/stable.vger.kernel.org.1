Return-Path: <stable+bounces-183052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF6ABB40B0
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5A219C5B2D
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573563126C1;
	Thu,  2 Oct 2025 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LK4WPsBg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC66431328B;
	Thu,  2 Oct 2025 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411840; cv=none; b=MD4XqxQ1cMOGWCBzBYyxBZz5DLSzPZuWz1ax/7iMjaTLF9wFsi4i9HEAlXrlblfrdgyKdUBE5gr+pe4FnFM/vy9OttGZyBKbW0ekpqySH/YnWC7mLDEogP1ZcYzY1lbWbFe8oXLRXBGpCMZyDd4qcOa6/oykGE2me0LIg4Nmet8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411840; c=relaxed/simple;
	bh=fGFxi/ZM37fVZxNizEzJZWs3xmMB+2drWx/pcHOJUS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FylO0ve9ycXQ6JUwiNw1j17Ptlv8k5iO37khdrUs3QnMlMN47kAX+sjPwE2bs/edHC3YYpnJTE8wC3V2lioN5+ipA7tSYwwqH42xybbiYUuH+sCGilXkFqaquAI/iUNwe3O19iDpheoITW8Au70LDKY4jP6jiHSy9zr+ARhptmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LK4WPsBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38CAC4CEFB;
	Thu,  2 Oct 2025 13:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759411839;
	bh=fGFxi/ZM37fVZxNizEzJZWs3xmMB+2drWx/pcHOJUS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LK4WPsBgeq3Wl/poKqZ31AaFKi+v1JhH7TebMwzejEU9H3LKz2Ymftiie3hD7WZjq
	 8vgc2gcJpbpCG6rwg0NnBuMbKIRlXwZwfsB/bVrfuwNUFbY/bLhRWsK3GrFkYa4xOj
	 RjMmlHWis00wpIYRqGnnpLX8eB0DBEFztRVAeD2A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.155
Date: Thu,  2 Oct 2025 15:30:27 +0200
Message-ID: <2025100227-opt-senate-b504@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025100226-custody-custody-a8f7@gregkh>
References: <2025100226-custody-custody-a8f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 380b99998dd8..2eea95cd7e2d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 154
+SUBLEVEL = 155
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
index c3c34fe714b0..064ad508c149 100644
--- a/arch/arm/mm/pageattr.c
+++ b/arch/arm/mm/pageattr.c
@@ -25,7 +25,7 @@ static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
 	return 0;
 }
 
-static bool in_range(unsigned long start, unsigned long size,
+static bool range_in_range(unsigned long start, unsigned long size,
 	unsigned long range_start, unsigned long range_end)
 {
 	return start >= range_start && start < range_end &&
@@ -63,8 +63,8 @@ static int change_memory_common(unsigned long addr, int numpages,
 	if (!size)
 		return 0;
 
-	if (!in_range(start, size, MODULES_VADDR, MODULES_END) &&
-	    !in_range(start, size, VMALLOC_START, VMALLOC_END))
+	if (!range_in_range(start, size, MODULES_VADDR, MODULES_END) &&
+	    !range_in_range(start, size, VMALLOC_START, VMALLOC_END))
 		return -EINVAL;
 
 	return __change_memory_common(start, size, set_mask, clear_mask);
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 86af7115ac60..e05a1029975a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -227,7 +227,7 @@ thermal-zones {
 		cpu-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <2000>;
-			thermal-sensors = <&tmu 0>;
+			thermal-sensors = <&tmu 1>;
 			trips {
 				cpu_alert0: trip0 {
 					temperature = <85000>;
@@ -257,7 +257,7 @@ map0 {
 		soc-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <2000>;
-			thermal-sensors = <&tmu 1>;
+			thermal-sensors = <&tmu 0>;
 			trips {
 				soc_alert0: trip0 {
 					temperature = <85000>;
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 28fa80fd69fa..c74b047eda19 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -552,15 +552,13 @@ static int cpumf_pmu_event_type(struct perf_event *event)
 static int cpumf_pmu_event_init(struct perf_event *event)
 {
 	unsigned int type = event->attr.type;
-	int err;
+	int err = -ENOENT;
 
 	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_RAW)
 		err = __hw_perf_event_init(event, type);
 	else if (event->pmu->type == type)
 		/* Registered as unknown PMU */
 		err = __hw_perf_event_init(event, cpumf_pmu_event_type(event));
-	else
-		return -ENOENT;
 
 	if (unlikely(err) && event->destroy)
 		event->destroy(event);
diff --git a/arch/um/drivers/mconsole_user.c b/arch/um/drivers/mconsole_user.c
index e24298a734be..a04cd13c6315 100644
--- a/arch/um/drivers/mconsole_user.c
+++ b/arch/um/drivers/mconsole_user.c
@@ -71,7 +71,9 @@ static struct mconsole_command *mconsole_parse(struct mc_request *req)
 	return NULL;
 }
 
+#ifndef MIN
 #define MIN(a,b) ((a)<(b) ? (a):(b))
+#endif
 
 #define STRINGX(x) #x
 #define STRING(x) STRINGX(x)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 77ee0012f849..a84d3d82824a 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -107,7 +107,7 @@ static inline void pgd_list_del(pgd_t *pgd)
 #define UNSHARED_PTRS_PER_PGD				\
 	(SHARED_KERNEL_PMD ? KERNEL_PGD_BOUNDARY : PTRS_PER_PGD)
 #define MAX_UNSHARED_PTRS_PER_PGD			\
-	max_t(size_t, KERNEL_PGD_BOUNDARY, PTRS_PER_PGD)
+	MAX_T(size_t, KERNEL_PGD_BOUNDARY, PTRS_PER_PGD)
 
 
 static void pgd_set_mm(pgd_t *pgd, struct mm_struct *mm)
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 90bdccab1dff..de67d9c6c9c6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2894,6 +2894,15 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 			goto err_null_driver;
 	}
 
+	/*
+	 * Mark support for the scheduler's frequency invariance engine for
+	 * drivers that implement target(), target_index() or fast_switch().
+	 */
+	if (!cpufreq_driver->setpolicy) {
+		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
+		pr_debug("cpufreq: supports frequency invariance\n");
+	}
+
 	ret = subsys_interface_register(&cpufreq_interface);
 	if (ret)
 		goto err_boost_unreg;
@@ -2915,21 +2924,14 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	hp_online = ret;
 	ret = 0;
 
-	/*
-	 * Mark support for the scheduler's frequency invariance engine for
-	 * drivers that implement target(), target_index() or fast_switch().
-	 */
-	if (!cpufreq_driver->setpolicy) {
-		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
-		pr_debug("supports frequency invariance");
-	}
-
 	pr_debug("driver %s up and running\n", driver_data->name);
 	goto out;
 
 err_if_unreg:
 	subsys_interface_unregister(&cpufreq_interface);
 err_boost_unreg:
+	if (!cpufreq_driver->setpolicy)
+		static_branch_disable_cpuslocked(&cpufreq_freq_invariance);
 	remove_boost_sysfs_file();
 err_null_driver:
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 8e39370fdb5c..f0de7b18a53f 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -109,8 +109,8 @@ static const u32 knl_interleave_list[] = {
 	0x104, 0x10c, 0x114, 0x11c,   /* 20-23 */
 };
 #define MAX_INTERLEAVE							\
-	(max_t(unsigned int, ARRAY_SIZE(sbridge_interleave_list),	\
-	       max_t(unsigned int, ARRAY_SIZE(ibridge_interleave_list),	\
+	(MAX_T(unsigned int, ARRAY_SIZE(sbridge_interleave_list),	\
+	       MAX_T(unsigned int, ARRAY_SIZE(ibridge_interleave_list),	\
 		     ARRAY_SIZE(knl_interleave_list))))
 
 struct interleave_pkg {
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index c0c174c101d2..c5e273bc2292 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -45,7 +45,6 @@
 #define I10NM_NUM_CHANNELS	MAX(I10NM_NUM_DDR_CHANNELS, I10NM_NUM_HBM_CHANNELS)
 #define I10NM_NUM_DIMMS		MAX(I10NM_NUM_DDR_DIMMS, I10NM_NUM_HBM_DIMMS)
 
-#define MAX(a, b)	((a) > (b) ? (a) : (b))
 #define NUM_IMC		MAX(SKX_NUM_IMC, I10NM_NUM_IMC)
 #define NUM_CHANNELS	MAX(SKX_NUM_CHANNELS, I10NM_NUM_CHANNELS)
 #define NUM_DIMMS	MAX(SKX_NUM_DIMMS, I10NM_NUM_DIMMS)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index af86402c70a9..dcb5de01a220 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1258,7 +1258,9 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 
 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
 
+#ifndef MIN
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#endif
 
 /* Common functions */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index 1b2df97226a3..40286e8dd4e1 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -25,7 +25,9 @@
 
 #include "hdcp.h"
 
+#ifndef MIN
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
+#endif
 #define HDCP_I2C_ADDR 0x3a	/* 0x74 >> 1*/
 #define KSV_READ_SIZE 0xf	/* 0x6803b - 0x6802c */
 #define HDCP_MAX_AUX_TRANSACTION_SIZE 16
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
index dac29fe6cfc6..abbdb7731996 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
@@ -22,12 +22,18 @@
  */
 #include <asm/div64.h>
 
-#define SHIFT_AMOUNT 16 /* We multiply all original integers with 2^SHIFT_AMOUNT to get the fInt representation */
+enum ppevvmath_constants {
+	/* We multiply all original integers with 2^SHIFT_AMOUNT to get the fInt representation */
+	SHIFT_AMOUNT	= 16,
 
-#define PRECISION 5 /* Change this value to change the number of decimal places in the final output - 5 is a good default */
+	/* Change this value to change the number of decimal places in the final output - 5 is a good default */
+	PRECISION	=  5,
 
-#define SHIFTED_2 (2 << SHIFT_AMOUNT)
-#define MAX (1 << (SHIFT_AMOUNT - 1)) - 1 /* 32767 - Might change in the future */
+	SHIFTED_2	= (2 << SHIFT_AMOUNT),
+
+	/* 32767 - Might change in the future */
+	MAX		= (1 << (SHIFT_AMOUNT - 1)) - 1,
+};
 
 /* -------------------------------------------------------------------------------
  * NEW TYPE - fINT
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index cfd41d56e970..47371ec9963b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2081,7 +2081,9 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
 	return ret;
 }
 
+#ifndef MAX
 #define MAX(a, b)	((a) > (b) ? (a) : (b))
+#endif
 
 static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 						 uint8_t pcie_gen_cap,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index af244def4801..ae8854b90f37 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1255,7 +1255,10 @@ static int smu_v13_0_0_get_thermal_temperature_range(struct smu_context *smu,
 	return 0;
 }
 
+#ifndef MAX
 #define MAX(a, b)	((a) > (b) ? (a) : (b))
+#endif
+
 static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 					   void **table)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 2d5cfe4651b4..f5e340c2c598 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1263,7 +1263,10 @@ static int smu_v13_0_7_get_thermal_temperature_range(struct smu_context *smu,
 	return 0;
 }
 
+#ifndef MAX
 #define MAX(a, b)	((a) > (b) ? (a) : (b))
+#endif
+
 static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
 					   void **table)
 {
diff --git a/drivers/gpu/drm/arm/display/include/malidp_utils.h b/drivers/gpu/drm/arm/display/include/malidp_utils.h
index 49a1d7f3539c..9f83baac6ed8 100644
--- a/drivers/gpu/drm/arm/display/include/malidp_utils.h
+++ b/drivers/gpu/drm/arm/display/include/malidp_utils.h
@@ -35,7 +35,7 @@ static inline void set_range(struct malidp_range *rg, u32 start, u32 end)
 	rg->end   = end;
 }
 
-static inline bool in_range(struct malidp_range *rg, u32 v)
+static inline bool malidp_in_range(struct malidp_range *rg, u32 v)
 {
 	return (v >= rg->start) && (v <= rg->end);
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index e200decd00c6..f4e76b46ca32 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -305,12 +305,12 @@ komeda_layer_check_cfg(struct komeda_layer *layer,
 	if (komeda_fb_check_src_coords(kfb, src_x, src_y, src_w, src_h))
 		return -EINVAL;
 
-	if (!in_range(&layer->hsize_in, src_w)) {
+	if (!malidp_in_range(&layer->hsize_in, src_w)) {
 		DRM_DEBUG_ATOMIC("invalidate src_w %d.\n", src_w);
 		return -EINVAL;
 	}
 
-	if (!in_range(&layer->vsize_in, src_h)) {
+	if (!malidp_in_range(&layer->vsize_in, src_h)) {
 		DRM_DEBUG_ATOMIC("invalidate src_h %d.\n", src_h);
 		return -EINVAL;
 	}
@@ -452,14 +452,14 @@ komeda_scaler_check_cfg(struct komeda_scaler *scaler,
 	hsize_out = dflow->out_w;
 	vsize_out = dflow->out_h;
 
-	if (!in_range(&scaler->hsize, hsize_in) ||
-	    !in_range(&scaler->hsize, hsize_out)) {
+	if (!malidp_in_range(&scaler->hsize, hsize_in) ||
+	    !malidp_in_range(&scaler->hsize, hsize_out)) {
 		DRM_DEBUG_ATOMIC("Invalid horizontal sizes");
 		return -EINVAL;
 	}
 
-	if (!in_range(&scaler->vsize, vsize_in) ||
-	    !in_range(&scaler->vsize, vsize_out)) {
+	if (!malidp_in_range(&scaler->vsize, vsize_in) ||
+	    !malidp_in_range(&scaler->vsize, vsize_out)) {
 		DRM_DEBUG_ATOMIC("Invalid vertical sizes");
 		return -EINVAL;
 	}
@@ -574,13 +574,13 @@ komeda_splitter_validate(struct komeda_splitter *splitter,
 		return -EINVAL;
 	}
 
-	if (!in_range(&splitter->hsize, dflow->in_w)) {
+	if (!malidp_in_range(&splitter->hsize, dflow->in_w)) {
 		DRM_DEBUG_ATOMIC("split in_w:%d is out of the acceptable range.\n",
 				 dflow->in_w);
 		return -EINVAL;
 	}
 
-	if (!in_range(&splitter->vsize, dflow->in_h)) {
+	if (!malidp_in_range(&splitter->vsize, dflow->in_h)) {
 		DRM_DEBUG_ATOMIC("split in_h: %d exceeds the acceptable range.\n",
 				 dflow->in_h);
 		return -EINVAL;
@@ -624,13 +624,13 @@ komeda_merger_validate(struct komeda_merger *merger,
 		return -EINVAL;
 	}
 
-	if (!in_range(&merger->hsize_merged, output->out_w)) {
+	if (!malidp_in_range(&merger->hsize_merged, output->out_w)) {
 		DRM_DEBUG_ATOMIC("merged_w: %d is out of the accepted range.\n",
 				 output->out_w);
 		return -EINVAL;
 	}
 
-	if (!in_range(&merger->vsize_merged, output->out_h)) {
+	if (!malidp_in_range(&merger->vsize_merged, output->out_h)) {
 		DRM_DEBUG_ATOMIC("merged_h: %d is out of the accepted range.\n",
 				 output->out_h);
 		return -EINVAL;
@@ -866,8 +866,8 @@ void komeda_complete_data_flow_cfg(struct komeda_layer *layer,
 	 * input/output range.
 	 */
 	if (dflow->en_scaling && scaler)
-		dflow->en_split = !in_range(&scaler->hsize, dflow->in_w) ||
-				  !in_range(&scaler->hsize, dflow->out_w);
+		dflow->en_split = !malidp_in_range(&scaler->hsize, dflow->in_w) ||
+				  !malidp_in_range(&scaler->hsize, dflow->out_w);
 }
 
 static bool merger_is_available(struct komeda_pipeline *pipe,
diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index a4a23b9623ad..7d2fb34c72b7 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -51,7 +51,7 @@ int ast_astdp_read_edid(struct drm_device *dev, u8 *ediddata)
 			 *	  of right-click of mouse.
 			 * 2. The Delays are often longer a lot when system resume from S3/S4.
 			 */
-			mdelay(j+1);
+			msleep(j + 1);
 
 			if (!(ast_get_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xD1,
 							ASTDP_MCU_FW_EXECUTING) &&
diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index d021497841b8..3969dc548cff 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -532,7 +532,7 @@ int drm_plane_create_color_properties(struct drm_plane *plane,
 {
 	struct drm_device *dev = plane->dev;
 	struct drm_property *prop;
-	struct drm_prop_enum_list enum_list[max_t(int, DRM_COLOR_ENCODING_MAX,
+	struct drm_prop_enum_list enum_list[MAX_T(int, DRM_COLOR_ENCODING_MAX,
 						       DRM_COLOR_RANGE_MAX)];
 	int i, len;
 
diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index 95b7cb099e63..9c7d9584aac7 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -724,8 +724,8 @@ void oaktrail_hdmi_teardown(struct drm_device *dev)
 
 	if (hdmi_dev) {
 		pdev = hdmi_dev->dev;
-		pci_set_drvdata(pdev, NULL);
 		oaktrail_hdmi_i2c_exit(pdev);
+		pci_set_drvdata(pdev, NULL);
 		iounmap(hdmi_dev->regs);
 		kfree(hdmi_dev);
 		pci_dev_put(pdev);
diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index beba39a38c87..6d69e75a287c 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -39,8 +39,9 @@ static u32 scale(u32 source_val,
 {
 	u64 target_val;
 
-	WARN_ON(source_min > source_max);
-	WARN_ON(target_min > target_max);
+	if (WARN_ON(source_min >= source_max) ||
+	    WARN_ON(target_min > target_max))
+		return target_min;
 
 	/* defensive */
 	source_val = clamp(source_val, source_min, source_max);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 9156e673d360..cd1d11104607 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -680,12 +680,6 @@ struct block_header {
 	u32 data[];
 };
 
-/* this should be a general kernel helper */
-static int in_range(u32 addr, u32 start, u32 size)
-{
-	return addr >= start && addr < start + size;
-}
-
 static bool fw_block_mem(struct a6xx_gmu_bo *bo, const struct block_header *blk)
 {
 	if (!in_range(blk->addr, bo->iova, bo->size))
diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index 820c2c3641d3..1311f10fad66 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -33,8 +33,10 @@
 #include "evergreen_reg_safe.h"
 #include "cayman_reg_safe.h"
 
+#ifndef MIN
 #define MAX(a,b)                   (((a)>(b))?(a):(b))
 #define MIN(a,b)                   (((a)<(b))?(a):(b))
+#endif
 
 #define REG_SAFE_BM_SIZE ARRAY_SIZE(evergreen_reg_safe_bm)
 
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 3ac674427675..44eb31055256 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -23,23 +23,23 @@
 #include <linux/util_macros.h>
 
 /* Indexes for the sysfs hooks */
-
-#define INPUT		0
-#define MIN		1
-#define MAX		2
-#define CONTROL		3
-#define OFFSET		3
-#define AUTOMIN		4
-#define THERM		5
-#define HYSTERSIS	6
-
+enum adt_sysfs_id {
+	INPUT		= 0,
+	MIN		= 1,
+	MAX		= 2,
+	CONTROL		= 3,
+	OFFSET		= 3,	// Dup
+	AUTOMIN		= 4,
+	THERM		= 5,
+	HYSTERSIS	= 6,
 /*
  * These are unique identifiers for the sysfs functions - unlike the
  * numbers above, these are not also indexes into an array
  */
+	ALARM		= 9,
+	FAULT		= 10,
+};
 
-#define ALARM		9
-#define FAULT		10
 
 /* 7475 Common Registers */
 
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index cc126e62643a..80c26551564f 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -191,6 +191,7 @@ static u16 get_legacy_obj_type(u16 opcode)
 {
 	switch (opcode) {
 	case MLX5_CMD_OP_CREATE_RQ:
+	case MLX5_CMD_OP_CREATE_RMP:
 		return MLX5_EVENT_QUEUE_TYPE_RQ;
 	case MLX5_CMD_OP_CREATE_QP:
 		return MLX5_EVENT_QUEUE_TYPE_QP;
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index efd0732a8c10..a201019babe4 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2618,7 +2618,7 @@ static void do_journal_write(struct dm_integrity_c *ic, unsigned int write_start
 				    unlikely(from_replay) &&
 #endif
 				    ic->internal_hash) {
-					char test_tag[max_t(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
+					char test_tag[MAX_T(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 
 					integrity_sector_checksum(ic, sec + ((l - j) << ic->sb->log2_sectors_per_block),
 								  (char *)access_journal_data(ic, i, l), test_tag);
diff --git a/drivers/media/dvb-frontends/stv0367_priv.h b/drivers/media/dvb-frontends/stv0367_priv.h
index 617f605947b2..7f056d1cce82 100644
--- a/drivers/media/dvb-frontends/stv0367_priv.h
+++ b/drivers/media/dvb-frontends/stv0367_priv.h
@@ -25,8 +25,11 @@
 #endif
 
 /* MACRO definitions */
+#ifndef MIN
 #define MAX(X, Y) ((X) >= (Y) ? (X) : (Y))
 #define MIN(X, Y) ((X) <= (Y) ? (X) : (Y))
+#endif
+
 #define INRANGE(X, Y, Z) \
 	((((X) <= (Y)) && ((Y) <= (Z))) || \
 	(((Z) <= (Y)) && ((Y) <= (X))) ? 1 : 0)
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index cc43c9c5e38c..92a3f28bea87 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -862,7 +862,6 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct rcar_can_priv *priv = netdev_priv(ndev);
-	u16 ctlr;
 	int err;
 
 	if (!netif_running(ndev))
@@ -874,12 +873,7 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
 		return err;
 	}
 
-	ctlr = readw(&priv->regs->ctlr);
-	ctlr &= ~RCAR_CAN_CTLR_SLPM;
-	writew(ctlr, &priv->regs->ctlr);
-	ctlr &= ~RCAR_CAN_CTLR_CANM;
-	writew(ctlr, &priv->regs->ctlr);
-	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+	rcar_can_start(ndev);
 
 	netif_device_attach(ndev);
 	netif_start_queue(ndev);
diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index b757555ed4c4..57ea7dfe8a59 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -813,6 +813,7 @@ static const struct net_device_ops hi3110_netdev_ops = {
 	.ndo_open = hi3110_open,
 	.ndo_stop = hi3110_stop,
 	.ndo_start_xmit = hi3110_hard_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops hi3110_ethtool_ops = {
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 4bec1e7e7b3e..380f90bc7a42 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -769,6 +769,7 @@ static const struct net_device_ops sun4ican_netdev_ops = {
 	.ndo_open = sun4ican_open,
 	.ndo_stop = sun4ican_close,
 	.ndo_start_xmit = sun4ican_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops sun4ican_ethtool_ops = {
diff --git a/drivers/net/can/usb/etas_es58x/es581_4.c b/drivers/net/can/usb/etas_es58x/es581_4.c
index 1bcdcece5ec7..4151b18fd045 100644
--- a/drivers/net/can/usb/etas_es58x/es581_4.c
+++ b/drivers/net/can/usb/etas_es58x/es581_4.c
@@ -6,12 +6,12 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
+#include <asm/unaligned.h>
 #include <linux/kernel.h>
 #include <linux/units.h>
-#include <asm/unaligned.h>
 
 #include "es58x_core.h"
 #include "es581_4.h"
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index ddb7c5735c9a..41bea531234d 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -7,15 +7,15 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2025 Vincent Mailhol <mailhol@kernel.org>
  */
 
+#include <asm/unaligned.h>
+#include <linux/crc16.h>
 #include <linux/ethtool.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/usb.h>
-#include <linux/crc16.h>
-#include <asm/unaligned.h>
 
 #include "es58x_core.h"
 
@@ -1976,6 +1976,7 @@ static const struct net_device_ops es58x_netdev_ops = {
 	.ndo_stop = es58x_stop,
 	.ndo_start_xmit = es58x_start_xmit,
 	.ndo_eth_ioctl = can_eth_ioctl_hwts,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops es58x_ethtool_ops = {
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.h b/drivers/net/can/usb/etas_es58x/es58x_core.h
index 640fe0a1df63..4a082fd69e6f 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.h
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.h
@@ -6,17 +6,17 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
 #ifndef __ES58X_COMMON_H__
 #define __ES58X_COMMON_H__
 
-#include <linux/types.h>
-#include <linux/usb.h>
-#include <linux/netdevice.h>
 #include <linux/can.h>
 #include <linux/can/dev.h>
+#include <linux/netdevice.h>
+#include <linux/types.h>
+#include <linux/usb.h>
 
 #include "es581_4.h"
 #include "es58x_fd.h"
diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
index c97ffa71fd75..fa87b0b78e3e 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
@@ -8,12 +8,12 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
+#include <asm/unaligned.h>
 #include <linux/kernel.h>
 #include <linux/units.h>
-#include <asm/unaligned.h>
 
 #include "es58x_core.h"
 #include "es58x_fd.h"
diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index 47619e9cb005..ecc489afb841 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -761,6 +761,7 @@ static const struct net_device_ops mcba_netdev_ops = {
 	.ndo_open = mcba_usb_open,
 	.ndo_stop = mcba_usb_close,
 	.ndo_start_xmit = mcba_usb_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops mcba_ethtool_ops = {
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 1d996d3320fe..928a78947cb0 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -89,7 +89,7 @@ void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
 		u32 delta_ts = time_ref->ts_dev_2 - time_ref->ts_dev_1;
 
 		if (time_ref->ts_dev_2 < time_ref->ts_dev_1)
-			delta_ts &= (1 << time_ref->adapter->ts_used_bits) - 1;
+			delta_ts &= (1ULL << time_ref->adapter->ts_used_bits) - 1;
 
 		time_ref->ts_total += delta_ts;
 	}
diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 05ecaa007ab1..d899ebb902a0 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -682,30 +682,24 @@ static int gswip_add_single_port_br(struct gswip_priv *priv, int port, bool add)
 	return 0;
 }
 
-static int gswip_port_enable(struct dsa_switch *ds, int port,
-			     struct phy_device *phydev)
+static int gswip_port_setup(struct dsa_switch *ds, int port)
 {
 	struct gswip_priv *priv = ds->priv;
 	int err;
 
-	if (!dsa_is_user_port(ds, port))
-		return 0;
-
 	if (!dsa_is_cpu_port(ds, port)) {
 		err = gswip_add_single_port_br(priv, port, true);
 		if (err)
 			return err;
 	}
 
-	/* RMON Counter Enable for port */
-	gswip_switch_w(priv, GSWIP_BM_PCFG_CNTEN, GSWIP_BM_PCFGp(port));
+	return 0;
+}
 
-	/* enable port fetch/store dma & VLAN Modification */
-	gswip_switch_mask(priv, 0, GSWIP_FDMA_PCTRL_EN |
-				   GSWIP_FDMA_PCTRL_VLANMOD_BOTH,
-			 GSWIP_FDMA_PCTRLp(port));
-	gswip_switch_mask(priv, 0, GSWIP_SDMA_PCTRL_EN,
-			  GSWIP_SDMA_PCTRLp(port));
+static int gswip_port_enable(struct dsa_switch *ds, int port,
+			     struct phy_device *phydev)
+{
+	struct gswip_priv *priv = ds->priv;
 
 	if (!dsa_is_cpu_port(ds, port)) {
 		u32 mdio_phy = 0;
@@ -717,6 +711,16 @@ static int gswip_port_enable(struct dsa_switch *ds, int port,
 				GSWIP_MDIO_PHYp(port));
 	}
 
+	/* RMON Counter Enable for port */
+	gswip_switch_w(priv, GSWIP_BM_PCFG_CNTEN, GSWIP_BM_PCFGp(port));
+
+	/* enable port fetch/store dma & VLAN Modification */
+	gswip_switch_mask(priv, 0, GSWIP_FDMA_PCTRL_EN |
+				   GSWIP_FDMA_PCTRL_VLANMOD_BOTH,
+			 GSWIP_FDMA_PCTRLp(port));
+	gswip_switch_mask(priv, 0, GSWIP_SDMA_PCTRL_EN,
+			  GSWIP_SDMA_PCTRLp(port));
+
 	return 0;
 }
 
@@ -724,9 +728,6 @@ static void gswip_port_disable(struct dsa_switch *ds, int port)
 {
 	struct gswip_priv *priv = ds->priv;
 
-	if (!dsa_is_user_port(ds, port))
-		return;
-
 	gswip_switch_mask(priv, GSWIP_FDMA_PCTRL_EN, 0,
 			  GSWIP_FDMA_PCTRLp(port));
 	gswip_switch_mask(priv, GSWIP_SDMA_PCTRL_EN, 0,
@@ -1365,8 +1366,9 @@ static int gswip_port_fdb(struct dsa_switch *ds, int port,
 	int i;
 	int err;
 
+	/* Operation not supported on the CPU port, don't throw errors */
 	if (!bridge)
-		return -EINVAL;
+		return 0;
 
 	for (i = max_ports; i < ARRAY_SIZE(priv->vlans); i++) {
 		if (priv->vlans[i].bridge == bridge) {
@@ -1821,6 +1823,7 @@ static int gswip_get_sset_count(struct dsa_switch *ds, int port, int sset)
 static const struct dsa_switch_ops gswip_xrx200_switch_ops = {
 	.get_tag_protocol	= gswip_get_tag_protocol,
 	.setup			= gswip_setup,
+	.port_setup		= gswip_port_setup,
 	.port_enable		= gswip_port_enable,
 	.port_disable		= gswip_port_disable,
 	.port_bridge_join	= gswip_port_bridge_join,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index 4d6663ff8472..72677d140a88 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -244,7 +244,7 @@ bnxt_tc_parse_pedit(struct bnxt *bp, struct bnxt_tc_actions *actions,
 			   offset < offset_of_ip6_daddr + 16) {
 			actions->nat.src_xlate = false;
 			idx = (offset - offset_of_ip6_daddr) / 4;
-			actions->nat.l3.ipv6.saddr.s6_addr32[idx] = htonl(val);
+			actions->nat.l3.ipv6.daddr.s6_addr32[idx] = htonl(val);
 		} else {
 			netdev_err(bp->dev,
 				   "%s: IPv6_hdr: Invalid pedit field\n",
diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index 9b84c8d8d309..d117022d15d7 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -2126,7 +2126,7 @@ static const struct ethtool_ops cxgb_ethtool_ops = {
 	.set_link_ksettings = set_link_ksettings,
 };
 
-static int in_range(int val, int lo, int hi)
+static int cxgb_in_range(int val, int lo, int hi)
 {
 	return val < 0 || (val <= hi && val >= lo);
 }
@@ -2162,19 +2162,19 @@ static int cxgb_siocdevprivate(struct net_device *dev,
 			return -EINVAL;
 		if (t.qset_idx >= SGE_QSETS)
 			return -EINVAL;
-		if (!in_range(t.intr_lat, 0, M_NEWTIMER) ||
-		    !in_range(t.cong_thres, 0, 255) ||
-		    !in_range(t.txq_size[0], MIN_TXQ_ENTRIES,
+		if (!cxgb_in_range(t.intr_lat, 0, M_NEWTIMER) ||
+		    !cxgb_in_range(t.cong_thres, 0, 255) ||
+		    !cxgb_in_range(t.txq_size[0], MIN_TXQ_ENTRIES,
 			      MAX_TXQ_ENTRIES) ||
-		    !in_range(t.txq_size[1], MIN_TXQ_ENTRIES,
+		    !cxgb_in_range(t.txq_size[1], MIN_TXQ_ENTRIES,
 			      MAX_TXQ_ENTRIES) ||
-		    !in_range(t.txq_size[2], MIN_CTRL_TXQ_ENTRIES,
+		    !cxgb_in_range(t.txq_size[2], MIN_CTRL_TXQ_ENTRIES,
 			      MAX_CTRL_TXQ_ENTRIES) ||
-		    !in_range(t.fl_size[0], MIN_FL_ENTRIES,
+		    !cxgb_in_range(t.fl_size[0], MIN_FL_ENTRIES,
 			      MAX_RX_BUFFERS) ||
-		    !in_range(t.fl_size[1], MIN_FL_ENTRIES,
+		    !cxgb_in_range(t.fl_size[1], MIN_FL_ENTRIES,
 			      MAX_RX_JUMBO_BUFFERS) ||
-		    !in_range(t.rspq_size, MIN_RSPQ_ENTRIES,
+		    !cxgb_in_range(t.rspq_size, MIN_RSPQ_ENTRIES,
 			      MAX_RSPQ_ENTRIES))
 			return -EINVAL;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 61590e92f3ab..3c9ac53da331 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -50,6 +50,7 @@
 #define I40E_MAX_VEB			16
 
 #define I40E_MAX_NUM_DESCRIPTORS	4096
+#define I40E_MAX_NUM_DESCRIPTORS_XL710	8160
 #define I40E_MAX_CSR_SPACE		(4 * 1024 * 1024 - 64 * 1024)
 #define I40E_DEFAULT_NUM_DESCRIPTORS	512
 #define I40E_REQ_DESCRIPTOR_MULTIPLE	32
@@ -1255,7 +1256,8 @@ struct i40e_mac_filter *i40e_add_mac_filter(struct i40e_vsi *vsi,
 					    const u8 *macaddr);
 int i40e_del_mac_filter(struct i40e_vsi *vsi, const u8 *macaddr);
 bool i40e_is_vsi_in_vlan(struct i40e_vsi *vsi);
-int i40e_count_filters(struct i40e_vsi *vsi);
+int i40e_count_all_filters(struct i40e_vsi *vsi);
+int i40e_count_active_filters(struct i40e_vsi *vsi);
 struct i40e_mac_filter *i40e_find_mac(struct i40e_vsi *vsi, const u8 *macaddr);
 void i40e_vlan_stripping_enable(struct i40e_vsi *vsi);
 static inline bool i40e_is_sw_dcb(struct i40e_pf *pf)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 9b5044cfea87..c3378106946c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2012,6 +2012,18 @@ static void i40e_get_drvinfo(struct net_device *netdev,
 		drvinfo->n_priv_flags += I40E_GL_PRIV_FLAGS_STR_LEN;
 }
 
+static u32 i40e_get_max_num_descriptors(struct i40e_pf *pf)
+{
+	struct i40e_hw *hw = &pf->hw;
+
+	switch (hw->mac.type) {
+	case I40E_MAC_XL710:
+		return I40E_MAX_NUM_DESCRIPTORS_XL710;
+	default:
+		return I40E_MAX_NUM_DESCRIPTORS;
+	}
+}
+
 static void i40e_get_ringparam(struct net_device *netdev,
 			       struct ethtool_ringparam *ring,
 			       struct kernel_ethtool_ringparam *kernel_ring,
@@ -2021,8 +2033,8 @@ static void i40e_get_ringparam(struct net_device *netdev,
 	struct i40e_pf *pf = np->vsi->back;
 	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 
-	ring->rx_max_pending = I40E_MAX_NUM_DESCRIPTORS;
-	ring->tx_max_pending = I40E_MAX_NUM_DESCRIPTORS;
+	ring->rx_max_pending = i40e_get_max_num_descriptors(pf);
+	ring->tx_max_pending = i40e_get_max_num_descriptors(pf);
 	ring->rx_mini_max_pending = 0;
 	ring->rx_jumbo_max_pending = 0;
 	ring->rx_pending = vsi->rx_rings[0]->count;
@@ -2047,12 +2059,12 @@ static int i40e_set_ringparam(struct net_device *netdev,
 			      struct kernel_ethtool_ringparam *kernel_ring,
 			      struct netlink_ext_ack *extack)
 {
+	u32 new_rx_count, new_tx_count, max_num_descriptors;
 	struct i40e_ring *tx_rings = NULL, *rx_rings = NULL;
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_hw *hw = &np->vsi->back->hw;
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	u32 new_rx_count, new_tx_count;
 	u16 tx_alloc_queue_pairs;
 	int timeout = 50;
 	int i, err = 0;
@@ -2060,14 +2072,15 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
 
-	if (ring->tx_pending > I40E_MAX_NUM_DESCRIPTORS ||
+	max_num_descriptors = i40e_get_max_num_descriptors(pf);
+	if (ring->tx_pending > max_num_descriptors ||
 	    ring->tx_pending < I40E_MIN_NUM_DESCRIPTORS ||
-	    ring->rx_pending > I40E_MAX_NUM_DESCRIPTORS ||
+	    ring->rx_pending > max_num_descriptors ||
 	    ring->rx_pending < I40E_MIN_NUM_DESCRIPTORS) {
 		netdev_info(netdev,
 			    "Descriptors requested (Tx: %d / Rx: %d) out of range [%d-%d]\n",
 			    ring->tx_pending, ring->rx_pending,
-			    I40E_MIN_NUM_DESCRIPTORS, I40E_MAX_NUM_DESCRIPTORS);
+			    I40E_MIN_NUM_DESCRIPTORS, max_num_descriptors);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e01eab03971f..522267314160 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1233,12 +1233,30 @@ void i40e_update_stats(struct i40e_vsi *vsi)
 }
 
 /**
- * i40e_count_filters - counts VSI mac filters
+ * i40e_count_all_filters - counts VSI MAC filters
  * @vsi: the VSI to be searched
  *
- * Returns count of mac filters
- **/
-int i40e_count_filters(struct i40e_vsi *vsi)
+ * Return: count of MAC filters in any state.
+ */
+int i40e_count_all_filters(struct i40e_vsi *vsi)
+{
+	struct i40e_mac_filter *f;
+	struct hlist_node *h;
+	int bkt, cnt = 0;
+
+	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist)
+		cnt++;
+
+	return cnt;
+}
+
+/**
+ * i40e_count_active_filters - counts VSI MAC filters
+ * @vsi: the VSI to be searched
+ *
+ * Return: count of active MAC filters.
+ */
+int i40e_count_active_filters(struct i40e_vsi *vsi)
 {
 	struct i40e_mac_filter *f;
 	struct hlist_node *h;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 7cfcb16c3091..2b2f9bb755b6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -446,7 +446,7 @@ static void i40e_config_irq_link_list(struct i40e_vf *vf, u16 vsi_id,
 		    (qtype << I40E_QINT_RQCTL_NEXTQ_TYPE_SHIFT) |
 		    (pf_queue_id << I40E_QINT_RQCTL_NEXTQ_INDX_SHIFT) |
 		    BIT(I40E_QINT_RQCTL_CAUSE_ENA_SHIFT) |
-		    (itr_idx << I40E_QINT_RQCTL_ITR_INDX_SHIFT);
+		    FIELD_PREP(I40E_QINT_RQCTL_ITR_INDX_MASK, itr_idx);
 		wr32(hw, reg_idx, reg);
 	}
 
@@ -653,6 +653,13 @@ static int i40e_config_vsi_tx_queue(struct i40e_vf *vf, u16 vsi_id,
 
 	/* only set the required fields */
 	tx_ctx.base = info->dma_ring_addr / 128;
+
+	/* ring_len has to be multiple of 8 */
+	if (!IS_ALIGNED(info->ring_len, 8) ||
+	    info->ring_len > I40E_MAX_NUM_DESCRIPTORS_XL710) {
+		ret = -EINVAL;
+		goto error_context;
+	}
 	tx_ctx.qlen = info->ring_len;
 	tx_ctx.rdylist = le16_to_cpu(vsi->info.qs_handle[0]);
 	tx_ctx.rdylist_act = 0;
@@ -718,6 +725,13 @@ static int i40e_config_vsi_rx_queue(struct i40e_vf *vf, u16 vsi_id,
 
 	/* only set the required fields */
 	rx_ctx.base = info->dma_ring_addr / 128;
+
+	/* ring_len has to be multiple of 32 */
+	if (!IS_ALIGNED(info->ring_len, 32) ||
+	    info->ring_len > I40E_MAX_NUM_DESCRIPTORS_XL710) {
+		ret = -EINVAL;
+		goto error_param;
+	}
 	rx_ctx.qlen = info->ring_len;
 
 	if (info->splithdr_enabled) {
@@ -1455,6 +1469,7 @@ static void i40e_trigger_vf_reset(struct i40e_vf *vf, bool flr)
 	 * functions that may still be running at this point.
 	 */
 	clear_bit(I40E_VF_STATE_INIT, &vf->vf_states);
+	clear_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states);
 
 	/* In the case of a VFLR, the HW has already reset the VF and we
 	 * just need to clean up, so don't hit the VFRTRIG register.
@@ -2121,7 +2136,10 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	size_t len = 0;
 	int ret;
 
-	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_INIT)) {
+	i40e_sync_vf_state(vf, I40E_VF_STATE_INIT);
+
+	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states) ||
+	    test_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto err;
 	}
@@ -2224,6 +2242,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 				vf->default_lan_addr.addr);
 	}
 	set_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states);
+	set_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states);
 
 err:
 	/* send the response back to the VF */
@@ -2386,7 +2405,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		}
 
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = I40E_ERR_NO_AVAILABLE_VSI;
 				goto error_param;
 			}
@@ -2407,7 +2426,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		 * to its appropriate VSIs based on TC mapping
 		 */
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = I40E_ERR_NO_AVAILABLE_VSI;
 				goto error_param;
 			}
@@ -2457,8 +2476,10 @@ static int i40e_validate_queue_map(struct i40e_vf *vf, u16 vsi_id,
 	u16 vsi_queue_id, queue_id;
 
 	for_each_set_bit(vsi_queue_id, &queuemap, I40E_MAX_VSI_QP) {
-		if (vf->adq_enabled) {
-			vsi_id = vf->ch[vsi_queue_id / I40E_MAX_VF_VSI].vsi_id;
+		u16 idx = vsi_queue_id / I40E_MAX_VF_VSI;
+
+		if (vf->adq_enabled && idx < vf->num_tc) {
+			vsi_id = vf->ch[idx].vsi_id;
 			queue_id = (vsi_queue_id % I40E_DEFAULT_QUEUES_PER_VF);
 		} else {
 			queue_id = vsi_queue_id;
@@ -2846,24 +2867,6 @@ static int i40e_vc_get_stats_msg(struct i40e_vf *vf, u8 *msg)
 				      (u8 *)&stats, sizeof(stats));
 }
 
-/**
- * i40e_can_vf_change_mac
- * @vf: pointer to the VF info
- *
- * Return true if the VF is allowed to change its MAC filters, false otherwise
- */
-static bool i40e_can_vf_change_mac(struct i40e_vf *vf)
-{
-	/* If the VF MAC address has been set administratively (via the
-	 * ndo_set_vf_mac command), then deny permission to the VF to
-	 * add/delete unicast MAC addresses, unless the VF is trusted
-	 */
-	if (vf->pf_set_mac && !vf->trusted)
-		return false;
-
-	return true;
-}
-
 #define I40E_MAX_MACVLAN_PER_HW 3072
 #define I40E_MAX_MACVLAN_PER_PF(num_ports) (I40E_MAX_MACVLAN_PER_HW /	\
 	(num_ports))
@@ -2902,8 +2905,10 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = pf->vsi[vf->lan_vsi_idx];
 	struct i40e_hw *hw = &pf->hw;
-	int mac2add_cnt = 0;
-	int i;
+	int i, mac_add_max, mac_add_cnt = 0;
+	bool vf_trusted;
+
+	vf_trusted = test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
 
 	for (i = 0; i < al->num_elements; i++) {
 		struct i40e_mac_filter *f;
@@ -2923,9 +2928,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 		 * The VF may request to set the MAC address filter already
 		 * assigned to it so do not return an error in that case.
 		 */
-		if (!i40e_can_vf_change_mac(vf) &&
-		    !is_multicast_ether_addr(addr) &&
-		    !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
+		if (!vf_trusted && !is_multicast_ether_addr(addr) &&
+		    vf->pf_set_mac && !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
 			dev_err(&pf->pdev->dev,
 				"VF attempting to override administratively set MAC address, bring down and up the VF interface to resume normal operation\n");
 			return -EPERM;
@@ -2934,29 +2938,33 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 		/*count filters that really will be added*/
 		f = i40e_find_mac(vsi, addr);
 		if (!f)
-			++mac2add_cnt;
+			++mac_add_cnt;
 	}
 
 	/* If this VF is not privileged, then we can't add more than a limited
-	 * number of addresses. Check to make sure that the additions do not
-	 * push us over the limit.
-	 */
-	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
-		if ((i40e_count_filters(vsi) + mac2add_cnt) >
-		    I40E_VC_MAX_MAC_ADDR_PER_VF) {
-			dev_err(&pf->pdev->dev,
-				"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
-			return -EPERM;
-		}
-	/* If this VF is trusted, it can use more resources than untrusted.
+	 * number of addresses.
+	 *
+	 * If this VF is trusted, it can use more resources than untrusted.
 	 * However to ensure that every trusted VF has appropriate number of
 	 * resources, divide whole pool of resources per port and then across
 	 * all VFs.
 	 */
-	} else {
-		if ((i40e_count_filters(vsi) + mac2add_cnt) >
-		    I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
-						       hw->num_ports)) {
+	if (!vf_trusted)
+		mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
+	else
+		mac_add_max = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs, hw->num_ports);
+
+	/* VF can replace all its filters in one step, in this case mac_add_max
+	 * will be added as active and another mac_add_max will be in
+	 * a to-be-removed state. Account for that.
+	 */
+	if ((i40e_count_active_filters(vsi) + mac_add_cnt) > mac_add_max ||
+	    (i40e_count_all_filters(vsi) + mac_add_cnt) > 2 * mac_add_max) {
+		if (!vf_trusted) {
+			dev_err(&pf->pdev->dev,
+				"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
+			return -EPERM;
+		} else {
 			dev_err(&pf->pdev->dev,
 				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
 			return -EPERM;
@@ -3523,7 +3531,7 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 
 	/* action_meta is TC number here to which the filter is applied */
 	if (!tc_filter->action_meta ||
-	    tc_filter->action_meta > vf->num_tc) {
+	    tc_filter->action_meta >= vf->num_tc) {
 		dev_info(&pf->pdev->dev, "VF %d: Invalid TC number %u\n",
 			 vf->vf_id, tc_filter->action_meta);
 		goto err;
@@ -3821,6 +3829,8 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 				       aq_ret);
 }
 
+#define I40E_MAX_VF_CLOUD_FILTER 0xFF00
+
 /**
  * i40e_vc_add_cloud_filter
  * @vf: pointer to the VF info
@@ -3860,6 +3870,14 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		goto err_out;
 	}
 
+	if (vf->num_cloud_filters >= I40E_MAX_VF_CLOUD_FILTER) {
+		dev_warn(&pf->pdev->dev,
+			 "VF %d: Max number of filters reached, can't apply cloud filter\n",
+			 vf->vf_id);
+		aq_ret = -ENOSPC;
+		goto err_out;
+	}
+
 	cfilter = kzalloc(sizeof(*cfilter), GFP_KERNEL);
 	if (!cfilter) {
 		aq_ret = -ENOMEM;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 97e9c34d7c6c..3b841fbaffa6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -39,7 +39,8 @@ enum i40e_vf_states {
 	I40E_VF_STATE_MC_PROMISC,
 	I40E_VF_STATE_UC_PROMISC,
 	I40E_VF_STATE_PRE_ENABLE,
-	I40E_VF_STATE_RESETTING
+	I40E_VF_STATE_RESETTING,
+	I40E_VF_STATE_RESOURCES_LOADED,
 };
 
 /* VF capabilities */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 254cad45a555..2fe633be06bf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -21,8 +21,7 @@
 #include "rvu.h"
 #include "lmac_common.h"
 
-#define DRV_NAME	"Marvell-CGX/RPM"
-#define DRV_STRING      "Marvell CGX/RPM Driver"
+#define DRV_NAME	"Marvell-CGX-RPM"
 
 static LIST_HEAD(cgx_list);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index bb77ab7ddfef..6833cbf85344 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -1039,7 +1039,6 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 
 free_leaf:
 	otx2_tc_del_from_flow_list(flow_cfg, new_node);
-	kfree_rcu(new_node, rcu);
 	if (new_node->is_act_police) {
 		mutex_lock(&nic->mbox.lock);
 
@@ -1059,6 +1058,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 
 		mutex_unlock(&nic->mbox.lock);
 	}
+	kfree_rcu(new_node, rcu);
 
 	return rc;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 948e35c405a8..be84aed47160 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2827,7 +2827,7 @@ static void stmmac_dma_interrupt(struct stmmac_priv *priv)
 	u32 channels_to_check = tx_channel_count > rx_channel_count ?
 				tx_channel_count : rx_channel_count;
 	u32 chan;
-	int status[max_t(u32, MTL_MAX_TX_QUEUES, MTL_MAX_RX_QUEUES)];
+	int status[MAX_T(u32, MTL_MAX_TX_QUEUES, MTL_MAX_RX_QUEUES)];
 
 	/* Make sure we never check beyond our status buffer. */
 	if (WARN_ON_ONCE(channels_to_check > ARRAY_SIZE(status)))
diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index 1eff202f6a1f..e050910b08a2 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -14,9 +14,7 @@
 #include "fjes.h"
 #include "fjes_trace.h"
 
-#define MAJ 1
-#define MIN 2
-#define DRV_VERSION __stringify(MAJ) "." __stringify(MIN)
+#define DRV_VERSION "1.2"
 #define DRV_NAME	"fjes"
 char fjes_driver_name[] = DRV_NAME;
 char fjes_driver_version[] = DRV_VERSION;
diff --git a/drivers/nfc/pn544/i2c.c b/drivers/nfc/pn544/i2c.c
index 9e754abcfa2a..50559d976f78 100644
--- a/drivers/nfc/pn544/i2c.c
+++ b/drivers/nfc/pn544/i2c.c
@@ -126,8 +126,6 @@ struct pn544_i2c_fw_secure_blob {
 #define PN544_FW_CMD_RESULT_COMMAND_REJECTED 0xE0
 #define PN544_FW_CMD_RESULT_CHUNK_ERROR 0xE6
 
-#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
-
 #define PN544_FW_WRITE_BUFFER_MAX_LEN 0x9f7
 #define PN544_FW_I2C_MAX_PAYLOAD PN544_HCI_I2C_LLC_MAX_SIZE
 #define PN544_FW_I2C_WRITE_FRAME_HEADER_LEN 8
diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 5ff5aaf92b56..b80007676c2d 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -757,7 +757,6 @@ static union acpi_object *__call_snc_method(acpi_handle handle, char *method,
 	return result;
 }
 
-#define MIN(a, b)	(a > b ? b : a)
 static int sony_nc_buffer_call(acpi_handle handle, char *name, u64 *value,
 		void *buffer, size_t buflen)
 {
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index e294d5d961eb..012cd2dade86 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -65,11 +65,7 @@
 #include "task.h"
 #include "probe_roms.h"
 
-#define MAJ 1
-#define MIN 2
-#define BUILD 0
-#define DRV_VERSION __stringify(MAJ) "." __stringify(MIN) "." \
-	__stringify(BUILD)
+#define DRV_VERSION "1.2.0"
 
 MODULE_VERSION(DRV_VERSION);
 
diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h
index a444ec14ff9d..1c17a87a8572 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/math_support.h
@@ -31,11 +31,6 @@
 /* A => B */
 #define IMPLIES(a, b)        (!(a) || (b))
 
-/* for preprocessor and array sizing use MIN and MAX
-   otherwise use min and max */
-#define MAX(a, b)            (((a) > (b)) ? (a) : (b))
-#define MIN(a, b)            (((a) < (b)) ? (a) : (b))
-
 #define ROUND_DIV(a, b)      (((b) != 0) ? ((a) + ((b) >> 1)) / (b) : 0)
 #define CEIL_DIV(a, b)       (((b) != 0) ? ((a) + (b) - 1) / (b) : 0)
 #define CEIL_MUL(a, b)       (CEIL_DIV(a, b) * (b))
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index bfd97cad8aa4..c0fd8ab3fe8f 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -734,7 +734,7 @@ void usb_detect_quirks(struct usb_device *udev)
 	udev->quirks ^= usb_detect_dynamic_quirks(udev);
 
 	if (udev->quirks)
-		dev_dbg(&udev->dev, "USB quirks for this device: %x\n",
+		dev_dbg(&udev->dev, "USB quirks for this device: 0x%x\n",
 			udev->quirks);
 
 #ifdef CONFIG_USB_DEFAULT_PERSIST
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 8882c6d7c7a5..7b04cad412aa 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2489,7 +2489,7 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
 	unsigned charcount = font->charcount;
 	int w = font->width;
 	int h = font->height;
-	int size;
+	int size, alloc_size;
 	int i, csum;
 	u8 *new_data, *data = font->data;
 	int pitch = PITCH(font->width);
@@ -2516,9 +2516,16 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
 	if (fbcon_invalid_charcount(info, charcount))
 		return -EINVAL;
 
-	size = CALC_FONTSZ(h, pitch, charcount);
+	/* Check for integer overflow in font size calculation */
+	if (check_mul_overflow(h, pitch, &size) ||
+	    check_mul_overflow(size, charcount, &size))
+		return -EINVAL;
+
+	/* Check for overflow in allocation size calculation */
+	if (check_add_overflow(FONT_EXTRA_WORDS * sizeof(int), size, &alloc_size))
+		return -EINVAL;
 
-	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);
+	new_data = kmalloc(alloc_size, GFP_USER);
 
 	if (!new_data)
 		return -ENOMEM;
diff --git a/drivers/virt/acrn/ioreq.c b/drivers/virt/acrn/ioreq.c
index d75ab3f66da4..d3d800a5cbe1 100644
--- a/drivers/virt/acrn/ioreq.c
+++ b/drivers/virt/acrn/ioreq.c
@@ -351,7 +351,7 @@ static bool handle_cf8cfc(struct acrn_vm *vm,
 	return is_handled;
 }
 
-static bool in_range(struct acrn_ioreq_range *range,
+static bool acrn_in_range(struct acrn_ioreq_range *range,
 		     struct acrn_io_request *req)
 {
 	bool ret = false;
@@ -389,7 +389,7 @@ static struct acrn_ioreq_client *find_ioreq_client(struct acrn_vm *vm,
 	list_for_each_entry(client, &vm->ioreq_clients, list) {
 		read_lock_bh(&client->range_lock);
 		list_for_each_entry(range, &client->range_list, list) {
-			if (in_range(range, req)) {
+			if (acrn_in_range(range, req)) {
 				found = client;
 				break;
 			}
diff --git a/fs/afs/server.c b/fs/afs/server.c
index 87381c2ffe37..f92ce4b7d73a 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -401,13 +401,14 @@ struct afs_server *afs_use_server(struct afs_server *server, enum afs_server_tra
 void afs_put_server(struct afs_net *net, struct afs_server *server,
 		    enum afs_server_trace reason)
 {
-	unsigned int a, debug_id = server->debug_id;
+	unsigned int a, debug_id;
 	bool zero;
 	int r;
 
 	if (!server)
 		return;
 
+	debug_id = server->debug_id;
 	a = atomic_read(&server->active);
 	zero = __refcount_dec_and_test(&server->ref, &r);
 	trace_afs_server(debug_id, r - 1, a, reason);
diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index f9850edfd726..cadd3fb48769 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -8,8 +8,6 @@
 #include <linux/math64.h>
 #include <linux/rbtree.h>
 
-#define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
-
 static inline void cond_wake_up(struct wait_queue_head *wq)
 {
 	/*
diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index d2eb4d291985..e8d5869682b2 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -36,8 +36,6 @@
  */
 
 
-#define in_range(b, first, len)	((b) >= (first) && (b) <= (first) + (len) - 1)
-
 struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
 					     unsigned int block_group,
 					     struct buffer_head ** bh)
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 903bb01e6dd2..87e223fa4ebd 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3804,8 +3804,6 @@ static inline void set_bitmap_uptodate(struct buffer_head *bh)
 	set_bit(BH_BITMAP_UPTODATE, &(bh)->b_state);
 }
 
-#define in_range(b, first, len)	((b) >= (first) && (b) <= (first) + (len) - 1)
-
 /* For ioend & aio unwritten conversion wait queues */
 #define EXT4_WQ_HASH_SZ		37
 #define ext4_ioend_wq(v)   (&ext4__ioend_wq[((unsigned long)(v)) %\
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d4b2a199cb9d..7f521311e3f0 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -576,14 +576,16 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
 
 	/*
 	 * If folio is mapped, it was faulted in after being
-	 * unmapped in caller.  Unmap (again) while holding
-	 * the fault mutex.  The mutex will prevent faults
-	 * until we finish removing the folio.
+	 * unmapped in caller or hugetlb_vmdelete_list() skips
+	 * unmapping it due to fail to grab lock.  Unmap (again)
+	 * while holding the fault mutex.  The mutex will prevent
+	 * faults until we finish removing the folio.  Hold folio
+	 * lock to guarantee no concurrent migration.
 	 */
+	folio_lock(folio);
 	if (unlikely(folio_mapped(folio)))
 		hugetlb_unmap_file_folio(h, mapping, folio, index);
 
-	folio_lock(folio);
 	/*
 	 * We must remove the folio from page cache before removing
 	 * the region/ reserve map (hugetlb_unreserve_pages).  In
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 323b8a401a8c..84b5b2f5df99 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -147,7 +147,7 @@ struct smb_direct_transport {
 	wait_queue_head_t	wait_send_pending;
 	atomic_t		send_pending;
 
-	struct delayed_work	post_recv_credits_work;
+	struct work_struct	post_recv_credits_work;
 	struct work_struct	send_immediate_work;
 	struct work_struct	disconnect_work;
 
@@ -365,8 +365,8 @@ static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
 
 	spin_lock_init(&t->lock_new_recv_credits);
 
-	INIT_DELAYED_WORK(&t->post_recv_credits_work,
-			  smb_direct_post_recv_credits);
+	INIT_WORK(&t->post_recv_credits_work,
+		  smb_direct_post_recv_credits);
 	INIT_WORK(&t->send_immediate_work, smb_direct_send_immediate_work);
 	INIT_WORK(&t->disconnect_work, smb_direct_disconnect_rdma_work);
 
@@ -393,7 +393,7 @@ static void free_transport(struct smb_direct_transport *t)
 		   atomic_read(&t->send_pending) == 0);
 
 	cancel_work_sync(&t->disconnect_work);
-	cancel_delayed_work_sync(&t->post_recv_credits_work);
+	cancel_work_sync(&t->post_recv_credits_work);
 	cancel_work_sync(&t->send_immediate_work);
 
 	if (t->qp) {
@@ -609,8 +609,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 			wake_up_interruptible(&t->wait_send_credits);
 
 		if (is_receive_credit_post_required(receive_credits, avail_recvmsg_count))
-			mod_delayed_work(smb_direct_wq,
-					 &t->post_recv_credits_work, 0);
+			queue_work(smb_direct_wq, &t->post_recv_credits_work);
 
 		if (data_length) {
 			enqueue_reassembly(t, recvmsg, (int)data_length);
@@ -767,8 +766,7 @@ static int smb_direct_read(struct ksmbd_transport *t, char *buf,
 		st->count_avail_recvmsg += queue_removed;
 		if (is_receive_credit_post_required(st->recv_credits, st->count_avail_recvmsg)) {
 			spin_unlock(&st->receive_credit_lock);
-			mod_delayed_work(smb_direct_wq,
-					 &st->post_recv_credits_work, 0);
+			queue_work(smb_direct_wq, &st->post_recv_credits_work);
 		} else {
 			spin_unlock(&st->receive_credit_lock);
 		}
@@ -795,7 +793,7 @@ static int smb_direct_read(struct ksmbd_transport *t, char *buf,
 static void smb_direct_post_recv_credits(struct work_struct *work)
 {
 	struct smb_direct_transport *t = container_of(work,
-		struct smb_direct_transport, post_recv_credits_work.work);
+		struct smb_direct_transport, post_recv_credits_work);
 	struct smb_direct_recvmsg *recvmsg;
 	int receive_credits, credits = 0;
 	int ret;
@@ -1676,7 +1674,7 @@ static int smb_direct_prepare_negotiation(struct smb_direct_transport *t)
 		goto out_err;
 	}
 
-	smb_direct_post_recv_credits(&t->post_recv_credits_work.work);
+	smb_direct_post_recv_credits(&t->post_recv_credits_work);
 	return 0;
 out_err:
 	put_recvmsg(t, recvmsg);
diff --git a/fs/ufs/util.h b/fs/ufs/util.h
index 4931bec1a01c..89247193d96d 100644
--- a/fs/ufs/util.h
+++ b/fs/ufs/util.h
@@ -11,12 +11,6 @@
 #include <linux/fs.h>
 #include "swab.h"
 
-
-/*
- * some useful macros
- */
-#define in_range(b,first,len)	((b)>=(first)&&(b)<(first)+(len))
-
 /*
  * functions used for retyping
  */
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 1424200fe88c..9af84cad92e9 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -152,7 +152,7 @@ struct af_alg_ctx {
 	size_t used;
 	atomic_t rcvused;
 
-	u32		more:1,
+	bool		more:1,
 			merge:1,
 			enc:1,
 			write:1,
diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index dd52969698f7..fc384714da45 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -5,6 +5,7 @@
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
 #include <linux/const.h>
+#include <linux/types.h>
 
 /*
  * min()/max()/clamp() macros must accomplish three things:
@@ -44,31 +45,34 @@
 
 #define __cmp(op, x, y)	((x) __cmp_op_##op (y) ? (x) : (y))
 
-#define __cmp_once(op, x, y, unique_x, unique_y) ({	\
-		typeof(x) unique_x = (x);		\
-		typeof(y) unique_y = (y);		\
-		static_assert(__types_ok(x, y),		\
-			#op "(" #x ", " #y ") signedness error, fix types or consider u" #op "() before " #op "_t()"); \
-		__cmp(op, unique_x, unique_y); })
+#define __cmp_once_unique(op, type, x, y, ux, uy) \
+	({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
+
+#define __cmp_once(op, type, x, y) \
+	__cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
+
+#define __careful_cmp_once(op, x, y) ({			\
+	static_assert(__types_ok(x, y),			\
+		#op "(" #x ", " #y ") signedness error, fix types or consider u" #op "() before " #op "_t()"); \
+	__cmp_once(op, __auto_type, x, y); })
 
 #define __careful_cmp(op, x, y)					\
 	__builtin_choose_expr(__is_constexpr((x) - (y)),	\
-		__cmp(op, x, y),				\
-		__cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
+		__cmp(op, x, y), __careful_cmp_once(op, x, y))
 
 #define __clamp(val, lo, hi)	\
 	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
 
-#define __clamp_once(val, lo, hi, unique_val, unique_lo, unique_hi) ({	\
-		typeof(val) unique_val = (val);				\
-		typeof(lo) unique_lo = (lo);				\
-		typeof(hi) unique_hi = (hi);				\
-		static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)), 	\
-				(lo) <= (hi), true),					\
-			"clamp() low limit " #lo " greater than high limit " #hi);	\
-		static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");	\
-		static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");	\
-		__clamp(unique_val, unique_lo, unique_hi); })
+#define __clamp_once(val, lo, hi, unique_val, unique_lo, unique_hi) ({		\
+	typeof(val) unique_val = (val);						\
+	typeof(lo) unique_lo = (lo);						\
+	typeof(hi) unique_hi = (hi);						\
+	static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)), 	\
+			(lo) <= (hi), true),					\
+		"clamp() low limit " #lo " greater than high limit " #hi);	\
+	static_assert(__types_ok(val, lo), "clamp() 'lo' signedness error");	\
+	static_assert(__types_ok(val, hi), "clamp() 'hi' signedness error");	\
+	__clamp(unique_val, unique_lo, unique_hi); })
 
 #define __careful_clamp(val, lo, hi) ({					\
 	__builtin_choose_expr(__is_constexpr((val) - (lo) + (hi)),	\
@@ -157,7 +161,7 @@
  * @x: first value
  * @y: second value
  */
-#define min_t(type, x, y)	__careful_cmp(min, (type)(x), (type)(y))
+#define min_t(type, x, y) __cmp_once(min, type, x, y)
 
 /**
  * max_t - return maximum of two values, using the specified type
@@ -165,7 +169,50 @@
  * @x: first value
  * @y: second value
  */
-#define max_t(type, x, y)	__careful_cmp(max, (type)(x), (type)(y))
+#define max_t(type, x, y) __cmp_once(max, type, x, y)
+
+/*
+ * Do not check the array parameter using __must_be_array().
+ * In the following legit use-case where the "array" passed is a simple pointer,
+ * __must_be_array() will return a failure.
+ * --- 8< ---
+ * int *buff
+ * ...
+ * min = min_array(buff, nb_items);
+ * --- 8< ---
+ *
+ * The first typeof(&(array)[0]) is needed in order to support arrays of both
+ * 'int *buff' and 'int buff[N]' types.
+ *
+ * The array can be an array of const items.
+ * typeof() keeps the const qualifier. Use __unqual_scalar_typeof() in order
+ * to discard the const qualifier for the __element variable.
+ */
+#define __minmax_array(op, array, len) ({				\
+	typeof(&(array)[0]) __array = (array);				\
+	typeof(len) __len = (len);					\
+	__unqual_scalar_typeof(__array[0]) __element = __array[--__len];\
+	while (__len--)							\
+		__element = op(__element, __array[__len]);		\
+	__element; })
+
+/**
+ * min_array - return minimum of values present in an array
+ * @array: array
+ * @len: array length
+ *
+ * Note that @len must not be zero (empty array).
+ */
+#define min_array(array, len) __minmax_array(min, array, len)
+
+/**
+ * max_array - return maximum of values present in an array
+ * @array: array
+ * @len: array length
+ *
+ * Note that @len must not be zero (empty array).
+ */
+#define max_array(array, len) __minmax_array(max, array, len)
 
 /**
  * clamp_t - return a value clamped to a given range using a given type
@@ -192,6 +239,32 @@
  */
 #define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
 
+static inline bool in_range64(u64 val, u64 start, u64 len)
+{
+	return (val - start) < len;
+}
+
+static inline bool in_range32(u32 val, u32 start, u32 len)
+{
+	return (val - start) < len;
+}
+
+/**
+ * in_range - Determine if a value lies within a range.
+ * @val: Value to test.
+ * @start: First value in range.
+ * @len: Number of values in range.
+ *
+ * This is more efficient than "if (start <= val && val < (start + len))".
+ * It also gives a different answer if @start + @len overflows the size of
+ * the type by a sufficient amount to encompass @val.  Decide for yourself
+ * which behaviour you want, or prove that start + len never overflow.
+ * Do not blindly replace one form with the other.
+ */
+#define in_range(val, start, len)					\
+	((sizeof(start) | sizeof(len) | sizeof(val)) <= sizeof(u32) ?	\
+		in_range32(val, start, len) : in_range64(val, start, len))
+
 /**
  * swap - swap values of @a and @b
  * @a: first value
@@ -200,4 +273,13 @@
 #define swap(a, b) \
 	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
 
+/*
+ * Use these carefully: no type checking, and uses the arguments
+ * multiple times. Use for obvious constants only.
+ */
+#define MIN(a,b) __cmp(min,a,b)
+#define MAX(a,b) __cmp(max,a,b)
+#define MIN_T(type,a,b) __cmp(min,(type)(a),(type)(b))
+#define MAX_T(type,a,b) __cmp(max,(type)(a),(type)(b))
+
 #endif	/* _LINUX_MINMAX_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9e17670de848..3bf7823e1097 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1782,6 +1782,60 @@ static inline int folio_estimated_sharers(struct folio *folio)
 	return page_mapcount(folio_page(folio, 0));
 }
 
+/**
+ * folio_expected_ref_count - calculate the expected folio refcount
+ * @folio: the folio
+ *
+ * Calculate the expected folio refcount, taking references from the pagecache,
+ * swapcache, PG_private and page table mappings into account. Useful in
+ * combination with folio_ref_count() to detect unexpected references (e.g.,
+ * GUP or other temporary references).
+ *
+ * Does currently not consider references from the LRU cache. If the folio
+ * was isolated from the LRU (which is the case during migration or split),
+ * the LRU cache does not apply.
+ *
+ * Calling this function on an unmapped folio -- !folio_mapped() -- that is
+ * locked will return a stable result.
+ *
+ * Calling this function on a mapped folio will not result in a stable result,
+ * because nothing stops additional page table mappings from coming (e.g.,
+ * fork()) or going (e.g., munmap()).
+ *
+ * Calling this function without the folio lock will also not result in a
+ * stable result: for example, the folio might get dropped from the swapcache
+ * concurrently.
+ *
+ * However, even when called without the folio lock or on a mapped folio,
+ * this function can be used to detect unexpected references early (for example,
+ * if it makes sense to even lock the folio and unmap it).
+ *
+ * The caller must add any reference (e.g., from folio_try_get()) it might be
+ * holding itself to the result.
+ *
+ * Returns the expected folio refcount.
+ */
+static inline int folio_expected_ref_count(struct folio *folio)
+{
+	const int order = folio_order(folio);
+	int ref_count = 0;
+
+	if (WARN_ON_ONCE(folio_test_slab(folio)))
+		return 0;
+
+	if (folio_test_anon(folio)) {
+		/* One reference per page from the swapcache. */
+		ref_count += folio_test_swapcache(folio) << order;
+	} else if (!((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS)) {
+		/* One reference per page from the pagecache. */
+		ref_count += !!folio->mapping << order;
+		/* One reference from PG_private. */
+		ref_count += folio_test_private(folio);
+	}
+
+	/* One reference per page table mapping. */
+	return ref_count + folio_mapcount(folio);
+}
 
 #ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
 static inline int arch_make_page_accessible(struct page *page)
diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index 5f1ae07d724b..ccec17a67af8 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -41,7 +41,7 @@ extern unsigned int pageblock_order;
  * Huge pages are a constant size, but don't exceed the maximum allocation
  * granularity.
  */
-#define pageblock_order		min_t(unsigned int, HUGETLB_PAGE_ORDER, MAX_ORDER - 1)
+#define pageblock_order		MIN_T(unsigned int, HUGETLB_PAGE_ORDER, MAX_ORDER - 1)
 
 #endif /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index add47f43e568..3eecf97dfbb8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -392,6 +392,16 @@ void lru_cache_add(struct page *);
 void mark_page_accessed(struct page *);
 void folio_mark_accessed(struct folio *);
 
+static inline bool folio_may_be_lru_cached(struct folio *folio)
+{
+	/*
+	 * Holding PMD-sized folios in per-CPU LRU cache unbalances accounting.
+	 * Holding small numbers of low-order mTHP folios in per-CPU LRU cache
+	 * will be sensible, but nobody has implemented and tested that yet.
+	 */
+	return !folio_test_large(folio);
+}
+
 extern atomic_t lru_disable_count;
 
 static inline bool lru_cache_disabled(void)
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 97cde23f56ec..4a1faf11785f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1140,6 +1140,27 @@ static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline struct hci_conn *hci_conn_hash_lookup_role(struct hci_dev *hdev,
+							 __u8 type, __u8 role,
+							 bdaddr_t *ba)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == type && c->role == role && !bacmp(&c->dst, ba)) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
 						       bdaddr_t *ba,
 						       __u8 ba_type)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ead1811534a0..276a0de9a1bb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5733,6 +5733,10 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 		verbose(env, "verifier bug. Two map pointers in a timer helper\n");
 		return -EFAULT;
 	}
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
+		return -EOPNOTSUPP;
+	}
 	meta->map_uid = reg->map_uid;
 	meta->map_ptr = map;
 	return 0;
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index cba8b1a6a4cc..7e43839ca7b0 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -223,18 +223,20 @@ static inline
 void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
 			   struct futex_hash_bucket *hb)
 {
-	q->key = *key;
+	struct task_struct *task;
 
+	q->key = *key;
 	__futex_unqueue(q);
 
 	WARN_ON(!q->rt_waiter);
 	q->rt_waiter = NULL;
 
 	q->lock_ptr = &hb->lock;
+	task = READ_ONCE(q->task);
 
 	/* Signal locked state to the waiter */
 	futex_requeue_pi_complete(q, 1);
-	wake_up_state(q->task, TASK_NORMAL);
+	wake_up_state(task, TASK_NORMAL);
 }
 
 /**
diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index 8af92dbe98f0..acb0c971a408 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -34,8 +34,6 @@ MODULE_PARM_DESC(cpu_affinity, "Cpu num test is running on");
 
 static struct completion done;
 
-#define MIN(x, y) ((x) < (y) ? (x) : (y))
-
 static void busy_wait(ulong time)
 {
 	u64 start, end;
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index c9b0533407ed..76737492e750 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -239,6 +239,10 @@ static int dyn_event_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	ret = tracing_check_open_get_tr(NULL);
 	if (ret)
 		return ret;
diff --git a/lib/btree.c b/lib/btree.c
index a82100c73b55..8407ff7dca1a 100644
--- a/lib/btree.c
+++ b/lib/btree.c
@@ -43,7 +43,6 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 
-#define MAX(a, b) ((a) > (b) ? (a) : (b))
 #define NODESIZE MAX(L1_CACHE_BYTES, 128)
 
 struct btree_geo {
diff --git a/lib/decompress_unlzma.c b/lib/decompress_unlzma.c
index 20a858031f12..9d34d35908da 100644
--- a/lib/decompress_unlzma.c
+++ b/lib/decompress_unlzma.c
@@ -37,7 +37,9 @@
 
 #include <linux/decompress/mm.h>
 
+#ifndef MIN
 #define	MIN(a, b) (((a) < (b)) ? (a) : (b))
+#endif
 
 static long long INIT read_int(unsigned char *ptr, int size)
 {
diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 07b4b9a1f54b..2ea564a40064 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -20,9 +20,6 @@
 static LIST_HEAD(io_range_list);
 static DEFINE_MUTEX(io_range_mutex);
 
-/* Consider a kernel general helper for this */
-#define in_range(b, first, len)        ((b) >= (first) && (b) < (first) + (len))
-
 /**
  * logic_pio_register_range - register logical PIO range for a host
  * @new_range: pointer to the IO range to be registered.
diff --git a/mm/gup.c b/mm/gup.c
index 37c55e61460e..b02993c9a8cd 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1961,14 +1961,14 @@ struct page *get_dump_page(unsigned long addr)
 /*
  * Returns the number of collected pages. Return value is always >= 0.
  */
-static void collect_longterm_unpinnable_pages(
+static unsigned long collect_longterm_unpinnable_pages(
 					struct list_head *movable_page_list,
 					unsigned long nr_pages,
 					struct page **pages)
 {
+	unsigned long i, collected = 0;
 	struct folio *prev_folio = NULL;
-	bool drain_allow = true;
-	unsigned long i;
+	int drained = 0;
 
 	for (i = 0; i < nr_pages; i++) {
 		struct folio *folio = page_folio(pages[i]);
@@ -1980,6 +1980,8 @@ static void collect_longterm_unpinnable_pages(
 		if (folio_is_longterm_pinnable(folio))
 			continue;
 
+		collected++;
+
 		if (folio_is_device_coherent(folio))
 			continue;
 
@@ -1988,9 +1990,17 @@ static void collect_longterm_unpinnable_pages(
 			continue;
 		}
 
-		if (!folio_test_lru(folio) && drain_allow) {
+		if (drained == 0 && folio_may_be_lru_cached(folio) &&
+				folio_ref_count(folio) !=
+				folio_expected_ref_count(folio) + 1) {
+			lru_add_drain();
+			drained = 1;
+		}
+		if (drained == 1 && folio_may_be_lru_cached(folio) &&
+				folio_ref_count(folio) !=
+				folio_expected_ref_count(folio) + 1) {
 			lru_add_drain_all();
-			drain_allow = false;
+			drained = 2;
 		}
 
 		if (folio_isolate_lru(folio))
@@ -2001,6 +2011,8 @@ static void collect_longterm_unpinnable_pages(
 				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
 				    folio_nr_pages(folio));
 	}
+
+	return collected;
 }
 
 /*
@@ -2093,10 +2105,12 @@ static int migrate_longterm_unpinnable_pages(
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages)
 {
+	unsigned long collected;
 	LIST_HEAD(movable_page_list);
 
-	collect_longterm_unpinnable_pages(&movable_page_list, nr_pages, pages);
-	if (list_empty(&movable_page_list))
+	collected = collect_longterm_unpinnable_pages(&movable_page_list,
+						nr_pages, pages);
+	if (!collected)
 		return 0;
 
 	return migrate_longterm_unpinnable_pages(&movable_page_list, nr_pages,
diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index dff759f32bbb..ea5a06fe94f9 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -258,7 +258,8 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
 				      u32 origin, bool checked)
 {
 	u64 address = (u64)addr;
-	u32 *shadow_start, *origin_start;
+	void *shadow_start;
+	u32 *aligned_shadow, *origin_start;
 	size_t pad = 0;
 
 	KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(addr, size));
@@ -277,9 +278,12 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
 	}
 	__memset(shadow_start, b, size);
 
-	if (!IS_ALIGNED(address, KMSAN_ORIGIN_SIZE)) {
+	if (IS_ALIGNED(address, KMSAN_ORIGIN_SIZE)) {
+		aligned_shadow = shadow_start;
+	} else {
 		pad = address % KMSAN_ORIGIN_SIZE;
 		address -= pad;
+		aligned_shadow = shadow_start - pad;
 		size += pad;
 	}
 	size = ALIGN(size, KMSAN_ORIGIN_SIZE);
@@ -293,7 +297,7 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
 	 * corresponding shadow slot is zero.
 	 */
 	for (int i = 0; i < size / KMSAN_ORIGIN_SIZE; i++) {
-		if (origin || !shadow_start[i])
+		if (origin || !aligned_shadow[i])
 			origin_start[i] = origin;
 	}
 }
diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 1328636cbd6c..bc2a460000ff 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -470,6 +470,21 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
 
+/* Test case: ensure that KMSAN does not access shadow memory out of bounds. */
+static void test_memset_on_guarded_buffer(struct kunit *test)
+{
+	void *buf = vmalloc(PAGE_SIZE);
+
+	kunit_info(test,
+		   "memset() on ends of guarded buffer should not crash\n");
+
+	for (size_t size = 0; size <= 128; size++) {
+		memset(buf, 0xff, size);
+		memset(buf + PAGE_SIZE - size, 0xff, size);
+	}
+	vfree(buf);
+}
+
 static noinline void fibonacci(int *array, int size, int start) {
 	if (start < 2 || (start == size))
 		return;
@@ -515,6 +530,7 @@ static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_memcpy_aligned_to_aligned),
 	KUNIT_CASE(test_memcpy_aligned_to_unaligned),
 	KUNIT_CASE(test_memcpy_aligned_to_unaligned2),
+	KUNIT_CASE(test_memset_on_guarded_buffer),
 	KUNIT_CASE(test_long_origin_chain),
 	{},
 };
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 721b2365dbca..afe3b2d2e7b9 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -829,42 +829,40 @@ void migrate_device_finalize(unsigned long *src_pfns,
 	unsigned long i;
 
 	for (i = 0; i < npages; i++) {
-		struct folio *dst, *src;
+		struct folio *dst = NULL, *src = NULL;
 		struct page *newpage = migrate_pfn_to_page(dst_pfns[i]);
 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
 
+		if (newpage)
+			dst = page_folio(newpage);
+
 		if (!page) {
-			if (newpage) {
-				unlock_page(newpage);
-				put_page(newpage);
+			if (dst) {
+				folio_unlock(dst);
+				folio_put(dst);
 			}
 			continue;
 		}
 
-		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE) || !newpage) {
-			if (newpage) {
-				unlock_page(newpage);
-				put_page(newpage);
+		src = page_folio(page);
+
+		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE) || !dst) {
+			if (dst) {
+				folio_unlock(dst);
+				folio_put(dst);
 			}
-			newpage = page;
+			dst = src;
 		}
 
-		src = page_folio(page);
-		dst = page_folio(newpage);
+		if (!folio_is_zone_device(dst))
+			folio_add_lru(dst);
 		remove_migration_ptes(src, dst, false);
 		folio_unlock(src);
+		folio_put(src);
 
-		if (is_zone_device_page(page))
-			put_page(page);
-		else
-			putback_lru_page(page);
-
-		if (newpage != page) {
-			unlock_page(newpage);
-			if (is_zone_device_page(newpage))
-				put_page(newpage);
-			else
-				putback_lru_page(newpage);
+		if (dst != src) {
+			folio_unlock(dst);
+			folio_put(dst);
 		}
 	}
 }
diff --git a/mm/mlock.c b/mm/mlock.c
index 7032f6dd0ce1..3bf9e1d263da 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -256,7 +256,7 @@ void mlock_folio(struct folio *folio)
 
 	folio_get(folio);
 	if (!pagevec_add(pvec, mlock_lru(&folio->page)) ||
-	    folio_test_large(folio) || lru_cache_disabled())
+	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_pagevec(pvec);
 	local_unlock(&mlock_pvec.lock);
 }
diff --git a/mm/swap.c b/mm/swap.c
index 85aa04fc48a6..e0fdf2535000 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -249,8 +249,8 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 static void folio_batch_add_and_move(struct folio_batch *fbatch,
 		struct folio *folio, move_fn_t move_fn)
 {
-	if (folio_batch_add(fbatch, folio) && !folio_test_large(folio) &&
-	    !lru_cache_disabled())
+	if (folio_batch_add(fbatch, folio) &&
+	    folio_may_be_lru_cached(folio) && !lru_cache_disabled())
 		return;
 	folio_batch_move_lru(fbatch, move_fn);
 }
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index af130e2dcea2..aede005d1adc 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -123,7 +123,6 @@
 #define ISOLATED_BITS	3
 #define MAGIC_VAL_BITS	8
 
-#define MAX(a, b) ((a) >= (b) ? (a) : (b))
 /* ZS_MIN_ALLOC_SIZE must be multiple of ZS_ALIGN */
 #define ZS_MIN_ALLOC_SIZE \
 	MAX(32, (ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT >> OBJ_INDEX_BITS))
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3d81afcccff8..a0ce0a1e3258 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3125,8 +3125,18 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	/* Check for existing connection:
+	 *
+	 * 1. If it doesn't exist then it must be receiver/slave role.
+	 * 2. If it does exist confirm that it is connecting/BT_CONNECT in case
+	 *    of initiator/master role since there could be a collision where
+	 *    either side is attempting to connect or something like a fuzzing
+	 *    testing is trying to play tricks to destroy the hcon object before
+	 *    it even attempts to connect (e.g. hcon->state == BT_OPEN).
+	 */
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
-	if (!conn) {
+	if (!conn ||
+	    (conn->role == HCI_ROLE_MASTER && conn->state != BT_CONNECT)) {
 		/* In case of error status and there is no connection pending
 		 * just unlock as there is nothing to cleanup.
 		 */
@@ -5706,8 +5716,18 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	 */
 	hci_dev_clear_flag(hdev, HCI_LE_ADV);
 
-	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, bdaddr);
-	if (!conn) {
+	/* Check for existing connection:
+	 *
+	 * 1. If it doesn't exist then use the role to create a new object.
+	 * 2. If it does exist confirm that it is connecting/BT_CONNECT in case
+	 *    of initiator/master role since there could be a collision where
+	 *    either side is attempting to connect or something like a fuzzing
+	 *    testing is trying to play tricks to destroy the hcon object before
+	 *    it even attempts to connect (e.g. hcon->state == BT_OPEN).
+	 */
+	conn = hci_conn_hash_lookup_role(hdev, LE_LINK, role, bdaddr);
+	if (!conn ||
+	    (conn->role == HCI_ROLE_MASTER && conn->state != BT_CONNECT)) {
 		/* In case of error status and there is no connection pending
 		 * just unlock as there is nothing to cleanup.
 		 */
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a2c3b58db54c..4c1b2468989a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2595,6 +2595,13 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 			hci_remove_ext_adv_instance_sync(hdev, adv->instance,
 							 NULL);
 		}
+
+		/* If current advertising instance is set to instance 0x00
+		 * then we need to re-enable it.
+		 */
+		if (!hdev->cur_adv_instance)
+			err = hci_enable_ext_advertising_sync(hdev,
+							      hdev->cur_adv_instance);
 	} else {
 		/* Schedule for most recent instance to be restarted and begin
 		 * the software rotation loop
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index bba955d82f72..c0f9d125f401 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2113,6 +2113,13 @@ static int replace_nexthop_single(struct net *net, struct nexthop *old,
 		return -EINVAL;
 	}
 
+	if (!list_empty(&old->grp_list) &&
+	    rtnl_dereference(new->nh_info)->fdb_nh !=
+	    rtnl_dereference(old->nh_info)->fdb_nh) {
+		NL_SET_ERR_MSG(extack, "Cannot change nexthop FDB status while in a group");
+		return -EINVAL;
+	}
+
 	err = call_nexthop_notifiers(net, NEXTHOP_EVENT_REPLACE, new, extack);
 	if (err)
 		return err;
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 1f52c5f2d347..234b2e56be4f 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -43,7 +43,7 @@
 #include <net/sock.h>
 #include <net/raw.h>
 
-#define TCPUDP_MIB_MAX max_t(u32, UDP_MIB_MAX, TCP_MIB_MAX)
+#define TCPUDP_MIB_MAX MAX_T(u32, UDP_MIB_MAX, TCP_MIB_MAX)
 
 /*
  *	Report socket allocation statistics [mea@utu.fi]
diff --git a/net/ipv6/proc.c b/net/ipv6/proc.c
index e20b3705c2d2..5e01863be039 100644
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -27,7 +27,7 @@
 #include <net/ipv6.h>
 
 #define MAX4(a, b, c, d) \
-	max_t(u32, max_t(u32, a, b), max_t(u32, c, d))
+	MAX_T(u32, MAX_T(u32, a, b), MAX_T(u32, c, d))
 #define SNMP_MIB_MAX MAX4(UDP_MIB_MAX, TCP_MIB_MAX, \
 			IPSTATS_MIB_MAX, ICMP_MIB_MAX)
 
diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index e29e4ccb5c5a..6b683ff015b9 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -242,7 +242,7 @@ static bool l4proto_in_range(const struct nf_conntrack_tuple *tuple,
 /* If we source map this tuple so reply looks like reply_tuple, will
  * that meet the constraints of range.
  */
-static int in_range(const struct nf_conntrack_tuple *tuple,
+static int nf_in_range(const struct nf_conntrack_tuple *tuple,
 		    const struct nf_nat_range2 *range)
 {
 	/* If we are supposed to map IPs, then we must be in the
@@ -291,7 +291,7 @@ find_appropriate_src(struct net *net,
 				       &ct->tuplehash[IP_CT_DIR_REPLY].tuple);
 			result->dst = tuple->dst;
 
-			if (in_range(result, range))
+			if (nf_in_range(result, range))
 				return 1;
 		}
 	}
@@ -523,7 +523,7 @@ get_unique_tuple(struct nf_conntrack_tuple *tuple,
 	if (maniptype == NF_NAT_MANIP_SRC &&
 	    !(range->flags & NF_NAT_RANGE_PROTO_RANDOM_ALL)) {
 		/* try the original tuple first */
-		if (in_range(orig_tuple, range)) {
+		if (nf_in_range(orig_tuple, range)) {
 			if (!nf_nat_used_tuple(orig_tuple, ct)) {
 				*tuple = *orig_tuple;
 				return;
diff --git a/net/tipc/core.h b/net/tipc/core.h
index 0a3f7a70a50a..7eccd97e0609 100644
--- a/net/tipc/core.h
+++ b/net/tipc/core.h
@@ -197,7 +197,7 @@ static inline int less(u16 left, u16 right)
 	return less_eq(left, right) && (mod(right) != mod(left));
 }
 
-static inline int in_range(u16 val, u16 min, u16 max)
+static inline int tipc_in_range(u16 val, u16 min, u16 max)
 {
 	return !less(val, min) && !more(val, max);
 }
diff --git a/net/tipc/link.c b/net/tipc/link.c
index d6a8f0aa531b..6c6d8546c578 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1624,7 +1624,7 @@ static int tipc_link_advance_transmq(struct tipc_link *l, struct tipc_link *r,
 					  last_ga->bgack_cnt);
 			}
 			/* Check against the last Gap ACK block */
-			if (in_range(seqno, start, end))
+			if (tipc_in_range(seqno, start, end))
 				continue;
 			/* Update/release the packet peer is acking */
 			bc_has_acked = true;
@@ -2252,12 +2252,12 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 		strncpy(if_name, data, TIPC_MAX_IF_NAME);
 
 		/* Update own tolerance if peer indicates a non-zero value */
-		if (in_range(peers_tol, TIPC_MIN_LINK_TOL, TIPC_MAX_LINK_TOL)) {
+		if (tipc_in_range(peers_tol, TIPC_MIN_LINK_TOL, TIPC_MAX_LINK_TOL)) {
 			l->tolerance = peers_tol;
 			l->bc_rcvlink->tolerance = peers_tol;
 		}
 		/* Update own priority if peer's priority is higher */
-		if (in_range(peers_prio, l->priority + 1, TIPC_MAX_LINK_PRI))
+		if (tipc_in_range(peers_prio, l->priority + 1, TIPC_MAX_LINK_PRI))
 			l->priority = peers_prio;
 
 		/* If peer is going down we want full re-establish cycle */
@@ -2300,13 +2300,13 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 		l->rcv_nxt_state = msg_seqno(hdr) + 1;
 
 		/* Update own tolerance if peer indicates a non-zero value */
-		if (in_range(peers_tol, TIPC_MIN_LINK_TOL, TIPC_MAX_LINK_TOL)) {
+		if (tipc_in_range(peers_tol, TIPC_MIN_LINK_TOL, TIPC_MAX_LINK_TOL)) {
 			l->tolerance = peers_tol;
 			l->bc_rcvlink->tolerance = peers_tol;
 		}
 		/* Update own prio if peer indicates a different value */
 		if ((peers_prio != l->priority) &&
-		    in_range(peers_prio, 1, TIPC_MAX_LINK_PRI)) {
+		    tipc_in_range(peers_prio, 1, TIPC_MAX_LINK_PRI)) {
 			l->priority = peers_prio;
 			rc = tipc_link_fsm_evt(l, LINK_FAILURE_EVT);
 		}
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 68c82e344d3b..270a0be672b7 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -16,6 +16,7 @@
 
 #include <linux/hid.h>
 #include <linux/init.h>
+#include <linux/input.h>
 #include <linux/math64.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
@@ -76,7 +77,8 @@ static int snd_create_std_mono_ctl_offset(struct usb_mixer_interface *mixer,
 	cval->idx_off = idx_off;
 
 	/* get_min_max() is called only for integer volumes later,
-	 * so provide a short-cut for booleans */
+	 * so provide a short-cut for booleans
+	 */
 	cval->min = 0;
 	cval->max = 1;
 	cval->res = 0;
@@ -125,7 +127,7 @@ static int snd_create_std_mono_table(struct usb_mixer_interface *mixer,
 {
 	int err;
 
-	while (t->name != NULL) {
+	while (t->name) {
 		err = snd_create_std_mono_ctl(mixer, t->unitid, t->control,
 				t->cmask, t->val_type, t->name, t->tlv_callback);
 		if (err < 0)
@@ -207,7 +209,6 @@ static void snd_usb_soundblaster_remote_complete(struct urb *urb)
 	if (code == rc->mute_code)
 		snd_usb_mixer_notify_id(mixer, rc->mute_mixer_id);
 	mixer->rc_code = code;
-	wmb();
 	wake_up(&mixer->rc_waitq);
 }
 
@@ -375,10 +376,10 @@ static int snd_audigy2nx_controls_create(struct usb_mixer_interface *mixer)
 		struct snd_kcontrol_new knew;
 
 		/* USB X-Fi S51 doesn't have a CMSS LED */
-		if ((mixer->chip->usb_id == USB_ID(0x041e, 0x3042)) && i == 0)
+		if (mixer->chip->usb_id == USB_ID(0x041e, 0x3042) && i == 0)
 			continue;
 		/* USB X-Fi S51 Pro doesn't have one either */
-		if ((mixer->chip->usb_id == USB_ID(0x041e, 0x30df)) && i == 0)
+		if (mixer->chip->usb_id == USB_ID(0x041e, 0x30df) && i == 0)
 			continue;
 		if (i > 1 && /* Live24ext has 2 LEDs only */
 			(mixer->chip->usb_id == USB_ID(0x041e, 0x3040) ||
@@ -527,6 +528,265 @@ static int snd_emu0204_controls_create(struct usb_mixer_interface *mixer)
 					  &snd_emu0204_control, NULL);
 }
 
+#if IS_REACHABLE(CONFIG_INPUT)
+/*
+ * Sony DualSense controller (PS5) jack detection
+ *
+ * Since this is an UAC 1 device, it doesn't support jack detection.
+ * However, the controller hid-playstation driver reports HP & MIC
+ * insert events through a dedicated input device.
+ */
+
+#define SND_DUALSENSE_JACK_OUT_TERM_ID 3
+#define SND_DUALSENSE_JACK_IN_TERM_ID 4
+
+struct dualsense_mixer_elem_info {
+	struct usb_mixer_elem_info info;
+	struct input_handler ih;
+	struct input_device_id id_table[2];
+	bool connected;
+};
+
+static void snd_dualsense_ih_event(struct input_handle *handle,
+				   unsigned int type, unsigned int code,
+				   int value)
+{
+	struct dualsense_mixer_elem_info *mei;
+	struct usb_mixer_elem_list *me;
+
+	if (type != EV_SW)
+		return;
+
+	mei = container_of(handle->handler, struct dualsense_mixer_elem_info, ih);
+	me = &mei->info.head;
+
+	if ((me->id == SND_DUALSENSE_JACK_OUT_TERM_ID && code == SW_HEADPHONE_INSERT) ||
+	    (me->id == SND_DUALSENSE_JACK_IN_TERM_ID && code == SW_MICROPHONE_INSERT)) {
+		mei->connected = !!value;
+		snd_ctl_notify(me->mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &me->kctl->id);
+	}
+}
+
+static bool snd_dualsense_ih_match(struct input_handler *handler,
+				   struct input_dev *dev)
+{
+	struct dualsense_mixer_elem_info *mei;
+	struct usb_device *snd_dev;
+	char *input_dev_path, *usb_dev_path;
+	size_t usb_dev_path_len;
+	bool match = false;
+
+	mei = container_of(handler, struct dualsense_mixer_elem_info, ih);
+	snd_dev = mei->info.head.mixer->chip->dev;
+
+	input_dev_path = kobject_get_path(&dev->dev.kobj, GFP_KERNEL);
+	if (!input_dev_path) {
+		dev_warn(&snd_dev->dev, "Failed to get input dev path\n");
+		return false;
+	}
+
+	usb_dev_path = kobject_get_path(&snd_dev->dev.kobj, GFP_KERNEL);
+	if (!usb_dev_path) {
+		dev_warn(&snd_dev->dev, "Failed to get USB dev path\n");
+		goto free_paths;
+	}
+
+	/*
+	 * Ensure the VID:PID matched input device supposedly owned by the
+	 * hid-playstation driver belongs to the actual hardware handled by
+	 * the current USB audio device, which implies input_dev_path being
+	 * a subpath of usb_dev_path.
+	 *
+	 * This verification is necessary when there is more than one identical
+	 * controller attached to the host system.
+	 */
+	usb_dev_path_len = strlen(usb_dev_path);
+	if (usb_dev_path_len >= strlen(input_dev_path))
+		goto free_paths;
+
+	usb_dev_path[usb_dev_path_len] = '/';
+	match = !memcmp(input_dev_path, usb_dev_path, usb_dev_path_len + 1);
+
+free_paths:
+	kfree(input_dev_path);
+	kfree(usb_dev_path);
+
+	return match;
+}
+
+static int snd_dualsense_ih_connect(struct input_handler *handler,
+				    struct input_dev *dev,
+				    const struct input_device_id *id)
+{
+	struct input_handle *handle;
+	int err;
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev = dev;
+	handle->handler = handler;
+	handle->name = handler->name;
+
+	err = input_register_handle(handle);
+	if (err)
+		goto err_free;
+
+	err = input_open_device(handle);
+	if (err)
+		goto err_unregister;
+
+	return 0;
+
+err_unregister:
+	input_unregister_handle(handle);
+err_free:
+	kfree(handle);
+	return err;
+}
+
+static void snd_dualsense_ih_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+static void snd_dualsense_ih_start(struct input_handle *handle)
+{
+	struct dualsense_mixer_elem_info *mei;
+	struct usb_mixer_elem_list *me;
+	int status = -1;
+
+	mei = container_of(handle->handler, struct dualsense_mixer_elem_info, ih);
+	me = &mei->info.head;
+
+	if (me->id == SND_DUALSENSE_JACK_OUT_TERM_ID &&
+	    test_bit(SW_HEADPHONE_INSERT, handle->dev->swbit))
+		status = test_bit(SW_HEADPHONE_INSERT, handle->dev->sw);
+	else if (me->id == SND_DUALSENSE_JACK_IN_TERM_ID &&
+		 test_bit(SW_MICROPHONE_INSERT, handle->dev->swbit))
+		status = test_bit(SW_MICROPHONE_INSERT, handle->dev->sw);
+
+	if (status >= 0) {
+		mei->connected = !!status;
+		snd_ctl_notify(me->mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &me->kctl->id);
+	}
+}
+
+static int snd_dualsense_jack_get(struct snd_kcontrol *kctl,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct dualsense_mixer_elem_info *mei = snd_kcontrol_chip(kctl);
+
+	ucontrol->value.integer.value[0] = mei->connected;
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new snd_dualsense_jack_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.access = SNDRV_CTL_ELEM_ACCESS_READ,
+	.info = snd_ctl_boolean_mono_info,
+	.get = snd_dualsense_jack_get,
+};
+
+static int snd_dualsense_resume_jack(struct usb_mixer_elem_list *list)
+{
+	snd_ctl_notify(list->mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+		       &list->kctl->id);
+	return 0;
+}
+
+static void snd_dualsense_mixer_elem_free(struct snd_kcontrol *kctl)
+{
+	struct dualsense_mixer_elem_info *mei = snd_kcontrol_chip(kctl);
+
+	if (mei->ih.event)
+		input_unregister_handler(&mei->ih);
+
+	snd_usb_mixer_elem_free(kctl);
+}
+
+static int snd_dualsense_jack_create(struct usb_mixer_interface *mixer,
+				     const char *name, bool is_output)
+{
+	struct dualsense_mixer_elem_info *mei;
+	struct input_device_id *idev_id;
+	struct snd_kcontrol *kctl;
+	int err;
+
+	mei = kzalloc(sizeof(*mei), GFP_KERNEL);
+	if (!mei)
+		return -ENOMEM;
+
+	snd_usb_mixer_elem_init_std(&mei->info.head, mixer,
+				    is_output ? SND_DUALSENSE_JACK_OUT_TERM_ID :
+						SND_DUALSENSE_JACK_IN_TERM_ID);
+
+	mei->info.head.resume = snd_dualsense_resume_jack;
+	mei->info.val_type = USB_MIXER_BOOLEAN;
+	mei->info.channels = 1;
+	mei->info.min = 0;
+	mei->info.max = 1;
+
+	kctl = snd_ctl_new1(&snd_dualsense_jack_control, mei);
+	if (!kctl) {
+		kfree(mei);
+		return -ENOMEM;
+	}
+
+	strscpy(kctl->id.name, name, sizeof(kctl->id.name));
+	kctl->private_free = snd_dualsense_mixer_elem_free;
+
+	err = snd_usb_mixer_add_control(&mei->info.head, kctl);
+	if (err)
+		return err;
+
+	idev_id = &mei->id_table[0];
+	idev_id->flags = INPUT_DEVICE_ID_MATCH_VENDOR | INPUT_DEVICE_ID_MATCH_PRODUCT |
+			 INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_SWBIT;
+	idev_id->vendor = USB_ID_VENDOR(mixer->chip->usb_id);
+	idev_id->product = USB_ID_PRODUCT(mixer->chip->usb_id);
+	idev_id->evbit[BIT_WORD(EV_SW)] = BIT_MASK(EV_SW);
+	if (is_output)
+		idev_id->swbit[BIT_WORD(SW_HEADPHONE_INSERT)] = BIT_MASK(SW_HEADPHONE_INSERT);
+	else
+		idev_id->swbit[BIT_WORD(SW_MICROPHONE_INSERT)] = BIT_MASK(SW_MICROPHONE_INSERT);
+
+	mei->ih.event = snd_dualsense_ih_event;
+	mei->ih.match = snd_dualsense_ih_match;
+	mei->ih.connect = snd_dualsense_ih_connect;
+	mei->ih.disconnect = snd_dualsense_ih_disconnect;
+	mei->ih.start = snd_dualsense_ih_start;
+	mei->ih.name = name;
+	mei->ih.id_table = mei->id_table;
+
+	err = input_register_handler(&mei->ih);
+	if (err) {
+		dev_warn(&mixer->chip->dev->dev,
+			 "Could not register input handler: %d\n", err);
+		mei->ih.event = NULL;
+	}
+
+	return 0;
+}
+
+static int snd_dualsense_controls_create(struct usb_mixer_interface *mixer)
+{
+	int err;
+
+	err = snd_dualsense_jack_create(mixer, "Headphone Jack", true);
+	if (err < 0)
+		return err;
+
+	return snd_dualsense_jack_create(mixer, "Headset Mic Jack", false);
+}
+#endif /* IS_REACHABLE(CONFIG_INPUT) */
+
 /* ASUS Xonar U1 / U3 controls */
 
 static int snd_xonar_u1_switch_get(struct snd_kcontrol *kcontrol,
@@ -1733,7 +1993,8 @@ static int snd_microii_spdif_default_put(struct snd_kcontrol *kcontrol,
 	unsigned int pval, pval_old;
 	int err;
 
-	pval = pval_old = kcontrol->private_value;
+	pval = kcontrol->private_value;
+	pval_old = pval;
 	pval &= 0xfffff0f0;
 	pval |= (ucontrol->value.iec958.status[1] & 0x0f) << 8;
 	pval |= (ucontrol->value.iec958.status[0] & 0x0f);
@@ -3271,7 +3532,7 @@ static int snd_djm_controls_update(struct usb_mixer_interface *mixer,
 	int err;
 	const struct snd_djm_device *device = &snd_djm_devices[device_idx];
 
-	if ((group >= device->ncontrols) || value >= device->controls[group].noptions)
+	if (group >= device->ncontrols || value >= device->controls[group].noptions)
 		return -EINVAL;
 
 	err = snd_usb_lock_shutdown(mixer->chip);
@@ -3389,6 +3650,13 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_emu0204_controls_create(mixer);
 		break;
 
+#if IS_REACHABLE(CONFIG_INPUT)
+	case USB_ID(0x054c, 0x0ce6): /* Sony DualSense controller (PS5) */
+	case USB_ID(0x054c, 0x0df2): /* Sony DualSense Edge controller (PS5) */
+		err = snd_dualsense_controls_create(mixer);
+		break;
+#endif /* IS_REACHABLE(CONFIG_INPUT) */
+
 	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
 	case USB_ID(0x0763, 0x2031): /* M-Audio Fast Track C400 */
 		err = snd_c400_create_mixer(mixer);
@@ -3546,7 +3814,8 @@ static void snd_dragonfly_quirk_db_scale(struct usb_mixer_interface *mixer,
 					 struct snd_kcontrol *kctl)
 {
 	/* Approximation using 10 ranges based on output measurement on hw v1.2.
-	 * This seems close to the cubic mapping e.g. alsamixer uses. */
+	 * This seems close to the cubic mapping e.g. alsamixer uses.
+	 */
 	static const DECLARE_TLV_DB_RANGE(scale,
 		 0,  1, TLV_DB_MINMAX_ITEM(-5300, -4970),
 		 2,  5, TLV_DB_MINMAX_ITEM(-4710, -4160),
@@ -3630,16 +3899,12 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 		if (unitid == 7 && cval->control == UAC_FU_VOLUME)
 			snd_dragonfly_quirk_db_scale(mixer, cval, kctl);
 		break;
+	}
+
 	/* lowest playback value is muted on some devices */
-	case USB_ID(0x0572, 0x1b09): /* Conexant Systems (Rockwell), Inc. */
-	case USB_ID(0x0d8c, 0x000c): /* C-Media */
-	case USB_ID(0x0d8c, 0x0014): /* C-Media */
-	case USB_ID(0x19f7, 0x0003): /* RODE NT-USB */
-	case USB_ID(0x2d99, 0x0026): /* HECATE G2 GAMING HEADSET */
+	if (mixer->chip->quirk_flags & QUIRK_FLAG_MIXER_MIN_MUTE)
 		if (strstr(kctl->id.name, "Playback"))
 			cval->min_mute = 1;
-		break;
-	}
 
 	/* ALSA-ify some Plantronics headset control names */
 	if (USB_ID_VENDOR(mixer->chip->usb_id) == 0x047f &&
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index ac43bdf6e9ca..2a862785fd93 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2094,6 +2094,10 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_SET_IFACE_FIRST),
 	DEVICE_FLG(0x0556, 0x0014, /* Phoenix Audio TMX320VC */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x0572, 0x1b08, /* Conexant Systems (Rockwell), Inc. */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
+	DEVICE_FLG(0x0572, 0x1b09, /* Conexant Systems (Rockwell), Inc. */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x05a3, 0x9420, /* ELP HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x05a7, 0x1020, /* Bose Companion 5 */
@@ -2136,12 +2140,16 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0b0e, 0x0349, /* Jabra 550a */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x0bda, 0x498a, /* Realtek Semiconductor Corp. */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0c45, 0x636b, /* Microdia JP001 USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
-	DEVICE_FLG(0x0d8c, 0x0014, /* USB Audio Device */
-		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x0d8c, 0x000c, /* C-Media */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
+	DEVICE_FLG(0x0d8c, 0x0014, /* C-Media */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
@@ -2150,6 +2158,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x1101, 0x0003, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x12d1, 0x3a07, /* Huawei Technologies Co., Ltd. */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */
@@ -2188,6 +2198,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x1901, 0x0191, /* GE B850V3 CP2114 audio interface */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x19f7, 0x0003, /* RODE NT-USB */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x19f7, 0x0035, /* RODE NT-USB+ */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1bcf, 0x2281, /* HD Webcam */
@@ -2238,6 +2250,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x2a70, 0x1881, /* OnePlus Technology (Shenzhen) Co., Ltd. BE02T */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x2b53, 0x0023, /* Fiero SC-01 (firmware v1.0.0 @ 48 kHz) */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x2b53, 0x0024, /* Fiero SC-01 (firmware v1.0.0 @ 96 kHz) */
@@ -2248,10 +2262,14 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x2d95, 0x8021, /* VIVO USB-C-XE710 HEADSET */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x2d99, 0x0026, /* HECATE G2 GAMING HEADSET */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x2fc6, 0xf0b7, /* iBasso DC07 Pro */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x30be, 0x0101, /* Schiit Hel */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
+	DEVICE_FLG(0x339b, 0x3a07, /* Synaptics HONOR USB-C HEADSET */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x413c, 0xa506, /* Dell AE515 sound bar */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x534d, 0x0021, /* MacroSilicon MS2100/MS2106 */
@@ -2303,6 +2321,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x2d87, /* Cayin device */
 		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x2fc6, /* Comture-inc devices */
+		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3336, /* HEM devices */
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3353, /* Khadas devices */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 65dcb1a02e97..17db6a7f3a84 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -180,6 +180,9 @@ extern bool snd_usb_skip_validation;
  *  for the given endpoint.
  * QUIRK_FLAG_MIC_RES_16 and QUIRK_FLAG_MIC_RES_384
  *  Set the fixed resolution for Mic Capture Volume (mostly for webcams)
+ * QUIRK_FLAG_MIXER_MIN_MUTE
+ *  Set minimum volume control value as mute for devices where the lowest
+ *  playback value represents muted state instead of minimum audible volume
  */
 
 #define QUIRK_FLAG_GET_SAMPLE_RATE	(1U << 0)
@@ -206,5 +209,6 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_FIXED_RATE		(1U << 21)
 #define QUIRK_FLAG_MIC_RES_16		(1U << 22)
 #define QUIRK_FLAG_MIC_RES_384		(1U << 23)
+#define QUIRK_FLAG_MIXER_MIN_MUTE	(1U << 24)
 
 #endif /* __USBAUDIO_H */
diff --git a/tools/testing/selftests/bpf/progs/get_branch_snapshot.c b/tools/testing/selftests/bpf/progs/get_branch_snapshot.c
index a1b139888048..511ac634eef0 100644
--- a/tools/testing/selftests/bpf/progs/get_branch_snapshot.c
+++ b/tools/testing/selftests/bpf/progs/get_branch_snapshot.c
@@ -15,7 +15,7 @@ long total_entries = 0;
 #define ENTRY_CNT 32
 struct perf_branch_entry entries[ENTRY_CNT] = {};
 
-static inline bool in_range(__u64 val)
+static inline bool gbs_in_range(__u64 val)
 {
 	return (val >= address_low) && (val < address_high);
 }
@@ -31,7 +31,7 @@ int BPF_PROG(test1, int n, int ret)
 	for (i = 0; i < ENTRY_CNT; i++) {
 		if (i >= total_entries)
 			break;
-		if (in_range(entries[i].from) && in_range(entries[i].to))
+		if (gbs_in_range(entries[i].from) && gbs_in_range(entries[i].to))
 			test1_hits++;
 		else if (!test1_hits)
 			wasted_entries++;
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index df8d90b51867..543a35e5c9df 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -441,8 +441,8 @@ ipv6_fdb_grp_fcnal()
 	log_test $? 0 "Get Fdb nexthop group by id"
 
 	# fdb nexthop group can only contain fdb nexthops
-	run_cmd "$IP nexthop add id 63 via 2001:db8:91::4"
-	run_cmd "$IP nexthop add id 64 via 2001:db8:91::5"
+	run_cmd "$IP nexthop add id 63 via 2001:db8:91::4 dev veth1"
+	run_cmd "$IP nexthop add id 64 via 2001:db8:91::5 dev veth1"
 	run_cmd "$IP nexthop add id 103 group 63/64 fdb"
 	log_test $? 2 "Fdb Nexthop group with non-fdb nexthops"
 
@@ -521,15 +521,15 @@ ipv4_fdb_grp_fcnal()
 	log_test $? 0 "Get Fdb nexthop group by id"
 
 	# fdb nexthop group can only contain fdb nexthops
-	run_cmd "$IP nexthop add id 14 via 172.16.1.2"
-	run_cmd "$IP nexthop add id 15 via 172.16.1.3"
+	run_cmd "$IP nexthop add id 14 via 172.16.1.2 dev veth1"
+	run_cmd "$IP nexthop add id 15 via 172.16.1.3 dev veth1"
 	run_cmd "$IP nexthop add id 103 group 14/15 fdb"
 	log_test $? 2 "Fdb Nexthop group with non-fdb nexthops"
 
 	# Non fdb nexthop group can not contain fdb nexthops
 	run_cmd "$IP nexthop add id 16 via 172.16.1.2 fdb"
 	run_cmd "$IP nexthop add id 17 via 172.16.1.3 fdb"
-	run_cmd "$IP nexthop add id 104 group 14/15"
+	run_cmd "$IP nexthop add id 104 group 16/17"
 	log_test $? 2 "Non-Fdb Nexthop group with fdb nexthops"
 
 	# fdb nexthop cannot have blackhole
@@ -556,7 +556,7 @@ ipv4_fdb_grp_fcnal()
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:14 dev vx10 nhid 12 self"
 	log_test $? 255 "Fdb mac add with nexthop"
 
-	run_cmd "$IP ro add 172.16.0.0/22 nhid 15"
+	run_cmd "$IP ro add 172.16.0.0/22 nhid 16"
 	log_test $? 2 "Route add with fdb nexthop"
 
 	run_cmd "$IP ro add 172.16.0.0/22 nhid 103"
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index b300e87404d8..b054bfef0f4f 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -60,7 +60,9 @@
 #define SKIP(s, ...)	XFAIL(s, ##__VA_ARGS__)
 #endif
 
+#ifndef MIN
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#endif
 
 #ifndef PR_SET_PTRACER
 # define PR_SET_PTRACER 0x59616d61
diff --git a/tools/testing/selftests/vm/mremap_test.c b/tools/testing/selftests/vm/mremap_test.c
index 9496346973d4..7f674160f01e 100644
--- a/tools/testing/selftests/vm/mremap_test.c
+++ b/tools/testing/selftests/vm/mremap_test.c
@@ -22,7 +22,9 @@
 #define VALIDATION_DEFAULT_THRESHOLD 4	/* 4MB */
 #define VALIDATION_NO_THRESHOLD 0	/* Verify the entire region */
 
+#ifndef MIN
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#endif
 
 struct config {
 	unsigned long long src_alignment;

