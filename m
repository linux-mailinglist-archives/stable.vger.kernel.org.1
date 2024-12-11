Return-Path: <stable+bounces-100810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E14E9ED76F
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 21:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61391888ED0
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8F204F82;
	Wed, 11 Dec 2024 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MASDn2bT"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C41BC085
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949984; cv=none; b=KRmKiqDxMtZq/VoYPuul0CvsOaHmqp/4+CPWtzLeHjRtOJxajOnn16ifitFOKJDR0M2yMbAqGSrmu42aSuq1oNO/sM0Hhwx4sCZeo2MuCsNT3wZGpa+RWFUdINVftau8BSN1IFD8CabNn40t5Jt3uXKzB8vPYxDT5fepjhzw1QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949984; c=relaxed/simple;
	bh=xNBHSTkH3SbV5gXvy0O5x3gd7FEWRoQoi+kl71valAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwX142VCrht2h7JZ8wkBISkqrGaROLJCgvEzSIeIprOLy+MEAio+4gj1R2RXsa9pZys5KU6Bbwn0t3qTtFP4yrRofSDXrxIv69Awp8N+8b8HJ+QBu+bWj9+fRnosFAGTbpeYtBWguCGIxUjdUHG7fQkYoMvUwqUXjQy1Jfuur78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MASDn2bT; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 11 Dec 2024 12:46:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733949979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DiJApXOAc0hwv3kQaHrLDZZL2Fn5Gj1tPRe5/QNMN1M=;
	b=MASDn2bT7F57NqmN2d3CBeVlxMXlXeLI2D2oKHwsORwXjWLazM9kvsmJnF1n6nffCRd1h1
	+nXpHsAaOH7pWYYGPbij5y7dwavnUIzeLUagh0gg8P7vyty1QUiJ7ySHJ/mQ6N84N9vMtU
	PzDlTD1WvnBCRZtwzXOS7gOATX+ERuk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] vmalloc: Fix accounting with i915
Message-ID: <b4fn2tcps75i4uzclwctptxrnutw4bstsfhjgel4sdjsvngdeb@3ilhvvskk2wb>
References: <20241211202538.168311-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211202538.168311-1-willy@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 11, 2024 at 08:25:37PM +0000, Matthew Wilcox (Oracle) wrote:
> If the caller of vmap() specifies VM_MAP_PUT_PAGES (currently only the
> i915 driver), we will decrement nr_vmalloc_pages and MEMCG_VMALLOC in
> vfree().  These counters are incremented by vmalloc() but not by vmap()
> so this will cause an underflow.  Check the VM_MAP_PUT_PAGES flag before
> decrementing either counter.
> 
> Fixes: b944afc9d64d (mm: add a VM_MAP_PUT_PAGES flag for vmap)
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Oh you merged them into one. Good.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

