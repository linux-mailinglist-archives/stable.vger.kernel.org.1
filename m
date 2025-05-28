Return-Path: <stable+bounces-147970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FCEAC6C71
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E184E495E
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E918128853F;
	Wed, 28 May 2025 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WG67XJgn"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A9278162
	for <stable@vger.kernel.org>; Wed, 28 May 2025 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748444643; cv=none; b=ugH7ud6BTTejJkCE1f5L+YdUZRx2kUmOX5jP0ku99hdOoitCT31MNt/lGG8KqRJeMhG/DS0JcnmMI8GOJPsRlftEkQEx/rRxI/kJNylISmJo9VPP2CMZGavr1aQrjLobNi8TvWuuUdkYz+JfxXoJzm/r7UPwd2uu94FYlrD327c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748444643; c=relaxed/simple;
	bh=OkmiKIsgi5XBDLuEUxaDQ06HcaY5iOHPXJI+iHHY6fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQjrZfKaHLIvWk2ouJj+1MFrFYJCVxaMCG3FaixOgJZu9+RS0Qoyw/PXWwq3+RmeUtbvVt5lnJohwkLmGUxJatcFJmrXwX8Sfl6SKnAJn/U4SzHmMTZTfm99hutApUc4epwkQoFK/fLgSWdF2SMmVyw6aaoJSRHKWju7Zgxw3Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WG67XJgn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748444640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fcg1D7pi8/e049vKSQfksEQEilD5PKbpIfwXzkGgo8Q=;
	b=WG67XJgnbKyuT/aVVcc8awq33yCiWu0vMkCBCqNOjZIhu570SgxKw0bCQI2uPID2A0+Ul0
	Y+uCuvm1WrrTTYghKHhdzL/rF9HyRPPUCh1nASh46eCd5vw32LcEwRz2Zr2ASmSmw+Z9fa
	IFBQpK878z0krmRweRh1YuP4nnv6gcI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-vVLQrIdHPDqfm8EYlIsR9g-1; Wed, 28 May 2025 11:03:59 -0400
X-MC-Unique: vVLQrIdHPDqfm8EYlIsR9g-1
X-Mimecast-MFC-AGG-ID: vVLQrIdHPDqfm8EYlIsR9g_1748444638
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4767e6b4596so76275601cf.2
        for <stable@vger.kernel.org>; Wed, 28 May 2025 08:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748444638; x=1749049438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fcg1D7pi8/e049vKSQfksEQEilD5PKbpIfwXzkGgo8Q=;
        b=mgrp6rbrQI3AxrRf4AQJfuCVZjZSj5Mo3ISsvDhk/RUBHAZnFFV/WQYbgFlK0jngnB
         ngKJwkTGWXuJeI1F+UjWPAQjCf9JdtPNpRJhnPTp4Od2HIKpUCjMW8ku18uGX1R33XbU
         elnaONWIA5pzkZoJdNZCcFc08x4wiNVMayg9DVtXG4Vuzr+IlCHrBGoNhpzjs1AdRC/c
         gIc9vCUn2fEGXNbVXNNSKfKRI9hKJrJuN+2G/RipRUk6PzVqv3KAUUQ8TVv5ITYcQPT/
         ZFA0VTtEejdJr2wVkmK7F4Cb9ZCbZp9nBOmL45VYw4AXQiKqDnPNR0Jknu/HV++/rP13
         rnsg==
X-Forwarded-Encrypted: i=1; AJvYcCVWb7rtpUruP0U5tX6XvZHD1ejOpjEma0/ossn9K/owGJ/UaQG6NpLzCcwsftWhwUzds28tKOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+UnwafYksVkUfHbSWht3aaIbBfFM77lXQ/lVA4+HiAA670zQ
	/J5ISDzccYFsUUOEgpwOtAF27N/flCmV6KKk+tYv9PBfBO9qxaxSQi0M/eY+hW0Ftng2sXTVMLD
	7hIMC9s3GoiqKfnoQ5LBBhyoMPsNNgo/4xA3Ze8//1eZsCzau3TpxJwRMXA==
X-Gm-Gg: ASbGncsbhfAR95KWH5XkU5t/+XHIDTU+NxdsQas8Tz+7IbWylS25POZnepIIcb+YvFT
	7Hvt8JtOTjF/+fnwKW+t4LqL4PJs7OHS1Z8W3Z4P1jfMtrJsxBICV92D8gDL1fHsgZWm9A1aoB/
	x6KrYrErAJqoD4KSeOh4ydvp4kG40/d7ZlPjVcSUV8iQq/S/26z+tnx1+m3yEqwGa0TwglIA3tr
	6nj8HDxm81TFZ7wa5TT6cwjIm8onKOMsD0HhsP5pbQ9Vj898lxBZBKityPd4BK+fjK/a/CtTL6c
	83I=
X-Received: by 2002:a05:622a:6107:b0:494:b316:3c7e with SMTP id d75a77b69052e-49f46d2a5efmr286510841cf.28.1748444638282;
        Wed, 28 May 2025 08:03:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnUJayuS+UkHO22TovQrelasWBZh3qt4Z2cFlt3nrXlxBdJnptXMVTRnxlIh9YaGB7i53KdA==
X-Received: by 2002:a05:622a:6107:b0:494:b316:3c7e with SMTP id d75a77b69052e-49f46d2a5efmr286510291cf.28.1748444637865;
        Wed, 28 May 2025 08:03:57 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a3c80f2b8asm6940071cf.73.2025.05.28.08.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 08:03:57 -0700 (PDT)
Date: Wed, 28 May 2025 11:03:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Gavin Guo <gavinguo@igalia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	akpm@linux-foundation.org, mike.kravetz@oracle.com,
	kernel-dev@igalia.com, stable@vger.kernel.org,
	Hugh Dickins <hughd@google.com>, Florent Revest <revest@google.com>,
	Gavin Shan <gshan@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
Message-ID: <aDcl2YM5wX-MwzbM@x1.local>
References: <20250528023326.3499204-1-gavinguo@igalia.com>
 <aDbXEnqnpDnAx4Mw@localhost.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aDbXEnqnpDnAx4Mw@localhost.localdomain>

On Wed, May 28, 2025 at 11:27:46AM +0200, Oscar Salvador wrote:
> On Wed, May 28, 2025 at 10:33:26AM +0800, Gavin Guo wrote:
> > There is ABBA dead locking scenario happening between hugetlb_fault()
> > and hugetlb_wp() on the pagecache folio's lock and hugetlb global mutex,
> > which is reproducible with syzkaller [1]. As below stack traces reveal,
> > process-1 tries to take the hugetlb global mutex (A3), but with the
> > pagecache folio's lock hold. Process-2 took the hugetlb global mutex but
> > tries to take the pagecache folio's lock.
> > 
> > Process-1                               Process-2
> > =========                               =========
> > hugetlb_fault
> >    mutex_lock                  (A1)
> >    filemap_lock_hugetlb_folio  (B1)
> >    hugetlb_wp
> >      alloc_hugetlb_folio       #error
> >        mutex_unlock            (A2)
> >                                         hugetlb_fault
> >                                           mutex_lock                  (A4)
> >                                           filemap_lock_hugetlb_folio  (B4)
> >        unmap_ref_private
> >        mutex_lock              (A3)
> > 
> > Fix it by releasing the pagecache folio's lock at (A2) of process-1 so
> > that pagecache folio's lock is available to process-2 at (B4), to avoid
> > the deadlock. In process-1, a new variable is added to track if the
> > pagecache folio's lock has been released by its child function
> > hugetlb_wp() to avoid double releases on the lock in hugetlb_fault().
> > The similar changes are applied to hugetlb_no_page().
> > 
> > Link: https://drive.google.com/file/d/1DVRnIW-vSayU5J1re9Ct_br3jJQU6Vpb/view?usp=drive_link [1]
> > Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchronization")
> > Cc: <stable@vger.kernel.org>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Florent Revest <revest@google.com>
> > Reviewed-by: Gavin Shan <gshan@redhat.com>
> > Signed-off-by: Gavin Guo <gavinguo@igalia.com>
> ... 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 6a3cf7935c14..560b9b35262a 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6137,7 +6137,8 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
> >   * Keep the pte_same checks anyway to make transition from the mutex easier.
> >   */
> >  static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
> > -		       struct vm_fault *vmf)
> > +		       struct vm_fault *vmf,
> > +		       bool *pagecache_folio_locked)
> >  {
> >  	struct vm_area_struct *vma = vmf->vma;
> >  	struct mm_struct *mm = vma->vm_mm;
> > @@ -6234,6 +6235,18 @@ static vm_fault_t hugetlb_wp(struct folio *pagecache_folio,
> >  			u32 hash;
> >  
> >  			folio_put(old_folio);
> > +			/*
> > +			 * The pagecache_folio has to be unlocked to avoid
> > +			 * deadlock and we won't re-lock it in hugetlb_wp(). The
> > +			 * pagecache_folio could be truncated after being
> > +			 * unlocked. So its state should not be reliable
> > +			 * subsequently.
> > +			 */
> > +			if (pagecache_folio) {
> > +				folio_unlock(pagecache_folio);
> > +				if (pagecache_folio_locked)
> > +					*pagecache_folio_locked = false;
> > +			}
> 
> I am having a problem with this patch as I think it keeps carrying on an
> assumption that it is not true.
> 
> I was discussing this matter yesterday with Peter Xu (CCed now), who has also some
> experience in this field.
> 
> Exactly against what pagecache_folio's lock protects us when
> pagecache_folio != old_folio?
> 
> There are two cases here:
> 
> 1) pagecache_folio = old_folio  (original page in the pagecache)
> 2) pagecache_folio != old_folio (original page has already been mapped
>                                  privately and CoWed, old_folio contains
> 				 the new folio)
> 
> For case 1), we need to hold the lock because we are copying old_folio
> to the new one in hugetlb_wp(). That is clear.

So I'm not 100% sure we need the folio lock even for copy; IIUC a refcount
would be enough?

> 
> But for case 2), unless I am missing something, we do not really need the
> pagecache_folio's lock at all, do we? (only old_folio's one)
> The only reason pagecache_folio gets looked up in the pagecache is to check
> whether the current task has mapped and faulted in the file privately, which
> means that a reservation has been consumed (a new folio was allocated).
> That is what the whole dance about "old_folio != pagecache_folio &&
> HPAGE_RESV_OWNER" in hugetlb_wp() is about.
> 
> And the original mapping cannot really go away either from under us, as
> remove_inode_hugepages() needs to take the mutex in order to evict it,
> which would be the only reason counters like resv_huge_pages (adjusted in
> remove_inode_hugepages()->hugetlb_unreserve_pages()) would
> interfere with alloc_hugetlb_folio() from hugetlb_wp().
> 
> So, again, unless I am missing something there is no need for the
> pagecache_folio lock when pagecache_folio != old_folio, let alone the
> need to hold it throughout hugetlb_wp().
> I think we could just look up the cache, and unlock it right away.
> 
> So, the current situation (previous to this patch) is already misleading
> for case 2).
> 
> And comments like:
> 
>  /*
>   * The pagecache_folio has to be unlocked to avoid
>   * deadlock and we won't re-lock it in hugetlb_wp(). The
>   * pagecache_folio could be truncated after being
>   * unlocked. So its state should not be reliable
>   * subsequently.
>   */
> 
> Keep carrying on the assumption that we need the lock.
> 
> Now, if the above is true, I would much rather see this reworked (I have
> some ideas I discussed with Peter yesterday), than keep it as is.

Yes just to reply in public I also am not aware of why the folio lock is
needed considering hugetlb has the fault mutex.  I'm not sure if we should
rely more on the fault mutex, but that doesn't sound like an immediate
concern.

It may depend on whether my above understand was correct.. and only if so,
maybe we could avoid locking the folio completely.

Thanks,

> 
> Let me also CC David who tends to have a good overview in this.
> 
> -- 
> Oscar Salvador
> SUSE Labs
> 

-- 
Peter Xu


