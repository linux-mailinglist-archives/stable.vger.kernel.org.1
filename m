Return-Path: <stable+bounces-40248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CEE8AA9D6
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D95284428
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6004DA0D;
	Fri, 19 Apr 2024 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zef8P/83"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE6A3FBAF
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514316; cv=none; b=f8QfzGsMxNgK/mNPxjNbuO/v9SsVfQ//sS0u1TXZ2iFP2RN4+mXk0OHqP4Kt/c1fj8Br1iuvPoaqRheHMqc6XHuHdNci0aW6QiHw3gg2zZqXdUPmZ5A/NPjJYzWfGmBkNI2mGmZWrr1EoLOdpuEWVy8vn/zl5NJ0z/eH0sBBvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514316; c=relaxed/simple;
	bh=INvnrnMpiL6ZdZe1ZOJSxQvcIjwsRals4O7VjRYie04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=R144LQN0aMnhAxTJkAxIdEOsINnEShQQQ9gtrW5Q+Bn+kEKVX1ZG4JzqXemq/7PQH4xtMwJJcds37kEOxSQsIU3w/vUPyzclrfPc5Iy0H022AF8oTMnSQ4LwjKnblY0S/MXXjAAkKigCxk1VvRhT+6r/u0wFRNYcRFAdnluYSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zef8P/83; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-343d7cd8f46so1095941f8f.2
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514313; x=1714119113; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKa0j5X+UI7nPftSXrA3aQd9DHTcbVb7ZgqAifJvT2w=;
        b=Zef8P/83xNdV7ww7EbfXusPkIUnx/qQiPjX0zzi+gusFB1kCwQcpsHJE/9L1ydccHo
         7k1QfMF0LOyOLYSZWXaaNe8NOHDWJM6gG7iCGeGwN9MaRQwvslpw+df0dlQTCR67x5/M
         jcdv7JvZ9dan8nyVB6bnlvmDcVUAoD8vUoe08dfTeg4nf5BVZ3ATrJorARNi3EX+QVM3
         ad8oYBFna5fFZFcKMindZZPcHsHJiSUd3vwtaACV/FCTjb2/B0bEo2Js9iyTB7LDqf2D
         Y9mSo79vQ4I6XZbImVdAdw4bTr01NI4xDjAFa3mZQO5kyBMJR7E2SqAU2JXkyAALhErU
         gb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514313; x=1714119113;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKa0j5X+UI7nPftSXrA3aQd9DHTcbVb7ZgqAifJvT2w=;
        b=KYAWF4/9pGSfY5yzbLA58Wh51G7kDx5OrMGP8X4BXSUK+5FqqpVHBTj+QGYipApRJ9
         KG6ItN7PYX1EG6oP6Td9fFIx+iNkBqtuNC72Pb6JS82LoFM09WgrS4rpTsc5DNZEY/Ys
         bMm7RNd+wNd4Y+33YlSkHJyav+HgHuWGmPCu9kNpRvbu1VYOUhpeMVuWfrbF2DxYS+H9
         aT7QYaJnYs+ouKpqdjRGFDi4QoLPZikfLhUCIckO+3QDRd/JDYGZ2+Rpgfg4sNdP0kzP
         ji+iLO8sHDD8TvswMpf8M0hTjDvJDe9IMbmmme4yRBytZTl9vGfp5MDw4tpiOBYEf+d4
         WWjg==
X-Gm-Message-State: AOJu0Ywa+RIP7eXYpA8uefKFYFSsQOg8wDYmJFQ0Hz7Zwz2oMja9gM08
	5Ywp9XvwmDVFBnrNBviKGkNgGigKQYVtCd3lV2gf9FonqQkM/Dn5DxR0wYtkABmQHMkAUSOzBL3
	L6CuFOOZuJ/M1XSFiR1htGRzrbSEBn7J8Y/oV/4y4E4z9TwVZeu4KATcvsXxj077cwlqSEq+8Qd
	OreCyANIbGDwH49+QoeJJq4Q==
X-Google-Smtp-Source: AGHT+IHrLCeUvG7pHtyPrklZBHjFZraX1Iwa+YQpZlOb5uOf/guSZwagdy7lGQUhwZPkHM1fqxnr1unD
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:4f55:b0:418:ce34:2a92 with SMTP id
 m21-20020a05600c4f5500b00418ce342a92mr7923wmq.6.1713514313012; Fri, 19 Apr
 2024 01:11:53 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:18 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5238; i=ardb@kernel.org;
 h=from:subject; bh=J9jItfdzlDDbUDqtD0PmF20Hphf4JU3m1G61ifgytKA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXdloVZO0fsC83vvxK1/dltp0sOmZweTDO/d1H9G3c
 TW+rMvTUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbycRPDX0HNOx2/jN1MGiQ/
 JF6on1aUbK/Ck/d9/sWDYj90uKY4LWX4n7NtqeO9t4Z8c3WDpnIWO8z/WHNion/MtRX1849PKom x4QEA
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-37-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 12/23] x86/boot: Derive file size from _edata symbol
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit aeb92067f6ae994b541d7f9752fe54ed3d108bcc upstream ]

Tweak the linker script so that the value of _edata represents the
decompressor binary's file size rounded up to the appropriate alignment.
This removes the need to calculate it in the build tool, and will make
it easier to refer to the file size from the header directly in
subsequent changes to the PE header layout.

While adding _edata to the sed regex that parses the compressed
vmlinux's symbol list, tweak the regex a bit for conciseness.

This change has no impact on the resulting bzImage binary when
configured with CONFIG_EFI_STUB=y.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230915171623.655440-14-ardb@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/Makefile                 |  2 +-
 arch/x86/boot/compressed/vmlinux.lds.S |  3 ++
 arch/x86/boot/header.S                 |  2 +-
 arch/x86/boot/tools/build.c            | 30 +++++---------------
 4 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 10ea28469788..b92e00836f69 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -91,7 +91,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi32_stub_entry\|efi64_stub_entry\|efi_pe_entry\|efi32_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_edata\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 32892e81bf61..aa7e9848cd8f 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -46,6 +46,9 @@ SECTIONS
 		_data = . ;
 		*(.data)
 		*(.data.*)
+
+		/* Add 4 bytes of extra space for a CRC-32 checksum */
+		. = ALIGN(. + 4, 0x20);
 		_edata = . ;
 	}
 	. = ALIGN(L1_CACHE_BYTES);
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 6dddf469ca60..b43b55130855 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -232,7 +232,7 @@ sentinel:	.byte 0xff, 0xff        /* Used to detect broken loaders */
 hdr:
 		.byte setup_sects - 1
 root_flags:	.word ROOT_RDONLY
-syssize:	.long 0			/* Filled in by build.c */
+syssize:	.long ZO__edata / 16
 ram_size:	.word 0			/* Obsolete */
 vid_mode:	.word SVGA_MODE
 root_dev:	.word 0			/* Default to major/minor 0/0 */
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 745d64b6d930..e792c6c5a634 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -52,6 +52,7 @@ u8 buf[SETUP_SECT_MAX*512];
 
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
+static unsigned long _edata;
 static unsigned long _end;
 
 /*----------------------------------------------------------------------*/
@@ -308,6 +309,7 @@ static void parse_zoffset(char *fname)
 	while (p && *p) {
 		PARSE_ZOFS(p, efi_pe_entry);
 		PARSE_ZOFS(p, efi32_pe_entry);
+		PARSE_ZOFS(p, _edata);
 		PARSE_ZOFS(p, _end);
 
 		p = strchr(p, '\n');
@@ -320,7 +322,6 @@ int main(int argc, char ** argv)
 {
 	unsigned int i, sz, setup_sectors;
 	int c;
-	u32 sys_size;
 	struct stat sb;
 	FILE *file, *dest;
 	int fd;
@@ -368,24 +369,14 @@ int main(int argc, char ** argv)
 		die("Unable to open `%s': %m", argv[2]);
 	if (fstat(fd, &sb))
 		die("Unable to stat `%s': %m", argv[2]);
-	sz = sb.st_size;
+	if (_edata != sb.st_size)
+		die("Unexpected file size `%s': %u != %u", argv[2], _edata,
+		    sb.st_size);
+	sz = _edata - 4;
 	kernel = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
 	if (kernel == MAP_FAILED)
 		die("Unable to mmap '%s': %m", argv[2]);
-	/* Number of 16-byte paragraphs, including space for a 4-byte CRC */
-	sys_size = (sz + 15 + 4) / 16;
-#ifdef CONFIG_EFI_STUB
-	/*
-	 * COFF requires minimum 32-byte alignment of sections, and
-	 * adding a signature is problematic without that alignment.
-	 */
-	sys_size = (sys_size + 1) & ~1;
-#endif
-
-	/* Patch the setup code with the appropriate size parameters */
-	put_unaligned_le32(sys_size, &buf[0x1f4]);
-
-	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
+	update_pecoff_text(setup_sectors * 512, i + _edata);
 
 
 	crc = partial_crc32(buf, i, crc);
@@ -397,13 +388,6 @@ int main(int argc, char ** argv)
 	if (fwrite(kernel, 1, sz, dest) != sz)
 		die("Writing kernel failed");
 
-	/* Add padding leaving 4 bytes for the checksum */
-	while (sz++ < (sys_size*16) - 4) {
-		crc = partial_crc32_one('\0', crc);
-		if (fwrite("\0", 1, 1, dest) != 1)
-			die("Writing padding failed");
-	}
-
 	/* Write the CRC */
 	put_unaligned_le32(crc, buf);
 	if (fwrite(buf, 1, 4, dest) != 4)
-- 
2.44.0.769.g3c40516874-goog


