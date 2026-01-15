Return-Path: <stable+bounces-208414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10761D22564
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 04:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3ACE302EAEB
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 03:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AFC2C028B;
	Thu, 15 Jan 2026 03:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1SIDzwu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE062BD587
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768449389; cv=none; b=GNShLRw5XlIx19NuA1k12h+4ZPnB7tFNFYfk3I92wxjF4zR1yQWuzDuiU0msbZJ9CgnlMK1jIA29PuThMwISS0KTzxj/yQHzjHQ0Wk+3GBzQWsqfHIDt7DwYa/6Fo94el7kqgtkkURpZRn4TlXxiN3ET3NYm2YxTNV3cW0C0wig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768449389; c=relaxed/simple;
	bh=8PTo8WdG2gqkNTQA+6lOZMx1DT70AMXpIpI6P3k7Qdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmH/Zk/+SlpXz21WzV26uaZYVQVO7tKdZGnr9ry+COgsrN8T8+MZsBtJ5Owk5jPlFbMiPAoKUob6nuW96u5Y2WTGFCMOd8B3EcoAdqyJbL42irF89Hi3whHSOph+WUJPT3IGXqOMRZOJTjEaJgTI7Kjlx55IlIe6kLH3OTLhses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1SIDzwu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-430f9ffd4e8so689162f8f.0
        for <stable@vger.kernel.org>; Wed, 14 Jan 2026 19:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768449385; x=1769054185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8h4CNT/vCdwT2WHgzViB1V6HoWHqUEOSKi1RhGen4M=;
        b=M1SIDzwu04IjMHIs24nruMNHqFUH4Yc6g2jEFTS9kv3MWpmj6J/3RFu9P0Df0PLFEM
         JG6efR7rvUEJ6ejqW+Rvy++sMXQ0/echeGRJzgaMHOancqohJWfL+xpUBv/L3SYZYr7K
         tngw4rIg1UdEvziBcV0Ic3ZobRhaOyA4xLOG9dI4HpgsHrTaigAWG8zz/CSkz/E2ahrg
         HED+MCRXkWT3ZxLLRiQEDj1FxLQ22MbY1N0Hn0Kocyutn0MXu4Bd/qYe7bufH85/NpXZ
         NIiv76SnMUne3VMUkt9C2EPD9H68WUDpnJabRIZYkX4u8p0EhQdkRfGbmkGOZgAdK6/4
         +cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768449385; x=1769054185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z8h4CNT/vCdwT2WHgzViB1V6HoWHqUEOSKi1RhGen4M=;
        b=q4gMD8/YNBUVw1MmVU8brUo5tCNuQxiReu9i1tqoYbM+raoN0k1XcM6ayAd5Nv139l
         n9WBHal3xJTZQUJ1RqY/LCPqqtqhE84VEXLiEIfszroE7ZbyG06MkXtrC9akFNee2lfS
         CR5gokq/m8HVBMQe092YICiRtxLQDpT+vjCSLPBDa3euEYJ5vVdCbnmxqCB4vrTmMiol
         Xq/FNmWp2xKBsPPi0NE582oJMD5w/rBSMU0B7LPdA9D0lVR9cWA3iB/JLjXDkYNMWmmY
         /ca1o6oLoy8yUyjwXZw3N6Q60H1so3HdIGNm/RN9lBMFFQiLelsjaMV9ml19plqmdimX
         7mqg==
X-Forwarded-Encrypted: i=1; AJvYcCWjnBhxoRH/HKUGOAHK1G5LSrmopZ/86ylEUdnMYG5FkpmMMY1tyaUYxtxphrNqv3cBQLC+tdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvDzXS+eZfMmup1nCGoeM221mAgXyIpZJTCSrHwpJ6ByXb5Yd7
	L/+iCzS6c8+/ROXu0Iak6dK35oD7aOrzCACfX4tW3mha0mSOyA0iOC9ZnCxWFbpNuTnmE+LAREM
	VlqR2cIBh+Jg11YrjBaHyRoPmMF/ziT0=
X-Gm-Gg: AY/fxX4qKJUX2qftWLHGyymtLLXkzcBfCPuEpPQRNae8pbOpKeOBb9xHNr9sRysMkL6
	OYgAQdUiXfpG+HOrbXKPr+iOPasJIJyi/DKg4Qx2xZxDq8bTcSJTl6nI7WEVT9GfdUhuNdz7g9W
	E/vYtcyV7yahMHm3G+/a0UvBYi88auS1kunD3M6nD/mE2/mBtgKbMZSWt+x4l0v9cae8OsrL2Jc
	dS+QTH52ug2sdHXZBV2MsXwCdPrxu+nsDofJvkvKwBad+5f5HfDmRRG6x5LJdGj9QexoXhJplM6
	Hsxl1Bz/0lt772KgfIRo7ajvEB8YpA==
X-Received: by 2002:a05:6000:2f82:b0:431:1c7:f967 with SMTP id
 ffacd0b85a97d-434d7580e3cmr1957942f8f.17.1768449384919; Wed, 14 Jan 2026
 19:56:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGeuRW53vukDy7WDO3FiVgu34-xVJYkfpm08oLO3odYFrA@mail.gmail.com>
 <20260113191516.31015-1-ryabinin.a.a@gmail.com>
In-Reply-To: <20260113191516.31015-1-ryabinin.a.a@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 15 Jan 2026 04:56:14 +0100
X-Gm-Features: AZwV_Qj2HFEg_msWenRDyDr9jlnYYzEBrAIjJPlBfTu53BTl1ZMgAQjnko_IfdI
Message-ID: <CA+fCnZe0RQOv8gppvs7PoH2r4QazWs+PJTpw+S-Krj6cx22qbA@mail.gmail.com>
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

On Tue, Jan 13, 2026 at 8:16=E2=80=AFPM Andrey Ryabinin <ryabinin.a.a@gmail=
.com> wrote:
>
> A KASAN warning can be triggered when vrealloc() changes the requested
> size to a value that is not aligned to KASAN_GRANULE_SIZE.
>
>     ------------[ cut here ]------------
>     WARNING: CPU: 2 PID: 1 at mm/kasan/shadow.c:174 kasan_unpoison+0x40/0=
x48
>     ...
>     pc : kasan_unpoison+0x40/0x48
>     lr : __kasan_unpoison_vmalloc+0x40/0x68
>     Call trace:
>      kasan_unpoison+0x40/0x48 (P)
>      vrealloc_node_align_noprof+0x200/0x320
>      bpf_patch_insn_data+0x90/0x2f0
>      convert_ctx_accesses+0x8c0/0x1158
>      bpf_check+0x1488/0x1900
>      bpf_prog_load+0xd20/0x1258
>      __sys_bpf+0x96c/0xdf0
>      __arm64_sys_bpf+0x50/0xa0
>      invoke_syscall+0x90/0x160
>
> Introduce a dedicated kasan_vrealloc() helper that centralizes
> KASAN handling for vmalloc reallocations. The helper accounts for KASAN
> granule alignment when growing or shrinking an allocation and ensures
> that partial granules are handled correctly.
>
> Use this helper from vrealloc_node_align_noprof() to fix poisoning
> logic.
>
> Reported-by: Maciej =C5=BBenczykowski <maze@google.com>
> Reported-by: <joonki.min@samsung-slsi.corp-partner.google.com>
> Closes: https://lkml.kernel.org/r/CANP3RGeuRW53vukDy7WDO3FiVgu34-xVJYkfpm=
08oLO3odYFrA@mail.gmail.com
> Fixes: d699440f58ce ("mm: fix vrealloc()'s KASAN poisoning logic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> ---
>  include/linux/kasan.h |  6 ++++++
>  mm/kasan/shadow.c     | 24 ++++++++++++++++++++++++
>  mm/vmalloc.c          |  7 ++-----
>  3 files changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 9c6ac4b62eb9..ff27712dd3c8 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -641,6 +641,9 @@ kasan_unpoison_vmap_areas(struct vm_struct **vms, int=
 nr_vms,
>                 __kasan_unpoison_vmap_areas(vms, nr_vms, flags);
>  }
>
> +void kasan_vrealloc(const void *start, unsigned long old_size,
> +               unsigned long new_size);
> +
>  #else /* CONFIG_KASAN_VMALLOC */
>
>  static inline void kasan_populate_early_vm_area_shadow(void *start,
> @@ -670,6 +673,9 @@ kasan_unpoison_vmap_areas(struct vm_struct **vms, int=
 nr_vms,
>                           kasan_vmalloc_flags_t flags)
>  { }
>
> +static inline void kasan_vrealloc(const void *start, unsigned long old_s=
ize,
> +                               unsigned long new_size) { }
> +
>  #endif /* CONFIG_KASAN_VMALLOC */
>
>  #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && =
\
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 32fbdf759ea2..e9b6b2d8e651 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -651,6 +651,30 @@ void __kasan_poison_vmalloc(const void *start, unsig=
ned long size)
>         kasan_poison(start, size, KASAN_VMALLOC_INVALID, false);
>  }
>
> +void kasan_vrealloc(const void *addr, unsigned long old_size,
> +               unsigned long new_size)
> +{
> +       if (!kasan_enabled())
> +               return;

Please move this check to include/linux/kasan.h and add
__kasan_vrealloc, similar to other hooks.

Otherwise, these kasan_enabled() checks eventually start creeping into
lower-level KASAN functions, and this makes the logic hard to follow.
We recently cleaned up most of these checks.

> +
> +       if (new_size < old_size) {
> +               kasan_poison_last_granule(addr, new_size);
> +
> +               new_size =3D round_up(new_size, KASAN_GRANULE_SIZE);
> +               old_size =3D round_up(old_size, KASAN_GRANULE_SIZE);
> +               if (new_size < old_size)
> +                       __kasan_poison_vmalloc(addr + new_size,
> +                                       old_size - new_size);
> +       } else if (new_size > old_size) {
> +               old_size =3D round_down(old_size, KASAN_GRANULE_SIZE);
> +               __kasan_unpoison_vmalloc(addr + old_size,
> +                                       new_size - old_size,
> +                                       KASAN_VMALLOC_PROT_NORMAL |
> +                                       KASAN_VMALLOC_VM_ALLOC |
> +                                       KASAN_VMALLOC_KEEP_TAG);
> +       }
> +}
> +
>  #else /* CONFIG_KASAN_VMALLOC */
>
>  int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 41dd01e8430c..2536d34df058 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4322,7 +4322,7 @@ void *vrealloc_node_align_noprof(const void *p, siz=
e_t size, unsigned long align
>                 if (want_init_on_free() || want_init_on_alloc(flags))
>                         memset((void *)p + size, 0, old_size - size);
>                 vm->requested_size =3D size;
> -               kasan_poison_vmalloc(p + size, old_size - size);
> +               kasan_vrealloc(p, old_size, size);
>                 return (void *)p;
>         }
>
> @@ -4330,16 +4330,13 @@ void *vrealloc_node_align_noprof(const void *p, s=
ize_t size, unsigned long align
>          * We already have the bytes available in the allocation; use the=
m.
>          */
>         if (size <=3D alloced_size) {
> -               kasan_unpoison_vmalloc(p + old_size, size - old_size,
> -                                      KASAN_VMALLOC_PROT_NORMAL |
> -                                      KASAN_VMALLOC_VM_ALLOC |
> -                                      KASAN_VMALLOC_KEEP_TAG);
>                 /*
>                  * No need to zero memory here, as unused memory will hav=
e
>                  * already been zeroed at initial allocation time or duri=
ng
>                  * realloc shrink time.
>                  */
>                 vm->requested_size =3D size;
> +               kasan_vrealloc(p, old_size, size);
>                 return (void *)p;
>         }
>
> --
> 2.52.0
>

With the change mentioned above:

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

