Return-Path: <stable+bounces-198230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F274C9F6FB
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 16:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E50B300BECA
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC4032B98B;
	Wed,  3 Dec 2025 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ++y0Wf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976D7186E40
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764775104; cv=none; b=YZHX29jNfuXRzExlKs4ZZubFgBnP2xrygIvam00295UXde2r3uZhJfFFq4pAslYOfHcLkBhEOJH5Y/PoJgAonwJFyIWAezE0B9Ndj80Tk+seA+aud5mwPC+sIFXkisUKvKSGqmWrYn6FS4jb54/roJbVSwu3g4pB5dVyHoIJaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764775104; c=relaxed/simple;
	bh=ABZJVd0vwxXIRcA1EMlVWzzqKDbyKyTfRUgBrr74vqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fs/x4d+P3aqjkz5YMV9QsLkQuESVU4939lyf21Mdzw2VC7BcsJoVO33Qu13yUHr6mvzb/xa34GYUIjgagLwrlPK+7ahuc2Yi+mRV9yZe54s3UMYXPfGvSRWPUI1wUxWFS6E17d5OKTRmJW1r3h333obX3OM47YAOGRnpCakB5sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ++y0Wf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42e2ce8681eso3217354f8f.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 07:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764775101; x=1765379901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHkKMPEnQ9YySxWfhJQb2dUyJQ3XmA+wblB+0uzx3ww=;
        b=WZ++y0WfCojxOP+1/Nts6psHO+LkDswLRMti9Dp85IfKo2f+obn7bUjSfNi/woLPx8
         Ap0hvM3tZVgtKBqk/2ZMl6C0tmRQbOyzDINmDy2kNWL2yRyC43m16T3Zsr5Lz0a/Hh01
         mkxf6FL+iLzYelMTLyjAiquNhVbghf3lmlti1q5YNtF+iZMhlKxCXtWFIBrshK923C8/
         WlpzOgSdsZNxmG7hStvC4Bmi5Vyj2EpDKtAcCfR0SOsKSjCbRmPXBWatgf3zO59pL90A
         oT9wxLGoqNDOCmVLjRD35UEVigEtjuFHqZj9jssYTJAupv+mSUEfnJ09Rw2U+BWI4LBf
         jhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764775101; x=1765379901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fHkKMPEnQ9YySxWfhJQb2dUyJQ3XmA+wblB+0uzx3ww=;
        b=Vm/0DIh2+ljpCmt/7D6BCNM1325N9EVszBtgy7rJYfCeGFikot45W3ozy9rua0hN0s
         y4Mcg+tr6ksyMUeIpKn+6zzho5WUS9y0nm/NDVwmbPwvHbpvoUeJGjU43/ZjRIpLav2S
         r/HzFQHeKvuFM5lM+ITky3XX47Ppf5Q4Usg+LjHDOdj1EuJKp+yNcbeqXIREjRGyzybQ
         S0OKiMVNfKLFfG6v3Owh8q/aIoLtEeADqLNcUyO8q2jd36C3e5R71k0RhOpDWdgR1b90
         1biBqtxZu5MAFmMNqwAeJpeMc1HH19rCgYdbiRIVZX+MeiZ8Edwol1RshxSiVZm304O3
         y0Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUCqdqOGDTXOwdacqUdN98bcJPSBna69dErQViAKDZezWRNIoJDgSohHRaAAIUy4qdNlvyo4ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuzqW5pxjPZCktqShyPtITJdiMZ8gRbO+mkO/Vhi9jOmGumoJu
	kBjWqjwus9ys7giG7LX0FTeDZqUKmwmmGQT60tn7RTz0jH4Y77czKRBVnaELN5IupyDPvq6JMRZ
	GS+19kMsFbfadevVYE5HNen846V0YyJc=
X-Gm-Gg: ASbGncujZiLuhbqYkcJpCpFtf2tydycDselDnQr0PitfVTrRjoM345WDZ/Wbs820TVm
	KCWLn29i8xQADmUah4IBgf3D/aRLsOgdY7RPe72WB6AVx4PLTkF735Qk3gtc7bVp+ENtw2Kop4I
	95AanxEpeOXuQz2Nf0iTmCEd2BrPkw+D0FiIBEjxXMSjEQIDW7+KJNSt7ZGK4QPMKY5KMx1BHpv
	ye64NrRE+SqkiWFAGR9O3VM/7dwsfetlo+w9ioDLxvQAgdSJMYENz/iO+6d3uTKXquP4pvZ/rjb
	lac4iCBFOc0yY2tqNHtm/mT3Dz5df9NFpjJNZtFi6WG9
X-Google-Smtp-Source: AGHT+IHwAOgKdZnjv8Ra6NRCH56wK2VLEzPW8OibPCEBWdRd2pmyHYQV/MPmjLsAx3h7bvr0pXS5J2RD3mxuOVyH004=
X-Received: by 2002:a5d:64c5:0:b0:429:d6dc:ae30 with SMTP id
 ffacd0b85a97d-42f731c2b6cmr2934585f8f.46.1764775100859; Wed, 03 Dec 2025
 07:18:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128185523.B995CC4CEFB@smtp.kernel.org>
In-Reply-To: <20251128185523.B995CC4CEFB@smtp.kernel.org>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 3 Dec 2025 16:18:10 +0100
X-Gm-Features: AWmQ_bkUSZqwRcjEKOHC2jF7jJ05Jhr7oMctTnmr-36-DTvY88P7pB7sfUaL8pw
Message-ID: <CA+fCnZeKm4uZuv2hhnSE0RrBvjw26eZFNXC6S+SPDMD0O1vvvA@mail.gmail.com>
Subject: Re: + mm-kasan-fix-incorrect-unpoisoning-in-vrealloc-for-kasan.patch
 added to mm-hotfixes-unstable branch
To: jiayuan.chen@linux.dev, Kees Cook <kees@kernel.org>
Cc: mm-commits@vger.kernel.org, vincenzo.frascino@arm.com, urezki@gmail.com, 
	stable@vger.kernel.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, dakr@kernel.org, kasan-dev <kasan-dev@googlegroups.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 7:55=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
>
> The patch titled
>      Subject: mm/kasan: fix incorrect unpoisoning in vrealloc for KASAN
> has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
>      mm-kasan-fix-incorrect-unpoisoning-in-vrealloc-for-kasan.patch
>
> This patch will shortly appear at
>      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree=
/patches/mm-kasan-fix-incorrect-unpoisoning-in-vrealloc-for-kasan.patch
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
> From: Jiayuan Chen <jiayuan.chen@linux.dev>
> Subject: mm/kasan: fix incorrect unpoisoning in vrealloc for KASAN
> Date: Fri, 28 Nov 2025 19:15:14 +0800

Hi Jiayuan,

Please CC kasan-dev@googlegroups.com when sending KASAN patches.

>
> Syzkaller reported a memory out-of-bounds bug [1]. This patch fixes two
> issues:
>
> 1. In vrealloc, we were missing the KASAN_VMALLOC_VM_ALLOC flag when
>    unpoisoning the extended region. This flag is required to correctly
>    associate the allocation with KASAN's vmalloc tracking.
>
>    Note: In contrast, vzalloc (via __vmalloc_node_range_noprof) explicitl=
y
>    sets KASAN_VMALLOC_VM_ALLOC and calls kasan_unpoison_vmalloc() with it=
.
>    vrealloc must behave consistently =E2=80=94 especially when reusing ex=
isting
>    vmalloc regions =E2=80=94 to ensure KASAN can track allocations correc=
tly.
>
> 2. When vrealloc reuses an existing vmalloc region (without allocating ne=
w
>    pages), KASAN previously generated a new tag, which broke tag-based
>    memory access tracking. We now add a 'reuse_tag' parameter to
>    __kasan_unpoison_vmalloc() to preserve the original tag in such cases.

I think we actually could assign a new tag to detect accesses through
the old pointer. Just gotta retag the whole region with this tag. But
this is a separate thing; filed
https://bugzilla.kernel.org/show_bug.cgi?id=3D220829 for this.

>
> A new helper kasan_unpoison_vralloc() is introduced to handle this reuse
> scenario, ensuring consistent tag behavior during reallocation.
>
>
> Link: https://lkml.kernel.org/r/20251128111516.244497-1-jiayuan.chen@linu=
x.dev
> Link: https://syzkaller.appspot.com/bug?extid=3D997752115a851cb0cf36 [1]
> Fixes: a0309faf1cb0 ("mm: vmalloc: support more granular vrealloc() sizin=
g")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Reported-by: syzbot+997752115a851cb0cf36@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68e243a2.050a0220.1696c6.007d.GAE@goo=
gle.com/T/
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Dmitriy Vyukov <dvyukov@google.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  include/linux/kasan.h |   21 +++++++++++++++++++--
>  mm/kasan/hw_tags.c    |    4 ++--
>  mm/kasan/shadow.c     |    6 ++++--
>  mm/vmalloc.c          |    4 ++--
>  4 files changed, 27 insertions(+), 8 deletions(-)
>
> --- a/include/linux/kasan.h~mm-kasan-fix-incorrect-unpoisoning-in-vreallo=
c-for-kasan
> +++ a/include/linux/kasan.h
> @@ -596,13 +596,23 @@ static inline void kasan_release_vmalloc
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>
>  void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
> -                              kasan_vmalloc_flags_t flags);
> +                              kasan_vmalloc_flags_t flags, bool reuse_ta=
g);
> +
> +static __always_inline void *kasan_unpoison_vrealloc(const void *start,
> +                                                    unsigned long size,
> +                                                    kasan_vmalloc_flags_=
t flags)
> +{
> +       if (kasan_enabled())
> +               return __kasan_unpoison_vmalloc(start, size, flags, true)=
;
> +       return (void *)start;
> +}
> +
>  static __always_inline void *kasan_unpoison_vmalloc(const void *start,
>                                                 unsigned long size,
>                                                 kasan_vmalloc_flags_t fla=
gs)
>  {
>         if (kasan_enabled())
> -               return __kasan_unpoison_vmalloc(start, size, flags);
> +               return __kasan_unpoison_vmalloc(start, size, flags, false=
);
>         return (void *)start;
>  }
>
> @@ -629,6 +639,13 @@ static inline void kasan_release_vmalloc
>                                          unsigned long free_region_end,
>                                          unsigned long flags) { }
>
> +static inline void *kasan_unpoison_vrealloc(const void *start,
> +                                           unsigned long size,
> +                                           kasan_vmalloc_flags_t flags)
> +{
> +       return (void *)start;
> +}
> +
>  static inline void *kasan_unpoison_vmalloc(const void *start,
>                                            unsigned long size,
>                                            kasan_vmalloc_flags_t flags)
> --- a/mm/kasan/hw_tags.c~mm-kasan-fix-incorrect-unpoisoning-in-vrealloc-f=
or-kasan
> +++ a/mm/kasan/hw_tags.c
> @@ -317,7 +317,7 @@ static void init_vmalloc_pages(const voi
>  }
>
>  void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
> -                               kasan_vmalloc_flags_t flags)
> +                               kasan_vmalloc_flags_t flags, bool reuse_t=
ag)
>  {
>         u8 tag;
>         unsigned long redzone_start, redzone_size;
> @@ -361,7 +361,7 @@ void *__kasan_unpoison_vmalloc(const voi
>                 return (void *)start;
>         }
>
> -       tag =3D kasan_random_tag();
> +       tag =3D reuse_tag ? get_tag(start) : kasan_random_tag();
>         start =3D set_tag(start, tag);
>
>         /* Unpoison and initialize memory up to size. */
> --- a/mm/kasan/shadow.c~mm-kasan-fix-incorrect-unpoisoning-in-vrealloc-fo=
r-kasan
> +++ a/mm/kasan/shadow.c
> @@ -625,7 +625,7 @@ void kasan_release_vmalloc(unsigned long
>  }
>
>  void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
> -                              kasan_vmalloc_flags_t flags)
> +                              kasan_vmalloc_flags_t flags, bool reuse_ta=
g)

Since we already have kasan_vmalloc_flags_t, I think it makes sense to
add reuse_tag as another flag.

>  {
>         /*
>          * Software KASAN modes unpoison both VM_ALLOC and non-VM_ALLOC
> @@ -648,7 +648,9 @@ void *__kasan_unpoison_vmalloc(const voi
>             !(flags & KASAN_VMALLOC_PROT_NORMAL))
>                 return (void *)start;
>
> -       start =3D set_tag(start, kasan_random_tag());
> +       if (!reuse_tag)
> +               start =3D set_tag(start, kasan_random_tag());

The HW_TAGS mode should also need this fix. Please build it (the build
should be failing with your patch as is), boot it, and run the KASAN
tests. And do the same for the other modes.

Would be good to have tests for vrealloc too. Filed
https://bugzilla.kernel.org/show_bug.cgi?id=3D220830 for this.

> +
>         kasan_unpoison(start, size, false);
>         return (void *)start;
>  }
> --- a/mm/vmalloc.c~mm-kasan-fix-incorrect-unpoisoning-in-vrealloc-for-kas=
an
> +++ a/mm/vmalloc.c
> @@ -4175,8 +4175,8 @@ void *vrealloc_node_align_noprof(const v
>          * We already have the bytes available in the allocation; use the=
m.
>          */
>         if (size <=3D alloced_size) {
> -               kasan_unpoison_vmalloc(p + old_size, size - old_size,
> -                                      KASAN_VMALLOC_PROT_NORMAL);
> +               kasan_unpoison_vrealloc(p, size,
> +                                       KASAN_VMALLOC_PROT_NORMAL | KASAN=
_VMALLOC_VM_ALLOC);

Orthogonal to this series, but is it allowed to call vrealloc on
executable mappings? If so, we need to only set
KASAN_VMALLOC_PROT_NORMAL for non-executable mappings. And
kasan_poison_vmalloc should not be called for them as well (so we
likely need to pass a protection flag to it to avoid exposing this
logic).

Kees, I see you worked on vrealloc annotations, do you happen to know?


>                 /*
>                  * No need to zero memory here, as unused memory will hav=
e
>                  * already been zeroed at initial allocation time or duri=
ng
> _
>
> Patches currently in -mm which might be from jiayuan.chen@linux.dev are
>
> mm-kasan-fix-incorrect-unpoisoning-in-vrealloc-for-kasan.patch
> mm-vmscan-skip-increasing-kswapd_failures-when-reclaim-was-boosted.patch
>

