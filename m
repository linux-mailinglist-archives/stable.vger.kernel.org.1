Return-Path: <stable+bounces-33944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EE5893C13
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1278B20D1D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 14:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2F143ADB;
	Mon,  1 Apr 2024 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVTBN3vV"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C44436C
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980781; cv=none; b=Q2diKp6kfUMaoLLUmJtVb31NQa6oehLL3HZElhmG/t4UnxADPXAKClZIjCa+h4Nw5Cso+cdoR2gBosAneMB94+yJDr21wm7Mr3hQYaFXjMHVruuQ0Q+bPI8RBfeaSd7Ugnu6GS9eHCR6Zrm+jo7yheJYCVJgxqNSHdUBcqRSed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980781; c=relaxed/simple;
	bh=aow0lRlrtfqZ1a6qRHrvnuZcLEjj9qRVymCn85woZUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cTN9DmD+GIMaLVlgqFQAHUeTHgOq1B2AT0yXrr59XThYeDzRYqrfaucDmlS8brIXTVOKMjhHBa+srLn4OV+hcjKBqfFYX6cefro1tomRkVLdD1dZeNDPv3G67fuZsqjqYhMdh8ebq3Em14c2P+4Zxc2dNXYDFpqZhIuPZccP9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVTBN3vV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6147c5b3468so19636257b3.1
        for <stable@vger.kernel.org>; Mon, 01 Apr 2024 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711980778; x=1712585578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WtvPWRr7AZWfte8c34tXrTsLGQ8utJUUDQpJbzF+1E=;
        b=eVTBN3vVFza/K8sgzWcikF7et5VsUTRQfRqTEtGBBRxr7jtLnwRTRYToguM6muyd2F
         u/cJjsWaIZLVR5H3/7gE3Pd9J7RSiJn5FklJ7hrdhFci0TxqQttAIYt+1iE2wdufssSG
         aGdKLD4lzG7YWaCJivBIdBQf5HaLj7104IlUkHn7k33fCBtleuhX6bvvpGKGF3bcjOE+
         DYfI9nf6NSgMh6l6j9lXwhrbZeHntFoRIN9HFJt5nkPjfjD1A7YTB2aGdjo3AYC9YWx4
         1bnaCKzrRCihuD/l0zeuPr9ndBD1Pa/776jm9hpAgXQkNjMiAkSidaTVybEqiWj1u1XA
         HWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711980778; x=1712585578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WtvPWRr7AZWfte8c34tXrTsLGQ8utJUUDQpJbzF+1E=;
        b=c2BntIG/Av1bSGTZh6fKJo7EvW4tcOG+dcF1pfVv9nW9/TfzuACmePWdcS98X+j7Up
         hMnONX9OCwK1GfKWmGx7TCAw/CaZ6NuWVGBYCCzN7U1EiKo4lHSWGn0pAoZC4lTbna/A
         JSHZGusg8krseU9zaFxzhLpeDF9epswiNbwY9zBQnvAW4PSUP/uq1vY9nMqIwLnmacwX
         SxvmpphNLWiWbEOAYCwQUbieR30T7CwH1Ey4oEiiRlYbfIi/N/ZLJ3z5iRUGcgvFQiib
         9BEnJW6cn5RLIRwUdtcDYq453WIL3sqVvOvVFC5x71pYJuUKHCM9xkgFH83UW9YMYK53
         o5/w==
X-Gm-Message-State: AOJu0YwFF7POmw2MtyRO66SED8QuRwbCYgqdsQS4gJNxWCvGWxNL46bX
	sy5SC9zxKONsdBFLbTd7c2WtdTxCMYSZKGZrLxkD577WZpmi7rpXp0Ekgg571P0rxNZDVHmqY3f
	25Nsuqj4AQUfyZnIQUuF23GUYHEjB9DxKBDuhjsV3cTrQwbSI5F92Ub5NrFSnzdhvhi0DCZMFJp
	l/G7baiRtvynne08hmv2TTG4rC1T6jjdASMWhdd5CG9VdEQHXJ/E5kUJbSX/Lo/nlgkGX/TQ==
X-Google-Smtp-Source: AGHT+IHpKeVuzmcR+5+7uRFHMAEpQGfE5J0oDKoB9CgT0obU0vlqVNEa9efd/8oZbejf8PQ0WikD4PxzECjiB2tR7iGB
X-Received: from loughlin00.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1b6f])
 (user=kevinloughlin job=sendgmr) by 2002:a81:4f4d:0:b0:615:f67:53e2 with SMTP
 id d74-20020a814f4d000000b006150f6753e2mr46218ywb.2.1711980778436; Mon, 01
 Apr 2024 07:12:58 -0700 (PDT)
Date: Mon,  1 Apr 2024 14:12:02 +0000
In-Reply-To: <2024040102-umbrella-nag-c677@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024040102-umbrella-nag-c677@gregkh>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401141202.1704141-1-kevinloughlin@google.com>
Subject: [PATCH 6.8.y] x86/sev: Skip ROM range scans and validation for
 SEV-SNP guests
From: Kevin Loughlin <kevinloughlin@google.com>
To: stable@vger.kernel.org
Cc: Kevin Loughlin <kevinloughlin@google.com>, Borislav Petkov <bp@alien8.de>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

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
(cherry picked from commit 0f4a1e80989aca185d955fcd791d7750082044a2)
Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 arch/x86/include/asm/sev.h      |  4 ++--
 arch/x86/include/asm/x86_init.h |  3 ++-
 arch/x86/kernel/eisa.c          |  3 ++-
 arch/x86/kernel/probe_roms.c    | 10 ----------
 arch/x86/kernel/setup.c         |  3 +--
 arch/x86/kernel/sev.c           | 27 ++++++++++++---------------
 arch/x86/kernel/x86_init.c      |  2 ++
 arch/x86/mm/mem_encrypt_amd.c   | 18 ++++++++++++++++++
 8 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 5b4a1ce3d368..36f905797075 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -203,12 +203,12 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
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
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
@@ -227,12 +227,12 @@ static inline void __init
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
index c878616a18b8..550dcbbbb175 100644
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
index 84201071dfac..97dd70285741 100644
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
index c67285824e82..c984b7928ab8 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/psp-sev.h>
+#include <linux/dmi.h>
 #include <uapi/linux/sev-guest.h>
 
 #include <asm/cpu_entry_area.h>
@@ -774,21 +775,6 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
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
@@ -2112,6 +2098,17 @@ void __init __noreturn snp_abort(void)
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
index a37ebd3b4773..3f0718b4a7d2 100644
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
index 70b91de2e053..94cd06d4b0af 100644
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
-- 
2.44.0.478.gd926399ef9-goog


