Return-Path: <stable+bounces-148005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B323AC72CD
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 23:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E48C7A6454
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 21:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323191DF270;
	Wed, 28 May 2025 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LddGgKyd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/TK6c2b5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LmKz5+RU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5cQ+DouM"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB801F1527
	for <stable@vger.kernel.org>; Wed, 28 May 2025 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748468060; cv=none; b=qXC0HdTIITmqd5CqDM9AnSWJa/KTBsWQ+0uvXmYQYYrqi4EZp2ErqATWKEnIy4xRu3nY1Pr0MsmqT+VW7xJjYJTC4Aq96dlFM0smrJvOIxiGUp26n4W1l1mWIgh4qOmsOUkzMTnttp8Vq6gM11IGxW/14dEpxq8me/9g22rT1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748468060; c=relaxed/simple;
	bh=XzwjS5Fpu7iUL+Pk3A5aKxwqsqkBVeIa4mYrswNDADA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CADB584U5q/c/XzvrNCUFRwKkNM416xq1WfmZDDI6/2v3MoHqa1AZyL+1e5K9cVfHDT+kLuU3irh2acezxa++cbmO7mI6LIWkzsS0/XWa6zlmfrZ2W/OuOV/SxSKCoHXJvM0bijFGj3qosGzXvIBmCz/NclzH79LGuRea1RyojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LddGgKyd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/TK6c2b5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LmKz5+RU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5cQ+DouM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB3C52116C;
	Wed, 28 May 2025 21:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748468056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zn5dDTOpfN67/OlDdxZPFl4vcSl3rIJLnpSo3fCnCZc=;
	b=LddGgKydabcDjkgkjiRsNwHsRbjjffoLMKK9oY2XmEFKbs0Wfn3VyJUkY2YdJqUy7Pmu+m
	+S6TtlCq0W7tpHQrlm7xpil/F/5UQPMPCtPaxhldpGPmLr85Xg2Bs/F/cuBzhyEgvldik8
	8qSUSEqC1TWjmt9yhrl4EN2i6Cng3iA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748468056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zn5dDTOpfN67/OlDdxZPFl4vcSl3rIJLnpSo3fCnCZc=;
	b=/TK6c2b5toZAlnPRukLl8xJl9eOOVPjeQxalhgsADmGO8L4nCoP+OZMkaYCfZfOp3Yp3Ru
	IcZRM2qRQ6wC/4AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LmKz5+RU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5cQ+DouM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748468055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zn5dDTOpfN67/OlDdxZPFl4vcSl3rIJLnpSo3fCnCZc=;
	b=LmKz5+RU3Roi2VY/TI1FP70B7nHiLENRqHDTR5xw6N63UClfa0iPJgrYX6hxmw9MZeQVtW
	sosiyniCDQFlCZ9cNKe9Ssjuv1NGQJFhsvAYjZnjpJTKk35QQOgrSj9oXpAEOEUV9rzWEL
	MknOtrZ7aofUsO6ojrHycrwtBIjFmn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748468055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zn5dDTOpfN67/OlDdxZPFl4vcSl3rIJLnpSo3fCnCZc=;
	b=5cQ+DouMgAZWRywQPBt4Vt9W4cYvV9iv/sXoaKDQ99F9S6CZDZbevAYYE7r2kHVvAI+NKe
	oUSbQzUMqCkhznAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B442136E3;
	Wed, 28 May 2025 21:34:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3xyUO1aBN2hGQgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 28 May 2025 21:34:14 +0000
Date: Wed, 28 May 2025 23:34:09 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Gavin Guo <gavinguo@igalia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	mike.kravetz@oracle.com, kernel-dev@igalia.com,
	stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	Florent Revest <revest@google.com>, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
Message-ID: <aDeBUXCRLRZobHq0@localhost.localdomain>
References: <20250528023326.3499204-1-gavinguo@igalia.com>
 <aDbXEnqnpDnAx4Mw@localhost.localdomain>
 <aDcl2YM5wX-MwzbM@x1.local>
 <629bb87e-c493-4069-866c-20e02c14ddcc@redhat.com>
 <aDcvplLNH0nGsLD1@localhost.localdomain>
 <4cc7e0bb-f247-419d-bf6f-07dc5e88c9c1@redhat.com>
 <04ecf2e3-651a-47c9-9f30-d31423e2c9d7@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ecf2e3-651a-47c9-9f30-d31423e2c9d7@redhat.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BB3C52116C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On Wed, May 28, 2025 at 10:26:04PM +0200, David Hildenbrand wrote:
> Digging a bit:
> 
> commit 56c9cfb13c9b6516017eea4e8cbe22ea02e07ee6
> Author: Naoya Horiguchi <nao.horiguchi@gmail.com>
> Date:   Fri Sep 10 13:23:04 2010 +0900
> 
>     hugetlb, rmap: fix confusing page locking in hugetlb_cow()
>     The "if (!trylock_page)" block in the avoidcopy path of hugetlb_cow()
>     looks confusing and is buggy.  Originally this trylock_page() was
>     intended to make sure that old_page is locked even when old_page !=
>     pagecache_page, because then only pagecache_page is locked.
> 
> Added the comment
> 
> +       /*
> +        * hugetlb_cow() requires page locks of pte_page(entry) and
> +        * pagecache_page, so here we need take the former one
> +        * when page != pagecache_page or !pagecache_page.
> +        * Note that locking order is always pagecache_page -> page,
> +        * so no worry about deadlock.
> +        */
> 
> 
> And
> 
> commit 0fe6e20b9c4c53b3e97096ee73a0857f60aad43f
> Author: Naoya Horiguchi <nao.horiguchi@gmail.com>
> Date:   Fri May 28 09:29:16 2010 +0900
> 
>     hugetlb, rmap: add reverse mapping for hugepage
>     This patch adds reverse mapping feature for hugepage by introducing
>     mapcount for shared/private-mapped hugepage and anon_vma for
>     private-mapped hugepage.
>     While hugepage is not currently swappable, reverse mapping can be useful
>     for memory error handler.
>     Without this patch, memory error handler cannot identify processes
>     using the bad hugepage nor unmap it from them. That is:
>     - for shared hugepage:
>       we can collect processes using a hugepage through pagecache,
>       but can not unmap the hugepage because of the lack of mapcount.
>     - for privately mapped hugepage:
>       we can neither collect processes nor unmap the hugepage.
>     This patch solves these problems.
>     This patch include the bug fix given by commit 23be7468e8, so reverts it.
> 
> Added the real locking magic.

Yes, I have been checking "hugetlb, rmap: add reverse mapping for
hugepage", which added locking the now-so-called 'old_folio' in case
hugetlbfs_pagecache_page() didn't return anything.

Because in hugetlb_wp, this was added:

 @@ -2286,8 +2299,11 @@ static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
  retry_avoidcopy:
         /* If no-one else is actually using this page, avoid the copy
          * and just make the page writable */
 -       avoidcopy = (page_count(old_page) == 1);
 +       avoidcopy = (page_mapcount(old_page) == 1);
         if (avoidcopy) {
 +               if (!trylock_page(old_page))
 +                       if (PageAnon(old_page))
 +                               page_move_anon_rmap(old_page, vma, address);

So, as you mentioned, it was done to keep the rmap stable as I guess rmap test test the
PageLock. 


> Not that much changed regarding locking until COW support was added in
> 
> commit 1e8f889b10d8d2223105719e36ce45688fedbd59
> Author: David Gibson <david@gibson.dropbear.id.au>
> Date:   Fri Jan 6 00:10:44 2006 -0800
> 
>     [PATCH] Hugetlb: Copy on Write support
>     Implement copy-on-write support for hugetlb mappings so MAP_PRIVATE can be
>     supported.  This helps us to safely use hugetlb pages in many more
>     applications.  The patch makes the following changes.  If needed, I also have
>     it broken out according to the following paragraphs.
> 
> 
> Confusing.
> 
> Locking the *old_folio* when calling hugetlb_wp() makes sense when it is
> an anon folio because we might want to call folio_move_anon_rmap() to adjust the rmap root.

Yes, this is clear.

> Locking the pagecache folio when calling hugetlb_wp() if old_folio is an anon folio ...
> does not make sense to me.

I think this one is also clear.

> Locking the pagecache folio when calling hugetlb_wp if old_folio is a pageache folio ...
> also doesn't quite make sense for me.
> Again, we don't take the lock for ordinary pages, so what's special about hugetlb for the last
> case (reservations, I assume?).

So, this case is when pagecache_folio == old_folio.

I guess we are talking about resv_maps? But I think we cannot interfere there.
For the reserves to be modified the page has to go away.

Now, I have been checking this one too:

 commit 04f2cbe35699d22dbf428373682ead85ca1240f5
 Author: Mel Gorman <mel@csn.ul.ie>
 Date:   Wed Jul 23 21:27:25 2008 -0700
 
     hugetlb: guarantee that COW faults for a process that called mmap(MAP_PRIVATE) on hugetlbfs will succeed

And I think it is interesting.
That one added this chunk in hugetlb_fault():

 @@ -1126,8 +1283,15 @@ int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
         spin_lock(&mm->page_table_lock);
         /* Check for a racing update before calling hugetlb_cow */
         if (likely(pte_same(entry, huge_ptep_get(ptep))))
 -               if (write_access && !pte_write(entry))
 -                       ret = hugetlb_cow(mm, vma, address, ptep, entry);
 +               if (write_access && !pte_write(entry)) {
 +                       struct page *page;
 +                       page = hugetlbfs_pagecache_page(vma, address);
 +                       ret = hugetlb_cow(mm, vma, address, ptep, entry, page);
 +                       if (page) {
 +                               unlock_page(page);
 +                               put_page(page);
 +                       }
 +               }

So, it finds and lock the page in the pagecache, and calls hugetlb_cow.

hugetlb_fault() takes hugetlb_instantiation_mutex, and there is a
comment saying:

        /*
         * Serialize hugepage allocation and instantiation, so that we don't
         * get spurious allocation failures if two CPUs race to instantiate
         * the same page in the page cache.
         */
        mutex_lock(&hugetlb_instantiation_mutex);

But it does not say anything about truncation.
Actually, checking the truncation code from back then,
truncate_hugepages() (and none of its callers) take the hugetlb_instantiation_mutex,
as it is done today (e.g: current remove_inode_hugepages() code).

Back then, truncate_hugepages() relied only in lock_page():

 static void truncate_hugepages(struct inode *inode, loff_t lstart)
 {
  ...
  ...
  lock_page(page);
  truncate_huge_page(page);
  unlock_page(page);
 }

While today, remove_inode_hugepages() takes the mutex, and also the lock.
And then zaps the page and does its thing with resv_maps.

So I think that we should not even need the lock for hugetlb_wp
when pagecache_folio == old_folio (pagecache), because the mutex
already protects us from the page to go away, right (e.g: truncated)?
Besides we hold a reference on that page since
filemap_lock_hugetlb_folio() locks the page and increases its refcount.

All in all, I am leaning towards not being needed, but it's getting late
here..


-- 
Oscar Salvador
SUSE Labs

