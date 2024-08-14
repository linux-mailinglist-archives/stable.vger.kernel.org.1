Return-Path: <stable+bounces-67611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF71951782
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 11:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B2C1F22DE9
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D030D13AA32;
	Wed, 14 Aug 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="alV95iKg"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A97E219EA
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723627123; cv=none; b=rfZpdzvA+enpCY0GWuHEuK4vLfPy79EWVCb7IN9jdO4V5w3OiQMxuHMj8asXW0iNvat5VOFuW69czu5KWB3y3n+o/jSIb57w7tE/lQzYz2Fap8X30wrbwZdQbtILIOnQARYyJRKtI2jOOgLVmAagrPBfmc2lKqkT5HHV5oBamRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723627123; c=relaxed/simple;
	bh=Y72mLsMFwAMZbmxekDOdlGRLPRIEOo+jEGCz2rl+T5o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ILDqgWYiVnP6oGKU3a9kOTiJBMz6qEEmETT4PG6JE37KDVfZN3ZOpKQAB2oIpWHjlaE8SNe7aQ8Z0RIrzFr/6ea5ZOxNgBWb1mJI8OTtjFTNAqjrbe9thY8RJObg33gizE5MknodCXjfgSIFxI1Zp+PLehwLCaYPQNJ4qf6pV/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=alV95iKg; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1723627114;
	bh=Y72mLsMFwAMZbmxekDOdlGRLPRIEOo+jEGCz2rl+T5o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=alV95iKgpzfeUXjsW45cCWTvGUUA74hMddzT02ULdFLcy5AIYjeWIfEZPSn2GnOAy
	 6ETT6SpOzpoasE3Ki4rPRSzLevDF7DrJR3BlLCYtQsm4+yg4CaobUoE1gJcAcwR7Nt
	 nwEu9p+9cjO4EnfrhVQQT2RUGvF+0QkQ8wmEZGSI=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 30E4366F26;
	Wed, 14 Aug 2024 05:18:31 -0400 (EDT)
Message-ID: <5aa26f6b0365ebf6b7e3c5b3d1c0a345b46431d3.camel@xry111.site>
Subject: Re: [PATCH for-stable] LoongArch: Define __ARCH_WANT_NEW_STAT in
 unistd.h
From: Xi Ruoyao <xry111@xry111.site>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Huacai Chen
	 <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, Sasha
 Levin <sashal@kernel.org>, stable@vger.kernel.org
Date: Wed, 14 Aug 2024 17:18:29 +0800
In-Reply-To: <2024081126-blubber-flaky-8219@gregkh>
References: 
	<CAAhV-H6vXEaJf9NO9Lqh0xKoFAehtOOOLQVO4j5v+_tD7oKEXQ@mail.gmail.com>
	 <20240730022542.3553255-1-chenhuacai@loongson.cn>
	 <2024073059-hamstring-verbalize-91df@gregkh>
	 <CAAhV-H7W-Ygn6tXySrip4k3P5xVbVf7GpjOzjXfQvCCbA4r5Wg@mail.gmail.com>
	 <2024081126-blubber-flaky-8219@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-08-11 at 17:42 +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 31, 2024 at 09:06:56AM +0800, Huacai Chen wrote:
> > On Tue, Jul 30, 2024 at 10:24=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >=20
> > > On Tue, Jul 30, 2024 at 10:25:42AM +0800, Huacai Chen wrote:
> > > > Chromium sandbox apparently wants to deny statx [1] so it could pro=
perly
> > > > inspect arguments after the sandboxed process later falls back to f=
stat.
> > > > Because there's currently not a "fd-only" version of statx, so that=
 the
> > > > sandbox has no way to ensure the path argument is empty without bei=
ng
> > > > able to peek into the sandboxed process's memory. For architectures=
 able
> > > > to do newfstatat though, glibc falls back to newfstatat after getti=
ng
> > > > -ENOSYS for statx, then the respective SIGSYS handler [2] takes car=
e of
> > > > inspecting the path argument, transforming allowed newfstatat's int=
o
> > > > fstat instead which is allowed and has the same type of return valu=
e.
> > > >=20
> > > > But, as LoongArch is the first architecture to not have fstat nor
> > > > newfstatat, the LoongArch glibc does not attempt falling back at al=
l
> > > > when it gets -ENOSYS for statx -- and you see the problem there!
> > > >=20
> > > > Actually, back when the LoongArch port was under review, people wer=
e
> > > > aware of the same problem with sandboxing clone3 [3], so clone was
> > > > eventually kept. Unfortunately it seemed at that time no one had no=
ticed
> > > > statx, so besides restoring fstat/newfstatat to LoongArch uapi (and
> > > > postponing the problem further), it seems inevitable that we would =
need
> > > > to tackle seccomp deep argument inspection.
> > > >=20
> > > > However, this is obviously a decision that shouldn't be taken light=
ly,
> > > > so we just restore fstat/newfstatat by defining __ARCH_WANT_NEW_STA=
T
> > > > in unistd.h. This is the simplest solution for now, and so we hope =
the
> > > > community will tackle the long-standing problem of seccomp deep arg=
ument
> > > > inspection in the future [4][5].
> > > >=20
> > > > More infomation please reading this thread [6].
> > > >=20
> > > > [1] https://chromium-review.googlesource.com/c/chromium/src/+/28231=
50
> > > > [2] https://chromium.googlesource.com/chromium/src/sandbox/+/c085b5=
1940bd/linux/seccomp-bpf-helpers/sigsys_handlers.cc#355
> > > > [3] https://lore.kernel.org/linux-arch/20220511211231.GG7074@bright=
rain.aerifal.cx/
> > > > [4] https://lwn.net/Articles/799557/
> > > > [5] https://lpc.events/event/4/contributions/560/attachments/397/64=
0/deep-arg-inspection.pdf
> > > > [6] https://lore.kernel.org/loongarch/20240226-granit-seilschaft-ec=
cc2433014d@brauner/T/#t
> > > >=20
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > > =C2=A0arch/loongarch/include/uapi/asm/unistd.h | 1 +
> > > > =C2=A01 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loonga=
rch/include/uapi/asm/unistd.h
> > > > index fcb668984f03..b344b1f91715 100644
> > > > --- a/arch/loongarch/include/uapi/asm/unistd.h
> > > > +++ b/arch/loongarch/include/uapi/asm/unistd.h
> > > > @@ -1,4 +1,5 @@
> > > > =C2=A0/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note *=
/
> > > > +#define __ARCH_WANT_NEW_STAT
> > > > =C2=A0#define __ARCH_WANT_SYS_CLONE
> > > > =C2=A0#define __ARCH_WANT_SYS_CLONE3
> > > >=20
> > > > --
> > > > 2.43.5
> > > >=20
> > > >=20
> > >=20
> > > What kernel branch(s) is this for?
> > For 6.1~6.10.
>=20
> What is the git id of this change in Linus's tree?

https://git.kernel.org/torvalds/c/7697a0fe0154


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

