Return-Path: <stable+bounces-166731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E95DB1CA4D
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 19:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595417A4539
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 17:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00E129A9E1;
	Wed,  6 Aug 2025 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hv12eHyQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6BA299AB1
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500184; cv=none; b=TcgdZcVyqyegT7l6+x83WOva3WwnKQYBqmn984MX+F+XqyieO4/JbtmAFgICRnPG4psp6eWPxRL0CMzS0gQrrnhMo7UjXSnZvu5CopQC94n5XMe/Azemq9sny1VZux0RsmhGMfmKQxZ5U53efigO2H+96s9qAdp8emA4dtSx5ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500184; c=relaxed/simple;
	bh=DHc787VAHHzOpB3Zm+nvbCGuSohWxNq5LBg0ZI96YDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfiKfhQCcf6IdcLBVPKQDCRHTQr/BJtSh3yQYP4QA5rYrO7QyUhG9nxNK2f5Y2GzpXcKkeKstyqwyLLbar1uFY1pKfQlp5G0UPjFzm8LlpZWK+AdUjLd7ejLaVI9klNdpKyNOxoD8c3SwfJoP/ywWKxDoqqVxRzST68Urw037T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hv12eHyQ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b099118fedso20051cf.1
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 10:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754500182; x=1755104982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxfvgCasWuA+gJKWPbYYwoEtVkgTH2JoUrawg5d9Ttc=;
        b=Hv12eHyQu4f3JRb/hRiVhvY7eXyvQ2JFdruBlCkz4CHyvBImFT48ArIcrjVX4xu63F
         0+BI17qSEbnO+qr4Hw2Nj6Cn+ywE4H4U4vShmoWTs/T69azPmIO0HYdat++HKetsfQCf
         vzY1jgyuBLm9rgT/nOC32E/6lhoS0+jZGkzkd73TCV9yQFz2AWj4fPUrSwYiExJMcwab
         RNNVuDc/KRktZ6YsAw6pI+y7OwRZIsE6blsaC/GZjFSHOhuSWLHzPWmOMBZxnbkCgXdP
         ipREymbnjKYbY61qNsf9xgomiOziQthmGkvJsbKuutVyyrbBGNA2l2Gt9nhFsEANGZ+l
         CWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754500182; x=1755104982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxfvgCasWuA+gJKWPbYYwoEtVkgTH2JoUrawg5d9Ttc=;
        b=RG9V10HivM3I2jiWNb5T52T7xLZw85QpelFjZGx2PQRSva0aTed3tAQ+z+nWg6e7MW
         deYMWbWnEno79Nzf1LhbdXydbNYLIPPJ6EUOiraFefXlBUofTrACdjwkHpICneaDGd5g
         1YtHgdTvfxPMV1260Y7ZI24anvJO/bhtIBD/tAU/LgVqjnuaQ06fonvGGBa9+MsOjQX/
         8tKzLSVrlAH4xTH37ZAvXkpFJK8UrmzlTT5URi/h2MI1e+uDbtYqX/aitbnKev369P+g
         5CiSUfkcss3KN8ZFn+FlYgJAMOCjC8mDCyby7z9b62hm0PkYzOzLeOT1lfSXK93qLE+Y
         H05Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQrEL771tCAxG7nCzVlnXZ/adtze+aQ4jewCNB6jn8TecgJNW8Tk36BkUHBI3T/i1ORY2jsxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA0Sd6VMvqIUOHbDLTitCx2u3QTY5xe43XGQA5ESXZH3R3p5JB
	5L4FZgB5gTBhnfakLb5HVvK34hmJdNMoAHqdIMaN2dikWiMnMH0qP6pJK2QZcS7yI8BdORUx90J
	U8xGyPMFoHr4t6lfDiUxkYmqZtXImIiF7PNh0GHpB
X-Gm-Gg: ASbGncvl92KDSDjOVjhfQYHt2HvP9k+lSG2J33QhCqXGHJwm+oPSIx9KBs1lGdbxaGx
	MxFzyyovqrPL3yz8JGrMhEHvXGIhCKw17zgbK+76v8du7rtmkZYKpZwt4rQFj3j8yIZCkTeIm78
	171jn6248wRyYNmv9beNoZuxH7FKJKIHLAvtwZauIlms/Ug1W5b2gTVnU0GuF1gR7iFtPuZ4h0y
	ZferlbqQmys8bOd2cfGf3p+k08t66tHYGj+s45YkcMN4+gS
X-Google-Smtp-Source: AGHT+IEMhHGLxiZthvv92hddLeh6VUsA2wNqyUMxu2FRa4/Ps+p8BXpPEcOIySKHKsvBGcHbKtUDuUxzy9tvSikqDlk=
X-Received: by 2002:a05:622a:8319:b0:4b0:9c14:2fec with SMTP id
 d75a77b69052e-4b09c143728mr2217691cf.8.1754500181246; Wed, 06 Aug 2025
 10:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806154015.769024-1-surenb@google.com> <aJOJI-YZ0TTxEzV9@x1.local>
In-Reply-To: <aJOJI-YZ0TTxEzV9@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 6 Aug 2025 10:09:30 -0700
X-Gm-Features: Ac12FXyt05U3kXqXIXEA0tOR0TWPYJFTgr2w2Z1A_F-UmeFYAUN8QHXxx2B-yHA
Message-ID: <CAJuCfpGGGJfnvzzdhOEwsXRWPm1nJoPcm2FcrYnkcJtc9W96gA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] userfaultfd: fix a crash in UFFDIO_MOVE with some
 non-present PMDs
To: Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, david@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 9:56=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Aug 06, 2025 at 08:40:15AM -0700, Suren Baghdasaryan wrote:
> > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
>
> The migration entry can appear with/without ALLOW_SRC_HOLES, right?  Mayb=
e
> drop this line?

Yes, you are right. I'll update.

>
> If we need another repost, the subject can further be tailored to mention
> migration entry too rather than non-present.  IMHO that's clearer on
> explaining the issue this patch is fixing (e.g. a valid transhuge THP can
> also have present bit cleared).
>
> > encounters a non-present PMD (migration entry), it proceeds with folio
> > access even though the folio is not present. Add the missing check and
>
> IMHO "... even though folio is not present" is pretty vague.  Maybe
> "... even though it's a swap entry"?  Fundamentally it's because of the
> different layouts of normal THP v.s. a swap entry, hence pmd_folio() shou=
ld
> not be used on top of swap entries.

Well, technically a migration entry is a non_swap_entry(), so calling
migration entries "swap entries" is confusing to me. Any better
wording we can use or do you think that's ok?

>
> > let split_huge_pmd() handle migration entries.
> >
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@go=
ogle.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: stable@vger.kernel.org
> > ---
> > Changes since v2 [1]
> > - Updated the title and changelog, per David Hildenbrand
> > - Removed extra checks for non-present not-migration PMD entries,
> > per Peter Xu
> >
> > [1] https://lore.kernel.org/all/20250731154442.319568-1-surenb@google.c=
om/
> >
> >  mm/userfaultfd.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 5431c9dd7fd7..116481606be8 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1826,13 +1826,16 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx,=
 unsigned long dst_start,
> >                       /* Check if we can move the pmd without splitting=
 it. */
> >                       if (move_splits_huge_pmd(dst_addr, src_addr, src_=
start + len) ||
> >                           !pmd_none(dst_pmdval)) {
> > -                             struct folio *folio =3D pmd_folio(*src_pm=
d);
> > -
> > -                             if (!folio || (!is_huge_zero_folio(folio)=
 &&
> > -                                            !PageAnonExclusive(&folio-=
>page))) {
> > -                                     spin_unlock(ptl);
> > -                                     err =3D -EBUSY;
> > -                                     break;
> > +                             /* Can be a migration entry */
> > +                             if (pmd_present(*src_pmd)) {
> > +                                     struct folio *folio =3D pmd_folio=
(*src_pmd);
> > +
> > +                                     if (!folio || (!is_huge_zero_foli=
o(folio) &&
> > +                                                    !PageAnonExclusive=
(&folio->page))) {
> > +                                             spin_unlock(ptl);
> > +                                             err =3D -EBUSY;
> > +                                             break;
> > +                                     }
> >                               }
>
> The change itself looks all correct, thanks.  If you agree with above
> commit message / subject updates, feel free to take this after some
> amendment of the commit message:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> >
> >                               spin_unlock(ptl);
> >
> > base-commit: 8e7e0c6d09502e44aa7a8fce0821e042a6ec03d1
> > --
> > 2.50.1.565.gc32cd1483b-goog
> >
>
> --
> Peter Xu
>

