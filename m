Return-Path: <stable+bounces-86787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67339A388A
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 10:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862A3281843
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 08:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9182418E040;
	Fri, 18 Oct 2024 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p9KD15ev"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4598F18E05A
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729240179; cv=none; b=SFx6doc4esdd+rhDtO5l7XfvjfQshzAF7UY8SLXqhjUerqoQuUQOOSxoWzj1iM3jIY3Fyi/zFafO+tgyzbXITk5ABL9taG85mYZ+mt60R6VtjWNybEyTyQxTAIMUa1WDCj3dgS3xDCRFXRkRIQAe6OrKUEqntnoDTrxiSgomUfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729240179; c=relaxed/simple;
	bh=ojL81khYa8IkdW1dyUebCxemKtwNvomtpyK+SPOMEQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXsFraXw77WZlzSPJt37AfTdUoudCkhYWKJpuNAF6LRZuxAfO9/eWOCEwfeckX8MdbPgndAvpWnnqzD9LiJ1VO+k74r69jvH7UYgwNtO5CEN2IyZDOXlTPeSxyBvYRZNt/of72M2ZWfEN8YHfpRFMPar25nTXdjXDUqhts5Yfn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p9KD15ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F72C4CED0;
	Fri, 18 Oct 2024 08:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729240179;
	bh=ojL81khYa8IkdW1dyUebCxemKtwNvomtpyK+SPOMEQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9KD15evXRFGlBRR29Gmn605qDbirs341cnsgIY+gOuEMQnquwL6zsFCiKguFcmjN
	 gnTdtxyuD26ZaR2K63lhb6PgMIGUEtvGfaWLTQ4nsDcBhpg+aNlGavTWDToI38Lxee
	 och0VgEg1q+l92Tu9nYiVkLUkVL2ZkMm0It/FMGE=
Date: Fri, 18 Oct 2024 10:29:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: chrisl@kernel.org
Cc: stable@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>, Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 6.11.y 2/3] mm/codetag: fix pgalloc_tag_split()
Message-ID: <2024101850-dwarf-payday-8d15@gregkh>
References: <20241017-stable-yuzhao-v1-0-3a4566660d44@kernel.org>
 <20241017-stable-yuzhao-v1-2-3a4566660d44@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017-stable-yuzhao-v1-2-3a4566660d44@kernel.org>

On Thu, Oct 17, 2024 at 02:58:03PM -0700, chrisl@kernel.org wrote:
> From: Yu Zhao <yuzhao@google.com>
> 
> [ Upstream commit 95599ef684d01136a8b77c16a7c853496786e173 ]
> 
> The current assumption is that a large folio can only be split into
> order-0 folios.  That is not the case for hugeTLB demotion, nor for THP
> split: see commit c010d47f107f ("mm: thp: split huge page to any lower
> order pages").
> 
> When a large folio is split into ones of a lower non-zero order, only the
> new head pages should be tagged.  Tagging tail pages can cause imbalanced
> "calls" counters, since only head pages are untagged by pgalloc_tag_sub()
> and the "calls" counts on tail pages are leaked, e.g.,
> 
>   # echo 2048kB >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote_size
>   # echo 700 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>   # time echo 700 >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote
>   # echo 0 >/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
>   # grep alloc_gigantic_folio /proc/allocinfo
> 
> Before this patch:
>   0  549427200  mm/hugetlb.c:1549 func:alloc_gigantic_folio
> 
>   real  0m2.057s
>   user  0m0.000s
>   sys   0m2.051s
> 
> After this patch:
>   0          0  mm/hugetlb.c:1549 func:alloc_gigantic_folio
> 
>   real  0m1.711s
>   user  0m0.000s
>   sys   0m1.704s
> 
> Not tagging tail pages also improves the splitting time, e.g., by about
> 15% when demoting 1GB hugeTLB folios to 2MB ones, as shown above.
> 
> Link: https://lkml.kernel.org/r/20240906042108.1150526-2-yuzhao@google.com
> Fixes: be25d1d4e822 ("mm: create new codetag references during page splitting")
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Acked-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

You did not sign off on this backport, so even if I wanted to take it, I
couldn't :(

Please fix this, and patch 3/3 up, and just send those.

sorry,

greg k-h

