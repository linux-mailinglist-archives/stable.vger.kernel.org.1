Return-Path: <stable+bounces-151601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 115A1ACFEF5
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 11:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA7F189780E
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 09:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A1C286412;
	Fri,  6 Jun 2025 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="N6bY10+K"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E3D283FFB;
	Fri,  6 Jun 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749201240; cv=none; b=YmXO+74h4EK4/FwTGQpV63mQ/NRLqF8dz2pZF6PS/WlAae3iJJKgdwwSk43so2PNO1YqXxgJDvXA0UZ4hxYiAF0akQivRG8FQL9dS6k0mYTVRoEbzOdpQpCYLlkfVGOTSoPSMuFhMgrUHxMPbP4/NYX6+5UO/marujLBX0j4w08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749201240; c=relaxed/simple;
	bh=8AzNZ4la2PoPmxTh0qvOadpjPianLkUkYxBsjSoIfoM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gGLJrZExG0Nm667rcKVwUfZjCbRlX4B/5kdf+qZ0g3Za3W2SXKW7WoSnyjLHDuX/y9alqX8zeIEzh7i2Voe22hhBdeEjyQH78xkduTQ2IQ+iuhaw3kIPXIJUbICKaIUN7yJBex+RJkLPAdJJJPjIHi3+rYIiHVPxR2OK5AJJg0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=N6bY10+K; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1749201229;
	bh=HQ4lHEPmIHw9cneR2PlF0QPtXcQfPGIV8GSmE9YMTkU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=N6bY10+Kk0WxoqAfmlihmF2xdiA8O9584b5lKeU3vxuVh5CokRiOc+fFAC6Dzdp7U
	 84izpGR5FOAvvpndZozSMK5woPm8xNFVJQBQ2kTr1h7kOl9jkYpMyRKBfFwlvuXzTt
	 xwSWTgYrBRbErFjHPYLfcDTm+hjHKmNBAkkvdYok=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id F10D865992;
	Fri,  6 Jun 2025 05:13:46 -0400 (EDT)
Message-ID: <06e4746ade602f42907aed82c16826230a8ff80e.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: vDSO: correctly use asm parameters in
 syscall wrappers
From: Xi Ruoyao <xry111@xry111.site>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Theodore Ts'o	 <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Nathan Chancellor	 <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>,  Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, 	loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 	stable@vger.kernel.org
Date: Fri, 06 Jun 2025 17:13:45 +0800
In-Reply-To: <20250605092735-bd76e803-e896-4d4c-a1f1-c30f8d321a9a@linutronix.de>
References: 
	<20250603-loongarch-vdso-syscall-v1-1-6d12d6dfbdd0@linutronix.de>
	 <CAAhV-H4Ba7DMV6AvGnvNBJ8FL_YcHjeeHYZWw2NG6JHL=X4PkQ@mail.gmail.com>
	 <5a5329feaab84acb91bbb4f48ea548b3fb4eab0f.camel@xry111.site>
	 <20250605092735-bd76e803-e896-4d4c-a1f1-c30f8d321a9a@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-05 at 09:37 +0200, Thomas Wei=C3=9Fschuh wrote:
> On Wed, Jun 04, 2025 at 10:30:55PM +0800, Xi Ruoyao wrote:
> > On Wed, 2025-06-04 at 22:05 +0800, Huacai Chen wrote:
> > > On Tue, Jun 3, 2025 at 7:49=E2=80=AFPM Thomas Wei=C3=9Fschuh
> > > <thomas.weissschuh@linutronix.de> wrote:
> > > >=20
> > > > The syscall wrappers use the "a0" register for two different regist=
er
> > > > variables, both the first argument and the return value. The "ret"
> > > > variable is used as both input and output while the argument regist=
er is
> > > > only used as input. Clang treats the conflicting input parameters a=
s
> > > > undefined behaviour and optimizes away the argument assignment.
> > > >=20
> > > > The code seems to work by chance for the most part today but that m=
ay
> > > > change in the future. Specifically clock_gettime_fallback() fails w=
ith
> > > > clockids from 16 to 23, as implemented by the upcoming auxiliary cl=
ocks.
> > > >=20
> > > > Switch the "ret" register variable to a pure output, similar to the=
 other
> > > > architectures' vDSO code. This works in both clang and GCC.
> > > Hmmm, at first the constraint is "=3Dr", during the progress of
> > > upstream, Xuerui suggested me to use "+r" instead [1].
> > > [1]=C2=A0 https://lore.kernel.org/linux-arch/5b14144a-9725-41db-7179-=
c059c41814cf@xen0n.name/
> >=20
> > Based on the example at
> > https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html:
> >=20
> > =C2=A0=C2=A0 To force an operand into a register, create a local variab=
le and specify
> > =C2=A0=C2=A0 the register name after the variable=E2=80=99s declaration=
. Then use the local
> > =C2=A0=C2=A0 variable for the asm operand and specify any constraint le=
tter that
> > =C2=A0=C2=A0 matches the register:
> > =C2=A0=C2=A0=20
> > =C2=A0=C2=A0 register int *p1 asm ("r0") =3D =E2=80=A6;
> > =C2=A0=C2=A0 register int *p2 asm ("r1") =3D =E2=80=A6;
> > =C2=A0=C2=A0 register int *result asm ("r0");
> > =C2=A0=C2=A0 asm ("sysint" : "=3Dr" (result) : "0" (p1), "r" (p2));
> > =C2=A0=C2=A0=20
> > I think this should actually be written
> >=20
> > =C2=A0	asm volatile(
> > =C2=A0	"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syscall 0\n"
> > 	: "=3Dr" (ret)
> > =C2=A0	: "r" (nr), "0" (buffer), "r" (len), "r" (flags)
> > =C2=A0	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
> > "$t8",
> > =C2=A0	=C2=A0 "memory");
> >=20
> > i.e. "=3D" should be used for the output operand 0, and "0" should be u=
sed
> > for the input operand 2 (buffer) to emphasis the same register as
> > operand 0 is used.
>=20
> I would have expected that matching constraints ("0") would only really m=
ake
> sense if the compiler selects the specific register to use. When the regi=
ster is
> already selected manually it seems redundant.
> But my inline ASM knowledge is limited and this is a real example from th=
e GCC
> docs, so it is probably more correct.
> On the other hand all the other vDSO implementations use "r" over "0" for=
 the
> input operand 2 and I'd like to keep them consistent.

Per https://gcc.gnu.org/pipermail/gcc-help/2025-June/144261.html and
https://gcc.gnu.org/pipermail/gcc-help/2025-June/144266.html it should
be fine to just use "r".

Reviewed-by: Xi Ruoyao <xry111@xry111.site>

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

