Return-Path: <stable+bounces-211323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGjHDBXUcmnKpgAAu9opvQ
	(envelope-from <stable+bounces-211323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 02:51:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E606F5C0
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 02:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AD05304A55C
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 01:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26EA3803F6;
	Fri, 23 Jan 2026 01:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2GSasFj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5F2322B90
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 01:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132797; cv=none; b=gBg2YFXWlUr9TPLcl55MYrS9WQwYGhQnqtk+MSlVXBqh/t8OJqVejQtDYRGt5x4gaK1JGNL15818xFWaVzAyl2P/GKjYOYiM6Cavek96Ck+7auVvA3O4k7vdF8YzaOq6udZzFejv9YfkccVabTLz3pFSkbnFXoAFesFe/tNbHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132797; c=relaxed/simple;
	bh=3n1kN6yU3UzQT4Lma3/YbJ3jqKYjPnr9GLpUMco4Z24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXrybDD4IiHm4oVpH2UAI4qtIgIq0ETfl9VvRO7Fv/v1YboHP+ENod+N9ErrUPsJwOn+l8N8gJvBCM24W+DaoPMZdaoGeW3N4dQ5Nc5Q+vE8nU6vctZuIy1I9VdnT8oeWwOuAsAUCPZ1AxPEIPYVSz7dLFN+x861GWHaTt/YDOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2GSasFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7069C2BC86
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 01:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769132795;
	bh=3n1kN6yU3UzQT4Lma3/YbJ3jqKYjPnr9GLpUMco4Z24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s2GSasFjjZyZzFb3bGk9vTxEuOFrBf9WHE7QBAjFxLVnkRR7oM5WejxLeaTbmV6Af
	 XPLyT7Bqc6A6bBoJ8/crxLPZTn5WCTdh6UTqpYuvG5iUKsts/MbGIf8EciSoHKvcwt
	 +kGxdc2+xudUfklPLXPoeKghG5WpM3mnXgA187/ufETiPIDgLVxw20iqFrF8HvFpO1
	 4xjgkMi3TdslFbNQsfM9NJ+n48lZhyz8jiuYQD7GnLWMvmbfKn/jj1iVhmcp+S5j30
	 d17CcM9fLnKchNhg8qTiE98D4YX2kGfF94h1WEZ8L9XDrlmqI6Pjqk8YZBGUkPzhqm
	 ttFdOBZ2O061w==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7942fca0da6so9369687b3.3
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 17:46:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWs1xLqgeXx08psgj16yIwFxLombROIGAqPT2oHKlkKZSEIWb5Vt7RyI+YOQVrJ0RX3qXMQh8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHj17YbUPt0Fi3kwZNWGwAHr4brbzkGpzf/hirW+3F4gBlSt+H
	p8rGTJadyr//CahFpbu+Qe5xrT3Yw+mnnNKJtm9uFN+7aI+AfhTzzbsKtTB3xbIoCOpdsEeVnb2
	MhjEDP/EP3trkq75MRYRbhyjOmftGwrEl0PU0+zn98w==
X-Received: by 2002:a05:690c:fc2:b0:794:2fed:5370 with SMTP id
 00721157ae682-794398bbae2mr13533937b3.4.1769132794957; Thu, 22 Jan 2026
 17:46:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-shmem-swap-fix-v3-1-3d33ebfbc057@tencent.com>
In-Reply-To: <20260120-shmem-swap-fix-v3-1-3d33ebfbc057@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 22 Jan 2026 17:46:24 -0800
X-Gmail-Original-Message-ID: <CACePvbVG0OubuZfT0+kY77BjrePQsopdFVTyuorMm_eE=chmiQ@mail.gmail.com>
X-Gm-Features: AZwV_QgOZRgtcLiF7s7TDclkawC0lZhk5ppCm7mmTLXyBp7ktzXk191M10WUAMc
Message-ID: <CACePvbVG0OubuZfT0+kY77BjrePQsopdFVTyuorMm_eE=chmiQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/shmem, swap: fix race of truncate and swap entry split
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,google.com,linux.alibaba.com,linux-foundation.org,huaweicloud.com,gmail.com,redhat.com,kernel.org,vger.kernel.org,tencent.com];
	TAGGED_FROM(0.00)[bounces-211323-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: A7E606F5C0
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 8:11=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> The helper for shmem swap freeing is not handling the order of swap
> entries correctly. It uses xa_cmpxchg_irq to erase the swap entry, but
> it gets the entry order before that using xa_get_order without lock
> protection, and it may get an outdated order value if the entry is split
> or changed in other ways after the xa_get_order and before the
> xa_cmpxchg_irq.
>
> And besides, the order could grow and be larger than expected, and cause
> truncation to erase data beyond the end border. For example, if the
> target entry and following entries are swapped in or freed, then a large
> folio was added in place and swapped out, using the same entry, the
> xa_cmpxchg_irq will still succeed, it's very unlikely to happen though.
>
> To fix that, open code the Xarray cmpxchg and put the order retrieval
> and value checking in the same critical section. Also, ensure the order
> won't exceed the end border, skip it if the entry goes across the
> border.
>
> Skipping large swap entries crosses the end border is safe here.
> Shmem truncate iterates the range twice, in the first iteration,
> find_lock_entries already filtered such entries, and shmem will
> swapin the entries that cross the end border and partially truncate the
> folio (split the folio or at least zero part of it). So in the second
> loop here, if we see a swap entry that crosses the end order, it must
> at least have its content erased already.
>
> I observed random swapoff hangs and kernel panics when stress testing
> ZSWAP with shmem. After applying this patch, all problems are gone.
>
> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Chris Li <chrisl@kernel.org>

For the record the two stage retry loop in shmem_undo_range() is not
easy for me to follow. Thanks for the fix.

Chris

> ---
> Changes in v3:
> - Rebased on top of mainline.
> - Fix nr_pages calculation [ Baolin Wang ]
> - Link to v2: https://lore.kernel.org/r/20260119-shmem-swap-fix-v2-1-034c=
946fd393@tencent.com
>
> Changes in v2:
> - Fix a potential retry loop issue and improvement to code style thanks
>   to Baoling Wang. I didn't split the change into two patches because a
>   separate patch doesn't stand well as a fix.
> - Link to v1: https://lore.kernel.org/r/20260112-shmem-swap-fix-v1-1-0f34=
7f4f6952@tencent.com
> ---
>  mm/shmem.c | 45 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index ec6c01378e9d..6c3485d24d66 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -962,17 +962,29 @@ static void shmem_delete_from_page_cache(struct fol=
io *folio, void *radswap)
>   * being freed).
>   */
>  static long shmem_free_swap(struct address_space *mapping,
> -                           pgoff_t index, void *radswap)
> +                           pgoff_t index, pgoff_t end, void *radswap)
>  {
> -       int order =3D xa_get_order(&mapping->i_pages, index);
> -       void *old;
> +       XA_STATE(xas, &mapping->i_pages, index);
> +       unsigned int nr_pages =3D 0;
> +       pgoff_t base;
> +       void *entry;
>
> -       old =3D xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0=
);
> -       if (old !=3D radswap)
> -               return 0;
> -       free_swap_and_cache_nr(radix_to_swp_entry(radswap), 1 << order);
> +       xas_lock_irq(&xas);
> +       entry =3D xas_load(&xas);
> +       if (entry =3D=3D radswap) {
> +               nr_pages =3D 1 << xas_get_order(&xas);
> +               base =3D round_down(xas.xa_index, nr_pages);
> +               if (base < index || base + nr_pages - 1 > end)
> +                       nr_pages =3D 0;
> +               else
> +                       xas_store(&xas, NULL);
> +       }
> +       xas_unlock_irq(&xas);
> +
> +       if (nr_pages)
> +               free_swap_and_cache_nr(radix_to_swp_entry(radswap), nr_pa=
ges);
>
> -       return 1 << order;
> +       return nr_pages;
>  }
>
>  /*
> @@ -1124,8 +1136,8 @@ static void shmem_undo_range(struct inode *inode, l=
off_t lstart, uoff_t lend,
>                         if (xa_is_value(folio)) {
>                                 if (unfalloc)
>                                         continue;
> -                               nr_swaps_freed +=3D shmem_free_swap(mappi=
ng,
> -                                                       indices[i], folio=
);
> +                               nr_swaps_freed +=3D shmem_free_swap(mappi=
ng, indices[i],
> +                                                                 end - 1=
, folio);
>                                 continue;
>                         }
>
> @@ -1191,12 +1203,23 @@ static void shmem_undo_range(struct inode *inode,=
 loff_t lstart, uoff_t lend,
>                         folio =3D fbatch.folios[i];
>
>                         if (xa_is_value(folio)) {
> +                               int order;
>                                 long swaps_freed;
>
>                                 if (unfalloc)
>                                         continue;
> -                               swaps_freed =3D shmem_free_swap(mapping, =
indices[i], folio);
> +                               swaps_freed =3D shmem_free_swap(mapping, =
indices[i],
> +                                                             end - 1, fo=
lio);
>                                 if (!swaps_freed) {
> +                                       /*
> +                                        * If found a large swap entry cr=
oss the end border,
> +                                        * skip it as the truncate_inode_=
partial_folio above
> +                                        * should have at least zerod its=
 content once.
> +                                        */
> +                                       order =3D shmem_confirm_swap(mapp=
ing, indices[i],
> +                                                                  radix_=
to_swp_entry(folio));
> +                                       if (order > 0 && indices[i] + (1 =
<< order) > end)
> +                                               continue;
>                                         /* Swap was replaced by page: ret=
ry */
>                                         index =3D indices[i];
>                                         break;
>
> ---
> base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
> change-id: 20260111-shmem-swap-fix-8d0e20a14b5d
>
> Best regards,
> --
> Kairui Song <kasong@tencent.com>
>

