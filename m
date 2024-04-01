Return-Path: <stable+bounces-33888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D3D89398A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 11:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA201C21654
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8545D1118A;
	Mon,  1 Apr 2024 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vt0F1t1s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452E0D52B
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964412; cv=none; b=YRB5adpMh/ANOq2aeQQm2uj/MBZfWFH1IDZ2nORcy+qnfHyMjJK65ZOlD1CZwKNkkc7uv0o+/K/+MCovbkGzjzJnBQKTAo2iLt0VYVZEnn3ZIY43dkHZB/tuyyj4HFv3+R3URrNLhVCZWy5ARLGVwgo2trNq1tTKCuda0d5RSkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964412; c=relaxed/simple;
	bh=OGXP1ONZXhLUF5PqOoER2y6sXKlhgvZWKetoQ8g3l1M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PDQ+NtMSP5ZNt9px4t6e0FkmTyRYlOLPunmOwa+KgWFWJWN2caHw0xhiE53me9y08d7c4izBcjIm6a5vztwDlXw4ycePqeBDFyxceEhgvUZaJ4rF3dxlfRBYoiiwlhH/LzPDOU9uIh3xtaqDsgo353AqW/NnRIz0jXvoyj8l4GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vt0F1t1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E78C433F1;
	Mon,  1 Apr 2024 09:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711964411;
	bh=OGXP1ONZXhLUF5PqOoER2y6sXKlhgvZWKetoQ8g3l1M=;
	h=Subject:To:Cc:From:Date:From;
	b=Vt0F1t1sq6awDq7fQu9TPzCMwcq2uzggvD/QBe2Dxg68M7JYQKcxZDvfQ1DJFjp1F
	 Qa3ynxmRI4haLLhl3GsINyelTK24/0z/y00qBqlvLwXJFKGy3vd8gDD4Q7yaTw5uFP
	 c5IJXDp9S/mkUVDV8b1P2/9omiu99v0gMpVubUnE=
Subject: FAILED: patch "[PATCH] x86/sev: Skip ROM range scans and validation for SEV-SNP" failed to apply to 6.7-stable tree
To: kevinloughlin@google.com,bp@alien8.de,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Apr 2024 11:40:05 +0200
Message-ID: <2024040105-swarm-prenatal-5d72@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 0f4a1e80989aca185d955fcd791d7750082044a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040105-swarm-prenatal-5d72@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

0f4a1e80989a ("x86/sev: Skip ROM range scans and validation for SEV-SNP guests")
428080c9b19b ("x86/sev: Move early startup code into .head.text section")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0f4a1e80989aca185d955fcd791d7750082044a2 Mon Sep 17 00:00:00 2001
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Wed, 13 Mar 2024 12:15:46 +0000
Subject: [PATCH] x86/sev: Skip ROM range scans and validation for SEV-SNP
 guests

SEV-SNP requires encrypted memory to be validated before access.
Because the ROM memory range is not part of the e820 table, it is not
pre-validated by the BIOS. Therefore, if a SEV-SNP guest kernel wishes
to access this range, the guest must first validate the range.

The current SEV-SNP code does indeed scan the ROM range during early
boot and thus attempts to validate the ROM range in probe_roms().
However, this behavior is neither sufficient nor necessary for the
following reasons:

* With regards to sufficiency, if EFI_CONFIG_TABLES are not enabled and
  CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK is set, the kernel will
  attempt to access the memory at SMBIOS_ENTRY_POINT_SCAN_START (which
  falls in the ROM range) prior to validation.

  For example, Project Oak Stage 0 provides a minimal guest firmware
  that currently meets these configuration conditions, meaning guests
  booting atop Oak Stage 0 firmware encounter a problematic call chain
  during dmi_setup() -> dmi_scan_machine() that results in a crash
  during boot if SEV-SNP is enabled.

* With regards to necessity, SEV-SNP guests generally read garbage
  (which changes across boots) from the ROM range, meaning these scans
  are unnecessary. The guest reads garbage because the legacy ROM range
  is unencrypted data but is accessed via an encrypted PMD during early
  boot (where the PMD is marked as encrypted due to potentially mapping
  actually-encrypted data in other PMD-contained ranges).

In one exceptional case, EISA probing treats the ROM range as
unencrypted data, which is inconsistent with other probing.

Continuing to allow SEV-SNP guests to use garbage and to inconsistently
classify ROM range encryption status can trigger undesirable behavior.
For instance, if garbage bytes appear to be a valid signature, memory
may be unnecessarily reserved for the ROM range. Future code or other
use cases may result in more problematic (arbitrary) behavior that
should be avoided.

While one solution would be to overhaul the early PMD mapping to always
treat the ROM region of the PMD as unencrypted, SEV-SNP guests do not
currently rely on data from the ROM region during early boot (and even
if they did, they would be mostly relying on garbage data anyways).

As a simpler solution, skip the ROM range scans (and the otherwise-
necessary range validation) during SEV-SNP guest early boot. The
potential SEV-SNP guest crash due to lack of ROM range validation is
thus avoided by simply not accessing the ROM range.

In most cases, skip the scans by overriding problematic x86_init
functions during sme_early_init() to SNP-safe variants, which can be
likened to x86_init overrides done for other platforms (ex: Xen); such
overrides also avoid the spread of cc_platform_has() checks throughout
the tree.

In the exceptional EISA case, still use cc_platform_has() for the
simplest change, given (1) checks for guest type (ex: Xen domain status)
are already performed here, and (2) these checks occur in a subsys
initcall instead of an x86_init function.

  [ bp: Massage commit message, remove "we"s. ]

Fixes: 9704c07bf9f7 ("x86/kernel: Validate ROM memory before accessing when SEV-SNP is active")
Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20240313121546.2964854-1-kevinloughlin@google.com

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 9477b4053bce..07e125f32528 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -218,12 +218,12 @@ void early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 				  unsigned long npages);
 void early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 				 unsigned long npages);
-void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
 void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __noreturn snp_abort(void);
+void snp_dmi_setup(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
@@ -244,12 +244,12 @@ static inline void __init
 early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
 static inline void __init
 early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr, unsigned long npages) { }
-static inline void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op) { }
 static inline void snp_set_memory_shared(unsigned long vaddr, unsigned long npages) { }
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned long npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
+static inline void snp_dmi_setup(void) { }
 static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
 {
 	return -ENOTTY;
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index b89b40f250e6..6149eabe200f 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -30,12 +30,13 @@ struct x86_init_mpparse {
  * @reserve_resources:		reserve the standard resources for the
  *				platform
  * @memory_setup:		platform specific memory setup
- *
+ * @dmi_setup:			platform specific DMI setup
  */
 struct x86_init_resources {
 	void (*probe_roms)(void);
 	void (*reserve_resources)(void);
 	char *(*memory_setup)(void);
+	void (*dmi_setup)(void);
 };
 
 /**
diff --git a/arch/x86/kernel/eisa.c b/arch/x86/kernel/eisa.c
index e963344b0449..53935b4d62e3 100644
--- a/arch/x86/kernel/eisa.c
+++ b/arch/x86/kernel/eisa.c
@@ -2,6 +2,7 @@
 /*
  * EISA specific code
  */
+#include <linux/cc_platform.h>
 #include <linux/ioport.h>
 #include <linux/eisa.h>
 #include <linux/io.h>
@@ -12,7 +13,7 @@ static __init int eisa_bus_probe(void)
 {
 	void __iomem *p;
 
-	if (xen_pv_domain() && !xen_initial_domain())
+	if ((xen_pv_domain() && !xen_initial_domain()) || cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return 0;
 
 	p = ioremap(0x0FFFD9, 4);
diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
index 319fef37d9dc..cc2c34ba7228 100644
--- a/arch/x86/kernel/probe_roms.c
+++ b/arch/x86/kernel/probe_roms.c
@@ -203,16 +203,6 @@ void __init probe_roms(void)
 	unsigned char c;
 	int i;
 
-	/*
-	 * The ROM memory range is not part of the e820 table and is therefore not
-	 * pre-validated by BIOS. The kernel page table maps the ROM region as encrypted
-	 * memory, and SNP requires encrypted memory to be validated before access.
-	 * Do that here.
-	 */
-	snp_prep_memory(video_rom_resource.start,
-			((system_rom_resource.end + 1) - video_rom_resource.start),
-			SNP_PAGE_STATE_PRIVATE);
-
 	/* video rom */
 	upper = adapter_rom_resources[0].start;
 	for (start = video_rom_resource.start; start < upper; start += 2048) {
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index ef206500ed6f..0109e6c510e0 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -9,7 +9,6 @@
 #include <linux/console.h>
 #include <linux/crash_dump.h>
 #include <linux/dma-map-ops.h>
-#include <linux/dmi.h>
 #include <linux/efi.h>
 #include <linux/ima.h>
 #include <linux/init_ohci1394_dma.h>
@@ -902,7 +901,7 @@ void __init setup_arch(char **cmdline_p)
 		efi_init();
 
 	reserve_ibft_region();
-	dmi_setup();
+	x86_init.resources.dmi_setup();
 
 	/*
 	 * VMware detection requires dmi to be available, so this
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b59b09c2f284..7e1e63cc48e6 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/psp-sev.h>
+#include <linux/dmi.h>
 #include <uapi/linux/sev-guest.h>
 
 #include <asm/init.h>
@@ -795,21 +796,6 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
 }
 
-void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op)
-{
-	unsigned long vaddr, npages;
-
-	vaddr = (unsigned long)__va(paddr);
-	npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
-
-	if (op == SNP_PAGE_STATE_PRIVATE)
-		early_snp_set_memory_private(vaddr, paddr, npages);
-	else if (op == SNP_PAGE_STATE_SHARED)
-		early_snp_set_memory_shared(vaddr, paddr, npages);
-	else
-		WARN(1, "invalid memory op %d\n", op);
-}
-
 static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
 				       unsigned long vaddr_end, int op)
 {
@@ -2136,6 +2122,17 @@ void __head __noreturn snp_abort(void)
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
 
+/*
+ * SEV-SNP guests should only execute dmi_setup() if EFI_CONFIG_TABLES are
+ * enabled, as the alternative (fallback) logic for DMI probing in the legacy
+ * ROM region can cause a crash since this region is not pre-validated.
+ */
+void __init snp_dmi_setup(void)
+{
+	if (efi_enabled(EFI_CONFIG_TABLES))
+		dmi_setup();
+}
+
 static void dump_cpuid_table(void)
 {
 	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index a42830dc151b..d5dc5a92635a 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -3,6 +3,7 @@
  *
  *  For licencing details see kernel-base/COPYING
  */
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/export.h>
@@ -66,6 +67,7 @@ struct x86_init_ops x86_init __initdata = {
 		.probe_roms		= probe_roms,
 		.reserve_resources	= reserve_standard_io_resources,
 		.memory_setup		= e820__memory_setup_default,
+		.dmi_setup		= dmi_setup,
 	},
 
 	.mpparse = {
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 70b91de2e053..422602f6039b 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -492,6 +492,24 @@ void __init sme_early_init(void)
 	 */
 	if (sev_status & MSR_AMD64_SEV_ENABLED)
 		ia32_disable();
+
+	/*
+	 * Override init functions that scan the ROM region in SEV-SNP guests,
+	 * as this memory is not pre-validated and would thus cause a crash.
+	 */
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
+		x86_init.mpparse.find_mptable = x86_init_noop;
+		x86_init.pci.init_irq = x86_init_noop;
+		x86_init.resources.probe_roms = x86_init_noop;
+
+		/*
+		 * DMI setup behavior for SEV-SNP guests depends on
+		 * efi_enabled(EFI_CONFIG_TABLES), which hasn't been
+		 * parsed yet. snp_dmi_setup() will run after that
+		 * parsing has happened.
+		 */
+		x86_init.resources.dmi_setup = snp_dmi_setup;
+	}
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)


