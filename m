Return-Path: <stable+bounces-98788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 546459E542E
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 12:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7809C1882911
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90092207E16;
	Thu,  5 Dec 2024 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Qq7Z+g1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D78207E12;
	Thu,  5 Dec 2024 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398928; cv=none; b=rbrxLF8FxDPBlZY9j0IxCzNzFgwJ5IjCMp9B4D8WwaNwGoArm/w7dC/svH8QqkFqPJ4eEAEvS3hnQCpjmzM5isGFZcAj7+FdH4oLgHfGlWy7UEOTu46mz8XKb/6gq8yckD1BLYfz8K7KdlB8N1g6x1Esso5E+FMhMDta157PeyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398928; c=relaxed/simple;
	bh=/lEkyLbZ3rtnBX4u4OQK0NYMkDMfUU6xeAvaWjYAOfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBeyajAGC5BwgnTBciMT6YgWo8zxPBmcA/hnEVIEMGgJHlHp/zz4R6A2umtPeMp4dvFdPe/fgMJbqICX8aXIpsL9vwBG7n0lzJRDRUJ6fwtCo8cpgWWsZlIpo6kzJRZWdSaYZvpoDG35pWnUfXddIpGpEGJ8+avejF789+4ONI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Qq7Z+g1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B3CC4CED1;
	Thu,  5 Dec 2024 11:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733398927;
	bh=/lEkyLbZ3rtnBX4u4OQK0NYMkDMfUU6xeAvaWjYAOfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2Qq7Z+g1tkEIn427raRu9YN/68aV9GnsHSEEAHznAhMozjFFlG1q9Hk8lVJSicJov
	 470QJOwBjkXRfKWrhFoCgr8nVyV0v9iakP+Sz3jTr7cgn9nDtOMQL5wUIZpVBTrVOS
	 Vxf/7WStWXw4A69/scagGCekkHyoTaqE0iBUqcE8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.325
Date: Thu,  5 Dec 2024 12:42:00 +0100
Message-ID: <2024120520-preorder-untracked-6e5b@gregkh>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2024120520-mashing-facing-6776@gregkh>
References: <2024120520-mashing-facing-6776@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
new file mode 100644
index 000000000000..bb2eec3021a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/adi,axi-clkgen.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binding for Analog Devices AXI clkgen pcore clock generator
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  The axi_clkgen IP core is a software programmable clock generator,
+  that can be synthesized on various FPGA platforms.
+
+  Link: https://wiki.analog.com/resources/fpga/docs/axi_clkgen
+
+properties:
+  compatible:
+    enum:
+      - adi,axi-clkgen-2.00.a
+
+  clocks:
+    description:
+      Specifies the reference clock(s) from which the output frequency is
+      derived. This must either reference one clock if only the first clock
+      input is connected or two if both clock inputs are connected. The last
+      clock is the AXI bus clock that needs to be enabled so we can access the
+      core registers.
+    minItems: 2
+    maxItems: 3
+
+  clock-names:
+    oneOf:
+      - items:
+          - const: clkin1
+          - const: s_axi_aclk
+      - items:
+          - const: clkin1
+          - const: clkin2
+          - const: s_axi_aclk
+
+  '#clock-cells':
+    const: 0
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@ff000000 {
+      compatible = "adi,axi-clkgen-2.00.a";
+      #clock-cells = <0>;
+      reg = <0xff000000 0x1000>;
+      clocks = <&osc 1>, <&clkc 15>;
+      clock-names = "clkin1", "s_axi_aclk";
+    };
diff --git a/Documentation/devicetree/bindings/clock/axi-clkgen.txt b/Documentation/devicetree/bindings/clock/axi-clkgen.txt
deleted file mode 100644
index aca94fe9416f..000000000000
--- a/Documentation/devicetree/bindings/clock/axi-clkgen.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Binding for the axi-clkgen clock generator
-
-This binding uses the common clock binding[1].
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Required properties:
-- compatible : shall be "adi,axi-clkgen-1.00.a" or "adi,axi-clkgen-2.00.a".
-- #clock-cells : from common clock binding; Should always be set to 0.
-- reg : Address and length of the axi-clkgen register set.
-- clocks : Phandle and clock specifier for the parent clock(s). This must
-	either reference one clock if only the first clock input is connected or two
-	if both clock inputs are connected. For the later case the clock connected
-	to the first input must be specified first.
-
-Optional properties:
-- clock-output-names : From common clock binding.
-
-Example:
-	clock@ff000000 {
-		compatible = "adi,axi-clkgen";
-		#clock-cells = <0>;
-		reg = <0xff000000 0x1000>;
-		clocks = <&osc 1>;
-	};
diff --git a/Makefile b/Makefile
index bb5071b9a89a..8df76f9b0712 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 324
+SUBLEVEL = 325
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 85da85faf869..0e37ae46348a 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -253,8 +253,8 @@
 
 			reg_dcdc5: dcdc5 {
 				regulator-always-on;
-				regulator-min-microvolt = <1425000>;
-				regulator-max-microvolt = <1575000>;
+				regulator-min-microvolt = <1450000>;
+				regulator-max-microvolt = <1550000>;
 				regulator-name = "vcc-dram";
 			};
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 1945b8096a06..668421b97dba 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -382,7 +382,7 @@ static void tls_thread_switch(struct task_struct *next)
 
 	if (is_compat_thread(task_thread_info(next)))
 		write_sysreg(next->thread.uw.tp_value, tpidrro_el0);
-	else if (!arm64_kernel_unmapped_at_el0())
+	else
 		write_sysreg(0, tpidrro_el0);
 
 	write_sysreg(*task_user_tls(next), tpidr_el0);
diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
index 908d58347790..b900931669ad 100644
--- a/arch/m68k/coldfire/device.c
+++ b/arch/m68k/coldfire/device.c
@@ -89,7 +89,7 @@ static struct platform_device mcf_uart = {
 	.dev.platform_data	= mcf_uart_platform_data,
 };
 
-#if IS_ENABLED(CONFIG_FEC)
+#ifdef MCFFEC_BASE0
 
 #ifdef CONFIG_M5441x
 #define FEC_NAME	"enet-fec"
@@ -141,6 +141,7 @@ static struct platform_device mcf_fec0 = {
 		.platform_data		= FEC_PDATA,
 	}
 };
+#endif /* MCFFEC_BASE0 */
 
 #ifdef MCFFEC_BASE1
 static struct resource mcf_fec1_resources[] = {
@@ -178,7 +179,6 @@ static struct platform_device mcf_fec1 = {
 	}
 };
 #endif /* MCFFEC_BASE1 */
-#endif /* CONFIG_FEC */
 
 #if IS_ENABLED(CONFIG_SPI_COLDFIRE_QSPI)
 /*
@@ -478,12 +478,12 @@ static struct platform_device mcf_i2c5 = {
 
 static struct platform_device *mcf_devices[] __initdata = {
 	&mcf_uart,
-#if IS_ENABLED(CONFIG_FEC)
+#ifdef MCFFEC_BASE0
 	&mcf_fec0,
+#endif
 #ifdef MCFFEC_BASE1
 	&mcf_fec1,
 #endif
-#endif
 #if IS_ENABLED(CONFIG_SPI_COLDFIRE_QSPI)
 	&mcf_qspi,
 #endif
diff --git a/arch/m68k/include/asm/mcfgpio.h b/arch/m68k/include/asm/mcfgpio.h
index 66203c334c6f..6c5d70defc1e 100644
--- a/arch/m68k/include/asm/mcfgpio.h
+++ b/arch/m68k/include/asm/mcfgpio.h
@@ -152,7 +152,7 @@ static inline void gpio_free(unsigned gpio)
  * read-modify-write as well as those controlled by the EPORT and GPIO modules.
  */
 #define MCFGPIO_SCR_START		40
-#elif defined(CONFIGM5441x)
+#elif defined(CONFIG_M5441x)
 /* The m5441x EPORT doesn't have its own GPIO port, uses PORT C */
 #define MCFGPIO_SCR_START		0
 #else
diff --git a/arch/m68k/include/asm/mvme147hw.h b/arch/m68k/include/asm/mvme147hw.h
index 9c7ff67c5ffd..46ce392db6fc 100644
--- a/arch/m68k/include/asm/mvme147hw.h
+++ b/arch/m68k/include/asm/mvme147hw.h
@@ -90,8 +90,8 @@ struct pcc_regs {
 #define M147_SCC_B_ADDR		0xfffe3000
 #define M147_SCC_PCLK		5000000
 
-#define MVME147_IRQ_SCSI_PORT	(IRQ_USER+0x45)
-#define MVME147_IRQ_SCSI_DMA	(IRQ_USER+0x46)
+#define MVME147_IRQ_SCSI_PORT	(IRQ_USER + 5)
+#define MVME147_IRQ_SCSI_DMA	(IRQ_USER + 6)
 
 /* SCC interrupts, for MVME147 */
 
diff --git a/arch/m68k/kernel/early_printk.c b/arch/m68k/kernel/early_printk.c
index 7d3fe08a48eb..f11ef9f1f56f 100644
--- a/arch/m68k/kernel/early_printk.c
+++ b/arch/m68k/kernel/early_printk.c
@@ -12,8 +12,9 @@
 #include <linux/string.h>
 #include <asm/setup.h>
 
-extern void mvme16x_cons_write(struct console *co,
-			       const char *str, unsigned count);
+
+#include "../mvme147/mvme147.h"
+#include "../mvme16x/mvme16x.h"
 
 asmlinkage void __init debug_cons_nputs(const char *s, unsigned n);
 
@@ -22,7 +23,9 @@ static void __ref debug_cons_write(struct console *c,
 {
 #if !(defined(CONFIG_SUN3) || defined(CONFIG_M68000) || \
       defined(CONFIG_COLDFIRE))
-	if (MACH_IS_MVME16x)
+	if (MACH_IS_MVME147)
+		mvme147_scc_write(c, s, n);
+	else if (MACH_IS_MVME16x)
 		mvme16x_cons_write(c, s, n);
 	else
 		debug_cons_nputs(s, n);
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index 93c68d2b8e0e..36ff89776574 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -35,6 +35,7 @@
 #include <asm/machdep.h>
 #include <asm/mvme147hw.h>
 
+#include "mvme147.h"
 
 static void mvme147_get_model(char *model);
 extern void mvme147_sched_init(irq_handler_t handler);
@@ -164,3 +165,32 @@ int mvme147_hwclk(int op, struct rtc_time *t)
 	}
 	return 0;
 }
+
+static void scc_delay(void)
+{
+	__asm__ __volatile__ ("nop; nop;");
+}
+
+static void scc_write(char ch)
+{
+	do {
+		scc_delay();
+	} while (!(in_8(M147_SCC_A_ADDR) & BIT(2)));
+	scc_delay();
+	out_8(M147_SCC_A_ADDR, 8);
+	scc_delay();
+	out_8(M147_SCC_A_ADDR, ch);
+}
+
+void mvme147_scc_write(struct console *co, const char *str, unsigned int count)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	while (count--)	{
+		if (*str == '\n')
+			scc_write('\r');
+		scc_write(*str++);
+	}
+	local_irq_restore(flags);
+}
diff --git a/arch/m68k/mvme147/mvme147.h b/arch/m68k/mvme147/mvme147.h
new file mode 100644
index 000000000000..140bc98b0102
--- /dev/null
+++ b/arch/m68k/mvme147/mvme147.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+struct console;
+
+/* config.c */
+void mvme147_scc_write(struct console *co, const char *str, unsigned int count);
diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index 5feb3ab484d0..bb658e0a5be5 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -38,6 +38,8 @@
 #include <asm/machdep.h>
 #include <asm/mvme16xhw.h>
 
+#include "mvme16x.h"
+
 extern t_bdid mvme_bdid;
 
 static MK48T08ptr_t volatile rtc = (MK48T08ptr_t)MVME_RTC_BASE;
diff --git a/arch/m68k/mvme16x/mvme16x.h b/arch/m68k/mvme16x/mvme16x.h
new file mode 100644
index 000000000000..159c34b70039
--- /dev/null
+++ b/arch/m68k/mvme16x/mvme16x.h
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+struct console;
+
+/* config.c */
+void mvme16x_cons_write(struct console *co, const char *str, unsigned count);
diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
index 4547891a684b..b1449ed56fce 100644
--- a/arch/powerpc/include/asm/sstep.h
+++ b/arch/powerpc/include/asm/sstep.h
@@ -164,9 +164,4 @@ extern int emulate_step(struct pt_regs *regs, unsigned int instr);
  */
 extern int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op);
 
-extern void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
-			     const void *mem, bool cross_endian);
-extern void emulate_vsx_store(struct instruction_op *op,
-			      const union vsx_reg *reg, void *mem,
-			      bool cross_endian);
 extern int emulate_dcbz(unsigned long ea, struct pt_regs *regs);
diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/vdso.h
index b5e1f8f8a05c..64bf8612f479 100644
--- a/arch/powerpc/include/asm/vdso.h
+++ b/arch/powerpc/include/asm/vdso.h
@@ -49,6 +49,7 @@ int vdso_getcpu_init(void);
 
 #define V_FUNCTION_BEGIN(name)		\
 	.globl name;			\
+	.type name,@function; 		\
 	name:				\
 
 #define V_FUNCTION_END(name)		\
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 3da6290e3ccc..8c645e0072c6 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -667,8 +667,8 @@ static nokprobe_inline int emulate_stq(struct pt_regs *regs, unsigned long ea,
 #endif /* __powerpc64 */
 
 #ifdef CONFIG_VSX
-void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
-		      const void *mem, bool rev)
+static nokprobe_inline void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
+					     const void *mem, bool rev)
 {
 	int size, read_size;
 	int i, j;
@@ -748,11 +748,9 @@ void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
 		break;
 	}
 }
-EXPORT_SYMBOL_GPL(emulate_vsx_load);
-NOKPROBE_SYMBOL(emulate_vsx_load);
 
-void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
-		       void *mem, bool rev)
+static nokprobe_inline void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
+					      void *mem, bool rev)
 {
 	int size, write_size;
 	int i, j;
@@ -824,8 +822,6 @@ void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
 		break;
 	}
 }
-EXPORT_SYMBOL_GPL(emulate_vsx_store);
-NOKPROBE_SYMBOL(emulate_vsx_store);
 
 static nokprobe_inline int do_vsx_load(struct instruction_op *op,
 				       unsigned long ea, struct pt_regs *regs,
diff --git a/arch/s390/kernel/syscalls/Makefile b/arch/s390/kernel/syscalls/Makefile
index 4d929edc80a6..b801966c94e9 100644
--- a/arch/s390/kernel/syscalls/Makefile
+++ b/arch/s390/kernel/syscalls/Makefile
@@ -12,7 +12,7 @@ kapi-hdrs-y := $(kapi)/unistd_nr.h
 uapi-hdrs-y := $(uapi)/unistd_32.h
 uapi-hdrs-y += $(uapi)/unistd_64.h
 
-targets += $(addprefix ../../../,$(gen-y) $(kapi-hdrs-y) $(uapi-hdrs-y))
+targets += $(addprefix ../../../../,$(gen-y) $(kapi-hdrs-y) $(uapi-hdrs-y))
 
 PHONY += kapi uapi
 
diff --git a/arch/sh/kernel/cpu/proc.c b/arch/sh/kernel/cpu/proc.c
index 85961b4f9c69..136b4aefd73b 100644
--- a/arch/sh/kernel/cpu/proc.c
+++ b/arch/sh/kernel/cpu/proc.c
@@ -133,7 +133,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	return *pos < NR_CPUS ? cpu_data + *pos : NULL;
+	return *pos < nr_cpu_ids ? cpu_data + *pos : NULL;
 }
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 {
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 0216e3254c90..85291e50d047 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -349,7 +349,7 @@ static struct platform_driver uml_net_driver = {
 
 static void net_device_release(struct device *dev)
 {
-	struct uml_net *device = dev_get_drvdata(dev);
+	struct uml_net *device = container_of(dev, struct uml_net, pdev.dev);
 	struct net_device *netdev = device->dev;
 	struct uml_net_private *lp = netdev_priv(netdev);
 
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 4a32df89a491..7f82f1fbb891 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -854,7 +854,7 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 
 static void ubd_device_release(struct device *dev)
 {
-	struct ubd *ubd_dev = dev_get_drvdata(dev);
+	struct ubd *ubd_dev = container_of(dev, struct ubd, pdev.dev);
 
 	blk_cleanup_queue(ubd_dev->queue);
 	*ubd_dev = ((struct ubd) DEFAULT_UBD);
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index b0b124025b48..2f056a25a2ef 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -797,7 +797,8 @@ static struct platform_driver uml_net_driver = {
 
 static void vector_device_release(struct device *dev)
 {
-	struct vector_device *device = dev_get_drvdata(dev);
+	struct vector_device *device =
+		container_of(dev, struct vector_device, pdev.dev);
 	struct net_device *netdev = device->dev;
 
 	list_del(&device->list);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index c9d09d04d19d..83ae59f748e1 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -396,6 +396,6 @@ int elf_core_copy_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
 {
 	int cpu = current_thread_info()->cpu;
 
-	return save_i387_registers(userspace_pid[cpu], (unsigned long *) fpu);
+	return save_i387_registers(userspace_pid[cpu], (unsigned long *) fpu) == 0;
 }
 
diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index fddb6d26239f..7957ac2a643f 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -115,7 +115,10 @@ static inline bool amd_gart_present(void)
 
 #define amd_nb_num(x)		0
 #define amd_nb_has_feature(x)	false
-#define node_to_amd_nb(x)	NULL
+static inline struct amd_northbridge *node_to_amd_nb(int node)
+{
+	return NULL;
+}
 #define amd_gart_present(x)	false
 
 #endif
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0cb559d63998..0f20320053d1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1544,6 +1544,12 @@ void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 		return;
 
 	clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
+	/*
+	 * Pairs with the smp_mb() in blk_mq_hctx_stopped() to order the
+	 * clearing of BLK_MQ_S_STOPPED above and the checking of dispatch
+	 * list in the subsequent routine.
+	 */
+	smp_mb__after_atomic();
 	blk_mq_run_hw_queue(hctx, async);
 }
 EXPORT_SYMBOL_GPL(blk_mq_start_stopped_hw_queue);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 5ad9251627f8..0973b8006234 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -142,6 +142,19 @@ static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data
 
 static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
 {
+	/* Fast path: hardware queue is not stopped most of the time. */
+	if (likely(!test_bit(BLK_MQ_S_STOPPED, &hctx->state)))
+		return false;
+
+	/*
+	 * This barrier is used to order adding of dispatch list before and
+	 * the test of BLK_MQ_S_STOPPED below. Pairs with the memory barrier
+	 * in blk_mq_start_stopped_hw_queue() so that dispatch code could
+	 * either see BLK_MQ_S_STOPPED is cleared or dispatch list is not
+	 * empty to avoid missing dispatching requests.
+	 */
+	smp_mb();
+
 	return test_bit(BLK_MQ_S_STOPPED, &hctx->state);
 }
 
diff --git a/crypto/pcrypt.c b/crypto/pcrypt.c
index 1e9de81ef84f..d18e18141cb0 100644
--- a/crypto/pcrypt.c
+++ b/crypto/pcrypt.c
@@ -174,8 +174,10 @@ static int pcrypt_aead_encrypt(struct aead_request *req)
 	err = pcrypt_do_parallel(padata, &ctx->cb_cpu, &pencrypt);
 	if (!err)
 		return -EINPROGRESS;
-	if (err == -EBUSY)
-		return -EAGAIN;
+	if (err == -EBUSY) {
+		/* try non-parallel mode */
+		return crypto_aead_encrypt(creq);
+	}
 
 	return err;
 }
@@ -220,8 +222,10 @@ static int pcrypt_aead_decrypt(struct aead_request *req)
 	err = pcrypt_do_parallel(padata, &ctx->cb_cpu, &pdecrypt);
 	if (!err)
 		return -EINPROGRESS;
-	if (err == -EBUSY)
-		return -EAGAIN;
+	if (err == -EBUSY) {
+		/* try non-parallel mode */
+		return crypto_aead_decrypt(creq);
+	}
 
 	return err;
 }
diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 7a181a8a9bf0..a8aecdcdae7e 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -286,7 +286,7 @@ static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *block,
 		if (frame->virt_irq > 0)
 			acpi_unregister_gsi(gtdt_frame->virtual_timer_interrupt);
 		frame->virt_irq = 0;
-	} while (i-- >= 0 && gtdt_frame--);
+	} while (i-- > 0 && gtdt_frame--);
 
 	return -EINVAL;
 }
diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 982c7ac311b8..aeb4961d14b9 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -391,12 +391,16 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		return IRQ_NONE;
 }
 
+static struct lock_class_key regmap_irq_lock_class;
+static struct lock_class_key regmap_irq_request_class;
+
 static int regmap_irq_map(struct irq_domain *h, unsigned int virq,
 			  irq_hw_number_t hw)
 {
 	struct regmap_irq_chip_data *data = h->host_data;
 
 	irq_set_chip_data(virq, data);
+	irq_set_lockdep_class(virq, &regmap_irq_lock_class, &regmap_irq_request_class);
 	irq_set_chip(virq, &data->irq_chip);
 	irq_set_nested_thread(virq, 1);
 	irq_set_parent(virq, data->irq);
diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 48d11f2598e8..f1e276ce28d4 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/slab.h>
 #include <linux/io.h>
@@ -414,7 +415,7 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 	struct clk_init_data init;
 	const char *parent_names[2];
 	const char *clk_name;
-	struct resource *mem;
+	struct clk *axi_clk;
 	unsigned int i;
 	int ret;
 
@@ -429,14 +430,29 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 	if (!axi_clkgen)
 		return -ENOMEM;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	axi_clkgen->base = devm_ioremap_resource(&pdev->dev, mem);
+	axi_clkgen->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(axi_clkgen->base))
 		return PTR_ERR(axi_clkgen->base);
 
 	init.num_parents = of_clk_get_parent_count(pdev->dev.of_node);
-	if (init.num_parents < 1 || init.num_parents > 2)
-		return -EINVAL;
+
+	axi_clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
+	if (!IS_ERR(axi_clk)) {
+		if (init.num_parents < 2 || init.num_parents > 3)
+			return -EINVAL;
+
+		init.num_parents -= 1;
+	} else {
+		/*
+		 * Legacy... So that old DTs which do not have clock-names still
+		 * work. In this case we don't explicitly enable the AXI bus
+		 * clock.
+		 */
+		if (PTR_ERR(axi_clk) != -ENOENT)
+			return PTR_ERR(axi_clk);
+		if (init.num_parents < 1 || init.num_parents > 2)
+			return -EINVAL;
+	}
 
 	for (i = 0; i < init.num_parents; i++) {
 		parent_names[i] = of_clk_get_parent_name(pdev->dev.of_node, i);
diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index da344696beed..1f4d0cf3a53c 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -166,7 +166,9 @@ static int __init cpufreq_init(void)
 
 	ret = cpufreq_register_driver(&loongson2_cpufreq_driver);
 
-	if (!ret && !nowait) {
+	if (ret) {
+		platform_driver_unregister(&platform_driver);
+	} else if (!nowait) {
 		saved_cpu_wait = cpu_wait;
 		cpu_wait = loongson2_cpu_wait;
 	}
diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
index c63992fbbc98..4349961982cc 100644
--- a/drivers/crypto/bcm/cipher.c
+++ b/drivers/crypto/bcm/cipher.c
@@ -2510,6 +2510,7 @@ static int ahash_hmac_setkey(struct crypto_ahash *ahash, const u8 *key,
 
 static int ahash_hmac_init(struct ahash_request *req)
 {
+	int ret;
 	struct iproc_reqctx_s *rctx = ahash_request_ctx(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct iproc_ctx_s *ctx = crypto_ahash_ctx(tfm);
@@ -2519,7 +2520,9 @@ static int ahash_hmac_init(struct ahash_request *req)
 	flow_log("ahash_hmac_init()\n");
 
 	/* init the context as a hash */
-	ahash_init(req);
+	ret = ahash_init(req);
+	if (ret)
+		return ret;
 
 	if (!spu_no_incr_hash(ctx)) {
 		/* SPU-M can do incr hashing but needs sw for outer HMAC */
diff --git a/drivers/crypto/cavium/cpt/cptpf_main.c b/drivers/crypto/cavium/cpt/cptpf_main.c
index 7416f30ee976..c6781bbbdc5f 100644
--- a/drivers/crypto/cavium/cpt/cptpf_main.c
+++ b/drivers/crypto/cavium/cpt/cptpf_main.c
@@ -48,7 +48,7 @@ static void cpt_disable_cores(struct cpt_device *cpt, u64 coremask,
 		dev_err(dev, "Cores still busy %llx", coremask);
 		grp = cpt_read_csr64(cpt->reg_base,
 				     CPTX_PF_EXEC_BUSY(0));
-		if (timeout--)
+		if (!timeout--)
 			break;
 
 		udelay(CSR_DELAY);
@@ -306,6 +306,8 @@ static int cpt_ucode_load_fw(struct cpt_device *cpt, const u8 *fw, bool is_ae)
 
 	ret = do_cpt_init(cpt, mcode);
 	if (ret) {
+		dma_free_coherent(&cpt->pdev->dev, mcode->code_size,
+				  mcode->code, mcode->phys_base);
 		dev_err(dev, "do_cpt_init failed with ret: %d\n", ret);
 		goto fw_release;
 	}
@@ -398,7 +400,7 @@ static void cpt_disable_all_cores(struct cpt_device *cpt)
 		dev_err(dev, "Cores still busy");
 		grp = cpt_read_csr64(cpt->reg_base,
 				     CPTX_PF_EXEC_BUSY(0));
-		if (timeout--)
+		if (!timeout--)
 			break;
 
 		udelay(CSR_DELAY);
diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index efc8276d1d9c..1b06a0bb90ab 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -327,21 +327,25 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
 	 * TODO: Add support for 32-bit wide buses
 	 */
 	if ((err_detect & DDR_EDE_SBE) && (bus_width == 64)) {
+		u64 cap = (u64)cap_high << 32 | cap_low;
+		u32 s = syndrome;
+
 		sbe_ecc_decode(cap_high, cap_low, syndrome,
 				&bad_data_bit, &bad_ecc_bit);
 
-		if (bad_data_bit != -1)
-			fsl_mc_printk(mci, KERN_ERR,
-				"Faulty Data bit: %d\n", bad_data_bit);
-		if (bad_ecc_bit != -1)
-			fsl_mc_printk(mci, KERN_ERR,
-				"Faulty ECC bit: %d\n", bad_ecc_bit);
+		if (bad_data_bit >= 0) {
+			fsl_mc_printk(mci, KERN_ERR, "Faulty Data bit: %d\n", bad_data_bit);
+			cap ^= 1ULL << bad_data_bit;
+		}
+
+		if (bad_ecc_bit >= 0) {
+			fsl_mc_printk(mci, KERN_ERR, "Faulty ECC bit: %d\n", bad_ecc_bit);
+			s ^= 1 << bad_ecc_bit;
+		}
 
 		fsl_mc_printk(mci, KERN_ERR,
 			"Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
-			cap_high ^ (1 << (bad_data_bit - 32)),
-			cap_low ^ (1 << bad_data_bit),
-			syndrome ^ (1 << bad_ecc_bit));
+			upper_32_bits(cap), lower_32_bits(cap), s);
 	}
 
 	fsl_mc_printk(mci, KERN_ERR,
diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 1ce27bb9dead..2745a596e1d1 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -638,6 +638,9 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
 	if (ret)
 		return ERR_PTR(ret);
 
+	if (!buf.opp_count)
+		return ERR_PTR(-ENOENT);
+
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
index 3cc5fbd78ee2..d7d9fc093c30 100644
--- a/drivers/gpu/drm/drm_mm.c
+++ b/drivers/gpu/drm/drm_mm.c
@@ -164,7 +164,7 @@ static void show_leaks(struct drm_mm *mm) { }
 
 INTERVAL_TREE_DEFINE(struct drm_mm_node, rb,
 		     u64, __subtree_last,
-		     START, LAST, static inline, drm_mm_interval_tree)
+		     START, LAST, static inline __maybe_unused, drm_mm_interval_tree)
 
 struct drm_mm_node *
 __drm_mm_interval_first(const struct drm_mm *mm, u64 start, u64 last)
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index b2930d1fe97c..51b7bdf5748b 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -108,17 +108,6 @@ static inline size_t size_vstruct(size_t nelem, size_t elem_size, size_t base)
 	return base + nelem * elem_size;
 }
 
-/* returns true if fence a comes after fence b */
-static inline bool fence_after(u32 a, u32 b)
-{
-	return (s32)(a - b) > 0;
-}
-
-static inline bool fence_after_eq(u32 a, u32 b)
-{
-	return (s32)(a - b) >= 0;
-}
-
 /*
  * Etnaviv timeouts are specified wrt CLOCK_MONOTONIC, not jiffies.
  * We need to calculate the timeout in terms of number of jiffies
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_dump.c b/drivers/gpu/drm/etnaviv/etnaviv_dump.c
index 9d839b4fd8f7..1112972e5895 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_dump.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_dump.c
@@ -73,7 +73,7 @@ static void etnaviv_core_dump_header(struct core_dump_iterator *iter,
 	hdr->file_size = cpu_to_le32(data_end - iter->data);
 
 	iter->hdr++;
-	iter->data += hdr->file_size;
+	iter->data += le32_to_cpu(hdr->file_size);
 }
 
 static void etnaviv_core_dump_registers(struct core_dump_iterator *iter,
@@ -81,10 +81,15 @@ static void etnaviv_core_dump_registers(struct core_dump_iterator *iter,
 {
 	struct etnaviv_dump_registers *reg = iter->data;
 	unsigned int i;
+	u32 read_addr;
 
 	for (i = 0; i < ARRAY_SIZE(etnaviv_dump_registers); i++, reg++) {
-		reg->reg = etnaviv_dump_registers[i];
-		reg->value = gpu_read(gpu, etnaviv_dump_registers[i]);
+		read_addr = etnaviv_dump_registers[i];
+		if (read_addr >= VIVS_PM_POWER_CONTROLS &&
+		    read_addr <= VIVS_PM_PULSE_EATER)
+			read_addr = gpu_fix_power_address(gpu, read_addr);
+		reg->reg = cpu_to_le32(etnaviv_dump_registers[i]);
+		reg->value = cpu_to_le32(gpu_read(gpu, read_addr));
 	}
 
 	etnaviv_core_dump_header(iter, ETDUMP_BUF_REG, reg);
@@ -220,7 +225,7 @@ void etnaviv_core_dump(struct etnaviv_gpu *gpu)
 		if (!IS_ERR(pages)) {
 			int j;
 
-			iter.hdr->data[0] = bomap - bomap_start;
+			iter.hdr->data[0] = cpu_to_le32((bomap - bomap_start));
 
 			for (j = 0; j < obj->base.size >> PAGE_SHIFT; j++)
 				*bomap++ = cpu_to_le64(page_to_phys(*pages++));
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 37ae15dc4fc6..dec636b96531 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -540,7 +540,7 @@ static void etnaviv_gpu_enable_mlcg(struct etnaviv_gpu *gpu)
 	u32 pmc, ppc;
 
 	/* enable clock gating */
-	ppc = gpu_read(gpu, VIVS_PM_POWER_CONTROLS);
+	ppc = gpu_read_power(gpu, VIVS_PM_POWER_CONTROLS);
 	ppc |= VIVS_PM_POWER_CONTROLS_ENABLE_MODULE_CLOCK_GATING;
 
 	/* Disable stall module clock gating for 4.3.0.1 and 4.3.0.2 revs */
@@ -548,9 +548,9 @@ static void etnaviv_gpu_enable_mlcg(struct etnaviv_gpu *gpu)
 	    gpu->identity.revision == 0x4302)
 		ppc |= VIVS_PM_POWER_CONTROLS_DISABLE_STALL_MODULE_CLOCK_GATING;
 
-	gpu_write(gpu, VIVS_PM_POWER_CONTROLS, ppc);
+	gpu_write_power(gpu, VIVS_PM_POWER_CONTROLS, ppc);
 
-	pmc = gpu_read(gpu, VIVS_PM_MODULE_CONTROLS);
+	pmc = gpu_read_power(gpu, VIVS_PM_MODULE_CONTROLS);
 
 	/* Disable PA clock gating for GC400+ without bugfix except for GC420 */
 	if (gpu->identity.model >= chipModel_GC400 &&
@@ -579,7 +579,7 @@ static void etnaviv_gpu_enable_mlcg(struct etnaviv_gpu *gpu)
 	pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA_HZ;
 	pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA_EZ;
 
-	gpu_write(gpu, VIVS_PM_MODULE_CONTROLS, pmc);
+	gpu_write_power(gpu, VIVS_PM_MODULE_CONTROLS, pmc);
 }
 
 void etnaviv_gpu_start_fe(struct etnaviv_gpu *gpu, u32 address, u16 prefetch)
@@ -620,11 +620,11 @@ static void etnaviv_gpu_setup_pulse_eater(struct etnaviv_gpu *gpu)
 	    (gpu->identity.features & chipFeatures_PIPE_3D))
 	{
 		/* Performance fix: disable internal DFS */
-		pulse_eater = gpu_read(gpu, VIVS_PM_PULSE_EATER);
+		pulse_eater = gpu_read_power(gpu, VIVS_PM_PULSE_EATER);
 		pulse_eater |= BIT(18);
 	}
 
-	gpu_write(gpu, VIVS_PM_PULSE_EATER, pulse_eater);
+	gpu_write_power(gpu, VIVS_PM_PULSE_EATER, pulse_eater);
 }
 
 static void etnaviv_gpu_hw_init(struct etnaviv_gpu *gpu)
@@ -1038,7 +1038,7 @@ static bool etnaviv_fence_signaled(struct dma_fence *fence)
 {
 	struct etnaviv_fence *f = to_etnaviv_fence(fence);
 
-	return fence_completed(f->gpu, f->base.seqno);
+	return (s32)(f->gpu->completed_fence - f->base.seqno) >= 0;
 }
 
 static void etnaviv_fence_release(struct dma_fence *fence)
@@ -1077,6 +1077,12 @@ static struct dma_fence *etnaviv_gpu_fence_alloc(struct etnaviv_gpu *gpu)
 	return &f->base;
 }
 
+/* returns true if fence a comes after fence b */
+static inline bool fence_after(u32 a, u32 b)
+{
+	return (s32)(a - b) > 0;
+}
+
 /*
  * event management:
  */
@@ -1231,10 +1237,12 @@ static void sync_point_perfmon_sample_pre(struct etnaviv_gpu *gpu,
 {
 	u32 val;
 
+	mutex_lock(&gpu->lock);
+
 	/* disable clock gating */
-	val = gpu_read(gpu, VIVS_PM_POWER_CONTROLS);
+	val = gpu_read_power(gpu, VIVS_PM_POWER_CONTROLS);
 	val &= ~VIVS_PM_POWER_CONTROLS_ENABLE_MODULE_CLOCK_GATING;
-	gpu_write(gpu, VIVS_PM_POWER_CONTROLS, val);
+	gpu_write_power(gpu, VIVS_PM_POWER_CONTROLS, val);
 
 	/* enable debug register */
 	val = gpu_read(gpu, VIVS_HI_CLOCK_CONTROL);
@@ -1242,6 +1250,8 @@ static void sync_point_perfmon_sample_pre(struct etnaviv_gpu *gpu,
 	gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, val);
 
 	sync_point_perfmon_sample(gpu, event, ETNA_PM_PROCESS_PRE);
+
+	mutex_unlock(&gpu->lock);
 }
 
 static void sync_point_perfmon_sample_post(struct etnaviv_gpu *gpu,
@@ -1251,13 +1261,9 @@ static void sync_point_perfmon_sample_post(struct etnaviv_gpu *gpu,
 	unsigned int i;
 	u32 val;
 
-	sync_point_perfmon_sample(gpu, event, ETNA_PM_PROCESS_POST);
-
-	for (i = 0; i < submit->nr_pmrs; i++) {
-		const struct etnaviv_perfmon_request *pmr = submit->pmrs + i;
+	mutex_lock(&gpu->lock);
 
-		*pmr->bo_vma = pmr->sequence;
-	}
+	sync_point_perfmon_sample(gpu, event, ETNA_PM_PROCESS_POST);
 
 	/* disable debug register */
 	val = gpu_read(gpu, VIVS_HI_CLOCK_CONTROL);
@@ -1265,9 +1271,17 @@ static void sync_point_perfmon_sample_post(struct etnaviv_gpu *gpu,
 	gpu_write(gpu, VIVS_HI_CLOCK_CONTROL, val);
 
 	/* enable clock gating */
-	val = gpu_read(gpu, VIVS_PM_POWER_CONTROLS);
+	val = gpu_read_power(gpu, VIVS_PM_POWER_CONTROLS);
 	val |= VIVS_PM_POWER_CONTROLS_ENABLE_MODULE_CLOCK_GATING;
-	gpu_write(gpu, VIVS_PM_POWER_CONTROLS, val);
+	gpu_write_power(gpu, VIVS_PM_POWER_CONTROLS, val);
+
+	mutex_unlock(&gpu->lock);
+
+	for (i = 0; i < submit->nr_pmrs; i++) {
+		const struct etnaviv_perfmon_request *pmr = submit->pmrs + i;
+
+		*pmr->bo_vma = pmr->sequence;
+	}
 }
 
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
index 039e0509af6a..dedc44e484a0 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
@@ -11,6 +11,7 @@
 
 #include "etnaviv_cmdbuf.h"
 #include "etnaviv_drv.h"
+#include "common.xml.h"
 
 struct etnaviv_gem_submit;
 struct etnaviv_vram_mapping;
@@ -162,9 +163,24 @@ static inline u32 gpu_read(struct etnaviv_gpu *gpu, u32 reg)
 	return readl(gpu->mmio + reg);
 }
 
-static inline bool fence_completed(struct etnaviv_gpu *gpu, u32 fence)
+static inline u32 gpu_fix_power_address(struct etnaviv_gpu *gpu, u32 reg)
 {
-	return fence_after_eq(gpu->completed_fence, fence);
+	/* Power registers in GC300 < 2.0 are offset by 0x100 */
+	if (gpu->identity.model == chipModel_GC300 &&
+	    gpu->identity.revision < 0x2000)
+		reg += 0x100;
+
+	return reg;
+}
+
+static inline void gpu_write_power(struct etnaviv_gpu *gpu, u32 reg, u32 data)
+{
+	writel(data, gpu->mmio + gpu_fix_power_address(gpu, reg));
+}
+
+static inline u32 gpu_read_power(struct etnaviv_gpu *gpu, u32 reg)
+{
+	return readl(gpu->mmio + gpu_fix_power_address(gpu, reg));
 }
 
 int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value);
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index 4ba5d035c590..4834c1846e43 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -1253,8 +1253,6 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
 
 	omap_obj = to_omap_bo(obj);
 
-	mutex_lock(&omap_obj->lock);
-
 	omap_obj->sgt = sgt;
 
 	if (sgt->orig_nents == 1) {
@@ -1270,8 +1268,7 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
 		pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
 		if (!pages) {
 			omap_gem_free_object(obj);
-			obj = ERR_PTR(-ENOMEM);
-			goto done;
+			return ERR_PTR(-ENOMEM);
 		}
 
 		omap_obj->pages = pages;
@@ -1284,13 +1281,10 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
 
 		if (WARN_ON(i != npages)) {
 			omap_gem_free_object(obj);
-			obj = ERR_PTR(-ENOMEM);
-			goto done;
+			return ERR_PTR(-ENOMEM);
 		}
 	}
 
-done:
-	mutex_unlock(&omap_obj->lock);
 	return obj;
 }
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index fe4051024db3..f0f6e8de025a 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1321,9 +1321,9 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 					rotation -= 1800;
 
 				input_report_abs(pen_input, ABS_TILT_X,
-						 (char)frame[7]);
+						 (signed char)frame[7]);
 				input_report_abs(pen_input, ABS_TILT_Y,
-						 (char)frame[8]);
+						 (signed char)frame[8]);
 				input_report_abs(pen_input, ABS_Z, rotation);
 				input_report_abs(pen_input, ABS_WHEEL,
 						 get_unaligned_le16(&frame[11]));
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index e2c93a50fe76..9b6ebf635698 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3110,7 +3110,7 @@ static void bnxt_re_process_res_shadow_qp_wc(struct bnxt_re_qp *qp,
 	wc->byte_len = orig_cqe->length;
 	wc->qp = &qp1_qp->ib_qp;
 
-	wc->ex.imm_data = cpu_to_be32(le32_to_cpu(orig_cqe->immdata));
+	wc->ex.imm_data = cpu_to_be32(orig_cqe->immdata);
 	wc->src_qp = orig_cqe->src_qp;
 	memcpy(wc->smac, orig_cqe->smac, ETH_ALEN);
 	if (bnxt_re_is_vlan_pkt(orig_cqe, &vlan_id, &sl)) {
@@ -3231,7 +3231,10 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 				continue;
 			}
 			wc->qp = &qp->ib_qp;
-			wc->ex.imm_data = cpu_to_be32(le32_to_cpu(cqe->immdata));
+			if (cqe->flags & CQ_RES_RC_FLAGS_IMM)
+				wc->ex.imm_data = cpu_to_be32(cqe->immdata);
+			else
+				wc->ex.invalidate_rkey = cqe->invrkey;
 			wc->src_qp = cqe->src_qp;
 			memcpy(wc->smac, cqe->smac, ETH_ALEN);
 			wc->port_num = 1;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index aed0c53d84be..6c0129231c07 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -349,7 +349,7 @@ struct bnxt_qplib_cqe {
 	u32				length;
 	u64				wr_id;
 	union {
-		__le32			immdata;
+		u32			immdata;
 		u32			invrkey;
 	};
 	u64				qp_handle;
diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 49d55c5bf717..91f5d52f45db 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -544,6 +544,9 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	for (minor = 0; minor < MAX_DVB_MINORS; minor++)
 		if (dvb_minors[minor] == NULL)
 			break;
+#else
+	minor = nums2minor(adap->num, type, id);
+#endif
 	if (minor >= MAX_DVB_MINORS) {
 		if (new_node) {
 			list_del (&new_node->list_head);
@@ -557,17 +560,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		mutex_unlock(&dvbdev_register_lock);
 		return -EINVAL;
 	}
-#else
-	minor = nums2minor(adap->num, type, id);
-	if (minor >= MAX_DVB_MINORS) {
-		dvb_media_device_free(dvbdev);
-		list_del(&dvbdev->list_head);
-		kfree(dvbdev);
-		*pdvbdev = NULL;
-		mutex_unlock(&dvbdev_register_lock);
-		return ret;
-	}
-#endif
+
 	dvbdev->minor = minor;
 	dvb_minors[minor] = dvb_device_get(dvbdev);
 	up_write(&minor_rwsem);
diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index cccf1a743f4e..f22a558ad807 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -472,11 +472,12 @@ int fmc_send_cmd(struct fmdev *fmdev, u8 fm_op, u16 type, void *payload,
 			   jiffies_to_msecs(FM_DRV_TX_TIMEOUT) / 1000);
 		return -ETIMEDOUT;
 	}
+	spin_lock_irqsave(&fmdev->resp_skb_lock, flags);
 	if (!fmdev->resp_skb) {
+		spin_unlock_irqrestore(&fmdev->resp_skb_lock, flags);
 		fmerr("Response SKB is missing\n");
 		return -EFAULT;
 	}
-	spin_lock_irqsave(&fmdev->resp_skb_lock, flags);
 	skb = fmdev->resp_skb;
 	fmdev->resp_skb = NULL;
 	spin_unlock_irqrestore(&fmdev->resp_skb_lock, flags);
diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index b8cf2658649e..7c8924dff17f 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -4206,10 +4206,8 @@ mptsas_find_phyinfo_by_phys_disk_num(MPT_ADAPTER *ioc, u8 phys_disk_num,
 static void
 mptsas_reprobe_lun(struct scsi_device *sdev, void *data)
 {
-	int rc;
-
 	sdev->no_uld_attach = data ? 1 : 0;
-	rc = scsi_device_reprobe(sdev);
+	WARN_ON(scsi_device_reprobe(sdev));
 }
 
 static void
diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
index abfb11818fdc..5fb5af5108ab 100644
--- a/drivers/mfd/da9052-spi.c
+++ b/drivers/mfd/da9052-spi.c
@@ -42,7 +42,7 @@ static int da9052_spi_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, da9052);
 
 	config = da9052_regmap_config;
-	config.read_flag_mask = 1;
+	config.write_flag_mask = 1;
 	config.reg_bits = 7;
 	config.pad_bits = 1;
 	config.val_bits = 8;
diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index 94cdad91c065..71f35bfac3f2 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -85,8 +85,8 @@ static int rt5033_i2c_probe(struct i2c_client *i2c,
 	}
 	dev_info(&i2c->dev, "Device found Device ID: %04x\n", dev_id);
 
-	ret = regmap_add_irq_chip(rt5033->regmap, rt5033->irq,
-			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+	ret = devm_regmap_add_irq_chip(rt5033->dev, rt5033->regmap,
+			rt5033->irq, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 			0, &rt5033_irq_chip, &rt5033->irq_data);
 	if (ret) {
 		dev_err(&i2c->dev, "Failed to request IRQ %d: %d\n",
diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index ed9412d750b7..871d2d42db93 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -1163,7 +1163,7 @@ static int apds990x_probe(struct i2c_client *client,
 		err = chip->pdata->setup_resources();
 		if (err) {
 			err = -EINVAL;
-			goto fail3;
+			goto fail4;
 		}
 	}
 
@@ -1171,7 +1171,7 @@ static int apds990x_probe(struct i2c_client *client,
 				apds990x_attribute_group);
 	if (err < 0) {
 		dev_err(&chip->client->dev, "Sysfs registration failed\n");
-		goto fail4;
+		goto fail5;
 	}
 
 	err = request_threaded_irq(client->irq, NULL,
@@ -1182,15 +1182,17 @@ static int apds990x_probe(struct i2c_client *client,
 	if (err) {
 		dev_err(&client->dev, "could not get IRQ %d\n",
 			client->irq);
-		goto fail5;
+		goto fail6;
 	}
 	return err;
-fail5:
+fail6:
 	sysfs_remove_group(&chip->client->dev.kobj,
 			&apds990x_attribute_group[0]);
-fail4:
+fail5:
 	if (chip->pdata && chip->pdata->release_resources)
 		chip->pdata->release_resources();
+fail4:
+	pm_runtime_disable(&client->dev);
 fail3:
 	regulator_bulk_disable(ARRAY_SIZE(chip->regs), chip->regs);
 fail2:
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a35526ae7a25..75355abe03c9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2857,8 +2857,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	if (host->use_dma == TRANS_MODE_IDMAC) {
 		mmc->max_segs = host->ring_size;
 		mmc->max_blk_size = 65535;
-		mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
-		mmc->max_seg_size = mmc->max_req_size;
+		mmc->max_seg_size = 0x1000;
+		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
 		mmc->max_blk_count = mmc->max_req_size / 512;
 	} else if (host->use_dma == TRANS_MODE_EDMAC) {
 		mmc->max_segs = 64;
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 24795454d106..008a47842de0 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -269,10 +269,6 @@ static int mmc_spi_response_get(struct mmc_spi_host *host,
 	u8 	leftover = 0;
 	unsigned short rotator;
 	int 	i;
-	char	tag[32];
-
-	snprintf(tag, sizeof(tag), "  ... CMD%d response SPI_%s",
-		cmd->opcode, maptype(cmd));
 
 	/* Except for data block reads, the whole response will already
 	 * be stored in the scratch buffer.  It's somewhere after the
@@ -422,8 +418,9 @@ static int mmc_spi_response_get(struct mmc_spi_host *host,
 	}
 
 	if (value < 0)
-		dev_dbg(&host->spi->dev, "%s: resp %04x %08x\n",
-			tag, cmd->resp[0], cmd->resp[1]);
+		dev_dbg(&host->spi->dev,
+			"  ... CMD%d response SPI_%s: resp %04x %08x\n",
+			cmd->opcode, maptype(cmd), cmd->resp[0], cmd->resp[1]);
 
 	/* disable chipselect on errors and some success cases */
 	if (value >= 0 && cs_on)
diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index 9d3997840889..8880e0401e6c 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -365,7 +365,7 @@ atmel_pmecc_create_user(struct atmel_pmecc *pmecc,
 	size = ALIGN(size, sizeof(s32));
 	size += (req->ecc.strength + 1) * sizeof(s32) * 3;
 
-	user = kzalloc(size, GFP_KERNEL);
+	user = devm_kzalloc(pmecc->dev, size, GFP_KERNEL);
 	if (!user)
 		return ERR_PTR(-ENOMEM);
 
@@ -411,12 +411,6 @@ atmel_pmecc_create_user(struct atmel_pmecc *pmecc,
 }
 EXPORT_SYMBOL_GPL(atmel_pmecc_create_user);
 
-void atmel_pmecc_destroy_user(struct atmel_pmecc_user *user)
-{
-	kfree(user);
-}
-EXPORT_SYMBOL_GPL(atmel_pmecc_destroy_user);
-
 static int get_strength(struct atmel_pmecc_user *user)
 {
 	const int *strengths = user->pmecc->caps->strengths;
diff --git a/drivers/mtd/nand/raw/atmel/pmecc.h b/drivers/mtd/nand/raw/atmel/pmecc.h
index 808f1be0d6ad..1b6ac2ce73f4 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.h
+++ b/drivers/mtd/nand/raw/atmel/pmecc.h
@@ -59,8 +59,6 @@ struct atmel_pmecc *devm_atmel_pmecc_get(struct device *dev);
 struct atmel_pmecc_user *
 atmel_pmecc_create_user(struct atmel_pmecc *pmecc,
 			struct atmel_pmecc_user_req *req);
-void atmel_pmecc_destroy_user(struct atmel_pmecc_user *user);
-
 void atmel_pmecc_reset(struct atmel_pmecc *pmecc);
 int atmel_pmecc_enable(struct atmel_pmecc_user *user, int op);
 void atmel_pmecc_disable(struct atmel_pmecc_user *user);
diff --git a/drivers/mtd/ubi/attach.c b/drivers/mtd/ubi/attach.c
index 93ceea4f27d5..d62e5b69ba4b 100644
--- a/drivers/mtd/ubi/attach.c
+++ b/drivers/mtd/ubi/attach.c
@@ -1459,7 +1459,7 @@ static int scan_all(struct ubi_device *ubi, struct ubi_attach_info *ai,
 	return err;
 }
 
-static struct ubi_attach_info *alloc_ai(void)
+static struct ubi_attach_info *alloc_ai(const char *slab_name)
 {
 	struct ubi_attach_info *ai;
 
@@ -1473,7 +1473,7 @@ static struct ubi_attach_info *alloc_ai(void)
 	INIT_LIST_HEAD(&ai->alien);
 	INIT_LIST_HEAD(&ai->fastmap);
 	ai->volumes = RB_ROOT;
-	ai->aeb_slab_cache = kmem_cache_create("ubi_aeb_slab_cache",
+	ai->aeb_slab_cache = kmem_cache_create(slab_name,
 					       sizeof(struct ubi_ainf_peb),
 					       0, 0, NULL);
 	if (!ai->aeb_slab_cache) {
@@ -1503,7 +1503,7 @@ static int scan_fast(struct ubi_device *ubi, struct ubi_attach_info **ai)
 
 	err = -ENOMEM;
 
-	scan_ai = alloc_ai();
+	scan_ai = alloc_ai("ubi_aeb_slab_cache_fastmap");
 	if (!scan_ai)
 		goto out;
 
@@ -1569,7 +1569,7 @@ int ubi_attach(struct ubi_device *ubi, int force_scan)
 	int err;
 	struct ubi_attach_info *ai;
 
-	ai = alloc_ai();
+	ai = alloc_ai("ubi_aeb_slab_cache");
 	if (!ai)
 		return -ENOMEM;
 
@@ -1587,7 +1587,7 @@ int ubi_attach(struct ubi_device *ubi, int force_scan)
 		if (err > 0 || mtd_is_eccerr(err)) {
 			if (err != UBI_NO_FASTMAP) {
 				destroy_ai(ai);
-				ai = alloc_ai();
+				ai = alloc_ai("ubi_aeb_slab_cache");
 				if (!ai)
 					return -ENOMEM;
 
@@ -1626,7 +1626,7 @@ int ubi_attach(struct ubi_device *ubi, int force_scan)
 	if (ubi->fm && ubi_dbg_chk_fastmap(ubi)) {
 		struct ubi_attach_info *scan_ai;
 
-		scan_ai = alloc_ai();
+		scan_ai = alloc_ai("ubi_aeb_slab_cache_dbg_chk_fastmap");
 		if (!scan_ai) {
 			err = -ENOMEM;
 			goto out_wl;
diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 83c460f7a883..221edcfca7f8 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -810,7 +810,14 @@ static int wear_leveling_worker(struct ubi_device *ubi, struct ubi_work *wrk,
 			goto out_not_moved;
 		}
 		if (err == MOVE_RETRY) {
-			scrubbing = 1;
+			/*
+			 * For source PEB:
+			 * 1. The scrubbing is set for scrub type PEB, it will
+			 *    be put back into ubi->scrub list.
+			 * 2. Non-scrub type PEB will be put back into ubi->used
+			 *    list.
+			 */
+			keep = 1;
 			dst_leb_clean = 1;
 			goto out_not_moved;
 		}
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index af0186a527a3..d7419c65d9e3 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17866,6 +17866,9 @@ static int tg3_init_one(struct pci_dev *pdev,
 	} else
 		persist_dma_mask = dma_mask = DMA_BIT_MASK(64);
 
+	if (tg3_asic_rev(tp) == ASIC_REV_57766)
+		persist_dma_mask = DMA_BIT_MASK(31);
+
 	/* Configure DMA attributes. */
 	if (dma_mask > DMA_BIT_MASK(32)) {
 		err = pci_set_dma_mask(pdev, dma_mask);
diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index 0d6a4e47e7a5..962d7046801c 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -1417,18 +1417,15 @@ static int pxa168_eth_probe(struct platform_device *pdev)
 
 	printk(KERN_NOTICE "PXA168 10/100 Ethernet Driver\n");
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "Fast Ethernet failed to get clock\n");
+		dev_err(&pdev->dev, "Fast Ethernet failed to get and enable clock\n");
 		return -ENODEV;
 	}
-	clk_prepare_enable(clk);
 
 	dev = alloc_etherdev(sizeof(struct pxa168_eth_private));
-	if (!dev) {
-		err = -ENOMEM;
-		goto err_clk;
-	}
+	if (!dev)
+		return -ENOMEM;
 
 	platform_set_drvdata(pdev, dev);
 	pep = netdev_priv(dev);
@@ -1541,8 +1538,6 @@ static int pxa168_eth_probe(struct platform_device *pdev)
 	mdiobus_free(pep->smi_bus);
 err_netdev:
 	free_netdev(dev);
-err_clk:
-	clk_disable_unprepare(clk);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 33407df6bea6..9176fbee5ed6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -346,6 +346,8 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
 
+	plat_dat->riwt_off = 1;
+
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
 		goto err_remove_config_dt;
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index f56f45c924de..44c2433b55a7 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1440,13 +1440,13 @@ static int lan78xx_set_wol(struct net_device *netdev,
 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
 	int ret;
 
+	if (wol->wolopts & ~WAKE_ALL)
+		return -EINVAL;
+
 	ret = usb_autopm_get_interface(dev->intf);
 	if (ret < 0)
 		return ret;
 
-	if (wol->wolopts & ~WAKE_ALL)
-		return -EINVAL;
-
 	pdata->wol = wol->wolopts;
 
 	device_set_wakeup_enable(&dev->udev->dev, (bool)wol->wolopts);
@@ -2204,6 +2204,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		if (dev->chipid == ID_REV_CHIP_ID_7801_) {
 			if (phy_is_pseudo_fixed_link(phydev)) {
 				fixed_phy_unregister(phydev);
+				phy_device_free(phydev);
 			} else {
 				phy_unregister_fixup_for_uid(PHY_KSZ9031RNX,
 							     0xfffffff0);
@@ -3884,8 +3885,10 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 
 	phy_disconnect(net->phydev);
 
-	if (phy_is_pseudo_fixed_link(phydev))
+	if (phy_is_pseudo_fixed_link(phydev)) {
 		fixed_phy_unregister(phydev);
+		phy_device_free(phydev);
+	}
 
 	unregister_netdev(net);
 
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 57ccbc8a6c05..32b25462a573 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1045,6 +1045,7 @@ static const struct usb_device_id products[] = {
 		USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0x581d, USB_CLASS_VENDOR_SPEC, 1, 7),
 		.driver_info = (unsigned long)&qmi_wwan_info,
 	},
+	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0122)},	/* Quectel RG650V */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0125)},	/* Quectel EC25, EC20 R2.0  Mini PCIe */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0306)},	/* Quectel EP06/EG06/EM06 */
 	{QMI_MATCH_FF_FF_FF(0x2c7c, 0x0512)},	/* Quectel EG12/EM12 */
diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index d5e5f9cf4ca8..762403dfbb36 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -297,6 +297,9 @@ int htc_connect_service(struct htc_target *target,
 		return -ETIMEDOUT;
 	}
 
+	if (target->conn_rsp_epid < 0 || target->conn_rsp_epid >= ENDPOINT_MAX)
+		return -EINVAL;
+
 	*conn_rsp_epid = target->conn_rsp_epid;
 	return 0;
 err:
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index bfa482cf464f..c8bf6e559dc5 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -853,7 +853,7 @@ struct mwifiex_ietypes_chanstats {
 struct mwifiex_ie_types_wildcard_ssid_params {
 	struct mwifiex_ie_types_header header;
 	u8 max_ssid_length;
-	u8 ssid[1];
+	u8 ssid[];
 } __packed;
 
 #define TSF_DATA_SIZE            8
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6adff541282b..fcf062f3b507 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -802,11 +802,16 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
 	struct gendisk *disk = ns ? ns->disk : NULL;
+	bool supports_metadata = disk && blk_get_integrity(disk);
+	bool has_metadata = meta_buffer && meta_len;
 	struct request *req;
 	struct bio *bio = NULL;
 	void *meta = NULL;
 	int ret;
 
+	if (has_metadata && !supports_metadata)
+		return -EINVAL;
+
 	req = nvme_alloc_request(q, cmd, 0, NVME_QID_ANY);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -821,7 +826,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 			goto out;
 		bio = req->bio;
 		bio->bi_disk = disk;
-		if (disk && meta_buffer && meta_len) {
+		if (has_metadata) {
 			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
 					meta_seed, write);
 			if (IS_ERR(meta)) {
diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index 1b2b3f3b648b..ce6eb71a6359 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -135,11 +135,13 @@ int cpqhp_unconfigure_device(struct pci_func *func)
 static int PCI_RefinedAccessConfig(struct pci_bus *bus, unsigned int devfn, u8 offset, u32 *value)
 {
 	u32 vendID = 0;
+	int ret;
 
-	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &vendID) == -1)
-		return -1;
-	if (vendID == 0xffffffff)
-		return -1;
+	ret = pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &vendID);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	if (PCI_POSSIBLE_ERROR(vendID))
+		return PCIBIOS_DEVICE_NOT_FOUND;
 	return pci_bus_read_config_dword(bus, devfn, offset, value);
 }
 
@@ -200,13 +202,15 @@ static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 *dev_
 {
 	u16 tdevice;
 	u32 work;
+	int ret;
 	u8 tbus;
 
 	ctrl->pci_bus->number = bus_num;
 
 	for (tdevice = 0; tdevice < 0xFF; tdevice++) {
 		/* Scan for access first */
-		if (PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work) == -1)
+		ret = PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work);
+		if (ret)
 			continue;
 		dbg("Looking for nonbridge bus_num %d dev_num %d\n", bus_num, tdevice);
 		/* Yep we got one. Not a bridge ? */
@@ -218,7 +222,8 @@ static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 *dev_
 	}
 	for (tdevice = 0; tdevice < 0xFF; tdevice++) {
 		/* Scan for access first */
-		if (PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work) == -1)
+		ret = PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work);
+		if (ret)
 			continue;
 		dbg("Looking for bridge bus_num %d dev_num %d\n", bus_num, tdevice);
 		/* Yep we got one. bridge ? */
@@ -251,7 +256,7 @@ static int PCI_GetBusDevHelper(struct controller *ctrl, u8 *bus_num, u8 *dev_num
 			*dev_num = tdevice;
 			ctrl->pci_bus->number = tbus;
 			pci_bus_read_config_dword(ctrl->pci_bus, *dev_num, PCI_VENDOR_ID, &work);
-			if (!nobridge || (work == 0xffffffff))
+			if (!nobridge || PCI_POSSIBLE_ERROR(work))
 				return 0;
 
 			dbg("bus_num %d devfn %d\n", *bus_num, *dev_num);
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index d575583e49c2..98f23eddc126 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -115,6 +115,7 @@ static void pci_slot_release(struct kobject *kobj)
 	up_read(&pci_bus_sem);
 
 	list_del(&slot->list);
+	pci_bus_put(slot->bus);
 
 	kfree(slot);
 }
@@ -296,7 +297,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 		goto err;
 	}
 
-	slot->bus = parent;
+	slot->bus = pci_bus_get(parent);
 	slot->number = slot_nr;
 
 	slot->kobj.kset = pci_slots_kset;
@@ -304,6 +305,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	slot_name = make_slot_name(name);
 	if (!slot_name) {
 		err = -ENOMEM;
+		pci_bus_put(slot->bus);
 		kfree(slot);
 		goto err;
 	}
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 3715a6c2955b..b89d89455bcb 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -482,8 +482,6 @@ EXPORT_SYMBOL_GPL(power_supply_get_by_name);
  */
 void power_supply_put(struct power_supply *psy)
 {
-	might_sleep();
-
 	atomic_dec(&psy->use_cnt);
 	put_device(&psy->dev);
 }
diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 48d2fb187a1b..17c342b4fe72 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -92,6 +92,8 @@ struct glink_core_rx_intent {
  * @rcids:	idr of all channels with a known remote channel id
  * @features:	remote features
  * @intentless:	flag to indicate that there is no intent
+ * @tx_avail_notify: Waitqueue for pending tx tasks
+ * @sent_read_notify: flag to check cmd sent or not
  */
 struct qcom_glink {
 	struct device *dev;
@@ -118,6 +120,8 @@ struct qcom_glink {
 	unsigned long features;
 
 	bool intentless;
+	wait_queue_head_t tx_avail_notify;
+	bool sent_read_notify;
 };
 
 enum {
@@ -187,20 +191,20 @@ struct glink_channel {
 
 static const struct rpmsg_endpoint_ops glink_endpoint_ops;
 
-#define RPM_CMD_VERSION			0
-#define RPM_CMD_VERSION_ACK		1
-#define RPM_CMD_OPEN			2
-#define RPM_CMD_CLOSE			3
-#define RPM_CMD_OPEN_ACK		4
-#define RPM_CMD_INTENT			5
-#define RPM_CMD_RX_DONE			6
-#define RPM_CMD_RX_INTENT_REQ		7
-#define RPM_CMD_RX_INTENT_REQ_ACK	8
-#define RPM_CMD_TX_DATA			9
-#define RPM_CMD_CLOSE_ACK		11
-#define RPM_CMD_TX_DATA_CONT		12
-#define RPM_CMD_READ_NOTIF		13
-#define RPM_CMD_RX_DONE_W_REUSE		14
+#define GLINK_CMD_VERSION		0
+#define GLINK_CMD_VERSION_ACK		1
+#define GLINK_CMD_OPEN			2
+#define GLINK_CMD_CLOSE			3
+#define GLINK_CMD_OPEN_ACK		4
+#define GLINK_CMD_INTENT		5
+#define GLINK_CMD_RX_DONE		6
+#define GLINK_CMD_RX_INTENT_REQ		7
+#define GLINK_CMD_RX_INTENT_REQ_ACK	8
+#define GLINK_CMD_TX_DATA		9
+#define GLINK_CMD_CLOSE_ACK		11
+#define GLINK_CMD_TX_DATA_CONT		12
+#define GLINK_CMD_READ_NOTIF		13
+#define GLINK_CMD_RX_DONE_W_REUSE	14
 
 #define GLINK_FEATURE_INTENTLESS	BIT(1)
 
@@ -305,6 +309,20 @@ static void qcom_glink_tx_write(struct qcom_glink *glink,
 	glink->tx_pipe->write(glink->tx_pipe, hdr, hlen, data, dlen);
 }
 
+static void qcom_glink_send_read_notify(struct qcom_glink *glink)
+{
+	struct glink_msg msg;
+
+	msg.cmd = cpu_to_le16(GLINK_CMD_READ_NOTIF);
+	msg.param1 = 0;
+	msg.param2 = 0;
+
+	qcom_glink_tx_write(glink, &msg, sizeof(msg), NULL, 0);
+
+	mbox_send_message(glink->mbox_chan, NULL);
+	mbox_client_txdone(glink->mbox_chan, 0);
+}
+
 static int qcom_glink_tx(struct qcom_glink *glink,
 			 const void *hdr, size_t hlen,
 			 const void *data, size_t dlen, bool wait)
@@ -325,12 +343,21 @@ static int qcom_glink_tx(struct qcom_glink *glink,
 			goto out;
 		}
 
+		if (!glink->sent_read_notify) {
+			glink->sent_read_notify = true;
+			qcom_glink_send_read_notify(glink);
+		}
+
 		/* Wait without holding the tx_lock */
 		spin_unlock_irqrestore(&glink->tx_lock, flags);
 
-		usleep_range(10000, 15000);
+		wait_event_timeout(glink->tx_avail_notify,
+				   qcom_glink_tx_avail(glink) >= tlen, 10 * HZ);
 
 		spin_lock_irqsave(&glink->tx_lock, flags);
+
+		if (qcom_glink_tx_avail(glink) >= tlen)
+			glink->sent_read_notify = false;
 	}
 
 	qcom_glink_tx_write(glink, hdr, hlen, data, dlen);
@@ -348,7 +375,7 @@ static int qcom_glink_send_version(struct qcom_glink *glink)
 {
 	struct glink_msg msg;
 
-	msg.cmd = cpu_to_le16(RPM_CMD_VERSION);
+	msg.cmd = cpu_to_le16(GLINK_CMD_VERSION);
 	msg.param1 = cpu_to_le16(GLINK_VERSION_1);
 	msg.param2 = cpu_to_le32(glink->features);
 
@@ -359,7 +386,7 @@ static void qcom_glink_send_version_ack(struct qcom_glink *glink)
 {
 	struct glink_msg msg;
 
-	msg.cmd = cpu_to_le16(RPM_CMD_VERSION_ACK);
+	msg.cmd = cpu_to_le16(GLINK_CMD_VERSION_ACK);
 	msg.param1 = cpu_to_le16(GLINK_VERSION_1);
 	msg.param2 = cpu_to_le32(glink->features);
 
@@ -371,7 +398,7 @@ static void qcom_glink_send_open_ack(struct qcom_glink *glink,
 {
 	struct glink_msg msg;
 
-	msg.cmd = cpu_to_le16(RPM_CMD_OPEN_ACK);
+	msg.cmd = cpu_to_le16(GLINK_CMD_OPEN_ACK);
 	msg.param1 = cpu_to_le16(channel->rcid);
 	msg.param2 = cpu_to_le32(0);
 
@@ -397,11 +424,11 @@ static void qcom_glink_handle_intent_req_ack(struct qcom_glink *glink,
 }
 
 /**
- * qcom_glink_send_open_req() - send a RPM_CMD_OPEN request to the remote
+ * qcom_glink_send_open_req() - send a GLINK_CMD_OPEN request to the remote
  * @glink: Ptr to the glink edge
  * @channel: Ptr to the channel that the open req is sent
  *
- * Allocates a local channel id and sends a RPM_CMD_OPEN message to the remote.
+ * Allocates a local channel id and sends a GLINK_CMD_OPEN message to the remote.
  * Will return with refcount held, regardless of outcome.
  *
  * Returns 0 on success, negative errno otherwise.
@@ -430,7 +457,7 @@ static int qcom_glink_send_open_req(struct qcom_glink *glink,
 
 	channel->lcid = ret;
 
-	req.msg.cmd = cpu_to_le16(RPM_CMD_OPEN);
+	req.msg.cmd = cpu_to_le16(GLINK_CMD_OPEN);
 	req.msg.param1 = cpu_to_le16(channel->lcid);
 	req.msg.param2 = cpu_to_le32(name_len);
 	strcpy(req.name, channel->name);
@@ -455,7 +482,7 @@ static void qcom_glink_send_close_req(struct qcom_glink *glink,
 {
 	struct glink_msg req;
 
-	req.cmd = cpu_to_le16(RPM_CMD_CLOSE);
+	req.cmd = cpu_to_le16(GLINK_CMD_CLOSE);
 	req.param1 = cpu_to_le16(channel->lcid);
 	req.param2 = 0;
 
@@ -467,7 +494,7 @@ static void qcom_glink_send_close_ack(struct qcom_glink *glink,
 {
 	struct glink_msg req;
 
-	req.cmd = cpu_to_le16(RPM_CMD_CLOSE_ACK);
+	req.cmd = cpu_to_le16(GLINK_CMD_CLOSE_ACK);
 	req.param1 = cpu_to_le16(rcid);
 	req.param2 = 0;
 
@@ -498,7 +525,7 @@ static void qcom_glink_rx_done_work(struct work_struct *work)
 		iid = intent->id;
 		reuse = intent->reuse;
 
-		cmd.id = reuse ? RPM_CMD_RX_DONE_W_REUSE : RPM_CMD_RX_DONE;
+		cmd.id = reuse ? GLINK_CMD_RX_DONE_W_REUSE : GLINK_CMD_RX_DONE;
 		cmd.lcid = cid;
 		cmd.liid = iid;
 
@@ -610,7 +637,7 @@ static int qcom_glink_send_intent_req_ack(struct qcom_glink *glink,
 {
 	struct glink_msg msg;
 
-	msg.cmd = cpu_to_le16(RPM_CMD_RX_INTENT_REQ_ACK);
+	msg.cmd = cpu_to_le16(GLINK_CMD_RX_INTENT_REQ_ACK);
 	msg.param1 = cpu_to_le16(channel->lcid);
 	msg.param2 = cpu_to_le32(granted);
 
@@ -641,7 +668,7 @@ static int qcom_glink_advertise_intent(struct qcom_glink *glink,
 	} __packed;
 	struct command cmd;
 
-	cmd.id = cpu_to_le16(RPM_CMD_INTENT);
+	cmd.id = cpu_to_le16(GLINK_CMD_INTENT);
 	cmd.lcid = cpu_to_le16(channel->lcid);
 	cmd.count = cpu_to_le32(1);
 	cmd.size = cpu_to_le32(intent->size);
@@ -991,6 +1018,9 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
 	unsigned int cmd;
 	int ret = 0;
 
+	/* To wakeup any blocking writers */
+	wake_up_all(&glink->tx_avail_notify);
+
 	for (;;) {
 		avail = qcom_glink_rx_avail(glink);
 		if (avail < sizeof(msg))
@@ -1003,42 +1033,43 @@ static irqreturn_t qcom_glink_native_intr(int irq, void *data)
 		param2 = le32_to_cpu(msg.param2);
 
 		switch (cmd) {
-		case RPM_CMD_VERSION:
-		case RPM_CMD_VERSION_ACK:
-		case RPM_CMD_CLOSE:
-		case RPM_CMD_CLOSE_ACK:
-		case RPM_CMD_RX_INTENT_REQ:
+		case GLINK_CMD_VERSION:
+		case GLINK_CMD_VERSION_ACK:
+		case GLINK_CMD_CLOSE:
+		case GLINK_CMD_CLOSE_ACK:
+		case GLINK_CMD_RX_INTENT_REQ:
 			ret = qcom_glink_rx_defer(glink, 0);
 			break;
-		case RPM_CMD_OPEN_ACK:
+		case GLINK_CMD_OPEN_ACK:
 			ret = qcom_glink_rx_open_ack(glink, param1);
 			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 			break;
-		case RPM_CMD_OPEN:
-			ret = qcom_glink_rx_defer(glink, param2);
+		case GLINK_CMD_OPEN:
+			/* upper 16 bits of param2 are the "prio" field */
+			ret = qcom_glink_rx_defer(glink, param2 & 0xffff);
 			break;
-		case RPM_CMD_TX_DATA:
-		case RPM_CMD_TX_DATA_CONT:
+		case GLINK_CMD_TX_DATA:
+		case GLINK_CMD_TX_DATA_CONT:
 			ret = qcom_glink_rx_data(glink, avail);
 			break;
-		case RPM_CMD_READ_NOTIF:
+		case GLINK_CMD_READ_NOTIF:
 			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 
 			mbox_send_message(glink->mbox_chan, NULL);
 			mbox_client_txdone(glink->mbox_chan, 0);
 			break;
-		case RPM_CMD_INTENT:
+		case GLINK_CMD_INTENT:
 			qcom_glink_handle_intent(glink, param1, param2, avail);
 			break;
-		case RPM_CMD_RX_DONE:
+		case GLINK_CMD_RX_DONE:
 			qcom_glink_handle_rx_done(glink, param1, param2, false);
 			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 			break;
-		case RPM_CMD_RX_DONE_W_REUSE:
+		case GLINK_CMD_RX_DONE_W_REUSE:
 			qcom_glink_handle_rx_done(glink, param1, param2, true);
 			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 			break;
-		case RPM_CMD_RX_INTENT_REQ_ACK:
+		case GLINK_CMD_RX_INTENT_REQ_ACK:
 			qcom_glink_handle_intent_req_ack(glink, param1, param2);
 			qcom_glink_rx_advance(glink, ALIGN(sizeof(msg), 8));
 			break;
@@ -1241,7 +1272,7 @@ static int qcom_glink_request_intent(struct qcom_glink *glink,
 
 	reinit_completion(&channel->intent_req_comp);
 
-	cmd.id = RPM_CMD_RX_INTENT_REQ;
+	cmd.id = GLINK_CMD_RX_INTENT_REQ;
 	cmd.cid = channel->lcid;
 	cmd.size = size;
 
@@ -1276,6 +1307,8 @@ static int __qcom_glink_send(struct glink_channel *channel,
 	} __packed req;
 	int ret;
 	unsigned long flags;
+	int chunk_size = len;
+	int left_size = 0;
 
 	if (!glink->intentless) {
 		while (!intent) {
@@ -1309,18 +1342,48 @@ static int __qcom_glink_send(struct glink_channel *channel,
 		iid = intent->id;
 	}
 
-	req.msg.cmd = cpu_to_le16(RPM_CMD_TX_DATA);
+	if (wait && chunk_size > SZ_8K) {
+		chunk_size = SZ_8K;
+		left_size = len - chunk_size;
+	}
+	req.msg.cmd = cpu_to_le16(GLINK_CMD_TX_DATA);
 	req.msg.param1 = cpu_to_le16(channel->lcid);
 	req.msg.param2 = cpu_to_le32(iid);
-	req.chunk_size = cpu_to_le32(len);
-	req.left_size = cpu_to_le32(0);
+	req.chunk_size = cpu_to_le32(chunk_size);
+	req.left_size = cpu_to_le32(left_size);
 
-	ret = qcom_glink_tx(glink, &req, sizeof(req), data, len, wait);
+	ret = qcom_glink_tx(glink, &req, sizeof(req), data, chunk_size, wait);
 
 	/* Mark intent available if we failed */
-	if (ret && intent)
-		intent->in_use = false;
+	if (ret) {
+		if (intent)
+			intent->in_use = false;
+		return ret;
+	}
+
+	while (left_size > 0) {
+		data = (void *)((char *)data + chunk_size);
+		chunk_size = left_size;
+		if (chunk_size > SZ_8K)
+			chunk_size = SZ_8K;
+		left_size -= chunk_size;
+
+		req.msg.cmd = cpu_to_le16(GLINK_CMD_TX_DATA_CONT);
+		req.msg.param1 = cpu_to_le16(channel->lcid);
+		req.msg.param2 = cpu_to_le32(iid);
+		req.chunk_size = cpu_to_le32(chunk_size);
+		req.left_size = cpu_to_le32(left_size);
 
+		ret = qcom_glink_tx(glink, &req, sizeof(req), data,
+				    chunk_size, wait);
+
+		/* Mark intent available if we failed */
+		if (ret) {
+			if (intent)
+				intent->in_use = false;
+			break;
+		}
+	}
 	return ret;
 }
 
@@ -1500,6 +1563,9 @@ static void qcom_glink_rx_close_ack(struct qcom_glink *glink, unsigned int lcid)
 	struct glink_channel *channel;
 	unsigned long flags;
 
+	/* To wakeup any blocking writers */
+	wake_up_all(&glink->tx_avail_notify);
+
 	spin_lock_irqsave(&glink->idr_lock, flags);
 	channel = idr_find(&glink->lcids, lcid);
 	if (WARN(!channel, "close ack on unknown channel\n")) {
@@ -1542,22 +1608,22 @@ static void qcom_glink_work(struct work_struct *work)
 		param2 = le32_to_cpu(msg->param2);
 
 		switch (cmd) {
-		case RPM_CMD_VERSION:
+		case GLINK_CMD_VERSION:
 			qcom_glink_receive_version(glink, param1, param2);
 			break;
-		case RPM_CMD_VERSION_ACK:
+		case GLINK_CMD_VERSION_ACK:
 			qcom_glink_receive_version_ack(glink, param1, param2);
 			break;
-		case RPM_CMD_OPEN:
+		case GLINK_CMD_OPEN:
 			qcom_glink_rx_open(glink, param1, msg->data);
 			break;
-		case RPM_CMD_CLOSE:
+		case GLINK_CMD_CLOSE:
 			qcom_glink_rx_close(glink, param1);
 			break;
-		case RPM_CMD_CLOSE_ACK:
+		case GLINK_CMD_CLOSE_ACK:
 			qcom_glink_rx_close_ack(glink, param1);
 			break;
-		case RPM_CMD_RX_INTENT_REQ:
+		case GLINK_CMD_RX_INTENT_REQ:
 			qcom_glink_handle_intent_req(glink, param1, param2);
 			break;
 		default:
@@ -1606,6 +1672,7 @@ struct qcom_glink *qcom_glink_native_probe(struct device *dev,
 	spin_lock_init(&glink->rx_lock);
 	INIT_LIST_HEAD(&glink->rx_queue);
 	INIT_WORK(&glink->rx_work, qcom_glink_work);
+	init_waitqueue_head(&glink->tx_avail_notify);
 
 	spin_lock_init(&glink->idr_lock);
 	idr_init(&glink->lcids);
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index ce051f91829f..1ab619fb978a 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -914,13 +914,18 @@ void rtc_timer_do_work(struct work_struct *work)
 	struct timerqueue_node *next;
 	ktime_t now;
 	struct rtc_time tm;
+	int err;
 
 	struct rtc_device *rtc =
 		container_of(work, struct rtc_device, irqwork);
 
 	mutex_lock(&rtc->ops_lock);
 again:
-	__rtc_read_time(rtc, &tm);
+	err = __rtc_read_time(rtc, &tm);
+	if (err) {
+		mutex_unlock(&rtc->ops_lock);
+		return;
+	}
 	now = rtc_tm_to_ktime(tm);
 	while ((next = timerqueue_getnext(&rtc->timerqueue))) {
 		if (next->expires > now)
diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
index bd7e6a6fc1f1..7a2a9b05ed09 100644
--- a/drivers/scsi/bfa/bfad.c
+++ b/drivers/scsi/bfa/bfad.c
@@ -1711,9 +1711,8 @@ bfad_init(void)
 
 	error = bfad_im_module_init();
 	if (error) {
-		error = -ENOMEM;
 		printk(KERN_WARNING "bfad_im_module_init failure\n");
-		goto ext;
+		return -ENOMEM;
 	}
 
 	if (strcmp(FCPI_NAME, " fcpim") == 0)
diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 7a179cfc01ed..15567e60216e 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -357,6 +357,7 @@ static int qedi_alloc_and_init_sb(struct qedi_ctx *qedi,
 	ret = qedi_ops->common->sb_init(qedi->cdev, sb_info, sb_virt, sb_phys,
 				       sb_id, QED_SB_TYPE_STORAGE);
 	if (ret) {
+		dma_free_coherent(&qedi->pdev->dev, sizeof(*sb_virt), sb_virt, sb_phys);
 		QEDI_ERR(&qedi->dbg_ctx,
 			 "Status block initialization failed for id = %d.\n",
 			  sb_id);
diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 46f0f322d4d8..48fe5fab5693 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -194,7 +194,6 @@ int __init register_intc_controller(struct intc_desc *desc)
 		goto err0;
 
 	INIT_LIST_HEAD(&d->list);
-	list_add_tail(&d->list, &intc_list);
 
 	raw_spin_lock_init(&d->lock);
 	INIT_RADIX_TREE(&d->tree, GFP_ATOMIC);
@@ -380,6 +379,7 @@ int __init register_intc_controller(struct intc_desc *desc)
 
 	d->skip_suspend = desc->skip_syscore_suspend;
 
+	list_add_tail(&d->list, &intc_list);
 	nr_intc_controllers++;
 
 	return 0;
diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 7369b061929b..4e1c6c5ea9c9 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -542,7 +542,8 @@ int geni_se_clk_tbl_get(struct geni_se *se, unsigned long **tbl)
 
 	for (i = 0; i < MAX_CLK_PERF_LEVEL; i++) {
 		freq = clk_round_rate(se->clk, freq + 1);
-		if (freq <= 0 || freq == se->clk_perf_tbl[i - 1])
+		if (freq <= 0 ||
+		    (i > 0 && freq == se->clk_perf_tbl[i - 1]))
 			break;
 		se->clk_perf_tbl[i] = freq;
 	}
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a15545cee4d2..d69a81a96c83 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -358,6 +358,16 @@ static int spi_drv_probe(struct device *dev)
 			spi->irq = 0;
 	}
 
+	if (has_acpi_companion(dev) && spi->irq < 0) {
+		struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
+
+		spi->irq = acpi_dev_gpio_irq_get(adev, 0);
+		if (spi->irq == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		if (spi->irq < 0)
+			spi->irq = 0;
+	}
+
 	ret = dev_pm_domain_attach(dev, true);
 	if (ret)
 		return ret;
@@ -1843,9 +1853,6 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
 	acpi_set_modalias(adev, acpi_device_hid(adev), spi->modalias,
 			  sizeof(spi->modalias));
 
-	if (spi->irq < 0)
-		spi->irq = acpi_dev_gpio_irq_get(adev, 0);
-
 	acpi_device_set_enumerated(adev);
 
 	adev->power.flags.ignore_parent = true;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index b9352d3bb2ed..77bef81488f2 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -643,12 +643,12 @@ static void omap_8250_shutdown(struct uart_port *port)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct omap8250_priv *priv = port->private_data;
 
+	pm_runtime_get_sync(port->dev);
+
 	flush_work(&priv->qos_work);
 	if (up->dma)
 		omap_8250_rx_dma_flush(up);
 
-	pm_runtime_get_sync(port->dev);
-
 	serial_out(up, UART_OMAP_WER, 0);
 
 	up->ier = 0;
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 245c9a51c2de..a0866a7a4baf 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -854,7 +854,7 @@ static struct ctl_table tty_table[] = {
 		.data		= &tty_ldisc_autoload,
 		.maxlen		= sizeof(tty_ldisc_autoload),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &zero,
 		.extra2		= &one,
 	},
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index c6610c15e03e..0396abf03b74 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -903,11 +903,14 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 	 * pending to be processed by the driver.
 	 */
 	if (dep->trb_enqueue == dep->trb_dequeue) {
+		struct dwc3_request *req;
+
 		/*
-		 * If there is any request remained in the started_list at
-		 * this point, that means there is no TRB available.
+		 * If there is any request remained in the started_list with
+		 * active TRBs at this point, then there is no TRB available.
 		 */
-		if (!list_empty(&dep->started_list))
+		req = next_request(&dep->started_list);
+		if (req && req->num_trbs)
 			return 0;
 
 		return DWC3_TRB_NUM - 1;
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index f9e82bbf596d..f340d7ac635b 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1910,8 +1910,20 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			memset(buf, 0, w_length);
 			buf[5] = 0x01;
 			switch (ctrl->bRequestType & USB_RECIP_MASK) {
+			/*
+			 * The Microsoft CompatID OS Descriptor Spec(w_index = 0x4) and
+			 * Extended Prop OS Desc Spec(w_index = 0x5) state that the
+			 * HighByte of wValue is the InterfaceNumber and the LowByte is
+			 * the PageNumber. This high/low byte ordering is incorrectly
+			 * documented in the Spec. USB analyzer output on the below
+			 * request packets show the high/low byte inverted i.e LowByte
+			 * is the InterfaceNumber and the HighByte is the PageNumber.
+			 * Since we dont support >64KB CompatID/ExtendedProp descriptors,
+			 * PageNumber is set to 0. Hence verify that the HighByte is 0
+			 * for below two cases.
+			 */
 			case USB_RECIP_DEVICE:
-				if (w_index != 0x4 || (w_value & 0xff))
+				if (w_index != 0x4 || (w_value >> 8))
 					break;
 				buf[6] = w_index;
 				/* Number of ext compat interfaces */
@@ -1927,9 +1939,9 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 				}
 				break;
 			case USB_RECIP_INTERFACE:
-				if (w_index != 0x5 || (w_value & 0xff))
+				if (w_index != 0x5 || (w_value >> 8))
 					break;
-				interface = w_value >> 8;
+				interface = w_value & 0xFF;
 				if (interface >= MAX_CONFIG_INTERFACES ||
 				    !os_desc_cfg->interface[interface])
 					break;
diff --git a/drivers/usb/host/ehci-spear.c b/drivers/usb/host/ehci-spear.c
index add796c78561..90bc254a4f03 100644
--- a/drivers/usb/host/ehci-spear.c
+++ b/drivers/usb/host/ehci-spear.c
@@ -110,7 +110,9 @@ static int spear_ehci_hcd_drv_probe(struct platform_device *pdev)
 	/* registers start at offset 0x0 */
 	hcd_to_ehci(hcd)->caps = hcd->regs;
 
-	clk_prepare_enable(sehci->clk);
+	retval = clk_prepare_enable(sehci->clk);
+	if (retval)
+		goto err_put_hcd;
 	retval = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (retval)
 		goto err_stop_ehci;
@@ -135,8 +137,7 @@ static int spear_ehci_hcd_drv_remove(struct platform_device *pdev)
 
 	usb_remove_hcd(hcd);
 
-	if (sehci->clk)
-		clk_disable_unprepare(sehci->clk);
+	clk_disable_unprepare(sehci->clk);
 	usb_put_hcd(hcd);
 
 	return 0;
diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
index 87067c3d6109..d99d424c05a7 100644
--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -27,6 +27,8 @@ static struct usb_class_driver chaoskey_class;
 static int chaoskey_rng_read(struct hwrng *rng, void *data,
 			     size_t max, bool wait);
 
+static DEFINE_MUTEX(chaoskey_list_lock);
+
 #define usb_dbg(usb_if, format, arg...) \
 	dev_dbg(&(usb_if)->dev, format, ## arg)
 
@@ -234,6 +236,7 @@ static void chaoskey_disconnect(struct usb_interface *interface)
 	usb_deregister_dev(interface, &chaoskey_class);
 
 	usb_set_intfdata(interface, NULL);
+	mutex_lock(&chaoskey_list_lock);
 	mutex_lock(&dev->lock);
 
 	dev->present = false;
@@ -245,6 +248,7 @@ static void chaoskey_disconnect(struct usb_interface *interface)
 	} else
 		mutex_unlock(&dev->lock);
 
+	mutex_unlock(&chaoskey_list_lock);
 	usb_dbg(interface, "disconnect done");
 }
 
@@ -252,6 +256,7 @@ static int chaoskey_open(struct inode *inode, struct file *file)
 {
 	struct chaoskey *dev;
 	struct usb_interface *interface;
+	int rv = 0;
 
 	/* get the interface from minor number and driver information */
 	interface = usb_find_interface(&chaoskey_driver, iminor(inode));
@@ -267,18 +272,23 @@ static int chaoskey_open(struct inode *inode, struct file *file)
 	}
 
 	file->private_data = dev;
+	mutex_lock(&chaoskey_list_lock);
 	mutex_lock(&dev->lock);
-	++dev->open;
+	if (dev->present)
+		++dev->open;
+	else
+		rv = -ENODEV;
 	mutex_unlock(&dev->lock);
+	mutex_unlock(&chaoskey_list_lock);
 
-	usb_dbg(interface, "open success");
-	return 0;
+	return rv;
 }
 
 static int chaoskey_release(struct inode *inode, struct file *file)
 {
 	struct chaoskey *dev = file->private_data;
 	struct usb_interface *interface;
+	int rv = 0;
 
 	if (dev == NULL)
 		return -ENODEV;
@@ -287,14 +297,15 @@ static int chaoskey_release(struct inode *inode, struct file *file)
 
 	usb_dbg(interface, "release");
 
+	mutex_lock(&chaoskey_list_lock);
 	mutex_lock(&dev->lock);
 
 	usb_dbg(interface, "open count at release is %d", dev->open);
 
 	if (dev->open <= 0) {
 		usb_dbg(interface, "invalid open count (%d)", dev->open);
-		mutex_unlock(&dev->lock);
-		return -ENODEV;
+		rv = -ENODEV;
+		goto bail;
 	}
 
 	--dev->open;
@@ -303,13 +314,15 @@ static int chaoskey_release(struct inode *inode, struct file *file)
 		if (dev->open == 0) {
 			mutex_unlock(&dev->lock);
 			chaoskey_free(dev);
-		} else
-			mutex_unlock(&dev->lock);
-	} else
-		mutex_unlock(&dev->lock);
-
+			goto destruction;
+		}
+	}
+bail:
+	mutex_unlock(&dev->lock);
+destruction:
+	mutex_unlock(&chaoskey_list_lock);
 	usb_dbg(interface, "release success");
-	return 0;
+	return rv;
 }
 
 static void chaos_read_callback(struct urb *urb)
diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 8b04d2705920..44a70e033468 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -281,28 +281,45 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
 	struct iowarrior *dev;
 	int read_idx;
 	int offset;
+	int retval;
 
 	dev = file->private_data;
 
+	if (file->f_flags & O_NONBLOCK) {
+		retval = mutex_trylock(&dev->mutex);
+		if (!retval)
+			return -EAGAIN;
+	} else {
+		retval = mutex_lock_interruptible(&dev->mutex);
+		if (retval)
+			return -ERESTARTSYS;
+	}
+
 	/* verify that the device wasn't unplugged */
-	if (!dev || !dev->present)
-		return -ENODEV;
+	if (!dev->present) {
+		retval = -ENODEV;
+		goto exit;
+	}
 
 	dev_dbg(&dev->interface->dev, "minor %d, count = %zd\n",
 		dev->minor, count);
 
 	/* read count must be packet size (+ time stamp) */
 	if ((count != dev->report_size)
-	    && (count != (dev->report_size + 1)))
-		return -EINVAL;
+	    && (count != (dev->report_size + 1))) {
+		retval = -EINVAL;
+		goto exit;
+	}
 
 	/* repeat until no buffer overrun in callback handler occur */
 	do {
 		atomic_set(&dev->overflow_flag, 0);
 		if ((read_idx = read_index(dev)) == -1) {
 			/* queue empty */
-			if (file->f_flags & O_NONBLOCK)
-				return -EAGAIN;
+			if (file->f_flags & O_NONBLOCK) {
+				retval = -EAGAIN;
+				goto exit;
+			}
 			else {
 				//next line will return when there is either new data, or the device is unplugged
 				int r = wait_event_interruptible(dev->read_wait,
@@ -313,28 +330,37 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
 								  -1));
 				if (r) {
 					//we were interrupted by a signal
-					return -ERESTART;
+					retval = -ERESTART;
+					goto exit;
 				}
 				if (!dev->present) {
 					//The device was unplugged
-					return -ENODEV;
+					retval = -ENODEV;
+					goto exit;
 				}
 				if (read_idx == -1) {
 					// Can this happen ???
-					return 0;
+					retval = 0;
+					goto exit;
 				}
 			}
 		}
 
 		offset = read_idx * (dev->report_size + 1);
 		if (copy_to_user(buffer, dev->read_queue + offset, count)) {
-			return -EFAULT;
+			retval = -EFAULT;
+			goto exit;
 		}
 	} while (atomic_read(&dev->overflow_flag));
 
 	read_idx = ++read_idx == MAX_INTERRUPT_BUFFER ? 0 : read_idx;
 	atomic_set(&dev->read_idx, read_idx);
+	mutex_unlock(&dev->mutex);
 	return count;
+
+exit:
+	mutex_unlock(&dev->mutex);
+	return retval;
 }
 
 /*
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 86e917f1cc21..0f20e2d977d4 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -315,6 +315,10 @@ static int vfio_virt_config_read(struct vfio_pci_device *vdev, int pos,
 	return count;
 }
 
+static struct perm_bits direct_ro_perms = {
+	.readfn = vfio_direct_config_read,
+};
+
 /* Default capability regions to read-only, no-virtualization */
 static struct perm_bits cap_perms[PCI_CAP_ID_MAX + 1] = {
 	[0 ... PCI_CAP_ID_MAX] = { .readfn = vfio_direct_config_read }
@@ -1837,9 +1841,17 @@ static ssize_t vfio_config_do_rw(struct vfio_pci_device *vdev, char __user *buf,
 		cap_start = *ppos;
 	} else {
 		if (*ppos >= PCI_CFG_SPACE_SIZE) {
-			WARN_ON(cap_id > PCI_EXT_CAP_ID_MAX);
+			/*
+			 * We can get a cap_id that exceeds PCI_EXT_CAP_ID_MAX
+			 * if we're hiding an unknown capability at the start
+			 * of the extended capability list.  Use default, ro
+			 * access, which will virtualize the id and next values.
+			 */
+			if (cap_id > PCI_EXT_CAP_ID_MAX)
+				perm = &direct_ro_perms;
+			else
+				perm = &ecap_perms[cap_id];
 
-			perm = &ecap_perms[cap_id];
 			cap_start = vfio_find_cap_start(vdev, *ppos);
 		} else {
 			WARN_ON(cap_id > PCI_CAP_ID_MAX);
diff --git a/drivers/video/fbdev/sh7760fb.c b/drivers/video/fbdev/sh7760fb.c
index 96de91d76623..d4ef70b17885 100644
--- a/drivers/video/fbdev/sh7760fb.c
+++ b/drivers/video/fbdev/sh7760fb.c
@@ -362,7 +362,7 @@ static void sh7760fb_free_mem(struct fb_info *info)
 	if (!info->screen_base)
 		return;
 
-	dma_free_coherent(info->dev, info->screen_size,
+	dma_free_coherent(info->device, info->screen_size,
 			  info->screen_base, par->fbdma);
 
 	par->fbdma = 0;
@@ -411,14 +411,13 @@ static int sh7760fb_alloc_mem(struct fb_info *info)
 	if (vram < PAGE_SIZE)
 		vram = PAGE_SIZE;
 
-	fbmem = dma_alloc_coherent(info->dev, vram, &par->fbdma, GFP_KERNEL);
-
+	fbmem = dma_alloc_coherent(info->device, vram, &par->fbdma, GFP_KERNEL);
 	if (!fbmem)
 		return -ENOMEM;
 
 	if ((par->fbdma & SH7760FB_DMA_MASK) != SH7760FB_DMA_MASK) {
-		sh7760fb_free_mem(info);
-		dev_err(info->dev, "kernel gave me memory at 0x%08lx, which is"
+		dma_free_coherent(info->device, vram, fbmem, par->fbdma);
+		dev_err(info->device, "kernel gave me memory at 0x%08lx, which is"
 			"unusable for the LCDC\n", (unsigned long)par->fbdma);
 		return -ENOMEM;
 	}
@@ -489,7 +488,7 @@ static int sh7760fb_probe(struct platform_device *pdev)
 
 	ret = sh7760fb_alloc_mem(info);
 	if (ret) {
-		dev_dbg(info->dev, "framebuffer memory allocation failed!\n");
+		dev_dbg(info->device, "framebuffer memory allocation failed!\n");
 		goto out_unmap;
 	}
 
diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 69c76327792e..3da77fe790cd 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -185,6 +185,56 @@ static inline ext4_fsblk_t ext4_fsmap_next_pblk(struct ext4_fsmap *fmr)
 	return fmr->fmr_physical + fmr->fmr_length;
 }
 
+static int ext4_getfsmap_meta_helper(struct super_block *sb,
+				     ext4_group_t agno, ext4_grpblk_t start,
+				     ext4_grpblk_t len, void *priv)
+{
+	struct ext4_getfsmap_info *info = priv;
+	struct ext4_fsmap *p;
+	struct ext4_fsmap *tmp;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	ext4_fsblk_t fsb, fs_start, fs_end;
+	int error;
+
+	fs_start = fsb = (EXT4_C2B(sbi, start) +
+			  ext4_group_first_block_no(sb, agno));
+	fs_end = fs_start + EXT4_C2B(sbi, len);
+
+	/* Return relevant extents from the meta_list */
+	list_for_each_entry_safe(p, tmp, &info->gfi_meta_list, fmr_list) {
+		if (p->fmr_physical < info->gfi_next_fsblk) {
+			list_del(&p->fmr_list);
+			kfree(p);
+			continue;
+		}
+		if (p->fmr_physical <= fs_start ||
+		    p->fmr_physical + p->fmr_length <= fs_end) {
+			/* Emit the retained free extent record if present */
+			if (info->gfi_lastfree.fmr_owner) {
+				error = ext4_getfsmap_helper(sb, info,
+							&info->gfi_lastfree);
+				if (error)
+					return error;
+				info->gfi_lastfree.fmr_owner = 0;
+			}
+			error = ext4_getfsmap_helper(sb, info, p);
+			if (error)
+				return error;
+			fsb = p->fmr_physical + p->fmr_length;
+			if (info->gfi_next_fsblk < fsb)
+				info->gfi_next_fsblk = fsb;
+			list_del(&p->fmr_list);
+			kfree(p);
+			continue;
+		}
+	}
+	if (info->gfi_next_fsblk < fsb)
+		info->gfi_next_fsblk = fsb;
+
+	return 0;
+}
+
+
 /* Transform a blockgroup's free record into a fsmap */
 static int ext4_getfsmap_datadev_helper(struct super_block *sb,
 					ext4_group_t agno, ext4_grpblk_t start,
@@ -539,6 +589,7 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 		error = ext4_mballoc_query_range(sb, info->gfi_agno,
 				EXT4_B2C(sbi, info->gfi_low.fmr_physical),
 				EXT4_B2C(sbi, info->gfi_high.fmr_physical),
+				ext4_getfsmap_meta_helper,
 				ext4_getfsmap_datadev_helper, info);
 		if (error)
 			goto err;
@@ -560,7 +611,8 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 
 	/* Report any gaps at the end of the bg */
 	info->gfi_last = true;
-	error = ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster, 0, info);
+	error = ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster + 1,
+					     0, info);
 	if (error)
 		goto err;
 
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 329b3cf10574..ef12b221781e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5424,13 +5424,14 @@ int
 ext4_mballoc_query_range(
 	struct super_block		*sb,
 	ext4_group_t			group,
-	ext4_grpblk_t			start,
+	ext4_grpblk_t			first,
 	ext4_grpblk_t			end,
+	ext4_mballoc_query_range_fn	meta_formatter,
 	ext4_mballoc_query_range_fn	formatter,
 	void				*priv)
 {
 	void				*bitmap;
-	ext4_grpblk_t			next;
+	ext4_grpblk_t			start, next;
 	struct ext4_buddy		e4b;
 	int				error;
 
@@ -5441,10 +5442,19 @@ ext4_mballoc_query_range(
 
 	ext4_lock_group(sb, group);
 
-	start = max(e4b.bd_info->bb_first_free, start);
+	start = max(e4b.bd_info->bb_first_free, first);
 	if (end >= EXT4_CLUSTERS_PER_GROUP(sb))
 		end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
-
+	if (meta_formatter && start != first) {
+		if (start > end)
+			start = end;
+		ext4_unlock_group(sb, group);
+		error = meta_formatter(sb, group, first, start - first,
+				       priv);
+		if (error)
+			goto out_unload;
+		ext4_lock_group(sb, group);
+	}
 	while (start <= end) {
 		start = mb_find_next_zero_bit(bitmap, end + 1, start);
 		if (start > end)
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 88c98f17e3d9..48f17c2b4fe9 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -212,6 +212,7 @@ ext4_mballoc_query_range(
 	ext4_group_t			agno,
 	ext4_grpblk_t			start,
 	ext4_grpblk_t			end,
+	ext4_mballoc_query_range_fn	meta_formatter,
 	ext4_mballoc_query_range_fn	formatter,
 	void				*priv);
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 926063a6d232..f89c9bec5f11 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -258,9 +258,9 @@ __u32 ext4_free_group_clusters(struct super_block *sb,
 __u32 ext4_free_inodes_count(struct super_block *sb,
 			      struct ext4_group_desc *bg)
 {
-	return le16_to_cpu(bg->bg_free_inodes_count_lo) |
+	return le16_to_cpu(READ_ONCE(bg->bg_free_inodes_count_lo)) |
 		(EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT ?
-		 (__u32)le16_to_cpu(bg->bg_free_inodes_count_hi) << 16 : 0);
+		 (__u32)le16_to_cpu(READ_ONCE(bg->bg_free_inodes_count_hi)) << 16 : 0);
 }
 
 __u32 ext4_used_dirs_count(struct super_block *sb,
@@ -314,9 +314,9 @@ void ext4_free_group_clusters_set(struct super_block *sb,
 void ext4_free_inodes_set(struct super_block *sb,
 			  struct ext4_group_desc *bg, __u32 count)
 {
-	bg->bg_free_inodes_count_lo = cpu_to_le16((__u16)count);
+	WRITE_ONCE(bg->bg_free_inodes_count_lo, cpu_to_le16((__u16)count));
 	if (EXT4_DESC_SIZE(sb) >= EXT4_MIN_DESC_SIZE_64BIT)
-		bg->bg_free_inodes_count_hi = cpu_to_le16(count >> 16);
+		WRITE_ONCE(bg->bg_free_inodes_count_hi, cpu_to_le16(count >> 16));
 }
 
 void ext4_used_dirs_set(struct super_block *sb,
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index e9b13f771990..2d6f2c62230a 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -156,6 +156,7 @@ struct hfsplus_sb_info {
 
 	/* Runtime variables */
 	u32 blockoffset;
+	u32 min_io_size;
 	sector_t part_start;
 	sector_t sect_count;
 	int fs_shift;
@@ -306,7 +307,7 @@ struct hfsplus_readdir_data {
  */
 static inline unsigned short hfsplus_min_io_size(struct super_block *sb)
 {
-	return max_t(unsigned short, bdev_logical_block_size(sb->s_bdev),
+	return max_t(unsigned short, HFSPLUS_SB(sb)->min_io_size,
 		     HFSPLUS_SECTOR_SIZE);
 }
 
diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 08c1580bdf7a..eb76ba8e8fec 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -170,6 +170,8 @@ int hfsplus_read_wrapper(struct super_block *sb)
 	if (!blocksize)
 		goto out;
 
+	sbi->min_io_size = blocksize;
+
 	if (hfsplus_get_last_session(sb, &part_start, &part_size))
 		goto out;
 
diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index 7e9abdb89712..5fbaf6ab9f48 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -340,10 +340,9 @@ static int jffs2_block_check_erase(struct jffs2_sb_info *c, struct jffs2_erasebl
 		} while(--retlen);
 		mtd_unpoint(c->mtd, jeb->offset, c->sector_size);
 		if (retlen) {
-			pr_warn("Newly-erased block contained word 0x%lx at offset 0x%08tx\n",
-				*wordebuf,
-				jeb->offset +
-				c->sector_size-retlen * sizeof(*wordebuf));
+			*bad_offset = jeb->offset + c->sector_size - retlen * sizeof(*wordebuf);
+			pr_warn("Newly-erased block contained word 0x%lx at offset 0x%08x\n",
+				*wordebuf, *bad_offset);
 			return -EIO;
 		}
 		return 0;
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index bb8c4583f065..874e635acff8 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -572,7 +572,7 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 
       size_check:
 	if (EALIST_SIZE(ea_buf->xattr) != ea_size) {
-		int size = min_t(int, EALIST_SIZE(ea_buf->xattr), ea_size);
+		int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
 
 		printk(KERN_ERR "ea_get: invalid extended attribute\n");
 		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c9db9a0fc733..66db81a90cee 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -2379,12 +2379,14 @@ static void nfs4_open_release(void *calldata)
 	struct nfs4_opendata *data = calldata;
 	struct nfs4_state *state = NULL;
 
+	/* In case of error, no cleanup! */
+	if (data->rpc_status != 0 || !data->rpc_done) {
+		nfs_release_seqid(data->o_arg.seqid);
+		goto out_free;
+	}
 	/* If this request hasn't been cancelled, do nothing */
 	if (!data->cancelled)
 		goto out_free;
-	/* In case of error, no cleanup! */
-	if (data->rpc_status != 0 || !data->rpc_done)
-		goto out_free;
 	/* In case we need an open_confirm, no cleanup! */
 	if (data->o_res.rflags & NFS4_OPEN_RESULT_CONFIRM)
 		goto out_free;
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index e6c7448d3d89..f564cd56aeff 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -283,17 +283,17 @@ static int decode_cb_compound4res(struct xdr_stream *xdr,
 	u32 length;
 	__be32 *p;
 
-	p = xdr_inline_decode(xdr, 4 + 4);
+	p = xdr_inline_decode(xdr, XDR_UNIT);
 	if (unlikely(p == NULL))
 		goto out_overflow;
-	hdr->status = be32_to_cpup(p++);
+	hdr->status = be32_to_cpup(p);
 	/* Ignore the tag */
-	length = be32_to_cpup(p++);
-	p = xdr_inline_decode(xdr, length + 4);
-	if (unlikely(p == NULL))
+	if (xdr_stream_decode_u32(xdr, &length) < 0)
+		goto out_overflow;
+	if (xdr_inline_decode(xdr, length) == NULL)
+		goto out_overflow;
+	if (xdr_stream_decode_u32(xdr, &hdr->nops) < 0)
 		goto out_overflow;
-	p += XDR_QUADLEN(length);
-	hdr->nops = be32_to_cpup(p);
 	return 0;
 out_overflow:
 	return -EIO;
@@ -1134,6 +1134,8 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 		ses = c->cn_session;
 	}
 	spin_unlock(&clp->cl_lock);
+	if (!c)
+		return;
 
 	err = setup_callback_client(clp, &conn, ses);
 	if (err) {
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 5188f9f70c78..e986e9e0c93f 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -596,7 +596,8 @@ nfs4_reset_recoverydir(char *recdir)
 		return status;
 	status = -ENOTDIR;
 	if (d_is_dir(path.dentry)) {
-		strcpy(user_recovery_dirname, recdir);
+		strscpy(user_recovery_dirname, recdir,
+			sizeof(user_recovery_dirname));
 		status = 0;
 	}
 	path_put(&path);
diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index eb195c33c9a9..799b42e83d7c 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -68,7 +68,6 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 		goto failed;
 	}
 	memset(bh->b_data, 0, i_blocksize(inode));
-	bh->b_bdev = inode->i_sb->s_bdev;
 	bh->b_blocknr = blocknr;
 	set_buffer_mapped(bh);
 	set_buffer_uptodate(bh);
@@ -133,7 +132,6 @@ int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
 		goto found;
 	}
 	set_buffer_mapped(bh);
-	bh->b_bdev = inode->i_sb->s_bdev;
 	bh->b_blocknr = pblocknr; /* set block address for read */
 	bh->b_end_io = end_buffer_read_sync;
 	get_bh(bh);
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index b0077f5f7112..518e10be1073 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -83,10 +83,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 		goto out;
 	}
 
-	if (!buffer_mapped(bh)) {
-		bh->b_bdev = inode->i_sb->s_bdev;
+	if (!buffer_mapped(bh))
 		set_buffer_mapped(bh);
-	}
 	bh->b_blocknr = pbn;
 	bh->b_end_io = end_buffer_read_sync;
 	get_bh(bh);
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index e80ef2c0a785..c1f964916489 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -89,7 +89,6 @@ static int nilfs_mdt_create_block(struct inode *inode, unsigned long block,
 	if (buffer_uptodate(bh))
 		goto failed_bh;
 
-	bh->b_bdev = sb->s_bdev;
 	err = nilfs_mdt_insert_new_block(inode, block, bh, init_block);
 	if (likely(!err)) {
 		get_bh(bh);
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 6e02bd5e2f18..beb095d49138 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -39,7 +39,6 @@ __nilfs_get_page_block(struct page *page, unsigned long block, pgoff_t index,
 	first_block = (unsigned long)index << (PAGE_SHIFT - blkbits);
 	bh = nilfs_page_get_nth_block(page, block - first_block);
 
-	touch_buffer(bh);
 	wait_on_buffer(bh);
 	return bh;
 }
@@ -64,6 +63,7 @@ struct buffer_head *nilfs_grab_buffer(struct inode *inode,
 		put_page(page);
 		return NULL;
 	}
+	bh->b_bdev = inode->i_sb->s_bdev;
 	return bh;
 }
 
diff --git a/fs/ocfs2/aops.h b/fs/ocfs2/aops.h
index 3494a62ed749..c1c218902990 100644
--- a/fs/ocfs2/aops.h
+++ b/fs/ocfs2/aops.h
@@ -86,6 +86,8 @@ enum ocfs2_iocb_lock_bits {
 	OCFS2_IOCB_NUM_LOCKS
 };
 
+#define ocfs2_iocb_init_rw_locked(iocb) \
+	(iocb->private = NULL)
 #define ocfs2_iocb_clear_rw_locked(iocb) \
 	clear_bit(OCFS2_IOCB_RW_LOCK, (unsigned long *)&iocb->private)
 #define ocfs2_iocb_rw_locked_level(iocb) \
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 9062002fd56c..08cd712b433c 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2412,6 +2412,8 @@ static ssize_t ocfs2_file_write_iter(struct kiocb *iocb,
 	} else
 		inode_lock(inode);
 
+	ocfs2_iocb_init_rw_locked(iocb);
+
 	/*
 	 * Concurrent O_DIRECT writes are allowed with
 	 * mount_option "coherency=buffered".
@@ -2558,6 +2560,8 @@ static ssize_t ocfs2_file_read_iter(struct kiocb *iocb,
 	if (!direct_io && nowait)
 		return -EOPNOTSUPP;
 
+	ocfs2_iocb_init_rw_locked(iocb);
+
 	/*
 	 * buffered reads protect themselves in ->readpage().  O_DIRECT reads
 	 * need locks to protect pending reads from racing with truncate.
diff --git a/fs/ocfs2/resize.c b/fs/ocfs2/resize.c
index 18451e0fab81..b0be92d2f05f 100644
--- a/fs/ocfs2/resize.c
+++ b/fs/ocfs2/resize.c
@@ -582,6 +582,8 @@ int ocfs2_group_add(struct inode *inode, struct ocfs2_new_group_input *input)
 	ocfs2_commit_trans(osb, handle);
 
 out_free_group_bh:
+	if (ret < 0)
+		ocfs2_remove_from_cache(INODE_CACHE(inode), group_bh);
 	brelse(group_bh);
 
 out_unlock:
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 4fd99ef7f334..690c2ec55461 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -2374,6 +2374,7 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
 			       struct ocfs2_blockcheck_stats *stats)
 {
 	int status = -EAGAIN;
+	u32 blksz_bits;
 
 	if (memcmp(di->i_signature, OCFS2_SUPER_BLOCK_SIGNATURE,
 		   strlen(OCFS2_SUPER_BLOCK_SIGNATURE)) == 0) {
@@ -2388,11 +2389,15 @@ static int ocfs2_verify_volume(struct ocfs2_dinode *di,
 				goto out;
 		}
 		status = -EINVAL;
-		if ((1 << le32_to_cpu(di->id2.i_super.s_blocksize_bits)) != blksz) {
+		/* Acceptable block sizes are 512 bytes, 1K, 2K and 4K. */
+		blksz_bits = le32_to_cpu(di->id2.i_super.s_blocksize_bits);
+		if (blksz_bits < 9 || blksz_bits > 12) {
 			mlog(ML_ERROR, "found superblock with incorrect block "
-			     "size: found %u, should be %u\n",
-			     1 << le32_to_cpu(di->id2.i_super.s_blocksize_bits),
-			       blksz);
+			     "size bits: found %u, should be 9, 10, 11, or 12\n",
+			     blksz_bits);
+		} else if ((1 << le32_to_cpu(blksz_bits)) != blksz) {
+			mlog(ML_ERROR, "found superblock with incorrect block "
+			     "size: found %u, should be %u\n", 1 << blksz_bits, blksz);
 		} else if (le16_to_cpu(di->id2.i_super.s_major_rev_level) !=
 			   OCFS2_MAJOR_REV_LEVEL ||
 			   le16_to_cpu(di->id2.i_super.s_minor_rev_level) !=
diff --git a/fs/proc/softirqs.c b/fs/proc/softirqs.c
index 12901dcf57e2..d8f4e7d54d00 100644
--- a/fs/proc/softirqs.c
+++ b/fs/proc/softirqs.c
@@ -19,7 +19,7 @@ static int show_softirqs(struct seq_file *p, void *v)
 	for (i = 0; i < NR_SOFTIRQS; i++) {
 		seq_printf(p, "%12s:", softirq_to_name[i]);
 		for_each_possible_cpu(j)
-			seq_printf(p, " %10u", kstat_softirqs_cpu(i, j));
+			seq_put_decimal_ull_width(p, " ", kstat_softirqs_cpu(i, j), 10);
 		seq_putc(p, '\n');
 	}
 	return 0;
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index f5b663d70826..1d548f86a41d 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -755,10 +755,10 @@ static void init_constants_master(struct ubifs_info *c)
 	 * necessary to report something for the 'statfs()' call.
 	 *
 	 * Subtract the LEB reserved for GC, the LEB which is reserved for
-	 * deletions, minimum LEBs for the index, and assume only one journal
-	 * head is available.
+	 * deletions, minimum LEBs for the index, the LEBs which are reserved
+	 * for each journal head.
 	 */
-	tmp64 = c->main_lebs - 1 - 1 - MIN_INDEX_LEBS - c->jhead_cnt + 1;
+	tmp64 = c->main_lebs - 1 - 1 - MIN_INDEX_LEBS - c->jhead_cnt;
 	tmp64 *= (long long)c->leb_size - c->leb_overhead;
 	tmp64 = ubifs_reported_space(c, tmp64);
 	c->block_cnt = tmp64 >> UBIFS_BLOCK_SHIFT;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d76682d2f9dc..bff57cb20e53 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1513,7 +1513,7 @@ static inline unsigned int queue_io_min(struct request_queue *q)
 	return q->limits.io_min;
 }
 
-static inline int bdev_io_min(struct block_device *bdev)
+static inline unsigned int bdev_io_min(struct block_device *bdev)
 {
 	return queue_io_min(bdev_get_queue(bdev));
 }
diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index fa928242567d..add50d10f410 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -349,7 +349,7 @@ static inline unsigned long _msecs_to_jiffies(const unsigned int m)
  * - all other values are converted to jiffies by either multiplying
  *   the input value by a factor or dividing it with a factor and
  *   handling any 32-bit overflows.
- *   for the details see __msecs_to_jiffies()
+ *   for the details see _msecs_to_jiffies()
  *
  * msecs_to_jiffies() checks for the passed in value being a constant
  * via __builtin_constant_p() allowing gcc to eliminate most of the
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 3ef82d3a78db..c47f74e6bd2c 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -80,7 +80,7 @@ static inline void *netpoll_poll_lock(struct napi_struct *napi)
 {
 	struct net_device *dev = napi->dev;
 
-	if (dev && dev->npinfo) {
+	if (dev && rcu_access_pointer(dev->npinfo)) {
 		int owner = smp_processor_id();
 
 		while (cmpxchg(&napi->poll_owner, -1, owner) != -1)
diff --git a/init/initramfs.c b/init/initramfs.c
index fceede4cff6e..59901e519777 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -323,6 +323,15 @@ static int __init do_name(void)
 {
 	state = SkipIt;
 	next_state = Reset;
+
+	/* name_len > 0 && name_len <= PATH_MAX checked in do_header */
+	if (collected[name_len - 1] != '\0') {
+		pr_err("initramfs name without nulterm: %.*s\n",
+		       (int)name_len, collected);
+		error("malformed archive");
+		return 1;
+	}
+
 	if (strcmp(collected, "TRAILER!!!") == 0) {
 		free_hash();
 		return 0;
@@ -385,6 +394,12 @@ static int __init do_copy(void)
 
 static int __init do_symlink(void)
 {
+	if (collected[name_len - 1] != '\0') {
+		pr_err("initramfs symlink without nulterm: %.*s\n",
+		       (int)name_len, collected);
+		error("malformed archive");
+		return 1;
+	}
 	collected[N_ALIGN(name_len) + body_len] = '\0';
 	clean_path(collected, 0);
 	ksys_symlink(collected + N_ALIGN(name_len), collected);
diff --git a/kernel/time/time.c b/kernel/time/time.c
index f7d4fa5ddb9e..4087cf51142c 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -576,7 +576,7 @@ EXPORT_SYMBOL(ns_to_timespec64);
  * - all other values are converted to jiffies by either multiplying
  *   the input value by a factor or dividing it with a factor and
  *   handling any 32-bit overflows.
- *   for the details see __msecs_to_jiffies()
+ *   for the details see _msecs_to_jiffies()
  *
  * msecs_to_jiffies() checks for the passed in value being a constant
  * via __builtin_constant_p() allowing gcc to eliminate most of the
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 5e68447588b7..22cce5dc0e28 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -349,10 +349,16 @@ void perf_uprobe_destroy(struct perf_event *p_event)
 int perf_trace_add(struct perf_event *p_event, int flags)
 {
 	struct trace_event_call *tp_event = p_event->tp_event;
+	struct hw_perf_event *hwc = &p_event->hw;
 
 	if (!(flags & PERF_EF_START))
 		p_event->hw.state = PERF_HES_STOPPED;
 
+	if (is_sampling_event(p_event)) {
+		hwc->last_period = hwc->sample_period;
+		perf_swevent_set_period(p_event);
+	}
+
 	/*
 	 * If TRACE_REG_PERF_ADD returns false; no custom action was performed
 	 * and we need to take the default action of enqueueing our event on
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 29c490e5d478..a6807fc90c04 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -50,7 +50,7 @@ void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 	static const unsigned int rounding[] = { 500, 50, 5 };
 	int i = 0, j;
 	u32 remainder = 0, sf_cap;
-	char tmp[8];
+	char tmp[12];
 	const char *unit;
 
 	tmp[0] = '\0';
diff --git a/mm/shmem.c b/mm/shmem.c
index 6e9027cb72ef..0788616696dc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1014,9 +1014,7 @@ static int shmem_getattr(const struct path *path, struct kstat *stat,
 		shmem_recalc_inode(inode);
 		spin_unlock_irq(&info->lock);
 	}
-	inode_lock_shared(inode);
 	generic_fillattr(inode, stat);
-	inode_unlock_shared(inode);
 
 	if (is_huge_enabled(sb_info))
 		stat->blksize = HPAGE_PMD_SIZE;
diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index c87146a49636..33d8814daa88 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -306,7 +306,7 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 		if (!priv->rings[i].intf)
 			break;
 		if (priv->rings[i].irq > 0)
-			unbind_from_irqhandler(priv->rings[i].irq, priv->dev);
+			unbind_from_irqhandler(priv->rings[i].irq, ring);
 		if (priv->rings[i].data.in) {
 			for (j = 0; j < (1 << XEN_9PFS_RING_ORDER); j++) {
 				grant_ref_t ref;
@@ -480,6 +480,7 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 		goto error;
 	}
 
+	xenbus_switch_state(dev, XenbusStateInitialised);
 	return 0;
 
  error_xenbus:
@@ -527,8 +528,10 @@ static void xen_9pfs_front_changed(struct xenbus_device *dev,
 		break;
 
 	case XenbusStateInitWait:
-		if (!xen_9pfs_front_init(dev))
-			xenbus_switch_state(dev, XenbusStateInitialised);
+		if (dev->state != XenbusStateInitialising)
+			break;
+
+		xen_9pfs_front_init(dev);
 		break;
 
 	case XenbusStateConnected:
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 8f53cc0d9682..da8ea1480a7d 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -736,7 +736,8 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 	struct sock *l2cap_sk;
 	struct l2cap_conn *conn;
 	struct rfcomm_conninfo cinfo;
-	int len, err = 0;
+	int err = 0;
+	size_t len;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -790,7 +791,7 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 		cinfo.hci_handle = conn->hcon->handle;
 		memcpy(cinfo.dev_class, conn->hcon->dev_class, 3);
 
-		len = min_t(unsigned int, len, sizeof(cinfo));
+		len = min(len, sizeof(cinfo));
 		if (copy_to_user(optval, (char *) &cinfo, len))
 			err = -EFAULT;
 
@@ -809,7 +810,8 @@ static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname, c
 {
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
-	int len, err = 0;
+	int err = 0;
+	size_t len;
 
 	BT_DBG("sk %p", sk);
 
@@ -834,7 +836,7 @@ static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname, c
 		sec.level = rfcomm_pi(sk)->sec_level;
 		sec.key_size = 0;
 
-		len = min_t(unsigned int, len, sizeof(sec));
+		len = min(len, sizeof(sec));
 		if (copy_to_user(optval, (char *) &sec, len))
 			err = -EFAULT;
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index e8c4e9c0c5a0..71d10bdee430 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -140,6 +140,8 @@ static u32 ieee80211_hw_conf_chan(struct ieee80211_local *local)
 	}
 
 	power = ieee80211_chandef_max_power(&chandef);
+	if (local->user_power_level != IEEE80211_UNSET_POWER_LEVEL)
+		power = min(local->user_power_level, power);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
diff --git a/net/netfilter/ipset/ip_set_bitmap_ip.c b/net/netfilter/ipset/ip_set_bitmap_ip.c
index 1b9df64c6236..b3ca8e87f629 100644
--- a/net/netfilter/ipset/ip_set_bitmap_ip.c
+++ b/net/netfilter/ipset/ip_set_bitmap_ip.c
@@ -166,11 +166,8 @@ bitmap_ip_uadt(struct ip_set *set, struct nlattr *tb[],
 		ret = ip_set_get_hostipaddr4(tb[IPSET_ATTR_IP_TO], &ip_to);
 		if (ret)
 			return ret;
-		if (ip > ip_to) {
+		if (ip > ip_to)
 			swap(ip, ip_to);
-			if (ip < map->first_ip)
-				return -IPSET_ERR_BITMAP_RANGE;
-		}
 	} else if (tb[IPSET_ATTR_CIDR]) {
 		u8 cidr = nla_get_u8(tb[IPSET_ATTR_CIDR]);
 
@@ -181,7 +178,7 @@ bitmap_ip_uadt(struct ip_set *set, struct nlattr *tb[],
 		ip_to = ip;
 	}
 
-	if (ip_to > map->last_ip)
+	if (ip < map->first_ip || ip_to > map->last_ip)
 		return -IPSET_ERR_BITMAP_RANGE;
 
 	for (; !before(ip_to, ip); ip += map->hosts) {
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2e26ecb46707..8c397697e47f 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -393,15 +393,6 @@ static void netlink_skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
 
 static void netlink_sock_destruct(struct sock *sk)
 {
-	struct netlink_sock *nlk = nlk_sk(sk);
-
-	if (nlk->cb_running) {
-		if (nlk->cb.done)
-			nlk->cb.done(&nlk->cb);
-		module_put(nlk->cb.module);
-		kfree_skb(nlk->cb.skb);
-	}
-
 	skb_queue_purge(&sk->sk_receive_queue);
 
 	if (!sock_flag(sk, SOCK_DEAD)) {
@@ -414,14 +405,6 @@ static void netlink_sock_destruct(struct sock *sk)
 	WARN_ON(nlk_sk(sk)->groups);
 }
 
-static void netlink_sock_destruct_work(struct work_struct *work)
-{
-	struct netlink_sock *nlk = container_of(work, struct netlink_sock,
-						work);
-
-	sk_free(&nlk->sk);
-}
-
 /* This lock without WQ_FLAG_EXCLUSIVE is good on UP and it is _very_ bad on
  * SMP. Look, when several writers sleep and reader wakes them up, all but one
  * immediately hit write lock and grab all the cpus. Exclusive sleep solves
@@ -738,12 +721,6 @@ static void deferred_put_nlk_sk(struct rcu_head *head)
 	if (!refcount_dec_and_test(&sk->sk_refcnt))
 		return;
 
-	if (nlk->cb_running && nlk->cb.done) {
-		INIT_WORK(&nlk->work, netlink_sock_destruct_work);
-		schedule_work(&nlk->work);
-		return;
-	}
-
 	sk_free(sk);
 }
 
@@ -793,6 +770,14 @@ static int netlink_release(struct socket *sock)
 				NETLINK_URELEASE, &n);
 	}
 
+	/* Terminate any outstanding dump */
+	if (nlk->cb_running) {
+		if (nlk->cb.done)
+			nlk->cb.done(&nlk->cb);
+		module_put(nlk->cb.module);
+		kfree_skb(nlk->cb.skb);
+	}
+
 	module_put(nlk->module);
 
 	if (netlink_is_kernel(sk)) {
diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
index 962de7b3c023..c61e634693ea 100644
--- a/net/netlink/af_netlink.h
+++ b/net/netlink/af_netlink.h
@@ -4,7 +4,6 @@
 
 #include <linux/rhashtable.h>
 #include <linux/atomic.h>
-#include <linux/workqueue.h>
 #include <net/sock.h>
 
 /* flags */
@@ -45,7 +44,6 @@ struct netlink_sock {
 
 	struct rhash_head	node;
 	struct rcu_head		rcu;
-	struct work_struct	work;
 };
 
 static inline struct netlink_sock *nlk_sk(struct sock *sk)
diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 7524544a965f..c1df7054c2f0 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -44,8 +44,12 @@ static int rfkill_gpio_set_power(void *data, bool blocked)
 {
 	struct rfkill_gpio_data *rfkill = data;
 
-	if (!blocked && !IS_ERR(rfkill->clk) && !rfkill->clk_enabled)
-		clk_enable(rfkill->clk);
+	if (!blocked && !IS_ERR(rfkill->clk) && !rfkill->clk_enabled) {
+		int ret = clk_enable(rfkill->clk);
+
+		if (ret)
+			return ret;
+	}
 
 	gpiod_set_value_cansleep(rfkill->shutdown_gpio, !blocked);
 	gpiod_set_value_cansleep(rfkill->reset_gpio, !blocked);
diff --git a/samples/bpf/xdp_adjust_tail_kern.c b/samples/bpf/xdp_adjust_tail_kern.c
index 411fdb21f8bc..9783754bdd8b 100644
--- a/samples/bpf/xdp_adjust_tail_kern.c
+++ b/samples/bpf/xdp_adjust_tail_kern.c
@@ -54,6 +54,7 @@ static __always_inline void swap_mac(void *data, struct ethhdr *orig_eth)
 
 static __always_inline __u16 csum_fold_helper(__u32 csum)
 {
+	csum = (csum & 0xffff) + (csum >> 16);
 	return ~((csum & 0xffff) + (csum >> 16));
 }
 
diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index 662fe19da990..30ac50f3f2ba 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -44,7 +44,7 @@ else
 	LINUX_COMPILE_BY=$KBUILD_BUILD_USER
 fi
 if test -z "$KBUILD_BUILD_HOST"; then
-	LINUX_COMPILE_HOST=`hostname`
+	LINUX_COMPILE_HOST=`uname -n`
 else
 	LINUX_COMPILE_HOST=$KBUILD_BUILD_HOST
 fi
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 90868df7865e..adcaabf40894 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -763,10 +763,7 @@ static int do_eisa_entry(const char *filename, void *symval,
 		char *alias)
 {
 	DEF_FIELD_ADDR(symval, eisa_device_id, sig);
-	if (sig[0])
-		sprintf(alias, EISA_DEVICE_MODALIAS_FMT "*", *sig);
-	else
-		strcat(alias, "*");
+	sprintf(alias, EISA_DEVICE_MODALIAS_FMT "*", *sig);
 	return 1;
 }
 
diff --git a/security/apparmor/capability.c b/security/apparmor/capability.c
index 752f73980e30..8c99e8150bab 100644
--- a/security/apparmor/capability.c
+++ b/security/apparmor/capability.c
@@ -98,6 +98,8 @@ static int audit_caps(struct common_audit_data *sa, struct aa_profile *profile,
 		return error;
 	} else {
 		aa_put_profile(ent->profile);
+		if (profile != ent->profile)
+			cap_clear(ent->caps);
 		ent->profile = aa_get_profile(profile);
 		cap_raise(ent->caps, cap);
 	}
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index e46e9f4bc994..9a93f77ceb0f 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1164,17 +1164,20 @@ static int da7219_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
-	if ((da7219->clk_src == clk_id) && (da7219->mclk_rate == freq))
+	mutex_lock(&da7219->pll_lock);
+
+	if ((da7219->clk_src == clk_id) && (da7219->mclk_rate == freq)) {
+		mutex_unlock(&da7219->pll_lock);
 		return 0;
+	}
 
 	if ((freq < 2000000) || (freq > 54000000)) {
+		mutex_unlock(&da7219->pll_lock);
 		dev_err(codec_dai->dev, "Unsupported MCLK value %d\n",
 			freq);
 		return -EINVAL;
 	}
 
-	mutex_lock(&da7219->pll_lock);
-
 	switch (clk_id) {
 	case DA7219_CLKSRC_MCLK_SQR:
 		snd_soc_component_update_bits(component, DA7219_PLL_CTRL,
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 16e2ab290375..2ed63866e9cc 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -879,6 +879,21 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{	/* Vexia Edu Atla 10 tablet */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
+			/* Above strings are too generic, also match on BIOS date */
+			DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
+		},
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF2 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* Voyo Winpad A15 */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
diff --git a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
index 17d5e3ee6d73..f5a9b7a0b585 100644
--- a/sound/usb/6fire/chip.c
+++ b/sound/usb/6fire/chip.c
@@ -66,8 +66,10 @@ static void usb6fire_chip_abort(struct sfire_chip *chip)
 	}
 }
 
-static void usb6fire_chip_destroy(struct sfire_chip *chip)
+static void usb6fire_card_free(struct snd_card *card)
 {
+	struct sfire_chip *chip = card->private_data;
+
 	if (chip) {
 		if (chip->pcm)
 			usb6fire_pcm_destroy(chip);
@@ -77,8 +79,6 @@ static void usb6fire_chip_destroy(struct sfire_chip *chip)
 			usb6fire_comm_destroy(chip);
 		if (chip->control)
 			usb6fire_control_destroy(chip);
-		if (chip->card)
-			snd_card_free(chip->card);
 	}
 }
 
@@ -141,6 +141,7 @@ static int usb6fire_chip_probe(struct usb_interface *intf,
 	chip->regidx = regidx;
 	chip->intf_count = 1;
 	chip->card = card;
+	card->private_free = usb6fire_card_free;
 
 	ret = usb6fire_comm_init(chip);
 	if (ret < 0)
@@ -167,7 +168,7 @@ static int usb6fire_chip_probe(struct usb_interface *intf,
 	return 0;
 
 destroy_chip:
-	usb6fire_chip_destroy(chip);
+	snd_card_free(card);
 	return ret;
 }
 
@@ -186,7 +187,6 @@ static void usb6fire_chip_disconnect(struct usb_interface *intf)
 
 			chip->shutdown = true;
 			usb6fire_chip_abort(chip);
-			usb6fire_chip_destroy(chip);
 		}
 	}
 }
diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index c6108a3d7f8f..9c6a2295d45a 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -890,14 +890,20 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *cdev)
 	return 0;
 }
 
-void snd_usb_caiaq_audio_free(struct snd_usb_caiaqdev *cdev)
+void snd_usb_caiaq_audio_disconnect(struct snd_usb_caiaqdev *cdev)
 {
 	struct device *dev = caiaqdev_to_dev(cdev);
 
 	dev_dbg(dev, "%s(%p)\n", __func__, cdev);
 	stream_stop(cdev);
+}
+
+void snd_usb_caiaq_audio_free(struct snd_usb_caiaqdev *cdev)
+{
+	struct device *dev = caiaqdev_to_dev(cdev);
+
+	dev_dbg(dev, "%s(%p)\n", __func__, cdev);
 	free_urbs(cdev->data_urbs_in);
 	free_urbs(cdev->data_urbs_out);
 	kfree(cdev->data_cb_info);
 }
-
diff --git a/sound/usb/caiaq/audio.h b/sound/usb/caiaq/audio.h
index 869bf6264d6a..07f5d064456c 100644
--- a/sound/usb/caiaq/audio.h
+++ b/sound/usb/caiaq/audio.h
@@ -3,6 +3,7 @@
 #define CAIAQ_AUDIO_H
 
 int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *cdev);
+void snd_usb_caiaq_audio_disconnect(struct snd_usb_caiaqdev *cdev);
 void snd_usb_caiaq_audio_free(struct snd_usb_caiaqdev *cdev);
 
 #endif /* CAIAQ_AUDIO_H */
diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index d55ca48de3ea..4df7f37aa670 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -402,6 +402,17 @@ static void setup_card(struct snd_usb_caiaqdev *cdev)
 		dev_err(dev, "Unable to set up control system (ret=%d)\n", ret);
 }
 
+static void card_free(struct snd_card *card)
+{
+	struct snd_usb_caiaqdev *cdev = caiaqdev(card);
+
+#ifdef CONFIG_SND_USB_CAIAQ_INPUT
+	snd_usb_caiaq_input_free(cdev);
+#endif
+	snd_usb_caiaq_audio_free(cdev);
+	usb_reset_device(cdev->chip.dev);
+}
+
 static int create_card(struct usb_device *usb_dev,
 		       struct usb_interface *intf,
 		       struct snd_card **cardp)
@@ -515,6 +526,7 @@ static int init_card(struct snd_usb_caiaqdev *cdev)
 		       cdev->vendor_name, cdev->product_name, usbpath);
 
 	setup_card(cdev);
+	card->private_free = card_free;
 	return 0;
 
  err_kill_urb:
@@ -560,15 +572,14 @@ static void snd_disconnect(struct usb_interface *intf)
 	snd_card_disconnect(card);
 
 #ifdef CONFIG_SND_USB_CAIAQ_INPUT
-	snd_usb_caiaq_input_free(cdev);
+	snd_usb_caiaq_input_disconnect(cdev);
 #endif
-	snd_usb_caiaq_audio_free(cdev);
+	snd_usb_caiaq_audio_disconnect(cdev);
 
 	usb_kill_urb(&cdev->ep1_in_urb);
 	usb_kill_urb(&cdev->midi_out_urb);
 
-	snd_card_free(card);
-	usb_reset_device(interface_to_usbdev(intf));
+	snd_card_free_when_closed(card);
 }
 
 
diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index 19951e1dbbb0..a01a242f5c99 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -842,15 +842,21 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *cdev)
 	return ret;
 }
 
-void snd_usb_caiaq_input_free(struct snd_usb_caiaqdev *cdev)
+void snd_usb_caiaq_input_disconnect(struct snd_usb_caiaqdev *cdev)
 {
 	if (!cdev || !cdev->input_dev)
 		return;
 
 	usb_kill_urb(cdev->ep4_in_urb);
+	input_unregister_device(cdev->input_dev);
+}
+
+void snd_usb_caiaq_input_free(struct snd_usb_caiaqdev *cdev)
+{
+	if (!cdev || !cdev->input_dev)
+		return;
+
 	usb_free_urb(cdev->ep4_in_urb);
 	cdev->ep4_in_urb = NULL;
-
-	input_unregister_device(cdev->input_dev);
 	cdev->input_dev = NULL;
 }
diff --git a/sound/usb/caiaq/input.h b/sound/usb/caiaq/input.h
index c42891e7be88..fbe267f85d02 100644
--- a/sound/usb/caiaq/input.h
+++ b/sound/usb/caiaq/input.h
@@ -4,6 +4,7 @@
 
 void snd_usb_caiaq_input_dispatch(struct snd_usb_caiaqdev *cdev, char *buf, unsigned int len);
 int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *cdev);
+void snd_usb_caiaq_input_disconnect(struct snd_usb_caiaqdev *cdev);
 void snd_usb_caiaq_input_free(struct snd_usb_caiaqdev *cdev);
 
 #endif
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 087eef5e249d..54055d12476b 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -596,6 +596,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_interface *intf)
 {
 	struct usb_host_config *config = dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
 
 	if (le16_to_cpu(get_cfg_desc(config)->wTotalLength) == EXTIGY_FIRMWARE_SIZE_OLD ||
@@ -607,10 +608,14 @@ static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_interfac
 		if (err < 0)
 			dev_dbg(&dev->dev, "error sending boot message: %d\n", err);
 		err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
-				&dev->descriptor, sizeof(dev->descriptor));
-		config = dev->actconfig;
+				&new_device_descriptor, sizeof(new_device_descriptor));
 		if (err < 0)
 			dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
+		if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
+			dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
+				new_device_descriptor.bNumConfigurations);
+		else
+			memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
 		err = usb_reset_configuration(dev);
 		if (err < 0)
 			dev_dbg(&dev->dev, "error usb_reset_configuration: %d\n", err);
@@ -826,6 +831,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *dev)
 static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 {
 	struct usb_host_config *config = dev->actconfig;
+	struct usb_device_descriptor new_device_descriptor;
 	int err;
 	u8 bootresponse[0x12];
 	int fwsize;
@@ -861,10 +867,14 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
 	dev_dbg(&dev->dev, "device initialised!\n");
 
 	err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
-		&dev->descriptor, sizeof(dev->descriptor));
-	config = dev->actconfig;
+		&new_device_descriptor, sizeof(new_device_descriptor));
 	if (err < 0)
 		dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
+	if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
+		dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
+			new_device_descriptor.bNumConfigurations);
+	else
+		memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
 
 	err = usb_reset_configuration(dev);
 	if (err < 0)
diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index 8082f7b077f1..eac2e4d0e7d9 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -649,10 +649,7 @@ static void snd_us122l_disconnect(struct usb_interface *intf)
 	usb_put_intf(usb_ifnum_to_if(us122l->dev, 1));
 	usb_put_dev(us122l->dev);
 
-	while (atomic_read(&us122l->mmap_count))
-		msleep(500);
-
-	snd_card_free(card);
+	snd_card_free_when_closed(card);
 }
 
 static int snd_us122l_suspend(struct usb_interface *intf, pm_message_t message)
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 4da4ec255246..38b8a657196d 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1593,8 +1593,21 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, unsigned long addr,
 
 	/* Find a corresponding function (name, baseline and baseaddr) */
 	if (die_find_realfunc(&cudie, (Dwarf_Addr)addr, &spdie)) {
-		/* Get function entry information */
-		func = basefunc = dwarf_diename(&spdie);
+		/*
+		 * Get function entry information.
+		 *
+		 * As described in the document DWARF Debugging Information
+		 * Format Version 5, section 2.22 Linkage Names, "mangled names,
+		 * are used in various ways, ... to distinguish multiple
+		 * entities that have the same name".
+		 *
+		 * Firstly try to get distinct linkage name, if fail then
+		 * rollback to get associated name in DIE.
+		 */
+		func = basefunc = die_get_linkage_name(&spdie);
+		if (!func)
+			func = basefunc = dwarf_diename(&spdie);
+
 		if (!func ||
 		    die_entrypc(&spdie, &baseaddr) != 0 ||
 		    dwarf_decl_line(&spdie, &baseline) != 0) {
diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 540f9a284e9f..9ef3ad3789c1 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -238,8 +238,7 @@ void *vdso_sym(const char *version, const char *name)
 		ELF(Sym) *sym = &vdso_info.symtab[chain];
 
 		/* Check for a defined global or weak function w/ right name. */
-		if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC &&
-		    ELF64_ST_TYPE(sym->st_info) != STT_NOTYPE)
+		if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC)
 			continue;
 		if (ELF64_ST_BIND(sym->st_info) != STB_GLOBAL &&
 		    ELF64_ST_BIND(sym->st_info) != STB_WEAK)
diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index f1c6e025cbe5..561bcc253fb3 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -152,7 +152,13 @@ int main(int argc, char *argv[])
 
 	printf("Watchdog Ticking Away!\n");
 
+	/*
+	 * Register the signals
+	 */
 	signal(SIGINT, term);
+	signal(SIGTERM, term);
+	signal(SIGKILL, term);
+	signal(SIGQUIT, term);
 
 	while (1) {
 		keep_alive();

