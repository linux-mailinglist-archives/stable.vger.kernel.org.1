Return-Path: <stable+bounces-106714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A33FEA00C08
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 17:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BEA3A3C04
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 16:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645761FAC5A;
	Fri,  3 Jan 2025 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Raaz+bn9"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513FD17F4F6
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735921573; cv=none; b=Uy+HJH617g/2fxUekxSArQbN0lDzkzQZjxo7+VLIu2y2alpoXMcItAiu7rtLmeawl9xs4ubyk8ErQTUa+lKUDn4Bb8Y9ojeYb5eg/L6p6U2ancfeCqbKMJyPf40049j7gUUYBXAl7WrZgcHrmYVSAur6/zgy/HQ3MDkIGEfLznw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735921573; c=relaxed/simple;
	bh=V/tYWepckXgaJhncB7h3zS/B5nCmC5uouZgNuoc23hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNaE9vHp67DN6aqivHeY0oJnTWE44WU/3sSqQChU7BZREoDCoTXQNXjQK7F46Bc4xoZtkCb+PIPVKFINnZgJqsOoLFY03D6XNdYx2lUDzjZ3H9fo+3B0DFY9hvCSejv78Wk+muUcbZqyaT/clPfUHpEGh4RTLNisPpMPMCIxBaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Raaz+bn9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735921570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5MHNQ7x94/Z6dGv9U16Uo43D+cJQCLIgcMDc7+n4zx8=;
	b=Raaz+bn97IT01Hu0CwFbKiOJXWPYqEjrkBTGsoe04kMq0ga/KRBOfmaF6NCTZ45LgQ1SO1
	8CsnaDT3iy/r87Gt0IImJv579CA+gepLm0yDtzeXyuyPAasLw19xwR8inrZMFiFGnQI6sn
	bhMH1bJ6sgm6/Ax3WBovuNcFU5toRI8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-Ympn8TDxNKmUR5Wn8b0Gcg-1; Fri, 03 Jan 2025 11:26:09 -0500
X-MC-Unique: Ympn8TDxNKmUR5Wn8b0Gcg-1
X-Mimecast-MFC-AGG-ID: Ympn8TDxNKmUR5Wn8b0Gcg
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8f51b49e5so218070576d6.1
        for <stable@vger.kernel.org>; Fri, 03 Jan 2025 08:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735921568; x=1736526368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MHNQ7x94/Z6dGv9U16Uo43D+cJQCLIgcMDc7+n4zx8=;
        b=YFMRC3jcem0TkO3Q9x71zxeuHxQdDKPoMFH/xRWpQUtKwG84aLkRelAcJygArSR0lO
         63bkN6LZfQ7PLSabU0aB8IvJITmCruk7e3v5fc0qfVFvg1LgpnIyPkZFh2U3HtFqkw1a
         yYWv4UZSypqw5FBwGOEllBhJc3kwr5BZNGSDCzwI5Or57Nzr2OAIEDsDCU1IXFCbFJWg
         KxnW7vTjX5/yfIAJ59ejacyBDXgow0CR7Y/5A37VpGRMU2ggbIZSUeE1UqriO8EN4Ok5
         M7hfTX+KGI8q9r7gHmgZG6ISXL/ACk84kpa31MNXRlco4TZJocso6PogMntSyxQQgV0h
         eKjA==
X-Forwarded-Encrypted: i=1; AJvYcCWdshFNpNJeTn/80W/LsjQSX/+wmE0AUW84qpn2IAw1hzn3x6/5ht9ivtmZabSlAvYefUgx1NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfiQoT9N1Of0DatfVJYafB4U8hA7vREYX6uJbjnKiJC3yQa8Bf
	9ZRzcq2VXNrkqBytPin+Su7jNPvXftoXIp+s4cr7sz8t2gWfCqzzMLFMTKauZOc5jmB009NTQCG
	AyiLX2RMxSGk+cqhWRhZa4lPvO8yH/hP5VdL9kZIMuucPj1UU88benw==
X-Gm-Gg: ASbGncuD8iiMOqHGYsljeJKQcaHWruimzgdwIA7pxQQ077Nm1N6P5aT1kqzRs6a0IbY
	uPIayyP8StaYco6wJtYJMZqZvIpcmgTlSprCtzeOf9oA7KsntuQiVojy7J96W0x2I9rDbnMtcgB
	Dwap7C3bBPWbfxSwOgTVa9m7Kh4ZXJe4nWoppQ/oIb0vg85ph0zl8Zpl4LlyhN+FYGPjSkjIFGO
	LL5rYVhVdnPVSZmU7dorTMWLUq+eLgScYCLzZohHNQuvPUGrpaHoTj+F+n52vzmz474F+sJgKB6
	rJ5LtDccSVpRHLv3Og==
X-Received: by 2002:a05:6214:240d:b0:6d8:e5f4:b977 with SMTP id 6a1803df08f44-6dd23308369mr920827846d6.5.1735921568653;
        Fri, 03 Jan 2025 08:26:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMhfRQSmYgRtjKy1hlSSHm/bvAWLo5/nax+/dFjUuYxGaLj/pusyg5rTT23tUKdcdUeFhzog==
X-Received: by 2002:a05:6214:240d:b0:6d8:e5f4:b977 with SMTP id 6a1803df08f44-6dd23308369mr920827476d6.5.1735921568325;
        Fri, 03 Jan 2025 08:26:08 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd32b2be9esm120441926d6.34.2025.01.03.08.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 08:26:07 -0800 (PST)
Date: Fri, 3 Jan 2025 11:26:04 -0500
From: Peter Xu <peterx@redhat.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com,
	leitao@debian.org, akpm@linux-foundation.org, muchun.song@linux.dev,
	osalvador@suse.de, roman.gushchin@linux.dev,
	nao.horiguchi@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/7] mm/hugetlb: Fix avoid_reserve to allow taking folio
 from subpool
Message-ID: <Z3gPnMDkng3NlVeV@x1n>
References: <diqzwmfxrrg8.fsf@ackerleytng-ctop.c.googlers.com>
 <diqzed1ssonz.fsf@ackerleytng-ctop.c.googlers.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <diqzed1ssonz.fsf@ackerleytng-ctop.c.googlers.com>

On Fri, Dec 27, 2024 at 11:15:44PM +0000, Ackerley Tng wrote:
> Ackerley Tng <ackerleytng@google.com> writes:
> 
> > <snip>
> >
> > I'll go over the rest of your patches and dig into the meaning of `avoid_reserve`.
> 
> Yes, after looking into this more deeply, I agree that avoid_reserve
> means avoiding the reservations in the resv_map rather than reservations
> in the subpool or hstate.
> 
> Here's more detail of what's going on in the reproducer that I wrote as I
> reviewed Peter's patch:
> 
> 1. On fallocate(), allocate page A
> 2. On mmap(), set up a vma without VM_MAYSHARE since MAP_PRIVATE was requested
> 3. On faulting *buf = 1, allocate a new page B, copy A to B because the mmap request was MAP_PRIVATE
> 4. On fork, prep for COW by marking page as read only. Both parent and child share B.
> 5. On faulting *buf = 2 (write fault), allocate page C, copy B to C
>     + B belongs to the child, C belongs to the parent
>     + C is owned by the parent
> 6. Child exits, B is freed
> 7. On munmap(), C is freed
> 8. On unlink(), A is freed
> 
> When C was allocated in the parent (owns MAP_PRIVATE page, doing a copy on
> write), spool->rsv_hpages was decreased but h->resv_huge_pages was not. This is
> the root of the bug.
> 
> We should decrement h->resv_huge_pages if a reserved page from the subpool was
> used, instead of whether avoid_reserve or vma_has_reserves() is set. If
> avoid_reserve is set, the subpool shouldn't be checked for a reservation, so we
> won't be decrementing h->resv_huge_pages anyway.
> 
> I agree with Peter's fix as a whole (the entire patch series).
> 
> Reviewed-by: Ackerley Tng <ackerleytng@google.com>
> Tested-by: Ackerley Tng <ackerleytng@google.com>
> 
> ---
> 
> Some definitions which might be helpful:
> 
> + h->resv_huge_pages indicates number of reserved pages globally.
>     + This number increases when pages are reserved
>     + This number decreases when reserved pages are allocated, or when pages are unreserved
> + spool->rsv_hpages indicates number of reserved pages in this subpool.
>     + This number increases when pages are reserved
>     + This number decreases when reserved pages are allocated, or when pages are unreserved
> + h->resv_huge_pages should be the sum of all subpools' spool->rsv_hpages.

I think you're correct. One add-on comment: I think when taking vma
reservation into accout, then the global reservation should be a sum of
all spools' and all vmas' reservations.

> 
> More details on the flow in alloc_hugetlb_folio() which might be helpful:
> 
> hugepage_subpool_get_pages() returns "the number of pages by which the global
> pools must be adjusted (upward)". This return value is never negative other than
> errors. (hugepage_subpool_get_pages() always gets called with a positive delta).
> 
> Specifically in alloc_hugetlb_folio(), the return value is either 0 or 1 (other
> than errors).
> 
> If the return value is 0, the subpool had enough reservations and so we should
> decrement h->resv_huge_pages.
> 
> If the return value is 1, it means that this subpool did not have any more
> reserved hugepages, and we need to get a page from the global
> hstate. dequeue_hugetlb_folio_vma() will get us a page that was already
> allocated.
> 
> In dequeue_hugetlb_folio_vma(), if the vma doesn't have enough reserves for 1
> page, and there are no available_huge_pages() left, we quit dequeueing since we
> will need to allocate a new page. If we want to avoid_reserve, that means we
> don't want to use the vma's reserves in resv_map, we also check
> available_huge_pages(). If there are available_huge_pages(), we go on to dequeue
> a page.
> 
> Then, we determine whether to decrement h->resv_huge_pages. We should decrement
> if a reserved page from the subpool was used, instead of whether avoid_reserve
> or vma_has_reserves() is set.
> 
> In the case where a surplus page needs to be allocated, the surplus page isn't
> and doesn't need to be associated with a subpool, so no subpool hugepage number
> tracking updates are required. h->resv_huge_pages still has to be updated... is
> this where h->resv_huge_pages can go negative?

This question doesn't sound like relevant to this specific scenario that
this patch (or, the reproducer attached in the patch) was about.  In the
reproducer of this patch, we don't need to have surplus page involved.

Going back to the question you're asking - I don't think resv_huge_pages
will go negative for the surplus case?

IIUC updating resv_huge_pages is the correct behavior even for surplus
pages, as long as gbl_chg==0.

The initial change was done by Naoya in commit a88c76954804 ("mm: hugetlb:
fix hugepage memory leak caused by wrong reserve count").  There're some
more information in the commit log.  In general, when gbl_chg==0 it means
we consumed a global reservation either in vma or spool, so it must be
accounted globally after the folio is successfully allocated.  Here "being
accounted" should mean the global resv count will be properly decremented.

Thanks for taking a look, Ackerley!

-- 
Peter Xu


