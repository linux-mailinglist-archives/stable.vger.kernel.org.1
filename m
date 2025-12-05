Return-Path: <stable+bounces-200092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 305ACCA5CAB
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 02:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36F79317C458
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 01:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95782066DE;
	Fri,  5 Dec 2025 01:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbweWum0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97250213E89
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764896957; cv=none; b=XsieIiRXFP0VMxcW5Riy6Bcr4zvjGeByYWAHTrRfewm9rDfRQ4CPQKksnCNCVtaVvzT0gL4Hd6NNnXrxRyhfY9uSZDDRg3Rs82RpJGre/mXvP+EAagRDBYGTKeaujLisLh39cKXaoZlwDQ949DIA5xV4rcwjK4PxpUclhbbbiz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764896957; c=relaxed/simple;
	bh=rMRBv/ChXqoLELq8qKykFWomxTtcupwUcOcKG7qeZeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHl/XgBnF1IiGs/gEu33K0/ICvwejhVucnchXH2r1XEUb1rSSLdA8ZRpOVaxdbEiOF9pUSPD9ZBe7RQtGOQL7nNpPPI7MQkdzQ+w1Vzg6pfocSODON5Se7OVt+DPiKrgx/XL85vUgSTgKZ3kJ7HuPhtQVpdFpAahMFfB/XnOa1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbweWum0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42e2b90ad22so679231f8f.2
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 17:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764896954; x=1765501754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+mF3Gja/Pth6t91/XACwIVYUz7EioOwwJ2M/LMKxqY=;
        b=LbweWum0RlskAexYY8+YqyvKAGGstZi/DCVt5I9ZJGsqxMJL3AoB6VKiMixuUrKrVP
         kmRqmio6VcpZT/HCJNpxVGwd0muD+WAKKRHRrPW4969CXHQ413eAwWfs3kU97AUdh3El
         ARGy1FU8PRY15bjI0W7env9QMqYaj1f6ZZIv2Y3MI6jb7WHVNgjrsvN7nY3+tKgSlCic
         gjdoSpgpD2I6Jjpe9NuwVW9aLolzn6JJJY42doI/4OVLOBNL8DKviQmy5LKQwfHd74zz
         t2wSuDXgxS6VV2s2UZ8ZczFHN7xB99yaS3GHK5XjD7JM4x/UAxUQFJgsCLaeoRWapLTY
         FBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764896954; x=1765501754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m+mF3Gja/Pth6t91/XACwIVYUz7EioOwwJ2M/LMKxqY=;
        b=EpiGBpmX91krygkY66hywpN8YWZWqHi78EwL8+f+XuhgGHT3rHb/SKtl+4SwNY+1JH
         +LNPb+Jt/JU9GARMCTDFtisEl3libDuJNLstF8oh8T+KdeKvgebRHSs7Zd0JNB++2LD5
         ifX3O++u8TOY6DVL+KVUH8fJsBX+1et3OWE5rypMoGYp8kCVLH8eDONEHZHTjgEjWlCU
         nNHmxSS9/3qTo2sRC6gsJv/j0NHKCg296rNuVtfr68t79/awl0tipaC7DrpY6VP08+nY
         sDIdm2n2Ll5tdTBd1nsHtVY68CJwB3d3NX44TuQfWvkoaOJWUWfIkJwZ+yuH/s+XYZRE
         6pkA==
X-Forwarded-Encrypted: i=1; AJvYcCXqG2b6i0IrSl94E6HZjL+DjD54lL58PC8x2xF+z0XiEXcmY0z97nNjbwIpxGPhSX6svpEee9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRaQKs4u2IWBta93R10ZiQrO7zMEnBLwVgCXV7VYdgx4FDE0/Y
	nySew1U8m+6Wb0lr1NymqZDFE4NcN43sIvHLxekZObSrkatVoBJSjz6zCmD9pHqki9ahvIpPxJK
	XHzAV8zwgOOOw7picuWJtrXAdSbMBlus=
X-Gm-Gg: ASbGncvIiOU86aZfIcpQHZnzXzJjPtmAiHurT3RrhP5uvCxt/onLZ/hHQea62cSICvQ
	fGPSsmzshbteSfznsBp0H88cMKcECocGuGsF0lDSgiGz/wp1M8V6WblPzhRiRjs4O/GovyUEYo0
	4d7rPawwTyUK/YwYUA+UEv16bgWlwMniireZSA331j/OvxouShdfqleAUrXkVuZxEQZF568MqwG
	wF8Lt+Mb5fFS/w+njfYUsxuF9LuPcZq5tNzOlqOUwlrm4HyX+62S1v1gucf2Wgp8qnd/Is+qaSy
	W6mFRjMA6enDfdrF3+zH0ujcp9721K9l
X-Google-Smtp-Source: AGHT+IHrLxvQquVzeBGBF0tieKiREZvd+gfKaW/+zjkJAmLlTU45HN5GIeGBuFV6OBvncx3R42+sl70O/V0jBzKjc54=
X-Received: by 2002:a05:6000:1887:b0:42b:2f90:bd05 with SMTP id
 ffacd0b85a97d-42f731c3290mr7979343f8f.45.1764896953705; Thu, 04 Dec 2025
 17:09:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764874575.git.m.wieczorretman@pm.me> <eb61d93b907e262eefcaa130261a08bcb6c5ce51.1764874575.git.m.wieczorretman@pm.me>
In-Reply-To: <eb61d93b907e262eefcaa130261a08bcb6c5ce51.1764874575.git.m.wieczorretman@pm.me>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 5 Dec 2025 02:09:02 +0100
X-Gm-Features: AQt7F2q4Ra3kjpdEcyDMUb7m8yHahuZhZTyWN3KMRPGCVySA_YBmuHFHNlC1cSE
Message-ID: <CA+fCnZfRTyNbRcU9jNB2O2EeXuoT0T2dY9atFyXy5P0jT1-QWw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kasan: Refactor pcpu kasan vmalloc unpoison
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Marco Elver <elver@google.com>, jiayuan.chen@linux.dev, stable@vger.kernel.org, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 8:00=E2=80=AFPM Maciej Wieczor-Retman
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

Nit: Can put this part after ---.

>
> Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
> Cc: <stable@vger.kernel.org> # 6.1+
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v3:
> - Redo the patch after applying Andrey's comments to align the code more
>   with what's already in include/linux/kasan.h
>
> Changelog v2:
> - Redo the whole patch so it's an actual refactor.
>
>  include/linux/kasan.h | 15 +++++++++++++++
>  mm/kasan/common.c     | 17 +++++++++++++++++
>  mm/vmalloc.c          |  4 +---
>  3 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 6d7972bb390c..cde493cb7702 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -615,6 +615,16 @@ static __always_inline void kasan_poison_vmalloc(con=
st void *start,
>                 __kasan_poison_vmalloc(start, size);
>  }
>
> +void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
> +                                kasan_vmalloc_flags_t flags);
> +static __always_inline void
> +kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
> +                         kasan_vmalloc_flags_t flags)
> +{
> +       if (kasan_enabled())
> +               __kasan_unpoison_vmap_areas(vms, nr_vms, flags);
> +}
> +
>  #else /* CONFIG_KASAN_VMALLOC */
>
>  static inline void kasan_populate_early_vm_area_shadow(void *start,
> @@ -639,6 +649,11 @@ static inline void *kasan_unpoison_vmalloc(const voi=
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
> index d4c14359feaf..1ed6289d471a 100644
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
> +void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
> +                                kasan_vmalloc_flags_t flags)
> +{
> +       unsigned long size;
> +       void *addr;
> +       int area;
> +
> +       for (area =3D 0 ; area < nr_vms ; area++) {
> +               size =3D vms[area]->size;
> +               addr =3D vms[area]->addr;
> +               vms[area]->addr =3D __kasan_unpoison_vmalloc(addr, size, =
flags);
> +       }
> +}
> +#endif
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 22a73a087135..33e705ccafba 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4872,9 +4872,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned=
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

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

