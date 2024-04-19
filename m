Return-Path: <stable+bounces-40253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6859B8AA9DB
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205392819E1
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90AE3A1A8;
	Fri, 19 Apr 2024 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3d01MG29"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246323E485
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514327; cv=none; b=TU9NiPzya0pUsGz0UpMbInYyLUCPOe1ulWM6aYaUHHn6g+8YoScZBczSRogNN7ZYExOStyg3Ab+8QYDK8yS3mtjb260dianYWKPozbEIOH5vPdp/oKZUDx0w7iI4e/Exwdqwq9J4xEgQsjLZ2ZbazR9gGWIXJi26I2d/Kkk5J4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514327; c=relaxed/simple;
	bh=ysuBfdRe2VWDsPp59zZ/XiF5d9oRnPEtaLv0wJrQU5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=S9g/47zcSp+N6dd8sc7XwXpXxMWatiEblFs/HtZnH6/9yqQz3cfliBE2SMqAsuEYCxLDwL9x4/4hQhBWl9nZk20i52Ok4O21DcT0gtfXnjRajb42aSHVhdJU0vkduhwuEBlJ91c71Evdjm9lIuhpj7c1jQCW1aG1PRpyOgQb44I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3d01MG29; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-41485831b2dso14554125e9.3
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514324; x=1714119124; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00mSUDgwbYRMFQ7OUGGLzLPK/wBtuepMkY48P4qQl5U=;
        b=3d01MG294nOJLVvC0GND3biygnmwuwhFGcxy5VQpN7ULU5FYdyx3tRRb5e4OwYYM8t
         kEhCbn4w+e3cgXptJ6d8wN9JcY28s463QR20MvCp8kOwuLodRxjkPeN5VSjuHMURTlKZ
         lUfui4Osog70pu8RepheMmnl4qEpI1D4RXB64LGyYE7FJLcKjznCaS9CcrS96BUotsAa
         bpzHUcBCPcBXfbARbdNI8fjYsJdhTtWEs6vJvXdzCUOoLkQ+s3JujQhJvcyjoBDTy+mA
         i8uQhaTcT0ItGTFGhx5VazgcMVuz6+ZBh1LRPB9J3Snm0oOD+OKSGnegYkDfnFHHHj0t
         NT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514324; x=1714119124;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00mSUDgwbYRMFQ7OUGGLzLPK/wBtuepMkY48P4qQl5U=;
        b=iR7rcktyatbg5bJxhqxgr2TET8fbfxoUM6WK3Gs2mEvt1xbx2NEvfCEiCgHnBgZ5ID
         K61mOQo+4e0e6o1HhDHFNp3qj0E+k+8GssTP0AmabtM+A+DKah1bgvx2XYroJTIORzew
         vRREHvJXcbTtYoJpF7CV+4A9QxRkzJZga2TjyhgrMscdWMMva7q0lF5NB/1k2bs6CRIg
         2JWOKyd8lqoPYKwBMvJ25DhDzwpgP58mDpE+KaNqjRHumS/B+9lMfuJl/h43Ody65hJh
         Kud/s6PwbzLx8xoqtUNokCEK9Ov71+XXgrwQTPToqmc4vah0nLONGc63WE1fl1ENl/YV
         RP0A==
X-Gm-Message-State: AOJu0Yy8Grwb5cGD4VoVFjz3KjMm2/TfHnQrqOFwUkEmk/iKx8fjZ09k
	HafMA45+RUTKMaUw8kJgyvbCm/hDwsoH4tX/3v+da7jkM0yZVMQSxQ1Yzyp7slfBTBBq0A53/3/
	cOgg/f9q7i1FHjPWdAQjA7o7+ldx60FJhkSXkc2+ZmKkTRfYQzTvy96BB1y70zljtt71q994SgJ
	/kDCsqoPf0VkdCNIcwxVEt4Q==
X-Google-Smtp-Source: AGHT+IFAv08bFDgSI8YWxC4DzYT5IgSgRMAv1S/6jmTnHkZotr9tcC69hWXihmSeGcG362Zajq272ES1
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3b09:b0:418:7f33:7a35 with SMTP id
 m9-20020a05600c3b0900b004187f337a35mr9314wms.4.1713514324750; Fri, 19 Apr
 2024 01:12:04 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:23 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3796; i=ardb@kernel.org;
 h=from:subject; bh=LbBFI85i6wC/0EzgPgicuvJHqIQyg0Gv+BLhdOZZCQU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXV2wTrPhU5mqYB3fo5NpFfq9u34enVOwfPfeFWbaQ
 g8P80zrKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNxu8TwP6X76pykXPMd7VI3
 83raIvnrHnu2hFfqtnAvnmze3Cg6l5Hh2tFn35MtFdUPKmSvF/nn/khdjPG9xrf/807krf3bzOD KAwA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-42-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 17/23] x86/efistub: Use 1:1 file:memory mapping
 for PE/COFF .compat section
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 1ad55cecf22f05f1c884adf63cc09d3c3e609ebf upstream ]

The .compat section is a dummy PE section that contains the address of
the 32-bit entrypoint of the 64-bit kernel image if it is bootable from
32-bit firmware (i.e., CONFIG_EFI_MIXED=y)

This section is only 8 bytes in size and is only referenced from the
loader, and so it is placed at the end of the memory view of the image,
to avoid the need for padding it to 4k, which is required for sections
appearing in the middle of the image.

Unfortunately, this violates the PE/COFF spec, and even if most EFI
loaders will work correctly (including the Tianocore reference
implementation), PE loaders do exist that reject such images, on the
basis that both the file and memory views of the file contents should be
described by the section headers in a monotonically increasing manner
without leaving any gaps.

So reorganize the sections to avoid this issue. This results in a slight
padding overhead (< 4k) which can be avoided if desired by disabling
CONFIG_EFI_MIXED (which is only needed in rare cases these days)

Fixes: 3e3eabe26dc8 ("x86/boot: Increase section and file alignment to 4k/512")
Reported-by: Mike Beaton <mjsbeaton@gmail.com>
Link: https://lkml.kernel.org/r/CAHzAAWQ6srV6LVNdmfbJhOwhBw5ZzxxZZ07aHt9oKkfYAdvuQQ%40mail.gmail.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S | 14 ++++++--------
 arch/x86/boot/setup.ld |  6 +++---
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 6264bbf54fbc..7593339b529a 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -105,8 +105,7 @@ extra_header_fields:
 	.word	0				# MinorSubsystemVersion
 	.long	0				# Win32VersionValue
 
-	.long	setup_size + ZO__end + pecompat_vsize
-						# SizeOfImage
+	.long	setup_size + ZO__end		# SizeOfImage
 
 	.long	salign				# SizeOfHeaders
 	.long	0				# CheckSum
@@ -142,7 +141,7 @@ section_table:
 	.ascii	".setup"
 	.byte	0
 	.byte	0
-	.long	setup_size - salign 		# VirtualSize
+	.long	pecompat_fstart - salign 	# VirtualSize
 	.long	salign				# VirtualAddress
 	.long	pecompat_fstart - salign	# SizeOfRawData
 	.long	salign				# PointerToRawData
@@ -155,8 +154,8 @@ section_table:
 #ifdef CONFIG_EFI_MIXED
 	.asciz	".compat"
 
-	.long	8				# VirtualSize
-	.long	setup_size + ZO__end		# VirtualAddress
+	.long	pecompat_fsize			# VirtualSize
+	.long	pecompat_fstart			# VirtualAddress
 	.long	pecompat_fsize			# SizeOfRawData
 	.long	pecompat_fstart			# PointerToRawData
 
@@ -171,17 +170,16 @@ section_table:
 	 * modes this image supports.
 	 */
 	.pushsection ".pecompat", "a", @progbits
-	.balign	falign
-	.set	pecompat_vsize, salign
+	.balign	salign
 	.globl	pecompat_fstart
 pecompat_fstart:
 	.byte	0x1				# Version
 	.byte	8				# Size
 	.word	IMAGE_FILE_MACHINE_I386		# PE machine type
 	.long	setup_size + ZO_efi32_pe_entry	# Entrypoint
+	.byte	0x0				# Sentinel
 	.popsection
 #else
-	.set	pecompat_vsize, 0
 	.set	pecompat_fstart, setup_size
 #endif
 	.ascii	".text"
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 83bb7efad8ae..3a2d1360abb0 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -24,6 +24,9 @@ SECTIONS
 	.text		: { *(.text .text.*) }
 	.text32		: { *(.text32) }
 
+	.pecompat	: { *(.pecompat) }
+	PROVIDE(pecompat_fsize = setup_size - pecompat_fstart);
+
 	. = ALIGN(16);
 	.rodata		: { *(.rodata*) }
 
@@ -36,9 +39,6 @@ SECTIONS
 	. = ALIGN(16);
 	.data		: { *(.data*) }
 
-	.pecompat	: { *(.pecompat) }
-	PROVIDE(pecompat_fsize = setup_size - pecompat_fstart);
-
 	.signature	: {
 		setup_sig = .;
 		LONG(0x5a5aaa55)
-- 
2.44.0.769.g3c40516874-goog


