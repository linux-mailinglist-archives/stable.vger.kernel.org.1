Return-Path: <stable+bounces-204494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DA5CEF008
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 17:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A098302F802
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 16:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1459F2C0F7E;
	Fri,  2 Jan 2026 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WMzmNr51"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCA12C11C9
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767372233; cv=none; b=svhZ0uDeZOgt1R8+ybUbc+4K1XYii/K6ieFJTdToeqU9fP+3xipqEMo3qXnghaVLV2aFaq5N7FDAKoaOQwwfYww5LuOBlaudc003YwHJJWwp3V/N1AE5DVWmE97AQSBEMNzL5TNHAa0xHOTtz+w/gp/8Dh//XlYqHqhkbdGVTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767372233; c=relaxed/simple;
	bh=rULonQ0HglXdZDgo1SKgcXHBStBXxbk6PRByY2MpwWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPOda+1RJ6wrjopRkzakj3tLaKtcyhMP7pcPhQTTxLqTg2Ct/ezgX3ErHShtR0v/LEXEAYypyDB2PYKCk0C3mDaRYUDHGGUkbFgJgEgWj/DARBVhEzo6EknuqRU/22Bw/uxEzNLeCoBa49I6ozYROdTGWezqC6BdwslFMcnGEtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WMzmNr51; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 2 Jan 2026 16:43:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767372219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lNfLrQjp/p3L3Sry3hdlByeYf8y53FPHj5UXmLcNYRI=;
	b=WMzmNr51WTVi6ClJJ1cnbLSLvxkjGjvlz92q4TR8JTo1n+CYavpsdQ8AJQqa3u7jhJjXkS
	Jv51XdM0pk5CbMr9ItfHfOQqQmcQg1J5n2X00iax0n8cP43UAZGMh1t7Z4EgvZDBNGR56R
	rLVP5U4SnEYGUpnTQkXkV243NyyxQLI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Pavel Butsykin <pbutsykin@cloudlinux.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/zswap: fix error pointer free in
 zswap_cpu_comp_prepare()
Message-ID: <prkvck4d7m5tra7sbonygvd6mtmdqj7lyj5wps4mjwkvunpkol@lm5sefrcedgd>
References: <20251231074638.2564302-1-pbutsykin@cloudlinux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231074638.2564302-1-pbutsykin@cloudlinux.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 31, 2025 at 11:46:38AM +0400, Pavel Butsykin wrote:
> crypto_alloc_acomp_node() may return ERR_PTR(), but the fail path checks
> only for NULL and can pass an error pointer to crypto_free_acomp().
> Use IS_ERR_OR_NULL() to only free valid acomp instances.
> 
> Fixes: 779b9955f643 ("mm: zswap: move allocations during CPU init outside the lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavel Butsykin <pbutsykin@cloudlinux.com>

Thanks for the fix!

Acked-by: Yosry Ahmed <yosry.ahmed@linux.dev>

> ---
>  mm/zswap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 5d0f8b13a958..ac9b7a60736b 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -787,7 +787,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
>  	return 0;
>  
>  fail:
> -	if (acomp)
> +	if (!IS_ERR_OR_NULL(acomp))
>  		crypto_free_acomp(acomp);
>  	kfree(buffer);
>  	return ret;
> -- 
> 2.52.0
> 

