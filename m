Return-Path: <stable+bounces-211627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN+9EEN8d2m9hgEAu9opvQ
	(envelope-from <stable+bounces-211627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:37:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F9389997
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 301AC30060A8
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78DB270540;
	Mon, 26 Jan 2026 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rehQdevu"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B9C23EAB3
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769438268; cv=none; b=rPQ1MIMtANu3ER63txHvoq7cSJkmtLwzmRoyHoad9fKsTBfCmEHCUnVWS8YAi+0ePnn00ojbX2lJnuIfS2PTeZ7wx4ArflIyg+dUoJk4FSsKIN3n0NiqLZh4CFkkbvh8dzquoulfCTGkvwy02cKGx5E5M2pmcU22C7VdukpConM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769438268; c=relaxed/simple;
	bh=8DK71chew/DZo8mxmNv0if2DG7rv8reaxjHdjyEdfQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nw8rVK6ZPEqpRZCmfUluFVxsY/sz78tLcRcoU80cSzEbaqsyYE07nXIn3nKHlJ2KPyKQgQKGCJAyowNs1jvaFf04RjfqTOkf9l1yr0lTu3fBJpb1Klc0QelWd11s24BDy9sNVKsdyC5h5X08Ri2TTXtJTCshP4U+6zNOKYKLBZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rehQdevu; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Jan 2026 22:37:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769438263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3gWPox18R9R0nDM+yJbkJ1B/qOaChMvjCqqEXPSWtY=;
	b=rehQdevuiw1TNhrO6RLeGjk8vl2XWVm33sLgqKmYpZ4h5yVPSaDPbLevcP6qnAyJ8KG3b5
	AIvJoCvrfKKgwXq0y0MJkvWRDZCHsoxSwgSHCpg1o1YmUzjGKxechwkWyRWkXxXm5vckTm
	dw50gVKh2Z548hagRtfWtNf2FLsf1NU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, cl@gentwo.org, rientjes@google.com, surenb@google.com, 
	kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH V2] mm/slab: avoid allocating slabobj_ext array from its
 own slab
Message-ID: <73gdb2vktj6dmog3z4kzpl2tefkuvt4ckcom24eo6xveznc7lx@v2b74xbwa36r>
References: <20260126125714.88008-1-harry.yoo@oracle.com>
 <aXdmN1jUR5bZ6rK8@hyeyoo>
 <795a4294-001f-4462-8afc-7310e9059943@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <795a4294-001f-4462-8afc-7310e9059943@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211627-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69F9389997
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 02:46:46PM +0100, Vlastimil Babka wrote:
> On 1/26/26 14:03, Harry Yoo wrote:
> > On Mon, Jan 26, 2026 at 09:57:14PM +0900, Harry Yoo wrote:
> >> When allocating slabobj_ext array in alloc_slab_obj_exts(), the array
> >> can be allocated from the same slab we're allocating the array for.
> >> This led to obj_exts_in_slab() incorrectly returning true [1],
> >> although the array is not allocated from wasted space of the slab.
> >> 
> >> Vlastimil Babka observed that this problem should be fixed even when
> >> ignoring its incompatibility with obj_exts_in_slab(), because it creates
> >> slabs that are never freed as there is always at least one allocated
> >> object.
> >> 
> >> To avoid this, use the next kmalloc size or large kmalloc when
> >> the array can be allocated from the same cache we're allocating
> >> the array for.
> >> 
> >> In case of random kmalloc caches, there are multiple kmalloc caches
> >> for the same size and the cache is selected based on the caller address.
> >> Because it is fragile to ensure the same caller address is passed to
> >> kmalloc_slab(), kmalloc_noprof(), and kmalloc_node_noprof(), bump the
> >> size to (s->object_size + 1) when the sizes are equal, instead of
> >> directly comparing the kmem_cache pointers.
> >> 
> >> Note that this doesn't happen when memory allocation profiling is
> >> disabled, as when the allocation of the array is triggered by memory
> >> cgroup (KMALLOC_CGROUP), the array is allocated from KMALLOC_NORMAL.
> >> 
> >> Reported-by: kernel test robot <oliver.sang@intel.com>
> >> Closes: https://lore.kernel.org/oe-lkp/202601231457.f7b31e09-lkp@intel.com [1]
> >> Cc: stable@vger.kernel.org
> >> Fixes: 4b8736964640 ("mm/slab: add allocation accounting into slab allocation and free paths")
> >> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> >> ---
> >> 
> >> V1 -> V2:
> >> - Simplified implementation based on Vlastimil's comment
> >> - added virt_to_slab() != NULL check before dereferencing it - because
> >>   (in theory) it may be allocated via large kmalloc.
> >> 
> >>  mm/slub.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++-------
> >>  1 file changed, 53 insertions(+), 7 deletions(-)
> >> 
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index f21b2f0c6f5a..5b4a3b9b7826 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -2095,6 +2095,49 @@ static inline void init_slab_obj_exts(struct slab *slab)
> >>  	slab->obj_exts = 0;
> >>  }
> >>  
> >> +/*
> >> + * Calculate the allocation size for slabobj_ext array.
> >> + *
> >> + * When memory allocation profiling is enabled, the obj_exts array
> >> + * could be allocated from the same slab cache it's being allocated for.
> >> + * This would prevent the slab from ever being freed because it would
> >> + * always contain at least one allocated object (its own obj_exts array).
> >> + *
> >> + * To avoid this, increase the allocation size when we detect the array
> >> + * may come from the same cache, forcing it to use a different cache.
> >> + */
> >> +static inline size_t obj_exts_alloc_size(struct kmem_cache *s,
> >> +					 struct slab *slab, gfp_t gfp)
> >> +{
> >> +	size_t sz = sizeof(struct slabobj_ext) * slab->objects;
> >> +	struct kmem_cache *obj_exts_cache;
> >> +
> >> +	/*
> >> +	 * slabobj_ext array for KMALLOC_CGROUP allocations
> >> +	 * are served from KMALLOC_NORMAL caches.
> >> +	 */
> >> +	if (!mem_alloc_profiling_enabled())
> >> +		return sz;
> > 
> > Hmm maybe we don't need this as there's !is_kmalloc_normal(s) check,
> > but this allows optimizing out the checks below when
> > CONFIG_MEM_ALLOC_PROFILING is not enabled.
> > 
> > So probably worth keeping it.
> 
> Right.
> 
> Thanks, added to slab/for-next as the first commit of the obj_metadata branch.

Hi Vlastimil,

This v2 patch still looks good to me!
Feel free to fold this R-b tag into the commit on slab/for-next.

Reviewed-by: Hao Li <hao.li@linux.dev>

