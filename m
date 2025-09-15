Return-Path: <stable+bounces-179652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF6DB585CE
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 22:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561E53A1269
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 20:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2927B28BA83;
	Mon, 15 Sep 2025 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p0JxLlYo"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA84A04
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967302; cv=none; b=Dxch8UtHZ7vfD8Si7WTbl7dmHkhOlHOD3mI0C7QBMHy0Gh3D+bwH3C0JPPR/HwyM/oxQWg8KF9Xs+GC1RcZXG+a7pY9hHLcaosa15Q8fYSyOF2eHx18pM2nFN8+C2+4KBOxFuPe0bqlTjXRN4xne/xF/lpe8tzGpqvUj7Pz0nFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967302; c=relaxed/simple;
	bh=kRfgRKlQGaXihKWS4z6jpHw3QReZKKLzjJ3cHsN3FUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBAA0zF7qquo+/euuyA0MMrltbVK2/TwcqU7+/u/s0mP8ymd/omXuHy8PJSf7C9j/X5vQcI/3uAGAhVUJFXoFXr00jBvUEuLSAnP6FS5B2EHI17AXMSP89Os5WiUImwt239zT7pHtmoMte1XrIOevklrSy5vqFcCFetL8h49ZUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p0JxLlYo; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Sep 2025 13:14:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757967297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/i2I5DeaWOvcMJn5TU1coJuYZxH6rbblO4Do7zaM7lQ=;
	b=p0JxLlYoGJ9/kmI9rASJEFGviUAXrEweuYwFpc7XvrySnalbtunyuVtgagnOYv6ZRp6LZa
	v1AV3z3CCCg6AFVYIcvmX8f0adPpHfd840BJaMi+NHS2qZPnRWWMk9Erf03W4GcRqw8P9R
	o+qSI2BNh96FbOWSz6l2NEKON2w/0Ag=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org, 
	rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com, 
	alexei.starovoitov@gmail.com, usamaarif642@gmail.com, 00107082@163.com, souravpanda@google.com, 
	kent.overstreet@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] slab: prevent warnings when slab obj_exts vector
 allocation fails
Message-ID: <wb63gbfs3x7hyhy6kzkg5ggn4mgngwrumkpvkg4fg2ju7oeg35@2ls4eggjpfqv>
References: <20250915200918.3855580-1-surenb@google.com>
 <20250915200918.3855580-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915200918.3855580-2-surenb@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 15, 2025 at 01:09:17PM -0700, Suren Baghdasaryan wrote:
> When object extension vector allocation fails, we set slab->obj_exts to
> OBJEXTS_ALLOC_FAIL to indicate the failure. Later, once the vector is
> successfully allocated, we will use this flag to mark codetag references
> stored in that vector as empty to avoid codetag warnings.
> 
> slab_obj_exts() used to retrieve the slab->obj_exts vector pointer checks
> slab->obj_exts for being either NULL or a pointer with MEMCG_DATA_OBJEXTS
> bit set. However it does not handle the case when slab->obj_exts equals
> OBJEXTS_ALLOC_FAIL. Add the missing condition to avoid extra warning.
> 
> Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark failed slab_ext allocations")
> Reported-by: Shakeel Butt <shakeel.butt@linux.dev>
> Closes: https://lore.kernel.org/all/jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: stable@vger.kernel.org # v6.10+

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

