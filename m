Return-Path: <stable+bounces-165758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9BCB1865F
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 19:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A4556246F
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 17:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD331DFDAB;
	Fri,  1 Aug 2025 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4bFfPKG"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5191DDC33
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068440; cv=none; b=u6qV3e2qwpF9HWRwe+8pynrjoL3vok/zSIGa4mg0QLHBhkBYF//cSCC+crIKL/mHuqLqHveMnPiq8Zq821Q93kLmM5fvsqDrI2PoVe5q1Yd7iMq5fOBdX+e5kixDFfzAnn/hTNjFAybijJVjPMJDgvcBgF0mxalCUDa3uGtMjrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068440; c=relaxed/simple;
	bh=urjHTNxVtznsZGPK5MfG0R49OKWj2ch5jHzSEmSRmi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYeNbtxh7RNadwp1xMQz2JY6Bp2pcJO6V6U33T5ovUzqR1aD2CUyCmeoFDLtlFcMSDHZF+jxFbO8BQhuwOS6gNV81foPkhalhoYMyOMB/+V9zYs0YE1/+saMA5U1b+x5md/ehFjFGeOorSK1RE75jiFk6EBRmu4CbHFlIOkyj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4bFfPKG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754068437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UapQRB4TdH6jPVjzlLlw/CIcbZ+SS127yBars+dasnY=;
	b=E4bFfPKGADA5XJIVWQDJfLrojC5d6uX81nDf3B5VpmMlLH9zgmLwky9qScNY4l05gIOosj
	S39gQPof8EVukt7EvljDPsAYC0zlxSbbPaMxUcHdxaPmRcZEsE4QCT0lCqJ11qOHKLMwPw
	cnbgxw2yf/DzcUr9OH+kk2OZYh+frxg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-1esqrPGdMty_dneVPgoh6Q-1; Fri, 01 Aug 2025 13:13:56 -0400
X-MC-Unique: 1esqrPGdMty_dneVPgoh6Q-1
X-Mimecast-MFC-AGG-ID: 1esqrPGdMty_dneVPgoh6Q_1754068436
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab68cc66d8so52368381cf.1
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 10:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754068435; x=1754673235;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UapQRB4TdH6jPVjzlLlw/CIcbZ+SS127yBars+dasnY=;
        b=cQrlmuC/7CS2JwpUbppNjoqMQq3etty14lr+7rNdPCwZXiYgKbBrriXO4IixAqiFT+
         hfPkf9SJB9Rrf4YH7suvkCe6ldUb4oAIi1aZrR0+qpd57sgkYx8gHJcpQne94j1/bRSL
         QrDPu9mRwRxUPvxLQd6wNwX1DV+p3BIv7cgo9VnabRIdxy/Vzlw6rNNjvkXLpJXfBbX0
         ufkg+Ce4C3LdePXwHmhtDHLgCSpRkwVlsy/Hlfo4Nx/lRR1+AvFyXlyBPBqyVEj0+3Cz
         EUW2hOcvG7fOP7jaL+enV0paLWKfOqWrNd/ixi1B2Dr6rcGe6JzDoBnzBwKTd/gACmP7
         m2aA==
X-Forwarded-Encrypted: i=1; AJvYcCXAkuQIK58qaTj8BnOAuBq525N6rvJb9C29TiUbv7ta5EHoBr0Yvw+moo8FHLH6/dhzLlMZJaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztC+iS+rTlk54uK2C6vxavR4TY85vy5tjTFtb0kj37hoYrT115
	25z4sDQE/UJKzXradW1PLHezXMpdy4DtHNDkl/AyiGLkY/IJLVtXLss/+k2sx08oWs8Aj1131+x
	k6xybCYRtxJcNDcObCS3dK8HR6mGLHSMzFP7S4eWYBdvt4k4fwgL4t1wuIw==
X-Gm-Gg: ASbGncuTCB0E5Bw8/r9KIQj5r6fZlozOvLEr7Zf0J2T0Kh6L6gCs8EkwJ/tKj4gd1BO
	EPnfv3C2sMDGAgu9QiDpYOx6jOom9BXVVEqO8iheOkEz8g2NgPljHi01pOdLcKBqF2B14i3P/5k
	xMe7dqR6Csv67o/VTMd5KwDoOmOZSvX4SrXBiuzR0q9ngsRE9CA6xjyb6r5dG//SVkNf3FXrigm
	TnAVO5p7Q0d1wfcq+O7aZ8mf5DY3vkgZizGB+CS4X/Inzl937MKgxT1NgsytDAOxpYitAJ0qYo3
	JUwe6sGsYEW7ZJHuBgp40FVXHyCgI37A
X-Received: by 2002:a05:622a:a953:20b0:4af:36a:a60f with SMTP id d75a77b69052e-4af036aa957mr25038471cf.21.1754068435402;
        Fri, 01 Aug 2025 10:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8+K6i2QRol52KGBLA9S6CAT2dneVBlknXiG0f/LH2d8sJO8oI3hxjPNdTh/rQMWdVl3tj8g==
X-Received: by 2002:a05:622a:a953:20b0:4af:36a:a60f with SMTP id d75a77b69052e-4af036aa957mr25037891cf.21.1754068434728;
        Fri, 01 Aug 2025 10:13:54 -0700 (PDT)
Received: from x1.local ([174.89.135.171])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeebde17fsm22954801cf.1.2025.08.01.10.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:13:54 -0700 (PDT)
Date: Fri, 1 Aug 2025 13:13:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	aarcange@redhat.com, lokeshgidra@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
Message-ID: <aIz1xrzBc2Spa2OH@x1.local>
References: <20250731154442.319568-1-surenb@google.com>
 <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
 <aIzMGlrR1SL5Y_Gp@x1.local>
 <CAJuCfpEqOUj8VPybstQjoJvCzyZtG6Q5Vr4WT0Lx_r3LFVS7og@mail.gmail.com>
 <aIzp6WqdzhomPhhf@x1.local>
 <CAJuCfpGWLnu+r2wvY2Egy2ESPD=tAVvfVvAKXUv1b+Z0hweeJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGWLnu+r2wvY2Egy2ESPD=tAVvfVvAKXUv1b+Z0hweeJg@mail.gmail.com>

On Fri, Aug 01, 2025 at 09:41:31AM -0700, Suren Baghdasaryan wrote:
> On Fri, Aug 1, 2025 at 9:23 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Aug 01, 2025 at 08:28:38AM -0700, Suren Baghdasaryan wrote:
> > > On Fri, Aug 1, 2025 at 7:16 AM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Fri, Aug 01, 2025 at 09:21:30AM +0200, David Hildenbrand wrote:
> > > > > On 31.07.25 17:44, Suren Baghdasaryan wrote:
> > > > >
> > > > > Hi!
> > > > >
> > > > > Did you mean in you patch description:
> > > > >
> > > > > "userfaultfd: fix a crash in UFFDIO_MOVE with some non-present PMDs"
> > > > >
> > > > > Talking about THP holes is very very confusing.
> > > > >
> > > > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> > > > > > encounters a non-present THP, it fails to properly recognize an unmapped
> > > > >
> > > > > You mean a "non-present PMD that is not a migration entry".
> > > > >
> > > > > > hole and tries to access a non-existent folio, resulting in
> > > > > > a crash. Add a check to skip non-present THPs.
> > > > >
> > > > > That makes sense. The code we have after this patch is rather complicated
> > > > > and hard to read.
> > > > >
> > > > > >
> > > > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > > > > > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
> > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > Cc: stable@vger.kernel.org
> > > > > > ---
> > > > > > Changes since v1 [1]
> > > > > > - Fixed step size calculation, per Lokesh Gidra
> > > > > > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokesh Gidra
> > > > > >
> > > > > > [1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@google.com/
> > > > > >
> > > > > >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
> > > > > >   1 file changed, 29 insertions(+), 16 deletions(-)
> > > > > >
> > > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > > index cbed91b09640..b5af31c22731 100644
> > > > > > --- a/mm/userfaultfd.c
> > > > > > +++ b/mm/userfaultfd.c
> > > > > > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> > > > > >             ptl = pmd_trans_huge_lock(src_pmd, src_vma);
> > > > > >             if (ptl) {
> > > > > > -                   /* Check if we can move the pmd without splitting it. */
> > > > > > -                   if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > > > -                       !pmd_none(dst_pmdval)) {
> > > > > > -                           struct folio *folio = pmd_folio(*src_pmd);
> > > > > > +                   if (pmd_present(*src_pmd) || is_pmd_migration_entry(*src_pmd)) {
> > > >
> > > > [1]
> > > >
> > > > > > +                           /* Check if we can move the pmd without splitting it. */
> > > > > > +                           if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > > > +                               !pmd_none(dst_pmdval)) {
> > > > > > +                                   if (pmd_present(*src_pmd)) {
> >
> > [2]
> >
> > > > > > +                                           struct folio *folio = pmd_folio(*src_pmd);
> >
> > [3]
> >
> > > > > > +
> > > > > > +                                           if (!folio || (!is_huge_zero_folio(folio) &&
> > > > > > +                                                          !PageAnonExclusive(&folio->page))) {
> > > > > > +                                                   spin_unlock(ptl);
> > > > > > +                                                   err = -EBUSY;
> > > > > > +                                                   break;
> > > > > > +                                           }
> > > > > > +                                   }
> > > > >
> > > > > ... in particular that. Is there some way to make this code simpler / easier
> > > > > to read? Like moving that whole last folio-check thingy into a helper?
> > > >
> > > > One question might be relevant is, whether the check above [1] can be
> > > > dropped.
> > > >
> > > > The thing is __pmd_trans_huge_lock() does double check the pmd to be !none
> > > > before returning the ptl.  I didn't follow closely on the recent changes on
> > > > mm side on possible new pmd swap entries, if migration is the only possible
> > > > one then it looks like [1] can be avoided.
> > >
> > > Hi Peter,
> > > is_swap_pmd() check in __pmd_trans_huge_lock() allows for (!pmd_none()
> > > && !pmd_present()) PMD to pass and that's when this crash is hit.
> >
> > First for all, thanks for looking into the issue with Lokesh; I am still
> > catching up with emails after taking weeks off.
> >
> > I didn't yet read into the syzbot report, but I thought the bug was about
> > referencing the folio on top of a swap entry after reading your current
> > patch, which has:
> >
> >         if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> >             !pmd_none(dst_pmdval)) {
> >                 struct folio *folio = pmd_folio(*src_pmd); <----
> >
> > Here looks like *src_pmd can be a migration entry. Is my understanding
> > correct?
> 
> Correct.
> 
> >
> > > If we drop the check at [1] then the path that takes us to
> >
> > If my above understanding is correct, IMHO it should be [2] above that
> > makes sure the reference won't happen on a swap entry, not necessarily [1]?
> 
> Yes, in case of migration entry this is what protects us.
> 
> >
> > > split_huge_pmd() will bail out inside split_huge_pmd_locked() with no
> > > indication that split did not happen. Afterwards we will retry
> >
> > So we're talking about the case where it's a swap pmd entry, right?
> 
> Hmm, my understanding is that it's being treated as a swap entry but
> in reality is not. I thought THPs are always split before they get
> swapped, no?

Yes they should be split, afaiu.

> 
> > Could you elaborate why the split would fail?
> 
> Just looking at the code, split_huge_pmd_locked() checks for
> (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd)).
> pmd_trans_huge() is false if !pmd_present() and it's not a migration
> entry, so __split_huge_pmd_locked() will be skipped.

Here might be the major part of where confusion came from: I thought it
must be a migration pmd entry to hit the issue, so it's not?

I checked the code just now:

__handle_mm_fault:
		if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
			VM_BUG_ON(thp_migration_supported() &&
					  !is_pmd_migration_entry(vmf.orig_pmd));

So IIUC pmd migration entry is still the only possible way to have a swap
entry.  It doesn't look like we have "real" swap entries for PMD (which can
further points to some swapfiles)?

-- 
Peter Xu


