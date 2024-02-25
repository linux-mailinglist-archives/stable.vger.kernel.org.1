Return-Path: <stable+bounces-23586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DC18629E8
	for <lists+stable@lfdr.de>; Sun, 25 Feb 2024 11:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D487B1C208C8
	for <lists+stable@lfdr.de>; Sun, 25 Feb 2024 10:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152BCDDCA;
	Sun, 25 Feb 2024 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV+UwGkX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02C4D528
	for <stable@vger.kernel.org>; Sun, 25 Feb 2024 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708855384; cv=none; b=KEeEX7YU25nR2S7uFauNWqOKlZCOxGM6bgIOptAMO3sIcJxN3QKsKOApfw6UUlUJjY/3V/7mZLCe/GGDAaplipYo+zxldeL9/a3WS296lJEMXoP1SCEAXy0qqnn4SBP0xAT2cS7ym0Kp/Lj62jCUVXKeQc8ac2DRDbC068Cpcq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708855384; c=relaxed/simple;
	bh=0HiEztjG/PKrWjhSVIeWAu4UPeQ2blKov0r/oWfcFIU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WN476G/ZaNBfGDov6B7L2zDae+fShwPpaLQmR4KcAUWKZ48/1Cy/QH3XPuBZwZxZUOiY3NFa+J4o87hBGl2GJrSoV5ZnKftKdop27/UAUdcXq+LjmaaneWu66dx6DsO+oU9+6V6NNrL0eUSPKS8o07d3EfxviMLGfzNm1pR7ZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lV+UwGkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338EDC43390
	for <stable@vger.kernel.org>; Sun, 25 Feb 2024 10:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708855384;
	bh=0HiEztjG/PKrWjhSVIeWAu4UPeQ2blKov0r/oWfcFIU=;
	h=From:Date:Subject:To:From;
	b=lV+UwGkXS4IWmT3MYFGynBsCORqyR8D9v8NEYaoXbyJoTPUkO24e1XRZkn1h4wiO9
	 Ob6sT8qp67F4wig1BKhXUyNF2+2cEY3yj+db8WPujRUwiAWDLe+8aL5FSK8777/M3o
	 awEmW9r/z8WZB1MccIPP9yW1hOPnWI1UJ13/5h+7pehjNRSd/EywbivBhebCASydum
	 X8t3NPJ18Vo4P7sGzeo30KfqquTf1+ctbpinU9u/nYeu2352wyYlUoU9X9jxVfGlKH
	 3i9yWPfsQ/Z6bR9jsUeFVqHExEob3AnGOzVILqcH14TXJ8nY302fhlT9Ekwvk/9O95
	 4f1JfApJ3wpNw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so21822691fa.3
        for <stable@vger.kernel.org>; Sun, 25 Feb 2024 02:03:04 -0800 (PST)
X-Gm-Message-State: AOJu0Yx0gpYKMykHZI2XyU+iYnoc72au9o8P4Rcg3wijLspaIBxJFmLD
	uPT60Ja7SBR5T3HyYLUE0t2lQlDJMva+4ByGusrozl+Jo/bo+iBxYHb28r8NHJ1DLWSVZ3a3GSU
	p1hz79qe65fIUTWAF69OMiITUDcI=
X-Google-Smtp-Source: AGHT+IFvPaG+mDdY2T1nCyLxRFLw8fgVjCu+WDs+/nRxM+fTYWuwInawuvOQLNkncUSV79vY7p6VYNp8hXNiVsls714=
X-Received: by 2002:a2e:a0c3:0:b0:2d2:5c4a:f764 with SMTP id
 f3-20020a2ea0c3000000b002d25c4af764mr2229716ljm.46.1708855381782; Sun, 25 Feb
 2024 02:03:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 25 Feb 2024 11:02:50 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE5y+6Fef1SqsePO1p8eGEL_qKR9ZkNPNKb-y6P8-7YmQ@mail.gmail.com>
Message-ID: <CAMj1kXE5y+6Fef1SqsePO1p8eGEL_qKR9ZkNPNKb-y6P8-7YmQ@mail.gmail.com>
Subject: EFI/x86 backports for v6.1
To: "# 3.4.x" <stable@vger.kernel.org>, Dimitri John Ledkov <xnox@ubuntu.com>, jan.setjeeilers@oracle.com
Content-Type: text/plain; charset="UTF-8"

Please consider the patches below for backporting to v6.1. They should
all apply cleanly in the given order.

These are prerequisites for NX compat support on x86, but the
remaining changes do not apply cleanly and will be sent as a patch
series at a later date.
By themselves, these changes not only constitute a reasonable cleanup,
they are also needed for future support of x86s [0] CPUs that are no
longer able to transition out of long mode.

 Documentation/x86/boot.rst                 |   2 +-
 arch/x86/Kconfig                           |  17 +
 arch/x86/boot/compressed/Makefile          |   8 +-
 arch/x86/boot/compressed/efi_mixed.S       | 383 +++++++++++++++++++
 arch/x86/boot/compressed/efi_thunk_64.S    | 195 ----------
 arch/x86/boot/compressed/head_32.S         |  25 +-
 arch/x86/boot/compressed/head_64.S         | 566 ++++++-----------------------
 arch/x86/boot/compressed/mem_encrypt.S     | 152 +++++++-
 arch/x86/boot/compressed/misc.c            |  34 +-
 arch/x86/boot/compressed/misc.h            |   2 -
 arch/x86/boot/compressed/pgtable.h         |  10 +-
 arch/x86/boot/compressed/pgtable_64.c      |  87 ++---
 arch/x86/boot/header.S                     |   2 +-
 arch/x86/boot/tools/build.c                |   2 +
 drivers/firmware/efi/efi.c                 |  22 ++
 drivers/firmware/efi/libstub/alignedmem.c  |   5 +-
 drivers/firmware/efi/libstub/arm64-stub.c  |   6 +-
 drivers/firmware/efi/libstub/efistub.h     |   6 +-
 drivers/firmware/efi/libstub/mem.c         |   3 +-
 drivers/firmware/efi/libstub/randomalloc.c |   5 +-
 drivers/firmware/efi/libstub/x86-stub.c    |  53 ++-
 drivers/firmware/efi/vars.c                |  13 +-
 include/linux/decompress/mm.h              |   2 +-
 23 files changed, 805 insertions(+), 795 deletions(-)

[0] https://www.intel.com/content/www/us/en/developer/articles/technical/envisioning-future-simplified-architecture.html


9cf42bca30e9 efi: libstub: use EFI_LOADER_CODE region when moving the
kernel in memory
cb8bda8ad443 x86/boot/compressed: Rename efi_thunk_64.S to efi-mixed.S
e2ab9eab324c x86/boot/compressed: Move 32-bit entrypoint code into .text section
5c3a85f35b58 x86/boot/compressed: Move bootargs parsing out of 32-bit
startup code
91592b5c0c2f x86/boot/compressed: Move efi32_pe_entry into .text section
73a6dec80e2a x86/boot/compressed: Move efi32_entry out of head_64.S
7f22ca396778 x86/boot/compressed: Move efi32_pe_entry() out of head_64.S
4b52016247ae x86/boot/compressed, efi: Merge multiple definitions of
image_offset into one
630f337f0c4f x86/boot/compressed: Simplify IDT/GDT preserve/restore in
the EFI thunk
6aac80a8da46 x86/boot/compressed: Avoid touching ECX in
startup32_set_idt_entry()
d73a257f7f86 x86/boot/compressed: Pull global variable reference into
startup32_load_idt()
c6355995ba47 x86/boot/compressed: Move startup32_load_idt() into .text section
9ea813be3d34 x86/boot/compressed: Move startup32_load_idt() out of head_64.S
b5d854cd4b6a x86/boot/compressed: Move startup32_check_sev_cbit() into .text
9d7eaae6a071 x86/boot/compressed: Move startup32_check_sev_cbit() out
of head_64.S
30c9ca16a527 x86/boot/compressed: Adhere to calling convention in
get_sev_encryption_bit()
61de13df9590 x86/boot/compressed: Only build mem_encrypt.S if AMD_MEM_ENCRYPT=y
bad267f9e18f efi: verify that variable services are supported
0217a40d7ba6 efi: efivars: prevent double registration
cc3fdda2876e x86/efi: Make the deprecated EFI handover protocol optional
7734a0f31e99 x86/boot: Robustify calling startup_{32,64}() from the
decompressor code
d2d7a54f69b6 x86/efistub: Branch straight to kernel entry point from C code
df9215f15206 x86/efistub: Simplify and clean up handover entry code
127920645876 x86/decompressor: Avoid magic offsets for EFI handover entrypoint
d7156b986d4c x86/efistub: Clear BSS in EFI handover protocol entrypoint
8b63cba746f8 x86/decompressor: Store boot_params pointer in callee save register
00c6b0978ec1 x86/decompressor: Assign paging related global variables earlier
e8972a76aa90 x86/decompressor: Call trampoline as a normal function
918a7a04e717 x86/decompressor: Use standard calling convention for trampoline
bd328aa01ff7 x86/decompressor: Avoid the need for a stack in the
32-bit trampoline
64ef578b6b68 x86/decompressor: Call trampoline directly from C code
f97b67a773cd x86/decompressor: Only call the trampoline when changing
paging levels
cb83cece57e1 x86/decompressor: Pass pgtable address to trampoline directly
03dda95137d3 x86/decompressor: Merge trampoline cleanup with switching code
24388292e2d7 x86/decompressor: Move global symbol references to C code
8217ad0a435f decompress: Use 8 byte alignment

