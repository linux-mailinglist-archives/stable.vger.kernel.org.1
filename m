Return-Path: <stable+bounces-61886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E9293D60B
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 17:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074432866EF
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA3017B404;
	Fri, 26 Jul 2024 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaPCpA4S"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669BD17838B
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007589; cv=none; b=ZkEU2OBc1Lqzl7rLJfWM9i9RMS4jMiqY1ZlbedUjA5u8q9lrche4rAypCv0GcrGoMFaS7Sz/8jC9/5Xn4U9e5LllhW5NP++JdKw/2aU1pWbQOH2Vl9yoqBfaPmKYbJRYM+WhNR9lwqVPudHWUrR3mRLmEtOZ59Ac7FegnUckQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007589; c=relaxed/simple;
	bh=RbHU4UP1JY5wKgN+Oh9cKQ22ngJhE4XdAkK8ZKK+P04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deHmsBkP8GYhew/Kod1K5Gz6xUmDGyEpqblyoLNCZc7aqFzecI/UHC8LtLgFTf3OP6CHCZvE9ZIra9tOtYIDSXzoAH18W0fU9pMdwOXWC7UkI1k8/ShGm5VLSsi+CjfjEHlRSHLTC6dp2IzMpWIxSYY3hS9gz+RUlfiVoFRxS4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iaPCpA4S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722007586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HQNYIPK7LP0OA8/oIlZfnEndy7+rTzNkw4e6NMHkIEk=;
	b=iaPCpA4SF/U/RO8TSNxCWAHJqzuIFKx1meYyNaQjXw7EKCMYJky7VtzK/X9swveIzofFEu
	xbcexK2jZJyX8im10zJ5j/+ZBbQbZuBDwbNdb0KtPuyKhDaf8ayPyiu9vwbikq9I7UTsUt
	X/aTFKMoxasaMKJT9VJh7FKMNksSj0M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-AtvzCp48MSKmvP8YWc6ZLw-1; Fri, 26 Jul 2024 11:26:24 -0400
X-MC-Unique: AtvzCp48MSKmvP8YWc6ZLw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b792d6fe5bso1219466d6.2
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 08:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722007584; x=1722612384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQNYIPK7LP0OA8/oIlZfnEndy7+rTzNkw4e6NMHkIEk=;
        b=bZwL/myghenovYc+7iZHLJAYUFNVu+DVWb9dcZPLFOu74lN/+eOwCLcYXPGQdCHejT
         y6ftXWXtUmdAY5qETswaRmAFzKipY4UILByNwIJZU3PzDPH9cdLVQpE6kIkTo2Vwre8T
         7ZXMmO9rxnx80eFqJrUrR0G+pQAsvJql4x9VhfXwK/NgN+xc6Jww6rRMXYYpbbd2QXNB
         /hMnpHPBu68wF6eO98qdvtvpc93tSIbAoPlon01utsa5BWO6PGTXqPi97je7es7Zxw6i
         +KAiyjwzA1EFdm+75o4kuD6T88VKV0p/4mgcVuNJTXvpHRO6NrAxMx/8nlyqkbVxThKH
         tJwA==
X-Forwarded-Encrypted: i=1; AJvYcCVT6yBncyXa4vgSz5Mj8ontefqkF9ujMuOaxrSV22tVbuqQYzRxWcqitq5yK5iWw5ax4x7YJSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr97kfCOWpXcaODNOSjQMm2znUUn5mwwCAxqBVtlrnFPwdALPu
	4W/RkVILmi9TLZkqcqDfsFtBCTF4UYtnBwJzwHzcbUqYPQ4rFfRPrcFyE/r2DzjjKAWWbtJpo1E
	BzkVdq5yC8Lv1iSX7vNA9INoqq4ZuxyNRGGw4UPWhchPYETj3HVPHLw==
X-Received: by 2002:a05:6214:d4f:b0:6b5:ddc3:f610 with SMTP id 6a1803df08f44-6bb3e2d368amr41051806d6.6.1722007584077;
        Fri, 26 Jul 2024 08:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCcOtmcKwMx6TXZjWFNTwpesdryp7ZSGGDThfHjU5YW3rn/SrGkp+RZ71WQrrnKaPTgZEnHg==
X-Received: by 2002:a05:6214:d4f:b0:6b5:ddc3:f610 with SMTP id 6a1803df08f44-6bb3e2d368amr41051676d6.6.1722007583704;
        Fri, 26 Jul 2024 08:26:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fb0bf4asm17526386d6.139.2024.07.26.08.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:26:23 -0700 (PDT)
Date: Fri, 26 Jul 2024 11:26:20 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
Message-ID: <ZqPAHDBDOtABrk_3@x1n>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240725183955.2268884-3-david@redhat.com>

On Thu, Jul 25, 2024 at 08:39:55PM +0200, David Hildenbrand wrote:
> We recently made GUP's common page table walking code to also walk
> hugetlb VMAs without most hugetlb special-casing, preparing for the
> future of having less hugetlb-specific page table walking code in the
> codebase. Turns out that we missed one page table locking detail: page
> table locking for hugetlb folios that are not mapped using a single
> PMD/PUD.
> 
> Assume we have hugetlb folio that spans multiple PTEs (e.g., 64 KiB
> hugetlb folios on arm64 with 4 KiB base page size). GUP, as it walks the
> page tables, will perform a pte_offset_map_lock() to grab the PTE table
> lock.
> 
> However, hugetlb that concurrently modifies these page tables would
> actually grab the mm->page_table_lock: with USE_SPLIT_PTE_PTLOCKS, the
> locks would differ. Something similar can happen right now with hugetlb
> folios that span multiple PMDs when USE_SPLIT_PMD_PTLOCKS.
> 
> Let's make huge_pte_lockptr() effectively uses the same PT locks as any
> core-mm page table walker would.
> 
> There is one ugly case: powerpc 8xx, whereby we have an 8 MiB hugetlb
> folio being mapped using two PTE page tables. While hugetlb wants to take
> the PMD table lock, core-mm would grab the PTE table lock of one of both
> PTE page tables. In such corner cases, we have to make sure that both
> locks match, which is (fortunately!) currently guaranteed for 8xx as it
> does not support SMP.

Do you mean "does not support SPLIT_PMD_PTLOCK" here instead of SMP?

> 
> Fixes: 9cb28da54643 ("mm/gup: handle hugetlb in the generic follow_page_mask code")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Patch looks all right to me:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!

-- 
Peter Xu


