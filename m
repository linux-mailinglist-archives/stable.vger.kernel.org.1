Return-Path: <stable+bounces-40247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A558AA9D5
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076D3B2224F
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 08:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8D64E1DC;
	Fri, 19 Apr 2024 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9w/bPPa"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D089A41C89
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514313; cv=none; b=srB2fvF/gy6LA22uaykHaMdw5K9ThrKQk6Oo2HPwg07ufsolfZAtgNw22ARaVffhf6nvGwHFKiJ2ZGwbue3IR45665d28Ui2GvLMmMTIRnQOKVWjLYA+6nhptQfn16kgiuIgRgoKUB2L7EpL+gV+ZQtYSZRTZA1oLT9VasBNVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514313; c=relaxed/simple;
	bh=RwDknd+P8q+I6rwwXur+E5/u22609MYFI7OpJlnr8lw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oHJJ6KItaOFGYSRSqnCtiSqiJMBzdbZWGgHQobuSBwP0rQacIShTW5PmtMN3wZ8LzNpF1a6Ef3913eoIlOs8LMaxnbTAvvYfNTWu70z5NqjCC2APdocFg4F6vWThW301Kw6FRWq5W51Z+5I8PgLLp9CnjZvVBTwkrnMSwRxJkL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k9w/bPPa; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61890f3180aso36101227b3.2
        for <stable@vger.kernel.org>; Fri, 19 Apr 2024 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713514311; x=1714119111; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+7+kPsc08L5aVCOAREXBWzq3aI5j6dgafEXL11WJ+kY=;
        b=k9w/bPPayreWxYcW0dVhBpfueIYRV1l2eulyezEfqB0Haj8Zw4K9cs9ooLUwqQzVmS
         XkyMaUxGbVgbv2PGnLZZFXvAqE4HvCKQYMLBmzEAnntQT8d/8jiMCns/2phKbayMNNgJ
         gAM3DrkE3FDp/M/3KJb0qgJ9hSFsLfv9VLldEKf3y9XMNQygndP+5g/r2nBCxecGZexU
         Ux427U3to2gvdRSqLx3l198H8Ge2P9lVtdvRysBk3WN0oRBtBIUXCq7EMqrBfAjCDgg8
         /niA6PaagNHRi0Q/uJhVys/Tqd4azYnk+9s0SZ20H6k/map7p8q2zdgh0sW5cEza5t4/
         307g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514311; x=1714119111;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7+kPsc08L5aVCOAREXBWzq3aI5j6dgafEXL11WJ+kY=;
        b=pHfHXucVqumStUHMLvOGmYf28Wnag+JEp+Hck4OmAy9RDlrKm4WOfczMrb1xKCOJb9
         Ty+Xw4mUSlrJ4GAD0sSSiUuF6iMiotcFLf2lRJCpN0oo1viAFQim1PyLvE/Nm9pKuWyu
         B4VkvbtQsAP5vQQ5gadMEVSFdbRca2oA6ZrZtrs7B52hsmPYqCbgXWNrle10/iZnszX/
         z1edKjQl4xqF1h2j55k0Hpz7g8GKKLBOZqd/W/1vunjU3skrT1eJteW1UO/VU+zEcBPj
         2+u+JZWgB5U02tnqdShTlmN6gW4q4QKdzTjcmE0+R0jw5MmzHUI/4vDPsSeM5bdrw5hJ
         Gr8g==
X-Gm-Message-State: AOJu0YxPKL49gfxntkNbhX+ptthRLRiGTQYBT3Av8T1FTjiJAGspyOjv
	nFa/27evVp7ZB6+5az0ivchwZvyyBcRk0nhhlAmfJ8fMk7m2nGp4bM/lTKXuy6SX9pV9j89RFSN
	UlzmNpNbm47YgWLBiKsWw3d5OgDHJCaEQsZSHvhsE3Me3B5aYr8tpeR7qraOpuzBLJBuKykve4R
	I+EQrFuye/EuXafNoThK1XDw==
X-Google-Smtp-Source: AGHT+IFgh36wwQodS/hQ5+k6jWKD6UM2aBAUruwCYHP8Q1NMhz5MhjK2qWn+/m53FnBh2gFzLGb0FadV
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:c6c5:0:b0:615:19db:8ee0 with SMTP id
 i188-20020a0dc6c5000000b0061519db8ee0mr374362ywd.1.1713514310752; Fri, 19 Apr
 2024 01:11:50 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:11:17 +0200
In-Reply-To: <20240419081105.3817596-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419081105.3817596-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3293; i=ardb@kernel.org;
 h=from:subject; bh=T3JMIxWM73V8HD+PODpNs7fLW+blAyECBQmAsiEjf4Y=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1JXem770M2zb3bzMOVs27M0rz87UZz5H/BmkmMG2JW1
 Wqu+p/VUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbSdZiR4dl1NamVX0JiWMvq
 NGUdL6QW5LEtdvI+u3BfzL+nhX6rtRj+2R+L9j4peNvYcWptnpBC7JSwhdwcJyfIvk1Z3/xi45Y qDgA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419081105.3817596-36-ardb+git@google.com>
Subject: [PATCH for-stable-6.1 11/23] x86/boot: Define setup size in linker script
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit 093ab258e3fb1d1d3afdfd4a69403d44ce90e360 upstream ]

The setup block contains the real mode startup code that is used when
booting from a legacy BIOS, along with the boot_params/setup_data that
is used by legacy x86 bootloaders to pass the command line and initial
ramdisk parameters, among other things.

The setup block also contains the PE/COFF header of the entire combined
image, which includes the compressed kernel image, the decompressor and
the EFI stub.

This PE header describes the layout of the executable image in memory,
and currently, the fact that the setup block precedes it makes it rather
fiddly to get the right values into the right place in the final image.

Let's make things a bit easier by defining the setup_size in the linker
script so it can be referenced from the asm code directly, rather than
having to rely on the build tool to calculate it. For the time being,
add 64 bytes of fixed padding for the .reloc and .compat sections - this
will be removed in a subsequent patch after the PE/COFF header has been
reorganized.

This change has no impact on the resulting bzImage binary when
configured with CONFIG_EFI_MIXED=y.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230915171623.655440-13-ardb@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/header.S      | 2 +-
 arch/x86/boot/setup.ld      | 4 ++++
 arch/x86/boot/tools/build.c | 6 ------
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 34ab46b891e3..6dddf469ca60 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -230,7 +230,7 @@ sentinel:	.byte 0xff, 0xff        /* Used to detect broken loaders */
 
 	.globl	hdr
 hdr:
-setup_sects:	.byte 0			/* Filled in by build.c */
+		.byte setup_sects - 1
 root_flags:	.word ROOT_RDONLY
 syssize:	.long 0			/* Filled in by build.c */
 ram_size:	.word 0			/* Obsolete */
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index b11c45b9e51e..9bd5c1ada599 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -39,6 +39,10 @@ SECTIONS
 	.signature	: {
 		setup_sig = .;
 		LONG(0x5a5aaa55)
+
+		/* Reserve some extra space for the reloc and compat sections */
+		setup_size = ALIGN(ABSOLUTE(.) + 64, 512);
+		setup_sects = ABSOLUTE(setup_size / 512);
 	}
 
 
diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index 069497543164..745d64b6d930 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -48,12 +48,7 @@ typedef unsigned int   u32;
 u8 buf[SETUP_SECT_MAX*512];
 
 #define PECOFF_RELOC_RESERVE 0x20
-
-#ifdef CONFIG_EFI_MIXED
 #define PECOFF_COMPAT_RESERVE 0x20
-#else
-#define PECOFF_COMPAT_RESERVE 0x0
-#endif
 
 static unsigned long efi_pe_entry;
 static unsigned long efi32_pe_entry;
@@ -388,7 +383,6 @@ int main(int argc, char ** argv)
 #endif
 
 	/* Patch the setup code with the appropriate size parameters */
-	buf[0x1f1] = setup_sectors-1;
 	put_unaligned_le32(sys_size, &buf[0x1f4]);
 
 	update_pecoff_text(setup_sectors * 512, i + (sys_size * 16));
-- 
2.44.0.769.g3c40516874-goog


