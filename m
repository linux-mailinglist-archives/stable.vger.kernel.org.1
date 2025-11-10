Return-Path: <stable+bounces-192932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B67EC46509
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0E3188190F
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 11:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF28307ACF;
	Mon, 10 Nov 2025 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kw2OM9VZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01C63081AF
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774662; cv=none; b=HHaCQAp2T/duKm+maAvlKm8VZ/vKpxLOoT7h29O9mjUlEj0Po1DB16jm8O3K+lfkjFnQG3esMRRyrpQghNQNuqNwGXvqB55BQYTzUw+NACd5PkkJu9UtSGvewd2RP+/dsO/khTS4N3uV1hNASaCyKkBCAtNKigxX9bGkQUL/V9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774662; c=relaxed/simple;
	bh=iDGR6kujmbdSBbmG+AD0H7K/yP2vLnwxrdfXu+qCQs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rq1HJrYWx1givsl2C5+Vz8SqGJAbf+QV9ZglM9oCqzWWopr8Dy/T1P86YyHEYXpBse+2vkFJWq1FKbuBc/gmuB7STOUNV0f1LDPHOYMfv885mzdM7orgkWTsZHQuqvEFtRZbpaNBJvafzX3VedV2+fJWix9KZw25n+P9IekgiOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kw2OM9VZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3408c9a8147so2285752a91.0
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 03:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762774660; x=1763379460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLlD7ajwlaj6jb6Z6UcGg3eD8sukiXTCecz3SZYTV1c=;
        b=Kw2OM9VZSjlJ2/zF7ojg/i1cCRZS1YjaR7NhfTDKTZjbIsuVpuTWP12Z4XW2bf9ql0
         uwx84h4IB9m5A3mh02r/AsRsBaN46TIjuId8pNIRdNLZ/V/3tFDcUeDUIgdlVxPs4HGl
         GJTFSt5XO2QcDg9T58LeU30ba4aPrHaiAGLYfJodNt33x0eyVYy6E/txRymNfDc+R8lX
         HrZUR9ymQOO/+qKW4YX7r/8Vpc++d4XCHsXNsHXCSXMkml5Z3SOEBYIt8JeYv8qgwAr5
         RRTo/Mtmv5D7G62ScuzA1q1i6wjblR3sWH29L48qsFaX8erHP0a98tyCwKG+8eb79+25
         D8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762774660; x=1763379460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lLlD7ajwlaj6jb6Z6UcGg3eD8sukiXTCecz3SZYTV1c=;
        b=Cwif1CZSO47h9hdvmuA16//M3qYKGpD5hymD7941BTO3HTUuHqTE0wKn5voZ4VOAec
         tkHVdnpNr/uzVb+fkHB2GeNjhH8AebQR9xGU8yfBKeMLTbXY7rgPBxEorYAwxXg1bkaG
         Cq57UrBtAEzfTd8D0C1kCI1rLRH5t59HENcLfo2E4GLMrrR6yzWxoKZDKFk6voVhe8Td
         VoepO2CQ5Fv86QzX5kiXteUinIW9G/NG6MIHQXJbs+P8rWz4zknoPbuldaRIW7Tn5pDJ
         sYrS2UOhRQUXLzDLALhC0pE/2+qTZsXpe+w0mY8OUGvjNueaZwn/tajzIrg3p6sIZ9uR
         H59g==
X-Forwarded-Encrypted: i=1; AJvYcCVvQ1Ro7d02s+CzgMEM+WmkvUmXG7dFVCbIo4Qn/ayJ0LwNKuWZGFXvFH2QKDh38+ppsBZFeNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRX7DR4wvlQEzva6SR6LVkgulQcfkZIWoKO/0mMdVBTmJ5OCTw
	+hRvMrkhivD65Itna5fhLRvGEq2gnHF4MxecNKWHr2gtpzgcUT6CvPoFwBJKN4Ms8cBYUotcx4E
	Woar1guQX84zPHpRGlzBbZHrg74aALyA=
X-Gm-Gg: ASbGncv5O9CN71RufLd/gxgjsyxhbB7vgF4rg1A+XJY5LPTtDgKhbeoIuHRe2BLiSP6
	7Oe0Orw6Olc2msLYiWx4/cRzKU069ocaCs2WRuPSztPTQuJRx4L56oqnOxXiKczFzpb0F1JvzJq
	rtqVsJEU0QwgdkWLDG2LRcN3+F5KVxSvPKHGm2KcKRuLbk/5WDmKPtEyx363B5mdOC3JDaNjrh2
	/wEgj3CdG/FrptmJp7eJ3U2X+j6jYXPB0vFR1NiUfw6vC2PF8ULuxwCae6iNoFyIUqQgg==
X-Google-Smtp-Source: AGHT+IHTguIiHquwsDWY+79OedOt9HQKo0mp/t8Ev2XHHW+BWzgfIoUuwYbZRUwbIMYycRiIsrTWcS+UGzxVQ2WRxLk=
X-Received: by 2002:a17:90b:4f4c:b0:343:a298:90ac with SMTP id
 98e67ed59e1d1-343a29893d3mr3232942a91.0.1762774660033; Mon, 10 Nov 2025
 03:37:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110-revert-78524b05f1a3-v1-1-88313f2b9b20@tencent.com>
 <875xbiodl2.fsf@DESKTOP-5N7EMDA> <CAMgjq7CTdtjMUUk2YvanL_PMZxS_7+pQhHDP-DjkhDaUhDRjDw@mail.gmail.com>
 <877bvymaau.fsf@DESKTOP-5N7EMDA>
In-Reply-To: <877bvymaau.fsf@DESKTOP-5N7EMDA>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 10 Nov 2025 19:37:01 +0800
X-Gm-Features: AWmQ_bkjqdnK8Cy3B0Xx0uCR5RCBhqT3UBp_P6dSxB7W8VE0ScC_scO1hHX9q-4
Message-ID: <CAMgjq7BsnGFDCVGRQoa+evBdOposnAKM3yKpf5gGykefUvq-mg@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm, swap: avoid redundant swap device pinning"
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Chris Li <chrisl@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 6:50=E2=80=AFPM Huang, Ying
<ying.huang@linux.alibaba.com> wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > On Mon, Nov 10, 2025 at 9:56=E2=80=AFAM Huang, Ying
> > <ying.huang@linux.alibaba.com> wrote:
> >>
> >> Hi, Kairui,
> >>
> >> Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org> write=
s:
> >>
> >> > From: Kairui Song <kasong@tencent.com>
> >> >
> >> > This reverts commit 78524b05f1a3e16a5d00cc9c6259c41a9d6003ce.
> >> >
> >> > While reviewing recent leaf entry changes, I noticed that commit
> >> > 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning") isn't
> >> > correct. It's true that most all callers of __read_swap_cache_async =
are
> >> > already holding a swap entry reference, so the repeated swap device
> >> > pinning isn't needed on the same swap device, but it is possible tha=
t
> >> > VMA readahead (swap_vma_readahead()) may encounter swap entries from=
 a
> >> > different swap device when there are multiple swap devices, and call
> >> > __read_swap_cache_async without holding a reference to that swap dev=
ice.
> >> >
> >> > So it is possible to cause a UAF if swapoff of device A raced with
> >> > swapin on device B, and VMA readahead tries to read swap entries fro=
m
> >> > device A. It's not easy to trigger but in theory possible to cause r=
eal
> >> > issues. And besides, that commit made swap more vulnerable to issues
> >> > like corrupted page tables.
> >> >
> >> > Just revert it. __read_swap_cache_async isn't that sensitive to
> >> > performance after all, as it's mostly used for SSD/HDD swap devices =
with
> >> > readahead. SYNCHRONOUS_IO devices may fallback onto it for swap coun=
t >
> >> > 1 entries, but very soon we will have a new helper and routine for
> >> > such devices, so they will never touch this helper or have redundant
> >> > swap device reference overhead.
> >>
> >> Is it better to add get_swap_device() in swap_vma_readahead()?  Whenev=
er
> >> we get a swap entry, the first thing we need to do is call
> >> get_swap_device() to check the validity of the swap entry and prevent
> >> the backing swap device from going under us.  This helps us to avoid
> >> checking the validity of the swap entry in every swap function.  Does
> >> this sound reasonable?
> >
> > Hi Ying, thanks for the suggestion!
> >
> > Yes, that's also a feasible approach.
> >
> > What I was thinking is that, currently except the readahead path, all
> > swapin entry goes through the get_swap_device() helper, that helper
> > also helps to mitigate swap entry corruption that may causes OOB or
> > NULL deref. Although I think it's really not that helpful at all to
> > mitigate page table corruption from the kernel side, but seems not a
> > really bad idea to have.
> >
> > And the code is simpler this way, and seems more suitable for a stable
> > & mainline fix. If we want  to add get_swap_device() in
> > swap_vma_readahead(), we need to do that for every entry that doesn't
> > match the target entry's swap device. The reference overhead is
> > trivial compared to readhead and bio layer, and only non
> > SYNCHRONOUS_IO devices use this helper (madvise is a special case, we
> > may optimize that later). ZRAM may fallback to the readahead path but
> > this fallback will be eliminated very soon in swap table p2.
>
> We have 2 choices in general.
>
> 1. Add get/put_swap_device() in every swap function.
>
> 2. Add get/put_swap_device() in every caller of the swap functions.
>
> Personally, I prefer 2.  It works better in situations like calling
> multiple swap functions.  It can reduce duplicated references.  It helps
> improve code reasoning and readability.

Totally agree, that's exactly what the recently added kerneldoc is
suggesting, caller of the swap function will need to use refcount or
lock to protect the swap device.

I'm not suggesting to add get/put in every function, just thinking
that maybe reverting it can have some nice side effects.

But anyway, this fix should also be good:

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 3f85a1c4cfd9..4cca4865627f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -747,6 +747,7 @@ static struct folio
*swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,

        blk_start_plug(&plug);
        for (addr =3D start; addr < end; ilx++, addr +=3D PAGE_SIZE) {
+               struct swap_info_struct *si =3D NULL;
                leaf_entry_t entry;

                if (!pte++) {
@@ -761,8 +762,12 @@ static struct folio
*swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
                        continue;
                pte_unmap(pte);
                pte =3D NULL;
+               if (swp_type(entry) !=3D swp_type(targ_entry))
+                       si =3D get_swap_device(entry);
                folio =3D __read_swap_cache_async(entry, gfp_mask, mpol, il=
x,
                                                &page_allocated, false);
+               if (si)
+                       put_swap_device(si);
                if (!folio)
                        continue;
                if (page_allocated) {

I'll post a patch if it looks ok.

