Return-Path: <stable+bounces-169707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DB7B27BB6
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 10:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C11188DB3A
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 08:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EC424E016;
	Fri, 15 Aug 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbW+Lki5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3F01519B4;
	Fri, 15 Aug 2025 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247847; cv=none; b=DoYcf+R5wbjUkhecKbwcmmP8GFlUtIFuHTRRl+5C+1lFSMLe1M5TBDu3iHnL5+UpCopfX9B+rFPoey1rATTp3E45gRN11gqvDwEgcxsTHSmp/4TzixQu2ZGDuXRhah18+l+/geMgYVJ98Eiy0xe8PsWEloqXUAYGhNG69bGMfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247847; c=relaxed/simple;
	bh=tFZ3dQRjUlI5OEsCU7Ae9mW17LHD+V/Wk9uO9K/WBhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQ8Qia8Oi00E2wYChL2N5VlT5SPQVGR5SipYIMlLXaw569ol/sLhpykHHweEySR8BxSW4YMwN5ZXNAtxKSQ9MUzWmzKYdXskDFbHI15P4P3KPiRPh7eX/3GPrUio5eEsHY8KrhsllPA1G0Jswp8ftjUpEauUgnbl6f2bB1fMZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbW+Lki5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AF8C4CEF7;
	Fri, 15 Aug 2025 08:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755247847;
	bh=tFZ3dQRjUlI5OEsCU7Ae9mW17LHD+V/Wk9uO9K/WBhY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PbW+Lki5GdtgPRWk6KJHakW5fq3skKRHg3Tjd7HfkKceyASIol5k3IhD8AgRZzUWx
	 1JuJgF27o3H3SOLmxi8Pa7TJgus526rKsrRxulrOkoYwSpaY4WqmV1j7/7fCv/USMN
	 M4UhPKa0JR6Pk24SqUvJn/VO/MdeoLIk3aPUmbdFZZufY6FGJMxiGCKZsDQONWhO+p
	 p2Y7O0l8J+4aawypmZTvTmzWslQ//IaMoWp2l5Tm1Qwi9LhoXAL9JDgVDwRuJVq4Xe
	 uo9CWt9/ofd5UzuzeE+PXzRWwsL0Q8aZ5XY0nhFUmp5G6OybZgjCBmVgD+b/Ox4Jjn
	 mPfdQ/Qt+1Evg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6188b5ae1e8so1879646a12.0;
        Fri, 15 Aug 2025 01:50:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1So165iKPOrtG6QbGV10jTXISfEQybZEAiLaQ8ntuh8Z6UKPGscaru59G4nCiLWPMYslt5p3S@vger.kernel.org, AJvYcCW087WfE4Tf5D7lAdWm7twollmz9Cl78FVdVPJc9noMTlZiwEEzWOmMVkKL8lbUUJKVSZ3ai0lkkopuDno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyojF06PxiZT7NAxy3x5ZY6Gsp+x4Ovh11N/6aHny65SP1Fhcy5
	nBTtIwRT2EqAy9W1GT3NKww6xPC5i5U+LF7cllQqqzTvCkKpY21DBJi4KaifsTqNKdOz8IRxNgs
	4vrpw8BikS7qUFpnpv+9rIHv5ZpRg9Bg=
X-Google-Smtp-Source: AGHT+IHGCpf4wRlB5ShJISeqNfHm1ljWIRp3fTE5KL5hhOU/yg6wagjRCoeo9Wgjye7juXOhgtVcmtt1IGZWWoeFvbE=
X-Received: by 2002:a05:6402:51ca:b0:618:aea9:725b with SMTP id
 4fb4d7f45d1cf-618b050d1f4mr851259a12.6.1755247845748; Fri, 15 Aug 2025
 01:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721101343.3283480-1-chenhuacai@loongson.cn> <20250811185635.f51ddda72f36bc0c2ba20600@linux-foundation.org>
In-Reply-To: <20250811185635.f51ddda72f36bc0c2ba20600@linux-foundation.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 15 Aug 2025 16:50:34 +0800
X-Gmail-Original-Message-ID: <CAAhV-H60uwMpuwOi1Jb0sgQO5oE=5AioMONAt3MtGTWzgm6uyw@mail.gmail.com>
X-Gm-Features: Ac12FXxMi_qLVWq4FNkYvA5_28kW1mRomx7voeDtiMJFOvKVKYCDp8Jp6A_eE9Q
Message-ID: <CAAhV-H60uwMpuwOi1Jb0sgQO5oE=5AioMONAt3MtGTWzgm6uyw@mail.gmail.com>
Subject: Re: [PATCH V3] init: Handle bootloader identifier in kernel parameters
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, linux-mm@kvack.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 9:56=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 21 Jul 2025 18:13:43 +0800 Huacai Chen <chenhuacai@loongson.cn> w=
rote:
>
> > BootLoader (Grub, LILO, etc) may pass an identifier such as "BOOT_IMAGE=
=3D
> > /boot/vmlinuz-x.y.z" to kernel parameters. But these identifiers are no=
t
> > recognized by the kernel itself so will be passed to user space. Howeve=
r
> > user space init program also doesn't recognized it.
> >
> > KEXEC/KDUMP (kexec-tools) may also pass an identifier such as "kexec" o=
n
> > some architectures.
> >
> > We cannot change BootLoader's behavior, because this behavior exists fo=
r
> > many years, and there are already user space programs search BOOT_IMAGE=
=3D
> > in /proc/cmdline to obtain the kernel image locations:
> >
> > https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/util.go
> > (search getBootOptions)
> > https://github.com/linuxdeepin/deepin-ab-recovery/blob/master/main.go
> > (search getKernelReleaseWithBootOption)
> >
> > So the the best way is handle (ignore) it by the kernel itself, which
> > can avoid such boot warnings (if we use something like init=3D/bin/bash=
,
> > bootloader identifier can even cause a crash):
> >
> > Kernel command line: BOOT_IMAGE=3D(hd0,1)/vmlinuz-6.x root=3D/dev/sda3 =
ro console=3Dtty
> > Unknown kernel command line parameters "BOOT_IMAGE=3D(hd0,1)/vmlinuz-6.=
x", will be passed to user space.
> >
> > Cc: stable@vger.kernel.org
>
> I think I'll keep this in -next until 6.18-rc1 - I suspect any issues
> here will take a while to discover.
>
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -545,6 +545,12 @@ static int __init unknown_bootoption(char *param, =
char *val,
> >                                    const char *unused, void *arg)
> >  {
> >       size_t len =3D strlen(param);
> > +     /*
> > +      * Well-known bootloader identifiers:
> > +      * 1. LILO/Grub pass "BOOT_IMAGE=3D...";
> > +      * 2. kexec/kdump (kexec-tools) pass "kexec".
> > +      */
> > +     const char *bootloader[] =3D { "BOOT_IMAGE=3D", "kexec", NULL };
> >
> >       /* Handle params aliased to sysctls */
> >       if (sysctl_is_alias(param))
> > @@ -552,6 +558,12 @@ static int __init unknown_bootoption(char *param, =
char *val,
> >
> >       repair_env_string(param, val);
> >
> > +     /* Handle bootloader identifier */
> > +     for (int i =3D 0; bootloader[i]; i++) {
> > +             if (!strncmp(param, bootloader[i], strlen(bootloader[i]))=
)
> > +                     return 0;
> > +     }
>
> We have str_has_prefix().
>
> And strstarts()!  Both of which are awfully similar and both of which
> lamely do two passes across a string.
OK, I will send V4 with strstarts().

Huacai

