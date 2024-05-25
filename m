Return-Path: <stable+bounces-46136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BBB8CEF6D
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 16:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60870B210AB
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4644F5FDB5;
	Sat, 25 May 2024 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GKz0+vnV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028A861674;
	Sat, 25 May 2024 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648507; cv=none; b=WWxqycOCAmO/pfXM6hnwJWsxbUYww43tz6lqMWqpvXUoPWcOqu95xPN0gTRxPL7PN+/hkRiWKTOtgDzE/hM8n+h7h96HulH8GB6ivhKuyiQo8XcBWTKEfwKVMD6fuBlWiz3FSMpJL+6Z2WoiITmwHiLcL1KmR68BaoJ34p/eG9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648507; c=relaxed/simple;
	bh=02FRPgyoZ/V8qxNIlpA+yMHYsj2RMaCV+O/GoHIbEaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIFfDcAKZijet4rQKzSZYSUYqPHX5/L712RaYeBxAc9SwUJ5myDFDt53B1mFP/jcDfqywX8aGa4ilkOj4GTEiT1D50ZMV0CrJchcIVPKzrMWnhljUtI9RCb3oedwHeaXRtTzwf6L+jSq8jP5paXOBVVjQIsEa1XRzWZXOQ1bEvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GKz0+vnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A405C2BD11;
	Sat, 25 May 2024 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716648506;
	bh=02FRPgyoZ/V8qxNIlpA+yMHYsj2RMaCV+O/GoHIbEaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GKz0+vnVk1Pyrl+3l/3dVprEQ6xbOEwv7U7exKSvAotJ2J8HHCgrJhkg5LmJdCrKG
	 3ykSJ7QN8TMEcT+ieECy91vxk+9lA7I80SzNlCe7SvyiT4xN/2m1toRIoMdg200/JV
	 O+cFcA/nNm0v+maAOrot4JFWe1q446n5yAMXQAjs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.218
Date: Sat, 25 May 2024 16:48:14 +0200
Message-ID: <2024052513-domelike-evaluate-a942@gregkh>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <2024052513-everybody-glory-b3dd@gregkh>
References: <2024052513-everybody-glory-b3dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index f523aa68a36b..cf601bd058ab 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -94,7 +94,6 @@ class KernelInclude(Include):
         # HINT: this is the only line I had to change / commented out:
         #path = utils.relative_path(None, path)
 
-        path = nodes.reprunicode(path)
         encoding = self.options.get(
             'encoding', self.state.document.settings.input_encoding)
         e_handler=self.state.document.settings.input_encoding_error_handler
diff --git a/Makefile b/Makefile
index d9557382a028..3bc56bf43c82 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 217
+SUBLEVEL = 218
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1631a9a1566e..bd785386d629 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -46,14 +46,6 @@
 .code64
 .section .entry.text, "ax"
 
-#ifdef CONFIG_PARAVIRT_XXL
-SYM_CODE_START(native_usergs_sysret64)
-	UNWIND_HINT_EMPTY
-	swapgs
-	sysretq
-SYM_CODE_END(native_usergs_sysret64)
-#endif /* CONFIG_PARAVIRT_XXL */
-
 /*
  * 64-bit SYSCALL instruction entry. Up to 6 arguments in registers.
  *
@@ -128,7 +120,12 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	 * Try to use SYSRET instead of IRET if we're returning to
 	 * a completely clean 64-bit userspace context.  If we're not,
 	 * go to the slow exit path.
+	 * In the Xen PV case we must use iret anyway.
 	 */
+
+	ALTERNATIVE "", "jmp	swapgs_restore_regs_and_return_to_usermode", \
+		X86_FEATURE_XENPV
+
 	movq	RCX(%rsp), %rcx
 	movq	RIP(%rsp), %r11
 
@@ -220,7 +217,9 @@ syscall_return_via_sysret:
 
 	popq	%rdi
 	popq	%rsp
-	USERGS_SYSRET64
+	swapgs
+	CLEAR_CPU_BUFFERS
+	sysretq
 SYM_CODE_END(entry_SYSCALL_64)
 
 /*
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index f40dea50dfbf..e585a4705b8d 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -132,13 +132,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 #endif
 
 #define INTERRUPT_RETURN	jmp native_iret
-#define USERGS_SYSRET64				\
-	swapgs;					\
-	CLEAR_CPU_BUFFERS;			\
-	sysretq;
-#define USERGS_SYSRET32				\
-	swapgs;					\
-	sysretl
 
 #else
 #define INTERRUPT_RETURN		iret
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 4a32b0d34376..3c89c1f64871 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -776,11 +776,6 @@ extern void default_banner(void);
 
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_PARAVIRT_XXL
-#define USERGS_SYSRET64							\
-	PARA_SITE(PARA_PATCH(PV_CPU_usergs_sysret64),			\
-		  ANNOTATE_RETPOLINE_SAFE;				\
-		  jmp PARA_INDIRECT(pv_ops+PV_CPU_usergs_sysret64);)
-
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(clobbers)                                        \
 	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),			    \
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 903d71884fa2..55d8b7950e61 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -157,14 +157,6 @@ struct pv_cpu_ops {
 
 	u64 (*read_pmc)(int counter);
 
-	/*
-	 * Switch to usermode gs and return to 64-bit usermode using
-	 * sysret.  Only used in 64-bit kernels to return to 64-bit
-	 * processes.  Usermode register state, including %rsp, must
-	 * already be restored.
-	 */
-	void (*usergs_sysret64)(void);
-
 	/* Normal iret.  Jump to this with the standard iret stack
 	   frame set up. */
 	void (*iret)(void);
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index 1354bc30614d..b14533af7676 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -13,8 +13,6 @@ int main(void)
 {
 #ifdef CONFIG_PARAVIRT
 #ifdef CONFIG_PARAVIRT_XXL
-	OFFSET(PV_CPU_usergs_sysret64, paravirt_patch_template,
-	       cpu.usergs_sysret64);
 #ifdef CONFIG_DEBUG_ENTRY
 	OFFSET(PV_IRQ_save_fl, paravirt_patch_template, irq.save_fl);
 #endif
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index f0e4ad8595ca..9d91061b862c 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -124,8 +124,7 @@ unsigned paravirt_patch_default(u8 type, void *insn_buff,
 	else if (opfunc == _paravirt_ident_64)
 		ret = paravirt_patch_ident_64(insn_buff, len);
 
-	else if (type == PARAVIRT_PATCH(cpu.iret) ||
-		 type == PARAVIRT_PATCH(cpu.usergs_sysret64))
+	else if (type == PARAVIRT_PATCH(cpu.iret))
 		/* If operation requires a jmp, then jmp */
 		ret = paravirt_patch_jmp(insn_buff, opfunc, addr, len);
 #endif
@@ -159,7 +158,6 @@ static u64 native_steal_clock(int cpu)
 
 /* These are in entry.S */
 extern void native_iret(void);
-extern void native_usergs_sysret64(void);
 
 static struct resource reserve_ioports = {
 	.start = 0,
@@ -299,7 +297,6 @@ struct paravirt_patch_template pv_ops = {
 
 	.cpu.load_sp0		= native_load_sp0,
 
-	.cpu.usergs_sysret64	= native_usergs_sysret64,
 	.cpu.iret		= native_iret,
 
 #ifdef CONFIG_X86_IOPL_IOPERM
diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravirt_patch.c
index 7c518b08aa3c..2fada2c347c9 100644
--- a/arch/x86/kernel/paravirt_patch.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -27,7 +27,6 @@ struct patch_xxl {
 	const unsigned char	mmu_write_cr3[3];
 	const unsigned char	irq_restore_fl[2];
 	const unsigned char	cpu_wbinvd[2];
-	const unsigned char	cpu_usergs_sysret64[6];
 	const unsigned char	mov64[3];
 };
 
@@ -40,8 +39,6 @@ static const struct patch_xxl patch_data_xxl = {
 	.mmu_write_cr3		= { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
 	.irq_restore_fl		= { 0x57, 0x9d },	// push %rdi; popfq
 	.cpu_wbinvd		= { 0x0f, 0x09 },	// wbinvd
-	.cpu_usergs_sysret64	= { 0x0f, 0x01, 0xf8,
-				    0x48, 0x0f, 0x07 },	// swapgs; sysretq
 	.mov64			= { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
 };
 
@@ -83,7 +80,6 @@ unsigned int native_patch(u8 type, void *insn_buff, unsigned long addr,
 	PATCH_CASE(mmu, read_cr3, xxl, insn_buff, len);
 	PATCH_CASE(mmu, write_cr3, xxl, insn_buff, len);
 
-	PATCH_CASE(cpu, usergs_sysret64, xxl, insn_buff, len);
 	PATCH_CASE(cpu, wbinvd, xxl, insn_buff, len);
 #endif
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8e0b957c6219..bc295439360e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8501,13 +8501,20 @@ static void update_cr8_intercept(struct kvm_vcpu *vcpu)
 
 static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 {
+	/*
+	 * Suppress the error code if the vCPU is in Real Mode, as Real Mode
+	 * exceptions don't report error codes.  The presence of an error code
+	 * is carried with the exception and only stripped when the exception
+	 * is injected as intercepted #PF VM-Exits for AMD's Paged Real Mode do
+	 * report an error code despite the CPU being in Real Mode.
+	 */
+	vcpu->arch.exception.has_error_code &= is_protmode(vcpu);
+
 	trace_kvm_inj_exception(vcpu->arch.exception.nr,
 				vcpu->arch.exception.has_error_code,
 				vcpu->arch.exception.error_code,
 				vcpu->arch.exception.injected);
 
-	if (vcpu->arch.exception.error_code && !is_protmode(vcpu))
-		vcpu->arch.exception.error_code = false;
 	kvm_x86_ops.queue_exception(vcpu);
 }
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 94804670caab..b1efc4b4f42a 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1059,7 +1059,6 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 	.read_pmc = xen_read_pmc,
 
 	.iret = xen_iret,
-	.usergs_sysret64 = xen_sysret64,
 
 	.load_tr_desc = paravirt_nop,
 	.set_ldt = xen_set_ldt,
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index e3031afcb103..3a33713cf449 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -220,27 +220,6 @@ SYM_CODE_START(xen_iret)
 	jmp hypercall_iret
 SYM_CODE_END(xen_iret)
 
-SYM_CODE_START(xen_sysret64)
-	UNWIND_HINT_EMPTY
-	/*
-	 * We're already on the usermode stack at this point, but
-	 * still with the kernel gs, so we can easily switch back.
-	 *
-	 * tss.sp2 is scratch space.
-	 */
-	movq %rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
-	movq PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-
-	pushq $__USER_DS
-	pushq PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
-	pushq %r11
-	pushq $__USER_CS
-	pushq %rcx
-
-	pushq $VGCF_in_syscall
-	jmp hypercall_iret
-SYM_CODE_END(xen_sysret64)
-
 /*
  * XEN pv doesn't use trampoline stack, PER_CPU_VAR(cpu_tss_rw + TSS_sp0) is
  * also the kernel stack.  Reusing swapgs_restore_regs_and_return_to_usermode()
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 8695809b88f0..98242430d07e 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -138,8 +138,6 @@ __visible unsigned long xen_read_cr2_direct(void);
 
 /* These are not functions, and cannot be called normally */
 __visible void xen_iret(void);
-__visible void xen_sysret32(void);
-__visible void xen_sysret64(void);
 
 extern int xen_panic_handler_init(void);
 
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index a981a22cfe89..b8388a3b9c06 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -149,8 +149,12 @@ static int scmi_domain_reset(const struct scmi_handle *handle, u32 domain,
 	struct scmi_xfer *t;
 	struct scmi_msg_reset_domain_reset *dom;
 	struct scmi_reset_info *pi = handle->reset_priv;
-	struct reset_dom_info *rdom = pi->dom_info + domain;
+	struct reset_dom_info *rdom;
 
+	if (domain >= pi->num_domains)
+		return -EINVAL;
+
+	rdom = pi->dom_info + domain;
 	if (rdom->async_reset)
 		flags |= ASYNCHRONOUS_RESET;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a8f1c4969fac..e971d2b9e3c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -765,6 +765,9 @@ int amdgpu_ras_error_query(struct amdgpu_device *adev,
 	if (!obj)
 		return -EINVAL;
 
+	if (!info || info->head.block == AMDGPU_RAS_BLOCK_COUNT)
+		return -EINVAL;
+
 	switch (info->head.block) {
 	case AMDGPU_RAS_BLOCK__UMC:
 		if (adev->umc.funcs->query_ras_error_count)
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 89dc69d1807e..2fc21aae1004 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2420,14 +2420,18 @@ static void umac_enable_set(struct bcmgenet_priv *priv, u32 mask, bool enable)
 {
 	u32 reg;
 
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
-	if (reg & CMD_SW_RESET)
+	if (reg & CMD_SW_RESET) {
+		spin_unlock_bh(&priv->reg_lock);
 		return;
+	}
 	if (enable)
 		reg |= mask;
 	else
 		reg &= ~mask;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 
 	/* UniMAC stops on a packet boundary, wait for a full-size packet
 	 * to be processed
@@ -2443,8 +2447,10 @@ static void reset_umac(struct bcmgenet_priv *priv)
 	udelay(10);
 
 	/* issue soft reset and disable MAC while updating its registers */
+	spin_lock_bh(&priv->reg_lock);
 	bcmgenet_umac_writel(priv, CMD_SW_RESET, UMAC_CMD);
 	udelay(2);
+	spin_unlock_bh(&priv->reg_lock);
 }
 
 static void bcmgenet_intr_disable(struct bcmgenet_priv *priv)
@@ -3572,16 +3578,19 @@ static void bcmgenet_set_rx_mode(struct net_device *dev)
 	 * 3. The number of filters needed exceeds the number filters
 	 *    supported by the hardware.
 	*/
+	spin_lock(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	if ((dev->flags & (IFF_PROMISC | IFF_ALLMULTI)) ||
 	    (nfilter > MAX_MDF_FILTER)) {
 		reg |= CMD_PROMISC;
 		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+		spin_unlock(&priv->reg_lock);
 		bcmgenet_umac_writel(priv, 0, UMAC_MDF_CTRL);
 		return;
 	} else {
 		reg &= ~CMD_PROMISC;
 		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+		spin_unlock(&priv->reg_lock);
 	}
 
 	/* update MDF filter */
@@ -3975,6 +3984,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	spin_lock_init(&priv->reg_lock);
 	spin_lock_init(&priv->lock);
 
 	SET_NETDEV_DEV(dev, &pdev->dev);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index c7853d5304b0..82f9fdf59103 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -627,6 +627,8 @@ struct bcmgenet_rxnfc_rule {
 /* device context */
 struct bcmgenet_priv {
 	void __iomem *base;
+	/* reg_lock: lock to serialize access to shared registers */
+	spinlock_t reg_lock;
 	enum bcmgenet_version version;
 	struct net_device *dev;
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index 2c2a56d5a0a1..35c12938cb34 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -134,6 +134,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Can't suspend with WoL if MAC is still in reset */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	if (reg & CMD_SW_RESET)
 		reg &= ~CMD_SW_RESET;
@@ -141,6 +142,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	/* disable RX */
 	reg &= ~CMD_RX_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 	mdelay(10);
 
 	if (priv->wolopts & (WAKE_MAGIC | WAKE_MAGICSECURE)) {
@@ -186,6 +188,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Enable CRC forward */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	priv->crc_fwd_en = 1;
 	reg |= CMD_CRC_FWD;
@@ -193,6 +196,7 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 	/* Receiver must be enabled for WOL MP detection */
 	reg |= CMD_RX_EN;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 
 	reg = UMAC_IRQ_MPD_R;
 	if (hfb_enable)
@@ -239,7 +243,9 @@ void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 	}
 
 	/* Disable CRC Forward */
+	spin_lock_bh(&priv->reg_lock);
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	reg &= ~CMD_CRC_FWD;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	spin_unlock_bh(&priv->reg_lock);
 }
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index becc717aad13..1e07f57ff3ed 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -91,6 +91,7 @@ void bcmgenet_mii_setup(struct net_device *dev)
 		reg |= RGMII_LINK;
 		bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
 
+		spin_lock_bh(&priv->reg_lock);
 		reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 		reg &= ~((CMD_SPEED_MASK << CMD_SPEED_SHIFT) |
 			       CMD_HD_EN |
@@ -103,6 +104,7 @@ void bcmgenet_mii_setup(struct net_device *dev)
 			reg |= CMD_TX_EN | CMD_RX_EN;
 		}
 		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+		spin_unlock_bh(&priv->reg_lock);
 
 		priv->eee.eee_active = phy_init_eee(phydev, 0) >= 0;
 		bcmgenet_eee_enable_set(dev,
@@ -264,6 +266,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 	 * block for the interface to work
 	 */
 	if (priv->ext_phy) {
+		mutex_lock(&phydev->lock);
 		reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
 		reg &= ~ID_MODE_DIS;
 		reg |= id_mode_dis;
@@ -272,6 +275,7 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 		else
 			reg |= RGMII_MODE_EN;
 		bcmgenet_ext_writel(priv, reg, EXT_RGMII_OOB_CTRL);
+		mutex_unlock(&phydev->lock);
 	}
 
 	if (init)
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 4d46260e6bff..ee99dc56c544 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -205,6 +205,7 @@ static int pinctrl_register_one_pin(struct pinctrl_dev *pctldev,
 				    const struct pinctrl_pin_desc *pin)
 {
 	struct pin_desc *pindesc;
+	int error;
 
 	pindesc = pin_desc_get(pctldev, pin->number);
 	if (pindesc) {
@@ -226,18 +227,25 @@ static int pinctrl_register_one_pin(struct pinctrl_dev *pctldev,
 	} else {
 		pindesc->name = kasprintf(GFP_KERNEL, "PIN%u", pin->number);
 		if (!pindesc->name) {
-			kfree(pindesc);
-			return -ENOMEM;
+			error = -ENOMEM;
+			goto failed;
 		}
 		pindesc->dynamic_name = true;
 	}
 
 	pindesc->drv_data = pin->drv_data;
 
-	radix_tree_insert(&pctldev->pin_desc_tree, pin->number, pindesc);
+	error = radix_tree_insert(&pctldev->pin_desc_tree, pin->number, pindesc);
+	if (error)
+		goto failed;
+
 	pr_debug("registered pin %d (%s) on %s\n",
 		 pin->number, pindesc->name, pctldev->desc->name);
 	return 0;
+
+failed:
+	kfree(pindesc);
+	return error;
 }
 
 static int pinctrl_register_pins(struct pinctrl_dev *pctldev,
diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 79b7db8580e0..d988511f8b32 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -19,6 +19,7 @@
 #include <linux/console.h>
 #include <linux/vt_kern.h>
 #include <linux/input.h>
+#include <linux/irq_work.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
@@ -48,6 +49,25 @@ static struct kgdb_io		kgdboc_earlycon_io_ops;
 static int                      (*earlycon_orig_exit)(struct console *con);
 #endif /* IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
 
+/*
+ * When we leave the debug trap handler we need to reset the keyboard status
+ * (since the original keyboard state gets partially clobbered by kdb use of
+ * the keyboard).
+ *
+ * The path to deliver the reset is somewhat circuitous.
+ *
+ * To deliver the reset we register an input handler, reset the keyboard and
+ * then deregister the input handler. However, to get this done right, we do
+ * have to carefully manage the calling context because we can only register
+ * input handlers from task context.
+ *
+ * In particular we need to trigger the action from the debug trap handler with
+ * all its NMI and/or NMI-like oddities. To solve this the kgdboc trap exit code
+ * (the "post_exception" callback) uses irq_work_queue(), which is NMI-safe, to
+ * schedule a callback from a hardirq context. From there we have to defer the
+ * work again, this time using schedule_work(), to get a callback using the
+ * system workqueue, which runs in task context.
+ */
 #ifdef CONFIG_KDB_KEYBOARD
 static int kgdboc_reset_connect(struct input_handler *handler,
 				struct input_dev *dev,
@@ -99,10 +119,17 @@ static void kgdboc_restore_input_helper(struct work_struct *dummy)
 
 static DECLARE_WORK(kgdboc_restore_input_work, kgdboc_restore_input_helper);
 
+static void kgdboc_queue_restore_input_helper(struct irq_work *unused)
+{
+	schedule_work(&kgdboc_restore_input_work);
+}
+
+static DEFINE_IRQ_WORK(kgdboc_restore_input_irq_work, kgdboc_queue_restore_input_helper);
+
 static void kgdboc_restore_input(void)
 {
 	if (likely(system_state == SYSTEM_RUNNING))
-		schedule_work(&kgdboc_restore_input_work);
+		irq_work_queue(&kgdboc_restore_input_irq_work);
 }
 
 static int kgdboc_register_kbd(char **cptr)
@@ -133,6 +160,7 @@ static void kgdboc_unregister_kbd(void)
 			i--;
 		}
 	}
+	irq_work_sync(&kgdboc_restore_input_irq_work);
 	flush_work(&kgdboc_restore_input_work);
 }
 #else /* ! CONFIG_KDB_KEYBOARD */
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 261131c9e37c..4446c4066679 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -249,8 +249,6 @@ static void ucsi_displayport_work(struct work_struct *work)
 	struct ucsi_dp *dp = container_of(work, struct ucsi_dp, work);
 	int ret;
 
-	mutex_lock(&dp->con->lock);
-
 	ret = typec_altmode_vdm(dp->alt, dp->header,
 				dp->vdo_data, dp->vdo_size);
 	if (ret)
@@ -259,8 +257,6 @@ static void ucsi_displayport_work(struct work_struct *work)
 	dp->vdo_data = NULL;
 	dp->vdo_size = 0;
 	dp->header = 0;
-
-	mutex_unlock(&dp->con->lock);
 }
 
 void ucsi_displayport_remove_partner(struct typec_altmode *alt)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 51298d749824..209eb85b6c27 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3194,6 +3194,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			 * alignment and size).
 			 */
 			ret = -EUCLEAN;
+			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
 			goto error;
 		}
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6be7e7592291..36fa456f42ba 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2645,6 +2645,8 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	if (subflow->request_mptcp && mptcp_token_new_connect(ssock->sk))
 		mptcp_subflow_early_fallback(msk, subflow);
 
+	WRITE_ONCE(msk->write_seq, subflow->idsn);
+
 do_connect:
 	err = ssock->ops->connect(ssock, uaddr, addr_len, flags);
 	sock->state = ssock->state;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index a2b14434d7aa..ac3678d2d6d5 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1927,7 +1927,7 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	struct sock *sk = sock->sk;
 	struct netlink_sock *nlk = nlk_sk(sk);
 	int noblock = flags & MSG_DONTWAIT;
-	size_t copied;
+	size_t copied, max_recvmsg_len;
 	struct sk_buff *skb, *data_skb;
 	int err, ret;
 
@@ -1960,9 +1960,10 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 #endif
 
 	/* Record the max length of recvmsg() calls for future allocations */
-	nlk->max_recvmsg_len = max(nlk->max_recvmsg_len, len);
-	nlk->max_recvmsg_len = min_t(size_t, nlk->max_recvmsg_len,
-				     SKB_WITH_OVERHEAD(32768));
+	max_recvmsg_len = max(READ_ONCE(nlk->max_recvmsg_len), len);
+	max_recvmsg_len = min_t(size_t, max_recvmsg_len,
+				SKB_WITH_OVERHEAD(32768));
+	WRITE_ONCE(nlk->max_recvmsg_len, max_recvmsg_len);
 
 	copied = data_skb->len;
 	if (len < copied) {
@@ -2211,6 +2212,7 @@ static int netlink_dump(struct sock *sk)
 	struct netlink_ext_ack extack = {};
 	struct netlink_callback *cb;
 	struct sk_buff *skb = NULL;
+	size_t max_recvmsg_len;
 	struct module *module;
 	int err = -ENOBUFS;
 	int alloc_min_size;
@@ -2233,8 +2235,9 @@ static int netlink_dump(struct sock *sk)
 	cb = &nlk->cb;
 	alloc_min_size = max_t(int, cb->min_dump_alloc, NLMSG_GOODSIZE);
 
-	if (alloc_min_size < nlk->max_recvmsg_len) {
-		alloc_size = nlk->max_recvmsg_len;
+	max_recvmsg_len = READ_ONCE(nlk->max_recvmsg_len);
+	if (alloc_min_size < max_recvmsg_len) {
+		alloc_size = max_recvmsg_len;
 		skb = alloc_skb(alloc_size,
 				(GFP_KERNEL & ~__GFP_DIRECT_RECLAIM) |
 				__GFP_NOWARN | __GFP_NORETRY);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 1c403e8a8044..4f5d44037081 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -210,7 +210,7 @@ static struct ima_rule_entry *arch_policy_entry __ro_after_init;
 static LIST_HEAD(ima_default_rules);
 static LIST_HEAD(ima_policy_rules);
 static LIST_HEAD(ima_temp_rules);
-static struct list_head *ima_rules = &ima_default_rules;
+static struct list_head __rcu *ima_rules = (struct list_head __rcu *)(&ima_default_rules);
 
 static int ima_policy __initdata;
 
@@ -648,12 +648,14 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
+	struct list_head *ima_rules_tmp;
 
 	if (template_desc)
 		*template_desc = ima_template_desc_current();
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, ima_rules, list) {
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 
 		if (!(entry->action & actmask))
 			continue;
@@ -701,11 +703,15 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 void ima_update_policy_flag(void)
 {
 	struct ima_rule_entry *entry;
+	struct list_head *ima_rules_tmp;
 
-	list_for_each_entry(entry, ima_rules, list) {
+	rcu_read_lock();
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		if (entry->action & IMA_DO_MASK)
 			ima_policy_flag |= entry->action;
 	}
+	rcu_read_unlock();
 
 	ima_appraise |= (build_ima_appraise | temp_ima_appraise);
 	if (!ima_appraise)
@@ -898,10 +904,10 @@ void ima_update_policy(void)
 
 	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
 
-	if (ima_rules != policy) {
+	if (ima_rules != (struct list_head __rcu *)policy) {
 		ima_policy_flag = 0;
-		ima_rules = policy;
 
+		rcu_assign_pointer(ima_rules, policy);
 		/*
 		 * IMA architecture specific policy rules are specified
 		 * as strings and converted to an array of ima_entry_rules
@@ -989,7 +995,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
 
-		if (ima_rules == &ima_default_rules) {
+		if (ima_rules == (struct list_head __rcu *)(&ima_default_rules)) {
 			kfree(entry->lsm[lsm_rule].args_p);
 			entry->lsm[lsm_rule].args_p = NULL;
 			result = -EINVAL;
@@ -1598,9 +1604,11 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 {
 	loff_t l = *pos;
 	struct ima_rule_entry *entry;
+	struct list_head *ima_rules_tmp;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, ima_rules, list) {
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		if (!l--) {
 			rcu_read_unlock();
 			return entry;
@@ -1619,7 +1627,8 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 	rcu_read_unlock();
 	(*pos)++;
 
-	return (&entry->list == ima_rules) ? NULL : entry;
+	return (&entry->list == &ima_default_rules ||
+		&entry->list == &ima_policy_rules) ? NULL : entry;
 }
 
 void ima_policy_stop(struct seq_file *m, void *v)
@@ -1823,6 +1832,7 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	struct ima_rule_entry *entry;
 	bool found = false;
 	enum ima_hooks func;
+	struct list_head *ima_rules_tmp;
 
 	if (id >= READING_MAX_ID)
 		return false;
@@ -1834,7 +1844,8 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	func = read_idmap[id] ?: FILE_CHECK;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, ima_rules, list) {
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
 		if (entry->action != APPRAISE)
 			continue;
 
diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
index c65c55b7a789..312889edb84a 100644
--- a/tools/testing/selftests/vm/map_hugetlb.c
+++ b/tools/testing/selftests/vm/map_hugetlb.c
@@ -15,7 +15,6 @@
 #include <unistd.h>
 #include <sys/mman.h>
 #include <fcntl.h>
-#include "vm_util.h"
 
 #define LENGTH (256UL*1024*1024)
 #define PROTECTION (PROT_READ | PROT_WRITE)
@@ -71,16 +70,10 @@ int main(int argc, char **argv)
 {
 	void *addr;
 	int ret;
-	size_t hugepage_size;
 	size_t length = LENGTH;
 	int flags = FLAGS;
 	int shift = 0;
 
-	hugepage_size = default_huge_page_size();
-	/* munmap with fail if the length is not page aligned */
-	if (hugepage_size > length)
-		length = hugepage_size;
-
 	if (argc > 1)
 		length = atol(argv[1]) << 20;
 	if (argc > 2) {

