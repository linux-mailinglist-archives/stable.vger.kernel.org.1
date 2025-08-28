Return-Path: <stable+bounces-176618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAA7B3A253
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 16:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2AEC165AAA
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 14:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7654312830;
	Thu, 28 Aug 2025 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ugZYARpl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0013128C3;
	Thu, 28 Aug 2025 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391909; cv=none; b=Lti0tBnWVOjSlfpPKgkvYRWEOUUVe65LWZBBFGcuesTOB/ZnHCnFxlEj4CqG+BAJPIMs4ThsQxL+H89nNtPLZCb780g13riCdxASd4LBp0KHchqnv/1mq+qbaY+w5IXOH7NNyYTw1PC18jleTIyzEqm6pq+WA7Jd1Op5svoNOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391909; c=relaxed/simple;
	bh=VaKnr72tTcg30IEzBqeucGA2uyfw7Hnjlfpyyi1wkYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E86R6rUoSEp5d6sP7zdpeGuY8o7YiJ5Xs24rcYwlMlB8moE/QrlMQRarPPGoPAA0U3ncjjcBXhIwPav+24mXhidhvxbOYBibbuctlNobah0a+SZq5h+XURA0PTZi8XQuOy3emxO7vvt0Mg7EDzWkMqzfJwfioQgewuQ+QBJLitU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ugZYARpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E7CC4CEEB;
	Thu, 28 Aug 2025 14:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756391908;
	bh=VaKnr72tTcg30IEzBqeucGA2uyfw7Hnjlfpyyi1wkYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ugZYARplkuim9zsZVUVLarpyfOc+3UhnSt5PJpljfSz9jcT5tXz+dpiBMOJ+M9yNS
	 zQfmwN6118FT8AZxSVYI+R0ZlWSIeUa0jHZAiDwgtEsWzDQJAbHNda86Aslp5BmZvi
	 U5IuEOS+1tbC1GbWEh9Mh67SO/s04SJdSenXdrbk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.4.297
Date: Thu, 28 Aug 2025 16:38:17 +0200
Message-ID: <2025082817-decidable-mundane-5fe0@gregkh>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082817-scrabble-skirmish-579f@gregkh>
References: <2025082817-scrabble-skirmish-579f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/firmware-guide/acpi/i2c-muxes.rst b/Documentation/firmware-guide/acpi/i2c-muxes.rst
index 3a8997ccd7c4..f366539acd79 100644
--- a/Documentation/firmware-guide/acpi/i2c-muxes.rst
+++ b/Documentation/firmware-guide/acpi/i2c-muxes.rst
@@ -14,7 +14,7 @@ Consider this topology::
     |      |   | 0x70 |--CH01--> i2c client B (0x50)
     +------+   +------+
 
-which corresponds to the following ASL::
+which corresponds to the following ASL (in the scope of \_SB)::
 
     Device (SMB1)
     {
@@ -24,7 +24,7 @@ which corresponds to the following ASL::
             Name (_HID, ...)
             Name (_CRS, ResourceTemplate () {
                 I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
-                            AddressingMode7Bit, "^SMB1", 0x00,
+                            AddressingMode7Bit, "\\_SB.SMB1", 0x00,
                             ResourceConsumer,,)
             }
 
@@ -37,7 +37,7 @@ which corresponds to the following ASL::
                     Name (_HID, ...)
                     Name (_CRS, ResourceTemplate () {
                         I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                    AddressingMode7Bit, "^CH00", 0x00,
+                                    AddressingMode7Bit, "\\_SB.SMB1.CH00", 0x00,
                                     ResourceConsumer,,)
                     }
                 }
@@ -52,7 +52,7 @@ which corresponds to the following ASL::
                     Name (_HID, ...)
                     Name (_CRS, ResourceTemplate () {
                         I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                    AddressingMode7Bit, "^CH01", 0x00,
+                                    AddressingMode7Bit, "\\_SB.SMB1.CH01", 0x00,
                                     ResourceConsumer,,)
                     }
                 }
diff --git a/Makefile b/Makefile
index f65e282f4a3f..3a6324569093 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 296
+SUBLEVEL = 297
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
@@ -568,8 +568,7 @@ ifneq ($(LLVM_IAS),1)
 CLANG_FLAGS	+= -no-integrated-as
 endif
 CLANG_FLAGS	+= -Werror=unknown-warning-option
-KBUILD_CFLAGS	+= $(CLANG_FLAGS)
-KBUILD_AFLAGS	+= $(CLANG_FLAGS)
+KBUILD_CPPFLAGS	+= $(CLANG_FLAGS)
 export CLANG_FLAGS
 endif
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 4f098edfbf20..cb33ed8de5f8 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -136,7 +136,7 @@ endif
 
 # Need -Uarm for gcc < 3.x
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
-KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
+KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include $(srctree)/arch/arm/include/asm/unified.h -msoft-float
 
 CHECKFLAGS	+= -D__arm__
 
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts b/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts
index 4e99e6c79a68..9b347029c2f6 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts
@@ -168,7 +168,6 @@
 	pinctrl-0 = <&pinctrl_uart2>;
 	linux,rs485-enabled-at-boot-time;
 	rs485-rx-during-tx;
-	rs485-rts-active-low;
 	uart-has-rtscts;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index fa248066d9d9..3679922bbabc 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -617,7 +617,7 @@
 
 			ftm: ftm@400b8000 {
 				compatible = "fsl,ftm-timer";
-				reg = <0x400b8000 0x1000 0x400b9000 0x1000>;
+				reg = <0x400b8000 0x1000>, <0x400b9000 0x1000>;
 				interrupts = <44 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "ftm-evt", "ftm-src",
 					"ftm-evt-counter-en", "ftm-src-counter-en";
diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
index 649e0a54784c..246a525d1d26 100644
--- a/arch/arm/mach-rockchip/platsmp.c
+++ b/arch/arm/mach-rockchip/platsmp.c
@@ -279,11 +279,6 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
-		if (rockchip_smp_prepare_sram(node)) {
-			of_node_put(node);
-			return;
-		}
-
 		/* enable the SCU power domain */
 		pmu_set_power_domain(PMU_PWRDN_SCU, true);
 
@@ -316,11 +311,19 @@ static void __init rockchip_smp_prepare_cpus(unsigned int max_cpus)
 		asm ("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
 		ncores = ((l2ctlr >> 24) & 0x3) + 1;
 	}
-	of_node_put(node);
 
 	/* Make sure that all cores except the first are really off */
 	for (i = 1; i < ncores; i++)
 		pmu_set_power_domain(0 + i, false);
+
+	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
+		if (rockchip_smp_prepare_sram(node)) {
+			of_node_put(node);
+			return;
+		}
+	}
+
+	of_node_put(node);
 }
 
 static void __init rk3036_smp_prepare_cpus(unsigned int max_cpus)
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index 76a65df42d10..dce0cb1fdd6f 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -63,7 +63,7 @@ static void __init tegra_cpu_reset_handler_enable(void)
 	BUG_ON(is_enabled);
 	BUG_ON(tegra_cpu_reset_handler_size > TEGRA_IRAM_RESET_HANDLER_SIZE);
 
-	memcpy(iram_base, (void *)__tegra_cpu_reset_handler_start,
+	memcpy_toio(iram_base, (void *)__tegra_cpu_reset_handler_start,
 			tegra_cpu_reset_handler_size);
 
 	err = call_firmware_op(set_cpu_boot_addr, 0, reset_address);
diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index cbf97e648d19..d1ddf5575973 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -141,7 +141,7 @@ acpi_set_mailbox_entry(int cpu, struct acpi_madt_generic_interrupt *processor)
 {}
 #endif
 
-static inline const char *acpi_get_enable_method(int cpu)
+static __always_inline const char *acpi_get_enable_method(int cpu)
 {
 	if (acpi_psci_present())
 		return "psci";
diff --git a/arch/m68k/Kconfig.debug b/arch/m68k/Kconfig.debug
index f43643111eaf..f9fa89ba259d 100644
--- a/arch/m68k/Kconfig.debug
+++ b/arch/m68k/Kconfig.debug
@@ -10,7 +10,7 @@ config BOOTPARAM_STRING
 
 config EARLY_PRINTK
 	bool "Early printk"
-	depends on !(SUN3 || M68000 || COLDFIRE)
+	depends on MMU_MOTOROLA
 	help
           Write kernel log output directly to a serial port.
           Where implemented, output goes to the framebuffer as well.
diff --git a/arch/m68k/kernel/early_printk.c b/arch/m68k/kernel/early_printk.c
index f11ef9f1f56f..521cbb8a150c 100644
--- a/arch/m68k/kernel/early_printk.c
+++ b/arch/m68k/kernel/early_printk.c
@@ -16,25 +16,10 @@
 #include "../mvme147/mvme147.h"
 #include "../mvme16x/mvme16x.h"
 
-asmlinkage void __init debug_cons_nputs(const char *s, unsigned n);
-
-static void __ref debug_cons_write(struct console *c,
-				   const char *s, unsigned n)
-{
-#if !(defined(CONFIG_SUN3) || defined(CONFIG_M68000) || \
-      defined(CONFIG_COLDFIRE))
-	if (MACH_IS_MVME147)
-		mvme147_scc_write(c, s, n);
-	else if (MACH_IS_MVME16x)
-		mvme16x_cons_write(c, s, n);
-	else
-		debug_cons_nputs(s, n);
-#endif
-}
+asmlinkage void __init debug_cons_nputs(struct console *c, const char *s, unsigned int n);
 
 static struct console early_console_instance = {
 	.name  = "debug",
-	.write = debug_cons_write,
 	.flags = CON_PRINTBUFFER | CON_BOOT,
 	.index = -1
 };
@@ -44,6 +29,12 @@ static int __init setup_early_printk(char *buf)
 	if (early_console || buf)
 		return 0;
 
+	if (MACH_IS_MVME147)
+		early_console_instance.write = mvme147_scc_write;
+	else if (MACH_IS_MVME16x)
+		early_console_instance.write = mvme16x_cons_write;
+	else
+		early_console_instance.write = debug_cons_nputs;
 	early_console = &early_console_instance;
 	register_console(early_console);
 
@@ -51,20 +42,15 @@ static int __init setup_early_printk(char *buf)
 }
 early_param("earlyprintk", setup_early_printk);
 
-/*
- * debug_cons_nputs() defined in arch/m68k/kernel/head.S cannot be called
- * after init sections are discarded (for platforms that use it).
- */
-#if !(defined(CONFIG_SUN3) || defined(CONFIG_M68000) || \
-      defined(CONFIG_COLDFIRE))
-
 static int __init unregister_early_console(void)
 {
-	if (!early_console || MACH_IS_MVME16x)
-		return 0;
+	/*
+	 * debug_cons_nputs() defined in arch/m68k/kernel/head.S cannot be
+	 * called after init sections are discarded (for platforms that use it).
+	 */
+	if (early_console && early_console->write == debug_cons_nputs)
+		return unregister_console(early_console);
 
-	return unregister_console(early_console);
+	return 0;
 }
 late_initcall(unregister_early_console);
-
-#endif
diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
index a54788458ca3..41e34817bd02 100644
--- a/arch/m68k/kernel/head.S
+++ b/arch/m68k/kernel/head.S
@@ -3242,8 +3242,8 @@ func_return	putn
  *	turns around and calls the internal routines.  This routine
  *	is used by the boot console.
  *
- *	The calling parameters are:
- *		void debug_cons_nputs(const char *str, unsigned length)
+ *	The function signature is -
+ *		void debug_cons_nputs(struct console *c, const char *s, unsigned int n)
  *
  *	This routine does NOT understand variable arguments only
  *	simple strings!
@@ -3252,8 +3252,8 @@ ENTRY(debug_cons_nputs)
 	moveml	%d0/%d1/%a0,%sp@-
 	movew	%sr,%sp@-
 	ori	#0x0700,%sr
-	movel	%sp@(18),%a0		/* fetch parameter */
-	movel	%sp@(22),%d1		/* fetch parameter */
+	movel	%sp@(22),%a0		/* char *s */
+	movel	%sp@(26),%d1		/* unsigned int n */
 	jra	2f
 1:
 #ifdef CONSOLE_DEBUG
@@ -3379,6 +3379,7 @@ L(console_clear_loop):
 
 	movel	%d4,%d1				/* screen height in pixels */
 	divul	%a0@(FONT_DESC_HEIGHT),%d1	/* d1 = max num rows */
+	subql	#1,%d1				/* row range is 0 to num - 1 */
 
 	movel	%d0,%a2@(Lconsole_struct_num_columns)
 	movel	%d1,%a2@(Lconsole_struct_num_rows)
@@ -3525,15 +3526,14 @@ func_start	console_putc,%a0/%a1/%d0-%d7
 	cmpib	#10,%d7
 	jne	L(console_not_lf)
 	movel	%a0@(Lconsole_struct_cur_row),%d0
-	addil	#1,%d0
-	movel	%d0,%a0@(Lconsole_struct_cur_row)
 	movel	%a0@(Lconsole_struct_num_rows),%d1
 	cmpl	%d1,%d0
 	jcs	1f
-	subil	#1,%d0
-	movel	%d0,%a0@(Lconsole_struct_cur_row)
 	console_scroll
+	jra	L(console_exit)
 1:
+	addql	#1,%d0
+	movel	%d0,%a0@(Lconsole_struct_cur_row)
 	jra	L(console_exit)
 
 L(console_not_lf):
@@ -3560,12 +3560,6 @@ L(console_not_cr):
  */
 L(console_not_home):
 	movel	%a0@(Lconsole_struct_cur_column),%d0
-	addql	#1,%a0@(Lconsole_struct_cur_column)
-	movel	%a0@(Lconsole_struct_num_columns),%d1
-	cmpl	%d1,%d0
-	jcs	1f
-	console_putc	#'\n'	/* recursion is OK! */
-1:
 	movel	%a0@(Lconsole_struct_cur_row),%d1
 
 	/*
@@ -3612,6 +3606,23 @@ L(console_do_font_scanline):
 	addq	#1,%d1
 	dbra	%d7,L(console_read_char_scanline)
 
+	/*
+	 *	Register usage in the code below:
+	 *	a0 = pointer to console globals
+	 *	d0 = cursor column
+	 *	d1 = cursor column limit
+	 */
+
+	lea	%pc@(L(console_globals)),%a0
+
+	movel	%a0@(Lconsole_struct_cur_column),%d0
+	addql	#1,%d0
+	movel	%d0,%a0@(Lconsole_struct_cur_column)	/* Update cursor pos */
+	movel	%a0@(Lconsole_struct_num_columns),%d1
+	cmpl	%d1,%d0
+	jcs	L(console_exit)
+	console_putc	#'\n'		/* Line wrap using tail recursion */
+
 L(console_exit):
 func_return	console_putc
 
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 4542258027a7..cc6f8265f28c 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -319,7 +319,7 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 KBUILD_LDFLAGS		+= -m $(ld-emul)
 
 ifdef CONFIG_MIPS
-CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
+CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
 	egrep -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
 	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
 endif
diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
index 012731546cf6..3de6b0ff1627 100644
--- a/arch/mips/include/asm/vpe.h
+++ b/arch/mips/include/asm/vpe.h
@@ -126,4 +126,12 @@ void cleanup_tc(struct tc *tc);
 
 int __init vpe_module_init(void);
 void __exit vpe_module_exit(void);
+
+#ifdef CONFIG_MIPS_VPE_LOADER_MT
+void *vpe_alloc(void);
+int vpe_start(void *vpe, unsigned long start);
+int vpe_stop(void *vpe);
+int vpe_free(void *vpe);
+#endif /* CONFIG_MIPS_VPE_LOADER_MT */
+
 #endif /* _ASM_VPE_H */
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 339870ed92f7..42e95e6edd1d 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -654,18 +654,20 @@ unsigned long mips_stack_top(void)
 	top -= PAGE_SIZE;
 
 	/* Space for the VDSO, data page & GIC user page */
-	top -= PAGE_ALIGN(current->thread.abi->vdso->size);
-	top -= PAGE_SIZE;
-	top -= mips_gic_present() ? PAGE_SIZE : 0;
+	if (current->thread.abi) {
+		top -= PAGE_ALIGN(current->thread.abi->vdso->size);
+		top -= PAGE_SIZE;
+		top -= mips_gic_present() ? PAGE_SIZE : 0;
+
+		/* Space to randomize the VDSO base */
+		if (current->flags & PF_RANDOMIZE)
+			top -= VDSO_RANDOMIZE_SIZE;
+	}
 
 	/* Space for cache colour alignment */
 	if (cpu_has_dc_aliases)
 		top -= shm_align_mask + 1;
 
-	/* Space to randomize the VDSO base */
-	if (current->flags & PF_RANDOMIZE)
-		top -= VDSO_RANDOMIZE_SIZE;
-
 	return top;
 }
 
diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index b6104d9413e0..5f63235e110e 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -497,6 +497,60 @@ static int __init set_ntlb(char *str)
 
 __setup("ntlb=", set_ntlb);
 
+/* Initialise all TLB entries with unique values */
+static void r4k_tlb_uniquify(void)
+{
+	int entry = num_wired_entries();
+
+	htw_stop();
+	write_c0_entrylo0(0);
+	write_c0_entrylo1(0);
+
+	while (entry < current_cpu_data.tlbsize) {
+		unsigned long asid_mask = cpu_asid_mask(&current_cpu_data);
+		unsigned long asid = 0;
+		int idx;
+
+		/* Skip wired MMID to make ginvt_mmid work */
+		if (cpu_has_mmid)
+			asid = MMID_KERNEL_WIRED + 1;
+
+		/* Check for match before using UNIQUE_ENTRYHI */
+		do {
+			if (cpu_has_mmid) {
+				write_c0_memorymapid(asid);
+				write_c0_entryhi(UNIQUE_ENTRYHI(entry));
+			} else {
+				write_c0_entryhi(UNIQUE_ENTRYHI(entry) | asid);
+			}
+			mtc0_tlbw_hazard();
+			tlb_probe();
+			tlb_probe_hazard();
+			idx = read_c0_index();
+			/* No match or match is on current entry */
+			if (idx < 0 || idx == entry)
+				break;
+			/*
+			 * If we hit a match, we need to try again with
+			 * a different ASID.
+			 */
+			asid++;
+		} while (asid < asid_mask);
+
+		if (idx >= 0 && idx != entry)
+			panic("Unable to uniquify TLB entry %d", idx);
+
+		write_c0_index(entry);
+		mtc0_tlbw_hazard();
+		tlb_write_indexed();
+		entry++;
+	}
+
+	tlbw_use_hazard();
+	htw_start();
+	flush_micro_tlb();
+}
+
 /*
  * Configure TLB (for init or after a CPU has been powered off).
  */
@@ -536,7 +590,7 @@ static void r4k_tlb_configure(void)
 	temp_tlb_entry = current_cpu_data.tlbsize - 1;
 
 	/* From this point on the ARC firmware is dead.	 */
-	local_flush_tlb_all();
+	r4k_tlb_uniquify();
 
 	/* Did I tell you that ARC SUCKS?  */
 }
diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 04460c2d2f8c..f5c8e3485c63 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -134,7 +134,7 @@ palo lifimage: vmlinuz
 	fi
 	@if test ! -f "$(PALOCONF)"; then \
 		cp $(srctree)/arch/parisc/defpalo.conf $(objtree)/palo.conf; \
-		echo 'A generic palo config file ($(objree)/palo.conf) has been created for you.'; \
+		echo 'A generic palo config file ($(objtree)/palo.conf) has been created for you.'; \
 		echo 'You should check it and re-run "make palo".'; \
 		echo 'WARNING: the "lifimage" file is now placed in this directory by default!'; \
 		false; \
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index b75b62b094b5..319fe81a4a39 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -274,7 +274,6 @@ CONFIG_NET_SCH_DSMARK=m
 CONFIG_NET_SCH_NETEM=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_CLS_BASIC=m
-CONFIG_NET_CLS_TCINDEX=m
 CONFIG_NET_CLS_ROUTE4=m
 CONFIG_NET_CLS_FW=m
 CONFIG_NET_CLS_U32=m
diff --git a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
index 13631f35cd14..12fb94968f3c 100644
--- a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
+++ b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
@@ -240,10 +240,8 @@ static int mpc512x_lpbfifo_kick(void)
 	dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
 	/* Make DMA channel work with LPB FIFO data register */
-	if (dma_dev->device_config(lpbfifo.chan, &dma_conf)) {
-		ret = -EINVAL;
-		goto err_dma_prep;
-	}
+	if (dma_dev->device_config(lpbfifo.chan, &dma_conf))
+		return -EINVAL;
 
 	sg_init_table(&sg, 1);
 
diff --git a/arch/s390/hypfs/hypfs_dbfs.c b/arch/s390/hypfs/hypfs_dbfs.c
index f4c7dbfaf8ee..5848f2e374a6 100644
--- a/arch/s390/hypfs/hypfs_dbfs.c
+++ b/arch/s390/hypfs/hypfs_dbfs.c
@@ -6,6 +6,7 @@
  * Author(s): Michael Holzheu <holzheu@linux.vnet.ibm.com>
  */
 
+#include <linux/security.h>
 #include <linux/slab.h>
 #include "hypfs.h"
 
@@ -64,24 +65,28 @@ static long dbfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	long rc;
 
 	mutex_lock(&df->lock);
-	if (df->unlocked_ioctl)
-		rc = df->unlocked_ioctl(file, cmd, arg);
-	else
-		rc = -ENOTTY;
+	rc = df->unlocked_ioctl(file, cmd, arg);
 	mutex_unlock(&df->lock);
 	return rc;
 }
 
-static const struct file_operations dbfs_ops = {
+static const struct file_operations dbfs_ops_ioctl = {
 	.read		= dbfs_read,
 	.llseek		= no_llseek,
 	.unlocked_ioctl = dbfs_ioctl,
 };
 
+static const struct file_operations dbfs_ops = {
+	.read		= dbfs_read,
+};
+
 void hypfs_dbfs_create_file(struct hypfs_dbfs_file *df)
 {
-	df->dentry = debugfs_create_file(df->name, 0400, dbfs_dir, df,
-					 &dbfs_ops);
+	const struct file_operations *fops = &dbfs_ops;
+
+	if (df->unlocked_ioctl && !security_locked_down(LOCKDOWN_DEBUGFS))
+		fops = &dbfs_ops_ioctl;
+	df->dentry = debugfs_create_file(df->name, 0400, dbfs_dir, df, fops);
 	mutex_init(&df->lock);
 }
 
diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index 99a7e028232d..8ab537d0d6f8 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -172,13 +172,6 @@ static inline unsigned long long get_tod_clock_fast(void)
 	return get_tod_clock();
 #endif
 }
-
-static inline cycles_t get_cycles(void)
-{
-	return (cycles_t) get_tod_clock() >> 2;
-}
-#define get_cycles get_cycles
-
 int get_phys_clock(unsigned long *clock);
 void init_cpu_timer(void);
 unsigned long long monotonic_clock(void);
@@ -202,6 +195,12 @@ static inline unsigned long long get_tod_clock_monotonic(void)
 	return tod;
 }
 
+static inline cycles_t get_cycles(void)
+{
+	return (cycles_t)get_tod_clock_monotonic() >> 2;
+}
+#define get_cycles get_cycles
+
 /**
  * tod_to_ns - convert a TOD format value to nanoseconds
  * @todval: to be converted TOD format value
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 11c32b228f51..0e1925104fcf 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -642,7 +642,7 @@ static int stp_sync_clock(void *data)
 		atomic_dec(&sync->cpus);
 		/* Wait for in_sync to be set. */
 		while (READ_ONCE(sync->in_sync) == 0)
-			__udelay(1);
+			;
 	}
 	if (sync->in_sync != 1)
 		/* Didn't work. Clear per-cpu in sync bit again. */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 816b3d0512ba..ad71f5a7faf0 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1180,13 +1180,20 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
 	}
 
 	bank_type = smca_get_bank_type(bank);
-	if (bank_type >= N_SMCA_BANK_TYPES)
-		return NULL;
 
 	if (b && bank_type == SMCA_UMC) {
 		if (b->block < ARRAY_SIZE(smca_umc_block_names))
 			return smca_umc_block_names[b->block];
-		return NULL;
+	}
+
+	if (b && b->block) {
+		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN, "th_block_%u", b->block);
+		return buf_mcatype;
+	}
+
+	if (bank_type >= N_SMCA_BANK_TYPES) {
+		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN, "th_bank_%u", bank);
+		return buf_mcatype;
 	}
 
 	if (smca_banks[bank].hwid->count == 1)
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 30bb0bd3b1b8..ae7e056d0007 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -59,13 +59,12 @@ __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 				    unsigned long error_code,
 				    unsigned long fault_addr)
 {
-	regs->ip = ex_fixup_addr(fixup);
-
 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
 		  (void *)instruction_pointer(regs));
 
 	__copy_kernel_to_fpregs(&init_fpstate, -1);
-	return true;
+
+	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
 }
 EXPORT_SYMBOL_GPL(ex_handler_fprestore);
 
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index c8338d627857..9cbf0593da05 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -228,7 +228,7 @@ static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
 
 static int acpi_processor_get_info(struct acpi_device *device)
 {
-	union acpi_object object = { 0 };
+	union acpi_object object = { .processor = { 0 } };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 	struct acpi_processor *pr = acpi_driver_data(device);
 	int device_declaration = 0;
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 50bed5a70812..d02d7cbab387 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -709,6 +709,8 @@ static void __ghes_panic(struct ghes *ghes,
 
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
 
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
+
 	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
 
 	if (!panic_timeout)
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 92db8b0622b2..e6bba26caf3c 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1228,7 +1228,9 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 
 	status = acpi_get_parent(handle, &pr_ahandle);
 	while (ACPI_SUCCESS(status)) {
-		acpi_bus_get_device(pr_ahandle, &d);
+		if (acpi_bus_get_device(pr_ahandle, &d))
+			break;
+
 		handle = pr_ahandle;
 
 		if (strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 6937aedc0a03..4db106e5ce1a 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -176,6 +176,9 @@ void acpi_processor_ppc_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu;
 
+	if (ignore_ppc == 1)
+		return;
+
 	for_each_cpu(cpu, policy->related_cpus) {
 		struct acpi_processor *pr = per_cpu(processors, cpu);
 		int ret;
@@ -196,6 +199,14 @@ void acpi_processor_ppc_init(struct cpufreq_policy *policy)
 		if (ret < 0)
 			pr_err("Failed to add freq constraint for CPU%d (%d)\n",
 			       cpu, ret);
+
+		if (!pr->performance)
+			continue;
+
+		ret = acpi_processor_get_platform_limit(pr);
+		if (ret)
+			pr_err("Failed to update freq constraint for CPU%d (%d)\n",
+			       cpu, ret);
 	}
 }
 
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a6beb2c5a692..dbde78feda31 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -92,22 +92,39 @@ config SATA_AHCI
 
 config SATA_MOBILE_LPM_POLICY
 	int "Default SATA Link Power Management policy for mobile chipsets"
-	range 0 4
+	range 0 5
 	default 0
 	depends on SATA_AHCI
 	help
 	  Select the Default SATA Link Power Management (LPM) policy to use
 	  for mobile / laptop variants of chipsets / "South Bridges".
 
-	  The value set has the following meanings:
+	  Each policy combines power saving states and features:
+	   - Partial: The Phy logic is powered but is in a reduced power
+                      state. The exit latency from this state is no longer than
+                      10us).
+	   - Slumber: The Phy logic is powered but is in an even lower power
+                      state. The exit latency from this state is potentially
+		      longer, but no longer than 10ms.
+	   - DevSleep: The Phy logic may be powered down. The exit latency from
+	               this state is no longer than 20 ms, unless otherwise
+		       specified by DETO in the device Identify Device Data log.
+	   - HIPM: Host Initiated Power Management (host automatically
+		   transitions to partial and slumber).
+	   - DIPM: Device Initiated Power Management (device automatically
+		   transitions to partial and slumber).
+
+	  The possible values for the default SATA link power management
+	  policies are:
 		0 => Keep firmware settings
-		1 => Maximum performance
-		2 => Medium power
-		3 => Medium power with Device Initiated PM enabled
-		4 => Minimum power
-
-	  Note "Minimum power" is known to cause issues, including disk
-	  corruption, with some disks and should not be used.
+		1 => No power savings (maximum performance)
+		2 => HIPM (Partial)
+		3 => HIPM (Partial) and DIPM (Partial and Slumber)
+		4 => HIPM (Partial and DevSleep) and DIPM (Partial and Slumber)
+		5 => HIPM (Slumber and DevSleep) and DIPM (Partial and Slumber)
+
+	  Excluding the value 0, higher values represent policies with higher
+	  power savings.
 
 config SATA_AHCI_PLATFORM
 	tristate "Platform AHCI SATA support"
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c621c98c6057..35c87e7e4ddf 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -984,18 +984,14 @@ static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
 		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
 	};
 	static const unsigned char stat_table[][4] = {
-		/* Must be first because BUSY means no other bits valid */
-		{0x80,		ABORTED_COMMAND, 0x47, 0x00},
-		// Busy, fake parity for now
-		{0x40,		ILLEGAL_REQUEST, 0x21, 0x04},
-		// Device ready, unaligned write command
-		{0x20,		HARDWARE_ERROR,  0x44, 0x00},
-		// Device fault, internal target failure
-		{0x08,		ABORTED_COMMAND, 0x47, 0x00},
-		// Timed out in xfer, fake parity for now
-		{0x04,		RECOVERED_ERROR, 0x11, 0x00},
-		// Recovered ECC error	  Medium error, recovered
-		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
+		/* Busy: must be first because BUSY means no other bits valid */
+		{ ATA_BUSY,	ABORTED_COMMAND, 0x00, 0x00 },
+		/* Device fault: INTERNAL TARGET FAILURE */
+		{ ATA_DF,	HARDWARE_ERROR,  0x44, 0x00 },
+		/* Corrected data error */
+		{ ATA_CORR,	RECOVERED_ERROR, 0x00, 0x00 },
+
+		{ 0xFF, 0xFF, 0xFF, 0xFF }, /* END mark */
 	};
 
 	/*
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 490ed7deb99a..35f2e961756b 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -8,6 +8,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/hrtimer.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/ktime.h>
@@ -254,6 +255,8 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	struct cpuidle_device *dev;
 	ktime_t domain_wakeup, next_hrtimer;
+	struct device *cpu_dev;
+	s64 cpu_constraint, global_constraint;
 	s64 idle_duration_ns;
 	int cpu, i;
 
@@ -264,6 +267,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
 		return true;
 
+	global_constraint = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 	/*
 	 * Find the next wakeup for any of the online CPUs within the PM domain
 	 * and its subdomains. Note, we only need the genpd->cpus, as it already
@@ -277,8 +281,16 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 			if (ktime_before(next_hrtimer, domain_wakeup))
 				domain_wakeup = next_hrtimer;
 		}
+
+		cpu_dev = get_cpu_device(cpu);
+		if (cpu_dev) {
+			cpu_constraint = dev_pm_qos_raw_resume_latency(cpu_dev);
+			if (cpu_constraint < global_constraint)
+				global_constraint = cpu_constraint;
+		}
 	}
 
+	global_constraint *= NSEC_PER_USEC;
 	/* The minimum idle duration is from now - until the next wakeup. */
 	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, ktime_get()));
 	if (idle_duration_ns <= 0)
@@ -291,8 +303,10 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	 */
 	i = genpd->state_idx;
 	do {
-		if (idle_duration_ns >= (genpd->states[i].residency_ns +
-		    genpd->states[i].power_off_latency_ns)) {
+		if ((idle_duration_ns >= (genpd->states[i].residency_ns +
+		    genpd->states[i].power_off_latency_ns)) &&
+		    (global_constraint >= (genpd->states[i].power_on_latency_ns +
+		    genpd->states[i].power_off_latency_ns))) {
 			genpd->state_idx = i;
 			return true;
 		}
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7fa231076ad5..7d362b38f2e8 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1698,6 +1698,11 @@ void pm_runtime_reinit(struct device *dev)
 				pm_runtime_put(dev->parent);
 		}
 	}
+	/*
+	 * Clear power.needs_force_resume in case it has been set by
+	 * pm_runtime_force_suspend() invoked from a driver remove callback.
+	 */
+	dev->power.needs_force_resume = false;
 }
 
 /**
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index d94f41a0abbe..d75050b0d1b3 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -2531,7 +2531,11 @@ static int handle_write_conflicts(struct drbd_device *device,
 			peer_req->w.cb = superseded ? e_send_superseded :
 						   e_send_retry_write;
 			list_add_tail(&peer_req->w.list, &device->done_ee);
-			queue_work(connection->ack_sender, &peer_req->peer_device->send_acks_work);
+			/* put is in drbd_send_acks_wf() */
+			kref_get(&device->kref);
+			if (!queue_work(connection->ack_sender,
+					&peer_req->peer_device->send_acks_work))
+				kref_put(&device->kref, drbd_destroy_device);
 
 			err = -ENOENT;
 			goto out;
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 6622dd1aa07b..59d73c3147b6 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -967,8 +967,10 @@ static bool vdc_port_mpgroup_check(struct vio_dev *vdev)
 	dev = device_find_child(vdev->dev.parent, &port_data,
 				vdc_device_probed);
 
-	if (dev)
+	if (dev) {
+		put_device(dev);
 		return true;
+	}
 
 	return false;
 }
diff --git a/drivers/char/hw_random/mtk-rng.c b/drivers/char/hw_random/mtk-rng.c
index 6c21eb749b51..f5325fe4f1de 100644
--- a/drivers/char/hw_random/mtk-rng.c
+++ b/drivers/char/hw_random/mtk-rng.c
@@ -149,7 +149,9 @@ static int mtk_rng_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, priv);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, RNG_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
-	devm_pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
 
 	dev_info(&pdev->dev, "registered RNG driver\n");
 
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 0833a2ac2f69..b8a13edee817 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4302,10 +4302,10 @@ static int handle_one_recv_msg(struct ipmi_smi *intf,
 		 * The NetFN and Command in the response is not even
 		 * marginally correct.
 		 */
-		dev_warn(intf->si_dev,
-			 "BMC returned incorrect response, expected netfn %x cmd %x, got netfn %x cmd %x\n",
-			 (msg->data[0] >> 2) | 1, msg->data[1],
-			 msg->rsp[0] >> 2, msg->rsp[1]);
+		dev_warn_ratelimited(intf->si_dev,
+				     "BMC returned incorrect response, expected netfn %x cmd %x, got netfn %x cmd %x\n",
+				     (msg->data[0] >> 2) | 1, msg->data[1],
+				     msg->rsp[0] >> 2, msg->rsp[1]);
 
 		/* Generate an error response for the message. */
 		msg->rsp[0] = msg->data[0] | (1 << 2);
diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index ccb62c480bdd..ac2099f3f41a 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -1192,14 +1192,8 @@ static struct ipmi_smi_watcher smi_watcher = {
 	.smi_gone = ipmi_smi_gone
 };
 
-static int action_op(const char *inval, char *outval)
+static int action_op_set_val(const char *inval)
 {
-	if (outval)
-		strcpy(outval, action);
-
-	if (!inval)
-		return 0;
-
 	if (strcmp(inval, "reset") == 0)
 		action_val = WDOG_TIMEOUT_RESET;
 	else if (strcmp(inval, "none") == 0)
@@ -1210,18 +1204,26 @@ static int action_op(const char *inval, char *outval)
 		action_val = WDOG_TIMEOUT_POWER_DOWN;
 	else
 		return -EINVAL;
-	strcpy(action, inval);
 	return 0;
 }
 
-static int preaction_op(const char *inval, char *outval)
+static int action_op(const char *inval, char *outval)
 {
+	int rv;
+
 	if (outval)
-		strcpy(outval, preaction);
+		strcpy(outval, action);
 
 	if (!inval)
 		return 0;
+	rv = action_op_set_val(inval);
+	if (!rv)
+		strcpy(action, inval);
+	return rv;
+}
 
+static int preaction_op_set_val(const char *inval)
+{
 	if (strcmp(inval, "pre_none") == 0)
 		preaction_val = WDOG_PRETIMEOUT_NONE;
 	else if (strcmp(inval, "pre_smi") == 0)
@@ -1234,18 +1236,26 @@ static int preaction_op(const char *inval, char *outval)
 		preaction_val = WDOG_PRETIMEOUT_MSG_INT;
 	else
 		return -EINVAL;
-	strcpy(preaction, inval);
 	return 0;
 }
 
-static int preop_op(const char *inval, char *outval)
+static int preaction_op(const char *inval, char *outval)
 {
+	int rv;
+
 	if (outval)
-		strcpy(outval, preop);
+		strcpy(outval, preaction);
 
 	if (!inval)
 		return 0;
+	rv = preaction_op_set_val(inval);
+	if (!rv)
+		strcpy(preaction, inval);
+	return 0;
+}
 
+static int preop_op_set_val(const char *inval)
+{
 	if (strcmp(inval, "preop_none") == 0)
 		preop_val = WDOG_PREOP_NONE;
 	else if (strcmp(inval, "preop_panic") == 0)
@@ -1254,7 +1264,22 @@ static int preop_op(const char *inval, char *outval)
 		preop_val = WDOG_PREOP_GIVE_DATA;
 	else
 		return -EINVAL;
-	strcpy(preop, inval);
+	return 0;
+}
+
+static int preop_op(const char *inval, char *outval)
+{
+	int rv;
+
+	if (outval)
+		strcpy(outval, preop);
+
+	if (!inval)
+		return 0;
+
+	rv = preop_op_set_val(inval);
+	if (!rv)
+		strcpy(preop, inval);
 	return 0;
 }
 
@@ -1291,18 +1316,18 @@ static int __init ipmi_wdog_init(void)
 {
 	int rv;
 
-	if (action_op(action, NULL)) {
+	if (action_op_set_val(action)) {
 		action_op("reset", NULL);
 		pr_info("Unknown action '%s', defaulting to reset\n", action);
 	}
 
-	if (preaction_op(preaction, NULL)) {
+	if (preaction_op_set_val(preaction)) {
 		preaction_op("pre_none", NULL);
 		pr_info("Unknown preaction '%s', defaulting to none\n",
 			preaction);
 	}
 
-	if (preop_op(preop, NULL)) {
+	if (preop_op_set_val(preop)) {
 		preop_op("preop_none", NULL);
 		pr_info("Unknown preop '%s', defaulting to none\n", preop);
 	}
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index 5b69e24a224f..2e153320fc53 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -278,6 +278,11 @@ davinci_lpsc_clk_register(struct device *dev, const char *name,
 
 	lpsc->pm_domain.name = devm_kasprintf(dev, GFP_KERNEL, "%s: %s",
 					      best_dev_name(dev), name);
+	if (!lpsc->pm_domain.name) {
+		clk_hw_unregister(&lpsc->hw);
+		kfree(lpsc);
+		return ERR_PTR(-ENOMEM);
+	}
 	lpsc->pm_domain.attach_dev = davinci_psc_genpd_attach_dev;
 	lpsc->pm_domain.detach_dev = davinci_psc_genpd_detach_dev;
 	lpsc->pm_domain.flags = GENPD_FLAG_PM_CLK;
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index 0e36ca3bf3d5..4fddb489cdce 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -334,8 +334,7 @@ static SUNXI_CCU_GATE(dram_ohci_clk,	"dram-ohci",	"dram",
 
 static const char * const de_parents[] = { "pll-video", "pll-periph0" };
 static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents,
-				 0x104, 0, 4, 24, 2, BIT(31),
-				 CLK_SET_RATE_PARENT);
+				 0x104, 0, 4, 24, 3, BIT(31), 0);
 
 static const char * const tcon_parents[] = { "pll-video" };
 static SUNXI_CCU_M_WITH_MUX_GATE(tcon_clk, "tcon", tcon_parents,
diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
index b0fc5e84f857..cab86a9be6bd 100644
--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -96,7 +96,7 @@ static void armada_8k_cpufreq_free_table(struct freq_table *freq_tables)
 {
 	int opps_index, nb_cpus = num_possible_cpus();
 
-	for (opps_index = 0 ; opps_index <= nb_cpus; opps_index++) {
+	for (opps_index = 0 ; opps_index < nb_cpus; opps_index++) {
 		int i;
 
 		/* If cpu_dev is NULL then we reached the end of the array */
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2a2fea6743aa..0f8777343e21 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1220,6 +1220,8 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 		goto err_free_real_cpus;
 	}
 
+	init_rwsem(&policy->rwsem);
+
 	freq_constraints_init(&policy->constraints);
 
 	policy->nb_min.notifier_call = cpufreq_notifier_min;
@@ -1242,7 +1244,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	}
 
 	INIT_LIST_HEAD(&policy->policy_list);
-	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
 	init_waitqueue_head(&policy->transition_wait);
 	INIT_WORK(&policy->update, handle_update);
@@ -2482,10 +2483,12 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	pr_debug("starting governor %s failed\n", policy->governor->name);
 	if (old_gov) {
 		policy->governor = old_gov;
-		if (cpufreq_init_governor(policy))
+		if (cpufreq_init_governor(policy)) {
 			policy->governor = NULL;
-		else
-			cpufreq_start_governor(policy);
+		} else if (cpufreq_start_governor(policy)) {
+			cpufreq_exit_governor(policy);
+			policy->governor = NULL;
+		}
 	}
 
 	return ret;
diff --git a/drivers/crypto/ccp/ccp-debugfs.c b/drivers/crypto/ccp/ccp-debugfs.c
index a1055554b47a..dc26bc22c91d 100644
--- a/drivers/crypto/ccp/ccp-debugfs.c
+++ b/drivers/crypto/ccp/ccp-debugfs.c
@@ -319,5 +319,8 @@ void ccp5_debugfs_setup(struct ccp_device *ccp)
 
 void ccp5_debugfs_destroy(void)
 {
+	mutex_lock(&ccp_debugfs_lock);
 	debugfs_remove_recursive(ccp_debugfs_dir);
+	ccp_debugfs_dir = NULL;
+	mutex_unlock(&ccp_debugfs_lock);
 }
diff --git a/drivers/crypto/img-hash.c b/drivers/crypto/img-hash.c
index 17cc44f14e5c..b5fd15e0c050 100644
--- a/drivers/crypto/img-hash.c
+++ b/drivers/crypto/img-hash.c
@@ -434,7 +434,7 @@ static int img_hash_write_via_dma_stop(struct img_hash_dev *hdev)
 	struct img_hash_request_ctx *ctx = ahash_request_ctx(hdev->req);
 
 	if (ctx->flags & DRIVER_FLAGS_SG)
-		dma_unmap_sg(hdev->dev, ctx->sg, ctx->dma_ct, DMA_TO_DEVICE);
+		dma_unmap_sg(hdev->dev, ctx->sg, 1, DMA_TO_DEVICE);
 
 	return 0;
 }
diff --git a/drivers/crypto/marvell/cipher.c b/drivers/crypto/marvell/cipher.c
index f92f86c94bff..d48034a9e0da 100644
--- a/drivers/crypto/marvell/cipher.c
+++ b/drivers/crypto/marvell/cipher.c
@@ -73,9 +73,12 @@ mv_cesa_skcipher_dma_cleanup(struct skcipher_request *req)
 static inline void mv_cesa_skcipher_cleanup(struct skcipher_request *req)
 {
 	struct mv_cesa_skcipher_req *creq = skcipher_request_ctx(req);
+	struct mv_cesa_engine *engine = creq->base.engine;
 
 	if (mv_cesa_req_get_type(&creq->base) == CESA_DMA_REQ)
 		mv_cesa_skcipher_dma_cleanup(req);
+
+	atomic_sub(req->cryptlen, &engine->load);
 }
 
 static void mv_cesa_skcipher_std_step(struct skcipher_request *req)
@@ -202,7 +205,6 @@ mv_cesa_skcipher_complete(struct crypto_async_request *req)
 	struct mv_cesa_engine *engine = creq->base.engine;
 	unsigned int ivsize;
 
-	atomic_sub(skreq->cryptlen, &engine->load);
 	ivsize = crypto_skcipher_ivsize(crypto_skcipher_reqtfm(skreq));
 
 	if (mv_cesa_req_get_type(&creq->base) == CESA_DMA_REQ) {
diff --git a/drivers/crypto/marvell/hash.c b/drivers/crypto/marvell/hash.c
index de1599bca3b7..01dd597b6a2a 100644
--- a/drivers/crypto/marvell/hash.c
+++ b/drivers/crypto/marvell/hash.c
@@ -107,9 +107,12 @@ static inline void mv_cesa_ahash_dma_cleanup(struct ahash_request *req)
 static inline void mv_cesa_ahash_cleanup(struct ahash_request *req)
 {
 	struct mv_cesa_ahash_req *creq = ahash_request_ctx(req);
+	struct mv_cesa_engine *engine = creq->base.engine;
 
 	if (mv_cesa_req_get_type(&creq->base) == CESA_DMA_REQ)
 		mv_cesa_ahash_dma_cleanup(req);
+
+	atomic_sub(req->nbytes, &engine->load);
 }
 
 static void mv_cesa_ahash_last_cleanup(struct ahash_request *req)
@@ -363,8 +366,6 @@ static void mv_cesa_ahash_complete(struct crypto_async_request *req)
 			}
 		}
 	}
-
-	atomic_sub(ahashreq->nbytes, &engine->load);
 }
 
 static void mv_cesa_ahash_prepare(struct crypto_async_request *req,
diff --git a/drivers/crypto/qat/qat_common/adf_transport_debug.c b/drivers/crypto/qat/qat_common/adf_transport_debug.c
index e794e9d97b2c..9303d6318207 100644
--- a/drivers/crypto/qat/qat_common/adf_transport_debug.c
+++ b/drivers/crypto/qat/qat_common/adf_transport_debug.c
@@ -75,8 +75,10 @@ static void *adf_ring_next(struct seq_file *sfile, void *v, loff_t *pos)
 	struct adf_etr_ring_data *ring = sfile->private;
 
 	if (*pos >= (ADF_SIZE_TO_RING_SIZE_IN_BYTES(ring->ring_size) /
-		     ADF_MSG_SIZE_TO_BYTES(ring->msg_size)))
+		     ADF_MSG_SIZE_TO_BYTES(ring->msg_size))) {
+		(*pos)++;
 		return NULL;
+	}
 
 	return ring->base_addr +
 		(ADF_MSG_SIZE_TO_BYTES(ring->msg_size) * (*pos)++);
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index e96032096042..827a1a9907b6 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1061,8 +1061,16 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	 */
 	mv_chan->dummy_src_addr = dma_map_single(dma_dev->dev,
 		mv_chan->dummy_src, MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dma_dev->dev, mv_chan->dummy_src_addr))
+		return ERR_PTR(-ENOMEM);
+
 	mv_chan->dummy_dst_addr = dma_map_single(dma_dev->dev,
 		mv_chan->dummy_dst, MV_XOR_MIN_BYTE_COUNT, DMA_TO_DEVICE);
+	if (dma_mapping_error(dma_dev->dev, mv_chan->dummy_dst_addr)) {
+		ret = -ENOMEM;
+		goto err_unmap_src;
+	}
+
 
 	/* allocate coherent memory for hardware descriptors
 	 * note: writecombine gives slightly better performance, but
@@ -1071,8 +1079,10 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 	mv_chan->dma_desc_pool_virt =
 	  dma_alloc_wc(&pdev->dev, MV_XOR_POOL_SIZE, &mv_chan->dma_desc_pool,
 		       GFP_KERNEL);
-	if (!mv_chan->dma_desc_pool_virt)
-		return ERR_PTR(-ENOMEM);
+	if (!mv_chan->dma_desc_pool_virt) {
+		ret = -ENOMEM;
+		goto err_unmap_dst;
+	}
 
 	/* discover transaction capabilites from the platform data */
 	dma_dev->cap_mask = cap_mask;
@@ -1156,6 +1166,13 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 err_free_dma:
 	dma_free_coherent(&pdev->dev, MV_XOR_POOL_SIZE,
 			  mv_chan->dma_desc_pool_virt, mv_chan->dma_desc_pool);
+err_unmap_dst:
+	dma_unmap_single(dma_dev->dev, mv_chan->dummy_dst_addr,
+			 MV_XOR_MIN_BYTE_COUNT, DMA_TO_DEVICE);
+err_unmap_src:
+	dma_unmap_single(dma_dev->dev, mv_chan->dummy_src_addr,
+			 MV_XOR_MIN_BYTE_COUNT, DMA_FROM_DEVICE);
+
 	return ERR_PTR(ret);
 }
 
diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 594409a6e975..0a8b04798b98 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -705,6 +705,9 @@ static int nbpf_desc_page_alloc(struct nbpf_channel *chan)
 		list_add_tail(&ldesc->node, &lhead);
 		ldesc->hwdesc_dma_addr = dma_map_single(dchan->device->dev,
 					hwdesc, sizeof(*hwdesc), DMA_TO_DEVICE);
+		if (dma_mapping_error(dchan->device->dev,
+				      ldesc->hwdesc_dma_addr))
+			goto unmap_error;
 
 		dev_dbg(dev, "%s(): mapped 0x%p to %pad\n", __func__,
 			hwdesc, &ldesc->hwdesc_dma_addr);
@@ -731,6 +734,16 @@ static int nbpf_desc_page_alloc(struct nbpf_channel *chan)
 	spin_unlock_irq(&chan->lock);
 
 	return ARRAY_SIZE(dpage->desc);
+
+unmap_error:
+	while (i--) {
+		ldesc--; hwdesc--;
+
+		dma_unmap_single(dchan->device->dev, ldesc->hwdesc_dma_addr,
+				 sizeof(hwdesc), DMA_TO_DEVICE);
+	}
+
+	return -ENOMEM;
 }
 
 static void nbpf_desc_put(struct nbpf_desc *desc)
@@ -1349,7 +1362,7 @@ static int nbpf_probe(struct platform_device *pdev)
 	if (irqs == 1) {
 		eirq = irqbuf[0];
 
-		for (i = 0; i <= num_channels; i++)
+		for (i = 0; i < num_channels; i++)
 			nbpf->chan[i].irq = irqbuf[0];
 	} else {
 		eirq = platform_get_irq_byname(pdev, "error");
@@ -1359,16 +1372,15 @@ static int nbpf_probe(struct platform_device *pdev)
 		if (irqs == num_channels + 1) {
 			struct nbpf_channel *chan;
 
-			for (i = 0, chan = nbpf->chan; i <= num_channels;
+			for (i = 0, chan = nbpf->chan; i < num_channels;
 			     i++, chan++) {
 				/* Skip the error IRQ */
 				if (irqbuf[i] == eirq)
 					i++;
+				if (i >= ARRAY_SIZE(irqbuf))
+					return -EINVAL;
 				chan->irq = irqbuf[i];
 			}
-
-			if (chan != nbpf->chan + num_channels)
-				return -EINVAL;
 		} else {
 			/* 2 IRQs and more than one channel */
 			if (irqbuf[0] == eirq)
@@ -1376,7 +1388,7 @@ static int nbpf_probe(struct platform_device *pdev)
 			else
 				irq = irqbuf[0];
 
-			for (i = 0; i <= num_channels; i++)
+			for (i = 0; i < num_channels; i++)
 				nbpf->chan[i].irq = irq;
 		}
 	}
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 31ef38e38537..efd5c2920c6d 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -405,12 +405,12 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 		}
 	}
 
-	priv->dma_nelms =
-	    dma_map_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
-	if (priv->dma_nelms == 0) {
+	err = dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
+	if (err) {
 		dev_err(&mgr->dev, "Unable to DMA map (TO_DEVICE)\n");
-		return -ENOMEM;
+		return err;
 	}
+	priv->dma_nelms = sgt->nents;
 
 	/* enable clock */
 	err = clk_enable(priv->clk);
@@ -478,7 +478,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 	clk_disable(priv->clk);
 
 out_free:
-	dma_unmap_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
+	dma_unmap_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
 	return err;
 }
 
diff --git a/drivers/gpio/gpio-tps65912.c b/drivers/gpio/gpio-tps65912.c
index 3ad68bd78282..736af805e54a 100644
--- a/drivers/gpio/gpio-tps65912.c
+++ b/drivers/gpio/gpio-tps65912.c
@@ -49,10 +49,13 @@ static int tps65912_gpio_direction_output(struct gpio_chip *gc,
 					  unsigned offset, int value)
 {
 	struct tps65912_gpio *gpio = gpiochip_get_data(gc);
+	int ret;
 
 	/* Set the initial value */
-	regmap_update_bits(gpio->tps->regmap, TPS65912_GPIO1 + offset,
-			   GPIO_SET_MASK, value ? GPIO_SET_MASK : 0);
+	ret = regmap_update_bits(gpio->tps->regmap, TPS65912_GPIO1 + offset,
+				 GPIO_SET_MASK, value ? GPIO_SET_MASK : 0);
+	if (ret)
+		return ret;
 
 	return regmap_update_bits(gpio->tps->regmap, TPS65912_GPIO1 + offset,
 				  GPIO_CFG_MASK, GPIO_CFG_MASK);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index 35a8d3c96fc9..2e811e963e35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -94,8 +94,8 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	r = amdgpu_vm_bo_map(adev, *bo_va, csa_addr, 0, size,
-			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
-			     AMDGPU_PTE_EXECUTABLE);
+			     AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
+			     AMDGPU_VM_PAGE_EXECUTABLE);
 
 	if (r) {
 		DRM_ERROR("failed to do bo_map on static CSA, err=%d\n", r);
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 0d2e13627c64..1a448397ae0b 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -992,7 +992,7 @@ static enum bp_result set_pixel_clock_v3(
 	allocation.sPCLKInput.usFbDiv =
 			cpu_to_le16((uint16_t)bp_params->feedback_divider);
 	allocation.sPCLKInput.ucFracFbDiv =
-			(uint8_t)bp_params->fractional_feedback_divider;
+			(uint8_t)(bp_params->fractional_feedback_divider / 100000);
 	allocation.sPCLKInput.ucPostDiv =
 			(uint8_t)bp_params->pixel_clock_post_divider;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
index b1e657e137a9..56a7266fed20 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
@@ -120,9 +120,12 @@ void dce110_fill_display_configs(
 	const struct dc_state *context,
 	struct dm_pp_display_configuration *pp_display_cfg)
 {
+	struct dc *dc = context->clk_mgr->ctx->dc;
 	int j;
 	int num_cfgs = 0;
 
+	pp_display_cfg->crtc_index = dc->res_pool->res_cap->num_timing_generator;
+
 	for (j = 0; j < context->stream_count; j++) {
 		int k;
 
@@ -164,6 +167,23 @@ void dce110_fill_display_configs(
 		cfg->v_refresh /= stream->timing.h_total;
 		cfg->v_refresh = (cfg->v_refresh + stream->timing.v_total / 2)
 							/ stream->timing.v_total;
+
+		/* Find first CRTC index and calculate its line time.
+		 * This is necessary for DPM on SI GPUs.
+		 */
+		if (cfg->pipe_idx < pp_display_cfg->crtc_index) {
+			const struct dc_crtc_timing *timing =
+				&context->streams[0]->timing;
+
+			pp_display_cfg->crtc_index = cfg->pipe_idx;
+			pp_display_cfg->line_time_in_us =
+				timing->h_total * 10000 / timing->pix_clk_100hz;
+		}
+	}
+
+	if (!num_cfgs) {
+		pp_display_cfg->crtc_index = 0;
+		pp_display_cfg->line_time_in_us = 0;
 	}
 
 	pp_display_cfg->display_count = num_cfgs;
@@ -231,16 +251,6 @@ void dce11_pplib_apply_display_requirements(
 
 	dce110_fill_display_configs(context, pp_display_cfg);
 
-	/* TODO: is this still applicable?*/
-	if (pp_display_cfg->display_count == 1) {
-		const struct dc_crtc_timing *timing =
-			&context->streams[0]->timing;
-
-		pp_display_cfg->crtc_index =
-			pp_display_cfg->disp_configs[0].pipe_idx;
-		pp_display_cfg->line_time_in_us = timing->h_total * 10000 / timing->pix_clk_100hz;
-	}
-
 	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
 		dm_pp_apply_display_requirements(dc->ctx, pp_display_cfg);
 }
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
index d09690fca452..8a1ad9305a21 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu_helper.c
@@ -148,7 +148,7 @@ int phm_wait_on_indirect_register(struct pp_hwmgr *hwmgr,
 	}
 
 	cgs_write_register(hwmgr->device, indirect_port, index);
-	return phm_wait_on_register(hwmgr, indirect_port + 1, mask, value);
+	return phm_wait_on_register(hwmgr, indirect_port + 1, value, mask);
 }
 
 int phm_wait_for_register_unequal(struct pp_hwmgr *hwmgr,
diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index ffc68d305afe..4eabef5b86d0 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -280,7 +280,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 	 * We just have to do it before any DPCD access and hope that the
 	 * monitor doesn't power down exactly after the throw away read.
 	 */
-	ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_DPCD_REV, buffer,
+	ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_LANE0_1_STATUS, buffer,
 				 1);
 	if (ret != 1)
 		goto out;
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 57f9baad9e36..d9b20bb7c7f5 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -327,19 +327,6 @@ void drm_sched_entity_destroy(struct drm_sched_entity *entity)
 }
 EXPORT_SYMBOL(drm_sched_entity_destroy);
 
-/**
- * drm_sched_entity_clear_dep - callback to clear the entities dependency
- */
-static void drm_sched_entity_clear_dep(struct dma_fence *f,
-				       struct dma_fence_cb *cb)
-{
-	struct drm_sched_entity *entity =
-		container_of(cb, struct drm_sched_entity, cb);
-
-	entity->dependency = NULL;
-	dma_fence_put(f);
-}
-
 /**
  * drm_sched_entity_clear_dep - callback to clear the entities dependency and
  * wake up scheduler
@@ -350,7 +337,8 @@ static void drm_sched_entity_wakeup(struct dma_fence *f,
 	struct drm_sched_entity *entity =
 		container_of(cb, struct drm_sched_entity, cb);
 
-	drm_sched_entity_clear_dep(f, cb);
+	entity->dependency = NULL;
+	dma_fence_put(f);
 	drm_sched_wakeup(entity->rq->sched);
 }
 
@@ -426,13 +414,6 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity)
 		fence = dma_fence_get(&s_fence->scheduled);
 		dma_fence_put(entity->dependency);
 		entity->dependency = fence;
-		if (!dma_fence_add_callback(fence, &entity->cb,
-					    drm_sched_entity_clear_dep))
-			return true;
-
-		/* Ignore it when it is already scheduled */
-		dma_fence_put(fence);
-		return false;
 	}
 
 	if (!dma_fence_add_callback(entity->dependency, &entity->cb,
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index ad0c5b353c16..dd718bdb3ade 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1655,9 +1655,12 @@ u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags)
 	/*
 	 * 7 extra bytes are necessary to achieve proper functionality
 	 * of implement() working on 8 byte chunks
+	 * 1 extra byte for the report ID if it is null (not used) so
+	 * we can reserve that extra byte in the first position of the buffer
+	 * when sending it to .raw_request()
 	 */
 
-	u32 len = hid_report_len(report) + 7;
+	u32 len = hid_report_len(report) + 7 + (report->id == 0);
 
 	return kzalloc(len, flags);
 }
@@ -1720,7 +1723,7 @@ static struct hid_report *hid_get_report(struct hid_report_enum *report_enum,
 int __hid_request(struct hid_device *hid, struct hid_report *report,
 		int reqtype)
 {
-	char *buf;
+	char *buf, *data_buf;
 	int ret;
 	u32 len;
 
@@ -1728,13 +1731,19 @@ int __hid_request(struct hid_device *hid, struct hid_report *report,
 	if (!buf)
 		return -ENOMEM;
 
+	data_buf = buf;
 	len = hid_report_len(report);
 
+	if (report->id == 0) {
+		/* reserve the first byte for the report ID */
+		data_buf++;
+		len++;
+	}
+
 	if (reqtype == HID_REQ_SET_REPORT)
-		hid_output_report(report, buf);
+		hid_output_report(report, data_buf);
 
-	ret = hid->ll_driver->raw_request(hid, report->id, buf, len,
-					  report->type, reqtype);
+	ret = hid_hw_raw_request(hid, report->id, buf, len, report->type, reqtype);
 	if (ret < 0) {
 		dbg_hid("unable to complete request: %d\n", ret);
 		goto out;
diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 3417f7dffa94..7bab436bd8f8 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -449,8 +449,10 @@ static int qup_i2c_bus_active(struct qup_i2c_dev *qup, int len)
 		if (!(status & I2C_STATUS_BUS_ACTIVE))
 			break;
 
-		if (time_after(jiffies, timeout))
+		if (time_after(jiffies, timeout)) {
 			ret = -ETIMEDOUT;
+			break;
+		}
 
 		usleep_range(len, len * 2);
 	}
diff --git a/drivers/i2c/busses/i2c-stm32.c b/drivers/i2c/busses/i2c-stm32.c
index 1da347e6a358..4878729f3322 100644
--- a/drivers/i2c/busses/i2c-stm32.c
+++ b/drivers/i2c/busses/i2c-stm32.c
@@ -98,7 +98,6 @@ int stm32_i2c_prep_dma_xfer(struct device *dev, struct stm32_i2c_dma *dma,
 			    void *dma_async_param)
 {
 	struct dma_async_tx_descriptor *txdesc;
-	struct device *chan_dev;
 	int ret;
 
 	if (rd_wr) {
@@ -112,11 +111,10 @@ int stm32_i2c_prep_dma_xfer(struct device *dev, struct stm32_i2c_dma *dma,
 	}
 
 	dma->dma_len = len;
-	chan_dev = dma->chan_using->device->dev;
 
-	dma->dma_buf = dma_map_single(chan_dev, buf, dma->dma_len,
+	dma->dma_buf = dma_map_single(dev, buf, dma->dma_len,
 				      dma->dma_data_dir);
-	if (dma_mapping_error(chan_dev, dma->dma_buf)) {
+	if (dma_mapping_error(dev, dma->dma_buf)) {
 		dev_err(dev, "DMA mapping failed\n");
 		return -EINVAL;
 	}
@@ -146,7 +144,7 @@ int stm32_i2c_prep_dma_xfer(struct device *dev, struct stm32_i2c_dma *dma,
 	return 0;
 
 err:
-	dma_unmap_single(chan_dev, dma->dma_buf, dma->dma_len,
+	dma_unmap_single(dev, dma->dma_buf, dma->dma_len,
 			 dma->dma_data_dir);
 	return ret;
 }
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 02f0f9eeb59f..c8d15d0f194e 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -632,10 +632,10 @@ static void stm32f7_i2c_dma_callback(void *arg)
 {
 	struct stm32f7_i2c_dev *i2c_dev = (struct stm32f7_i2c_dev *)arg;
 	struct stm32_i2c_dma *dma = i2c_dev->dma;
-	struct device *dev = dma->chan_using->device->dev;
 
 	stm32f7_i2c_disable_dma_req(i2c_dev);
-	dma_unmap_single(dev, dma->dma_buf, dma->dma_len, dma->dma_data_dir);
+	dma_unmap_single(i2c_dev->dev, dma->dma_buf, dma->dma_len,
+			 dma->dma_data_dir);
 	complete(&dma->dma_complete);
 }
 
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 86b7b44cfca2..1906c711f38a 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -9,6 +9,7 @@
 #define I3C_INTERNALS_H
 
 #include <linux/i3c/master.h>
+#include <linux/io.h>
 
 extern struct bus_type i3c_bus_type;
 
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 8604c9e7b6ac..07478ddff622 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1243,7 +1243,7 @@ static int i3c_master_retrieve_dev_info(struct i3c_dev_desc *dev)
 
 	if (dev->info.bcr & I3C_BCR_HDR_CAP) {
 		ret = i3c_master_gethdrcap_locked(master, &dev->info);
-		if (ret)
+		if (ret && ret != -ENOTSUPP)
 			return ret;
 	}
 
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 5c2cc61b666e..2ad0a6f4c336 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -505,10 +505,10 @@ static const struct iio_event_spec max1363_events[] = {
 	MAX1363_CHAN_U(1, _s1, 1, bits, ev_spec, num_ev_spec),		\
 	MAX1363_CHAN_U(2, _s2, 2, bits, ev_spec, num_ev_spec),		\
 	MAX1363_CHAN_U(3, _s3, 3, bits, ev_spec, num_ev_spec),		\
-	MAX1363_CHAN_B(0, 1, d0m1, 4, bits, ev_spec, num_ev_spec),	\
-	MAX1363_CHAN_B(2, 3, d2m3, 5, bits, ev_spec, num_ev_spec),	\
-	MAX1363_CHAN_B(1, 0, d1m0, 6, bits, ev_spec, num_ev_spec),	\
-	MAX1363_CHAN_B(3, 2, d3m2, 7, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(0, 1, d0m1, 12, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(2, 3, d2m3, 13, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 18, bits, ev_spec, num_ev_spec),	\
+	MAX1363_CHAN_B(3, 2, d3m2, 19, bits, ev_spec, num_ev_spec),	\
 	IIO_CHAN_SOFT_TIMESTAMP(8)					\
 	}
 
@@ -526,23 +526,23 @@ static const struct iio_chan_spec max1363_channels[] =
 /* Applies to max1236, max1237 */
 static const enum max1363_modes max1236_mode_list[] = {
 	_s0, _s1, _s2, _s3,
-	s0to1, s0to2, s0to3,
+	s0to1, s0to2, s2to3, s0to3,
 	d0m1, d2m3, d1m0, d3m2,
 	d0m1to2m3, d1m0to3m2,
-	s2to3,
 };
 
 /* Applies to max1238, max1239 */
 static const enum max1363_modes max1238_mode_list[] = {
 	_s0, _s1, _s2, _s3, _s4, _s5, _s6, _s7, _s8, _s9, _s10, _s11,
 	s0to1, s0to2, s0to3, s0to4, s0to5, s0to6,
+	s6to7, s6to8, s6to9, s6to10, s6to11,
 	s0to7, s0to8, s0to9, s0to10, s0to11,
 	d0m1, d2m3, d4m5, d6m7, d8m9, d10m11,
 	d1m0, d3m2, d5m4, d7m6, d9m8, d11m10,
-	d0m1to2m3, d0m1to4m5, d0m1to6m7, d0m1to8m9, d0m1to10m11,
-	d1m0to3m2, d1m0to5m4, d1m0to7m6, d1m0to9m8, d1m0to11m10,
-	s6to7, s6to8, s6to9, s6to10, s6to11,
-	d6m7to8m9, d6m7to10m11, d7m6to9m8, d7m6to11m10,
+	d0m1to2m3, d0m1to4m5, d0m1to6m7, d6m7to8m9,
+	d0m1to8m9, d6m7to10m11, d0m1to10m11, d1m0to3m2,
+	d1m0to5m4, d1m0to7m6, d7m6to9m8, d1m0to9m8,
+	d7m6to11m10, d1m0to11m10,
 };
 
 #define MAX1363_12X_CHANS(bits) {				\
@@ -578,16 +578,15 @@ static const struct iio_chan_spec max1238_channels[] = MAX1363_12X_CHANS(12);
 
 static const enum max1363_modes max11607_mode_list[] = {
 	_s0, _s1, _s2, _s3,
-	s0to1, s0to2, s0to3,
-	s2to3,
+	s0to1, s0to2, s2to3,
+	s0to3,
 	d0m1, d2m3, d1m0, d3m2,
 	d0m1to2m3, d1m0to3m2,
 };
 
 static const enum max1363_modes max11608_mode_list[] = {
 	_s0, _s1, _s2, _s3, _s4, _s5, _s6, _s7,
-	s0to1, s0to2, s0to3, s0to4, s0to5, s0to6, s0to7,
-	s6to7,
+	s0to1, s0to2, s0to3, s0to4, s0to5, s0to6, s6to7, s0to7,
 	d0m1, d2m3, d4m5, d6m7,
 	d1m0, d3m2, d5m4, d7m6,
 	d0m1to2m3, d0m1to4m5, d0m1to6m7,
@@ -603,14 +602,14 @@ static const enum max1363_modes max11608_mode_list[] = {
 	MAX1363_CHAN_U(5, _s5, 5, bits, NULL, 0),	\
 	MAX1363_CHAN_U(6, _s6, 6, bits, NULL, 0),	\
 	MAX1363_CHAN_U(7, _s7, 7, bits, NULL, 0),	\
-	MAX1363_CHAN_B(0, 1, d0m1, 8, bits, NULL, 0),	\
-	MAX1363_CHAN_B(2, 3, d2m3, 9, bits, NULL, 0),	\
-	MAX1363_CHAN_B(4, 5, d4m5, 10, bits, NULL, 0),	\
-	MAX1363_CHAN_B(6, 7, d6m7, 11, bits, NULL, 0),	\
-	MAX1363_CHAN_B(1, 0, d1m0, 12, bits, NULL, 0),	\
-	MAX1363_CHAN_B(3, 2, d3m2, 13, bits, NULL, 0),	\
-	MAX1363_CHAN_B(5, 4, d5m4, 14, bits, NULL, 0),	\
-	MAX1363_CHAN_B(7, 6, d7m6, 15, bits, NULL, 0),	\
+	MAX1363_CHAN_B(0, 1, d0m1, 12, bits, NULL, 0),	\
+	MAX1363_CHAN_B(2, 3, d2m3, 13, bits, NULL, 0),	\
+	MAX1363_CHAN_B(4, 5, d4m5, 14, bits, NULL, 0),	\
+	MAX1363_CHAN_B(6, 7, d6m7, 15, bits, NULL, 0),	\
+	MAX1363_CHAN_B(1, 0, d1m0, 18, bits, NULL, 0),	\
+	MAX1363_CHAN_B(3, 2, d3m2, 19, bits, NULL, 0),	\
+	MAX1363_CHAN_B(5, 4, d5m4, 20, bits, NULL, 0),	\
+	MAX1363_CHAN_B(7, 6, d7m6, 21, bits, NULL, 0),	\
 	IIO_CHAN_SOFT_TIMESTAMP(16)			\
 }
 static const struct iio_chan_spec max11602_channels[] = MAX1363_8X_CHANS(8);
diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 0ecec5a15fbf..ab07b12124fa 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -393,10 +393,9 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < priv->cfg->num_irqs; i++) {
-		irq_set_chained_handler(priv->irq[i], stm32_adc_irq_handler);
-		irq_set_handler_data(priv->irq[i], priv);
-	}
+	for (i = 0; i < priv->cfg->num_irqs; i++)
+		irq_set_chained_handler_and_data(priv->irq[i],
+						 stm32_adc_irq_handler, priv);
 
 	return 0;
 }
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 70da928e0d16..9c6c71218cf2 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -103,8 +103,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 		ret_type = prox_state->scale_precision;
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = hid_sensor_convert_exponent(
-				prox_state->prox_attr.unit_expo);
+		*val = 0;
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index 56d6e9f927f4..49a19f22a3ec 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -938,12 +938,18 @@ static irqreturn_t isl29501_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct isl29501_private *isl29501 = iio_priv(indio_dev);
 	const unsigned long *active_mask = indio_dev->active_scan_mask;
-	u32 buffer[4] __aligned(8) = {}; /* 1x16-bit + naturally aligned ts */
-
-	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask))
-		isl29501_register_read(isl29501, REG_DISTANCE, buffer);
+	u32 value;
+	struct {
+		u16 data;
+		aligned_s64 ts;
+	} scan = { };
+
+	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask)) {
+		isl29501_register_read(isl29501, REG_DISTANCE, &value);
+		scan.data = value;
+	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 7affe6b4ae21..641e537a0069 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -578,8 +578,8 @@ static int __ib_cache_gid_add(struct ib_device *ib_dev, u8 port,
 out_unlock:
 	mutex_unlock(&table->lock);
 	if (ret)
-		pr_warn("%s: unable to add gid %pI6 error=%d\n",
-			__func__, gid->raw, ret);
+		pr_warn_ratelimited("%s: unable to add gid %pI6 error=%d\n",
+				    __func__, gid->raw, ret);
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 832b878fa67e..6933fbea2b46 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -1009,31 +1009,35 @@ static void find_hw_thread_mask(uint hw_thread_no, cpumask_var_t hw_thread_mask,
 				struct hfi1_affinity_node_list *affinity)
 {
 	int possible, curr_cpu, i;
-	uint num_cores_per_socket = node_affinity.num_online_cpus /
+	uint num_cores_per_socket;
+
+	cpumask_copy(hw_thread_mask, &affinity->proc.mask);
+
+	if (affinity->num_core_siblings == 0)
+		return;
+
+	num_cores_per_socket = node_affinity.num_online_cpus /
 					affinity->num_core_siblings /
 						node_affinity.num_online_nodes;
 
-	cpumask_copy(hw_thread_mask, &affinity->proc.mask);
-	if (affinity->num_core_siblings > 0) {
-		/* Removing other siblings not needed for now */
-		possible = cpumask_weight(hw_thread_mask);
-		curr_cpu = cpumask_first(hw_thread_mask);
-		for (i = 0;
-		     i < num_cores_per_socket * node_affinity.num_online_nodes;
-		     i++)
-			curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
-
-		for (; i < possible; i++) {
-			cpumask_clear_cpu(curr_cpu, hw_thread_mask);
-			curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
-		}
+	/* Removing other siblings not needed for now */
+	possible = cpumask_weight(hw_thread_mask);
+	curr_cpu = cpumask_first(hw_thread_mask);
+	for (i = 0;
+	     i < num_cores_per_socket * node_affinity.num_online_nodes;
+	     i++)
+		curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
 
-		/* Identifying correct HW threads within physical cores */
-		cpumask_shift_left(hw_thread_mask, hw_thread_mask,
-				   num_cores_per_socket *
-				   node_affinity.num_online_nodes *
-				   hw_thread_no);
+	for (; i < possible; i++) {
+		cpumask_clear_cpu(curr_cpu, hw_thread_mask);
+		curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
 	}
+
+	/* Identifying correct HW threads within physical cores */
+	cpumask_shift_left(hw_thread_mask, hw_thread_mask,
+			   num_cores_per_socket *
+			   node_affinity.num_online_nodes *
+			   hw_thread_no);
 }
 
 int hfi1_get_proc_affinity(int node)
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index a0362201b5d3..31f7d09c71dc 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -142,12 +142,12 @@ static const struct xpad_device {
 	{ 0x046d, 0xca88, "Logitech Compact Controller for Xbox", 0, XTYPE_XBOX },
 	{ 0x046d, 0xca8a, "Logitech Precision Vibration Feedback Wheel", 0, XTYPE_XBOX },
 	{ 0x046d, 0xcaa3, "Logitech DriveFx Racing Wheel", 0, XTYPE_XBOX360 },
+	{ 0x0502, 0x1305, "Acer NGR200", 0, XTYPE_XBOX360 },
 	{ 0x056e, 0x2004, "Elecom JC-U3613M", 0, XTYPE_XBOX360 },
 	{ 0x05fd, 0x1007, "Mad Catz Controller (unverified)", 0, XTYPE_XBOX },
 	{ 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (Germany)", 0, XTYPE_XBOX },
 	{ 0x05fe, 0x3030, "Chic Controller", 0, XTYPE_XBOX },
 	{ 0x05fe, 0x3031, "Chic Controller", 0, XTYPE_XBOX },
-	{ 0x0502, 0x1305, "Acer NGR200", 0, XTYPE_XBOX },
 	{ 0x062a, 0x0020, "Logic3 Xbox GamePad", 0, XTYPE_XBOX },
 	{ 0x062a, 0x0033, "Competition Pro Steering Wheel", 0, XTYPE_XBOX },
 	{ 0x06a3, 0x0200, "Saitek Racing Wheel", 0, XTYPE_XBOX },
diff --git a/drivers/media/dvb-frontends/dib7000p.c b/drivers/media/dvb-frontends/dib7000p.c
index fd08a851a452..41dcbabdc193 100644
--- a/drivers/media/dvb-frontends/dib7000p.c
+++ b/drivers/media/dvb-frontends/dib7000p.c
@@ -2198,6 +2198,8 @@ static int w7090p_tuner_write_serpar(struct i2c_adapter *i2c_adap, struct i2c_ms
 	struct dib7000p_state *state = i2c_get_adapdata(i2c_adap);
 	u8 n_overflow = 1;
 	u16 i = 1000;
+	if (msg[0].len < 3)
+		return -EOPNOTSUPP;
 	u16 serpar_num = msg[0].buf[0];
 
 	while (n_overflow == 1 && i) {
@@ -2217,6 +2219,8 @@ static int w7090p_tuner_read_serpar(struct i2c_adapter *i2c_adap, struct i2c_msg
 	struct dib7000p_state *state = i2c_get_adapdata(i2c_adap);
 	u8 n_overflow = 1, n_empty = 1;
 	u16 i = 1000;
+	if (msg[0].len < 1 || msg[1].len < 2)
+		return -EOPNOTSUPP;
 	u16 serpar_num = msg[0].buf[0];
 	u16 read_word;
 
@@ -2261,8 +2265,12 @@ static int dib7090p_rw_on_apb(struct i2c_adapter *i2c_adap,
 	u16 word;
 
 	if (num == 1) {		/* write */
+		if (msg[0].len < 3)
+			return -EOPNOTSUPP;
 		dib7000p_write_word(state, apb_address, ((msg[0].buf[1] << 8) | (msg[0].buf[2])));
 	} else {
+		if (msg[1].len < 2)
+			return -EOPNOTSUPP;
 		word = dib7000p_read_word(state, apb_address);
 		msg[1].buf[0] = (word >> 8) & 0xff;
 		msg[1].buf[1] = (word) & 0xff;
diff --git a/drivers/media/i2c/ov2659.c b/drivers/media/i2c/ov2659.c
index e1ff38009cf0..2d1f132a4a87 100644
--- a/drivers/media/i2c/ov2659.c
+++ b/drivers/media/i2c/ov2659.c
@@ -1432,14 +1432,15 @@ static int ov2659_probe(struct i2c_client *client)
 				     V4L2_CID_TEST_PATTERN,
 				     ARRAY_SIZE(ov2659_test_pattern_menu) - 1,
 				     0, 0, ov2659_test_pattern_menu);
-	ov2659->sd.ctrl_handler = &ov2659->ctrls;
 
 	if (ov2659->ctrls.error) {
 		dev_err(&client->dev, "%s: control initialization error %d\n",
 			__func__, ov2659->ctrls.error);
+		v4l2_ctrl_handler_free(&ov2659->ctrls);
 		return  ov2659->ctrls.error;
 	}
 
+	ov2659->sd.ctrl_handler = &ov2659->ctrls;
 	sd = &ov2659->sd;
 	client->flags |= I2C_CLIENT_SCCB;
 #ifdef CONFIG_VIDEO_V4L2_SUBDEV_API
diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index f4ebe93a495c..2dad35568586 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -110,7 +110,7 @@ static inline struct tc358743_state *to_state(struct v4l2_subdev *sd)
 
 /* --------------- I2C --------------- */
 
-static void i2c_rd(struct v4l2_subdev *sd, u16 reg, u8 *values, u32 n)
+static int i2c_rd(struct v4l2_subdev *sd, u16 reg, u8 *values, u32 n)
 {
 	struct tc358743_state *state = to_state(sd);
 	struct i2c_client *client = state->i2c_client;
@@ -136,6 +136,7 @@ static void i2c_rd(struct v4l2_subdev *sd, u16 reg, u8 *values, u32 n)
 		v4l2_err(sd, "%s: reading register 0x%x from 0x%x failed\n",
 				__func__, reg, client->addr);
 	}
+	return err != ARRAY_SIZE(msgs);
 }
 
 static void i2c_wr(struct v4l2_subdev *sd, u16 reg, u8 *values, u32 n)
@@ -192,15 +193,24 @@ static void i2c_wr(struct v4l2_subdev *sd, u16 reg, u8 *values, u32 n)
 	}
 }
 
-static noinline u32 i2c_rdreg(struct v4l2_subdev *sd, u16 reg, u32 n)
+static noinline u32 i2c_rdreg_err(struct v4l2_subdev *sd, u16 reg, u32 n,
+				  int *err)
 {
+	int error;
 	__le32 val = 0;
 
-	i2c_rd(sd, reg, (u8 __force *)&val, n);
+	error = i2c_rd(sd, reg, (u8 __force *)&val, n);
+	if (err)
+		*err = error;
 
 	return le32_to_cpu(val);
 }
 
+static inline u32 i2c_rdreg(struct v4l2_subdev *sd, u16 reg, u32 n)
+{
+	return i2c_rdreg_err(sd, reg, n, NULL);
+}
+
 static noinline void i2c_wrreg(struct v4l2_subdev *sd, u16 reg, u32 val, u32 n)
 {
 	__le32 raw = cpu_to_le32(val);
@@ -229,6 +239,13 @@ static u16 i2c_rd16(struct v4l2_subdev *sd, u16 reg)
 	return i2c_rdreg(sd, reg, 2);
 }
 
+static int i2c_rd16_err(struct v4l2_subdev *sd, u16 reg, u16 *value)
+{
+	int err;
+	*value = i2c_rdreg_err(sd, reg, 2, &err);
+	return err;
+}
+
 static void i2c_wr16(struct v4l2_subdev *sd, u16 reg, u16 val)
 {
 	i2c_wrreg(sd, reg, val, 2);
@@ -1668,12 +1685,23 @@ static int tc358743_enum_mbus_code(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static u32 tc358743_g_colorspace(u32 code)
+{
+	switch (code) {
+	case MEDIA_BUS_FMT_RGB888_1X24:
+		return V4L2_COLORSPACE_SRGB;
+	case MEDIA_BUS_FMT_UYVY8_1X16:
+		return V4L2_COLORSPACE_SMPTE170M;
+	default:
+		return 0;
+	}
+}
+
 static int tc358743_get_fmt(struct v4l2_subdev *sd,
 		struct v4l2_subdev_pad_config *cfg,
 		struct v4l2_subdev_format *format)
 {
 	struct tc358743_state *state = to_state(sd);
-	u8 vi_rep = i2c_rd8(sd, VI_REP);
 
 	if (format->pad != 0)
 		return -EINVAL;
@@ -1683,23 +1711,7 @@ static int tc358743_get_fmt(struct v4l2_subdev *sd,
 	format->format.height = state->timings.bt.height;
 	format->format.field = V4L2_FIELD_NONE;
 
-	switch (vi_rep & MASK_VOUT_COLOR_SEL) {
-	case MASK_VOUT_COLOR_RGB_FULL:
-	case MASK_VOUT_COLOR_RGB_LIMITED:
-		format->format.colorspace = V4L2_COLORSPACE_SRGB;
-		break;
-	case MASK_VOUT_COLOR_601_YCBCR_LIMITED:
-	case MASK_VOUT_COLOR_601_YCBCR_FULL:
-		format->format.colorspace = V4L2_COLORSPACE_SMPTE170M;
-		break;
-	case MASK_VOUT_COLOR_709_YCBCR_FULL:
-	case MASK_VOUT_COLOR_709_YCBCR_LIMITED:
-		format->format.colorspace = V4L2_COLORSPACE_REC709;
-		break;
-	default:
-		format->format.colorspace = 0;
-		break;
-	}
+	format->format.colorspace = tc358743_g_colorspace(format->format.code);
 
 	return 0;
 }
@@ -1713,19 +1725,14 @@ static int tc358743_set_fmt(struct v4l2_subdev *sd,
 	u32 code = format->format.code; /* is overwritten by get_fmt */
 	int ret = tc358743_get_fmt(sd, cfg, format);
 
-	format->format.code = code;
+	if (code == MEDIA_BUS_FMT_RGB888_1X24 ||
+	    code == MEDIA_BUS_FMT_UYVY8_1X16)
+		format->format.code = code;
+	format->format.colorspace = tc358743_g_colorspace(format->format.code);
 
 	if (ret)
 		return ret;
 
-	switch (code) {
-	case MEDIA_BUS_FMT_RGB888_1X24:
-	case MEDIA_BUS_FMT_UYVY8_1X16:
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
 		return 0;
 
@@ -1952,8 +1959,19 @@ static int tc358743_probe_of(struct tc358743_state *state)
 	state->pdata.refclk_hz = clk_get_rate(refclk);
 	state->pdata.ddc5v_delay = DDC5V_DELAY_100_MS;
 	state->pdata.enable_hdcp = false;
-	/* A FIFO level of 16 should be enough for 2-lane 720p60 at 594 MHz. */
-	state->pdata.fifo_level = 16;
+	/*
+	 * Ideally the FIFO trigger level should be set based on the input and
+	 * output data rates, but the calculations required are buried in
+	 * Toshiba's register settings spreadsheet.
+	 * A value of 16 works with a 594Mbps data rate for 720p60 (using 2
+	 * lanes) and 1080p60 (using 4 lanes), but fails when the data rate
+	 * is increased, or a lower pixel clock is used that result in CSI
+	 * reading out faster than the data is arriving.
+	 *
+	 * A value of 374 works with both those modes at 594Mbps, and with most
+	 * modes on 972Mbps.
+	 */
+	state->pdata.fifo_level = 374;
 	/*
 	 * The PLL input clock is obtained by dividing refclk by pll_prd.
 	 * It must be between 6 MHz and 40 MHz, lower frequency is better.
@@ -2041,6 +2059,7 @@ static int tc358743_probe(struct i2c_client *client)
 	struct tc358743_platform_data *pdata = client->dev.platform_data;
 	struct v4l2_subdev *sd;
 	u16 irq_mask = MASK_HDMI_MSK | MASK_CSI_MSK;
+	u16 chipid;
 	int err;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
@@ -2072,7 +2091,8 @@ static int tc358743_probe(struct i2c_client *client)
 	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
 
 	/* i2c access */
-	if ((i2c_rd16(sd, CHIPID) & MASK_CHIPID) != 0) {
+	if (i2c_rd16_err(sd, CHIPID, &chipid) ||
+	    (chipid & MASK_CHIPID) != 0) {
 		v4l2_info(sd, "not a TC358743 on address 0x%x\n",
 			  client->addr << 1);
 		return -ENODEV;
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 2db9229d5601..adf3de3e017f 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -888,7 +888,7 @@ static int camss_probe(struct platform_device *pdev)
 	ret = v4l2_device_register(camss->dev, &camss->v4l2_dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
-		goto err_cleanup;
+		goto err_media_device_cleanup;
 	}
 
 	ret = camss_register_entities(camss);
@@ -945,6 +945,8 @@ static int camss_probe(struct platform_device *pdev)
 	camss_unregister_entities(camss);
 err_register_entities:
 	v4l2_device_unregister(&camss->v4l2_dev);
+err_media_device_cleanup:
+	media_device_cleanup(&camss->media_dev);
 err_cleanup:
 	v4l2_async_notifier_cleanup(&camss->notifier);
 err_free:
diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index f003c57a1645..42088120128f 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -267,13 +267,13 @@ static int venus_probe(struct platform_device *pdev)
 	mutex_init(&core->lock);
 	INIT_DELAYED_WORK(&core->work, venus_sys_error_handler);
 
-	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, hfi_isr_thread,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-					"venus", core);
+	ret = hfi_create(core, &venus_core_ops);
 	if (ret)
 		return ret;
 
-	ret = hfi_create(core, &venus_core_ops);
+	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, hfi_isr_thread,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"venus", core);
 	if (ret)
 		return ret;
 
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 922cb7e64bfa..03512858c868 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -16,6 +16,8 @@
 
 #define VIDC_CLKS_NUM_MAX	4
 
+#define VENUS_MAX_FPS			240
+
 struct freq_tbl {
 	unsigned int load;
 	unsigned long freq;
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 1b37d77bf998..328c257b7849 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -240,6 +240,7 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
 static int venus_read_queue(struct venus_hfi_device *hdev,
 			    struct iface_queue *queue, void *pkt, u32 *tx_req)
 {
+	struct hfi_pkt_hdr *pkt_hdr = NULL;
 	struct hfi_queue_header *qhdr;
 	u32 dwords, new_rd_idx;
 	u32 rd_idx, wr_idx, type, qsize;
@@ -305,6 +306,9 @@ static int venus_read_queue(struct venus_hfi_device *hdev,
 			memcpy(pkt, rd_ptr, len);
 			memcpy(pkt + len, queue->qmem.kva, new_rd_idx << 2);
 		}
+		pkt_hdr = (struct hfi_pkt_hdr *)(pkt);
+		if ((pkt_hdr->size >> 2) != dwords)
+			return -EINVAL;
 	} else {
 		/* bad packet received, dropping */
 		new_rd_idx = qhdr->write_idx;
@@ -1604,6 +1608,7 @@ void venus_hfi_destroy(struct venus_core *core)
 	mutex_destroy(&hdev->lock);
 	kfree(hdev);
 	core->priv = NULL;
+	disable_irq(core->irq);
 	core->ops = NULL;
 }
 
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index a0a67b7132b8..551462e64082 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -418,11 +418,10 @@ static int vdec_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	us_per_frame = timeperframe->numerator * (u64)USEC_PER_SEC;
 	do_div(us_per_frame, timeperframe->denominator);
 
-	if (!us_per_frame)
-		return -EINVAL;
-
+	us_per_frame = clamp(us_per_frame, 1, USEC_PER_SEC);
 	fps = (u64)USEC_PER_SEC;
 	do_div(fps, us_per_frame);
+	fps = min(VENUS_MAX_FPS, fps);
 
 	inst->fps = fps;
 	inst->timeperframe = *timeperframe;
diff --git a/drivers/media/usb/gspca/vicam.c b/drivers/media/usb/gspca/vicam.c
index d98343fd33fe..91e177aa8136 100644
--- a/drivers/media/usb/gspca/vicam.c
+++ b/drivers/media/usb/gspca/vicam.c
@@ -227,6 +227,7 @@ static int sd_init(struct gspca_dev *gspca_dev)
 	const struct ihex_binrec *rec;
 	const struct firmware *fw;
 	u8 *firmware_buf;
+	int len;
 
 	ret = request_ihex_firmware(&fw, VICAM_FIRMWARE,
 				    &gspca_dev->dev->dev);
@@ -241,9 +242,14 @@ static int sd_init(struct gspca_dev *gspca_dev)
 		goto exit;
 	}
 	for (rec = (void *)fw->data; rec; rec = ihex_next_binrec(rec)) {
-		memcpy(firmware_buf, rec->data, be16_to_cpu(rec->len));
+		len = be16_to_cpu(rec->len);
+		if (len > PAGE_SIZE) {
+			ret = -EINVAL;
+			break;
+		}
+		memcpy(firmware_buf, rec->data, len);
 		ret = vicam_control_msg(gspca_dev, 0xff, 0, 0, firmware_buf,
-					be16_to_cpu(rec->len));
+					len);
 		if (ret < 0)
 			break;
 	}
diff --git a/drivers/media/usb/hdpvr/hdpvr-i2c.c b/drivers/media/usb/hdpvr/hdpvr-i2c.c
index 785c8508a46e..e6a190fe0e87 100644
--- a/drivers/media/usb/hdpvr/hdpvr-i2c.c
+++ b/drivers/media/usb/hdpvr/hdpvr-i2c.c
@@ -165,10 +165,16 @@ static const struct i2c_algorithm hdpvr_algo = {
 	.functionality = hdpvr_functionality,
 };
 
+/* prevent invalid 0-length usb_control_msg */
+static const struct i2c_adapter_quirks hdpvr_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN_READ,
+};
+
 static const struct i2c_adapter hdpvr_i2c_adapter_template = {
 	.name   = "Hauppauge HD PVR I2C",
 	.owner  = THIS_MODULE,
 	.algo   = &hdpvr_algo,
+	.quirks = &hdpvr_quirks,
 };
 
 static int hdpvr_activate_ir(struct hdpvr_device *dev)
diff --git a/drivers/media/usb/rainshadow-cec/rainshadow-cec.c b/drivers/media/usb/rainshadow-cec/rainshadow-cec.c
index ee870ea1a886..6f8d6797c614 100644
--- a/drivers/media/usb/rainshadow-cec/rainshadow-cec.c
+++ b/drivers/media/usb/rainshadow-cec/rainshadow-cec.c
@@ -171,11 +171,12 @@ static irqreturn_t rain_interrupt(struct serio *serio, unsigned char data,
 {
 	struct rain *rain = serio_get_drvdata(serio);
 
+	spin_lock(&rain->buf_lock);
 	if (rain->buf_len == DATA_SIZE) {
+		spin_unlock(&rain->buf_lock);
 		dev_warn_once(rain->dev, "buffer overflow\n");
 		return IRQ_HANDLED;
 	}
-	spin_lock(&rain->buf_lock);
 	rain->buf_len++;
 	rain->buf[rain->buf_wr_idx] = data;
 	rain->buf_wr_idx = (rain->buf_wr_idx + 1) & 0xff;
diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
index b249f037900c..d62a960bb5e7 100644
--- a/drivers/media/usb/usbtv/usbtv-video.c
+++ b/drivers/media/usb/usbtv/usbtv-video.c
@@ -73,6 +73,10 @@ static int usbtv_configure_for_norm(struct usbtv *usbtv, v4l2_std_id norm)
 	}
 
 	if (params) {
+		if (vb2_is_busy(&usbtv->vb2q) &&
+		    (usbtv->width != params->cap_width ||
+		     usbtv->height != params->cap_height))
+			return -EBUSY;
 		usbtv->width = params->cap_width;
 		usbtv->height = params->cap_height;
 		usbtv->n_chunks = usbtv->width * usbtv->height
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 2c2ceb50500c..c0a8344c5533 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -452,6 +452,9 @@ static int uvc_parse_format(struct uvc_device *dev,
 	unsigned int i, n;
 	u8 ftype;
 
+	if (buflen < 4)
+		return -EINVAL;
+
 	format->type = buffer[2];
 	format->index = buffer[3];
 
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index e62afdee20db..40f1a1a5ea28 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -228,6 +228,15 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
 
 		ctrl->dwMaxPayloadTransferSize = bandwidth;
 	}
+
+	if (stream->intf->num_altsetting > 1 &&
+	    ctrl->dwMaxPayloadTransferSize > stream->maxpsize) {
+		dev_warn_ratelimited(&stream->intf->dev,
+				     "UVC non compliance: the max payload transmission size (%u) exceeds the size of the ep max packet (%u). Using the max size.\n",
+				     ctrl->dwMaxPayloadTransferSize,
+				     stream->maxpsize);
+		ctrl->dwMaxPayloadTransferSize = stream->maxpsize;
+	}
 }
 
 static size_t uvc_video_ctrl_size(struct uvc_streaming *stream)
@@ -1300,12 +1309,6 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 	if (!meta_buf || length == 2)
 		return;
 
-	if (meta_buf->length - meta_buf->bytesused <
-	    length + sizeof(meta->ns) + sizeof(meta->sof)) {
-		meta_buf->error = 1;
-		return;
-	}
-
 	has_pts = mem[1] & UVC_STREAM_PTS;
 	has_scr = mem[1] & UVC_STREAM_SCR;
 
@@ -1326,6 +1329,12 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 				  !memcmp(scr, stream->clock.last_scr, 6)))
 		return;
 
+	if (meta_buf->length - meta_buf->bytesused <
+	    length + sizeof(meta->ns) + sizeof(meta->sof)) {
+		meta_buf->error = 1;
+		return;
+	}
+
 	meta = (struct uvc_meta_buf *)((u8 *)meta_buf->mem + meta_buf->bytesused);
 	local_irq_save(flags);
 	time = uvc_video_get_time();
diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 7ac7a5063fb2..d17b40bebf6f 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -2187,7 +2187,6 @@ void v4l2_ctrl_handler_free(struct v4l2_ctrl_handler *hdl)
 	kvfree(hdl->buckets);
 	hdl->buckets = NULL;
 	hdl->cached = NULL;
-	hdl->error = 0;
 	mutex_unlock(hdl->lock);
 	mutex_destroy(&hdl->_lock);
 }
@@ -3529,8 +3528,19 @@ v4l2_ctrls_find_req_obj(struct v4l2_ctrl_handler *hdl,
 	obj = media_request_object_find(req, &req_ops, hdl);
 	if (obj)
 		return obj;
+	/*
+	 * If there are no controls in this completed request,
+	 * then that can only happen if:
+	 *
+	 * 1) no controls were present in the queued request, and
+	 * 2) v4l2_ctrl_request_complete() could not allocate a
+	 *    control handler object to store the completed state in.
+	 *
+	 * So return ENOMEM to indicate that there was an out-of-memory
+	 * error.
+	 */
 	if (!set)
-		return ERR_PTR(-ENOENT);
+		return ERR_PTR(-ENOMEM);
 
 	new_hdl = kzalloc(sizeof(*new_hdl), GFP_KERNEL);
 	if (!new_hdl)
@@ -3541,8 +3551,8 @@ v4l2_ctrls_find_req_obj(struct v4l2_ctrl_handler *hdl,
 	if (!ret)
 		ret = v4l2_ctrl_request_bind(req, new_hdl, hdl);
 	if (ret) {
+		v4l2_ctrl_handler_free(new_hdl);
 		kfree(new_hdl);
-
 		return ERR_PTR(ret);
 	}
 
@@ -4113,8 +4123,25 @@ void v4l2_ctrl_request_complete(struct media_request *req,
 	 * wants to leave the controls unchanged.
 	 */
 	obj = media_request_object_find(req, &req_ops, main_hdl);
-	if (!obj)
-		return;
+	if (!obj) {
+		int ret;
+
+		/* Create a new request so the driver can return controls */
+		hdl = kzalloc(sizeof(*hdl), GFP_KERNEL);
+		if (!hdl)
+			return;
+
+		ret = v4l2_ctrl_handler_init(hdl, (main_hdl->nr_of_buckets - 1) * 8);
+		if (!ret)
+			ret = v4l2_ctrl_request_bind(req, hdl, main_hdl);
+		if (ret) {
+			v4l2_ctrl_handler_free(hdl);
+			kfree(hdl);
+			return;
+		}
+		hdl->request_is_queued = true;
+		obj = media_request_object_find(req, &req_ops, main_hdl);
+	}
 	hdl = container_of(obj, struct v4l2_ctrl_handler, req_obj);
 
 	list_for_each_entry(ref, &hdl->ctrl_refs, node) {
diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index 1c7a9dcfed65..e24ab362e51a 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -324,7 +324,7 @@ EXPORT_SYMBOL(memstick_init_req);
 static int h_memstick_read_dev_id(struct memstick_dev *card,
 				  struct memstick_request **mrq)
 {
-	struct ms_id_register id_reg;
+	struct ms_id_register id_reg = {};
 
 	if (!(*mrq)) {
 		memstick_init_req(&card->current_mrq, MS_TPC_READ_REG, &id_reg,
@@ -550,7 +550,6 @@ EXPORT_SYMBOL(memstick_add_host);
  */
 void memstick_remove_host(struct memstick_host *host)
 {
-	host->removing = 1;
 	flush_workqueue(workqueue);
 	mutex_lock(&host->lock);
 	if (host->card)
diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index dec279845a75..43ec4948daa2 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -812,6 +812,7 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 	int err;
 
 	host->eject = true;
+	msh->removing = true;
 	cancel_work_sync(&host->handle_req);
 	cancel_delayed_work_sync(&host->poll_card);
 
diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index 8acf6e6aff31..5451089f07da 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -698,6 +698,12 @@ static void rtsx_usb_disconnect(struct usb_interface *intf)
 }
 
 #ifdef CONFIG_PM
+static int rtsx_usb_resume_child(struct device *dev, void *data)
+{
+	pm_request_resume(dev);
+	return 0;
+}
+
 static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct rtsx_ucr *ucr =
@@ -713,8 +719,10 @@ static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
 			mutex_unlock(&ucr->dev_mutex);
 
 			/* Defer the autosuspend if card exists */
-			if (val & (SD_CD | MS_CD))
+			if (val & (SD_CD | MS_CD)) {
+				device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
 				return -EAGAIN;
+			}
 		} else {
 			/* There is an ongoing operation*/
 			return -EAGAIN;
@@ -724,12 +732,6 @@ static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
 	return 0;
 }
 
-static int rtsx_usb_resume_child(struct device *dev, void *data)
-{
-	pm_request_resume(dev);
-	return 0;
-}
-
 static int rtsx_usb_resume(struct usb_interface *intf)
 {
 	device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index d20943e43312..8a9912219e5e 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -507,7 +507,8 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
 	if (!desc) {
-		dma_unmap_sg(dma_chan->device->dev, data->sg, sg_len, dir_data);
+		dma_unmap_sg(dma_chan->device->dev, data->sg, data->sg_len,
+			     dir_data);
 		return;
 	}
 
diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 3261560bede4..581bec5c4caf 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1038,9 +1038,7 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
 		err = sd_power_on(host);
 	}
 
-	if (!err)
-		host->power_mode = power_mode;
-
+	host->power_mode = power_mode;
 	return err;
 }
 
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 22978057b94a..e75dbc0cfda1 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -972,7 +972,8 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
 {
 	return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_EMMC &&
 	       (dmi_match(DMI_BIOS_VENDOR, "LENOVO") ||
-		dmi_match(DMI_SYS_VENDOR, "IRBIS"));
+		dmi_match(DMI_SYS_VENDOR, "IRBIS") ||
+		dmi_match(DMI_SYS_VENDOR, "Positivo Tecnologia SA"));
 }
 
 static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 987626ffdb6f..3ac3f9d840ff 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -264,7 +264,8 @@ static struct sdhci_ops sdhci_am654_ops = {
 static const struct sdhci_pltfm_data sdhci_am654_pdata = {
 	.ops = &sdhci_am654_ops,
 	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
 };
 
 static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
@@ -286,7 +287,8 @@ static struct sdhci_ops sdhci_j721e_8bit_ops = {
 static const struct sdhci_pltfm_data sdhci_j721e_8bit_pdata = {
 	.ops = &sdhci_j721e_8bit_ops,
 	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
 };
 
 static const struct sdhci_am654_driver_data sdhci_j721e_8bit_drvdata = {
@@ -308,7 +310,8 @@ static struct sdhci_ops sdhci_j721e_4bit_ops = {
 static const struct sdhci_pltfm_data sdhci_j721e_4bit_pdata = {
 	.ops = &sdhci_j721e_4bit_ops,
 	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
 };
 
 static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
diff --git a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
index 2578f27914ef..ffe89209cf4b 100644
--- a/drivers/mtd/ftl.c
+++ b/drivers/mtd/ftl.c
@@ -344,7 +344,7 @@ static int erase_xfer(partition_t *part,
             return -ENOMEM;
 
     erase->addr = xfer->Offset;
-    erase->len = 1 << part->header.EraseUnitSize;
+    erase->len = 1ULL << part->header.EraseUnitSize;
 
     ret = mtd_erase(part->mbd.mtd, erase);
     if (!ret) {
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 997910bec727..a54ad340f1e2 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -370,7 +370,7 @@ static int atmel_nand_dma_transfer(struct atmel_nand_controller *nc,
 	dma_cookie_t cookie;
 
 	buf_dma = dma_map_single(nc->dev, buf, len, dir);
-	if (dma_mapping_error(nc->dev, dev_dma)) {
+	if (dma_mapping_error(nc->dev, buf_dma)) {
 		dev_err(nc->dev,
 			"Failed to prepare a buffer for DMA access\n");
 		goto err;
diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index d1ed5878b3b1..28ed65dd3d43 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -143,6 +143,7 @@ struct atmel_pmecc_caps {
 	int nstrengths;
 	int el_offset;
 	bool correct_erased_chunks;
+	bool clk_ctrl;
 };
 
 struct atmel_pmecc {
@@ -846,6 +847,10 @@ static struct atmel_pmecc *atmel_pmecc_create(struct platform_device *pdev,
 	if (IS_ERR(pmecc->regs.errloc))
 		return ERR_CAST(pmecc->regs.errloc);
 
+	/* pmecc data setup time */
+	if (caps->clk_ctrl)
+		writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_CLK);
+
 	/* Disable all interrupts before registering the PMECC handler. */
 	writel(0xffffffff, pmecc->regs.base + ATMEL_PMECC_IDR);
 	atmel_pmecc_reset(pmecc);
@@ -899,6 +904,7 @@ static struct atmel_pmecc_caps at91sam9g45_caps = {
 	.strengths = atmel_pmecc_strengths,
 	.nstrengths = 5,
 	.el_offset = 0x8c,
+	.clk_ctrl = true,
 };
 
 static struct atmel_pmecc_caps sama5d4_caps = {
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index bccadf8f27fa..c44b64542818 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -492,6 +492,8 @@ static int dma_xfer(struct fsmc_nand_data *host, void *buffer, int len,
 
 	dma_dev = chan->device;
 	dma_addr = dma_map_single(dma_dev->dev, buffer, len, direction);
+	if (dma_mapping_error(dma_dev->dev, dma_addr))
+		return -EINVAL;
 
 	if (direction == DMA_TO_DEVICE) {
 		dma_src = dma_addr;
diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index 560a0a5ba6f3..f269b5faa03a 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -953,6 +953,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		can->err_rep_cnt = 0;
 		can->bec.txerr = 0;
 		can->bec.rxerr = 0;
+		can->can.dev->dev_port = i;
 
 		init_completion(&can->start_comp);
 		init_completion(&can->flush_comp);
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index a96b22398407..602f0b3bbcdf 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -813,6 +813,7 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 
 	SET_NETDEV_DEV(netdev, &dev->intf->dev);
 	netdev->dev_id = channel;
+	netdev->dev_port = channel;
 
 	dev->nets[channel] = priv;
 
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index d41c9006a028..fea28b24a1a0 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -337,18 +337,23 @@ static void b53_set_forwarding(struct b53_device *dev, int enable)
 
 	b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_MODE, mgmt);
 
-	/* Include IMP port in dumb forwarding mode
-	 */
-	b53_read8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, &mgmt);
-	mgmt |= B53_MII_DUMB_FWDG_EN;
-	b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
-
-	/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
-	 * frames should be flooded or not.
-	 */
-	b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
-	mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
-	b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
+	if (!is5325(dev)) {
+		/* Include IMP port in dumb forwarding mode */
+		b53_read8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, &mgmt);
+		mgmt |= B53_MII_DUMB_FWDG_EN;
+		b53_write8(dev, B53_CTRL_PAGE, B53_SWITCH_CTRL, mgmt);
+
+		/* Look at B53_UC_FWD_EN and B53_MC_FWD_EN to decide whether
+		 * frames should be flooded or not.
+		 */
+		b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
+		mgmt |= B53_UC_FWD_EN | B53_MC_FWD_EN | B53_IPMC_FWD_EN;
+		b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
+	} else {
+		b53_read8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, &mgmt);
+		mgmt |= B53_IP_MCAST_25;
+		b53_write8(dev, B53_CTRL_PAGE, B53_IP_MULTICAST_CTRL, mgmt);
+	}
 }
 
 static void b53_enable_vlan(struct b53_device *dev, bool enable,
@@ -502,6 +507,10 @@ void b53_imp_vlan_setup(struct dsa_switch *ds, int cpu_port)
 	unsigned int i;
 	u16 pvlan;
 
+	/* BCM5325 CPU port is at 8 */
+	if ((is5325(dev) || is5365(dev)) && cpu_port == B53_CPU_PORT_25)
+		cpu_port = B53_CPU_PORT;
+
 	/* Enable the IMP port to be in the same VLAN as the other ports
 	 * on a per-port basis such that we only have Port i and IMP in
 	 * the same VLAN.
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index b2c539a42154..ea6897c3f6f7 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -103,6 +103,7 @@
 
 /* IP Multicast control (8 bit) */
 #define B53_IP_MULTICAST_CTRL		0x21
+#define  B53_IP_MCAST_25		BIT(0)
 #define  B53_IPMC_FWD_EN		BIT(1)
 #define  B53_UC_FWD_EN			BIT(6)
 #define  B53_MC_FWD_EN			BIT(7)
diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index 174344c450af..f6232e8178b8 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -2464,6 +2464,10 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
 							  skb->data,
 							  skb_headlen(skb),
 							  DMA_TO_DEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev,
+						      dma_addr))
+					return -ENOMEM;
+
 				desc[frag].addr_lo = lower_32_bits(dma_addr);
 				desc[frag].addr_hi = upper_32_bits(dma_addr);
 				frag++;
@@ -2473,6 +2477,10 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
 							  skb->data,
 							  skb_headlen(skb) / 2,
 							  DMA_TO_DEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev,
+						      dma_addr))
+					return -ENOMEM;
+
 				desc[frag].addr_lo = lower_32_bits(dma_addr);
 				desc[frag].addr_hi = upper_32_bits(dma_addr);
 				frag++;
@@ -2483,6 +2491,10 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
 							  skb_headlen(skb) / 2,
 							  skb_headlen(skb) / 2,
 							  DMA_TO_DEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev,
+						      dma_addr))
+					goto unmap_first_out;
+
 				desc[frag].addr_lo = lower_32_bits(dma_addr);
 				desc[frag].addr_hi = upper_32_bits(dma_addr);
 				frag++;
@@ -2494,6 +2506,9 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
 						    0,
 						    desc[frag].len_vlan,
 						    DMA_TO_DEVICE);
+			if (dma_mapping_error(&adapter->pdev->dev, dma_addr))
+				goto unmap_out;
+
 			desc[frag].addr_lo = lower_32_bits(dma_addr);
 			desc[frag].addr_hi = upper_32_bits(dma_addr);
 			frag++;
@@ -2583,6 +2598,27 @@ static int nic_send_packet(struct et131x_adapter *adapter, struct tcb *tcb)
 		       &adapter->regs->global.watchdog_timer);
 	}
 	return 0;
+
+unmap_out:
+	// Unmap the body of the packet with map_page
+	while (--i) {
+		frag--;
+		dma_addr = desc[frag].addr_lo;
+		dma_addr |= (u64)desc[frag].addr_hi << 32;
+		dma_unmap_page(&adapter->pdev->dev, dma_addr,
+			       desc[frag].len_vlan, DMA_TO_DEVICE);
+	}
+
+unmap_first_out:
+	// Unmap the header with map_single
+	while (frag--) {
+		dma_addr = desc[frag].addr_lo;
+		dma_addr |= (u64)desc[frag].addr_hi << 32;
+		dma_unmap_single(&adapter->pdev->dev, dma_addr,
+				 desc[frag].len_vlan, DMA_TO_DEVICE);
+	}
+
+	return -ENOMEM;
 }
 
 static int send_packet(struct sk_buff *skb, struct et131x_adapter *adapter)
diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 58a002dd758c..ba07817d0a22 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1049,6 +1049,11 @@ static bool ag71xx_fill_rx_buf(struct ag71xx *ag, struct ag71xx_buf *buf,
 	buf->rx.rx_buf = data;
 	buf->rx.dma_addr = dma_map_single(&ag->pdev->dev, data, ag->rx_buf_size,
 					  DMA_FROM_DEVICE);
+	if (dma_mapping_error(&ag->pdev->dev, buf->rx.dma_addr)) {
+		skb_free_frag(data);
+		buf->rx.rx_buf = NULL;
+		return false;
+	}
 	desc->data = (u32)buf->rx.dma_addr + offset;
 	return true;
 }
@@ -1343,6 +1348,10 @@ static netdev_tx_t ag71xx_hard_start_xmit(struct sk_buff *skb,
 
 	dma_addr = dma_map_single(&ag->pdev->dev, skb->data, skb->len,
 				  DMA_TO_DEVICE);
+	if (dma_mapping_error(&ag->pdev->dev, dma_addr)) {
+		netif_dbg(ag, tx_err, ndev, "DMA mapping error\n");
+		goto err_drop;
+	}
 
 	i = ring->curr & ring_mask;
 	desc = ag71xx_ring_desc(ring, i);
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index a34c33e8a8ad..8854025610e6 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1430,9 +1430,9 @@ static acpi_status bgx_acpi_match_id(acpi_handle handle, u32 lvl,
 {
 	struct acpi_buffer string = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct bgx *bgx = context;
-	char bgx_sel[5];
+	char bgx_sel[7];
 
-	snprintf(bgx_sel, 5, "BGX%d", bgx->bgx_id);
+	snprintf(bgx_sel, sizeof(bgx_sel), "BGX%d", bgx->bgx_id);
 	if (ACPI_FAILURE(acpi_get_name(handle, ACPI_SINGLE_NAME, &string))) {
 		pr_warn("Invalid link device\n");
 		return AE_OK;
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index d9bceb26f4e5..d6984c179bae 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -3851,8 +3851,8 @@ int be_cmd_set_mac_list(struct be_adapter *adapter, u8 *mac_array,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
 	spin_unlock_bh(&adapter->mcc_lock);
+	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
 	return status;
 }
 
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 4b9380003c85..ce235def334f 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1467,10 +1467,10 @@ static void be_tx_timeout(struct net_device *netdev)
 						 ntohs(tcphdr->source));
 					dev_info(dev, "TCP dest port %d\n",
 						 ntohs(tcphdr->dest));
-					dev_info(dev, "TCP sequence num %d\n",
-						 ntohs(tcphdr->seq));
-					dev_info(dev, "TCP ack_seq %d\n",
-						 ntohs(tcphdr->ack_seq));
+					dev_info(dev, "TCP sequence num %u\n",
+						 ntohl(tcphdr->seq));
+					dev_info(dev, "TCP ack_seq %u\n",
+						 ntohl(tcphdr->ack_seq));
 				} else if (ip_hdr(skb)->protocol ==
 					   IPPROTO_UDP) {
 					udphdr = udp_hdr(skb);
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 0a186d16e73f..3e44e60f15ff 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -516,8 +516,10 @@ static int dpaa_get_ts_info(struct net_device *net_dev,
 		of_node_put(ptp_node);
 	}
 
-	if (ptp_dev)
+	if (ptp_dev) {
 		ptp = platform_get_drvdata(ptp_dev);
+		put_device(&ptp_dev->dev);
+	}
 
 	if (ptp)
 		info->phc_index = ptp->phc_index;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index fd7c504b44f2..f8a096633280 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2590,27 +2590,25 @@ static int fec_enet_us_to_itr_clock(struct net_device *ndev, int us)
 static void fec_enet_itr_coal_set(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	int rx_itr, tx_itr;
+	u32 rx_itr = 0, tx_itr = 0;
+	int rx_ictt, tx_ictt;
 
-	/* Must be greater than zero to avoid unpredictable behavior */
-	if (!fep->rx_time_itr || !fep->rx_pkts_itr ||
-	    !fep->tx_time_itr || !fep->tx_pkts_itr)
-		return;
-
-	/* Select enet system clock as Interrupt Coalescing
-	 * timer Clock Source
-	 */
-	rx_itr = FEC_ITR_CLK_SEL;
-	tx_itr = FEC_ITR_CLK_SEL;
+	rx_ictt = fec_enet_us_to_itr_clock(ndev, fep->rx_time_itr);
+	tx_ictt = fec_enet_us_to_itr_clock(ndev, fep->tx_time_itr);
 
-	/* set ICFT and ICTT */
-	rx_itr |= FEC_ITR_ICFT(fep->rx_pkts_itr);
-	rx_itr |= FEC_ITR_ICTT(fec_enet_us_to_itr_clock(ndev, fep->rx_time_itr));
-	tx_itr |= FEC_ITR_ICFT(fep->tx_pkts_itr);
-	tx_itr |= FEC_ITR_ICTT(fec_enet_us_to_itr_clock(ndev, fep->tx_time_itr));
+	if (rx_ictt > 0 && fep->rx_pkts_itr > 1) {
+		/* Enable with enet system clock as Interrupt Coalescing timer Clock Source */
+		rx_itr = FEC_ITR_EN | FEC_ITR_CLK_SEL;
+		rx_itr |= FEC_ITR_ICFT(fep->rx_pkts_itr);
+		rx_itr |= FEC_ITR_ICTT(rx_ictt);
+	}
 
-	rx_itr |= FEC_ITR_EN;
-	tx_itr |= FEC_ITR_EN;
+	if (tx_ictt > 0 && fep->tx_pkts_itr > 1) {
+		/* Enable with enet system clock as Interrupt Coalescing timer Clock Source */
+		tx_itr = FEC_ITR_EN | FEC_ITR_CLK_SEL;
+		tx_itr |= FEC_ITR_ICFT(fep->tx_pkts_itr);
+		tx_itr |= FEC_ITR_ICTT(tx_ictt);
+	}
 
 	writel(tx_itr, fep->hwp + FEC_TXIC0);
 	writel(rx_itr, fep->hwp + FEC_RXIC0);
diff --git a/drivers/net/ethernet/freescale/gianfar_ethtool.c b/drivers/net/ethernet/freescale/gianfar_ethtool.c
index 01a7255e86c9..e5cd8fe4bd0f 100644
--- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
+++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
@@ -1490,8 +1490,10 @@ static int gfar_get_ts_info(struct net_device *dev,
 	if (ptp_node) {
 		ptp_dev = of_find_device_by_node(ptp_node);
 		of_node_put(ptp_node);
-		if (ptp_dev)
+		if (ptp_dev) {
 			ptp = platform_get_drvdata(ptp_dev);
+			put_device(&ptp_dev->dev);
+		}
 	}
 
 	if (ptp)
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index b14441944b4b..db72e5e4acd3 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -189,13 +189,14 @@ struct fm10k_q_vector {
 	struct fm10k_ring_container rx, tx;
 
 	struct napi_struct napi;
+	struct rcu_head rcu;	/* to avoid race with update stats on free */
+
 	cpumask_t affinity_mask;
 	char name[IFNAMSIZ + 9];
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dbg_q_vector;
 #endif /* CONFIG_DEBUG_FS */
-	struct rcu_head rcu;	/* to avoid race with update stats on free */
 
 	/* for dynamic allocation of rings associated with this q_vector */
 	struct fm10k_ring ring[0] ____cacheline_internodealigned_in_smp;
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 4c8c31692e9e..edb5e408c980 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -864,6 +864,7 @@ struct i40e_q_vector {
 	u16 reg_idx;		/* register index of the interrupt */
 
 	struct napi_struct napi;
+	struct rcu_head rcu;	/* to avoid race with update stats on free */
 
 	struct i40e_ring_container rx;
 	struct i40e_ring_container tx;
@@ -874,7 +875,6 @@ struct i40e_q_vector {
 	cpumask_t affinity_mask;
 	struct irq_affinity_notify affinity_notify;
 
-	struct rcu_head rcu;	/* to avoid race with update stats on free */
 	char name[I40E_INT_NAME_STR_LEN];
 	bool arm_wb_state;
 } ____cacheline_internodealigned_in_smp;
diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index 6cfe8eb7f47d..14fba20ab7f3 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -753,6 +753,8 @@ enum ice_status ice_copy_and_init_pkg(struct ice_hw *hw, const u8 *buf, u32 len)
 		return ICE_ERR_PARAM;
 
 	buf_copy = devm_kmemdup(ice_hw_to_dev(hw), buf, len, GFP_KERNEL);
+	if (!buf_copy)
+		return ICE_ERR_NO_MEMORY;
 
 	status = ice_init_pkg(hw, buf_copy, len);
 	if (status) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 0142ca226bf5..0f9a1fce0dee 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -458,9 +458,10 @@ struct ixgbe_q_vector {
 	struct ixgbe_ring_container rx, tx;
 
 	struct napi_struct napi;
+	struct rcu_head rcu;	/* to avoid race with update stats on free */
+
 	cpumask_t affinity_mask;
 	int numa_node;
-	struct rcu_head rcu;	/* to avoid race with update stats on free */
 	char name[IFNAMSIZ + 9];
 
 	/* for dynamic allocation of rings associated with this q_vector */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 921a2ddb497e..c68eb5dddf5b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -582,7 +582,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 	dma_addr_t dma;
 	u32 cmd_type;
 
-	while (budget-- > 0) {
+	while (likely(budget)) {
 		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
 			work_done = false;
 			break;
@@ -619,6 +619,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 		xdp_ring->next_to_use++;
 		if (xdp_ring->next_to_use == xdp_ring->count)
 			xdp_ring->next_to_use = 0;
+
+		budget--;
 	}
 
 	if (tx_desc) {
diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 951482d899f9..a834a0c7f770 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -293,7 +293,7 @@ static void xemaclite_aligned_read(u32 *src_ptr, u8 *dest_ptr,
 
 		/* Read the remaining data */
 		for (; length > 0; length--)
-			*to_u8_ptr = *from_u8_ptr;
+			*to_u8_ptr++ = *from_u8_ptr++;
 	}
 }
 
diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index e387c219f17d..68bb94f970f6 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -306,6 +306,7 @@ static struct phy_driver smsc_phy_driver[] = {
 	/* PHY_BASIC_FEATURES */
 	.flags		= PHY_RST_AFTER_CLK_EN,
 
+	.flags		= PHY_RST_AFTER_CLK_EN,
 	.probe		= smsc_phy_probe,
 
 	/* basic functions */
diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index e1fabb3e3246..83541444bc8c 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -141,15 +141,13 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	int len;
 	unsigned char *data;
 	__u32 seq_recv;
-
-
 	struct rtable *rt;
 	struct net_device *tdev;
 	struct iphdr  *iph;
 	int    max_headroom;
 
 	if (sk_pppox(po)->sk_state & PPPOX_DEAD)
-		goto tx_error;
+		goto tx_drop;
 
 	rt = ip_route_output_ports(net, &fl4, NULL,
 				   opt->dst_addr.sin_addr.s_addr,
@@ -157,7 +155,7 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 				   0, 0, IPPROTO_GRE,
 				   RT_TOS(0), 0);
 	if (IS_ERR(rt))
-		goto tx_error;
+		goto tx_drop;
 
 	tdev = rt->dst.dev;
 
@@ -165,16 +163,20 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 
 	if (skb_headroom(skb) < max_headroom || skb_cloned(skb) || skb_shared(skb)) {
 		struct sk_buff *new_skb = skb_realloc_headroom(skb, max_headroom);
-		if (!new_skb) {
-			ip_rt_put(rt);
+
+		if (!new_skb)
 			goto tx_error;
-		}
+
 		if (skb->sk)
 			skb_set_owner_w(new_skb, skb->sk);
 		consume_skb(skb);
 		skb = new_skb;
 	}
 
+	/* Ensure we can safely access protocol field and LCP code */
+	if (!pskb_may_pull(skb, 3))
+		goto tx_error;
+
 	data = skb->data;
 	islcp = ((data[0] << 8) + data[1]) == PPP_LCP && 1 <= data[2] && data[2] <= 7;
 
@@ -248,6 +250,8 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	return 1;
 
 tx_error:
+	ip_rt_put(rt);
+tx_drop:
 	kfree_skb(skb);
 	return 1;
 }
diff --git a/drivers/net/usb/sierra_net.c b/drivers/net/usb/sierra_net.c
index 6f9ec5ce61dc..a8f8134fab36 100644
--- a/drivers/net/usb/sierra_net.c
+++ b/drivers/net/usb/sierra_net.c
@@ -694,6 +694,10 @@ static int sierra_net_bind(struct usbnet *dev, struct usb_interface *intf)
 			status);
 		return -ENODEV;
 	}
+	if (!dev->status) {
+		dev_err(&dev->udev->dev, "No status endpoint found");
+		return -ENODEV;
+	}
 	/* Initialize sierra private data */
 	priv = kzalloc(sizeof *priv, GFP_KERNEL);
 	if (!priv)
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 1e8f395c8639..87c0bcfef480 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1097,6 +1097,9 @@ static void __handle_link_change(struct usbnet *dev)
 	if (!test_bit(EVENT_DEV_OPEN, &dev->flags))
 		return;
 
+	if (test_and_clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags))
+		netif_carrier_on(dev->net);
+
 	if (!netif_carrier_ok(dev->net)) {
 		/* kill URBs for reading packets to save bus bandwidth */
 		unlink_urbs(dev, &dev->rxq);
@@ -1978,10 +1981,12 @@ EXPORT_SYMBOL(usbnet_manage_power);
 void usbnet_link_change(struct usbnet *dev, bool link, bool need_reset)
 {
 	/* update link after link is reseted */
-	if (link && !need_reset)
-		netif_carrier_on(dev->net);
-	else
+	if (link && !need_reset) {
+		set_bit(EVENT_LINK_CARRIER_ON, &dev->flags);
+	} else {
+		clear_bit(EVENT_LINK_CARRIER_ON, &dev->flags);
 		netif_carrier_off(dev->net);
+	}
 
 	if (need_reset && link)
 		usbnet_defer_kevent(dev, EVENT_LINK_RESET);
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 215c546bf50a..6f82338c617e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -394,6 +394,26 @@ static unsigned int mergeable_ctx_to_truesize(void *mrg_ctx)
 	return (unsigned long)mrg_ctx & ((1 << MRG_CTX_HEADER_SHIFT) - 1);
 }
 
+static int check_mergeable_len(struct net_device *dev, void *mrg_ctx,
+			       unsigned int len)
+{
+	unsigned int headroom, tailroom, room, truesize;
+
+	truesize = mergeable_ctx_to_truesize(mrg_ctx);
+	headroom = mergeable_ctx_to_headroom(mrg_ctx);
+	tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
+	room = SKB_DATA_ALIGN(headroom + tailroom);
+
+	if (len > truesize - room) {
+		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
+			 dev->name, len, (unsigned long)(truesize - room));
+		dev->stats.rx_length_errors++;
+		return -1;
+	}
+
+	return 0;
+}
+
 /* Called from bottom half context */
 static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 				   struct receive_queue *rq,
@@ -639,7 +659,8 @@ static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
  * across multiple buffers (num_buf > 1), and we make sure buffers
  * have enough headroom.
  */
-static struct page *xdp_linearize_page(struct receive_queue *rq,
+static struct page *xdp_linearize_page(struct net_device *dev,
+				       struct receive_queue *rq,
 				       u16 *num_buf,
 				       struct page *p,
 				       int offset,
@@ -659,18 +680,27 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
 	memcpy(page_address(page) + page_off, page_address(p) + offset, *len);
 	page_off += *len;
 
+	/* Only mergeable mode can go inside this while loop. In small mode,
+	 * *num_buf == 1, so it cannot go inside.
+	 */
 	while (--*num_buf) {
 		unsigned int buflen;
 		void *buf;
+		void *ctx;
 		int off;
 
-		buf = virtqueue_get_buf(rq->vq, &buflen);
+		buf = virtqueue_get_buf_ctx(rq->vq, &buflen, &ctx);
 		if (unlikely(!buf))
 			goto err_buf;
 
 		p = virt_to_head_page(buf);
 		off = buf - page_address(p);
 
+		if (check_mergeable_len(dev, ctx, buflen)) {
+			put_page(p);
+			goto err_buf;
+		}
+
 		/* guard against a misconfigured or uncooperative backend that
 		 * is sending packet larger than the MTU.
 		 */
@@ -745,7 +775,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 			headroom = vi->hdr_len + header_offset;
 			buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
 				 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-			xdp_page = xdp_linearize_page(rq, &num_buf, page,
+			xdp_page = xdp_linearize_page(dev, rq, &num_buf, page,
 						      offset, header_offset,
 						      &tlen);
 			if (!xdp_page)
@@ -910,7 +940,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		if (unlikely(num_buf > 1 ||
 			     headroom < virtnet_get_headroom(vi))) {
 			/* linearize data for XDP */
-			xdp_page = xdp_linearize_page(rq, &num_buf,
+			xdp_page = xdp_linearize_page(dev, rq, &num_buf,
 						      page, offset,
 						      VIRTIO_XDP_HEADROOM,
 						      &len);
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index b51a2367dbaa..8a320300a617 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1040,6 +1040,8 @@ static void vrf_ip6_input_dst(struct sk_buff *skb, struct net_device *vrf_dev,
 	struct net *net = dev_net(vrf_dev);
 	struct rt6_info *rt6;
 
+	skb_dst_drop(skb);
+
 	rt6 = vrf_ip6_route_lookup(net, vrf_dev, &fl6, ifindex, skb,
 				   RT6_LOOKUP_F_HAS_SADDR | RT6_LOOKUP_F_IFACE);
 	if (unlikely(!rt6))
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 668c8897c109..f9508d71fc6c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1118,10 +1118,6 @@ brcmf_cfg80211_scan(struct wiphy *wiphy, struct cfg80211_scan_request *request)
 		return -EAGAIN;
 	}
 
-	/* If scan req comes for p2p0, send it over primary I/F */
-	if (vif == cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif)
-		vif = cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
-
 	brcmf_dbg(SCAN, "START ESCAN\n");
 
 	cfg->scan_request = request;
@@ -1137,6 +1133,10 @@ brcmf_cfg80211_scan(struct wiphy *wiphy, struct cfg80211_scan_request *request)
 	if (err)
 		goto scan_out;
 
+	/* If scan req comes for p2p0, send it over primary I/F */
+	if (vif == cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif)
+		vif = cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
+
 	err = brcmf_do_escan(vif->ifp, request);
 	if (err)
 		goto scan_out;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
index 1e597e5de5f1..b4f6f8682fa9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
@@ -974,7 +974,7 @@ void wlc_lcnphy_read_table(struct brcms_phy *pi, struct phytbl_info *pti)
 
 static void
 wlc_lcnphy_common_read_table(struct brcms_phy *pi, u32 tbl_id,
-			     const u16 *tbl_ptr, u32 tbl_len,
+			     u16 *tbl_ptr, u32 tbl_len,
 			     u32 tbl_width, u32 tbl_offset)
 {
 	struct phytbl_info tab;
diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 20c933602f0a..31f1c57450d4 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -1573,8 +1573,11 @@ il4965_tx_cmd_build_rate(struct il_priv *il,
 	    || rate_idx > RATE_COUNT_LEGACY)
 		rate_idx = rate_lowest_index(&il->bands[info->band], sta);
 	/* For 5 GHZ band, remap mac80211 rate indices into driver indices */
-	if (info->band == NL80211_BAND_5GHZ)
+	if (info->band == NL80211_BAND_5GHZ) {
 		rate_idx += IL_FIRST_OFDM_RATE;
+		if (rate_idx > IL_LAST_OFDM_RATE)
+			rate_idx = IL_LAST_OFDM_RATE;
+	}
 	/* Get PLCP rate for tx_cmd->rate_n_flags */
 	rate_plcp = il_rates[rate_idx].plcp;
 	/* Zero out flags for this packet */
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 4f2789bb3b5b..9ca704a2c679 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1055,9 +1055,11 @@ static void iwl_bg_restart(struct work_struct *data)
  *
  *****************************************************************************/
 
-static void iwl_setup_deferred_work(struct iwl_priv *priv)
+static int iwl_setup_deferred_work(struct iwl_priv *priv)
 {
 	priv->workqueue = alloc_ordered_workqueue(DRV_NAME, 0);
+	if (!priv->workqueue)
+		return -ENOMEM;
 
 	INIT_WORK(&priv->restart, iwl_bg_restart);
 	INIT_WORK(&priv->beacon_update, iwl_bg_beacon_update);
@@ -1074,6 +1076,8 @@ static void iwl_setup_deferred_work(struct iwl_priv *priv)
 	timer_setup(&priv->statistics_periodic, iwl_bg_statistics_periodic, 0);
 
 	timer_setup(&priv->ucode_trace, iwl_bg_ucode_trace, 0);
+
+	return 0;
 }
 
 void iwl_cancel_deferred_work(struct iwl_priv *priv)
@@ -1469,7 +1473,9 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	/********************
 	 * 6. Setup services
 	 ********************/
-	iwl_setup_deferred_work(priv);
+	if (iwl_setup_deferred_work(priv))
+		goto out_uninit_drv;
+
 	iwl_setup_rx_handlers(priv);
 
 	iwl_power_initialize(priv);
@@ -1507,6 +1513,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	iwl_cancel_deferred_work(priv);
 	destroy_workqueue(priv->workqueue);
 	priv->workqueue = NULL;
+out_uninit_drv:
 	iwl_uninit_drv(priv);
 out_free_eeprom_blob:
 	kfree(priv->eeprom_blob);
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
index e68a13c33c45..19defdb43126 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rs.c
@@ -2935,7 +2935,7 @@ static void rs_fill_link_cmd(struct iwl_priv *priv,
 		/* Repeat initial/next rate.
 		 * For legacy IWL_NUMBER_TRY == 1, this loop will not execute.
 		 * For HT IWL_HT_NUMBER_TRY == 3, this executes twice. */
-		while (repeat_rate > 0 && (index < LINK_QUAL_MAX_RETRY_NUM)) {
+		while (repeat_rate > 0 && index < (LINK_QUAL_MAX_RETRY_NUM - 1)) {
 			if (is_legacy(tbl_type.lq_type)) {
 				if (ant_toggle_cnt < NUM_TRY_BEFORE_ANT_TOGGLE)
 					ant_toggle_cnt++;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 286b5ca3b167..14f96bd41377 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2130,6 +2130,7 @@ int iwl_fw_dbg_collect(struct iwl_fw_runtime *fwrt,
 	struct iwl_fw_dump_desc *desc;
 	unsigned int delay = 0;
 	bool monitor_only = false;
+	int ret;
 
 	if (trigger) {
 		u16 occurrences = le16_to_cpu(trigger->occurrences) - 1;
@@ -2160,7 +2161,11 @@ int iwl_fw_dbg_collect(struct iwl_fw_runtime *fwrt,
 	desc->trig_desc.type = cpu_to_le32(trig);
 	memcpy(desc->trig_desc.data, str, len);
 
-	return iwl_fw_dbg_collect_desc(fwrt, desc, monitor_only, delay);
+	ret = iwl_fw_dbg_collect_desc(fwrt, desc, monitor_only, delay);
+	if (ret)
+		kfree(desc);
+
+	return ret;
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_collect);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 18c5975d7c03..70ba91d2bedf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -123,8 +123,10 @@ static int __init iwl_mvm_init(void)
 	}
 
 	ret = iwl_opmode_register("iwlmvm", &iwl_mvm_ops);
-	if (ret)
+	if (ret) {
 		pr_err("Unable to register MVM op_mode: %d\n", ret);
+		iwl_mvm_rate_control_unregister();
+	}
 
 	return ret;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 55292e9b15c1..b860aad4c155 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -874,7 +874,7 @@ static inline bool iwl_mvm_scan_fits(struct iwl_mvm *mvm, int n_ssids,
 				     int n_channels)
 {
 	return ((n_ssids <= PROBE_OPTION_MAX) &&
-		(n_channels <= mvm->fw->ucode_capa.n_scan_channels) &
+		(n_channels <= mvm->fw->ucode_capa.n_scan_channels) &&
 		(ies->common_ie_len +
 		 ies->len[NL80211_BAND_2GHZ] +
 		 ies->len[NL80211_BAND_5GHZ] <=
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index abd5c8670bc4..a0c15af1b167 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -1220,6 +1220,10 @@ static int rxq_refill(struct ieee80211_hw *hw, int index, int limit)
 
 		addr = pci_map_single(priv->pdev, skb->data,
 				      MWL8K_RX_MAXSZ, DMA_FROM_DEVICE);
+		if (dma_mapping_error(&priv->pdev->dev, addr)) {
+			kfree_skb(skb);
+			break;
+		}
 
 		rxq->rxd_count++;
 		rx = rxq->tail++;
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index eb68b2d3caa1..c9df185dc3f4 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -1041,10 +1041,11 @@ static void rtl8187_stop(struct ieee80211_hw *dev)
 	rtl818x_iowrite8(priv, &priv->map->CONFIG4, reg | RTL818X_CONFIG4_VCOOFF);
 	rtl818x_iowrite8(priv, &priv->map->EEPROM_CMD, RTL818X_EEPROM_CMD_NORMAL);
 
+	usb_kill_anchored_urbs(&priv->anchored);
+
 	while ((skb = skb_dequeue(&priv->b_tx_status.queue)))
 		dev_kfree_skb_any(skb);
 
-	usb_kill_anchored_urbs(&priv->anchored);
 	mutex_unlock(&priv->conf_mutex);
 
 	if (!priv->is_rtl8187b)
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 5611f00ef0bd..81d1c544313f 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5387,7 +5387,7 @@ static int rtl8xxxu_submit_rx_urb(struct rtl8xxxu_priv *priv,
 		skb_size = fops->rx_agg_buf_size;
 		skb_size += (rx_desc_sz + sizeof(struct rtl8723au_phy_stats));
 	} else {
-		skb_size = IEEE80211_MAX_FRAME_LEN;
+		skb_size = IEEE80211_MAX_FRAME_LEN + rx_desc_sz;
 	}
 
 	skb = __netdev_alloc_skb(NULL, skb_size, GFP_KERNEL);
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 9339c6d2b258..daf6d0eeb3e3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -804,13 +804,19 @@ static void _rtl_pci_rx_interrupt(struct ieee80211_hw *hw)
 		skb = new_skb;
 no_new:
 		if (rtlpriv->use_new_trx_flow) {
-			_rtl_pci_init_one_rxdesc(hw, skb, (u8 *)buffer_desc,
-						 rxring_idx,
-						 rtlpci->rx_ring[rxring_idx].idx);
+			if (!_rtl_pci_init_one_rxdesc(hw, skb, (u8 *)buffer_desc,
+						      rxring_idx,
+						      rtlpci->rx_ring[rxring_idx].idx)) {
+				if (new_skb)
+					dev_kfree_skb_any(skb);
+			}
 		} else {
-			_rtl_pci_init_one_rxdesc(hw, skb, (u8 *)pdesc,
-						 rxring_idx,
-						 rtlpci->rx_ring[rxring_idx].idx);
+			if (!_rtl_pci_init_one_rxdesc(hw, skb, (u8 *)pdesc,
+						      rxring_idx,
+						      rtlpci->rx_ring[rxring_idx].idx)) {
+				if (new_skb)
+					dev_kfree_skb_any(skb);
+			}
 			if (rtlpci->rx_ring[rxring_idx].idx ==
 			    rtlpci->rxringcount - 1)
 				rtlpriv->cfg->ops->set_desc(hw, (u8 *)pdesc,
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ef8e677ce9d1..281ddde9d8cc 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -445,7 +445,7 @@ static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
 			dev_dbg(dev, "malformed TLP received from the link\n");
 
 		if (sub_reg & PCIE_CORE_INT_UCR)
-			dev_dbg(dev, "malformed TLP received from the link\n");
+			dev_dbg(dev, "Unexpected Completion received from the link\n");
 
 		if (sub_reg & PCIE_CORE_INT_FCE)
 			dev_dbg(dev, "an error was observed in the flow control advertisements from the other side\n");
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d1288a0bd530..98d54c78f08d 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -480,6 +480,7 @@ void pci_ep_cfs_remove_epf_group(struct config_group *group)
 	if (IS_ERR_OR_NULL(group))
 		return;
 
+	list_del(&group->group_entry);
 	configfs_unregister_default_group(group);
 }
 EXPORT_SYMBOL(pci_ep_cfs_remove_epf_group);
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index fb1306de8f40..3d76bebe96c1 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -155,7 +155,7 @@ static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 	mutex_lock(&pci_epf_mutex);
 	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
 		pci_ep_cfs_remove_epf_group(group);
-	list_del(&driver->epf_group);
+	WARN_ON(!list_empty(&driver->epf_group));
 	mutex_unlock(&pci_epf_mutex);
 }
 
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 382494261830..800964c81e06 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -18,6 +18,9 @@
 #define DRIVER_AUTHOR	"Gavin Shan, IBM Corporation"
 #define DRIVER_DESC	"PowerPC PowerNV PCI Hotplug Driver"
 
+#define SLOT_WARN(sl, x...) \
+	((sl)->pdev ? pci_warn((sl)->pdev, x) : dev_warn(&(sl)->bus->dev, x))
+
 struct pnv_php_event {
 	bool			added;
 	struct pnv_php_slot	*php_slot;
@@ -270,7 +273,7 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
 
 	ret = pnv_pci_get_device_tree(php_slot->dn->phandle, fdt1, 0x10000);
 	if (ret) {
-		pci_warn(php_slot->pdev, "Error %d getting FDT blob\n", ret);
+		SLOT_WARN(php_slot, "Error %d getting FDT blob\n", ret);
 		goto free_fdt1;
 	}
 
@@ -284,7 +287,7 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
 	dt = of_fdt_unflatten_tree(fdt, php_slot->dn, NULL);
 	if (!dt) {
 		ret = -EINVAL;
-		pci_warn(php_slot->pdev, "Cannot unflatten FDT\n");
+		SLOT_WARN(php_slot, "Cannot unflatten FDT\n");
 		goto free_fdt;
 	}
 
@@ -294,15 +297,15 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
 	ret = pnv_php_populate_changeset(&php_slot->ocs, php_slot->dn);
 	if (ret) {
 		pnv_php_reverse_nodes(php_slot->dn);
-		pci_warn(php_slot->pdev, "Error %d populating changeset\n",
-			 ret);
+		SLOT_WARN(php_slot, "Error %d populating changeset\n",
+			  ret);
 		goto free_dt;
 	}
 
 	php_slot->dn->child = NULL;
 	ret = of_changeset_apply(&php_slot->ocs);
 	if (ret) {
-		pci_warn(php_slot->pdev, "Error %d applying changeset\n", ret);
+		SLOT_WARN(php_slot, "Error %d applying changeset\n", ret);
 		goto destroy_changeset;
 	}
 
@@ -341,18 +344,19 @@ int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
 	ret = pnv_pci_set_power_state(php_slot->id, state, &msg);
 	if (ret > 0) {
 		if (be64_to_cpu(msg.params[1]) != php_slot->dn->phandle	||
-		    be64_to_cpu(msg.params[2]) != state			||
-		    be64_to_cpu(msg.params[3]) != OPAL_SUCCESS) {
-			pci_warn(php_slot->pdev, "Wrong msg (%lld, %lld, %lld)\n",
-				 be64_to_cpu(msg.params[1]),
-				 be64_to_cpu(msg.params[2]),
-				 be64_to_cpu(msg.params[3]));
+		    be64_to_cpu(msg.params[2]) != state) {
+			SLOT_WARN(php_slot, "Wrong msg (%lld, %lld, %lld)\n",
+				  be64_to_cpu(msg.params[1]),
+				  be64_to_cpu(msg.params[2]),
+				  be64_to_cpu(msg.params[3]));
 			return -ENOMSG;
 		}
+		if (be64_to_cpu(msg.params[3]) != OPAL_SUCCESS) {
+			ret = -ENODEV;
+			goto error;
+		}
 	} else if (ret < 0) {
-		pci_warn(php_slot->pdev, "Error %d powering %s\n",
-			 ret, (state == OPAL_PCI_SLOT_POWER_ON) ? "on" : "off");
-		return ret;
+		goto error;
 	}
 
 	if (state == OPAL_PCI_SLOT_POWER_OFF || state == OPAL_PCI_SLOT_OFFLINE)
@@ -361,6 +365,11 @@ int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
 		ret = pnv_php_add_devtree(php_slot);
 
 	return ret;
+
+error:
+	SLOT_WARN(php_slot, "Error %d powering %s\n",
+		  ret, (state == OPAL_PCI_SLOT_POWER_ON) ? "on" : "off");
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pnv_php_set_slot_power_state);
 
@@ -377,8 +386,8 @@ static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
 	 */
 	ret = pnv_pci_get_power_state(php_slot->id, &power_state);
 	if (ret) {
-		pci_warn(php_slot->pdev, "Error %d getting power status\n",
-			 ret);
+		SLOT_WARN(php_slot, "Error %d getting power status\n",
+			  ret);
 	} else {
 		*state = power_state;
 	}
@@ -386,6 +395,20 @@ static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
 	return 0;
 }
 
+static int pcie_check_link_active(struct pci_dev *pdev)
+{
+	u16 lnk_status;
+	int ret;
+
+	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
+		return -ENODEV;
+
+	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+
+	return ret;
+}
+
 static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 {
 	struct pnv_php_slot *php_slot = to_pnv_php_slot(slot);
@@ -398,10 +421,23 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 	 */
 	ret = pnv_pci_get_presence_state(php_slot->id, &presence);
 	if (ret >= 0) {
+		if (pci_pcie_type(php_slot->pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
+			presence == OPAL_PCI_SLOT_EMPTY) {
+			/*
+			 * Similar to pciehp_hpc, check whether the Link Active
+			 * bit is set to account for broken downstream bridges
+			 * that don't properly assert Presence Detect State, as
+			 * was observed on the Microsemi Switchtec PM8533 PFX
+			 * [11f8:8533].
+			 */
+			if (pcie_check_link_active(php_slot->pdev) > 0)
+				presence = OPAL_PCI_SLOT_PRESENT;
+		}
+
 		*state = presence;
 		ret = 0;
 	} else {
-		pci_warn(php_slot->pdev, "Error %d getting presence\n", ret);
+		SLOT_WARN(php_slot, "Error %d getting presence\n", ret);
 	}
 
 	return ret;
@@ -674,7 +710,7 @@ static int pnv_php_register_slot(struct pnv_php_slot *php_slot)
 	ret = pci_hp_register(&php_slot->slot, php_slot->bus,
 			      php_slot->slot_no, php_slot->name);
 	if (ret) {
-		pci_warn(php_slot->pdev, "Error %d registering slot\n", ret);
+		SLOT_WARN(php_slot, "Error %d registering slot\n", ret);
 		return ret;
 	}
 
@@ -727,7 +763,7 @@ static int pnv_php_enable_msix(struct pnv_php_slot *php_slot)
 	/* Enable MSIx */
 	ret = pci_enable_msix_exact(pdev, &entry, 1);
 	if (ret) {
-		pci_warn(pdev, "Error %d enabling MSIx\n", ret);
+		SLOT_WARN(php_slot, "Error %d enabling MSIx\n", ret);
 		return ret;
 	}
 
@@ -777,8 +813,9 @@ static irqreturn_t pnv_php_interrupt(int irq, void *data)
 		   (sts & PCI_EXP_SLTSTA_PDC)) {
 		ret = pnv_pci_get_presence_state(php_slot->id, &presence);
 		if (ret) {
-			pci_warn(pdev, "PCI slot [%s] error %d getting presence (0x%04x), to retry the operation.\n",
-				 php_slot->name, ret, sts);
+			SLOT_WARN(php_slot,
+				  "PCI slot [%s] error %d getting presence (0x%04x), to retry the operation.\n",
+				  php_slot->name, ret, sts);
 			return IRQ_HANDLED;
 		}
 
@@ -808,8 +845,9 @@ static irqreturn_t pnv_php_interrupt(int irq, void *data)
 	 */
 	event = kzalloc(sizeof(*event), GFP_ATOMIC);
 	if (!event) {
-		pci_warn(pdev, "PCI slot [%s] missed hotplug event 0x%04x\n",
-			 php_slot->name, sts);
+		SLOT_WARN(php_slot,
+			  "PCI slot [%s] missed hotplug event 0x%04x\n",
+			  php_slot->name, sts);
 		return IRQ_HANDLED;
 	}
 
@@ -833,7 +871,7 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 	/* Allocate workqueue */
 	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
 	if (!php_slot->wq) {
-		pci_warn(pdev, "Cannot alloc workqueue\n");
+		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
 		pnv_php_disable_irq(php_slot, true);
 		return;
 	}
@@ -857,7 +895,7 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 			  php_slot->name, php_slot);
 	if (ret) {
 		pnv_php_disable_irq(php_slot, true);
-		pci_warn(pdev, "Error %d enabling IRQ %d\n", ret, irq);
+		SLOT_WARN(php_slot, "Error %d enabling IRQ %d\n", ret, irq);
 		return;
 	}
 
@@ -893,7 +931,7 @@ static void pnv_php_enable_irq(struct pnv_php_slot *php_slot)
 
 	ret = pci_enable_device(pdev);
 	if (ret) {
-		pci_warn(pdev, "Error %d enabling device\n", ret);
+		SLOT_WARN(php_slot, "Error %d enabling device\n", ret);
 		return;
 	}
 
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 86dc5ae17c6d..07d1508e6dc5 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -791,13 +791,11 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
 bool pciehp_is_native(struct pci_dev *bridge)
 {
 	const struct pci_host_bridge *host;
-	u32 slot_cap;
 
 	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
 		return false;
 
-	pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
-	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
+	if (!bridge->is_pciehp)
 		return false;
 
 	if (pcie_ports_native)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 050fb376d1c5..11aa5cf9bd1f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2646,8 +2646,12 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
  * pci_bridge_d3_possible - Is it possible to put the bridge into D3
  * @bridge: Bridge to check
  *
- * This function checks if it is possible to move the bridge to D3.
- * Currently we only allow D3 for recent enough PCIe ports and Thunderbolt.
+ * Currently we only allow D3 for some PCIe ports and for Thunderbolt.
+ *
+ * Return: Whether it is possible to move the bridge to D3.
+ *
+ * The return value is guaranteed to be constant across the entire lifetime
+ * of the bridge, including its hot-removal.
  */
 bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cae7ca18a69d..aa726740514b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1479,7 +1479,7 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &reg32);
 	if (reg32 & PCI_EXP_SLTCAP_HPC)
-		pdev->is_hotplug_bridge = 1;
+		pdev->is_hotplug_bridge = pdev->is_pciehp = 1;
 }
 
 static void set_pcie_thunderbolt(struct pci_dev *dev)
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 10595b43360b..2a9c2d94eb55 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -340,6 +340,7 @@ static struct irq_chip stm32_gpio_irq_chip = {
 	.irq_set_wake	= irq_chip_set_wake_parent,
 	.irq_request_resources = stm32_gpio_irq_request_resources,
 	.irq_release_resources = stm32_gpio_irq_release_resources,
+	.irq_set_affinity = IS_ENABLED(CONFIG_SMP) ? irq_chip_set_affinity_parent : NULL,
 };
 
 static int stm32_gpio_domain_translate(struct irq_domain *d,
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 8c41f8b818b2..83775dd12cfa 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -327,6 +327,7 @@ static int sunxi_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	const char *function, *pin_prop;
 	const char *group;
 	int ret, npins, nmaps, configlen = 0, i = 0;
+	struct pinctrl_map *new_map;
 
 	*map = NULL;
 	*num_maps = 0;
@@ -401,9 +402,13 @@ static int sunxi_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	 * We know have the number of maps we need, we can resize our
 	 * map array
 	 */
-	*map = krealloc(*map, i * sizeof(struct pinctrl_map), GFP_KERNEL);
-	if (!*map)
-		return -ENOMEM;
+	new_map = krealloc(*map, i * sizeof(struct pinctrl_map), GFP_KERNEL);
+	if (!new_map) {
+		ret = -ENOMEM;
+		goto err_free_map;
+	}
+
+	*map = new_map;
 
 	return 0;
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 9eb74d9e1519..e480fff7142a 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -514,12 +514,12 @@ static unsigned long __init tpacpi_check_quirks(
 	return 0;
 }
 
-static inline bool __pure __init tpacpi_is_lenovo(void)
+static __always_inline bool __pure __init tpacpi_is_lenovo(void)
 {
 	return thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO;
 }
 
-static inline bool __pure __init tpacpi_is_ibm(void)
+static __always_inline bool __pure __init tpacpi_is_ibm(void)
 {
 	return thinkpad_id.vendor == PCI_VENDOR_ID_IBM;
 }
diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index f912284b2e55..34f570ccbe47 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -448,11 +448,9 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
 	if (!info)
 		return -EINVAL;
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = bq24190_read_mask(bdi, info->reg, info->mask, info->shift, &v);
 	if (ret)
@@ -483,7 +481,7 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = pm_runtime_get_sync(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
 	if (ret < 0)
 		return ret;
 
@@ -504,10 +502,9 @@ static int bq24190_set_charge_mode(struct regulator_dev *dev, u8 val)
 	struct bq24190_dev_info *bdi = rdev_get_drvdata(dev);
 	int ret;
 
-	ret = pm_runtime_get_sync(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
 	if (ret < 0) {
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
-		pm_runtime_put_noidle(bdi->dev);
 		return ret;
 	}
 
@@ -537,10 +534,9 @@ static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
 	int ret;
 	u8 val;
 
-	ret = pm_runtime_get_sync(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
 	if (ret < 0) {
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
-		pm_runtime_put_noidle(bdi->dev);
 		return ret;
 	}
 
@@ -1081,11 +1077,9 @@ static int bq24190_charger_get_property(struct power_supply *psy,
 
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
@@ -1155,11 +1149,9 @@ static int bq24190_charger_set_property(struct power_supply *psy,
 
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -1429,11 +1421,9 @@ static int bq24190_battery_get_property(struct power_supply *psy,
 	dev_warn(bdi->dev, "warning: /sys/class/power_supply/bq24190-battery is deprecated\n");
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
@@ -1477,11 +1467,9 @@ static int bq24190_battery_set_property(struct power_supply *psy,
 	dev_warn(bdi->dev, "warning: /sys/class/power_supply/bq24190-battery is deprecated\n");
 	dev_dbg(bdi->dev, "prop: %d\n", psp);
 
-	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bdi->dev);
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
@@ -1635,10 +1623,9 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 	int error;
 
 	bdi->irq_event = true;
-	error = pm_runtime_get_sync(bdi->dev);
+	error = pm_runtime_resume_and_get(bdi->dev);
 	if (error < 0) {
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-		pm_runtime_put_noidle(bdi->dev);
 		return IRQ_NONE;
 	}
 	bq24190_check_status(bdi);
@@ -1858,11 +1845,10 @@ static int bq24190_remove(struct i2c_client *client)
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
 	int error;
 
-	error = pm_runtime_get_sync(bdi->dev);
-	if (error < 0) {
+	cancel_delayed_work_sync(&bdi->input_current_limit_work);
+	error = pm_runtime_resume_and_get(bdi->dev);
+	if (error < 0)
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-		pm_runtime_put_noidle(bdi->dev);
-	}
 
 	bq24190_register_reset(bdi);
 	if (bdi->battery)
@@ -1911,11 +1897,9 @@ static __maybe_unused int bq24190_pm_suspend(struct device *dev)
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
 	int error;
 
-	error = pm_runtime_get_sync(bdi->dev);
-	if (error < 0) {
+	error = pm_runtime_resume_and_get(bdi->dev);
+	if (error < 0)
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-		pm_runtime_put_noidle(bdi->dev);
-	}
 
 	bq24190_register_reset(bdi);
 
@@ -1936,11 +1920,9 @@ static __maybe_unused int bq24190_pm_resume(struct device *dev)
 	bdi->f_reg = 0;
 	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
 
-	error = pm_runtime_get_sync(bdi->dev);
-	if (error < 0) {
+	error = pm_runtime_resume_and_get(bdi->dev);
+	if (error < 0)
 		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
-		pm_runtime_put_noidle(bdi->dev);
-	}
 
 	bq24190_register_reset(bdi);
 	bq24190_set_config(bdi);
diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supply/max14577_charger.c
index 8a59feac6468..90b97736ac2a 100644
--- a/drivers/power/supply/max14577_charger.c
+++ b/drivers/power/supply/max14577_charger.c
@@ -501,7 +501,7 @@ static struct max14577_charger_platform_data *max14577_charger_dt_init(
 static struct max14577_charger_platform_data *max14577_charger_dt_init(
 		struct platform_device *pdev)
 {
-	return NULL;
+	return ERR_PTR(-ENODATA);
 }
 #endif /* CONFIG_OF */
 
@@ -572,7 +572,7 @@ static int max14577_charger_probe(struct platform_device *pdev)
 	chg->max14577 = max14577;
 
 	chg->pdata = max14577_charger_dt_init(pdev);
-	if (IS_ERR_OR_NULL(chg->pdata))
+	if (IS_ERR(chg->pdata))
 		return PTR_ERR(chg->pdata);
 
 	ret = max14577_charger_reg_init(chg);
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 2d008e0d116a..ea966fc67d28 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -41,6 +41,9 @@ static __poll_t pps_cdev_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &pps->queue, wait);
 
+	if (pps->last_fetched_ev == pps->last_ev)
+		return 0;
+
 	return EPOLLIN | EPOLLRDNORM;
 }
 
@@ -186,9 +189,11 @@ static long pps_cdev_ioctl(struct file *file,
 		if (err)
 			return err;
 
-		/* Return the fetched timestamp */
+		/* Return the fetched timestamp and save last fetched event  */
 		spin_lock_irq(&pps->lock);
 
+		pps->last_fetched_ev = pps->last_ev;
+
 		fdata.info.assert_sequence = pps->assert_sequence;
 		fdata.info.clear_sequence = pps->clear_sequence;
 		fdata.info.assert_tu = pps->assert_tu;
@@ -272,9 +277,11 @@ static long pps_cdev_compat_ioctl(struct file *file,
 		if (err)
 			return err;
 
-		/* Return the fetched timestamp */
+		/* Return the fetched timestamp and save last fetched event  */
 		spin_lock_irq(&pps->lock);
 
+		pps->last_fetched_ev = pps->last_ev;
+
 		compat.info.assert_sequence = pps->assert_sequence;
 		compat.info.clear_sequence = pps->clear_sequence;
 		compat.info.current_mode = pps->current_mode;
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 77492bf0551c..f61cb8496c3a 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -204,6 +204,15 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
 		val |= FIELD_PREP(PWM_IMX_TPM_SC_PS, p->prescale);
 		writel(val, tpm->base + PWM_IMX_TPM_SC);
 
+		/*
+		 * if the counter is disabled (CMOD == 0), programming the new
+		 * period length (MOD) will not reset the counter (CNT). If
+		 * CNT.COUNT happens to be bigger than the new MOD value then
+		 * the counter will end up being reset way too late. Therefore,
+		 * manually reset it to 0.
+		 */
+		if (!cmod)
+			writel(0x0, tpm->base + PWM_IMX_TPM_CNT);
 		/*
 		 * set period count:
 		 * if the PWM is disabled (CMOD[1:0] = 2b00), then MOD register
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 3cf766d892db..c2235daa5bcd 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -119,6 +119,26 @@ static inline void pwm_mediatek_writel(struct pwm_mediatek_chip *chip,
 	writel(value, chip->regs + pwm_mediatek_reg_offset[num] + offset);
 }
 
+static void pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
+	u32 value;
+
+	value = readl(pc->regs);
+	value |= BIT(pwm->hwpwm);
+	writel(value, pc->regs);
+}
+
+static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
+	u32 value;
+
+	value = readl(pc->regs);
+	value &= ~BIT(pwm->hwpwm);
+	writel(value, pc->regs);
+}
+
 static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       int duty_ns, int period_ns)
 {
@@ -148,7 +168,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(resolution, clk_rate);
 
 	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
-	while (cnt_period > 8191) {
+	if (!cnt_period)
+		return -EINVAL;
+
+	while (cnt_period > 8192) {
 		resolution *= 2;
 		clkdiv++;
 		cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000,
@@ -171,9 +194,16 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	cnt_duty = DIV_ROUND_CLOSEST_ULL((u64)duty_ns * 1000, resolution);
+
 	pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
-	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
-	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
+	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period - 1);
+
+	if (cnt_duty) {
+		pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty - 1);
+		pwm_mediatek_enable(chip, pwm);
+	} else {
+		pwm_mediatek_disable(chip, pwm);
+	}
 
 out:
 	pwm_mediatek_clk_disable(chip, pwm);
@@ -181,39 +211,35 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
-static int pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
 {
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 value;
-	int ret;
+	int err;
 
-	ret = pwm_mediatek_clk_enable(chip, pwm);
-	if (ret < 0)
-		return ret;
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
 
-	value = readl(pc->regs);
-	value |= BIT(pwm->hwpwm);
-	writel(value, pc->regs);
+	if (!state->enabled) {
+		if (pwm->state.enabled) {
+			pwm_mediatek_disable(chip, pwm);
+			pwm_mediatek_clk_disable(chip, pwm);
+		}
 
-	return 0;
-}
+		return 0;
+	}
 
-static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 value;
+	err = pwm_mediatek_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
 
-	value = readl(pc->regs);
-	value &= ~BIT(pwm->hwpwm);
-	writel(value, pc->regs);
+	if (!pwm->state.enabled)
+		err = pwm_mediatek_clk_enable(chip, pwm);
 
-	pwm_mediatek_clk_disable(chip, pwm);
+	return err;
 }
 
 static const struct pwm_ops pwm_mediatek_ops = {
-	.config = pwm_mediatek_config,
-	.enable = pwm_mediatek_enable,
-	.disable = pwm_mediatek_disable,
+	.apply = pwm_mediatek_apply,
 	.owner = THIS_MODULE,
 };
 
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a01a769b2f2d..e5ce97dc3215 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5062,6 +5062,7 @@ static void regulator_remove_coupling(struct regulator_dev *rdev)
 				 err);
 	}
 
+	rdev->coupling_desc.n_coupled = 0;
 	kfree(rdev->coupling_desc.coupled_rdevs);
 	rdev->coupling_desc.coupled_rdevs = NULL;
 }
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 40532a36ae67..bf79208b8a45 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -252,6 +252,13 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
 		if (tmp & DS1340_BIT_OSF)
 			return -EINVAL;
 		break;
+	case ds_1341:
+		ret = regmap_read(ds1307->regmap, DS1337_REG_STATUS, &tmp);
+		if (ret)
+			return ret;
+		if (tmp & DS1337_BIT_OSF)
+			return -EINVAL;
+		break;
 	case mcp794xx:
 		if (!(tmp & MCP794XX_BIT_ST))
 			return -EINVAL;
@@ -343,6 +350,10 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
 		regmap_update_bits(ds1307->regmap, DS1340_REG_FLAG,
 				   DS1340_BIT_OSF, 0);
 		break;
+	case ds_1341:
+		regmap_update_bits(ds1307->regmap, DS1337_REG_STATUS,
+				   DS1337_BIT_OSF, 0);
+		break;
 	case mcp794xx:
 		/*
 		 * these bits were cleared when preparing the date/time
@@ -1381,7 +1392,7 @@ static long ds3231_clk_sqw_round_rate(struct clk_hw *hw, unsigned long rate,
 			return ds3231_clk_sqw_rates[i];
 	}
 
-	return 0;
+	return ds3231_clk_sqw_rates[ARRAY_SIZE(ds3231_clk_sqw_rates) - 1];
 }
 
 static int ds3231_clk_sqw_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1686,10 +1697,8 @@ static int ds1307_probe(struct i2c_client *client,
 		regmap_write(ds1307->regmap, DS1337_REG_CONTROL,
 			     regs[0]);
 
-		/* oscillator fault?  clear flag, and warn */
+		/* oscillator fault? warn */
 		if (regs[1] & DS1337_BIT_OSF) {
-			regmap_write(ds1307->regmap, DS1337_REG_STATUS,
-				     regs[1] & ~DS1337_BIT_OSF);
 			dev_warn(ds1307->dev, "SET TIME!\n");
 		}
 		break;
diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index fb6d7967ec00..bd625ab70617 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -316,7 +316,7 @@ static long hym8563_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 		if (clkout_rates[i] <= rate)
 			return clkout_rates[i];
 
-	return 0;
+	return clkout_rates[0];
 }
 
 static int hym8563_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 24baa4767b11..9e4fdfe9d86a 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -421,7 +421,7 @@ static long pcf8563_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 		if (clkout_rates[i] <= rate)
 			return clkout_rates[i];
 
-	return 0;
+	return clkout_rates[0];
 }
 
 static int pcf8563_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
index 8849eca08a49..6909affadf6f 100644
--- a/drivers/scsi/aacraid/comminit.c
+++ b/drivers/scsi/aacraid/comminit.c
@@ -482,8 +482,7 @@ void aac_define_int_mode(struct aac_dev *dev)
 	    pci_find_capability(dev->pdev, PCI_CAP_ID_MSIX)) {
 		min_msix = 2;
 		i = pci_alloc_irq_vectors(dev->pdev,
-					  min_msix, msi_count,
-					  PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
+					  min_msix, msi_count, PCI_IRQ_MSIX);
 		if (i > 0) {
 			dev->msi_enabled = 1;
 			msi_count = i;
diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index 22f06be2606f..6dcf1094e01b 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -707,6 +707,7 @@ bfad_im_probe(struct bfad_s *bfad)
 
 	if (bfad_thread_workq(bfad) != BFA_STATUS_OK) {
 		kfree(im);
+		bfad->im = NULL;
 		return BFA_STATUS_FAILED;
 	}
 
diff --git a/drivers/scsi/ibmvscsi_tgt/libsrp.c b/drivers/scsi/ibmvscsi_tgt/libsrp.c
index 8a0e28aec928..0ecad398ed3d 100644
--- a/drivers/scsi/ibmvscsi_tgt/libsrp.c
+++ b/drivers/scsi/ibmvscsi_tgt/libsrp.c
@@ -184,7 +184,8 @@ static int srp_direct_data(struct ibmvscsis_cmd *cmd, struct srp_direct_buf *md,
 	err = rdma_io(cmd, sg, nsg, md, 1, dir, len);
 
 	if (dma_map)
-		dma_unmap_sg(iue->target->dev, sg, nsg, DMA_BIDIRECTIONAL);
+		dma_unmap_sg(iue->target->dev, sg, cmd->se_cmd.t_data_nents,
+			     DMA_BIDIRECTIONAL);
 
 	return err;
 }
@@ -256,7 +257,8 @@ static int srp_indirect_data(struct ibmvscsis_cmd *cmd, struct srp_cmd *srp_cmd,
 	err = rdma_io(cmd, sg, nsg, md, nmd, dir, len);
 
 	if (dma_map)
-		dma_unmap_sg(iue->target->dev, sg, nsg, DMA_BIDIRECTIONAL);
+		dma_unmap_sg(iue->target->dev, sg, cmd->se_cmd.t_data_nents,
+			     DMA_BIDIRECTIONAL);
 
 free_mem:
 	if (token && dma_map) {
diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index 591aebb40a0f..2deeddad10e1 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -2914,7 +2914,7 @@ static void isci_request_io_request_complete(struct isci_host *ihost,
 					 task->total_xfer_len, task->data_dir);
 		else  /* unmap the sgl dma addresses */
 			dma_unmap_sg(&ihost->pdev->dev, task->scatter,
-				     request->num_sg_entries, task->data_dir);
+				     task->num_scatter, task->data_dir);
 		break;
 	case SAS_PROTOCOL_SMP: {
 		struct scatterlist *sg = &task->smp_task.smp_req;
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index f3cee64c6d12..9b94218ff04c 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -2893,7 +2893,8 @@ iscsi_conn_setup(struct iscsi_cls_session *cls_session, int dd_size,
 	conn = cls_conn->dd_data;
 	memset(conn, 0, sizeof(*conn) + dd_size);
 
-	conn->dd_data = cls_conn->dd_data + sizeof(*conn);
+	if (dd_size)
+		conn->dd_data = cls_conn->dd_data + sizeof(*conn);
 	conn->session = session;
 	conn->cls_conn = cls_conn;
 	conn->c_stage = ISCSI_CONN_INITIAL_STAGE;
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 291fccf02d45..f75431a948f3 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -5886,7 +5886,6 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
 			}
 			phba->nvmeio_trc_on = 1;
 			phba->nvmeio_trc_output_idx = 0;
-			phba->nvmeio_trc = NULL;
 		} else {
 nvmeio_off:
 			phba->nvmeio_trc_size = 0;
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index f238e0f41f07..1d58895b3943 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -469,6 +469,10 @@ lpfc_sli4_vport_delete_fcp_xri_aborted(struct lpfc_vport *vport)
 	if (!(vport->cfg_enable_fc4_type & LPFC_ENABLE_FCP))
 		return;
 
+	/* may be called before queues established if hba_setup fails */
+	if (!phba->sli4_hba.hdwq)
+		return;
+
 	spin_lock_irqsave(&phba->hbalock, iflag);
 	for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
 		qp = &phba->sli4_hba.hdwq[idx];
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 4731e464dfb9..3169b37a88b3 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -181,6 +181,14 @@ struct sense_info {
 #define MPT3SAS_PORT_ENABLE_COMPLETE (0xFFFD)
 #define MPT3SAS_ABRT_TASK_SET (0xFFFE)
 #define MPT3SAS_REMOVE_UNRESPONDING_DEVICES (0xFFFF)
+
+/*
+ * SAS Log info code for a NCQ collateral abort after an NCQ error:
+ * IOC_LOGINFO_PREFIX_PL | PL_LOGINFO_CODE_SATA_NCQ_FAIL_ALL_CMDS_AFTR_ERR
+ * See: drivers/message/fusion/lsi/mpi_log_sas.h
+ */
+#define IOC_LOGINFO_SATA_NCQ_FAIL_AFTER_ERR	0x31080000
+
 /**
  * struct fw_event_work - firmware event struct
  * @list: link list framework
@@ -5327,6 +5335,17 @@ _scsih_io_done(struct MPT3SAS_ADAPTER *ioc, u16 smid, u8 msix_index, u32 reply)
 			scmd->result = DID_TRANSPORT_DISRUPTED << 16;
 			goto out;
 		}
+		if (log_info == IOC_LOGINFO_SATA_NCQ_FAIL_AFTER_ERR) {
+			/*
+			 * This is a ATA NCQ command aborted due to another NCQ
+			 * command failure. We must retry this command
+			 * immediately but without incrementing its retry
+			 * counter.
+			 */
+			WARN_ON_ONCE(xfer_cnt != 0);
+			scmd->result = DID_IMM_RETRY << 16;
+			break;
+		}
 		if (log_info == 0x31110630) {
 			if (scmd->retries > 2) {
 				scmd->result = DID_NO_CONNECT << 16;
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 3e0b8ebe257f..68caeaf9e636 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -831,7 +831,7 @@ static int mvs_task_prep(struct sas_task *task, struct mvs_info *mvi, int is_tmf
 	dev_printk(KERN_ERR, mvi->dev, "mvsas prep failed[%d]!\n", rc);
 	if (!sas_protocol_ata(task->task_proto))
 		if (n_elem)
-			dma_unmap_sg(mvi->dev, task->scatter, n_elem,
+			dma_unmap_sg(mvi->dev, task->scatter, task->num_scatter,
 				     task->data_dir);
 prep_out:
 	return rc;
@@ -882,7 +882,7 @@ static void mvs_slot_task_free(struct mvs_info *mvi, struct sas_task *task,
 	if (!sas_protocol_ata(task->task_proto))
 		if (slot->n_elem)
 			dma_unmap_sg(mvi->dev, task->scatter,
-				     slot->n_elem, task->data_dir);
+				     task->num_scatter, task->data_dir);
 
 	switch (task->task_proto) {
 	case SAS_PROTOCOL_SMP:
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index af1c45dd2f38..4957e50b7b5d 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -6593,6 +6593,8 @@ static struct iscsi_endpoint *qla4xxx_get_ep_fwdb(struct scsi_qla_host *ha,
 
 	ep = qla4xxx_ep_connect(ha->host, (struct sockaddr *)dst_addr, 0);
 	vfree(dst_addr);
+	if (IS_ERR(ep))
+		return NULL;
 	return ep;
 }
 
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index d236322ced30..175cc535fc96 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1686,7 +1686,7 @@ int scsi_scan_host_selected(struct Scsi_Host *shost, unsigned int channel,
 
 	return 0;
 }
-
+EXPORT_SYMBOL(scsi_scan_host_selected);
 static void scsi_sysfs_add_devices(struct Scsi_Host *shost)
 {
 	struct scsi_device *sdev;
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index 182fd25c7c43..0da3f7f1d03e 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -41,6 +41,8 @@
 #include <scsi/scsi_transport_sas.h>
 
 #include "scsi_sas_internal.h"
+#include "scsi_priv.h"
+
 struct sas_host_attrs {
 	struct list_head rphy_list;
 	struct mutex lock;
@@ -1648,32 +1650,66 @@ int scsi_is_sas_rphy(const struct device *dev)
 }
 EXPORT_SYMBOL(scsi_is_sas_rphy);
 
-
-/*
- * SCSI scan helper
- */
-
-static int sas_user_scan(struct Scsi_Host *shost, uint channel,
-		uint id, u64 lun)
+static void scan_channel_zero(struct Scsi_Host *shost, uint id, u64 lun)
 {
 	struct sas_host_attrs *sas_host = to_sas_host_attrs(shost);
 	struct sas_rphy *rphy;
 
-	mutex_lock(&sas_host->lock);
 	list_for_each_entry(rphy, &sas_host->rphy_list, list) {
 		if (rphy->identify.device_type != SAS_END_DEVICE ||
 		    rphy->scsi_target_id == -1)
 			continue;
 
-		if ((channel == SCAN_WILD_CARD || channel == 0) &&
-		    (id == SCAN_WILD_CARD || id == rphy->scsi_target_id)) {
+		if (id == SCAN_WILD_CARD || id == rphy->scsi_target_id) {
 			scsi_scan_target(&rphy->dev, 0, rphy->scsi_target_id,
 					 lun, SCSI_SCAN_MANUAL);
 		}
 	}
-	mutex_unlock(&sas_host->lock);
+}
 
-	return 0;
+/*
+ * SCSI scan helper
+ */
+
+static int sas_user_scan(struct Scsi_Host *shost, uint channel,
+		uint id, u64 lun)
+{
+	struct sas_host_attrs *sas_host = to_sas_host_attrs(shost);
+	int res = 0;
+	int i;
+
+	switch (channel) {
+	case 0:
+		mutex_lock(&sas_host->lock);
+		scan_channel_zero(shost, id, lun);
+		mutex_unlock(&sas_host->lock);
+		break;
+
+	case SCAN_WILD_CARD:
+		mutex_lock(&sas_host->lock);
+		scan_channel_zero(shost, id, lun);
+		mutex_unlock(&sas_host->lock);
+
+		for (i = 1; i <= shost->max_channel; i++) {
+			res = scsi_scan_host_selected(shost, i, id, lun,
+						      SCSI_SCAN_MANUAL);
+			if (res)
+				goto exit_scan;
+		}
+		break;
+
+	default:
+		if (channel < shost->max_channel) {
+			res = scsi_scan_host_selected(shost, channel, id, lun,
+						      SCSI_SCAN_MANUAL);
+		} else {
+			res = -EINVAL;
+		}
+		break;
+	}
+
+exit_scan:
+	return res;
 }
 
 
diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 43e30937fc9d..f3462ce22a0b 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -60,6 +60,7 @@ struct aspeed_lpc_snoop_model_data {
 };
 
 struct aspeed_lpc_snoop_channel {
+	bool enabled;
 	struct kfifo		fifo;
 	wait_queue_head_t	wq;
 	struct miscdevice	miscdev;
@@ -192,6 +193,9 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	const struct aspeed_lpc_snoop_model_data *model_data =
 		of_device_get_match_data(dev);
 
+	if (WARN_ON(lpc_snoop->chan[channel].enabled))
+		return -EBUSY;
+
 	init_waitqueue_head(&lpc_snoop->chan[channel].wq);
 	/* Create FIFO datastructure */
 	rc = kfifo_alloc(&lpc_snoop->chan[channel].fifo,
@@ -238,6 +242,8 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		regmap_update_bits(lpc_snoop->regmap, HICRB,
 				hicrb_en, hicrb_en);
 
+	lpc_snoop->chan[channel].enabled = true;
+
 	return 0;
 
 err_misc_deregister:
@@ -250,6 +256,9 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 				     int channel)
 {
+	if (!lpc_snoop->chan[channel].enabled)
+		return;
+
 	switch (channel) {
 	case 0:
 		regmap_update_bits(lpc_snoop->regmap, HICR5,
@@ -265,8 +274,10 @@ static void aspeed_lpc_disable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		return;
 	}
 
-	kfifo_free(&lpc_snoop->chan[channel].fifo);
+	lpc_snoop->chan[channel].enabled = false;
+	/* Consider improving safety wrt concurrent reader(s) */
 	misc_deregister(&lpc_snoop->chan[channel].miscdev);
+	kfifo_free(&lpc_snoop->chan[channel].fifo);
 }
 
 static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 6034cd8992b0..c2bbde533e66 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -12,11 +12,43 @@
 #include <linux/firmware.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/qcom_scm.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/mdt_loader.h>
 
+static bool mdt_header_valid(const struct firmware *fw)
+{
+	const struct elf32_hdr *ehdr;
+	size_t phend;
+	size_t shend;
+
+	if (fw->size < sizeof(*ehdr))
+		return false;
+
+	ehdr = (struct elf32_hdr *)fw->data;
+
+	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG))
+		return false;
+
+	if (ehdr->e_phentsize != sizeof(struct elf32_phdr))
+		return false;
+
+	phend = size_add(size_mul(sizeof(struct elf32_phdr), ehdr->e_phnum), ehdr->e_phoff);
+	if (phend > fw->size)
+		return false;
+
+	if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
+		return false;
+
+	shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
+	if (shend > fw->size)
+		return false;
+
+	return true;
+}
+
 static bool mdt_phdr_valid(const struct elf32_phdr *phdr)
 {
 	if (phdr->p_type != PT_LOAD)
@@ -46,6 +78,9 @@ ssize_t qcom_mdt_get_size(const struct firmware *fw)
 	phys_addr_t max_addr = 0;
 	int i;
 
+	if (!mdt_header_valid(fw))
+		return -EINVAL;
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -92,6 +127,9 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len)
 	size_t ehdr_size;
 	void *data;
 
+	if (!mdt_header_valid(fw))
+		return ERR_PTR(-EINVAL);
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -151,6 +189,9 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	if (!fw || !mem_region || !mem_phys || !mem_size)
 		return -EINVAL;
 
+	if (!mdt_header_valid(fw))
+		return -EINVAL;
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index d11320a4dfcf..8023ebac671b 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -950,7 +950,7 @@ static int tegra_powergate_of_get_clks(struct tegra_powergate *pg,
 }
 
 static int tegra_powergate_of_get_resets(struct tegra_powergate *pg,
-					 struct device_node *np, bool off)
+					 struct device_node *np)
 {
 	struct device *dev = pg->pmc->dev;
 	int err;
@@ -965,22 +965,6 @@ static int tegra_powergate_of_get_resets(struct tegra_powergate *pg,
 	err = reset_control_acquire(pg->reset);
 	if (err < 0) {
 		pr_err("failed to acquire resets: %d\n", err);
-		goto out;
-	}
-
-	if (off) {
-		err = reset_control_assert(pg->reset);
-	} else {
-		err = reset_control_deassert(pg->reset);
-		if (err < 0)
-			goto out;
-
-		reset_control_release(pg->reset);
-	}
-
-out:
-	if (err) {
-		reset_control_release(pg->reset);
 		reset_control_put(pg->reset);
 	}
 
@@ -1025,20 +1009,43 @@ static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 		goto set_available;
 	}
 
-	err = tegra_powergate_of_get_resets(pg, np, off);
+	err = tegra_powergate_of_get_resets(pg, np);
 	if (err < 0) {
 		dev_err(dev, "failed to get resets for %pOFn: %d\n", np, err);
 		goto remove_clks;
 	}
 
-	if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
-		if (off)
-			WARN_ON(tegra_powergate_power_up(pg, true));
+	/*
+	 * If the power-domain is off, then ensure the resets are asserted.
+	 * If the power-domain is on, then power down to ensure that when is
+	 * it turned on the power-domain, clocks and resets are all in the
+	 * expected state.
+	 */
+	if (off) {
+		err = reset_control_assert(pg->reset);
+		if (err) {
+			pr_err("failed to assert resets: %d\n", err);
+			goto remove_resets;
+		}
+	} else {
+		err = tegra_powergate_power_down(pg);
+		if (err) {
+			dev_err(dev, "failed to turn off PM domain %s: %d\n",
+				pg->genpd.name, err);
+			goto remove_resets;
+		}
+	}
 
+	/*
+	 * If PM_GENERIC_DOMAINS is not enabled, power-on
+	 * the domain and skip the genpd registration.
+	 */
+	if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
+		WARN_ON(tegra_powergate_power_up(pg, true));
 		goto remove_resets;
 	}
 
-	err = pm_genpd_init(&pg->genpd, NULL, off);
+	err = pm_genpd_init(&pg->genpd, NULL, true);
 	if (err < 0) {
 		dev_err(dev, "failed to initialise PM domain %pOFn: %d\n", np,
 		       err);
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 3b3f909407c3..6e4c7bf9eb0d 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1532,7 +1532,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
 		if (ret < 0) {
 			dev_err(bus->dev, "Prepare port(s) failed ret = %d\n",
 				ret);
-			return ret;
+			goto restore_params;
 		}
 	}
 
diff --git a/drivers/staging/comedi/comedi_compat32.c b/drivers/staging/comedi/comedi_compat32.c
index 36a3564ba1fb..2f444e2b92c2 100644
--- a/drivers/staging/comedi/comedi_compat32.c
+++ b/drivers/staging/comedi/comedi_compat32.c
@@ -360,6 +360,9 @@ static int compat_insnlist(struct file *file, unsigned long arg)
 	if (err)
 		return -EFAULT;
 
+	if (n_insns > 65536)	/* See MAX_INSNS in comedi_fops.c */
+		return -EINVAL;
+
 	/* Allocate user memory to copy insnlist and insns into. */
 	s = compat_alloc_user_space(offsetof(struct combined_insnlist,
 					     insn[n_insns]));
diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index 8b2337f8303d..219a36216e50 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -781,6 +781,7 @@ static int is_device_busy(struct comedi_device *dev)
 	struct comedi_subdevice *s;
 	int i;
 
+	lockdep_assert_held_write(&dev->attach_lock);
 	lockdep_assert_held(&dev->mutex);
 	if (!dev->attached)
 		return 0;
@@ -789,7 +790,16 @@ static int is_device_busy(struct comedi_device *dev)
 		s = &dev->subdevices[i];
 		if (s->busy)
 			return 1;
-		if (s->async && comedi_buf_is_mmapped(s))
+		if (!s->async)
+			continue;
+		if (comedi_buf_is_mmapped(s))
+			return 1;
+		/*
+		 * There may be tasks still waiting on the subdevice's wait
+		 * queue, although they should already be about to be removed
+		 * from it since the subdevice has no active async command.
+		 */
+		if (wq_has_sleeper(&s->async->wait_head))
 			return 1;
 	}
 
@@ -819,15 +829,22 @@ static int do_devconfig_ioctl(struct comedi_device *dev,
 		return -EPERM;
 
 	if (!arg) {
-		if (is_device_busy(dev))
-			return -EBUSY;
+		int rc = 0;
+
 		if (dev->attached) {
-			struct module *driver_module = dev->driver->module;
+			down_write(&dev->attach_lock);
+			if (is_device_busy(dev)) {
+				rc = -EBUSY;
+			} else {
+				struct module *driver_module =
+					dev->driver->module;
 
-			comedi_device_detach(dev);
-			module_put(driver_module);
+				comedi_device_detach_locked(dev);
+				module_put(driver_module);
+			}
+			up_write(&dev->attach_lock);
 		}
-		return 0;
+		return rc;
 	}
 
 	if (copy_from_user(&it, arg, sizeof(it)))
@@ -1502,6 +1519,16 @@ static int parse_insn(struct comedi_device *dev, struct comedi_insn *insn,
 	return ret;
 }
 
+#define MAX_INSNS   65536
+static int check_insnlist_len(struct comedi_device *dev, unsigned int n_insns)
+{
+	if (n_insns > MAX_INSNS) {
+		dev_dbg(dev->class_dev, "insnlist length too large\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 /*
  * COMEDI_INSNLIST ioctl
  * synchronous instruction list
@@ -1534,6 +1561,9 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
 	if (copy_from_user(&insnlist, arg, sizeof(insnlist)))
 		return -EFAULT;
 
+	ret = check_insnlist_len(dev, insnlist.n_insns);
+	if (ret)
+		return ret;
 	insns = kcalloc(insnlist.n_insns, sizeof(*insns), GFP_KERNEL);
 	if (!insns) {
 		ret = -ENOMEM;
@@ -1567,21 +1597,27 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
 	}
 
 	for (i = 0; i < insnlist.n_insns; ++i) {
+		unsigned int n = insns[i].n;
+
 		if (insns[i].insn & INSN_MASK_WRITE) {
 			if (copy_from_user(data, insns[i].data,
-					   insns[i].n * sizeof(unsigned int))) {
+					   n * sizeof(unsigned int))) {
 				dev_dbg(dev->class_dev,
 					"copy_from_user failed\n");
 				ret = -EFAULT;
 				goto error;
 			}
+			if (n < MIN_SAMPLES) {
+				memset(&data[n], 0, (MIN_SAMPLES - n) *
+						    sizeof(unsigned int));
+			}
 		}
 		ret = parse_insn(dev, insns + i, data, file);
 		if (ret < 0)
 			goto error;
 		if (insns[i].insn & INSN_MASK_READ) {
 			if (copy_to_user(insns[i].data, data,
-					 insns[i].n * sizeof(unsigned int))) {
+					 n * sizeof(unsigned int))) {
 				dev_dbg(dev->class_dev,
 					"copy_to_user failed\n");
 				ret = -EFAULT;
@@ -1648,6 +1684,10 @@ static int do_insn_ioctl(struct comedi_device *dev,
 			ret = -EFAULT;
 			goto error;
 		}
+		if (insn.n < MIN_SAMPLES) {
+			memset(&data[insn.n], 0,
+			       (MIN_SAMPLES - insn.n) * sizeof(unsigned int));
+		}
 	}
 	ret = parse_insn(dev, &insn, data, file);
 	if (ret < 0)
diff --git a/drivers/staging/comedi/comedi_internal.h b/drivers/staging/comedi/comedi_internal.h
index 515f293a5d26..43599c1b97b7 100644
--- a/drivers/staging/comedi/comedi_internal.h
+++ b/drivers/staging/comedi/comedi_internal.h
@@ -50,6 +50,7 @@ extern struct mutex comedi_drivers_list_lock;
 int insn_inval(struct comedi_device *dev, struct comedi_subdevice *s,
 	       struct comedi_insn *insn, unsigned int *data);
 
+void comedi_device_detach_locked(struct comedi_device *dev);
 void comedi_device_detach(struct comedi_device *dev);
 int comedi_device_attach(struct comedi_device *dev,
 			 struct comedi_devconfig *it);
diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/drivers.c
index 750a6ff3c03c..fd098e62a308 100644
--- a/drivers/staging/comedi/drivers.c
+++ b/drivers/staging/comedi/drivers.c
@@ -159,7 +159,7 @@ static void comedi_device_detach_cleanup(struct comedi_device *dev)
 	int i;
 	struct comedi_subdevice *s;
 
-	lockdep_assert_held(&dev->attach_lock);
+	lockdep_assert_held_write(&dev->attach_lock);
 	lockdep_assert_held(&dev->mutex);
 	if (dev->subdevices) {
 		for (i = 0; i < dev->n_subdevices; i++) {
@@ -196,16 +196,23 @@ static void comedi_device_detach_cleanup(struct comedi_device *dev)
 	comedi_clear_hw_dev(dev);
 }
 
-void comedi_device_detach(struct comedi_device *dev)
+void comedi_device_detach_locked(struct comedi_device *dev)
 {
+	lockdep_assert_held_write(&dev->attach_lock);
 	lockdep_assert_held(&dev->mutex);
 	comedi_device_cancel_all(dev);
-	down_write(&dev->attach_lock);
 	dev->attached = false;
 	dev->detach_count++;
 	if (dev->driver)
 		dev->driver->detach(dev);
 	comedi_device_detach_cleanup(dev);
+}
+
+void comedi_device_detach(struct comedi_device *dev)
+{
+	lockdep_assert_held(&dev->mutex);
+	down_write(&dev->attach_lock);
+	comedi_device_detach_locked(dev);
 	up_write(&dev->attach_lock);
 }
 
@@ -339,10 +346,10 @@ int comedi_dio_insn_config(struct comedi_device *dev,
 			   unsigned int *data,
 			   unsigned int mask)
 {
-	unsigned int chan_mask = 1 << CR_CHAN(insn->chanspec);
+	unsigned int chan = CR_CHAN(insn->chanspec);
 
-	if (!mask)
-		mask = chan_mask;
+	if (!mask && chan < 32)
+		mask = 1U << chan;
 
 	switch (data[0]) {
 	case INSN_CONFIG_DIO_INPUT:
@@ -382,7 +389,7 @@ EXPORT_SYMBOL_GPL(comedi_dio_insn_config);
 unsigned int comedi_dio_update_state(struct comedi_subdevice *s,
 				     unsigned int *data)
 {
-	unsigned int chanmask = (s->n_chan < 32) ? ((1 << s->n_chan) - 1)
+	unsigned int chanmask = (s->n_chan < 32) ? ((1U << s->n_chan) - 1)
 						 : 0xffffffff;
 	unsigned int mask = data[0] & chanmask;
 	unsigned int bits = data[1];
@@ -615,6 +622,9 @@ static int insn_rw_emulate_bits(struct comedi_device *dev,
 	unsigned int _data[2];
 	int ret;
 
+	if (insn->n == 0)
+		return 0;
+
 	memset(_data, 0, sizeof(_data));
 	memset(&_insn, 0, sizeof(_insn));
 	_insn.insn = INSN_BITS;
@@ -625,8 +635,8 @@ static int insn_rw_emulate_bits(struct comedi_device *dev,
 	if (insn->insn == INSN_WRITE) {
 		if (!(s->subdev_flags & SDF_WRITABLE))
 			return -EINVAL;
-		_data[0] = 1 << (chan - base_chan);		    /* mask */
-		_data[1] = data[0] ? (1 << (chan - base_chan)) : 0; /* bits */
+		_data[0] = 1U << (chan - base_chan);		     /* mask */
+		_data[1] = data[0] ? (1U << (chan - base_chan)) : 0; /* bits */
 	}
 
 	ret = s->insn_bits(dev, s, &_insn, _data);
@@ -709,7 +719,7 @@ static int __comedi_device_postconfig(struct comedi_device *dev)
 
 		if (s->type == COMEDI_SUBD_DO) {
 			if (s->n_chan < 32)
-				s->io_bits = (1 << s->n_chan) - 1;
+				s->io_bits = (1U << s->n_chan) - 1;
 			else
 				s->io_bits = 0xffffffff;
 		}
diff --git a/drivers/staging/comedi/drivers/aio_iiro_16.c b/drivers/staging/comedi/drivers/aio_iiro_16.c
index 41c9c56816ef..68be0ab0b80b 100644
--- a/drivers/staging/comedi/drivers/aio_iiro_16.c
+++ b/drivers/staging/comedi/drivers/aio_iiro_16.c
@@ -178,7 +178,8 @@ static int aio_iiro_16_attach(struct comedi_device *dev,
 	 * Digital input change of state interrupts are optionally supported
 	 * using IRQ 2-7, 10-12, 14, or 15.
 	 */
-	if ((1 << it->options[1]) & 0xdcfc) {
+	if (it->options[1] > 0 && it->options[1] < 16 &&
+	    (1 << it->options[1]) & 0xdcfc) {
 		ret = request_irq(it->options[1], aio_iiro_16_cos, 0,
 				  dev->board_name, dev);
 		if (ret == 0)
diff --git a/drivers/staging/comedi/drivers/comedi_test.c b/drivers/staging/comedi/drivers/comedi_test.c
index 9e60d2a0edc1..7397495de4d6 100644
--- a/drivers/staging/comedi/drivers/comedi_test.c
+++ b/drivers/staging/comedi/drivers/comedi_test.c
@@ -790,7 +790,7 @@ static void waveform_detach(struct comedi_device *dev)
 {
 	struct waveform_private *devpriv = dev->private;
 
-	if (devpriv) {
+	if (devpriv && dev->n_subdevices) {
 		del_timer_sync(&devpriv->ai_timer);
 		del_timer_sync(&devpriv->ao_timer);
 	}
diff --git a/drivers/staging/comedi/drivers/das16m1.c b/drivers/staging/comedi/drivers/das16m1.c
index 4e36377b592a..16e4c1637d0b 100644
--- a/drivers/staging/comedi/drivers/das16m1.c
+++ b/drivers/staging/comedi/drivers/das16m1.c
@@ -523,7 +523,8 @@ static int das16m1_attach(struct comedi_device *dev,
 	devpriv->extra_iobase = dev->iobase + DAS16M1_8255_IOBASE;
 
 	/* only irqs 2, 3, 4, 5, 6, 7, 10, 11, 12, 14, and 15 are valid */
-	if ((1 << it->options[1]) & 0xdcfc) {
+	if (it->options[1] >= 2 && it->options[1] <= 15 &&
+	    (1 << it->options[1]) & 0xdcfc) {
 		ret = request_irq(it->options[1], das16m1_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0)
diff --git a/drivers/staging/comedi/drivers/das6402.c b/drivers/staging/comedi/drivers/das6402.c
index 0034005bdf8f..0cd5d1b1ffde 100644
--- a/drivers/staging/comedi/drivers/das6402.c
+++ b/drivers/staging/comedi/drivers/das6402.c
@@ -569,7 +569,8 @@ static int das6402_attach(struct comedi_device *dev,
 	das6402_reset(dev);
 
 	/* IRQs 2,3,5,6,7, 10,11,15 are valid for "enhanced" mode */
-	if ((1 << it->options[1]) & 0x8cec) {
+	if (it->options[1] > 0 && it->options[1] < 16 &&
+	    (1 << it->options[1]) & 0x8cec) {
 		ret = request_irq(it->options[1], das6402_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0) {
diff --git a/drivers/staging/comedi/drivers/pcl812.c b/drivers/staging/comedi/drivers/pcl812.c
index aefc1b849cf7..98112c79e2d7 100644
--- a/drivers/staging/comedi/drivers/pcl812.c
+++ b/drivers/staging/comedi/drivers/pcl812.c
@@ -1151,7 +1151,8 @@ static int pcl812_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 		if (!dev->pacer)
 			return -ENOMEM;
 
-		if ((1 << it->options[1]) & board->irq_bits) {
+		if (it->options[1] > 0 && it->options[1] < 16 &&
+		    (1 << it->options[1]) & board->irq_bits) {
 			ret = request_irq(it->options[1], pcl812_interrupt, 0,
 					  dev->board_name, dev);
 			if (ret == 0)
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 771697508cec..a524cacd89cd 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -752,6 +752,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	return info;
 
 release_framebuf:
+	fb_deferred_io_cleanup(info);
 	framebuffer_release(info);
 
 alloc_fail:
diff --git a/drivers/staging/media/imx/imx-media-csc-scaler.c b/drivers/staging/media/imx/imx-media-csc-scaler.c
index 135e1e64c244..dacab4e077b4 100644
--- a/drivers/staging/media/imx/imx-media-csc-scaler.c
+++ b/drivers/staging/media/imx/imx-media-csc-scaler.c
@@ -911,7 +911,7 @@ imx_media_csc_scaler_device_init(struct imx_media_dev *md)
 	return &priv->vdev;
 
 err_m2m:
-	video_set_drvdata(vfd, NULL);
+	video_device_release(vfd);
 err_vfd:
 	kfree(priv);
 	return ERR_PTR(ret);
diff --git a/drivers/staging/nvec/nvec_power.c b/drivers/staging/nvec/nvec_power.c
index 0e861c4bfcbf..590b801c5992 100644
--- a/drivers/staging/nvec/nvec_power.c
+++ b/drivers/staging/nvec/nvec_power.c
@@ -194,7 +194,7 @@ static int nvec_power_bat_notifier(struct notifier_block *nb,
 		break;
 	case MANUFACTURER:
 		memcpy(power->bat_manu, &res->plc, res->length - 2);
-		power->bat_model[res->length - 2] = '\0';
+		power->bat_manu[res->length - 2] = '\0';
 		break;
 	case MODEL:
 		memcpy(power->bat_model, &res->plc, res->length - 2);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 17b2361bc8f2..fc768b61f483 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -39,10 +39,13 @@ temp_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 	ret = thermal_zone_get_temp(tz, &temperature);
 
-	if (ret)
-		return ret;
+	if (!ret)
+		return sprintf(buf, "%d\n", temperature);
 
-	return sprintf(buf, "%d\n", temperature);
+	if (ret == -EAGAIN)
+		return -ENODATA;
+
+	return ret;
 }
 
 static ssize_t
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index b7980c856898..43d0e50cd5bf 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -38,7 +38,7 @@ static bool match_service_id(const struct tb_service_id *id,
 			return false;
 	}
 
-	if (id->match_flags & TBSVC_MATCH_PROTOCOL_VERSION) {
+	if (id->match_flags & TBSVC_MATCH_PROTOCOL_REVISION) {
 		if (id->protocol_revision != svc->prtcrevs)
 			return false;
 	}
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 6b3ff20a0656..010c6be83ae1 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2296,9 +2296,8 @@ int serial8250_do_startup(struct uart_port *port)
 	/*
 	 * Now, initialize the UART
 	 */
-	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
-
 	spin_lock_irqsave(&port->lock, flags);
+	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 	if (up->port.flags & UPF_FOURPORT) {
 		if (!up->port.irq)
 			up->port.mctrl |= TIOCM_OUT1;
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 317067184bfa..15e6c56258b4 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1025,7 +1025,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 			__func__);
 		return 0;
 	}
-	dma_sync_sg_for_device(port->dev, priv->sg_tx_p, nent, DMA_TO_DEVICE);
+	dma_sync_sg_for_device(port->dev, priv->sg_tx_p, num, DMA_TO_DEVICE);
 	priv->desc_tx = desc;
 	desc->callback = pch_dma_tx_complete;
 	desc->callback_param = priv;
diff --git a/drivers/tty/vt/defkeymap.c_shipped b/drivers/tty/vt/defkeymap.c_shipped
index c7095fb7d2d1..14e742b0d1c2 100644
--- a/drivers/tty/vt/defkeymap.c_shipped
+++ b/drivers/tty/vt/defkeymap.c_shipped
@@ -23,6 +23,22 @@ u_short plain_map[NR_KEYS] = {
 	0xf118,	0xf601,	0xf602,	0xf117,	0xf600,	0xf119,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 u_short shift_map[NR_KEYS] = {
@@ -42,6 +58,22 @@ u_short shift_map[NR_KEYS] = {
 	0xf20b,	0xf601,	0xf602,	0xf117,	0xf600,	0xf20a,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 u_short altgr_map[NR_KEYS] = {
@@ -61,6 +93,22 @@ u_short altgr_map[NR_KEYS] = {
 	0xf118,	0xf601,	0xf602,	0xf117,	0xf600,	0xf119,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 u_short ctrl_map[NR_KEYS] = {
@@ -80,6 +128,22 @@ u_short ctrl_map[NR_KEYS] = {
 	0xf118,	0xf601,	0xf602,	0xf117,	0xf600,	0xf119,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 u_short shift_ctrl_map[NR_KEYS] = {
@@ -99,6 +163,22 @@ u_short shift_ctrl_map[NR_KEYS] = {
 	0xf118,	0xf601,	0xf602,	0xf117,	0xf600,	0xf119,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 u_short alt_map[NR_KEYS] = {
@@ -118,6 +198,22 @@ u_short alt_map[NR_KEYS] = {
 	0xf118,	0xf210,	0xf211,	0xf117,	0xf600,	0xf119,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 u_short ctrl_alt_map[NR_KEYS] = {
@@ -137,6 +233,22 @@ u_short ctrl_alt_map[NR_KEYS] = {
 	0xf118,	0xf601,	0xf602,	0xf117,	0xf600,	0xf119,	0xf115,	0xf20c,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 ushort *key_maps[MAX_NR_KEYMAPS] = {
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 0da9e0ab045b..91abd5c11659 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1460,7 +1460,7 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 		rc = atomic_notifier_call_chain(&keyboard_notifier_list,
 						KBD_UNICODE, &param);
 		if (rc != NOTIFY_STOP)
-			if (down && !raw_mode)
+			if (down && !(raw_mode || kbd->kbdmode == VC_OFF))
 				k_unicode(vc, keysym, !down);
 		return;
 	}
diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index a4d863f6cda7..58e5bc574e6a 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -984,25 +984,60 @@ static int cxacru_fw(struct usb_device *usb_dev, enum cxacru_fw_request fw,
 	return ret;
 }
 
-static void cxacru_upload_firmware(struct cxacru_data *instance,
-				   const struct firmware *fw,
-				   const struct firmware *bp)
+
+static int cxacru_find_firmware(struct cxacru_data *instance,
+				char *phase, const struct firmware **fw_p)
 {
-	int ret;
+	struct usbatm_data *usbatm = instance->usbatm;
+	struct device *dev = &usbatm->usb_intf->dev;
+	char buf[16];
+
+	sprintf(buf, "cxacru-%s.bin", phase);
+	usb_dbg(usbatm, "cxacru_find_firmware: looking for %s\n", buf);
+
+	if (request_firmware(fw_p, buf, dev)) {
+		usb_dbg(usbatm, "no stage %s firmware found\n", phase);
+		return -ENOENT;
+	}
+
+	usb_info(usbatm, "found firmware %s\n", buf);
+
+	return 0;
+}
+
+static int cxacru_heavy_init(struct usbatm_data *usbatm_instance,
+			     struct usb_interface *usb_intf)
+{
+	const struct firmware *fw, *bp;
+	struct cxacru_data *instance = usbatm_instance->driver_data;
 	struct usbatm_data *usbatm = instance->usbatm;
 	struct usb_device *usb_dev = usbatm->usb_dev;
 	__le16 signature[] = { usb_dev->descriptor.idVendor,
 			       usb_dev->descriptor.idProduct };
 	__le32 val;
+	int ret;
 
-	usb_dbg(usbatm, "%s\n", __func__);
+	ret = cxacru_find_firmware(instance, "fw", &fw);
+	if (ret) {
+		usb_warn(usbatm_instance, "firmware (cxacru-fw.bin) unavailable (system misconfigured?)\n");
+		return ret;
+	}
+
+	if (instance->modem_type->boot_rom_patch) {
+		ret = cxacru_find_firmware(instance, "bp", &bp);
+		if (ret) {
+			usb_warn(usbatm_instance, "boot ROM patch (cxacru-bp.bin) unavailable (system misconfigured?)\n");
+			release_firmware(fw);
+			return ret;
+		}
+	}
 
 	/* FirmwarePllFClkValue */
 	val = cpu_to_le32(instance->modem_type->pll_f_clk);
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, PLLFCLK_ADDR, (u8 *) &val, 4);
 	if (ret) {
 		usb_err(usbatm, "FirmwarePllFClkValue failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* FirmwarePllBClkValue */
@@ -1010,7 +1045,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, PLLBCLK_ADDR, (u8 *) &val, 4);
 	if (ret) {
 		usb_err(usbatm, "FirmwarePllBClkValue failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* Enable SDRAM */
@@ -1018,7 +1053,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, SDRAMEN_ADDR, (u8 *) &val, 4);
 	if (ret) {
 		usb_err(usbatm, "Enable SDRAM failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* Firmware */
@@ -1026,7 +1061,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, FW_ADDR, fw->data, fw->size);
 	if (ret) {
 		usb_err(usbatm, "Firmware upload failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* Boot ROM patch */
@@ -1035,7 +1070,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 		ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, BR_ADDR, bp->data, bp->size);
 		if (ret) {
 			usb_err(usbatm, "Boot ROM patching failed: %d\n", ret);
-			return;
+			goto done;
 		}
 	}
 
@@ -1043,7 +1078,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, SIG_ADDR, (u8 *) signature, 4);
 	if (ret) {
 		usb_err(usbatm, "Signature storing failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	usb_info(usbatm, "starting device\n");
@@ -1055,7 +1090,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	}
 	if (ret) {
 		usb_err(usbatm, "Passing control to firmware failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* Delay to allow firmware to start up. */
@@ -1069,53 +1104,10 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	ret = cxacru_cm(instance, CM_REQUEST_CARD_GET_STATUS, NULL, 0, NULL, 0);
 	if (ret < 0) {
 		usb_err(usbatm, "modem failed to initialize: %d\n", ret);
-		return;
-	}
-}
-
-static int cxacru_find_firmware(struct cxacru_data *instance,
-				char *phase, const struct firmware **fw_p)
-{
-	struct usbatm_data *usbatm = instance->usbatm;
-	struct device *dev = &usbatm->usb_intf->dev;
-	char buf[16];
-
-	sprintf(buf, "cxacru-%s.bin", phase);
-	usb_dbg(usbatm, "cxacru_find_firmware: looking for %s\n", buf);
-
-	if (request_firmware(fw_p, buf, dev)) {
-		usb_dbg(usbatm, "no stage %s firmware found\n", phase);
-		return -ENOENT;
-	}
-
-	usb_info(usbatm, "found firmware %s\n", buf);
-
-	return 0;
-}
-
-static int cxacru_heavy_init(struct usbatm_data *usbatm_instance,
-			     struct usb_interface *usb_intf)
-{
-	const struct firmware *fw, *bp;
-	struct cxacru_data *instance = usbatm_instance->driver_data;
-	int ret = cxacru_find_firmware(instance, "fw", &fw);
-
-	if (ret) {
-		usb_warn(usbatm_instance, "firmware (cxacru-fw.bin) unavailable (system misconfigured?)\n");
-		return ret;
+		goto done;
 	}
 
-	if (instance->modem_type->boot_rom_patch) {
-		ret = cxacru_find_firmware(instance, "bp", &bp);
-		if (ret) {
-			usb_warn(usbatm_instance, "boot ROM patch (cxacru-bp.bin) unavailable (system misconfigured?)\n");
-			release_firmware(fw);
-			return ret;
-		}
-	}
-
-	cxacru_upload_firmware(instance, fw, bp);
-
+done:
 	if (instance->modem_type->boot_rom_patch)
 		release_firmware(bp);
 	release_firmware(fw);
diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index ff61f88fc867..3a22bc727bb9 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -277,8 +277,19 @@ static inline int ci_role_start(struct ci_hdrc *ci, enum ci_role role)
 		return -ENXIO;
 
 	ret = ci->roles[role]->start(ci);
-	if (!ret)
-		ci->role = role;
+	if (ret)
+		return ret;
+
+	ci->role = role;
+
+	if (ci->usb_phy) {
+		if (role == CI_ROLE_HOST)
+			usb_phy_set_event(ci->usb_phy, USB_EVENT_ID);
+		else
+			/* in device mode but vbus is invalid*/
+			usb_phy_set_event(ci->usb_phy, USB_EVENT_NONE);
+	}
+
 	return ret;
 }
 
@@ -292,6 +303,9 @@ static inline void ci_role_stop(struct ci_hdrc *ci)
 	ci->role = CI_ROLE_END;
 
 	ci->roles[role]->stop(ci);
+
+	if (ci->usb_phy)
+		usb_phy_set_event(ci->usb_phy, USB_EVENT_NONE);
 }
 
 static inline enum usb_role ci_role_to_usb_role(struct ci_hdrc *ci)
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index a6ce6b89b271..d483a957804b 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -1533,44 +1533,68 @@ static const struct usb_ep_ops usb_ep_ops = {
 /******************************************************************************
  * GADGET block
  *****************************************************************************/
+/**
+ * ci_hdrc_gadget_connect: caller makes sure gadget driver is binded
+ */
+static void ci_hdrc_gadget_connect(struct usb_gadget *_gadget, int is_active)
+{
+	struct ci_hdrc *ci = container_of(_gadget, struct ci_hdrc, gadget);
+
+	if (is_active) {
+		pm_runtime_get_sync(&_gadget->dev);
+		hw_device_reset(ci);
+		spin_lock_irq(&ci->lock);
+		if (ci->driver) {
+			hw_device_state(ci, ci->ep0out->qh.dma);
+			usb_gadget_set_state(_gadget, USB_STATE_POWERED);
+			spin_unlock_irq(&ci->lock);
+			usb_udc_vbus_handler(_gadget, true);
+		} else {
+			spin_unlock_irq(&ci->lock);
+		}
+	} else {
+		usb_udc_vbus_handler(_gadget, false);
+		if (ci->driver)
+			ci->driver->disconnect(&ci->gadget);
+		hw_device_state(ci, 0);
+		if (ci->platdata->notify_event)
+			ci->platdata->notify_event(ci,
+			CI_HDRC_CONTROLLER_STOPPED_EVENT);
+		_gadget_stop_activity(&ci->gadget);
+		pm_runtime_put_sync(&_gadget->dev);
+		usb_gadget_set_state(_gadget, USB_STATE_NOTATTACHED);
+	}
+}
+
 static int ci_udc_vbus_session(struct usb_gadget *_gadget, int is_active)
 {
 	struct ci_hdrc *ci = container_of(_gadget, struct ci_hdrc, gadget);
 	unsigned long flags;
-	int gadget_ready = 0;
+	int ret = 0;
 
 	spin_lock_irqsave(&ci->lock, flags);
 	ci->vbus_active = is_active;
-	if (ci->driver)
-		gadget_ready = 1;
 	spin_unlock_irqrestore(&ci->lock, flags);
 
 	if (ci->usb_phy)
 		usb_phy_set_charger_state(ci->usb_phy, is_active ?
 			USB_CHARGER_PRESENT : USB_CHARGER_ABSENT);
 
-	if (gadget_ready) {
-		if (is_active) {
-			pm_runtime_get_sync(&_gadget->dev);
-			hw_device_reset(ci);
-			hw_device_state(ci, ci->ep0out->qh.dma);
-			usb_gadget_set_state(_gadget, USB_STATE_POWERED);
-			usb_udc_vbus_handler(_gadget, true);
-		} else {
-			usb_udc_vbus_handler(_gadget, false);
-			if (ci->driver)
-				ci->driver->disconnect(&ci->gadget);
-			hw_device_state(ci, 0);
-			if (ci->platdata->notify_event)
-				ci->platdata->notify_event(ci,
-				CI_HDRC_CONTROLLER_STOPPED_EVENT);
-			_gadget_stop_activity(&ci->gadget);
-			pm_runtime_put_sync(&_gadget->dev);
-			usb_gadget_set_state(_gadget, USB_STATE_NOTATTACHED);
-		}
+	if (ci->platdata->notify_event)
+		ret = ci->platdata->notify_event(ci,
+				CI_HDRC_CONTROLLER_VBUS_EVENT);
+
+	if (ci->usb_phy) {
+		if (is_active)
+			usb_phy_set_event(ci->usb_phy, USB_EVENT_VBUS);
+		else
+			usb_phy_set_event(ci->usb_phy, USB_EVENT_NONE);
 	}
 
-	return 0;
+	if (ci->driver)
+		ci_hdrc_gadget_connect(_gadget, is_active);
+
+	return ret;
 }
 
 static int ci_udc_wakeup(struct usb_gadget *_gadget)
@@ -1794,18 +1818,10 @@ static int ci_udc_start(struct usb_gadget *gadget,
 		return retval;
 	}
 
-	pm_runtime_get_sync(&ci->gadget.dev);
-	if (ci->vbus_active) {
-		hw_device_reset(ci);
-	} else {
+	if (ci->vbus_active)
+		ci_hdrc_gadget_connect(gadget, 1);
+	else
 		usb_udc_vbus_handler(&ci->gadget, false);
-		pm_runtime_put_sync(&ci->gadget.dev);
-		return retval;
-	}
-
-	retval = hw_device_state(ci, ci->ep0out->qh.dma);
-	if (retval)
-		pm_runtime_put_sync(&ci->gadget.dev);
 
 	return retval;
 }
@@ -1835,6 +1851,7 @@ static int ci_udc_stop(struct usb_gadget *gadget)
 	unsigned long flags;
 
 	spin_lock_irqsave(&ci->lock, flags);
+	ci->driver = NULL;
 
 	if (ci->vbus_active) {
 		hw_device_state(ci, 0);
@@ -1847,7 +1864,6 @@ static int ci_udc_stop(struct usb_gadget *gadget)
 		pm_runtime_put(&ci->gadget.dev);
 	}
 
-	ci->driver = NULL;
 	spin_unlock_irqrestore(&ci->lock, flags);
 
 	ci_udc_stop_for_otg_fsm(ci);
@@ -1890,6 +1906,9 @@ static irqreturn_t udc_irq(struct ci_hdrc *ci)
 		if (USBi_PCI & intr) {
 			ci->gadget.speed = hw_port_is_high_speed(ci) ?
 				USB_SPEED_HIGH : USB_SPEED_FULL;
+			if (ci->usb_phy)
+				usb_phy_set_event(ci->usb_phy,
+					USB_EVENT_ENUMERATED);
 			if (ci->suspended) {
 				if (ci->driver->resume) {
 					spin_unlock(&ci->lock);
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 59a354822413..4730089a771b 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1520,8 +1520,6 @@ static int acm_probe(struct usb_interface *intf,
 	acm->nb_index = 0;
 	acm->nb_size = 0;
 
-	dev_info(&intf->dev, "ttyACM%d: USB ACM device\n", minor);
-
 	acm->line.dwDTERate = cpu_to_le32(9600);
 	acm->line.bDataBits = 8;
 	acm_set_line(acm, &acm->line);
@@ -1529,6 +1527,12 @@ static int acm_probe(struct usb_interface *intf,
 	usb_driver_claim_interface(&acm_driver, data_interface, acm);
 	usb_set_intfdata(data_interface, acm);
 
+	if (quirks & CLEAR_HALT_CONDITIONS) {
+		/* errors intentionally ignored */
+		usb_clear_halt(usb_dev, acm->in);
+		usb_clear_halt(usb_dev, acm->out);
+	}
+
 	tty_dev = tty_port_register_device(&acm->port, acm_tty_driver, minor,
 			&control_interface->dev);
 	if (IS_ERR(tty_dev)) {
@@ -1536,10 +1540,7 @@ static int acm_probe(struct usb_interface *intf,
 		goto alloc_fail6;
 	}
 
-	if (quirks & CLEAR_HALT_CONDITIONS) {
-		usb_clear_halt(usb_dev, acm->in);
-		usb_clear_halt(usb_dev, acm->out);
-	}
+	dev_info(&intf->dev, "ttyACM%d: USB ACM device\n", minor);
 
 	return 0;
 alloc_fail6:
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 585375817f5e..1a2039d1b342 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -51,6 +51,12 @@
 #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
 #define USB_PING_RESPONSE_TIME		400	/* ns */
 
+/*
+ * Give SS hubs 200ms time after wake to train downstream links before
+ * assuming no port activity and allowing hub to runtime suspend back.
+ */
+#define USB_SS_PORT_U0_WAKE_TIME	200  /* ms */
+
 /* Protect struct usb_device->state and ->children members
  * Note: Both are also protected by ->dev.sem, except that ->state can
  * change to USB_STATE_NOTATTACHED even when the semaphore isn't held. */
@@ -1024,11 +1030,12 @@ int usb_remove_device(struct usb_device *udev)
 
 enum hub_activation_type {
 	HUB_INIT, HUB_INIT2, HUB_INIT3,		/* INITs must come first */
-	HUB_POST_RESET, HUB_RESUME, HUB_RESET_RESUME,
+	HUB_POST_RESET, HUB_RESUME, HUB_RESET_RESUME, HUB_POST_RESUME,
 };
 
 static void hub_init_func2(struct work_struct *ws);
 static void hub_init_func3(struct work_struct *ws);
+static void hub_post_resume(struct work_struct *ws);
 
 static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 {
@@ -1051,6 +1058,13 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 			goto init2;
 		goto init3;
 	}
+
+	if (type == HUB_POST_RESUME) {
+		usb_autopm_put_interface_async(to_usb_interface(hub->intfdev));
+		kref_put(&hub->kref, hub_release);
+		return;
+	}
+
 	kref_get(&hub->kref);
 
 	/* The superspeed hub except for root hub has to use Hub Depth
@@ -1299,6 +1313,17 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		device_unlock(&hdev->dev);
 	}
 
+	if (type == HUB_RESUME && hub_is_superspeed(hub->hdev)) {
+		/* give usb3 downstream links training time after hub resume */
+		usb_autopm_get_interface_no_resume(
+			to_usb_interface(hub->intfdev));
+
+		INIT_DELAYED_WORK(&hub->init_work, hub_post_resume);
+		queue_delayed_work(system_power_efficient_wq, &hub->init_work,
+				   msecs_to_jiffies(USB_SS_PORT_U0_WAKE_TIME));
+		return;
+	}
+
 	kref_put(&hub->kref, hub_release);
 }
 
@@ -1317,6 +1342,13 @@ static void hub_init_func3(struct work_struct *ws)
 	hub_activate(hub, HUB_INIT3);
 }
 
+static void hub_post_resume(struct work_struct *ws)
+{
+	struct usb_hub *hub = container_of(ws, struct usb_hub, init_work.work);
+
+	hub_activate(hub, HUB_POST_RESUME);
+}
+
 enum hub_quiescing_type {
 	HUB_DISCONNECT, HUB_PRE_RESET, HUB_SUSPEND
 };
@@ -1342,6 +1374,7 @@ static void hub_quiesce(struct usb_hub *hub, enum hub_quiescing_type type)
 
 	/* Stop hub_wq and related activity */
 	del_timer_sync(&hub->irq_urb_retry);
+	flush_delayed_work(&hub->init_work);
 	usb_kill_urb(hub->urb);
 	if (hub->has_indicators)
 		cancel_delayed_work_sync(&hub->leds);
@@ -2755,6 +2788,8 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
 #define SET_CONFIG_TRIES	(2 * (use_both_schemes + 1))
 #define USE_NEW_SCHEME(i, scheme)	((i) / 2 == (int)(scheme))
 
+#define DETECT_DISCONNECT_TRIES 5
+
 #define HUB_ROOT_RESET_TIME	60	/* times are in msec */
 #define HUB_SHORT_RESET_TIME	10
 #define HUB_BH_RESET_TIME	50
@@ -5389,6 +5424,8 @@ static void port_event(struct usb_hub *hub, int port1)
 	struct usb_device *udev = port_dev->child;
 	struct usb_device *hdev = hub->hdev;
 	u16 portstatus, portchange;
+	int i = 0;
+	int err;
 
 	connect_change = test_bit(port1, hub->change_bits);
 	clear_bit(port1, hub->event_bits);
@@ -5465,17 +5502,30 @@ static void port_event(struct usb_hub *hub, int port1)
 		connect_change = 1;
 
 	/*
-	 * Warm reset a USB3 protocol port if it's in
-	 * SS.Inactive state.
+	 * Avoid trying to recover a USB3 SS.Inactive port with a warm reset if
+	 * the device was disconnected. A 12ms disconnect detect timer in
+	 * SS.Inactive state transitions the port to RxDetect automatically.
+	 * SS.Inactive link error state is common during device disconnect.
 	 */
-	if (hub_port_warm_reset_required(hub, port1, portstatus)) {
-		dev_dbg(&port_dev->dev, "do warm reset\n");
-		if (!udev || !(portstatus & USB_PORT_STAT_CONNECTION)
+	while (hub_port_warm_reset_required(hub, port1, portstatus)) {
+		if ((i++ < DETECT_DISCONNECT_TRIES) && udev) {
+			u16 unused;
+
+			msleep(20);
+			hub_port_status(hub, port1, &portstatus, &unused);
+			dev_dbg(&port_dev->dev, "Wait for inactive link disconnect detect\n");
+			continue;
+		} else if (!udev || !(portstatus & USB_PORT_STAT_CONNECTION)
 				|| udev->state == USB_STATE_NOTATTACHED) {
-			if (hub_port_reset(hub, port1, NULL,
-					HUB_BH_RESET_TIME, true) < 0)
+			dev_dbg(&port_dev->dev, "do warm reset, port only\n");
+			err = hub_port_reset(hub, port1, NULL,
+					     HUB_BH_RESET_TIME, true);
+			if (!udev && err == -ENOTCONN)
+				connect_change = 0;
+			else if (err < 0)
 				hub_port_disable(hub, port1, 1);
 		} else {
+			dev_dbg(&port_dev->dev, "do warm reset, full device\n");
 			usb_unlock_port(port_dev);
 			usb_lock_device(udev);
 			usb_reset_device(udev);
@@ -5483,6 +5533,7 @@ static void port_event(struct usb_hub *hub, int port1)
 			usb_lock_port(port_dev);
 			connect_change = 0;
 		}
+		break;
 	}
 
 	if (connect_change)
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 5f6ba422c463..75a4d162c58b 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -368,6 +368,7 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0781, 0x5591), .driver_info = USB_QUIRK_NO_LPM },
 
 	/* SanDisk Corp. SanDisk 3.2Gen1 */
+	{ USB_DEVICE(0x0781, 0x5596), .driver_info = USB_QUIRK_DELAY_INIT },
 	{ USB_DEVICE(0x0781, 0x55a3), .driver_info = USB_QUIRK_DELAY_INIT },
 
 	/* SanDisk Extreme 55AE */
diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 850d0fffe1c6..e60f4ef06e3d 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -490,7 +490,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 
 	/* Check that the pipe's type matches the endpoint's type */
 	if (usb_pipe_type_check(urb->dev, urb->pipe))
-		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
+		dev_warn_once(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
 			usb_pipetype(urb->pipe), pipetypes[xfertype]);
 
 	/* Check against a simple/standard policy */
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 8a3ec1a951fe..9bb1edb81d6e 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -529,6 +529,9 @@ static int dwc3_meson_g12a_remove(struct platform_device *pdev)
 
 	usb_role_switch_unregister(priv->role_switch);
 
+	put_device(priv->switch_desc.udc);
+	put_device(priv->switch_desc.usb2_port);
+
 	of_platform_depopulate(dev);
 
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 742be1e07a01..8be05c7fc98b 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -615,13 +615,13 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	ret = reset_control_deassert(qcom->resets);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to deassert resets, err=%d\n", ret);
-		goto reset_assert;
+		return ret;
 	}
 
 	ret = dwc3_qcom_clk_init(qcom, of_clk_get_parent_count(np));
 	if (ret) {
 		dev_err(dev, "failed to get clocks\n");
-		goto reset_assert;
+		return ret;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -700,8 +700,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 		clk_disable_unprepare(qcom->clks[i]);
 		clk_put(qcom->clks[i]);
 	}
-reset_assert:
-	reset_control_assert(qcom->resets);
 
 	return ret;
 }
@@ -725,8 +723,6 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
 	}
 	qcom->num_clocks = 0;
 
-	reset_control_assert(qcom->resets);
-
 	pm_runtime_allow(dev);
 	pm_runtime_disable(dev);
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 76316205483b..73608332d78d 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2937,6 +2937,15 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 static void dwc3_gadget_endpoint_transfer_not_ready(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event)
 {
+	/*
+	 * During a device-initiated disconnect, a late xferNotReady event can
+	 * be generated after the End Transfer command resets the event filter,
+	 * but before the controller is halted. Ignore it to prevent a new
+	 * transfer from starting.
+	 */
+	if (!dep->dwc->connected)
+		return;
+
 	dwc3_gadget_endpoint_frame_from_event(dep, event);
 	(void) __dwc3_gadget_start_isoc(dep);
 }
diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index 5a462a1d1896..7673ded077a4 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -678,6 +678,10 @@ int __init early_xdbc_setup_hardware(void)
 
 		xdbc.table_base = NULL;
 		xdbc.out_buf = NULL;
+
+		early_iounmap(xdbc.xhci_base, xdbc.xhci_length);
+		xdbc.xhci_base = NULL;
+		xdbc.xhci_length = 0;
 	}
 
 	return ret;
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 4b2e9df97b11..55597a898f40 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2241,6 +2241,11 @@ int composite_os_desc_req_prepare(struct usb_composite_dev *cdev,
 	if (!cdev->os_desc_req->buf) {
 		ret = -ENOMEM;
 		usb_ep_free_request(ep0, cdev->os_desc_req);
+		/*
+		 * Set os_desc_req to NULL so that composite_dev_cleanup()
+		 * will not try to free it again.
+		 */
+		cdev->os_desc_req = NULL;
 		goto end;
 	}
 	cdev->os_desc_req->context = cdev;
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 87657e0ca5fc..476a22728e8d 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -824,6 +824,8 @@ static ssize_t os_desc_qw_sign_store(struct config_item *item, const char *page,
 	struct gadget_info *gi = os_desc_item_to_gadget_info(item);
 	int res, l;
 
+	if (!len)
+		return len;
 	l = min((int)len, OS_STRING_QW_SIGN_LEN >> 1);
 	if (page[l - 1] == '\n')
 		--l;
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 2952e5feb2ee..90114c09a711 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2551,6 +2551,7 @@ static int renesas_usb3_remove(struct platform_device *pdev)
 	struct renesas_usb3 *usb3 = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(usb3->dentry);
+	put_device(usb3->host_dev);
 	device_remove_file(&pdev->dev, &dev_attr_role);
 
 	cancel_work_sync(&usb3->role_work);
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 66cb9f08bff1..2c9015f2a7d3 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -628,8 +628,7 @@ static int xhci_enter_test_mode(struct xhci_hcd *xhci,
 		if (!xhci->devs[i])
 			continue;
 
-		retval = xhci_disable_slot(xhci, i);
-		xhci_free_virt_device(xhci, i);
+		retval = xhci_disable_and_free_slot(xhci, i);
 		if (retval)
 			xhci_err(xhci, "Failed to disable slot %d, %d. Enter test mode anyway\n",
 				 i, retval);
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 610190bf62da..8eb764b6050d 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -879,21 +879,20 @@ int xhci_alloc_tt_info(struct xhci_hcd *xhci,
  * will be manipulated by the configure endpoint, allocate device, or update
  * hub functions while this function is removing the TT entries from the list.
  */
-void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
+void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device *dev,
+		int slot_id)
 {
-	struct xhci_virt_device *dev;
 	int i;
 	int old_active_eps = 0;
 
 	/* Slot ID 0 is reserved */
-	if (slot_id == 0 || !xhci->devs[slot_id])
+	if (slot_id == 0 || !dev)
 		return;
 
-	dev = xhci->devs[slot_id];
-
-	xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
-	if (!dev)
-		return;
+	/* If device ctx array still points to _this_ device, clear it */
+	if (dev->out_ctx &&
+	    xhci->dcbaa->dev_context_ptrs[slot_id] == cpu_to_le64(dev->out_ctx->dma))
+		xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
 
 	trace_xhci_free_virt_device(dev);
 
@@ -932,8 +931,9 @@ void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
 
 	if (dev->udev && dev->udev->slot_id)
 		dev->udev->slot_id = 0;
-	kfree(xhci->devs[slot_id]);
-	xhci->devs[slot_id] = NULL;
+	if (xhci->devs[slot_id] == dev)
+		xhci->devs[slot_id] = NULL;
+	kfree(dev);
 }
 
 /*
@@ -975,7 +975,7 @@ static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_i
 out:
 	/* we are now at a leaf device */
 	xhci_debugfs_remove_slot(xhci, slot_id);
-	xhci_free_virt_device(xhci, slot_id);
+	xhci_free_virt_device(xhci, vdev, slot_id);
 }
 
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
@@ -1214,6 +1214,8 @@ int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_device *ud
 	ep0_ctx->deq = cpu_to_le64(dev->eps[0].ring->first_seg->dma |
 				   dev->eps[0].ring->cycle_state);
 
+	ep0_ctx->tx_info = cpu_to_le32(EP_AVG_TRB_LENGTH(8));
+
 	trace_xhci_setup_addressable_virt_device(dev);
 
 	/* Steps 7 and 8 were done in xhci_alloc_virt_device() */
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index fa320006b04d..73570b392282 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -333,7 +333,8 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_usb_phy;
 
-	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
+	if (HCC_MAX_PSA(xhci->hcc_params) >= 4 &&
+	    !(xhci->quirks & XHCI_BROKEN_STREAMS))
 		xhci->shared_hcd->can_do_streams = 1;
 
 	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 08b016864fc0..ac9464eddc83 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -973,12 +973,15 @@ static void xhci_kill_endpoint_urbs(struct xhci_hcd *xhci,
  */
 void xhci_hc_died(struct xhci_hcd *xhci)
 {
+	bool notify;
 	int i, j;
 
 	if (xhci->xhc_state & XHCI_STATE_DYING)
 		return;
 
-	xhci_err(xhci, "xHCI host controller not responding, assume dead\n");
+	notify = !(xhci->xhc_state & XHCI_STATE_REMOVING);
+	if (notify)
+		xhci_err(xhci, "xHCI host controller not responding, assume dead\n");
 	xhci->xhc_state |= XHCI_STATE_DYING;
 
 	xhci_cleanup_command_queue(xhci);
@@ -992,7 +995,7 @@ void xhci_hc_died(struct xhci_hcd *xhci)
 	}
 
 	/* inform usb core hc died if PCI remove isn't already handling it */
-	if (!(xhci->xhc_state & XHCI_STATE_REMOVING))
+	if (notify)
 		usb_hc_died(xhci_to_hcd(xhci));
 }
 
@@ -1255,7 +1258,8 @@ static void xhci_handle_cmd_enable_slot(struct xhci_hcd *xhci, int slot_id,
 		command->slot_id = 0;
 }
 
-static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id)
+static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id,
+					u32 cmd_comp_code)
 {
 	struct xhci_virt_device *virt_dev;
 	struct xhci_slot_ctx *slot_ctx;
@@ -1270,6 +1274,10 @@ static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id)
 	if (xhci->quirks & XHCI_EP_LIMIT_QUIRK)
 		/* Delete default control endpoint resources */
 		xhci_free_device_endpoint_resources(xhci, virt_dev, true);
+	if (cmd_comp_code == COMP_SUCCESS) {
+		xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
+		xhci->devs[slot_id] = NULL;
+	}
 }
 
 static void xhci_handle_cmd_config_ep(struct xhci_hcd *xhci, int slot_id,
@@ -1509,7 +1517,7 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 		xhci_handle_cmd_enable_slot(xhci, slot_id, cmd, cmd_comp_code);
 		break;
 	case TRB_DISABLE_SLOT:
-		xhci_handle_cmd_disable_slot(xhci, slot_id);
+		xhci_handle_cmd_disable_slot(xhci, slot_id, cmd_comp_code);
 		break;
 	case TRB_CONFIG_EP:
 		if (!cmd->completion)
@@ -4076,7 +4084,8 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 
 	if ((xhci->xhc_state & XHCI_STATE_DYING) ||
 		(xhci->xhc_state & XHCI_STATE_HALTED)) {
-		xhci_dbg(xhci, "xHCI dying or halted, can't queue_command\n");
+		xhci_dbg(xhci, "xHCI dying or halted, can't queue_command. state: 0x%x\n",
+			 xhci->xhc_state);
 		return -ESHUTDOWN;
 	}
 
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 3383d7f0c88f..c98789ea1934 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -118,7 +118,8 @@ int xhci_halt(struct xhci_hcd *xhci)
 	ret = xhci_handshake(&xhci->op_regs->status,
 			STS_HALT, STS_HALT, XHCI_MAX_HALT_USEC);
 	if (ret) {
-		xhci_warn(xhci, "Host halt failed, %d\n", ret);
+		if (!(xhci->xhc_state & XHCI_STATE_DYING))
+			xhci_warn(xhci, "Host halt failed, %d\n", ret);
 		return ret;
 	}
 	xhci->xhc_state |= XHCI_STATE_HALTED;
@@ -175,7 +176,8 @@ int xhci_reset(struct xhci_hcd *xhci, u64 timeout_us)
 	state = readl(&xhci->op_regs->status);
 
 	if (state == ~(u32)0) {
-		xhci_warn(xhci, "Host not accessible, reset failed.\n");
+		if (!(xhci->xhc_state & XHCI_STATE_DYING))
+			xhci_warn(xhci, "Host not accessible, reset failed.\n");
 		return -ENODEV;
 	}
 
@@ -3945,7 +3947,7 @@ static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	xhci_disable_slot(xhci, udev->slot_id);
 
 	spin_lock_irqsave(&xhci->lock, flags);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	xhci_free_virt_device(xhci, virt_dev, udev->slot_id);
 	spin_unlock_irqrestore(&xhci->lock, flags);
 
 }
@@ -3994,6 +3996,16 @@ int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id)
 	return ret;
 }
 
+int xhci_disable_and_free_slot(struct xhci_hcd *xhci, u32 slot_id)
+{
+	struct xhci_virt_device *vdev = xhci->devs[slot_id];
+	int ret;
+
+	ret = xhci_disable_slot(xhci, slot_id);
+	xhci_free_virt_device(xhci, vdev, slot_id);
+	return ret;
+}
+
 /*
  * Checks if we have enough host controller resources for the default control
  * endpoint.
@@ -4099,8 +4111,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	return 1;
 
 disable_slot:
-	xhci_disable_slot(xhci, udev->slot_id);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	xhci_disable_and_free_slot(xhci, udev->slot_id);
 
 	return 0;
 }
@@ -4236,8 +4247,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 		dev_warn(&udev->dev, "Device not responding to setup %s.\n", act);
 
 		mutex_unlock(&xhci->mutex);
-		ret = xhci_disable_slot(xhci, udev->slot_id);
-		xhci_free_virt_device(xhci, udev->slot_id);
+		ret = xhci_disable_and_free_slot(xhci, udev->slot_id);
 		if (!ret) {
 			if (xhci_alloc_dev(hcd, udev) == 1)
 				xhci_setup_addressable_virt_dev(xhci, udev);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index d27b08d43e39..d6fa03b21349 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1997,7 +1997,7 @@ void xhci_dbg_trace(struct xhci_hcd *xhci, void (*trace)(struct va_format *),
 /* xHCI memory management */
 void xhci_mem_cleanup(struct xhci_hcd *xhci);
 int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags);
-void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id);
+void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device *dev, int slot_id);
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id, struct usb_device *udev, gfp_t flags);
 int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_device *udev);
 void xhci_copy_ep0_dequeue_into_input_ctx(struct xhci_hcd *xhci,
@@ -2087,6 +2087,7 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
 int xhci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
 			   struct usb_tt *tt, gfp_t mem_flags);
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
+int xhci_disable_and_free_slot(struct xhci_hcd *xhci, u32 slot_id);
 int xhci_ext_cap_init(struct xhci_hcd *xhci);
 
 int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup);
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index b8fc818c154a..efb70b5c9e8e 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1910,6 +1910,7 @@ static int musb_gadget_stop(struct usb_gadget *g)
 	 * gadget driver here and have everything work;
 	 * that currently misbehaves.
 	 */
+	usb_gadget_set_state(g, USB_STATE_NOTATTACHED);
 
 	/* Force check of devctl register for PM runtime */
 	schedule_delayed_work(&musb->irq_work, 0);
@@ -2018,6 +2019,7 @@ void musb_g_disconnect(struct musb *musb)
 	case OTG_STATE_B_PERIPHERAL:
 	case OTG_STATE_B_IDLE:
 		musb->xceiv->otg->state = OTG_STATE_B_IDLE;
+		usb_gadget_set_state(&musb->g, USB_STATE_NOTATTACHED);
 		break;
 	case OTG_STATE_B_SRP_INIT:
 		break;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 8def19fc5025..76b7ac1103ab 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -476,13 +476,13 @@ static int omap2430_probe(struct platform_device *pdev)
 			ARRAY_SIZE(musb_resources));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err2;
+		goto err_put_control_otghs;
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err2;
+		goto err_put_control_otghs;
 	}
 
 	pm_runtime_enable(glue->dev);
@@ -497,7 +497,9 @@ static int omap2430_probe(struct platform_device *pdev)
 
 err3:
 	pm_runtime_disable(glue->dev);
-
+err_put_control_otghs:
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 err2:
 	platform_device_put(musb);
 
@@ -511,6 +513,8 @@ static int omap2430_remove(struct platform_device *pdev)
 
 	platform_device_unregister(glue->musb);
 	pm_runtime_disable(glue->dev);
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 
 	return 0;
 }
diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 6dfecbd47d7a..7c81ccaaf2e9 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -394,6 +394,7 @@ static bool mxs_phy_is_otg_host(struct mxs_phy *mxs_phy)
 static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
 {
 	bool vbus_is_on = false;
+	enum usb_phy_events last_event = mxs_phy->phy.last_event;
 
 	/* If the SoCs don't need to disconnect line without vbus, quit */
 	if (!(mxs_phy->data->flags & MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS))
@@ -405,7 +406,8 @@ static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
 
 	vbus_is_on = mxs_phy_get_vbus_status(mxs_phy);
 
-	if (on && !vbus_is_on && !mxs_phy_is_otg_host(mxs_phy))
+	if (on && ((!vbus_is_on && !mxs_phy_is_otg_host(mxs_phy))
+		|| (last_event == USB_EVENT_VBUS)))
 		__mxs_phy_disconnect_line(mxs_phy, true);
 	else
 		__mxs_phy_disconnect_line(mxs_phy, false);
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index d13b8e35ce33..ee01061b413c 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -781,6 +781,8 @@ static const struct usb_device_id id_table_combined[] = {
 		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_NDI_AURORA_SCU_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
+	{ USB_DEVICE(FTDI_NDI_VID, FTDI_NDI_EMGUIDE_GEMINI_PID),
+		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
 	{ USB_DEVICE(TELLDUS_VID, TELLDUS_TELLSTICK_PID) },
 	{ USB_DEVICE(NOVITUS_VID, NOVITUS_BONO_E_PID) },
 	{ USB_DEVICE(FTDI_VID, RTSYSTEMS_USB_VX8_PID) },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 9c95ca876bae..324065cc352c 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -197,6 +197,9 @@
 #define FTDI_NDI_FUTURE_3_PID		0xDA73	/* NDI future device #3 */
 #define FTDI_NDI_AURORA_SCU_PID		0xDA74	/* NDI Aurora SCU */
 
+#define FTDI_NDI_VID			0x23F2
+#define FTDI_NDI_EMGUIDE_GEMINI_PID	0x0003	/* NDI Emguide Gemini */
+
 /*
  * ChamSys Limited (www.chamsys.co.uk) USB wing/interface product IDs
  */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 08d70256e72e..233be8250b61 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1415,6 +1415,9 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x30),	/* Telit FE910C04 (ECM) */
+	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d1, 0xff, 0xff, 0x30),	/* Telit FN990B (MBIM) */
 	  .driver_info = NCTRL(6) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d1, 0xff, 0xff, 0x40) },
@@ -2343,6 +2346,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe145, 0xff),			/* Foxconn T99W651 RNDIS */
 	  .driver_info = RSVD(5) | RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe15f, 0xff),                     /* Foxconn T99W709 */
+	  .driver_info = RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe167, 0xff),                     /* Foxconn T99W640 MBIM */
+	  .driver_info = RSVD(3) },
 	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1782, 0x4d10) },						/* Fibocom L610 (AT mode) */
diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index 0c423916d7bf..a026c6cb6e68 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -252,7 +252,7 @@ static int rts51x_bulk_transport(struct us_data *us, u8 lun,
 		return USB_STOR_TRANSPORT_ERROR;
 	}
 
-	residue = bcs->Residue;
+	residue = le32_to_cpu(bcs->Residue);
 	if (bcs->Tag != us->tag)
 		return USB_STOR_TRANSPORT_ERROR;
 
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index a6dc2faae85d..509e4e155f41 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -934,6 +934,13 @@ UNUSUAL_DEV(  0x05e3, 0x0723, 0x9451, 0x9451,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_SANE_SENSE ),
 
+/* Added by Maël GUERIN <mael.guerin@murena.io> */
+UNUSUAL_DEV(  0x0603, 0x8611, 0x0000, 0xffff,
+		"Novatek",
+		"NTK96550-based camera",
+		USB_SC_SCSI, USB_PR_BULK, NULL,
+		US_FL_BULK_IGNORE_TAG ),
+
 /*
  * Reported by Hanno Boeck <hanno@gmx.de>
  * Taken from the Lycoris Kernel
@@ -1483,6 +1490,28 @@ UNUSUAL_DEV( 0x0bc2, 0x3332, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_WP_DETECT ),
 
+/*
+ * Reported by Zenm Chen <zenmchen@gmail.com>
+ * Ignore driver CD mode, otherwise usb_modeswitch may fail to switch
+ * the device into Wi-Fi mode.
+ */
+UNUSUAL_DEV( 0x0bda, 0x1a2b, 0x0000, 0xffff,
+		"Realtek",
+		"DISK",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_DEVICE ),
+
+/*
+ * Reported by Zenm Chen <zenmchen@gmail.com>
+ * Ignore driver CD mode, otherwise usb_modeswitch may fail to switch
+ * the device into Wi-Fi mode.
+ */
+UNUSUAL_DEV( 0x0bda, 0xa192, 0x0000, 0xffff,
+		"Realtek",
+		"DISK",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_DEVICE ),
+
 UNUSUAL_DEV(  0x0d49, 0x7310, 0x0000, 0x9999,
 		"Maxtor",
 		"USB to SATA",
diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 5e661bae3997..9d242c5213e1 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -104,6 +104,7 @@ struct fusb302_chip {
 	bool vconn_on;
 	bool vbus_on;
 	bool charge_on;
+	bool pd_rx_on;
 	bool vbus_present;
 	enum typec_cc_polarity cc_polarity;
 	enum typec_cc_status cc1;
@@ -841,6 +842,11 @@ static int tcpm_set_pd_rx(struct tcpc_dev *dev, bool on)
 	int ret = 0;
 
 	mutex_lock(&chip->lock);
+	if (chip->pd_rx_on == on) {
+		fusb302_log(chip, "pd is already %s", on ? "on" : "off");
+		goto done;
+	}
+
 	ret = fusb302_pd_rx_flush(chip);
 	if (ret < 0) {
 		fusb302_log(chip, "cannot flush pd rx buffer, ret=%d", ret);
@@ -863,6 +869,8 @@ static int tcpm_set_pd_rx(struct tcpc_dev *dev, bool on)
 			    on ? "on" : "off", ret);
 		goto done;
 	}
+
+	chip->pd_rx_on = on;
 	fusb302_log(chip, "pd := %s", on ? "on" : "off");
 done:
 	mutex_unlock(&chip->lock);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 484818796978..8402255760b3 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2422,6 +2422,9 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
 	}
 	r = __vhost_add_used_n(vq, heads, count);
 
+	if (r < 0)
+		return r;
+
 	/* Make sure buffer is written before we update index. */
 	smp_wmb();
 	if (vhost_put_used_idx(vq)) {
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 6a7c0ea1184e..23f15f42e5cb 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1198,7 +1198,7 @@ static bool vgacon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
 				     c->vc_screenbuf_size - delta);
 			c->vc_origin = vga_vram_end - c->vc_screenbuf_size;
 			vga_rolled_over = 0;
-		} else if (oldo - delta >= (unsigned long)c->vc_screenbuf)
+		} else
 			c->vc_origin -= delta;
 		c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
 		scr_memsetw((u16 *) (c->vc_origin), c->vc_video_erase_char,
diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index dbc8808b093a..8dac15bf2b0c 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -992,8 +992,13 @@ static int imxfb_probe(struct platform_device *pdev)
 
 
 	INIT_LIST_HEAD(&info->modelist);
-	for (i = 0; i < fbi->num_modes; i++)
-		fb_add_videomode(&fbi->mode[i].mode, &info->modelist);
+	for (i = 0; i < fbi->num_modes; i++) {
+		ret = fb_add_videomode(&fbi->mode[i].mode, &info->modelist);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to add videomode\n");
+			goto failed_cmap;
+		}
+	}
 
 	/*
 	 * This makes sure that our colour bitfield
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index fef7c61f5555..72dc5f4f6eb8 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -289,6 +289,8 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	} else {
 		wdd->timeout = DW_WDT_DEFAULT_SECONDS;
 		watchdog_init_timeout(wdd, 0, dev);
+		/* Limit timeout value to hardware constraints. */
+		dw_wdt_set_timeout(wdd, wdd->timeout);
 	}
 
 	platform_set_drvdata(pdev, dw_wdt);
diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
index 4a363a8b2d20..84c98c4c510c 100644
--- a/drivers/watchdog/ziirave_wdt.c
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -306,6 +306,9 @@ static int ziirave_firm_verify(struct watchdog_device *wdd,
 		const u16 len = be16_to_cpu(rec->len);
 		const u32 addr = be32_to_cpu(rec->addr);
 
+		if (len > sizeof(data))
+			return -EINVAL;
+
 		if (ziirave_firm_addr_readonly(addr))
 			continue;
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 75bf490cd732..ed9911946638 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -274,8 +274,7 @@ struct walk_control {
 
 	/*
 	 * Ignore any items from the inode currently being processed. Needs
-	 * to be set every time we find a BTRFS_INODE_ITEM_KEY and we are in
-	 * the LOG_WALK_REPLAY_INODES stage.
+	 * to be set every time we find a BTRFS_INODE_ITEM_KEY.
 	 */
 	bool ignore_cur_inode;
 
@@ -2604,23 +2603,30 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 
 	nritems = btrfs_header_nritems(eb);
 	for (i = 0; i < nritems; i++) {
-		btrfs_item_key_to_cpu(eb, &key, i);
+		struct btrfs_inode_item *inode_item;
 
-		/* inode keys are done during the first stage */
-		if (key.type == BTRFS_INODE_ITEM_KEY &&
-		    wc->stage == LOG_WALK_REPLAY_INODES) {
-			struct btrfs_inode_item *inode_item;
-			u32 mode;
+		btrfs_item_key_to_cpu(eb, &key, i);
 
-			inode_item = btrfs_item_ptr(eb, i,
-					    struct btrfs_inode_item);
+		if (key.type == BTRFS_INODE_ITEM_KEY) {
+			inode_item = btrfs_item_ptr(eb, i, struct btrfs_inode_item);
 			/*
-			 * If we have a tmpfile (O_TMPFILE) that got fsync'ed
-			 * and never got linked before the fsync, skip it, as
-			 * replaying it is pointless since it would be deleted
-			 * later. We skip logging tmpfiles, but it's always
-			 * possible we are replaying a log created with a kernel
-			 * that used to log tmpfiles.
+			 * An inode with no links is either:
+			 *
+			 * 1) A tmpfile (O_TMPFILE) that got fsync'ed and never
+			 *    got linked before the fsync, skip it, as replaying
+			 *    it is pointless since it would be deleted later.
+			 *    We skip logging tmpfiles, but it's always possible
+			 *    we are replaying a log created with a kernel that
+			 *    used to log tmpfiles;
+			 *
+			 * 2) A non-tmpfile which got its last link deleted
+			 *    while holding an open fd on it and later got
+			 *    fsynced through that fd. We always log the
+			 *    parent inodes when inode->last_unlink_trans is
+			 *    set to the current transaction, so ignore all the
+			 *    inode items for this inode. We will delete the
+			 *    inode when processing the parent directory with
+			 *    replay_dir_deletes().
 			 */
 			if (btrfs_inode_nlink(eb, inode_item) == 0) {
 				wc->ignore_cur_inode = true;
@@ -2628,8 +2634,14 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 			} else {
 				wc->ignore_cur_inode = false;
 			}
-			ret = replay_xattr_deletes(wc->trans, root, log,
-						   path, key.objectid);
+		}
+
+		/* Inode keys are done during the first stage. */
+		if (key.type == BTRFS_INODE_ITEM_KEY &&
+		    wc->stage == LOG_WALK_REPLAY_INODES) {
+			u32 mode;
+
+			ret = replay_xattr_deletes(wc->trans, root, log, path, key.objectid);
 			if (ret)
 				break;
 			mode = btrfs_inode_mode(eb, inode_item);
@@ -3941,6 +3953,11 @@ static void fill_inode_item(struct btrfs_trans_handle *trans,
 	btrfs_set_token_timespec_nsec(leaf, &item->ctime,
 				      inode->i_ctime.tv_nsec, &token);
 
+	btrfs_set_token_timespec_sec(leaf, &item->otime,
+				     BTRFS_I(inode)->i_otime.tv_sec, &token);
+	btrfs_set_token_timespec_nsec(leaf, &item->otime,
+				      BTRFS_I(inode)->i_otime.tv_nsec, &token);
+
 	btrfs_set_token_inode_nbytes(leaf, item, inode_get_bytes(inode),
 				     &token);
 
diff --git a/fs/buffer.c b/fs/buffer.c
index 4ec88d08d04e..e0da5e56e499 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -161,8 +161,8 @@ static void __end_buffer_read_notouch(struct buffer_head *bh, int uptodate)
  */
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
 {
-	__end_buffer_read_notouch(bh, uptodate);
 	put_bh(bh);
+	__end_buffer_read_notouch(bh, uptodate);
 }
 EXPORT_SYMBOL(end_buffer_read_sync);
 
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 253321adc266..76003dbd43ec 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1722,6 +1722,7 @@ static inline bool is_retryable_error(int error)
 #define   MID_RETRY_NEEDED      8 /* session closed while this request out */
 #define   MID_RESPONSE_MALFORMED 0x10
 #define   MID_SHUTDOWN		 0x20
+#define   MID_RESPONSE_READY 0x40 /* ready for other process handle the rsp */
 
 /* Flags */
 #define   MID_WAIT_CANCELLED	 1 /* Cancelled while waiting for response */
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index f924f05b1829..ea444c8d0c40 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -4544,6 +4544,12 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 			pSMB->FileName[name_len] = 0;
 			pSMB->FileName[name_len+1] = 0;
 			name_len += 2;
+		} else if (!searchName[0]) {
+			pSMB->FileName[0] = CIFS_DIR_SEP(cifs_sb);
+			pSMB->FileName[1] = 0;
+			pSMB->FileName[2] = 0;
+			pSMB->FileName[3] = 0;
+			name_len = 4;
 		}
 	} else {
 		name_len = copy_path_name(pSMB->FileName, searchName);
@@ -4555,6 +4561,10 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 			pSMB->FileName[name_len] = '*';
 			pSMB->FileName[name_len+1] = 0;
 			name_len += 2;
+		} else if (!searchName[0]) {
+			pSMB->FileName[0] = CIFS_DIR_SEP(cifs_sb);
+			pSMB->FileName[1] = 0;
+			name_len = 2;
 		}
 	}
 
diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 0842a1af0b98..72df002e8ae3 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -495,7 +495,6 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_RECV) {
 		log_rdma_recv(INFO, "wc->status=%d opcode=%d\n",
 			wc->status, wc->opcode);
-		smbd_disconnect_rdma_connection(info);
 		goto error;
 	}
 
@@ -512,8 +511,9 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		info->full_packet_received = true;
 		info->negotiate_done =
 			process_negotiation_response(response, wc->byte_len);
+		put_receive_buffer(info, response);
 		complete(&info->negotiate_completion);
-		break;
+		return;
 
 	/* SMBD data transfer packet */
 	case SMBD_TRANSFER_DATA:
@@ -565,14 +565,16 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 
 		queue_work(info->workqueue, &info->recv_done_work);
 		return;
-
-	default:
-		log_rdma_recv(ERR,
-			"unexpected response type=%d\n", response->type);
 	}
 
+	/*
+	 * This is an internal error!
+	 */
+	log_rdma_recv(ERR, "unexpected response type=%d\n", response->type);
+	WARN_ON_ONCE(response->type != SMBD_TRANSFER_DATA);
 error:
 	put_receive_buffer(info, response);
+	smbd_disconnect_rdma_connection(info);
 }
 
 static struct rdma_cm_id *smbd_create_id(
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 60141a7468b0..37d08c1daf29 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -47,6 +47,8 @@
 void
 cifs_wake_up_task(struct mid_q_entry *mid)
 {
+	if (mid->mid_state == MID_RESPONSE_RECEIVED)
+		mid->mid_state = MID_RESPONSE_READY;
 	wake_up_process(mid->callback_data);
 }
 
@@ -99,7 +101,8 @@ static void _cifs_mid_q_entry_release(struct kref *refcount)
 	struct TCP_Server_Info *server = midEntry->server;
 
 	if (midEntry->resp_buf && (midEntry->mid_flags & MID_WAIT_CANCELLED) &&
-	    midEntry->mid_state == MID_RESPONSE_RECEIVED &&
+	    (midEntry->mid_state == MID_RESPONSE_RECEIVED ||
+	     midEntry->mid_state == MID_RESPONSE_READY) &&
 	    server->ops->handle_cancelled_mid)
 		server->ops->handle_cancelled_mid(midEntry->resp_buf, server);
 
@@ -737,7 +740,8 @@ wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
 	int error;
 
 	error = wait_event_freezekillable_unsafe(server->response_q,
-				    midQ->mid_state != MID_REQUEST_SUBMITTED);
+				    midQ->mid_state != MID_REQUEST_SUBMITTED &&
+				    midQ->mid_state != MID_RESPONSE_RECEIVED);
 	if (error < 0)
 		return -ERESTARTSYS;
 
@@ -889,7 +893,7 @@ cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
 
 	spin_lock(&GlobalMid_Lock);
 	switch (mid->mid_state) {
-	case MID_RESPONSE_RECEIVED:
+	case MID_RESPONSE_READY:
 		spin_unlock(&GlobalMid_Lock);
 		return rc;
 	case MID_RETRY_NEEDED:
@@ -987,6 +991,9 @@ cifs_compound_callback(struct mid_q_entry *mid)
 	credits.instance = server->reconnect_instance;
 
 	add_credits(server, &credits, mid->optype);
+
+	if (mid->mid_state == MID_RESPONSE_RECEIVED)
+		mid->mid_state = MID_RESPONSE_READY;
 }
 
 static void
@@ -1150,7 +1157,8 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			send_cancel(server, &rqst[i], midQ[i]);
 			spin_lock(&GlobalMid_Lock);
 			midQ[i]->mid_flags |= MID_WAIT_CANCELLED;
-			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED) {
+			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED ||
+			    midQ[i]->mid_state == MID_RESPONSE_RECEIVED) {
 				midQ[i]->callback = cifs_cancelled_callback;
 				cancelled_mid[i] = true;
 				credits[i].value = 0;
@@ -1171,7 +1179,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		}
 
 		if (!midQ[i]->resp_buf ||
-		    midQ[i]->mid_state != MID_RESPONSE_RECEIVED) {
+		    midQ[i]->mid_state != MID_RESPONSE_READY) {
 			rc = -EIO;
 			cifs_dbg(FYI, "Bad MID state?\n");
 			goto out;
@@ -1348,7 +1356,8 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	if (rc != 0) {
 		send_cancel(server, &rqst, midQ);
 		spin_lock(&GlobalMid_Lock);
-		if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
+		if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		    midQ->mid_state == MID_RESPONSE_RECEIVED) {
 			/* no longer considered to be "in-flight" */
 			midQ->callback = DeleteMidQEntry;
 			spin_unlock(&GlobalMid_Lock);
@@ -1365,7 +1374,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	}
 
 	if (!midQ->resp_buf || !out_buf ||
-	    midQ->mid_state != MID_RESPONSE_RECEIVED) {
+	    midQ->mid_state != MID_RESPONSE_READY) {
 		rc = -EIO;
 		cifs_server_dbg(VFS, "Bad MID state?\n");
 		goto out;
@@ -1485,13 +1494,15 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 
 	/* Wait for a reply - allow signals to interrupt. */
 	rc = wait_event_interruptible(server->response_q,
-		(!(midQ->mid_state == MID_REQUEST_SUBMITTED)) ||
+		(!(midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		   midQ->mid_state == MID_RESPONSE_RECEIVED)) ||
 		((server->tcpStatus != CifsGood) &&
 		 (server->tcpStatus != CifsNew)));
 
 	/* Were we interrupted by a signal ? */
 	if ((rc == -ERESTARTSYS) &&
-		(midQ->mid_state == MID_REQUEST_SUBMITTED) &&
+		(midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		 midQ->mid_state == MID_RESPONSE_RECEIVED) &&
 		((server->tcpStatus == CifsGood) ||
 		 (server->tcpStatus == CifsNew))) {
 
@@ -1521,7 +1532,8 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		if (rc) {
 			send_cancel(server, &rqst, midQ);
 			spin_lock(&GlobalMid_Lock);
-			if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
+			if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
+			    midQ->mid_state == MID_RESPONSE_RECEIVED) {
 				/* no longer considered to be "in-flight" */
 				midQ->callback = DeleteMidQEntry;
 				spin_unlock(&GlobalMid_Lock);
@@ -1539,7 +1551,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		return rc;
 
 	/* rcvd frame is ok */
-	if (out_buf == NULL || midQ->mid_state != MID_RESPONSE_RECEIVED) {
+	if (out_buf == NULL || midQ->mid_state != MID_RESPONSE_READY) {
 		rc = -EIO;
 		cifs_tcon_dbg(VFS, "Bad MID state?\n");
 		goto out;
diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index dfd314ee3423..bdc194b8f4de 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -393,6 +393,14 @@ static unsigned int ext4_getfsmap_find_sb(struct super_block *sb,
 	/* Reserved GDT blocks */
 	if (!ext4_has_feature_meta_bg(sb) || metagroup < first_meta_bg) {
 		len = le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks);
+
+		/*
+		 * mkfs.ext4 can set s_reserved_gdt_blocks as 0 in some cases,
+		 * check for that.
+		 */
+		if (!len)
+			return 0;
+
 		error = ext4_getfsmap_fill(meta_list, fsb, len,
 					   EXT4_FMR_OWN_RESV_GDT);
 		if (error)
@@ -526,6 +534,7 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 	ext4_group_t end_ag;
 	ext4_grpblk_t first_cluster;
 	ext4_grpblk_t last_cluster;
+	struct ext4_fsmap irec;
 	int error = 0;
 
 	bofs = le32_to_cpu(sbi->s_es->s_first_data_block);
@@ -609,10 +618,18 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 			goto err;
 	}
 
-	/* Report any gaps at the end of the bg */
+	/*
+	 * The dummy record below will cause ext4_getfsmap_helper() to report
+	 * any allocated blocks at the end of the range.
+	 */
+	irec.fmr_device = 0;
+	irec.fmr_physical = end_fsb + 1;
+	irec.fmr_length = 0;
+	irec.fmr_owner = EXT4_FMR_OWN_FREE;
+	irec.fmr_flags = 0;
+
 	info->gfi_last = true;
-	error = ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster + 1,
-					     0, info);
+	error = ext4_getfsmap_helper(sb, info, &irec);
 	if (error)
 		goto err;
 
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 7e8892dad2d7..626be0ec3c7a 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -296,7 +296,11 @@ static int ext4_create_inline_data(handle_t *handle,
 	if (error)
 		goto out;
 
-	BUG_ON(!is.s.not_found);
+	if (!is.s.not_found) {
+		EXT4_ERROR_INODE(inode, "unexpected inline data xattr");
+		error = -EFSCORRUPTED;
+		goto out;
+	}
 
 	error = ext4_xattr_ibody_set(handle, inode, &i, &is);
 	if (error) {
@@ -347,7 +351,11 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 	if (error)
 		goto out;
 
-	BUG_ON(is.s.not_found);
+	if (is.s.not_found) {
+		EXT4_ERROR_INODE(inode, "missing inline data xattr");
+		error = -EFSCORRUPTED;
+		goto out;
+	}
 
 	len -= EXT4_MIN_INLINE_DATA_SIZE;
 	value = kzalloc(len, GFP_NOFS);
@@ -1978,7 +1986,12 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 			if ((err = ext4_xattr_ibody_find(inode, &i, &is)) != 0)
 				goto out_error;
 
-			BUG_ON(is.s.not_found);
+			if (is.s.not_found) {
+				EXT4_ERROR_INODE(inode,
+						 "missing inline data xattr");
+				err = -EFSCORRUPTED;
+				goto out_error;
+			}
 
 			value_len = le32_to_cpu(is.s.here->e_value_size);
 			value = kmalloc(value_len, GFP_NOFS);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8f020c719b18..fe54c84a1df0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -150,7 +150,7 @@ static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
  */
 int ext4_inode_is_fast_symlink(struct inode *inode)
 {
-	if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
+	if (!ext4_has_feature_ea_inode(inode->i_sb)) {
 		int ea_blocks = EXT4_I(inode)->i_file_acl ?
 				EXT4_CLUSTER_SIZE(inode->i_sb) >> 9 : 0;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1b8f41daddba..e17b19bb4148 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1098,7 +1098,7 @@ struct f2fs_bio_info {
 #define RDEV(i)				(raw_super->devs[i])
 struct f2fs_dev_info {
 	struct block_device *bdev;
-	char path[MAX_PATH_LEN];
+	char path[MAX_PATH_LEN + 1];
 	unsigned int total_segments;
 	block_t start_blk;
 	block_t end_blk;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index b0cbb01df8cb..ce4f4a67134f 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -221,6 +221,13 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
+	if (ino_of_node(node_page) == fi->i_xattr_nid) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_warn(sbi, "%s: corrupted inode i_ino=%lx, xnid=%x, run fsck to fix.",
+			  __func__, inode->i_ino, fi->i_xattr_nid);
+		return false;
+	}
+
 	if (f2fs_sb_has_flexible_inline_xattr(sbi)
 			&& !f2fs_has_extra_attr(inode)) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
@@ -728,6 +735,19 @@ void f2fs_evict_inode(struct inode *inode)
 		f2fs_update_inode_page(inode);
 		if (dquot_initialize_needed(inode))
 			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+
+		/*
+		 * If both f2fs_truncate() and f2fs_update_inode_page() failed
+		 * due to fuzzed corrupted inode, call f2fs_inode_synced() to
+		 * avoid triggering later f2fs_bug_on().
+		 */
+		if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
+			f2fs_warn(sbi,
+				"f2fs_evict_inode: inode is dirty, ino:%lu",
+				inode->i_ino);
+			f2fs_inode_synced(inode);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+		}
 	}
 	sb_end_intwrite(inode->i_sb);
 no_delete:
@@ -740,8 +760,12 @@ void f2fs_evict_inode(struct inode *inode)
 	if (likely(!f2fs_cp_error(sbi) &&
 				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
 		f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
-	else
-		f2fs_inode_synced(inode);
+
+	/*
+	 * anyway, it needs to remove the inode from sbi->inode_list[DIRTY_META]
+	 * list to avoid UAF in f2fs_sync_inode_meta() during checkpoint.
+	 */
+	f2fs_inode_synced(inode);
 
 	/* ino == 0, if f2fs_new_inode() was failed t*/
 	if (inode->i_ino)
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index d629b3c6546c..86ddd5a3d748 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -764,6 +764,16 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	for (i = 1; i <= level; i++) {
 		bool done = false;
 
+		if (nids[i] && nids[i] == dn->inode->i_ino) {
+			err = -EFSCORRUPTED;
+			f2fs_err(sbi,
+				"inode mapping table is corrupted, run fsck to fix it, "
+				"ino:%lu, nid:%u, level:%d, offset:%d",
+				dn->inode->i_ino, nids[i], level, offset[level]);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			goto release_pages;
+		}
+
 		if (!nids[i] && mode == ALLOC_NODE) {
 			/* alloc new node */
 			if (!f2fs_alloc_nid(sbi, &(nids[i]))) {
diff --git a/fs/file.c b/fs/file.c
index cf7c04f35564..95f6af59df80 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -78,9 +78,17 @@ static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
 	copy_fd_bitmaps(nfdt, ofdt, fdt_words(ofdt));
 }
 
-static struct fdtable * alloc_fdtable(unsigned int nr)
+/*
+ * Note how the fdtable bitmap allocations very much have to be a multiple of
+ * BITS_PER_LONG. This is not only because we walk those things in chunks of
+ * 'unsigned long' in some places, but simply because that is how the Linux
+ * kernel bitmaps are defined to work: they are not "bits in an array of bytes",
+ * they are very much "bits in an array of unsigned long".
+ */
+static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
 {
 	struct fdtable *fdt;
+	unsigned int nr;
 	void *data;
 
 	/*
@@ -88,21 +96,47 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
 	 * Allocation steps are keyed to the size of the fdarray, since it
 	 * grows far faster than any of the other dynamic data. We try to fit
 	 * the fdarray into comfortable page-tuned chunks: starting at 1024B
-	 * and growing in powers of two from there on.
+	 * and growing in powers of two from there on.  Since we called only
+	 * with slots_wanted > BITS_PER_LONG (embedded instance in files->fdtab
+	 * already gives BITS_PER_LONG slots), the above boils down to
+	 * 1.  use the smallest power of two large enough to give us that many
+	 * slots.
+	 * 2.  on 32bit skip 64 and 128 - the minimal capacity we want there is
+	 * 256 slots (i.e. 1Kb fd array).
+	 * 3.  on 64bit don't skip anything, 1Kb fd array means 128 slots there
+	 * and we are never going to be asked for 64 or less.
 	 */
-	nr /= (1024 / sizeof(struct file *));
-	nr = roundup_pow_of_two(nr + 1);
-	nr *= (1024 / sizeof(struct file *));
+	if (IS_ENABLED(CONFIG_32BIT) && slots_wanted < 256)
+		nr = 256;
+	else
+		nr = roundup_pow_of_two(slots_wanted);
 	/*
 	 * Note that this can drive nr *below* what we had passed if sysctl_nr_open
-	 * had been set lower between the check in expand_files() and here.  Deal
-	 * with that in caller, it's cheaper that way.
+	 * had been set lower between the check in expand_files() and here.
 	 *
 	 * We make sure that nr remains a multiple of BITS_PER_LONG - otherwise
 	 * bitmaps handling below becomes unpleasant, to put it mildly...
 	 */
-	if (unlikely(nr > sysctl_nr_open))
-		nr = ((sysctl_nr_open - 1) | (BITS_PER_LONG - 1)) + 1;
+	if (unlikely(nr > sysctl_nr_open)) {
+		nr = round_down(sysctl_nr_open, BITS_PER_LONG);
+		if (nr < slots_wanted)
+			return ERR_PTR(-EMFILE);
+	}
+
+	/*
+	 * Check if the allocation size would exceed INT_MAX. kvmalloc_array()
+	 * and kvmalloc() will warn if the allocation size is greater than
+	 * INT_MAX, as filp_cachep objects are not __GFP_NOWARN.
+	 *
+	 * This can happen when sysctl_nr_open is set to a very high value and
+	 * a process tries to use a file descriptor near that limit. For example,
+	 * if sysctl_nr_open is set to 1073741816 (0x3ffffff8) - which is what
+	 * systemd typically sets it to - then trying to use a file descriptor
+	 * close to that value will require allocating a file descriptor table
+	 * that exceeds 8GB in size.
+	 */
+	if (unlikely(nr > INT_MAX / sizeof(struct file *)))
+		return ERR_PTR(-EMFILE);
 
 	fdt = kmalloc(sizeof(struct fdtable), GFP_KERNEL_ACCOUNT);
 	if (!fdt)
@@ -131,7 +165,7 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
 out_fdt:
 	kfree(fdt);
 out:
-	return NULL;
+	return ERR_PTR(-ENOMEM);
 }
 
 /*
@@ -148,7 +182,7 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 	struct fdtable *new_fdt, *cur_fdt;
 
 	spin_unlock(&files->file_lock);
-	new_fdt = alloc_fdtable(nr);
+	new_fdt = alloc_fdtable(nr + 1);
 
 	/* make sure all __fd_install() have seen resize_in_progress
 	 * or have finished their rcu_read_lock_sched() section.
@@ -157,16 +191,8 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 		synchronize_rcu();
 
 	spin_lock(&files->file_lock);
-	if (!new_fdt)
-		return -ENOMEM;
-	/*
-	 * extremely unlikely race - sysctl_nr_open decreased between the check in
-	 * caller and alloc_fdtable().  Cheaper to catch it here...
-	 */
-	if (unlikely(new_fdt->max_fds <= nr)) {
-		__free_fdtable(new_fdt);
-		return -EMFILE;
-	}
+	if (IS_ERR(new_fdt))
+		return PTR_ERR(new_fdt);
 	cur_fdt = files_fdtable(files);
 	BUG_ON(nr < cur_fdt->max_fds);
 	copy_fdtable(new_fdt, cur_fdt);
@@ -303,16 +329,9 @@ struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 		if (new_fdt != &newf->fdtab)
 			__free_fdtable(new_fdt);
 
-		new_fdt = alloc_fdtable(open_files - 1);
-		if (!new_fdt) {
-			*errorp = -ENOMEM;
-			goto out_release;
-		}
-
-		/* beyond sysctl_nr_open; nothing to do */
-		if (unlikely(new_fdt->max_fds < open_files)) {
-			__free_fdtable(new_fdt);
-			*errorp = -EMFILE;
+		new_fdt = alloc_fdtable(open_files);
+		if (IS_ERR(new_fdt)) {
+			*errorp = PTR_ERR(new_fdt);
 			goto out_release;
 		}
 
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 2251286cd83f..219e3b8fd6a8 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -15,6 +15,48 @@
 
 #include "btree.h"
 
+static inline
+bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
+{
+	bool is_valid = off < node->tree->node_size;
+
+	if (!is_valid) {
+		pr_err("requested invalid offset: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off);
+	}
+
+	return is_valid;
+}
+
+static inline
+int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
+{
+	unsigned int node_size;
+
+	if (!is_bnode_offset_valid(node, off))
+		return 0;
+
+	node_size = node->tree->node_size;
+
+	if ((off + len) > node_size) {
+		int new_len = (int)node_size - off;
+
+		pr_err("requested length has been corrected: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, "
+		       "requested_len %d, corrected_len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len, new_len);
+
+		return new_len;
+	}
+
+	return len;
+}
+
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 {
 	struct page *page;
@@ -23,6 +65,20 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 	int bytes_to_read;
 	void *vaddr;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagenum = off >> PAGE_SHIFT;
 	off &= ~PAGE_MASK; /* compute page offset for the first page */
@@ -83,6 +139,20 @@ void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
 {
 	struct page *page;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	page = node->page[0];
 
@@ -108,6 +178,20 @@ void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
 {
 	struct page *page;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	page = node->page[0];
 
@@ -124,6 +208,10 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 	hfs_dbg(BNODE_MOD, "copybytes: %u,%u,%u\n", dst, src, len);
 	if (!len)
 		return;
+
+	len = check_and_correct_requested_length(src_node, src, len);
+	len = check_and_correct_requested_length(dst_node, dst, len);
+
 	src += src_node->page_offset;
 	dst += dst_node->page_offset;
 	src_page = src_node->page[0];
@@ -143,6 +231,10 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src, len);
 	if (!len)
 		return;
+
+	len = check_and_correct_requested_length(node, src, len);
+	len = check_and_correct_requested_length(node, dst, len);
+
 	src += node->page_offset;
 	dst += node->page_offset;
 	page = node->page[0];
@@ -494,6 +586,7 @@ void hfs_bnode_put(struct hfs_bnode *node)
 		if (test_bit(HFS_BNODE_DELETED, &node->flags)) {
 			hfs_bnode_unhash(node);
 			spin_unlock(&tree->hash_lock);
+			hfs_bnode_clear(node, 0, tree->node_size);
 			hfs_bmap_free(node);
 			hfs_bnode_free(node);
 			return;
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index cf6e5de7b9da..c9c38fddf505 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -18,12 +18,68 @@
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
 
+static inline
+bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
+{
+	bool is_valid = off < node->tree->node_size;
+
+	if (!is_valid) {
+		pr_err("requested invalid offset: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off);
+	}
+
+	return is_valid;
+}
+
+static inline
+int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
+{
+	unsigned int node_size;
+
+	if (!is_bnode_offset_valid(node, off))
+		return 0;
+
+	node_size = node->tree->node_size;
+
+	if ((off + len) > node_size) {
+		int new_len = (int)node_size - off;
+
+		pr_err("requested length has been corrected: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, "
+		       "requested_len %d, corrected_len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len, new_len);
+
+		return new_len;
+	}
+
+	return len;
+}
+
 /* Copy a specified range of bytes from the raw data of a node */
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 {
 	struct page **pagep;
 	int l;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
 	off &= ~PAGE_MASK;
@@ -83,6 +139,20 @@ void hfs_bnode_write(struct hfs_bnode *node, void *buf, int off, int len)
 	struct page **pagep;
 	int l;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
 	off &= ~PAGE_MASK;
@@ -113,6 +183,20 @@ void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
 	struct page **pagep;
 	int l;
 
+	if (!is_bnode_offset_valid(node, off))
+		return;
+
+	if (len == 0) {
+		pr_err("requested zero length: "
+		       "NODE: id %u, type %#x, height %u, "
+		       "node_size %u, offset %d, len %d\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off, len);
+		return;
+	}
+
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
 	off &= ~PAGE_MASK;
@@ -139,6 +223,10 @@ void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst,
 	hfs_dbg(BNODE_MOD, "copybytes: %u,%u,%u\n", dst, src, len);
 	if (!len)
 		return;
+
+	len = check_and_correct_requested_length(src_node, src, len);
+	len = check_and_correct_requested_length(dst_node, dst, len);
+
 	src += src_node->page_offset;
 	dst += dst_node->page_offset;
 	src_page = src_node->page + (src >> PAGE_SHIFT);
@@ -196,6 +284,10 @@ void hfs_bnode_move(struct hfs_bnode *node, int dst, int src, int len)
 	hfs_dbg(BNODE_MOD, "movebytes: %u,%u,%u\n", dst, src, len);
 	if (!len)
 		return;
+
+	len = check_and_correct_requested_length(node, src, len);
+	len = check_and_correct_requested_length(node, dst, len);
+
 	src += node->page_offset;
 	dst += node->page_offset;
 	if (dst > src) {
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index c95a2f0ed4a7..fad1c250f150 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -342,9 +342,6 @@ static int hfsplus_free_extents(struct super_block *sb,
 	int i;
 	int err = 0;
 
-	/* Mapping the allocation file may lock the extent tree */
-	WARN_ON(mutex_is_locked(&HFSPLUS_SB(sb)->ext_tree->tree_lock));
-
 	hfsplus_dump_extent(extent);
 	for (i = 0; i < 8; extent++, i++) {
 		count = be32_to_cpu(extent->block_count);
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 73342c925a4b..36b6cf2a3abb 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -132,7 +132,14 @@ int hfsplus_uni2asc(struct super_block *sb,
 
 	op = astr;
 	ip = ustr->unicode;
+
 	ustrlen = be16_to_cpu(ustr->length);
+	if (ustrlen > HFSPLUS_MAX_STRLEN) {
+		ustrlen = HFSPLUS_MAX_STRLEN;
+		pr_err("invalid length %u has been corrected to %d\n",
+			be16_to_cpu(ustr->length), ustrlen);
+	}
+
 	len = *len_p;
 	ce1 = NULL;
 	compose = !test_bit(HFSPLUS_SB_NODECOMPOSE, &HFSPLUS_SB(sb)->flags);
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index d91f76ef18d9..2438cd759620 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -172,7 +172,11 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 		return PTR_ERR(attr_file);
 	}
 
-	BUG_ON(i_size_read(attr_file) != 0);
+	if (i_size_read(attr_file) != 0) {
+		err = -EIO;
+		pr_err("detected inconsistent attributes file, running fsck.hfsplus is recommended.\n");
+		goto end_attr_file_creation;
+	}
 
 	hip = HFSPLUS_I(attr_file);
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 47b292f9b4f8..c18a47a86e8b 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -152,7 +152,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_flags |= VM_HUGETLB | VM_DONTEXPAND;
 	vma->vm_ops = &hugetlb_vm_ops;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 95c08f3c4b35..ce3848720a8d 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1499,9 +1499,16 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 		inode->i_op = &page_symlink_inode_operations;
 		inode_nohighmem(inode);
 		inode->i_data.a_ops = &isofs_symlink_aops;
-	} else
+	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		/* XXX - parse_rock_ridge_inode() had already set i_rdev. */
 		init_special_inode(inode, inode->i_mode, inode->i_rdev);
+	} else {
+		printk(KERN_DEBUG "ISOFS: Invalid file type 0%04o for inode %lu.\n",
+			inode->i_mode, inode->i_ino);
+		ret = -EIO;
+		goto fail;
+	}
 
 	ret = 0;
 out:
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index c09d1bdffb91..faf9b98f6d5e 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -321,6 +321,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 		retry:
 			if (batch_count)
 				__flush_batch(journal, &batch_count);
+			cond_resched();
 			spin_lock(&journal->j_list_lock);
 			goto restart;
 	}
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 930d2701f206..44872daeca01 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -44,6 +44,9 @@ static int jfs_open(struct inode *inode, struct file *file)
 {
 	int rc;
 
+	if (S_ISREG(inode->i_mode) && inode->i_size < 0)
+		return -EIO;
+
 	if ((rc = dquot_file_open(inode, file)))
 		return rc;
 
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 62c4a5450cda..6d353fbe67c0 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -145,9 +145,9 @@ void jfs_evict_inode(struct inode *inode)
 	if (!inode->i_nlink && !is_bad_inode(inode)) {
 		dquot_initialize(inode);
 
+		truncate_inode_pages_final(&inode->i_data);
 		if (JFS_IP(inode)->fileset == FILESYSTEM_I) {
 			struct inode *ipimap = JFS_SBI(inode->i_sb)->ipimap;
-			truncate_inode_pages_final(&inode->i_data);
 
 			if (test_cflag(COMMIT_Freewmap, inode))
 				jfs_free_zero_link(inode);
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 8cffb5dd98cf..17c4e7bdf283 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1457,6 +1457,12 @@ dbAllocAG(struct bmap * bmp, int agno, s64 nblocks, int l2nb, s64 * results)
 	    (1 << (L2LPERCTL - (bmp->db_agheight << 1))) / bmp->db_agwidth;
 	ti = bmp->db_agstart + bmp->db_agwidth * (agno & (agperlev - 1));
 
+	if (ti < 0 || ti >= le32_to_cpu(dcp->nleafs)) {
+		jfs_error(bmp->db_ipbmap->i_sb, "Corrupt dmapctl page\n");
+		release_metapage(mp);
+		return -EIO;
+	}
+
 	/* dmap control page trees fan-out by 4 and a single allocation
 	 * group may be described by 1 or 2 subtrees within the ag level
 	 * dmap control page, depending upon the ag size. examine the ag's
@@ -1875,8 +1881,10 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno, s64 * results)
 			return -EIO;
 		dp = (struct dmap *) mp->data;
 
-		if (dp->tree.budmin < 0)
+		if (dp->tree.budmin < 0) {
+			release_metapage(mp);
 			return -EIO;
+		}
 
 		/* try to allocate the blocks.
 		 */
diff --git a/fs/namespace.c b/fs/namespace.c
index ee5a87061f20..c87f847c959d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2210,6 +2210,19 @@ static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
 	return attach_recursive_mnt(mnt, p, mp, false);
 }
 
+static int may_change_propagation(const struct mount *m)
+{
+        struct mnt_namespace *ns = m->mnt_ns;
+
+	 // it must be mounted in some namespace
+	 if (IS_ERR_OR_NULL(ns))         // is_mounted()
+		 return -EINVAL;
+	 // and the caller must be admin in userns of that namespace
+	 if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
+		 return -EPERM;
+	 return 0;
+}
+
 /*
  * Sanity check the flags to change_mnt_propagation.
  */
@@ -2246,10 +2259,10 @@ static int do_change_type(struct path *path, int ms_flags)
 		return -EINVAL;
 
 	namespace_lock();
-	if (!check_mnt(mnt)) {
-		err = -EINVAL;
+	err = may_change_propagation(mnt);
+	if (err)
 		goto out_unlock;
-	}
+
 	if (type == MS_SHARED) {
 		err = invent_group_ids(mnt, recurse);
 		if (err)
@@ -2624,6 +2637,71 @@ static bool check_for_nsfs_mounts(struct mount *subtree)
 	return ret;
 }
 
+static int do_set_group(struct path *from_path, struct path *to_path)
+{
+	struct mount *from, *to;
+	int err;
+
+	from = real_mount(from_path->mnt);
+	to = real_mount(to_path->mnt);
+
+	namespace_lock();
+
+	err = may_change_propagation(from);
+	if (err)
+		goto out;
+	err = may_change_propagation(to);
+	if (err)
+		goto out;
+
+	err = -EINVAL;
+	/* To and From paths should be mount roots */
+	if (from_path->dentry != from_path->mnt->mnt_root)
+		goto out;
+	if (to_path->dentry != to_path->mnt->mnt_root)
+		goto out;
+
+	/* Setting sharing groups is only allowed across same superblock */
+	if (from->mnt.mnt_sb != to->mnt.mnt_sb)
+		goto out;
+
+	/* From mount root should be wider than To mount root */
+	if (!is_subdir(to->mnt.mnt_root, from->mnt.mnt_root))
+		goto out;
+
+	/* From mount should not have locked children in place of To's root */
+	if (has_locked_children(from, to->mnt.mnt_root))
+		goto out;
+
+	/* Setting sharing groups is only allowed on private mounts */
+	if (IS_MNT_SHARED(to) || IS_MNT_SLAVE(to))
+		goto out;
+
+	/* From should not be private */
+	if (!IS_MNT_SHARED(from) && !IS_MNT_SLAVE(from))
+		goto out;
+
+	if (IS_MNT_SLAVE(from)) {
+		struct mount *m = from->mnt_master;
+
+		list_add(&to->mnt_slave, &m->mnt_slave_list);
+		to->mnt_master = m;
+	}
+
+	if (IS_MNT_SHARED(from)) {
+		to->mnt_group_id = from->mnt_group_id;
+		list_add(&to->mnt_share, &from->mnt_share);
+		lock_mount_hash();
+		set_mnt_shared(to);
+		unlock_mount_hash();
+	}
+
+	err = 0;
+out:
+	namespace_unlock();
+	return err;
+}
+
 static int do_move_mount(struct path *old_path, struct path *new_path)
 {
 	struct mnt_namespace *ns;
@@ -3583,7 +3661,10 @@ SYSCALL_DEFINE5(move_mount,
 	if (ret < 0)
 		goto out_to;
 
-	ret = do_move_mount(&from_path, &to_path);
+	if (flags & MOVE_MOUNT_SET_GROUP)
+		ret = do_set_group(&from_path, &to_path);
+	else
+		ret = do_move_mount(&from_path, &to_path);
 
 out_to:
 	path_put(&to_path);
diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 9f10b90debec..4f929134fc63 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -171,8 +171,8 @@ do_add_page_to_bio(struct bio *bio, int npg, int rw, sector_t isect,
 
 	/* limit length to what the device mapping allows */
 	end = disk_addr + *len;
-	if (end >= map->start + map->len)
-		*len = map->start + map->len - disk_addr;
+	if (end >= map->disk_offset + map->len)
+		*len = map->disk_offset + map->len - disk_addr;
 
 retry:
 	if (!bio) {
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 6e3a14fdff9c..007d68a3a616 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -199,10 +199,11 @@ static bool bl_map_stripe(struct pnfs_block_dev *dev, u64 offset,
 	struct pnfs_block_dev *child;
 	u64 chunk;
 	u32 chunk_idx;
+	u64 disk_chunk;
 	u64 disk_offset;
 
 	chunk = div_u64(offset, dev->chunk_size);
-	div_u64_rem(chunk, dev->nr_children, &chunk_idx);
+	disk_chunk = div_u64_rem(chunk, dev->nr_children, &chunk_idx);
 
 	if (chunk_idx >= dev->nr_children) {
 		dprintk("%s: invalid chunk idx %d (%lld/%lld)\n",
@@ -215,7 +216,7 @@ static bool bl_map_stripe(struct pnfs_block_dev *dev, u64 offset,
 	offset = chunk * dev->chunk_size;
 
 	/* disk offset of the stripe */
-	disk_offset = div_u64(offset, dev->nr_children);
+	disk_offset = disk_chunk * dev->chunk_size;
 
 	child = &dev->children[chunk_idx];
 	child->map(child, disk_offset, map);
diff --git a/fs/nfs/blocklayout/extent_tree.c b/fs/nfs/blocklayout/extent_tree.c
index 7a57ff2528af..055ec818eaaa 100644
--- a/fs/nfs/blocklayout/extent_tree.c
+++ b/fs/nfs/blocklayout/extent_tree.c
@@ -552,6 +552,15 @@ static int ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
 	return ret;
 }
 
+/**
+ * ext_tree_prepare_commit - encode extents that need to be committed
+ * @arg: layout commit data
+ *
+ * Return values:
+ *   %0: Success, all required extents are encoded
+ *   %-ENOSPC: Some extents are encoded, but not all, due to RPC size limit
+ *   %-ENOMEM: Out of memory, extents not encoded
+ */
 int
 ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 {
@@ -568,12 +577,12 @@ ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 	start_p = page_address(arg->layoutupdate_page);
 	arg->layoutupdate_pages = &arg->layoutupdate_page;
 
-retry:
-	ret = ext_tree_encode_commit(bl, start_p + 1, buffer_size, &count, &arg->lastbytewritten);
+	ret = ext_tree_encode_commit(bl, start_p + 1, buffer_size,
+			&count, &arg->lastbytewritten);
 	if (unlikely(ret)) {
 		ext_tree_free_commitdata(arg, buffer_size);
 
-		buffer_size = ext_tree_layoutupdate_size(bl, count);
+		buffer_size = NFS_SERVER(arg->inode)->wsize;
 		count = 0;
 
 		arg->layoutupdate_pages =
@@ -588,7 +597,8 @@ ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 			return -ENOMEM;
 		}
 
-		goto retry;
+		ret = ext_tree_encode_commit(bl, start_p + 1, buffer_size,
+				&count, &arg->lastbytewritten);
 	}
 
 	*start_p = cpu_to_be32(count);
@@ -608,7 +618,7 @@ ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 	}
 
 	dprintk("%s found %zu ranges\n", __func__, count);
-	return 0;
+	return ret;
 }
 
 void
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 323cef064f2a..bdece12af53e 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -646,6 +646,42 @@ struct nfs_client *nfs_init_client(struct nfs_client *clp,
 }
 EXPORT_SYMBOL_GPL(nfs_init_client);
 
+static void nfs4_server_set_init_caps(struct nfs_server *server)
+{
+#if IS_ENABLED(CONFIG_NFS_V4)
+	/* Set the basic capabilities */
+	server->caps = server->nfs_client->cl_mvops->init_caps;
+	if (server->flags & NFS_MOUNT_NORDIRPLUS)
+		server->caps &= ~NFS_CAP_READDIRPLUS;
+
+	/*
+	 * Don't use NFS uid/gid mapping if we're using AUTH_SYS or lower
+	 * authentication.
+	 */
+	if (nfs4_disable_idmapping &&
+	    server->client->cl_auth->au_flavor == RPC_AUTH_UNIX)
+		server->caps |= NFS_CAP_UIDGID_NOMAP;
+#endif
+}
+
+void nfs_server_set_init_caps(struct nfs_server *server)
+{
+	switch (server->nfs_client->rpc_ops->version) {
+	case 2:
+		server->caps = NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS;
+		break;
+	case 3:
+		server->caps = NFS_CAP_HARDLINKS | NFS_CAP_SYMLINKS;
+		if (!(server->flags & NFS_MOUNT_NORDIRPLUS))
+			server->caps |= NFS_CAP_READDIRPLUS;
+		break;
+	default:
+		nfs4_server_set_init_caps(server);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(nfs_server_set_init_caps);
+
 /*
  * Create a version 2 or 3 client
  */
@@ -683,9 +719,6 @@ static int nfs_init_server(struct nfs_server *server,
 	/* Initialise the client representation from the mount data */
 	server->flags = data->flags;
 	server->options = data->options;
-	server->caps |= NFS_CAP_HARDLINKS|NFS_CAP_SYMLINKS|NFS_CAP_FILEID|
-		NFS_CAP_MODE|NFS_CAP_NLINK|NFS_CAP_OWNER|NFS_CAP_OWNER_GROUP|
-		NFS_CAP_ATIME|NFS_CAP_CTIME|NFS_CAP_MTIME;
 
 	if (data->rsize)
 		server->rsize = nfs_block_size(data->rsize, NULL);
@@ -710,6 +743,8 @@ static int nfs_init_server(struct nfs_server *server,
 	if (error < 0)
 		goto error;
 
+	nfs_server_set_init_caps(server);
+
 	/* Preserve the values of mount_server-related mount options */
 	if (data->mount_server.addrlen) {
 		memcpy(&server->mountd_address, &data->mount_server.address,
@@ -834,7 +869,6 @@ void nfs_server_copy_userdata(struct nfs_server *target, struct nfs_server *sour
 	target->acregmax = source->acregmax;
 	target->acdirmin = source->acdirmin;
 	target->acdirmax = source->acdirmax;
-	target->caps = source->caps;
 	target->options = source->options;
 	target->auth_info = source->auth_info;
 	target->port = source->port;
@@ -1042,6 +1076,8 @@ struct nfs_server *nfs_clone_server(struct nfs_server *source,
 	if (error < 0)
 		goto out_free_server;
 
+	nfs_server_set_init_caps(server);
+
 	/* probe the filesystem info for this server filesystem */
 	error = nfs_probe_fsinfo(server, fh, fattr_fsinfo);
 	if (error < 0)
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 0682037f972b..982f0eeac3df 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -700,7 +700,7 @@ static void nfs_direct_commit_complete(struct nfs_commit_data *data)
 		nfs_unlock_and_release_request(req);
 	}
 
-	if (atomic_dec_and_test(&cinfo.mds->rpcs_out))
+	if (nfs_commit_end(cinfo.mds))
 		nfs_direct_write_complete(dreq);
 }
 
@@ -727,10 +727,17 @@ static void nfs_direct_commit_schedule(struct nfs_direct_req *dreq)
 	LIST_HEAD(mds_list);
 
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
+	nfs_commit_begin(cinfo.mds);
 	nfs_scan_commit(dreq->inode, &mds_list, &cinfo);
 	res = nfs_generic_commit_list(dreq->inode, &mds_list, 0, &cinfo);
-	if (res < 0) /* res == -ENOMEM */
-		nfs_direct_write_reschedule(dreq);
+	if (res < 0) { /* res == -ENOMEM */
+		spin_lock(&dreq->lock);
+		if (dreq->flags == 0)
+			dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
+		spin_unlock(&dreq->lock);
+	}
+	if (nfs_commit_end(cinfo.mds))
+		nfs_direct_write_complete(dreq);
 }
 
 static void nfs_direct_write_schedule_work(struct work_struct *work)
diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index deecb67638aa..97b6fa0adb57 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -67,14 +67,21 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
 	struct nfs4_label *label = NULL;
 	struct nfs_fattr *fattr = NULL;
 	struct nfs_fh *server_fh = nfs_exp_embedfh(fid->raw);
-	size_t fh_size = offsetof(struct nfs_fh, data) + server_fh->size;
+	size_t fh_size = offsetof(struct nfs_fh, data);
 	const struct nfs_rpc_ops *rpc_ops;
 	struct dentry *dentry;
 	struct inode *inode;
-	int len = EMBED_FH_OFF + XDR_QUADLEN(fh_size);
+	int len = EMBED_FH_OFF;
 	u32 *p = fid->raw;
 	int ret;
 
+	/* Initial check of bounds */
+	if (fh_len < len + XDR_QUADLEN(fh_size) ||
+	    fh_len > XDR_QUADLEN(NFS_MAXFHSIZE))
+		return NULL;
+	/* Calculate embedded filehandle size */
+	fh_size += server_fh->size;
+	len += XDR_QUADLEN(fh_size);
 	/* NULL translates to ESTALE */
 	if (fh_len < len || fh_type != len)
 		return NULL;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 0dc53732b5c9..4f0d2fc810e4 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1869,7 +1869,11 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	nfs_wcc_update_inode(inode, fattr);
 
 	if (pnfs_layoutcommit_outstanding(inode)) {
-		nfsi->cache_validity |= save_cache_validity & NFS_INO_INVALID_ATTR;
+		nfsi->cache_validity |=
+			save_cache_validity &
+			(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
+			 NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
+			 NFS_INO_REVAL_FORCED);
 		cache_revalidated = false;
 	}
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index bfb53756654d..46fc42d575ce 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -172,6 +172,7 @@ nfs4_find_client_sessionid(struct net *, const struct sockaddr *,
 				struct nfs4_sessionid *, u32);
 extern struct nfs_server *nfs_create_server(struct nfs_mount_info *,
 					struct nfs_subversion *);
+extern void nfs_server_set_init_caps(struct nfs_server *);
 extern struct nfs_server *nfs4_create_server(
 					struct nfs_mount_info *,
 					struct nfs_subversion *);
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 1f4bdcda3fda..eeab44727a76 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -1011,18 +1011,7 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 	if (error < 0)
 		goto out;
 
-	/* Set the basic capabilities */
-	server->caps |= server->nfs_client->cl_mvops->init_caps;
-	if (server->flags & NFS_MOUNT_NORDIRPLUS)
-			server->caps &= ~NFS_CAP_READDIRPLUS;
-	/*
-	 * Don't use NFS uid/gid mapping if we're using AUTH_SYS or lower
-	 * authentication.
-	 */
-	if (nfs4_disable_idmapping &&
-			server->client->cl_auth->au_flavor == RPC_AUTH_UNIX)
-		server->caps |= NFS_CAP_UIDGID_NOMAP;
-
+	nfs_server_set_init_caps(server);
 
 	/* Probe the root fh to retrieve its FSID and filehandle */
 	error = nfs4_get_rootfh(server, mntfh, auth_probe);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3477da3c2190..5f8de86b2798 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -282,7 +282,7 @@ const u32 nfs4_fs_locations_bitmap[3] = {
 };
 
 static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
-		struct inode *inode)
+				    struct inode *inode, unsigned long flags)
 {
 	unsigned long cache_validity;
 
@@ -290,22 +290,19 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 	if (!inode || !nfs4_have_delegation(inode, FMODE_READ))
 		return;
 
-	cache_validity = READ_ONCE(NFS_I(inode)->cache_validity);
-	if (!(cache_validity & NFS_INO_REVAL_FORCED))
-		cache_validity &= ~(NFS_INO_INVALID_CHANGE
-				| NFS_INO_INVALID_SIZE);
+	cache_validity = READ_ONCE(NFS_I(inode)->cache_validity) | flags;
 
+	/* Remove the attributes over which we have full control */
+	dst[1] &= ~FATTR4_WORD1_RAWDEV;
 	if (!(cache_validity & NFS_INO_INVALID_SIZE))
 		dst[0] &= ~FATTR4_WORD0_SIZE;
 
 	if (!(cache_validity & NFS_INO_INVALID_CHANGE))
 		dst[0] &= ~FATTR4_WORD0_CHANGE;
-}
 
-static void nfs4_bitmap_copy_adjust_setattr(__u32 *dst,
-		const __u32 *src, struct inode *inode)
-{
-	nfs4_bitmap_copy_adjust(dst, src, inode);
+	if (!(cache_validity & NFS_INO_INVALID_OTHER))
+		dst[1] &= ~(FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER |
+			    FATTR4_WORD1_OWNER_GROUP);
 }
 
 static void nfs4_setup_readdir(u64 cookie, __be32 *verifier, struct dentry *dentry,
@@ -3333,12 +3330,15 @@ static int nfs4_do_setattr(struct inode *inode, const struct cred *cred,
 		.inode = inode,
 		.stateid = &arg.stateid,
 	};
+	unsigned long adjust_flags = NFS_INO_INVALID_CHANGE;
 	int err;
 
+	if (sattr->ia_valid & (ATTR_MODE|ATTR_UID|ATTR_GID))
+		adjust_flags |= NFS_INO_INVALID_OTHER;
+
 	do {
-		nfs4_bitmap_copy_adjust_setattr(bitmask,
-				nfs4_bitmask(server, olabel),
-				inode);
+		nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, olabel),
+					inode, adjust_flags);
 
 		err = _nfs4_do_setattr(inode, &arg, &res, cred, ctx);
 		switch (err) {
@@ -3884,6 +3884,8 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 		.interruptible = true,
 	};
 	int err;
+
+	nfs_server_set_init_caps(server);
 	do {
 		err = nfs4_handle_exception(server,
 				_nfs4_server_capabilities(server, fhandle),
@@ -4143,8 +4145,7 @@ static int _nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 		.rpc_resp = &res,
 	};
 
-	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, label), inode);
-
+	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, label), inode, 0);
 	nfs_fattr_init(fattr);
 	return nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 }
@@ -4732,8 +4733,8 @@ static int _nfs4_proc_link(struct inode *inode, struct inode *dir, const struct
 	}
 
 	nfs4_inode_make_writeable(inode);
-	nfs4_bitmap_copy_adjust_setattr(bitmask, nfs4_bitmask(server, res.label), inode);
-
+	nfs4_bitmap_copy_adjust(bitmask, nfs4_bitmask(server, res.label), inode,
+				NFS_INO_INVALID_CHANGE);
 	status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
 	if (!status) {
 		update_changeattr(dir, &res.cinfo, res.fattr->time_start, 0);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index d91576a587e4..992cdac8dbe9 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -3047,6 +3047,7 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	loff_t end_pos;
 	int status;
+	bool mark_as_dirty = false;
 
 	if (!pnfs_layoutcommit_outstanding(inode))
 		return 0;
@@ -3098,19 +3099,23 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 	if (ld->prepare_layoutcommit) {
 		status = ld->prepare_layoutcommit(&data->args);
 		if (status) {
-			put_cred(data->cred);
+			if (status != -ENOSPC)
+				put_cred(data->cred);
 			spin_lock(&inode->i_lock);
 			set_bit(NFS_INO_LAYOUTCOMMIT, &nfsi->flags);
 			if (end_pos > nfsi->layout->plh_lwb)
 				nfsi->layout->plh_lwb = end_pos;
-			goto out_unlock;
+			if (status != -ENOSPC)
+				goto out_unlock;
+			spin_unlock(&inode->i_lock);
+			mark_as_dirty = true;
 		}
 	}
 
 
 	status = nfs4_proc_layoutcommit(data, sync);
 out:
-	if (status)
+	if (status || mark_as_dirty)
 		mark_inode_dirty_sync(inode);
 	dprintk("<-- %s status %d\n", __func__, status);
 	return status;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 10ce264a6456..f3c672b11c4f 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1653,15 +1653,18 @@ static int wait_on_commit(struct nfs_mds_commit_info *cinfo)
 				       !atomic_read(&cinfo->rpcs_out));
 }
 
-static void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
+void nfs_commit_begin(struct nfs_mds_commit_info *cinfo)
 {
 	atomic_inc(&cinfo->rpcs_out);
 }
 
-static void nfs_commit_end(struct nfs_mds_commit_info *cinfo)
+bool nfs_commit_end(struct nfs_mds_commit_info *cinfo)
 {
-	if (atomic_dec_and_test(&cinfo->rpcs_out))
+	if (atomic_dec_and_test(&cinfo->rpcs_out)) {
 		wake_up_var(&cinfo->rpcs_out);
+		return true;
+	}
+	return false;
 }
 
 void nfs_commitdata_release(struct nfs_commit_data *data)
@@ -1756,6 +1759,7 @@ void nfs_init_commit(struct nfs_commit_data *data,
 	data->res.fattr   = &data->fattr;
 	data->res.verf    = &data->verf;
 	nfs_fattr_init(&data->fattr);
+	nfs_commit_begin(cinfo->mds);
 }
 EXPORT_SYMBOL_GPL(nfs_init_commit);
 
@@ -1801,7 +1805,6 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 
 	/* Set up the argument struct */
 	nfs_init_commit(data, head, NULL, cinfo);
-	atomic_inc(&cinfo->mds->rpcs_out);
 	return nfs_initiate_commit(NFS_CLIENT(inode), data, NFS_PROTO(inode),
 				   data->mds_ops, how, 0);
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a3f8660803c7..933de78918e3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3956,10 +3956,16 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 	}
 	status = nfs_ok;
 	if (conf) { /* case 1: callback update */
-		old = unconf;
-		unhash_client_locked(old);
-		nfsd4_change_callback(conf, &unconf->cl_cb_conn);
-	} else { /* case 3: normal case; new or rebooted client */
+		if (get_client_locked(conf) == nfs_ok) {
+			old = unconf;
+			unhash_client_locked(old);
+			nfsd4_change_callback(conf, &unconf->cl_cb_conn);
+		} else {
+			conf = NULL;
+		}
+	}
+
+	if (!conf) { /* case 3: normal case; new or rebooted client */
 		old = find_confirmed_client_by_name(&unconf->cl_name, nn);
 		if (old) {
 			status = nfserr_clid_inuse;
@@ -3975,10 +3981,14 @@ nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 				goto out;
 			}
 		}
+		status = get_client_locked(unconf);
+		if (status != nfs_ok) {
+			old = NULL;
+			goto out;
+		}
 		move_to_confirmed(unconf);
 		conf = unconf;
 	}
-	get_client_locked(conf);
 	spin_unlock(&nn->client_lock);
 	nfsd4_probe_callback(conf);
 	spin_lock(&nn->client_lock);
@@ -5081,6 +5091,20 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 		status = nfs4_check_deleg(cl, open, &dp);
 		if (status)
 			goto out;
+		if (dp && nfsd4_is_deleg_cur(open) &&
+				(dp->dl_stid.sc_file != fp)) {
+			/*
+			 * RFC8881 section 8.2.4 mandates the server to return
+			 * NFS4ERR_BAD_STATEID if the selected table entry does
+			 * not match the current filehandle. However returning
+			 * NFS4ERR_BAD_STATEID in the OPEN can cause the client
+			 * to repeatedly retry the operation with the same
+			 * stateid, since the stateid itself is valid. To avoid
+			 * this situation NFSD returns NFS4ERR_INVAL instead.
+			 */
+			status = nfserr_inval;
+			goto out;
+		}
 		stp = nfsd4_find_and_lock_existing_open(fp, open);
 	} else {
 		open->op_file = NULL;
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 7e4edc588d62..fa050a01577d 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -525,11 +525,18 @@ static int __nilfs_read_inode(struct super_block *sb,
 		inode->i_op = &nilfs_symlink_inode_operations;
 		inode_nohighmem(inode);
 		inode->i_mapping->a_ops = &nilfs_aops;
-	} else {
+	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		inode->i_op = &nilfs_special_inode_operations;
 		init_special_inode(
 			inode, inode->i_mode,
 			huge_decode_dev(le64_to_cpu(raw_inode->i_device_code)));
+	} else {
+		nilfs_error(sb,
+			    "invalid file type bits in mode 0%o for inode %lu",
+			    inode->i_mode, ino);
+		err = -EIO;
+		goto failed_unmap;
 	}
 	nilfs_ifile_unmap_inode(root->ifile, ino, bh);
 	brelse(bh);
diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index fa41db088488..cd4bfd92ebd6 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -354,7 +354,7 @@ static ssize_t orangefs_debug_read(struct file *file,
 		goto out;
 
 	mutex_lock(&orangefs_debug_lock);
-	sprintf_ret = sprintf(buf, "%s", (char *)file->private_data);
+	sprintf_ret = scnprintf(buf, ORANGEFS_MAX_DEBUG_STRING_LEN, "%s", (char *)file->private_data);
 	mutex_unlock(&orangefs_debug_lock);
 
 	read_ret = simple_read_from_buffer(ubuf, count, ppos, buf, sprintf_ret);
@@ -728,8 +728,8 @@ static void do_k_string(void *k_mask, int index)
 
 	if (*mask & s_kmod_keyword_mask_map[index].mask_val) {
 		if ((strlen(kernel_debug_string) +
-		     strlen(s_kmod_keyword_mask_map[index].keyword))
-			< ORANGEFS_MAX_DEBUG_STRING_LEN - 1) {
+		     strlen(s_kmod_keyword_mask_map[index].keyword) + 1)
+			< ORANGEFS_MAX_DEBUG_STRING_LEN) {
 				strcat(kernel_debug_string,
 				       s_kmod_keyword_mask_map[index].keyword);
 				strcat(kernel_debug_string, ",");
@@ -756,7 +756,7 @@ static void do_c_string(void *c_mask, int index)
 	    (mask->mask2 & cdm_array[index].mask2)) {
 		if ((strlen(client_debug_string) +
 		     strlen(cdm_array[index].keyword) + 1)
-			< ORANGEFS_MAX_DEBUG_STRING_LEN - 2) {
+			< ORANGEFS_MAX_DEBUG_STRING_LEN) {
 				strcat(client_debug_string,
 				       cdm_array[index].keyword);
 				strcat(client_debug_string, ",");
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 545207683ddd..702d7d298695 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -74,10 +74,15 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	unsigned short flags;
 	unsigned int fragments;
 	u64 lookup_table_start, xattr_id_table_start, next_table;
-	int err;
+	int err, devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
 
 	TRACE("Entered squashfs_fill_superblock\n");
 
+	if (!devblksize) {
+		errorf(fc, "squashfs: unable to set blocksize\n");
+		return -EINVAL;
+	}
+
 	sb->s_fs_info = kzalloc(sizeof(*msblk), GFP_KERNEL);
 	if (sb->s_fs_info == NULL) {
 		ERROR("Failed to allocate squashfs_sb_info\n");
@@ -85,12 +90,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	msblk = sb->s_fs_info;
 
-	msblk->devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
-	if (!msblk->devblksize) {
-		errorf(fc, "squashfs: unable to set blocksize\n");
-		return -EINVAL;
-	}
-
+	msblk->devblksize = devblksize;
 	msblk->devblksize_log2 = ffz(~msblk->devblksize);
 
 	mutex_init(&msblk->meta_index_mutex);
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 9f2de5e7c6e1..361bc8acfb0f 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1417,7 +1417,7 @@ static int udf_load_logicalvol(struct super_block *sb, sector_t block,
 	struct genericPartitionMap *gpm;
 	uint16_t ident;
 	struct buffer_head *bh;
-	unsigned int table_len;
+	unsigned int table_len, part_map_count;
 	int ret;
 
 	bh = udf_read_tagged(sb, block, block, &ident);
@@ -1438,7 +1438,16 @@ static int udf_load_logicalvol(struct super_block *sb, sector_t block,
 					   "logical volume");
 	if (ret)
 		goto out_bh;
-	ret = udf_sb_alloc_partition_maps(sb, le32_to_cpu(lvd->numPartitionMaps));
+
+	part_map_count = le32_to_cpu(lvd->numPartitionMaps);
+	if (part_map_count > table_len / sizeof(struct genericPartitionMap1)) {
+		udf_err(sb, "error loading logical volume descriptor: "
+			"Too many partition maps (%u > %u)\n", part_map_count,
+			table_len / (unsigned)sizeof(struct genericPartitionMap1));
+		ret = -EIO;
+		goto out_bh;
+	}
+	ret = udf_sb_alloc_partition_maps(sb, part_map_count);
 	if (ret)
 		goto out_bh;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d3648a55590c..c5985d72d60e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -430,7 +430,7 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
  * @host: Owner, either the inode or the block_device.
  * @i_pages: Cached pages.
  * @gfp_mask: Memory allocation flags to use for allocating pages.
- * @i_mmap_writable: Number of VM_SHARED mappings.
+ * @i_mmap_writable: Number of VM_SHARED, VM_MAYWRITE mappings.
  * @nr_thps: Number of THPs in the pagecache (non-shmem only).
  * @i_mmap: Tree of private and shared mappings.
  * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
@@ -553,7 +553,7 @@ static inline int mapping_mapped(struct address_space *mapping)
 
 /*
  * Might pages of this file have been modified in userspace?
- * Note that i_mmap_writable counts all VM_SHARED vmas: do_mmap_pgoff
+ * Note that i_mmap_writable counts all VM_SHARED, VM_MAYWRITE vmas: do_mmap_pgoff
  * marks vma as VM_SHARED if it is shared, and the file was opened for
  * writing i.e. vma may be mprotected writable even if now readonly.
  *
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index b3dae069bcd9..52ce74226ba2 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -240,19 +240,19 @@ vlan_for_each(struct net_device *dev,
 
 static inline struct net_device *vlan_dev_real_dev(const struct net_device *dev)
 {
-	BUG();
+	WARN_ON_ONCE(1);
 	return NULL;
 }
 
 static inline u16 vlan_dev_vlan_id(const struct net_device *dev)
 {
-	BUG();
+	WARN_ON_ONCE(1);
 	return 0;
 }
 
 static inline __be16 vlan_dev_vlan_proto(const struct net_device *dev)
 {
-	BUG();
+	WARN_ON_ONCE(1);
 	return 0;
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4d3657b630db..57cba6e4fdcd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -549,6 +549,17 @@ static inline bool vma_is_anonymous(struct vm_area_struct *vma)
 	return !vma->vm_ops;
 }
 
+static inline bool is_shared_maywrite(vm_flags_t vm_flags)
+{
+	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
+		(VM_SHARED | VM_MAYWRITE);
+}
+
+static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
+{
+	return is_shared_maywrite(vma->vm_flags);
+}
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
@@ -2935,25 +2946,26 @@ static inline int pages_identical(struct page *page1, struct page *page2)
 }
 
 /**
- * seal_check_future_write - Check for F_SEAL_FUTURE_WRITE flag and handle it
+ * seal_check_write - Check for F_SEAL_WRITE or F_SEAL_FUTURE_WRITE flags and
+ *                    handle them.
  * @seals: the seals to check
  * @vma: the vma to operate on
  *
- * Check whether F_SEAL_FUTURE_WRITE is set; if so, do proper check/handling on
- * the vma flags.  Return 0 if check pass, or <0 for errors.
+ * Check whether F_SEAL_WRITE or F_SEAL_FUTURE_WRITE are set; if so, do proper
+ * check/handling on the vma flags.  Return 0 if check pass, or <0 for errors.
  */
-static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
+static inline int seal_check_write(int seals, struct vm_area_struct *vma)
 {
-	if (seals & F_SEAL_FUTURE_WRITE) {
+	if (seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
 		/*
 		 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
-		 * "future write" seal active.
+		 * write seals are active.
 		 */
 		if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
 			return -EPERM;
 
 		/*
-		 * Since an F_SEAL_FUTURE_WRITE sealed memfd can be mapped as
+		 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
 		 * MAP_SHARED and read-only, take care to not allow mprotect to
 		 * revert protections on such mappings. Do this only for shared
 		 * mappings. For private mappings, don't need to mask
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 4d5a851cafe8..6e9062caa7df 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -214,10 +214,9 @@ struct kparam_array
 #define __moduleparam_const const
 #endif
 
-/* This is the fundamental function for registering boot/module
-   parameters. */
+/* This is the fundamental function for registering boot/module parameters. */
 #define __module_param_call(prefix, name, ops, arg, perm, level, flags)	\
-	/* Default value instead of permissions? */			\
+	static_assert(sizeof(""prefix) - 1 <= MAX_PARAM_PREFIX_LEN);	\
 	static const char __param_str_##name[] = prefix #name;		\
 	static struct kernel_param __moduleparam_const __param_##name	\
 	__used								\
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 49cf5c855cbe..b2b441f3572b 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -549,6 +549,8 @@ extern int nfs_wb_page_cancel(struct inode *inode, struct page* page);
 extern int  nfs_commit_inode(struct inode *, int);
 extern struct nfs_commit_data *nfs_commitdata_alloc(bool never_fail);
 extern void nfs_commit_free(struct nfs_commit_data *data);
+void nfs_commit_begin(struct nfs_mds_commit_info *cinfo);
+bool nfs_commit_end(struct nfs_mds_commit_info *cinfo);
 
 static inline int
 nfs_have_writebacks(struct inode *inode)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f2f92eb950cc..d24d709e5625 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -415,6 +415,7 @@ struct pci_dev {
 	unsigned int	is_virtfn:1;
 	unsigned int	reset_fn:1;
 	unsigned int	is_hotplug_bridge:1;
+	unsigned int	is_pciehp:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
 	/*
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index c7abce28ed29..aab0aebb529e 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -52,6 +52,7 @@ struct pps_device {
 	int current_mode;			/* PPS mode at event time */
 
 	unsigned int last_ev;			/* last PPS event id */
+	unsigned int last_fetched_ev;		/* last fetched PPS event id */
 	wait_queue_head_t queue;		/* PPS event queue */
 
 	unsigned int id;			/* PPS source unique ID */
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4edce28fb454..101ac3d6581e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2493,6 +2493,29 @@ static inline void skb_reset_transport_header(struct sk_buff *skb)
 	skb->transport_header = skb->data - skb->head;
 }
 
+/**
+ * skb_reset_transport_header_careful - conditionally reset transport header
+ * @skb: buffer to alter
+ *
+ * Hardened version of skb_reset_transport_header().
+ *
+ * Returns: true if the operation was a success.
+ */
+static inline bool __must_check
+skb_reset_transport_header_careful(struct sk_buff *skb)
+{
+	long offset = skb->data - skb->head;
+
+	if (unlikely(offset != (typeof(skb->transport_header))offset))
+		return false;
+
+	if (unlikely(offset == (typeof(skb->transport_header))~0U))
+		return false;
+
+	skb->transport_header = offset;
+	return true;
+}
+
 static inline void skb_set_transport_header(struct sk_buff *skb,
 					    const int offset)
 {
@@ -3050,7 +3073,13 @@ static inline void *skb_frag_address(const skb_frag_t *frag)
  */
 static inline void *skb_frag_address_safe(const skb_frag_t *frag)
 {
-	void *ptr = page_address(skb_frag_page(frag));
+	struct page *page = skb_frag_page(frag);
+	void *ptr;
+
+	if (!page)
+		return NULL;
+
+	ptr = page_address(page);
 	if (unlikely(!ptr))
 		return NULL;
 
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index edd89b7c8f18..54167a2d28ea 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -67,6 +67,7 @@ struct ci_hdrc_platform_data {
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
 #define CI_HDRC_IMX_HSIC_ACTIVE_EVENT		2
 #define CI_HDRC_IMX_HSIC_SUSPEND_EVENT		3
+#define CI_HDRC_CONTROLLER_VBUS_EVENT		4
 	int	(*notify_event) (struct ci_hdrc *ci, unsigned event);
 	struct regulator	*reg_vbus;
 	struct usb_otg_caps	ci_otg_caps;
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index fc6ed1311589..83ca77818822 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -83,6 +83,7 @@ struct usbnet {
 #		define EVENT_LINK_CHANGE	11
 #		define EVENT_SET_RX_MODE	12
 #		define EVENT_NO_IP_ALIGN	13
+#		define EVENT_LINK_CARRIER_ON	14
 	u32			rx_speed;	/* in bps - NOT Mbps */
 	u32			tx_speed;	/* in bps - NOT Mbps */
 };
diff --git a/include/net/act_api.h b/include/net/act_api.h
index 4dabe4730f00..25d9a12118ba 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -186,6 +186,31 @@ int tcf_action_dump(struct sk_buff *skb, struct tc_action *actions[], int bind,
 		    int ref);
 int tcf_action_dump_old(struct sk_buff *skb, struct tc_action *a, int, int);
 int tcf_action_dump_1(struct sk_buff *skb, struct tc_action *a, int, int);
+
+static inline void tcf_action_update_bstats(struct tc_action *a,
+					    struct sk_buff *skb)
+{
+	bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), skb);
+}
+
+static inline struct gnet_stats_queue *
+tcf_action_get_qstats(struct tc_action *a)
+{
+	return this_cpu_ptr(a->cpu_qstats);
+}
+
+static inline void tcf_action_inc_drop_qstats(struct tc_action *a)
+{
+	qstats_drop_inc(this_cpu_ptr(a->cpu_qstats));
+}
+
+static inline void tcf_action_inc_overlimit_qstats(struct tc_action *a)
+{
+	qstats_overlimit_inc(this_cpu_ptr(a->cpu_qstats));
+}
+
+void tcf_action_update_stats(struct tc_action *a, u64 bytes, u32 packets,
+			     bool drop, bool hw);
 int tcf_action_copy_stats(struct sk_buff *, struct tc_action *, int);
 
 int tcf_action_check_ctrlact(int action, struct tcf_proto *tp,
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2dfa3331604e..3a550544dd9f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -433,7 +433,7 @@ ieee80211_get_sband_iftype_data(const struct ieee80211_supported_band *sband,
 {
 	int i;
 
-	if (WARN_ON(iftype >= NL80211_IFTYPE_MAX))
+	if (WARN_ON(iftype >= NUM_NL80211_IFTYPES))
 		return NULL;
 
 	if (iftype == NL80211_IFTYPE_AP_VLAN)
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 6d934ce54c8d..a9a68714b58f 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1320,19 +1320,6 @@ void mini_qdisc_pair_swap(struct mini_Qdisc_pair *miniqp,
 void mini_qdisc_pair_init(struct mini_Qdisc_pair *miniqp, struct Qdisc *qdisc,
 			  struct mini_Qdisc __rcu **p_miniq);
 
-static inline void skb_tc_reinsert(struct sk_buff *skb, struct tcf_result *res)
-{
-	struct gnet_stats_queue *stats = res->qstats;
-	int ret;
-
-	if (res->ingress)
-		ret = netif_receive_skb(skb);
-	else
-		ret = dev_queue_xmit(skb);
-	if (ret && stats)
-		qstats_overlimit_inc(res->qstats);
-}
-
 /* Make sure qdisc is no longer in SCHED state. */
 static inline void qdisc_synchronize(const struct Qdisc *q)
 {
diff --git a/include/net/udp.h b/include/net/udp.h
index 7323f72fed70..bab7b68c5f6d 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -471,6 +471,16 @@ static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
 {
 	netdev_features_t features = NETIF_F_SG;
 	struct sk_buff *segs;
+	int drop_count;
+
+	/*
+	 * Segmentation in UDP receive path is only for UDP GRO, drop udp
+	 * fragmentation offload (UFO) packets.
+	 */
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP) {
+		drop_count = 1;
+		goto drop;
+	}
 
 	/* Avoid csum recalculation by skb_segment unless userspace explicitly
 	 * asks for the final checksum values
@@ -494,16 +504,18 @@ static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
 	 */
 	segs = __skb_gso_segment(skb, features, false);
 	if (IS_ERR_OR_NULL(segs)) {
-		int segs_nr = skb_shinfo(skb)->gso_segs;
-
-		atomic_add(segs_nr, &sk->sk_drops);
-		SNMP_ADD_STATS(__UDPX_MIB(sk, ipv4), UDP_MIB_INERRORS, segs_nr);
-		kfree_skb(skb);
-		return NULL;
+		drop_count = skb_shinfo(skb)->gso_segs;
+		goto drop;
 	}
 
 	consume_skb(skb);
 	return segs;
+
+drop:
+	atomic_add(drop_count, &sk->sk_drops);
+	SNMP_ADD_STATS(__UDPX_MIB(sk, ipv4), UDP_MIB_INERRORS, drop_count);
+	kfree_skb(skb);
+	return NULL;
 }
 
 #endif	/* _UDP_H */
diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
index 9f2273a08356..acd32dc630c3 100644
--- a/include/uapi/linux/in6.h
+++ b/include/uapi/linux/in6.h
@@ -151,7 +151,6 @@ struct in6_flowlabel_req {
 /*
  *	IPV6 socket options
  */
-#if __UAPI_DEF_IPV6_OPTIONS
 #define IPV6_ADDRFORM		1
 #define IPV6_2292PKTINFO	2
 #define IPV6_2292HOPOPTS	3
@@ -168,8 +167,10 @@ struct in6_flowlabel_req {
 #define IPV6_MULTICAST_IF	17
 #define IPV6_MULTICAST_HOPS	18
 #define IPV6_MULTICAST_LOOP	19
+#if __UAPI_DEF_IPV6_OPTIONS
 #define IPV6_ADD_MEMBERSHIP	20
 #define IPV6_DROP_MEMBERSHIP	21
+#endif
 #define IPV6_ROUTER_ALERT	22
 #define IPV6_MTU_DISCOVER	23
 #define IPV6_MTU		24
@@ -201,7 +202,6 @@ struct in6_flowlabel_req {
 #define IPV6_IPSEC_POLICY	34
 #define IPV6_XFRM_POLICY	35
 #define IPV6_HDRINCL		36
-#endif
 
 /*
  * Multicast:
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index ea57526a5b89..1bad6701f2b2 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -23,7 +23,7 @@ struct io_uring_sqe {
 	__u64	addr;		/* pointer to buffer or iovecs */
 	__u32	len;		/* buffer size or number of iovecs */
 	union {
-		__kernel_rwf_t	rw_flags;
+		__u32		rw_flags;
 		__u32		fsync_flags;
 		__u16		poll_events;
 		__u32		sync_range_flags;
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 96a0240f23fe..535ca707dfd7 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -70,7 +70,8 @@
 #define MOVE_MOUNT_T_SYMLINKS		0x00000010 /* Follow symlinks on to path */
 #define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
 #define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
-#define MOVE_MOUNT__MASK		0x00000077
+#define MOVE_MOUNT_SET_GROUP		0x00000100 /* Set sharing group instead */
+#define MOVE_MOUNT__MASK		0x00000177
 
 /*
  * fsopen() flags.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ecae7c7f895b..6816507803fc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5789,11 +5789,21 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	ring_buffer_put(rb); /* could be last */
 }
 
+static int perf_mmap_may_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	/*
+	 * Forbid splitting perf mappings to prevent refcount leaks due to
+	 * the resulting non-matching offsets and sizes. See open()/close().
+	 */
+	return -EINVAL;
+}
+
 static const struct vm_operations_struct perf_mmap_vmops = {
 	.open		= perf_mmap_open,
 	.close		= perf_mmap_close, /* non mergeable */
 	.fault		= perf_mmap_fault,
 	.page_mkwrite	= perf_mmap_fault,
+	.split		= perf_mmap_may_split,
 };
 
 static int perf_mmap(struct file *file, struct vm_area_struct *vma)
@@ -5877,9 +5887,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			goto unlock;
 		}
 
-		atomic_set(&rb->aux_mmap_count, 1);
 		user_extra = nr_pages;
-
 		goto accounting;
 	}
 
@@ -5986,8 +5994,10 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	} else {
 		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
 				   event->attr.aux_watermark, flags);
-		if (!ret)
+		if (!ret) {
+			atomic_set(&rb->aux_mmap_count, 1);
 			rb->aux_mmap_locked = extra;
+		}
 	}
 
 unlock:
@@ -5997,11 +6007,15 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 		atomic_inc(&event->mmap_count);
 	} else if (rb) {
+		/* AUX allocation failed */
 		atomic_dec(&rb->mmap_count);
 	}
 aux_unlock:
 	mutex_unlock(&event->mmap_mutex);
 
+	if (ret)
+		return ret;
+
 	/*
 	 * Since pinned accounting is per vm we cannot allow fork() to copy our
 	 * vma.
diff --git a/kernel/fork.c b/kernel/fork.c
index e71f96bff1dc..ad3e6e91d828 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -566,7 +566,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			if (tmp->vm_flags & VM_DENYWRITE)
 				atomic_dec(&inode->i_writecount);
 			i_mmap_lock_write(mapping);
-			if (tmp->vm_flags & VM_SHARED)
+			if (vma_is_shared_maywrite(tmp))
 				atomic_inc(&mapping->i_mmap_writable);
 			flush_dcache_mmap_lock(mapping);
 			/* insert tmp into the share list, just after mpnt */
diff --git a/kernel/power/console.c b/kernel/power/console.c
index fcdf0e14a47d..19c48aa5355d 100644
--- a/kernel/power/console.c
+++ b/kernel/power/console.c
@@ -16,6 +16,7 @@
 #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
 
 static int orig_fgconsole, orig_kmsg;
+static bool vt_switch_done;
 
 static DEFINE_MUTEX(vt_switch_mutex);
 
@@ -136,17 +137,21 @@ void pm_prepare_console(void)
 	if (orig_fgconsole < 0)
 		return;
 
+	vt_switch_done = true;
+
 	orig_kmsg = vt_kmsg_redirect(SUSPEND_CONSOLE);
 	return;
 }
 
 void pm_restore_console(void)
 {
-	if (!pm_vt_switch())
+	if (!pm_vt_switch() && !vt_switch_done)
 		return;
 
 	if (orig_fgconsole >= 0) {
 		vt_move_to_console(orig_fgconsole, 0);
 		vt_kmsg_redirect(orig_kmsg);
 	}
+
+	vt_switch_done = false;
 }
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1d9f2831b54e..197fefa82d18 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -582,10 +582,13 @@ static void rcu_preempt_deferred_qs(struct task_struct *t)
  */
 static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 {
+	unsigned long flags;
 	struct rcu_data *rdp;
 
 	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
+	local_irq_save(flags);
 	rdp->defer_qs_iw_pending = false;
+	local_irq_restore(flags);
 }
 
 /*
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 03a14d939ac3..718291af1063 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3650,13 +3650,17 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 	        } else {
 			iter->hash = alloc_and_copy_ftrace_hash(size_bits, hash);
 		}
+	} else {
+		if (hash)
+			iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
+		else
+			iter->hash = EMPTY_HASH;
+	}
 
-		if (!iter->hash) {
-			trace_parser_put(&iter->parser);
-			goto out_unlock;
-		}
-	} else
-		iter->hash = hash;
+	if (!iter->hash) {
+		trace_parser_put(&iter->parser);
+		goto out_unlock;
+	}
 
 	ret = 0;
 
@@ -5117,9 +5121,6 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 		ret = ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
 						      iter->hash, filter_hash);
 		mutex_unlock(&ftrace_lock);
-	} else {
-		/* For read only, the hash is the ops hash */
-		iter->hash = NULL;
 	}
 
 	mutex_unlock(&iter->ops->func_hash->regex_lock);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 77df1e28fa32..eae997f277b6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2109,7 +2109,10 @@ __register_event(struct trace_event_call *call, struct module *mod)
 	if (ret < 0)
 		return ret;
 
+	down_write(&trace_event_sem);
 	list_add(&call->list, &ftrace_events);
+	up_write(&trace_event_sem);
+
 	call->mod = mod;
 
 	return 0;
@@ -2489,6 +2492,8 @@ __trace_add_event_dirs(struct trace_array *tr)
 	struct trace_event_call *call;
 	int ret;
 
+	lockdep_assert_held(&trace_event_sem);
+
 	list_for_each_entry(call, &ftrace_events, list) {
 		ret = __trace_add_new_event(call, tr);
 		if (ret < 0)
diff --git a/mm/filemap.c b/mm/filemap.c
index f1ed0400c37c..af3efb23262b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2876,7 +2876,7 @@ int generic_file_mmap(struct file * file, struct vm_area_struct * vma)
  */
 int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+	if (vma_is_shared_maywrite(vma))
 		return -EINVAL;
 	return generic_file_mmap(file, vma);
 }
diff --git a/mm/hmm.c b/mm/hmm.c
index 902f5fa6bf93..e0dccfc8db60 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -392,6 +392,7 @@ static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
 	return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline uint64_t pmd_to_hmm_pfn_flags(struct hmm_range *range, pmd_t pmd)
 {
 	if (pmd_protnone(pmd))
@@ -401,7 +402,6 @@ static inline uint64_t pmd_to_hmm_pfn_flags(struct hmm_range *range, pmd_t pmd)
 				range->flags[HMM_PFN_VALID];
 }
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 		unsigned long end, uint64_t *pfns, pmd_t pmd)
 {
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index d8cde7292bf9..a7fc6b23c37e 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -13,7 +13,7 @@
  *
  * The following locks and mutexes are used by kmemleak:
  *
- * - kmemleak_lock (rwlock): protects the object_list modifications and
+ * - kmemleak_lock (raw_spinlock_t): protects the object_list modifications and
  *   accesses to the object_tree_root. The object_list is the main list
  *   holding the metadata (struct kmemleak_object) for the allocated memory
  *   blocks. The object_tree_root is a red black tree used to look-up
@@ -22,13 +22,13 @@
  *   object_tree_root in the create_object() function called from the
  *   kmemleak_alloc() callback and removed in delete_object() called from the
  *   kmemleak_free() callback
- * - kmemleak_object.lock (spinlock): protects a kmemleak_object. Accesses to
- *   the metadata (e.g. count) are protected by this lock. Note that some
- *   members of this structure may be protected by other means (atomic or
- *   kmemleak_lock). This lock is also held when scanning the corresponding
- *   memory block to avoid the kernel freeing it via the kmemleak_free()
- *   callback. This is less heavyweight than holding a global lock like
- *   kmemleak_lock during scanning
+ * - kmemleak_object.lock (raw_spinlock_t): protects a kmemleak_object.
+ *   Accesses to the metadata (e.g. count) are protected by this lock. Note
+ *   that some members of this structure may be protected by other means
+ *   (atomic or kmemleak_lock). This lock is also held when scanning the
+ *   corresponding memory block to avoid the kernel freeing it via the
+ *   kmemleak_free() callback. This is less heavyweight than holding a global
+ *   lock like kmemleak_lock during scanning.
  * - scan_mutex (mutex): ensures that only one thread may scan the memory for
  *   unreferenced objects at a time. The gray_list contains the objects which
  *   are already referenced or marked as false positives and need to be
@@ -135,7 +135,7 @@ struct kmemleak_scan_area {
  * (use_count) and freed using the RCU mechanism.
  */
 struct kmemleak_object {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	unsigned int flags;		/* object status flags */
 	struct list_head object_list;
 	struct list_head gray_list;
@@ -191,8 +191,8 @@ static int mem_pool_free_count = ARRAY_SIZE(mem_pool);
 static LIST_HEAD(mem_pool_free_list);
 /* search tree for object boundaries */
 static struct rb_root object_tree_root = RB_ROOT;
-/* rw_lock protecting the access to object_list and object_tree_root */
-static DEFINE_RWLOCK(kmemleak_lock);
+/* protecting the access to object_list and object_tree_root */
+static DEFINE_RAW_SPINLOCK(kmemleak_lock);
 
 /* allocation caches for kmemleak internal data */
 static struct kmem_cache *object_cache;
@@ -417,6 +417,7 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
 {
 	unsigned long flags;
 	struct kmemleak_object *object;
+	bool warn = false;
 
 	/* try the slab allocator first */
 	if (object_cache) {
@@ -426,7 +427,7 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
 	}
 
 	/* slab allocation failed, try the memory pool */
-	write_lock_irqsave(&kmemleak_lock, flags);
+	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	object = list_first_entry_or_null(&mem_pool_free_list,
 					  typeof(*object), object_list);
 	if (object)
@@ -434,8 +435,10 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
 	else if (mem_pool_free_count)
 		object = &mem_pool[--mem_pool_free_count];
 	else
+		warn = true;
+	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
+	if (warn)
 		pr_warn_once("Memory pool empty, consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE\n");
-	write_unlock_irqrestore(&kmemleak_lock, flags);
 
 	return object;
 }
@@ -453,9 +456,9 @@ static void mem_pool_free(struct kmemleak_object *object)
 	}
 
 	/* add the object to the memory pool free list */
-	write_lock_irqsave(&kmemleak_lock, flags);
+	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	list_add(&object->object_list, &mem_pool_free_list);
-	write_unlock_irqrestore(&kmemleak_lock, flags);
+	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 }
 
 /*
@@ -514,9 +517,9 @@ static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
 	struct kmemleak_object *object;
 
 	rcu_read_lock();
-	read_lock_irqsave(&kmemleak_lock, flags);
+	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	object = lookup_object(ptr, alias);
-	read_unlock_irqrestore(&kmemleak_lock, flags);
+	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 
 	/* check whether the object is still available */
 	if (object && !get_object(object))
@@ -546,11 +549,11 @@ static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int ali
 	unsigned long flags;
 	struct kmemleak_object *object;
 
-	write_lock_irqsave(&kmemleak_lock, flags);
+	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	object = lookup_object(ptr, alias);
 	if (object)
 		__remove_object(object);
-	write_unlock_irqrestore(&kmemleak_lock, flags);
+	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 
 	return object;
 }
@@ -585,7 +588,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	INIT_LIST_HEAD(&object->object_list);
 	INIT_LIST_HEAD(&object->gray_list);
 	INIT_HLIST_HEAD(&object->area_list);
-	spin_lock_init(&object->lock);
+	raw_spin_lock_init(&object->lock);
 	atomic_set(&object->use_count, 1);
 	object->flags = OBJECT_ALLOCATED;
 	object->pointer = ptr;
@@ -617,7 +620,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	/* kernel backtrace */
 	object->trace_len = __save_stack_trace(object->trace);
 
-	write_lock_irqsave(&kmemleak_lock, flags);
+	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 
 	untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
 	min_addr = min(min_addr, untagged_ptr);
@@ -649,7 +652,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 
 	list_add_tail_rcu(&object->object_list, &object_list);
 out:
-	write_unlock_irqrestore(&kmemleak_lock, flags);
+	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 	return object;
 }
 
@@ -667,9 +670,9 @@ static void __delete_object(struct kmemleak_object *object)
 	 * Locking here also ensures that the corresponding memory block
 	 * cannot be freed when it is being scanned.
 	 */
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->flags &= ~OBJECT_ALLOCATED;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
 
@@ -739,9 +742,9 @@ static void paint_it(struct kmemleak_object *object, int color)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	__paint_it(object, color);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 }
 
 static void paint_ptr(unsigned long ptr, int color)
@@ -803,7 +806,7 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
 	if (scan_area_cache)
 		area = kmem_cache_alloc(scan_area_cache, gfp_kmemleak_mask(gfp));
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	if (!area) {
 		pr_warn_once("Cannot allocate a scan area, scanning the full object\n");
 		/* mark the object for full scan to avoid false positives */
@@ -825,7 +828,7 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
 
 	hlist_add_head(&area->node, &object->area_list);
 out_unlock:
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
 
@@ -847,9 +850,9 @@ static void object_set_excess_ref(unsigned long ptr, unsigned long excess_ref)
 		return;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->excess_ref = excess_ref;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
 
@@ -869,9 +872,9 @@ static void object_no_scan(unsigned long ptr)
 		return;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->flags |= OBJECT_NO_SCAN;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
 
@@ -1031,9 +1034,9 @@ void __ref kmemleak_update_trace(const void *ptr)
 		return;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->trace_len = __save_stack_trace(object->trace);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 
 	put_object(object);
 }
@@ -1238,7 +1241,7 @@ static void scan_block(void *_start, void *_end,
 	unsigned long flags;
 	unsigned long untagged_ptr;
 
-	read_lock_irqsave(&kmemleak_lock, flags);
+	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	for (ptr = start; ptr < end; ptr++) {
 		struct kmemleak_object *object;
 		unsigned long pointer;
@@ -1273,7 +1276,7 @@ static void scan_block(void *_start, void *_end,
 		 * previously acquired in scan_object(). These locks are
 		 * enclosed by scan_mutex.
 		 */
-		spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
+		raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
 		/* only pass surplus references (object already gray) */
 		if (color_gray(object)) {
 			excess_ref = object->excess_ref;
@@ -1282,7 +1285,7 @@ static void scan_block(void *_start, void *_end,
 			excess_ref = 0;
 			update_refs(object);
 		}
-		spin_unlock(&object->lock);
+		raw_spin_unlock(&object->lock);
 
 		if (excess_ref) {
 			object = lookup_object(excess_ref, 0);
@@ -1291,12 +1294,12 @@ static void scan_block(void *_start, void *_end,
 			if (object == scanned)
 				/* circular reference, ignore */
 				continue;
-			spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
+			raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
 			update_refs(object);
-			spin_unlock(&object->lock);
+			raw_spin_unlock(&object->lock);
 		}
 	}
-	read_unlock_irqrestore(&kmemleak_lock, flags);
+	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 }
 
 /*
@@ -1329,7 +1332,7 @@ static void scan_object(struct kmemleak_object *object)
 	 * Once the object->lock is acquired, the corresponding memory block
 	 * cannot be freed (the same lock is acquired in delete_object).
 	 */
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	if (object->flags & OBJECT_NO_SCAN)
 		goto out;
 	if (!(object->flags & OBJECT_ALLOCATED))
@@ -1349,9 +1352,9 @@ static void scan_object(struct kmemleak_object *object)
 			if (start >= end)
 				break;
 
-			spin_unlock_irqrestore(&object->lock, flags);
+			raw_spin_unlock_irqrestore(&object->lock, flags);
 			cond_resched();
-			spin_lock_irqsave(&object->lock, flags);
+			raw_spin_lock_irqsave(&object->lock, flags);
 		} while (object->flags & OBJECT_ALLOCATED);
 	} else
 		hlist_for_each_entry(area, &object->area_list, node)
@@ -1359,7 +1362,7 @@ static void scan_object(struct kmemleak_object *object)
 				   (void *)(area->start + area->size),
 				   object);
 out:
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 }
 
 /*
@@ -1413,7 +1416,7 @@ static void kmemleak_scan(void)
 	/* prepare the kmemleak_object's */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 #ifdef DEBUG
 		/*
 		 * With a few exceptions there should be a maximum of
@@ -1430,7 +1433,7 @@ static void kmemleak_scan(void)
 		if (color_gray(object) && get_object(object))
 			list_add_tail(&object->gray_list, &gray_list);
 
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -1498,14 +1501,14 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 		if (color_white(object) && (object->flags & OBJECT_ALLOCATED)
 		    && update_checksum(object) && get_object(object)) {
 			/* color it gray temporarily */
 			object->count = object->min_count;
 			list_add_tail(&object->gray_list, &gray_list);
 		}
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -1525,7 +1528,7 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 		if (unreferenced_object(object) &&
 		    !(object->flags & OBJECT_REPORTED)) {
 			object->flags |= OBJECT_REPORTED;
@@ -1535,7 +1538,7 @@ static void kmemleak_scan(void)
 
 			new_leaks++;
 		}
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -1687,10 +1690,10 @@ static int kmemleak_seq_show(struct seq_file *seq, void *v)
 	struct kmemleak_object *object = v;
 	unsigned long flags;
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	if ((object->flags & OBJECT_REPORTED) && unreferenced_object(object))
 		print_unreferenced(seq, object);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	return 0;
 }
 
@@ -1720,9 +1723,9 @@ static int dump_str_object_info(const char *str)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	dump_object_info(object);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 
 	put_object(object);
 	return 0;
@@ -1741,11 +1744,11 @@ static void kmemleak_clear(void)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 		if ((object->flags & OBJECT_REPORTED) &&
 		    unreferenced_object(object))
 			__paint_it(object, KMEMLEAK_GREY);
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -1849,6 +1852,7 @@ static const struct file_operations kmemleak_fops = {
 static void __kmemleak_do_cleanup(void)
 {
 	struct kmemleak_object *object, *tmp;
+	unsigned int cnt = 0;
 
 	/*
 	 * Kmemleak has already been disabled, no need for RCU list traversal
@@ -1857,6 +1861,10 @@ static void __kmemleak_do_cleanup(void)
 	list_for_each_entry_safe(object, tmp, &object_list, object_list) {
 		__remove_object(object);
 		__delete_object(object);
+
+		/* Call cond_resched() once per 64 iterations to avoid soft lockup */
+		if (!(++cnt & 0x3f))
+			cond_resched();
 	}
 }
 
diff --git a/mm/madvise.c b/mm/madvise.c
index ac8d68c488b5..3f5331c96ad5 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -839,7 +839,7 @@ static long madvise_remove(struct vm_area_struct *vma,
 			return -EINVAL;
 	}
 
-	if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) != (VM_SHARED|VM_WRITE))
+	if (!vma_is_shared_maywrite(vma))
 		return -EACCES;
 
 	offset = (loff_t)(start - vma->vm_start)
diff --git a/mm/mmap.c b/mm/mmap.c
index eeebbb20accf..e591a82a26a8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -141,7 +141,7 @@ static void __remove_shared_vm_struct(struct vm_area_struct *vma,
 {
 	if (vma->vm_flags & VM_DENYWRITE)
 		atomic_inc(&file_inode(file)->i_writecount);
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_is_shared_maywrite(vma))
 		mapping_unmap_writable(mapping);
 
 	flush_dcache_mmap_lock(mapping);
@@ -619,7 +619,7 @@ static void __vma_link_file(struct vm_area_struct *vma)
 
 		if (vma->vm_flags & VM_DENYWRITE)
 			atomic_dec(&file_inode(file)->i_writecount);
-		if (vma->vm_flags & VM_SHARED)
+		if (vma_is_shared_maywrite(vma))
 			atomic_inc(&mapping->i_mmap_writable);
 
 		flush_dcache_mmap_lock(mapping);
@@ -1718,6 +1718,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
+	bool writable_file_mapping = false;
 	int error;
 	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged = 0;
@@ -1785,11 +1786,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			if (error)
 				goto free_vma;
 		}
-		if (vm_flags & VM_SHARED) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto allow_write_and_free_vma;
-		}
 
 		/* ->mmap() can change vma->vm_file, but must guarantee that
 		 * vma_link() below can deny write-access if VM_DENYWRITE is set
@@ -1801,6 +1797,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto unmap_and_free_vma;
 
+		if (vma_is_shared_maywrite(vma)) {
+			error = mapping_map_writable(file->f_mapping);
+			if (error)
+				goto close_and_free_vma;
+
+			writable_file_mapping = true;
+		}
+
 		/* Can addr have changed??
 		 *
 		 * Answer: Yes, several device drivers can do it in their
@@ -1823,7 +1827,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 	/* Once vma denies write, undo our temporary denial count */
 	if (file) {
-		if (vm_flags & VM_SHARED)
+		if (writable_file_mapping)
 			mapping_unmap_writable(file->f_mapping);
 		if (vm_flags & VM_DENYWRITE)
 			allow_write_access(file);
@@ -1858,15 +1862,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	return addr;
 
+close_and_free_vma:
+	if (vma->vm_ops && vma->vm_ops->close)
+		vma->vm_ops->close(vma);
 unmap_and_free_vma:
 	vma->vm_file = NULL;
 	fput(file);
 
 	/* Undo any partial mapping done by a device driver. */
 	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
-	if (vm_flags & VM_SHARED)
+	if (writable_file_mapping)
 		mapping_unmap_writable(file->f_mapping);
-allow_write_and_free_vma:
 	if (vm_flags & VM_DENYWRITE)
 		allow_write_access(file);
 free_vma:
diff --git a/mm/shmem.c b/mm/shmem.c
index 264229680ad7..8475d56f5977 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2215,7 +2215,7 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	struct shmem_inode_info *info = SHMEM_I(file_inode(file));
 	int ret;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6b100f02ee43..b379deb0a10c 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -357,7 +357,7 @@ static void cache_free_handle(struct zs_pool *pool, unsigned long handle)
 
 static struct zspage *cache_alloc_zspage(struct zs_pool *pool, gfp_t flags)
 {
-	return kmem_cache_alloc(pool->zspage_cachep,
+	return kmem_cache_zalloc(pool->zspage_cachep,
 			flags & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
 }
 
@@ -1067,7 +1067,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	if (!zspage)
 		return NULL;
 
-	memset(zspage, 0, sizeof(struct zspage));
+	if (!IS_ENABLED(CONFIG_COMPACTION))
+		gfp &= ~__GFP_MOVABLE;
+
 	zspage->magic = ZSPAGE_MAGIC;
 	migrate_lock_init(zspage);
 
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index c75fca3eed49..14244445f944 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -354,6 +354,35 @@ static int __vlan_device_event(struct net_device *dev, unsigned long event)
 	return err;
 }
 
+static void vlan_vid0_add(struct net_device *dev)
+{
+	struct vlan_info *vlan_info;
+	int err;
+
+	if (!(dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
+		return;
+
+	pr_info("adding VLAN 0 to HW filter on device %s\n", dev->name);
+
+	err = vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
+	if (err)
+		return;
+
+	vlan_info = rtnl_dereference(dev->vlan_info);
+	vlan_info->auto_vid0 = true;
+}
+
+static void vlan_vid0_del(struct net_device *dev)
+{
+	struct vlan_info *vlan_info = rtnl_dereference(dev->vlan_info);
+
+	if (!vlan_info || !vlan_info->auto_vid0)
+		return;
+
+	vlan_info->auto_vid0 = false;
+	vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
+}
+
 static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 			     void *ptr)
 {
@@ -375,15 +404,10 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 			return notifier_from_errno(err);
 	}
 
-	if ((event == NETDEV_UP) &&
-	    (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER)) {
-		pr_info("adding VLAN 0 to HW filter on device %s\n",
-			dev->name);
-		vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
-	}
-	if (event == NETDEV_DOWN &&
-	    (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
-		vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
+	if (event == NETDEV_UP)
+		vlan_vid0_add(dev);
+	else if (event == NETDEV_DOWN)
+		vlan_vid0_del(dev);
 
 	vlan_info = rtnl_dereference(dev->vlan_info);
 	if (!vlan_info)
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index 6728d1593929..f0d78018b0d2 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -33,6 +33,7 @@ struct vlan_info {
 	struct vlan_group	grp;
 	struct list_head	vid_list;
 	unsigned int		nr_vids;
+	bool			auto_vid0;
 	struct rcu_head		rcu;
 };
 
diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
index 45f584171de7..17d9cb380e7b 100644
--- a/net/appletalk/aarp.c
+++ b/net/appletalk/aarp.c
@@ -35,6 +35,7 @@
 #include <linux/seq_file.h>
 #include <linux/export.h>
 #include <linux/etherdevice.h>
+#include <linux/refcount.h>
 
 int sysctl_aarp_expiry_time = AARP_EXPIRY_TIME;
 int sysctl_aarp_tick_time = AARP_TICK_TIME;
@@ -44,17 +45,19 @@ int sysctl_aarp_resolve_time = AARP_RESOLVE_TIME;
 /* Lists of aarp entries */
 /**
  *	struct aarp_entry - AARP entry
- *	@last_sent - Last time we xmitted the aarp request
- *	@packet_queue - Queue of frames wait for resolution
- *	@status - Used for proxy AARP
- *	expires_at - Entry expiry time
- *	target_addr - DDP Address
- *	dev - Device to use
- *	hwaddr - Physical i/f address of target/router
- *	xmit_count - When this hits 10 we give up
- *	next - Next entry in chain
+ *	@refcnt: Reference count
+ *	@last_sent: Last time we xmitted the aarp request
+ *	@packet_queue: Queue of frames wait for resolution
+ *	@status: Used for proxy AARP
+ *	@expires_at: Entry expiry time
+ *	@target_addr: DDP Address
+ *	@dev:  Device to use
+ *	@hwaddr:  Physical i/f address of target/router
+ *	@xmit_count:  When this hits 10 we give up
+ *	@next: Next entry in chain
  */
 struct aarp_entry {
+	refcount_t			refcnt;
 	/* These first two are only used for unresolved entries */
 	unsigned long		last_sent;
 	struct sk_buff_head	packet_queue;
@@ -79,6 +82,17 @@ static DEFINE_RWLOCK(aarp_lock);
 /* Used to walk the list and purge/kick entries.  */
 static struct timer_list aarp_timer;
 
+static inline void aarp_entry_get(struct aarp_entry *a)
+{
+	refcount_inc(&a->refcnt);
+}
+
+static inline void aarp_entry_put(struct aarp_entry *a)
+{
+	if (refcount_dec_and_test(&a->refcnt))
+		kfree(a);
+}
+
 /*
  *	Delete an aarp queue
  *
@@ -87,7 +101,7 @@ static struct timer_list aarp_timer;
 static void __aarp_expire(struct aarp_entry *a)
 {
 	skb_queue_purge(&a->packet_queue);
-	kfree(a);
+	aarp_entry_put(a);
 }
 
 /*
@@ -380,9 +394,11 @@ static void aarp_purge(void)
 static struct aarp_entry *aarp_alloc(void)
 {
 	struct aarp_entry *a = kmalloc(sizeof(*a), GFP_ATOMIC);
+	if (!a)
+		return NULL;
 
-	if (a)
-		skb_queue_head_init(&a->packet_queue);
+	refcount_set(&a->refcnt, 1);
+	skb_queue_head_init(&a->packet_queue);
 	return a;
 }
 
@@ -508,6 +524,7 @@ int aarp_proxy_probe_network(struct atalk_iface *atif, struct atalk_addr *sa)
 	entry->dev = atif->dev;
 
 	write_lock_bh(&aarp_lock);
+	aarp_entry_get(entry);
 
 	hash = sa->s_node % (AARP_HASH_SIZE - 1);
 	entry->next = proxies[hash];
@@ -533,6 +550,7 @@ int aarp_proxy_probe_network(struct atalk_iface *atif, struct atalk_addr *sa)
 		retval = 1;
 	}
 
+	aarp_entry_put(entry);
 	write_unlock_bh(&aarp_lock);
 out:
 	return retval;
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 46ca0f1354fd..01170c4e9c6d 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1400,9 +1400,10 @@ static int atalk_route_packet(struct sk_buff *skb, struct net_device *dev,
 
 /**
  *	atalk_rcv - Receive a packet (in skb) from device dev
- *	@skb - packet received
- *	@dev - network device where the packet comes from
- *	@pt - packet type
+ *	@skb: packet received
+ *	@dev: network device where the packet comes from
+ *	@pt: packet type
+ *	@orig_dev: the original receive net device
  *
  *	Receive a packet (in skb) from device dev. This has come from the SNAP
  *	decoder, and on entry skb->transport_header is the DDP header, skb->len
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 266112c960ee..f8e7b0ba2d27 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -19,14 +19,9 @@ static const struct device_type bt_link = {
 	.release = bt_link_release,
 };
 
-/*
- * The rfcomm tty device will possibly retain even when conn
- * is down, and sysfs doesn't support move zombie device,
- * so we should move the device before conn device is destroyed.
- */
-static int __match_tty(struct device *dev, void *data)
+static int __match_any(struct device *dev, void *unused)
 {
-	return !strncmp(dev_name(dev), "rfcomm", 6);
+	return 1;
 }
 
 void hci_conn_init_sysfs(struct hci_conn *conn)
@@ -71,10 +66,12 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 		return;
 	}
 
+	/* If there are devices using the connection as parent reset it to NULL
+	 * before unregistering the device.
+	 */
 	while (1) {
 		struct device *dev;
-
-		dev = device_find_child(&conn->dev, NULL, __match_tty);
+		dev = device_find_child(&conn->dev, NULL, __match_any);
 		if (!dev)
 			break;
 		device_move(dev, NULL, DPM_ORDER_DEV_LAST);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4939152f6adc..1272ad73e401 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3484,12 +3484,28 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 		/* Configure output options and let the other side know
 		 * which ones we don't like. */
 
-		/* If MTU is not provided in configure request, use the most recently
-		 * explicitly or implicitly accepted value for the other direction,
-		 * or the default value.
+		/* If MTU is not provided in configure request, try adjusting it
+		 * to the current output MTU if it has been set
+		 *
+		 * Bluetooth Core 6.1, Vol 3, Part A, Section 4.5
+		 *
+		 * Each configuration parameter value (if any is present) in an
+		 * L2CAP_CONFIGURATION_RSP packet reflects an ‘adjustment’ to a
+		 * configuration parameter value that has been sent (or, in case
+		 * of default values, implied) in the corresponding
+		 * L2CAP_CONFIGURATION_REQ packet.
 		 */
-		if (mtu == 0)
-			mtu = chan->imtu ? chan->imtu : L2CAP_DEFAULT_MTU;
+		if (!mtu) {
+			/* Only adjust for ERTM channels as for older modes the
+			 * remote stack may not be able to detect that the
+			 * adjustment causing it to silently drop packets.
+			 */
+			if (chan->mode == L2CAP_MODE_ERTM &&
+			    chan->omtu && chan->omtu != L2CAP_DEFAULT_MTU)
+				mtu = chan->omtu;
+			else
+				mtu = L2CAP_DEFAULT_MTU;
+		}
 
 		if (mtu < L2CAP_DEFAULT_MIN_MTU)
 			result = L2CAP_CONF_UNACCEPT;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index e6d93501e106..93df53f2b76e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1488,6 +1488,9 @@ static void l2cap_sock_resume_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
 
+	if (!sk)
+		return;
+
 	if (test_and_clear_bit(FLAG_PENDING_SECURITY, &chan->flags)) {
 		sk->sk_state = BT_CONNECTED;
 		chan->state = BT_CONNECTED;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 4d5ba9778885..65035d89af98 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1368,7 +1368,7 @@ static void smp_timeout(struct work_struct *work)
 
 	BT_DBG("conn %p", conn);
 
-	hci_disconnect(conn->hcon, HCI_ERROR_REMOTE_USER_TERM);
+	hci_disconnect(conn->hcon, HCI_ERROR_AUTH_FAILURE);
 }
 
 static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
@@ -2908,8 +2908,25 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 	if (code > SMP_CMD_MAX)
 		goto drop;
 
-	if (smp && !test_and_clear_bit(code, &smp->allow_cmd))
+	if (smp && !test_and_clear_bit(code, &smp->allow_cmd)) {
+		/* If there is a context and the command is not allowed consider
+		 * it a failure so the session is cleanup properly.
+		 */
+		switch (code) {
+		case SMP_CMD_IDENT_INFO:
+		case SMP_CMD_IDENT_ADDR_INFO:
+		case SMP_CMD_SIGN_INFO:
+			/* 3.6.1. Key distribution and generation
+			 *
+			 * A device may reject a distributed key by sending the
+			 * Pairing Failed command with the reason set to
+			 * "Key Rejected".
+			 */
+			smp_failure(conn, SMP_KEY_REJECTED);
+			break;
+		}
 		goto drop;
+	}
 
 	/* If we don't have a context the only allowed commands are
 	 * pairing request and security request.
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 121edadd5f8d..f17de3d9778d 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -138,6 +138,7 @@ struct smp_cmd_keypress_notify {
 #define SMP_NUMERIC_COMP_FAILED		0x0c
 #define SMP_BREDR_PAIRING_IN_PROGRESS	0x0d
 #define SMP_CROSS_TRANSP_NOT_ALLOWED	0x0e
+#define SMP_KEY_REJECTED		0x0f
 
 #define SMP_MIN_ENC_KEY_SIZE		7
 #define SMP_MAX_ENC_KEY_SIZE		16
diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
index d8cb4b2a076b..3eec293ab22f 100644
--- a/net/caif/cfctrl.c
+++ b/net/caif/cfctrl.c
@@ -351,17 +351,154 @@ int cfctrl_cancel_req(struct cflayer *layr, struct cflayer *adap_layer)
 	return found;
 }
 
+static int cfctrl_link_setup(struct cfctrl *cfctrl, struct cfpkt *pkt, u8 cmdrsp)
+{
+	u8 len;
+	u8 linkid = 0;
+	enum cfctrl_srv serv;
+	enum cfctrl_srv servtype;
+	u8 endpoint;
+	u8 physlinkid;
+	u8 prio;
+	u8 tmp;
+	u8 *cp;
+	int i;
+	struct cfctrl_link_param linkparam;
+	struct cfctrl_request_info rsp, *req;
+
+	memset(&linkparam, 0, sizeof(linkparam));
+
+	tmp = cfpkt_extr_head_u8(pkt);
+
+	serv = tmp & CFCTRL_SRV_MASK;
+	linkparam.linktype = serv;
+
+	servtype = tmp >> 4;
+	linkparam.chtype = servtype;
+
+	tmp = cfpkt_extr_head_u8(pkt);
+	physlinkid = tmp & 0x07;
+	prio = tmp >> 3;
+
+	linkparam.priority = prio;
+	linkparam.phyid = physlinkid;
+	endpoint = cfpkt_extr_head_u8(pkt);
+	linkparam.endpoint = endpoint & 0x03;
+
+	switch (serv) {
+	case CFCTRL_SRV_VEI:
+	case CFCTRL_SRV_DBG:
+		if (CFCTRL_ERR_BIT & cmdrsp)
+			break;
+		/* Link ID */
+		linkid = cfpkt_extr_head_u8(pkt);
+		break;
+	case CFCTRL_SRV_VIDEO:
+		tmp = cfpkt_extr_head_u8(pkt);
+		linkparam.u.video.connid = tmp;
+		if (CFCTRL_ERR_BIT & cmdrsp)
+			break;
+		/* Link ID */
+		linkid = cfpkt_extr_head_u8(pkt);
+		break;
+
+	case CFCTRL_SRV_DATAGRAM:
+		linkparam.u.datagram.connid = cfpkt_extr_head_u32(pkt);
+		if (CFCTRL_ERR_BIT & cmdrsp)
+			break;
+		/* Link ID */
+		linkid = cfpkt_extr_head_u8(pkt);
+		break;
+	case CFCTRL_SRV_RFM:
+		/* Construct a frame, convert
+		 * DatagramConnectionID
+		 * to network format long and copy it out...
+		 */
+		linkparam.u.rfm.connid = cfpkt_extr_head_u32(pkt);
+		cp = (u8 *) linkparam.u.rfm.volume;
+		for (tmp = cfpkt_extr_head_u8(pkt);
+		     cfpkt_more(pkt) && tmp != '\0';
+		     tmp = cfpkt_extr_head_u8(pkt))
+			*cp++ = tmp;
+		*cp = '\0';
+
+		if (CFCTRL_ERR_BIT & cmdrsp)
+			break;
+		/* Link ID */
+		linkid = cfpkt_extr_head_u8(pkt);
+
+		break;
+	case CFCTRL_SRV_UTIL:
+		/* Construct a frame, convert
+		 * DatagramConnectionID
+		 * to network format long and copy it out...
+		 */
+		/* Fifosize KB */
+		linkparam.u.utility.fifosize_kb = cfpkt_extr_head_u16(pkt);
+		/* Fifosize bufs */
+		linkparam.u.utility.fifosize_bufs = cfpkt_extr_head_u16(pkt);
+		/* name */
+		cp = (u8 *) linkparam.u.utility.name;
+		caif_assert(sizeof(linkparam.u.utility.name)
+			     >= UTILITY_NAME_LENGTH);
+		for (i = 0; i < UTILITY_NAME_LENGTH && cfpkt_more(pkt); i++) {
+			tmp = cfpkt_extr_head_u8(pkt);
+			*cp++ = tmp;
+		}
+		/* Length */
+		len = cfpkt_extr_head_u8(pkt);
+		linkparam.u.utility.paramlen = len;
+		/* Param Data */
+		cp = linkparam.u.utility.params;
+		while (cfpkt_more(pkt) && len--) {
+			tmp = cfpkt_extr_head_u8(pkt);
+			*cp++ = tmp;
+		}
+		if (CFCTRL_ERR_BIT & cmdrsp)
+			break;
+		/* Link ID */
+		linkid = cfpkt_extr_head_u8(pkt);
+		/* Length */
+		len = cfpkt_extr_head_u8(pkt);
+		/* Param Data */
+		cfpkt_extr_head(pkt, NULL, len);
+		break;
+	default:
+		pr_warn("Request setup, invalid type (%d)\n", serv);
+		return -1;
+	}
+
+	rsp.cmd = CFCTRL_CMD_LINK_SETUP;
+	rsp.param = linkparam;
+	spin_lock_bh(&cfctrl->info_list_lock);
+	req = cfctrl_remove_req(cfctrl, &rsp);
+
+	if (CFCTRL_ERR_BIT == (CFCTRL_ERR_BIT & cmdrsp) ||
+		cfpkt_erroneous(pkt)) {
+		pr_err("Invalid O/E bit or parse error "
+				"on CAIF control channel\n");
+		cfctrl->res.reject_rsp(cfctrl->serv.layer.up, 0,
+				       req ? req->client_layer : NULL);
+	} else {
+		cfctrl->res.linksetup_rsp(cfctrl->serv.layer.up, linkid,
+					  serv, physlinkid,
+					  req ?  req->client_layer : NULL);
+	}
+
+	kfree(req);
+
+	spin_unlock_bh(&cfctrl->info_list_lock);
+
+	return 0;
+}
+
 static int cfctrl_recv(struct cflayer *layer, struct cfpkt *pkt)
 {
 	u8 cmdrsp;
 	u8 cmd;
-	int ret = -1;
-	u8 len;
-	u8 param[255];
+	int ret = 0;
 	u8 linkid = 0;
 	struct cfctrl *cfctrl = container_obj(layer);
-	struct cfctrl_request_info rsp, *req;
-
 
 	cmdrsp = cfpkt_extr_head_u8(pkt);
 	cmd = cmdrsp & CFCTRL_CMD_MASK;
@@ -374,150 +511,7 @@ static int cfctrl_recv(struct cflayer *layer, struct cfpkt *pkt)
 
 	switch (cmd) {
 	case CFCTRL_CMD_LINK_SETUP:
-		{
-			enum cfctrl_srv serv;
-			enum cfctrl_srv servtype;
-			u8 endpoint;
-			u8 physlinkid;
-			u8 prio;
-			u8 tmp;
-			u8 *cp;
-			int i;
-			struct cfctrl_link_param linkparam;
-			memset(&linkparam, 0, sizeof(linkparam));
-
-			tmp = cfpkt_extr_head_u8(pkt);
-
-			serv = tmp & CFCTRL_SRV_MASK;
-			linkparam.linktype = serv;
-
-			servtype = tmp >> 4;
-			linkparam.chtype = servtype;
-
-			tmp = cfpkt_extr_head_u8(pkt);
-			physlinkid = tmp & 0x07;
-			prio = tmp >> 3;
-
-			linkparam.priority = prio;
-			linkparam.phyid = physlinkid;
-			endpoint = cfpkt_extr_head_u8(pkt);
-			linkparam.endpoint = endpoint & 0x03;
-
-			switch (serv) {
-			case CFCTRL_SRV_VEI:
-			case CFCTRL_SRV_DBG:
-				if (CFCTRL_ERR_BIT & cmdrsp)
-					break;
-				/* Link ID */
-				linkid = cfpkt_extr_head_u8(pkt);
-				break;
-			case CFCTRL_SRV_VIDEO:
-				tmp = cfpkt_extr_head_u8(pkt);
-				linkparam.u.video.connid = tmp;
-				if (CFCTRL_ERR_BIT & cmdrsp)
-					break;
-				/* Link ID */
-				linkid = cfpkt_extr_head_u8(pkt);
-				break;
-
-			case CFCTRL_SRV_DATAGRAM:
-				linkparam.u.datagram.connid =
-				    cfpkt_extr_head_u32(pkt);
-				if (CFCTRL_ERR_BIT & cmdrsp)
-					break;
-				/* Link ID */
-				linkid = cfpkt_extr_head_u8(pkt);
-				break;
-			case CFCTRL_SRV_RFM:
-				/* Construct a frame, convert
-				 * DatagramConnectionID
-				 * to network format long and copy it out...
-				 */
-				linkparam.u.rfm.connid =
-				    cfpkt_extr_head_u32(pkt);
-				cp = (u8 *) linkparam.u.rfm.volume;
-				for (tmp = cfpkt_extr_head_u8(pkt);
-				     cfpkt_more(pkt) && tmp != '\0';
-				     tmp = cfpkt_extr_head_u8(pkt))
-					*cp++ = tmp;
-				*cp = '\0';
-
-				if (CFCTRL_ERR_BIT & cmdrsp)
-					break;
-				/* Link ID */
-				linkid = cfpkt_extr_head_u8(pkt);
-
-				break;
-			case CFCTRL_SRV_UTIL:
-				/* Construct a frame, convert
-				 * DatagramConnectionID
-				 * to network format long and copy it out...
-				 */
-				/* Fifosize KB */
-				linkparam.u.utility.fifosize_kb =
-				    cfpkt_extr_head_u16(pkt);
-				/* Fifosize bufs */
-				linkparam.u.utility.fifosize_bufs =
-				    cfpkt_extr_head_u16(pkt);
-				/* name */
-				cp = (u8 *) linkparam.u.utility.name;
-				caif_assert(sizeof(linkparam.u.utility.name)
-					     >= UTILITY_NAME_LENGTH);
-				for (i = 0;
-				     i < UTILITY_NAME_LENGTH
-				     && cfpkt_more(pkt); i++) {
-					tmp = cfpkt_extr_head_u8(pkt);
-					*cp++ = tmp;
-				}
-				/* Length */
-				len = cfpkt_extr_head_u8(pkt);
-				linkparam.u.utility.paramlen = len;
-				/* Param Data */
-				cp = linkparam.u.utility.params;
-				while (cfpkt_more(pkt) && len--) {
-					tmp = cfpkt_extr_head_u8(pkt);
-					*cp++ = tmp;
-				}
-				if (CFCTRL_ERR_BIT & cmdrsp)
-					break;
-				/* Link ID */
-				linkid = cfpkt_extr_head_u8(pkt);
-				/* Length */
-				len = cfpkt_extr_head_u8(pkt);
-				/* Param Data */
-				cfpkt_extr_head(pkt, &param, len);
-				break;
-			default:
-				pr_warn("Request setup, invalid type (%d)\n",
-					serv);
-				goto error;
-			}
-
-			rsp.cmd = cmd;
-			rsp.param = linkparam;
-			spin_lock_bh(&cfctrl->info_list_lock);
-			req = cfctrl_remove_req(cfctrl, &rsp);
-
-			if (CFCTRL_ERR_BIT == (CFCTRL_ERR_BIT & cmdrsp) ||
-				cfpkt_erroneous(pkt)) {
-				pr_err("Invalid O/E bit or parse error "
-						"on CAIF control channel\n");
-				cfctrl->res.reject_rsp(cfctrl->serv.layer.up,
-						       0,
-						       req ? req->client_layer
-						       : NULL);
-			} else {
-				cfctrl->res.linksetup_rsp(cfctrl->serv.
-							  layer.up, linkid,
-							  serv, physlinkid,
-							  req ? req->
-							  client_layer : NULL);
-			}
-
-			kfree(req);
-
-			spin_unlock_bh(&cfctrl->info_list_lock);
-		}
+		ret = cfctrl_link_setup(cfctrl, pkt, cmdrsp);
 		break;
 	case CFCTRL_CMD_LINK_DESTROY:
 		linkid = cfpkt_extr_head_u8(pkt);
@@ -544,9 +538,9 @@ static int cfctrl_recv(struct cflayer *layer, struct cfpkt *pkt)
 		break;
 	default:
 		pr_err("Unrecognized Control Frame\n");
+		ret = -1;
 		goto error;
 	}
-	ret = 0;
 error:
 	cfpkt_destroy(pkt);
 	return ret;
diff --git a/net/core/filter.c b/net/core/filter.c
index e6ec6f013ec0..fd18497977bd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7282,6 +7282,9 @@ static bool flow_dissector_is_valid_access(int off, int size,
 	if (off < 0 || off >= sizeof(struct __sk_buff))
 		return false;
 
+	if (off % size != 0)
+		return false;
+
 	if (type == BPF_WRITE)
 		return false;
 
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 940d371f5f3b..09ae2fc41fa9 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -807,6 +807,13 @@ int netpoll_setup(struct netpoll *np)
 		goto put;
 
 	rtnl_unlock();
+
+	/* Make sure all NAPI polls which started before dev->npinfo
+	 * was visible have exited before we start calling NAPI poll.
+	 * NAPI skips locking if dev->npinfo is NULL.
+	 */
+	synchronize_rcu();
+
 	return 0;
 
 put:
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d173234503f9..80612f73ff53 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2378,7 +2378,6 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
 	do_cache = true;
 	if (type == RTN_BROADCAST) {
 		flags |= RTCF_BROADCAST | RTCF_LOCAL;
-		fi = NULL;
 	} else if (type == RTN_MULTICAST) {
 		flags |= RTCF_MULTICAST | RTCF_LOCAL;
 		if (!ip_check_mc_rcu(in_dev, fl4->daddr, fl4->saddr,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 6b3bb8a59035..9d65e684e626 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4588,8 +4588,9 @@ static void tcp_ofo_queue(struct sock *sk)
 
 		if (before(TCP_SKB_CB(skb)->seq, dsack_high)) {
 			__u32 dsack = dsack_high;
+
 			if (before(TCP_SKB_CB(skb)->end_seq, dsack_high))
-				dsack_high = TCP_SKB_CB(skb)->end_seq;
+				dsack = TCP_SKB_CB(skb)->end_seq;
 			tcp_dsack_extend(sk, TCP_SKB_CB(skb)->seq, dsack);
 		}
 		p = rb_next(p);
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 6505a6fd245a..7e025f3517b8 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -58,7 +58,7 @@ static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
 	remcsum = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TUNNEL_REMCSUM);
 	skb->remcsum_offload = remcsum;
 
-	need_ipsec = skb_dst(skb) && dst_xfrm(skb_dst(skb));
+	need_ipsec = (skb_dst(skb) && dst_xfrm(skb_dst(skb))) || skb_sec_path(skb);
 	/* Try to offload checksum if possible */
 	offload_csum = !!(need_csum &&
 			  !need_ipsec &&
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index b7b4ba68f3a2..0d9d11902b1b 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -109,7 +109,9 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 
 	ops = rcu_dereference(inet6_offloads[proto]);
 	if (likely(ops && ops->callbacks.gso_segment)) {
-		skb_reset_transport_header(skb);
+		if (!skb_reset_transport_header_careful(skb))
+			goto out;
+
 		segs = ops->callbacks.gso_segment(skb, features);
 		if (!segs)
 			skb->network_header = skb_mac_header(skb) + nhoff - skb->head;
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index b3b2aa92e60d..292a36576115 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -295,6 +295,9 @@ int seg6_hmac_info_add(struct net *net, u32 key, struct seg6_hmac_info *hinfo)
 	struct seg6_pernet_data *sdata = seg6_pernet(net);
 	int err;
 
+	if (!__hmac_get_algo(hinfo->alg_id))
+		return -EINVAL;
+
 	err = rhashtable_lookup_insert_fast(&sdata->hmac_infos, &hinfo->node,
 					    rht_params);
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 461cff7b94ad..f8d72f3e4def 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3661,6 +3661,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	 * The key can be removed while the packet was queued, so need to call
 	 * this here to get the current key.
 	 */
+	info->control.hw_key = NULL;
 	r = ieee80211_tx_h_select_key(&tx);
 	if (r != TX_CONTINUE) {
 		ieee80211_free_txskb(&local->hw, skb);
diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index b723452768d4..67d5ee4dbc2a 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -86,7 +86,7 @@ struct ncsi_channel_version {
 	u8   update;		/* NCSI version update */
 	char alpha1;		/* NCSI version alpha1 */
 	char alpha2;		/* NCSI version alpha2 */
-	u8  fw_name[12];	/* Firmware name string                */
+	u8  fw_name[12 + 1];	/* Firmware name string                */
 	u32 fw_version;		/* Firmware version                   */
 	u16 pci_ids[4];		/* PCI identification                 */
 	u32 mf_id;		/* Manufacture ID                     */
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index b7d311f97905..41e4ed80f29a 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -782,6 +782,7 @@ static int ncsi_rsp_handler_gvi(struct ncsi_request *nr)
 	ncv->alpha1 = rsp->alpha1;
 	ncv->alpha2 = rsp->alpha2;
 	memcpy(ncv->fw_name, rsp->fw_name, 12);
+	ncv->fw_name[12] = '\0';
 	ncv->fw_version = ntohl(rsp->fw_version);
 	for (i = 0; i < ARRAY_SIZE(ncv->pci_ids); i++)
 		ncv->pci_ids[i] = ntohs(rsp->pci_ids[i]);
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index eeb000e41ad7..5d6f9b375c0f 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -808,8 +808,6 @@ ctnetlink_conntrack_event(unsigned int events, struct nf_ct_event *item)
 
 static int ctnetlink_done(struct netlink_callback *cb)
 {
-	if (cb->args[1])
-		nf_ct_put((struct nf_conn *)cb->args[1]);
 	kfree(cb->data);
 	return 0;
 }
@@ -890,18 +888,25 @@ static int ctnetlink_filter_match(struct nf_conn *ct, void *data)
 	return 0;
 }
 
+static unsigned long ctnetlink_get_id(const struct nf_conn *ct)
+{
+	unsigned long id = nf_ct_get_id(ct);
+
+	return id ? id : 1;
+}
+
 static int
 ctnetlink_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct net *net = sock_net(skb->sk);
-	struct nf_conn *ct, *last;
+	unsigned long last_id = cb->args[1];
 	struct nf_conntrack_tuple_hash *h;
 	struct hlist_nulls_node *n;
 	struct nf_conn *nf_ct_evict[8];
+	struct nf_conn *ct;
 	int res, i;
 	spinlock_t *lockp;
 
-	last = (struct nf_conn *)cb->args[1];
 	i = 0;
 
 	local_bh_disable();
@@ -936,7 +941,7 @@ ctnetlink_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 				continue;
 
 			if (cb->args[1]) {
-				if (ct != last)
+				if (ctnetlink_get_id(ct) != last_id)
 					continue;
 				cb->args[1] = 0;
 			}
@@ -951,8 +956,7 @@ ctnetlink_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 					    ct);
 			rcu_read_unlock();
 			if (res < 0) {
-				nf_conntrack_get(&ct->ct_general);
-				cb->args[1] = (unsigned long)ct;
+				cb->args[1] = ctnetlink_get_id(ct);
 				spin_unlock(lockp);
 				goto out;
 			}
@@ -965,12 +969,10 @@ ctnetlink_dump_table(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 out:
 	local_bh_enable();
-	if (last) {
+	if (last_id) {
 		/* nf ct hash resize happened, now clear the leftover. */
-		if ((struct nf_conn *)cb->args[1] == last)
+		if (cb->args[1] == last_id)
 			cb->args[1] = 0;
-
-		nf_ct_put(last);
 	}
 
 	while (i) {
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 9e20fb759cb8..54c43f1cceac 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2823,7 +2823,7 @@ static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
 static void nf_tables_rule_release(const struct nft_ctx *ctx,
 				   struct nft_rule *rule)
 {
-	lockdep_commit_lock_is_held(ctx->net);
+	WARN_ON_ONCE(!lockdep_commit_lock_is_held(ctx->net));
 
 	nft_rule_expr_deactivate(ctx, rule, NFT_TRANS_RELEASE);
 	nf_tables_rule_destroy(ctx, rule);
@@ -4173,7 +4173,7 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      struct nft_set_binding *binding,
 			      enum nft_trans_phase phase)
 {
-	lockdep_commit_lock_is_held(ctx->net);
+	WARN_ON_ONCE(!lockdep_commit_lock_is_held(ctx->net));
 
 	switch (phase) {
 	case NFT_TRANS_PREPARE_ERROR:
diff --git a/net/netfilter/xt_nfacct.c b/net/netfilter/xt_nfacct.c
index 5aab6df74e0f..68b07476f754 100644
--- a/net/netfilter/xt_nfacct.c
+++ b/net/netfilter/xt_nfacct.c
@@ -38,8 +38,8 @@ nfacct_mt_checkentry(const struct xt_mtchk_param *par)
 
 	nfacct = nfnl_acct_find_get(par->net, info->name);
 	if (nfacct == NULL) {
-		pr_info_ratelimited("accounting object `%s' does not exists\n",
-				    info->name);
+		pr_info_ratelimited("accounting object `%.*s' does not exist\n",
+				    NFACCT_NAME_MAX, info->name);
 		return -ENOENT;
 	}
 	info->nfacct = nfacct;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 808ca542bfba..3259fb5b58dd 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1212,7 +1212,7 @@ int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
 	nlk = nlk_sk(sk);
 	rmem = atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
 
-	if ((rmem == skb->truesize || rmem < READ_ONCE(sk->sk_rcvbuf)) &&
+	if ((rmem == skb->truesize || rmem <= READ_ONCE(sk->sk_rcvbuf)) &&
 	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
 		netlink_skb_set_owner_r(skb, sk);
 		return 0;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index b1cf6a069e63..c6a301516bb0 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2713,7 +2713,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	int len_sum = 0;
 	int status = TP_STATUS_AVAILABLE;
 	int hlen, tlen, copylen = 0;
-	long timeo = 0;
+	long timeo;
 
 	mutex_lock(&po->pg_vec_lock);
 
@@ -2767,22 +2767,28 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 	if ((size_max > dev->mtu + reserve + VLAN_HLEN) && !po->has_vnet_hdr)
 		size_max = dev->mtu + reserve + VLAN_HLEN;
 
+	timeo = sock_sndtimeo(&po->sk, msg->msg_flags & MSG_DONTWAIT);
 	reinit_completion(&po->skb_completion);
 
 	do {
 		ph = packet_current_frame(po, &po->tx_ring,
 					  TP_STATUS_SEND_REQUEST);
 		if (unlikely(ph == NULL)) {
-			if (need_wait && skb) {
-				timeo = sock_sndtimeo(&po->sk, msg->msg_flags & MSG_DONTWAIT);
+			/* Note: packet_read_pending() might be slow if we
+			 * have to call it as it's per_cpu variable, but in
+			 * fast-path we don't have to call it, only when ph
+			 * is NULL, we need to check the pending_refcnt.
+			 */
+			if (need_wait && packet_read_pending(&po->tx_ring)) {
 				timeo = wait_for_completion_interruptible_timeout(&po->skb_completion, timeo);
 				if (timeo <= 0) {
 					err = !timeo ? -ETIMEDOUT : -ERESTARTSYS;
 					goto out_put;
 				}
-			}
-			/* check for additional frames */
-			continue;
+				/* check for additional frames */
+				continue;
+			} else
+				break;
 		}
 
 		skb = NULL;
@@ -2872,14 +2878,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		}
 		packet_increment_head(&po->tx_ring);
 		len_sum += tp_len;
-	} while (likely((ph != NULL) ||
-		/* Note: packet_read_pending() might be slow if we have
-		 * to call it as it's per_cpu variable, but in fast-path
-		 * we already short-circuit the loop with the first
-		 * condition, and luckily don't have to go that path
-		 * anyway.
-		 */
-		 (need_wait && packet_read_pending(&po->tx_ring))));
+	} while (1);
 
 	err = len_sum;
 	goto out_put;
@@ -4505,10 +4504,10 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 	spin_lock(&po->bind_lock);
 	was_running = po->running;
 	num = po->num;
-	if (was_running) {
-		WRITE_ONCE(po->num, 0);
+	WRITE_ONCE(po->num, 0);
+	if (was_running)
 		__unregister_prot_hook(sk, false);
-	}
+
 	spin_unlock(&po->bind_lock);
 
 	synchronize_net();
@@ -4540,10 +4539,10 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 	mutex_unlock(&po->pg_vec_lock);
 
 	spin_lock(&po->bind_lock);
-	if (was_running) {
-		WRITE_ONCE(po->num, num);
+	WRITE_ONCE(po->num, num);
+	if (was_running)
 		register_prot_hook(sk);
-	}
+
 	spin_unlock(&po->bind_lock);
 	if (pg_vec && (po->tp_version > TPACKET_V2)) {
 		/* Because we don't support block-based V3 on tx-ring */
diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index 0c5d0f7b8b4b..83d435e274e9 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -825,6 +825,7 @@ static struct sock *pep_sock_accept(struct sock *sk, int flags, int *errp,
 	}
 
 	/* Check for duplicate pipe handle */
+	pn_skb_get_dst_sockaddr(skb, &dst);
 	newsk = pep_find_pipe(&pn->hlist, &dst, pipe_handle);
 	if (unlikely(newsk)) {
 		__sock_put(newsk);
@@ -849,7 +850,6 @@ static struct sock *pep_sock_accept(struct sock *sk, int flags, int *errp,
 	newsk->sk_destruct = pipe_destruct;
 
 	newpn = pep_sk(newsk);
-	pn_skb_get_dst_sockaddr(skb, &dst);
 	pn_skb_get_src_sockaddr(skb, &src);
 	newpn->pn_sk.sobject = pn_sockaddr_get_object(&dst);
 	newpn->pn_sk.dobject = pn_sockaddr_get_object(&src);
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 52394e45bac5..b2a537f1a1ea 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1032,6 +1032,20 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 	return err;
 }
 
+void tcf_action_update_stats(struct tc_action *a, u64 bytes, u32 packets,
+			     bool drop, bool hw)
+{
+	_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), bytes, packets);
+
+	if (drop)
+		this_cpu_ptr(a->cpu_qstats)->drops += packets;
+
+	if (hw)
+		_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats_hw),
+				   bytes, packets);
+}
+EXPORT_SYMBOL(tcf_action_update_stats);
+
 int tcf_action_copy_stats(struct sk_buff *skb, struct tc_action *p,
 			  int compat_mode)
 {
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index fa1b1fd10c44..5a1f9c8be8b7 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -577,7 +577,7 @@ static int tcf_csum_act(struct sk_buff *skb, const struct tc_action *a,
 	params = rcu_dereference_bh(p->params);
 
 	tcf_lastuse_update(&p->tcf_tm);
-	bstats_cpu_update(this_cpu_ptr(p->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&p->common, skb);
 
 	action = READ_ONCE(p->tcf_action);
 	if (unlikely(action == TC_ACT_SHOT))
@@ -621,7 +621,7 @@ static int tcf_csum_act(struct sk_buff *skb, const struct tc_action *a,
 	return action;
 
 drop:
-	qstats_drop_inc(this_cpu_ptr(p->common.cpu_qstats));
+	tcf_action_inc_drop_qstats(&p->common);
 	action = TC_ACT_SHOT;
 	goto out;
 }
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 02d4491991b5..077cef97527f 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -482,11 +482,11 @@ static int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	skb_push_rcsum(skb, nh_ofs);
 
 out:
-	bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), skb);
+	tcf_action_update_bstats(&c->common, skb);
 	return retval;
 
 drop:
-	qstats_drop_inc(this_cpu_ptr(a->cpu_qstats));
+	tcf_action_inc_drop_qstats(&c->common);
 	return TC_ACT_SHOT;
 }
 
@@ -917,11 +917,7 @@ static void tcf_stats_update(struct tc_action *a, u64 bytes, u32 packets,
 {
 	struct tcf_ct *c = to_ct(a);
 
-	_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), bytes, packets);
-
-	if (hw)
-		_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats_hw),
-				   bytes, packets);
+	tcf_action_update_stats(a, bytes, packets, false, hw);
 	c->tcf_tm.lastuse = max_t(u64, c->tcf_tm.lastuse, lastuse);
 }
 
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index faf68a44b845..ef08fd58f28a 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -159,9 +159,9 @@ static int tcf_gact_act(struct sk_buff *skb, const struct tc_action *a,
 		action = gact_rand[ptype](gact);
 	}
 #endif
-	bstats_cpu_update(this_cpu_ptr(gact->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&gact->common, skb);
 	if (action == TC_ACT_SHOT)
-		qstats_drop_inc(this_cpu_ptr(gact->common.cpu_qstats));
+		tcf_action_inc_drop_qstats(&gact->common);
 
 	tcf_lastuse_update(&gact->tcf_tm);
 
@@ -175,15 +175,7 @@ static void tcf_gact_stats_update(struct tc_action *a, u64 bytes, u32 packets,
 	int action = READ_ONCE(gact->tcf_action);
 	struct tcf_t *tm = &gact->tcf_tm;
 
-	_bstats_cpu_update(this_cpu_ptr(gact->common.cpu_bstats), bytes,
-			   packets);
-	if (action == TC_ACT_SHOT)
-		this_cpu_ptr(gact->common.cpu_qstats)->drops += packets;
-
-	if (hw)
-		_bstats_cpu_update(this_cpu_ptr(gact->common.cpu_bstats_hw),
-				   bytes, packets);
-
+	tcf_action_update_stats(a, bytes, packets, action == TC_ACT_SHOT, hw);
 	tm->lastuse = max_t(u64, tm->lastuse, lastuse);
 }
 
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index e3f28cb03f7e..f1392de686ba 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -28,8 +28,8 @@
 static LIST_HEAD(mirred_list);
 static DEFINE_SPINLOCK(mirred_list_lock);
 
-#define MIRRED_RECURSION_LIMIT    4
-static DEFINE_PER_CPU(unsigned int, mirred_rec_level);
+#define MIRRED_NEST_LIMIT    4
+static DEFINE_PER_CPU(unsigned int, mirred_nest_level);
 
 static bool tcf_mirred_is_act_redirect(int action)
 {
@@ -206,6 +206,25 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 	return err;
 }
 
+static bool is_mirred_nested(void)
+{
+	return unlikely(__this_cpu_read(mirred_nest_level) > 1);
+}
+
+static int tcf_mirred_forward(bool want_ingress, struct sk_buff *skb)
+{
+	int err;
+
+	if (!want_ingress)
+		err = dev_queue_xmit(skb);
+	else if (is_mirred_nested())
+		err = netif_rx(skb);
+	else
+		err = netif_receive_skb(skb);
+
+	return err;
+}
+
 static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 			  struct tcf_result *res)
 {
@@ -213,7 +232,7 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 	struct sk_buff *skb2 = skb;
 	bool m_mac_header_xmit;
 	struct net_device *dev;
-	unsigned int rec_level;
+	unsigned int nest_level;
 	int retval, err = 0;
 	bool use_reinsert;
 	bool want_ingress;
@@ -224,16 +243,16 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 	int mac_len;
 	bool at_nh;
 
-	rec_level = __this_cpu_inc_return(mirred_rec_level);
-	if (unlikely(rec_level > MIRRED_RECURSION_LIMIT)) {
+	nest_level = __this_cpu_inc_return(mirred_nest_level);
+	if (unlikely(nest_level > MIRRED_NEST_LIMIT)) {
 		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
 				     netdev_name(skb->dev));
-		__this_cpu_dec(mirred_rec_level);
+		__this_cpu_dec(mirred_nest_level);
 		return TC_ACT_SHOT;
 	}
 
 	tcf_lastuse_update(&m->tcf_tm);
-	bstats_cpu_update(this_cpu_ptr(m->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&m->common, skb);
 
 	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
 	m_eaction = READ_ONCE(m->tcfm_eaction);
@@ -295,25 +314,22 @@ static int tcf_mirred_act(struct sk_buff *skb, const struct tc_action *a,
 		/* let's the caller reinsert the packet, if possible */
 		if (use_reinsert) {
 			res->ingress = want_ingress;
-			res->qstats = this_cpu_ptr(m->common.cpu_qstats);
-			skb_tc_reinsert(skb, res);
-			__this_cpu_dec(mirred_rec_level);
+			err = tcf_mirred_forward(res->ingress, skb);
+			if (err)
+				tcf_action_inc_overlimit_qstats(&m->common);
+			__this_cpu_dec(mirred_nest_level);
 			return TC_ACT_CONSUMED;
 		}
 	}
 
-	if (!want_ingress)
-		err = dev_queue_xmit(skb2);
-	else
-		err = netif_receive_skb(skb2);
-
+	err = tcf_mirred_forward(want_ingress, skb2);
 	if (err) {
 out:
-		qstats_overlimit_inc(this_cpu_ptr(m->common.cpu_qstats));
+		tcf_action_inc_overlimit_qstats(&m->common);
 		if (tcf_mirred_is_act_redirect(m_eaction))
 			retval = TC_ACT_SHOT;
 	}
-	__this_cpu_dec(mirred_rec_level);
+	__this_cpu_dec(mirred_nest_level);
 
 	return retval;
 }
@@ -324,10 +340,7 @@ static void tcf_stats_update(struct tc_action *a, u64 bytes, u32 packets,
 	struct tcf_mirred *m = to_mirred(a);
 	struct tcf_t *tm = &m->tcf_tm;
 
-	_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), bytes, packets);
-	if (hw)
-		_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats_hw),
-				   bytes, packets);
+	tcf_action_update_stats(a, bytes, packets, false, hw);
 	tm->lastuse = max_t(u64, tm->lastuse, lastuse);
 }
 
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index a7660b602237..b67da92955b1 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -306,10 +306,7 @@ static void tcf_police_stats_update(struct tc_action *a,
 	struct tcf_police *police = to_police(a);
 	struct tcf_t *tm = &police->tcf_tm;
 
-	_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), bytes, packets);
-	if (hw)
-		_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats_hw),
-				   bytes, packets);
+	tcf_action_update_stats(a, bytes, packets, false, hw);
 	tm->lastuse = max_t(u64, tm->lastuse, lastuse);
 }
 
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index a5a2bf01eb9b..e5b0c13d6d58 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -31,7 +31,7 @@ static int tunnel_key_act(struct sk_buff *skb, const struct tc_action *a,
 	params = rcu_dereference_bh(t->params);
 
 	tcf_lastuse_update(&t->tcf_tm);
-	bstats_cpu_update(this_cpu_ptr(t->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&t->common, skb);
 	action = READ_ONCE(t->tcf_action);
 
 	switch (params->tcft_action) {
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 7dc76c68ec52..b4b09c0c8589 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -29,7 +29,7 @@ static int tcf_vlan_act(struct sk_buff *skb, const struct tc_action *a,
 	u16 tci;
 
 	tcf_lastuse_update(&v->tcf_tm);
-	bstats_cpu_update(this_cpu_ptr(v->common.cpu_bstats), skb);
+	tcf_action_update_bstats(&v->common, skb);
 
 	/* Ensure 'data' points at mac_header prior calling vlan manipulating
 	 * functions.
@@ -88,7 +88,7 @@ static int tcf_vlan_act(struct sk_buff *skb, const struct tc_action *a,
 	return action;
 
 drop:
-	qstats_drop_inc(this_cpu_ptr(v->common.cpu_qstats));
+	tcf_action_inc_drop_qstats(&v->common);
 	return TC_ACT_SHOT;
 }
 
@@ -308,10 +308,7 @@ static void tcf_vlan_stats_update(struct tc_action *a, u64 bytes, u32 packets,
 	struct tcf_vlan *v = to_vlan(a);
 	struct tcf_t *tm = &v->tcf_tm;
 
-	_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats), bytes, packets);
-	if (hw)
-		_bstats_cpu_update(this_cpu_ptr(a->cpu_bstats_hw),
-				   bytes, packets);
+	tcf_action_update_stats(a, bytes, packets, false, hw);
 	tm->lastuse = max_t(u64, tm->lastuse, lastuse);
 }
 
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index fc96ec46e6f6..738691b5697b 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1725,7 +1725,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	ktime_t now = ktime_get();
 	struct cake_tin_data *b;
 	struct cake_flow *flow;
-	u32 idx;
+	u32 idx, tin;
 
 	/* choose flow to insert into */
 	idx = cake_classify(sch, &b, skb, q->flow_mode, &ret);
@@ -1735,6 +1735,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		__qdisc_drop(skb, to_free);
 		return ret;
 	}
+	tin = (u32)(b - q->tins);
 	idx--;
 	flow = &b->flows[idx];
 
@@ -1904,13 +1905,22 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		q->buffer_max_used = q->buffer_used;
 
 	if (q->buffer_used > q->buffer_limit) {
+		bool same_flow = false;
 		u32 dropped = 0;
+		u32 drop_id;
 
 		while (q->buffer_used > q->buffer_limit) {
 			dropped++;
-			cake_drop(sch, to_free);
+			drop_id = cake_drop(sch, to_free);
+
+			if ((drop_id >> 16) == tin &&
+			    (drop_id & 0xFFFF) == idx)
+				same_flow = true;
 		}
 		b->drop_overlimit += dropped;
+
+		if (same_flow)
+			return NET_XMIT_CN;
 	}
 	return NET_XMIT_SUCCESS;
 }
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 30169b3adbbb..d9eff03deada 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -95,10 +95,7 @@ static struct sk_buff *codel_qdisc_dequeue(struct Qdisc *sch)
 			    &q->stats, qdisc_pkt_len, codel_get_enqueue_time,
 			    drop_func, dequeue_func);
 
-	/* We cant call qdisc_tree_reduce_backlog() if our qlen is 0,
-	 * or HTB crashes. Defer it for next round.
-	 */
-	if (q->stats.drop_count && sch->q.qlen) {
+	if (q->stats.drop_count) {
 		qdisc_tree_reduce_backlog(sch, q->stats.drop_count, q->stats.drop_len);
 		q->stats.drop_count = 0;
 		q->stats.drop_len = 0;
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 1a0571806342..088084eb393e 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -111,6 +111,7 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	if (cl == NULL)
 		return -ENOBUFS;
 
+	INIT_LIST_HEAD(&cl->alist);
 	cl->common.classid = classid;
 	cl->quantum	   = quantum;
 	cl->qdisc	   = qdisc_create_dflt(sch->dev_queue,
@@ -234,7 +235,7 @@ static void drr_qlen_notify(struct Qdisc *csh, unsigned long arg)
 {
 	struct drr_class *cl = (struct drr_class *)arg;
 
-	list_del(&cl->alist);
+	list_del_init(&cl->alist);
 }
 
 static int drr_dump_class(struct Qdisc *sch, unsigned long arg,
@@ -401,7 +402,7 @@ static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 			if (unlikely(skb == NULL))
 				goto out;
 			if (cl->qdisc->q.qlen == 0)
-				list_del(&cl->alist);
+				list_del_init(&cl->alist);
 
 			bstats_update(&cl->bstats, skb);
 			qdisc_bstats_update(sch, skb);
@@ -442,7 +443,7 @@ static void drr_reset_qdisc(struct Qdisc *sch)
 	for (i = 0; i < q->clhash.hashsize; i++) {
 		hlist_for_each_entry(cl, &q->clhash.hash[i], common.hnode) {
 			if (cl->qdisc->q.qlen)
-				list_del(&cl->alist);
+				list_del_init(&cl->alist);
 			qdisc_reset(cl->qdisc);
 		}
 	}
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 30796bb54972..eb380b43d52c 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -315,10 +315,8 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc *sch)
 	}
 	qdisc_bstats_update(sch, skb);
 	flow->deficit -= qdisc_pkt_len(skb);
-	/* We cant call qdisc_tree_reduce_backlog() if our qlen is 0,
-	 * or HTB crashes. Defer it for next round.
-	 */
-	if (q->cstats.drop_count && sch->q.qlen) {
+
+	if (q->cstats.drop_count) {
 		qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
 					  q->cstats.drop_len);
 		q->cstats.drop_count = 0;
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 0f57dd39b6b8..5cb789c7c82d 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -209,7 +209,10 @@ eltree_insert(struct hfsc_class *cl)
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
@@ -1230,7 +1233,8 @@ hfsc_qlen_notify(struct Qdisc *sch, unsigned long arg)
 	/* vttree is now handled in update_vf() so that update_vf(cl, 0, 0)
 	 * needs to be called explicitly to remove a class from vttree.
 	 */
-	update_vf(cl, 0, 0);
+	if (cl->cl_nactive)
+		update_vf(cl, 0, 0);
 	if (cl->cl_flags & HFSC_RSC)
 		eltree_remove(cl);
 }
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index c618aae25b09..dd5088f7bffb 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -558,7 +558,7 @@ htb_change_class_mode(struct htb_sched *q, struct htb_class *cl, s64 *diff)
  */
 static inline void htb_activate(struct htb_sched *q, struct htb_class *cl)
 {
-	WARN_ON(cl->level || !cl->leaf.q || !cl->leaf.q->q.qlen);
+	WARN_ON(cl->level || !cl->leaf.q);
 
 	if (!cl->prio_activity) {
 		cl->prio_activity = 1 << cl->prio;
@@ -776,7 +776,9 @@ static struct htb_class *htb_lookup_leaf(struct htb_prio *hprio, const int prio)
 		u32 *pid;
 	} stk[TC_HTB_MAXDEPTH], *sp = stk;
 
-	BUG_ON(!hprio->row.rb_node);
+	if (unlikely(!hprio->row.rb_node))
+		return NULL;
+
 	sp->root = hprio->row.rb_node;
 	sp->pptr = &hprio->ptr;
 	sp->pid = &hprio->last_ptr_id;
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 27bd18c74e85..cdf2df194d24 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -962,6 +962,41 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
 	return 0;
 }
 
+static const struct Qdisc_class_ops netem_class_ops;
+
+static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
+			       struct netlink_ext_ack *extack)
+{
+	struct Qdisc *root, *q;
+	unsigned int i;
+
+	root = qdisc_root_sleeping(sch);
+
+	if (sch != root && root->ops->cl_ops == &netem_class_ops) {
+		if (duplicates ||
+		    ((struct netem_sched_data *)qdisc_priv(root))->duplicate)
+			goto err;
+	}
+
+	if (!qdisc_dev(root))
+		return 0;
+
+	hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
+		if (sch != q && q->ops->cl_ops == &netem_class_ops) {
+			if (duplicates ||
+			    ((struct netem_sched_data *)qdisc_priv(q))->duplicate)
+				goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	NL_SET_ERR_MSG(extack,
+		       "netem: cannot mix duplicating netems with other netems in tree");
+	return -EINVAL;
+}
+
 /* Parse netlink message to set options */
 static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 			struct netlink_ext_ack *extack)
@@ -1023,6 +1058,11 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	q->gap = qopt->gap;
 	q->counter = 0;
 	q->loss = qopt->loss;
+
+	ret = check_netem_in_tree(sch, qopt->duplicate, extack);
+	if (ret)
+		goto unlock;
+
 	q->duplicate = qopt->duplicate;
 
 	/* for compatibility with earlier versions.
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index c466d255f786..511f344dbb77 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -348,7 +348,7 @@ static void qfq_deactivate_class(struct qfq_sched *q, struct qfq_class *cl)
 	struct qfq_aggregate *agg = cl->agg;
 
 
-	list_del(&cl->alist); /* remove from RR queue of the aggregate */
+	list_del_init(&cl->alist); /* remove from RR queue of the aggregate */
 	if (list_empty(&agg->active)) /* agg is now inactive */
 		qfq_deactivate_agg(q, agg);
 }
@@ -408,7 +408,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	bool existing = false;
 	struct nlattr *tb[TCA_QFQ_MAX + 1];
 	struct qfq_aggregate *new_agg = NULL;
-	u32 weight, lmax, inv_w;
+	u32 weight, lmax, inv_w, old_weight, old_lmax;
 	int err;
 	int delta_w;
 
@@ -444,12 +444,16 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	inv_w = ONE_FP / weight;
 	weight = ONE_FP / inv_w;
 
-	if (cl != NULL &&
-	    lmax == cl->agg->lmax &&
-	    weight == cl->agg->class_weight)
-		return 0; /* nothing to change */
+	if (cl != NULL) {
+		sch_tree_lock(sch);
+		old_weight = cl->agg->class_weight;
+		old_lmax   = cl->agg->lmax;
+		sch_tree_unlock(sch);
+		if (lmax == old_lmax && weight == old_weight)
+			return 0; /* nothing to change */
+	}
 
-	delta_w = weight - (cl ? cl->agg->class_weight : 0);
+	delta_w = weight - (cl ? old_weight : 0);
 
 	if (q->wsum + delta_w > QFQ_MAX_WSUM) {
 		pr_notice("qfq: total weight out of range (%d + %u)\n",
@@ -478,6 +482,7 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 
 	cl->common.classid = classid;
 	cl->deficit = lmax;
+	INIT_LIST_HEAD(&cl->alist);
 
 	cl->qdisc = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
 				      classid, NULL);
@@ -530,9 +535,6 @@ static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 
 static void qfq_destroy_class(struct Qdisc *sch, struct qfq_class *cl)
 {
-	struct qfq_sched *q = qdisc_priv(sch);
-
-	qfq_rm_from_agg(q, cl);
 	gen_kill_estimator(&cl->rate_est);
 	qdisc_put(cl->qdisc);
 	kfree(cl);
@@ -550,6 +552,7 @@ static int qfq_delete_class(struct Qdisc *sch, unsigned long arg)
 
 	qdisc_purge_queue(cl->qdisc);
 	qdisc_class_hash_remove(&q->clhash, &cl->common);
+	qfq_rm_from_agg(q, cl);
 
 	sch_tree_unlock(sch);
 
@@ -620,6 +623,7 @@ static int qfq_dump_class(struct Qdisc *sch, unsigned long arg,
 {
 	struct qfq_class *cl = (struct qfq_class *)arg;
 	struct nlattr *nest;
+	u32 class_weight, lmax;
 
 	tcm->tcm_parent	= TC_H_ROOT;
 	tcm->tcm_handle	= cl->common.classid;
@@ -628,8 +632,13 @@ static int qfq_dump_class(struct Qdisc *sch, unsigned long arg,
 	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
 	if (nest == NULL)
 		goto nla_put_failure;
-	if (nla_put_u32(skb, TCA_QFQ_WEIGHT, cl->agg->class_weight) ||
-	    nla_put_u32(skb, TCA_QFQ_LMAX, cl->agg->lmax))
+
+	sch_tree_lock(sch);
+	class_weight	= cl->agg->class_weight;
+	lmax		= cl->agg->lmax;
+	sch_tree_unlock(sch);
+	if (nla_put_u32(skb, TCA_QFQ_WEIGHT, class_weight) ||
+	    nla_put_u32(skb, TCA_QFQ_LMAX, lmax))
 		goto nla_put_failure;
 	return nla_nest_end(skb, nest);
 
@@ -646,8 +655,10 @@ static int qfq_dump_class_stats(struct Qdisc *sch, unsigned long arg,
 
 	memset(&xstats, 0, sizeof(xstats));
 
+	sch_tree_lock(sch);
 	xstats.weight = cl->agg->class_weight;
 	xstats.lmax = cl->agg->lmax;
+	sch_tree_unlock(sch);
 
 	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
 				  d, NULL, &cl->bstats) < 0 ||
@@ -991,7 +1002,7 @@ static struct sk_buff *agg_dequeue(struct qfq_aggregate *agg,
 	cl->deficit -= (int) len;
 
 	if (cl->qdisc->q.qlen == 0) /* no more packets, remove from list */
-		list_del(&cl->alist);
+		list_del_init(&cl->alist);
 	else if (cl->deficit < qdisc_pkt_len(cl->qdisc->ops->peek(cl->qdisc))) {
 		cl->deficit += agg->lmax;
 		list_move_tail(&cl->alist, &agg->active);
@@ -1423,6 +1434,8 @@ static void qfq_qlen_notify(struct Qdisc *sch, unsigned long arg)
 	struct qfq_sched *q = qdisc_priv(sch);
 	struct qfq_class *cl = (struct qfq_class *)arg;
 
+	if (list_empty(&cl->alist))
+		return;
 	qfq_deactivate_class(q, cl);
 }
 
@@ -1495,6 +1508,7 @@ static void qfq_destroy_qdisc(struct Qdisc *sch)
 	for (i = 0; i < q->clhash.hashsize; i++) {
 		hlist_for_each_entry_safe(cl, next, &q->clhash.hash[i],
 					  common.hnode) {
+			qfq_rm_from_agg(q, cl);
 			qfq_destroy_class(sch, cl);
 		}
 	}
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index acda65371028..eaaa5d0e17a7 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -77,12 +77,6 @@
 #define SFQ_EMPTY_SLOT		0xffff
 #define SFQ_DEFAULT_HASH_DIVISOR 1024
 
-/* We use 16 bits to store allot, and want to handle packets up to 64K
- * Scale allot by 8 (1<<3) so that no overflow occurs.
- */
-#define SFQ_ALLOT_SHIFT		3
-#define SFQ_ALLOT_SIZE(X)	DIV_ROUND_UP(X, 1 << SFQ_ALLOT_SHIFT)
-
 /* This type should contain at least SFQ_MAX_DEPTH + 1 + SFQ_MAX_FLOWS values */
 typedef u16 sfq_index;
 
@@ -104,7 +98,7 @@ struct sfq_slot {
 	sfq_index	next; /* next slot in sfq RR chain */
 	struct sfq_head dep; /* anchor in dep[] chains */
 	unsigned short	hash; /* hash value (index in ht[]) */
-	short		allot; /* credit for this slot */
+	int		allot; /* credit for this slot */
 
 	unsigned int    backlog;
 	struct red_vars vars;
@@ -120,7 +114,6 @@ struct sfq_sched_data {
 	siphash_key_t 	perturbation;
 	u8		cur_depth;	/* depth of longest slot */
 	u8		flags;
-	unsigned short  scaled_quantum; /* SFQ_ALLOT_SIZE(quantum) */
 	struct tcf_proto __rcu *filter_list;
 	struct tcf_block *block;
 	sfq_index	*ht;		/* Hash table ('divisor' slots) */
@@ -459,7 +452,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		 */
 		q->tail = slot;
 		/* We could use a bigger initial quantum for new flows */
-		slot->allot = q->scaled_quantum;
+		slot->allot = q->quantum;
 	}
 	if (++sch->q.qlen <= q->limit)
 		return NET_XMIT_SUCCESS;
@@ -496,7 +489,7 @@ sfq_dequeue(struct Qdisc *sch)
 	slot = &q->slots[a];
 	if (slot->allot <= 0) {
 		q->tail = slot;
-		slot->allot += q->scaled_quantum;
+		slot->allot += q->quantum;
 		goto next_slot;
 	}
 	skb = slot_dequeue_head(slot);
@@ -515,7 +508,7 @@ sfq_dequeue(struct Qdisc *sch)
 		}
 		q->tail->next = next_a;
 	} else {
-		slot->allot -= SFQ_ALLOT_SIZE(qdisc_pkt_len(skb));
+		slot->allot -= qdisc_pkt_len(skb);
 	}
 	return skb;
 }
@@ -598,7 +591,7 @@ static void sfq_rehash(struct Qdisc *sch)
 				q->tail->next = x;
 			}
 			q->tail = slot;
-			slot->allot = q->scaled_quantum;
+			slot->allot = q->quantum;
 		}
 	}
 	sch->q.qlen -= dropped;
@@ -611,6 +604,7 @@ static void sfq_perturbation(struct timer_list *t)
 	struct Qdisc *sch = q->sch;
 	spinlock_t *root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	siphash_key_t nkey;
+	int period;
 
 	get_random_bytes(&nkey, sizeof(nkey));
 	spin_lock(root_lock);
@@ -619,11 +613,16 @@ static void sfq_perturbation(struct timer_list *t)
 		sfq_rehash(sch);
 	spin_unlock(root_lock);
 
-	if (q->perturb_period)
-		mod_timer(&q->perturb_timer, jiffies + q->perturb_period);
+	/* q->perturb_period can change under us from
+	 * sfq_change() and sfq_destroy().
+	 */
+	period = READ_ONCE(q->perturb_period);
+	if (period)
+		mod_timer(&q->perturb_timer, jiffies + period);
 }
 
-static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
+static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
+		      struct netlink_ext_ack *extack)
 {
 	struct sfq_sched_data *q = qdisc_priv(sch);
 	struct tc_sfq_qopt *ctl = nla_data(opt);
@@ -632,6 +631,15 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
 	struct red_parms *p = NULL;
 	struct sk_buff *to_free = NULL;
 	struct sk_buff *tail = NULL;
+	unsigned int maxflows;
+	unsigned int quantum;
+	unsigned int divisor;
+	int perturb_period;
+	u8 headdrop;
+	u8 maxdepth;
+	int limit;
+	u8 flags;
+
 
 	if (opt->nla_len < nla_attr_size(sizeof(*ctl)))
 		return -EINVAL;
@@ -641,13 +649,17 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
 	    (!is_power_of_2(ctl->divisor) || ctl->divisor > 65536))
 		return -EINVAL;
 
-	/* slot->allot is a short, make sure quantum is not too big. */
-	if (ctl->quantum) {
-		unsigned int scaled = SFQ_ALLOT_SIZE(ctl->quantum);
+	if ((int)ctl->quantum < 0) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
+		return -EINVAL;
+	}
 
-		if (scaled <= 0 || scaled > SHRT_MAX)
-			return -EINVAL;
+	if (ctl->perturb_period < 0 ||
+	    ctl->perturb_period > INT_MAX / HZ) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid perturb period");
+		return -EINVAL;
 	}
+	perturb_period = ctl->perturb_period * HZ;
 
 	if (ctl_v1 && !red_check_params(ctl_v1->qth_min, ctl_v1->qth_max,
 					ctl_v1->Wlog, ctl_v1->Scell_log, NULL))
@@ -657,37 +669,62 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
 		if (!p)
 			return -ENOMEM;
 	}
+
 	sch_tree_lock(sch);
-	if (ctl->quantum) {
-		q->quantum = ctl->quantum;
-		q->scaled_quantum = SFQ_ALLOT_SIZE(q->quantum);
-	}
-	q->perturb_period = ctl->perturb_period * HZ;
+
+	limit = q->limit;
+	divisor = q->divisor;
+	headdrop = q->headdrop;
+	maxdepth = q->maxdepth;
+	maxflows = q->maxflows;
+	quantum = q->quantum;
+	flags = q->flags;
+
+	/* update and validate configuration */
+	if (ctl->quantum)
+		quantum = ctl->quantum;
 	if (ctl->flows)
-		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
+		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
-		q->divisor = ctl->divisor;
-		q->maxflows = min_t(u32, q->maxflows, q->divisor);
+		divisor = ctl->divisor;
+		maxflows = min_t(u32, maxflows, divisor);
 	}
 	if (ctl_v1) {
 		if (ctl_v1->depth)
-			q->maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
+			maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
 		if (p) {
-			swap(q->red_parms, p);
-			red_set_parms(q->red_parms,
+			red_set_parms(p,
 				      ctl_v1->qth_min, ctl_v1->qth_max,
 				      ctl_v1->Wlog,
 				      ctl_v1->Plog, ctl_v1->Scell_log,
 				      NULL,
 				      ctl_v1->max_P);
 		}
-		q->flags = ctl_v1->flags;
-		q->headdrop = ctl_v1->headdrop;
+		flags = ctl_v1->flags;
+		headdrop = ctl_v1->headdrop;
 	}
 	if (ctl->limit) {
-		q->limit = min_t(u32, ctl->limit, q->maxdepth * q->maxflows);
-		q->maxflows = min_t(u32, q->maxflows, q->limit);
+		limit = min_t(u32, ctl->limit, maxdepth * maxflows);
+		maxflows = min_t(u32, maxflows, limit);
 	}
+	if (limit == 1) {
+		sch_tree_unlock(sch);
+		kfree(p);
+		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
+		return -EINVAL;
+	}
+
+	/* commit configuration */
+	q->limit = limit;
+	q->divisor = divisor;
+	q->headdrop = headdrop;
+	q->maxdepth = maxdepth;
+	q->maxflows = maxflows;
+	WRITE_ONCE(q->perturb_period, perturb_period);
+	q->quantum = quantum;
+	q->flags = flags;
+	if (p)
+		swap(q->red_parms, p);
 
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > q->limit) {
@@ -724,7 +761,7 @@ static void sfq_destroy(struct Qdisc *sch)
 	struct sfq_sched_data *q = qdisc_priv(sch);
 
 	tcf_block_put(q->block);
-	q->perturb_period = 0;
+	WRITE_ONCE(q->perturb_period, 0);
 	del_timer_sync(&q->perturb_timer);
 	sfq_free(q->ht);
 	sfq_free(q->slots);
@@ -757,12 +794,11 @@ static int sfq_init(struct Qdisc *sch, struct nlattr *opt,
 	q->divisor = SFQ_DEFAULT_HASH_DIVISOR;
 	q->maxflows = SFQ_DEFAULT_FLOWS;
 	q->quantum = psched_mtu(qdisc_dev(sch));
-	q->scaled_quantum = SFQ_ALLOT_SIZE(q->quantum);
 	q->perturb_period = 0;
 	get_random_bytes(&q->perturbation, sizeof(q->perturbation));
 
 	if (opt) {
-		int err = sfq_change(sch, opt);
+		int err = sfq_change(sch, opt, extack);
 		if (err)
 			return err;
 	}
@@ -873,7 +909,7 @@ static int sfq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	if (idx != SFQ_EMPTY_SLOT) {
 		const struct sfq_slot *slot = &q->slots[idx];
 
-		xstats.allot = slot->allot << SFQ_ALLOT_SHIFT;
+		xstats.allot = slot->allot;
 		qs.qlen = slot->qlen;
 		qs.backlog = slot->backlog;
 	}
diff --git a/net/sctp/input.c b/net/sctp/input.c
index b1d3e342ac83..9013257cf3df 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -114,7 +114,7 @@ int sctp_rcv(struct sk_buff *skb)
 	 * it's better to just linearize it otherwise crc computing
 	 * takes longer.
 	 */
-	if ((!is_gso && skb_linearize(skb)) ||
+	if (((!is_gso || skb_cloned(skb)) && skb_linearize(skb)) ||
 	    !pskb_may_pull(skb, sizeof(struct sctphdr)))
 		goto discard_it;
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 432bce329392..8dabbbf52168 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -822,6 +822,19 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 		delta = msg->sg.size;
 		psock->eval = sk_psock_msg_verdict(sk, psock, msg);
 		delta -= msg->sg.size;
+
+		if ((s32)delta > 0) {
+			/* It indicates that we executed bpf_msg_pop_data(),
+			 * causing the plaintext data size to decrease.
+			 * Therefore the encrypted data size also needs to
+			 * correspondingly decrease. We only need to subtract
+			 * delta to calculate the new ciphertext length since
+			 * ktls does not support block encryption.
+			 */
+			struct sk_msg *enc = &ctx->open_rec->msg_encrypted;
+
+			sk_msg_trim(sk, enc, enc->sg.size - delta);
+		}
 	}
 	if (msg->cork_bytes && msg->cork_bytes > msg->sg.size &&
 	    !enospc && !full_record) {
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 7877515a6962..831ca8da8481 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -487,7 +487,8 @@ static int __vsock_bind_stream(struct vsock_sock *vsk,
 		unsigned int i;
 
 		for (i = 0; i < MAX_PORT_RETRIES; i++) {
-			if (port <= LAST_RESERVED_PORT)
+			if (port == VMADDR_PORT_ANY ||
+			    port <= LAST_RESERVED_PORT)
 				port = LAST_RESERVED_PORT + 1;
 
 			new_addr.svm_port = port++;
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index f9462010575f..ea75459ac272 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -598,7 +598,8 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 
 	mgmt = (const struct ieee80211_mgmt *)params->buf;
 
-	if (!ieee80211_is_mgmt(mgmt->frame_control))
+	if (!ieee80211_is_mgmt(mgmt->frame_control) ||
+	    ieee80211_has_order(mgmt->frame_control))
 		return -EINVAL;
 
 	stype = le16_to_cpu(mgmt->frame_control) & IEEE80211_FCTL_STYPE;
diff --git a/samples/mei/mei-amt-version.c b/samples/mei/mei-amt-version.c
index 32234481ad7d..9e8028e45e3b 100644
--- a/samples/mei/mei-amt-version.c
+++ b/samples/mei/mei-amt-version.c
@@ -69,11 +69,11 @@
 #include <string.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
+#include <sys/time.h>
 #include <unistd.h>
 #include <errno.h>
 #include <stdint.h>
 #include <stdbool.h>
-#include <bits/wordsize.h>
 #include <linux/mei.h>
 
 /*****************************************************************************
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 82eb69f07b35..4d2b8e659747 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -99,16 +99,16 @@ try-run = $(shell set -e;		\
 	fi)
 
 # as-option
-# Usage: cflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
+# Usage: aflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
 
 as-option = $(call try-run,\
-	$(CC) $(KBUILD_CFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2))
+	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(1),$(2))
 
 # as-instr
-# Usage: cflags-y += $(call as-instr,instr,option1,option2)
+# Usage: aflags-y += $(call as-instr,instr,option1,option2)
 
 as-instr = $(call try-run,\
-	printf "%b\n" "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
+	printf "%b\n" "$(1)" | $(CC) -Werror $(CLANG_FLAGS) $(KBUILD_AFLAGS) -c -x assembler-with-cpp -o "$$TMP" -,$(2),$(3))
 
 # __cc-option
 # Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)
diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index 9b10f1248da1..6eb71c75b765 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -786,7 +786,7 @@ static void renderer_edited(GtkCellRendererText * cell,
 	struct symbol *sym;
 
 	if (!gtk_tree_model_get_iter(model2, &iter, path))
-		return;
+		goto free;
 
 	gtk_tree_model_get(model2, &iter, COL_MENU, &menu, -1);
 	sym = menu->sym;
@@ -798,6 +798,7 @@ static void renderer_edited(GtkCellRendererText * cell,
 
 	update_tree(&rootmenu, NULL);
 
+free:
 	gtk_tree_path_free(path);
 }
 
@@ -980,13 +981,14 @@ on_treeview2_key_press_event(GtkWidget * widget,
 void
 on_treeview2_cursor_changed(GtkTreeView * treeview, gpointer user_data)
 {
+	GtkTreeModel *model = gtk_tree_view_get_model(treeview);
 	GtkTreeSelection *selection;
 	GtkTreeIter iter;
 	struct menu *menu;
 
 	selection = gtk_tree_view_get_selection(treeview);
-	if (gtk_tree_selection_get_selected(selection, &model2, &iter)) {
-		gtk_tree_model_get(model2, &iter, COL_MENU, &menu, -1);
+	if (gtk_tree_selection_get_selected(selection, &model, &iter)) {
+		gtk_tree_model_get(model, &iter, COL_MENU, &menu, -1);
 		text_insert_help(menu);
 	}
 }
diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
index 1dcfb288ee63..327b60cdb8da 100644
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -39,8 +39,10 @@ int dialog_inputbox(const char *title, const char *prompt, int height, int width
 
 	if (!init)
 		instr[0] = '\0';
-	else
-		strcpy(instr, init);
+	else {
+		strncpy(instr, init, sizeof(dialog_input_result) - 1);
+		instr[sizeof(dialog_input_result) - 1] = '\0';
+	}
 
 do_resize:
 	if (getmaxy(stdscr) <= (height - INPUTBOX_HEIGTH_MIN))
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index 58c2f8afe59b..7e10e919fbdc 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -272,7 +272,7 @@ int dialog_menu(const char *title, const char *prompt,
 		if (key < 256 && isalpha(key))
 			key = tolower(key);
 
-		if (strchr("ynmh", key))
+		if (strchr("ynmh ", key))
 			i = max_choice;
 		else {
 			for (i = choice + 1; i < max_choice; i++) {
diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index 331b2cc917ec..af56d27693d0 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -580,6 +580,8 @@ static void item_add_str(const char *fmt, ...)
 		tmp_str,
 		sizeof(k_menu_items[index].str));
 
+	k_menu_items[index].str[sizeof(k_menu_items[index].str) - 1] = '\0';
+
 	free_item(curses_menu_items[index]);
 	curses_menu_items[index] = new_item(
 			k_menu_items[index].str,
diff --git a/scripts/kconfig/nconf.gui.c b/scripts/kconfig/nconf.gui.c
index 77f525a8617c..8b3e9bc893a7 100644
--- a/scripts/kconfig/nconf.gui.c
+++ b/scripts/kconfig/nconf.gui.c
@@ -398,6 +398,7 @@ int dialog_inputbox(WINDOW *main_window,
 	x = (columns-win_cols)/2;
 
 	strncpy(result, init, *result_len);
+	result[*result_len - 1] = '\0';
 
 	/* create the windows */
 	win = newwin(win_lines, win_cols, y, x);
diff --git a/security/inode.c b/security/inode.c
index 6c326939750d..e6e07787eec9 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -159,7 +159,6 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 		inode->i_fop = fops;
 	}
 	d_instantiate(dentry, inode);
-	dget(dentry);
 	inode_unlock(dir);
 	return dentry;
 
@@ -306,7 +305,6 @@ void securityfs_remove(struct dentry *dentry)
 			simple_rmdir(dir, dentry);
 		else
 			simple_unlink(dir, dentry);
-		dput(dentry);
 	}
 	inode_unlock(dir);
 	simple_release_fs(&mount, &mount_count);
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 40f50571ad63..dee38dd872b5 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4014,7 +4014,7 @@ static int add_tuning_control(struct hda_codec *codec,
 	}
 	knew.private_value =
 		HDA_COMPOSE_AMP_VAL(nid, 1, 0, type);
-	sprintf(namestr, "%s %s Volume", name, dirstr[dir]);
+	snprintf(namestr, sizeof(namestr), "%s %s Volume", name, dirstr[dir]);
 	return snd_hda_ctl_add(codec, nid, snd_ctl_new1(&knew, codec));
 }
 
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 31ba21b80504..6bc441fa6abe 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4161,6 +4161,8 @@ HDA_CODEC_ENTRY(0x10de002d, "Tegra186 HDMI/DP0", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de002e, "Tegra186 HDMI/DP1", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de002f, "Tegra194 HDMI/DP2", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0030, "Tegra194 HDMI/DP3", patch_tegra_hdmi),
+HDA_CODEC_ENTRY(0x10de0033, "SoC 33 HDMI/DP",	patch_tegra_hdmi),
+HDA_CODEC_ENTRY(0x10de0035, "SoC 35 HDMI/DP",	patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0040, "GPU 40 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0041, "GPU 41 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0042, "GPU 42 HDMI/DP",	patch_nvhdmi),
@@ -4199,15 +4201,32 @@ HDA_CODEC_ENTRY(0x10de0097, "GPU 97 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0098, "GPU 98 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0099, "GPU 99 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de009a, "GPU 9a HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de009b, "GPU 9b HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de009c, "GPU 9c HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de009d, "GPU 9d HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de009e, "GPU 9e HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de009f, "GPU 9f HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a0, "GPU a0 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a1, "GPU a1 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a3, "GPU a3 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a4, "GPU a4 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a5, "GPU a5 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a6, "GPU a6 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a7, "GPU a7 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a8, "GPU a8 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a9, "GPU a9 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00aa, "GPU aa HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00ab, "GPU ab HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00ad, "GPU ad HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00ae, "GPU ae HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00af, "GPU af HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00b0, "GPU b0 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00b1, "GPU b1 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00c0, "GPU c0 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00c1, "GPU c1 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00c3, "GPU c3 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00c4, "GPU c4 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00c5, "GPU c5 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de8001, "MCP73 HDMI",	patch_nvhdmi_2ch),
 HDA_CODEC_ENTRY(0x10de8067, "MCP67/68 HDMI",	patch_nvhdmi_2ch),
 HDA_CODEC_ENTRY(0x11069f80, "VX900 HDMI/DP",	patch_via_hdmi),
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 5150e8d38975..87a23a4660e8 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -2285,7 +2285,7 @@ static int snd_intel8x0_mixer(struct intel8x0 *chip, int ac97_clock,
 			tmp |= chip->ac97_sdin[0] << ICH_DI1L_SHIFT;
 			for (i = 1; i < 4; i++) {
 				if (pcm->r[0].codec[i]) {
-					tmp |= chip->ac97_sdin[pcm->r[0].codec[1]->num] << ICH_DI2L_SHIFT;
+					tmp |= chip->ac97_sdin[pcm->r[0].codec[i]->num] << ICH_DI2L_SHIFT;
 					break;
 				}
 			}
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 78d5b4d31bb6..71d13b413418 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1231,7 +1231,8 @@ static int hdac_hdmi_parse_eld(struct hdac_device *hdev,
 						>> DRM_ELD_VER_SHIFT;
 
 	if (ver != ELD_VER_CEA_861D && ver != ELD_VER_PARTIAL) {
-		dev_err(&hdev->dev, "HDMI: Unknown ELD version %d\n", ver);
+		dev_err_ratelimited(&hdev->dev,
+				    "HDMI: Unknown ELD version %d\n", ver);
 		return -EINVAL;
 	}
 
@@ -1239,7 +1240,8 @@ static int hdac_hdmi_parse_eld(struct hdac_device *hdev,
 		DRM_ELD_MNL_MASK) >> DRM_ELD_MNL_SHIFT;
 
 	if (mnl > ELD_MAX_MNL) {
-		dev_err(&hdev->dev, "HDMI: MNL Invalid %d\n", mnl);
+		dev_err_ratelimited(&hdev->dev,
+				    "HDMI: MNL Invalid %d\n", mnl);
 		return -EINVAL;
 	}
 
@@ -1293,8 +1295,8 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 
 	if (!port->eld.monitor_present || !port->eld.eld_valid) {
 
-		dev_err(&hdev->dev, "%s: disconnect for pin:port %d:%d\n",
-						__func__, pin->nid, port->id);
+		dev_dbg(&hdev->dev, "%s: disconnect for pin:port %d:%d\n",
+			__func__, pin->nid, port->id);
 
 		/*
 		 * PCMs are not registered during device probe, so don't
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 3bc63fbcb188..e290a83c20af 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2810,6 +2810,11 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 	}
 
 	regmap_read(rt5640->regmap, RT5640_VENDOR_ID2, &val);
+	if (val != RT5640_DEVICE_ID) {
+		usleep_range(60000, 100000);
+		regmap_read(rt5640->regmap, RT5640_VENDOR_ID2, &val);
+	}
+
 	if (val != RT5640_DEVICE_ID) {
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt5640/39\n", val);
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index fdbfaedda4ce..219c4133d26e 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -565,13 +565,15 @@ static void fsl_sai_config_disable(struct fsl_sai *sai, int dir)
 	 * anymore. Add software reset to fix this issue.
 	 * This is a hardware bug, and will be fix in the
 	 * next sai version.
+	 *
+	 * In consumer mode, this can happen even after a
+	 * single open/close, especially if both tx and rx
+	 * are running concurrently.
 	 */
-	if (!sai->is_slave_mode) {
-		/* Software Reset */
-		regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), FSL_SAI_CSR_SR);
-		/* Clear SR bit to finish the reset */
-		regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), 0);
-	}
+	/* Software Reset */
+	regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), FSL_SAI_CSR_SR);
+	/* Clear SR bit to finish the reset */
+	regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), 0);
 }
 
 static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 5c27f7ab4a5f..78a75c29ed88 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -11,7 +11,7 @@ menuconfig SND_SOC_INTEL_MACH
          kernel: saying N will just cause the configurator to skip all
          the questions about Intel ASoC machine drivers.
 
-if SND_SOC_INTEL_MACH
+if SND_SOC_INTEL_MACH && (SND_SOC_SOF_INTEL_COMMON || !SND_SOC_SOF_INTEL_COMMON)
 
 if SND_SOC_INTEL_HASWELL
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9f764d92469e..6142ce468c3b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -741,6 +741,10 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_dapm_context *dapm,
 out:
 	trace_snd_soc_bias_level_done(card, level);
 
+	/* success */
+	if (ret == 0)
+		snd_soc_dapm_init_bias_level(dapm, level);
+
 	return ret;
 }
 
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index a3b1f1c064dd..02e4f336b524 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -638,28 +638,32 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw_range);
 static int snd_soc_clip_to_platform_max(struct snd_kcontrol *kctl)
 {
 	struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
-	struct snd_ctl_elem_value uctl;
+	struct snd_ctl_elem_value *uctl;
 	int ret;
 
 	if (!mc->platform_max)
 		return 0;
 
-	ret = kctl->get(kctl, &uctl);
+	uctl = kzalloc(sizeof(*uctl), GFP_KERNEL);
+	if (!uctl)
+		return -ENOMEM;
+
+	ret = kctl->get(kctl, uctl);
 	if (ret < 0)
-		return ret;
+		goto out;
 
-	if (uctl.value.integer.value[0] > mc->platform_max)
-		uctl.value.integer.value[0] = mc->platform_max;
+	if (uctl->value.integer.value[0] > mc->platform_max)
+		uctl->value.integer.value[0] = mc->platform_max;
 
 	if (snd_soc_volsw_is_stereo(mc) &&
-	    uctl.value.integer.value[1] > mc->platform_max)
-		uctl.value.integer.value[1] = mc->platform_max;
+	    uctl->value.integer.value[1] > mc->platform_max)
+		uctl->value.integer.value[1] = mc->platform_max;
 
-	ret = kctl->put(kctl, &uctl);
-	if (ret < 0)
-		return ret;
+	ret = kctl->put(kctl, uctl);
 
-	return 0;
+out:
+	kfree(uctl);
+	return ret;
 }
 
 /**
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index e752b6bb03ec..04267d4e3ecf 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1990,15 +1990,15 @@ static int dell_dock_mixer_init(struct usb_mixer_interface *mixer)
 #define SND_RME_CLK_FREQMUL_SHIFT		18
 #define SND_RME_CLK_FREQMUL_MASK		0x7
 #define SND_RME_CLK_SYSTEM(x) \
-	((x >> SND_RME_CLK_SYSTEM_SHIFT) & SND_RME_CLK_SYSTEM_MASK)
+	(((x) >> SND_RME_CLK_SYSTEM_SHIFT) & SND_RME_CLK_SYSTEM_MASK)
 #define SND_RME_CLK_AES(x) \
-	((x >> SND_RME_CLK_AES_SHIFT) & SND_RME_CLK_AES_SPDIF_MASK)
+	(((x) >> SND_RME_CLK_AES_SHIFT) & SND_RME_CLK_AES_SPDIF_MASK)
 #define SND_RME_CLK_SPDIF(x) \
-	((x >> SND_RME_CLK_SPDIF_SHIFT) & SND_RME_CLK_AES_SPDIF_MASK)
+	(((x) >> SND_RME_CLK_SPDIF_SHIFT) & SND_RME_CLK_AES_SPDIF_MASK)
 #define SND_RME_CLK_SYNC(x) \
-	((x >> SND_RME_CLK_SYNC_SHIFT) & SND_RME_CLK_SYNC_MASK)
+	(((x) >> SND_RME_CLK_SYNC_SHIFT) & SND_RME_CLK_SYNC_MASK)
 #define SND_RME_CLK_FREQMUL(x) \
-	((x >> SND_RME_CLK_FREQMUL_SHIFT) & SND_RME_CLK_FREQMUL_MASK)
+	(((x) >> SND_RME_CLK_FREQMUL_SHIFT) & SND_RME_CLK_FREQMUL_MASK)
 #define SND_RME_CLK_AES_LOCK			0x1
 #define SND_RME_CLK_AES_SYNC			0x4
 #define SND_RME_CLK_SPDIF_LOCK			0x2
@@ -2007,9 +2007,9 @@ static int dell_dock_mixer_init(struct usb_mixer_interface *mixer)
 #define SND_RME_SPDIF_FORMAT_SHIFT		5
 #define SND_RME_BINARY_MASK			0x1
 #define SND_RME_SPDIF_IF(x) \
-	((x >> SND_RME_SPDIF_IF_SHIFT) & SND_RME_BINARY_MASK)
+	(((x) >> SND_RME_SPDIF_IF_SHIFT) & SND_RME_BINARY_MASK)
 #define SND_RME_SPDIF_FORMAT(x) \
-	((x >> SND_RME_SPDIF_FORMAT_SHIFT) & SND_RME_BINARY_MASK)
+	(((x) >> SND_RME_SPDIF_FORMAT_SHIFT) & SND_RME_BINARY_MASK)
 
 static const u32 snd_rme_rate_table[] = {
 	32000, 44100, 48000, 50000,
diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index 6d8ef3aa99b5..3b225430bfad 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -118,6 +118,8 @@
 #define SCARLETT2_MIXER_MAX_VALUE \
 	((SCARLETT2_MIXER_MAX_DB - SCARLETT2_MIXER_MIN_DB) * 2)
 
+#include <linux/delay.h>
+
 /* map from (dB + 80) * 2 to mixer value
  * for dB in 0 .. 172: int(8192 * pow(10, ((dB - 160) / 2 / 20)))
  */
@@ -591,6 +593,8 @@ static int scarlett2_usb(
 	u16 req_buf_size = sizeof(struct scarlett2_usb_packet) + req_size;
 	u16 resp_buf_size = sizeof(struct scarlett2_usb_packet) + resp_size;
 	struct scarlett2_usb_packet *req = NULL, *resp = NULL;
+	int retries = 0;
+	const int max_retries = 5;
 	int err = 0;
 
 	req = kmalloc(req_buf_size, GFP_KERNEL);
@@ -614,6 +618,7 @@ static int scarlett2_usb(
 	if (req_size)
 		memcpy(req->data, req_data, req_size);
 
+retry:
 	err = snd_usb_ctl_msg(mixer->chip->dev,
 			usb_sndctrlpipe(mixer->chip->dev, 0),
 			SCARLETT2_USB_VENDOR_SPECIFIC_CMD_REQ,
@@ -624,6 +629,10 @@ static int scarlett2_usb(
 			req_buf_size);
 
 	if (err != req_buf_size) {
+		if (err == -EPROTO && ++retries <= max_retries) {
+			msleep(5 * (1 << (retries - 1)));
+			goto retry;
+		}
 		usb_audio_err(
 			mixer->chip,
 			"Scarlett Gen 2 USB request result cmd %x was %d\n",
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index d698b609fe52..bb919f1d4043 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -342,20 +342,28 @@ snd_pcm_chmap_elem *convert_chmap_v3(struct uac3_cluster_header_descriptor
 
 	len = le16_to_cpu(cluster->wLength);
 	c = 0;
-	p += sizeof(struct uac3_cluster_header_descriptor);
+	p += sizeof(*cluster);
+	len -= sizeof(*cluster);
 
-	while (((p - (void *)cluster) < len) && (c < channels)) {
+	while (len > 0 && (c < channels)) {
 		struct uac3_cluster_segment_descriptor *cs_desc = p;
 		u16 cs_len;
 		u8 cs_type;
 
+		if (len < sizeof(*cs_desc))
+			break;
 		cs_len = le16_to_cpu(cs_desc->wLength);
+		if (len < cs_len)
+			break;
 		cs_type = cs_desc->bSegmentType;
 
 		if (cs_type == UAC3_CHANNEL_INFORMATION) {
 			struct uac3_cluster_information_segment_descriptor *is = p;
 			unsigned char map;
 
+			if (cs_len < sizeof(*is))
+				break;
+
 			/*
 			 * TODO: this conversion is not complete, update it
 			 * after adding UAC3 values to asound.h
@@ -457,6 +465,7 @@ snd_pcm_chmap_elem *convert_chmap_v3(struct uac3_cluster_header_descriptor
 			chmap->map[c++] = map;
 		}
 		p += cs_len;
+		len -= cs_len;
 	}
 
 	if (channels < c)
@@ -873,7 +882,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 	u64 badd_formats = 0;
 	unsigned int num_channels;
 	struct audioformat *fp;
-	u16 cluster_id, wLength;
+	u16 cluster_id, wLength, cluster_wLength;
 	int clock = 0;
 	int err;
 
@@ -1002,6 +1011,16 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 		return ERR_PTR(-EIO);
 	}
 
+	cluster_wLength = le16_to_cpu(cluster->wLength);
+	if (cluster_wLength < sizeof(*cluster) ||
+	    cluster_wLength > wLength) {
+		dev_err(&dev->dev,
+			"%u:%d : invalid Cluster Descriptor size\n",
+			iface_no, altno);
+		kfree(cluster);
+		return ERR_PTR(-EIO);
+	}
+
 	num_channels = cluster->bNrChannels;
 	chmap = convert_chmap_v3(cluster);
 	kfree(cluster);
diff --git a/sound/usb/validate.c b/sound/usb/validate.c
index 89a48d731719..46cf36ab0acd 100644
--- a/sound/usb/validate.c
+++ b/sound/usb/validate.c
@@ -221,6 +221,17 @@ static bool validate_uac3_feature_unit(const void *p,
 	return d->bLength >= sizeof(*d) + 4 + 2;
 }
 
+static bool validate_uac3_power_domain_unit(const void *p,
+					    const struct usb_desc_validator *v)
+{
+	const struct uac3_power_domain_descriptor *d = p;
+
+	if (d->bLength < sizeof(*d))
+		return false;
+	/* baEntities[] + wPDomainDescrStr */
+	return d->bLength >= sizeof(*d) + d->bNrEntities + 2;
+}
+
 static bool validate_midi_out_jack(const void *p,
 				   const struct usb_desc_validator *v)
 {
@@ -274,7 +285,7 @@ static const struct usb_desc_validator audio_validators[] = {
 	/* UAC_VERSION_3, UAC3_EXTENDED_TERMINAL: not implemented yet */
 	FUNC(UAC_VERSION_3, UAC3_MIXER_UNIT, validate_mixer_unit),
 	FUNC(UAC_VERSION_3, UAC3_SELECTOR_UNIT, validate_selector_unit),
-	FUNC(UAC_VERSION_3, UAC_FEATURE_UNIT, validate_uac3_feature_unit),
+	FUNC(UAC_VERSION_3, UAC3_FEATURE_UNIT, validate_uac3_feature_unit),
 	/*  UAC_VERSION_3, UAC3_EFFECT_UNIT: not implemented yet */
 	FUNC(UAC_VERSION_3, UAC3_PROCESSING_UNIT, validate_processing_unit),
 	FUNC(UAC_VERSION_3, UAC3_EXTENSION_UNIT, validate_processing_unit),
@@ -285,6 +296,7 @@ static const struct usb_desc_validator audio_validators[] = {
 	      struct uac3_clock_multiplier_descriptor),
 	/* UAC_VERSION_3, UAC3_SAMPLE_RATE_CONVERTER: not implemented yet */
 	/* UAC_VERSION_3, UAC3_CONNECTORS: not implemented yet */
+	FUNC(UAC_VERSION_3, UAC3_POWER_DOMAIN, validate_uac3_power_domain_unit),
 	{ } /* terminator */
 };
 
diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index c6787a1daa48..c2953b2bf130 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -87,17 +87,18 @@ static int dump_link_nlmsg(void *cookie, void *msg, struct nlattr **tb)
 {
 	struct bpf_netdev_t *netinfo = cookie;
 	struct ifinfomsg *ifinfo = msg;
+	struct ip_devname_ifindex *tmp;
 
 	if (netinfo->filter_idx > 0 && netinfo->filter_idx != ifinfo->ifi_index)
 		return 0;
 
 	if (netinfo->used_len == netinfo->array_len) {
-		netinfo->devices = realloc(netinfo->devices,
-			(netinfo->array_len + 16) *
-			sizeof(struct ip_devname_ifindex));
-		if (!netinfo->devices)
+		tmp = realloc(netinfo->devices,
+			(netinfo->array_len + 16) * sizeof(struct ip_devname_ifindex));
+		if (!tmp)
 			return -ENOMEM;
 
+		netinfo->devices = tmp;
 		netinfo->array_len += 16;
 	}
 	netinfo->devices[netinfo->used_len].ifindex = ifinfo->ifi_index;
@@ -116,6 +117,7 @@ static int dump_class_qdisc_nlmsg(void *cookie, void *msg, struct nlattr **tb)
 {
 	struct bpf_tcinfo_t *tcinfo = cookie;
 	struct tcmsg *info = msg;
+	struct tc_kind_handle *tmp;
 
 	if (tcinfo->is_qdisc) {
 		/* skip clsact qdisc */
@@ -127,11 +129,12 @@ static int dump_class_qdisc_nlmsg(void *cookie, void *msg, struct nlattr **tb)
 	}
 
 	if (tcinfo->used_len == tcinfo->array_len) {
-		tcinfo->handle_array = realloc(tcinfo->handle_array,
+		tmp = realloc(tcinfo->handle_array,
 			(tcinfo->array_len + 16) * sizeof(struct tc_kind_handle));
-		if (!tcinfo->handle_array)
+		if (!tmp)
 			return -ENOMEM;
 
+		tcinfo->handle_array = tmp;
 		tcinfo->array_len += 16;
 	}
 	tcinfo->handle_array[tcinfo->used_len].handle = info->tcm_handle;
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 55a9de311d7b..e1ff0faa0149 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -93,6 +93,7 @@ static int bp_accounting(int wp_cnt, int share)
 		fd_wp = wp_event((void *)&the_var, &attr_new);
 		TEST_ASSERT_VAL("failed to create max wp\n", fd_wp != -1);
 		pr_debug("wp max created\n");
+		close(fd_wp);
 	}
 
 	for (i = 0; i < wp_cnt; i++)
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index 0e8c0b879d4b..09c606760464 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -201,9 +201,9 @@ static int mperf_stop(void)
 	int cpu;
 
 	for (cpu = 0; cpu < cpu_count; cpu++) {
-		mperf_measure_stats(cpu);
-		mperf_get_tsc(&tsc_at_measure_end[cpu]);
 		clock_gettime(CLOCK_REALTIME, &time_end[cpu]);
+		mperf_get_tsc(&tsc_at_measure_end[cpu]);
+		mperf_measure_stats(cpu);
 	}
 
 	return 0;
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 10b3c5b25b69..964a531e1a65 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1280,7 +1280,10 @@ sub __eval_option {
 	# If a variable contains itself, use the default var
 	if (($var eq $name) && defined($opt{$var})) {
 	    $o = $opt{$var};
-	    $retval = "$retval$o";
+	    # Only append if the default doesn't contain itself
+	    if ($o !~ m/\$\{$var\}/) {
+		$retval = "$retval$o";
+	    }
 	} elsif (defined($opt{$o})) {
 	    $o = $opt{$o};
 	    $retval = "$retval$o";
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
index f4e92afab14b..9a7b7c62cbd9 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
@@ -33,7 +33,7 @@ ftrace_filter_check 'schedule*' '^schedule.*$'
 ftrace_filter_check '*pin*lock' '.*pin.*lock$'
 
 # filter by start*mid*
-ftrace_filter_check 'mutex*try*' '^mutex.*try.*'
+ftrace_filter_check 'mutex*unl*' '^mutex.*unl.*'
 
 # Advanced full-glob matching feature is recently supported.
 # Skip the tests if we are sure the kernel does not support it.
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
index ddbcfc9b7bac..7a5fd1d5355e 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -47,6 +47,17 @@ typedef volatile u_int32_t futex_t;
 					 FUTEX_PRIVATE_FLAG)
 #endif
 
+/*
+ * SYS_futex is expected from system C library, in glibc some 32-bit
+ * architectures (e.g. RV32) are using 64-bit time_t, therefore it doesn't have
+ * SYS_futex defined but just SYS_futex_time64. Define SYS_futex as
+ * SYS_futex_time64 in this situation to ensure the compilation and the
+ * compatibility.
+ */
+#if !defined(SYS_futex) && defined(SYS_futex_time64)
+#define SYS_futex SYS_futex_time64
+#endif
+
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
index 813d02d1939d..1e27031288c8 100755
--- a/tools/testing/selftests/net/forwarding/tc_actions.sh
+++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
@@ -2,7 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ALL_TESTS="gact_drop_and_ok_test mirred_egress_redirect_test \
-	mirred_egress_mirror_test gact_trap_test"
+	mirred_egress_mirror_test matchall_mirred_egress_mirror_test \
+	gact_trap_test mirred_egress_to_ingress_tcp_test"
 NUM_NETIFS=4
 source tc_common.sh
 source lib.sh
@@ -50,6 +51,9 @@ switch_destroy()
 mirred_egress_test()
 {
 	local action=$1
+	local protocol=$2
+	local classifier=$3
+	local classifier_args=$4
 
 	RET=0
 
@@ -62,9 +66,9 @@ mirred_egress_test()
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched without redirect rule inserted"
 
-	tc filter add dev $swp1 ingress protocol ip pref 1 handle 101 flower \
-		$tcflags dst_ip 192.0.2.2 action mirred egress $action \
-		dev $swp2
+	tc filter add dev $swp1 ingress protocol $protocol pref 1 handle 101 \
+		$classifier $tcflags $classifier_args \
+		action mirred egress $action dev $swp2
 
 	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
 		-t ip -q
@@ -72,10 +76,11 @@ mirred_egress_test()
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_err $? "Did not match incoming $action packet"
 
-	tc filter del dev $swp1 ingress protocol ip pref 1 handle 101 flower
+	tc filter del dev $swp1 ingress protocol $protocol pref 1 handle 101 \
+		$classifier
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 
-	log_test "mirred egress $action ($tcflags)"
+	log_test "mirred egress $classifier $action ($tcflags)"
 }
 
 gact_drop_and_ok_test()
@@ -148,6 +153,52 @@ gact_trap_test()
 	log_test "trap ($tcflags)"
 }
 
+mirred_egress_to_ingress_tcp_test()
+{
+	local tmpfile=$(mktemp) tmpfile1=$(mktemp)
+
+	RET=0
+	dd conv=sparse status=none if=/dev/zero bs=1M count=2 of=$tmpfile
+	tc filter add dev $h1 protocol ip pref 100 handle 100 egress flower \
+		$tcflags ip_proto tcp src_ip 192.0.2.1 dst_ip 192.0.2.2 \
+			action ct commit nat src addr 192.0.2.2 pipe \
+			action ct clear pipe \
+			action ct commit nat dst addr 192.0.2.1 pipe \
+			action ct clear pipe \
+			action skbedit ptype host pipe \
+			action mirred ingress redirect dev $h1
+	tc filter add dev $h1 protocol ip pref 101 handle 101 egress flower \
+		$tcflags ip_proto icmp \
+			action mirred ingress redirect dev $h1
+	tc filter add dev $h1 protocol ip pref 102 handle 102 ingress flower \
+		ip_proto icmp \
+			action drop
+
+	ip vrf exec v$h1 nc --recv-only -w10 -l -p 12345 -o $tmpfile1  &
+	local rpid=$!
+	ip vrf exec v$h1 nc -w1 --send-only 192.0.2.2 12345 <$tmpfile
+	wait -n $rpid
+	cmp -s $tmpfile $tmpfile1
+	check_err $? "server output check failed"
+
+	$MZ $h1 -c 10 -p 64 -a $h1mac -b $h1mac -A 192.0.2.1 -B 192.0.2.1 \
+		-t icmp "ping,id=42,seq=5" -q
+	tc_check_packets "dev $h1 egress" 101 10
+	check_err $? "didn't mirred redirect ICMP"
+	tc_check_packets "dev $h1 ingress" 102 10
+	check_err $? "didn't drop mirred ICMP"
+	local overlimits=$(tc_rule_stats_get ${h1} 101 egress .overlimits)
+	test ${overlimits} = 10
+	check_err $? "wrong overlimits, expected 10 got ${overlimits}"
+
+	tc filter del dev $h1 egress protocol ip pref 100 handle 100 flower
+	tc filter del dev $h1 egress protocol ip pref 101 handle 101 flower
+	tc filter del dev $h1 ingress protocol ip pref 102 handle 102 flower
+
+	rm -f $tmpfile $tmpfile1
+	log_test "mirred_egress_to_ingress_tcp ($tcflags)"
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
@@ -187,12 +238,17 @@ cleanup()
 
 mirred_egress_redirect_test()
 {
-	mirred_egress_test "redirect"
+	mirred_egress_test "redirect" "ip" "flower" "dst_ip 192.0.2.2"
 }
 
 mirred_egress_mirror_test()
 {
-	mirred_egress_test "mirror"
+	mirred_egress_test "mirror" "ip" "flower" "dst_ip 192.0.2.2"
+}
+
+matchall_mirred_egress_mirror_test()
+{
+	mirred_egress_test "mirror" "all" "matchall" ""
 }
 
 trap cleanup EXIT
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 3b929e031f59..0c343954a17b 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -744,6 +744,11 @@ kci_test_ipsec_offload()
 	sysfsf=$sysfsd/ipsec
 	sysfsnet=/sys/bus/netdevsim/devices/netdevsim0/net/
 	probed=false
+	esp4_offload_probed_default=false
+
+	if lsmod | grep -q esp4_offload; then
+		esp4_offload_probed_default=true
+	fi
 
 	# setup netdevsim since dummydev doesn't have offload support
 	if [ ! -w /sys/bus/netdevsim/new_device ] ; then
@@ -833,6 +838,7 @@ EOF
 	fi
 
 	# clean up any leftovers
+	! "$esp4_offload_probed_default" && lsmod | grep -q esp4_offload && rmmod esp4_offload
 	echo 0 > /sys/bus/netdevsim/del_device
 	$probed && rmmod netdevsim
 

