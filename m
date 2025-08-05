Return-Path: <stable+bounces-166633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED9B1B6B1
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 16:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B3B188BBE2
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5681C277CBC;
	Tue,  5 Aug 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NP9PEN/2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAF623AB8E
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404776; cv=none; b=LOXmJWQXyT/WzynuBfepClhaNvisN+rS5h6bjSAqeCHvPyCMZLHGAfs0lPJJZhjPv/jPM9QBKkFcvszMOacNRMBCM1TASoictdBfyeW04g7DRJCGEhWKfnMQlr0vdT1wzz7NIOx+b3P0QvmIxikwi+ROhPNDYMAFeDI5T6kGpHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404776; c=relaxed/simple;
	bh=gbokQcVVmMFKLfH6UFzF/zNCmiwRKHtvhABBZ3J6q0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0f5hZum309yvSAPgdF5ZBQMKX7scsnPuB/4WodBDkzyHoMLKoUWuE6M4Jx3pm0N3A4Sg/wdaeMn5hXzjs3Lgj56FSdglr0KBTBUZknN9f94VawmRLw9hfGJZb7hqYCUmdhjGa1a2VrTrvS14cC4bUythJGVSacl8tECmEHbGxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NP9PEN/2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754404772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=osBUTD8AGmf3RzRhZE1d3AllWvZV7FgrCRdQPsKZtns=;
	b=NP9PEN/2+/7KzXrZ2huQsA67rTELw1YNg688keMW4zEE9BPFYI/cTXJtYjQBpCYMCew94V
	yKMO8kgdc1R+8SCF7nvVhfHRY/8O5r/fSb148Qe/N9lt1mlgwQAtSX50lJvABjuGSn9Yov
	EWraNa8nJMLQBLmphj9tydCuWrGP1AI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-v2S5QapNOVO93aWSAGyxMg-1; Tue, 05 Aug 2025 10:39:31 -0400
X-MC-Unique: v2S5QapNOVO93aWSAGyxMg-1
X-Mimecast-MFC-AGG-ID: v2S5QapNOVO93aWSAGyxMg_1754404771
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b08a2b3e83so9545251cf.3
        for <stable@vger.kernel.org>; Tue, 05 Aug 2025 07:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404771; x=1755009571;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osBUTD8AGmf3RzRhZE1d3AllWvZV7FgrCRdQPsKZtns=;
        b=T/J4X+lenjmCzdSIJSmaAm6OAOLouiW7lLg/kocPYHwTJNGC8K50qmXv92VlzMlS99
         Yp56WNdH3V2CTpnKf5uThcXHAQ3S0sVX1HFOCwfoWhnMJ0JQ9tFVTqg2dgZOu2QAha3K
         ykOY8/VQTLVHC4jXUUurNJLomk6xreu7IiCYFWHZEc42vciFn58a7RH6L7v7uIvAwM8b
         kmLAU6FQwfNAt481+xSlwtDuuVDayuEE6u+QRfuZv72lE36CJ2T33iU134X70GPzsOTT
         ASlnjToiFQmkS1HmQ7BV7ohYzV0a3qvLGlS8cOzbdpV6GaFJRZk4zGBs6f/Q5aJzl3qY
         mHUA==
X-Forwarded-Encrypted: i=1; AJvYcCUMv6j7SOyaJWqwkfPo3P6WRL55ydjY+iTo22cD5UtMC9PABqn0x3ddMeJGQD6+v/nv/uFEclY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvHy1nLH0xV2L+SE2WKFnTZB0x3Wam3R5Q1imR7gSfMjkNycP1
	fpj1Fc9/WFV9Ynq5tsiMeuPzxvzc/d5e/xsc9srr1fhzgnxp4+oZ9fjZXScPQ5wRMxFc4VyLaa8
	isX6Sp0MUQFbpmCSNj/US1xqW5mVUlF7ZLRLVU6OB+LfJevQjzhD6lOJAbw==
X-Gm-Gg: ASbGncs/iKH752bOA66Z3F675quPnjbFXyTokvpAo6wrLRyNc3muigYTjXmzeewRjzl
	1Pty4tZeX3/x8qdxfPKyllfKSm24+0FRF8KMrhRJV/wNGcB7qH3t1c4DU0xLs56WvDKrJ/Y75tG
	EC2OxdrrINplNmojFad332pbTXt0SAk5kI/kAsK1P2+1K6rdt4tOn9YZyLNlcH+aiPM3JtycH2u
	FcPCmbRwrJhRlh+OLA0zD9PEaMWvHUop7g1eq9z31eaZa6IvS2uK7utKAMDB7IoIgIY4/TMweum
	ig+ohYoIkxVeVEmh1kZSJaBPRHTGBNLm
X-Received: by 2002:a05:622a:341:b0:4b0:7372:1bcb with SMTP id d75a77b69052e-4b073722829mr97740941cf.15.1754404770515;
        Tue, 05 Aug 2025 07:39:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbzW4UiXSJV9RVR64B6UcBQaLqjWbfSx5kR9/jhgtO/J/1mSovc/gLubrthIt8BIT18R/6Yw==
X-Received: by 2002:a05:622a:341:b0:4b0:7372:1bcb with SMTP id d75a77b69052e-4b073722829mr97740261cf.15.1754404769737;
        Tue, 05 Aug 2025 07:39:29 -0700 (PDT)
Received: from x1.local ([174.89.135.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5c55a2sm685723885a.36.2025.08.05.07.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:39:28 -0700 (PDT)
Date: Tue, 5 Aug 2025 10:39:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	aarcange@redhat.com, lokeshgidra@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
Message-ID: <aJIXlN-ZD_soWdP0@x1.local>
References: <aIzMGlrR1SL5Y_Gp@x1.local>
 <CAJuCfpEqOUj8VPybstQjoJvCzyZtG6Q5Vr4WT0Lx_r3LFVS7og@mail.gmail.com>
 <aIzp6WqdzhomPhhf@x1.local>
 <CAJuCfpGWLnu+r2wvY2Egy2ESPD=tAVvfVvAKXUv1b+Z0hweeJg@mail.gmail.com>
 <aIz1xrzBc2Spa2OH@x1.local>
 <CAJuCfpFJGaDaFyNLa3JsVh19NWLGNGo1ebC_ijGTgPGNyfUFig@mail.gmail.com>
 <aI0Ffc9WXeU2X71O@x1.local>
 <CAJuCfpFSY3fDH36dabS=nGzasZJ6FtQ_jv79eFWVZrEWRMMTiQ@mail.gmail.com>
 <aI1ckD3KhNvoMtlv@x1.local>
 <CAJuCfpHcScutgGi3imYTJVXBqs=jcqZ5CkKKe=sfVHjUg0Y6RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHcScutgGi3imYTJVXBqs=jcqZ5CkKKe=sfVHjUg0Y6RQ@mail.gmail.com>

On Mon, Aug 04, 2025 at 07:55:42AM -0700, Suren Baghdasaryan wrote:
> On Fri, Aug 1, 2025 at 5:32 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Aug 01, 2025 at 07:30:02PM +0000, Suren Baghdasaryan wrote:
> > > On Fri, Aug 1, 2025 at 6:21 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Fri, Aug 01, 2025 at 05:45:10PM +0000, Suren Baghdasaryan wrote:
> > > > > On Fri, Aug 1, 2025 at 5:13 PM Peter Xu <peterx@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Aug 01, 2025 at 09:41:31AM -0700, Suren Baghdasaryan wrote:
> > > > > > > On Fri, Aug 1, 2025 at 9:23 AM Peter Xu <peterx@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Aug 01, 2025 at 08:28:38AM -0700, Suren Baghdasaryan wrote:
> > > > > > > > > On Fri, Aug 1, 2025 at 7:16 AM Peter Xu <peterx@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Aug 01, 2025 at 09:21:30AM +0200, David Hildenbrand wrote:
> > > > > > > > > > > On 31.07.25 17:44, Suren Baghdasaryan wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi!
> > > > > > > > > > >
> > > > > > > > > > > Did you mean in you patch description:
> > > > > > > > > > >
> > > > > > > > > > > "userfaultfd: fix a crash in UFFDIO_MOVE with some non-present PMDs"
> > > > > > > > > > >
> > > > > > > > > > > Talking about THP holes is very very confusing.
> > > > > > > > > > >
> > > > > > > > > > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> > > > > > > > > > > > encounters a non-present THP, it fails to properly recognize an unmapped
> > > > > > > > > > >
> > > > > > > > > > > You mean a "non-present PMD that is not a migration entry".
> > > > > > > > > > >
> > > > > > > > > > > > hole and tries to access a non-existent folio, resulting in
> > > > > > > > > > > > a crash. Add a check to skip non-present THPs.
> > > > > > > > > > >
> > > > > > > > > > > That makes sense. The code we have after this patch is rather complicated
> > > > > > > > > > > and hard to read.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > > > > > > > > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > > > > > > > > > > > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
> > > > > > > > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > > > > ---
> > > > > > > > > > > > Changes since v1 [1]
> > > > > > > > > > > > - Fixed step size calculation, per Lokesh Gidra
> > > > > > > > > > > > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokesh Gidra
> > > > > > > > > > > >
> > > > > > > > > > > > [1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@google.com/
> > > > > > > > > > > >
> > > > > > > > > > > >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
> > > > > > > > > > > >   1 file changed, 29 insertions(+), 16 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > > > > > > > > index cbed91b09640..b5af31c22731 100644
> > > > > > > > > > > > --- a/mm/userfaultfd.c
> > > > > > > > > > > > +++ b/mm/userfaultfd.c
> > > > > > > > > > > > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> > > > > > > > > > > >             ptl = pmd_trans_huge_lock(src_pmd, src_vma);
> > > > > > > > > > > >             if (ptl) {
> > > > > > > > > > > > -                   /* Check if we can move the pmd without splitting it. */
> > > > > > > > > > > > -                   if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > > > > > > > > > -                       !pmd_none(dst_pmdval)) {
> > > > > > > > > > > > -                           struct folio *folio = pmd_folio(*src_pmd);
> > > > > > > > > > > > +                   if (pmd_present(*src_pmd) || is_pmd_migration_entry(*src_pmd)) {
> > > > > > > > > >
> > > > > > > > > > [1]
> > > > > > > > > >
> > > > > > > > > > > > +                           /* Check if we can move the pmd without splitting it. */
> > > > > > > > > > > > +                           if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > > > > > > > > > +                               !pmd_none(dst_pmdval)) {
> > > > > > > > > > > > +                                   if (pmd_present(*src_pmd)) {
> > > > > > > >
> > > > > > > > [2]
> > > > > > > >
> > > > > > > > > > > > +                                           struct folio *folio = pmd_folio(*src_pmd);
> > > > > > > >
> > > > > > > > [3]
> > > > > > > >
> > > > > > > > > > > > +
> > > > > > > > > > > > +                                           if (!folio || (!is_huge_zero_folio(folio) &&
> > > > > > > > > > > > +                                                          !PageAnonExclusive(&folio->page))) {
> > > > > > > > > > > > +                                                   spin_unlock(ptl);
> > > > > > > > > > > > +                                                   err = -EBUSY;
> > > > > > > > > > > > +                                                   break;
> > > > > > > > > > > > +                                           }
> > > > > > > > > > > > +                                   }
> > > > > > > > > > >
> > > > > > > > > > > ... in particular that. Is there some way to make this code simpler / easier
> > > > > > > > > > > to read? Like moving that whole last folio-check thingy into a helper?
> > > > > > > > > >
> > > > > > > > > > One question might be relevant is, whether the check above [1] can be
> > > > > > > > > > dropped.
> > > > > > > > > >
> > > > > > > > > > The thing is __pmd_trans_huge_lock() does double check the pmd to be !none
> > > > > > > > > > before returning the ptl.  I didn't follow closely on the recent changes on
> > > > > > > > > > mm side on possible new pmd swap entries, if migration is the only possible
> > > > > > > > > > one then it looks like [1] can be avoided.
> > > > > > > > >
> > > > > > > > > Hi Peter,
> > > > > > > > > is_swap_pmd() check in __pmd_trans_huge_lock() allows for (!pmd_none()
> > > > > > > > > && !pmd_present()) PMD to pass and that's when this crash is hit.
> > > > > > > >
> > > > > > > > First for all, thanks for looking into the issue with Lokesh; I am still
> > > > > > > > catching up with emails after taking weeks off.
> > > > > > > >
> > > > > > > > I didn't yet read into the syzbot report, but I thought the bug was about
> > > > > > > > referencing the folio on top of a swap entry after reading your current
> > > > > > > > patch, which has:
> > > > > > > >
> > > > > > > >         if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > > > > >             !pmd_none(dst_pmdval)) {
> > > > > > > >                 struct folio *folio = pmd_folio(*src_pmd); <----
> > > > > > > >
> > > > > > > > Here looks like *src_pmd can be a migration entry. Is my understanding
> > > > > > > > correct?
> > > > > > >
> > > > > > > Correct.
> > > > > > >
> > > > > > > >
> > > > > > > > > If we drop the check at [1] then the path that takes us to
> > > > > > > >
> > > > > > > > If my above understanding is correct, IMHO it should be [2] above that
> > > > > > > > makes sure the reference won't happen on a swap entry, not necessarily [1]?
> > > > > > >
> > > > > > > Yes, in case of migration entry this is what protects us.
> > > > > > >
> > > > > > > >
> > > > > > > > > split_huge_pmd() will bail out inside split_huge_pmd_locked() with no
> > > > > > > > > indication that split did not happen. Afterwards we will retry
> > > > > > > >
> > > > > > > > So we're talking about the case where it's a swap pmd entry, right?
> > > > > > >
> > > > > > > Hmm, my understanding is that it's being treated as a swap entry but
> > > > > > > in reality is not. I thought THPs are always split before they get
> > > > > > > swapped, no?
> > > > > >
> > > > > > Yes they should be split, afaiu.
> > > > > >
> > > > > > >
> > > > > > > > Could you elaborate why the split would fail?
> > > > > > >
> > > > > > > Just looking at the code, split_huge_pmd_locked() checks for
> > > > > > > (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd)).
> > > > > > > pmd_trans_huge() is false if !pmd_present() and it's not a migration
> > > > > > > entry, so __split_huge_pmd_locked() will be skipped.
> > > > > >
> > > > > > Here might be the major part of where confusion came from: I thought it
> > > > > > must be a migration pmd entry to hit the issue, so it's not?
> > > > > >
> > > > > > I checked the code just now:
> > > > > >
> > > > > > __handle_mm_fault:
> > > > > >                 if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
> > > > > >                         VM_BUG_ON(thp_migration_supported() &&
> > > > > >                                           !is_pmd_migration_entry(vmf.orig_pmd));
> > > > > >
> > > > > > So IIUC pmd migration entry is still the only possible way to have a swap
> > > > > > entry.  It doesn't look like we have "real" swap entries for PMD (which can
> > > > > > further points to some swapfiles)?
> > > > >
> > > > > Correct. AFAIU here we stumble on a pmd entry which was allocated but
> > > > > never populated.
> > > >
> > > > Do you mean a pmd_none()?
> > >
> > > Yes.
> > >
> > > >
> > > > If so, that goes back to my original question, on why
> > > > __pmd_trans_huge_lock() returns non-NULL if it's a pmd_none()?  IMHO it
> > > > really should have returned NULL for pmd_none().
> > >
> > > That was exactly the answer I gave Lokesh when he theorized about the
> > > cause of this crash but after reproducing it I saw that
> > > pmd_trans_huge_lock() happily returns the PTL as long as PMD is not
> > > pmd_none(). And that's because it passes as is_swap_pmd(). But even if
> > > we change that we still need to implement the code to skip the entire
> > > PMD.
> >
> > The thing is I thought if pmd_trans_huge_lock() can return non-NULL, it
> > must be either a migration entry or a present THP. So are you describing a
> > THP but with present bit cleared?  Do you know what is that entry, and why
> > it has present bit cleared?
> 
> In this case it's because earlier we allocated that PMD here:
> https://elixir.bootlin.com/linux/v6.16/source/mm/userfaultfd.c#L1797

AFAIU, this line is not about allocation of any pmd entry, but the pmd
pgtable page that _holds_ the PMDs:

static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
{
	return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, address))?
		NULL: pmd_offset(pud, address);
}

It makes sure the PUD entry, not the PMD entry, be populated.

> but wouldn't that be the same if the PMD was mapped and then got
> unmapped later? My understanding is that we allocate the PMD at the
> line I pointed to make UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES case the same
> as this unmapped PMD case. If my assumption is incorrect then we could
> skip the hole earlier instead of allocating the PMD for it.
> 
> >
> > I think my attention got attracted to pmd migration entry too much, so I
> > didn't really notice such possibility, as I believe migration pmd is broken
> > already in this path.
> >
> > The original code:
> >
> >                 ptl = pmd_trans_huge_lock(src_pmd, src_vma);
> >                 if (ptl) {
> >                         /* Check if we can move the pmd without splitting it. */
> >                         if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> >                             !pmd_none(dst_pmdval)) {
> >                                 struct folio *folio = pmd_folio(*src_pmd);
> >
> >                                 if (!folio || (!is_huge_zero_folio(folio) &&
> >                                                !PageAnonExclusive(&folio->page))) {
> >                                         spin_unlock(ptl);
> >                                         err = -EBUSY;
> >                                         break;
> >                                 }
> >
> >                                 spin_unlock(ptl);
> >                                 split_huge_pmd(src_vma, src_pmd, src_addr);
> >                                 /* The folio will be split by move_pages_pte() */
> >                                 continue;
> >                         }
> >
> >                         err = move_pages_huge_pmd(mm, dst_pmd, src_pmd,
> >                                                   dst_pmdval, dst_vma, src_vma,
> >                                                   dst_addr, src_addr);
> >                         step_size = HPAGE_PMD_SIZE;
> >                 } else {
> >
> > It'll get ptl for a migration pmd, then pmd_folio is risky without checking
> > present bit.  That's what my previous smaller patch wanted to fix.
> >
> > But besides that, IIUC it's all fine at least for a pmd migration entry,
> > because when with the smaller patch applied, either we'll try to split the
> > pmd migration entry, or we'll do move_pages_huge_pmd(), which internally
> > handles the pmd migration entry too by waiting on it:
> >
> >         if (!pmd_trans_huge(src_pmdval)) {
> >                 spin_unlock(src_ptl);
> >                 if (is_pmd_migration_entry(src_pmdval)) {
> >                         pmd_migration_entry_wait(mm, &src_pmdval);
> >                         return -EAGAIN;
> >                 }
> >                 return -ENOENT;
> >         }
> >
> > Then logically after the migration entry got recovered, we'll either see a
> > real THP or pmd none next time.
> 
> Yes, for migration entries adding the "if (pmd_present(*src_pmd))"
> before getting the folio is enough. The problematic case is
> (!pmd_none(*src_pmd) && !pmd_present(*src_pmd)) and not a migration
> entry.

I thought we could have any of below here on the pmd entry:

  (0) pmd_none, which should constantly have pmd_trans_huge_lock -> NULL

  (1) pmd pgtable entry, which must have PRESENT && !TRANS, so
  pmd_trans_huge_lock -> NULL,

  (2) pmd migration, pmd_trans_huge_lock -> valid

  (3) pmd thp, pmd_trans_huge_lock -> valid

I thought (2) was broken, which we seem to agree upon.. however if so the
smaller patch should fix it, per explanation in my previous reply.  OTOH I
can't think of (4).

Said that, I just noticed (3) can be broken as well - could it be a
prot_none entry?  The very confusing part of this patch is it seems to
think it's pmd_none() here as holes:

	if (pmd_present(*src_pmd) || is_pmd_migration_entry(*src_pmd)) {
                ...
	} else {
		spin_unlock(ptl);
		if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {
			err = -ENOENT;
			break;
		}
		/* nothing to do to move a hole */
		err = 0;
		step_size = min(HPAGE_PMD_SIZE, src_start + len - src_addr);
	}

But is it really?  Again, I don't think pmd_none() could happen with
pmd_trans_huge_lock() returning the ptl.

Could you double check this?  E.g. with this line if that makes sense to
you:

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 8bf8ff0be990f..d2d4f2a0ae69f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1903,6 +1903,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
                                                          dst_addr, src_addr);
                                step_size = HPAGE_PMD_SIZE;
                        } else {
+                               BUG_ON(!pmd_none(*src_pmd));
                                spin_unlock(ptl);
                                if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {
                                        err = -ENOENT;

I would expect it constantly BUG() here, if that explains my thoughts.

Now I doubt it's a prot_none THP.. aka, a THP that got numa hint to be
moved.  If so, we may need to process it / move it / .. but we likely
should never skip it.  We can double check the buggy pmd entry you hit
(besides migration entry) first.

Thanks,

-- 
Peter Xu


