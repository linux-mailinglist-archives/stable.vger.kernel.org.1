Return-Path: <stable+bounces-100809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 360D39ED76B
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 21:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4CD1888ED0
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4E71D14EC;
	Wed, 11 Dec 2024 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZShGqhjR"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF33CA4E
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949935; cv=none; b=SrC0Pe4Uda/xYZY2sFk+Mhg8vDo+tKhf0AkycngAgM1+fjuTy7CYDw2ikcr/PAKsYr7Sbrwg66ff9cfeF25lLglGjuB3mPzssjs83sFRSLotO5/bGl+97fkdVp+APaIDWy+cXbsGifOEA1k/WQdvDR64V75h+IP7AHTim99EDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949935; c=relaxed/simple;
	bh=FRML3w5HTZhYPZN17cyzuQ7Q763sSZfK4yHPaykRUkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVaqkSGF7RhEBjW0+igtig2VZB4MpKk+PvNoxQ5ExG8oeJKUeRmkl0P7TVXdvvQa+P7ynd5LA56IYjGHZ9/dRqchV7ScYBu3mnsa2qo0hnb1qBvkzalIhjttqwFQt/eT98Q9/LpoTpuGnfJz3c1/k57gkhH32+Wt1vHtIgEZscQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZShGqhjR; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Dec 2024 12:45:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733949920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w7t+KorEtSawtI5MSpoIQmlEIOdqN2q2ix3mEzFEVRs=;
	b=ZShGqhjRRetiCdBj+MmiL6GOD9OmmWicXoCHHVHgDfHNAoy8aJrCIFonrEKRftLNLOweHL
	JRfUHvz2WMEDQ7T4GukNikeovUnXjs+N+QHoP1uebhRgtuCKhm9NMHCd7odz4ZW+Zbm5kE
	SHXSoU8qSsIsNocyhw30ygtWTQxq7cI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] vmalloc: Fix accounting of VmallocUsed with i915
Message-ID: <ocj6ojwevnbdp6y52z7yv3jf2xyt7l3kiccurg27utpcem33oa@j3b4cjcbow5v>
References: <20241211043252.3295947-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211043252.3295947-1-willy@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 11, 2024 at 04:32:49AM +0000, Matthew Wilcox (Oracle) wrote:
> If the caller of vmap() specifies VM_MAP_PUT_PAGES (currently only the
> i915 driver), we will decrement nr_vmalloc_pages in vfree() without ever
> incrementing it.  Check the flag before decrementing the counter.
> 
> Fixes: b944afc9d64d (mm: add a VM_MAP_PUT_PAGES flag for vmap)
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

