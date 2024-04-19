Return-Path: <stable+bounces-40250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4724F8AA9D8
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB9AB225CA
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5F14EB58;
	Fri, 19 Apr 2024 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YqdI/R0E"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916C441C89
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514320; cv=none; b=OWWX9B4abhXQiy7QtpveNsg7CD56SgBQJlGzhgXrGwPofc5f5YIChdq9z50LmGwMOfpcXWwuk0ylsC0P6jE34yfsoc8n0HC+y64SUOcrCnH7x6M60W+J3HxGAUaPkH49t0qOGDBcZKq6Y9p23TVCBvq/75vFFYJJcuIHqHduLYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514320; c=relaxed/simple;
	bh=wYBhCUzzsb5NN7Y5JEx2i3cni7U3x4Xaxgqg7HjXNQI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=s56i/c0l8+h1vRXjF9NLedwAE7kSG9zwuXMBeBU4DN33P+mA8HzadVf+t+rFpDi1dNxA1x8sZyCKVC6U5Vdaw/6vSmBz6ZKpx1vDYmIlL/YsFP+0vKMXkzYUqSVvxbCs5KZTB7RwQuxuM+FXzO9xKbmyq2ita4ihsUI4aw/CRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YqdI/R0E; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61afae89be3so35375317b3.0
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514317; x=1714119117; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S//NSZz/KxvXiakN0rFDDYjC7ow0HKeb0sJlhDBEF38=;
        b=YqdI/R0EHuAwSrghllLdKMnz/wtnaYDuPooqVvdSi4qVfWYo0RMCLItdgpHsPrQY/N
         3pr/R9qV2xwVbomckl6+oE0jNc3socN+NjleQODPfuKSD6SI4SpAhFpDCY7UuZhONrkE
         yYX9O42h+sSR17W8R1tcmZy5MHhoAzbZVm7CYSciq9rBLec+ySoUefUQ+rMzjfG0T2jo
         yK2aY2oISyHb/sBkEiqjJncLwkcElSnCQLgxrFtfe1bE/42Hgh9IlfuXzp19lByIxFEj
         Kn4snE4i6IMY6kdj7VnuEtwFIcgcSNIN+sqifyFWzoXQKQzKaZBBHbZ7ZYypl2hcvPTA
         0c+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514317; x=1714119117;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S//NSZz/KxvXiakN0rFDDYjC7ow0HKeb0sJlhDBEF38=;
        b=dSsg6EMqzmWPjtkRay7AgDjEhNikSON8qUHZZb97tPA5SkDW3QFuQRdfGyKXeDuP+Q
         pyfkimLdzxu31whMiI8+364yUZkjsUuH2FQPpXXEbiaAyOmzTHbN2pjb24whF0Ynklqm
         Xj3jlNkMTfnif/NP6/HFGX8PIS03REn15t3AA3Ap/XnpnJTOxXt3EVOpfIwoLlg6Gesq
         wNXn3/vrb/cHDX8JWriEA53iFmQXa3oFwItCIREYM5JKSPfY3cBuSm5cq3BPLz2PZdjV
         DEIbgozMXGEUhJblJ/7X/uyeuR4fkH60KPOcd8v2gx63QOGUATrYwZmYV0KdMrgOVp/z
         9wDA==
X-Gm-Message-State: AOJu0Yz3brCdUELbUdLK07EJDTr5efNKdBYh9zWfVtalpP1jL7P/Iv3e
	aAxtHOWM7MSnjrqpTGhV6yvBQrXan7QN0LyLTox7pR1BflHDkI813S+18QvTAeW8/tVIPkIbfOL
	lA2gj63eyw1/oWR6QYitbaJ89KsuawltOHur7XdscKtnw/LvsKmZ2pSbqlhTdVpWxAIFwlez5xj
	f6ZYDyssu+MNUTgswra2f08Q==
X-Google-Smtp-Source: AGHT+IGNBsa1hVRPZyrGWHqH1IPm1jhLWKOPtiY63U2MyF7JQkrNX9Q/Z6kduboL0qRQNes0XUA07sOM
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1024:b0:de3:e1eb:ead9 with SMTP id
 x4-20020a056902102400b00de3e1ebead9mr437919ybt.11.1713514317518; Fri, 19 Apr
 2024 01:11:57 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:20 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4857; i=ardb@kernel.org;
 h=from:subject; bh=bEyz7+AZesVaQsJg5wxGpOL8bGMf14vRO+xsGAuPx0M=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXSVIYt1j/hwtZdfFt4PNnnQe2KUseb1Sbbut2Ocnv
 ctC85g6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETinBj+WXsx8fFVGWxOT+Et
 Lnh0cOoHplO3JxppsfyuLHY+JTD/JMMfzotz3J0+BnvUnnyxO36CsEZ8vqtRn8bZkwmC17fYOYh wAwA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-39-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 14/23] x86/boot: Drop PE/COFF .reloc section
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit fa5750521e0a4efbc1af05223da9c4bbd6c21c83 upstream ]

Ancient buggy EFI loaders may have required a .reloc section to be
present at some point in time, but this has not been true for a long
time so the .reloc section can just be dropped.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230915171623.655440-16-ardb@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 20 ------------
 arch/x86/boot/setup.ld      |  4 +--
 arch/x86/boot/tools/build.c | 34 +++-----------------
 3 files changed, 7 insertions(+), 51 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index f8f609fb8709..a01e55ce506f 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -154,26 +154,6 @@ section_table:
 		IMAGE_SCN_MEM_READ		| \
 		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
-	#
-	# The EFI application loader requires a relocation section
-	# because EFI applications must be relocatable. The .reloc
-	# offset & size fields are filled in by build.c.
-	#
-	.ascii	".reloc"
-	.byte	0
-	.byte	0
-	.long	0
-	.long	0
-	.long	0				# SizeOfRawData
-	.long	0				# PointerToRawData
-	.long	0				# PointerToRelocations
-	.long	0				# PointerToLineNumbers
-	.word	0				# NumberOfRelocations
-	.word	0				# NumberOfLineNumbers
-	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
-		IMAGE_SCN_MEM_READ		| \
-		IMAGE_SCN_MEM_DISCARDABLE	# Characteristics
-
 #ifdef CONFIG_EFI_MIXED
 	#
 	# The offset & size fields are filled in by build.c.
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 9bd5c1ada599..6d389499565c 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -40,8 +40,8 @@ SECTIONS
 		setup_sig = .;
 		LONG(0x5a5aaa55)
 
-		/* Reserve some extra space for the reloc and compat sections */
-		setup_size = ALIGN(ABSOLUTE(.) + 64, 512);
+		/* Reserve some extra space for the compat section */
+		setup_size = ALIGN(ABSOLUTE(.) + 32, 512);
 		setup_sects = ABSOLUTE(setup_size / 512);
 	}
 
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 9712f27e32c1..faccff9743a3 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -47,7 +47,6 @@ typedef unsigned int   u32;
 /* This must be large enough to hold the entire setup */
 u8 buf[SETUP_SECT_MAX*512];
 
-#define PECOFF_RELOC_RESERVE 0x20
 #define PECOFF_COMPAT_RESERVE 0x20
 
 static unsigned long efi32_pe_entry;
@@ -180,24 +179,13 @@ static void update_pecoff_section_header(char *section_name, u32 offset, u32 siz
 	update_pecoff_section_header_fields(section_name, offset, size, size, offset);
 }
 
-static void update_pecoff_setup_and_reloc(unsigned int size)
+static void update_pecoff_setup(unsigned int size)
 {
 	u32 setup_offset = 0x200;
-	u32 reloc_offset = size - PECOFF_RELOC_RESERVE - PECOFF_COMPAT_RESERVE;
-#ifdef CONFIG_EFI_MIXED
-	u32 compat_offset = reloc_offset + PECOFF_RELOC_RESERVE;
-#endif
-	u32 setup_size = reloc_offset - setup_offset;
+	u32 compat_offset = size - PECOFF_COMPAT_RESERVE;
+	u32 setup_size = compat_offset - setup_offset;
 
 	update_pecoff_section_header(".setup", setup_offset, setup_size);
-	update_pecoff_section_header(".reloc", reloc_offset, PECOFF_RELOC_RESERVE);
-
-	/*
-	 * Modify .reloc section contents with a single entry. The
-	 * relocation is applied to offset 10 of the relocation section.
-	 */
-	put_unaligned_le32(reloc_offset + 10, &buf[reloc_offset]);
-	put_unaligned_le32(10, &buf[reloc_offset + 4]);
 
 #ifdef CONFIG_EFI_MIXED
 	update_pecoff_section_header(".compat", compat_offset, PECOFF_COMPAT_RESERVE);
@@ -214,21 +202,10 @@ static void update_pecoff_setup_and_reloc(unsigned int size)
 #endif
 }
 
-static int reserve_pecoff_reloc_section(int c)
-{
-	/* Reserve 0x20 bytes for .reloc section */
-	memset(buf+c, 0, PECOFF_RELOC_RESERVE);
-	return PECOFF_RELOC_RESERVE;
-}
-
 #else
 
-static inline void update_pecoff_setup_and_reloc(unsigned int size) {}
+static inline void update_pecoff_setup(unsigned int size) {}
 
-static inline int reserve_pecoff_reloc_section(int c)
-{
-	return 0;
-}
 #endif /* CONFIG_EFI_STUB */
 
 static int reserve_pecoff_compat_section(int c)
@@ -307,7 +284,6 @@ int main(int argc, char ** argv)
 	fclose(file);
 
 	c += reserve_pecoff_compat_section(c);
-	c += reserve_pecoff_reloc_section(c);
 
 	/* Pad unused space with zeros */
 	setup_sectors = (c + 511) / 512;
@@ -316,7 +292,7 @@ int main(int argc, char ** argv)
 	i = setup_sectors*512;
 	memset(buf+c, 0, i-c);
 
-	update_pecoff_setup_and_reloc(i);
+	update_pecoff_setup(i);
 
 	/* Open and stat the kernel file */
 	fd = open(argv[2], O_RDONLY);
-- 
2.44.0.769.g3c40516874-goog


