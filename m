Return-Path: <stable+bounces-83519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8E399B371
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E19283B2E
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18CF188918;
	Sat, 12 Oct 2024 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e36xhZIh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0D187330;
	Sat, 12 Oct 2024 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732391; cv=none; b=lBz9PhpkymdVvq/D9XadkFPIbm/jTSuLMJ4LYPT6gTe6f4Jmn9p7a0IvtVRdky2+7tgoktMMnfqNi9+MDSGAJh2Iom82GC/oPCK05Q3em2MLKzv97LwXUz1Gfdrts/h4P+IHpWup59vorX6GJH6sfUSbHymZyVbJAc69wx7ukcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732391; c=relaxed/simple;
	bh=lrRuZmbItQXT9jpY1mp53Ktvwuv/GGccoxSxctyMX64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQFv28qEiGwoz8rODZM6x0F1Apx89qIh8F6va/7zSBvrvqKggfPfEbvmBFZ7isu3N+wNTXFwuVA11uoOlBMUzTldKfnWymLUcXqEz9m7FKuQEmanaspxXk1tnnXDMUgDTraFYmaPdDVlA7qz+7soeILGDGGjyebOL00JlX8swww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e36xhZIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB39CC4CED0;
	Sat, 12 Oct 2024 11:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732391;
	bh=lrRuZmbItQXT9jpY1mp53Ktvwuv/GGccoxSxctyMX64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e36xhZIh0dMrcA2gnP+YAY/TcgS0Febfx/mSPZMQYxUtIoGiTjUVycM5s0eM62t0C
	 /+lguaplyRv5tMldPSYAxQECQZNv6UrPMHLwqBNeKY797ERc2JM+h01h3B24QXdenG
	 fKeevxR8772oft+tVamobMxOKK0q4P4OJiuTcKzMFDyDSwzcTOyqkSLBRWIEVwRls5
	 WmdoPhL66Wi2k0zPI4Vsxu/Os3koJ0KGs5aGC9r0KzZ7OnPs5rnjDpyAktKvtjKqZ6
	 363gnlTU47Pyc9ZzsZZsw/IZdCkzMy0cDomzg+1fZy008tePfecXIUU/A+sQuPHgOm
	 XkCubVmOnLWTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 05/16] arm64: Force position-independent veneers
Date: Sat, 12 Oct 2024 07:26:01 -0400
Message-ID: <20241012112619.1762860-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112619.1762860-1-sashal@kernel.org>
References: <20241012112619.1762860-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 9abe390e689f4f5c23c5f507754f8678431b4f72 ]

Certain portions of code always need to be position-independent
regardless of CONFIG_RELOCATABLE, including code which is executed in an
idmap or which is executed before relocations are applied. In some
kernel configurations the LLD linker generates position-dependent
veneers for such code, and when executed these result in early boot-time
failures.

Marc Zyngier encountered a boot failure resulting from this when
building a (particularly cursed) configuration with LLVM, as he reported
to the list:

  https://lore.kernel.org/linux-arm-kernel/86wmjwvatn.wl-maz@kernel.org/

In Marc's kernel configuration, the .head.text and .rodata.text sections
end up more than 128MiB apart, requiring a veneer to branch between the
two:

| [mark@lakrids:~/src/linux]% usekorg 14.1.0 aarch64-linux-objdump -t vmlinux | grep -w _text
| ffff800080000000 g       .head.text     0000000000000000 _text
| [mark@lakrids:~/src/linux]% usekorg 14.1.0 aarch64-linux-objdump -t vmlinux | grep -w primary_entry
| ffff8000889df0e0 g       .rodata.text   000000000000006c primary_entry,

... consequently, LLD inserts a position-dependent veneer for the branch
from _stext (in .head.text) to primary_entry (in .rodata.text):

| ffff800080000000 <_text>:
| ffff800080000000:       fa405a4d        ccmp    x18, #0x0, #0xd, pl     // pl = nfrst
| ffff800080000004:       14003fff        b       ffff800080010000 <__AArch64AbsLongThunk_primary_entry>
...
| ffff800080010000 <__AArch64AbsLongThunk_primary_entry>:
| ffff800080010000:       58000050        ldr     x16, ffff800080010008 <__AArch64AbsLongThunk_primary_entry+0x8>
| ffff800080010004:       d61f0200        br      x16
| ffff800080010008:       889df0e0        .word   0x889df0e0
| ffff80008001000c:       ffff8000        .word   0xffff8000

... and as this is executed early in boot before the kernel is mapped in
TTBR1 this results in a silent boot failure.

Fix this by passing '--pic-veneer' to the linker, which will cause the
linker to use position-independent veneers, e.g.

| ffff800080000000 <_text>:
| ffff800080000000:       fa405a4d        ccmp    x18, #0x0, #0xd, pl     // pl = nfrst
| ffff800080000004:       14003fff        b       ffff800080010000 <__AArch64ADRPThunk_primary_entry>
...
| ffff800080010000 <__AArch64ADRPThunk_primary_entry>:
| ffff800080010000:       f004e3f0        adrp    x16, ffff800089c8f000 <__idmap_text_start>
| ffff800080010004:       91038210        add     x16, x16, #0xe0
| ffff800080010008:       d61f0200        br      x16

I've opted to pass '--pic-veneer' unconditionally, as:

* In addition to solving the boot failure, these sequences are generally
  nicer as they require fewer instructions and don't need to perform
  data accesses.

* While the position-independent veneer sequences have a limited +/-2GiB
  range, this is not a new restriction. Even kernels built with
  CONFIG_RELOCATABLE=n are limited to 2GiB in size as we have several
  structues using 32-bit relative offsets and PPREL32 relocations, which
  are similarly limited to +/-2GiB in range. These include extable
  entries, jump table entries, and alt_instr entries.

* GNU LD defaults to using position-independent veneers, and supports
  the same '--pic-veneer' option, so this change is not expected to
  adversely affect GNU LD.

I've tested with GNU LD 2.30 to 2.42 inclusive and LLVM 13.0.1 to 19.1.0
inclusive, using the kernel.org binaries from:

* https://mirrors.edge.kernel.org/pub/tools/crosstool/
* https://mirrors.edge.kernel.org/pub/tools/llvm/

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Marc Zyngier <maz@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Will Deacon <will@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20240927101838.3061054-1-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index f6bc3da1ef110..c8e237b20ef29 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -10,7 +10,7 @@
 #
 # Copyright (C) 1995-2001 by Russell King
 
-LDFLAGS_vmlinux	:=--no-undefined -X
+LDFLAGS_vmlinux	:=--no-undefined -X --pic-veneer
 
 ifeq ($(CONFIG_RELOCATABLE), y)
 # Pass --no-apply-dynamic-relocs to restore pre-binutils-2.27 behaviour
-- 
2.43.0


