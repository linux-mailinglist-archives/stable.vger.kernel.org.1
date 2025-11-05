Return-Path: <stable+bounces-192462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A00D7C339C9
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 02:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 546AA4F50AE
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 01:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA1D245008;
	Wed,  5 Nov 2025 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoeCCMr5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8613D38DEC
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 01:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305185; cv=none; b=bjHdVVF7eCxVHVrzQaAYGXkrPqryweS8O6uLk1NKX+A7TQI1TQ1Qykiz6k5+BOBAnmXFowGzfMVw/m291cRI9TH2C+AYXoc5YlSAiZX4OLjYZ3s17XUxBEubEN7peOfSQYUb1bDz4rB5NDCdfTZg0SMjlYexBLdDo6P8d5xYXtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305185; c=relaxed/simple;
	bh=6InYZMQeFqt2ZvaTGOM1WmDa5UNCTyaEikpDbM/eRFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZA//Qe16cBkyfpd4IrhXW++8M8YqzKFu/dFMikLNSDWm39G4g3P37IaaHs0BqNjEgG6UEScEUFqbT2ipNEB7fxNfKRFboqlWLQbgk7Ls4Fg7B5lWAg6GuFaWO4e1ieCTtv1FXZZs5Lpj6bT1pDk5Qu1Sc+f44plpIkeZrDT9fVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoeCCMr5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429cf861327so727650f8f.0
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 17:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762305181; x=1762909981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEppFMrKLaYig4LQcDZc9JttD0i9i7R12SVoQFz4438=;
        b=HoeCCMr59bUh5Pn4LpGf7d6DgQ858lErzq0t02nfDD+eJa41gdrE4TbSIgTJUtlgVy
         tEsuLKyjkpZCkaH3xtfvVR3FDnsvkR9//zaY0BmHikG3Tp8iDDKvBDP8EMA8bWacMslV
         D4X2Pkhh59eY2csPfM8oGmSwj6rv/3//hviNwZIbrZ2fVoUb+e2sJwBpruZ2yeWiZGb1
         V5aE1pmOtrG28oAd0n7PQW42KSP8TxZfzYFXYPSquvDuNJvZoRhRVnJv7TX/VeJIv+Mx
         JB4WBre8RU4pkGQE++fQ4WsCyNq4BaH4tlvft0hLNpI/joqFb5no7aYjGcGWS4vifU9l
         Tlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762305181; x=1762909981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEppFMrKLaYig4LQcDZc9JttD0i9i7R12SVoQFz4438=;
        b=O2eaTQ0VxRimEX3yoKXa/2/bdUmWaMVgYmzYgj6ddcil/vlO9RCZHM9WDO4Ad8IDSf
         m0+3aN8Wj1Y5bvRdm5rMdBilNbfOceTqx49DRs9BUXQwYrQSyzlTl1ypF606T5PBlaVT
         Wbxq0bp3tquewra/2mjmJU46I2/vR0jlQ+M++15kXQ0+y7byJJTSIttrmQLiQiVQYOm7
         iXWY/ufNB1I8OLmEIaQnUQmxby8NA7vjia6CU+gyih7VYrumjSYXgi3yZ6UQkYOCJKCt
         Va6LbHyi9apDKB7QKd+t76AudUHBKMalbeS/QF9T8c28UM+CkP4qQbxRm18otmmLXhxw
         lPXg==
X-Forwarded-Encrypted: i=1; AJvYcCVZMO6ke5n6Kk5K4SAUVlUJMx5A0PeHRhbqQLtMaxWnwNQ932QZoQzknIJ4XivMtV+6zrWvHbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYFiKU1xcOyBlnYXTSlRg53fNc8pcKCb+cXPSluOsij6YuO9W
	ZjLGq1WCaWwVQKILs511wGNCpBCLNVIBVWQJJChXC4LpvWanXTXPb32y6xM1U0t3UdYAJ1RJ5Ys
	GviKeEx6cSVSMQ4B0dNgs+YnLWk3VwVY=
X-Gm-Gg: ASbGncvkRcCTaUsa8EdGmQrwX09P4qzi/CNli5kmpl8rT2Pox/TWvGDxxxbVYvbdnx1
	EEEkKp6dSlRNUaFdeUsAXDh4uWiB9ZU+jpXUWXJ3veHEDFNB1Pd+b4UzShazxKprhN/f3J0MSCM
	wGr3xFRo83gu3VmxFcVsXLvJqHRExSl4gKbB3cQK8y/Cg+au8lypToKljf8QbjHFFCtv0UhGodV
	s2RbyK7thdwpLI14Cp8aQuj3jqYH740U3Vf+fEPgCUfZhZBRZIhwgkxRuX2dEvGAakOilLscYGO
	KQYXV5iwJFUl11B1czw=
X-Google-Smtp-Source: AGHT+IHCfgX3Z/LDuYoZSbqXwRjysY8+m7ec0N9w0xsi4VyTAQkq2Kw1AUpHu8Gn9+Htyk3mcPXjzFztaSDlGgcNE8c=
X-Received: by 2002:a05:6000:310a:b0:425:76e3:81c5 with SMTP id
 ffacd0b85a97d-429e32e9294mr950863f8f.17.1762305180706; Tue, 04 Nov 2025
 17:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762267022.git.m.wieczorretman@pm.me> <821677dd824d003cc5b7a77891db4723e23518ea.1762267022.git.m.wieczorretman@pm.me>
In-Reply-To: <821677dd824d003cc5b7a77891db4723e23518ea.1762267022.git.m.wieczorretman@pm.me>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 5 Nov 2025 02:12:49 +0100
X-Gm-Features: AWmQ_bnQFmPxXQdMPzkfEOvXBlnPN2_-SgGdaVU5DLbX3hNjDp0f9mJkSXaOTEE
Message-ID: <CA+fCnZefD8F7rMu3-M4uDTbWR5R8y7qfLzjrB34sK3bz4di03g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] kasan: Unpoison pcpu chunks with base address tag
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, stable@vger.kernel.org, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Baoquan He <bhe@redhat.com>, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:49=E2=80=AFPM Maciej Wieczor-Retman
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
> Refactor code by moving it into a helper in preparation for the actual
> fix.
>
> Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
> Cc: <stable@vger.kernel.org> # 6.1+
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Tested-by: Baoquan He <bhe@redhat.com>
> ---
> Changelog v1 (after splitting of from the KASAN series):
> - Rewrite first paragraph of the patch message to point at the user
>   impact of the issue.
> - Move helper to common.c so it can be compiled in all KASAN modes.
>
>  include/linux/kasan.h | 10 ++++++++++
>  mm/kasan/common.c     | 11 +++++++++++
>  mm/vmalloc.c          |  4 +---
>  3 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index d12e1a5f5a9a..b00849ea8ffd 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -614,6 +614,13 @@ static __always_inline void kasan_poison_vmalloc(con=
st void *start,
>                 __kasan_poison_vmalloc(start, size);
>  }
>
> +void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms);
> +static __always_inline void kasan_unpoison_vmap_areas(struct vm_struct *=
*vms, int nr_vms)
> +{
> +       if (kasan_enabled())
> +               __kasan_unpoison_vmap_areas(vms, nr_vms);
> +}
> +
>  #else /* CONFIG_KASAN_VMALLOC */
>
>  static inline void kasan_populate_early_vm_area_shadow(void *start,
> @@ -638,6 +645,9 @@ static inline void *kasan_unpoison_vmalloc(const void=
 *start,
>  static inline void kasan_poison_vmalloc(const void *start, unsigned long=
 size)
>  { }
>
> +static inline void kasan_unpoison_vmap_areas(struct vm_struct **vms, int=
 nr_vms)
> +{ }
> +
>  #endif /* CONFIG_KASAN_VMALLOC */
>
>  #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && =
\
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index d4c14359feaf..c63544a98c24 100644
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
> @@ -582,3 +583,13 @@ bool __kasan_check_byte(const void *address, unsigne=
d long ip)
>         }
>         return true;
>  }
> +
> +void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms)
> +{
> +       int area;
> +
> +       for (area =3D 0 ; area < nr_vms ; area++) {
> +               kasan_poison(vms[area]->addr, vms[area]->size,
> +                            arch_kasan_get_tag(vms[area]->addr), false);

The patch description says this patch is a refactoring, but the patch
changes the logic of the code.

We don't call __kasan_unpoison_vmalloc() anymore and don't perform all
the related checks. This might be OK, assuming the checks always
succeed/fail, but this needs to be explained (note that there two
versions of __kasan_unpoison_vmalloc() with different checks).

And also we don't assign a random tag anymore - we should.

Also, you can just use get/set_tag(), no need to use the arch_ version
(and in the following patch too).





> +       }
> +}
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 798b2ed21e46..934c8bfbcebf 100644
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
> +       kasan_unpoison_vmap_areas(vms, nr_vms);
>
>         kfree(vas);
>         return vms;
> --
> 2.51.0
>
>

