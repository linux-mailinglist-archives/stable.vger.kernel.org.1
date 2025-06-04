Return-Path: <stable+bounces-151425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C9CACE049
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 16:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C114D176D3C
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8D728F950;
	Wed,  4 Jun 2025 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="R+xeHyZt"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A2226863;
	Wed,  4 Jun 2025 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047469; cv=none; b=V267i9as7ub9LUQaUoLx9qh/CYqIm6dvkjjpg4S5HNiTdl0yN3+aqi434kEbmaTT5Gmjn0JFqrLL0RkZ50lDKe+KXo5MQcqGUsbs9BT5rRwHD7+dKOUrsKGW4SA3Z6BfUtYpztnsZpiv/GcU4VDHREgeyAlTPnK8H4YZiEWfY8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047469; c=relaxed/simple;
	bh=szGzg1VWdLNaQhzap8mRj1Cx9myok4IZd5/gZyF9eLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=czIUJzm5oBDF39E5vHrxhknAN0lbGz8cnTS/Y6OMvyJkZ/Xtg4xPDUtDrDmF/5p2qQzGZjDko9988tobkeEp8KdxNQnROozl+uQFt/BJIC+HDDPNJMWxpne+KyD1M5J1f3dNWdx1aQCLQlefcP+oPiU+uXGj9cbhM5bLQ0NSpqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=R+xeHyZt; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1749047460;
	bh=BN1yZiR+/rn2XlLp429yT8gjgjOJLYeI4IJXSvPwvg0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=R+xeHyZtmJ35nzniBZYxy1o5fen5ftCDTSL9p2CTl2fdc3BAmsCAoF+KqluKg1g0g
	 8mqtABzO3jFZwy1KO7ys+jf8BWDX2uYWUYsv6VuITEtHUm/mznuL383T01T2e44pHY
	 SJLxYop6m+LUrn4tGhxE/B1o9x68EgAPA/GHWxJg=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id AA7A865F62;
	Wed,  4 Jun 2025 10:30:57 -0400 (EDT)
Message-ID: <5a5329feaab84acb91bbb4f48ea548b3fb4eab0f.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: vDSO: correctly use asm parameters in
 syscall wrappers
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
	 <thomas.weissschuh@linutronix.de>
Cc: WANG Xuerui <kernel@xen0n.name>, Theodore Ts'o <tytso@mit.edu>, "Jason
 A. Donenfeld" <Jason@zx2c4.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers	 <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, 	loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 	stable@vger.kernel.org
Date: Wed, 04 Jun 2025 22:30:55 +0800
In-Reply-To: <CAAhV-H4Ba7DMV6AvGnvNBJ8FL_YcHjeeHYZWw2NG6JHL=X4PkQ@mail.gmail.com>
References: 
	<20250603-loongarch-vdso-syscall-v1-1-6d12d6dfbdd0@linutronix.de>
	 <CAAhV-H4Ba7DMV6AvGnvNBJ8FL_YcHjeeHYZWw2NG6JHL=X4PkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-04 at 22:05 +0800, Huacai Chen wrote:
> On Tue, Jun 3, 2025 at 7:49=E2=80=AFPM Thomas Wei=C3=9Fschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >=20
> > The syscall wrappers use the "a0" register for two different register
> > variables, both the first argument and the return value. The "ret"
> > variable is used as both input and output while the argument register i=
s
> > only used as input. Clang treats the conflicting input parameters as
> > undefined behaviour and optimizes away the argument assignment.
> >=20
> > The code seems to work by chance for the most part today but that may
> > change in the future. Specifically clock_gettime_fallback() fails with
> > clockids from 16 to 23, as implemented by the upcoming auxiliary clocks=
.
> >=20
> > Switch the "ret" register variable to a pure output, similar to the oth=
er
> > architectures' vDSO code. This works in both clang and GCC.
> Hmmm, at first the constraint is "=3Dr", during the progress of
> upstream, Xuerui suggested me to use "+r" instead [1].
> [1]=C2=A0 https://lore.kernel.org/linux-arch/5b14144a-9725-41db-7179-c059=
c41814cf@xen0n.name/

Based on the example at
https://gcc.gnu.org/onlinedocs/gcc/Local-Register-Variables.html:

   To force an operand into a register, create a local variable and specify
   the register name after the variable=E2=80=99s declaration. Then use the=
 local
   variable for the asm operand and specify any constraint letter that
   matches the register:
  =20
   register int *p1 asm ("r0") =3D =E2=80=A6;
   register int *p2 asm ("r1") =3D =E2=80=A6;
   register int *result asm ("r0");
   asm ("sysint" : "=3Dr" (result) : "0" (p1), "r" (p2));
  =20
I think this should actually be written

 	asm volatile(
 	"      syscall 0\n"
	: "=3Dr" (ret)
 	: "r" (nr), "0" (buffer), "r" (len), "r" (flags)
 	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
"$t8",
 	  "memory");

i.e. "=3D" should be used for the output operand 0, and "0" should be used
for the input operand 2 (buffer) to emphasis the same register as
operand 0 is used.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

