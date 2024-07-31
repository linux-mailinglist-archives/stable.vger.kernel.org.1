Return-Path: <stable+bounces-64690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DC794240C
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 03:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 724F1B212CC
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 01:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622A9539A;
	Wed, 31 Jul 2024 01:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pK82qb4+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292D748F
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 01:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722388031; cv=none; b=G3PJ/c5EEpSJMTZCStzQu/rSYxzveDK4gSxSdrll8wrsUD/h9D25L4hgJuGR+udI+Fa4C2wj/yeToFt1hdNPswHIuelgRSsXzg0alRUVrYxUJ0HTv0rSrG7AgIlJ9yHh+Bnfd8x8A22b+MD7czAiBUrKxN8pD9J9msfYoDJPpjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722388031; c=relaxed/simple;
	bh=3cf8/IH5fWGwrqkVCPFgrihHd1rSTimzC3dmsm9znkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ugv1zdhUjk4bTgkf4BIOFN4zx2uk3VOKkeGMi45FY++QebteuSDrhjDNDRfzmM/aOOta/CpW9KEciHU2wj2GRqg/Tf19wY/NLpeJOAC6WPAu0FyRM+LQuvqfJa8LMA0dltr1B1QaI8Ek6Iz7pu0C+EhvO1G1S707km2m4l94BuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pK82qb4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0262DC4AF10
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 01:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722388031;
	bh=3cf8/IH5fWGwrqkVCPFgrihHd1rSTimzC3dmsm9znkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pK82qb4+X0CMgaEwSP4x5isZABEyB4Z1c1geeAeCuXYocoqO0QdNb/qnTV/zGA7dc
	 4nED0J+iaqLk2eQtRDK1jYroUNsGcHi1llhkcGmcF2OsHsZXDy9CiohnRCCD6Nmt+p
	 DWXop6VOoaaVUUl6FiKYkjGDgyTy0CZcJvByn2P2iHWrEOkjyF8RSGt6lx0gVBmKBK
	 fNmvwXUde/9gAxkJHcbs6Kgxd08EmHQbRbuAzI/3a4XNO7Hfzes6nOfNgFoRP8qgWl
	 vnU9v2Vm2FbSvnSuvq38MGVXBDyDFpPcl4CE0oxBQSJRStOZHAvjMMpAQtFQkAuhcc
	 hB5dILHREI2SQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ed9b802ceso6393118e87.3
        for <stable@vger.kernel.org>; Tue, 30 Jul 2024 18:07:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVw2b0mFQXsP5BsN1s39MSyK/JpKjYFoMQYqNykUjNpTTcWg3zlxlI+t1Jx4L8Yvoi7eKsftDrF8wfFbVV3g85WO6JcVvEa
X-Gm-Message-State: AOJu0Yz/qqKCXNqktZ8/7T2IZ9t7KoSPKAppGA9jSSawR7sh3RqLFQdl
	E/ghxi9EGl/H1yw5fVDdBMbagpvRmhKXA2GIuwQR6ohWq4KrVr/PAvFG6wIV9lpmrUb4H9xtdDq
	WCGtooAquOz9IirZw64XSdoCEz7k=
X-Google-Smtp-Source: AGHT+IHF9qiOBkLVHOBVQ0wBgnDJBl3ec+j6xf3HzIGYOYuR6kUP4Bkwr/OxInWm0jP/KwMmsivWFFjm3VrtLIAFPoM=
X-Received: by 2002:ac2:4888:0:b0:52c:90b6:170f with SMTP id
 2adb3069b0e04-5309b27b023mr9631322e87.29.1722388029241; Tue, 30 Jul 2024
 18:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAhV-H6vXEaJf9NO9Lqh0xKoFAehtOOOLQVO4j5v+_tD7oKEXQ@mail.gmail.com>
 <20240730022542.3553255-1-chenhuacai@loongson.cn> <2024073059-hamstring-verbalize-91df@gregkh>
In-Reply-To: <2024073059-hamstring-verbalize-91df@gregkh>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 31 Jul 2024 09:06:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7W-Ygn6tXySrip4k3P5xVbVf7GpjOzjXfQvCCbA4r5Wg@mail.gmail.com>
Message-ID: <CAAhV-H7W-Ygn6tXySrip4k3P5xVbVf7GpjOzjXfQvCCbA4r5Wg@mail.gmail.com>
Subject: Re: [PATCH for-stable] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 10:24=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 30, 2024 at 10:25:42AM +0800, Huacai Chen wrote:
> > Chromium sandbox apparently wants to deny statx [1] so it could properl=
y
> > inspect arguments after the sandboxed process later falls back to fstat=
.
> > Because there's currently not a "fd-only" version of statx, so that the
> > sandbox has no way to ensure the path argument is empty without being
> > able to peek into the sandboxed process's memory. For architectures abl=
e
> > to do newfstatat though, glibc falls back to newfstatat after getting
> > -ENOSYS for statx, then the respective SIGSYS handler [2] takes care of
> > inspecting the path argument, transforming allowed newfstatat's into
> > fstat instead which is allowed and has the same type of return value.
> >
> > But, as LoongArch is the first architecture to not have fstat nor
> > newfstatat, the LoongArch glibc does not attempt falling back at all
> > when it gets -ENOSYS for statx -- and you see the problem there!
> >
> > Actually, back when the LoongArch port was under review, people were
> > aware of the same problem with sandboxing clone3 [3], so clone was
> > eventually kept. Unfortunately it seemed at that time no one had notice=
d
> > statx, so besides restoring fstat/newfstatat to LoongArch uapi (and
> > postponing the problem further), it seems inevitable that we would need
> > to tackle seccomp deep argument inspection.
> >
> > However, this is obviously a decision that shouldn't be taken lightly,
> > so we just restore fstat/newfstatat by defining __ARCH_WANT_NEW_STAT
> > in unistd.h. This is the simplest solution for now, and so we hope the
> > community will tackle the long-standing problem of seccomp deep argumen=
t
> > inspection in the future [4][5].
> >
> > More infomation please reading this thread [6].
> >
> > [1] https://chromium-review.googlesource.com/c/chromium/src/+/2823150
> > [2] https://chromium.googlesource.com/chromium/src/sandbox/+/c085b51940=
bd/linux/seccomp-bpf-helpers/sigsys_handlers.cc#355
> > [3] https://lore.kernel.org/linux-arch/20220511211231.GG7074@brightrain=
.aerifal.cx/
> > [4] https://lwn.net/Articles/799557/
> > [5] https://lpc.events/event/4/contributions/560/attachments/397/640/de=
ep-arg-inspection.pdf
> > [6] https://lore.kernel.org/loongarch/20240226-granit-seilschaft-eccc24=
33014d@brauner/T/#t
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/include/uapi/asm/unistd.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/=
include/uapi/asm/unistd.h
> > index fcb668984f03..b344b1f91715 100644
> > --- a/arch/loongarch/include/uapi/asm/unistd.h
> > +++ b/arch/loongarch/include/uapi/asm/unistd.h
> > @@ -1,4 +1,5 @@
> >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#define __ARCH_WANT_NEW_STAT
> >  #define __ARCH_WANT_SYS_CLONE
> >  #define __ARCH_WANT_SYS_CLONE3
> >
> > --
> > 2.43.5
> >
> >
>
> What kernel branch(s) is this for?
For 6.1~6.10.

Huacai
>
> thanks,
>
> greg k-h

