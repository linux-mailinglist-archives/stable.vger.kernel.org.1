Return-Path: <stable+bounces-198639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23167CA11A9
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05395300311C
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 18:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E59335551;
	Wed,  3 Dec 2025 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClHuxdL9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B706312805
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777199; cv=none; b=sL+EwYJVVpHDCvkRjjOQsAF6L27hOq2KzKduydDq+0/KSKQUUGH98LbQJ9kieQsyH5xsMnDjNFHQ5bTicMTfsgqVwhTpLD5Wggwce814EFm3TOEiP45ioPghoEckpDSB2S7dHmYj2iCQUGZG3oeYx1ZxVDQ5VDtYZ8e739MRuNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777199; c=relaxed/simple;
	bh=fwBtInZY9qPWvGK+66pD6fKFgimnL2e6e0a0mNH5azc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdYYc0tvHssMIBhdDOts/QUTWaO3ZJORTXRzuI5dUaFXQLrQ7jiRAKxquWUddGGbl2B4pp4xjVgOGSFdTGv8fP43olPKkgBavFqp5ycUoxYCNZ9k6l2vzOWWZnnyUXU0owj8oP/zc77urojBcae0MuQrTgExnl/GDeBBUNn4vdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClHuxdL9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2d5e119fso2318555f8f.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 07:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764777195; x=1765381995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbCXDQ9SqAkNCyhh2J6cLNmuXbzuNKSafExnU4lsLPE=;
        b=ClHuxdL9/B1tAdXhkk8rynjs9OgrZwO/MPDdtH7PttCDpee9KKjpGwxAIeeWe4dAn5
         HCd3zoxqrFC0Z+A8dVk2MBmdM5gW/JHLsp5lqYOpSuAqzuRMnpYSqRmwcWiaAK3ccCr3
         iPlxJngRKZIObFMJhaSXK6SpD/klGAVRk/UnenwE66kNT+jp7E5U43alcX1JXS3Do2EZ
         Yv/X3fI1qVWIqgcEWbFbejqw2x64c7HNkCYty65jn6p9o1v1YZPByULoFwXIaL7L5wAQ
         SEnlN4LBeqgj6Csb3JczOcnSMWGxs/rr20J6x2WFx/81cysGDbb3+Kk+q6Bhul55pXNI
         M1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764777195; x=1765381995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UbCXDQ9SqAkNCyhh2J6cLNmuXbzuNKSafExnU4lsLPE=;
        b=uK62dCGFSKjKEMnIz5lwIxKWOtir/kGyx4TEDpND7TXzrtIp1fuF9U61Cgb2iCbcgD
         x+K/SzSL902iEZqLKJeBaMupszbpGVS7QvxR0UaenZ2qVqO5c21VfGFgg35M2q66qSrx
         n0N6jKs4HX6ROO77Tbc7dKV+bsEioRGtwXQXW9dTpnEK//bcPW/amD8oj6/Ibv8ZDDLj
         U9W49x+ynqecl/uBC0uhepbNsvnyO6CwV0ACFnd5SRlS9x8GKTSgzrDMPSAmxdQceqUh
         l5QnFjhMNhPayT1RyKn1Fy+JUHVPgQs2gKg2a2i2X3MHLEGdyTGhRiw2hkNG3BQuHXMw
         3R5A==
X-Forwarded-Encrypted: i=1; AJvYcCUP/eITDYD4nDCnWEOO0xNlbik+hSKwX0mrS47Krv7vWtt7Hk2EAFk02N5OFx9sWTRKB+b9LY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7fMxO+j9eU60j2tgJDh40AdEOcE1JnbKQ+16sY6YDRA7YEzFc
	oMLVJHqdFlsJYEKX8QPljTOtJiNByqaZyIOPBJ1QwhMB5I2bo6zHJL3Jq7pWwxRb2JciQoFvVpC
	xmAAK/2r0emYlyG3AdjyKf6dUzc36ECo=
X-Gm-Gg: ASbGncsAW9ntE6FDPl4M3hsBReqBcVLzAUUCc+Ki4EnSB1AOsZwJeF9EVEa+Fp/lq4u
	1cWzYVFp2yiXNSzdIWGDGCMAlN7jd0rKVSC3KckCt9Fm2zb1yarlvToW27I13J87JBd+SqYfezd
	HUDQk8RgZ9UsypZsqeuZB2nwdmXpdf4qJVIXGnnwoodjcSSl8LOqR7xKRd0Iebfh3Lozt6wmul4
	0BAgap3x2x7hzJg2798VXdY5bViQu3fmSWGUKm1tas4lw/AsdkgOMWDSFXAGctsrynqJV5M9Yuy
	/njHjZgsDWHqoFvdbVTWOIoEYqnq3TyDtg==
X-Google-Smtp-Source: AGHT+IHlgWIguHQqtQJUmTU9clPCoSpB0eZFF4A7hFrVj4ECNhiZ2vK4TnzEqYb6JUFA9cj3Dgx32Onb9P4bwY/6Tdc=
X-Received: by 2002:a05:6000:1449:b0:429:d170:b3d1 with SMTP id
 ffacd0b85a97d-42f7320bea0mr2896527f8f.59.1764777195326; Wed, 03 Dec 2025
 07:53:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764685296.git.m.wieczorretman@pm.me> <3907c330d802e5b86bfe003485220de972aaac18.1764685296.git.m.wieczorretman@pm.me>
In-Reply-To: <3907c330d802e5b86bfe003485220de972aaac18.1764685296.git.m.wieczorretman@pm.me>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 3 Dec 2025 16:53:04 +0100
X-Gm-Features: AWmQ_blEBUtF_kyhGwNBKkD8DFVrkg1o4JirX5I6i5HJ0Jf545_FnpPgl_CXx1E
Message-ID: <CA+fCnZcNoLERGmjyVV=ykD62hPRkPua4AqKE083BBm6OHmGtPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kasan: Refactor pcpu kasan vmalloc unpoison
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, stable@vger.kernel.org, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
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
> Refactor code by reusing __kasan_unpoison_vmalloc in a new helper in
> preparation for the actual fix.
>
> Changelog v1 (after splitting of from the KASAN series):
> - Rewrite first paragraph of the patch message to point at the user
>   impact of the issue.
> - Move helper to common.c so it can be compiled in all KASAN modes.
>
> Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
> Cc: <stable@vger.kernel.org> # 6.1+
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v2:
> - Redo the whole patch so it's an actual refactor.
>
>  include/linux/kasan.h | 16 +++++++++++++---
>  mm/kasan/common.c     | 17 +++++++++++++++++
>  mm/kasan/hw_tags.c    | 15 +++++++++++++--
>  mm/kasan/shadow.c     | 16 ++++++++++++++--
>  mm/vmalloc.c          |  4 +---
>  5 files changed, 58 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index d12e1a5f5a9a..4a3d3dba9764 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -595,14 +595,14 @@ static inline void kasan_release_vmalloc(unsigned l=
ong start,
>
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>
> -void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
> -                              kasan_vmalloc_flags_t flags);
> +void *__kasan_random_unpoison_vmalloc(const void *start, unsigned long s=
ize,
> +                                     kasan_vmalloc_flags_t flags);
>  static __always_inline void *kasan_unpoison_vmalloc(const void *start,
>                                                 unsigned long size,
>                                                 kasan_vmalloc_flags_t fla=
gs)
>  {
>         if (kasan_enabled())
> -               return __kasan_unpoison_vmalloc(start, size, flags);
> +               return __kasan_random_unpoison_vmalloc(start, size, flags=
);
>         return (void *)start;
>  }
>
> @@ -614,6 +614,11 @@ static __always_inline void kasan_poison_vmalloc(con=
st void *start,
>                 __kasan_poison_vmalloc(start, size);
>  }
>
> +void *__kasan_unpoison_vmap_areas(void *addr, unsigned long size,
> +                                 kasan_vmalloc_flags_t flags, u8 tag);
> +void kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
> +                              kasan_vmalloc_flags_t flags);
> +
>  #else /* CONFIG_KASAN_VMALLOC */
>
>  static inline void kasan_populate_early_vm_area_shadow(void *start,
> @@ -638,6 +643,11 @@ static inline void *kasan_unpoison_vmalloc(const voi=
d *start,
>  static inline void kasan_poison_vmalloc(const void *start, unsigned long=
 size)
>  { }
>
> +static __always_inline void
> +kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
> +                         kasan_vmalloc_flags_t flags)
> +{ }
> +
>  #endif /* CONFIG_KASAN_VMALLOC */
>
>  #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && =
\
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index d4c14359feaf..7884ea7d13f9 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -28,6 +28,7 @@
>  #include <linux/string.h>
>  #include <linux/types.h>
>  #include <linux/bug.h>
> +#include <linux/vmalloc.h>
>
>  #include "kasan.h"
>  #include "../slab.h"
> @@ -582,3 +583,19 @@ bool __kasan_check_byte(const void *address, unsigne=
d long ip)
>         }
>         return true;
>  }
> +
> +#ifdef CONFIG_KASAN_VMALLOC
> +void kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
> +                              kasan_vmalloc_flags_t flags)

kasan_unpoison_vmap_areas() needs to be defined in
inclunde/linux/kasan.h and call __kasan_unpoison_vmap_areas() when
kasan_enabled() =3D=3D true, similar to the other wrappers.

And check my comment for patch #2: with that, you should not need to
add so many new __helpers: just __kasan_unpoison_vmalloc and
__kasan_unpoison_vmap_areas should suffice.


> +{
> +       unsigned long size;
> +       void *addr;
> +       int area;
> +
> +       for (area =3D 0 ; area < nr_vms ; area++) {
> +               size =3D vms[area]->size;
> +               addr =3D vms[area]->addr;
> +               vms[area]->addr =3D __kasan_unpoison_vmap_areas(addr, siz=
e, flags);
> +       }
> +}
> +#endif
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 1c373cc4b3fa..4b7936a2bd6f 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -316,8 +316,8 @@ static void init_vmalloc_pages(const void *start, uns=
igned long size)
>         }
>  }
>
> -void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
> -                               kasan_vmalloc_flags_t flags)
> +static void *__kasan_unpoison_vmalloc(const void *start, unsigned long s=
ize,
> +                                     kasan_vmalloc_flags_t flags)
>  {
>         u8 tag;
>         unsigned long redzone_start, redzone_size;
> @@ -387,6 +387,12 @@ void *__kasan_unpoison_vmalloc(const void *start, un=
signed long size,
>         return (void *)start;
>  }
>
> +void *__kasan_random_unpoison_vmalloc(const void *start, unsigned long s=
ize,
> +                                     kasan_vmalloc_flags_t flags)
> +{
> +       return __kasan_unpoison_vmalloc(start, size, flags);
> +}
> +
>  void __kasan_poison_vmalloc(const void *start, unsigned long size)
>  {
>         /*
> @@ -396,6 +402,11 @@ void __kasan_poison_vmalloc(const void *start, unsig=
ned long size)
>          */
>  }
>
> +void *__kasan_unpoison_vmap_areas(void *addr, unsigned long size,
> +                                 kasan_vmalloc_flags_t flags, u8 tag)
> +{
> +       return __kasan_unpoison_vmalloc(addr, size, flags);
> +}
>  #endif
>
>  void kasan_enable_hw_tags(void)
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 5d2a876035d6..0a8d8bf6e9cf 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -624,8 +624,8 @@ void kasan_release_vmalloc(unsigned long start, unsig=
ned long end,
>         }
>  }
>
> -void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
> -                              kasan_vmalloc_flags_t flags)
> +static void *__kasan_unpoison_vmalloc(const void *start, unsigned long s=
ize,
> +                                     kasan_vmalloc_flags_t flags)
>  {
>         /*
>          * Software KASAN modes unpoison both VM_ALLOC and non-VM_ALLOC
> @@ -653,6 +653,18 @@ void *__kasan_unpoison_vmalloc(const void *start, un=
signed long size,
>         return (void *)start;
>  }
>
> +void *__kasan_random_unpoison_vmalloc(const void *start, unsigned long s=
ize,
> +                                     kasan_vmalloc_flags_t flags)
> +{
> +       return __kasan_unpoison_vmalloc(start, size, flags);
> +}
> +
> +void *__kasan_unpoison_vmap_areas(void *addr, unsigned long size,
> +                                 kasan_vmalloc_flags_t flags, u8 tag)
> +{
> +       return __kasan_unpoison_vmalloc(addr, size, flags);
> +}
> +
>  /*
>   * Poison the shadow for a vmalloc region. Called as part of the
>   * freeing process at the time the region is freed.
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 798b2ed21e46..32ecdb8cd4b8 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4870,9 +4870,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned=
 long *offsets,
>          * With hardware tag-based KASAN, marking is skipped for
>          * non-VM_ALLOC mappings, see __kasan_unpoison_vmalloc().
>          */
> -       for (area =3D 0; area < nr_vms; area++)
> -               vms[area]->addr =3D kasan_unpoison_vmalloc(vms[area]->add=
r,
> -                               vms[area]->size, KASAN_VMALLOC_PROT_NORMA=
L);
> +       kasan_unpoison_vmap_areas(vms, nr_vms, KASAN_VMALLOC_PROT_NORMAL)=
;
>
>         kfree(vas);
>         return vms;
> --
> 2.52.0
>
>

