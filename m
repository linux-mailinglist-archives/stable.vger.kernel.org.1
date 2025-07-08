Return-Path: <stable+bounces-160515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC29AFCF54
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7803B7F6E
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CB92DAFCE;
	Tue,  8 Jul 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5ibg2Nd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317CF23BCEB
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988782; cv=none; b=uOLZmTQl06wKksLuy3RfglydqksLhaTWlihwuvb/KURwXMBh2SZnNvEM8okeQCRQSPLRHLcCCHBUw+Z2y/bH5lGJ9uR9TjpWGs1MR3qA2aSqMpQhXBWxwjOIBFNAP6bLrKRx8SUws+xFeWG00J9zKu0E373nBmebGbMsK7ZdKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988782; c=relaxed/simple;
	bh=UW7FNSgtzmx4PeXPEOkeqEcyq3nkgBjKwAlwHPL8Lmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BV/IwcI5CtudFyaluW/QP2QFUEffuue/QaQYD2KBsOdNLFGLb9VwQLMKrfPSgYcOVCMSKOvwvR0wkpqLl6Jc9vcFYlLmbVuMaVAC4I1ucffWUL3hMF9B2zXRdIyrT8mJF0NZaWiN5Bfz7pOQCnrVfkvZQySe0B3MXimxxJkh7Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X5ibg2Nd; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a58197794eso201711cf.1
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751988780; x=1752593580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9tZiU5eIxoOobBKXVYQ5QlOi0wUutX8iQEeH++Ok0M=;
        b=X5ibg2NdYqrSyz0xXesZHALBVkG+nQ2ZN2kTAbqRkbZGRlIjgbW0v+3l3X18gqNrhp
         gu4XA44BVy1UDhU94kE1jrTdUPi03XRiedxlBV04hGISew3FLnCubmTQuVtbX7f3PDon
         UJyib/5ZdNailwf7JozzTbd/z8vNEh2MRHP6Y+XzNQZL6URAgU+9q5ZNfoJiuZzdqMth
         va3qtamObHTrUrTXFnXjwktwtKE8Hc8SZVzE3UQdq4ef07/VYeVuh9lyz4OBRi3DUFxU
         uouLSopF75mErdqlWnKMhzmus2KHuSgI6630tjxYuFC7fJbzq6x4OEGXLPtmvyuMqWH7
         Vk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751988780; x=1752593580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9tZiU5eIxoOobBKXVYQ5QlOi0wUutX8iQEeH++Ok0M=;
        b=lGf1x6B4NPtDMY37MZNKOnM3+KpfwfQumf+zLUV1YCXzh3dYxR3guzvSg+voN9Rnyl
         k1pcbnUH+ft9VDOJgYVn7P7GYdAKfICujh+XjSAychYiGW5qScvS96Jz5lYeUZu5i7z+
         Tua8BCOqk4sW/negYfEXDBW85yBtSbx0C6XP6nQsRzrN/8WlKK7Yvpt1fBtzrUq/fIzb
         KxJCQfaAHrN0gI9BBse3U5g4PEK6PBpqCqSA9wqnP8ezpSmHk6yHp6uaGHGZubw6qKfe
         6srk6JPMBTQklyQcA8CAp5g54cy/G6AeD0PTXk+zAQuAN6vm2SC2yYzvywx6I142cPVd
         q+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeMxV2g66UGGKPGSldOjemTyU8YCWTMrmEsQsoa2boKbMxK3rQypOLbnfLCiUrx10ionl+d9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1mGK58MNFtT+gbsGMfvJ5nXvalbS3hMUvoDfVZQ+rli3RW6Zc
	8TEJuMt11ToAiWqiixVhHNF+bFlWSwnWKmKspogAB5ctxNV2AM+MCo58t40HAZ42a/yC3IZkuuj
	SZnCqQtYMDxuPMG0fOjoixBCMG9moX320cBJwlbwb
X-Gm-Gg: ASbGncvuFuscZxj+tQ95N7a7jssPOUeVKJLinvBnSkYrXzibvw5qNBSx4sK+Kn3g872
	KPirBlucTyk985iYjtIos3npzkOIU4m08H2YpnMgFWwm4G5ULqhBArp9TBGLCukpM13NXT2zsDk
	j8zIdMuRlif5C2WxDi3ikKEXUAFhTYRUuealW+q1gqXl5nnB6LaIeBVi0ebWFkviN71K89K/gXY
	g==
X-Google-Smtp-Source: AGHT+IG7fz++CeO2vs2J17V+ScGy3kEvPCUHnRVl6BVmyw4ZsfTyk9kTInu9aaiKvmmFZvE1OA0cyA+m/0vknmyY/rE=
X-Received: by 2002:a05:622a:d10:b0:4a9:7c7e:f2f9 with SMTP id
 d75a77b69052e-4a9d4818812mr2838841cf.17.1751988779418; Tue, 08 Jul 2025
 08:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630031958.1225651-1-sashal@kernel.org> <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
 <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com>
In-Reply-To: <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 8 Jul 2025 08:32:48 -0700
X-Gm-Features: Ac12FXzacz7_GNV6Umyb4v4clDu6vWsu0ttd-4YoNOndub-L61ooXKLtNoloNTs
Message-ID: <CAJuCfpEfkw5_FGOqz3PwN0PyC5u1RbKVAXWZDWGbhS=t3OsRzw@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration entries
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Sasha Levin <sashal@kernel.org>, peterx@redhat.com, 
	aarcange@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 8:10=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 01.07.25 02:57, Andrew Morton wrote:
> > On Sun, 29 Jun 2025 23:19:58 -0400 Sasha Levin <sashal@kernel.org> wrot=
e:
> >
> >> When handling non-swap entries in move_pages_pte(), the error handling
> >> for entries that are NOT migration entries fails to unmap the page tab=
le
> >> entries before jumping to the error handling label.
> >>
> >> This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE system=
s
> >> triggers a WARNING in kunmap_local_indexed() because the kmap stack is
> >> corrupted.
> >>
> >> Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
> >>    WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_indexed+0=
x178/0x17c
> >>    Call trace:
> >>      kunmap_local_indexed from move_pages+0x964/0x19f4
> >>      move_pages from userfaultfd_ioctl+0x129c/0x2144
> >>      userfaultfd_ioctl from sys_ioctl+0x558/0xd24
> >>
> >> The issue was introduced with the UFFDIO_MOVE feature but became more
> >> frequent with the addition of guard pages (commit 7c53dfbdb024 ("mm: a=
dd
> >> PTE_MARKER_GUARD PTE marker")) which made the non-migration entry code
> >> path more commonly executed during userfaultfd operations.
> >>
> >> Fix this by ensuring PTEs are properly unmapped in all non-swap entry
> >> paths before jumping to the error handling label, not just for migrati=
on
> >> entries.
> >
> > I don't get it.
> >
> >> --- a/mm/userfaultfd.c
> >> +++ b/mm/userfaultfd.c
> >> @@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct *mm=
, pmd_t *dst_pmd, pmd_t *src_pmd,
> >>
> >>              entry =3D pte_to_swp_entry(orig_src_pte);
> >>              if (non_swap_entry(entry)) {
> >> +                    pte_unmap(src_pte);
> >> +                    pte_unmap(dst_pte);
> >> +                    src_pte =3D dst_pte =3D NULL;
> >>                      if (is_migration_entry(entry)) {
> >> -                            pte_unmap(src_pte);
> >> -                            pte_unmap(dst_pte);
> >> -                            src_pte =3D dst_pte =3D NULL;
> >>                              migration_entry_wait(mm, src_pmd, src_add=
r);
> >>                              err =3D -EAGAIN;
> >> -                    } else
> >> +                    } else {
> >>                              err =3D -EFAULT;
> >> +                    }
> >>                      goto out;
> >
> > where we have
> >
> > out:
> >       ...
> >       if (dst_pte)
> >               pte_unmap(dst_pte);
> >       if (src_pte)
> >               pte_unmap(src_pte);
>
> AI slop?

Hmm, but there is even a Call trace in the report. I wonder if the
issue is somewhere else?

>
> --
> Cheers,
>
> David / dhildenb
>

