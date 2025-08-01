Return-Path: <stable+bounces-165751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D6BB184B0
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 17:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB255A13C1
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA25267B02;
	Fri,  1 Aug 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ONOnTNS"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7377123535C
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061130; cv=none; b=dSqzp823xEV3dg3iJO6uacJhwB4SYK/LyWR3HMRWhahv49TZLSd7Z31NX8ncLaoIL/uEFLdDya8ehwUxHv2rT9KOcCiS4p/Wg7VWAb+NIrIuefXHrXn9LKKE21NQkb7yIgGAgjS9L8qW16fD8xKQJjUkFXy7jvkV5SMvgK5Bd9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061130; c=relaxed/simple;
	bh=fxFG5jnZ4dMkX4nyXGKB5dGsWGN4AxI6xsEXNzeIaLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSZHUlLTQvG/zZcuIYjXkHlb9abBiw5ojs3Wh/WXuaYo3day3u4ljT5+OfuOyof2zLzUmFFxl6DZ0EqMTbqk/y61uBUa+IEeTRX4XuwFar+Q0pJtkX55WSXhPFAGm1hVPrQeKJKxCMcYtXOHAYkKIGroCkoDtX2HduXUuBNZh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ONOnTNS; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab86a29c98so441431cf.0
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 08:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754061127; x=1754665927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoCvDf2STWqjlVzd+8uazfHv+yAfec07kh2ZhHKg+3g=;
        b=3ONOnTNSNDLDqYzXxHbxbKN0GAlOnk1xy6zYNVVrOGB9TOoWGha6lcCm/sMwBT70rH
         DGZq41cI1l6uQHUu9HeHIuRFJxgkI1n4lt9wTo3gmmW7+cPxFcTLR53/edDu337duVZ+
         fAQdbyAJkf7AtJsBY8/M5TE4DaabSV6iJ5ZZtVf9CIpIhQLLQfF/qxo3HOvouFxbPzTm
         pC2Kf+s056NOfEUow1qZLuAgpImtwcrlkPYnubKyqL4RC4MNYYROsjckrjDFirn5UQcD
         7QD+ib+jHwpJD4RgFc+REQMUqVSVOioiY+ykOglp7KjdGd+Rdxlx9WRWCZLNtFqUG6Yw
         dqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754061127; x=1754665927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoCvDf2STWqjlVzd+8uazfHv+yAfec07kh2ZhHKg+3g=;
        b=AbXb/L2XIR0v2rLDOYWjlGmMbb1gWdAKn3p2vADLLYZttLxsUnWkeBl0FJbOXev81a
         /Bdo63H/PQXEBacHQxg8VIDr1jjajd/hgPPC8DiJCQGukf3bAXeg+67sOb/jCSN8Kg3Q
         k5RVi61qnjrN0tA6MdUklr0rmH3Jxm3NVt61V1x3+33Fmiu1vGpKIqGq/ngwS83RhEpM
         S/B+pqY3QPOMeFSIscxvqDowaL5LNFEcNNpdfuHAnTe2R9SGFjWxOCRa7+9e9nNnvYm8
         emzrmTyZq5KgrMDFJWuqcPfTSAX8KAIO9UxC3Mw4daNjUFxvkxvWIomn/9Nso3Gf9aYG
         0usQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYqV3pkCNVNpViwNg2tWjnhwTu+hAMU7WFSPr6upHv6cWHRgkudO1aDOfLE8H+xjgkagL0g0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0KLG9rtUl23L+sc2qfDrtCt+qJxf8yQk8LPMxnNbM1Kd6X2rP
	6hFXki2S7jPxlxltdfwbmyjv9IQ0+La/AxTmlZc+E6oaZmYw8U3bbQoHZlNvucEVnukClwKinsm
	ev+2jTP4jeMmKX0E1zCpNxyFlHdkxwkYUFWwURRva
X-Gm-Gg: ASbGncs0P2ppptz0Clm/G5ZBt8pXsXNSauWVipmlHLXSJPCTa1WmxkVu/L2bDoyimCA
	Kr4zmcI+v7Cnxkh43LXQvaZPq3mYjjCaNVugyN8vMvr5oge8vWRYDkyHoAJ/q2Uk2qxWpyei1Ep
	ntW1QyJl+5fCH4Lq5hFnkdIMtyEEjN7Cw17P3pfsuWFfd3IGo4mFqensCtdMvCndfyy5JCAtg/1
	YaZGSPiDQFS04f1u7C3B84D1+XYRQJ9iwlbdw==
X-Google-Smtp-Source: AGHT+IEcXXFNQJXhQXaLDDs9kA4bqVnd84TK3sznmDH2mazS4z6rzXjrqdGlkijgDyhkzMQKRWnLp921znoYXPeBhuo=
X-Received: by 2002:a05:622a:86:b0:4ae:e478:268d with SMTP id
 d75a77b69052e-4af0079bc5cmr4436381cf.5.1754061126793; Fri, 01 Aug 2025
 08:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731154442.319568-1-surenb@google.com> <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
In-Reply-To: <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 1 Aug 2025 08:11:54 -0700
X-Gm-Features: Ac12FXwHTk6dY4NJRJgP0bh8zoHGQ_RejUiRmgYpnRzf77eWrvYI8LNs-_ARMGI
Message-ID: <CAJuCfpHkxe1Sb3jL6hK02+zQVFw7yOYte3BR5XDnHRvx7aTjNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 7:21=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 31.07.25 17:44, Suren Baghdasaryan wrote:
>
> Hi!
>
> Did you mean in you patch description:
>
> "userfaultfd: fix a crash in UFFDIO_MOVE with some non-present PMDs"
>
> Talking about THP holes is very very confusing.

Hi David,
Yes, "hole" is not a technical term, so I'll change as you suggested.

>
> > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> > encounters a non-present THP, it fails to properly recognize an unmappe=
d
>
> You mean a "non-present PMD that is not a migration entry".

Yes, will fix.


>
> > hole and tries to access a non-existent folio, resulting in
> > a crash. Add a check to skip non-present THPs.
>
> That makes sense. The code we have after this patch is rather
> complicated and hard to read.
>
> >
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@go=
ogle.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: stable@vger.kernel.org
> > ---
> > Changes since v1 [1]
> > - Fixed step size calculation, per Lokesh Gidra
> > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokesh =
Gidra
> >
> > [1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@google.=
com/
> >
> >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
> >   1 file changed, 29 insertions(+), 16 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index cbed91b09640..b5af31c22731 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx,=
 unsigned long dst_start,
> >
> >               ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
> >               if (ptl) {
> > -                     /* Check if we can move the pmd without splitting=
 it. */
> > -                     if (move_splits_huge_pmd(dst_addr, src_addr, src_=
start + len) ||
> > -                         !pmd_none(dst_pmdval)) {
> > -                             struct folio *folio =3D pmd_folio(*src_pm=
d);
> > +                     if (pmd_present(*src_pmd) || is_pmd_migration_ent=
ry(*src_pmd)) {
> > +                             /* Check if we can move the pmd without s=
plitting it. */
> > +                             if (move_splits_huge_pmd(dst_addr, src_ad=
dr, src_start + len) ||
> > +                                 !pmd_none(dst_pmdval)) {
> > +                                     if (pmd_present(*src_pmd)) {
> > +                                             struct folio *folio =3D p=
md_folio(*src_pmd);
> > +
> > +                                             if (!folio || (!is_huge_z=
ero_folio(folio) &&
> > +                                                            !PageAnonE=
xclusive(&folio->page))) {
> > +                                                     spin_unlock(ptl);
> > +                                                     err =3D -EBUSY;
> > +                                                     break;
> > +                                             }
> > +                                     }
>
> ... in particular that. Is there some way to make this code simpler /
> easier to read? Like moving that whole last folio-check thingy into a
> helper?

Do you mean refactor the section after "if (ptf)" into a separate function?
I was trying to minimize the code changes to simplify backporting but
since additional indentation changes this whole block, I think it does
not make much difference. Please let me know if I understood you
correctly and I'll move the code into a separate function.
Thanks,
Suren.

>
>
> --
> Cheers,
>
> David / dhildenb
>

