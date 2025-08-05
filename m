Return-Path: <stable+bounces-166635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC0EB1B6EF
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 16:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B443B9493
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 14:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E862264A0;
	Tue,  5 Aug 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJyVwZkG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7227933F
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754405852; cv=none; b=a45L03X3CsoaJ8CIP2UCV6RoZrYjyzpavu19Orq+e0Qpmoltn3yM+BBnEC+JeAKUbm06t8xmyxO1tY6PJW/6KHJbhu7fdbl6S4O+OC5ImZfqxNVk2GDQuavYtc/gZassOdQd4N9tPDIvaep36drQwxvDnseXOt485fUP+8oIDcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754405852; c=relaxed/simple;
	bh=NhdyBGEPT7eejNSJMcyjTlJxOm6Q6CKyxrDAtOrUNmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWNMs8yfh8XN0kdRy0NcqcR52Ng+x4wMU1C8lgG6lpHCdHAuJ1MGai3wwWyGSeH/4zofxmhKfqBPCGJzIcYMmzmNjAM7F/CFKeC9vv0bG+FrpKQB89wPdDgglkS7uFdxsCfJgXEe0dKDCpsye0hh92sULcjO0/vN8BMkmJoQIlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJyVwZkG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b07a5e9f9fso440451cf.0
        for <stable@vger.kernel.org>; Tue, 05 Aug 2025 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754405849; x=1755010649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX5cs3lHqIbxrim0a3iEN5C2bHRmCjQDiyeRqDnGqIA=;
        b=HJyVwZkGz7cif15IXHonIxwT1m7Lj3cfUKVI2XD1jupoPYKnYJuAGTv3ckct5h5kdh
         XoA5sAbwggr4pjR1wcAzE2W/fNLXnNhApym8NGst6uf/BrgiU9GaQTGr5oieAIfr505y
         d1R6iMXzWxxGcDlq/VaD2ylExtW28ZhVKS2Gugu4FVahunRtn2MV5tQ6+kJgHUHRgdp6
         fVkCKC10osz+/7BfAO7YD0vwO6u6pywRk7p9PwvHoccVYrfvv9QVgfWKdylA/NKI5xdQ
         3q+SfgScZ5E4cVO1qyS6OY4k8jr24PNQnZ+FypPwAAsmG4IwYi/Dm8AhOUT64p2YX/Wt
         N+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754405849; x=1755010649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UX5cs3lHqIbxrim0a3iEN5C2bHRmCjQDiyeRqDnGqIA=;
        b=XKOFUjFanDVCg4nvmM5XOpHP3+pD+RiJ6rBnp4zyHg09BDK4qlSDSScLrdUcJgR/3m
         i9jfsKy2S3KV6SXdnD7CT1tZKK+mgFP+cbIqLmghI8nTPareSYGyBp1B8hfTF8Wvh9N/
         Dyczznur1l8A/zt/6hXdWMm6yMlJuIr13YepWIynkzs8onJVU0Bs5vd9rKNMb8MaKHKQ
         iOyNUo9rtP+Vawn5r6D1cjV5XfUYGbW38c8uV0sBn9ZzoNkFNGZnGTIYENxH4+iPgXpx
         nOuofaE6cfmhcwfqXMNONhpHeOWukJZqHfi5Pj//pawJBRIUpd292cmsXyY/tJYUd/rt
         34qw==
X-Forwarded-Encrypted: i=1; AJvYcCXDsGLN39fdtMeFtuA1FabF1eQ2V92HoO7QDf2WVX8cg/quBBzNBqeD8OeT4FagW/FY0Xc4j1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy83NDHrB2mV7ZwuywEsACivtZNgZSep82tkcTY5IPN5vIgQdNP
	HMIpkVwmSpapWfZuCocBfimapbzL6JxZiwRtjCuPRiwow5SYsc1oRFkmlx8ryhVPSXcOvxXFWe7
	4ZH0aCgRbi+/U8x1mmRIiQN3kNv8ib+b4tu8X3bnP
X-Gm-Gg: ASbGncuAeO+10VmRaqAEBVI4Bs4tOfjO3nC0VqdJAow7SeO4pqIiSSG5V+luh/W2iR1
	wZznmEBXZKMI9wwdEuiJNWrb5sXlHoeYS8KzS5dz9RsJYrN0CEzMOwDarMlCm2K9jnPjDo42yGa
	y96Z2iWqdV42XYjnx4t+ydkWzFpM9Vwb98lTdRZnFTcEn6ZrGqQP8n0kXP36TcBx+QNOq75qi/f
	Kl4EbTCaJg/dPM27EXHbs+K+pOcoUwHYs0sRsfXg41EqWz1
X-Google-Smtp-Source: AGHT+IGLZKNoZY1g7Z4NbMCRTteQccrBt8PcIwP4mJ0WIiz5tnPREzcYXyX50zdXotguGwk86Au/Hdop0F1jHsOFKmo=
X-Received: by 2002:a05:622a:180b:b0:497:75b6:e542 with SMTP id
 d75a77b69052e-4b084f11753mr4011031cf.10.1754405848822; Tue, 05 Aug 2025
 07:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIzMGlrR1SL5Y_Gp@x1.local> <CAJuCfpEqOUj8VPybstQjoJvCzyZtG6Q5Vr4WT0Lx_r3LFVS7og@mail.gmail.com>
 <aIzp6WqdzhomPhhf@x1.local> <CAJuCfpGWLnu+r2wvY2Egy2ESPD=tAVvfVvAKXUv1b+Z0hweeJg@mail.gmail.com>
 <aIz1xrzBc2Spa2OH@x1.local> <CAJuCfpFJGaDaFyNLa3JsVh19NWLGNGo1ebC_ijGTgPGNyfUFig@mail.gmail.com>
 <aI0Ffc9WXeU2X71O@x1.local> <CAJuCfpFSY3fDH36dabS=nGzasZJ6FtQ_jv79eFWVZrEWRMMTiQ@mail.gmail.com>
 <aI1ckD3KhNvoMtlv@x1.local> <CAJuCfpHcScutgGi3imYTJVXBqs=jcqZ5CkKKe=sfVHjUg0Y6RQ@mail.gmail.com>
 <aJIXlN-ZD_soWdP0@x1.local>
In-Reply-To: <aJIXlN-ZD_soWdP0@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 5 Aug 2025 07:57:17 -0700
X-Gm-Features: Ac12FXyAM_EgbCxyw_Y-VGO-izFJUCqFoQ6tTjGFrNOoAZicqFMbU-6OO5r2W8c
Message-ID: <CAJuCfpFzP_W8i8pwL+-Uv-n+2LixgFrzqn2HsY_h-1kbP=g3JQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 7:39=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Aug 04, 2025 at 07:55:42AM -0700, Suren Baghdasaryan wrote:
> > On Fri, Aug 1, 2025 at 5:32=E2=80=AFPM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > On Fri, Aug 01, 2025 at 07:30:02PM +0000, Suren Baghdasaryan wrote:
> > > > On Fri, Aug 1, 2025 at 6:21=E2=80=AFPM Peter Xu <peterx@redhat.com>=
 wrote:
> > > > >
> > > > > On Fri, Aug 01, 2025 at 05:45:10PM +0000, Suren Baghdasaryan wrot=
e:
> > > > > > On Fri, Aug 1, 2025 at 5:13=E2=80=AFPM Peter Xu <peterx@redhat.=
com> wrote:
> > > > > > >
> > > > > > > On Fri, Aug 01, 2025 at 09:41:31AM -0700, Suren Baghdasaryan =
wrote:
> > > > > > > > On Fri, Aug 1, 2025 at 9:23=E2=80=AFAM Peter Xu <peterx@red=
hat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Aug 01, 2025 at 08:28:38AM -0700, Suren Baghdasar=
yan wrote:
> > > > > > > > > > On Fri, Aug 1, 2025 at 7:16=E2=80=AFAM Peter Xu <peterx=
@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Aug 01, 2025 at 09:21:30AM +0200, David Hilde=
nbrand wrote:
> > > > > > > > > > > > On 31.07.25 17:44, Suren Baghdasaryan wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Hi!
> > > > > > > > > > > >
> > > > > > > > > > > > Did you mean in you patch description:
> > > > > > > > > > > >
> > > > > > > > > > > > "userfaultfd: fix a crash in UFFDIO_MOVE with some =
non-present PMDs"
> > > > > > > > > > > >
> > > > > > > > > > > > Talking about THP holes is very very confusing.
> > > > > > > > > > > >
> > > > > > > > > > > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_AL=
LOW_SRC_HOLES and it
> > > > > > > > > > > > > encounters a non-present THP, it fails to properl=
y recognize an unmapped
> > > > > > > > > > > >
> > > > > > > > > > > > You mean a "non-present PMD that is not a migration=
 entry".
> > > > > > > > > > > >
> > > > > > > > > > > > > hole and tries to access a non-existent folio, re=
sulting in
> > > > > > > > > > > > > a crash. Add a check to skip non-present THPs.
> > > > > > > > > > > >
> > > > > > > > > > > > That makes sense. The code we have after this patch=
 is rather complicated
> > > > > > > > > > > > and hard to read.
> > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uA=
BI")
> > > > > > > > > > > > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkalle=
r.appspotmail.com
> > > > > > > > > > > > > Closes: https://lore.kernel.org/all/68794b5c.a70a=
0220.693ce.0050.GAE@google.com/
> > > > > > > > > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.=
com>
> > > > > > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > > > > > ---
> > > > > > > > > > > > > Changes since v1 [1]
> > > > > > > > > > > > > - Fixed step size calculation, per Lokesh Gidra
> > > > > > > > > > > > > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_=
SRC_HOLES, per Lokesh Gidra
> > > > > > > > > > > > >
> > > > > > > > > > > > > [1] https://lore.kernel.org/all/20250730170733.38=
29267-1-surenb@google.com/
> > > > > > > > > > > > >
> > > > > > > > > > > > >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++=
++++----------------
> > > > > > > > > > > > >   1 file changed, 29 insertions(+), 16 deletions(=
-)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > > > > > > > > > index cbed91b09640..b5af31c22731 100644
> > > > > > > > > > > > > --- a/mm/userfaultfd.c
> > > > > > > > > > > > > +++ b/mm/userfaultfd.c
> > > > > > > > > > > > > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct=
 userfaultfd_ctx *ctx, unsigned long dst_start,
> > > > > > > > > > > > >             ptl =3D pmd_trans_huge_lock(src_pmd, =
src_vma);
> > > > > > > > > > > > >             if (ptl) {
> > > > > > > > > > > > > -                   /* Check if we can move the p=
md without splitting it. */
> > > > > > > > > > > > > -                   if (move_splits_huge_pmd(dst_=
addr, src_addr, src_start + len) ||
> > > > > > > > > > > > > -                       !pmd_none(dst_pmdval)) {
> > > > > > > > > > > > > -                           struct folio *folio =
=3D pmd_folio(*src_pmd);
> > > > > > > > > > > > > +                   if (pmd_present(*src_pmd) || =
is_pmd_migration_entry(*src_pmd)) {
> > > > > > > > > > >
> > > > > > > > > > > [1]
> > > > > > > > > > >
> > > > > > > > > > > > > +                           /* Check if we can mo=
ve the pmd without splitting it. */
> > > > > > > > > > > > > +                           if (move_splits_huge_=
pmd(dst_addr, src_addr, src_start + len) ||
> > > > > > > > > > > > > +                               !pmd_none(dst_pmd=
val)) {
> > > > > > > > > > > > > +                                   if (pmd_prese=
nt(*src_pmd)) {
> > > > > > > > >
> > > > > > > > > [2]
> > > > > > > > >
> > > > > > > > > > > > > +                                           struc=
t folio *folio =3D pmd_folio(*src_pmd);
> > > > > > > > >
> > > > > > > > > [3]
> > > > > > > > >
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +                                           if (!=
folio || (!is_huge_zero_folio(folio) &&
> > > > > > > > > > > > > +                                                =
          !PageAnonExclusive(&folio->page))) {
> > > > > > > > > > > > > +                                                =
   spin_unlock(ptl);
> > > > > > > > > > > > > +                                                =
   err =3D -EBUSY;
> > > > > > > > > > > > > +                                                =
   break;
> > > > > > > > > > > > > +                                           }
> > > > > > > > > > > > > +                                   }
> > > > > > > > > > > >
> > > > > > > > > > > > ... in particular that. Is there some way to make t=
his code simpler / easier
> > > > > > > > > > > > to read? Like moving that whole last folio-check th=
ingy into a helper?
> > > > > > > > > > >
> > > > > > > > > > > One question might be relevant is, whether the check =
above [1] can be
> > > > > > > > > > > dropped.
> > > > > > > > > > >
> > > > > > > > > > > The thing is __pmd_trans_huge_lock() does double chec=
k the pmd to be !none
> > > > > > > > > > > before returning the ptl.  I didn't follow closely on=
 the recent changes on
> > > > > > > > > > > mm side on possible new pmd swap entries, if migratio=
n is the only possible
> > > > > > > > > > > one then it looks like [1] can be avoided.
> > > > > > > > > >
> > > > > > > > > > Hi Peter,
> > > > > > > > > > is_swap_pmd() check in __pmd_trans_huge_lock() allows f=
or (!pmd_none()
> > > > > > > > > > && !pmd_present()) PMD to pass and that's when this cra=
sh is hit.
> > > > > > > > >
> > > > > > > > > First for all, thanks for looking into the issue with Lok=
esh; I am still
> > > > > > > > > catching up with emails after taking weeks off.
> > > > > > > > >
> > > > > > > > > I didn't yet read into the syzbot report, but I thought t=
he bug was about
> > > > > > > > > referencing the folio on top of a swap entry after readin=
g your current
> > > > > > > > > patch, which has:
> > > > > > > > >
> > > > > > > > >         if (move_splits_huge_pmd(dst_addr, src_addr, src_=
start + len) ||
> > > > > > > > >             !pmd_none(dst_pmdval)) {
> > > > > > > > >                 struct folio *folio =3D pmd_folio(*src_pm=
d); <----
> > > > > > > > >
> > > > > > > > > Here looks like *src_pmd can be a migration entry. Is my =
understanding
> > > > > > > > > correct?
> > > > > > > >
> > > > > > > > Correct.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > If we drop the check at [1] then the path that takes us=
 to
> > > > > > > > >
> > > > > > > > > If my above understanding is correct, IMHO it should be [=
2] above that
> > > > > > > > > makes sure the reference won't happen on a swap entry, no=
t necessarily [1]?
> > > > > > > >
> > > > > > > > Yes, in case of migration entry this is what protects us.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > split_huge_pmd() will bail out inside split_huge_pmd_lo=
cked() with no
> > > > > > > > > > indication that split did not happen. Afterwards we wil=
l retry
> > > > > > > > >
> > > > > > > > > So we're talking about the case where it's a swap pmd ent=
ry, right?
> > > > > > > >
> > > > > > > > Hmm, my understanding is that it's being treated as a swap =
entry but
> > > > > > > > in reality is not. I thought THPs are always split before t=
hey get
> > > > > > > > swapped, no?
> > > > > > >
> > > > > > > Yes they should be split, afaiu.
> > > > > > >
> > > > > > > >
> > > > > > > > > Could you elaborate why the split would fail?
> > > > > > > >
> > > > > > > > Just looking at the code, split_huge_pmd_locked() checks fo=
r
> > > > > > > > (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd)).
> > > > > > > > pmd_trans_huge() is false if !pmd_present() and it's not a =
migration
> > > > > > > > entry, so __split_huge_pmd_locked() will be skipped.
> > > > > > >
> > > > > > > Here might be the major part of where confusion came from: I =
thought it
> > > > > > > must be a migration pmd entry to hit the issue, so it's not?
> > > > > > >
> > > > > > > I checked the code just now:
> > > > > > >
> > > > > > > __handle_mm_fault:
> > > > > > >                 if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
> > > > > > >                         VM_BUG_ON(thp_migration_supported() &=
&
> > > > > > >                                           !is_pmd_migration_e=
ntry(vmf.orig_pmd));
> > > > > > >
> > > > > > > So IIUC pmd migration entry is still the only possible way to=
 have a swap
> > > > > > > entry.  It doesn't look like we have "real" swap entries for =
PMD (which can
> > > > > > > further points to some swapfiles)?
> > > > > >
> > > > > > Correct. AFAIU here we stumble on a pmd entry which was allocat=
ed but
> > > > > > never populated.
> > > > >
> > > > > Do you mean a pmd_none()?
> > > >
> > > > Yes.
> > > >
> > > > >
> > > > > If so, that goes back to my original question, on why
> > > > > __pmd_trans_huge_lock() returns non-NULL if it's a pmd_none()?  I=
MHO it
> > > > > really should have returned NULL for pmd_none().
> > > >
> > > > That was exactly the answer I gave Lokesh when he theorized about t=
he
> > > > cause of this crash but after reproducing it I saw that
> > > > pmd_trans_huge_lock() happily returns the PTL as long as PMD is not
> > > > pmd_none(). And that's because it passes as is_swap_pmd(). But even=
 if
> > > > we change that we still need to implement the code to skip the enti=
re
> > > > PMD.
> > >
> > > The thing is I thought if pmd_trans_huge_lock() can return non-NULL, =
it
> > > must be either a migration entry or a present THP. So are you describ=
ing a
> > > THP but with present bit cleared?  Do you know what is that entry, an=
d why
> > > it has present bit cleared?
> >
> > In this case it's because earlier we allocated that PMD here:
> > https://elixir.bootlin.com/linux/v6.16/source/mm/userfaultfd.c#L1797
>
> AFAIU, this line is not about allocation of any pmd entry, but the pmd
> pgtable page that _holds_ the PMDs:
>
> static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned=
 long address)
> {
>         return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address)=
)?
>                 NULL: pmd_offset(pud, address);
> }
>
> It makes sure the PUD entry, not the PMD entry, be populated.

Hmm. Then I was reading this code completely wrong and need to rethink
what is happening here.

>
> > but wouldn't that be the same if the PMD was mapped and then got
> > unmapped later? My understanding is that we allocate the PMD at the
> > line I pointed to make UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES case the same
> > as this unmapped PMD case. If my assumption is incorrect then we could
> > skip the hole earlier instead of allocating the PMD for it.
> >
> > >
> > > I think my attention got attracted to pmd migration entry too much, s=
o I
> > > didn't really notice such possibility, as I believe migration pmd is =
broken
> > > already in this path.
> > >
> > > The original code:
> > >
> > >                 ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
> > >                 if (ptl) {
> > >                         /* Check if we can move the pmd without split=
ting it. */
> > >                         if (move_splits_huge_pmd(dst_addr, src_addr, =
src_start + len) ||
> > >                             !pmd_none(dst_pmdval)) {
> > >                                 struct folio *folio =3D pmd_folio(*sr=
c_pmd);
> > >
> > >                                 if (!folio || (!is_huge_zero_folio(fo=
lio) &&
> > >                                                !PageAnonExclusive(&fo=
lio->page))) {
> > >                                         spin_unlock(ptl);
> > >                                         err =3D -EBUSY;
> > >                                         break;
> > >                                 }
> > >
> > >                                 spin_unlock(ptl);
> > >                                 split_huge_pmd(src_vma, src_pmd, src_=
addr);
> > >                                 /* The folio will be split by move_pa=
ges_pte() */
> > >                                 continue;
> > >                         }
> > >
> > >                         err =3D move_pages_huge_pmd(mm, dst_pmd, src_=
pmd,
> > >                                                   dst_pmdval, dst_vma=
, src_vma,
> > >                                                   dst_addr, src_addr)=
;
> > >                         step_size =3D HPAGE_PMD_SIZE;
> > >                 } else {
> > >
> > > It'll get ptl for a migration pmd, then pmd_folio is risky without ch=
ecking
> > > present bit.  That's what my previous smaller patch wanted to fix.
> > >
> > > But besides that, IIUC it's all fine at least for a pmd migration ent=
ry,
> > > because when with the smaller patch applied, either we'll try to spli=
t the
> > > pmd migration entry, or we'll do move_pages_huge_pmd(), which interna=
lly
> > > handles the pmd migration entry too by waiting on it:
> > >
> > >         if (!pmd_trans_huge(src_pmdval)) {
> > >                 spin_unlock(src_ptl);
> > >                 if (is_pmd_migration_entry(src_pmdval)) {
> > >                         pmd_migration_entry_wait(mm, &src_pmdval);
> > >                         return -EAGAIN;
> > >                 }
> > >                 return -ENOENT;
> > >         }
> > >
> > > Then logically after the migration entry got recovered, we'll either =
see a
> > > real THP or pmd none next time.
> >
> > Yes, for migration entries adding the "if (pmd_present(*src_pmd))"
> > before getting the folio is enough. The problematic case is
> > (!pmd_none(*src_pmd) && !pmd_present(*src_pmd)) and not a migration
> > entry.
>
> I thought we could have any of below here on the pmd entry:
>
>   (0) pmd_none, which should constantly have pmd_trans_huge_lock -> NULL
>
>   (1) pmd pgtable entry, which must have PRESENT && !TRANS, so
>   pmd_trans_huge_lock -> NULL,
>
>   (2) pmd migration, pmd_trans_huge_lock -> valid
>
>   (3) pmd thp, pmd_trans_huge_lock -> valid
>
> I thought (2) was broken, which we seem to agree upon.. however if so the
> smaller patch should fix it, per explanation in my previous reply.  OTOH =
I
> can't think of (4).

The case I was hitting is (!pmd_none && !pmd_present &&
!is_pmd_migration_entry). My original thinking was that this entry was
newly allocated at the line I pointed earlier but now I'm not so sure
anymore.

>
> Said that, I just noticed (3) can be broken as well - could it be a
> prot_none entry?  The very confusing part of this patch is it seems to
> think it's pmd_none() here as holes:
>
>         if (pmd_present(*src_pmd) || is_pmd_migration_entry(*src_pmd)) {
>                 ...
>         } else {
>                 spin_unlock(ptl);
>                 if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {
>                         err =3D -ENOENT;
>                         break;
>                 }
>                 /* nothing to do to move a hole */
>                 err =3D 0;
>                 step_size =3D min(HPAGE_PMD_SIZE, src_start + len - src_a=
ddr);
>         }
>
> But is it really?  Again, I don't think pmd_none() could happen with
> pmd_trans_huge_lock() returning the ptl.

That is true, in the pmd_none() case pmd_trans_huge_lock() returns NULL.

>
> Could you double check this?  E.g. with this line if that makes sense to
> you:
>
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 8bf8ff0be990f..d2d4f2a0ae69f 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1903,6 +1903,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, uns=
igned long dst_start,
>                                                           dst_addr, src_a=
ddr);
>                                 step_size =3D HPAGE_PMD_SIZE;
>                         } else {
> +                               BUG_ON(!pmd_none(*src_pmd));
>                                 spin_unlock(ptl);
>                                 if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_H=
OLES)) {
>                                         err =3D -ENOENT;
>
> I would expect it constantly BUG() here, if that explains my thoughts.

I'll add this and check.

>
> Now I doubt it's a prot_none THP.. aka, a THP that got numa hint to be
> moved.  If so, we may need to process it / move it / .. but we likely
> should never skip it.  We can double check the buggy pmd entry you hit
> (besides migration entry) first.

Let me log the flags of the entry when this issue happens. That should
provide more insights.
Thanks,
Suren.

>
> Thanks,
>
> --
> Peter Xu
>

