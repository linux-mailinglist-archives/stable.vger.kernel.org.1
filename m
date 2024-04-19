Return-Path: <stable+bounces-40252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB968AA9D9
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123E12814AE
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AAD4D59F;
	Fri, 19 Apr 2024 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qbj1X9qt"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A123E485
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514325; cv=none; b=aY06t3BHTcEAKszp40mlFXkUvaWoUhe6DHdGefUlO+NBDDiAULceKxTwfhvwDNrD3/mzXIO+mbU51vwIeCu/0OE6GFzk1q0+y+kUHqDKDEJ/S7B6Z2w1LeukKoIfc0/WyAD5ETh2JUhImsioW9djsRUbxx7PCLPwuCR64WSoIhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514325; c=relaxed/simple;
	bh=k9hhbN6y2DOufNn1tCcqAzNk4hd4C6hGwMyUIVXWBbM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qSy+lLyefvQZqhCEdodAfADyshLpLa4ePnoJyQM9gppG6XsnPh1dw5INKLQPXpPkVhAJsJHc87zuMP69y9WgKthz0TPs6/HU13aaSmUQs+TJjCEvm/diF1aGpinveagZqQC0rH+fCJtd8B/RSCwmCsQV8Q4nsUhuFXOqdH1e7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qbj1X9qt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61ab7fc5651so33133977b3.2
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514322; x=1714119122; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXCi0wKKQOfrzO/bTMWjptHg9C0x1/oDOE+jZCOZ+mQ=;
        b=Qbj1X9qtcCKDDhhPu7Wi1diL6/ooNxMCSWs9t4t74I0sOhZSUwFJfEPEK79Q9Zt4oB
         A8yJ204vHHOje5XIQT+jF1ItiL1VMWJ+FEGwax99lYKA/J12MRO2Yy328hQ/dVvv9OrX
         Nx+uXlVIDI1jRbz72C1fLnulC1iWy87XdiOIl5G3bIP14J3ud67I+g8EkALs+BC7bEtN
         J3vEF58TxVGFVFM7Jm/e64Rv+LRwpwCL4JYcpG/mGDV19LPZ7Nqjwc+JSsBfxLHuQjS6
         kc11gimUkPPvWZat0uHDqQ/FoWaxF+WW9fxuTqd9I/FlcLaN/uCPSh2BE4DzvV4g7MKR
         /lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514322; x=1714119122;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXCi0wKKQOfrzO/bTMWjptHg9C0x1/oDOE+jZCOZ+mQ=;
        b=KX/wNAdc2WxHas/M8JqDVK7E88fPhWujfprZWTldsoD1NtCqA48Ami+uL2f5DgJ2xm
         jBZuJS5y6KpWbCoVVg9+g35HA9ys07tdLIqDVb1NOMP/cGN/SqV8S/K+I1c+zLsZDH8k
         2vbiK5m1FKGYVbXpV6LXpQ5/IOYCL5hI+l6Vak71SHoQuPKPOABxsTvwyPFU95wSJ/Fn
         ky/UxBoa0CeDmjvxvZvBea2xrmknAGAXeh2QGqr8Y4o+9/9s1XLBRgLy29Pvs2LodVLC
         keydMtS9KndXHR/uAENreQMCGGtlzFLdjXdL2IhRWFwa2A2G/7eSqociXjAv9Z54AjvR
         LvMA==
X-Gm-Message-State: AOJu0YxfOvhK6zKBKjTm2ft2ehfduetb/KnVYfZCsPYwZUE5pa7uvtj0
	XpSO2YHyWFsEQ4Dz7MEq6rveEWxlD+4NbGRcW413jqKzk1Nvm+bKv1gY9V7RJL271IiiP8TFuC5
	jf/k1SJrvNlwBMq9eXaitw1huxRePGe89Lez/w/cHTMpSbpwU5Ao6NTFoMdpStIjJgcy0Lya6Ho
	AqZolALToOY3hrXLowxGCdbw==
X-Google-Smtp-Source: AGHT+IHMML3T1qj7WneLF8wBDmNu6KLyxxScts4Yq+ZTcFhiVEJaEDW1B7KWVDysh9F96yPt3R15gN64
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:df03:0:b0:61b:737:1a86 with SMTP id
 i3-20020a0ddf03000000b0061b07371a86mr348299ywe.10.1713514322580; Fri, 19 Apr
 2024 01:12:02 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:22 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=10333; i=ardb@kernel.org;
 h=from:subject; bh=qiiMd3dKlcm09ndhXx5P+fU6Dobp5fkZZBCOQWDZKUM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXe34h9/9Esr/O8pC1m8tONRhn777iwbr7ca5973fb
 Nq67mp5RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI7SKG/0Et0Tu/GaRGXhBV
 8m+v/dYzeeM3QW4/8woOnprNr8uCvjD892Gs8ljzqv2kxAF1ib3hIe68H9+f3sgfeqZtuqq9c/M 5RgA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-41-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 16/23] x86/boot: Increase section and file
 alignment to 4k/512
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 3e3eabe26dc88692d34cf76ca0e0dd331481cc15 upstream ]

Align x86 with other EFI architectures, and increase the section
alignment to the EFI page size (4k), so that firmware is able to honour
the section permission attributes and map code read-only and data
non-executable.

There are a number of requirements that have to be taken into account:
- the sign tools get cranky when there are gaps between sections in the
  file view of the image
- the virtual offset of each section must be aligned to the image's
  section alignment
- the file offset *and size* of each section must be aligned to the
  image's file alignment
- the image size must be aligned to the section alignment
- each section's virtual offset must be greater than or equal to the
  size of the headers.

In order to meet all these requirements, while avoiding the need for
lots of padding to accommodate the .compat section, the latter is placed
at an arbitrary offset towards the end of the image, but aligned to the
minimum file alignment (512 bytes). The space before the .text section
is therefore distributed between the PE header, the .setup section and
the .compat section, leaving no gaps in the file coverage, making the
signing tools happy.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230915171623.655440-18-ardb@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/vmlinux.lds.S |  4 +-
 arch/x86/boot/header.S                 | 75 +++++++++-------
 arch/x86/boot/setup.ld                 |  7 +-
 arch/x86/boot/tools/build.c            | 90 +-------------------
 4 files changed, 51 insertions(+), 125 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index aa7e9848cd8f..bcf0e4e4c98e 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -42,13 +42,13 @@ SECTIONS
 		*(.rodata.*)
 		_erodata = . ;
 	}
-	.data :	{
+	.data :	ALIGN(0x1000) {
 		_data = . ;
 		*(.data)
 		*(.data.*)
 
 		/* Add 4 bytes of extra space for a CRC-32 checksum */
-		. = ALIGN(. + 4, 0x20);
+		. = ALIGN(. + 4, 0x200);
 		_edata = . ;
 	}
 	. = ALIGN(L1_CACHE_BYTES);
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 178252cdccf5..6264bbf54fbc 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -36,6 +36,9 @@ SYSSEG		= 0x1000		/* historical load address >> 4 */
 #define ROOT_RDONLY 1
 #endif
 
+	.set	salign, 0x1000
+	.set	falign, 0x200
+
 	.code16
 	.section ".bstext", "ax"
 #ifdef CONFIG_EFI_STUB
@@ -81,7 +84,7 @@ optional_header:
 
 	.long	setup_size + ZO_efi_pe_entry	# AddressOfEntryPoint
 
-	.long	0x0200				# BaseOfCode
+	.long	setup_size			# BaseOfCode
 #ifdef CONFIG_X86_32
 	.long	0				# data
 #endif
@@ -92,8 +95,8 @@ extra_header_fields:
 #else
 	.quad	0				# ImageBase
 #endif
-	.long	0x20				# SectionAlignment
-	.long	0x20				# FileAlignment
+	.long	salign				# SectionAlignment
+	.long	falign				# FileAlignment
 	.word	0				# MajorOperatingSystemVersion
 	.word	0				# MinorOperatingSystemVersion
 	.word	LINUX_EFISTUB_MAJOR_VERSION	# MajorImageVersion
@@ -102,9 +105,10 @@ extra_header_fields:
 	.word	0				# MinorSubsystemVersion
 	.long	0				# Win32VersionValue
 
-	.long	setup_size + ZO__end 		# SizeOfImage
+	.long	setup_size + ZO__end + pecompat_vsize
+						# SizeOfImage
 
-	.long	0x200				# SizeOfHeaders
+	.long	salign				# SizeOfHeaders
 	.long	0				# CheckSum
 	.word	IMAGE_SUBSYSTEM_EFI_APPLICATION	# Subsystem (EFI application)
 #ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
@@ -135,44 +139,51 @@ extra_header_fields:
 
 	# Section table
 section_table:
-	#
-	# The offset & size fields are filled in by build.c.
-	#
 	.ascii	".setup"
 	.byte	0
 	.byte	0
-	.long	0
-	.long	0x0				# startup_{32,64}
-	.long	0				# Size of initialized data
-						# on disk
-	.long	0x0				# startup_{32,64}
-	.long	0				# PointerToRelocations
-	.long	0				# PointerToLineNumbers
-	.word	0				# NumberOfRelocations
-	.word	0				# NumberOfLineNumbers
-	.long	IMAGE_SCN_CNT_CODE		| \
+	.long	setup_size - salign 		# VirtualSize
+	.long	salign				# VirtualAddress
+	.long	pecompat_fstart - salign	# SizeOfRawData
+	.long	salign				# PointerToRawData
+
+	.long	0, 0, 0
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_EXECUTE		# Characteristics
+		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 
 #ifdef CONFIG_EFI_MIXED
-	#
-	# The offset & size fields are filled in by build.c.
-	#
 	.asciz	".compat"
-	.long	0
-	.long	0x0
-	.long	0				# Size of initialized data
-						# on disk
-	.long	0x0
-	.long	0				# PointerToRelocations
-	.long	0				# PointerToLineNumbers
-	.word	0				# NumberOfRelocations
-	.word	0				# NumberOfLineNumbers
+
+	.long	8				# VirtualSize
+	.long	setup_size + ZO__end		# VirtualAddress
+	.long	pecompat_fsize			# SizeOfRawData
+	.long	pecompat_fstart			# PointerToRawData
+
+	.long	0, 0, 0
 	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
 		IMAGE_SCN_MEM_READ		| \
 		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
-#endif
 
+	/*
+	 * Put the IA-32 machine type and the associated entry point address in
+	 * the .compat section, so loaders can figure out which other execution
+	 * modes this image supports.
+	 */
+	.pushsection ".pecompat", "a", @progbits
+	.balign	falign
+	.set	pecompat_vsize, salign
+	.globl	pecompat_fstart
+pecompat_fstart:
+	.byte	0x1				# Version
+	.byte	8				# Size
+	.word	IMAGE_FILE_MACHINE_I386		# PE machine type
+	.long	setup_size + ZO_efi32_pe_entry	# Entrypoint
+	.popsection
+#else
+	.set	pecompat_vsize, 0
+	.set	pecompat_fstart, setup_size
+#endif
 	.ascii	".text"
 	.byte	0
 	.byte	0
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 6d389499565c..83bb7efad8ae 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -36,16 +36,17 @@ SECTIONS
 	. = ALIGN(16);
 	.data		: { *(.data*) }
 
+	.pecompat	: { *(.pecompat) }
+	PROVIDE(pecompat_fsize = setup_size - pecompat_fstart);
+
 	.signature	: {
 		setup_sig = .;
 		LONG(0x5a5aaa55)
 
-		/* Reserve some extra space for the compat section */
-		setup_size = ALIGN(ABSOLUTE(.) + 32, 512);
+		setup_size = ALIGN(ABSOLUTE(.), 4096);
 		setup_sects = ABSOLUTE(setup_size / 512);
 	}
 
-
 	. = ALIGN(16);
 	.bss		:
 	{
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index faccff9743a3..10311d77c67f 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -47,9 +47,6 @@ typedef unsigned int   u32;
 /* This must be large enough to hold the entire setup */
 u8 buf[SETUP_SECT_MAX*512];
 
-#define PECOFF_COMPAT_RESERVE 0x20
-
-static unsigned long efi32_pe_entry;
 static unsigned long _edata;
 
 /*----------------------------------------------------------------------*/
@@ -136,85 +133,6 @@ static void usage(void)
 	die("Usage: build setup system zoffset.h image");
 }
 
-#ifdef CONFIG_EFI_STUB
-
-static void update_pecoff_section_header_fields(char *section_name, u32 vma, u32 size, u32 datasz, u32 offset)
-{
-	unsigned int pe_header;
-	unsigned short num_sections;
-	u8 *section;
-
-	pe_header = get_unaligned_le32(&buf[0x3c]);
-	num_sections = get_unaligned_le16(&buf[pe_header + 6]);
-
-#ifdef CONFIG_X86_32
-	section = &buf[pe_header + 0xa8];
-#else
-	section = &buf[pe_header + 0xb8];
-#endif
-
-	while (num_sections > 0) {
-		if (strncmp((char*)section, section_name, 8) == 0) {
-			/* section header size field */
-			put_unaligned_le32(size, section + 0x8);
-
-			/* section header vma field */
-			put_unaligned_le32(vma, section + 0xc);
-
-			/* section header 'size of initialised data' field */
-			put_unaligned_le32(datasz, section + 0x10);
-
-			/* section header 'file offset' field */
-			put_unaligned_le32(offset, section + 0x14);
-
-			break;
-		}
-		section += 0x28;
-		num_sections--;
-	}
-}
-
-static void update_pecoff_section_header(char *section_name, u32 offset, u32 size)
-{
-	update_pecoff_section_header_fields(section_name, offset, size, size, offset);
-}
-
-static void update_pecoff_setup(unsigned int size)
-{
-	u32 setup_offset = 0x200;
-	u32 compat_offset = size - PECOFF_COMPAT_RESERVE;
-	u32 setup_size = compat_offset - setup_offset;
-
-	update_pecoff_section_header(".setup", setup_offset, setup_size);
-
-#ifdef CONFIG_EFI_MIXED
-	update_pecoff_section_header(".compat", compat_offset, PECOFF_COMPAT_RESERVE);
-
-	/*
-	 * Put the IA-32 machine type (0x14c) and the associated entry point
-	 * address in the .compat section, so loaders can figure out which other
-	 * execution modes this image supports.
-	 */
-	buf[compat_offset] = 0x1;
-	buf[compat_offset + 1] = 0x8;
-	put_unaligned_le16(0x14c, &buf[compat_offset + 2]);
-	put_unaligned_le32(efi32_pe_entry + size, &buf[compat_offset + 4]);
-#endif
-}
-
-#else
-
-static inline void update_pecoff_setup(unsigned int size) {}
-
-#endif /* CONFIG_EFI_STUB */
-
-static int reserve_pecoff_compat_section(int c)
-{
-	/* Reserve 0x20 bytes for .compat section */
-	memset(buf+c, 0, PECOFF_COMPAT_RESERVE);
-	return PECOFF_COMPAT_RESERVE;
-}
-
 /*
  * Parse zoffset.h and find the entry points. We could just #include zoffset.h
  * but that would mean tools/build would have to be rebuilt every time. It's
@@ -243,7 +161,6 @@ static void parse_zoffset(char *fname)
 	p = (char *)buf;
 
 	while (p && *p) {
-		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, _edata);
 
 		p = strchr(p, '\n');
@@ -283,17 +200,14 @@ int main(int argc, char ** argv)
 		die("Boot block hasn't got boot flag (0xAA55)");
 	fclose(file);
 
-	c += reserve_pecoff_compat_section(c);
-
 	/* Pad unused space with zeros */
-	setup_sectors = (c + 511) / 512;
+	setup_sectors = (c + 4095) / 4096;
+	setup_sectors *= 8;
 	if (setup_sectors < SETUP_SECT_MIN)
 		setup_sectors = SETUP_SECT_MIN;
 	i = setup_sectors*512;
 	memset(buf+c, 0, i-c);
 
-	update_pecoff_setup(i);
-
 	/* Open and stat the kernel file */
 	fd = open(argv[2], O_RDONLY);
 	if (fd < 0)
-- 
2.44.0.769.g3c40516874-goog


