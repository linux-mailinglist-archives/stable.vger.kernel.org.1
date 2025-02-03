Return-Path: <stable+bounces-112006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8AAA257C7
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 12:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711823A77E2
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33631202C2E;
	Mon,  3 Feb 2025 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="O1ZnTm4E"
X-Original-To: stable@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5CE202C2B;
	Mon,  3 Feb 2025 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580760; cv=none; b=Sxn1qFY2IhkaHZVm7UgSyo5AX5vwbjp7z7dDAQChQuBM6nKsxILS4fH+dyoLNtK3G6ADXjOwAG2XAw3USDcduHXfL/gF6POoN2Q6JRqL7WJpDWkVBASZWvBhLPJ58noBDT5dlsOR2KQGAW7MVjFPfpw2QxkAO4UTSZCOSGezc/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580760; c=relaxed/simple;
	bh=/otsI0o+yMwouI36jw7KVM05ZvmD3t3X3FrM8ryfZXc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QFYvNhGQVb0DKI2w/O86fVPb11JbkZK+HBKvdx2V8kGXwEzeKSnihaPxKfyM2oD84g6RMDXlxzp3P6SaM4Wi4Y4BDN6DTs//M6OEj7ehEHDIbas+WGoHG7bMoKDYRGskc3CzYhdwHzycw8sYKquCpJSezhP/MC7E2HWMSGXuHto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=O1ZnTm4E; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ndB87xolaXa1J3UitZAvUjBujJg2LO69M2RKaZY+Yow=; t=1738580757; x=1739185557; 
	b=O1ZnTm4EssP30VPVuKgzMv6RXU/O7HtsZZwfP3ZAW1xuenGTJImY83jDRjBCTnvjSj8I3adnGG4
	04RI7dOLtYnKnCcu2jnuhKBE4NGEzOOEkpS5iWSRxJUSG/rNRfi1WoxJ8kO4PXj22CbFhkaHeXaJF
	OxaJePvj/+QgYB6I7W2abeO1KTne85+6HMOVL/DlZleiplHfmJdzbcBZ4W6n7zZmYw0VFPnwsFEs3
	DZt/PsPlo5xTjx30h9/aLqQrfonhsbLGXc55l+SWAxhvc3vbaZ93ufRXRRfaZeswvaz1hc5/4eq2N
	lZfwyt7XG001xaqtPFNfEF0+jc0kMMaQAFNg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1teuH2-000000034gj-1a2M; Mon, 03 Feb 2025 12:05:52 +0100
Received: from p5dc55198.dip0.t-ipconnect.de ([93.197.81.152] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1teuH2-00000003ApG-0T7h; Mon, 03 Feb 2025 12:05:52 +0100
Message-ID: <1cd3e413a8d784655b692ad1ddd4adfd9705d529.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 0/4] alpha: stack fixes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ivan Kokshaysky <ink@unseen.parts>, Richard Henderson	
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Oleg
 Nesterov	 <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd
 Bergmann	 <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Magnus Lindholm
 <linmag7@gmail.com>, 	linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
Date: Mon, 03 Feb 2025 12:05:51 +0100
In-Reply-To: <6cb712c1c338d3ce5313e05a054ea9de21025ff0.camel@physik.fu-berlin.de>
References: <20250131104129.11052-1-ink@unseen.parts>
	 <6cb712c1c338d3ce5313e05a054ea9de21025ff0.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ivan,

On Sat, 2025-02-01 at 10:46 +0100, John Paul Adrian Glaubitz wrote:
> On Fri, 2025-01-31 at 11:41 +0100, Ivan Kokshaysky wrote:
> > This series fixes oopses on Alpha/SMP observed since kernel v6.9. [1]
> > Thanks to Magnus Lindholm for identifying that remarkably longstanding
> > bug.
> >=20
> > The problem is that GCC expects 16-byte alignment of the incoming stack
> > since early 2004, as Maciej found out [2]:
> >   Having actually dug speculatively I can see that the psABI was change=
d in
> >  GCC 3.5 with commit e5e10fb4a350 ("re PR target/14539 (128-bit long do=
uble
> >  improperly aligned)") back in Mar 2004, when the stack pointer alignme=
nt
> >  was increased from 8 bytes to 16 bytes, and arch/alpha/kernel/entry.S =
has
> >  various suspicious stack pointer adjustments, starting with SP_OFF whi=
ch
> >  is not a whole multiple of 16.
> >=20
> > Also, as Magnus noted, "ALPHA Calling Standard" [3] required the same:
> >  D.3.1 Stack Alignment
> >   This standard requires that stacks be octaword aligned at the time a
> >   new procedure is invoked.
> >=20
> > However:
> > - the "normal" kernel stack is always misaligned by 8 bytes, thanks to
> >   the odd number of 64-bit words in 'struct pt_regs', which is the very
> >   first thing pushed onto the kernel thread stack;
> > - syscall, fault, interrupt etc. handlers may, or may not, receive alig=
ned
> >   stack depending on numerous factors.
> >=20
> > Somehow we got away with it until recently, when we ended up with
> > a stack corruption in kernel/smp.c:smp_call_function_single() due to
> > its use of 32-byte aligned local data and the compiler doing clever
> > things allocating it on the stack.
> >=20
> > Patches 1-2 are preparatory; 3 - the main fix; 4 - fixes remaining
> > special cases.
> >=20
> > Ivan.
> >=20
> > [1] https://lore.kernel.org/rcu/CA+=3DFv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=
=3DEi90G98ukRcRJA@mail.gmail.com/#r
> > [2] https://lore.kernel.org/rcu/alpine.DEB.2.21.2501130248010.18889@ang=
ie.orcam.me.uk/
> > [3] https://bitsavers.org/pdf/dec/alpha/Alpha_Calling_Standard_Rev_2.0_=
19900427.pdf
> > ---
> > Changes in v2:
> > - patch #1: provide empty 'struct pt_regs' to fix compile failure in li=
bbpf,
> >   reported by John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>;
> >   update comment and commit message accordingly;
> > - cc'ed <stable@vger.kernel.org> as older kernels ought to be fixed as =
well.
> > ---
> > Ivan Kokshaysky (4):
> >   alpha/uapi: do not expose kernel-only stack frame structures
> >   alpha: replace hardcoded stack offsets with autogenerated ones
> >   alpha: make stack 16-byte aligned (most cases)
> >   alpha: align stack for page fault and user unaligned trap handlers
> >=20
> >  arch/alpha/include/asm/ptrace.h      | 64 ++++++++++++++++++++++++++-
> >  arch/alpha/include/uapi/asm/ptrace.h | 65 ++--------------------------
> >  arch/alpha/kernel/asm-offsets.c      |  4 ++
> >  arch/alpha/kernel/entry.S            | 24 +++++-----
> >  arch/alpha/kernel/traps.c            |  2 +-
> >  arch/alpha/mm/fault.c                |  4 +-
> >  6 files changed, 83 insertions(+), 80 deletions(-)
>=20
> Thanks, I'm testing the v2 series of the patches now.

I have applied the series, but I am seeing gcc crashes from time to time:

/build/reproducible-path/palapeli-24.12.1/obj-alpha-linux-gnu/mime/palathum=
bcreator_autogen/include/thumbnail-creator.moc: In function =E2=80=98QObjec=
t* qt_plugin_instance()=E2=80=99:
/build/reproducible-path/palapeli-24.12.1/obj-alpha-linux-gnu/mime/palathum=
bcreator_autogen/include/thumbnail-creator.moc:328:1: error: unrecognizable=
 insn:
  328 | QT_MOC_EXPORT_PLUGIN_V2(palathumbcreator_factory, palathumbcreator_=
factory, qt_pluginMetaDataV2_palathumbcreator_factory)
      | ^~~~~~~~~~~~~~~~~~~~~~~
(jump_insn 331 295 332 3 (set (pc)
        (address:DI 1)) -1
     (nil)
 -> 40)
during RTL pass: sched1
/build/reproducible-path/palapeli-24.12.1/obj-alpha-linux-gnu/mime/palathum=
bcreator_autogen/include/thumbnail-creator.moc:328:1: internal compiler err=
or: in extract_insn, at recog.cc:2812
0x12195fc8b internal_error(char const*, ...)
	???:0
0x1201f37b7 fancy_abort(char const*, int, char const*)
	???:0
0x1201f0a6f _fatal_insn(char const*, rtx_def const*, char const*, int, char=
 const*)
	???:0
0x1201f0ab7 _fatal_insn_not_found(rtx_def const*, char const*, int, char co=
nst*)
	???:0
0x120b5ff97 extract_insn(rtx_insn*)
	???:0
0x12179d003 deps_analyze_insn(deps_desc*, rtx_insn*)
	???:0
0x12179d98f sched_analyze(deps_desc*, rtx_insn*, rtx_insn*)
	???:0
0x120bb0517 sched_rgn_compute_dependencies(int)
	???:0
Please submit a full bug report, with preprocessed source (by using -frepor=
t-bug).
Please include the complete backtrace with any bug report.
See <file:///usr/share/doc/gcc-14/README.Bugs> for instructions.
The bug is not reproducible, so it is likely a hardware or OS problem.

See: https://buildd.debian.org/status/fetch.php?pkg=3Dpalapeli&arch=3Dalpha=
&ver=3D4%3A24.12.1-1&stamp=3D1738215920&raw=3D0

But this might be related to CONFIG_COMPACTION as Michael Cree already ment=
ioned
as this option is enabled in Debian by default on all architectures except =
for
m68k.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

