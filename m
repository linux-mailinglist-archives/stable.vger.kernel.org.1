Return-Path: <stable+bounces-148112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECD1AC81FF
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 20:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E731C03107
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 18:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD96422FE0D;
	Thu, 29 May 2025 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sbjEQdxp"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226BE22F75E
	for <stable@vger.kernel.org>; Thu, 29 May 2025 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748542442; cv=none; b=BQfSXG53wFAEnMn7XyGlgxRYQgEc1yGUaxI0pPwm8EeVIt41x9StW9Todre0g7zj/LQNcySvaChmdCSCYLS5beXDZnSPd5uvfcFC8GsIyz5J7CpJzGOtGdXhTGMa0Q9liwzDq3PwTC8+SU7d0N7Lcb2xJU1mULCH5HlMkmXAsD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748542442; c=relaxed/simple;
	bh=NemdL54bnOcp0tP6a+ElySUO8zbK/K1HzrBb2hqa4yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzkqIY7bAWpFl6k6XOiZUjNHnNecUXX9NdY3knn129ISfSnUS6x20JtPTlSZj6xqrQs8reyQXexBLbtRCcZUcUwSMNIq25K5vhvOnkU/PAOyZK58LBbgMnQCdVMkItSsGRhJy02zIEt5QVeHu0hDKMZXr/oiVctDy/9eZumNGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sbjEQdxp; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 May 2025 11:13:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748542437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AX+Z+FU7v3e67d6zdoj3TbbyWOI/VVebECq9cL7CD2s=;
	b=sbjEQdxp2oh7NLmxDQfyE3K6ahSO5JIX4xvan1uNCVM+YUU6vqzQBNHtoX7/RYvpJhldEQ
	hAWVaJuERmfTZkudZNofLJj7eCfCiUbSszeKfrJ5g7KXWSaEjZySh8oaJUBGOW8FRrUFSX
	7Cdcyqh2TpNbGRcihf/J11DMxdCV+sw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Hongyu Ning <hongyu.ning@linux.intel.com>, stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] mm: Fix vmstat after removing NR_BOUNCE
Message-ID: <fhpxqctusqtn5cpyihf6z2esmujofi2ra7gknelms2ta4p2riv@3s7bxucy6quf>
References: <20250529103832.2937460-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529103832.2937460-1-kirill.shutemov@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 29, 2025 at 01:38:32PM +0300, Kirill A. Shutemov wrote:
> Hongyu noticed that the nr_unaccepted counter kept growing even in the
> absence of unaccepted memory on the machine.
> 
> This happens due to a commit that removed NR_BOUNCE: it removed the
> counter from the enum zone_stat_item, but left it in the vmstat_text
> array.
> 
> As a result, all counters below nr_bounce in /proc/vmstat are
> shifted by one line, causing the numa_hit counter to be labeled as
> nr_unaccepted.
> 
> To fix this issue, remove nr_bounce from the vmstat_text array.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> Fixes: 194df9f66db8 ("mm: remove NR_BOUNCE zone stat")
> Cc: stable@vger.kernel.org
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

Can we put BUILD_BUG_ON() to avoid this situation in the future?


