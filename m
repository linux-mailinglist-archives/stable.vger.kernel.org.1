Return-Path: <stable+bounces-36313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1718F89B7F4
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 08:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57479B224E2
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 06:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35C32232A;
	Mon,  8 Apr 2024 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gyFxp8zz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EFF200BA
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558988; cv=none; b=My8/QfsYcrVcRzPRVFvNOEQSIPh22Y4KBsHjuP3L7EfZIbKNaaIibYHlY9k1KLM86do4CT0lEYVZRCdvdLXkjjByxclzfXzhp6bQ+CejK8fK3P56D8xLDrI4EdEg9mECnejufD/Yt4gHUWHrKSSIiqLOA4kReQG/QtiZUq/183Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558988; c=relaxed/simple;
	bh=h80+BvojIXnxQ51g8Et6TRaBhD1pQUnxNey0fGugD2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FSw5o8MEZZoVYm0sjW4K9Vffnw+hVsQRSZ9zMuSVklgLWDdA9eYnxGUFxLoMF0ZPc9+0KBx1wvwR7bapBrxZ3bG/2PqLSkkn6bRaqq4YF1LuplGxhAlkuza/cXxkPwpJyXSEUQsfI0TnI/aUS8MwevnPgK+lgozzJo4KPUO/NGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gyFxp8zz; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-41485831b2dso30852755e9.3
        for <stable@vger.kernel.org>; Sun, 07 Apr 2024 23:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712558985; x=1713163785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=peuGZhHYiXFppAjJInuN+Mn43+BpaUtOLCJ6uYuhOrY=;
        b=gyFxp8zzoD7j5TblGHG8hpJxnHo8LYCKinbs9BL0kmcNnhBiEz5WTgAs29B+MqZdRK
         bTadRat0tFKlNLiXzxVKNxHXfYVXXa3UQWHzboWjSiz4VBr3UYwuBEgAjH/KwzAD9FU5
         oDMz8E13mgtfSvVno/HBqAGMQv9rDQEFfxTxuzioO7cto9yN3SlPQEVeQ1/VnLLSw32t
         izvVVob5X5pH1aWe24cUPzUCbb9cjwF/Vj/osi6y63xrmXC2Hjfcb0YVsUGi1LUmY/9e
         GebkClOQczeK18FtsdVec3lm4la2jFCs8hMiqAjVR1iZ/+GN4pKUW+Hee/owl90FuryD
         G50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712558985; x=1713163785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=peuGZhHYiXFppAjJInuN+Mn43+BpaUtOLCJ6uYuhOrY=;
        b=UXWrs9KBD2yklhK/CUz7C8pBP8K2qvLcWzeOHa8CflmCHz0aOSua2CD0O2/2BAAjxx
         me8Eubr05q9yk985EW6zOPm5pEIvIM1cEMD7XcSymTQXL0jmXMJgL0TWtAqwfAyL78/0
         4h6Bg2ty8/4922eNtuQvtYHdEkNTCMZWPn+z6EYzzwCOmh9bPwbWhNZrMTGLlIhJ7JF1
         wlG2U4f5ehoulHq7OkiRBLwsl4ZAqojwn4kTidCLuERlGxXGFGtpS3xWSndTn1wXXNps
         +uKm7KIjXEDBX0N/cKcMAWEGHb5gq2sJKLGwH0wcjrWZAPmOU4bAN54nKchgjJVU9OjD
         1OMQ==
X-Gm-Message-State: AOJu0YxjWYf/oeA9F8nSBzWTAAY7o3BY9lauN0oYTb03Rf7LNd7J8A+M
	x1fTDuMeSQTWffKOwRZ0oND6YW+O2vH9hfZEgjHaZikakoYFFKzKdecorAJbNb09ALpYwnAjr04
	znJZ9zF9QF+oHrcTK4OiKn6mL1PnJUym1UmQoHXyKlGwWPaJ4BQ7vLthnauPIbfx3WkqMo2EFkb
	b/X7AOz2TzMj0tChT1j4PCcA==
X-Google-Smtp-Source: AGHT+IFmcnaCfvcCnVBtG7S3PkMcGRIQ7Ck7ttU3ZhStHlDCaAQadTDYG8O5WW5/03PK61RP6Dq2iZG5
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:46d0:b0:414:8c08:2f94 with SMTP id
 q16-20020a05600c46d000b004148c082f94mr21606wmo.4.1712558984899; Sun, 07 Apr
 2024 23:49:44 -0700 (PDT)
Date: Mon,  8 Apr 2024 08:49:21 +0200
In-Reply-To: <20240408064917.3391405-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408064917.3391405-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7237; i=ardb@kernel.org;
 h=from:subject; bh=u45FcVcCB1bxHbmKzFi6A6FUfzVOiA1Gbajh77u49M0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU14cuHeKoWGyikKGSZXwwwu7nafx86zY3/3hLx17C/Z7
 3HOiNjXUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACai4MnwT3PGv//c6seaWDfm
 cvkYTbvSYtdicv3e32knkvft9nqhcJKRYQknQ8n2ADHGWxyXWNsbuws5Ehn2/arIELM4rfzF9tQ pdgA=
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408064917.3391405-11-ardb+git@google.com>
Subject: [PATCH -for-stable-v6.6+ 3/6] x86/boot: Move mem_encrypt= parsing to
 the decompressor
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit cd0d9d92c8bb46e77de62efd7df13069ddd61e7d upstream ]

The early SME/SEV code parses the command line very early, in order to
decide whether or not memory encryption should be enabled, which needs
to occur even before the initial page tables are created.

This is problematic for a number of reasons:
- this early code runs from the 1:1 mapping provided by the decompressor
  or firmware, which uses a different translation than the one assumed by
  the linker, and so the code needs to be built in a special way;
- parsing external input while the entire kernel image is still mapped
  writable is a bad idea in general, and really does not belong in
  security minded code;
- the current code ignores the built-in command line entirely (although
  this appears to be the case for the entire decompressor)

Given that the decompressor/EFI stub is an intrinsic part of the x86
bootable kernel image, move the command line parsing there and out of
the core kernel. This removes the need to build lib/cmdline.o in a
special way, or to use RIP-relative LEA instructions in inline asm
blocks.

This involves a new xloadflag in the setup header to indicate
that mem_encrypt=on appeared on the kernel command line.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20240227151907.387873-17-ardb+git@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/misc.c         | 15 +++++++++
 arch/x86/include/uapi/asm/bootparam.h   |  1 +
 arch/x86/lib/Makefile                   | 13 --------
 arch/x86/mm/mem_encrypt_identity.c      | 32 ++------------------
 drivers/firmware/efi/libstub/x86-stub.c |  3 ++
 5 files changed, 22 insertions(+), 42 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index f711f2a85862..c6136a1be283 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -357,6 +357,19 @@ unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 	return entry;
 }
 
+/*
+ * Set the memory encryption xloadflag based on the mem_encrypt= command line
+ * parameter, if provided.
+ */
+static void parse_mem_encrypt(struct setup_header *hdr)
+{
+	int on = cmdline_find_option_bool("mem_encrypt=on");
+	int off = cmdline_find_option_bool("mem_encrypt=off");
+
+	if (on > off)
+		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
+}
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -387,6 +400,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	/* Clear flags intended for solely in-kernel use. */
 	boot_params->hdr.loadflags &= ~KASLR_FLAG;
 
+	parse_mem_encrypt(&boot_params->hdr);
+
 	sanitize_boot_params(boot_params);
 
 	if (boot_params->screen_info.orig_video_mode == 7) {
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 01d19fc22346..eeea058cf602 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -38,6 +38,7 @@
 #define XLF_EFI_KEXEC			(1<<4)
 #define XLF_5LEVEL			(1<<5)
 #define XLF_5LEVEL_ENABLED		(1<<6)
+#define XLF_MEM_ENCRYPTION		(1<<7)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index ea3a28e7b613..f0dae4fb6d07 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -14,19 +14,6 @@ ifdef CONFIG_KCSAN
 CFLAGS_REMOVE_delay.o = $(CC_FLAGS_FTRACE)
 endif
 
-# Early boot use of cmdline; don't instrument it
-ifdef CONFIG_AMD_MEM_ENCRYPT
-KCOV_INSTRUMENT_cmdline.o := n
-KASAN_SANITIZE_cmdline.o  := n
-KCSAN_SANITIZE_cmdline.o  := n
-
-ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_cmdline.o = -pg
-endif
-
-CFLAGS_cmdline.o := -fno-stack-protector -fno-jump-tables
-endif
-
 inat_tables_script = $(srctree)/arch/x86/tools/gen-insn-attr-x86.awk
 inat_tables_maps = $(srctree)/arch/x86/lib/x86-opcode-map.txt
 quiet_cmd_inat_tables = GEN     $@
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 0166ab1780cc..d210c7fc8fa2 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -43,7 +43,6 @@
 
 #include <asm/setup.h>
 #include <asm/sections.h>
-#include <asm/cmdline.h>
 #include <asm/coco.h>
 #include <asm/sev.h>
 
@@ -95,9 +94,6 @@ struct sme_populate_pgd_data {
  */
 static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
-static char sme_cmdline_arg[] __initdata = "mem_encrypt";
-static char sme_cmdline_on[]  __initdata = "on";
-
 static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
@@ -504,11 +500,9 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 
 void __init sme_enable(struct boot_params *bp)
 {
-	const char *cmdline_ptr, *cmdline_arg, *cmdline_on;
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
 	unsigned long me_mask;
-	char buffer[16];
 	bool snp;
 	u64 msr;
 
@@ -551,6 +545,9 @@ void __init sme_enable(struct boot_params *bp)
 
 	/* Check if memory encryption is enabled */
 	if (feature_mask == AMD_SME_BIT) {
+		if (!(bp->hdr.xloadflags & XLF_MEM_ENCRYPTION))
+			return;
+
 		/*
 		 * No SME if Hypervisor bit is set. This check is here to
 		 * prevent a guest from trying to enable SME. For running as a
@@ -570,31 +567,8 @@ void __init sme_enable(struct boot_params *bp)
 		msr = __rdmsr(MSR_AMD64_SYSCFG);
 		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
 			return;
-	} else {
-		/* SEV state cannot be controlled by a command line option */
-		goto out;
 	}
 
-	/*
-	 * Fixups have not been applied to phys_base yet and we're running
-	 * identity mapped, so we must obtain the address to the SME command
-	 * line argument data using rip-relative addressing.
-	 */
-	asm ("lea sme_cmdline_arg(%%rip), %0"
-	     : "=r" (cmdline_arg)
-	     : "p" (sme_cmdline_arg));
-	asm ("lea sme_cmdline_on(%%rip), %0"
-	     : "=r" (cmdline_on)
-	     : "p" (sme_cmdline_on));
-
-	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
-				     ((u64)bp->ext_cmd_line_ptr << 32));
-
-	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0 ||
-	    strncmp(buffer, cmdline_on, sizeof(buffer)))
-		return;
-
-out:
 	RIP_REL_REF(sme_me_mask) = me_mask;
 	physical_mask &= ~me_mask;
 	cc_vendor = CC_VENDOR_AMD;
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 8307950fe3ce..6224f5c40532 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -888,6 +888,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		}
 	}
 
+	if (efi_mem_encrypt > 0)
+		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
+
 	status = efi_decompress_kernel(&kernel_entry);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to decompress kernel\n");
-- 
2.44.0.478.gd926399ef9-goog


