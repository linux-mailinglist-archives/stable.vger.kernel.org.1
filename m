Return-Path: <stable+bounces-165753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34D4B184F4
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 17:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B40585842
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B99272E7E;
	Fri,  1 Aug 2025 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQbLeL/P"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71313272E51
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062134; cv=none; b=uFncfDWHE29dfm/zhngHrT4/NFzflDe9qk+icq83iIApa8MO66kfViUOHryN4QoT6/xq2Ns/qIEw3bVnPzhIpEI19wd4leaB4I4kAi96bbRi/i36h6XRCqvKecInmBzKJOdolAg+rAbga1E1T5OqRLKkOqsdX904T5ePa8K+Qus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062134; c=relaxed/simple;
	bh=1nuyfykHKbww2UsYTenRbhSr7IHO3blinakLuHPVej4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvuwIwav4z0ggLzn6McLSUL9mDIeAVS3FeudSSyA7BM0aDzwURNu9k9Po0drw096/kdUHmsVqzdxs6o+2zKlqcH9uWWLQXJY6PdQRNhyTq9aeDeQv5rOpz0od1y+g9tUzadMadao8KllL2SacIWVmea3sgrEjC22nUuZda/8Oww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sQbLeL/P; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4aef56cea5bso192851cf.1
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754062130; x=1754666930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKUaz7EOc6pAVsIf46qg1U45YzHIMBuAGqpgh/8GvhQ=;
        b=sQbLeL/PuaJjEtejw4+MWNEiyzkyepdcHSqaKsqVVhkVFiE4IK06iuBJ01p4LI+bwA
         U0jWc1lUEIujLJg9g8mDAOYSpe1SLkPVThjij4Z1LAFPBy9iKyPY4J6aqHSZ+4qebVP8
         +LFnwr4IZk7L5MwzkPHXVmHCc2q2krtTfICgyj6uzn8tYjbEsC7V0SxNpg6OzvXgYk6M
         dpFaQcNbvjESNqCIa8RYtfy8S9HtGybuVk7S1wQQylIeC8JF6COvbGnSU2hKwF3VgeNR
         DzvF68CE4TXbyzWfq0uZZjX0RABz6xPgS3hzDNqSo8A1ZUesY5kwzMcoL+2GmpjxLJj3
         5SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062130; x=1754666930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKUaz7EOc6pAVsIf46qg1U45YzHIMBuAGqpgh/8GvhQ=;
        b=xSFOP4qGVafn6UbD6dE6qKUGdfQnoZBnoUC9GpSjqs67mIzjth8VfDuhVrB/IWE9vh
         tyzE/TWwc9Xw8Nim/FOSlVyzEEGT2xyERuebZ15O0h2csyKgodnZUCFAbDLqWpJIST6U
         xEDZKpFSeaBDLWqOt3gUscoe2UQ5Cjd/ZfGBgIVilgQLgDNYX6wQ9GeT+8yZaJqErMry
         MKSN9ikYDSTuQNh/l0RbRLtQoHsaIs8zOJhn7PSaEFXFKUDpjU73dmh1RMOb0FxgTz7P
         cETkMAgryyqglaAYoe8lPubuQ0muAjtDXwImEX07KNnWQqxCA3puTfnyqUSZUA3/uOmx
         UPoA==
X-Forwarded-Encrypted: i=1; AJvYcCXzUpI9/2KhIlnCStFfYnlHebPi9VajBCUMZVxBxB4Gx1Ddvxhl7W8RLFJ5UFOLc4Ke09VqWQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/jw8iSP3RsuAMcIGlpXe9wS2mUImLGIFesku6MM43K3r2ZNPy
	hMVJfvZZvdopG8TCENgvvNNJre2mB+eNzFYGalDhLTw4BPfnRnbKfTnS0FcLZkJSKGCJxniIprl
	g140iNVwfG0LpHVhpQX0mhvQuVE2UOsMMj1RQfSTc
X-Gm-Gg: ASbGncvBucQT/YzdsVQe0uZpA6p+N667M+q1QDt1ndx/OcGyB6gEc/H/c3D6FA0rWkt
	o00EOH1bulHlH7oSFhLzrvZpStGgew0rNsJVfdke3ysrxid6AC5KDpZhFnDFEb8XRX8W9jRpkyn
	kZBhnhOynwR21zm5cTUa2bSOortd/1dQ1gf2hHEuWHiv4NriZ5e79K0j5zwI98vbuWIub5xZhtY
	fTMyibak8ntNRDXwUyj3TqogdJM9qm4iCx3tA==
X-Google-Smtp-Source: AGHT+IF+teQNuR14ehmgtvK0of52GqQHhCvAg/4XHVLVi6NVhtxwyDJNIbdEdTYfPwlm7CziAZ1u+5p/EohwBYVT+A8=
X-Received: by 2002:ac8:5a09:0:b0:4a6:907e:61ca with SMTP id
 d75a77b69052e-4aefe562a19mr5749921cf.12.1754062129703; Fri, 01 Aug 2025
 08:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731154442.319568-1-surenb@google.com> <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
 <aIzMGlrR1SL5Y_Gp@x1.local>
In-Reply-To: <aIzMGlrR1SL5Y_Gp@x1.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 1 Aug 2025 08:28:38 -0700
X-Gm-Features: Ac12FXy4jpkgwpCin0s1nae7ReBsAmBb3y90QLsWZVUvuEg44PA4Y4G1UBm27Jc
Message-ID: <CAJuCfpEqOUj8VPybstQjoJvCzyZtG6Q5Vr4WT0Lx_r3LFVS7og@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 7:16=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Aug 01, 2025 at 09:21:30AM +0200, David Hildenbrand wrote:
> > On 31.07.25 17:44, Suren Baghdasaryan wrote:
> >
> > Hi!
> >
> > Did you mean in you patch description:
> >
> > "userfaultfd: fix a crash in UFFDIO_MOVE with some non-present PMDs"
> >
> > Talking about THP holes is very very confusing.
> >
> > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> > > encounters a non-present THP, it fails to properly recognize an unmap=
ped
> >
> > You mean a "non-present PMD that is not a migration entry".
> >
> > > hole and tries to access a non-existent folio, resulting in
> > > a crash. Add a check to skip non-present THPs.
> >
> > That makes sense. The code we have after this patch is rather complicat=
ed
> > and hard to read.
> >
> > >
> > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@=
google.com/
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Cc: stable@vger.kernel.org
> > > ---
> > > Changes since v1 [1]
> > > - Fixed step size calculation, per Lokesh Gidra
> > > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokes=
h Gidra
> > >
> > > [1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@googl=
e.com/
> > >
> > >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
> > >   1 file changed, 29 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index cbed91b09640..b5af31c22731 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ct=
x, unsigned long dst_start,
> > >             ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
> > >             if (ptl) {
> > > -                   /* Check if we can move the pmd without splitting=
 it. */
> > > -                   if (move_splits_huge_pmd(dst_addr, src_addr, src_=
start + len) ||
> > > -                       !pmd_none(dst_pmdval)) {
> > > -                           struct folio *folio =3D pmd_folio(*src_pm=
d);
> > > +                   if (pmd_present(*src_pmd) || is_pmd_migration_ent=
ry(*src_pmd)) {
>
> [1]
>
> > > +                           /* Check if we can move the pmd without s=
plitting it. */
> > > +                           if (move_splits_huge_pmd(dst_addr, src_ad=
dr, src_start + len) ||
> > > +                               !pmd_none(dst_pmdval)) {
> > > +                                   if (pmd_present(*src_pmd)) {
> > > +                                           struct folio *folio =3D p=
md_folio(*src_pmd);
> > > +
> > > +                                           if (!folio || (!is_huge_z=
ero_folio(folio) &&
> > > +                                                          !PageAnonE=
xclusive(&folio->page))) {
> > > +                                                   spin_unlock(ptl);
> > > +                                                   err =3D -EBUSY;
> > > +                                                   break;
> > > +                                           }
> > > +                                   }
> >
> > ... in particular that. Is there some way to make this code simpler / e=
asier
> > to read? Like moving that whole last folio-check thingy into a helper?
>
> One question might be relevant is, whether the check above [1] can be
> dropped.
>
> The thing is __pmd_trans_huge_lock() does double check the pmd to be !non=
e
> before returning the ptl.  I didn't follow closely on the recent changes =
on
> mm side on possible new pmd swap entries, if migration is the only possib=
le
> one then it looks like [1] can be avoided.

Hi Peter,
is_swap_pmd() check in __pmd_trans_huge_lock() allows for (!pmd_none()
&& !pmd_present()) PMD to pass and that's when this crash is hit.
If we drop the check at [1] then the path that takes us to
split_huge_pmd() will bail out inside split_huge_pmd_locked() with no
indication that split did not happen. Afterwards we will retry
thinking that PMD got split and leaving further remapping to
move_pages_pte() (see the comment before "continue"). I think in this
case it will end up in the same path again instead (infinite loop). I
didn't test this but from the code I think that's what would happen.
Does that make sense?

>
> And it also looks applicable to also drop the "else" later, because in "i=
f
> (ptl)" it cannot hit pmd_none().
>
> Thanks,
>
> --
> Peter Xu
>

