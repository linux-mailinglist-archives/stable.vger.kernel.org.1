Return-Path: <stable+bounces-40251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB618AA9DA
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1D22B2249E
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761D84EB54;
	Fri, 19 Apr 2024 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVTXHere"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB86C41C89
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514323; cv=none; b=VR2fU0pQL23LvjvskK9bxlZdVwvDTDg0wQWNutJUcZOzdN1z7NZ3O7bUZLpJno2qkm5fcpDPVcGsrAR1TiD1NYh2O4jcpl4KE0ILyHL2FGfSgbTg4rajWIUC2YlY7DkGLSMrVZbgWiPLeiOfqt9BCdzYKr0S3Hy8VBHYF0BfUYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514323; c=relaxed/simple;
	bh=IXVlJtptvXz1PrOyV8kHlbpDe3WOa+e0y/XTLT+F7X0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Vx+UrDOU9y1p7oZdTwzIXF/IdDH8YxVGwz5f2Xhq5DL27CC63XfzOh3WWI/VYFu8X5RccN6XNOlmEIHEBLgyT13iDICmYPQSxQ4IWNbTQ76/bZKy8Zduiv+xjSUaH5qDa+EhQf/bs/GsUSdB/oYqwRCjXobJrd2TZdQLCdYNF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVTXHere; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-345aa380e51so1008894f8f.3
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514320; x=1714119120; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0lPyC6xarTvLs5YoeAebpj0JOJ3efUNM423yPoYSss=;
        b=kVTXHerevcvMc7GK6v/04q3KpNahnSw0hiKeOs/KJJC0tI7eKQsw9WfWUtGMU9e8lC
         cRbWnU9x880U+wlrHDm6ZcWLgwA3aE/Sgk1UonxiOeqmLmUEQviCKuSakIbjCzqC1pGH
         FeB81zLnaYhui3EIC5l3K+DVBAOJ67rrBHgFedXgsawMdj6nTZFiBDsqstZC94XfSPc7
         leZj22uCVjoKdDkvyhAL+D4OqSXXeVgMQ9IWOX0JIPCMIwQZQeR0dp8iJKy1/GEl25IP
         EVLlSXqi9FTQBq7FXqtk3W2N8/F4b79Kpjan+JtEQLRTzdbgfcaGcLNOcy687H+MHd2l
         OHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514320; x=1714119120;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0lPyC6xarTvLs5YoeAebpj0JOJ3efUNM423yPoYSss=;
        b=JVnPKeFR1dQkYOSxhHUHsz+bQytU2sQXJmY1A45OF8Y4C1OY9HagvpQtXYzuh0suvv
         criF3Wmffwqz0IUnl2ITSpb7edKVE1YzcFNB7LPUtRCMyqNksReCJzxflYRfp98xVbgU
         O28FKGVYgw84Lr5MqVRk9phcRFVV5sudPCaGeyP5LObAi9TlxufXGG749QvdCgHGXDMu
         KKauPS7WGWJ8KOgOQamSo7bR72knfuUzyngxpyfpPgWhJmr7FHSI0hH9/fcaqZK17cBI
         tybLEhFl9iW2ShHIgxUdSQe8m4v8zieLL9M3wNMEaaAnme9Wxe5TAvUoBMgMHQqbhA3U
         QEOA==
X-Gm-Message-State: AOJu0YwCP2n6lpUr+t8EuviRacLCPHh8VI6ArsLlU1iueaLh51oJSkP5
	xzKZ9bcTrcOAcT2fZAr0Q91LzabjbVt0MlREgxYT56fo6W4BTG7ck/iH5H2sScUL+CghtaHCcnO
	REyAEQWSKgzE9jFcoKASV7fvVlCiCwsLzBh3riBRpABFkP16f1yedc4Rdce3uK6ccPSHtdZOkgn
	HwExmL0aXh95LsqR66t63wWQ==
X-Google-Smtp-Source: AGHT+IHGNi5XYJQV/AVXXN6jMRiMzyffTc+p/79aZ5+a6YsDIldba6o3PlWiRbaxTRZztZxmNl0knrIA
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:f705:0:b0:343:737f:3f06 with SMTP id
 r5-20020adff705000000b00343737f3f06mr3608wrp.3.1713514319943; Fri, 19 Apr
 2024 01:11:59 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:21 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3016; i=ardb@kernel.org;
 h=from:subject; bh=t/fSlP0S3dDay4IHqTG8uIspZVfaj/zHDbzLQP2cGb0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXdX24UE7kVqWPLN8m6cW4WonD0XfXGO4jjv2488yO
 x03OaOOUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJHOVob/te2Np2WvaPyXT1b/
 0jd5zr6UJcUWTOe0nN/OCr39mvnhLUaGeRKsxgXf2C/lvKhQSGLsjV2wY5bm/5ZpRZNzREwZQqb xAQA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-40-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 15/23] x86/boot: Split off PE/COFF .data section
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 34951f3c28bdf6481d949a20413b2ce7693687b2 upstream ]

Describe the code and data of the decompressor binary using separate
.text and .data PE/COFF sections, so that we will be able to map them
using restricted permissions once we increase the section and file
alignment sufficiently. This avoids the need for memory mappings that
are writable and executable at the same time, which is something that
is best avoided for security reasons.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230915171623.655440-17-ardb@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/Makefile |  2 +-
 arch/x86/boot/header.S | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index b92e00836f69..3c1b3520361c 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -91,7 +91,7 @@ $(obj)/vmlinux.bin: $(obj)/compressed/vmlinux FORCE
 
 SETUP_OBJS = $(addprefix $(obj)/,$(setup-y))
 
-sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_edata\|z_.*\)$$/\#define ZO_\2 0x\1/p'
+sed-zoffset := -e 's/^\([0-9a-fA-F]*\) [a-zA-Z] \(startup_32\|efi.._stub_entry\|efi\(32\)\?_pe_entry\|input_data\|kernel_info\|_end\|_ehead\|_text\|_e\?data\|z_.*\)$$/\#define ZO_\2 0x\1/p'
 
 quiet_cmd_zoffset = ZOFFSET $@
       cmd_zoffset = $(NM) $< | sed -n $(sed-zoffset) > $@
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index a01e55ce506f..178252cdccf5 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -74,9 +74,9 @@ optional_header:
 	.byte	0x02				# MajorLinkerVersion
 	.byte	0x14				# MinorLinkerVersion
 
-	.long	setup_size + ZO__end - 0x200	# SizeOfCode
+	.long	ZO__data			# SizeOfCode
 
-	.long	0				# SizeOfInitializedData
+	.long	ZO__end - ZO__data		# SizeOfInitializedData
 	.long	0				# SizeOfUninitializedData
 
 	.long	setup_size + ZO_efi_pe_entry	# AddressOfEntryPoint
@@ -177,9 +177,9 @@ section_table:
 	.byte	0
 	.byte	0
 	.byte	0
-	.long	ZO__end
+	.long	ZO__data
 	.long	setup_size
-	.long	ZO__edata			# Size of initialized data
+	.long	ZO__data			# Size of initialized data
 						# on disk
 	.long	setup_size
 	.long	0				# PointerToRelocations
@@ -190,6 +190,17 @@ section_table:
 		IMAGE_SCN_MEM_READ		| \
 		IMAGE_SCN_MEM_EXECUTE		# Characteristics
 
+	.ascii	".data\0\0\0"
+	.long	ZO__end - ZO__data		# VirtualSize
+	.long	setup_size + ZO__data		# VirtualAddress
+	.long	ZO__edata - ZO__data		# SizeOfRawData
+	.long	setup_size + ZO__data		# PointerToRawData
+
+	.long	0, 0, 0
+	.long	IMAGE_SCN_CNT_INITIALIZED_DATA	| \
+		IMAGE_SCN_MEM_READ		| \
+		IMAGE_SCN_MEM_WRITE		# Characteristics
+
 	.set	section_count, (. - section_table) / 40
 #endif /* CONFIG_EFI_STUB */
 
-- 
2.44.0.769.g3c40516874-goog


