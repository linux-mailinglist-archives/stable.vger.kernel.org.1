Return-Path: <stable+bounces-70341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E91960AA0
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC24283C7E
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6259B1BA270;
	Tue, 27 Aug 2024 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ULn3o9V6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JgBxu/VG"
X-Original-To: stable@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13651BA87C
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762299; cv=none; b=UAxruOeSSpH/uSe5egj7NlAH5OPZz/SA8PFYlVWjTqgkKxyaR+zNcKcCrpRtxh48fLIs+Rm1A5uEZ0LpPPbDHBt5wjt9in+qLFT8B0MbDhnHNTbMWsGM/OvXflCleLzqzdjanoHHxLFVUN1Si1ORodZrTDsgbrT/dCANSRJjMLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762299; c=relaxed/simple;
	bh=8oAlVB2p14p1FmjiAn0gTUbGgIB9XKe8/9pLUoFv3s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QepSuKNo2LJ5HfezjDRHwPDL3VETtYC72N0DqGbUu3zu5/molyP5W143Z419oOp/IiRwcl1aaWVnau1o/3lTB4674yYoyy7p3eTCvTMmqcfBnu58NBKNzHCAZYgtPRdRICDXL+G/tEiW0vmD52qbHxxOoqQYrCoqBX3874+wLgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ULn3o9V6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JgBxu/VG; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8C419138FFCB;
	Tue, 27 Aug 2024 08:38:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 27 Aug 2024 08:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724762295; x=1724848695; bh=x+b75gcQQ4
	D2jsQaGN9hmr9Esk93TZGMzIfRZ+WRoyU=; b=ULn3o9V6a8h7BwNc8Ya3LFplRt
	kf9FN0IT8uc055PA3URwtqnd1hW1kGAOol+263vGgrfpMewkDuq3GcrdPzPHJzsK
	c4RPtHen0y9zDN8uL0v6BIse2Rfx/deR90vId3pU982naGUoExjBP6aW4nx8a/Z0
	cq/hIdqmtxvtHwzZpz+XWdoo81dHDyh8xslUmjgMSSTvgtHrlIVbxGCcHtMbMAjG
	hpRf/F/G+KiDq81ZeHsyjBdObcq+WPBIxR+pXwCc4ZKgu0q42PsHwYTgShmk18qu
	dbwVBn2TsbWPXi2NGDdyKlitjW+HhzmhIo6499fSz1jwy5/QPHdCOl+WAlXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724762295; x=1724848695; bh=x+b75gcQQ4D2jsQaGN9hmr9Esk93
	TZGMzIfRZ+WRoyU=; b=JgBxu/VGpOZ3EQItErgYxL/sDs0vwOwVdkCcC/f3nbww
	FqO4BumzD36GwgLJ9TD9lFeHmYQaj3X/po6T50mbHQy2yQgbYp9sA/T8VXWaLofu
	iCg4y7HIy+8620KVHzx3mxfDlnQl5qhSMQ1WH66i4762IaWyaBBT+lJwiO27+6he
	BaW6iAD2cObDryiAYf89d4+5u3/w2Bd+bsZVIjh5gTJLbg/ECGixRiEAx6ISB/CI
	qrrWolb84DfwT36e42ED0Fy7UR3PrK6a5QjqDYfoLQUWEA1hZuChtDoJykg1OWmF
	+D1fIQvTxYi7QFgukVe5GNJ2a9dcMfdv8aed8NPuEA==
X-ME-Sender: <xms:t8jNZkFb0gGA0Nk94dsVhLQSPuCRwME4XbQVMHrmEucwx0fCyNB0UA>
    <xme:t8jNZtVcb4puHQiHwqeqxL4x6Vd6BrvGfo9uLcakhiQHsuO4xU2vtTofhEdJ40WLy
    eC8_7qkk8MZJQ>
X-ME-Received: <xmr:t8jNZuI8jkDrYG7yGj2xvo8CkGpiXHq1LzKGIDBwKSDriRn4Qmw4jdqM5zx2J7JED7nU8Oi6UcWlkMB9ocZRJuO9flgdl2lkBRDD_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeftddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeel
    vedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrg
    hilhhonhhgrdhlihhusehophhpohdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeiihhgvnhhgthgrnhhgqhhurghnse
    hophhpohdrtghomhdprhgtphhtthhopegshhgvsehrvgguhhgrthdrtghomhdprhgtphht
    thhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopegsrghohhhurgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhhohgtkhhosehsuhhsvgdrtghomhdprhgt
    phhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghkph
    hmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:t8jNZmFkfqgissyx34rP3er529CRj5aeYnZSuPpGHr2YPVkJwfs5fg>
    <xmx:t8jNZqWnry-eNLjby0cdc8XZrKtWj4VvhnBh7wsit1r28KyYo9T4MA>
    <xmx:t8jNZpM7a0GHVc_k5Ctr1b2a57eEU_8v6GiaiX6dwlPOHv_Bf_peCQ>
    <xmx:t8jNZh0BUAo_Q0GSR2M_3USnicWLphsARgx8HOb5eQxum7TBbibhIw>
    <xmx:t8jNZhOydwuGuZz1U5Srl4slCR-JLjbkz3zmHBIh81gKChpf9UfvHCmZ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Aug 2024 08:38:14 -0400 (EDT)
Date: Tue, 27 Aug 2024 14:38:07 +0200
From: Greg KH <greg@kroah.com>
To: Hailong Liu <hailong.liu@oppo.com>
Cc: stable@vger.kernel.org, Tangquan Zheng <zhengtangquan@oppo.com>,
	Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/vmalloc: fix page mapping if
 vm_area_alloc_pages() with high order fallback to order 0
Message-ID: <2024082702-footer-comment-cb33@gregkh>
References: <2024081918-payday-symphonic-ac65@gregkh>
 <20240820085242.18631-1-hailong.liu@oppo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820085242.18631-1-hailong.liu@oppo.com>

On Tue, Aug 20, 2024 at 04:52:42PM +0800, Hailong Liu wrote:
> The __vmap_pages_range_noflush() assumes its argument pages** contains
> pages with the same page shift.  However, since commit e9c3cda4d86e ("mm,
> vmalloc: fix high order __GFP_NOFAIL allocations"), if gfp_flags includes
> __GFP_NOFAIL with high order in vm_area_alloc_pages() and page allocation
> failed for high order, the pages** may contain two different page shifts
> (high order and order-0).  This could lead __vmap_pages_range_noflush() to
> perform incorrect mappings, potentially resulting in memory corruption.
> 
> Users might encounter this as follows (vmap_allow_huge = true, 2M is for
> PMD_SIZE):
> 
> kvmalloc(2M, __GFP_NOFAIL|GFP_X)
>     __vmalloc_node_range_noprof(vm_flags=VM_ALLOW_HUGE_VMAP)
>         vm_area_alloc_pages(order=9) ---> order-9 allocation failed and fallback to order-0
>             vmap_pages_range()
>                 vmap_pages_range_noflush()
>                     __vmap_pages_range_noflush(page_shift = 21) ----> wrong mapping happens
> 
> We can remove the fallback code because if a high-order allocation fails,
> __vmalloc_node_range_noprof() will retry with order-0.  Therefore, it is
> unnecessary to fallback to order-0 here.  Therefore, fix this by removing
> the fallback code.
> 
> Link: https://lkml.kernel.org/r/20240808122019.3361-1-hailong.liu@oppo.com
> Fixes: e9c3cda4d86e ("mm, vmalloc: fix high order __GFP_NOFAIL allocations")
> Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> Reported-by: Tangquan Zheng <zhengtangquan@oppo.com>
> Reviewed-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Acked-by: Barry Song <baohua@kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 61ebe5a747da649057c37be1c37eb934b4af79ca)
> Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> ---
>  mm/vmalloc.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index c5e30b52844c..a0b650f50faa 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2992,15 +2992,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			page = alloc_pages(alloc_gfp, order);
>  		else
>  			page = alloc_pages_node(nid, alloc_gfp, order);
> -		if (unlikely(!page)) {
> -			if (!nofail)
> -				break;
> -
> -			/* fall back to the zero order allocations */
> -			alloc_gfp |= __GFP_NOFAIL;
> -			order = 0;
> -			continue;
> -		}
> +		if (unlikely(!page))
> +			break;
>  
>  		/*
>  		 * Higher order allocations must be able to be treated as
> -- 
> 2.25.1
> 
> 

Now queued up, thanks.

greg k-h

