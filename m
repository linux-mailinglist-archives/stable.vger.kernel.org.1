Return-Path: <stable+bounces-35457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA38894405
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6682B283869
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19095482DF;
	Mon,  1 Apr 2024 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Suz1G5HX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC3821105;
	Mon,  1 Apr 2024 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991459; cv=none; b=WsOCAiYT26w2rJk4MxMW5Fh3JAHXhHIfzZORYVM+wfaIvLzfbCf2JCkKtPVjIa+pKSzH3pYtiz954NKT2VjqZW3fG9DG7SWe9GV49qYDhjbHdyGnQc7/bN8dc3sxBKaZkhviebolSRS9+I257lnx6hNGY8L+qQXJAj1Mo4b12Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991459; c=relaxed/simple;
	bh=i0GIIT2ctvoTKRIIR47+yvIkEaZRQX/Wt6ioUL2xL8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOH0eOsCRNBr+wjwVFWz75omG8GGM+6ZXP7ApQWLG+6pwuxnt1aXurwIfgbjvwlnNcvT/21sZ5E7B/09ERqll0rI/J+fzUhqJ2HQjwboVFaqfmdW9TGHG7NtFujhdHt7hC6khsK6OXdKAxmjoIpPaReQp5oP8Lfg7reeTOyyZbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Suz1G5HX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE07C433C7;
	Mon,  1 Apr 2024 17:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711991459;
	bh=i0GIIT2ctvoTKRIIR47+yvIkEaZRQX/Wt6ioUL2xL8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Suz1G5HXXR4ZeWcQn7Kk/GYip2jnA10FNiu8ejuSqY+0Q1qup7NO/qNNw++KCJgZR
	 3ZvUGfmO6KNiWWvPmAJDc+eGxoAnN7Y7sXz1JGz+p+evjSjBx1J733Xr2F5Qzvpf27
	 dz+3uZmFokRcnCKEbjDy5CapSksAJNhdaES4cXQo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kevin Loughlin <kevinloughlin@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	stable@kernel.org
Subject: [PATCH 6.1 270/272] x86/sev: Skip ROM range scans and validation for SEV-SNP guests
Date: Mon,  1 Apr 2024 17:47:40 +0200
Message-ID: <20240401152539.502755871@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kevin Loughlin <kevinloughlin@google.com>

commit 0f4a1e80989aca185d955fcd791d7750082044a2 upstream.

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
Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/sev.h      |    4 ++--
 arch/x86/include/asm/x86_init.h |    3 ++-
 arch/x86/kernel/eisa.c          |    3 ++-
 arch/x86/kernel/probe_roms.c    |   10 ----------
 arch/x86/kernel/setup.c         |    3 +--
 arch/x86/kernel/sev.c           |   27 ++++++++++++---------------
 arch/x86/kernel/x86_init.c      |    2 ++
 arch/x86/mm/mem_encrypt_amd.c   |   18 ++++++++++++++++++
 8 files changed, 39 insertions(+), 31 deletions(-)

--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -196,12 +196,12 @@ void __init early_snp_set_memory_private
 					 unsigned long npages);
 void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 					unsigned long npages);
-void __init snp_prep_memory(unsigned long paddr, unsigned int sz, enum psc_op op);
 void snp_set_memory_shared(unsigned long vaddr, unsigned long npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
+void snp_dmi_setup(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
@@ -219,12 +219,12 @@ static inline void __init
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
@@ -1032,7 +1031,7 @@ void __init setup_arch(char **cmdline_p)
 	if (efi_enabled(EFI_BOOT))
 		efi_init();
 
-	dmi_setup();
+	x86_init.resources.dmi_setup();
 
 	/*
 	 * VMware detection requires dmi to be available, so this
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/psp-sev.h>
+#include <linux/dmi.h>
 #include <uapi/linux/sev-guest.h>
 
 #include <asm/cpu_entry_area.h>
@@ -768,21 +769,6 @@ void __init early_snp_set_memory_shared(
 	early_set_pages_state(paddr, npages, SNP_PAGE_STATE_SHARED);
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
 static int vmgexit_psc(struct snp_psc_desc *desc)
 {
 	int cur_entry, end_entry, ret = 0;
@@ -2152,6 +2138,17 @@ void __init __noreturn snp_abort(void)
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
@@ -66,6 +67,7 @@ struct x86_init_ops x86_init __initdata
 		.probe_roms		= probe_roms,
 		.reserve_resources	= reserve_standard_io_resources,
 		.memory_setup		= e820__memory_setup_default,
+		.dmi_setup		= dmi_setup,
 	},
 
 	.mpparse = {
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -513,6 +513,24 @@ void __init sme_early_init(void)
 	 */
 	if (sev_status & MSR_AMD64_SEV_ENABLED)
 		ia32_disable();
+
+	/*
+	 * Override init functions that scan the ROM region in SEV-SNP guests,
+	 * as this memory is not pre-validated and would thus cause a crash.
+	 */
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
+		x86_init.mpparse.find_smp_config = x86_init_noop;
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



