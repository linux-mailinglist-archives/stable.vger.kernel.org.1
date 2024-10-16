Return-Path: <stable+bounces-86534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9219E9A11DC
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 20:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16291C2247E
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 18:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618D818C002;
	Wed, 16 Oct 2024 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQcYz1Sr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221D416E86F
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104640; cv=none; b=Hb0+37LT0uZIQLLnYh/fIklKBkVUXeNH2GRPXZ40SO2tdrqWCZqCcUxkfc7awa4sQmqejIc6QrDt6+wROfRKx57XF079iUm//cj6dMbb6yYIeOyH/+HUHgo1wTuPHqf0RkwS4FynMcp6be2zYVKSbPo4we5CcJ55Y8scmNjE20Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104640; c=relaxed/simple;
	bh=L6XHu4FtlGacMcWbxzLjmXjFmMokOmuXuUJaQfV8FBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/nno6tpWzjVp/CXuZpqGhaUQ/kBaRb1AYx7fSee7TnFwKX10mKi9yECbT3tpGjh6h4IfJUMj20Sh4W7uuwdB6VuR6kR+uADxg0ofZd35Z5iwSNRivVxPleBtaRbXJEnD7CeKaGVbeRY0w4pIGwZRiIcw5Pcp0bl3nW+lABsZ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQcYz1Sr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9830AC4CECD
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 18:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729104639;
	bh=L6XHu4FtlGacMcWbxzLjmXjFmMokOmuXuUJaQfV8FBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cQcYz1SrUMtZnuULX9/VHkciXXbeLuwfwhNVXj9at80MMmjjlef3Q8cdK/9FNAJaW
	 txZQLSWvM2AFkPFS9P+8VlmHXZ7zeZha+XjDk0Wf3cuWPPttdbgzGOuxX8wHaIAiM+
	 LvVbPn8sRkQCrFSSM3T41B57ZyHyhr2LTIGLCeStsGRjUvw3QqlLfE4l7YOKt7Eb27
	 crirxna7+lc+RvlJCMfHIlbXkk0BLxLyWeVSnKAz3EnFiUUsABYic1Nz41T4KrEduG
	 b9izFi7tTZQ3EpaLmTPMYLAjq7/rf+j+loXH+rY2oljMROpmrV3C24b3z/itpmf4cr
	 J04XptSVv30kw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539983beb19so160434e87.3
        for <stable@vger.kernel.org>; Wed, 16 Oct 2024 11:50:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTuSracI5QoKnX4F6ndRmTF3TwLNHZMD1htqfNMn5ivVCsmC84c8gRAfIuXP/Ey6uHnQYPse0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLl0iC0dp9pHq4L2RtFboDfXLUE7SWEH0KsUcdfDAfZns9Tigv
	fZMzpNJsXZ3Rpp4AotMwTjaKEAmeYbgKT8CBx6GqJVoNtnSV8hxJJGRbE9j8jqjNmLxZ86wbiBm
	+c8yjiS5rhbMBrHbsOmhrVLNRn0I=
X-Google-Smtp-Source: AGHT+IGJGDssr9uVJTLE6jB1f3Nuog+tjAvDKy3jYqTbpcvp+KymNCSVjvyuzrQo6U3A4w7yQVMXCVc3SZR2YJTJTsA=
X-Received: by 2002:a05:6512:4009:b0:52c:dc6f:75a3 with SMTP id
 2adb3069b0e04-539da58697fmr9901673e87.40.1729104637783; Wed, 16 Oct 2024
 11:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-arm-kasan-vmalloc-crash-v1-0-dbb23592ca83@linaro.org>
 <20241015-arm-kasan-vmalloc-crash-v1-1-dbb23592ca83@linaro.org>
 <CAMj1kXHuJ9JjbxcG0LkRpQiPzW-BDfX+LoW3+W_cfsD=1hdPDg@mail.gmail.com> <CACRpkdZp84MzXEC7i8K2FCnR3pEc05wPBVX=mMO5s6j1tJTm_A@mail.gmail.com>
In-Reply-To: <CACRpkdZp84MzXEC7i8K2FCnR3pEc05wPBVX=mMO5s6j1tJTm_A@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 16 Oct 2024 20:50:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGHsexspqKfewL3i7M1aqZJwkb6D_kO_UCoAvoSF24Wrg@mail.gmail.com>
Message-ID: <CAMj1kXGHsexspqKfewL3i7M1aqZJwkb6D_kO_UCoAvoSF24Wrg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: ioremap: Flush PGDs for VMALLOC shadow
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Clement LE GOFFIC <clement.legoffic@foss.st.com>, Russell King <linux@armlinux.org.uk>, 
	Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Antonio Borneo <antonio.borneo@foss.st.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Oct 2024 at 20:38, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Wed, Oct 16, 2024 at 1:33=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
>
> > > @@ -125,6 +126,12 @@ void __check_vmalloc_seq(struct mm_struct *mm)
> (...)
> > Then, there is another part to this: in arch/arm/kernel/traps.c, we
> > have the following code
> >
> > void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
> > {
> >     if (start < VMALLOC_END && end > VMALLOC_START)
> >         atomic_inc_return_release(&init_mm.context.vmalloc_seq);
> > }
> >
> > where we only bump vmalloc_seq if the updated region overlaps with the
> > vmalloc region, so this will need a similar treatment afaict.
>
> Not really, right? We bump init_mm.context.vmalloc_seq if the address
> overlaps the entire vmalloc area.
>
> Then the previously patched __check_vmalloc_seq() will check that
> atomic counter and copy the PGD entries, and with the code in this
> patch it will also copy (sync) the corresponding shadow memory
> at that point.
>

Yes, so we rely on the fact that changes to the vmalloc area and
changes to the associated shadow mappings always occur in combination,
right?

I think that should probably be safe, but we have to be sure.

