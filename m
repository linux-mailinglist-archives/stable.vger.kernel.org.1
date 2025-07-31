Return-Path: <stable+bounces-165671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C41CB17333
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 16:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF231884216
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AD314885D;
	Thu, 31 Jul 2025 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Urfy7wUB"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C42F24
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971848; cv=none; b=pIwYKDJhkzvNP/kueh+LIeW1Qdy6Bd+T7btR6Od9Y6umd5U06des1DwIDvGkAVYv+EuCtTcFceJQHIpRDYowLiUlZFUFT20tUFCl7Dm7ZBFBKp+cyfjKmiW1JAIV0Btw0ygRtz1y3+NF0qBI7yhEsT24uv6z9Jnfe4+sPRcBPSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971848; c=relaxed/simple;
	bh=2zcrs1xswIA1l7tTfNbMKxV75YXhdUEj7fyBQro4ue0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRbL2c+vZgKFFeb2xidFrNnmsaFvpVRRc++sYBNY0FnSSXSLeF+lMtHSghl5ht0nG3tMsqkrYWUZcx1+oTyCXX6H88MWvV4dSU0RL0QP2D+0E7RlT4qH8UjfckZBEjN/lKrSgRbCOkxJ0MdFBz/VTMLemkgvz3/FUrgV1qBMtww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Urfy7wUB; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso405651cf.0
        for <stable@vger.kernel.org>; Thu, 31 Jul 2025 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753971845; x=1754576645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaEPQlDrJ3xUdOaNniHVDx2+n9iGAETTjj86f/r2NQg=;
        b=Urfy7wUBRNXK1SXcj5S6UCg4eCQBIib9qFDFicziStrkJIaNnTbIatwjfIxDl7rze8
         /gQRbaJbd2FasYpTWASNdVOGBus2itigJ0+AUv+K6MnOPZdm4YFzWEUeRQE76Em9mFcb
         IP3N68UeED4Jo86QUQBSklnfmjmWTMh9+xxm1YMYSEWIud6lWHM+48jDbrHX1SnV9Wle
         x2zP+PxvaoMc+SsBfR+qaGyzCKAKajXPE7V4/diutie2WyUMx5dw8YDqzL0lyhXsXq6q
         7Q2+/SHhQawWaobWLjUr2cxXPcwsnSOrtYF6ZnJ4mMJrAnv443fFMJFLu+dsdp2qZ9kt
         YxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753971845; x=1754576645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaEPQlDrJ3xUdOaNniHVDx2+n9iGAETTjj86f/r2NQg=;
        b=D1K8/DEcGlLRt2Ffosh+CMzIztsXnwj7iInYbFgZCEMAXlSYU1VbZzI7xunJMr5tle
         gH1eioN0oJErM5bbWybA7c1MqSTvMAhX4sTKP/1VbWzgqArLebDVSHyQx9KGRgXt+Pc2
         RcNYHwzS4cfQmxEiwMHj0SrBJ2HIwgQfGghf72SVvQjqWBcvXfXfTWdqkC/tN3Ge5JOa
         VaNiRqVdqcXO5ZIAYfZ/jQzjFuQ7swlQsZVUK34c3MnzcAdKDd/KJtgjtrFryXKpccGi
         7zF89wobo5WEPDWzA+y0mhD1w1C5x4J0fsTm7rLN1wELzrufz4ETqU0sgVNhxIr+LWPH
         DUow==
X-Forwarded-Encrypted: i=1; AJvYcCVk4iKqYvf7tm1MFFqr7+i70V8OhKVxNnul3Rl1iHRz3ON8SINAt5Q2FbjHm1dpQxLKJ3RMtgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz894ENBPP84HAZ5E7M3e4ZlGVWvn4jdJYpoiimXG60+0t+ZYyr
	7A6S/0tcIcLnYYVK6dZV9/4ZMbzQEIYh5PewNRe7bLPyfl4Ebn9ugw/KfQIcdJX5dKKTIQg8xP9
	fhpl0D12XS/Uy14YgT6apz2yICGn7jmPVnG+/9nFj
X-Gm-Gg: ASbGncsUGa04UTBqC7e07EdzcnCDhRKuKTDlO3D4+uICBEt1oEeFNvd8l8bWPs30QFE
	lQFBAuS8BdNA01+5G1UnNF8L6wYVmT/On4iQJ4i7o7zPvWmBwKHqwgy6t/gSAENIm0XljUUESua
	7JR3sGLajqoLCfuZvjAeiO3aJtwti8e4n+ltursfN/XHpi7uoPWKkFQ/zDVxZZQUYWvpO/ptnl5
	EMEfCYEAzMn2kNGsjgL4qjeFkREA6eZGMAtqw==
X-Google-Smtp-Source: AGHT+IH+U7W48iIJwZXQgQOQ/vHHdTop5m5TFsH8fhOVp61+aOVc0QiEilGP1nFKe1yRkmhH6wUYo0aGLXGz+zulmMk=
X-Received: by 2002:ac8:7f14:0:b0:4a8:19d5:e9bb with SMTP id
 d75a77b69052e-4aef1c60a48mr2832411cf.13.1753971845017; Thu, 31 Jul 2025
 07:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730170733.3829267-1-surenb@google.com> <20250731015241.3576-1-hdanton@sina.com>
 <CA+EESO4mkiedqVMCV3fEnB-xeBMKyct1_WA=YDFVbqSGU4F+6A@mail.gmail.com>
In-Reply-To: <CA+EESO4mkiedqVMCV3fEnB-xeBMKyct1_WA=YDFVbqSGU4F+6A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 31 Jul 2025 07:23:54 -0700
X-Gm-Features: Ac12FXy9AeUURppfkgynMqQjKLG3IYh8hvItem-Sdjqlh2M8Jm5M7zE6NTKVTE4
Message-ID: <CAJuCfpGzazWVYzc9XXh+xTP9R7cMffiP2P4G5OJTQ0-Ji4xFEQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles a
 THP hole
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Hillf Danton <hdanton@sina.com>, akpm@linux-foundation.org, peterx@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 12:35=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
>
> On Wed, Jul 30, 2025 at 6:58=E2=80=AFPM Hillf Danton <hdanton@sina.com> w=
rote:
> >
> > #syz test
> >
> > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> > encounters a non-present THP, it fails to properly recognize an unmappe=
d
> > hole and tries to access a non-existent folio, resulting in
> > a crash. Add a check to skip non-present THPs.
> >
> Thanks Suren for promptly addressing this issue.
>
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@go=
ogle.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  mm/userfaultfd.c | 38 +++++++++++++++++++++++---------------
> >  1 file changed, 23 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index cbed91b09640..60be8080ddd0 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1818,27 +1818,35 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx,=
 unsigned long dst_start,
> >
> >                 ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
> >                 if (ptl) {
> > -                       /* Check if we can move the pmd without splitti=
ng it. */
> > -                       if (move_splits_huge_pmd(dst_addr, src_addr, sr=
c_start + len) ||
> > -                           !pmd_none(dst_pmdval)) {
> > -                               struct folio *folio =3D pmd_folio(*src_=
pmd);
> > +                       if (pmd_present(*src_pmd) || is_pmd_migration_e=
ntry(*src_pmd)) {
> > +                               /* Check if we can move the pmd without=
 splitting it. */
> > +                               if (move_splits_huge_pmd(dst_addr, src_=
addr, src_start + len) ||
> > +                                   !pmd_none(dst_pmdval)) {
> > +                                       if (pmd_present(*src_pmd)) {
> > +                                               struct folio *folio =3D=
 pmd_folio(*src_pmd);
> > +
> > +                                               if (!folio || (!is_huge=
_zero_folio(folio) &&
> > +                                                              !PageAno=
nExclusive(&folio->page))) {
> > +                                                       spin_unlock(ptl=
);
> > +                                                       err =3D -EBUSY;
> > +                                                       break;
> > +                                               }
> > +                                       }
> >
> > -                               if (!folio || (!is_huge_zero_folio(foli=
o) &&
> > -                                              !PageAnonExclusive(&foli=
o->page))) {
> >                                         spin_unlock(ptl);
> > -                                       err =3D -EBUSY;
> > -                                       break;
> > +                                       split_huge_pmd(src_vma, src_pmd=
, src_addr);
> > +                                       /* The folio will be split by m=
ove_pages_pte() */
> > +                                       continue;
> >                                 }
> >
> > +                               err =3D move_pages_huge_pmd(mm, dst_pmd=
, src_pmd,
> > +                                                         dst_pmdval, d=
st_vma, src_vma,
> > +                                                         dst_addr, src=
_addr);
> > +                       } else {
> > +                               /* nothing to do to move a hole */
> >                                 spin_unlock(ptl);
> > -                               split_huge_pmd(src_vma, src_pmd, src_ad=
dr);
> > -                               /* The folio will be split by move_page=
s_pte() */
> > -                               continue;
> > +                               err =3D 0;
> I think we need to act here depending on whether
> UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is set or not.

Hmm, yes, I think you are right. I thought we would bail out earlier
if !UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES but I think it's possible to get
here if the PMD was established earlier but then unmapped.

>
>            err =3D (mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES) ? 0 : -ENOEN=
T;
>
> Also, IMO, the step_size in this case should be the minimum of
> remaining length and HPAGE_PMD_SIZE.

Ah, ok. I think it matters only for incrementing "moved" correctly
because otherwise the functionality is the same.

> >                         }
> > -
> > -                       err =3D move_pages_huge_pmd(mm, dst_pmd, src_pm=
d,
> > -                                                 dst_pmdval, dst_vma, =
src_vma,
> > -                                                 dst_addr, src_addr);
> >                         step_size =3D HPAGE_PMD_SIZE;
> >                 } else {
> >                         if (pmd_none(*src_pmd)) {
> I have a related question/doubt: why do we populate the page-table
> hierarchy on the src side [1] (and then also at line 1857) when a hole
> is found? IMHO, it shouldn't be needed. Depending on whether
> UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is set or not, it should either
> return -ENOENT, or continue past the hole. Please correct me if I'm
> wrong.

I thought about that too. I think it's done to simplify the logic.
This way we can treat the cases when PMD was never allocated and when
PMD was allocated, mapped and then unmapped the same way.

>
> [1] https://elixir.bootlin.com/linux/v6.16/source/mm/userfaultfd.c#L1797
>
> >
> > base-commit: 01da54f10fddf3b01c5a3b80f6b16bbad390c302
> > --
> > 2.50.1.552.g942d659e1b-goog

