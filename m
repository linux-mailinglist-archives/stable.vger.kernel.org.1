Return-Path: <stable+bounces-36047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C70BD899965
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 202D2B21542
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DCF15FCEC;
	Fri,  5 Apr 2024 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="oqHOIXXZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GwaGATpn"
X-Original-To: stable@vger.kernel.org
Received: from flow6-smtp.messagingengine.com (flow6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92816134404
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309202; cv=none; b=HpJgL1Qq0aKHYlFoeD3gvXagk7e1s9mOCkmhmSr5PYON2Om7yJRK5/h618xv2lv3ucVzkTpiqLo3/gyGQsgz6tweUMFj++xDEOim3zI+Ktwfd4WMMbAhh4xr8dzXrwqBsGQb465F0Pvt9OZYZyAm8aXWMAZcR62kKIDC0IbCHlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309202; c=relaxed/simple;
	bh=DT7ZbjK135dLx1DUlGChjJPF8gD6AwSyt6zl7+kiqEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSjE/8Ezv81WusLmNfAnwwBRyEWLn3ZzEH82BdUzn3nRzJjyf0KAmnKCSp/QyxgdmKoQYxbSRS4tZFX545OvxbSsPqc0DPxtEnmnVAKpGwhIrcoHm7tjcAi7OTHQHdqIY0n5+py+hZR0p7MUXbnE6+MgbHrB338g/wdiBIkoBf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=oqHOIXXZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GwaGATpn; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailflow.nyi.internal (Postfix) with ESMTP id 8B17A2003A6;
	Fri,  5 Apr 2024 05:26:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 05 Apr 2024 05:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712309198; x=1712316398; bh=VimsCt1NjU
	gB9PPOMylpZaTkqa/KezJysVgloR7X3hw=; b=oqHOIXXZu2NtbdJvQDQ/mVm5WC
	q16ZQRLKbzaPGafZZ9DV6QjyCXoJ5HgXP5zkmfwiNPfoSU+TbISbjuYbEyiHj1Hc
	JrsemMhF4n9kJJ2BYhhuts8jMxKAvigN/KGu79Wxb5cBosBSQj6oxq27KpEEEAdT
	GHi34OQ+N1eXM8LbvKcBn6HjYHT2qxbbSAdawUwuJc5EHrG0qj90ahbn83OBYrGi
	XZ2qmePQgF/iV4+kLqJ3OHknfBfA6o7gDLI3NhOrO9skcoMTbQ2sxpjthxIruyZJ
	0sV1DUxfXRt2AnuJOqHoUq/2Gz1LwmgJxNAy6C1mXvv0eAwWp0T6+8+fJZRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712309198; x=1712316398; bh=VimsCt1NjUgB9PPOMylpZaTkqa/K
	ezJysVgloR7X3hw=; b=GwaGATpnYkaAN4/IdeFWOXpUVYg64tREInPP7JXhVxT1
	WFw20RFyxEk9MdYWzFmOyc0xV1aJspQ2/TLNxAtuATvh1UHGaJu2u1NviCgKVpsp
	zYIypm4TXjjjpW6JXRQLHLAwkfmcj/URnQ1AirWMkYybhfIeNyO0sh561CR2TONY
	3c954B0Ce3b6T0W2OpZThVikXeAmSILOgzrry/vDpaSAz8zGclpAmJbUlCskQOSh
	fqcewJLelNVXtz8oO1+XDfG9sS7xAufe6DuOqargHlKq/+t572NYPvDG2eoV16a2
	mvjUeum/a6OYI19Af/d3YzB8bwu0ICy8BbAO6CdTTA==
X-ME-Sender: <xms:zcMPZgpQFW7rbjUBk8oKC49ypUFVc7kIYztv6lnmB30_21nsvCxxTw>
    <xme:zcMPZmosKsLuWCTF5JT2_N76tWNQpaoE4GevHN3ejnRCXTjnRg3N0uWWGVJCtczWV
    aNq3d5HstWh3w>
X-ME-Received: <xmr:zcMPZlN99GTzAfuHlV2Kl9BduNcwXCkFRknYFu-am10zaMiTHI5QZLfiMXcrG904Noz2WA3DTjZMsahnySq4Ui06azJxDUsCVbJpgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegtddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:zcMPZn5aGWwebNxg28FNkra26T3vYMFJXefh-KILUVrm7yVrUD3FAQ>
    <xmx:zsMPZv5_hLqYrdulejpbNI5bleu8qLSdKYnWfhngmyL10TDUn24M_Q>
    <xmx:zsMPZnhPdzjmeDykKV_nfSDtyblHssk0jkjoyBGQlFeG7x7vBJcvsg>
    <xmx:zsMPZp43cAG8M75otn0LMSJRvniMpBLlydF_MaqTmCA6wN1Tws2xcA>
    <xmx:zsMPZt5hUxtm2j07fHbQFn1jr9QAkD1KOIbFiE10cFxEBGi2gyHh1VUU>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Apr 2024 05:26:37 -0400 (EDT)
Date: Fri, 5 Apr 2024 11:26:35 +0200
From: Greg KH <greg@kroah.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: stable@vger.kernel.org, Sven van Ashbrook <svenva@chromium.org>,
	Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	Curtis Malainey <cujomalainey@chromium.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Michal Hocko <mhocko@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4.19.y] mm, vmscan: prevent infinite loop for costly
 GFP_NOIO | __GFP_RETRY_MAYFAIL allocations
Message-ID: <2024040526-antarctic-figurine-e00f@gregkh>
References: <2024032732-prowess-craving-9106@gregkh>
 <20240404153315.1766-2-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404153315.1766-2-vbabka@suse.cz>

On Thu, Apr 04, 2024 at 05:33:16PM +0200, Vlastimil Babka wrote:
> Sven reports an infinite loop in __alloc_pages_slowpath() for costly order
> __GFP_RETRY_MAYFAIL allocations that are also GFP_NOIO.  Such combination
> can happen in a suspend/resume context where a GFP_KERNEL allocation can
> have __GFP_IO masked out via gfp_allowed_mask.
> 
> Quoting Sven:
> 
> 1. try to do a "costly" allocation (order > PAGE_ALLOC_COSTLY_ORDER)
>    with __GFP_RETRY_MAYFAIL set.
> 
> 2. page alloc's __alloc_pages_slowpath tries to get a page from the
>    freelist. This fails because there is nothing free of that costly
>    order.
> 
> 3. page alloc tries to reclaim by calling __alloc_pages_direct_reclaim,
>    which bails out because a zone is ready to be compacted; it pretends
>    to have made a single page of progress.
> 
> 4. page alloc tries to compact, but this always bails out early because
>    __GFP_IO is not set (it's not passed by the snd allocator, and even
>    if it were, we are suspending so the __GFP_IO flag would be cleared
>    anyway).
> 
> 5. page alloc believes reclaim progress was made (because of the
>    pretense in item 3) and so it checks whether it should retry
>    compaction. The compaction retry logic thinks it should try again,
>    because:
>     a) reclaim is needed because of the early bail-out in item 4
>     b) a zonelist is suitable for compaction
> 
> 6. goto 2. indefinite stall.
> 
> (end quote)
> 
> The immediate root cause is confusing the COMPACT_SKIPPED returned from
> __alloc_pages_direct_compact() (step 4) due to lack of __GFP_IO to be
> indicating a lack of order-0 pages, and in step 5 evaluating that in
> should_compact_retry() as a reason to retry, before incrementing and
> limiting the number of retries.  There are however other places that
> wrongly assume that compaction can happen while we lack __GFP_IO.
> 
> To fix this, introduce gfp_compaction_allowed() to abstract the __GFP_IO
> evaluation and switch the open-coded test in try_to_compact_pages() to use
> it.
> 
> Also use the new helper in:
> - compaction_ready(), which will make reclaim not bail out in step 3, so
>   there's at least one attempt to actually reclaim, even if chances are
>   small for a costly order
> - in_reclaim_compaction() which will make should_continue_reclaim()
>   return false and we don't over-reclaim unnecessarily
> - in __alloc_pages_slowpath() to set a local variable can_compact,
>   which is then used to avoid retrying reclaim/compaction for costly
>   allocations (step 5) if we can't compact and also to skip the early
>   compaction attempt that we do in some cases
> 
> Link: https://lkml.kernel.org/r/20240221114357.13655-2-vbabka@suse.cz
> Fixes: 3250845d0526 ("Revert "mm, oom: prevent premature OOM killer invocation for high order request"")
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reported-by: Sven van Ashbrook <svenva@chromium.org>
> Closes: https://lore.kernel.org/all/CAG-rBihs_xMKb3wrMO1%2B-%2Bp4fowP9oy1pa_OTkfxBzPUVOZF%2Bg@mail.gmail.com/
> Tested-by: Karthikeyan Ramasubramanian <kramasub@chromium.org>
> Cc: Brian Geffon <bgeffon@google.com>
> Cc: Curtis Malainey <cujomalainey@chromium.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 803de9000f334b771afacb6ff3e78622916668b0)
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

All backports now queued up, thanks!

greg k-h

