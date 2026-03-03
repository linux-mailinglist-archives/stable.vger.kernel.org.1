Return-Path: <stable+bounces-222838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PqmDQ2mpmkTSQAAu9opvQ
	(envelope-from <stable+bounces-222838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 10:12:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A13A01EBAF4
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 10:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C31A305AC99
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 09:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CB238C2DE;
	Tue,  3 Mar 2026 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="gTeoqOPh"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D772438C2C3;
	Tue,  3 Mar 2026 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772529140; cv=none; b=CLBNXcIB0LfGt6soLPZ+8KtQuEM+brH0Xj7wKOKUS2lcJ8pGRtw6P84Y8Ml1hiNbjFx91t4W23hm0y/kjei1+MDpV+iqjfzDEKFwWT/Rr/mPSAvkemJ1Zdwo87P/b5f/VNaUmGhWqcdAB6cg07Zpx2TSt3kof0bq9nFF/IYrE2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772529140; c=relaxed/simple;
	bh=W+k3tgk00XEusak3vneXCe8oDLrRoBUY7m8ARrYYqoo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vC1PEmfQ6Oa6VgnEgTgQLpQJmKcYhaRMN7OCMDDJ/+JTwq+HRmRnHBuIpaqgJKDlm5xDGkexgkuEGyieLjZ9UrKM9SKPzCCRZHLhT7/hxTSSmWbq2XTJ5bq0CvjdAiTFOcYdSeo3ApXFSOXWVafaxcMCcJYbyGSvhLvm3nVwfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=gTeoqOPh; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1772529133;
	bh=Qf5UX4CYvJ2qHksAOeFCAUgTdb8D6lnBU1KDdk2gENk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gTeoqOPhFEPr5gMQzb8CdiUheMZmm0TVPD7aw9PbacfuaaXroZy3nMTGh+hxUBrDU
	 ZEA98JHSFU3ZBpBwoSGLMj8I0Tp+g/GpK6ZcaL2ESTtNwVKWJdsj3+ZT2IUmd7lBTl
	 42MLy7M023AYLqrwLlyVXzGqMRO2+YtIascfmR6w=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id AFE1267061;
	Tue,  3 Mar 2026 04:12:05 -0500 (EST)
Message-ID: <809bd3ac6eba9db5fc28ba3360907e847018b88a.camel@xry111.site>
Subject: Re: [PATCH v3] LoongArch: vDSO: Emit GNU_EH_FRAME correctly
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Jinyang He <hejinyang@loongson.cn>, 
 WANG Rui <wangrui@loongson.cn>, Mingcong Bai <jeffbai@aosc.io>, Zixing Liu
 <liushuyu@aosc.io>, "H . Peter Anvin"	 <hpa@zytor.com>,
 stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,  Menglong
 Dong <menglong8.dong@gmail.com>, Bibo Mao <maobibo@loongson.cn>, Tiezhu
 Yang <yangtiezhu@loongson.cn>,  Hanlu Li <lihanlu@loongson.cn>, Nathan
 Chancellor <nathan@kernel.org>, Jiaxun Yang	 <jiaxun.yang@flygoat.com>, Ard
 Biesheuvel <ardb@kernel.org>, Wentao Guan	 <guanwentao@uniontech.com>,
 loongarch@lists.linux.dev, 	linux-kernel@vger.kernel.org
Date: Tue, 03 Mar 2026 17:12:02 +0800
In-Reply-To: <CAAhV-H4mk5f4RMspuwFtWpT775zwJMhiOy2W83jav5XZfg_L-A@mail.gmail.com>
References: <20260303083248.567185-1-xry111@xry111.site>
	 <CAAhV-H4mk5f4RMspuwFtWpT775zwJMhiOy2W83jav5XZfg_L-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A13A01EBAF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222838-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[xen0n.name,loongson.cn,aosc.io,zytor.com,vger.kernel.org,infradead.org,gmail.com,kernel.org,flygoat.com,uniontech.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[xry111.site:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,xry111.site:dkim,xry111.site:email,xry111.site:mid,gnu.org:url]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 16:54 +0800, Huacai Chen wrote:
> Hi, Ruoyao,
>=20
> On Tue, Mar 3, 2026 at 4:33=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wro=
te:
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
> > use -fno-asynchronous-unwind-tables").=C2=A0 IIRC it indicates some inh=
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
> >=20
> > Changes from [v2]:
> > - Wrap .cfi_* for signal trampoline in SYM_SIGFUNC_START.
> > - Remove comment lines in sigframe.h not so meaningful.
> >=20
> > Changes from [v1] to v2:
> > - Use DWARF column 0 instead of the libgcc-specific column 72.
> > - Style change to sigframe.h.
> >=20
> > [v1]: https://lore.kernel.org/20260225104607.3803060-1-xry111@xry111.si=
te
> >=20
> > =C2=A0arch/loongarch/include/asm/linkage.h=C2=A0 | 34 +++++++++++++++++=
++++++++++
> > =C2=A0arch/loongarch/include/asm/sigframe.h |=C2=A0 9 +++++++
> > =C2=A0arch/loongarch/kernel/asm-offsets.c=C2=A0=C2=A0 |=C2=A0 2 ++
> > =C2=A0arch/loongarch/kernel/signal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 6 +----
> > =C2=A0arch/loongarch/vdso/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> > =C2=A0arch/loongarch/vdso/sigreturn.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 10 +++-----
> > =C2=A06 files changed, 51 insertions(+), 14 deletions(-)
> > =C2=A0create mode 100644 arch/loongarch/include/asm/sigframe.h
> >=20
> > diff --git a/arch/loongarch/include/asm/linkage.h b/arch/loongarch/incl=
ude/asm/linkage.h
> > index e2eca1a25b4e..db465036385f 100644
> > --- a/arch/loongarch/include/asm/linkage.h
> > +++ b/arch/loongarch/include/asm/linkage.h
> > @@ -42,3 +42,37 @@
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SYM_END(name, SYM_T_NONE)
> >=20
> > =C2=A0#endif
> > +
> > +/*
> > + * This is for the signal handler trampoline, which is used as the ret=
urn
> > + * address of the signal handlers in userspace instead of called norma=
lly.
> > + * The long standing libgcc bug https://gcc.gnu.org/PR124050=C2=A0requ=
ires a
> > + * nop between .cfi_startproc and the actual address of the trampoline=
, so
> > + * we cannot simply use SYM_FUNC_START.
> > + *
> > + * This wrapper also contains all the .cfi_* directives for recovering
> > + * the content of the GPRs and the "return address" (where the rt_sigr=
eturn
> > + * syscall will jump to), assuming there is a struct rt_sigframe (wher=
e
> > + * a struct sigcontext containing those information we need to recover=
) at
> > + * $sp.=C2=A0 The "DWARF for the LoongArch(TM) Architecture" manual st=
ates
> > + * column 0 is for $zero, but it does not make too much sense to
> > + * save/restore the hardware zero register.=C2=A0 Repurpose this colum=
n here
> > + * for the return address (here it's not the content of $ra we cannot =
use
> > + * the default column 3).
> > + */
> > +#define SYM_SIGFUNC_START(name)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cfi_startproc;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cfi_signal_frame;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cfi_def_cfa 3, RT_SIGFRAME_SC;=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cfi_return_column 0;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cfi_offset 0, SC_PC;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .irp=C2=A0=C2=A0=C2=A0 num, 1, 2,=
 3, 4, 5, 6, 7, 8,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9, 10, 11, 12, 13, 14, 15, 16=
,=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 17, 18, 19, 20, 21, 22, 23, 2=
4,=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25, 26, 27, 28, 29, 30, 31;=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cfi_offset \num, SC_REGS + \num =
* SZREG;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .endr;=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nop;=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SYM_START(name, SYM_L_GLOBAL, SYM=
_A_ALIGN)
> > +
> > +#define SYM_SIGFUNC_END(name) SYM_FUNC_END(name)
> Why this block is out of #endif ?
>=20
> > diff --git a/arch/loongarch/include/asm/sigframe.h b/arch/loongarch/inc=
lude/asm/sigframe.h
> > new file mode 100644
> > index 000000000000..109298b8d7e0
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/sigframe.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +#include <asm/siginfo.h>
> > +#include <asm/ucontext.h>
> > +
> > +struct rt_sigframe {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct siginfo rs_info;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ucontext rs_uctx;
> > +};
> > diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kerne=
l/asm-offsets.c
> > index 3017c7157600..2cc953f113ac 100644
> > --- a/arch/loongarch/kernel/asm-offsets.c
> > +++ b/arch/loongarch/kernel/asm-offsets.c
> > @@ -16,6 +16,7 @@
> > =C2=A0#include <asm/ptrace.h>
> > =C2=A0#include <asm/processor.h>
> > =C2=A0#include <asm/ftrace.h>
> > +#include <asm/sigframe.h>
> > =C2=A0#include <vdso/datapage.h>
> >=20
> > =C2=A0static void __used output_ptreg_defines(void)
> > @@ -220,6 +221,7 @@ static void __used output_sc_defines(void)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 COMMENT("Linux sigcontext of=
fsets.");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OFFSET(SC_REGS, sigcontext, =
sc_regs);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OFFSET(SC_PC, sigcontext, sc=
_pc);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OFFSET(RT_SIGFRAME_SC, rt_sigfram=
e, rs_uctx.uc_mcontext);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLANK();
> > =C2=A0}
> >=20
> > diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/sig=
nal.c
> > index c9f7ca778364..e297d54ea638 100644
> > --- a/arch/loongarch/kernel/signal.c
> > +++ b/arch/loongarch/kernel/signal.c
> > @@ -37,6 +37,7 @@
> > =C2=A0#include <asm/lbt.h>
> > =C2=A0#include <asm/ucontext.h>
> > =C2=A0#include <asm/vdso.h>
> > +#include <asm/sigframe.h>
> >=20
> > =C2=A0#ifdef DEBUG_SIG
> > =C2=A0#=C2=A0 define DEBUGP(fmt, args...) printk("%s: " fmt, __func__, =
##args)
> > @@ -51,11 +52,6 @@
> > =C2=A0#define lock_lbt_owner()=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ({ p=
reempt_disable(); pagefault_disable(); })
> > =C2=A0#define unlock_lbt_owner()=C2=A0=C2=A0=C2=A0=C2=A0 ({ pagefault_e=
nable(); preempt_enable(); })
> >=20
> > -struct rt_sigframe {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct siginfo rs_info;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ucontext rs_uctx;
> > -};
> > -
> > =C2=A0struct _ctx_layout {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sctx_info *addr;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int size;
> > diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefil=
e
> > index 520f1513f07d..294c16b9517f 100644
> > --- a/arch/loongarch/vdso/Makefile
> > +++ b/arch/loongarch/vdso/Makefile
> > @@ -26,7 +26,7 @@ cflags-vdso :=3D $(ccflags-vdso) \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(filter -W%,$(filter-out -W=
a$(comma)%,$(KBUILD_CFLAGS))) \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -std=3Dgnu11 -fms-extensions=
 -O2 -g -fno-strict-aliasing -fno-common -fno-builtin \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -fno-stack-protector -fno-ju=
mp-tables -DDISABLE_BRANCH_PROFILING \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call cc-option, -fno-asynchrono=
us-unwind-tables) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call cc-option, -fasynchronous-=
unwind-tables) \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(call cc-option, -fno-stack=
-protector)
> > =C2=A0aflags-vdso :=3D $(ccflags-vdso) \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -D__ASSEMBLY__ -Wa,-gdwarf-2
> > @@ -41,7 +41,7 @@ endif
> >=20
> > =C2=A0# VDSO linker flags.
> > =C2=A0ldflags-y :=3D -Bsymbolic --no-undefined -soname=3Dlinux-vdso.so.=
1 \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(filter -E%,$(KBUILD_CFLAGS)) -s=
hared --build-id -T
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(filter -E%,$(KBUILD_CFLAGS)) -s=
hared --build-id --eh-frame-hdr -T
> >=20
> > =C2=A0#
> > =C2=A0# Shared build commands.
> > diff --git a/arch/loongarch/vdso/sigreturn.S b/arch/loongarch/vdso/sigr=
eturn.S
> > index 9cb3c58fad03..e40bf4186f29 100644
> > --- a/arch/loongarch/vdso/sigreturn.S
> > +++ b/arch/loongarch/vdso/sigreturn.S
> > @@ -12,13 +12,9 @@
> >=20
> > =C2=A0#include <asm/regdef.h>
> > =C2=A0#include <asm/asm.h>
> > +#include <asm/asm-offsets.h>
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .section=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .text
> Can we keep this line?

Oops, indeed this should be kept.  I'm unsure why I didn't see any issue
without it...

--=20
Xi Ruoyao <xry111@xry111.site>

