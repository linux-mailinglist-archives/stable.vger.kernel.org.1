Return-Path: <stable+bounces-211626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLN1C418d2m9hgEAu9opvQ
	(envelope-from <stable+bounces-211626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:39:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD2E89A02
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B32305A420
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1732A24677A;
	Mon, 26 Jan 2026 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iK5OL59v"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225BC245020
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437949; cv=none; b=IC5aTLHaMaZM/jNZTK/Veedl1+BzzdxvVnDcVsiGDDZ5dwM5Cq21WgIwzr0be1/Ngfv/vmNh38smxHVzWGQiOFXMENhwX9vQkaWfFG6KSyNWBeFcwQdk0bfn5L5dQN95fTsEBnWUbmSB/gIXHIouYc4cG49F/aWN2YkQIJhYytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437949; c=relaxed/simple;
	bh=xaBvoUmF/AvM1YTimhK7eOKMP/wKLpSE3Fn0ItlahvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSAp43IBsfkuaqol6CCfp0/9LTNfL7+69+kuygzVSZwFlJW7YGvqErNw6neSx957QPnVJBXsH5nTaxX95qCeSGoT0lU+X0Hkx9gFdI8fDA7lN4jpU9V6POgAzubDu0ZipVmm/euiH23Qje1ts/OVyz4yEtCUtHEm0NmYiZvAuB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iK5OL59v; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Jan 2026 22:31:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769437945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yauI0tcgo0+gYANQoQ4SC/6g3xcV7IYqYM+9jpJfB40=;
	b=iK5OL59vC4WO+lI0NZoy2qozlsKaEVfF1lppmUeqPmFleXMViYrOi5L3wsDbk57Yaa2yu7
	S9wvsBgQuCZB18JkmqjUutFUVkjOxGJvXW0VHlGOorNk48Lq27MCADCz5ImzidSW46tQpx
	9LAdk0Sk4OD+h/vyrrmccmuPbWC7eDU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org, 
	cl@gentwo.org, rientjes@google.com, surenb@google.com, 
	kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: avoid allocating slabobj_ext array from its own
 slab
Message-ID: <74km7ybuexsentai3jvf5wfbd3k7cf4mflyd2zgth2dzkxcfp6@l77gkdbpfcic>
References: <20260124104614.9739-1-harry.yoo@oracle.com>
 <bbhrcvqbwuvf6l4xwv7ax6w5iwuixaivvuknvlgutnavxyllme@r5zkvsh7mwtw>
 <aXdlheky-H2a29Uk@hyeyoo>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXdlheky-H2a29Uk@hyeyoo>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211626-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hao.li@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DD2E89A02
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:00:53PM +0900, Harry Yoo wrote:
> On Mon, Jan 26, 2026 at 08:51:10AM +0800, Hao Li wrote:
> > On Sat, Jan 24, 2026 at 07:46:14PM +0900, Harry Yoo wrote:
> > > When allocating slabobj_ext array in alloc_slab_obj_exts(), the array
> > > can be allocated from the same slab we're allocating the array for.
> > > This led to obj_exts_in_slab() incorrectly returning true [1],
> > > although the array is not allocated from wasted space of the slab.
> > 
> > This is indeed a tricky issue to uncover.
> > 
> > > 
> > > Vlastimil Babka observed that this problem should be fixed even when
> > > ignoring its incompatibility with obj_exts_in_slab(), because it creates
> > > slabs that are never freed as there is always at least one allocated
> > > object.
> > > 
> > > To avoid this, use the next kmalloc size or large kmalloc when
> > > kmalloc_slab() returns the same cache we're allocating the array for.
> > 
> > Nice approach.
> > 
> > > 
> > > In case of random kmalloc caches, there are multiple kmalloc caches for
> > > the same size and the cache is selected based on the caller address.
> > > Because it is fragile to ensure the same caller address is passed to
> > > kmalloc_slab(), kmalloc_noprof(), and kmalloc_node_noprof(), fall back
> > > to (s->object_size + 1) when the sizes are equal.
> > 
> > Good catch on this corner case!
> > 
> > > 
> > > Note that this doesn't happen when memory allocation profiling is
> > > disabled, as when the allocation of the array is triggered by memory
> > > cgroup (KMALLOC_CGROUP), the array is allocated from KMALLOC_NORMAL.
> > > 
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202601231457.f7b31e09-lkp@intel.com
> > > Cc: stable@vger.kernel.org
> > > Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
> > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > 
> > Looks good to me!
> > Reviewed-by: Hao Li <hao.li@linux.dev>
> 
> Hi Hao, thanks a lot for reviewing!
> 
> I was tempted to add your R-b tag, but since the implementation has
> changed a bit, 

Hi Harry,

Thanks for letting me know!

> could you please provide R-b again if V2 [1] still looks
> good to you?
> 
> [1] https://lore.kernel.org/linux-mm/20260126125714.88008-1-harry.yoo@oracle.com

Sure - I've reviewed v2 and it's still LGTM.
I'll send my Reviewed-by on the v2 thread.
Thanks!

> 
> -- 
> Cheers,
> Harry / Hyeonggon

