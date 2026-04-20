Return-Path: <stable+bounces-239950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGt4NFxf5mkWvgEAu9opvQ
	(envelope-from <stable+bounces-239950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:16:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 543E9430DA3
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB6FA30E1791
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343933793A6;
	Mon, 20 Apr 2026 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F/jR/IpR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E108737883C;
	Mon, 20 Apr 2026 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776703873; cv=none; b=Kgw2H4CHYdRkKJBlXe7zn/9i4nR3ZnQ7wZB6LqbDiJtgOh+PKFvjfC+J5f/rC0w6NYJ2FVRtcJ1FWouK+QuE33eVnGfOdoRfZ42b8fz93C5UNIk+RMdsSxaE0OaKXHvInVBtA/+WD6lEyZv4oMXXR9xNfmLg7G/BMoB5vh6iTbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776703873; c=relaxed/simple;
	bh=jv9KBJPeWPD7HQ/S6MXPqVdupIpZZVJJB35zyCJWuOE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ADBHLq0n94l5ok27VB7bQmy5/qpitAI+S5e55xTI+OM7a3CG8wiAKhiMo+Gr49zAitrfBQ6cpGqyBU7SHhznsbYyJr8jSvOQdV1Mx+gKeW2p3DJIvnVWvKdXw+YKzndTkx2w93x35bvljw9168WHOQmgP9Yn4AvB/I/NjaV5EwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F/jR/IpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358F7C19425;
	Mon, 20 Apr 2026 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776703872;
	bh=jv9KBJPeWPD7HQ/S6MXPqVdupIpZZVJJB35zyCJWuOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F/jR/IpRjnuPCyTQ/2dwBsw6QpfproLKZqT5GNGgZDHEFWfm2VclIV3GrcLYyBfti
	 ZT82lfiiz1xenX/v9WRDFbONv9BMa5AbbbQQpSzzGr0uSr7oU3qyrVz3MgxHOQEFjo
	 UGDOf6ytD+3+LqlmBNFC2NwfwKTdQOBbVhUxqMLo=
Date: Mon, 20 Apr 2026 09:51:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: <linux-kernel@vger.kernel.org>, <ritesh.list@gmail.com>,
 <abuehaze@amazon.com>, <alisaidi@amazon.com>, <blakgeof@amazon.com>,
 <brauner@kernel.org>, <dipietro.salvatore@gmail.com>, <djwong@kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-xfs@vger.kernel.org>, <stable@vger.kernel.org>,
 <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] mm/filemap: avoid costly reclaim for high-order
 folio allocations
Message-Id: <20260420095106.86ecdb685cd31e0847362512@linux-foundation.org>
In-Reply-To: <20260420161404.642-1-dipiets@amazon.it>
References: <20260420161404.642-1-dipiets@amazon.it>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239950-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,amazon.com,kernel.org,kvack.org,infradead.org,suse.cz];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.it:email,linux-foundation.org:dkim,linux-foundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 543E9430DA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026 16:14:03 +0000 Salvatore Dipietro <dipiets@amazon.it> wrote:

> Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> introduced high-order folio allocations in the buffered write path.
> When memory is fragmented, each failed allocation above
> PAGE_ALLOC_COSTLY_ORDER triggers compaction and drain_all_pages() via
> __alloc_pages_slowpath(), causing a 0.75x throughput drop on pgbench
> (simple-update) with  1024 clients on a 96-vCPU arm64 system.
> 
> In __filemap_get_folio(), for orders above min_order, split the
> allocation behavior by cost:
> 
>  - For orders above PAGE_ALLOC_COSTLY_ORDER: strip
>    __GFP_DIRECT_RECLAIM, making them purely opportunistic. The
>    allocator tries the freelists only and returns NULL immediately if
>    pages are not available.
> 
>  - For non-costly orders (between min_order and
>    PAGE_ALLOC_COSTLY_ORDER): use __GFP_NORETRY to allow lightweight
>    direct reclaim without expensive compaction retries.
> 
> With this patch, pgbench throughput recovers to 148k TPS (+67% vs
> regressed baseline), stable across all iterations.

"Good money after bad"?  Prove me wrong!

Instead of performing weird fragile hard-to-maintain party tricks with
the page allocator to work around the damage, plan B is to simply
revert 5d8edfb900d5.

5d8edfb900d5 came with no performance testing results.  Does anyone
have any evidence that it improved anything?  By how much?

> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2007,8 +2007,13 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
>  			gfp_t alloc_gfp = gfp;
>  
>  			err = -ENOMEM;
> -			if (order > min_order)
> -				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
> +			if (order > min_order) {
> +				alloc_gfp |= __GFP_NOWARN;
> +				if (order > PAGE_ALLOC_COSTLY_ORDER)
> +					alloc_gfp &= ~__GFP_DIRECT_RECLAIM;
> +				else
> +					alloc_gfp |= __GFP_NORETRY;
> +			}
>  			folio = filemap_alloc_folio(alloc_gfp, order, policy);

I don't think it's reasonable to expect a reader to understand why this
code is as it is.  Hence each clause here should have a comment
explaining why we're taking that step, please.


Look.  I'm being grumpy.  We know that patches which purportedly
improve performance must come with quality performance testing results.
How long have we been at this?

