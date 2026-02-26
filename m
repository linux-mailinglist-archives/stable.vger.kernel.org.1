Return-Path: <stable+bounces-219783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL0BCckYoGmzfgQAu9opvQ
	(envelope-from <stable+bounces-219783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 10:56:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAC81A3D2C
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 10:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE0BC3142A1A
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 09:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2961E39447F;
	Thu, 26 Feb 2026 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Z5bkXRIk"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928AA399036;
	Thu, 26 Feb 2026 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099094; cv=none; b=jAPggMiZGn5V5PblLfnongm5lvrwA1Bwy4Ns7cqnJoRKwFZdLxgNjVqjz7nwjPxKoZ1BU/9H/isR1SwLXqoEPvMZ865eLIhLuthEdMA0xVF9Av+ZkGCAacYsqCgASDULXPutVA4VjVDYcy80AqTFufZMQEJO9OYZGDNu2hp2kEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099094; c=relaxed/simple;
	bh=E7N92gzXpH05h23WdhX6bsUGcMmNWSNLUuFYwgCc9uA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FcFMBMQ+2w5VUHuP90HH07dmHHJ60F95OeRHNTA/o1USnRKzbDIlUR+5ZrAEY9k5I8SFX01GRFbcSqWTal1wMxbfjL2phuMgais06A2uiqKhe56jw7+3Ain8GckcOkJX08Kh7h1DBKHBmcthXgmr+sL/++xG2d+AHWZtNU4Jn7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Z5bkXRIk; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1772099090;
	bh=C+isJdGDTiiQ6TnD/DAtbrRXRdlm8oylfOj/2zTVcd0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Z5bkXRIkAL9O5K2+Wmwig9R5HkrtZ2cpw+nZqMppE0F8grMS6uUYqEttKRE6BH877
	 YY59sZuuRj2OdAhNEqZQdnkr9R9tnl8M2B0EsunBSaOwyGHjnB/v6btGxxJBMLSnPN
	 UYTlfLz+B+WMI2/d2a4zzLXpvsL5eYXVvBhck9bE=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id D5F361A4242;
	Thu, 26 Feb 2026 04:44:45 -0500 (EST)
Message-ID: <343022ca4deda29affa70f399d238049078d8832.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: vDSO: Emit GNU_EH_FRAME correctly
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, WANG Rui <wangrui@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Zixing Liu <liushuyu@aosc.io>, "H . Peter
 Anvin" <hpa@zytor.com>, 	stable@vger.kernel.org, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>,  Menglong Dong <menglong8.dong@gmail.com>, Bibo Mao
 <maobibo@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>,  Hanlu Li
 <lihanlu@loongson.cn>, Nathan Chancellor <nathan@kernel.org>, Jiaxun Yang	
 <jiaxun.yang@flygoat.com>, Ard Biesheuvel <ardb@kernel.org>, Wentao Guan	
 <guanwentao@uniontech.com>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Thu, 26 Feb 2026 17:44:44 +0800
In-Reply-To: <CAAhV-H4pUw_OOSbQOLO5pZUmkYU1F0_13GAMzKmkzedBPdYOAA@mail.gmail.com>
References: <20260225104607.3803060-1-xry111@xry111.site>
	 <CAAhV-H4pUw_OOSbQOLO5pZUmkYU1F0_13GAMzKmkzedBPdYOAA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219783-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[xen0n.name,loongson.cn,aosc.io,zytor.com,vger.kernel.org,infradead.org,gmail.com,kernel.org,flygoat.com,uniontech.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[xry111.site:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,loongson.cn:email,xry111.site:mid,xry111.site:dkim,xry111.site:email]
X-Rspamd-Queue-Id: 6FAC81A3D2C
X-Rspamd-Action: no action

On Thu, 2026-02-26 at 17:22 +0800, Huacai Chen wrote:
> Hi, Ruoyao,
>=20
> On Wed, Feb 25, 2026 at 6:46=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wr=
ote:
> >=20
> > With -fno-asynchronous-unwind-tables and --no-eh-frame-hdr (the default
> > of the linker), the GNU_EH_FRAME segment (specified by vdso.lds.S) is
> > empty.=C2=A0 This is not valid, as the current DWARF specification mand=
ates
> > the first byte of the EH frame to be the version number 1.=C2=A0 It cau=
ses
> > some unwinders to complain, for example the ClickHouse query profiler
> > spams the log with messages:
> >=20
> > =C2=A0=C2=A0=C2=A0 clickhouse-server[365854]: libunwind: unsupported .e=
h_frame_hdr
> > =C2=A0=C2=A0=C2=A0 version: 127 at 7ffffffb0000
> >=20
> > Here "127" is just the byte located at the p_vaddr (0, i.e. the
> > beginning of the vDSO) of the empty GNU_EH_FRAME segment.
> > Cross-checking with /proc/365854/maps has also proven 7ffffffb0000 is
> > the start of vDSO in the process VM image.
> >=20
> > In LoongArch the -fno-asynchronous-unwind-tables option seems just a
> > MIPS legacy, and MIPS only uses this option to satisfy the MIPS-specifi=
c
> > "genvdso" program, per the commit cfd75c2db17e ("MIPS: VDSO: Explicitly
> > use -fno-asynchronous-unwind-tables").=C2=A0 IIUC it indicates some inh=
erent
> > limitation of the MIPS ELF ABI and has nothing to do with LoongArch.=C2=
=A0 So
> > we can simply flip it over to -fasynchronous-unwind-tables and pass
> > --eh-frame-hdr for linking the vDSO, allowing the profilers to unwind t=
he
> > stack for statistics even if the sample point is taken when the PC is i=
n
> > the vDSO.
> >=20
> > However simply adjusting the options above would exploit an issue: when
> > the libgcc unwinder saw the invalid GNU_EH_FRAME segment, it silently
> > falled back to a machine-specific routine to match the code pattern of
> > rt_sigreturn and extract the registers saved in the sigframe if the cod=
e
> > pattern is matched.=C2=A0 As unwinding from signal handlers is vital fo=
r
> > libgcc to support pthread cancellation etc., the fall-back routine had
> > been silently keeping the LoongArch Linux systems functioning since
> > Linux 5.19.=C2=A0 But when we start to emit GNU_EH_FRAME with the corre=
ct
> > format, fall-back routine will no longer be used and libgcc will fail
> > to unwind the sigframe, and unwinding from signal handlers will no
> > longer work, causing dozens of glibc test failures.=C2=A0 To make it po=
ssible
> > to unwind from signal handlers again, it's necessary to code the unwind
> > info in __vdso_rt_sigreturn via .cfi_* directives.
> >=20
> > The offsets in the .cfi_* directives depend on the layout of struct
> > sigframe, notably the offset of sigcontect in the sigframe.=C2=A0 To us=
e the
> > offset in the assembly file, factor out struct sigframe into a header t=
o
> > allow asm-offsets.c to output the offset for assembly.
> >=20
> > To work around a long-term issue in the libgcc unwinder (the pc is
> > unconditionally substracted by 1: doing so is technically incorrect for
> > a signal frame), a nop instruction is included with the two real
> > instructions in __vdso_rt_sigreturn in the same FDE PC range.=C2=A0 The=
 same
> > hack has been used on x86 for a long time.
> >=20
> > Fixes: c6b99bed6b8f ("LoongArch: Add VDSO and VSYSCALL support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > ---
> > =C2=A0arch/loongarch/include/asm/sigframe.h | 22 ++++++++++++++
> > =C2=A0arch/loongarch/kernel/asm-offsets.c=C2=A0=C2=A0 |=C2=A0 2 ++
> > =C2=A0arch/loongarch/kernel/signal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 6 +---
> > =C2=A0arch/loongarch/vdso/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +--
> > =C2=A0arch/loongarch/vdso/sigreturn.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 44 ++++++++++++++++++++++++---
> > =C2=A05 files changed, 67 insertions(+), 11 deletions(-)
> > =C2=A0create mode 100644 arch/loongarch/include/asm/sigframe.h
> >=20
> > diff --git a/arch/loongarch/include/asm/sigframe.h b/arch/loongarch/inc=
lude/asm/sigframe.h
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
> I think we don't need to copy so many lines here, they are enough in sign=
al.c.

Will remove them in V2.

> > +
> > +#include <uapi/asm/ucontext.h>
> Is it a requirement that the UAPI header should be the first?

I don't think so, and it seems the uapi/ component isn't needed here (as
Kbuild passes -Iarch/$(ARCH)/include/uapi).  I'd remove the uapi/
component and move it after siginfo.h following the alphabetical order.

> > +#include <asm/siginfo.h>

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * HACK: The dwarf2 unwind r=
outine will subtract 1 from the return
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * address to get an address=
 in the middle of the persumed call
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * instruction.=C2=A0 While =
in libgcc there exists a logic to avoid
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * subtracting 1 for the sig=
nal frame (a frame with the 'S'
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * augmentation that we've a=
lready added via .cfi_signal_frame),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * unfortunately it doesn't =
really work: the check of signal frame
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * is at libgcc/unwind-dw2:1=
008 in GCC 15.2.0, but the flag it
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * checks will only get upda=
ted by the extract_cie_info call at line
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 1025.=C2=A0 So include a =
nop before the real start to make up for it.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This is also the reason w=
e don't use SYM_FUNC_START.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nop
> This hack is out of my knowledge, can "nop" be after SYM_START()?

I guess we can do it if:

diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.=
c
index e297d54ea638..b2c7f5754818 100644
--- a/arch/loongarch/kernel/signal.c
+++ b/arch/loongarch/kernel/signal.c
@@ -1009,7 +1009,7 @@ static void handle_signal(struct ksignal *ksig, struc=
t pt_regs *regs)
=20
 	rseq_signal_deliver(ksig, regs);
=20
-	ret =3D setup_rt_frame(vdso + current->thread.vdso->offset_sigreturn, ksi=
g, regs, oldset);
+	ret =3D setup_rt_frame(vdso + current->thread.vdso->offset_sigreturn + 4,=
 ksig, regs, oldset);
=20
 	signal_setup_done(ret, ksig, 0);
 }

I.e. the FDE must include one instruction before what we set up as the
return address of the signal handler.  But I don't think this would be
prettier.
>=20

--=20
Xi Ruoyao <xry111@xry111.site>

