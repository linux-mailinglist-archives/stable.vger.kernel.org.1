Return-Path: <stable+bounces-147984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3265DAC6DF6
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 18:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BD11BA5363
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 16:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E573828C851;
	Wed, 28 May 2025 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FV/+li4T"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98EF17B418
	for <stable@vger.kernel.org>; Wed, 28 May 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748449473; cv=none; b=Cd+fkQg+PL1B3pYkpJOhws0UNr48sB9eP9amLp5/jsljANBnooBpmJYCuciATv4XO9BhQEV+n9m4dy/25qJFcHbh8YpvAg/ZTP5GQA6q9I2uW9q3xQFQVEsP429CVPP5QbDCcaOo0nvBiwTG3igw++3T/OA9xYgRbtvfbn+MI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748449473; c=relaxed/simple;
	bh=282JlZCXGeqP/PzRjpZh9RPcBxfOxdu51od+r+SojZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoqxGuUiMiAs8LO6zUkhtgSoXi3+Lfgk6rjxkdOnaJkAc7LaORh+eZ8enE66S7fj5wgYbXXcacLa0P5k+qrGsBeUmDxzfXi11VbU9yii47V4T4lDtLtXccqoNz/nPQ7nOk0cPeHXwzO5p9xrfcqfNDivlj4otm4GLIKP1l4AQIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FV/+li4T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748449470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H3WfoxKRVcW4Y+DnHDOZBJuxMROGpvocSlXq1ZkIg5E=;
	b=FV/+li4TWgmTQ7xQVtbvh+PJAVGtxQuVooFV8o5yDejKOHFsaWEBTQQsoZ7/Owpw6TkIyl
	tvLisBDEOTK0v1WqCWUcB2rryIeyVn8rqsVWySuFwyiRwAVJxIfll2P49/Fzb1c0fCZF+K
	lwvaaml8QlT7zdbPGYeWk4tsvQW16h8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-rOYrvr3mPCqwzfpYhTLZdQ-1; Wed, 28 May 2025 12:24:29 -0400
X-MC-Unique: rOYrvr3mPCqwzfpYhTLZdQ-1
X-Mimecast-MFC-AGG-ID: rOYrvr3mPCqwzfpYhTLZdQ_1748449469
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5f3b8b1a1so754771785a.3
        for <stable@vger.kernel.org>; Wed, 28 May 2025 09:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748449469; x=1749054269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3WfoxKRVcW4Y+DnHDOZBJuxMROGpvocSlXq1ZkIg5E=;
        b=ElDKjy2fuPipIvq4w31wDo8JVrqouHv7hhrLCpvUmPzn3lvAAA5t2BVeFCGzfAovlt
         SjSpHFf3WLYj8HHZiwGTm3puZxtaVHjMpIsQQty/Y+U7kWktcp+kr8gKfsIk6GGCiqV0
         pjivhNi44otuABvnKxLoZfFoiFDgA1Z462sO13M6AuPGZlgFkfaxJ+Na+Sy/SnIvVj5s
         2TZ0/9mO3cTyh21KAFOoUjq8SuCWRie62HOpiF8iZyWl7BRJ0cb005IhSYm8SpFamXjP
         ws+4cfUSLJUqCNFO/Afb2jiXWpH3p+mMOrmV8CBByC3vYCYcP/7Ldj5qxHeygAp6xT49
         3Gkg==
X-Forwarded-Encrypted: i=1; AJvYcCWj+vEOgNIrvXpjKFRu158j2RJw8B8zfE7+0UoNfLJwVfSgzrF7QVinkYZBr73x1un6cxLoa2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1lXJb1ALEYfjRsmcJZO8T/C3Db6EU1sAtM81IwmdLIZz4x7r5
	qBO68PolgINUNhkAeKnFsDCVjSLEvNgfRupudJQCLx6GQZKqfaRIivT0U+QH3VEC8rhmg2S3ahG
	A7lL/cvEnDECsAII82prfifjZOjs3lCjLe4AlHk8Zl4bEvWMeQuOwla1ZhQ==
X-Gm-Gg: ASbGncullMPFqB4wAwH1c5zw3nwSedTs7zdVfQaF/0nNnep/I8gZdhVqfq8DNS1VFqx
	7oHAeIlN5nG8m5sdDWegsxVSm5eW6O1Vh9qT/ero5U5nqLCqjd/7619GabFCaDvCQpmwzX5u9UG
	f5vlw9mSF4pkW0/a0G+Pmmg6qY9RzmoelodTmtpQstDLAMSx5jvSfUkXnzntEAR/Dv6Nv27rduD
	ARBzn/p9Gf9jTUtmDDgad7KaFB2Q83xZxRgsfjUyhzA+9Bjgjs6ILn7KxfyduXFE0znIYHgVp8a
	Jfs=
X-Received: by 2002:a05:620a:8804:b0:7ca:f447:c676 with SMTP id af79cd13be357-7ceecc7b357mr2983878485a.43.1748449468982;
        Wed, 28 May 2025 09:24:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAnXf43b6H4MlK1EjDvv8V/BsoyuWSWPUUzmroPDps16PFlFqzdhDpePuXhUVM/nmAt1nS0Q==
X-Received: by 2002:a05:620a:8804:b0:7ca:f447:c676 with SMTP id af79cd13be357-7ceecc7b357mr2983875185a.43.1748449468640;
        Wed, 28 May 2025 09:24:28 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cfc5d3a361sm87712085a.87.2025.05.28.09.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 09:24:28 -0700 (PDT)
Date: Wed, 28 May 2025 12:24:24 -0400
From: Peter Xu <peterx@redhat.com>
To: James Houghton <jthoughton@google.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Gavin Guo <gavinguo@igalia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, muchun.song@linux.dev,
	akpm@linux-foundation.org, mike.kravetz@oracle.com,
	kernel-dev@igalia.com, stable@vger.kernel.org,
	Hugh Dickins <hughd@google.com>, Florent Revest <revest@google.com>,
	Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
Message-ID: <aDc4uO_Vq-q7ks5h@x1.local>
References: <20250528023326.3499204-1-gavinguo@igalia.com>
 <aDbXEnqnpDnAx4Mw@localhost.localdomain>
 <aDcl2YM5wX-MwzbM@x1.local>
 <629bb87e-c493-4069-866c-20e02c14ddcc@redhat.com>
 <aDcvplLNH0nGsLD1@localhost.localdomain>
 <CADrL8HXD0hX+5WvtZWKXAr0NvfvOJZhqL9PVBawYQuAyzhGgYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HXD0hX+5WvtZWKXAr0NvfvOJZhqL9PVBawYQuAyzhGgYg@mail.gmail.com>

On Wed, May 28, 2025 at 12:14:28PM -0400, James Houghton wrote:

[...]

> > > For 2) I am also not sure if we need need the pagecache folio locked; I
> > > doubt it ... but this code is not the easiest to follow.
> >
> > I have been staring at that code and thinking about potential scenarios
> > for a few days now, and I cannot convice myself that we need
> > pagecache_folio's lock when pagecache_folio != old_folio because as a
> > matter of fact I cannot think of anything it protects us against.
> 
> Hi Oscar,

Hey, James,

> 
> Have you thought about the UFFDIO_CONTINUE case (hugetlb_mfill_atomic_pte())?
> 
> I'm slightly concerned that, if you aren't holding pagecache_folio's
> lock, there might be issues where hugetlb_mfill_atomic_pte() proceeds
> to map a hugetlb page that it is not supposed to. (For example, if the
> fault handler does not generally hold pagecache_folio's lock,
> hugetlb_mfill_atomic_pte() will see a page in the pagecache and map
> it, even though it may not have been zeroed yet.)
> 
> I haven't had enough time to fully think through this case, but just
> want to make sure it has been considered.

AFAIU we're talking about two separate code paths.  IIUC you're talking
about a fresh new hugetlb folio being allocated, but then that's what
hugetlb_no_page() does.  Folio lock required there.

Here IIUC Oscar's context is only in hugetlb_wp() where there's a niche use
case to compare whether a VM_PRIVATE has already CoWed once from a
pagecache, and whether we need the folio lock for the pagecache lookup.
Aka, this one:

	if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
	    !(vma->vm_flags & VM_MAYSHARE) && !huge_pte_write(vmf.orig_pte)) {
		if (vma_needs_reservation(h, vma, vmf.address) < 0) {
			ret = VM_FAULT_OOM;
			goto out_mutex;
		}
		/* Just decrements count, does not deallocate */
		vma_end_reservation(h, vma, vmf.address);

		pagecache_folio = filemap_lock_hugetlb_folio(h, mapping, <---
							     vmf.pgoff);
		if (IS_ERR(pagecache_folio))
			pagecache_folio = NULL;
	}

Thanks,

-- 
Peter Xu


