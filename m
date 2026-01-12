Return-Path: <stable+bounces-208035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3387AD10AA1
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 06:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8ABCD30118F5
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 05:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936D030F92E;
	Mon, 12 Jan 2026 05:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0RWfnoO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D634B30F7FE
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 05:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768197415; cv=none; b=TFYrlqOZZ3o/m71jOUzpruJga1WOjMurhe2PbtRmWY5Bnpu7Oi44lm5OBLoiO8L3FWgpRLWu3jodC9mEkhkoNlvTqAEKbIErAIPmbtc597I4hChPcg+CV3iKMHh9JS7jj/FtgH2uJEseUtCk6h2fnmS2Mi/C3fJbwCVtRQ45Fhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768197415; c=relaxed/simple;
	bh=bw4XwygbaQT5YxAbgPyXu0OqveXy3acxtvwur3iO9HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mneyBIUmnAiXwZjEPmlSOWoHlvEDIZoiwz2rhzhbfEQ0PHQw2mpYhc6P2GGc9UtutyXaBQSPIet759GK3MQg+NJy82qPjA/nXzbvwnEy7NiMs4f6p3r9C+Gj87LUTafIVuptQL2O3cXHm4gRD1/F3QN6vkAKZpzZs20YAUV/Tv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0RWfnoO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b86f81d8051so203609066b.1
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 21:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768197412; x=1768802212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQUdO7kF0Tnp+bmM0UqigmkOuUsrJx5sPNlFABU/J6A=;
        b=H0RWfnoOxBg7cd5DVvTIHJ291r8fTgja0Jiq75dcJSFiPQ9z1PuuKhhfbSJJVuZkNr
         A5DA0NhvYQM6u+nUygk9+dO7nWLkqy1069ojxU67faDlaAHBigYTvM8dRZ4pSkMhtSM2
         F/LjysaICyWq+d7sYvSUQ0wi2ay2W4DCX+FyPrbXgOBBiV5TreIB+Oz45mYBIQhJecDF
         /gMq1B64/m85Dwyo1LKblxjnxey5P+03MBeZCbZhAuYPlSFDewCJDrKFNPBdwUVRMoPg
         H+ewhfI5jg+CzpRpsNCTFpvVGlXS7AoQgjq4MaiaRzwcAT79zqyRxWBEyXHyvdJDyYow
         YMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768197412; x=1768802212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MQUdO7kF0Tnp+bmM0UqigmkOuUsrJx5sPNlFABU/J6A=;
        b=jMYs74AkmdmUIKgNG5jRJ4C4ms03tNqef7zqL+ywmFHAjjVmG0wGAkwEXpzB7/pMfo
         3wGyHE0sOLq4PwDCZ0TafYJNUuAhTRxVWQMiYuHkbnCciZxLH69DpZ0C89WWtqJ990+V
         8rW+lsJa5MOvZILZCKXwMvqC9ekKLx1wmS5lq8tPnn16fDniekjQ2KmzG43EgKttLcgg
         ue4/HWDfccnY9oerMVW2+4vTdrY/kAKNHYfbWC7alYxaFaQkb6jjbWi6bi8L0kLf9/OM
         Ol5Dl0L9lpyFXIhbASCMPPSXZ4420k2LCGE7lIaY1i2kIWaPjTYl+cx/q4xQc1cH5wpa
         2EoA==
X-Forwarded-Encrypted: i=1; AJvYcCWSXK8kb0vpynnZelvXyCd968kbqDwb0HtsA8Eq8KyxG+f8xddttn0kp6dC9L7kwNgBxiShqOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG2gKVKmSea2VRZ4M3/L6McgxJToXSS5ZmZpVrDe7WAWVHCVCC
	Ptxql6BCrv3tlfU616fgjWOHyz2qne3c8W8kZnRLZo8S6La4sZRNoaQ+bHhyaTQ0VvhAlyosZqv
	Gxz/HcSVzkIPio9ACsjo4RUMUo7rUz/A=
X-Gm-Gg: AY/fxX4SQgCoKgIeyUUjXRHQVO5YbsteWxfhviaVW6QNk1fHdsHW9nICWXdUdfgAhZf
	k4sjQKz5g3uHp/Zq1ZXnr6JmZA8oshXoTGvpFF/D9LVaxHP5rCGN1GrP9GXJ+9WW1LuNzII00uX
	3+sqGZU3yMnSn8gnvGsEHIYxvcqdmSaHfEgOOLh2dMnQCFdCbSwtIJ0IGIjXwmXt3FXKwpfnXdH
	ODqr/zV59VbnN0IA8EX8Ux0pdzNRO0zWsJlKznG8AsoGQ5wl3JsLmkeLq1CBTMCFlYkGxpdPd8g
	v37BciuBQftvZjfaOfcXOnwxn/Wd
X-Google-Smtp-Source: AGHT+IF9+5Xm1x2hlaMfVdBJMXeE5xX+pUBh8s0pJhPoOJjfsYHUGhHytLEUNT9OMey+gHzXJkXW9WWRMyLYWqXhHvg=
X-Received: by 2002:a17:907:86ac:b0:b87:2882:bf7e with SMTP id
 a640c23a62f3a-b872882c3bamr66251366b.11.1768197411905; Sun, 11 Jan 2026
 21:56:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-shmem-swap-fix-v1-1-0f347f4f6952@tencent.com> <d20f536c-edc1-42a0-9978-13918d39ecba@linux.alibaba.com>
In-Reply-To: <d20f536c-edc1-42a0-9978-13918d39ecba@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 12 Jan 2026 13:56:15 +0800
X-Gm-Features: AZwV_Qi-Mm2ah-xczly_xAKLT7xAGHWF9XcoeRmwlQ3QVUGtCtrYpZeOA8joW4A
Message-ID: <CAMgjq7ASxBdAakd_3J3O-nPysArLruGO-j4rCHg6OFvvNq7f0g@mail.gmail.com>
Subject: Re: [PATCH] mm/shmem, swap: fix race of truncate and swap entry split
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 12:00=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
> On 1/12/26 1:53 AM, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > The helper for shmem swap freeing is not handling the order of swap
> > entries correctly. It uses xa_cmpxchg_irq to erase the swap entry,
> > but it gets the entry order before that using xa_get_order
> > without lock protection. As a result the order could be a stalled value
> > if the entry is split after the xa_get_order and before the
> > xa_cmpxchg_irq. In fact that are more way for other races to occur
> > during the time window.
> >
> > To fix that, open code the Xarray cmpxchg and put the order retrivial a=
nd
> > value checking in the same critical section. Also ensure the order won'=
t
> > exceed the truncate border.
> >
> > I observed random swapoff hangs and swap entry leaks when stress
> > testing ZSWAP with shmem. After applying this patch, the problem is res=
olved.
> >
> > Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >   mm/shmem.c | 35 +++++++++++++++++++++++------------
> >   1 file changed, 23 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 0b4c8c70d017..e160da0cd30f 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -961,18 +961,28 @@ static void shmem_delete_from_page_cache(struct f=
olio *folio, void *radswap)
> >    * the number of pages being freed. 0 means entry not found in XArray=
 (0 pages
> >    * being freed).
> >    */
> > -static long shmem_free_swap(struct address_space *mapping,
> > -                         pgoff_t index, void *radswap)
> > +static long shmem_free_swap(struct address_space *mapping, pgoff_t ind=
ex,
> > +                         unsigned int max_nr, void *radswap)
> >   {
> > -     int order =3D xa_get_order(&mapping->i_pages, index);
> > -     void *old;
> > +     XA_STATE(xas, &mapping->i_pages, index);
> > +     unsigned int nr_pages =3D 0;
> > +     void *entry;
> >
> > -     old =3D xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0=
);
> > -     if (old !=3D radswap)
> > -             return 0;
> > -     swap_put_entries_direct(radix_to_swp_entry(radswap), 1 << order);
> > +     xas_lock_irq(&xas);
> > +     entry =3D xas_load(&xas);
> > +     if (entry =3D=3D radswap) {
> > +             nr_pages =3D 1 << xas_get_order(&xas);
> > +             if (index =3D=3D round_down(xas.xa_index, nr_pages) && nr=
_pages < max_nr)
> > +                     xas_store(&xas, NULL);
> > +             else
> > +                     nr_pages =3D 0;
> > +     }
> > +     xas_unlock_irq(&xas);
> > +
> > +     if (nr_pages)
> > +             swap_put_entries_direct(radix_to_swp_entry(radswap), nr_p=
ages);
> >
> > -     return 1 << order;
> > +     return nr_pages;
> >   }
>
> Thanks for the analysis, and it makes sense to me. Would the following
> implementation be simpler and also address your issue (we will not
> release the lock in __xa_cmpxchg() since gfp =3D 0)?

Hi Baolin,

>
> static long shmem_free_swap(struct address_space *mapping,
>                              pgoff_t index, void *radswap)
> {
>          XA_STATE(xas, &mapping->i_pages, index);
>          int order;
>          void *old;
>
>          xas_lock_irq(&xas);
>          order =3D xas_get_order(&xas);

Thanks for the suggestion. I did consider implementing it this way,
but I was worried that the order could grow upwards. For example
shmem_undo_range is trying to free 0-95 and there is an entry at 64
with order 5 (64 - 95). Before shmem_free_swap is called, the entry
was swapped in, then the folio was freed, then an order 6 folio was
allocated there and swapped out again using the same entry.

Then here it will free the whole order 6 entry (64 - 127), while
shmem_undo_range is only supposed to erase (0-96).

That's why I added a max_nr argument to the helper. The GFP =3D=3D 0 below
looks not very clean either, that's trivial though.

>          old =3D __xa_cmpxchg(xas.xa, index, radswap, NULL, 0);

Am I overthinking it?

