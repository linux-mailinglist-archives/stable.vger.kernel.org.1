Return-Path: <stable+bounces-180736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E61E8B8D26C
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 01:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6C13B36B2
	for <lists+stable@lfdr.de>; Sat, 20 Sep 2025 23:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53A626D4DA;
	Sat, 20 Sep 2025 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AV4xIGi8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D701CAA92;
	Sat, 20 Sep 2025 23:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758412122; cv=none; b=vFQnIAQ/CLWHLy4xN84ulef0W9/qriFbCipsqRdQns26qAaFJmlzRwI8oNOq2o2w/16QhU3Kgp7n+dIMHuFjjY9z4p+Pa0vczjeJQxoljbNP8tozfc+aDf1Buqz+svy/BQMSOya/w59gnc+hEidorThEn7zaYEgLVRzreQLyD4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758412122; c=relaxed/simple;
	bh=QIxkoqGx1iUDk/Kd3gvhLnK7lvE5vZWy6iG9qboqNBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBbUJNjJnEd0DC52ppwJB3i44bbB6KyxwAbhj/E7S6MWCHlOX9/nxBZ7GibIwmNVh65tg37/362AZqLZyGwNvE9hK9IMAWkfADVv1J3uWcx82I8B8GF6Gc9LtBxmdwsMs7t485QlZnC0iiSHUsGFa4o76o9YGhDL9V36OByaSvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AV4xIGi8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7333C4CEEB;
	Sat, 20 Sep 2025 23:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758412121;
	bh=QIxkoqGx1iUDk/Kd3gvhLnK7lvE5vZWy6iG9qboqNBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AV4xIGi8APouzirRimK7yffgO7siT/0UcuPPSj4PVrnZZDid+0mxGhctenFvGnu72
	 j0LVloGhnaE5cuxrm6jgfsJ37iJkdxNOyPqCdjy3rRdTyigsNfT3Ly4YpeZwaXTsCe
	 r0umDP3Zit7m8A8izCHed2+917rc7aV9AtMbwmQXR6FapM9mBEU5uYp+S/PsL9tq/Z
	 iCDNOhqU1mjByfdxg7PozjHbWN+elCTRt5bzyMyGFaXtIx4Brn3m5V4xrC+K/N2BHH
	 9MG2CO9FPTI/PB6HB6KjLG7g6JXDCEDQSlGWxOabG94uswsDnaAf4cwu7IQwKwytKo
	 eseEURPsECPvw==
Date: Sat, 20 Sep 2025 16:48:36 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH V2] LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN
 enabled
Message-ID: <20250920234836.GA3857420@ax162>
References: <20250910091033.725716-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910091033.725716-1-chenhuacai@loongson.cn>

Hi Huacai,

On Wed, Sep 10, 2025 at 05:10:33PM +0800, Huacai Chen wrote:
> ARCH_STRICT_ALIGN is used for hardware without UAL, now it only control
> the -mstrict-align flag. However, ACPI structures are packed by default
> so will cause unaligned accesses.
> 
> To avoid this, define ACPI_MISALIGNMENT_NOT_SUPPORTED in asm/acenv.h to
> align ACPI structures if ARCH_STRICT_ALIGN enabled.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Suggested-by: Xi Ruoyao <xry111@xry111.site>
> Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Modify asm/acenv.h instead of Makefile.
> 
>  arch/loongarch/include/asm/acenv.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/acenv.h b/arch/loongarch/include/asm/acenv.h
> index 52f298f7293b..483c955f2ae5 100644
> --- a/arch/loongarch/include/asm/acenv.h
> +++ b/arch/loongarch/include/asm/acenv.h
> @@ -10,9 +10,8 @@
>  #ifndef _ASM_LOONGARCH_ACENV_H
>  #define _ASM_LOONGARCH_ACENV_H
>  
> -/*
> - * This header is required by ACPI core, but we have nothing to fill in
> - * right now. Will be updated later when needed.
> - */
> +#ifdef CONFIG_ARCH_STRICT_ALIGN
> +#define ACPI_MISALIGNMENT_NOT_SUPPORTED
> +#endif /* CONFIG_ARCH_STRICT_ALIGN */
>  
>  #endif /* _ASM_LOONGARCH_ACENV_H */

I am seeing several ACPI errors in my QEMU testing after this change in
Linus's tree as commit a9d13433fe17 ("LoongArch: Align ACPI structures
if ARCH_STRICT_ALIGN enabled").

  $ make -skj"$(nproc)" ARCH=loongarch CROSS_COMPILE=loongarch64-linux- clean defconfig vmlinuz.efi
  kernel/sched/fair.o: warning: objtool: sched_update_scaling() falls through to next function init_entity_runnable_average()
  mm/mempolicy.o: warning: objtool: alloc_pages_bulk_mempolicy_noprof+0x380: stack state mismatch: reg1[30]=-1+0 reg2[30]=-2-80
  lib/crypto/mpi/mpih-div.o: warning: objtool: mpihelp_divrem+0x2d0: stack state mismatch: reg1[22]=-1+0 reg2[22]=-2-16
  In file included from include/acpi/acpi.h:24,
                   from drivers/acpi/acpica/tbprint.c:10:
  drivers/acpi/acpica/tbprint.c: In function 'acpi_tb_print_table_header':
  include/acpi/actypes.h:530:43: warning: 'strncmp' argument 1 declared attribute 'nonstring' is smaller than the specified bound 8 [-Wstringop-overread]
    530 | #define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, (sizeof(a) < 8) ? ACPI_NAMESEG_SIZE : 8))
        |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  drivers/acpi/acpica/tbprint.c:105:20: note: in expansion of macro 'ACPI_VALIDATE_RSDP_SIG'
    105 |         } else if (ACPI_VALIDATE_RSDP_SIG(ACPI_CAST_PTR(struct acpi_table_rsdp,
        |                    ^~~~~~~~~~~~~~~~~~~~~~
  In file included from include/acpi/acpi.h:26:
  include/acpi/actbl.h:69:14: note: argument 'signature' declared here
     69 |         char signature[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;       /* ASCII table signature */
        |              ^~~~~~~~~

  $ curl -LSso /tmp/loongarch-QEMU_EFI.fd https://github.com/loongson/Firmware/raw/main/LoongArchVirtMachine/QEMU_EFI.fd

  $ curl -LSs https://github.com/ClangBuiltLinux/boot-utils/releases/download/20241120-044434/loongarch-rootfs.cpio.zst | zstd -d >/tmp/rootfs.cpio

  $ sha256sum /tmp/loongarch-QEMU_EFI.fd /tmp/rootfs.cpio
  b375639ebcf7a873d2cab67f0c9c1c6c208fc3f1bcba4083172fa20c4fb7e1ab /tmp/loongarch-QEMU_EFI.fd
  1c17c9a4ea823931446fca5f5323b8e9384ba88b48d679e394ec5d4f6e258793 /tmp/rootfs.cpio

  $ qemu-system-loongarch64 --version | head -1
  QEMU emulator version 10.1.0 (qemu-10.1.0-8.fc44)

  # Filtered by "ACPI" and "Linux version"
  $ qemu-system-loongarch64 \
      -display none \
      -nodefaults \
      -M virt \
      -cpu la464 \
      -bios /tmp/loongarch-QEMU_EFI.fd \
      -no-reboot \
      -append console=ttyS0,115200 \
      -kernel arch/loongarch/boot/vmlinuz.efi \
      -initrd /tmp/rootfs.cpio \
      -m 2G \
      -smp 2 \
      -serial mon:stdio
  [    0.000000] Linux version 6.17.0-rc6+ (nathan@aadp) (loongarch64-linux-gcc (GCC) 15.2.0, GNU ld (GNU Binutils) 2.45) #1 SMP PREEMPT_DYNAMIC Sat Sep 20 16:24:42 MST 2025
  [    0.000000] efi: SMBIOS=0xf3c0000 SMBIOS 3.0=0xdd50000 MEMATTR=0xe832118 ACPI=0xe12f000 ACPI 2.0=0xe12f014 INITRD=0xe125f18 MEMRESERVE=0xe125f98 MEMMAP=0xe122018 
  [    0.000000] ACPI: Early table checksum verification disabled
  [    0.000000] ACPI: RSDP 0x000000000E12F014 000024 (v02 BOCHS )
  [    0.000000] ACPI: XSDT 0x000000000E12E0E8 000054 (v01 BOCHS  BXPC     00000001      01000013)
  [    0.000000] ACPI: FACP 0x000000000E12B000 00010C (v05 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.000000] ACPI: DSDT 0x000000000E12C000 00125D (v01 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.000000] ACPI: FACS 0x000000000C770000 000040
  [    0.000000] ACPI: APIC 0x000000000E12A000 00007B (v01 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.000000] ACPI: PPTT 0x000000000E129000 000074 (v02 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.000000] ACPI: SRAT 0x000000000E128000 0000A0 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.000000] ACPI: SPCR 0x000000000E127000 000050 (v02 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.000000] ACPI: MCFG 0x000000000E126000 00003C (v01 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.000000] ACPI: SPCR: console: uart,mmio,0x1fe001e0,115200
  [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0fffffff]
  [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0xefffffff]
  [    0.014877] ACPI: Core revision 20250404
  [    0.854788] ACPI: Added _OSI(Module Device)
  [    0.854920] ACPI: Added _OSI(Processor Device)
  [    0.854935] ACPI: Added _OSI(Processor Aggregator Device)
  [    0.885597] ACPI: 1 ACPI AML tables successfully acquired and loaded
  [    0.906695] ACPI: Interpreter enabled
  [    0.910327] ACPI: PM: (supports S0 S5)
  [    0.910495] ACPI: Using LPIC for interrupt routing
  [    0.911650] ACPI: MCFG table detected, 1 entries
  [    0.925560] ACPI Error: AE_AML_ALIGNMENT, Returned by Handler for [SystemMemory] (20250404/evregion-301)
  [    0.928083] ACPI Error: Aborting method \_SB.CPUS.CSTA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
  [    0.930036] ACPI Error: Aborting method \_SB.CPUS.C000._STA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
  [    0.930585] ACPI Error: Method execution failed \_SB.CPUS.C000._STA due to previous error (AE_AML_ALIGNMENT) (20250404/uteval-68)
  [    0.931693] ACPI Error: AE_AML_ALIGNMENT, Returned by Handler for [SystemMemory] (20250404/evregion-301)
  [    0.931878] ACPI Error: Aborting method \_SB.CPUS.CSTA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
  [    0.932035] ACPI Error: Aborting method \_SB.CPUS.C001._STA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
  [    0.932171] ACPI Error: Method execution failed \_SB.CPUS.C001._STA due to previous error (AE_AML_ALIGNMENT) (20250404/uteval-68)
  [    0.969018] ACPI Error: AE_AML_ALIGNMENT, Returned by Handler for [SystemMemory] (20250404/evregion-301)
  [    0.969139] ACPI Error: Aborting method \_SB.CPUS.CSTA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
  [    0.969238] ACPI Error: Aborting method \_SB.CPUS.C000._STA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
  [    0.971203] ACPI Error: AE_AML_ALIGNMENT, Returned by Handler for [SystemMemory] (20250404/evregion-301)
  [    0.971307] ACPI Error: Aborting method \_SB.CPUS.CSTA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
  [    0.971399] ACPI Error: Aborting method \_SB.CPUS.C001._STA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
  [    0.992513] ACPI Error: AE_AML_ALIGNMENT, Returned by Handler for [SystemMemory] (20250404/evregion-301)
  [    0.992762] ACPI Error: Aborting method \_SB.CPUS.CSTA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
  [    0.993027] ACPI Error: Aborting method \_SB.CPUS.C000._STA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
  [    0.993511] ACPI Error: AE_AML_ALIGNMENT, Returned by Handler for [SystemMemory] (20250404/evregion-301)
  [    0.993593] ACPI Error: Aborting method \_SB.CPUS.CSTA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
  [    0.993664] ACPI Error: Aborting method \_SB.CPUS.C001._STA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
  [    0.994569] ACPI: PCI: Interrupt link L000 configured for IRQ 80
  [    0.994887] ACPI: PCI: Interrupt link L001 configured for IRQ 81
  [    0.995038] ACPI: PCI: Interrupt link L002 configured for IRQ 82
  [    0.995167] ACPI: PCI: Interrupt link L003 configured for IRQ 83
  [    0.998540] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
  [    1.009539] ACPI: Remapped I/O 0x0000000018004000 to [io  0x0000-0xbfff window]
  [    1.039462] ACPI: bus type USB registered
  [    1.125150] pnp: PnP ACPI init
  [    1.135025] ACPI Error: AE_AML_ALIGNMENT, Returned by Handler for [SystemMemory] (20250404/evregion-301)
  [    1.135162] ACPI Error: Aborting method \_SB.CPUS.CSTA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
  [    1.135433] ACPI Error: Aborting method \_SB.CPUS.C000._STA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
  [    1.135539] ACPI Error: Method execution failed \_SB.CPUS.C000._STA due to previous error (AE_AML_ALIGNMENT) (20250404/uteval-68)
  [    1.136219] ACPI Error: AE_AML_ALIGNMENT, Returned by Handler for [SystemMemory] (20250404/evregion-301)
  [    1.136328] ACPI Error: Aborting method \_SB.CPUS.CSTA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
  [    1.136426] ACPI Error: Aborting method \_SB.CPUS.C001._STA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
  [    1.136516] ACPI Error: Method execution failed \_SB.CPUS.C001._STA due to previous error (AE_AML_ALIGNMENT) (20250404/uteval-68)
  [    1.144655] pnp: PnP ACPI: found 5 devices
  [    1.316259] ACPI: bus type thunderbolt registered
  [    1.441002] ACPI: button: Power Button [PWRB]
  [    1.719602] ACPI: bus type drm_connector registered
  [    8.642000] ACPI: PM: Preparing to enter system sleep state S5

At the parent change, this is all I see for ACPI messages.

  [    0.000000] efi: SMBIOS=0xf3c0000 SMBIOS 3.0=0xdd50000 MEMATTR=0xe832118 ACPI=0xe12f000 ACPI 2.0=0xe12f014 INITRD=0xe125f18 MEMRESERVE=0xe125f98 MEMMAP=0xe122018
  [    0.000000] ACPI: Early table checksum verification disabled
  [    0.000000] ACPI: RSDP 0x000000000E12F014 000024 (v02 BOCHS )
  [    0.000000] ACPI: XSDT 0x000000000E12E0E8 000054 (v01 BOCHS  BXPC     00000001      01000013)
  [    0.000000] ACPI: FACP 0x000000000E12B000 00010C (v05 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.000000] ACPI: DSDT 0x000000000E12C000 00125D (v01 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.000000] ACPI: FACS 0x000000000C770000 000040
  [    0.000000] ACPI: APIC 0x000000000E12A000 00007B (v01 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.000000] ACPI: PPTT 0x000000000E129000 000074 (v02 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.000000] ACPI: SRAT 0x000000000E128000 0000A0 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.000000] ACPI: SPCR 0x000000000E127000 000050 (v02 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.000000] ACPI: MCFG 0x000000000E126000 00003C (v01 BOCHS  BXPC     00000001 BXPC 00000001)
  [    0.000000] ACPI: SPCR: console: uart,mmio,0x1fe001e0,115200
  [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0fffffff]
  [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0xefffffff]
  [    0.014597] ACPI: Core revision 20250404
  [    0.915706] ACPI: Added _OSI(Module Device)
  [    0.915755] ACPI: Added _OSI(Processor Device)
  [    0.915764] ACPI: Added _OSI(Processor Aggregator Device)
  [    0.945135] ACPI: 1 ACPI AML tables successfully acquired and loaded
  [    0.960197] ACPI: Interpreter enabled
  [    0.961985] ACPI: PM: (supports S0 S5)
  [    0.962069] ACPI: Using LPIC for interrupt routing
  [    0.962718] ACPI: MCFG table detected, 1 entries
  [    1.013706] ACPI: PCI: Interrupt link L000 configured for IRQ 80
  [    1.013966] ACPI: PCI: Interrupt link L001 configured for IRQ 81
  [    1.014076] ACPI: PCI: Interrupt link L002 configured for IRQ 82
  [    1.014176] ACPI: PCI: Interrupt link L003 configured for IRQ 83
  [    1.014977] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
  [    1.022475] ACPI: Remapped I/O 0x0000000018004000 to [io  0x0000-0xbfff window]
  [    1.058781] ACPI: bus type USB registered
  [    1.125533] pnp: PnP ACPI init
  [    1.140430] pnp: PnP ACPI: found 5 devices
  [    1.270053] ACPI: bus type thunderbolt registered
  [    1.382724] ACPI: button: Power Button [PWRB]
  [    1.673533] ACPI: bus type drm_connector registered
  [    8.715507] ACPI: PM: Preparing to enter system sleep state S5

Is this expected?

Cheers,
Nathan

# bad: [3b08f56fbbb9ef75c7454487f8d3db80a84deef7] Merge tag 'x86-urgent-2025-09-20' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [f83ec76bf285bea5727f478a68b894f5543ca76e] Linux 6.17-rc6
git bisect start '3b08f56fbbb9ef75c7454487f8d3db80a84deef7' 'v6.17-rc6'
# good: [cbf658dd09419f1ef9de11b9604e950bdd5c170b] Merge tag 'net-6.17-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good cbf658dd09419f1ef9de11b9604e950bdd5c170b
# good: [e8442d5b7bc6338d553040f5b1f7bd43f5ab30e0] Merge tag 'sound-6.17-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good e8442d5b7bc6338d553040f5b1f7bd43f5ab30e0
# bad: [ffa7119cd1294dc1814e582dc07ffeb953ae7b26] Merge tag 'mmc-v6.17-rc2-2' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect bad ffa7119cd1294dc1814e582dc07ffeb953ae7b26
# bad: [8dc5245673cf7f33743e5c0d2a4207c0b8df3067] LoongArch: KVM: Avoid copy_*_user() with lock hold in kvm_pch_pic_regs_access()
git bisect bad 8dc5245673cf7f33743e5c0d2a4207c0b8df3067
# bad: [d6d69f0edde63b553345d4efaceb7daed89fe04c] LoongArch: Replace sprintf() with sysfs_emit()
git bisect bad d6d69f0edde63b553345d4efaceb7daed89fe04c
# good: [74f8295c6fb8436bec9995baf6ba463151b6fb68] LoongArch: Handle jump tables options for RUST
git bisect good 74f8295c6fb8436bec9995baf6ba463151b6fb68
# bad: [a9d13433fe17be0e867e51e71a1acd2731fbef8d] LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN enabled
git bisect bad a9d13433fe17be0e867e51e71a1acd2731fbef8d
# good: [f5003098e2f337d8e8a87dc636250e3fa978d9ad] LoongArch: Update help info of ARCH_STRICT_ALIGN
git bisect good f5003098e2f337d8e8a87dc636250e3fa978d9ad
# first bad commit: [a9d13433fe17be0e867e51e71a1acd2731fbef8d] LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN enabled

