Return-Path: <stable+bounces-165764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADDEB18745
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 20:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63EBB582968
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 18:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09261F12FB;
	Fri,  1 Aug 2025 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTCKRyCz"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C67F16FF44
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072470; cv=none; b=FKtJjBp914qudQn2wispkLZQRoi1g/ToalSDkeMCBn3QVnEMjtm7yfjez4TSPtlGD+X2V9btSm76K/37RQxagA9thkW1LnVkPNxXg8S7nlLoHrlBDnGwHwTZWeKIBRECju5m/z6QtHLTKHpxEOsrZ6sYfYS++JDw7zwoghPVkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072470; c=relaxed/simple;
	bh=ZyhKLAXPVem8Lwhg/0x9FEtKYTT6fl9Yd/aQVwsfu4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGyMnI+vLGD5QfAhKr+20bBveVJICsD9EJRSJBPaKXHRcd0a2W2//zHnnggXXDmD1hvzNRo5i9Wp/yiNdwZMvs9CUVlkL3xfSR/ZJ+8Ww4IpI9jmcU6q+nsdRHUaHqMMDEcSxfPu/r7/NyL/gsVjNDy9jgcwAOlH5gtcH0jMRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTCKRyCz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754072467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2g39l8sL+vMNhyKGrd5r0iuwpLk0Okh6OkF+13JKUXU=;
	b=KTCKRyCzlN2mPP7BCcsqzuh7PbfhshLzlcsciQM0QHHUYihqmAo9wBnMJvbHvEQIUlI23C
	0bRKaRV9fqNTc1N/gyeAmhFqThAudH4vw7xTsZx6c0zPuf/sjXN5e8LPufIt4txJc+YfR5
	TS83s20nvCU7dBUMxQZTE+lM5gkiGOI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-v0pRcr1VNG25s8cRPY-APw-1; Fri, 01 Aug 2025 14:21:06 -0400
X-MC-Unique: v0pRcr1VNG25s8cRPY-APw-1
X-Mimecast-MFC-AGG-ID: v0pRcr1VNG25s8cRPY-APw_1754072465
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7073a5f61a6so21043426d6.0
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 11:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754072465; x=1754677265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2g39l8sL+vMNhyKGrd5r0iuwpLk0Okh6OkF+13JKUXU=;
        b=UmWzaKIwui1mHNTfvhpVom2pPreQCGzL0yHa+QRMYMdueL41x/TleM5SkOBMtWRTjg
         OPTTz+ZSJBdbw8HvNViDlfAaGKFRaVRm7MnSuTNiuTvE+LMKEtNQhuQGCQfCBx28SmWH
         Fwh61t4b36+uaFwMqypEkD/pFTFB7/H8Rz37i+Pm8/jtZ+eWOCnOub99KR42KZOXCEeM
         tRn0ynFg9jsKx8JQWJyavZLoTyWa0d29u9lyAsrdSMiE9IEUmPEF1Ifl+ibLy1hrQq+9
         zADT1LSex5bS81Sycp7rpHhtqRrX9raM1gjZI2YRJKUfBNDCk8RbveGy/81AYU6IZ+OX
         Otew==
X-Forwarded-Encrypted: i=1; AJvYcCVNPrfnW5HIFOWwzqT4412qNRKsRQu9UsIb3ZDvih4ywLcidCc8wwjZ3bvRTs1wlVknudS1NsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsPk4518jFJbLLOY+Gv9Fpf1c7vHHLi6vYE0Nhc3vuLyvXBj9F
	UiU4+CKKNdRrIqiqlrzQOPqqUaIjt4aXamUVmJA+e/7mYd1HPxK/g1q6/JtXHvV0zsXINgdVWbo
	nJepcS6M5Xq1yBHEXgRbNPIPNhaBOtd3VUPnfcnDt1mwYJ9XDd8J2GriYow==
X-Gm-Gg: ASbGncvyVXQggqK3KJ/HQf8uBJxfuziMmrU9DvE8gpuP82aCygL1Nq19EVv6nobbYm5
	glDzz9QerxmgnDGYdI0ugu+3hWbIyfQL9THuqDgjuokEJGs6zD1qS2DMQEISpO0BuLvuDSjiJBe
	CkwzZtlTJldG+lBs4I8fCU1lxuXnefL+NwQASBahZgUJlRKWxn54Nk9cumI2BG2F/48Tt/dGSDj
	5iOS2kb0qhOr4nDB+fyDitedl6BFSIrd9UD1o/wRNGuvoBxr3OQX9BH2COwydKbPI2QXAipvIWg
	/BVIotUcvKAvRUkBD8uaZbH4PiArRbDS
X-Received: by 2002:ad4:5e88:0:b0:707:5ccb:6c4 with SMTP id 6a1803df08f44-7093633522bmr10005836d6.49.1754072465232;
        Fri, 01 Aug 2025 11:21:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJHvaY504H4W8dqLVRQkrI3AZzsoZBUQlKebveXmIXu7VcAHN9hG/HeWlxIkI0yMFKMrPIQA==
X-Received: by 2002:ad4:5e88:0:b0:707:5ccb:6c4 with SMTP id 6a1803df08f44-7093633522bmr10005226d6.49.1754072464631;
        Fri, 01 Aug 2025 11:21:04 -0700 (PDT)
Received: from x1.local ([174.89.135.171])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeed62d1fsm22935171cf.41.2025.08.01.11.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 11:21:04 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:20:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	aarcange@redhat.com, lokeshgidra@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
Message-ID: <aI0Ffc9WXeU2X71O@x1.local>
References: <20250731154442.319568-1-surenb@google.com>
 <d2b6be85-44d5-4a87-bfe5-4a9e80f95bb8@redhat.com>
 <aIzMGlrR1SL5Y_Gp@x1.local>
 <CAJuCfpEqOUj8VPybstQjoJvCzyZtG6Q5Vr4WT0Lx_r3LFVS7og@mail.gmail.com>
 <aIzp6WqdzhomPhhf@x1.local>
 <CAJuCfpGWLnu+r2wvY2Egy2ESPD=tAVvfVvAKXUv1b+Z0hweeJg@mail.gmail.com>
 <aIz1xrzBc2Spa2OH@x1.local>
 <CAJuCfpFJGaDaFyNLa3JsVh19NWLGNGo1ebC_ijGTgPGNyfUFig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFJGaDaFyNLa3JsVh19NWLGNGo1ebC_ijGTgPGNyfUFig@mail.gmail.com>

On Fri, Aug 01, 2025 at 05:45:10PM +0000, Suren Baghdasaryan wrote:
> On Fri, Aug 1, 2025 at 5:13 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Aug 01, 2025 at 09:41:31AM -0700, Suren Baghdasaryan wrote:
> > > On Fri, Aug 1, 2025 at 9:23 AM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Fri, Aug 01, 2025 at 08:28:38AM -0700, Suren Baghdasaryan wrote:
> > > > > On Fri, Aug 1, 2025 at 7:16 AM Peter Xu <peterx@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Aug 01, 2025 at 09:21:30AM +0200, David Hildenbrand wrote:
> > > > > > > On 31.07.25 17:44, Suren Baghdasaryan wrote:
> > > > > > >
> > > > > > > Hi!
> > > > > > >
> > > > > > > Did you mean in you patch description:
> > > > > > >
> > > > > > > "userfaultfd: fix a crash in UFFDIO_MOVE with some non-present PMDs"
> > > > > > >
> > > > > > > Talking about THP holes is very very confusing.
> > > > > > >
> > > > > > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> > > > > > > > encounters a non-present THP, it fails to properly recognize an unmapped
> > > > > > >
> > > > > > > You mean a "non-present PMD that is not a migration entry".
> > > > > > >
> > > > > > > > hole and tries to access a non-existent folio, resulting in
> > > > > > > > a crash. Add a check to skip non-present THPs.
> > > > > > >
> > > > > > > That makes sense. The code we have after this patch is rather complicated
> > > > > > > and hard to read.
> > > > > > >
> > > > > > > >
> > > > > > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> > > > > > > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
> > > > > > > > Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
> > > > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > ---
> > > > > > > > Changes since v1 [1]
> > > > > > > > - Fixed step size calculation, per Lokesh Gidra
> > > > > > > > - Added missing check for UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES, per Lokesh Gidra
> > > > > > > >
> > > > > > > > [1] https://lore.kernel.org/all/20250730170733.3829267-1-surenb@google.com/
> > > > > > > >
> > > > > > > >   mm/userfaultfd.c | 45 +++++++++++++++++++++++++++++----------------
> > > > > > > >   1 file changed, 29 insertions(+), 16 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > > > > > index cbed91b09640..b5af31c22731 100644
> > > > > > > > --- a/mm/userfaultfd.c
> > > > > > > > +++ b/mm/userfaultfd.c
> > > > > > > > @@ -1818,28 +1818,41 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> > > > > > > >             ptl = pmd_trans_huge_lock(src_pmd, src_vma);
> > > > > > > >             if (ptl) {
> > > > > > > > -                   /* Check if we can move the pmd without splitting it. */
> > > > > > > > -                   if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > > > > > -                       !pmd_none(dst_pmdval)) {
> > > > > > > > -                           struct folio *folio = pmd_folio(*src_pmd);
> > > > > > > > +                   if (pmd_present(*src_pmd) || is_pmd_migration_entry(*src_pmd)) {
> > > > > >
> > > > > > [1]
> > > > > >
> > > > > > > > +                           /* Check if we can move the pmd without splitting it. */
> > > > > > > > +                           if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > > > > > +                               !pmd_none(dst_pmdval)) {
> > > > > > > > +                                   if (pmd_present(*src_pmd)) {
> > > >
> > > > [2]
> > > >
> > > > > > > > +                                           struct folio *folio = pmd_folio(*src_pmd);
> > > >
> > > > [3]
> > > >
> > > > > > > > +
> > > > > > > > +                                           if (!folio || (!is_huge_zero_folio(folio) &&
> > > > > > > > +                                                          !PageAnonExclusive(&folio->page))) {
> > > > > > > > +                                                   spin_unlock(ptl);
> > > > > > > > +                                                   err = -EBUSY;
> > > > > > > > +                                                   break;
> > > > > > > > +                                           }
> > > > > > > > +                                   }
> > > > > > >
> > > > > > > ... in particular that. Is there some way to make this code simpler / easier
> > > > > > > to read? Like moving that whole last folio-check thingy into a helper?
> > > > > >
> > > > > > One question might be relevant is, whether the check above [1] can be
> > > > > > dropped.
> > > > > >
> > > > > > The thing is __pmd_trans_huge_lock() does double check the pmd to be !none
> > > > > > before returning the ptl.  I didn't follow closely on the recent changes on
> > > > > > mm side on possible new pmd swap entries, if migration is the only possible
> > > > > > one then it looks like [1] can be avoided.
> > > > >
> > > > > Hi Peter,
> > > > > is_swap_pmd() check in __pmd_trans_huge_lock() allows for (!pmd_none()
> > > > > && !pmd_present()) PMD to pass and that's when this crash is hit.
> > > >
> > > > First for all, thanks for looking into the issue with Lokesh; I am still
> > > > catching up with emails after taking weeks off.
> > > >
> > > > I didn't yet read into the syzbot report, but I thought the bug was about
> > > > referencing the folio on top of a swap entry after reading your current
> > > > patch, which has:
> > > >
> > > >         if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
> > > >             !pmd_none(dst_pmdval)) {
> > > >                 struct folio *folio = pmd_folio(*src_pmd); <----
> > > >
> > > > Here looks like *src_pmd can be a migration entry. Is my understanding
> > > > correct?
> > >
> > > Correct.
> > >
> > > >
> > > > > If we drop the check at [1] then the path that takes us to
> > > >
> > > > If my above understanding is correct, IMHO it should be [2] above that
> > > > makes sure the reference won't happen on a swap entry, not necessarily [1]?
> > >
> > > Yes, in case of migration entry this is what protects us.
> > >
> > > >
> > > > > split_huge_pmd() will bail out inside split_huge_pmd_locked() with no
> > > > > indication that split did not happen. Afterwards we will retry
> > > >
> > > > So we're talking about the case where it's a swap pmd entry, right?
> > >
> > > Hmm, my understanding is that it's being treated as a swap entry but
> > > in reality is not. I thought THPs are always split before they get
> > > swapped, no?
> >
> > Yes they should be split, afaiu.
> >
> > >
> > > > Could you elaborate why the split would fail?
> > >
> > > Just looking at the code, split_huge_pmd_locked() checks for
> > > (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd)).
> > > pmd_trans_huge() is false if !pmd_present() and it's not a migration
> > > entry, so __split_huge_pmd_locked() will be skipped.
> >
> > Here might be the major part of where confusion came from: I thought it
> > must be a migration pmd entry to hit the issue, so it's not?
> >
> > I checked the code just now:
> >
> > __handle_mm_fault:
> >                 if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
> >                         VM_BUG_ON(thp_migration_supported() &&
> >                                           !is_pmd_migration_entry(vmf.orig_pmd));
> >
> > So IIUC pmd migration entry is still the only possible way to have a swap
> > entry.  It doesn't look like we have "real" swap entries for PMD (which can
> > further points to some swapfiles)?
> 
> Correct. AFAIU here we stumble on a pmd entry which was allocated but
> never populated.

Do you mean a pmd_none()?

If so, that goes back to my original question, on why
__pmd_trans_huge_lock() returns non-NULL if it's a pmd_none()?  IMHO it
really should have returned NULL for pmd_none().

IOW, I still don't understand why below won't already work:

===8<===
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 52d7d5f144b8e..33e78f52ee9f5 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1880,13 +1880,15 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
                        /* Check if we can move the pmd without splitting it. */
                        if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
                            !pmd_none(dst_pmdval)) {
-                               struct folio *folio = pmd_folio(*src_pmd);
-
-                               if (!folio || (!is_huge_zero_folio(folio) &&
-                                              !PageAnonExclusive(&folio->page))) {
-                                       spin_unlock(ptl);
-                                       err = -EBUSY;
-                                       break;
+                               if (pmd_present(*src_pmd)) {
+                                       struct folio *folio = pmd_folio(*src_pmd);
+
+                                       if (!folio || (!is_huge_zero_folio(folio) &&
+                                                      !PageAnonExclusive(&folio->page))) {
+                                               spin_unlock(ptl);
+                                               err = -EBUSY;
+                                               break;
+                                       }
                                }

                                spin_unlock(ptl);

===8<===

Likely I missed something important..  I'll be afk for a while soon, I'll
also double check (maybe early next week) on the reproducer.

Thanks,

-- 
Peter Xu


