Return-Path: <stable+bounces-210122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B50F1D38B10
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 02:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A39023034425
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 01:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEEC21146C;
	Sat, 17 Jan 2026 01:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlKA2Vtz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54946D1A7
	for <stable@vger.kernel.org>; Sat, 17 Jan 2026 01:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768612588; cv=none; b=FbMLXX3TNA6xt8/ivkNKwZZnTZSIE8Yb861AlpWmUtvNguYAi90keMUKMUDvb3bqK3bL56Un2vWE3kRRM6WkA6WADI2XVB+PFQtenwmEprpoKzDIFExDdMfRlgV6tOWby2ULwTH2iXkXaF3A0kGol1cpD/rwjLdlLbEKug4brbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768612588; c=relaxed/simple;
	bh=ocof3UtAX0tYNJdjurWbsTwQtK/5v0lOyfVO2rM75zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJv29Ng7Bj2UNsM61mHep8q7BPoCODbatMA02kA2LkQrEzxvuiJP0mjx/OiIzn25iguYfnuJGPaeSaK4kUVIllES8khEuuq/qOI2gUGMEzda7EfpEYHhBNV6elkBocQkVBRlcZvqGPTeszG3qb+vVJ/X8NnHbZmUcU71Qbfo3OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlKA2Vtz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee807a4c5so19253305e9.2
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 17:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768612581; x=1769217381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jacRTGEGX5vlMnwDO2iTbDAhG4zdHGWsi458RG2c5M=;
        b=BlKA2VtzLPDYRzZMaonHqJqXjciZCX9yytbinnXLZTeBOQTrE2dd3JjW94qKsUgXvp
         m+YDPizmqxL7je+4qc0i8q4ghnfrWP6O/p2hkh4Q7uIXv35lYreyB2wOp0YN+tYWL5yq
         VkB+1OHGSeHzbSqOVgAtDpP+oruyYjRbliLhXpYFbj3ik4O+xw0qtqYuiMygroxsiMmK
         NyaZO6k8uWgxP0XkSWfMqiLKjgOONpvSnb7PkWMWXGSauSLYIn1W6AdAC8tE9hCfsiBG
         TOzk4VoCFKa3SQzTTgo5v8Sm2dfScqxZwVwHxGBcZdGNF2ferpji/GpOmcLqCsonDTrL
         87WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768612581; x=1769217381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8jacRTGEGX5vlMnwDO2iTbDAhG4zdHGWsi458RG2c5M=;
        b=AS+wYumisU0OiMukkGOweHiSa6Us1hWuFTodLpFMXO7+6ovNWfwe7ARMp8kRUmehGt
         tNUi2pTPguIo2T6OGZtmDQKiDPV8LpbcWK9cWZ52+VoSM8q8CyrlqTs0jOyW4SUorzxF
         UE6luiXwfH67nZiDFcvR0aiwmvGVsLOywqsm7N8Hv6Ph1DeYx4/ADs2+QgMwnox0sezT
         ygeJIfD6ExRusArzoDsRAUUmk10PbtX1niSUeK68afUgpjYcs7+jyAZuV9FVYfeuYIou
         FuAgmUNuBQ6SN0jTSdNuSFUGNS5kmZYxnNMEusvMC5qZdxpheFzDTsB4gtVQlDy1IFxI
         2z8w==
X-Forwarded-Encrypted: i=1; AJvYcCUZMj/HA32Kwo/1hIHUR6dQw8igUMiVbeGsVh9BKq4hEhHoYEzmt3uAX41HSBmmI4nJpC+C5I8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypXdTiwWDzh3yd1/ilBby+ufCBv0gKFyqn1/lRHyRadihcaq5w
	wlAL4sEyqwr+m/kyZumsULpYu/uvg2dVGoKTmk693fAY2wbzjUAuh1eIIjaudihHPVB+/6FIg3n
	myG9JIfA2YqShBg7dEuCIpMnQyvY56G4=
X-Gm-Gg: AY/fxX6y0oNKCabzk35OCfQ3J3wQV4FWCaXd3uDZHZ2VSWLaIh+MV+0qKMwjrbQJN8R
	UgfiYoY3NIUc5gUYyvg5++50rVY/rROiKc3ZdEe+6se+h5zYqVjdP4woeppaI+qEnAKr6wCCvan
	e6eHffs5LpO21qvZft6rh3IyBwtMDS1pfCS6XjDpryTfRZMOX28QyX9/vw9Eo8HiXiTFYbyXcWm
	VMQO5nUEwMjmH+CDdeV5fSecJyTqWKLNok27FDyIc0WgKRyyHyAaY55rWSoAD2cYQsKH96yctjx
	1bwoHvRiS7SEl9qflVq5Xn8eisoB
X-Received: by 2002:a05:600c:45d1:b0:480:1d16:2538 with SMTP id
 5b1f17b1804b1-4801eb03358mr43804885e9.23.1768612581229; Fri, 16 Jan 2026
 17:16:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGeuRW53vukDy7WDO3FiVgu34-xVJYkfpm08oLO3odYFrA@mail.gmail.com>
 <20260113191516.31015-1-ryabinin.a.a@gmail.com> <CA+fCnZe0RQOv8gppvs7PoH2r4QazWs+PJTpw+S-Krj6cx22qbA@mail.gmail.com>
 <10812bb1-58c3-45c9-bae4-428ce2d8effd@gmail.com>
In-Reply-To: <10812bb1-58c3-45c9-bae4-428ce2d8effd@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 17 Jan 2026 02:16:10 +0100
X-Gm-Features: AZwV_Qgw2efsxw5nCGxgrSSMx3DQz0LNWwfRwrPgK6uICIY1gvifMYqiZzjGO_4
Message-ID: <CA+fCnZeDaNG+hXq1kP2uEX1V4ZY=PNg_M8Ljfwoi9i+4qGSm6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/kasan: Fix KASAN poisoning in vrealloc()
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Maciej Wieczor-Retman <m.wieczorretman@pm.me>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev@googlegroups.com, Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, joonki.min@samsung-slsi.corp-partner.google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 2:26=E2=80=AFPM Andrey Ryabinin <ryabinin.a.a@gmail=
.com> wrote:
>
> So something like bellow I guess.

Yeah, looks good.

> I think this would actually have the opposite effect and make the code ha=
rder to follow.
> Introducing an extra wrapper adds another layer of indirection and more b=
oilerplate, which
> makes the control flow less obvious and the code harder to navigate and g=
rep.
>
> And what's the benefit here? I don't clearly see it.

One functional benefit is when HW_TAGS mode enabled in .config but
disabled via command-line, we avoid a function call into KASAN
runtime.

From the readability perspective, what we had before the recent
clean-up was an assortment of kasan_enabled/kasan_arch_ready checks in
lower-level KASAN functions, which made it hard to figure out what
actually happens when KASAN is not enabled. And these high-level
checks make it more clear. At least in my opinion.


>
> ---
>  include/linux/kasan.h | 10 +++++++++-
>  mm/kasan/shadow.c     |  5 +----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index ff27712dd3c8..338a1921a50a 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -641,9 +641,17 @@ kasan_unpoison_vmap_areas(struct vm_struct **vms, in=
t nr_vms,
>                 __kasan_unpoison_vmap_areas(vms, nr_vms, flags);
>  }
>
> -void kasan_vrealloc(const void *start, unsigned long old_size,
> +void __kasan_vrealloc(const void *start, unsigned long old_size,
>                 unsigned long new_size);
>
> +static __always_inline void kasan_vrealloc(const void *start,
> +                                       unsigned long old_size,
> +                                       unsigned long new_size)
> +{
> +       if (kasan_enabled())
> +               __kasan_vrealloc(start, old_size, new_size);
> +}
> +
>  #else /* CONFIG_KASAN_VMALLOC */
>
>  static inline void kasan_populate_early_vm_area_shadow(void *start,
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index e9b6b2d8e651..29b0d0d38b40 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -651,12 +651,9 @@ void __kasan_poison_vmalloc(const void *start, unsig=
ned long size)
>         kasan_poison(start, size, KASAN_VMALLOC_INVALID, false);
>  }
>
> -void kasan_vrealloc(const void *addr, unsigned long old_size,
> +void __kasan_vrealloc(const void *addr, unsigned long old_size,
>                 unsigned long new_size)
>  {
> -       if (!kasan_enabled())
> -               return;
> -
>         if (new_size < old_size) {
>                 kasan_poison_last_granule(addr, new_size);
>
> --
> 2.52.0
>
>

