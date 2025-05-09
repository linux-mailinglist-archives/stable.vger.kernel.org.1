Return-Path: <stable+bounces-142992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 448E4AB0CB3
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F9716F2C5
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A72274669;
	Fri,  9 May 2025 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qpCJ6y2U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9A272E69;
	Fri,  9 May 2025 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778052; cv=none; b=d5ZhmYcBfV9u2+tfCUohAnUFBP/YSsLfXF39qdGrEWqAzLy26sIy48cEzvb1byso1cOpP9xfMD/izzhw3wcHh1A2w6tnYthOvDPBzV6/92eCMM8ONZbss8eKBvQmliJDnRhOQBJ/+5Z9KW8u3nFFH/WGD8XgU8BsiXJiAwqGz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778052; c=relaxed/simple;
	bh=J15EGVmUwJ02YeryePXO5CFh9JHZUU0OZk6es5JalVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MR1ZsmgeME7u73zSTluk2CmKDjNpc4aLnMmeDKXl1oYTIiXQEtGDVNaoqrpcIwVyq/ekesuUCMBTnI+iMca/FxSVCkO3sIxtQ3YhvDd31MhLj5wvm6F6CVtHIwIS0gUrFtRySja+xudOoi67ZPwQ6F5Rbz8iUg4rMVW3AoDaQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qpCJ6y2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCE9C4CEE4;
	Fri,  9 May 2025 08:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746778051;
	bh=J15EGVmUwJ02YeryePXO5CFh9JHZUU0OZk6es5JalVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpCJ6y2UcctCIZJ/K1K3ds1YlTTKZOjtVoLL/uwggTXunm413zvvIunhZhG6RSm4o
	 NxH4jyDXLuI0jFvgvBXlPkRTHn9N1aDSFEDUEDz7hAs16VE4BoyGEifiUp/Wfrnudb
	 QDnth3dBBLUxlOYxr1OkhmAU5oDzq4+yxBSOE4lY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.14.6
Date: Fri,  9 May 2025 10:07:13 +0200
Message-ID: <2025050913-karma-splashing-3afa@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025050913-hazy-pyromania-f458@gregkh>
References: <2025050913-hazy-pyromania-f458@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 87835d7abbce..6c3233a21380 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 14
-SUBLEVEL = 5
+SUBLEVEL = 6
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6ul.dtsi
index f2386dcb9ff2..dda4fa91b2f2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6ul.dtsi
@@ -40,6 +40,9 @@ ethphy1: ethernet-phy@1 {
 			reg = <1>;
 			interrupt-parent = <&gpio4>;
 			interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
+			micrel,led-mode = <1>;
+			clocks = <&clks IMX6UL_CLK_ENET_REF>;
+			clock-names = "rmii-ref";
 			status = "okay";
 		};
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 6b8470cb3461..0e6a9e639d76 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1542,7 +1542,7 @@ pcie0: pcie@4c300000 {
 			reg = <0 0x4c300000 0 0x10000>,
 			      <0 0x60100000 0 0xfe00000>,
 			      <0 0x4c360000 0 0x10000>,
-			      <0 0x4c340000 0 0x2000>;
+			      <0 0x4c340000 0 0x4000>;
 			reg-names = "dbi", "config", "atu", "app";
 			ranges = <0x81000000 0x0 0x00000000 0x0 0x6ff00000 0 0x00100000>,
 				 <0x82000000 0x0 0x10000000 0x9 0x10000000 0 0x10000000>;
@@ -1582,7 +1582,7 @@ pcie0_ep: pcie-ep@4c300000 {
 			reg = <0 0x4c300000 0 0x10000>,
 			      <0 0x4c360000 0 0x1000>,
 			      <0 0x4c320000 0 0x1000>,
-			      <0 0x4c340000 0 0x2000>,
+			      <0 0x4c340000 0 0x4000>,
 			      <0 0x4c370000 0 0x10000>,
 			      <0x9 0 1 0>;
 			reg-names = "dbi","atu", "dbi2", "app", "dma", "addr_space";
@@ -1609,7 +1609,7 @@ pcie1: pcie@4c380000 {
 			reg = <0 0x4c380000 0 0x10000>,
 			      <8 0x80100000 0 0xfe00000>,
 			      <0 0x4c3e0000 0 0x10000>,
-			      <0 0x4c3c0000 0 0x2000>;
+			      <0 0x4c3c0000 0 0x4000>;
 			reg-names = "dbi", "config", "atu", "app";
 			ranges = <0x81000000 0 0x00000000 0x8 0x8ff00000 0 0x00100000>,
 				 <0x82000000 0 0x10000000 0xa 0x10000000 0 0x10000000>;
@@ -1649,7 +1649,7 @@ pcie1_ep: pcie-ep@4c380000 {
 			reg = <0 0x4c380000 0 0x10000>,
 			      <0 0x4c3e0000 0 0x1000>,
 			      <0 0x4c3a0000 0 0x1000>,
-			      <0 0x4c3c0000 0 0x2000>,
+			      <0 0x4c3c0000 0 0x4000>,
 			      <0 0x4c3f0000 0 0x10000>,
 			      <0xa 0 1 0>;
 			reg-names = "dbi", "atu", "dbi2", "app", "dma", "addr_space";
diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index f3c6cdfd7008..87110f91e489 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -115,14 +115,13 @@ scmi_vdda18adc: regulator@7 {
 	};
 
 	intc: interrupt-controller@4ac00000 {
-		compatible = "arm,cortex-a7-gic";
+		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
-		#address-cells = <1>;
 		interrupt-controller;
 		reg = <0x0 0x4ac10000 0x0 0x1000>,
-		      <0x0 0x4ac20000 0x0 0x2000>,
-		      <0x0 0x4ac40000 0x0 0x2000>,
-		      <0x0 0x4ac60000 0x0 0x2000>;
+		      <0x0 0x4ac20000 0x0 0x20000>,
+		      <0x0 0x4ac40000 0x0 0x20000>,
+		      <0x0 0x4ac60000 0x0 0x20000>;
 	};
 
 	psci {
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 0f51fd10b4b0..30e79f111b35 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -879,10 +879,12 @@ static u8 spectre_bhb_loop_affected(void)
 	static const struct midr_range spectre_bhb_k132_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
 		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+		{},
 	};
 	static const struct midr_range spectre_bhb_k38_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A715),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
+		{},
 	};
 	static const struct midr_range spectre_bhb_k32_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
diff --git a/arch/parisc/math-emu/driver.c b/arch/parisc/math-emu/driver.c
index 34495446e051..71829cb7bc81 100644
--- a/arch/parisc/math-emu/driver.c
+++ b/arch/parisc/math-emu/driver.c
@@ -97,9 +97,19 @@ handle_fpe(struct pt_regs *regs)
 
 	memcpy(regs->fr, frcopy, sizeof regs->fr);
 	if (signalcode != 0) {
-	    force_sig_fault(signalcode >> 24, signalcode & 0xffffff,
-			    (void __user *) regs->iaoq[0]);
-	    return -1;
+		int sig = signalcode >> 24;
+
+		if (sig == SIGFPE) {
+			/*
+			 * Clear floating point trap bit to avoid trapping
+			 * again on the first floating-point instruction in
+			 * the userspace signal handler.
+			 */
+			regs->fr[0] &= ~(1ULL << 38);
+		}
+		force_sig_fault(sig, signalcode & 0xffffff,
+				(void __user *) regs->iaoq[0]);
+		return -1;
 	}
 
 	return signalcode ? -1 : 0;
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 1db60fe13802..3d8dc822282a 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -234,10 +234,8 @@ fi
 
 # suppress some warnings in recent ld versions
 nowarn="-z noexecstack"
-if ! ld_is_lld; then
-	if [ "$LD_VERSION" -ge "$(echo 2.39 | ld_version)" ]; then
-		nowarn="$nowarn --no-warn-rwx-segments"
-	fi
+if "${CROSS}ld" -v --no-warn-rwx-segments >/dev/null 2>&1; then
+	nowarn="$nowarn --no-warn-rwx-segments"
 fi
 
 platformo=$object/"$platform".o
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 34a5aec4908f..126bf3b06ab7 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -258,10 +258,6 @@ static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
 			break;
 		}
 	}
-	if (i == hdr->e_shnum) {
-		pr_err("%s: doesn't contain __patchable_function_entries.\n", me->name);
-		return -ENOEXEC;
-	}
 #endif
 
 	pr_debug("Looks like a total of %lu stubs, max\n", relocs);
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 311e2112d782..128c011afc48 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1120,6 +1120,19 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 	pmd_t *pmd;
 	pte_t *pte;
 
+	/*
+	 * Make sure we align the start vmemmap addr so that we calculate
+	 * the correct start_pfn in altmap boundary check to decided whether
+	 * we should use altmap or RAM based backing memory allocation. Also
+	 * the address need to be aligned for set_pte operation.
+
+	 * If the start addr is already PMD_SIZE aligned we will try to use
+	 * a pmd mapping. We don't want to be too aggressive here beacause
+	 * that will cause more allocations in RAM. So only if the namespace
+	 * vmemmap start addr is PMD_SIZE aligned we will use PMD mapping.
+	 */
+
+	start = ALIGN_DOWN(start, PAGE_SIZE);
 	for (addr = start; addr < end; addr = next) {
 		next = pmd_addr_end(addr, end);
 
@@ -1145,8 +1158,8 @@ int __meminit radix__vmemmap_populate(unsigned long start, unsigned long end, in
 			 * in altmap block allocation failures, in which case
 			 * we fallback to RAM for vmemmap allocation.
 			 */
-			if (altmap && (!IS_ALIGNED(addr, PMD_SIZE) ||
-				       altmap_cross_boundary(altmap, addr, PMD_SIZE))) {
+			if (!IS_ALIGNED(addr, PMD_SIZE) || (altmap &&
+			    altmap_cross_boundary(altmap, addr, PMD_SIZE))) {
 				/*
 				 * make sure we don't create altmap mappings
 				 * covering things outside the device.
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index f676156d9f3d..0e9f84ab4bdc 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -34,14 +34,11 @@ static bool early_is_tdx_guest(void)
 
 void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 {
-	static bool sevsnp;
-
 	/* Platform-specific memory-acceptance call goes here */
 	if (early_is_tdx_guest()) {
 		if (!tdx_accept_memory(start, end))
 			panic("TDX: Failed to accept memory\n");
-	} else if (sevsnp || (sev_get_status() & MSR_AMD64_SEV_SNP_ENABLED)) {
-		sevsnp = true;
+	} else if (early_is_sevsnp_guest()) {
 		snp_accept_memory(start, end);
 	} else {
 		error("Cannot accept memory: unknown platform\n");
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 89ba168f4f0f..0003e4416efd 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -645,3 +645,43 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
 
 	sev_verify_cbit(top_level_pgt);
 }
+
+bool early_is_sevsnp_guest(void)
+{
+	static bool sevsnp;
+
+	if (sevsnp)
+		return true;
+
+	if (!(sev_get_status() & MSR_AMD64_SEV_SNP_ENABLED))
+		return false;
+
+	sevsnp = true;
+
+	if (!snp_vmpl) {
+		unsigned int eax, ebx, ecx, edx;
+
+		/*
+		 * CPUID Fn8000_001F_EAX[28] - SVSM support
+		 */
+		eax = 0x8000001f;
+		ecx = 0;
+		native_cpuid(&eax, &ebx, &ecx, &edx);
+		if (eax & BIT(28)) {
+			struct msr m;
+
+			/* Obtain the address of the calling area to use */
+			boot_rdmsr(MSR_SVSM_CAA, &m);
+			boot_svsm_caa = (void *)m.q;
+			boot_svsm_caa_pa = m.q;
+
+			/*
+			 * The real VMPL level cannot be discovered, but the
+			 * memory acceptance routines make no use of that so
+			 * any non-zero value suffices here.
+			 */
+			snp_vmpl = U8_MAX;
+		}
+	}
+	return true;
+}
diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
index 4e463f33186d..d3900384b8ab 100644
--- a/arch/x86/boot/compressed/sev.h
+++ b/arch/x86/boot/compressed/sev.h
@@ -13,12 +13,14 @@
 bool sev_snp_enabled(void);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 sev_get_status(void);
+bool early_is_sevsnp_guest(void);
 
 #else
 
 static inline bool sev_snp_enabled(void) { return false; }
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 sev_get_status(void) { return 0; }
+static inline bool early_is_sevsnp_guest(void) { return false; }
 
 #endif
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index ce8d4fdf54fb..a46b792a171c 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -753,7 +753,7 @@ void x86_pmu_enable_all(int added)
 	}
 }
 
-static inline int is_x86_event(struct perf_event *event)
+int is_x86_event(struct perf_event *event)
 {
 	int i;
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9e8de416d1f0..47741a0c6dd6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4341,7 +4341,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	arr[pebs_enable] = (struct perf_guest_switch_msr){
 		.msr = MSR_IA32_PEBS_ENABLE,
 		.host = cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_mask,
-		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask,
+		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask & kvm_pmu->pebs_enable,
 	};
 
 	if (arr[pebs_enable].host) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 1dfa78a30266..7bb5cf514d77 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -110,9 +110,16 @@ static inline bool is_topdown_event(struct perf_event *event)
 	return is_metric_event(event) || is_slots_event(event);
 }
 
+int is_x86_event(struct perf_event *event);
+
+static inline bool check_leader_group(struct perf_event *leader, int flags)
+{
+	return is_x86_event(leader) ? !!(leader->hw.flags & flags) : false;
+}
+
 static inline bool is_branch_counters_group(struct perf_event *event)
 {
-	return event->group_leader->hw.flags & PERF_X86_EVENT_BRANCH_COUNTERS;
+	return check_leader_group(event->group_leader, PERF_X86_EVENT_BRANCH_COUNTERS);
 }
 
 struct amd_nb {
diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 3e56ce8bc2c1..93c3687d30b7 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -36,8 +36,6 @@
 #define DRIVER_VERSION_STR "1.0.0 " UTS_RELEASE
 #endif
 
-static struct lock_class_key submitted_jobs_xa_lock_class_key;
-
 int ivpu_dbg_mask;
 module_param_named(dbg_mask, ivpu_dbg_mask, int, 0644);
 MODULE_PARM_DESC(dbg_mask, "Driver debug mask. See IVPU_DBG_* macros.");
@@ -465,26 +463,6 @@ static const struct drm_driver driver = {
 	.major = 1,
 };
 
-static void ivpu_context_abort_invalid(struct ivpu_device *vdev)
-{
-	struct ivpu_file_priv *file_priv;
-	unsigned long ctx_id;
-
-	mutex_lock(&vdev->context_list_lock);
-
-	xa_for_each(&vdev->context_xa, ctx_id, file_priv) {
-		if (!file_priv->has_mmu_faults || file_priv->aborted)
-			continue;
-
-		mutex_lock(&file_priv->lock);
-		ivpu_context_abort_locked(file_priv);
-		file_priv->aborted = true;
-		mutex_unlock(&file_priv->lock);
-	}
-
-	mutex_unlock(&vdev->context_list_lock);
-}
-
 static irqreturn_t ivpu_irq_thread_handler(int irq, void *arg)
 {
 	struct ivpu_device *vdev = arg;
@@ -498,9 +476,6 @@ static irqreturn_t ivpu_irq_thread_handler(int irq, void *arg)
 		case IVPU_HW_IRQ_SRC_IPC:
 			ivpu_ipc_irq_thread_handler(vdev);
 			break;
-		case IVPU_HW_IRQ_SRC_MMU_EVTQ:
-			ivpu_context_abort_invalid(vdev);
-			break;
 		case IVPU_HW_IRQ_SRC_DCT:
 			ivpu_pm_dct_irq_thread_handler(vdev);
 			break;
@@ -617,16 +592,21 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
 	xa_init_flags(&vdev->context_xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 	xa_init_flags(&vdev->submitted_jobs_xa, XA_FLAGS_ALLOC1);
 	xa_init_flags(&vdev->db_xa, XA_FLAGS_ALLOC1);
-	lockdep_set_class(&vdev->submitted_jobs_xa.xa_lock, &submitted_jobs_xa_lock_class_key);
 	INIT_LIST_HEAD(&vdev->bo_list);
 
 	vdev->db_limit.min = IVPU_MIN_DB;
 	vdev->db_limit.max = IVPU_MAX_DB;
 
+	INIT_WORK(&vdev->context_abort_work, ivpu_context_abort_thread_handler);
+
 	ret = drmm_mutex_init(&vdev->drm, &vdev->context_list_lock);
 	if (ret)
 		goto err_xa_destroy;
 
+	ret = drmm_mutex_init(&vdev->drm, &vdev->submitted_jobs_lock);
+	if (ret)
+		goto err_xa_destroy;
+
 	ret = drmm_mutex_init(&vdev->drm, &vdev->bo_list_lock);
 	if (ret)
 		goto err_xa_destroy;
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 3fdff3f6cffd..ebfcf3e42a3d 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -137,6 +137,7 @@ struct ivpu_device {
 	struct mutex context_list_lock; /* Protects user context addition/removal */
 	struct xarray context_xa;
 	struct xa_limit context_xa_limit;
+	struct work_struct context_abort_work;
 
 	struct xarray db_xa;
 	struct xa_limit db_limit;
@@ -145,6 +146,7 @@ struct ivpu_device {
 	struct mutex bo_list_lock; /* Protects bo_list */
 	struct list_head bo_list;
 
+	struct mutex submitted_jobs_lock; /* Protects submitted_jobs */
 	struct xarray submitted_jobs_xa;
 	struct ivpu_ipc_consumer job_done_consumer;
 
diff --git a/drivers/accel/ivpu/ivpu_hw_btrs.h b/drivers/accel/ivpu/ivpu_hw_btrs.h
index 71792dab3c21..3855e2df1e0c 100644
--- a/drivers/accel/ivpu/ivpu_hw_btrs.h
+++ b/drivers/accel/ivpu/ivpu_hw_btrs.h
@@ -14,7 +14,7 @@
 #define PLL_PROFILING_FREQ_DEFAULT   38400000
 #define PLL_PROFILING_FREQ_HIGH      400000000
 
-#define DCT_DEFAULT_ACTIVE_PERCENT 15u
+#define DCT_DEFAULT_ACTIVE_PERCENT 30u
 #define DCT_PERIOD_US		   35300u
 
 int ivpu_hw_btrs_info_init(struct ivpu_device *vdev);
diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index 7149312f16e1..673801889c7b 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -223,7 +223,8 @@ static int ivpu_cmdq_fini(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cm
 	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW) {
 		ret = ivpu_jsm_hws_destroy_cmdq(vdev, file_priv->ctx.id, cmdq->id);
 		if (!ret)
-			ivpu_dbg(vdev, JOB, "Command queue %d destroyed\n", cmdq->id);
+			ivpu_dbg(vdev, JOB, "Command queue %d destroyed, ctx %d\n",
+				 cmdq->id, file_priv->ctx.id);
 	}
 
 	ret = ivpu_jsm_unregister_db(vdev, cmdq->db_id);
@@ -324,6 +325,8 @@ void ivpu_context_abort_locked(struct ivpu_file_priv *file_priv)
 
 	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_OS)
 		ivpu_jsm_context_release(vdev, file_priv->ctx.id);
+
+	file_priv->aborted = true;
 }
 
 static int ivpu_cmdq_push_job(struct ivpu_cmdq *cmdq, struct ivpu_job *job)
@@ -462,16 +465,14 @@ static struct ivpu_job *ivpu_job_remove_from_submitted_jobs(struct ivpu_device *
 {
 	struct ivpu_job *job;
 
-	xa_lock(&vdev->submitted_jobs_xa);
-	job = __xa_erase(&vdev->submitted_jobs_xa, job_id);
+	lockdep_assert_held(&vdev->submitted_jobs_lock);
 
+	job = xa_erase(&vdev->submitted_jobs_xa, job_id);
 	if (xa_empty(&vdev->submitted_jobs_xa) && job) {
 		vdev->busy_time = ktime_add(ktime_sub(ktime_get(), vdev->busy_start_ts),
 					    vdev->busy_time);
 	}
 
-	xa_unlock(&vdev->submitted_jobs_xa);
-
 	return job;
 }
 
@@ -479,6 +480,28 @@ static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32
 {
 	struct ivpu_job *job;
 
+	lockdep_assert_held(&vdev->submitted_jobs_lock);
+
+	job = xa_load(&vdev->submitted_jobs_xa, job_id);
+	if (!job)
+		return -ENOENT;
+
+	if (job_status == VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW) {
+		guard(mutex)(&job->file_priv->lock);
+
+		if (job->file_priv->has_mmu_faults)
+			return 0;
+
+		/*
+		 * Mark context as faulty and defer destruction of the job to jobs abort thread
+		 * handler to synchronize between both faults and jobs returning context violation
+		 * status and ensure both are handled in the same way
+		 */
+		job->file_priv->has_mmu_faults = true;
+		queue_work(system_wq, &vdev->context_abort_work);
+		return 0;
+	}
+
 	job = ivpu_job_remove_from_submitted_jobs(vdev, job_id);
 	if (!job)
 		return -ENOENT;
@@ -497,6 +520,10 @@ static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32
 	ivpu_stop_job_timeout_detection(vdev);
 
 	ivpu_rpm_put(vdev);
+
+	if (!xa_empty(&vdev->submitted_jobs_xa))
+		ivpu_start_job_timeout_detection(vdev);
+
 	return 0;
 }
 
@@ -505,8 +532,12 @@ void ivpu_jobs_abort_all(struct ivpu_device *vdev)
 	struct ivpu_job *job;
 	unsigned long id;
 
+	mutex_lock(&vdev->submitted_jobs_lock);
+
 	xa_for_each(&vdev->submitted_jobs_xa, id, job)
 		ivpu_job_signal_and_destroy(vdev, id, DRM_IVPU_JOB_STATUS_ABORTED);
+
+	mutex_unlock(&vdev->submitted_jobs_lock);
 }
 
 static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
@@ -521,6 +552,7 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
 	if (ret < 0)
 		return ret;
 
+	mutex_lock(&vdev->submitted_jobs_lock);
 	mutex_lock(&file_priv->lock);
 
 	cmdq = ivpu_cmdq_acquire(file_priv, priority);
@@ -528,18 +560,17 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
 		ivpu_warn_ratelimited(vdev, "Failed to get job queue, ctx %d engine %d prio %d\n",
 				      file_priv->ctx.id, job->engine_idx, priority);
 		ret = -EINVAL;
-		goto err_unlock_file_priv;
+		goto err_unlock;
 	}
 
-	xa_lock(&vdev->submitted_jobs_xa);
 	is_first_job = xa_empty(&vdev->submitted_jobs_xa);
-	ret = __xa_alloc_cyclic(&vdev->submitted_jobs_xa, &job->job_id, job, file_priv->job_limit,
-				&file_priv->job_id_next, GFP_KERNEL);
+	ret = xa_alloc_cyclic(&vdev->submitted_jobs_xa, &job->job_id, job, file_priv->job_limit,
+			      &file_priv->job_id_next, GFP_KERNEL);
 	if (ret < 0) {
 		ivpu_dbg(vdev, JOB, "Too many active jobs in ctx %d\n",
 			 file_priv->ctx.id);
 		ret = -EBUSY;
-		goto err_unlock_submitted_jobs_xa;
+		goto err_unlock;
 	}
 
 	ret = ivpu_cmdq_push_job(cmdq, job);
@@ -562,20 +593,20 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
 		 job->job_id, file_priv->ctx.id, job->engine_idx, priority,
 		 job->cmd_buf_vpu_addr, cmdq->jobq->header.tail);
 
-	xa_unlock(&vdev->submitted_jobs_xa);
-
 	mutex_unlock(&file_priv->lock);
 
-	if (unlikely(ivpu_test_mode & IVPU_TEST_MODE_NULL_HW))
+	if (unlikely(ivpu_test_mode & IVPU_TEST_MODE_NULL_HW)) {
 		ivpu_job_signal_and_destroy(vdev, job->job_id, VPU_JSM_STATUS_SUCCESS);
+	}
+
+	mutex_unlock(&vdev->submitted_jobs_lock);
 
 	return 0;
 
 err_erase_xa:
-	__xa_erase(&vdev->submitted_jobs_xa, job->job_id);
-err_unlock_submitted_jobs_xa:
-	xa_unlock(&vdev->submitted_jobs_xa);
-err_unlock_file_priv:
+	xa_erase(&vdev->submitted_jobs_xa, job->job_id);
+err_unlock:
+	mutex_unlock(&vdev->submitted_jobs_lock);
 	mutex_unlock(&file_priv->lock);
 	ivpu_rpm_put(vdev);
 	return ret;
@@ -745,7 +776,6 @@ ivpu_job_done_callback(struct ivpu_device *vdev, struct ivpu_ipc_hdr *ipc_hdr,
 		       struct vpu_jsm_msg *jsm_msg)
 {
 	struct vpu_ipc_msg_payload_job_done *payload;
-	int ret;
 
 	if (!jsm_msg) {
 		ivpu_err(vdev, "IPC message has no JSM payload\n");
@@ -758,9 +788,10 @@ ivpu_job_done_callback(struct ivpu_device *vdev, struct ivpu_ipc_hdr *ipc_hdr,
 	}
 
 	payload = (struct vpu_ipc_msg_payload_job_done *)&jsm_msg->payload;
-	ret = ivpu_job_signal_and_destroy(vdev, payload->job_id, payload->job_status);
-	if (!ret && !xa_empty(&vdev->submitted_jobs_xa))
-		ivpu_start_job_timeout_detection(vdev);
+
+	mutex_lock(&vdev->submitted_jobs_lock);
+	ivpu_job_signal_and_destroy(vdev, payload->job_id, payload->job_status);
+	mutex_unlock(&vdev->submitted_jobs_lock);
 }
 
 void ivpu_job_done_consumer_init(struct ivpu_device *vdev)
@@ -773,3 +804,41 @@ void ivpu_job_done_consumer_fini(struct ivpu_device *vdev)
 {
 	ivpu_ipc_consumer_del(vdev, &vdev->job_done_consumer);
 }
+
+void ivpu_context_abort_thread_handler(struct work_struct *work)
+{
+	struct ivpu_device *vdev = container_of(work, struct ivpu_device, context_abort_work);
+	struct ivpu_file_priv *file_priv;
+	unsigned long ctx_id;
+	struct ivpu_job *job;
+	unsigned long id;
+
+	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
+		ivpu_jsm_reset_engine(vdev, 0);
+
+	mutex_lock(&vdev->context_list_lock);
+	xa_for_each(&vdev->context_xa, ctx_id, file_priv) {
+		if (!file_priv->has_mmu_faults || file_priv->aborted)
+			continue;
+
+		mutex_lock(&file_priv->lock);
+		ivpu_context_abort_locked(file_priv);
+		mutex_unlock(&file_priv->lock);
+	}
+	mutex_unlock(&vdev->context_list_lock);
+
+	if (vdev->fw->sched_mode != VPU_SCHEDULING_MODE_HW)
+		return;
+
+	ivpu_jsm_hws_resume_engine(vdev, 0);
+	/*
+	 * In hardware scheduling mode NPU already has stopped processing jobs
+	 * and won't send us any further notifications, thus we have to free job related resources
+	 * and notify userspace
+	 */
+	mutex_lock(&vdev->submitted_jobs_lock);
+	xa_for_each(&vdev->submitted_jobs_xa, id, job)
+		if (job->file_priv->aborted)
+			ivpu_job_signal_and_destroy(vdev, job->job_id, DRM_IVPU_JOB_STATUS_ABORTED);
+	mutex_unlock(&vdev->submitted_jobs_lock);
+}
diff --git a/drivers/accel/ivpu/ivpu_job.h b/drivers/accel/ivpu/ivpu_job.h
index 8b19e3f8b4cf..af1ed039569c 100644
--- a/drivers/accel/ivpu/ivpu_job.h
+++ b/drivers/accel/ivpu/ivpu_job.h
@@ -66,6 +66,7 @@ void ivpu_cmdq_reset_all_contexts(struct ivpu_device *vdev);
 
 void ivpu_job_done_consumer_init(struct ivpu_device *vdev);
 void ivpu_job_done_consumer_fini(struct ivpu_device *vdev);
+void ivpu_context_abort_thread_handler(struct work_struct *work);
 
 void ivpu_jobs_abort_all(struct ivpu_device *vdev);
 
diff --git a/drivers/accel/ivpu/ivpu_mmu.c b/drivers/accel/ivpu/ivpu_mmu.c
index 26ef52fbb93e..21f820dd0c65 100644
--- a/drivers/accel/ivpu/ivpu_mmu.c
+++ b/drivers/accel/ivpu/ivpu_mmu.c
@@ -890,8 +890,7 @@ void ivpu_mmu_irq_evtq_handler(struct ivpu_device *vdev)
 		REGV_WR32(IVPU_MMU_REG_EVTQ_CONS_SEC, vdev->mmu->evtq.cons);
 	}
 
-	if (!kfifo_put(&vdev->hw->irq.fifo, IVPU_HW_IRQ_SRC_MMU_EVTQ))
-		ivpu_err_ratelimited(vdev, "IRQ FIFO full\n");
+	queue_work(system_wq, &vdev->context_abort_work);
 }
 
 void ivpu_mmu_evtq_dump(struct ivpu_device *vdev)
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index 5060c5dd40d1..7acf78aeb380 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -433,16 +433,17 @@ int ivpu_pm_dct_enable(struct ivpu_device *vdev, u8 active_percent)
 	active_us = (DCT_PERIOD_US * active_percent) / 100;
 	inactive_us = DCT_PERIOD_US - active_us;
 
+	vdev->pm->dct_active_percent = active_percent;
+
+	ivpu_dbg(vdev, PM, "DCT requested %u%% (D0: %uus, D0i2: %uus)\n",
+		 active_percent, active_us, inactive_us);
+
 	ret = ivpu_jsm_dct_enable(vdev, active_us, inactive_us);
 	if (ret) {
 		ivpu_err_ratelimited(vdev, "Failed to enable DCT: %d\n", ret);
 		return ret;
 	}
 
-	vdev->pm->dct_active_percent = active_percent;
-
-	ivpu_dbg(vdev, PM, "DCT set to %u%% (D0: %uus, D0i2: %uus)\n",
-		 active_percent, active_us, inactive_us);
 	return 0;
 }
 
@@ -450,15 +451,16 @@ int ivpu_pm_dct_disable(struct ivpu_device *vdev)
 {
 	int ret;
 
+	vdev->pm->dct_active_percent = 0;
+
+	ivpu_dbg(vdev, PM, "DCT requested to be disabled\n");
+
 	ret = ivpu_jsm_dct_disable(vdev);
 	if (ret) {
 		ivpu_err_ratelimited(vdev, "Failed to disable DCT: %d\n", ret);
 		return ret;
 	}
 
-	vdev->pm->dct_active_percent = 0;
-
-	ivpu_dbg(vdev, PM, "DCT disabled\n");
 	return 0;
 }
 
@@ -470,7 +472,7 @@ void ivpu_pm_dct_irq_thread_handler(struct ivpu_device *vdev)
 	if (ivpu_hw_btrs_dct_get_request(vdev, &enable))
 		return;
 
-	if (vdev->pm->dct_active_percent)
+	if (enable)
 		ret = ivpu_pm_dct_enable(vdev, DCT_DEFAULT_ACTIVE_PERCENT);
 	else
 		ret = ivpu_pm_dct_disable(vdev);
diff --git a/drivers/accel/ivpu/ivpu_sysfs.c b/drivers/accel/ivpu/ivpu_sysfs.c
index 616477fc17fa..8a616791c32f 100644
--- a/drivers/accel/ivpu/ivpu_sysfs.c
+++ b/drivers/accel/ivpu/ivpu_sysfs.c
@@ -30,11 +30,12 @@ npu_busy_time_us_show(struct device *dev, struct device_attribute *attr, char *b
 	struct ivpu_device *vdev = to_ivpu_device(drm);
 	ktime_t total, now = 0;
 
-	xa_lock(&vdev->submitted_jobs_xa);
+	mutex_lock(&vdev->submitted_jobs_lock);
+
 	total = vdev->busy_time;
 	if (!xa_empty(&vdev->submitted_jobs_xa))
 		now = ktime_sub(ktime_get(), vdev->busy_start_ts);
-	xa_unlock(&vdev->submitted_jobs_xa);
+	mutex_unlock(&vdev->submitted_jobs_lock);
 
 	return sysfs_emit(buf, "%lld\n", ktime_to_us(ktime_add(total, now)));
 }
diff --git a/drivers/base/module.c b/drivers/base/module.c
index 5bc71bea883a..218aaa096455 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -42,16 +42,13 @@ int module_add_driver(struct module *mod, const struct device_driver *drv)
 	if (mod)
 		mk = &mod->mkobj;
 	else if (drv->mod_name) {
-		struct kobject *mkobj;
-
-		/* Lookup built-in module entry in /sys/modules */
-		mkobj = kset_find_obj(module_kset, drv->mod_name);
-		if (mkobj) {
-			mk = container_of(mkobj, struct module_kobject, kobj);
+		/* Lookup or create built-in module entry in /sys/modules */
+		mk = lookup_or_create_module_kobject(drv->mod_name);
+		if (mk) {
 			/* remember our module structure */
 			drv->p->mkobj = mk;
-			/* kset_find_obj took a reference */
-			kobject_put(mkobj);
+			/* lookup_or_create_module_kobject took a reference */
+			kobject_put(&mk->kobj);
 		}
 	}
 
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ab06a7a064fb..348c4feb7a2d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -115,15 +115,6 @@ struct ublk_uring_cmd_pdu {
  */
 #define UBLK_IO_FLAG_OWNED_BY_SRV 0x02
 
-/*
- * IO command is aborted, so this flag is set in case of
- * !UBLK_IO_FLAG_ACTIVE.
- *
- * After this flag is observed, any pending or new incoming request
- * associated with this io command will be failed immediately
- */
-#define UBLK_IO_FLAG_ABORTED 0x04
-
 /*
  * UBLK_IO_FLAG_NEED_GET_DATA is set because IO command requires
  * get data buffer address from ublksrv.
@@ -194,8 +185,6 @@ struct ublk_device {
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
 	unsigned int		nr_privileged_daemon;
-
-	struct work_struct	nosrv_work;
 };
 
 /* header of ublk_params */
@@ -204,7 +193,9 @@ struct ublk_params_header {
 	__u32	types;
 };
 
-static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
+
+static void ublk_stop_dev_unlocked(struct ublk_device *ub);
+static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
 
 static inline unsigned int ublk_req_build_flags(struct request *req);
 static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
@@ -594,6 +585,11 @@ static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 	return ubq->flags & UBLK_F_USER_COPY;
 }
 
+static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
+{
+	return !ublk_support_user_copy(ubq);
+}
+
 static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
 {
 	/*
@@ -921,7 +917,7 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (ublk_support_user_copy(ubq))
+	if (!ublk_need_map_io(ubq))
 		return rq_bytes;
 
 	/*
@@ -945,7 +941,7 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (ublk_support_user_copy(ubq))
+	if (!ublk_need_map_io(ubq))
 		return rq_bytes;
 
 	if (ublk_need_unmap_req(req)) {
@@ -1038,7 +1034,7 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 
 static inline bool ubq_daemon_is_dying(struct ublk_queue *ubq)
 {
-	return ubq->ubq_daemon->flags & PF_EXITING;
+	return !ubq->ubq_daemon || ubq->ubq_daemon->flags & PF_EXITING;
 }
 
 /* todo: handle partial completion */
@@ -1049,12 +1045,6 @@ static inline void __ublk_complete_rq(struct request *req)
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
 
-	/* called from ublk_abort_queue() code path */
-	if (io->flags & UBLK_IO_FLAG_ABORTED) {
-		res = BLK_STS_IOERR;
-		goto exit;
-	}
-
 	/* failed read IO if nothing is read */
 	if (!io->res && req_op(req) == REQ_OP_READ)
 		io->res = -EIO;
@@ -1104,47 +1094,6 @@ static void ublk_complete_rq(struct kref *ref)
 	__ublk_complete_rq(req);
 }
 
-static void ublk_do_fail_rq(struct request *req)
-{
-	struct ublk_queue *ubq = req->mq_hctx->driver_data;
-
-	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
-		blk_mq_requeue_request(req, false);
-	else
-		__ublk_complete_rq(req);
-}
-
-static void ublk_fail_rq_fn(struct kref *ref)
-{
-	struct ublk_rq_data *data = container_of(ref, struct ublk_rq_data,
-			ref);
-	struct request *req = blk_mq_rq_from_pdu(data);
-
-	ublk_do_fail_rq(req);
-}
-
-/*
- * Since ublk_rq_task_work_cb always fails requests immediately during
- * exiting, __ublk_fail_req() is only called from abort context during
- * exiting. So lock is unnecessary.
- *
- * Also aborting may not be started yet, keep in mind that one failed
- * request may be issued by block layer again.
- */
-static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
-		struct request *req)
-{
-	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
-
-	if (ublk_need_req_ref(ubq)) {
-		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
-
-		kref_put(&data->ref, ublk_fail_rq_fn);
-	} else {
-		ublk_do_fail_rq(req);
-	}
-}
-
 static void ubq_complete_io_cmd(struct ublk_io *io, int res,
 				unsigned issue_flags)
 {
@@ -1301,8 +1250,6 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 {
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
-	unsigned int nr_inflight = 0;
-	int i;
 
 	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
 		if (!ubq->timeout) {
@@ -1313,26 +1260,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 		return BLK_EH_DONE;
 	}
 
-	if (!ubq_daemon_is_dying(ubq))
-		return BLK_EH_RESET_TIMER;
-
-	for (i = 0; i < ubq->q_depth; i++) {
-		struct ublk_io *io = &ubq->ios[i];
-
-		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
-			nr_inflight++;
-	}
-
-	/* cancelable uring_cmd can't help us if all commands are in-flight */
-	if (nr_inflight == ubq->q_depth) {
-		struct ublk_device *ub = ubq->dev;
-
-		if (ublk_abort_requests(ub, ubq)) {
-			schedule_work(&ub->nosrv_work);
-		}
-		return BLK_EH_DONE;
-	}
-
 	return BLK_EH_RESET_TIMER;
 }
 
@@ -1435,6 +1362,37 @@ static const struct blk_mq_ops ublk_mq_ops = {
 	.timeout	= ublk_timeout,
 };
 
+static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
+{
+	int i;
+
+	/* All old ioucmds have to be completed */
+	ubq->nr_io_ready = 0;
+
+	/*
+	 * old daemon is PF_EXITING, put it now
+	 *
+	 * It could be NULL in case of closing one quisced device.
+	 */
+	if (ubq->ubq_daemon)
+		put_task_struct(ubq->ubq_daemon);
+	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
+	ubq->ubq_daemon = NULL;
+	ubq->timeout = false;
+
+	for (i = 0; i < ubq->q_depth; i++) {
+		struct ublk_io *io = &ubq->ios[i];
+
+		/*
+		 * UBLK_IO_FLAG_CANCELED is kept for avoiding to touch
+		 * io->cmd
+		 */
+		io->flags &= UBLK_IO_FLAG_CANCELED;
+		io->cmd = NULL;
+		io->addr = 0;
+	}
+}
+
 static int ublk_ch_open(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = container_of(inode->i_cdev,
@@ -1446,10 +1404,119 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static void ublk_reset_ch_dev(struct ublk_device *ub)
+{
+	int i;
+
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
+
+	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
+	ub->mm = NULL;
+	ub->nr_queues_ready = 0;
+	ub->nr_privileged_daemon = 0;
+}
+
+static struct gendisk *ublk_get_disk(struct ublk_device *ub)
+{
+	struct gendisk *disk;
+
+	spin_lock(&ub->lock);
+	disk = ub->ub_disk;
+	if (disk)
+		get_device(disk_to_dev(disk));
+	spin_unlock(&ub->lock);
+
+	return disk;
+}
+
+static void ublk_put_disk(struct gendisk *disk)
+{
+	if (disk)
+		put_device(disk_to_dev(disk));
+}
+
 static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
+	struct gendisk *disk;
+	int i;
+
+	/*
+	 * disk isn't attached yet, either device isn't live, or it has
+	 * been removed already, so we needn't to do anything
+	 */
+	disk = ublk_get_disk(ub);
+	if (!disk)
+		goto out;
 
+	/*
+	 * All uring_cmd are done now, so abort any request outstanding to
+	 * the ublk server
+	 *
+	 * This can be done in lockless way because ublk server has been
+	 * gone
+	 *
+	 * More importantly, we have to provide forward progress guarantee
+	 * without holding ub->mutex, otherwise control task grabbing
+	 * ub->mutex triggers deadlock
+	 *
+	 * All requests may be inflight, so ->canceling may not be set, set
+	 * it now.
+	 */
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		ubq->canceling = true;
+		ublk_abort_queue(ub, ubq);
+	}
+	blk_mq_kick_requeue_list(disk->queue);
+
+	/*
+	 * All infligh requests have been completed or requeued and any new
+	 * request will be failed or requeued via `->canceling` now, so it is
+	 * fine to grab ub->mutex now.
+	 */
+	mutex_lock(&ub->mutex);
+
+	/* double check after grabbing lock */
+	if (!ub->ub_disk)
+		goto unlock;
+
+	/*
+	 * Transition the device to the nosrv state. What exactly this
+	 * means depends on the recovery flags
+	 */
+	blk_mq_quiesce_queue(disk->queue);
+	if (ublk_nosrv_should_stop_dev(ub)) {
+		/*
+		 * Allow any pending/future I/O to pass through quickly
+		 * with an error. This is needed because del_gendisk
+		 * waits for all pending I/O to complete
+		 */
+		for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+			ublk_get_queue(ub, i)->force_abort = true;
+		blk_mq_unquiesce_queue(disk->queue);
+
+		ublk_stop_dev_unlocked(ub);
+	} else {
+		if (ublk_nosrv_dev_should_queue_io(ub)) {
+			/* ->canceling is set and all requests are aborted */
+			ub->dev_info.state = UBLK_S_DEV_QUIESCED;
+		} else {
+			ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
+			for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+				ublk_get_queue(ub, i)->fail_io = true;
+		}
+		blk_mq_unquiesce_queue(disk->queue);
+	}
+unlock:
+	mutex_unlock(&ub->mutex);
+	ublk_put_disk(disk);
+
+	/* all uring_cmd has been done now, reset device & ubq */
+	ublk_reset_ch_dev(ub);
+out:
 	clear_bit(UB_STATE_OPEN, &ub->state);
 	return 0;
 }
@@ -1516,10 +1583,26 @@ static void ublk_commit_completion(struct ublk_device *ub,
 		ublk_put_req_ref(ubq, req);
 }
 
+static void __ublk_fail_req(struct ublk_queue *ubq, struct ublk_io *io,
+		struct request *req)
+{
+	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
+
+	if (ublk_nosrv_should_reissue_outstanding(ubq->dev))
+		blk_mq_requeue_request(req, false);
+	else {
+		io->res = -EIO;
+		__ublk_complete_rq(req);
+	}
+}
+
 /*
- * Called from ubq_daemon context via cancel fn, meantime quiesce ublk
- * blk-mq queue, so we are called exclusively with blk-mq and ubq_daemon
- * context, so everything is serialized.
+ * Called from ublk char device release handler, when any uring_cmd is
+ * done, meantime request queue is "quiesced" since all inflight requests
+ * can't be completed because ublk server is dead.
+ *
+ * So no one can hold our request IO reference any more, simply ignore the
+ * reference, and complete the request immediately
  */
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 {
@@ -1536,46 +1619,29 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 			 * will do it
 			 */
 			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
-			if (rq && blk_mq_request_started(rq)) {
-				io->flags |= UBLK_IO_FLAG_ABORTED;
+			if (rq && blk_mq_request_started(rq))
 				__ublk_fail_req(ubq, io, rq);
-			}
 		}
 	}
 }
 
 /* Must be called when queue is frozen */
-static bool ublk_mark_queue_canceling(struct ublk_queue *ubq)
+static void ublk_mark_queue_canceling(struct ublk_queue *ubq)
 {
-	bool canceled;
-
 	spin_lock(&ubq->cancel_lock);
-	canceled = ubq->canceling;
-	if (!canceled)
+	if (!ubq->canceling)
 		ubq->canceling = true;
 	spin_unlock(&ubq->cancel_lock);
-
-	return canceled;
 }
 
-static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
+static void ublk_start_cancel(struct ublk_queue *ubq)
 {
-	bool was_canceled = ubq->canceling;
-	struct gendisk *disk;
-
-	if (was_canceled)
-		return false;
-
-	spin_lock(&ub->lock);
-	disk = ub->ub_disk;
-	if (disk)
-		get_device(disk_to_dev(disk));
-	spin_unlock(&ub->lock);
+	struct ublk_device *ub = ubq->dev;
+	struct gendisk *disk = ublk_get_disk(ub);
 
 	/* Our disk has been dead */
 	if (!disk)
-		return false;
-
+		return;
 	/*
 	 * Now we are serialized with ublk_queue_rq()
 	 *
@@ -1584,25 +1650,36 @@ static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
 	 * touch completed uring_cmd
 	 */
 	blk_mq_quiesce_queue(disk->queue);
-	was_canceled = ublk_mark_queue_canceling(ubq);
-	if (!was_canceled) {
-		/* abort queue is for making forward progress */
-		ublk_abort_queue(ub, ubq);
-	}
+	ublk_mark_queue_canceling(ubq);
 	blk_mq_unquiesce_queue(disk->queue);
-	put_device(disk_to_dev(disk));
-
-	return !was_canceled;
+	ublk_put_disk(disk);
 }
 
-static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
+static void ublk_cancel_cmd(struct ublk_queue *ubq, unsigned tag,
 		unsigned int issue_flags)
 {
+	struct ublk_io *io = &ubq->ios[tag];
+	struct ublk_device *ub = ubq->dev;
+	struct request *req;
 	bool done;
 
 	if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
 		return;
 
+	/*
+	 * Don't try to cancel this command if the request is started for
+	 * avoiding race between io_uring_cmd_done() and
+	 * io_uring_cmd_complete_in_task().
+	 *
+	 * Either the started request will be aborted via __ublk_abort_rq(),
+	 * then this uring_cmd is canceled next time, or it will be done in
+	 * task work function ublk_dispatch_req() because io_uring guarantees
+	 * that ublk_dispatch_req() is always called
+	 */
+	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
+	if (req && blk_mq_request_started(req))
+		return;
+
 	spin_lock(&ubq->cancel_lock);
 	done = !!(io->flags & UBLK_IO_FLAG_CANCELED);
 	if (!done)
@@ -1616,6 +1693,17 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
 /*
  * The ublk char device won't be closed when calling cancel fn, so both
  * ublk device and queue are guaranteed to be live
+ *
+ * Two-stage cancel:
+ *
+ * - make every active uring_cmd done in ->cancel_fn()
+ *
+ * - aborting inflight ublk IO requests in ublk char device release handler,
+ *   which depends on 1st stage because device can only be closed iff all
+ *   uring_cmd are done
+ *
+ * Do _not_ try to acquire ub->mutex before all inflight requests are
+ * aborted, otherwise deadlock may be caused.
  */
 static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
@@ -1623,9 +1711,6 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
 	struct task_struct *task;
-	struct ublk_device *ub;
-	bool need_schedule;
-	struct ublk_io *io;
 
 	if (WARN_ON_ONCE(!ubq))
 		return;
@@ -1637,16 +1722,11 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	if (WARN_ON_ONCE(task && task != ubq->ubq_daemon))
 		return;
 
-	ub = ubq->dev;
-	need_schedule = ublk_abort_requests(ub, ubq);
-
-	io = &ubq->ios[pdu->tag];
-	WARN_ON_ONCE(io->cmd != cmd);
-	ublk_cancel_cmd(ubq, io, issue_flags);
+	if (!ubq->canceling)
+		ublk_start_cancel(ubq);
 
-	if (need_schedule) {
-		schedule_work(&ub->nosrv_work);
-	}
+	WARN_ON_ONCE(ubq->ios[pdu->tag].cmd != cmd);
+	ublk_cancel_cmd(ubq, pdu->tag, issue_flags);
 }
 
 static inline bool ublk_queue_ready(struct ublk_queue *ubq)
@@ -1659,7 +1739,7 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
 	int i;
 
 	for (i = 0; i < ubq->q_depth; i++)
-		ublk_cancel_cmd(ubq, &ubq->ios[i], IO_URING_F_UNLOCKED);
+		ublk_cancel_cmd(ubq, i, IO_URING_F_UNLOCKED);
 }
 
 /* Cancel all pending commands, must be called after del_gendisk() returns */
@@ -1697,23 +1777,6 @@ static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
 	}
 }
 
-static void __ublk_quiesce_dev(struct ublk_device *ub)
-{
-	int i;
-
-	pr_devel("%s: quiesce ub: dev_id %d state %s\n",
-			__func__, ub->dev_info.dev_id,
-			ub->dev_info.state == UBLK_S_DEV_LIVE ?
-			"LIVE" : "QUIESCED");
-	blk_mq_quiesce_queue(ub->ub_disk->queue);
-	/* mark every queue as canceling */
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
-		ublk_get_queue(ub, i)->canceling = true;
-	ublk_wait_tagset_rqs_idle(ub);
-	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
-	blk_mq_unquiesce_queue(ub->ub_disk->queue);
-}
-
 static void ublk_force_abort_dev(struct ublk_device *ub)
 {
 	int i;
@@ -1748,58 +1811,51 @@ static struct gendisk *ublk_detach_disk(struct ublk_device *ub)
 	return disk;
 }
 
-static void ublk_stop_dev(struct ublk_device *ub)
+static void ublk_stop_dev_unlocked(struct ublk_device *ub)
+	__must_hold(&ub->mutex)
 {
 	struct gendisk *disk;
 
-	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
-		goto unlock;
+		return;
+
 	if (ublk_nosrv_dev_should_queue_io(ub))
 		ublk_force_abort_dev(ub);
 	del_gendisk(ub->ub_disk);
 	disk = ublk_detach_disk(ub);
 	put_disk(disk);
- unlock:
+}
+
+static void ublk_stop_dev(struct ublk_device *ub)
+{
+	mutex_lock(&ub->mutex);
+	ublk_stop_dev_unlocked(ub);
 	mutex_unlock(&ub->mutex);
 	ublk_cancel_dev(ub);
 }
 
-static void ublk_nosrv_work(struct work_struct *work)
+/* reset ublk io_uring queue & io flags */
+static void ublk_reset_io_flags(struct ublk_device *ub)
 {
-	struct ublk_device *ub =
-		container_of(work, struct ublk_device, nosrv_work);
-	int i;
-
-	if (ublk_nosrv_should_stop_dev(ub)) {
-		ublk_stop_dev(ub);
-		return;
-	}
+	int i, j;
 
-	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
-		goto unlock;
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
 
-	if (ublk_nosrv_dev_should_queue_io(ub)) {
-		__ublk_quiesce_dev(ub);
-	} else {
-		blk_mq_quiesce_queue(ub->ub_disk->queue);
-		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
-		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-			ublk_get_queue(ub, i)->fail_io = true;
-		}
-		blk_mq_unquiesce_queue(ub->ub_disk->queue);
+		/* UBLK_IO_FLAG_CANCELED can be cleared now */
+		spin_lock(&ubq->cancel_lock);
+		for (j = 0; j < ubq->q_depth; j++)
+			ubq->ios[j].flags &= ~UBLK_IO_FLAG_CANCELED;
+		spin_unlock(&ubq->cancel_lock);
+		ubq->canceling = false;
+		ubq->fail_io = false;
 	}
-
- unlock:
-	mutex_unlock(&ub->mutex);
-	ublk_cancel_dev(ub);
 }
 
 /* device can only be started after all IOs are ready */
 static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
+	__must_hold(&ub->mutex)
 {
-	mutex_lock(&ub->mutex);
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
 		ubq->ubq_daemon = current;
@@ -1809,9 +1865,12 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 		if (capable(CAP_SYS_ADMIN))
 			ub->nr_privileged_daemon++;
 	}
-	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
+
+	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues) {
+		/* now we are ready for handling ublk io request */
+		ublk_reset_io_flags(ub);
 		complete_all(&ub->completion);
-	mutex_unlock(&ub->mutex);
+	}
 }
 
 static inline int ublk_check_cmd_op(u32 cmd_op)
@@ -1850,6 +1909,52 @@ static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 	io_uring_cmd_mark_cancelable(cmd, issue_flags);
 }
 
+static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
+		      struct ublk_io *io, __u64 buf_addr)
+{
+	struct ublk_device *ub = ubq->dev;
+	int ret = 0;
+
+	/*
+	 * When handling FETCH command for setting up ublk uring queue,
+	 * ub->mutex is the innermost lock, and we won't block for handling
+	 * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
+	 */
+	mutex_lock(&ub->mutex);
+	/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
+	if (ublk_queue_ready(ubq)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* allow each command to be FETCHed at most once */
+	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
+
+	if (ublk_need_map_io(ubq)) {
+		/*
+		 * FETCH_RQ has to provide IO buffer if NEED GET
+		 * DATA is not enabled
+		 */
+		if (!buf_addr && !ublk_need_get_data(ubq))
+			goto out;
+	} else if (buf_addr) {
+		/* User copy requires addr to be unset */
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ublk_fill_io_cmd(io, cmd, buf_addr);
+	ublk_mark_io_ready(ub, ubq);
+out:
+	mutex_unlock(&ub->mutex);
+	return ret;
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -1902,33 +2007,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	ret = -EINVAL;
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_FETCH_REQ:
-		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
-		if (ublk_queue_ready(ubq)) {
-			ret = -EBUSY;
-			goto out;
-		}
-		/*
-		 * The io is being handled by server, so COMMIT_RQ is expected
-		 * instead of FETCH_REQ
-		 */
-		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
-			goto out;
-
-		if (!ublk_support_user_copy(ubq)) {
-			/*
-			 * FETCH_RQ has to provide IO buffer if NEED GET
-			 * DATA is not enabled
-			 */
-			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
-				goto out;
-		} else if (ub_cmd->addr) {
-			/* User copy requires addr to be unset */
-			ret = -EINVAL;
+		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
+		if (ret)
 			goto out;
-		}
-
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_mark_io_ready(ub, ubq);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
@@ -1936,7 +2017,7 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
 
-		if (!ublk_support_user_copy(ubq)) {
+		if (ublk_need_map_io(ubq)) {
 			/*
 			 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
 			 * NEED GET DATA is not enabled or it is Read IO.
@@ -2324,7 +2405,6 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 static void ublk_remove(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->nosrv_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
 	ublk_put_device(ub);
 	ublks_added--;
@@ -2598,7 +2678,6 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		goto out_unlock;
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->lock);
-	INIT_WORK(&ub->nosrv_work, ublk_nosrv_work);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
 	if (ret < 0)
@@ -2733,7 +2812,6 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
 static int ublk_ctrl_stop_dev(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->nosrv_work);
 	return 0;
 }
 
@@ -2840,42 +2918,15 @@ static int ublk_ctrl_set_params(struct ublk_device *ub,
 	return ret;
 }
 
-static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
-{
-	int i;
-
-	WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
-
-	/* All old ioucmds have to be completed */
-	ubq->nr_io_ready = 0;
-	/* old daemon is PF_EXITING, put it now */
-	put_task_struct(ubq->ubq_daemon);
-	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
-	ubq->ubq_daemon = NULL;
-	ubq->timeout = false;
-
-	for (i = 0; i < ubq->q_depth; i++) {
-		struct ublk_io *io = &ubq->ios[i];
-
-		/* forget everything now and be ready for new FETCH_REQ */
-		io->flags = 0;
-		io->cmd = NULL;
-		io->addr = 0;
-	}
-}
-
 static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 		struct io_uring_cmd *cmd)
 {
 	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
 	int ret = -EINVAL;
-	int i;
 
 	mutex_lock(&ub->mutex);
 	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
-	if (!ub->nr_queues_ready)
-		goto out_unlock;
 	/*
 	 * START_RECOVERY is only allowd after:
 	 *
@@ -2899,12 +2950,6 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 		goto out_unlock;
 	}
 	pr_devel("%s: start recovery for dev id %d.\n", __func__, header->dev_id);
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
-		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
-	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
-	ub->mm = NULL;
-	ub->nr_queues_ready = 0;
-	ub->nr_privileged_daemon = 0;
 	init_completion(&ub->completion);
 	ret = 0;
  out_unlock:
@@ -2918,7 +2963,6 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	const struct ublksrv_ctrl_cmd *header = io_uring_sqe_cmd(cmd->sqe);
 	int ublksrv_pid = (int)header->data[0];
 	int ret = -EINVAL;
-	int i;
 
 	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
@@ -2938,22 +2982,10 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 		goto out_unlock;
 	}
 	ub->dev_info.ublksrv_pid = ublksrv_pid;
+	ub->dev_info.state = UBLK_S_DEV_LIVE;
 	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
 			__func__, ublksrv_pid, header->dev_id);
-
-	blk_mq_quiesce_queue(ub->ub_disk->queue);
-	ub->dev_info.state = UBLK_S_DEV_LIVE;
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-		struct ublk_queue *ubq = ublk_get_queue(ub, i);
-
-		ubq->canceling = false;
-		ubq->fail_io = false;
-	}
-	blk_mq_unquiesce_queue(ub->ub_disk->queue);
-	pr_devel("%s: queue unquiesced, dev id %d.\n",
-			__func__, header->dev_id);
 	blk_mq_kick_requeue_list(ub->ub_disk->queue);
-
 	ret = 0;
  out_unlock:
 	mutex_unlock(&ub->mutex);
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 6130854b6658..1636f636fbef 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -595,8 +595,10 @@ static int btintel_pcie_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 		/* This is a debug event that comes from IML and OP image when it
 		 * starts execution. There is no need pass this event to stack.
 		 */
-		if (skb->data[2] == 0x97)
+		if (skb->data[2] == 0x97) {
+			hci_recv_diag(hdev, skb);
 			return 0;
+		}
 	}
 
 	return hci_recv_frame(hdev, skb);
@@ -612,7 +614,6 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
 	u8 pkt_type;
 	u16 plen;
 	u32 pcie_pkt_type;
-	struct sk_buff *new_skb;
 	void *pdata;
 	struct hci_dev *hdev = data->hdev;
 
@@ -689,24 +690,20 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
 
 	bt_dev_dbg(hdev, "pkt_type: 0x%2.2x len: %u", pkt_type, plen);
 
-	new_skb = bt_skb_alloc(plen, GFP_ATOMIC);
-	if (!new_skb) {
-		bt_dev_err(hdev, "Failed to allocate memory for skb of len: %u",
-			   skb->len);
-		ret = -ENOMEM;
-		goto exit_error;
-	}
-
-	hci_skb_pkt_type(new_skb) = pkt_type;
-	skb_put_data(new_skb, skb->data, plen);
+	hci_skb_pkt_type(skb) = pkt_type;
 	hdev->stat.byte_rx += plen;
+	skb_trim(skb, plen);
 
 	if (pcie_pkt_type == BTINTEL_PCIE_HCI_EVT_PKT)
-		ret = btintel_pcie_recv_event(hdev, new_skb);
+		ret = btintel_pcie_recv_event(hdev, skb);
 	else
-		ret = hci_recv_frame(hdev, new_skb);
+		ret = hci_recv_frame(hdev, skb);
+	skb = NULL; /* skb is freed in the callee  */
 
 exit_error:
+	if (skb)
+		kfree_skb(skb);
+
 	if (ret)
 		hdev->stat.err_rx++;
 
@@ -720,16 +717,10 @@ static void btintel_pcie_rx_work(struct work_struct *work)
 	struct btintel_pcie_data *data = container_of(work,
 					struct btintel_pcie_data, rx_work);
 	struct sk_buff *skb;
-	int err;
-	struct hci_dev *hdev = data->hdev;
 
 	/* Process the sk_buf in queue and send to the HCI layer */
 	while ((skb = skb_dequeue(&data->rx_skb_q))) {
-		err = btintel_pcie_recv_frame(data, skb);
-		if (err)
-			bt_dev_err(hdev, "Failed to send received frame: %d",
-				   err);
-		kfree_skb(skb);
+		btintel_pcie_recv_frame(data, skb);
 	}
 }
 
@@ -782,10 +773,8 @@ static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
 	bt_dev_dbg(hdev, "RXQ: cr_hia: %u  cr_tia: %u", cr_hia, cr_tia);
 
 	/* Check CR_TIA and CR_HIA for change */
-	if (cr_tia == cr_hia) {
-		bt_dev_warn(hdev, "RXQ: no new CD found");
+	if (cr_tia == cr_hia)
 		return;
-	}
 
 	rxq = &data->rxq;
 
@@ -821,6 +810,16 @@ static irqreturn_t btintel_pcie_msix_isr(int irq, void *data)
 	return IRQ_WAKE_THREAD;
 }
 
+static inline bool btintel_pcie_is_rxq_empty(struct btintel_pcie_data *data)
+{
+	return data->ia.cr_hia[BTINTEL_PCIE_RXQ_NUM] == data->ia.cr_tia[BTINTEL_PCIE_RXQ_NUM];
+}
+
+static inline bool btintel_pcie_is_txackq_empty(struct btintel_pcie_data *data)
+{
+	return data->ia.cr_tia[BTINTEL_PCIE_TXQ_NUM] == data->ia.cr_hia[BTINTEL_PCIE_TXQ_NUM];
+}
+
 static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 {
 	struct msix_entry *entry = dev_id;
@@ -848,12 +847,18 @@ static irqreturn_t btintel_pcie_irq_msix_handler(int irq, void *dev_id)
 		btintel_pcie_msix_gp0_handler(data);
 
 	/* For TX */
-	if (intr_fh & BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0)
+	if (intr_fh & BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0) {
 		btintel_pcie_msix_tx_handle(data);
+		if (!btintel_pcie_is_rxq_empty(data))
+			btintel_pcie_msix_rx_handle(data);
+	}
 
 	/* For RX */
-	if (intr_fh & BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1)
+	if (intr_fh & BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1) {
 		btintel_pcie_msix_rx_handle(data);
+		if (!btintel_pcie_is_txackq_empty(data))
+			btintel_pcie_msix_tx_handle(data);
+	}
 
 	/*
 	 * Before sending the interrupt the HW disables it to prevent a nested
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index bfd769f2026b..ccd0a21da395 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3010,22 +3010,16 @@ static void btusb_coredump_qca(struct hci_dev *hdev)
 		bt_dev_err(hdev, "%s: triggle crash failed (%d)", __func__, err);
 }
 
-/*
- * ==0: not a dump pkt.
- * < 0: fails to handle a dump pkt
- * > 0: otherwise.
- */
+/* Return: 0 on success, negative errno on failure. */
 static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	int ret = 1;
+	int ret = 0;
 	u8 pkt_type;
 	u8 *sk_ptr;
 	unsigned int sk_len;
 	u16 seqno;
 	u32 dump_size;
 
-	struct hci_event_hdr *event_hdr;
-	struct hci_acl_hdr *acl_hdr;
 	struct qca_dump_hdr *dump_hdr;
 	struct btusb_data *btdata = hci_get_drvdata(hdev);
 	struct usb_device *udev = btdata->udev;
@@ -3035,30 +3029,14 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 	sk_len = skb->len;
 
 	if (pkt_type == HCI_ACLDATA_PKT) {
-		acl_hdr = hci_acl_hdr(skb);
-		if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
-			return 0;
 		sk_ptr += HCI_ACL_HDR_SIZE;
 		sk_len -= HCI_ACL_HDR_SIZE;
-		event_hdr = (struct hci_event_hdr *)sk_ptr;
-	} else {
-		event_hdr = hci_event_hdr(skb);
 	}
 
-	if ((event_hdr->evt != HCI_VENDOR_PKT)
-		|| (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
-		return 0;
-
 	sk_ptr += HCI_EVENT_HDR_SIZE;
 	sk_len -= HCI_EVENT_HDR_SIZE;
 
 	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
-	if ((sk_len < offsetof(struct qca_dump_hdr, data))
-		|| (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
-	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
-		return 0;
-
-	/*it is dump pkt now*/
 	seqno = le16_to_cpu(dump_hdr->seqno);
 	if (seqno == 0) {
 		set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
@@ -3132,17 +3110,84 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 	return ret;
 }
 
+/* Return: true if the ACL packet is a dump packet, false otherwise. */
+static bool acl_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	u8 *sk_ptr;
+	unsigned int sk_len;
+
+	struct hci_event_hdr *event_hdr;
+	struct hci_acl_hdr *acl_hdr;
+	struct qca_dump_hdr *dump_hdr;
+
+	sk_ptr = skb->data;
+	sk_len = skb->len;
+
+	acl_hdr = hci_acl_hdr(skb);
+	if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
+		return false;
+
+	sk_ptr += HCI_ACL_HDR_SIZE;
+	sk_len -= HCI_ACL_HDR_SIZE;
+	event_hdr = (struct hci_event_hdr *)sk_ptr;
+
+	if ((event_hdr->evt != HCI_VENDOR_PKT) ||
+	    (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
+		return false;
+
+	sk_ptr += HCI_EVENT_HDR_SIZE;
+	sk_len -= HCI_EVENT_HDR_SIZE;
+
+	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
+	if ((sk_len < offsetof(struct qca_dump_hdr, data)) ||
+	    (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
+	    (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
+		return false;
+
+	return true;
+}
+
+/* Return: true if the event packet is a dump packet, false otherwise. */
+static bool evt_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	u8 *sk_ptr;
+	unsigned int sk_len;
+
+	struct hci_event_hdr *event_hdr;
+	struct qca_dump_hdr *dump_hdr;
+
+	sk_ptr = skb->data;
+	sk_len = skb->len;
+
+	event_hdr = hci_event_hdr(skb);
+
+	if ((event_hdr->evt != HCI_VENDOR_PKT)
+	    || (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
+		return false;
+
+	sk_ptr += HCI_EVENT_HDR_SIZE;
+	sk_len -= HCI_EVENT_HDR_SIZE;
+
+	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
+	if ((sk_len < offsetof(struct qca_dump_hdr, data)) ||
+	    (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
+	    (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
+		return false;
+
+	return true;
+}
+
 static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	if (handle_dump_pkt_qca(hdev, skb))
-		return 0;
+	if (acl_pkt_is_dump_qca(hdev, skb))
+		return handle_dump_pkt_qca(hdev, skb);
 	return hci_recv_frame(hdev, skb);
 }
 
 static int btusb_recv_evt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	if (handle_dump_pkt_qca(hdev, skb))
-		return 0;
+	if (evt_pkt_is_dump_qca(hdev, skb))
+		return handle_dump_pkt_qca(hdev, skb);
 	return hci_recv_frame(hdev, skb);
 }
 
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 463b69a2dff5..453b629d3de6 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -909,6 +909,20 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
 		pr_warn(FW_WARN "P-state 0 is not max freq\n");
 
+	if (acpi_cpufreq_driver.set_boost) {
+		if (policy->boost_supported) {
+			/*
+			 * The firmware may have altered boost state while the
+			 * CPU was offline (for example during a suspend-resume
+			 * cycle).
+			 */
+			if (policy->boost_enabled != boost_state(cpu))
+				set_boost(policy, policy->boost_enabled);
+		} else {
+			policy->boost_supported = true;
+		}
+	}
+
 	return result;
 
 err_unreg:
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 934e0e19824c..61cbfb56bf4e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -535,16 +535,18 @@ void cpufreq_disable_fast_switch(struct cpufreq_policy *policy)
 EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 
 static unsigned int __resolve_freq(struct cpufreq_policy *policy,
-		unsigned int target_freq, unsigned int relation)
+				   unsigned int target_freq,
+				   unsigned int min, unsigned int max,
+				   unsigned int relation)
 {
 	unsigned int idx;
 
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	target_freq = clamp_val(target_freq, min, max);
 
 	if (!policy->freq_table)
 		return target_freq;
 
-	idx = cpufreq_frequency_table_target(policy, target_freq, relation);
+	idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
 	policy->cached_resolved_idx = idx;
 	policy->cached_target_freq = target_freq;
 	return policy->freq_table[idx].frequency;
@@ -564,7 +566,21 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 					 unsigned int target_freq)
 {
-	return __resolve_freq(policy, target_freq, CPUFREQ_RELATION_LE);
+	unsigned int min = READ_ONCE(policy->min);
+	unsigned int max = READ_ONCE(policy->max);
+
+	/*
+	 * If this function runs in parallel with cpufreq_set_policy(), it may
+	 * read policy->min before the update and policy->max after the update
+	 * or the other way around, so there is no ordering guarantee.
+	 *
+	 * Resolve this by always honoring the max (in case it comes from
+	 * thermal throttling or similar).
+	 */
+	if (unlikely(min > max))
+		min = max;
+
+	return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
@@ -2337,7 +2353,8 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	if (cpufreq_disabled())
 		return -ENODEV;
 
-	target_freq = __resolve_freq(policy, target_freq, relation);
+	target_freq = __resolve_freq(policy, target_freq, policy->min,
+				     policy->max, relation);
 
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
 		 policy->cpu, target_freq, relation, old_target_freq);
@@ -2661,11 +2678,18 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	 * Resolve policy min/max to available frequencies. It ensures
 	 * no frequency resolution will neither overshoot the requested maximum
 	 * nor undershoot the requested minimum.
+	 *
+	 * Avoid storing intermediate values in policy->max or policy->min and
+	 * compiler optimizations around them because they may be accessed
+	 * concurrently by cpufreq_driver_resolve_freq() during the update.
 	 */
-	policy->min = new_data.min;
-	policy->max = new_data.max;
-	policy->min = __resolve_freq(policy, policy->min, CPUFREQ_RELATION_L);
-	policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
+	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max,
+					       new_data.min, new_data.max,
+					       CPUFREQ_RELATION_H));
+	new_data.min = __resolve_freq(policy, new_data.min, new_data.min,
+				      new_data.max, CPUFREQ_RELATION_L);
+	WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);
+
 	trace_cpu_frequency_limits(policy);
 
 	cpufreq_update_pressure(policy);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index a7c38b8b3e78..0e65d37c9231 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -76,7 +76,8 @@ static unsigned int generic_powersave_bias_target(struct cpufreq_policy *policy,
 		return freq_next;
 	}
 
-	index = cpufreq_frequency_table_target(policy, freq_next, relation);
+	index = cpufreq_frequency_table_target(policy, freq_next, policy->min,
+					       policy->max, relation);
 	freq_req = freq_table[index].frequency;
 	freq_reduc = freq_req * od_tuners->powersave_bias / 1000;
 	freq_avg = freq_req - freq_reduc;
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 10e80d912b8d..9db21ffc1197 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -116,8 +116,8 @@ int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *policy)
 EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
 
 int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
-				 unsigned int target_freq,
-				 unsigned int relation)
+				 unsigned int target_freq, unsigned int min,
+				 unsigned int max, unsigned int relation)
 {
 	struct cpufreq_frequency_table optimal = {
 		.driver_data = ~0,
@@ -148,7 +148,7 @@ int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
 	cpufreq_for_each_valid_entry_idx(pos, table, i) {
 		freq = pos->frequency;
 
-		if ((freq < policy->min) || (freq > policy->max))
+		if (freq < min || freq > max)
 			continue;
 		if (freq == target_freq) {
 			optimal.driver_data = i;
@@ -367,6 +367,10 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
 	if (ret)
 		return ret;
 
+	/* Driver's may have set this field already */
+	if (policy_has_boost_freq(policy))
+		policy->boost_supported = true;
+
 	return set_freq_table_sorted(policy);
 }
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 9c4cc01fd51a..43e847e9f741 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -598,6 +598,9 @@ static bool turbo_is_disabled(void)
 {
 	u64 misc_en;
 
+	if (!cpu_feature_enabled(X86_FEATURE_IDA))
+		return true;
+
 	rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
 
 	return !!(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 3e971f902363..dcd7008fe06b 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -99,7 +99,7 @@ static irqreturn_t altr_sdram_mc_err_handler(int irq, void *dev_id)
 	if (status & priv->ecc_stat_ce_mask) {
 		regmap_read(drvdata->mc_vbase, priv->ecc_saddr_offset,
 			    &err_addr);
-		if (priv->ecc_uecnt_offset)
+		if (priv->ecc_cecnt_offset)
 			regmap_read(drvdata->mc_vbase,  priv->ecc_cecnt_offset,
 				    &err_count);
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, err_count,
@@ -1005,9 +1005,6 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 		}
 	}
 
-	/* Interrupt mode set to every SBERR */
-	regmap_write(ecc_mgr_map, ALTR_A10_ECC_INTMODE_OFST,
-		     ALTR_A10_ECC_INTMODE);
 	/* Enable ECC */
 	ecc_set_bits(ecc_ctrl_en_mask, (ecc_block_base +
 					ALTR_A10_ECC_CTRL_OFST));
@@ -2127,6 +2124,10 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 		return PTR_ERR(edac->ecc_mgr_map);
 	}
 
+	/* Set irq mask for DDR SBE to avoid any pending irq before registration */
+	regmap_write(edac->ecc_mgr_map, A10_SYSMGR_ECC_INTMASK_SET_OFST,
+		     (A10_SYSMGR_ECC_INTMASK_SDMMCB | A10_SYSMGR_ECC_INTMASK_DDR0));
+
 	edac->irq_chip.name = pdev->dev.of_node->name;
 	edac->irq_chip.irq_mask = a10_eccmgr_irq_mask;
 	edac->irq_chip.irq_unmask = a10_eccmgr_irq_unmask;
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 3727e72c8c2e..7248d24c4908 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -249,6 +249,8 @@ struct altr_sdram_mc_data {
 #define A10_SYSMGR_ECC_INTMASK_SET_OFST   0x94
 #define A10_SYSMGR_ECC_INTMASK_CLR_OFST   0x98
 #define A10_SYSMGR_ECC_INTMASK_OCRAM      BIT(1)
+#define A10_SYSMGR_ECC_INTMASK_SDMMCB     BIT(16)
+#define A10_SYSMGR_ECC_INTMASK_DDR0       BIT(17)
 
 #define A10_SYSMGR_ECC_INTSTAT_SERR_OFST  0x9C
 #define A10_SYSMGR_ECC_INTSTAT_DERR_OFST  0xA0
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 655672a88095..03d22cbb2ad4 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -280,7 +280,8 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
 			memcpy(buffer + idx, drv_info->rx_buffer + idx * sz,
 			       buf_sz);
 
-	ffa_rx_release();
+	if (!(flags & PARTITION_INFO_GET_RETURN_COUNT_ONLY))
+		ffa_rx_release();
 
 	mutex_unlock(&drv_info->rx_lock);
 
diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index a3386bf36de5..7d7af2262c01 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -260,6 +260,9 @@ static struct scmi_device *scmi_child_dev_find(struct device *parent,
 	if (!dev)
 		return NULL;
 
+	/* Drop the refcnt bumped implicitly by device_find_child */
+	put_device(dev);
+
 	return to_scmi_dev(dev);
 }
 
diff --git a/drivers/firmware/cirrus/Kconfig b/drivers/firmware/cirrus/Kconfig
index 0a883091259a..e3c2e38b746d 100644
--- a/drivers/firmware/cirrus/Kconfig
+++ b/drivers/firmware/cirrus/Kconfig
@@ -6,14 +6,11 @@ config FW_CS_DSP
 
 config FW_CS_DSP_KUNIT_TEST_UTILS
 	tristate
-	depends on KUNIT && REGMAP
-	select FW_CS_DSP
 
 config FW_CS_DSP_KUNIT_TEST
 	tristate "KUnit tests for Cirrus Logic cs_dsp" if !KUNIT_ALL_TESTS
-	depends on KUNIT && REGMAP
+	depends on KUNIT && REGMAP && FW_CS_DSP
 	default KUNIT_ALL_TESTS
-	select FW_CS_DSP
 	select FW_CS_DSP_KUNIT_TEST_UTILS
 	help
 	  This builds KUnit tests for cs_dsp.
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index fbef3f471bd0..bd228dc77e99 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -188,7 +188,7 @@ config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
         bool "Enable refcount backtrace history in the DP MST helpers"
 	depends on STACKTRACE_SUPPORT
         select STACKDEPOT
-        depends on DRM_KMS_HELPER
+        select DRM_KMS_HELPER
         depends on DEBUG_KERNEL
         depends on EXPERT
         help
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
index 41421da63a08..a11f556b3ff1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -361,7 +361,7 @@ static void nbio_v7_11_get_clockgating_state(struct amdgpu_device *adev,
 		*flags |= AMD_CG_SUPPORT_BIF_LS;
 }
 
-#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
+#define MMIO_REG_HOLE_OFFSET 0x44000
 
 static void nbio_v7_11_set_reg_remap(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 76c8e6457175..3660e4a1a85f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1912,26 +1912,6 @@ static enum dmub_ips_disable_type dm_get_default_ips_mode(
 
 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 	case IP_VERSION(3, 5, 0):
-		/*
-		 * On DCN35 systems with Z8 enabled, it's possible for IPS2 + Z8 to
-		 * cause a hard hang. A fix exists for newer PMFW.
-		 *
-		 * As a workaround, for non-fixed PMFW, force IPS1+RCG as the deepest
-		 * IPS state in all cases, except for s0ix and all displays off (DPMS),
-		 * where IPS2 is allowed.
-		 *
-		 * When checking pmfw version, use the major and minor only.
-		 */
-		if ((adev->pm.fw_version & 0x00FFFF00) < 0x005D6300)
-			ret = DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
-		else if (amdgpu_ip_version(adev, GC_HWIP, 0) > IP_VERSION(11, 5, 0))
-			/*
-			 * Other ASICs with DCN35 that have residency issues with
-			 * IPS2 in idle.
-			 * We want them to use IPS2 only in display off cases.
-			 */
-			ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
-		break;
 	case IP_VERSION(3, 5, 1):
 		ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
 		break;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index c0dc23244049..10ba4d7bf632 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -172,7 +172,10 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 	struct mod_hdcp_display_adjustment display_adjust;
 	unsigned int conn_index = aconnector->base.index;
 
-	mutex_lock(&hdcp_w->mutex);
+	guard(mutex)(&hdcp_w->mutex);
+	drm_connector_get(&aconnector->base);
+	if (hdcp_w->aconnector[conn_index])
+		drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
 	hdcp_w->aconnector[conn_index] = aconnector;
 
 	memset(&link_adjust, 0, sizeof(link_adjust));
@@ -209,7 +212,6 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 	mod_hdcp_update_display(&hdcp_w->hdcp, conn_index, &link_adjust, &display_adjust, &hdcp_w->output);
 
 	process_output(hdcp_w);
-	mutex_unlock(&hdcp_w->mutex);
 }
 
 static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
@@ -220,8 +222,7 @@ static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 	struct drm_connector_state *conn_state = aconnector->base.state;
 	unsigned int conn_index = aconnector->base.index;
 
-	mutex_lock(&hdcp_w->mutex);
-	hdcp_w->aconnector[conn_index] = aconnector;
+	guard(mutex)(&hdcp_w->mutex);
 
 	/* the removal of display will invoke auth reset -> hdcp destroy and
 	 * we'd expect the Content Protection (CP) property changed back to
@@ -237,9 +238,11 @@ static void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 	}
 
 	mod_hdcp_remove_display(&hdcp_w->hdcp, aconnector->base.index, &hdcp_w->output);
-
+	if (hdcp_w->aconnector[conn_index]) {
+		drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
+		hdcp_w->aconnector[conn_index] = NULL;
+	}
 	process_output(hdcp_w);
-	mutex_unlock(&hdcp_w->mutex);
 }
 
 void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_index)
@@ -247,7 +250,7 @@ void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_inde
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
 	unsigned int conn_index;
 
-	mutex_lock(&hdcp_w->mutex);
+	guard(mutex)(&hdcp_w->mutex);
 
 	mod_hdcp_reset_connection(&hdcp_w->hdcp,  &hdcp_w->output);
 
@@ -256,11 +259,13 @@ void hdcp_reset_display(struct hdcp_workqueue *hdcp_work, unsigned int link_inde
 	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_INDEX; conn_index++) {
 		hdcp_w->encryption_status[conn_index] =
 			MOD_HDCP_ENCRYPTION_STATUS_HDCP_OFF;
+		if (hdcp_w->aconnector[conn_index]) {
+			drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
+			hdcp_w->aconnector[conn_index] = NULL;
+		}
 	}
 
 	process_output(hdcp_w);
-
-	mutex_unlock(&hdcp_w->mutex);
 }
 
 void hdcp_handle_cpirq(struct hdcp_workqueue *hdcp_work, unsigned int link_index)
@@ -277,7 +282,7 @@ static void event_callback(struct work_struct *work)
 	hdcp_work = container_of(to_delayed_work(work), struct hdcp_workqueue,
 				 callback_dwork);
 
-	mutex_lock(&hdcp_work->mutex);
+	guard(mutex)(&hdcp_work->mutex);
 
 	cancel_delayed_work(&hdcp_work->callback_dwork);
 
@@ -285,8 +290,6 @@ static void event_callback(struct work_struct *work)
 			       &hdcp_work->output);
 
 	process_output(hdcp_work);
-
-	mutex_unlock(&hdcp_work->mutex);
 }
 
 static void event_property_update(struct work_struct *work)
@@ -323,7 +326,7 @@ static void event_property_update(struct work_struct *work)
 			continue;
 
 		drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-		mutex_lock(&hdcp_work->mutex);
+		guard(mutex)(&hdcp_work->mutex);
 
 		if (conn_state->commit) {
 			ret = wait_for_completion_interruptible_timeout(&conn_state->commit->hw_done,
@@ -355,7 +358,6 @@ static void event_property_update(struct work_struct *work)
 			drm_hdcp_update_content_protection(connector,
 							   DRM_MODE_CONTENT_PROTECTION_DESIRED);
 		}
-		mutex_unlock(&hdcp_work->mutex);
 		drm_modeset_unlock(&dev->mode_config.connection_mutex);
 	}
 }
@@ -368,7 +370,7 @@ static void event_property_validate(struct work_struct *work)
 	struct amdgpu_dm_connector *aconnector;
 	unsigned int conn_index;
 
-	mutex_lock(&hdcp_work->mutex);
+	guard(mutex)(&hdcp_work->mutex);
 
 	for (conn_index = 0; conn_index < AMDGPU_DM_MAX_DISPLAY_INDEX;
 	     conn_index++) {
@@ -408,8 +410,6 @@ static void event_property_validate(struct work_struct *work)
 			schedule_work(&hdcp_work->property_update_work);
 		}
 	}
-
-	mutex_unlock(&hdcp_work->mutex);
 }
 
 static void event_watchdog_timer(struct work_struct *work)
@@ -420,7 +420,7 @@ static void event_watchdog_timer(struct work_struct *work)
 				 struct hdcp_workqueue,
 				      watchdog_timer_dwork);
 
-	mutex_lock(&hdcp_work->mutex);
+	guard(mutex)(&hdcp_work->mutex);
 
 	cancel_delayed_work(&hdcp_work->watchdog_timer_dwork);
 
@@ -429,8 +429,6 @@ static void event_watchdog_timer(struct work_struct *work)
 			       &hdcp_work->output);
 
 	process_output(hdcp_work);
-
-	mutex_unlock(&hdcp_work->mutex);
 }
 
 static void event_cpirq(struct work_struct *work)
@@ -439,13 +437,11 @@ static void event_cpirq(struct work_struct *work)
 
 	hdcp_work = container_of(work, struct hdcp_workqueue, cpirq_work);
 
-	mutex_lock(&hdcp_work->mutex);
+	guard(mutex)(&hdcp_work->mutex);
 
 	mod_hdcp_process_event(&hdcp_work->hdcp, MOD_HDCP_EVENT_CPIRQ, &hdcp_work->output);
 
 	process_output(hdcp_work);
-
-	mutex_unlock(&hdcp_work->mutex);
 }
 
 void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
@@ -479,7 +475,7 @@ static bool enable_assr(void *handle, struct dc_link *link)
 
 	dtm_cmd = (struct ta_dtm_shared_memory *)psp->dtm_context.context.mem_context.shared_buf;
 
-	mutex_lock(&psp->dtm_context.mutex);
+	guard(mutex)(&psp->dtm_context.mutex);
 	memset(dtm_cmd, 0, sizeof(struct ta_dtm_shared_memory));
 
 	dtm_cmd->cmd_id = TA_DTM_COMMAND__TOPOLOGY_ASSR_ENABLE;
@@ -494,8 +490,6 @@ static bool enable_assr(void *handle, struct dc_link *link)
 		res = false;
 	}
 
-	mutex_unlock(&psp->dtm_context.mutex);
-
 	return res;
 }
 
@@ -504,6 +498,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 	struct hdcp_workqueue *hdcp_work = handle;
 	struct amdgpu_dm_connector *aconnector = config->dm_stream_ctx;
 	int link_index = aconnector->dc_link->link_index;
+	unsigned int conn_index = aconnector->base.index;
 	struct mod_hdcp_display *display = &hdcp_work[link_index].display;
 	struct mod_hdcp_link *link = &hdcp_work[link_index].link;
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
@@ -557,13 +552,14 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
 			 (!!aconnector->base.state) ?
 			 aconnector->base.state->hdcp_content_type : -1);
 
-	mutex_lock(&hdcp_w->mutex);
+	guard(mutex)(&hdcp_w->mutex);
 
 	mod_hdcp_add_display(&hdcp_w->hdcp, link, display, &hdcp_w->output);
-
+	drm_connector_get(&aconnector->base);
+	if (hdcp_w->aconnector[conn_index])
+		drm_connector_put(&hdcp_w->aconnector[conn_index]->base);
+	hdcp_w->aconnector[conn_index] = aconnector;
 	process_output(hdcp_w);
-	mutex_unlock(&hdcp_w->mutex);
-
 }
 
 /**
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index c299cd94d3f7..cf2463090d3a 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -964,6 +964,10 @@ void drm_show_fdinfo(struct seq_file *m, struct file *f)
 	struct drm_file *file = f->private_data;
 	struct drm_device *dev = file->minor->dev;
 	struct drm_printer p = drm_seq_file_printer(m);
+	int idx;
+
+	if (!drm_dev_enter(dev, &idx))
+		return;
 
 	drm_printf(&p, "drm-driver:\t%s\n", dev->driver->name);
 	drm_printf(&p, "drm-client-id:\t%llu\n", file->client_id);
@@ -983,6 +987,8 @@ void drm_show_fdinfo(struct seq_file *m, struct file *f)
 
 	if (dev->driver->show_fdinfo)
 		dev->driver->show_fdinfo(&p, file);
+
+	drm_dev_exit(idx);
 }
 EXPORT_SYMBOL(drm_show_fdinfo);
 
diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 34bca7567576..3ea9f23b4f67 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -404,12 +404,16 @@ static void mipi_dbi_blank(struct mipi_dbi_dev *dbidev)
 	u16 height = drm->mode_config.min_height;
 	u16 width = drm->mode_config.min_width;
 	struct mipi_dbi *dbi = &dbidev->dbi;
-	size_t len = width * height * 2;
+	const struct drm_format_info *dst_format;
+	size_t len;
 	int idx;
 
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
+	dst_format = drm_format_info(dbidev->pixel_format);
+	len = drm_format_info_min_pitch(dst_format, 0, width) * height;
+
 	memset(dbidev->tx_buf, 0, len);
 
 	mipi_dbi_set_window_address(dbidev, 0, width - 1, 0, height - 1);
diff --git a/drivers/gpu/drm/i915/pxp/intel_pxp_gsccs.h b/drivers/gpu/drm/i915/pxp/intel_pxp_gsccs.h
index 9aae779c4da3..4969d3de2bac 100644
--- a/drivers/gpu/drm/i915/pxp/intel_pxp_gsccs.h
+++ b/drivers/gpu/drm/i915/pxp/intel_pxp_gsccs.h
@@ -23,6 +23,7 @@ int intel_pxp_gsccs_init(struct intel_pxp *pxp);
 
 int intel_pxp_gsccs_create_session(struct intel_pxp *pxp, int arb_session_id);
 void intel_pxp_gsccs_end_arb_fw_session(struct intel_pxp *pxp, u32 arb_session_id);
+bool intel_pxp_gsccs_is_ready_for_sessions(struct intel_pxp *pxp);
 
 #else
 static inline void intel_pxp_gsccs_fini(struct intel_pxp *pxp)
@@ -34,8 +35,11 @@ static inline int intel_pxp_gsccs_init(struct intel_pxp *pxp)
 	return 0;
 }
 
-#endif
+static inline bool intel_pxp_gsccs_is_ready_for_sessions(struct intel_pxp *pxp)
+{
+	return false;
+}
 
-bool intel_pxp_gsccs_is_ready_for_sessions(struct intel_pxp *pxp);
+#endif
 
 #endif /*__INTEL_PXP_GSCCS_H__ */
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index 7cc84472cece..edddfc036c6d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -90,7 +90,7 @@ nouveau_fence_context_kill(struct nouveau_fence_chan *fctx, int error)
 	while (!list_empty(&fctx->pending)) {
 		fence = list_entry(fctx->pending.next, typeof(*fence), head);
 
-		if (error)
+		if (error && !dma_fence_is_signaled_locked(&fence->base))
 			dma_fence_set_error(&fence->base, error);
 
 		if (nouveau_fence_signal(fence))
diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
index fd4215e2f982..925fbc2cda70 100644
--- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
+++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
@@ -216,6 +216,9 @@ static void drm_gem_shmem_test_get_pages_sgt(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt);
 	KUNIT_EXPECT_NULL(test, shmem->sgt);
 
+	ret = kunit_add_action_or_reset(test, kfree_wrapper, sgt);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	ret = kunit_add_action_or_reset(test, sg_free_table_wrapper, sgt);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
diff --git a/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h b/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
index a255946b6f77..8cfcd3360896 100644
--- a/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
+++ b/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
@@ -41,6 +41,7 @@
 
 #define GFX_OP_PIPE_CONTROL(len)	((0x3<<29)|(0x3<<27)|(0x2<<24)|((len)-2))
 
+#define	  PIPE_CONTROL0_L3_READ_ONLY_CACHE_INVALIDATE	BIT(10)	/* gen12 */
 #define	  PIPE_CONTROL0_HDC_PIPELINE_FLUSH		BIT(9)	/* gen12 */
 
 #define   PIPE_CONTROL_COMMAND_CACHE_INVALIDATE		(1<<29)
diff --git a/drivers/gpu/drm/xe/xe_guc_capture.c b/drivers/gpu/drm/xe/xe_guc_capture.c
index f6d523e4c5fe..9095618648bc 100644
--- a/drivers/gpu/drm/xe/xe_guc_capture.c
+++ b/drivers/gpu/drm/xe/xe_guc_capture.c
@@ -359,7 +359,7 @@ static void __fill_ext_reg(struct __guc_mmio_reg_descr *ext,
 
 	ext->reg = XE_REG(extlist->reg.__reg.addr);
 	ext->flags = FIELD_PREP(GUC_REGSET_STEERING_NEEDED, 1);
-	ext->flags = FIELD_PREP(GUC_REGSET_STEERING_GROUP, slice_id);
+	ext->flags |= FIELD_PREP(GUC_REGSET_STEERING_GROUP, slice_id);
 	ext->flags |= FIELD_PREP(GUC_REGSET_STEERING_INSTANCE, subslice_id);
 	ext->regname = extlist->name;
 }
diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c b/drivers/gpu/drm/xe/xe_ring_ops.c
index 9f327f27c072..8d1fb33d923f 100644
--- a/drivers/gpu/drm/xe/xe_ring_ops.c
+++ b/drivers/gpu/drm/xe/xe_ring_ops.c
@@ -141,7 +141,8 @@ emit_pipe_control(u32 *dw, int i, u32 bit_group_0, u32 bit_group_1, u32 offset,
 static int emit_pipe_invalidate(u32 mask_flags, bool invalidate_tlb, u32 *dw,
 				int i)
 {
-	u32 flags = PIPE_CONTROL_CS_STALL |
+	u32 flags0 = 0;
+	u32 flags1 = PIPE_CONTROL_CS_STALL |
 		PIPE_CONTROL_COMMAND_CACHE_INVALIDATE |
 		PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE |
 		PIPE_CONTROL_TEXTURE_CACHE_INVALIDATE |
@@ -152,11 +153,15 @@ static int emit_pipe_invalidate(u32 mask_flags, bool invalidate_tlb, u32 *dw,
 		PIPE_CONTROL_STORE_DATA_INDEX;
 
 	if (invalidate_tlb)
-		flags |= PIPE_CONTROL_TLB_INVALIDATE;
+		flags1 |= PIPE_CONTROL_TLB_INVALIDATE;
 
-	flags &= ~mask_flags;
+	flags1 &= ~mask_flags;
 
-	return emit_pipe_control(dw, i, 0, flags, LRC_PPHWSP_SCRATCH_ADDR, 0);
+	if (flags1 & PIPE_CONTROL_VF_CACHE_INVALIDATE)
+		flags0 |= PIPE_CONTROL0_L3_READ_ONLY_CACHE_INVALIDATE;
+
+	return emit_pipe_control(dw, i, flags0, flags1,
+				 LRC_PPHWSP_SCRATCH_ADDR, 0);
 }
 
 static int emit_store_imm_ppgtt_posted(u64 addr, u64 value,
diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 0d4b3935e687..342d47e67586 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -1380,9 +1380,9 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	return 0;
 
 rpm_disable:
-	pm_runtime_put(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index cb536d372b12..fb82f8035c0f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3677,6 +3677,14 @@ static int __init parse_ivrs_acpihid(char *str)
 	while (*uid == '0' && *(uid + 1))
 		uid++;
 
+	if (strlen(hid) >= ACPIHID_HID_LEN) {
+		pr_err("Invalid command line: hid is too long\n");
+		return 1;
+	} else if (strlen(uid) >= ACPIHID_UID_LEN) {
+		pr_err("Invalid command line: uid is too long\n");
+		return 1;
+	}
+
 	i = early_acpihid_map_size++;
 	memcpy(early_acpihid_map[i].hid, hid, strlen(hid));
 	memcpy(early_acpihid_map[i].uid, uid, strlen(uid));
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 9ba596430e7c..980cc6b33c43 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -411,6 +411,12 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 		return ERR_CAST(smmu_domain);
 	smmu_domain->domain.type = IOMMU_DOMAIN_SVA;
 	smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
+
+	/*
+	 * Choose page_size as the leaf page size for invalidation when
+	 * ARM_SMMU_FEAT_RANGE_INV is present
+	 */
+	smmu_domain->domain.pgsize_bitmap = PAGE_SIZE;
 	smmu_domain->smmu = smmu;
 
 	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 59749e8180af..e495334d1c43 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3364,6 +3364,7 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
 		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct rb_node *existing;
 		u32 sid = fwspec->ids[i];
 
 		new_stream->id = sid;
@@ -3374,10 +3375,20 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 			break;
 
 		/* Insert into SID tree */
-		if (rb_find_add(&new_stream->node, &smmu->streams,
-				arm_smmu_streams_cmp_node)) {
-			dev_warn(master->dev, "stream %u already in tree\n",
-				 sid);
+		existing = rb_find_add(&new_stream->node, &smmu->streams,
+				       arm_smmu_streams_cmp_node);
+		if (existing) {
+			struct arm_smmu_master *existing_master =
+				rb_entry(existing, struct arm_smmu_stream, node)
+					->master;
+
+			/* Bridged PCI devices may end up with duplicated IDs */
+			if (existing_master == master)
+				continue;
+
+			dev_warn(master->dev,
+				 "stream %u already in tree from dev %s\n", sid,
+				 dev_name(existing_master->dev));
 			ret = -EINVAL;
 			break;
 		}
@@ -4405,6 +4416,8 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
 	if (FIELD_GET(IDR3_RIL, reg))
 		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
+	if (FIELD_GET(IDR3_FWB, reg))
+		smmu->features |= ARM_SMMU_FEAT_S2FWB;
 
 	/* IDR5 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 76417bd5e926..07adf4ceeea0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4504,6 +4504,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e30, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e40, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e90, quirk_iommu_igfx);
 
+/* QM57/QS57 integrated gfx malfunctions with dmar */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_iommu_igfx);
+
 /* Broadwell igfx malfunctions with dmar */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1606, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x160B, quirk_iommu_igfx);
@@ -4581,7 +4584,6 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_calpella_no_shadow_gtt);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0062, quirk_calpella_no_shadow_gtt);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x006a, quirk_calpella_no_shadow_gtt);
 
diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index 7942d8eb3d00..f772deb9cba5 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -227,6 +227,9 @@ static int qcom_mpm_alloc(struct irq_domain *domain, unsigned int virq,
 	if (ret)
 		return ret;
 
+	if (pin == GPIO_NO_WAKE_IRQ)
+		return irq_domain_disconnect_hierarchy(domain, virq);
+
 	ret = irq_domain_set_hwirq_and_chip(domain, virq, pin,
 					    &qcom_mpm_chip, priv);
 	if (ret)
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index aab8240429b0..debc533a0365 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -68,6 +68,8 @@
 #define LIST_DIRTY	1
 #define LIST_SIZE	2
 
+#define SCAN_RESCHED_CYCLE	16
+
 /*--------------------------------------------------------------*/
 
 /*
@@ -2426,7 +2428,12 @@ static void __scan(struct dm_bufio_client *c)
 
 			atomic_long_dec(&c->need_shrink);
 			freed++;
-			cond_resched();
+
+			if (unlikely(freed % SCAN_RESCHED_CYCLE == 0)) {
+				dm_bufio_unlock(c);
+				cond_resched();
+				dm_bufio_lock(c);
+			}
 		}
 	}
 }
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 65ab609ac0cb..9947962e80f2 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -5176,7 +5176,7 @@ static void dm_integrity_dtr(struct dm_target *ti)
 	BUG_ON(!RB_EMPTY_ROOT(&ic->in_progress));
 	BUG_ON(!list_empty(&ic->wait_list));
 
-	if (ic->mode == 'B')
+	if (ic->mode == 'B' && ic->bitmap_flush_work.work.func)
 		cancel_delayed_work_sync(&ic->bitmap_flush_work);
 	if (ic->metadata_wq)
 		destroy_workqueue(ic->metadata_wq);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 0ef5203387b2..58febd1bc772 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -523,8 +523,9 @@ static char **realloc_argv(unsigned int *size, char **old_argv)
 		gfp = GFP_NOIO;
 	}
 	argv = kmalloc_array(new_size, sizeof(*argv), gfp);
-	if (argv && old_argv) {
-		memcpy(argv, old_argv, *size * sizeof(*argv));
+	if (argv) {
+		if (old_argv)
+			memcpy(argv, old_argv, *size * sizeof(*argv));
 		*size = new_size;
 	}
 
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index f73b84bae0c4..6ebb3d1eeb4d 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1112,26 +1112,26 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	num_irqs = platform_irq_count(pdev);
 	if (num_irqs < 0) {
 		ret = num_irqs;
-		goto eirq;
+		goto edisclk;
 	}
 
 	/* There must be at least one IRQ source */
 	if (!num_irqs) {
 		ret = -ENXIO;
-		goto eirq;
+		goto edisclk;
 	}
 
 	for (i = 0; i < num_irqs; i++) {
 		irq = platform_get_irq(pdev, i);
 		if (irq < 0) {
 			ret = irq;
-			goto eirq;
+			goto edisclk;
 		}
 
 		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
 				       dev_name(&pdev->dev), host);
 		if (ret)
-			goto eirq;
+			goto edisclk;
 	}
 
 	ret = tmio_mmc_host_probe(host);
@@ -1143,8 +1143,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 	return ret;
 
-eirq:
-	tmio_mmc_host_remove(host);
 edisclk:
 	renesas_sdhi_clk_disable(host);
 efree:
diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 940f1b71226d..7b35d24c38d7 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1543,7 +1543,7 @@ static void vsc9959_tas_clock_adjust(struct ocelot *ocelot)
 	struct tc_taprio_qopt_offload *taprio;
 	struct ocelot_port *ocelot_port;
 	struct timespec64 base_ts;
-	int port;
+	int i, port;
 	u32 val;
 
 	mutex_lock(&ocelot->fwd_domain_lock);
@@ -1575,6 +1575,9 @@ static void vsc9959_tas_clock_adjust(struct ocelot *ocelot)
 			   QSYS_PARAM_CFG_REG_3_BASE_TIME_SEC_MSB_M,
 			   QSYS_PARAM_CFG_REG_3);
 
+		for (i = 0; i < taprio->num_entries; i++)
+			vsc9959_tas_gcl_set(ocelot, i, &taprio->entries[i]);
+
 		ocelot_rmw(ocelot, QSYS_TAS_PARAM_CFG_CTRL_CONFIG_CHANGE,
 			   QSYS_TAS_PARAM_CFG_CTRL_CONFIG_CHANGE,
 			   QSYS_TAS_PARAM_CFG_CTRL);
diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index b76a9b7e0aed..889a18962270 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -172,34 +172,31 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
 	return padev;
 }
 
-int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
+void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
+			 struct pds_auxiliary_dev **pd_ptr)
 {
 	struct pds_auxiliary_dev *padev;
-	int err = 0;
 
-	if (!cf)
-		return -ENODEV;
+	if (!*pd_ptr)
+		return;
 
 	mutex_lock(&pf->config_lock);
 
-	padev = pf->vfs[cf->vf_id].padev;
-	if (padev) {
-		pds_client_unregister(pf, padev->client_id);
-		auxiliary_device_delete(&padev->aux_dev);
-		auxiliary_device_uninit(&padev->aux_dev);
-		padev->client_id = 0;
-	}
-	pf->vfs[cf->vf_id].padev = NULL;
+	padev = *pd_ptr;
+	pds_client_unregister(pf, padev->client_id);
+	auxiliary_device_delete(&padev->aux_dev);
+	auxiliary_device_uninit(&padev->aux_dev);
+	*pd_ptr = NULL;
 
 	mutex_unlock(&pf->config_lock);
-	return err;
 }
 
-int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
+int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
+			enum pds_core_vif_types vt,
+			struct pds_auxiliary_dev **pd_ptr)
 {
 	struct pds_auxiliary_dev *padev;
 	char devname[PDS_DEVNAME_LEN];
-	enum pds_core_vif_types vt;
 	unsigned long mask;
 	u16 vt_support;
 	int client_id;
@@ -208,6 +205,9 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
 	if (!cf)
 		return -ENODEV;
 
+	if (vt >= PDS_DEV_TYPE_MAX)
+		return -EINVAL;
+
 	mutex_lock(&pf->config_lock);
 
 	mask = BIT_ULL(PDSC_S_FW_DEAD) |
@@ -219,17 +219,10 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
 		goto out_unlock;
 	}
 
-	/* We only support vDPA so far, so it is the only one to
-	 * be verified that it is available in the Core device and
-	 * enabled in the devlink param.  In the future this might
-	 * become a loop for several VIF types.
-	 */
-
 	/* Verify that the type is supported and enabled.  It is not
 	 * an error if there is no auxbus device support for this
 	 * VF, it just means something else needs to happen with it.
 	 */
-	vt = PDS_DEV_TYPE_VDPA;
 	vt_support = !!le16_to_cpu(pf->dev_ident.vif_types[vt]);
 	if (!(vt_support &&
 	      pf->viftype_status[vt].supported &&
@@ -255,7 +248,7 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
 		err = PTR_ERR(padev);
 		goto out_unlock;
 	}
-	pf->vfs[cf->vf_id].padev = padev;
+	*pd_ptr = padev;
 
 out_unlock:
 	mutex_unlock(&pf->config_lock);
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index ec637dc4327a..becd3104473c 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -303,8 +303,11 @@ void pdsc_health_thread(struct work_struct *work);
 int pdsc_register_notify(struct notifier_block *nb);
 void pdsc_unregister_notify(struct notifier_block *nb);
 void pdsc_notify(unsigned long event, void *data);
-int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf);
-int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf);
+int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
+			enum pds_core_vif_types vt,
+			struct pds_auxiliary_dev **pd_ptr);
+void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
+			 struct pds_auxiliary_dev **pd_ptr);
 
 void pdsc_process_adminq(struct pdsc_qcq *qcq);
 void pdsc_work_thread(struct work_struct *work);
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index ca23cde385e6..d8dc39da4161 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -56,8 +56,11 @@ int pdsc_dl_enable_set(struct devlink *dl, u32 id,
 	for (vf_id = 0; vf_id < pdsc->num_vfs; vf_id++) {
 		struct pdsc *vf = pdsc->vfs[vf_id].vf;
 
-		err = ctx->val.vbool ? pdsc_auxbus_dev_add(vf, pdsc) :
-				       pdsc_auxbus_dev_del(vf, pdsc);
+		if (ctx->val.vbool)
+			err = pdsc_auxbus_dev_add(vf, pdsc, vt_entry->vif_id,
+						  &pdsc->vfs[vf_id].padev);
+		else
+			pdsc_auxbus_dev_del(vf, pdsc, &pdsc->vfs[vf_id].padev);
 	}
 
 	return err;
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 660268ff9562..a3a68889137b 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -190,7 +190,8 @@ static int pdsc_init_vf(struct pdsc *vf)
 	devl_unlock(dl);
 
 	pf->vfs[vf->vf_id].vf = vf;
-	err = pdsc_auxbus_dev_add(vf, pf);
+	err = pdsc_auxbus_dev_add(vf, pf, PDS_DEV_TYPE_VDPA,
+				  &pf->vfs[vf->vf_id].padev);
 	if (err) {
 		devl_lock(dl);
 		devl_unregister(dl);
@@ -417,7 +418,7 @@ static void pdsc_remove(struct pci_dev *pdev)
 
 		pf = pdsc_get_pf_struct(pdsc->pdev);
 		if (!IS_ERR(pf)) {
-			pdsc_auxbus_dev_del(pdsc, pf);
+			pdsc_auxbus_dev_del(pdsc, pf, &pf->vfs[pdsc->vf_id].padev);
 			pf->vfs[pdsc->vf_id].vf = NULL;
 		}
 	} else {
@@ -482,7 +483,8 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
 
 		pf = pdsc_get_pf_struct(pdsc->pdev);
 		if (!IS_ERR(pf))
-			pdsc_auxbus_dev_del(pdsc, pf);
+			pdsc_auxbus_dev_del(pdsc, pf,
+					    &pf->vfs[pdsc->vf_id].padev);
 	}
 
 	pdsc_unmap_bars(pdsc);
@@ -527,7 +529,8 @@ static void pdsc_reset_done(struct pci_dev *pdev)
 
 		pf = pdsc_get_pf_struct(pdsc->pdev);
 		if (!IS_ERR(pf))
-			pdsc_auxbus_dev_add(pdsc, pf);
+			pdsc_auxbus_dev_add(pdsc, pf, PDS_DEV_TYPE_VDPA,
+					    &pf->vfs[pdsc->vf_id].padev);
 	}
 }
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-desc.c b/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
index 230726d7b74f..d41b58fad37b 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-desc.c
@@ -373,8 +373,13 @@ static int xgbe_map_rx_buffer(struct xgbe_prv_data *pdata,
 	}
 
 	/* Set up the header page info */
-	xgbe_set_buffer_data(&rdata->rx.hdr, &ring->rx_hdr_pa,
-			     XGBE_SKB_ALLOC_SIZE);
+	if (pdata->netdev->features & NETIF_F_RXCSUM) {
+		xgbe_set_buffer_data(&rdata->rx.hdr, &ring->rx_hdr_pa,
+				     XGBE_SKB_ALLOC_SIZE);
+	} else {
+		xgbe_set_buffer_data(&rdata->rx.hdr, &ring->rx_hdr_pa,
+				     pdata->rx_buf_size);
+	}
 
 	/* Set up the buffer page info */
 	xgbe_set_buffer_data(&rdata->rx.buf, &ring->rx_buf_pa,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index f393228d41c7..f1b0fb02b3cd 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -320,6 +320,18 @@ static void xgbe_config_sph_mode(struct xgbe_prv_data *pdata)
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, HDSMS, XGBE_SPH_HDSMS_SIZE);
 }
 
+static void xgbe_disable_sph_mode(struct xgbe_prv_data *pdata)
+{
+	unsigned int i;
+
+	for (i = 0; i < pdata->channel_count; i++) {
+		if (!pdata->channel[i]->rx_ring)
+			break;
+
+		XGMAC_DMA_IOWRITE_BITS(pdata->channel[i], DMA_CH_CR, SPH, 0);
+	}
+}
+
 static int xgbe_write_rss_reg(struct xgbe_prv_data *pdata, unsigned int type,
 			      unsigned int index, unsigned int val)
 {
@@ -3545,8 +3557,12 @@ static int xgbe_init(struct xgbe_prv_data *pdata)
 	xgbe_config_tx_coalesce(pdata);
 	xgbe_config_rx_buffer_size(pdata);
 	xgbe_config_tso_mode(pdata);
-	xgbe_config_sph_mode(pdata);
-	xgbe_config_rss(pdata);
+
+	if (pdata->netdev->features & NETIF_F_RXCSUM) {
+		xgbe_config_sph_mode(pdata);
+		xgbe_config_rss(pdata);
+	}
+
 	desc_if->wrapper_tx_desc_init(pdata);
 	desc_if->wrapper_rx_desc_init(pdata);
 	xgbe_enable_dma_interrupts(pdata);
@@ -3702,5 +3718,9 @@ void xgbe_init_function_ptrs_dev(struct xgbe_hw_if *hw_if)
 	hw_if->disable_vxlan = xgbe_disable_vxlan;
 	hw_if->set_vxlan_id = xgbe_set_vxlan_id;
 
+	/* For Split Header*/
+	hw_if->enable_sph = xgbe_config_sph_mode;
+	hw_if->disable_sph = xgbe_disable_sph_mode;
+
 	DBGPR("<--xgbe_init_function_ptrs\n");
 }
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 5475867708f4..8bc49259d71a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -2257,10 +2257,17 @@ static int xgbe_set_features(struct net_device *netdev,
 	if (ret)
 		return ret;
 
-	if ((features & NETIF_F_RXCSUM) && !rxcsum)
+	if ((features & NETIF_F_RXCSUM) && !rxcsum) {
+		hw_if->enable_sph(pdata);
+		hw_if->enable_vxlan(pdata);
 		hw_if->enable_rx_csum(pdata);
-	else if (!(features & NETIF_F_RXCSUM) && rxcsum)
+		schedule_work(&pdata->restart_work);
+	} else if (!(features & NETIF_F_RXCSUM) && rxcsum) {
+		hw_if->disable_sph(pdata);
+		hw_if->disable_vxlan(pdata);
 		hw_if->disable_rx_csum(pdata);
+		schedule_work(&pdata->restart_work);
+	}
 
 	if ((features & NETIF_F_HW_VLAN_CTAG_RX) && !rxvlan)
 		hw_if->enable_rx_vlan_stripping(pdata);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index d85386cac8d1..ed5d43c16d0e 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -865,6 +865,10 @@ struct xgbe_hw_if {
 	void (*enable_vxlan)(struct xgbe_prv_data *);
 	void (*disable_vxlan)(struct xgbe_prv_data *);
 	void (*set_vxlan_id)(struct xgbe_prv_data *);
+
+	/* For Split Header */
+	void (*enable_sph)(struct xgbe_prv_data *pdata);
+	void (*disable_sph)(struct xgbe_prv_data *pdata);
 };
 
 /* This structure represents implementation specific routines for an
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1b39574e3fa2..bd8b9cb05ae9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2011,6 +2011,7 @@ static struct sk_buff *bnxt_rx_vlan(struct sk_buff *skb, u8 cmp_type,
 	}
 	return skb;
 vlan_err:
+	skb_mark_for_recycle(skb);
 	dev_kfree_skb(skb);
 	return NULL;
 }
@@ -3403,6 +3404,9 @@ static void bnxt_free_tx_skbs(struct bnxt *bp)
 		}
 		netdev_tx_reset_queue(netdev_get_tx_queue(bp->dev, i));
 	}
+
+	if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
+		bnxt_ptp_free_txts_skbs(bp->ptp_cfg);
 }
 
 static void bnxt_free_one_rx_ring(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
@@ -11376,6 +11380,9 @@ static void bnxt_init_napi(struct bnxt *bp)
 		poll_fn = bnxt_poll_p5;
 	else if (BNXT_CHIP_TYPE_NITRO_A0(bp))
 		cp_nr_rings--;
+
+	set_bit(BNXT_STATE_NAPI_DISABLED, &bp->state);
+
 	for (i = 0; i < cp_nr_rings; i++) {
 		bnapi = bp->bnapi[i];
 		netif_napi_add_config(bp->dev, &bnapi->napi, poll_fn,
@@ -12165,13 +12172,8 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 				set_bit(BNXT_STATE_ABORT_ERR, &bp->state);
 				return rc;
 			}
+			/* IRQ will be initialized later in bnxt_request_irq()*/
 			bnxt_clear_int_mode(bp);
-			rc = bnxt_init_int_mode(bp);
-			if (rc) {
-				clear_bit(BNXT_STATE_FW_RESET_DET, &bp->state);
-				netdev_err(bp->dev, "init int mode failed\n");
-				return rc;
-			}
 		}
 		rc = bnxt_cancel_reservations(bp, fw_reset);
 	}
@@ -12570,8 +12572,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	/* VF-reps may need to be re-opened after the PF is re-opened */
 	if (BNXT_PF(bp))
 		bnxt_vf_reps_open(bp);
-	if (bp->ptp_cfg && !(bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP))
-		WRITE_ONCE(bp->ptp_cfg->tx_avail, BNXT_MAX_TX_TS);
 	bnxt_ptp_init_rtc(bp, true);
 	bnxt_ptp_cfg_tstamp_filters(bp);
 	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
@@ -15731,8 +15731,8 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 
 	bnxt_rdma_aux_device_del(bp);
 
-	bnxt_ptp_clear(bp);
 	unregister_netdev(dev);
+	bnxt_ptp_clear(bp);
 
 	bnxt_rdma_aux_device_uninit(bp);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index 7236d8e548ab..a73398c4a3e9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -110,20 +110,30 @@ static int bnxt_hwrm_dbg_dma_data(struct bnxt *bp, void *msg,
 			}
 		}
 
+		if (cmn_req->req_type ==
+				cpu_to_le16(HWRM_DBG_COREDUMP_RETRIEVE))
+			info->dest_buf_size += len;
+
 		if (info->dest_buf) {
 			if ((info->seg_start + off + len) <=
 			    BNXT_COREDUMP_BUF_LEN(info->buf_len)) {
-				memcpy(info->dest_buf + off, dma_buf, len);
+				u16 copylen = min_t(u16, len,
+						    info->dest_buf_size - off);
+
+				memcpy(info->dest_buf + off, dma_buf, copylen);
+				if (copylen < len)
+					break;
 			} else {
 				rc = -ENOBUFS;
+				if (cmn_req->req_type ==
+				    cpu_to_le16(HWRM_DBG_COREDUMP_LIST)) {
+					kfree(info->dest_buf);
+					info->dest_buf = NULL;
+				}
 				break;
 			}
 		}
 
-		if (cmn_req->req_type ==
-				cpu_to_le16(HWRM_DBG_COREDUMP_RETRIEVE))
-			info->dest_buf_size += len;
-
 		if (!(cmn_resp->flags & HWRM_DBG_CMN_FLAGS_MORE))
 			break;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 9c5820839514..54208e049598 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2062,6 +2062,17 @@ static int bnxt_get_regs_len(struct net_device *dev)
 	return reg_len;
 }
 
+#define BNXT_PCIE_32B_ENTRY(start, end)			\
+	 { offsetof(struct pcie_ctx_hw_stats, start),	\
+	   offsetof(struct pcie_ctx_hw_stats, end) }
+
+static const struct {
+	u16 start;
+	u16 end;
+} bnxt_pcie_32b_entries[] = {
+	BNXT_PCIE_32B_ENTRY(pcie_ltssm_histogram[0], pcie_ltssm_histogram[3]),
+};
+
 static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 			  void *_p)
 {
@@ -2094,12 +2105,27 @@ static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 	req->pcie_stat_host_addr = cpu_to_le64(hw_pcie_stats_addr);
 	rc = hwrm_req_send(bp, req);
 	if (!rc) {
-		__le64 *src = (__le64 *)hw_pcie_stats;
-		u64 *dst = (u64 *)(_p + BNXT_PXP_REG_LEN);
-		int i;
-
-		for (i = 0; i < sizeof(*hw_pcie_stats) / sizeof(__le64); i++)
-			dst[i] = le64_to_cpu(src[i]);
+		u8 *dst = (u8 *)(_p + BNXT_PXP_REG_LEN);
+		u8 *src = (u8 *)hw_pcie_stats;
+		int i, j;
+
+		for (i = 0, j = 0; i < sizeof(*hw_pcie_stats); ) {
+			if (i >= bnxt_pcie_32b_entries[j].start &&
+			    i <= bnxt_pcie_32b_entries[j].end) {
+				u32 *dst32 = (u32 *)(dst + i);
+
+				*dst32 = le32_to_cpu(*(__le32 *)(src + i));
+				i += 4;
+				if (i > bnxt_pcie_32b_entries[j].end &&
+				    j < ARRAY_SIZE(bnxt_pcie_32b_entries) - 1)
+					j++;
+			} else {
+				u64 *dst64 = (u64 *)(dst + i);
+
+				*dst64 = le64_to_cpu(*(__le64 *)(src + i));
+				i += 8;
+			}
+		}
 	}
 	hwrm_req_drop(bp, req);
 }
@@ -4922,6 +4948,7 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 	if (!bp->num_tests || !BNXT_PF(bp))
 		return;
 
+	memset(buf, 0, sizeof(u64) * bp->num_tests);
 	if (etest->flags & ETH_TEST_FL_OFFLINE &&
 	    bnxt_ulp_registered(bp->edev)) {
 		etest->flags |= ETH_TEST_FL_FAILED;
@@ -4929,7 +4956,6 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 		return;
 	}
 
-	memset(buf, 0, sizeof(u64) * bp->num_tests);
 	if (!netif_running(dev)) {
 		etest->flags |= ETH_TEST_FL_FAILED;
 		return;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 2d4e19b96ee7..0669d43472f5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -794,6 +794,27 @@ static long bnxt_ptp_ts_aux_work(struct ptp_clock_info *ptp_info)
 	return HZ;
 }
 
+void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp)
+{
+	struct bnxt_ptp_tx_req *txts_req;
+	u16 cons = ptp->txts_cons;
+
+	/* make sure ptp aux worker finished with
+	 * possible BNXT_STATE_OPEN set
+	 */
+	ptp_cancel_worker_sync(ptp->ptp_clock);
+
+	ptp->tx_avail = BNXT_MAX_TX_TS;
+	while (cons != ptp->txts_prod) {
+		txts_req = &ptp->txts_req[cons];
+		if (!IS_ERR_OR_NULL(txts_req->tx_skb))
+			dev_kfree_skb_any(txts_req->tx_skb);
+		cons = NEXT_TXTS(cons);
+	}
+	ptp->txts_cons = cons;
+	ptp_schedule_worker(ptp->ptp_clock, 0);
+}
+
 int bnxt_ptp_get_txts_prod(struct bnxt_ptp_cfg *ptp, u16 *prod)
 {
 	spin_lock_bh(&ptp->ptp_tx_lock);
@@ -1105,7 +1126,6 @@ int bnxt_ptp_init(struct bnxt *bp)
 void bnxt_ptp_clear(struct bnxt *bp)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
-	int i;
 
 	if (!ptp)
 		return;
@@ -1117,12 +1137,5 @@ void bnxt_ptp_clear(struct bnxt *bp)
 	kfree(ptp->ptp_info.pin_config);
 	ptp->ptp_info.pin_config = NULL;
 
-	for (i = 0; i < BNXT_MAX_TX_TS; i++) {
-		if (ptp->txts_req[i].tx_skb) {
-			dev_kfree_skb_any(ptp->txts_req[i].tx_skb);
-			ptp->txts_req[i].tx_skb = NULL;
-		}
-	}
-
 	bnxt_unmap_ptp_regs(bp);
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index a95f05e9c579..0481161d26ef 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -162,6 +162,7 @@ int bnxt_ptp_cfg_tstamp_filters(struct bnxt *bp);
 void bnxt_ptp_reapply_pps(struct bnxt *bp);
 int bnxt_hwtstamp_set(struct net_device *dev, struct ifreq *ifr);
 int bnxt_hwtstamp_get(struct net_device *dev, struct ifreq *ifr);
+void bnxt_ptp_free_txts_skbs(struct bnxt_ptp_cfg *ptp);
 int bnxt_ptp_get_txts_prod(struct bnxt_ptp_cfg *ptp, u16 *prod);
 void bnxt_get_tx_ts_p5(struct bnxt *bp, struct sk_buff *skb, u16 prod);
 int bnxt_get_rx_ts_p5(struct bnxt *bp, u64 *ts, u32 pkt_ts);
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index d0ea92607870..6bf8a7aeef90 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -352,7 +352,7 @@ parse_eeprom (struct net_device *dev)
 	eth_hw_addr_set(dev, psrom->mac_addr);
 
 	if (np->chip_id == CHIP_IP1000A) {
-		np->led_mode = psrom->led_mode;
+		np->led_mode = le16_to_cpu(psrom->led_mode);
 		return 0;
 	}
 
diff --git a/drivers/net/ethernet/dlink/dl2k.h b/drivers/net/ethernet/dlink/dl2k.h
index 195dc6cfd895..0e33e2eaae96 100644
--- a/drivers/net/ethernet/dlink/dl2k.h
+++ b/drivers/net/ethernet/dlink/dl2k.h
@@ -335,7 +335,7 @@ typedef struct t_SROM {
 	u16 sub_system_id;	/* 0x06 */
 	u16 pci_base_1;		/* 0x08 (IP1000A only) */
 	u16 pci_base_2;		/* 0x0a (IP1000A only) */
-	u16 led_mode;		/* 0x0c (IP1000A only) */
+	__le16 led_mode;	/* 0x0c (IP1000A only) */
 	u16 reserved1[9];	/* 0x0e-0x1f */
 	u8 mac_addr[6];		/* 0x20-0x25 */
 	u8 reserved2[10];	/* 0x26-0x2f */
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f7c4ce8e9a26..c5d5fa8d7dfd 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -714,7 +714,12 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	writel(0, txq->bd.reg_desc_active);
+	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active))
+		writel(0, txq->bd.reg_desc_active);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 9bbece25552b..3d70c97a0bed 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -60,7 +60,7 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.name = "tm_qset",
 		.cmd = HNAE3_DBG_CMD_TM_QSET,
 		.dentry = HNS3_DBG_DENTRY_TM,
-		.buf_len = HNS3_DBG_READ_LEN,
+		.buf_len = HNS3_DBG_READ_LEN_1MB,
 		.init = hns3_dbg_common_file_init,
 	},
 	{
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 9ff797fb36c4..b03b8758c777 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -473,20 +473,14 @@ static void hns3_mask_vector_irq(struct hns3_enet_tqp_vector *tqp_vector,
 	writel(mask_en, tqp_vector->mask_addr);
 }
 
-static void hns3_vector_enable(struct hns3_enet_tqp_vector *tqp_vector)
+static void hns3_irq_enable(struct hns3_enet_tqp_vector *tqp_vector)
 {
 	napi_enable(&tqp_vector->napi);
 	enable_irq(tqp_vector->vector_irq);
-
-	/* enable vector */
-	hns3_mask_vector_irq(tqp_vector, 1);
 }
 
-static void hns3_vector_disable(struct hns3_enet_tqp_vector *tqp_vector)
+static void hns3_irq_disable(struct hns3_enet_tqp_vector *tqp_vector)
 {
-	/* disable vector */
-	hns3_mask_vector_irq(tqp_vector, 0);
-
 	disable_irq(tqp_vector->vector_irq);
 	napi_disable(&tqp_vector->napi);
 	cancel_work_sync(&tqp_vector->rx_group.dim.work);
@@ -707,11 +701,42 @@ static int hns3_set_rx_cpu_rmap(struct net_device *netdev)
 	return 0;
 }
 
+static void hns3_enable_irqs_and_tqps(struct net_device *netdev)
+{
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
+	struct hnae3_handle *h = priv->ae_handle;
+	u16 i;
+
+	for (i = 0; i < priv->vector_num; i++)
+		hns3_irq_enable(&priv->tqp_vector[i]);
+
+	for (i = 0; i < priv->vector_num; i++)
+		hns3_mask_vector_irq(&priv->tqp_vector[i], 1);
+
+	for (i = 0; i < h->kinfo.num_tqps; i++)
+		hns3_tqp_enable(h->kinfo.tqp[i]);
+}
+
+static void hns3_disable_irqs_and_tqps(struct net_device *netdev)
+{
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
+	struct hnae3_handle *h = priv->ae_handle;
+	u16 i;
+
+	for (i = 0; i < h->kinfo.num_tqps; i++)
+		hns3_tqp_disable(h->kinfo.tqp[i]);
+
+	for (i = 0; i < priv->vector_num; i++)
+		hns3_mask_vector_irq(&priv->tqp_vector[i], 0);
+
+	for (i = 0; i < priv->vector_num; i++)
+		hns3_irq_disable(&priv->tqp_vector[i]);
+}
+
 static int hns3_nic_net_up(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hnae3_handle *h = priv->ae_handle;
-	int i, j;
 	int ret;
 
 	ret = hns3_nic_reset_all_ring(h);
@@ -720,23 +745,13 @@ static int hns3_nic_net_up(struct net_device *netdev)
 
 	clear_bit(HNS3_NIC_STATE_DOWN, &priv->state);
 
-	/* enable the vectors */
-	for (i = 0; i < priv->vector_num; i++)
-		hns3_vector_enable(&priv->tqp_vector[i]);
-
-	/* enable rcb */
-	for (j = 0; j < h->kinfo.num_tqps; j++)
-		hns3_tqp_enable(h->kinfo.tqp[j]);
+	hns3_enable_irqs_and_tqps(netdev);
 
 	/* start the ae_dev */
 	ret = h->ae_algo->ops->start ? h->ae_algo->ops->start(h) : 0;
 	if (ret) {
 		set_bit(HNS3_NIC_STATE_DOWN, &priv->state);
-		while (j--)
-			hns3_tqp_disable(h->kinfo.tqp[j]);
-
-		for (j = i - 1; j >= 0; j--)
-			hns3_vector_disable(&priv->tqp_vector[j]);
+		hns3_disable_irqs_and_tqps(netdev);
 	}
 
 	return ret;
@@ -823,17 +838,9 @@ static void hns3_reset_tx_queue(struct hnae3_handle *h)
 static void hns3_nic_net_down(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
-	struct hnae3_handle *h = hns3_get_handle(netdev);
 	const struct hnae3_ae_ops *ops;
-	int i;
 
-	/* disable vectors */
-	for (i = 0; i < priv->vector_num; i++)
-		hns3_vector_disable(&priv->tqp_vector[i]);
-
-	/* disable rcb */
-	for (i = 0; i < h->kinfo.num_tqps; i++)
-		hns3_tqp_disable(h->kinfo.tqp[i]);
+	hns3_disable_irqs_and_tqps(netdev);
 
 	/* stop ae_dev */
 	ops = priv->ae_handle->ae_algo->ops;
@@ -5864,8 +5871,6 @@ int hns3_set_channels(struct net_device *netdev,
 void hns3_external_lb_prepare(struct net_device *ndev, bool if_running)
 {
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
-	struct hnae3_handle *h = priv->ae_handle;
-	int i;
 
 	if (!if_running)
 		return;
@@ -5876,11 +5881,7 @@ void hns3_external_lb_prepare(struct net_device *ndev, bool if_running)
 	netif_carrier_off(ndev);
 	netif_tx_disable(ndev);
 
-	for (i = 0; i < priv->vector_num; i++)
-		hns3_vector_disable(&priv->tqp_vector[i]);
-
-	for (i = 0; i < h->kinfo.num_tqps; i++)
-		hns3_tqp_disable(h->kinfo.tqp[i]);
+	hns3_disable_irqs_and_tqps(ndev);
 
 	/* delay ring buffer clearing to hns3_reset_notify_uninit_enet
 	 * during reset process, because driver may not be able
@@ -5896,7 +5897,6 @@ void hns3_external_lb_restore(struct net_device *ndev, bool if_running)
 {
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
 	struct hnae3_handle *h = priv->ae_handle;
-	int i;
 
 	if (!if_running)
 		return;
@@ -5912,11 +5912,7 @@ void hns3_external_lb_restore(struct net_device *ndev, bool if_running)
 
 	clear_bit(HNS3_NIC_STATE_DOWN, &priv->state);
 
-	for (i = 0; i < priv->vector_num; i++)
-		hns3_vector_enable(&priv->tqp_vector[i]);
-
-	for (i = 0; i < h->kinfo.num_tqps; i++)
-		hns3_tqp_enable(h->kinfo.tqp[i]);
+	hns3_enable_irqs_and_tqps(ndev);
 
 	netif_tx_wake_all_queues(ndev);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index 181af419b878..0ffda5146bae 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -439,6 +439,13 @@ static int hclge_ptp_create_clock(struct hclge_dev *hdev)
 	ptp->info.settime64 = hclge_ptp_settime;
 
 	ptp->info.n_alarm = 0;
+
+	spin_lock_init(&ptp->lock);
+	ptp->io_base = hdev->hw.hw.io_base + HCLGE_PTP_REG_OFFSET;
+	ptp->ts_cfg.rx_filter = HWTSTAMP_FILTER_NONE;
+	ptp->ts_cfg.tx_type = HWTSTAMP_TX_OFF;
+	hdev->ptp = ptp;
+
 	ptp->clock = ptp_clock_register(&ptp->info, &hdev->pdev->dev);
 	if (IS_ERR(ptp->clock)) {
 		dev_err(&hdev->pdev->dev,
@@ -450,12 +457,6 @@ static int hclge_ptp_create_clock(struct hclge_dev *hdev)
 		return -ENODEV;
 	}
 
-	spin_lock_init(&ptp->lock);
-	ptp->io_base = hdev->hw.hw.io_base + HCLGE_PTP_REG_OFFSET;
-	ptp->ts_cfg.rx_filter = HWTSTAMP_FILTER_NONE;
-	ptp->ts_cfg.tx_type = HWTSTAMP_TX_OFF;
-	hdev->ptp = ptp;
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 9ba767740a04..dada42e7e0ec 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1292,9 +1292,8 @@ static void hclgevf_sync_vlan_filter(struct hclgevf_dev *hdev)
 	rtnl_unlock();
 }
 
-static int hclgevf_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
+static int hclgevf_en_hw_strip_rxvtag_cmd(struct hclgevf_dev *hdev, bool enable)
 {
-	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	struct hclge_vf_to_pf_msg send_msg;
 
 	hclgevf_build_send_msg(&send_msg, HCLGE_MBX_SET_VLAN,
@@ -1303,6 +1302,19 @@ static int hclgevf_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
 	return hclgevf_send_mbx_msg(hdev, &send_msg, false, NULL, 0);
 }
 
+static int hclgevf_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
+{
+	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	int ret;
+
+	ret = hclgevf_en_hw_strip_rxvtag_cmd(hdev, enable);
+	if (ret)
+		return ret;
+
+	hdev->rxvtag_strip_en = enable;
+	return 0;
+}
+
 static int hclgevf_reset_tqp(struct hnae3_handle *handle)
 {
 #define HCLGEVF_RESET_ALL_QUEUE_DONE	1U
@@ -2204,12 +2216,13 @@ static int hclgevf_rss_init_hw(struct hclgevf_dev *hdev)
 					  tc_valid, tc_size);
 }
 
-static int hclgevf_init_vlan_config(struct hclgevf_dev *hdev)
+static int hclgevf_init_vlan_config(struct hclgevf_dev *hdev,
+				    bool rxvtag_strip_en)
 {
 	struct hnae3_handle *nic = &hdev->nic;
 	int ret;
 
-	ret = hclgevf_en_hw_strip_rxvtag(nic, true);
+	ret = hclgevf_en_hw_strip_rxvtag(nic, rxvtag_strip_en);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed to enable rx vlan offload, ret = %d\n", ret);
@@ -2879,7 +2892,7 @@ static int hclgevf_reset_hdev(struct hclgevf_dev *hdev)
 	if (ret)
 		return ret;
 
-	ret = hclgevf_init_vlan_config(hdev);
+	ret = hclgevf_init_vlan_config(hdev, hdev->rxvtag_strip_en);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed(%d) to initialize VLAN config\n", ret);
@@ -2994,7 +3007,7 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 		goto err_config;
 	}
 
-	ret = hclgevf_init_vlan_config(hdev);
+	ret = hclgevf_init_vlan_config(hdev, true);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed(%d) to initialize VLAN config\n", ret);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index cccef3228461..0208425ab594 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -253,6 +253,7 @@ struct hclgevf_dev {
 	int *vector_irq;
 
 	bool gro_en;
+	bool rxvtag_strip_en;
 
 	unsigned long vlan_del_fail_bmap[BITS_TO_LONGS(VLAN_N_VID)];
 
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 71e05d30f0fd..d7b90a77bb49 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1047,10 +1047,5 @@ static inline void ice_clear_rdma_cap(struct ice_pf *pf)
 	clear_bit(ICE_FLAG_RDMA_ENA, pf->flags);
 }
 
-static inline enum ice_phy_model ice_get_phy_model(const struct ice_hw *hw)
-{
-	return hw->ptp.phy_model;
-}
-
 extern const struct xdp_metadata_ops ice_xdp_md_ops;
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 1e801300310e..59df31c2c83f 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -186,7 +186,7 @@ static int ice_set_mac_type(struct ice_hw *hw)
  * ice_is_generic_mac - check if device's mac_type is generic
  * @hw: pointer to the hardware structure
  *
- * Return: true if mac_type is generic (with SBQ support), false if not
+ * Return: true if mac_type is ICE_MAC_GENERIC*, false otherwise.
  */
 bool ice_is_generic_mac(struct ice_hw *hw)
 {
@@ -194,120 +194,6 @@ bool ice_is_generic_mac(struct ice_hw *hw)
 		hw->mac_type == ICE_MAC_GENERIC_3K_E825);
 }
 
-/**
- * ice_is_e810
- * @hw: pointer to the hardware structure
- *
- * returns true if the device is E810 based, false if not.
- */
-bool ice_is_e810(struct ice_hw *hw)
-{
-	return hw->mac_type == ICE_MAC_E810;
-}
-
-/**
- * ice_is_e810t
- * @hw: pointer to the hardware structure
- *
- * returns true if the device is E810T based, false if not.
- */
-bool ice_is_e810t(struct ice_hw *hw)
-{
-	switch (hw->device_id) {
-	case ICE_DEV_ID_E810C_SFP:
-		switch (hw->subsystem_device_id) {
-		case ICE_SUBDEV_ID_E810T:
-		case ICE_SUBDEV_ID_E810T2:
-		case ICE_SUBDEV_ID_E810T3:
-		case ICE_SUBDEV_ID_E810T4:
-		case ICE_SUBDEV_ID_E810T6:
-		case ICE_SUBDEV_ID_E810T7:
-			return true;
-		}
-		break;
-	case ICE_DEV_ID_E810C_QSFP:
-		switch (hw->subsystem_device_id) {
-		case ICE_SUBDEV_ID_E810T2:
-		case ICE_SUBDEV_ID_E810T3:
-		case ICE_SUBDEV_ID_E810T5:
-			return true;
-		}
-		break;
-	default:
-		break;
-	}
-
-	return false;
-}
-
-/**
- * ice_is_e822 - Check if a device is E822 family device
- * @hw: pointer to the hardware structure
- *
- * Return: true if the device is E822 based, false if not.
- */
-bool ice_is_e822(struct ice_hw *hw)
-{
-	switch (hw->device_id) {
-	case ICE_DEV_ID_E822C_BACKPLANE:
-	case ICE_DEV_ID_E822C_QSFP:
-	case ICE_DEV_ID_E822C_SFP:
-	case ICE_DEV_ID_E822C_10G_BASE_T:
-	case ICE_DEV_ID_E822C_SGMII:
-	case ICE_DEV_ID_E822L_BACKPLANE:
-	case ICE_DEV_ID_E822L_SFP:
-	case ICE_DEV_ID_E822L_10G_BASE_T:
-	case ICE_DEV_ID_E822L_SGMII:
-		return true;
-	default:
-		return false;
-	}
-}
-
-/**
- * ice_is_e823
- * @hw: pointer to the hardware structure
- *
- * returns true if the device is E823-L or E823-C based, false if not.
- */
-bool ice_is_e823(struct ice_hw *hw)
-{
-	switch (hw->device_id) {
-	case ICE_DEV_ID_E823L_BACKPLANE:
-	case ICE_DEV_ID_E823L_SFP:
-	case ICE_DEV_ID_E823L_10G_BASE_T:
-	case ICE_DEV_ID_E823L_1GBE:
-	case ICE_DEV_ID_E823L_QSFP:
-	case ICE_DEV_ID_E823C_BACKPLANE:
-	case ICE_DEV_ID_E823C_QSFP:
-	case ICE_DEV_ID_E823C_SFP:
-	case ICE_DEV_ID_E823C_10G_BASE_T:
-	case ICE_DEV_ID_E823C_SGMII:
-		return true;
-	default:
-		return false;
-	}
-}
-
-/**
- * ice_is_e825c - Check if a device is E825C family device
- * @hw: pointer to the hardware structure
- *
- * Return: true if the device is E825-C based, false if not.
- */
-bool ice_is_e825c(struct ice_hw *hw)
-{
-	switch (hw->device_id) {
-	case ICE_DEV_ID_E825C_BACKPLANE:
-	case ICE_DEV_ID_E825C_QSFP:
-	case ICE_DEV_ID_E825C_SFP:
-	case ICE_DEV_ID_E825C_SGMII:
-		return true;
-	default:
-		return false;
-	}
-}
-
 /**
  * ice_is_pf_c827 - check if pf contains c827 phy
  * @hw: pointer to the hw struct
@@ -2409,7 +2295,7 @@ ice_parse_1588_func_caps(struct ice_hw *hw, struct ice_hw_func_caps *func_p,
 	info->tmr_index_owned = ((number & ICE_TS_TMR_IDX_OWND_M) != 0);
 	info->tmr_index_assoc = ((number & ICE_TS_TMR_IDX_ASSOC_M) != 0);
 
-	if (!ice_is_e825c(hw)) {
+	if (hw->mac_type != ICE_MAC_GENERIC_3K_E825) {
 		info->clk_freq = FIELD_GET(ICE_TS_CLK_FREQ_M, number);
 		info->clk_src = ((number & ICE_TS_CLK_SRC_M) != 0);
 	} else {
@@ -5765,6 +5651,96 @@ ice_aq_write_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
 	return ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
 }
 
+/**
+ * ice_get_pca9575_handle - find and return the PCA9575 controller
+ * @hw: pointer to the hw struct
+ * @pca9575_handle: GPIO controller's handle
+ *
+ * Find and return the GPIO controller's handle in the netlist.
+ * When found - the value will be cached in the hw structure and following calls
+ * will return cached value.
+ *
+ * Return: 0 on success, -ENXIO when there's no PCA9575 present.
+ */
+int ice_get_pca9575_handle(struct ice_hw *hw, u16 *pca9575_handle)
+{
+	struct ice_aqc_get_link_topo *cmd;
+	struct ice_aq_desc desc;
+	int err;
+	u8 idx;
+
+	/* If handle was read previously return cached value */
+	if (hw->io_expander_handle) {
+		*pca9575_handle = hw->io_expander_handle;
+		return 0;
+	}
+
+#define SW_PCA9575_SFP_TOPO_IDX		2
+#define SW_PCA9575_QSFP_TOPO_IDX	1
+
+	/* Check if the SW IO expander controlling SMA exists in the netlist. */
+	if (hw->device_id == ICE_DEV_ID_E810C_SFP)
+		idx = SW_PCA9575_SFP_TOPO_IDX;
+	else if (hw->device_id == ICE_DEV_ID_E810C_QSFP)
+		idx = SW_PCA9575_QSFP_TOPO_IDX;
+	else
+		return -ENXIO;
+
+	/* If handle was not detected read it from the netlist */
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_link_topo);
+	cmd = &desc.params.get_link_topo;
+	cmd->addr.topo_params.node_type_ctx =
+		ICE_AQC_LINK_TOPO_NODE_TYPE_GPIO_CTRL;
+	cmd->addr.topo_params.index = idx;
+
+	err = ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
+	if (err)
+		return -ENXIO;
+
+	/* Verify if we found the right IO expander type */
+	if (desc.params.get_link_topo.node_part_num !=
+	    ICE_AQC_GET_LINK_TOPO_NODE_NR_PCA9575)
+		return -ENXIO;
+
+	/* If present save the handle and return it */
+	hw->io_expander_handle =
+		le16_to_cpu(desc.params.get_link_topo.addr.handle);
+	*pca9575_handle = hw->io_expander_handle;
+
+	return 0;
+}
+
+/**
+ * ice_read_pca9575_reg - read the register from the PCA9575 controller
+ * @hw: pointer to the hw struct
+ * @offset: GPIO controller register offset
+ * @data: pointer to data to be read from the GPIO controller
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int ice_read_pca9575_reg(struct ice_hw *hw, u8 offset, u8 *data)
+{
+	struct ice_aqc_link_topo_addr link_topo;
+	__le16 addr;
+	u16 handle;
+	int err;
+
+	memset(&link_topo, 0, sizeof(link_topo));
+
+	err = ice_get_pca9575_handle(hw, &handle);
+	if (err)
+		return err;
+
+	link_topo.handle = cpu_to_le16(handle);
+	link_topo.topo_params.node_type_ctx =
+		FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_CTX_M,
+			   ICE_AQC_LINK_TOPO_NODE_CTX_PROVIDED);
+
+	addr = cpu_to_le16((u16)offset);
+
+	return ice_aq_read_i2c(hw, link_topo, 0, addr, 1, data, NULL);
+}
+
 /**
  * ice_aq_set_gpio
  * @hw: pointer to the hw struct
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 15ba38543738..9b00aa0ddf10 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -131,7 +131,6 @@ int
 ice_aq_manage_mac_write(struct ice_hw *hw, const u8 *mac_addr, u8 flags,
 			struct ice_sq_cd *cd);
 bool ice_is_generic_mac(struct ice_hw *hw);
-bool ice_is_e810(struct ice_hw *hw);
 int ice_clear_pf_cfg(struct ice_hw *hw);
 int
 ice_aq_set_phy_cfg(struct ice_hw *hw, struct ice_port_info *pi,
@@ -276,10 +275,6 @@ ice_stat_update40(struct ice_hw *hw, u32 reg, bool prev_stat_loaded,
 void
 ice_stat_update32(struct ice_hw *hw, u32 reg, bool prev_stat_loaded,
 		  u64 *prev_stat, u64 *cur_stat);
-bool ice_is_e810t(struct ice_hw *hw);
-bool ice_is_e822(struct ice_hw *hw);
-bool ice_is_e823(struct ice_hw *hw);
-bool ice_is_e825c(struct ice_hw *hw);
 int
 ice_sched_query_elem(struct ice_hw *hw, u32 node_teid,
 		     struct ice_aqc_txsched_elem_data *buf);
@@ -306,5 +301,7 @@ int
 ice_aq_write_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
 		 u16 bus_addr, __le16 addr, u8 params, const u8 *data,
 		 struct ice_sq_cd *cd);
+int ice_get_pca9575_handle(struct ice_hw *hw, u16 *pca9575_handle);
+int ice_read_pca9575_reg(struct ice_hw *hw, u8 offset, u8 *data);
 bool ice_fw_supports_report_dflt_cfg(struct ice_hw *hw);
 #endif /* _ICE_COMMON_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 03988be03729..59323c019544 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -2345,15 +2345,15 @@ ice_get_set_tx_topo(struct ice_hw *hw, u8 *buf, u16 buf_size,
 			cmd->set_flags |= ICE_AQC_TX_TOPO_FLAGS_SRC_RAM |
 					  ICE_AQC_TX_TOPO_FLAGS_LOAD_NEW;
 
-		if (ice_is_e825c(hw))
-			desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
+		desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
 	} else {
 		ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_tx_topo);
 		cmd->get_flags = ICE_AQC_TX_TOPO_GET_RAM;
-	}
 
-	if (!ice_is_e825c(hw))
-		desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
+		if (hw->mac_type == ICE_MAC_E810 ||
+		    hw->mac_type == ICE_MAC_GENERIC)
+			desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
+	}
 
 	status = ice_aq_send_cmd(hw, &desc, buf, buf_size, cd);
 	if (status)
diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index b2148dbe49b2..6b26290452d4 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -381,32 +381,23 @@ void ice_gnss_exit(struct ice_pf *pf)
 }
 
 /**
- * ice_gnss_is_gps_present - Check if GPS HW is present
+ * ice_gnss_is_module_present - Check if GNSS HW is present
  * @hw: pointer to HW struct
+ *
+ * Return: true when GNSS is present, false otherwise.
  */
-bool ice_gnss_is_gps_present(struct ice_hw *hw)
+bool ice_gnss_is_module_present(struct ice_hw *hw)
 {
-	if (!hw->func_caps.ts_func_info.src_tmr_owned)
-		return false;
+	int err;
+	u8 data;
 
-	if (!ice_is_gps_in_netlist(hw))
+	if (!hw->func_caps.ts_func_info.src_tmr_owned ||
+	    !ice_is_gps_in_netlist(hw))
 		return false;
 
-#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
-	if (ice_is_e810t(hw)) {
-		int err;
-		u8 data;
-
-		err = ice_read_pca9575_reg(hw, ICE_PCA9575_P0_IN, &data);
-		if (err || !!(data & ICE_P0_GNSS_PRSNT_N))
-			return false;
-	} else {
-		return false;
-	}
-#else
-	if (!ice_is_e810t(hw))
+	err = ice_read_pca9575_reg(hw, ICE_PCA9575_P0_IN, &data);
+	if (err || !!(data & ICE_P0_GNSS_PRSNT_N))
 		return false;
-#endif /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
 
 	return true;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.h b/drivers/net/ethernet/intel/ice/ice_gnss.h
index 75e567ad7059..15daf603ed7b 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.h
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.h
@@ -37,11 +37,11 @@ struct gnss_serial {
 #if IS_ENABLED(CONFIG_GNSS)
 void ice_gnss_init(struct ice_pf *pf);
 void ice_gnss_exit(struct ice_pf *pf);
-bool ice_gnss_is_gps_present(struct ice_hw *hw);
+bool ice_gnss_is_module_present(struct ice_hw *hw);
 #else
 static inline void ice_gnss_init(struct ice_pf *pf) { }
 static inline void ice_gnss_exit(struct ice_pf *pf) { }
-static inline bool ice_gnss_is_gps_present(struct ice_hw *hw)
+static inline bool ice_gnss_is_module_present(struct ice_hw *hw)
 {
 	return false;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d0faa087793d..e0785e820d60 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3882,7 +3882,7 @@ void ice_init_feature_support(struct ice_pf *pf)
 			ice_set_feature_support(pf, ICE_F_CGU);
 		if (ice_is_clock_mux_in_netlist(&pf->hw))
 			ice_set_feature_support(pf, ICE_F_SMA_CTRL);
-		if (ice_gnss_is_gps_present(&pf->hw))
+		if (ice_gnss_is_module_present(&pf->hw))
 			ice_set_feature_support(pf, ICE_F_GNSS);
 		break;
 	default:
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a99e0fbd0b8b..92ce419ff0bc 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1318,20 +1318,20 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
-	if (ice_is_e810(hw))
-		return 0;
-
 	mutex_lock(&ptp_port->ps_lock);
 
-	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_ETH56G:
-		err = ice_stop_phy_timer_eth56g(hw, port, true);
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
+		err = 0;
 		break;
-	case ICE_PHY_E82X:
+	case ICE_MAC_GENERIC:
 		kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
 
 		err = ice_stop_phy_timer_e82x(hw, port, true);
 		break;
+	case ICE_MAC_GENERIC_3K_E825:
+		err = ice_stop_phy_timer_eth56g(hw, port, true);
+		break;
 	default:
 		err = -ENODEV;
 	}
@@ -1361,19 +1361,16 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 	unsigned long flags;
 	int err;
 
-	if (ice_is_e810(hw))
-		return 0;
-
 	if (!ptp_port->link_up)
 		return ice_ptp_port_phy_stop(ptp_port);
 
 	mutex_lock(&ptp_port->ps_lock);
 
-	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_ETH56G:
-		err = ice_start_phy_timer_eth56g(hw, port);
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
+		err = 0;
 		break;
-	case ICE_PHY_E82X:
+	case ICE_MAC_GENERIC:
 		/* Start the PHY timer in Vernier mode */
 		kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
 
@@ -1398,6 +1395,9 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
 					   0);
 		break;
+	case ICE_MAC_GENERIC_3K_E825:
+		err = ice_start_phy_timer_eth56g(hw, port);
+		break;
 	default:
 		err = -ENODEV;
 	}
@@ -1432,12 +1432,13 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	/* Skip HW writes if reset is in progress */
 	if (pf->hw.reset_ongoing)
 		return;
-	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_E810:
+
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
 		/* Do not reconfigure E810 PHY */
 		return;
-	case ICE_PHY_ETH56G:
-	case ICE_PHY_E82X:
+	case ICE_MAC_GENERIC:
+	case ICE_MAC_GENERIC_3K_E825:
 		ice_ptp_port_phy_restart(ptp_port);
 		return;
 	default:
@@ -1465,46 +1466,44 @@ static int ice_ptp_cfg_phy_interrupt(struct ice_pf *pf, bool ena, u32 threshold)
 
 	ice_ptp_reset_ts_memory(hw);
 
-	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_ETH56G: {
-		int port;
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
+		return 0;
+	case ICE_MAC_GENERIC: {
+		int quad;
 
-		for (port = 0; port < hw->ptp.num_lports; port++) {
+		for (quad = 0; quad < ICE_GET_QUAD_NUM(hw->ptp.num_lports);
+		     quad++) {
 			int err;
 
-			err = ice_phy_cfg_intr_eth56g(hw, port, ena, threshold);
+			err = ice_phy_cfg_intr_e82x(hw, quad, ena, threshold);
 			if (err) {
-				dev_err(dev, "Failed to configure PHY interrupt for port %d, err %d\n",
-					port, err);
+				dev_err(dev, "Failed to configure PHY interrupt for quad %d, err %d\n",
+					quad, err);
 				return err;
 			}
 		}
 
 		return 0;
 	}
-	case ICE_PHY_E82X: {
-		int quad;
+	case ICE_MAC_GENERIC_3K_E825: {
+		int port;
 
-		for (quad = 0; quad < ICE_GET_QUAD_NUM(hw->ptp.num_lports);
-		     quad++) {
+		for (port = 0; port < hw->ptp.num_lports; port++) {
 			int err;
 
-			err = ice_phy_cfg_intr_e82x(hw, quad, ena, threshold);
+			err = ice_phy_cfg_intr_eth56g(hw, port, ena, threshold);
 			if (err) {
-				dev_err(dev, "Failed to configure PHY interrupt for quad %d, err %d\n",
-					quad, err);
+				dev_err(dev, "Failed to configure PHY interrupt for port %d, err %d\n",
+					port, err);
 				return err;
 			}
 		}
 
 		return 0;
 	}
-	case ICE_PHY_E810:
-		return 0;
-	case ICE_PHY_UNSUP:
+	case ICE_MAC_UNKNOWN:
 	default:
-		dev_warn(dev, "%s: Unexpected PHY model %d\n", __func__,
-			 ice_get_phy_model(hw));
 		return -EOPNOTSUPP;
 	}
 }
@@ -1740,7 +1739,7 @@ static int ice_ptp_write_perout(struct ice_hw *hw, unsigned int chan,
 	/* 0. Reset mode & out_en in AUX_OUT */
 	wr32(hw, GLTSYN_AUX_OUT(chan, tmr_idx), 0);
 
-	if (ice_is_e825c(hw)) {
+	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825) {
 		int err;
 
 		/* Enable/disable CGU 1PPS output for E825C */
@@ -1825,7 +1824,7 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 		return ice_ptp_write_perout(hw, rq->index, gpio_pin, 0, 0);
 
 	if (strncmp(pf->ptp.pin_desc[pin_desc_idx].name, "1PPS", 64) == 0 &&
-	    period != NSEC_PER_SEC && hw->ptp.phy_model == ICE_PHY_E82X) {
+	    period != NSEC_PER_SEC && hw->mac_type == ICE_MAC_GENERIC) {
 		dev_err(ice_pf_to_dev(pf), "1PPS pin supports only 1 s period\n");
 		return -EOPNOTSUPP;
 	}
@@ -2080,7 +2079,7 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	/* For Vernier mode on E82X, we need to recalibrate after new settime.
 	 * Start with marking timestamps as invalid.
 	 */
-	if (ice_get_phy_model(hw) == ICE_PHY_E82X) {
+	if (hw->mac_type == ICE_MAC_GENERIC) {
 		err = ice_ptp_clear_phy_offset_ready_e82x(hw);
 		if (err)
 			dev_warn(ice_pf_to_dev(pf), "Failed to mark timestamps as invalid before settime\n");
@@ -2104,7 +2103,7 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	ice_ptp_enable_all_perout(pf);
 
 	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
-	if (ice_get_phy_model(hw) == ICE_PHY_E82X)
+	if (hw->mac_type == ICE_MAC_GENERIC)
 		ice_ptp_restart_all_phy(pf);
 exit:
 	if (err) {
@@ -2558,7 +2557,7 @@ static void ice_ptp_set_funcs_e82x(struct ice_pf *pf)
 		pf->ptp.info.getcrosststamp = ice_ptp_getcrosststamp_e82x;
 
 #endif /* CONFIG_ICE_HWTS */
-	if (ice_is_e825c(&pf->hw)) {
+	if (pf->hw.mac_type == ICE_MAC_GENERIC_3K_E825) {
 		pf->ptp.ice_pin_desc = ice_pin_desc_e825c;
 		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e825c);
 	} else {
@@ -2646,10 +2645,17 @@ static void ice_ptp_set_caps(struct ice_pf *pf)
 	info->enable = ice_ptp_gpio_enable;
 	info->verify = ice_verify_pin;
 
-	if (ice_is_e810(&pf->hw))
+	switch (pf->hw.mac_type) {
+	case ICE_MAC_E810:
 		ice_ptp_set_funcs_e810(pf);
-	else
+		return;
+	case ICE_MAC_GENERIC:
+	case ICE_MAC_GENERIC_3K_E825:
 		ice_ptp_set_funcs_e82x(pf);
+		return;
+	default:
+		return;
+	}
 }
 
 /**
@@ -2779,7 +2785,7 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 	bool trigger_oicr = false;
 	unsigned int i;
 
-	if (ice_is_e810(hw))
+	if (!pf->ptp.port.tx.has_ready_bitmap)
 		return;
 
 	if (!ice_pf_src_tmr_owned(pf))
@@ -2914,14 +2920,12 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 	 */
 	ice_ptp_flush_all_tx_tracker(pf);
 
-	if (!ice_is_e810(hw)) {
-		/* Enable quad interrupts */
-		err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
-		if (err)
-			return err;
+	/* Enable quad interrupts */
+	err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
+	if (err)
+		return err;
 
-		ice_ptp_restart_all_phy(pf);
-	}
+	ice_ptp_restart_all_phy(pf);
 
 	/* Re-enable all periodic outputs and external timestamp events */
 	ice_ptp_enable_all_perout(pf);
@@ -2973,8 +2977,9 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 static bool ice_is_primary(struct ice_hw *hw)
 {
-	return ice_is_e825c(hw) && ice_is_dual(hw) ?
-		!!(hw->dev_caps.nac_topo.mode & ICE_NAC_TOPO_PRIMARY_M) : true;
+	return hw->mac_type == ICE_MAC_GENERIC_3K_E825 && ice_is_dual(hw) ?
+		       !!(hw->dev_caps.nac_topo.mode & ICE_NAC_TOPO_PRIMARY_M) :
+		       true;
 }
 
 static int ice_ptp_setup_adapter(struct ice_pf *pf)
@@ -2992,7 +2997,7 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
 	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
 	struct ice_ptp *ptp = &pf->ptp;
 
-	if (WARN_ON(!ctrl_ptp) || ice_get_phy_model(&pf->hw) == ICE_PHY_UNSUP)
+	if (WARN_ON(!ctrl_ptp) || pf->hw.mac_type == ICE_MAC_UNKNOWN)
 		return -ENODEV;
 
 	INIT_LIST_HEAD(&ptp->port.list_node);
@@ -3009,7 +3014,7 @@ static void ice_ptp_cleanup_pf(struct ice_pf *pf)
 {
 	struct ice_ptp *ptp = &pf->ptp;
 
-	if (ice_get_phy_model(&pf->hw) != ICE_PHY_UNSUP) {
+	if (pf->hw.mac_type != ICE_MAC_UNKNOWN) {
 		mutex_lock(&pf->adapter->ports.lock);
 		list_del(&ptp->port.list_node);
 		mutex_unlock(&pf->adapter->ports.lock);
@@ -3136,18 +3141,18 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 
 	mutex_init(&ptp_port->ps_lock);
 
-	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_ETH56G:
-		return ice_ptp_init_tx_eth56g(pf, &ptp_port->tx,
-					      ptp_port->port_num);
-	case ICE_PHY_E810:
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
 		return ice_ptp_init_tx_e810(pf, &ptp_port->tx);
-	case ICE_PHY_E82X:
+	case ICE_MAC_GENERIC:
 		kthread_init_delayed_work(&ptp_port->ov_work,
 					  ice_ptp_wait_for_offsets);
 
 		return ice_ptp_init_tx_e82x(pf, &ptp_port->tx,
 					    ptp_port->port_num);
+	case ICE_MAC_GENERIC_3K_E825:
+		return ice_ptp_init_tx_eth56g(pf, &ptp_port->tx,
+					      ptp_port->port_num);
 	default:
 		return -ENODEV;
 	}
@@ -3164,8 +3169,8 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
  */
 static void ice_ptp_init_tx_interrupt_mode(struct ice_pf *pf)
 {
-	switch (ice_get_phy_model(&pf->hw)) {
-	case ICE_PHY_E82X:
+	switch (pf->hw.mac_type) {
+	case ICE_MAC_GENERIC:
 		/* E822 based PHY has the clock owner process the interrupt
 		 * for all ports.
 		 */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index ec91822e9280..8475d422f1ec 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -746,7 +746,7 @@ static int ice_init_cgu_e82x(struct ice_hw *hw)
 	int err;
 
 	/* Disable sticky lock detection so lock err reported is accurate */
-	if (ice_is_e825c(hw))
+	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		err = ice_cfg_cgu_pll_dis_sticky_bits_e825c(hw);
 	else
 		err = ice_cfg_cgu_pll_dis_sticky_bits_e82x(hw);
@@ -756,7 +756,7 @@ static int ice_init_cgu_e82x(struct ice_hw *hw)
 	/* Configure the CGU PLL using the parameters from the function
 	 * capabilities.
 	 */
-	if (ice_is_e825c(hw))
+	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825)
 		err = ice_cfg_cgu_pll_e825c(hw, ts_info->time_ref,
 					    (enum ice_clk_src)ts_info->clk_src);
 	else
@@ -827,8 +827,8 @@ static u32 ice_ptp_tmr_cmd_to_port_reg(struct ice_hw *hw,
 	/* Certain hardware families share the same register values for the
 	 * port register and source timer register.
 	 */
-	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_E810:
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
 		return ice_ptp_tmr_cmd_to_src_reg(hw, cmd) & TS_CMD_MASK_E810;
 	default:
 		break;
@@ -2729,10 +2729,7 @@ static void ice_ptp_init_phy_e825(struct ice_hw *hw)
 {
 	struct ice_ptp_hw *ptp = &hw->ptp;
 	struct ice_eth56g_params *params;
-	u32 phy_rev;
-	int err;
 
-	ptp->phy_model = ICE_PHY_ETH56G;
 	params = &ptp->phy.eth56g;
 	params->onestep_ena = false;
 	params->peer_delay = 0;
@@ -2742,9 +2739,6 @@ static void ice_ptp_init_phy_e825(struct ice_hw *hw)
 	ptp->num_lports = params->num_phys * ptp->ports_per_phy;
 
 	ice_sb_access_ena_eth56g(hw, true);
-	err = ice_read_phy_eth56g(hw, hw->pf_id, PHY_REG_REVISION, &phy_rev);
-	if (err || phy_rev != PHY_REVISION_ETH56G)
-		ptp->phy_model = ICE_PHY_UNSUP;
 }
 
 /* E822 family functions
@@ -4792,7 +4786,6 @@ int ice_phy_cfg_intr_e82x(struct ice_hw *hw, u8 quad, bool ena, u8 threshold)
  */
 static void ice_ptp_init_phy_e82x(struct ice_ptp_hw *ptp)
 {
-	ptp->phy_model = ICE_PHY_E82X;
 	ptp->num_lports = 8;
 	ptp->ports_per_phy = 8;
 }
@@ -5315,68 +5308,6 @@ ice_get_phy_tx_tstamp_ready_e810(struct ice_hw *hw, u8 port, u64 *tstamp_ready)
  * to access the extended GPIOs available.
  */
 
-/**
- * ice_get_pca9575_handle
- * @hw: pointer to the hw struct
- * @pca9575_handle: GPIO controller's handle
- *
- * Find and return the GPIO controller's handle in the netlist.
- * When found - the value will be cached in the hw structure and following calls
- * will return cached value
- */
-static int
-ice_get_pca9575_handle(struct ice_hw *hw, u16 *pca9575_handle)
-{
-	struct ice_aqc_get_link_topo *cmd;
-	struct ice_aq_desc desc;
-	int status;
-	u8 idx;
-
-	/* If handle was read previously return cached value */
-	if (hw->io_expander_handle) {
-		*pca9575_handle = hw->io_expander_handle;
-		return 0;
-	}
-
-	/* If handle was not detected read it from the netlist */
-	cmd = &desc.params.get_link_topo;
-	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_link_topo);
-
-	/* Set node type to GPIO controller */
-	cmd->addr.topo_params.node_type_ctx =
-		(ICE_AQC_LINK_TOPO_NODE_TYPE_M &
-		 ICE_AQC_LINK_TOPO_NODE_TYPE_GPIO_CTRL);
-
-#define SW_PCA9575_SFP_TOPO_IDX		2
-#define SW_PCA9575_QSFP_TOPO_IDX	1
-
-	/* Check if the SW IO expander controlling SMA exists in the netlist. */
-	if (hw->device_id == ICE_DEV_ID_E810C_SFP)
-		idx = SW_PCA9575_SFP_TOPO_IDX;
-	else if (hw->device_id == ICE_DEV_ID_E810C_QSFP)
-		idx = SW_PCA9575_QSFP_TOPO_IDX;
-	else
-		return -EOPNOTSUPP;
-
-	cmd->addr.topo_params.index = idx;
-
-	status = ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
-	if (status)
-		return -EOPNOTSUPP;
-
-	/* Verify if we found the right IO expander type */
-	if (desc.params.get_link_topo.node_part_num !=
-		ICE_AQC_GET_LINK_TOPO_NODE_NR_PCA9575)
-		return -EOPNOTSUPP;
-
-	/* If present save the handle and return it */
-	hw->io_expander_handle =
-		le16_to_cpu(desc.params.get_link_topo.addr.handle);
-	*pca9575_handle = hw->io_expander_handle;
-
-	return 0;
-}
-
 /**
  * ice_read_sma_ctrl
  * @hw: pointer to the hw struct
@@ -5441,37 +5372,6 @@ int ice_write_sma_ctrl(struct ice_hw *hw, u8 data)
 	return status;
 }
 
-/**
- * ice_read_pca9575_reg
- * @hw: pointer to the hw struct
- * @offset: GPIO controller register offset
- * @data: pointer to data to be read from the GPIO controller
- *
- * Read the register from the GPIO controller
- */
-int ice_read_pca9575_reg(struct ice_hw *hw, u8 offset, u8 *data)
-{
-	struct ice_aqc_link_topo_addr link_topo;
-	__le16 addr;
-	u16 handle;
-	int err;
-
-	memset(&link_topo, 0, sizeof(link_topo));
-
-	err = ice_get_pca9575_handle(hw, &handle);
-	if (err)
-		return err;
-
-	link_topo.handle = cpu_to_le16(handle);
-	link_topo.topo_params.node_type_ctx =
-		FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_CTX_M,
-			   ICE_AQC_LINK_TOPO_NODE_CTX_PROVIDED);
-
-	addr = cpu_to_le16((u16)offset);
-
-	return ice_aq_read_i2c(hw, link_topo, 0, addr, 1, data, NULL);
-}
-
 /**
  * ice_ptp_read_sdp_ac - read SDP available connections section from NVM
  * @hw: pointer to the HW struct
@@ -5538,7 +5438,6 @@ int ice_ptp_read_sdp_ac(struct ice_hw *hw, __le16 *entries, uint *num_entries)
  */
 static void ice_ptp_init_phy_e810(struct ice_ptp_hw *ptp)
 {
-	ptp->phy_model = ICE_PHY_E810;
 	ptp->num_lports = 8;
 	ptp->ports_per_phy = 4;
 
@@ -5547,9 +5446,8 @@ static void ice_ptp_init_phy_e810(struct ice_ptp_hw *ptp)
 
 /* Device agnostic functions
  *
- * The following functions implement shared behavior common to both E822 and
- * E810 devices, possibly calling a device specific implementation where
- * necessary.
+ * The following functions implement shared behavior common to all devices,
+ * possibly calling a device specific implementation where necessary.
  */
 
 /**
@@ -5612,14 +5510,19 @@ void ice_ptp_init_hw(struct ice_hw *hw)
 {
 	struct ice_ptp_hw *ptp = &hw->ptp;
 
-	if (ice_is_e822(hw) || ice_is_e823(hw))
-		ice_ptp_init_phy_e82x(ptp);
-	else if (ice_is_e810(hw))
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
 		ice_ptp_init_phy_e810(ptp);
-	else if (ice_is_e825c(hw))
+		break;
+	case ICE_MAC_GENERIC:
+		ice_ptp_init_phy_e82x(ptp);
+		break;
+	case ICE_MAC_GENERIC_3K_E825:
 		ice_ptp_init_phy_e825(hw);
-	else
-		ptp->phy_model = ICE_PHY_UNSUP;
+		break;
+	default:
+		return;
+	}
 }
 
 /**
@@ -5640,11 +5543,11 @@ void ice_ptp_init_hw(struct ice_hw *hw)
 static int ice_ptp_write_port_cmd(struct ice_hw *hw, u8 port,
 				  enum ice_ptp_tmr_cmd cmd)
 {
-	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_ETH56G:
-		return ice_ptp_write_port_cmd_eth56g(hw, port, cmd);
-	case ICE_PHY_E82X:
+	switch (hw->mac_type) {
+	case ICE_MAC_GENERIC:
 		return ice_ptp_write_port_cmd_e82x(hw, port, cmd);
+	case ICE_MAC_GENERIC_3K_E825:
+		return ice_ptp_write_port_cmd_eth56g(hw, port, cmd);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -5705,8 +5608,8 @@ static int ice_ptp_port_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	u32 port;
 
 	/* PHY models which can program all ports simultaneously */
-	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_E810:
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
 		return ice_ptp_port_cmd_e810(hw, cmd);
 	default:
 		break;
@@ -5784,17 +5687,17 @@ int ice_ptp_init_time(struct ice_hw *hw, u64 time)
 
 	/* PHY timers */
 	/* Fill Rx and Tx ports and send msg to PHY */
-	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_ETH56G:
-		err = ice_ptp_prep_phy_time_eth56g(hw,
-						   (u32)(time & 0xFFFFFFFF));
-		break;
-	case ICE_PHY_E810:
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
 		err = ice_ptp_prep_phy_time_e810(hw, time & 0xFFFFFFFF);
 		break;
-	case ICE_PHY_E82X:
+	case ICE_MAC_GENERIC:
 		err = ice_ptp_prep_phy_time_e82x(hw, time & 0xFFFFFFFF);
 		break;
+	case ICE_MAC_GENERIC_3K_E825:
+		err = ice_ptp_prep_phy_time_eth56g(hw,
+						   (u32)(time & 0xFFFFFFFF));
+		break;
 	default:
 		err = -EOPNOTSUPP;
 	}
@@ -5830,16 +5733,16 @@ int ice_ptp_write_incval(struct ice_hw *hw, u64 incval)
 	wr32(hw, GLTSYN_SHADJ_L(tmr_idx), lower_32_bits(incval));
 	wr32(hw, GLTSYN_SHADJ_H(tmr_idx), upper_32_bits(incval));
 
-	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_ETH56G:
-		err = ice_ptp_prep_phy_incval_eth56g(hw, incval);
-		break;
-	case ICE_PHY_E810:
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
 		err = ice_ptp_prep_phy_incval_e810(hw, incval);
 		break;
-	case ICE_PHY_E82X:
+	case ICE_MAC_GENERIC:
 		err = ice_ptp_prep_phy_incval_e82x(hw, incval);
 		break;
+	case ICE_MAC_GENERIC_3K_E825:
+		err = ice_ptp_prep_phy_incval_eth56g(hw, incval);
+		break;
 	default:
 		err = -EOPNOTSUPP;
 	}
@@ -5899,16 +5802,16 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 	wr32(hw, GLTSYN_SHADJ_L(tmr_idx), 0);
 	wr32(hw, GLTSYN_SHADJ_H(tmr_idx), adj);
 
-	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_ETH56G:
-		err = ice_ptp_prep_phy_adj_eth56g(hw, adj);
-		break;
-	case ICE_PHY_E810:
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
 		err = ice_ptp_prep_phy_adj_e810(hw, adj);
 		break;
-	case ICE_PHY_E82X:
+	case ICE_MAC_GENERIC:
 		err = ice_ptp_prep_phy_adj_e82x(hw, adj);
 		break;
+	case ICE_MAC_GENERIC_3K_E825:
+		err = ice_ptp_prep_phy_adj_eth56g(hw, adj);
+		break;
 	default:
 		err = -EOPNOTSUPP;
 	}
@@ -5932,13 +5835,13 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
  */
 int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp)
 {
-	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_ETH56G:
-		return ice_read_ptp_tstamp_eth56g(hw, block, idx, tstamp);
-	case ICE_PHY_E810:
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
 		return ice_read_phy_tstamp_e810(hw, block, idx, tstamp);
-	case ICE_PHY_E82X:
+	case ICE_MAC_GENERIC:
 		return ice_read_phy_tstamp_e82x(hw, block, idx, tstamp);
+	case ICE_MAC_GENERIC_3K_E825:
+		return ice_read_ptp_tstamp_eth56g(hw, block, idx, tstamp);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -5962,13 +5865,13 @@ int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp)
  */
 int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx)
 {
-	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_ETH56G:
-		return ice_clear_ptp_tstamp_eth56g(hw, block, idx);
-	case ICE_PHY_E810:
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
 		return ice_clear_phy_tstamp_e810(hw, block, idx);
-	case ICE_PHY_E82X:
+	case ICE_MAC_GENERIC:
 		return ice_clear_phy_tstamp_e82x(hw, block, idx);
+	case ICE_MAC_GENERIC_3K_E825:
+		return ice_clear_ptp_tstamp_eth56g(hw, block, idx);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -6025,14 +5928,14 @@ static int ice_get_pf_c827_idx(struct ice_hw *hw, u8 *idx)
  */
 void ice_ptp_reset_ts_memory(struct ice_hw *hw)
 {
-	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_ETH56G:
-		ice_ptp_reset_ts_memory_eth56g(hw);
-		break;
-	case ICE_PHY_E82X:
+	switch (hw->mac_type) {
+	case ICE_MAC_GENERIC:
 		ice_ptp_reset_ts_memory_e82x(hw);
 		break;
-	case ICE_PHY_E810:
+	case ICE_MAC_GENERIC_3K_E825:
+		ice_ptp_reset_ts_memory_eth56g(hw);
+		break;
+	case ICE_MAC_E810:
 	default:
 		return;
 	}
@@ -6054,13 +5957,13 @@ int ice_ptp_init_phc(struct ice_hw *hw)
 	/* Clear event err indications for auxiliary pins */
 	(void)rd32(hw, GLTSYN_STAT(src_idx));
 
-	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_ETH56G:
-		return ice_ptp_init_phc_eth56g(hw);
-	case ICE_PHY_E810:
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
 		return ice_ptp_init_phc_e810(hw);
-	case ICE_PHY_E82X:
+	case ICE_MAC_GENERIC:
 		return ice_ptp_init_phc_e82x(hw);
+	case ICE_MAC_GENERIC_3K_E825:
+		return ice_ptp_init_phc_eth56g(hw);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -6079,16 +5982,16 @@ int ice_ptp_init_phc(struct ice_hw *hw)
  */
 int ice_get_phy_tx_tstamp_ready(struct ice_hw *hw, u8 block, u64 *tstamp_ready)
 {
-	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_ETH56G:
-		return ice_get_phy_tx_tstamp_ready_eth56g(hw, block,
-							  tstamp_ready);
-	case ICE_PHY_E810:
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
 		return ice_get_phy_tx_tstamp_ready_e810(hw, block,
 							tstamp_ready);
-	case ICE_PHY_E82X:
+	case ICE_MAC_GENERIC:
 		return ice_get_phy_tx_tstamp_ready_e82x(hw, block,
 							tstamp_ready);
+	case ICE_MAC_GENERIC_3K_E825:
+		return ice_get_phy_tx_tstamp_ready_eth56g(hw, block,
+							  tstamp_ready);
 		break;
 	default:
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 6779ce120515..6b4679407558 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -395,7 +395,6 @@ int ice_phy_cfg_intr_e82x(struct ice_hw *hw, u8 quad, bool ena, u8 threshold);
 /* E810 family functions */
 int ice_read_sma_ctrl(struct ice_hw *hw, u8 *data);
 int ice_write_sma_ctrl(struct ice_hw *hw, u8 data);
-int ice_read_pca9575_reg(struct ice_hw *hw, u8 offset, u8 *data);
 int ice_ptp_read_sdp_ac(struct ice_hw *hw, __le16 *entries, uint *num_entries);
 int ice_cgu_get_num_pins(struct ice_hw *hw, bool input);
 enum dpll_pin_type ice_cgu_get_pin_type(struct ice_hw *hw, u8 pin, bool input);
@@ -431,13 +430,13 @@ int ice_phy_cfg_ptp_1step_eth56g(struct ice_hw *hw, u8 port);
  */
 static inline u64 ice_get_base_incval(struct ice_hw *hw)
 {
-	switch (hw->ptp.phy_model) {
-	case ICE_PHY_ETH56G:
-		return ICE_ETH56G_NOMINAL_INCVAL;
-	case ICE_PHY_E810:
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
 		return ICE_PTP_NOMINAL_INCVAL_E810;
-	case ICE_PHY_E82X:
+	case ICE_MAC_GENERIC:
 		return ice_e82x_nominal_incval(ice_e82x_time_ref(hw));
+	case ICE_MAC_GENERIC_3K_E825:
+		return ICE_ETH56G_NOMINAL_INCVAL;
 	default:
 		return 0;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 33a1a5934c0d..0aab21113cc4 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -871,14 +871,6 @@ union ice_phy_params {
 	struct ice_eth56g_params eth56g;
 };
 
-/* PHY model */
-enum ice_phy_model {
-	ICE_PHY_UNSUP = -1,
-	ICE_PHY_E810 = 1,
-	ICE_PHY_E82X,
-	ICE_PHY_ETH56G,
-};
-
 /* Global Link Topology */
 enum ice_global_link_topo {
 	ICE_LINK_TOPO_UP_TO_2_LINKS,
@@ -888,7 +880,6 @@ enum ice_global_link_topo {
 };
 
 struct ice_ptp_hw {
-	enum ice_phy_model phy_model;
 	union ice_phy_params phy;
 	u8 num_lports;
 	u8 ports_per_phy;
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index 9be4bd717512..f90f545b3144 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -2097,6 +2097,11 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
 	pf = vf->pf;
 	dev = ice_pf_to_dev(pf);
 	vf_vsi = ice_get_vf_vsi(vf);
+	if (!vf_vsi) {
+		dev_err(dev, "Can not get FDIR vf_vsi for VF %u\n", vf->vf_id);
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto err_exit;
+	}
 
 #define ICE_VF_MAX_FDIR_FILTERS	128
 	if (!ice_fdir_num_avail_fltr(&pf->hw, vf_vsi) ||
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 66544faab710..aef0e9775a33 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -629,13 +629,13 @@ bool idpf_is_capability_ena(struct idpf_adapter *adapter, bool all,
 	VIRTCHNL2_CAP_RX_HSPLIT_AT_L4V4	|\
 	VIRTCHNL2_CAP_RX_HSPLIT_AT_L4V6)
 
-#define IDPF_CAP_RX_CSUM_L4V4 (\
-	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_TCP	|\
-	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_UDP)
+#define IDPF_CAP_TX_CSUM_L4V4 (\
+	VIRTCHNL2_CAP_TX_CSUM_L4_IPV4_TCP	|\
+	VIRTCHNL2_CAP_TX_CSUM_L4_IPV4_UDP)
 
-#define IDPF_CAP_RX_CSUM_L4V6 (\
-	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_TCP	|\
-	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_UDP)
+#define IDPF_CAP_TX_CSUM_L4V6 (\
+	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_TCP	|\
+	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_UDP)
 
 #define IDPF_CAP_RX_CSUM (\
 	VIRTCHNL2_CAP_RX_CSUM_L3_IPV4		|\
@@ -644,11 +644,9 @@ bool idpf_is_capability_ena(struct idpf_adapter *adapter, bool all,
 	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_TCP	|\
 	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_UDP)
 
-#define IDPF_CAP_SCTP_CSUM (\
+#define IDPF_CAP_TX_SCTP_CSUM (\
 	VIRTCHNL2_CAP_TX_CSUM_L4_IPV4_SCTP	|\
-	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_SCTP	|\
-	VIRTCHNL2_CAP_RX_CSUM_L4_IPV4_SCTP	|\
-	VIRTCHNL2_CAP_RX_CSUM_L4_IPV6_SCTP)
+	VIRTCHNL2_CAP_TX_CSUM_L4_IPV6_SCTP)
 
 #define IDPF_CAP_TUNNEL_TX_CSUM (\
 	VIRTCHNL2_CAP_TX_CSUM_L3_SINGLE_TUNNEL	|\
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index a055a47449f1..6e8a82dae162 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -703,8 +703,10 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
 	struct idpf_vport_config *vport_config;
+	netdev_features_t other_offloads = 0;
+	netdev_features_t csum_offloads = 0;
+	netdev_features_t tso_offloads = 0;
 	netdev_features_t dflt_features;
-	netdev_features_t offloads = 0;
 	struct idpf_netdev_priv *np;
 	struct net_device *netdev;
 	u16 idx = vport->idx;
@@ -766,53 +768,32 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 
 	if (idpf_is_cap_ena_all(adapter, IDPF_RSS_CAPS, IDPF_CAP_RSS))
 		dflt_features |= NETIF_F_RXHASH;
-	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_RX_CSUM_L4V4))
-		dflt_features |= NETIF_F_IP_CSUM;
-	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_RX_CSUM_L4V6))
-		dflt_features |= NETIF_F_IPV6_CSUM;
+	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_TX_CSUM_L4V4))
+		csum_offloads |= NETIF_F_IP_CSUM;
+	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_TX_CSUM_L4V6))
+		csum_offloads |= NETIF_F_IPV6_CSUM;
 	if (idpf_is_cap_ena(adapter, IDPF_CSUM_CAPS, IDPF_CAP_RX_CSUM))
-		dflt_features |= NETIF_F_RXCSUM;
-	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_SCTP_CSUM))
-		dflt_features |= NETIF_F_SCTP_CRC;
+		csum_offloads |= NETIF_F_RXCSUM;
+	if (idpf_is_cap_ena_all(adapter, IDPF_CSUM_CAPS, IDPF_CAP_TX_SCTP_CSUM))
+		csum_offloads |= NETIF_F_SCTP_CRC;
 
 	if (idpf_is_cap_ena(adapter, IDPF_SEG_CAPS, VIRTCHNL2_CAP_SEG_IPV4_TCP))
-		dflt_features |= NETIF_F_TSO;
+		tso_offloads |= NETIF_F_TSO;
 	if (idpf_is_cap_ena(adapter, IDPF_SEG_CAPS, VIRTCHNL2_CAP_SEG_IPV6_TCP))
-		dflt_features |= NETIF_F_TSO6;
+		tso_offloads |= NETIF_F_TSO6;
 	if (idpf_is_cap_ena_all(adapter, IDPF_SEG_CAPS,
 				VIRTCHNL2_CAP_SEG_IPV4_UDP |
 				VIRTCHNL2_CAP_SEG_IPV6_UDP))
-		dflt_features |= NETIF_F_GSO_UDP_L4;
+		tso_offloads |= NETIF_F_GSO_UDP_L4;
 	if (idpf_is_cap_ena_all(adapter, IDPF_RSC_CAPS, IDPF_CAP_RSC))
-		offloads |= NETIF_F_GRO_HW;
-	/* advertise to stack only if offloads for encapsulated packets is
-	 * supported
-	 */
-	if (idpf_is_cap_ena(vport->adapter, IDPF_SEG_CAPS,
-			    VIRTCHNL2_CAP_SEG_TX_SINGLE_TUNNEL)) {
-		offloads |= NETIF_F_GSO_UDP_TUNNEL	|
-			    NETIF_F_GSO_GRE		|
-			    NETIF_F_GSO_GRE_CSUM	|
-			    NETIF_F_GSO_PARTIAL		|
-			    NETIF_F_GSO_UDP_TUNNEL_CSUM	|
-			    NETIF_F_GSO_IPXIP4		|
-			    NETIF_F_GSO_IPXIP6		|
-			    0;
-
-		if (!idpf_is_cap_ena_all(vport->adapter, IDPF_CSUM_CAPS,
-					 IDPF_CAP_TUNNEL_TX_CSUM))
-			netdev->gso_partial_features |=
-				NETIF_F_GSO_UDP_TUNNEL_CSUM;
-
-		netdev->gso_partial_features |= NETIF_F_GSO_GRE_CSUM;
-		offloads |= NETIF_F_TSO_MANGLEID;
-	}
+		other_offloads |= NETIF_F_GRO_HW;
 	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_LOOPBACK))
-		offloads |= NETIF_F_LOOPBACK;
+		other_offloads |= NETIF_F_LOOPBACK;
 
-	netdev->features |= dflt_features;
-	netdev->hw_features |= dflt_features | offloads;
-	netdev->hw_enc_features |= dflt_features | offloads;
+	netdev->features |= dflt_features | csum_offloads | tso_offloads;
+	netdev->hw_features |=  netdev->features | other_offloads;
+	netdev->vlan_features |= netdev->features | other_offloads;
+	netdev->hw_enc_features |= dflt_features | other_offloads;
 	idpf_set_ethtool_ops(netdev);
 	SET_NETDEV_DEV(netdev, &adapter->pdev->dev);
 
@@ -1131,11 +1112,9 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 
 	num_max_q = max(max_q->max_txq, max_q->max_rxq);
 	vport->q_vector_idxs = kcalloc(num_max_q, sizeof(u16), GFP_KERNEL);
-	if (!vport->q_vector_idxs) {
-		kfree(vport);
+	if (!vport->q_vector_idxs)
+		goto free_vport;
 
-		return NULL;
-	}
 	idpf_vport_init(vport, max_q);
 
 	/* This alloc is done separate from the LUT because it's not strictly
@@ -1145,11 +1124,9 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	 */
 	rss_data = &adapter->vport_config[idx]->user_config.rss_data;
 	rss_data->rss_key = kzalloc(rss_data->rss_key_size, GFP_KERNEL);
-	if (!rss_data->rss_key) {
-		kfree(vport);
+	if (!rss_data->rss_key)
+		goto free_vector_idxs;
 
-		return NULL;
-	}
 	/* Initialize default rss key */
 	netdev_rss_key_fill((void *)rss_data->rss_key, rss_data->rss_key_size);
 
@@ -1162,6 +1139,13 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	adapter->next_vport = idpf_get_free_slot(adapter);
 
 	return vport;
+
+free_vector_idxs:
+	kfree(vport->q_vector_idxs);
+free_vport:
+	kfree(vport);
+
+	return NULL;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index bec4a02c5373..b35713036a54 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -89,6 +89,7 @@ static void idpf_shutdown(struct pci_dev *pdev)
 {
 	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
 
+	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->vc_event_task);
 	idpf_vc_core_deinit(adapter);
 	idpf_deinit_dflt_mbx(adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 612ed26a29c5..efc7b30e4211 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -1290,6 +1290,8 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 	/* reset the tstamp_config */
 	igc_ptp_set_timestamp_mode(adapter, &adapter->tstamp_config);
 
+	mutex_lock(&adapter->ptm_lock);
+
 	spin_lock_irqsave(&adapter->tmreg_lock, flags);
 
 	switch (adapter->hw.mac.type) {
@@ -1308,7 +1310,6 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 		if (!igc_is_crosststamp_supported(adapter))
 			break;
 
-		mutex_lock(&adapter->ptm_lock);
 		wr32(IGC_PCIE_DIG_DELAY, IGC_PCIE_DIG_DELAY_DEFAULT);
 		wr32(IGC_PCIE_PHY_DELAY, IGC_PCIE_PHY_DELAY_DEFAULT);
 
@@ -1332,7 +1333,6 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 			netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
 
 		igc_ptm_reset(hw);
-		mutex_unlock(&adapter->ptm_lock);
 		break;
 	default:
 		/* No work to do. */
@@ -1349,5 +1349,7 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 out:
 	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
 
+	mutex_unlock(&adapter->ptm_lock);
+
 	wrfl();
 }
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 0a679e95196f..24499bb36c00 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -1223,7 +1223,7 @@ static void octep_hb_timeout_task(struct work_struct *work)
 		miss_cnt);
 	rtnl_lock();
 	if (netif_running(oct->netdev))
-		octep_stop(oct->netdev);
+		dev_close(oct->netdev);
 	rtnl_unlock();
 }
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 18c922dd5fc6..ccb69bc5c952 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -835,7 +835,9 @@ static void octep_vf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	struct octep_vf_device *oct = netdev_priv(netdev);
 
 	netdev_hold(netdev, NULL, GFP_ATOMIC);
-	schedule_work(&oct->tx_timeout_task);
+	if (!schedule_work(&oct->tx_timeout_task))
+		netdev_put(netdev, NULL);
+
 }
 
 static int octep_vf_set_mac(struct net_device *netdev, void *p)
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 477b8732b860..c6d60f1d4f77 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -269,12 +269,8 @@ static const char * const mtk_clks_source_name[] = {
 	"ethwarp_wocpu2",
 	"ethwarp_wocpu1",
 	"ethwarp_wocpu0",
-	"top_usxgmii0_sel",
-	"top_usxgmii1_sel",
 	"top_sgm0_sel",
 	"top_sgm1_sel",
-	"top_xfi_phy0_xtal_sel",
-	"top_xfi_phy1_xtal_sel",
 	"top_eth_gmii_sel",
 	"top_eth_refck_50m_sel",
 	"top_eth_sys_200m_sel",
@@ -2206,14 +2202,18 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		ring->data[idx] = new_data;
 		rxd->rxd1 = (unsigned int)dma_addr;
 release_desc:
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA)) {
+			if (unlikely(dma_addr == DMA_MAPPING_ERROR))
+				addr64 = FIELD_GET(RX_DMA_ADDR64_MASK,
+						   rxd->rxd2);
+			else
+				addr64 = RX_DMA_PREP_ADDR64(dma_addr);
+		}
+
 		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
 			rxd->rxd2 = RX_DMA_LSO;
 		else
-			rxd->rxd2 = RX_DMA_PREP_PLEN0(ring->buf_size);
-
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA) &&
-		    likely(dma_addr != DMA_MAPPING_ERROR))
-			rxd->rxd2 |= RX_DMA_PREP_ADDR64(dma_addr);
+			rxd->rxd2 = RX_DMA_PREP_PLEN0(ring->buf_size) | addr64;
 
 		ring->calc_idx = idx;
 		done++;
diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 25989c79c92e..c2ab87828d85 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1163,6 +1163,7 @@ static int mtk_star_tx_poll(struct napi_struct *napi, int budget)
 	struct net_device *ndev = priv->ndev;
 	unsigned int head = ring->head;
 	unsigned int entry = ring->tail;
+	unsigned long flags;
 
 	while (entry != head && count < (MTK_STAR_RING_NUM_DESCS - 1)) {
 		ret = mtk_star_tx_complete_one(priv);
@@ -1182,9 +1183,9 @@ static int mtk_star_tx_poll(struct napi_struct *napi, int budget)
 		netif_wake_queue(ndev);
 
 	if (napi_complete(napi)) {
-		spin_lock(&priv->lock);
+		spin_lock_irqsave(&priv->lock, flags);
 		mtk_star_enable_dma_irq(priv, false, true);
-		spin_unlock(&priv->lock);
+		spin_unlock_irqrestore(&priv->lock, flags);
 	}
 
 	return 0;
@@ -1341,16 +1342,16 @@ static int mtk_star_rx(struct mtk_star_priv *priv, int budget)
 static int mtk_star_rx_poll(struct napi_struct *napi, int budget)
 {
 	struct mtk_star_priv *priv;
+	unsigned long flags;
 	int work_done = 0;
 
 	priv = container_of(napi, struct mtk_star_priv, rx_napi);
 
 	work_done = mtk_star_rx(priv, budget);
-	if (work_done < budget) {
-		napi_complete_done(napi, work_done);
-		spin_lock(&priv->lock);
+	if (work_done < budget && napi_complete_done(napi, work_done)) {
+		spin_lock_irqsave(&priv->lock, flags);
 		mtk_star_enable_dma_irq(priv, true, false);
-		spin_unlock(&priv->lock);
+		spin_unlock_irqrestore(&priv->lock, flags);
 	}
 
 	return work_done;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 09433b91be17..c8adf309ecad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -177,6 +177,7 @@ static int mlx5e_tx_reporter_ptpsq_unhealthy_recover(void *ctx)
 
 	priv = ptpsq->txqsq.priv;
 
+	rtnl_lock();
 	mutex_lock(&priv->state_lock);
 	chs = &priv->channels;
 	netdev = priv->netdev;
@@ -184,22 +185,19 @@ static int mlx5e_tx_reporter_ptpsq_unhealthy_recover(void *ctx)
 	carrier_ok = netif_carrier_ok(netdev);
 	netif_carrier_off(netdev);
 
-	rtnl_lock();
 	mlx5e_deactivate_priv_channels(priv);
-	rtnl_unlock();
 
 	mlx5e_ptp_close(chs->ptp);
 	err = mlx5e_ptp_open(priv, &chs->params, chs->c[0]->lag_port, &chs->ptp);
 
-	rtnl_lock();
 	mlx5e_activate_priv_channels(priv);
-	rtnl_unlock();
 
 	/* return carrier back if needed */
 	if (carrier_ok)
 		netif_carrier_on(netdev);
 
 	mutex_unlock(&priv->state_lock);
+	rtnl_unlock();
 
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
index e4e487c8431b..b9cf79e27124 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
@@ -165,9 +165,6 @@ static int mlx5e_tc_tun_parse_vxlan(struct mlx5e_priv *priv,
 	struct flow_match_enc_keyid enc_keyid;
 	void *misc_c, *misc_v;
 
-	misc_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, misc_parameters);
-	misc_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, misc_parameters);
-
 	if (!flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ENC_KEYID))
 		return 0;
 
@@ -182,6 +179,30 @@ static int mlx5e_tc_tun_parse_vxlan(struct mlx5e_priv *priv,
 		err = mlx5e_tc_tun_parse_vxlan_gbp_option(priv, spec, f);
 		if (err)
 			return err;
+
+		/* We can't mix custom tunnel headers with symbolic ones and we
+		 * don't have a symbolic field name for GBP, so we use custom
+		 * tunnel headers in this case. We need hardware support to
+		 * match on custom tunnel headers, but we already know it's
+		 * supported because the previous call successfully checked for
+		 * that.
+		 */
+		misc_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
+				      misc_parameters_5);
+		misc_v = MLX5_ADDR_OF(fte_match_param, spec->match_value,
+				      misc_parameters_5);
+
+		/* Shift by 8 to account for the reserved bits in the vxlan
+		 * header after the VNI.
+		 */
+		MLX5_SET(fte_match_set_misc5, misc_c, tunnel_header_1,
+			 be32_to_cpu(enc_keyid.mask->keyid) << 8);
+		MLX5_SET(fte_match_set_misc5, misc_v, tunnel_header_1,
+			 be32_to_cpu(enc_keyid.key->keyid) << 8);
+
+		spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS_5;
+
+		return 0;
 	}
 
 	/* match on VNI is required */
@@ -195,6 +216,11 @@ static int mlx5e_tc_tun_parse_vxlan(struct mlx5e_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
+	misc_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
+			      misc_parameters);
+	misc_v = MLX5_ADDR_OF(fte_match_param, spec->match_value,
+			      misc_parameters);
+
 	MLX5_SET(fte_match_set_misc, misc_c, vxlan_vni,
 		 be32_to_cpu(enc_keyid.mask->keyid));
 	MLX5_SET(fte_match_set_misc, misc_v, vxlan_vni,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 9ba99609999f..f1d908f61134 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1750,9 +1750,6 @@ extra_split_attr_dests_needed(struct mlx5e_tc_flow *flow, struct mlx5_flow_attr
 	    !list_is_first(&attr->list, &flow->attrs))
 		return 0;
 
-	if (flow_flag_test(flow, SLOW))
-		return 0;
-
 	esw_attr = attr->esw_attr;
 	if (!esw_attr->split_count ||
 	    esw_attr->split_count == esw_attr->out_count - 1)
@@ -1766,7 +1763,7 @@ extra_split_attr_dests_needed(struct mlx5e_tc_flow *flow, struct mlx5_flow_attr
 	for (i = esw_attr->split_count; i < esw_attr->out_count; i++) {
 		/* external dest with encap is considered as internal by firmware */
 		if (esw_attr->dests[i].vport == MLX5_VPORT_UPLINK &&
-		    !(esw_attr->dests[i].flags & MLX5_ESW_DEST_ENCAP_VALID))
+		    !(esw_attr->dests[i].flags & MLX5_ESW_DEST_ENCAP))
 			ext_dest = true;
 		else
 			int_dest = true;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 20cc01ceee8a..2e0920199d47 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3532,7 +3532,9 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	int err;
 
 	mutex_init(&esw->offloads.termtbl_mutex);
-	mlx5_rdma_enable_roce(esw->dev);
+	err = mlx5_rdma_enable_roce(esw->dev);
+	if (err)
+		goto err_roce;
 
 	err = mlx5_esw_host_number_init(esw);
 	if (err)
@@ -3593,6 +3595,7 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	esw_offloads_metadata_uninit(esw);
 err_metadata:
 	mlx5_rdma_disable_roce(esw->dev);
+err_roce:
 	mutex_destroy(&esw->offloads.termtbl_mutex);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
index a42f6cd99b74..5c552b71e371 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
@@ -118,8 +118,8 @@ static void mlx5_rdma_make_default_gid(struct mlx5_core_dev *dev, union ib_gid *
 
 static int mlx5_rdma_add_roce_addr(struct mlx5_core_dev *dev)
 {
+	u8 mac[ETH_ALEN] = {};
 	union ib_gid gid;
-	u8 mac[ETH_ALEN];
 
 	mlx5_rdma_make_default_gid(dev, &gid);
 	return mlx5_core_roce_gid_set(dev, 0,
@@ -140,17 +140,17 @@ void mlx5_rdma_disable_roce(struct mlx5_core_dev *dev)
 	mlx5_nic_vport_disable_roce(dev);
 }
 
-void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev)
+int mlx5_rdma_enable_roce(struct mlx5_core_dev *dev)
 {
 	int err;
 
 	if (!MLX5_CAP_GEN(dev, roce))
-		return;
+		return 0;
 
 	err = mlx5_nic_vport_enable_roce(dev);
 	if (err) {
 		mlx5_core_err(dev, "Failed to enable RoCE: %d\n", err);
-		return;
+		return err;
 	}
 
 	err = mlx5_rdma_add_roce_addr(dev);
@@ -165,10 +165,11 @@ void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev)
 		goto del_roce_addr;
 	}
 
-	return;
+	return err;
 
 del_roce_addr:
 	mlx5_rdma_del_roce_addr(dev);
 disable_roce:
 	mlx5_nic_vport_disable_roce(dev);
+	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.h b/drivers/net/ethernet/mellanox/mlx5/core/rdma.h
index 750cff2a71a4..3d9e76c3d42f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/rdma.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/rdma.h
@@ -8,12 +8,12 @@
 
 #ifdef CONFIG_MLX5_ESWITCH
 
-void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev);
+int mlx5_rdma_enable_roce(struct mlx5_core_dev *dev);
 void mlx5_rdma_disable_roce(struct mlx5_core_dev *dev);
 
 #else /* CONFIG_MLX5_ESWITCH */
 
-static inline void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev) {}
+static inline int mlx5_rdma_enable_roce(struct mlx5_core_dev *dev) { return 0; }
 static inline void mlx5_rdma_disable_roce(struct mlx5_core_dev *dev) {}
 
 #endif /* CONFIG_MLX5_ESWITCH */
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 23760b613d3e..e2d6bfb5d693 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1815,6 +1815,7 @@ static void lan743x_tx_frame_add_lso(struct lan743x_tx *tx,
 	if (nr_frags <= 0) {
 		tx->frame_data0 |= TX_DESC_DATA0_LS_;
 		tx->frame_data0 |= TX_DESC_DATA0_IOC_;
+		tx->frame_last = tx->frame_first;
 	}
 	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
 	tx_descriptor->data0 = cpu_to_le32(tx->frame_data0);
@@ -1884,6 +1885,7 @@ static int lan743x_tx_frame_add_fragment(struct lan743x_tx *tx,
 		tx->frame_first = 0;
 		tx->frame_data0 = 0;
 		tx->frame_tail = 0;
+		tx->frame_last = 0;
 		return -ENOMEM;
 	}
 
@@ -1924,16 +1926,18 @@ static void lan743x_tx_frame_end(struct lan743x_tx *tx,
 	    TX_DESC_DATA0_DTYPE_DATA_) {
 		tx->frame_data0 |= TX_DESC_DATA0_LS_;
 		tx->frame_data0 |= TX_DESC_DATA0_IOC_;
+		tx->frame_last = tx->frame_tail;
 	}
 
-	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
-	buffer_info = &tx->buffer_info[tx->frame_tail];
+	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_last];
+	buffer_info = &tx->buffer_info[tx->frame_last];
 	buffer_info->skb = skb;
 	if (time_stamp)
 		buffer_info->flags |= TX_BUFFER_INFO_FLAG_TIMESTAMP_REQUESTED;
 	if (ignore_sync)
 		buffer_info->flags |= TX_BUFFER_INFO_FLAG_IGNORE_SYNC;
 
+	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
 	tx_descriptor->data0 = cpu_to_le32(tx->frame_data0);
 	tx->frame_tail = lan743x_tx_next_index(tx, tx->frame_tail);
 	tx->last_tail = tx->frame_tail;
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 7f73d66854be..db5fc73e41cc 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -980,6 +980,7 @@ struct lan743x_tx {
 	u32		frame_first;
 	u32		frame_data0;
 	u32		frame_tail;
+	u32		frame_last;
 
 	struct lan743x_tx_buffer_info *buffer_info;
 
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index ef93df520887..08bee56aea35 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -830,6 +830,7 @@ EXPORT_SYMBOL(ocelot_vlan_prepare);
 int ocelot_vlan_add(struct ocelot *ocelot, int port, u16 vid, bool pvid,
 		    bool untagged)
 {
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
 	int err;
 
 	/* Ignore VID 0 added to our RX filter by the 8021q module, since
@@ -849,6 +850,11 @@ int ocelot_vlan_add(struct ocelot *ocelot, int port, u16 vid, bool pvid,
 					   ocelot_bridge_vlan_find(ocelot, vid));
 		if (err)
 			return err;
+	} else if (ocelot_port->pvid_vlan &&
+		   ocelot_bridge_vlan_find(ocelot, vid) == ocelot_port->pvid_vlan) {
+		err = ocelot_port_set_pvid(ocelot, port, NULL);
+		if (err)
+			return err;
 	}
 
 	/* Untagged egress vlan clasification */
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 2aacc1996796..55b8d3666153 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1925,8 +1925,8 @@ static u16 rtase_calc_time_mitigation(u32 time_us)
 
 	time_us = min_t(int, time_us, RTASE_MITI_MAX_TIME);
 
-	msb = fls(time_us);
-	if (msb >= RTASE_MITI_COUNT_BIT_NUM) {
+	if (time_us > RTASE_MITI_TIME_COUNT_MASK) {
+		msb = fls(time_us);
 		time_unit = msb - RTASE_MITI_COUNT_BIT_NUM;
 		time_count = time_us >> (msb - RTASE_MITI_COUNT_BIT_NUM);
 	} else {
diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/ethernet/vertexcom/mse102x.c
index 89dc4c401a8d..e4d993f31374 100644
--- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -6,6 +6,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/if_vlan.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -33,7 +34,7 @@
 #define CMD_CTR		(0x2 << CMD_SHIFT)
 
 #define CMD_MASK	GENMASK(15, CMD_SHIFT)
-#define LEN_MASK	GENMASK(CMD_SHIFT - 1, 0)
+#define LEN_MASK	GENMASK(CMD_SHIFT - 2, 0)
 
 #define DET_CMD_LEN	4
 #define DET_SOF_LEN	2
@@ -262,7 +263,7 @@ static int mse102x_tx_frame_spi(struct mse102x_net *mse, struct sk_buff *txp,
 }
 
 static int mse102x_rx_frame_spi(struct mse102x_net *mse, u8 *buff,
-				unsigned int frame_len)
+				unsigned int frame_len, bool drop)
 {
 	struct mse102x_net_spi *mses = to_mse102x_spi(mse);
 	struct spi_transfer *xfer = &mses->spi_xfer;
@@ -280,6 +281,9 @@ static int mse102x_rx_frame_spi(struct mse102x_net *mse, u8 *buff,
 		netdev_err(mse->ndev, "%s: spi_sync() failed: %d\n",
 			   __func__, ret);
 		mse->stats.xfer_err++;
+	} else if (drop) {
+		netdev_dbg(mse->ndev, "%s: Drop frame\n", __func__);
+		ret = -EINVAL;
 	} else if (*sof != cpu_to_be16(DET_SOF)) {
 		netdev_dbg(mse->ndev, "%s: SPI start of frame is invalid (0x%04x)\n",
 			   __func__, *sof);
@@ -307,6 +311,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
 	struct sk_buff *skb;
 	unsigned int rxalign;
 	unsigned int rxlen;
+	bool drop = false;
 	__be16 rx = 0;
 	u16 cmd_resp;
 	u8 *rxpkt;
@@ -329,7 +334,8 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
 			net_dbg_ratelimited("%s: Unexpected response (0x%04x)\n",
 					    __func__, cmd_resp);
 			mse->stats.invalid_rts++;
-			return;
+			drop = true;
+			goto drop;
 		}
 
 		net_dbg_ratelimited("%s: Unexpected response to first CMD\n",
@@ -337,12 +343,20 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
 	}
 
 	rxlen = cmd_resp & LEN_MASK;
-	if (!rxlen) {
-		net_dbg_ratelimited("%s: No frame length defined\n", __func__);
+	if (rxlen < ETH_ZLEN || rxlen > VLAN_ETH_FRAME_LEN) {
+		net_dbg_ratelimited("%s: Invalid frame length: %d\n", __func__,
+				    rxlen);
 		mse->stats.invalid_len++;
-		return;
+		drop = true;
 	}
 
+	/* In case of a invalid CMD_RTS, the frame must be consumed anyway.
+	 * So assume the maximum possible frame length.
+	 */
+drop:
+	if (drop)
+		rxlen = VLAN_ETH_FRAME_LEN;
+
 	rxalign = ALIGN(rxlen + DET_SOF_LEN + DET_DFT_LEN, 4);
 	skb = netdev_alloc_skb_ip_align(mse->ndev, rxalign);
 	if (!skb)
@@ -353,7 +367,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
 	 * They are copied, but ignored.
 	 */
 	rxpkt = skb_put(skb, rxlen) - DET_SOF_LEN;
-	if (mse102x_rx_frame_spi(mse, rxpkt, rxlen)) {
+	if (mse102x_rx_frame_spi(mse, rxpkt, rxlen, drop)) {
 		mse->ndev->stats.rx_errors++;
 		dev_kfree_skb(skb);
 		return;
@@ -509,6 +523,7 @@ static irqreturn_t mse102x_irq(int irq, void *_mse)
 static int mse102x_net_open(struct net_device *ndev)
 {
 	struct mse102x_net *mse = netdev_priv(ndev);
+	struct mse102x_net_spi *mses = to_mse102x_spi(mse);
 	int ret;
 
 	ret = request_threaded_irq(ndev->irq, NULL, mse102x_irq, IRQF_ONESHOT,
@@ -524,6 +539,13 @@ static int mse102x_net_open(struct net_device *ndev)
 
 	netif_carrier_on(ndev);
 
+	/* The SPI interrupt can stuck in case of pending packet(s).
+	 * So poll for possible packet(s) to re-arm the interrupt.
+	 */
+	mutex_lock(&mses->lock);
+	mse102x_rx_pkt_spi(mse);
+	mutex_unlock(&mses->lock);
+
 	netif_dbg(mse, ifup, ndev, "network device up\n");
 
 	return 0;
diff --git a/drivers/net/mdio/mdio-mux-meson-gxl.c b/drivers/net/mdio/mdio-mux-meson-gxl.c
index 00c66240136b..3dd12a8c8b03 100644
--- a/drivers/net/mdio/mdio-mux-meson-gxl.c
+++ b/drivers/net/mdio/mdio-mux-meson-gxl.c
@@ -17,6 +17,7 @@
 #define  REG2_LEDACT		GENMASK(23, 22)
 #define  REG2_LEDLINK		GENMASK(25, 24)
 #define  REG2_DIV4SEL		BIT(27)
+#define  REG2_REVERSED		BIT(28)
 #define  REG2_ADCBYPASS		BIT(30)
 #define  REG2_CLKINSEL		BIT(31)
 #define ETH_REG3		0x4
@@ -65,7 +66,7 @@ static void gxl_enable_internal_mdio(struct gxl_mdio_mux *priv)
 	 * The only constraint is that it must match the one in
 	 * drivers/net/phy/meson-gxl.c to properly match the PHY.
 	 */
-	writel(FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
+	writel(REG2_REVERSED | FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
 	       priv->regs + ETH_REG2);
 
 	/* Enable the internal phy */
diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index bb0bf1415872..7b3739b29c8f 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -630,16 +630,6 @@ static const struct driver_info	zte_rndis_info = {
 	.tx_fixup =	rndis_tx_fixup,
 };
 
-static const struct driver_info	wwan_rndis_info = {
-	.description =	"Mobile Broadband RNDIS device",
-	.flags =	FLAG_WWAN | FLAG_POINTTOPOINT | FLAG_FRAMING_RN | FLAG_NO_SETINT,
-	.bind =		rndis_bind,
-	.unbind =	rndis_unbind,
-	.status =	rndis_status,
-	.rx_fixup =	rndis_rx_fixup,
-	.tx_fixup =	rndis_tx_fixup,
-};
-
 /*-------------------------------------------------------------------------*/
 
 static const struct usb_device_id	products [] = {
@@ -676,11 +666,9 @@ static const struct usb_device_id	products [] = {
 	USB_INTERFACE_INFO(USB_CLASS_WIRELESS_CONTROLLER, 1, 3),
 	.driver_info = (unsigned long) &rndis_info,
 }, {
-	/* Mobile Broadband Modem, seen in Novatel Verizon USB730L and
-	 * Telit FN990A (RNDIS)
-	 */
+	/* Novatel Verizon USB730L */
 	USB_INTERFACE_INFO(USB_CLASS_MISC, 4, 1),
-	.driver_info = (unsigned long)&wwan_rndis_info,
+	.driver_info = (unsigned long) &rndis_info,
 },
 	{ },		// END
 };
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 6e6e9f05509a..06d19e90eadb 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -627,7 +627,11 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 	 * default dst remote_ip previously added for this vni
 	 */
 	if (!vxlan_addr_any(&vninode->remote_ip) ||
-	    !vxlan_addr_any(&dst->remote_ip))
+	    !vxlan_addr_any(&dst->remote_ip)) {
+		u32 hash_index = fdb_head_index(vxlan, all_zeros_mac,
+						vninode->vni);
+
+		spin_lock_bh(&vxlan->hash_lock[hash_index]);
 		__vxlan_fdb_delete(vxlan, all_zeros_mac,
 				   (vxlan_addr_any(&vninode->remote_ip) ?
 				   dst->remote_ip : vninode->remote_ip),
@@ -635,6 +639,8 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 				   vninode->vni, vninode->vni,
 				   dst->remote_ifindex,
 				   true);
+		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+	}
 
 	if (vxlan->dev->flags & IFF_UP) {
 		if (vxlan_addr_multicast(&vninode->remote_ip) &&
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 2821c27f317e..d06c724f63d9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -896,14 +896,16 @@ brcmf_usb_dl_writeimage(struct brcmf_usbdev_info *devinfo, u8 *fw, int fwlen)
 	}
 
 	/* 1) Prepare USB boot loader for runtime image */
-	brcmf_usb_dl_cmd(devinfo, DL_START, &state, sizeof(state));
+	err = brcmf_usb_dl_cmd(devinfo, DL_START, &state, sizeof(state));
+	if (err)
+		goto fail;
 
 	rdlstate = le32_to_cpu(state.state);
 	rdlbytes = le32_to_cpu(state.bytes);
 
 	/* 2) Check we are in the Waiting state */
 	if (rdlstate != DL_WAITING) {
-		brcmf_err("Failed to DL_START\n");
+		brcmf_err("Invalid DL state: %u\n", rdlstate);
 		err = -EINVAL;
 		goto fail;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index be9e464c9b7b..3ff493e920d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -148,6 +148,7 @@
  * during a error FW error.
  */
 #define CSR_FUNC_SCRATCH_INIT_VALUE		(0x01010101)
+#define CSR_FUNC_SCRATCH_POWER_OFF_MASK		0xFFFF
 
 /* Bits for CSR_HW_IF_CONFIG_REG */
 #define CSR_HW_IF_CONFIG_REG_MSK_MAC_STEP_DASH	(0x0000000F)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 47854a36413e..ced8261c725f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -21,6 +21,7 @@ struct iwl_trans_dev_restart_data {
 	struct list_head list;
 	unsigned int restart_count;
 	time64_t last_error;
+	bool backoff;
 	char name[];
 };
 
@@ -125,13 +126,20 @@ iwl_trans_determine_restart_mode(struct iwl_trans *trans)
 	if (!data)
 		return at_least;
 
-	if (ktime_get_boottime_seconds() - data->last_error >=
+	if (!data->backoff &&
+	    ktime_get_boottime_seconds() - data->last_error >=
 			IWL_TRANS_RESET_OK_TIME)
 		data->restart_count = 0;
 
 	index = data->restart_count;
-	if (index >= ARRAY_SIZE(escalation_list))
+	if (index >= ARRAY_SIZE(escalation_list)) {
 		index = ARRAY_SIZE(escalation_list) - 1;
+		if (!data->backoff) {
+			data->backoff = true;
+			return IWL_RESET_MODE_BACKOFF;
+		}
+		data->backoff = false;
+	}
 
 	return max(at_least, escalation_list[index]);
 }
@@ -140,7 +148,8 @@ iwl_trans_determine_restart_mode(struct iwl_trans *trans)
 
 static void iwl_trans_restart_wk(struct work_struct *wk)
 {
-	struct iwl_trans *trans = container_of(wk, typeof(*trans), restart.wk);
+	struct iwl_trans *trans = container_of(wk, typeof(*trans),
+					       restart.wk.work);
 	struct iwl_trans_reprobe *reprobe;
 	enum iwl_reset_mode mode;
 
@@ -168,6 +177,12 @@ static void iwl_trans_restart_wk(struct work_struct *wk)
 		return;
 
 	mode = iwl_trans_determine_restart_mode(trans);
+	if (mode == IWL_RESET_MODE_BACKOFF) {
+		IWL_ERR(trans, "Too many device errors - delay next reset\n");
+		queue_delayed_work(system_unbound_wq, &trans->restart.wk,
+				   IWL_TRANS_RESET_DELAY);
+		return;
+	}
 
 	iwl_trans_inc_restart_count(trans->dev);
 
@@ -227,7 +242,7 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 	trans->dev = dev;
 	trans->num_rx_queues = 1;
 
-	INIT_WORK(&trans->restart.wk, iwl_trans_restart_wk);
+	INIT_DELAYED_WORK(&trans->restart.wk, iwl_trans_restart_wk);
 
 	return trans;
 }
@@ -271,7 +286,7 @@ int iwl_trans_init(struct iwl_trans *trans)
 
 void iwl_trans_free(struct iwl_trans *trans)
 {
-	cancel_work_sync(&trans->restart.wk);
+	cancel_delayed_work_sync(&trans->restart.wk);
 	kmem_cache_destroy(trans->dev_cmd_pool);
 }
 
@@ -403,7 +418,7 @@ void iwl_trans_op_mode_leave(struct iwl_trans *trans)
 
 	iwl_trans_pcie_op_mode_leave(trans);
 
-	cancel_work_sync(&trans->restart.wk);
+	cancel_delayed_work_sync(&trans->restart.wk);
 
 	trans->op_mode = NULL;
 
@@ -540,7 +555,6 @@ void __releases(nic_access)
 iwl_trans_release_nic_access(struct iwl_trans *trans)
 {
 	iwl_trans_pcie_release_nic_access(trans);
-	__release(nic_access);
 }
 IWL_EXPORT_SYMBOL(iwl_trans_release_nic_access);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index f6234065dbdd..9c64e1fd4c09 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -958,7 +958,7 @@ struct iwl_trans {
 	struct iwl_dma_ptr invalid_tx_cmd;
 
 	struct {
-		struct work_struct wk;
+		struct delayed_work wk;
 		struct iwl_fw_error_dump_mode mode;
 		bool during_reset;
 	} restart;
@@ -1159,7 +1159,7 @@ static inline void iwl_trans_schedule_reset(struct iwl_trans *trans,
 	 */
 	trans->restart.during_reset = test_bit(STATUS_IN_SW_RESET,
 					       &trans->status);
-	queue_work(system_unbound_wq, &trans->restart.wk);
+	queue_delayed_work(system_unbound_wq, &trans->restart.wk, 0);
 }
 
 static inline void iwl_trans_fw_error(struct iwl_trans *trans,
@@ -1258,6 +1258,9 @@ enum iwl_reset_mode {
 	IWL_RESET_MODE_RESCAN,
 	IWL_RESET_MODE_FUNC_RESET,
 	IWL_RESET_MODE_PROD_RESET,
+
+	/* keep last - special backoff value */
+	IWL_RESET_MODE_BACKOFF,
 };
 
 void iwl_trans_pcie_reset(struct iwl_trans *trans, enum iwl_reset_mode mode);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index e0b657b2f74b..d4c1bc20971f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1702,11 +1702,27 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 	 * Scratch value was altered, this means the device was powered off, we
 	 * need to reset it completely.
 	 * Note: MAC (bits 0:7) will be cleared upon suspend even with wowlan,
-	 * so assume that any bits there mean that the device is usable.
+	 * but not bits [15:8]. So if we have bits set in lower word, assume
+	 * the device is alive.
+	 * For older devices, just try silently to grab the NIC.
 	 */
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ &&
-	    !iwl_read32(trans, CSR_FUNC_SCRATCH))
-		device_was_powered_off = true;
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		if (!(iwl_read32(trans, CSR_FUNC_SCRATCH) &
+		      CSR_FUNC_SCRATCH_POWER_OFF_MASK))
+			device_was_powered_off = true;
+	} else {
+		/*
+		 * bh are re-enabled by iwl_trans_pcie_release_nic_access,
+		 * so re-enable them if _iwl_trans_pcie_grab_nic_access fails.
+		 */
+		local_bh_disable();
+		if (_iwl_trans_pcie_grab_nic_access(trans, true)) {
+			iwl_trans_pcie_release_nic_access(trans);
+		} else {
+			device_was_powered_off = true;
+			local_bh_enable();
+		}
+	}
 
 	if (restore || device_was_powered_off) {
 		trans->state = IWL_TRANS_NO_FW;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 45460f93d24a..114a9195ad7f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -558,10 +558,10 @@ void iwl_trans_pcie_free(struct iwl_trans *trans);
 void iwl_trans_pcie_free_pnvm_dram_regions(struct iwl_dram_regions *dram_regions,
 					   struct device *dev);
 
-bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans);
-#define _iwl_trans_pcie_grab_nic_access(trans)			\
+bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent);
+#define _iwl_trans_pcie_grab_nic_access(trans, silent)		\
 	__cond_lock(nic_access_nobh,				\
-		    likely(__iwl_trans_pcie_grab_nic_access(trans)))
+		    likely(__iwl_trans_pcie_grab_nic_access(trans, silent)))
 
 void iwl_trans_pcie_check_product_reset_status(struct pci_dev *pdev);
 void iwl_trans_pcie_check_product_reset_mode(struct pci_dev *pdev);
@@ -1105,7 +1105,8 @@ void iwl_trans_pcie_set_bits_mask(struct iwl_trans *trans, u32 reg,
 int iwl_trans_pcie_read_config32(struct iwl_trans *trans, u32 ofs,
 				 u32 *val);
 bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans);
-void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans);
+void __releases(nic_access_nobh)
+iwl_trans_pcie_release_nic_access(struct iwl_trans *trans);
 
 /* transport gen 1 exported functions */
 void iwl_trans_pcie_fw_alive(struct iwl_trans *trans, u32 scd_addr);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index c917ed4c19bc..102a6123bba0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2351,7 +2351,8 @@ void iwl_trans_pcie_reset(struct iwl_trans *trans, enum iwl_reset_mode mode)
 	struct iwl_trans_pcie_removal *removal;
 	char _msg = 0, *msg = &_msg;
 
-	if (WARN_ON(mode < IWL_RESET_MODE_REMOVE_ONLY))
+	if (WARN_ON(mode < IWL_RESET_MODE_REMOVE_ONLY ||
+		    mode == IWL_RESET_MODE_BACKOFF))
 		return;
 
 	if (test_bit(STATUS_TRANS_DEAD, &trans->status))
@@ -2405,7 +2406,7 @@ EXPORT_SYMBOL(iwl_trans_pcie_reset);
  * This version doesn't disable BHs but rather assumes they're
  * already disabled.
  */
-bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
+bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent)
 {
 	int ret;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -2457,6 +2458,11 @@ bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 	if (unlikely(ret < 0)) {
 		u32 cntrl = iwl_read32(trans, CSR_GP_CNTRL);
 
+		if (silent) {
+			spin_unlock(&trans_pcie->reg_lock);
+			return false;
+		}
+
 		WARN_ONCE(1,
 			  "Timeout waiting for hardware access (CSR_GP_CNTRL 0x%08x)\n",
 			  cntrl);
@@ -2488,7 +2494,7 @@ bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 	bool ret;
 
 	local_bh_disable();
-	ret = __iwl_trans_pcie_grab_nic_access(trans);
+	ret = __iwl_trans_pcie_grab_nic_access(trans, false);
 	if (ret) {
 		/* keep BHs disabled until iwl_trans_pcie_release_nic_access */
 		return ret;
@@ -2497,7 +2503,8 @@ bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 	return false;
 }
 
-void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
+void __releases(nic_access_nobh)
+iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -2524,6 +2531,7 @@ void iwl_trans_pcie_release_nic_access(struct iwl_trans *trans)
 	 * scheduled on different CPUs (after we drop reg_lock).
 	 */
 out:
+	__release(nic_access_nobh);
 	spin_unlock_bh(&trans_pcie->reg_lock);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 7c1dd5cc084a..83c6fcafcf1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1021,7 +1021,7 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 	 * returned. This needs to be done only on NICs that have
 	 * apmg_wake_up_wa set (see above.)
 	 */
-	if (!_iwl_trans_pcie_grab_nic_access(trans))
+	if (!_iwl_trans_pcie_grab_nic_access(trans, false))
 		return -EIO;
 
 	/*
diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index eae93efa6150..82d1bf7edba2 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -102,7 +102,6 @@ int plfxlc_mac_init_hw(struct ieee80211_hw *hw)
 void plfxlc_mac_release(struct plfxlc_mac *mac)
 {
 	plfxlc_chip_release(&mac->chip);
-	lockdep_assert_held(&mac->lock);
 }
 
 int plfxlc_op_start(struct ieee80211_hw *hw)
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 486afe598184..09ed1f61c9a8 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -97,6 +97,7 @@ config NVME_TCP_TLS
 	depends on NVME_TCP
 	select NET_HANDSHAKE
 	select KEYS
+	select TLS
 	help
 	  Enables TLS encryption for NVMe TCP using the netlink handshake API.
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1dc12784efaf..d49b69565d04 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3578,7 +3578,7 @@ static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
 
 	dev_info(dev->ctrl.device, "restart after slot reset\n");
 	pci_restore_state(pdev);
-	if (!nvme_try_sched_reset(&dev->ctrl))
+	if (nvme_try_sched_reset(&dev->ctrl))
 		nvme_unquiesce_io_queues(&dev->ctrl);
 	return PCI_ERS_RESULT_RECOVERED;
 }
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 327f3f2f5399..d991baa82a1c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1944,7 +1944,7 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	cancel_work_sync(&queue->io_work);
 }
 
-static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
+static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
@@ -1963,6 +1963,31 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_unlock(&queue->queue_lock);
 }
 
+static void nvme_tcp_wait_queue(struct nvme_ctrl *nctrl, int qid)
+{
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+	int timeout = 100;
+
+	while (timeout > 0) {
+		if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags) ||
+		    !sk_wmem_alloc_get(queue->sock->sk))
+			return;
+		msleep(2);
+		timeout -= 2;
+	}
+	dev_warn(nctrl->device,
+		 "qid %d: timeout draining sock wmem allocation expired\n",
+		 qid);
+}
+
+static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
+{
+	nvme_tcp_stop_queue_nowait(nctrl, qid);
+	nvme_tcp_wait_queue(nctrl, qid);
+}
+
+
 static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
 {
 	write_lock_bh(&queue->sock->sk->sk_callback_lock);
@@ -2030,7 +2055,9 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->queue_count; i++)
-		nvme_tcp_stop_queue(ctrl, i);
+		nvme_tcp_stop_queue_nowait(ctrl, i);
+	for (i = 1; i < ctrl->queue_count; i++)
+		nvme_tcp_wait_queue(ctrl, i);
 }
 
 static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index fb7446d6d682..4c253b433bf7 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -98,6 +98,7 @@ config NVME_TARGET_TCP_TLS
 	bool "NVMe over Fabrics TCP target TLS encryption support"
 	depends on NVME_TARGET_TCP
 	select NET_HANDSHAKE
+	select TLS
 	help
 	  Enables TLS encryption for the NVMe TCP target using the netlink handshake API.
 
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 842a1e6cbfc4..18de31328540 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -37,16 +37,16 @@ static inline const struct group_desc *imx_pinctrl_find_group_by_name(
 				struct pinctrl_dev *pctldev,
 				const char *name)
 {
-	const struct group_desc *grp = NULL;
+	const struct group_desc *grp;
 	int i;
 
 	for (i = 0; i < pctldev->num_groups; i++) {
 		grp = pinctrl_generic_get_group(pctldev, i);
 		if (grp && !strcmp(grp->grp.name, name))
-			break;
+			return grp;
 	}
 
-	return grp;
+	return NULL;
 }
 
 static void imx_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
diff --git a/drivers/pinctrl/mediatek/pinctrl-airoha.c b/drivers/pinctrl/mediatek/pinctrl-airoha.c
index 547a798b71c8..5d84a778683d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-airoha.c
+++ b/drivers/pinctrl/mediatek/pinctrl-airoha.c
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/pinctrl/mt65xx.h>
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/gpio/driver.h>
@@ -112,39 +113,19 @@
 #define REG_LAN_LED1_MAPPING			0x0280
 
 #define LAN4_LED_MAPPING_MASK			GENMASK(18, 16)
-#define LAN4_PHY4_LED_MAP			BIT(18)
-#define LAN4_PHY2_LED_MAP			BIT(17)
-#define LAN4_PHY1_LED_MAP			BIT(16)
-#define LAN4_PHY0_LED_MAP			0
-#define LAN4_PHY3_LED_MAP			GENMASK(17, 16)
+#define LAN4_PHY_LED_MAP(_n)			FIELD_PREP_CONST(LAN4_LED_MAPPING_MASK, (_n))
 
 #define LAN3_LED_MAPPING_MASK			GENMASK(14, 12)
-#define LAN3_PHY4_LED_MAP			BIT(14)
-#define LAN3_PHY2_LED_MAP			BIT(13)
-#define LAN3_PHY1_LED_MAP			BIT(12)
-#define LAN3_PHY0_LED_MAP			0
-#define LAN3_PHY3_LED_MAP			GENMASK(13, 12)
+#define LAN3_PHY_LED_MAP(_n)			FIELD_PREP_CONST(LAN3_LED_MAPPING_MASK, (_n))
 
 #define LAN2_LED_MAPPING_MASK			GENMASK(10, 8)
-#define LAN2_PHY4_LED_MAP			BIT(12)
-#define LAN2_PHY2_LED_MAP			BIT(11)
-#define LAN2_PHY1_LED_MAP			BIT(10)
-#define LAN2_PHY0_LED_MAP			0
-#define LAN2_PHY3_LED_MAP			GENMASK(11, 10)
+#define LAN2_PHY_LED_MAP(_n)			FIELD_PREP_CONST(LAN2_LED_MAPPING_MASK, (_n))
 
 #define LAN1_LED_MAPPING_MASK			GENMASK(6, 4)
-#define LAN1_PHY4_LED_MAP			BIT(6)
-#define LAN1_PHY2_LED_MAP			BIT(5)
-#define LAN1_PHY1_LED_MAP			BIT(4)
-#define LAN1_PHY0_LED_MAP			0
-#define LAN1_PHY3_LED_MAP			GENMASK(5, 4)
+#define LAN1_PHY_LED_MAP(_n)			FIELD_PREP_CONST(LAN1_LED_MAPPING_MASK, (_n))
 
 #define LAN0_LED_MAPPING_MASK			GENMASK(2, 0)
-#define LAN0_PHY4_LED_MAP			BIT(3)
-#define LAN0_PHY2_LED_MAP			BIT(2)
-#define LAN0_PHY1_LED_MAP			BIT(1)
-#define LAN0_PHY0_LED_MAP			0
-#define LAN0_PHY3_LED_MAP			GENMASK(2, 1)
+#define LAN0_PHY_LED_MAP(_n)			FIELD_PREP_CONST(LAN0_LED_MAPPING_MASK, (_n))
 
 /* CONF */
 #define REG_I2C_SDA_E2				0x001c
@@ -1476,8 +1457,8 @@ static const struct airoha_pinctrl_func_group phy1_led0_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED0_MAPPING,
-			LAN1_LED_MAPPING_MASK,
-			LAN1_PHY1_LED_MAP
+			LAN0_LED_MAPPING_MASK,
+			LAN0_PHY_LED_MAP(0)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1491,8 +1472,8 @@ static const struct airoha_pinctrl_func_group phy1_led0_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED0_MAPPING,
-			LAN2_LED_MAPPING_MASK,
-			LAN2_PHY1_LED_MAP
+			LAN1_LED_MAPPING_MASK,
+			LAN1_PHY_LED_MAP(0)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1506,8 +1487,8 @@ static const struct airoha_pinctrl_func_group phy1_led0_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED0_MAPPING,
-			LAN3_LED_MAPPING_MASK,
-			LAN3_PHY1_LED_MAP
+			LAN2_LED_MAPPING_MASK,
+			LAN2_PHY_LED_MAP(0)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1521,8 +1502,8 @@ static const struct airoha_pinctrl_func_group phy1_led0_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED0_MAPPING,
-			LAN4_LED_MAPPING_MASK,
-			LAN4_PHY1_LED_MAP
+			LAN3_LED_MAPPING_MASK,
+			LAN3_PHY_LED_MAP(0)
 		},
 		.regmap_size = 2,
 	},
@@ -1540,8 +1521,8 @@ static const struct airoha_pinctrl_func_group phy2_led0_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED0_MAPPING,
-			LAN1_LED_MAPPING_MASK,
-			LAN1_PHY2_LED_MAP
+			LAN0_LED_MAPPING_MASK,
+			LAN0_PHY_LED_MAP(1)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1555,8 +1536,8 @@ static const struct airoha_pinctrl_func_group phy2_led0_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED0_MAPPING,
-			LAN2_LED_MAPPING_MASK,
-			LAN2_PHY2_LED_MAP
+			LAN1_LED_MAPPING_MASK,
+			LAN1_PHY_LED_MAP(1)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1570,8 +1551,8 @@ static const struct airoha_pinctrl_func_group phy2_led0_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED0_MAPPING,
-			LAN3_LED_MAPPING_MASK,
-			LAN3_PHY2_LED_MAP
+			LAN2_LED_MAPPING_MASK,
+			LAN2_PHY_LED_MAP(1)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1585,8 +1566,8 @@ static const struct airoha_pinctrl_func_group phy2_led0_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED0_MAPPING,
-			LAN4_LED_MAPPING_MASK,
-			LAN4_PHY2_LED_MAP
+			LAN3_LED_MAPPING_MASK,
+			LAN3_PHY_LED_MAP(1)
 		},
 		.regmap_size = 2,
 	},
@@ -1604,8 +1585,8 @@ static const struct airoha_pinctrl_func_group phy3_led0_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED0_MAPPING,
-			LAN1_LED_MAPPING_MASK,
-			LAN1_PHY3_LED_MAP
+			LAN0_LED_MAPPING_MASK,
+			LAN0_PHY_LED_MAP(2)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1619,8 +1600,8 @@ static const struct airoha_pinctrl_func_group phy3_led0_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED0_MAPPING,
-			LAN2_LED_MAPPING_MASK,
-			LAN2_PHY3_LED_MAP
+			LAN1_LED_MAPPING_MASK,
+			LAN1_PHY_LED_MAP(2)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1634,8 +1615,8 @@ static const struct airoha_pinctrl_func_group phy3_led0_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED0_MAPPING,
-			LAN3_LED_MAPPING_MASK,
-			LAN3_PHY3_LED_MAP
+			LAN2_LED_MAPPING_MASK,
+			LAN2_PHY_LED_MAP(2)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1649,8 +1630,8 @@ static const struct airoha_pinctrl_func_group phy3_led0_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED0_MAPPING,
-			LAN4_LED_MAPPING_MASK,
-			LAN4_PHY3_LED_MAP
+			LAN3_LED_MAPPING_MASK,
+			LAN3_PHY_LED_MAP(2)
 		},
 		.regmap_size = 2,
 	},
@@ -1668,8 +1649,8 @@ static const struct airoha_pinctrl_func_group phy4_led0_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED0_MAPPING,
-			LAN1_LED_MAPPING_MASK,
-			LAN1_PHY4_LED_MAP
+			LAN0_LED_MAPPING_MASK,
+			LAN0_PHY_LED_MAP(3)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1683,8 +1664,8 @@ static const struct airoha_pinctrl_func_group phy4_led0_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED0_MAPPING,
-			LAN2_LED_MAPPING_MASK,
-			LAN2_PHY4_LED_MAP
+			LAN1_LED_MAPPING_MASK,
+			LAN1_PHY_LED_MAP(3)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1698,8 +1679,8 @@ static const struct airoha_pinctrl_func_group phy4_led0_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED0_MAPPING,
-			LAN3_LED_MAPPING_MASK,
-			LAN3_PHY4_LED_MAP
+			LAN2_LED_MAPPING_MASK,
+			LAN2_PHY_LED_MAP(3)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1713,8 +1694,8 @@ static const struct airoha_pinctrl_func_group phy4_led0_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED0_MAPPING,
-			LAN4_LED_MAPPING_MASK,
-			LAN4_PHY4_LED_MAP
+			LAN3_LED_MAPPING_MASK,
+			LAN3_PHY_LED_MAP(3)
 		},
 		.regmap_size = 2,
 	},
@@ -1732,8 +1713,8 @@ static const struct airoha_pinctrl_func_group phy1_led1_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED1_MAPPING,
-			LAN1_LED_MAPPING_MASK,
-			LAN1_PHY1_LED_MAP
+			LAN0_LED_MAPPING_MASK,
+			LAN0_PHY_LED_MAP(0)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1747,8 +1728,8 @@ static const struct airoha_pinctrl_func_group phy1_led1_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED1_MAPPING,
-			LAN2_LED_MAPPING_MASK,
-			LAN2_PHY1_LED_MAP
+			LAN1_LED_MAPPING_MASK,
+			LAN1_PHY_LED_MAP(0)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1762,8 +1743,8 @@ static const struct airoha_pinctrl_func_group phy1_led1_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED1_MAPPING,
-			LAN3_LED_MAPPING_MASK,
-			LAN3_PHY1_LED_MAP
+			LAN2_LED_MAPPING_MASK,
+			LAN2_PHY_LED_MAP(0)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1777,8 +1758,8 @@ static const struct airoha_pinctrl_func_group phy1_led1_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED1_MAPPING,
-			LAN4_LED_MAPPING_MASK,
-			LAN4_PHY1_LED_MAP
+			LAN3_LED_MAPPING_MASK,
+			LAN3_PHY_LED_MAP(0)
 		},
 		.regmap_size = 2,
 	},
@@ -1796,8 +1777,8 @@ static const struct airoha_pinctrl_func_group phy2_led1_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED1_MAPPING,
-			LAN1_LED_MAPPING_MASK,
-			LAN1_PHY2_LED_MAP
+			LAN0_LED_MAPPING_MASK,
+			LAN0_PHY_LED_MAP(1)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1811,8 +1792,8 @@ static const struct airoha_pinctrl_func_group phy2_led1_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED1_MAPPING,
-			LAN2_LED_MAPPING_MASK,
-			LAN2_PHY2_LED_MAP
+			LAN1_LED_MAPPING_MASK,
+			LAN1_PHY_LED_MAP(1)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1826,8 +1807,8 @@ static const struct airoha_pinctrl_func_group phy2_led1_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED1_MAPPING,
-			LAN3_LED_MAPPING_MASK,
-			LAN3_PHY2_LED_MAP
+			LAN2_LED_MAPPING_MASK,
+			LAN2_PHY_LED_MAP(1)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1841,8 +1822,8 @@ static const struct airoha_pinctrl_func_group phy2_led1_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED1_MAPPING,
-			LAN4_LED_MAPPING_MASK,
-			LAN4_PHY2_LED_MAP
+			LAN3_LED_MAPPING_MASK,
+			LAN3_PHY_LED_MAP(1)
 		},
 		.regmap_size = 2,
 	},
@@ -1860,8 +1841,8 @@ static const struct airoha_pinctrl_func_group phy3_led1_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED1_MAPPING,
-			LAN1_LED_MAPPING_MASK,
-			LAN1_PHY3_LED_MAP
+			LAN0_LED_MAPPING_MASK,
+			LAN0_PHY_LED_MAP(2)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1875,8 +1856,8 @@ static const struct airoha_pinctrl_func_group phy3_led1_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED1_MAPPING,
-			LAN2_LED_MAPPING_MASK,
-			LAN2_PHY3_LED_MAP
+			LAN1_LED_MAPPING_MASK,
+			LAN1_PHY_LED_MAP(2)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1890,8 +1871,8 @@ static const struct airoha_pinctrl_func_group phy3_led1_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED1_MAPPING,
-			LAN3_LED_MAPPING_MASK,
-			LAN3_PHY3_LED_MAP
+			LAN2_LED_MAPPING_MASK,
+			LAN2_PHY_LED_MAP(2)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1905,8 +1886,8 @@ static const struct airoha_pinctrl_func_group phy3_led1_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED1_MAPPING,
-			LAN4_LED_MAPPING_MASK,
-			LAN4_PHY3_LED_MAP
+			LAN3_LED_MAPPING_MASK,
+			LAN3_PHY_LED_MAP(2)
 		},
 		.regmap_size = 2,
 	},
@@ -1924,8 +1905,8 @@ static const struct airoha_pinctrl_func_group phy4_led1_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED1_MAPPING,
-			LAN1_LED_MAPPING_MASK,
-			LAN1_PHY4_LED_MAP
+			LAN0_LED_MAPPING_MASK,
+			LAN0_PHY_LED_MAP(3)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1939,8 +1920,8 @@ static const struct airoha_pinctrl_func_group phy4_led1_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED1_MAPPING,
-			LAN2_LED_MAPPING_MASK,
-			LAN2_PHY4_LED_MAP
+			LAN1_LED_MAPPING_MASK,
+			LAN1_PHY_LED_MAP(3)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1954,8 +1935,8 @@ static const struct airoha_pinctrl_func_group phy4_led1_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED1_MAPPING,
-			LAN3_LED_MAPPING_MASK,
-			LAN3_PHY4_LED_MAP
+			LAN2_LED_MAPPING_MASK,
+			LAN2_PHY_LED_MAP(3)
 		},
 		.regmap_size = 2,
 	}, {
@@ -1969,8 +1950,8 @@ static const struct airoha_pinctrl_func_group phy4_led1_func_group[] = {
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_LAN_LED1_MAPPING,
-			LAN4_LED_MAPPING_MASK,
-			LAN4_PHY4_LED_MAP
+			LAN3_LED_MAPPING_MASK,
+			LAN3_PHY_LED_MAP(3)
 		},
 		.regmap_size = 2,
 	},
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8750.c b/drivers/pinctrl/qcom/pinctrl-sm8750.c
index 1af11cd95fb0..b94fb4ee0ec3 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8750.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8750.c
@@ -46,7 +46,9 @@
 		.out_bit = 1,                                         \
 		.intr_enable_bit = 0,                                 \
 		.intr_status_bit = 0,                                 \
-		.intr_target_bit = 5,                                 \
+		.intr_wakeup_present_bit = 6,                         \
+		.intr_wakeup_enable_bit = 7,                          \
+		.intr_target_bit = 8,                                 \
 		.intr_target_kpss_val = 3,                            \
 		.intr_raw_status_bit = 4,                             \
 		.intr_polarity_bit = 1,                               \
diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index e6124498b195..cfd1c37cf6b6 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -724,10 +724,9 @@ static void amd_pmc_s2idle_check(void)
 	struct smu_metrics table;
 	int rc;
 
-	/* CZN: Ensure that future s0i3 entry attempts at least 10ms passed */
-	if (pdev->cpu_id == AMD_CPU_ID_CZN && !get_metrics_table(pdev, &table) &&
-	    table.s0i3_last_entry_status)
-		usleep_range(10000, 20000);
+	/* Avoid triggering OVP */
+	if (!get_metrics_table(pdev, &table) && table.s0i3_last_entry_status)
+		msleep(2500);
 
 	/* Dump the IdleMask before we add to the STB */
 	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 1426ea8e4f19..1a711d395d2d 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -250,6 +250,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_asm201,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Alienware m15 R7",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m15 R7"),
+		},
+		.driver_data = &quirk_x_series,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "Alienware m16 R1",
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index 40bbf8e45fa4..bdee5d00f30b 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -146,15 +146,13 @@ static int uncore_event_cpu_online(unsigned int cpu)
 {
 	struct uncore_data *data;
 	int target;
+	int ret;
 
 	/* Check if there is an online cpu in the package for uncore MSR */
 	target = cpumask_any_and(&uncore_cpu_mask, topology_die_cpumask(cpu));
 	if (target < nr_cpu_ids)
 		return 0;
 
-	/* Use this CPU on this die as a control CPU */
-	cpumask_set_cpu(cpu, &uncore_cpu_mask);
-
 	data = uncore_get_instance(cpu);
 	if (!data)
 		return 0;
@@ -163,7 +161,14 @@ static int uncore_event_cpu_online(unsigned int cpu)
 	data->die_id = topology_die_id(cpu);
 	data->domain_id = UNCORE_DOMAIN_ID_INVALID;
 
-	return uncore_freq_add_entry(data, cpu);
+	ret = uncore_freq_add_entry(data, cpu);
+	if (ret)
+		return ret;
+
+	/* Use this CPU on this die as a control CPU */
+	cpumask_set_cpu(cpu, &uncore_cpu_mask);
+
+	return 0;
 }
 
 static int uncore_event_cpu_offline(unsigned int cpu)
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 4b7344e1816e..605cce32a3d3 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2578,12 +2578,60 @@ static const struct ocp_sma_op ocp_fb_sma_op = {
 	.set_output	= ptp_ocp_sma_fb_set_output,
 };
 
+static int
+ptp_ocp_sma_adva_set_output(struct ptp_ocp *bp, int sma_nr, u32 val)
+{
+	u32 reg, mask, shift;
+	unsigned long flags;
+	u32 __iomem *gpio;
+
+	gpio = sma_nr > 2 ? &bp->sma_map1->gpio2 : &bp->sma_map2->gpio2;
+	shift = sma_nr & 1 ? 0 : 16;
+
+	mask = 0xffff << (16 - shift);
+
+	spin_lock_irqsave(&bp->lock, flags);
+
+	reg = ioread32(gpio);
+	reg = (reg & mask) | (val << shift);
+
+	iowrite32(reg, gpio);
+
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	return 0;
+}
+
+static int
+ptp_ocp_sma_adva_set_inputs(struct ptp_ocp *bp, int sma_nr, u32 val)
+{
+	u32 reg, mask, shift;
+	unsigned long flags;
+	u32 __iomem *gpio;
+
+	gpio = sma_nr > 2 ? &bp->sma_map2->gpio1 : &bp->sma_map1->gpio1;
+	shift = sma_nr & 1 ? 0 : 16;
+
+	mask = 0xffff << (16 - shift);
+
+	spin_lock_irqsave(&bp->lock, flags);
+
+	reg = ioread32(gpio);
+	reg = (reg & mask) | (val << shift);
+
+	iowrite32(reg, gpio);
+
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	return 0;
+}
+
 static const struct ocp_sma_op ocp_adva_sma_op = {
 	.tbl		= { ptp_ocp_adva_sma_in, ptp_ocp_adva_sma_out },
 	.init		= ptp_ocp_sma_fb_init,
 	.get		= ptp_ocp_sma_fb_get,
-	.set_inputs	= ptp_ocp_sma_fb_set_inputs,
-	.set_output	= ptp_ocp_sma_fb_set_output,
+	.set_inputs	= ptp_ocp_sma_adva_set_inputs,
+	.set_output	= ptp_ocp_sma_adva_set_output,
 };
 
 static int
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index a9f0f47f4759..74b013c41601 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -585,7 +585,11 @@ u64 spi_mem_calc_op_duration(struct spi_mem_op *op)
 	ns_per_cycles = 1000000000 / op->max_freq;
 	ncycles += ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ? 2 : 1);
 	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dtr ? 2 : 1);
-	ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
+
+	/* Dummy bytes are optional for some SPI flash memory operations */
+	if (op->dummy.nbytes)
+		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
+
 	ncycles += ((op->data.nbytes * 8) / op->data.buswidth) / (op->data.dtr ? 2 : 1);
 
 	return ncycles * ns_per_cycles;
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 3822d7c8d8ed..2a8bb798e95b 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -728,9 +728,9 @@ static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
 	u32 inactive_cycles;
 	u8 cs_state;
 
-	if (setup->unit != SPI_DELAY_UNIT_SCK ||
-	    hold->unit != SPI_DELAY_UNIT_SCK ||
-	    inactive->unit != SPI_DELAY_UNIT_SCK) {
+	if ((setup->unit && setup->unit != SPI_DELAY_UNIT_SCK) ||
+	    (hold->unit && hold->unit != SPI_DELAY_UNIT_SCK) ||
+	    (inactive->unit && inactive->unit != SPI_DELAY_UNIT_SCK)) {
 		dev_err(&spi->dev,
 			"Invalid delay unit %d, should be SPI_DELAY_UNIT_SCK\n",
 			SPI_DELAY_UNIT_SCK);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 128e35a848b7..99e7e4a570f0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7201,8 +7201,6 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 			err = -EINVAL;
 		}
 	}
-	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
-				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
 
 	return err;
 }
diff --git a/fs/bcachefs/btree_update_interior.c b/fs/bcachefs/btree_update_interior.c
index e4e7c804625e..e9be8b5571a4 100644
--- a/fs/bcachefs/btree_update_interior.c
+++ b/fs/bcachefs/btree_update_interior.c
@@ -35,6 +35,8 @@ static const char * const bch2_btree_update_modes[] = {
 	NULL
 };
 
+static void bch2_btree_update_to_text(struct printbuf *, struct btree_update *);
+
 static int bch2_btree_insert_node(struct btree_update *, struct btree_trans *,
 				  btree_path_idx_t, struct btree *, struct keylist *);
 static void bch2_btree_update_add_new_node(struct btree_update *, struct btree *);
@@ -1782,11 +1784,24 @@ static int bch2_btree_insert_node(struct btree_update *as, struct btree_trans *t
 	int ret;
 
 	lockdep_assert_held(&c->gc_lock);
-	BUG_ON(!btree_node_intent_locked(path, b->c.level));
 	BUG_ON(!b->c.level);
 	BUG_ON(!as || as->b);
 	bch2_verify_keylist_sorted(keys);
 
+	if (!btree_node_intent_locked(path, b->c.level)) {
+		struct printbuf buf = PRINTBUF;
+		bch2_log_msg_start(c, &buf);
+		prt_printf(&buf, "%s(): node not locked at level %u\n",
+			   __func__, b->c.level);
+		bch2_btree_update_to_text(&buf, as);
+		bch2_btree_path_to_text(&buf, trans, path_idx);
+
+		bch2_print_string_as_lines(KERN_ERR, buf.buf);
+		printbuf_exit(&buf);
+		bch2_fs_emergency_read_only(c);
+		return -EIO;
+	}
+
 	ret = bch2_btree_node_lock_write(trans, path, &b->c);
 	if (ret)
 		return ret;
diff --git a/fs/bcachefs/error.c b/fs/bcachefs/error.c
index 038da6a61f6b..6cbf4819e923 100644
--- a/fs/bcachefs/error.c
+++ b/fs/bcachefs/error.c
@@ -11,6 +11,14 @@
 
 #define FSCK_ERR_RATELIMIT_NR	10
 
+void bch2_log_msg_start(struct bch_fs *c, struct printbuf *out)
+{
+#ifdef BCACHEFS_LOG_PREFIX
+	prt_printf(out, bch2_log_msg(c, ""));
+#endif
+	printbuf_indent_add(out, 2);
+}
+
 bool bch2_inconsistent_error(struct bch_fs *c)
 {
 	set_bit(BCH_FS_error, &c->flags);
diff --git a/fs/bcachefs/error.h b/fs/bcachefs/error.h
index 7acf2a27ca28..5730eb6b2f38 100644
--- a/fs/bcachefs/error.h
+++ b/fs/bcachefs/error.h
@@ -18,6 +18,8 @@ struct work_struct;
 
 /* Error messages: */
 
+void bch2_log_msg_start(struct bch_fs *, struct printbuf *);
+
 /*
  * Inconsistency errors: The on disk data is inconsistent. If these occur during
  * initial recovery, they don't indicate a bug in the running code - we walk all
diff --git a/fs/bcachefs/xattr_format.h b/fs/bcachefs/xattr_format.h
index c7916011ef34..67426e33d04e 100644
--- a/fs/bcachefs/xattr_format.h
+++ b/fs/bcachefs/xattr_format.h
@@ -13,7 +13,13 @@ struct bch_xattr {
 	__u8			x_type;
 	__u8			x_name_len;
 	__le16			x_val_len;
-	__u8			x_name[] __counted_by(x_name_len);
+	/*
+	 * x_name contains the name and value counted by
+	 * x_name_len + x_val_len. The introduction of
+	 * __counted_by(x_name_len) caused a false positive
+	 * detection of an out of bounds write.
+	 */
+	__u8			x_name[];
 } __packed __aligned(8);
 
 #endif /* _BCACHEFS_XATTR_FORMAT_H */
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b2fa33911c28..029fba82b81d 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -516,6 +516,14 @@ static inline void btrfs_assert_inode_locked(struct btrfs_inode *inode)
 	lockdep_assert_held(&inode->vfs_inode.i_rwsem);
 }
 
+static inline void btrfs_update_inode_mapping_flags(struct btrfs_inode *inode)
+{
+	if (inode->flags & BTRFS_INODE_NODATASUM)
+		mapping_clear_stable_writes(inode->vfs_inode.i_mapping);
+	else
+		mapping_set_stable_writes(inode->vfs_inode.i_mapping);
+}
+
 /* Array of bytes with variable length, hexadecimal format 0x1234 */
 #define CSUM_FMT				"0x%*phN"
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b2fae67f8fa3..c021aae8875e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1871,7 +1871,7 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
 			      subpage->bitmaps)) {
 			spin_unlock_irqrestore(&subpage->lock, flags);
 			spin_unlock(&folio->mapping->i_private_lock);
-			bit_start++;
+			bit_start += sectors_per_node;
 			continue;
 		}
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a92997a583bd..cd4e40a71918 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -874,7 +874,6 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 			ret = PTR_ERR(folio);
 		return ret;
 	}
-	folio_wait_writeback(folio);
 	/* Only support page sized folio yet. */
 	ASSERT(folio_order(folio) == 0);
 	ret = set_folio_extent_mapped(folio);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 38756f8cef46..3be6f8e8e157 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2083,12 +2083,13 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 		/*
 		 * If the found extent starts after requested offset, then
-		 * adjust extent_end to be right before this extent begins
+		 * adjust cur_offset to be right before this extent begins.
 		 */
 		if (found_key.offset > cur_offset) {
-			extent_end = found_key.offset;
-			extent_type = 0;
-			goto must_cow;
+			if (cow_start == (u64)-1)
+				cow_start = cur_offset;
+			cur_offset = found_key.offset;
+			goto next_slot;
 		}
 
 		/*
@@ -3845,12 +3846,13 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
  *
  * On failure clean up the inode.
  */
-static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
+static int btrfs_read_locked_inode(struct btrfs_inode *inode, struct btrfs_path *path)
 {
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *leaf;
 	struct btrfs_inode_item *inode_item;
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct inode *vfs_inode = &inode->vfs_inode;
 	struct btrfs_key location;
 	unsigned long ptr;
 	int maybe_acls;
@@ -3859,17 +3861,17 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 	bool filled = false;
 	int first_xattr_slot;
 
-	ret = btrfs_init_file_extent_tree(BTRFS_I(inode));
+	ret = btrfs_init_file_extent_tree(inode);
 	if (ret)
 		goto out;
 
-	ret = btrfs_fill_inode(inode, &rdev);
+	ret = btrfs_fill_inode(vfs_inode, &rdev);
 	if (!ret)
 		filled = true;
 
 	ASSERT(path);
 
-	btrfs_get_inode_key(BTRFS_I(inode), &location);
+	btrfs_get_inode_key(inode, &location);
 
 	ret = btrfs_lookup_inode(NULL, root, path, &location, 0);
 	if (ret) {
@@ -3889,41 +3891,41 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 
 	inode_item = btrfs_item_ptr(leaf, path->slots[0],
 				    struct btrfs_inode_item);
-	inode->i_mode = btrfs_inode_mode(leaf, inode_item);
-	set_nlink(inode, btrfs_inode_nlink(leaf, inode_item));
-	i_uid_write(inode, btrfs_inode_uid(leaf, inode_item));
-	i_gid_write(inode, btrfs_inode_gid(leaf, inode_item));
-	btrfs_i_size_write(BTRFS_I(inode), btrfs_inode_size(leaf, inode_item));
-	btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
-			round_up(i_size_read(inode), fs_info->sectorsize));
-
-	inode_set_atime(inode, btrfs_timespec_sec(leaf, &inode_item->atime),
+	vfs_inode->i_mode = btrfs_inode_mode(leaf, inode_item);
+	set_nlink(vfs_inode, btrfs_inode_nlink(leaf, inode_item));
+	i_uid_write(vfs_inode, btrfs_inode_uid(leaf, inode_item));
+	i_gid_write(vfs_inode, btrfs_inode_gid(leaf, inode_item));
+	btrfs_i_size_write(inode, btrfs_inode_size(leaf, inode_item));
+	btrfs_inode_set_file_extent_range(inode, 0,
+			round_up(i_size_read(vfs_inode), fs_info->sectorsize));
+
+	inode_set_atime(vfs_inode, btrfs_timespec_sec(leaf, &inode_item->atime),
 			btrfs_timespec_nsec(leaf, &inode_item->atime));
 
-	inode_set_mtime(inode, btrfs_timespec_sec(leaf, &inode_item->mtime),
+	inode_set_mtime(vfs_inode, btrfs_timespec_sec(leaf, &inode_item->mtime),
 			btrfs_timespec_nsec(leaf, &inode_item->mtime));
 
-	inode_set_ctime(inode, btrfs_timespec_sec(leaf, &inode_item->ctime),
+	inode_set_ctime(vfs_inode, btrfs_timespec_sec(leaf, &inode_item->ctime),
 			btrfs_timespec_nsec(leaf, &inode_item->ctime));
 
-	BTRFS_I(inode)->i_otime_sec = btrfs_timespec_sec(leaf, &inode_item->otime);
-	BTRFS_I(inode)->i_otime_nsec = btrfs_timespec_nsec(leaf, &inode_item->otime);
+	inode->i_otime_sec = btrfs_timespec_sec(leaf, &inode_item->otime);
+	inode->i_otime_nsec = btrfs_timespec_nsec(leaf, &inode_item->otime);
 
-	inode_set_bytes(inode, btrfs_inode_nbytes(leaf, inode_item));
-	BTRFS_I(inode)->generation = btrfs_inode_generation(leaf, inode_item);
-	BTRFS_I(inode)->last_trans = btrfs_inode_transid(leaf, inode_item);
+	inode_set_bytes(vfs_inode, btrfs_inode_nbytes(leaf, inode_item));
+	inode->generation = btrfs_inode_generation(leaf, inode_item);
+	inode->last_trans = btrfs_inode_transid(leaf, inode_item);
 
-	inode_set_iversion_queried(inode,
-				   btrfs_inode_sequence(leaf, inode_item));
-	inode->i_generation = BTRFS_I(inode)->generation;
-	inode->i_rdev = 0;
+	inode_set_iversion_queried(vfs_inode, btrfs_inode_sequence(leaf, inode_item));
+	vfs_inode->i_generation = inode->generation;
+	vfs_inode->i_rdev = 0;
 	rdev = btrfs_inode_rdev(leaf, inode_item);
 
-	if (S_ISDIR(inode->i_mode))
-		BTRFS_I(inode)->index_cnt = (u64)-1;
+	if (S_ISDIR(vfs_inode->i_mode))
+		inode->index_cnt = (u64)-1;
 
 	btrfs_inode_split_flags(btrfs_inode_flags(leaf, inode_item),
-				&BTRFS_I(inode)->flags, &BTRFS_I(inode)->ro_flags);
+				&inode->flags, &inode->ro_flags);
+	btrfs_update_inode_mapping_flags(inode);
 
 cache_index:
 	/*
@@ -3935,9 +3937,8 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 	 * This is required for both inode re-read from disk and delayed inode
 	 * in the delayed_nodes xarray.
 	 */
-	if (BTRFS_I(inode)->last_trans == btrfs_get_fs_generation(fs_info))
-		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
-			&BTRFS_I(inode)->runtime_flags);
+	if (inode->last_trans == btrfs_get_fs_generation(fs_info))
+		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags);
 
 	/*
 	 * We don't persist the id of the transaction where an unlink operation
@@ -3966,7 +3967,7 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 	 * transaction commits on fsync if our inode is a directory, or if our
 	 * inode is not a directory, logging its parent unnecessarily.
 	 */
-	BTRFS_I(inode)->last_unlink_trans = BTRFS_I(inode)->last_trans;
+	inode->last_unlink_trans = inode->last_trans;
 
 	/*
 	 * Same logic as for last_unlink_trans. We don't persist the generation
@@ -3974,15 +3975,15 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 	 * operation, so after eviction and reloading the inode we must be
 	 * pessimistic and assume the last transaction that modified the inode.
 	 */
-	BTRFS_I(inode)->last_reflink_trans = BTRFS_I(inode)->last_trans;
+	inode->last_reflink_trans = inode->last_trans;
 
 	path->slots[0]++;
-	if (inode->i_nlink != 1 ||
+	if (vfs_inode->i_nlink != 1 ||
 	    path->slots[0] >= btrfs_header_nritems(leaf))
 		goto cache_acl;
 
 	btrfs_item_key_to_cpu(leaf, &location, path->slots[0]);
-	if (location.objectid != btrfs_ino(BTRFS_I(inode)))
+	if (location.objectid != btrfs_ino(inode))
 		goto cache_acl;
 
 	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
@@ -3990,13 +3991,12 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 		struct btrfs_inode_ref *ref;
 
 		ref = (struct btrfs_inode_ref *)ptr;
-		BTRFS_I(inode)->dir_index = btrfs_inode_ref_index(leaf, ref);
+		inode->dir_index = btrfs_inode_ref_index(leaf, ref);
 	} else if (location.type == BTRFS_INODE_EXTREF_KEY) {
 		struct btrfs_inode_extref *extref;
 
 		extref = (struct btrfs_inode_extref *)ptr;
-		BTRFS_I(inode)->dir_index = btrfs_inode_extref_index(leaf,
-								     extref);
+		inode->dir_index = btrfs_inode_extref_index(leaf, extref);
 	}
 cache_acl:
 	/*
@@ -4004,50 +4004,49 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 	 * any xattrs or acls
 	 */
 	maybe_acls = acls_after_inode_item(leaf, path->slots[0],
-			btrfs_ino(BTRFS_I(inode)), &first_xattr_slot);
+					   btrfs_ino(inode), &first_xattr_slot);
 	if (first_xattr_slot != -1) {
 		path->slots[0] = first_xattr_slot;
-		ret = btrfs_load_inode_props(inode, path);
+		ret = btrfs_load_inode_props(vfs_inode, path);
 		if (ret)
 			btrfs_err(fs_info,
 				  "error loading props for ino %llu (root %llu): %d",
-				  btrfs_ino(BTRFS_I(inode)),
-				  btrfs_root_id(root), ret);
+				  btrfs_ino(inode), btrfs_root_id(root), ret);
 	}
 
 	if (!maybe_acls)
-		cache_no_acl(inode);
+		cache_no_acl(vfs_inode);
 
-	switch (inode->i_mode & S_IFMT) {
+	switch (vfs_inode->i_mode & S_IFMT) {
 	case S_IFREG:
-		inode->i_mapping->a_ops = &btrfs_aops;
-		inode->i_fop = &btrfs_file_operations;
-		inode->i_op = &btrfs_file_inode_operations;
+		vfs_inode->i_mapping->a_ops = &btrfs_aops;
+		vfs_inode->i_fop = &btrfs_file_operations;
+		vfs_inode->i_op = &btrfs_file_inode_operations;
 		break;
 	case S_IFDIR:
-		inode->i_fop = &btrfs_dir_file_operations;
-		inode->i_op = &btrfs_dir_inode_operations;
+		vfs_inode->i_fop = &btrfs_dir_file_operations;
+		vfs_inode->i_op = &btrfs_dir_inode_operations;
 		break;
 	case S_IFLNK:
-		inode->i_op = &btrfs_symlink_inode_operations;
-		inode_nohighmem(inode);
-		inode->i_mapping->a_ops = &btrfs_aops;
+		vfs_inode->i_op = &btrfs_symlink_inode_operations;
+		inode_nohighmem(vfs_inode);
+		vfs_inode->i_mapping->a_ops = &btrfs_aops;
 		break;
 	default:
-		inode->i_op = &btrfs_special_inode_operations;
-		init_special_inode(inode, inode->i_mode, rdev);
+		vfs_inode->i_op = &btrfs_special_inode_operations;
+		init_special_inode(vfs_inode, vfs_inode->i_mode, rdev);
 		break;
 	}
 
-	btrfs_sync_inode_flags_to_i_flags(inode);
+	btrfs_sync_inode_flags_to_i_flags(vfs_inode);
 
-	ret = btrfs_add_inode_to_root(BTRFS_I(inode), true);
+	ret = btrfs_add_inode_to_root(inode, true);
 	if (ret)
 		goto out;
 
 	return 0;
 out:
-	iget_failed(inode);
+	iget_failed(vfs_inode);
 	return ret;
 }
 
@@ -5602,7 +5601,7 @@ static int btrfs_find_actor(struct inode *inode, void *opaque)
 		args->root == BTRFS_I(inode)->root;
 }
 
-static struct inode *btrfs_iget_locked(u64 ino, struct btrfs_root *root)
+static struct btrfs_inode *btrfs_iget_locked(u64 ino, struct btrfs_root *root)
 {
 	struct inode *inode;
 	struct btrfs_iget_args args;
@@ -5614,7 +5613,9 @@ static struct inode *btrfs_iget_locked(u64 ino, struct btrfs_root *root)
 	inode = iget5_locked_rcu(root->fs_info->sb, hashval, btrfs_find_actor,
 			     btrfs_init_locked_inode,
 			     (void *)&args);
-	return inode;
+	if (!inode)
+		return NULL;
+	return BTRFS_I(inode);
 }
 
 /*
@@ -5624,22 +5625,22 @@ static struct inode *btrfs_iget_locked(u64 ino, struct btrfs_root *root)
 struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 			      struct btrfs_path *path)
 {
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	int ret;
 
 	inode = btrfs_iget_locked(ino, root);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW))
-		return inode;
+	if (!(inode->vfs_inode.i_state & I_NEW))
+		return &inode->vfs_inode;
 
 	ret = btrfs_read_locked_inode(inode, path);
 	if (ret)
 		return ERR_PTR(ret);
 
-	unlock_new_inode(inode);
-	return inode;
+	unlock_new_inode(&inode->vfs_inode);
+	return &inode->vfs_inode;
 }
 
 /*
@@ -5647,7 +5648,7 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
  */
 struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 {
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	struct btrfs_path *path;
 	int ret;
 
@@ -5655,20 +5656,22 @@ struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW))
-		return inode;
+	if (!(inode->vfs_inode.i_state & I_NEW))
+		return &inode->vfs_inode;
 
 	path = btrfs_alloc_path();
-	if (!path)
+	if (!path) {
+		iget_failed(&inode->vfs_inode);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	ret = btrfs_read_locked_inode(inode, path);
 	btrfs_free_path(path);
 	if (ret)
 		return ERR_PTR(ret);
 
-	unlock_new_inode(inode);
-	return inode;
+	unlock_new_inode(&inode->vfs_inode);
+	return &inode->vfs_inode;
 }
 
 static struct inode *new_simple_dir(struct inode *dir,
@@ -6339,6 +6342,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		if (btrfs_test_opt(fs_info, NODATACOW))
 			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATACOW |
 				BTRFS_INODE_NODATASUM;
+		btrfs_update_inode_mapping_flags(BTRFS_I(inode));
 	}
 
 	ret = btrfs_insert_inode_locked(inode);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e666c141cae0..10a97f0af8d4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -393,6 +393,7 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 
 update_flags:
 	binode->flags = binode_flags;
+	btrfs_update_inode_mapping_flags(binode);
 	btrfs_sync_inode_flags_to_i_flags(inode);
 	inode_inc_iversion(inode);
 	inode_set_ctime_current(inode);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 978a57da8b4f..f39656668967 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1277,7 +1277,7 @@ struct zone_info {
 
 static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 				struct zone_info *info, unsigned long *active,
-				struct btrfs_chunk_map *map)
+				struct btrfs_chunk_map *map, bool new)
 {
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
 	struct btrfs_device *device;
@@ -1307,6 +1307,8 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 		return 0;
 	}
 
+	ASSERT(!new || btrfs_dev_is_empty_zone(device, info->physical));
+
 	/* This zone will be used for allocation, so mark this zone non-empty. */
 	btrfs_dev_clear_zone_empty(device, info->physical);
 
@@ -1319,6 +1321,18 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 	 * to determine the allocation offset within the zone.
 	 */
 	WARN_ON(!IS_ALIGNED(info->physical, fs_info->zone_size));
+
+	if (new) {
+		sector_t capacity;
+
+		capacity = bdev_zone_capacity(device->bdev, info->physical >> SECTOR_SHIFT);
+		up_read(&dev_replace->rwsem);
+		info->alloc_offset = 0;
+		info->capacity = capacity << SECTOR_SHIFT;
+
+		return 0;
+	}
+
 	nofs_flag = memalloc_nofs_save();
 	ret = btrfs_get_dev_zone(device, info->physical, &zone);
 	memalloc_nofs_restore(nofs_flag);
@@ -1588,7 +1602,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 
 	for (i = 0; i < map->num_stripes; i++) {
-		ret = btrfs_load_zone_info(fs_info, i, &zone_info[i], active, map);
+		ret = btrfs_load_zone_info(fs_info, i, &zone_info[i], active, map, new);
 		if (ret)
 			goto out;
 
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 163b8fea47e8..e7118501fdcc 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2920,6 +2920,7 @@ int smb311_posix_mkdir(const unsigned int xid, struct inode *inode,
 		req->CreateContextsOffset = cpu_to_le32(
 			sizeof(struct smb2_create_req) +
 			iov[1].iov_len);
+		le32_add_cpu(&req->CreateContextsLength, iov[n_iov-1].iov_len);
 		pc_buf = iov[n_iov-1].iov_base;
 	}
 
diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index 83caa3849749..b3d121052408 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -550,7 +550,19 @@ int ksmbd_krb5_authenticate(struct ksmbd_session *sess, char *in_blob,
 		retval = -ENOMEM;
 		goto out;
 	}
-	sess->user = user;
+
+	if (!sess->user) {
+		/* First successful authentication */
+		sess->user = user;
+	} else {
+		if (!ksmbd_compare_user(sess->user, user)) {
+			ksmbd_debug(AUTH, "different user tried to reuse session\n");
+			retval = -EPERM;
+			ksmbd_free_user(user);
+			goto out;
+		}
+		ksmbd_free_user(user);
+	}
 
 	memcpy(sess->sess_key, resp->payload, resp->session_key_len);
 	memcpy(out_blob, resp->payload + resp->session_key_len,
diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 3f45f28f6f0f..9dec4c2940bc 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -59,10 +59,12 @@ static void ksmbd_session_rpc_clear_list(struct ksmbd_session *sess)
 	struct ksmbd_session_rpc *entry;
 	long index;
 
+	down_write(&sess->rpc_lock);
 	xa_for_each(&sess->rpc_handle_list, index, entry) {
 		xa_erase(&sess->rpc_handle_list, index);
 		__session_rpc_close(sess, entry);
 	}
+	up_write(&sess->rpc_lock);
 
 	xa_destroy(&sess->rpc_handle_list);
 }
@@ -92,7 +94,7 @@ int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 {
 	struct ksmbd_session_rpc *entry, *old;
 	struct ksmbd_rpc_command *resp;
-	int method;
+	int method, id;
 
 	method = __rpc_method(rpc_name);
 	if (!method)
@@ -102,26 +104,29 @@ int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 	if (!entry)
 		return -ENOMEM;
 
+	down_read(&sess->rpc_lock);
 	entry->method = method;
-	entry->id = ksmbd_ipc_id_alloc();
-	if (entry->id < 0)
+	entry->id = id = ksmbd_ipc_id_alloc();
+	if (id < 0)
 		goto free_entry;
-	old = xa_store(&sess->rpc_handle_list, entry->id, entry, KSMBD_DEFAULT_GFP);
+	old = xa_store(&sess->rpc_handle_list, id, entry, KSMBD_DEFAULT_GFP);
 	if (xa_is_err(old))
 		goto free_id;
 
-	resp = ksmbd_rpc_open(sess, entry->id);
+	resp = ksmbd_rpc_open(sess, id);
 	if (!resp)
 		goto erase_xa;
 
+	up_read(&sess->rpc_lock);
 	kvfree(resp);
-	return entry->id;
+	return id;
 erase_xa:
 	xa_erase(&sess->rpc_handle_list, entry->id);
 free_id:
 	ksmbd_rpc_id_free(entry->id);
 free_entry:
 	kfree(entry);
+	up_read(&sess->rpc_lock);
 	return -EINVAL;
 }
 
@@ -129,9 +134,11 @@ void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id)
 {
 	struct ksmbd_session_rpc *entry;
 
+	down_write(&sess->rpc_lock);
 	entry = xa_erase(&sess->rpc_handle_list, id);
 	if (entry)
 		__session_rpc_close(sess, entry);
+	up_write(&sess->rpc_lock);
 }
 
 int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id)
@@ -439,6 +446,7 @@ static struct ksmbd_session *__session_create(int protocol)
 	sess->sequence_number = 1;
 	rwlock_init(&sess->tree_conns_lock);
 	atomic_set(&sess->refcnt, 2);
+	init_rwsem(&sess->rpc_lock);
 
 	ret = __init_smb2_session(sess);
 	if (ret)
diff --git a/fs/smb/server/mgmt/user_session.h b/fs/smb/server/mgmt/user_session.h
index f21348381d59..c5749d6ec715 100644
--- a/fs/smb/server/mgmt/user_session.h
+++ b/fs/smb/server/mgmt/user_session.h
@@ -63,6 +63,7 @@ struct ksmbd_session {
 	rwlock_t			tree_conns_lock;
 
 	atomic_t			refcnt;
+	struct rw_semaphore		rpc_lock;
 };
 
 static inline int test_session_flag(struct ksmbd_session *sess, int bit)
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 57839f9708bb..58ede9196751 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1602,11 +1602,6 @@ static int krb5_authenticate(struct ksmbd_work *work,
 	if (prev_sess_id && prev_sess_id != sess->id)
 		destroy_previous_session(conn, sess->user, prev_sess_id);
 
-	if (sess->state == SMB2_SESSION_VALID) {
-		ksmbd_free_user(sess->user);
-		sess->user = NULL;
-	}
-
 	retval = ksmbd_krb5_authenticate(sess, in_blob, in_len,
 					 out_blob, &out_len);
 	if (retval) {
@@ -2249,10 +2244,6 @@ int smb2_session_logoff(struct ksmbd_work *work)
 	sess->state = SMB2_SESSION_EXPIRED;
 	up_write(&conn->session_lock);
 
-	if (sess->user) {
-		ksmbd_free_user(sess->user);
-		sess->user = NULL;
-	}
 	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_SETUP);
 
 	rsp->StructureSize = cpu_to_le16(4);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6aa67e9b2ec0..0fec27d6b986 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -691,23 +691,6 @@ static inline bool blk_queue_is_zoned(struct request_queue *q)
 		(q->limits.features & BLK_FEAT_ZONED);
 }
 
-#ifdef CONFIG_BLK_DEV_ZONED
-static inline unsigned int disk_nr_zones(struct gendisk *disk)
-{
-	return disk->nr_zones;
-}
-bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs);
-#else /* CONFIG_BLK_DEV_ZONED */
-static inline unsigned int disk_nr_zones(struct gendisk *disk)
-{
-	return 0;
-}
-static inline bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
-{
-	return false;
-}
-#endif /* CONFIG_BLK_DEV_ZONED */
-
 static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 {
 	if (!blk_queue_is_zoned(disk->queue))
@@ -715,11 +698,6 @@ static inline unsigned int disk_zone_no(struct gendisk *disk, sector_t sector)
 	return sector >> ilog2(disk->queue->limits.chunk_sectors);
 }
 
-static inline unsigned int bdev_nr_zones(struct block_device *bdev)
-{
-	return disk_nr_zones(bdev->bd_disk);
-}
-
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	return bdev->bd_disk->queue->limits.max_open_zones;
@@ -826,6 +804,51 @@ static inline u64 sb_bdev_nr_blocks(struct super_block *sb)
 		(sb->s_blocksize_bits - SECTOR_SHIFT);
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static inline unsigned int disk_nr_zones(struct gendisk *disk)
+{
+	return disk->nr_zones;
+}
+bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs);
+
+/**
+ * disk_zone_capacity - returns the zone capacity of zone containing @sector
+ * @disk:	disk to work with
+ * @sector:	sector number within the querying zone
+ *
+ * Returns the zone capacity of a zone containing @sector. @sector can be any
+ * sector in the zone.
+ */
+static inline unsigned int disk_zone_capacity(struct gendisk *disk,
+					      sector_t sector)
+{
+	sector_t zone_sectors = disk->queue->limits.chunk_sectors;
+
+	if (sector + zone_sectors >= get_capacity(disk))
+		return disk->last_zone_capacity;
+	return disk->zone_capacity;
+}
+static inline unsigned int bdev_zone_capacity(struct block_device *bdev,
+					      sector_t pos)
+{
+	return disk_zone_capacity(bdev->bd_disk, pos);
+}
+#else /* CONFIG_BLK_DEV_ZONED */
+static inline unsigned int disk_nr_zones(struct gendisk *disk)
+{
+	return 0;
+}
+static inline bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
+{
+	return false;
+}
+#endif /* CONFIG_BLK_DEV_ZONED */
+
+static inline unsigned int bdev_nr_zones(struct block_device *bdev)
+{
+	return disk_nr_zones(bdev->bd_disk);
+}
+
 int bdev_disk_changed(struct gendisk *disk, bool invalidate);
 
 void put_disk(struct gendisk *disk);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 7fe0981a7e46..73024830bd73 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -144,6 +144,9 @@ struct cpufreq_policy {
 	/* Per policy boost enabled flag. */
 	bool			boost_enabled;
 
+	/* Per policy boost supported flag. */
+	bool			boost_supported;
+
 	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
 	unsigned int cached_target_freq;
 	unsigned int cached_resolved_idx;
@@ -770,8 +773,8 @@ int cpufreq_frequency_table_verify(struct cpufreq_policy_data *policy,
 int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *policy);
 
 int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
-				 unsigned int target_freq,
-				 unsigned int relation);
+				 unsigned int target_freq, unsigned int min,
+				 unsigned int max, unsigned int relation);
 int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 		unsigned int freq);
 
@@ -836,12 +839,12 @@ static inline int cpufreq_table_find_index_dl(struct cpufreq_policy *policy,
 	return best;
 }
 
-/* Works only on sorted freq-tables */
-static inline int cpufreq_table_find_index_l(struct cpufreq_policy *policy,
-					     unsigned int target_freq,
-					     bool efficiencies)
+static inline int find_index_l(struct cpufreq_policy *policy,
+			       unsigned int target_freq,
+			       unsigned int min, unsigned int max,
+			       bool efficiencies)
 {
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	target_freq = clamp_val(target_freq, min, max);
 
 	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
 		return cpufreq_table_find_index_al(policy, target_freq,
@@ -851,6 +854,14 @@ static inline int cpufreq_table_find_index_l(struct cpufreq_policy *policy,
 						   efficiencies);
 }
 
+/* Works only on sorted freq-tables */
+static inline int cpufreq_table_find_index_l(struct cpufreq_policy *policy,
+					     unsigned int target_freq,
+					     bool efficiencies)
+{
+	return find_index_l(policy, target_freq, policy->min, policy->max, efficiencies);
+}
+
 /* Find highest freq at or below target in a table in ascending order */
 static inline int cpufreq_table_find_index_ah(struct cpufreq_policy *policy,
 					      unsigned int target_freq,
@@ -904,12 +915,12 @@ static inline int cpufreq_table_find_index_dh(struct cpufreq_policy *policy,
 	return best;
 }
 
-/* Works only on sorted freq-tables */
-static inline int cpufreq_table_find_index_h(struct cpufreq_policy *policy,
-					     unsigned int target_freq,
-					     bool efficiencies)
+static inline int find_index_h(struct cpufreq_policy *policy,
+			       unsigned int target_freq,
+			       unsigned int min, unsigned int max,
+			       bool efficiencies)
 {
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	target_freq = clamp_val(target_freq, min, max);
 
 	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
 		return cpufreq_table_find_index_ah(policy, target_freq,
@@ -919,6 +930,14 @@ static inline int cpufreq_table_find_index_h(struct cpufreq_policy *policy,
 						   efficiencies);
 }
 
+/* Works only on sorted freq-tables */
+static inline int cpufreq_table_find_index_h(struct cpufreq_policy *policy,
+					     unsigned int target_freq,
+					     bool efficiencies)
+{
+	return find_index_h(policy, target_freq, policy->min, policy->max, efficiencies);
+}
+
 /* Find closest freq to target in a table in ascending order */
 static inline int cpufreq_table_find_index_ac(struct cpufreq_policy *policy,
 					      unsigned int target_freq,
@@ -989,12 +1008,12 @@ static inline int cpufreq_table_find_index_dc(struct cpufreq_policy *policy,
 	return best;
 }
 
-/* Works only on sorted freq-tables */
-static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
-					     unsigned int target_freq,
-					     bool efficiencies)
+static inline int find_index_c(struct cpufreq_policy *policy,
+			       unsigned int target_freq,
+			       unsigned int min, unsigned int max,
+			       bool efficiencies)
 {
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	target_freq = clamp_val(target_freq, min, max);
 
 	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
 		return cpufreq_table_find_index_ac(policy, target_freq,
@@ -1004,7 +1023,17 @@ static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
 						   efficiencies);
 }
 
-static inline bool cpufreq_is_in_limits(struct cpufreq_policy *policy, int idx)
+/* Works only on sorted freq-tables */
+static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
+					     unsigned int target_freq,
+					     bool efficiencies)
+{
+	return find_index_c(policy, target_freq, policy->min, policy->max, efficiencies);
+}
+
+static inline bool cpufreq_is_in_limits(struct cpufreq_policy *policy,
+					unsigned int min, unsigned int max,
+					int idx)
 {
 	unsigned int freq;
 
@@ -1013,11 +1042,13 @@ static inline bool cpufreq_is_in_limits(struct cpufreq_policy *policy, int idx)
 
 	freq = policy->freq_table[idx].frequency;
 
-	return freq == clamp_val(freq, policy->min, policy->max);
+	return freq == clamp_val(freq, min, max);
 }
 
 static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 						 unsigned int target_freq,
+						 unsigned int min,
+						 unsigned int max,
 						 unsigned int relation)
 {
 	bool efficiencies = policy->efficiencies_available &&
@@ -1028,29 +1059,26 @@ static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 	relation &= ~CPUFREQ_RELATION_E;
 
 	if (unlikely(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED))
-		return cpufreq_table_index_unsorted(policy, target_freq,
-						    relation);
+		return cpufreq_table_index_unsorted(policy, target_freq, min,
+						    max, relation);
 retry:
 	switch (relation) {
 	case CPUFREQ_RELATION_L:
-		idx = cpufreq_table_find_index_l(policy, target_freq,
-						 efficiencies);
+		idx = find_index_l(policy, target_freq, min, max, efficiencies);
 		break;
 	case CPUFREQ_RELATION_H:
-		idx = cpufreq_table_find_index_h(policy, target_freq,
-						 efficiencies);
+		idx = find_index_h(policy, target_freq, min, max, efficiencies);
 		break;
 	case CPUFREQ_RELATION_C:
-		idx = cpufreq_table_find_index_c(policy, target_freq,
-						 efficiencies);
+		idx = find_index_c(policy, target_freq, min, max, efficiencies);
 		break;
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
 	}
 
-	/* Limit frequency index to honor policy->min/max */
-	if (!cpufreq_is_in_limits(policy, idx) && efficiencies) {
+	/* Limit frequency index to honor min and max */
+	if (!cpufreq_is_in_limits(policy, min, max, idx) && efficiencies) {
 		efficiencies = false;
 		goto retry;
 	}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 38c65e92ecd0..87cbe47b323e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -425,10 +425,10 @@ static inline int __iommu_copy_struct_from_user(
 	void *dst_data, const struct iommu_user_data *src_data,
 	unsigned int data_type, size_t data_len, size_t min_len)
 {
-	if (src_data->type != data_type)
-		return -EINVAL;
 	if (WARN_ON(!dst_data || !src_data))
 		return -EINVAL;
+	if (src_data->type != data_type)
+		return -EINVAL;
 	if (src_data->len < min_len || data_len < src_data->len)
 		return -EINVAL;
 	return copy_struct_from_user(dst_data, data_len, src_data->uptr,
@@ -441,8 +441,8 @@ static inline int __iommu_copy_struct_from_user(
  *        include/uapi/linux/iommufd.h
  * @user_data: Pointer to a struct iommu_user_data for user space data info
  * @data_type: The data type of the @kdst. Must match with @user_data->type
- * @min_last: The last memember of the data structure @kdst points in the
- *            initial version.
+ * @min_last: The last member of the data structure @kdst points in the initial
+ *            version.
  * Return 0 for success, otherwise -error.
  */
 #define iommu_copy_struct_from_user(kdst, user_data, data_type, min_last) \
diff --git a/include/linux/module.h b/include/linux/module.h
index 30e5b19bafa9..ba33bba3cc74 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -162,6 +162,8 @@ extern void cleanup_module(void);
 #define __INITRODATA_OR_MODULE __INITRODATA
 #endif /*CONFIG_MODULES*/
 
+struct module_kobject *lookup_or_create_module_kobject(const char *name);
+
 /* Generic info of form tag = "info" */
 #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a8586c3058c7..797992019f9e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1931,6 +1931,8 @@ struct hci_cp_le_pa_create_sync {
 	__u8      sync_cte_type;
 } __packed;
 
+#define HCI_OP_LE_PA_CREATE_SYNC_CANCEL	0x2045
+
 #define HCI_OP_LE_PA_TERM_SYNC		0x2046
 struct hci_cp_le_pa_term_sync {
 	__le16    handle;
@@ -2830,7 +2832,7 @@ struct hci_evt_le_create_big_complete {
 	__le16  bis_handle[];
 } __packed;
 
-#define HCI_EVT_LE_BIG_SYNC_ESTABILISHED 0x1d
+#define HCI_EVT_LE_BIG_SYNC_ESTABLISHED 0x1d
 struct hci_evt_le_big_sync_estabilished {
 	__u8    status;
 	__u8    handle;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f0b49aad519e..7d8bab892154 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1105,10 +1105,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_bis(struct hci_dev *hdev,
 	return NULL;
 }
 
-static inline struct hci_conn *hci_conn_hash_lookup_sid(struct hci_dev *hdev,
-							__u8 sid,
-							bdaddr_t *dst,
-							__u8 dst_type)
+static inline struct hci_conn *
+hci_conn_hash_lookup_create_pa_sync(struct hci_dev *hdev)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
@@ -1116,8 +1114,10 @@ static inline struct hci_conn *hci_conn_hash_lookup_sid(struct hci_dev *hdev,
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != ISO_LINK  || bacmp(&c->dst, dst) ||
-		    c->dst_type != dst_type || c->sid != sid)
+		if (c->type != ISO_LINK)
+			continue;
+
+		if (!test_bit(HCI_CONN_CREATE_PA_SYNC, &c->flags))
 			continue;
 
 		rcu_read_unlock();
@@ -1516,8 +1516,6 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
 bool hci_iso_setup_path(struct hci_conn *conn);
 int hci_le_create_cis_pending(struct hci_dev *hdev);
-int hci_pa_create_sync_pending(struct hci_dev *hdev);
-int hci_le_big_create_sync_pending(struct hci_dev *hdev);
 int hci_conn_check_create_cis(struct hci_conn *conn);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
@@ -1558,9 +1556,9 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 data_len, __u8 *data);
 struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 		       __u8 dst_type, __u8 sid, struct bt_iso_qos *qos);
-int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
-			   struct bt_iso_qos *qos,
-			   __u16 sync_handle, __u8 num_bis, __u8 bis[]);
+int hci_conn_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
+			     struct bt_iso_qos *qos, __u16 sync_handle,
+			     __u8 num_bis, __u8 bis[]);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 7e2cf0cca939..72558c826aa1 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -185,3 +185,6 @@ int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 			    struct hci_conn_params *params);
+
+int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn);
+int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn);
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index a58ae7589d12..e8bd6ddb7b12 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -71,9 +71,6 @@ struct xdp_sock {
 	 */
 	u32 tx_budget_spent;
 
-	/* Protects generic receive. */
-	spinlock_t rx_lock;
-
 	/* Statistics */
 	u64 rx_dropped;
 	u64 rx_queue_full;
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 50779406bc2d..b3699a848844 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -53,6 +53,8 @@ struct xsk_buff_pool {
 	refcount_t users;
 	struct xdp_umem *umem;
 	struct work_struct work;
+	/* Protects generic receive in shared and non-shared umem mode. */
+	spinlock_t rx_lock;
 	struct list_head free_list;
 	struct list_head xskb_list;
 	u32 heads_cnt;
@@ -230,8 +232,8 @@ static inline u64 xp_get_handle(struct xdp_buff_xsk *xskb,
 		return orig_addr;
 
 	offset = xskb->xdp.data - xskb->xdp.data_hard_start;
-	orig_addr -= offset;
 	offset += pool->headroom;
+	orig_addr -= offset;
 	return orig_addr + (offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT);
 }
 
diff --git a/include/sound/ump_convert.h b/include/sound/ump_convert.h
index d099ae27f849..682499b871ea 100644
--- a/include/sound/ump_convert.h
+++ b/include/sound/ump_convert.h
@@ -19,7 +19,7 @@ struct ump_cvt_to_ump_bank {
 /* context for converting from MIDI1 byte stream to UMP packet */
 struct ump_cvt_to_ump {
 	/* MIDI1 intermediate buffer */
-	unsigned char buf[4];
+	unsigned char buf[6]; /* up to 6 bytes for SysEx */
 	int len;
 	int cmd_bytes;
 
diff --git a/kernel/params.c b/kernel/params.c
index 0074d29c9b80..c417d28bc1df 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -763,7 +763,7 @@ void destroy_params(const struct kernel_param *params, unsigned num)
 			params[i].ops->free(params[i].arg);
 }
 
-static struct module_kobject * __init locate_module_kobject(const char *name)
+struct module_kobject __modinit * lookup_or_create_module_kobject(const char *name)
 {
 	struct module_kobject *mk;
 	struct kobject *kobj;
@@ -805,7 +805,7 @@ static void __init kernel_add_sysfs_param(const char *name,
 	struct module_kobject *mk;
 	int err;
 
-	mk = locate_module_kobject(name);
+	mk = lookup_or_create_module_kobject(name);
 	if (!mk)
 		return;
 
@@ -876,7 +876,7 @@ static void __init version_sysfs_builtin(void)
 	int err;
 
 	for (vattr = __start___modver; vattr < __stop___modver; vattr++) {
-		mk = locate_module_kobject(vattr->module_name);
+		mk = lookup_or_create_module_kobject(vattr->module_name);
 		if (mk) {
 			err = sysfs_create_file(&mk->kobj, &vattr->mattr.attr);
 			WARN_ON_ONCE(err);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 50aa6d590832..814626bb410b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6682,13 +6682,14 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 		/* Copy the data into the page, so we can start over. */
 		ret = trace_seq_to_buffer(&iter->seq,
 					  page_address(spd.pages[i]),
-					  trace_seq_used(&iter->seq));
+					  min((size_t)trace_seq_used(&iter->seq),
+						  PAGE_SIZE));
 		if (ret < 0) {
 			__free_page(spd.pages[i]);
 			break;
 		}
 		spd.partial[i].offset = 0;
-		spd.partial[i].len = trace_seq_used(&iter->seq);
+		spd.partial[i].len = ret;
 
 		trace_seq_init(&iter->seq);
 	}
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 03d56f711ad1..358bbebbab50 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -961,11 +961,12 @@ enum print_line_t print_event_fields(struct trace_iterator *iter,
 	struct trace_event_call *call;
 	struct list_head *head;
 
+	lockdep_assert_held_read(&trace_event_sem);
+
 	/* ftrace defined events have separate call structures */
 	if (event->type <= __TRACE_LAST_TYPE) {
 		bool found = false;
 
-		down_read(&trace_event_sem);
 		list_for_each_entry(call, &ftrace_events, list) {
 			if (call->event.type == event->type) {
 				found = true;
@@ -975,7 +976,6 @@ enum print_line_t print_event_fields(struct trace_iterator *iter,
 			if (call->event.type > __TRACE_LAST_TYPE)
 				break;
 		}
-		up_read(&trace_event_sem);
 		if (!found) {
 			trace_seq_printf(&iter->seq, "UNKNOWN TYPE %d\n", event->type);
 			goto out;
diff --git a/mm/memblock.c b/mm/memblock.c
index 95af35fd1389..9c2df1c60948 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2180,11 +2180,14 @@ static void __init memmap_init_reserved_pages(void)
 	struct memblock_region *region;
 	phys_addr_t start, end;
 	int nid;
+	unsigned long max_reserved;
 
 	/*
 	 * set nid on all reserved pages and also treat struct
 	 * pages for the NOMAP regions as PageReserved
 	 */
+repeat:
+	max_reserved = memblock.reserved.max;
 	for_each_mem_region(region) {
 		nid = memblock_get_region_node(region);
 		start = region->base;
@@ -2193,8 +2196,15 @@ static void __init memmap_init_reserved_pages(void)
 		if (memblock_is_nomap(region))
 			reserve_bootmem_region(start, end, nid);
 
-		memblock_set_node(start, end, &memblock.reserved, nid);
+		memblock_set_node(start, region->size, &memblock.reserved, nid);
 	}
+	/*
+	 * 'max' is changed means memblock.reserved has been doubled its
+	 * array, which may result a new reserved region before current
+	 * 'start'. Now we should repeat the procedure to set its node id.
+	 */
+	if (max_reserved != memblock.reserved.max)
+		goto repeat;
 
 	/*
 	 * initialize struct pages for reserved regions that don't have
diff --git a/mm/slub.c b/mm/slub.c
index 96babca6b330..87f3edf9acb8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2025,18 +2025,6 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	slab->obj_exts = 0;
 }
 
-static inline bool need_slab_obj_ext(void)
-{
-	if (mem_alloc_profiling_enabled())
-		return true;
-
-	/*
-	 * CONFIG_MEMCG creates vector of obj_cgroup objects conditionally
-	 * inside memcg_slab_post_alloc_hook. No other users for now.
-	 */
-	return false;
-}
-
 #else /* CONFIG_SLAB_OBJ_EXT */
 
 static inline void init_slab_obj_exts(struct slab *slab)
@@ -2053,11 +2041,6 @@ static inline void free_slab_obj_exts(struct slab *slab)
 {
 }
 
-static inline bool need_slab_obj_ext(void)
-{
-	return false;
-}
-
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
@@ -2089,7 +2072,7 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 static inline void
 alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 {
-	if (need_slab_obj_ext()) {
+	if (mem_alloc_profiling_enabled()) {
 		struct slabobj_ext *obj_exts;
 
 		obj_exts = prepare_slab_obj_exts_hook(s, flags, object);
@@ -2565,8 +2548,12 @@ static __always_inline void account_slab(struct slab *slab, int order,
 static __always_inline void unaccount_slab(struct slab *slab, int order,
 					   struct kmem_cache *s)
 {
-	if (memcg_kmem_online() || need_slab_obj_ext())
-		free_slab_obj_exts(slab);
+	/*
+	 * The slab object extensions should now be freed regardless of
+	 * whether mem_alloc_profiling_enabled() or not because profiling
+	 * might have been disabled after slab->obj_exts got allocated.
+	 */
+	free_slab_obj_exts(slab);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
 			    -(PAGE_SIZE << order));
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d097e308a755..ae66fa0a5fb5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2061,95 +2061,6 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 	return hci_le_create_big(conn, &conn->iso_qos);
 }
 
-static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
-{
-	bt_dev_dbg(hdev, "");
-
-	if (err)
-		bt_dev_err(hdev, "Unable to create PA: %d", err);
-}
-
-static bool hci_conn_check_create_pa_sync(struct hci_conn *conn)
-{
-	if (conn->type != ISO_LINK || conn->sid == HCI_SID_INVALID)
-		return false;
-
-	return true;
-}
-
-static int create_pa_sync(struct hci_dev *hdev, void *data)
-{
-	struct hci_cp_le_pa_create_sync cp = {0};
-	struct hci_conn *conn;
-	int err = 0;
-
-	hci_dev_lock(hdev);
-
-	rcu_read_lock();
-
-	/* The spec allows only one pending LE Periodic Advertising Create
-	 * Sync command at a time. If the command is pending now, don't do
-	 * anything. We check for pending connections after each PA Sync
-	 * Established event.
-	 *
-	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
-	 * page 2493:
-	 *
-	 * If the Host issues this command when another HCI_LE_Periodic_
-	 * Advertising_Create_Sync command is pending, the Controller shall
-	 * return the error code Command Disallowed (0x0C).
-	 */
-	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (test_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags))
-			goto unlock;
-	}
-
-	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (hci_conn_check_create_pa_sync(conn)) {
-			struct bt_iso_qos *qos = &conn->iso_qos;
-
-			cp.options = qos->bcast.options;
-			cp.sid = conn->sid;
-			cp.addr_type = conn->dst_type;
-			bacpy(&cp.addr, &conn->dst);
-			cp.skip = cpu_to_le16(qos->bcast.skip);
-			cp.sync_timeout = cpu_to_le16(qos->bcast.sync_timeout);
-			cp.sync_cte_type = qos->bcast.sync_cte_type;
-
-			break;
-		}
-	}
-
-unlock:
-	rcu_read_unlock();
-
-	hci_dev_unlock(hdev);
-
-	if (bacmp(&cp.addr, BDADDR_ANY)) {
-		hci_dev_set_flag(hdev, HCI_PA_SYNC);
-		set_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
-
-		err = __hci_cmd_sync_status(hdev, HCI_OP_LE_PA_CREATE_SYNC,
-					    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
-		if (!err)
-			err = hci_update_passive_scan_sync(hdev);
-
-		if (err) {
-			hci_dev_clear_flag(hdev, HCI_PA_SYNC);
-			clear_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
-		}
-	}
-
-	return err;
-}
-
-int hci_pa_create_sync_pending(struct hci_dev *hdev)
-{
-	/* Queue start pa_create_sync and scan */
-	return hci_cmd_sync_queue(hdev, create_pa_sync,
-				  NULL, create_pa_complete);
-}
-
 struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 				    __u8 dst_type, __u8 sid,
 				    struct bt_iso_qos *qos)
@@ -2164,97 +2075,18 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->dst_type = dst_type;
 	conn->sid = sid;
 	conn->state = BT_LISTEN;
+	conn->conn_timeout = msecs_to_jiffies(qos->bcast.sync_timeout * 10);
 
 	hci_conn_hold(conn);
 
-	hci_pa_create_sync_pending(hdev);
+	hci_connect_pa_sync(hdev, conn);
 
 	return conn;
 }
 
-static bool hci_conn_check_create_big_sync(struct hci_conn *conn)
-{
-	if (!conn->num_bis)
-		return false;
-
-	return true;
-}
-
-static void big_create_sync_complete(struct hci_dev *hdev, void *data, int err)
-{
-	bt_dev_dbg(hdev, "");
-
-	if (err)
-		bt_dev_err(hdev, "Unable to create BIG sync: %d", err);
-}
-
-static int big_create_sync(struct hci_dev *hdev, void *data)
-{
-	DEFINE_FLEX(struct hci_cp_le_big_create_sync, pdu, bis, num_bis, 0x11);
-	struct hci_conn *conn;
-
-	rcu_read_lock();
-
-	pdu->num_bis = 0;
-
-	/* The spec allows only one pending LE BIG Create Sync command at
-	 * a time. If the command is pending now, don't do anything. We
-	 * check for pending connections after each BIG Sync Established
-	 * event.
-	 *
-	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
-	 * page 2586:
-	 *
-	 * If the Host sends this command when the Controller is in the
-	 * process of synchronizing to any BIG, i.e. the HCI_LE_BIG_Sync_
-	 * Established event has not been generated, the Controller shall
-	 * return the error code Command Disallowed (0x0C).
-	 */
-	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (test_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags))
-			goto unlock;
-	}
-
-	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (hci_conn_check_create_big_sync(conn)) {
-			struct bt_iso_qos *qos = &conn->iso_qos;
-
-			set_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
-
-			pdu->handle = qos->bcast.big;
-			pdu->sync_handle = cpu_to_le16(conn->sync_handle);
-			pdu->encryption = qos->bcast.encryption;
-			memcpy(pdu->bcode, qos->bcast.bcode,
-			       sizeof(pdu->bcode));
-			pdu->mse = qos->bcast.mse;
-			pdu->timeout = cpu_to_le16(qos->bcast.timeout);
-			pdu->num_bis = conn->num_bis;
-			memcpy(pdu->bis, conn->bis, conn->num_bis);
-
-			break;
-		}
-	}
-
-unlock:
-	rcu_read_unlock();
-
-	if (!pdu->num_bis)
-		return 0;
-
-	return hci_send_cmd(hdev, HCI_OP_LE_BIG_CREATE_SYNC,
-			    struct_size(pdu, bis, pdu->num_bis), pdu);
-}
-
-int hci_le_big_create_sync_pending(struct hci_dev *hdev)
-{
-	/* Queue big_create_sync */
-	return hci_cmd_sync_queue_once(hdev, big_create_sync,
-				       NULL, big_create_sync_complete);
-}
-
-int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
-			   struct bt_iso_qos *qos,
-			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
+int hci_conn_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
+			     struct bt_iso_qos *qos, __u16 sync_handle,
+			     __u8 num_bis, __u8 bis[])
 {
 	int err;
 
@@ -2271,9 +2103,10 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 
 		hcon->num_bis = num_bis;
 		memcpy(hcon->bis, bis, num_bis);
+		hcon->conn_timeout = msecs_to_jiffies(qos->bcast.timeout * 10);
 	}
 
-	return hci_le_big_create_sync_pending(hdev);
+	return hci_connect_big_sync(hdev, hcon);
 }
 
 static void create_big_complete(struct hci_dev *hdev, void *data, int err)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 20d3cdcb14f6..ab940ec698c0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6371,8 +6371,7 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
 
-	conn = hci_conn_hash_lookup_sid(hdev, ev->sid, &ev->bdaddr,
-					ev->bdaddr_type);
+	conn = hci_conn_hash_lookup_create_pa_sync(hdev);
 	if (!conn) {
 		bt_dev_err(hdev,
 			   "Unable to find connection for dst %pMR sid 0x%2.2x",
@@ -6411,9 +6410,6 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 	}
 
 unlock:
-	/* Handle any other pending PA sync command */
-	hci_pa_create_sync_pending(hdev);
-
 	hci_dev_unlock(hdev);
 }
 
@@ -6925,7 +6921,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
-	if (!hci_le_ev_skb_pull(hdev, skb, HCI_EVT_LE_BIG_SYNC_ESTABILISHED,
+	if (!hci_le_ev_skb_pull(hdev, skb, HCI_EVT_LE_BIG_SYNC_ESTABLISHED,
 				flex_array_size(ev, bis, ev->num_bis)))
 		return;
 
@@ -6996,9 +6992,6 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 		}
 
 unlock:
-	/* Handle any other pending BIG sync command */
-	hci_le_big_create_sync_pending(hdev);
-
 	hci_dev_unlock(hdev);
 }
 
@@ -7120,8 +7113,8 @@ static const struct hci_le_ev {
 		     hci_le_create_big_complete_evt,
 		     sizeof(struct hci_evt_le_create_big_complete),
 		     HCI_MAX_EVENT_SIZE),
-	/* [0x1d = HCI_EV_LE_BIG_SYNC_ESTABILISHED] */
-	HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_ESTABILISHED,
+	/* [0x1d = HCI_EV_LE_BIG_SYNC_ESTABLISHED] */
+	HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_ESTABLISHED,
 		     hci_le_big_sync_established_evt,
 		     sizeof(struct hci_evt_le_big_sync_estabilished),
 		     HCI_MAX_EVENT_SIZE),
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 14c3ee5c6a1e..85c6ac082bfc 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2693,16 +2693,16 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 
 	/* Force address filtering if PA Sync is in progress */
 	if (hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
-		struct hci_cp_le_pa_create_sync *sent;
+		struct hci_conn *conn;
 
-		sent = hci_sent_cmd_data(hdev, HCI_OP_LE_PA_CREATE_SYNC);
-		if (sent) {
+		conn = hci_conn_hash_lookup_create_pa_sync(hdev);
+		if (conn) {
 			struct conn_params pa;
 
 			memset(&pa, 0, sizeof(pa));
 
-			bacpy(&pa.addr, &sent->addr);
-			pa.addr_type = sent->addr_type;
+			bacpy(&pa.addr, &conn->dst);
+			pa.addr_type = conn->dst_type;
 
 			/* Clear first since there could be addresses left
 			 * behind.
@@ -6895,3 +6895,143 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CONN_UPDATE,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
+
+static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
+{
+	bt_dev_dbg(hdev, "err %d", err);
+
+	if (!err)
+		return;
+
+	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
+
+	if (err == -ECANCELED)
+		return;
+
+	hci_dev_lock(hdev);
+
+	hci_update_passive_scan_sync(hdev);
+
+	hci_dev_unlock(hdev);
+}
+
+static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_cp_le_pa_create_sync cp;
+	struct hci_conn *conn = data;
+	struct bt_iso_qos *qos = &conn->iso_qos;
+	int err;
+
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
+	if (hci_dev_test_and_set_flag(hdev, HCI_PA_SYNC))
+		return -EBUSY;
+
+	/* Mark HCI_CONN_CREATE_PA_SYNC so hci_update_passive_scan_sync can
+	 * program the address in the allow list so PA advertisements can be
+	 * received.
+	 */
+	set_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
+
+	hci_update_passive_scan_sync(hdev);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.options = qos->bcast.options;
+	cp.sid = conn->sid;
+	cp.addr_type = conn->dst_type;
+	bacpy(&cp.addr, &conn->dst);
+	cp.skip = cpu_to_le16(qos->bcast.skip);
+	cp.sync_timeout = cpu_to_le16(qos->bcast.sync_timeout);
+	cp.sync_cte_type = qos->bcast.sync_cte_type;
+
+	/* The spec allows only one pending LE Periodic Advertising Create
+	 * Sync command at a time so we forcefully wait for PA Sync Established
+	 * event since cmd_work can only schedule one command at a time.
+	 *
+	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+	 * page 2493:
+	 *
+	 * If the Host issues this command when another HCI_LE_Periodic_
+	 * Advertising_Create_Sync command is pending, the Controller shall
+	 * return the error code Command Disallowed (0x0C).
+	 */
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_PA_CREATE_SYNC,
+				       sizeof(cp), &cp,
+				       HCI_EV_LE_PA_SYNC_ESTABLISHED,
+				       conn->conn_timeout, NULL);
+	if (err == -ETIMEDOUT)
+		__hci_cmd_sync_status(hdev, HCI_OP_LE_PA_CREATE_SYNC_CANCEL,
+				      0, NULL, HCI_CMD_TIMEOUT);
+
+	return err;
+}
+
+int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	return hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync, conn,
+				       create_pa_complete);
+}
+
+static void create_big_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct hci_conn *conn = data;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	if (err == -ECANCELED)
+		return;
+
+	if (hci_conn_valid(hdev, conn))
+		clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+}
+
+static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
+{
+	DEFINE_FLEX(struct hci_cp_le_big_create_sync, cp, bis, num_bis, 0x11);
+	struct hci_conn *conn = data;
+	struct bt_iso_qos *qos = &conn->iso_qos;
+	int err;
+
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
+	set_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+
+	memset(cp, 0, sizeof(*cp));
+	cp->handle = qos->bcast.big;
+	cp->sync_handle = cpu_to_le16(conn->sync_handle);
+	cp->encryption = qos->bcast.encryption;
+	memcpy(cp->bcode, qos->bcast.bcode, sizeof(cp->bcode));
+	cp->mse = qos->bcast.mse;
+	cp->timeout = cpu_to_le16(qos->bcast.timeout);
+	cp->num_bis = conn->num_bis;
+	memcpy(cp->bis, conn->bis, conn->num_bis);
+
+	/* The spec allows only one pending LE BIG Create Sync command at
+	 * a time, so we forcefully wait for BIG Sync Established event since
+	 * cmd_work can only schedule one command at a time.
+	 *
+	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+	 * page 2586:
+	 *
+	 * If the Host sends this command when the Controller is in the
+	 * process of synchronizing to any BIG, i.e. the HCI_LE_BIG_Sync_
+	 * Established event has not been generated, the Controller shall
+	 * return the error code Command Disallowed (0x0C).
+	 */
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_BIG_CREATE_SYNC,
+				       struct_size(cp, bis, cp->num_bis), cp,
+				       HCI_EVT_LE_BIG_SYNC_ESTABLISHED,
+				       conn->conn_timeout, NULL);
+	if (err == -ETIMEDOUT)
+		hci_le_big_terminate_sync(hdev, cp->handle);
+
+	return err;
+}
+
+int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	return hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn,
+				       create_big_complete);
+}
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 0cb52a3308ba..491efb327b5b 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1450,14 +1450,13 @@ static void iso_conn_big_sync(struct sock *sk)
 	lock_sock(sk);
 
 	if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
-		err = hci_le_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
-					     &iso_pi(sk)->qos,
-					     iso_pi(sk)->sync_handle,
-					     iso_pi(sk)->bc_num_bis,
-					     iso_pi(sk)->bc_bis);
+		err = hci_conn_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
+					       &iso_pi(sk)->qos,
+					       iso_pi(sk)->sync_handle,
+					       iso_pi(sk)->bc_num_bis,
+					       iso_pi(sk)->bc_bis);
 		if (err)
-			bt_dev_err(hdev, "hci_le_big_create_sync: %d",
-				   err);
+			bt_dev_err(hdev, "hci_big_create_sync: %d", err);
 	}
 
 	release_sock(sk);
@@ -1906,7 +1905,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 					      hcon);
 		} else if (test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
 			ev = hci_recv_event_data(hcon->hdev,
-						 HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
+						 HCI_EVT_LE_BIG_SYNC_ESTABLISHED);
 
 			/* Get reference to PA sync parent socket, if it exists */
 			parent = iso_get_sock(&hcon->src, &hcon->dst,
@@ -2097,12 +2096,11 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 			if (!test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
 			    !test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
-				err = hci_le_big_create_sync(hdev,
-							     hcon,
-							     &iso_pi(sk)->qos,
-							     iso_pi(sk)->sync_handle,
-							     iso_pi(sk)->bc_num_bis,
-							     iso_pi(sk)->bc_bis);
+				err = hci_conn_big_create_sync(hdev, hcon,
+							       &iso_pi(sk)->qos,
+							       iso_pi(sk)->sync_handle,
+							       iso_pi(sk)->bc_num_bis,
+							       iso_pi(sk)->bc_bis);
 				if (err) {
 					bt_dev_err(hdev, "hci_le_big_create_sync: %d",
 						   err);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a55388fbf07c..c219a8c596d3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7380,6 +7380,9 @@ static int l2cap_recv_frag(struct l2cap_conn *conn, struct sk_buff *skb,
 			return -ENOMEM;
 		/* Init rx_len */
 		conn->rx_len = len;
+
+		skb_set_delivery_time(conn->rx_skb, skb->tstamp,
+				      skb->tstamp_type);
 	}
 
 	/* Copy as much as the rx_skb can hold */
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2dfac79dc78b..e04ebe651c33 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -435,7 +435,7 @@ static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 				       iif, sdif);
 	NAPI_GRO_CB(skb)->is_flist = !sk;
 	if (sk)
-		sock_put(sk);
+		sock_gen_put(sk);
 }
 
 INDIRECT_CALLABLE_SCOPE
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index ecfca59f31f1..da5d4aea1b59 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -247,6 +247,62 @@ static struct sk_buff *__udpv4_gso_segment_list_csum(struct sk_buff *segs)
 	return segs;
 }
 
+static void __udpv6_gso_segment_csum(struct sk_buff *seg,
+				     struct in6_addr *oldip,
+				     const struct in6_addr *newip,
+				     __be16 *oldport, __be16 newport)
+{
+	struct udphdr *uh = udp_hdr(seg);
+
+	if (ipv6_addr_equal(oldip, newip) && *oldport == newport)
+		return;
+
+	if (uh->check) {
+		inet_proto_csum_replace16(&uh->check, seg, oldip->s6_addr32,
+					  newip->s6_addr32, true);
+
+		inet_proto_csum_replace2(&uh->check, seg, *oldport, newport,
+					 false);
+		if (!uh->check)
+			uh->check = CSUM_MANGLED_0;
+	}
+
+	*oldip = *newip;
+	*oldport = newport;
+}
+
+static struct sk_buff *__udpv6_gso_segment_list_csum(struct sk_buff *segs)
+{
+	const struct ipv6hdr *iph;
+	const struct udphdr *uh;
+	struct ipv6hdr *iph2;
+	struct sk_buff *seg;
+	struct udphdr *uh2;
+
+	seg = segs;
+	uh = udp_hdr(seg);
+	iph = ipv6_hdr(seg);
+	uh2 = udp_hdr(seg->next);
+	iph2 = ipv6_hdr(seg->next);
+
+	if (!(*(const u32 *)&uh->source ^ *(const u32 *)&uh2->source) &&
+	    ipv6_addr_equal(&iph->saddr, &iph2->saddr) &&
+	    ipv6_addr_equal(&iph->daddr, &iph2->daddr))
+		return segs;
+
+	while ((seg = seg->next)) {
+		uh2 = udp_hdr(seg);
+		iph2 = ipv6_hdr(seg);
+
+		__udpv6_gso_segment_csum(seg, &iph2->saddr, &iph->saddr,
+					 &uh2->source, uh->source);
+		__udpv6_gso_segment_csum(seg, &iph2->daddr, &iph->daddr,
+					 &uh2->dest, uh->dest);
+	}
+
+	return segs;
+}
+
 static struct sk_buff *__udp_gso_segment_list(struct sk_buff *skb,
 					      netdev_features_t features,
 					      bool is_ipv6)
@@ -259,7 +315,10 @@ static struct sk_buff *__udp_gso_segment_list(struct sk_buff *skb,
 
 	udp_hdr(skb)->len = htons(sizeof(struct udphdr) + mss);
 
-	return is_ipv6 ? skb : __udpv4_gso_segment_list_csum(skb);
+	if (is_ipv6)
+		return __udpv6_gso_segment_list_csum(skb);
+	else
+		return __udpv4_gso_segment_list_csum(skb);
 }
 
 struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index ae2da28f9dfb..5ab509a5fbdf 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -42,7 +42,7 @@ static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 					iif, sdif);
 	NAPI_GRO_CB(skb)->is_flist = !sk;
 	if (sk)
-		sock_put(sk);
+		sock_gen_put(sk);
 #endif /* IS_ENABLED(CONFIG_IPV6) */
 }
 
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index c69b999fae17..9b6d79bd8737 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -35,6 +35,11 @@ struct drr_sched {
 	struct Qdisc_class_hash		clhash;
 };
 
+static bool cl_is_active(struct drr_class *cl)
+{
+	return !list_empty(&cl->alist);
+}
+
 static struct drr_class *drr_find_class(struct Qdisc *sch, u32 classid)
 {
 	struct drr_sched *q = qdisc_priv(sch);
@@ -105,6 +110,7 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		return -ENOBUFS;
 
 	gnet_stats_basic_sync_init(&cl->bstats);
+	INIT_LIST_HEAD(&cl->alist);
 	cl->common.classid = classid;
 	cl->quantum	   = quantum;
 	cl->qdisc	   = qdisc_create_dflt(sch->dev_queue,
@@ -229,7 +235,7 @@ static void drr_qlen_notify(struct Qdisc *csh, unsigned long arg)
 {
 	struct drr_class *cl = (struct drr_class *)arg;
 
-	list_del(&cl->alist);
+	list_del_init(&cl->alist);
 }
 
 static int drr_dump_class(struct Qdisc *sch, unsigned long arg,
@@ -336,7 +342,6 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct drr_sched *q = qdisc_priv(sch);
 	struct drr_class *cl;
 	int err = 0;
-	bool first;
 
 	cl = drr_classify(skb, sch, &err);
 	if (cl == NULL) {
@@ -346,7 +351,6 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	first = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		if (net_xmit_drop_count(err)) {
@@ -356,7 +360,7 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	if (first) {
+	if (!cl_is_active(cl)) {
 		list_add_tail(&cl->alist, &q->active);
 		cl->deficit = cl->quantum;
 	}
@@ -390,7 +394,7 @@ static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 			if (unlikely(skb == NULL))
 				goto out;
 			if (cl->qdisc->q.qlen == 0)
-				list_del(&cl->alist);
+				list_del_init(&cl->alist);
 
 			bstats_update(&cl->bstats, skb);
 			qdisc_bstats_update(sch, skb);
@@ -431,7 +435,7 @@ static void drr_reset_qdisc(struct Qdisc *sch)
 	for (i = 0; i < q->clhash.hashsize; i++) {
 		hlist_for_each_entry(cl, &q->clhash.hash[i], common.hnode) {
 			if (cl->qdisc->q.qlen)
-				list_del(&cl->alist);
+				list_del_init(&cl->alist);
 			qdisc_reset(cl->qdisc);
 		}
 	}
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 516038a44163..2c069f0181c6 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -74,6 +74,11 @@ static const struct nla_policy ets_class_policy[TCA_ETS_MAX + 1] = {
 	[TCA_ETS_QUANTA_BAND] = { .type = NLA_U32 },
 };
 
+static bool cl_is_active(struct ets_class *cl)
+{
+	return !list_empty(&cl->alist);
+}
+
 static int ets_quantum_parse(struct Qdisc *sch, const struct nlattr *attr,
 			     unsigned int *quantum,
 			     struct netlink_ext_ack *extack)
@@ -293,7 +298,7 @@ static void ets_class_qlen_notify(struct Qdisc *sch, unsigned long arg)
 	 * to remove them.
 	 */
 	if (!ets_class_is_strict(q, cl) && sch->q.qlen)
-		list_del(&cl->alist);
+		list_del_init(&cl->alist);
 }
 
 static int ets_class_dump(struct Qdisc *sch, unsigned long arg,
@@ -416,7 +421,6 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct ets_sched *q = qdisc_priv(sch);
 	struct ets_class *cl;
 	int err = 0;
-	bool first;
 
 	cl = ets_classify(skb, sch, &err);
 	if (!cl) {
@@ -426,7 +430,6 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	first = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		if (net_xmit_drop_count(err)) {
@@ -436,7 +439,7 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	if (first && !ets_class_is_strict(q, cl)) {
+	if (!cl_is_active(cl) && !ets_class_is_strict(q, cl)) {
 		list_add_tail(&cl->alist, &q->active);
 		cl->deficit = cl->quantum;
 	}
@@ -488,7 +491,7 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 			if (unlikely(!skb))
 				goto out;
 			if (cl->qdisc->q.qlen == 0)
-				list_del(&cl->alist);
+				list_del_init(&cl->alist);
 			return ets_qdisc_dequeue_skb(sch, skb);
 		}
 
@@ -657,7 +660,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 	}
 	for (i = q->nbands; i < oldbands; i++) {
 		if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
-			list_del(&q->classes[i].alist);
+			list_del_init(&q->classes[i].alist);
 		qdisc_tree_flush_backlog(q->classes[i].qdisc);
 	}
 	WRITE_ONCE(q->nstrict, nstrict);
@@ -713,7 +716,7 @@ static void ets_qdisc_reset(struct Qdisc *sch)
 
 	for (band = q->nstrict; band < q->nbands; band++) {
 		if (q->classes[band].qdisc->q.qlen)
-			list_del(&q->classes[band].alist);
+			list_del_init(&q->classes[band].alist);
 	}
 	for (band = 0; band < q->nbands; band++)
 		qdisc_reset(q->classes[band].qdisc);
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 5bb4ab9941d6..cb8c525ea20e 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -203,7 +203,10 @@ eltree_insert(struct hfsc_class *cl)
 static inline void
 eltree_remove(struct hfsc_class *cl)
 {
-	rb_erase(&cl->el_node, &cl->sched->eligible);
+	if (!RB_EMPTY_NODE(&cl->el_node)) {
+		rb_erase(&cl->el_node, &cl->sched->eligible);
+		RB_CLEAR_NODE(&cl->el_node);
+	}
 }
 
 static inline void
@@ -1225,7 +1228,8 @@ hfsc_qlen_notify(struct Qdisc *sch, unsigned long arg)
 	/* vttree is now handled in update_vf() so that update_vf(cl, 0, 0)
 	 * needs to be called explicitly to remove a class from vttree.
 	 */
-	update_vf(cl, 0, 0);
+	if (cl->cl_nactive)
+		update_vf(cl, 0, 0);
 	if (cl->cl_flags & HFSC_RSC)
 		eltree_remove(cl);
 }
@@ -1565,7 +1569,7 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		return err;
 	}
 
-	if (first) {
+	if (first && !cl->cl_nactive) {
 		if (cl->cl_flags & HFSC_RSC)
 			init_ed(cl, len);
 		if (cl->cl_flags & HFSC_FSC)
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index c31bc5489bdd..4b9a639b642e 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1485,6 +1485,8 @@ static void htb_qlen_notify(struct Qdisc *sch, unsigned long arg)
 {
 	struct htb_class *cl = (struct htb_class *)arg;
 
+	if (!cl->prio_activity)
+		return;
 	htb_deactivate(qdisc_priv(sch), cl);
 }
 
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 6a07cdbdb9e1..42061d02c052 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -202,6 +202,11 @@ struct qfq_sched {
  */
 enum update_reason {enqueue, requeue};
 
+static bool cl_is_active(struct qfq_class *cl)
+{
+	return !list_empty(&cl->alist);
+}
+
 static struct qfq_class *qfq_find_class(struct Qdisc *sch, u32 classid)
 {
 	struct qfq_sched *q = qdisc_priv(sch);
@@ -347,7 +352,7 @@ static void qfq_deactivate_class(struct qfq_sched *q, struct qfq_class *cl)
 	struct qfq_aggregate *agg = cl->agg;
 
 
-	list_del(&cl->alist); /* remove from RR queue of the aggregate */
+	list_del_init(&cl->alist); /* remove from RR queue of the aggregate */
 	if (list_empty(&agg->active)) /* agg is now inactive */
 		qfq_deactivate_agg(q, agg);
 }
@@ -474,6 +479,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	gnet_stats_basic_sync_init(&cl->bstats);
 	cl->common.classid = classid;
 	cl->deficit = lmax;
+	INIT_LIST_HEAD(&cl->alist);
 
 	cl->qdisc = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
 				      classid, NULL);
@@ -982,7 +988,7 @@ static struct sk_buff *agg_dequeue(struct qfq_aggregate *agg,
 	cl->deficit -= (int) len;
 
 	if (cl->qdisc->q.qlen == 0) /* no more packets, remove from list */
-		list_del(&cl->alist);
+		list_del_init(&cl->alist);
 	else if (cl->deficit < qdisc_pkt_len(cl->qdisc->ops->peek(cl->qdisc))) {
 		cl->deficit += agg->lmax;
 		list_move_tail(&cl->alist, &agg->active);
@@ -1214,7 +1220,6 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct qfq_class *cl;
 	struct qfq_aggregate *agg;
 	int err = 0;
-	bool first;
 
 	cl = qfq_classify(skb, sch, &err);
 	if (cl == NULL) {
@@ -1236,7 +1241,6 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	gso_segs = skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
-	first = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		pr_debug("qfq_enqueue: enqueue failed %d\n", err);
@@ -1252,8 +1256,8 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	++sch->q.qlen;
 
 	agg = cl->agg;
-	/* if the queue was not empty, then done here */
-	if (!first) {
+	/* if the class is active, then done here */
+	if (cl_is_active(cl)) {
 		if (unlikely(skb == cl->qdisc->ops->peek(cl->qdisc)) &&
 		    list_first_entry(&agg->active, struct qfq_class, alist)
 		    == cl && cl->deficit < len)
@@ -1415,6 +1419,8 @@ static void qfq_qlen_notify(struct Qdisc *sch, unsigned long arg)
 	struct qfq_sched *q = qdisc_priv(sch);
 	struct qfq_class *cl = (struct qfq_class *)arg;
 
+	if (list_empty(&cl->alist))
+		return;
 	qfq_deactivate_class(q, cl);
 }
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index a373a7130d75..c13e13fa79fc 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -337,13 +337,14 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 	u32 len = xdp_get_buff_len(xdp);
 	int err;
 
-	spin_lock_bh(&xs->rx_lock);
 	err = xsk_rcv_check(xs, xdp, len);
 	if (!err) {
+		spin_lock_bh(&xs->pool->rx_lock);
 		err = __xsk_rcv(xs, xdp, len);
 		xsk_flush(xs);
+		spin_unlock_bh(&xs->pool->rx_lock);
 	}
-	spin_unlock_bh(&xs->rx_lock);
+
 	return err;
 }
 
@@ -1730,7 +1731,6 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 	xs = xdp_sk(sk);
 	xs->state = XSK_READY;
 	mutex_init(&xs->mutex);
-	spin_lock_init(&xs->rx_lock);
 
 	INIT_LIST_HEAD(&xs->map_list);
 	spin_lock_init(&xs->map_list_lock);
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index d158cb6dd391..63ae121d29e6 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -87,6 +87,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 	pool->addrs = umem->addrs;
 	pool->tx_metadata_len = umem->tx_metadata_len;
 	pool->tx_sw_csum = umem->flags & XDP_UMEM_TX_SW_CSUM;
+	spin_lock_init(&pool->rx_lock);
 	INIT_LIST_HEAD(&pool->free_list);
 	INIT_LIST_HEAD(&pool->xskb_list);
 	INIT_LIST_HEAD(&pool->xsk_tx_list);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 356df48c9730..2ff02fb6f7e9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -440,6 +440,10 @@ static void alc_fill_eapd_coef(struct hda_codec *codec)
 		alc_update_coef_idx(codec, 0x67, 0xf000, 0x3000);
 		fallthrough;
 	case 0x10ec0215:
+	case 0x10ec0236:
+	case 0x10ec0245:
+	case 0x10ec0256:
+	case 0x10ec0257:
 	case 0x10ec0285:
 	case 0x10ec0289:
 		alc_update_coef_idx(codec, 0x36, 1<<13, 0);
@@ -447,12 +451,8 @@ static void alc_fill_eapd_coef(struct hda_codec *codec)
 	case 0x10ec0230:
 	case 0x10ec0233:
 	case 0x10ec0235:
-	case 0x10ec0236:
-	case 0x10ec0245:
 	case 0x10ec0255:
-	case 0x10ec0256:
 	case 0x19e58326:
-	case 0x10ec0257:
 	case 0x10ec0282:
 	case 0x10ec0283:
 	case 0x10ec0286:
@@ -10713,8 +10713,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8caf, "HP Elite mt645 G8 Mobile Thin Client", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8cbd, "HP Pavilion Aero Laptop 13-bg0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
-	SND_PCI_QUIRK(0x103c, 0x8cdd, "HP Spectre", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8cde, "HP Spectre", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8cdd, "HP Spectre", ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX),
+	SND_PCI_QUIRK(0x103c, 0x8cde, "HP OmniBook Ultra Flip Laptop 14t", ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX),
 	SND_PCI_QUIRK(0x103c, 0x8cdf, "HP SnowWhite", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ce0, "HP SnowWhite", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
@@ -10732,8 +10732,11 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8de8, "HP Gemtree", ALC245_FIXUP_TAS2781_SPI_2),
 	SND_PCI_QUIRK(0x103c, 0x8de9, "HP Gemtree", ALC245_FIXUP_TAS2781_SPI_2),
 	SND_PCI_QUIRK(0x103c, 0x8dec, "HP EliteBook 640 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8ded, "HP EliteBook 640 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8dee, "HP EliteBook 660 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8def, "HP EliteBook 660 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8df0, "HP EliteBook 630 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8df1, "HP EliteBook 630 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e14, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
@@ -10771,10 +10774,10 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x12a3, "Asus N7691ZM", ALC269_FIXUP_ASUS_N7601ZM),
 	SND_PCI_QUIRK(0x1043, 0x12af, "ASUS UX582ZS", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x12b4, "ASUS B3405CCA / P3405CCA", ALC294_FIXUP_ASUS_CS35L41_SPI_2),
-	SND_PCI_QUIRK(0x1043, 0x12e0, "ASUS X541SA", ALC256_FIXUP_ASUS_MIC),
-	SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", ALC256_FIXUP_ASUS_MIC),
+	SND_PCI_QUIRK(0x1043, 0x12e0, "ASUS X541SA", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", ALC269VB_FIXUP_ASUS_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC),
+	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1433, "ASUS GX650PY/PZ/PV/PU/PYV/PZV/PIV/PVV", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1460, "Asus VivoBook 15", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
@@ -10828,7 +10831,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1c9f, "ASUS G614JU/JV/JI", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1caf, "ASUS G634JY/JZ/JI/JG", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
-	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1ccf, "ASUS G814JU/JV/JI", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1cdf, "ASUS G814JY/JZ/JG", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1cef, "ASUS G834JY/JZ/JI/JG", ALC285_FIXUP_ASUS_HEADSET_MIC),
diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index 89e99ed4275a..f631147fc63b 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -101,7 +101,7 @@ static int acp_i2s_set_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask, u32 rx_mas
 	struct acp_stream *stream;
 	int slot_len, no_of_slots;
 
-	chip = dev_get_platdata(dev);
+	chip = dev_get_drvdata(dev->parent);
 	switch (slot_width) {
 	case SLOT_WIDTH_8:
 		slot_len = 8;
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index ee35f3aa5521..0138cfabbb03 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -763,10 +763,9 @@ config SND_SOC_CS_AMP_LIB
 	tristate
 
 config SND_SOC_CS_AMP_LIB_TEST
-	tristate "KUnit test for Cirrus Logic cs-amp-lib"
-	depends on KUNIT
+	tristate "KUnit test for Cirrus Logic cs-amp-lib" if !KUNIT_ALL_TESTS
+	depends on SND_SOC_CS_AMP_LIB && KUNIT
 	default KUNIT_ALL_TESTS
-	select SND_SOC_CS_AMP_LIB
 	help
 	  This builds KUnit tests for the Cirrus Logic common
 	  amplifier library.
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 32efb30c55d6..8bd5b93f3457 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -1146,9 +1146,9 @@ void graph_util_parse_link_direction(struct device_node *np,
 	bool is_playback_only = of_property_read_bool(np, "playback-only");
 	bool is_capture_only  = of_property_read_bool(np, "capture-only");
 
-	if (is_playback_only)
+	if (playback_only)
 		*playback_only = is_playback_only;
-	if (is_capture_only)
+	if (capture_only)
 		*capture_only = is_capture_only;
 }
 EXPORT_SYMBOL_GPL(graph_util_parse_link_direction);
diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 3a0af4ca7ab6..0f7458a43901 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -1244,7 +1244,7 @@ static int rz_ssi_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops rz_ssi_pm_ops = {
 	RUNTIME_PM_OPS(rz_ssi_runtime_suspend, rz_ssi_runtime_resume, NULL)
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static struct platform_driver rz_ssi_driver = {
diff --git a/sound/soc/sdw_utils/soc_sdw_rt_dmic.c b/sound/soc/sdw_utils/soc_sdw_rt_dmic.c
index 46d917a99c51..97be110a59b6 100644
--- a/sound/soc/sdw_utils/soc_sdw_rt_dmic.c
+++ b/sound/soc/sdw_utils/soc_sdw_rt_dmic.c
@@ -29,6 +29,8 @@ int asoc_sdw_rt_dmic_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_da
 		mic_name = devm_kasprintf(card->dev, GFP_KERNEL, "rt715-sdca");
 	else
 		mic_name = devm_kasprintf(card->dev, GFP_KERNEL, "%s", component->name_prefix);
+	if (!mic_name)
+		return -ENOMEM;
 
 	card->components = devm_kasprintf(card->dev, GFP_KERNEL,
 					  "%s mic:%s", card->components,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3c6d8aef4130..26b34b688508 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3046,7 +3046,7 @@ int snd_soc_of_parse_pin_switches(struct snd_soc_card *card, const char *prop)
 	unsigned int i, nb_controls;
 	int ret;
 
-	if (!of_property_read_bool(dev->of_node, prop))
+	if (!of_property_present(dev->of_node, prop))
 		return 0;
 
 	strings = devm_kcalloc(dev, nb_controls_max,
@@ -3120,23 +3120,17 @@ int snd_soc_of_parse_tdm_slot(struct device_node *np,
 	if (rx_mask)
 		snd_soc_of_get_slot_mask(np, "dai-tdm-slot-rx-mask", rx_mask);
 
-	if (of_property_read_bool(np, "dai-tdm-slot-num")) {
-		ret = of_property_read_u32(np, "dai-tdm-slot-num", &val);
-		if (ret)
-			return ret;
-
-		if (slots)
-			*slots = val;
-	}
-
-	if (of_property_read_bool(np, "dai-tdm-slot-width")) {
-		ret = of_property_read_u32(np, "dai-tdm-slot-width", &val);
-		if (ret)
-			return ret;
+	ret = of_property_read_u32(np, "dai-tdm-slot-num", &val);
+	if (ret && ret != -EINVAL)
+		return ret;
+	if (!ret && slots)
+		*slots = val;
 
-		if (slot_width)
-			*slot_width = val;
-	}
+	ret = of_property_read_u32(np, "dai-tdm-slot-width", &val);
+	if (ret && ret != -EINVAL)
+		return ret;
+	if (!ret && slot_width)
+		*slot_width = val;
 
 	return 0;
 }
@@ -3403,12 +3397,12 @@ unsigned int snd_soc_daifmt_parse_clock_provider_raw(struct device_node *np,
 	 * check "[prefix]frame-master"
 	 */
 	snprintf(prop, sizeof(prop), "%sbitclock-master", prefix);
-	bit = of_property_read_bool(np, prop);
+	bit = of_property_present(np, prop);
 	if (bit && bitclkmaster)
 		*bitclkmaster = of_parse_phandle(np, prop, 0);
 
 	snprintf(prop, sizeof(prop), "%sframe-master", prefix);
-	frame = of_property_read_bool(np, prop);
+	frame = of_property_present(np, prop);
 	if (frame && framemaster)
 		*framemaster = of_parse_phandle(np, prop, 0);
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 88b3ad5a2552..53b0ea68b939 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1618,10 +1618,13 @@ static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
 		/*
 		 * Filter for systems with 'component_chaining' enabled.
 		 * This helps to avoid unnecessary re-configuration of an
-		 * already active BE on such systems.
+		 * already active BE on such systems and ensures the BE DAI
+		 * widget is powered ON after hw_params() BE DAI callback.
 		 */
 		if (fe->card->component_chaining &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_NEW) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_CLOSE))
 			continue;
 
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 3efbf4aaf965..d9c4266c8150 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -409,11 +409,11 @@ static int stm32_sai_set_parent_rate(struct stm32_sai_sub_data *sai,
 				     unsigned int rate)
 {
 	struct platform_device *pdev = sai->pdev;
-	unsigned int sai_ck_rate, sai_ck_max_rate, sai_curr_rate, sai_new_rate;
+	unsigned int sai_ck_rate, sai_ck_max_rate, sai_ck_min_rate, sai_curr_rate, sai_new_rate;
 	int div, ret;
 
 	/*
-	 * Set maximum expected kernel clock frequency
+	 * Set minimum and maximum expected kernel clock frequency
 	 * - mclk on or spdif:
 	 *   f_sai_ck = MCKDIV * mclk-fs * fs
 	 *   Here typical 256 ratio is assumed for mclk-fs
@@ -423,13 +423,16 @@ static int stm32_sai_set_parent_rate(struct stm32_sai_sub_data *sai,
 	 *   Set constraint MCKDIV * FRL <= 256, to ensure MCKDIV is in available range
 	 *   f_sai_ck = sai_ck_max_rate * pow_of_two(FRL) / 256
 	 */
+	sai_ck_min_rate = rate * 256;
 	if (!(rate % SAI_RATE_11K))
 		sai_ck_max_rate = SAI_MAX_SAMPLE_RATE_11K * 256;
 	else
 		sai_ck_max_rate = SAI_MAX_SAMPLE_RATE_8K * 256;
 
-	if (!sai->sai_mclk && !STM_SAI_PROTOCOL_IS_SPDIF(sai))
+	if (!sai->sai_mclk && !STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
+		sai_ck_min_rate = rate * sai->fs_length;
 		sai_ck_max_rate /= DIV_ROUND_CLOSEST(256, roundup_pow_of_two(sai->fs_length));
+	}
 
 	/*
 	 * Request exclusivity, as the clock is shared by SAI sub-blocks and by
@@ -444,7 +447,10 @@ static int stm32_sai_set_parent_rate(struct stm32_sai_sub_data *sai,
 	 * return immediately.
 	 */
 	sai_curr_rate = clk_get_rate(sai->sai_ck);
-	if (stm32_sai_rate_accurate(sai_ck_max_rate, sai_curr_rate))
+	dev_dbg(&pdev->dev, "kernel clock rate: min [%u], max [%u], current [%u]",
+		sai_ck_min_rate, sai_ck_max_rate, sai_curr_rate);
+	if (stm32_sai_rate_accurate(sai_ck_max_rate, sai_curr_rate) &&
+	    sai_curr_rate >= sai_ck_min_rate)
 		return 0;
 
 	/*
@@ -472,7 +478,7 @@ static int stm32_sai_set_parent_rate(struct stm32_sai_sub_data *sai,
 		/* Try a lower frequency */
 		div++;
 		sai_ck_rate = sai_ck_max_rate / div;
-	} while (sai_ck_rate > rate);
+	} while (sai_ck_rate >= sai_ck_min_rate);
 
 	/* No accurate rate found */
 	dev_err(&pdev->dev, "Failed to find an accurate rate");
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index a29f28eb7d0c..f36ec98da460 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -926,6 +926,8 @@ static int endpoint_set_interface(struct snd_usb_audio *chip,
 {
 	int altset = set ? ep->altsetting : 0;
 	int err;
+	int retries = 0;
+	const int max_retries = 5;
 
 	if (ep->iface_ref->altset == altset)
 		return 0;
@@ -935,8 +937,13 @@ static int endpoint_set_interface(struct snd_usb_audio *chip,
 
 	usb_audio_dbg(chip, "Setting usb interface %d:%d for EP 0x%x\n",
 		      ep->iface, altset, ep->ep_num);
+retry:
 	err = usb_set_interface(chip->dev, ep->iface, altset);
 	if (err < 0) {
+		if (err == -EPROTO && ++retries <= max_retries) {
+			msleep(5 * (1 << (retries - 1)));
+			goto retry;
+		}
 		usb_audio_err_ratelimited(
 			chip, "%d:%d: usb_set_interface failed (%d)\n",
 			ep->iface, altset, err);
diff --git a/sound/usb/format.c b/sound/usb/format.c
index 6049d957694c..a9283b2bd2f4 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -260,7 +260,8 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 	}
 
 	/* Jabra Evolve 65 headset */
-	if (chip->usb_id == USB_ID(0x0b0e, 0x030b)) {
+	if (chip->usb_id == USB_ID(0x0b0e, 0x030b) ||
+	    chip->usb_id == USB_ID(0x0b0e, 0x030c)) {
 		/* only 48kHz for playback while keeping 16kHz for capture */
 		if (fp->nr_rates != 1)
 			return set_fixed_rate(fp, 48000, SNDRV_PCM_RATE_48000);

