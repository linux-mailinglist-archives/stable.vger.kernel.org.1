Return-Path: <stable+bounces-198637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D972CA0EF1
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1E233437811
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5547335070;
	Wed,  3 Dec 2025 15:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcZA5isw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B40312805
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777196; cv=none; b=cL4UPzAfVIwp0OQ3z+lqSwrWwInqy7jltWa4rg9wceClvdpMSBwLDvMZ2BG70g/Qhphx3pxn3ZpLe97J8AndmJM2gBkvfm7MWOcHuloT7I7xutGtbQfK+RUWixcdhjHNi5Y9ij5dLH2m7fOLI+xaV4uQljoLP74wGZjprboxxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777196; c=relaxed/simple;
	bh=X0oTl5LzZw+/bc0ubbZJwUMlLrr7c8DxPOFLXaZQjvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNmQsDbKcOpAJd/2MvLFH3LI4yP7/DyU5sz+/AIhn+cVcCNV2ZOFsjjo91yS35PO/J65llqZf6oDjVIUc6aWC0+mm8+yh3jFfAZ64wJJPXzkJudQAlK18efV1K84L1+/LqLroMbHOH2ECgMVDvRMJXXGpyvn7UVL335fw66ZIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcZA5isw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42e2e50c233so1968540f8f.3
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 07:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764777193; x=1765381993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2crlSn5K87P6BhIOUFvHVg2OvJtF8ySKOKkXTHnicII=;
        b=bcZA5isw1PZRJ4XxsIdn+aFrvNw9ZjqKbnUUzMnPlDS7TyYUTrVQHbiXCHfeevL/lU
         axJd/WYQtdYU7xN2EnC4g1OD4fgwPs9UnDtc3yXDUNCuXj+H19PqBCEaP0zYWaN7Sg7C
         +V3f4c1z0DcFSo3i6tX2lmZ2tkg6ccA0qWjwTppztkpJutKdVzh0gxwZ9PfzRkwY7WeP
         Wv2b8PD1xjJfJx4sJSnc5qwWR9W7BcXwSqOUF8+fp0ALoTXPhPvM7txmomPMlWQBW5UJ
         qkZqKKCZbHVUHT3ZI/57ORJFIEEUGxagK+ZXwWBm+uyKYv4DuxYTXzA5jG6mydP8sXWD
         mPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764777193; x=1765381993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2crlSn5K87P6BhIOUFvHVg2OvJtF8ySKOKkXTHnicII=;
        b=Sn8JRu2K84huniiLZdIg9ccvxB8mAq578GXSXh5lYNkZoI97qXQFluhKlvkLMhhXX6
         ZpmYMLMAUZmpKwb4QoyjxZbQ6TrvOLs77bc9X3U7Khypy+OtmM9DODJ2R537LN5wXb1R
         bpOlb2wFK9tkMMtZa1uOS1+EvB+tFAWYFxgwPsKaSC+w75lDxJ8vmAL7OMFFJfzaLVZS
         pk4n18tCHylfM6bnRsUvYibrGjt7dZCHC4AE8ogzuh8KuUHdlqy7FqcyK3lHZcO/tLqc
         kUgIwGJTSBrwC1je8NG2X09NiCAXyX7wwYAD3DA4PfqWpUaIahXydzLPkZuZ72+S0+pO
         mBWA==
X-Forwarded-Encrypted: i=1; AJvYcCUl7rI3h5AFJIoA6E39r/LD26fgaweUKwGMoJ5RiN0UfOiPwr5SRatRhM/fBJErCdbqmQnxn6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlEcHr5u8/4PPx3qSRM0LSjPCsXlzf3RXUHPHHy7xLkLY3Dpo6
	qWTToPEDwx0x+rIoCNAl4UBqEQ4C3RR6zXOr453CihLHZykupiEP0EHt+MSGt7ZXlb6aP9YhEqh
	qkyheV7/SzIwaqF+jCnLRoHv2LbDkV5c=
X-Gm-Gg: ASbGncspAyCRG4Zpge34Fot8cDRJO+3qH9UnO3va3pddaFlLcy9o+0BbjHpI6RA066q
	8dphLiEdV37Ng/AcXFRP2EPMiUT8GnF7mHn47TgeNM1vloWTa9YU1ETjJMgyyfOCHowgA+gX56p
	GiXVlptjXtOrRf6uBsr2yX64m0DOArwkGuahvi+8R5ZUzZyYZVhCyhQdsZlzUjGRcuzLmTpIXCt
	WZqW4TFPYMR1ljZNw2w4UxKe/S0mJmERJwf3xwZRIK7plnaphxxDy5MRrhRpaNIGO9D7RjKUJo7
	plo5UmLaagGz3UWwimycnvDRGhfU4VgQNGgvd98XSBO+
X-Google-Smtp-Source: AGHT+IGVEthIPVzhhHPc503742QRTcWX7tDuLoDjRhTCI8e1jm4EB23dZFS0OfI6wAy+XLFNoXZh5Qvo5IbYTQBjLA8=
X-Received: by 2002:a05:6000:2407:b0:429:66bf:1475 with SMTP id
 ffacd0b85a97d-42f73171fe9mr2836344f8f.3.1764777192950; Wed, 03 Dec 2025
 07:53:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764685296.git.m.wieczorretman@pm.me> <325c5fa1043408f1afe94abab202cde9878240c5.1764685296.git.m.wieczorretman@pm.me>
In-Reply-To: <325c5fa1043408f1afe94abab202cde9878240c5.1764685296.git.m.wieczorretman@pm.me>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 3 Dec 2025 16:53:01 +0100
X-Gm-Features: AWmQ_blDuVtndNbheCozTAbytnRMB29Z6p9yQJJRwDXdD-0EGYk1gIR7FCpOkvo
Message-ID: <CA+fCnZdzBdC4hdjOLa5U_9g=MhhBfNW24n+gHpYNqW8taY_Vzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kasan: Unpoison vms[area] addresses with a common tag
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>, jiayuan.chen@linux.dev
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>, stable@vger.kernel.org, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 3:29=E2=80=AFPM Maciej Wieczor-Retman
<m.wieczorretman@pm.me> wrote:
>
> From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>
> A KASAN tag mismatch, possibly causing a kernel panic, can be observed
> on systems with a tag-based KASAN enabled and with multiple NUMA nodes.
> It was reported on arm64 and reproduced on x86. It can be explained in
> the following points:
>
>         1. There can be more than one virtual memory chunk.
>         2. Chunk's base address has a tag.
>         3. The base address points at the first chunk and thus inherits
>            the tag of the first chunk.
>         4. The subsequent chunks will be accessed with the tag from the
>            first chunk.
>         5. Thus, the subsequent chunks need to have their tag set to
>            match that of the first chunk.
>
> Use the modified __kasan_unpoison_vmalloc() to pass the tag of the first
> vm_struct's address when vm_structs are unpoisoned in
> pcpu_get_vm_areas(). Assigning a common tag resolves the pcpu chunk
> address mismatch.
>
> Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
> Cc: <stable@vger.kernel.org> # 6.1+
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v2:
> - Revise the whole patch to match the fixed refactorization from the
>   first patch.
>
> Changelog v1:
> - Rewrite the patch message to point at the user impact of the issue.
> - Move helper to common.c so it can be compiled in all KASAN modes.
>
>  mm/kasan/common.c  |  3 ++-
>  mm/kasan/hw_tags.c | 12 ++++++++----
>  mm/kasan/shadow.c  | 15 +++++++++++----
>  3 files changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 7884ea7d13f9..e5a867a5670b 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -591,11 +591,12 @@ void kasan_unpoison_vmap_areas(struct vm_struct **v=
ms, int nr_vms,
>         unsigned long size;
>         void *addr;
>         int area;
> +       u8 tag =3D get_tag(vms[0]->addr);
>
>         for (area =3D 0 ; area < nr_vms ; area++) {
>                 size =3D vms[area]->size;
>                 addr =3D vms[area]->addr;
> -               vms[area]->addr =3D __kasan_unpoison_vmap_areas(addr, siz=
e, flags);
> +               vms[area]->addr =3D __kasan_unpoison_vmap_areas(addr, siz=
e, flags, tag);

I'm thinking what you can do here is:

vms[area]->addr =3D set_tag(addr, tag);
__kasan_unpoison_vmalloc(addr, size, flags | KASAN_VMALLOC_KEEP_TAG);

This is with the assumption that Jiayuan's patch is changed to add
KASAN_VMALLOC_KEEP_TAG to kasan_vmalloc_flags_t.

Then you should not need that extra __kasan_random_unpoison_vmalloc helper.


>         }
>  }
>  #endif
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 4b7936a2bd6f..2a02b898b9d8 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -317,7 +317,7 @@ static void init_vmalloc_pages(const void *start, uns=
igned long size)
>  }
>
>  static void *__kasan_unpoison_vmalloc(const void *start, unsigned long s=
ize,
> -                                     kasan_vmalloc_flags_t flags)
> +                                     kasan_vmalloc_flags_t flags, int un=
poison_tag)
>  {
>         u8 tag;
>         unsigned long redzone_start, redzone_size;
> @@ -361,7 +361,11 @@ static void *__kasan_unpoison_vmalloc(const void *st=
art, unsigned long size,
>                 return (void *)start;
>         }
>
> -       tag =3D kasan_random_tag();
> +       if (unpoison_tag < 0)
> +               tag =3D kasan_random_tag();
> +       else
> +               tag =3D unpoison_tag;
> +
>         start =3D set_tag(start, tag);
>
>         /* Unpoison and initialize memory up to size. */
> @@ -390,7 +394,7 @@ static void *__kasan_unpoison_vmalloc(const void *sta=
rt, unsigned long size,
>  void *__kasan_random_unpoison_vmalloc(const void *start, unsigned long s=
ize,
>                                       kasan_vmalloc_flags_t flags)
>  {
> -       return __kasan_unpoison_vmalloc(start, size, flags);
> +       return __kasan_unpoison_vmalloc(start, size, flags, -1);
>  }
>
>  void __kasan_poison_vmalloc(const void *start, unsigned long size)
> @@ -405,7 +409,7 @@ void __kasan_poison_vmalloc(const void *start, unsign=
ed long size)
>  void *__kasan_unpoison_vmap_areas(void *addr, unsigned long size,
>                                   kasan_vmalloc_flags_t flags, u8 tag)
>  {
> -       return __kasan_unpoison_vmalloc(addr, size, flags);
> +       return __kasan_unpoison_vmalloc(addr, size, flags, tag);
>  }
>  #endif
>
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 0a8d8bf6e9cf..7a66ffc1d5b3 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -625,8 +625,10 @@ void kasan_release_vmalloc(unsigned long start, unsi=
gned long end,
>  }
>
>  static void *__kasan_unpoison_vmalloc(const void *start, unsigned long s=
ize,
> -                                     kasan_vmalloc_flags_t flags)
> +                                     kasan_vmalloc_flags_t flags, int un=
poison_tag)
>  {
> +       u8 tag;
> +
>         /*
>          * Software KASAN modes unpoison both VM_ALLOC and non-VM_ALLOC
>          * mappings, so the KASAN_VMALLOC_VM_ALLOC flag is ignored.
> @@ -648,7 +650,12 @@ static void *__kasan_unpoison_vmalloc(const void *st=
art, unsigned long size,
>             !(flags & KASAN_VMALLOC_PROT_NORMAL))
>                 return (void *)start;
>
> -       start =3D set_tag(start, kasan_random_tag());
> +       if (unpoison_tag < 0)
> +               tag =3D kasan_random_tag();
> +       else
> +               tag =3D unpoison_tag;
> +
> +       start =3D set_tag(start, tag);
>         kasan_unpoison(start, size, false);
>         return (void *)start;
>  }
> @@ -656,13 +663,13 @@ static void *__kasan_unpoison_vmalloc(const void *s=
tart, unsigned long size,
>  void *__kasan_random_unpoison_vmalloc(const void *start, unsigned long s=
ize,
>                                       kasan_vmalloc_flags_t flags)
>  {
> -       return __kasan_unpoison_vmalloc(start, size, flags);
> +       return __kasan_unpoison_vmalloc(start, size, flags, -1);
>  }
>
>  void *__kasan_unpoison_vmap_areas(void *addr, unsigned long size,
>                                   kasan_vmalloc_flags_t flags, u8 tag)
>  {
> -       return __kasan_unpoison_vmalloc(addr, size, flags);
> +       return __kasan_unpoison_vmalloc(addr, size, flags, tag);
>  }
>
>  /*
> --
> 2.52.0
>
>

