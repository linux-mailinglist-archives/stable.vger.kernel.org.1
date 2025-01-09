Return-Path: <stable+bounces-108102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC4A0764A
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 13:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22A0168666
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8516221885C;
	Thu,  9 Jan 2025 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R3H0XvHc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15924218AD8;
	Thu,  9 Jan 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736427422; cv=none; b=A/e0JciMg6ycZLkoonpXRLIFu10q/BoNncFFR+ho20eMFF1Ks+90jR9YOVuwcAgw/wKjkVyoTPHmzfIy1+nSoxkA0il6uV3W+D401eMTXwiPFnZULUhuLEarWCjIuEneySRFhQwkHLIpJM6ys5/aeK7rNfLRtSMOdpO6emAVhBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736427422; c=relaxed/simple;
	bh=IwK5ISeVTfetnv87KgRmshRAu+3wH5q7HQTU61V9ogY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKdKisELADxYmpNeEteAszsZ8rvhzCtGSP23nnw7ik8NT/PPsqkjK4LEw/qUJaT78GpwQCZNTixS2OA4gNPK3N73/SVJYExRcdDPrGnobpnf7Pf3tFQnPYRIoXIzWGFvN3Masi3lO2FSUfkSMDlLLTykB5x09Qnk6Gkvy1n/Uwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R3H0XvHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFE0C4CED2;
	Thu,  9 Jan 2025 12:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736427421;
	bh=IwK5ISeVTfetnv87KgRmshRAu+3wH5q7HQTU61V9ogY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R3H0XvHcRrCeZHOp6Tj8bpBMANazOMzD59bM9Lfo/2h8YItQ3dV1ErnHloKQul/v+
	 TbiPYHZZUGhbsnH3AHnOIAfZhJPavYe4R8m2yeItC8tJt6waUM1HCFTYOLNJkK582s
	 0MqcsVM+Jlf6FuMy/paaeqdIVxodiWr6dcvr/hZU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.124
Date: Thu,  9 Jan 2025 13:56:50 +0100
Message-ID: <2025010950-emboss-saline-0f8f@gregkh>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025010950-hazily-gradient-123a@gregkh>
References: <2025010950-hazily-gradient-123a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml b/Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml
index 987aa83c2649..e956f524e379 100644
--- a/Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/adi,adv7533.yaml
@@ -87,7 +87,7 @@ properties:
   adi,dsi-lanes:
     description: Number of DSI data lanes connected to the DSI host.
     $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [ 1, 2, 3, 4 ]
+    enum: [ 2, 3, 4 ]
 
   ports:
     description:
diff --git a/Makefile b/Makefile
index 43ecffba11a6..d26a3c2e4519 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 123
+SUBLEVEL = 124
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 329400a1c355..8e6f52c6626d 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -6,7 +6,7 @@
 KBUILD_DEFCONFIG := haps_hs_smp_defconfig
 
 ifeq ($(CROSS_COMPILE),)
-CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux-)
+CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux- arc-linux-gnu-)
 endif
 
 cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 542b818c0d20..6090fe513d40 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -152,6 +152,63 @@ static void hv_machine_crash_shutdown(struct pt_regs *regs)
 	hyperv_cleanup();
 }
 #endif /* CONFIG_KEXEC_CORE */
+
+static u64 hv_ref_counter_at_suspend;
+static void (*old_save_sched_clock_state)(void);
+static void (*old_restore_sched_clock_state)(void);
+
+/*
+ * Hyper-V clock counter resets during hibernation. Save and restore clock
+ * offset during suspend/resume, while also considering the time passed
+ * before suspend. This is to make sure that sched_clock using hv tsc page
+ * based clocksource, proceeds from where it left off during suspend and
+ * it shows correct time for the timestamps of kernel messages after resume.
+ */
+static void save_hv_clock_tsc_state(void)
+{
+	hv_ref_counter_at_suspend = hv_read_reference_counter();
+}
+
+static void restore_hv_clock_tsc_state(void)
+{
+	/*
+	 * Adjust the offsets used by hv tsc clocksource to
+	 * account for the time spent before hibernation.
+	 * adjusted value = reference counter (time) at suspend
+	 *                - reference counter (time) now.
+	 */
+	hv_adj_sched_clock_offset(hv_ref_counter_at_suspend - hv_read_reference_counter());
+}
+
+/*
+ * Functions to override save_sched_clock_state and restore_sched_clock_state
+ * functions of x86_platform. The Hyper-V clock counter is reset during
+ * suspend-resume and the offset used to measure time needs to be
+ * corrected, post resume.
+ */
+static void hv_save_sched_clock_state(void)
+{
+	old_save_sched_clock_state();
+	save_hv_clock_tsc_state();
+}
+
+static void hv_restore_sched_clock_state(void)
+{
+	restore_hv_clock_tsc_state();
+	old_restore_sched_clock_state();
+}
+
+static void __init x86_setup_ops_for_tsc_pg_clock(void)
+{
+	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
+		return;
+
+	old_save_sched_clock_state = x86_platform.save_sched_clock_state;
+	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
+
+	old_restore_sched_clock_state = x86_platform.restore_sched_clock_state;
+	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
+}
 #endif /* CONFIG_HYPERV */
 
 static uint32_t  __init ms_hyperv_platform(void)
@@ -454,6 +511,7 @@ static void __init ms_hyperv_init_platform(void)
 
 	/* Register Hyper-V specific clocksource */
 	hv_init_clocksource();
+	x86_setup_ops_for_tsc_pg_clock();
 #endif
 	/*
 	 * TSC should be marked as unstable only after Hyper-V
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b83181357f36..b4133258e1bf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1733,7 +1733,8 @@ static void zram_reset_device(struct zram *zram)
 	zram_meta_free(zram, zram->disksize);
 	zram->disksize = 0;
 	memset(&zram->stats, 0, sizeof(zram->stats));
-	zcomp_destroy(zram->comp);
+	if (zram->comp)
+		zcomp_destroy(zram->comp);
 	zram->comp = NULL;
 	reset_bdev(zram);
 
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 18de1f439ffd..6b4f58ee66e0 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -27,7 +27,8 @@
 #include <asm/mshyperv.h>
 
 static struct clock_event_device __percpu *hv_clock_event;
-static u64 hv_sched_clock_offset __ro_after_init;
+/* Note: offset can hold negative values after hibernation. */
+static u64 hv_sched_clock_offset __read_mostly;
 
 /*
  * If false, we're using the old mechanism for stimer0 interrupts
@@ -417,6 +418,17 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr.as_uint64);
 }
 
+/*
+ * Called during resume from hibernation, from overridden
+ * x86_platform.restore_sched_clock_state routine. This is to adjust offsets
+ * used to calculate time for hv tsc page based sched_clock, to account for
+ * time spent before hibernation.
+ */
+void hv_adj_sched_clock_offset(u64 offset)
+{
+	hv_sched_clock_offset -= offset;
+}
+
 #ifdef HAVE_VDSO_CLOCKMODE_HVCLOCK
 static int hv_cs_enable(struct clocksource *cs)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 8a7705db0b9a..a7ed47cb5bf6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -324,7 +324,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 		spage = migrate_pfn_to_page(migrate->src[i]);
 		if (spage && !is_zone_device_page(spage)) {
 			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
-					      DMA_TO_DEVICE);
+					      DMA_BIDIRECTIONAL);
 			r = dma_mapping_error(dev, src[i]);
 			if (r) {
 				dev_err(adev->dev, "%s: fail %d dma_map_page\n",
@@ -623,7 +623,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
 			goto out_oom;
 		}
 
-		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_FROM_DEVICE);
+		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
 		r = dma_mapping_error(dev, dst[i]);
 		if (r) {
 			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
index 61f4a38e7d2b..8f786592143b 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
@@ -153,7 +153,16 @@ static int adv7511_hdmi_hw_params(struct device *dev, void *data,
 			   ADV7511_AUDIO_CFG3_LEN_MASK, len);
 	regmap_update_bits(adv7511->regmap, ADV7511_REG_I2C_FREQ_ID_CFG,
 			   ADV7511_I2C_FREQ_ID_CFG_RATE_MASK, rate << 4);
-	regmap_write(adv7511->regmap, 0x73, 0x1);
+
+	/* send current Audio infoframe values while updating */
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
+			   BIT(5), BIT(5));
+
+	regmap_write(adv7511->regmap, ADV7511_REG_AUDIO_INFOFRAME(0), 0x1);
+
+	/* use Audio infoframe updated info */
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
+			   BIT(5), 0);
 
 	return 0;
 }
@@ -184,8 +193,9 @@ static int audio_startup(struct device *dev, void *data)
 	regmap_update_bits(adv7511->regmap, ADV7511_REG_GC(0),
 				BIT(7) | BIT(6), BIT(7));
 	/* use Audio infoframe updated info */
-	regmap_update_bits(adv7511->regmap, ADV7511_REG_GC(1),
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_INFOFRAME_UPDATE,
 				BIT(5), 0);
+
 	/* enable SPDIF receiver */
 	if (adv7511->audio_source == ADV7511_AUDIO_SOURCE_SPDIF)
 		regmap_update_bits(adv7511->regmap, ADV7511_REG_AUDIO_CONFIG,
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
index b8eeaf4736e7..145b43f5e427 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
@@ -179,7 +179,7 @@ int adv7533_parse_dt(struct device_node *np, struct adv7511 *adv)
 
 	of_property_read_u32(np, "adi,dsi-lanes", &num_lanes);
 
-	if (num_lanes < 1 || num_lanes > 4)
+	if (num_lanes < 2 || num_lanes > 4)
 		return -EINVAL;
 
 	adv->num_dsi_lanes = num_lanes;
diff --git a/drivers/gpu/drm/i915/gt/intel_rc6.c b/drivers/gpu/drm/i915/gt/intel_rc6.c
index f8d0523f4c18..d1dcb018117d 100644
--- a/drivers/gpu/drm/i915/gt/intel_rc6.c
+++ b/drivers/gpu/drm/i915/gt/intel_rc6.c
@@ -134,7 +134,7 @@ static void gen11_rc6_enable(struct intel_rc6 *rc6)
 			GEN9_MEDIA_PG_ENABLE |
 			GEN11_MEDIA_SAMPLER_PG_ENABLE;
 
-	if (GRAPHICS_VER(gt->i915) >= 12) {
+	if (GRAPHICS_VER(gt->i915) >= 12 && !IS_DG1(gt->i915)) {
 		for (i = 0; i < I915_MAX_VCS; i++)
 			if (HAS_ENGINE(gt, _VCS(i)))
 				pg_enable |= (VDN_HCP_POWERGATE_ENABLE(i) |
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index e836c9c477f6..c6053e82ecf6 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -161,7 +161,7 @@ static const void __user *uverbs_request_next_ptr(struct uverbs_req_iter *iter,
 {
 	const void __user *res = iter->cur;
 
-	if (iter->cur + len > iter->end)
+	if (len > iter->end - iter->cur)
 		return (void __force __user *)ERR_PTR(-ENOSPC);
 	iter->cur += len;
 	return res;
@@ -2009,11 +2009,13 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 	ret = uverbs_request_start(attrs, &iter, &cmd, sizeof(cmd));
 	if (ret)
 		return ret;
-	wqes = uverbs_request_next_ptr(&iter, cmd.wqe_size * cmd.wr_count);
+	wqes = uverbs_request_next_ptr(&iter, size_mul(cmd.wqe_size,
+						       cmd.wr_count));
 	if (IS_ERR(wqes))
 		return PTR_ERR(wqes);
-	sgls = uverbs_request_next_ptr(
-		&iter, cmd.sge_count * sizeof(struct ib_uverbs_sge));
+	sgls = uverbs_request_next_ptr(&iter,
+				       size_mul(cmd.sge_count,
+						sizeof(struct ib_uverbs_sge)));
 	if (IS_ERR(sgls))
 		return PTR_ERR(sgls);
 	ret = uverbs_request_finish(&iter);
@@ -2199,11 +2201,11 @@ ib_uverbs_unmarshall_recv(struct uverbs_req_iter *iter, u32 wr_count,
 	if (wqe_size < sizeof(struct ib_uverbs_recv_wr))
 		return ERR_PTR(-EINVAL);
 
-	wqes = uverbs_request_next_ptr(iter, wqe_size * wr_count);
+	wqes = uverbs_request_next_ptr(iter, size_mul(wqe_size, wr_count));
 	if (IS_ERR(wqes))
 		return ERR_CAST(wqes);
-	sgls = uverbs_request_next_ptr(
-		iter, sge_count * sizeof(struct ib_uverbs_sge));
+	sgls = uverbs_request_next_ptr(iter, size_mul(sge_count,
+						      sizeof(struct ib_uverbs_sge)));
 	if (IS_ERR(sgls))
 		return ERR_CAST(sgls);
 	ret = uverbs_request_finish(iter);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 13102ba93847..94c34ba103ea 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -138,7 +138,7 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 
 	ib_attr->vendor_id = rdev->en_dev->pdev->vendor;
 	ib_attr->vendor_part_id = rdev->en_dev->pdev->device;
-	ib_attr->hw_ver = rdev->en_dev->pdev->subsystem_device;
+	ib_attr->hw_ver = rdev->en_dev->pdev->revision;
 	ib_attr->max_qp = dev_attr->max_qp;
 	ib_attr->max_qp_wr = dev_attr->max_qp_wqes;
 	ib_attr->device_cap_flags =
@@ -1940,18 +1940,20 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		}
 	}
 
-	if (qp_attr_mask & IB_QP_PATH_MTU) {
-		qp->qplib_qp.modify_flags |=
-				CMDQ_MODIFY_QP_MODIFY_MASK_PATH_MTU;
-		qp->qplib_qp.path_mtu = __from_ib_mtu(qp_attr->path_mtu);
-		qp->qplib_qp.mtu = ib_mtu_enum_to_int(qp_attr->path_mtu);
-	} else if (qp_attr->qp_state == IB_QPS_RTR) {
-		qp->qplib_qp.modify_flags |=
-			CMDQ_MODIFY_QP_MODIFY_MASK_PATH_MTU;
-		qp->qplib_qp.path_mtu =
-			__from_ib_mtu(iboe_get_mtu(rdev->netdev->mtu));
-		qp->qplib_qp.mtu =
-			ib_mtu_enum_to_int(iboe_get_mtu(rdev->netdev->mtu));
+	if (qp_attr->qp_state == IB_QPS_RTR) {
+		enum ib_mtu qpmtu;
+
+		qpmtu = iboe_get_mtu(rdev->netdev->mtu);
+		if (qp_attr_mask & IB_QP_PATH_MTU) {
+			if (ib_mtu_enum_to_int(qp_attr->path_mtu) >
+			    ib_mtu_enum_to_int(qpmtu))
+				return -EINVAL;
+			qpmtu = qp_attr->path_mtu;
+		}
+
+		qp->qplib_qp.modify_flags |= CMDQ_MODIFY_QP_MODIFY_MASK_PATH_MTU;
+		qp->qplib_qp.path_mtu = __from_ib_mtu(qpmtu);
+		qp->qplib_qp.mtu = ib_mtu_enum_to_int(qpmtu);
 	}
 
 	if (qp_attr_mask & IB_QP_TIMEOUT) {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 7bd7ac8d52e6..23f9a48828dc 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1149,9 +1149,11 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 		rq->dbinfo.db = qp->dpi->dbr;
 		rq->dbinfo.max_slot = bnxt_qplib_set_rq_max_slot(rq->wqe_size);
 	}
+	spin_lock_bh(&rcfw->tbl_lock);
 	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
 	rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
 	rcfw->qp_tbl[tbl_indx].qp_handle = (void *)qp;
+	spin_unlock_bh(&rcfw->tbl_lock);
 
 	return 0;
 fail:
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index bae7d8926143..f59e8755f611 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -124,7 +124,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 	attr->max_qp_init_rd_atom =
 		sb->max_qp_init_rd_atom > BNXT_QPLIB_MAX_OUT_RD_ATOM ?
 		BNXT_QPLIB_MAX_OUT_RD_ATOM : sb->max_qp_init_rd_atom;
-	attr->max_qp_wqes = le16_to_cpu(sb->max_qp_wr);
+	attr->max_qp_wqes = le16_to_cpu(sb->max_qp_wr) - 1;
 	/*
 	 * 128 WQEs needs to be reserved for the HW (8916). Prevent
 	 * reporting the max number
diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 11a78ceae568..950c133d4220 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -153,8 +153,7 @@ int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 	return total;
 }
 
-int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
-			   int buf_cnt, struct ib_umem *umem,
+int hns_roce_get_umem_bufs(dma_addr_t *bufs, int buf_cnt, struct ib_umem *umem,
 			   unsigned int page_shift)
 {
 	struct ib_block_iter biter;
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 9b91731a6207..5e0d78f4e545 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -133,14 +133,12 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	struct hns_roce_cq_table *cq_table = &hr_dev->cq_table;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	u64 mtts[MTT_MIN_COUNT] = {};
-	dma_addr_t dma_handle;
 	int ret;
 
-	ret = hns_roce_mtr_find(hr_dev, &hr_cq->mtr, 0, mtts, ARRAY_SIZE(mtts),
-				&dma_handle);
-	if (!ret) {
+	ret = hns_roce_mtr_find(hr_dev, &hr_cq->mtr, 0, mtts, ARRAY_SIZE(mtts));
+	if (ret) {
 		ibdev_err(ibdev, "failed to find CQ mtr, ret = %d.\n", ret);
-		return -EINVAL;
+		return ret;
 	}
 
 	/* Get CQC memory HEM(Hardware Entry Memory) table */
@@ -157,7 +155,8 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 		goto err_put;
 	}
 
-	ret = hns_roce_create_cqc(hr_dev, hr_cq, mtts, dma_handle);
+	ret = hns_roce_create_cqc(hr_dev, hr_cq, mtts,
+				  hns_roce_get_mtr_ba(&hr_cq->mtr));
 	if (ret)
 		goto err_xa;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 5b8b68b2d69c..060797001353 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -882,8 +882,7 @@ struct hns_roce_hw {
 	int (*rereg_write_mtpt)(struct hns_roce_dev *hr_dev,
 				struct hns_roce_mr *mr, int flags,
 				void *mb_buf);
-	int (*frmr_write_mtpt)(struct hns_roce_dev *hr_dev, void *mb_buf,
-			       struct hns_roce_mr *mr);
+	int (*frmr_write_mtpt)(void *mb_buf, struct hns_roce_mr *mr);
 	int (*mw_write_mtpt)(void *mb_buf, struct hns_roce_mw *mw);
 	void (*write_cqc)(struct hns_roce_dev *hr_dev,
 			  struct hns_roce_cq *hr_cq, void *mb_buf, u64 *mtts,
@@ -1117,8 +1116,13 @@ void hns_roce_cmd_use_polling(struct hns_roce_dev *hr_dev);
 
 /* hns roce hw need current block and next block addr from mtt */
 #define MTT_MIN_COUNT	 2
+static inline dma_addr_t hns_roce_get_mtr_ba(struct hns_roce_mtr *mtr)
+{
+	return mtr->hem_cfg.root_ba;
+}
+
 int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-		      u32 offset, u64 *mtt_buf, int mtt_max, u64 *base_addr);
+		      u32 offset, u64 *mtt_buf, int mtt_max);
 int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 			struct hns_roce_buf_attr *buf_attr,
 			unsigned int page_shift, struct ib_udata *udata,
@@ -1177,7 +1181,7 @@ struct hns_roce_buf *hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size,
 int hns_roce_get_kmem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 			   int buf_cnt, struct hns_roce_buf *buf,
 			   unsigned int page_shift);
-int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
+int hns_roce_get_umem_bufs(dma_addr_t *bufs,
 			   int buf_cnt, struct ib_umem *umem,
 			   unsigned int page_shift);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index f605eb8fd13a..f1de497fc977 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -986,6 +986,7 @@ struct hns_roce_hem_item {
 	size_t count; /* max ba numbers */
 	int start; /* start buf offset in this hem */
 	int end; /* end buf offset in this hem */
+	bool exist_bt;
 };
 
 /* All HEM items are linked in a tree structure */
@@ -1014,6 +1015,7 @@ hem_list_alloc_item(struct hns_roce_dev *hr_dev, int start, int end, int count,
 		}
 	}
 
+	hem->exist_bt = exist_bt;
 	hem->count = count;
 	hem->start = start;
 	hem->end = end;
@@ -1024,34 +1026,32 @@ hem_list_alloc_item(struct hns_roce_dev *hr_dev, int start, int end, int count,
 }
 
 static void hem_list_free_item(struct hns_roce_dev *hr_dev,
-			       struct hns_roce_hem_item *hem, bool exist_bt)
+			       struct hns_roce_hem_item *hem)
 {
-	if (exist_bt)
+	if (hem->exist_bt)
 		dma_free_coherent(hr_dev->dev, hem->count * BA_BYTE_LEN,
 				  hem->addr, hem->dma_addr);
 	kfree(hem);
 }
 
 static void hem_list_free_all(struct hns_roce_dev *hr_dev,
-			      struct list_head *head, bool exist_bt)
+			      struct list_head *head)
 {
 	struct hns_roce_hem_item *hem, *temp_hem;
 
 	list_for_each_entry_safe(hem, temp_hem, head, list) {
 		list_del(&hem->list);
-		hem_list_free_item(hr_dev, hem, exist_bt);
+		hem_list_free_item(hr_dev, hem);
 	}
 }
 
-static void hem_list_link_bt(struct hns_roce_dev *hr_dev, void *base_addr,
-			     u64 table_addr)
+static void hem_list_link_bt(void *base_addr, u64 table_addr)
 {
 	*(u64 *)(base_addr) = table_addr;
 }
 
 /* assign L0 table address to hem from root bt */
-static void hem_list_assign_bt(struct hns_roce_dev *hr_dev,
-			       struct hns_roce_hem_item *hem, void *cpu_addr,
+static void hem_list_assign_bt(struct hns_roce_hem_item *hem, void *cpu_addr,
 			       u64 phy_addr)
 {
 	hem->addr = cpu_addr;
@@ -1141,6 +1141,10 @@ int hns_roce_hem_list_calc_root_ba(const struct hns_roce_buf_region *regions,
 
 	for (i = 0; i < region_cnt; i++) {
 		r = (struct hns_roce_buf_region *)&regions[i];
+		/* when r->hopnum = 0, the region should not occupy root_ba. */
+		if (!r->hopnum)
+			continue;
+
 		if (r->hopnum > 1) {
 			step = hem_list_calc_ba_range(r->hopnum, 1, unit);
 			if (step > 0)
@@ -1222,8 +1226,7 @@ static int hem_list_alloc_mid_bt(struct hns_roce_dev *hr_dev,
 		if (level > 1) {
 			pre = hem_ptrs[level - 1];
 			step = (cur->start - pre->start) / step * BA_BYTE_LEN;
-			hem_list_link_bt(hr_dev, pre->addr + step,
-					 cur->dma_addr);
+			hem_list_link_bt(pre->addr + step, cur->dma_addr);
 		}
 	}
 
@@ -1235,7 +1238,7 @@ static int hem_list_alloc_mid_bt(struct hns_roce_dev *hr_dev,
 
 err_exit:
 	for (level = 1; level < hopnum; level++)
-		hem_list_free_all(hr_dev, &temp_list[level], true);
+		hem_list_free_all(hr_dev, &temp_list[level]);
 
 	return ret;
 }
@@ -1276,16 +1279,26 @@ static int alloc_fake_root_bt(struct hns_roce_dev *hr_dev, void *cpu_base,
 {
 	struct hns_roce_hem_item *hem;
 
+	/* This is on the has_mtt branch, if r->hopnum
+	 * is 0, there is no root_ba to reuse for the
+	 * region's fake hem, so a dma_alloc request is
+	 * necessary here.
+	 */
 	hem = hem_list_alloc_item(hr_dev, r->offset, r->offset + r->count - 1,
-				  r->count, false);
+				  r->count, !r->hopnum);
 	if (!hem)
 		return -ENOMEM;
 
-	hem_list_assign_bt(hr_dev, hem, cpu_base, phy_base);
+	/* The root_ba can be reused only when r->hopnum > 0. */
+	if (r->hopnum)
+		hem_list_assign_bt(hem, cpu_base, phy_base);
 	list_add(&hem->list, branch_head);
 	list_add(&hem->sibling, leaf_head);
 
-	return r->count;
+	/* If r->hopnum == 0, 0 is returned,
+	 * so that the root_bt entry is not occupied.
+	 */
+	return r->hopnum ? r->count : 0;
 }
 
 static int setup_middle_bt(struct hns_roce_dev *hr_dev, void *cpu_base,
@@ -1304,7 +1317,7 @@ static int setup_middle_bt(struct hns_roce_dev *hr_dev, void *cpu_base,
 	/* if exist mid bt, link L1 to L0 */
 	list_for_each_entry_safe(hem, temp_hem, branch_head, list) {
 		offset = (hem->start - r->offset) / step * BA_BYTE_LEN;
-		hem_list_link_bt(hr_dev, cpu_base + offset, hem->dma_addr);
+		hem_list_link_bt(cpu_base + offset, hem->dma_addr);
 		total++;
 	}
 
@@ -1329,7 +1342,7 @@ setup_root_hem(struct hns_roce_dev *hr_dev, struct hns_roce_hem_list *hem_list,
 		return -ENOMEM;
 
 	total = 0;
-	for (i = 0; i < region_cnt && total < max_ba_num; i++) {
+	for (i = 0; i < region_cnt && total <= max_ba_num; i++) {
 		r = &regions[i];
 		if (!r->count)
 			continue;
@@ -1395,9 +1408,9 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
 			     region_cnt);
 	if (ret) {
 		for (i = 0; i < region_cnt; i++)
-			hem_list_free_all(hr_dev, &head.branch[i], false);
+			hem_list_free_all(hr_dev, &head.branch[i]);
 
-		hem_list_free_all(hr_dev, &head.root, true);
+		hem_list_free_all(hr_dev, &head.root);
 	}
 
 	return ret;
@@ -1460,10 +1473,9 @@ void hns_roce_hem_list_release(struct hns_roce_dev *hr_dev,
 
 	for (i = 0; i < HNS_ROCE_MAX_BT_REGION; i++)
 		for (j = 0; j < HNS_ROCE_MAX_BT_LEVEL; j++)
-			hem_list_free_all(hr_dev, &hem_list->mid_bt[i][j],
-					  j != 0);
+			hem_list_free_all(hr_dev, &hem_list->mid_bt[i][j]);
 
-	hem_list_free_all(hr_dev, &hem_list->root_bt, true);
+	hem_list_free_all(hr_dev, &hem_list->root_bt);
 	INIT_LIST_HEAD(&hem_list->btm_bt);
 	hem_list->root_ba = 0;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 54df6c6e4cac..ab0dca9d199a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -471,7 +471,7 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
 	valid_num_sge = calc_wr_sge_num(wr, &msg_len);
 
 	ret = set_ud_opcode(ud_sq_wqe, wr);
-	if (WARN_ON(ret))
+	if (WARN_ON_ONCE(ret))
 		return ret;
 
 	ud_sq_wqe->msg_len = cpu_to_le32(msg_len);
@@ -575,7 +575,7 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
 	rc_sq_wqe->msg_len = cpu_to_le32(msg_len);
 
 	ret = set_rc_opcode(hr_dev, rc_sq_wqe, wr);
-	if (WARN_ON(ret))
+	if (WARN_ON_ONCE(ret))
 		return ret;
 
 	hr_reg_write(rc_sq_wqe, RC_SEND_WQE_SO,
@@ -673,6 +673,10 @@ static void write_dwqe(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 #define HNS_ROCE_SL_SHIFT 2
 	struct hns_roce_v2_rc_send_wqe *rc_sq_wqe = wqe;
 
+	if (unlikely(qp->state == IB_QPS_ERR)) {
+		flush_cqe(hr_dev, qp);
+		return;
+	}
 	/* All kinds of DirectWQE have the same header field layout */
 	hr_reg_enable(rc_sq_wqe, RC_SEND_WQE_FLAG);
 	hr_reg_write(rc_sq_wqe, RC_SEND_WQE_DB_SL_L, qp->sl);
@@ -3289,21 +3293,22 @@ static int set_mtpt_pbl(struct hns_roce_dev *hr_dev,
 	u64 pages[HNS_ROCE_V2_MAX_INNER_MTPT_NUM] = { 0 };
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	dma_addr_t pbl_ba;
-	int i, count;
+	int ret;
+	int i;
 
-	count = hns_roce_mtr_find(hr_dev, &mr->pbl_mtr, 0, pages,
-				  min_t(int, ARRAY_SIZE(pages), mr->npages),
-				  &pbl_ba);
-	if (count < 1) {
-		ibdev_err(ibdev, "failed to find PBL mtr, count = %d.\n",
-			  count);
-		return -ENOBUFS;
+	ret = hns_roce_mtr_find(hr_dev, &mr->pbl_mtr, 0, pages,
+				min_t(int, ARRAY_SIZE(pages), mr->npages));
+	if (ret) {
+		ibdev_err(ibdev, "failed to find PBL mtr, ret = %d.\n", ret);
+		return ret;
 	}
 
 	/* Aligned to the hardware address access unit */
-	for (i = 0; i < count; i++)
+	for (i = 0; i < ARRAY_SIZE(pages); i++)
 		pages[i] >>= 6;
 
+	pbl_ba = hns_roce_get_mtr_ba(&mr->pbl_mtr);
+
 	mpt_entry->pbl_size = cpu_to_le32(mr->npages);
 	mpt_entry->pbl_ba_l = cpu_to_le32(pbl_ba >> 3);
 	hr_reg_write(mpt_entry, MPT_PBL_BA_H, upper_32_bits(pbl_ba >> 3));
@@ -3399,21 +3404,14 @@ static int hns_roce_v2_rereg_write_mtpt(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
-static int hns_roce_v2_frmr_write_mtpt(struct hns_roce_dev *hr_dev,
-				       void *mb_buf, struct hns_roce_mr *mr)
+static int hns_roce_v2_frmr_write_mtpt(void *mb_buf, struct hns_roce_mr *mr)
 {
-	struct ib_device *ibdev = &hr_dev->ib_dev;
+	dma_addr_t pbl_ba = hns_roce_get_mtr_ba(&mr->pbl_mtr);
 	struct hns_roce_v2_mpt_entry *mpt_entry;
-	dma_addr_t pbl_ba = 0;
 
 	mpt_entry = mb_buf;
 	memset(mpt_entry, 0, sizeof(*mpt_entry));
 
-	if (hns_roce_mtr_find(hr_dev, &mr->pbl_mtr, 0, NULL, 0, &pbl_ba) < 0) {
-		ibdev_err(ibdev, "failed to find frmr mtr.\n");
-		return -ENOBUFS;
-	}
-
 	hr_reg_write(mpt_entry, MPT_ST, V2_MPT_ST_FREE);
 	hr_reg_write(mpt_entry, MPT_PD, mr->pd);
 
@@ -4372,8 +4370,7 @@ static void set_access_flags(struct hns_roce_qp *hr_qp,
 }
 
 static void set_qpc_wqe_cnt(struct hns_roce_qp *hr_qp,
-			    struct hns_roce_v2_qp_context *context,
-			    struct hns_roce_v2_qp_context *qpc_mask)
+			    struct hns_roce_v2_qp_context *context)
 {
 	hr_reg_write(context, QPC_SGE_SHIFT,
 		     to_hr_hem_entries_shift(hr_qp->sge.sge_cnt,
@@ -4395,7 +4392,6 @@ static inline int get_pdn(struct ib_pd *ib_pd)
 }
 
 static void modify_qp_reset_to_init(struct ib_qp *ibqp,
-				    const struct ib_qp_attr *attr,
 				    struct hns_roce_v2_qp_context *context,
 				    struct hns_roce_v2_qp_context *qpc_mask)
 {
@@ -4414,7 +4410,7 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 
 	hr_reg_write(context, QPC_RQWS, ilog2(hr_qp->rq.max_gs));
 
-	set_qpc_wqe_cnt(hr_qp, context, qpc_mask);
+	set_qpc_wqe_cnt(hr_qp, context);
 
 	/* No VLAN need to set 0xFFF */
 	hr_reg_write(context, QPC_VLAN_ID, 0xfff);
@@ -4459,7 +4455,6 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 }
 
 static void modify_qp_init_to_init(struct ib_qp *ibqp,
-				   const struct ib_qp_attr *attr,
 				   struct hns_roce_v2_qp_context *context,
 				   struct hns_roce_v2_qp_context *qpc_mask)
 {
@@ -4496,17 +4491,20 @@ static int config_qp_rq_buf(struct hns_roce_dev *hr_dev,
 {
 	u64 mtts[MTT_MIN_COUNT] = { 0 };
 	u64 wqe_sge_ba;
-	int count;
+	int ret;
 
 	/* Search qp buf's mtts */
-	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, hr_qp->rq.offset, mtts,
-				  MTT_MIN_COUNT, &wqe_sge_ba);
-	if (hr_qp->rq.wqe_cnt && count < 1) {
+	ret = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, hr_qp->rq.offset, mtts,
+				MTT_MIN_COUNT);
+	if (hr_qp->rq.wqe_cnt && ret) {
 		ibdev_err(&hr_dev->ib_dev,
-			  "failed to find RQ WQE, QPN = 0x%lx.\n", hr_qp->qpn);
-		return -EINVAL;
+			  "failed to find QP(0x%lx) RQ WQE buf, ret = %d.\n",
+			  hr_qp->qpn, ret);
+		return ret;
 	}
 
+	wqe_sge_ba = hns_roce_get_mtr_ba(&hr_qp->mtr);
+
 	context->wqe_sge_ba = cpu_to_le32(wqe_sge_ba >> 3);
 	qpc_mask->wqe_sge_ba = 0;
 
@@ -4570,23 +4568,23 @@ static int config_qp_sq_buf(struct hns_roce_dev *hr_dev,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	u64 sge_cur_blk = 0;
 	u64 sq_cur_blk = 0;
-	int count;
+	int ret;
 
 	/* search qp buf's mtts */
-	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, 0, &sq_cur_blk, 1, NULL);
-	if (count < 1) {
-		ibdev_err(ibdev, "failed to find QP(0x%lx) SQ buf.\n",
-			  hr_qp->qpn);
-		return -EINVAL;
+	ret = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, hr_qp->sq.offset,
+				&sq_cur_blk, 1);
+	if (ret) {
+		ibdev_err(ibdev, "failed to find QP(0x%lx) SQ WQE buf, ret = %d.\n",
+			  hr_qp->qpn, ret);
+		return ret;
 	}
 	if (hr_qp->sge.sge_cnt > 0) {
-		count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr,
-					  hr_qp->sge.offset,
-					  &sge_cur_blk, 1, NULL);
-		if (count < 1) {
-			ibdev_err(ibdev, "failed to find QP(0x%lx) SGE buf.\n",
-				  hr_qp->qpn);
-			return -EINVAL;
+		ret = hns_roce_mtr_find(hr_dev, &hr_qp->mtr,
+					hr_qp->sge.offset, &sge_cur_blk, 1);
+		if (ret) {
+			ibdev_err(ibdev, "failed to find QP(0x%lx) SGE buf, ret = %d.\n",
+				  hr_qp->qpn, ret);
+			return ret;
 		}
 	}
 
@@ -4754,8 +4752,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	return 0;
 }
 
-static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
-				const struct ib_qp_attr *attr, int attr_mask,
+static int modify_qp_rtr_to_rts(struct ib_qp *ibqp, int attr_mask,
 				struct hns_roce_v2_qp_context *context,
 				struct hns_roce_v2_qp_context *qpc_mask)
 {
@@ -5123,15 +5120,14 @@ static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
 
 	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
 		memset(qpc_mask, 0, hr_dev->caps.qpc_sz);
-		modify_qp_reset_to_init(ibqp, attr, context, qpc_mask);
+		modify_qp_reset_to_init(ibqp, context, qpc_mask);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_INIT) {
-		modify_qp_init_to_init(ibqp, attr, context, qpc_mask);
+		modify_qp_init_to_init(ibqp, context, qpc_mask);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR) {
 		ret = modify_qp_init_to_rtr(ibqp, attr, attr_mask, context,
 					    qpc_mask);
 	} else if (cur_state == IB_QPS_RTR && new_state == IB_QPS_RTS) {
-		ret = modify_qp_rtr_to_rts(ibqp, attr, attr_mask, context,
-					   qpc_mask);
+		ret = modify_qp_rtr_to_rts(ibqp, attr_mask, context, qpc_mask);
 	}
 
 	return ret;
@@ -5689,18 +5685,20 @@ static int hns_roce_v2_write_srqc_index_queue(struct hns_roce_srq *srq,
 	struct ib_device *ibdev = srq->ibsrq.device;
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
 	u64 mtts_idx[MTT_MIN_COUNT] = {};
-	dma_addr_t dma_handle_idx = 0;
+	dma_addr_t dma_handle_idx;
 	int ret;
 
 	/* Get physical address of idx que buf */
 	ret = hns_roce_mtr_find(hr_dev, &idx_que->mtr, 0, mtts_idx,
-				ARRAY_SIZE(mtts_idx), &dma_handle_idx);
-	if (ret < 1) {
+				ARRAY_SIZE(mtts_idx));
+	if (ret) {
 		ibdev_err(ibdev, "failed to find mtr for SRQ idx, ret = %d.\n",
 			  ret);
-		return -ENOBUFS;
+		return ret;
 	}
 
+	dma_handle_idx = hns_roce_get_mtr_ba(&idx_que->mtr);
+
 	hr_reg_write(ctx, SRQC_IDX_HOP_NUM,
 		     to_hr_hem_hopnum(hr_dev->caps.idx_hop_num, srq->wqe_cnt));
 
@@ -5732,20 +5730,22 @@ static int hns_roce_v2_write_srqc(struct hns_roce_srq *srq, void *mb_buf)
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
 	struct hns_roce_srq_context *ctx = mb_buf;
 	u64 mtts_wqe[MTT_MIN_COUNT] = {};
-	dma_addr_t dma_handle_wqe = 0;
+	dma_addr_t dma_handle_wqe;
 	int ret;
 
 	memset(ctx, 0, sizeof(*ctx));
 
 	/* Get the physical address of srq buf */
 	ret = hns_roce_mtr_find(hr_dev, &srq->buf_mtr, 0, mtts_wqe,
-				ARRAY_SIZE(mtts_wqe), &dma_handle_wqe);
-	if (ret < 1) {
+				ARRAY_SIZE(mtts_wqe));
+	if (ret) {
 		ibdev_err(ibdev, "failed to find mtr for SRQ WQE, ret = %d.\n",
 			  ret);
-		return -ENOBUFS;
+		return ret;
 	}
 
+	dma_handle_wqe = hns_roce_get_mtr_ba(&srq->buf_mtr);
+
 	hr_reg_write(ctx, SRQC_SRQ_ST, 1);
 	hr_reg_write_bool(ctx, SRQC_SRQ_TYPE,
 			  srq->ibsrq.srq_type == IB_SRQT_XRC);
@@ -6466,7 +6466,7 @@ static int config_eqc(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 	u64 eqe_ba[MTT_MIN_COUNT] = { 0 };
 	struct hns_roce_eq_context *eqc;
 	u64 bt_ba = 0;
-	int count;
+	int ret;
 
 	eqc = mb_buf;
 	memset(eqc, 0, sizeof(struct hns_roce_eq_context));
@@ -6474,13 +6474,15 @@ static int config_eqc(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 	init_eq_config(hr_dev, eq);
 
 	/* if not multi-hop, eqe buffer only use one trunk */
-	count = hns_roce_mtr_find(hr_dev, &eq->mtr, 0, eqe_ba, MTT_MIN_COUNT,
-				  &bt_ba);
-	if (count < 1) {
-		dev_err(hr_dev->dev, "failed to find EQE mtr\n");
-		return -ENOBUFS;
+	ret = hns_roce_mtr_find(hr_dev, &eq->mtr, 0, eqe_ba,
+				ARRAY_SIZE(eqe_ba));
+	if (ret) {
+		dev_err(hr_dev->dev, "failed to find EQE mtr, ret = %d\n", ret);
+		return ret;
 	}
 
+	bt_ba = hns_roce_get_mtr_ba(&eq->mtr);
+
 	hr_reg_write(eqc, EQC_EQ_ST, HNS_ROCE_V2_EQ_STATE_VALID);
 	hr_reg_write(eqc, EQC_EQE_HOP_NUM, eq->hop_num);
 	hr_reg_write(eqc, EQC_OVER_IGNORE, eq->over_ignore);
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 7f29a55d378f..408ef2a96149 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -154,7 +154,7 @@ static int hns_roce_mr_enable(struct hns_roce_dev *hr_dev,
 	if (mr->type != MR_TYPE_FRMR)
 		ret = hr_dev->hw->write_mtpt(hr_dev, mailbox->buf, mr);
 	else
-		ret = hr_dev->hw->frmr_write_mtpt(hr_dev, mailbox->buf, mr);
+		ret = hr_dev->hw->frmr_write_mtpt(mailbox->buf, mr);
 	if (ret) {
 		dev_err(dev, "failed to write mtpt, ret = %d.\n", ret);
 		goto err_page;
@@ -714,7 +714,7 @@ static int mtr_map_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		return -ENOMEM;
 
 	if (mtr->umem)
-		npage = hns_roce_get_umem_bufs(hr_dev, pages, page_count,
+		npage = hns_roce_get_umem_bufs(pages, page_count,
 					       mtr->umem, page_shift);
 	else
 		npage = hns_roce_get_kmem_bufs(hr_dev, pages, page_count,
@@ -767,11 +767,6 @@ int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	for (i = 0, mapped_cnt = 0; i < mtr->hem_cfg.region_count &&
 	     mapped_cnt < page_cnt; i++) {
 		r = &mtr->hem_cfg.region[i];
-		/* if hopnum is 0, no need to map pages in this region */
-		if (!r->hopnum) {
-			mapped_cnt += r->count;
-			continue;
-		}
 
 		if (r->offset + r->count > page_cnt) {
 			ret = -EINVAL;
@@ -802,47 +797,53 @@ int hns_roce_mtr_map(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 	return ret;
 }
 
-int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
-		      u32 offset, u64 *mtt_buf, int mtt_max, u64 *base_addr)
+static int hns_roce_get_direct_addr_mtt(struct hns_roce_hem_cfg *cfg,
+					u32 start_index, u64 *mtt_buf,
+					int mtt_cnt)
 {
-	struct hns_roce_hem_cfg *cfg = &mtr->hem_cfg;
-	int mtt_count, left;
-	u32 start_index;
+	int mtt_count;
 	int total = 0;
-	__le64 *mtts;
 	u32 npage;
 	u64 addr;
 
-	if (!mtt_buf || mtt_max < 1)
-		goto done;
-
-	/* no mtt memory in direct mode, so just return the buffer address */
-	if (cfg->is_direct) {
-		start_index = offset >> HNS_HW_PAGE_SHIFT;
-		for (mtt_count = 0; mtt_count < cfg->region_count &&
-		     total < mtt_max; mtt_count++) {
-			npage = cfg->region[mtt_count].offset;
-			if (npage < start_index)
-				continue;
+	if (mtt_cnt > cfg->region_count)
+		return -EINVAL;
 
-			addr = cfg->root_ba + (npage << HNS_HW_PAGE_SHIFT);
-			mtt_buf[total] = addr;
+	for (mtt_count = 0; mtt_count < cfg->region_count && total < mtt_cnt;
+	     mtt_count++) {
+		npage = cfg->region[mtt_count].offset;
+		if (npage < start_index)
+			continue;
 
-			total++;
-		}
+		addr = cfg->root_ba + (npage << HNS_HW_PAGE_SHIFT);
+		mtt_buf[total] = addr;
 
-		goto done;
+		total++;
 	}
 
-	start_index = offset >> cfg->buf_pg_shift;
-	left = mtt_max;
+	if (!total)
+		return -ENOENT;
+
+	return 0;
+}
+
+static int hns_roce_get_mhop_mtt(struct hns_roce_dev *hr_dev,
+				 struct hns_roce_mtr *mtr, u32 start_index,
+				 u64 *mtt_buf, int mtt_cnt)
+{
+	int left = mtt_cnt;
+	int total = 0;
+	int mtt_count;
+	__le64 *mtts;
+	u32 npage;
+
 	while (left > 0) {
 		mtt_count = 0;
 		mtts = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
 						  start_index + total,
 						  &mtt_count);
 		if (!mtts || !mtt_count)
-			goto done;
+			break;
 
 		npage = min(mtt_count, left);
 		left -= npage;
@@ -850,11 +851,33 @@ int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 			mtt_buf[total++] = le64_to_cpu(mtts[mtt_count]);
 	}
 
-done:
-	if (base_addr)
-		*base_addr = cfg->root_ba;
+	if (!total)
+		return -ENOENT;
+
+	return 0;
+}
 
-	return total;
+int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
+		      u32 offset, u64 *mtt_buf, int mtt_max)
+{
+	struct hns_roce_hem_cfg *cfg = &mtr->hem_cfg;
+	u32 start_index;
+	int ret;
+
+	if (!mtt_buf || mtt_max < 1)
+		return -EINVAL;
+
+	/* no mtt memory in direct mode, so just return the buffer address */
+	if (cfg->is_direct) {
+		start_index = offset >> HNS_HW_PAGE_SHIFT;
+		ret = hns_roce_get_direct_addr_mtt(cfg, start_index,
+						   mtt_buf, mtt_max);
+	} else {
+		start_index = offset >> cfg->buf_pg_shift;
+		ret = hns_roce_get_mhop_mtt(hr_dev, mtr, start_index,
+					    mtt_buf, mtt_max);
+	}
+	return ret;
 }
 
 static int mtr_init_buf_cfg(struct hns_roce_dev *hr_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 7af663176104..19136cb16960 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1139,7 +1139,6 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 }
 
 static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
-				     struct ib_pd *ib_pd,
 				     struct ib_qp_init_attr *init_attr,
 				     struct ib_udata *udata,
 				     struct hns_roce_qp *hr_qp)
@@ -1293,7 +1292,6 @@ int hns_roce_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_attr,
 	struct ib_device *ibdev = qp->device;
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
 	struct hns_roce_qp *hr_qp = to_hr_qp(qp);
-	struct ib_pd *pd = qp->pd;
 	int ret;
 
 	ret = check_qp_type(hr_dev, init_attr->qp_type, !!udata);
@@ -1308,7 +1306,7 @@ int hns_roce_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_attr,
 		hr_qp->phy_port = hr_dev->iboe.phy_port[hr_qp->port];
 	}
 
-	ret = hns_roce_create_qp_common(hr_dev, pd, init_attr, udata, hr_qp);
+	ret = hns_roce_create_qp_common(hr_dev, init_attr, udata, hr_qp);
 	if (ret)
 		ibdev_err(ibdev, "create QP type 0x%x failed(%d)\n",
 			  init_attr->qp_type, ret);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 652508b660a0..80fcb1b0e8fd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -249,7 +249,7 @@ static void free_srq_wqe_buf(struct hns_roce_dev *hr_dev,
 	hns_roce_mtr_destroy(hr_dev, &srq->buf_mtr);
 }
 
-static int alloc_srq_wrid(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
+static int alloc_srq_wrid(struct hns_roce_srq *srq)
 {
 	srq->wrid = kvmalloc_array(srq->wqe_cnt, sizeof(u64), GFP_KERNEL);
 	if (!srq->wrid)
@@ -365,7 +365,7 @@ static int alloc_srq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq,
 		goto err_idx;
 
 	if (!udata) {
-		ret = alloc_srq_wrid(hr_dev, srq);
+		ret = alloc_srq_wrid(srq);
 		if (ret)
 			goto err_wqe_buf;
 	}
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index bce31e28eb30..45a414e8d35f 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3265,7 +3265,8 @@ static int mlx5_ib_init_multiport_master(struct mlx5_ib_dev *dev)
 		list_for_each_entry(mpi, &mlx5_ib_unaffiliated_port_list,
 				    list) {
 			if (dev->sys_image_guid == mpi->sys_image_guid &&
-			    (mlx5_core_native_port_num(mpi->mdev) - 1) == i) {
+			    (mlx5_core_native_port_num(mpi->mdev) - 1) == i &&
+			    mlx5_core_same_coredev_type(dev->mdev, mpi->mdev)) {
 				bound = mlx5_ib_bind_slave_port(dev, mpi);
 			}
 
@@ -4280,7 +4281,8 @@ static int mlx5r_mp_probe(struct auxiliary_device *adev,
 
 	mutex_lock(&mlx5_ib_multiport_mutex);
 	list_for_each_entry(dev, &mlx5_ib_dev_list, ib_dev_list) {
-		if (dev->sys_image_guid == mpi->sys_image_guid)
+		if (dev->sys_image_guid == mpi->sys_image_guid &&
+		    mlx5_core_same_coredev_type(dev->mdev, mpi->mdev))
 			bound = mlx5_ib_bind_slave_port(dev, mpi);
 
 		if (bound) {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index a70ccb4d4c85..8b3b9b798676 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -344,6 +344,7 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 	struct rtrs_srv_mr *srv_mr;
 	bool need_inval = false;
 	enum ib_send_flags flags;
+	struct ib_sge list;
 	u32 imm;
 	int err;
 
@@ -396,7 +397,6 @@ static int send_io_resp_imm(struct rtrs_srv_con *con, struct rtrs_srv_op *id,
 	imm = rtrs_to_io_rsp_imm(id->msg_id, errno, need_inval);
 	imm_wr.wr.next = NULL;
 	if (always_invalidate) {
-		struct ib_sge list;
 		struct rtrs_msg_rkey_rsp *msg;
 
 		srv_mr = &srv_path->mrs[id->msg_id];
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4c7bae0ec8f9..867b282fa95d 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -63,7 +63,7 @@ static void gic_check_cpu_features(void)
 
 union gic_base {
 	void __iomem *common_base;
-	void __percpu * __iomem *percpu_base;
+	void __iomem * __percpu *percpu_base;
 };
 
 struct gic_chip_data {
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index e9fa92a83322..b854ee425fcd 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 switch driver main logic
  *
- * Copyright (C) 2017-2019 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
 
 #include <linux/kernel.h>
@@ -964,26 +964,51 @@ void ksz9477_get_caps(struct ksz_device *dev, int port,
 int ksz9477_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
 {
 	u32 secs = msecs / 1000;
-	u8 value;
-	u8 data;
+	u8 data, mult, value;
+	u32 max_val;
 	int ret;
 
-	value = FIELD_GET(SW_AGE_PERIOD_7_0_M, secs);
+#define MAX_TIMER_VAL	((1 << 8) - 1)
 
-	ret = ksz_write8(dev, REG_SW_LUE_CTRL_3, value);
-	if (ret < 0)
-		return ret;
+	/* The aging timer comprises a 3-bit multiplier and an 8-bit second
+	 * value.  Either of them cannot be zero.  The maximum timer is then
+	 * 7 * 255 = 1785 seconds.
+	 */
+	if (!secs)
+		secs = 1;
 
-	data = FIELD_GET(SW_AGE_PERIOD_10_8_M, secs);
+	/* Return error if too large. */
+	else if (secs > 7 * MAX_TIMER_VAL)
+		return -EINVAL;
 
 	ret = ksz_read8(dev, REG_SW_LUE_CTRL_0, &value);
 	if (ret < 0)
 		return ret;
 
-	value &= ~SW_AGE_CNT_M;
-	value |= FIELD_PREP(SW_AGE_CNT_M, data);
+	/* Check whether there is need to update the multiplier. */
+	mult = FIELD_GET(SW_AGE_CNT_M, value);
+	max_val = MAX_TIMER_VAL;
+	if (mult > 0) {
+		/* Try to use the same multiplier already in the register as
+		 * the hardware default uses multiplier 4 and 75 seconds for
+		 * 300 seconds.
+		 */
+		max_val = DIV_ROUND_UP(secs, mult);
+		if (max_val > MAX_TIMER_VAL || max_val * mult != secs)
+			max_val = MAX_TIMER_VAL;
+	}
+
+	data = DIV_ROUND_UP(secs, max_val);
+	if (mult != data) {
+		value &= ~SW_AGE_CNT_M;
+		value |= FIELD_PREP(SW_AGE_CNT_M, data);
+		ret = ksz_write8(dev, REG_SW_LUE_CTRL_0, value);
+		if (ret < 0)
+			return ret;
+	}
 
-	return ksz_write8(dev, REG_SW_LUE_CTRL_0, value);
+	value = DIV_ROUND_UP(secs, data);
+	return ksz_write8(dev, REG_SW_LUE_CTRL_3, value);
 }
 
 void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/microchip/ksz9477_reg.h
index 04086e9ab0a0..ffb9484018ed 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 register definitions
  *
- * Copyright (C) 2017-2018 Microchip Technology Inc.
+ * Copyright (C) 2017-2024 Microchip Technology Inc.
  */
 
 #ifndef __KSZ9477_REGS_H
@@ -190,8 +190,6 @@
 #define SW_VLAN_ENABLE			BIT(7)
 #define SW_DROP_INVALID_VID		BIT(6)
 #define SW_AGE_CNT_M			GENMASK(5, 3)
-#define SW_AGE_CNT_S			3
-#define SW_AGE_PERIOD_10_8_M		GENMASK(10, 8)
 #define SW_RESV_MCAST_ENABLE		BIT(2)
 #define SW_HASH_OPTION_M		0x03
 #define SW_HASH_OPTION_CRC		1
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index d1b2db8e6533..a3a7a90dad96 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -454,6 +454,11 @@ static inline int ksz_write64(struct ksz_device *dev, u32 reg, u64 value)
 	return regmap_bulk_write(dev->regmap[2], reg, val, 2);
 }
 
+static inline int ksz_rmw8(struct ksz_device *dev, int offset, u8 mask, u8 val)
+{
+	return regmap_update_bits(dev->regmap[0], offset, mask, val);
+}
+
 static inline int ksz_pread8(struct ksz_device *dev, int port, int offset,
 			     u8 *data)
 {
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 7e4f307a0387..338eff0818df 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Microchip LAN937X switch driver main logic
- * Copyright (C) 2019-2022 Microchip Technology Inc.
+ * Copyright (C) 2019-2024 Microchip Technology Inc.
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -249,10 +249,66 @@ int lan937x_change_mtu(struct ksz_device *dev, int port, int new_mtu)
 
 int lan937x_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
 {
-	u32 secs = msecs / 1000;
-	u32 value;
+	u8 data, mult, value8;
+	bool in_msec = false;
+	u32 max_val, value;
+	u32 secs = msecs;
 	int ret;
 
+#define MAX_TIMER_VAL	((1 << 20) - 1)
+
+	/* The aging timer comprises a 3-bit multiplier and a 20-bit second
+	 * value.  Either of them cannot be zero.  The maximum timer is then
+	 * 7 * 1048575 = 7340025 seconds.  As this value is too large for
+	 * practical use it can be interpreted as microseconds, making the
+	 * maximum timer 7340 seconds with finer control.  This allows for
+	 * maximum 122 minutes compared to 29 minutes in KSZ9477 switch.
+	 */
+	if (msecs % 1000)
+		in_msec = true;
+	else
+		secs /= 1000;
+	if (!secs)
+		secs = 1;
+
+	/* Return error if too large. */
+	else if (secs > 7 * MAX_TIMER_VAL)
+		return -EINVAL;
+
+	/* Configure how to interpret the number value. */
+	ret = ksz_rmw8(dev, REG_SW_LUE_CTRL_2, SW_AGE_CNT_IN_MICROSEC,
+		       in_msec ? SW_AGE_CNT_IN_MICROSEC : 0);
+	if (ret < 0)
+		return ret;
+
+	ret = ksz_read8(dev, REG_SW_LUE_CTRL_0, &value8);
+	if (ret < 0)
+		return ret;
+
+	/* Check whether there is need to update the multiplier. */
+	mult = FIELD_GET(SW_AGE_CNT_M, value8);
+	max_val = MAX_TIMER_VAL;
+	if (mult > 0) {
+		/* Try to use the same multiplier already in the register as
+		 * the hardware default uses multiplier 4 and 75 seconds for
+		 * 300 seconds.
+		 */
+		max_val = DIV_ROUND_UP(secs, mult);
+		if (max_val > MAX_TIMER_VAL || max_val * mult != secs)
+			max_val = MAX_TIMER_VAL;
+	}
+
+	data = DIV_ROUND_UP(secs, max_val);
+	if (mult != data) {
+		value8 &= ~SW_AGE_CNT_M;
+		value8 |= FIELD_PREP(SW_AGE_CNT_M, data);
+		ret = ksz_write8(dev, REG_SW_LUE_CTRL_0, value8);
+		if (ret < 0)
+			return ret;
+	}
+
+	secs = DIV_ROUND_UP(secs, data);
+
 	value = FIELD_GET(SW_AGE_PERIOD_7_0_M, secs);
 
 	ret = ksz_write8(dev, REG_SW_AGE_PERIOD__1, value);
diff --git a/drivers/net/dsa/microchip/lan937x_reg.h b/drivers/net/dsa/microchip/lan937x_reg.h
index 5bc16a4c4441..f36ef2ce4065 100644
--- a/drivers/net/dsa/microchip/lan937x_reg.h
+++ b/drivers/net/dsa/microchip/lan937x_reg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Microchip LAN937X switch register definitions
- * Copyright (C) 2019-2021 Microchip Technology Inc.
+ * Copyright (C) 2019-2024 Microchip Technology Inc.
  */
 #ifndef __LAN937X_REG_H
 #define __LAN937X_REG_H
@@ -48,8 +48,7 @@
 
 #define SW_VLAN_ENABLE			BIT(7)
 #define SW_DROP_INVALID_VID		BIT(6)
-#define SW_AGE_CNT_M			0x7
-#define SW_AGE_CNT_S			3
+#define SW_AGE_CNT_M			GENMASK(5, 3)
 #define SW_RESV_MCAST_ENABLE		BIT(2)
 
 #define REG_SW_LUE_CTRL_1		0x0311
@@ -62,6 +61,10 @@
 #define SW_FAST_AGING			BIT(1)
 #define SW_LINK_AUTO_AGING		BIT(0)
 
+#define REG_SW_LUE_CTRL_2		0x0312
+
+#define SW_AGE_CNT_IN_MICROSEC		BIT(7)
+
 #define REG_SW_AGE_PERIOD__1		0x0313
 #define SW_AGE_PERIOD_7_0_M		GENMASK(7, 0)
 
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 1693f6c60efc..e53ab9b5482e 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1956,7 +1956,11 @@ static int bcm_sysport_open(struct net_device *dev)
 	unsigned int i;
 	int ret;
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		netdev_err(dev, "could not enable priv clock\n");
+		return ret;
+	}
 
 	/* Reset UniMAC */
 	umac_reset(priv);
@@ -2614,7 +2618,11 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 		goto err_deregister_notifier;
 	}
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "could not enable priv clock\n");
+		goto err_deregister_netdev;
+	}
 
 	priv->rev = topctrl_readl(priv, REV_CNTL) & REV_MASK;
 	dev_info(&pdev->dev,
@@ -2628,6 +2636,8 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_deregister_netdev:
+	unregister_netdev(dev);
 err_deregister_notifier:
 	unregister_netdevice_notifier(&priv->netdev_notifier);
 err_deregister_fixed_link:
@@ -2799,7 +2809,12 @@ static int __maybe_unused bcm_sysport_resume(struct device *d)
 	if (!netif_running(dev))
 		return 0;
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		netdev_err(dev, "could not enable priv clock\n");
+		return ret;
+	}
+
 	if (priv->wolopts)
 		clk_disable_unprepare(priv->wol_clk);
 
diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 8941f69d93e9..b9dda48326d5 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2707,9 +2707,15 @@ static struct platform_device *port_platdev[3];
 
 static void mv643xx_eth_shared_of_remove(void)
 {
+	struct mv643xx_eth_platform_data *pd;
 	int n;
 
 	for (n = 0; n < 3; n++) {
+		if (!port_platdev[n])
+			continue;
+		pd = dev_get_platdata(&port_platdev[n]->dev);
+		if (pd)
+			of_node_put(pd->phy_node);
 		platform_device_del(port_platdev[n]);
 		port_platdev[n] = NULL;
 	}
@@ -2770,8 +2776,10 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 	}
 
 	ppdev = platform_device_alloc(MV643XX_ETH_NAME, dev_num);
-	if (!ppdev)
-		return -ENOMEM;
+	if (!ppdev) {
+		ret = -ENOMEM;
+		goto put_err;
+	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 	ppdev->dev.of_node = pnp;
 
@@ -2793,6 +2801,8 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 
 port_err:
 	platform_device_put(ppdev);
+put_err:
+	of_node_put(ppd.phy_node);
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index ab33ba1c3023..31bcced59f2f 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -130,6 +130,7 @@ static const struct pci_device_id sky2_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x436C) }, /* 88E8072 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x436D) }, /* 88E8055 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4370) }, /* 88E8075 */
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4373) }, /* 88E8075 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4380) }, /* 88E8057 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4381) }, /* 88E8059 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4382) }, /* 88E8079 */
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index b3472fb94617..8883ef012747 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -423,8 +423,7 @@ mlxsw_sp_span_gretap4_route(const struct net_device *to_dev,
 
 	parms = mlxsw_sp_ipip_netdev_parms4(to_dev);
 	ip_tunnel_init_flow(&fl4, parms.iph.protocol, *daddrp, *saddrp,
-			    0, 0, dev_net(to_dev), parms.link, tun->fwmark, 0,
-			    0);
+			    0, 0, tun->net, parms.link, tun->fwmark, 0, 0);
 
 	rt = ip_route_output_key(tun->net, &fl4);
 	if (IS_ERR(rt))
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 0046a4ee6e64..c368ef3cd9cb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -8,6 +8,7 @@
   Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
 *******************************************************************************/
 
+#include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
@@ -293,62 +294,80 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 }
 
 /**
- * stmmac_dt_phy - parse device-tree driver parameters to allocate PHY resources
- * @plat: driver data platform structure
- * @np: device tree node
- * @dev: device pointer
- * Description:
- * The mdio bus will be allocated in case of a phy transceiver is on board;
- * it will be NULL if the fixed-link is configured.
- * If there is the "snps,dwmac-mdio" sub-node the mdio will be allocated
- * in any case (for DSA, mdio must be registered even if fixed-link).
- * The table below sums the supported configurations:
- *	-------------------------------
- *	snps,phy-addr	|     Y
- *	-------------------------------
- *	phy-handle	|     Y
- *	-------------------------------
- *	fixed-link	|     N
- *	-------------------------------
- *	snps,dwmac-mdio	|
- *	  even if	|     Y
- *	fixed-link	|
- *	-------------------------------
+ * stmmac_of_get_mdio() - Gets the MDIO bus from the devicetree.
+ * @np: devicetree node
+ *
+ * The MDIO bus will be searched for in the following ways:
+ * 1. The compatible is "snps,dwc-qos-ethernet-4.10" && a "mdio" named
+ *    child node exists
+ * 2. A child node with the "snps,dwmac-mdio" compatible is present
  *
- * It returns 0 in case of success otherwise -ENODEV.
+ * Return: The MDIO node if present otherwise NULL
  */
-static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
-			 struct device_node *np, struct device *dev)
+static struct device_node *stmmac_of_get_mdio(struct device_node *np)
 {
-	bool mdio = !of_phy_is_fixed_link(np);
 	static const struct of_device_id need_mdio_ids[] = {
 		{ .compatible = "snps,dwc-qos-ethernet-4.10" },
 		{},
 	};
+	struct device_node *mdio_node = NULL;
 
 	if (of_match_node(need_mdio_ids, np)) {
-		plat->mdio_node = of_get_child_by_name(np, "mdio");
+		mdio_node = of_get_child_by_name(np, "mdio");
 	} else {
 		/**
 		 * If snps,dwmac-mdio is passed from DT, always register
 		 * the MDIO
 		 */
-		for_each_child_of_node(np, plat->mdio_node) {
-			if (of_device_is_compatible(plat->mdio_node,
+		for_each_child_of_node(np, mdio_node) {
+			if (of_device_is_compatible(mdio_node,
 						    "snps,dwmac-mdio"))
 				break;
 		}
 	}
 
-	if (plat->mdio_node) {
+	return mdio_node;
+}
+
+/**
+ * stmmac_mdio_setup() - Populate platform related MDIO structures.
+ * @plat: driver data platform structure
+ * @np: devicetree node
+ * @dev: device pointer
+ *
+ * This searches for MDIO information from the devicetree.
+ * If an MDIO node is found, it's assigned to plat->mdio_node and
+ * plat->mdio_bus_data is allocated.
+ * If no connection can be determined, just plat->mdio_bus_data is allocated
+ * to indicate a bus should be created and scanned for a phy.
+ * If it's determined there's no MDIO bus needed, both are left NULL.
+ *
+ * This expects that plat->phy_node has already been searched for.
+ *
+ * Return: 0 on success, errno otherwise.
+ */
+static int stmmac_mdio_setup(struct plat_stmmacenet_data *plat,
+			     struct device_node *np, struct device *dev)
+{
+	bool legacy_mdio;
+
+	plat->mdio_node = stmmac_of_get_mdio(np);
+	if (plat->mdio_node)
 		dev_dbg(dev, "Found MDIO subnode\n");
-		mdio = true;
-	}
 
-	if (mdio) {
-		plat->mdio_bus_data =
-			devm_kzalloc(dev, sizeof(struct stmmac_mdio_bus_data),
-				     GFP_KERNEL);
+	/* Legacy devicetrees allowed for no MDIO bus description and expect
+	 * the bus to be scanned for devices. If there's no phy or fixed-link
+	 * described assume this is the case since there must be something
+	 * connected to the MAC.
+	 */
+	legacy_mdio = !of_phy_is_fixed_link(np) && !plat->phy_node;
+	if (legacy_mdio)
+		dev_info(dev, "Deprecated MDIO bus assumption used\n");
+
+	if (plat->mdio_node || legacy_mdio) {
+		plat->mdio_bus_data = devm_kzalloc(dev,
+						   sizeof(*plat->mdio_bus_data),
+						   GFP_KERNEL);
 		if (!plat->mdio_bus_data)
 			return -ENOMEM;
 
@@ -453,10 +472,11 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	if (of_property_read_u32(np, "snps,phy-addr", &plat->phy_addr) == 0)
 		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
 
-	/* To Configure PHY by using all device-tree supported properties */
-	rc = stmmac_dt_phy(plat, np, &pdev->dev);
-	if (rc)
-		return ERR_PTR(rc);
+	rc = stmmac_mdio_setup(plat, np, &pdev->dev);
+	if (rc) {
+		ret = ERR_PTR(rc);
+		goto error_put_phy;
+	}
 
 	of_property_read_u32(np, "tx-fifo-depth", &plat->tx_fifo_size);
 
@@ -542,8 +562,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*dma_cfg),
 			       GFP_KERNEL);
 	if (!dma_cfg) {
-		stmmac_remove_config_dt(pdev, plat);
-		return ERR_PTR(-ENOMEM);
+		ret = ERR_PTR(-ENOMEM);
+		goto error_put_mdio;
 	}
 	plat->dma_cfg = dma_cfg;
 
@@ -571,8 +591,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 
 	rc = stmmac_mtl_setup(pdev, plat);
 	if (rc) {
-		stmmac_remove_config_dt(pdev, plat);
-		return ERR_PTR(rc);
+		ret = ERR_PTR(rc);
+		goto error_put_mdio;
 	}
 
 	/* clock setup */
@@ -624,10 +644,48 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	clk_disable_unprepare(plat->pclk);
 error_pclk_get:
 	clk_disable_unprepare(plat->stmmac_clk);
+error_put_mdio:
+	of_node_put(plat->mdio_node);
+error_put_phy:
+	of_node_put(plat->phy_node);
 
 	return ret;
 }
 
+static void devm_stmmac_remove_config_dt(void *data)
+{
+	struct plat_stmmacenet_data *plat = data;
+
+	clk_disable_unprepare(plat->stmmac_clk);
+	clk_disable_unprepare(plat->pclk);
+	of_node_put(plat->mdio_node);
+	of_node_put(plat->phy_node);
+}
+
+/**
+ * devm_stmmac_probe_config_dt
+ * @pdev: platform_device structure
+ * @mac: MAC address to use
+ * Description: Devres variant of stmmac_probe_config_dt().
+ */
+struct plat_stmmacenet_data *
+devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
+{
+	struct plat_stmmacenet_data *plat;
+	int ret;
+
+	plat = stmmac_probe_config_dt(pdev, mac);
+	if (IS_ERR(plat))
+		return plat;
+
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       devm_stmmac_remove_config_dt, plat);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return plat;
+}
+
 /**
  * stmmac_remove_config_dt - undo the effects of stmmac_probe_config_dt()
  * @pdev: platform_device structure
@@ -650,12 +708,19 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	return ERR_PTR(-EINVAL);
 }
 
+struct plat_stmmacenet_data *
+devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
+{
+	return ERR_PTR(-EINVAL);
+}
+
 void stmmac_remove_config_dt(struct platform_device *pdev,
 			     struct plat_stmmacenet_data *plat)
 {
 }
 #endif /* CONFIG_OF */
 EXPORT_SYMBOL_GPL(stmmac_probe_config_dt);
+EXPORT_SYMBOL_GPL(devm_stmmac_probe_config_dt);
 EXPORT_SYMBOL_GPL(stmmac_remove_config_dt);
 
 int stmmac_get_platform_resources(struct platform_device *pdev,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index 3fff3f59d73d..2102c6d41464 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -13,6 +13,8 @@
 
 struct plat_stmmacenet_data *
 stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac);
+struct plat_stmmacenet_data *
+devm_stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac);
 void stmmac_remove_config_dt(struct platform_device *pdev,
 			     struct plat_stmmacenet_data *plat);
 
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 8b9e2888b310..65aefebdf9a9 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1372,6 +1372,9 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a9, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c0, 0)}, /* Telit FE910C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c4, 0)}, /* Telit FE910C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c8, 0)}, /* Telit FE910C04 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
diff --git a/drivers/net/wwan/iosm/iosm_ipc_mmio.c b/drivers/net/wwan/iosm/iosm_ipc_mmio.c
index 63eb08c43c05..6764c13530b9 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mmio.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mmio.c
@@ -104,7 +104,7 @@ struct iosm_mmio *ipc_mmio_init(void __iomem *mmio, struct device *dev)
 			break;
 
 		msleep(20);
-	} while (retries-- > 0);
+	} while (--retries > 0);
 
 	if (!retries) {
 		dev_err(ipc_mmio->dev, "invalid exec stage %X", stage);
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 0bcca08ff2bd..44a2081c5249 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -97,14 +97,21 @@ void t7xx_fsm_broadcast_state(struct t7xx_fsm_ctl *ctl, enum md_state state)
 	fsm_state_notify(ctl->md, state);
 }
 
+static void fsm_release_command(struct kref *ref)
+{
+	struct t7xx_fsm_command *cmd = container_of(ref, typeof(*cmd), refcnt);
+
+	kfree(cmd);
+}
+
 static void fsm_finish_command(struct t7xx_fsm_ctl *ctl, struct t7xx_fsm_command *cmd, int result)
 {
 	if (cmd->flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
-		*cmd->ret = result;
-		complete_all(cmd->done);
+		cmd->result = result;
+		complete_all(&cmd->done);
 	}
 
-	kfree(cmd);
+	kref_put(&cmd->refcnt, fsm_release_command);
 }
 
 static void fsm_del_kf_event(struct t7xx_fsm_event *event)
@@ -387,7 +394,6 @@ static int fsm_main_thread(void *data)
 
 int t7xx_fsm_append_cmd(struct t7xx_fsm_ctl *ctl, enum t7xx_fsm_cmd_state cmd_id, unsigned int flag)
 {
-	DECLARE_COMPLETION_ONSTACK(done);
 	struct t7xx_fsm_command *cmd;
 	unsigned long flags;
 	int ret;
@@ -399,11 +405,13 @@ int t7xx_fsm_append_cmd(struct t7xx_fsm_ctl *ctl, enum t7xx_fsm_cmd_state cmd_id
 	INIT_LIST_HEAD(&cmd->entry);
 	cmd->cmd_id = cmd_id;
 	cmd->flag = flag;
+	kref_init(&cmd->refcnt);
 	if (flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
-		cmd->done = &done;
-		cmd->ret = &ret;
+		init_completion(&cmd->done);
+		kref_get(&cmd->refcnt);
 	}
 
+	kref_get(&cmd->refcnt);
 	spin_lock_irqsave(&ctl->command_lock, flags);
 	list_add_tail(&cmd->entry, &ctl->command_queue);
 	spin_unlock_irqrestore(&ctl->command_lock, flags);
@@ -413,11 +421,11 @@ int t7xx_fsm_append_cmd(struct t7xx_fsm_ctl *ctl, enum t7xx_fsm_cmd_state cmd_id
 	if (flag & FSM_CMD_FLAG_WAIT_FOR_COMPLETION) {
 		unsigned long wait_ret;
 
-		wait_ret = wait_for_completion_timeout(&done,
+		wait_ret = wait_for_completion_timeout(&cmd->done,
 						       msecs_to_jiffies(FSM_CMD_TIMEOUT_MS));
-		if (!wait_ret)
-			return -ETIMEDOUT;
 
+		ret = wait_ret ? cmd->result : -ETIMEDOUT;
+		kref_put(&cmd->refcnt, fsm_release_command);
 		return ret;
 	}
 
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.h b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
index b1af0259d4c5..d9f2522e6b2c 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.h
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
@@ -107,8 +107,9 @@ struct t7xx_fsm_command {
 	struct list_head	entry;
 	enum t7xx_fsm_cmd_state	cmd_id;
 	unsigned int		flag;
-	struct completion	*done;
-	int			*ret;
+	struct completion	done;
+	int			result;
+	struct kref		refcnt;
 };
 
 struct t7xx_fsm_notifier {
diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index 5f356edfd0fd..2e8bbef8ca34 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -85,6 +85,7 @@ const struct regmap_config mcp23x08_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(mcp23x08_defaults),
 	.cache_type = REGCACHE_FLAT,
 	.max_register = MCP_OLAT,
+	.disable_locking = true, /* mcp->lock protects the regmap */
 };
 EXPORT_SYMBOL_GPL(mcp23x08_regmap);
 
@@ -131,6 +132,7 @@ const struct regmap_config mcp23x17_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(mcp23x17_defaults),
 	.cache_type = REGCACHE_FLAT,
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.disable_locking = true, /* mcp->lock protects the regmap */
 };
 EXPORT_SYMBOL_GPL(mcp23x17_regmap);
 
@@ -228,7 +230,9 @@ static int mcp_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin,
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_PULL_UP:
+		mutex_lock(&mcp->lock);
 		ret = mcp_read(mcp, MCP_GPPU, &data);
+		mutex_unlock(&mcp->lock);
 		if (ret < 0)
 			return ret;
 		status = (data & BIT(pin)) ? 1 : 0;
@@ -257,7 +261,9 @@ static int mcp_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 
 		switch (param) {
 		case PIN_CONFIG_BIAS_PULL_UP:
+			mutex_lock(&mcp->lock);
 			ret = mcp_set_bit(mcp, MCP_GPPU, pin, arg);
+			mutex_unlock(&mcp->lock);
 			break;
 		default:
 			dev_dbg(mcp->dev, "Invalid config param %04x\n", param);
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 288aaa05d007..56a9222b439a 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1479,6 +1479,18 @@ static struct pci_device_id nhi_ids[] = {
 	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_MTL_P_NHI1),
 	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_LNL_NHI0),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_LNL_NHI1),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_PTL_M_NHI0),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_PTL_M_NHI1),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_PTL_P_NHI0),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_PTL_P_NHI1),
+	  .driver_data = (kernel_ulong_t)&icl_nhi_ops },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_80G_NHI) },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_40G_NHI) },
 
diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
index 0f029ce75882..16744f25a9a0 100644
--- a/drivers/thunderbolt/nhi.h
+++ b/drivers/thunderbolt/nhi.h
@@ -90,6 +90,12 @@ extern const struct tb_nhi_ops icl_nhi_ops;
 #define PCI_DEVICE_ID_INTEL_TGL_H_NHI1			0x9a21
 #define PCI_DEVICE_ID_INTEL_RPL_NHI0			0xa73e
 #define PCI_DEVICE_ID_INTEL_RPL_NHI1			0xa76d
+#define PCI_DEVICE_ID_INTEL_LNL_NHI0			0xa833
+#define PCI_DEVICE_ID_INTEL_LNL_NHI1			0xa834
+#define PCI_DEVICE_ID_INTEL_PTL_M_NHI0			0xe333
+#define PCI_DEVICE_ID_INTEL_PTL_M_NHI1			0xe334
+#define PCI_DEVICE_ID_INTEL_PTL_P_NHI0			0xe433
+#define PCI_DEVICE_ID_INTEL_PTL_P_NHI1			0xe434
 
 #define PCI_CLASS_SERIAL_USB_USB4			0x0c0340
 
diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index edbd92435b41..5bd5c22a5085 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -98,6 +98,7 @@ static int tb_retimer_nvm_add(struct tb_retimer *rt)
 
 err_nvm:
 	dev_dbg(&rt->dev, "NVM upgrade disabled\n");
+	rt->no_nvm_upgrade = true;
 	if (!IS_ERR(nvm))
 		tb_nvm_free(nvm);
 
@@ -177,8 +178,6 @@ static ssize_t nvm_authenticate_show(struct device *dev,
 
 	if (!rt->nvm)
 		ret = -EAGAIN;
-	else if (rt->no_nvm_upgrade)
-		ret = -EOPNOTSUPP;
 	else
 		ret = sysfs_emit(buf, "%#x\n", rt->auth_status);
 
@@ -304,6 +303,19 @@ static ssize_t vendor_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(vendor);
 
+static umode_t retimer_is_visible(struct kobject *kobj, struct attribute *attr,
+				  int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct tb_retimer *rt = tb_to_retimer(dev);
+
+	if (attr == &dev_attr_nvm_authenticate.attr ||
+	    attr == &dev_attr_nvm_version.attr)
+		return rt->no_nvm_upgrade ? 0 : attr->mode;
+
+	return attr->mode;
+}
+
 static struct attribute *retimer_attrs[] = {
 	&dev_attr_device.attr,
 	&dev_attr_nvm_authenticate.attr,
@@ -313,6 +325,7 @@ static struct attribute *retimer_attrs[] = {
 };
 
 static const struct attribute_group retimer_group = {
+	.is_visible = retimer_is_visible,
 	.attrs = retimer_attrs,
 };
 
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 975d825091cb..2503022a3123 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -52,6 +52,7 @@
  *   endpoint rings; it generates events on the event ring for these.
  */
 
+#include <linux/jiffies.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
@@ -1051,6 +1052,19 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 	return 0;
 }
 
+/*
+ * Erase queued TDs from transfer ring(s) and give back those the xHC didn't
+ * stop on. If necessary, queue commands to move the xHC off cancelled TDs it
+ * stopped on. Those will be given back later when the commands complete.
+ *
+ * Call under xhci->lock on a stopped endpoint.
+ */
+void xhci_process_cancelled_tds(struct xhci_virt_ep *ep)
+{
+	xhci_invalidate_cancelled_tds(ep);
+	xhci_giveback_invalidated_tds(ep);
+}
+
 /*
  * Returns the TD the endpoint ring halted on.
  * Only call for non-running rings without streams.
@@ -1141,9 +1155,35 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 				break;
 			ep->ep_state &= ~EP_STOP_CMD_PENDING;
 			return;
+		case EP_STATE_STOPPED:
+			/*
+			 * Per xHCI 4.6.9, Stop Endpoint command on a Stopped
+			 * EP is a Context State Error, and EP stays Stopped.
+			 *
+			 * But maybe it failed on Halted, and somebody ran Reset
+			 * Endpoint later. EP state is now Stopped and EP_HALTED
+			 * still set because Reset EP handler will run after us.
+			 */
+			if (ep->ep_state & EP_HALTED)
+				break;
+			/*
+			 * On some HCs EP state remains Stopped for some tens of
+			 * us to a few ms or more after a doorbell ring, and any
+			 * new Stop Endpoint fails without aborting the restart.
+			 * This handler may run quickly enough to still see this
+			 * Stopped state, but it will soon change to Running.
+			 *
+			 * Assume this bug on unexpected Stop Endpoint failures.
+			 * Keep retrying until the EP starts and stops again, on
+			 * chips where this is known to help. Wait for 100ms.
+			 */
+			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
+				break;
+			fallthrough;
 		case EP_STATE_RUNNING:
 			/* Race, HW handled stop ep cmd before ep was running */
-			xhci_dbg(xhci, "Stop ep completion ctx error, ep is running\n");
+			xhci_dbg(xhci, "Stop ep completion ctx error, ctx_state %d\n",
+					GET_EP_CTX_STATE(ep_ctx));
 
 			command = xhci_alloc_command(xhci, false, GFP_ATOMIC);
 			if (!command) {
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index b072154badf3..e726c5edee03 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -8,6 +8,7 @@
  * Some code borrowed from the Linux EHCI driver.
  */
 
+#include <linux/jiffies.h>
 #include <linux/pci.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
@@ -1902,15 +1903,27 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		}
 	}
 
-	/* Queue a stop endpoint command, but only if this is
-	 * the first cancellation to be handled.
-	 */
-	if (!(ep->ep_state & EP_STOP_CMD_PENDING)) {
+	/* These completion handlers will sort out cancelled TDs for us */
+	if (ep->ep_state & (EP_STOP_CMD_PENDING | EP_HALTED | SET_DEQ_PENDING)) {
+		xhci_dbg(xhci, "Not queuing Stop Endpoint on slot %d ep %d in state 0x%x\n",
+				urb->dev->slot_id, ep_index, ep->ep_state);
+		goto done;
+	}
+
+	/* In this case no commands are pending but the endpoint is stopped */
+	if (ep->ep_state & EP_CLEARING_TT) {
+		/* and cancelled TDs can be given back right away */
+		xhci_dbg(xhci, "Invalidating TDs instantly on slot %d ep %d in state 0x%x\n",
+				urb->dev->slot_id, ep_index, ep->ep_state);
+		xhci_process_cancelled_tds(ep);
+	} else {
+		/* Otherwise, queue a new Stop Endpoint command */
 		command = xhci_alloc_command(xhci, false, GFP_ATOMIC);
 		if (!command) {
 			ret = -ENOMEM;
 			goto done;
 		}
+		ep->stop_time = jiffies;
 		ep->ep_state |= EP_STOP_CMD_PENDING;
 		xhci_queue_stop_endpoint(xhci, command, urb->dev->slot_id,
 					 ep_index, 0);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 0b526edf636f..1a641f281c00 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -717,6 +717,7 @@ struct xhci_virt_ep {
 	/* Bandwidth checking storage */
 	struct xhci_bw_info	bw_info;
 	struct list_head	bw_endpoint_list;
+	unsigned long		stop_time;
 	/* Isoch Frame ID checking storage */
 	int			next_frame_id;
 	/* Use new Isoch TRB layout needed for extended TBC support */
@@ -1951,6 +1952,7 @@ void xhci_ring_doorbell_for_active_rings(struct xhci_hcd *xhci,
 void xhci_cleanup_command_queue(struct xhci_hcd *xhci);
 void inc_deq(struct xhci_hcd *xhci, struct xhci_ring *ring);
 unsigned int count_trbs(u64 addr, u64 len);
+void xhci_process_cancelled_tds(struct xhci_virt_ep *ep);
 
 /* xHCI roothub code */
 void xhci_set_link_state(struct xhci_hcd *xhci, struct xhci_port *port,
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 347934eb5198..c7171b286de7 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -404,13 +404,13 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
  * bytes the allocator should try to find free next to the block it returns.
  * This is just a hint and may be ignored by the allocator.
  */
-static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
-			     struct btrfs_root *root,
-			     struct extent_buffer *buf,
-			     struct extent_buffer *parent, int parent_slot,
-			     struct extent_buffer **cow_ret,
-			     u64 search_start, u64 empty_size,
-			     enum btrfs_lock_nesting nest)
+int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
+			  struct btrfs_root *root,
+			  struct extent_buffer *buf,
+			  struct extent_buffer *parent, int parent_slot,
+			  struct extent_buffer **cow_ret,
+			  u64 search_start, u64 empty_size,
+			  enum btrfs_lock_nesting nest)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_disk_key disk_key;
@@ -520,6 +520,8 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		btrfs_free_tree_block(trans, btrfs_root_id(root), buf,
 				      parent_start, last_ref);
 	}
+
+	trace_btrfs_cow_block(root, buf, cow);
 	if (unlock_orig)
 		btrfs_tree_unlock(buf);
 	free_extent_buffer_stale(buf);
@@ -559,7 +561,7 @@ static inline int should_cow_block(struct btrfs_trans_handle *trans,
 }
 
 /*
- * cows a single block, see __btrfs_cow_block for the real work.
+ * COWs a single block, see btrfs_force_cow_block() for the real work.
  * This version of it has extra checks so that a block isn't COWed more than
  * once per transaction, as long as it hasn't been written yet
  */
@@ -571,7 +573,6 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 search_start;
-	int ret;
 
 	if (unlikely(test_bit(BTRFS_ROOT_DELETING, &root->state))) {
 		btrfs_abort_transaction(trans, -EUCLEAN);
@@ -612,12 +613,8 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 	 * Also We don't care about the error, as it's handled internally.
 	 */
 	btrfs_qgroup_trace_subtree_after_cow(trans, root, buf);
-	ret = __btrfs_cow_block(trans, root, buf, parent,
-				 parent_slot, cow_ret, search_start, 0, nest);
-
-	trace_btrfs_cow_block(root, buf, *cow_ret);
-
-	return ret;
+	return btrfs_force_cow_block(trans, root, buf, parent, parent_slot,
+				     cow_ret, search_start, 0, nest);
 }
 ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
 
@@ -764,11 +761,11 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 			search_start = last_block;
 
 		btrfs_tree_lock(cur);
-		err = __btrfs_cow_block(trans, root, cur, parent, i,
-					&cur, search_start,
-					min(16 * blocksize,
-					    (end_slot - i) * blocksize),
-					BTRFS_NESTING_COW);
+		err = btrfs_force_cow_block(trans, root, cur, parent, i,
+					    &cur, search_start,
+					    min(16 * blocksize,
+						(end_slot - i) * blocksize),
+					    BTRFS_NESTING_COW);
 		if (err) {
 			btrfs_tree_unlock(cur);
 			free_extent_buffer(cur);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index cab023927b43..da8986e0c422 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3032,6 +3032,13 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		    struct extent_buffer *parent, int parent_slot,
 		    struct extent_buffer **cow_ret,
 		    enum btrfs_lock_nesting nest);
+int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
+			  struct btrfs_root *root,
+			  struct extent_buffer *buf,
+			  struct extent_buffer *parent, int parent_slot,
+			  struct extent_buffer **cow_ret,
+			  u64 search_start, u64 empty_size,
+			  enum btrfs_lock_nesting nest);
 int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root,
 		      struct extent_buffer *buf,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b7ec38f7e4b9..30fe5ebc3650 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4651,6 +4651,15 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 * already the cleaner, but below we run all pending delayed iputs.
 	 */
 	btrfs_flush_workqueue(fs_info->fixup_workers);
+	/*
+	 * Similar case here, we have to wait for delalloc workers before we
+	 * proceed below and stop the cleaner kthread, otherwise we trigger a
+	 * use-after-tree on the cleaner kthread task_struct when a delalloc
+	 * worker running submit_compressed_extents() adds a delayed iput, which
+	 * does a wake up on the cleaner kthread, which was already freed below
+	 * when we call kthread_stop().
+	 */
+	btrfs_flush_workqueue(fs_info->delalloc_workers);
 
 	/*
 	 * After we parked the cleaner kthread, ordered extents may have
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 16789490078f..b2cded5bf69c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10469,7 +10469,7 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 		 */
 		WRITE_ONCE(priv->status, status);
 	}
-	if (!atomic_dec_return(&priv->pending))
+	if (atomic_dec_and_test(&priv->pending))
 		wake_up(&priv->wait);
 	btrfs_bio_free_csum(bbio);
 	bio_put(&bbio->bio);
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 96d441ca511d..71478a590e83 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3988,6 +3988,7 @@ static bool __query_dir(struct dir_context *ctx, const char *name, int namlen,
 	/* dot and dotdot entries are already reserved */
 	if (!strcmp(".", name) || !strcmp("..", name))
 		return true;
+	d_info->num_scan++;
 	if (ksmbd_share_veto_filename(priv->work->tcon->share_conf, name))
 		return true;
 	if (!match_pattern(name, namlen, priv->search_pattern))
@@ -4148,8 +4149,17 @@ int smb2_query_dir(struct ksmbd_work *work)
 	query_dir_private.info_level		= req->FileInformationClass;
 	dir_fp->readdir_data.private		= &query_dir_private;
 	set_ctx_actor(&dir_fp->readdir_data.ctx, __query_dir);
-
+again:
+	d_info.num_scan = 0;
 	rc = iterate_dir(dir_fp->filp, &dir_fp->readdir_data.ctx);
+	/*
+	 * num_entry can be 0 if the directory iteration stops before reaching
+	 * the end of the directory and no file is matched with the search
+	 * pattern.
+	 */
+	if (rc >= 0 && !d_info.num_entry && d_info.num_scan &&
+	    d_info.out_buf_len > 0)
+		goto again;
 	/*
 	 * req->OutputBufferLength is too small to contain even one entry.
 	 * In this case, it immediately returns OutputBufferLength 0 to client.
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index e761dde2443e..cc47e71c4de1 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -43,6 +43,7 @@ struct ksmbd_dir_info {
 	char		*rptr;
 	int		name_len;
 	int		out_buf_len;
+	int		num_scan;
 	int		num_entry;
 	int		data_count;
 	int		last_entry_offset;
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index b3f5d73ae1d6..6668e92b1cc4 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -34,6 +34,8 @@ extern void hv_init_clocksource(void);
 
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
 
+extern void hv_adj_sched_clock_offset(u64 offset);
+
 static inline notrace u64
 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg, u64 *cur_tsc)
 {
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 83266201746c..9f7dbbb34094 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -587,13 +587,16 @@ static inline int vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
  * vlan_get_protocol - get protocol EtherType.
  * @skb: skbuff to query
  * @type: first vlan protocol
+ * @mac_offset: MAC offset
  * @depth: buffer to store length of eth and vlan tags in bytes
  *
  * Returns the EtherType of the packet, regardless of whether it is
  * vlan encapsulated (normal or hardware accelerated) or not.
  */
-static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
-					 int *depth)
+static inline __be16 __vlan_get_protocol_offset(const struct sk_buff *skb,
+						__be16 type,
+						int mac_offset,
+						int *depth)
 {
 	unsigned int vlan_depth = skb->mac_len, parse_depth = VLAN_MAX_DEPTH;
 
@@ -612,7 +615,8 @@ static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
 		do {
 			struct vlan_hdr vhdr, *vh;
 
-			vh = skb_header_pointer(skb, vlan_depth, sizeof(vhdr), &vhdr);
+			vh = skb_header_pointer(skb, mac_offset + vlan_depth,
+						sizeof(vhdr), &vhdr);
 			if (unlikely(!vh || !--parse_depth))
 				return 0;
 
@@ -627,6 +631,12 @@ static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
 	return type;
 }
 
+static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
+					 int *depth)
+{
+	return __vlan_get_protocol_offset(skb, type, 0, depth);
+}
+
 /**
  * vlan_get_protocol - get protocol EtherType.
  * @skb: skbuff to query
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 1cae12185cf0..2588ddd3512b 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1212,6 +1212,12 @@ static inline bool mlx5_core_is_vf(const struct mlx5_core_dev *dev)
 	return dev->coredev_type == MLX5_COREDEV_VF;
 }
 
+static inline bool mlx5_core_same_coredev_type(const struct mlx5_core_dev *dev1,
+					       const struct mlx5_core_dev *dev2)
+{
+	return dev1->coredev_type == dev2->coredev_type;
+}
+
 static inline bool mlx5_core_is_ecpf(const struct mlx5_core_dev *dev)
 {
 	return dev->caps.embedded_cpu;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d26b57e87f7f..b37e95554271 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -815,7 +815,6 @@ struct hci_conn_params {
 extern struct list_head hci_dev_list;
 extern struct list_head hci_cb_list;
 extern rwlock_t hci_dev_list_lock;
-extern struct mutex hci_cb_list_lock;
 
 #define hci_dev_set_flag(hdev, nr)             set_bit((nr), (hdev)->dev_flags)
 #define hci_dev_clear_flag(hdev, nr)           clear_bit((nr), (hdev)->dev_flags)
@@ -1769,24 +1768,47 @@ struct hci_cb {
 
 	char *name;
 
+	bool (*match)		(struct hci_conn *conn);
 	void (*connect_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*disconn_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*security_cfm)	(struct hci_conn *conn, __u8 status,
-								__u8 encrypt);
+				 __u8 encrypt);
 	void (*key_change_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*role_switch_cfm)	(struct hci_conn *conn, __u8 status, __u8 role);
 };
 
+static inline void hci_cb_lookup(struct hci_conn *conn, struct list_head *list)
+{
+	struct hci_cb *cb, *cpy;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(cb, &hci_cb_list, list) {
+		if (cb->match && cb->match(conn)) {
+			cpy = kmalloc(sizeof(*cpy), GFP_ATOMIC);
+			if (!cpy)
+				break;
+
+			*cpy = *cb;
+			INIT_LIST_HEAD(&cpy->list);
+			list_add_rcu(&cpy->list, list);
+		}
+	}
+	rcu_read_unlock();
+}
+
 static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
 {
-	struct hci_cb *cb;
+	struct list_head list;
+	struct hci_cb *cb, *tmp;
+
+	INIT_LIST_HEAD(&list);
+	hci_cb_lookup(conn, &list);
 
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
+	list_for_each_entry_safe(cb, tmp, &list, list) {
 		if (cb->connect_cfm)
 			cb->connect_cfm(conn, status);
+		kfree(cb);
 	}
-	mutex_unlock(&hci_cb_list_lock);
 
 	if (conn->connect_cfm_cb)
 		conn->connect_cfm_cb(conn, status);
@@ -1794,43 +1816,55 @@ static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
 
 static inline void hci_disconn_cfm(struct hci_conn *conn, __u8 reason)
 {
-	struct hci_cb *cb;
+	struct list_head list;
+	struct hci_cb *cb, *tmp;
+
+	INIT_LIST_HEAD(&list);
+	hci_cb_lookup(conn, &list);
 
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
+	list_for_each_entry_safe(cb, tmp, &list, list) {
 		if (cb->disconn_cfm)
 			cb->disconn_cfm(conn, reason);
+		kfree(cb);
 	}
-	mutex_unlock(&hci_cb_list_lock);
 
 	if (conn->disconn_cfm_cb)
 		conn->disconn_cfm_cb(conn, reason);
 }
 
-static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
+static inline void hci_security_cfm(struct hci_conn *conn, __u8 status,
+				    __u8 encrypt)
 {
-	struct hci_cb *cb;
-	__u8 encrypt;
-
-	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
-		return;
+	struct list_head list;
+	struct hci_cb *cb, *tmp;
 
-	encrypt = test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x00;
+	INIT_LIST_HEAD(&list);
+	hci_cb_lookup(conn, &list);
 
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
+	list_for_each_entry_safe(cb, tmp, &list, list) {
 		if (cb->security_cfm)
 			cb->security_cfm(conn, status, encrypt);
+		kfree(cb);
 	}
-	mutex_unlock(&hci_cb_list_lock);
 
 	if (conn->security_cfm_cb)
 		conn->security_cfm_cb(conn, status);
 }
 
+static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
+{
+	__u8 encrypt;
+
+	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
+		return;
+
+	encrypt = test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x00;
+
+	hci_security_cfm(conn, status, encrypt);
+}
+
 static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 {
-	struct hci_cb *cb;
 	__u8 encrypt;
 
 	if (conn->state == BT_CONFIG) {
@@ -1857,40 +1891,38 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 			conn->sec_level = conn->pending_sec_level;
 	}
 
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
-		if (cb->security_cfm)
-			cb->security_cfm(conn, status, encrypt);
-	}
-	mutex_unlock(&hci_cb_list_lock);
-
-	if (conn->security_cfm_cb)
-		conn->security_cfm_cb(conn, status);
+	hci_security_cfm(conn, status, encrypt);
 }
 
 static inline void hci_key_change_cfm(struct hci_conn *conn, __u8 status)
 {
-	struct hci_cb *cb;
+	struct list_head list;
+	struct hci_cb *cb, *tmp;
+
+	INIT_LIST_HEAD(&list);
+	hci_cb_lookup(conn, &list);
 
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
+	list_for_each_entry_safe(cb, tmp, &list, list) {
 		if (cb->key_change_cfm)
 			cb->key_change_cfm(conn, status);
+		kfree(cb);
 	}
-	mutex_unlock(&hci_cb_list_lock);
 }
 
 static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
 								__u8 role)
 {
-	struct hci_cb *cb;
+	struct list_head list;
+	struct hci_cb *cb, *tmp;
+
+	INIT_LIST_HEAD(&list);
+	hci_cb_lookup(conn, &list);
 
-	mutex_lock(&hci_cb_list_lock);
-	list_for_each_entry(cb, &hci_cb_list, list) {
+	list_for_each_entry_safe(cb, tmp, &list, list) {
 		if (cb->role_switch_cfm)
 			cb->role_switch_cfm(conn, status, role);
+		kfree(cb);
 	}
-	mutex_unlock(&hci_cb_list_lock);
 }
 
 static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index f1ba369306fe..84751313b826 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -57,6 +57,13 @@ struct ip_tunnel_key {
 	__u8			flow_flags;
 };
 
+struct ip_tunnel_encap {
+	u16			type;
+	u16			flags;
+	__be16			sport;
+	__be16			dport;
+};
+
 /* Flags for ip_tunnel_info mode. */
 #define IP_TUNNEL_INFO_TX	0x01	/* represents tx tunnel parameters */
 #define IP_TUNNEL_INFO_IPV6	0x02	/* key contains IPv6 addresses */
@@ -66,9 +73,9 @@ struct ip_tunnel_key {
 #define IP_TUNNEL_OPTS_MAX					\
 	GENMASK((sizeof_field(struct ip_tunnel_info,		\
 			      options_len) * BITS_PER_BYTE) - 1, 0)
-
 struct ip_tunnel_info {
 	struct ip_tunnel_key	key;
+	struct ip_tunnel_encap	encap;
 #ifdef CONFIG_DST_CACHE
 	struct dst_cache	dst_cache;
 #endif
@@ -86,13 +93,6 @@ struct ip_tunnel_6rd_parm {
 };
 #endif
 
-struct ip_tunnel_encap {
-	u16			type;
-	u16			flags;
-	__be16			sport;
-	__be16			dport;
-};
-
 struct ip_tunnel_prl_entry {
 	struct ip_tunnel_prl_entry __rcu *next;
 	__be32				addr;
@@ -293,6 +293,7 @@ struct ip_tunnel *ip_tunnel_lookup(struct ip_tunnel_net *itn,
 				   __be32 remote, __be32 local,
 				   __be32 key);
 
+void ip_tunnel_md_udp_encap(struct sk_buff *skb, struct ip_tunnel_info *info);
 int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		  const struct tnl_ptk_info *tpi, struct metadata_dst *tun_dst,
 		  bool log_ecn_error);
@@ -405,22 +406,23 @@ static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
 	return hlen;
 }
 
-static inline int ip_tunnel_encap(struct sk_buff *skb, struct ip_tunnel *t,
+static inline int ip_tunnel_encap(struct sk_buff *skb,
+				  struct ip_tunnel_encap *e,
 				  u8 *protocol, struct flowi4 *fl4)
 {
 	const struct ip_tunnel_encap_ops *ops;
 	int ret = -EINVAL;
 
-	if (t->encap.type == TUNNEL_ENCAP_NONE)
+	if (e->type == TUNNEL_ENCAP_NONE)
 		return 0;
 
-	if (t->encap.type >= MAX_IPTUN_ENCAP_OPS)
+	if (e->type >= MAX_IPTUN_ENCAP_OPS)
 		return -EINVAL;
 
 	rcu_read_lock();
-	ops = rcu_dereference(iptun_encaps[t->encap.type]);
+	ops = rcu_dereference(iptun_encaps[e->type]);
 	if (likely(ops && ops->build_header))
-		ret = ops->build_header(skb, &t->encap, protocol, fl4);
+		ret = ops->build_header(skb, e, protocol, fl4);
 	rcu_read_unlock();
 
 	return ret;
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index c24b04235d91..d11398aa642e 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -706,15 +706,18 @@ struct nft_set_ext_tmpl {
 /**
  *	struct nft_set_ext - set extensions
  *
- *	@genmask: generation mask
+ *	@genmask: generation mask, but also flags (see NFT_SET_ELEM_DEAD_BIT)
  *	@offset: offsets of individual extension types
  *	@data: beginning of extension data
+ *
+ *	This structure must be aligned to word size, otherwise atomic bitops
+ *	on genmask field can cause alignment failure on some archs.
  */
 struct nft_set_ext {
 	u8	genmask;
 	u8	offset[NFT_SET_EXT_NUM];
 	char	data[];
-};
+} __aligned(BITS_PER_LONG / 8);
 
 static inline void nft_set_ext_prepare(struct nft_set_ext_tmpl *tmpl)
 {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 0ea0d50a7c16..83b416af4da1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -523,6 +523,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 {
+	int err;
+
 	/* Branch offsets can't overflow when program is shrinking, no need
 	 * to call bpf_adj_branches(..., true) here
 	 */
@@ -530,7 +532,9 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 		sizeof(struct bpf_insn) * (prog->len - off - cnt));
 	prog->len -= cnt;
 
-	return WARN_ON_ONCE(bpf_adj_branches(prog, off, off + cnt, off, false));
+	err = bpf_adj_branches(prog, off, off + cnt, off, false);
+	WARN_ON_ONCE(err);
+	return err;
 }
 
 static void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp)
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 9413f27294ca..cb3ecf07a34b 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -165,7 +165,7 @@ static void kcov_remote_area_put(struct kcov_remote_area *area,
  * Unlike in_serving_softirq(), this function returns false when called during
  * a hardirq or an NMI that happened in the softirq context.
  */
-static inline bool in_softirq_really(void)
+static __always_inline bool in_softirq_really(void)
 {
 	return in_serving_softirq() && !in_hardirq() && !in_nmi();
 }
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 75e654c91c24..94bb5f9251b1 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -358,6 +358,18 @@ static bool process_string(const char *fmt, int len, struct trace_event_call *ca
 		s = r + 1;
 	} while (s < e);
 
+	/*
+	 * Check for arrays. If the argument has: foo[REC->val]
+	 * then it is very likely that foo is an array of strings
+	 * that are safe to use.
+	 */
+	r = strstr(s, "[");
+	if (r && r < e) {
+		r = strstr(r, "REC->");
+		if (r && r < e)
+			return true;
+	}
+
 	/*
 	 * If there's any strings in the argument consider this arg OK as it
 	 * could be: REC->field ? "foo" : "bar" and we don't want to get into
diff --git a/mm/readahead.c b/mm/readahead.c
index 794d8ddc0697..e0bef7c0d7af 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -599,7 +599,11 @@ static void ondemand_readahead(struct readahead_control *ractl,
 			1UL << order);
 	if (index == expected || index == (ra->start + ra->size)) {
 		ra->start += ra->size;
-		ra->size = get_next_ra_size(ra, max_pages);
+		/*
+		 * In the case of MADV_HUGEPAGE, the actual size might exceed
+		 * the readahead window.
+		 */
+		ra->size = max(ra->size, get_next_ra_size(ra, max_pages));
 		ra->async_size = ra->size;
 		goto readit;
 	}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4cd0cbf9c121..be863204d7c8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -588,7 +588,14 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
 	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
 		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
-
+	/*
+	 * If there are no reclaimable file-backed or anonymous pages,
+	 * ensure zones with sufficient free pages are not skipped.
+	 * This prevents zones like DMA32 from being ignored in reclaim
+	 * scenarios where they can still help alleviate memory pressure.
+	 */
+	if (nr == 0)
+		nr = zone_page_state_snapshot(zone, NR_FREE_PAGES);
 	return nr;
 }
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3cd7c212375f..496dac042b9c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -58,7 +58,6 @@ DEFINE_RWLOCK(hci_dev_list_lock);
 
 /* HCI callback list */
 LIST_HEAD(hci_cb_list);
-DEFINE_MUTEX(hci_cb_list_lock);
 
 /* HCI ID Numbering */
 static DEFINE_IDA(hci_index_ida);
@@ -2978,9 +2977,7 @@ int hci_register_cb(struct hci_cb *cb)
 {
 	BT_DBG("%p name %s", cb, cb->name);
 
-	mutex_lock(&hci_cb_list_lock);
-	list_add_tail(&cb->list, &hci_cb_list);
-	mutex_unlock(&hci_cb_list_lock);
+	list_add_tail_rcu(&cb->list, &hci_cb_list);
 
 	return 0;
 }
@@ -2990,9 +2987,8 @@ int hci_unregister_cb(struct hci_cb *cb)
 {
 	BT_DBG("%p name %s", cb, cb->name);
 
-	mutex_lock(&hci_cb_list_lock);
-	list_del(&cb->list);
-	mutex_unlock(&hci_cb_list_lock);
+	list_del_rcu(&cb->list);
+	synchronize_rcu();
 
 	return 0;
 }
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 437cbeaa9619..f62df9097f5e 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1579,6 +1579,11 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	return lm;
 }
 
+static bool iso_match(struct hci_conn *hcon)
+{
+	return hcon->type == ISO_LINK || hcon->type == LE_LINK;
+}
+
 static void iso_connect_cfm(struct hci_conn *hcon, __u8 status)
 {
 	if (hcon->type != ISO_LINK) {
@@ -1748,6 +1753,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 static struct hci_cb iso_cb = {
 	.name		= "ISO",
+	.match		= iso_match,
 	.connect_cfm	= iso_connect_cfm,
 	.disconn_cfm	= iso_disconn_cfm,
 };
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 187c91843876..2a8051fae08c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -8273,6 +8273,11 @@ static struct l2cap_chan *l2cap_global_fixed_chan(struct l2cap_chan *c,
 	return NULL;
 }
 
+static bool l2cap_match(struct hci_conn *hcon)
+{
+	return hcon->type == ACL_LINK || hcon->type == LE_LINK;
+}
+
 static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 {
 	struct hci_dev *hdev = hcon->hdev;
@@ -8280,9 +8285,6 @@ static void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 	struct l2cap_chan *pchan;
 	u8 dst_type;
 
-	if (hcon->type != ACL_LINK && hcon->type != LE_LINK)
-		return;
-
 	BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status);
 
 	if (status) {
@@ -8347,9 +8349,6 @@ int l2cap_disconn_ind(struct hci_conn *hcon)
 
 static void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 {
-	if (hcon->type != ACL_LINK && hcon->type != LE_LINK)
-		return;
-
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
 	l2cap_conn_del(hcon, bt_to_errno(reason));
@@ -8637,6 +8636,7 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 
 static struct hci_cb l2cap_cb = {
 	.name		= "L2CAP",
+	.match		= l2cap_match,
 	.connect_cfm	= l2cap_connect_cfm,
 	.disconn_cfm	= l2cap_disconn_cfm,
 	.security_cfm	= l2cap_security_cfm,
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 4f54c7df3a94..1686fa60e278 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2130,6 +2130,11 @@ static int rfcomm_run(void *unused)
 	return 0;
 }
 
+static bool rfcomm_match(struct hci_conn *hcon)
+{
+	return hcon->type == ACL_LINK;
+}
+
 static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 {
 	struct rfcomm_session *s;
@@ -2176,6 +2181,7 @@ static void rfcomm_security_cfm(struct hci_conn *conn, u8 status, u8 encrypt)
 
 static struct hci_cb rfcomm_cb = {
 	.name		= "RFCOMM",
+	.match		= rfcomm_match,
 	.security_cfm	= rfcomm_security_cfm
 };
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index fe8728041ad0..127479bf475b 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1367,11 +1367,13 @@ int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	return lm;
 }
 
-static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
+static bool sco_match(struct hci_conn *hcon)
 {
-	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
-		return;
+	return hcon->type == SCO_LINK || hcon->type == ESCO_LINK;
+}
 
+static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
+{
 	BT_DBG("hcon %p bdaddr %pMR status %u", hcon, &hcon->dst, status);
 
 	if (!status) {
@@ -1386,9 +1388,6 @@ static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 
 static void sco_disconn_cfm(struct hci_conn *hcon, __u8 reason)
 {
-	if (hcon->type != SCO_LINK && hcon->type != ESCO_LINK)
-		return;
-
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
 	sco_conn_del(hcon, bt_to_errno(reason));
@@ -1414,6 +1413,7 @@ void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
 
 static struct hci_cb sco_cb = {
 	.name		= "SCO",
+	.match		= sco_match,
 	.connect_cfm	= sco_connect_cfm,
 	.disconn_cfm	= sco_disconn_cfm,
 };
diff --git a/net/core/dev.c b/net/core/dev.c
index 2ee1a535b3cb..90559cb66803 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3679,8 +3679,10 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
 		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
-		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
+		    !ipv6_has_hopopt_jumbo(skb))
 			goto sw_checksum;
+
 		switch (skb->csum_offset) {
 		case offsetof(struct tcphdr, check):
 		case offsetof(struct udphdr, check):
diff --git a/net/core/sock.c b/net/core/sock.c
index dce8f878f638..168e7f42c054 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1122,7 +1122,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		sk->sk_reuse = (valbool ? SK_CAN_REUSE : SK_NO_REUSE);
 		break;
 	case SO_REUSEPORT:
-		sk->sk_reuseport = valbool;
+		if (valbool && !sk_is_inet(sk))
+			ret = -EOPNOTSUPP;
+		else
+			sk->sk_reuseport = valbool;
 		break;
 	case SO_TYPE:
 	case SO_PROTOCOL:
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 3445e576b05b..67cabc40f1dc 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -43,6 +43,7 @@
 #include <net/rtnetlink.h>
 #include <net/udp.h>
 #include <net/dst_metadata.h>
+#include <net/inet_dscp.h>
 
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ipv6.h>
@@ -102,10 +103,9 @@ struct ip_tunnel *ip_tunnel_lookup(struct ip_tunnel_net *itn,
 		if (!ip_tunnel_key_match(&t->parms, flags, key))
 			continue;
 
-		if (t->parms.link == link)
+		if (READ_ONCE(t->parms.link) == link)
 			return t;
-		else
-			cand = t;
+		cand = t;
 	}
 
 	hlist_for_each_entry_rcu(t, head, hash_node) {
@@ -117,9 +117,9 @@ struct ip_tunnel *ip_tunnel_lookup(struct ip_tunnel_net *itn,
 		if (!ip_tunnel_key_match(&t->parms, flags, key))
 			continue;
 
-		if (t->parms.link == link)
+		if (READ_ONCE(t->parms.link) == link)
 			return t;
-		else if (!cand)
+		if (!cand)
 			cand = t;
 	}
 
@@ -137,9 +137,9 @@ struct ip_tunnel *ip_tunnel_lookup(struct ip_tunnel_net *itn,
 		if (!ip_tunnel_key_match(&t->parms, flags, key))
 			continue;
 
-		if (t->parms.link == link)
+		if (READ_ONCE(t->parms.link) == link)
 			return t;
-		else if (!cand)
+		if (!cand)
 			cand = t;
 	}
 
@@ -150,9 +150,9 @@ struct ip_tunnel *ip_tunnel_lookup(struct ip_tunnel_net *itn,
 		    !(t->dev->flags & IFF_UP))
 			continue;
 
-		if (t->parms.link == link)
+		if (READ_ONCE(t->parms.link) == link)
 			return t;
-		else if (!cand)
+		if (!cand)
 			cand = t;
 	}
 
@@ -221,7 +221,7 @@ static struct ip_tunnel *ip_tunnel_find(struct ip_tunnel_net *itn,
 	hlist_for_each_entry_rcu(t, head, hash_node) {
 		if (local == t->parms.iph.saddr &&
 		    remote == t->parms.iph.daddr &&
-		    link == t->parms.link &&
+		    link == READ_ONCE(t->parms.link) &&
 		    type == t->dev->type &&
 		    ip_tunnel_key_match(&t->parms, flags, key))
 			break;
@@ -294,7 +294,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
 
 		ip_tunnel_init_flow(&fl4, iph->protocol, iph->daddr,
 				    iph->saddr, tunnel->parms.o_key,
-				    RT_TOS(iph->tos), dev_net(dev),
+				    iph->tos & INET_DSCP_MASK, tunnel->net,
 				    tunnel->parms.link, tunnel->fwmark, 0, 0);
 		rt = ip_route_output_key(tunnel->net, &fl4);
 
@@ -359,6 +359,20 @@ static struct ip_tunnel *ip_tunnel_create(struct net *net,
 	return ERR_PTR(err);
 }
 
+void ip_tunnel_md_udp_encap(struct sk_buff *skb, struct ip_tunnel_info *info)
+{
+	const struct iphdr *iph = ip_hdr(skb);
+	const struct udphdr *udph;
+
+	if (iph->protocol != IPPROTO_UDP)
+		return;
+
+	udph = (struct udphdr *)((__u8 *)iph + (iph->ihl << 2));
+	info->encap.sport = udph->source;
+	info->encap.dport = udph->dest;
+}
+EXPORT_SYMBOL(ip_tunnel_md_udp_encap);
+
 int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		  const struct tnl_ptk_info *tpi, struct metadata_dst *tun_dst,
 		  bool log_ecn_error)
@@ -596,10 +610,14 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			tos = ipv6_get_dsfield((const struct ipv6hdr *)inner_iph);
 	}
 	ip_tunnel_init_flow(&fl4, proto, key->u.ipv4.dst, key->u.ipv4.src,
-			    tunnel_id_to_key32(key->tun_id), RT_TOS(tos),
-			    dev_net(dev), 0, skb->mark, skb_get_hash(skb),
-			    key->flow_flags);
-	if (tunnel->encap.type != TUNNEL_ENCAP_NONE)
+			    tunnel_id_to_key32(key->tun_id),
+			    tos & INET_DSCP_MASK, tunnel->net, 0, skb->mark,
+			    skb_get_hash(skb), key->flow_flags);
+
+	if (!tunnel_hlen)
+		tunnel_hlen = ip_encap_hlen(&tun_info->encap);
+
+	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0)
 		goto tx_error;
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
@@ -755,11 +773,11 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	ip_tunnel_init_flow(&fl4, protocol, dst, tnl_params->saddr,
-			    tunnel->parms.o_key, RT_TOS(tos),
-			    dev_net(dev), tunnel->parms.link,
+			    tunnel->parms.o_key, tos & INET_DSCP_MASK,
+			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
-	if (ip_tunnel_encap(skb, tunnel, &protocol, &fl4) < 0)
+	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
 		goto tx_error;
 
 	if (connected && md) {
@@ -876,7 +894,7 @@ static void ip_tunnel_update(struct ip_tunnel_net *itn,
 	if (t->parms.link != p->link || t->fwmark != fwmark) {
 		int mtu;
 
-		t->parms.link = p->link;
+		WRITE_ONCE(t->parms.link, p->link);
 		t->fwmark = fwmark;
 		mtu = ip_tunnel_bind_dev(dev);
 		if (set_mtu)
@@ -1066,9 +1084,9 @@ EXPORT_SYMBOL(ip_tunnel_get_link_net);
 
 int ip_tunnel_get_iflink(const struct net_device *dev)
 {
-	struct ip_tunnel *tunnel = netdev_priv(dev);
+	const struct ip_tunnel *tunnel = netdev_priv(dev);
 
-	return tunnel->parms.link;
+	return READ_ONCE(tunnel->parms.link);
 }
 EXPORT_SYMBOL(ip_tunnel_get_iflink);
 
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 180f9daf5bec..1cf35c50cdf4 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -241,6 +241,7 @@ static int ipip_tunnel_rcv(struct sk_buff *skb, u8 ipproto)
 			tun_dst = ip_tun_rx_dst(skb, 0, 0, 0);
 			if (!tun_dst)
 				return 0;
+			ip_tunnel_md_udp_encap(skb, &tun_dst->u.tun_info);
 		}
 		skb_reset_mac_header(skb);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9ac47ccfe120..2379ee551164 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7124,6 +7124,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 			if (unlikely(!inet_csk_reqsk_queue_hash_add(sk, req,
 								    req->timeout))) {
 				reqsk_free(req);
+				dst_release(dst);
 				return 0;
 			}
 
diff --git a/net/ipv6/ila/ila_xlat.c b/net/ipv6/ila/ila_xlat.c
index 2e7a36a1ea0a..8483116dfa23 100644
--- a/net/ipv6/ila/ila_xlat.c
+++ b/net/ipv6/ila/ila_xlat.c
@@ -201,6 +201,8 @@ static const struct nf_hook_ops ila_nf_hook_ops[] = {
 	},
 };
 
+static DEFINE_MUTEX(ila_mutex);
+
 static int ila_add_mapping(struct net *net, struct ila_xlat_params *xp)
 {
 	struct ila_net *ilan = net_generic(net, ila_net_id);
@@ -208,16 +210,20 @@ static int ila_add_mapping(struct net *net, struct ila_xlat_params *xp)
 	spinlock_t *lock = ila_get_lock(ilan, xp->ip.locator_match);
 	int err = 0, order;
 
-	if (!ilan->xlat.hooks_registered) {
+	if (!READ_ONCE(ilan->xlat.hooks_registered)) {
 		/* We defer registering net hooks in the namespace until the
 		 * first mapping is added.
 		 */
-		err = nf_register_net_hooks(net, ila_nf_hook_ops,
-					    ARRAY_SIZE(ila_nf_hook_ops));
+		mutex_lock(&ila_mutex);
+		if (!ilan->xlat.hooks_registered) {
+			err = nf_register_net_hooks(net, ila_nf_hook_ops,
+						ARRAY_SIZE(ila_nf_hook_ops));
+			if (!err)
+				WRITE_ONCE(ilan->xlat.hooks_registered, true);
+		}
+		mutex_unlock(&ila_mutex);
 		if (err)
 			return err;
-
-		ilan->xlat.hooks_registered = true;
 	}
 
 	ila = kzalloc(sizeof(*ila), GFP_KERNEL);
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 3ffb6a5b1f82..cc24cefdb85c 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1024,7 +1024,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 		ttl = iph6->hop_limit;
 	tos = INET_ECN_encapsulate(tos, ipv6_get_dsfield(iph6));
 
-	if (ip_tunnel_encap(skb, tunnel, &protocol, &fl4) < 0) {
+	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0) {
 		ip_rt_put(rt);
 		goto tx_error;
 	}
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 51bccfb00a9c..61b0159b2fbe 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -124,8 +124,8 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 	if (unlikely(!pskb_may_pull(skb, llc_len)))
 		return 0;
 
-	skb->transport_header += llc_len;
 	skb_pull(skb, llc_len);
+	skb_reset_transport_header(skb);
 	if (skb->protocol == htons(ETH_P_802_2)) {
 		__be16 pdulen;
 		s32 data_size;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 738f1f139a90..e8326e09d1b3 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2436,6 +2436,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			WARN(1, "Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.\n");
 		else
 			WARN(1, "Hardware became unavailable during restart.\n");
+		ieee80211_wake_queues_by_reason(hw, IEEE80211_MAX_QUEUE_MAP,
+						IEEE80211_QUEUE_STOP_REASON_SUSPEND,
+						false);
 		ieee80211_handle_reconfig_failure(local);
 		return res;
 	}
diff --git a/net/mctp/route.c b/net/mctp/route.c
index ea7cb9973128..e72cdd4ce588 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -334,8 +334,13 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 	msk = NULL;
 	rc = -EINVAL;
 
-	/* we may be receiving a locally-routed packet; drop source sk
-	 * accounting
+	/* We may be receiving a locally-routed packet; drop source sk
+	 * accounting.
+	 *
+	 * From here, we will either queue the skb - either to a frag_queue, or
+	 * to a receiving socket. When that succeeds, we clear the skb pointer;
+	 * a non-NULL skb on exit will be otherwise unowned, and hence
+	 * kfree_skb()-ed.
 	 */
 	skb_orphan(skb);
 
@@ -389,7 +394,9 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 		 * pending key.
 		 */
 		if (flags & MCTP_HDR_FLAG_EOM) {
-			sock_queue_rcv_skb(&msk->sk, skb);
+			rc = sock_queue_rcv_skb(&msk->sk, skb);
+			if (!rc)
+				skb = NULL;
 			if (key) {
 				/* we've hit a pending reassembly; not much we
 				 * can do but drop it
@@ -398,7 +405,6 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 						   MCTP_TRACE_KEY_REPLIED);
 				key = NULL;
 			}
-			rc = 0;
 			goto out_unlock;
 		}
 
@@ -425,8 +431,10 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 			 * this function.
 			 */
 			rc = mctp_key_add(key, msk);
-			if (!rc)
+			if (!rc) {
 				trace_mctp_key_acquire(key);
+				skb = NULL;
+			}
 
 			/* we don't need to release key->lock on exit, so
 			 * clean up here and suppress the unlock via
@@ -444,6 +452,8 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 				key = NULL;
 			} else {
 				rc = mctp_frag_queue(key, skb);
+				if (!rc)
+					skb = NULL;
 			}
 		}
 
@@ -458,12 +468,19 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 		else
 			rc = mctp_frag_queue(key, skb);
 
+		if (rc)
+			goto out_unlock;
+
+		/* we've queued; the queue owns the skb now */
+		skb = NULL;
+
 		/* end of message? deliver to socket, and we're done with
 		 * the reassembly/response key
 		 */
-		if (!rc && flags & MCTP_HDR_FLAG_EOM) {
-			sock_queue_rcv_skb(key->sk, key->reasm_head);
-			key->reasm_head = NULL;
+		if (flags & MCTP_HDR_FLAG_EOM) {
+			rc = sock_queue_rcv_skb(key->sk, key->reasm_head);
+			if (!rc)
+				key->reasm_head = NULL;
 			__mctp_key_done_in(key, net, f, MCTP_TRACE_KEY_REPLIED);
 			key = NULL;
 		}
@@ -482,8 +499,7 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 	if (any_key)
 		mctp_key_unref(any_key);
 out:
-	if (rc)
-		kfree_skb(skb);
+	kfree_skb(skb);
 	return rc;
 }
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 517bbfe5f626..e8224e1eb72a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -665,8 +665,15 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 		    &echo, &drop_other_suboptions))
 		return false;
 
+	/*
+	 * Later on, mptcp_write_options() will enforce mutually exclusion with
+	 * DSS, bail out if such option is set and we can't drop it.
+	 */
 	if (drop_other_suboptions)
 		remaining += opt_size;
+	else if (opts->suboptions & OPTION_MPTCP_DSS)
+		return false;
+
 	len = mptcp_add_addr_len(opts->addr.family, echo, !!opts->addr.port);
 	if (remaining < len)
 		return false;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 370afcac2623..0848e63bac65 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -538,13 +538,13 @@ static void mptcp_send_ack(struct mptcp_sock *msk)
 		mptcp_subflow_send_ack(mptcp_subflow_tcp_sock(subflow));
 }
 
-static void mptcp_subflow_cleanup_rbuf(struct sock *ssk)
+static void mptcp_subflow_cleanup_rbuf(struct sock *ssk, int copied)
 {
 	bool slow;
 
 	slow = lock_sock_fast(ssk);
 	if (tcp_can_send_ack(ssk))
-		tcp_cleanup_rbuf(ssk, 1);
+		tcp_cleanup_rbuf(ssk, copied);
 	unlock_sock_fast(ssk, slow);
 }
 
@@ -561,7 +561,7 @@ static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
 			      (ICSK_ACK_PUSHED2 | ICSK_ACK_PUSHED)));
 }
 
-static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
+static void mptcp_cleanup_rbuf(struct mptcp_sock *msk, int copied)
 {
 	int old_space = READ_ONCE(msk->old_wspace);
 	struct mptcp_subflow_context *subflow;
@@ -569,14 +569,14 @@ static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
 	int space =  __mptcp_space(sk);
 	bool cleanup, rx_empty;
 
-	cleanup = (space > 0) && (space >= (old_space << 1));
-	rx_empty = !__mptcp_rmem(sk);
+	cleanup = (space > 0) && (space >= (old_space << 1)) && copied;
+	rx_empty = !__mptcp_rmem(sk) && copied;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		if (cleanup || mptcp_subflow_could_cleanup(ssk, rx_empty))
-			mptcp_subflow_cleanup_rbuf(ssk);
+			mptcp_subflow_cleanup_rbuf(ssk, copied);
 	}
 }
 
@@ -1917,6 +1917,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	goto out;
 }
 
+static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
+
 static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 				struct msghdr *msg,
 				size_t len, int flags,
@@ -1968,6 +1970,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 			break;
 	}
 
+	mptcp_rcv_space_adjust(msk, copied);
 	return copied;
 }
 
@@ -2192,9 +2195,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		copied += bytes_read;
 
-		/* be sure to advertise window change */
-		mptcp_cleanup_rbuf(msk);
-
 		if (skb_queue_empty(&msk->receive_queue) && __mptcp_move_skbs(msk))
 			continue;
 
@@ -2246,7 +2246,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 
 		pr_debug("block timeout %ld\n", timeo);
-		mptcp_rcv_space_adjust(msk, copied);
+		mptcp_cleanup_rbuf(msk, copied);
 		err = sk_wait_data(sk, &timeo, NULL);
 		if (err < 0) {
 			err = copied ? : err;
@@ -2254,7 +2254,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 	}
 
-	mptcp_rcv_space_adjust(msk, copied);
+	mptcp_cleanup_rbuf(msk, copied);
 
 out_err:
 	if (cmsg_flags && copied >= 0) {
diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index bd2b17b219ae..0b270893ee14 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -754,6 +754,12 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	int ret;
 	struct sk_buff *skbn;
 
+	/*
+	 * Reject malformed packets early. Check that it contains at least 2
+	 * addresses and 1 byte more for Time-To-Live
+	 */
+	if (skb->len < 2 * sizeof(ax25_address) + 1)
+		return 0;
 
 	nr_src  = (ax25_address *)(skb->data + 0);
 	nr_dest = (ax25_address *)(skb->data + 7);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 9da9e41899c6..f3bd3e126703 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -541,10 +541,8 @@ static void *packet_current_frame(struct packet_sock *po,
 	return packet_lookup_frame(po, rb, rb->head, status);
 }
 
-static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
+static u16 vlan_get_tci(const struct sk_buff *skb, struct net_device *dev)
 {
-	u8 *skb_orig_data = skb->data;
-	int skb_orig_len = skb->len;
 	struct vlan_hdr vhdr, *vh;
 	unsigned int header_len;
 
@@ -565,33 +563,21 @@ static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
 	else
 		return 0;
 
-	skb_push(skb, skb->data - skb_mac_header(skb));
-	vh = skb_header_pointer(skb, header_len, sizeof(vhdr), &vhdr);
-	if (skb_orig_data != skb->data) {
-		skb->data = skb_orig_data;
-		skb->len = skb_orig_len;
-	}
+	vh = skb_header_pointer(skb, skb_mac_offset(skb) + header_len,
+				sizeof(vhdr), &vhdr);
 	if (unlikely(!vh))
 		return 0;
 
 	return ntohs(vh->h_vlan_TCI);
 }
 
-static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
+static __be16 vlan_get_protocol_dgram(const struct sk_buff *skb)
 {
 	__be16 proto = skb->protocol;
 
-	if (unlikely(eth_type_vlan(proto))) {
-		u8 *skb_orig_data = skb->data;
-		int skb_orig_len = skb->len;
-
-		skb_push(skb, skb->data - skb_mac_header(skb));
-		proto = __vlan_get_protocol(skb, proto, NULL);
-		if (skb_orig_data != skb->data) {
-			skb->data = skb_orig_data;
-			skb->len = skb_orig_len;
-		}
-	}
+	if (unlikely(eth_type_vlan(proto)))
+		proto = __vlan_get_protocol_offset(skb, proto,
+						   skb_mac_offset(skb), NULL);
 
 	return proto;
 }
diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index 2965a12fe8aa..8b97b13d4c2f 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -137,7 +137,8 @@ static struct sctp_association *sctp_association_init(
 		= 5 * asoc->rto_max;
 
 	asoc->timeouts[SCTP_EVENT_TIMEOUT_SACK] = asoc->sackdelay;
-	asoc->timeouts[SCTP_EVENT_TIMEOUT_AUTOCLOSE] = sp->autoclose * HZ;
+	asoc->timeouts[SCTP_EVENT_TIMEOUT_AUTOCLOSE] =
+		(unsigned long)sp->autoclose * HZ;
 
 	/* Initializes the timers */
 	for (i = SCTP_EVENT_TIMEOUT_NONE; i < SCTP_NUM_TIMEOUT_TYPES; ++i)
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index c08beab14a2e..ba09484ef910 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -741,8 +741,8 @@ static void do_input(char *alias,
 
 	for (i = min / BITS_PER_LONG; i < max / BITS_PER_LONG + 1; i++)
 		arr[i] = TO_NATIVE(arr[i]);
-	for (i = min; i < max; i++)
-		if (arr[i / BITS_PER_LONG] & (1L << (i%BITS_PER_LONG)))
+	for (i = min; i <= max; i++)
+		if (arr[i / BITS_PER_LONG] & (1ULL << (i%BITS_PER_LONG)))
 			sprintf(alias + strlen(alias), "%X,*", i);
 }
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 2b8ebd390e37..25599cd5d6ae 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -969,7 +969,10 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 					xpermd->driver))
 			return;
 	} else {
-		BUG();
+		pr_warn_once(
+			"SELinux: unknown extended permission (%u) will be ignored\n",
+			node->datum.u.xperms->specified);
+		return;
 	}
 
 	if (node->key.specified == AVTAB_XPERMS_ALLOWED) {
@@ -1006,7 +1009,8 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 					node->datum.u.xperms->perms.p[i];
 		}
 	} else {
-		BUG();
+		pr_warn_once("SELinux: unknown specified key (%u)\n",
+			     node->key.specified);
 	}
 }
 
diff --git a/sound/core/seq/oss/seq_oss_synth.c b/sound/core/seq/oss/seq_oss_synth.c
index e3394919daa0..51ee4c00a843 100644
--- a/sound/core/seq/oss/seq_oss_synth.c
+++ b/sound/core/seq/oss/seq_oss_synth.c
@@ -66,6 +66,7 @@ static struct seq_oss_synth midi_synth_dev = {
 };
 
 static DEFINE_SPINLOCK(register_lock);
+static DEFINE_MUTEX(sysex_mutex);
 
 /*
  * prototypes
@@ -497,6 +498,7 @@ snd_seq_oss_synth_sysex(struct seq_oss_devinfo *dp, int dev, unsigned char *buf,
 	if (!info)
 		return -ENXIO;
 
+	guard(mutex)(&sysex_mutex);
 	sysex = info->sysex;
 	if (sysex == NULL) {
 		sysex = kzalloc(sizeof(*sysex), GFP_KERNEL);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ef9b0cc339f2..d124a10ab619 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10255,6 +10255,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0xf111, 0x0001, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0xf111, 0x0006, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0xf111, 0x0009, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0xf111, 0x000c, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 
 #if 0
 	/* Below is a quirk table taken from the old code.
@@ -10443,6 +10444,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC255_FIXUP_ACER_HEADPHONE_AND_MIC, .name = "alc255-acer-headphone-and-mic"},
 	{.id = ALC285_FIXUP_HP_GPIO_AMP_INIT, .name = "alc285-hp-amp-init"},
 	{.id = ALC236_FIXUP_LENOVO_INV_DMIC, .name = "alc236-fixup-lenovo-inv-mic"},
+	{.id = ALC2XX_FIXUP_HEADSET_MIC, .name = "alc2xx-fixup-headset-mic"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
diff --git a/sound/usb/format.c b/sound/usb/format.c
index 3b45d0ee7693..3b3a5ea6fcbf 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -60,6 +60,8 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 			pcm_formats |= SNDRV_PCM_FMTBIT_SPECIAL;
 			/* flag potentially raw DSD capable altsettings */
 			fp->dsd_raw = true;
+			/* clear special format bit to avoid "unsupported format" msg below */
+			format &= ~UAC2_FORMAT_TYPE_I_RAW_DATA;
 		}
 
 		format <<= 1;
@@ -71,8 +73,11 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 		sample_width = as->bBitResolution;
 		sample_bytes = as->bSubslotSize;
 
-		if (format & UAC3_FORMAT_TYPE_I_RAW_DATA)
+		if (format & UAC3_FORMAT_TYPE_I_RAW_DATA) {
 			pcm_formats |= SNDRV_PCM_FMTBIT_SPECIAL;
+			/* clear special format bit to avoid "unsupported format" msg below */
+			format &= ~UAC3_FORMAT_TYPE_I_RAW_DATA;
+		}
 
 		format <<= 1;
 		break;
diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index 6eb7d93b358d..20ac32635f1f 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -687,7 +687,7 @@ static int snd_us16x08_meter_get(struct snd_kcontrol *kcontrol,
 	struct usb_mixer_elem_info *elem = kcontrol->private_data;
 	struct snd_usb_audio *chip = elem->head.mixer->chip;
 	struct snd_us16x08_meter_store *store = elem->private_data;
-	u8 meter_urb[64];
+	u8 meter_urb[64] = {0};
 
 	switch (kcontrol->private_value) {
 	case 0: {
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 673591fbf917..6525b02af1b0 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2223,6 +2223,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	DEVICE_FLG(0x2522, 0x0007, /* LH Labs Geek Out HD Audio 1V5 */
 		   QUIRK_FLAG_SET_IFACE_FIRST),
+	DEVICE_FLG(0x262a, 0x9302, /* ddHiFi TC44C */
+		   QUIRK_FLAG_DSD_RAW),
 	DEVICE_FLG(0x2708, 0x0002, /* Audient iD14 */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */

