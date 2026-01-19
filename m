Return-Path: <stable+bounces-210250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19189D39C55
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 03:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB1CE30065BC
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 02:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9731F9F7A;
	Mon, 19 Jan 2026 02:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJpKeWa6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6504317D
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768789110; cv=pass; b=u9TPpzZ4QYlBPg5ZIq8eNx7aRHVGxr0TvEBtexUmCrQJIksMWvS3zSXTVdPG+rdu4GMghHqIuEYb75QY6hndUN4vBs9fMRKUlkBbLKdMRCBAub/br+ucrMonS1nLJKOhW/6f5yUO4fCp3XBDEfXs7O3xICKhJmHnXreDbSWQAAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768789110; c=relaxed/simple;
	bh=f6j3Dt/mVA/7NLX9/hZQxUBjRIOpQmrAy0EbCVmZvHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8VJqLaaoyI1RFL/aDpo0xa1Dz0IVclFIq4uEVjLsFXGKskWphPhk4SkNYG7DJ80z4NFqRNYFIJgM05ae6r9me0tCo9lK/+gaBkSQ9tHDs82kAyfAcqoS7tdi9nUNNtLWL/y6YKmJdnX23dbmO1K7poV8YyysaB3BcAj6YG5xio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJpKeWa6; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so6443983a12.1
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 18:18:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768789107; cv=none;
        d=google.com; s=arc-20240605;
        b=M0VOkIyfQ8+0OU77qjhoHxj0DNtuZ51z3SRqrKBTph0603zSs3LTMwvTK5QYbccjlj
         xkfzkmcLbHYVIVuaxI17REMfsSG7eLF6ibYzGYQQlPV0qmgZecOGZnPv3F0BSH/4PQSo
         c/TQ5nR5NlEUD4GAsZTYKtRteU1+xR6AzZrQWhrxtwJqlr8Oh5TgMgMp7AA1r/LR+n/N
         q0EAQtgWuFMur3AWxjra0YQ0cHsqvoGL0lQFXnaWHiQe0okTU2Ipb9kr3CmjbfbWFRs7
         soaMJ0DX+8qr1ljMB++pJ2R1BqTp7ZIh4m6/vDeTKoZIjeFNVRKAxjgvb4DHZm5b26Ic
         rSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lbVqX0y113pE3VuBeoL43QiSH2p0tgUteB/1HKVBpKw=;
        fh=cLlHBzpLsRPibhXE3FSz8XjaukjfyC2wttsi0P3xMMg=;
        b=IDp+n0OM5uTujnvGMGV1wLfytGcrVTW6n55nM95pifvxaaAKS/D4Lvmzu5kiku+lZN
         +w42ec3xkb8Zvh35WtesR+972q82g8x8A4Cl7lbBua6Jpmru0kxfahN56/9mQqsNiY16
         w/GDEfvqbRd49HhcBKilaj3cJBqc1L33424rxIriR3K30R+PTS+6nPjs9txr0GLaUuD7
         hB+yaq2LUtKiQHFBCsZY8ngKkAiteCEmWwyUmm52cnEisz6KO/staUkgYsOjZMP7tx+F
         ehsuvGZBVwZDLAcKLmNqDkaQZXT4l5i/KQd9Vil8T5VMiyznpW+JdNBYKS4LXSKq7Rnq
         fRhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768789107; x=1769393907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbVqX0y113pE3VuBeoL43QiSH2p0tgUteB/1HKVBpKw=;
        b=RJpKeWa6jy6Rw13Hh/UwfAsksPkujKDfFbisEyFXfFsMQruihehjE6e3f5o92kiQ4P
         R+dcBAgwN+IrOyBHD2cIMd1WMvwRcFfsEQrt9QmCfAAIRraTdr3XacKezMuar31L31W1
         S/RJ7sA6DSS2KZhcncejJwNPl73c5DZq4zzihnAkE9b/oy+ea4KjiT7aGPgxzkuRvg/a
         BCBqClrKN3u2ZI50Dzpsk9f/kzUsgqe93fwM9PgOW6fDw7k9jevxxKHRh0Y9UFFwLfGb
         XmfQSBr+6iZm26xBp9CID4U6nPOf0z9dWE2+64Ym/e1btrbz1o1+xmOSUaCK9np15jUy
         jv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768789107; x=1769393907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lbVqX0y113pE3VuBeoL43QiSH2p0tgUteB/1HKVBpKw=;
        b=oKjbdzG/MQztE1MZUdfDPbw3CwFNHDn0XN+U/q/FfVzdJgsZ/fI2ogkPsgvGN1y6U5
         YQMDww9hlJxSfOZ4ro9VIB7+GDs/Ppopibbq70ZVvgdxYVSWjuB+NxXOmLaUGQNBZPaW
         h3gzjuW2QZ3PP5WRG77BFOf760JbGW3qH4nEsbIQkrAYOw/WVeL881foxdTla6J7EsY0
         J92wYY+cyFGz9gmGkezPkpqiq4sD34+c/dcRH3GUJ/36sNqHZvd0aD9qtgq4wjPEatWJ
         70DW/IFHPwIJPtS7bY+bN+Vj1TB00cq1+bAnzajmnV6sp64qRG4JRebcVWFrOtuBHKzY
         /Lkw==
X-Forwarded-Encrypted: i=1; AJvYcCW9x5sFcTY7+PP9vaawR02rk2KK2DcOf6q2V3RwylbQBMAdQ7vQ4KGOEeRlfXmIU10TfFrXMQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKECRgsM3hleziCeF6DX5JTBIQvGfho9gKsIGXHW5sBa9wom2J
	klfoDiX/JN98AHQ5W04JLc0QTcUG1XL6zrqTpqogmV4+nlNH6zXbMQbRDzGammvBGAOxeqL6pi5
	KQr9wyyuOfGa+ZkvHMMmMgZklN6Oerho=
X-Gm-Gg: AY/fxX5dizhQIE1q8ml0Wpw363vgyAEvn+pom/+C99PSSH6Q2bAy2xjVKGa+fbbpU4r
	ZKRHPuk/SkJ6JoneYQUG58jDqp23pX8G9aU6r+gwjHdoRlFLKranxvreXyBr0vNqhsCHp8mmE0o
	Wh479qBaL2S4tzeBkYNRKlQIxRfpsgaBGIFR9vBdeCKnH9KV7qtal5r28GSjvAVMryLDqVj3IHq
	a/yrcdW3wvVvQDu1Wpp3uXUCcttrKWEhsZnUhWOtu3awpxfstqjdtTc2H1HumvVYvsL8CVOstpX
	C6Tn56lYJa3zHqxlIw/SUYANK+s=
X-Received: by 2002:a05:6402:2709:b0:64b:63d0:90b5 with SMTP id
 4fb4d7f45d1cf-654bb32c773mr7864449a12.17.1768789106902; Sun, 18 Jan 2026
 18:18:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-shmem-swap-fix-v2-1-034c946fd393@tencent.com> <20260118113315.b102a7728769f05c5aeec57c@linux-foundation.org>
In-Reply-To: <20260118113315.b102a7728769f05c5aeec57c@linux-foundation.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 19 Jan 2026 10:17:50 +0800
X-Gm-Features: AZwV_QhWLKnQHBcRkTfFshMsakcIqTl3ORpdLGOWc9aOTRMJJIchJq1TGdxna8M
Message-ID: <CAMgjq7AA1LoLopoFrmRBh5KiL75VtBORfTaR2Lafq3OttD5cDQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/shmem, swap: fix race of truncate and swap entry split
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 3:33=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 19 Jan 2026 00:55:59 +0800 Kairui Song <ryncsn@gmail.com> wrote:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > I observed random swapoff hangs and kernel panics when stress testing
> > ZSWAP with shmem. After applying this patch, all problems are gone.
> >
> > Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
>
> September 2024.
>
> Seems about right.  A researcher recently found that kernel bugs take two=
 years
> to fix.  https://pebblebed.com/blog/kernel-bugs?ref=3Ditsfoss.com
>
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -962,17 +962,29 @@ static void shmem_delete_from_page_cache(struct f=
olio *folio, void *radswap)
> >   * being freed).
> >   */
> >  static long shmem_free_swap(struct address_space *mapping,
> > -                         pgoff_t index, void *radswap)
> > +                         pgoff_t index, pgoff_t end, void *radswap)
> >  {
> > -     int order =3D xa_get_order(&mapping->i_pages, index);
> > -     void *old;
> > +     XA_STATE(xas, &mapping->i_pages, index);
> > +     unsigned int nr_pages =3D 0;
> > +     pgoff_t base;
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
> > +             base =3D round_down(xas.xa_index, nr_pages);
> > +             if (base < index || base + nr_pages - 1 > end)
> > +                     nr_pages =3D 0;
> > +             else
> > +                     xas_store(&xas, NULL);
> > +     }
> > +     xas_unlock_irq(&xas);
> > +
> > +     if (nr_pages)
> > +             swap_put_entries_direct(radix_to_swp_entry(radswap), nr_p=
ages);
> >
> > -     return 1 << order;
> > +     return nr_pages;
> >  }
> >
>
> What tree was this prepared against?
>
> Both Linus mainline and mm.git have
>
> : static long shmem_free_swap(struct address_space *mapping,
> :                           pgoff_t index, void *radswap)
> : {
> :       int order =3D xa_get_order(&mapping->i_pages, index);
> :       void *old;
> :
> :       old =3D xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0=
);
> :       if (old !=3D radswap)
> :               return 0;
> :       free_swap_and_cache_nr(radix_to_swp_entry(radswap), 1 << order);
> :
> :       return 1 << order;
> : }
>
> but that free_swap_and_cache_nr() call is absent from your tree.

Oh, I tested and sent this patch based on mm-unstable, because the bug
was found while I was testing swap table series. This is a 2 year old
existing bug though. Swapoff during high system pressure is not a very
common thing, and maybe mTHP for shmem is currently not very commonly
used either? So maybe that's why no one found this issue.

free_swap_and_cache_nr is renamed to swap_put_entries_direct in
mm-unstable, it's irrelevant to this fix or bug. The rename change was
made here:
https://lore.kernel.org/linux-mm/20251220-swap-table-p2-v5-14-8862a265a033@=
tencent.com/

Should I resend this patch base on the mainline and rebase that
series? Or should we merge this in mm-unstable first then I can
send seperate fixes for stable?

