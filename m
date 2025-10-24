Return-Path: <stable+bounces-189181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E91C0402C
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 03:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99BAD4E905B
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 01:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2741C1F0C;
	Fri, 24 Oct 2025 01:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3MSdKDJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7901A2547
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761268812; cv=none; b=StPwebaYmq+N1oZhN+nmj4qOT8+bGYYDFEPbWX3I14rnnqFxjHD+OuIx2rwQzbXi2TRj4Ej0ujYAxX07a2hwit1fxxyoLLg/+V5+ONOXNl47D24YmeIZ2DKhO87H0vQ2vZpaNW7ZHoF/qnCt+emw7ofl3qlUqsouFNGJCMFpH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761268812; c=relaxed/simple;
	bh=8IYAyusncA0WDWQnsh5pBKEVIwZxhk9CGVxXMJ7jxGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sq1MSg1kUh/GmSfkgMKr+yAIp5IcV23hK+amEpIRXXDQSr0SE3sjEgN5BYjyaS2+LSF/m3IqQ+y3xKYTChfvTXo1p3qemZY3/bT6WPxa2sBQd+Ojyvm6oqRahSFmrqfc29/Sb6A2vVzLcyB0fV/XIPgYhaYwB/nU1kNh+8TttH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3MSdKDJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so8439435e9.0
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 18:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761268809; x=1761873609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cy50PIQ5NMkORVfUN5Id2ZgmraUO4+QWD/JL9v9VhXk=;
        b=U3MSdKDJyGV0VN95Fo8Qj0o9kYcaTL6FCjlRTv79vjZq0Ol9zmpedCAGjeTgON5EqJ
         n4CnAm02ufLW6aALLuwG/0qaL00Jr68SrIJ+jhU2WaVUoQPswRr1fVrtdUr8Cq9mToBl
         s3Zoh1S8UQS06nkItFKvd33wJgYQ/mCZ/8KXzyTGUcs/KrWg3MpJ/SMvf8XkRpwcvQO4
         nkJT7VN6od+mvxmHgxxz4hvFtQL4f05Z6FKs9+hw05fN3TCadLcLo0gmhYtQnr9SnDHZ
         IJkTCw+4SZNO26CJSbtHa1V8YRF8aN3z4Xv95E9etBDx315UZ1UR7wD1AXK4a+tvbapN
         IrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761268809; x=1761873609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cy50PIQ5NMkORVfUN5Id2ZgmraUO4+QWD/JL9v9VhXk=;
        b=vm7KM3k6GiVXibQT44LpI4wJHG4Ed3YssGO/SqMxxqnYl4n7w4AVvRZWQ4dJcFvr8j
         IUy3XHksnPCmI5xYA8WCi5WoeRP43kDI+mcK2ry+6sCH7Lz6cd85xSiCaUHukCXpEYY0
         FuTw40hIeq3e08kX3//QfDZyflABQtCnKVZMfyPtmeKUJTjVO4NMZTa1twgjIqzzLr7i
         ED9qIEwh+0tmhFSrjXE8cq0CO8E2h5+vJ3j4widsm++QzaNORIkIygi4vEOvkbsRNBTR
         Sq7KlCkNBxKeBWn3NDycFqjV1IQS5DmQ4CgE9bT/PrjePs4sIxQ4gUTfoDp3R2GVfS9l
         rA2w==
X-Forwarded-Encrypted: i=1; AJvYcCWOxPyvuib2dYAYX6US62kyTkvSQL7WK2n92u3B9bOsaZeiTVTb6tq4eqPQa5dQ1cyw0lUu6Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7W4++Url200bPOHdrN/RezqI40szCFPiXZ4/sELUBSjvTRWpL
	9vkxENWk7TG0EDmniJJ9VRMckTxNepzNGg+w2bMi+90cr/A119QEuzwfOgj/ox6L0kZ0731jjn9
	eGV7FjcduVLeAgzm3IcyNT1ezTrGfobs=
X-Gm-Gg: ASbGncvMp5y7Z1aF3MimvQirEmhQLk1tTNf3+F/EfG9PlHM8jOnbLYBmx7AGFkEUlyh
	kaR36kd1r2dcaOAY5X1ejaUJ93MyfcJLfKmsSCO10B8uiIKkMsGNPzZrPNw4fk20I2t5k2+vt4Y
	pa3g6M5005cd7Um0JAs/LMXTvJqM3pBEQBFJsvGArcJvwIzg6PGMeJVYbA8qYfH1Zbtga0i78bg
	W5yUpzHZfOrtxtgiFELzNVukDnKyOHArRwGzoodnWh696IS8tdlHAoXijVmGzrJ19Vznh14maH8
	p9ncUMwUf85izlv5k4Q0x1KYfQKJMg==
X-Google-Smtp-Source: AGHT+IFcsv1if8cvL8kTlEejCx/FQgqyt5yCy0bJs0SYJkx4Iq5kMise7FkEaCwdtzjswF2CqR/fouTnY/43pxfDv9c=
X-Received: by 2002:a05:6000:240f:b0:426:d582:14a3 with SMTP id
 ffacd0b85a97d-4298a040705mr2343679f8f.9.1761268808604; Thu, 23 Oct 2025
 18:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023131600.1103431-1-harry.yoo@oracle.com> <aPrLF0OUK651M4dk@hyeyoo>
In-Reply-To: <aPrLF0OUK651M4dk@hyeyoo>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 24 Oct 2025 03:19:57 +0200
X-Gm-Features: AWmQ_bm41GuiWsYtz5XuMNDIQQhr0EMvmp-bLNyUrjc6_dWg-wZ67Ora4xbHgfU
Message-ID: <CA+fCnZezoWn40BaS3cgmCeLwjT+5AndzcQLc=wH3BjMCu6_YCw@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: ensure all metadata in slab object are word-aligned
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
	Alexander Potapenko <glider@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Feng Tang <feng.79.tang@gmail.com>, 
	Christoph Lameter <cl@gentwo.org>, Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 2:41=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> Adding more details on how I discovered this and why I care:
>
> I was developing a feature that uses unused bytes in s->size as the
> slabobj_ext metadata. Unlike other metadata where slab disables KASAN
> when accessing it, this should be unpoisoned to avoid adding complexity
> and overhead when accessing it.

Generally, unpoisoining parts of slabs that should not be accessed by
non-slab code is undesirable - this would prevent KASAN from detecting
OOB accesses into that memory.

An alternative to unpoisoning or disabling KASAN could be to add
helper functions annotated with __no_sanitize_address that do the
required accesses. And make them inlined when KASAN is disabled to
avoid the performance hit.

On a side note, you might also need to check whether SW_TAGS KASAN and
KMSAN would be unhappy with your changes:

- When we do kasan_disable_current() or metadata_access_enable(), we
also do kasan_reset_tag();
- In metadata_access_enable(), we disable KMSAN as well.

> This warning is from kasan_unpoison():
>         if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
>                 return;
>
> on x86_64, the address passed to kasan_{poison,unpoison}() should be at
> least aligned with 8 bytes.
>
> After manual investigation it turns out when the SLAB_STORE_USER flag is
> specified, any metadata after the original kmalloc request size is
> misaligned.
>
> Questions:
> - Could it cause any issues other than the one described above?
> - Does KASAN even support architectures that have issues with unaligned
>   accesses?

Unaligned accesses are handled just fine. It's just that the start of
any unpoisoned/accessible memory region must be aligned to 8 (or 16
for SW_TAGS) bytes due to how KASAN encodes shadow memory values.

> - How come we haven't seen any issues regarding this so far? :/

As you pointed out, we don't unpoison the memory that stores KASAN
metadata and instead just disable KASAN error reporting. This is done
deliberately to allow KASAN catching accesses into that memory that
happen outside of the slab/KASAN code.

