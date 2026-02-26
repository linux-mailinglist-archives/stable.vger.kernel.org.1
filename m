Return-Path: <stable+bounces-219741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ED3AE2in2lfdAQAu9opvQ
	(envelope-from <stable+bounces-219741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 02:30:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C0D19FCE6
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 02:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F236230488DA
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 01:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E243557F3;
	Thu, 26 Feb 2026 01:30:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300F921146C;
	Thu, 26 Feb 2026 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069438; cv=none; b=Ipg3rfrScN8eiG6rHJzOrC73PsHc+m6PW0xi2aq9xjD1ZSgfW88nvyDjUG+m0xoD2iKqdNo9VOew+lKm5oYcwEMy/b8mgDBi7Krzni8tZQKHaUxnsZx/hjAmfeVf74VmETJY+Il/fGNPrLhuPLEbZ3vPpcHmCVd5R4XogwjETMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069438; c=relaxed/simple;
	bh=aAZQlM+mM5UZqJGdjBICV1gTjgyXio/kwuDjKdeL0lI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cjTuebVsYGfDXGODbirgRZW6YrzG8peINRLcCx64uqaUuJy6u4s9ddGOAeGiZ7sNIXnfQj7Z9HfEZqM/8/y0wL9gTOdD7AcGlYIxPMHsDufwC4AtGquUXOINNmIXNWUKpTMpucpHOaF6nTTfd1AXVdTinLigAU1ZSZL6qLKPMqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8CxLMM5op9p4UwVAA--.65257S3;
	Thu, 26 Feb 2026 09:30:33 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
	by front1 (Coremail) with SMTP id qMiowJCxOMExop9p0glLAA--.62144S3;
	Thu, 26 Feb 2026 09:30:27 +0800 (CST)
Subject: Re: [PATCH] LoongArch: vDSO: Emit GNU_EH_FRAME correctly
To: Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>
Cc: WANG Rui <wangrui@loongson.cn>, Mingcong Bai <jeffbai@aosc.io>,
 Zixing Liu <liushuyu@aosc.io>, "H . Peter Anvin" <hpa@zytor.com>,
 stable@vger.kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Menglong Dong <menglong8.dong@gmail.com>, Bibo Mao <maobibo@loongson.cn>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Hanlu Li <lihanlu@loongson.cn>,
 Nathan Chancellor <nathan@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Ard Biesheuvel <ardb@kernel.org>,
 Wentao Guan <guanwentao@uniontech.com>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260225104607.3803060-1-xry111@xry111.site>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <ab012e96-e0c8-cc26-ab09-9f2bd2f65b42@loongson.cn>
Date: Thu, 26 Feb 2026 09:30:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260225104607.3803060-1-xry111@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:qMiowJCxOMExop9p0glLAA--.62144S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3ArWDAF4fAw1rJw4kCr4Utrc_yoWfuFy3pF
	n8Aan3GrWDGFyI9r9rtw4rZrZ5A3Z7Wr1Ygan0ka48Cr90gr1xJr4vyrs0qF1DJ3ykCryI
	gF98tFW3uFs8AagCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8svtJUUUU
	U==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-219741-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[loongson.cn,aosc.io,zytor.com,vger.kernel.org,infradead.org,gmail.com,kernel.org,flygoat.com,uniontech.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hejinyang@loongson.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.894];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xry111.site:email]
X-Rspamd-Queue-Id: 53C0D19FCE6
X-Rspamd-Action: no action

On 2026-02-25 18:45, Xi Ruoyao wrote:

> With -fno-asynchronous-unwind-tables and --no-eh-frame-hdr (the default
> of the linker), the GNU_EH_FRAME segment (specified by vdso.lds.S) is
> empty.  This is not valid, as the current DWARF specification mandates
> the first byte of the EH frame to be the version number 1.  It causes
> some unwinders to complain, for example the ClickHouse query profiler
> spams the log with messages:
>
>      clickhouse-server[365854]: libunwind: unsupported .eh_frame_hdr
>      version: 127 at 7ffffffb0000
>
> Here "127" is just the byte located at the p_vaddr (0, i.e. the
> beginning of the vDSO) of the empty GNU_EH_FRAME segment.
> Cross-checking with /proc/365854/maps has also proven 7ffffffb0000 is
> the start of vDSO in the process VM image.
>
> In LoongArch the -fno-asynchronous-unwind-tables option seems just a
> MIPS legacy, and MIPS only uses this option to satisfy the MIPS-specific
> "genvdso" program, per the commit cfd75c2db17e ("MIPS: VDSO: Explicitly
> use -fno-asynchronous-unwind-tables").  IIUC it indicates some inherent
> limitation of the MIPS ELF ABI and has nothing to do with LoongArch.  So
> we can simply flip it over to -fasynchronous-unwind-tables and pass
> --eh-frame-hdr for linking the vDSO, allowing the profilers to unwind the
> stack for statistics even if the sample point is taken when the PC is in
> the vDSO.
>
> However simply adjusting the options above would exploit an issue: when
> the libgcc unwinder saw the invalid GNU_EH_FRAME segment, it silently
> falled back to a machine-specific routine to match the code pattern of
> rt_sigreturn and extract the registers saved in the sigframe if the code
> pattern is matched.  As unwinding from signal handlers is vital for
> libgcc to support pthread cancellation etc., the fall-back routine had
> been silently keeping the LoongArch Linux systems functioning since
> Linux 5.19.  But when we start to emit GNU_EH_FRAME with the correct
> format, fall-back routine will no longer be used and libgcc will fail
> to unwind the sigframe, and unwinding from signal handlers will no
> longer work, causing dozens of glibc test failures.  To make it possible
> to unwind from signal handlers again, it's necessary to code the unwind
> info in __vdso_rt_sigreturn via .cfi_* directives.
>
> The offsets in the .cfi_* directives depend on the layout of struct
> sigframe, notably the offset of sigcontect in the sigframe.  To use the
> offset in the assembly file, factor out struct sigframe into a header to
> allow asm-offsets.c to output the offset for assembly.
>
> To work around a long-term issue in the libgcc unwinder (the pc is
> unconditionally substracted by 1: doing so is technically incorrect for
> a signal frame), a nop instruction is included with the two real
> instructions in __vdso_rt_sigreturn in the same FDE PC range.  The same
> hack has been used on x86 for a long time.
>
> Fixes: c6b99bed6b8f ("LoongArch: Add VDSO and VSYSCALL support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>   arch/loongarch/include/asm/sigframe.h | 22 ++++++++++++++
>   arch/loongarch/kernel/asm-offsets.c   |  2 ++
>   arch/loongarch/kernel/signal.c        |  6 +---
>   arch/loongarch/vdso/Makefile          |  4 +--
>   arch/loongarch/vdso/sigreturn.S       | 44 ++++++++++++++++++++++++---
>   5 files changed, 67 insertions(+), 11 deletions(-)
>   create mode 100644 arch/loongarch/include/asm/sigframe.h
>
> diff --git a/arch/loongarch/include/asm/sigframe.h b/arch/loongarch/include/asm/sigframe.h
> new file mode 100644
> index 000000000000..6889bcf5dc88
> --- /dev/null
> +++ b/arch/loongarch/include/asm/sigframe.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Separated from arch/loongarch/kernel/signal.c:
> + *
> + * Author: Hanlu Li <lihanlu@loongson.cn>
> + *         Huacai Chen <chenhuacai@loongson.cn>
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + *
> + * Derived from MIPS:
> + * Copyright (C) 1991, 1992  Linus Torvalds
> + * Copyright (C) 1994 - 2000  Ralf Baechle
> + * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
> + * Copyright (C) 2014, Imagination Technologies Ltd.
> + */
> +
> +#include <uapi/asm/ucontext.h>
> +#include <asm/siginfo.h>
> +
> +struct rt_sigframe {
> +	struct siginfo rs_info;
> +	struct ucontext rs_uctx;
> +};
> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
> index 3017c7157600..2cc953f113ac 100644
> --- a/arch/loongarch/kernel/asm-offsets.c
> +++ b/arch/loongarch/kernel/asm-offsets.c
> @@ -16,6 +16,7 @@
>   #include <asm/ptrace.h>
>   #include <asm/processor.h>
>   #include <asm/ftrace.h>
> +#include <asm/sigframe.h>
>   #include <vdso/datapage.h>
>   
>   static void __used output_ptreg_defines(void)
> @@ -220,6 +221,7 @@ static void __used output_sc_defines(void)
>   	COMMENT("Linux sigcontext offsets.");
>   	OFFSET(SC_REGS, sigcontext, sc_regs);
>   	OFFSET(SC_PC, sigcontext, sc_pc);
> +	OFFSET(RT_SIGFRAME_SC, rt_sigframe, rs_uctx.uc_mcontext);
>   	BLANK();
>   }
>   
> diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
> index c9f7ca778364..e297d54ea638 100644
> --- a/arch/loongarch/kernel/signal.c
> +++ b/arch/loongarch/kernel/signal.c
> @@ -37,6 +37,7 @@
>   #include <asm/lbt.h>
>   #include <asm/ucontext.h>
>   #include <asm/vdso.h>
> +#include <asm/sigframe.h>
>   
>   #ifdef DEBUG_SIG
>   #  define DEBUGP(fmt, args...) printk("%s: " fmt, __func__, ##args)
> @@ -51,11 +52,6 @@
>   #define lock_lbt_owner()	({ preempt_disable(); pagefault_disable(); })
>   #define unlock_lbt_owner()	({ pagefault_enable(); preempt_enable(); })
>   
> -struct rt_sigframe {
> -	struct siginfo rs_info;
> -	struct ucontext rs_uctx;
> -};
> -
>   struct _ctx_layout {
>   	struct sctx_info *addr;
>   	unsigned int size;
> diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
> index 520f1513f07d..294c16b9517f 100644
> --- a/arch/loongarch/vdso/Makefile
> +++ b/arch/loongarch/vdso/Makefile
> @@ -26,7 +26,7 @@ cflags-vdso := $(ccflags-vdso) \
>   	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
>   	-std=gnu11 -fms-extensions -O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
>   	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
> -	$(call cc-option, -fno-asynchronous-unwind-tables) \
> +	$(call cc-option, -fasynchronous-unwind-tables) \
>   	$(call cc-option, -fno-stack-protector)
>   aflags-vdso := $(ccflags-vdso) \
>   	-D__ASSEMBLY__ -Wa,-gdwarf-2
> @@ -41,7 +41,7 @@ endif
>   
>   # VDSO linker flags.
>   ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
> -	$(filter -E%,$(KBUILD_CFLAGS)) -shared --build-id -T
> +	$(filter -E%,$(KBUILD_CFLAGS)) -shared --build-id --eh-frame-hdr -T
>   
>   #
>   # Shared build commands.
> diff --git a/arch/loongarch/vdso/sigreturn.S b/arch/loongarch/vdso/sigreturn.S
> index 9cb3c58fad03..e46c1deacb9e 100644
> --- a/arch/loongarch/vdso/sigreturn.S
> +++ b/arch/loongarch/vdso/sigreturn.S
> @@ -12,13 +12,49 @@
>   
>   #include <asm/regdef.h>
>   #include <asm/asm.h>
> +#include <asm/asm-offsets.h>
>   
>   	.section	.text
> -	.cfi_sections	.debug_frame
>   
> -SYM_FUNC_START(__vdso_rt_sigreturn)
> +	.cfi_startproc
> +	.cfi_signal_frame
>   
> +	/*
> +	 * There is a struct rt_sigframe at $sp, set CFA to the address of
> +	 * the struct sigcontext in the rt_sigframe to simplify the
> +	 * offsets below.
> +	 */
> +	.cfi_def_cfa 3, RT_SIGFRAME_SC
> +
> +	/*
> +	 * 72 is DWARF 2 CFA column for the return address from a signal
> +	 * handler context on LoongArch, i.e. the PC stored in the
> +	 * sigcontext.
> +	 */
Could we use `.cfi_return_column 0` here? Since I recommended
llvm::libunwind that restore register to zero not destroy it
and we can use it as a hack, [1]. But I don't know whether the
libgcc works ok or not in this case.
Otherwise I think we should update [2] first.

Others look good to me.

[1] https://reviews.llvm.org/D137010#3907282
[2] https://github.com/loongson/la-abi-specs/blob/release/ladwarf.adoc


Thanks,
Jinyang
> +	.cfi_return_column 72
> +	.cfi_offset 72, SC_PC
> +
> +	/* The GPRs of the "caller" are also stored in the sigcontext.  */
> +.irp	num, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, \
> +	     17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
> +	.cfi_offset \num, SC_REGS + \num * SZREG
> +.endr
> +
> +	/*
> +	 * HACK: The dwarf2 unwind routine will subtract 1 from the return
> +	 * address to get an address in the middle of the persumed call
> +	 * instruction.  While in libgcc there exists a logic to avoid
> +	 * subtracting 1 for the signal frame (a frame with the 'S'
> +	 * augmentation that we've already added via .cfi_signal_frame),
> +	 * unfortunately it doesn't really work: the check of signal frame
> +	 * is at libgcc/unwind-dw2:1008 in GCC 15.2.0, but the flag it
> +	 * checks will only get updated by the extract_cie_info call at line
> +	 * 1025.  So include a nop before the real start to make up for it.
> +	 * This is also the reason we don't use SYM_FUNC_START.
> +	 */
> +	nop
> +SYM_START(__vdso_rt_sigreturn, SYM_L_GLOBAL, SYM_A_ALIGN)
>   	li.w	a7, __NR_rt_sigreturn
>   	syscall	0
> -
> -SYM_FUNC_END(__vdso_rt_sigreturn)
> +	.cfi_endproc
> +SYM_END(__vdso_rt_sigreturn, SYM_T_FUNC)


