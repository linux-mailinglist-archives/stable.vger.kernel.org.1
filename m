Return-Path: <stable+bounces-47720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034558D4E5D
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 16:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACDAD1F2243F
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AC017C239;
	Thu, 30 May 2024 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvovkK8k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4241D143C40;
	Thu, 30 May 2024 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080567; cv=none; b=JUGvwv0bB2eCey7YzFJ1SWJ3zaLQ56wZT70kC8sxyjEuyejJQC70SWZWthERzENy+uEtBpdHxpnIe9WSjg8xGFLdtZVD2nyqxvG7U5gLGEZjjRAcsvrEYtucDydYPKIY6iuP6Vxbl/nApxsUhclVJIA5m+nNMS85LTrXxCJHfvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080567; c=relaxed/simple;
	bh=wwtJRjKMn2slhYPeALJabtNJMZHMmNFS65oYl0ixA5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iz8XYnGJZE56Lb8iyPA38rVkrS+B7/NOvV+C2Il4XbrpEV2Onk2u/fpq0iT6rvOZpWBHs7qNDCx3IXrfSEVBeMC2vWBmj6TcdzX+inmuM6poxxSe0ashxcSGcSrtlkiUifo/eTGBuWA358vtrbbW0EPJb5ESnmcupcFs2r6OVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvovkK8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F1BC32782;
	Thu, 30 May 2024 14:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717080566;
	bh=wwtJRjKMn2slhYPeALJabtNJMZHMmNFS65oYl0ixA5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HvovkK8k20SzEg2YC30XUIcx5DwkzfCmENgeU/PRMKsS5mS8d+8ESkOAcY0R3DUO5
	 bnQ5Tb2BIBR5U1s6KE7HsZJ2csiwkGORNeHmu9ndaZgcpwUdJPvBBGRSvd0vYcraWF
	 snnWgvcDddNVYqSGdeBNglASlIBQoT9Lxa662Vo9JWldTkwihOPuHSjvfl+L1DvlOJ
	 ZfOBGRdpnPvMFMByFvWzO6o9St8fUMHfqwXkCXCZCpr+xLSb9f5YudMiJ7f0q0pyEG
	 6iuz9wDqTZWrhZv6HRROr5QDTlfWhSKZByOw+H+cc8sQD+NTfMbxCPjdvb7sA4GQXE
	 d0fyo2X7tFENg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b7ebb2668so1031034e87.2;
        Thu, 30 May 2024 07:49:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnUe56gRACO7eLsHlR8Nqnk+EUT/yQFnbM8QZuvIj7ONTPcHCwdUyOYXSUZTuacZRzLwPAK+9477x/Dml0/caTMynV4RxL9WTTZjO714GnamySnIaeuYASe9hGRclbbtoHGLjI
X-Gm-Message-State: AOJu0Yy0JjPIaADBUJEKQY2Up3PAaE1UgJ+qxJLTOiIew5QwlHTLRXxO
	+/oR0GZlDVqYR0nVnFLmCFi08P1lARcT2fgEa+MAJt9GMykv6Xd95MStzSWEnbRYfzR1GgHpcmt
	S9cRkhM7LmKUSrfS4Ig7DmrOItrs=
X-Google-Smtp-Source: AGHT+IEFbO7hCM8ignUOyU2tTcs7HiHvR3sHXqvQXQMLlxZdRFHMlmmonXFYocj9Y5VwLAJsY827gITXCm29TWhIeR4=
X-Received: by 2002:a19:6404:0:b0:52a:7d01:84cd with SMTP id
 2adb3069b0e04-52b7d437e3dmr2178953e87.30.1717080565312; Thu, 30 May 2024
 07:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522-loongarch-booting-fixes-v3-0-25e77a8fc86e@flygoat.com>
 <20240522-loongarch-booting-fixes-v3-1-25e77a8fc86e@flygoat.com> <e1321725-ee7e-4716-ad45-634803fca5ff@t-8ch.de>
In-Reply-To: <e1321725-ee7e-4716-ad45-634803fca5ff@t-8ch.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 30 May 2024 22:49:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H78dNJVgL5mrSwRJF8jT0bV9znO=hx_EgsvKePWtac24g@mail.gmail.com>
Message-ID: <CAAhV-H78dNJVgL5mrSwRJF8jT0bV9znO=hx_EgsvKePWtac24g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] LoongArch: Fix built-in DTB detection
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Thomas,

On Thu, May 30, 2024 at 6:06=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> On 2024-05-22 23:02:17+0000, Jiaxun Yang wrote:
> > fdt_check_header(__dtb_start) will always success because kernel
> > provided a dummy dtb, and by coincidence __dtb_start clashed with
> > entry of this dummy dtb. The consequence is fdt passed from
> > firmware will never be taken.
> >
> > Fix by trying to utilise __dtb_start only when CONFIG_BUILTIN_DTB
> > is enabled.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 7b937cc243e5 ("of: Create of_root if no dtb provided by firmware=
")
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > ---
> > v3: Better reasoning in commit message, thanks Binbin and Huacai!
> > ---
> >  arch/loongarch/kernel/setup.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setu=
p.c
> > index 60e0fe97f61a..ea6d5db6c878 100644
> > --- a/arch/loongarch/kernel/setup.c
> > +++ b/arch/loongarch/kernel/setup.c
> > @@ -275,16 +275,18 @@ static void __init arch_reserve_crashkernel(void)
> >  static void __init fdt_setup(void)
> >  {
> >  #ifdef CONFIG_OF_EARLY_FLATTREE
> > -     void *fdt_pointer;
> > +     void *fdt_pointer =3D NULL;
> >
> >       /* ACPI-based systems do not require parsing fdt */
> >       if (acpi_os_get_root_pointer())
> >               return;
> >
> > +#ifdef CONFIG_BUILTIN_DTB
> >       /* Prefer to use built-in dtb, checking its legality first. */
> >       if (!fdt_check_header(__dtb_start))
> >               fdt_pointer =3D __dtb_start;
> > -     else
> > +#endif
> > +     if (!fdt_pointer)
> >               fdt_pointer =3D efi_fdt_pointer(); /* Fallback to firmwar=
e dtb */
>
> Prefer to use non-ifdef logic:
>
>         if (IS_ENABLED(CONFIG_BUILTIN_DTB) && !fdt_check_header(__dtb_sta=
rt))
>                 fdt_pointer =3D __dtb_start;
>
> This is shorter, easier to read and will prevent bitrot.
> The code will be typechecked but then optimized away, so no
> runtime overhead exists.
Good suggestion, I will take it.

Huacai
>
> >
> >       if (!fdt_pointer || fdt_check_header(fdt_pointer))
> >
> > --
> > 2.43.0
> >

