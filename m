Return-Path: <stable+bounces-151393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEA3ACDE7A
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C493A684B
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD1728FA86;
	Wed,  4 Jun 2025 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="daaHNy2z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BBF28F943;
	Wed,  4 Jun 2025 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749042376; cv=none; b=dJaf+Swk8ncmzk/uymJDDkzIOmdOGd7FWN7DyqR8LjDc7ClsQfc6+XhMrohqrv1X/lZB1GkYbrC0nHxsArQ2WMLRev1yaXpM+Aza5ozHMsYgnubSTIdCk+aQKFe1lfVUm/rnCoSRs7ltwQmHX85+3aduTKyXvVKc2zR2sMeZgM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749042376; c=relaxed/simple;
	bh=w90sv7vWxUKcj6bUcD+sAgG6sJuNwDin9jqPb2pKETM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpqEd4CLV/6UCJnnohaFuH0aWO3j4v3gezOqE3FioGcXWXL9nQqVdro2iJhfX6VfLKZGEsjP+z1Ut5q0PIVGXDSulF7iKZMZm91Ix1om2c7XhxBaxhs3ktEDnlaxweCHyBc4s5l/UpO5rDO3mAO/1totVcm8Nasqp706gUeczE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=daaHNy2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDFBC4CEE7;
	Wed,  4 Jun 2025 13:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749042375;
	bh=w90sv7vWxUKcj6bUcD+sAgG6sJuNwDin9jqPb2pKETM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=daaHNy2zno96ZKxDHdwY6bp5C3gf9aG3V6/M6vS7vkQSY2S+ZteeY31b9sJhrDINc
	 5BJLD2+V/AAdP/yxafFe+DUIXUt3jRAnMmr8QciDNbtDzBHNZ1M+xY0phduR1gaVXF
	 CAy7p1ZO16Xbd/kH/IZp+eJNkYl5HOAHsjIU9Ylc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.238
Date: Wed,  4 Jun 2025 15:06:03 +0200
Message-ID: <2025060403-fancied-portion-4a33@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025060403-reappear-jacket-275f@gregkh>
References: <2025060403-reappear-jacket-275f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 88110e74b3f7..12af5b0ecc8e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5122,6 +5122,8 @@
 
 			Selecting 'on' will also enable the mitigation
 			against user space to user space task attacks.
+			Selecting specific mitigation does not force enable
+			user mitigations.
 
 			Selecting 'off' will disable both the kernel and
 			the user space protections.
diff --git a/Makefile b/Makefile
index b0e2f455eb87..7d94034c906d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 237
+SUBLEVEL = 238
 EXTRAVERSION =
 NAME = Dare mighty things
 
@@ -795,6 +795,18 @@ KBUILD_CFLAGS += -Wno-gnu
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
index fb99b3e971c3..c00097794dab 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -126,7 +126,7 @@ dsi@54400000 {
 			reg = <0x54400000 0x00040000>;
 			clocks = <&tegra_car TEGRA114_CLK_DSIB>,
 				 <&tegra_car TEGRA114_CLK_DSIBLP>,
-				 <&tegra_car TEGRA114_CLK_PLL_D2_OUT0>;
+				 <&tegra_car TEGRA114_CLK_PLL_D_OUT0>;
 			clock-names = "dsi", "lp", "parent";
 			resets = <&tegra_car 82>;
 			reset-names = "dsi";
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index a9caaf7c0d67..c04772a9740e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1638,7 +1638,7 @@ vdd_1v8_dis: regulator@7 {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		regulator-always-on;
-		gpio = <&exp1 14 GPIO_ACTIVE_HIGH>;
+		gpio = <&exp1 9 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		vin-supply = <&vdd_1v8>;
 	};
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7756a365d4c4..d92b5aed354e 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -601,7 +601,8 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	pr_err("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
 
 #define pud_none(pud)		(!pud_val(pud))
-#define pud_bad(pud)		(!pud_table(pud))
+#define pud_bad(pud)		((pud_val(pud) & PUD_TYPE_MASK) != \
+				 PUD_TYPE_TABLE)
 #define pud_present(pud)	pte_present(pud_pte(pud))
 #define pud_leaf(pud)		(pud_present(pud) && !pud_table(pud))
 #define pud_valid(pud)		pte_valid(pud_pte(pud))
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
index 9bf60d7d44d3..a7bcf2b814c8 100644
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
index 9a753c4dafab..b29135dd7334 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2944,11 +2944,11 @@ static void __init fixup_device_tree_pmac(void)
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
index 4211e23a2f68..e2caca06c155 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -153,5 +153,6 @@ MRPROPER_FILES += $(HOST_DIR)/include/generated
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
+	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
 
 export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 9242dc91d751..268a238f4f9c 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -49,6 +49,7 @@ void __init mem_init(void)
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free(__pa(brk_end), uml_reserved - brk_end);
 	uml_reserved = brk_end;
+	min_low_pfn = PFN_UP(__pa(uml_reserved));
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 354d52e17ef5..8525b7960787 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -808,7 +808,8 @@ static __init int perf_event_ibs_init(void)
 	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 		perf_ibs_op.max_period  |= IBS_OP_MAX_CNT_EXT_MASK;
 		perf_ibs_op.config_mask	|= IBS_OP_MAX_CNT_EXT_MASK;
-		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
+		perf_ibs_op.cnt_mask    |= (IBS_OP_MAX_CNT_EXT_MASK |
+					    IBS_OP_CUR_CNT_EXT_MASK);
 	}
 
 	ret = perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
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
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index a4e4bbb7795d..63fc0f50cd38 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -402,6 +402,7 @@ struct pebs_xmm {
  */
 #define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
 #define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
+#define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)
 #define IBS_OP_CNT_CTL		(1ULL<<19)
 #define IBS_OP_VAL		(1ULL<<18)
 #define IBS_OP_ENABLE		(1ULL<<17)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 045ab6d0a98b..9b3611e4cb80 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1231,9 +1231,13 @@ static __ro_after_init enum spectre_v2_mitigation_cmd spectre_v2_cmd;
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
@@ -1246,7 +1250,7 @@ spectre_v2_parse_user_cmdline(void)
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
 	if (ret < 0)
-		return SPECTRE_V2_USER_CMD_AUTO;
+		return mode;
 
 	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
 		if (match_option(arg, ret, v2_user_options[i].option)) {
@@ -1256,8 +1260,8 @@ spectre_v2_parse_user_cmdline(void)
 		}
 	}
 
-	pr_err("Unknown user space protection option (%s). Switching to AUTO select\n", arg);
-	return SPECTRE_V2_USER_CMD_AUTO;
+	pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
+	return mode;
 }
 
 static inline bool spectre_v2_in_eibrs_mode(enum spectre_v2_mitigation mode)
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index f2e53b20df7e..09997eee7b6f 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -38,8 +38,12 @@
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
 
@@ -121,9 +125,22 @@ static void nmi_check_duration(struct nmiaction *action, u64 duration)
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
@@ -209,6 +226,31 @@ void unregister_nmi_handler(unsigned int type, const char *name)
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
index 4d8c0e258150..a09060b9bd15 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -874,15 +874,11 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
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
index 50f7b22f1b48..be21cfdc6dbc 100644
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
index b5ea34c340cc..3ef66a39111c 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -432,7 +432,7 @@ config ACPI_SBS
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
index 38581001811b..78be329c2d7c 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -219,16 +219,18 @@ static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
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
@@ -261,15 +263,18 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
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
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 464ed352ab2e..ed7b2caa9ebb 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -53,7 +53,7 @@ enum tis_int_flags {
 enum tis_defaults {
 	TIS_MEM_LEN = 0x5000,
 	TIS_SHORT_TIMEOUT = 750,	/* ms */
-	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
+	TIS_LONG_TIMEOUT = 4000,	/* 4 secs */
 	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
 	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
 };
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 385653fe3966..aebeb4d3c8dd 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/units.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -417,11 +418,151 @@ static const char * const imx8mp_clkout_sels[] = {"audio_pll1_out", "audio_pll2_
 static struct clk_hw **hws;
 static struct clk_hw_onecell_data *clk_hw_data;
 
+struct imx8mp_clock_constraints {
+	unsigned int clkid;
+	u32 maxrate;
+};
+
+/*
+ * Below tables are taken from IMX8MPCEC Rev. 2.1, 07/2023
+ * Table 13. Maximum frequency of modules.
+ * Probable typos fixed are marked with a comment.
+ */
+static const struct imx8mp_clock_constraints imx8mp_clock_common_constraints[] = {
+	{ IMX8MP_CLK_A53_DIV,             1000 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ENET_AXI,             266666667 }, /* Datasheet claims 266MHz */
+	{ IMX8MP_CLK_NAND_USDHC_BUS,       266666667 }, /* Datasheet claims 266MHz */
+	{ IMX8MP_CLK_MEDIA_APB,            200 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_HDMI_APB,             133333333 }, /* Datasheet claims 133MHz */
+	{ IMX8MP_CLK_ML_AXI,               800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_AHB,                  133333333 },
+	{ IMX8MP_CLK_IPG_ROOT,              66666667 },
+	{ IMX8MP_CLK_AUDIO_AHB,            400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_DISP2_PIX,      170 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_DRAM_ALT,             666666667 },
+	{ IMX8MP_CLK_DRAM_APB,             200 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_CAN1,                  80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_CAN2,                  80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_PCIE_AUX,              10 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_I2C5,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_I2C6,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_SAI1,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_SAI2,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_SAI3,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_SAI5,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_SAI6,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_ENET_QOS,             125 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ENET_QOS_TIMER,       200 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ENET_REF,             125 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ENET_TIMER,           125 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ENET_PHY_REF,         125 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_NAND,                 500 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_QSPI,                 400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_USDHC1,               400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_USDHC2,               400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_I2C1,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_I2C2,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_I2C3,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_I2C4,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_UART1,                 80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_UART2,                 80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_UART3,                 80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_UART4,                 80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ECSPI1,                80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ECSPI2,                80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_PWM1,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_PWM2,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_PWM3,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_PWM4,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_GPT1,                 100 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPT2,                 100 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPT3,                 100 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPT4,                 100 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPT5,                 100 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPT6,                 100 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_WDOG,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_IPP_DO_CLKO1,         200 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_IPP_DO_CLKO2,         200 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_HDMI_REF_266M,        266 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_USDHC3,               400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_MIPI_PHY1_REF,  300 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_DISP1_PIX,      250 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_CAM2_PIX,       277 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_LDB,            595 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_MIPI_TEST_BYTE, 200 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ECSPI3,                80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_PDM,                  200 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_SAI7,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_MAIN_AXI,             400 * HZ_PER_MHZ },
+	{ /* Sentinel */ }
+};
+
+static const struct imx8mp_clock_constraints imx8mp_clock_nominal_constraints[] = {
+	{ IMX8MP_CLK_M7_CORE,           600 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ML_CORE,           800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU3D_CORE,        800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU3D_SHADER_CORE, 800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU2D_CORE,        800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_AUDIO_AXI_SRC,     600 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_HSIO_AXI,          400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_ISP,         400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_VPU_BUS,           600 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_AXI,         400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_HDMI_AXI,          400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU_AXI,           600 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU_AHB,           300 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_NOC,               800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_NOC_IO,            600 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ML_AHB,            300 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_VPU_G1,            600 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_VPU_G2,            500 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_CAM1_PIX,    400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_VPU_VC8000E,       400 * HZ_PER_MHZ }, /* Datasheet claims 500MHz */
+	{ IMX8MP_CLK_DRAM_CORE,         800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GIC,               400 * HZ_PER_MHZ },
+	{ /* Sentinel */ }
+};
+
+static const struct imx8mp_clock_constraints imx8mp_clock_overdrive_constraints[] = {
+	{ IMX8MP_CLK_M7_CORE,            800 * HZ_PER_MHZ},
+	{ IMX8MP_CLK_ML_CORE,           1000 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU3D_CORE,        1000 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU3D_SHADER_CORE, 1000 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU2D_CORE,        1000 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_AUDIO_AXI_SRC,      800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_HSIO_AXI,           500 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_ISP,          500 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_VPU_BUS,            800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_AXI,          500 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_HDMI_AXI,           500 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU_AXI,            800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU_AHB,            400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_NOC,               1000 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_NOC_IO,             800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ML_AHB,             400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_VPU_G1,             800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_VPU_G2,             700 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_CAM1_PIX,     500 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_VPU_VC8000E,        500 * HZ_PER_MHZ }, /* Datasheet claims 400MHz */
+	{ IMX8MP_CLK_DRAM_CORE,         1000 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GIC,                500 * HZ_PER_MHZ },
+	{ /* Sentinel */ }
+};
+
+static void imx8mp_clocks_apply_constraints(const struct imx8mp_clock_constraints constraints[])
+{
+	const struct imx8mp_clock_constraints *constr;
+
+	for (constr = constraints; constr->clkid; constr++)
+		clk_hw_set_rate_range(hws[constr->clkid], 0, constr->maxrate);
+}
+
 static int imx8mp_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	void __iomem *anatop_base, *ccm_base;
+	const char *opmode;
 	int err;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
@@ -736,6 +877,16 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	imx_check_clk_hws(hws, IMX8MP_CLK_END);
 
+	imx8mp_clocks_apply_constraints(imx8mp_clock_common_constraints);
+
+	err = of_property_read_string(np, "fsl,operating-mode", &opmode);
+	if (!err) {
+		if (!strcmp(opmode, "nominal"))
+			imx8mp_clocks_apply_constraints(imx8mp_clock_nominal_constraints);
+		else if (!strcmp(opmode, "overdrive"))
+			imx8mp_clocks_apply_constraints(imx8mp_clock_overdrive_constraints);
+	}
+
 	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
 	if (err < 0) {
 		dev_err(dev, "failed to register hws for i.MX8MP\n");
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
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index be4175f415ba..1946691f6b32 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -119,6 +119,9 @@ static void gic_update_frequency(void *data)
 
 static int gic_starting_cpu(unsigned int cpu)
 {
+	/* Ensure the GIC counter is running */
+	clear_gic_config(GIC_CONFIG_COUNTSTOP);
+
 	gic_clockevent_cpu_init(cpu, this_cpu_ptr(&gic_clockevent_device));
 	return 0;
 }
@@ -253,9 +256,6 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 			pr_warn("Unable to register clock notifier\n");
 	}
 
-	/* And finally start the counter */
-	clear_gic_config(GIC_CONFIG_COUNTSTOP);
-
 	/*
 	 * It's safe to use the MIPS GIC timer as a sched clock source only if
 	 * its ticks are stable, which is true on either the platforms with
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index b0a7ad566081..a95cc8f024fd 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -249,8 +249,19 @@ static unsigned int get_typical_interval(struct menu_device *data,
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
index 915724fd7ea6..a3a172173e34 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -825,9 +825,9 @@ static int dmatest_func(void *data)
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
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 15eecb757619..1f01bd483c6b 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -962,8 +962,11 @@ static void udma_check_tx_completion(struct work_struct *work)
 	u32 residue_diff;
 	ktime_t time_diff;
 	unsigned long delay;
+	unsigned long flags;
 
 	while (1) {
+		spin_lock_irqsave(&uc->vc.lock, flags);
+
 		if (uc->desc) {
 			/* Get previous residue and time stamp */
 			residue_diff = uc->tx_drain.residue;
@@ -998,6 +1001,8 @@ static void udma_check_tx_completion(struct work_struct *work)
 				break;
 			}
 
+			spin_unlock_irqrestore(&uc->vc.lock, flags);
+
 			usleep_range(ktime_to_us(delay),
 				     ktime_to_us(delay) + 10);
 			continue;
@@ -1014,6 +1019,8 @@ static void udma_check_tx_completion(struct work_struct *work)
 
 		break;
 	}
+
+	spin_unlock_irqrestore(&uc->vc.lock, flags);
 }
 
 static irqreturn_t udma_ring_irq_handler(int irq, void *data)
@@ -3075,7 +3082,6 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
 				      struct of_dma *ofdma)
 {
 	struct udma_dev *ud = ofdma->of_dma_data;
-	dma_cap_mask_t mask = ud->ddev.cap_mask;
 	struct udma_filter_param filter_param;
 	struct dma_chan *chan;
 
@@ -3088,7 +3094,7 @@ static struct dma_chan *udma_of_xlate(struct of_phandle_args *dma_spec,
 	else
 		filter_param.atype = 0;
 
-	chan = __dma_request_channel(&mask, udma_dma_filter_fn, &filter_param,
+	chan = __dma_request_channel(&ud->ddev.cap_mask, udma_dma_filter_fn, &filter_param,
 				     ofdma->of_node);
 	if (!chan) {
 		dev_err(ud->dev, "get channel fail in %s.\n", __func__);
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index be38fd71f731..99aaada3a2d9 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -97,7 +97,7 @@ static irqreturn_t altr_sdram_mc_err_handler(int irq, void *dev_id)
 	if (status & priv->ecc_stat_ce_mask) {
 		regmap_read(drvdata->mc_vbase, priv->ecc_saddr_offset,
 			    &err_addr);
-		if (priv->ecc_uecnt_offset)
+		if (priv->ecc_cecnt_offset)
 			regmap_read(drvdata->mc_vbase,  priv->ecc_cecnt_offset,
 				    &err_count);
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, err_count,
@@ -1006,9 +1006,6 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 		}
 	}
 
-	/* Interrupt mode set to every SBERR */
-	regmap_write(ecc_mgr_map, ALTR_A10_ECC_INTMODE_OFST,
-		     ALTR_A10_ECC_INTMODE);
 	/* Enable ECC */
 	ecc_set_bits(ecc_ctrl_en_mask, (ecc_block_base +
 					ALTR_A10_ECC_CTRL_OFST));
@@ -2089,6 +2086,10 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
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
index cad20e87783b..79a6612bd01e 100644
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
 				dimm = edac_get_dimm(mci, (i * 2) + 1, j, 0);
 				dimm->nr_pages = nr_pages;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index fad887a66886..7949a87b03a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -70,12 +70,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
 
-	/* Program the AGP BAR */
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BASE, 0);
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
-
 	if (!amdgpu_sriov_vf(adev) || adev->asic_type <= CHIP_VEGA10) {
+		/* Program the AGP BAR */
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BASE, 0);
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
 		/* Program the system aperture low logical page number. */
 		WREG32_SOC15_RLC(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 184527afe2bd..05d2598f516d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -755,6 +755,14 @@ struct kfd_process *kfd_create_process(struct file *filep)
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
@@ -767,14 +775,6 @@ struct kfd_process *kfd_create_process(struct file *filep)
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
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 84fb1377ec93..88a9473ccf53 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -228,6 +228,7 @@ static bool create_links(
 		link->link_id.type = OBJECT_TYPE_CONNECTOR;
 		link->link_id.id = CONNECTOR_ID_VIRTUAL;
 		link->link_id.enum_id = ENUM_ID_1;
+		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 		link->link_enc = kzalloc(sizeof(*link->link_enc), GFP_KERNEL);
 
 		if (!link->link_enc) {
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index d27f2840b955..9c8595a98609 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -104,7 +104,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 		return false;
 	}
 
-	switch (mode->crtc_hdisplay) {
+	switch (mode->hdisplay) {
 	case 640:
 		vbios_mode->enh_table = &res_640x480[refresh_rate_index];
 		break;
@@ -115,7 +115,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 		vbios_mode->enh_table = &res_1024x768[refresh_rate_index];
 		break;
 	case 1280:
-		if (mode->crtc_vdisplay == 800)
+		if (mode->vdisplay == 800)
 			vbios_mode->enh_table = &res_1280x800[refresh_rate_index];
 		else
 			vbios_mode->enh_table = &res_1280x1024[refresh_rate_index];
@@ -127,7 +127,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 		vbios_mode->enh_table = &res_1440x900[refresh_rate_index];
 		break;
 	case 1600:
-		if (mode->crtc_vdisplay == 900)
+		if (mode->vdisplay == 900)
 			vbios_mode->enh_table = &res_1600x900[refresh_rate_index];
 		else
 			vbios_mode->enh_table = &res_1600x1200[refresh_rate_index];
@@ -136,7 +136,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 		vbios_mode->enh_table = &res_1680x1050[refresh_rate_index];
 		break;
 	case 1920:
-		if (mode->crtc_vdisplay == 1080)
+		if (mode->vdisplay == 1080)
 			vbios_mode->enh_table = &res_1920x1080[refresh_rate_index];
 		else
 			vbios_mode->enh_table = &res_1920x1200[refresh_rate_index];
@@ -180,6 +180,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 	hborder = (vbios_mode->enh_table->flags & HBorder) ? 8 : 0;
 	vborder = (vbios_mode->enh_table->flags & VBorder) ? 8 : 0;
 
+	adjusted_mode->crtc_hdisplay = vbios_mode->enh_table->hde;
 	adjusted_mode->crtc_htotal = vbios_mode->enh_table->ht;
 	adjusted_mode->crtc_hblank_start = vbios_mode->enh_table->hde + hborder;
 	adjusted_mode->crtc_hblank_end = vbios_mode->enh_table->ht - hborder;
@@ -189,6 +190,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 					 vbios_mode->enh_table->hfp +
 					 vbios_mode->enh_table->hsync);
 
+	adjusted_mode->crtc_vdisplay = vbios_mode->enh_table->vde;
 	adjusted_mode->crtc_vtotal = vbios_mode->enh_table->vt;
 	adjusted_mode->crtc_vblank_start = vbios_mode->enh_table->vde + vborder;
 	adjusted_mode->crtc_vblank_end = vbios_mode->enh_table->vt - vborder;
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index dee3b81dec58..8612dd552d39 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -557,6 +557,30 @@ mode_valid(struct drm_atomic_state *state)
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
@@ -720,6 +744,10 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
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
index 39eb39e78d7a..c3b4a84a9f91 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -5097,6 +5097,7 @@ drm_reset_display_info(struct drm_connector *connector)
 	info->has_hdmi_infoframe = false;
 	info->rgb_quant_range_selectable = false;
 	memset(&info->hdmi, 0, sizeof(info->hdmi));
+	memset(&connector->hdr_sink_metadata, 0, sizeof(connector->hdr_sink_metadata));
 
 	info->non_desktop = 0;
 	memset(&info->monitor_range, 0, sizeof(info->monitor_range));
diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
index 33569b910ed5..fbf1e67913f6 100644
--- a/drivers/gpu/drm/i915/gvt/opregion.c
+++ b/drivers/gpu/drm/i915/gvt/opregion.c
@@ -222,7 +222,8 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
 	u8 *buf;
 	struct opregion_header *header;
 	struct vbt v;
-	const char opregion_signature[16] = OPREGION_SIGNATURE;
+
+	static_assert(sizeof(header->signature) == sizeof(OPREGION_SIGNATURE) - 1);
 
 	gvt_dbg_core("init vgpu%d opregion\n", vgpu->id);
 	vgpu_opregion(vgpu)->va = (void *)__get_free_pages(GFP_KERNEL |
@@ -236,8 +237,9 @@ int intel_vgpu_init_opregion(struct intel_vgpu *vgpu)
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
index ac75c10aed2f..3a58d3dfd558 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -340,12 +340,13 @@ static void mtk_dpi_config_swap_input(struct mtk_dpi *dpi, bool enable)
 
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
 
diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 37127ba40aa9..0eb86943a358 100644
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
index e5dcbf67de7e..d31bf9e49bcd 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -95,7 +95,7 @@ nouveau_fence_context_kill(struct nouveau_fence_chan *fctx, int error)
 	while (!list_empty(&fctx->pending)) {
 		fence = list_entry(fctx->pending.next, typeof(*fence), head);
 
-		if (error)
+		if (error && !dma_fence_is_signaled_locked(&fence->base))
 			dma_fence_set_error(&fence->base, error);
 
 		if (nouveau_fence_signal(fence))
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 07b59021008e..9cc9c950604a 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -964,27 +964,28 @@ static const struct panel_desc auo_g070vvn01 = {
 	},
 };
 
-static const struct drm_display_mode auo_g101evn010_mode = {
-	.clock = 68930,
-	.hdisplay = 1280,
-	.hsync_start = 1280 + 82,
-	.hsync_end = 1280 + 82 + 2,
-	.htotal = 1280 + 82 + 2 + 84,
-	.vdisplay = 800,
-	.vsync_start = 800 + 8,
-	.vsync_end = 800 + 8 + 2,
-	.vtotal = 800 + 8 + 2 + 6,
+static const struct display_timing auo_g101evn010_timing = {
+	.pixelclock = { 64000000, 68930000, 85000000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 8, 64, 256 },
+	.hback_porch = { 8, 64, 256 },
+	.hsync_len = { 40, 168, 767 },
+	.vactive = { 800, 800, 800 },
+	.vfront_porch = { 4, 8, 100 },
+	.vback_porch = { 4, 8, 100 },
+	.vsync_len = { 8, 16, 223 },
 };
 
 static const struct panel_desc auo_g101evn010 = {
-	.modes = &auo_g101evn010_mode,
-	.num_modes = 1,
+	.timings = &auo_g101evn010_timing,
+	.num_timings = 1,
 	.bpc = 6,
 	.size = {
 		.width = 216,
 		.height = 135,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
index 6bacdb7583df..0505f87d13c0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -32,7 +32,6 @@
 #define VMW_FENCE_WRAP (1 << 31)
 
 struct vmw_fence_manager {
-	int num_fence_objects;
 	struct vmw_private *dev_priv;
 	spinlock_t lock;
 	struct list_head fence_list;
@@ -113,13 +112,13 @@ static void vmw_fence_obj_destroy(struct dma_fence *f)
 {
 	struct vmw_fence_obj *fence =
 		container_of(f, struct vmw_fence_obj, base);
-
 	struct vmw_fence_manager *fman = fman_from_fence(fence);
 
-	spin_lock(&fman->lock);
-	list_del_init(&fence->head);
-	--fman->num_fence_objects;
-	spin_unlock(&fman->lock);
+	if (!list_empty(&fence->head)) {
+		spin_lock(&fman->lock);
+		list_del_init(&fence->head);
+		spin_unlock(&fman->lock);
+	}
 	fence->destroy(fence);
 }
 
@@ -250,7 +249,6 @@ static const struct dma_fence_ops vmw_fence_ops = {
 	.release = vmw_fence_obj_destroy,
 };
 
-
 /**
  * Execute signal actions on fences recently signaled.
  * This is done from a workqueue so we don't have to execute
@@ -353,7 +351,6 @@ static int vmw_fence_obj_init(struct vmw_fence_manager *fman,
 		goto out_unlock;
 	}
 	list_add_tail(&fence->head, &fman->fence_list);
-	++fman->num_fence_objects;
 
 out_unlock:
 	spin_unlock(&fman->lock);
@@ -402,7 +399,7 @@ static bool vmw_fence_goal_new_locked(struct vmw_fence_manager *fman,
 {
 	u32 goal_seqno;
 	u32 *fifo_mem;
-	struct vmw_fence_obj *fence;
+	struct vmw_fence_obj *fence, *next_fence;
 
 	if (likely(!fman->seqno_valid))
 		return false;
@@ -413,7 +410,7 @@ static bool vmw_fence_goal_new_locked(struct vmw_fence_manager *fman,
 		return false;
 
 	fman->seqno_valid = false;
-	list_for_each_entry(fence, &fman->fence_list, head) {
+	list_for_each_entry_safe(fence, next_fence, &fman->fence_list, head) {
 		if (!list_empty(&fence->seq_passed_actions)) {
 			fman->seqno_valid = true;
 			vmw_mmio_write(fence->base.seqno,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index d86720fce48f..4b8f8e0ce8ca 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -41,6 +41,10 @@
 #define USB_VENDOR_ID_ACTIONSTAR	0x2101
 #define USB_DEVICE_ID_ACTIONSTAR_1011	0x1011
 
+#define USB_VENDOR_ID_ADATA_XPG 0x125f
+#define USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE 0x7505
+#define USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE_DONGLE 0x7506
+
 #define USB_VENDOR_ID_ADS_TECH		0x06e1
 #define USB_DEVICE_ID_ADS_TECH_RADIO_SI470X	0xa155
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 9c1afe9cdddf..b3e7ede8f398 100644
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
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 35ca2c02c9b9..7fdc7f213b11 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1508,7 +1508,10 @@ static int i2c_pxa_probe(struct platform_device *dev)
 				i2c->adap.name);
 	}
 
-	clk_prepare_enable(i2c->clk);
+	ret = clk_prepare_enable(i2c->clk);
+	if (ret)
+		return dev_err_probe(&dev->dev, ret,
+				     "failed to enable clock\n");
 
 	if (i2c->use_pio) {
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 576c12670bd8..8fd51de64d96 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -14,6 +14,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -150,6 +151,8 @@
 /* TAG length for DATA READ in RX FIFO  */
 #define READ_RX_TAGS_LEN		2
 
+#define QUP_BUS_WIDTH			8
+
 static unsigned int scl_freq;
 module_param_named(scl_freq, scl_freq, uint, 0444);
 MODULE_PARM_DESC(scl_freq, "SCL frequency override");
@@ -227,6 +230,7 @@ struct qup_i2c_dev {
 	int			irq;
 	struct clk		*clk;
 	struct clk		*pclk;
+	struct icc_path		*icc_path;
 	struct i2c_adapter	adap;
 
 	int			clk_ctl;
@@ -255,6 +259,10 @@ struct qup_i2c_dev {
 	/* To configure when bus is in run state */
 	u32			config_run;
 
+	/* bandwidth votes */
+	u32			src_clk_freq;
+	u32			cur_bw_clk_freq;
+
 	/* dma parameters */
 	bool			is_dma;
 	/* To check if the current transfer is using DMA */
@@ -453,6 +461,23 @@ static int qup_i2c_bus_active(struct qup_i2c_dev *qup, int len)
 	return ret;
 }
 
+static int qup_i2c_vote_bw(struct qup_i2c_dev *qup, u32 clk_freq)
+{
+	u32 needed_peak_bw;
+	int ret;
+
+	if (qup->cur_bw_clk_freq == clk_freq)
+		return 0;
+
+	needed_peak_bw = Bps_to_icc(clk_freq * QUP_BUS_WIDTH);
+	ret = icc_set_bw(qup->icc_path, 0, needed_peak_bw);
+	if (ret)
+		return ret;
+
+	qup->cur_bw_clk_freq = clk_freq;
+	return 0;
+}
+
 static void qup_i2c_write_tx_fifo_v1(struct qup_i2c_dev *qup)
 {
 	struct qup_i2c_block *blk = &qup->blk;
@@ -840,6 +865,10 @@ static int qup_i2c_bam_xfer(struct i2c_adapter *adap, struct i2c_msg *msg,
 	int ret = 0;
 	int idx = 0;
 
+	ret = qup_i2c_vote_bw(qup, qup->src_clk_freq);
+	if (ret)
+		return ret;
+
 	enable_irq(qup->irq);
 	ret = qup_i2c_req_dma(qup);
 
@@ -1645,6 +1674,7 @@ static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
 	config = readl(qup->base + QUP_CONFIG);
 	config |= QUP_CLOCK_AUTO_GATE;
 	writel(config, qup->base + QUP_CONFIG);
+	qup_i2c_vote_bw(qup, 0);
 	clk_disable_unprepare(qup->pclk);
 }
 
@@ -1745,6 +1775,11 @@ static int qup_i2c_probe(struct platform_device *pdev)
 			goto fail_dma;
 		}
 		qup->is_dma = true;
+
+		qup->icc_path = devm_of_icc_get(&pdev->dev, NULL);
+		if (IS_ERR(qup->icc_path))
+			return dev_err_probe(&pdev->dev, PTR_ERR(qup->icc_path),
+					     "failed to get interconnect path\n");
 	}
 
 nodma:
@@ -1793,6 +1828,7 @@ static int qup_i2c_probe(struct platform_device *pdev)
 		qup_i2c_enable_clocks(qup);
 		src_clk_freq = clk_get_rate(qup->clk);
 	}
+	qup->src_clk_freq = src_clk_freq;
 
 	/*
 	 * Bootloaders might leave a pending interrupt on certain QUP's,
diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index b4ae4f86da3e..9b60ac5dadf0 100644
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
index 2445ebc551dd..9580a7f7f73d 100644
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
index 58b3f6065db0..e29eb38a5069 100644
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
index 2ea9a5c4d846..002628e31b5c 100644
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
index 12ed0a2e55e4..2e6c634c56c7 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -369,6 +369,9 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_SAMPLE_SIZE;
+
 	fifo_len = (le16_to_cpu(fifo_status) & fifo_diff_mask) *
 		   ST_LSM6DSX_CHAN_SIZE;
 	fifo_len = (fifo_len / pattern_len) * pattern_len;
@@ -586,6 +589,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 	if (!fifo_len)
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
+
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
 		err = st_lsm6dsx_read_block(hw,
 					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 43394c3f29d4..129576a79698 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -69,11 +69,8 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 
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
index 82504b0ce01b..284eb7e4a2ae 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -163,6 +163,7 @@ static const char * const topbuttonpad_pnp_ids[] = {
 
 static const char * const smbus_pnp_ids[] = {
 	/* all of the topbuttonpad_pnp_ids are valid, we just add some extras */
+	"DLL060d", /* Dell Precision M3800 */
 	"LEN0048", /* X1 Carbon 3 */
 	"LEN0046", /* X250 */
 	"LEN0049", /* Yoga 11e */
@@ -187,11 +188,15 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
 	"LEN2068", /* T14 Gen 1 */
+	"SYN1221", /* TUXEDO InfinityBook Pro 14 v5 */
+	"SYN3003", /* HP EliteBook 850 G1 */
 	"SYN3015", /* HP EliteBook 840 G2 */
 	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
 	"SYN323d", /* HP Spectre X360 13-w013dx */
 	"SYN3257", /* HP Envy 13-ad105ng */
+	"TOS01f6", /* Dynabook Portege X30L-G */
+	"TOS0213", /* Dynabook Portege X30-D */
 	NULL
 };
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 917ee5a67e78..e09391ab3deb 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3243,6 +3243,14 @@ static int __init parse_ivrs_acpihid(char *str)
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
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c694ecbd304e..4c100e192223 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -6234,6 +6234,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e30, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e40, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e90, quirk_iommu_igfx);
 
+/* QM57/QS57 integrated gfx malfunctions with dmar */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_iommu_igfx);
+
 /* Broadwell igfx malfunctions with dmar */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1606, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x160B, quirk_iommu_igfx);
@@ -6311,7 +6314,6 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
        }
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_calpella_no_shadow_gtt);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0062, quirk_calpella_no_shadow_gtt);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x006a, quirk_calpella_no_shadow_gtt);
 
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 205a27519607..b17deec1c5d4 100644
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
@@ -408,7 +408,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 	return ret;
 }
 
-static struct of_device_id gicv2m_device_id[] = {
+static __initconst struct of_device_id gicv2m_device_id[] = {
 	{	.compatible	= "arm,gic-v2m-frame",	},
 	{},
 };
@@ -473,7 +473,7 @@ static struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
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
index 8a03357f8c93..fc6ad47c08b5 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2958,6 +2958,27 @@ static dm_cblock_t get_cache_dev_size(struct cache *cache)
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
@@ -3006,6 +3027,9 @@ static int cache_preresume(struct dm_target *ti)
 	struct cache *cache = ti->private;
 	dm_cblock_t csize = get_cache_dev_size(cache);
 
+	if (!can_resume(cache))
+		return -EINVAL;
+
 	/*
 	 * Check to see if the cache has resized.
 	 */
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 934887f8a855..07a7b4e51f0e 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4392,7 +4392,7 @@ static void dm_integrity_dtr(struct dm_target *ti)
 	BUG_ON(!RB_EMPTY_ROOT(&ic->in_progress));
 	BUG_ON(!list_empty(&ic->wait_list));
 
-	if (ic->mode == 'B')
+	if (ic->mode == 'B' && ic->bitmap_flush_work.work.func)
 		cancel_delayed_work_sync(&ic->bitmap_flush_work);
 	if (ic->metadata_wq)
 		destroy_workqueue(ic->metadata_wq);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 31bcdcd93c7a..4351de47fa77 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -513,8 +513,9 @@ static char **realloc_argv(unsigned *size, char **old_argv)
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
 
@@ -681,6 +682,10 @@ int dm_table_add_target(struct dm_table *t, const char *type,
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
index b7e0ec265b70..6e3b3643a2cd 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -811,13 +811,12 @@ static int c8sectpfe_probe(struct platform_device *pdev)
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
index c5e21785fafe..02343e88cc61 100644
--- a/drivers/media/usb/cx231xx/cx231xx-417.c
+++ b/drivers/media/usb/cx231xx/cx231xx-417.c
@@ -1722,6 +1722,8 @@ static void cx231xx_video_dev_init(
 	vfd->lock = &dev->lock;
 	vfd->release = video_device_release_empty;
 	vfd->ctrl_handler = &dev->mpeg_ctrl_handler.hdl;
+	vfd->device_caps = V4L2_CAP_READWRITE | V4L2_CAP_STREAMING |
+			   V4L2_CAP_VIDEO_CAPTURE;
 	video_set_drvdata(vfd, dev);
 	if (dev->tuner_type == TUNER_ABSENT) {
 		v4l2_disable_ioctl(vfd, VIDIOC_G_FREQUENCY);
diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index fbf0dcb313c8..67d3e6511a14 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -312,6 +312,8 @@ static int call_enum_dv_timings(struct v4l2_subdev *sd,
 static int call_get_mbus_config(struct v4l2_subdev *sd, unsigned int pad,
 				struct v4l2_mbus_config *config)
 {
+	memset(config, 0, sizeof(*config));
+
 	return check_pad(sd, pad) ? :
 	       sd->ops->pad->get_mbus_config(sd, pad, config);
 }
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 24e524a1b927..a15b44ca87d3 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1108,26 +1108,26 @@ int renesas_sdhi_probe(struct platform_device *pdev,
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
@@ -1139,8 +1139,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 	return ret;
 
-eirq:
-	tmio_mmc_host_remove(host);
 edisclk:
 	renesas_sdhi_clk_disable(host);
 efree:
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 67d9dd2165ec..376959569353 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -666,8 +666,12 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 
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
index 9091930f5859..3d601a3f31c1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2010,10 +2010,15 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
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
index 7caaf5b49c7b..c5ccd42af528 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2239,7 +2239,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	RCU_INIT_POINTER(bond->current_arp_slave, NULL);
 
-	if (!all && (!bond->params.fail_over_mac ||
+	if (!all && (bond->params.fail_over_mac != BOND_FOM_ACTIVE ||
 		     BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)) {
 		if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
 		    bond_has_slaves(bond))
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 8f0dde85e3da..1e0bf3405394 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -330,7 +330,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		/* Check if we need custom RAMINIT via syscon. Mostly for TI
 		 * platforms. Only supported with DT boot.
 		 */
-		if (np && of_property_read_bool(np, "syscon-raminit")) {
+		if (np && of_property_present(np, "syscon-raminit")) {
 			u32 id;
 			struct c_can_raminit *raminit = &priv->raminit_sys;
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 189d22658813..3d1ac72f689e 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2889,8 +2889,8 @@ static int mcp251xfd_remove(struct spi_device *spi)
 	struct mcp251xfd_priv *priv = spi_get_drvdata(spi);
 	struct net_device *ndev = priv->ndev;
 
-	can_rx_offload_del(&priv->offload);
 	mcp251xfd_unregister(priv);
+	can_rx_offload_del(&priv->offload);
 	spi->max_speed_hz = priv->spi_max_speed_hz_orig;
 	free_candev(ndev);
 
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index d3428e62bef2..39a56cedbc1f 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -373,15 +373,17 @@ static void b53_enable_vlan(struct b53_device *dev, bool enable,
 		b53_read8(dev, B53_VLAN_PAGE, B53_VLAN_CTRL5, &vc5);
 	}
 
+	vc1 &= ~VC1_RX_MCST_FWD_EN;
+
 	if (enable) {
 		vc0 |= VC0_VLAN_EN | VC0_VID_CHK_EN | VC0_VID_HASH_VID;
-		vc1 |= VC1_RX_MCST_UNTAG_EN | VC1_RX_MCST_FWD_EN;
+		vc1 |= VC1_RX_MCST_UNTAG_EN;
 		vc4 &= ~VC4_ING_VID_CHECK_MASK;
 		if (enable_filtering) {
 			vc4 |= VC4_ING_VID_VIO_DROP << VC4_ING_VID_CHECK_S;
 			vc5 |= VC5_DROP_VTABLE_MISS;
 		} else {
-			vc4 |= VC4_ING_VID_VIO_FWD << VC4_ING_VID_CHECK_S;
+			vc4 |= VC4_NO_ING_VID_CHK << VC4_ING_VID_CHECK_S;
 			vc5 &= ~VC5_DROP_VTABLE_MISS;
 		}
 
@@ -393,7 +395,7 @@ static void b53_enable_vlan(struct b53_device *dev, bool enable,
 
 	} else {
 		vc0 &= ~(VC0_VLAN_EN | VC0_VID_CHK_EN | VC0_VID_HASH_VID);
-		vc1 &= ~(VC1_RX_MCST_UNTAG_EN | VC1_RX_MCST_FWD_EN);
+		vc1 &= ~VC1_RX_MCST_UNTAG_EN;
 		vc4 &= ~VC4_ING_VID_CHECK_MASK;
 		vc5 &= ~VC5_DROP_VTABLE_MISS;
 
@@ -1870,7 +1872,7 @@ EXPORT_SYMBOL(b53_br_join);
 void b53_br_leave(struct dsa_switch *ds, int port, struct net_device *br)
 {
 	struct b53_device *dev = ds->priv;
-	struct b53_vlan *vl = &dev->vlans[0];
+	struct b53_vlan *vl;
 	s8 cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
 	unsigned int i;
 	u16 pvlan, reg, pvid;
@@ -1896,6 +1898,7 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct net_device *br)
 	dev->ports[port].vlan_ctl_mask = pvlan;
 
 	pvid = b53_default_pvid(dev);
+	vl = &dev->vlans[pvid];
 
 	/* Make this port join all VLANs without VLAN entries */
 	if (is58xx(dev)) {
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 4362fe0f346d..5f5e5b8267e0 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1644,6 +1644,7 @@ static void sja1105_bridge_stp_state_set(struct dsa_switch *ds, int port,
 	switch (state) {
 	case BR_STATE_DISABLED:
 	case BR_STATE_BLOCKING:
+	case BR_STATE_LISTENING:
 		/* From UM10944 description of DRPDTAG (why put this there?):
 		 * "Management traffic flows to the port regardless of the state
 		 * of the INGRESS flag". So BPDUs are still be allowed to pass.
@@ -1653,11 +1654,6 @@ static void sja1105_bridge_stp_state_set(struct dsa_switch *ds, int port,
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
index 23401958bc13..8926011604e3 100644
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
index e0b8f3c4cc0b..0493de8ee545 100644
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
diff --git a/drivers/net/ethernet/apm/xgene-v2/main.c b/drivers/net/ethernet/apm/xgene-v2/main.c
index 80399c8980bd..627f86014100 100644
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
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 2984234df67e..4dfb65b0bf1c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1344,6 +1344,17 @@ static int bnxt_get_regs_len(struct net_device *dev)
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
@@ -1372,12 +1383,27 @@ static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 	mutex_lock(&bp->hwrm_cmd_lock);
 	rc = _hwrm_send_message(bp, &req, sizeof(req), HWRM_CMD_TIMEOUT);
 	if (!rc) {
-		__le64 *src = (__le64 *)hw_pcie_stats;
-		u64 *dst = (u64 *)(_p + BNXT_PXP_REG_LEN);
-		int i;
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
 
-		for (i = 0; i < sizeof(*hw_pcie_stats) / sizeof(__le64); i++)
-			dst[i] = le64_to_cpu(src[i]);
+				*dst64 = le64_to_cpu(*(__le64 *)(src + i));
+				i += 8;
+			}
+		}
 	}
 	mutex_unlock(&bp->hwrm_cmd_lock);
 	dma_free_coherent(&bp->pdev->dev, sizeof(*hw_pcie_stats), hw_pcie_stats,
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 0f18837def3c..74f3cabf8ed6 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -826,22 +826,15 @@ static void macb_update_stats(struct macb *bp)
 
 static int macb_halt_tx(struct macb *bp)
 {
-	unsigned long	halt_time, timeout;
-	u32		status;
+	u32 status;
 
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(THALT));
 
-	timeout = jiffies + usecs_to_jiffies(MACB_HALT_TIMEOUT);
-	do {
-		halt_time = jiffies;
-		status = macb_readl(bp, TSR);
-		if (!(status & MACB_BIT(TGO)))
-			return 0;
-
-		udelay(250);
-	} while (time_before(halt_time, timeout));
-
-	return -ETIMEDOUT;
+	/* Poll TSR until TGO is cleared or timeout. */
+	return read_poll_timeout_atomic(macb_readl, status,
+					!(status & MACB_BIT(TGO)),
+					250, MACB_HALT_TIMEOUT, false,
+					bp, TSR);
 }
 
 static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb)
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 734acb834c98..66e0fbdcef22 100644
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
index 8e30e999456d..805434ba3035 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -602,7 +602,12 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
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
diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
index 632f16ffee40..085b1a0d67c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -577,7 +577,7 @@ void ice_free_cpu_rx_rmap(struct ice_vsi *vsi)
 {
 	struct net_device *netdev;
 
-	if (!vsi || vsi->type != ICE_VSI_PF || !vsi->arfs_fltr_list)
+	if (!vsi || vsi->type != ICE_VSI_PF)
 		return;
 
 	netdev = vsi->netdev;
@@ -600,7 +600,7 @@ int ice_set_cpu_rx_rmap(struct ice_vsi *vsi)
 	int base_idx, i;
 
 	if (!vsi || vsi->type != ICE_VSI_PF)
-		return -EINVAL;
+		return 0;
 
 	pf = vsi->back;
 	netdev = vsi->netdev;
@@ -638,7 +638,6 @@ void ice_remove_arfs(struct ice_pf *pf)
 	if (!pf_vsi)
 		return;
 
-	ice_free_cpu_rx_rmap(pf_vsi);
 	ice_clear_arfs(pf_vsi);
 }
 
@@ -655,9 +654,5 @@ void ice_rebuild_arfs(struct ice_pf *pf)
 		return;
 
 	ice_remove_arfs(pf);
-	if (ice_set_cpu_rx_rmap(pf_vsi)) {
-		dev_err(ice_pf_to_dev(pf), "Failed to rebuild aRFS\n");
-		return;
-	}
 	ice_init_arfs(pf_vsi);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index e99c8c10bc61..d3e5bf180c37 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2411,6 +2411,8 @@ void ice_vsi_free_irq(struct ice_vsi *vsi)
 		return;
 
 	vsi->irqs_ready = false;
+	ice_free_cpu_rx_rmap(vsi);
+
 	ice_for_each_q_vector(vsi, i) {
 		u16 vector = i + base;
 		int irq_num;
@@ -2424,7 +2426,8 @@ void ice_vsi_free_irq(struct ice_vsi *vsi)
 			continue;
 
 		/* clear the affinity notifier in the IRQ descriptor */
-		irq_set_affinity_notifier(irq_num, NULL);
+		if (!IS_ENABLED(CONFIG_RFS_ACCEL))
+			irq_set_affinity_notifier(irq_num, NULL);
 
 		/* clear the affinity_mask in the IRQ descriptor */
 		irq_set_affinity_hint(irq_num, NULL);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 035bc90c8124..a337a6826a84 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2247,6 +2247,13 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
 		irq_set_affinity_hint(irq_num, &q_vector->affinity_mask);
 	}
 
+	err = ice_set_cpu_rx_rmap(vsi);
+	if (err) {
+		netdev_err(vsi->netdev, "Failed to setup CPU RMAP on VSI %u: %pe\n",
+			   vsi->vsi_num, ERR_PTR(err));
+		goto free_q_irqs;
+	}
+
 	vsi->irqs_ready = true;
 	return 0;
 
@@ -3242,22 +3249,12 @@ static int ice_setup_pf_sw(struct ice_pf *pf)
 	 */
 	ice_napi_add(vsi);
 
-	status = ice_set_cpu_rx_rmap(vsi);
-	if (status) {
-		dev_err(ice_pf_to_dev(pf), "Failed to set CPU Rx map VSI %d error %d\n",
-			vsi->vsi_num, status);
-		status = -EINVAL;
-		goto unroll_napi_add;
-	}
 	status = ice_init_mac_fltr(pf);
 	if (status)
-		goto free_cpu_rx_map;
+		goto unroll_napi_add;
 
 	return status;
 
-free_cpu_rx_map:
-	ice_free_cpu_rx_rmap(vsi);
-
 unroll_napi_add:
 	if (vsi) {
 		ice_napi_del(vsi);
@@ -4598,7 +4595,6 @@ static int __maybe_unused ice_suspend(struct device *dev)
 			continue;
 		ice_vsi_free_q_vectors(pf->vsi[v]);
 	}
-	ice_free_cpu_rx_rmap(ice_get_main_vsi(pf));
 	ice_clear_interrupt_scheme(pf);
 
 	pci_save_state(pdev);
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
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 59b097cda327..6c52ddef88a6 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -445,6 +445,8 @@ int mlx4_en_process_tx_cq(struct net_device *dev,
 
 	if (unlikely(!priv->port_up))
 		return 0;
+	if (unlikely(!napi_budget) && cq->type == TX_XDP)
+		return 0;
 
 	netdev_txq_bql_complete_prefetchw(ring->tx_queue);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 6512bb231e7e..2fb1fe9a8eee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -53,6 +53,7 @@
 #define MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE \
         max(0x7, MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE)
 #define MLX5E_REP_PARAMS_DEF_NUM_CHANNELS 1
+#define MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE 0x8
 
 static const char mlx5e_rep_driver_name[] = "mlx5e_rep";
 
@@ -702,6 +703,8 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
 
 	/* RQ */
 	mlx5e_build_rq_params(mdev, params);
+	if (!mlx5e_is_uplink_rep(priv) && mlx5_core_is_ecpf(mdev))
+		params->log_rq_mtu_frames = MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE;
 
 	/* CQ moderation params */
 	params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
@@ -740,6 +743,8 @@ static void mlx5e_build_rep_netdev(struct net_device *netdev)
 	}
 
 	netdev->watchdog_timeo    = 15 * HZ;
+	if (mlx5_core_is_ecpf(mdev))
+		netdev->tx_queue_len = 1 << MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE;
 
 	netdev->features       |= NETIF_F_NETNS_LOCAL;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
index ce8ab1f01876..c380340b8166 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
@@ -188,6 +188,9 @@ mlx5e_test_loopback_validate(struct sk_buff *skb,
 	struct udphdr *udph;
 	struct iphdr *iph;
 
+	if (skb_linearize(skb))
+		goto out;
+
 	/* We are only going to peek, no need to clone the SKB */
 	if (MLX5E_TEST_PKT_SIZE - ETH_HLEN > skb_headlen(skb))
 		goto out;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index ccc7dd3e738a..7c6646f932b6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2317,7 +2317,9 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 		esw->offloads.encap = DEVLINK_ESWITCH_ENCAP_MODE_NONE;
 
 	mutex_init(&esw->offloads.termtbl_mutex);
-	mlx5_rdma_enable_roce(esw->dev);
+	err = mlx5_rdma_enable_roce(esw->dev);
+	if (err)
+		goto err_roce;
 
 	err = mlx5_esw_host_number_init(esw);
 	if (err)
@@ -2366,6 +2368,7 @@ int esw_offloads_enable(struct mlx5_eswitch *esw)
 err_metadata:
 	esw->flags &= ~MLX5_ESWITCH_VPORT_MATCH_METADATA;
 	mlx5_rdma_disable_roce(esw->dev);
+err_roce:
 	mutex_destroy(&esw->offloads.termtbl_mutex);
 	return err;
 }
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
index f42e118f3290..d48912d7afe5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -733,6 +733,7 @@ static void poll_health(struct timer_list *t)
 	health->prev = count;
 	if (health->miss_counter == MAX_MISSES) {
 		mlx5_core_err(dev, "device's health compromised - reached miss count\n");
+		health->synd = ioread8(&h->synd);
 		print_health_info(dev);
 		queue_work(health->wq, &health->report_work);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 6fd974920394..2f886bd77664 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -88,7 +88,6 @@ static void irq_set_name(char *name, int vecidx)
 
 	snprintf(name, MLX5_MAX_IRQ_NAME, "mlx5_comp%d",
 		 vecidx - MLX5_IRQ_VEC_COMP_BASE);
-	return;
 }
 
 static int request_irqs(struct mlx5_core_dev *dev, int nvec)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rdma.c b/drivers/net/ethernet/mellanox/mlx5/core/rdma.c
index 2389239acadc..e61a4fa46d77 100644
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
@@ -177,11 +177,11 @@ void mlx5_rdma_enable_roce(struct mlx5_core_dev *dev)
 		goto del_roce_addr;
 	}
 
-	return;
+	return err;
 
 del_roce_addr:
 	mlx5_rdma_del_roce_addr(dev);
 disable_roce:
 	mlx5_nic_vport_disable_roce(dev);
-	return;
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
index 50cb1c5251f7..a0f490a90757 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1475,6 +1475,7 @@ static void lan743x_tx_frame_add_lso(struct lan743x_tx *tx,
 	if (nr_frags <= 0) {
 		tx->frame_data0 |= TX_DESC_DATA0_LS_;
 		tx->frame_data0 |= TX_DESC_DATA0_IOC_;
+		tx->frame_last = tx->frame_first;
 	}
 	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
 	tx_descriptor->data0 = cpu_to_le32(tx->frame_data0);
@@ -1544,6 +1545,7 @@ static int lan743x_tx_frame_add_fragment(struct lan743x_tx *tx,
 		tx->frame_first = 0;
 		tx->frame_data0 = 0;
 		tx->frame_tail = 0;
+		tx->frame_last = 0;
 		return -ENOMEM;
 	}
 
@@ -1584,16 +1586,18 @@ static void lan743x_tx_frame_end(struct lan743x_tx *tx,
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
index 751f2bc9ce84..2a40cc827b18 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -657,6 +657,7 @@ struct lan743x_tx {
 	u32		frame_first;
 	u32		frame_data0;
 	u32		frame_tail;
+	u32		frame_last;
 
 	struct lan743x_tx_buffer_info *buffer_info;
 
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index 256b19f68cae..bf510d3882cf 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -1485,8 +1485,11 @@ static int qlcnic_sriov_channel_cfg_cmd(struct qlcnic_adapter *adapter, u8 cmd_o
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
index 958bbcfc2668..d04bc6597e0f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -936,7 +936,7 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
 		/* of_mdio_parse_addr returns a valid (0 ~ 31) PHY
 		 * address. No need to mask it again.
 		 */
-		reg |= 1 << H3_EPHY_ADDR_SHIFT;
+		reg |= ret << H3_EPHY_ADDR_SHIFT;
 	} else {
 		/* For SoCs without internal PHY the PHY selection bit should be
 		 * set to 0 (external PHY).
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index a1ee205d6a88..d6f8d3e757a2 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1427,6 +1427,7 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 		ndev->netdev_ops = &cpsw_netdev_ops;
 		ndev->ethtool_ops = &cpsw_ethtool_ops;
 		SET_NETDEV_DEV(ndev, dev);
+		ndev->dev.of_node = slave_data->slave_node;
 
 		if (!napi_ndev) {
 			/* CPSW Host port CPDMA interface is shared between
diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 9a082910ec59..35e2b7eb3076 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1488,8 +1488,7 @@ static u8 mcps_data_request(
 	command.pdata.data_req.src_addr_mode = src_addr_mode;
 	command.pdata.data_req.dst.mode = dst_address_mode;
 	if (dst_address_mode != MAC_MODE_NO_ADDR) {
-		command.pdata.data_req.dst.pan_id[0] = LS_BYTE(dst_pan_id);
-		command.pdata.data_req.dst.pan_id[1] = MS_BYTE(dst_pan_id);
+		put_unaligned_le16(dst_pan_id, command.pdata.data_req.dst.pan_id);
 		if (dst_address_mode == MAC_MODE_SHORT_ADDR) {
 			command.pdata.data_req.dst.address[0] = LS_BYTE(
 				dst_addr->short_address
@@ -1838,12 +1837,12 @@ static int ca8210_skb_rx(
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
 
@@ -1970,7 +1969,7 @@ static int ca8210_skb_tx(
 	status =  mcps_data_request(
 		header.source.mode,
 		header.dest.mode,
-		header.dest.pan_id,
+		le16_to_cpu(header.dest.pan_id),
 		(union macaddr *)&header.dest.extended_addr,
 		skb->len - mac_len,
 		&skb->data[mac_len],
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ec67d2eb05ec..7d7aa7d76880 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -333,9 +333,9 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 			be32_to_cpu(fdb->vni)))
 		goto nla_put_failure;
 
-	ci.ndm_used	 = jiffies_to_clock_t(now - fdb->used);
+	ci.ndm_used	 = jiffies_to_clock_t(now - READ_ONCE(fdb->used));
 	ci.ndm_confirmed = 0;
-	ci.ndm_updated	 = jiffies_to_clock_t(now - fdb->updated);
+	ci.ndm_updated	 = jiffies_to_clock_t(now - READ_ONCE(fdb->updated));
 	ci.ndm_refcnt	 = 0;
 
 	if (nla_put(skb, NDA_CACHEINFO, sizeof(ci), &ci))
@@ -541,8 +541,8 @@ static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
 	struct vxlan_fdb *f;
 
 	f = __vxlan_find_mac(vxlan, mac, vni);
-	if (f && f->used != jiffies)
-		f->used = jiffies;
+	if (f && READ_ONCE(f->used) != jiffies)
+		WRITE_ONCE(f->used, jiffies);
 
 	return f;
 }
@@ -1072,12 +1072,12 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
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
@@ -1111,7 +1111,7 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	}
 
 	if (ndm_flags & NTF_USE)
-		f->used = jiffies;
+		WRITE_ONCE(f->used, jiffies);
 
 	if (notify) {
 		if (rd == NULL)
@@ -1524,7 +1524,7 @@ static bool vxlan_snoop(struct net_device *dev,
 				    src_mac, &rdst->remote_ip.sa, &src_ip->sa);
 
 		rdst->remote_ip = *src_ip;
-		f->updated = jiffies;
+		WRITE_ONCE(f->updated, jiffies);
 		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);
 	} else {
 		u32 hash_index = fdb_head_index(vxlan, src_mac, vni);
@@ -2999,7 +2999,7 @@ static void vxlan_cleanup(struct timer_list *t)
 			if (f->flags & NTF_EXT_LEARNED)
 				continue;
 
-			timeout = f->used + vxlan->cfg.age_interval * HZ;
+			timeout = READ_ONCE(f->used) + vxlan->cfg.age_interval * HZ;
 			if (time_before_eq(timeout, jiffies)) {
 				netdev_dbg(vxlan->dev,
 					   "garbage collect %pM\n",
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
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 7991705e9d13..082eec4208c5 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -666,6 +666,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 	int i;
 
 	mt76_worker_disable(&dev->tx_worker);
+	napi_disable(&dev->tx_napi);
 	netif_napi_del(&dev->tx_napi);
 	for (i = 0; i < ARRAY_SIZE(dev->q_tx); i++)
 		mt76_dma_tx_cleanup(dev, i, true);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 91eea38f62cd..ab302e2ce9a2 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1141,6 +1141,7 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 			    struct ieee80211_sta_ht_cap *ht_cap)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
+	int i;
 
 	ht_cap->ht_supported = true;
 	ht_cap->cap = 0;
@@ -1158,25 +1159,20 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
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
 			     struct ieee80211_sta_vht_cap *vht_cap)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	u16 mcs_map;
+	u16 mcs_map = 0;
 	__le16 highest;
+	int i;
 
 	if (efuse->hw_cap.ptcl != EFUSE_HW_CAP_IGNORE &&
 	    efuse->hw_cap.ptcl != EFUSE_HW_CAP_PTCL_VHT)
@@ -1199,21 +1195,15 @@ static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
 	if (rtw_chip_has_rx_ldpc(rtwdev))
 		vht_cap->cap |= IEEE80211_VHT_CAP_RXLDPC;
 
-	mcs_map = IEEE80211_VHT_MCS_SUPPORT_0_9 << 0 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 4 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 6 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 8 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 10 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 12 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 14;
-	if (efuse->hw_cap.nss > 1) {
-		highest = cpu_to_le16(780);
-		mcs_map |= IEEE80211_VHT_MCS_SUPPORT_0_9 << 2;
-	} else {
-		highest = cpu_to_le16(390);
-		mcs_map |= IEEE80211_VHT_MCS_NOT_SUPPORTED << 2;
+	for (i = 0; i < 8; i++) {
+		if (i < efuse->hw_cap.nss)
+			mcs_map |= IEEE80211_VHT_MCS_SUPPORT_0_9 << (i * 2);
+		else
+			mcs_map |= IEEE80211_VHT_MCS_NOT_SUPPORTED << (i * 2);
 	}
 
+	highest = cpu_to_le16(390 * efuse->hw_cap.nss);
+
 	vht_cap->vht_mcs.rx_mcs_map = cpu_to_le16(mcs_map);
 	vht_cap->vht_mcs.tx_mcs_map = cpu_to_le16(mcs_map);
 	vht_cap->vht_mcs.rx_highest = highest;
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 9088bfb2a315..27de6eeb4ad6 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -107,6 +107,7 @@
 #define BIT_SHIFT_ROM_PGE	16
 #define BIT_FW_INIT_RDY		BIT(15)
 #define BIT_FW_DW_RDY		BIT(14)
+#define BIT_CPU_CLK_SEL		(BIT(12) | BIT(13))
 #define BIT_RPWM_TOGGLE		BIT(7)
 #define BIT_RAM_DL_SEL		BIT(7)	/* legacy only */
 #define BIT_DMEM_CHKSUM_OK	BIT(6)
@@ -124,7 +125,7 @@
 				 BIT_CHECK_SUM_OK)
 #define FW_READY_LEGACY		(BIT_MCUFWDL_RDY | BIT_FWDL_CHK_RPT |	       \
 				 BIT_WINTINI_RDY | BIT_RAM_DL_SEL)
-#define FW_READY_MASK		0xffff
+#define FW_READY_MASK		(0xffff & ~BIT_CPU_CLK_SEL)
 
 #define REG_MCU_TST_CFG		0x84
 #define VAL_FW_TRIGGER		0x1
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index dbfd67c3f598..1478cb22cf5f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -954,11 +954,11 @@ static void rtw8822b_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
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
 
@@ -966,12 +966,12 @@ rtw8822b_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
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
@@ -979,11 +979,13 @@ rtw8822b_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
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
 
diff --git a/drivers/net/wireless/realtek/rtw88/util.c b/drivers/net/wireless/realtek/rtw88/util.c
index 2c515af214e7..bfd017d53fef 100644
--- a/drivers/net/wireless/realtek/rtw88/util.c
+++ b/drivers/net/wireless/realtek/rtw88/util.c
@@ -101,7 +101,8 @@ void rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss)
 		*nss = 4;
 		*mcs = rate - DESC_RATEVHT4SS_MCS0;
 	} else if (rate >= DESC_RATEMCS0 &&
-		   rate <= DESC_RATEMCS15) {
+		   rate <= DESC_RATEMCS31) {
+		*nss = 0;
 		*mcs = rate - DESC_RATEMCS0;
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
index b19fba64beb0..cb9b38e142ed 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4429,7 +4429,8 @@ static void nvme_fw_act_work(struct work_struct *work)
 		msleep(100);
 	}
 
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
+	    !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
 		return;
 
 	nvme_start_queues(ctrl);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 93835c019b8e..7709a604d0be 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1573,7 +1573,7 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	cancel_work_sync(&queue->io_work);
 }
 
-static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
+static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
@@ -1584,6 +1584,31 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
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
@@ -1691,7 +1716,9 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->queue_count; i++)
-		nvme_tcp_stop_queue(ctrl, i);
+		nvme_tcp_stop_queue_nowait(ctrl, i);
+	for (i = 1; i < ctrl->queue_count; i++)
+		nvme_tcp_wait_queue(ctrl, i);
 }
 
 static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 754a963867dc..6019eee1f9bd 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1395,6 +1395,9 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
 
+	if (!queue->state_change)
+		return;
+
 	write_lock_bh(&sock->sk->sk_callback_lock);
 	sock->sk->sk_data_ready =  queue->data_ready;
 	sock->sk->sk_state_change = queue->state_change;
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 3a547793135c..93f08f18f6b3 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -231,14 +231,15 @@ static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len
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
index 8117f2dad86c..a68c7e273586 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1092,11 +1092,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index bbc9786bc36c..85be07e8b418 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -300,8 +300,8 @@ static int brcm_pcie_encode_ibar_size(u64 size)
 	if (log2_in >= 12 && log2_in <= 15)
 		/* Covers 4KB to 32KB (inclusive) */
 		return (log2_in - 12) + 0x1c;
-	else if (log2_in >= 16 && log2_in <= 35)
-		/* Covers 64KB to 32GB, (inclusive) */
+	else if (log2_in >= 16 && log2_in <= 36)
+		/* Covers 64KB to 64GB, (inclusive) */
 		return log2_in - 15;
 	/* Something is awry so disable */
 	return 0;
@@ -1326,3 +1326,4 @@ module_platform_driver(brcm_pcie_driver);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Broadcom STB PCIe RC driver");
 MODULE_AUTHOR("Broadcom");
+MODULE_SOFTDEP("pre: irq_bcm2712_mip");
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index a159bfdfa251..04c3ae8efc0f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -806,11 +806,9 @@ static resource_size_t calculate_iosize(resource_size_t size,
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
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index ac4428e8fae9..4294ba946b9c 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1512,6 +1512,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	cmn->dev = &pdev->dev;
+	cmn->cpu = raw_smp_processor_id();
 	platform_set_drvdata(pdev, cmn);
 
 	if (has_acpi_companion(cmn->dev))
@@ -1533,7 +1534,6 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	cmn->cpu = raw_smp_processor_id();
 	cmn->pmu = (struct pmu) {
 		.module = THIS_MODULE,
 		.attr_groups = arm_cmn_attr_groups,
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 1bcdef37e8aa..dac0f7f4f3d3 100644
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
index c0802152f30b..ea01a121b8fc 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -429,8 +429,11 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
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
index 8bd8d1f8eba2..e654ddb1a42b 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -536,16 +536,16 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
 
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
index fbfddcc39d5c..6ab3481ba902 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
@@ -79,7 +79,7 @@ static enum bcm281xx_pin_type hdmi_pin = BCM281XX_PIN_TYPE_HDMI;
 struct bcm281xx_pin_function {
 	const char *name;
 	const char * const *groups;
-	const unsigned ngroups;
+	const unsigned int ngroups;
 };
 
 /*
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
index 0220228c5040..d9279fc7be83 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -143,10 +143,14 @@ static int dt_to_map_one_config(struct pinctrl *p,
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
@@ -265,6 +269,8 @@ int pinctrl_dt_to_map(struct pinctrl *p, struct pinctrl_dev *pctldev)
 			ret = dt_to_map_one_config(p, pctldev, statename,
 						   np_config);
 			of_node_put(np_config);
+			if (ret == 1)
+				continue;
 			if (ret < 0)
 				goto err;
 		}
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 20683cd072bb..ae72edba8a1f 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -483,7 +483,7 @@ static int meson_pinconf_get(struct pinctrl_dev *pcdev, unsigned int pin,
 	case PIN_CONFIG_BIAS_PULL_DOWN:
 	case PIN_CONFIG_BIAS_PULL_UP:
 		if (meson_pinconf_get_pull(pc, pin) == param)
-			arg = 1;
+			arg = 60000;
 		else
 			return -EINVAL;
 		break;
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 931656494768..265232d1b9a8 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2739,7 +2739,8 @@ static int asus_wmi_add(struct platform_device *pdev)
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
index c07b3bcbf795..5a8434da60e7 100644
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
@@ -4049,6 +4050,10 @@ static bool hotkey_notify_6xxx(const u32 hkey,
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
@@ -10233,6 +10238,8 @@ static int __must_check __init get_thinkpad_model_data(
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
index 07a9cc91671b..3a2401ce2ec9 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1864,10 +1864,8 @@ static int ds1307_probe(struct i2c_client *client,
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
diff --git a/drivers/rtc/rtc-rv3032.c b/drivers/rtc/rtc-rv3032.c
index 9e6166864bd7..acae15c34d12 100644
--- a/drivers/rtc/rtc-rv3032.c
+++ b/drivers/rtc/rtc-rv3032.c
@@ -69,7 +69,7 @@
 #define RV3032_CLKOUT2_FD_MSK		GENMASK(6, 5)
 #define RV3032_CLKOUT2_OS		BIT(7)
 
-#define RV3032_CTRL1_EERD		BIT(3)
+#define RV3032_CTRL1_EERD		BIT(2)
 #define RV3032_CTRL1_WADA		BIT(5)
 
 #define RV3032_CTRL2_STOP		BIT(0)
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 3ff76ca147a5..353c360b0c6a 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -5407,6 +5407,7 @@ static struct lpfc_nodelist *
 __lpfc_findnode_did(struct lpfc_vport *vport, uint32_t did)
 {
 	struct lpfc_nodelist *ndlp;
+	struct lpfc_nodelist *np = NULL;
 	uint32_t data1;
 
 	list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
@@ -5421,14 +5422,20 @@ __lpfc_findnode_did(struct lpfc_vport *vport, uint32_t did)
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
index edd26a2570fa..8ce77fbe4e3f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -676,6 +676,7 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 	size_t data_in_sz = 0;
 	long ret;
 	u16 device_handle = MPT3SAS_INVALID_DEVICE_HANDLE;
+	int tm_ret;
 
 	issue_reset = 0;
 
@@ -1107,18 +1108,25 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 			if (pcie_device && (!ioc->tm_custom_handling) &&
 			    (!(mpt3sas_scsih_is_pcie_scsi_device(
 			    pcie_device->device_info))))
-				mpt3sas_scsih_issue_locked_tm(ioc,
+				tm_ret = mpt3sas_scsih_issue_locked_tm(ioc,
 				  le16_to_cpu(mpi_request->FunctionDependent1),
 				  0, 0, 0,
 				  MPI2_SCSITASKMGMT_TASKTYPE_TARGET_RESET, 0,
 				  0, pcie_device->reset_timeout,
 			MPI26_SCSITASKMGMT_MSGFLAGS_PROTOCOL_LVL_RST_PCIE);
 			else
-				mpt3sas_scsih_issue_locked_tm(ioc,
+				tm_ret = mpt3sas_scsih_issue_locked_tm(ioc,
 				  le16_to_cpu(mpi_request->FunctionDependent1),
 				  0, 0, 0,
 				  MPI2_SCSITASKMGMT_TASKTYPE_TARGET_RESET, 0,
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
index 465fe83b49e9..23bbb062c2aa 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -951,7 +951,6 @@ static void reset_state(struct scsi_tape *STp)
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
@@ -3627,9 +3630,25 @@ static long st_ioctl_common(struct file *file, unsigned int cmd_in, void __user
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
diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index bbbc2d2b7091..4d8948165487 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -57,6 +57,12 @@ k3_chipinfo_partno_to_names(unsigned int partno,
 	return -EINVAL;
 }
 
+static const struct regmap_config k3_chipinfo_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
 static int k3_chipinfo_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -64,13 +70,18 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct soc_device *soc_dev;
 	struct regmap *regmap;
+	void __iomem *base;
 	u32 partno_id;
 	u32 variant;
 	u32 jtag_id;
 	u32 mfg;
 	int ret;
 
-	regmap = device_node_to_regmap(node);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = regmap_init_mmio(dev, base, &k3_chipinfo_regmap_cfg);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0d9201a2999d..eda7ed618369 100644
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
@@ -61,6 +61,7 @@
 #define SPI_SR_TFIWF			BIT(18)
 #define SPI_SR_RFDF			BIT(17)
 #define SPI_SR_CMDFFF			BIT(16)
+#define SPI_SR_TXRXS			BIT(30)
 #define SPI_SR_CLEAR			(SPI_SR_TCFQF | \
 					SPI_SR_TFUF | SPI_SR_TFFF | \
 					SPI_SR_CMDTCF | SPI_SR_SPEF | \
@@ -907,9 +908,20 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_device *spi = message->spi;
 	struct spi_transfer *transfer;
 	int status = 0;
+	u32 val = 0;
+	bool cs_change = false;
 
 	message->actual_length = 0;
 
+	/* Put DSPI in running mode if halted. */
+	regmap_read(dspi->regmap, SPI_MCR, &val);
+	if (val & SPI_MCR_HALT) {
+		regmap_update_bits(dspi->regmap, SPI_MCR, SPI_MCR_HALT, 0);
+		while (regmap_read(dspi->regmap, SPI_SR, &val) >= 0 &&
+		       !(val & SPI_SR_TXRXS))
+			;
+	}
+
 	list_for_each_entry(transfer, &message->transfers, transfer_list) {
 		dspi->cur_transfer = transfer;
 		dspi->cur_msg = message;
@@ -934,6 +946,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				dspi->tx_cmd |= SPI_PUSHR_CMD_CONT;
 		}
 
+		cs_change = transfer->cs_change;
 		dspi->tx = transfer->tx_buf;
 		dspi->rx = transfer->rx_buf;
 		dspi->len = transfer->len;
@@ -943,6 +956,8 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
 				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
 
+		regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
+
 		spi_take_timestamp_pre(dspi->ctlr, dspi->cur_transfer,
 				       dspi->progress, !dspi->irq);
 
@@ -966,6 +981,15 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		spi_transfer_delay_exec(transfer);
 	}
 
+	if (status || !cs_change) {
+		/* Put DSPI in stop mode */
+		regmap_update_bits(dspi->regmap, SPI_MCR,
+				   SPI_MCR_HALT, SPI_MCR_HALT);
+		while (regmap_read(dspi->regmap, SPI_SR, &val) >= 0 &&
+		       val & SPI_SR_TXRXS)
+			;
+	}
+
 	message->status = status;
 	spi_finalize_current_message(ctlr);
 
@@ -1128,6 +1152,20 @@ static int dspi_resume(struct device *dev)
 
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
@@ -1145,6 +1183,8 @@ static const struct regmap_config dspi_regmap_config = {
 	.reg_stride	= 4,
 	.max_register	= 0x88,
 	.volatile_table	= &dspi_volatile_table,
+	.rd_table	= &dspi_access_table,
+	.wr_table	= &dspi_access_table,
 };
 
 static const struct regmap_range dspi_xspi_volatile_ranges[] = {
@@ -1166,6 +1206,8 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 		.reg_stride	= 4,
 		.max_register	= 0x13c,
 		.volatile_table	= &dspi_xspi_volatile_table,
+		.rd_table	= &dspi_access_table,
+		.wr_table	= &dspi_access_table,
 	},
 	{
 		.name		= "pushr",
@@ -1188,6 +1230,8 @@ static int dspi_init(struct fsl_dspi *dspi)
 	if (!spi_controller_is_slave(dspi->ctlr))
 		mcr |= SPI_MCR_MASTER;
 
+	mcr |= SPI_MCR_HALT;
+
 	regmap_write(dspi->regmap, SPI_MCR, mcr);
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
 
diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 4d4f77a186a9..89fccb9da1b8 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -383,7 +383,7 @@ MODULE_LICENSE("GPL");
 static void spi_test_print_hex_dump(char *pre, const void *ptr, size_t len)
 {
 	/* limit the hex_dump */
-	if (len < 1024) {
+	if (len <= 1024) {
 		print_hex_dump(KERN_INFO, pre,
 			       DUMP_PREFIX_OFFSET, 16, 1,
 			       ptr, len, 0);
diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 1fdfc6e6691d..a8fba310d700 100644
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
 
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 3d3ac48243eb..408b83882dae 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -689,7 +689,6 @@ static void zynqmp_process_dma_irq(struct zynqmp_qspi *xqspi)
 static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 {
 	struct zynqmp_qspi *xqspi = (struct zynqmp_qspi *)dev_id;
-	irqreturn_t ret = IRQ_NONE;
 	u32 status, mask, dma_status = 0;
 
 	status = zynqmp_gqspi_read(xqspi, GQSPI_ISR_OFST);
@@ -704,27 +703,24 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 				   dma_status);
 	}
 
-	if (mask & GQSPI_ISR_TXNOT_FULL_MASK) {
+	if (!mask && !dma_status)
+		return IRQ_NONE;
+
+	if (mask & GQSPI_ISR_TXNOT_FULL_MASK)
 		zynqmp_qspi_filltxfifo(xqspi, GQSPI_TX_FIFO_FILL);
-		ret = IRQ_HANDLED;
-	}
 
-	if (dma_status & GQSPI_QSPIDMA_DST_I_STS_DONE_MASK) {
+	if (dma_status & GQSPI_QSPIDMA_DST_I_STS_DONE_MASK)
 		zynqmp_process_dma_irq(xqspi);
-		ret = IRQ_HANDLED;
-	} else if (!(mask & GQSPI_IER_RXEMPTY_MASK) &&
-			(mask & GQSPI_IER_GENFIFOEMPTY_MASK)) {
+	else if (!(mask & GQSPI_IER_RXEMPTY_MASK) &&
+			(mask & GQSPI_IER_GENFIFOEMPTY_MASK))
 		zynqmp_qspi_readrxfifo(xqspi, GQSPI_RX_FIFO_FILL);
-		ret = IRQ_HANDLED;
-	}
 
 	if (xqspi->bytes_to_receive == 0 && xqspi->bytes_to_transfer == 0 &&
 	    ((status & GQSPI_IRQ_MASK) == GQSPI_IRQ_MASK)) {
 		zynqmp_gqspi_write(xqspi, GQSPI_IDR_OFST, GQSPI_ISR_IDR_MASK);
 		complete(&xqspi->data_completion);
-		ret = IRQ_HANDLED;
 	}
-	return ret;
+	return IRQ_HANDLED;
 }
 
 /**
diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 2bb1c2e9cb57..a005ddd6bc47 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -401,16 +401,14 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 
 	bytes_available = ioread32(fifo->base_addr + XLLF_RLR_OFFSET);
 	if (!bytes_available) {
-		dev_err(fifo->dt_device, "received a packet of length 0 - fifo core will be reset\n");
-		reset_ip_core(fifo);
+		dev_err(fifo->dt_device, "received a packet of length 0\n");
 		ret = -EIO;
 		goto end_unlock;
 	}
 
 	if (bytes_available > len) {
-		dev_err(fifo->dt_device, "user read buffer too small (available bytes=%zu user buffer bytes=%zu) - fifo core will be reset\n",
+		dev_err(fifo->dt_device, "user read buffer too small (available bytes=%zu user buffer bytes=%zu)\n",
 			bytes_available, len);
-		reset_ip_core(fifo);
 		ret = -EINVAL;
 		goto end_unlock;
 	}
@@ -419,8 +417,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		/* this probably can't happen unless IP
 		 * registers were previously mishandled
 		 */
-		dev_err(fifo->dt_device, "received a packet that isn't word-aligned - fifo core will be reset\n");
-		reset_ip_core(fifo);
+		dev_err(fifo->dt_device, "received a packet that isn't word-aligned\n");
 		ret = -EIO;
 		goto end_unlock;
 	}
@@ -441,7 +438,6 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 
 		if (copy_to_user(buf + copied * sizeof(u32), tmp_buf,
 				 copy * sizeof(u32))) {
-			reset_ip_core(fifo);
 			ret = -EFAULT;
 			goto end_unlock;
 		}
@@ -552,7 +548,6 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 
 		if (copy_from_user(tmp_buf, buf + copied * sizeof(u32),
 				   copy * sizeof(u32))) {
-			reset_ip_core(fifo);
 			ret = -EFAULT;
 			goto end_unlock;
 		}
@@ -785,9 +780,6 @@ static int axis_fifo_parse_dt(struct axis_fifo *fifo)
 		goto end;
 	}
 
-	/* IP sets TDFV to fifo depth - 4 so we will do the same */
-	fifo->tx_fifo_depth -= 4;
-
 	ret = get_dts_property(fifo, "xlnx,use-rx-data", &fifo->has_rx_fifo);
 	if (ret) {
 		dev_err(fifo->dt_device, "missing xlnx,use-rx-data property\n");
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 6c14d7bcdd67..081b17f49863 100644
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
index 075e2a6fb474..48fe53323f84 100644
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
index f2bd2e207e0b..db4f1ae3d6fc 100644
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
index 47c5f26e6012..f2809c44988b 100644
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
diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 73049f9bea25..34a5fbcc3d20 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -19,6 +19,7 @@
 #define SITES_MAX		16
 #define TMR_DISABLE		0x0
 #define TMR_ME			0x80000000
+#define TMR_CMD			BIT(29)
 #define TMR_ALPF		0x0c000000
 #define TMR_ALPF_V2		0x03000000
 #define TMTMIR_DEFAULT	0x0000000f
@@ -345,6 +346,12 @@ static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (data->ver > TMU_VER1) {
+		ret = regmap_set_bits(data->regmap, REGS_TMR, TMR_CMD);
+		if (ret)
+			return ret;
+	}
+
 	clk_disable_unprepare(data->clk);
 
 	return 0;
@@ -359,6 +366,12 @@ static int __maybe_unused qoriq_tmu_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (data->ver > TMU_VER1) {
+		ret = regmap_clear_bits(data->regmap, REGS_TMR, TMR_CMD);
+		if (ret)
+			return ret;
+	}
+
 	/* Enable monitoring */
 	return regmap_update_bits(data->regmap, REGS_TMR, TMR_ME, TMR_ME);
 }
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index a54c3cff6c28..03d883f5a4cc 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -360,25 +360,18 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		data->pinctrl = devm_pinctrl_get(dev);
 		if (PTR_ERR(data->pinctrl) == -ENODEV)
 			data->pinctrl = NULL;
-		else if (IS_ERR(data->pinctrl)) {
-			if (PTR_ERR(data->pinctrl) != -EPROBE_DEFER)
-				dev_err(dev, "pinctrl get failed, err=%ld\n",
-					PTR_ERR(data->pinctrl));
-			return PTR_ERR(data->pinctrl);
-		}
+		else if (IS_ERR(data->pinctrl))
+			return dev_err_probe(dev, PTR_ERR(data->pinctrl),
+					     "pinctrl get failed\n");
 
 		data->hsic_pad_regulator =
 				devm_regulator_get_optional(dev, "hsic");
 		if (PTR_ERR(data->hsic_pad_regulator) == -ENODEV) {
 			/* no pad regualator is needed */
 			data->hsic_pad_regulator = NULL;
-		} else if (IS_ERR(data->hsic_pad_regulator)) {
-			if (PTR_ERR(data->hsic_pad_regulator) != -EPROBE_DEFER)
-				dev_err(dev,
-					"Get HSIC pad regulator error: %ld\n",
-					PTR_ERR(data->hsic_pad_regulator));
-			return PTR_ERR(data->hsic_pad_regulator);
-		}
+		} else if (IS_ERR(data->hsic_pad_regulator))
+			return dev_err_probe(dev, PTR_ERR(data->hsic_pad_regulator),
+					     "Get HSIC pad regulator error\n");
 
 		if (data->hsic_pad_regulator) {
 			ret = regulator_enable(data->hsic_pad_regulator);
@@ -453,7 +446,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
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
@@ -462,7 +459,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	ret = imx_usbmisc_init(data->usbmisc_data);
 	if (ret) {
 		dev_err(dev, "usbmisc init failed, ret=%d\n", ret);
-		goto err_clk;
+		goto phy_shutdown;
 	}
 
 	data->ci_pdev = ci_hdrc_add_device(dev,
@@ -470,10 +467,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
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
 
 	if (data->usbmisc_data) {
@@ -507,6 +502,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 disable_device:
 	ci_hdrc_remove_device(data->ci_pdev);
+phy_shutdown:
+	if (data->override_phy_control)
+		usb_phy_shutdown(data->phy);
 err_clk:
 	imx_disable_unprepare_clks(dev);
 disable_hsic_regulator:
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 78adc112a77b..f76fedd8fa90 100644
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
diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 9d3e36c867e8..7f159ed1fa41 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -1737,6 +1737,10 @@ static int __tegra_xudc_ep_disable(struct tegra_xudc_ep *ep)
 		val = xudc_readl(xudc, CTRL);
 		val &= ~CTRL_RUN;
 		xudc_writel(xudc, val, CTRL);
+
+		val = xudc_readl(xudc, ST);
+		if (val & ST_RC)
+			xudc_writel(xudc, ST_RC, ST);
 	}
 
 	dev_info(xudc->dev, "ep %u disabled\n", ep->index);
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
diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index ffb09737b5d0..e2cd145ed495 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1178,6 +1178,7 @@ static void tegra_xhci_id_work(struct work_struct *work)
 	tegra->otg_usb3_port = tegra_xusb_padctl_get_usb3_companion(tegra->padctl,
 								    tegra->otg_usb2_port);
 
+	pm_runtime_get_sync(tegra->dev);
 	if (tegra->host_mode) {
 		/* switch to host mode */
 		if (tegra->otg_usb3_port >= 0) {
@@ -1207,6 +1208,7 @@ static void tegra_xhci_id_work(struct work_struct *work)
 		}
 
 		tegra_xhci_set_port_power(tegra, true, true);
+		pm_runtime_mark_last_busy(tegra->dev);
 
 	} else {
 		if (tegra->otg_usb3_port >= 0)
@@ -1214,6 +1216,7 @@ static void tegra_xhci_id_work(struct work_struct *work)
 
 		tegra_xhci_set_port_power(tegra, true, false);
 	}
+	pm_runtime_put_autosuspend(tegra->dev);
 }
 
 static int tegra_xusb_get_usb2_port(struct tegra_xusb *tegra,
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index def903e9d2ab..e0456e5e10b6 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -527,15 +527,20 @@ static ssize_t pin_assignment_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(pin_assignment);
 
-static struct attribute *dp_altmode_attrs[] = {
+static struct attribute *displayport_attrs[] = {
 	&dev_attr_configuration.attr,
 	&dev_attr_pin_assignment.attr,
 	NULL
 };
 
-static const struct attribute_group dp_altmode_group = {
+static const struct attribute_group displayport_group = {
 	.name = "displayport",
-	.attrs = dp_altmode_attrs,
+	.attrs = displayport_attrs,
+};
+
+static const struct attribute_group *displayport_groups[] = {
+	&displayport_group,
+	NULL,
 };
 
 int dp_altmode_probe(struct typec_altmode *alt)
@@ -543,7 +548,6 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	const struct typec_altmode *port = typec_altmode_get_partner(alt);
 	struct fwnode_handle *fwnode;
 	struct dp_altmode *dp;
-	int ret;
 
 	/* FIXME: Port can only be DFP_U. */
 
@@ -554,10 +558,6 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	      DP_CAP_PIN_ASSIGN_DFP_D(alt->vdo)))
 		return -ENODEV;
 
-	ret = sysfs_create_group(&alt->dev.kobj, &dp_altmode_group);
-	if (ret)
-		return ret;
-
 	dp = devm_kzalloc(&alt->dev, sizeof(*dp), GFP_KERNEL);
 	if (!dp)
 		return -ENOMEM;
@@ -588,7 +588,6 @@ void dp_altmode_remove(struct typec_altmode *alt)
 {
 	struct dp_altmode *dp = typec_altmode_get_drvdata(alt);
 
-	sysfs_remove_group(&alt->dev.kobj, &dp_altmode_group);
 	cancel_work_sync(&dp->work);
 
 	if (dp->connector_fwnode) {
@@ -613,6 +612,7 @@ static struct typec_altmode_driver dp_altmode_driver = {
 	.driver = {
 		.name = "typec_displayport",
 		.owner = THIS_MODULE,
+		.dev_groups = displayport_groups,
 	},
 };
 module_typec_altmode_driver(dp_altmode_driver);
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index c37240a34899..a6ee9fae875a 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4019,7 +4019,7 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 	case SNK_TRY_WAIT_DEBOUNCE:
 		if (!tcpm_port_is_sink(port)) {
 			port->max_wait = 0;
-			tcpm_set_state(port, SRC_TRYWAIT, 0);
+			tcpm_set_state(port, SRC_TRYWAIT, PD_T_PD_DEBOUNCE);
 		}
 		break;
 	case SRC_TRY_WAIT:
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 4446c4066679..60c871fa58d6 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -270,6 +270,8 @@ void ucsi_displayport_remove_partner(struct typec_altmode *alt)
 	if (!dp)
 		return;
 
+	cancel_work_sync(&dp->work);
+
 	dp->data.conf = 0;
 	dp->data.status = 0;
 	dp->initialized = false;
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index fb6211efb5d8..dffdb5eb506b 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -573,6 +573,10 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 		    uc->has_multiple_dp) {
 			con_index = (uc->last_cmd_sent >> 16) &
 				    UCSI_CMD_CONNECTOR_MASK;
+			if (con_index == 0) {
+				ret = -EINVAL;
+				goto err_put;
+			}
 			con = &uc->ucsi->connector[con_index - 1];
 			ucsi_ccg_update_set_new_cam_cmd(uc, con, (u64 *)val);
 		}
@@ -587,6 +591,7 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 
 err_clear_bit:
 	clear_bit(DEV_CMD_PENDING, &uc->flags);
+err_put:
 	pm_runtime_put_sync(uc->dev);
 	mutex_unlock(&uc->lock);
 
diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 8e095b0982db..bb821b68f88c 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -59,12 +59,11 @@ static void bit_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 }
 
 static void bit_clear(struct vc_data *vc, struct fb_info *info, int sy,
-		      int sx, int height, int width)
+		      int sx, int height, int width, int fg, int bg)
 {
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	struct fb_fillrect region;
 
-	region.color = attr_bgcol_ec(bgshift, vc, info);
+	region.color = bg;
 	region.dx = sx * vc->vc_font.width;
 	region.dy = sy * vc->vc_font.height;
 	region.width = width * vc->vc_font.width;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 6d58c8a5cb44..080b615a5581 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1266,7 +1266,7 @@ static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_ops *ops = info->fbcon_par;
-
+	int fg, bg;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	u_int y_break;
 
@@ -1287,16 +1287,18 @@ static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
 		fbcon_clear_margins(vc, 0);
 	}
 
+	fg = get_color(vc, info, vc->vc_video_erase_char, 1);
+	bg = get_color(vc, info, vc->vc_video_erase_char, 0);
 	/* Split blits that cross physical y_wrap boundary */
 
 	y_break = p->vrows - p->yscroll;
 	if (sy < y_break && sy + height - 1 >= y_break) {
 		u_int b = y_break - sy;
-		ops->clear(vc, info, real_y(p, sy), sx, b, width);
+		ops->clear(vc, info, real_y(p, sy), sx, b, width, fg, bg);
 		ops->clear(vc, info, real_y(p, sy + b), sx, height - b,
-				 width);
+				 width, fg, bg);
 	} else
-		ops->clear(vc, info, real_y(p, sy), sx, height, width);
+		ops->clear(vc, info, real_y(p, sy), sx, height, width, fg, bg);
 }
 
 static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 0f16cbc99e6a..3e1ec454b8aa 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -57,7 +57,7 @@ struct fbcon_ops {
 	void (*bmove)(struct vc_data *vc, struct fb_info *info, int sy,
 		      int sx, int dy, int dx, int height, int width);
 	void (*clear)(struct vc_data *vc, struct fb_info *info, int sy,
-		      int sx, int height, int width);
+		      int sx, int height, int width, int fb, int bg);
 	void (*putcs)(struct vc_data *vc, struct fb_info *info,
 		      const unsigned short *s, int count, int yy, int xx,
 		      int fg, int bg);
@@ -118,42 +118,6 @@ static inline int mono_col(const struct fb_info *info)
 	return (~(0xfff << max_len)) & 0xff;
 }
 
-static inline int attr_col_ec(int shift, struct vc_data *vc,
-			      struct fb_info *info, int is_fg)
-{
-	int is_mono01;
-	int col;
-	int fg;
-	int bg;
-
-	if (!vc)
-		return 0;
-
-	if (vc->vc_can_do_color)
-		return is_fg ? attr_fgcol(shift,vc->vc_video_erase_char)
-			: attr_bgcol(shift,vc->vc_video_erase_char);
-
-	if (!info)
-		return 0;
-
-	col = mono_col(info);
-	is_mono01 = info->fix.visual == FB_VISUAL_MONO01;
-
-	if (attr_reverse(vc->vc_video_erase_char)) {
-		fg = is_mono01 ? col : 0;
-		bg = is_mono01 ? 0 : col;
-	}
-	else {
-		fg = is_mono01 ? 0 : col;
-		bg = is_mono01 ? col : 0;
-	}
-
-	return is_fg ? fg : bg;
-}
-
-#define attr_bgcol_ec(bgshift, vc, info) attr_col_ec(bgshift, vc, info, 0)
-#define attr_fgcol_ec(fgshift, vc, info) attr_col_ec(fgshift, vc, info, 1)
-
     /*
      *  Scroll Method
      */
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index f75b24c32d49..40c7d5793ccf 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -78,14 +78,13 @@ static void ccw_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 }
 
 static void ccw_clear(struct vc_data *vc, struct fb_info *info, int sy,
-		     int sx, int height, int width)
+		     int sx, int height, int width, int fg, int bg)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fb_fillrect region;
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	u32 vyres = GETVYRES(ops->p, info);
 
-	region.color = attr_bgcol_ec(bgshift,vc,info);
+	region.color = bg;
 	region.dx = sy * vc->vc_font.height;
 	region.dy = vyres - ((sx + width) * vc->vc_font.width);
 	region.height = width * vc->vc_font.width;
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index cf03dc62f35d..933e4ed52d39 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -63,14 +63,13 @@ static void cw_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 }
 
 static void cw_clear(struct vc_data *vc, struct fb_info *info, int sy,
-		     int sx, int height, int width)
+		     int sx, int height, int width, int fg, int bg)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fb_fillrect region;
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	u32 vxres = GETVXRES(ops->p, info);
 
-	region.color = attr_bgcol_ec(bgshift,vc,info);
+	region.color = bg;
 	region.dx = vxres - ((sy + height) * vc->vc_font.height);
 	region.dy = sx *  vc->vc_font.width;
 	region.height = width * vc->vc_font.width;
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index c5d2da731d68..abd23f37815f 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -64,15 +64,14 @@ static void ud_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 }
 
 static void ud_clear(struct vc_data *vc, struct fb_info *info, int sy,
-		     int sx, int height, int width)
+		     int sx, int height, int width, int fg, int bg)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fb_fillrect region;
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	u32 vyres = GETVYRES(ops->p, info);
 	u32 vxres = GETVXRES(ops->p, info);
 
-	region.color = attr_bgcol_ec(bgshift,vc,info);
+	region.color = bg;
 	region.dy = vyres - ((sy + height) * vc->vc_font.height);
 	region.dx = vxres - ((sx + width) *  vc->vc_font.width);
 	region.width = width * vc->vc_font.width;
diff --git a/drivers/video/fbdev/core/tileblit.c b/drivers/video/fbdev/core/tileblit.c
index 628fe5e010c0..ef20824e9c7b 100644
--- a/drivers/video/fbdev/core/tileblit.c
+++ b/drivers/video/fbdev/core/tileblit.c
@@ -33,16 +33,14 @@ static void tile_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 }
 
 static void tile_clear(struct vc_data *vc, struct fb_info *info, int sy,
-		       int sx, int height, int width)
+		       int sx, int height, int width, int fg, int bg)
 {
 	struct fb_tilerect rect;
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
-	int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
 
 	rect.index = vc->vc_video_erase_char &
 		((vc->vc_hi_font_mask) ? 0x1ff : 0xff);
-	rect.fg = attr_fgcol_ec(fgshift, vc, info);
-	rect.bg = attr_bgcol_ec(bgshift, vc, info);
+	rect.fg = fg;
+	rect.bg = bg;
 	rect.sx = sx;
 	rect.sy = sy;
 	rect.width = width;
@@ -77,7 +75,42 @@ static void tile_putcs(struct vc_data *vc, struct fb_info *info,
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
index 5d564e8670c5..6f2606932867 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1830,6 +1830,7 @@ static int fsl_diu_remove(struct platform_device *pdev)
 	int i;
 
 	data = dev_get_drvdata(&pdev->dev);
+	device_remove_file(&pdev->dev, &data->dev_attr);
 	disable_lcdc(&data->fsl_diu_info[0]);
 
 	free_irq(data->irq, data->diu_reg);
diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index 804d8f4d0e73..e7a95f7926c4 100644
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
index 000d02ea4f7d..d8efb8ea23a0 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -87,19 +87,21 @@ static inline dma_addr_t xen_virt_to_bus(struct device *dev, void *address)
 	return xen_phys_to_dma(dev, virt_to_phys(address));
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
@@ -321,7 +323,8 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 	phys = dma_to_phys(hwdev, *dma_handle);
 	dev_addr = xen_phys_to_dma(hwdev, phys);
 	if (((dev_addr + size - 1 <= dma_mask)) &&
-	    !range_straddles_page_boundary(phys, size))
+	    !range_straddles_page_boundary(phys, size) &&
+	    !range_requires_alignment(phys, size))
 		*dma_handle = dev_addr;
 	else {
 		if (xen_create_contiguous_region(phys, order,
@@ -362,6 +365,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 
 	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
 		     range_straddles_page_boundary(phys, size)) &&
+	    !range_requires_alignment(phys, size) &&
 	    TestClearPageXenRemapped(page))
 		xen_destroy_contiguous_region(phys, order);
 
diff --git a/drivers/xen/xenbus/xenbus.h b/drivers/xen/xenbus/xenbus.h
index 2a93b7c9c159..f1576988a28a 100644
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
index 743795d402cb..fb5358a73820 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -864,9 +864,15 @@ static int __init xenbus_init(void)
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
@@ -885,10 +891,6 @@ static int __init xenbus_init(void)
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
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index cf2b65be04b5..d652d4091b2b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -174,6 +174,14 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			ei = btrfs_item_ptr(leaf, path->slots[0],
 					    struct btrfs_extent_item);
 			num_refs = btrfs_extent_refs(leaf, ei);
+			if (unlikely(num_refs == 0)) {
+				ret = -EUCLEAN;
+				btrfs_err(fs_info,
+			"unexpected zero reference count for extent item (%llu %u %llu)",
+					  key.objectid, key.type, key.offset);
+				btrfs_abort_transaction(trans, ret);
+				goto out_free;
+			}
 			extent_flags = btrfs_extent_flags(leaf, ei);
 		} else {
 			ret = -EINVAL;
@@ -185,8 +193,6 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 
 			goto out_free;
 		}
-
-		BUG_ON(num_refs == 0);
 	} else {
 		num_refs = 0;
 		extent_flags = 0;
@@ -216,10 +222,19 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 			goto search_again;
 		}
 		spin_lock(&head->lock);
-		if (head->extent_op && head->extent_op->update_flags)
+		if (head->extent_op && head->extent_op->update_flags) {
 			extent_flags |= head->extent_op->flags_to_set;
-		else
-			BUG_ON(num_refs == 0);
+		} else if (unlikely(num_refs == 0)) {
+			spin_unlock(&head->lock);
+			mutex_unlock(&head->mutex);
+			spin_unlock(&delayed_refs->lock);
+			ret = -EUCLEAN;
+			btrfs_err(fs_info,
+			  "unexpected zero reference count for extent %llu (%s)",
+				  bytenr, metadata ? "metadata" : "data");
+			btrfs_abort_transaction(trans, ret);
+			goto out_free;
+		}
 
 		num_refs += head->ref_mod;
 		spin_unlock(&head->lock);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9cef930c4ecf..8498994ef5c6 100644
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
index a9e72f42e91e..3e7bb24eb227 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -390,10 +390,8 @@ static int fs_path_ensure_buf(struct fs_path *p, int len)
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
index 799be3a5d25e..9e62d75f2465 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -755,7 +755,10 @@ find_cifs_entry(const unsigned int xid, struct cifs_tcon *tcon, loff_t pos,
 			else
 				cifs_buf_release(cfile->srch_inf.
 						ntwrk_buf_start);
+			/* Reset all pointers to the network buffer to prevent stale references */
 			cfile->srch_inf.ntwrk_buf_start = NULL;
+			cfile->srch_inf.srch_entries_start = NULL;
+			cfile->srch_inf.last_entry = NULL;
 		}
 		rc = initiate_cifs_search(xid, file, full_path);
 		if (rc) {
@@ -778,11 +781,11 @@ find_cifs_entry(const unsigned int xid, struct cifs_tcon *tcon, loff_t pos,
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
index 7b085975ea16..7e5ac34112bd 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -42,6 +42,7 @@
 #include <linux/path.h>
 #include <linux/timekeeping.h>
 #include <linux/elf.h>
+#include <uapi/linux/pidfd.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -56,6 +57,13 @@
 static bool dump_vma_snapshot(struct coredump_params *cprm);
 static void free_vma_snapshot(struct coredump_params *cprm);
 
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
@@ -327,6 +335,27 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
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
@@ -550,7 +579,7 @@ static void wait_for_dump_helpers(struct file *file)
 }
 
 /*
- * umh_pipe_setup
+ * umh_coredump_setup
  * helper function to customize the process used
  * to collect the core in userspace.  Specifically
  * it sets up a pipe and installs it as fd 0 (stdin)
@@ -560,21 +589,61 @@ static void wait_for_dump_helpers(struct file *file)
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
 
@@ -651,7 +720,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 
 		if (cprm.limit == 1) {
-			/* See umh_pipe_setup() which sets RLIMIT_CORE = 1.
+			/* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
 			 *
 			 * Normally core limits are irrelevant to pipes, since
 			 * we're not writing to the file system, but we use
@@ -696,7 +765,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		retval = -ENOMEM;
 		sub_info = call_usermodehelper_setup(helper_argv[0],
 						helper_argv, NULL, GFP_KERNEL,
-						umh_pipe_setup, NULL, &cprm);
+						umh_coredump_setup, NULL, &cprm);
 		if (sub_info)
 			retval = call_usermodehelper_exec(sub_info,
 							  UMH_WAIT_EXEC);
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index bdbf130416c7..be267cd9dea7 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -637,8 +637,8 @@ static int ext4_has_free_clusters(struct ext4_sb_info *sbi,
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
index 2f97112657ad..869cc6e06d88 100644
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
@@ -1638,6 +1634,7 @@ static int do_umount(struct mount *mnt, int flags)
 			umount_tree(mnt, UMOUNT_PROPAGATE);
 		retval = 0;
 	} else {
+		smp_mb(); // paired with __legitimize_mnt()
 		shrink_submounts(mnt);
 		retval = -EBUSY;
 		if (!propagate_mount_busy(mnt, 2)) {
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index dbed8d44d805..f3bb987e9dba 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -297,7 +297,8 @@ nfs_start_delegation_return_locked(struct nfs_inode *nfsi)
 	if (delegation == NULL)
 		goto out;
 	spin_lock(&delegation->lock);
-	if (!test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
+	if (delegation->inode &&
+	    !test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
 		clear_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
 		/* Refcount matched in nfs_end_delegation_return() */
 		ret = nfs_get_delegation(delegation);
diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index 86c3f7e69ec4..e6bf55e37521 100644
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
index 1af0b8ad83f2..ce9c2d1f54ae 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1260,6 +1260,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -ECONNRESET:
 		case -EHOSTDOWN:
 		case -EHOSTUNREACH:
+		case -ENETDOWN:
 		case -ENETUNREACH:
 		case -EADDRINUSE:
 		case -ENOBUFS:
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index bfa7202ca7be..4b0cdddce6eb 100644
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
index ac3fab214df1..1005ecf7c250 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6732,10 +6732,18 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
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
@@ -6743,7 +6751,6 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
 	p->lsp = lsp;
 	/* Ensure we don't close file until we're done freeing locks! */
 	p->ctx = get_nfs_open_context(ctx);
-	p->l_ctx = nfs_get_lock_context(ctx);
 	locks_init_lock(&p->fl);
 	locks_copy_lock(&p->fl, fl);
 	p->server = NFS_SERVER(inode);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 807dd6f17e1b..e3cabced1aea 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2719,7 +2719,15 @@ static void nfs4_state_manager(struct nfs_client *clp)
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
index 39ac4824b97d..1800836306a5 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -733,6 +733,14 @@ pnfs_mark_matching_lsegs_invalid(struct pnfs_layout_hdr *lo,
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
@@ -1183,6 +1191,7 @@ void pnfs_layoutreturn_free_lsegs(struct pnfs_layout_hdr *lo,
 		pnfs_mark_matching_lsegs_invalid(lo, &freeme, range, seq);
 		pnfs_free_returned_lsegs(lo, &freeme, range, seq);
 		pnfs_set_layout_stateid(lo, stateid, NULL, true);
+		pnfs_reset_return_info(lo);
 	} else
 		pnfs_mark_layout_stateid_invalid(lo, &freeme);
 out_unlock:
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index a7cf84a6673b..f88b0cf00f21 100644
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
@@ -405,7 +406,8 @@ int pnfs_generic_commit_pagelist(struct inode *inode,
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
index a2ad8bb87e2d..461c00c1338c 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -651,12 +651,12 @@ _same_data_server_addrs_locked(const struct list_head *dsaddrs1,
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
@@ -749,7 +749,7 @@ nfs4_pnfs_remotestr(struct list_head *dsaddrs, gfp_t gfp_flags)
  * uncached and return cached struct nfs4_pnfs_ds.
  */
 struct nfs4_pnfs_ds *
-nfs4_pnfs_ds_add(struct list_head *dsaddrs, gfp_t gfp_flags)
+nfs4_pnfs_ds_add(const struct net *net, struct list_head *dsaddrs, gfp_t gfp_flags)
 {
 	struct nfs4_pnfs_ds *tmp_ds, *ds = NULL;
 	char *remotestr;
@@ -767,13 +767,14 @@ nfs4_pnfs_ds_add(struct list_head *dsaddrs, gfp_t gfp_flags)
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
index c319495988b6..02a1d2e99af1 100644
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
@@ -1412,6 +1434,18 @@ static int __ocfs2_recovery_thread(void *arg)
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
@@ -1509,13 +1543,13 @@ static int __ocfs2_recovery_thread(void *arg)
 
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
@@ -1525,14 +1559,16 @@ static int __ocfs2_recovery_thread(void *arg)
 
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
index bc5d77cb3c50..141182422eab 100644
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
index 1c59eca29b22..41ecdfa9b31e 100644
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
index 48f0547d4850..cd70ded309e4 100644
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
 
@@ -93,8 +93,7 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 	struct orangefs_write_range *wrp, wr;
 	struct iov_iter iter;
 	ssize_t ret;
-	size_t len;
-	loff_t off;
+	loff_t len, off;
 	int i;
 
 	len = i_size_read(inode);
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index d07c851d255b..4a245d79ba6b 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -332,8 +332,27 @@ struct drm_atomic_state {
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
index c26ce73dcb08..2218121cf8f2 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -89,6 +89,7 @@ struct coredump_params {
 	int vma_count;
 	size_t vma_data_size;
 	struct core_vma_metadata *vma_meta;
+	struct pid *pid;
 };
 
 /*
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a7d70cdee25e..fb48f8ba5dcc 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -568,10 +568,14 @@ static inline int dma_mmap_wc(struct device *dev,
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
 
 /*
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index d758c131ed5e..89b3527e0367 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -189,6 +189,7 @@ struct inet6_cork {
 	struct ipv6_txoptions *opt;
 	u8 hop_limit;
 	u8 tclass;
+	u8 dontfrag:1;
 };
 
 /**
diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index eb8169c03d89..0eb04d537038 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -1116,7 +1116,7 @@ int mlx4_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
 int mlx4_buf_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
 		       struct mlx4_buf *buf);
 
-int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order);
+int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned int order);
 void mlx4_db_free(struct mlx4_dev *dev, struct mlx4_db *db);
 
 int mlx4_alloc_hwq_res(struct mlx4_dev *dev, struct mlx4_hwq_resources *wqres,
diff --git a/include/linux/pid.h b/include/linux/pid.h
index af308e15f174..f47868537209 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -79,6 +79,7 @@ struct file;
 extern struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 int pidfd_create(struct pid *pid, unsigned int flags);
+int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 9db6710e6ee7..9b3e01db654e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -987,6 +987,9 @@ do {									\
 #define kvfree_rcu(...) KVFREE_GET_MACRO(__VA_ARGS__,		\
 	kvfree_rcu_arg_2, kvfree_rcu_arg_1)(__VA_ARGS__)
 
+#define kvfree_rcu_mightsleep(ptr) kvfree_rcu_arg_1(ptr)
+#define kfree_rcu_mightsleep(ptr) kvfree_rcu_mightsleep(ptr)
+
 #define KVFREE_GET_MACRO(_1, _2, NAME, ...) NAME
 #define kvfree_rcu_arg_2(ptr, rhf) kfree_rcu(ptr, rhf)
 #define kvfree_rcu_arg_1(ptr)					\
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 59eb5cd567d7..92f04fcb8947 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -64,7 +64,7 @@ extern int rcu_scheduler_active __read_mostly;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 95c3069823f9..7868e847eee0 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -174,7 +174,7 @@ enum tpm2_const {
 
 enum tpm2_timeouts {
 	TPM2_TIMEOUT_A          =    750,
-	TPM2_TIMEOUT_B          =   2000,
+	TPM2_TIMEOUT_B          =   4000,
 	TPM2_TIMEOUT_C          =    200,
 	TPM2_TIMEOUT_D          =     30,
 	TPM2_DURATION_SHORT     =     20,
diff --git a/include/linux/types.h b/include/linux/types.h
index a147977602b5..cb496d6a8d79 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -109,8 +109,9 @@ typedef u64			u_int64_t;
 typedef s64			int64_t;
 #endif
 
-/* this is a special 64bit data type that is 8-byte aligned */
+/* These are the special 64-bit data types that are 8-byte aligned */
 #define aligned_u64		__aligned_u64
+#define aligned_s64		__aligned_s64
 #define aligned_be64		__aligned_be64
 #define aligned_le64		__aligned_le64
 
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 73150520c02d..ffc6d122f91e 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -676,7 +676,9 @@ struct v4l2_subdev_pad_config {
  *		     possible configuration from the remote end, likely calling
  *		     this operation as close as possible to stream on time. The
  *		     operation shall fail if the pad index it has been called on
- *		     is not valid or in case of unrecoverable failures.
+ *		     is not valid or in case of unrecoverable failures. The
+ *		     config argument has been memset to 0 just before calling
+ *		     the op.
  *
  * @set_mbus_config: set the media bus configuration of a remote sub-device.
  *		     This operations is intended to allow, in combination with
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index cb13e604dc34..25dd157728a3 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1018,7 +1018,7 @@ static inline bool nft_chain_is_bound(struct nft_chain *chain)
 
 int nft_chain_add(struct nft_table *table, struct nft_chain *chain);
 void nft_chain_del(struct nft_chain *chain);
-void nf_tables_chain_destroy(struct nft_ctx *ctx);
+void nf_tables_chain_destroy(struct nft_chain *chain);
 
 struct nft_stats {
 	u64			bytes;
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 4db11c4695cf..a4c670ad8c4a 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1036,6 +1036,21 @@ static inline struct sk_buff *__qdisc_dequeue_head(struct qdisc_skb_head *qh)
 	return skb;
 }
 
+static inline struct sk_buff *qdisc_dequeue_internal(struct Qdisc *sch, bool direct)
+{
+	struct sk_buff *skb;
+
+	skb = __skb_dequeue(&sch->gso_skb);
+	if (skb) {
+		sch->q.qlen--;
+		return skb;
+	}
+	if (direct)
+		return __qdisc_dequeue_head(&sch->q);
+	else
+		return sch->dequeue(sch);
+}
+
 static inline struct sk_buff *qdisc_dequeue_head(struct Qdisc *sch)
 {
 	struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 6554a9f71c62..c573c6a7da12 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1334,6 +1334,8 @@ int snd_pcm_lib_mmap_iomem(struct snd_pcm_substream *substream, struct vm_area_s
 #define snd_pcm_lib_mmap_iomem	NULL
 #endif
 
+void snd_pcm_runtime_buffer_set_silence(struct snd_pcm_runtime *runtime);
+
 /**
  * snd_pcm_limit_isa_dma_size - Get the max size fitting with ISA DMA transfer
  * @dma: DMA number
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 041be3ce1071..d8aa1d357024 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1788,7 +1788,7 @@ DECLARE_EVENT_CLASS(btrfs__prelim_ref,
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
 		 const struct prelim_ref *oldref,
 		 const struct prelim_ref *newref, u64 tree_size),
-	TP_ARGS(fs_info, newref, oldref, tree_size),
+	TP_ARGS(fs_info, oldref, newref, tree_size),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,  root_id		)
diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
index f6d2f83cbe29..aa96c4589b71 100644
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
index efeb0b742750..37d7a99be8f0 100644
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
index 8b8a5a172b15..6ece27056fe9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1820,6 +1820,91 @@ const struct file_operations pidfd_fops = {
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
@@ -2153,21 +2238,12 @@ static __latent_entropy struct task_struct *copy_process(
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
diff --git a/kernel/padata.c b/kernel/padata.c
index c7aa60907fdf..1bd61add0915 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -363,7 +363,8 @@ static void padata_reorder(struct parallel_data *pd)
 		 * To avoid UAF issue, add pd ref here, and put pd ref after reorder_work finish.
 		 */
 		padata_get_pd(pd);
-		queue_work(pinst->serial_wq, &pd->reorder_work);
+		if (!queue_work(pinst->serial_wq, &pd->reorder_work))
+			padata_put_pd(pd);
 	}
 }
 
diff --git a/kernel/params.c b/kernel/params.c
index eb00abef7076..0df4a315760d 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -947,7 +947,9 @@ int module_sysfs_initialized;
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
index f5ba0740f9b5..c07a84197173 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -919,13 +919,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
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
index 29569b1c3d8c..3a68c650ff2a 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -161,6 +161,7 @@ static int posix_timer_add(struct k_itimer *timer)
 			return id;
 		}
 		spin_unlock(&hash_lock);
+		cond_resched();
 	}
 	/* POSIX return code when no timer ID could be allocated */
 	return -EAGAIN;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ca39a647f2ef..d63d388acffc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6685,13 +6685,14 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
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
index fde0aa244148..a75a9ca46b59 100644
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
index 14f26b3b0204..142b4d5e08fe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1312,7 +1312,6 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 {
 	struct mem_cgroup *iter;
 	int ret = 0;
-	int i = 0;
 
 	BUG_ON(memcg == root_mem_cgroup);
 
@@ -1322,10 +1321,9 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 
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
index 4675a8df0ec9..59e1fcc05566 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4758,6 +4758,14 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
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
index 2b88b17cc8b2..259b43b435a9 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -400,6 +400,7 @@ struct net_bridge {
 		struct rtable		fake_rtable;
 		struct rt6_info		fake_rt6_info;
 	};
+	u32				metrics[RTAX_MAX];
 #endif
 	u16				group_fwd_mask;
 	u16				group_fwd_mask_required;
diff --git a/net/can/bcm.c b/net/can/bcm.c
index cb849b5a8c14..200b66e85c1c 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -58,6 +58,7 @@
 #include <linux/can/skb.h>
 #include <linux/can/bcm.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
@@ -120,6 +121,7 @@ struct bcm_op {
 	struct canfd_frame last_sframe;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
+	spinlock_t bcm_tx_lock; /* protect currframe/count in runtime updates */
 };
 
 struct bcm_sock {
@@ -205,7 +207,9 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 	seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifindex));
 	seq_printf(m, " <<<\n");
 
-	list_for_each_entry(op, &bo->rx_ops, list) {
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
 
 		unsigned long reduction;
 
@@ -261,6 +265,9 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 		seq_printf(m, "# sent %ld\n", op->frames_abs);
 	}
 	seq_putc(m, '\n');
+
+	rcu_read_unlock();
+
 	return 0;
 }
 #endif /* CONFIG_PROC_FS */
@@ -273,13 +280,18 @@ static void bcm_can_tx(struct bcm_op *op)
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
@@ -300,6 +312,10 @@ static void bcm_can_tx(struct bcm_op *op)
 	skb->dev = dev;
 	can_skb_set_owner(skb, op->sk);
 	err = can_send(skb, 1);
+
+	/* update currframe and count under lock protection */
+	spin_lock_bh(&op->bcm_tx_lock);
+
 	if (!err)
 		op->frames_abs++;
 
@@ -308,6 +324,11 @@ static void bcm_can_tx(struct bcm_op *op)
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
@@ -404,7 +425,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 	struct bcm_msg_head msg_head;
 
 	if (op->kt_ival1 && (op->count > 0)) {
-		op->count--;
+		bcm_can_tx(op);
 		if (!op->count && (op->flags & TX_COUNTEVT)) {
 
 			/* create notification to user */
@@ -419,7 +440,6 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 
 			bcm_send_to_user(op, &msg_head, NULL, 0);
 		}
-		bcm_can_tx(op);
 
 	} else if (op->kt_ival2) {
 		bcm_can_tx(op);
@@ -796,7 +816,7 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 						  REGMASK(op->can_id),
 						  bcm_rx_handler, op);
 
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return 1; /* done */
 		}
@@ -816,7 +836,7 @@ static int bcm_delete_tx_op(struct list_head *ops, struct bcm_msg_head *mh,
 	list_for_each_entry_safe(op, n, ops, list) {
 		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex) &&
 		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME)) {
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return 1; /* done */
 		}
@@ -909,6 +929,27 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
 
@@ -916,9 +957,14 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -977,22 +1023,8 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
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
@@ -1009,11 +1041,8 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
@@ -1229,7 +1258,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 					      bcm_rx_handler, op, "bcm", sk);
 		if (err) {
 			/* this bcm rx op is broken -> remove it */
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return err;
 		}
diff --git a/net/can/gw.c b/net/can/gw.c
index cbb46d3aa963..59b9f3e579f7 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -130,7 +130,7 @@ struct cgw_job {
 	u32 handled_frames;
 	u32 dropped_frames;
 	u32 deleted_frames;
-	struct cf_mod mod;
+	struct cf_mod __rcu *cf_mod;
 	union {
 		/* CAN frame data source */
 		struct net_device *dev;
@@ -397,6 +397,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	struct cgw_job *gwj = (struct cgw_job *)data;
 	struct canfd_frame *cf;
 	struct sk_buff *nskb;
+	struct cf_mod *mod;
 	int modidx = 0;
 
 	/* process strictly Classic CAN or CAN FD frames */
@@ -444,7 +445,8 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	 * When there is at least one modification function activated,
 	 * we need to copy the skb as we want to modify skb->data.
 	 */
-	if (gwj->mod.modfunc[0])
+	mod = rcu_dereference(gwj->cf_mod);
+	if (mod->modfunc[0])
 		nskb = skb_copy(skb, GFP_ATOMIC);
 	else
 		nskb = skb_clone(skb, GFP_ATOMIC);
@@ -467,8 +469,8 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	cf = (struct canfd_frame *)nskb->data;
 
 	/* perform preprocessed modification functions if there are any */
-	while (modidx < MAX_MODFUNCTIONS && gwj->mod.modfunc[modidx])
-		(*gwj->mod.modfunc[modidx++])(cf, &gwj->mod);
+	while (modidx < MAX_MODFUNCTIONS && mod->modfunc[modidx])
+		(*mod->modfunc[modidx++])(cf, mod);
 
 	/* Has the CAN frame been modified? */
 	if (modidx) {
@@ -484,11 +486,11 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		}
 
 		/* check for checksum updates */
-		if (gwj->mod.csumfunc.crc8)
-			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
+		if (mod->csumfunc.crc8)
+			(*mod->csumfunc.crc8)(cf, &mod->csum.crc8);
 
-		if (gwj->mod.csumfunc.xor)
-			(*gwj->mod.csumfunc.xor)(cf, &gwj->mod.csum.xor);
+		if (mod->csumfunc.xor)
+			(*mod->csumfunc.xor)(cf, &mod->csum.xor);
 	}
 
 	/* clear the skb timestamp if not configured the other way */
@@ -515,6 +517,24 @@ static inline void cgw_unregister_filter(struct net *net, struct cgw_job *gwj)
 			  gwj->ccgw.filter.can_mask, can_can_gw_rcv, gwj);
 }
 
+static void cgw_job_free_rcu(struct rcu_head *rcu_head)
+{
+	struct cgw_job *gwj = container_of(rcu_head, struct cgw_job, rcu);
+
+	/* cgw_job::cf_mod is always accessed from the same cgw_job object within
+	 * the same RCU read section. Once cgw_job is scheduled for removal,
+	 * cf_mod can also be removed without mandating an additional grace period.
+	 */
+	kfree(rcu_access_pointer(gwj->cf_mod));
+	kmem_cache_free(cgw_cache, gwj);
+}
+
+/* Return cgw_job::cf_mod with RTNL protected section */
+static struct cf_mod *cgw_job_cf_mod(struct cgw_job *gwj)
+{
+	return rcu_dereference_protected(gwj->cf_mod, rtnl_is_locked());
+}
+
 static int cgw_notifier(struct notifier_block *nb,
 			unsigned long msg, void *ptr)
 {
@@ -534,8 +554,7 @@ static int cgw_notifier(struct notifier_block *nb,
 			if (gwj->src.dev == dev || gwj->dst.dev == dev) {
 				hlist_del(&gwj->list);
 				cgw_unregister_filter(net, gwj);
-				synchronize_rcu();
-				kmem_cache_free(cgw_cache, gwj);
+				call_rcu(&gwj->rcu, cgw_job_free_rcu);
 			}
 		}
 	}
@@ -548,6 +567,7 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 {
 	struct rtcanmsg *rtcan;
 	struct nlmsghdr *nlh;
+	struct cf_mod *mod;
 
 	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*rtcan), flags);
 	if (!nlh)
@@ -582,82 +602,83 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 			goto cancel;
 	}
 
+	mod = cgw_job_cf_mod(gwj);
 	if (gwj->flags & CGW_FLAGS_CAN_FD) {
 		struct cgw_fdframe_mod mb;
 
-		if (gwj->mod.modtype.and) {
-			memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.and;
+		if (mod->modtype.and) {
+			memcpy(&mb.cf, &mod->modframe.and, sizeof(mb.cf));
+			mb.modtype = mod->modtype.and;
 			if (nla_put(skb, CGW_FDMOD_AND, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.or) {
-			memcpy(&mb.cf, &gwj->mod.modframe.or, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.or;
+		if (mod->modtype.or) {
+			memcpy(&mb.cf, &mod->modframe.or, sizeof(mb.cf));
+			mb.modtype = mod->modtype.or;
 			if (nla_put(skb, CGW_FDMOD_OR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.xor) {
-			memcpy(&mb.cf, &gwj->mod.modframe.xor, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.xor;
+		if (mod->modtype.xor) {
+			memcpy(&mb.cf, &mod->modframe.xor, sizeof(mb.cf));
+			mb.modtype = mod->modtype.xor;
 			if (nla_put(skb, CGW_FDMOD_XOR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.set) {
-			memcpy(&mb.cf, &gwj->mod.modframe.set, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.set;
+		if (mod->modtype.set) {
+			memcpy(&mb.cf, &mod->modframe.set, sizeof(mb.cf));
+			mb.modtype = mod->modtype.set;
 			if (nla_put(skb, CGW_FDMOD_SET, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 	} else {
 		struct cgw_frame_mod mb;
 
-		if (gwj->mod.modtype.and) {
-			memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.and;
+		if (mod->modtype.and) {
+			memcpy(&mb.cf, &mod->modframe.and, sizeof(mb.cf));
+			mb.modtype = mod->modtype.and;
 			if (nla_put(skb, CGW_MOD_AND, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.or) {
-			memcpy(&mb.cf, &gwj->mod.modframe.or, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.or;
+		if (mod->modtype.or) {
+			memcpy(&mb.cf, &mod->modframe.or, sizeof(mb.cf));
+			mb.modtype = mod->modtype.or;
 			if (nla_put(skb, CGW_MOD_OR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.xor) {
-			memcpy(&mb.cf, &gwj->mod.modframe.xor, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.xor;
+		if (mod->modtype.xor) {
+			memcpy(&mb.cf, &mod->modframe.xor, sizeof(mb.cf));
+			mb.modtype = mod->modtype.xor;
 			if (nla_put(skb, CGW_MOD_XOR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.set) {
-			memcpy(&mb.cf, &gwj->mod.modframe.set, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.set;
+		if (mod->modtype.set) {
+			memcpy(&mb.cf, &mod->modframe.set, sizeof(mb.cf));
+			mb.modtype = mod->modtype.set;
 			if (nla_put(skb, CGW_MOD_SET, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 	}
 
-	if (gwj->mod.uid) {
-		if (nla_put_u32(skb, CGW_MOD_UID, gwj->mod.uid) < 0)
+	if (mod->uid) {
+		if (nla_put_u32(skb, CGW_MOD_UID, mod->uid) < 0)
 			goto cancel;
 	}
 
-	if (gwj->mod.csumfunc.crc8) {
+	if (mod->csumfunc.crc8) {
 		if (nla_put(skb, CGW_CS_CRC8, CGW_CS_CRC8_LEN,
-			    &gwj->mod.csum.crc8) < 0)
+			    &mod->csum.crc8) < 0)
 			goto cancel;
 	}
 
-	if (gwj->mod.csumfunc.xor) {
+	if (mod->csumfunc.xor) {
 		if (nla_put(skb, CGW_CS_XOR, CGW_CS_XOR_LEN,
-			    &gwj->mod.csum.xor) < 0)
+			    &mod->csum.xor) < 0)
 			goto cancel;
 	}
 
@@ -991,7 +1012,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct rtcanmsg *r;
 	struct cgw_job *gwj;
-	struct cf_mod mod;
+	struct cf_mod *mod;
 	struct can_can_gw ccgw;
 	u8 limhops = 0;
 	int err = 0;
@@ -1010,37 +1031,48 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (r->gwtype != CGW_TYPE_CAN_CAN)
 		return -EINVAL;
 
-	err = cgw_parse_attr(nlh, &mod, CGW_TYPE_CAN_CAN, &ccgw, &limhops);
+	mod = kmalloc(sizeof(*mod), GFP_KERNEL);
+	if (!mod)
+		return -ENOMEM;
+
+	err = cgw_parse_attr(nlh, mod, CGW_TYPE_CAN_CAN, &ccgw, &limhops);
 	if (err < 0)
-		return err;
+		goto out_free_cf;
 
-	if (mod.uid) {
+	if (mod->uid) {
 		ASSERT_RTNL();
 
 		/* check for updating an existing job with identical uid */
 		hlist_for_each_entry(gwj, &net->can.cgw_list, list) {
-			if (gwj->mod.uid != mod.uid)
+			struct cf_mod *old_cf;
+
+			old_cf = cgw_job_cf_mod(gwj);
+			if (old_cf->uid != mod->uid)
 				continue;
 
 			/* interfaces & filters must be identical */
-			if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw)))
-				return -EINVAL;
+			if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw))) {
+				err = -EINVAL;
+				goto out_free_cf;
+			}
 
-			/* update modifications with disabled softirq & quit */
-			local_bh_disable();
-			memcpy(&gwj->mod, &mod, sizeof(mod));
-			local_bh_enable();
+			rcu_assign_pointer(gwj->cf_mod, mod);
+			kfree_rcu_mightsleep(old_cf);
 			return 0;
 		}
 	}
 
 	/* ifindex == 0 is not allowed for job creation */
-	if (!ccgw.src_idx || !ccgw.dst_idx)
-		return -ENODEV;
+	if (!ccgw.src_idx || !ccgw.dst_idx) {
+		err = -ENODEV;
+		goto out_free_cf;
+	}
 
 	gwj = kmem_cache_alloc(cgw_cache, GFP_KERNEL);
-	if (!gwj)
-		return -ENOMEM;
+	if (!gwj) {
+		err = -ENOMEM;
+		goto out_free_cf;
+	}
 
 	gwj->handled_frames = 0;
 	gwj->dropped_frames = 0;
@@ -1050,7 +1082,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	gwj->limit_hops = limhops;
 
 	/* insert already parsed information */
-	memcpy(&gwj->mod, &mod, sizeof(mod));
+	RCU_INIT_POINTER(gwj->cf_mod, mod);
 	memcpy(&gwj->ccgw, &ccgw, sizeof(ccgw));
 
 	err = -ENODEV;
@@ -1077,9 +1109,11 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (!err)
 		hlist_add_head_rcu(&gwj->list, &net->can.cgw_list);
 out:
-	if (err)
+	if (err) {
 		kmem_cache_free(cgw_cache, gwj);
-
+out_free_cf:
+		kfree(mod);
+	}
 	return err;
 }
 
@@ -1093,8 +1127,7 @@ static void cgw_remove_all_jobs(struct net *net)
 	hlist_for_each_entry_safe(gwj, nx, &net->can.cgw_list, list) {
 		hlist_del(&gwj->list);
 		cgw_unregister_filter(net, gwj);
-		synchronize_rcu();
-		kmem_cache_free(cgw_cache, gwj);
+		call_rcu(&gwj->rcu, cgw_job_free_rcu);
 	}
 }
 
@@ -1140,19 +1173,22 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	/* remove only the first matching entry */
 	hlist_for_each_entry_safe(gwj, nx, &net->can.cgw_list, list) {
+		struct cf_mod *cf_mod;
+
 		if (gwj->flags != r->flags)
 			continue;
 
 		if (gwj->limit_hops != limhops)
 			continue;
 
+		cf_mod = cgw_job_cf_mod(gwj);
 		/* we have a match when uid is enabled and identical */
-		if (gwj->mod.uid || mod.uid) {
-			if (gwj->mod.uid != mod.uid)
+		if (cf_mod->uid || mod.uid) {
+			if (cf_mod->uid != mod.uid)
 				continue;
 		} else {
 			/* no uid => check for identical modifications */
-			if (memcmp(&gwj->mod, &mod, sizeof(mod)))
+			if (memcmp(cf_mod, &mod, sizeof(mod)))
 				continue;
 		}
 
@@ -1162,8 +1198,7 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 		hlist_del(&gwj->list);
 		cgw_unregister_filter(net, gwj);
-		synchronize_rcu();
-		kmem_cache_free(cgw_cache, gwj);
+		call_rcu(&gwj->rcu, cgw_job_free_rcu);
 		err = 0;
 		break;
 	}
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index c1e3d3bea128..57502e862846 100644
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
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 5e2a003cd83c..f902cd8cb852 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -817,19 +817,33 @@ static int rtm_to_fib_config(struct net *net, struct sk_buff *skb,
 		}
 	}
 
+	if (cfg->fc_dst_len > 32) {
+		NL_SET_ERR_MSG(extack, "Invalid prefix length");
+		err = -EINVAL;
+		goto errout;
+	}
+
+	if (cfg->fc_dst_len < 32 && (ntohl(cfg->fc_dst) << cfg->fc_dst_len)) {
+		NL_SET_ERR_MSG(extack, "Invalid prefix for given prefix length");
+		err = -EINVAL;
+		goto errout;
+	}
+
 	if (cfg->fc_nh_id) {
 		if (cfg->fc_oif || cfg->fc_gw_family ||
 		    cfg->fc_encap || cfg->fc_mp) {
 			NL_SET_ERR_MSG(extack,
 				       "Nexthop specification and nexthop id are mutually exclusive");
-			return -EINVAL;
+			err = -EINVAL;
+			goto errout;
 		}
 	}
 
 	if (has_gw && has_via) {
 		NL_SET_ERR_MSG(extack,
 			       "Nexthop configuration can not contain both GATEWAY and VIA");
-		return -EINVAL;
+		err = -EINVAL;
+		goto errout;
 	}
 
 	if (!cfg->fc_table)
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index d279cb8ac158..a270951386e1 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -226,9 +226,9 @@ static int fib4_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
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
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 1bdcdc79d43f..6c53381fa36f 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1145,22 +1145,6 @@ static int fib_insert_alias(struct trie *t, struct key_vector *tp,
 	return 0;
 }
 
-static bool fib_valid_key_len(u32 key, u8 plen, struct netlink_ext_ack *extack)
-{
-	if (plen > KEYLENGTH) {
-		NL_SET_ERR_MSG(extack, "Invalid prefix length");
-		return false;
-	}
-
-	if ((plen < KEYLENGTH) && (key << plen)) {
-		NL_SET_ERR_MSG(extack,
-			       "Invalid prefix for given prefix length");
-		return false;
-	}
-
-	return true;
-}
-
 static void fib_remove_alias(struct trie *t, struct key_vector *tp,
 			     struct key_vector *l, struct fib_alias *old);
 
@@ -1181,9 +1165,6 @@ int fib_table_insert(struct net *net, struct fib_table *tb,
 
 	key = ntohl(cfg->fc_dst);
 
-	if (!fib_valid_key_len(key, plen, extack))
-		return -EINVAL;
-
 	pr_debug("Insert table=%u %08x/%d\n", tb->tb_id, key, plen);
 
 	fi = fib_create_info(cfg, extack);
@@ -1671,9 +1652,6 @@ int fib_table_delete(struct net *net, struct fib_table *tb,
 
 	key = ntohl(cfg->fc_dst);
 
-	if (!fib_valid_key_len(key, plen, extack))
-		return -EINVAL;
-
 	l = fib_find_node(t, &tp, key);
 	if (!l)
 		return -ESRCH;
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 0fb5d758264f..fea74ab2a4be 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -934,22 +934,37 @@ int inet_ehash_locks_alloc(struct inet_hashinfo *hashinfo)
 {
 	unsigned int locksz = sizeof(spinlock_t);
 	unsigned int i, nblocks = 1;
+	spinlock_t *ptr = NULL;
 
-	if (locksz != 0) {
-		/* allocate 2 cache lines or at least one spinlock per cpu */
-		nblocks = max(2U * L1_CACHE_BYTES / locksz, 1U);
-		nblocks = roundup_pow_of_two(nblocks * num_possible_cpus());
+	if (locksz == 0)
+		goto set_mask;
 
-		/* no more locks than number of hash buckets */
-		nblocks = min(nblocks, hashinfo->ehash_mask + 1);
+	/* Allocate 2 cache lines or at least one spinlock per cpu. */
+	nblocks = max(2U * L1_CACHE_BYTES / locksz, 1U) * num_possible_cpus();
 
-		hashinfo->ehash_locks = kvmalloc_array(nblocks, locksz, GFP_KERNEL);
-		if (!hashinfo->ehash_locks)
-			return -ENOMEM;
+	/* At least one page per NUMA node. */
+	nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE / locksz);
+
+	nblocks = roundup_pow_of_two(nblocks);
+
+	/* No more locks than number of hash buckets. */
+	nblocks = min(nblocks, hashinfo->ehash_mask + 1);
 
-		for (i = 0; i < nblocks; i++)
-			spin_lock_init(&hashinfo->ehash_locks[i]);
+	if (num_online_nodes() > 1) {
+		/* Use vmalloc() to allow NUMA policy to spread pages
+		 * on all available nodes if desired.
+		 */
+		ptr = vmalloc_array(nblocks, locksz);
+	}
+	if (!ptr) {
+		ptr = kvmalloc_array(nblocks, locksz, GFP_KERNEL);
+		if (!ptr)
+			return -ENOMEM;
 	}
+	for (i = 0; i < nblocks; i++)
+		spin_lock_init(&ptr[i]);
+	hashinfo->ehash_locks = ptr;
+set_mask:
 	hashinfo->ehash_locks_mask = nblocks - 1;
 	return 0;
 }
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 6b926c71b6f3..7c2e714527f6 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -403,6 +403,20 @@ static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp, const struct tcphdr
 	return false;
 }
 
+static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
+{
+	tp->delivered_ce += ecn_count;
+}
+
+/* Updates the delivered and delivered_ce counts */
+static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
+				bool ece_ack)
+{
+	tp->delivered += delivered;
+	if (ece_ack)
+		tcp_count_delivered_ce(tp, delivered);
+}
+
 /* Buffer size and advertised window tuning.
  *
  * 1. Tuning sk->sk_sndbuf, when connection enters established state.
@@ -1102,15 +1116,6 @@ void tcp_mark_skb_lost(struct sock *sk, struct sk_buff *skb)
 	}
 }
 
-/* Updates the delivered and delivered_ce counts */
-static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
-				bool ece_ack)
-{
-	tp->delivered += delivered;
-	if (ece_ack)
-		tp->delivered_ce += delivered;
-}
-
 /* This procedure tags the retransmission queue when SACKs arrive.
  *
  * We have three tag bits: SACKED(S), RETRANS(R) and LOST(L).
@@ -3735,12 +3740,23 @@ static void tcp_process_tlp_ack(struct sock *sk, u32 ack, int flag)
 	}
 }
 
-static inline void tcp_in_ack_event(struct sock *sk, u32 flags)
+static void tcp_in_ack_event(struct sock *sk, int flag)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 
-	if (icsk->icsk_ca_ops->in_ack_event)
-		icsk->icsk_ca_ops->in_ack_event(sk, flags);
+	if (icsk->icsk_ca_ops->in_ack_event) {
+		u32 ack_ev_flags = 0;
+
+		if (flag & FLAG_WIN_UPDATE)
+			ack_ev_flags |= CA_ACK_WIN_UPDATE;
+		if (flag & FLAG_SLOWPATH) {
+			ack_ev_flags |= CA_ACK_SLOWPATH;
+			if (flag & FLAG_ECE)
+				ack_ev_flags |= CA_ACK_ECE;
+		}
+
+		icsk->icsk_ca_ops->in_ack_event(sk, ack_ev_flags);
+	}
 }
 
 /* Congestion control has updated the cwnd already. So if we're in
@@ -3857,12 +3873,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		tcp_snd_una_update(tp, ack);
 		flag |= FLAG_WIN_UPDATE;
 
-		tcp_in_ack_event(sk, CA_ACK_WIN_UPDATE);
-
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPACKS);
 	} else {
-		u32 ack_ev_flags = CA_ACK_SLOWPATH;
-
 		if (ack_seq != TCP_SKB_CB(skb)->end_seq)
 			flag |= FLAG_DATA;
 		else
@@ -3874,19 +3886,12 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 			flag |= tcp_sacktag_write_queue(sk, skb, prior_snd_una,
 							&sack_state);
 
-		if (tcp_ecn_rcv_ecn_echo(tp, tcp_hdr(skb))) {
+		if (tcp_ecn_rcv_ecn_echo(tp, tcp_hdr(skb)))
 			flag |= FLAG_ECE;
-			ack_ev_flags |= CA_ACK_ECE;
-		}
 
 		if (sack_state.sack_delivered)
 			tcp_count_delivered(tp, sack_state.sack_delivered,
 					    flag & FLAG_ECE);
-
-		if (flag & FLAG_WIN_UPDATE)
-			ack_ev_flags |= CA_ACK_WIN_UPDATE;
-
-		tcp_in_ack_event(sk, ack_ev_flags);
 	}
 
 	/* This is a deviation from RFC3168 since it states that:
@@ -3913,6 +3918,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	tcp_rack_update_reo_wnd(sk, &rs);
 
+	tcp_in_ack_event(sk, flag);
+
 	if (tp->tlp_high_seq)
 		tcp_process_tlp_ack(sk, ack, flag);
 
@@ -3944,6 +3951,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	return 1;
 
 no_queue:
+	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index b6952b88b505..73beaa7e2d70 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -242,6 +242,62 @@ static struct sk_buff *__udpv4_gso_segment_list_csum(struct sk_buff *segs)
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
@@ -254,7 +310,10 @@ static struct sk_buff *__udp_gso_segment_list(struct sk_buff *skb,
 
 	udp_hdr(skb)->len = htons(sizeof(struct udphdr) + mss);
 
-	return is_ipv6 ? skb : __udpv4_gso_segment_list_csum(skb);
+	if (is_ipv6)
+		return __udpv6_gso_segment_list_csum(skb);
+	else
+		return __udpv4_gso_segment_list_csum(skb);
 }
 
 struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index cf9a44fb8243..0d4e82744921 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -353,9 +353,9 @@ static int fib6_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
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
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 426330b8dfa4..f024d89cb0f8 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1416,6 +1416,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	cork->fl.u.ip6 = *fl6;
 	v6_cork->hop_limit = ipc6->hlimit;
 	v6_cork->tclass = ipc6->tclass;
+	v6_cork->dontfrag = ipc6->dontfrag;
 	if (rt->dst.flags & DST_XFRM_TUNNEL)
 		mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
 		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
@@ -1450,7 +1451,7 @@ static int __ip6_append_data(struct sock *sk,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
 			     void *from, size_t length, int transhdrlen,
-			     unsigned int flags, struct ipcm6_cookie *ipc6)
+			     unsigned int flags)
 {
 	struct sk_buff *skb, *skb_prev = NULL;
 	unsigned int maxfraglen, fragheaderlen, mtu, orig_mtu, pmtu;
@@ -1507,7 +1508,7 @@ static int __ip6_append_data(struct sock *sk,
 	if (headersize + transhdrlen > mtu)
 		goto emsgsize;
 
-	if (cork->length + length > mtu - headersize && ipc6->dontfrag &&
+	if (cork->length + length > mtu - headersize && v6_cork->dontfrag &&
 	    (sk->sk_protocol == IPPROTO_UDP ||
 	     sk->sk_protocol == IPPROTO_RAW)) {
 		ipv6_local_rxpmtu(sk, fl6, mtu - headersize +
@@ -1825,7 +1826,7 @@ int ip6_append_data(struct sock *sk,
 
 	return __ip6_append_data(sk, fl6, &sk->sk_write_queue, &inet->cork.base,
 				 &np->cork, sk_page_frag(sk), getfrag,
-				 from, length, transhdrlen, flags, ipc6);
+				 from, length, transhdrlen, flags);
 }
 EXPORT_SYMBOL_GPL(ip6_append_data);
 
@@ -2020,7 +2021,7 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 	err = __ip6_append_data(sk, fl6, &queue, &cork->base, &v6_cork,
 				&current->task_frag, getfrag, from,
 				length + exthdrlen, transhdrlen + exthdrlen,
-				flags, ipc6);
+				flags);
 	if (err) {
 		__ip6_flush_pending_frames(sk, &queue, cork, &v6_cork);
 		return ERR_PTR(err);
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index dae978badd26..5065b9622ada 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -887,15 +887,15 @@ static int llc_ui_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
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
index 093ec5214008..636118b0f2ef 100644
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
index 8498bf27a353..abf558868db1 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -613,7 +613,9 @@ static struct ctl_table nf_ct_sysctl_table[] = {
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
@@ -652,7 +654,9 @@ static struct ctl_table nf_ct_sysctl_table[] = {
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
@@ -931,7 +935,9 @@ static struct ctl_table nf_ct_netfilter_table[] = {
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
index 04fda8c14e04..ff419ecb268a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1911,9 +1911,9 @@ static void nf_tables_chain_free_chain_rules(struct nft_chain *chain)
 	kvfree(chain->rules_next);
 }
 
-void nf_tables_chain_destroy(struct nft_ctx *ctx)
+void nf_tables_chain_destroy(struct nft_chain *chain)
 {
-	struct nft_chain *chain = ctx->chain;
+	const struct nft_table *table = chain->table;
 	struct nft_hook *hook, *next;
 
 	if (WARN_ON(chain->use > 0))
@@ -1925,7 +1925,7 @@ void nf_tables_chain_destroy(struct nft_ctx *ctx)
 	if (nft_is_base_chain(chain)) {
 		struct nft_base_chain *basechain = nft_base_chain(chain);
 
-		if (nft_base_chain_netdev(ctx->family, basechain->ops.hooknum)) {
+		if (nft_base_chain_netdev(table->family, basechain->ops.hooknum)) {
 			list_for_each_entry_safe(hook, next,
 						 &basechain->hook_list, list) {
 				list_del_rcu(&hook->list);
@@ -2367,7 +2367,7 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 err_use:
 	nf_tables_unregister_hook(net, table, chain);
 err_destroy_chain:
-	nf_tables_chain_destroy(ctx);
+	nf_tables_chain_destroy(chain);
 
 	return err;
 }
@@ -3344,8 +3344,11 @@ void nf_tables_rule_destroy(const struct nft_ctx *ctx, struct nft_rule *rule)
 	kfree(rule);
 }
 
+/* can only be used if rule is no longer visible to dumps */
 static void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *rule)
 {
+	lockdep_commit_lock_is_held(ctx->net);
+
 	nft_rule_expr_deactivate(ctx, rule, NFT_TRANS_RELEASE);
 	nf_tables_rule_destroy(ctx, rule);
 }
@@ -4857,6 +4860,8 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase)
 {
+	lockdep_commit_lock_is_held(ctx->net);
+
 	switch (phase) {
 	case NFT_TRANS_PREPARE_ERROR:
 		nft_set_trans_unbind(ctx, set);
@@ -7999,7 +8004,7 @@ static void nft_commit_release(struct nft_trans *trans)
 		kfree(nft_trans_chain_name(trans));
 		break;
 	case NFT_MSG_DELCHAIN:
-		nf_tables_chain_destroy(&trans->ctx);
+		nf_tables_chain_destroy(nft_trans_chain(trans));
 		break;
 	case NFT_MSG_DELRULE:
 		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
@@ -8840,7 +8845,7 @@ static void nf_tables_abort_release(struct nft_trans *trans)
 		nf_tables_table_destroy(&trans->ctx);
 		break;
 	case NFT_MSG_NEWCHAIN:
-		nf_tables_chain_destroy(&trans->ctx);
+		nf_tables_chain_destroy(nft_trans_chain(trans));
 		break;
 	case NFT_MSG_NEWRULE:
 		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
@@ -9559,23 +9564,43 @@ int nft_data_dump(struct sk_buff *skb, int attr, const struct nft_data *data,
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
@@ -9646,10 +9671,9 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
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
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index d154fe67ca8a..a889cf1d863e 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -221,7 +221,7 @@ static void nft_immediate_destroy(const struct nft_ctx *ctx,
 			list_del(&rule->list);
 			nf_tables_rule_destroy(&chain_ctx, rule);
 		}
-		nf_tables_chain_destroy(&chain_ctx);
+		nf_tables_chain_destroy(chain);
 		break;
 	default:
 		break;
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index a02ea493c269..c3ca4ae11c09 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -953,8 +953,7 @@ static int output_userspace(struct datapath *dp, struct sk_buff *skb,
 	upcall.cmd = OVS_PACKET_CMD_ACTION;
 	upcall.mru = OVS_CB(skb)->mru;
 
-	for (a = nla_data(attr), rem = nla_len(attr); rem > 0;
-	     a = nla_next(a, &rem)) {
+	nla_for_each_nested(a, attr, rem) {
 		switch (nla_type(a)) {
 		case OVS_USERSPACE_ATTR_USERDATA:
 			upcall.userdata = a;
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 91a19460cb57..07b9f8335f05 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -256,31 +256,31 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 
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
@@ -323,12 +323,16 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
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
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 30169b3adbbb..d99c7386e24e 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -174,7 +174,7 @@ static int codel_change(struct Qdisc *sch, struct nlattr *opt,
 
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
 
 		dropped += qdisc_pkt_len(skb);
 		qdisc_qstats_backlog_dec(sch, skb);
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 08424aac6da8..7ddf73f5a418 100644
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
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 0afd9187f836..35b8577aef7d 100644
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
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 5a1274199fe3..65b12b39e2ec 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -904,7 +904,7 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 		sch_tree_lock(sch);
 	}
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = fq_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
 		if (!skb)
 			break;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 01d6eea5b0ce..60dbc549e991 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -429,7 +429,7 @@ static int fq_codel_change(struct Qdisc *sch, struct nlattr *opt,
 
 	while (sch->q.qlen > sch->limit ||
 	       q->memory_usage > q->memory_limit) {
-		struct sk_buff *skb = fq_codel_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
 		q->cstats.drop_len += qdisc_pkt_len(skb);
 		rtnl_kfree_skbs(skb, skb);
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index a5b63158f081..d4bfa3382e11 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -360,7 +360,7 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 
 	/* Drop excess packets if new limit is lower */
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = fq_pie_qdisc_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
 		len_dropped += qdisc_pkt_len(skb);
 		num_dropped += 1;
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index aad090fd165b..443db2c08a09 100644
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
@@ -1571,7 +1578,10 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
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
@@ -1586,9 +1596,6 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 
 	}
 
-	sch->qstats.backlog += len;
-	sch->q.qlen++;
-
 	return NET_XMIT_SUCCESS;
 }
 
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 420ede875322..433bddcbc0c7 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -563,7 +563,7 @@ static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
 	qlen = sch->q.qlen;
 	prev_backlog = sch->qstats.backlog;
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = hhf_dequeue(sch);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, false);
 
 		rtnl_kfree_skbs(skb, skb);
 	}
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index c65077f0c0f3..47f5d4adb5a3 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -193,7 +193,7 @@ static int pie_change(struct Qdisc *sch, struct nlattr *opt,
 	/* Drop excess packets if new limit is lower */
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > sch->limit) {
-		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
+		struct sk_buff *skb = qdisc_dequeue_internal(sch, true);
 
 		dropped += qdisc_pkt_len(skb);
 		qdisc_qstats_backlog_dec(sch, skb);
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index ebf9f473c939..1ee15db5fcc8 100644
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
@@ -1222,7 +1227,6 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct qfq_class *cl;
 	struct qfq_aggregate *agg;
 	int err = 0;
-	bool first;
 
 	cl = qfq_classify(skb, sch, &err);
 	if (cl == NULL) {
@@ -1244,7 +1248,6 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	gso_segs = skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
-	first = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		pr_debug("qfq_enqueue: enqueue failed %d\n", err);
@@ -1261,8 +1264,8 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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
index 7ec5b0bc48eb..0a4b4870c4d9 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -273,9 +273,6 @@ static struct rpc_xprt *rpc_clnt_set_transport(struct rpc_clnt *clnt,
 	old = rcu_dereference_protected(clnt->cl_xprt,
 			lockdep_is_held(&clnt->cl_lock));
 
-	if (!xprt_bound(xprt))
-		clnt->cl_autobind = 1;
-
 	clnt->cl_timeout = timeout;
 	rcu_assign_pointer(clnt->cl_xprt, xprt);
 	spin_unlock(&clnt->cl_lock);
diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index 8fad45320e1b..f1bb4fd2a270 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -794,9 +794,10 @@ static void rpcb_getport_done(struct rpc_task *child, void *data)
 	}
 
 	trace_rpcb_setport(child, map->r_status, map->r_port);
-	xprt->ops->set_port(xprt, map->r_port);
-	if (map->r_port)
+	if (map->r_port) {
+		xprt->ops->set_port(xprt, map->r_port);
 		xprt_set_bound(xprt);
+	}
 }
 
 /*
diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index bf384bd12696..159d891b81c5 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -821,12 +821,16 @@ static int tipc_aead_encrypt(struct tipc_aead *aead, struct sk_buff *skb,
 		goto exit;
 	}
 
+	/* Get net to avoid freed tipc_crypto when delete namespace */
+	get_net(aead->crypto->net);
+
 	/* Now, do encrypt */
 	rc = crypto_aead_encrypt(req);
 	if (rc == -EINPROGRESS || rc == -EBUSY)
 		return rc;
 
 	tipc_bearer_put(b);
+	put_net(aead->crypto->net);
 
 exit:
 	kfree(ctx);
@@ -864,6 +868,7 @@ static void tipc_aead_encrypt_done(struct crypto_async_request *base, int err)
 	kfree(tx_ctx);
 	tipc_bearer_put(b);
 	tipc_aead_put(aead);
+	put_net(net);
 }
 
 /**
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index a1a662a55c2a..64b971bb1d36 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1594,6 +1594,9 @@ int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl)
 	struct xfrm_policy *delpol;
 	struct hlist_head *chain;
 
+	/* Sanitize mark before store */
+	policy->mark.v &= policy->mark.m;
+
 	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
 	chain = policy_hash_bysel(net, &policy->selector, policy->family, dir);
 	if (chain)
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 94179ff475f2..da2d7012e5c7 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1249,6 +1249,9 @@ static void __xfrm_state_insert(struct xfrm_state *x)
 
 	list_add(&x->km.all, &net->xfrm.state_all);
 
+	/* Sanitize mark before store */
+	x->mark.v &= x->mark.m;
+
 	h = xfrm_dst_hash(net, &x->id.daddr, &x->props.saddr,
 			  x->props.reqid, x->props.family);
 	hlist_add_head_rcu(&x->bydst, net->xfrm.state_bydst + h);
diff --git a/samples/ftrace/sample-trace-array.c b/samples/ftrace/sample-trace-array.c
index 6aba02a31c96..77685a7eb767 100644
--- a/samples/ftrace/sample-trace-array.c
+++ b/samples/ftrace/sample-trace-array.c
@@ -112,7 +112,7 @@ static int __init sample_trace_array_init(void)
 	/*
 	 * If context specific per-cpu buffers havent already been allocated.
 	 */
-	trace_printk_init_buffers();
+	trace_array_init_printk(tr);
 
 	simple_tsk = kthread_run(simple_thread, NULL, "sample-instance");
 	if (IS_ERR(simple_tsk)) {
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
index 44f0b5148a5b..6402626e47c6 100644
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
index de6f94bee50b..8eb5fef41dbe 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1078,8 +1078,7 @@ static int snd_pcm_oss_change_params_locked(struct snd_pcm_substream *substream)
 	runtime->oss.params = 0;
 	runtime->oss.prepare = 1;
 	runtime->oss.buffer_used = 0;
-	if (runtime->dma_area)
-		snd_pcm_format_set_silence(runtime->format, runtime->dma_area, bytes_to_samples(runtime, runtime->dma_bytes));
+	snd_pcm_runtime_buffer_set_silence(runtime);
 
 	runtime->oss.period_frames = snd_pcm_alsa_frames(substream, oss_period_size);
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 9425fcd30c4c..98bd6fe850d3 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -685,6 +685,17 @@ static void snd_pcm_buffer_access_unlock(struct snd_pcm_runtime *runtime)
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
index 34332d008b27..32e38a70af93 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -1573,7 +1573,7 @@ static int snd_es1968_capture_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct es1968 *chip = snd_pcm_substream_chip(substream);
 	struct esschan *es;
-	int apu1, apu2;
+	int err, apu1, apu2;
 
 	apu1 = snd_es1968_alloc_apu_pair(chip, ESM_APU_PCM_CAPTURE);
 	if (apu1 < 0)
@@ -1616,7 +1616,9 @@ static int snd_es1968_capture_open(struct snd_pcm_substream *substream)
 	runtime->hw = snd_es1968_capture;
 	runtime->hw.buffer_bytes_max = runtime->hw.period_bytes_max =
 		calc_available_memory_size(chip) - 1024; /* keep MIXBUF size */
-	snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
+	err = snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
+	if (err < 0)
+		return err;
 
 	spin_lock_irq(&chip->substream_lock);
 	list_add(&es->list, &chip->substream_list);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3fdd2337919e..b2df53215279 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6702,6 +6702,41 @@ static void alc285_fixup_hp_spectre_x360_eb1(struct hda_codec *codec,
 	}
 }
 
+/* GPIO1 = amplifier on/off */
+static void alc285_fixup_hp_spectre_x360_df1(struct hda_codec *codec,
+					     const struct hda_fixup *fix,
+					     int action)
+{
+	struct alc_spec *spec = codec->spec;
+	static const hda_nid_t conn[] = { 0x02 };
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x14, 0x90170110 },  /* front/high speakers */
+		{ 0x17, 0x90170130 },  /* back/bass speakers */
+		{ }
+	};
+
+	// enable mute led
+	alc285_fixup_hp_mute_led_coefbit(codec, fix, action);
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		/* needed for amp of back speakers */
+		spec->gpio_mask |= 0x01;
+		spec->gpio_dir |= 0x01;
+		snd_hda_apply_pincfgs(codec, pincfgs);
+		/* share DAC to have unified volume control */
+		snd_hda_override_conn_list(codec, 0x14, ARRAY_SIZE(conn), conn);
+		snd_hda_override_conn_list(codec, 0x17, ARRAY_SIZE(conn), conn);
+		break;
+	case HDA_FIXUP_ACT_INIT:
+		/* need to toggle GPIO to enable the amp of back speakers */
+		alc_update_gpio_data(codec, 0x01, true);
+		msleep(100);
+		alc_update_gpio_data(codec, 0x01, false);
+		break;
+	}
+}
+
 static void alc285_fixup_hp_spectre_x360(struct hda_codec *codec,
 					  const struct hda_fixup *fix, int action)
 {
@@ -6984,6 +7019,7 @@ enum {
 	ALC280_FIXUP_HP_9480M,
 	ALC245_FIXUP_HP_X360_AMP,
 	ALC285_FIXUP_HP_SPECTRE_X360_EB1,
+	ALC285_FIXUP_HP_SPECTRE_X360_DF1,
 	ALC285_FIXUP_HP_ENVY_X360,
 	ALC288_FIXUP_DELL_HEADSET_MODE,
 	ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
@@ -8818,6 +8854,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_hp_spectre_x360_eb1
 	},
+	[ALC285_FIXUP_HP_SPECTRE_X360_DF1] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_hp_spectre_x360_df1
+	},
 	[ALC285_FIXUP_HP_ENVY_X360] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_hp_envy_x360,
@@ -9223,6 +9263,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x86c1, "HP Laptop 15-da3001TU", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x86c7, "HP Envy AiO 32", ALC274_FIXUP_HP_ENVY_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x86e7, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
+	SND_PCI_QUIRK(0x103c, 0x863e, "HP Spectre x360 15-df1xxx", ALC285_FIXUP_HP_SPECTRE_X360_DF1),
 	SND_PCI_QUIRK(0x103c, 0x86e8, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x86f9, "HP Spectre x360 13-aw0xxx", ALC285_FIXUP_HP_SPECTRE_X360_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8716, "HP Elite Dragonfly G2 Notebook PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
@@ -9750,6 +9791,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC295_FIXUP_HP_OMEN, .name = "alc295-hp-omen"},
 	{.id = ALC285_FIXUP_HP_SPECTRE_X360, .name = "alc285-hp-spectre-x360"},
 	{.id = ALC285_FIXUP_HP_SPECTRE_X360_EB1, .name = "alc285-hp-spectre-x360-eb1"},
+	{.id = ALC285_FIXUP_HP_SPECTRE_X360_DF1, .name = "alc285-hp-spectre-x360-df1"},
 	{.id = ALC285_FIXUP_HP_ENVY_X360, .name = "alc285-hp-envy-x360"},
 	{.id = ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP, .name = "alc287-ideapad-bass-spk-amp"},
 	{.id = ALC623_FIXUP_LENOVO_THINKSTATION_P340, .name = "alc623-lenovo-thinkstation-p340"},
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
diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index dd8eeafa223e..e09480e4c54c 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -130,33 +130,6 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new tas2764_asi1_mux =
 	SOC_DAPM_ENUM("ASI1 Source", tas2764_ASI1_src_enum);
 
-static int tas2764_dac_event(struct snd_soc_dapm_widget *w,
-			     struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
-	int ret;
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		tas2764->dac_powered = true;
-		ret = tas2764_update_pwr_ctrl(tas2764);
-		break;
-	case SND_SOC_DAPM_PRE_PMD:
-		tas2764->dac_powered = false;
-		ret = tas2764_update_pwr_ctrl(tas2764);
-		break;
-	default:
-		dev_err(tas2764->dev, "Unsupported event\n");
-		return -EINVAL;
-	}
-
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static const struct snd_kcontrol_new isense_switch =
 	SOC_DAPM_SINGLE("Switch", TAS2764_PWR_CTRL, TAS2764_ISENSE_POWER_EN, 1, 1);
 static const struct snd_kcontrol_new vsense_switch =
@@ -169,8 +142,7 @@ static const struct snd_soc_dapm_widget tas2764_dapm_widgets[] = {
 			    1, &isense_switch),
 	SND_SOC_DAPM_SWITCH("VSENSE", TAS2764_PWR_CTRL, TAS2764_VSENSE_POWER_EN,
 			    1, &vsense_switch),
-	SND_SOC_DAPM_DAC_E("DAC", NULL, SND_SOC_NOPM, 0, 0, tas2764_dac_event,
-			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_OUTPUT("OUT"),
 	SND_SOC_DAPM_SIGGEN("VMON"),
 	SND_SOC_DAPM_SIGGEN("IMON")
@@ -191,9 +163,28 @@ static int tas2764_mute(struct snd_soc_dai *dai, int mute, int direction)
 {
 	struct tas2764_priv *tas2764 =
 			snd_soc_component_get_drvdata(dai->component);
+	int ret;
+
+	if (!mute) {
+		tas2764->dac_powered = true;
+		ret = tas2764_update_pwr_ctrl(tas2764);
+		if (ret)
+			return ret;
+	}
 
 	tas2764->unmuted = !mute;
-	return tas2764_update_pwr_ctrl(tas2764);
+	ret = tas2764_update_pwr_ctrl(tas2764);
+	if (ret)
+		return ret;
+
+	if (mute) {
+		tas2764->dac_powered = false;
+		ret = tas2764_update_pwr_ctrl(tas2764);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int tas2764_set_bitwidth(struct tas2764_priv *tas2764, int bitwidth)
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 06559f2afe32..b4b2781ad22e 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -431,6 +431,19 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
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
diff --git a/sound/soc/qcom/qdsp6/q6afe-clocks.c b/sound/soc/qcom/qdsp6/q6afe-clocks.c
index acfc0c698f6a..9431656283cd 100644
--- a/sound/soc/qcom/qdsp6/q6afe-clocks.c
+++ b/sound/soc/qcom/qdsp6/q6afe-clocks.c
@@ -11,33 +11,29 @@
 #include <linux/slab.h>
 #include "q6afe.h"
 
-#define Q6AFE_CLK(id) &(struct q6afe_clk) {		\
+#define Q6AFE_CLK(id) {					\
 		.clk_id	= id,				\
 		.afe_clk_id	= Q6AFE_##id,		\
 		.name = #id,				\
-		.attributes = LPASS_CLK_ATTRIBUTE_COUPLE_NO, \
 		.rate = 19200000,			\
-		.hw.init = &(struct clk_init_data) {	\
-			.ops = &clk_q6afe_ops,		\
-			.name = #id,			\
-		},					\
 	}
 
-#define Q6AFE_VOTE_CLK(id, blkid, n) &(struct q6afe_clk) { \
+#define Q6AFE_VOTE_CLK(id, blkid, n) {			\
 		.clk_id	= id,				\
 		.afe_clk_id = blkid,			\
-		.name = #n,				\
-		.hw.init = &(struct clk_init_data) {	\
-			.ops = &clk_vote_q6afe_ops,	\
-			.name = #id,			\
-		},					\
+		.name = n,				\
 	}
 
-struct q6afe_clk {
-	struct device *dev;
+struct q6afe_clk_init {
 	int clk_id;
 	int afe_clk_id;
 	char *name;
+	int rate;
+};
+
+struct q6afe_clk {
+	struct device *dev;
+	int afe_clk_id;
 	int attributes;
 	int rate;
 	uint32_t handle;
@@ -48,8 +44,7 @@ struct q6afe_clk {
 
 struct q6afe_cc {
 	struct device *dev;
-	struct q6afe_clk **clks;
-	int num_clks;
+	struct q6afe_clk *clks[Q6AFE_MAX_CLK_ID];
 };
 
 static int clk_q6afe_prepare(struct clk_hw *hw)
@@ -105,7 +100,7 @@ static int clk_vote_q6afe_block(struct clk_hw *hw)
 	struct q6afe_clk *clk = to_q6afe_clk(hw);
 
 	return q6afe_vote_lpass_core_hw(clk->dev, clk->afe_clk_id,
-					clk->name, &clk->handle);
+					clk_hw_get_name(&clk->hw), &clk->handle);
 }
 
 static void clk_unvote_q6afe_block(struct clk_hw *hw)
@@ -120,84 +115,76 @@ static const struct clk_ops clk_vote_q6afe_ops = {
 	.unprepare	= clk_unvote_q6afe_block,
 };
 
-struct q6afe_clk *q6afe_clks[Q6AFE_MAX_CLK_ID] = {
-	[LPASS_CLK_ID_PRI_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_MI2S_IBIT),
-	[LPASS_CLK_ID_PRI_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_MI2S_EBIT),
-	[LPASS_CLK_ID_SEC_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_MI2S_IBIT),
-	[LPASS_CLK_ID_SEC_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_MI2S_EBIT),
-	[LPASS_CLK_ID_TER_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_MI2S_IBIT),
-	[LPASS_CLK_ID_TER_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_MI2S_EBIT),
-	[LPASS_CLK_ID_QUAD_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_MI2S_IBIT),
-	[LPASS_CLK_ID_QUAD_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_MI2S_EBIT),
-	[LPASS_CLK_ID_SPEAKER_I2S_IBIT] =
-				Q6AFE_CLK(LPASS_CLK_ID_SPEAKER_I2S_IBIT),
-	[LPASS_CLK_ID_SPEAKER_I2S_EBIT] =
-				Q6AFE_CLK(LPASS_CLK_ID_SPEAKER_I2S_EBIT),
-	[LPASS_CLK_ID_SPEAKER_I2S_OSR] =
-				Q6AFE_CLK(LPASS_CLK_ID_SPEAKER_I2S_OSR),
-	[LPASS_CLK_ID_QUI_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUI_MI2S_IBIT),
-	[LPASS_CLK_ID_QUI_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUI_MI2S_EBIT),
-	[LPASS_CLK_ID_SEN_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEN_MI2S_IBIT),
-	[LPASS_CLK_ID_SEN_MI2S_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEN_MI2S_EBIT),
-	[LPASS_CLK_ID_INT0_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT0_MI2S_IBIT),
-	[LPASS_CLK_ID_INT1_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT1_MI2S_IBIT),
-	[LPASS_CLK_ID_INT2_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT2_MI2S_IBIT),
-	[LPASS_CLK_ID_INT3_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT3_MI2S_IBIT),
-	[LPASS_CLK_ID_INT4_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT4_MI2S_IBIT),
-	[LPASS_CLK_ID_INT5_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT5_MI2S_IBIT),
-	[LPASS_CLK_ID_INT6_MI2S_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_INT6_MI2S_IBIT),
-	[LPASS_CLK_ID_QUI_MI2S_OSR] = Q6AFE_CLK(LPASS_CLK_ID_QUI_MI2S_OSR),
-	[LPASS_CLK_ID_PRI_PCM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_PCM_IBIT),
-	[LPASS_CLK_ID_PRI_PCM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_PCM_EBIT),
-	[LPASS_CLK_ID_SEC_PCM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_PCM_IBIT),
-	[LPASS_CLK_ID_SEC_PCM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_PCM_EBIT),
-	[LPASS_CLK_ID_TER_PCM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_PCM_IBIT),
-	[LPASS_CLK_ID_TER_PCM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_PCM_EBIT),
-	[LPASS_CLK_ID_QUAD_PCM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_PCM_IBIT),
-	[LPASS_CLK_ID_QUAD_PCM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_PCM_EBIT),
-	[LPASS_CLK_ID_QUIN_PCM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUIN_PCM_IBIT),
-	[LPASS_CLK_ID_QUIN_PCM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUIN_PCM_EBIT),
-	[LPASS_CLK_ID_QUI_PCM_OSR] = Q6AFE_CLK(LPASS_CLK_ID_QUI_PCM_OSR),
-	[LPASS_CLK_ID_PRI_TDM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_TDM_IBIT),
-	[LPASS_CLK_ID_PRI_TDM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_PRI_TDM_EBIT),
-	[LPASS_CLK_ID_SEC_TDM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_TDM_IBIT),
-	[LPASS_CLK_ID_SEC_TDM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_SEC_TDM_EBIT),
-	[LPASS_CLK_ID_TER_TDM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_TDM_IBIT),
-	[LPASS_CLK_ID_TER_TDM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_TER_TDM_EBIT),
-	[LPASS_CLK_ID_QUAD_TDM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_TDM_IBIT),
-	[LPASS_CLK_ID_QUAD_TDM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUAD_TDM_EBIT),
-	[LPASS_CLK_ID_QUIN_TDM_IBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUIN_TDM_IBIT),
-	[LPASS_CLK_ID_QUIN_TDM_EBIT] = Q6AFE_CLK(LPASS_CLK_ID_QUIN_TDM_EBIT),
-	[LPASS_CLK_ID_QUIN_TDM_OSR] = Q6AFE_CLK(LPASS_CLK_ID_QUIN_TDM_OSR),
-	[LPASS_CLK_ID_MCLK_1] = Q6AFE_CLK(LPASS_CLK_ID_MCLK_1),
-	[LPASS_CLK_ID_MCLK_2] = Q6AFE_CLK(LPASS_CLK_ID_MCLK_2),
-	[LPASS_CLK_ID_MCLK_3] = Q6AFE_CLK(LPASS_CLK_ID_MCLK_3),
-	[LPASS_CLK_ID_MCLK_4] = Q6AFE_CLK(LPASS_CLK_ID_MCLK_4),
-	[LPASS_CLK_ID_INTERNAL_DIGITAL_CODEC_CORE] =
-		Q6AFE_CLK(LPASS_CLK_ID_INTERNAL_DIGITAL_CODEC_CORE),
-	[LPASS_CLK_ID_INT_MCLK_0] = Q6AFE_CLK(LPASS_CLK_ID_INT_MCLK_0),
-	[LPASS_CLK_ID_INT_MCLK_1] = Q6AFE_CLK(LPASS_CLK_ID_INT_MCLK_1),
-	[LPASS_CLK_ID_WSA_CORE_MCLK] = Q6AFE_CLK(LPASS_CLK_ID_WSA_CORE_MCLK),
-	[LPASS_CLK_ID_WSA_CORE_NPL_MCLK] =
-				Q6AFE_CLK(LPASS_CLK_ID_WSA_CORE_NPL_MCLK),
-	[LPASS_CLK_ID_VA_CORE_MCLK] = Q6AFE_CLK(LPASS_CLK_ID_VA_CORE_MCLK),
-	[LPASS_CLK_ID_TX_CORE_MCLK] = Q6AFE_CLK(LPASS_CLK_ID_TX_CORE_MCLK),
-	[LPASS_CLK_ID_TX_CORE_NPL_MCLK] =
-			Q6AFE_CLK(LPASS_CLK_ID_TX_CORE_NPL_MCLK),
-	[LPASS_CLK_ID_RX_CORE_MCLK] = Q6AFE_CLK(LPASS_CLK_ID_RX_CORE_MCLK),
-	[LPASS_CLK_ID_RX_CORE_NPL_MCLK] =
-				Q6AFE_CLK(LPASS_CLK_ID_RX_CORE_NPL_MCLK),
-	[LPASS_CLK_ID_VA_CORE_2X_MCLK] =
-				Q6AFE_CLK(LPASS_CLK_ID_VA_CORE_2X_MCLK),
-	[LPASS_HW_AVTIMER_VOTE] = Q6AFE_VOTE_CLK(LPASS_HW_AVTIMER_VOTE,
-						 Q6AFE_LPASS_CORE_AVTIMER_BLOCK,
-						 "LPASS_AVTIMER_MACRO"),
-	[LPASS_HW_MACRO_VOTE] = Q6AFE_VOTE_CLK(LPASS_HW_MACRO_VOTE,
-						Q6AFE_LPASS_CORE_HW_MACRO_BLOCK,
-						"LPASS_HW_MACRO"),
-	[LPASS_HW_DCODEC_VOTE] = Q6AFE_VOTE_CLK(LPASS_HW_DCODEC_VOTE,
-					Q6AFE_LPASS_CORE_HW_DCODEC_BLOCK,
-					"LPASS_HW_DCODEC"),
+static const struct q6afe_clk_init q6afe_clks[] = {
+	Q6AFE_CLK(LPASS_CLK_ID_PRI_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_PRI_MI2S_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SEC_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SEC_MI2S_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_TER_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_TER_MI2S_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUAD_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUAD_MI2S_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SPEAKER_I2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SPEAKER_I2S_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SPEAKER_I2S_OSR),
+	Q6AFE_CLK(LPASS_CLK_ID_QUI_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUI_MI2S_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SEN_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SEN_MI2S_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_INT0_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_INT1_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_INT2_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_INT3_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_INT4_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_INT5_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_INT6_MI2S_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUI_MI2S_OSR),
+	Q6AFE_CLK(LPASS_CLK_ID_PRI_PCM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_PRI_PCM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SEC_PCM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SEC_PCM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_TER_PCM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_TER_PCM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUAD_PCM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUAD_PCM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUIN_PCM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUIN_PCM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUI_PCM_OSR),
+	Q6AFE_CLK(LPASS_CLK_ID_PRI_TDM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_PRI_TDM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SEC_TDM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_SEC_TDM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_TER_TDM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_TER_TDM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUAD_TDM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUAD_TDM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUIN_TDM_IBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUIN_TDM_EBIT),
+	Q6AFE_CLK(LPASS_CLK_ID_QUIN_TDM_OSR),
+	Q6AFE_CLK(LPASS_CLK_ID_MCLK_1),
+	Q6AFE_CLK(LPASS_CLK_ID_MCLK_2),
+	Q6AFE_CLK(LPASS_CLK_ID_MCLK_3),
+	Q6AFE_CLK(LPASS_CLK_ID_MCLK_4),
+	Q6AFE_CLK(LPASS_CLK_ID_INTERNAL_DIGITAL_CODEC_CORE),
+	Q6AFE_CLK(LPASS_CLK_ID_INT_MCLK_0),
+	Q6AFE_CLK(LPASS_CLK_ID_INT_MCLK_1),
+	Q6AFE_CLK(LPASS_CLK_ID_WSA_CORE_MCLK),
+	Q6AFE_CLK(LPASS_CLK_ID_WSA_CORE_NPL_MCLK),
+	Q6AFE_CLK(LPASS_CLK_ID_VA_CORE_MCLK),
+	Q6AFE_CLK(LPASS_CLK_ID_TX_CORE_MCLK),
+	Q6AFE_CLK(LPASS_CLK_ID_TX_CORE_NPL_MCLK),
+	Q6AFE_CLK(LPASS_CLK_ID_RX_CORE_MCLK),
+	Q6AFE_CLK(LPASS_CLK_ID_RX_CORE_NPL_MCLK),
+	Q6AFE_CLK(LPASS_CLK_ID_VA_CORE_2X_MCLK),
+	Q6AFE_VOTE_CLK(LPASS_HW_AVTIMER_VOTE,
+		       Q6AFE_LPASS_CORE_AVTIMER_BLOCK,
+		       "LPASS_AVTIMER_MACRO"),
+	Q6AFE_VOTE_CLK(LPASS_HW_MACRO_VOTE,
+		       Q6AFE_LPASS_CORE_HW_MACRO_BLOCK,
+		       "LPASS_HW_MACRO"),
+	Q6AFE_VOTE_CLK(LPASS_HW_DCODEC_VOTE,
+		       Q6AFE_LPASS_CORE_HW_DCODEC_BLOCK,
+		       "LPASS_HW_DCODEC"),
 };
 
 static struct clk_hw *q6afe_of_clk_hw_get(struct of_phandle_args *clkspec,
@@ -207,7 +194,7 @@ static struct clk_hw *q6afe_of_clk_hw_get(struct of_phandle_args *clkspec,
 	unsigned int idx = clkspec->args[0];
 	unsigned int attr = clkspec->args[1];
 
-	if (idx >= cc->num_clks || attr > LPASS_CLK_ATTRIBUTE_COUPLE_DIVISOR) {
+	if (idx >= Q6AFE_MAX_CLK_ID || attr > LPASS_CLK_ATTRIBUTE_COUPLE_DIVISOR) {
 		dev_err(cc->dev, "Invalid clk specifier (%d, %d)\n", idx, attr);
 		return ERR_PTR(-EINVAL);
 	}
@@ -230,20 +217,36 @@ static int q6afe_clock_dev_probe(struct platform_device *pdev)
 	if (!cc)
 		return -ENOMEM;
 
-	cc->clks = &q6afe_clks[0];
-	cc->num_clks = ARRAY_SIZE(q6afe_clks);
+	cc->dev = dev;
 	for (i = 0; i < ARRAY_SIZE(q6afe_clks); i++) {
-		if (!q6afe_clks[i])
-			continue;
+		unsigned int id = q6afe_clks[i].clk_id;
+		struct clk_init_data init = {
+			.name =  q6afe_clks[i].name,
+		};
+		struct q6afe_clk *clk;
+
+		clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
+		if (!clk)
+			return -ENOMEM;
+
+		clk->dev = dev;
+		clk->afe_clk_id = q6afe_clks[i].afe_clk_id;
+		clk->rate = q6afe_clks[i].rate;
+		clk->hw.init = &init;
+
+		if (clk->rate)
+			init.ops = &clk_q6afe_ops;
+		else
+			init.ops = &clk_vote_q6afe_ops;
 
-		q6afe_clks[i]->dev = dev;
+		cc->clks[id] = clk;
 
-		ret = devm_clk_hw_register(dev, &q6afe_clks[i]->hw);
+		ret = devm_clk_hw_register(dev, &clk->hw);
 		if (ret)
 			return ret;
 	}
 
-	ret = of_clk_add_hw_provider(dev->of_node, q6afe_of_clk_hw_get, cc);
+	ret = devm_of_clk_add_hw_provider(dev, q6afe_of_clk_hw_get, cc);
 	if (ret)
 		return ret;
 
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 0ca1e4aae518..7be495336446 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -1681,7 +1681,7 @@ int q6afe_unvote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
 EXPORT_SYMBOL(q6afe_unvote_lpass_core_hw);
 
 int q6afe_vote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
-			     char *client_name, uint32_t *client_handle)
+			     const char *client_name, uint32_t *client_handle)
 {
 	struct q6afe *afe = dev_get_drvdata(dev->parent);
 	struct afe_cmd_remote_lpass_core_hw_vote_request *vote_cfg;
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
index 22e10269aa10..3845b56c0ed3 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -236,7 +236,7 @@ int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
 int q6afe_set_lpass_clock(struct device *dev, int clk_id, int clk_src,
 			  int clk_root, unsigned int freq);
 int q6afe_vote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
-			     char *client_name, uint32_t *client_handle);
+			     const char *client_name, uint32_t *client_handle);
 int q6afe_unvote_lpass_core_hw(struct device *dev, uint32_t hw_block_id,
 			       uint32_t client_handle);
 #endif /* __Q6AFE_H__ */
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 4705c3da6280..f9aba413e495 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -208,10 +208,11 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 
 	if (dai->driver->ops &&
 	    dai->driver->ops->xlate_tdm_slot_mask)
-		dai->driver->ops->xlate_tdm_slot_mask(slots,
-						      &tx_mask, &rx_mask);
+		ret = dai->driver->ops->xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
 	else
-		snd_soc_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
+		ret = snd_soc_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
+	if (ret)
+		goto err;
 
 	dai->tx_mask = tx_mask;
 	dai->rx_mask = rx_mask;
@@ -220,6 +221,7 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	    dai->driver->ops->set_tdm_slot)
 		ret = dai->driver->ops->set_tdm_slot(dai, tx_mask, rx_mask,
 						      slots, slot_width);
+err:
 	return soc_dai_ret(dai, ret);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index a83cd8d8a963..55f7c7999330 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -615,6 +615,33 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
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
@@ -640,7 +667,7 @@ int snd_soc_limit_volume(struct snd_soc_card *card,
 		mc = (struct soc_mixer_control *)kctl->private_value;
 		if (max <= mc->max) {
 			mc->platform_max = max;
-			ret = 0;
+			ret = snd_soc_clip_to_platform_max(kctl);
 		}
 	}
 	return ret;
diff --git a/sound/usb/format.c b/sound/usb/format.c
index 552094012c49..593f1acd8fd3 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -251,7 +251,8 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 	}
 
 	/* Jabra Evolve 65 headset */
-	if (chip->usb_id == USB_ID(0x0b0e, 0x030b)) {
+	if (chip->usb_id == USB_ID(0x0b0e, 0x030b) ||
+	    chip->usb_id == USB_ID(0x0b0e, 0x030c)) {
 		/* only 48kHz for playback while keeping 16kHz for capture */
 		if (fp->nr_rates != 1)
 			return set_fixed_rate(fp, 48000, SNDRV_PCM_RATE_48000);
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index eefa2b34e641..33065b17900f 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -311,10 +311,11 @@ int get_fd_type(int fd)
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
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 33cdcfe10634..f65e03e7cf94 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1503,7 +1503,7 @@ static int set_kcfg_value_str(struct extern_desc *ext, char *ext_val,
 	}
 
 	len = strlen(value);
-	if (value[len - 1] != '"') {
+	if (len < 2 || value[len - 1] != '"') {
 		pr_warn("extern (kcfg) '%s': invalid string config '%s'\n",
 			ext->name, value);
 		return -EINVAL;
diff --git a/tools/testing/selftests/vm/compaction_test.c b/tools/testing/selftests/vm/compaction_test.c
index 7c260060a1a6..00ebd9d508ff 100644
--- a/tools/testing/selftests/vm/compaction_test.c
+++ b/tools/testing/selftests/vm/compaction_test.c
@@ -89,6 +89,8 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
 	int compaction_index = 0;
 	char initial_nr_hugepages[20] = {0};
 	char nr_hugepages[20] = {0};
+	char target_nr_hugepages[24] = {0};
+	int slen;
 
 	/* We want to test with 80% of available memory. Else, OOM killer comes
 	   in to play */
@@ -118,11 +120,18 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
 
 	lseek(fd, 0, SEEK_SET);
 
-	/* Request a large number of huge pages. The Kernel will allocate
-	   as much as it can */
-	if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {
-		ksft_test_result_fail("Failed to write 100000 to /proc/sys/vm/nr_hugepages: %s\n",
-				      strerror(errno));
+	/*
+	 * Request huge pages for about half of the free memory. The Kernel
+	 * will allocate as much as it can, and we expect it will get at least 1/3
+	 */
+	nr_hugepages_ul = mem_free / hugepage_size / 2;
+	snprintf(target_nr_hugepages, sizeof(target_nr_hugepages),
+		 "%lu", nr_hugepages_ul);
+
+	slen = strlen(target_nr_hugepages);
+	if (write(fd, target_nr_hugepages, slen) != slen) {
+		ksft_test_result_fail("Failed to write %lu to /proc/sys/vm/nr_hugepages: %s\n",
+			       nr_hugepages_ul, strerror(errno));
 		goto close_fd;
 	}
 

