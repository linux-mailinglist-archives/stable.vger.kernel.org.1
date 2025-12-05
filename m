Return-Path: <stable+bounces-200093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F247ACA5CAE
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 02:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89B7A3171BC8
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 01:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E2C215F42;
	Fri,  5 Dec 2025 01:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr0ugwhJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F62135B8
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 01:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764896962; cv=none; b=BZtM+PohL9dPx0SBBPwYd6HfK/vYUlh7/Ku7AdGU4894OaZlQmUhZNmxoT/2HNCo1L6FdrkK6vDWyrs14p2HQE3nveWlTj8qYKlq+cZ1hevnld5fsVrZgg0TcLI7MTdUPoGr2HSvRbJXkOeRq1gCwPLbEwH1XWbow3O7lMSb4w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764896962; c=relaxed/simple;
	bh=HeZKtPzw9NHyXnHEJvwFc57rnxZGHdmwSDicdlQ/Bao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsAwmiCh1ggHx+fUeKbw2PMQNW1TU8mZ8sFlCFCQ+lih8mmIaCvBKj9jZSfy+2IWxLaEOBD0PP/IOFrCyBC1736FcpU1gkc2OLanY1eWWguyDZO66iD0hs+q/LM72hJRVaWILXMsgYFOuktgEINnnSKcU0tflBib3vszmxY3ETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr0ugwhJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42e2e671521so1042167f8f.1
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 17:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764896958; x=1765501758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1CMGYCKUig7gpcSJTE0d5scwAdKO9yGMHIMC90eJ0c=;
        b=Wr0ugwhJ2S++1l1xsDVjWFVxba2rIQ6DACmuZY/XC9s6OnaFTcYFIPraowQ1zc/3uK
         +bjU6J/LUNtQM/815pXb/zqZAQRmPEHzV6xXnSotzp6eLa3AHXzK166n2mTb3jjptgK6
         3FoV/kncWxOfUnVgZSjvcoasNKrJD+CD48MNBwqQllXq7qGTOMg04+7d0YHUIkjtCf7C
         MmiN2WrP4bwVIALiWbWlJyrN+CGo21Y/ZjDBdphjEoy1wDwQaLAZ89y0RXLwIm+mczOd
         +jo3pNK+EkPGff0YKwkx04E36YvDhFkmPORAp8xkdDZoQDMyZ5xF2vq3Hy9R/ful/G0D
         RX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764896958; x=1765501758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P1CMGYCKUig7gpcSJTE0d5scwAdKO9yGMHIMC90eJ0c=;
        b=Kj6wBZjLiM5xGM3kYgFd0fESN7LNmlvgBTfQwOV7oDR202Tm0n6IJvebAyI/iwRpvq
         7vI8p10Qw/X84SRJKWr6Xp4+iFsL46BQHRytvfI+aNTCtuCXaA1yzfWXKDgg6CA3g2zm
         Y3DUqrnxd3KHaKmVSDEZSQOo1jr0oFLwXfvjd6RDS++yOrLB60XKXyRs64gZc2c/4SLl
         r1EThrsYGcx3eZeIG+0+qA1wbT26YxKiYmDF8Lm4bz2G730fTR3M0zCRIYxYzgvpsAIo
         Cjbfuuz8wjaWY5MA0bY0T7QgRmloYH0H7lXCyCia60R5JvAo2kMj6O4n/5KnrnncJ5q4
         eUVw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ6p49ybKvwJv/1mhIhwPQe0gc6WYiMT2ZVhubl8MM1peQxDqmU/iC1eYTsAe5yYp47fbZ7o0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze1V2YJm42+IKaKAG+ryFHnSvKJ8Z0CnIQAKyP37Zu+PBcLSiW
	IvCILH2QkbJDuWijMHmnAvre1awi3Mc7hK308VX2GdV2NsXjE1BRPVjgRxi18E7ttOvw4oNV3o6
	FBiLWR9FQrxao7pEXrjdIcZvvA3wqcjA=
X-Gm-Gg: ASbGnctWriiE3GaRybFXvdkmM5f8Y5soTYd24//n1mfPoMKYOFDpcZrWYrEtsW++y/f
	JiX9zbPyTO1OzfrbA4Mh2l5a2FBlW93lhRTBjuF0KPLivBk7OGLRSwumlNK9g736T1n6D3kZlnp
	IMuXoG+pGzITXwygGup63795W0spZT6xfxTXpV+UPl4v3Jp0UxCZjREx2dTxa7DGzT8/pmYwaVj
	zDd/VIGGpcoRaAXqsm4TYhaB1qepvUJ0QmUGrI1zDhmUHG752XUhRT1IbtgjrJemA/sDcsIoESC
	0yoc4KojccVr5Y4deR0XOreTUQilppUQk+uLbQcFVb8=
X-Google-Smtp-Source: AGHT+IG7NRtC5NzLh6PjBtSNPzjlWlLqBillUgmBkpdL27TkwBaqjqvlRHVG5YbPeI/4mVrxrLB1QDd37dPHR1UMYK4=
X-Received: by 2002:a05:6000:2893:b0:42f:7601:899c with SMTP id
 ffacd0b85a97d-42f7985e948mr4707442f8f.50.1764896958124; Thu, 04 Dec 2025
 17:09:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1764874575.git.m.wieczorretman@pm.me> <873821114a9f722ffb5d6702b94782e902883fdf.1764874575.git.m.wieczorretman@pm.me>
In-Reply-To: <873821114a9f722ffb5d6702b94782e902883fdf.1764874575.git.m.wieczorretman@pm.me>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 5 Dec 2025 02:09:06 +0100
X-Gm-Features: AQt7F2pwGQslVbX98n-X35KQ99_jXpXs5BPWa6Oqbo-7MPEh__0kv49yZSFAeOY
Message-ID: <CA+fCnZeuGdKSEm11oGT6FS71_vGq1vjq-xY36kxVdFvwmag2ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kasan: Unpoison vms[area] addresses with a common tag
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Marco Elver <elver@google.com>, jiayuan.chen@linux.dev, 
	stable@vger.kernel.org, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
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
> Use the new vmalloc flag that disables random tag assignment in
> __kasan_unpoison_vmalloc() - pass the same random tag to all the
> vm_structs by tagging the pointers before they go inside
> __kasan_unpoison_vmalloc(). Assigning a common tag resolves the pcpu
> chunk address mismatch.
>
> Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
> Cc: <stable@vger.kernel.org> # 6.1+
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v3:
> - Redo the patch by using a flag instead of a new argument in
>   __kasan_unpoison_vmalloc() (Andrey Konovalov)
>
> Changelog v2:
> - Revise the whole patch to match the fixed refactorization from the
>   first patch.
>
> Changelog v1:
> - Rewrite the patch message to point at the user impact of the issue.
> - Move helper to common.c so it can be compiled in all KASAN modes.
>
>  mm/kasan/common.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 1ed6289d471a..496bb2c56911 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -591,11 +591,28 @@ void __kasan_unpoison_vmap_areas(struct vm_struct *=
*vms, int nr_vms,
>         unsigned long size;
>         void *addr;
>         int area;
> +       u8 tag;
> +
> +       /*
> +        * If KASAN_VMALLOC_KEEP_TAG was set at this point, all vms[] poi=
nters
> +        * would be unpoisoned with the KASAN_TAG_KERNEL which would disa=
ble
> +        * KASAN checks down the line.
> +        */
> +       if (flags & KASAN_VMALLOC_KEEP_TAG) {

I think we can do a WARN_ON() here: passing KASAN_VMALLOC_KEEP_TAG to
this function would be a bug in KASAN annotations and thus a kernel
bug. Therefore, printing a WARNING seems justified.

> +               pr_warn("KASAN_VMALLOC_KEEP_TAG flag shouldn't be already=
 set!\n");
> +               return;
> +       }
> +
> +       size =3D vms[0]->size;
> +       addr =3D vms[0]->addr;
> +       vms[0]->addr =3D __kasan_unpoison_vmalloc(addr, size, flags);
> +       tag =3D get_tag(vms[0]->addr);
>
> -       for (area =3D 0 ; area < nr_vms ; area++) {
> +       for (area =3D 1 ; area < nr_vms ; area++) {
>                 size =3D vms[area]->size;
> -               addr =3D vms[area]->addr;
> -               vms[area]->addr =3D __kasan_unpoison_vmalloc(addr, size, =
flags);
> +               addr =3D set_tag(vms[area]->addr, tag);
> +               vms[area]->addr =3D
> +                       __kasan_unpoison_vmalloc(addr, size, flags | KASA=
N_VMALLOC_KEEP_TAG);
>         }
>  }
>  #endif
> --
> 2.52.0
>

With WARN_ON():

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

