Return-Path: <stable+bounces-151391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC8ACDE76
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633F63A67C3
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD3728F950;
	Wed,  4 Jun 2025 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oRH2aMQA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195BE28F94C;
	Wed,  4 Jun 2025 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749042368; cv=none; b=enAA6MSmCSO/h/GM+bHVixKBGQ1whOapzLNsFQ9muP7PlwrtKl2W9ks7KJ7i5xkX8B8obpKUmafR8bNFdZgNAGiHzjUsuB5djsgW/WrFADbFTAZFyS4+6BwssxmJ+sb/bJnIUIN8SFDBMres7WMqn1naAcxuom8JXtYUYyM+S20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749042368; c=relaxed/simple;
	bh=j62zJn+ao7/rhYXtyDYArzg1KEzC6tS1JKwOQP0zn2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewcmDbf+5QGNLan6fYbyX8iQFovzQ2XQVX/ZXGZyPkAQzNbkr+SA2kpNu28qPn/tnbwujuJ62pCgU18RTluNnhBvUyD3YuLHlitjuZCJN0svqDinpz2uomXnpesoCadJF+iZxdO+2NvAfLCSRQoICm/UtL84hriJJ07n17DxeTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oRH2aMQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DF8C4CEE7;
	Wed,  4 Jun 2025 13:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749042367;
	bh=j62zJn+ao7/rhYXtyDYArzg1KEzC6tS1JKwOQP0zn2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRH2aMQAlD8ymeZOmix1GGTO+O3zQUPS3wW/Qgg4fFL4HbKLDha/2qUapmqcUhAIl
	 wjCHQrslixUr3JDV1qo7dZr+fZXsiIOff4ol3IGCijdm/Pj5skkDOat3lYYdI82304
	 ytc594BxIiuHX39CD26JDbqcgqtOk22xtXbP+eFg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.294
Date: Wed,  4 Jun 2025 15:05:57 +0200
Message-ID: <2025060457-data-magician-5792@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025060457-precinct-hedge-839f@gregkh>
References: <2025060457-precinct-hedge-839f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9975dcab99c3..6d9acc3f977b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4600,6 +4600,8 @@
 
 			Selecting 'on' will also enable the mitigation
 			against user space to user space task attacks.
+			Selecting specific mitigation does not force enable
+			user mitigations.
 
 			Selecting 'off' will disable both the kernel and
 			the user space protections.
diff --git a/Makefile b/Makefile
index 70d2e8cc6f9f..cc8e29781c25 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 293
+SUBLEVEL = 294
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
@@ -770,6 +770,18 @@ KBUILD_CFLAGS += -Wno-tautological-compare
 # source of a reference will be _MergedGlobals and not on of the whitelisted names.
 # See modpost pattern 2
 KBUILD_CFLAGS += -mno-global-merge
+
+# Clang may emit a warning when a const variable, such as the dummy variables
+# in typecheck(), or const member of an aggregate type are not initialized,
+# which can result in unexpected behavior. However, in many audited cases of
+# the "field" variant of the warning, this is intentional because the field is
+# never used within a particular call path, the field is within a union with
+# other non-const members, or the containing object is not const so the field
+# can be modified via memcpy() / memset(). While the variable warning also gets
+# disabled with this same switch, there should not be too much coverage lost
+# because -Wuninitialized will still flag when an uninitialized const variable
+# is used.
+KBUILD_CFLAGS += $(call cc-disable-warning, default-const-init-unsafe)
 else
 
 # Warn about unmarked fall-throughs in switch statement.
diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 0d7a6327e404..fe1ebc3c5aa8 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -123,7 +123,7 @@
 			reg = <0x54400000 0x00040000>;
 			clocks = <&tegra_car TEGRA114_CLK_DSIB>,
 				 <&tegra_car TEGRA114_CLK_DSIBLP>,
-				 <&tegra_car TEGRA114_CLK_PLL_D2_OUT0>;
+				 <&tegra_car TEGRA114_CLK_PLL_D_OUT0>;
 			clock-names = "dsi", "lp", "parent";
 			resets = <&tegra_car 82>;
 			reset-names = "dsi";
diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 652998c83640..aff72ebfc68d 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -839,7 +839,7 @@
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vopb_mmu";
 		clocks = <&cru ACLK_VOPB>, <&cru HCLK_VOPB>;
-		clock-names = "aclk", "hclk";
+		clock-names = "aclk", "iface";
 		power-domains = <&power PX30_PD_VO>;
 		#iommu-cells = <0>;
 		status = "disabled";
@@ -871,7 +871,7 @@
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vopl_mmu";
 		clocks = <&cru ACLK_VOPL>, <&cru HCLK_VOPL>;
-		clock-names = "aclk", "hclk";
+		clock-names = "aclk", "iface";
 		power-domains = <&power PX30_PD_VO>;
 		#iommu-cells = <0>;
 		status = "disabled";
diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index b463f2aa5a61..7acbe701afd6 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -87,4 +87,20 @@ struct dyn_arch_ftrace {
 #endif /*  CONFIG_DYNAMIC_FTRACE */
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
+
+#ifdef CONFIG_FTRACE_SYSCALLS
+#ifndef __ASSEMBLY__
+/*
+ * Some syscall entry functions on mips start with "__sys_" (fork and clone,
+ * for instance). We should also match the sys_ variant with those.
+ */
+#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
+static inline bool arch_syscall_match_sym_name(const char *sym,
+					       const char *name)
+{
+	return !strcmp(sym, name) ||
+		(!strncmp(sym, "__sys_", 6) && !strcmp(sym + 6, name + 4));
+}
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_FTRACE_SYSCALLS */
 #endif /* _ASM_MIPS_FTRACE_H */
diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index ae578860f729..4ec9b306556f 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -65,7 +65,8 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
 
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
-#define MAX_REG_OFFSET (offsetof(struct pt_regs, __last))
+#define MAX_REG_OFFSET \
+	(offsetof(struct pt_regs, __last) - sizeof(unsigned long))
 
 /**
  * regs_get_register() - get register value from its offset
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index a26f40db15d0..cb09536fb986 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -56,10 +56,7 @@ static DEFINE_PER_CPU_ALIGNED(u32*, ready_count);
 /* Indicates online CPUs coupled with the current CPU */
 static DEFINE_PER_CPU_ALIGNED(cpumask_t, online_coupled);
 
-/*
- * Used to synchronize entry to deep idle states. Actually per-core rather
- * than per-CPU.
- */
+/* Used to synchronize entry to deep idle states */
 static DEFINE_PER_CPU_ALIGNED(atomic_t, pm_barrier);
 
 /* Saved CPU state across the CPS_PM_POWER_GATED state */
@@ -118,9 +115,10 @@ int cps_pm_enter_state(enum cps_pm_state state)
 	cps_nc_entry_fn entry;
 	struct core_boot_config *core_cfg;
 	struct vpe_boot_config *vpe_cfg;
+	atomic_t *barrier;
 
 	/* Check that there is an entry function for this state */
-	entry = per_cpu(nc_asm_enter, core)[state];
+	entry = per_cpu(nc_asm_enter, cpu)[state];
 	if (!entry)
 		return -EINVAL;
 
@@ -156,7 +154,7 @@ int cps_pm_enter_state(enum cps_pm_state state)
 	smp_mb__after_atomic();
 
 	/* Create a non-coherent mapping of the core ready_count */
-	core_ready_count = per_cpu(ready_count, core);
+	core_ready_count = per_cpu(ready_count, cpu);
 	nc_addr = kmap_noncoherent(virt_to_page(core_ready_count),
 				   (unsigned long)core_ready_count);
 	nc_addr += ((unsigned long)core_ready_count & ~PAGE_MASK);
@@ -164,7 +162,8 @@ int cps_pm_enter_state(enum cps_pm_state state)
 
 	/* Ensure ready_count is zero-initialised before the assembly runs */
 	WRITE_ONCE(*nc_core_ready_count, 0);
-	coupled_barrier(&per_cpu(pm_barrier, core), online);
+	barrier = &per_cpu(pm_barrier, cpumask_first(&cpu_sibling_map[cpu]));
+	coupled_barrier(barrier, online);
 
 	/* Run the generated entry code */
 	left = entry(online, nc_core_ready_count);
@@ -635,12 +634,14 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 
 static int cps_pm_online_cpu(unsigned int cpu)
 {
-	enum cps_pm_state state;
-	unsigned core = cpu_core(&cpu_data[cpu]);
+	unsigned int sibling, core;
 	void *entry_fn, *core_rc;
+	enum cps_pm_state state;
+
+	core = cpu_core(&cpu_data[cpu]);
 
 	for (state = CPS_PM_NC_WAIT; state < CPS_PM_STATE_COUNT; state++) {
-		if (per_cpu(nc_asm_enter, core)[state])
+		if (per_cpu(nc_asm_enter, cpu)[state])
 			continue;
 		if (!test_bit(state, state_support))
 			continue;
@@ -652,16 +653,19 @@ static int cps_pm_online_cpu(unsigned int cpu)
 			clear_bit(state, state_support);
 		}
 
-		per_cpu(nc_asm_enter, core)[state] = entry_fn;
+		for_each_cpu(sibling, &cpu_sibling_map[cpu])
+			per_cpu(nc_asm_enter, sibling)[state] = entry_fn;
 	}
 
-	if (!per_cpu(ready_count, core)) {
+	if (!per_cpu(ready_count, cpu)) {
 		core_rc = kmalloc(sizeof(u32), GFP_KERNEL);
 		if (!core_rc) {
 			pr_err("Failed allocate core %u ready_count\n", core);
 			return -ENOMEM;
 		}
-		per_cpu(ready_count, core) = core_rc;
+
+		for_each_cpu(sibling, &cpu_sibling_map[cpu])
+			per_cpu(ready_count, sibling) = core_rc;
 	}
 
 	return 0;
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
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index b7ef63614417..e0abb13b5806 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2906,11 +2906,11 @@ static void __init fixup_device_tree_pmac(void)
 	char type[8];
 	phandle node;
 
-	// Some pmacs are missing #size-cells on escc nodes
+	// Some pmacs are missing #size-cells on escc or i2s nodes
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = '\0';
 		prom_getprop(node, "device_type", type, sizeof(type));
-		if (prom_strcmp(type, "escc"))
+		if (prom_strcmp(type, "escc") && prom_strcmp(type, "i2s"))
 			continue;
 
 		if (prom_getproplen(node, "#size-cells") != PROM_ERROR)
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 94cea8d46b22..daec900ed463 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -154,5 +154,6 @@ MRPROPER_DIRS += arch/$(SUBARCH)/include/generated
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
+	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
 
 export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 417ff647fb37..06fb50218136 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -49,6 +49,7 @@ void __init mem_init(void)
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free(__pa(brk_end), uml_reserved - brk_end);
 	uml_reserved = brk_end;
+	min_low_pfn = PFN_UP(__pa(uml_reserved));
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 9d5d949e662e..dfb483c8c98b 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -59,6 +59,8 @@ int __register_nmi_handler(unsigned int, struct nmiaction *);
 
 void unregister_nmi_handler(unsigned int, const char *);
 
+void set_emergency_nmi_handler(unsigned int type, nmi_handler_t handler);
+
 void stop_nmi(void);
 void restart_nmi(void);
 void local_touch_nmi(void);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4f803aed2ef0..0f523ebfbabf 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1050,9 +1050,13 @@ static __ro_after_init enum spectre_v2_mitigation_cmd spectre_v2_cmd;
 static enum spectre_v2_user_cmd __init
 spectre_v2_parse_user_cmdline(void)
 {
+	enum spectre_v2_user_cmd mode;
 	char arg[20];
 	int ret, i;
 
+	mode = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
+		SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;
+
 	switch (spectre_v2_cmd) {
 	case SPECTRE_V2_CMD_NONE:
 		return SPECTRE_V2_USER_CMD_NONE;
@@ -1065,7 +1069,7 @@ spectre_v2_parse_user_cmdline(void)
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
 	if (ret < 0)
-		return SPECTRE_V2_USER_CMD_AUTO;
+		return mode;
 
 	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
 		if (match_option(arg, ret, v2_user_options[i].option)) {
@@ -1075,8 +1079,8 @@ spectre_v2_parse_user_cmdline(void)
 		}
 	}
 
-	pr_err("Unknown user space protection option (%s). Switching to AUTO select\n", arg);
-	return SPECTRE_V2_USER_CMD_AUTO;
+	pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
+	return mode;
 }
 
 static inline bool spectre_v2_in_eibrs_mode(enum spectre_v2_mitigation mode)
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 5bb001c0c771..d5c572bca8b1 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -41,8 +41,12 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/nmi.h>
 
+/*
+ * An emergency handler can be set in any context including NMI
+ */
 struct nmi_desc {
 	raw_spinlock_t lock;
+	nmi_handler_t emerg_handler;
 	struct list_head head;
 };
 
@@ -124,9 +128,22 @@ static void nmi_check_duration(struct nmiaction *action, u64 duration)
 static int nmi_handle(unsigned int type, struct pt_regs *regs)
 {
 	struct nmi_desc *desc = nmi_to_desc(type);
+	nmi_handler_t ehandler;
 	struct nmiaction *a;
 	int handled=0;
 
+	/*
+	 * Call the emergency handler, if set
+	 *
+	 * In the case of crash_nmi_callback() emergency handler, it will
+	 * return in the case of the crashing CPU to enable it to complete
+	 * other necessary crashing actions ASAP. Other handlers in the
+	 * linked list won't need to be run.
+	 */
+	ehandler = desc->emerg_handler;
+	if (ehandler)
+		return ehandler(type, regs);
+
 	rcu_read_lock();
 
 	/*
@@ -212,6 +229,31 @@ void unregister_nmi_handler(unsigned int type, const char *name)
 }
 EXPORT_SYMBOL_GPL(unregister_nmi_handler);
 
+/**
+ * set_emergency_nmi_handler - Set emergency handler
+ * @type:    NMI type
+ * @handler: the emergency handler to be stored
+ *
+ * Set an emergency NMI handler which, if set, will preempt all the other
+ * handlers in the linked list. If a NULL handler is passed in, it will clear
+ * it. It is expected that concurrent calls to this function will not happen
+ * or the system is screwed beyond repair.
+ */
+void set_emergency_nmi_handler(unsigned int type, nmi_handler_t handler)
+{
+	struct nmi_desc *desc = nmi_to_desc(type);
+
+	if (WARN_ON_ONCE(desc->emerg_handler == handler))
+		return;
+	desc->emerg_handler = handler;
+
+	/*
+	 * Ensure the emergency handler is visible to other CPUs before
+	 * function return
+	 */
+	smp_wmb();
+}
+
 static void
 pci_serr_error(unsigned char reason, struct pt_regs *regs)
 {
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 6fede2f00104..17e378db513d 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -875,15 +875,11 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	shootdown_callback = callback;
 
 	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	/* Would it be better to replace the trap vector here? */
-	if (register_nmi_handler(NMI_LOCAL, crash_nmi_callback,
-				 NMI_FLAG_FIRST, "crash"))
-		return;		/* Return what? */
+
 	/*
-	 * Ensure the new callback function is set before sending
-	 * out the NMI
+	 * Set emergency handler to preempt other handlers.
 	 */
-	wmb();
+	set_emergency_nmi_handler(NMI_LOCAL, crash_nmi_callback);
 
 	apic_send_IPI_allbutself(NMI_VECTOR);
 
diff --git a/arch/x86/um/os-Linux/mcontext.c b/arch/x86/um/os-Linux/mcontext.c
index 49c3744cac37..81b9d1f9f4e6 100644
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -26,7 +26,6 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 	COPY(RIP);
 	COPY2(EFLAGS, EFL);
 	COPY2(CS, CSGSFS);
-	regs->gp[CS / sizeof(unsigned long)] &= 0xffff;
-	regs->gp[CS / sizeof(unsigned long)] |= 3;
+	regs->gp[SS / sizeof(unsigned long)] = mc->gregs[REG_CSGSFS] >> 48;
 #endif
 }
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index 8673ac8828e9..a4c4790bbd6e 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -262,10 +262,6 @@ static int hash_accept(struct socket *sock, struct socket *newsock, int flags,
 		return err;
 
 	err = crypto_ahash_import(&ctx2->req, state);
-	if (err) {
-		sock_orphan(sk2);
-		sock_put(sk2);
-	}
 
 	return err;
 }
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ebe1e9e5fd81..3902fe64c484 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -431,7 +431,7 @@ config ACPI_SBS
 	  the modules will be called sbs and sbshc.
 
 config ACPI_HED
-	tristate "Hardware Error Device"
+	bool "Hardware Error Device"
 	help
 	  This driver supports the Hardware Error Device (PNP0C33),
 	  which is used to report some hardware errors notified via
diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index cf148287e2ba..75166839c99e 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -72,7 +72,12 @@ static struct acpi_driver acpi_hed_driver = {
 		.notify = acpi_hed_notify,
 	},
 };
-module_acpi_driver(acpi_hed_driver);
+
+static int __init acpi_hed_driver_init(void)
+{
+	return acpi_bus_register_driver(&acpi_hed_driver);
+}
+subsys_initcall(acpi_hed_driver_init);
 
 ACPI_MODULE_NAME("hed");
 MODULE_AUTHOR("Huang Ying");
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index c1c7727ab932..762849825428 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -218,16 +218,18 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
 			     sizeof(struct acpi_table_pptt));
 	proc_sz = sizeof(struct acpi_pptt_processor);
 
-	while ((unsigned long)entry + proc_sz < table_end) {
+	/* ignore subtable types that are smaller than a processor node */
+	while ((unsigned long)entry + proc_sz <= table_end) {
 		cpu_node = (struct acpi_pptt_processor *)entry;
+
 		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
 		    cpu_node->parent == node_entry)
 			return 0;
 		if (entry->length == 0)
 			return 0;
+
 		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
 				     entry->length);
-
 	}
 	return 1;
 }
@@ -260,15 +262,18 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
 	proc_sz = sizeof(struct acpi_pptt_processor);
 
 	/* find the processor structure associated with this cpuid */
-	while ((unsigned long)entry + proc_sz < table_end) {
+	while ((unsigned long)entry + proc_sz <= table_end) {
 		cpu_node = (struct acpi_pptt_processor *)entry;
 
 		if (entry->length == 0) {
 			pr_warn("Invalid zero length subtable\n");
 			break;
 		}
+		/* entry->length may not equal proc_sz, revalidate the processor structure length */
 		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
 		    acpi_cpu_id == cpu_node->acpi_processor_id &&
+		    (unsigned long)entry + entry->length <= table_end &&
+		    entry->length == proc_sz + cpu_node->number_of_priv_resources * sizeof(u32) &&
 		     acpi_pptt_leaf_node(table_hdr, cpu_node)) {
 			return (struct acpi_pptt_processor *)entry;
 		}
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index 39f7c2d736d1..9a91ce66e16e 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -103,7 +103,9 @@ int __init clocksource_i8253_init(void)
 #ifdef CONFIG_CLKEVT_I8253
 void clockevent_i8253_disable(void)
 {
-	raw_spin_lock(&i8253_lock);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&i8253_lock, flags);
 
 	/*
 	 * Writing the MODE register should stop the counter, according to
@@ -133,7 +135,7 @@ void clockevent_i8253_disable(void)
 
 	outb_p(0x30, PIT_MODE);
 
-	raw_spin_unlock(&i8253_lock);
+	raw_spin_unlock_irqrestore(&i8253_lock, flags);
 }
 
 static int pit_shutdown(struct clock_event_device *evt)
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index e5a5d0c8d66b..bb7288f6adbf 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -259,8 +259,19 @@ static unsigned int get_typical_interval(struct menu_device *data,
 	 * This can deal with workloads that have long pauses interspersed
 	 * with sporadic activity with a bunch of short pauses.
 	 */
-	if ((divisor * 4) <= INTERVALS * 3)
+	if (divisor * 4 <= INTERVALS * 3) {
+		/*
+		 * If there are sufficiently many data points still under
+		 * consideration after the outliers have been eliminated,
+		 * returning without a prediction would be a mistake because it
+		 * is likely that the next interval will not exceed the current
+		 * maximum, so return the latter in that case.
+		 */
+		if (divisor >= INTERVALS / 2)
+			return max;
+
 		return UINT_MAX;
+	}
 
 	thresh = max - 1;
 	goto again;
diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 6dfa1e038726..238936e2dfe2 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -809,9 +809,9 @@ static int dmatest_func(void *data)
 		} else {
 			dma_async_issue_pending(chan);
 
-			wait_event_timeout(thread->done_wait,
-					   done->done,
-					   msecs_to_jiffies(params->timeout));
+			wait_event_freezable_timeout(thread->done_wait,
+					done->done,
+					msecs_to_jiffies(params->timeout));
 
 			status = dma_async_is_tx_complete(chan, cookie, NULL,
 							  NULL);
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index a09a5041e74c..ecc5248f014f 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -96,7 +96,7 @@ static irqreturn_t altr_sdram_mc_err_handler(int irq, void *dev_id)
 	if (status & priv->ecc_stat_ce_mask) {
 		regmap_read(drvdata->mc_vbase, priv->ecc_saddr_offset,
 			    &err_addr);
-		if (priv->ecc_uecnt_offset)
+		if (priv->ecc_cecnt_offset)
 			regmap_read(drvdata->mc_vbase,  priv->ecc_cecnt_offset,
 				    &err_count);
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, err_count,
@@ -1103,9 +1103,6 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 		}
 	}
 
-	/* Interrupt mode set to every SBERR */
-	regmap_write(ecc_mgr_map, ALTR_A10_ECC_INTMODE_OFST,
-		     ALTR_A10_ECC_INTMODE);
 	/* Enable ECC */
 	ecc_set_bits(ecc_ctrl_en_mask, (ecc_block_base +
 					ALTR_A10_ECC_CTRL_OFST));
@@ -2213,6 +2210,10 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
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
diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index d3d9916b1ba3..f865528728d7 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -398,10 +398,9 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 	int i, j, ret;
 	struct mem_ctl_info *mci = NULL;
 	struct edac_mc_layer layers[2];
-	struct dimm_data dimm_info[IE31200_CHANNELS][IE31200_DIMMS_PER_CHANNEL];
 	void __iomem *window;
 	struct ie31200_priv *priv;
-	u32 addr_decode, mad_offset;
+	u32 addr_decode[IE31200_CHANNELS], mad_offset;
 
 	/*
 	 * Kaby Lake, Coffee Lake seem to work like Skylake. Please re-visit
@@ -459,19 +458,10 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 		mad_offset = IE31200_MAD_DIMM_0_OFFSET;
 	}
 
-	/* populate DIMM info */
 	for (i = 0; i < IE31200_CHANNELS; i++) {
-		addr_decode = readl(window + mad_offset +
+		addr_decode[i] = readl(window + mad_offset +
 					(i * 4));
-		edac_dbg(0, "addr_decode: 0x%x\n", addr_decode);
-		for (j = 0; j < IE31200_DIMMS_PER_CHANNEL; j++) {
-			populate_dimm_info(&dimm_info[i][j], addr_decode, j,
-					   skl);
-			edac_dbg(0, "size: 0x%x, rank: %d, width: %d\n",
-				 dimm_info[i][j].size,
-				 dimm_info[i][j].dual_rank,
-				 dimm_info[i][j].x16_width);
-		}
+		edac_dbg(0, "addr_decode: 0x%x\n", addr_decode[i]);
 	}
 
 	/*
@@ -482,14 +472,22 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 	 */
 	for (i = 0; i < IE31200_DIMMS_PER_CHANNEL; i++) {
 		for (j = 0; j < IE31200_CHANNELS; j++) {
+			struct dimm_data dimm_info;
 			struct dimm_info *dimm;
 			unsigned long nr_pages;
 
-			nr_pages = IE31200_PAGES(dimm_info[j][i].size, skl);
+			populate_dimm_info(&dimm_info, addr_decode[j], i,
+					   skl);
+			edac_dbg(0, "size: 0x%x, rank: %d, width: %d\n",
+				 dimm_info.size,
+				 dimm_info.dual_rank,
+				 dimm_info.x16_width);
+
+			nr_pages = IE31200_PAGES(dimm_info.size, skl);
 			if (nr_pages == 0)
 				continue;
 
-			if (dimm_info[j][i].dual_rank) {
+			if (dimm_info.dual_rank) {
 				nr_pages = nr_pages / 2;
 				dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms,
 						     mci->n_layers, (i * 2) + 1,
diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 4e0edb60bfba..d107ad73a188 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -52,7 +52,7 @@
 /* V2 Defines */
 #define VSE_CVP_TX_CREDITS		0x49	/* 8bit */
 
-#define V2_CREDIT_TIMEOUT_US		20000
+#define V2_CREDIT_TIMEOUT_US		40000
 #define V2_CHECK_CREDIT_US		10
 #define V2_POLL_TIMEOUT_US		1000000
 #define V2_USER_TIMEOUT_US		500000
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 662e4d973f13..b07deeb98747 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -277,6 +277,14 @@ struct kfd_process *kfd_create_process(struct file *filep)
 	if (thread->group_leader->mm != thread->mm)
 		return ERR_PTR(-EINVAL);
 
+	/* If the process just called exec(3), it is possible that the
+	 * cleanup of the kfd_process (following the release of the mm
+	 * of the old process image) is still in the cleanup work queue.
+	 * Make sure to drain any job before trying to recreate any
+	 * resource for this process.
+	 */
+	flush_workqueue(kfd_process_wq);
+
 	/*
 	 * take kfd processes mutex before starting of process creation
 	 * so there won't be a case where two threads of the same process
@@ -289,14 +297,6 @@ struct kfd_process *kfd_create_process(struct file *filep)
 	if (process) {
 		pr_debug("Process already found\n");
 	} else {
-		/* If the process just called exec(3), it is possible that the
-		 * cleanup of the kfd_process (following the release of the mm
-		 * of the old process image) is still in the cleanup work queue.
-		 * Make sure to drain any job before trying to recreate any
-		 * resource for this process.
-		 */
-		flush_workqueue(kfd_process_wq);
-
 		process = create_process(thread);
 		if (IS_ERR(process))
 			goto out;
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 70d97a7fc686..678dba387d83 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -561,6 +561,30 @@ mode_valid(struct drm_atomic_state *state)
 	return 0;
 }
 
+static int drm_atomic_check_valid_clones(struct drm_atomic_state *state,
+					 struct drm_crtc *crtc)
+{
+	struct drm_encoder *drm_enc;
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
+									  crtc);
+
+	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask) {
+		if (!drm_enc->possible_clones) {
+			DRM_DEBUG("enc%d possible_clones is 0\n", drm_enc->base.id);
+			continue;
+		}
+
+		if ((crtc_state->encoder_mask & drm_enc->possible_clones) !=
+		    crtc_state->encoder_mask) {
+			DRM_DEBUG("crtc%d failed valid clone check for mask 0x%x\n",
+				  crtc->base.id, crtc_state->encoder_mask);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * drm_atomic_helper_check_modeset - validate state object for modeset changes
  * @dev: DRM device
@@ -724,6 +748,10 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 		ret = drm_atomic_add_affected_planes(state, crtc);
 		if (ret != 0)
 			return ret;
+
+		ret = drm_atomic_check_valid_clones(state, crtc);
+		if (ret != 0)
+			return ret;
 	}
 
 	/*
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 7b27fe16bcbb..ec4f403a7e09 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -4629,6 +4629,7 @@ drm_reset_display_info(struct drm_connector *connector)
 	info->has_hdmi_infoframe = false;
 	info->rgb_quant_range_selectable = false;
 	memset(&info->hdmi, 0, sizeof(info->hdmi));
+	memset(&connector->hdr_sink_metadata, 0, sizeof(connector->hdr_sink_metadata));
 
 	info->non_desktop = 0;
 }
diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
index 867e7629025b..7d347e2944a0 100644
--- a/drivers/gpu/drm/i915/gvt/opregion.c
+++ b/drivers/gpu/drm/i915/gvt/opregion.c
@@ -223,7 +223,8 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
 	u8 *buf;
 	struct opregion_header *header;
 	struct vbt v;
-	const char opregion_signature[16] = OPREGION_SIGNATURE;
+
+	static_assert(sizeof(header->signature) == sizeof(OPREGION_SIGNATURE) - 1);
 
 	gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
 	vgpu_opregion(vgpu)->va = (void *)__get_free_pages(GFP_KERNEL |
@@ -237,8 +238,9 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
 	/* emulated opregion with VBT mailbox only */
 	buf = (u8 *)vgpu_opregion(vgpu)->va;
 	header = (struct opregion_header *)buf;
-	memcpy(header->signature, opregion_signature,
-	       sizeof(opregion_signature));
+
+	memcpy(header->signature, OPREGION_SIGNATURE, sizeof(header->signature));
+
 	header->size = 0x8;
 	header->opregion_ver = 0x02000000;
 	header->mboxes = MBOX_VBT;
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 191e0cec004b..6d105e8aae45 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -337,12 +337,13 @@ static void mtk_dpi_config_swap_input(struct mtk_dpi *dpi, bool enable)
 
 static void mtk_dpi_config_2n_h_fre(struct mtk_dpi *dpi)
 {
-	mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, H_FRE_2N, H_FRE_2N);
+	if (dpi->conf->reg_h_fre_con)
+		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, H_FRE_2N, H_FRE_2N);
 }
 
 static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
 {
-	if (dpi->conf->edge_sel_en)
+	if (dpi->conf->edge_sel_en && dpi->conf->reg_h_fre_con)
 		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
 }
 
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index d5369577b475..356916608cc4 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -40,6 +40,10 @@
 #define USB_VENDOR_ID_ACTIONSTAR	0x2101
 #define USB_DEVICE_ID_ACTIONSTAR_1011	0x1011
 
+#define USB_VENDOR_ID_ADATA_XPG 0x125f
+#define USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE 0x7505
+#define USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE_DONGLE 0x7506
+
 #define USB_VENDOR_ID_ADS_TECH		0x06e1
 #define USB_DEVICE_ID_ADS_TECH_RADIO_SI470X	0xa155
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 9b375ca53946..ff1a9d142cdd 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -27,6 +27,8 @@
 static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR), HID_QUIRK_BADPAD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ADATA_XPG, USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ADATA_XPG, USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE_DONGLE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AFATECH, USB_DEVICE_ID_AFATECH_AF9016), HID_QUIRK_FULLSPEED_INTERVAL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AIREN, USB_DEVICE_ID_AIREN_SLIMPLUS), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AKAI_09E8, USB_DEVICE_ID_AKAI_09E8_MIDIMIX), HID_QUIRK_NO_INIT_REPORTS },
diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
index d5b7a696a68c..50c5b204bf04 100644
--- a/drivers/hid/usbhid/usbkbd.c
+++ b/drivers/hid/usbhid/usbkbd.c
@@ -160,7 +160,7 @@ static int usb_kbd_event(struct input_dev *dev, unsigned int type,
 		return -1;
 
 	spin_lock_irqsave(&kbd->leds_lock, flags);
-	kbd->newleds = (!!test_bit(LED_KANA,    dev->led) << 3) | (!!test_bit(LED_COMPOSE, dev->led) << 3) |
+	kbd->newleds = (!!test_bit(LED_KANA,    dev->led) << 4) | (!!test_bit(LED_COMPOSE, dev->led) << 3) |
 		       (!!test_bit(LED_SCROLLL, dev->led) << 2) | (!!test_bit(LED_CAPSL,   dev->led) << 1) |
 		       (!!test_bit(LED_NUML,    dev->led));
 
diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index d96e435cc42b..e0b3917dfe6f 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -394,7 +394,12 @@ static int gpio_fan_set_cur_state(struct thermal_cooling_device *cdev,
 	if (state >= fan_data->num_speed)
 		return -EINVAL;
 
+	mutex_lock(&fan_data->lock);
+
 	set_fan_speed(fan_data, state);
+
+	mutex_unlock(&fan_data->lock);
+
 	return 0;
 }
 
@@ -490,7 +495,11 @@ MODULE_DEVICE_TABLE(of, of_gpio_fan_match);
 
 static void gpio_fan_stop(void *data)
 {
+	struct gpio_fan_data *fan_data = data;
+
+	mutex_lock(&fan_data->lock);
 	set_fan_speed(data, 0);
+	mutex_unlock(&fan_data->lock);
 }
 
 static int gpio_fan_probe(struct platform_device *pdev)
@@ -564,7 +573,9 @@ static int gpio_fan_suspend(struct device *dev)
 
 	if (fan_data->gpios) {
 		fan_data->resume_speed = fan_data->speed_index;
+		mutex_lock(&fan_data->lock);
 		set_fan_speed(fan_data, 0);
+		mutex_unlock(&fan_data->lock);
 	}
 
 	return 0;
@@ -574,8 +585,11 @@ static int gpio_fan_resume(struct device *dev)
 {
 	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
 
-	if (fan_data->gpios)
+	if (fan_data->gpios) {
+		mutex_lock(&fan_data->lock);
 		set_fan_speed(fan_data, fan_data->resume_speed);
+		mutex_unlock(&fan_data->lock);
+	}
 
 	return 0;
 }
diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 559a73bab51e..15889bcc8587 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -110,7 +110,7 @@ struct xgene_hwmon_dev {
 
 	phys_addr_t		comm_base_addr;
 	void			*pcc_comm_addr;
-	u64			usecs_lat;
+	unsigned int		usecs_lat;
 };
 
 /*
diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index 89faef6f013b..c800a8303328 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -624,9 +624,9 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 	return 0;
 
 rpm_disable:
-	pm_runtime_put(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index d0c557c8d80f..c5a6e7527baf 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1284,7 +1284,10 @@ static int i2c_pxa_probe(struct platform_device *dev)
 				i2c->adap.name);
 	}
 
-	clk_prepare_enable(i2c->clk);
+	ret = clk_prepare_enable(i2c->clk);
+	if (ret)
+		return dev_err_probe(&dev->dev, ret,
+				     "failed to enable clock\n");
 
 	if (i2c->use_pio) {
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 2de45587569a..de01af6e52b4 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -214,9 +214,9 @@ static const struct iio_chan_spec adis16201_channels[] = {
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
 	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
 	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
 	ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index e1ad2cd61b7f..e9f4043966ae 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -127,7 +127,7 @@ static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int addr)
 		{
 			.tx_buf = &st->d16[0],
 			.len = 2,
-			.cs_change = 0,
+			.cs_change = 1,
 		}, {
 			.rx_buf = &st->d16[1],
 			.len = 2,
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index c1adb95f2a46..fd9aea145320 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -168,7 +168,7 @@ struct ad7768_state {
 	union {
 		struct {
 			__be32 chan;
-			s64 timestamp;
+			aligned_s64 timestamp;
 		} scan;
 		__be32 d32;
 		u8 d8[2];
diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index 2e37834633ff..02addbd33ebe 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -483,7 +483,7 @@ static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct {
 		__le16 values[DLN2_ADC_MAX_CHANNELS];
-		int64_t timestamp_space;
+		aligned_s64 timestamp_space;
 	} data;
 	struct dln2_adc_get_all_vals dev_data;
 	struct dln2_adc *dln2 = iio_priv(indio_dev);
diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index c0845d892faa..0e466106becb 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -232,7 +232,7 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
 	int ret;
 	struct {
 		s32 data[4]; /* PM1, PM2P5, PM4, PM10 */
-		s64 ts;
+		aligned_s64 ts;
 	} scan;
 
 	mutex_lock(&state->lock);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index d1f2109012ed..e78e631361cb 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -360,6 +360,9 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_SAMPLE_SIZE;
+
 	fifo_len = (le16_to_cpu(fifo_status) & fifo_diff_mask) *
 		   ST_LSM6DSX_CHAN_SIZE;
 	fifo_len = (fifo_len / pattern_len) * pattern_len;
@@ -538,6 +541,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 	if (!fifo_len)
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
+
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
 		err = st_lsm6dsx_read_block(hw,
 					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index ad3090131126..81f66ba6bf35 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -96,11 +96,8 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 
 	err = do_mmap_info(rxe, uresp ? &uresp->mi : NULL, udata,
 			   cq->queue->buf, cq->queue->buf_size, &cq->queue->ip);
-	if (err) {
-		vfree(cq->queue->buf);
-		kfree(cq->queue);
+	if (err)
 		return err;
-	}
 
 	if (uresp)
 		cq->is_user = 1;
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 9cfd2c1d4e3a..fc23ea8afbe8 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -163,6 +163,7 @@ static const char * const topbuttonpad_pnp_ids[] = {
 
 static const char * const smbus_pnp_ids[] = {
 	/* all of the topbuttonpad_pnp_ids are valid, we just add some extras */
+	"DLL060d", /* Dell Precision M3800 */
 	"LEN0048", /* X1 Carbon 3 */
 	"LEN0046", /* X250 */
 	"LEN0049", /* Yoga 11e */
@@ -185,10 +186,14 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN2044", /* L470  */
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
+	"SYN1221", /* TUXEDO InfinityBook Pro 14 v5 */
+	"SYN3003", /* HP EliteBook 850 G1 */
 	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
 	"SYN323d", /* HP Spectre X360 13-w013dx */
 	"SYN3257", /* HP Envy 13-ad105ng */
+	"TOS01f6", /* Dynabook Portege X30L-G */
+	"TOS0213", /* Dynabook Portege X30-D */
 	NULL
 };
 
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 0abb714fdbf1..de29512c75cc 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -3124,6 +3124,14 @@ static int __init parse_ivrs_acpihid(char *str)
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
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 11efd6c6b111..2468b285c77c 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -262,7 +262,7 @@ static struct msi_domain_info gicv2m_pmsi_domain_info = {
 	.chip	= &gicv2m_pmsi_irq_chip,
 };
 
-static void gicv2m_teardown(void)
+static void __init gicv2m_teardown(void)
 {
 	struct v2m_data *v2m, *tmp;
 
@@ -277,7 +277,7 @@ static void gicv2m_teardown(void)
 	}
 }
 
-static int gicv2m_allocate_domains(struct irq_domain *parent)
+static __init int gicv2m_allocate_domains(struct irq_domain *parent)
 {
 	struct irq_domain *inner_domain, *pci_domain, *plat_domain;
 	struct v2m_data *v2m;
@@ -407,7 +407,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 	return ret;
 }
 
-static struct of_device_id gicv2m_device_id[] = {
+static __initconst struct of_device_id gicv2m_device_id[] = {
 	{	.compatible	= "arm,gic-v2m-frame",	},
 	{},
 };
@@ -472,7 +472,7 @@ static struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
 	return data->fwnode;
 }
 
-static bool acpi_check_amazon_graviton_quirks(void)
+static __init bool acpi_check_amazon_graviton_quirks(void)
 {
 	static struct acpi_table_madt *madt;
 	acpi_status status;
diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 4229b9b5da98..6f54501dc776 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -350,11 +350,12 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 
 	mutex_lock(&con_mutex);
 
-	if (of_parse_phandle_with_args(dev->of_node, "mboxes",
-				       "#mbox-cells", index, &spec)) {
+	ret = of_parse_phandle_with_args(dev->of_node, "mboxes", "#mbox-cells",
+					 index, &spec);
+	if (ret) {
 		dev_dbg(dev, "%s: can't parse \"mboxes\" property\n", __func__);
 		mutex_unlock(&con_mutex);
-		return ERR_PTR(-ENODEV);
+		return ERR_PTR(ret);
 	}
 
 	chan = ERR_PTR(-EPROBE_DEFER);
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index c1d2e3376afc..0aa22a994c86 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2996,6 +2996,27 @@ static dm_cblock_t get_cache_dev_size(struct cache *cache)
 	return to_cblock(size);
 }
 
+static bool can_resume(struct cache *cache)
+{
+	/*
+	 * Disallow retrying the resume operation for devices that failed the
+	 * first resume attempt, as the failure leaves the policy object partially
+	 * initialized. Retrying could trigger BUG_ON when loading cache mappings
+	 * into the incomplete policy object.
+	 */
+	if (cache->sized && !cache->loaded_mappings) {
+		if (get_cache_mode(cache) != CM_WRITE)
+			DMERR("%s: unable to resume a failed-loaded cache, please check metadata.",
+			      cache_device_name(cache));
+		else
+			DMERR("%s: unable to resume cache due to missing proper cache table reload",
+			      cache_device_name(cache));
+		return false;
+	}
+
+	return true;
+}
+
 static bool can_resize(struct cache *cache, dm_cblock_t new_size)
 {
 	if (from_cblock(new_size) > from_cblock(cache->cache_size)) {
@@ -3044,6 +3065,9 @@ static int cache_preresume(struct dm_target *ti)
 	struct cache *cache = ti->private;
 	dm_cblock_t csize = get_cache_dev_size(cache);
 
+	if (!can_resume(cache))
+		return -EINVAL;
+
 	/*
 	 * Check to see if the cache has resized.
 	 */
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 37ab8e05db85..15580ba773e7 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4199,7 +4199,7 @@ static void dm_integrity_dtr(struct dm_target *ti)
 	BUG_ON(!RB_EMPTY_ROOT(&ic->in_progress));
 	BUG_ON(!list_empty(&ic->wait_list));
 
-	if (ic->mode == 'B')
+	if (ic->mode == 'B' && ic->bitmap_flush_work.work.func)
 		cancel_delayed_work_sync(&ic->bitmap_flush_work);
 	if (ic->metadata_wq)
 		destroy_workqueue(ic->metadata_wq);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index fcb9e2775f78..7002846afb30 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -573,8 +573,9 @@ static char **realloc_argv(unsigned *size, char **old_argv)
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
 
@@ -741,6 +742,10 @@ int dm_table_add_target(struct dm_table *t, const char *type,
 		DMERR("%s: zero-length target", dm_device_name(t->md));
 		return -EINVAL;
 	}
+	if (start + len < start || start + len > LLONG_MAX >> SECTOR_SHIFT) {
+		DMERR("%s: too large device", dm_device_name(t->md));
+		return -EINVAL;
+	}
 
 	tgt->type = dm_get_target_type(type);
 	if (!tgt->type) {
diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 69070b706831..8229fbb88a8d 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -813,13 +813,12 @@ static int c8sectpfe_probe(struct platform_device *pdev)
 		}
 		tsin->i2c_adapter =
 			of_find_i2c_adapter_by_node(i2c_bus);
+		of_node_put(i2c_bus);
 		if (!tsin->i2c_adapter) {
 			dev_err(&pdev->dev, "No i2c adapter found\n");
-			of_node_put(i2c_bus);
 			ret = -ENODEV;
 			goto err_clk_disable;
 		}
-		of_node_put(i2c_bus);
 
 		tsin->rst_gpio = of_get_named_gpio(child, "reset-gpios", 0);
 
diff --git a/drivers/media/usb/cx231xx/cx231xx-417.c b/drivers/media/usb/cx231xx/cx231xx-417.c
index 6d218a036966..a9d080823f10 100644
--- a/drivers/media/usb/cx231xx/cx231xx-417.c
+++ b/drivers/media/usb/cx231xx/cx231xx-417.c
@@ -1966,6 +1966,8 @@ static void cx231xx_video_dev_init(
 	vfd->lock = &dev->lock;
 	vfd->release = video_device_release_empty;
 	vfd->ctrl_handler = &dev->mpeg_ctrl_handler.hdl;
+	vfd->device_caps = V4L2_CAP_READWRITE | V4L2_CAP_STREAMING |
+			   V4L2_CAP_VIDEO_CAPTURE;
 	video_set_drvdata(vfd, dev);
 	if (dev->tuner_type == TUNER_ABSENT) {
 		v4l2_disable_ioctl(vfd, VIDIOC_G_FREQUENCY);
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 390caef1bdab..22978057b94a 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -669,8 +669,12 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 
 	sdhci_set_power(host, mode, vdd);
 
-	if (mode == MMC_POWER_OFF)
+	if (mode == MMC_POWER_OFF) {
+		if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD ||
+		    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BYT_SD)
+			usleep_range(15000, 17500);
 		return;
+	}
 
 	/*
 	 * Bus power might not enable after D3 -> D0 transition due to the
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4004e4e7b622..f8d0a0e49abe 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1708,10 +1708,15 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	host->mmc->actual_clock = 0;
 
-	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	if (clk & SDHCI_CLOCK_CARD_EN)
+		sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN,
+			SDHCI_CLOCK_CONTROL);
 
-	if (clock == 0)
+	if (clock == 0) {
+		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 		return;
+	}
 
 	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
 	sdhci_enable_clk(host, clk);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 89797b257573..3b235a269c1b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1954,7 +1954,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	RCU_INIT_POINTER(bond->current_arp_slave, NULL);
 
-	if (!all && (!bond->params.fail_over_mac ||
+	if (!all && (bond->params.fail_over_mac != BOND_FOM_ACTIVE ||
 		     BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)) {
 		if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
 		    bond_has_slaves(bond))
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 9f5852657852..d41c9006a028 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -381,7 +381,7 @@ static void b53_enable_vlan(struct b53_device *dev, bool enable,
 			vc4 |= VC4_ING_VID_VIO_DROP << VC4_ING_VID_CHECK_S;
 			vc5 |= VC5_DROP_VTABLE_MISS;
 		} else {
-			vc4 |= VC4_ING_VID_VIO_FWD << VC4_ING_VID_CHECK_S;
+			vc4 |= VC4_NO_ING_VID_CHK << VC4_ING_VID_CHECK_S;
 			vc5 &= ~VC5_DROP_VTABLE_MISS;
 		}
 
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index eab861352bf2..007eb05ed659 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1390,6 +1390,7 @@ static void sja1105_bridge_stp_state_set(struct dsa_switch *ds, int port,
 	switch (state) {
 	case BR_STATE_DISABLED:
 	case BR_STATE_BLOCKING:
+	case BR_STATE_LISTENING:
 		/* From UM10944 description of DRPDTAG (why put this there?):
 		 * "Management traffic flows to the port regardless of the state
 		 * of the INGRESS flag". So BPDUs are still be allowed to pass.
@@ -1399,11 +1400,6 @@ static void sja1105_bridge_stp_state_set(struct dsa_switch *ds, int port,
 		mac[port].egress    = false;
 		mac[port].dyn_learn = false;
 		break;
-	case BR_STATE_LISTENING:
-		mac[port].ingress   = true;
-		mac[port].egress    = false;
-		mac[port].dyn_learn = false;
-		break;
 	case BR_STATE_LEARNING:
 		mac[port].ingress   = true;
 		mac[port].egress    = false;
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
index decc1c09a031..0f7d33632853 100644
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
index 504fbd43be7d..de10e7e3a68d 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -2372,10 +2372,17 @@ static int xgbe_set_features(struct net_device *netdev,
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
index 729307a96c50..a27979ef7b1c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -834,6 +834,10 @@ struct xgbe_hw_if {
 	void (*enable_vxlan)(struct xgbe_prv_data *);
 	void (*disable_vxlan)(struct xgbe_prv_data *);
 	void (*set_vxlan_id)(struct xgbe_prv_data *);
+
+	/* For Split Header */
+	void (*enable_sph)(struct xgbe_prv_data *pdata);
+	void (*disable_sph)(struct xgbe_prv_data *pdata);
 };
 
 /* This structure represents implementation specific routines for an
diff --git a/drivers/net/ethernet/apm/xgene-v2/main.c b/drivers/net/ethernet/apm/xgene-v2/main.c
index 848be6bf2fd1..514a121d96ae 100644
--- a/drivers/net/ethernet/apm/xgene-v2/main.c
+++ b/drivers/net/ethernet/apm/xgene-v2/main.c
@@ -9,8 +9,6 @@
 
 #include "main.h"
 
-static const struct acpi_device_id xge_acpi_match[];
-
 static int xge_get_resources(struct xge_pdata *pdata)
 {
 	struct platform_device *pdev;
@@ -733,7 +731,7 @@ MODULE_DEVICE_TABLE(acpi, xge_acpi_match);
 static struct platform_driver xge_driver = {
 	.driver = {
 		   .name = "xgene-enet-v2",
-		   .acpi_match_table = ACPI_PTR(xge_acpi_match),
+		   .acpi_match_table = xge_acpi_match,
 	},
 	.probe = xge_probe,
 	.remove = xge_remove,
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 55e720d2ea0c..eb2315764134 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -358,7 +358,7 @@ parse_eeprom (struct net_device *dev)
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
index 5660a83356eb..fd7c504b44f2 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -605,7 +605,12 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
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
diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/ethernet/mellanox/mlx4/alloc.c
index b330020dc0d6..f2bded847e61 100644
--- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
@@ -682,9 +682,9 @@ static struct mlx4_db_pgdir *mlx4_alloc_db_pgdir(struct device *dma_device)
 }
 
 static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
-				    struct mlx4_db *db, int order)
+				    struct mlx4_db *db, unsigned int order)
 {
-	int o;
+	unsigned int o;
 	int i;
 
 	for (o = order; o <= 1; ++o) {
@@ -712,7 +712,7 @@ static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
 	return 0;
 }
 
-int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order)
+int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned int order)
 {
 	struct mlx4_priv *priv = mlx4_priv(dev);
 	struct mlx4_db_pgdir *pgdir;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index a40fecfdb10c..479304afdada 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -53,6 +53,7 @@
 #define MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE \
         max(0x7, MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE)
 #define MLX5E_REP_PARAMS_DEF_NUM_CHANNELS 1
+#define MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE 0x8
 
 static const char mlx5e_rep_driver_name[] = "mlx5e_rep";
 
@@ -1430,6 +1431,8 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
 
 	/* RQ */
 	mlx5e_build_rq_params(mdev, params);
+	if (!mlx5e_is_uplink_rep(priv) && mlx5_core_is_ecpf(mdev))
+		params->log_rq_mtu_frames = MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE;
 
 	/* CQ moderation params */
 	params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
@@ -1470,6 +1473,8 @@ static void mlx5e_build_rep_netdev(struct net_device *netdev)
 	}
 
 	netdev->watchdog_timeo    = 15 * HZ;
+	if (mlx5_core_is_ecpf(mdev))
+		netdev->tx_queue_len = 1 << MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE;
 
 	netdev->features       |= NETIF_F_NETNS_LOCAL;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
index bbff8d8ded76..abb88a61e4d9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
@@ -189,6 +189,9 @@ mlx5e_test_loopback_validate(struct sk_buff *skb,
 	struct udphdr *udph;
 	struct iphdr *iph;
 
+	if (skb_linearize(skb))
+		goto out;
+
 	/* We are only going to peek, no need to clone the SKB */
 	if (MLX5E_TEST_PKT_SIZE - ETH_HLEN > skb_headlen(skb))
 		goto out;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
index 3ce17c3d7a00..5e8db7a6185a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -156,11 +156,16 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
 	u64 value_msb;
 
 	value_lsb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_lsb);
+	/* bit 1-63 are not supported for NICs,
+	 * hence read only bit 0 (asic) from lsb.
+	 */
+	value_lsb &= 0x1;
 	value_msb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_msb);
 
-	mlx5_core_warn(events->dev,
-		       "High temperature on sensors with bit set %llx %llx",
-		       value_msb, value_lsb);
+	if (net_ratelimit())
+		mlx5_core_warn(events->dev,
+			       "High temperature on sensors with bit set %llx %llx",
+			       value_msb, value_lsb);
 
 	return NOTIFY_OK;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index d4ad0e4192bb..44e3f8cfecac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -736,6 +736,7 @@ static void poll_health(struct timer_list *t)
 	health->prev = count;
 	if (health->miss_counter == MAX_MISSES) {
 		mlx5_core_err(dev, "device's health compromised - reached miss count\n");
+		health->synd = ioread8(&h->synd);
 		print_health_info(dev);
 		queue_work(health->wq, &health->report_work);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
index 2389239acadc..945d90844f0c 100644
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
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 6458dbd6c631..a69a34d93ad6 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1221,7 +1221,7 @@ static void lan743x_tx_release_desc(struct lan743x_tx *tx,
 	if (!(buffer_info->flags & TX_BUFFER_INFO_FLAG_ACTIVE))
 		goto done;
 
-	descriptor_type = (descriptor->data0) &
+	descriptor_type = le32_to_cpu(descriptor->data0) &
 			  TX_DESC_DATA0_DTYPE_MASK_;
 	if (descriptor_type == TX_DESC_DATA0_DTYPE_DATA_)
 		goto clean_up_data_descriptor;
@@ -1281,7 +1281,7 @@ static int lan743x_tx_next_index(struct lan743x_tx *tx, int index)
 
 static void lan743x_tx_release_completed_descriptors(struct lan743x_tx *tx)
 {
-	while ((*tx->head_cpu_ptr) != (tx->last_head)) {
+	while (le32_to_cpu(*tx->head_cpu_ptr) != (tx->last_head)) {
 		lan743x_tx_release_desc(tx, tx->last_head, false);
 		tx->last_head = lan743x_tx_next_index(tx, tx->last_head);
 	}
@@ -1367,10 +1367,10 @@ static int lan743x_tx_frame_start(struct lan743x_tx *tx,
 	if (dma_mapping_error(dev, dma_ptr))
 		return -ENOMEM;
 
-	tx_descriptor->data1 = DMA_ADDR_LOW32(dma_ptr);
-	tx_descriptor->data2 = DMA_ADDR_HIGH32(dma_ptr);
-	tx_descriptor->data3 = (frame_length << 16) &
-		TX_DESC_DATA3_FRAME_LENGTH_MSS_MASK_;
+	tx_descriptor->data1 = cpu_to_le32(DMA_ADDR_LOW32(dma_ptr));
+	tx_descriptor->data2 = cpu_to_le32(DMA_ADDR_HIGH32(dma_ptr));
+	tx_descriptor->data3 = cpu_to_le32((frame_length << 16) &
+		TX_DESC_DATA3_FRAME_LENGTH_MSS_MASK_);
 
 	buffer_info->skb = NULL;
 	buffer_info->dma_ptr = dma_ptr;
@@ -1409,9 +1409,10 @@ static void lan743x_tx_frame_add_lso(struct lan743x_tx *tx,
 	if (nr_frags <= 0) {
 		tx->frame_data0 |= TX_DESC_DATA0_LS_;
 		tx->frame_data0 |= TX_DESC_DATA0_IOC_;
+		tx->frame_last = tx->frame_first;
 	}
 	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
-	tx_descriptor->data0 = tx->frame_data0;
+	tx_descriptor->data0 = cpu_to_le32(tx->frame_data0);
 
 	/* move to next descriptor */
 	tx->frame_tail = lan743x_tx_next_index(tx, tx->frame_tail);
@@ -1455,7 +1456,7 @@ static int lan743x_tx_frame_add_fragment(struct lan743x_tx *tx,
 
 	/* wrap up previous descriptor */
 	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
-	tx_descriptor->data0 = tx->frame_data0;
+	tx_descriptor->data0 = cpu_to_le32(tx->frame_data0);
 
 	/* move to next descriptor */
 	tx->frame_tail = lan743x_tx_next_index(tx, tx->frame_tail);
@@ -1478,13 +1479,14 @@ static int lan743x_tx_frame_add_fragment(struct lan743x_tx *tx,
 		tx->frame_first = 0;
 		tx->frame_data0 = 0;
 		tx->frame_tail = 0;
+		tx->frame_last = 0;
 		return -ENOMEM;
 	}
 
-	tx_descriptor->data1 = DMA_ADDR_LOW32(dma_ptr);
-	tx_descriptor->data2 = DMA_ADDR_HIGH32(dma_ptr);
-	tx_descriptor->data3 = (frame_length << 16) &
-			       TX_DESC_DATA3_FRAME_LENGTH_MSS_MASK_;
+	tx_descriptor->data1 = cpu_to_le32(DMA_ADDR_LOW32(dma_ptr));
+	tx_descriptor->data2 = cpu_to_le32(DMA_ADDR_HIGH32(dma_ptr));
+	tx_descriptor->data3 = cpu_to_le32((frame_length << 16) &
+			       TX_DESC_DATA3_FRAME_LENGTH_MSS_MASK_);
 
 	buffer_info->skb = NULL;
 	buffer_info->dma_ptr = dma_ptr;
@@ -1518,17 +1520,19 @@ static void lan743x_tx_frame_end(struct lan743x_tx *tx,
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
 
-	tx_descriptor->data0 = tx->frame_data0;
+	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
+	tx_descriptor->data0 = cpu_to_le32(tx->frame_data0);
 	tx->frame_tail = lan743x_tx_next_index(tx, tx->frame_tail);
 	tx->last_tail = tx->frame_tail;
 
@@ -1946,11 +1950,11 @@ static int lan743x_rx_init_ring_element(struct lan743x_rx *rx, int index,
 	}
 
 	buffer_info->buffer_length = length;
-	descriptor->data1 = DMA_ADDR_LOW32(buffer_info->dma_ptr);
-	descriptor->data2 = DMA_ADDR_HIGH32(buffer_info->dma_ptr);
+	descriptor->data1 = cpu_to_le32(DMA_ADDR_LOW32(buffer_info->dma_ptr));
+	descriptor->data2 = cpu_to_le32(DMA_ADDR_HIGH32(buffer_info->dma_ptr));
 	descriptor->data3 = 0;
-	descriptor->data0 = (RX_DESC_DATA0_OWN_ |
-			    (length & RX_DESC_DATA0_BUF_LENGTH_MASK_));
+	descriptor->data0 = cpu_to_le32((RX_DESC_DATA0_OWN_ |
+			    (length & RX_DESC_DATA0_BUF_LENGTH_MASK_)));
 	skb_reserve(buffer_info->skb, RX_HEAD_PADDING);
 	lan743x_rx_update_tail(rx, index);
 
@@ -1965,12 +1969,12 @@ static void lan743x_rx_reuse_ring_element(struct lan743x_rx *rx, int index)
 	descriptor = &rx->ring_cpu_ptr[index];
 	buffer_info = &rx->buffer_info[index];
 
-	descriptor->data1 = DMA_ADDR_LOW32(buffer_info->dma_ptr);
-	descriptor->data2 = DMA_ADDR_HIGH32(buffer_info->dma_ptr);
+	descriptor->data1 = cpu_to_le32(DMA_ADDR_LOW32(buffer_info->dma_ptr));
+	descriptor->data2 = cpu_to_le32(DMA_ADDR_HIGH32(buffer_info->dma_ptr));
 	descriptor->data3 = 0;
-	descriptor->data0 = (RX_DESC_DATA0_OWN_ |
+	descriptor->data0 = cpu_to_le32((RX_DESC_DATA0_OWN_ |
 			    ((buffer_info->buffer_length) &
-			    RX_DESC_DATA0_BUF_LENGTH_MASK_));
+			    RX_DESC_DATA0_BUF_LENGTH_MASK_)));
 	lan743x_rx_update_tail(rx, index);
 }
 
@@ -2004,14 +2008,13 @@ static int lan743x_rx_process_packet(struct lan743x_rx *rx)
 {
 	struct skb_shared_hwtstamps *hwtstamps = NULL;
 	int result = RX_PROCESS_RESULT_NOTHING_TO_DO;
+	int current_head_index = le32_to_cpu(*rx->head_cpu_ptr);
 	struct lan743x_rx_buffer_info *buffer_info;
 	struct lan743x_rx_descriptor *descriptor;
-	int current_head_index = -1;
 	int extension_index = -1;
 	int first_index = -1;
 	int last_index = -1;
 
-	current_head_index = *rx->head_cpu_ptr;
 	if (current_head_index < 0 || current_head_index >= rx->ring_size)
 		goto done;
 
@@ -2020,14 +2023,14 @@ static int lan743x_rx_process_packet(struct lan743x_rx *rx)
 
 	if (rx->last_head != current_head_index) {
 		descriptor = &rx->ring_cpu_ptr[rx->last_head];
-		if (descriptor->data0 & RX_DESC_DATA0_OWN_)
+		if (le32_to_cpu(descriptor->data0) & RX_DESC_DATA0_OWN_)
 			goto done;
 
-		if (!(descriptor->data0 & RX_DESC_DATA0_FS_))
+		if (!(le32_to_cpu(descriptor->data0) & RX_DESC_DATA0_FS_))
 			goto done;
 
 		first_index = rx->last_head;
-		if (descriptor->data0 & RX_DESC_DATA0_LS_) {
+		if (le32_to_cpu(descriptor->data0) & RX_DESC_DATA0_LS_) {
 			last_index = rx->last_head;
 		} else {
 			int index;
@@ -2035,10 +2038,10 @@ static int lan743x_rx_process_packet(struct lan743x_rx *rx)
 			index = lan743x_rx_next_index(rx, first_index);
 			while (index != current_head_index) {
 				descriptor = &rx->ring_cpu_ptr[index];
-				if (descriptor->data0 & RX_DESC_DATA0_OWN_)
+				if (le32_to_cpu(descriptor->data0) & RX_DESC_DATA0_OWN_)
 					goto done;
 
-				if (descriptor->data0 & RX_DESC_DATA0_LS_) {
+				if (le32_to_cpu(descriptor->data0) & RX_DESC_DATA0_LS_) {
 					last_index = index;
 					break;
 				}
@@ -2047,17 +2050,17 @@ static int lan743x_rx_process_packet(struct lan743x_rx *rx)
 		}
 		if (last_index >= 0) {
 			descriptor = &rx->ring_cpu_ptr[last_index];
-			if (descriptor->data0 & RX_DESC_DATA0_EXT_) {
+			if (le32_to_cpu(descriptor->data0) & RX_DESC_DATA0_EXT_) {
 				/* extension is expected to follow */
 				int index = lan743x_rx_next_index(rx,
 								  last_index);
 				if (index != current_head_index) {
 					descriptor = &rx->ring_cpu_ptr[index];
-					if (descriptor->data0 &
+					if (le32_to_cpu(descriptor->data0) &
 					    RX_DESC_DATA0_OWN_) {
 						goto done;
 					}
-					if (descriptor->data0 &
+					if (le32_to_cpu(descriptor->data0) &
 					    RX_DESC_DATA0_EXT_) {
 						extension_index = index;
 					} else {
@@ -2110,7 +2113,7 @@ static int lan743x_rx_process_packet(struct lan743x_rx *rx)
 			}
 			buffer_info->skb = NULL;
 			packet_length =	RX_DESC_DATA0_FRAME_LENGTH_GET_
-					(descriptor->data0);
+					(le32_to_cpu(descriptor->data0));
 			skb_put(skb, packet_length - 4);
 			skb->protocol = eth_type_trans(skb,
 						       rx->adapter->netdev);
@@ -2148,8 +2151,8 @@ static int lan743x_rx_process_packet(struct lan743x_rx *rx)
 			descriptor = &rx->ring_cpu_ptr[extension_index];
 			buffer_info = &rx->buffer_info[extension_index];
 
-			ts_sec = descriptor->data1;
-			ts_nsec = (descriptor->data2 &
+			ts_sec = le32_to_cpu(descriptor->data1);
+			ts_nsec = (le32_to_cpu(descriptor->data2) &
 				  RX_DESC_DATA2_TS_NS_MASK_);
 			lan743x_rx_reuse_ring_element(rx, extension_index);
 			real_last_index = extension_index;
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 1fbcef391098..44b107caba84 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -652,10 +652,11 @@ struct lan743x_tx {
 	u32		frame_first;
 	u32		frame_data0;
 	u32		frame_tail;
+	u32		frame_last;
 
 	struct lan743x_tx_buffer_info *buffer_info;
 
-	u32		*head_cpu_ptr;
+	__le32		*head_cpu_ptr;
 	dma_addr_t	head_dma_ptr;
 	int		last_head;
 	int		last_tail;
@@ -685,7 +686,7 @@ struct lan743x_rx {
 
 	struct lan743x_rx_buffer_info *buffer_info;
 
-	u32		*head_cpu_ptr;
+	__le32		*head_cpu_ptr;
 	dma_addr_t	head_dma_ptr;
 	u32		last_head;
 	u32		last_tail;
@@ -769,10 +770,10 @@ struct lan743x_adapter {
 #define TX_DESC_DATA3_FRAME_LENGTH_MSS_MASK_	(0x3FFF0000)
 
 struct lan743x_tx_descriptor {
-	u32     data0;
-	u32     data1;
-	u32     data2;
-	u32     data3;
+	__le32     data0;
+	__le32     data1;
+	__le32     data2;
+	__le32     data3;
 } __aligned(DEFAULT_DMA_DESCRIPTOR_SPACING);
 
 #define TX_BUFFER_INFO_FLAG_ACTIVE		BIT(0)
@@ -807,10 +808,10 @@ struct lan743x_tx_buffer_info {
 #define RX_HEAD_PADDING		NET_IP_ALIGN
 
 struct lan743x_rx_descriptor {
-	u32     data0;
-	u32     data1;
-	u32     data2;
-	u32     data3;
+	__le32     data0;
+	__le32     data1;
+	__le32     data2;
+	__le32     data3;
 } __aligned(DEFAULT_DMA_DESCRIPTOR_SPACING);
 
 #define RX_BUFFER_INFO_FLAG_ACTIVE      BIT(0)
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index 5d8b9e10ddf8..d6fcef1651a7 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -1486,8 +1486,11 @@ static int qlcnic_sriov_channel_cfg_cmd(struct qlcnic_adapter *adapter, u8 cmd_o
 	}
 
 	cmd_op = (cmd.rsp.arg[0] & 0xff);
-	if (cmd.rsp.arg[0] >> 25 == 2)
-		return 2;
+	if (cmd.rsp.arg[0] >> 25 == 2) {
+		ret = 2;
+		goto out;
+	}
+
 	if (cmd_op == QLCNIC_BC_CMD_CHANNEL_INIT)
 		set_bit(QLC_BC_VF_STATE, &vf->state);
 	else
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 497ce6e6b16f..99387e39c04e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -919,7 +919,7 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 		/* of_mdio_parse_addr returns a valid (0 ~ 31) PHY
 		 * address. No need to mask it again.
 		 */
-		reg |= 1 << H3_EPHY_ADDR_SHIFT;
+		reg |= ret << H3_EPHY_ADDR_SHIFT;
 	} else {
 		/* For SoCs without internal PHY the PHY selection bit should be
 		 * set to 0 (external PHY).
diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index d394e2b65054..d99976034027 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1487,8 +1487,7 @@ static u8 mcps_data_request(
 	command.pdata.data_req.src_addr_mode = src_addr_mode;
 	command.pdata.data_req.dst.mode = dst_address_mode;
 	if (dst_address_mode != MAC_MODE_NO_ADDR) {
-		command.pdata.data_req.dst.pan_id[0] = LS_BYTE(dst_pan_id);
-		command.pdata.data_req.dst.pan_id[1] = MS_BYTE(dst_pan_id);
+		put_unaligned_le16(dst_pan_id, command.pdata.data_req.dst.pan_id);
 		if (dst_address_mode == MAC_MODE_SHORT_ADDR) {
 			command.pdata.data_req.dst.address[0] = LS_BYTE(
 				dst_addr->short_address
@@ -1837,12 +1836,12 @@ static int ca8210_skb_rx(
 	}
 	hdr.source.mode = data_ind[0];
 	dev_dbg(&priv->spi->dev, "srcAddrMode: %#03x\n", hdr.source.mode);
-	hdr.source.pan_id = *(u16 *)&data_ind[1];
+	hdr.source.pan_id = cpu_to_le16(get_unaligned_le16(&data_ind[1]));
 	dev_dbg(&priv->spi->dev, "srcPanId: %#06x\n", hdr.source.pan_id);
 	memcpy(&hdr.source.extended_addr, &data_ind[3], 8);
 	hdr.dest.mode = data_ind[11];
 	dev_dbg(&priv->spi->dev, "dstAddrMode: %#03x\n", hdr.dest.mode);
-	hdr.dest.pan_id = *(u16 *)&data_ind[12];
+	hdr.dest.pan_id = cpu_to_le16(get_unaligned_le16(&data_ind[12]));
 	dev_dbg(&priv->spi->dev, "dstPanId: %#06x\n", hdr.dest.pan_id);
 	memcpy(&hdr.dest.extended_addr, &data_ind[14], 8);
 
@@ -1969,7 +1968,7 @@ static int ca8210_skb_tx(
 	status =  mcps_data_request(
 		header.source.mode,
 		header.dest.mode,
-		header.dest.pan_id,
+		le16_to_cpu(header.dest.pan_id),
 		(union macaddr *)&header.dest.extended_addr,
 		skb->len - mac_len,
 		&skb->data[mac_len],
diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index ce11fb2b0556..7105ac37f341 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -302,9 +302,9 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 	    nla_put_u32(skb, NDA_IFINDEX, rdst->remote_ifindex))
 		goto nla_put_failure;
 
-	ci.ndm_used	 = jiffies_to_clock_t(now - fdb->used);
+	ci.ndm_used	 = jiffies_to_clock_t(now - READ_ONCE(fdb->used));
 	ci.ndm_confirmed = 0;
-	ci.ndm_updated	 = jiffies_to_clock_t(now - fdb->updated);
+	ci.ndm_updated	 = jiffies_to_clock_t(now - READ_ONCE(fdb->updated));
 	ci.ndm_refcnt	 = 0;
 
 	if (nla_put(skb, NDA_CACHEINFO, sizeof(ci), &ci))
@@ -510,8 +510,8 @@ static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
 	struct vxlan_fdb *f;
 
 	f = __vxlan_find_mac(vxlan, mac, vni);
-	if (f && f->used != jiffies)
-		f->used = jiffies;
+	if (f && READ_ONCE(f->used) != jiffies)
+		WRITE_ONCE(f->used, jiffies);
 
 	return f;
 }
@@ -942,12 +942,12 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	    !(f->flags & NTF_VXLAN_ADDED_BY_USER)) {
 		if (f->state != state) {
 			f->state = state;
-			f->updated = jiffies;
+			WRITE_ONCE(f->updated, jiffies);
 			notify = 1;
 		}
 		if (f->flags != fdb_flags) {
 			f->flags = fdb_flags;
-			f->updated = jiffies;
+			WRITE_ONCE(f->updated, jiffies);
 			notify = 1;
 		}
 	}
@@ -974,7 +974,7 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	}
 
 	if (ndm_flags & NTF_USE)
-		f->used = jiffies;
+		WRITE_ONCE(f->used, jiffies);
 
 	if (notify) {
 		if (rd == NULL)
@@ -1351,7 +1351,7 @@ static bool vxlan_snoop(struct net_device *dev,
 				    src_mac, &rdst->remote_ip.sa, &src_ip->sa);
 
 		rdst->remote_ip = *src_ip;
-		f->updated = jiffies;
+		WRITE_ONCE(f->updated, jiffies);
 		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);
 	} else {
 		u32 hash_index = fdb_head_index(vxlan, src_mac, vni);
@@ -2748,7 +2748,7 @@ static void vxlan_cleanup(struct timer_list *t)
 			if (f->flags & NTF_EXT_LEARNED)
 				continue;
 
-			timeout = f->used + vxlan->cfg.age_interval * HZ;
+			timeout = READ_ONCE(f->used) + vxlan->cfg.age_interval * HZ;
 			if (time_before_eq(timeout, jiffies)) {
 				netdev_dbg(vxlan->dev,
 					   "garbage collect %pM\n",
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 3b897f040371..943aae63ec35 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -866,14 +866,16 @@ brcmf_usb_dl_writeimage(struct brcmf_usbdev_info *devinfo, u8 *fw, int fwlen)
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
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 15c7a6fc37b9..e4d487468c4d 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -766,6 +766,7 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 			    struct ieee80211_sta_ht_cap *ht_cap)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
+	int i;
 
 	ht_cap->ht_supported = true;
 	ht_cap->cap = 0;
@@ -780,17 +781,11 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 	ht_cap->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
 	ht_cap->ampdu_density = IEEE80211_HT_MPDU_DENSITY_16;
 	ht_cap->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
-	if (efuse->hw_cap.nss > 1) {
-		ht_cap->mcs.rx_mask[0] = 0xFF;
-		ht_cap->mcs.rx_mask[1] = 0xFF;
-		ht_cap->mcs.rx_mask[4] = 0x01;
-		ht_cap->mcs.rx_highest = cpu_to_le16(300);
-	} else {
-		ht_cap->mcs.rx_mask[0] = 0xFF;
-		ht_cap->mcs.rx_mask[1] = 0x00;
-		ht_cap->mcs.rx_mask[4] = 0x01;
-		ht_cap->mcs.rx_highest = cpu_to_le16(150);
-	}
+
+	for (i = 0; i < efuse->hw_cap.nss; i++)
+		ht_cap->mcs.rx_mask[i] = 0xFF;
+	ht_cap->mcs.rx_mask[4] = 0x01;
+	ht_cap->mcs.rx_highest = cpu_to_le16(150 * efuse->hw_cap.nss);
 }
 
 static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 63abda3b0ebf..004a85448ce9 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -864,11 +864,11 @@ static void rtw8822b_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
 }
 
 static void
-rtw8822b_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
+rtw8822b_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path,
+				    u8 rs, u32 *phy_pwr_idx)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	static const u32 offset_txagc[2] = {0x1d00, 0x1d80};
-	static u32 phy_pwr_idx;
 	u8 rate, rate_idx, pwr_index, shift;
 	int j;
 
@@ -876,12 +876,12 @@ rtw8822b_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
 		rate = rtw_rate_section[rs][j];
 		pwr_index = hal->tx_pwr_tbl[path][rate];
 		shift = rate & 0x3;
-		phy_pwr_idx |= ((u32)pwr_index << (shift * 8));
+		*phy_pwr_idx |= ((u32)pwr_index << (shift * 8));
 		if (shift == 0x3) {
 			rate_idx = rate & 0xfc;
 			rtw_write32(rtwdev, offset_txagc[path] + rate_idx,
-				    phy_pwr_idx);
-			phy_pwr_idx = 0;
+				    *phy_pwr_idx);
+			*phy_pwr_idx = 0;
 		}
 	}
 }
@@ -889,11 +889,13 @@ rtw8822b_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
 static void rtw8822b_set_tx_power_index(struct rtw_dev *rtwdev)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
+	u32 phy_pwr_idx = 0;
 	int rs, path;
 
 	for (path = 0; path < hal->rf_path_num; path++) {
 		for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++)
-			rtw8822b_set_tx_power_index_by_rate(rtwdev, path, rs);
+			rtw8822b_set_tx_power_index_by_rate(rtwdev, path, rs,
+							    &phy_pwr_idx);
 	}
 }
 
diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 9251441fd8a3..5251058adc4d 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -421,7 +421,8 @@ int nd_label_data_init(struct nvdimm_drvdata *ndd)
 	if (ndd->data)
 		return 0;
 
-	if (ndd->nsarea.status || ndd->nsarea.max_xfer == 0) {
+	if (ndd->nsarea.status || ndd->nsarea.max_xfer == 0 ||
+	    ndd->nsarea.config_size == 0) {
 		dev_dbg(ndd->dev, "failed to init config data area: (%u:%u)\n",
 			ndd->nsarea.max_xfer, ndd->nsarea.config_size);
 		return -ENXIO;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9816debe5cb5..94c8ef4a54d3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3980,7 +3980,8 @@ static void nvme_fw_act_work(struct work_struct *work)
 		msleep(100);
 	}
 
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
+	    !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
 		return;
 
 	nvme_start_queues(ctrl);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 61296032ce6d..364f83c92b18 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1423,7 +1423,7 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	cancel_work_sync(&queue->io_work);
 }
 
-static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
+static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
@@ -1433,6 +1433,31 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	__nvme_tcp_stop_queue(queue);
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
@@ -1539,7 +1564,9 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->queue_count; i++)
-		nvme_tcp_stop_queue(ctrl, i);
+		nvme_tcp_stop_queue_nowait(ctrl, i);
+	for (i = 1; i < ctrl->queue_count; i++)
+		nvme_tcp_wait_queue(ctrl, i);
 }
 
 static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 11c8506e04ca..bac81baa49c1 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1338,6 +1338,9 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
 
+	if (!queue->state_change)
+		return;
+
 	write_lock_bh(&sock->sk->sk_callback_lock);
 	sock->sk->sk_data_ready =  queue->data_ready;
 	sock->sk->sk_state_change = queue->state_change;
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 7fb870097a84..ee3467730dac 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -213,14 +213,15 @@ static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len
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
index 30c259f63239..86cdd27cdd3b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1112,11 +1112,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "pcie_aux clock source missing or invalid\n");
 			return PTR_ERR(imx6_pcie->pcie_aux);
 		}
-		/* fall through */
-	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
-
+		/* fall through */
+	case IMX7D:
 		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
 									    "pciephy");
 		if (IS_ERR(imx6_pcie->pciephy_reset)) {
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 32e34ade736c..1793e1084aeb 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -800,11 +800,9 @@ static resource_size_t calculate_iosize(resource_size_t size,
 	size = (size & 0xff) + ((size & ~0xffUL) << 2);
 #endif
 	size = size + size1;
-	if (size < old_size)
-		size = old_size;
 
-	size = ALIGN(max(size, add_size) + children_add_size, align);
-	return size;
+	size = max(size, add_size) + children_add_size;
+	return ALIGN(max(size, old_size), align);
 }
 
 static resource_size_t calculate_memsize(resource_size_t size,
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index c94a0d2c4516..917e01af4769 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -360,13 +360,14 @@ EXPORT_SYMBOL_GPL(phy_power_off);
 
 int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode)
 {
-	int ret;
+	int ret = 0;
 
-	if (!phy || !phy->ops->set_mode)
+	if (!phy)
 		return 0;
 
 	mutex_lock(&phy->mutex);
-	ret = phy->ops->set_mode(phy, mode, submode);
+	if (phy->ops->set_mode)
+		ret = phy->ops->set_mode(phy, mode, submode);
 	if (!ret)
 		phy->attrs.mode = mode;
 	mutex_unlock(&phy->mutex);
diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index ddc41db1f65a..d28a313a3b13 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -427,8 +427,11 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	val = readl(usb2_base + USB2_INT_ENABLE);
 	val |= USB2_INT_ENABLE_UCOM_INTEN | rphy->int_enable_bits;
 	writel(val, usb2_base + USB2_INT_ENABLE);
-	writel(USB2_SPD_RSM_TIMSET_INIT, usb2_base + USB2_SPD_RSM_TIMSET);
-	writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
+
+	if (!rcar_gen3_is_any_rphy_initialized(channel)) {
+		writel(USB2_SPD_RSM_TIMSET_INIT, usb2_base + USB2_SPD_RSM_TIMSET);
+		writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
+	}
 
 	/* Initialize otg part */
 	if (channel->is_otg_channel) {
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index efe7abf459fd..6caceab9b382 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -526,16 +526,16 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
 
 	err = dev_set_name(&port->dev, "%s-%u", name, index);
 	if (err < 0)
-		goto unregister;
+		goto put_device;
 
 	err = device_add(&port->dev);
 	if (err < 0)
-		goto unregister;
+		goto put_device;
 
 	return 0;
 
-unregister:
-	device_unregister(&port->dev);
+put_device:
+	put_device(&port->dev);
 	return err;
 }
 
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
index 3452005342ad..69e8d7856fff 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
@@ -79,7 +79,7 @@ static enum bcm281xx_pin_type hdmi_pin = BCM281XX_PIN_TYPE_HDMI;
 struct bcm281xx_pin_function {
 	const char *name;
 	const char * const *groups;
-	const unsigned ngroups;
+	const unsigned int ngroups;
 };
 
 /**
@@ -91,10 +91,10 @@ struct bcm281xx_pinctrl_data {
 
 	/* List of all pins */
 	const struct pinctrl_pin_desc *pins;
-	const unsigned npins;
+	const unsigned int npins;
 
 	const struct bcm281xx_pin_function *functions;
-	const unsigned nfunctions;
+	const unsigned int nfunctions;
 
 	struct regmap *regmap;
 };
@@ -948,7 +948,7 @@ static struct bcm281xx_pinctrl_data bcm281xx_pinctrl = {
 };
 
 static inline enum bcm281xx_pin_type pin_type_get(struct pinctrl_dev *pctldev,
-						  unsigned pin)
+						  unsigned int pin)
 {
 	struct bcm281xx_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
 
@@ -992,7 +992,7 @@ static int bcm281xx_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
 }
 
 static const char *bcm281xx_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
-						   unsigned group)
+						   unsigned int group)
 {
 	struct bcm281xx_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
 
@@ -1000,9 +1000,9 @@ static const char *bcm281xx_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
 }
 
 static int bcm281xx_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
-					   unsigned group,
+					   unsigned int group,
 					   const unsigned **pins,
-					   unsigned *num_pins)
+					   unsigned int *num_pins)
 {
 	struct bcm281xx_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
 
@@ -1014,7 +1014,7 @@ static int bcm281xx_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
 
 static void bcm281xx_pinctrl_pin_dbg_show(struct pinctrl_dev *pctldev,
 					  struct seq_file *s,
-					  unsigned offset)
+					  unsigned int offset)
 {
 	seq_printf(s, " %s", dev_name(pctldev->dev));
 }
@@ -1036,7 +1036,7 @@ static int bcm281xx_pinctrl_get_fcns_count(struct pinctrl_dev *pctldev)
 }
 
 static const char *bcm281xx_pinctrl_get_fcn_name(struct pinctrl_dev *pctldev,
-						 unsigned function)
+						 unsigned int function)
 {
 	struct bcm281xx_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
 
@@ -1044,9 +1044,9 @@ static const char *bcm281xx_pinctrl_get_fcn_name(struct pinctrl_dev *pctldev,
 }
 
 static int bcm281xx_pinctrl_get_fcn_groups(struct pinctrl_dev *pctldev,
-					   unsigned function,
+					   unsigned int function,
 					   const char * const **groups,
-					   unsigned * const num_groups)
+					   unsigned int * const num_groups)
 {
 	struct bcm281xx_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
 
@@ -1057,8 +1057,8 @@ static int bcm281xx_pinctrl_get_fcn_groups(struct pinctrl_dev *pctldev,
 }
 
 static int bcm281xx_pinmux_set(struct pinctrl_dev *pctldev,
-			       unsigned function,
-			       unsigned group)
+			       unsigned int function,
+			       unsigned int group)
 {
 	struct bcm281xx_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
 	const struct bcm281xx_pin_function *f = &pdata->functions[function];
@@ -1089,7 +1089,7 @@ static const struct pinmux_ops bcm281xx_pinctrl_pinmux_ops = {
 };
 
 static int bcm281xx_pinctrl_pin_config_get(struct pinctrl_dev *pctldev,
-					   unsigned pin,
+					   unsigned int pin,
 					   unsigned long *config)
 {
 	return -ENOTSUPP;
@@ -1098,9 +1098,9 @@ static int bcm281xx_pinctrl_pin_config_get(struct pinctrl_dev *pctldev,
 
 /* Goes through the configs and update register val/mask */
 static int bcm281xx_std_pin_update(struct pinctrl_dev *pctldev,
-				   unsigned pin,
+				   unsigned int pin,
 				   unsigned long *configs,
-				   unsigned num_configs,
+				   unsigned int num_configs,
 				   u32 *val,
 				   u32 *mask)
 {
@@ -1214,9 +1214,9 @@ static const u16 bcm281xx_pullup_map[] = {
 
 /* Goes through the configs and update register val/mask */
 static int bcm281xx_i2c_pin_update(struct pinctrl_dev *pctldev,
-				   unsigned pin,
+				   unsigned int pin,
 				   unsigned long *configs,
-				   unsigned num_configs,
+				   unsigned int num_configs,
 				   u32 *val,
 				   u32 *mask)
 {
@@ -1284,9 +1284,9 @@ static int bcm281xx_i2c_pin_update(struct pinctrl_dev *pctldev,
 
 /* Goes through the configs and update register val/mask */
 static int bcm281xx_hdmi_pin_update(struct pinctrl_dev *pctldev,
-				    unsigned pin,
+				    unsigned int pin,
 				    unsigned long *configs,
-				    unsigned num_configs,
+				    unsigned int num_configs,
 				    u32 *val,
 				    u32 *mask)
 {
@@ -1328,9 +1328,9 @@ static int bcm281xx_hdmi_pin_update(struct pinctrl_dev *pctldev,
 }
 
 static int bcm281xx_pinctrl_pin_config_set(struct pinctrl_dev *pctldev,
-					   unsigned pin,
+					   unsigned int pin,
 					   unsigned long *configs,
-					   unsigned num_configs)
+					   unsigned int num_configs)
 {
 	struct bcm281xx_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
 	enum bcm281xx_pin_type pin_type;
diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index 200357094e3b..e9bfb96a2e0e 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -141,10 +141,14 @@ static int dt_to_map_one_config(struct pinctrl *p,
 		pctldev = get_pinctrl_dev_from_of_node(np_pctldev);
 		if (pctldev)
 			break;
-		/* Do not defer probing of hogs (circular loop) */
+		/*
+		 * Do not defer probing of hogs (circular loop)
+		 *
+		 * Return 1 to let the caller catch the case.
+		 */
 		if (np_pctldev == p->dev->of_node) {
 			of_node_put(np_pctldev);
-			return -ENODEV;
+			return 1;
 		}
 	}
 	of_node_put(np_pctldev);
@@ -268,6 +272,8 @@ int pinctrl_dt_to_map(struct pinctrl *p, struct pinctrl_dev *pctldev)
 			ret = dt_to_map_one_config(p, pctldev, statename,
 						   np_config);
 			of_node_put(np_config);
+			if (ret == 1)
+				continue;
 			if (ret < 0)
 				goto err;
 		}
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index aba479a1150c..f3b381370e5e 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -480,7 +480,7 @@ static int meson_pinconf_get(struct pinctrl_dev *pcdev, unsigned int pin,
 	case PIN_CONFIG_BIAS_PULL_DOWN:
 	case PIN_CONFIG_BIAS_PULL_UP:
 		if (meson_pinconf_get_pull(pc, pin) == param)
-			arg = 1;
+			arg = 60000;
 		else
 			return -EINVAL;
 		break;
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 761cab698c75..9e8be6c52e3d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2458,7 +2458,8 @@ static int asus_wmi_add(struct platform_device *pdev)
 		goto fail_leds;
 
 	asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_WLAN, &result);
-	if (result & (ASUS_WMI_DSTS_PRESENCE_BIT | ASUS_WMI_DSTS_USER_BIT))
+	if ((result & (ASUS_WMI_DSTS_PRESENCE_BIT | ASUS_WMI_DSTS_USER_BIT)) ==
+	    (ASUS_WMI_DSTS_PRESENCE_BIT | ASUS_WMI_DSTS_USER_BIT))
 		asus->driver->wlan_ctrl_by_user = 1;
 
 	if (!(asus->driver->wlan_ctrl_by_user && ashs_present())) {
diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 80929380ec7e..04ccfdd99e27 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -17,13 +17,13 @@
 /*
  * fujitsu-laptop.c - Fujitsu laptop support, providing access to additional
  * features made available on a range of Fujitsu laptops including the
- * P2xxx/P5xxx/S6xxx/S7xxx series.
+ * P2xxx/P5xxx/S2xxx/S6xxx/S7xxx series.
  *
  * This driver implements a vendor-specific backlight control interface for
  * Fujitsu laptops and provides support for hotkeys present on certain Fujitsu
  * laptops.
  *
- * This driver has been tested on a Fujitsu Lifebook S6410, S7020 and
+ * This driver has been tested on a Fujitsu Lifebook S2110, S6410, S7020 and
  * P8010.  It should work on most P-series and S-series Lifebooks, but
  * YMMV.
  *
@@ -102,7 +102,11 @@
 #define KEY2_CODE			0x411
 #define KEY3_CODE			0x412
 #define KEY4_CODE			0x413
-#define KEY5_CODE			0x420
+#define KEY5_CODE			0x414
+#define KEY6_CODE			0x415
+#define KEY7_CODE			0x416
+#define KEY8_CODE			0x417
+#define KEY9_CODE			0x420
 
 /* Hotkey ringbuffer limits */
 #define MAX_HOTKEY_RINGBUFFER_SIZE	100
@@ -450,7 +454,7 @@ static const struct key_entry keymap_default[] = {
 	{ KE_KEY, KEY2_CODE,            { KEY_PROG2 } },
 	{ KE_KEY, KEY3_CODE,            { KEY_PROG3 } },
 	{ KE_KEY, KEY4_CODE,            { KEY_PROG4 } },
-	{ KE_KEY, KEY5_CODE,            { KEY_RFKILL } },
+	{ KE_KEY, KEY9_CODE,            { KEY_RFKILL } },
 	/* Soft keys read from status flags */
 	{ KE_KEY, FLAG_RFKILL,          { KEY_RFKILL } },
 	{ KE_KEY, FLAG_TOUCHPAD_TOGGLE, { KEY_TOUCHPAD_TOGGLE } },
@@ -474,6 +478,18 @@ static const struct key_entry keymap_p8010[] = {
 	{ KE_END, 0 }
 };
 
+static const struct key_entry keymap_s2110[] = {
+	{ KE_KEY, KEY1_CODE, { KEY_PROG1 } }, /* "A" */
+	{ KE_KEY, KEY2_CODE, { KEY_PROG2 } }, /* "B" */
+	{ KE_KEY, KEY3_CODE, { KEY_WWW } },   /* "Internet" */
+	{ KE_KEY, KEY4_CODE, { KEY_EMAIL } }, /* "E-mail" */
+	{ KE_KEY, KEY5_CODE, { KEY_STOPCD } },
+	{ KE_KEY, KEY6_CODE, { KEY_PLAYPAUSE } },
+	{ KE_KEY, KEY7_CODE, { KEY_PREVIOUSSONG } },
+	{ KE_KEY, KEY8_CODE, { KEY_NEXTSONG } },
+	{ KE_END, 0 }
+};
+
 static const struct key_entry *keymap = keymap_default;
 
 static int fujitsu_laptop_dmi_keymap_override(const struct dmi_system_id *id)
@@ -511,6 +527,15 @@ static const struct dmi_system_id fujitsu_laptop_dmi_table[] = {
 		},
 		.driver_data = (void *)keymap_p8010
 	},
+	{
+		.callback = fujitsu_laptop_dmi_keymap_override,
+		.ident = "Fujitsu LifeBook S2110",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK S2110"),
+		},
+		.driver_data = (void *)keymap_s2110
+	},
 	{}
 };
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index fbb9a5c7f8b8..9eb74d9e1519 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -195,6 +195,7 @@ enum tpacpi_hkey_event_t {
 	/* Thermal events */
 	TP_HKEY_EV_ALARM_BAT_HOT	= 0x6011, /* battery too hot */
 	TP_HKEY_EV_ALARM_BAT_XHOT	= 0x6012, /* battery critically hot */
+	TP_HKEY_EV_ALARM_BAT_LIM_CHANGE	= 0x6013, /* battery charge limit changed*/
 	TP_HKEY_EV_ALARM_SENSOR_HOT	= 0x6021, /* sensor too hot */
 	TP_HKEY_EV_ALARM_SENSOR_XHOT	= 0x6022, /* sensor critically hot */
 	TP_HKEY_EV_THM_TABLE_CHANGED	= 0x6030, /* windows; thermal table changed */
@@ -4059,6 +4060,10 @@ static bool hotkey_notify_6xxx(const u32 hkey,
 		pr_alert("THERMAL EMERGENCY: battery is extremely hot!\n");
 		/* recommended action: immediate sleep/hibernate */
 		break;
+	case TP_HKEY_EV_ALARM_BAT_LIM_CHANGE:
+		pr_debug("Battery Info: battery charge threshold changed\n");
+		/* User changed charging threshold. No action needed */
+		return true;
 	case TP_HKEY_EV_ALARM_SENSOR_HOT:
 		pr_crit("THERMAL ALARM: a sensor reports something is too hot!\n");
 		/* recommended action: warn user through gui, that */
@@ -10112,6 +10117,8 @@ static int __must_check __init get_thinkpad_model_data(
 		tp->vendor = PCI_VENDOR_ID_IBM;
 	else if (dmi_name_in_vendors("LENOVO"))
 		tp->vendor = PCI_VENDOR_ID_LENOVO;
+	else if (dmi_name_in_vendors("NEC"))
+		tp->vendor = PCI_VENDOR_ID_LENOVO;
 	else
 		return 0;
 
diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
index 75f432f61e91..f4d6e62bd963 100644
--- a/drivers/regulator/ad5398.c
+++ b/drivers/regulator/ad5398.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
 
 #define AD5398_CURRENT_EN_MASK	0x8000
 
@@ -221,15 +222,20 @@ static int ad5398_probe(struct i2c_client *client,
 	const struct ad5398_current_data_format *df =
 			(struct ad5398_current_data_format *)id->driver_data;
 
-	if (!init_data)
-		return -EINVAL;
-
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
 	config.dev = &client->dev;
+	if (client->dev.of_node)
+		init_data = of_get_regulator_init_data(&client->dev,
+						       client->dev.of_node,
+						       &ad5398_reg);
+	if (!init_data)
+		return -EINVAL;
+
 	config.init_data = init_data;
+	config.of_node = client->dev.of_node;
 	config.driver_data = chip;
 
 	chip->client = client;
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 99b93f56a2d5..40532a36ae67 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1680,10 +1680,8 @@ static int ds1307_probe(struct i2c_client *client,
 		 * For some variants, be sure alarms can trigger when we're
 		 * running on Vbackup (BBSQI/BBSQW)
 		 */
-		if (want_irq || ds1307_can_wakeup_device) {
+		if (want_irq || ds1307_can_wakeup_device)
 			regs[0] |= DS1337_BIT_INTCN | chip->bbsqi_bit;
-			regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
-		}
 
 		regmap_write(ds1307->regmap, DS1337_REG_CONTROL,
 			     regs[0]);
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 0abce779fbb1..3238222b89fa 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -5357,6 +5357,7 @@ static struct lpfc_nodelist *
 __lpfc_findnode_did(struct lpfc_vport *vport, uint32_t did)
 {
 	struct lpfc_nodelist *ndlp;
+	struct lpfc_nodelist *np = NULL;
 	uint32_t data1;
 
 	list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
@@ -5371,14 +5372,20 @@ __lpfc_findnode_did(struct lpfc_vport *vport, uint32_t did)
 					 ndlp, ndlp->nlp_DID,
 					 ndlp->nlp_flag, data1, ndlp->nlp_rpi,
 					 ndlp->active_rrqs_xri_bitmap);
-			return ndlp;
+
+			/* Check for new or potentially stale node */
+			if (ndlp->nlp_state != NLP_STE_UNUSED_NODE)
+				return ndlp;
+			np = ndlp;
 		}
 	}
 
-	/* FIND node did <did> NOT FOUND */
-	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
-			 "0932 FIND node did x%x NOT FOUND.\n", did);
-	return NULL;
+	if (!np)
+		/* FIND node did <did> NOT FOUND */
+		lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
+				 "0932 FIND node did x%x NOT FOUND.\n", did);
+
+	return np;
 }
 
 struct lpfc_nodelist *
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 1c5c172315de..377e941d93e3 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -662,6 +662,7 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 	size_t data_in_sz = 0;
 	long ret;
 	u16 device_handle = MPT3SAS_INVALID_DEVICE_HANDLE;
+	int tm_ret;
 
 	issue_reset = 0;
 
@@ -1094,16 +1095,23 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 			if (pcie_device && (!ioc->tm_custom_handling) &&
 			    (!(mpt3sas_scsih_is_pcie_scsi_device(
 			    pcie_device->device_info))))
-				mpt3sas_scsih_issue_locked_tm(ioc,
+				tm_ret = mpt3sas_scsih_issue_locked_tm(ioc,
 				  le16_to_cpu(mpi_request->FunctionDependent1),
 				  0, MPI2_SCSITASKMGMT_TASKTYPE_TARGET_RESET, 0,
 				  0, pcie_device->reset_timeout,
 			MPI26_SCSITASKMGMT_MSGFLAGS_PROTOCOL_LVL_RST_PCIE);
 			else
-				mpt3sas_scsih_issue_locked_tm(ioc,
+				tm_ret = mpt3sas_scsih_issue_locked_tm(ioc,
 				  le16_to_cpu(mpi_request->FunctionDependent1),
 				  0, MPI2_SCSITASKMGMT_TASKTYPE_TARGET_RESET, 0,
 				  0, 30, MPI2_SCSITASKMGMT_MSGFLAGS_LINK_RESET);
+
+			if (tm_ret != SUCCESS) {
+				ioc_info(ioc,
+					 "target reset failed, issue hard reset: handle (0x%04x)\n",
+					 le16_to_cpu(mpi_request->FunctionDependent1));
+				mpt3sas_base_hard_reset_handler(ioc, FORCE_BIG_HAMMER);
+			}
 		} else
 			mpt3sas_base_hard_reset_handler(ioc, FORCE_BIG_HAMMER);
 	}
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 2b5e3e2ba3b8..d4aef346bfee 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -949,7 +949,6 @@ static void reset_state(struct scsi_tape *STp)
 		STp->partition = find_partition(STp);
 		if (STp->partition < 0)
 			STp->partition = 0;
-		STp->new_partition = STp->partition;
 	}
 }
 
@@ -2889,7 +2888,6 @@ static int st_int_ioctl(struct scsi_tape *STp, unsigned int cmd_in, unsigned lon
 			timeout = STp->long_timeout * 8;
 
 		DEBC_printk(STp, "Erasing tape.\n");
-		fileno = blkno = at_sm = 0;
 		break;
 	case MTSETBLK:		/* Set block length */
 	case MTSETDENSITY:	/* Set tape density */
@@ -2922,14 +2920,17 @@ static int st_int_ioctl(struct scsi_tape *STp, unsigned int cmd_in, unsigned lon
 		if (cmd_in == MTSETDENSITY) {
 			(STp->buffer)->b_data[4] = arg;
 			STp->density_changed = 1;	/* At least we tried ;-) */
+			STp->changed_density = arg;
 		} else if (cmd_in == SET_DENS_AND_BLK)
 			(STp->buffer)->b_data[4] = arg >> 24;
 		else
 			(STp->buffer)->b_data[4] = STp->density;
 		if (cmd_in == MTSETBLK || cmd_in == SET_DENS_AND_BLK) {
 			ltmp = arg & MT_ST_BLKSIZE_MASK;
-			if (cmd_in == MTSETBLK)
+			if (cmd_in == MTSETBLK) {
 				STp->blksize_changed = 1; /* At least we tried ;-) */
+				STp->changed_blksize = arg;
+			}
 		} else
 			ltmp = STp->block_size;
 		(STp->buffer)->b_data[9] = (ltmp >> 16);
@@ -3076,7 +3077,9 @@ static int st_int_ioctl(struct scsi_tape *STp, unsigned int cmd_in, unsigned lon
 			   cmd_in == MTSETDRVBUFFER ||
 			   cmd_in == SET_DENS_AND_BLK) {
 			if (cmdstatp->sense_hdr.sense_key == ILLEGAL_REQUEST &&
-			    !(STp->use_pf & PF_TESTED)) {
+				cmdstatp->sense_hdr.asc == 0x24 &&
+				(STp->device)->scsi_level <= SCSI_2 &&
+				!(STp->use_pf & PF_TESTED)) {
 				/* Try the other possible state of Page Format if not
 				   already tried */
 				STp->use_pf = (STp->use_pf ^ USE_PF) | PF_TESTED;
@@ -3628,9 +3631,25 @@ static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 				retval = (-EIO);
 				goto out;
 			}
-			reset_state(STp);
+			reset_state(STp); /* Clears pos_unknown */
 			/* remove this when the midlevel properly clears was_reset */
 			STp->device->was_reset = 0;
+
+			/* Fix the device settings after reset, ignore errors */
+			if (mtc.mt_op == MTREW || mtc.mt_op == MTSEEK ||
+				mtc.mt_op == MTEOM) {
+				if (STp->can_partitions) {
+					/* STp->new_partition contains the
+					 *  latest partition set
+					 */
+					STp->partition = 0;
+					switch_partition(STp);
+				}
+				if (STp->density_changed)
+					st_int_ioctl(STp, MTSETDENSITY, STp->changed_density);
+				if (STp->blksize_changed)
+					st_int_ioctl(STp, MTSETBLK, STp->changed_blksize);
+			}
 		}
 
 		if (mtc.mt_op != MTNOP && mtc.mt_op != MTSETBLK &&
diff --git a/drivers/scsi/st.h b/drivers/scsi/st.h
index 95d2e7a7988d..c9947abb0a45 100644
--- a/drivers/scsi/st.h
+++ b/drivers/scsi/st.h
@@ -168,12 +168,14 @@ struct scsi_tape {
 	unsigned char compression_changed;
 	unsigned char drv_buffer;
 	unsigned char density;
+	unsigned char changed_density;
 	unsigned char door_locked;
 	unsigned char autorew_dev;   /* auto-rewind device */
 	unsigned char rew_at_close;  /* rewind necessary at close */
 	unsigned char inited;
 	unsigned char cleaning_req;  /* cleaning requested? */
 	int block_size;
+	int changed_blksize;
 	int min_block;
 	int max_block;
 	int recover_count;     /* From tape opening */
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 351b2989db07..1d94fc89602f 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 //
 // Copyright 2013 Freescale Semiconductor, Inc.
-// Copyright 2020 NXP
+// Copyright 2020-2025 NXP
 //
 // Freescale DSPI driver
 // This file contains a driver for the Freescale DSPI
@@ -946,6 +946,20 @@ static int dspi_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(dspi_pm, dspi_suspend, dspi_resume);
 
+static const struct regmap_range dspi_yes_ranges[] = {
+	regmap_reg_range(SPI_MCR, SPI_MCR),
+	regmap_reg_range(SPI_TCR, SPI_CTAR(3)),
+	regmap_reg_range(SPI_SR, SPI_TXFR3),
+	regmap_reg_range(SPI_RXFR0, SPI_RXFR3),
+	regmap_reg_range(SPI_CTARE(0), SPI_CTARE(3)),
+	regmap_reg_range(SPI_SREX, SPI_SREX),
+};
+
+static const struct regmap_access_table dspi_access_table = {
+	.yes_ranges	= dspi_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(dspi_yes_ranges),
+};
+
 static const struct regmap_range dspi_volatile_ranges[] = {
 	regmap_reg_range(SPI_MCR, SPI_TCR),
 	regmap_reg_range(SPI_SR, SPI_SR),
@@ -963,6 +977,8 @@ static const struct regmap_config dspi_regmap_config = {
 	.reg_stride	= 4,
 	.max_register	= 0x88,
 	.volatile_table	= &dspi_volatile_table,
+	.rd_table	= &dspi_access_table,
+	.wr_table	= &dspi_access_table,
 };
 
 static const struct regmap_range dspi_xspi_volatile_ranges[] = {
@@ -984,6 +1000,8 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 		.reg_stride	= 4,
 		.max_register	= 0x13c,
 		.volatile_table	= &dspi_xspi_volatile_table,
+		.rd_table	= &dspi_access_table,
+		.wr_table	= &dspi_access_table,
 	},
 	{
 		.name		= "pushr",
diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 69a9df2cbbcf..0f571ff13237 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -377,7 +377,7 @@ MODULE_LICENSE("GPL");
 static void spi_test_print_hex_dump(char *pre, const void *ptr, size_t len)
 {
 	/* limit the hex_dump */
-	if (len < 1024) {
+	if (len <= 1024) {
 		print_hex_dump(KERN_INFO, pre,
 			       DUMP_PREFIX_OFFSET, 16, 1,
 			       ptr, len, 0);
diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index cbfac6596fad..2bdac65789b6 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -263,6 +263,9 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	else
 		reg |= SUN4I_CTL_DHB;
 
+	/* Now that the settings are correct, enable the interface */
+	reg |= SUN4I_CTL_ENABLE;
+
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
 
 	/* Ensure that we have a parent clock fast enough */
@@ -403,7 +406,7 @@ static int sun4i_spi_runtime_resume(struct device *dev)
 	}
 
 	sun4i_spi_write(sspi, SUN4I_CTL_REG,
-			SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP);
+			SUN4I_CTL_MASTER | SUN4I_CTL_TP);
 
 	return 0;
 
diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 805437fa249a..4dd2c8e9b787 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -16,7 +16,7 @@
 
 #include <linux/kernel.h>
 #include <linux/wait.h>
-#include <linux/spinlock_types.h>
+#include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/init.h>
@@ -134,9 +134,9 @@ struct axis_fifo {
 	int has_tx_fifo; /* whether the IP has the tx fifo enabled */
 
 	wait_queue_head_t read_queue; /* wait queue for asynchronos read */
-	spinlock_t read_queue_lock; /* lock for reading waitqueue */
+	struct mutex read_lock; /* lock for reading */
 	wait_queue_head_t write_queue; /* wait queue for asynchronos write */
-	spinlock_t write_queue_lock; /* lock for writing waitqueue */
+	struct mutex write_lock; /* lock for writing */
 	unsigned int write_flags; /* write file flags */
 	unsigned int read_flags; /* read file flags */
 
@@ -337,7 +337,21 @@ static void reset_ip_core(struct axis_fifo *fifo)
 	iowrite32(XLLF_INT_ALL_MASK, fifo->base_addr + XLLF_ISR_OFFSET);
 }
 
-/* reads a single packet from the fifo as dictated by the tlast signal */
+/**
+ * axis_fifo_write() - Read a packet from AXIS-FIFO character device.
+ * @f Open file.
+ * @buf User space buffer to read to.
+ * @len User space buffer length.
+ * @off Buffer offset.
+ *
+ * As defined by the device's documentation, we need to check the device's
+ * occupancy before reading the length register and then the data. All these
+ * operations must be executed atomically, in order and one after the other
+ * without missing any.
+ *
+ * Returns the number of bytes read from the device or negative error code
+ *	on failure.
+ */
 static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 			      size_t len, loff_t *off)
 {
@@ -351,60 +365,61 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 	u32 tmp_buf[READ_BUF_SIZE];
 
 	if (fifo->read_flags & O_NONBLOCK) {
-		/* opened in non-blocking mode
-		 * return if there are no packets available
+		/*
+		 * Device opened in non-blocking mode. Try to lock it and then
+		 * check if any packet is available.
 		 */
-		if (!ioread32(fifo->base_addr + XLLF_RDFO_OFFSET))
+		if (!mutex_trylock(&fifo->read_lock))
 			return -EAGAIN;
+
+		if (!ioread32(fifo->base_addr + XLLF_RDFO_OFFSET)) {
+			ret = -EAGAIN;
+			goto end_unlock;
+		}
 	} else {
 		/* opened in blocking mode
 		 * wait for a packet available interrupt (or timeout)
 		 * if nothing is currently available
 		 */
-		spin_lock_irq(&fifo->read_queue_lock);
-		ret = wait_event_interruptible_lock_irq_timeout
-			(fifo->read_queue,
-			 ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
-			 fifo->read_queue_lock,
-			 (read_timeout >= 0) ? msecs_to_jiffies(read_timeout) :
+		mutex_lock(&fifo->read_lock);
+		ret = wait_event_interruptible_timeout(fifo->read_queue,
+			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
+			(read_timeout >= 0) ? msecs_to_jiffies(read_timeout) :
 				MAX_SCHEDULE_TIMEOUT);
-		spin_unlock_irq(&fifo->read_queue_lock);
 
-		if (ret == 0) {
-			/* timeout occurred */
-			dev_dbg(fifo->dt_device, "read timeout");
-			return -EAGAIN;
-		} else if (ret == -ERESTARTSYS) {
-			/* signal received */
-			return -ERESTARTSYS;
-		} else if (ret < 0) {
-			dev_err(fifo->dt_device, "wait_event_interruptible_timeout() error in read (ret=%i)\n",
-				ret);
-			return ret;
+		if (ret <= 0) {
+			if (ret == 0) {
+				ret = -EAGAIN;
+			} else if (ret != -ERESTARTSYS) {
+				dev_err(fifo->dt_device, "wait_event_interruptible_timeout() error in read (ret=%i)\n",
+					ret);
+			}
+
+			goto end_unlock;
 		}
 	}
 
 	bytes_available = ioread32(fifo->base_addr + XLLF_RLR_OFFSET);
 	if (!bytes_available) {
-		dev_err(fifo->dt_device, "received a packet of length 0 - fifo core will be reset\n");
-		reset_ip_core(fifo);
-		return -EIO;
+		dev_err(fifo->dt_device, "received a packet of length 0\n");
+		ret = -EIO;
+		goto end_unlock;
 	}
 
 	if (bytes_available > len) {
-		dev_err(fifo->dt_device, "user read buffer too small (available bytes=%zu user buffer bytes=%zu) - fifo core will be reset\n",
+		dev_err(fifo->dt_device, "user read buffer too small (available bytes=%zu user buffer bytes=%zu)\n",
 			bytes_available, len);
-		reset_ip_core(fifo);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto end_unlock;
 	}
 
 	if (bytes_available % sizeof(u32)) {
 		/* this probably can't happen unless IP
 		 * registers were previously mishandled
 		 */
-		dev_err(fifo->dt_device, "received a packet that isn't word-aligned - fifo core will be reset\n");
-		reset_ip_core(fifo);
-		return -EIO;
+		dev_err(fifo->dt_device, "received a packet that isn't word-aligned\n");
+		ret = -EIO;
+		goto end_unlock;
 	}
 
 	words_available = bytes_available / sizeof(u32);
@@ -423,17 +438,37 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 
 		if (copy_to_user(buf + copied * sizeof(u32), tmp_buf,
 				 copy * sizeof(u32))) {
-			reset_ip_core(fifo);
-			return -EFAULT;
+			ret = -EFAULT;
+			goto end_unlock;
 		}
 
 		copied += copy;
 		words_available -= copy;
 	}
 
-	return bytes_available;
+	ret = bytes_available;
+
+end_unlock:
+	mutex_unlock(&fifo->read_lock);
+
+	return ret;
 }
 
+/**
+ * axis_fifo_write() - Write buffer to AXIS-FIFO character device.
+ * @f Open file.
+ * @buf User space buffer to write to the device.
+ * @len User space buffer length.
+ * @off Buffer offset.
+ *
+ * As defined by the device's documentation, we need to write to the device's
+ * data buffer then to the device's packet length register atomically. Also,
+ * we need to lock before checking if the device has available space to avoid
+ * any concurrency issue.
+ *
+ * Returns the number of bytes written to the device or negative error code
+ *	on failure.
+ */
 static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 			       size_t len, loff_t *off)
 {
@@ -466,12 +501,17 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 	}
 
 	if (fifo->write_flags & O_NONBLOCK) {
-		/* opened in non-blocking mode
-		 * return if there is not enough room available in the fifo
+		/*
+		 * Device opened in non-blocking mode. Try to lock it and then
+		 * check if there is any room to write the given buffer.
 		 */
+		if (!mutex_trylock(&fifo->write_lock))
+			return -EAGAIN;
+
 		if (words_to_write > ioread32(fifo->base_addr +
 					      XLLF_TDFV_OFFSET)) {
-			return -EAGAIN;
+			ret = -EAGAIN;
+			goto end_unlock;
 		}
 	} else {
 		/* opened in blocking mode */
@@ -479,30 +519,22 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		/* wait for an interrupt (or timeout) if there isn't
 		 * currently enough room in the fifo
 		 */
-		spin_lock_irq(&fifo->write_queue_lock);
-		ret = wait_event_interruptible_lock_irq_timeout
-			(fifo->write_queue,
-			 ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
+		mutex_lock(&fifo->write_lock);
+		ret = wait_event_interruptible_timeout(fifo->write_queue,
+			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
 				>= words_to_write,
-			 fifo->write_queue_lock,
-			 (write_timeout >= 0) ?
-				msecs_to_jiffies(write_timeout) :
+			(write_timeout >= 0) ? msecs_to_jiffies(write_timeout) :
 				MAX_SCHEDULE_TIMEOUT);
-		spin_unlock_irq(&fifo->write_queue_lock);
 
-		if (ret == 0) {
-			/* timeout occurred */
-			dev_dbg(fifo->dt_device, "write timeout\n");
-			return -EAGAIN;
-		} else if (ret == -ERESTARTSYS) {
-			/* signal received */
-			return -ERESTARTSYS;
-		} else if (ret < 0) {
-			/* unknown error */
-			dev_err(fifo->dt_device,
-				"wait_event_interruptible_timeout() error in write (ret=%i)\n",
-				ret);
-			return ret;
+		if (ret <= 0) {
+			if (ret == 0) {
+				ret = -EAGAIN;
+			} else if (ret != -ERESTARTSYS) {
+				dev_err(fifo->dt_device, "wait_event_interruptible_timeout() error in write (ret=%i)\n",
+					ret);
+			}
+
+			goto end_unlock;
 		}
 	}
 
@@ -515,8 +547,8 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 
 		if (copy_from_user(tmp_buf, buf + copied * sizeof(u32),
 				   copy * sizeof(u32))) {
-			reset_ip_core(fifo);
-			return -EFAULT;
+			ret = -EFAULT;
+			goto end_unlock;
 		}
 
 		for (i = 0; i < copy; i++)
@@ -527,10 +559,15 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		words_to_write -= copy;
 	}
 
+	ret = copied * sizeof(u32);
+
 	/* write packet size to fifo */
-	iowrite32(copied * sizeof(u32), fifo->base_addr + XLLF_TLR_OFFSET);
+	iowrite32(ret, fifo->base_addr + XLLF_TLR_OFFSET);
 
-	return (ssize_t)copied * sizeof(u32);
+end_unlock:
+	mutex_unlock(&fifo->write_lock);
+
+	return ret;
 }
 
 static irqreturn_t axis_fifo_irq(int irq, void *dw)
@@ -701,6 +738,65 @@ static int get_dts_property(struct axis_fifo *fifo,
 	return 0;
 }
 
+static int axis_fifo_parse_dt(struct axis_fifo *fifo)
+{
+	int ret;
+	unsigned int value;
+
+	ret = get_dts_property(fifo, "xlnx,axi-str-rxd-tdata-width", &value);
+	if (ret) {
+		dev_err(fifo->dt_device, "missing xlnx,axi-str-rxd-tdata-width property\n");
+		goto end;
+	} else if (value != 32) {
+		dev_err(fifo->dt_device, "xlnx,axi-str-rxd-tdata-width only supports 32 bits\n");
+		ret = -EIO;
+		goto end;
+	}
+
+	ret = get_dts_property(fifo, "xlnx,axi-str-txd-tdata-width", &value);
+	if (ret) {
+		dev_err(fifo->dt_device, "missing xlnx,axi-str-txd-tdata-width property\n");
+		goto end;
+	} else if (value != 32) {
+		dev_err(fifo->dt_device, "xlnx,axi-str-txd-tdata-width only supports 32 bits\n");
+		ret = -EIO;
+		goto end;
+	}
+
+	ret = get_dts_property(fifo, "xlnx,rx-fifo-depth",
+			       &fifo->rx_fifo_depth);
+	if (ret) {
+		dev_err(fifo->dt_device, "missing xlnx,rx-fifo-depth property\n");
+		ret = -EIO;
+		goto end;
+	}
+
+	ret = get_dts_property(fifo, "xlnx,tx-fifo-depth",
+			       &fifo->tx_fifo_depth);
+	if (ret) {
+		dev_err(fifo->dt_device, "missing xlnx,tx-fifo-depth property\n");
+		ret = -EIO;
+		goto end;
+	}
+
+	ret = get_dts_property(fifo, "xlnx,use-rx-data", &fifo->has_rx_fifo);
+	if (ret) {
+		dev_err(fifo->dt_device, "missing xlnx,use-rx-data property\n");
+		ret = -EIO;
+		goto end;
+	}
+
+	ret = get_dts_property(fifo, "xlnx,use-tx-data", &fifo->has_tx_fifo);
+	if (ret) {
+		dev_err(fifo->dt_device, "missing xlnx,use-tx-data property\n");
+		ret = -EIO;
+		goto end;
+	}
+
+end:
+	return ret;
+}
+
 static int axis_fifo_probe(struct platform_device *pdev)
 {
 	struct resource *r_irq; /* interrupt resources */
@@ -712,34 +808,6 @@ static int axis_fifo_probe(struct platform_device *pdev)
 
 	int rc = 0; /* error return value */
 
-	/* IP properties from device tree */
-	unsigned int rxd_tdata_width;
-	unsigned int txc_tdata_width;
-	unsigned int txd_tdata_width;
-	unsigned int tdest_width;
-	unsigned int tid_width;
-	unsigned int tuser_width;
-	unsigned int data_interface_type;
-	unsigned int has_tdest;
-	unsigned int has_tid;
-	unsigned int has_tkeep;
-	unsigned int has_tstrb;
-	unsigned int has_tuser;
-	unsigned int rx_fifo_depth;
-	unsigned int rx_programmable_empty_threshold;
-	unsigned int rx_programmable_full_threshold;
-	unsigned int axi_id_width;
-	unsigned int axi4_data_width;
-	unsigned int select_xpm;
-	unsigned int tx_fifo_depth;
-	unsigned int tx_programmable_empty_threshold;
-	unsigned int tx_programmable_full_threshold;
-	unsigned int use_rx_cut_through;
-	unsigned int use_rx_data;
-	unsigned int use_tx_control;
-	unsigned int use_tx_cut_through;
-	unsigned int use_tx_data;
-
 	/* ----------------------------
 	 *     init wrapper device
 	 * ----------------------------
@@ -756,8 +824,8 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	init_waitqueue_head(&fifo->read_queue);
 	init_waitqueue_head(&fifo->write_queue);
 
-	spin_lock_init(&fifo->read_queue_lock);
-	spin_lock_init(&fifo->write_queue_lock);
+	mutex_init(&fifo->read_lock);
+	mutex_init(&fifo->write_lock);
 
 	/* ----------------------------
 	 *   init device memory space
@@ -806,164 +874,9 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	 * ----------------------------
 	 */
 
-	/* retrieve device tree properties */
-	rc = get_dts_property(fifo, "xlnx,axi-str-rxd-tdata-width",
-			      &rxd_tdata_width);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,axi-str-txc-tdata-width",
-			      &txc_tdata_width);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,axi-str-txd-tdata-width",
-			      &txd_tdata_width);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,axis-tdest-width", &tdest_width);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,axis-tid-width", &tid_width);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,axis-tuser-width", &tuser_width);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,data-interface-type",
-			      &data_interface_type);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,has-axis-tdest", &has_tdest);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,has-axis-tid", &has_tid);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,has-axis-tkeep", &has_tkeep);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,has-axis-tstrb", &has_tstrb);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,has-axis-tuser", &has_tuser);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,rx-fifo-depth", &rx_fifo_depth);
+	rc = axis_fifo_parse_dt(fifo);
 	if (rc)
 		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,rx-fifo-pe-threshold",
-			      &rx_programmable_empty_threshold);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,rx-fifo-pf-threshold",
-			      &rx_programmable_full_threshold);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,s-axi-id-width", &axi_id_width);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,s-axi4-data-width", &axi4_data_width);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,select-xpm", &select_xpm);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,tx-fifo-depth", &tx_fifo_depth);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,tx-fifo-pe-threshold",
-			      &tx_programmable_empty_threshold);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,tx-fifo-pf-threshold",
-			      &tx_programmable_full_threshold);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,use-rx-cut-through",
-			      &use_rx_cut_through);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,use-rx-data", &use_rx_data);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,use-tx-ctrl", &use_tx_control);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,use-tx-cut-through",
-			      &use_tx_cut_through);
-	if (rc)
-		goto err_unmap;
-	rc = get_dts_property(fifo, "xlnx,use-tx-data", &use_tx_data);
-	if (rc)
-		goto err_unmap;
-
-	/* check validity of device tree properties */
-	if (rxd_tdata_width != 32) {
-		dev_err(fifo->dt_device,
-			"rxd_tdata_width width [%u] unsupported\n",
-			rxd_tdata_width);
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (txd_tdata_width != 32) {
-		dev_err(fifo->dt_device,
-			"txd_tdata_width width [%u] unsupported\n",
-			txd_tdata_width);
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (has_tdest) {
-		dev_err(fifo->dt_device, "tdest not supported\n");
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (has_tid) {
-		dev_err(fifo->dt_device, "tid not supported\n");
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (has_tkeep) {
-		dev_err(fifo->dt_device, "tkeep not supported\n");
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (has_tstrb) {
-		dev_err(fifo->dt_device, "tstrb not supported\n");
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (has_tuser) {
-		dev_err(fifo->dt_device, "tuser not supported\n");
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (use_rx_cut_through) {
-		dev_err(fifo->dt_device, "rx cut-through not supported\n");
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (use_tx_cut_through) {
-		dev_err(fifo->dt_device, "tx cut-through not supported\n");
-		rc = -EIO;
-		goto err_unmap;
-	}
-	if (use_tx_control) {
-		dev_err(fifo->dt_device, "tx control not supported\n");
-		rc = -EIO;
-		goto err_unmap;
-	}
-
-	/* TODO
-	 * these exist in the device tree but it's unclear what they do
-	 * - select-xpm
-	 * - data-interface-type
-	 */
-
-	/* set device wrapper properties based on IP config */
-	fifo->rx_fifo_depth = rx_fifo_depth;
-	/* IP sets TDFV to fifo depth - 4 so we will do the same */
-	fifo->tx_fifo_depth = tx_fifo_depth - 4;
-	fifo->has_rx_fifo = use_rx_data;
-	fifo->has_tx_fifo = use_tx_data;
 
 	reset_ip_core(fifo);
 
diff --git a/drivers/staging/axis-fifo/axis-fifo.txt b/drivers/staging/axis-fifo/axis-fifo.txt
index 85d88c010e72..5828e1b8e822 100644
--- a/drivers/staging/axis-fifo/axis-fifo.txt
+++ b/drivers/staging/axis-fifo/axis-fifo.txt
@@ -25,10 +25,10 @@ Required properties:
 - xlnx,axi-str-txc-tdata-width: Should be <0x20>
 - xlnx,axi-str-txd-protocol: Should be "XIL_AXI_STREAM_ETH_DATA"
 - xlnx,axi-str-txd-tdata-width: Should be <0x20>
-- xlnx,axis-tdest-width: AXI-Stream TDEST width
-- xlnx,axis-tid-width: AXI-Stream TID width
-- xlnx,axis-tuser-width: AXI-Stream TUSER width
-- xlnx,data-interface-type: Should be <0x0>
+- xlnx,axis-tdest-width: AXI-Stream TDEST width (ignored by the driver)
+- xlnx,axis-tid-width: AXI-Stream TID width (ignored by the driver)
+- xlnx,axis-tuser-width: AXI-Stream TUSER width (ignored by the driver)
+- xlnx,data-interface-type: Should be <0x0> (ignored by the driver)
 - xlnx,has-axis-tdest: Should be <0x0> (this feature isn't supported)
 - xlnx,has-axis-tid: Should be <0x0> (this feature isn't supported)
 - xlnx,has-axis-tkeep: Should be <0x0> (this feature isn't supported)
@@ -36,13 +36,17 @@ Required properties:
 - xlnx,has-axis-tuser: Should be <0x0> (this feature isn't supported)
 - xlnx,rx-fifo-depth: Depth of RX FIFO in words
 - xlnx,rx-fifo-pe-threshold: RX programmable empty interrupt threshold
+	(ignored by the driver)
 - xlnx,rx-fifo-pf-threshold: RX programmable full interrupt threshold
-- xlnx,s-axi-id-width: Should be <0x4>
-- xlnx,s-axi4-data-width: Should be <0x20>
-- xlnx,select-xpm: Should be <0x0>
+	(ignored by the driver)
+- xlnx,s-axi-id-width: Should be <0x4> (ignored by the driver)
+- xlnx,s-axi4-data-width: Should be <0x20> (ignored by the driver)
+- xlnx,select-xpm: Should be <0x0> (ignored by the driver)
 - xlnx,tx-fifo-depth: Depth of TX FIFO in words
 - xlnx,tx-fifo-pe-threshold: TX programmable empty interrupt threshold
+	(ignored by the driver)
 - xlnx,tx-fifo-pf-threshold: TX programmable full interrupt threshold
+	(ignored by the driver)
 - xlnx,use-rx-cut-through: Should be <0x0> (this feature isn't supported)
 - xlnx,use-rx-data: <0x1> if RX FIFO is enabled, <0x0> otherwise
 - xlnx,use-tx-ctrl: Should be <0x0> (this feature isn't supported)
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index a9985a7f8199..c1f583895070 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -136,7 +136,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
-	if (strcmp(buf, "full")) {
+	if (strcmp(buf, "full") == 0) {
 		gpiod_set_value(chip->rdwr_pin, 1);
 		chip->mode = AD7816_FULL;
 	} else {
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index ab2f0ceb1e23..b610c99c9c2d 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4168,8 +4168,8 @@ int iscsit_close_connection(
 	spin_unlock(&iscsit_global->ts_bitmap_lock);
 
 	iscsit_stop_timers_for_cmds(conn);
-	iscsit_stop_nopin_response_timer(conn);
 	iscsit_stop_nopin_timer(conn);
+	iscsit_stop_nopin_response_timer(conn);
 
 	if (conn->conn_transport->iscsit_wait_conn)
 		conn->conn_transport->iscsit_wait_conn(conn);
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 18fbbe510d01..eb3eae8f799a 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -455,6 +455,9 @@ fd_execute_write_same(struct se_cmd *cmd)
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 	}
 
+	if (!cmd->t_data_nents)
+		return TCM_INVALID_CDB_FIELD;
+
 	if (cmd->t_data_nents > 1 ||
 	    cmd->t_data_sg[0].length != cmd->se_dev->dev_attrib.block_size) {
 		pr_err("WRITE_SAME: Illegal SGL t_data_nents: %u length: %u"
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 1c181d31f4c8..19cf5bdbb03d 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -458,6 +458,10 @@ iblock_execute_write_same(struct se_cmd *cmd)
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
index e63c163dba78..6f6db650e938 100644
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
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 0fe545815c5c..d4566b5ec348 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -340,11 +340,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		pdata.flags |= CI_HDRC_IMX_IS_HSIC;
 		data->usbmisc_data->hsic = 1;
 		data->pinctrl = devm_pinctrl_get(dev);
-		if (IS_ERR(data->pinctrl)) {
-			dev_err(dev, "pinctrl get failed, err=%ld\n",
-					PTR_ERR(data->pinctrl));
-			return PTR_ERR(data->pinctrl);
-		}
+		if (PTR_ERR(data->pinctrl) == -ENODEV)
+			data->pinctrl = NULL;
+		else if (IS_ERR(data->pinctrl))
+			return dev_err_probe(dev, PTR_ERR(data->pinctrl),
+					     "pinctrl get failed\n");
 
 		pinctrl_hsic_idle = pinctrl_lookup_state(data->pinctrl, "idle");
 		if (IS_ERR(pinctrl_hsic_idle)) {
@@ -369,17 +369,14 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 			return PTR_ERR(data->pinctrl_hsic_active);
 		}
 
-		data->hsic_pad_regulator = devm_regulator_get(dev, "hsic");
-		if (PTR_ERR(data->hsic_pad_regulator) == -EPROBE_DEFER) {
-			return -EPROBE_DEFER;
-		} else if (PTR_ERR(data->hsic_pad_regulator) == -ENODEV) {
+		data->hsic_pad_regulator =
+				devm_regulator_get_optional(dev, "hsic");
+		if (PTR_ERR(data->hsic_pad_regulator) == -ENODEV) {
 			/* no pad regualator is needed */
 			data->hsic_pad_regulator = NULL;
-		} else if (IS_ERR(data->hsic_pad_regulator)) {
-			dev_err(dev, "Get HSIC pad regulator error: %ld\n",
-					PTR_ERR(data->hsic_pad_regulator));
-			return PTR_ERR(data->hsic_pad_regulator);
-		}
+		} else if (IS_ERR(data->hsic_pad_regulator))
+			return dev_err_probe(dev, PTR_ERR(data->hsic_pad_regulator),
+					     "Get HSIC pad regulator error\n");
 
 		if (data->hsic_pad_regulator) {
 			ret = regulator_enable(data->hsic_pad_regulator);
@@ -420,7 +417,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	    of_usb_get_phy_mode(np) == USBPHY_INTERFACE_MODE_ULPI) {
 		pdata.flags |= CI_HDRC_OVERRIDE_PHY_CONTROL;
 		data->override_phy_control = true;
-		usb_phy_init(pdata.usb_phy);
+		ret = usb_phy_init(pdata.usb_phy);
+		if (ret) {
+			dev_err(dev, "Failed to init phy\n");
+			goto err_clk;
+		}
 	}
 
 	if (pdata.flags & CI_HDRC_SUPPORTS_RUNTIME_PM)
@@ -429,7 +430,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	ret = imx_usbmisc_init(data->usbmisc_data);
 	if (ret) {
 		dev_err(dev, "usbmisc init failed, ret=%d\n", ret);
-		goto err_clk;
+		goto phy_shutdown;
 	}
 
 	data->ci_pdev = ci_hdrc_add_device(dev,
@@ -437,10 +438,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 				&pdata);
 	if (IS_ERR(data->ci_pdev)) {
 		ret = PTR_ERR(data->ci_pdev);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "ci_hdrc_add_device failed, err=%d\n",
-					ret);
-		goto err_clk;
+		dev_err_probe(dev, ret, "ci_hdrc_add_device failed\n");
+		goto phy_shutdown;
 	}
 
 	ret = imx_usbmisc_init_post(data->usbmisc_data);
@@ -460,6 +459,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 disable_device:
 	ci_hdrc_remove_device(data->ci_pdev);
+phy_shutdown:
+	if (data->override_phy_control)
+		usb_phy_shutdown(data->phy);
 err_clk:
 	imx_disable_unprepare_clks(dev);
 disable_hsic_regulator:
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 00345a51f18d..67e96fc4f9b5 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -485,6 +485,7 @@ static int usbtmc488_ioctl_read_stb(struct usbtmc_file_data *file_data,
 	u8 tag;
 	__u8 stb;
 	int rv;
+	long wait_rv;
 
 	dev_dbg(dev, "Enter ioctl_read_stb iin_ep_present: %d\n",
 		data->iin_ep_present);
@@ -527,16 +528,17 @@ static int usbtmc488_ioctl_read_stb(struct usbtmc_file_data *file_data,
 	}
 
 	if (data->iin_ep_present) {
-		rv = wait_event_interruptible_timeout(
+		wait_rv = wait_event_interruptible_timeout(
 			data->waitq,
 			atomic_read(&data->iin_data_valid) != 0,
 			file_data->timeout);
-		if (rv < 0) {
-			dev_dbg(dev, "wait interrupted %d\n", rv);
+		if (wait_rv < 0) {
+			dev_dbg(dev, "wait interrupted %ld\n", wait_rv);
+			rv = wait_rv;
 			goto exit;
 		}
 
-		if (rv == 0) {
+		if (wait_rv == 0) {
 			dev_dbg(dev, "wait timed out\n");
 			rv = -ETIMEDOUT;
 			goto exit;
@@ -556,6 +558,8 @@ static int usbtmc488_ioctl_read_stb(struct usbtmc_file_data *file_data,
 	rv = put_user(stb, (__u8 __user *)arg);
 	dev_dbg(dev, "stb:0x%02x received %d\n", (unsigned int)stb, rv);
 
+	rv = 0;
+
  exit:
 	/* bump interrupt bTag */
 	data->iin_bTag += 1;
@@ -572,9 +576,9 @@ static int usbtmc488_ioctl_wait_srq(struct usbtmc_file_data *file_data,
 {
 	struct usbtmc_device_data *data = file_data->data;
 	struct device *dev = &data->intf->dev;
-	int rv;
 	u32 timeout;
 	unsigned long expire;
+	long wait_rv;
 
 	if (!data->iin_ep_present) {
 		dev_dbg(dev, "no interrupt endpoint present\n");
@@ -588,25 +592,24 @@ static int usbtmc488_ioctl_wait_srq(struct usbtmc_file_data *file_data,
 
 	mutex_unlock(&data->io_mutex);
 
-	rv = wait_event_interruptible_timeout(
-			data->waitq,
-			atomic_read(&file_data->srq_asserted) != 0 ||
-			atomic_read(&file_data->closing),
-			expire);
+	wait_rv = wait_event_interruptible_timeout(
+		data->waitq,
+		atomic_read(&file_data->srq_asserted) != 0 ||
+		atomic_read(&file_data->closing),
+		expire);
 
 	mutex_lock(&data->io_mutex);
 
 	/* Note! disconnect or close could be called in the meantime */
 	if (atomic_read(&file_data->closing) || data->zombie)
-		rv = -ENODEV;
+		return -ENODEV;
 
-	if (rv < 0) {
-		/* dev can be invalid now! */
-		pr_debug("%s - wait interrupted %d\n", __func__, rv);
-		return rv;
+	if (wait_rv < 0) {
+		dev_dbg(dev, "%s - wait interrupted %ld\n", __func__, wait_rv);
+		return wait_rv;
 	}
 
-	if (rv == 0) {
+	if (wait_rv == 0) {
 		dev_dbg(dev, "%s - wait timed out\n", __func__);
 		return -ETIMEDOUT;
 	}
@@ -800,6 +803,7 @@ static ssize_t usbtmc_generic_read(struct usbtmc_file_data *file_data,
 	unsigned long expire;
 	int bufcount = 1;
 	int again = 0;
+	long wait_rv;
 
 	/* mutex already locked */
 
@@ -912,19 +916,24 @@ static ssize_t usbtmc_generic_read(struct usbtmc_file_data *file_data,
 		if (!(flags & USBTMC_FLAG_ASYNC)) {
 			dev_dbg(dev, "%s: before wait time %lu\n",
 				__func__, expire);
-			retval = wait_event_interruptible_timeout(
+			wait_rv = wait_event_interruptible_timeout(
 				file_data->wait_bulk_in,
 				usbtmc_do_transfer(file_data),
 				expire);
 
-			dev_dbg(dev, "%s: wait returned %d\n",
-				__func__, retval);
+			dev_dbg(dev, "%s: wait returned %ld\n",
+				__func__, wait_rv);
 
-			if (retval <= 0) {
-				if (retval == 0)
-					retval = -ETIMEDOUT;
+			if (wait_rv < 0) {
+				retval = wait_rv;
 				goto error;
 			}
+
+			if (wait_rv == 0) {
+				retval = -ETIMEDOUT;
+				goto error;
+			}
+
 		}
 
 		urb = usb_get_from_anchor(&file_data->in_anchor);
@@ -1350,7 +1359,10 @@ static ssize_t usbtmc_read(struct file *filp, char __user *buf,
 	if (!buffer)
 		return -ENOMEM;
 
-	mutex_lock(&data->io_mutex);
+	retval = mutex_lock_interruptible(&data->io_mutex);
+	if (retval < 0)
+		goto exit_nolock;
+
 	if (data->zombie) {
 		retval = -ENODEV;
 		goto exit;
@@ -1473,6 +1485,7 @@ static ssize_t usbtmc_read(struct file *filp, char __user *buf,
 
 exit:
 	mutex_unlock(&data->io_mutex);
+exit_nolock:
 	kfree(buffer);
 	return retval;
 }
diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
index be9e9db7cad1..c0834bac4c95 100644
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -122,7 +122,7 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
 	}
 
 	/* Get and enable clock if any specified */
-	uhci->clk = devm_clk_get(&pdev->dev, NULL);
+	uhci->clk = devm_clk_get_optional(&pdev->dev, NULL);
 	if (IS_ERR(uhci->clk)) {
 		ret = PTR_ERR(uhci->clk);
 		goto err_rmr;
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index c626a6acfad6..d60ed6735c34 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3787,7 +3787,7 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 	case SNK_TRY_WAIT_DEBOUNCE:
 		if (!tcpm_port_is_sink(port)) {
 			port->max_wait = 0;
-			tcpm_set_state(port, SRC_TRYWAIT, 0);
+			tcpm_set_state(port, SRC_TRYWAIT, PD_T_PD_DEBOUNCE);
 		}
 		break;
 	case SRC_TRY_WAIT:
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index f67c5a304155..79692b13a873 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -272,6 +272,8 @@ void ucsi_displayport_remove_partner(struct typec_altmode *alt)
 	if (!dp)
 		return;
 
+	cancel_work_sync(&dp->work);
+
 	dp->data.conf = 0;
 	dp->data.status = 0;
 	dp->initialized = false;
diff --git a/drivers/video/fbdev/core/tileblit.c b/drivers/video/fbdev/core/tileblit.c
index adff8d6ffe6f..64c60fcb92d7 100644
--- a/drivers/video/fbdev/core/tileblit.c
+++ b/drivers/video/fbdev/core/tileblit.c
@@ -77,7 +77,42 @@ static void tile_putcs(struct vc_data *vc, struct fb_info *info,
 static void tile_clear_margins(struct vc_data *vc, struct fb_info *info,
 			       int color, int bottom_only)
 {
-	return;
+	unsigned int cw = vc->vc_font.width;
+	unsigned int ch = vc->vc_font.height;
+	unsigned int rw = info->var.xres - (vc->vc_cols*cw);
+	unsigned int bh = info->var.yres - (vc->vc_rows*ch);
+	unsigned int rs = info->var.xres - rw;
+	unsigned int bs = info->var.yres - bh;
+	unsigned int vwt = info->var.xres_virtual / cw;
+	unsigned int vht = info->var.yres_virtual / ch;
+	struct fb_tilerect rect;
+
+	rect.index = vc->vc_video_erase_char &
+		((vc->vc_hi_font_mask) ? 0x1ff : 0xff);
+	rect.fg = color;
+	rect.bg = color;
+
+	if ((int) rw > 0 && !bottom_only) {
+		rect.sx = (info->var.xoffset + rs + cw - 1) / cw;
+		rect.sy = 0;
+		rect.width = (rw + cw - 1) / cw;
+		rect.height = vht;
+		if (rect.width + rect.sx > vwt)
+			rect.width = vwt - rect.sx;
+		if (rect.sx < vwt)
+			info->tileops->fb_tilefill(info, &rect);
+	}
+
+	if ((int) bh > 0) {
+		rect.sx = info->var.xoffset / cw;
+		rect.sy = (info->var.yoffset + bs) / ch;
+		rect.width = rs / cw;
+		rect.height = (bh + ch - 1) / ch;
+		if (rect.height + rect.sy > vht)
+			rect.height = vht - rect.sy;
+		if (rect.sy < vht)
+			info->tileops->fb_tilefill(info, &rect);
+	}
 }
 
 static void tile_cursor(struct vc_data *vc, struct fb_info *info, int mode,
diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index d4c2a6b3839e..3dc399704adc 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1828,6 +1828,7 @@ static int fsl_diu_remove(struct platform_device *pdev)
 	int i;
 
 	data = dev_get_drvdata(&pdev->dev);
+	device_remove_file(&pdev->dev, &data->dev_attr);
 	disable_lcdc(&data->fsl_diu_info[0]);
 
 	free_irq(data->irq, data->diu_reg);
diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index e1cb277a9e16..69bceab71c3f 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -26,6 +26,8 @@
 
 #define DRV_NAME    "xen-platform-pci"
 
+#define PCI_DEVICE_ID_XEN_PLATFORM_XS61	0x0002
+
 static unsigned long platform_mmio;
 static unsigned long platform_mmio_alloc;
 static unsigned long platform_mmiolen;
@@ -167,6 +169,8 @@ static int platform_pci_probe(struct pci_dev *pdev,
 static const struct pci_device_id platform_pci_tbl[] = {
 	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM_XS61,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0,}
 };
 
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 5bd29d0bffa2..382ee7dc3d5d 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -85,19 +85,21 @@ static inline dma_addr_t xen_virt_to_bus(void *address)
 	return xen_phys_to_bus(virt_to_phys(address));
 }
 
+static inline bool range_requires_alignment(phys_addr_t p, size_t size)
+{
+	phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
+	phys_addr_t bus_addr = pfn_to_bfn(XEN_PFN_DOWN(p)) << XEN_PAGE_SHIFT;
+
+	return IS_ALIGNED(p, algn) && !IS_ALIGNED(bus_addr, algn);
+}
+
 static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 {
 	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
 	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
-	phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
 
 	next_bfn = pfn_to_bfn(xen_pfn);
 
-	/* If buffer is physically aligned, ensure DMA alignment. */
-	if (IS_ALIGNED(p, algn) &&
-	    !IS_ALIGNED((phys_addr_t)next_bfn << XEN_PAGE_SHIFT, algn))
-		return 1;
-
 	for (i = 1; i < nr_pages; i++)
 		if (pfn_to_bfn(++xen_pfn) != ++next_bfn)
 			return 1;
@@ -320,7 +322,8 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 	phys = *dma_handle;
 	dev_addr = xen_phys_to_bus(phys);
 	if (((dev_addr + size - 1 <= dma_mask)) &&
-	    !range_straddles_page_boundary(phys, size))
+	    !range_straddles_page_boundary(phys, size) &&
+	    !range_requires_alignment(phys, size))
 		*dma_handle = dev_addr;
 	else {
 		if (xen_create_contiguous_region(phys, order,
@@ -360,6 +363,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 
 	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
 		     range_straddles_page_boundary(phys, size)) &&
+	    !range_requires_alignment(phys, size) &&
 	    TestClearPageXenRemapped(page))
 		xen_destroy_contiguous_region(phys, order);
 
diff --git a/drivers/xen/xenbus/xenbus.h b/drivers/xen/xenbus/xenbus.h
index 88516a8a9f93..39e8aee26378 100644
--- a/drivers/xen/xenbus/xenbus.h
+++ b/drivers/xen/xenbus/xenbus.h
@@ -77,6 +77,7 @@ enum xb_req_state {
 struct xb_req_data {
 	struct list_head list;
 	wait_queue_head_t wq;
+	struct kref kref;
 	struct xsd_sockmsg msg;
 	uint32_t caller_req_id;
 	enum xsd_sockmsg_type type;
@@ -103,6 +104,7 @@ int xb_init_comms(void);
 void xb_deinit_comms(void);
 int xs_watch_msg(struct xs_watch_event *event);
 void xs_request_exit(struct xb_req_data *req);
+void xs_free_req(struct kref *kref);
 
 int xenbus_match(struct device *_dev, struct device_driver *_drv);
 int xenbus_dev_probe(struct device *_dev);
diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
index e5fda0256feb..82df2da1b880 100644
--- a/drivers/xen/xenbus/xenbus_comms.c
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -309,8 +309,8 @@ static int process_msg(void)
 			virt_wmb();
 			req->state = xb_req_state_got_reply;
 			req->cb(req);
-		} else
-			kfree(req);
+		}
+		kref_put(&req->kref, xs_free_req);
 	}
 
 	mutex_unlock(&xs_response_mutex);
@@ -386,14 +386,13 @@ static int process_writes(void)
 	state.req->msg.type = XS_ERROR;
 	state.req->err = err;
 	list_del(&state.req->list);
-	if (state.req->state == xb_req_state_aborted)
-		kfree(state.req);
-	else {
+	if (state.req->state != xb_req_state_aborted) {
 		/* write err, then update state */
 		virt_wmb();
 		state.req->state = xb_req_state_got_reply;
 		wake_up(&state.req->wq);
 	}
+	kref_put(&state.req->kref, xs_free_req);
 
 	mutex_unlock(&xb_write_mutex);
 
diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index 0792fda49a15..c495cff3da30 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -406,7 +406,7 @@ void xenbus_dev_queue_reply(struct xb_req_data *req)
 	mutex_unlock(&u->reply_mutex);
 
 	kfree(req->body);
-	kfree(req);
+	kref_put(&req->kref, xs_free_req);
 
 	kref_put(&u->kref, xenbus_file_free);
 
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index fd686b962727..17705f82f85f 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -881,9 +881,15 @@ static int __init xenbus_init(void)
 	if (xen_pv_domain())
 		xen_store_domain_type = XS_PV;
 	if (xen_hvm_domain())
+	{
 		xen_store_domain_type = XS_HVM;
-	if (xen_hvm_domain() && xen_initial_domain())
-		xen_store_domain_type = XS_LOCAL;
+		err = hvm_get_parameter(HVM_PARAM_STORE_EVTCHN, &v);
+		if (err)
+			goto out_error;
+		xen_store_evtchn = (int)v;
+		if (!v && xen_initial_domain())
+			xen_store_domain_type = XS_LOCAL;
+	}
 	if (xen_pv_domain() && !xen_start_info->store_evtchn)
 		xen_store_domain_type = XS_LOCAL;
 	if (xen_pv_domain() && xen_start_info->store_evtchn)
@@ -902,10 +908,6 @@ static int __init xenbus_init(void)
 		xen_store_interface = gfn_to_virt(xen_store_gfn);
 		break;
 	case XS_HVM:
-		err = hvm_get_parameter(HVM_PARAM_STORE_EVTCHN, &v);
-		if (err)
-			goto out_error;
-		xen_store_evtchn = (int)v;
 		err = hvm_get_parameter(HVM_PARAM_STORE_PFN, &v);
 		if (err)
 			goto out_error;
diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index 12e02eb01f59..a4dd92719e7a 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -112,6 +112,12 @@ static void xs_suspend_exit(void)
 	wake_up_all(&xs_state_enter_wq);
 }
 
+void xs_free_req(struct kref *kref)
+{
+	struct xb_req_data *req = container_of(kref, struct xb_req_data, kref);
+	kfree(req);
+}
+
 static uint32_t xs_request_enter(struct xb_req_data *req)
 {
 	uint32_t rq_id;
@@ -237,6 +243,12 @@ static void xs_send(struct xb_req_data *req, struct xsd_sockmsg *msg)
 	req->caller_req_id = req->msg.req_id;
 	req->msg.req_id = xs_request_enter(req);
 
+	/*
+	 * Take 2nd ref.  One for this thread, and the second for the
+	 * xenbus_thread.
+	 */
+	kref_get(&req->kref);
+
 	mutex_lock(&xb_write_mutex);
 	list_add_tail(&req->list, &xb_write_list);
 	notify = list_is_singular(&xb_write_list);
@@ -261,8 +273,8 @@ static void *xs_wait_for_reply(struct xb_req_data *req, struct xsd_sockmsg *msg)
 	if (req->state == xb_req_state_queued ||
 	    req->state == xb_req_state_wait_reply)
 		req->state = xb_req_state_aborted;
-	else
-		kfree(req);
+
+	kref_put(&req->kref, xs_free_req);
 	mutex_unlock(&xb_write_mutex);
 
 	return ret;
@@ -291,6 +303,7 @@ int xenbus_dev_request_and_reply(struct xsd_sockmsg *msg, void *par)
 	req->cb = xenbus_dev_queue_reply;
 	req->par = par;
 	req->user_req = true;
+	kref_init(&req->kref);
 
 	xs_send(req, msg);
 
@@ -319,6 +332,7 @@ static void *xs_talkv(struct xenbus_transaction t,
 	req->num_vecs = num_vecs;
 	req->cb = xs_wake_up;
 	req->user_req = false;
+	kref_init(&req->kref);
 
 	msg.req_id = 0;
 	msg.tx_id = t.id;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 04788940afaf..64af1c7f95c2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5134,10 +5134,10 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 	return NULL;
 }
 
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 					u64 start)
 {
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	struct extent_buffer *eb, *exists = NULL;
 	int ret;
 
@@ -5173,8 +5173,11 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 free_eb:
 	btrfs_release_extent_buffer(eb);
 	return exists;
-}
+#else
+	/* Stub to avoid linker error when compiled with optimizations turned off. */
+	return NULL;
 #endif
+}
 
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start)
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e1063ef3dece..b0933d952593 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -397,10 +397,8 @@ static int fs_path_ensure_buf(struct fs_path *p, int len)
 	if (p->buf_len >= len)
 		return 0;
 
-	if (len > PATH_MAX) {
-		WARN_ON(1);
-		return -ENOMEM;
-	}
+	if (WARN_ON(len > PATH_MAX))
+		return -ENAMETOOLONG;
 
 	path_len = p->end - p->start;
 	old_buf_len = p->buf_len;
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 3925a7bfc74d..c3156f602b20 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -621,7 +621,10 @@ find_cifs_entry(const unsigned int xid, struct cifs_tcon *tcon, loff_t pos,
 			else
 				cifs_buf_release(cfile->srch_inf.
 						ntwrk_buf_start);
+			/* Reset all pointers to the network buffer to prevent stale references */
 			cfile->srch_inf.ntwrk_buf_start = NULL;
+			cfile->srch_inf.srch_entries_start = NULL;
+			cfile->srch_inf.last_entry = NULL;
 		}
 		rc = initiate_cifs_search(xid, file);
 		if (rc) {
@@ -644,11 +647,11 @@ find_cifs_entry(const unsigned int xid, struct cifs_tcon *tcon, loff_t pos,
 		rc = server->ops->query_dir_next(xid, tcon, &cfile->fid,
 						 search_flags,
 						 &cfile->srch_inf);
+		if (rc)
+			return -ENOENT;
 		/* FindFirst/Next set last_entry to NULL on malformed reply */
 		if (cfile->srch_inf.last_entry)
 			cifs_save_resume_key(cfile->srch_inf.last_entry, cfile);
-		if (rc)
-			return -ENOENT;
 	}
 	if (index_to_find < cfile->srch_inf.index_of_last_entry) {
 		/* we found the buffer that contains the entry */
diff --git a/fs/coredump.c b/fs/coredump.c
index f34767eedf38..615e3231a96b 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -52,6 +52,13 @@
 
 #include <trace/events/sched.h>
 
+/*
+ * File descriptor number for the pidfd for the thread-group leader of
+ * the coredumping task installed into the usermode helper's file
+ * descriptor table.
+ */
+#define COREDUMP_PIDFD_NUMBER 3
+
 int core_uses_pid;
 unsigned int core_pipe_limit;
 char core_pattern[CORENAME_MAX_SIZE] = "core";
@@ -314,6 +321,27 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 				err = cn_printf(cn, "%lu",
 					      rlimit(RLIMIT_CORE));
 				break;
+			/* pidfd number */
+			case 'F': {
+				/*
+				 * Installing a pidfd only makes sense if
+				 * we actually spawn a usermode helper.
+				 */
+				if (!ispipe)
+					break;
+
+				/*
+				 * Note that we'll install a pidfd for the
+				 * thread-group leader. We know that task
+				 * linkage hasn't been removed yet and even if
+				 * this @current isn't the actual thread-group
+				 * leader we know that the thread-group leader
+				 * cannot be reaped until @current has exited.
+				 */
+				cprm->pid = task_tgid(current);
+				err = cn_printf(cn, "%d", COREDUMP_PIDFD_NUMBER);
+				break;
+			}
 			default:
 				break;
 			}
@@ -537,7 +565,7 @@ static void wait_for_dump_helpers(struct file *file)
 }
 
 /*
- * umh_pipe_setup
+ * umh_coredump_setup
  * helper function to customize the process used
  * to collect the core in userspace.  Specifically
  * it sets up a pipe and installs it as fd 0 (stdin)
@@ -547,21 +575,61 @@ static void wait_for_dump_helpers(struct file *file)
  * is a special value that we use to trap recursive
  * core dumps
  */
-static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
+static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 {
 	struct file *files[2];
+	struct file *pidfs_file = NULL;
 	struct coredump_params *cp = (struct coredump_params *)info->data;
-	int err = create_pipe_files(files, 0);
+	int err;
+
+	if (cp->pid) {
+		int fd;
+
+		fd = pidfd_prepare(cp->pid, 0, &pidfs_file);
+		if (fd < 0)
+			return fd;
+
+		/*
+		 * We don't care about the fd. We also cannot simply
+		 * replace it below because dup2() will refuse to close
+		 * this file descriptor if its in a larval state. So
+		 * close it!
+		 */
+		put_unused_fd(fd);
+
+		/*
+		 * Usermode helpers are childen of either
+		 * system_unbound_wq or of kthreadd. So we know that
+		 * we're starting off with a clean file descriptor
+		 * table. So we should always be able to use
+		 * COREDUMP_PIDFD_NUMBER as our file descriptor value.
+		 */
+		err = replace_fd(COREDUMP_PIDFD_NUMBER, pidfs_file, 0);
+		if (err < 0)
+			goto out_fail;
+
+		pidfs_file = NULL;
+	}
+
+	err = create_pipe_files(files, 0);
 	if (err)
-		return err;
+		goto out_fail;
 
 	cp->file = files[1];
 
 	err = replace_fd(0, files[0], 0);
 	fput(files[0]);
+	if (err < 0)
+		goto out_fail;
+
 	/* and disallow core files too */
 	current->signal->rlim[RLIMIT_CORE] = (struct rlimit){1, 1};
 
+	err = 0;
+
+out_fail:
+	if (pidfs_file)
+		fput(pidfs_file);
 	return err;
 }
 
@@ -638,7 +706,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 
 		if (cprm.limit == 1) {
-			/* See umh_pipe_setup() which sets RLIMIT_CORE = 1.
+			/* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
 			 *
 			 * Normally core limits are irrelevant to pipes, since
 			 * we're not writing to the file system, but we use
@@ -683,7 +751,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		retval = -ENOMEM;
 		sub_info = call_usermodehelper_setup(helper_argv[0],
 						helper_argv, NULL, GFP_KERNEL,
-						umh_pipe_setup, NULL, &cprm);
+						umh_coredump_setup, NULL, &cprm);
 		if (sub_info)
 			retval = call_usermodehelper_exec(sub_info,
 							  UMH_WAIT_EXEC);
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index b68cee75f5c5..a32eb67a8f0e 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -609,8 +609,8 @@ static int ext4_has_free_clusters(struct ext4_sb_info *sbi,
 	/* Hm, nope.  Are (enough) root reserved clusters available? */
 	if (uid_eq(sbi->s_resuid, current_fsuid()) ||
 	    (!gid_eq(sbi->s_resgid, GLOBAL_ROOT_GID) && in_group_p(sbi->s_resgid)) ||
-	    capable(CAP_SYS_RESOURCE) ||
-	    (flags & EXT4_MB_USE_ROOT_BLOCKS)) {
+	    (flags & EXT4_MB_USE_ROOT_BLOCKS) ||
+	    capable(CAP_SYS_RESOURCE)) {
 
 		if (free_clusters >= (nclusters + dirty_clusters +
 				      resv_clusters))
diff --git a/fs/namespace.c b/fs/namespace.c
index 281f08eaba5b..a5cb608778b1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -569,15 +569,11 @@ int __legitimize_mnt(struct vfsmount *bastard, unsigned seq)
 		return 0;
 	mnt = real_mount(bastard);
 	mnt_add_count(mnt, 1);
-	smp_mb();			// see mntput_no_expire()
+	smp_mb();		// see mntput_no_expire() and do_umount()
 	if (likely(!read_seqretry(&mount_lock, seq)))
 		return 0;
-	if (bastard->mnt_flags & MNT_SYNC_UMOUNT) {
-		mnt_add_count(mnt, -1);
-		return 1;
-	}
 	lock_mount_hash();
-	if (unlikely(bastard->mnt_flags & MNT_DOOMED)) {
+	if (unlikely(bastard->mnt_flags & (MNT_SYNC_UMOUNT | MNT_DOOMED))) {
 		mnt_add_count(mnt, -1);
 		unlock_mount_hash();
 		return 1;
@@ -1588,6 +1584,7 @@ static int do_umount(struct mount *mnt, int flags)
 			umount_tree(mnt, UMOUNT_PROPAGATE);
 		retval = 0;
 	} else {
+		smp_mb(); // paired with __legitimize_mnt()
 		shrink_submounts(mnt);
 		retval = -EBUSY;
 		if (!propagate_mount_busy(mnt, 2)) {
diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 31922657e836..1397e0816ba0 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -284,7 +284,7 @@ static u32 initiate_file_draining(struct nfs_client *clp,
 		goto unlock;
 	}
 
-	pnfs_set_layout_stateid(lo, &args->cbl_stateid, true);
+	pnfs_set_layout_stateid(lo, &args->cbl_stateid, NULL, true);
 	switch (pnfs_mark_matching_lsegs_return(lo, &free_me_list,
 				&args->cbl_range,
 				be32_to_cpu(args->cbl_stateid.seqid))) {
diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index d913e818858f..82bba1ede717 100644
--- a/fs/nfs/filelayout/filelayoutdev.c
+++ b/fs/nfs/filelayout/filelayoutdev.c
@@ -75,6 +75,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	struct page *scratch;
 	struct list_head dsaddrs;
 	struct nfs4_pnfs_ds_addr *da;
+	struct net *net = server->nfs_client->cl_net;
 
 	/* set up xdr stream */
 	scratch = alloc_page(gfp_flags);
@@ -160,8 +161,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 
 		mp_count = be32_to_cpup(p); /* multipath count */
 		for (j = 0; j < mp_count; j++) {
-			da = nfs4_decode_mp_ds_addr(server->nfs_client->cl_net,
-						    &stream, gfp_flags);
+			da = nfs4_decode_mp_ds_addr(net, &stream, gfp_flags);
 			if (da)
 				list_add_tail(&da->da_node, &dsaddrs);
 		}
@@ -171,7 +171,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 			goto out_err_free_deviceid;
 		}
 
-		dsaddr->ds_list[i] = nfs4_pnfs_ds_add(&dsaddrs, gfp_flags);
+		dsaddr->ds_list[i] = nfs4_pnfs_ds_add(net, &dsaddrs, gfp_flags);
 		if (!dsaddr->ds_list[i])
 			goto out_err_drain_dsaddrs;
 
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 1b88b78f40be..3b4f93dcf323 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1285,6 +1285,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -ECONNRESET:
 		case -EHOSTDOWN:
 		case -EHOSTUNREACH:
+		case -ENETDOWN:
 		case -ENETUNREACH:
 		case -EADDRINUSE:
 		case -ENOBUFS:
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index 1f12297109b4..e6d7473e1a32 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -49,6 +49,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	struct nfs4_pnfs_ds_addr *da;
 	struct nfs4_ff_layout_ds *new_ds = NULL;
 	struct nfs4_ff_ds_version *ds_versions = NULL;
+	struct net *net = server->nfs_client->cl_net;
 	u32 mp_count;
 	u32 version_count;
 	__be32 *p;
@@ -80,8 +81,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 
 	for (i = 0; i < mp_count; i++) {
 		/* multipath ds */
-		da = nfs4_decode_mp_ds_addr(server->nfs_client->cl_net,
-					    &stream, gfp_flags);
+		da = nfs4_decode_mp_ds_addr(net, &stream, gfp_flags);
 		if (da)
 			list_add_tail(&da->da_node, &dsaddrs);
 	}
@@ -147,7 +147,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	new_ds->ds_versions = ds_versions;
 	new_ds->ds_versions_cnt = version_count;
 
-	new_ds->ds = nfs4_pnfs_ds_add(&dsaddrs, gfp_flags);
+	new_ds->ds = nfs4_pnfs_ds_add(net, &dsaddrs, gfp_flags);
 	if (!new_ds->ds)
 		goto out_err_drain_dsaddrs;
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 632cea3fb91d..3477da3c2190 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6573,10 +6573,18 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
 	struct nfs4_unlockdata *p;
 	struct nfs4_state *state = lsp->ls_state;
 	struct inode *inode = state->inode;
+	struct nfs_lock_context *l_ctx;
 
 	p = kzalloc(sizeof(*p), GFP_NOFS);
 	if (p == NULL)
 		return NULL;
+	l_ctx = nfs_get_lock_context(ctx);
+	if (!IS_ERR(l_ctx)) {
+		p->l_ctx = l_ctx;
+	} else {
+		kfree(p);
+		return NULL;
+	}
 	p->arg.fh = NFS_FH(inode);
 	p->arg.fl = &p->fl;
 	p->arg.seqid = seqid;
@@ -6584,7 +6592,6 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
 	p->lsp = lsp;
 	/* Ensure we don't close file until we're done freeing locks! */
 	p->ctx = get_nfs_open_context(ctx);
-	p->l_ctx = nfs_get_lock_context(ctx);
 	locks_init_lock(&p->fl);
 	locks_copy_lock(&p->fl, fl);
 	p->server = NFS_SERVER(inode);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 1d38484e0a53..b64a3751c3e4 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2655,7 +2655,15 @@ static void nfs4_state_manager(struct nfs_client *clp)
 	pr_warn_ratelimited("NFS: state manager%s%s failed on NFSv4 server %s"
 			" with error %d\n", section_sep, section,
 			clp->cl_hostname, -status);
-	ssleep(1);
+	switch (status) {
+	case -ENETDOWN:
+	case -ENETUNREACH:
+		nfs_mark_client_ready(clp, -EIO);
+		break;
+	default:
+		ssleep(1);
+		break;
+	}
 out_drain:
 	memalloc_nofs_restore(memflags);
 	nfs4_end_drain_session(clp);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 90961dae4dc3..d91576a587e4 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -710,6 +710,14 @@ pnfs_mark_matching_lsegs_invalid(struct pnfs_layout_hdr *lo,
 	return remaining;
 }
 
+static void pnfs_reset_return_info(struct pnfs_layout_hdr *lo)
+{
+	struct pnfs_layout_segment *lseg;
+
+	list_for_each_entry(lseg, &lo->plh_return_segs, pls_list)
+		pnfs_set_plh_return_info(lo, lseg->pls_range.iomode, 0);
+}
+
 static void
 pnfs_free_returned_lsegs(struct pnfs_layout_hdr *lo,
 		struct list_head *free_me,
@@ -943,10 +951,21 @@ pnfs_destroy_all_layouts(struct nfs_client *clp)
 	pnfs_destroy_layouts_byclid(clp, false);
 }
 
+static void
+pnfs_set_layout_cred(struct pnfs_layout_hdr *lo, const struct cred *cred)
+{
+	const struct cred *old;
+
+	if (cred && cred_fscmp(lo->plh_lc_cred, cred) != 0) {
+		old = xchg(&lo->plh_lc_cred, get_cred(cred));
+		put_cred(old);
+	}
+}
+
 /* update lo->plh_stateid with new if is more recent */
 void
 pnfs_set_layout_stateid(struct pnfs_layout_hdr *lo, const nfs4_stateid *new,
-			bool update_barrier)
+			const struct cred *cred, bool update_barrier)
 {
 	u32 oldseq, newseq, new_barrier = 0;
 
@@ -954,6 +973,7 @@ pnfs_set_layout_stateid(struct pnfs_layout_hdr *lo, const nfs4_stateid *new,
 	newseq = be32_to_cpu(new->seqid);
 
 	if (!pnfs_layout_is_valid(lo)) {
+		pnfs_set_layout_cred(lo, cred);
 		nfs4_stateid_copy(&lo->plh_stateid, new);
 		lo->plh_barrier = newseq;
 		pnfs_clear_layoutreturn_info(lo);
@@ -1149,7 +1169,8 @@ void pnfs_layoutreturn_free_lsegs(struct pnfs_layout_hdr *lo,
 
 		pnfs_mark_matching_lsegs_invalid(lo, &freeme, range, seq);
 		pnfs_free_returned_lsegs(lo, &freeme, range, seq);
-		pnfs_set_layout_stateid(lo, stateid, true);
+		pnfs_set_layout_stateid(lo, stateid, NULL, true);
+		pnfs_reset_return_info(lo);
 	} else
 		pnfs_mark_layout_stateid_invalid(lo, &freeme);
 out_unlock:
@@ -2382,14 +2403,14 @@ pnfs_layout_process(struct nfs4_layoutget *lgp)
 
 	if (!pnfs_layout_is_valid(lo)) {
 		/* We have a completely new layout */
-		pnfs_set_layout_stateid(lo, &res->stateid, true);
+		pnfs_set_layout_stateid(lo, &res->stateid, lgp->cred, true);
 	} else if (nfs4_stateid_match_other(&lo->plh_stateid, &res->stateid)) {
 		/* existing state ID, make sure the sequence number matches. */
 		if (pnfs_layout_stateid_blocked(lo, &res->stateid)) {
 			dprintk("%s forget reply due to sequence\n", __func__);
 			goto out_forget;
 		}
-		pnfs_set_layout_stateid(lo, &res->stateid, false);
+		pnfs_set_layout_stateid(lo, &res->stateid, lgp->cred, false);
 	} else {
 		/*
 		 * We got an entirely new state ID.  Mark all segments for the
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 68339680bb7d..7976886a47db 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -57,6 +57,7 @@ struct nfs4_pnfs_ds {
 	struct list_head	ds_node;  /* nfs4_pnfs_dev_hlist dev_dslist */
 	char			*ds_remotestr;	/* comma sep list of addrs */
 	struct list_head	ds_addrs;
+	const struct net	*ds_net;
 	struct nfs_client	*ds_clp;
 	refcount_t		ds_count;
 	unsigned long		ds_state;
@@ -270,6 +271,7 @@ bool nfs4_layout_refresh_old_stateid(nfs4_stateid *dst,
 void pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo);
 void pnfs_set_layout_stateid(struct pnfs_layout_hdr *lo,
 			     const nfs4_stateid *new,
+			     const struct cred *cred,
 			     bool update_barrier);
 int pnfs_mark_matching_lsegs_invalid(struct pnfs_layout_hdr *lo,
 				struct list_head *tmp_list,
@@ -377,7 +379,8 @@ int pnfs_generic_commit_pagelist(struct inode *inode,
 int pnfs_generic_scan_commit_lists(struct nfs_commit_info *cinfo, int max);
 void pnfs_generic_write_commit_done(struct rpc_task *task, void *data);
 void nfs4_pnfs_ds_put(struct nfs4_pnfs_ds *ds);
-struct nfs4_pnfs_ds *nfs4_pnfs_ds_add(struct list_head *dsaddrs,
+struct nfs4_pnfs_ds *nfs4_pnfs_ds_add(const struct net *net,
+				      struct list_head *dsaddrs,
 				      gfp_t gfp_flags);
 void nfs4_pnfs_v3_ds_connect_unload(void);
 int nfs4_pnfs_ds_connect(struct nfs_server *mds_srv, struct nfs4_pnfs_ds *ds,
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index aff44a7b98f8..e2d90239d042 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -414,12 +414,12 @@ _same_data_server_addrs_locked(const struct list_head *dsaddrs1,
  * Lookup DS by addresses.  nfs4_ds_cache_lock is held
  */
 static struct nfs4_pnfs_ds *
-_data_server_lookup_locked(const struct list_head *dsaddrs)
+_data_server_lookup_locked(const struct net *net, const struct list_head *dsaddrs)
 {
 	struct nfs4_pnfs_ds *ds;
 
 	list_for_each_entry(ds, &nfs4_data_server_cache, ds_node)
-		if (_same_data_server_addrs_locked(&ds->ds_addrs, dsaddrs))
+		if (ds->ds_net == net && _same_data_server_addrs_locked(&ds->ds_addrs, dsaddrs))
 			return ds;
 	return NULL;
 }
@@ -512,7 +512,7 @@ nfs4_pnfs_remotestr(struct list_head *dsaddrs, gfp_t gfp_flags)
  * uncached and return cached struct nfs4_pnfs_ds.
  */
 struct nfs4_pnfs_ds *
-nfs4_pnfs_ds_add(struct list_head *dsaddrs, gfp_t gfp_flags)
+nfs4_pnfs_ds_add(const struct net *net, struct list_head *dsaddrs, gfp_t gfp_flags)
 {
 	struct nfs4_pnfs_ds *tmp_ds, *ds = NULL;
 	char *remotestr;
@@ -530,13 +530,14 @@ nfs4_pnfs_ds_add(struct list_head *dsaddrs, gfp_t gfp_flags)
 	remotestr = nfs4_pnfs_remotestr(dsaddrs, gfp_flags);
 
 	spin_lock(&nfs4_ds_cache_lock);
-	tmp_ds = _data_server_lookup_locked(dsaddrs);
+	tmp_ds = _data_server_lookup_locked(net, dsaddrs);
 	if (tmp_ds == NULL) {
 		INIT_LIST_HEAD(&ds->ds_addrs);
 		list_splice_init(dsaddrs, &ds->ds_addrs);
 		ds->ds_remotestr = remotestr;
 		refcount_set(&ds->ds_count, 1);
 		INIT_LIST_HEAD(&ds->ds_node);
+		ds->ds_net = net;
 		ds->ds_clp = NULL;
 		list_add(&ds->ds_node, &nfs4_data_server_cache);
 		dprintk("%s add new data server %s\n", __func__,
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 69490c613076..fa3da4b23d67 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -175,7 +175,7 @@ int ocfs2_recovery_init(struct ocfs2_super *osb)
 	struct ocfs2_recovery_map *rm;
 
 	mutex_init(&osb->recovery_lock);
-	osb->disable_recovery = 0;
+	osb->recovery_state = OCFS2_REC_ENABLED;
 	osb->recovery_thread_task = NULL;
 	init_waitqueue_head(&osb->recovery_event);
 
@@ -194,31 +194,53 @@ int ocfs2_recovery_init(struct ocfs2_super *osb)
 	return 0;
 }
 
-/* we can't grab the goofy sem lock from inside wait_event, so we use
- * memory barriers to make sure that we'll see the null task before
- * being woken up */
 static int ocfs2_recovery_thread_running(struct ocfs2_super *osb)
 {
-	mb();
 	return osb->recovery_thread_task != NULL;
 }
 
-void ocfs2_recovery_exit(struct ocfs2_super *osb)
+static void ocfs2_recovery_disable(struct ocfs2_super *osb,
+				   enum ocfs2_recovery_state state)
 {
-	struct ocfs2_recovery_map *rm;
-
-	/* disable any new recovery threads and wait for any currently
-	 * running ones to exit. Do this before setting the vol_state. */
 	mutex_lock(&osb->recovery_lock);
-	osb->disable_recovery = 1;
+	/*
+	 * If recovery thread is not running, we can directly transition to
+	 * final state.
+	 */
+	if (!ocfs2_recovery_thread_running(osb)) {
+		osb->recovery_state = state + 1;
+		goto out_lock;
+	}
+	osb->recovery_state = state;
+	/* Wait for recovery thread to acknowledge state transition */
+	wait_event_cmd(osb->recovery_event,
+		       !ocfs2_recovery_thread_running(osb) ||
+				osb->recovery_state >= state + 1,
+		       mutex_unlock(&osb->recovery_lock),
+		       mutex_lock(&osb->recovery_lock));
+out_lock:
 	mutex_unlock(&osb->recovery_lock);
-	wait_event(osb->recovery_event, !ocfs2_recovery_thread_running(osb));
 
-	/* At this point, we know that no more recovery threads can be
-	 * launched, so wait for any recovery completion work to
-	 * complete. */
+	/*
+	 * At this point we know that no more recovery work can be queued so
+	 * wait for any recovery completion work to complete.
+	 */
 	if (osb->ocfs2_wq)
 		flush_workqueue(osb->ocfs2_wq);
+}
+
+void ocfs2_recovery_disable_quota(struct ocfs2_super *osb)
+{
+	ocfs2_recovery_disable(osb, OCFS2_REC_QUOTA_WANT_DISABLE);
+}
+
+void ocfs2_recovery_exit(struct ocfs2_super *osb)
+{
+	struct ocfs2_recovery_map *rm;
+
+	/* disable any new recovery threads and wait for any currently
+	 * running ones to exit. Do this before setting the vol_state. */
+	ocfs2_recovery_disable(osb, OCFS2_REC_WANT_DISABLE);
 
 	/*
 	 * Now that recovery is shut down, and the osb is about to be
@@ -1391,6 +1413,18 @@ static int __ocfs2_recovery_thread(void *arg)
 		}
 	}
 restart:
+	if (quota_enabled) {
+		mutex_lock(&osb->recovery_lock);
+		/* Confirm that recovery thread will no longer recover quotas */
+		if (osb->recovery_state == OCFS2_REC_QUOTA_WANT_DISABLE) {
+			osb->recovery_state = OCFS2_REC_QUOTA_DISABLED;
+			wake_up(&osb->recovery_event);
+		}
+		if (osb->recovery_state >= OCFS2_REC_QUOTA_DISABLED)
+			quota_enabled = 0;
+		mutex_unlock(&osb->recovery_lock);
+	}
+
 	status = ocfs2_super_lock(osb, 1);
 	if (status < 0) {
 		mlog_errno(status);
@@ -1488,13 +1522,13 @@ static int __ocfs2_recovery_thread(void *arg)
 
 	ocfs2_free_replay_slots(osb);
 	osb->recovery_thread_task = NULL;
-	mb(); /* sync with ocfs2_recovery_thread_running */
+	if (osb->recovery_state == OCFS2_REC_WANT_DISABLE)
+		osb->recovery_state = OCFS2_REC_DISABLED;
 	wake_up(&osb->recovery_event);
 
 	mutex_unlock(&osb->recovery_lock);
 
-	if (quota_enabled)
-		kfree(rm_quota);
+	kfree(rm_quota);
 
 	/* no one is callint kthread_stop() for us so the kthread() api
 	 * requires that we call do_exit().  And it isn't exported, but
@@ -1504,14 +1538,16 @@ static int __ocfs2_recovery_thread(void *arg)
 
 void ocfs2_recovery_thread(struct ocfs2_super *osb, int node_num)
 {
+	int was_set = -1;
+
 	mutex_lock(&osb->recovery_lock);
+	if (osb->recovery_state < OCFS2_REC_WANT_DISABLE)
+		was_set = ocfs2_recovery_map_set(osb, node_num);
 
 	trace_ocfs2_recovery_thread(node_num, osb->node_num,
-		osb->disable_recovery, osb->recovery_thread_task,
-		osb->disable_recovery ?
-		-1 : ocfs2_recovery_map_set(osb, node_num));
+		osb->recovery_state, osb->recovery_thread_task, was_set);
 
-	if (osb->disable_recovery)
+	if (osb->recovery_state >= OCFS2_REC_WANT_DISABLE)
 		goto out;
 
 	if (osb->recovery_thread_task)
diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
index eb7a21bac71e..b6f1a628b7c0 100644
--- a/fs/ocfs2/journal.h
+++ b/fs/ocfs2/journal.h
@@ -150,6 +150,7 @@ void ocfs2_wait_for_recovery(struct ocfs2_super *osb);
 
 int ocfs2_recovery_init(struct ocfs2_super *osb);
 void ocfs2_recovery_exit(struct ocfs2_super *osb);
+void ocfs2_recovery_disable_quota(struct ocfs2_super *osb);
 
 int ocfs2_compute_replay_slots(struct ocfs2_super *osb);
 void ocfs2_free_replay_slots(struct ocfs2_super *osb);
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index 0a8cd8e59a92..5cea6942c1bd 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -286,6 +286,21 @@ enum ocfs2_mount_options
 #define OCFS2_OSB_ERROR_FS	0x0004
 #define OCFS2_DEFAULT_ATIME_QUANTUM	60
 
+enum ocfs2_recovery_state {
+	OCFS2_REC_ENABLED = 0,
+	OCFS2_REC_QUOTA_WANT_DISABLE,
+	/*
+	 * Must be OCFS2_REC_QUOTA_WANT_DISABLE + 1 for
+	 * ocfs2_recovery_disable_quota() to work.
+	 */
+	OCFS2_REC_QUOTA_DISABLED,
+	OCFS2_REC_WANT_DISABLE,
+	/*
+	 * Must be OCFS2_REC_WANT_DISABLE + 1 for ocfs2_recovery_exit() to work
+	 */
+	OCFS2_REC_DISABLED,
+};
+
 struct ocfs2_journal;
 struct ocfs2_slot_info;
 struct ocfs2_recovery_map;
@@ -348,7 +363,7 @@ struct ocfs2_super
 	struct ocfs2_recovery_map *recovery_map;
 	struct ocfs2_replay_map *replay_map;
 	struct task_struct *recovery_thread_task;
-	int disable_recovery;
+	enum ocfs2_recovery_state recovery_state;
 	wait_queue_head_t checkpoint_event;
 	struct ocfs2_journal *journal;
 	unsigned long osb_commit_interval;
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 77d5aa90338f..1baa68c01c67 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -453,8 +453,7 @@ struct ocfs2_quota_recovery *ocfs2_begin_quota_recovery(
 
 /* Sync changes in local quota file into global quota file and
  * reinitialize local quota file.
- * The function expects local quota file to be already locked and
- * s_umount locked in shared mode. */
+ * The function expects local quota file to be already locked. */
 static int ocfs2_recover_local_quota_file(struct inode *lqinode,
 					  int type,
 					  struct ocfs2_quota_recovery *rec)
@@ -585,7 +584,6 @@ int ocfs2_finish_quota_recovery(struct ocfs2_super *osb,
 {
 	unsigned int ino[OCFS2_MAXQUOTAS] = { LOCAL_USER_QUOTA_SYSTEM_INODE,
 					      LOCAL_GROUP_QUOTA_SYSTEM_INODE };
-	struct super_block *sb = osb->sb;
 	struct ocfs2_local_disk_dqinfo *ldinfo;
 	struct buffer_head *bh;
 	handle_t *handle;
@@ -597,7 +595,6 @@ int ocfs2_finish_quota_recovery(struct ocfs2_super *osb,
 	printk(KERN_NOTICE "ocfs2: Finishing quota recovery on device (%s) for "
 	       "slot %u\n", osb->dev_str, slot_num);
 
-	down_read(&sb->s_umount);
 	for (type = 0; type < OCFS2_MAXQUOTAS; type++) {
 		if (list_empty(&(rec->r_list[type])))
 			continue;
@@ -674,7 +671,6 @@ int ocfs2_finish_quota_recovery(struct ocfs2_super *osb,
 			break;
 	}
 out:
-	up_read(&sb->s_umount);
 	kfree(rec);
 	return status;
 }
@@ -840,8 +836,7 @@ static int ocfs2_local_free_info(struct super_block *sb, int type)
 	ocfs2_release_local_quota_bitmaps(&oinfo->dqi_chunk);
 
 	/*
-	 * s_umount held in exclusive mode protects us against racing with
-	 * recovery thread...
+	 * ocfs2_dismount_volume() has already aborted quota recovery...
 	 */
 	if (oinfo->dqi_rec) {
 		ocfs2_free_quota_recovery(oinfo->dqi_rec);
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 6ce2c9fbb9db..0768746381ae 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1876,6 +1876,9 @@ static void ocfs2_dismount_volume(struct super_block *sb, int mnt_err)
 	/* Orphan scan should be stopped as early as possible */
 	ocfs2_orphan_scan_stop(osb);
 
+	/* Stop quota recovery so that we can disable quotas */
+	ocfs2_recovery_disable_quota(osb);
+
 	ocfs2_disable_quotas(osb);
 
 	/* All dquots should be freed by now */
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 636892ffec0b..238773a508ba 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -22,9 +22,9 @@ static int orangefs_writepage_locked(struct page *page,
 	struct orangefs_write_range *wr = NULL;
 	struct iov_iter iter;
 	struct bio_vec bv;
-	size_t len, wlen;
+	size_t wlen;
 	ssize_t ret;
-	loff_t off;
+	loff_t len, off;
 
 	set_page_writeback(page);
 
@@ -98,8 +98,7 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 	struct orangefs_write_range *wrp, wr;
 	struct iov_iter iter;
 	ssize_t ret;
-	size_t len;
-	loff_t off;
+	loff_t len, off;
 	int i;
 
 	len = i_size_read(inode);
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 927e1205d7aa..202975db784c 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -323,8 +323,27 @@ struct drm_atomic_state {
 	 *
 	 * Allow full modeset. This is used by the ATOMIC IOCTL handler to
 	 * implement the DRM_MODE_ATOMIC_ALLOW_MODESET flag. Drivers should
-	 * never consult this flag, instead looking at the output of
-	 * drm_atomic_crtc_needs_modeset().
+	 * generally not consult this flag, but instead look at the output of
+	 * drm_atomic_crtc_needs_modeset(). The detailed rules are:
+	 *
+	 * - Drivers must not consult @allow_modeset in the atomic commit path.
+	 *   Use drm_atomic_crtc_needs_modeset() instead.
+	 *
+	 * - Drivers must consult @allow_modeset before adding unrelated struct
+	 *   drm_crtc_state to this commit by calling
+	 *   drm_atomic_get_crtc_state(). See also the warning in the
+	 *   documentation for that function.
+	 *
+	 * - Drivers must never change this flag, it is under the exclusive
+	 *   control of userspace.
+	 *
+	 * - Drivers may consult @allow_modeset in the atomic check path, if
+	 *   they have the choice between an optimal hardware configuration
+	 *   which requires a modeset, and a less optimal configuration which
+	 *   can be committed without a modeset. An example would be suboptimal
+	 *   scanout FIFO allocation resulting in increased idle power
+	 *   consumption. This allows userspace to avoid flickering and delays
+	 *   for the normal composition loop at reasonable cost.
 	 */
 	bool allow_modeset : 1;
 	bool legacy_cursor_update : 1;
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index a345d9fed3d8..9be00e48b3c3 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -93,6 +93,7 @@ struct coredump_params {
 	unsigned long mm_flags;
 	loff_t written;
 	loff_t pos;
+	struct pid *pid;
 };
 
 /*
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 87cbae4b051f..ead09620e213 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -895,10 +895,14 @@ static inline int dma_mmap_wc(struct device *dev,
 #else
 #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
 #define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
-#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
-#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
-#define dma_unmap_len(PTR, LEN_NAME)             (0)
-#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
+#define dma_unmap_addr(PTR, ADDR_NAME)           \
+	({ typeof(PTR) __p __maybe_unused = PTR; 0; })
+#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  \
+	do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
+#define dma_unmap_len(PTR, LEN_NAME)             \
+	({ typeof(PTR) __p __maybe_unused = PTR; 0; })
+#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    \
+	do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
 #endif
 
 #endif
diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index 35b4e324e17f..7c399831540d 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -1128,7 +1128,7 @@ int mlx4_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
 int mlx4_buf_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
 		       struct mlx4_buf *buf);
 
-int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order);
+int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned int order);
 void mlx4_db_free(struct mlx4_dev *dev, struct mlx4_db *db);
 
 int mlx4_alloc_hwq_res(struct mlx4_dev *dev, struct mlx4_hwq_resources *wqres,
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 9645b1194c98..5216973610fd 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -75,6 +75,7 @@ extern const struct file_operations pidfd_fops;
 struct file;
 
 extern struct pid *pidfd_pid(const struct file *file);
+int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
@@ -85,6 +86,10 @@ static inline struct pid *get_pid(struct pid *pid)
 
 extern void put_pid(struct pid *pid);
 extern struct task_struct *pid_task(struct pid *pid, enum pid_type);
+static inline bool pid_has_task(struct pid *pid, enum pid_type type)
+{
+	return !hlist_empty(&pid->tasks[type]);
+}
 extern struct task_struct *get_pid_task(struct pid *pid, enum pid_type);
 
 extern struct pid *get_task_pid(struct task_struct *task, enum pid_type type);
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 18b1ed9864b0..5d39875c6594 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -53,7 +53,7 @@ void rcu_scheduler_starting(void);
 extern int rcu_scheduler_active __read_mostly;
 void rcu_end_inkernel_boot(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
diff --git a/include/linux/types.h b/include/linux/types.h
index 05030f608be3..71e55c06c963 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -114,8 +114,9 @@ typedef u64			u_int64_t;
 typedef s64			int64_t;
 #endif
 
-/* this is a special 64bit data type that is 8-byte aligned */
+/* These are the special 64-bit data types that are 8-byte aligned */
 #define aligned_u64		__aligned_u64
+#define aligned_s64		__aligned_s64
 #define aligned_be64		__aligned_be64
 #define aligned_le64		__aligned_le64
 
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 299e35458863..b887ffee0153 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1319,6 +1319,8 @@ int snd_pcm_lib_mmap_iomem(struct snd_pcm_substream *substream, struct vm_area_s
 #define snd_pcm_lib_mmap_iomem	NULL
 #endif
 
+void snd_pcm_runtime_buffer_set_silence(struct snd_pcm_runtime *runtime);
+
 /**
  * snd_pcm_limit_isa_dma_size - Get the max size fitting with ISA DMA transfer
  * @dma: DMA number
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 94a3adb65b8a..fe4d7e165050 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1773,7 +1773,7 @@ DECLARE_EVENT_CLASS(btrfs__prelim_ref,
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
 		 const struct prelim_ref *oldref,
 		 const struct prelim_ref *newref, u64 tree_size),
-	TP_ARGS(fs_info, newref, oldref, tree_size),
+	TP_ARGS(fs_info, oldref, newref, tree_size),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,  root_id		)
diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
index 2fce8b6876e9..cf5f4617ba5a 100644
--- a/include/uapi/linux/types.h
+++ b/include/uapi/linux/types.h
@@ -46,6 +46,7 @@ typedef __u32 __bitwise __wsum;
  * No conversions are necessary between 32-bit user-space and a 64-bit kernel.
  */
 #define __aligned_u64 __u64 __attribute__((aligned(8)))
+#define __aligned_s64 __s64 __attribute__((aligned(8)))
 #define __aligned_be64 __be64 __attribute__((aligned(8)))
 #define __aligned_le64 __le64 __attribute__((aligned(8)))
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 273a8a42cb72..801022a8899b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -81,7 +81,7 @@
 DEFINE_MUTEX(cgroup_mutex);
 DEFINE_SPINLOCK(css_set_lock);
 
-#ifdef CONFIG_PROVE_RCU
+#if (defined CONFIG_PROVE_RCU || defined CONFIG_LOCKDEP)
 EXPORT_SYMBOL_GPL(cgroup_mutex);
 EXPORT_SYMBOL_GPL(css_set_lock);
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 1728aa77861c..e71f96bff1dc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1703,10 +1703,16 @@ static int pidfd_release(struct inode *inode, struct file *file)
 #ifdef CONFIG_PROC_FS
 static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 {
-	struct pid_namespace *ns = proc_pid_ns(file_inode(m->file));
 	struct pid *pid = f->private_data;
+	struct pid_namespace *ns;
+	pid_t nr = -1;
 
-	seq_put_decimal_ull(m, "Pid:\t", pid_nr_ns(pid, ns));
+	if (likely(pid_has_task(pid, PIDTYPE_PID))) {
+		ns = proc_pid_ns(file_inode(m->file));
+		nr = pid_nr_ns(pid, ns);
+	}
+
+	seq_put_decimal_ll(m, "Pid:\t", nr);
 	seq_putc(m, '\n');
 }
 #endif
@@ -1744,6 +1750,91 @@ const struct file_operations pidfd_fops = {
 #endif
 };
 
+/**
+ * __pidfd_prepare - allocate a new pidfd_file and reserve a pidfd
+ * @pid:   the struct pid for which to create a pidfd
+ * @flags: flags of the new @pidfd
+ * @pidfd: the pidfd to return
+ *
+ * Allocate a new file that stashes @pid and reserve a new pidfd number in the
+ * caller's file descriptor table. The pidfd is reserved but not installed yet.
+
+ * The helper doesn't perform checks on @pid which makes it useful for pidfds
+ * created via CLONE_PIDFD where @pid has no task attached when the pidfd and
+ * pidfd file are prepared.
+ *
+ * If this function returns successfully the caller is responsible to either
+ * call fd_install() passing the returned pidfd and pidfd file as arguments in
+ * order to install the pidfd into its file descriptor table or they must use
+ * put_unused_fd() and fput() on the returned pidfd and pidfd file
+ * respectively.
+ *
+ * This function is useful when a pidfd must already be reserved but there
+ * might still be points of failure afterwards and the caller wants to ensure
+ * that no pidfd is leaked into its file descriptor table.
+ *
+ * Return: On success, a reserved pidfd is returned from the function and a new
+ *         pidfd file is returned in the last argument to the function. On
+ *         error, a negative error code is returned from the function and the
+ *         last argument remains unchanged.
+ */
+static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
+{
+	int pidfd;
+	struct file *pidfd_file;
+
+	if (flags & ~(O_NONBLOCK | O_RDWR | O_CLOEXEC))
+		return -EINVAL;
+
+	pidfd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
+	if (pidfd < 0)
+		return pidfd;
+
+	pidfd_file = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
+					flags | O_RDWR | O_CLOEXEC);
+	if (IS_ERR(pidfd_file)) {
+		put_unused_fd(pidfd);
+		return PTR_ERR(pidfd_file);
+	}
+	get_pid(pid); /* held by pidfd_file now */
+	*ret = pidfd_file;
+	return pidfd;
+}
+
+/**
+ * pidfd_prepare - allocate a new pidfd_file and reserve a pidfd
+ * @pid:   the struct pid for which to create a pidfd
+ * @flags: flags of the new @pidfd
+ * @pidfd: the pidfd to return
+ *
+ * Allocate a new file that stashes @pid and reserve a new pidfd number in the
+ * caller's file descriptor table. The pidfd is reserved but not installed yet.
+ *
+ * The helper verifies that @pid is used as a thread group leader.
+ *
+ * If this function returns successfully the caller is responsible to either
+ * call fd_install() passing the returned pidfd and pidfd file as arguments in
+ * order to install the pidfd into its file descriptor table or they must use
+ * put_unused_fd() and fput() on the returned pidfd and pidfd file
+ * respectively.
+ *
+ * This function is useful when a pidfd must already be reserved but there
+ * might still be points of failure afterwards and the caller wants to ensure
+ * that no pidfd is leaked into its file descriptor table.
+ *
+ * Return: On success, a reserved pidfd is returned from the function and a new
+ *         pidfd file is returned in the last argument to the function. On
+ *         error, a negative error code is returned from the function and the
+ *         last argument remains unchanged.
+ */
+int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
+{
+	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
+		return -EINVAL;
+
+	return __pidfd_prepare(pid, flags, ret);
+}
+
 static void __delayed_free_task(struct rcu_head *rhp)
 {
 	struct task_struct *tsk = container_of(rhp, struct task_struct, rcu);
@@ -2064,21 +2155,12 @@ static __latent_entropy struct task_struct *copy_process(
 	 * if the fd table isn't shared).
 	 */
 	if (clone_flags & CLONE_PIDFD) {
-		retval = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
+		/* Note that no task has been attached to @pid yet. */
+		retval = __pidfd_prepare(pid, O_RDWR | O_CLOEXEC, &pidfile);
 		if (retval < 0)
 			goto bad_fork_free_pid;
-
 		pidfd = retval;
 
-		pidfile = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
-					      O_RDWR | O_CLOEXEC);
-		if (IS_ERR(pidfile)) {
-			put_unused_fd(pidfd);
-			retval = PTR_ERR(pidfile);
-			goto bad_fork_free_pid;
-		}
-		get_pid(pid);	/* held by pidfile now */
-
 		retval = put_user(pidfd, args->pidfd);
 		if (retval)
 			goto bad_fork_put_pidfd;
diff --git a/kernel/params.c b/kernel/params.c
index b638476d12de..6639d6eec6bd 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -946,7 +946,9 @@ int module_sysfs_initialized;
 static void module_kobj_release(struct kobject *kobj)
 {
 	struct module_kobject *mk = to_module_kobject(kobj);
-	complete(mk->kobj_completion);
+
+	if (mk->kobj_completion)
+		complete(mk->kobj_completion);
 }
 
 struct kobj_type module_ktype = {
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2c127d438fe0..1d9f2831b54e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -902,13 +902,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
  */
 static void rcu_flavor_sched_clock_irq(int user)
 {
-	if (user || rcu_is_cpu_rrupt_from_idle()) {
+	if (user || rcu_is_cpu_rrupt_from_idle() ||
+	     (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
+	      (preempt_count() == HARDIRQ_OFFSET))) {
 
 		/*
 		 * Get here if this CPU took its interrupt from user
-		 * mode or from the idle loop, and if this is not a
-		 * nested interrupt.  In this case, the CPU is in
-		 * a quiescent state, so note it.
+		 * mode, from the idle loop without this being a nested
+		 * interrupt, or while not holding the task preempt count
+		 * (with PREEMPT_COUNT=y). In this case, the CPU is in a
+		 * quiescent state, so note it.
 		 *
 		 * No memory barrier is required here because rcu_qs()
 		 * references only CPU-local variables that other CPUs
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index f3b8313475ac..2a2e4f6622ae 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -159,6 +159,7 @@ static int posix_timer_add(struct k_itimer *timer)
 			return id;
 		}
 		spin_unlock(&hash_lock);
+		cond_resched();
 	}
 	/* POSIX return code when no timer ID could be allocated */
 	return -EAGAIN;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d084334193bd..06c12d873c17 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6331,13 +6331,14 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
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
diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index e659a027036e..f6807062b32a 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -116,7 +116,7 @@ EXPORT_SYMBOL(dql_completed);
 void dql_reset(struct dql *dql)
 {
 	/* Reset all dynamic values */
-	dql->limit = 0;
+	dql->limit = dql->min_limit;
 	dql->num_queued = 0;
 	dql->num_completed = 0;
 	dql->last_obj_cnt = 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6f5565553e5f..2026e32d62a6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1221,7 +1221,6 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 {
 	struct mem_cgroup *iter;
 	int ret = 0;
-	int i = 0;
 
 	BUG_ON(memcg == root_mem_cgroup);
 
@@ -1231,10 +1230,9 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 
 		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
 		while (!ret && (task = css_task_iter_next(&it))) {
-			/* Avoid potential softlockup warning */
-			if ((++i & 1023) == 0)
-				cond_resched();
 			ret = fn(task, arg);
+			/* Avoid potential softlockup warning */
+			cond_resched();
 		}
 		css_task_iter_end(&it);
 		if (ret) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a0c01c3575bc..66e4b78786a9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4573,6 +4573,14 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	}
 
 retry:
+	/*
+	 * Deal with possible cpuset update races or zonelist updates to avoid
+	 * infinite retries.
+	 */
+	if (check_retry_cpuset(cpuset_mems_cookie, ac) ||
+	    check_retry_zonelist(zonelist_iter_cookie))
+		goto restart;
+
 	/* Ensure kswapd doesn't accidentally go to sleep as long as we loop */
 	if (alloc_flags & ALLOC_KSWAPD)
 		wake_all_kswapds(order, gfp_mask, ac);
diff --git a/net/bridge/br_nf_core.c b/net/bridge/br_nf_core.c
index 8c69f0c95a8e..b8c8deb87407 100644
--- a/net/bridge/br_nf_core.c
+++ b/net/bridge/br_nf_core.c
@@ -65,17 +65,14 @@ static struct dst_ops fake_dst_ops = {
  * ipt_REJECT needs it.  Future netfilter modules might
  * require us to fill additional fields.
  */
-static const u32 br_dst_default_metrics[RTAX_MAX] = {
-	[RTAX_MTU - 1] = 1500,
-};
-
 void br_netfilter_rtable_init(struct net_bridge *br)
 {
 	struct rtable *rt = &br->fake_rtable;
 
 	atomic_set(&rt->dst.__refcnt, 1);
 	rt->dst.dev = br->dev;
-	dst_init_metrics(&rt->dst, br_dst_default_metrics, true);
+	dst_init_metrics(&rt->dst, br->metrics, false);
+	dst_metric_set(&rt->dst, RTAX_MTU, br->dev->mtu);
 	rt->dst.flags	= DST_NOXFRM | DST_FAKE_RTABLE;
 	rt->dst.ops = &fake_dst_ops;
 }
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 5ba4620727a7..eb0b1b513feb 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -346,6 +346,7 @@ struct net_bridge {
 		struct rtable		fake_rtable;
 		struct rt6_info		fake_rt6_info;
 	};
+	u32				metrics[RTAX_MAX];
 #endif
 	u16				group_fwd_mask;
 	u16				group_fwd_mask_required;
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 1b5409b39a75..ccf15fc2353c 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -58,6 +58,7 @@
 #include <linux/can/skb.h>
 #include <linux/can/bcm.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
@@ -122,6 +123,7 @@ struct bcm_op {
 	struct canfd_frame last_sframe;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
+	spinlock_t bcm_tx_lock; /* protect currframe/count in runtime updates */
 };
 
 struct bcm_sock {
@@ -207,7 +209,9 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 	seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifindex));
 	seq_printf(m, " <<<\n");
 
-	list_for_each_entry(op, &bo->rx_ops, list) {
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
 
 		unsigned long reduction;
 
@@ -263,6 +267,9 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 		seq_printf(m, "# sent %ld\n", op->frames_abs);
 	}
 	seq_putc(m, '\n');
+
+	rcu_read_unlock();
+
 	return 0;
 }
 #endif /* CONFIG_PROC_FS */
@@ -275,13 +282,18 @@ static void bcm_can_tx(struct bcm_op *op)
 {
 	struct sk_buff *skb;
 	struct net_device *dev;
-	struct canfd_frame *cf = op->frames + op->cfsiz * op->currframe;
+	struct canfd_frame *cf;
 	int err;
 
 	/* no target device? => exit */
 	if (!op->ifindex)
 		return;
 
+	/* read currframe under lock protection */
+	spin_lock_bh(&op->bcm_tx_lock);
+	cf = op->frames + op->cfsiz * op->currframe;
+	spin_unlock_bh(&op->bcm_tx_lock);
+
 	dev = dev_get_by_index(sock_net(op->sk), op->ifindex);
 	if (!dev) {
 		/* RFC: should this bcm_op remove itself here? */
@@ -302,6 +314,10 @@ static void bcm_can_tx(struct bcm_op *op)
 	skb->dev = dev;
 	can_skb_set_owner(skb, op->sk);
 	err = can_send(skb, 1);
+
+	/* update currframe and count under lock protection */
+	spin_lock_bh(&op->bcm_tx_lock);
+
 	if (!err)
 		op->frames_abs++;
 
@@ -310,6 +326,11 @@ static void bcm_can_tx(struct bcm_op *op)
 	/* reached last frame? */
 	if (op->currframe >= op->nframes)
 		op->currframe = 0;
+
+	if (op->count > 0)
+		op->count--;
+
+	spin_unlock_bh(&op->bcm_tx_lock);
 out:
 	dev_put(dev);
 }
@@ -406,7 +427,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 	struct bcm_msg_head msg_head;
 
 	if (op->kt_ival1 && (op->count > 0)) {
-		op->count--;
+		bcm_can_tx(op);
 		if (!op->count && (op->flags & TX_COUNTEVT)) {
 
 			/* create notification to user */
@@ -421,7 +442,6 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 
 			bcm_send_to_user(op, &msg_head, NULL, 0);
 		}
-		bcm_can_tx(op);
 
 	} else if (op->kt_ival2) {
 		bcm_can_tx(op);
@@ -798,7 +818,7 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 						  REGMASK(op->can_id),
 						  bcm_rx_handler, op);
 
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return 1; /* done */
 		}
@@ -818,7 +838,7 @@ static int bcm_delete_tx_op(struct list_head *ops, struct bcm_msg_head *mh,
 	list_for_each_entry_safe(op, n, ops, list) {
 		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex) &&
 		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME)) {
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return 1; /* done */
 		}
@@ -911,6 +931,27 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		}
 		op->flags = msg_head->flags;
 
+		/* only lock for unlikely count/nframes/currframe changes */
+		if (op->nframes != msg_head->nframes ||
+		    op->flags & TX_RESET_MULTI_IDX ||
+		    op->flags & SETTIMER) {
+
+			spin_lock_bh(&op->bcm_tx_lock);
+
+			if (op->nframes != msg_head->nframes ||
+			    op->flags & TX_RESET_MULTI_IDX) {
+				/* potentially update changed nframes */
+				op->nframes = msg_head->nframes;
+				/* restart multiple frame transmission */
+				op->currframe = 0;
+			}
+
+			if (op->flags & SETTIMER)
+				op->count = msg_head->count;
+
+			spin_unlock_bh(&op->bcm_tx_lock);
+		}
+
 	} else {
 		/* insert new BCM operation for the given can_id */
 
@@ -918,9 +959,14 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (!op)
 			return -ENOMEM;
 
+		spin_lock_init(&op->bcm_tx_lock);
 		op->can_id = msg_head->can_id;
 		op->cfsiz = CFSIZ(msg_head->flags);
 		op->flags = msg_head->flags;
+		op->nframes = msg_head->nframes;
+
+		if (op->flags & SETTIMER)
+			op->count = msg_head->count;
 
 		/* create array for CAN frames and copy the data */
 		if (msg_head->nframes > 1) {
@@ -979,22 +1025,8 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 	} /* if ((op = bcm_find_op(&bo->tx_ops, msg_head->can_id, ifindex))) */
 
-	if (op->nframes != msg_head->nframes) {
-		op->nframes   = msg_head->nframes;
-		/* start multiple frame transmission with index 0 */
-		op->currframe = 0;
-	}
-
-	/* check flags */
-
-	if (op->flags & TX_RESET_MULTI_IDX) {
-		/* start multiple frame transmission with index 0 */
-		op->currframe = 0;
-	}
-
 	if (op->flags & SETTIMER) {
 		/* set timer values */
-		op->count = msg_head->count;
 		op->ival1 = msg_head->ival1;
 		op->ival2 = msg_head->ival2;
 		op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
@@ -1011,11 +1043,8 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		op->flags |= TX_ANNOUNCE;
 	}
 
-	if (op->flags & TX_ANNOUNCE) {
+	if (op->flags & TX_ANNOUNCE)
 		bcm_can_tx(op);
-		if (op->count)
-			op->count--;
-	}
 
 	if (op->flags & STARTTIMER)
 		bcm_tx_start_timer(op);
@@ -1231,7 +1260,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 					      bcm_rx_handler, op, "bcm", sk);
 		if (err) {
 			/* this bcm rx op is broken -> remove it */
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return err;
 		}
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 5e9bd9d80b39..4fd66e6466d2 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -805,6 +805,10 @@ static ssize_t get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
 	pkt_dev->nr_labels = 0;
 	do {
 		__u32 tmp;
+
+		if (n >= MAX_MPLS_LABELS)
+			return -E2BIG;
+
 		len = hex32_arg(&buffer[i], 8, &tmp);
 		if (len <= 0)
 			return len;
@@ -816,8 +820,6 @@ static ssize_t get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
 			return -EFAULT;
 		i++;
 		n++;
-		if (n >= MAX_MPLS_LABELS)
-			return -E2BIG;
 	} while (c == ',');
 
 	pkt_dev->nr_labels = n;
@@ -1768,8 +1770,8 @@ static ssize_t pktgen_thread_write(struct file *file,
 	i = len;
 
 	/* Read variable name */
-
-	len = strn_len(&user_buffer[i], sizeof(name) - 1);
+	max = min(sizeof(name) - 1, count - i);
+	len = strn_len(&user_buffer[i], max);
 	if (len < 0)
 		return len;
 
@@ -1799,7 +1801,8 @@ static ssize_t pktgen_thread_write(struct file *file,
 	if (!strcmp(name, "add_device")) {
 		char f[32];
 		memset(f, 0, 32);
-		len = strn_len(&user_buffer[i], sizeof(f) - 1);
+		max = min(sizeof(f) - 1, count - i);
+		len = strn_len(&user_buffer[i], max);
 		if (len < 0) {
 			ret = len;
 			goto out;
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index e9a3cc9e98df..1617ea18fae3 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -220,9 +220,9 @@ static int fib4_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 			       struct nlattr **tb,
 			       struct netlink_ext_ack *extack)
 {
-	struct net *net = sock_net(skb->sk);
+	struct fib4_rule *rule4 = (struct fib4_rule *)rule;
+	struct net *net = rule->fr_net;
 	int err = -EINVAL;
-	struct fib4_rule *rule4 = (struct fib4_rule *) rule;
 
 	if (frh->tos & ~IPTOS_TOS_MASK) {
 		NL_SET_ERR_MSG(extack, "Invalid tos");
diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 3cf9dc223103..acb8610c9a9d 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -344,9 +344,9 @@ static int fib6_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 			       struct nlattr **tb,
 			       struct netlink_ext_ack *extack)
 {
+	struct fib6_rule *rule6 = (struct fib6_rule *)rule;
+	struct net *net = rule->fr_net;
 	int err = -EINVAL;
-	struct net *net = sock_net(skb->sk);
-	struct fib6_rule *rule6 = (struct fib6_rule *) rule;
 
 	if (rule->action == FR_ACT_TO_TBL && !rule->l3mdev) {
 		if (rule->table == RT6_TABLE_UNSPEC) {
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index d57bfce94d60..390fcbe885b1 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -885,15 +885,15 @@ static int llc_ui_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		if (sk->sk_type != SOCK_STREAM)
 			goto copy_uaddr;
 
+		/* Partial read */
+		if (used + offset < skb_len)
+			continue;
+
 		if (!(flags & MSG_PEEK)) {
 			skb_unlink(skb, &sk->sk_receive_queue);
 			kfree_skb(skb);
 			*seq = 0;
 		}
-
-		/* Partial read */
-		if (used + offset < skb_len)
-			continue;
 	} while (len > 0);
 
 out:
diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 30b8b3fad150..297631f9717b 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -88,7 +88,7 @@ struct hbucket {
 #define ahash_sizeof_regions(htable_bits)		\
 	(ahash_numof_locks(htable_bits) * sizeof(struct ip_set_region))
 #define ahash_region(n, htable_bits)		\
-	((n) % ahash_numof_locks(htable_bits))
+	((n) / jhash_size(HTABLE_REGION_BITS))
 #define ahash_bucket_start(h,  htable_bits)	\
 	((htable_bits) < HTABLE_REGION_BITS ? 0	\
 		: (h) * jhash_size(HTABLE_REGION_BITS))
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 1e3dbed9d784..de330dffa0a2 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -608,7 +608,9 @@ static struct ctl_table nf_ct_sysctl_table[] = {
 		.data		= &nf_conntrack_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	[NF_SYSCTL_CT_COUNT] = {
 		.procname	= "nf_conntrack_count",
@@ -647,7 +649,9 @@ static struct ctl_table nf_ct_sysctl_table[] = {
 		.data		= &nf_ct_expect_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	[NF_SYSCTL_CT_ACCT] = {
 		.procname	= "nf_conntrack_acct",
@@ -926,7 +930,9 @@ static struct ctl_table nf_ct_netfilter_table[] = {
 		.data		= &nf_conntrack_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{ }
 };
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 7812cc3cc751..9e20fb759cb8 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1675,10 +1675,8 @@ static void nf_tables_chain_free_chain_rules(struct nft_chain *chain)
 	kvfree(chain->rules_next);
 }
 
-static void nf_tables_chain_destroy(struct nft_ctx *ctx)
+void nf_tables_chain_destroy(struct nft_chain *chain)
 {
-	struct nft_chain *chain = ctx->chain;
-
 	if (WARN_ON(chain->use > 0))
 		return;
 
@@ -1929,7 +1927,7 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 err_use:
 	nf_tables_unregister_hook(net, table, chain);
 err1:
-	nf_tables_chain_destroy(ctx);
+	nf_tables_chain_destroy(chain);
 
 	return err;
 }
@@ -2825,6 +2823,8 @@ static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
 static void nf_tables_rule_release(const struct nft_ctx *ctx,
 				   struct nft_rule *rule)
 {
+	lockdep_commit_lock_is_held(ctx->net);
+
 	nft_rule_expr_deactivate(ctx, rule, NFT_TRANS_RELEASE);
 	nf_tables_rule_destroy(ctx, rule);
 }
@@ -4173,6 +4173,8 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase)
 {
+	lockdep_commit_lock_is_held(ctx->net);
+
 	switch (phase) {
 	case NFT_TRANS_PREPARE_ERROR:
 		nft_set_trans_unbind(ctx, set);
@@ -6905,7 +6907,7 @@ static void nft_commit_release(struct nft_trans *trans)
 		kfree(nft_trans_chain_name(trans));
 		break;
 	case NFT_MSG_DELCHAIN:
-		nf_tables_chain_destroy(&trans->ctx);
+		nf_tables_chain_destroy(trans->ctx.chain);
 		break;
 	case NFT_MSG_DELRULE:
 		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
@@ -7582,7 +7584,7 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 		nf_tables_table_destroy(&trans->ctx);
 		break;
 	case NFT_MSG_NEWCHAIN:
-		nf_tables_chain_destroy(&trans->ctx);
+		nf_tables_chain_destroy(trans->ctx.chain);
 		break;
 	case NFT_MSG_NEWRULE:
 		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
@@ -8218,23 +8220,43 @@ int nft_data_dump(struct sk_buff *skb, int attr, const struct nft_data *data,
 }
 EXPORT_SYMBOL_GPL(nft_data_dump);
 
-int __nft_release_basechain(struct nft_ctx *ctx)
+static void __nft_release_basechain_now(struct nft_ctx *ctx)
 {
 	struct nft_rule *rule, *nr;
 
-	if (WARN_ON(!nft_is_base_chain(ctx->chain)))
-		return 0;
-
-	nf_tables_unregister_hook(ctx->net, ctx->chain->table, ctx->chain);
 	list_for_each_entry_safe(rule, nr, &ctx->chain->rules, list) {
 		list_del(&rule->list);
-		nft_use_dec(&ctx->chain->use);
 		nf_tables_rule_release(ctx, rule);
 	}
+	nf_tables_chain_destroy(ctx->chain);
+}
+
+int __nft_release_basechain(struct nft_ctx *ctx)
+{
+	struct nft_rule *rule;
+
+	if (WARN_ON_ONCE(!nft_is_base_chain(ctx->chain)))
+		return 0;
+
+	nf_tables_unregister_hook(ctx->net, ctx->chain->table, ctx->chain);
+	list_for_each_entry(rule, &ctx->chain->rules, list)
+		nft_use_dec(&ctx->chain->use);
+
 	nft_chain_del(ctx->chain);
 	nft_use_dec(&ctx->table->use);
-	nf_tables_chain_destroy(ctx);
 
+	if (!maybe_get_net(ctx->net)) {
+		__nft_release_basechain_now(ctx);
+		return 0;
+	}
+
+	/* wait for ruleset dumps to complete.  Owning chain is no longer in
+	 * lists, so new dumps can't find any of these rules anymore.
+	 */
+	synchronize_rcu();
+
+	__nft_release_basechain_now(ctx);
+	put_net(ctx->net);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__nft_release_basechain);
@@ -8300,10 +8322,9 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
 		nft_obj_destroy(&ctx, obj);
 	}
 	list_for_each_entry_safe(chain, nc, &table->chains, list) {
-		ctx.chain = chain;
 		nft_chain_del(chain);
 		nft_use_dec(&table->use);
-		nf_tables_chain_destroy(&ctx);
+		nf_tables_chain_destroy(chain);
 	}
 	list_del(&table->list);
 	nf_tables_table_destroy(&ctx);
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 815a55fa7356..5af7fe6312cf 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -967,8 +967,7 @@ static int output_userspace(struct datapath *dp, struct sk_buff *skb,
 	upcall.cmd = OVS_PACKET_CMD_ACTION;
 	upcall.mru = OVS_CB(skb)->mru;
 
-	for (a = nla_data(attr), rem = nla_len(attr); rem > 0;
-		 a = nla_next(a, &rem)) {
+	nla_for_each_nested(a, attr, rem) {
 		switch (nla_type(a)) {
 		case OVS_USERSPACE_ATTR_USERDATA:
 			upcall.userdata = a;
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 07a2b0b35495..1a0571806342 100644
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
@@ -344,7 +349,6 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct drr_sched *q = qdisc_priv(sch);
 	struct drr_class *cl;
 	int err = 0;
-	bool first;
 
 	cl = drr_classify(skb, sch, &err);
 	if (cl == NULL) {
@@ -354,7 +358,6 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	first = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		if (net_xmit_drop_count(err)) {
@@ -364,7 +367,7 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	if (first) {
+	if (!cl_is_active(cl)) {
 		list_add_tail(&cl->alist, &q->active);
 		cl->deficit = cl->quantum;
 	}
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 79c63c4610d3..0f57dd39b6b8 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -176,6 +176,11 @@ struct hfsc_sched {
 
 #define	HT_INFINITY	0xffffffffffffffffULL	/* infinite time value */
 
+static bool cl_in_el_or_vttree(struct hfsc_class *cl)
+{
+	return ((cl->cl_flags & HFSC_FSC) && cl->cl_nactive) ||
+		((cl->cl_flags & HFSC_RSC) && !RB_EMPTY_NODE(&cl->el_node));
+}
 
 /*
  * eligible tree holds backlogged classes being sorted by their eligible times.
@@ -1038,6 +1043,8 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	if (cl == NULL)
 		return -ENOBUFS;
 
+	RB_CLEAR_NODE(&cl->el_node);
+
 	err = tcf_block_get(&cl->block, &cl->filter_list, sch, extack);
 	if (err) {
 		kfree(cl);
@@ -1573,7 +1580,10 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		return err;
 	}
 
-	if (first) {
+	sch->qstats.backlog += len;
+	sch->q.qlen++;
+
+	if (first && !cl_in_el_or_vttree(cl)) {
 		if (cl->cl_flags & HFSC_RSC)
 			init_ed(cl, len);
 		if (cl->cl_flags & HFSC_FSC)
@@ -1588,9 +1598,6 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 
 	}
 
-	sch->qstats.backlog += len;
-	sch->q.qlen++;
-
 	return NET_XMIT_SUCCESS;
 }
 
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 4cdf2dd04701..c618aae25b09 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -331,7 +331,8 @@ static void htb_add_to_wait_tree(struct htb_sched *q,
  */
 static inline void htb_next_rb_node(struct rb_node **n)
 {
-	*n = rb_next(*n);
+	if (*n)
+		*n = rb_next(*n);
 }
 
 /**
@@ -573,8 +574,8 @@ static inline void htb_activate(struct htb_sched *q, struct htb_class *cl)
  */
 static inline void htb_deactivate(struct htb_sched *q, struct htb_class *cl)
 {
-	WARN_ON(!cl->prio_activity);
-
+	if (!cl->prio_activity)
+		return;
 	htb_deactivate_prios(q, cl);
 	cl->prio_activity = 0;
 }
@@ -1280,8 +1281,7 @@ static int htb_delete(struct Qdisc *sch, unsigned long arg)
 	if (cl->parent)
 		cl->parent->children--;
 
-	if (cl->prio_activity)
-		htb_deactivate(q, cl);
+	htb_deactivate(q, cl);
 
 	if (cl->cmode != HTB_CAN_SEND)
 		htb_safe_rb_erase(&cl->pq_node,
@@ -1406,8 +1406,7 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 			/* turn parent into inner node */
 			qdisc_purge_queue(parent->leaf.q);
 			parent_qdisc = parent->leaf.q;
-			if (parent->prio_activity)
-				htb_deactivate(q, parent);
+			htb_deactivate(q, parent);
 
 			/* remove from evt list because of level change */
 			if (parent->cmode != HTB_CAN_SEND) {
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 6e9e3405f26b..c466d255f786 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -203,6 +203,11 @@ struct qfq_sched {
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
@@ -1218,7 +1223,6 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct qfq_class *cl;
 	struct qfq_aggregate *agg;
 	int err = 0;
-	bool first;
 
 	cl = qfq_classify(skb, sch, &err);
 	if (cl == NULL) {
@@ -1240,7 +1244,6 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	gso_segs = skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
-	first = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		pr_debug("qfq_enqueue: enqueue failed %d\n", err);
@@ -1257,8 +1260,8 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	++sch->q.qlen;
 
 	agg = cl->agg;
-	/* if the queue was not empty, then done here */
-	if (!first) {
+	/* if the class is active, then done here */
+	if (cl_is_active(cl)) {
 		if (unlikely(skb == cl->qdisc->ops->peek(cl->qdisc)) &&
 		    list_first_entry(&agg->active, struct qfq_class, alist)
 		    == cl && cl->deficit < len)
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index f689c7b0c304..d67cb10a11db 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -277,9 +277,6 @@ static struct rpc_xprt *rpc_clnt_set_transport(struct rpc_clnt *clnt,
 	old = rcu_dereference_protected(clnt->cl_xprt,
 			lockdep_is_held(&clnt->cl_lock));
 
-	if (!xprt_bound(xprt))
-		clnt->cl_autobind = 1;
-
 	clnt->cl_timeout = timeout;
 	rcu_assign_pointer(clnt->cl_xprt, xprt);
 	spin_unlock(&clnt->cl_lock);
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index bffac2f4b581..78f69ee65d0e 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1571,6 +1571,9 @@ int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl)
 	struct xfrm_policy *delpol;
 	struct hlist_head *chain;
 
+	/* Sanitize mark before store */
+	policy->mark.v &= policy->mark.m;
+
 	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
 	chain = policy_hash_bysel(net, &policy->selector, policy->family, dir);
 	if (chain)
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index e8be18bff096..7380aa3a5f0f 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1244,6 +1244,9 @@ static void __xfrm_state_insert(struct xfrm_state *x)
 
 	list_add(&x->km.all, &net->xfrm.state_all);
 
+	/* Sanitize mark before store */
+	x->mark.v &= x->mark.m;
+
 	h = xfrm_dst_hash(net, &x->id.daddr, &x->props.saddr,
 			  x->props.reqid, x->props.family);
 	hlist_add_head_rcu(&x->bydst, net->xfrm.state_bydst + h);
diff --git a/scripts/config b/scripts/config
index 8c8d7c3d7acc..330bef88fd5e 100755
--- a/scripts/config
+++ b/scripts/config
@@ -32,6 +32,7 @@ commands:
                              Disable option directly after other option
 	--module-after|-M beforeopt option
                              Turn option into module directly after other option
+	--refresh            Refresh the config using old settings
 
 	commands can be repeated multiple times
 
@@ -124,16 +125,22 @@ undef_var() {
 	txt_delete "^# $name is not set" "$FN"
 }
 
-if [ "$1" = "--file" ]; then
-	FN="$2"
-	if [ "$FN" = "" ] ; then
-		usage
+FN=.config
+CMDS=()
+while [[ $# -gt 0 ]]; do
+	if [ "$1" = "--file" ]; then
+		if [ "$2" = "" ]; then
+			usage
+		fi
+		FN="$2"
+		shift 2
+	else
+		CMDS+=("$1")
+		shift
 	fi
-	shift 2
-else
-	FN=.config
-fi
+done
 
+set -- "${CMDS[@]}"
 if [ "$1" = "" ] ; then
 	usage
 fi
@@ -217,9 +224,8 @@ while [ "$1" != "" ] ; do
 		set_var "${CONFIG_}$B" "${CONFIG_}$B=m" "${CONFIG_}$A"
 		;;
 
-	# undocumented because it ignores --file (fixme)
 	--refresh)
-		yes "" | make oldconfig
+		yes "" | make oldconfig KCONFIG_CONFIG=$FN
 		;;
 
 	*)
diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index d7d5c58b8b6a..557f37f481fd 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -98,8 +98,8 @@ INITFILE=$1
 shift;
 
 if [ ! -r "$INITFILE" ]; then
-	echo "The base file '$INITFILE' does not exist.  Exit." >&2
-	exit 1
+	echo "The base file '$INITFILE' does not exist. Creating one..." >&2
+	touch "$INITFILE"
 fi
 
 MERGE_LIST=$*
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index ddb0a292802e..526598b40b13 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -921,6 +921,10 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	if (rc >= 0) {
 		old_cat = skp->smk_netlabel.attr.mls.cat;
 		rcu_assign_pointer(skp->smk_netlabel.attr.mls.cat, ncats.attr.mls.cat);
+		if (ncats.attr.mls.cat)
+			skp->smk_netlabel.flags |= NETLBL_SECATTR_MLS_CAT;
+		else
+			skp->smk_netlabel.flags &= ~(u32)NETLBL_SECATTR_MLS_CAT;
 		skp->smk_netlabel.attr.mls.lvl = ncats.attr.mls.lvl;
 		synchronize_rcu();
 		netlbl_catmap_free(old_cat);
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 51d2911366e9..dc5aac6749fc 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1081,8 +1081,7 @@ static int snd_pcm_oss_change_params_locked(struct snd_pcm_substream *substream)
 	runtime->oss.params = 0;
 	runtime->oss.prepare = 1;
 	runtime->oss.buffer_used = 0;
-	if (runtime->dma_area)
-		snd_pcm_format_set_silence(runtime->format, runtime->dma_area, bytes_to_samples(runtime, runtime->dma_bytes));
+	snd_pcm_runtime_buffer_set_silence(runtime);
 
 	runtime->oss.period_frames = snd_pcm_alsa_frames(substream, oss_period_size);
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 57a4991fa0f3..cef58e0828c4 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -648,6 +648,17 @@ static void snd_pcm_buffer_access_unlock(struct snd_pcm_runtime *runtime)
 	atomic_inc(&runtime->buffer_accessing);
 }
 
+/* fill the PCM buffer with the current silence format; called from pcm_oss.c */
+void snd_pcm_runtime_buffer_set_silence(struct snd_pcm_runtime *runtime)
+{
+	snd_pcm_buffer_access_lock(runtime);
+	if (runtime->dma_area)
+		snd_pcm_format_set_silence(runtime->format, runtime->dma_area,
+					   bytes_to_samples(runtime, runtime->dma_bytes));
+	snd_pcm_buffer_access_unlock(runtime);
+}
+EXPORT_SYMBOL_GPL(snd_pcm_runtime_buffer_set_silence);
+
 #if IS_ENABLED(CONFIG_SND_PCM_OSS)
 #define is_oss_stream(substream)	((substream)->oss.oss)
 #else
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 974142535a25..686d3bfd1e10 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -1575,7 +1575,7 @@ static int snd_es1968_capture_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct es1968 *chip = snd_pcm_substream_chip(substream);
 	struct esschan *es;
-	int apu1, apu2;
+	int err, apu1, apu2;
 
 	apu1 = snd_es1968_alloc_apu_pair(chip, ESM_APU_PCM_CAPTURE);
 	if (apu1 < 0)
@@ -1618,7 +1618,9 @@ static int snd_es1968_capture_open(struct snd_pcm_substream *substream)
 	runtime->hw = snd_es1968_capture;
 	runtime->hw.buffer_bytes_max = runtime->hw.period_bytes_max =
 		calc_available_memory_size(chip) - 1024; /* keep MIXBUF size */
-	snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
+	err = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
+	if (err < 0)
+		return err;
 
 	spin_lock_irq(&chip->substream_lock);
 	list_add(&es->list, &chip->substream_list);
diff --git a/sound/sh/Kconfig b/sound/sh/Kconfig
index b75fbb3236a7..f5fa09d740b4 100644
--- a/sound/sh/Kconfig
+++ b/sound/sh/Kconfig
@@ -14,7 +14,7 @@ if SND_SUPERH
 
 config SND_AICA
 	tristate "Dreamcast Yamaha AICA sound"
-	depends on SH_DREAMCAST
+	depends on SH_DREAMCAST && SH_DMA_API
 	select SND_PCM
 	select G2_DMA
 	help
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 104cfb56d225..5a8e86ba2900 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -428,6 +428,19 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{       /* Acer Aspire SW3-013 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW3-013"),
+		},
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 08ed973b2d97..a3b1f1c064dd 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -635,6 +635,33 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_volsw_range);
 
+static int snd_soc_clip_to_platform_max(struct snd_kcontrol *kctl)
+{
+	struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
+	struct snd_ctl_elem_value uctl;
+	int ret;
+
+	if (!mc->platform_max)
+		return 0;
+
+	ret = kctl->get(kctl, &uctl);
+	if (ret < 0)
+		return ret;
+
+	if (uctl.value.integer.value[0] > mc->platform_max)
+		uctl.value.integer.value[0] = mc->platform_max;
+
+	if (snd_soc_volsw_is_stereo(mc) &&
+	    uctl.value.integer.value[1] > mc->platform_max)
+		uctl.value.integer.value[1] = mc->platform_max;
+
+	ret = kctl->put(kctl, &uctl);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 /**
  * snd_soc_limit_volume - Set new limit to an existing volume control.
  *
@@ -667,7 +694,7 @@ int snd_soc_limit_volume(struct snd_soc_card *card,
 		mc = (struct soc_mixer_control *)kctl->private_value;
 		if (max <= mc->max) {
 			mc->platform_max = max;
-			ret = 0;
+			ret = snd_soc_clip_to_platform_max(kctl);
 		}
 	}
 	return ret;
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index a209f53901b8..91bf7575493b 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -283,10 +283,11 @@ int get_fd_type(int fd)
 		p_err("can't read link type: %s", strerror(errno));
 		return -1;
 	}
-	if (n == sizeof(path)) {
+	if (n == sizeof(buf)) {
 		p_err("can't read link type: path too long!");
 		return -1;
 	}
+	buf[n] = '\0';
 
 	if (strstr(buf, "bpf-map"))
 		return BPF_OBJ_MAP;
diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index cd72016c3cfa..ab0630ae6be8 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -130,6 +130,10 @@ objprefix    := $(subst ./,,$(OUTPUT)$(dir)/)
 obj-y        := $(addprefix $(objprefix),$(obj-y))
 subdir-obj-y := $(addprefix $(objprefix),$(subdir-obj-y))
 
+# Separate out test log files from real build objects.
+test-y       := $(filter %_log, $(obj-y))
+obj-y        := $(filter-out %_log, $(obj-y))
+
 # Final '$(obj)-in.o' object
 in-target := $(objprefix)$(obj)-in.o
 
@@ -140,7 +144,7 @@ $(subdir-y):
 
 $(sort $(subdir-obj-y)): $(subdir-y) ;
 
-$(in-target): $(obj-y) FORCE
+$(in-target): $(obj-y) $(test-y) FORCE
 	$(call rule_mkdir)
 	$(call if_changed,$(host)ld_multi)
 

