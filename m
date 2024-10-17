Return-Path: <stable+bounces-86683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479E99A2D10
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 21:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40F81F215F0
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2187521D168;
	Thu, 17 Oct 2024 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKl+50w0"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4521C177
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191674; cv=none; b=iDrtxXHXrhbrvdRdTIDyXiBQEjlQoXXDsRc3z7kik1/BvO/kL96lZjcxyKZRKuWzPm2beGDvM3w4mgkzmJJ0D7wBHc9HTlVgXlCuA7StAl4d1UYttwbzf7ZyILjWMcT3LmhiwHPVyxW1Or6A8X4JEJPFP9c8iHpE3RNIoGFUNDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191674; c=relaxed/simple;
	bh=WVH+K6ExCtSFLk5JRBHirE7ownRS5xmztgPR9yYCCug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAN8pKP4CjWOpp7ReBq1dBNVx7p6p+l0E/3d7VKm0dWAM3nccr2b4iLFC3PE/uvsNWzPUD1ok6LAtPNAjhop2LtXBxvKoB8hGNB9z3viRsciBb2sBrJS3Xj3b12YMmnObrf5OrkJ0Zj8Zu8uMM3/WWWw6N73gLBeQKN8Qwk62Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VKl+50w0; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb501492ccso14888641fa.2
        for <stable@vger.kernel.org>; Thu, 17 Oct 2024 12:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729191668; x=1729796468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lU3mObs7ZaU0oOzXWh6lZdlXzB4eGdGSPMvLDf83xnY=;
        b=VKl+50w0f41FUFlweR0Vq4dk8cBWocm19Icx6tE7txYhNaAFjJxOSgXfsioNHXEysd
         CUjc2yg8FuCBs6o4oSoHjGhiLZe2udCF78BHV9OKlDBi78h6uMBtEMi0E935cnA930dl
         W/bAl826F32gyuVNNpM/RU1pMY0rDHkFU1lq7fwYU6jkZMCdUBmB1kYAebkydnLJOgJ7
         mKHTSoDB5n17MpgZY8/twE3HC0IKZk8XFxnH3MZ9IZBjTZDNybfkspbnPmG6bfOmWh8x
         iQulFPIEWTYEf9wpOtNXj/m2lDwUFlbQ0NfaOY0hq45x8ohRrq6/kVlwS/PKc4Q6hUc7
         9CNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191668; x=1729796468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lU3mObs7ZaU0oOzXWh6lZdlXzB4eGdGSPMvLDf83xnY=;
        b=R9s93jxLKFoBAM5R52R1qjjpZXDbMgBfwzjDzj6M+0amdXQSXGbIoK3jcozUBlOv2i
         Cct8L8S3ZUY9svA6EPyAWqZfwBQbfkRYQ3WWGhqExKWdDA5VkcaNamyM6MRfZqDq+wAc
         T/da1AQSmgfveSAthkwLQyJYEfxYL17CU2rfHl42F7FVJYvAxanSgVZqfie3w+sLL3aN
         wkWsHPuHz9CcMV6J2CG9u14ZPpyWyX5LNxsh/8jUVHUhnQhqj09jpVew/y0sdOilebBg
         6imXtKS22jjUrIx9t6ezurJrGyOuJ2AUS0oO/XV8UAGiXwBNOJ7v6NmWTkjPq80AQG6z
         6Tqg==
X-Forwarded-Encrypted: i=1; AJvYcCX2UWtoZOKulGQQ2D889X34+FuIsijnV4bxhrjsxUVuTjoyeSAfxtOYLsUGjoxVL3osovIbPy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfkfBQMfbLgvCQp36YDB3V0RZNYN0HE7lVTYdJ/iLfrLsw5VkB
	V9kR2xFiYiouSAzJQbxAvKWxyT4ddQKo7UmiRODvb5fP/iJ5+hokNIZxl4aF7909fsj1VgGa99C
	Y7wEcI7/kPrUZQieYI/Cvn83ZzoPhTRsuPMQZGw==
X-Google-Smtp-Source: AGHT+IHJeyGHoEdVg5gahAtoLC5kb1XqCmrujO8GrsKJdhQBIrzNdth5nou9m05kGz6+prHxUELbU3wCqlAmf39VMTs=
X-Received: by 2002:a05:651c:b25:b0:2fb:5740:9f9a with SMTP id
 38308e7fff4ca-2fb5740a18dmr82304681fa.29.1729191667969; Thu, 17 Oct 2024
 12:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-arm-kasan-vmalloc-crash-v3-0-d2a34cd5b663@linaro.org>
 <20241017-arm-kasan-vmalloc-crash-v3-1-d2a34cd5b663@linaro.org> <69f71ac8-4ba6-46ed-b2ab-e575dcada47b@foss.st.com>
In-Reply-To: <69f71ac8-4ba6-46ed-b2ab-e575dcada47b@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 17 Oct 2024 21:00:55 +0200
Message-ID: <CACRpkdYvgZj1R4gAmzFhf4GmFOxZXhpHVTOio+hVP52OBAJP0A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ARM: ioremap: Sync PGDs for VMALLOC shadow
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev <kasan-dev@googlegroups.com>
Cc: Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Antonio Borneo <antonio.borneo@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 4:22=E2=80=AFPM Clement LE GOFFIC
<clement.legoffic@foss.st.com> wrote:
>
> On 10/17/24 14:59, Linus Walleij wrote:
> > [...]
> >
> > +static unsigned long arm_kasan_mem_to_shadow(unsigned long addr)
> > +{
> > +     return (unsigned long)kasan_mem_to_shadow((void *)addr);
> > +}
> > +
>
> `kasan_mem_to_shadow` function symbol is only exported with :
> CONFIG_KASAN_GENERIC or defined(CONFIG_KASAN_SW_TAGS) from kasan.h
>
> To me, the if condition you added below should be expanded with those
> two macros.
(...)
> > +             if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {

Let's check this with the KASAN authors, I think looking for
CONFIG_KASAN_VMALLOC
should be enough as it is inside the if KASAN clause in
lib/Kconfig.kasan, i.e. the symbol KASAN must be enabled for
CONFIG_KASAN_VMALLOC to be enabled, and if KASAN is enabled
then either KASAN_GENERIC or KASAN_SW_TAGS is enabled
(the third option KASAN_HW_TAGS, also known as memory tagging
is only available on ARM64 and we are not ARM64.)

But I might be wrong! Kconfig regularly bites me in the foot...

Yours,
Linus Walleij

