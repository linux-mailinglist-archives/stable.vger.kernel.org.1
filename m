Return-Path: <stable+bounces-40249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BA58AA9D7
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEB01F22CD1
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CDD4E1DC;
	Fri, 19 Apr 2024 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2hgolva"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE9941C89
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514317; cv=none; b=r+EIozXW9NEEb22p/dXARraRwgozmtYVc3KTWTU+8PAt+LlJpgdAQycJpPq1qHhDfrl65ZkIamxEjLWSBfkC5GvMjR7dmpMNW7lCbTtIFS5jRVMD0Suf/x/1UO5zv4PtTia0H84MvmuHyTfK1Bbnf/W0k4M6Wu4aU1gdiNuI5YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514317; c=relaxed/simple;
	bh=hF1ZcwbkZgdUEXwGbkehJjqxVcwsPEV99ySVpF2KBM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oE5B9MnKhhn+yr6tYZnbEQOf3+nn90VMB8PRn/Gl3+sVLsLgoen85hvDOGFWEWud2UlZtK8PviLeiAF/tv19Y/hb2dZHAUjWcwnCcTUol1kejk1TnSGPn+OSED92S9OeBTWGvU8CqAJkGjEwMIg1Hyiv9FRqeP0/J88ZQX3BZI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2hgolva; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-615073c8dfbso33837247b3.1
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514315; x=1714119115; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHAY0Yh/Ep5trqHI57nrXfEwDrE7wIVhIlZIlY4DzPk=;
        b=X2hgolvayoklO2bKKMMj27JmtNfG7OqRBADG57D2c5eFg1F4Y75/Xs2v9q2MrlAtQQ
         JrCG41wamB69EQRK+uoBi4PFpH8faohDMXLYEZip2e/qYFFDYA7XcqKdZZaV2cKMno7W
         pKDupHVZxuXl9ImB6FZdMSDi010Q4C68que2zoqtITeea32Fuq5s1QTi5fosll8bOAeK
         No2dokmrMnGVToWS3GbzQQ7QoquKfxFE3JhOGC1ELCREGP0ShWSBCd7M/MNRRjDqx5S0
         /2aRG4g53/No8MRhzOo3iG9RA0/OPsvUAygoqQ5jWFMeUwKKAgVfkb1U3yTFfB3yIp+g
         fpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514315; x=1714119115;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHAY0Yh/Ep5trqHI57nrXfEwDrE7wIVhIlZIlY4DzPk=;
        b=FmsbeCwZyQaFp9G84iHM/HSnhDfvfRHyryiIcV6aAcQJtOF3BmABWDxtOH+aNREBU6
         byLgSL+dV/i18yJ1xkIttZ6XjmSMwfrfV6fm6jJzwzAc5R6qBpPFteMCBIYZAv7pYHW9
         pDiqvaTrUftZmzSZcyOHmmXYx0iWuWuzzz2ZT4EniFGAvLM/u71fXwPyHW+PPBiXtvqF
         hCkfw0MGtUKTT4P56CM2VLm9UqgDN3OdnHCZd/cjRQqnbyskpOoASt8dL2KRy+9wtlpi
         E9oNdftS6RdWI69cjQjmxnHyqybVvQ43w5hfaxMDsxMcwPkFQsUrQoi2jdcCxOk8nv71
         L8mQ==
X-Gm-Message-State: AOJu0YxOWzCpXky5AJBOz5gZeAFR34S8OYO7EqFstblyRB6aF+7h49kx
	E/nNOuAhHvVZl2DU1KdFj722alG7e4GMA42Xw7UWio43MIJeDcvt/rWEUthmsow6YpFQLudiGlY
	DN3w21Q0AsmH70g5h58KnbOajeRVy8VbYXHsGZYo51sQTqXozL37Fgro7vhrcx7u2wHleSVsw73
	3oNanFjqCxCBEWtC+AVR1S3A==
X-Google-Smtp-Source: AGHT+IFvDdF3JbXjqpTTWgYBGwACixEgLOgokM5kKYa0BBf0V4DvTzWsqErmoR715eT6LyQtbEy3l/Wb
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:10c1:b0:dbe:a0c2:df25 with SMTP id
 w1-20020a05690210c100b00dbea0c2df25mr106232ybu.8.1713514315191; Fri, 19 Apr
 2024 01:11:55 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:19 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5312; i=ardb@kernel.org;
 h=from:subject; bh=tzIO3Ads8GtWCak6dBga78ZdjLm0yhiJh/kfV69rufw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXfntc9l1Dx5F8v9d/Xhzz7JDStxflu/wyw/0VG2dv
 7BiVolDRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiI3ASGf7b/8j8+37bsnzqH
 6r0Kj8hpq0Kz9CsLfKeGVyXNvvWN4wsjw/NrERoxTz52TX/93VmhU/PvwwW+8uH+t3xXacoKKXs VMQMA
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-38-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 13/23] x86/boot: Construct PE/COFF .text
 section from assembler
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit efa089e63b56bdc5eca754b995cb039dd7a5457e upstream ]

Now that the size of the setup block is visible to the assembler, it is
possible to populate the PE/COFF header fields from the asm code
directly, instead of poking the values into the binary using the build
tool. This will make it easier to reorganize the section layout without
having to tweak the build tool in lockstep.

This change has no impact on the resulting bzImage binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230915171623.655440-15-ardb@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 22 +++------
 arch/x86/boot/tools/build.c | 47 --------------------
 2 files changed, 7 insertions(+), 62 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b43b55130855..f8f609fb8709 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -74,14 +74,12 @@ optional_header:
 	.byte	0x02				# MajorLinkerVersion
 	.byte	0x14				# MinorLinkerVersion
 
-	# Filled in by build.c
-	.long	0				# SizeOfCode
+	.long	setup_size + ZO__end - 0x200	# SizeOfCode
 
 	.long	0				# SizeOfInitializedData
 	.long	0				# SizeOfUninitializedData
 
-	# Filled in by build.c
-	.long	0x0000				# AddressOfEntryPoint
+	.long	setup_size + ZO_efi_pe_entry	# AddressOfEntryPoint
 
 	.long	0x0200				# BaseOfCode
 #ifdef CONFIG_X86_32
@@ -104,10 +102,7 @@ extra_header_fields:
 	.word	0				# MinorSubsystemVersion
 	.long	0				# Win32VersionValue
 
-	#
-	# The size of the bzImage is written in tools/build.c
-	#
-	.long	0				# SizeOfImage
+	.long	setup_size + ZO__end 		# SizeOfImage
 
 	.long	0x200				# SizeOfHeaders
 	.long	0				# CheckSum
@@ -198,18 +193,15 @@ section_table:
 		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
 #endif
 
-	#
-	# The offset & size fields are filled in by build.c.
-	#
 	.ascii	".text"
 	.byte	0
 	.byte	0
 	.byte	0
-	.long	0
-	.long	0x0				# startup_{32,64}
-	.long	0				# Size of initialized data
+	.long	ZO__end
+	.long	setup_size
+	.long	ZO__edata			# Size of initialized data
 						# on disk
-	.long	0x0				# startup_{32,64}
+	.long	setup_size
 	.long	0				# PointerToRelocations
 	.long	0				# PointerToLineNumbers
 	.word	0				# NumberOfRelocations
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index e792c6c5a634..9712f27e32c1 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -50,10 +50,8 @@ u8 buf[SETUP_SECT_MAX*512];
 #define PECOFF_RELOC_RESERVE 0x20
 #define PECOFF_COMPAT_RESERVE 0x20
 
-static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
 static unsigned long _edata;
-static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
 
@@ -216,32 +214,6 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
 #endif
 }
 
-static void update_pecoff_text(unsigned int text_start, unsigned int file_sz)
-{
-	unsigned int pe_header;
-	unsigned int text_sz = file_sz - text_start;
-	unsigned int bss_sz = _end - text_sz;
-
-	pe_header = get_unaligned_le32(&buf[0x3c]);
-
-	/*
-	 * Size of code: Subtract the size of the first sector (512 bytes)
-	 * which includes the header.
-	 */
-	put_unaligned_le32(file_sz - 512 + bss_sz, &buf[pe_header + 0x1c]);
-
-	/* Size of image */
-	put_unaligned_le32(file_sz + bss_sz, &buf[pe_header + 0x50]);
-
-	/*
-	 * Address of entry point for PE/COFF executable
-	 */
-	put_unaligned_le32(text_start + efi_pe_entry, &buf[pe_header + 0x28]);
-
-	update_pecoff_section_header_fields(".text", text_start, text_sz + bss_sz,
-					    text_sz, text_start);
-}
-
 static int reserve_pecoff_reloc_section(int c)
 {
 	/* Reserve 0x20 bytes for .reloc section */
@@ -249,22 +221,9 @@ static int reserve_pecoff_reloc_section(int c)
 	return PECOFF_RELOC_RESERVE;
 }
 
-static void efi_stub_defaults(void)
-{
-	/* Defaults for old kernel */
-#ifdef CONFIG_X86_32
-	efi_pe_entry = 0x10;
-#else
-	efi_pe_entry = 0x210;
-#endif
-}
-
 #else
 
 static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
-static inline void update_pecoff_text(unsigned int text_start,
-				      unsigned int file_sz) {}
-static inline void efi_stub_defaults(void) {}
 
 static inline int reserve_pecoff_reloc_section(int c)
 {
@@ -307,10 +266,8 @@ static void parse_zoffset(char *fname)
 	p = (char *)buf;
 
 	while (p && *p) {
-		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
 		PARSE_ZOFS(p, _edata);
-		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
 		while (p && (*p == '\r' || *p == '\n'))
@@ -328,8 +285,6 @@ int main(int argc, char ** argv)
 	void *kernel;
 	u32 crc = 0xffffffffUL;
 
-	efi_stub_defaults();
-
 	if (argc != 5)
 		usage();
 	parse_zoffset(argv[3]);
@@ -376,8 +331,6 @@ int main(int argc, char ** argv)
 	kernel = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
 	if (kernel == MAP_FAILED)
 		die("Unable to mmap '%s': %m", argv[2]);
-	update_pecoff_text(setup_sectors * 512, i + _edata);
-
 
 	crc = partial_crc32(buf, i, crc);
 	if (fwrite(buf, 1, i, dest) != i)
-- 
2.44.0.769.g3c40516874-goog


