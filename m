Return-Path: <stable+bounces-219744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BwfyGq6xn2kpdQQAu9opvQ
	(envelope-from <stable+bounces-219744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 03:36:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FC51A0227
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 03:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA93F302E40E
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 02:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE90A33EB07;
	Thu, 26 Feb 2026 02:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="eKFhXQvN"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C32BB13;
	Thu, 26 Feb 2026 02:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073385; cv=none; b=XBKr1MyLd9H+l6zciUsPn9aVnv4uaZSRmDVD5YIZNenf2JWZ/xDY+y8E4QzvZS4Bbu3ysXbzMFEMR08E8PwG+QXndogPDes6SlVBfo46aUq6hk4IFEqeUtrMYoOIfcZhO3894dTo9d3xCYzUM5Kg+kFK8qGpPiByApfHyAwEA1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073385; c=relaxed/simple;
	bh=bKF7whReJIn8JKfwcVEEd5XFoh76kcATdGd43AVoMJo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vsqw2faubKtZI48QYM2eMafE7wU5FVnZCjx3/OVDIiBMwbd5mhM1T+xpE0Jr6qy3YKmUYWKu5C/bmd2gfta3LAs+gDYGWMSpE+17fVT0d0Q5UvAI6ebsZTIlTNBbP0oS8NmPK0xPqD5WBVWj1jk7vm+ZTX5x5qoYpQFfFFDuzpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=eKFhXQvN; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1772073381;
	bh=49RBKy8u4LElecUSYTEDeez5MCwRWq4fA5GLRxjd93I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eKFhXQvNBK57c2NYIDM6mG4Yc2CqWHt2yRSQdAulpJ3W1xWTJk9iH2dchgr5FprBO
	 Y8lo8QcKvdj+ODC3pgh24kDE/Qhw+wAOdnTIb29Cz6LOx1iTb3RVhnhAFAE8KdqF1W
	 7wbkBfjI1nZtIbiDeNCruAV4Sz/6twy3Vi7ssrYU=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 3F69066EE5;
	Wed, 25 Feb 2026 21:36:15 -0500 (EST)
Message-ID: <a9284c7a78b12502973ae39be041a0d52b83a1fe.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: vDSO: Emit GNU_EH_FRAME correctly
From: Xi Ruoyao <xry111@xry111.site>
To: Jinyang He <hejinyang@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
  WANG Xuerui <kernel@xen0n.name>
Cc: WANG Rui <wangrui@loongson.cn>, Mingcong Bai <jeffbai@aosc.io>, Zixing
 Liu	 <liushuyu@aosc.io>, "H . Peter Anvin" <hpa@zytor.com>,
 stable@vger.kernel.org,  "Peter Zijlstra (Intel)"	 <peterz@infradead.org>,
 Menglong Dong <menglong8.dong@gmail.com>, Bibo Mao	 <maobibo@loongson.cn>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Hanlu Li	 <lihanlu@loongson.cn>,
 Nathan Chancellor <nathan@kernel.org>, Jiaxun Yang	
 <jiaxun.yang@flygoat.com>, Ard Biesheuvel <ardb@kernel.org>, Wentao Guan	
 <guanwentao@uniontech.com>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Thu, 26 Feb 2026 10:36:11 +0800
In-Reply-To: <ab012e96-e0c8-cc26-ab09-9f2bd2f65b42@loongson.cn>
References: <20260225104607.3803060-1-xry111@xry111.site>
	 <ab012e96-e0c8-cc26-ab09-9f2bd2f65b42@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219744-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[loongson.cn,aosc.io,zytor.com,vger.kernel.org,infradead.org,gmail.com,kernel.org,flygoat.com,uniontech.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[xry111.site:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xry111.site:mid,xry111.site:dkim,xry111.site:email]
X-Rspamd-Queue-Id: A3FC51A0227
X-Rspamd-Action: no action

On Thu, 2026-02-26 at 09:30 +0800, Jinyang He wrote:
> On 2026-02-25 18:45, Xi Ruoyao wrote:
>=20
> > With -fno-asynchronous-unwind-tables and --no-eh-frame-hdr (the
> > default
> > of the linker), the GNU_EH_FRAME segment (specified by vdso.lds.S)
> > is
> > empty.=C2=A0 This is not valid, as the current DWARF specification
> > mandates
> > the first byte of the EH frame to be the version number 1.=C2=A0 It
> > causes
> > some unwinders to complain, for example the ClickHouse query
> > profiler
> > spams the log with messages:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 clickhouse-server[365854]: libunwind: unsuppor=
ted .eh_frame_hdr
> > =C2=A0=C2=A0=C2=A0=C2=A0 version: 127 at 7ffffffb0000
> >=20
> > Here "127" is just the byte located at the p_vaddr (0, i.e. the
> > beginning of the vDSO) of the empty GNU_EH_FRAME segment.
> > Cross-checking with /proc/365854/maps has also proven 7ffffffb0000
> > is
> > the start of vDSO in the process VM image.
> >=20
> > In LoongArch the -fno-asynchronous-unwind-tables option seems just a
> > MIPS legacy, and MIPS only uses this option to satisfy the MIPS-
> > specific
> > "genvdso" program, per the commit cfd75c2db17e ("MIPS: VDSO:
> > Explicitly
> > use -fno-asynchronous-unwind-tables").=C2=A0 IIUC it indicates some
> > inherent
> > limitation of the MIPS ELF ABI and has nothing to do with
> > LoongArch.=C2=A0 So
> > we can simply flip it over to -fasynchronous-unwind-tables and pass
> > --eh-frame-hdr for linking the vDSO, allowing the profilers to
> > unwind the
> > stack for statistics even if the sample point is taken when the PC
> > is in
> > the vDSO.
> >=20
> > However simply adjusting the options above would exploit an issue:
> > when
> > the libgcc unwinder saw the invalid GNU_EH_FRAME segment, it
> > silently
> > falled back to a machine-specific routine to match the code pattern
> > of
> > rt_sigreturn and extract the registers saved in the sigframe if the
> > code
> > pattern is matched.=C2=A0 As unwinding from signal handlers is vital fo=
r
> > libgcc to support pthread cancellation etc., the fall-back routine
> > had
> > been silently keeping the LoongArch Linux systems functioning since
> > Linux 5.19.=C2=A0 But when we start to emit GNU_EH_FRAME with the corre=
ct
> > format, fall-back routine will no longer be used and libgcc will
> > fail
> > to unwind the sigframe, and unwinding from signal handlers will no
> > longer work, causing dozens of glibc test failures.=C2=A0 To make it
> > possible
> > to unwind from signal handlers again, it's necessary to code the
> > unwind
> > info in __vdso_rt_sigreturn via .cfi_* directives.
> >=20
> > The offsets in the .cfi_* directives depend on the layout of struct
> > sigframe, notably the offset of sigcontect in the sigframe.=C2=A0 To us=
e
> > the
> > offset in the assembly file, factor out struct sigframe into a
> > header to
> > allow asm-offsets.c to output the offset for assembly.
> >=20
> > To work around a long-term issue in the libgcc unwinder (the pc is
> > unconditionally substracted by 1: doing so is technically incorrect
> > for
> > a signal frame), a nop instruction is included with the two real
> > instructions in __vdso_rt_sigreturn in the same FDE PC range.=C2=A0 The
> > same
> > hack has been used on x86 for a long time.
> >=20
> > Fixes: c6b99bed6b8f ("LoongArch: Add VDSO and VSYSCALL support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > ---
> > =C2=A0 arch/loongarch/include/asm/sigframe.h | 22 ++++++++++++++
> > =C2=A0 arch/loongarch/kernel/asm-offsets.c=C2=A0=C2=A0 |=C2=A0 2 ++
> > =C2=A0 arch/loongarch/kernel/signal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 6 +---
> > =C2=A0 arch/loongarch/vdso/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +--
> > =C2=A0 arch/loongarch/vdso/sigreturn.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 44
> > ++++++++++++++++++++++++---
> > =C2=A0 5 files changed, 67 insertions(+), 11 deletions(-)
> > =C2=A0 create mode 100644 arch/loongarch/include/asm/sigframe.h
> >=20
> > diff --git a/arch/loongarch/include/asm/sigframe.h
> > b/arch/loongarch/include/asm/sigframe.h
> > new file mode 100644
> > index 000000000000..6889bcf5dc88
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/sigframe.h
> > @@ -0,0 +1,22 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Separated from arch/loongarch/kernel/signal.c:
> > + *
> > + * Author: Hanlu Li <lihanlu@loongson.cn>
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Huacai Chen <chenhu=
acai@loongson.cn>
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + *
> > + * Derived from MIPS:
> > + * Copyright (C) 1991, 1992=C2=A0 Linus Torvalds
> > + * Copyright (C) 1994 - 2000=C2=A0 Ralf Baechle
> > + * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
> > + * Copyright (C) 2014, Imagination Technologies Ltd.
> > + */
> > +
> > +#include <uapi/asm/ucontext.h>
> > +#include <asm/siginfo.h>
> > +
> > +struct rt_sigframe {
> > +	struct siginfo rs_info;
> > +	struct ucontext rs_uctx;
> > +};
> > diff --git a/arch/loongarch/kernel/asm-offsets.c
> > b/arch/loongarch/kernel/asm-offsets.c
> > index 3017c7157600..2cc953f113ac 100644
> > --- a/arch/loongarch/kernel/asm-offsets.c
> > +++ b/arch/loongarch/kernel/asm-offsets.c
> > @@ -16,6 +16,7 @@
> > =C2=A0 #include <asm/ptrace.h>
> > =C2=A0 #include <asm/processor.h>
> > =C2=A0 #include <asm/ftrace.h>
> > +#include <asm/sigframe.h>
> > =C2=A0 #include <vdso/datapage.h>
> > =C2=A0=20
> > =C2=A0 static void __used output_ptreg_defines(void)
> > @@ -220,6 +221,7 @@ static void __used output_sc_defines(void)
> > =C2=A0=C2=A0	COMMENT("Linux sigcontext offsets.");
> > =C2=A0=C2=A0	OFFSET(SC_REGS, sigcontext, sc_regs);
> > =C2=A0=C2=A0	OFFSET(SC_PC, sigcontext, sc_pc);
> > +	OFFSET(RT_SIGFRAME_SC, rt_sigframe, rs_uctx.uc_mcontext);
> > =C2=A0=C2=A0	BLANK();
> > =C2=A0 }
> > =C2=A0=20
> > diff --git a/arch/loongarch/kernel/signal.c
> > b/arch/loongarch/kernel/signal.c
> > index c9f7ca778364..e297d54ea638 100644
> > --- a/arch/loongarch/kernel/signal.c
> > +++ b/arch/loongarch/kernel/signal.c
> > @@ -37,6 +37,7 @@
> > =C2=A0 #include <asm/lbt.h>
> > =C2=A0 #include <asm/ucontext.h>
> > =C2=A0 #include <asm/vdso.h>
> > +#include <asm/sigframe.h>
> > =C2=A0=20
> > =C2=A0 #ifdef DEBUG_SIG
> > =C2=A0 #=C2=A0 define DEBUGP(fmt, args...) printk("%s: " fmt, __func__,
> > ##args)
> > @@ -51,11 +52,6 @@
> > =C2=A0 #define lock_lbt_owner()	({ preempt_disable();
> > pagefault_disable(); })
> > =C2=A0 #define unlock_lbt_owner()	({ pagefault_enable();
> > preempt_enable(); })
> > =C2=A0=20
> > -struct rt_sigframe {
> > -	struct siginfo rs_info;
> > -	struct ucontext rs_uctx;
> > -};
> > -
> > =C2=A0 struct _ctx_layout {
> > =C2=A0=C2=A0	struct sctx_info *addr;
> > =C2=A0=C2=A0	unsigned int size;
> > diff --git a/arch/loongarch/vdso/Makefile
> > b/arch/loongarch/vdso/Makefile
> > index 520f1513f07d..294c16b9517f 100644
> > --- a/arch/loongarch/vdso/Makefile
> > +++ b/arch/loongarch/vdso/Makefile
> > @@ -26,7 +26,7 @@ cflags-vdso :=3D $(ccflags-vdso) \
> > =C2=A0=C2=A0	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) =
\
> > =C2=A0=C2=A0	-std=3Dgnu11 -fms-extensions -O2 -g -fno-strict-aliasing -
> > fno-common -fno-builtin \
> > =C2=A0=C2=A0	-fno-stack-protector -fno-jump-tables -
> > DDISABLE_BRANCH_PROFILING \
> > -	$(call cc-option, -fno-asynchronous-unwind-tables) \
> > +	$(call cc-option, -fasynchronous-unwind-tables) \
> > =C2=A0=C2=A0	$(call cc-option, -fno-stack-protector)
> > =C2=A0 aflags-vdso :=3D $(ccflags-vdso) \
> > =C2=A0=C2=A0	-D__ASSEMBLY__ -Wa,-gdwarf-2
> > @@ -41,7 +41,7 @@ endif
> > =C2=A0=20
> > =C2=A0 # VDSO linker flags.
> > =C2=A0 ldflags-y :=3D -Bsymbolic --no-undefined -soname=3Dlinux-vdso.so=
.1 \
> > -	$(filter -E%,$(KBUILD_CFLAGS)) -shared --build-id -T
> > +	$(filter -E%,$(KBUILD_CFLAGS)) -shared --build-id --eh-
> > frame-hdr -T
> > =C2=A0=20
> > =C2=A0 #
> > =C2=A0 # Shared build commands.
> > diff --git a/arch/loongarch/vdso/sigreturn.S
> > b/arch/loongarch/vdso/sigreturn.S
> > index 9cb3c58fad03..e46c1deacb9e 100644
> > --- a/arch/loongarch/vdso/sigreturn.S
> > +++ b/arch/loongarch/vdso/sigreturn.S
> > @@ -12,13 +12,49 @@
> > =C2=A0=20
> > =C2=A0 #include <asm/regdef.h>
> > =C2=A0 #include <asm/asm.h>
> > +#include <asm/asm-offsets.h>
> > =C2=A0=20
> > =C2=A0=C2=A0	.section	.text
> > -	.cfi_sections	.debug_frame
> > =C2=A0=20
> > -SYM_FUNC_START(__vdso_rt_sigreturn)
> > +	.cfi_startproc
> > +	.cfi_signal_frame
> > =C2=A0=20
> > +	/*
> > +	 * There is a struct rt_sigframe at $sp, set CFA to the
> > address of
> > +	 * the struct sigcontext in the rt_sigframe to simplify the
> > +	 * offsets below.
> > +	 */
> > +	.cfi_def_cfa 3, RT_SIGFRAME_SC
> > +
> > +	/*
> > +	 * 72 is DWARF 2 CFA column for the return address from a
> > signal
> > +	 * handler context on LoongArch, i.e. the PC stored in the
> > +	 * sigcontext.
> > +	 */
> Could we use `.cfi_return_column 0` here? Since I recommended
> llvm::libunwind that restore register to zero not destroy it
> and we can use it as a hack, [1]. But I don't know whether the
> libgcc works ok or not in this case.
> Otherwise I think we should update [2] first.
>=20
> Others look good to me.
>=20
> [1] https://reviews.llvm.org/D137010#3907282
> [2] https://github.com/loongson/la-abi-specs/blob/release/ladwarf.adoc

I'll take a look but I think [2] needs an update no matter if we use 0
or 72.  I.e. if we use 0 we should document the slot for the signal
frame RA instead of $r0.

--=20
Xi Ruoyao <xry111@xry111.site>

