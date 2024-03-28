Return-Path: <stable+bounces-26559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C0D870F21
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C0B1C240E9
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129C37992E;
	Mon,  4 Mar 2024 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ouR7TufZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDABC7868F;
	Mon,  4 Mar 2024 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589070; cv=none; b=GKm02iltvt6Dph3zG/N13bLX+ZIdVxVf51/u2BQ6XNPUe+wvha9sBXOTizmTXLBGNt7LFlW9augW21Ycd4VBn/6ekIcTPmUrg/jH+luPjFVdDR+n6zpRnThuS75KE8Rv/fNQZpXYd8SU9nh02BFCiMjtWIKvsPdR9CdtgwJNzGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589070; c=relaxed/simple;
	bh=Jp+34Y4bMlSzDxBq33V5KL73nLDL5sujOjsGkMeDoNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVQFI8ybSNTix1zfDRfpR/0nJ5tminGonauJGKeek1/XfPMc1ZlhHJGVPLku7xShRk9Wxc5qzPz2Bz9++RvQZMcb+TsOWKSYAXr6yuzJwJaB8LLal0hhj9NibJ9AWrdM4w/7NLIdmVWMzfLYX4SkFKZvYN6NaMTjAKZA6t/3W8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ouR7TufZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03288C433C7;
	Mon,  4 Mar 2024 21:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709589070;
	bh=Jp+34Y4bMlSzDxBq33V5KL73nLDL5sujOjsGkMeDoNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ouR7TufZOAt1FWDclEXt04+sYJE1/nxg+iLKot0fMYhsa6gZT3bXrWtyTWTIfO3XA
	 fDltExki7hnmgDOrV6oWT74yA4W1rJ1l3c1to/Vbm5pddiQwtg7b0t37NQHcUSi4jo
	 PM8w87O4pTrwpAzInCv/G63NGElUnKH5aI79/E/4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.1 190/215] x86/efistub: Perform SNP feature test while running in the firmware
Date: Mon,  4 Mar 2024 21:24:13 +0000
Message-ID: <20240304211602.991618627@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
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

From: Ard Biesheuvel <ardb+git@google.com>

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 31c77a50992e8dd136feed7b67073bb5f1f978cc upstream ]

Before refactoring the EFI stub boot flow to avoid the legacy bare metal
decompressor, duplicate the SNP feature check in the EFI stub before
handing over to the kernel proper.

The SNP feature check can be performed while running under the EFI boot
services, which means it can force the boot to fail gracefully and
return an error to the bootloader if the loaded kernel does not
implement support for all the features that the hypervisor enabled.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-23-ardb@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/sev.c          |  112 ++++++++++++++++++--------------
 arch/x86/include/asm/sev.h              |    5 +
 drivers/firmware/efi/libstub/x86-stub.c |   17 ++++
 3 files changed, 88 insertions(+), 46 deletions(-)

--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -327,20 +327,25 @@ static void enforce_vmpl0(void)
  */
 #define SNP_FEATURES_PRESENT (0)
 
+u64 snp_get_unsupported_features(u64 status)
+{
+	if (!(status & MSR_AMD64_SEV_SNP_ENABLED))
+		return 0;
+
+	return status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
+}
+
 void snp_check_features(void)
 {
 	u64 unsupported;
 
-	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
-		return;
-
 	/*
 	 * Terminate the boot if hypervisor has enabled any feature lacking
 	 * guest side implementation. Pass on the unsupported features mask through
 	 * EXIT_INFO_2 of the GHCB protocol so that those features can be reported
 	 * as part of the guest boot failure.
 	 */
-	unsupported = sev_status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
+	unsupported = snp_get_unsupported_features(sev_status);
 	if (unsupported) {
 		if (ghcb_version < 2 || (!boot_ghcb && !early_setup_ghcb()))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
@@ -350,35 +355,22 @@ void snp_check_features(void)
 	}
 }
 
-void sev_enable(struct boot_params *bp)
+/*
+ * sev_check_cpu_support - Check for SEV support in the CPU capabilities
+ *
+ * Returns < 0 if SEV is not supported, otherwise the position of the
+ * encryption bit in the page table descriptors.
+ */
+static int sev_check_cpu_support(void)
 {
 	unsigned int eax, ebx, ecx, edx;
-	struct msr m;
-	bool snp;
-
-	/*
-	 * bp->cc_blob_address should only be set by boot/compressed kernel.
-	 * Initialize it to 0 to ensure that uninitialized values from
-	 * buggy bootloaders aren't propagated.
-	 */
-	if (bp)
-		bp->cc_blob_address = 0;
-
-	/*
-	 * Do an initial SEV capability check before snp_init() which
-	 * loads the CPUID page and the same checks afterwards are done
-	 * without the hypervisor and are trustworthy.
-	 *
-	 * If the HV fakes SEV support, the guest will crash'n'burn
-	 * which is good enough.
-	 */
 
 	/* Check for the SME/SEV support leaf */
 	eax = 0x80000000;
 	ecx = 0;
 	native_cpuid(&eax, &ebx, &ecx, &edx);
 	if (eax < 0x8000001f)
-		return;
+		return -ENODEV;
 
 	/*
 	 * Check for the SME/SEV feature:
@@ -393,6 +385,35 @@ void sev_enable(struct boot_params *bp)
 	native_cpuid(&eax, &ebx, &ecx, &edx);
 	/* Check whether SEV is supported */
 	if (!(eax & BIT(1)))
+		return -ENODEV;
+
+	return ebx & 0x3f;
+}
+
+void sev_enable(struct boot_params *bp)
+{
+	struct msr m;
+	int bitpos;
+	bool snp;
+
+	/*
+	 * bp->cc_blob_address should only be set by boot/compressed kernel.
+	 * Initialize it to 0 to ensure that uninitialized values from
+	 * buggy bootloaders aren't propagated.
+	 */
+	if (bp)
+		bp->cc_blob_address = 0;
+
+	/*
+	 * Do an initial SEV capability check before snp_init() which
+	 * loads the CPUID page and the same checks afterwards are done
+	 * without the hypervisor and are trustworthy.
+	 *
+	 * If the HV fakes SEV support, the guest will crash'n'burn
+	 * which is good enough.
+	 */
+
+	if (sev_check_cpu_support() < 0)
 		return;
 
 	/*
@@ -403,26 +424,8 @@ void sev_enable(struct boot_params *bp)
 
 	/* Now repeat the checks with the SNP CPUID table. */
 
-	/* Recheck the SME/SEV support leaf */
-	eax = 0x80000000;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	if (eax < 0x8000001f)
-		return;
-
-	/*
-	 * Recheck for the SME/SEV feature:
-	 *   CPUID Fn8000_001F[EAX]
-	 *   - Bit 0 - Secure Memory Encryption support
-	 *   - Bit 1 - Secure Encrypted Virtualization support
-	 *   CPUID Fn8000_001F[EBX]
-	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
-	 */
-	eax = 0x8000001f;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	/* Check whether SEV is supported */
-	if (!(eax & BIT(1))) {
+	bitpos = sev_check_cpu_support();
+	if (bitpos < 0) {
 		if (snp)
 			error("SEV-SNP support indicated by CC blob, but not CPUID.");
 		return;
@@ -454,7 +457,24 @@ void sev_enable(struct boot_params *bp)
 	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
 
-	sme_me_mask = BIT_ULL(ebx & 0x3f);
+	sme_me_mask = BIT_ULL(bitpos);
+}
+
+/*
+ * sev_get_status - Retrieve the SEV status mask
+ *
+ * Returns 0 if the CPU is not SEV capable, otherwise the value of the
+ * AMD64_SEV MSR.
+ */
+u64 sev_get_status(void)
+{
+	struct msr m;
+
+	if (sev_check_cpu_support() < 0)
+		return 0;
+
+	boot_rdmsr(MSR_AMD64_SEV, &m);
+	return m.q;
 }
 
 /* Search for Confidential Computing blob in the EFI config table. */
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -202,6 +202,8 @@ void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
+u64 snp_get_unsupported_features(u64 status);
+u64 sev_get_status(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -225,6 +227,9 @@ static inline int snp_issue_guest_reques
 {
 	return -ENOTTY;
 }
+
+static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
+static inline u64 sev_get_status(void) { return 0; }
 #endif
 
 #endif
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -15,6 +15,7 @@
 #include <asm/setup.h>
 #include <asm/desc.h>
 #include <asm/boot.h>
+#include <asm/sev.h>
 
 #include "efistub.h"
 #include "x86-stub.h"
@@ -747,6 +748,19 @@ static efi_status_t exit_boot(struct boo
 	return EFI_SUCCESS;
 }
 
+static bool have_unsupported_snp_features(void)
+{
+	u64 unsupported;
+
+	unsupported = snp_get_unsupported_features(sev_get_status());
+	if (unsupported) {
+		efi_err("Unsupported SEV-SNP features detected: 0x%llx\n",
+			unsupported);
+		return true;
+	}
+	return false;
+}
+
 static void __noreturn enter_kernel(unsigned long kernel_addr,
 				    struct boot_params *boot_params)
 {
@@ -777,6 +791,9 @@ void __noreturn efi_stub_entry(efi_handl
 	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
+	if (have_unsupported_snp_features())
+		efi_exit(handle, EFI_UNSUPPORTED);
+
 	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
 		efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
 		if (efi_dxe_table &&



