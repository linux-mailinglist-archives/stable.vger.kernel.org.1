Return-Path: <stable+bounces-199952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 121B3CA20E1
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 01:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B20EF301FF7B
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 00:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9083D1DC997;
	Thu,  4 Dec 2025 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU/Cr70D"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F821D618A
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764809031; cv=none; b=Ltlhnshtt4KzEB99opNySScPkiFpnBI+/133nKqk+LxWi5X0zeVL6aKi1RaPm73sxuiOTbWdU0S58sm46GgScrlAjcwA0gbhH0wO5/atJ9TAzeJsTrwXQS9wMAoWFgwNL/dVAQPPtygaZycxxaIPyJkLRE7Vdchj2eSX8SXpTU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764809031; c=relaxed/simple;
	bh=jQ60Is7wZDakMaGbFh/gzzuQueFZvJTV+0VgQINmXWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTdLdDXBReVtwkX2xAQB9TdzuEGT+xpotYy961+70riX9Cm2OhjhvLuAwkTuxzMPDaDh23tMQ/GyMssUWszGslcxbYbsJxY34Xyb6I2Coe4SsLdS+1aid/yNqOQbyczJYpa5oF3FKb55SYNP7Lm2Sq/FRz2kQnp7cFglEaW9s6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU/Cr70D; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477aa218f20so2252855e9.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 16:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764809028; x=1765413828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSZR0s81uMpFgx5g0GkJVL+/X7Q/NOvMK5/MCFI0OA8=;
        b=KU/Cr70D030fS9B1DN+YKAVb7d5v0JZjvUQRaDP4zoToHYrksvtT2TJc43f4Id7hlO
         QZeAoBZ9/uyIA7P4LjcJt+EYy/Em++haNSzHlnO+u3Q5V0snxfuzrJCWBW9PEELyhKIj
         W8PE0DioY1dzQOTI0qD2JwDTIeKA4ACEmvq2mps7yIIUid46If0S38pYnfs7/4o/ZT6h
         r4E74ma3SnUmI2o7If5LO1w/F4ztJZxagZ7NXK9iKrcn8XA8q1J21pdzRvS38bmYfbcE
         xCBJ6OLw7A+h9DVIReyLYI9zNj1nueVkmubU/14kpXVVBKbgfOiPJJgGz5C54pVurkTB
         eheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764809028; x=1765413828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSZR0s81uMpFgx5g0GkJVL+/X7Q/NOvMK5/MCFI0OA8=;
        b=rBPobOCqf+aHQnBFUNexvAggd7nOjfcFKE9v3FSH0CP33MOAvim3cwpHsn9ws5Cp9l
         EalZtrW/ymhYQorT6tbki7d608qHR3PeCBJSGlHpjjvcGj8emRhrNVwZMXklnZTIXh7X
         qF1frrcq93tDv/+k+w5AteRvYcSGLykNRQ+J4Sc9EvAML99rEVAAH1PWh05qKAUFJjUZ
         3ofR/HImXi4gxwVvmKQUCpGlwaLBbM0YcZz5GTsvNjvJ+wpDqS8ONUv4SxzK6YchXvOH
         xTgU3/G9xQ/YBUyjx0Axjo5CNbd+Z9fmV6Mhg9d4ZDoOLs5ucSVHJ+AG+Ei5DkNpmYiV
         tqlg==
X-Forwarded-Encrypted: i=1; AJvYcCXiv9k6erO4QlmVRkF5liWuz3DcZkQ0BMIEGfb4eMJEGl279sadJj2GygQoTTMhEk4NmgF+QBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9CYQF/ergMrwvL43rlRQlgNaCJ9sJnEif1Ukb1pucz9LZkYC
	9DpvEhr+wzPnVZcu72UicCK40Oo6DPQ9MtxIKYJqSLGgcQ3TweJ7hdtTJqFK7JkoOEeo9SmfSvh
	l1+5F/Mw796slNMUR+RzOjJqMF2rTeT0=
X-Gm-Gg: ASbGncuJajrYxYNVdbDhMYEhtlZcxDQtwr3hCFnSsOHKeJcq2pOLApOfK1eaYTswvSb
	d/itLMx9u9gDly3UaTqz5vbnZymksYF7u4leaoBBw6AzYiZInvw546YRyVsCgz6RDtgdvEaySsF
	deD+KCEYFBdI/JaHqGZ4VsgH6Tkr0r20Bj45xcDMTnSxlZuk370pOkK14ohHC0iyWAJC8q/OJMK
	YFN1h+O2Oj19osqx0jKzewXdqKuuRFiwGz663sXkAs/ezBWb36+q7wDew7FfOwUPXfftkE6w0SA
	ET1oS0v3yq45bDGGobf4dilDKkjSdOYRlV1q0YHW1Rn1
X-Google-Smtp-Source: AGHT+IEsyIO5w16AGkEcxeFY0A0Rl0517V7+ZhktBGwPg6whYXFZrhXBqYK/iiw0zMLWkYGo/S9OeTwQvGtAxGcTeSQ=
X-Received: by 2002:a05:600c:3152:b0:477:6d96:b3c8 with SMTP id
 5b1f17b1804b1-4792af3d888mr39174785e9.23.1764809027713; Wed, 03 Dec 2025
 16:43:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764685296.git.m.wieczorretman@pm.me> <325c5fa1043408f1afe94abab202cde9878240c5.1764685296.git.m.wieczorretman@pm.me>
 <CA+fCnZdzBdC4hdjOLa5U_9g=MhhBfNW24n+gHpYNqW8taY_Vzg@mail.gmail.com> <phrugqbctcakjmy2jhea56k5kwqszuua646cxfj4afrj5wk4wg@gdji4pf7kzhz>
In-Reply-To: <phrugqbctcakjmy2jhea56k5kwqszuua646cxfj4afrj5wk4wg@gdji4pf7kzhz>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 4 Dec 2025 01:43:36 +0100
X-Gm-Features: AWmQ_bl7ZVunvhyvED5tOqclCssm6-frqSDnocWXgYLBUJsGZUA2QPhZVEy1VsU
Message-ID: <CA+fCnZeCayQN3448h6zWy55wc4SpDZ30Xr8WVYW7KQSrxNxhFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kasan: Unpoison vms[area] addresses with a common tag
To: =?UTF-8?Q?Maciej_Wiecz=C3=B3r=2DRetman?= <m.wieczorretman@pm.me>
Cc: jiayuan.chen@linux.dev, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Marco Elver <elver@google.com>, stable@vger.kernel.org, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 5:24=E2=80=AFPM Maciej Wiecz=C3=B3r-Retman
<m.wieczorretman@pm.me> wrote:
>
> >I'm thinking what you can do here is:
> >
> >vms[area]->addr =3D set_tag(addr, tag);
> >__kasan_unpoison_vmalloc(addr, size, flags | KASAN_VMALLOC_KEEP_TAG);
>
>
> I noticed that something like this wouldn't work once I started trying
> to rebase my work onto Jiayuan's. The line:
> +       u8 tag =3D get_tag(vms[0]->addr);
> is wrong and should be
> +       u8 tag =3D kasan_random_tag();

Ah, right.

> I was sure the vms[0]->addr was already tagged (I recall checking this
> so I'm not sure if something changed or my previous check was wrong) but
> the problem here is that vms[0]->addr, vms[1]->addr ... were unpoisoned
> with random addresses, specifically different random addresses. So then
> later in the pcpu chunk code vms[1] related pointers would get the tag
> from vms[0]->addr.
>
> So I think we still need a separate way to do __kasan_unpoison_vmalloc
> with a specific tag.

Why?

Assuming KASAN_VMALLOC_KEEP_TAG takes the tag from the pointer, just do:

tag =3D kasan_random_tag();
for (area =3D 0; ...) {
    vms[area]->addr =3D set_tag(vms[area]->addr, tag);
    __kasan_unpoison_vmalloc(vms[area]->addr, vms[area]->size, flags |
KASAN_VMALLOC_KEEP_TAG);
}

Or maybe even better:

vms[0]->addr =3D __kasan_unpoison_vmalloc(vms[0]->addr, vms[0]->size, flags=
);
tag =3D get_tag(vms[0]->addr);
for (area =3D 1; ...) {
    vms[area]->addr =3D set_tag(vms[area]->addr, tag);
    __kasan_unpoison_vmalloc(vms[area]->addr, vms[area]->size, flags |
KASAN_VMALLOC_KEEP_TAG);
}

This way we won't assign a random tag unless it's actually needed
(i.e. when KASAN_VMALLOC_PROT_NORMAL is not provided; assuming we care
to support that case).

