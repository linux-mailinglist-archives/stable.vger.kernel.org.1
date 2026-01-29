Return-Path: <stable+bounces-212791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AvDEEKHe2mlFQIAu9opvQ
	(envelope-from <stable+bounces-212791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:13:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6033B1F6A
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ABF7308FE87
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9785A3382C3;
	Thu, 29 Jan 2026 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KQyhd+zH"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A7313E39
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702846; cv=none; b=cRETvfO3RtOnGrzoKWSp86kFGBaY8NNmDpX5i8BekQT9l3PwzC2gd0V3VkIVPfViXvWpuMmXhb6jXBqcMHYYfLK1Y50i2oFjD0WwuXh+uAg+JuzllwdBJ7mc+rYDkmhcKx8o/GCvtHLTS4jSHU+/rSB7hBkvTNUrbWdAPnjJH2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702846; c=relaxed/simple;
	bh=JV8oz6kgGENszqbeyUoRgkdoVM+q2aONKnxbqj/pAiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgO2t+LWIyrQU1ValADLZlSpsL0GbviF0zD1wq28/ROPmKqRCILmRZxxkvNaC3fjELgjma6WGQ9isIPqTtyddnIg6anwDt/5O4QCYFBxXrvoP6NqMM68jzXbg/cpLss+QBX/h+Yb4zZ7X8lO0OrwVHijs7zbun3S/BjZHHto3sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KQyhd+zH; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 30 Jan 2026 00:06:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769702832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4DyRR+8pEpil2SIyjO3JCOq7XaAaTnp588uXM7WQog=;
	b=KQyhd+zHftxInKZGx+Z8mxveTRnfwHYW/v+DCnqYEnM+WXSvsxPmKXA3qc53XywMh1RYwm
	FroW66WMQTV9+PNir9U2yJqEhvQITRlLXF7m0gfSv9/BACckTTglyOvI32WGqct9o4ttWV
	yrgwzMfflDgF+IaG0NhAXbptwGh055M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v4 00/22] slab: replace cpu (partial) slabs with sheaves
Message-ID: <aozlag7qiwbdezzjgw3bq73ihnkeppmc5iy4hq7zosg3zyalih@ieo3a4qecfxg>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <imzzlzuzjmlkhxc7hszxh5ba7jksvqcieg5rzyryijkkdhai5q@l2t4ye5quozb>
 <390d6318-08f3-403b-bf96-4675a0d1fe98@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390d6318-08f3-403b-bf96-4675a0d1fe98@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212791-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[oracle.com,suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hao.li@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6033B1F6A
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 04:28:01PM +0100, Vlastimil Babka wrote:
> On 1/29/26 16:18, Hao Li wrote:
> > Hi Vlastimil,
> > 
> > I conducted a detailed performance evaluation of the each patch on my setup.
> 
> Thanks! What was the benchmark(s) used?

I'm currently using the mmap2 test case from will-it-scale. The machine is still
an AMD 2-socket system, with 2 nodes per socket, totaling 192 CPUs, with SMT
disabled. For each test run, I used 64, 128, and 192 processes respectively.

> Importantly, does it rely on vma/maple_node objects?

Yes, this test primarily puts a lot of pressure on maple_node.

> So previously those would become kind of double
> cached by both sheaves and cpu (partial) slabs (and thus hopefully benefited
> more than they should) since sheaves introduction in 6.18, and now they are
> not double cached anymore?

Exactly, since version 6.18, maple_node has indeed benefited from a dual-layer
cache.

I did wonder if this isn't a performance regression but rather the
performance returning to its baseline after removing one layer of caching.

However, verifying this idea would require completely disabling the sheaf
mechanism on version 6.19-rc5 while leaving the rest of the SLUB code untouched.
It would be great to hear any suggestions on how this might be approached.

> 
> > During my tests, I observed two points in the series where performance
> > regressions occurred:
> > 
> >     Patch 10: I noticed a ~16% regression in my environment. My hypothesis is
> >     that with this patch, the allocation fast path bypasses the percpu partial
> >     list, leading to increased contention on the node list.
> 
> That makes sense.
> 
> >     Patch 12: This patch seems to introduce an additional ~9.7% regression. I
> >     suspect this might be because the free path also loses buffering from the
> >     percpu partial list, further exacerbating node list contention.
> 
> Hmm yeah... we did put the previously full slabs there, avoiding the lock.
> 
> > These are the only two patches in the series where I observed noticeable
> > regressions. The rest of the patches did not show significant performance
> > changes in my tests.
> > 
> > I hope these test results are helpful.
> 
> They are, thanks. I'd however hope it's just some particular test that has
> these regressions,

Yes, I hope so too. And the mmap2 test case is indeed quite extreme.

> which can be explained by the loss of double caching.

If we could compare it with a version that only uses the
CPU partial list, the answer might become clearer.

