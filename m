Return-Path: <stable+bounces-65243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B24944D7B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 15:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BFE81C24ABE
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D2D1A3BB9;
	Thu,  1 Aug 2024 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fM/DYDY/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8096F1A2C20
	for <stable@vger.kernel.org>; Thu,  1 Aug 2024 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520358; cv=none; b=CVTUN5I9FvnV1AKdv8NQsilELkx55B/AxAg+utvC14VcJb9XW6nQ3nePud6cnra+CiLCs9sUkwTQX8pwDUUaQRpVkb6xeKwZTrtfFV6U/LUd2dBAuhe6azmH8DpEYqEd2exYzQuXbFJEWrSEZRvTb2Zuf3oDITCy582fcpP5m0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520358; c=relaxed/simple;
	bh=1YP6AD5SUeV0h3ytVf6TeAyLyYSUZPrknb5L7NmapjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVk8b+V2U+5trlwp8BWsZnmBtSIG8J7wEK4e9VACDiLkHxqgja4qYg6vUYCRNWoo92Y11LTGRxI9AYRxs+ge3kKVJd+8eFoOlBj0O/xTlVGe1FIUSkTNnQF8Z+PqIf3myVXtCanU2/p6cCDDevU+fz1K29T0MN2yc0RTfL0DUw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fM/DYDY/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722520355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k6+M5lxqWFd3gMZ3w6UL7CO9WtUAKE4v1JrMS05eUKA=;
	b=fM/DYDY/iRtyCsNPgmoy7tGGDLOSwCQnF0fBzR9ZeJnQ3d2BvgImKNmNxidYQDF8at2Ft/
	T8gyJGKQjgtwtrq6QgEsOHYEiKq0MXRsqpnERE2mMr9j3IGfAzajGLh+NUSNPQEWk9qEgE
	JDQM4o5VY9w2Xva6YkBvzZhtFJGEYIo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-lzVWwbUVO76-jlzBjwUuOA-1; Thu, 01 Aug 2024 09:52:34 -0400
X-MC-Unique: lzVWwbUVO76-jlzBjwUuOA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b7a47a271cso15907326d6.2
        for <stable@vger.kernel.org>; Thu, 01 Aug 2024 06:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722520353; x=1723125153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6+M5lxqWFd3gMZ3w6UL7CO9WtUAKE4v1JrMS05eUKA=;
        b=qfO8iSTz9g1KljB2DBlC036ZFJTnOL2JpW6C7d/sScmzgY66gh5W763iYZsZlhhqEB
         y/rWqFpXJRz9HDukhpr5/mAWUh1WWgDUIahylBuusQDDHptj5B5vqcgIPBsFHdyOfxCh
         adXcxBKd5KmytpYtHgDOfUOniVqFQgrNqY7mXBj8uHELzO/ZHqt3O2svFNMGTSDyAjeQ
         XOSOJr11Q8DSQK0EX/uBP3g417hGkBm4ue+XArCvOAp8wcTv+GfEyWQKAEBOBVh/QFia
         KZbgribN+0N8IjwO2EIuxAgvtOQo1ybHZpcqSfVL78TukptYjZeUaaURw7cituUqwUce
         2j4A==
X-Forwarded-Encrypted: i=1; AJvYcCWmiDQYpKG4hbTxLb4NIyz4WE5sgKdQIfs++FUGP1IZ9dmCt+teahLrj/WNLkMAFFY4y5fwyrc5vgZua3kZOGk3QN9N9qGV
X-Gm-Message-State: AOJu0YyRpRkoahccszjUFGhFbBa06QyfMHoCdlObiGALX/GvNDbDei41
	7tRdek1Vgr2Z5vQ1CnAKVlnE3CGFr2brbmRDqGCgpG2WP3d68gB0nrZyv+MHw98/0coLZHKYjMN
	DNlKLx3gHM/fKlKQ8g6rZF4cK9dTLGuUC9N+9Ur2impkKRdUrzp2fZg==
X-Received: by 2002:a05:620a:1aa7:b0:79f:af4:66e8 with SMTP id af79cd13be357-7a34ee96b5emr2432585a.2.1722520353524;
        Thu, 01 Aug 2024 06:52:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6sKK7x0m2Ws2ix0NAwD4CGdu/V5JvqWQLttEjLrMQ0dCRu8cILfqpCGlY3ZlJ/ZSmBWXrpw==
X-Received: by 2002:a05:620a:1aa7:b0:79f:af4:66e8 with SMTP id af79cd13be357-7a34ee96b5emr2431385a.2.1722520353070;
        Thu, 01 Aug 2024 06:52:33 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1fafec133sm353312585a.94.2024.08.01.06.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:52:32 -0700 (PDT)
Date: Thu, 1 Aug 2024 09:52:30 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	James Houghton <jthoughton@google.com>, stable@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Muchun Song <muchun.song@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v3] mm/hugetlb: fix hugetlb vs. core-mm PT locking
Message-ID: <ZquTHvK0Rc0xBA4y@x1n>
References: <20240731122103.382509-1-david@redhat.com>
 <541f6c23-77ad-4d46-a8ed-fb18c9b635b3@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541f6c23-77ad-4d46-a8ed-fb18c9b635b3@redhat.com>

On Thu, Aug 01, 2024 at 10:50:18AM +0200, David Hildenbrand wrote:
> On 31.07.24 14:21, David Hildenbrand wrote:
> > We recently made GUP's common page table walking code to also walk hugetlb
> > VMAs without most hugetlb special-casing, preparing for the future of
> > having less hugetlb-specific page table walking code in the codebase.
> > Turns out that we missed one page table locking detail: page table locking
> > for hugetlb folios that are not mapped using a single PMD/PUD.
> 
> James, Peter,
> 
> the following seems to get the job done. Thoughts?

OK to me, so my A-b can keep, but let me still comment; again, all
nitpicks.

> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 8e462205400d..776dc3914d9e 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -938,10 +938,40 @@ static inline bool htlb_allow_alloc_fallback(int reason)
>  static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>  					   struct mm_struct *mm, pte_t *pte)
>  {
> -	if (huge_page_size(h) == PMD_SIZE)
> +	unsigned long size = huge_page_size(h);
> +
> +	VM_WARN_ON(size == PAGE_SIZE);
> +
> +	/*
> +	 * hugetlb must use the exact same PT locks as core-mm page table
> +	 * walkers would. When modifying a PTE table, hugetlb must take the
> +	 * PTE PT lock, when modifying a PMD table, hugetlb must take the PMD
> +	 * PT lock etc.
> +	 *
> +	 * The expectation is that any hugetlb folio smaller than a PMD is
> +	 * always mapped into a single PTE table and that any hugetlb folio
> +	 * smaller than a PUD (but at least as big as a PMD) is always mapped
> +	 * into a single PMD table.
> +	 *
> +	 * If that does not hold for an architecture, then that architecture
> +	 * must disable split PT locks such that all *_lockptr() functions
> +	 * will give us the same result: the per-MM PT lock.
> +	 *
> +	 * Note that with e.g., CONFIG_PGTABLE_LEVELS=2 where
> +	 * PGDIR_SIZE==P4D_SIZE==PUD_SIZE==PMD_SIZE, we'd use the MM PT lock
> +	 * directly with a PMD hugetlb size, whereby core-mm would call
> +	 * pmd_lockptr() instead. However, in such configurations split PMD
> +	 * locks are disabled -- split locks don't make sense on a single
> +	 * PGDIR page table -- and the end result is the same.
> +	 */
> +	if (size >= P4D_SIZE)
> +		return &mm->page_table_lock;

I'd drop this so the mm lock fallback will be done below (especially in
reality the pud lock is always mm lock for now..).  Also this line reads
like there can be P4D size huge page but in reality PUD is the largest
(nopxx doesn't count).  We also same some cycles in most cases if removed.

> +	else if (size >= PUD_SIZE)
> +		return pud_lockptr(mm, (pud_t *) pte);
> +	else if (size >= PMD_SIZE || IS_ENABLED(CONFIG_HIGHPTE))

I thought this HIGHPTE can also be dropped? Because in HIGHPTE it should
never have lower-than-PMD huge pages or we're in trouble.  That's why I
kept one WARN_ON() in my pesudo code but only before trying to take the pte
lockptr.

>  		return pmd_lockptr(mm, (pmd_t *) pte);
> -	VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
> -	return &mm->page_table_lock;
> +	/* pte_alloc_huge() only applies with !CONFIG_HIGHPTE */
> +	return ptep_lockptr(mm, pte);
>  }
>  #ifndef hugepages_supported
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a890a1731c14..bd219ac9c026 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2869,6 +2869,13 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
>  }
> +static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
> +{
> +	BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
> +	BUILD_BUG_ON(MAX_PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE);
> +	return ptlock_ptr(virt_to_ptdesc(pte));
> +}

Great to know we can drop the mask..

Thanks,

> +
>  static inline bool ptlock_init(struct ptdesc *ptdesc)
>  {
>  	/*
> @@ -2893,6 +2900,10 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  {
>  	return &mm->page_table_lock;
>  }
> +static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
> +{
> +	return &mm->page_table_lock;
> +}
>  static inline void ptlock_cache_init(void) {}
>  static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
>  static inline void ptlock_free(struct ptdesc *ptdesc) {}
> -- 
> 2.45.2
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Peter Xu


