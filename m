Return-Path: <stable+bounces-191627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1DEC1B0E9
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 15:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 644C1507869
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86AC3559CF;
	Wed, 29 Oct 2025 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hrmGkcyi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D7C2E1C7A;
	Wed, 29 Oct 2025 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745372; cv=none; b=knZ810d7uUtvMqzVSNCwTCuq4KI+G+xy8cMvZ07L1eUwY/AXXu4W2nfEdvMuhh2WBvu08JTNmXBt4mvr8kEzE5jK0I9j/HLauY+HsAOVyvc9V9Q+5gHwI/T7XilGSUn9PNbykaWkDxeMKQVDQYmiYJmyHXeLAdHr82T11zQqi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745372; c=relaxed/simple;
	bh=fAxcy3V65WaQNbTuBI9OZmk5202G3BuaWuYt1wgjEbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oR7SVEZoLIe2Qi4nhFaQ17PFt3WwXPIeGZ+riBBpor43snyjud4uhEudbgNy7cfH7zTOiRTJZpGXmYZA9MwIq6j+5NKWhIVEC5rwhr8QHEhSIeZnDm0/QYMdo3cD3lshkoTO22GegEBGZaiQ5VAPSk1IRv1BbiZtfZJO0ix6fO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hrmGkcyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EECC4CEF7;
	Wed, 29 Oct 2025 13:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761745370;
	bh=fAxcy3V65WaQNbTuBI9OZmk5202G3BuaWuYt1wgjEbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hrmGkcyiujKEq8+HeyAF2h6NpjXL1FTGSQ2wNDZosa2FQeetNBihdNzPxmTcKqSeL
	 DEcZMRmF6aiXKa8olGyT/d/uhGn8x8IqhAm84xh9BLnoLIgdTPiXHH+3ZGo6Iz+S1T
	 nCJj4elGNi/pqEe/KKzsFUmxyn2snZfSg5/3DBpk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.17.6
Date: Wed, 29 Oct 2025 14:42:02 +0100
Message-ID: <2025102901-dinginess-chooser-5ed7@gregkh>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <2025102901-nuzzle-gizmo-9f40@gregkh>
References: <2025102901-nuzzle-gizmo-9f40@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index e925cd4c3ac8..72483bc3274d 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -197,6 +197,7 @@ allOf:
               - renesas,rcar-gen2-scif
               - renesas,rcar-gen3-scif
               - renesas,rcar-gen4-scif
+              - renesas,rcar-gen5-scif
     then:
       properties:
         interrupts:
diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
index baf130669c38..73e7a60a0060 100644
--- a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
@@ -89,13 +89,21 @@ required:
   - reg
   - "#address-cells"
   - "#size-cells"
-  - dma-ranges
   - ranges
   - clocks
   - clock-names
   - interrupts
   - power-domains
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: fsl,imx8mp-dwc3
+    then:
+      required:
+        - dma-ranges
+
 additionalProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index dfd084ed9024..d49a58d5478f 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -68,6 +68,7 @@ properties:
           - qcom,sm8550-dwc3
           - qcom,sm8650-dwc3
           - qcom,x1e80100-dwc3
+          - qcom,x1e80100-dwc3-mp
       - const: qcom,snps-dwc3
 
   reg:
@@ -460,8 +461,10 @@ allOf:
     then:
       properties:
         interrupts:
+          minItems: 4
           maxItems: 5
         interrupt-names:
+          minItems: 4
           items:
             - const: dwc_usb3
             - const: pwr_event
diff --git a/Makefile b/Makefile
index 072a3be62551..d090c7c253e8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 17
-SUBLEVEL = 5
+SUBLEVEL = 6
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
@@ -1444,11 +1444,11 @@ endif
 
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
+	$(Q)$(MAKE) O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/
 
 tools/%: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
+	$(Q)$(MAKE) O=$(abspath $(objtree)) subdir=tools -C $(srctree)/tools/ $*
 
 # ---------------------------------------------------------------------------
 # Kernel selftest
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 0a9212d3106f..18e73580828a 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -270,6 +270,9 @@ gicv2: interrupt-controller@7fff9000 {
 			      <0x7fffc000 0x2000>,
 			      <0x7fffe000 0x2000>;
 			interrupt-controller;
+			#address-cells = <0>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+					IRQ_TYPE_LEVEL_HIGH)>;
 			#interrupt-cells = <3>;
 		};
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index abd2dee416b3..e6fdb5296330 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -293,7 +293,8 @@ static inline pmd_t set_pmd_bit(pmd_t pmd, pgprot_t prot)
 static inline pte_t pte_mkwrite_novma(pte_t pte)
 {
 	pte = set_pte_bit(pte, __pgprot(PTE_WRITE));
-	pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
+	if (pte_sw_dirty(pte))
+		pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
 	return pte;
 }
 
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index a86c897017df..cd5912ba617b 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -35,7 +35,7 @@ void copy_highpage(struct page *to, struct page *from)
 		    from != folio_page(src, 0))
 			return;
 
-		WARN_ON_ONCE(!folio_try_hugetlb_mte_tagging(dst));
+		folio_try_hugetlb_mte_tagging(dst);
 
 		/*
 		 * Populate tags for all subpages.
@@ -51,8 +51,13 @@ void copy_highpage(struct page *to, struct page *from)
 		}
 		folio_set_hugetlb_mte_tagged(dst);
 	} else if (page_mte_tagged(from)) {
-		/* It's a new page, shouldn't have been tagged yet */
-		WARN_ON_ONCE(!try_page_mte_tagging(to));
+		/*
+		 * Most of the time it's a new page that shouldn't have been
+		 * tagged yet. However, folio migration can end up reusing the
+		 * same page without untagging it. Ignore the warning if the
+		 * page is already tagged.
+		 */
+		try_page_mte_tagging(to);
 
 		mte_copy_page_tags(kto, kfrom);
 		set_page_mte_tagged(to);
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 696ab1f32a67..2a37d4c26d87 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1693,7 +1693,7 @@ UnsignedEnum	43:40	TraceFilt
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-UnsignedEnum	39:36	DoubleLock
+SignedEnum	39:36	DoubleLock
 	0b0000	IMP
 	0b1111	NI
 EndEnum
@@ -2409,7 +2409,7 @@ UnsignedEnum	11:8	ASID2
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-SignedEnum	7:4	EIESB
+UnsignedEnum	7:4	EIESB
 	0b0000	NI
 	0b0001	ToEL3
 	0b0010	ToELx
diff --git a/arch/m68k/include/asm/bitops.h b/arch/m68k/include/asm/bitops.h
index 14c64a6f1217..50ec92651d5a 100644
--- a/arch/m68k/include/asm/bitops.h
+++ b/arch/m68k/include/asm/bitops.h
@@ -350,12 +350,12 @@ static inline bool xor_unlock_is_negative_byte(unsigned long mask,
 #include <asm-generic/bitops/ffz.h>
 #else
 
-static inline int find_first_zero_bit(const unsigned long *vaddr,
-				      unsigned size)
+static inline unsigned long find_first_zero_bit(const unsigned long *vaddr,
+						unsigned long size)
 {
 	const unsigned long *p = vaddr;
-	int res = 32;
-	unsigned int words;
+	unsigned long res = 32;
+	unsigned long words;
 	unsigned long num;
 
 	if (!size)
@@ -376,8 +376,9 @@ static inline int find_first_zero_bit(const unsigned long *vaddr,
 }
 #define find_first_zero_bit find_first_zero_bit
 
-static inline int find_next_zero_bit(const unsigned long *vaddr, int size,
-				     int offset)
+static inline unsigned long find_next_zero_bit(const unsigned long *vaddr,
+					       unsigned long size,
+					       unsigned long offset)
 {
 	const unsigned long *p = vaddr + (offset >> 5);
 	int bit = offset & 31UL, res;
@@ -406,11 +407,12 @@ static inline int find_next_zero_bit(const unsigned long *vaddr, int size,
 }
 #define find_next_zero_bit find_next_zero_bit
 
-static inline int find_first_bit(const unsigned long *vaddr, unsigned size)
+static inline unsigned long find_first_bit(const unsigned long *vaddr,
+					   unsigned long size)
 {
 	const unsigned long *p = vaddr;
-	int res = 32;
-	unsigned int words;
+	unsigned long res = 32;
+	unsigned long words;
 	unsigned long num;
 
 	if (!size)
@@ -431,8 +433,9 @@ static inline int find_first_bit(const unsigned long *vaddr, unsigned size)
 }
 #define find_first_bit find_first_bit
 
-static inline int find_next_bit(const unsigned long *vaddr, int size,
-				int offset)
+static inline unsigned long find_next_bit(const unsigned long *vaddr,
+					  unsigned long size,
+					  unsigned long offset)
 {
 	const unsigned long *p = vaddr + (offset >> 5);
 	int bit = offset & 31UL, res;
diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
index 3a2836e9d856..2a3fd8bbf6c2 100644
--- a/arch/mips/mti-malta/malta-setup.c
+++ b/arch/mips/mti-malta/malta-setup.c
@@ -47,7 +47,7 @@ static struct resource standard_io_resources[] = {
 		.name = "keyboard",
 		.start = 0x60,
 		.end = 0x6f,
-		.flags = IORESOURCE_IO | IORESOURCE_BUSY
+		.flags = IORESOURCE_IO
 	},
 	{
 		.name = "dma page reg",
diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index 2a40150142c3..f43f01c4ab93 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -142,6 +142,20 @@ static void __init find_limits(unsigned long *min, unsigned long *max_low,
 	*max_high = PFN_DOWN(memblock_end_of_DRAM());
 }
 
+static void __init adjust_lowmem_bounds(void)
+{
+	phys_addr_t block_start, block_end;
+	u64 i;
+	phys_addr_t memblock_limit = 0;
+
+	for_each_mem_range(i, &block_start, &block_end) {
+		if (block_end > memblock_limit)
+			memblock_limit = block_end;
+	}
+
+	memblock_set_current_limit(memblock_limit);
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	console_verbose();
@@ -157,6 +171,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Keep a copy of command line */
 	*cmdline_p = boot_command_line;
 
+	adjust_lowmem_bounds();
 	find_limits(&min_low_pfn, &max_low_pfn, &max_pfn);
 
 	memblock_reserve(__pa_symbol(_stext), _end - _stext);
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 93d77ad5a92f..d8f944a5a037 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -20,18 +20,6 @@ struct mm_struct;
 #include <asm/nohash/pgtable.h>
 #endif /* !CONFIG_PPC_BOOK3S */
 
-/*
- * Protection used for kernel text. We want the debuggers to be able to
- * set breakpoints anywhere, so don't write protect the kernel text
- * on platforms where such control is possible.
- */
-#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || defined(CONFIG_BDI_SWITCH) || \
-	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
-#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
-#else
-#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
-#endif
-
 /* Make modules code happy. We don't set RO yet */
 #define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
 
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index be9c4106e22f..c42ecdf94e48 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -204,7 +204,7 @@ int mmu_mark_initmem_nx(void)
 
 	for (i = 0; i < nb - 1 && base < top;) {
 		size = bat_block_size(base, top);
-		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
+		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
 		base += size;
 	}
 	if (base < top) {
@@ -215,7 +215,7 @@ int mmu_mark_initmem_nx(void)
 				pr_warn("Some RW data is getting mapped X. "
 					"Adjust CONFIG_DATA_SHIFT to avoid that.\n");
 		}
-		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
+		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_X);
 		base += size;
 	}
 	for (; i < nb; i++)
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 15276068f657..0c9ef705803e 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -104,7 +104,7 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 	p = memstart_addr + s;
 	for (; s < top; s += PAGE_SIZE) {
 		ktext = core_kernel_text(v);
-		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
+		map_kernel_page(v, p, ktext ? PAGE_KERNEL_X : PAGE_KERNEL);
 		v += PAGE_SIZE;
 		p += PAGE_SIZE;
 	}
diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 5e0a718d1be7..0823fa2da151 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -545,7 +545,7 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
 	/* balloon page list reference */
 	put_page(page);
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 
 static void cmm_balloon_compaction_init(void)
diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 7fe0a379474a..5fe10724d307 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -41,4 +41,11 @@ static inline bool riscv_hwprobe_pair_cmp(struct riscv_hwprobe *pair,
 	return pair->value == other_pair->value;
 }
 
+#ifdef CONFIG_MMU
+void riscv_hwprobe_register_async_probe(void);
+void riscv_hwprobe_complete_async_probe(void);
+#else
+static inline void riscv_hwprobe_register_async_probe(void) {}
+static inline void riscv_hwprobe_complete_async_probe(void) {}
+#endif
 #endif
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 815067742939..4355e8f3670b 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -653,6 +653,8 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 	return __pgprot(prot);
 }
 
+#define pgprot_dmacoherent pgprot_writecombine
+
 /*
  * Both Svade and Svadu control the hardware behavior when the PTE A/D bits need to be set. By
  * default the M-mode firmware enables the hardware updating scheme when only Svadu is present in
diff --git a/arch/riscv/include/asm/vdso/arch_data.h b/arch/riscv/include/asm/vdso/arch_data.h
index da57a3786f7a..88b37af55175 100644
--- a/arch/riscv/include/asm/vdso/arch_data.h
+++ b/arch/riscv/include/asm/vdso/arch_data.h
@@ -12,6 +12,12 @@ struct vdso_arch_data {
 
 	/* Boolean indicating all CPUs have the same static hwprobe values. */
 	__u8 homogeneous_cpus;
+
+	/*
+	 * A gate to check and see if the hwprobe data is actually ready, as
+	 * probing is deferred to avoid boot slowdowns.
+	 */
+	__u8 ready;
 };
 
 #endif /* __RISCV_ASM_VDSO_ARCH_DATA_H */
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index f6b13e9f5e6c..3dbc8cc557dd 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -62,10 +62,8 @@ int __init riscv_early_of_processor_hartid(struct device_node *node, unsigned lo
 		return -ENODEV;
 	}
 
-	if (!of_device_is_available(node)) {
-		pr_info("CPU with hartid=%lu is not available\n", *hart);
+	if (!of_device_is_available(node))
 		return -ENODEV;
-	}
 
 	if (of_property_read_string(node, "riscv,isa-base", &isa))
 		goto old_interface;
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 743d53415572..72ca768f4e91 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -474,10 +474,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
 	__RISCV_ISA_EXT_DATA(zalrsc, RISCV_ISA_EXT_ZALRSC),
 	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
-	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zfa, RISCV_ISA_EXT_ZFA, riscv_ext_f_depends),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zfbfmin, RISCV_ISA_EXT_ZFBFMIN, riscv_ext_f_depends),
-	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
-	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zfh, RISCV_ISA_EXT_ZFH, riscv_ext_f_depends),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zfhmin, RISCV_ISA_EXT_ZFHMIN, riscv_ext_f_depends),
 	__RISCV_ISA_EXT_DATA(zca, RISCV_ISA_EXT_ZCA),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zcb, RISCV_ISA_EXT_ZCB, riscv_ext_zca_depends),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zcd, RISCV_ISA_EXT_ZCD, riscv_ext_zcd_validate),
@@ -932,9 +932,9 @@ static int has_thead_homogeneous_vlenb(void)
 {
 	int cpu;
 	u32 prev_vlenb = 0;
-	u32 vlenb;
+	u32 vlenb = 0;
 
-	/* Ignore thead,vlenb property if xtheavector is not enabled in the kernel */
+	/* Ignore thead,vlenb property if xtheadvector is not enabled in the kernel */
 	if (!IS_ENABLED(CONFIG_RISCV_ISA_XTHEADVECTOR))
 		return 0;
 
diff --git a/arch/riscv/kernel/pi/cmdline_early.c b/arch/riscv/kernel/pi/cmdline_early.c
index fbcdc9e4e143..389d086a0718 100644
--- a/arch/riscv/kernel/pi/cmdline_early.c
+++ b/arch/riscv/kernel/pi/cmdline_early.c
@@ -41,9 +41,9 @@ static char *get_early_cmdline(uintptr_t dtb_pa)
 static u64 match_noXlvl(char *cmdline)
 {
 	if (strstr(cmdline, "no4lvl"))
-		return SATP_MODE_48;
+		return SATP_MODE_39;
 	else if (strstr(cmdline, "no5lvl"))
-		return SATP_MODE_57;
+		return SATP_MODE_48;
 
 	return 0;
 }
diff --git a/arch/riscv/kernel/pi/fdt_early.c b/arch/riscv/kernel/pi/fdt_early.c
index 9bdee2fafe47..a12ff8090f19 100644
--- a/arch/riscv/kernel/pi/fdt_early.c
+++ b/arch/riscv/kernel/pi/fdt_early.c
@@ -3,6 +3,7 @@
 #include <linux/init.h>
 #include <linux/libfdt.h>
 #include <linux/ctype.h>
+#include <asm/csr.h>
 
 #include "pi.h"
 
@@ -183,3 +184,42 @@ bool fdt_early_match_extension_isa(const void *fdt, const char *ext_name)
 
 	return ret;
 }
+
+/**
+ *  set_satp_mode_from_fdt - determine SATP mode based on the MMU type in fdt
+ *
+ * @dtb_pa: physical address of the device tree blob
+ *
+ *  Returns the SATP mode corresponding to the MMU type of the first enabled CPU,
+ *  0 otherwise
+ */
+u64 set_satp_mode_from_fdt(uintptr_t dtb_pa)
+{
+	const void *fdt = (const void *)dtb_pa;
+	const char *mmu_type;
+	int node, parent;
+
+	parent = fdt_path_offset(fdt, "/cpus");
+	if (parent < 0)
+		return 0;
+
+	fdt_for_each_subnode(node, fdt, parent) {
+		if (!fdt_node_name_eq(fdt, node, "cpu"))
+			continue;
+
+		if (!fdt_device_is_available(fdt, node))
+			continue;
+
+		mmu_type = fdt_getprop(fdt, node, "mmu-type", NULL);
+		if (!mmu_type)
+			break;
+
+		if (!strcmp(mmu_type, "riscv,sv39"))
+			return SATP_MODE_39;
+		else if (!strcmp(mmu_type, "riscv,sv48"))
+			return SATP_MODE_48;
+		break;
+	}
+
+	return 0;
+}
diff --git a/arch/riscv/kernel/pi/pi.h b/arch/riscv/kernel/pi/pi.h
index 21141d84fea6..3fee2cfddf7c 100644
--- a/arch/riscv/kernel/pi/pi.h
+++ b/arch/riscv/kernel/pi/pi.h
@@ -14,6 +14,7 @@ u64 get_kaslr_seed(uintptr_t dtb_pa);
 u64 get_kaslr_seed_zkr(const uintptr_t dtb_pa);
 bool set_nokaslr_from_cmdline(uintptr_t dtb_pa);
 u64 set_satp_mode_from_cmdline(uintptr_t dtb_pa);
+u64 set_satp_mode_from_fdt(uintptr_t dtb_pa);
 
 bool fdt_early_match_extension_isa(const void *fdt, const char *ext_name);
 
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 0b170e18a2be..8dcbebfdbe1e 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -5,6 +5,9 @@
  * more details.
  */
 #include <linux/syscalls.h>
+#include <linux/completion.h>
+#include <linux/atomic.h>
+#include <linux/once.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/hwprobe.h>
@@ -27,6 +30,11 @@ static void hwprobe_arch_id(struct riscv_hwprobe *pair,
 	bool first = true;
 	int cpu;
 
+	if (pair->key != RISCV_HWPROBE_KEY_MVENDORID &&
+	    pair->key != RISCV_HWPROBE_KEY_MIMPID &&
+	    pair->key != RISCV_HWPROBE_KEY_MARCHID)
+		goto out;
+
 	for_each_cpu(cpu, cpus) {
 		u64 cpu_id;
 
@@ -57,6 +65,7 @@ static void hwprobe_arch_id(struct riscv_hwprobe *pair,
 		}
 	}
 
+out:
 	pair->value = id;
 }
 
@@ -153,14 +162,12 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			EXT_KEY(ZVKT);
 		}
 
-		if (has_fpu()) {
-			EXT_KEY(ZCD);
-			EXT_KEY(ZCF);
-			EXT_KEY(ZFA);
-			EXT_KEY(ZFBFMIN);
-			EXT_KEY(ZFH);
-			EXT_KEY(ZFHMIN);
-		}
+		EXT_KEY(ZCD);
+		EXT_KEY(ZCF);
+		EXT_KEY(ZFA);
+		EXT_KEY(ZFBFMIN);
+		EXT_KEY(ZFH);
+		EXT_KEY(ZFHMIN);
 
 		if (IS_ENABLED(CONFIG_RISCV_ISA_SUPM))
 			EXT_KEY(SUPM);
@@ -452,28 +459,32 @@ static int hwprobe_get_cpus(struct riscv_hwprobe __user *pairs,
 	return 0;
 }
 
-static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
-			    size_t pair_count, size_t cpusetsize,
-			    unsigned long __user *cpus_user,
-			    unsigned int flags)
-{
-	if (flags & RISCV_HWPROBE_WHICH_CPUS)
-		return hwprobe_get_cpus(pairs, pair_count, cpusetsize,
-					cpus_user, flags);
+#ifdef CONFIG_MMU
 
-	return hwprobe_get_values(pairs, pair_count, cpusetsize,
-				  cpus_user, flags);
+static DECLARE_COMPLETION(boot_probes_done);
+static atomic_t pending_boot_probes = ATOMIC_INIT(1);
+
+void riscv_hwprobe_register_async_probe(void)
+{
+	atomic_inc(&pending_boot_probes);
 }
 
-#ifdef CONFIG_MMU
+void riscv_hwprobe_complete_async_probe(void)
+{
+	if (atomic_dec_and_test(&pending_boot_probes))
+		complete(&boot_probes_done);
+}
 
-static int __init init_hwprobe_vdso_data(void)
+static int complete_hwprobe_vdso_data(void)
 {
 	struct vdso_arch_data *avd = vdso_k_arch_data;
 	u64 id_bitsmash = 0;
 	struct riscv_hwprobe pair;
 	int key;
 
+	if (unlikely(!atomic_dec_and_test(&pending_boot_probes)))
+		wait_for_completion(&boot_probes_done);
+
 	/*
 	 * Initialize vDSO data with the answers for the "all CPUs" case, to
 	 * save a syscall in the common case.
@@ -501,13 +512,52 @@ static int __init init_hwprobe_vdso_data(void)
 	 * vDSO should defer to the kernel for exotic cpu masks.
 	 */
 	avd->homogeneous_cpus = id_bitsmash != 0 && id_bitsmash != -1;
+
+	/*
+	 * Make sure all the VDSO values are visible before we look at them.
+	 * This pairs with the implicit "no speculativly visible accesses"
+	 * barrier in the VDSO hwprobe code.
+	 */
+	smp_wmb();
+	avd->ready = true;
+	return 0;
+}
+
+static int __init init_hwprobe_vdso_data(void)
+{
+	struct vdso_arch_data *avd = vdso_k_arch_data;
+
+	/*
+	 * Prevent the vDSO cached values from being used, as they're not ready
+	 * yet.
+	 */
+	avd->ready = false;
 	return 0;
 }
 
 arch_initcall_sync(init_hwprobe_vdso_data);
 
+#else
+
+static int complete_hwprobe_vdso_data(void) { return 0; }
+
 #endif /* CONFIG_MMU */
 
+static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
+			    size_t pair_count, size_t cpusetsize,
+			    unsigned long __user *cpus_user,
+			    unsigned int flags)
+{
+	DO_ONCE_SLEEPABLE(complete_hwprobe_vdso_data);
+
+	if (flags & RISCV_HWPROBE_WHICH_CPUS)
+		return hwprobe_get_cpus(pairs, pair_count, cpusetsize,
+					cpus_user, flags);
+
+	return hwprobe_get_values(pairs, pair_count, cpusetsize,
+				cpus_user, flags);
+}
+
 SYSCALL_DEFINE5(riscv_hwprobe, struct riscv_hwprobe __user *, pairs,
 		size_t, pair_count, size_t, cpusetsize, unsigned long __user *,
 		cpus, unsigned int, flags)
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index ae2068425fbc..70b5e6927620 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -379,6 +379,7 @@ static void check_vector_unaligned_access(struct work_struct *work __always_unus
 static int __init vec_check_unaligned_access_speed_all_cpus(void *unused __always_unused)
 {
 	schedule_on_each_cpu(check_vector_unaligned_access);
+	riscv_hwprobe_complete_async_probe();
 
 	return 0;
 }
@@ -473,8 +474,12 @@ static int __init check_unaligned_access_all_cpus(void)
 			per_cpu(vector_misaligned_access, cpu) = unaligned_vector_speed_param;
 	} else if (!check_vector_unaligned_access_emulated_all_cpus() &&
 		   IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
-		kthread_run(vec_check_unaligned_access_speed_all_cpus,
-			    NULL, "vec_check_unaligned_access_speed_all_cpus");
+		riscv_hwprobe_register_async_probe();
+		if (IS_ERR(kthread_run(vec_check_unaligned_access_speed_all_cpus,
+				       NULL, "vec_check_unaligned_access_speed_all_cpus"))) {
+			pr_warn("Failed to create vec_unalign_check kthread\n");
+			riscv_hwprobe_complete_async_probe();
+		}
 	}
 
 	/*
diff --git a/arch/riscv/kernel/vdso/hwprobe.c b/arch/riscv/kernel/vdso/hwprobe.c
index 2ddeba6c68dd..8f45500d0a6e 100644
--- a/arch/riscv/kernel/vdso/hwprobe.c
+++ b/arch/riscv/kernel/vdso/hwprobe.c
@@ -27,7 +27,7 @@ static int riscv_vdso_get_values(struct riscv_hwprobe *pairs, size_t pair_count,
 	 * homogeneous, then this function can handle requests for arbitrary
 	 * masks.
 	 */
-	if ((flags != 0) || (!all_cpus && !avd->homogeneous_cpus))
+	if (flags != 0 || (!all_cpus && !avd->homogeneous_cpus) || unlikely(!avd->ready))
 		return riscv_hwprobe(pairs, pair_count, cpusetsize, cpus, flags);
 
 	/* This is something we can handle, fill out the pairs. */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 15683ae13fa5..85cb70b10c07 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -816,6 +816,7 @@ static __meminit pgprot_t pgprot_from_va(uintptr_t va)
 
 #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
 u64 __pi_set_satp_mode_from_cmdline(uintptr_t dtb_pa);
+u64 __pi_set_satp_mode_from_fdt(uintptr_t dtb_pa);
 
 static void __init disable_pgtable_l5(void)
 {
@@ -855,18 +856,22 @@ static void __init set_mmap_rnd_bits_max(void)
  * underlying hardware: establish 1:1 mapping in 4-level page table mode
  * then read SATP to see if the configuration was taken into account
  * meaning sv48 is supported.
+ * The maximum SATP mode is limited by both the command line and the "mmu-type"
+ * property in the device tree, since some platforms may hang if an unsupported
+ * SATP mode is attempted.
  */
 static __init void set_satp_mode(uintptr_t dtb_pa)
 {
 	u64 identity_satp, hw_satp;
 	uintptr_t set_satp_mode_pmd = ((unsigned long)set_satp_mode) & PMD_MASK;
-	u64 satp_mode_cmdline = __pi_set_satp_mode_from_cmdline(dtb_pa);
+	u64 satp_mode_limit = min_not_zero(__pi_set_satp_mode_from_cmdline(dtb_pa),
+					   __pi_set_satp_mode_from_fdt(dtb_pa));
 
 	kernel_map.page_offset = PAGE_OFFSET_L5;
 
-	if (satp_mode_cmdline == SATP_MODE_57) {
+	if (satp_mode_limit == SATP_MODE_48) {
 		disable_pgtable_l5();
-	} else if (satp_mode_cmdline == SATP_MODE_48) {
+	} else if (satp_mode_limit == SATP_MODE_39) {
 		disable_pgtable_l5();
 		disable_pgtable_l4();
 		return;
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index d2f6f1f6d2fc..ad3e0f7f7fc1 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -16,9 +16,13 @@
 
 unsigned long *crst_table_alloc(struct mm_struct *mm)
 {
-	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL, CRST_ALLOC_ORDER);
+	gfp_t gfp = GFP_KERNEL_ACCOUNT;
+	struct ptdesc *ptdesc;
 	unsigned long *table;
 
+	if (mm == &init_mm)
+		gfp &= ~__GFP_ACCOUNT;
+	ptdesc = pagetable_alloc(gfp, CRST_ALLOC_ORDER);
 	if (!ptdesc)
 		return NULL;
 	table = ptdesc_to_virt(ptdesc);
@@ -117,7 +121,7 @@ struct ptdesc *page_table_alloc_pgste(struct mm_struct *mm)
 	struct ptdesc *ptdesc;
 	u64 *table;
 
-	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
+	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, 0);
 	if (ptdesc) {
 		table = (u64 *)ptdesc_to_virt(ptdesc);
 		__arch_set_page_dat(table, 1);
@@ -136,10 +140,13 @@ void page_table_free_pgste(struct ptdesc *ptdesc)
 
 unsigned long *page_table_alloc(struct mm_struct *mm)
 {
+	gfp_t gfp = GFP_KERNEL_ACCOUNT;
 	struct ptdesc *ptdesc;
 	unsigned long *table;
 
-	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
+	if (mm == &init_mm)
+		gfp &= ~__GFP_ACCOUNT;
+	ptdesc = pagetable_alloc(gfp, 0);
 	if (!ptdesc)
 		return NULL;
 	if (!pagetable_pte_ctor(mm, ptdesc)) {
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 514f63340880..ad66eb83b96a 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -194,7 +194,7 @@ static bool need_sha_check(u32 cur_rev)
 	}
 
 	switch (cur_rev >> 8) {
-	case 0x80012: return cur_rev <= 0x800126f; break;
+	case 0x80012: return cur_rev <= 0x8001277; break;
 	case 0x80082: return cur_rev <= 0x800820f; break;
 	case 0x83010: return cur_rev <= 0x830107c; break;
 	case 0x86001: return cur_rev <= 0x860010e; break;
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8fa52914e16b..c3e131f4f908 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -184,6 +184,16 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 	if (!bi->interval_exp)
 		bi->interval_exp = ilog2(lim->logical_block_size);
 
+	/*
+	 * The PI generation / validation helpers do not expect intervals to
+	 * straddle multiple bio_vecs.  Enforce alignment so that those are
+	 * never generated, and that each buffer is aligned as expected.
+	 */
+	if (bi->csum_type) {
+		lim->dma_alignment = max(lim->dma_alignment,
+					(1U << bi->interval_exp) - 1);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index fd64460a2e26..eb76f6f8f490 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -95,6 +95,11 @@ acpi_tb_print_table_header(acpi_physical_address address,
 {
 	struct acpi_table_header local_header;
 
+#pragma GCC diagnostic push
+#if defined(__GNUC__) && __GNUC__ >= 11
+#pragma GCC diagnostic ignored "-Wstringop-overread"
+#endif
+
 	if (ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_FACS)) {
 
 		/* FACS only has signature and length fields */
@@ -135,4 +140,5 @@ acpi_tb_print_table_header(acpi_physical_address address,
 			   local_header.asl_compiler_id,
 			   local_header.asl_compiler_revision));
 	}
+#pragma GCC diagnostic pop
 }
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 312b462e349d..5702804b92e4 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -850,17 +850,8 @@ static int binder_inc_node_nilocked(struct binder_node *node, int strong,
 	} else {
 		if (!internal)
 			node->local_weak_refs++;
-		if (!node->has_weak_ref && list_empty(&node->work.entry)) {
-			if (target_list == NULL) {
-				pr_err("invalid inc weak node for %d\n",
-					node->debug_id);
-				return -EINVAL;
-			}
-			/*
-			 * See comment above
-			 */
+		if (!node->has_weak_ref && target_list && list_empty(&node->work.entry))
 			binder_enqueue_work_ilocked(&node->work, target_list);
-		}
 	}
 	return 0;
 }
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1037169abb45..e1eff05bea4a 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -292,7 +292,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 		 * frequency (by keeping the initial capacity_freq_ref value).
 		 */
 		cpu_clk = of_clk_get(cpu_node, 0);
-		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
+		if (!IS_ERR_OR_NULL(cpu_clk)) {
 			per_cpu(capacity_freq_ref, cpu) =
 				clk_get_rate(cpu_clk) / HZ_PER_KHZ;
 			clk_put(cpu_clk);
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 37faf6156d7c..55bdc7f5e59d 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -23,50 +23,46 @@ struct devcd_entry {
 	void *data;
 	size_t datalen;
 	/*
-	 * Here, mutex is required to serialize the calls to del_wk work between
-	 * user/kernel space which happens when devcd is added with device_add()
-	 * and that sends uevent to user space. User space reads the uevents,
-	 * and calls to devcd_data_write() which try to modify the work which is
-	 * not even initialized/queued from devcoredump.
+	 * There are 2 races for which mutex is required.
 	 *
+	 * The first race is between device creation and userspace writing to
+	 * schedule immediately destruction.
 	 *
+	 * This race is handled by arming the timer before device creation, but
+	 * when device creation fails the timer still exists.
 	 *
-	 *        cpu0(X)                                 cpu1(Y)
+	 * To solve this, hold the mutex during device_add(), and set
+	 * init_completed on success before releasing the mutex.
 	 *
-	 *        dev_coredump() uevent sent to user space
-	 *        device_add()  ======================> user space process Y reads the
-	 *                                              uevents writes to devcd fd
-	 *                                              which results into writes to
+	 * That way the timer will never fire until device_add() is called,
+	 * it will do nothing if init_completed is not set. The timer is also
+	 * cancelled in that case.
 	 *
-	 *                                             devcd_data_write()
-	 *                                               mod_delayed_work()
-	 *                                                 try_to_grab_pending()
-	 *                                                   timer_delete()
-	 *                                                     debug_assert_init()
-	 *       INIT_DELAYED_WORK()
-	 *       schedule_delayed_work()
-	 *
-	 *
-	 * Also, mutex alone would not be enough to avoid scheduling of
-	 * del_wk work after it get flush from a call to devcd_free()
-	 * mentioned as below.
-	 *
-	 *	disabled_store()
-	 *        devcd_free()
-	 *          mutex_lock()             devcd_data_write()
-	 *          flush_delayed_work()
-	 *          mutex_unlock()
-	 *                                   mutex_lock()
-	 *                                   mod_delayed_work()
-	 *                                   mutex_unlock()
-	 * So, delete_work flag is required.
+	 * The second race involves multiple parallel invocations of devcd_free(),
+	 * add a deleted flag so only 1 can call the destructor.
 	 */
 	struct mutex mutex;
-	bool delete_work;
+	bool init_completed, deleted;
 	struct module *owner;
 	ssize_t (*read)(char *buffer, loff_t offset, size_t count,
 			void *data, size_t datalen);
 	void (*free)(void *data);
+	/*
+	 * If nothing interferes and device_add() was returns success,
+	 * del_wk will destroy the device after the timer fires.
+	 *
+	 * Multiple userspace processes can interfere in the working of the timer:
+	 * - Writing to the coredump will reschedule the timer to run immediately,
+	 *   if still armed.
+	 *
+	 *   This is handled by using "if (cancel_delayed_work()) {
+	 *   schedule_delayed_work() }", to prevent re-arming after having
+	 *   been previously fired.
+	 * - Writing to /sys/class/devcoredump/disabled will destroy the
+	 *   coredump synchronously.
+	 *   This is handled by using disable_delayed_work_sync(), and then
+	 *   checking if deleted flag is set with &devcd->mutex held.
+	 */
 	struct delayed_work del_wk;
 	struct device *failing_dev;
 };
@@ -95,14 +91,27 @@ static void devcd_dev_release(struct device *dev)
 	kfree(devcd);
 }
 
+static void __devcd_del(struct devcd_entry *devcd)
+{
+	devcd->deleted = true;
+	device_del(&devcd->devcd_dev);
+	put_device(&devcd->devcd_dev);
+}
+
 static void devcd_del(struct work_struct *wk)
 {
 	struct devcd_entry *devcd;
+	bool init_completed;
 
 	devcd = container_of(wk, struct devcd_entry, del_wk.work);
 
-	device_del(&devcd->devcd_dev);
-	put_device(&devcd->devcd_dev);
+	/* devcd->mutex serializes against dev_coredumpm_timeout */
+	mutex_lock(&devcd->mutex);
+	init_completed = devcd->init_completed;
+	mutex_unlock(&devcd->mutex);
+
+	if (init_completed)
+		__devcd_del(devcd);
 }
 
 static ssize_t devcd_data_read(struct file *filp, struct kobject *kobj,
@@ -122,12 +131,12 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
-	mutex_lock(&devcd->mutex);
-	if (!devcd->delete_work) {
-		devcd->delete_work = true;
-		mod_delayed_work(system_wq, &devcd->del_wk, 0);
-	}
-	mutex_unlock(&devcd->mutex);
+	/*
+	 * Although it's tempting to use mod_delayed work here,
+	 * that will cause a reschedule if the timer already fired.
+	 */
+	if (cancel_delayed_work(&devcd->del_wk))
+		schedule_delayed_work(&devcd->del_wk, 0);
 
 	return count;
 }
@@ -151,11 +160,21 @@ static int devcd_free(struct device *dev, void *data)
 {
 	struct devcd_entry *devcd = dev_to_devcd(dev);
 
+	/*
+	 * To prevent a race with devcd_data_write(), disable work and
+	 * complete manually instead.
+	 *
+	 * We cannot rely on the return value of
+	 * disable_delayed_work_sync() here, because it might be in the
+	 * middle of a cancel_delayed_work + schedule_delayed_work pair.
+	 *
+	 * devcd->mutex here guards against multiple parallel invocations
+	 * of devcd_free().
+	 */
+	disable_delayed_work_sync(&devcd->del_wk);
 	mutex_lock(&devcd->mutex);
-	if (!devcd->delete_work)
-		devcd->delete_work = true;
-
-	flush_delayed_work(&devcd->del_wk);
+	if (!devcd->deleted)
+		__devcd_del(devcd);
 	mutex_unlock(&devcd->mutex);
 	return 0;
 }
@@ -179,12 +198,10 @@ static ssize_t disabled_show(const struct class *class, const struct class_attri
  *                                                                 put_device() <- last reference
  *             error = fn(dev, data)                           devcd_dev_release()
  *             devcd_free(dev, data)                           kfree(devcd)
- *             mutex_lock(&devcd->mutex);
  *
  *
  * In the above diagram, it looks like disabled_store() would be racing with parallelly
- * running devcd_del() and result in memory abort while acquiring devcd->mutex which
- * is called after kfree of devcd memory after dropping its last reference with
+ * running devcd_del() and result in memory abort after dropping its last reference with
  * put_device(). However, this will not happens as fn(dev, data) runs
  * with its own reference to device via klist_node so it is not its last reference.
  * so, above situation would not occur.
@@ -374,7 +391,7 @@ void dev_coredumpm_timeout(struct device *dev, struct module *owner,
 	devcd->read = read;
 	devcd->free = free;
 	devcd->failing_dev = get_device(dev);
-	devcd->delete_work = false;
+	devcd->deleted = false;
 
 	mutex_init(&devcd->mutex);
 	device_initialize(&devcd->devcd_dev);
@@ -383,8 +400,14 @@ void dev_coredumpm_timeout(struct device *dev, struct module *owner,
 		     atomic_inc_return(&devcd_count));
 	devcd->devcd_dev.class = &devcd_class;
 
-	mutex_lock(&devcd->mutex);
 	dev_set_uevent_suppress(&devcd->devcd_dev, true);
+
+	/* devcd->mutex prevents devcd_del() completing until init finishes */
+	mutex_lock(&devcd->mutex);
+	devcd->init_completed = false;
+	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
+	schedule_delayed_work(&devcd->del_wk, timeout);
+
 	if (device_add(&devcd->devcd_dev))
 		goto put_device;
 
@@ -401,13 +424,20 @@ void dev_coredumpm_timeout(struct device *dev, struct module *owner,
 
 	dev_set_uevent_suppress(&devcd->devcd_dev, false);
 	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
-	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
-	schedule_delayed_work(&devcd->del_wk, timeout);
+
+	/*
+	 * Safe to run devcd_del() now that we are done with devcd_dev.
+	 * Alternatively we could have taken a ref on devcd_dev before
+	 * dropping the lock.
+	 */
+	devcd->init_completed = true;
 	mutex_unlock(&devcd->mutex);
 	return;
  put_device:
-	put_device(&devcd->devcd_dev);
 	mutex_unlock(&devcd->mutex);
+	cancel_delayed_work_sync(&devcd->del_wk);
+	put_device(&devcd->devcd_dev);
+
  put_module:
 	module_put(owner);
  free:
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 87b0b78249da..ad39ab95ea66 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -52,6 +52,7 @@
 static DEFINE_IDR(nbd_index_idr);
 static DEFINE_MUTEX(nbd_index_mutex);
 static struct workqueue_struct *nbd_del_wq;
+static struct cred *nbd_cred;
 static int nbd_total_devices = 0;
 
 struct nbd_sock {
@@ -554,6 +555,7 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 	int result;
 	struct msghdr msg = {} ;
 	unsigned int noreclaim_flag;
+	const struct cred *old_cred;
 
 	if (unlikely(!sock)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
@@ -562,6 +564,8 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 		return -EINVAL;
 	}
 
+	old_cred = override_creds(nbd_cred);
+
 	msg.msg_iter = *iter;
 
 	noreclaim_flag = memalloc_noreclaim_save();
@@ -586,6 +590,8 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
+	revert_creds(old_cred);
+
 	return result;
 }
 
@@ -2677,7 +2683,15 @@ static int __init nbd_init(void)
 		return -ENOMEM;
 	}
 
+	nbd_cred = prepare_kernel_cred(&init_task);
+	if (!nbd_cred) {
+		destroy_workqueue(nbd_del_wq);
+		unregister_blkdev(NBD_MAJOR, "nbd");
+		return -ENOMEM;
+	}
+
 	if (genl_register_family(&nbd_genl_family)) {
+		put_cred(nbd_cred);
 		destroy_workqueue(nbd_del_wq);
 		unregister_blkdev(NBD_MAJOR, "nbd");
 		return -EINVAL;
@@ -2732,6 +2746,7 @@ static void __exit nbd_cleanup(void)
 	/* Also wait for nbd_dev_remove_work() completes */
 	destroy_workqueue(nbd_del_wq);
 
+	put_cred(nbd_cred);
 	idr_destroy(&nbd_index_idr);
 	unregister_blkdev(NBD_MAJOR, "nbd");
 }
diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
index 002c0e76baff..c7c262a2d8ca 100644
--- a/drivers/comedi/comedi_buf.c
+++ b/drivers/comedi/comedi_buf.c
@@ -317,7 +317,7 @@ static unsigned int comedi_buf_munge(struct comedi_subdevice *s,
 	unsigned int count = 0;
 	const unsigned int num_sample_bytes = comedi_bytes_per_sample(s);
 
-	if (!s->munge || (async->cmd.flags & CMDF_RAWDATA)) {
+	if (!s->munge || (async->cmd.flags & CMDF_RAWDATA) || async->cmd.chanlist_len == 0) {
 		async->munge_count += num_bytes;
 		return num_bytes;
 	}
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b4c79fde1979..e4f1933dd7d4 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1614,7 +1614,11 @@ static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
 	 * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
 	 * limits, epp and desired perf will get reset to the cached values in cpudata struct
 	 */
-	return amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
+	return amd_pstate_update_perf(policy, perf.bios_min_perf,
+				     FIELD_GET(AMD_CPPC_DES_PERF_MASK, cpudata->cppc_req_cached),
+				     FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
+				     FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached),
+				     false);
 }
 
 static int amd_pstate_suspend(struct cpufreq_policy *policy)
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index b2e3d0b0a116..d54a60a024e4 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -188,20 +188,17 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	 *
 	 * This can deal with workloads that have long pauses interspersed
 	 * with sporadic activity with a bunch of short pauses.
+	 *
+	 * However, if the number of remaining samples is too small to exclude
+	 * any more outliers, allow the deepest available idle state to be
+	 * selected because there are systems where the time spent by CPUs in
+	 * deep idle states is correlated to the maximum frequency the CPUs
+	 * can get to.  On those systems, shallow idle states should be avoided
+	 * unless there is a clear indication that the given CPU is most likley
+	 * going to be woken up shortly.
 	 */
-	if (divisor * 4 <= INTERVALS * 3) {
-		/*
-		 * If there are sufficiently many data points still under
-		 * consideration after the outliers have been eliminated,
-		 * returning without a prediction would be a mistake because it
-		 * is likely that the next interval will not exceed the current
-		 * maximum, so return the latter in that case.
-		 */
-		if (divisor >= INTERVALS / 2)
-			return max;
-
+	if (divisor * 4 <= INTERVALS * 3)
 		return UINT_MAX;
-	}
 
 	/* Update the thresholds for the next round. */
 	if (avg - min > max - avg)
diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 65bf1685350a..c72ee4756585 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -649,6 +649,26 @@ static u16 ffa_memory_attributes_get(u32 func_id)
 	return FFA_MEM_NORMAL | FFA_MEM_WRITE_BACK | FFA_MEM_INNER_SHAREABLE;
 }
 
+static void ffa_emad_impdef_value_init(u32 version, void *dst, void *src)
+{
+	struct ffa_mem_region_attributes *ep_mem_access;
+
+	if (FFA_EMAD_HAS_IMPDEF_FIELD(version))
+		memcpy(dst, src, sizeof(ep_mem_access->impdef_val));
+}
+
+static void
+ffa_mem_region_additional_setup(u32 version, struct ffa_mem_region *mem_region)
+{
+	if (!FFA_MEM_REGION_HAS_EP_MEM_OFFSET(version)) {
+		mem_region->ep_mem_size = 0;
+	} else {
+		mem_region->ep_mem_size = ffa_emad_size_get(version);
+		mem_region->ep_mem_offset = sizeof(*mem_region);
+		memset(mem_region->reserved, 0, 12);
+	}
+}
+
 static int
 ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 		       struct ffa_mem_ops_args *args)
@@ -667,27 +687,24 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
 	mem_region->flags = args->flags;
 	mem_region->sender_id = drv_info->vm_id;
 	mem_region->attributes = ffa_memory_attributes_get(func_id);
-	ep_mem_access = buffer +
-			ffa_mem_desc_offset(buffer, 0, drv_info->version);
 	composite_offset = ffa_mem_desc_offset(buffer, args->nattrs,
 					       drv_info->version);
 
-	for (idx = 0; idx < args->nattrs; idx++, ep_mem_access++) {
+	for (idx = 0; idx < args->nattrs; idx++) {
+		ep_mem_access = buffer +
+			ffa_mem_desc_offset(buffer, idx, drv_info->version);
 		ep_mem_access->receiver = args->attrs[idx].receiver;
 		ep_mem_access->attrs = args->attrs[idx].attrs;
 		ep_mem_access->composite_off = composite_offset;
 		ep_mem_access->flag = 0;
 		ep_mem_access->reserved = 0;
+		ffa_emad_impdef_value_init(drv_info->version,
+					   ep_mem_access->impdef_val,
+					   args->attrs[idx].impdef_val);
 	}
 	mem_region->handle = 0;
 	mem_region->ep_count = args->nattrs;
-	if (drv_info->version <= FFA_VERSION_1_0) {
-		mem_region->ep_mem_size = 0;
-	} else {
-		mem_region->ep_mem_size = sizeof(*ep_mem_access);
-		mem_region->ep_mem_offset = sizeof(*mem_region);
-		memset(mem_region->reserved, 0, 12);
-	}
+	ffa_mem_region_additional_setup(drv_info->version, mem_region);
 
 	composite = buffer + composite_offset;
 	composite->total_pg_cnt = ffa_get_num_pages_sg(args->sg);
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 07b9e629276d..7c35c95fddba 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -309,16 +309,36 @@ enum debug_counters {
 	SCMI_DEBUG_COUNTERS_LAST
 };
 
-static inline void scmi_inc_count(atomic_t *arr, int stat)
+/**
+ * struct scmi_debug_info  - Debug common info
+ * @top_dentry: A reference to the top debugfs dentry
+ * @name: Name of this SCMI instance
+ * @type: Type of this SCMI instance
+ * @is_atomic: Flag to state if the transport of this instance is atomic
+ * @counters: An array of atomic_c's used for tracking statistics (if enabled)
+ */
+struct scmi_debug_info {
+	struct dentry *top_dentry;
+	const char *name;
+	const char *type;
+	bool is_atomic;
+	atomic_t counters[SCMI_DEBUG_COUNTERS_LAST];
+};
+
+static inline void scmi_inc_count(struct scmi_debug_info *dbg, int stat)
 {
-	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_COUNTERS))
-		atomic_inc(&arr[stat]);
+	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_COUNTERS)) {
+		if (dbg)
+			atomic_inc(&dbg->counters[stat]);
+	}
 }
 
-static inline void scmi_dec_count(atomic_t *arr, int stat)
+static inline void scmi_dec_count(struct scmi_debug_info *dbg, int stat)
 {
-	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_COUNTERS))
-		atomic_dec(&arr[stat]);
+	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_COUNTERS)) {
+		if (dbg)
+			atomic_dec(&dbg->counters[stat]);
+	}
 }
 
 enum scmi_bad_msg {
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index bd56a877fdfc..a8f2247feab9 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -115,22 +115,6 @@ struct scmi_protocol_instance {
 
 #define ph_to_pi(h)	container_of(h, struct scmi_protocol_instance, ph)
 
-/**
- * struct scmi_debug_info  - Debug common info
- * @top_dentry: A reference to the top debugfs dentry
- * @name: Name of this SCMI instance
- * @type: Type of this SCMI instance
- * @is_atomic: Flag to state if the transport of this instance is atomic
- * @counters: An array of atomic_c's used for tracking statistics (if enabled)
- */
-struct scmi_debug_info {
-	struct dentry *top_dentry;
-	const char *name;
-	const char *type;
-	bool is_atomic;
-	atomic_t counters[SCMI_DEBUG_COUNTERS_LAST];
-};
-
 /**
  * struct scmi_info - Structure representing a SCMI instance
  *
@@ -610,7 +594,7 @@ scmi_xfer_inflight_register_unlocked(struct scmi_xfer *xfer,
 	/* Set in-flight */
 	set_bit(xfer->hdr.seq, minfo->xfer_alloc_table);
 	hash_add(minfo->pending_xfers, &xfer->node, xfer->hdr.seq);
-	scmi_inc_count(info->dbg->counters, XFERS_INFLIGHT);
+	scmi_inc_count(info->dbg, XFERS_INFLIGHT);
 
 	xfer->pending = true;
 }
@@ -819,8 +803,9 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 			hash_del(&xfer->node);
 			xfer->pending = false;
 
-			scmi_dec_count(info->dbg->counters, XFERS_INFLIGHT);
+			scmi_dec_count(info->dbg, XFERS_INFLIGHT);
 		}
+		xfer->flags = 0;
 		hlist_add_head(&xfer->node, &minfo->free_xfers);
 	}
 	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
@@ -839,8 +824,6 @@ void scmi_xfer_raw_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 {
 	struct scmi_info *info = handle_to_scmi_info(handle);
 
-	xfer->flags &= ~SCMI_XFER_FLAG_IS_RAW;
-	xfer->flags &= ~SCMI_XFER_FLAG_CHAN_SET;
 	return __scmi_xfer_put(&info->tx_minfo, xfer);
 }
 
@@ -1034,7 +1017,7 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
 		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
 
 		scmi_bad_message_trace(cinfo, msg_hdr, MSG_UNEXPECTED);
-		scmi_inc_count(info->dbg->counters, ERR_MSG_UNEXPECTED);
+		scmi_inc_count(info->dbg, ERR_MSG_UNEXPECTED);
 
 		return xfer;
 	}
@@ -1062,7 +1045,7 @@ scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
 			msg_type, xfer_id, msg_hdr, xfer->state);
 
 		scmi_bad_message_trace(cinfo, msg_hdr, MSG_INVALID);
-		scmi_inc_count(info->dbg->counters, ERR_MSG_INVALID);
+		scmi_inc_count(info->dbg, ERR_MSG_INVALID);
 
 		/* On error the refcount incremented above has to be dropped */
 		__scmi_xfer_put(minfo, xfer);
@@ -1107,7 +1090,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 			PTR_ERR(xfer));
 
 		scmi_bad_message_trace(cinfo, msg_hdr, MSG_NOMEM);
-		scmi_inc_count(info->dbg->counters, ERR_MSG_NOMEM);
+		scmi_inc_count(info->dbg, ERR_MSG_NOMEM);
 
 		scmi_clear_channel(info, cinfo);
 		return;
@@ -1123,7 +1106,7 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo,
 	trace_scmi_msg_dump(info->id, cinfo->id, xfer->hdr.protocol_id,
 			    xfer->hdr.id, "NOTI", xfer->hdr.seq,
 			    xfer->hdr.status, xfer->rx.buf, xfer->rx.len);
-	scmi_inc_count(info->dbg->counters, NOTIFICATION_OK);
+	scmi_inc_count(info->dbg, NOTIFICATION_OK);
 
 	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
 		    xfer->hdr.id, xfer->rx.buf, xfer->rx.len, ts);
@@ -1183,10 +1166,10 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP) {
 		scmi_clear_channel(info, cinfo);
 		complete(xfer->async_done);
-		scmi_inc_count(info->dbg->counters, DELAYED_RESPONSE_OK);
+		scmi_inc_count(info->dbg, DELAYED_RESPONSE_OK);
 	} else {
 		complete(&xfer->done);
-		scmi_inc_count(info->dbg->counters, RESPONSE_OK);
+		scmi_inc_count(info->dbg, RESPONSE_OK);
 	}
 
 	if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
@@ -1296,7 +1279,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 					"timed out in resp(caller: %pS) - polling\n",
 					(void *)_RET_IP_);
 				ret = -ETIMEDOUT;
-				scmi_inc_count(info->dbg->counters, XFERS_RESPONSE_POLLED_TIMEOUT);
+				scmi_inc_count(info->dbg, XFERS_RESPONSE_POLLED_TIMEOUT);
 			}
 		}
 
@@ -1321,7 +1304,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 					    "RESP" : "resp",
 					    xfer->hdr.seq, xfer->hdr.status,
 					    xfer->rx.buf, xfer->rx.len);
-			scmi_inc_count(info->dbg->counters, RESPONSE_POLLED_OK);
+			scmi_inc_count(info->dbg, RESPONSE_POLLED_OK);
 
 			if (IS_ENABLED(CONFIG_ARM_SCMI_RAW_MODE_SUPPORT)) {
 				scmi_raw_message_report(info->raw, xfer,
@@ -1336,7 +1319,7 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 			dev_err(dev, "timed out in resp(caller: %pS)\n",
 				(void *)_RET_IP_);
 			ret = -ETIMEDOUT;
-			scmi_inc_count(info->dbg->counters, XFERS_RESPONSE_TIMEOUT);
+			scmi_inc_count(info->dbg, XFERS_RESPONSE_TIMEOUT);
 		}
 	}
 
@@ -1420,13 +1403,13 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	    !is_transport_polling_capable(info->desc)) {
 		dev_warn_once(dev,
 			      "Polling mode is not supported by transport.\n");
-		scmi_inc_count(info->dbg->counters, SENT_FAIL_POLLING_UNSUPPORTED);
+		scmi_inc_count(info->dbg, SENT_FAIL_POLLING_UNSUPPORTED);
 		return -EINVAL;
 	}
 
 	cinfo = idr_find(&info->tx_idr, pi->proto->id);
 	if (unlikely(!cinfo)) {
-		scmi_inc_count(info->dbg->counters, SENT_FAIL_CHANNEL_NOT_FOUND);
+		scmi_inc_count(info->dbg, SENT_FAIL_CHANNEL_NOT_FOUND);
 		return -EINVAL;
 	}
 	/* True ONLY if also supported by transport. */
@@ -1461,19 +1444,19 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	ret = info->desc->ops->send_message(cinfo, xfer);
 	if (ret < 0) {
 		dev_dbg(dev, "Failed to send message %d\n", ret);
-		scmi_inc_count(info->dbg->counters, SENT_FAIL);
+		scmi_inc_count(info->dbg, SENT_FAIL);
 		return ret;
 	}
 
 	trace_scmi_msg_dump(info->id, cinfo->id, xfer->hdr.protocol_id,
 			    xfer->hdr.id, "CMND", xfer->hdr.seq,
 			    xfer->hdr.status, xfer->tx.buf, xfer->tx.len);
-	scmi_inc_count(info->dbg->counters, SENT_OK);
+	scmi_inc_count(info->dbg, SENT_OK);
 
 	ret = scmi_wait_for_message_response(cinfo, xfer);
 	if (!ret && xfer->hdr.status) {
 		ret = scmi_to_linux_errno(xfer->hdr.status);
-		scmi_inc_count(info->dbg->counters, ERR_PROTOCOL);
+		scmi_inc_count(info->dbg, ERR_PROTOCOL);
 	}
 
 	if (info->desc->ops->mark_txdone)
@@ -3423,6 +3406,9 @@ int scmi_inflight_count(const struct scmi_handle *handle)
 	if (IS_ENABLED(CONFIG_ARM_SCMI_DEBUG_COUNTERS)) {
 		struct scmi_info *info = handle_to_scmi_info(handle);
 
+		if (!info->dbg)
+			return 0;
+
 		return atomic_read(&info->dbg->counters[XFERS_INFLIGHT]);
 	} else {
 		return 0;
diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
index ffe7e1cb6b23..fe5c10cd5c32 100644
--- a/drivers/gpio/gpio-104-idio-16.c
+++ b/drivers/gpio/gpio-104-idio-16.c
@@ -59,6 +59,7 @@ static const struct regmap_config idio_16_regmap_config = {
 	.reg_stride = 1,
 	.val_bits = 8,
 	.io_port = true,
+	.max_register = 0x5,
 	.wr_table = &idio_16_wr_table,
 	.rd_table = &idio_16_rd_table,
 	.volatile_table = &idio_16_rd_table,
diff --git a/drivers/gpio/gpio-idio-16.c b/drivers/gpio/gpio-idio-16.c
index 0103be977c66..4fbae6f6a497 100644
--- a/drivers/gpio/gpio-idio-16.c
+++ b/drivers/gpio/gpio-idio-16.c
@@ -6,6 +6,7 @@
 
 #define DEFAULT_SYMBOL_NAMESPACE "GPIO_IDIO_16"
 
+#include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -107,6 +108,7 @@ int devm_idio_16_regmap_register(struct device *const dev,
 	struct idio_16_data *data;
 	struct regmap_irq_chip *chip;
 	struct regmap_irq_chip_data *chip_data;
+	DECLARE_BITMAP(fixed_direction_output, IDIO_16_NGPIO);
 
 	if (!config->parent)
 		return -EINVAL;
@@ -164,6 +166,9 @@ int devm_idio_16_regmap_register(struct device *const dev,
 	gpio_config.irq_domain = regmap_irq_get_domain(chip_data);
 	gpio_config.reg_mask_xlate = idio_16_reg_mask_xlate;
 
+	bitmap_from_u64(fixed_direction_output, GENMASK_U64(15, 0));
+	gpio_config.fixed_direction_output = fixed_direction_output;
+
 	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
 }
 EXPORT_SYMBOL_GPL(devm_idio_16_regmap_register);
diff --git a/drivers/gpio/gpio-ljca.c b/drivers/gpio/gpio-ljca.c
index 3b4f8830c741..f32d1d237795 100644
--- a/drivers/gpio/gpio-ljca.c
+++ b/drivers/gpio/gpio-ljca.c
@@ -286,22 +286,14 @@ static void ljca_gpio_event_cb(void *context, u8 cmd, const void *evt_data,
 {
 	const struct ljca_gpio_packet *packet = evt_data;
 	struct ljca_gpio_dev *ljca_gpio = context;
-	int i, irq;
+	int i;
 
 	if (cmd != LJCA_GPIO_INT_EVENT)
 		return;
 
 	for (i = 0; i < packet->num; i++) {
-		irq = irq_find_mapping(ljca_gpio->gc.irq.domain,
-				       packet->item[i].index);
-		if (!irq) {
-			dev_err(ljca_gpio->gc.parent,
-				"gpio_id %u does not mapped to IRQ yet\n",
-				packet->item[i].index);
-			return;
-		}
-
-		generic_handle_domain_irq(ljca_gpio->gc.irq.domain, irq);
+		generic_handle_domain_irq(ljca_gpio->gc.irq.domain,
+					packet->item[i].index);
 		set_bit(packet->item[i].index, ljca_gpio->reenable_irqs);
 	}
 
diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 476cea1b5ed7..9d28ca8e1d6f 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -41,6 +41,7 @@ static const struct regmap_config idio_16_regmap_config = {
 	.reg_stride = 1,
 	.val_bits = 8,
 	.io_port = true,
+	.max_register = 0x7,
 	.wr_table = &idio_16_wr_table,
 	.rd_table = &idio_16_rd_table,
 	.volatile_table = &idio_16_rd_table,
diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 3f8b72311f8e..170d13b00ae7 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -31,6 +31,12 @@ struct gpio_regmap {
 	unsigned int reg_clr_base;
 	unsigned int reg_dir_in_base;
 	unsigned int reg_dir_out_base;
+	unsigned long *fixed_direction_output;
+
+#ifdef CONFIG_REGMAP_IRQ
+	int regmap_irq_line;
+	struct regmap_irq_chip_data *irq_chip_data;
+#endif
 
 	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
 			      unsigned int offset, unsigned int *reg,
@@ -129,6 +135,13 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
 	unsigned int base, val, reg, mask;
 	int invert, ret;
 
+	if (gpio->fixed_direction_output) {
+		if (test_bit(offset, gpio->fixed_direction_output))
+			return GPIO_LINE_DIRECTION_OUT;
+		else
+			return GPIO_LINE_DIRECTION_IN;
+	}
+
 	if (gpio->reg_dat_base && !gpio->reg_set_base)
 		return GPIO_LINE_DIRECTION_IN;
 	if (gpio->reg_set_base && !gpio->reg_dat_base)
@@ -215,6 +228,7 @@ EXPORT_SYMBOL_GPL(gpio_regmap_get_drvdata);
  */
 struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config)
 {
+	struct irq_domain *irq_domain;
 	struct gpio_regmap *gpio;
 	struct gpio_chip *chip;
 	int ret;
@@ -277,6 +291,17 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 			goto err_free_gpio;
 	}
 
+	if (config->fixed_direction_output) {
+		gpio->fixed_direction_output = bitmap_alloc(chip->ngpio,
+							    GFP_KERNEL);
+		if (!gpio->fixed_direction_output) {
+			ret = -ENOMEM;
+			goto err_free_gpio;
+		}
+		bitmap_copy(gpio->fixed_direction_output,
+			    config->fixed_direction_output, chip->ngpio);
+	}
+
 	/* if not set, assume there is only one register */
 	gpio->ngpio_per_reg = config->ngpio_per_reg;
 	if (!gpio->ngpio_per_reg)
@@ -293,10 +318,24 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 
 	ret = gpiochip_add_data(chip, gpio);
 	if (ret < 0)
-		goto err_free_gpio;
+		goto err_free_bitmap;
+
+#ifdef CONFIG_REGMAP_IRQ
+	if (config->regmap_irq_chip) {
+		gpio->regmap_irq_line = config->regmap_irq_line;
+		ret = regmap_add_irq_chip_fwnode(dev_fwnode(config->parent), config->regmap,
+						 config->regmap_irq_line, config->regmap_irq_flags,
+						 0, config->regmap_irq_chip, &gpio->irq_chip_data);
+		if (ret)
+			goto err_free_bitmap;
 
-	if (config->irq_domain) {
-		ret = gpiochip_irqchip_add_domain(chip, config->irq_domain);
+		irq_domain = regmap_irq_get_domain(gpio->irq_chip_data);
+	} else
+#endif
+	irq_domain = config->irq_domain;
+
+	if (irq_domain) {
+		ret = gpiochip_irqchip_add_domain(chip, irq_domain);
 		if (ret)
 			goto err_remove_gpiochip;
 	}
@@ -305,6 +344,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 
 err_remove_gpiochip:
 	gpiochip_remove(chip);
+err_free_bitmap:
+	bitmap_free(gpio->fixed_direction_output);
 err_free_gpio:
 	kfree(gpio);
 	return ERR_PTR(ret);
@@ -317,7 +358,13 @@ EXPORT_SYMBOL_GPL(gpio_regmap_register);
  */
 void gpio_regmap_unregister(struct gpio_regmap *gpio)
 {
+#ifdef CONFIG_REGMAP_IRQ
+	if (gpio->irq_chip_data)
+		regmap_del_irq_chip(gpio->regmap_irq_line, gpio->irq_chip_data);
+#endif
+
 	gpiochip_remove(&gpio->gpio_chip);
+	bitmap_free(gpio->fixed_direction_output);
 	kfree(gpio);
 }
 EXPORT_SYMBOL_GPL(gpio_regmap_unregister);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 61167c19359d..b95b98cc2553 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -200,6 +200,9 @@ void dcn401_init_hw(struct dc *dc)
 		 */
 		struct dc_link *link = dc->links[i];
 
+		if (link->ep_type != DISPLAY_ENDPOINT_PHY)
+			continue;
+
 		link->link_enc->funcs->hw_init(link->link_enc);
 
 		/* Check for enabled DIG to identify enabled display */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index 41c76ba9ba56..62a39204fe0b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -44,7 +44,13 @@
  */
 #define MAX_PIPES 6
 #define MAX_PHANTOM_PIPES (MAX_PIPES / 2)
-#define MAX_LINKS (MAX_PIPES * 2 +2)
+
+#define MAX_DPIA 6
+#define MAX_CONNECTOR 6
+#define MAX_VIRTUAL_LINKS 4
+
+#define MAX_LINKS (MAX_DPIA + MAX_CONNECTOR + MAX_VIRTUAL_LINKS)
+
 #define MAX_DIG_LINK_ENCODERS 7
 #define MAX_DWB_PIPES	1
 #define MAX_HPO_DP2_ENCODERS	4
diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 1d6312fa1429..f52752880e1c 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -174,6 +174,33 @@ static void drm_panic_write_pixel24(void *vaddr, unsigned int offset, u32 color)
 	*p = color & 0xff;
 }
 
+/*
+ * Special case if the pixel crosses page boundaries
+ */
+static void drm_panic_write_pixel24_xpage(void *vaddr, struct page *next_page,
+					  unsigned int offset, u32 color)
+{
+	u8 *vaddr2;
+	u8 *p = vaddr + offset;
+
+	vaddr2 = kmap_local_page_try_from_panic(next_page);
+
+	*p++ = color & 0xff;
+	color >>= 8;
+
+	if (offset == PAGE_SIZE - 1)
+		p = vaddr2;
+
+	*p++ = color & 0xff;
+	color >>= 8;
+
+	if (offset == PAGE_SIZE - 2)
+		p = vaddr2;
+
+	*p = color & 0xff;
+	kunmap_local(vaddr2);
+}
+
 static void drm_panic_write_pixel32(void *vaddr, unsigned int offset, u32 color)
 {
 	u32 *p = vaddr + offset;
@@ -231,7 +258,14 @@ static void drm_panic_blit_page(struct page **pages, unsigned int dpitch,
 					page = new_page;
 					vaddr = kmap_local_page_try_from_panic(pages[page]);
 				}
-				if (vaddr)
+				if (!vaddr)
+					continue;
+
+				// Special case for 24bit, as a pixel might cross page boundaries
+				if (cpp == 3 && offset + 3 > PAGE_SIZE)
+					drm_panic_write_pixel24_xpage(vaddr, pages[page + 1],
+								      offset, fg32);
+				else
 					drm_panic_write_pixel(vaddr, offset, fg32, cpp);
 			}
 		}
@@ -321,7 +355,15 @@ static void drm_panic_fill_page(struct page **pages, unsigned int dpitch,
 				page = new_page;
 				vaddr = kmap_local_page_try_from_panic(pages[page]);
 			}
-			drm_panic_write_pixel(vaddr, offset, color, cpp);
+			if (!vaddr)
+				continue;
+
+			// Special case for 24bit, as a pixel might cross page boundaries
+			if (cpp == 3 && offset + 3 > PAGE_SIZE)
+				drm_panic_write_pixel24_xpage(vaddr, pages[page + 1],
+							      offset, color);
+			else
+				drm_panic_write_pixel(vaddr, offset, color, cpp);
 		}
 	}
 	if (vaddr)
@@ -429,6 +471,9 @@ static void drm_panic_logo_rect(struct drm_rect *rect, const struct font_desc *f
 static void drm_panic_logo_draw(struct drm_scanout_buffer *sb, struct drm_rect *rect,
 				const struct font_desc *font, u32 fg_color)
 {
+	if (rect->x2 > sb->width || rect->y2 > sb->height)
+		return;
+
 	if (logo_mono)
 		drm_panic_blit(sb, rect, logo_mono->data,
 			       DIV_ROUND_UP(drm_rect_width(rect), 8), 1, fg_color);
@@ -733,7 +778,10 @@ static int _draw_panic_static_qr_code(struct drm_scanout_buffer *sb)
 	pr_debug("QR width %d and scale %d\n", qr_width, scale);
 	r_qr_canvas = DRM_RECT_INIT(0, 0, qr_canvas_width * scale, qr_canvas_width * scale);
 
-	v_margin = (sb->height - drm_rect_height(&r_qr_canvas) - drm_rect_height(&r_msg)) / 5;
+	v_margin = sb->height - drm_rect_height(&r_qr_canvas) - drm_rect_height(&r_msg);
+	if (v_margin < 0)
+		return -ENOSPC;
+	v_margin /= 5;
 
 	drm_rect_translate(&r_qr_canvas, (sb->width - r_qr_canvas.x2) / 2, 2 * v_margin);
 	r_qr = DRM_RECT_INIT(r_qr_canvas.x1 + QR_MARGIN * scale, r_qr_canvas.y1 + QR_MARGIN * scale,
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 4140f697ba5a..0402f5f734a1 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1147,10 +1147,14 @@ panthor_vm_op_ctx_prealloc_vmas(struct panthor_vm_op_ctx *op_ctx)
 		break;
 
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP:
-		/* Partial unmaps might trigger a remap with either a prev or a next VA,
-		 * but not both.
+		/* Two VMAs can be needed for an unmap, as an unmap can happen
+		 * in the middle of a drm_gpuva, requiring a remap with both
+		 * prev & next VA. Or an unmap can span more than one drm_gpuva
+		 * where the first and last ones are covered partially, requring
+		 * a remap for the first with a prev VA and remap for the last
+		 * with a next VA.
 		 */
-		vma_count = 1;
+		vma_count = 2;
 		break;
 
 	default:
diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index 29d4d3f51da1..8f7b2603e47f 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -291,6 +291,9 @@ int xe_ggtt_init_early(struct xe_ggtt *ggtt)
 		ggtt->pt_ops = &xelp_pt_ops;
 
 	ggtt->wq = alloc_workqueue("xe-ggtt-wq", 0, WQ_MEM_RECLAIM);
+	if (!ggtt->wq)
+		return -ENOMEM;
+
 	__xe_ggtt_init_early(ggtt, xe_wopcm_size(xe));
 
 	err = drmm_add_action_or_reset(&xe->drm, ggtt_fini_early, ggtt);
diff --git a/drivers/hwmon/cgbc-hwmon.c b/drivers/hwmon/cgbc-hwmon.c
index 772f44d56ccf..3aff4e092132 100644
--- a/drivers/hwmon/cgbc-hwmon.c
+++ b/drivers/hwmon/cgbc-hwmon.c
@@ -107,6 +107,9 @@ static int cgbc_hwmon_probe_sensors(struct device *dev, struct cgbc_hwmon_data *
 	nb_sensors = data[0];
 
 	hwmon->sensors = devm_kzalloc(dev, sizeof(*hwmon->sensors) * nb_sensors, GFP_KERNEL);
+	if (!hwmon->sensors)
+		return -ENOMEM;
+
 	sensor = hwmon->sensors;
 
 	for (i = 0; i < nb_sensors; i++) {
diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
index c52c55d2e7f4..0c6b31ee755b 100644
--- a/drivers/hwmon/pmbus/isl68137.c
+++ b/drivers/hwmon/pmbus/isl68137.c
@@ -334,10 +334,9 @@ static int isl68137_probe_from_dt(struct device *dev,
 				  struct isl68137_data *data)
 {
 	const struct device_node *np = dev->of_node;
-	struct device_node *child;
 	int err;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (strcmp(child->name, "channel"))
 			continue;
 
diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
index 56834d26f8ef..ef981ed97da8 100644
--- a/drivers/hwmon/pmbus/max34440.c
+++ b/drivers/hwmon/pmbus/max34440.c
@@ -336,18 +336,18 @@ static struct pmbus_driver_info max34440_info[] = {
 		.format[PSC_CURRENT_IN] = direct,
 		.format[PSC_CURRENT_OUT] = direct,
 		.format[PSC_TEMPERATURE] = direct,
-		.m[PSC_VOLTAGE_IN] = 1,
+		.m[PSC_VOLTAGE_IN] = 125,
 		.b[PSC_VOLTAGE_IN] = 0,
 		.R[PSC_VOLTAGE_IN] = 0,
-		.m[PSC_VOLTAGE_OUT] = 1,
+		.m[PSC_VOLTAGE_OUT] = 125,
 		.b[PSC_VOLTAGE_OUT] = 0,
 		.R[PSC_VOLTAGE_OUT] = 0,
-		.m[PSC_CURRENT_IN] = 1,
+		.m[PSC_CURRENT_IN] = 250,
 		.b[PSC_CURRENT_IN] = 0,
-		.R[PSC_CURRENT_IN] = 2,
-		.m[PSC_CURRENT_OUT] = 1,
+		.R[PSC_CURRENT_IN] = -1,
+		.m[PSC_CURRENT_OUT] = 250,
 		.b[PSC_CURRENT_OUT] = 0,
-		.R[PSC_CURRENT_OUT] = 2,
+		.R[PSC_CURRENT_OUT] = -1,
 		.m[PSC_TEMPERATURE] = 1,
 		.b[PSC_TEMPERATURE] = 0,
 		.R[PSC_TEMPERATURE] = 2,
diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 557ad3e7752a..f36c0229328f 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -291,24 +291,26 @@ static struct sht3x_data *sht3x_update_client(struct device *dev)
 	return data;
 }
 
-static int temp1_input_read(struct device *dev)
+static int temp1_input_read(struct device *dev, long *temp)
 {
 	struct sht3x_data *data = sht3x_update_client(dev);
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	return data->temperature;
+	*temp = data->temperature;
+	return 0;
 }
 
-static int humidity1_input_read(struct device *dev)
+static int humidity1_input_read(struct device *dev, long *humidity)
 {
 	struct sht3x_data *data = sht3x_update_client(dev);
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	return data->humidity;
+	*humidity = data->humidity;
+	return 0;
 }
 
 /*
@@ -706,6 +708,7 @@ static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
 		      u32 attr, int channel, long *val)
 {
 	enum sht3x_limits index;
+	int ret;
 
 	switch (type) {
 	case hwmon_chip:
@@ -720,10 +723,12 @@ static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_temp:
 		switch (attr) {
 		case hwmon_temp_input:
-			*val = temp1_input_read(dev);
-			break;
+			return temp1_input_read(dev, val);
 		case hwmon_temp_alarm:
-			*val = temp1_alarm_read(dev);
+			ret = temp1_alarm_read(dev);
+			if (ret < 0)
+				return ret;
+			*val = ret;
 			break;
 		case hwmon_temp_max:
 			index = limit_max;
@@ -748,10 +753,12 @@ static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_humidity:
 		switch (attr) {
 		case hwmon_humidity_input:
-			*val = humidity1_input_read(dev);
-			break;
+			return humidity1_input_read(dev, val);
 		case hwmon_humidity_alarm:
-			*val = humidity1_alarm_read(dev);
+			ret = humidity1_alarm_read(dev);
+			if (ret < 0)
+				return ret;
+			*val = ret;
 			break;
 		case hwmon_humidity_max:
 			index = limit_max;
diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index 11549d85f23b..b5785472765a 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -30,7 +30,7 @@ static u32 fsl_mc_msi_domain_get_msi_id(struct irq_domain *domain,
 	u32 out_id;
 
 	of_node = irq_domain_get_of_node(domain);
-	out_id = of_node ? of_msi_map_id(&mc_dev->dev, of_node, mc_dev->icid) :
+	out_id = of_node ? of_msi_xlate(&mc_dev->dev, &of_node, mc_dev->icid) :
 			iort_msi_map_id(&mc_dev->dev, mc_dev->icid);
 
 	return out_id;
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 7eec907ed454..7dceb2db67a3 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -384,6 +384,8 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 	}
 	spin_unlock(&fl->lock);
 
+	dma_buf_put(buf);
+
 	return ret;
 }
 
diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
index 015927665678..00ed2147113e 100644
--- a/drivers/misc/lkdtm/fortify.c
+++ b/drivers/misc/lkdtm/fortify.c
@@ -44,6 +44,9 @@ static void lkdtm_FORTIFY_STR_MEMBER(void)
 	char *src;
 
 	src = kmalloc(size, GFP_KERNEL);
+	if (!src)
+		return;
+
 	strscpy(src, "over ten bytes", size);
 	size = strlen(src) + 1;
 
@@ -109,6 +112,9 @@ static void lkdtm_FORTIFY_MEM_MEMBER(void)
 	char *src;
 
 	src = kmalloc(size, GFP_KERNEL);
+	if (!src)
+		return;
+
 	strscpy(src, "over ten bytes", size);
 	size = strlen(src) + 1;
 
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index bc40b940ae21..a4f75dc36929 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -120,6 +120,8 @@
 #define MEI_DEV_ID_PTL_H      0xE370  /* Panther Lake H */
 #define MEI_DEV_ID_PTL_P      0xE470  /* Panther Lake P */
 
+#define MEI_DEV_ID_WCL_P      0x4D70  /* Wildcat Lake P */
+
 /*
  * MEI HW Section
  */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 3f9c60b579ae..bc0fc584a8e4 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -127,6 +127,8 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_H, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_P, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_WCL_P, MEI_ME_PCH15_CFG)},
+
 	/* required last entry */
 	{0, }
 };
diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 6653fc53c951..cc1d18b3df5c 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1737,7 +1737,7 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 {
 	unsigned long status, flags;
 	struct vmballoon *b;
-	int ret;
+	int ret = 0;
 
 	b = container_of(b_dev_info, struct vmballoon, b_dev_info);
 
@@ -1796,17 +1796,15 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 		 * A failure happened. While we can deflate the page we just
 		 * inflated, this deflation can also encounter an error. Instead
 		 * we will decrease the size of the balloon to reflect the
-		 * change and report failure.
+		 * change.
 		 */
 		atomic64_dec(&b->size);
-		ret = -EBUSY;
 	} else {
 		/*
 		 * Success. Take a reference for the page, and we will add it to
 		 * the list after acquiring the lock.
 		 */
 		get_page(newpage);
-		ret = MIGRATEPAGE_SUCCESS;
 	}
 
 	/* Update the balloon list under the @pages_lock */
@@ -1817,7 +1815,7 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 	 * If we succeed just insert it to the list and update the statistics
 	 * under the lock.
 	 */
-	if (ret == MIGRATEPAGE_SUCCESS) {
+	if (status == VMW_BALLOON_SUCCESS) {
 		balloon_page_insert(&b->b_dev_info, newpage);
 		__count_vm_event(BALLOON_MIGRATE);
 	}
diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index cf5be9c449a5..10064d7b7249 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -929,6 +929,10 @@ static void release_mdev(struct device *dev)
 {
 	struct most_dev *mdev = to_mdev_from_dev(dev);
 
+	kfree(mdev->busy_urbs);
+	kfree(mdev->cap);
+	kfree(mdev->conf);
+	kfree(mdev->ep_address);
 	kfree(mdev);
 }
 /**
@@ -1093,7 +1097,7 @@ hdm_probe(struct usb_interface *interface, const struct usb_device_id *id)
 err_free_conf:
 	kfree(mdev->conf);
 err_free_mdev:
-	put_device(&mdev->dev);
+	kfree(mdev);
 	return ret;
 }
 
@@ -1121,13 +1125,6 @@ static void hdm_disconnect(struct usb_interface *interface)
 	if (mdev->dci)
 		device_unregister(&mdev->dci->dev);
 	most_deregister_interface(&mdev->iface);
-
-	kfree(mdev->busy_urbs);
-	kfree(mdev->cap);
-	kfree(mdev->conf);
-	kfree(mdev->ep_address);
-	put_device(&mdev->dci->dev);
-	put_device(&mdev->dev);
 }
 
 static int hdm_suspend(struct usb_interface *interface, pm_message_t message)
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f4f0feddd9fa..e74a1fd34724 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2385,7 +2385,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		unblock_netpoll_tx();
 	}
 
-	if (bond_mode_can_use_xmit_hash(bond))
+	/* broadcast mode uses the all_slaves to loop through slaves. */
+	if (bond_mode_can_use_xmit_hash(bond) ||
+	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
 		bond_update_slave_arr(bond, NULL);
 
 	if (!slave_dev->netdev_ops->ndo_bpf ||
@@ -2561,7 +2563,8 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	bond_upper_dev_unlink(bond, slave);
 
-	if (bond_mode_can_use_xmit_hash(bond))
+	if (bond_mode_can_use_xmit_hash(bond) ||
+	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
 		bond_update_slave_arr(bond, slave);
 
 	slave_info(bond_dev, slave_dev, "Releasing %s interface\n",
@@ -2969,7 +2972,7 @@ static void bond_mii_monitor(struct work_struct *work)
 {
 	struct bonding *bond = container_of(work, struct bonding,
 					    mii_work.work);
-	bool should_notify_peers = false;
+	bool should_notify_peers;
 	bool commit;
 	unsigned long delay;
 	struct slave *slave;
@@ -2981,30 +2984,33 @@ static void bond_mii_monitor(struct work_struct *work)
 		goto re_arm;
 
 	rcu_read_lock();
+
 	should_notify_peers = bond_should_notify_peers(bond);
 	commit = !!bond_miimon_inspect(bond);
-	if (bond->send_peer_notif) {
-		rcu_read_unlock();
-		if (rtnl_trylock()) {
-			bond->send_peer_notif--;
-			rtnl_unlock();
-		}
-	} else {
-		rcu_read_unlock();
-	}
 
-	if (commit) {
+	rcu_read_unlock();
+
+	if (commit || bond->send_peer_notif) {
 		/* Race avoidance with bond_close cancel of workqueue */
 		if (!rtnl_trylock()) {
 			delay = 1;
-			should_notify_peers = false;
 			goto re_arm;
 		}
 
-		bond_for_each_slave(bond, slave, iter) {
-			bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
+		if (commit) {
+			bond_for_each_slave(bond, slave, iter) {
+				bond_commit_link_state(slave,
+						       BOND_SLAVE_NOTIFY_LATER);
+			}
+			bond_miimon_commit(bond);
+		}
+
+		if (bond->send_peer_notif) {
+			bond->send_peer_notif--;
+			if (should_notify_peers)
+				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
+							 bond->dev);
 		}
-		bond_miimon_commit(bond);
 
 		rtnl_unlock();	/* might sleep, hold no other locks */
 	}
@@ -3012,13 +3018,6 @@ static void bond_mii_monitor(struct work_struct *work)
 re_arm:
 	if (bond->params.miimon)
 		queue_delayed_work(bond->wq, &bond->mii_work, delay);
-
-	if (should_notify_peers) {
-		if (!rtnl_trylock())
-			return;
-		call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
-		rtnl_unlock();
-	}
 }
 
 static int bond_upper_dev_walk(struct net_device *upper,
diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
index bfc60eb33dc3..333ad42ea73b 100644
--- a/drivers/net/can/bxcan.c
+++ b/drivers/net/can/bxcan.c
@@ -842,7 +842,7 @@ static netdev_tx_t bxcan_start_xmit(struct sk_buff *skb,
 	u32 id;
 	int i, j;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
 	if (bxcan_tx_busy(priv))
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index d9f6ab3efb97..e2b366dbf727 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -285,7 +285,9 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	}
 
 	if (data[IFLA_CAN_RESTART_MS]) {
-		if (!priv->do_set_mode) {
+		unsigned int restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
+
+		if (restart_ms != 0 && !priv->do_set_mode) {
 			NL_SET_ERR_MSG(extack,
 				       "Device doesn't support restart from Bus Off");
 			return -EOPNOTSUPP;
@@ -294,7 +296,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		/* Do not allow changing restart delay while running */
 		if (dev->flags & IFF_UP)
 			return -EBUSY;
-		priv->restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
+		priv->restart_ms = restart_ms;
 	}
 
 	if (data[IFLA_CAN_RESTART]) {
diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
index c80032bc1a52..73e66f9a3781 100644
--- a/drivers/net/can/esd/esdacc.c
+++ b/drivers/net/can/esd/esdacc.c
@@ -254,7 +254,7 @@ netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	u32 acc_id;
 	u32 acc_dlc;
 
-	if (can_dropped_invalid_skb(netdev, skb))
+	if (can_dev_dropped_skb(netdev, skb))
 		return NETDEV_TX_OK;
 
 	/* Access core->tx_fifo_tail only once because it may be changed
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index 865a15e033a9..12200dcfd338 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -72,7 +72,7 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	int err;
 	u8 i;
 
-	if (can_dropped_invalid_skb(ndev, skb))
+	if (can_dev_dropped_skb(ndev, skb))
 		return NETDEV_TX_OK;
 
 	if (!netif_subqueue_maybe_stop(priv->ndev, 0,
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 0f4efd505332..a5f3d19f1466 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1077,8 +1077,7 @@ static int dpaa2_eth_build_single_fd(struct dpaa2_eth_priv *priv,
 	dma_addr_t addr;
 
 	buffer_start = skb->data - dpaa2_eth_needed_headroom(skb);
-	aligned_start = PTR_ALIGN(buffer_start - DPAA2_ETH_TX_BUF_ALIGN,
-				  DPAA2_ETH_TX_BUF_ALIGN);
+	aligned_start = PTR_ALIGN(buffer_start, DPAA2_ETH_TX_BUF_ALIGN);
 	if (aligned_start >= skb->head)
 		buffer_start = aligned_start;
 	else
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index e4287725832e..5496b4cb2a64 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1558,6 +1558,8 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
 
+	enetc_lock_mdio();
+
 	while (likely(rx_frm_cnt < work_limit)) {
 		union enetc_rx_bd *rxbd;
 		struct sk_buff *skb;
@@ -1593,7 +1595,9 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 		rx_byte_cnt += skb->len + ETH_HLEN;
 		rx_frm_cnt++;
 
+		enetc_unlock_mdio();
 		napi_gro_receive(napi, skb);
+		enetc_lock_mdio();
 	}
 
 	rx_ring->next_to_clean = i;
@@ -1601,6 +1605,8 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
 	rx_ring->stats.packets += rx_frm_cnt;
 	rx_ring->stats.bytes += rx_byte_cnt;
 
+	enetc_unlock_mdio();
+
 	return rx_frm_cnt;
 }
 
@@ -1910,6 +1916,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 	/* next descriptor to process */
 	i = rx_ring->next_to_clean;
 
+	enetc_lock_mdio();
+
 	while (likely(rx_frm_cnt < work_limit)) {
 		union enetc_rx_bd *rxbd, *orig_rxbd;
 		struct xdp_buff xdp_buff;
@@ -1973,7 +1981,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			 */
 			enetc_bulk_flip_buff(rx_ring, orig_i, i);
 
+			enetc_unlock_mdio();
 			napi_gro_receive(napi, skb);
+			enetc_lock_mdio();
 			break;
 		case XDP_TX:
 			tx_ring = priv->xdp_tx_ring[rx_ring->index];
@@ -2008,7 +2018,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			}
 			break;
 		case XDP_REDIRECT:
+			enetc_unlock_mdio();
 			err = xdp_do_redirect(rx_ring->ndev, &xdp_buff, prog);
+			enetc_lock_mdio();
 			if (unlikely(err)) {
 				enetc_xdp_drop(rx_ring, orig_i, i);
 				rx_ring->stats.xdp_redirect_failures++;
@@ -2028,8 +2040,11 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 	rx_ring->stats.packets += rx_frm_cnt;
 	rx_ring->stats.bytes += rx_byte_cnt;
 
-	if (xdp_redirect_frm_cnt)
+	if (xdp_redirect_frm_cnt) {
+		enetc_unlock_mdio();
 		xdp_do_flush();
+		enetc_lock_mdio();
+	}
 
 	if (xdp_tx_frm_cnt)
 		enetc_update_tx_ring_tail(tx_ring);
@@ -2038,6 +2053,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 		enetc_refill_rx_ring(rx_ring, enetc_bd_unused(rx_ring) -
 				     rx_ring->xdp.xdp_tx_in_flight);
 
+	enetc_unlock_mdio();
+
 	return rx_frm_cnt;
 }
 
@@ -2056,6 +2073,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 	for (i = 0; i < v->count_tx_rings; i++)
 		if (!enetc_clean_tx_ring(&v->tx_ring[i], budget))
 			complete = false;
+	enetc_unlock_mdio();
 
 	prog = rx_ring->xdp.prog;
 	if (prog)
@@ -2067,10 +2085,8 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 	if (work_done)
 		v->rx_napi_work = true;
 
-	if (!complete) {
-		enetc_unlock_mdio();
+	if (!complete)
 		return budget;
-	}
 
 	napi_complete_done(napi, work_done);
 
@@ -2079,6 +2095,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
 
 	v->rx_napi_work = false;
 
+	enetc_lock_mdio();
 	/* enable interrupts */
 	enetc_wr_reg_hot(v->rbier, ENETC_RBIER_RXTIE);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 62e8ee4d2f04..fbc08a18db6d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -67,7 +67,7 @@ struct enetc_lso_t {
 #define ENETC_LSO_MAX_DATA_LEN		SZ_256K
 
 #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
-#define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
+#define ENETC_RXB_TRUESIZE	(PAGE_SIZE >> 1)
 #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
 #define ENETC_RXB_DMA_SIZE	\
 	(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - ENETC_RXB_PAD)
diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
index 65302c41bfb1..38875c196cb6 100644
--- a/drivers/net/ethernet/hisilicon/Kconfig
+++ b/drivers/net/ethernet/hisilicon/Kconfig
@@ -148,6 +148,7 @@ config HIBMCGE
 	tristate "Hisilicon BMC Gigabit Ethernet Device Support"
 	depends on PCI && PCI_MSI
 	select PHYLIB
+	select FIXED_PHY
 	select MOTORCOMM_PHY
 	select REALTEK_PHY
 	help
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 3cca06a74cf9..06e1a04e693f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -99,7 +99,7 @@ u8 mlx5e_mpwrq_umr_entry_size(enum mlx5e_mpwrq_umr_mode mode)
 		return sizeof(struct mlx5_ksm) * 4;
 	}
 	WARN_ONCE(1, "MPWRQ UMR mode %d is not known\n", mode);
-	return 0;
+	return 1;
 }
 
 u8 mlx5e_mpwrq_log_wqe_sz(struct mlx5_core_dev *mdev, u8 page_shift,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index 5d7c15abfcaf..f8eaaf37963b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -342,6 +342,7 @@ void mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
 void mlx5e_ipsec_handle_mpv_event(int event, struct mlx5e_priv *slave_priv,
 				  struct mlx5e_priv *master_priv);
 void mlx5e_ipsec_send_event(struct mlx5e_priv *priv, int event);
+void mlx5e_ipsec_disable_events(struct mlx5e_priv *priv);
 
 static inline struct mlx5_core_dev *
 mlx5e_ipsec_sa2dev(struct mlx5e_ipsec_sa_entry *sa_entry)
@@ -387,6 +388,10 @@ static inline void mlx5e_ipsec_handle_mpv_event(int event, struct mlx5e_priv *sl
 static inline void mlx5e_ipsec_send_event(struct mlx5e_priv *priv, int event)
 {
 }
+
+static inline void mlx5e_ipsec_disable_events(struct mlx5e_priv *priv)
+{
+}
 #endif
 
 #endif	/* __MLX5E_IPSEC_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 9e2365253563..f1297b5a0408 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -2869,9 +2869,30 @@ void mlx5e_ipsec_handle_mpv_event(int event, struct mlx5e_priv *slave_priv,
 
 void mlx5e_ipsec_send_event(struct mlx5e_priv *priv, int event)
 {
-	if (!priv->ipsec)
-		return; /* IPsec not supported */
+	if (!priv->ipsec || mlx5_devcom_comp_get_size(priv->devcom) < 2)
+		return; /* IPsec not supported or no peers */
 
 	mlx5_devcom_send_event(priv->devcom, event, event, priv);
 	wait_for_completion(&priv->ipsec->comp);
 }
+
+void mlx5e_ipsec_disable_events(struct mlx5e_priv *priv)
+{
+	struct mlx5_devcom_comp_dev *tmp = NULL;
+	struct mlx5e_priv *peer_priv;
+
+	if (!priv->devcom)
+		return;
+
+	if (!mlx5_devcom_for_each_peer_begin(priv->devcom))
+		goto out;
+
+	peer_priv = mlx5_devcom_get_next_peer_data(priv->devcom, &tmp);
+	if (peer_priv)
+		complete_all(&peer_priv->ipsec->comp);
+
+	mlx5_devcom_for_each_peer_end(priv->devcom);
+out:
+	mlx5_devcom_unregister_component(priv->devcom);
+	priv->devcom = NULL;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 21bb88c5d3dc..8a63e62938e7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -261,6 +261,7 @@ static void mlx5e_devcom_cleanup_mpv(struct mlx5e_priv *priv)
 	}
 
 	mlx5_devcom_unregister_component(priv->devcom);
+	priv->devcom = NULL;
 }
 
 static int blocking_event(struct notifier_block *nb, unsigned long event, void *data)
@@ -6068,6 +6069,7 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 	if (mlx5e_monitor_counter_supported(priv))
 		mlx5e_monitor_counter_cleanup(priv);
 
+	mlx5e_ipsec_disable_events(priv);
 	mlx5e_disable_blocking_events(priv);
 	mlx5e_disable_async_events(priv);
 	mlx5_lag_remove_netdev(mdev, priv->netdev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b8c609d91d11..5dbf48da2f4f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1773,14 +1773,27 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 	}
 
 	prog = rcu_dereference(rq->xdp_prog);
-	if (prog && mlx5e_xdp_handle(rq, prog, mxbuf)) {
-		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
-			struct mlx5e_wqe_frag_info *pwi;
+	if (prog) {
+		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
+
+		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
+			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT,
+						 rq->flags)) {
+				struct mlx5e_wqe_frag_info *pwi;
+
+				wi -= old_nr_frags - sinfo->nr_frags;
+
+				for (pwi = head_wi; pwi < wi; pwi++)
+					pwi->frag_page->frags++;
+			}
+			return NULL; /* page/packet was consumed by XDP */
+		}
 
-			for (pwi = head_wi; pwi < wi; pwi++)
-				pwi->frag_page->frags++;
+		nr_frags_free = old_nr_frags - sinfo->nr_frags;
+		if (unlikely(nr_frags_free)) {
+			wi -= nr_frags_free;
+			truesize -= nr_frags_free * frag_info->frag_stride;
 		}
-		return NULL; /* page/packet was consumed by XDP */
 	}
 
 	skb = mlx5e_build_linear_skb(
@@ -2004,6 +2017,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u32 byte_cnt       = cqe_bcnt;
 	struct skb_shared_info *sinfo;
 	unsigned int truesize = 0;
+	u32 pg_consumed_bytes;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
 	u32 linear_frame_sz;
@@ -2057,7 +2071,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 	while (byte_cnt) {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
-		u32 pg_consumed_bytes = min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
+		pg_consumed_bytes =
+			min_t(u32, PAGE_SIZE - frag_offset, byte_cnt);
 
 		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 			truesize += pg_consumed_bytes;
@@ -2073,10 +2088,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	}
 
 	if (prog) {
+		u8 nr_frags_free, old_nr_frags = sinfo->nr_frags;
+		u32 len;
+
 		if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 				struct mlx5e_frag_page *pfp;
 
+				frag_page -= old_nr_frags - sinfo->nr_frags;
+
 				for (pfp = head_page; pfp < frag_page; pfp++)
 					pfp->frags++;
 
@@ -2087,9 +2107,19 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
+		nr_frags_free = old_nr_frags - sinfo->nr_frags;
+		if (unlikely(nr_frags_free)) {
+			frag_page -= nr_frags_free;
+			truesize -= (nr_frags_free - 1) * PAGE_SIZE +
+				ALIGN(pg_consumed_bytes,
+				      BIT(rq->mpwqe.log_stride_sz));
+		}
+
+		len = mxbuf->xdp.data_end - mxbuf->xdp.data;
+
 		skb = mlx5e_build_linear_skb(
 			rq, mxbuf->xdp.data_hard_start, linear_frame_sz,
-			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
+			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, len,
 			mxbuf->xdp.data - mxbuf->xdp.data_meta);
 		if (unlikely(!skb)) {
 			mlx5e_page_release_fragmented(rq->page_pool,
@@ -2114,8 +2144,11 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			do
 				pagep->frags++;
 			while (++pagep < frag_page);
+
+			headlen = min_t(u16, MLX5E_RX_MAX_HEAD - len,
+					skb->data_len);
+			__pskb_pull_tail(skb, headlen);
 		}
-		__pskb_pull_tail(skb, headlen);
 	} else {
 		dma_addr_t addr;
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 94b6fb94f8f1..f32f559bf6bf 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2210,15 +2210,35 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 		skb_tx_timestamp(skb);
 	}
-	/* Descriptor type must be set after all the above writes */
-	dma_wmb();
+
 	if (num_tx_desc > 1) {
 		desc->die_dt = DT_FEND;
 		desc--;
+		/* When using multi-descriptors, DT_FEND needs to get written
+		 * before DT_FSTART, but the compiler may reorder the memory
+		 * writes in an attempt to optimize the code.
+		 * Use a dma_wmb() barrier to make sure DT_FEND and DT_FSTART
+		 * are written exactly in the order shown in the code.
+		 * This is particularly important for cases where the DMA engine
+		 * is already running when we are running this code. If the DMA
+		 * sees DT_FSTART without the corresponding DT_FEND it will enter
+		 * an error condition.
+		 */
+		dma_wmb();
 		desc->die_dt = DT_FSTART;
 	} else {
+		/* Descriptor type must be set after all the above writes */
+		dma_wmb();
 		desc->die_dt = DT_FSINGLE;
 	}
+
+	/* Before ringing the doorbell we need to make sure that the latest
+	 * writes have been committed to memory, otherwise it could delay
+	 * things until the doorbell is rang again.
+	 * This is in replacement of the read operation mentioned in the HW
+	 * manuals.
+	 */
+	dma_wmb();
 	ravb_modify(ndev, TCCR, TCCR_TSRQ0 << q, TCCR_TSRQ0 << q);
 
 	priv->cur_tx[q] += num_tx_desc;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index f6687c2f30f6..8ca75ab76897 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1448,14 +1448,15 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 		}
 	} else {
 		if (bsp_priv->clk_enabled) {
+			if (bsp_priv->ops && bsp_priv->ops->set_clock_selection) {
+				bsp_priv->ops->set_clock_selection(bsp_priv,
+					      bsp_priv->clock_input, false);
+			}
+
 			clk_bulk_disable_unprepare(bsp_priv->num_clks,
 						   bsp_priv->clks);
 			clk_disable_unprepare(bsp_priv->clk_phy);
 
-			if (bsp_priv->ops && bsp_priv->ops->set_clock_selection)
-				bsp_priv->ops->set_clock_selection(bsp_priv,
-					      bsp_priv->clock_input, false);
-
 			bsp_priv->clk_enabled = false;
 		}
 	}
diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index 59d6ab989c55..8ffbfaa3ab18 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -163,7 +163,9 @@ struct am65_cpts {
 	struct device_node *clk_mux_np;
 	struct clk *refclk;
 	u32 refclk_freq;
-	struct list_head events;
+	/* separate lists to handle TX and RX timestamp independently */
+	struct list_head events_tx;
+	struct list_head events_rx;
 	struct list_head pool;
 	struct am65_cpts_event pool_data[AM65_CPTS_MAX_EVENTS];
 	spinlock_t lock; /* protects events lists*/
@@ -227,6 +229,24 @@ static void am65_cpts_disable(struct am65_cpts *cpts)
 	am65_cpts_write32(cpts, 0, int_enable);
 }
 
+static int am65_cpts_purge_event_list(struct am65_cpts *cpts,
+				      struct list_head *events)
+{
+	struct list_head *this, *next;
+	struct am65_cpts_event *event;
+	int removed = 0;
+
+	list_for_each_safe(this, next, events) {
+		event = list_entry(this, struct am65_cpts_event, list);
+		if (time_after(jiffies, event->tmo)) {
+			list_del_init(&event->list);
+			list_add(&event->list, &cpts->pool);
+			++removed;
+		}
+	}
+	return removed;
+}
+
 static int am65_cpts_event_get_port(struct am65_cpts_event *event)
 {
 	return (event->event1 & AM65_CPTS_EVENT_1_PORT_NUMBER_MASK) >>
@@ -239,20 +259,12 @@ static int am65_cpts_event_get_type(struct am65_cpts_event *event)
 		AM65_CPTS_EVENT_1_EVENT_TYPE_SHIFT;
 }
 
-static int am65_cpts_cpts_purge_events(struct am65_cpts *cpts)
+static int am65_cpts_purge_events(struct am65_cpts *cpts)
 {
-	struct list_head *this, *next;
-	struct am65_cpts_event *event;
 	int removed = 0;
 
-	list_for_each_safe(this, next, &cpts->events) {
-		event = list_entry(this, struct am65_cpts_event, list);
-		if (time_after(jiffies, event->tmo)) {
-			list_del_init(&event->list);
-			list_add(&event->list, &cpts->pool);
-			++removed;
-		}
-	}
+	removed += am65_cpts_purge_event_list(cpts, &cpts->events_tx);
+	removed += am65_cpts_purge_event_list(cpts, &cpts->events_rx);
 
 	if (removed)
 		dev_dbg(cpts->dev, "event pool cleaned up %d\n", removed);
@@ -287,7 +299,7 @@ static int __am65_cpts_fifo_read(struct am65_cpts *cpts)
 						 struct am65_cpts_event, list);
 
 		if (!event) {
-			if (am65_cpts_cpts_purge_events(cpts)) {
+			if (am65_cpts_purge_events(cpts)) {
 				dev_err(cpts->dev, "cpts: event pool empty\n");
 				ret = -1;
 				goto out;
@@ -306,11 +318,21 @@ static int __am65_cpts_fifo_read(struct am65_cpts *cpts)
 				cpts->timestamp);
 			break;
 		case AM65_CPTS_EV_RX:
+			event->tmo = jiffies +
+				msecs_to_jiffies(AM65_CPTS_EVENT_RX_TX_TIMEOUT);
+
+			list_move_tail(&event->list, &cpts->events_rx);
+
+			dev_dbg(cpts->dev,
+				"AM65_CPTS_EV_RX e1:%08x e2:%08x t:%lld\n",
+				event->event1, event->event2,
+				event->timestamp);
+			break;
 		case AM65_CPTS_EV_TX:
 			event->tmo = jiffies +
 				msecs_to_jiffies(AM65_CPTS_EVENT_RX_TX_TIMEOUT);
 
-			list_move_tail(&event->list, &cpts->events);
+			list_move_tail(&event->list, &cpts->events_tx);
 
 			dev_dbg(cpts->dev,
 				"AM65_CPTS_EV_TX e1:%08x e2:%08x t:%lld\n",
@@ -828,7 +850,7 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
 	return found;
 }
 
-static void am65_cpts_find_ts(struct am65_cpts *cpts)
+static void am65_cpts_find_tx_ts(struct am65_cpts *cpts)
 {
 	struct am65_cpts_event *event;
 	struct list_head *this, *next;
@@ -837,7 +859,7 @@ static void am65_cpts_find_ts(struct am65_cpts *cpts)
 	LIST_HEAD(events);
 
 	spin_lock_irqsave(&cpts->lock, flags);
-	list_splice_init(&cpts->events, &events);
+	list_splice_init(&cpts->events_tx, &events);
 	spin_unlock_irqrestore(&cpts->lock, flags);
 
 	list_for_each_safe(this, next, &events) {
@@ -850,7 +872,7 @@ static void am65_cpts_find_ts(struct am65_cpts *cpts)
 	}
 
 	spin_lock_irqsave(&cpts->lock, flags);
-	list_splice_tail(&events, &cpts->events);
+	list_splice_tail(&events, &cpts->events_tx);
 	list_splice_tail(&events_free, &cpts->pool);
 	spin_unlock_irqrestore(&cpts->lock, flags);
 }
@@ -861,7 +883,7 @@ static long am65_cpts_ts_work(struct ptp_clock_info *ptp)
 	unsigned long flags;
 	long delay = -1;
 
-	am65_cpts_find_ts(cpts);
+	am65_cpts_find_tx_ts(cpts);
 
 	spin_lock_irqsave(&cpts->txq.lock, flags);
 	if (!skb_queue_empty(&cpts->txq))
@@ -905,7 +927,7 @@ static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, u32 skb_mtype_seqid)
 
 	spin_lock_irqsave(&cpts->lock, flags);
 	__am65_cpts_fifo_read(cpts);
-	list_for_each_safe(this, next, &cpts->events) {
+	list_for_each_safe(this, next, &cpts->events_rx) {
 		event = list_entry(this, struct am65_cpts_event, list);
 		if (time_after(jiffies, event->tmo)) {
 			list_move(&event->list, &cpts->pool);
@@ -1155,7 +1177,8 @@ struct am65_cpts *am65_cpts_create(struct device *dev, void __iomem *regs,
 		return ERR_PTR(ret);
 
 	mutex_init(&cpts->ptp_clk_lock);
-	INIT_LIST_HEAD(&cpts->events);
+	INIT_LIST_HEAD(&cpts->events_tx);
+	INIT_LIST_HEAD(&cpts->events_rx);
 	INIT_LIST_HEAD(&cpts->pool);
 	spin_lock_init(&cpts->lock);
 	skb_queue_head_init(&cpts->txq);
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 289f62c5d2c7..0d7f30360d87 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -560,16 +560,34 @@ static void ovpn_tcp_close(struct sock *sk, long timeout)
 static __poll_t ovpn_tcp_poll(struct file *file, struct socket *sock,
 			      poll_table *wait)
 {
-	__poll_t mask = datagram_poll(file, sock, wait);
+	struct sk_buff_head *queue = &sock->sk->sk_receive_queue;
 	struct ovpn_socket *ovpn_sock;
+	struct ovpn_peer *peer = NULL;
+	__poll_t mask;
 
 	rcu_read_lock();
 	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
-	if (ovpn_sock && ovpn_sock->peer &&
-	    !skb_queue_empty(&ovpn_sock->peer->tcp.user_queue))
-		mask |= EPOLLIN | EPOLLRDNORM;
+	/* if we landed in this callback, we expect to have a
+	 * meaningful state. The ovpn_socket lifecycle would
+	 * prevent it otherwise.
+	 */
+	if (WARN(!ovpn_sock || !ovpn_sock->peer,
+		 "ovpn: null state in ovpn_tcp_poll!")) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	if (ovpn_peer_hold(ovpn_sock->peer)) {
+		peer = ovpn_sock->peer;
+		queue = &peer->tcp.user_queue;
+	}
 	rcu_read_unlock();
 
+	mask = datagram_poll_queue(file, sock, wait, queue);
+
+	if (peer)
+		ovpn_peer_put(peer);
+
 	return mask;
 }
 
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 605b0315b4cb..99f8374fd32a 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4109,6 +4109,8 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 {
 	struct lan8814_shared_priv *shared = phy_package_get_priv(phydev);
 
+	shared->phydev = phydev;
+
 	/* Initialise shared lock for clock*/
 	mutex_init(&shared->shared_lock);
 
@@ -4164,8 +4166,6 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
 
 	phydev_dbg(phydev, "successfully registered ptp clock\n");
 
-	shared->phydev = phydev;
-
 	/* The EP.4 is shared between all the PHYs in the package and also it
 	 * can be accessed by any of the PHYs
 	 */
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 64af3b96f028..62ef87ecc558 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -156,7 +156,7 @@
 #define RTL_8211FVD_PHYID			0x001cc878
 #define RTL_8221B				0x001cc840
 #define RTL_8221B_VB_CG				0x001cc849
-#define RTL_8221B_VN_CG				0x001cc84a
+#define RTL_8221B_VM_CG				0x001cc84a
 #define RTL_8251B				0x001cc862
 #define RTL_8261C				0x001cc890
 
@@ -1362,16 +1362,16 @@ static int rtl8221b_vb_cg_c45_match_phy_device(struct phy_device *phydev,
 	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, true);
 }
 
-static int rtl8221b_vn_cg_c22_match_phy_device(struct phy_device *phydev,
+static int rtl8221b_vm_cg_c22_match_phy_device(struct phy_device *phydev,
 					       const struct phy_driver *phydrv)
 {
-	return rtlgen_is_c45_match(phydev, RTL_8221B_VN_CG, false);
+	return rtlgen_is_c45_match(phydev, RTL_8221B_VM_CG, false);
 }
 
-static int rtl8221b_vn_cg_c45_match_phy_device(struct phy_device *phydev,
+static int rtl8221b_vm_cg_c45_match_phy_device(struct phy_device *phydev,
 					       const struct phy_driver *phydrv)
 {
-	return rtlgen_is_c45_match(phydev, RTL_8221B_VN_CG, true);
+	return rtlgen_is_c45_match(phydev, RTL_8221B_VM_CG, true);
 }
 
 static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev,
@@ -1718,7 +1718,7 @@ static struct phy_driver realtek_drvs[] = {
 		.suspend        = genphy_c45_pma_suspend,
 		.resume         = rtlgen_c45_resume,
 	}, {
-		.match_phy_device = rtl8221b_vn_cg_c22_match_phy_device,
+		.match_phy_device = rtl8221b_vm_cg_c22_match_phy_device,
 		.name           = "RTL8221B-VM-CG 2.5Gbps PHY (C22)",
 		.probe		= rtl822x_probe,
 		.get_features   = rtl822x_get_features,
@@ -1731,8 +1731,8 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 	}, {
-		.match_phy_device = rtl8221b_vn_cg_c45_match_phy_device,
-		.name           = "RTL8221B-VN-CG 2.5Gbps PHY (C45)",
+		.match_phy_device = rtl8221b_vm_cg_c45_match_phy_device,
+		.name           = "RTL8221B-VM-CG 2.5Gbps PHY (C45)",
 		.probe		= rtl822x_probe,
 		.config_init    = rtl822xb_config_init,
 		.get_rate_matching = rtl822xb_get_rate_matching,
diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 92add3daadbb..278e6cb6f4d9 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -685,9 +685,16 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 	rtl8150_t *dev = netdev_priv(netdev);
 	int count, res;
 
+	/* pad the frame and ensure terminating USB packet, datasheet 9.2.3 */
+	count = max(skb->len, ETH_ZLEN);
+	if (count % 64 == 0)
+		count++;
+	if (skb_padto(skb, count)) {
+		netdev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
+
 	netif_stop_queue(netdev);
-	count = (skb->len < 60) ? 60 : skb->len;
-	count = (count & 0x3f) ? count : count + 1;
 	dev->tx_skb = skb;
 	usb_fill_bulk_urb(dev->tx_urb, dev->udev, usb_sndbulkpipe(dev->udev, 2),
 		      skb->data, count, write_bulk_callback, dev);
diff --git a/drivers/nvmem/rcar-efuse.c b/drivers/nvmem/rcar-efuse.c
index f24bdb9cb5a7..d9a96a1d59c8 100644
--- a/drivers/nvmem/rcar-efuse.c
+++ b/drivers/nvmem/rcar-efuse.c
@@ -127,6 +127,7 @@ static const struct of_device_id rcar_fuse_match[] = {
 	{ .compatible = "renesas,r8a779h0-otp", .data = &rcar_fuse_v4m },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, rcar_fuse_match);
 
 static struct platform_driver rcar_fuse_driver = {
 	.probe = rcar_fuse_probe,
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 74aaea61de13..3d4afeeb30ed 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -670,16 +670,47 @@ void __init of_irq_init(const struct of_device_id *matches)
 	}
 }
 
+static int of_check_msi_parent(struct device_node *dev_node, struct device_node **msi_node)
+{
+	struct of_phandle_args msi_spec;
+	int ret;
+
+	/*
+	 * An msi-parent phandle with a missing or == 0 #msi-cells
+	 * property identifies a 1:1 ID translation mapping.
+	 *
+	 * Set the msi controller node if the firmware matches this
+	 * condition.
+	 */
+	ret = of_parse_phandle_with_optional_args(dev_node, "msi-parent", "#msi-cells",
+						  0, &msi_spec);
+	if (ret)
+		return ret;
+
+	if ((*msi_node && *msi_node != msi_spec.np) || msi_spec.args_count != 0)
+		ret = -EINVAL;
+
+	if (!ret) {
+		/* Return with a node reference held */
+		*msi_node = msi_spec.np;
+		return 0;
+	}
+	of_node_put(msi_spec.np);
+
+	return ret;
+}
+
 /**
  * of_msi_xlate - map a MSI ID and find relevant MSI controller node
  * @dev: device for which the mapping is to be done.
- * @msi_np: Pointer to store the MSI controller node
+ * @msi_np: Pointer to target MSI controller node
  * @id_in: Device ID.
  *
  * Walk up the device hierarchy looking for devices with a "msi-map"
- * property. If found, apply the mapping to @id_in. @msi_np pointed
- * value must be NULL on entry, if an MSI controller is found @msi_np is
- * initialized to the MSI controller node with a reference held.
+ * or "msi-parent" property. If found, apply the mapping to @id_in.
+ * If @msi_np points to a non-NULL device node pointer, only entries targeting
+ * that node will be matched; if it points to a NULL value, it will receive the
+ * device node of the first matching target phandle, with a reference held.
  *
  * Returns: The mapped MSI id.
  */
@@ -690,31 +721,18 @@ u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in)
 
 	/*
 	 * Walk up the device parent links looking for one with a
-	 * "msi-map" property.
+	 * "msi-map" or an "msi-parent" property.
 	 */
-	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent)
+	for (parent_dev = dev; parent_dev; parent_dev = parent_dev->parent) {
 		if (!of_map_id(parent_dev->of_node, id_in, "msi-map",
 				"msi-map-mask", msi_np, &id_out))
 			break;
+		if (!of_check_msi_parent(parent_dev->of_node, msi_np))
+			break;
+	}
 	return id_out;
 }
 
-/**
- * of_msi_map_id - Map a MSI ID for a device.
- * @dev: device for which the mapping is to be done.
- * @msi_np: device node of the expected msi controller.
- * @id_in: unmapped MSI ID for the device.
- *
- * Walk up the device hierarchy looking for devices with a "msi-map"
- * property.  If found, apply the mapping to @id_in.
- *
- * Return: The mapped MSI ID.
- */
-u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in)
-{
-	return of_msi_xlate(dev, &msi_np, id_in);
-}
-
 /**
  * of_msi_map_get_device_domain - Use msi-map to find the relevant MSI domain
  * @dev: device for which the mapping is to be done.
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index b11b7f63f0d6..cbdc83c064d4 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -479,7 +479,7 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
 
 	of_node = irq_domain_get_of_node(domain);
-	rid = of_node ? of_msi_map_id(&pdev->dev, of_node, rid) :
+	rid = of_node ? of_msi_xlate(&pdev->dev, &of_node, rid) :
 			iort_msi_map_id(&pdev->dev, rid);
 
 	return rid;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0f4d98036cd..005b92e6585e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5932,6 +5932,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 {
 	u16 v;
 	int ret;
+	unsigned int firstbit;
 	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
 
 	if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
@@ -5949,7 +5950,10 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
 			rq = mps;
 	}
 
-	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
+	firstbit = ffs(rq);
+	if (firstbit < 8)
+		return -EINVAL;
+	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, firstbit - 8);
 
 	if (bridge->no_inc_mrrs) {
 		int max_mrrs = pcie_get_readrq(dev);
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index a449651f79c9..6594d64b03a9 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -234,7 +234,7 @@ int hisi_uncore_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	hisi_pmu = to_hisi_pmu(event->pmu);
-	if (event->attr.config > hisi_pmu->check_event)
+	if ((event->attr.config & HISI_EVENTID_MASK) > hisi_pmu->check_event)
 		return -EINVAL;
 
 	if (hisi_pmu->on_cpu == -1)
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index 777675838b80..e69660f72be6 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -43,7 +43,8 @@
 		return FIELD_GET(GENMASK_ULL(hi, lo), event->attr.config);  \
 	}
 
-#define HISI_GET_EVENTID(ev) (ev->hw.config_base & 0xff)
+#define HISI_EVENTID_MASK		GENMASK(7, 0)
+#define HISI_GET_EVENTID(ev)		((ev)->hw.config_base & HISI_EVENTID_MASK)
 
 #define HISI_PMU_EVTYPE_BITS		8
 #define HISI_PMU_EVTYPE_SHIFT(idx)	((idx) % 4 * HISI_PMU_EVTYPE_BITS)
diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 4776013e0764..16a2fd9fdd9b 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -2015,6 +2015,7 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
 	if (pmc->block[blk_num].type == MLXBF_PMC_TYPE_CRSPACE) {
 		/* Program crspace counters to count clock cycles using "count_clock" sysfs */
 		attr = &pmc->block[blk_num].attr_count_clock;
+		sysfs_attr_init(&attr->dev_attr.attr);
 		attr->dev_attr.attr.mode = 0644;
 		attr->dev_attr.show = mlxbf_pmc_count_clock_show;
 		attr->dev_attr.store = mlxbf_pmc_count_clock_store;
diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 31f9643a6a3b..f417dcc9af35 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -209,6 +209,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &g_series_quirks,
 	},
+	{
+		.ident = "Dell Inc. G15 5530",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5530"),
+		},
+		.driver_data = &g_series_quirks,
+	},
 	{
 		.ident = "Dell Inc. G16 7630",
 		.matches = {
@@ -1639,7 +1647,7 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
 
 static int wmax_wmi_suspend(struct device *dev)
 {
-	if (awcc->hwmon)
+	if (awcc && awcc->hwmon)
 		awcc_hwmon_suspend(dev);
 
 	return 0;
@@ -1647,7 +1655,7 @@ static int wmax_wmi_suspend(struct device *dev)
 
 static int wmax_wmi_resume(struct device *dev)
 {
-	if (awcc->hwmon)
+	if (awcc && awcc->hwmon)
 		awcc_hwmon_resume(dev);
 
 	return 0;
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 4e1286ce05c9..f354f2f51a48 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2550,7 +2550,7 @@ ptp_ocp_sma_fb_init(struct ptp_ocp *bp)
 		for (i = 0; i < OCP_SMA_NUM; i++) {
 			bp->sma[i].fixed_fcn = true;
 			bp->sma[i].fixed_dir = true;
-			bp->sma[1].dpll_prop.capabilities &=
+			bp->sma[i].dpll_prop.capabilities &=
 				~DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE;
 		}
 		return;
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 3bf09a89a089..e92e2fd8ce5d 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -1405,7 +1405,9 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 	/* Step 3: import the encrypted key value as a new key */
 	rc = ep11_unwrapkey(card, domain, kek, keklen,
 			    encbuf, encbuflen, 0, def_iv,
-			    keybitsize, 0, keybuf, keybufsize, keytype, xflags);
+			    keybitsize, keygenflags,
+			    keybuf, keybufsize,
+			    keytype, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s importing key value as new key failed, rc=%d\n",
 			       __func__, rc);
diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index dbe640986825..b78163eaed61 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -192,6 +192,14 @@
 #define SPI_NAND_OP_RESET			0xff
 #define SPI_NAND_OP_DIE_SELECT			0xc2
 
+/* SNAND FIFO commands */
+#define SNAND_FIFO_TX_BUSWIDTH_SINGLE		0x08
+#define SNAND_FIFO_TX_BUSWIDTH_DUAL		0x09
+#define SNAND_FIFO_TX_BUSWIDTH_QUAD		0x0a
+#define SNAND_FIFO_RX_BUSWIDTH_SINGLE		0x0c
+#define SNAND_FIFO_RX_BUSWIDTH_DUAL		0x0e
+#define SNAND_FIFO_RX_BUSWIDTH_QUAD		0x0f
+
 #define SPI_NAND_CACHE_SIZE			(SZ_4K + SZ_256)
 #define SPI_MAX_TRANSFER_SIZE			511
 
@@ -387,10 +395,26 @@ static int airoha_snand_set_mode(struct airoha_snand_ctrl *as_ctrl,
 	return regmap_write(as_ctrl->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
 }
 
-static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
-				   const u8 *data, int len)
+static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl,
+				   const u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
@@ -409,16 +433,32 @@ static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
 	return 0;
 }
 
-static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, u8 *data,
-				  int len)
+static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl,
+				  u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
 		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
-		err = airoha_snand_set_fifo_op(as_ctrl, 0xc, data_len);
+		err = airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
 		if (err)
 			return err;
 
@@ -618,6 +658,10 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
+	/* continuous reading is not supported */
+	if (desc->info.length > SPI_NAND_CACHE_SIZE)
+		return -E2BIG;
+
 	if (!airoha_snand_supports_op(desc->mem, &desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
@@ -654,13 +698,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	err = airoha_snand_nfi_config(as_ctrl);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
 				  DMA_FROM_DEVICE);
 	err = dma_mapping_error(as_ctrl->dev, dma_addr);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
 	/* set dma addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
@@ -689,8 +733,9 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set read addr */
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3, 0x0);
+	/* set read addr: zero page offset + descriptor read offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3,
+			   desc->info.offset);
 	if (err)
 		goto error_dma_unmap;
 
@@ -760,6 +805,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_FROM_DEVICE);
+error_dma_mode_off:
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
 
@@ -824,7 +871,9 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2, 0x0);
+	/* set write addr: zero page offset + descriptor write offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2,
+			   desc->info.offset);
 	if (err)
 		goto error_dma_unmap;
 
@@ -892,18 +941,35 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_TO_DEVICE);
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
 
 static int airoha_snand_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	u8 data[8], cmd, opcode = op->cmd.opcode;
 	struct airoha_snand_ctrl *as_ctrl;
+	int op_len, addr_len, dummy_len;
+	u8 buf[20], *data;
 	int i, err;
 
 	as_ctrl = spi_controller_get_devdata(mem->spi->controller);
 
+	op_len = op->cmd.nbytes;
+	addr_len = op->addr.nbytes;
+	dummy_len = op->dummy.nbytes;
+
+	if (op_len + dummy_len + addr_len > sizeof(buf))
+		return -EIO;
+
+	data = buf;
+	for (i = 0; i < op_len; i++)
+		*data++ = op->cmd.opcode >> (8 * (op_len - i - 1));
+	for (i = 0; i < addr_len; i++)
+		*data++ = op->addr.val >> (8 * (addr_len - i - 1));
+	for (i = 0; i < dummy_len; i++)
+		*data++ = 0xff;
+
 	/* switch to manual mode */
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	if (err < 0)
@@ -914,40 +980,40 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 		return err;
 
 	/* opcode */
-	err = airoha_snand_write_data(as_ctrl, 0x8, &opcode, sizeof(opcode));
+	data = buf;
+	err = airoha_snand_write_data(as_ctrl, data, op_len,
+				      op->cmd.buswidth);
 	if (err)
 		return err;
 
 	/* addr part */
-	cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
-	put_unaligned_be64(op->addr.val, data);
-
-	for (i = ARRAY_SIZE(data) - op->addr.nbytes;
-	     i < ARRAY_SIZE(data); i++) {
-		err = airoha_snand_write_data(as_ctrl, cmd, &data[i],
-					      sizeof(data[0]));
+	data += op_len;
+	if (addr_len) {
+		err = airoha_snand_write_data(as_ctrl, data, addr_len,
+					      op->addr.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* dummy */
-	data[0] = 0xff;
-	for (i = 0; i < op->dummy.nbytes; i++) {
-		err = airoha_snand_write_data(as_ctrl, 0x8, &data[0],
-					      sizeof(data[0]));
+	data += addr_len;
+	if (dummy_len) {
+		err = airoha_snand_write_data(as_ctrl, data, dummy_len,
+					      op->dummy.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* data */
-	if (op->data.dir == SPI_MEM_DATA_IN) {
-		err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
-					     op->data.nbytes);
-		if (err)
-			return err;
-	} else {
-		err = airoha_snand_write_data(as_ctrl, 0x8, op->data.buf.out,
-					      op->data.nbytes);
+	if (op->data.nbytes) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
+						     op->data.nbytes,
+						     op->data.buswidth);
+		else
+			err = airoha_snand_write_data(as_ctrl, op->data.buf.out,
+						      op->data.nbytes,
+						      op->data.buswidth);
 		if (err)
 			return err;
 	}
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index d1a59120d384..ce0f605ab688 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1995,7 +1995,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (cqspi->use_direct_mode) {
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER)
-			goto probe_setup_failed;
+			goto probe_dma_failed;
 	}
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
@@ -2019,9 +2019,10 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	return 0;
 probe_setup_failed:
-	cqspi_controller_enable(cqspi, 0);
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
 		pm_runtime_disable(dev);
+probe_dma_failed:
+	cqspi_controller_enable(cqspi, 0);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index b92bfef47371..ab13f11242c3 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -399,8 +399,13 @@ struct nxp_fspi {
 	struct mutex lock;
 	struct pm_qos_request pm_qos_req;
 	int selected;
-#define FSPI_NEED_INIT		(1 << 0)
+#define FSPI_NEED_INIT		BIT(0)
+#define FSPI_DTR_MODE		BIT(1)
 	int flags;
+	/* save the previous operation clock rate */
+	unsigned long pre_op_rate;
+	/* the max clock rate fspi output to device */
+	unsigned long max_rate;
 };
 
 static inline int needs_ip_only(struct nxp_fspi *f)
@@ -645,6 +650,43 @@ static void nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
 	return;
 }
 
+/*
+ * Sample Clock source selection for Flash Reading
+ * Four modes defined by fspi:
+ * mode 0: Dummy Read strobe generated by FlexSPI Controller
+ *         and loopback internally
+ * mode 1: Dummy Read strobe generated by FlexSPI Controller
+ *         and loopback from DQS pad
+ * mode 2: Reserved
+ * mode 3: Flash provided Read strobe and input from DQS pad
+ *
+ * fspi default use mode 0 after reset
+ */
+static void nxp_fspi_select_rx_sample_clk_source(struct nxp_fspi *f,
+						 bool op_is_dtr)
+{
+	u32 reg;
+
+	/*
+	 * For 8D-8D-8D mode, need to use mode 3 (Flash provided Read
+	 * strobe and input from DQS pad), otherwise read operaton may
+	 * meet issue.
+	 * This mode require flash device connect the DQS pad on board.
+	 * For other modes, still use mode 0, keep align with before.
+	 * spi_nor_suspend will disable 8D-8D-8D mode, also need to
+	 * change the mode back to mode 0.
+	 */
+	reg = fspi_readl(f, f->iobase + FSPI_MCR0);
+	if (op_is_dtr) {
+		reg |= FSPI_MCR0_RXCLKSRC(3);
+		f->max_rate = 166000000;
+	} else {	/*select mode 0 */
+		reg &= ~FSPI_MCR0_RXCLKSRC(3);
+		f->max_rate = 66000000;
+	}
+	fspi_writel(f, reg, f->iobase + FSPI_MCR0);
+}
+
 static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
 {
 	int ret;
@@ -672,6 +714,12 @@ static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
 				   0, POLL_TOUT, true);
 	if (ret)
 		dev_warn(f->dev, "DLL lock failed, please fix it!\n");
+
+	/*
+	 * For ERR050272, DLL lock status bit is not accurate,
+	 * wait for 4us more as a workaround.
+	 */
+	udelay(4);
 }
 
 /*
@@ -715,15 +763,24 @@ static void nxp_fspi_dll_calibration(struct nxp_fspi *f)
 static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 				const struct spi_mem_op *op)
 {
+	/* flexspi only support one DTR mode: 8D-8D-8D */
+	bool op_is_dtr = op->cmd.dtr && op->addr.dtr && op->dummy.dtr && op->data.dtr;
 	unsigned long rate = op->max_freq;
 	int ret;
 	uint64_t size_kb;
 
 	/*
-	 * Return, if previously selected target device is same as current
-	 * requested target device.
+	 * Return when following condition all meet,
+	 * 1, if previously selected target device is same as current
+	 *    requested target device.
+	 * 2, the DTR or STR mode do not change.
+	 * 3, previous operation max rate equals current one.
+	 *
+	 * For other case, need to re-config.
 	 */
-	if (f->selected == spi_get_chipselect(spi, 0))
+	if ((f->selected == spi_get_chipselect(spi, 0)) &&
+	    (!!(f->flags & FSPI_DTR_MODE) == op_is_dtr) &&
+	    (f->pre_op_rate == op->max_freq))
 		return;
 
 	/* Reset FLSHxxCR0 registers */
@@ -740,6 +797,19 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 
 	dev_dbg(f->dev, "Target device [CS:%x] selected\n", spi_get_chipselect(spi, 0));
 
+	nxp_fspi_select_rx_sample_clk_source(f, op_is_dtr);
+	rate = min(f->max_rate, op->max_freq);
+
+	if (op_is_dtr) {
+		f->flags |= FSPI_DTR_MODE;
+		/* For DTR mode, flexspi will default div 2 and output to device.
+		 * so here to config the root clock to 2 * device rate.
+		 */
+		rate = rate * 2;
+	} else {
+		f->flags &= ~FSPI_DTR_MODE;
+	}
+
 	nxp_fspi_clk_disable_unprep(f);
 
 	ret = clk_set_rate(f->clk, rate);
@@ -757,6 +827,8 @@ static void nxp_fspi_select_mem(struct nxp_fspi *f, struct spi_device *spi,
 	if (rate > 100000000)
 		nxp_fspi_dll_calibration(f);
 
+	f->pre_op_rate = op->max_freq;
+
 	f->selected = spi_get_chipselect(spi, 0);
 }
 
diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 9eba5c0a60f2..b3c2b03b1153 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -704,7 +704,12 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 			ret = -ENOMEM;
 			goto err_dma;
 		}
-		sfc->dma_buffer = virt_to_phys(sfc->buffer);
+		sfc->dma_buffer = dma_map_single(dev, sfc->buffer,
+					    sfc->max_iosize, DMA_BIDIRECTIONAL);
+		if (dma_mapping_error(dev, sfc->dma_buffer)) {
+			ret = -ENOMEM;
+			goto err_dma_map;
+		}
 	}
 
 	ret = devm_spi_register_controller(dev, host);
@@ -715,6 +720,9 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 
 	return 0;
 err_register:
+	dma_unmap_single(dev, sfc->dma_buffer, sfc->max_iosize,
+			 DMA_BIDIRECTIONAL);
+err_dma_map:
 	free_pages((unsigned long)sfc->buffer, get_order(sfc->max_iosize));
 err_dma:
 	pm_runtime_get_sync(dev);
@@ -736,6 +744,8 @@ static void rockchip_sfc_remove(struct platform_device *pdev)
 	struct spi_controller *host = sfc->host;
 
 	spi_unregister_controller(host);
+	dma_unmap_single(&pdev->dev, sfc->dma_buffer, sfc->max_iosize,
+			 DMA_BIDIRECTIONAL);
 	free_pages((unsigned long)sfc->buffer, get_order(sfc->max_iosize));
 
 	clk_disable_unprepare(sfc->clk);
diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 94bbb3b6576d..01a5bb43cd2d 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -182,10 +182,12 @@ static int agilent_82350b_accel_write(struct gpib_board *board, u8 *buffer,
 		return retval;
 #endif
 
-	retval = agilent_82350b_write(board, buffer, 1, 0, &num_bytes);
-	*bytes_written += num_bytes;
-	if (retval < 0)
-		return retval;
+	if (fifotransferlength > 0) {
+		retval = agilent_82350b_write(board, buffer, 1, 0, &num_bytes);
+		*bytes_written += num_bytes;
+		if (retval < 0)
+			return retval;
+	}
 
 	write_byte(tms_priv, tms_priv->imr0_bits & ~HR_BOIE, IMR0);
 	for (i = 1; i < fifotransferlength;) {
@@ -217,7 +219,7 @@ static int agilent_82350b_accel_write(struct gpib_board *board, u8 *buffer,
 			break;
 	}
 	write_byte(tms_priv, tms_priv->imr0_bits, IMR0);
-	if (retval)
+	if (retval < 0)
 		return retval;
 
 	if (send_eoi) {
diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index 4138f3d2bae7..efce01b39b9b 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -1517,6 +1517,11 @@ void fmh_gpib_detach(struct gpib_board *board)
 					   resource_size(e_priv->gpib_iomem_res));
 	}
 	fmh_gpib_generic_detach(board);
+
+	if (board->dev) {
+		put_device(board->dev);
+		board->dev = NULL;
+	}
 }
 
 static int fmh_gpib_pci_attach_impl(struct gpib_board *board,
diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 73ea72f34c0a..5e543fa95b82 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -327,7 +327,10 @@ static void ni_usb_soft_update_status(struct gpib_board *board, unsigned int ni_
 	board->status &= ~clear_mask;
 	board->status &= ~ni_usb_ibsta_mask;
 	board->status |= ni_usb_ibsta & ni_usb_ibsta_mask;
-	//FIXME should generate events on DTAS and DCAS
+	if (ni_usb_ibsta & DCAS)
+		push_gpib_event(board, EVENT_DEV_CLR);
+	if (ni_usb_ibsta & DTAS)
+		push_gpib_event(board, EVENT_DEV_TRG);
 
 	spin_lock_irqsave(&board->spinlock, flags);
 /* remove set status bits from monitored set why ?***/
@@ -694,8 +697,12 @@ static int ni_usb_read(struct gpib_board *board, u8 *buffer, size_t length,
 		 */
 		break;
 	case NIUSB_ATN_STATE_ERROR:
-		retval = -EIO;
-		dev_err(&usb_dev->dev, "read when ATN set\n");
+		if (status.ibsta & DCAS) {
+			retval = -EINTR;
+		} else {
+			retval = -EIO;
+			dev_dbg(&usb_dev->dev, "read when ATN set stat: 0x%06x\n", status.ibsta);
+		}
 		break;
 	case NIUSB_ADDRESSING_ERROR:
 		retval = -EIO;
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a53ba04d9770..710ae4d40aec 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -635,7 +635,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (IS_ERR(data->rst))
 		return PTR_ERR(data->rst);
 
-	reset_control_deassert(data->rst);
+	err = reset_control_deassert(data->rst);
+	if (err)
+		return dev_err_probe(dev, err, "failed to deassert resets\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
 	if (err)
diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 04a0cbab02c2..b9cc0b786ca6 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -40,6 +40,8 @@
 #define PCI_DEVICE_ID_ACCESSIO_COM_4SM		0x10db
 #define PCI_DEVICE_ID_ACCESSIO_COM_8SM		0x10ea
 
+#define PCI_DEVICE_ID_ADVANTECH_XR17V352	0x0018
+
 #define PCI_DEVICE_ID_COMMTECH_4224PCI335	0x0002
 #define PCI_DEVICE_ID_COMMTECH_4222PCI335	0x0004
 #define PCI_DEVICE_ID_COMMTECH_2324PCI335	0x000a
@@ -1622,6 +1624,12 @@ static const struct exar8250_board pbn_fastcom35x_8 = {
 	.exit		= pci_xr17v35x_exit,
 };
 
+static const struct exar8250_board pbn_adv_XR17V352 = {
+	.num_ports	= 2,
+	.setup		= pci_xr17v35x_setup,
+	.exit		= pci_xr17v35x_exit,
+};
+
 static const struct exar8250_board pbn_exar_XR17V4358 = {
 	.num_ports	= 12,
 	.setup		= pci_xr17v35x_setup,
@@ -1696,6 +1704,9 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	USR_DEVICE(XR17C152, 2980, pbn_exar_XR17C15x),
 	USR_DEVICE(XR17C152, 2981, pbn_exar_XR17C15x),
 
+	/* ADVANTECH devices */
+	EXAR_DEVICE(ADVANTECH, XR17V352, pbn_adv_XR17V352),
+
 	/* Exar Corp. XR17C15[248] Dual/Quad/Octal UART */
 	EXAR_DEVICE(EXAR, XR17C152, pbn_exar_XR17C15x),
 	EXAR_DEVICE(EXAR, XR17C154, pbn_exar_XR17C15x),
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index b44de2ed7413..5875a7b9b4b1 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -435,6 +435,7 @@ static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
 	while
 		(serial_in(up, MTK_UART_DEBUG0));
 
+	clk_disable_unprepare(data->uart_clk);
 	clk_disable_unprepare(data->bus_clk);
 
 	return 0;
@@ -445,6 +446,7 @@ static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 
 	clk_prepare_enable(data->bus_clk);
+	clk_prepare_enable(data->uart_clk);
 
 	return 0;
 }
@@ -475,13 +477,13 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 	int dmacnt;
 #endif
 
-	data->uart_clk = devm_clk_get(&pdev->dev, "baud");
+	data->uart_clk = devm_clk_get_enabled(&pdev->dev, "baud");
 	if (IS_ERR(data->uart_clk)) {
 		/*
 		 * For compatibility with older device trees try unnamed
 		 * clk when no baud clk can be found.
 		 */
-		data->uart_clk = devm_clk_get(&pdev->dev, NULL);
+		data->uart_clk = devm_clk_get_enabled(&pdev->dev, NULL);
 		if (IS_ERR(data->uart_clk)) {
 			dev_warn(&pdev->dev, "Can't get uart clock\n");
 			return PTR_ERR(data->uart_clk);
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index a668e0bb26b3..81eb078bfe4a 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -588,13 +588,6 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 		div /= prescaler;
 	}
 
-	/* Enable enhanced features */
-	sc16is7xx_efr_lock(port);
-	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
-			      SC16IS7XX_EFR_ENABLE_BIT,
-			      SC16IS7XX_EFR_ENABLE_BIT);
-	sc16is7xx_efr_unlock(port);
-
 	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_CLKSEL_BIT,
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 538b2f991609..62bb62b82cbe 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1014,16 +1014,18 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 	struct sci_port *s = to_sci_port(port);
 	const struct plat_sci_reg *reg;
 	int copied = 0;
-	u16 status;
+	u32 status;
 
-	reg = sci_getreg(port, s->params->overrun_reg);
-	if (!reg->size)
-		return 0;
+	if (s->type != SCI_PORT_RSCI) {
+		reg = sci_getreg(port, s->params->overrun_reg);
+		if (!reg->size)
+			return 0;
+	}
 
-	status = sci_serial_in(port, s->params->overrun_reg);
+	status = s->ops->read_reg(port, s->params->overrun_reg);
 	if (status & s->params->overrun_mask) {
 		status &= ~s->params->overrun_mask;
-		sci_serial_out(port, s->params->overrun_reg, status);
+		s->ops->write_reg(port, s->params->overrun_reg, status);
 
 		port->icount.overrun++;
 
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index f5bc53875330..47f589c4104a 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -467,6 +467,8 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Huawei 4G LTE module */
 	{ USB_DEVICE(0x12d1, 0x15bb), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },
+	{ USB_DEVICE(0x12d1, 0x15c1), .driver_info =
+			USB_QUIRK_DISCONNECT_SUSPEND },
 	{ USB_DEVICE(0x12d1, 0x15c3), .driver_info =
 			USB_QUIRK_DISCONNECT_SUSPEND },
 
diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index 20165e1582d9..b71680c58de6 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -667,8 +667,6 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io *io, void __user *ptr,
 		return ERR_PTR(-EINVAL);
 	if (!usb_raw_io_flags_valid(io->flags))
 		return ERR_PTR(-EINVAL);
-	if (io->length > PAGE_SIZE)
-		return ERR_PTR(-EINVAL);
 	if (get_from_user)
 		data = memdup_user(ptr + sizeof(*io), io->length);
 	else {
diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 63edf2d8f245..ecda964e018a 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -892,7 +892,8 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			dev_info(dbc->dev, "DbC configured\n");
 			portsc = readl(&dbc->regs->portsc);
 			writel(portsc, &dbc->regs->portsc);
-			return EVT_GSER;
+			ret = EVT_GSER;
+			break;
 		}
 
 		return EVT_DONE;
@@ -954,7 +955,8 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			break;
 		case TRB_TYPE(TRB_TRANSFER):
 			dbc_handle_xfer_event(dbc, evt);
-			ret = EVT_XFER_DONE;
+			if (ret != EVT_GSER)
+				ret = EVT_XFER_DONE;
 			break;
 		default:
 			break;
@@ -1390,8 +1392,15 @@ int xhci_dbc_suspend(struct xhci_hcd *xhci)
 	if (!dbc)
 		return 0;
 
-	if (dbc->state == DS_CONFIGURED)
+	switch (dbc->state) {
+	case DS_ENABLED:
+	case DS_CONNECTED:
+	case DS_CONFIGURED:
 		dbc->resume_required = 1;
+		break;
+	default:
+		break;
+	}
 
 	xhci_dbc_stop(dbc);
 
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 62e984d20e59..5de856f65f0d 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -273,6 +273,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM05CN			0x0312
 #define QUECTEL_PRODUCT_EM05G_GR		0x0313
 #define QUECTEL_PRODUCT_EM05G_RS		0x0314
+#define QUECTEL_PRODUCT_RG255C			0x0316
 #define QUECTEL_PRODUCT_EM12			0x0512
 #define QUECTEL_PRODUCT_RM500Q			0x0800
 #define QUECTEL_PRODUCT_RM520N			0x0801
@@ -617,6 +618,7 @@ static void option_instat_callback(struct urb *urb);
 #define UNISOC_VENDOR_ID			0x1782
 /* TOZED LT70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
 #define TOZED_PRODUCT_LT70C			0x4055
+#define UNISOC_PRODUCT_UIS7720			0x4064
 /* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
 #define LUAT_PRODUCT_AIR720U			0x4e00
 
@@ -1270,6 +1272,9 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500K, 0xff, 0x00, 0x00) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG650V, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG650V, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG255C, 0xff, 0xff, 0x30) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG255C, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RG255C, 0xff, 0xff, 0x40) },
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
@@ -1398,10 +1403,14 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a2, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a3, 0xff),	/* Telit FN920C04 (ECM) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a4, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a7, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a8, 0xff),	/* Telit FN920C04 (ECM) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a9, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10aa, 0xff),	/* Telit FN920C04 (MBIM) */
@@ -2466,6 +2475,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9291, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9291, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, UNISOC_PRODUCT_UIS7720, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0530, 0xff),			/* TCL IK512 MBIM */
 	  .driver_info = NCTRL(1) },
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index b2a568a5bc9b..cc78770509db 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -7876,9 +7876,9 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 
 	port->partner_desc.identity = &port->partner_ident;
 
-	port->role_sw = usb_role_switch_get(port->dev);
+	port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);
 	if (!port->role_sw)
-		port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);
+		port->role_sw = usb_role_switch_get(port->dev);
 	if (IS_ERR(port->role_sw)) {
 		err = PTR_ERR(port->role_sw);
 		goto out_destroy_wq;
diff --git a/drivers/vfio/cdx/Makefile b/drivers/vfio/cdx/Makefile
index df92b320122a..dadbef2419ea 100644
--- a/drivers/vfio/cdx/Makefile
+++ b/drivers/vfio/cdx/Makefile
@@ -5,4 +5,8 @@
 
 obj-$(CONFIG_VFIO_CDX) += vfio-cdx.o
 
-vfio-cdx-objs := main.o intr.o
+vfio-cdx-objs := main.o
+
+ifdef CONFIG_GENERIC_MSI_IRQ
+vfio-cdx-objs += intr.o
+endif
diff --git a/drivers/vfio/cdx/private.h b/drivers/vfio/cdx/private.h
index dc56729b3114..172e48caa3a0 100644
--- a/drivers/vfio/cdx/private.h
+++ b/drivers/vfio/cdx/private.h
@@ -38,11 +38,25 @@ struct vfio_cdx_device {
 	u8			config_msi;
 };
 
+#ifdef CONFIG_GENERIC_MSI_IRQ
 int vfio_cdx_set_irqs_ioctl(struct vfio_cdx_device *vdev,
 			    u32 flags, unsigned int index,
 			    unsigned int start, unsigned int count,
 			    void *data);
 
 void vfio_cdx_irqs_cleanup(struct vfio_cdx_device *vdev);
+#else
+static int vfio_cdx_set_irqs_ioctl(struct vfio_cdx_device *vdev,
+				   u32 flags, unsigned int index,
+				   unsigned int start, unsigned int count,
+				   void *data)
+{
+	return -EINVAL;
+}
+
+static void vfio_cdx_irqs_cleanup(struct vfio_cdx_device *vdev)
+{
+}
+#endif
 
 #endif /* VFIO_CDX_PRIVATE_H */
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index e299e18346a3..eae65136cdfb 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -875,7 +875,7 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
 	balloon_page_finalize(page);
 	put_page(page); /* balloon reference */
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 #endif /* CONFIG_BALLOON_COMPACTION */
 
diff --git a/fs/aio.c b/fs/aio.c
index 7fc7b6221312..059e03cfa088 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -445,7 +445,7 @@ static int aio_migrate_folio(struct address_space *mapping, struct folio *dst,
 	folio_get(dst);
 
 	rc = folio_migrate_mapping(mapping, dst, src, 1);
-	if (rc != MIGRATEPAGE_SUCCESS) {
+	if (rc) {
 		folio_put(dst);
 		goto out_unlock;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cd8a09e3d1dc..4031cbdea074 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7430,7 +7430,7 @@ static int btrfs_migrate_folio(struct address_space *mapping,
 {
 	int ret = filemap_migrate_folio(mapping, dst, src, mode);
 
-	if (ret != MIGRATEPAGE_SUCCESS)
+	if (ret)
 		return ret;
 
 	if (folio_test_ordered(src)) {
@@ -7438,7 +7438,7 @@ static int btrfs_migrate_folio(struct address_space *mapping,
 		folio_set_ordered(dst);
 	}
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 #else
 #define btrfs_migrate_folio NULL
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 9f1858b42c0e..10d213a52b05 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -982,7 +982,7 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 
 	extent_root = btrfs_extent_root(fs_info, 0);
 	/* If the extent tree is damaged we cannot ignore it (IGNOREBADROOTS). */
-	if (IS_ERR(extent_root)) {
+	if (!extent_root) {
 		btrfs_warn(fs_info, "ref-verify: extent tree not available, disabling");
 		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
 		return 0;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7664025a5af4..5692b905b704 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4148,6 +4148,48 @@ static int refresh_ref_path(struct send_ctx *sctx, struct recorded_ref *ref)
 	return ret;
 }
 
+static int rbtree_check_dir_ref_comp(const void *k, const struct rb_node *node)
+{
+	const struct recorded_ref *data = k;
+	const struct recorded_ref *ref = rb_entry(node, struct recorded_ref, node);
+
+	if (data->dir > ref->dir)
+		return 1;
+	if (data->dir < ref->dir)
+		return -1;
+	if (data->dir_gen > ref->dir_gen)
+		return 1;
+	if (data->dir_gen < ref->dir_gen)
+		return -1;
+	return 0;
+}
+
+static bool rbtree_check_dir_ref_less(struct rb_node *node, const struct rb_node *parent)
+{
+	const struct recorded_ref *entry = rb_entry(node, struct recorded_ref, node);
+
+	return rbtree_check_dir_ref_comp(entry, parent) < 0;
+}
+
+static int record_check_dir_ref_in_tree(struct rb_root *root,
+			struct recorded_ref *ref, struct list_head *list)
+{
+	struct recorded_ref *tmp_ref;
+	int ret;
+
+	if (rb_find(ref, root, rbtree_check_dir_ref_comp))
+		return 0;
+
+	ret = dup_ref(ref, list);
+	if (ret < 0)
+		return ret;
+
+	tmp_ref = list_last_entry(list, struct recorded_ref, list);
+	rb_add(&tmp_ref->node, root, rbtree_check_dir_ref_less);
+	tmp_ref->root = root;
+	return 0;
+}
+
 static int rename_current_inode(struct send_ctx *sctx,
 				struct fs_path *current_path,
 				struct fs_path *new_path)
@@ -4175,11 +4217,11 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 	struct recorded_ref *cur;
 	struct recorded_ref *cur2;
 	LIST_HEAD(check_dirs);
+	struct rb_root rbtree_check_dirs = RB_ROOT;
 	struct fs_path *valid_path = NULL;
 	u64 ow_inode = 0;
 	u64 ow_gen;
 	u64 ow_mode;
-	u64 last_dir_ino_rm = 0;
 	bool did_overwrite = false;
 	bool is_orphan = false;
 	bool can_rename = true;
@@ -4483,7 +4525,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 					goto out;
 			}
 		}
-		ret = dup_ref(cur, &check_dirs);
+		ret = record_check_dir_ref_in_tree(&rbtree_check_dirs, cur, &check_dirs);
 		if (ret < 0)
 			goto out;
 	}
@@ -4511,7 +4553,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		}
 
 		list_for_each_entry(cur, &sctx->deleted_refs, list) {
-			ret = dup_ref(cur, &check_dirs);
+			ret = record_check_dir_ref_in_tree(&rbtree_check_dirs, cur, &check_dirs);
 			if (ret < 0)
 				goto out;
 		}
@@ -4521,7 +4563,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		 * We have a moved dir. Add the old parent to check_dirs
 		 */
 		cur = list_first_entry(&sctx->deleted_refs, struct recorded_ref, list);
-		ret = dup_ref(cur, &check_dirs);
+		ret = record_check_dir_ref_in_tree(&rbtree_check_dirs, cur, &check_dirs);
 		if (ret < 0)
 			goto out;
 	} else if (!S_ISDIR(sctx->cur_inode_mode)) {
@@ -4555,7 +4597,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				if (is_current_inode_path(sctx, cur->full_path))
 					fs_path_reset(&sctx->cur_inode_path);
 			}
-			ret = dup_ref(cur, &check_dirs);
+			ret = record_check_dir_ref_in_tree(&rbtree_check_dirs, cur, &check_dirs);
 			if (ret < 0)
 				goto out;
 		}
@@ -4598,8 +4640,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 			ret = cache_dir_utimes(sctx, cur->dir, cur->dir_gen);
 			if (ret < 0)
 				goto out;
-		} else if (ret == inode_state_did_delete &&
-			   cur->dir != last_dir_ino_rm) {
+		} else if (ret == inode_state_did_delete) {
 			ret = can_rmdir(sctx, cur->dir, cur->dir_gen);
 			if (ret < 0)
 				goto out;
@@ -4611,7 +4652,6 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				ret = send_rmdir(sctx, valid_path);
 				if (ret < 0)
 					goto out;
-				last_dir_ino_rm = cur->dir;
 			}
 		}
 	}
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index fcc7ecbb4945..a4499b422f95 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2070,7 +2070,13 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
 	fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
 	fs_info->super_for_commit = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
 	if (!fs_info->super_copy || !fs_info->super_for_commit) {
-		btrfs_free_fs_info(fs_info);
+		/*
+		 * Dont call btrfs_free_fs_info() to free it as it's still
+		 * initialized partially.
+		 */
+		kfree(fs_info->super_copy);
+		kfree(fs_info->super_for_commit);
+		kvfree(fs_info);
 		return -ENOMEM;
 	}
 	btrfs_init_fs_info(fs_info);
diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 6dd3a524cd35..be938fdf17d9 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5576,7 +5576,7 @@ static int receive_rcom_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
 
 	if (rl->rl_status == DLM_LKSTS_CONVERT && middle_conversion(lkb)) {
 		/* We may need to adjust grmode depending on other granted locks. */
-		log_limit(ls, "%s %x middle convert gr %d rq %d remote %d %x",
+		log_rinfo(ls, "%s %x middle convert gr %d rq %d remote %d %x",
 			  __func__, lkb->lkb_id, lkb->lkb_grmode,
 			  lkb->lkb_rqmode, lkb->lkb_nodeid, lkb->lkb_remid);
 		rsb_set_flag(r, RSB_RECOVER_CONVERT);
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 1929327ffbe1..ee11a70def92 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -730,7 +730,7 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 
 	dlm_device_deregister(ls);
 
-	if (force < 3 && dlm_user_daemon_available())
+	if (force != 3 && dlm_user_daemon_available())
 		do_uevent(ls, 0);
 
 	dlm_recoverd_stop(ls);
diff --git a/fs/dlm/recover.c b/fs/dlm/recover.c
index be4240f09abd..3ac020fb8139 100644
--- a/fs/dlm/recover.c
+++ b/fs/dlm/recover.c
@@ -842,7 +842,7 @@ static void recover_conversion(struct dlm_rsb *r)
 		 */
 		if (((lkb->lkb_grmode == DLM_LOCK_PR) && (other_grmode == DLM_LOCK_CW)) ||
 		    ((lkb->lkb_grmode == DLM_LOCK_CW) && (other_grmode == DLM_LOCK_PR))) {
-			log_limit(ls, "%s %x gr %d rq %d, remote %d %x, other_lkid %u, other gr %d, set gr=NL",
+			log_rinfo(ls, "%s %x gr %d rq %d, remote %d %x, other_lkid %u, other gr %d, set gr=NL",
 				  __func__, lkb->lkb_id, lkb->lkb_grmode,
 				  lkb->lkb_rqmode, lkb->lkb_nodeid,
 				  lkb->lkb_remid, other_lkid, other_grmode);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 798223e6da9c..b2dabdf176b6 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -55,10 +55,6 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	} else {
 		m->partialref = !!(advise & Z_EROFS_LI_PARTIAL_REF);
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
-		if (m->clusterofs >= 1 << vi->z_lclusterbits) {
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
 	}
 	return 0;
@@ -240,21 +236,29 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
 					   unsigned int lcn, bool lookahead)
 {
+	struct erofs_inode *vi = EROFS_I(m->inode);
+	int err;
+
+	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT) {
+		err = z_erofs_load_compact_lcluster(m, lcn, lookahead);
+	} else {
+		DBG_BUGON(vi->datalayout != EROFS_INODE_COMPRESSED_FULL);
+		err = z_erofs_load_full_lcluster(m, lcn);
+	}
+	if (err)
+		return err;
+
 	if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
 		erofs_err(m->inode->i_sb, "unknown type %u @ lcn %u of nid %llu",
-				m->type, lcn, EROFS_I(m->inode)->nid);
+			  m->type, lcn, EROFS_I(m->inode)->nid);
 		DBG_BUGON(1);
 		return -EOPNOTSUPP;
+	} else if (m->type != Z_EROFS_LCLUSTER_TYPE_NONHEAD &&
+		   m->clusterofs >= (1 << vi->z_lclusterbits)) {
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
 	}
-
-	switch (EROFS_I(m->inode)->datalayout) {
-	case EROFS_INODE_COMPRESSED_FULL:
-		return z_erofs_load_full_lcluster(m, lcn);
-	case EROFS_INODE_COMPRESSED_COMPACT:
-		return z_erofs_load_compact_lcluster(m, lcn, lookahead);
-	default:
-		return -EINVAL;
-	}
+	return 0;
 }
 
 static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
@@ -596,7 +600,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 			vi->z_fragmentoff = map->m_plen;
 			if (recsz > offsetof(struct z_erofs_extent, pstart_lo))
 				vi->z_fragmentoff |= map->m_pa << 32;
-		} else if (map->m_plen) {
+		} else if (map->m_plen & Z_EROFS_EXTENT_PLEN_MASK) {
 			map->m_flags |= EROFS_MAP_MAPPED |
 				EROFS_MAP_FULL_MAPPED | EROFS_MAP_ENCODED;
 			fmt = map->m_plen >> Z_EROFS_EXTENT_PLEN_FMT_BIT;
@@ -715,6 +719,7 @@ static int z_erofs_map_sanity_check(struct inode *inode,
 				    struct erofs_map_blocks *map)
 {
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
+	u64 pend;
 
 	if (!(map->m_flags & EROFS_MAP_ENCODED))
 		return 0;
@@ -732,6 +737,10 @@ static int z_erofs_map_sanity_check(struct inode *inode,
 	if (unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
 		     map->m_llen > Z_EROFS_PCLUSTER_MAX_DSIZE))
 		return -EOPNOTSUPP;
+	/* Filesystems beyond 48-bit physical block addresses are invalid */
+	if (unlikely(check_add_overflow(map->m_pa, map->m_plen, &pend) ||
+		     (pend >> sbi->blkszbits) >= BIT_ULL(48)))
+		return -EFSCORRUPTED;
 	return 0;
 }
 
diff --git a/fs/exec.c b/fs/exec.c
index a69a2673f631..1515e0585e25 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -599,7 +599,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		    unsigned long stack_top,
 		    int executable_stack)
 {
-	unsigned long ret;
+	int ret;
 	unsigned long stack_shift;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = bprm->vma;
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 6db37c20587d..570e5ae6b73d 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -361,12 +361,6 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 	gfs2_sbstats_inc(gl, GFS2_LKS_DCOUNT);
 	gfs2_update_request_times(gl);
 
-	/* don't want to call dlm if we've unmounted the lock protocol */
-	if (test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
-		gfs2_glock_free(gl);
-		return;
-	}
-
 	/*
 	 * When the lockspace is released, all remaining glocks will be
 	 * unlocked automatically.  This is more efficient than unlocking them
@@ -396,6 +390,11 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 		goto again;
 	}
 
+	if (error == -ENODEV) {
+		gfs2_glock_free(gl);
+		return;
+	}
+
 	if (error) {
 		fs_err(sdp, "gdlm_unlock %x,%llx err=%d\n",
 		       gl->gl_name.ln_type,
diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index 34e9804e0f36..e46f650b5e9c 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -21,7 +21,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
@@ -115,6 +115,12 @@ int hfs_brec_find(struct hfs_find_data *fd)
 	__be32 data;
 	int height, res;
 
+	fd->record = -1;
+	fd->keyoffset = -1;
+	fd->keylength = -1;
+	fd->entryoffset = -1;
+	fd->entrylength = -1;
+
 	tree = fd->tree;
 	if (fd->bnode)
 		hfs_bnode_put(fd->bnode);
diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 896396554bcc..b01db1fae147 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -179,6 +179,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	struct hfs_btree *tree;
 	struct hfs_bnode *node, *parent;
 	int end_off, rec_off, data_off, size;
+	int src, dst, len;
 
 	tree = fd->tree;
 	node = fd->bnode;
@@ -208,10 +209,14 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	}
 	hfs_bnode_write_u16(node, offsetof(struct hfs_bnode_desc, num_recs), node->num_recs);
 
-	if (rec_off == end_off)
-		goto skip;
 	size = fd->keylength + fd->entrylength;
 
+	if (rec_off == end_off) {
+		src = fd->keyoffset;
+		hfs_bnode_clear(node, src, size);
+		goto skip;
+	}
+
 	do {
 		data_off = hfs_bnode_read_u16(node, rec_off);
 		hfs_bnode_write_u16(node, rec_off + 2, data_off - size);
@@ -219,9 +224,23 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	} while (rec_off >= end_off);
 
 	/* fill hole */
-	hfs_bnode_move(node, fd->keyoffset, fd->keyoffset + size,
-		       data_off - fd->keyoffset - size);
+	dst = fd->keyoffset;
+	src = fd->keyoffset + size;
+	len = data_off - src;
+
+	hfs_bnode_move(node, dst, src, len);
+
+	src = dst + len;
+	len = data_off - src;
+
+	hfs_bnode_clear(node, src, len);
+
 skip:
+	/*
+	 * Remove the obsolete offset to free space.
+	 */
+	hfs_bnode_write_u16(node, end_off, 0);
+
 	hfs_bnode_dump(node);
 	if (!fd->record)
 		hfs_brec_update_parent(fd);
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 8082eb01127c..bf811347bb07 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -172,7 +172,7 @@ int hfs_mdb_get(struct super_block *sb)
 		pr_warn("continuing without an alternate MDB\n");
 	}
 
-	HFS_SB(sb)->bitmap = kmalloc(8192, GFP_KERNEL);
+	HFS_SB(sb)->bitmap = kzalloc(8192, GFP_KERNEL);
 	if (!HFS_SB(sb)->bitmap)
 		goto out;
 
diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 901e83d65d20..26ebac4c6042 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
@@ -158,6 +158,12 @@ int hfs_brec_find(struct hfs_find_data *fd, search_strategy_t do_key_compare)
 	__be32 data;
 	int height, res;
 
+	fd->record = -1;
+	fd->keyoffset = -1;
+	fd->keylength = -1;
+	fd->entryoffset = -1;
+	fd->entrylength = -1;
+
 	tree = fd->tree;
 	if (fd->bnode)
 		hfs_bnode_put(fd->bnode);
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 14f4995588ff..407d5152eb41 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -18,47 +18,6 @@
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
 
-static inline
-bool is_bnode_offset_valid(struct hfs_bnode *node, int off)
-{
-	bool is_valid = off < node->tree->node_size;
-
-	if (!is_valid) {
-		pr_err("requested invalid offset: "
-		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d\n",
-		       node->this, node->type, node->height,
-		       node->tree->node_size, off);
-	}
-
-	return is_valid;
-}
-
-static inline
-int check_and_correct_requested_length(struct hfs_bnode *node, int off, int len)
-{
-	unsigned int node_size;
-
-	if (!is_bnode_offset_valid(node, off))
-		return 0;
-
-	node_size = node->tree->node_size;
-
-	if ((off + len) > node_size) {
-		int new_len = (int)node_size - off;
-
-		pr_err("requested length has been corrected: "
-		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %d, "
-		       "requested_len %d, corrected_len %d\n",
-		       node->this, node->type, node->height,
-		       node->tree->node_size, off, len, new_len);
-
-		return new_len;
-	}
-
-	return len;
-}
 
 /* Copy a specified range of bytes from the raw data of a node */
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 9e1732a2b92a..fe6a54c4083c 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -393,6 +393,12 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	len = hfs_brec_lenoff(node, 2, &off16);
 	off = off16;
 
+	if (!is_bnode_offset_valid(node, off)) {
+		hfs_bnode_put(node);
+		return ERR_PTR(-EIO);
+	}
+	len = check_and_correct_requested_length(node, off, len);
+
 	off += node->page_offset;
 	pagep = node->page + (off >> PAGE_SHIFT);
 	data = kmap_local_page(*pagep);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 2311e4be4e86..9dd18de0bc89 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -581,6 +581,48 @@ hfsplus_btree_lock_class(struct hfs_btree *tree)
 	return class;
 }
 
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
 /* compatibility */
 #define hfsp_mt2ut(t)		(struct timespec64){ .tv_sec = __hfsp_mt2ut(t) }
 #define hfsp_ut2mt(t)		__hfsp_ut2mt((t).tv_sec)
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 86351bdc8985..77ec048021a0 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -68,13 +68,26 @@ struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 	if (!(inode->i_state & I_NEW))
 		return inode;
 
-	INIT_LIST_HEAD(&HFSPLUS_I(inode)->open_dir_list);
-	spin_lock_init(&HFSPLUS_I(inode)->open_dir_lock);
-	mutex_init(&HFSPLUS_I(inode)->extents_lock);
-	HFSPLUS_I(inode)->flags = 0;
+	atomic_set(&HFSPLUS_I(inode)->opencnt, 0);
+	HFSPLUS_I(inode)->first_blocks = 0;
+	HFSPLUS_I(inode)->clump_blocks = 0;
+	HFSPLUS_I(inode)->alloc_blocks = 0;
+	HFSPLUS_I(inode)->cached_start = U32_MAX;
+	HFSPLUS_I(inode)->cached_blocks = 0;
+	memset(HFSPLUS_I(inode)->first_extents, 0, sizeof(hfsplus_extent_rec));
+	memset(HFSPLUS_I(inode)->cached_extents, 0, sizeof(hfsplus_extent_rec));
 	HFSPLUS_I(inode)->extent_state = 0;
+	mutex_init(&HFSPLUS_I(inode)->extents_lock);
 	HFSPLUS_I(inode)->rsrc_inode = NULL;
-	atomic_set(&HFSPLUS_I(inode)->opencnt, 0);
+	HFSPLUS_I(inode)->create_date = 0;
+	HFSPLUS_I(inode)->linkid = 0;
+	HFSPLUS_I(inode)->flags = 0;
+	HFSPLUS_I(inode)->fs_blocks = 0;
+	HFSPLUS_I(inode)->userflags = 0;
+	HFSPLUS_I(inode)->subfolders = 0;
+	INIT_LIST_HEAD(&HFSPLUS_I(inode)->open_dir_list);
+	spin_lock_init(&HFSPLUS_I(inode)->open_dir_lock);
+	HFSPLUS_I(inode)->phys_size = 0;
 
 	if (inode->i_ino >= HFSPLUS_FIRSTUSER_CNID ||
 	    inode->i_ino == HFSPLUS_ROOT_CNID) {
@@ -524,7 +537,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
 		hfs_find_exit(&fd);
 		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
-			err = -EINVAL;
+			err = -EIO;
 			goto out_put_root;
 		}
 		inode = hfsplus_iget(sb, be32_to_cpu(entry.folder.id));
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index be4be99304bc..5517d40266dd 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1054,7 +1054,7 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 	int rc;
 
 	rc = migrate_huge_page_move_mapping(mapping, dst, src);
-	if (rc != MIGRATEPAGE_SUCCESS)
+	if (rc)
 		return rc;
 
 	if (hugetlb_folio_subpool(src)) {
@@ -1065,7 +1065,7 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 
 	folio_migrate_flags(dst, src);
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 #else
 #define hugetlbfs_migrate_folio NULL
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index b98cf3bb6c1f..871cf4fb3636 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -169,7 +169,7 @@ static int __metapage_migrate_folio(struct address_space *mapping,
 	}
 
 	rc = filemap_migrate_folio(mapping, dst, src, mode);
-	if (rc != MIGRATEPAGE_SUCCESS)
+	if (rc)
 		return rc;
 
 	for (i = 0; i < MPS_PER_PAGE; i++) {
@@ -199,7 +199,7 @@ static int __metapage_migrate_folio(struct address_space *mapping,
 		}
 	}
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 #endif	/* CONFIG_MIGRATION */
 
@@ -242,7 +242,7 @@ static int __metapage_migrate_folio(struct address_space *mapping,
 		return -EAGAIN;
 
 	rc = filemap_migrate_folio(mapping, dst, src, mode);
-	if (rc != MIGRATEPAGE_SUCCESS)
+	if (rc)
 		return rc;
 
 	if (unlikely(insert_metapage(dst, mp)))
@@ -253,7 +253,7 @@ static int __metapage_migrate_folio(struct address_space *mapping,
 	mp->folio = dst;
 	remove_metapage(src, mp);
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 #endif	/* CONFIG_MIGRATION */
 
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 1161eabf11ee..9cc7eb863643 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -17,6 +17,7 @@
 #include "fanotify/fanotify.h"
 #include "fdinfo.h"
 #include "fsnotify.h"
+#include "../internal.h"
 
 #if defined(CONFIG_PROC_FS)
 
@@ -46,7 +47,12 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 
 	size = f->handle_bytes >> 2;
 
+	if (!super_trylock_shared(inode->i_sb))
+		return;
+
 	ret = exportfs_encode_fid(inode, (struct fid *)f->f_handle, &size);
+	up_read(&inode->i_sb->s_umount);
+
 	if ((ret == FILEID_INVALID) || (ret < 0))
 		return;
 
diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index cbe2f8ed8897..80ebb0b7265a 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -867,6 +867,11 @@ static int __ocfs2_move_extents_range(struct buffer_head *di_bh,
 			mlog_errno(ret);
 			goto out;
 		}
+		/*
+		 * Invalidate extent cache after moving/defragging to prevent
+		 * stale cached data with outdated extent flags.
+		 */
+		ocfs2_extent_map_trunc(inode, cpos);
 
 		context->clusters_moved += alloc_size;
 next:
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 0fae95cf81c4..3e2c5eb3d313 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -740,7 +740,7 @@ struct TCP_Server_Info {
 	bool nosharesock;
 	bool tcp_nodelay;
 	bool terminate;
-	unsigned int credits;  /* send no more requests at once */
+	int credits;  /* send no more requests at once */
 	unsigned int max_credits; /* can override large 32000 default at mnt */
 	unsigned int in_flight;  /* number of requests on the wire to server */
 	unsigned int max_in_flight; /* max number of requests that were on wire */
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 6b41360631f9..bf82a6fd7bf8 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2484,11 +2484,8 @@ cifs_do_rename(const unsigned int xid, struct dentry *from_dentry,
 	}
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 do_rename_exit:
-	if (rc == 0) {
+	if (rc == 0)
 		d_move(from_dentry, to_dentry);
-		/* Force a new lookup */
-		d_drop(from_dentry);
-	}
 	cifs_put_tlink(tlink);
 	return rc;
 }
diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 6480945c2459..99fad70356c5 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -362,8 +362,8 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct smbd_connection *info =
 		container_of(sc, struct smbd_connection, socket);
 
-	log_rdma_send(INFO, "smbdirect_send_io 0x%p completed wc->status=%d\n",
-		request, wc->status);
+	log_rdma_send(INFO, "smbdirect_send_io 0x%p completed wc->status=%s\n",
+		request, ib_wc_status_msg(wc->status));
 
 	for (i = 0; i < request->num_sge; i++)
 		ib_dma_unmap_single(sc->ib.dev,
@@ -372,8 +372,9 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
 			DMA_TO_DEVICE);
 
 	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_SEND) {
-		log_rdma_send(ERR, "wc->status=%d wc->opcode=%d\n",
-			wc->status, wc->opcode);
+		if (wc->status != IB_WC_WR_FLUSH_ERR)
+			log_rdma_send(ERR, "wc->status=%s wc->opcode=%d\n",
+				ib_wc_status_msg(wc->status), wc->opcode);
 		mempool_free(request, sc->send_io.mem.pool);
 		smbd_disconnect_rdma_connection(info);
 		return;
@@ -429,6 +430,7 @@ static bool process_negotiation_response(
 		return false;
 	}
 	info->receive_credit_target = le16_to_cpu(packet->credits_requested);
+	info->receive_credit_target = min_t(u16, info->receive_credit_target, sp->recv_credit_max);
 
 	if (packet->credits_granted == 0) {
 		log_rdma_event(ERR, "error: credits_granted==0\n");
@@ -537,17 +539,21 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	struct smbd_connection *info =
 		container_of(sc, struct smbd_connection, socket);
+	u16 old_recv_credit_target;
 	u32 data_offset = 0;
 	u32 data_length = 0;
 	u32 remaining_data_length = 0;
 
-	log_rdma_recv(INFO, "response=0x%p type=%d wc status=%d wc opcode %d byte_len=%d pkey_index=%u\n",
-		      response, sc->recv_io.expected, wc->status, wc->opcode,
+	log_rdma_recv(INFO,
+		      "response=0x%p type=%d wc status=%s wc opcode %d byte_len=%d pkey_index=%u\n",
+		      response, sc->recv_io.expected,
+		      ib_wc_status_msg(wc->status), wc->opcode,
 		      wc->byte_len, wc->pkey_index);
 
 	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_RECV) {
-		log_rdma_recv(INFO, "wc->status=%d opcode=%d\n",
-			wc->status, wc->opcode);
+		if (wc->status != IB_WC_WR_FLUSH_ERR)
+			log_rdma_recv(ERR, "wc->status=%s opcode=%d\n",
+				ib_wc_status_msg(wc->status), wc->opcode);
 		goto error;
 	}
 
@@ -599,8 +605,13 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		}
 
 		atomic_dec(&info->receive_credits);
+		old_recv_credit_target = info->receive_credit_target;
 		info->receive_credit_target =
 			le16_to_cpu(data_transfer->credits_requested);
+		info->receive_credit_target =
+			min_t(u16, info->receive_credit_target, sp->recv_credit_max);
+		info->receive_credit_target =
+			max_t(u16, info->receive_credit_target, 1);
 		if (le16_to_cpu(data_transfer->credits_granted)) {
 			atomic_add(le16_to_cpu(data_transfer->credits_granted),
 				&info->send_credits);
@@ -629,6 +640,9 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		 * reassembly queue and wake up the reading thread
 		 */
 		if (data_length) {
+			if (info->receive_credit_target > old_recv_credit_target)
+				queue_work(info->workqueue, &info->post_send_credits_work);
+
 			enqueue_reassembly(info, response, data_length);
 			wake_up_interruptible(&sc->recv_io.reassembly.wait_queue);
 		} else
diff --git a/fs/smb/client/smbdirect.h b/fs/smb/client/smbdirect.h
index 4ca9b2b2c57f..ed362267dd11 100644
--- a/fs/smb/client/smbdirect.h
+++ b/fs/smb/client/smbdirect.h
@@ -63,7 +63,7 @@ struct smbd_connection {
 	int protocol;
 	atomic_t send_credits;
 	atomic_t receive_credits;
-	int receive_credit_target;
+	u16 receive_credit_target;
 
 	/* Memory registrations */
 	/* Maximum number of RDMA read/write outstanding on this connection */
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 46f87fd1ce1c..2c08cccfa680 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -263,10 +263,16 @@ static void ipc_msg_handle_free(int handle)
 
 static int handle_response(int type, void *payload, size_t sz)
 {
-	unsigned int handle = *(unsigned int *)payload;
+	unsigned int handle;
 	struct ipc_msg_table_entry *entry;
 	int ret = 0;
 
+	/* Prevent 4-byte read beyond declared payload size */
+	if (sz < sizeof(unsigned int))
+		return -EINVAL;
+
+	handle = *(unsigned int *)payload;
+
 	ipc_update_last_active();
 	down_read(&ipc_msg_table_lock);
 	hash_for_each_possible(ipc_msg_table, entry, ipc_table_hlist, handle) {
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index e1f659d3b4cf..2363244ff5f7 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -939,12 +939,15 @@ static int smb_direct_flush_send_list(struct smb_direct_transport *t,
 			       struct smb_direct_sendmsg,
 			       list);
 
+	if (send_ctx->need_invalidate_rkey) {
+		first->wr.opcode = IB_WR_SEND_WITH_INV;
+		first->wr.ex.invalidate_rkey = send_ctx->remote_key;
+		send_ctx->need_invalidate_rkey = false;
+		send_ctx->remote_key = 0;
+	}
+
 	last->wr.send_flags = IB_SEND_SIGNALED;
 	last->wr.wr_cqe = &last->cqe;
-	if (is_last && send_ctx->need_invalidate_rkey) {
-		last->wr.opcode = IB_WR_SEND_WITH_INV;
-		last->wr.ex.invalidate_rkey = send_ctx->remote_key;
-	}
 
 	ret = smb_direct_post_send(t, &first->wr);
 	if (!ret) {
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 2d78e94072a0..e142bac4f9f8 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -498,17 +498,26 @@ int compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
 }
 EXPORT_SYMBOL_GPL(compat_only_sysfs_link_entry_to_kobj);
 
-static int sysfs_group_attrs_change_owner(struct kernfs_node *grp_kn,
+static int sysfs_group_attrs_change_owner(struct kobject *kobj,
+					  struct kernfs_node *grp_kn,
 					  const struct attribute_group *grp,
 					  struct iattr *newattrs)
 {
 	struct kernfs_node *kn;
-	int error;
+	int error, i;
+	umode_t mode;
 
 	if (grp->attrs) {
 		struct attribute *const *attr;
 
-		for (attr = grp->attrs; *attr; attr++) {
+		for (i = 0, attr = grp->attrs; *attr; i++, attr++) {
+			if (grp->is_visible) {
+				mode = grp->is_visible(kobj, *attr, i);
+				if (mode & SYSFS_GROUP_INVISIBLE)
+					break;
+				if (!mode)
+					continue;
+			}
 			kn = kernfs_find_and_get(grp_kn, (*attr)->name);
 			if (!kn)
 				return -ENOENT;
@@ -523,7 +532,14 @@ static int sysfs_group_attrs_change_owner(struct kernfs_node *grp_kn,
 	if (grp->bin_attrs) {
 		const struct bin_attribute *const *bin_attr;
 
-		for (bin_attr = grp->bin_attrs; *bin_attr; bin_attr++) {
+		for (i = 0, bin_attr = grp->bin_attrs; *bin_attr; i++, bin_attr++) {
+			if (grp->is_bin_visible) {
+				mode = grp->is_bin_visible(kobj, *bin_attr, i);
+				if (mode & SYSFS_GROUP_INVISIBLE)
+					break;
+				if (!mode)
+					continue;
+			}
 			kn = kernfs_find_and_get(grp_kn, (*bin_attr)->attr.name);
 			if (!kn)
 				return -ENOENT;
@@ -573,7 +589,7 @@ int sysfs_group_change_owner(struct kobject *kobj,
 
 	error = kernfs_setattr(grp_kn, &newattrs);
 	if (!error)
-		error = sysfs_group_attrs_change_owner(grp_kn, grp, &newattrs);
+		error = sysfs_group_attrs_change_owner(kobj, grp_kn, grp, &newattrs);
 
 	kernfs_put(grp_kn);
 
diff --git a/fs/xfs/scrub/nlinks.c b/fs/xfs/scrub/nlinks.c
index 26721fab5cab..091c79e432e5 100644
--- a/fs/xfs/scrub/nlinks.c
+++ b/fs/xfs/scrub/nlinks.c
@@ -376,6 +376,36 @@ xchk_nlinks_collect_pptr(
 	return error;
 }
 
+static uint
+xchk_nlinks_ilock_dir(
+	struct xfs_inode	*ip)
+{
+	uint			lock_mode = XFS_ILOCK_SHARED;
+
+	/*
+	 * We're going to scan the directory entries, so we must be ready to
+	 * pull the data fork mappings into memory if they aren't already.
+	 */
+	if (xfs_need_iread_extents(&ip->i_df))
+		lock_mode = XFS_ILOCK_EXCL;
+
+	/*
+	 * We're going to scan the parent pointers, so we must be ready to
+	 * pull the attr fork mappings into memory if they aren't already.
+	 */
+	if (xfs_has_parent(ip->i_mount) && xfs_inode_has_attr_fork(ip) &&
+	    xfs_need_iread_extents(&ip->i_af))
+		lock_mode = XFS_ILOCK_EXCL;
+
+	/*
+	 * Take the IOLOCK so that other threads cannot start a directory
+	 * update while we're scanning.
+	 */
+	lock_mode |= XFS_IOLOCK_SHARED;
+	xfs_ilock(ip, lock_mode);
+	return lock_mode;
+}
+
 /* Walk a directory to bump the observed link counts of the children. */
 STATIC int
 xchk_nlinks_collect_dir(
@@ -394,8 +424,7 @@ xchk_nlinks_collect_dir(
 		return 0;
 
 	/* Prevent anyone from changing this directory while we walk it. */
-	xfs_ilock(dp, XFS_IOLOCK_SHARED);
-	lock_mode = xfs_ilock_data_map_shared(dp);
+	lock_mode = xchk_nlinks_ilock_dir(dp);
 
 	/*
 	 * The dotdot entry of an unlinked directory still points to the last
@@ -452,7 +481,6 @@ xchk_nlinks_collect_dir(
 	xchk_iscan_abort(&xnc->collect_iscan);
 out_unlock:
 	xfs_iunlock(dp, lock_mode);
-	xfs_iunlock(dp, XFS_IOLOCK_SHARED);
 	return error;
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index bb0a82635a77..9a7dd3a36f74 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1386,16 +1386,25 @@ suffix_kstrtoull(
 static inline void
 xfs_fs_warn_deprecated(
 	struct fs_context	*fc,
-	struct fs_parameter	*param,
-	uint64_t		flag,
-	bool			value)
+	struct fs_parameter	*param)
 {
-	/* Don't print the warning if reconfiguring and current mount point
-	 * already had the flag set
+	/*
+	 * Always warn about someone passing in a deprecated mount option.
+	 * Previously we wouldn't print the warning if we were reconfiguring
+	 * and current mount point already had the flag set, but that was not
+	 * the right thing to do.
+	 *
+	 * Many distributions mount the root filesystem with no options in the
+	 * initramfs and rely on mount -a to remount the root fs with the
+	 * options in fstab.  However, the old behavior meant that there would
+	 * never be a warning about deprecated mount options for the root fs in
+	 * /etc/fstab.  On a single-fs system, that means no warning at all.
+	 *
+	 * Compounding this problem are distribution scripts that copy
+	 * /proc/mounts to fstab, which means that we can't remove mount
+	 * options unless we're 100% sure they have only ever been advertised
+	 * in /proc/mounts in response to explicitly provided mount options.
 	 */
-	if ((fc->purpose & FS_CONTEXT_FOR_RECONFIGURE) &&
-            !!(XFS_M(fc->root->d_sb)->m_features & flag) == value)
-		return;
 	xfs_warn(fc->s_fs_info, "%s mount option is deprecated.", param->key);
 }
 
@@ -1543,19 +1552,19 @@ xfs_fs_parse_param(
 #endif
 	/* Following mount options will be removed in September 2025 */
 	case Opt_ikeep:
-		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_IKEEP, true);
+		xfs_fs_warn_deprecated(fc, param);
 		parsing_mp->m_features |= XFS_FEAT_IKEEP;
 		return 0;
 	case Opt_noikeep:
-		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_IKEEP, false);
+		xfs_fs_warn_deprecated(fc, param);
 		parsing_mp->m_features &= ~XFS_FEAT_IKEEP;
 		return 0;
 	case Opt_attr2:
-		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_ATTR2, true);
+		xfs_fs_warn_deprecated(fc, param);
 		parsing_mp->m_features |= XFS_FEAT_ATTR2;
 		return 0;
 	case Opt_noattr2:
-		xfs_fs_warn_deprecated(fc, param, XFS_FEAT_NOATTR2, true);
+		xfs_fs_warn_deprecated(fc, param);
 		parsing_mp->m_features |= XFS_FEAT_NOATTR2;
 		return 0;
 	case Opt_max_open_zones:
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index e1634897e159..effa4d5e0242 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -337,6 +337,7 @@ struct ffa_mem_region_attributes {
 	 * an `struct ffa_mem_region_addr_range`.
 	 */
 	u32 composite_off;
+	u8 impdef_val[16];
 	u64 reserved;
 };
 
@@ -416,15 +417,31 @@ struct ffa_mem_region {
 #define CONSTITUENTS_OFFSET(x)	\
 	(offsetof(struct ffa_composite_mem_region, constituents[x]))
 
+#define FFA_EMAD_HAS_IMPDEF_FIELD(version)	((version) >= FFA_VERSION_1_2)
+#define FFA_MEM_REGION_HAS_EP_MEM_OFFSET(version) ((version) > FFA_VERSION_1_0)
+
+static inline u32 ffa_emad_size_get(u32 ffa_version)
+{
+	u32 sz;
+	struct ffa_mem_region_attributes *ep_mem_access;
+
+	if (FFA_EMAD_HAS_IMPDEF_FIELD(ffa_version))
+		sz = sizeof(*ep_mem_access);
+	else
+		sz = sizeof(*ep_mem_access) - sizeof(ep_mem_access->impdef_val);
+
+	return sz;
+}
+
 static inline u32
 ffa_mem_desc_offset(struct ffa_mem_region *buf, int count, u32 ffa_version)
 {
-	u32 offset = count * sizeof(struct ffa_mem_region_attributes);
+	u32 offset = count * ffa_emad_size_get(ffa_version);
 	/*
 	 * Earlier to v1.1, the endpoint memory descriptor array started at
 	 * offset 32(i.e. offset of ep_mem_offset in the current structure)
 	 */
-	if (ffa_version <= FFA_VERSION_1_0)
+	if (!FFA_MEM_REGION_HAS_EP_MEM_OFFSET(ffa_version))
 		offset += offsetof(struct ffa_mem_region, ep_mem_offset);
 	else
 		offset += sizeof(struct ffa_mem_region);
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index cfb0dd1ea49c..b80286a73d0a 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -314,9 +314,6 @@ static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
 static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
 					  int fh_flags)
 {
-	if (!nop)
-		return false;
-
 	/*
 	 * If a non-decodeable file handle was requested, we only need to make
 	 * sure that filesystem did not opt-out of encoding fid.
@@ -324,6 +321,10 @@ static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
 	if (fh_flags & EXPORT_FH_FID)
 		return exportfs_can_encode_fid(nop);
 
+	/* Normal file handles cannot be created without export ops */
+	if (!nop)
+		return false;
+
 	/*
 	 * If a connectable file handle was requested, we need to make sure that
 	 * filesystem can also decode connected file handles.
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index c722c67668c6..e14ff69eaba1 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -37,9 +37,18 @@ struct regmap;
  *			offset to a register/bitmask pair. If not
  *			given the default gpio_regmap_simple_xlate()
  *			is used.
+ * @fixed_direction_output:
+ *			(Optional) Bitmap representing the fixed direction of
+ *			the GPIO lines. Useful when there are GPIO lines with a
+ *			fixed direction mixed together in the same register.
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
+ * @regmap_irq_chip:	(Optional) Pointer on an regmap_irq_chip structure. If
+ *			set, a regmap-irq device will be created and the IRQ
+ *			domain will be set accordingly.
+ * @regmap_irq_line	(Optional) The IRQ the device uses to signal interrupts.
+ * @regmap_irq_flags	(Optional) The IRQF_ flags to use for the interrupt.
  *
  * The ->reg_mask_xlate translates a given base address and GPIO offset to
  * register and mask pair. The base address is one of the given register
@@ -77,6 +86,13 @@ struct gpio_regmap_config {
 	int reg_stride;
 	int ngpio_per_reg;
 	struct irq_domain *irq_domain;
+	unsigned long *fixed_direction_output;
+
+#ifdef CONFIG_REGMAP_IRQ
+	struct regmap_irq_chip *regmap_irq_chip;
+	int regmap_irq_line;
+	unsigned long regmap_irq_flags;
+#endif
 
 	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
 			      unsigned int offset, unsigned int *reg,
diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
index 34e615c76ca5..c4403eeb7144 100644
--- a/include/linux/hung_task.h
+++ b/include/linux/hung_task.h
@@ -20,6 +20,10 @@
  * always zero. So we can use these bits to encode the specific blocking
  * type.
  *
+ * Note that on architectures where this is not guaranteed, or for any
+ * unaligned lock, this tracking mechanism is silently skipped for that
+ * lock.
+ *
  * Type encoding:
  * 00 - Blocked on mutex			(BLOCKER_TYPE_MUTEX)
  * 01 - Blocked on semaphore			(BLOCKER_TYPE_SEM)
@@ -45,7 +49,7 @@ static inline void hung_task_set_blocker(void *lock, unsigned long type)
 	 * If the lock pointer matches the BLOCKER_TYPE_MASK, return
 	 * without writing anything.
 	 */
-	if (WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK))
+	if (lock_ptr & BLOCKER_TYPE_MASK)
 		return;
 
 	WRITE_ONCE(current->blocker, lock_ptr | type);
@@ -53,8 +57,6 @@ static inline void hung_task_set_blocker(void *lock, unsigned long type)
 
 static inline void hung_task_clear_blocker(void)
 {
-	WARN_ON_ONCE(!READ_ONCE(current->blocker));
-
 	WRITE_ONCE(current->blocker, 0UL);
 }
 
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 9009e27b5f44..1f0ac122c3bf 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -12,14 +12,6 @@ typedef void free_folio_t(struct folio *folio, unsigned long private);
 
 struct migration_target_control;
 
-/*
- * Return values from addresss_space_operations.migratepage():
- * - negative errno on page migration failure;
- * - zero on page migration success;
- */
-#define MIGRATEPAGE_SUCCESS		0
-#define MIGRATEPAGE_UNMAP		1
-
 /**
  * struct movable_operations - Driver page migration
  * @isolate_page:
@@ -35,8 +27,7 @@ struct migration_target_control;
  * @src page.  The driver should copy the contents of the
  * @src page to the @dst page and set up the fields of @dst page.
  * Both pages are locked.
- * If page migration is successful, the driver should
- * return MIGRATEPAGE_SUCCESS.
+ * If page migration is successful, the driver should return 0.
  * If the driver cannot migrate the page at the moment, it can return
  * -EAGAIN.  The VM interprets this as a temporary migration failure and
  * will retry it later.  Any other error value is a permanent migration
diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 71cf5bfc6349..0cb36a3ffc47 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -19,7 +19,7 @@ enum misc_res_type {
 	MISC_CG_RES_SEV_ES,
 #endif
 #ifdef CONFIG_INTEL_TDX_HOST
-	/* Intel TDX HKIDs resource */
+	/** @MISC_CG_RES_TDX: Intel TDX HKIDs resource */
 	MISC_CG_RES_TDX,
 #endif
 	/** @MISC_CG_RES_TYPES: count of enum misc_res_type constants */
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index a480063c9cb1..1db8543dfc8a 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -55,7 +55,6 @@ extern struct irq_domain *of_msi_map_get_device_domain(struct device *dev,
 							u32 bus_token);
 extern void of_msi_configure(struct device *dev, const struct device_node *np);
 extern u32 of_msi_xlate(struct device *dev, struct device_node **msi_np, u32 id_in);
-u32 of_msi_map_id(struct device *dev, struct device_node *msi_np, u32 id_in);
 #else
 static inline void of_irq_init(const struct of_device_id *matches)
 {
@@ -105,11 +104,6 @@ static inline u32 of_msi_xlate(struct device *dev, struct device_node **msi_np,
 {
 	return id_in;
 }
-static inline u32 of_msi_map_id(struct device *dev,
-				 struct device_node *msi_np, u32 id_in)
-{
-	return id_in;
-}
 #endif
 
 #if defined(CONFIG_OF_IRQ) || defined(CONFIG_SPARC)
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fa633657e4c0..ad66110b43cc 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4157,6 +4157,9 @@ struct sk_buff *__skb_recv_datagram(struct sock *sk,
 				    struct sk_buff_head *sk_queue,
 				    unsigned int flags, int *off, int *err);
 struct sk_buff *skb_recv_datagram(struct sock *sk, unsigned int flags, int *err);
+__poll_t datagram_poll_queue(struct file *file, struct socket *sock,
+			     struct poll_table_struct *wait,
+			     struct sk_buff_head *rcv_queue);
 __poll_t datagram_poll(struct file *file, struct socket *sock,
 			   struct poll_table_struct *wait);
 int skb_copy_datagram_iter(const struct sk_buff *from, int offset,
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 20e0584db1dd..4d1780848d0e 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -401,6 +401,10 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	if (!tnl_hdr_negotiated)
 		return -EINVAL;
 
+        vhdr->hash_hdr.hash_value = 0;
+        vhdr->hash_hdr.hash_report = 0;
+        vhdr->hash_hdr.padding = 0;
+
 	/* Let the basic parsing deal with plain GSO features. */
 	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
 	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index 9798d6fb4ec7..9e7e15a5896b 100644
--- a/io_uring/fdinfo.c
+++ b/io_uring/fdinfo.c
@@ -59,7 +59,6 @@ static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
 {
 	struct io_overflow_cqe *ocqe;
 	struct io_rings *r = ctx->rings;
-	struct rusage sq_usage;
 	unsigned int sq_mask = ctx->sq_entries - 1, cq_mask = ctx->cq_entries - 1;
 	unsigned int sq_head = READ_ONCE(r->sq.head);
 	unsigned int sq_tail = READ_ONCE(r->sq.tail);
@@ -150,14 +149,15 @@ static void __io_uring_show_fdinfo(struct io_ring_ctx *ctx, struct seq_file *m)
 		 * thread termination.
 		 */
 		if (tsk) {
+			u64 usec;
+
 			get_task_struct(tsk);
 			rcu_read_unlock();
-			getrusage(tsk, RUSAGE_SELF, &sq_usage);
+			usec = io_sq_cpu_usec(tsk);
 			put_task_struct(tsk);
 			sq_pid = sq->task_pid;
 			sq_cpu = sq->sq_cpu;
-			sq_total_time = (sq_usage.ru_stime.tv_sec * 1000000
-					 + sq_usage.ru_stime.tv_usec);
+			sq_total_time = usec;
 			sq_work_time = sq->work_time;
 		} else {
 			rcu_read_unlock();
diff --git a/io_uring/filetable.c b/io_uring/filetable.c
index a21660e3145a..794ef95df293 100644
--- a/io_uring/filetable.c
+++ b/io_uring/filetable.c
@@ -57,7 +57,7 @@ void io_free_file_tables(struct io_ring_ctx *ctx, struct io_file_table *table)
 
 static int io_install_fixed_file(struct io_ring_ctx *ctx, struct file *file,
 				 u32 slot_index)
-	__must_hold(&req->ctx->uring_lock)
+	__must_hold(&ctx->uring_lock)
 {
 	struct io_rsrc_node *node;
 
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index a3f11349ce06..e22f072c7d5f 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -11,6 +11,7 @@
 #include <linux/audit.h>
 #include <linux/security.h>
 #include <linux/cpuset.h>
+#include <linux/sched/cputime.h>
 #include <linux/io_uring.h>
 
 #include <uapi/linux/io_uring.h>
@@ -169,7 +170,38 @@ static inline bool io_sqd_events_pending(struct io_sq_data *sqd)
 	return READ_ONCE(sqd->state);
 }
 
-static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
+struct io_sq_time {
+	bool started;
+	u64 usec;
+};
+
+u64 io_sq_cpu_usec(struct task_struct *tsk)
+{
+	u64 utime, stime;
+
+	task_cputime_adjusted(tsk, &utime, &stime);
+	do_div(stime, 1000);
+	return stime;
+}
+
+static void io_sq_update_worktime(struct io_sq_data *sqd, struct io_sq_time *ist)
+{
+	if (!ist->started)
+		return;
+	ist->started = false;
+	sqd->work_time += io_sq_cpu_usec(current) - ist->usec;
+}
+
+static void io_sq_start_worktime(struct io_sq_time *ist)
+{
+	if (ist->started)
+		return;
+	ist->started = true;
+	ist->usec = io_sq_cpu_usec(current);
+}
+
+static int __io_sq_thread(struct io_ring_ctx *ctx, struct io_sq_data *sqd,
+			  bool cap_entries, struct io_sq_time *ist)
 {
 	unsigned int to_submit;
 	int ret = 0;
@@ -182,6 +214,8 @@ static int __io_sq_thread(struct io_ring_ctx *ctx, bool cap_entries)
 	if (to_submit || !wq_list_empty(&ctx->iopoll_list)) {
 		const struct cred *creds = NULL;
 
+		io_sq_start_worktime(ist);
+
 		if (ctx->sq_creds != current_cred())
 			creds = override_creds(ctx->sq_creds);
 
@@ -255,23 +289,11 @@ static bool io_sq_tw_pending(struct llist_node *retry_list)
 	return retry_list || !llist_empty(&tctx->task_list);
 }
 
-static void io_sq_update_worktime(struct io_sq_data *sqd, struct rusage *start)
-{
-	struct rusage end;
-
-	getrusage(current, RUSAGE_SELF, &end);
-	end.ru_stime.tv_sec -= start->ru_stime.tv_sec;
-	end.ru_stime.tv_usec -= start->ru_stime.tv_usec;
-
-	sqd->work_time += end.ru_stime.tv_usec + end.ru_stime.tv_sec * 1000000;
-}
-
 static int io_sq_thread(void *data)
 {
 	struct llist_node *retry_list = NULL;
 	struct io_sq_data *sqd = data;
 	struct io_ring_ctx *ctx;
-	struct rusage start;
 	unsigned long timeout = 0;
 	char buf[TASK_COMM_LEN] = {};
 	DEFINE_WAIT(wait);
@@ -309,6 +331,7 @@ static int io_sq_thread(void *data)
 	mutex_lock(&sqd->lock);
 	while (1) {
 		bool cap_entries, sqt_spin = false;
+		struct io_sq_time ist = { };
 
 		if (io_sqd_events_pending(sqd) || signal_pending(current)) {
 			if (io_sqd_handle_event(sqd))
@@ -317,9 +340,8 @@ static int io_sq_thread(void *data)
 		}
 
 		cap_entries = !list_is_singular(&sqd->ctx_list);
-		getrusage(current, RUSAGE_SELF, &start);
 		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list) {
-			int ret = __io_sq_thread(ctx, cap_entries);
+			int ret = __io_sq_thread(ctx, sqd, cap_entries, &ist);
 
 			if (!sqt_spin && (ret > 0 || !wq_list_empty(&ctx->iopoll_list)))
 				sqt_spin = true;
@@ -327,15 +349,18 @@ static int io_sq_thread(void *data)
 		if (io_sq_tw(&retry_list, IORING_TW_CAP_ENTRIES_VALUE))
 			sqt_spin = true;
 
-		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list)
-			if (io_napi(ctx))
+		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list) {
+			if (io_napi(ctx)) {
+				io_sq_start_worktime(&ist);
 				io_napi_sqpoll_busy_poll(ctx);
+			}
+		}
+
+		io_sq_update_worktime(sqd, &ist);
 
 		if (sqt_spin || !time_after(jiffies, timeout)) {
-			if (sqt_spin) {
-				io_sq_update_worktime(sqd, &start);
+			if (sqt_spin)
 				timeout = jiffies + sqd->sq_thread_idle;
-			}
 			if (unlikely(need_resched())) {
 				mutex_unlock(&sqd->lock);
 				cond_resched();
diff --git a/io_uring/sqpoll.h b/io_uring/sqpoll.h
index b83dcdec9765..fd2f6f29b516 100644
--- a/io_uring/sqpoll.h
+++ b/io_uring/sqpoll.h
@@ -29,6 +29,7 @@ void io_sq_thread_unpark(struct io_sq_data *sqd);
 void io_put_sq_data(struct io_sq_data *sqd);
 void io_sqpoll_wait_sq(struct io_ring_ctx *ctx);
 int io_sqpoll_wq_cpu_affinity(struct io_ring_ctx *ctx, cpumask_var_t mask);
+u64 io_sq_cpu_usec(struct task_struct *tsk);
 
 static inline struct task_struct *sqpoll_task_locked(struct io_sq_data *sqd)
 {
diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 3101ad8ec0cf..c8ca00e681f7 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -252,7 +252,7 @@ int io_waitid_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return -EINVAL;
 
 	iwa = io_uring_alloc_async_data(NULL, req);
-	if (!unlikely(iwa))
+	if (unlikely(!iwa))
 		return -ENOMEM;
 	iwa->req = req;
 
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index b82399437db0..7458382be840 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -23,6 +23,7 @@
 #include <linux/ctype.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/swiotlb.h>
 #include <asm/sections.h>
 #include "debug.h"
 
@@ -594,7 +595,9 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 	if (rc == -ENOMEM) {
 		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
-	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
+	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
+		     is_swiotlb_active(entry->dev))) {
 		err_printk(entry->dev, entry,
 			"cacheline tracking EEXIST, overlapping mappings aren't supported\n");
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8f0b1acace0a..4770d25ae240 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6969,6 +6969,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	int h_nr_runnable = 0;
 	struct cfs_rq *cfs_rq;
 	u64 slice = 0;
+	int ret = 0;
 
 	if (entity_is_task(se)) {
 		p = task_of(se);
@@ -6998,7 +6999,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			return 0;
+			goto out;
 
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
@@ -7039,7 +7040,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			return 0;
+			goto out;
 	}
 
 	sub_nr_running(rq, h_nr_queued);
@@ -7048,6 +7049,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
+	ret = 1;
+out:
 	if (p && task_delayed) {
 		WARN_ON_ONCE(!task_sleep);
 		WARN_ON_ONCE(p->on_rq != 1);
@@ -7063,7 +7066,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		__block_task(rq, p);
 	}
 
-	return 1;
+	return ret;
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cf2109b67f9a..72fb9129afb6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3735,11 +3735,9 @@ static inline int mm_cid_get(struct rq *rq, struct task_struct *t,
 			     struct mm_struct *mm)
 {
 	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	struct cpumask *cpumask;
 	int cid;
 
 	lockdep_assert_rq_held(rq);
-	cpumask = mm_cidmask(mm);
 	cid = __this_cpu_read(pcpu_cid->cid);
 	if (mm_cid_is_valid(cid)) {
 		mm_cid_snapshot_time(rq, mm);
diff --git a/kernel/trace/rv/monitors/pagefault/Kconfig b/kernel/trace/rv/monitors/pagefault/Kconfig
index 5e16625f1653..0e013f00c33b 100644
--- a/kernel/trace/rv/monitors/pagefault/Kconfig
+++ b/kernel/trace/rv/monitors/pagefault/Kconfig
@@ -5,6 +5,7 @@ config RV_MON_PAGEFAULT
 	select RV_LTL_MONITOR
 	depends on RV_MON_RTAPP
 	depends on X86 || RISCV
+	depends on MMU
 	default y
 	select LTL_MON_EVENTS_ID
 	bool "pagefault monitor"
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 48338520376f..43e9ea473cda 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -501,7 +501,7 @@ static void *enabled_monitors_next(struct seq_file *m, void *p, loff_t *pos)
 
 	list_for_each_entry_continue(mon, &rv_monitors_list, list) {
 		if (mon->enabled)
-			return mon;
+			return &mon->list;
 	}
 
 	return NULL;
@@ -509,7 +509,7 @@ static void *enabled_monitors_next(struct seq_file *m, void *p, loff_t *pos)
 
 static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
 {
-	struct rv_monitor *mon;
+	struct list_head *head;
 	loff_t l;
 
 	mutex_lock(&rv_interface_lock);
@@ -517,15 +517,15 @@ static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
 	if (list_empty(&rv_monitors_list))
 		return NULL;
 
-	mon = list_entry(&rv_monitors_list, struct rv_monitor, list);
+	head = &rv_monitors_list;
 
 	for (l = 0; l <= *pos; ) {
-		mon = enabled_monitors_next(m, mon, &l);
-		if (!mon)
+		head = enabled_monitors_next(m, head, &l);
+		if (!head)
 			break;
 	}
 
-	return mon;
+	return head;
 }
 
 /*
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 08065b363972..533c1c2d72f2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -451,6 +451,9 @@ void damon_destroy_scheme(struct damos *s)
 	damos_for_each_filter_safe(f, next, s)
 		damos_destroy_filter(f);
 
+	damos_for_each_ops_filter_safe(f, next, s)
+		damos_destroy_filter(f);
+
 	kfree(s->migrate_dests.node_id_arr);
 	kfree(s->migrate_dests.weight_arr);
 	damon_del_scheme(s);
@@ -811,7 +814,7 @@ int damos_commit_quota_goals(struct damos_quota *dst, struct damos_quota *src)
 				src_goal->metric, src_goal->target_value);
 		if (!new_goal)
 			return -ENOMEM;
-		damos_commit_quota_goal_union(new_goal, src_goal);
+		damos_commit_quota_goal(new_goal, src_goal);
 		damos_add_quota_goal(dst, new_goal);
 	}
 	return 0;
@@ -1422,7 +1425,7 @@ int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 	INIT_LIST_HEAD(&control->list);
 
 	mutex_lock(&ctx->call_controls_lock);
-	list_add_tail(&ctx->call_controls, &control->list);
+	list_add_tail(&control->list, &ctx->call_controls);
 	mutex_unlock(&ctx->call_controls_lock);
 	if (!damon_is_running(ctx))
 		return -EINVAL;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7308dee97b21..2959beb4bcbf 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1435,13 +1435,14 @@ static int damon_sysfs_commit_input(void *data)
 	if (IS_ERR(param_ctx))
 		return PTR_ERR(param_ctx);
 	test_ctx = damon_new_ctx();
+	if (!test_ctx)
+		return -ENOMEM;
 	err = damon_commit_ctx(test_ctx, param_ctx);
-	if (err) {
-		damon_destroy_ctx(test_ctx);
+	if (err)
 		goto out;
-	}
 	err = damon_commit_ctx(kdamond->damon_ctx, param_ctx);
 out:
+	damon_destroy_ctx(test_ctx);
 	damon_destroy_ctx(param_ctx);
 	return err;
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index fceaf965f264..24cb81c8d838 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4120,6 +4120,9 @@ static bool thp_underused(struct folio *folio)
 	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
 		return false;
 
+	if (folio_contain_hwpoisoned_page(folio))
+		return false;
+
 	for (i = 0; i < folio_nr_pages(folio); i++) {
 		if (pages_identical(folio_page(folio, i), ZERO_PAGE(0))) {
 			if (++num_zero_pages > khugepaged_max_ptes_none)
diff --git a/mm/migrate.c b/mm/migrate.c
index 4ff6eea0ef7e..db92d6d8e510 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -231,18 +231,17 @@ static void putback_movable_ops_page(struct page *page)
  * src and dst are also released by migration core. These pages will not be
  * folios in the future, so that must be reworked.
  *
- * Returns MIGRATEPAGE_SUCCESS on success, otherwise a negative error
- * code.
+ * Returns 0 on success, otherwise a negative error code.
  */
 static int migrate_movable_ops_page(struct page *dst, struct page *src,
 		enum migrate_mode mode)
 {
-	int rc = MIGRATEPAGE_SUCCESS;
+	int rc;
 
 	VM_WARN_ON_ONCE_PAGE(!page_has_movable_ops(src), src);
 	VM_WARN_ON_ONCE_PAGE(!PageMovableOpsIsolated(src), src);
 	rc = page_movable_ops(src)->migrate_page(dst, src, mode);
-	if (rc == MIGRATEPAGE_SUCCESS)
+	if (!rc)
 		ClearPageMovableOpsIsolated(src);
 	return rc;
 }
@@ -302,8 +301,9 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 	struct page *page = folio_page(folio, idx);
 	pte_t newpte;
 
-	if (PageCompound(page))
+	if (PageCompound(page) || PageHWPoison(page))
 		return false;
+
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(pte_present(old_pte), page);
@@ -586,7 +586,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 		if (folio_test_swapbacked(folio))
 			__folio_set_swapbacked(newfolio);
 
-		return MIGRATEPAGE_SUCCESS;
+		return 0;
 	}
 
 	oldzone = folio_zone(folio);
@@ -687,7 +687,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	}
 	local_irq_enable();
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 
 int folio_migrate_mapping(struct address_space *mapping,
@@ -736,7 +736,7 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 
 	xas_unlock_irq(&xas);
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 
 /*
@@ -852,14 +852,14 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 		return rc;
 
 	rc = __folio_migrate_mapping(mapping, dst, src, expected_count);
-	if (rc != MIGRATEPAGE_SUCCESS)
+	if (rc)
 		return rc;
 
 	if (src_private)
 		folio_attach_private(dst, folio_detach_private(src));
 
 	folio_migrate_flags(dst, src);
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 
 /**
@@ -966,7 +966,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 	}
 
 	rc = filemap_migrate_folio(mapping, dst, src, mode);
-	if (rc != MIGRATEPAGE_SUCCESS)
+	if (rc)
 		goto unlock_buffers;
 
 	bh = head;
@@ -1070,7 +1070,7 @@ static int fallback_migrate_folio(struct address_space *mapping,
  *
  * Return value:
  *   < 0 - error code
- *  MIGRATEPAGE_SUCCESS - success
+ *     0 - success
  */
 static int move_to_new_folio(struct folio *dst, struct folio *src,
 				enum migrate_mode mode)
@@ -1098,7 +1098,7 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 	else
 		rc = fallback_migrate_folio(mapping, dst, src, mode);
 
-	if (rc == MIGRATEPAGE_SUCCESS) {
+	if (!rc) {
 		/*
 		 * For pagecache folios, src->mapping must be cleared before src
 		 * is freed. Anonymous folios must stay anonymous until freed.
@@ -1188,7 +1188,7 @@ static void migrate_folio_done(struct folio *src,
 static int migrate_folio_unmap(new_folio_t get_new_folio,
 		free_folio_t put_new_folio, unsigned long private,
 		struct folio *src, struct folio **dstp, enum migrate_mode mode,
-		enum migrate_reason reason, struct list_head *ret)
+		struct list_head *ret)
 {
 	struct folio *dst;
 	int rc = -EAGAIN;
@@ -1197,16 +1197,6 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	bool locked = false;
 	bool dst_locked = false;
 
-	if (folio_ref_count(src) == 1) {
-		/* Folio was freed from under us. So we are done. */
-		folio_clear_active(src);
-		folio_clear_unevictable(src);
-		/* free_pages_prepare() will clear PG_isolated. */
-		list_del(&src->lru);
-		migrate_folio_done(src, reason);
-		return MIGRATEPAGE_SUCCESS;
-	}
-
 	dst = get_new_folio(src, private);
 	if (!dst)
 		return -ENOMEM;
@@ -1296,7 +1286,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 
 	if (unlikely(page_has_movable_ops(&src->page))) {
 		__migrate_folio_record(dst, old_page_state, anon_vma);
-		return MIGRATEPAGE_UNMAP;
+		return 0;
 	}
 
 	/*
@@ -1326,7 +1316,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 
 	if (!folio_mapped(src)) {
 		__migrate_folio_record(dst, old_page_state, anon_vma);
-		return MIGRATEPAGE_UNMAP;
+		return 0;
 	}
 
 out:
@@ -1458,7 +1448,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 	if (folio_ref_count(src) == 1) {
 		/* page was freed from under us. So we are done. */
 		folio_putback_hugetlb(src);
-		return MIGRATEPAGE_SUCCESS;
+		return 0;
 	}
 
 	dst = get_new_folio(src, private);
@@ -1521,8 +1511,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 		rc = move_to_new_folio(dst, src, mode);
 
 	if (page_was_mapped)
-		remove_migration_ptes(src,
-			rc == MIGRATEPAGE_SUCCESS ? dst : src, 0);
+		remove_migration_ptes(src, !rc ? dst : src, 0);
 
 unlock_put_anon:
 	folio_unlock(dst);
@@ -1531,7 +1520,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 	if (anon_vma)
 		put_anon_vma(anon_vma);
 
-	if (rc == MIGRATEPAGE_SUCCESS) {
+	if (!rc) {
 		move_hugetlb_state(src, dst, reason);
 		put_new_folio = NULL;
 	}
@@ -1539,7 +1528,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 out_unlock:
 	folio_unlock(src);
 out:
-	if (rc == MIGRATEPAGE_SUCCESS)
+	if (!rc)
 		folio_putback_hugetlb(src);
 	else if (rc != -EAGAIN)
 		list_move_tail(&src->lru, ret);
@@ -1649,7 +1638,7 @@ static int migrate_hugetlbs(struct list_head *from, new_folio_t get_new_folio,
 						      reason, ret_folios);
 			/*
 			 * The rules are:
-			 *	Success: hugetlb folio will be put back
+			 *	0: hugetlb folio will be put back
 			 *	-EAGAIN: stay on the from list
 			 *	-ENOMEM: stay on the from list
 			 *	Other errno: put on ret_folios list
@@ -1666,7 +1655,7 @@ static int migrate_hugetlbs(struct list_head *from, new_folio_t get_new_folio,
 				retry++;
 				nr_retry_pages += nr_pages;
 				break;
-			case MIGRATEPAGE_SUCCESS:
+			case 0:
 				stats->nr_succeeded += nr_pages;
 				break;
 			default:
@@ -1720,7 +1709,7 @@ static void migrate_folios_move(struct list_head *src_folios,
 				reason, ret_folios);
 		/*
 		 * The rules are:
-		 *	Success: folio will be freed
+		 *	0: folio will be freed
 		 *	-EAGAIN: stay on the unmap_folios list
 		 *	Other errno: put on ret_folios list
 		 */
@@ -1730,7 +1719,7 @@ static void migrate_folios_move(struct list_head *src_folios,
 			*thp_retry += is_thp;
 			*nr_retry_pages += nr_pages;
 			break;
-		case MIGRATEPAGE_SUCCESS:
+		case 0:
 			stats->nr_succeeded += nr_pages;
 			stats->nr_thp_succeeded += is_thp;
 			break;
@@ -1869,14 +1858,27 @@ static int migrate_pages_batch(struct list_head *from,
 				continue;
 			}
 
+			/*
+			 * If we are holding the last folio reference, the folio
+			 * was freed from under us, so just drop our reference.
+			 */
+			if (likely(!page_has_movable_ops(&folio->page)) &&
+			    folio_ref_count(folio) == 1) {
+				folio_clear_active(folio);
+				folio_clear_unevictable(folio);
+				list_del(&folio->lru);
+				migrate_folio_done(folio, reason);
+				stats->nr_succeeded += nr_pages;
+				stats->nr_thp_succeeded += is_thp;
+				continue;
+			}
+
 			rc = migrate_folio_unmap(get_new_folio, put_new_folio,
-					private, folio, &dst, mode, reason,
-					ret_folios);
+					private, folio, &dst, mode, ret_folios);
 			/*
 			 * The rules are:
-			 *	Success: folio will be freed
-			 *	Unmap: folio will be put on unmap_folios list,
-			 *	       dst folio put on dst_folios list
+			 *	0: folio will be put on unmap_folios list,
+			 *	   dst folio put on dst_folios list
 			 *	-EAGAIN: stay on the from list
 			 *	-ENOMEM: stay on the from list
 			 *	Other errno: put on ret_folios list
@@ -1926,11 +1928,7 @@ static int migrate_pages_batch(struct list_head *from,
 				thp_retry += is_thp;
 				nr_retry_pages += nr_pages;
 				break;
-			case MIGRATEPAGE_SUCCESS:
-				stats->nr_succeeded += nr_pages;
-				stats->nr_thp_succeeded += is_thp;
-				break;
-			case MIGRATEPAGE_UNMAP:
+			case 0:
 				list_move_tail(&folio->lru, &unmap_folios);
 				list_add_tail(&dst->lru, &dst_folios);
 				break;
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index e05e14d6eacd..abd9f6850db6 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -778,7 +778,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 		if (migrate && migrate->fault_page == page)
 			extra_cnt = 1;
 		r = folio_migrate_mapping(mapping, newfolio, folio, extra_cnt);
-		if (r != MIGRATEPAGE_SUCCESS)
+		if (r)
 			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
 		else
 			folio_migrate_flags(newfolio, folio);
diff --git a/mm/mremap.c b/mm/mremap.c
index 35de0a7b910e..bd7314898ec5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1237,10 +1237,10 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 }
 
 /*
- * Perform final tasks for MADV_DONTUNMAP operation, clearing mlock() and
- * account flags on remaining VMA by convention (it cannot be mlock()'d any
- * longer, as pages in range are no longer mapped), and removing anon_vma_chain
- * links from it (if the entire VMA was copied over).
+ * Perform final tasks for MADV_DONTUNMAP operation, clearing mlock() flag on
+ * remaining VMA by convention (it cannot be mlock()'d any longer, as pages in
+ * range are no longer mapped), and removing anon_vma_chain links from it if the
+ * entire VMA was copied over.
  */
 static void dontunmap_complete(struct vma_remap_struct *vrm,
 			       struct vm_area_struct *new_vma)
@@ -1250,11 +1250,8 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
 	unsigned long old_start = vrm->vma->vm_start;
 	unsigned long old_end = vrm->vma->vm_end;
 
-	/*
-	 * We always clear VM_LOCKED[ONFAULT] | VM_ACCOUNT on the old
-	 * vma.
-	 */
-	vm_flags_clear(vrm->vma, VM_LOCKED_MASK | VM_ACCOUNT);
+	/* We always clear VM_LOCKED[ONFAULT] on the old VMA. */
+	vm_flags_clear(vrm->vma, VM_LOCKED_MASK);
 
 	/*
 	 * anon_vma links of the old vma is no longer needed after its page
diff --git a/mm/page_owner.c b/mm/page_owner.c
index c3ca21132c2c..589ec37c94aa 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -168,6 +168,9 @@ static void add_stack_record_to_list(struct stack_record *stack_record,
 	unsigned long flags;
 	struct stack *stack;
 
+	if (!gfpflags_allow_spinning(gfp_mask))
+		return;
+
 	set_current_in_page_owner();
 	stack = kmalloc(sizeof(*stack), gfp_nested_mask(gfp_mask));
 	if (!stack) {
diff --git a/mm/slub.c b/mm/slub.c
index 16b5e221c94d..2bf22bfce846 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1976,9 +1976,9 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 	}
 }
 
-static inline void mark_failed_objexts_alloc(struct slab *slab)
+static inline bool mark_failed_objexts_alloc(struct slab *slab)
 {
-	slab->obj_exts = OBJEXTS_ALLOC_FAIL;
+	return cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL) == 0;
 }
 
 static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
@@ -2000,7 +2000,7 @@ static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
 #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
 
 static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
-static inline void mark_failed_objexts_alloc(struct slab *slab) {}
+static inline bool mark_failed_objexts_alloc(struct slab *slab) { return false; }
 static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
 			struct slabobj_ext *vec, unsigned int objects) {}
 
@@ -2033,8 +2033,14 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
 			   slab_nid(slab));
 	if (!vec) {
-		/* Mark vectors which failed to allocate */
-		mark_failed_objexts_alloc(slab);
+		/*
+		 * Try to mark vectors which failed to allocate.
+		 * If this operation fails, there may be a racing process
+		 * that has already completed the allocation.
+		 */
+		if (!mark_failed_objexts_alloc(slab) &&
+		    slab_obj_exts(slab))
+			return 0;
 
 		return -ENOMEM;
 	}
@@ -2043,6 +2049,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 #ifdef CONFIG_MEMCG
 	new_exts |= MEMCG_DATA_OBJEXTS;
 #endif
+retry:
 	old_exts = READ_ONCE(slab->obj_exts);
 	handle_failed_objexts_alloc(old_exts, vec, objects);
 	if (new_slab) {
@@ -2052,8 +2059,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		 * be simply assigned.
 		 */
 		slab->obj_exts = new_exts;
-	} else if ((old_exts & ~OBJEXTS_FLAGS_MASK) ||
-		   cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
+	} else if (old_exts & ~OBJEXTS_FLAGS_MASK) {
 		/*
 		 * If the slab is already in use, somebody can allocate and
 		 * assign slabobj_exts in parallel. In this case the existing
@@ -2062,6 +2068,9 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		mark_objexts_empty(vec);
 		kfree(vec);
 		return 0;
+	} else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
+		/* Retry if a racing thread changed slab->obj_exts from under us. */
+		goto retry;
 	}
 
 	kmemleak_not_leak(vec);
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 805a10b41266..153783d49d34 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1746,7 +1746,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	 * instead.
 	 */
 	if (!zpdesc->zspage)
-		return MIGRATEPAGE_SUCCESS;
+		return 0;
 
 	/* The page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
@@ -1813,7 +1813,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	reset_zpdesc(zpdesc);
 	zpdesc_put(zpdesc);
 
-	return MIGRATEPAGE_SUCCESS;
+	return 0;
 }
 
 static void zs_page_putback(struct page *page)
diff --git a/net/core/datagram.c b/net/core/datagram.c
index f474b9b120f9..8b328879f8d2 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -920,21 +920,22 @@ int skb_copy_and_csum_datagram_msg(struct sk_buff *skb,
 EXPORT_SYMBOL(skb_copy_and_csum_datagram_msg);
 
 /**
- * 	datagram_poll - generic datagram poll
+ *	datagram_poll_queue - same as datagram_poll, but on a specific receive
+ *		queue
  *	@file: file struct
  *	@sock: socket
  *	@wait: poll table
+ *	@rcv_queue: receive queue to poll
  *
- *	Datagram poll: Again totally generic. This also handles
- *	sequenced packet sockets providing the socket receive queue
- *	is only ever holding data ready to receive.
+ *	Performs polling on the given receive queue, handling shutdown, error,
+ *	and connection state. This is useful for protocols that deliver
+ *	userspace-bound packets through a custom queue instead of
+ *	sk->sk_receive_queue.
  *
- *	Note: when you *don't* use this routine for this protocol,
- *	and you use a different write policy from sock_writeable()
- *	then please supply your own write_space callback.
+ *	Return: poll bitmask indicating the socket's current state
  */
-__poll_t datagram_poll(struct file *file, struct socket *sock,
-			   poll_table *wait)
+__poll_t datagram_poll_queue(struct file *file, struct socket *sock,
+			     poll_table *wait, struct sk_buff_head *rcv_queue)
 {
 	struct sock *sk = sock->sk;
 	__poll_t mask;
@@ -956,7 +957,7 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLHUP;
 
 	/* readable? */
-	if (!skb_queue_empty_lockless(&sk->sk_receive_queue))
+	if (!skb_queue_empty_lockless(rcv_queue))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
 	/* Connection-based need to check for termination and startup */
@@ -978,4 +979,27 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 
 	return mask;
 }
+EXPORT_SYMBOL(datagram_poll_queue);
+
+/**
+ *	datagram_poll - generic datagram poll
+ *	@file: file struct
+ *	@sock: socket
+ *	@wait: poll table
+ *
+ *	Datagram poll: Again totally generic. This also handles
+ *	sequenced packet sockets providing the socket receive queue
+ *	is only ever holding data ready to receive.
+ *
+ *	Note: when you *don't* use this routine for this protocol,
+ *	and you use a different write policy from sock_writeable()
+ *	then please supply your own write_space callback.
+ *
+ *	Return: poll bitmask indicating the socket's current state
+ */
+__poll_t datagram_poll(struct file *file, struct socket *sock, poll_table *wait)
+{
+	return datagram_poll_queue(file, sock, wait,
+				   &sock->sk->sk_receive_queue);
+}
 EXPORT_SYMBOL(datagram_poll);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 094b085cff20..8f3fd52f089d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4707,9 +4707,6 @@ static int rtnl_fdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int err;
 	u16 vid;
 
-	if (!netlink_capable(skb, CAP_NET_ADMIN))
-		return -EPERM;
-
 	if (!del_bulk) {
 		err = nlmsg_parse_deprecated(nlh, sizeof(*ndm), tb, NDA_MAX,
 					     NULL, extack);
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index b120470246cc..c96b63adf96f 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -34,12 +34,18 @@ static int hsr_newlink(struct net_device *dev,
 		       struct netlink_ext_ack *extack)
 {
 	struct net *link_net = rtnl_newlink_link_net(params);
+	struct net_device *link[2], *interlink = NULL;
 	struct nlattr **data = params->data;
 	enum hsr_version proto_version;
 	unsigned char multicast_spec;
 	u8 proto = HSR_PROTOCOL_HSR;
 
-	struct net_device *link[2], *interlink = NULL;
+	if (!net_eq(link_net, dev_net(dev))) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "HSR slaves/interlink must be on the same net namespace than HSR link");
+		return -EINVAL;
+	}
+
 	if (!data) {
 		NL_SET_ERR_MSG_MOD(extack, "No slave devices specified");
 		return -EINVAL;
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 8c46493a0835..07f50d0304cf 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -333,6 +333,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	}
 
 subflow:
+	/* No need to try establishing subflows to remote id0 if not allowed */
+	if (mptcp_pm_add_addr_c_flag_case(msk))
+		goto exit;
+
 	/* check if should create a new subflow */
 	while (msk->pm.local_addr_used < local_addr_max &&
 	       msk->pm.subflows < subflows_max) {
@@ -364,6 +368,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			__mptcp_subflow_connect(sk, &local, &addrs[i]);
 		spin_lock_bh(&msk->pm.lock);
 	}
+
+exit:
 	mptcp_pm_nl_check_work_pending(msk);
 }
 
diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 5c1652181805..f5a7d5a38755 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -169,13 +169,14 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 				chunk->head_skb = chunk->skb;
 
 			/* skbs with "cover letter" */
-			if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len)
+			if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len) {
+				if (WARN_ON(!skb_shinfo(chunk->skb)->frag_list)) {
+					__SCTP_INC_STATS(dev_net(chunk->skb->dev),
+							 SCTP_MIB_IN_PKT_DISCARDS);
+					sctp_chunk_free(chunk);
+					goto next_chunk;
+				}
 				chunk->skb = skb_shinfo(chunk->skb)->frag_list;
-
-			if (WARN_ON(!chunk->skb)) {
-				__SCTP_INC_STATS(dev_net(chunk->skb->dev), SCTP_MIB_IN_PKT_DISCARDS);
-				sctp_chunk_free(chunk);
-				goto next_chunk;
 			}
 		}
 
diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index a944e7dcb8b9..a94084b4a498 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -56,7 +56,6 @@ static struct inet_protosw smc_inet_protosw = {
 	.protocol	= IPPROTO_SMC,
 	.prot		= &smc_inet_prot,
 	.ops		= &smc_inet_stream_ops,
-	.flags		= INET_PROTOSW_ICSK,
 };
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -104,27 +103,15 @@ static struct inet_protosw smc_inet6_protosw = {
 	.protocol	= IPPROTO_SMC,
 	.prot		= &smc_inet6_prot,
 	.ops		= &smc_inet6_stream_ops,
-	.flags		= INET_PROTOSW_ICSK,
 };
 #endif /* CONFIG_IPV6 */
 
-static unsigned int smc_sync_mss(struct sock *sk, u32 pmtu)
-{
-	/* No need pass it through to clcsock, mss can always be set by
-	 * sock_create_kern or smc_setsockopt.
-	 */
-	return 0;
-}
-
 static int smc_inet_init_sock(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
 
 	/* init common smc sock */
 	smc_sk_init(net, sk, IPPROTO_SMC);
-
-	inet_csk(sk)->icsk_sync_mss = smc_sync_mss;
-
 	/* create clcsock */
 	return smc_create_clcsk(net, sk, sk->sk_family);
 }
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index bebb355f3ffe..21758f59edc1 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -487,12 +487,26 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		goto err;
 	}
 
-	if (vsk->transport) {
-		if (vsk->transport == new_transport) {
-			ret = 0;
-			goto err;
-		}
+	if (vsk->transport && vsk->transport == new_transport) {
+		ret = 0;
+		goto err;
+	}
 
+	/* We increase the module refcnt to prevent the transport unloading
+	 * while there are open sockets assigned to it.
+	 */
+	if (!new_transport || !try_module_get(new_transport->module)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* It's safe to release the mutex after a successful try_module_get().
+	 * Whichever transport `new_transport` points at, it won't go away until
+	 * the last module_put() below or in vsock_deassign_transport().
+	 */
+	mutex_unlock(&vsock_register_mutex);
+
+	if (vsk->transport) {
 		/* transport->release() must be called with sock lock acquired.
 		 * This path can only be taken during vsock_connect(), where we
 		 * have already held the sock lock. In the other cases, this
@@ -512,20 +526,6 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		vsk->peer_shutdown = 0;
 	}
 
-	/* We increase the module refcnt to prevent the transport unloading
-	 * while there are open sockets assigned to it.
-	 */
-	if (!new_transport || !try_module_get(new_transport->module)) {
-		ret = -ENODEV;
-		goto err;
-	}
-
-	/* It's safe to release the mutex after a successful try_module_get().
-	 * Whichever transport `new_transport` points at, it won't go away until
-	 * the last module_put() below or in vsock_deassign_transport().
-	 */
-	mutex_unlock(&vsock_register_mutex);
-
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
 		    !new_transport->seqpacket_allow(remote_cid)) {
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index fc7a603b04f1..bf744ac9d5a7 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -555,14 +555,10 @@ static void espintcp_close(struct sock *sk, long timeout)
 static __poll_t espintcp_poll(struct file *file, struct socket *sock,
 			      poll_table *wait)
 {
-	__poll_t mask = datagram_poll(file, sock, wait);
 	struct sock *sk = sock->sk;
 	struct espintcp_ctx *ctx = espintcp_getctx(sk);
 
-	if (!skb_queue_empty(&ctx->ike_queue))
-		mask |= EPOLLIN | EPOLLRDNORM;
-
-	return mask;
+	return datagram_poll_queue(file, sock, wait, &ctx->ike_queue);
 }
 
 static void build_protos(struct proto *espintcp_prot,
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 4749fb6bffef..3f7198e158ba 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -217,13 +217,7 @@ pub fn id(&self) -> u32 {
 
     /// Returns a reference to the parent [`device::Device`], if any.
     pub fn parent(&self) -> Option<&device::Device> {
-        let ptr: *const Self = self;
-        // CAST: `Device<Ctx: DeviceContext>` types are transparent to each other.
-        let ptr: *const Device = ptr.cast();
-        // SAFETY: `ptr` was derived from `&self`.
-        let this = unsafe { &*ptr };
-
-        this.as_ref().parent()
+        self.as_ref().parent()
     }
 }
 
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index a1db49eb159a..e1a1c3e7f694 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -250,7 +250,7 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device {
 
     /// Returns a reference to the parent device, if any.
     #[cfg_attr(not(CONFIG_AUXILIARY_BUS), expect(dead_code))]
-    pub(crate) fn parent(&self) -> Option<&Self> {
+    pub(crate) fn parent(&self) -> Option<&Device> {
         // SAFETY:
         // - By the type invariant `self.as_raw()` is always valid.
         // - The parent device is only ever set at device creation.
@@ -263,7 +263,7 @@ pub(crate) fn parent(&self) -> Option<&Self> {
             // - Since `parent` is not NULL, it must be a valid pointer to a `struct device`.
             // - `parent` is valid for the lifetime of `self`, since a `struct device` holds a
             //   reference count of its parent.
-            Some(unsafe { Self::from_raw(parent) })
+            Some(unsafe { Device::from_raw(parent) })
         }
     }
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d14f20ef1db1..d23fefcb15d3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -217,6 +217,7 @@ static bool is_rust_noreturn(const struct symbol *func)
 	 * these come from the Rust standard library).
 	 */
 	return str_ends_with(func->name, "_4core5sliceSp15copy_from_slice17len_mismatch_fail")		||
+	       str_ends_with(func->name, "_4core6option13expect_failed")				||
 	       str_ends_with(func->name, "_4core6option13unwrap_failed")				||
 	       str_ends_with(func->name, "_4core6result13unwrap_failed")				||
 	       str_ends_with(func->name, "_4core9panicking5panic")					||
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8e92dfead43b..5579709c3653 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3751,7 +3751,7 @@ endpoint_tests()
 	# subflow_rebuild_header is needed to support the implicit flag
 	# userspace pm type prevents add_addr
 	if reset "implicit EP" &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -3776,7 +3776,7 @@ endpoint_tests()
 	fi
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		start_events
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 0 3
@@ -3852,7 +3852,7 @@ endpoint_tests()
 
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=0
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 3 3
@@ -3927,7 +3927,7 @@ endpoint_tests()
 
 	# flush and re-add
 	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 1 2
 		# broadcast IP: no packet for this address will be received on ns1
diff --git a/tools/testing/selftests/net/sctp_hello.c b/tools/testing/selftests/net/sctp_hello.c
index f02f1f95d227..a04dac0b8027 100644
--- a/tools/testing/selftests/net/sctp_hello.c
+++ b/tools/testing/selftests/net/sctp_hello.c
@@ -29,7 +29,6 @@ static void set_addr(struct sockaddr_storage *ss, char *ip, char *port, int *len
 static int do_client(int argc, char *argv[])
 {
 	struct sockaddr_storage ss;
-	char buf[] = "hello";
 	int csk, ret, len;
 
 	if (argc < 5) {
@@ -56,16 +55,10 @@ static int do_client(int argc, char *argv[])
 
 	set_addr(&ss, argv[3], argv[4], &len);
 	ret = connect(csk, (struct sockaddr *)&ss, len);
-	if (ret < 0) {
-		printf("failed to connect to peer\n");
+	if (ret < 0)
 		return -1;
-	}
 
-	ret = send(csk, buf, strlen(buf) + 1, 0);
-	if (ret < 0) {
-		printf("failed to send msg %d\n", ret);
-		return -1;
-	}
+	recv(csk, NULL, 0, 0);
 	close(csk);
 
 	return 0;
@@ -75,7 +68,6 @@ int main(int argc, char *argv[])
 {
 	struct sockaddr_storage ss;
 	int lsk, csk, ret, len;
-	char buf[20];
 
 	if (argc < 2 || (strcmp(argv[1], "server") && strcmp(argv[1], "client"))) {
 		printf("%s server|client ...\n", argv[0]);
@@ -125,11 +117,6 @@ int main(int argc, char *argv[])
 		return -1;
 	}
 
-	ret = recv(csk, buf, sizeof(buf), 0);
-	if (ret <= 0) {
-		printf("failed to recv msg %d\n", ret);
-		return -1;
-	}
 	close(csk);
 	close(lsk);
 
diff --git a/tools/testing/selftests/net/sctp_vrf.sh b/tools/testing/selftests/net/sctp_vrf.sh
index c854034b6aa1..667b211aa8a1 100755
--- a/tools/testing/selftests/net/sctp_vrf.sh
+++ b/tools/testing/selftests/net/sctp_vrf.sh
@@ -20,9 +20,9 @@ setup() {
 	modprobe sctp_diag
 	setup_ns CLIENT_NS1 CLIENT_NS2 SERVER_NS
 
-	ip net exec $CLIENT_NS1 sysctl -w net.ipv6.conf.default.accept_dad=0 2>&1 >/dev/null
-	ip net exec $CLIENT_NS2 sysctl -w net.ipv6.conf.default.accept_dad=0 2>&1 >/dev/null
-	ip net exec $SERVER_NS sysctl -w net.ipv6.conf.default.accept_dad=0 2>&1 >/dev/null
+	ip net exec $CLIENT_NS1 sysctl -wq net.ipv6.conf.default.accept_dad=0
+	ip net exec $CLIENT_NS2 sysctl -wq net.ipv6.conf.default.accept_dad=0
+	ip net exec $SERVER_NS sysctl -wq net.ipv6.conf.default.accept_dad=0
 
 	ip -n $SERVER_NS link add veth1 type veth peer name veth1 netns $CLIENT_NS1
 	ip -n $SERVER_NS link add veth2 type veth peer name veth1 netns $CLIENT_NS2
@@ -62,17 +62,40 @@ setup() {
 }
 
 cleanup() {
-	ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
+	wait_client $CLIENT_NS1
+	wait_client $CLIENT_NS2
+	stop_server
 	cleanup_ns $CLIENT_NS1 $CLIENT_NS2 $SERVER_NS
 }
 
-wait_server() {
+start_server() {
 	local IFACE=$1
 	local CNT=0
 
-	until ip netns exec $SERVER_NS ss -lS src $SERVER_IP:$SERVER_PORT | \
-		grep LISTEN | grep "$IFACE" 2>&1 >/dev/null; do
-		[ $((CNT++)) = "20" ] && { RET=3; return $RET; }
+	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP $SERVER_PORT $IFACE &
+	disown
+	until ip netns exec $SERVER_NS ss -SlH | grep -q "$IFACE"; do
+		[ $((CNT++)) -eq 30 ] && { RET=3; return $RET; }
+		sleep 0.1
+	done
+}
+
+stop_server() {
+	local CNT=0
+
+	ip netns exec $SERVER_NS pkill sctp_hello
+	while ip netns exec $SERVER_NS ss -SaH | grep -q .; do
+		[ $((CNT++)) -eq 30 ] && break
+		sleep 0.1
+	done
+}
+
+wait_client() {
+	local CLIENT_NS=$1
+	local CNT=0
+
+	while ip netns exec $CLIENT_NS ss -SaH | grep -q .; do
+		[ $((CNT++)) -eq 30 ] && break
 		sleep 0.1
 	done
 }
@@ -81,14 +104,12 @@ do_test() {
 	local CLIENT_NS=$1
 	local IFACE=$2
 
-	ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
-	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
-		$SERVER_PORT $IFACE 2>&1 >/dev/null &
-	disown
-	wait_server $IFACE || return $RET
+	start_server $IFACE || return $RET
 	timeout 3 ip netns exec $CLIENT_NS ./sctp_hello client $AF \
-		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT
 	RET=$?
+	wait_client $CLIENT_NS
+	stop_server
 	return $RET
 }
 
@@ -96,25 +117,21 @@ do_testx() {
 	local IFACE1=$1
 	local IFACE2=$2
 
-	ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
-	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
-		$SERVER_PORT $IFACE1 2>&1 >/dev/null &
-	disown
-	wait_server $IFACE1 || return $RET
-	ip netns exec $SERVER_NS ./sctp_hello server $AF $SERVER_IP \
-		$SERVER_PORT $IFACE2 2>&1 >/dev/null &
-	disown
-	wait_server $IFACE2 || return $RET
+	start_server $IFACE1 || return $RET
+	start_server $IFACE2 || return $RET
 	timeout 3 ip netns exec $CLIENT_NS1 ./sctp_hello client $AF \
-		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null && \
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT && \
 	timeout 3 ip netns exec $CLIENT_NS2 ./sctp_hello client $AF \
-		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT 2>&1 >/dev/null
+		$SERVER_IP $SERVER_PORT $CLIENT_IP $CLIENT_PORT
 	RET=$?
+	wait_client $CLIENT_NS1
+	wait_client $CLIENT_NS2
+	stop_server
 	return $RET
 }
 
 testup() {
-	ip netns exec $SERVER_NS sysctl -w net.sctp.l3mdev_accept=1 2>&1 >/dev/null
+	ip netns exec $SERVER_NS sysctl -wq net.sctp.l3mdev_accept=1
 	echo -n "TEST 01: nobind, connect from client 1, l3mdev_accept=1, Y "
 	do_test $CLIENT_NS1 || { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
@@ -123,7 +140,7 @@ testup() {
 	do_test $CLIENT_NS2 && { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
 
-	ip netns exec $SERVER_NS sysctl -w net.sctp.l3mdev_accept=0 2>&1 >/dev/null
+	ip netns exec $SERVER_NS sysctl -wq net.sctp.l3mdev_accept=0
 	echo -n "TEST 03: nobind, connect from client 1, l3mdev_accept=0, N "
 	do_test $CLIENT_NS1 && { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
@@ -160,7 +177,7 @@ testup() {
 	do_testx vrf-1 vrf-2 || { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
 
-	echo -n "TEST 12: bind vrf-2 & 1 in server, connect from client 1 & 2, N "
+	echo -n "TEST 12: bind vrf-2 & 1 in server, connect from client 1 & 2, Y "
 	do_testx vrf-2 vrf-1 || { echo "[FAIL]"; return $RET; }
 	echo "[PASS]"
 }

