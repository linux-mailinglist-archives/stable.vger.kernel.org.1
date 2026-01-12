Return-Path: <stable+bounces-208064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A00D11A30
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0F0D3007938
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83C1277CBF;
	Mon, 12 Jan 2026 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL5kGuzu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB39827AC31
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211747; cv=none; b=G7+sjXlZ2Wu0D+se4iSfWAqloAB0hj0pO3hHqbg6AaJDyiL8dDaganJp/4oCOtUFcRfdBa9zAtZ+1HMRgJHsY98d5wQ8vfmt6zrFgoh+W18qNRIs5dcV9qYhjaldKFj9nH1rHWIJrYMgwSrecYafR3PYpAiyJToVuruWodfNcHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211747; c=relaxed/simple;
	bh=LPI094l9LVadjnD24orr/hJdukIh5i9lRUnb6svtzho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvGhqFdquW6lSHlv3m+196VOJlag9S3PknQDp6IyGh9wmGKZ+4fWICNJHKS2s416l8EbIEmZgoITZRaMr8+/GN3FhQMrOzklaRydDi2zMbP474YOq454yTFHf58UNUI/b4dc4Cc5S/542/bYxsYwd5PEtzZUwwE07C7d+futq9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL5kGuzu; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64d0d41404cso10060970a12.0
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 01:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768211744; x=1768816544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK8RvD0wg0cx8lVS3kyXyRfv713Ea0iYheTw/LCOhM0=;
        b=HL5kGuzuX/bkByFPW1tfL7hR7wAyL0yleLnzu6wHoIHtoWKuuNkdVLgEBD/FdQHN6X
         RTzyGyACxwLvXQVRQcblLD0vrITopqtlIrwHv74d6CEqAipqGSPLrdQsTflp4tbadJdQ
         z88wO8vks2GL3P0VDzKlEjht7/Z0p4b+ZsNdO149mYXbXhzTXY+hOlRpjanOplXIHEI0
         yvU4Bvll1j84grmISJhPxp2q0HOmHEjxpo4+QY0cXSWbKNzH1a3s1POIOHyTbq/iAYuq
         WznFwM72pY1WbVbW7llk6tY/64HgGP944dyjwnUmdVZkBOl8WZLUlYZv+BKfNu7fYxs7
         sYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768211744; x=1768816544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hK8RvD0wg0cx8lVS3kyXyRfv713Ea0iYheTw/LCOhM0=;
        b=vcBk54R2k2u2rymygqdki9z0bxNNJpcRNaR+DrpJImLTQ+Bj59GsAsbNdj9W6Aw9RK
         CB7F3R4awRFZhU5KBzGdymFS2WekL+/BhCO1KeTXJSzKnwQa4EIjEv5i+BmPo2g2giYJ
         bxzKuJzGO89sdb3owfuqWQaVU5kHsr27zezdNJOAADc82eu4cIS6uAnu9AWy3C6jGCIa
         mPA4XIuRpdunKtAWcbDZAQOCY+pfHUCyRV9NOlKaH5hHrXvH15hVX1feFiF17wqs2tVQ
         rp6V7uSbPRnKx9fdiwg1PMRB6Kf2dxBvCzAYVuWC8hwSG+KrEzVkjYXGwqC5WcdEApyB
         Ykqw==
X-Forwarded-Encrypted: i=1; AJvYcCU/YxOBDYdI7J0/K3K4ya3/26nMF8qSuXSLt/PX01zHTbp+/uwc321MRpAzAQkG+3IsTGV0UUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSOHPx5TqD5rCO/x3s12nljNM0yiJLSlJRG8EbO0yt5WxTz3S7
	J1+/LNNcEOlf/d9Do4Hz0CAFfHf7d4BLXOTgNIO9IJOksPhqP6ok80r9ds9P8lNu0aH0VPh1d/G
	QMpGT6ovplXJgUK0MdeQRiGn94jioLZA=
X-Gm-Gg: AY/fxX4o81lYPuqu2heZLoUJVV7OotWOj051mIeGSbJMagkSIfCHIdGkmhLm6VNMISa
	26t4jpb8ahKjroydc2ahm/7wG0iNYlvoQlhSFKffuG2+PjRKNHgUqG3qFbbEKxwjd+RmcQPRZrM
	Cl03jcmLCONzH3+S2zlh+ICUjZIJRki8lGXmXltPNKJgwLt/TMuSS+sd/yqg9pYEXeONQ15cu61
	SGjL2ax8aEYUASOJLSS4sllBmH892yhJJXHdfdynkY+Ku6BxMaP6dX8zXLs9NdDIVJiG6KhM+4/
	O9UbRSye8zIDYF6q11o7jUyP+mEK
X-Google-Smtp-Source: AGHT+IHL4tD/eA41YzB9jltvfCK39D5lYU0R/uXdXlmYGdDlSTlXcrJ/8VqcjD71w0d57VLK7uMQoI2FDyF+f0gkQSM=
X-Received: by 2002:a05:6402:1ecf:b0:640:f2cd:831 with SMTP id
 4fb4d7f45d1cf-65097ddd11cmr16678648a12.10.1768211743873; Mon, 12 Jan 2026
 01:55:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-shmem-swap-fix-v1-1-0f347f4f6952@tencent.com>
 <d20f536c-edc1-42a0-9978-13918d39ecba@linux.alibaba.com> <CAMgjq7ASxBdAakd_3J3O-nPysArLruGO-j4rCHg6OFvvNq7f0g@mail.gmail.com>
 <1dffe6b1-7a89-4468-8101-35922231f3a6@linux.alibaba.com>
In-Reply-To: <1dffe6b1-7a89-4468-8101-35922231f3a6@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 12 Jan 2026 17:55:07 +0800
X-Gm-Features: AZwV_QhXBjzBmhSsBlEr9V_cMtomZ7AHf_ABUPMfh__jgYGB1Qr8yYkPUcXksXo
Message-ID: <CAMgjq7Biq9nB_waZeWW+iJUa9Pj+paSSrke-tmnB=-3uY8k2VA@mail.gmail.com>
Subject: Re: [PATCH] mm/shmem, swap: fix race of truncate and swap entry split
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 4:22=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
> On 1/12/26 1:56 PM, Kairui Song wrote:
> > On Mon, Jan 12, 2026 at 12:00=E2=80=AFPM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >> On 1/12/26 1:53 AM, Kairui Song wrote:
> >>> From: Kairui Song <kasong@tencent.com>
> >>>
> >>> The helper for shmem swap freeing is not handling the order of swap
> >>> entries correctly. It uses xa_cmpxchg_irq to erase the swap entry,
> >>> but it gets the entry order before that using xa_get_order
> >>> without lock protection. As a result the order could be a stalled val=
ue
> >>> if the entry is split after the xa_get_order and before the
> >>> xa_cmpxchg_irq. In fact that are more way for other races to occur
> >>> during the time window.
> >>>
> >>> To fix that, open code the Xarray cmpxchg and put the order retrivial=
 and
> >>> value checking in the same critical section. Also ensure the order wo=
n't
> >>> exceed the truncate border.
> >>>
> >>> I observed random swapoff hangs and swap entry leaks when stress
> >>> testing ZSWAP with shmem. After applying this patch, the problem is r=
esolved.
> >>>
> >>> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Kairui Song <kasong@tencent.com>
> >>> ---
> >>>    mm/shmem.c | 35 +++++++++++++++++++++++------------
> >>>    1 file changed, 23 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/mm/shmem.c b/mm/shmem.c
> >>> index 0b4c8c70d017..e160da0cd30f 100644
> >>> --- a/mm/shmem.c
> >>> +++ b/mm/shmem.c
> >>> @@ -961,18 +961,28 @@ static void shmem_delete_from_page_cache(struct=
 folio *folio, void *radswap)
> >>>     * the number of pages being freed. 0 means entry not found in XAr=
ray (0 pages
> >>>     * being freed).
> >>>     */
> >>> -static long shmem_free_swap(struct address_space *mapping,
> >>> -                         pgoff_t index, void *radswap)
> >>> +static long shmem_free_swap(struct address_space *mapping, pgoff_t i=
ndex,
> >>> +                         unsigned int max_nr, void *radswap)
> >>>    {
> >>> -     int order =3D xa_get_order(&mapping->i_pages, index);
> >>> -     void *old;
> >>> +     XA_STATE(xas, &mapping->i_pages, index);
> >>> +     unsigned int nr_pages =3D 0;
> >>> +     void *entry;
> >>>
> >>> -     old =3D xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL,=
 0);
> >>> -     if (old !=3D radswap)
> >>> -             return 0;
> >>> -     swap_put_entries_direct(radix_to_swp_entry(radswap), 1 << order=
);
> >>> +     xas_lock_irq(&xas);
> >>> +     entry =3D xas_load(&xas);
> >>> +     if (entry =3D=3D radswap) {
> >>> +             nr_pages =3D 1 << xas_get_order(&xas);
> >>> +             if (index =3D=3D round_down(xas.xa_index, nr_pages) && =
nr_pages < max_nr)
> >>> +                     xas_store(&xas, NULL);
> >>> +             else
> >>> +                     nr_pages =3D 0;
> >>> +     }
> >>> +     xas_unlock_irq(&xas);
> >>> +
> >>> +     if (nr_pages)
> >>> +             swap_put_entries_direct(radix_to_swp_entry(radswap), nr=
_pages);
> >>>
> >>> -     return 1 << order;
> >>> +     return nr_pages;
> >>>    }
> >>
> >> Thanks for the analysis, and it makes sense to me. Would the following
> >> implementation be simpler and also address your issue (we will not
> >> release the lock in __xa_cmpxchg() since gfp =3D 0)?
> >
> > Hi Baolin,
> >
> >>
> >> static long shmem_free_swap(struct address_space *mapping,
> >>                               pgoff_t index, void *radswap)
> >> {
> >>           XA_STATE(xas, &mapping->i_pages, index);
> >>           int order;
> >>           void *old;
> >>
> >>           xas_lock_irq(&xas);
> >>           order =3D xas_get_order(&xas);
> >
> > Thanks for the suggestion. I did consider implementing it this way,
> > but I was worried that the order could grow upwards. For example
> > shmem_undo_range is trying to free 0-95 and there is an entry at 64
> > with order 5 (64 - 95). Before shmem_free_swap is called, the entry
> > was swapped in, then the folio was freed, then an order 6 folio was
> > allocated there and swapped out again using the same entry.
> >
> > Then here it will free the whole order 6 entry (64 - 127), while
> > shmem_undo_range is only supposed to erase (0-96).
>
> Good point. However, this cannot happen during swapoff, because the
> 'end' is set to -1 in shmem_evict_inode().

That's not only for swapff, shmem_truncate_range / falloc can also use it r=
ight?

>
> Actually, the real question is how to handle the case where a large swap
> entry happens to cross the 'end' when calling shmem_truncate_range(). If
> the shmem mapping stores a folio, we would split that large folio by
> truncate_inode_partial_folio(). If the shmem mapping stores a large swap
> entry, then as you noted, the truncation range can indeed exceed the 'end=
'.
>
> But with your change, that large swap entry would not be truncated, and
> I=E2=80=99m not sure whether that might cause other issues. Perhaps the b=
est
> approach is to first split the large swap entry and only truncate the
> swap entries within the 'end' boundary like the
> truncate_inode_partial_folio() does.

Right... I was thinking that the shmem_undo_range iterates the undo
range twice IIUC, in the second try it will retry if shmem_free_swap
returns 0:

swaps_freed =3D shmem_free_swap(mapping, indices[i], end - indices[i], foli=
o);
if (!swaps_freed) {
    /* Swap was replaced by page: retry */
    index =3D indices[i];
    break;
}

So I thought shmem_free_swap returning 0 is good enough. Which is not,
it may cause the second loop to retry forever.

>
> Alternatively, this patch could only focus on the race on the order,
> which seems uncontested. As for handling large swap entries that go
> beyond the 'end', should we address that in a follow-up, for example by
> splitting? What do you think?
>

I think a partial fix is still wrong, How about we just handle the
split here, like this?

static int shmem_free_swap(struct address_space *mapping, pgoff_t index,
                unsigned int max_nr, void *radswap)
{
    XA_STATE(xas, &mapping->i_pages, index);
    int nr_pages =3D 0, ret;
    void *entry;
    bool split;

retry:
    xas_lock_irq(&xas);
    entry =3D xas_load(&xas);
    if (entry =3D=3D radswap) {
        nr_pages =3D 1 << xas_get_order(&xas);
        /*
         * Check if the order growed upwards and a larger entry is
         * now covering the target entry. In this case caller may need to
         * restart the iteration.
         */
        if (index !=3D round_down(xas.xa_index, nr_pages)) {
            xas_unlock_irq(&xas);
            return 0;
        }

        /* Check if we are freeing part of a large entry. */
        if (nr_pages > max_nr) {
            xas_unlock_irq(&xas);
            /* Let the caller decide what to do by returning 0 if
split failed. */
            if (shmem_split_large_entry(mapping, index + max_nr,
radswap, mapping_gfp(mapping)))
                return 0;
            goto retry;
        }

        xas_store(&xas, NULL);
        xas_unlock_irq(&xas);

        swap_put_entries_direct(radix_to_swp_entry(radswap), nr_pages);
        return nr_pages;
    }

    xas_unlock_irq(&xas);
    return 0;
}

