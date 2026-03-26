Return-Path: <stable+bounces-230428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kICwFmPaxGkq4gQAu9opvQ
	(envelope-from <stable+bounces-230428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 08:04:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB623302B2
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 08:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD652300E605
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 07:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0B43AA1B9;
	Thu, 26 Mar 2026 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twitnVTm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902683921CA
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774508515; cv=none; b=a32v/vbtOqhDiU5P0AWBv7jZimQwctUwQEHb84yqqYMjz3XF9S2lJWgoOMT/694FCdReLHk8Y4i80ywjy/hZXy93PxJnbw3vqcts5BkW100z1gUIfpkymB2ILmP+IZYei5gRg2J+ab8SM8BT1ZFqJFcF8f39uWSJ3n+QmeTTSJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774508515; c=relaxed/simple;
	bh=09yf9yEfT+DjCAm9yhn7ytT47RWdJQm7vhsvXzEA1Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEKge6VOxWA0z5CWh1iOfBf0b2210Cyp6u9rVLoEI95wpJy/G572c/8WAwQXQE2sW5SJRhx5dg2PfZMEmoh+KN2O7gBsmVF+hMUqXYEpOHYXwWEAmUuabWvEa1wXrLma8QVIxANAKPgatdOoYxBoYVJXQTf95CFsc64khoOrjRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twitnVTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33253C116C6
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 07:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774508515;
	bh=09yf9yEfT+DjCAm9yhn7ytT47RWdJQm7vhsvXzEA1Ds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=twitnVTmBG5UHOHXXWH/upQeYwdOO+kz38IM8Fej619+nNMGR3v/QySyPxQhUap7B
	 cO7/LGU+VAH+ADH9lqTxkdUh1ky6VE/hd6I2y4MPGzmkCXbJCBPfsJpuEpobi/SyVp
	 95AXmPYLulazmWzJPNBmyznNShbkMP6dwY/IeD0nPizYSoAw4byb94uXK3KuR0/ZGl
	 lXhI4BdPW2eYddlNQrF/ZR5WhFR6VUoklCJFBGu7zChhyMkTSOuPNG93LxNfSov4YF
	 0EJ6ijqcDZNn/AoEhShmOuR/0AlzyGVaCRP/lHSsSidPAafqK3V6uTrc9ARg7yOA9u
	 9JpeQIgdoAARQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9825ba7e8dso85618066b.3
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 00:01:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUY603AjiAN2MIqZkmXC9+6+yUHFRmML8JSfM+S6pvjW+4qdeQbRU9cJZXmyjdE+EmYukzheEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX3AELEPMY/1dvqBhQLfFxwNRLrzaQQRxKleb0HFReav9OdTwy
	UHJZmD/8YtWhfWrh+9Qkkl39t3/2nvTtpMJnATbkPszwTuHI8n/V9twpeXpB7Ow971/jcoogHRV
	kdQ3Z806/J4zi74/l3ZiXnoPvxhTVRJ4=
X-Received: by 2002:a17:906:ee8e:b0:b88:6309:c300 with SMTP id
 a640c23a62f3a-b9a54268f23mr451338766b.39.1774508508709; Thu, 26 Mar 2026
 00:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312101440.772081-1-xry111@xry111.site>
In-Reply-To: <20260312101440.772081-1-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 26 Mar 2026 15:01:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6RPEJ+K0bObgSR6K7-DSxiEzVpOpevBYuiAXK3H4wGzA@mail.gmail.com>
X-Gm-Features: AQROBzBJQrnEXt1U-RWfdZWn51P-R5aifLcwNbXyiZ2o7T1PFoW9AMHl4heJT3Q
Message-ID: <CAAhV-H6RPEJ+K0bObgSR6K7-DSxiEzVpOpevBYuiAXK3H4wGzA@mail.gmail.com>
Subject: Re: [PATCH v4] LoongArch: vDSO: Emit GNU_EH_FRAME correctly
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, Jinyang He <hejinyang@loongson.cn>, 
	WANG Rui <wangrui@loongson.cn>, Mingcong Bai <jeffbai@aosc.io>, Zixing Liu <liushuyu@aosc.io>, 
	"H . Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Menglong Dong <menglong8.dong@gmail.com>, 
	Bibo Mao <maobibo@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Hanlu Li <lihanlu@loongson.cn>, Nathan Chancellor <nathan@kernel.org>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Wentao Guan <guanwentao@uniontech.com>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230428-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[xen0n.name,loongson.cn,aosc.io,zytor.com,vger.kernel.org,infradead.org,gmail.com,kernel.org,flygoat.com,uniontech.com,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gnu.org:url,mail.gmail.com:mid,xry111.site:email]
X-Rspamd-Queue-Id: CCB623302B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Applied, thanks.

Huacai

On Thu, Mar 12, 2026 at 6:15=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> With -fno-asynchronous-unwind-tables and --no-eh-frame-hdr (the default
> of the linker), the GNU_EH_FRAME segment (specified by vdso.lds.S) is
> empty.  This is not valid, as the current DWARF specification mandates
> the first byte of the EH frame to be the version number 1.  It causes
> some unwinders to complain, for example the ClickHouse query profiler
> spams the log with messages:
>
>     clickhouse-server[365854]: libunwind: unsupported .eh_frame_hdr
>     version: 127 at 7ffffffb0000
>
> Here "127" is just the byte located at the p_vaddr (0, i.e. the
> beginning of the vDSO) of the empty GNU_EH_FRAME segment.
> Cross-checking with /proc/365854/maps has also proven 7ffffffb0000 is
> the start of vDSO in the process VM image.
>
> In LoongArch the -fno-asynchronous-unwind-tables option seems just a
> MIPS legacy, and MIPS only uses this option to satisfy the MIPS-specific
> "genvdso" program, per the commit cfd75c2db17e ("MIPS: VDSO: Explicitly
> use -fno-asynchronous-unwind-tables").  IIRC it indicates some inherent
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
>
> Changes from [v3]:
> - Move SYM_SIGFUNC_* into include guard.
> - Retain ".section .text".
>
> Changes from [v2] to v3:
> - Wrap .cfi_* for signal trampoline in SYM_SIGFUNC_START.
> - Remove comment lines in sigframe.h not so meaningful.
>
> Changes from [v1] to v2:
> - Use DWARF column 0 instead of the libgcc-specific column 72.
> - Style change to sigframe.h.
>
> [v3]: https://lore.kernel.org/20260303083248.567185-1-xry111@xry111.site
> [v2]: https://lore.kernel.org/20260227072031.581229-1-xry111@xry111.site
> [v1]: https://lore.kernel.org/20260225104607.3803060-1-xry111@xry111.site
>
>  arch/loongarch/include/asm/linkage.h  | 34 +++++++++++++++++++++++++++
>  arch/loongarch/include/asm/sigframe.h |  9 +++++++
>  arch/loongarch/kernel/asm-offsets.c   |  2 ++
>  arch/loongarch/kernel/signal.c        |  6 +----
>  arch/loongarch/vdso/Makefile          |  4 ++--
>  arch/loongarch/vdso/sigreturn.S       |  8 +++----
>  6 files changed, 51 insertions(+), 12 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/sigframe.h
>
> diff --git a/arch/loongarch/include/asm/linkage.h b/arch/loongarch/includ=
e/asm/linkage.h
> index e2eca1a25b4e..9f10de85b3f6 100644
> --- a/arch/loongarch/include/asm/linkage.h
> +++ b/arch/loongarch/include/asm/linkage.h
> @@ -41,4 +41,38 @@
>         .cfi_endproc;                                   \
>         SYM_END(name, SYM_T_NONE)
>
> +/*
> + * This is for the signal handler trampoline, which is used as the retur=
n
> + * address of the signal handlers in userspace instead of called normall=
y.
> + * The long standing libgcc bug https://gcc.gnu.org/PR124050 requires a
> + * nop between .cfi_startproc and the actual address of the trampoline, =
so
> + * we cannot simply use SYM_FUNC_START.
> + *
> + * This wrapper also contains all the .cfi_* directives for recovering
> + * the content of the GPRs and the "return address" (where the rt_sigret=
urn
> + * syscall will jump to), assuming there is a struct rt_sigframe (where
> + * a struct sigcontext containing those information we need to recover) =
at
> + * $sp.  The "DWARF for the LoongArch(TM) Architecture" manual states
> + * column 0 is for $zero, but it does not make too much sense to
> + * save/restore the hardware zero register.  Repurpose this column here
> + * for the return address (here it's not the content of $ra we cannot us=
e
> + * the default column 3).
> + */
> +#define SYM_SIGFUNC_START(name)                                \
> +       .cfi_startproc;                                 \
> +       .cfi_signal_frame;                              \
> +       .cfi_def_cfa 3, RT_SIGFRAME_SC;                 \
> +       .cfi_return_column 0;                           \
> +       .cfi_offset 0, SC_PC;                           \
> +       .irp    num, 1, 2, 3, 4, 5, 6, 7, 8,            \
> +                    9, 10, 11, 12, 13, 14, 15, 16,     \
> +                    17, 18, 19, 20, 21, 22, 23, 24,    \
> +                    25, 26, 27, 28, 29, 30, 31;        \
> +       .cfi_offset \num, SC_REGS + \num * SZREG;       \
> +       .endr;                                          \
> +       nop;                                            \
> +       SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
> +
> +#define SYM_SIGFUNC_END(name) SYM_FUNC_END(name)
> +
>  #endif
> diff --git a/arch/loongarch/include/asm/sigframe.h b/arch/loongarch/inclu=
de/asm/sigframe.h
> new file mode 100644
> index 000000000000..109298b8d7e0
> --- /dev/null
> +++ b/arch/loongarch/include/asm/sigframe.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#include <asm/siginfo.h>
> +#include <asm/ucontext.h>
> +
> +struct rt_sigframe {
> +       struct siginfo rs_info;
> +       struct ucontext rs_uctx;
> +};
> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/=
asm-offsets.c
> index 3017c7157600..2cc953f113ac 100644
> --- a/arch/loongarch/kernel/asm-offsets.c
> +++ b/arch/loongarch/kernel/asm-offsets.c
> @@ -16,6 +16,7 @@
>  #include <asm/ptrace.h>
>  #include <asm/processor.h>
>  #include <asm/ftrace.h>
> +#include <asm/sigframe.h>
>  #include <vdso/datapage.h>
>
>  static void __used output_ptreg_defines(void)
> @@ -220,6 +221,7 @@ static void __used output_sc_defines(void)
>         COMMENT("Linux sigcontext offsets.");
>         OFFSET(SC_REGS, sigcontext, sc_regs);
>         OFFSET(SC_PC, sigcontext, sc_pc);
> +       OFFSET(RT_SIGFRAME_SC, rt_sigframe, rs_uctx.uc_mcontext);
>         BLANK();
>  }
>
> diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signa=
l.c
> index c9f7ca778364..e297d54ea638 100644
> --- a/arch/loongarch/kernel/signal.c
> +++ b/arch/loongarch/kernel/signal.c
> @@ -37,6 +37,7 @@
>  #include <asm/lbt.h>
>  #include <asm/ucontext.h>
>  #include <asm/vdso.h>
> +#include <asm/sigframe.h>
>
>  #ifdef DEBUG_SIG
>  #  define DEBUGP(fmt, args...) printk("%s: " fmt, __func__, ##args)
> @@ -51,11 +52,6 @@
>  #define lock_lbt_owner()       ({ preempt_disable(); pagefault_disable()=
; })
>  #define unlock_lbt_owner()     ({ pagefault_enable(); preempt_enable(); =
})
>
> -struct rt_sigframe {
> -       struct siginfo rs_info;
> -       struct ucontext rs_uctx;
> -};
> -
>  struct _ctx_layout {
>         struct sctx_info *addr;
>         unsigned int size;
> diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
> index 520f1513f07d..294c16b9517f 100644
> --- a/arch/loongarch/vdso/Makefile
> +++ b/arch/loongarch/vdso/Makefile
> @@ -26,7 +26,7 @@ cflags-vdso :=3D $(ccflags-vdso) \
>         $(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
>         -std=3Dgnu11 -fms-extensions -O2 -g -fno-strict-aliasing -fno-com=
mon -fno-builtin \
>         -fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING =
\
> -       $(call cc-option, -fno-asynchronous-unwind-tables) \
> +       $(call cc-option, -fasynchronous-unwind-tables) \
>         $(call cc-option, -fno-stack-protector)
>  aflags-vdso :=3D $(ccflags-vdso) \
>         -D__ASSEMBLY__ -Wa,-gdwarf-2
> @@ -41,7 +41,7 @@ endif
>
>  # VDSO linker flags.
>  ldflags-y :=3D -Bsymbolic --no-undefined -soname=3Dlinux-vdso.so.1 \
> -       $(filter -E%,$(KBUILD_CFLAGS)) -shared --build-id -T
> +       $(filter -E%,$(KBUILD_CFLAGS)) -shared --build-id --eh-frame-hdr =
-T
>
>  #
>  # Shared build commands.
> diff --git a/arch/loongarch/vdso/sigreturn.S b/arch/loongarch/vdso/sigret=
urn.S
> index 9cb3c58fad03..a876dbdc458a 100644
> --- a/arch/loongarch/vdso/sigreturn.S
> +++ b/arch/loongarch/vdso/sigreturn.S
> @@ -12,13 +12,11 @@
>
>  #include <asm/regdef.h>
>  #include <asm/asm.h>
> +#include <asm/asm-offsets.h>
>
>         .section        .text
> -       .cfi_sections   .debug_frame
> -
> -SYM_FUNC_START(__vdso_rt_sigreturn)
>
> +SYM_SIGFUNC_START(__vdso_rt_sigreturn)
>         li.w    a7, __NR_rt_sigreturn
>         syscall 0
> -
> -SYM_FUNC_END(__vdso_rt_sigreturn)
> +SYM_SIGFUNC_END(__vdso_rt_sigreturn)
> --
> 2.53.0
>

