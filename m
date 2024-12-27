Return-Path: <stable+bounces-106200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FD59FD50A
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 14:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D86162216
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 13:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48461F2C20;
	Fri, 27 Dec 2024 13:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z0G1RWh0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41333150994;
	Fri, 27 Dec 2024 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735307117; cv=none; b=loO3DromAPDaPz+uMncIR+564hFKAHUFv0vgGglOp8mUUPGDItaFvOiCK+bcGXBox8ZPFfCxJpWUn/wfzPkgWoT2OcV+h2LHhVR1BmExNRSd1xS61FV8OYNahCRo284342AeEK4itWYKOjEM3kdsCJ750XP/O7gV3V7ltc2Od0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735307117; c=relaxed/simple;
	bh=rNDcXeIAEY2XzXBF4B7OvYhNFU/qmyp49g7Wk+CHj8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mW7aerImz40LxgT5+qTXq6Xk62QDNJpb9Jwgec+xAsdSX3p7CQURc1vm/XX6/1FRzVrTUdFe1cHfssO2PaTMweFa+4goW7U3MOm/CdKb5tsxhNz3XvyeiE+m8eLXfg+NdXXtlDMgvRLG0b0R7xLBs65sysIWEB4PEb104mDYiiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z0G1RWh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07278C4CED0;
	Fri, 27 Dec 2024 13:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735307116;
	bh=rNDcXeIAEY2XzXBF4B7OvYhNFU/qmyp49g7Wk+CHj8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z0G1RWh07cCi1MHohsGPaGupHBxvxdcjmMqx8gcjJy37JATQ5XyFk/PJBza8r26Hi
	 N5PtWk9hAbyNQWxf93CXbz0yI6rKKXh49UcbEh30eaptfexc0YlN0Vl9lTPi4Z6nPh
	 F/pcYtQuejPhqwVFiOECLZKKQk+EH+puNt643DSQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.122
Date: Fri, 27 Dec 2024 14:45:04 +0100
Message-ID: <2024122704-doorbell-goatskin-6484@gregkh>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2024122703-enrage-panning-ebd6@gregkh>
References: <2024122703-enrage-panning-ebd6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index ddb75912d2a8..23af31992b81 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 121
+SUBLEVEL = 122
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/hexagon/Makefile b/arch/hexagon/Makefile
index 92d005958dfb..ff172cbe5881 100644
--- a/arch/hexagon/Makefile
+++ b/arch/hexagon/Makefile
@@ -32,3 +32,9 @@ KBUILD_LDFLAGS += $(ldflags-y)
 TIR_NAME := r19
 KBUILD_CFLAGS += -ffixed-$(TIR_NAME) -DTHREADINFO_REG=$(TIR_NAME) -D__linux__
 KBUILD_AFLAGS += -DTHREADINFO_REG=$(TIR_NAME)
+
+# Disable HexagonConstExtenders pass for LLVM versions prior to 19.1.0
+# https://github.com/llvm/llvm-project/issues/99714
+ifneq ($(call clang-min-version, 190100),y)
+KBUILD_CFLAGS += -mllvm -hexagon-cext=false
+endif
diff --git a/arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dts b/arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dts
index c945f8565d54..fb180cb2b8e2 100644
--- a/arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dts
+++ b/arch/mips/boot/dts/loongson/loongson64g_4core_ls7a.dts
@@ -33,6 +33,7 @@ msi: msi-controller@2ff00000 {
 		compatible = "loongson,pch-msi-1.0";
 		reg = <0 0x2ff00000 0 0x8>;
 		interrupt-controller;
+		#interrupt-cells = <1>;
 		msi-controller;
 		loongson,msi-base-vec = <64>;
 		loongson,msi-num-vecs = <192>;
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3818c85cf964..43b1df7ec183 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -33,6 +33,26 @@
 u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
 EXPORT_SYMBOL_GPL(kvm_cpu_caps);
 
+struct cpuid_xstate_sizes {
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+};
+
+static struct cpuid_xstate_sizes xstate_sizes[XFEATURE_MAX] __ro_after_init;
+
+void __init kvm_init_xstate_sizes(void)
+{
+	u32 ign;
+	int i;
+
+	for (i = XFEATURE_YMM; i < ARRAY_SIZE(xstate_sizes); i++) {
+		struct cpuid_xstate_sizes *xs = &xstate_sizes[i];
+
+		cpuid_count(0xD, i, &xs->eax, &xs->ebx, &xs->ecx, &ign);
+	}
+}
+
 u32 xstate_required_size(u64 xstate_bv, bool compacted)
 {
 	int feature_bit = 0;
@@ -41,14 +61,15 @@ u32 xstate_required_size(u64 xstate_bv, bool compacted)
 	xstate_bv &= XFEATURE_MASK_EXTEND;
 	while (xstate_bv) {
 		if (xstate_bv & 0x1) {
-		        u32 eax, ebx, ecx, edx, offset;
-		        cpuid_count(0xD, feature_bit, &eax, &ebx, &ecx, &edx);
+			struct cpuid_xstate_sizes *xs = &xstate_sizes[feature_bit];
+			u32 offset;
+
 			/* ECX[1]: 64B alignment in compacted form */
 			if (compacted)
-				offset = (ecx & 0x2) ? ALIGN(ret, 64) : ret;
+				offset = (xs->ecx & 0x2) ? ALIGN(ret, 64) : ret;
 			else
-				offset = ebx;
-			ret = max(ret, offset + eax);
+				offset = xs->ebx;
+			ret = max(ret, offset + xs->eax);
 		}
 
 		xstate_bv >>= 1;
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 18fd2e845989..4be98e1c4cd7 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -32,6 +32,7 @@ int kvm_vcpu_ioctl_get_cpuid2(struct kvm_vcpu *vcpu,
 bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 	       u32 *ecx, u32 *edx, bool exact_only);
 
+void __init kvm_init_xstate_sizes(void);
 u32 xstate_required_size(u64 xstate_bv, bool compacted);
 
 int cpuid_query_maxphyaddr(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4e778ba6a5d4..19ce8199f347 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9712,7 +9712,7 @@ static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
 {
 	u64 ret = vcpu->run->hypercall.ret;
 
-	if (!is_64_bit_mode(vcpu))
+	if (!is_64_bit_hypercall(vcpu))
 		ret = (u32)ret;
 	kvm_rax_write(vcpu, ret);
 	++vcpu->stat.hypercalls;
@@ -13820,6 +13820,8 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_vmgexit_msr_protocol_exit);
 
 static int __init kvm_x86_init(void)
 {
+	kvm_init_xstate_sizes();
+
 	kvm_mmu_x86_module_init();
 	mitigate_smt_rsb &= boot_cpu_has_bug(X86_BUG_SMT_RSB) && cpu_smt_possible();
 	return 0;
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 966aab902d19..b83181357f36 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -530,6 +530,12 @@ static ssize_t backing_dev_store(struct device *dev,
 	}
 
 	nr_pages = i_size_read(inode) >> PAGE_SHIFT;
+	/* Refuse to use zero sized device (also prevents self reference) */
+	if (!nr_pages) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	bitmap_sz = BITS_TO_LONGS(nr_pages) * sizeof(long);
 	bitmap = kvzalloc(bitmap_sz, GFP_KERNEL);
 	if (!bitmap) {
@@ -1162,12 +1168,16 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 	size_t num_pages = disksize >> PAGE_SHIFT;
 	size_t index;
 
+	if (!zram->table)
+		return;
+
 	/* Free all pages that are still in this zram device */
 	for (index = 0; index < num_pages; index++)
 		zram_free_page(zram, index);
 
 	zs_destroy_pool(zram->mem_pool);
 	vfree(zram->table);
+	zram->table = NULL;
 }
 
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
@@ -1716,11 +1726,6 @@ static void zram_reset_device(struct zram *zram)
 
 	zram->limit_pages = 0;
 
-	if (!init_done(zram)) {
-		up_write(&zram->init_lock);
-		return;
-	}
-
 	set_capacity_and_notify(zram->disk, 0);
 	part_stat_set_all(zram->disk->part0, 0);
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5b7d848a6f01..0e03c4908050 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -974,6 +974,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
+	struct cxl_port *iter = port;
 	u16 eig, peig;
 	u8 eiw, peiw;
 
@@ -990,16 +991,26 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 
 	cxlsd = to_cxl_switch_decoder(&cxld->dev);
 	if (cxl_rr->nr_targets_set) {
-		int i, distance;
+		int i, distance = 1;
+		struct cxl_region_ref *cxl_rr_iter;
 
 		/*
-		 * Passthrough decoders impose no distance requirements between
-		 * peers
+		 * The "distance" between peer downstream ports represents which
+		 * endpoint positions in the region interleave a given port can
+		 * host.
+		 *
+		 * For example, at the root of a hierarchy the distance is
+		 * always 1 as every index targets a different host-bridge. At
+		 * each subsequent switch level those ports map every Nth region
+		 * position where N is the width of the switch == distance.
 		 */
-		if (cxl_rr->nr_targets == 1)
-			distance = 0;
-		else
-			distance = p->nr_targets / cxl_rr->nr_targets;
+		do {
+			cxl_rr_iter = cxl_rr_load(iter, cxlr);
+			distance *= cxl_rr_iter->nr_targets;
+			iter = to_cxl_port(iter->dev.parent);
+		} while (!is_cxl_root(iter));
+		distance *= cxlrd->cxlsd.cxld.interleave_ways;
+
 		for (i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
 				rc = check_last_peer(cxled, ep, cxl_rr,
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 2bcdb935a3ac..ef99174d81ce 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -164,7 +164,7 @@ static const struct dma_buf_ops udmabuf_ops = {
 };
 
 #define SEALS_WANTED (F_SEAL_SHRINK)
-#define SEALS_DENIED (F_SEAL_WRITE)
+#define SEALS_DENIED (F_SEAL_WRITE|F_SEAL_FUTURE_WRITE)
 
 static long udmabuf_create(struct miscdevice *device,
 			   struct udmabuf_create_list *head,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index f34bc9bb7045..7f1e92110dd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -150,7 +150,6 @@ void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
 
 void amdgpu_job_free_resources(struct amdgpu_job *job)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
 	struct dma_fence *f;
 	unsigned i;
 
@@ -163,7 +162,7 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 		f = NULL;
 
 	for (i = 0; i < job->num_ibs; ++i)
-		amdgpu_ib_free(ring->adev, &job->ibs[i], f);
+		amdgpu_ib_free(NULL, &job->ibs[i], f);
 }
 
 static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 49a47807c42d..16be61abd998 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1060,10 +1060,9 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	 * next command submission.
 	 */
 	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
-		uint32_t mem_type = bo->tbo.resource->mem_type;
-
-		if (!(bo->preferred_domains &
-		      amdgpu_mem_type_to_domain(mem_type)))
+		if (bo->tbo.resource &&
+		    !(bo->preferred_domains &
+		      amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type)))
 			amdgpu_vm_bo_evicted(&bo_va->base);
 		else
 			amdgpu_vm_bo_idle(&bo_va->base);
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 304004fb80aa..8e6ec75dc687 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -808,14 +808,11 @@ EXPORT_SYMBOL(drm_mode_set_name);
  */
 int drm_mode_vrefresh(const struct drm_display_mode *mode)
 {
-	unsigned int num, den;
+	unsigned int num = 1, den = 1;
 
 	if (mode->htotal == 0 || mode->vtotal == 0)
 		return 0;
 
-	num = mode->clock;
-	den = mode->htotal * mode->vtotal;
-
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
 		num *= 2;
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
@@ -823,6 +820,12 @@ int drm_mode_vrefresh(const struct drm_display_mode *mode)
 	if (mode->vscan > 1)
 		den *= mode->vscan;
 
+	if (check_mul_overflow(mode->clock, num, &num))
+		return 0;
+
+	if (check_mul_overflow(mode->htotal * mode->vtotal, den, &den))
+		return 0;
+
 	return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(num, 1000), den);
 }
 EXPORT_SYMBOL(drm_mode_vrefresh);
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_types.h b/drivers/gpu/drm/i915/gt/intel_engine_types.h
index 107f465a27b9..458320d28e27 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_engine_types.h
@@ -339,6 +339,11 @@ struct intel_engine_guc_stats {
 	 * @start_gt_clk: GT clock time of last idle to active transition.
 	 */
 	u64 start_gt_clk;
+
+	/**
+	 * @total: The last value of total returned
+	 */
+	u64 total;
 };
 
 struct intel_engine_cs {
diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
index 56df4c4a8a1a..2e0eb6cb8eab 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c
@@ -1213,6 +1213,21 @@ static void __get_engine_usage_record(struct intel_engine_cs *engine,
 	} while (++i < 6);
 }
 
+static void __set_engine_usage_record(struct intel_engine_cs *engine,
+				      u32 last_in, u32 id, u32 total)
+{
+	struct iosys_map rec_map = intel_guc_engine_usage_record_map(engine);
+
+#define record_write(map_, field_, val_) \
+	iosys_map_wr_field(map_, 0, struct guc_engine_usage_record, field_, val_)
+
+	record_write(&rec_map, last_switch_in_stamp, last_in);
+	record_write(&rec_map, current_context_index, id);
+	record_write(&rec_map, total_runtime, total);
+
+#undef record_write
+}
+
 static void guc_update_engine_gt_clks(struct intel_engine_cs *engine)
 {
 	struct intel_engine_guc_stats *stats = &engine->stats.guc;
@@ -1331,9 +1346,12 @@ static ktime_t guc_engine_busyness(struct intel_engine_cs *engine, ktime_t *now)
 		total += intel_gt_clock_interval_to_ns(gt, clk);
 	}
 
+	if (total > stats->total)
+		stats->total = total;
+
 	spin_unlock_irqrestore(&guc->timestamp.lock, flags);
 
-	return ns_to_ktime(total);
+	return ns_to_ktime(stats->total);
 }
 
 static void __reset_guc_busyness_stats(struct intel_guc *guc)
@@ -1350,8 +1368,21 @@ static void __reset_guc_busyness_stats(struct intel_guc *guc)
 
 	guc_update_pm_timestamp(guc, &unused);
 	for_each_engine(engine, gt, id) {
+		struct intel_engine_guc_stats *stats = &engine->stats.guc;
+
 		guc_update_engine_gt_clks(engine);
-		engine->stats.guc.prev_total = 0;
+
+		/*
+		 * If resetting a running context, accumulate the active
+		 * time as well since there will be no context switch.
+		 */
+		if (stats->running) {
+			u64 clk = guc->timestamp.gt_stamp - stats->start_gt_clk;
+
+			stats->total_gt_clks += clk;
+		}
+		stats->prev_total = 0;
+		stats->running = 0;
 	}
 
 	spin_unlock_irqrestore(&guc->timestamp.lock, flags);
@@ -1404,6 +1435,9 @@ static void guc_timestamp_ping(struct work_struct *wrk)
 
 static int guc_action_enable_usage_stats(struct intel_guc *guc)
 {
+	struct intel_gt *gt = guc_to_gt(guc);
+	struct intel_engine_cs *engine;
+	enum intel_engine_id id;
 	u32 offset = intel_guc_engine_usage_offset(guc);
 	u32 action[] = {
 		INTEL_GUC_ACTION_SET_ENG_UTIL_BUFF,
@@ -1411,6 +1445,9 @@ static int guc_action_enable_usage_stats(struct intel_guc *guc)
 		0,
 	};
 
+	for_each_engine(engine, gt, id)
+		__set_engine_usage_record(engine, 0, 0xffffffff, 0);
+
 	return intel_guc_send(guc, action, ARRAY_SIZE(action));
 }
 
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index ec2780be74d1..a92a7cd697f4 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -577,9 +577,9 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 			return dev_err_probe(dev, -EPROBE_DEFER, "Cannot get secondary DSI host\n");
 
 		nt->dsi[1] = mipi_dsi_device_register_full(dsi_r_host, info);
-		if (!nt->dsi[1]) {
+		if (IS_ERR(nt->dsi[1])) {
 			dev_err(dev, "Cannot get secondary DSI node\n");
-			return -ENODEV;
+			return PTR_ERR(nt->dsi[1]);
 		}
 		num_dsis++;
 	}
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index d35b60c06114..77017d951826 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -767,6 +767,12 @@ hv_kvp_init(struct hv_util_service *srv)
 	 */
 	kvp_transaction.state = HVUTIL_DEVICE_INIT;
 
+	return 0;
+}
+
+int
+hv_kvp_init_transport(void)
+{
 	hvt = hvutil_transport_init(kvp_devname, CN_KVP_IDX, CN_KVP_VAL,
 				    kvp_on_msg, kvp_on_reset);
 	if (!hvt)
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 0d2184be1691..397f4c8fa46c 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -388,6 +388,12 @@ hv_vss_init(struct hv_util_service *srv)
 	 */
 	vss_transaction.state = HVUTIL_DEVICE_INIT;
 
+	return 0;
+}
+
+int
+hv_vss_init_transport(void)
+{
 	hvt = hvutil_transport_init(vss_devname, CN_VSS_IDX, CN_VSS_VAL,
 				    vss_on_msg, vss_on_reset);
 	if (!hvt) {
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 835e6039c186..ad6c066fd2b7 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -141,6 +141,7 @@ static struct hv_util_service util_heartbeat = {
 static struct hv_util_service util_kvp = {
 	.util_cb = hv_kvp_onchannelcallback,
 	.util_init = hv_kvp_init,
+	.util_init_transport = hv_kvp_init_transport,
 	.util_pre_suspend = hv_kvp_pre_suspend,
 	.util_pre_resume = hv_kvp_pre_resume,
 	.util_deinit = hv_kvp_deinit,
@@ -149,6 +150,7 @@ static struct hv_util_service util_kvp = {
 static struct hv_util_service util_vss = {
 	.util_cb = hv_vss_onchannelcallback,
 	.util_init = hv_vss_init,
+	.util_init_transport = hv_vss_init_transport,
 	.util_pre_suspend = hv_vss_pre_suspend,
 	.util_pre_resume = hv_vss_pre_resume,
 	.util_deinit = hv_vss_deinit,
@@ -592,6 +594,13 @@ static int util_probe(struct hv_device *dev,
 	if (ret)
 		goto error;
 
+	if (srv->util_init_transport) {
+		ret = srv->util_init_transport();
+		if (ret) {
+			vmbus_close(dev->channel);
+			goto error;
+		}
+	}
 	return 0;
 
 error:
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index dc673edf053c..ab12e21bf5fc 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -365,12 +365,14 @@ void vmbus_on_event(unsigned long data);
 void vmbus_on_msg_dpc(unsigned long data);
 
 int hv_kvp_init(struct hv_util_service *srv);
+int hv_kvp_init_transport(void);
 void hv_kvp_deinit(void);
 int hv_kvp_pre_suspend(void);
 int hv_kvp_pre_resume(void);
 void hv_kvp_onchannelcallback(void *context);
 
 int hv_vss_init(struct hv_util_service *srv);
+int hv_vss_init_transport(void);
 void hv_vss_deinit(void);
 int hv_vss_pre_suspend(void);
 int hv_vss_pre_resume(void);
diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index b9a93ee9c236..aaba9521ebef 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -19,15 +19,20 @@
  * the Free Software Foundation; version 2 of the License.
  */
 
+#include <linux/bitops.h>
+#include <linux/bug.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
-#include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include <linux/util_macros.h>
+#include <linux/types.h>
+#include <linux/units.h>
 
 // Common register definition
 #define TMP51X_SHUNT_CONFIG		0x00
@@ -100,8 +105,8 @@
 #define TMP51X_REMOTE_TEMP_LIMIT_2_POS		8
 #define TMP513_REMOTE_TEMP_LIMIT_3_POS		7
 
-#define TMP51X_VBUS_RANGE_32V		32000000
-#define TMP51X_VBUS_RANGE_16V		16000000
+#define TMP51X_VBUS_RANGE_32V		(32 * MICRO)
+#define TMP51X_VBUS_RANGE_16V		(16 * MICRO)
 
 // Max and Min value
 #define MAX_BUS_VOLTAGE_32_LIMIT	32764
@@ -173,7 +178,7 @@ struct tmp51x_data {
 	struct regmap *regmap;
 };
 
-// Set the shift based on the gain 8=4, 4=3, 2=2, 1=1
+// Set the shift based on the gain: 8 -> 1, 4 -> 2, 2 -> 3, 1 -> 4
 static inline u8 tmp51x_get_pga_shift(struct tmp51x_data *data)
 {
 	return 5 - ffs(data->pga_gain);
@@ -195,8 +200,10 @@ static int tmp51x_get_value(struct tmp51x_data *data, u8 reg, u8 pos,
 		 * 2's complement number shifted by one to four depending
 		 * on the pga gain setting. 1lsb = 10uV
 		 */
-		*val = sign_extend32(regval, 17 - tmp51x_get_pga_shift(data));
-		*val = DIV_ROUND_CLOSEST(*val * 10000, data->shunt_uohms);
+		*val = sign_extend32(regval,
+				     reg == TMP51X_SHUNT_CURRENT_RESULT ?
+				     16 - tmp51x_get_pga_shift(data) : 15);
+		*val = DIV_ROUND_CLOSEST(*val * 10 * MILLI, data->shunt_uohms);
 		break;
 	case TMP51X_BUS_VOLTAGE_RESULT:
 	case TMP51X_BUS_VOLTAGE_H_LIMIT:
@@ -211,8 +218,8 @@ static int tmp51x_get_value(struct tmp51x_data *data, u8 reg, u8 pos,
 		break;
 	case TMP51X_BUS_CURRENT_RESULT:
 		// Current = (ShuntVoltage * CalibrationRegister) / 4096
-		*val = sign_extend32(regval, 16) * data->curr_lsb_ua;
-		*val = DIV_ROUND_CLOSEST(*val, 1000);
+		*val = sign_extend32(regval, 15) * (long)data->curr_lsb_ua;
+		*val = DIV_ROUND_CLOSEST(*val, MILLI);
 		break;
 	case TMP51X_LOCAL_TEMP_RESULT:
 	case TMP51X_REMOTE_TEMP_RESULT_1:
@@ -223,7 +230,7 @@ static int tmp51x_get_value(struct tmp51x_data *data, u8 reg, u8 pos,
 	case TMP51X_REMOTE_TEMP_LIMIT_2:
 	case TMP513_REMOTE_TEMP_LIMIT_3:
 		// 1lsb = 0.0625 degrees centigrade
-		*val = sign_extend32(regval, 16) >> TMP51X_TEMP_SHIFT;
+		*val = sign_extend32(regval, 15) >> TMP51X_TEMP_SHIFT;
 		*val = DIV_ROUND_CLOSEST(*val * 625, 10);
 		break;
 	case TMP51X_N_FACTOR_AND_HYST_1:
@@ -252,7 +259,7 @@ static int tmp51x_set_value(struct tmp51x_data *data, u8 reg, long val)
 		 * The user enter current value and we convert it to
 		 * voltage. 1lsb = 10uV
 		 */
-		val = DIV_ROUND_CLOSEST(val * data->shunt_uohms, 10000);
+		val = DIV_ROUND_CLOSEST(val * data->shunt_uohms, 10 * MILLI);
 		max_val = U16_MAX >> tmp51x_get_pga_shift(data);
 		regval = clamp_val(val, -max_val, max_val);
 		break;
@@ -542,18 +549,16 @@ static int tmp51x_calibrate(struct tmp51x_data *data)
 	if (data->shunt_uohms == 0)
 		return regmap_write(data->regmap, TMP51X_SHUNT_CALIBRATION, 0);
 
-	max_curr_ma = DIV_ROUND_CLOSEST_ULL(vshunt_max * 1000 * 1000,
-					    data->shunt_uohms);
+	max_curr_ma = DIV_ROUND_CLOSEST_ULL(vshunt_max * MICRO, data->shunt_uohms);
 
 	/*
 	 * Calculate the minimal bit resolution for the current and the power.
 	 * Those values will be used during register interpretation.
 	 */
-	data->curr_lsb_ua = DIV_ROUND_CLOSEST_ULL(max_curr_ma * 1000, 32767);
+	data->curr_lsb_ua = DIV_ROUND_CLOSEST_ULL(max_curr_ma * MILLI, 32767);
 	data->pwr_lsb_uw = 20 * data->curr_lsb_ua;
 
-	div = DIV_ROUND_CLOSEST_ULL(data->curr_lsb_ua * data->shunt_uohms,
-				    1000 * 1000);
+	div = DIV_ROUND_CLOSEST_ULL(data->curr_lsb_ua * data->shunt_uohms, MICRO);
 
 	return regmap_write(data->regmap, TMP51X_SHUNT_CALIBRATION,
 			    DIV_ROUND_CLOSEST(40960, div));
@@ -628,9 +633,9 @@ static int tmp51x_vbus_range_to_reg(struct device *dev,
 	} else if (data->vbus_range_uvolt == TMP51X_VBUS_RANGE_16V) {
 		data->shunt_config &= ~TMP51X_BUS_VOLTAGE_MASK;
 	} else {
-		dev_err(dev, "ti,bus-range-microvolt is invalid: %u\n",
-			data->vbus_range_uvolt);
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL,
+				     "ti,bus-range-microvolt is invalid: %u\n",
+				     data->vbus_range_uvolt);
 	}
 	return 0;
 }
@@ -646,8 +651,8 @@ static int tmp51x_pga_gain_to_reg(struct device *dev, struct tmp51x_data *data)
 	} else if (data->pga_gain == 1) {
 		data->shunt_config |= CURRENT_SENSE_VOLTAGE_40_MASK;
 	} else {
-		dev_err(dev, "ti,pga-gain is invalid: %u\n", data->pga_gain);
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL,
+				     "ti,pga-gain is invalid: %u\n", data->pga_gain);
 	}
 	return 0;
 }
@@ -679,10 +684,10 @@ static int tmp51x_read_properties(struct device *dev, struct tmp51x_data *data)
 		memcpy(data->nfactor, nfactor, (data->id == tmp513) ? 3 : 2);
 
 	// Check if shunt value is compatible with pga-gain
-	if (data->shunt_uohms > data->pga_gain * 40 * 1000 * 1000) {
-		dev_err(dev, "shunt-resistor: %u too big for pga_gain: %u\n",
-			data->shunt_uohms, data->pga_gain);
-		return -EINVAL;
+	if (data->shunt_uohms > data->pga_gain * 40 * MICRO) {
+		return dev_err_probe(dev, -EINVAL,
+				     "shunt-resistor: %u too big for pga_gain: %u\n",
+				     data->shunt_uohms, data->pga_gain);
 	}
 
 	return 0;
@@ -726,22 +731,17 @@ static int tmp51x_probe(struct i2c_client *client)
 		data->id = i2c_match_id(tmp51x_id, client)->driver_data;
 
 	ret = tmp51x_configure(dev, data);
-	if (ret < 0) {
-		dev_err(dev, "error configuring the device: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "error configuring the device\n");
 
 	data->regmap = devm_regmap_init_i2c(client, &tmp51x_regmap_config);
-	if (IS_ERR(data->regmap)) {
-		dev_err(dev, "failed to allocate register map\n");
-		return PTR_ERR(data->regmap);
-	}
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "failed to allocate register map\n");
 
 	ret = tmp51x_init(data);
-	if (ret < 0) {
-		dev_err(dev, "error configuring the device: %d\n", ret);
-		return -ENODEV;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "error configuring the device\n");
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
 							 data,
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index d2c09b0fdf52..ab87bef50402 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -95,7 +95,7 @@ enum {
 
 static inline int wait_timeout(struct i2c_pnx_algo_data *data)
 {
-	long timeout = data->timeout;
+	long timeout = jiffies_to_msecs(data->timeout);
 	while (timeout > 0 &&
 			(ioread32(I2C_REG_STS(data)) & mstatus_active)) {
 		mdelay(1);
@@ -106,7 +106,7 @@ static inline int wait_timeout(struct i2c_pnx_algo_data *data)
 
 static inline int wait_reset(struct i2c_pnx_algo_data *data)
 {
-	long timeout = data->timeout;
+	long timeout = jiffies_to_msecs(data->timeout);
 	while (timeout > 0 &&
 			(ioread32(I2C_REG_CTL(data)) & mcntrl_reset)) {
 		mdelay(1);
diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index b9959621cc5d..6f8ce656183c 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -325,7 +325,7 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 		if (brl <= (0x1F + 3))
 			break;
 
-		total_ticks /= 2;
+		total_ticks = DIV_ROUND_UP(total_ticks, 2);
 		rate /= 2;
 	}
 
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 62d236bfe937..3d6af49e9180 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1520,7 +1520,6 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
 		  SDHCI_QUIRK_NO_HISPD_BIT |
-		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
diff --git a/drivers/net/ethernet/broadcom/bgmac-platform.c b/drivers/net/ethernet/broadcom/bgmac-platform.c
index b4381cd41979..3f4e8bac40c1 100644
--- a/drivers/net/ethernet/broadcom/bgmac-platform.c
+++ b/drivers/net/ethernet/broadcom/bgmac-platform.c
@@ -171,6 +171,7 @@ static int platform_phy_connect(struct bgmac *bgmac)
 static int bgmac_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct device_node *phy_node;
 	struct bgmac *bgmac;
 	struct resource *regs;
 	int ret;
@@ -236,7 +237,9 @@ static int bgmac_probe(struct platform_device *pdev)
 	bgmac->cco_ctl_maskset = platform_bgmac_cco_ctl_maskset;
 	bgmac->get_bus_clock = platform_bgmac_get_bus_clock;
 	bgmac->cmn_maskset32 = platform_bgmac_cmn_maskset32;
-	if (of_parse_phandle(np, "phy-handle", 0)) {
+	phy_node = of_parse_phandle(np, "phy-handle", 0);
+	if (phy_node) {
+		of_node_put(phy_node);
 		bgmac->phy_connect = platform_phy_connect;
 	} else {
 		bgmac->phy_connect = bgmac_phy_connect_direct;
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
index 1e55b12fee51..5c9f462ac935 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
@@ -346,8 +346,9 @@ static struct sk_buff *copy_gl_to_skb_pkt(const struct pkt_gl *gl,
 	 * driver. Once driver synthesizes cpl_pass_accpet_req the skb will go
 	 * through the regular cpl_pass_accept_req processing in TOM.
 	 */
-	skb = alloc_skb(gl->tot_len + sizeof(struct cpl_pass_accept_req)
-			- pktshift, GFP_ATOMIC);
+	skb = alloc_skb(size_add(gl->tot_len,
+				 sizeof(struct cpl_pass_accept_req)) -
+			pktshift, GFP_ATOMIC);
 	if (unlikely(!skb))
 		return NULL;
 	__skb_put(skb, gl->tot_len + sizeof(struct cpl_pass_accept_req)
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index 2d6906aba2a2..af6100e5d9b9 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -172,6 +172,7 @@ static int create_txqs(struct hinic_dev *nic_dev)
 	hinic_sq_dbgfs_uninit(nic_dev);
 
 	devm_kfree(&netdev->dev, nic_dev->txqs);
+	nic_dev->txqs = NULL;
 	return err;
 }
 
@@ -268,6 +269,7 @@ static int create_rxqs(struct hinic_dev *nic_dev)
 	hinic_rq_dbgfs_uninit(nic_dev);
 
 	devm_kfree(&netdev->dev, nic_dev->rxqs);
+	nic_dev->rxqs = NULL;
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 310a36356f56..71dbdac38020 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1161,7 +1161,7 @@ void ocelot_ifh_set_basic(void *ifh, struct ocelot *ocelot, int port,
 
 	memset(ifh, 0, OCELOT_TAG_LEN);
 	ocelot_ifh_set_bypass(ifh, 1);
-	ocelot_ifh_set_src(ifh, BIT_ULL(ocelot->num_phys_ports));
+	ocelot_ifh_set_src(ifh, ocelot->num_phys_ports);
 	ocelot_ifh_set_dest(ifh, BIT_ULL(port));
 	ocelot_ifh_set_qos_class(ifh, qos_class);
 	ocelot_ifh_set_tag_type(ifh, tag_type);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index d7370fb60a16..928ef2933990 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -828,8 +828,8 @@ static int ionic_get_module_eeprom(struct net_device *netdev,
 	len = min_t(u32, sizeof(xcvr->sprom), ee->len);
 
 	do {
-		memcpy(data, xcvr->sprom, len);
-		memcpy(tbuf, xcvr->sprom, len);
+		memcpy(data, &xcvr->sprom[ee->offset], len);
+		memcpy(tbuf, &xcvr->sprom[ee->offset], len);
 
 		/* Let's make sure we got a consistent copy */
 		if (!memcmp(data, tbuf, len))
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 14865fc245da..b746944bcd2a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3484,8 +3484,8 @@ int ionic_lif_register(struct ionic_lif *lif)
 	/* only register LIF0 for now */
 	err = register_netdev(lif->netdev);
 	if (err) {
-		dev_err(lif->ionic->dev, "Cannot register net device, aborting\n");
-		ionic_lif_unregister_phc(lif);
+		dev_err(lif->ionic->dev, "Cannot register net device: %d, aborting\n", err);
+		ionic_lif_unregister(lif);
 		return err;
 	}
 
diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index b782c35c4ac1..8ada397bc357 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -38,6 +38,7 @@ fwnode_find_pse_control(struct fwnode_handle *fwnode)
 static struct mii_timestamper *
 fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
 {
+	struct mii_timestamper *mii_ts;
 	struct of_phandle_args arg;
 	int err;
 
@@ -51,10 +52,16 @@ fwnode_find_mii_timestamper(struct fwnode_handle *fwnode)
 	else if (err)
 		return ERR_PTR(err);
 
-	if (arg.args_count != 1)
-		return ERR_PTR(-EINVAL);
+	if (arg.args_count != 1) {
+		mii_ts = ERR_PTR(-EINVAL);
+		goto put_node;
+	}
+
+	mii_ts = register_mii_timestamper(arg.np, arg.args[0]);
 
-	return register_mii_timestamper(arg.np, arg.args[0]);
+put_node:
+	of_node_put(arg.np);
+	return mii_ts;
 }
 
 int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
diff --git a/drivers/net/netdevsim/health.c b/drivers/net/netdevsim/health.c
index aa77af4a68df..bc44462c70e2 100644
--- a/drivers/net/netdevsim/health.c
+++ b/drivers/net/netdevsim/health.c
@@ -203,6 +203,8 @@ static ssize_t nsim_dev_health_break_write(struct file *file,
 	char *break_msg;
 	int err;
 
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
 	break_msg = memdup_user_nul(data, count);
 	if (IS_ERR(break_msg))
 		return PTR_ERR(break_msg);
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 67763e5b8c0e..18498619177c 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -595,7 +595,7 @@ struct device_node *__of_get_dma_parent(const struct device_node *np)
 	if (ret < 0)
 		return of_get_parent(np);
 
-	return of_node_get(args.np);
+	return args.np;
 }
 #endif
 
diff --git a/drivers/of/base.c b/drivers/of/base.c
index f849bbb9ef8c..e1b2b9275e68 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1597,8 +1597,10 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 			map_len--;
 
 			/* Check if not found */
-			if (!new)
+			if (!new) {
+				ret = -EINVAL;
 				goto put;
+			}
 
 			if (!of_device_is_available(new))
 				match = 0;
@@ -1608,17 +1610,20 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
 				goto put;
 
 			/* Check for malformed properties */
-			if (WARN_ON(new_size > MAX_PHANDLE_ARGS))
-				goto put;
-			if (map_len < new_size)
+			if (WARN_ON(new_size > MAX_PHANDLE_ARGS) ||
+			    map_len < new_size) {
+				ret = -EINVAL;
 				goto put;
+			}
 
 			/* Move forward by new node's #<list>-cells amount */
 			map += new_size;
 			map_len -= new_size;
 		}
-		if (!match)
+		if (!match) {
+			ret = -ENOENT;
 			goto put;
+		}
 
 		/* Get the <list>-map-pass-thru property (optional) */
 		pass = of_get_property(cur, pass_name, NULL);
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 8c402690d109..8d77566eae1a 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -111,6 +111,7 @@ const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len, struct of_ph
 	else
 		np = of_find_node_by_phandle(be32_to_cpup(imap));
 	imap++;
+	len--;
 
 	/* Check if not found */
 	if (!np) {
@@ -354,6 +355,7 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 		return of_irq_parse_oldworld(device, index, out_irq);
 
 	/* Get the reg property (if any) */
+	addr_len = 0;
 	addr = of_get_property(device, "reg", &addr_len);
 
 	/* Prevent out-of-bounds read in case of longer interrupt parent address size */
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d3924a44db02..fd3020a399cf 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -73,10 +73,6 @@ int pci_host_common_probe(struct platform_device *pdev)
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
-	/* Do not reassign resources if probe only */
-	if (!pci_has_flag(PCI_PROBE_ONLY))
-		pci_add_flags(PCI_REASSIGN_ALL_BUS);
-
 	bridge->sysdata = cfg;
 	bridge->ops = (struct pci_ops *)&ops->pci_ops;
 	bridge->msi_domain = true;
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 5c35884c226e..a1dd614bdc32 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -870,6 +870,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		dev_set_msi_domain(&vmd->bus->dev,
 				   dev_get_msi_domain(&vmd->dev->dev));
 
+	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
+			       "domain"), "Can't create symlink to domain\n");
+
 	vmd_acpi_begin();
 
 	pci_scan_child_bus(vmd->bus);
@@ -907,9 +910,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	pci_bus_add_devices(vmd->bus);
 
 	vmd_acpi_end();
-
-	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
-			       "domain"), "Can't create symlink to domain\n");
 	return 0;
 }
 
@@ -985,8 +985,8 @@ static void vmd_remove(struct pci_dev *dev)
 {
 	struct vmd_dev *vmd = pci_get_drvdata(dev);
 
-	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_stop_root_bus(vmd->bus);
+	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
 	pci_remove_root_bus(vmd->bus);
 	vmd_cleanup_srcu(vmd);
 	vmd_detach_resources(vmd);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 5426f450ce91..1b59e6fc7439 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1384,6 +1384,22 @@ static int aer_probe(struct pcie_device *dev)
 	return 0;
 }
 
+static int aer_suspend(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	aer_disable_rootport(rpc);
+	return 0;
+}
+
+static int aer_resume(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+
+	aer_enable_rootport(rpc);
+	return 0;
+}
+
 /**
  * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
  * @dev: pointer to Root Port, RCEC, or RCiEP
@@ -1455,6 +1471,8 @@ static struct pcie_port_service_driver aerdriver = {
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,
+	.suspend	= aer_suspend,
+	.resume		= aer_resume,
 	.remove		= aer_remove,
 };
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5c1ab9ee65eb..fbb47954a96c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3082,20 +3082,18 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 
 	bus = bridge->bus;
 
+	/* If we must preserve the resource configuration, claim now */
+	if (bridge->preserve_config)
+		pci_bus_claim_resources(bus);
+
 	/*
-	 * We insert PCI resources into the iomem_resource and
-	 * ioport_resource trees in either pci_bus_claim_resources()
-	 * or pci_bus_assign_resources().
+	 * Assign whatever was left unassigned. If we didn't claim above,
+	 * this will reassign everything.
 	 */
-	if (pci_has_flag(PCI_PROBE_ONLY)) {
-		pci_bus_claim_resources(bus);
-	} else {
-		pci_bus_size_bridges(bus);
-		pci_bus_assign_resources(bus);
+	pci_assign_unassigned_root_bus_resources(bus);
 
-		list_for_each_entry(child, &bus->children, node)
-			pcie_bus_configure_settings(child);
-	}
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
 	return 0;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d0da564ac94b..2b3df65005ca 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5008,6 +5008,10 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_BROADCOM, 0x1750, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1751, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0x1752, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x1760, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x1761, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x1762, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_BROADCOM, 0x1763, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pci_quirk_brcm_acs },
 	/* Amazon Annapurna Labs */
 	{ PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index 053be5c5e0ca..eff920de31c2 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -42,8 +42,9 @@ struct p2sb_res_cache {
 };
 
 static struct p2sb_res_cache p2sb_resources[NR_P2SB_RES_CACHE];
+static bool p2sb_hidden_by_bios;
 
-static int p2sb_get_devfn(unsigned int *devfn)
+static void p2sb_get_devfn(unsigned int *devfn)
 {
 	unsigned int fn = P2SB_DEVFN_DEFAULT;
 	const struct x86_cpu_id *id;
@@ -53,7 +54,6 @@ static int p2sb_get_devfn(unsigned int *devfn)
 		fn = (unsigned int)id->driver_data;
 
 	*devfn = fn;
-	return 0;
 }
 
 static bool p2sb_valid_resource(const struct resource *res)
@@ -97,6 +97,12 @@ static void p2sb_scan_and_cache_devfn(struct pci_bus *bus, unsigned int devfn)
 
 static int p2sb_scan_and_cache(struct pci_bus *bus, unsigned int devfn)
 {
+	/*
+	 * The BIOS prevents the P2SB device from being enumerated by the PCI
+	 * subsystem, so we need to unhide and hide it back to lookup the BAR.
+	 */
+	pci_bus_write_config_dword(bus, devfn, P2SBC, 0);
+
 	/* Scan the P2SB device and cache its BAR0 */
 	p2sb_scan_and_cache_devfn(bus, devfn);
 
@@ -104,6 +110,8 @@ static int p2sb_scan_and_cache(struct pci_bus *bus, unsigned int devfn)
 	if (devfn == P2SB_DEVFN_GOLDMONT)
 		p2sb_scan_and_cache_devfn(bus, SPI_DEVFN_GOLDMONT);
 
+	pci_bus_write_config_dword(bus, devfn, P2SBC, P2SBC_HIDE);
+
 	if (!p2sb_valid_resource(&p2sb_resources[PCI_FUNC(devfn)].res))
 		return -ENOENT;
 
@@ -129,12 +137,10 @@ static int p2sb_cache_resources(void)
 	u32 value = P2SBC_HIDE;
 	struct pci_bus *bus;
 	u16 class;
-	int ret;
+	int ret = 0;
 
 	/* Get devfn for P2SB device itself */
-	ret = p2sb_get_devfn(&devfn_p2sb);
-	if (ret)
-		return ret;
+	p2sb_get_devfn(&devfn_p2sb);
 
 	bus = p2sb_get_bus(NULL);
 	if (!bus)
@@ -154,22 +160,53 @@ static int p2sb_cache_resources(void)
 	 */
 	pci_lock_rescan_remove();
 
+	pci_bus_read_config_dword(bus, devfn_p2sb, P2SBC, &value);
+	p2sb_hidden_by_bios = value & P2SBC_HIDE;
+
 	/*
-	 * The BIOS prevents the P2SB device from being enumerated by the PCI
-	 * subsystem, so we need to unhide and hide it back to lookup the BAR.
-	 * Unhide the P2SB device here, if needed.
+	 * If the BIOS does not hide the P2SB device then its resources
+	 * are accesilble. Cache them only if the P2SB device is hidden.
 	 */
-	pci_bus_read_config_dword(bus, devfn_p2sb, P2SBC, &value);
-	if (value & P2SBC_HIDE)
-		pci_bus_write_config_dword(bus, devfn_p2sb, P2SBC, 0);
+	if (p2sb_hidden_by_bios)
+		ret = p2sb_scan_and_cache(bus, devfn_p2sb);
 
-	ret = p2sb_scan_and_cache(bus, devfn_p2sb);
+	pci_unlock_rescan_remove();
 
-	/* Hide the P2SB device, if it was hidden */
-	if (value & P2SBC_HIDE)
-		pci_bus_write_config_dword(bus, devfn_p2sb, P2SBC, P2SBC_HIDE);
+	return ret;
+}
 
-	pci_unlock_rescan_remove();
+static int p2sb_read_from_cache(struct pci_bus *bus, unsigned int devfn,
+				struct resource *mem)
+{
+	struct p2sb_res_cache *cache = &p2sb_resources[PCI_FUNC(devfn)];
+
+	if (cache->bus_dev_id != bus->dev.id)
+		return -ENODEV;
+
+	if (!p2sb_valid_resource(&cache->res))
+		return -ENOENT;
+
+	memcpy(mem, &cache->res, sizeof(*mem));
+
+	return 0;
+}
+
+static int p2sb_read_from_dev(struct pci_bus *bus, unsigned int devfn,
+			      struct resource *mem)
+{
+	struct pci_dev *pdev;
+	int ret = 0;
+
+	pdev = pci_get_slot(bus, devfn);
+	if (!pdev)
+		return -ENODEV;
+
+	if (p2sb_valid_resource(pci_resource_n(pdev, 0)))
+		p2sb_read_bar0(pdev, mem);
+	else
+		ret = -ENOENT;
+
+	pci_dev_put(pdev);
 
 	return ret;
 }
@@ -190,28 +227,17 @@ static int p2sb_cache_resources(void)
  */
 int p2sb_bar(struct pci_bus *bus, unsigned int devfn, struct resource *mem)
 {
-	struct p2sb_res_cache *cache;
-	int ret;
-
 	bus = p2sb_get_bus(bus);
 	if (!bus)
 		return -ENODEV;
 
-	if (!devfn) {
-		ret = p2sb_get_devfn(&devfn);
-		if (ret)
-			return ret;
-	}
+	if (!devfn)
+		p2sb_get_devfn(&devfn);
 
-	cache = &p2sb_resources[PCI_FUNC(devfn)];
-	if (cache->bus_dev_id != bus->dev.id)
-		return -ENODEV;
+	if (p2sb_hidden_by_bios)
+		return p2sb_read_from_cache(bus, devfn, mem);
 
-	if (!p2sb_valid_resource(&cache->res))
-		return -ENOENT;
-
-	memcpy(mem, &cache->res, sizeof(*mem));
-	return 0;
+	return p2sb_read_from_dev(bus, devfn, mem);
 }
 EXPORT_SYMBOL_GPL(p2sb_bar);
 
diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
index d996782a7106..7a73f5e4a1fc 100644
--- a/drivers/sh/clk/core.c
+++ b/drivers/sh/clk/core.c
@@ -295,7 +295,7 @@ int clk_enable(struct clk *clk)
 	int ret;
 
 	if (!clk)
-		return -EINVAL;
+		return 0;
 
 	spin_lock_irqsave(&clock_lock, flags);
 	ret = __clk_enable(clk);
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c5e4fa478e64..c592032657a1 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1093,6 +1093,37 @@ static void tb_exit_redrive(struct tb_port *port)
 	}
 }
 
+static void tb_switch_enter_redrive(struct tb_switch *sw)
+{
+	struct tb_port *port;
+
+	tb_switch_for_each_port(sw, port)
+		tb_enter_redrive(port);
+}
+
+/*
+ * Called during system and runtime suspend to forcefully exit redrive
+ * mode without querying whether the resource is available.
+ */
+static void tb_switch_exit_redrive(struct tb_switch *sw)
+{
+	struct tb_port *port;
+
+	if (!(sw->quirks & QUIRK_KEEP_POWER_IN_DP_REDRIVE))
+		return;
+
+	tb_switch_for_each_port(sw, port) {
+		if (!tb_port_is_dpin(port))
+			continue;
+
+		if (port->redrive) {
+			port->redrive = false;
+			pm_runtime_put(&sw->dev);
+			tb_port_dbg(port, "exit redrive mode\n");
+		}
+	}
+}
+
 static void tb_dp_resource_unavailable(struct tb *tb, struct tb_port *port)
 {
 	struct tb_port *in, *out;
@@ -1548,6 +1579,7 @@ static int tb_start(struct tb *tb)
 	tb_create_usb3_tunnels(tb->root_switch);
 	/* Add DP IN resources for the root switch */
 	tb_add_dp_resources(tb->root_switch);
+	tb_switch_enter_redrive(tb->root_switch);
 	/* Make the discovered switches available to the userspace */
 	device_for_each_child(&tb->root_switch->dev, NULL,
 			      tb_scan_finalize_switch);
@@ -1563,6 +1595,7 @@ static int tb_suspend_noirq(struct tb *tb)
 
 	tb_dbg(tb, "suspending...\n");
 	tb_disconnect_and_release_dp(tb);
+	tb_switch_exit_redrive(tb->root_switch);
 	tb_switch_suspend(tb->root_switch, false);
 	tcm->hotplug_active = false; /* signal tb_handle_hotplug to quit */
 	tb_dbg(tb, "suspend finished\n");
@@ -1665,6 +1698,7 @@ static int tb_resume_noirq(struct tb *tb)
 		tb_dbg(tb, "tunnels restarted, sleeping for 100ms\n");
 		msleep(100);
 	}
+	tb_switch_enter_redrive(tb->root_switch);
 	 /* Allow tb_handle_hotplug to progress events */
 	tcm->hotplug_active = true;
 	tb_dbg(tb, "resume finished\n");
@@ -1728,6 +1762,12 @@ static int tb_runtime_suspend(struct tb *tb)
 	struct tb_cm *tcm = tb_priv(tb);
 
 	mutex_lock(&tb->lock);
+	/*
+	 * The below call only releases DP resources to allow exiting and
+	 * re-entering redrive mode.
+	 */
+	tb_disconnect_and_release_dp(tb);
+	tb_switch_exit_redrive(tb->root_switch);
 	tb_switch_suspend(tb->root_switch, true);
 	tcm->hotplug_active = false;
 	mutex_unlock(&tb->lock);
@@ -1759,6 +1799,7 @@ static int tb_runtime_resume(struct tb *tb)
 	tb_restore_children(tb->root_switch);
 	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
 		tb_tunnel_restart(tunnel);
+	tb_switch_enter_redrive(tb->root_switch);
 	tcm->hotplug_active = true;
 	mutex_unlock(&tb->lock);
 
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 81a9c9d6be08..57d47348dc19 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -44,6 +44,7 @@ struct cdns3_platform_data {
 			bool suspend, bool wakeup);
 	unsigned long quirks;
 #define CDNS3_DEFAULT_PM_RUNTIME_ALLOW	BIT(0)
+#define CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE	BIT(1)
 };
 
 /**
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 33ba30f79b33..8e19ee72c120 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -385,7 +385,7 @@ static irqreturn_t cdns_drd_irq(int irq, void *data)
 int cdns_drd_init(struct cdns *cdns)
 {
 	void __iomem *regs;
-	u32 state;
+	u32 state, reg;
 	int ret;
 
 	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
@@ -429,6 +429,14 @@ int cdns_drd_init(struct cdns *cdns)
 			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
 					      &cdns->otg_v1_regs->ien;
 			writel(1, &cdns->otg_v1_regs->simulate);
+
+			if (cdns->pdata &&
+			    (cdns->pdata->quirks & CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE)) {
+				reg = readl(&cdns->otg_v1_regs->susp_ctrl);
+				reg |= SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE;
+				writel(reg, &cdns->otg_v1_regs->susp_ctrl);
+			}
+
 			cdns->version  = CDNS3_CONTROLLER_V1;
 		} else {
 			dev_err(cdns->dev, "not supporte DID=0x%08x\n", state);
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index d72370c321d3..1e2aee14d629 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -193,6 +193,9 @@ struct cdns_otg_irq_regs {
 /* OTGREFCLK - bitmasks */
 #define OTGREFCLK_STB_CLK_SWITCH_EN	BIT(31)
 
+/* SUPS_CTRL - bitmasks */
+#define SUSP_CTRL_SUSPEND_RESIDENCY_ENABLE	BIT(17)
+
 /* OVERRIDE - bitmasks */
 #define OVERRIDE_IDPULLUP		BIT(0)
 /* Only for CDNS3_CONTROLLER_V0 version */
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index cb29f9fae2f2..1c8141d80e25 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -886,10 +886,10 @@ static void dwc2_gadget_config_nonisoc_xfer_ddma(struct dwc2_hsotg_ep *hs_ep,
 	}
 
 	/* DMA sg buffer */
-	for_each_sg(ureq->sg, sg, ureq->num_sgs, i) {
+	for_each_sg(ureq->sg, sg, ureq->num_mapped_sgs, i) {
 		dwc2_gadget_fill_nonisoc_xfer_ddma_one(hs_ep, &desc,
 			sg_dma_address(sg) + sg->offset, sg_dma_len(sg),
-			sg_is_last(sg));
+			(i == (ureq->num_mapped_sgs - 1)));
 		desc_count += hs_ep->desc_count;
 	}
 
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index ec737fcd2c40..6d80ed3cc540 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -625,6 +625,8 @@ static void option_instat_callback(struct urb *urb);
 #define MEIGSMART_PRODUCT_SRM825L		0x4d22
 /* MeiG Smart SLM320 based on UNISOC UIS8910 */
 #define MEIGSMART_PRODUCT_SLM320		0x4d41
+/* MeiG Smart SLM770A based on ASR1803 */
+#define MEIGSMART_PRODUCT_SLM770A		0x4d57
 
 /* Device flags */
 
@@ -1395,6 +1397,12 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10aa, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c0, 0xff),	/* Telit FE910C04 (rmnet) */
+	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c4, 0xff),	/* Telit FE910C04 (rmnet) */
+	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c8, 0xff),	/* Telit FE910C04 (rmnet) */
+	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(3) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
@@ -2247,6 +2255,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7127, 0xff, 0x00, 0x00),
 	  .driver_info = NCTRL(2) | NCTRL(3) | NCTRL(4) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7129, 0xff, 0x00, 0x00),        /* MediaTek T7XX  */
+	  .driver_info = NCTRL(2) | NCTRL(3) | NCTRL(4) },
 	{ USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MEN200) },
 	{ USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MPL200),
 	  .driver_info = RSVD(1) | RSVD(4) },
@@ -2375,6 +2385,18 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0116, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for Golbal EDU */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0116, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0116, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010a, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WRD for WWAN Ready */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010a, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010a, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010b, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for WWAN Ready */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010b, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010b, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010c, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WRD for WWAN Ready */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010c, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010c, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010d, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for WWAN Ready */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010d, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x010d, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
@@ -2382,9 +2404,14 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM320, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM770A, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0530, 0xff),			/* TCL IK512 MBIM */
+	  .driver_info = NCTRL(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0640, 0xff),			/* TCL IK512 ECM */
+	  .driver_info = NCTRL(3) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 28f5df3b70c8..bf3822b25c58 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1433,6 +1433,11 @@ static int check_extent_item(struct extent_buffer *leaf,
 					   dref_offset, fs_info->sectorsize);
 				return -EUCLEAN;
 			}
+			if (unlikely(btrfs_extent_data_ref_count(leaf, dref) == 0)) {
+				extent_err(leaf, slot,
+			"invalid data ref count, should have non-zero value");
+				return -EUCLEAN;
+			}
 			inline_refs += btrfs_extent_data_ref_count(leaf, dref);
 			break;
 		/* Contains parent bytenr and ref count */
@@ -1445,6 +1450,11 @@ static int check_extent_item(struct extent_buffer *leaf,
 					   inline_offset, fs_info->sectorsize);
 				return -EUCLEAN;
 			}
+			if (unlikely(btrfs_shared_data_ref_count(leaf, sref) == 0)) {
+				extent_err(leaf, slot,
+			"invalid shared data ref count, should have non-zero value");
+				return -EUCLEAN;
+			}
 			inline_refs += btrfs_shared_data_ref_count(leaf, sref);
 			break;
 		default:
@@ -1496,8 +1506,18 @@ static int check_simple_keyed_refs(struct extent_buffer *leaf,
 {
 	u32 expect_item_size = 0;
 
-	if (key->type == BTRFS_SHARED_DATA_REF_KEY)
+	if (key->type == BTRFS_SHARED_DATA_REF_KEY) {
+		struct btrfs_shared_data_ref *sref;
+
+		sref = btrfs_item_ptr(leaf, slot, struct btrfs_shared_data_ref);
+		if (unlikely(btrfs_shared_data_ref_count(leaf, sref) == 0)) {
+			extent_err(leaf, slot,
+		"invalid shared data backref count, should have non-zero value");
+			return -EUCLEAN;
+		}
+
 		expect_item_size = sizeof(struct btrfs_shared_data_ref);
+	}
 
 	if (unlikely(btrfs_item_size(leaf, slot) != expect_item_size)) {
 		generic_err(leaf, slot,
@@ -1557,6 +1577,11 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 				   offset, leaf->fs_info->sectorsize);
 			return -EUCLEAN;
 		}
+		if (unlikely(btrfs_extent_data_ref_count(leaf, dref) == 0)) {
+			extent_err(leaf, slot,
+	"invalid extent data backref count, should have non-zero value");
+			return -EUCLEAN;
+		}
 	}
 	return 0;
 }
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index e292d5c6058e..bd15991166c2 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -420,6 +420,8 @@ static int ceph_parse_mount_param(struct fs_context *fc,
 
 	switch (token) {
 	case Opt_snapdirname:
+		if (strlen(param->string) > NAME_MAX)
+			return invalfc(fc, "snapdirname too long");
 		kfree(fsopt->snapdir_name);
 		fsopt->snapdir_name = param->string;
 		param->string = NULL;
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 939e5e242b98..b3dc7ff42400 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -47,7 +47,7 @@ struct inode *efivarfs_get_inode(struct super_block *sb,
  *
  *	VariableName-12345678-1234-1234-1234-1234567891bc
  */
-bool efivarfs_valid_name(const char *str, int len)
+static bool efivarfs_valid_name(const char *str, int len)
 {
 	const char *s = str + len - EFI_VARIABLE_GUID_LEN;
 
diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
index 8ebf3a6a8aa2..dcb973d8736c 100644
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -50,7 +50,6 @@ bool efivar_variable_is_removable(efi_guid_t vendor, const char *name,
 
 extern const struct file_operations efivarfs_file_operations;
 extern const struct inode_operations efivarfs_dir_inode_operations;
-extern bool efivarfs_valid_name(const char *str, int len);
 extern struct inode *efivarfs_get_inode(struct super_block *sb,
 			const struct inode *dir, int mode, dev_t dev,
 			bool is_removable);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 77c7615bba5e..b8c4641ed152 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -64,9 +64,6 @@ static int efivarfs_d_hash(const struct dentry *dentry, struct qstr *qstr)
 	const unsigned char *s = qstr->name;
 	unsigned int len = qstr->len;
 
-	if (!efivarfs_valid_name(s, len))
-		return -EINVAL;
-
 	while (len-- > EFI_VARIABLE_GUID_LEN)
 		hash = partial_name_hash(*s++, hash);
 
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f296ffb57d05..6101dbe28344 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1237,7 +1237,10 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 				break;
 			}
 		}
-		wake_up(&ep->wq);
+		if (sync)
+			wake_up_sync(&ep->wq);
+		else
+			wake_up(&ep->wq);
 	}
 	if (waitqueue_active(&ep->poll_wait))
 		pwake++;
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index c96d2e76156e..f68286932019 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1196,7 +1196,7 @@ pnfs_prepare_layoutreturn(struct pnfs_layout_hdr *lo,
 		enum pnfs_iomode *iomode)
 {
 	/* Serialise LAYOUTGET/LAYOUTRETURN */
-	if (atomic_read(&lo->plh_outstanding) != 0)
+	if (atomic_read(&lo->plh_outstanding) != 0 && lo->plh_return_seq == 0)
 		return false;
 	if (test_and_set_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags))
 		return false;
diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 13d943df871d..abe3d5e1d84c 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -35,6 +35,7 @@ void nilfs_init_btnc_inode(struct inode *btnc_inode)
 	ii->i_flags = 0;
 	memset(&ii->i_bmap_data, 0, sizeof(struct nilfs_bmap));
 	mapping_set_gfp_mask(btnc_inode->i_mapping, GFP_NOFS);
+	btnc_inode->i_mapping->a_ops = &nilfs_buffer_cache_aops;
 }
 
 void nilfs_btnode_cache_clear(struct address_space *btnc)
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index 2f612288ea45..8cdb1dc76f61 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -163,7 +163,7 @@ int nilfs_init_gcinode(struct inode *inode)
 
 	inode->i_mode = S_IFREG;
 	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
-	inode->i_mapping->a_ops = &empty_aops;
+	inode->i_mapping->a_ops = &nilfs_buffer_cache_aops;
 
 	ii->i_flags = 0;
 	nilfs_bmap_init_gc(ii->i_bmap);
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 8eb4288d46fe..072998626155 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -309,6 +309,10 @@ const struct address_space_operations nilfs_aops = {
 	.is_partially_uptodate  = block_is_partially_uptodate,
 };
 
+const struct address_space_operations nilfs_buffer_cache_aops = {
+	.invalidate_folio	= block_invalidate_folio,
+};
+
 static int nilfs_insert_inode_locked(struct inode *inode,
 				     struct nilfs_root *root,
 				     unsigned long ino)
@@ -614,8 +618,14 @@ struct inode *nilfs_iget(struct super_block *sb, struct nilfs_root *root,
 	inode = nilfs_iget_locked(sb, root, ino);
 	if (unlikely(!inode))
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+
+	if (!(inode->i_state & I_NEW)) {
+		if (!inode->i_nlink) {
+			iput(inode);
+			return ERR_PTR(-ESTALE);
+		}
 		return inode;
+	}
 
 	err = __nilfs_read_inode(sb, root, ino, inode);
 	if (unlikely(err)) {
@@ -748,6 +758,7 @@ struct inode *nilfs_iget_for_shadow(struct inode *inode)
 	NILFS_I(s_inode)->i_flags = 0;
 	memset(NILFS_I(s_inode)->i_bmap, 0, sizeof(struct nilfs_bmap));
 	mapping_set_gfp_mask(s_inode->i_mapping, GFP_NOFS);
+	s_inode->i_mapping->a_ops = &nilfs_buffer_cache_aops;
 
 	err = nilfs_attach_btree_node_cache(s_inode);
 	if (unlikely(err)) {
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index ffaca278acd3..a14f6342a025 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -67,6 +67,11 @@ nilfs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 		inode = NULL;
 	} else {
 		inode = nilfs_iget(dir->i_sb, NILFS_I(dir)->i_root, ino);
+		if (inode == ERR_PTR(-ESTALE)) {
+			nilfs_error(dir->i_sb,
+					"deleted inode referenced: %lu", ino);
+			return ERR_PTR(-EIO);
+		}
 	}
 
 	return d_splice_alias(inode, dentry);
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index ee27bb370d77..5a880b4edf3d 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -379,6 +379,7 @@ extern const struct file_operations nilfs_dir_operations;
 extern const struct inode_operations nilfs_file_inode_operations;
 extern const struct file_operations nilfs_file_operations;
 extern const struct address_space_operations nilfs_aops;
+extern const struct address_space_operations nilfs_buffer_cache_aops;
 extern const struct inode_operations nilfs_dir_inode_operations;
 extern const struct inode_operations nilfs_special_inode_operations;
 extern const struct inode_operations nilfs_symlink_inode_operations;
diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 04169e428fdf..76dd2e35e098 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -170,7 +170,7 @@ static struct buffer_head *udf_fiiter_bread_blk(struct udf_fileident_iter *iter)
 static int udf_fiiter_advance_blk(struct udf_fileident_iter *iter)
 {
 	iter->loffset++;
-	if (iter->loffset < iter->elen >> iter->dir->i_blkbits)
+	if (iter->loffset < DIV_ROUND_UP(iter->elen, 1<<iter->dir->i_blkbits))
 		return 0;
 
 	iter->loffset = 0;
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 811d59cf891b..afc204370901 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1567,6 +1567,7 @@ struct hv_util_service {
 	void *channel;
 	void (*util_cb)(void *);
 	int (*util_init)(struct hv_util_service *);
+	int (*util_init_transport)(void);
 	void (*util_deinit)(void);
 	int (*util_pre_suspend)(void);
 	int (*util_pre_resume)(void);
diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index a8f3058448ea..e0dec1bf917a 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -50,10 +50,8 @@ bool io_is_uring_fops(struct file *file);
 
 static inline void io_uring_files_cancel(void)
 {
-	if (current->io_uring) {
-		io_uring_unreg_ringfd();
+	if (current->io_uring)
 		__io_uring_cancel(false);
-	}
 }
 static inline void io_uring_task_cancel(void)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9e58e5400d78..28f91982402a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1996,14 +1996,13 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma);
  * These helpers provide future and backwards compatibility
  * for accessing popular PCI BAR info
  */
-#define pci_resource_start(dev, bar)	((dev)->resource[(bar)].start)
-#define pci_resource_end(dev, bar)	((dev)->resource[(bar)].end)
-#define pci_resource_flags(dev, bar)	((dev)->resource[(bar)].flags)
-#define pci_resource_len(dev,bar) \
-	((pci_resource_end((dev), (bar)) == 0) ? 0 :	\
-							\
-	 (pci_resource_end((dev), (bar)) -		\
-	  pci_resource_start((dev), (bar)) + 1))
+#define pci_resource_n(dev, bar)	(&(dev)->resource[(bar)])
+#define pci_resource_start(dev, bar)	(pci_resource_n(dev, bar)->start)
+#define pci_resource_end(dev, bar)	(pci_resource_n(dev, bar)->end)
+#define pci_resource_flags(dev, bar)	(pci_resource_n(dev, bar)->flags)
+#define pci_resource_len(dev,bar)					\
+	(pci_resource_end((dev), (bar)) ? 				\
+	 resource_size(pci_resource_n((dev), (bar))) : 0)
 
 /*
  * Similar to the helpers above, these manipulate per-pci_dev
diff --git a/include/linux/wait.h b/include/linux/wait.h
index a0307b516b09..bc06a315653a 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -224,6 +224,7 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
 #define wake_up_all(x)			__wake_up(x, TASK_NORMAL, 0, NULL)
 #define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL, 1)
 #define wake_up_all_locked(x)		__wake_up_locked((x), TASK_NORMAL, 0)
+#define wake_up_sync(x)			__wake_up_sync(x, TASK_NORMAL)
 
 #define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 0b1361663267..9b58ba4616d4 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -434,13 +434,17 @@ static void io_prep_async_link(struct io_kiocb *req)
 	}
 }
 
-void io_queue_iowq(struct io_kiocb *req, bool *dont_use)
+static void io_queue_iowq(struct io_kiocb *req)
 {
 	struct io_kiocb *link = io_prep_linked_timeout(req);
 	struct io_uring_task *tctx = req->task->io_uring;
 
 	BUG_ON(!tctx);
-	BUG_ON(!tctx->io_wq);
+
+	if ((current->flags & PF_KTHREAD) || !tctx->io_wq) {
+		io_req_task_queue_fail(req, -ECANCELED);
+		return;
+	}
 
 	/* init ->work of the whole link before punting */
 	io_prep_async_link(req);
@@ -1909,7 +1913,7 @@ static void io_queue_async(struct io_kiocb *req, int ret)
 		break;
 	case IO_APOLL_ABORTED:
 		io_kbuf_recycle(req, 0);
-		io_queue_iowq(req, NULL);
+		io_queue_iowq(req);
 		break;
 	case IO_APOLL_OK:
 		break;
@@ -1958,7 +1962,7 @@ static void io_queue_sqe_fallback(struct io_kiocb *req)
 		if (unlikely(req->ctx->drain_active))
 			io_drain_req(req);
 		else
-			io_queue_iowq(req, NULL);
+			io_queue_iowq(req);
 	}
 }
 
@@ -3085,6 +3089,7 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
 
 void __io_uring_cancel(bool cancel_all)
 {
+	io_uring_unreg_ringfd();
 	io_uring_cancel_generic(cancel_all, NULL);
 }
 
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 3b87f5421eb6..a1f679b8199e 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -54,7 +54,6 @@ static inline bool io_req_ffs_set(struct io_kiocb *req)
 void __io_req_task_work_add(struct io_kiocb *req, bool allow_local);
 bool io_alloc_async_data(struct io_kiocb *req);
 void io_req_task_queue(struct io_kiocb *req);
-void io_queue_iowq(struct io_kiocb *req, bool *dont_use);
 void io_req_task_complete(struct io_kiocb *req, bool *locked);
 void io_req_task_queue_fail(struct io_kiocb *req, int ret);
 void io_req_task_submit(struct io_kiocb *req, bool *locked);
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 9d6e17a244ae..692663bd864f 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -167,12 +167,6 @@ static inline loff_t *io_kiocb_update_pos(struct io_kiocb *req)
 	return NULL;
 }
 
-static void io_req_task_queue_reissue(struct io_kiocb *req)
-{
-	req->io_task_work.func = io_queue_iowq;
-	io_req_task_work_add(req);
-}
-
 #ifdef CONFIG_BLOCK
 static bool io_resubmit_prep(struct io_kiocb *req)
 {
@@ -341,7 +335,7 @@ static int kiocb_done(struct io_kiocb *req, ssize_t ret,
 	if (req->flags & REQ_F_REISSUE) {
 		req->flags &= ~REQ_F_REISSUE;
 		if (io_resubmit_prep(req))
-			io_req_task_queue_reissue(req);
+			return -EAGAIN;
 		else
 			io_req_task_queue_fail(req, final_ret);
 	}
@@ -691,7 +685,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_t mode)
 	return 0;
 }
 
-int io_read(struct io_kiocb *req, unsigned int issue_flags)
+static int __io_read(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 	struct io_rw_state __s, *s = &__s;
@@ -757,6 +751,14 @@ int io_read(struct io_kiocb *req, unsigned int issue_flags)
 
 	ret = io_iter_do_read(rw, &s->iter);
 
+	/*
+	 * Some file systems like to return -EOPNOTSUPP for an IOCB_NOWAIT
+	 * issue, even though they should be returning -EAGAIN. To be safe,
+	 * retry from blocking context for either.
+	 */
+	if (ret == -EOPNOTSUPP && force_nonblock)
+		ret = -EAGAIN;
+
 	if (ret == -EAGAIN || (req->flags & REQ_F_REISSUE)) {
 		req->flags &= ~REQ_F_REISSUE;
 		/* if we can poll, just do that */
@@ -836,7 +838,18 @@ int io_read(struct io_kiocb *req, unsigned int issue_flags)
 	/* it's faster to check here then delegate to kfree */
 	if (iovec)
 		kfree(iovec);
-	return kiocb_done(req, ret, issue_flags);
+	return ret;
+}
+
+int io_read(struct io_kiocb *req, unsigned int issue_flags)
+{
+	int ret;
+
+	ret = __io_read(req, issue_flags);
+	if (ret >= 0)
+		return kiocb_done(req, ret, issue_flags);
+
+	return ret;
 }
 
 static bool io_kiocb_start_write(struct io_kiocb *req, struct kiocb *kiocb)
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 24859d964505..75e654c91c24 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -242,19 +242,16 @@ int trace_event_get_offsets(struct trace_event_call *call)
 	return tail->offset + tail->size;
 }
 
-/*
- * Check if the referenced field is an array and return true,
- * as arrays are OK to dereference.
- */
-static bool test_field(const char *fmt, struct trace_event_call *call)
+
+static struct trace_event_fields *find_event_field(const char *fmt,
+						   struct trace_event_call *call)
 {
 	struct trace_event_fields *field = call->class->fields_array;
-	const char *array_descriptor;
 	const char *p = fmt;
 	int len;
 
 	if (!(len = str_has_prefix(fmt, "REC->")))
-		return false;
+		return NULL;
 	fmt += len;
 	for (p = fmt; *p; p++) {
 		if (!isalnum(*p) && *p != '_')
@@ -263,16 +260,120 @@ static bool test_field(const char *fmt, struct trace_event_call *call)
 	len = p - fmt;
 
 	for (; field->type; field++) {
-		if (strncmp(field->name, fmt, len) ||
-		    field->name[len])
+		if (strncmp(field->name, fmt, len) || field->name[len])
 			continue;
-		array_descriptor = strchr(field->type, '[');
-		/* This is an array and is OK to dereference. */
-		return array_descriptor != NULL;
+
+		return field;
+	}
+	return NULL;
+}
+
+/*
+ * Check if the referenced field is an array and return true,
+ * as arrays are OK to dereference.
+ */
+static bool test_field(const char *fmt, struct trace_event_call *call)
+{
+	struct trace_event_fields *field;
+
+	field = find_event_field(fmt, call);
+	if (!field)
+		return false;
+
+	/* This is an array and is OK to dereference. */
+	return strchr(field->type, '[') != NULL;
+}
+
+/* Look for a string within an argument */
+static bool find_print_string(const char *arg, const char *str, const char *end)
+{
+	const char *r;
+
+	r = strstr(arg, str);
+	return r && r < end;
+}
+
+/* Return true if the argument pointer is safe */
+static bool process_pointer(const char *fmt, int len, struct trace_event_call *call)
+{
+	const char *r, *e, *a;
+
+	e = fmt + len;
+
+	/* Find the REC-> in the argument */
+	r = strstr(fmt, "REC->");
+	if (r && r < e) {
+		/*
+		 * Addresses of events on the buffer, or an array on the buffer is
+		 * OK to dereference. There's ways to fool this, but
+		 * this is to catch common mistakes, not malicious code.
+		 */
+		a = strchr(fmt, '&');
+		if ((a && (a < r)) || test_field(r, call))
+			return true;
+	} else if (find_print_string(fmt, "__get_dynamic_array(", e)) {
+		return true;
+	} else if (find_print_string(fmt, "__get_rel_dynamic_array(", e)) {
+		return true;
+	} else if (find_print_string(fmt, "__get_dynamic_array_len(", e)) {
+		return true;
+	} else if (find_print_string(fmt, "__get_rel_dynamic_array_len(", e)) {
+		return true;
+	} else if (find_print_string(fmt, "__get_sockaddr(", e)) {
+		return true;
+	} else if (find_print_string(fmt, "__get_rel_sockaddr(", e)) {
+		return true;
 	}
 	return false;
 }
 
+/* Return true if the string is safe */
+static bool process_string(const char *fmt, int len, struct trace_event_call *call)
+{
+	const char *r, *e, *s;
+
+	e = fmt + len;
+
+	/*
+	 * There are several helper functions that return strings.
+	 * If the argument contains a function, then assume its field is valid.
+	 * It is considered that the argument has a function if it has:
+	 *   alphanumeric or '_' before a parenthesis.
+	 */
+	s = fmt;
+	do {
+		r = strstr(s, "(");
+		if (!r || r >= e)
+			break;
+		for (int i = 1; r - i >= s; i++) {
+			char ch = *(r - i);
+			if (isspace(ch))
+				continue;
+			if (isalnum(ch) || ch == '_')
+				return true;
+			/* Anything else, this isn't a function */
+			break;
+		}
+		/* A function could be wrapped in parethesis, try the next one */
+		s = r + 1;
+	} while (s < e);
+
+	/*
+	 * If there's any strings in the argument consider this arg OK as it
+	 * could be: REC->field ? "foo" : "bar" and we don't want to get into
+	 * verifying that logic here.
+	 */
+	if (find_print_string(fmt, "\"", e))
+		return true;
+
+	/* Dereferenced strings are also valid like any other pointer */
+	if (process_pointer(fmt, len, call))
+		return true;
+
+	/* Make sure the field is found, and consider it OK for now if it is */
+	return find_event_field(fmt, call) != NULL;
+}
+
 /*
  * Examine the print fmt of the event looking for unsafe dereference
  * pointers using %p* that could be recorded in the trace event and
@@ -282,13 +383,14 @@ static bool test_field(const char *fmt, struct trace_event_call *call)
 static void test_event_printk(struct trace_event_call *call)
 {
 	u64 dereference_flags = 0;
+	u64 string_flags = 0;
 	bool first = true;
-	const char *fmt, *c, *r, *a;
+	const char *fmt;
 	int parens = 0;
 	char in_quote = 0;
 	int start_arg = 0;
 	int arg = 0;
-	int i;
+	int i, e;
 
 	fmt = call->print_fmt;
 
@@ -372,8 +474,16 @@ static void test_event_printk(struct trace_event_call *call)
 						star = true;
 						continue;
 					}
-					if ((fmt[i + j] == 's') && star)
-						arg++;
+					if ((fmt[i + j] == 's')) {
+						if (star)
+							arg++;
+						if (WARN_ONCE(arg == 63,
+							      "Too many args for event: %s",
+							      trace_event_name(call)))
+							return;
+						dereference_flags |= 1ULL << arg;
+						string_flags |= 1ULL << arg;
+					}
 					break;
 				}
 				break;
@@ -401,42 +511,47 @@ static void test_event_printk(struct trace_event_call *call)
 		case ',':
 			if (in_quote || parens)
 				continue;
+			e = i;
 			i++;
 			while (isspace(fmt[i]))
 				i++;
-			start_arg = i;
-			if (!(dereference_flags & (1ULL << arg)))
-				goto next_arg;
 
-			/* Find the REC-> in the argument */
-			c = strchr(fmt + i, ',');
-			r = strstr(fmt + i, "REC->");
-			if (r && (!c || r < c)) {
-				/*
-				 * Addresses of events on the buffer,
-				 * or an array on the buffer is
-				 * OK to dereference.
-				 * There's ways to fool this, but
-				 * this is to catch common mistakes,
-				 * not malicious code.
-				 */
-				a = strchr(fmt + i, '&');
-				if ((a && (a < r)) || test_field(r, call))
+			/*
+			 * If start_arg is zero, then this is the start of the
+			 * first argument. The processing of the argument happens
+			 * when the end of the argument is found, as it needs to
+			 * handle paranthesis and such.
+			 */
+			if (!start_arg) {
+				start_arg = i;
+				/* Balance out the i++ in the for loop */
+				i--;
+				continue;
+			}
+
+			if (dereference_flags & (1ULL << arg)) {
+				if (string_flags & (1ULL << arg)) {
+					if (process_string(fmt + start_arg, e - start_arg, call))
+						dereference_flags &= ~(1ULL << arg);
+				} else if (process_pointer(fmt + start_arg, e - start_arg, call))
 					dereference_flags &= ~(1ULL << arg);
-			} else if ((r = strstr(fmt + i, "__get_dynamic_array(")) &&
-				   (!c || r < c)) {
-				dereference_flags &= ~(1ULL << arg);
-			} else if ((r = strstr(fmt + i, "__get_sockaddr(")) &&
-				   (!c || r < c)) {
-				dereference_flags &= ~(1ULL << arg);
 			}
 
-		next_arg:
-			i--;
+			start_arg = i;
 			arg++;
+			/* Balance out the i++ in the for loop */
+			i--;
 		}
 	}
 
+	if (dereference_flags & (1ULL << arg)) {
+		if (string_flags & (1ULL << arg)) {
+			if (process_string(fmt + start_arg, i - start_arg, call))
+				dereference_flags &= ~(1ULL << arg);
+		} else if (process_pointer(fmt + start_arg, i - start_arg, call))
+			dereference_flags &= ~(1ULL << arg);
+	}
+
 	/*
 	 * If you triggered the below warning, the trace event reported
 	 * uses an unsafe dereference pointer %p*. As the data stored
diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index 902ff2f3bc72..5cc35b553a04 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -611,6 +611,8 @@ init_list_set(struct net *net, struct ip_set *set, u32 size)
 	return true;
 }
 
+static struct lock_class_key list_set_lockdep_key;
+
 static int
 list_set_create(struct net *net, struct ip_set *set, struct nlattr *tb[],
 		u32 flags)
@@ -627,6 +629,7 @@ list_set_create(struct net *net, struct ip_set *set, struct nlattr *tb[],
 	if (size < IP_SET_LIST_MIN_SIZE)
 		size = IP_SET_LIST_MIN_SIZE;
 
+	lockdep_set_class(&set->lock, &list_set_lockdep_key);
 	set->variant = &set_variant;
 	set->dsize = ip_set_elem_len(set, tb, sizeof(struct set_elem),
 				     __alignof__(struct set_elem));
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 73e8caeffd47..eee9ebad35a5 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1541,7 +1541,6 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	b->backlogs[idx]    -= len;
 	b->tin_backlog      -= len;
 	sch->qstats.backlog -= len;
-	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	flow->dropped++;
 	b->tin_dropped++;
@@ -1552,6 +1551,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 
 	__qdisc_drop(skb, to_free);
 	sch->q.qlen--;
+	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	cake_heapify(q, 0);
 
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index 3ac3e5c80b6f..e38cf3428701 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -123,10 +123,10 @@ static void choke_drop_by_idx(struct Qdisc *sch, unsigned int idx,
 	if (idx == q->tail)
 		choke_zap_tail_holes(q);
 
+	--sch->q.qlen;
 	qdisc_qstats_backlog_dec(sch, skb);
 	qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
 	qdisc_drop(skb, sch, to_free);
-	--sch->q.qlen;
 }
 
 struct choke_skb_cb {
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 868e722aef06..e2bdd6aa3d89 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1988,6 +1988,8 @@ static int smc_listen_prfx_check(struct smc_sock *new_smc,
 	if (pclc->hdr.typev1 == SMC_TYPE_N)
 		return 0;
 	pclc_prfx = smc_clc_proposal_get_prefix(pclc);
+	if (!pclc_prfx)
+		return -EPROTO;
 	if (smc_clc_prfx_match(newclcsock, pclc_prfx))
 		return SMC_CLC_DECL_DIFFPREFIX;
 
@@ -2094,6 +2096,8 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
 	pclc_smcd = smc_get_clc_msg_smcd(pclc);
 	smc_v2_ext = smc_get_clc_v2_ext(pclc);
 	smcd_v2_ext = smc_get_clc_smcd_v2_ext(smc_v2_ext);
+	if (!pclc_smcd || !smc_v2_ext || !smcd_v2_ext)
+		goto not_found;
 
 	mutex_lock(&smcd_dev_list.mutex);
 	if (pclc_smcd->ism.chid)
@@ -2153,7 +2157,9 @@ static void smc_find_ism_v1_device_serv(struct smc_sock *new_smc,
 	int rc = 0;
 
 	/* check if ISM V1 is available */
-	if (!(ini->smcd_version & SMC_V1) || !smcd_indicated(ini->smc_type_v1))
+	if (!(ini->smcd_version & SMC_V1) ||
+	    !smcd_indicated(ini->smc_type_v1) ||
+	    !pclc_smcd)
 		goto not_found;
 	ini->is_smcd = true; /* prepare ISM check */
 	ini->ism_peer_gid[0] = ntohll(pclc_smcd->ism.gid);
@@ -2789,6 +2795,13 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 			} else {
 				sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 				set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+
+				if (sk->sk_state != SMC_INIT) {
+					/* Race breaker the same way as tcp_poll(). */
+					smp_mb__after_atomic();
+					if (atomic_read(&smc->conn.sndbuf_space))
+						mask |= EPOLLOUT | EPOLLWRNORM;
+				}
 			}
 			if (atomic_read(&smc->conn.bytes_to_rcv))
 				mask |= EPOLLIN | EPOLLRDNORM;
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 867df4522815..a48fdc83fe6b 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -354,6 +354,10 @@ static bool smc_clc_msg_prop_valid(struct smc_clc_msg_proposal *pclc)
 
 	v2_ext = smc_get_clc_v2_ext(pclc);
 	pclc_prfx = smc_clc_proposal_get_prefix(pclc);
+	if (!pclc_prfx ||
+	    pclc_prfx->ipv6_prefixes_cnt > SMC_CLC_MAX_V6_PREFIX)
+		return false;
+
 	if (hdr->version == SMC_V1) {
 		if (hdr->typev1 == SMC_TYPE_N)
 			return false;
@@ -749,6 +753,11 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 						SMC_CLC_RECV_BUF_LEN : datlen;
 		iov_iter_kvec(&msg.msg_iter, ITER_DEST, &vec, 1, recvlen);
 		len = sock_recvmsg(smc->clcsock, &msg, krflags);
+		if (len < recvlen) {
+			smc->sk.sk_err = EPROTO;
+			reason_code = -EPROTO;
+			goto out;
+		}
 		datlen -= len;
 	}
 	if (clcm->type == SMC_CLC_DECLINE) {
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 5fee545c9a10..0f6102cd5de1 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -303,8 +303,12 @@ struct smc_clc_msg_decline_v2 {	/* clc decline message */
 static inline struct smc_clc_msg_proposal_prefix *
 smc_clc_proposal_get_prefix(struct smc_clc_msg_proposal *pclc)
 {
+	u16 offset = ntohs(pclc->iparea_offset);
+
+	if (offset > sizeof(struct smc_clc_msg_smcd))
+		return NULL;
 	return (struct smc_clc_msg_proposal_prefix *)
-	       ((u8 *)pclc + sizeof(*pclc) + ntohs(pclc->iparea_offset));
+	       ((u8 *)pclc + sizeof(*pclc) + offset);
 }
 
 static inline bool smcr_indicated(int smc_type)
@@ -357,9 +361,15 @@ smc_get_clc_v2_ext(struct smc_clc_msg_proposal *prop)
 static inline struct smc_clc_smcd_v2_extension *
 smc_get_clc_smcd_v2_ext(struct smc_clc_v2_extension *prop_v2ext)
 {
+	u16 max_offset = offsetof(struct smc_clc_msg_proposal_area, pclc_smcd_v2_ext) -
+		offsetof(struct smc_clc_msg_proposal_area, pclc_v2_ext) -
+		offsetof(struct smc_clc_v2_extension, hdr) -
+		offsetofend(struct smc_clnt_opts_area_hdr, smcd_v2_ext_offset);
+
 	if (!prop_v2ext)
 		return NULL;
-	if (!ntohs(prop_v2ext->hdr.smcd_v2_ext_offset))
+	if (!ntohs(prop_v2ext->hdr.smcd_v2_ext_offset) ||
+	    ntohs(prop_v2ext->hdr.smcd_v2_ext_offset) > max_offset)
 		return NULL;
 
 	return (struct smc_clc_smcd_v2_extension *)
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 10d79cb55528..890785d4f6b6 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1726,7 +1726,9 @@ void smcr_link_down_cond_sched(struct smc_link *lnk)
 {
 	if (smc_link_downing(&lnk->state)) {
 		trace_smcr_link_down(lnk, __builtin_return_address(0));
-		schedule_work(&lnk->link_down_wrk);
+		smcr_link_hold(lnk); /* smcr_link_put in link_down_wrk */
+		if (!schedule_work(&lnk->link_down_wrk))
+			smcr_link_put(lnk);
 	}
 }
 
@@ -1758,11 +1760,14 @@ static void smc_link_down_work(struct work_struct *work)
 	struct smc_link_group *lgr = link->lgr;
 
 	if (list_empty(&lgr->list))
-		return;
+		goto out;
 	wake_up_all(&lgr->llc_msg_waiter);
 	mutex_lock(&lgr->llc_conf_mutex);
 	smcr_link_down(link);
 	mutex_unlock(&lgr->llc_conf_mutex);
+
+out:
+	smcr_link_put(link); /* smcr_link_hold by schedulers of link_down_work */
 }
 
 static int smc_vlan_by_tcpsk_walk(struct net_device *lower_dev,
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index d03de37e3578..9cd85ab19c55 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -267,6 +267,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					SOF_BT_OFFLOAD_SSP(2) |
 					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "0000000000070000"),
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					RT711_JD2_100K),
+	},
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
@@ -378,6 +387,15 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					RT711_JD2 |
 					SOF_SDW_FOUR_SPK),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0B8C"),
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					RT711_JD2),
+	},
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
diff --git a/tools/testing/selftests/bpf/sdt.h b/tools/testing/selftests/bpf/sdt.h
index ca0162b4dc57..1fcfa5160231 100644
--- a/tools/testing/selftests/bpf/sdt.h
+++ b/tools/testing/selftests/bpf/sdt.h
@@ -102,6 +102,8 @@
 # define STAP_SDT_ARG_CONSTRAINT        nZr
 # elif defined __arm__
 # define STAP_SDT_ARG_CONSTRAINT        g
+# elif defined __loongarch__
+# define STAP_SDT_ARG_CONSTRAINT        nmr
 # else
 # define STAP_SDT_ARG_CONSTRAINT        nor
 # endif

