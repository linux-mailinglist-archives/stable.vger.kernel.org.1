Return-Path: <stable+bounces-142984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4705EAB0C98
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5CE1B6736F
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E487270ED8;
	Fri,  9 May 2025 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0gpy/4E7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC024BD1A;
	Fri,  9 May 2025 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746777988; cv=none; b=nZq+91eVdbFpuqUmKAr7C2l9Vj64c4y/GlajBxqawAYl0aWH+ohbqqu4FjthDgpw43SvvyvHbqF8CkbjFM/AMEHVWUlCdBaieRrMBAdseFsfg3twCxZa48mmU1hFd2imXV4Ls+HTNNoRnucEC9llwZBUvhdvcmd9k5SlnDTCCj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746777988; c=relaxed/simple;
	bh=xYuoomNXMj2VqIUL4RpcCxTGht/hwduDgmfPPwF48/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOp3LkUpDgNfYBydCSfEuoReV34R0Fhdj4pbvnciUzEa247icAbeBgqasU7XdMMU6tCweGuNsRZ1sw7UZKmyOJBZZ0PUoJktcGRvb6OoakTrnfOwghcNsyPCNIRUY9Baml4/9wQJvBBp9q8HalNtPuEzIED4NwYCFF9YzGNrDsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0gpy/4E7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A66C4CEE4;
	Fri,  9 May 2025 08:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746777988;
	bh=xYuoomNXMj2VqIUL4RpcCxTGht/hwduDgmfPPwF48/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0gpy/4E7hRX/LiAt+TxbnwFk57zZKzJ8XNGRKDphxyDWF2IX3QozgH5qPWWipLPWP
	 ma+7VYkBtSC0/AOZ2a5bUGP6N6og1CV4G/5DXi4okGbvpU9oQmj9PdVRSCU3VR0oIa
	 O5KTwGOKnoT1NZsBu0dcsCnRZryWlv4LPZ2ctqHw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.182
Date: Fri,  9 May 2025 10:06:16 +0200
Message-ID: <2025050916-paralyses-deduct-8285@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025050916-wavy-early-2c0d@gregkh>
References: <2025050916-wavy-early-2c0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 26099a3b2964..2288ad8ae88a 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 181
+SUBLEVEL = 182
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/boot/dts/imx6ul-imx6ull-opos6ul.dtsi b/arch/arm/boot/dts/imx6ul-imx6ull-opos6ul.dtsi
index f2386dcb9ff2..dda4fa91b2f2 100644
--- a/arch/arm/boot/dts/imx6ul-imx6ull-opos6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-imx6ull-opos6ul.dtsi
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
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 750588f9a1d4..df8188193c17 100644
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
index 6ce427b58836..ecd27b48d61f 100644
--- a/arch/parisc/math-emu/driver.c
+++ b/arch/parisc/math-emu/driver.c
@@ -103,9 +103,19 @@ handle_fpe(struct pt_regs *regs)
 
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
diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 4bdcb91478a5..9e00275576b1 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -44,6 +44,7 @@ KVM_X86_OP(set_idt)
 KVM_X86_OP(get_gdt)
 KVM_X86_OP(set_gdt)
 KVM_X86_OP(sync_dirty_debug_regs)
+KVM_X86_OP(set_dr6)
 KVM_X86_OP(set_dr7)
 KVM_X86_OP(cache_reg)
 KVM_X86_OP(get_rflags)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f779facd8246..710c9c87cdf2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1344,6 +1344,7 @@ struct kvm_x86_ops {
 	void (*get_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*set_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
 	void (*sync_dirty_debug_regs)(struct kvm_vcpu *vcpu);
+	void (*set_dr6)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*set_dr7)(struct kvm_vcpu *vcpu, unsigned long value);
 	void (*cache_reg)(struct kvm_vcpu *vcpu, enum kvm_reg reg);
 	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index bc0958eb83b4..0d0aea145f2d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1887,11 +1887,11 @@ static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
 	svm->asid = sd->next_asid++;
 }
 
-static void svm_set_dr6(struct vcpu_svm *svm, unsigned long value)
+static void svm_set_dr6(struct kvm_vcpu *vcpu, unsigned long value)
 {
-	struct vmcb *vmcb = svm->vmcb;
+	struct vmcb *vmcb = to_svm(vcpu)->vmcb;
 
-	if (svm->vcpu.arch.guest_state_protected)
+	if (vcpu->arch.guest_state_protected)
 		return;
 
 	if (unlikely(value != vmcb->save.dr6)) {
@@ -3851,10 +3851,8 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
 	 * Run with all-zero DR6 unless needed, so that we can get the exact cause
 	 * of a #DB.
 	 */
-	if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
-		svm_set_dr6(svm, vcpu->arch.dr6);
-	else
-		svm_set_dr6(svm, DR6_ACTIVE_LOW);
+	if (likely(!(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)))
+		svm_set_dr6(vcpu, DR6_ACTIVE_LOW);
 
 	clgi();
 	kvm_load_guest_xsave_state(vcpu);
@@ -4631,6 +4629,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.set_idt = svm_set_idt,
 	.get_gdt = svm_get_gdt,
 	.set_gdt = svm_set_gdt,
+	.set_dr6 = svm_set_dr6,
 	.set_dr7 = svm_set_dr7,
 	.sync_dirty_debug_regs = svm_sync_dirty_debug_regs,
 	.cache_reg = svm_cache_reg,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6965cf92bd36..5e3e60bdaa5e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5249,6 +5249,12 @@ static void vmx_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 	set_debugreg(DR6_RESERVED, 6);
 }
 
+static void vmx_set_dr6(struct kvm_vcpu *vcpu, unsigned long val)
+{
+	lockdep_assert_irqs_disabled();
+	set_debugreg(vcpu->arch.dr6, 6);
+}
+
 static void vmx_set_dr7(struct kvm_vcpu *vcpu, unsigned long val)
 {
 	vmcs_writel(GUEST_DR7, val);
@@ -6839,10 +6845,6 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		vmx->loaded_vmcs->host_state.cr4 = cr4;
 	}
 
-	/* When KVM_DEBUGREG_WONT_EXIT, dr6 is accessible in guest. */
-	if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
-		set_debugreg(vcpu->arch.dr6, 6);
-
 	/* When single-stepping over STI and MOV SS, we must clear the
 	 * corresponding interruptibility bits in the guest state. Otherwise
 	 * vmentry fails as it then expects bit 14 (BS) in pending debug
@@ -7777,6 +7779,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.set_idt = vmx_set_idt,
 	.get_gdt = vmx_get_gdt,
 	.set_gdt = vmx_set_gdt,
+	.set_dr6 = vmx_set_dr6,
 	.set_dr7 = vmx_set_dr7,
 	.sync_dirty_debug_regs = vmx_sync_dirty_debug_regs,
 	.cache_reg = vmx_cache_reg,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b9e7457bf2aa..bf03f3ff896e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9963,6 +9963,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(vcpu->arch.eff_db[1], 1);
 		set_debugreg(vcpu->arch.eff_db[2], 2);
 		set_debugreg(vcpu->arch.eff_db[3], 3);
+		/* When KVM_DEBUGREG_WONT_EXIT, dr6 is accessible in guest. */
+		if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
+			static_call(kvm_x86_set_dr6)(vcpu, vcpu->arch.dr6);
 	} else if (unlikely(hw_breakpoint_active())) {
 		set_debugreg(0, 7);
 	}
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 5dd29789f97d..330845d53c21 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -98,7 +98,7 @@ static irqreturn_t altr_sdram_mc_err_handler(int irq, void *dev_id)
 	if (status & priv->ecc_stat_ce_mask) {
 		regmap_read(drvdata->mc_vbase, priv->ecc_saddr_offset,
 			    &err_addr);
-		if (priv->ecc_uecnt_offset)
+		if (priv->ecc_cecnt_offset)
 			regmap_read(drvdata->mc_vbase,  priv->ecc_cecnt_offset,
 				    &err_count);
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, err_count,
@@ -1015,9 +1015,6 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 		}
 	}
 
-	/* Interrupt mode set to every SBERR */
-	regmap_write(ecc_mgr_map, ALTR_A10_ECC_INTMODE_OFST,
-		     ALTR_A10_ECC_INTMODE);
 	/* Enable ECC */
 	ecc_set_bits(ecc_ctrl_en_mask, (ecc_block_base +
 					ALTR_A10_ECC_CTRL_OFST));
@@ -2100,6 +2097,10 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
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
diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 7c1c0951e562..758ced6a8cc4 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -73,6 +73,9 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
 	if (!dev)
 		return NULL;
 
+	/* Drop the refcnt bumped implicitly by device_find_child */
+	put_device(dev);
+
 	return to_scmi_dev(dev);
 }
 
diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 2a942dc6a6dc..2a82119eb58e 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -790,13 +790,13 @@ meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
 				 FREQ_1000_1001(params[i].pixel_freq));
 		DRM_DEBUG_DRIVER("i = %d phy_freq = %d alt = %d\n",
 				 i, params[i].phy_freq,
-				 FREQ_1000_1001(params[i].phy_freq/1000)*1000);
+				 FREQ_1000_1001(params[i].phy_freq/10)*10);
 		/* Match strict frequency */
 		if (phy_freq == params[i].phy_freq &&
 		    vclk_freq == params[i].vclk_freq)
 			return MODE_OK;
 		/* Match 1000/1001 variant */
-		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/1000)*1000) &&
+		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/10)*10) &&
 		    vclk_freq == FREQ_1000_1001(params[i].vclk_freq))
 			return MODE_OK;
 	}
@@ -1070,7 +1070,7 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 
 	for (freq = 0 ; params[freq].pixel_freq ; ++freq) {
 		if ((phy_freq == params[freq].phy_freq ||
-		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/1000)*1000) &&
+		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/10)*10) &&
 		    (vclk_freq == params[freq].vclk_freq ||
 		     vclk_freq == FREQ_1000_1001(params[freq].vclk_freq))) {
 			if (vclk_freq != params[freq].vclk_freq)
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index 0ae416aa76dc..af2b71e3058c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -95,7 +95,7 @@ nouveau_fence_context_kill(struct nouveau_fence_chan *fctx, int error)
 	while (!list_empty(&fctx->pending)) {
 		fence = list_entry(fctx->pending.next, typeof(*fence), head);
 
-		if (error)
+		if (error && !dma_fence_is_signaled_locked(&fence->base))
 			dma_fence_set_error(&fence->base, error);
 
 		if (nouveau_fence_signal(fence))
diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index c688f11ae5c9..96a4ce9c8d25 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -616,9 +616,9 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
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
index 70f3720d96c7..b6ee83b81d32 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3343,6 +3343,14 @@ static int __init parse_ivrs_acpihid(char *str)
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
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ec4c87095c6c..bc65e7b4f004 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1430,26 +1430,37 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
+static int arm_smmu_streams_cmp_key(const void *lhs, const struct rb_node *rhs)
+{
+	struct arm_smmu_stream *stream_rhs =
+		rb_entry(rhs, struct arm_smmu_stream, node);
+	const u32 *sid_lhs = lhs;
+
+	if (*sid_lhs < stream_rhs->id)
+		return -1;
+	if (*sid_lhs > stream_rhs->id)
+		return 1;
+	return 0;
+}
+
+static int arm_smmu_streams_cmp_node(struct rb_node *lhs,
+				     const struct rb_node *rhs)
+{
+	return arm_smmu_streams_cmp_key(
+		&rb_entry(lhs, struct arm_smmu_stream, node)->id, rhs);
+}
+
 static struct arm_smmu_master *
 arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 {
 	struct rb_node *node;
-	struct arm_smmu_stream *stream;
 
 	lockdep_assert_held(&smmu->streams_mutex);
 
-	node = smmu->streams.rb_node;
-	while (node) {
-		stream = rb_entry(node, struct arm_smmu_stream, node);
-		if (stream->id < sid)
-			node = node->rb_right;
-		else if (stream->id > sid)
-			node = node->rb_left;
-		else
-			return stream->master;
-	}
-
-	return NULL;
+	node = rb_find(&sid, &smmu->streams, arm_smmu_streams_cmp_key);
+	if (!node)
+		return NULL;
+	return rb_entry(node, struct arm_smmu_stream, node)->master;
 }
 
 /* IRQ and event handlers */
@@ -2560,8 +2571,6 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 {
 	int i;
 	int ret = 0;
-	struct arm_smmu_stream *new_stream, *cur_stream;
-	struct rb_node **new_node, *parent_node = NULL;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
 	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
@@ -2572,9 +2581,10 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 
 	mutex_lock(&smmu->streams_mutex);
 	for (i = 0; i < fwspec->num_ids; i++) {
+		struct arm_smmu_stream *new_stream = &master->streams[i];
+		struct rb_node *existing;
 		u32 sid = fwspec->ids[i];
 
-		new_stream = &master->streams[i];
 		new_stream->id = sid;
 		new_stream->master = master;
 
@@ -2594,28 +2604,23 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 		}
 
 		/* Insert into SID tree */
-		new_node = &(smmu->streams.rb_node);
-		while (*new_node) {
-			cur_stream = rb_entry(*new_node, struct arm_smmu_stream,
-					      node);
-			parent_node = *new_node;
-			if (cur_stream->id > new_stream->id) {
-				new_node = &((*new_node)->rb_left);
-			} else if (cur_stream->id < new_stream->id) {
-				new_node = &((*new_node)->rb_right);
-			} else {
-				dev_warn(master->dev,
-					 "stream %u already in tree\n",
-					 cur_stream->id);
-				ret = -EINVAL;
-				break;
-			}
-		}
-		if (ret)
-			break;
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
 
-		rb_link_node(&new_stream->node, parent_node, new_node);
-		rb_insert_color(&new_stream->node, &smmu->streams);
+			dev_warn(master->dev,
+				 "stream %u already in tree from dev %s\n", sid,
+				 dev_name(existing_master->dev));
+			ret = -EINVAL;
+			break;
+		}
 	}
 
 	if (ret) {
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1d2e3c12dc81..14a83b564db4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5660,6 +5660,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e30, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e40, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e90, quirk_iommu_igfx);
 
+/* QM57/QS57 integrated gfx malfunctions with dmar */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_iommu_igfx);
+
 /* Broadwell igfx malfunctions with dmar */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1606, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x160B, quirk_iommu_igfx);
@@ -5737,7 +5740,6 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_calpella_no_shadow_gtt);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0062, quirk_calpella_no_shadow_gtt);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x006a, quirk_calpella_no_shadow_gtt);
 
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 0e57c60681aa..9d99b19cd21b 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -263,7 +263,7 @@ static struct msi_domain_info gicv2m_pmsi_domain_info = {
 	.chip	= &gicv2m_pmsi_irq_chip,
 };
 
-static void gicv2m_teardown(void)
+static void __init gicv2m_teardown(void)
 {
 	struct v2m_data *v2m, *tmp;
 
@@ -278,7 +278,7 @@ static void gicv2m_teardown(void)
 	}
 }
 
-static int gicv2m_allocate_domains(struct irq_domain *parent)
+static __init int gicv2m_allocate_domains(struct irq_domain *parent)
 {
 	struct irq_domain *inner_domain, *pci_domain, *plat_domain;
 	struct v2m_data *v2m;
@@ -405,7 +405,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 	return ret;
 }
 
-static struct of_device_id gicv2m_device_id[] = {
+static __initconst struct of_device_id gicv2m_device_id[] = {
 	{	.compatible	= "arm,gic-v2m-frame",	},
 	{},
 };
@@ -470,7 +470,7 @@ static struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
 	return data->fwnode;
 }
 
-static bool acpi_check_amazon_graviton_quirks(void)
+static __init bool acpi_check_amazon_graviton_quirks(void)
 {
 	static struct acpi_table_madt *madt;
 	acpi_status status;
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index ffae04983b0a..e9d553eea9cd 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4543,7 +4543,7 @@ static void dm_integrity_dtr(struct dm_target *ti)
 	BUG_ON(!RB_EMPTY_ROOT(&ic->in_progress));
 	BUG_ON(!list_empty(&ic->wait_list));
 
-	if (ic->mode == 'B')
+	if (ic->mode == 'B' && ic->bitmap_flush_work.work.func)
 		cancel_delayed_work_sync(&ic->bitmap_flush_work);
 	if (ic->metadata_wq)
 		destroy_workqueue(ic->metadata_wq);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 52083d397fc4..5a66be3b2a63 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -492,8 +492,9 @@ static char **realloc_argv(unsigned *size, char **old_argv)
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
index 3ff95ed8513a..9ea9bc250543 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1078,26 +1078,26 @@ int renesas_sdhi_probe(struct platform_device *pdev,
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
@@ -1109,8 +1109,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 	return ret;
 
-eirq:
-	tmio_mmc_host_remove(host);
 edisclk:
 	renesas_sdhi_clk_disable(host);
 efree:
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
index 4030d619e84f..3cf7943b590c 100644
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
@@ -3495,8 +3507,12 @@ static int xgbe_init(struct xgbe_prv_data *pdata)
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
@@ -3650,5 +3666,9 @@ void xgbe_init_function_ptrs_dev(struct xgbe_hw_if *hw_if)
 	hw_if->disable_vxlan = xgbe_disable_vxlan;
 	hw_if->set_vxlan_id = xgbe_set_vxlan_id;
 
+	/* For Split Header*/
+	hw_if->enable_sph = xgbe_config_sph_mode;
+	hw_if->disable_sph = xgbe_disable_sph_mode;
+
 	DBGPR("<--xgbe_init_function_ptrs\n");
 }
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 8d823bc14700..af04c035633f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -2264,10 +2264,17 @@ static int xgbe_set_features(struct net_device *netdev,
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
index 497c4ec6089a..bb1254bdd874 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -833,6 +833,10 @@ struct xgbe_hw_if {
 	void (*enable_vxlan)(struct xgbe_prv_data *);
 	void (*disable_vxlan)(struct xgbe_prv_data *);
 	void (*set_vxlan_id)(struct xgbe_prv_data *);
+
+	/* For Split Header */
+	void (*enable_sph)(struct xgbe_prv_data *pdata);
+	void (*disable_sph)(struct xgbe_prv_data *pdata);
 };
 
 /* This structure represents implementation specific routines for an
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index 156f76bcea7e..8716c924f3f5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -66,20 +66,30 @@ static int bnxt_hwrm_dbg_dma_data(struct bnxt *bp, void *msg,
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
index 8ebc1c522a05..ad307df8d97b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1360,6 +1360,17 @@ static int bnxt_get_regs_len(struct net_device *dev)
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
@@ -1391,12 +1402,27 @@ static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
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
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 993bba0ffb16..af0b6fa296e5 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -353,7 +353,7 @@ parse_eeprom (struct net_device *dev)
 		dev->dev_addr[i] = psrom->mac_addr[i];
 
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
index 7b5585bc21d8..5c860eef0300 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -635,7 +635,12 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
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
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index fa16cdcee10d..8d1b66281c09 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -178,6 +178,7 @@ struct hns3_mac_stats {
 
 /* hnae3 loop mode */
 enum hnae3_loop {
+	HNAE3_LOOP_EXTERNAL,
 	HNAE3_LOOP_APP,
 	HNAE3_LOOP_SERIAL_SERDES,
 	HNAE3_LOOP_PARALLEL_SERDES,
@@ -802,6 +803,7 @@ struct hnae3_roce_private_info {
 #define HNAE3_SUPPORT_SERDES_SERIAL_LOOPBACK	BIT(2)
 #define HNAE3_SUPPORT_VF	      BIT(3)
 #define HNAE3_SUPPORT_SERDES_PARALLEL_LOOPBACK	BIT(4)
+#define HNAE3_SUPPORT_EXTERNAL_LOOPBACK	BIT(5)
 
 #define HNAE3_USER_UPE		BIT(0)	/* unicast promisc enabled by user */
 #define HNAE3_USER_MPE		BIT(1)	/* mulitcast promisc enabled by user */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index bd801e35d51e..d6fe09ca03d2 100644
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
index 60592e8ddf3b..adc2f1e34e32 100644
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
@@ -5642,6 +5649,58 @@ int hns3_set_channels(struct net_device *netdev,
 	return 0;
 }
 
+void hns3_external_lb_prepare(struct net_device *ndev, bool if_running)
+{
+	struct hns3_nic_priv *priv = netdev_priv(ndev);
+
+	if (!if_running)
+		return;
+
+	if (test_and_set_bit(HNS3_NIC_STATE_DOWN, &priv->state))
+		return;
+
+	netif_carrier_off(ndev);
+	netif_tx_disable(ndev);
+
+	hns3_disable_irqs_and_tqps(ndev);
+
+	/* delay ring buffer clearing to hns3_reset_notify_uninit_enet
+	 * during reset process, because driver may not be able
+	 * to disable the ring through firmware when downing the netdev.
+	 */
+	if (!hns3_nic_resetting(ndev))
+		hns3_nic_reset_all_ring(priv->ae_handle);
+
+	hns3_reset_tx_queue(priv->ae_handle);
+}
+
+void hns3_external_lb_restore(struct net_device *ndev, bool if_running)
+{
+	struct hns3_nic_priv *priv = netdev_priv(ndev);
+	struct hnae3_handle *h = priv->ae_handle;
+
+	if (!if_running)
+		return;
+
+	if (hns3_nic_resetting(ndev))
+		return;
+
+	if (!test_bit(HNS3_NIC_STATE_DOWN, &priv->state))
+		return;
+
+	if (hns3_nic_reset_all_ring(priv->ae_handle))
+		return;
+
+	clear_bit(HNS3_NIC_STATE_DOWN, &priv->state);
+
+	hns3_enable_irqs_and_tqps(ndev);
+
+	netif_tx_wake_all_queues(ndev);
+
+	if (h->ae_algo->ops->get_status(h))
+		netif_carrier_on(ndev);
+}
+
 static const struct hns3_hw_error_info hns3_hw_err[] = {
 	{ .type = HNAE3_PPU_POISON_ERROR,
 	  .msg = "PPU poison" },
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index f60ba2ee8b8b..f3f7f370807f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -729,4 +729,7 @@ u16 hns3_get_max_available_channels(struct hnae3_handle *h);
 void hns3_cq_period_mode_init(struct hns3_nic_priv *priv,
 			      enum dim_cq_period_mode tx_mode,
 			      enum dim_cq_period_mode rx_mode);
+
+void hns3_external_lb_prepare(struct net_device *ndev, bool if_running);
+void hns3_external_lb_restore(struct net_device *ndev, bool if_running);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 17fa4e7684cd..b01ce4fd6bc4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -67,7 +67,6 @@ static const struct hns3_stats hns3_rxq_stats[] = {
 
 #define HNS3_TQP_STATS_COUNT (HNS3_TXQ_STATS_COUNT + HNS3_RXQ_STATS_COUNT)
 
-#define HNS3_SELF_TEST_TYPE_NUM         4
 #define HNS3_NIC_LB_TEST_PKT_NUM	1
 #define HNS3_NIC_LB_TEST_RING_ID	0
 #define HNS3_NIC_LB_TEST_PACKET_SIZE	128
@@ -93,6 +92,7 @@ static int hns3_lp_setup(struct net_device *ndev, enum hnae3_loop loop, bool en)
 	case HNAE3_LOOP_PARALLEL_SERDES:
 	case HNAE3_LOOP_APP:
 	case HNAE3_LOOP_PHY:
+	case HNAE3_LOOP_EXTERNAL:
 		ret = h->ae_algo->ops->set_loopback(h, loop, en);
 		break;
 	default:
@@ -300,6 +300,10 @@ static int hns3_lp_run_test(struct net_device *ndev, enum hnae3_loop mode)
 
 static void hns3_set_selftest_param(struct hnae3_handle *h, int (*st_param)[2])
 {
+	st_param[HNAE3_LOOP_EXTERNAL][0] = HNAE3_LOOP_EXTERNAL;
+	st_param[HNAE3_LOOP_EXTERNAL][1] =
+			h->flags & HNAE3_SUPPORT_EXTERNAL_LOOPBACK;
+
 	st_param[HNAE3_LOOP_APP][0] = HNAE3_LOOP_APP;
 	st_param[HNAE3_LOOP_APP][1] =
 			h->flags & HNAE3_SUPPORT_APP_LOOPBACK;
@@ -318,17 +322,11 @@ static void hns3_set_selftest_param(struct hnae3_handle *h, int (*st_param)[2])
 			h->flags & HNAE3_SUPPORT_PHY_LOOPBACK;
 }
 
-static void hns3_selftest_prepare(struct net_device *ndev,
-				  bool if_running, int (*st_param)[2])
+static void hns3_selftest_prepare(struct net_device *ndev, bool if_running)
 {
 	struct hns3_nic_priv *priv = netdev_priv(ndev);
 	struct hnae3_handle *h = priv->ae_handle;
 
-	if (netif_msg_ifdown(h))
-		netdev_info(ndev, "self test start\n");
-
-	hns3_set_selftest_param(h, st_param);
-
 	if (if_running)
 		ndev->netdev_ops->ndo_stop(ndev);
 
@@ -367,18 +365,15 @@ static void hns3_selftest_restore(struct net_device *ndev, bool if_running)
 
 	if (if_running)
 		ndev->netdev_ops->ndo_open(ndev);
-
-	if (netif_msg_ifdown(h))
-		netdev_info(ndev, "self test end\n");
 }
 
 static void hns3_do_selftest(struct net_device *ndev, int (*st_param)[2],
 			     struct ethtool_test *eth_test, u64 *data)
 {
-	int test_index = 0;
+	int test_index = HNAE3_LOOP_APP;
 	u32 i;
 
-	for (i = 0; i < HNS3_SELF_TEST_TYPE_NUM; i++) {
+	for (i = HNAE3_LOOP_APP; i < HNAE3_LOOP_NONE; i++) {
 		enum hnae3_loop loop_type = (enum hnae3_loop)st_param[i][0];
 
 		if (!st_param[i][1])
@@ -397,6 +392,20 @@ static void hns3_do_selftest(struct net_device *ndev, int (*st_param)[2],
 	}
 }
 
+static void hns3_do_external_lb(struct net_device *ndev,
+				struct ethtool_test *eth_test, u64 *data)
+{
+	data[HNAE3_LOOP_EXTERNAL] = hns3_lp_up(ndev, HNAE3_LOOP_EXTERNAL);
+	if (!data[HNAE3_LOOP_EXTERNAL])
+		data[HNAE3_LOOP_EXTERNAL] = hns3_lp_run_test(ndev, HNAE3_LOOP_EXTERNAL);
+	hns3_lp_down(ndev, HNAE3_LOOP_EXTERNAL);
+
+	if (data[HNAE3_LOOP_EXTERNAL])
+		eth_test->flags |= ETH_TEST_FL_FAILED;
+
+	eth_test->flags |= ETH_TEST_FL_EXTERNAL_LB_DONE;
+}
+
 /**
  * hns3_nic_self_test - self test
  * @ndev: net device
@@ -406,7 +415,9 @@ static void hns3_do_selftest(struct net_device *ndev, int (*st_param)[2],
 static void hns3_self_test(struct net_device *ndev,
 			   struct ethtool_test *eth_test, u64 *data)
 {
-	int st_param[HNS3_SELF_TEST_TYPE_NUM][2];
+	struct hns3_nic_priv *priv = netdev_priv(ndev);
+	struct hnae3_handle *h = priv->ae_handle;
+	int st_param[HNAE3_LOOP_NONE][2];
 	bool if_running = netif_running(ndev);
 
 	if (hns3_nic_resetting(ndev)) {
@@ -414,13 +425,29 @@ static void hns3_self_test(struct net_device *ndev,
 		return;
 	}
 
-	/* Only do offline selftest, or pass by default */
-	if (eth_test->flags != ETH_TEST_FL_OFFLINE)
+	if (!(eth_test->flags & ETH_TEST_FL_OFFLINE))
 		return;
 
-	hns3_selftest_prepare(ndev, if_running, st_param);
+	if (netif_msg_ifdown(h))
+		netdev_info(ndev, "self test start\n");
+
+	hns3_set_selftest_param(h, st_param);
+
+	/* external loopback test requires that the link is up and the duplex is
+	 * full, do external test first to reduce the whole test time
+	 */
+	if (eth_test->flags & ETH_TEST_FL_EXTERNAL_LB) {
+		hns3_external_lb_prepare(ndev, if_running);
+		hns3_do_external_lb(ndev, eth_test, data);
+		hns3_external_lb_restore(ndev, if_running);
+	}
+
+	hns3_selftest_prepare(ndev, if_running);
 	hns3_do_selftest(ndev, st_param, eth_test, data);
 	hns3_selftest_restore(ndev, if_running);
+
+	if (netif_msg_ifdown(h))
+		netdev_info(ndev, "self test end\n");
 }
 
 static void hns3_update_limit_promisc_mode(struct net_device *netdev,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 35411f9a1432..a0284a9d90e8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -151,10 +151,11 @@ static const u32 tqp_intr_reg_addr_list[] = {HCLGE_TQP_INTR_CTRL_REG,
 					     HCLGE_TQP_INTR_RL_REG};
 
 static const char hns3_nic_test_strs[][ETH_GSTRING_LEN] = {
-	"App    Loopback test",
-	"Serdes serial Loopback test",
-	"Serdes parallel Loopback test",
-	"Phy    Loopback test"
+	"External Loopback test",
+	"App      Loopback test",
+	"Serdes   serial Loopback test",
+	"Serdes   parallel Loopback test",
+	"Phy      Loopback test"
 };
 
 static const struct hclge_comm_stats_str g_mac_stats_string[] = {
@@ -754,7 +755,8 @@ static int hclge_get_sset_count(struct hnae3_handle *handle, int stringset)
 #define HCLGE_LOOPBACK_TEST_FLAGS (HNAE3_SUPPORT_APP_LOOPBACK | \
 		HNAE3_SUPPORT_PHY_LOOPBACK | \
 		HNAE3_SUPPORT_SERDES_SERIAL_LOOPBACK | \
-		HNAE3_SUPPORT_SERDES_PARALLEL_LOOPBACK)
+		HNAE3_SUPPORT_SERDES_PARALLEL_LOOPBACK | \
+		HNAE3_SUPPORT_EXTERNAL_LOOPBACK)
 
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
@@ -776,9 +778,12 @@ static int hclge_get_sset_count(struct hnae3_handle *handle, int stringset)
 			handle->flags |= HNAE3_SUPPORT_APP_LOOPBACK;
 		}
 
-		count += 2;
+		count += 1;
 		handle->flags |= HNAE3_SUPPORT_SERDES_SERIAL_LOOPBACK;
+		count += 1;
 		handle->flags |= HNAE3_SUPPORT_SERDES_PARALLEL_LOOPBACK;
+		count += 1;
+		handle->flags |= HNAE3_SUPPORT_EXTERNAL_LOOPBACK;
 
 		if ((hdev->hw.mac.phydev && hdev->hw.mac.phydev->drv &&
 		     hdev->hw.mac.phydev->drv->set_loopback) ||
@@ -806,6 +811,11 @@ static void hclge_get_strings(struct hnae3_handle *handle, u32 stringset,
 					   size, p);
 		p = hclge_tqps_get_strings(handle, p);
 	} else if (stringset == ETH_SS_TEST) {
+		if (handle->flags & HNAE3_SUPPORT_EXTERNAL_LOOPBACK) {
+			memcpy(p, hns3_nic_test_strs[HNAE3_LOOP_EXTERNAL],
+			       ETH_GSTRING_LEN);
+			p += ETH_GSTRING_LEN;
+		}
 		if (handle->flags & HNAE3_SUPPORT_APP_LOOPBACK) {
 			memcpy(p, hns3_nic_test_strs[HNAE3_LOOP_APP],
 			       ETH_GSTRING_LEN);
@@ -8060,7 +8070,7 @@ static int hclge_set_loopback(struct hnae3_handle *handle,
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
-	int ret;
+	int ret = 0;
 
 	/* Loopback can be enabled in three places: SSU, MAC, and serdes. By
 	 * default, SSU loopback is enabled, so if the SMAC and the DMAC are
@@ -8087,6 +8097,8 @@ static int hclge_set_loopback(struct hnae3_handle *handle,
 	case HNAE3_LOOP_PHY:
 		ret = hclge_set_phy_loopback(hdev, en);
 		break;
+	case HNAE3_LOOP_EXTERNAL:
+		break;
 	default:
 		ret = -ENOTSUPP;
 		dev_err(&hdev->pdev->dev,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index 4d4cea1f5015..b7cf9fbf9718 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -452,6 +452,13 @@ static int hclge_ptp_create_clock(struct hclge_dev *hdev)
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
@@ -463,12 +470,6 @@ static int hclge_ptp_create_clock(struct hclge_dev *hdev)
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
index 7bb01eafba74..628d5c5ad75d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1761,9 +1761,8 @@ static void hclgevf_sync_vlan_filter(struct hclgevf_dev *hdev)
 	rtnl_unlock();
 }
 
-static int hclgevf_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
+static int hclgevf_en_hw_strip_rxvtag_cmd(struct hclgevf_dev *hdev, bool enable)
 {
-	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 	struct hclge_vf_to_pf_msg send_msg;
 
 	hclgevf_build_send_msg(&send_msg, HCLGE_MBX_SET_VLAN,
@@ -1772,6 +1771,19 @@ static int hclgevf_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
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
@@ -2684,12 +2696,13 @@ static int hclgevf_rss_init_hw(struct hclgevf_dev *hdev)
 	return hclgevf_set_rss_tc_mode(hdev, rss_cfg->rss_size);
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
@@ -3359,7 +3372,7 @@ static int hclgevf_reset_hdev(struct hclgevf_dev *hdev)
 	if (ret)
 		return ret;
 
-	ret = hclgevf_init_vlan_config(hdev);
+	ret = hclgevf_init_vlan_config(hdev, hdev->rxvtag_strip_en);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed(%d) to initialize VLAN config\n", ret);
@@ -3472,7 +3485,7 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 		goto err_config;
 	}
 
-	ret = hclgevf_init_vlan_config(hdev);
+	ret = hclgevf_init_vlan_config(hdev, true);
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"failed(%d) to initialize VLAN config\n", ret);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 2b216ac96914..a6468fe2ec32 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -315,6 +315,7 @@ struct hclgevf_dev {
 	int *vector_irq;
 
 	bool gro_en;
+	bool rxvtag_strip_en;
 
 	unsigned long vlan_del_fail_bmap[BITS_TO_LONGS(VLAN_N_VID)];
 
diff --git a/drivers/net/ethernet/intel/ice/ice_fltr.c b/drivers/net/ethernet/intel/ice/ice_fltr.c
index e27b4de7e7aa..7536451cb09e 100644
--- a/drivers/net/ethernet/intel/ice/ice_fltr.c
+++ b/drivers/net/ethernet/intel/ice/ice_fltr.c
@@ -46,6 +46,64 @@ ice_fltr_add_entry_to_list(struct device *dev, struct ice_fltr_info *info,
 	return 0;
 }
 
+/**
+ * ice_fltr_set_vlan_vsi_promisc
+ * @hw: pointer to the hardware structure
+ * @vsi: the VSI being configured
+ * @promisc_mask: mask of promiscuous config bits
+ *
+ * Set VSI with all associated VLANs to given promiscuous mode(s)
+ */
+enum ice_status
+ice_fltr_set_vlan_vsi_promisc(struct ice_hw *hw, struct ice_vsi *vsi,
+			      u8 promisc_mask)
+{
+	return ice_set_vlan_vsi_promisc(hw, vsi->idx, promisc_mask, false);
+}
+
+/**
+ * ice_fltr_clear_vlan_vsi_promisc
+ * @hw: pointer to the hardware structure
+ * @vsi: the VSI being configured
+ * @promisc_mask: mask of promiscuous config bits
+ *
+ * Clear VSI with all associated VLANs to given promiscuous mode(s)
+ */
+enum ice_status
+ice_fltr_clear_vlan_vsi_promisc(struct ice_hw *hw, struct ice_vsi *vsi,
+				u8 promisc_mask)
+{
+	return ice_set_vlan_vsi_promisc(hw, vsi->idx, promisc_mask, true);
+}
+
+/**
+ * ice_fltr_clear_vsi_promisc - clear specified promiscuous mode(s)
+ * @hw: pointer to the hardware structure
+ * @vsi_handle: VSI handle to clear mode
+ * @promisc_mask: mask of promiscuous config bits to clear
+ * @vid: VLAN ID to clear VLAN promiscuous
+ */
+enum ice_status
+ice_fltr_clear_vsi_promisc(struct ice_hw *hw, u16 vsi_handle, u8 promisc_mask,
+			   u16 vid)
+{
+	return ice_clear_vsi_promisc(hw, vsi_handle, promisc_mask, vid);
+}
+
+/**
+ * ice_fltr_set_vsi_promisc - set given VSI to given promiscuous mode(s)
+ * @hw: pointer to the hardware structure
+ * @vsi_handle: VSI handle to configure
+ * @promisc_mask: mask of promiscuous config bits
+ * @vid: VLAN ID to set VLAN promiscuous
+ */
+enum ice_status
+ice_fltr_set_vsi_promisc(struct ice_hw *hw, u16 vsi_handle, u8 promisc_mask,
+			 u16 vid)
+{
+	return ice_set_vsi_promisc(hw, vsi_handle, promisc_mask, vid);
+}
+
 /**
  * ice_fltr_add_mac_list - add list of MAC filters
  * @vsi: pointer to VSI struct
diff --git a/drivers/net/ethernet/intel/ice/ice_fltr.h b/drivers/net/ethernet/intel/ice/ice_fltr.h
index 361cb4da9b43..a0e8226f64f6 100644
--- a/drivers/net/ethernet/intel/ice/ice_fltr.h
+++ b/drivers/net/ethernet/intel/ice/ice_fltr.h
@@ -6,6 +6,18 @@
 
 void ice_fltr_free_list(struct device *dev, struct list_head *h);
 enum ice_status
+ice_fltr_set_vlan_vsi_promisc(struct ice_hw *hw, struct ice_vsi *vsi,
+			      u8 promisc_mask);
+enum ice_status
+ice_fltr_clear_vlan_vsi_promisc(struct ice_hw *hw, struct ice_vsi *vsi,
+				u8 promisc_mask);
+enum ice_status
+ice_fltr_clear_vsi_promisc(struct ice_hw *hw, u16 vsi_handle, u8 promisc_mask,
+			   u16 vid);
+enum ice_status
+ice_fltr_set_vsi_promisc(struct ice_hw *hw, u16 vsi_handle, u8 promisc_mask,
+			 u16 vid);
+enum ice_status
 ice_fltr_add_mac_to_list(struct ice_vsi *vsi, struct list_head *list,
 			 const u8 *mac, enum ice_sw_fwd_act_type action);
 enum ice_status
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 329bf24a3f0e..735f8cef6bfa 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -222,32 +222,45 @@ static bool ice_vsi_fltr_changed(struct ice_vsi *vsi)
 }
 
 /**
- * ice_cfg_promisc - Enable or disable promiscuous mode for a given PF
+ * ice_set_promisc - Enable promiscuous mode for a given PF
  * @vsi: the VSI being configured
  * @promisc_m: mask of promiscuous config bits
- * @set_promisc: enable or disable promisc flag request
  *
  */
-static int ice_cfg_promisc(struct ice_vsi *vsi, u8 promisc_m, bool set_promisc)
+static int ice_set_promisc(struct ice_vsi *vsi, u8 promisc_m)
 {
-	struct ice_hw *hw = &vsi->back->hw;
-	enum ice_status status = 0;
+	enum ice_status status;
 
 	if (vsi->type != ICE_VSI_PF)
 		return 0;
 
-	if (vsi->num_vlan > 1) {
-		status = ice_set_vlan_vsi_promisc(hw, vsi->idx, promisc_m,
-						  set_promisc);
-	} else {
-		if (set_promisc)
-			status = ice_set_vsi_promisc(hw, vsi->idx, promisc_m,
-						     0);
-		else
-			status = ice_clear_vsi_promisc(hw, vsi->idx, promisc_m,
-						       0);
-	}
+	if (vsi->num_vlan > 1)
+		status = ice_fltr_set_vlan_vsi_promisc(&vsi->back->hw, vsi, promisc_m);
+	else
+		status = ice_fltr_set_vsi_promisc(&vsi->back->hw, vsi->idx, promisc_m, 0);
+	if (status)
+		return -EIO;
+
+	return 0;
+}
 
+/**
+ * ice_clear_promisc - Disable promiscuous mode for a given PF
+ * @vsi: the VSI being configured
+ * @promisc_m: mask of promiscuous config bits
+ *
+ */
+static int ice_clear_promisc(struct ice_vsi *vsi, u8 promisc_m)
+{
+	enum ice_status status;
+
+	if (vsi->type != ICE_VSI_PF)
+		return 0;
+
+	if (vsi->num_vlan > 1)
+		status = ice_fltr_clear_vlan_vsi_promisc(&vsi->back->hw, vsi, promisc_m);
+	else
+		status = ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx, promisc_m, 0);
 	if (status)
 		return -EIO;
 
@@ -343,7 +356,7 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 			else
 				promisc_m = ICE_MCAST_PROMISC_BITS;
 
-			err = ice_cfg_promisc(vsi, promisc_m, true);
+			err = ice_set_promisc(vsi, promisc_m);
 			if (err) {
 				netdev_err(netdev, "Error setting Multicast promiscuous mode on VSI %i\n",
 					   vsi->vsi_num);
@@ -357,7 +370,7 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 			else
 				promisc_m = ICE_MCAST_PROMISC_BITS;
 
-			err = ice_cfg_promisc(vsi, promisc_m, false);
+			err = ice_clear_promisc(vsi, promisc_m);
 			if (err) {
 				netdev_err(netdev, "Error clearing Multicast promiscuous mode on VSI %i\n",
 					   vsi->vsi_num);
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index 2ca8102e8f36..3b87cc9dfd46 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -2079,6 +2079,11 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
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
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 9d4d58757e04..e4e25f3ba849 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -286,37 +286,6 @@ static int ice_check_vf_init(struct ice_pf *pf, struct ice_vf *vf)
 	return 0;
 }
 
-/**
- * ice_err_to_virt_err - translate errors for VF return code
- * @ice_err: error return code
- */
-static enum virtchnl_status_code ice_err_to_virt_err(enum ice_status ice_err)
-{
-	switch (ice_err) {
-	case ICE_SUCCESS:
-		return VIRTCHNL_STATUS_SUCCESS;
-	case ICE_ERR_BAD_PTR:
-	case ICE_ERR_INVAL_SIZE:
-	case ICE_ERR_DEVICE_NOT_SUPPORTED:
-	case ICE_ERR_PARAM:
-	case ICE_ERR_CFG:
-		return VIRTCHNL_STATUS_ERR_PARAM;
-	case ICE_ERR_NO_MEMORY:
-		return VIRTCHNL_STATUS_ERR_NO_MEMORY;
-	case ICE_ERR_NOT_READY:
-	case ICE_ERR_RESET_FAILED:
-	case ICE_ERR_FW_API_VER:
-	case ICE_ERR_AQ_ERROR:
-	case ICE_ERR_AQ_TIMEOUT:
-	case ICE_ERR_AQ_FULL:
-	case ICE_ERR_AQ_NO_WORK:
-	case ICE_ERR_AQ_EMPTY:
-		return VIRTCHNL_STATUS_ERR_ADMIN_QUEUE_ERROR;
-	default:
-		return VIRTCHNL_STATUS_ERR_NOT_SUPPORTED;
-	}
-}
-
 /**
  * ice_vc_vf_broadcast - Broadcast a message to all VFs on PF
  * @pf: pointer to the PF structure
@@ -1301,45 +1270,50 @@ static void ice_clear_vf_reset_trigger(struct ice_vf *vf)
 	ice_flush(hw);
 }
 
-/**
- * ice_vf_set_vsi_promisc - set given VF VSI to given promiscuous mode(s)
- * @vf: pointer to the VF info
- * @vsi: the VSI being configured
- * @promisc_m: mask of promiscuous config bits
- * @rm_promisc: promisc flag request from the VF to remove or add filter
- *
- * This function configures VF VSI promiscuous mode, based on the VF requests,
- * for Unicast, Multicast and VLAN
- */
-static enum ice_status
-ice_vf_set_vsi_promisc(struct ice_vf *vf, struct ice_vsi *vsi, u8 promisc_m,
-		       bool rm_promisc)
+static int
+ice_vf_set_vsi_promisc(struct ice_vf *vf, struct ice_vsi *vsi, u8 promisc_m)
 {
-	struct ice_pf *pf = vf->pf;
-	enum ice_status status = 0;
-	struct ice_hw *hw;
+	struct ice_hw *hw = &vsi->back->hw;
+	enum ice_status status;
 
-	hw = &pf->hw;
-	if (vsi->num_vlan) {
-		status = ice_set_vlan_vsi_promisc(hw, vsi->idx, promisc_m,
-						  rm_promisc);
-	} else if (vf->port_vlan_info) {
-		if (rm_promisc)
-			status = ice_clear_vsi_promisc(hw, vsi->idx, promisc_m,
-						       vf->port_vlan_info);
-		else
-			status = ice_set_vsi_promisc(hw, vsi->idx, promisc_m,
-						     vf->port_vlan_info);
-	} else {
-		if (rm_promisc)
-			status = ice_clear_vsi_promisc(hw, vsi->idx, promisc_m,
-						       0);
-		else
-			status = ice_set_vsi_promisc(hw, vsi->idx, promisc_m,
-						     0);
+	if (vf->port_vlan_info)
+		status = ice_fltr_set_vsi_promisc(hw, vsi->idx, promisc_m,
+						  vf->port_vlan_info & VLAN_VID_MASK);
+	else if (vsi->num_vlan > 1)
+		status = ice_fltr_set_vlan_vsi_promisc(hw, vsi, promisc_m);
+	else
+		status = ice_fltr_set_vsi_promisc(hw, vsi->idx, promisc_m, 0);
+
+	if (status && status != ICE_ERR_ALREADY_EXISTS) {
+		dev_err(ice_pf_to_dev(vsi->back), "enable Tx/Rx filter promiscuous mode on VF-%u failed, error: %s\n",
+			vf->vf_id, ice_stat_str(status));
+		return ice_status_to_errno(status);
+	}
+
+	return 0;
+}
+
+static int
+ice_vf_clear_vsi_promisc(struct ice_vf *vf, struct ice_vsi *vsi, u8 promisc_m)
+{
+	struct ice_hw *hw = &vsi->back->hw;
+	enum ice_status status;
+
+	if (vf->port_vlan_info)
+		status = ice_fltr_clear_vsi_promisc(hw, vsi->idx, promisc_m,
+						    vf->port_vlan_info & VLAN_VID_MASK);
+	else if (vsi->num_vlan > 1)
+		status = ice_fltr_clear_vlan_vsi_promisc(hw, vsi, promisc_m);
+	else
+		status = ice_fltr_clear_vsi_promisc(hw, vsi->idx, promisc_m, 0);
+
+	if (status && status != ICE_ERR_DOES_NOT_EXIST) {
+		dev_err(ice_pf_to_dev(vsi->back), "disable Tx/Rx filter promiscuous mode on VF-%u failed, error: %s\n",
+			vf->vf_id, ice_stat_str(status));
+		return ice_status_to_errno(status);
 	}
 
-	return status;
+	return 0;
 }
 
 static void ice_vf_clear_counters(struct ice_vf *vf)
@@ -1700,7 +1674,7 @@ bool ice_reset_vf(struct ice_vf *vf, bool is_vflr)
 		else
 			promisc_m = ICE_UCAST_PROMISC_BITS;
 
-		if (ice_vf_set_vsi_promisc(vf, vsi, promisc_m, true))
+		if (ice_vf_clear_vsi_promisc(vf, vsi, promisc_m))
 			dev_err(dev, "disabling promiscuous mode failed\n");
 	}
 
@@ -2952,10 +2926,10 @@ bool ice_is_any_vf_in_promisc(struct ice_pf *pf)
 static int ice_vc_cfg_promiscuous_mode_msg(struct ice_vf *vf, u8 *msg)
 {
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	enum ice_status mcast_status = 0, ucast_status = 0;
 	bool rm_promisc, alluni = false, allmulti = false;
 	struct virtchnl_promisc_info *info =
 	    (struct virtchnl_promisc_info *)msg;
+	int mcast_err = 0, ucast_err = 0;
 	struct ice_pf *pf = vf->pf;
 	struct ice_vsi *vsi;
 	struct device *dev;
@@ -3052,24 +3026,21 @@ static int ice_vc_cfg_promiscuous_mode_msg(struct ice_vf *vf, u8 *msg)
 			ucast_m = ICE_UCAST_PROMISC_BITS;
 		}
 
-		ucast_status = ice_vf_set_vsi_promisc(vf, vsi, ucast_m,
-						      !alluni);
-		if (ucast_status) {
-			dev_err(dev, "%sable Tx/Rx filter promiscuous mode on VF-%d failed\n",
-				alluni ? "en" : "dis", vf->vf_id);
-			v_ret = ice_err_to_virt_err(ucast_status);
-		}
+		if (alluni)
+			ucast_err = ice_vf_set_vsi_promisc(vf, vsi, ucast_m);
+		else
+			ucast_err = ice_vf_clear_vsi_promisc(vf, vsi, ucast_m);
 
-		mcast_status = ice_vf_set_vsi_promisc(vf, vsi, mcast_m,
-						      !allmulti);
-		if (mcast_status) {
-			dev_err(dev, "%sable Tx/Rx filter promiscuous mode on VF-%d failed\n",
-				allmulti ? "en" : "dis", vf->vf_id);
-			v_ret = ice_err_to_virt_err(mcast_status);
-		}
+		if (allmulti)
+			mcast_err = ice_vf_set_vsi_promisc(vf, vsi, mcast_m);
+		else
+			mcast_err = ice_vf_clear_vsi_promisc(vf, vsi, mcast_m);
+
+		if (ucast_err || mcast_err)
+			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 	}
 
-	if (!mcast_status) {
+	if (!mcast_err) {
 		if (allmulti &&
 		    !test_and_set_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states))
 			dev_info(dev, "VF %u successfully set multicast promiscuous mode\n",
@@ -3079,7 +3050,7 @@ static int ice_vc_cfg_promiscuous_mode_msg(struct ice_vf *vf, u8 *msg)
 				 vf->vf_id);
 	}
 
-	if (!ucast_status) {
+	if (!ucast_err) {
 		if (alluni && !test_and_set_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states))
 			dev_info(dev, "VF %u successfully set unicast promiscuous mode\n",
 				 vf->vf_id);
diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index 392648246d8f..639cf1c27dbd 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -32,6 +32,7 @@
 #define MTK_STAR_SKB_ALIGNMENT			16
 #define MTK_STAR_HASHTABLE_MC_LIMIT		256
 #define MTK_STAR_HASHTABLE_SIZE_MAX		512
+#define MTK_STAR_DESC_NEEDED			(MAX_SKB_FRAGS + 4)
 
 /* Normally we'd use NET_IP_ALIGN but on arm64 its value is 0 and it doesn't
  * work for this controller.
@@ -216,7 +217,8 @@ struct mtk_star_ring_desc_data {
 	struct sk_buff *skb;
 };
 
-#define MTK_STAR_RING_NUM_DESCS			128
+#define MTK_STAR_RING_NUM_DESCS			512
+#define MTK_STAR_TX_THRESH			(MTK_STAR_RING_NUM_DESCS / 4)
 #define MTK_STAR_NUM_TX_DESCS			MTK_STAR_RING_NUM_DESCS
 #define MTK_STAR_NUM_RX_DESCS			MTK_STAR_RING_NUM_DESCS
 #define MTK_STAR_NUM_DESCS_TOTAL		(MTK_STAR_RING_NUM_DESCS * 2)
@@ -246,7 +248,8 @@ struct mtk_star_priv {
 	struct mtk_star_ring rx_ring;
 
 	struct mii_bus *mii;
-	struct napi_struct napi;
+	struct napi_struct tx_napi;
+	struct napi_struct rx_napi;
 
 	struct device_node *phy_node;
 	phy_interface_t phy_intf;
@@ -357,19 +360,16 @@ mtk_star_ring_push_head_tx(struct mtk_star_ring *ring,
 	mtk_star_ring_push_head(ring, desc_data, flags);
 }
 
-static unsigned int mtk_star_ring_num_used_descs(struct mtk_star_ring *ring)
+static unsigned int mtk_star_tx_ring_avail(struct mtk_star_ring *ring)
 {
-	return abs(ring->head - ring->tail);
-}
+	u32 avail;
 
-static bool mtk_star_ring_full(struct mtk_star_ring *ring)
-{
-	return mtk_star_ring_num_used_descs(ring) == MTK_STAR_RING_NUM_DESCS;
-}
+	if (ring->tail > ring->head)
+		avail = ring->tail - ring->head - 1;
+	else
+		avail = MTK_STAR_RING_NUM_DESCS - ring->head + ring->tail - 1;
 
-static bool mtk_star_ring_descs_available(struct mtk_star_ring *ring)
-{
-	return mtk_star_ring_num_used_descs(ring) > 0;
+	return avail;
 }
 
 static dma_addr_t mtk_star_dma_map_rx(struct mtk_star_priv *priv,
@@ -414,6 +414,36 @@ static void mtk_star_nic_disable_pd(struct mtk_star_priv *priv)
 			  MTK_STAR_BIT_MAC_CFG_NIC_PD);
 }
 
+static void mtk_star_enable_dma_irq(struct mtk_star_priv *priv,
+				    bool rx, bool tx)
+{
+	u32 value;
+
+	regmap_read(priv->regs, MTK_STAR_REG_INT_MASK, &value);
+
+	if (tx)
+		value &= ~MTK_STAR_BIT_INT_STS_TNTC;
+	if (rx)
+		value &= ~MTK_STAR_BIT_INT_STS_FNRC;
+
+	regmap_write(priv->regs, MTK_STAR_REG_INT_MASK, value);
+}
+
+static void mtk_star_disable_dma_irq(struct mtk_star_priv *priv,
+				     bool rx, bool tx)
+{
+	u32 value;
+
+	regmap_read(priv->regs, MTK_STAR_REG_INT_MASK, &value);
+
+	if (tx)
+		value |= MTK_STAR_BIT_INT_STS_TNTC;
+	if (rx)
+		value |= MTK_STAR_BIT_INT_STS_FNRC;
+
+	regmap_write(priv->regs, MTK_STAR_REG_INT_MASK, value);
+}
+
 /* Unmask the three interrupts we care about, mask all others. */
 static void mtk_star_intr_enable(struct mtk_star_priv *priv)
 {
@@ -429,20 +459,11 @@ static void mtk_star_intr_disable(struct mtk_star_priv *priv)
 	regmap_write(priv->regs, MTK_STAR_REG_INT_MASK, ~0);
 }
 
-static unsigned int mtk_star_intr_read(struct mtk_star_priv *priv)
-{
-	unsigned int val;
-
-	regmap_read(priv->regs, MTK_STAR_REG_INT_STS, &val);
-
-	return val;
-}
-
 static unsigned int mtk_star_intr_ack_all(struct mtk_star_priv *priv)
 {
 	unsigned int val;
 
-	val = mtk_star_intr_read(priv);
+	regmap_read(priv->regs, MTK_STAR_REG_INT_STS, &val);
 	regmap_write(priv->regs, MTK_STAR_REG_INT_STS, val);
 
 	return val;
@@ -714,25 +735,44 @@ static void mtk_star_free_tx_skbs(struct mtk_star_priv *priv)
 	mtk_star_ring_free_skbs(priv, ring, mtk_star_dma_unmap_tx);
 }
 
-/* All processing for TX and RX happens in the napi poll callback.
- *
- * FIXME: The interrupt handling should be more fine-grained with each
- * interrupt enabled/disabled independently when needed. Unfortunatly this
- * turned out to impact the driver's stability and until we have something
- * working properly, we're disabling all interrupts during TX & RX processing
- * or when resetting the counter registers.
- */
+/**
+ * mtk_star_handle_irq - Interrupt Handler.
+ * @irq: interrupt number.
+ * @data: pointer to a network interface device structure.
+ * Description : this is the driver interrupt service routine.
+ * it mainly handles:
+ *  1. tx complete interrupt for frame transmission.
+ *  2. rx complete interrupt for frame reception.
+ *  3. MAC Management Counter interrupt to avoid counter overflow.
+ **/
 static irqreturn_t mtk_star_handle_irq(int irq, void *data)
 {
-	struct mtk_star_priv *priv;
-	struct net_device *ndev;
-
-	ndev = data;
-	priv = netdev_priv(ndev);
+	struct net_device *ndev = data;
+	struct mtk_star_priv *priv = netdev_priv(ndev);
+	unsigned int intr_status = mtk_star_intr_ack_all(priv);
+	bool rx, tx;
+
+	rx = (intr_status & MTK_STAR_BIT_INT_STS_FNRC) &&
+	     napi_schedule_prep(&priv->rx_napi);
+	tx = (intr_status & MTK_STAR_BIT_INT_STS_TNTC) &&
+	     napi_schedule_prep(&priv->tx_napi);
+
+	if (rx || tx) {
+		spin_lock(&priv->lock);
+		/* mask Rx and TX Complete interrupt */
+		mtk_star_disable_dma_irq(priv, rx, tx);
+		spin_unlock(&priv->lock);
+
+		if (rx)
+			__napi_schedule(&priv->rx_napi);
+		if (tx)
+			__napi_schedule(&priv->tx_napi);
+	}
 
-	if (netif_running(ndev)) {
-		mtk_star_intr_disable(priv);
-		napi_schedule(&priv->napi);
+	/* interrupt is triggered once any counters reach 0x8000000 */
+	if (intr_status & MTK_STAR_REG_INT_STS_MIB_CNT_TH) {
+		mtk_star_update_stats(priv);
+		mtk_star_reset_counters(priv);
 	}
 
 	return IRQ_HANDLED;
@@ -955,7 +995,8 @@ static int mtk_star_enable(struct net_device *ndev)
 	if (ret)
 		goto err_free_skbs;
 
-	napi_enable(&priv->napi);
+	napi_enable(&priv->tx_napi);
+	napi_enable(&priv->rx_napi);
 
 	mtk_star_intr_ack_all(priv);
 	mtk_star_intr_enable(priv);
@@ -988,7 +1029,8 @@ static void mtk_star_disable(struct net_device *ndev)
 	struct mtk_star_priv *priv = netdev_priv(ndev);
 
 	netif_stop_queue(ndev);
-	napi_disable(&priv->napi);
+	napi_disable(&priv->tx_napi);
+	napi_disable(&priv->rx_napi);
 	mtk_star_intr_disable(priv);
 	mtk_star_dma_disable(priv);
 	mtk_star_intr_ack_all(priv);
@@ -1020,13 +1062,45 @@ static int mtk_star_netdev_ioctl(struct net_device *ndev,
 	return phy_mii_ioctl(ndev->phydev, req, cmd);
 }
 
-static int mtk_star_netdev_start_xmit(struct sk_buff *skb,
-				      struct net_device *ndev)
+static int __mtk_star_maybe_stop_tx(struct mtk_star_priv *priv, u16 size)
+{
+	netif_stop_queue(priv->ndev);
+
+	/* Might race with mtk_star_tx_poll, check again */
+	smp_mb();
+	if (likely(mtk_star_tx_ring_avail(&priv->tx_ring) < size))
+		return -EBUSY;
+
+	netif_start_queue(priv->ndev);
+
+	return 0;
+}
+
+static inline int mtk_star_maybe_stop_tx(struct mtk_star_priv *priv, u16 size)
+{
+	if (likely(mtk_star_tx_ring_avail(&priv->tx_ring) >= size))
+		return 0;
+
+	return __mtk_star_maybe_stop_tx(priv, size);
+}
+
+static netdev_tx_t mtk_star_netdev_start_xmit(struct sk_buff *skb,
+					      struct net_device *ndev)
 {
 	struct mtk_star_priv *priv = netdev_priv(ndev);
 	struct mtk_star_ring *ring = &priv->tx_ring;
 	struct device *dev = mtk_star_get_dev(priv);
 	struct mtk_star_ring_desc_data desc_data;
+	int nfrags = skb_shinfo(skb)->nr_frags;
+
+	if (unlikely(mtk_star_tx_ring_avail(ring) < nfrags + 1)) {
+		if (!netif_queue_stopped(ndev)) {
+			netif_stop_queue(ndev);
+			/* This is a hard error, log it. */
+			pr_err_ratelimited("Tx ring full when queue awake\n");
+		}
+		return NETDEV_TX_BUSY;
+	}
 
 	desc_data.dma_addr = mtk_star_dma_map_tx(priv, skb);
 	if (dma_mapping_error(dev, desc_data.dma_addr))
@@ -1034,17 +1108,11 @@ static int mtk_star_netdev_start_xmit(struct sk_buff *skb,
 
 	desc_data.skb = skb;
 	desc_data.len = skb->len;
-
-	spin_lock_bh(&priv->lock);
-
 	mtk_star_ring_push_head_tx(ring, &desc_data);
 
 	netdev_sent_queue(ndev, skb->len);
 
-	if (mtk_star_ring_full(ring))
-		netif_stop_queue(ndev);
-
-	spin_unlock_bh(&priv->lock);
+	mtk_star_maybe_stop_tx(priv, MTK_STAR_DESC_NEEDED);
 
 	mtk_star_dma_resume_tx(priv);
 
@@ -1076,31 +1144,41 @@ static int mtk_star_tx_complete_one(struct mtk_star_priv *priv)
 	return ret;
 }
 
-static void mtk_star_tx_complete_all(struct mtk_star_priv *priv)
+static int mtk_star_tx_poll(struct napi_struct *napi, int budget)
 {
+	struct mtk_star_priv *priv = container_of(napi, struct mtk_star_priv,
+						  tx_napi);
+	int ret = 0, pkts_compl = 0, bytes_compl = 0, count = 0;
 	struct mtk_star_ring *ring = &priv->tx_ring;
 	struct net_device *ndev = priv->ndev;
-	int ret, pkts_compl, bytes_compl;
-	bool wake = false;
-
-	spin_lock(&priv->lock);
-
-	for (pkts_compl = 0, bytes_compl = 0;;
-	     pkts_compl++, bytes_compl += ret, wake = true) {
-		if (!mtk_star_ring_descs_available(ring))
-			break;
+	unsigned int head = ring->head;
+	unsigned int entry = ring->tail;
+	unsigned long flags;
 
+	while (entry != head && count < (MTK_STAR_RING_NUM_DESCS - 1)) {
 		ret = mtk_star_tx_complete_one(priv);
 		if (ret < 0)
 			break;
+
+		count++;
+		pkts_compl++;
+		bytes_compl += ret;
+		entry = ring->tail;
 	}
 
 	netdev_completed_queue(ndev, pkts_compl, bytes_compl);
 
-	if (wake && netif_queue_stopped(ndev))
+	if (unlikely(netif_queue_stopped(ndev)) &&
+	    (mtk_star_tx_ring_avail(ring) > MTK_STAR_TX_THRESH))
 		netif_wake_queue(ndev);
 
-	spin_unlock(&priv->lock);
+	if (napi_complete(napi)) {
+		spin_lock_irqsave(&priv->lock, flags);
+		mtk_star_enable_dma_irq(priv, false, true);
+		spin_unlock_irqrestore(&priv->lock, flags);
+	}
+
+	return 0;
 }
 
 static void mtk_star_netdev_get_stats64(struct net_device *ndev,
@@ -1180,7 +1258,7 @@ static const struct ethtool_ops mtk_star_ethtool_ops = {
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 };
 
-static int mtk_star_receive_packet(struct mtk_star_priv *priv)
+static int mtk_star_rx(struct mtk_star_priv *priv, int budget)
 {
 	struct mtk_star_ring *ring = &priv->rx_ring;
 	struct device *dev = mtk_star_get_dev(priv);
@@ -1188,107 +1266,85 @@ static int mtk_star_receive_packet(struct mtk_star_priv *priv)
 	struct net_device *ndev = priv->ndev;
 	struct sk_buff *curr_skb, *new_skb;
 	dma_addr_t new_dma_addr;
-	int ret;
+	int ret, count = 0;
 
-	spin_lock(&priv->lock);
-	ret = mtk_star_ring_pop_tail(ring, &desc_data);
-	spin_unlock(&priv->lock);
-	if (ret)
-		return -1;
+	while (count < budget) {
+		ret = mtk_star_ring_pop_tail(ring, &desc_data);
+		if (ret)
+			return -1;
 
-	curr_skb = desc_data.skb;
+		curr_skb = desc_data.skb;
 
-	if ((desc_data.flags & MTK_STAR_DESC_BIT_RX_CRCE) ||
-	    (desc_data.flags & MTK_STAR_DESC_BIT_RX_OSIZE)) {
-		/* Error packet -> drop and reuse skb. */
-		new_skb = curr_skb;
-		goto push_new_skb;
-	}
+		if ((desc_data.flags & MTK_STAR_DESC_BIT_RX_CRCE) ||
+		    (desc_data.flags & MTK_STAR_DESC_BIT_RX_OSIZE)) {
+			/* Error packet -> drop and reuse skb. */
+			new_skb = curr_skb;
+			goto push_new_skb;
+		}
 
-	/* Prepare new skb before receiving the current one. Reuse the current
-	 * skb if we fail at any point.
-	 */
-	new_skb = mtk_star_alloc_skb(ndev);
-	if (!new_skb) {
-		ndev->stats.rx_dropped++;
-		new_skb = curr_skb;
-		goto push_new_skb;
-	}
+		/* Prepare new skb before receiving the current one.
+		 * Reuse the current skb if we fail at any point.
+		 */
+		new_skb = mtk_star_alloc_skb(ndev);
+		if (!new_skb) {
+			ndev->stats.rx_dropped++;
+			new_skb = curr_skb;
+			goto push_new_skb;
+		}
 
-	new_dma_addr = mtk_star_dma_map_rx(priv, new_skb);
-	if (dma_mapping_error(dev, new_dma_addr)) {
-		ndev->stats.rx_dropped++;
-		dev_kfree_skb(new_skb);
-		new_skb = curr_skb;
-		netdev_err(ndev, "DMA mapping error of RX descriptor\n");
-		goto push_new_skb;
-	}
+		new_dma_addr = mtk_star_dma_map_rx(priv, new_skb);
+		if (dma_mapping_error(dev, new_dma_addr)) {
+			ndev->stats.rx_dropped++;
+			dev_kfree_skb(new_skb);
+			new_skb = curr_skb;
+			netdev_err(ndev, "DMA mapping error of RX descriptor\n");
+			goto push_new_skb;
+		}
 
-	/* We can't fail anymore at this point: it's safe to unmap the skb. */
-	mtk_star_dma_unmap_rx(priv, &desc_data);
+		/* We can't fail anymore at this point:
+		 * it's safe to unmap the skb.
+		 */
+		mtk_star_dma_unmap_rx(priv, &desc_data);
 
-	skb_put(desc_data.skb, desc_data.len);
-	desc_data.skb->ip_summed = CHECKSUM_NONE;
-	desc_data.skb->protocol = eth_type_trans(desc_data.skb, ndev);
-	desc_data.skb->dev = ndev;
-	netif_receive_skb(desc_data.skb);
+		skb_put(desc_data.skb, desc_data.len);
+		desc_data.skb->ip_summed = CHECKSUM_NONE;
+		desc_data.skb->protocol = eth_type_trans(desc_data.skb, ndev);
+		desc_data.skb->dev = ndev;
+		netif_receive_skb(desc_data.skb);
 
-	/* update dma_addr for new skb */
-	desc_data.dma_addr = new_dma_addr;
+		/* update dma_addr for new skb */
+		desc_data.dma_addr = new_dma_addr;
 
 push_new_skb:
-	desc_data.len = skb_tailroom(new_skb);
-	desc_data.skb = new_skb;
 
-	spin_lock(&priv->lock);
-	mtk_star_ring_push_head_rx(ring, &desc_data);
-	spin_unlock(&priv->lock);
-
-	return 0;
-}
-
-static int mtk_star_process_rx(struct mtk_star_priv *priv, int budget)
-{
-	int received, ret;
+		count++;
 
-	for (received = 0, ret = 0; received < budget && ret == 0; received++)
-		ret = mtk_star_receive_packet(priv);
+		desc_data.len = skb_tailroom(new_skb);
+		desc_data.skb = new_skb;
+		mtk_star_ring_push_head_rx(ring, &desc_data);
+	}
 
 	mtk_star_dma_resume_rx(priv);
 
-	return received;
+	return count;
 }
 
-static int mtk_star_poll(struct napi_struct *napi, int budget)
+static int mtk_star_rx_poll(struct napi_struct *napi, int budget)
 {
 	struct mtk_star_priv *priv;
-	unsigned int status;
-	int received = 0;
-
-	priv = container_of(napi, struct mtk_star_priv, napi);
-
-	status = mtk_star_intr_read(priv);
-	mtk_star_intr_ack_all(priv);
-
-	if (status & MTK_STAR_BIT_INT_STS_TNTC)
-		/* Clean-up all TX descriptors. */
-		mtk_star_tx_complete_all(priv);
+	unsigned long flags;
+	int work_done = 0;
 
-	if (status & MTK_STAR_BIT_INT_STS_FNRC)
-		/* Receive up to $budget packets. */
-		received = mtk_star_process_rx(priv, budget);
+	priv = container_of(napi, struct mtk_star_priv, rx_napi);
 
-	if (unlikely(status & MTK_STAR_REG_INT_STS_MIB_CNT_TH)) {
-		mtk_star_update_stats(priv);
-		mtk_star_reset_counters(priv);
+	work_done = mtk_star_rx(priv, budget);
+	if (work_done < budget && napi_complete_done(napi, work_done)) {
+		spin_lock_irqsave(&priv->lock, flags);
+		mtk_star_enable_dma_irq(priv, true, false);
+		spin_unlock_irqrestore(&priv->lock, flags);
 	}
 
-	if (received < budget)
-		napi_complete_done(napi, received);
-
-	mtk_star_intr_enable(priv);
-
-	return received;
+	return work_done;
 }
 
 static void mtk_star_mdio_rwok_clear(struct mtk_star_priv *priv)
@@ -1551,7 +1607,10 @@ static int mtk_star_probe(struct platform_device *pdev)
 	ndev->netdev_ops = &mtk_star_netdev_ops;
 	ndev->ethtool_ops = &mtk_star_ethtool_ops;
 
-	netif_napi_add(ndev, &priv->napi, mtk_star_poll, NAPI_POLL_WEIGHT);
+	netif_napi_add(ndev, &priv->rx_napi, mtk_star_rx_poll,
+		       NAPI_POLL_WEIGHT);
+	netif_tx_napi_add(ndev, &priv->tx_napi, mtk_star_tx_poll,
+			  NAPI_POLL_WEIGHT);
 
 	phydev = of_phy_find_device(priv->phy_node);
 	if (phydev) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 829f703233a9..766a05f557fb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3138,7 +3138,9 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	int err;
 
 	mutex_init(&esw->offloads.termtbl_mutex);
-	mlx5_rdma_enable_roce(esw->dev);
+	err = mlx5_rdma_enable_roce(esw->dev);
+	if (err)
+		goto err_roce;
 
 	err = mlx5_esw_host_number_init(esw);
 	if (err)
@@ -3198,6 +3200,7 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 	esw_offloads_metadata_uninit(esw);
 err_metadata:
 	mlx5_rdma_disable_roce(esw->dev);
+err_roce:
 	mutex_destroy(&esw->offloads.termtbl_mutex);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
index 540cf05f6373..e61a4fa46d77 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
@@ -130,8 +130,8 @@ static void mlx5_rdma_make_default_gid(struct mlx5_core_dev *dev, union ib_gid *
 
 static int mlx5_rdma_add_roce_addr(struct mlx5_core_dev *dev)
 {
+	u8 mac[ETH_ALEN] = {};
 	union ib_gid gid;
-	u8 mac[ETH_ALEN];
 
 	mlx5_rdma_make_default_gid(dev, &gid);
 	return mlx5_core_roce_gid_set(dev, 0,
@@ -152,17 +152,17 @@ void mlx5_rdma_disable_roce(struct mlx5_core_dev *dev)
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
@@ -177,10 +177,11 @@ void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev)
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
index a3392c74372a..fe919c197450 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1448,6 +1448,7 @@ static void lan743x_tx_frame_add_lso(struct lan743x_tx *tx,
 	if (nr_frags <= 0) {
 		tx->frame_data0 |= TX_DESC_DATA0_LS_;
 		tx->frame_data0 |= TX_DESC_DATA0_IOC_;
+		tx->frame_last = tx->frame_first;
 	}
 	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
 	tx_descriptor->data0 = cpu_to_le32(tx->frame_data0);
@@ -1517,6 +1518,7 @@ static int lan743x_tx_frame_add_fragment(struct lan743x_tx *tx,
 		tx->frame_first = 0;
 		tx->frame_data0 = 0;
 		tx->frame_tail = 0;
+		tx->frame_last = 0;
 		return -ENOMEM;
 	}
 
@@ -1557,16 +1559,18 @@ static void lan743x_tx_frame_end(struct lan743x_tx *tx,
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
index 6080028c1df2..a1226ab0fb42 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -658,6 +658,7 @@ struct lan743x_tx {
 	u32		frame_first;
 	u32		frame_data0;
 	u32		frame_tail;
+	u32		frame_last;
 
 	struct lan743x_tx_buffer_info *buffer_info;
 
diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index 230f2fcf9c46..7c8bcec0a8fa 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -31,47 +31,6 @@ static int lan88xx_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, LAN88XX_EXT_PAGE_ACCESS, page);
 }
 
-static int lan88xx_phy_config_intr(struct phy_device *phydev)
-{
-	int rc;
-
-	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
-		/* unmask all source and clear them before enable */
-		rc = phy_write(phydev, LAN88XX_INT_MASK, 0x7FFF);
-		rc = phy_read(phydev, LAN88XX_INT_STS);
-		rc = phy_write(phydev, LAN88XX_INT_MASK,
-			       LAN88XX_INT_MASK_MDINTPIN_EN_ |
-			       LAN88XX_INT_MASK_LINK_CHANGE_);
-	} else {
-		rc = phy_write(phydev, LAN88XX_INT_MASK, 0);
-		if (rc)
-			return rc;
-
-		/* Ack interrupts after they have been disabled */
-		rc = phy_read(phydev, LAN88XX_INT_STS);
-	}
-
-	return rc < 0 ? rc : 0;
-}
-
-static irqreturn_t lan88xx_handle_interrupt(struct phy_device *phydev)
-{
-	int irq_status;
-
-	irq_status = phy_read(phydev, LAN88XX_INT_STS);
-	if (irq_status < 0) {
-		phy_error(phydev);
-		return IRQ_NONE;
-	}
-
-	if (!(irq_status & LAN88XX_INT_STS_LINK_CHANGE_))
-		return IRQ_NONE;
-
-	phy_trigger_machine(phydev);
-
-	return IRQ_HANDLED;
-}
-
 static int lan88xx_suspend(struct phy_device *phydev)
 {
 	struct lan88xx_priv *priv = phydev->priv;
@@ -388,8 +347,9 @@ static struct phy_driver microchip_phy_driver[] = {
 	.config_aneg	= lan88xx_config_aneg,
 	.link_change_notify = lan88xx_link_change_notify,
 
-	.config_intr	= lan88xx_phy_config_intr,
-	.handle_interrupt = lan88xx_handle_interrupt,
+	/* Interrupt handling is broken, do not define related
+	 * functions to force polling.
+	 */
 
 	.suspend	= lan88xx_suspend,
 	.resume		= genphy_resume,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 9fb68c2dc7e3..8c12aaffe719 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -903,14 +903,16 @@ brcmf_usb_dl_writeimage(struct brcmf_usbdev_info *devinfo, u8 *fw, int fwlen)
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
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0fc5aba88bc1..99bf17f2dcfc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1602,7 +1602,7 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	cancel_work_sync(&queue->io_work);
 }
 
-static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
+static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
@@ -1613,6 +1613,31 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
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
@@ -1720,7 +1745,9 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->queue_count; i++)
-		nvme_tcp_stop_queue(ctrl, i);
+		nvme_tcp_stop_queue_nowait(ctrl, i);
+	for (i = 1; i < ctrl->queue_count; i++)
+		nvme_tcp_wait_queue(ctrl, i);
 }
 
 static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl)
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 19c42a9dcba9..f503bb10b10b 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -257,14 +257,15 @@ static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len
 	csize = snprintf(str, len, "of:N%pOFn%c%s", dev->of_node, 'T',
 			 of_node_get_device_type(dev->of_node));
 	tsize = csize;
+	if (csize >= len)
+		csize = len > 0 ? len - 1 : 0;
 	len -= csize;
-	if (str)
-		str += csize;
+	str += csize;
 
 	of_property_for_each_string(dev->of_node, "compatible", p, compat) {
 		csize = strlen(compat) + 1;
 		tsize += csize;
-		if (csize > len)
+		if (csize >= len)
 			continue;
 
 		csize = snprintf(str, len, "C%s", compat);
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6a3336f2105b..7766b5b14929 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1070,11 +1070,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		if (IS_ERR(imx6_pcie->pcie_aux))
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
 					     "pcie_aux clock source missing or invalid\n");
-		fallthrough;
-	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
-
+		fallthrough;
+	case IMX7D:
 		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
 									    "pciephy");
 		if (IS_ERR(imx6_pcie->pciephy_reset)) {
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 014860716605..538009a83c97 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -447,6 +447,9 @@ fd_execute_write_same(struct se_cmd *cmd)
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 	}
 
+	if (!cmd->t_data_nents)
+		return TCM_INVALID_CDB_FIELD;
+
 	if (cmd->t_data_nents > 1 ||
 	    cmd->t_data_sg[0].length != cmd->se_dev->dev_attrib.block_size) {
 		pr_err("WRITE_SAME: Illegal SGL t_data_nents: %u length: %u"
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 4069a1edcfa3..1555f6cf55a1 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -496,6 +496,10 @@ iblock_execute_write_same(struct se_cmd *cmd)
 		       " backends not supported\n");
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 	}
+
+	if (!cmd->t_data_nents)
+		return TCM_INVALID_CDB_FIELD;
+
 	sg = &cmd->t_data_sg[0];
 
 	if (cmd->t_data_nents > 1 ||
diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_core_sbc.c
index ca1b2312d6e7..f6132836eb38 100644
--- a/drivers/target/target_core_sbc.c
+++ b/drivers/target/target_core_sbc.c
@@ -312,6 +312,12 @@ sbc_setup_write_same(struct se_cmd *cmd, unsigned char flags, struct sbc_ops *op
 		pr_warn("WRITE SAME with ANCHOR not supported\n");
 		return TCM_INVALID_CDB_FIELD;
 	}
+
+	if (flags & 0x01) {
+		pr_warn("WRITE SAME with NDOB not supported\n");
+		return TCM_INVALID_CDB_FIELD;
+	}
+
 	/*
 	 * Special case for WRITE_SAME w/ UNMAP=1 that ends up getting
 	 * translated into block discard requests within backend code.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3727a926b7fa..baf2867e6dbe 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7034,13 +7034,14 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
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
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 1a57dd8aa513..612da8ec1081 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -245,6 +245,62 @@ static struct sk_buff *__udpv4_gso_segment_list_csum(struct sk_buff *segs)
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
@@ -257,7 +313,10 @@ static struct sk_buff *__udp_gso_segment_list(struct sk_buff *skb,
 
 	udp_hdr(skb)->len = htons(sizeof(struct udphdr) + mss);
 
-	return is_ipv6 ? skb : __udpv4_gso_segment_list_csum(skb);
+	if (is_ipv6)
+		return __udpv6_gso_segment_list_csum(skb);
+	else
+		return __udpv4_gso_segment_list_csum(skb);
 }
 
 struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 97cd4b2377d6..1aa1d10de30e 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -254,31 +254,31 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 
 	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
 	m_eaction = READ_ONCE(m->tcfm_eaction);
+	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
 	retval = READ_ONCE(m->tcf_action);
 	dev = rcu_dereference_bh(m->tcfm_dev);
 	if (unlikely(!dev)) {
 		pr_notice_once("tc mirred: target device is gone\n");
-		goto out;
+		goto err_cant_do;
 	}
 
 	if (unlikely(!(dev->flags & IFF_UP)) || !netif_carrier_ok(dev)) {
 		net_notice_ratelimited("tc mirred to Houston: device %s is down\n",
 				       dev->name);
-		goto out;
+		goto err_cant_do;
 	}
 
 	/* we could easily avoid the clone only if called by ingress and clsact;
 	 * since we can't easily detect the clsact caller, skip clone only for
 	 * ingress - that covers the TC S/W datapath.
 	 */
-	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
 	at_ingress = skb_at_tc_ingress(skb);
 	use_reinsert = at_ingress && is_redirect &&
 		       tcf_mirred_can_reinsert(retval);
 	if (!use_reinsert) {
 		skb2 = skb_clone(skb, GFP_ATOMIC);
 		if (!skb2)
-			goto out;
+			goto err_cant_do;
 	}
 
 	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
@@ -321,12 +321,16 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 	}
 
 	err = tcf_mirred_forward(want_ingress, skb2);
-	if (err) {
-out:
+	if (err)
 		tcf_action_inc_overlimit_qstats(&m->common);
-		if (tcf_mirred_is_act_redirect(m_eaction))
-			retval = TC_ACT_SHOT;
-	}
+	__this_cpu_dec(mirred_nest_level);
+
+	return retval;
+
+err_cant_do:
+	if (is_redirect)
+		retval = TC_ACT_SHOT;
+	tcf_action_inc_overlimit_qstats(&m->common);
 	__this_cpu_dec(mirred_nest_level);
 
 	return retval;
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 80a88e208d2b..e33a72c356c8 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -36,6 +36,11 @@ struct drr_sched {
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
@@ -345,7 +350,6 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct drr_sched *q = qdisc_priv(sch);
 	struct drr_class *cl;
 	int err = 0;
-	bool first;
 
 	cl = drr_classify(skb, sch, &err);
 	if (cl == NULL) {
@@ -355,7 +359,6 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	first = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		if (net_xmit_drop_count(err)) {
@@ -365,7 +368,7 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	if (first) {
+	if (!cl_is_active(cl)) {
 		list_add_tail(&cl->alist, &q->active);
 		cl->deficit = cl->quantum;
 	}
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index d686ea7e8db4..07fae45f5873 100644
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
@@ -424,7 +429,6 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct ets_sched *q = qdisc_priv(sch);
 	struct ets_class *cl;
 	int err = 0;
-	bool first;
 
 	cl = ets_classify(skb, sch, &err);
 	if (!cl) {
@@ -434,7 +438,6 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	first = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		if (net_xmit_drop_count(err)) {
@@ -444,7 +447,7 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	if (first && !ets_class_is_strict(q, cl)) {
+	if (!cl_is_active(cl) && !ets_class_is_strict(q, cl)) {
 		list_add_tail(&cl->alist, &q->active);
 		cl->deficit = cl->quantum;
 	}
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 85c296664c9a..d6c5fc543f65 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1572,7 +1572,7 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		return err;
 	}
 
-	if (first) {
+	if (first && !cl->cl_nactive) {
 		if (cl->cl_flags & HFSC_RSC)
 			init_ed(cl, len);
 		if (cl->cl_flags & HFSC_FSC)
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index b1dbe03dde1b..a198145f1251 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -204,6 +204,11 @@ struct qfq_sched {
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
@@ -1223,7 +1228,6 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct qfq_class *cl;
 	struct qfq_aggregate *agg;
 	int err = 0;
-	bool first;
 
 	cl = qfq_classify(skb, sch, &err);
 	if (cl == NULL) {
@@ -1245,7 +1249,6 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	gso_segs = skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
-	first = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		pr_debug("qfq_enqueue: enqueue failed %d\n", err);
@@ -1262,8 +1265,8 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	++sch->q.qlen;
 
 	agg = cl->agg;
-	/* if the queue was not empty, then done here */
-	if (!first) {
+	/* if the class is active, then done here */
+	if (cl_is_active(cl)) {
 		if (unlikely(skb == cl->qdisc->ops->peek(cl->qdisc)) &&
 		    list_first_entry(&agg->active, struct qfq_class, alist)
 		    == cl && cl->deficit < len)
diff --git a/sound/usb/format.c b/sound/usb/format.c
index 3b3a5ea6fcbf..f33d25a4e4cc 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -263,7 +263,8 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 	}
 
 	/* Jabra Evolve 65 headset */
-	if (chip->usb_id == USB_ID(0x0b0e, 0x030b)) {
+	if (chip->usb_id == USB_ID(0x0b0e, 0x030b) ||
+	    chip->usb_id == USB_ID(0x0b0e, 0x030c)) {
 		/* only 48kHz for playback while keeping 16kHz for capture */
 		if (fp->nr_rates != 1)
 			return set_fixed_rate(fp, 48000, SNDRV_PCM_RATE_48000);

