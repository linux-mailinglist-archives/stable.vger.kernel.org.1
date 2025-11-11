Return-Path: <stable+bounces-194545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC33C50097
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 00:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257CC3AA2F6
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 23:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189FC2BF002;
	Tue, 11 Nov 2025 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W17u6B68"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2126222068A
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762902536; cv=none; b=ttzsmut+mI+6QkqQiN7yZ5UgKMoNod2mBS4EgDA2jfWbVTEmNpqr7vSkOZ63uQ1ODoyCjQC1cELXgGWp9m/jEcQOJy7179W+pXKv6mnZyxjrHE/9MS1AR101qpt0WMNO+psnzd/yp9d0OonuMx2sx9RDWbOuHPg8BBI1vtwvuXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762902536; c=relaxed/simple;
	bh=lzSt4xZGwU8JDpXsMR/xzbxlzTjUPinjnTH15xJvkbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iU6rn0HZH48I2/pAF7UHhztaorL7GdJ2gEMn4ka8esK55xKlZCttJOIZaeHOtpjhxAgmH5+pFdB+ubKcT9Xv/ISkvIjwMyMTQMEhvhD4NFBE+bemYrwLk+XwFEMAsL6CyHUMcQd4wTMKZLqG66dVsaAc2cCl5e3h/1JbXByyMVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W17u6B68; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b387483bbso124503f8f.1
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 15:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762902533; x=1763507333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fz6bHuZsEjx2kw3X2XBGwkXSho2Ygh0BSCqvUOG5fck=;
        b=W17u6B684W8uhr2KZKmoMh5qlHAQIaTeMKu/9jvHIqzzWjijM0UfZjlDR7rdvQ13l+
         ZSUKvOXwORpijsX8AxLlGzTmKzsUH65ma67ZBUeFCY9VGg5cpQkeX3czgEbPo5UuRKl6
         KlHzGicX0P1l7niWDQwRTBnFKtS2U74m/5UdHVOifAwKuGupjT4pZoKHNlanmPkvmLb1
         f45oqKB+i0wBKwO2vtfCC/8CU4N7rmgu46oJVIiaSsUiYtFha2SME+7kXtZiMUlTKMbO
         y7rljFNgTSkk2ToDFFhBrlr0gwL4gdckRyev89l2JkNmK8InRvayZhTyqasO9oPyVxl2
         Ot3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762902533; x=1763507333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fz6bHuZsEjx2kw3X2XBGwkXSho2Ygh0BSCqvUOG5fck=;
        b=uyBTEqzZFIaIocyx97ZJRNSVBOgqAtp38VOSuix+5KEDEA9Aks3Pbq5ToNDlCe/Smf
         cKvrPx9bqILH+Zg+yISOqe1hYAVWACCOuu+tIq2HSYuxLIs/Wx0P2kpTGSInRmJoWsXQ
         hxzZBHgfVRqX+FTTG/crPTFQWaOANOJ7o4GIbl9q2fPnvQyeBM85QkBqnIUDVWlY60x6
         h/aQOwpVc833MJAGL5YDZp2SD382nVOSbwgbQDrGMlU0SjzQNHIl/UN6uTT3JyhAoWPO
         A8V5FEyMg0T7nKTuI6TAuplozX2RiuleFg+8BccWwlTJNZgaPrwH9vMZ9JNAVAyFse78
         KMow==
X-Forwarded-Encrypted: i=1; AJvYcCXfYAIp3UU7NaKxIF5UHv4AxNLCvB9oMTqC1PvXHDyFNsDDlKlWHvYsBSae0cmwb/8Uow01F1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww453cf45Od5Pu5AzA/eVdYEYIXfdQaPD7BZ+F9D9AQwQYblCs
	NEfIcBFLHPd2O1p5nZQE+TXpf7qqyHSg6jwavHCRGTTpZG/t5UGRGiFBQVGJ/+6zSEAvgwUD/Vs
	Owei1UHBHNtGk14GuOiW9LNksoR67CdA=
X-Gm-Gg: ASbGncvuX8m9eb/xS9bSv6fyF5y01AmDYcJ83ExRjNTO6bWoINqqYWoue7NfrRpTqA3
	kNxuQ90QKpr/5q/hX1U+kMosKQPWOBFLiQBAITYGlKzzyGT5J3xaFoIHtpn9DZm41QjWWT82yY3
	F3SlQILXhUF6wI/S5gbzjjTLRTbAYwppqEtJw7A1aRFs44IAyAUT+PdH49sYHwq9wdw85l8qkm2
	BzPMpp0E7539PfCo1/FI681KgPNsUSZlEW6PkinGLTDckbXGNnDeW8YrL6QwZzKTvhFfA==
X-Google-Smtp-Source: AGHT+IHUtdHMv/cqBlF2IZX4Ed0+tDle0TRpoL7aKBRklYRm3SP4w4aEL9nl6pCo50SjADZ45Zk0Nfh2MxZS/Rv9fDI=
X-Received: by 2002:a05:6000:26ce:b0:429:8bfe:d842 with SMTP id
 ffacd0b85a97d-42b4bb8770cmr551863f8f.4.1762902533255; Tue, 11 Nov 2025
 15:08:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111-swap-fix-vma-uaf-v1-1-41c660e58562@tencent.com> <CAKEwX=OuhWBZWAKs0JYG6mLqe=NvyiD9L0dOEb=5ZJB-jfFi1Q@mail.gmail.com>
In-Reply-To: <CAKEwX=OuhWBZWAKs0JYG6mLqe=NvyiD9L0dOEb=5ZJB-jfFi1Q@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 11 Nov 2025 15:08:41 -0800
X-Gm-Features: AWmQ_bmzxwMvKHMB2MWGIM6T7AKaSNIwuKC2a3-Jg9SENE9orxavP6xnPq9AT8M
Message-ID: <CAKEwX=NKyXf=EEwszOm4BGm3WwHRu=38ThE7Wn=jsDUJGe=bKg@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: fix potential UAF issue for VMA readahead
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Huang Ying <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 11:48=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Tue, Nov 11, 2025 at 5:36=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Since commit 78524b05f1a3 ("mm, swap: avoid redundant swap device
> > pinning"), the common helper for allocating and preparing a folio in th=
e
> > swap cache layer no longer tries to get a swap device reference
> > internally, because all callers of __read_swap_cache_async are already
> > holding a swap entry reference. The repeated swap device pinning isn't
> > needed on the same swap device.
> >
> > Caller of VMA readahead is also holding a reference to the target
> > entry's swap device, but VMA readahead walks the page table, so it migh=
t
> > encounter swap entries from other devices, and call
> > __read_swap_cache_async on another device without holding a reference t=
o
> > it.
> >
> > So it is possible to cause a UAF when swapoff of device A raced with
> > swapin on device B, and VMA readahead tries to read swap entries from
> > device A. It's not easy to trigger, but in theory, it could cause real
> > issues.
> >
> > Make VMA readahead try to get the device reference first if the swap
> > device is a different one from the target entry.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 78524b05f1a3 ("mm, swap: avoid redundant swap device pinning")
> > Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> > Sending as a new patch instead of V2 because the approach is very
> > different.
> >
> > Previous patch:
> > https://lore.kernel.org/linux-mm/20251110-revert-78524b05f1a3-v1-1-8831=
3f2b9b20@tencent.com/
> > ---
> >  mm/swap_state.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 0cf9853a9232..da0481e163a4 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -745,6 +745,7 @@ static struct folio *swap_vma_readahead(swp_entry_t=
 targ_entry, gfp_t gfp_mask,
> >
> >         blk_start_plug(&plug);
> >         for (addr =3D start; addr < end; ilx++, addr +=3D PAGE_SIZE) {
> > +               struct swap_info_struct *si =3D NULL;
> >                 softleaf_t entry;
> >
> >                 if (!pte++) {
> > @@ -759,8 +760,19 @@ static struct folio *swap_vma_readahead(swp_entry_=
t targ_entry, gfp_t gfp_mask,
> >                         continue;
> >                 pte_unmap(pte);
> >                 pte =3D NULL;
> > +               /*
> > +                * Readahead entry may come from a device that we are n=
ot
> > +                * holding a reference to, try to grab a reference, or =
skip.
> > +                */
> > +               if (swp_type(entry) !=3D swp_type(targ_entry)) {
> > +                       si =3D get_swap_device(entry);
> > +                       if (!si)
> > +                               continue;
> > +               }
> >                 folio =3D __read_swap_cache_async(entry, gfp_mask, mpol=
, ilx,
> >                                                 &page_allocated, false)=
;
> > +               if (si)
> > +                       put_swap_device(si);
>
> Shouldn't we reset si to NULL here?
>
> Otherwise, suppose we're swapping in a readahead window. One of the
> swap entries in the window is on a different swapfile from the target
> entry. We look up and get a reference to that different swapfile,
> setting it to si.
>
> We do the swapping in work, then we release the recently acquired referen=
ce.
>
> In the next iteration in the for loop, we will still see si !=3D NULL,
> and we put_swap_device() it again, i.e double releasing reference to
> that swap device.
>
> Or am I missing something?

Nvm - Andrew pointed out to me that si was NULLED at the beginning of
the loop. Looks like I was blind :)

Anyway:
Acked-by: Nhat Pham <nphamcs@gmail.com>

