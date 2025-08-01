Return-Path: <stable+bounces-165771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1E6B187C0
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 21:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D6E178E0F
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 19:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89113205AA1;
	Fri,  1 Aug 2025 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RPUnxaTD"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F811FBC92
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076618; cv=none; b=X8Y/V0gTn0CCLdtXqXz9ktOCAikjypsNpzxSqWdmGr4IgF774Dk1eEbPD8B3SskOmcmRAmB0HcTHZZS59B0aPZG3cKeX9ibhMK0dzLv/VoB8tEie94nNJatxUGXjHrYTR9qwpHq0YfofOqdTyjcN8PsIRKQlaIMwgYof1g4W1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076618; c=relaxed/simple;
	bh=mfanK206pIXizsL2pLcY7vv9XivfIfMYTdb6jhjHWyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGQVxjnh4nDcKTvARbVwOcHR7bT1rLef+RKBRlLzCpqvB+lCLBGC9ZcrAMYpu83Xn+Y590oDpFW34fewIC3xGY/Db54trP0kBUkirr/xOKlemd11mhXrpcnYM3tOVLwpSOjknBuplkK36jdDzv/TLdphkA+xazXtCDc1iqZmBls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RPUnxaTD; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ab86a29c98so57691cf.0
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754076615; x=1754681415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twDNEhjIuV3P8FWkQWfYnM6bEXR/NJ1nyF/4WQ2JH/0=;
        b=RPUnxaTDgBXNkEZSjTQnRwLIRsOr55Va2xyZfHU6enzDy23hfQMsiotuKBCHQVqZIm
         lf/myJtHULJ5umH/QuVey8EZ5vHSRtOTahRjIVpGa2ssyJq+EWYx7b55acDX611weLhR
         /3q1Su1Hl/G+f27jPzVHrnVzS+qL2hGyueBZsSOGFrsfN7DNJLk7URO4OFPaKIoodVav
         bM1ZsE9FD8aFD+nUZ09FzYFCNavjyud9yt/PWRAqPmUJJDtT44sYxpf696OIipf3/mVl
         ppumpTCTfrhjU+brpkrTl6BT2t6jr3Rlzu4QTbYaeCHYmKGlIsF5x4S0fp/2Wu5YLTaQ
         BXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754076615; x=1754681415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twDNEhjIuV3P8FWkQWfYnM6bEXR/NJ1nyF/4WQ2JH/0=;
        b=XBmgHgy6SIymDaRuWzZOkz4GEtL0wEsgaBVM8N8AeW6hiDcdDDBlMz4jJ1wqOggLm7
         2Wp8igDPYyzEGHlv2WmYaZSjceJD9vvJ5lAK8h+80iPFZgW0rF2b8DlmnhtNQdEoImZL
         CTGZCPGRpU4JzxpRCao1IbuL1xUvmfPGAIsXiAV/J7pHZhN2cGCkbB4HcGL3VYCS2S7N
         gz2/mgpG0yYdBvoVO9DH3x5+vXuTQyhWDkS5qX5aAGno9+hqQ75f519759RGCuNxBEb6
         ACileqwCarIekrDnq5Tkuw0uS63Clov+qgpprqMQKoms4LTb1EbOWAnZT6NZBAvjDZvu
         dJAw==
X-Forwarded-Encrypted: i=1; AJvYcCX4uC+BaoGbysgI+XBRTME1rQQOOgridBihVwBiILVM5eEYKLUObq0SgwNduZy1OGhGwHMn74M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZk7q4B8ygAdySequoQ32K/MIAxy9HyIyYYJ1Iqtfpsz0DerBL
	KtKRA0uho/oUvCsZQuTQRxtxQBrygL43jnJfTqoOoFCzzVVYoKfgjlW83plZv6G1SNF+Hp6UhJs
	qsfULfW/edpX6+es9YLN2R8lo5Je0PgD4u0Kz9k1OgVy3CzGV8RvTrY5qXh8=
X-Gm-Gg: ASbGncsBAlhBge9u2N4jgvydLMsKDwsYILkvG2Y7fU/Jospc0a+bTAD8YaBUBefkKXu
	f0ylvVNTh8dNud4tKqFz9ExaElBZ9Xlb75oXYFmr0Aw/rSNBH30B3QqAg0WMLTWPK7oDOOl/+CZ
	vWTm5mvDhIZ5y6w9tyftiEfdna0HesEO2Oh1jPHC5U/Dto62DKEUzQyy+YpB152ct4kZnRkozCI
	IT6ZuoHHk2nlZ5EVp+S1/Q0IS6mh3/h11g=
X-Google-Smtp-Source: AGHT+IGJz6lFXVxVdLxtOYGPbfOs+p+cwbfDc9Hr4tq8znJjmVLXS2URnxtlM7GxjpvFbqbJihK6yqO34DNYKLHSJ4U=
X-Received: by 2002:ac8:5d49:0:b0:4ae:e478:268d with SMTP id
 d75a77b69052e-4af13199dd2mr477631cf.5.1754076614621; Fri, 01 Aug 2025
 12:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731154442.319568-1-surenb@google.com> <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
 <aIzMGlrR1SL5Y_Gp@x1.local> <CAJuCfpEqOUj8VPybstQjoJvCzyZtG6Q5Vr4WT0Lx_r3LFVS7og@mail.gmail.com>
 <aIzp6WqdzhomPhhf@x1.local> <CAJuCfpGWLnu+r2wvY2Egy2ESPD=tAVvfVvAKXUv1b+Z0hweeJg@mail.gmail.com>
 <aIz1xrzBc2Spa2OH@x1.local> <CAJuCfpFJGaDaFyNLa3JsVh19NWLGNGo1ebC_ijGTgPGNyfUFig@mail.gmail.com>
 <aI0Ffc9WXeU2X71O@x1.local>
In-Reply-To: <aI0Ffc9WXeU2X71O@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 1 Aug 2025 19:30:02 +0000
X-Gm-Features: Ac12FXwqbmtzOOF0OpEWd-6TjRB4swEi2Z6oN7xIU_JaZp9vQNVpQvwwBAnRsUI
Message-ID: <CAJuCfpFSY3fDH36dabS=nGzasZJ6FtQ_jv79eFWVZrEWRMMTiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 6:21=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Aug 01, 2025 at 05:45:10PM +0000, Suren Baghdasaryan wrote:
> > On Fri, Aug 1, 2025 at 5:13=E2=80=AFPM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > On Fri, Aug 01, 2025 at 09:41:31AM -0700, Suren Baghdasaryan wrote:
> > > > On Fri, Aug 1, 2025 at 9:23=E2=80=AFAM Peter Xu <peterx@redhat.com>=
 wrote:
> > > > >
> > > > > On Fri, Aug 01, 2025 at 08:28:38AM -0700, Suren Baghdasaryan wrot=
e:
> > > > > > On Fri, Aug 1, 2025 at 7:16=E2=80=AFAM Peter Xu <peterx@redhat.=
com> wrote:
> > > > > > >
> > > > > > > On Fri, Aug 01, 2025 at 09:21:30AM +0200, David Hildenbrand w=
rote:
> > > > > > > > On 31.07.25 17:44, Suren Baghdasaryan wrote:
> > > > > > > >
> > > > > > > > Hi!
> > > > > > > >
> > > > > > > > Did you mean in you patch description:
> > > > > > > >
> > > > > > > > "userfaultfd: fix a crash in UFFDIO_MOVE with some non-pres=
ent PMDs"
> > > > > > > >
> > > > > > > > Talking about THP holes is very very confusing.
> > > > > > > >
> > > > > > > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_=
HOLES and it
> > > > > > > > > encounters a non-present THP, it fails to properly recogn=
ize an unmapped
> > > > > > > >
> > > > > > > > You mean a "non-present PMD that is not a migration entry".
> > > > > > > >
> > > > > > > > > hole and tries to access a non-existent folio, resulting =
in
> > > > > > > > > a crash. Add a check to skip non-present THPs.
> > > > > > > >
> > > > > > > > That makes sense. The code we have after this patch is rath=
er complicated
> > > > > > > > and hard to read.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > > > > > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspo=
tmail.com
> > > > > > > > > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693=
ce.0050.GAE@google.com/
> > > > > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > ---
> > > > > > > > > Changes since v1 [1]
> > > > > > > > > - Fixed step size calculation, per Lokesh Gidra
> > > > > > > > > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLE=
S, per Lokesh Gidra
> > > > > > > > >
> > > > > > > > > [1] https://lore.kernel.org/all/20250730170733.3829267-1-=
surenb@google.com/
> > > > > > > > >
> > > > > > > > >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----=
------------
> > > > > > > > >   1 file changed, 29 insertions(+), 16 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > > > > > index cbed91b09640..b5af31c22731 100644
> > > > > > > > > --- a/mm/userfaultfd.c
> > > > > > > > > +++ b/mm/userfaultfd.c
> > > > > > > > > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfau=
ltfd_ctx *ctx, unsigned long dst_start,
> > > > > > > > >             ptl =3D pmd_trans_huge_lock(src_pmd, src_vma)=
;
> > > > > > > > >             if (ptl) {
> > > > > > > > > -                   /* Check if we can move the pmd witho=
ut splitting it. */
> > > > > > > > > -                   if (move_splits_huge_pmd(dst_addr, sr=
c_addr, src_start + len) ||
> > > > > > > > > -                       !pmd_none(dst_pmdval)) {
> > > > > > > > > -                           struct folio *folio =3D pmd_f=
olio(*src_pmd);
> > > > > > > > > +                   if (pmd_present(*src_pmd) || is_pmd_m=
igration_entry(*src_pmd)) {
> > > > > > >
> > > > > > > [1]
> > > > > > >
> > > > > > > > > +                           /* Check if we can move the p=
md without splitting it. */
> > > > > > > > > +                           if (move_splits_huge_pmd(dst_=
addr, src_addr, src_start + len) ||
> > > > > > > > > +                               !pmd_none(dst_pmdval)) {
> > > > > > > > > +                                   if (pmd_present(*src_=
pmd)) {
> > > > >
> > > > > [2]
> > > > >
> > > > > > > > > +                                           struct folio =
*folio =3D pmd_folio(*src_pmd);
> > > > >
> > > > > [3]
> > > > >
> > > > > > > > > +
> > > > > > > > > +                                           if (!folio ||=
 (!is_huge_zero_folio(folio) &&
> > > > > > > > > +                                                        =
  !PageAnonExclusive(&folio->page))) {
> > > > > > > > > +                                                   spin_=
unlock(ptl);
> > > > > > > > > +                                                   err =
=3D -EBUSY;
> > > > > > > > > +                                                   break=
;
> > > > > > > > > +                                           }
> > > > > > > > > +                                   }
> > > > > > > >
> > > > > > > > ... in particular that. Is there some way to make this code=
 simpler / easier
> > > > > > > > to read? Like moving that whole last folio-check thingy int=
o a helper?
> > > > > > >
> > > > > > > One question might be relevant is, whether the check above [1=
] can be
> > > > > > > dropped.
> > > > > > >
> > > > > > > The thing is __pmd_trans_huge_lock() does double check the pm=
d to be !none
> > > > > > > before returning the ptl.  I didn't follow closely on the rec=
ent changes on
> > > > > > > mm side on possible new pmd swap entries, if migration is the=
 only possible
> > > > > > > one then it looks like [1] can be avoided.
> > > > > >
> > > > > > Hi Peter,
> > > > > > is_swap_pmd() check in __pmd_trans_huge_lock() allows for (!pmd=
_none()
> > > > > > && !pmd_present()) PMD to pass and that's when this crash is hi=
t.
> > > > >
> > > > > First for all, thanks for looking into the issue with Lokesh; I a=
m still
> > > > > catching up with emails after taking weeks off.
> > > > >
> > > > > I didn't yet read into the syzbot report, but I thought the bug w=
as about
> > > > > referencing the folio on top of a swap entry after reading your c=
urrent
> > > > > patch, which has:
> > > > >
> > > > >         if (move_splits_huge_pmd(dst_addr, src_addr, src_start + =
len) ||
> > > > >             !pmd_none(dst_pmdval)) {
> > > > >                 struct folio *folio =3D pmd_folio(*src_pmd); <---=
-
> > > > >
> > > > > Here looks like *src_pmd can be a migration entry. Is my understa=
nding
> > > > > correct?
> > > >
> > > > Correct.
> > > >
> > > > >
> > > > > > If we drop the check at [1] then the path that takes us to
> > > > >
> > > > > If my above understanding is correct, IMHO it should be [2] above=
 that
> > > > > makes sure the reference won't happen on a swap entry, not necess=
arily [1]?
> > > >
> > > > Yes, in case of migration entry this is what protects us.
> > > >
> > > > >
> > > > > > split_huge_pmd() will bail out inside split_huge_pmd_locked() w=
ith no
> > > > > > indication that split did not happen. Afterwards we will retry
> > > > >
> > > > > So we're talking about the case where it's a swap pmd entry, righ=
t?
> > > >
> > > > Hmm, my understanding is that it's being treated as a swap entry bu=
t
> > > > in reality is not. I thought THPs are always split before they get
> > > > swapped, no?
> > >
> > > Yes they should be split, afaiu.
> > >
> > > >
> > > > > Could you elaborate why the split would fail?
> > > >
> > > > Just looking at the code, split_huge_pmd_locked() checks for
> > > > (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd)).
> > > > pmd_trans_huge() is false if !pmd_present() and it's not a migratio=
n
> > > > entry, so __split_huge_pmd_locked() will be skipped.
> > >
> > > Here might be the major part of where confusion came from: I thought =
it
> > > must be a migration pmd entry to hit the issue, so it's not?
> > >
> > > I checked the code just now:
> > >
> > > __handle_mm_fault:
> > >                 if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
> > >                         VM_BUG_ON(thp_migration_supported() &&
> > >                                           !is_pmd_migration_entry(vmf=
.orig_pmd));
> > >
> > > So IIUC pmd migration entry is still the only possible way to have a =
swap
> > > entry.  It doesn't look like we have "real" swap entries for PMD (whi=
ch can
> > > further points to some swapfiles)?
> >
> > Correct. AFAIU here we stumble on a pmd entry which was allocated but
> > never populated.
>
> Do you mean a pmd_none()?

Yes.

>
> If so, that goes back to my original question, on why
> __pmd_trans_huge_lock() returns non-NULL if it's a pmd_none()?  IMHO it
> really should have returned NULL for pmd_none().

That was exactly the answer I gave Lokesh when he theorized about the
cause of this crash but after reproducing it I saw that
pmd_trans_huge_lock() happily returns the PTL as long as PMD is not
pmd_none(). And that's because it passes as is_swap_pmd(). But even if
we change that we still need to implement the code to skip the entire
PMD.

>
> IOW, I still don't understand why below won't already work:
>
> =3D=3D=3D8<=3D=3D=3D
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 52d7d5f144b8e..33e78f52ee9f5 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1880,13 +1880,15 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, u=
nsigned long dst_start,
>                         /* Check if we can move the pmd without splitting=
 it. */
>                         if (move_splits_huge_pmd(dst_addr, src_addr, src_=
start + len) ||
>                             !pmd_none(dst_pmdval)) {
> -                               struct folio *folio =3D pmd_folio(*src_pm=
d);
> -
> -                               if (!folio || (!is_huge_zero_folio(folio)=
 &&
> -                                              !PageAnonExclusive(&folio-=
>page))) {
> -                                       spin_unlock(ptl);
> -                                       err =3D -EBUSY;
> -                                       break;
> +                               if (pmd_present(*src_pmd)) {
> +                                       struct folio *folio =3D pmd_folio=
(*src_pmd);
> +
> +                                       if (!folio || (!is_huge_zero_foli=
o(folio) &&
> +                                                      !PageAnonExclusive=
(&folio->page))) {
> +                                               spin_unlock(ptl);
> +                                               err =3D -EBUSY;
> +                                               break;
> +                                       }
>                                 }
>
>                                 spin_unlock(ptl);
>
> =3D=3D=3D8<=3D=3D=3D
>
> Likely I missed something important..  I'll be afk for a while soon, I'll
> also double check (maybe early next week) on the reproducer.
>
> Thanks,
>
> --
> Peter Xu
>

