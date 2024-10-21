Return-Path: <stable+bounces-87551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9983B9A68F4
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 14:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC1C1F21C10
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C191A1F4FD1;
	Mon, 21 Oct 2024 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPuj8Rbf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6602B1F8903
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514794; cv=none; b=RJfD0HGNg6hd84vmGJ+lZt3eaqM5sl/oQWsVK4fQ1DEWyCrEKOSATNKg3Ivzn92K9M1BmeSSSODYJV6SKj4tjLzLs9aEiVoNm32xpnYsDNOLic7u8RpZ105x7COF6R1vkuvyLglNJ92wUAff71fx1lBEKMrcdJ/W9FOAdqcgK9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514794; c=relaxed/simple;
	bh=GipNeiHlWq01xxl6JBssY7r/CVBRMaxGJfNsqJ4td1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uP0bjoJrZUMGnnC8k/js+c/va+wc4eR22JXrZU9e+0yU2a247Ct7nulriXIYPahubJm52EmJq6+JhBdNsfYsL4Ov2SIR80MFpQDwr402ZyWHC08+JZvWX5cKZ2cw+PIe3o8yQAJce/Tm99L2aLfXBat1++kvQohF6fPdQbaYnSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RPuj8Rbf; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e4b7409fso4430737e87.0
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 05:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729514790; x=1730119590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00OOYAye7Y8Jmp2eoWZbqWaZ8JNNBAOvgechpLDPNLM=;
        b=RPuj8RbfJhOc2DYVbhHSgbjzjf5uqWkIUXINkOP8zFUkeNZ0lNxWYHemgox7FLynbi
         01fw9GisVNdrMAruc5qKbx7uBvCWc2738iDCUWXWk8TCDnXCnXvt5CJFKx85qNoyvpgj
         ZgYlYmb6ybQ/nhZkiHclaDy5Ro6udzDGosUNHk6A5UP5D2uOk8vYx9G2bxykEDC8pNEJ
         U2VNvHdNhP/sfclnaM/qTVTAp2IFxA9E3LFKKk2pTvHMiH+mJZAH3+9YHdutZToGc+v/
         tblUbW0oBLERRzaCApZR66fDoIZ+/tV8V1w8Zp3I5/WvQUpK6xmVSHJ4wxbrHbhY4t1B
         aNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514790; x=1730119590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00OOYAye7Y8Jmp2eoWZbqWaZ8JNNBAOvgechpLDPNLM=;
        b=E0J+lmOp8oT/NBKfZDi1Ld0PEta4gOsBqlsxFwxzxaWHzuvs/+z52n5B95cylbxiRy
         4BnuU20jpNYPeCf8qyiD6fBsB1guIX7/WTMrqA8vbc7SXLbmF55ZN4pfdVA/IiQsaExj
         3x3h5Tr9gyWqhaK7wAmxCJ/wYhQJqXzcvCp/ZhFFN3qFg+ETymfqWEzOcsjYK1OhQPsS
         GOnsx/xB/K77hpwci881UOjiBYS+nb41CAEf3FcCvUxYzRSKy+lRzNgD4RipN/jwuS7l
         9foR3xi6OTjmogNazULRP3rCKhjJxtpq2GlI26HeZUQUTYfAZjlb4JxyE3STeWbprD9R
         qVkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQu0riFJjzH9PIWwCOInllNBob1RNt7KG3khjFrXfs5lgChsijS2NGGsqYq7T+32fab3wmmA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxohJctbSpNlAVKEjq+2n47fCcESl3RVpDzmH/tycz+roc7FUvX
	6Rt92gErjuPCxfgR3KN/d4I2Umr3x7RSGQKeEzoozTxX8Q/lncPftlJQmBIr08KGXLogfSDBu3y
	dkMZm8ZPelfKDQ4i3Ip3gH57jGOVGmVbN0syMCQ==
X-Google-Smtp-Source: AGHT+IGe3S4BwA+pOP/cQq7I1CjxxDBUjVQoZRmQ7W4PP8hKLPc100e8nJIIOd6Yg8yfMAsZvsSBWYHMIieC1vxcEJw=
X-Received: by 2002:a05:6512:1392:b0:539:e67e:7db8 with SMTP id
 2adb3069b0e04-53a0c6ae65bmr4990352e87.12.1729514790318; Mon, 21 Oct 2024
 05:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-arm-kasan-vmalloc-crash-v3-0-d2a34cd5b663@linaro.org>
 <20241017-arm-kasan-vmalloc-crash-v3-1-d2a34cd5b663@linaro.org>
 <69f71ac8-4ba6-46ed-b2ab-e575dcada47b@foss.st.com> <CACRpkdYvgZj1R4gAmzFhf4GmFOxZXhpHVTOio+hVP52OBAJP0A@mail.gmail.com>
 <46336aba-e7dd-49dd-aa1c-c5f765006e3c@foss.st.com>
In-Reply-To: <46336aba-e7dd-49dd-aa1c-c5f765006e3c@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 21 Oct 2024 14:46:18 +0200
Message-ID: <CACRpkdaiwt3aHmRKbR5e-hbd3VpR_Zxd95N3CmcAtFV-mjw_tg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ARM: ioremap: Sync PGDs for VMALLOC shadow
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev <kasan-dev@googlegroups.com>, 
	Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Antonio Borneo <antonio.borneo@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 2:12=E2=80=AFPM Clement LE GOFFIC
<clement.legoffic@foss.st.com> wrote:

> I saw your email about Melon's patch targeting the same subject.
> If we don't enable KASAN either you patch or Melon's one do not compile.
>
> [...]
> +       if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
> [...]
>
> Should be replaced with an #ifdef directive.
> `kasan_mem_to_shadow` symbol is hiden behind :
>
> include/linux/kasan.h:32:#if defined(CONFIG_KASAN_GENERIC) ||
> defined(CONFIG_KASAN_SW_TAGS)
>
> So symbol doesn't exist without KASAN enabled.

Yeah sorry for missing this. :(

The absence of stubs in the Kasan header makes it necessary to rely
on ifdefs.

I will fold the ideas from Melon's patch into mine and also develop
a version that works with ifdefs.

Yours,
Linus Walleij

