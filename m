Return-Path: <stable+bounces-25906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1BB870044
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 12:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252911F24530
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 11:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568E138DE6;
	Mon,  4 Mar 2024 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEYbMluU"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E7938DF5
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551252; cv=none; b=kdUUqLVd7T0DcLCOohnKATELwTY7G1RllYQr735lAw93Jkva2xfaJbpdzmQ5O+XSL79ULDQ5GXkR0DhLBEmSKK0Rctk65w/yT9PlYFNkCYhNgAx2ZtDhhjoTo5Vs/FNP/Cdjtedhwnky0N8M0djdMc/AZGjE86sISNWh3m5hJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551252; c=relaxed/simple;
	bh=1hnt7HmBmSM6MEyPU6x43sYmUBDHIfgNeOo2zLyk2xg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uts/RzNSXhsjEXsVrDKp1ohU2QF6ImKZtH9bjsqOSGdgKaZxflT/pA+cjIsxkF8pps2l3BloE5ZPCTlKYskl9d37xNlexuQMWATP2KcShzjEUv6A4vHcFHuJ1da/Zw46SaPsVb2xopC5MfLDOjqF/CTaPuV43EXP3mvVEUbL5Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iEYbMluU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ac8c5781so74745727b3.3
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 03:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551249; x=1710156049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt9KXbPdYtpSNAoxQGZeBkZRIgyEiTvsrae5R+y6R40=;
        b=iEYbMluUxUoNKOfHxyUB7wcKYGeyAcAF3rrRXNK6D0Jq+/iTGsHfKIcy96Mnbw9Kq7
         F6Oe9r4FVGJEtvDwoSTyoCjyEPNUK7UNviyMmRMNyiDLgp+1qmUtQCpv8ijzgOlMwrzQ
         lDYDW11Of5m1EnAJqi4PS479n0/XvrcN1f9Z/4+8hX6QEysChOaO5KE12beoNGj82mpo
         hY7SkLPBGssTRh3ma3fZkvbCiPFcnor5BdYIsrL2ulR/3Xd+dHhpHC08fUYUeVHMiixY
         eoNvZWsD5bx0cIyA8Lw20/iDV8i8TWp7/0bTxYaJpQZDPGpYLuqOFf8aMgrKlgYdRZNc
         5NVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551249; x=1710156049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt9KXbPdYtpSNAoxQGZeBkZRIgyEiTvsrae5R+y6R40=;
        b=ZEjRg7J1Q86kREsNbxD/gbdoCJSqyJ5mT5C9uWwwJUz5p5pMebv6fbja7VDo51ynwx
         mHWbWoLO3pG3iD95uOLVjHnRVGv/h0/nDYX59KTvS24RfIAccqTadQwRqPhPz7Hyje+U
         iHHY4zxZEXMivKodzCWHIenBRng6fjYGbysR7PHIvXTyyBAxd6uJBmwEonDZXit0d6d5
         VreWqBK8xmbdGy8kghIJmYv+9TQ3hBVldFnmbrU8sLaSEvmxciIgOjc24OFPcWU46cQ/
         Luw0lrA8s7/2Ku9Bv7xlJ80ekR9+wEtdlwtG30PlGQf8f6RGcXfeeiol1oW+poTwVv9Q
         L8Hw==
X-Gm-Message-State: AOJu0Yzi08vQ884TOipmEobYOZY0TENZMtNoTLYqh9ip6XL9y9zcrTPW
	WywX9mlROjg9HHAOfUanZIL6VBRNY0Kol+Zfi2s+zYfkgAYtBDZRjvUXaGJEKHCfx5MvuYJIy92
	jgDkwLtu9oVPkyYp7E6UcX6+fw7sEkbFbhCAabjQFHXe/kW09hg6l7Bzcxz7pPHjv+lxww9s602
	cl7vxAn1DUIIysrZn5f8Ik7A==
X-Google-Smtp-Source: AGHT+IGvUyYjSTPamb+WoPFj8AvLmkNJBIOFe2Cq6mO+qGK5XbGO3645/V13Yd+ZsgkAX+mTHxnOWTD7
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1004:b0:dc2:3441:897f with SMTP id
 w4-20020a056902100400b00dc23441897fmr2257433ybt.6.1709551248832; Mon, 04 Mar
 2024 03:20:48 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:51 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=19492; i=ardb@kernel.org;
 h=from:subject; bh=SxF88NmdyFvphtD4aIT5NZNOTXhvVzBIS7v+e9ZS6/I=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpuogPSYan5LTMz6/xWj4hK6NibY3FsvRNa8s7DDxtY
 iWy/cw7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERCZRj+BzWX3s62q4n4P/O9
 fOv3rlfvpOetnrStRiBG7J3ftd6FxowMfRmcE64yG4dqJ0V5Tb4n8sxmldrVMytFKlO9Tl06crO VGQA=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-33-ardb+git@google.com>
Subject: [PATCH stable-v6.1 13/18] x86/efistub: Avoid legacy decompressor when
 doing EFI boot
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit a1b87d54f4e45ff5e0d081fb1d9db3bf1a8fb39a upstream ]

The bare metal decompressor code was never really intended to run in a
hosted environment such as the EFI boot services, and does a few things
that are becoming problematic in the context of EFI boot now that the
logo requirements are getting tighter: EFI executables will no longer be
allowed to consist of a single executable section that is mapped with
read, write and execute permissions if they are intended for use in a
context where Secure Boot is enabled (and where Microsoft's set of
certificates is used, i.e., every x86 PC built to run Windows).

To avoid stepping on reserved memory before having inspected the E820
tables, and to ensure the correct placement when running a kernel build
that is non-relocatable, the bare metal decompressor moves its own
executable image to the end of the allocation that was reserved for it,
in order to perform the decompression in place. This means the region in
question requires both write and execute permissions, which either need
to be given upfront (which EFI will no longer permit), or need to be
applied on demand using the existing page fault handling framework.

However, the physical placement of the kernel is usually randomized
anyway, and even if it isn't, a dedicated decompression output buffer
can be allocated anywhere in memory using EFI APIs when still running in
the boot services, given that EFI support already implies a relocatable
kernel. This means that decompression in place is never necessary, nor
is moving the compressed image from one end to the other.

Since EFI already maps all of memory 1:1, it is also unnecessary to
create new page tables or handle page faults when decompressing the
kernel. That means there is also no need to replace the special
exception handlers for SEV. Generally, there is little need to do
any of the things that the decompressor does beyond

- initialize SEV encryption, if needed,
- perform the 4/5 level paging switch, if needed,
- decompress the kernel
- relocate the kernel

So do all of this from the EFI stub code, and avoid the bare metal
decompressor altogether.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-24-ardb@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile       |   5 +
 arch/x86/boot/compressed/efi_mixed.S    |  55 -------
 arch/x86/boot/compressed/head_32.S      |  13 --
 arch/x86/boot/compressed/head_64.S      |  27 ----
 arch/x86/include/asm/efi.h              |   7 +-
 arch/x86/include/asm/sev.h              |   2 +
 drivers/firmware/efi/libstub/x86-stub.c | 166 +++++++++-----------
 7 files changed, 84 insertions(+), 191 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 0c9ebf74fac5..3965b2c9efee 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -74,6 +74,11 @@ LDFLAGS_vmlinux += -z noexecstack
 ifeq ($(CONFIG_LD_IS_BFD),y)
 LDFLAGS_vmlinux += $(call ld-option,--no-warn-rwx-segments)
 endif
+ifeq ($(CONFIG_EFI_STUB),y)
+# ensure that the static EFI stub library will be pulled in, even if it is
+# never referenced explicitly from the startup code
+LDFLAGS_vmlinux += -u efi_pe_entry
+endif
 LDFLAGS_vmlinux += -T
 
 hostprogs	:= mkpiggy
diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index d6d1b76b594d..8232c5b2a9bf 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -275,10 +275,6 @@ SYM_FUNC_START_LOCAL(efi32_entry)
 	jmp	startup_32
 SYM_FUNC_END(efi32_entry)
 
-#define ST32_boottime		60 // offsetof(efi_system_table_32_t, boottime)
-#define BS32_handle_protocol	88 // offsetof(efi_boot_services_32_t, handle_protocol)
-#define LI32_image_base		32 // offsetof(efi_loaded_image_32_t, image_base)
-
 /*
  * efi_status_t efi32_pe_entry(efi_handle_t image_handle,
  *			       efi_system_table_32_t *sys_table)
@@ -286,8 +282,6 @@ SYM_FUNC_END(efi32_entry)
 SYM_FUNC_START(efi32_pe_entry)
 	pushl	%ebp
 	movl	%esp, %ebp
-	pushl	%eax				// dummy push to allocate loaded_image
-
 	pushl	%ebx				// save callee-save registers
 	pushl	%edi
 
@@ -296,48 +290,8 @@ SYM_FUNC_START(efi32_pe_entry)
 	movl	$0x80000003, %eax		// EFI_UNSUPPORTED
 	jnz	2f
 
-	call	1f
-1:	pop	%ebx
-
-	/* Get the loaded image protocol pointer from the image handle */
-	leal	-4(%ebp), %eax
-	pushl	%eax				// &loaded_image
-	leal	(loaded_image_proto - 1b)(%ebx), %eax
-	pushl	%eax				// pass the GUID address
-	pushl	8(%ebp)				// pass the image handle
-
-	/*
-	 * Note the alignment of the stack frame.
-	 *   sys_table
-	 *   handle             <-- 16-byte aligned on entry by ABI
-	 *   return address
-	 *   frame pointer
-	 *   loaded_image       <-- local variable
-	 *   saved %ebx		<-- 16-byte aligned here
-	 *   saved %edi
-	 *   &loaded_image
-	 *   &loaded_image_proto
-	 *   handle             <-- 16-byte aligned for call to handle_protocol
-	 */
-
-	movl	12(%ebp), %eax			// sys_table
-	movl	ST32_boottime(%eax), %eax	// sys_table->boottime
-	call	*BS32_handle_protocol(%eax)	// sys_table->boottime->handle_protocol
-	addl	$12, %esp			// restore argument space
-	testl	%eax, %eax
-	jnz	2f
-
 	movl	8(%ebp), %ecx			// image_handle
 	movl	12(%ebp), %edx			// sys_table
-	movl	-4(%ebp), %esi			// loaded_image
-	movl	LI32_image_base(%esi), %esi	// loaded_image->image_base
-	leal	(startup_32 - 1b)(%ebx), %ebp	// runtime address of startup_32
-	/*
-	 * We need to set the image_offset variable here since startup_32() will
-	 * use it before we get to the 64-bit efi_pe_entry() in C code.
-	 */
-	subl	%esi, %ebp			// calculate image_offset
-	movl	%ebp, (image_offset - 1b)(%ebx)	// save image_offset
 	xorl	%esi, %esi
 	jmp	efi32_entry			// pass %ecx, %edx, %esi
 						// no other registers remain live
@@ -356,15 +310,6 @@ SYM_FUNC_START_NOALIGN(efi64_stub_entry)
 SYM_FUNC_END(efi64_stub_entry)
 #endif
 
-	.section ".rodata"
-	/* EFI loaded image protocol GUID */
-	.balign 4
-SYM_DATA_START_LOCAL(loaded_image_proto)
-	.long	0x5b1b31a1
-	.word	0x9562, 0x11d2
-	.byte	0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b
-SYM_DATA_END(loaded_image_proto)
-
 	.data
 	.balign	8
 SYM_DATA_START_LOCAL(efi32_boot_gdt)
diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 3af4a383615b..1cfe9802a42f 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -84,19 +84,6 @@ SYM_FUNC_START(startup_32)
 
 #ifdef CONFIG_RELOCATABLE
 	leal	startup_32@GOTOFF(%edx), %ebx
-
-#ifdef CONFIG_EFI_STUB
-/*
- * If we were loaded via the EFI LoadImage service, startup_32() will be at an
- * offset to the start of the space allocated for the image. efi_pe_entry() will
- * set up image_offset to tell us where the image actually starts, so that we
- * can use the full available buffer.
- *	image_offset = startup_32 - image_base
- * Otherwise image_offset will be zero and has no effect on the calculations.
- */
-	subl    image_offset@GOTOFF(%edx), %ebx
-#endif
-
 	movl	BP_kernel_alignment(%esi), %eax
 	decl	%eax
 	addl    %eax, %ebx
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 9a0d83b4d266..0d7aef10b19a 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -138,19 +138,6 @@ SYM_FUNC_START(startup_32)
 
 #ifdef CONFIG_RELOCATABLE
 	movl	%ebp, %ebx
-
-#ifdef CONFIG_EFI_STUB
-/*
- * If we were loaded via the EFI LoadImage service, startup_32 will be at an
- * offset to the start of the space allocated for the image. efi_pe_entry will
- * set up image_offset to tell us where the image actually starts, so that we
- * can use the full available buffer.
- *	image_offset = startup_32 - image_base
- * Otherwise image_offset will be zero and has no effect on the calculations.
- */
-	subl    rva(image_offset)(%ebp), %ebx
-#endif
-
 	movl	BP_kernel_alignment(%esi), %eax
 	decl	%eax
 	addl	%eax, %ebx
@@ -327,20 +314,6 @@ SYM_CODE_START(startup_64)
 	/* Start with the delta to where the kernel will run at. */
 #ifdef CONFIG_RELOCATABLE
 	leaq	startup_32(%rip) /* - $startup_32 */, %rbp
-
-#ifdef CONFIG_EFI_STUB
-/*
- * If we were loaded via the EFI LoadImage service, startup_32 will be at an
- * offset to the start of the space allocated for the image. efi_pe_entry will
- * set up image_offset to tell us where the image actually starts, so that we
- * can use the full available buffer.
- *	image_offset = startup_32 - image_base
- * Otherwise image_offset will be zero and has no effect on the calculations.
- */
-	movl    image_offset(%rip), %eax
-	subq	%rax, %rbp
-#endif
-
 	movl	BP_kernel_alignment(%rsi), %eax
 	decl	%eax
 	addq	%rax, %rbp
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 522ff2e443b3..e601264b1a24 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -88,6 +88,8 @@ static inline void efi_fpu_end(void)
 }
 
 #ifdef CONFIG_X86_32
+#define EFI_X86_KERNEL_ALLOC_LIMIT		(SZ_512M - 1)
+
 #define arch_efi_call_virt_setup()					\
 ({									\
 	efi_fpu_begin();						\
@@ -101,8 +103,7 @@ static inline void efi_fpu_end(void)
 })
 
 #else /* !CONFIG_X86_32 */
-
-#define EFI_LOADER_SIGNATURE	"EL64"
+#define EFI_X86_KERNEL_ALLOC_LIMIT		EFI_ALLOC_LIMIT
 
 extern asmlinkage u64 __efi_call(void *fp, ...);
 
@@ -214,6 +215,8 @@ efi_status_t efi_set_virtual_address_map(unsigned long memory_map_size,
 
 #ifdef CONFIG_EFI_MIXED
 
+#define EFI_ALLOC_LIMIT		(efi_is_64bit() ? ULONG_MAX : U32_MAX)
+
 #define ARCH_HAS_EFISTUB_WRAPPERS
 
 static inline bool efi_is_64bit(void)
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index e231638ba19a..cf98fc28601f 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -157,6 +157,7 @@ static __always_inline void sev_es_nmi_complete(void)
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
+extern void sev_enable(struct boot_params *bp);
 
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs)
 {
@@ -210,6 +211,7 @@ static inline void sev_es_ist_exit(void) { }
 static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
 static inline void sev_es_nmi_complete(void) { }
 static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
+static inline void sev_enable(struct boot_params *bp) { }
 static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate) { return 0; }
 static inline int rmpadjust(unsigned long vaddr, bool rmp_psize, unsigned long attrs) { return 0; }
 static inline void setup_ghcb(void) { }
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 8d3ce383bcbb..61017921f9ca 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -15,17 +15,14 @@
 #include <asm/setup.h>
 #include <asm/desc.h>
 #include <asm/boot.h>
+#include <asm/kaslr.h>
 #include <asm/sev.h>
 
 #include "efistub.h"
 #include "x86-stub.h"
 
-/* Maximum physical address for 64-bit kernel with 4-level paging */
-#define MAXMEM_X86_64_4LEVEL (1ull << 46)
-
 const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
-u32 image_offset __section(".data");
 static efi_loaded_image_t *image = NULL;
 static efi_memory_attribute_protocol_t *memattr;
 
@@ -276,33 +273,9 @@ void efi_adjust_memory_range_protection(unsigned long start,
 	}
 }
 
-extern const u8 startup_32[], startup_64[];
-
-static void
-setup_memory_protection(unsigned long image_base, unsigned long image_size)
-{
-#ifdef CONFIG_64BIT
-	if (image_base != (unsigned long)startup_32)
-		efi_adjust_memory_range_protection(image_base, image_size);
-#else
-	/*
-	 * Clear protection flags on a whole range of possible
-	 * addresses used for KASLR. We don't need to do that
-	 * on x86_64, since KASLR/extraction is performed after
-	 * dedicated identity page tables are built and we only
-	 * need to remove possible protection on relocated image
-	 * itself disregarding further relocations.
-	 */
-	efi_adjust_memory_range_protection(LOAD_PHYSICAL_ADDR,
-					   KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR);
-#endif
-}
-
 static const efi_char16_t apple[] = L"Apple";
 
-static void setup_quirks(struct boot_params *boot_params,
-			 unsigned long image_base,
-			 unsigned long image_size)
+static void setup_quirks(struct boot_params *boot_params)
 {
 	efi_char16_t *fw_vendor = (efi_char16_t *)(unsigned long)
 		efi_table_attr(efi_system_table, fw_vendor);
@@ -311,9 +284,6 @@ static void setup_quirks(struct boot_params *boot_params,
 		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
 			retrieve_apple_device_properties(boot_params);
 	}
-
-	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES))
-		setup_memory_protection(image_base, image_size);
 }
 
 /*
@@ -466,7 +436,6 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	}
 
 	image_base = efi_table_attr(image, image_base);
-	image_offset = (void *)startup_32 - image_base;
 
 	status = efi_allocate_pages(sizeof(struct boot_params),
 				    (unsigned long *)&boot_params, ULONG_MAX);
@@ -761,6 +730,61 @@ static bool have_unsupported_snp_features(void)
 	return false;
 }
 
+static void efi_get_seed(void *seed, int size)
+{
+	efi_get_random_bytes(size, seed);
+
+	/*
+	 * This only updates seed[0] when running on 32-bit, but in that case,
+	 * seed[1] is not used anyway, as there is no virtual KASLR on 32-bit.
+	 */
+	*(unsigned long *)seed ^= kaslr_get_random_long("EFI");
+}
+
+static void error(char *str)
+{
+	efi_warn("Decompression failed: %s\n", str);
+}
+
+static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
+{
+	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
+	unsigned long addr, alloc_size, entry;
+	efi_status_t status;
+	u32 seed[2] = {};
+
+	/* determine the required size of the allocation */
+	alloc_size = ALIGN(max_t(unsigned long, output_len, kernel_total_size),
+			   MIN_KERNEL_ALIGN);
+
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && !efi_nokaslr) {
+		u64 range = KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR - kernel_total_size;
+
+		efi_get_seed(seed, sizeof(seed));
+
+		virt_addr += (range * seed[1]) >> 32;
+		virt_addr &= ~(CONFIG_PHYSICAL_ALIGN - 1);
+	}
+
+	status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
+				  seed[0], EFI_LOADER_CODE,
+				  EFI_X86_KERNEL_ALLOC_LIMIT);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	entry = decompress_kernel((void *)addr, virt_addr, error);
+	if (entry == ULONG_MAX) {
+		efi_free(alloc_size, addr);
+		return EFI_LOAD_ERROR;
+	}
+
+	*kernel_entry = addr + entry;
+
+	efi_adjust_memory_range_protection(addr, kernel_total_size);
+
+	return EFI_SUCCESS;
+}
+
 static void __noreturn enter_kernel(unsigned long kernel_addr,
 				    struct boot_params *boot_params)
 {
@@ -780,10 +804,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 			       struct boot_params *boot_params)
 {
 	efi_guid_t guid = EFI_MEMORY_ATTRIBUTE_PROTOCOL_GUID;
-	unsigned long bzimage_addr = (unsigned long)startup_32;
-	unsigned long buffer_start, buffer_end;
 	struct setup_header *hdr = &boot_params->hdr;
 	const struct linux_efi_initrd *initrd = NULL;
+	unsigned long kernel_entry;
 	efi_status_t status;
 
 	efi_system_table = sys_table_arg;
@@ -812,60 +835,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
-	/*
-	 * If the kernel isn't already loaded at a suitable address,
-	 * relocate it.
-	 *
-	 * It must be loaded above LOAD_PHYSICAL_ADDR.
-	 *
-	 * The maximum address for 64-bit is 1 << 46 for 4-level paging. This
-	 * is defined as the macro MAXMEM, but unfortunately that is not a
-	 * compile-time constant if 5-level paging is configured, so we instead
-	 * define our own macro for use here.
-	 *
-	 * For 32-bit, the maximum address is complicated to figure out, for
-	 * now use KERNEL_IMAGE_SIZE, which will be 512MiB, the same as what
-	 * KASLR uses.
-	 *
-	 * Also relocate it if image_offset is zero, i.e. the kernel wasn't
-	 * loaded by LoadImage, but rather by a bootloader that called the
-	 * handover entry. The reason we must always relocate in this case is
-	 * to handle the case of systemd-boot booting a unified kernel image,
-	 * which is a PE executable that contains the bzImage and an initrd as
-	 * COFF sections. The initrd section is placed after the bzImage
-	 * without ensuring that there are at least init_size bytes available
-	 * for the bzImage, and thus the compressed kernel's startup code may
-	 * overwrite the initrd unless it is moved out of the way.
-	 */
-
-	buffer_start = ALIGN(bzimage_addr - image_offset,
-			     hdr->kernel_alignment);
-	buffer_end = buffer_start + hdr->init_size;
-
-	if ((buffer_start < LOAD_PHYSICAL_ADDR)				     ||
-	    (IS_ENABLED(CONFIG_X86_32) && buffer_end > KERNEL_IMAGE_SIZE)    ||
-	    (IS_ENABLED(CONFIG_X86_64) && buffer_end > MAXMEM_X86_64_4LEVEL) ||
-	    (image_offset == 0)) {
-		extern char _bss[];
-
-		status = efi_relocate_kernel(&bzimage_addr,
-					     (unsigned long)_bss - bzimage_addr,
-					     hdr->init_size,
-					     hdr->pref_address,
-					     hdr->kernel_alignment,
-					     LOAD_PHYSICAL_ADDR);
-		if (status != EFI_SUCCESS) {
-			efi_err("efi_relocate_kernel() failed!\n");
-			goto fail;
-		}
-		/*
-		 * Now that we've copied the kernel elsewhere, we no longer
-		 * have a set up block before startup_32(), so reset image_offset
-		 * to zero in case it was set earlier.
-		 */
-		image_offset = 0;
-	}
-
 #ifdef CONFIG_CMDLINE_BOOL
 	status = efi_parse_options(CONFIG_CMDLINE);
 	if (status != EFI_SUCCESS) {
@@ -883,6 +852,12 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		}
 	}
 
+	status = efi_decompress_kernel(&kernel_entry);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to decompress kernel\n");
+		goto fail;
+	}
+
 	/*
 	 * At this point, an initrd may already have been loaded by the
 	 * bootloader and passed via bootparams. We permit an initrd loaded
@@ -922,7 +897,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 
 	setup_efi_pci(boot_params);
 
-	setup_quirks(boot_params, bzimage_addr, buffer_end - buffer_start);
+	setup_quirks(boot_params);
 
 	status = exit_boot(boot_params, handle);
 	if (status != EFI_SUCCESS) {
@@ -930,12 +905,15 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		goto fail;
 	}
 
-	efi_5level_switch();
+	/*
+	 * Call the SEV init code while still running with the firmware's
+	 * GDT/IDT, so #VC exceptions will be handled by EFI.
+	 */
+	sev_enable(boot_params);
 
-	if (IS_ENABLED(CONFIG_X86_64))
-		bzimage_addr += startup_64 - startup_32;
+	efi_5level_switch();
 
-	enter_kernel(bzimage_addr, boot_params);
+	enter_kernel(kernel_entry, boot_params);
 fail:
 	efi_err("efi_stub_entry() failed!\n");
 
-- 
2.44.0.278.ge034bb2e1d-goog


