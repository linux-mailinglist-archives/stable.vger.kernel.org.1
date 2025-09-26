Return-Path: <stable+bounces-181782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B90BA4C30
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 19:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF9C3A817D
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CB326A087;
	Fri, 26 Sep 2025 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="LxrrZ70p"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E23B7A8;
	Fri, 26 Sep 2025 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758906961; cv=none; b=QLj5DorwobNW5G3AKbI7CDo46K5LTtz2EizQj0JhnJEZkTrzFu5F7uyhRNbSer7BjfOzMMFBCVPX4hwOCzXhO46N8TIB9Rj5xvuy4h2jx6H7BNSx2+ra0J1rj1KRschKkmwiX0B7VMzrGkxiAYkRBGxH673o1EvJI9Gi/J8LlXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758906961; c=relaxed/simple;
	bh=9s1JWYLtY9Au2cU7gKvf1tWMFDr3WPsmVd7i7+W3bdA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YrQhTcwQtuOjOCwDGkEmLmHpcXhHiC9UednqGUwpSC3GTG6yZ5neR1jDqLzbeqSPOMG8kZI2v0fWW/4wOWrjqmbhjg99KXYT5RR+LFzGoxSW9TdjE2VXqKHsi6cphFZndLH+iclA0uX5bVAyQRRyByB2w+a2C4MY/CrKisstlkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=LxrrZ70p; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1758906952;
	bh=9s1JWYLtY9Au2cU7gKvf1tWMFDr3WPsmVd7i7+W3bdA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LxrrZ70p5KBrbuEn9rhlI5K7pEJeScDXhXKQIG3UYcU+P5QE8OLrSmJhO37NEJPb9
	 MeKVb7TL05aMrnFLYBhOGbRcxHnQiYJQB92eaTJABKnUhYOylbGydCVNJS8L0uogvR
	 FUEUwA8lszOSiTAQekw74WUaDmZyWVgxverS4hHY=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 24C5A66B3B;
	Fri, 26 Sep 2025 13:15:48 -0400 (EDT)
Message-ID: <c1f9e36dbdff64298ed2c6418247fb37dcd1f986.camel@xry111.site>
Subject: Re: [PATCH V2] LoongArch: Align ACPI structures if
 ARCH_STRICT_ALIGN enabled
From: Xi Ruoyao <xry111@xry111.site>
To: Guenter Roeck <linux@roeck-us.net>, Huacai Chen <chenhuacai@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Huacai Chen
 <chenhuacai@loongson.cn>, 	loongarch@lists.linux.dev, Xuefeng Li
 <lixuefeng@loongson.cn>, Guo Ren	 <guoren@kernel.org>, Xuerui Wang
 <kernel@xen0n.name>, Jiaxun Yang	 <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,  Binbin Zhou
 <zhoubinbin@loongson.cn>
Date: Sat, 27 Sep 2025 01:15:47 +0800
In-Reply-To: <899f2dec-e8b9-44f4-ab8d-001e160a2aed@roeck-us.net>
References: <20250910091033.725716-1-chenhuacai@loongson.cn>
	 <20250920234836.GA3857420@ax162>
	 <CAAhV-H5S8VKKBkNyrWfeuCVv8jS6tNED6YNeAD=i-+wkaoRSDQ@mail.gmail.com>
	 <899f2dec-e8b9-44f4-ab8d-001e160a2aed@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-26 at 07:31 -0700, Guenter Roeck wrote:
> On Sun, Sep 21, 2025 at 09:07:38AM +0800, Huacai Chen wrote:
> > Hi, Nathan,
> >=20
> > On Sun, Sep 21, 2025 at 7:48=E2=80=AFAM Nathan Chancellor <nathan@kerne=
l.org> wrote:
> > >=20
> > > Hi Huacai,
> > >=20
> > > On Wed, Sep 10, 2025 at 05:10:33PM +0800, Huacai Chen wrote:
> > > > ARCH_STRICT_ALIGN is used for hardware without UAL, now it only con=
trol
> > > > the -mstrict-align flag. However, ACPI structures are packed by def=
ault
> > > > so will cause unaligned accesses.
> > > >=20
> > > > To avoid this, define ACPI_MISALIGNMENT_NOT_SUPPORTED in asm/acenv.=
h to
> > > > align ACPI structures if ARCH_STRICT_ALIGN enabled.
> > > >=20
> > > > Cc: stable@vger.kernel.org
> > > > Reported-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > > > Suggested-by: Xi Ruoyao <xry111@xry111.site>
> > > > Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > > V2: Modify asm/acenv.h instead of Makefile.
> > > >=20
> > > > =C2=A0arch/loongarch/include/asm/acenv.h | 7 +++----
> > > > =C2=A01 file changed, 3 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/arch/loongarch/include/asm/acenv.h b/arch/loongarch/in=
clude/asm/acenv.h
> > > > index 52f298f7293b..483c955f2ae5 100644
> > > > --- a/arch/loongarch/include/asm/acenv.h
> > > > +++ b/arch/loongarch/include/asm/acenv.h
> > > > @@ -10,9 +10,8 @@
> > > > =C2=A0#ifndef _ASM_LOONGARCH_ACENV_H
> > > > =C2=A0#define _ASM_LOONGARCH_ACENV_H
> > > >=20
> > > > -/*
> > > > - * This header is required by ACPI core, but we have nothing to fi=
ll in
> > > > - * right now. Will be updated later when needed.
> > > > - */
> > > > +#ifdef CONFIG_ARCH_STRICT_ALIGN
> > > > +#define ACPI_MISALIGNMENT_NOT_SUPPORTED
> > > > +#endif /* CONFIG_ARCH_STRICT_ALIGN */
> > > >=20
> > > > =C2=A0#endif /* _ASM_LOONGARCH_ACENV_H */
> > >=20
> > > I am seeing several ACPI errors in my QEMU testing after this change =
in
> > > Linus's tree as commit a9d13433fe17 ("LoongArch: Align ACPI structure=
s
> > > if ARCH_STRICT_ALIGN enabled").
> > >=20
> > > =C2=A0 $ make -skj"$(nproc)" ARCH=3Dloongarch CROSS_COMPILE=3Dloongar=
ch64-linux- clean defconfig vmlinuz.efi
> > > =C2=A0 kernel/sched/fair.o: warning: objtool: sched_update_scaling() =
falls through to next function init_entity_runnable_average()
> > > =C2=A0 mm/mempolicy.o: warning: objtool: alloc_pages_bulk_mempolicy_n=
oprof+0x380: stack state mismatch: reg1[30]=3D-1+0 reg2[30]=3D-2-80
> > > =C2=A0 lib/crypto/mpi/mpih-div.o: warning: objtool: mpihelp_divrem+0x=
2d0: stack state mismatch: reg1[22]=3D-1+0 reg2[22]=3D-2-16
> > > =C2=A0 In file included from include/acpi/acpi.h:24,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from drivers/acpi/acpica/tbprint.c:=
10:
> > > =C2=A0 drivers/acpi/acpica/tbprint.c: In function 'acpi_tb_print_tabl=
e_header':
> > > =C2=A0 include/acpi/actypes.h:530:43: warning: 'strncmp' argument 1 d=
eclared attribute 'nonstring' is smaller than the specified bound 8 [-Wstri=
ngop-overread]
> > > =C2=A0=C2=A0=C2=A0 530 | #define ACPI_VALIDATE_RSDP_SIG(a)=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_=
RSDP, (sizeof(a) < 8) ? ACPI_NAMESEG_SIZE : 8))
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~
> > > =C2=A0 drivers/acpi/acpica/tbprint.c:105:20: note: in expansion of ma=
cro 'ACPI_VALIDATE_RSDP_SIG'
> > > =C2=A0=C2=A0=C2=A0 105 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } else if (ACPI_VALIDATE_RSDP_SIG(ACPI_CAST_PTR(struct acpi_table_rsdp,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~
> > > =C2=A0 In file included from include/acpi/acpi.h:26:
> > > =C2=A0 include/acpi/actbl.h:69:14: note: argument 'signature' declare=
d here
> > > =C2=A0=C2=A0=C2=A0=C2=A0 69 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 char signature[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* ASCII table signature */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~
> > > From this link this seems a comiler issue (at least not an
> > arch-specific kernel issue):
> > https://github.com/AOSC-Tracking/linux/commit/1e9ee413357ef58dd902f6ec5=
5013d2a2f2043eb
> >=20
>=20
> I see that the patch made it into the upstream kernel, now breaking both
> mainline and 6.16.y test builds of loongarch64:allmodconfig with gcc.
>=20
> Since this is apparently intentional, I'll stop build testing
> loongarch64:allmodconfig. So far it looks like my qemu tests
> are not affected, so I'll continue testing those for the time being.

See=C2=A0https://gcc.gnu.org/PR122073 and
https://github.com/acpica/acpica/pull/1050.


--=20
Xi Ruoyao <xry111@xry111.site>

