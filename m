Return-Path: <stable+bounces-124045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845DCA5CAD0
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A503AFD6F
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A625125F990;
	Tue, 11 Mar 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ry8tyfgv"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7CF2253AB
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710510; cv=none; b=u3pEINCvePzg+izdP28g8wh5EeqBKczbgPR3Z28WfEHr+KFmBjcjheF38EwI3iytmhxnZtx1P0hWmumHKLfy02FYyP6jecVBuKVKauJ4BKwN7c6mE83g8wi4HVw17oUgGzI4wNFvmler0U6TALWQ+BOiX0Iyhks8m/ix3voWbe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710510; c=relaxed/simple;
	bh=IWASrnOWANM8XtQXfnGhgl+lCP5IEYneKhicR53pZ+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrL6C16qxHmDu74taMi7KCe5QgGnSV0kaDV+84kvNAgvVRmasazGvOCrW9HFOWmQyOIfbaiGSf60YOTVKuqfiylTqpeH/1tcR8GwVheGBIpBhtayUeCgD/Dz2t1CyNavCUCYIKWLBFvBzEZuDgfU6FMzPOQNz0UTblS3BXK3ilA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ry8tyfgv; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Mar 2025 16:28:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741710506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2v5924SrAK+nkot0P3H41NQkoPOcxGeW7jlz7h2Cp3Y=;
	b=ry8tyfgvaN3wVqqxD6oXXY6WLpOgUHm2JyK4G+Rnwy8772eAsrttvHyjnTg16e6N3l6to0
	lDNYA0HOEZ7Kl92wfwQkEQyHHPD07HKzBzqDQ5m1MZ2lMokb4SUp20WIVAmAN6HpTW+HzA
	zutYDxLanrFINUm0SkCJ6+KvThNgRjc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, stable@vger.kernel.org
Subject: Re: [PATCH] memcg: drain obj stock on cpu hotplug teardown
Message-ID: <Z9Bkn63LE4JRB3x7@google.com>
References: <20250310230934.2913113-1-shakeel.butt@linux.dev>
 <20250311153032.GB1211411@cmpxchg.org>
 <orewawh6kpgrbl4jlvpeancg4s6cyrldlpbqbd7wyjn3xtqy5y@2edkh5ffbnas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orewawh6kpgrbl4jlvpeancg4s6cyrldlpbqbd7wyjn3xtqy5y@2edkh5ffbnas>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 11, 2025 at 08:57:54AM -0700, Shakeel Butt wrote:
> On Tue, Mar 11, 2025 at 11:30:32AM -0400, Johannes Weiner wrote:
> > On Mon, Mar 10, 2025 at 04:09:34PM -0700, Shakeel Butt wrote:
> > > Currently on cpu hotplug teardown, only memcg stock is drained but we
> > > need to drain the obj stock as well otherwise we will miss the stats
> > > accumulated on the target cpu as well as the nr_bytes cached. The stats
> > > include MEMCG_KMEM, NR_SLAB_RECLAIMABLE_B & NR_SLAB_UNRECLAIMABLE_B. In
> > > addition we are leaking reference to struct obj_cgroup object.
> > > 
> > > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > Cc: <stable@vger.kernel.org>
> > 
> > Wow, that's old. Good catch.
> > 
> > > ---
> > >  mm/memcontrol.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 4de6acb9b8ec..59dcaf6a3519 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -1921,9 +1921,18 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
> > >  static int memcg_hotplug_cpu_dead(unsigned int cpu)
> > >  {
> > >  	struct memcg_stock_pcp *stock;
> > > +	struct obj_cgroup *old;
> > > +	unsigned long flags;
> > >  
> > >  	stock = &per_cpu(memcg_stock, cpu);
> > > +
> > > +	/* drain_obj_stock requires stock_lock */
> > > +	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > > +	old = drain_obj_stock(stock);
> > > +	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> > > +
> > >  	drain_stock(stock);
> > > +	obj_cgroup_put(old);
> > 
> > It might be better to call drain_local_stock() directly instead. That
> > would prevent a bug of this type to reoccur in the future.
> 
> The issue is drain_local_stock() works on the local cpu stock while here
> we are working on a remote cpu cpu which is dead (memcg_hotplug_cpu_dead
> is in PREPARE section of hotplug teardown which runs after the cpu is
> dead).
> 
> We can safely call drain_stock() on remote cpu stock here but
> drain_obj_stock() is a bit tricky as it can __refill_stock() to local cpu
> stock and can call __mod_objcg_mlstate to flush stats. Both of these
> requires irq disable for NON-RT kernels and thus I added the local_lock
> here.
> 
> Anyways I wanted a simple fix for the backports and in parallel I am
> working on cleaning up all the stock functions as I plan to add multi
> memcg support.

Really curious to see patches/more details here, I have some ideas here
as well (nothing materialized yet though).

Thanks!

