Return-Path: <stable+bounces-110940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D272A206E0
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 10:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169E516465C
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 09:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545D61B0420;
	Tue, 28 Jan 2025 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="legqiZgm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92511DF723
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738055642; cv=none; b=jYiE197jRtHSgXJjK3moUUx+gMxVVTYQSjaQvGaLH+ttrazttbY4CbmrFVNri/oFNjWSVBwlCojOJS7D2Vq/MAGCf1YmoN97imfimsKt9DMlcfXh4xWXs/OeqvW5XsJ1yqlUTSTTOX1qGq1nLBvBCG0DMdThka/mOZenOozWFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738055642; c=relaxed/simple;
	bh=6zaq9+VqJAnn+K2heWIoKEiqTIfR5pSotvPa7dF6gFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQWJf3YCYHrcMv4ZV5RS3wuI+7t8R5QVnItJt7iX+28d7qwdjqCmwgtmr+MpdKnJByAGODFMKuhy+tfvQIkK2haJ09EGfCrQCC5O1PsAuVtS/8F3zTP6eHHw/5NqZiOs4jH94ok83qkomBSyNSgRnGU0BZD5odnQgFRGdclAojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=legqiZgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0724EC4CED3;
	Tue, 28 Jan 2025 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738055641;
	bh=6zaq9+VqJAnn+K2heWIoKEiqTIfR5pSotvPa7dF6gFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=legqiZgmEyVsaE0ucD960eI28pBTtLscIdi7zBtIeu4NzywsuDG36V4lLRQBuw5dW
	 gN1H8rryQrCB8hBkVI6OSzpF6Gax8t+hVEVJEOJSLUGMER5QNjrfUdFGVG6W/t6zG0
	 H11RLT7zqQWQDZIjvtBK1FFMY9OEpI8Ny/lFEgsg=
Date: Tue, 28 Jan 2025 10:13:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6.12 hotfix] mm/zswap: fix inconsistent charging when
 zswap_store_page() fails
Message-ID: <2025012842-rebuilt-snugly-518f@gregkh>
References: <20250128174938.2638-1-42.hyeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128174938.2638-1-42.hyeyoo@gmail.com>

On Wed, Jan 29, 2025 at 02:49:38AM +0900, Hyeonggon Yoo wrote:
> Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
> mistakenly skipped charging any zswapped pages when a single call to
> zswap_store_page() failed, even if some pages in the folio are
> successfully stored in zswap.
> 
> Making things worse, these not-charged pages are uncharged in
> zswap_entry_free(), making zswap charging inconsistent.
> 
> This inconsistency triggers two warnings when following these steps:
>   # On a machine with 64GiB of RAM and 36GiB of zswap
>   $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-ng
>   $ sudo reboot
> 
>   Two warnings are:
>     in mm/memcontrol.c:163, function obj_cgroup_release():
>       WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
> 
>     in mm/page_counter.c:60, function page_counter_cancel():
>       if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=%lu\n",
> 	  new, nr_pages))
> 
> Charge zswapped pages even if some pages of the folio are not zswapped.
> After resolving the inconsistency, these warnings disappear.
> 
> Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")

This commit is in 6.13, not 6.12, so your subject line is a bit
confusing :(


