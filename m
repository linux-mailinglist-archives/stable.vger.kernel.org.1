Return-Path: <stable+bounces-165788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C82B189EE
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 02:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F77C188C96B
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 00:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB72629F;
	Sat,  2 Aug 2025 00:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZxQIa8H"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B7B1CF96
	for <stable@vger.kernel.org>; Sat,  2 Aug 2025 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754094755; cv=none; b=JJxTMLEIi2nGQlRg89yGXr7tb5lGaHUg0x2xlAu89qS7SozpGarJRIEgxU9701+WcwIknQeeKe+4NS1h3N7cVrFoZowAWgI0ZEvyI1dilU3qscqJnD7u3MuMGtEcA0X5j21IsqPvr/uL2dN/yNdDklAmAO+uNSqe9BRVYZb02XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754094755; c=relaxed/simple;
	bh=zoftsT9FOd6RuoHAW3H90z45JFNLZfOlT0X6Gnq1ie4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wk4FFmA46RoR5A/U1USavj6z5wesb/noPFR8wo5LRLcoa3Dq2fJWLa2zOmBPmgRhzEiYtyxQlIuNvix/4wl+g0eL3+o9tq7so2yn+h/wvxWXAyv741Ue7cKkUQ59ZLII7WXxk74Z0nvu9Cp7t5JALwLq933rPzpg5rj+p9Ilen0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZxQIa8H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754094752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2kHJlrQseChL3F3Lej9Uklzvin/23o+r6QXAoYU51E=;
	b=AZxQIa8HA6LOtvsgblsbO3Xoc37XAqd52bGUAQJJbOaSZhNm1Bt8uGNkwFRkbJsbdeoIQL
	Om+fsLHbbe1cx6COrzxiu3zR6dleCvz+Un8LIhWxbPjSAzZGwlWqOIimOIRFb4eAnaCiAD
	NS8YJpxOh61ykrKMLkBxEjXnhGu3BDU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-a3UyncbtOveGvCkpzQytjg-1; Fri, 01 Aug 2025 20:32:31 -0400
X-MC-Unique: a3UyncbtOveGvCkpzQytjg-1
X-Mimecast-MFC-AGG-ID: a3UyncbtOveGvCkpzQytjg_1754094750
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e698c12c3eso21530485a.0
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 17:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754094750; x=1754699550;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2kHJlrQseChL3F3Lej9Uklzvin/23o+r6QXAoYU51E=;
        b=DUYZXLWYUXdqG9yd4i4VrhI6WMAyOJe6BnNcZKw4lL1DqfhE8Jk2wqrUK91OAibMmy
         8VmzHoRka6Z+Inc8wfhcYaMcnuwAyBHi51jOcHS6o1xzRk8Q2XmItwBVP41vHDYjXAMu
         VmA88qdYQLawuLNc7cUiqkiwyNcdtIQtb72Dtsi3ag9q6fmeYg21UmRdkqTpD/hPPj5k
         KorXkr6oOCmcGZ+enjfV7ZD7qMwsRmSoZsbln/YjaKJAfrREnMQQqxdARWW6WCHQz+zW
         eSGC0Q6cLlgDFHXstDGnxMEqX43vD3jMqRzMS52yi1mGAf0gZ6teSQyqefdlfp2VzfIE
         tAdg==
X-Forwarded-Encrypted: i=1; AJvYcCWCrc/KjRtiuCFgIl4e7cMeaPH+tEa5mU/gAe5hJaPyfRNtEX2vHwIcrN18qkgsdrtfa0YLN+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGkpWKp3iB1kAuVqEJhrGGPaGSfa+jgDJBpZEKw7FV16iZ8eLr
	wXK12YRSxBxgXx3bpbhJ02J5GPJwB8oBd7uZQuMamACO/aFJAt8mPEWJye19PjQaDgtoC97FFgv
	+bKm6cMDWM3ysYjcYAbB1zVgrrOJtqWkFGNGKN/1hZRIs3GWjc4F+tUYCbw==
X-Gm-Gg: ASbGncv9ZVDeWd+jYB4+Q7WhqgKLAyTm/YYpZEPAemFMhZUwrcTx9zFeKZqgHyYtNB5
	LaRJ4PAiqln9eURjWVgPVPPoARDFAX8mQsV5U6Cq1wD2Bpd/4kAUsLYjalRh5NwqMOMXnF5gX+m
	TLb+N1gdN8DvvnbipE7gOfDL+sHH4whnIBI5SURqabAigggffAMZDciUxrtUQIPoOqU5P7WqyRY
	uks3MJdlzukY0P6Slf3//+TsT5Ztwtr0rZ/33B/AqTcY2javKx2DEoFFcNLVaOrNNhwyeFigv+e
	fxdTyfSugMWDTQl2K/Zc4f/iFAqsfdYd
X-Received: by 2002:a05:622a:424e:b0:4af:23a:4d8f with SMTP id d75a77b69052e-4af1094bb33mr29893761cf.1.1754094750237;
        Fri, 01 Aug 2025 17:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcyIfCLQARG8ajrAkxw6gecilHP9OwpIaR2rAKxNNqso1ts3GOWxdhyD6yzWs4HO8O8IpDiQ==
X-Received: by 2002:a05:622a:424e:b0:4af:23a:4d8f with SMTP id d75a77b69052e-4af1094bb33mr29893491cf.1.1754094749728;
        Fri, 01 Aug 2025 17:32:29 -0700 (PDT)
Received: from x1.local ([174.89.135.171])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeec005c2sm25861691cf.16.2025.08.01.17.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 17:32:28 -0700 (PDT)
Date: Fri, 1 Aug 2025 20:32:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	aarcange@redhat.com, lokeshgidra@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
Message-ID: <aI1ckD3KhNvoMtlv@x1.local>
References: <20250731154442.319568-1-surenb@google.com>
 <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
 <aIzMGlrR1SL5Y_Gp@x1.local>
 <CAJuCfpEqOUj8VPybstQjoJvCzyZtG6Q5Vr4WT0Lx_r3LFVS7og@mail.gmail.com>
 <aIzp6WqdzhomPhhf@x1.local>
 <CAJuCfpGWLnu+r2wvY2Egy2ESPD=tAVvfVvAKXUv1b+Z0hweeJg@mail.gmail.com>
 <aIz1xrzBc2Spa2OH@x1.local>
 <CAJuCfpFJGaDaFyNLa3JsVh19NWLGNGo1ebC_ijGTgPGNyfUFig@mail.gmail.com>
 <aI0Ffc9WXeU2X71O@x1.local>
 <CAJuCfpFSY3fDH36dabS=nGzasZJ6FtQ_jv79eFWVZrEWRMMTiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFSY3fDH36dabS=nGzasZJ6FtQ_jv79eFWVZrEWRMMTiQ@mail.gmail.com>

On Fri, Aug 01, 2025 at 07:30:02PM +0000, Suren Baghdasaryan wrote:
> On Fri, Aug 1, 2025 at 6:21 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Aug 01, 2025 at 05:45:10PM +0000, Suren Baghdasaryan wrote:
> > > On Fri, Aug 1, 2025 at 5:13 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Fri, Aug 01, 2025 at 09:41:31AM -0700, Suren Baghdasaryan wrote:
> > > > > On Fri, Aug 1, 2025 at 9:23 AM Peter Xu <peterx@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Aug 01, 2025 at 08:28:38AM -0700, Suren Baghdasaryan wrote:
> > > > > > > On Fri, Aug 1, 2025 at 7:16 AM Peter Xu <peterx@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Aug 01, 2025 at 09:21:30AM +0200, David Hildenbrand wrote:
> > > > > > > > > On 31.07.25 17:44, Suren Baghdasaryan wrote:
> > > > > > > > >
> > > > > > > > > Hi!
> > > > > > > > >
> > > > > > > > > Did you mean in you patch description:
> > > > > > > > >
> > > > > > > > > "userfaultfd: fix a crash in UFFDIO_MOVE with some non-present PMDs"
> > > > > > > > >
> > > > > > > > > Talking about THP holes is very very confusing.
> > > > > > > > >
> > > > > > > > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> > > > > > > > > > encounters a non-present THP, it fails to properly recognize an unmapped
> > > > > > > > >
> > > > > > > > > You mean a "non-present PMD that is not a migration entry".
> > > > > > > > >
> > > > > > > > > > hole and tries to access a non-existent folio, resulting in
> > > > > > > > > > a crash. Add a check to skip non-present THPs.
> > > > > > > > >
> > > > > > > > > That makes sense. The code we have after this patch is rather complicated
> > > > > > > > > and hard to read.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > > > > > > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > > > > > > > > > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
> > > > > > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > > ---
> > > > > > > > > > Changes since v1 [1]
> > > > > > > > > > - Fixed step size calculation, per Lokesh Gidra
> > > > > > > > > > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokesh Gidra
> > > > > > > > > >
> > > > > > > > > > [1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@google.com/
> > > > > > > > > >
> > > > > > > > > >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
> > > > > > > > > >   1 file changed, 29 insertions(+), 16 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > > > > > > index cbed91b09640..b5af31c22731 100644
> > > > > > > > > > --- a/mm/userfaultfd.c
> > > > > > > > > > +++ b/mm/userfaultfd.c
> > > > > > > > > > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> > > > > > > > > >             ptl = pmd_trans_huge_lock(src_pmd, src_vma);
> > > > > > > > > >             if (ptl) {
> > > > > > > > > > -                   /* Check if we can move the pmd without splitting it. */
> > > > > > > > > > -                   if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > > > > > > > -                       !pmd_none(dst_pmdval)) {
> > > > > > > > > > -                           struct folio *folio = pmd_folio(*src_pmd);
> > > > > > > > > > +                   if (pmd_present(*src_pmd) || is_pmd_migration_entry(*src_pmd)) {
> > > > > > > >
> > > > > > > > [1]
> > > > > > > >
> > > > > > > > > > +                           /* Check if we can move the pmd without splitting it. */
> > > > > > > > > > +                           if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > > > > > > > +                               !pmd_none(dst_pmdval)) {
> > > > > > > > > > +                                   if (pmd_present(*src_pmd)) {
> > > > > >
> > > > > > [2]
> > > > > >
> > > > > > > > > > +                                           struct folio *folio = pmd_folio(*src_pmd);
> > > > > >
> > > > > > [3]
> > > > > >
> > > > > > > > > > +
> > > > > > > > > > +                                           if (!folio || (!is_huge_zero_folio(folio) &&
> > > > > > > > > > +                                                          !PageAnonExclusive(&folio->page))) {
> > > > > > > > > > +                                                   spin_unlock(ptl);
> > > > > > > > > > +                                                   err = -EBUSY;
> > > > > > > > > > +                                                   break;
> > > > > > > > > > +                                           }
> > > > > > > > > > +                                   }
> > > > > > > > >
> > > > > > > > > ... in particular that. Is there some way to make this code simpler / easier
> > > > > > > > > to read? Like moving that whole last folio-check thingy into a helper?
> > > > > > > >
> > > > > > > > One question might be relevant is, whether the check above [1] can be
> > > > > > > > dropped.
> > > > > > > >
> > > > > > > > The thing is __pmd_trans_huge_lock() does double check the pmd to be !none
> > > > > > > > before returning the ptl.  I didn't follow closely on the recent changes on
> > > > > > > > mm side on possible new pmd swap entries, if migration is the only possible
> > > > > > > > one then it looks like [1] can be avoided.
> > > > > > >
> > > > > > > Hi Peter,
> > > > > > > is_swap_pmd() check in __pmd_trans_huge_lock() allows for (!pmd_none()
> > > > > > > && !pmd_present()) PMD to pass and that's when this crash is hit.
> > > > > >
> > > > > > First for all, thanks for looking into the issue with Lokesh; I am still
> > > > > > catching up with emails after taking weeks off.
> > > > > >
> > > > > > I didn't yet read into the syzbot report, but I thought the bug was about
> > > > > > referencing the folio on top of a swap entry after reading your current
> > > > > > patch, which has:
> > > > > >
> > > > > >         if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > > >             !pmd_none(dst_pmdval)) {
> > > > > >                 struct folio *folio = pmd_folio(*src_pmd); <----
> > > > > >
> > > > > > Here looks like *src_pmd can be a migration entry. Is my understanding
> > > > > > correct?
> > > > >
> > > > > Correct.
> > > > >
> > > > > >
> > > > > > > If we drop the check at [1] then the path that takes us to
> > > > > >
> > > > > > If my above understanding is correct, IMHO it should be [2] above that
> > > > > > makes sure the reference won't happen on a swap entry, not necessarily [1]?
> > > > >
> > > > > Yes, in case of migration entry this is what protects us.
> > > > >
> > > > > >
> > > > > > > split_huge_pmd() will bail out inside split_huge_pmd_locked() with no
> > > > > > > indication that split did not happen. Afterwards we will retry
> > > > > >
> > > > > > So we're talking about the case where it's a swap pmd entry, right?
> > > > >
> > > > > Hmm, my understanding is that it's being treated as a swap entry but
> > > > > in reality is not. I thought THPs are always split before they get
> > > > > swapped, no?
> > > >
> > > > Yes they should be split, afaiu.
> > > >
> > > > >
> > > > > > Could you elaborate why the split would fail?
> > > > >
> > > > > Just looking at the code, split_huge_pmd_locked() checks for
> > > > > (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd)).
> > > > > pmd_trans_huge() is false if !pmd_present() and it's not a migration
> > > > > entry, so __split_huge_pmd_locked() will be skipped.
> > > >
> > > > Here might be the major part of where confusion came from: I thought it
> > > > must be a migration pmd entry to hit the issue, so it's not?
> > > >
> > > > I checked the code just now:
> > > >
> > > > __handle_mm_fault:
> > > >                 if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
> > > >                         VM_BUG_ON(thp_migration_supported() &&
> > > >                                           !is_pmd_migration_entry(vmf.orig_pmd));
> > > >
> > > > So IIUC pmd migration entry is still the only possible way to have a swap
> > > > entry.  It doesn't look like we have "real" swap entries for PMD (which can
> > > > further points to some swapfiles)?
> > >
> > > Correct. AFAIU here we stumble on a pmd entry which was allocated but
> > > never populated.
> >
> > Do you mean a pmd_none()?
> 
> Yes.
> 
> >
> > If so, that goes back to my original question, on why
> > __pmd_trans_huge_lock() returns non-NULL if it's a pmd_none()?  IMHO it
> > really should have returned NULL for pmd_none().
> 
> That was exactly the answer I gave Lokesh when he theorized about the
> cause of this crash but after reproducing it I saw that
> pmd_trans_huge_lock() happily returns the PTL as long as PMD is not
> pmd_none(). And that's because it passes as is_swap_pmd(). But even if
> we change that we still need to implement the code to skip the entire
> PMD.

The thing is I thought if pmd_trans_huge_lock() can return non-NULL, it
must be either a migration entry or a present THP. So are you describing a
THP but with present bit cleared?  Do you know what is that entry, and why
it has present bit cleared?

I think my attention got attracted to pmd migration entry too much, so I
didn't really notice such possibility, as I believe migration pmd is broken
already in this path.

The original code:

		ptl = pmd_trans_huge_lock(src_pmd, src_vma);
		if (ptl) {
			/* Check if we can move the pmd without splitting it. */
			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
			    !pmd_none(dst_pmdval)) {
				struct folio *folio = pmd_folio(*src_pmd);

				if (!folio || (!is_huge_zero_folio(folio) &&
					       !PageAnonExclusive(&folio->page))) {
					spin_unlock(ptl);
					err = -EBUSY;
					break;
				}

				spin_unlock(ptl);
				split_huge_pmd(src_vma, src_pmd, src_addr);
				/* The folio will be split by move_pages_pte() */
				continue;
			}

			err = move_pages_huge_pmd(mm, dst_pmd, src_pmd,
						  dst_pmdval, dst_vma, src_vma,
						  dst_addr, src_addr);
			step_size = HPAGE_PMD_SIZE;
		} else {

It'll get ptl for a migration pmd, then pmd_folio is risky without checking
present bit.  That's what my previous smaller patch wanted to fix.

But besides that, IIUC it's all fine at least for a pmd migration entry,
because when with the smaller patch applied, either we'll try to split the
pmd migration entry, or we'll do move_pages_huge_pmd(), which internally
handles the pmd migration entry too by waiting on it:

	if (!pmd_trans_huge(src_pmdval)) {
		spin_unlock(src_ptl);
		if (is_pmd_migration_entry(src_pmdval)) {
			pmd_migration_entry_wait(mm, &src_pmdval);
			return -EAGAIN;
		}
		return -ENOENT;
	}

Then logically after the migration entry got recovered, we'll either see a
real THP or pmd none next time.

Some explanation on the problematic non-present THP entry would be helpful.

Thanks,

-- 
Peter Xu


