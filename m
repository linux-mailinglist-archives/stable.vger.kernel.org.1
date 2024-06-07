Return-Path: <stable+bounces-49974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DA39006B9
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 16:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC771F22FB6
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 14:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7281957E6;
	Fri,  7 Jun 2024 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B8hEjK93"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DBB26AFA
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770776; cv=none; b=tkWVc0bldG13cYyJQvFRYbnBTvzE/yfHhfkmBCTC5xsJJes/vKJTx5/SrWLMhS5U+OzFBNIiAl5kiGxdrMtnf4go1RsBCJVzTaf8vx8k4XDw/W8evtN2VaTy8ELPNJjizg61JL3GkyPYbN9CAHT8arMV6SQuZDNr6L0ZDaLEJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770776; c=relaxed/simple;
	bh=KLNaDjyJghj2OpfI7J2yiPaJ8igUX0r6A5F6ONpoHzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFQNkMfKaYn3vecQ+OjG0MTqHSd0BohXUPni2uId7xVPLhIdK7hzetTfIy6/899bYfzJ+zcu1Lu8YE+J7UwuK9ZWnrJKiy17EK57IwQ1UsXYL4avoRlu0zORLOtxrvfn2c0umkRiNWyiMAGvVgYuQaMZIiOM0qdL/tbx13UwgDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B8hEjK93; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hawk@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717770771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2NvCYHpZJ1ZjGoA68QOuHW4f0uq565qSfBp0tFxFCsw=;
	b=B8hEjK93FWbycj6OxRHaxjicx7BrkV2Uiq2QDAKDQKrIM5ihChm3umdH0rf5J06hUPY7K8
	yavee1l8pRBkj+GJTSlatoJgrXhDvVrFG0wNwJ/RpfFl9pdZOdn/pB+SMXj1ljjDVYmXZZ
	QIyaFwoSlrU4qh5k1Ikwog41UFEvxf8=
X-Envelope-To: stable@vger.kernel.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: tj@kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: longman@redhat.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: kernel-team@cloudflare.com
Date: Fri, 7 Jun 2024 07:32:46 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: stable@vger.kernel.org, yosryahmed@google.com, tj@kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, cgroups@vger.kernel.org, 
	longman@redhat.com, linux-mm@kvack.org, kernel-team@cloudflare.com
Subject: Re: [PATCH 6.6.y] mm: ratelimit stat flush from workingset shrinker
Message-ID: <tge6txvuepcu3iy7nz3cuafbd5x2hmeprbaz3d3fzawvvzg3xr@f4utxxs2egxl>
References: <171776806121.384105.7980809581420394573.stgit@firesoul>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171776806121.384105.7980809581420394573.stgit@firesoul>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 07, 2024 at 03:48:06PM GMT, Jesper Dangaard Brouer wrote:
> From: Shakeel Butt <shakeelb@google.com>
> 
> commit d4a5b369ad6d8aae552752ff438dddde653a72ec upstream.
> 
> One of our workloads (Postgres 14 + sysbench OLTP) regressed on newer
> upstream kernel and on further investigation, it seems like the cause is
> the always synchronous rstat flush in the count_shadow_nodes() added by
> the commit f82e6bf9bb9b ("mm: memcg: use rstat for non-hierarchical
> stats").  On further inspection it seems like we don't really need
> accurate stats in this function as it was already approximating the amount
> of appropriate shadow entries to keep for maintaining the refault
> information.  Since there is already 2 sec periodic rstat flush, we don't
> need exact stats here.  Let's ratelimit the rstat flush in this code path.
> 
> Link: https://lkml.kernel.org/r/20231228073055.4046430-1-shakeelb@google.com
> Fixes: f82e6bf9bb9b ("mm: memcg: use rstat for non-hierarchical stats")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> ---
> On production with kernel v6.6 we are observing issues with excessive
> cgroup rstat flushing due to the extra call to mem_cgroup_flush_stats()
> in count_shadow_nodes() introduced in commit f82e6bf9bb9b ("mm: memcg:
> use rstat for non-hierarchical stats") that commit is part of v6.6.
> We request backport of commit d4a5b369ad6d ("mm: ratelimit stat flush
> from workingset shrinker") as it have a fixes tag for this commit.
> 
> IMHO it is worth explaining call path that makes count_shadow_nodes()
> cause excessive cgroup rstat flushing calls. Function shrink_node()
> calls mem_cgroup_flush_stats() on its own first, and then invokes
> shrink_node_memcgs(). Function shrink_node_memcgs() iterates over
> cgroups via mem_cgroup_iter() for each calling shrink_slab(). The
> shrink_slab() calls do_shrink_slab() that via shrinker->count_objects()
> invoke count_shadow_nodes(), and count_shadow_nodes() does
> a mem_cgroup_flush_stats() call, that seems unnecessary.
> 

Actually at Meta production we have also replaced
mem_cgroup_flush_stats() in shrink_node() with
mem_cgroup_flush_stats_ratelimited() as it was causing too much flushing
issue. We have not observed any issue after the change. I will propose
that patch to upstream as well.

