Return-Path: <stable+bounces-172663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FBFB32C4D
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 00:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24CA67AB12D
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 22:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62632459C6;
	Sat, 23 Aug 2025 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW5gCCJT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4E214A62B;
	Sat, 23 Aug 2025 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755987952; cv=none; b=fH+NuSulinSmr1WH9bPRmB+dmXCIXTagCh6TQI5WFceFbt+uBtldWYuwi39zSbvmuzBRvsAwttNU5jVPHqe6IdHnhOvTLyGrrRelpq4bmnxz/Kg+cMSh5Fsgl7nhFi/6ifQLkbub5R6xHNhuTXT0Ru6P+VJhYvkIqzx2+BqYe5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755987952; c=relaxed/simple;
	bh=o4tfWUnrvWW45XkZjNc1uODnZaubDv7GA3aKCYWJF4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QH2Fu0XPv3arwqon2aEW42sBXn3KbDrt9Q9IVkRqwy7zDW7iLqTdOQGiAxh4GUoQaHFn1TA8ECBY/Ei89rx5p6F1jSivg01Rqzn9tRJ8z9QmZP3kJeg1tlNc1I/53QSLnvM75fCuMdj/x0xVErzwS4QLpL+BlHv58tdPouxVqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW5gCCJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006EEC4CEE7;
	Sat, 23 Aug 2025 22:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755987952;
	bh=o4tfWUnrvWW45XkZjNc1uODnZaubDv7GA3aKCYWJF4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EW5gCCJTK7w2G0x+G3zywZXedzHj9/qQI1rjhYF+wvNvopXKT7P6FrAkAuFi8cKmj
	 I8lTL32lfQ1nqgO2elnEwFep+tvlWkgW9UKFfD4dS9yXpxgdG1G8jVF0JZI3girzc2
	 MeIT2aesP36eC+S/Z1eSvm1YW7ebomNsH4l71ZUldiy+VOABv4pjqsr/A5zJYwI5HS
	 XJlIgElipnkM9PuxuJlRJNNKwJl34n6/PwfEDiorLfkAUbxNJvt7UJawH3gCyEDzr9
	 TAQA6OlARepjOpflztscbknBTiySWrM7ZSlzOxgyzp5GwK5xLmJz3RB9eyNW1sUBbC
	 fa0AsZsHGo/Aw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55ce5243f6dso3627339e87.2;
        Sat, 23 Aug 2025 15:25:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOT7VFp2kLNx7uQbkTXHkWdmBra6DKqp4Mm+20063vkJJSGbtWhBTbSKpY9hXWiK3WJg3x1/6qUQuH5Q0=@vger.kernel.org, AJvYcCWRpISuHyeuAG5KT0Wc6gZYFmQCUXH1hPGmf7YcjWCv09reNkiu77R8UEnK8v4SCNVTIGvM5MhD@vger.kernel.org
X-Gm-Message-State: AOJu0YwI+OYKilHuOflZE5jVZdjSBDi1PXJvewo8zdgjVAUwkQdL4QvZ
	/eYAuVjNp5+XRx7J8SuqPho23bElij/laUSSV5qYp5VmCnEibDu+Lg9PiJnNL4bnD59BT1bd3yZ
	NpEcAEultC8lIJHy2KI4jUh1+ZEWhwBU=
X-Google-Smtp-Source: AGHT+IEAJZ5I9jytEZddwlocNfvIS6Y8INNTtScihMjxLZcdUP+pDu2NWjNEprTyR8UYHe48zmc40UAAKEbPmo50WKc=
X-Received: by 2002:a05:6512:6284:b0:55a:5122:91ea with SMTP id
 2adb3069b0e04-55f0ccce7e5mr2161677e87.34.1755987950359; Sat, 23 Aug 2025
 15:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822041526.467434-1-CFSworks@gmail.com>
In-Reply-To: <20250822041526.467434-1-CFSworks@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 24 Aug 2025 08:25:39 +1000
X-Gmail-Original-Message-ID: <CAMj1kXH38gOUpDDdarCXPAY3BHBbuFzdD=Dq7Knsg-qHJoNqzQ@mail.gmail.com>
X-Gm-Features: Ac12FXx4h-esqmUyLXFQpc9yLkNC9WcNoc6ief3rZx4PjW95nKGNarPk-LBLvw8
Message-ID: <CAMj1kXH38gOUpDDdarCXPAY3BHBbuFzdD=Dq7Knsg-qHJoNqzQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/boot: Zero-initialize idmap PGDs before use
To: Sam Edwards <cfsworks@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baruch Siach <baruch@tkos.co.il>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sam,

On Fri, 22 Aug 2025 at 14:15, Sam Edwards <cfsworks@gmail.com> wrote:
>
> In early boot, Linux creates identity virtual->physical address mappings
> so that it can enable the MMU before full memory management is ready.
> To ensure some available physical memory to back these structures,
> vmlinux.lds reserves some space (and defines marker symbols) in the
> middle of the kernel image. However, because they are defined outside of
> PROGBITS sections, they aren't pre-initialized -- at least as far as ELF
> is concerned.
>
> In the typical case, this isn't actually a problem: the boot image is
> prepared with objcopy, which zero-fills the gaps, so these structures
> are incidentally zero-initialized (an all-zeroes entry is considered
> absent, so zero-initialization is appropriate).
>
> However, that is just a happy accident: the `vmlinux` ELF output
> authoritatively represents the state of memory at entry. If the ELF
> says a region of memory isn't initialized, we must treat it as
> uninitialized. Indeed, certain bootloaders (e.g. Broadcom CFE) ingest
> the ELF directly -- sidestepping the objcopy-produced image entirely --
> and therefore do not initialize the gaps. This results in the early boot
> code crashing when it attempts to create identity mappings.
>
> Therefore, add boot-time zero-initialization for the following:
> - __pi_init_idmap_pg_dir..__pi_init_idmap_pg_end
> - idmap_pg_dir
> - reserved_pg_dir

I don't think this is the right approach.

If the ELF representation is inaccurate, it should be fixed, and this
should be achievable without impacting the binary image at all.

> - tramp_pg_dir # Already done, but this patch corrects the size
>

What is wrong with the size?

> Note, swapper_pg_dir is already initialized (by copy from idmap_pg_dir)
> before use, so this patch does not need to address it.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  arch/arm64/kernel/head.S | 12 ++++++++++++
>  arch/arm64/mm/mmu.c      |  3 ++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index ca04b338cb0d..0c3be11d0006 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -86,6 +86,18 @@ SYM_CODE_START(primary_entry)
>         bl      record_mmu_state
>         bl      preserve_boot_args
>
> +       adrp    x0, reserved_pg_dir
> +       add     x1, x0, #PAGE_SIZE
> +0:     str     xzr, [x0], 8
> +       cmp     x0, x1
> +       b.lo    0b
> +
> +       adrp    x0, __pi_init_idmap_pg_dir
> +       adrp    x1, __pi_init_idmap_pg_end
> +1:     str     xzr, [x0], 8
> +       cmp     x0, x1
> +       b.lo    1b
> +
>         adrp    x1, early_init_stack
>         mov     sp, x1
>         mov     x29, xzr
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 34e5d78af076..aaf823565a65 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -761,7 +761,7 @@ static int __init map_entry_trampoline(void)
>         pgprot_val(prot) &= ~PTE_NG;
>
>         /* Map only the text into the trampoline page table */
> -       memset(tramp_pg_dir, 0, PGD_SIZE);
> +       memset(tramp_pg_dir, 0, PAGE_SIZE);
>         __create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS,
>                              entry_tramp_text_size(), prot,
>                              pgd_pgtable_alloc_init_mm, NO_BLOCK_MAPPINGS);
> @@ -806,6 +806,7 @@ static void __init create_idmap(void)
>         u64 end   = __pa_symbol(__idmap_text_end);
>         u64 ptep  = __pa_symbol(idmap_ptes);
>
> +       memset(idmap_pg_dir, 0, PAGE_SIZE);
>         __pi_map_range(&ptep, start, end, start, PAGE_KERNEL_ROX,
>                        IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
>                        __phys_to_virt(ptep) - ptep);
> --
> 2.49.1
>

