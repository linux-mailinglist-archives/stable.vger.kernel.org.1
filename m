Return-Path: <stable+bounces-132010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5B0A833C6
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 23:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389D03B882D
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 21:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC04216E05;
	Wed,  9 Apr 2025 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2paZGHK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB75215184
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235900; cv=none; b=fdeYjozSLqgmSOEjdqXitNwgbvczg/1qVBuAE5wIKVEYH22pP0IWr1z6onaj58Axl2j7FYzTvWBPaEQFKS0apStLpcfM5UVdi+jB5EF17iEnTtRPZAT0BwZeglxksBWWBrfTOQ7/mq0/KiMY6bV7CqHr18kFd1uFwtdMSWYjmlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235900; c=relaxed/simple;
	bh=0nFkHUPAlc0I1FOYvKUq8VmjB8LHwh1qovpVHIs6hAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSoVyR1mDrardKM6ml/aqGtUl2arCWKl3k2dFxErs5ordmqydUDp1oOvK3Wdpcbc78NaASRGLMoHPta3TNA8RtXuZSKUW9l1vcbF4PN7pK5Gk9g2i+enX299Q9KYspudQ92Bo/GmREr9MSySkPcuzsGsdefhUZ84L26eqoWhasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n2paZGHK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso7995e9.1
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 14:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744235895; x=1744840695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHM9muTKfrXd9aqR5zV7SMKrJOiG+iDY4wChxrhJl6A=;
        b=n2paZGHKbsI31X++f+e9cQYwNf693BRscTTaWARct2lAqDKUTqjHQkFzcJrogoVznm
         rpF81v7PN0EwdT52msxyAMUuKtruIo/NpVA39lvl0GjyMNhkN1BnxNgACfTZD/cnhMgj
         PkW3noYyrYa743G2nikiDzfynxLpPdqAUwyu7KewZpPDY/v7LVjkCsUBPOcHHrlo6uav
         FXBTZ2RZYi00gIArqOGNjkdtRO7kVyE064E54Kgrl2SZs6d+AT5qNFN+B9gnElzClbnL
         4wwMa7VkQtKALHYOVlPGOLMqQFezWasQEVHnPWrqLOYVFyIKkSaNp5DpKRu/qewsPbmt
         T7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744235895; x=1744840695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHM9muTKfrXd9aqR5zV7SMKrJOiG+iDY4wChxrhJl6A=;
        b=sXmjdzQKpYb79Cj6mOs+M244RqOD1DgpNLPPFtQDQs2zz7LxiRNs9smNzNTY6YbF96
         jl3jItIlcF0sB07EKrp3ZvFUpV+syb3SRUZtwkZKZmlco/5IQieqHdQRFlsKY4jpu84+
         GGmIXMebYgmsPKsBdeUsG/oiNt/BsD9KHHqu5/dkQESoIA/Ga/oFO5Bi1i1k6Cbd2bzy
         XDwB4sW1+e+Oan8xiHqGJGZgCrIRbDKm5gJ+QoQwTOJZCjBLZt/PCfG9u1TDtpYqER6g
         M1kTQtk2t7NPW684oSydS8BNxyBJHl8YV1snUk76Rv4JNPSMdKDa1MSLBRACkD3veNbC
         NaMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXME3ZZpy+U6TiZ3df28thU+hGDRo+jVdcEFsjp4j51hTgO/u+5rIg7gfilm6tWaM9kJxpKC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS5ZyHPli3RmG6ZaxBnKTEqBqKNI3BMpKAAFaYSLi4irj9/0C2
	xvJjv0F6MP4V6ByyPAGHc+RfO1uX6BfEnGmTfU5vo3tHrjq68JNqLZBFo067N5jnG0tbOkT/Gbh
	qwR06+TJulVAmteqaPWuVDYDCW+6xmvltApGr
X-Gm-Gg: ASbGncs8hD4UtbOGKqo0iWPtA8ceyWHi8zr1jqhlP+fS08UPy/BVdj8pC1LUsVYpuLc
	IjRH7O5PuZffeBGX6ZGuUKUKam18yY+mz+u/2v+xIsnFW+x4619Ex5GG9GRWbmrgq/NCG3Ya7G4
	iau8hZq5n8jCJa1HpqGbDWKaF7sHx4tYYIl9eVAycK4Z+b+Mts7us=
X-Google-Smtp-Source: AGHT+IGNGwnva+gICJ5WQa3hrf7rRIIOZmzHju1WvnqLhCD6/wZWRAw4agWWnzWJT9wURz7SJnk46zh8GGg+Xx50m9I=
X-Received: by 2002:a05:600c:1f8c:b0:43b:b106:bb1c with SMTP id
 5b1f17b1804b1-43f2dace339mr263625e9.0.1744235894548; Wed, 09 Apr 2025
 14:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409211241.70C37C4CEE2@smtp.kernel.org>
In-Reply-To: <20250409211241.70C37C4CEE2@smtp.kernel.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 9 Apr 2025 14:58:02 -0700
X-Gm-Features: ATxdqUEbE3CZxtKpHpWKZp7E8dj3fHaqRF1Zy1BhbdU0bnSVU8IkMU0Q14OJmBc
Message-ID: <CABdmKX21Bw1JrY5YxvTHpSOj5qAqAifcBRUxvC7BSNw4EUpEPw@mail.gmail.com>
Subject: Re: + alloc_tag-handle-incomplete-bulk-allocations-in-vm_module_tags_populate.patch
 added to mm-hotfixes-unstable branch
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, surenb@google.com, stable@vger.kernel.org, 
	kent.overstreet@linux.dev, janghyuck.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 2:12=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
>
> The patch titled
>      Subject: alloc_tag: handle incomplete bulk allocations in vm_module_=
tags_populate
> has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
>      alloc_tag-handle-incomplete-bulk-allocations-in-vm_module_tags_popul=
ate.patch
>
> This patch will shortly appear at
>      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree=
/patches/alloc_tag-handle-incomplete-bulk-allocations-in-vm_module_tags_pop=
ulate.patch
>
> This patch will later appear in the mm-hotfixes-unstable branch at
>     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
>
> *** Remember to use Documentation/process/submit-checklist.rst when testi=
ng your code ***
>
> The -mm tree is included into linux-next via the mm-everything
> branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> and is updated there every 2-3 working days
>
> ------------------------------------------------------
> From: "T.J. Mercier" <tjmercier@google.com>
> Subject: alloc_tag: handle incomplete bulk allocations in vm_module_tags_=
populate
> Date: Wed, 9 Apr 2025 19:54:47 +0000
>
> alloc_pages_bulk_node may partially succeed and allocate fewer than the
> requested nr_pages.  There are several conditions under which this can
> occur, but we have encountered the case where CONFIG_PAGE_OWNER is enable=
d
> causing all bulk allocations to always fallback to single page allocation=
s
> due to commit 187ad460b841 ("mm/page_alloc: avoid page allocator recursio=
n
> with pagesets.lock held").
>
> Currently vm_module_tags_populate immediately fails when
> alloc_pages_bulk_node returns fewer than the requested number of pages.
> This patch causes vm_module_tags_populate to retry bulk allocations for
> the remaining memory instead.
>
> Link: https://lkml.kernel.org/r/20250409195448.3697351-1-tjmercier@google=
.com
> Fixes: 187ad460b841 ("mm/page_alloc: avoid page allocator recursion with =
pagesets.lock held")

I wasn't sure if this should have a Fixes: but since allocation tags
came after the commit above, I think it'd be better to reference
0f9b685626da ("alloc_tag: populate memory for module tags as needed")
which introduced this bulk allocation.

> Signed-off-by: T.J. Mercier <tjmercier@google.com>
> Reported-by: Janghyuck Kim <janghyuck.kim@samsung.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  lib/alloc_tag.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> --- a/lib/alloc_tag.c~alloc_tag-handle-incomplete-bulk-allocations-in-vm_=
module_tags_populate
> +++ a/lib/alloc_tag.c
> @@ -422,11 +422,20 @@ static int vm_module_tags_populate(void)
>                 unsigned long old_shadow_end =3D ALIGN(phys_end, MODULE_A=
LIGN);
>                 unsigned long new_shadow_end =3D ALIGN(new_end, MODULE_AL=
IGN);
>                 unsigned long more_pages;
> -               unsigned long nr;
> +               unsigned long nr =3D 0;
>
>                 more_pages =3D ALIGN(new_end - phys_end, PAGE_SIZE) >> PA=
GE_SHIFT;
> -               nr =3D alloc_pages_bulk_node(GFP_KERNEL | __GFP_NOWARN,
> -                                          NUMA_NO_NODE, more_pages, next=
_page);
> +               while (nr < more_pages) {
> +                       unsigned long allocated;
> +
> +                       allocated =3D alloc_pages_bulk_node(GFP_KERNEL | =
__GFP_NOWARN,
> +                               NUMA_NO_NODE, more_pages - nr, next_page =
+ nr);
> +
> +                       if (!allocated)
> +                               break;
> +                       nr +=3D allocated;
> +               }
> +
>                 if (nr < more_pages ||
>                     vmap_pages_range(phys_end, phys_end + (nr << PAGE_SHI=
FT), PAGE_KERNEL,
>                                      next_page, PAGE_SHIFT) < 0) {
> _
>
> Patches currently in -mm which might be from tjmercier@google.com are
>
> alloc_tag-handle-incomplete-bulk-allocations-in-vm_module_tags_populate.p=
atch
>

