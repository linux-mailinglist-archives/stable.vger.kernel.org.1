Return-Path: <stable+bounces-21417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED1085C8CF
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A852B20DE8
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06010151CDC;
	Tue, 20 Feb 2024 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KM06SBGE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FC71509AC;
	Tue, 20 Feb 2024 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464352; cv=none; b=XeIm0oY1zCPlhPW1oM5LUWvnxnDMEzOsQBhoHoLPpHexIRnBeQERDo5cKyz0nlc6ss7+okXd7VVAQRyakmj0uFjdT2O8Cs5jGiAAAHQCYmlQ6bw21F5SH24VFE3Jfk0NimUoxb/JBdh9vo7aNRRGH34lekIuJLMmOxtucjTO2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464352; c=relaxed/simple;
	bh=gY1urJ2ZtIfWEpi/vj+AVCUhLI9/lcYrmE+uaJX0w3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyV+C3TItcak28+IvCunciltll35+mb0YiVCzRMzEv8s1yG7vyazcqC2b7MyLFxC3nt2SZVeJKO+xX1Y4jy6C2ajtLgs4NuuANCQ2ZF8dAPq0tTW2nQ32PVjPQBLaQnZwm/j5+t0laQ7801s5+EHIMM+io/SnxggXMcz6oE5eg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KM06SBGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2D8C433C7;
	Tue, 20 Feb 2024 21:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708464352;
	bh=gY1urJ2ZtIfWEpi/vj+AVCUhLI9/lcYrmE+uaJX0w3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KM06SBGEhbtOidk721k+rt7Z32qny5IGaNmfyNa1Z0BtnNW4J37uR+M/ltbg5mlPQ
	 06XhlhMHb/wtMkG5nvVauv45hRkyrN0HmBQhd9D8tL80lzfG7OCxoMgcOahWIexggP
	 8FCerKTKxRTyZyO5gh3mW05O+UshAFBUytCZcq7U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6.6 330/331] x86/boot: Increase section and file alignment to 4k/512
Date: Tue, 20 Feb 2024 21:57:26 +0100
Message-ID: <20240220205648.613705786@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
References: <20240220205637.572693592@linuxfoundation.org>
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

From: Ard Biesheuvel <ardb@kernel.org>

commit 3e3eabe26dc88692d34cf76ca0e0dd331481cc15 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/compressed/vmlinux.lds.S |    4 -
 arch/x86/boot/header.S                 |   75 +++++++++++++++------------
 arch/x86/boot/setup.ld                 |    7 +-
 arch/x86/boot/tools/build.c            |   90 ---------------------------------
 4 files changed, 51 insertions(+), 125 deletions(-)

--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -43,13 +43,13 @@ SECTIONS
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
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -36,6 +36,9 @@ SYSSEG		= 0x1000		/* historical load add
 #define ROOT_RDONLY 1
 #endif
 
+	.set	salign, 0x1000
+	.set	falign, 0x200
+
 	.code16
 	.section ".bstext", "ax"
 #ifdef CONFIG_EFI_STUB
@@ -82,7 +85,7 @@ optional_header:
 
 	.long	setup_size + ZO_efi_pe_entry	# AddressOfEntryPoint
 
-	.long	0x0200				# BaseOfCode
+	.long	setup_size			# BaseOfCode
 #ifdef CONFIG_X86_32
 	.long	0				# data
 #endif
@@ -93,8 +96,8 @@ extra_header_fields:
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
@@ -103,9 +106,10 @@ extra_header_fields:
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
@@ -136,44 +140,51 @@ extra_header_fields:
 
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



