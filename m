Return-Path: <stable+bounces-89259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CF89B551B
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 22:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40A71C227BD
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 21:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B560207A1B;
	Tue, 29 Oct 2024 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nu4H1lcd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03521422AB
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237585; cv=none; b=m0reMS/bZL55Uy90HUY9tHw2q0ZYIy0mywYtB3aD1hxgaHtwbK9lTrsMxa576CaH3XYhA5x9E8aISXIqvK6vyBPJ2vtIKjdMwoFZJ2+BNYA1J81L3Bdl+oR51aaAL/nYLl1UsNxWnZ8OgME/O9ijkAX/Hj4E606ZCSYdZJdtjQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237585; c=relaxed/simple;
	bh=q8g0feFRM/g+KnXJgAODk2AAUgWx4QsqawCDf5AlE04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNsxKhcKjirSqQ7yxJCgfsOFsmazQGYQ+QbfeO2inK5u2oVF7p00SsMn3X5GEBYRWcDolPwkuq+L6aNreiCo4q6vAoRa4XlVZVH26Zp/qgcFqA+ZfARJ7IxlLTkm8GnNrOJFVqAioM1f4xPRUdt+wwKJ4Opl8noFQmr4+9KDTGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nu4H1lcd; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb3110b964so47183051fa.1
        for <stable@vger.kernel.org>; Tue, 29 Oct 2024 14:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730237581; x=1730842381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8g0feFRM/g+KnXJgAODk2AAUgWx4QsqawCDf5AlE04=;
        b=Nu4H1lcdZInCoXiq1u796zywcZ3kb9B05t77AJzWOxQCxP8ZQrZFgmY+ZA8bkqWoXn
         FRJcP5mSHc7cZDCPESCFmkRvhTyhKgG3K54pt7oQGbqx5aJsEVF1KDV2WT4tibzwFK7N
         kVlpuqMUUmaEtIx0979eVFgiiO8Pbw2ZD4X+ZAJrGnnW7wiL6WLc0l6ejOZ5advjFigI
         7hZDv05NU3NoeC4aTzbJfVuDj7yWGEFYN7YSROga97g2QQ6dPqMvLUluUd9h74tdvo98
         m3W8Dm5JqMAUVeYCMH8bBcD47PXEjcYtXxOCtvXEogarCxpAA/x8+6nFLyqpht3cK1Nl
         K8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730237581; x=1730842381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8g0feFRM/g+KnXJgAODk2AAUgWx4QsqawCDf5AlE04=;
        b=nNg1R7VV5f3omF6n/vxyr73ETRVfuRVnMi4I4yBi49f5BZvZUNLanmOO/Kl4b1eMyD
         44OahX1KojWti1IIRn8GjjskD0skYlqxyJTTCdSvz7CLEUDU7Noa4j2bBjUdUlNp2Yib
         6UJzn0oxloRk417gN09TBY+PHu1YMPU1DYo2jXwBTYLQxvIEKnPP0LJA9gXEUKI+zuua
         FvR9i37FpOxOYzke+b6hb7eWIctB3ItI29Lc21WH/Ldz9rkbDxttm6fwMqz/L69MItnV
         TPb8vMiKGBVJOpEgt7plznRRMDSQRkw1/OUX0vtbfumggkv/NF8TyRvTCZOwexvuhX+t
         pkvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg4NqYyXpvrmMhY93iidRe53rXJpB5/ymDb6YGjoDmaBumjyLvf4ZXfEFgNa1MU94mH0fMN6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBBMowCBSiVrwXQYOfpbmNaWXoDMhUlCgkHd1W0NPKJixzmyJR
	7yNWnPpc01vQJqko6kMVMj/5yxlTmNQ/WA09TLtq7qS7bcJsKfv/RZ+2xcgh4c4Hize3TJ0m4OO
	XtrszRG4W/nW42M8ko+HrAQwifb9KV44X9SFk3A==
X-Google-Smtp-Source: AGHT+IGz/3o5I5pu/IvRI0ZSy55BS620aj8UcTY9J52CZ6B8oesgnwPYNjKruN7W2FCVabsplBzN7qiPeSUE29LMc/w=
X-Received: by 2002:a2e:be9f:0:b0:2fb:3bef:6233 with SMTP id
 38308e7fff4ca-2fcbe08cf3bmr60977061fa.33.1730237580772; Tue, 29 Oct 2024
 14:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-arm-kasan-vmalloc-crash-v3-0-d2a34cd5b663@linaro.org>
 <20241017-arm-kasan-vmalloc-crash-v3-1-d2a34cd5b663@linaro.org>
 <69f71ac8-4ba6-46ed-b2ab-e575dcada47b@foss.st.com> <CACRpkdYvgZj1R4gAmzFhf4GmFOxZXhpHVTOio+hVP52OBAJP0A@mail.gmail.com>
 <46336aba-e7dd-49dd-aa1c-c5f765006e3c@foss.st.com> <CACRpkdY2=qdY_0GA1gB03yHODPEvxum+4YBjzsXRVnhLaf++6Q@mail.gmail.com>
 <f3856158-10e6-4ee8-b4d5-b7f2fe6d1097@foss.st.com> <CACRpkdZa5x6NvUg0kU6F0+HaFhKhVswvK2WaaCSBx3-JCVFcag@mail.gmail.com>
 <CACRpkdYtG3ObRCghte2D0UgeZxkOC6oEUg39uRs+Z0nXiPhUTA@mail.gmail.com> <aeef0000-2b08-4fd5-b834-0ead5c122223@foss.st.com>
In-Reply-To: <aeef0000-2b08-4fd5-b834-0ead5c122223@foss.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 29 Oct 2024 22:32:49 +0100
Message-ID: <CACRpkdbgZ2J_-9KLeRz2Y8G4+T2qPo5uax4-o=KZbVFRVEO4Hw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ARM: ioremap: Sync PGDs for VMALLOC shadow
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev <kasan-dev@googlegroups.com>, Russell King <linux@armlinux.org.uk>, 
	Kees Cook <kees@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Mark Brown <broonie@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Antonio Borneo <antonio.borneo@foss.st.com>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 4:03=E2=80=AFPM Clement LE GOFFIC
<clement.legoffic@foss.st.com> wrote:

> I have tested your patches against few kernel versions without
> reproducing the issue.
> - b6506981f880^
> - v6.6.48
> - v6.12-rc4
> I didn't touch to CONFIG_VMAP_STACK though.
>
> The main difference from my crash report is my test environment which
> was a downstream one.
>
> So it seems related to ST downstream kernel version based on a v6.6.48.
> Even though the backtrace was talking about unwinding and kasan.
>
> I will continue to investigate on my side in the next weeks but I don't
> want to block the patch integration process if I was.

I think we can assume that the patches we have queued in Russells
patch tracker at least don't make things worse, so let's merge those
and then see if there is more fallout we need to dig into as you test.

Thanks Clement!

Yours,
Linus Walleij

