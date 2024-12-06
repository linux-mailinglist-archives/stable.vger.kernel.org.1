Return-Path: <stable+bounces-99402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F24429E718C
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADACE280F1F
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3510D148832;
	Fri,  6 Dec 2024 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xXET9Evc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71301442E8;
	Fri,  6 Dec 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497040; cv=none; b=GOE3O/xFBjxIfVtsZRBi757PIZZ9T5jutqhRSMirAsQt3g6sAksKSWemPfPHRW36BT4+l5xQgg6y7dUtW9o1qe37ipcKrnvuWcAbBj8Jl29+hy53ZV0IjioDSXIuS5nhqa/TM4kqgM0GR1FOcdN3ew1P/lKF3c55VBfSWTEFW20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497040; c=relaxed/simple;
	bh=/PHfPvow6P1cnlPecMip+l+YWAGkbTNQ1tHuxVyYjlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFYwNbtsiVmVVEJ4ydNPJxJ/M+O2/UY35yxoX5XfM2RDYOA78ICIoeTCrEcqWkBwWw1f7VvGopV3ZMsteb2drsLTB4OfrE7NbjTndbMxGNGKUQp33Yc8CJI4iEPuelATQ7fb3lykD9S8sMiks5E5qr0dCscxII4TIvt6RTAZV44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xXET9Evc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCADC4CED1;
	Fri,  6 Dec 2024 14:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497039;
	bh=/PHfPvow6P1cnlPecMip+l+YWAGkbTNQ1tHuxVyYjlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xXET9EvcxkeYHO/gqBrAwdXaIDB/l0ukeYYAzn1UfzF93jVArtRhA3sqyVfyZdpVS
	 D3qBdY63Y8zgWCDRUcgp61FYgCq7SKRykAg9DvkAIBtXqD5NfsTeXh53eF+pmVNpLr
	 WP5zN1ka5T6EuRJIAhFNh27edUlLf16aeMNrRoNY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Usama Arif <usamaarif642@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 145/676] of/fdt: add dt_phys arg to early_init_dt_scan and early_init_dt_verify
Date: Fri,  6 Dec 2024 15:29:24 +0100
Message-ID: <20241206143659.015398961@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Usama Arif <usamaarif642@gmail.com>

[ Upstream commit b2473a359763e27567993e7d8f37de82f57a0829 ]

 __pa() is only intended to be used for linear map addresses and using
it for initial_boot_params which is in fixmap for arm64 will give an
incorrect value. Hence save the physical address when it is known at
boot time when calling early_init_dt_scan for arm64 and use it at kexec
time instead of converting the virtual address using __pa().

Note that arm64 doesn't need the FDT region reserved in the DT as the
kernel explicitly reserves the passed in FDT. Therefore, only a debug
warning is fixed with this change.

Reported-by: Breno Leitao <leitao@debian.org>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
Link: https://lore.kernel.org/r/20241023171426.452688-1-usamaarif642@gmail.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/kernel/devtree.c              |  2 +-
 arch/arm/kernel/devtree.c              |  2 +-
 arch/arm64/kernel/setup.c              |  6 +++++-
 arch/csky/kernel/setup.c               |  4 ++--
 arch/loongarch/kernel/setup.c          |  2 +-
 arch/microblaze/kernel/prom.c          |  2 +-
 arch/mips/kernel/prom.c                |  2 +-
 arch/mips/kernel/relocate.c            |  2 +-
 arch/nios2/kernel/prom.c               |  4 ++--
 arch/openrisc/kernel/prom.c            |  2 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c      |  2 +-
 arch/powerpc/kernel/prom.c             |  2 +-
 arch/powerpc/platforms/pseries/plpks.c |  2 +-
 arch/riscv/kernel/setup.c              |  2 +-
 arch/sh/kernel/setup.c                 |  2 +-
 arch/um/kernel/dtb.c                   |  2 +-
 arch/x86/kernel/devicetree.c           |  2 +-
 arch/xtensa/kernel/setup.c             |  2 +-
 drivers/of/fdt.c                       | 14 ++++++++------
 drivers/of/kexec.c                     |  2 +-
 include/linux/of_fdt.h                 |  5 +++--
 21 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/arch/arc/kernel/devtree.c b/arch/arc/kernel/devtree.c
index 4c9e61457b2f6..cc6ac7d128aa1 100644
--- a/arch/arc/kernel/devtree.c
+++ b/arch/arc/kernel/devtree.c
@@ -62,7 +62,7 @@ const struct machine_desc * __init setup_machine_fdt(void *dt)
 	const struct machine_desc *mdesc;
 	unsigned long dt_root;
 
-	if (!early_init_dt_scan(dt))
+	if (!early_init_dt_scan(dt, __pa(dt)))
 		return NULL;
 
 	mdesc = of_flat_dt_match_machine(NULL, arch_get_next_mach);
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 264827281113b..abf13b21ba76f 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -201,7 +201,7 @@ const struct machine_desc * __init setup_machine_fdt(void *dt_virt)
 
 	mdesc_best = &__mach_desc_GENERIC_DT;
 
-	if (!dt_virt || !early_init_dt_verify(dt_virt))
+	if (!dt_virt || !early_init_dt_verify(dt_virt, __pa(dt_virt)))
 		return NULL;
 
 	mdesc = of_flat_dt_match_machine(mdesc_best, arch_get_next_mach);
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index c583d1f335f8c..040b0175334c0 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -190,7 +190,11 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
 	if (dt_virt)
 		memblock_reserve(dt_phys, size);
 
-	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
+	/*
+	 * dt_virt is a fixmap address, hence __pa(dt_virt) can't be used.
+	 * Pass dt_phys directly.
+	 */
+	if (!early_init_dt_scan(dt_virt, dt_phys)) {
 		pr_crit("\n"
 			"Error: invalid device tree blob at physical address %pa (virtual address 0x%px)\n"
 			"The dtb must be 8-byte aligned and must not exceed 2 MB in size\n"
diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index 106fbf0b6f3b4..2d85484ae0e7e 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -124,9 +124,9 @@ asmlinkage __visible void __init csky_start(unsigned int unused,
 	pre_trap_init();
 
 	if (dtb_start == NULL)
-		early_init_dt_scan(__dtb_start);
+		early_init_dt_scan(__dtb_start, __pa(dtb_start));
 	else
-		early_init_dt_scan(dtb_start);
+		early_init_dt_scan(dtb_start, __pa(dtb_start));
 
 	start_kernel();
 
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 065f2db57c099..7ef1c1ff1fc44 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -304,7 +304,7 @@ static void __init fdt_setup(void)
 	if (!fdt_pointer || fdt_check_header(fdt_pointer))
 		return;
 
-	early_init_dt_scan(fdt_pointer);
+	early_init_dt_scan(fdt_pointer, __pa(fdt_pointer));
 	early_init_fdt_reserve_self();
 
 	max_low_pfn = PFN_PHYS(memblock_end_of_DRAM());
diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index e424c796e297c..76ac4cfdfb42c 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -18,7 +18,7 @@ void __init early_init_devtree(void *params)
 {
 	pr_debug(" -> early_init_devtree(%p)\n", params);
 
-	early_init_dt_scan(params);
+	early_init_dt_scan(params, __pa(params));
 	if (!strlen(boot_command_line))
 		strscpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
 
diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index f88ce78e13e3a..474dc1eec3bb5 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -39,7 +39,7 @@ char *mips_get_machine_name(void)
 
 void __init __dt_setup_arch(void *bph)
 {
-	if (!early_init_dt_scan(bph))
+	if (!early_init_dt_scan(bph, __pa(bph)))
 		return;
 
 	mips_set_machine_name(of_flat_dt_get_machine_name());
diff --git a/arch/mips/kernel/relocate.c b/arch/mips/kernel/relocate.c
index 58fc8d089402b..6d35d4f7ebe19 100644
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -337,7 +337,7 @@ void *__init relocate_kernel(void)
 #if defined(CONFIG_USE_OF)
 	/* Deal with the device tree */
 	fdt = plat_get_fdt();
-	early_init_dt_scan(fdt);
+	early_init_dt_scan(fdt, __pa(fdt));
 	if (boot_command_line[0]) {
 		/* Boot command line was passed in device tree */
 		strscpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
diff --git a/arch/nios2/kernel/prom.c b/arch/nios2/kernel/prom.c
index 8d98af5c7201b..15bbdd78e9bf2 100644
--- a/arch/nios2/kernel/prom.c
+++ b/arch/nios2/kernel/prom.c
@@ -26,12 +26,12 @@ void __init early_init_devtree(void *params)
 	if (be32_to_cpup((__be32 *)CONFIG_NIOS2_DTB_PHYS_ADDR) ==
 		 OF_DT_HEADER) {
 		params = (void *)CONFIG_NIOS2_DTB_PHYS_ADDR;
-		early_init_dt_scan(params);
+		early_init_dt_scan(params, __pa(params));
 		return;
 	}
 #endif
 	if (be32_to_cpu((__be32) *dtb) == OF_DT_HEADER)
 		params = (void *)__dtb_start;
 
-	early_init_dt_scan(params);
+	early_init_dt_scan(params, __pa(params));
 }
diff --git a/arch/openrisc/kernel/prom.c b/arch/openrisc/kernel/prom.c
index 19e6008bf114c..e424e9bd12a79 100644
--- a/arch/openrisc/kernel/prom.c
+++ b/arch/openrisc/kernel/prom.c
@@ -22,6 +22,6 @@
 
 void __init early_init_devtree(void *params)
 {
-	early_init_dt_scan(params);
+	early_init_dt_scan(params, __pa(params));
 	memblock_allow_resize();
 }
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index c3fb9fdf5bd78..a84e75fff1dfe 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -857,7 +857,7 @@ bool __init dt_cpu_ftrs_init(void *fdt)
 	using_dt_cpu_ftrs = false;
 
 	/* Setup and verify the FDT, if it fails we just bail */
-	if (!early_init_dt_verify(fdt))
+	if (!early_init_dt_verify(fdt, __pa(fdt)))
 		return false;
 
 	if (!of_scan_flat_dt(fdt_find_cpu_features, NULL))
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index bf6d8ad3819e9..7d5eccf3f80d9 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -781,7 +781,7 @@ void __init early_init_devtree(void *params)
 	DBG(" -> early_init_devtree(%px)\n", params);
 
 	/* Too early to BUG_ON(), do it by hand */
-	if (!early_init_dt_verify(params))
+	if (!early_init_dt_verify(params, __pa(params)))
 		panic("BUG: Failed verifying flat device tree, bad version?");
 
 	of_scan_flat_dt(early_init_dt_scan_model, NULL);
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index ed492d38f6ad6..fe7a43a8a1f46 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -683,7 +683,7 @@ void __init plpks_early_init_devtree(void)
 out:
 	fdt_nop_property(fdt, chosen_node, "ibm,plpks-pw");
 	// Since we've cleared the password, we must update the FDT checksum
-	early_init_dt_verify(fdt);
+	early_init_dt_verify(fdt, __pa(fdt));
 }
 
 static __init int pseries_plpks_init(void)
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index ddadee6621f0d..1fa501b7d0c86 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -246,7 +246,7 @@ static void __init init_resources(void)
 static void __init parse_dtb(void)
 {
 	/* Early scan of device tree from init memory */
-	if (early_init_dt_scan(dtb_early_va)) {
+	if (early_init_dt_scan(dtb_early_va, __pa(dtb_early_va))) {
 		const char *name = of_flat_dt_get_machine_name();
 
 		if (name) {
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index b3da2757faaf3..1fb59c69b97c8 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -260,7 +260,7 @@ void __ref sh_fdt_init(phys_addr_t dt_phys)
 	dt_virt = phys_to_virt(dt_phys);
 #endif
 
-	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
+	if (!dt_virt || !early_init_dt_scan(dt_virt, __pa(dt_virt))) {
 		pr_crit("Error: invalid device tree blob"
 			" at physical address %p\n", (void *)dt_phys);
 
diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
index 4954188a6a090..8d78ced9e08f6 100644
--- a/arch/um/kernel/dtb.c
+++ b/arch/um/kernel/dtb.c
@@ -17,7 +17,7 @@ void uml_dtb_init(void)
 
 	area = uml_load_file(dtb, &size);
 	if (area) {
-		if (!early_init_dt_scan(area)) {
+		if (!early_init_dt_scan(area, __pa(area))) {
 			pr_err("invalid DTB %s\n", dtb);
 			memblock_free(area, size);
 			return;
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 47fe7de1575dd..37ca25d82bbcd 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -294,7 +294,7 @@ static void __init x86_flattree_get_config(void)
 			map_len = size;
 		}
 
-		early_init_dt_verify(dt);
+		early_init_dt_verify(dt, __pa(dt));
 	}
 
 	unflatten_and_copy_device_tree();
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 52d6e4870a04c..124e84fd9a296 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -228,7 +228,7 @@ static int __init xtensa_dt_io_area(unsigned long node, const char *uname,
 
 void __init early_init_devtree(void *params)
 {
-	early_init_dt_scan(params);
+	early_init_dt_scan(params, __pa(params));
 	of_scan_flat_dt(xtensa_dt_io_area, NULL);
 
 	if (!command_line[0])
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da958..366fbdc56dec1 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -471,6 +471,7 @@ int __initdata dt_root_addr_cells;
 int __initdata dt_root_size_cells;
 
 void *initial_boot_params __ro_after_init;
+phys_addr_t initial_boot_params_pa __ro_after_init;
 
 #ifdef CONFIG_OF_EARLY_FLATTREE
 
@@ -1270,17 +1271,18 @@ static void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
 	return ptr;
 }
 
-bool __init early_init_dt_verify(void *params)
+bool __init early_init_dt_verify(void *dt_virt, phys_addr_t dt_phys)
 {
-	if (!params)
+	if (!dt_virt)
 		return false;
 
 	/* check device tree validity */
-	if (fdt_check_header(params))
+	if (fdt_check_header(dt_virt))
 		return false;
 
 	/* Setup flat device-tree pointer */
-	initial_boot_params = params;
+	initial_boot_params = dt_virt;
+	initial_boot_params_pa = dt_phys;
 	of_fdt_crc32 = crc32_be(~0, initial_boot_params,
 				fdt_totalsize(initial_boot_params));
 	return true;
@@ -1306,11 +1308,11 @@ void __init early_init_dt_scan_nodes(void)
 	early_init_dt_check_for_usable_mem_range();
 }
 
-bool __init early_init_dt_scan(void *params)
+bool __init early_init_dt_scan(void *dt_virt, phys_addr_t dt_phys)
 {
 	bool status;
 
-	status = early_init_dt_verify(params);
+	status = early_init_dt_verify(dt_virt, dt_phys);
 	if (!status)
 		return false;
 
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 68278340cecfe..3b98a57f1f074 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -301,7 +301,7 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 	}
 
 	/* Remove memory reservation for the current device tree. */
-	ret = fdt_find_and_del_mem_rsv(fdt, __pa(initial_boot_params),
+	ret = fdt_find_and_del_mem_rsv(fdt, initial_boot_params_pa,
 				       fdt_totalsize(initial_boot_params));
 	if (ret == -EINVAL) {
 		pr_err("Error removing memory reservation.\n");
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index d69ad5bb1eb1e..b8d6c0c208760 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -31,6 +31,7 @@ extern void *of_fdt_unflatten_tree(const unsigned long *blob,
 extern int __initdata dt_root_addr_cells;
 extern int __initdata dt_root_size_cells;
 extern void *initial_boot_params;
+extern phys_addr_t initial_boot_params_pa;
 
 extern char __dtb_start[];
 extern char __dtb_end[];
@@ -70,8 +71,8 @@ extern u64 dt_mem_next_cell(int s, const __be32 **cellp);
 /* Early flat tree scan hooks */
 extern int early_init_dt_scan_root(void);
 
-extern bool early_init_dt_scan(void *params);
-extern bool early_init_dt_verify(void *params);
+extern bool early_init_dt_scan(void *dt_virt, phys_addr_t dt_phys);
+extern bool early_init_dt_verify(void *dt_virt, phys_addr_t dt_phys);
 extern void early_init_dt_scan_nodes(void);
 
 extern const char *of_flat_dt_get_machine_name(void);
-- 
2.43.0




