Return-Path: <stable+bounces-207872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B3DD0ABC6
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 15:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15FAF3014639
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC66C23B60A;
	Fri,  9 Jan 2026 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BHJcKxj2"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D812F39B8
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969907; cv=none; b=gZPeCV8k/m/iIO2AWqAwQVIh/MYmpbGF966Z9zUHKVfYr+WqMv0GL+/te0nXtaBWeCSG/4hBmW/gXCvVRIH1h2dZ7hEnOLeyV1WuUWxV89kWQgGYPuQmnZlF1Xk7lUgXiLbM1ODO5Iw243Nqxe9Xm+Pa162j61kMEPTGpF3Sq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969907; c=relaxed/simple;
	bh=+d9pmRxCx6SpaCtFUFxI8NlvBcAZ5Byhp79v6WYk2UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFKf00hZpjkqjWW55Rt97V2dh4fgG/4nLTf8fECJFre0muTVfORMBAJrVZPAhYkbyNs1EjZZgivWCT2zHCiSZujfO2lM+llknyHABg+oM06c8OubR04xPq73Uxm+eDSumaJ3x4NnVbElHd4qBPhrO+IUXbhk5v+VSyaJ39fJsX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BHJcKxj2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YoZEkcP81J9S3LDfhd18FIDcOfNOHxVwqIdavyFjCcY=; b=BHJcKxj2yeh95VRAEMy+WwO+hX
	ucUCoR6gGGXhz/d2SOVoCO1+FR/lX5MJzHmYTJV9BOP5ugNsAenGQkjSFok27X94Wyypa/Z+zBboy
	gqQJwG5kdFbvRp0H/WlrlbiQ8clbkMRQlQQU3veYfj961e5yof7tzKWuUb+6NUnkSywc//0jnCdy5
	eEGai36Ud9I+LLKFHormnIRTX/PVJewliP66fCB5C+OVGshRIe6Ko/2mRQC5fuSI7fodvXZgazijl
	0I1+VYC4OsYGkMdajZiMc9+FoY0pd2esYb7DU4SxY05QZASZi3FxgREgpQATFGNLncSgTLz+WE2U3
	oRGX8OEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veDjT-0000000GuRO-018d;
	Fri, 09 Jan 2026 14:44:55 +0000
Date: Fri, 9 Jan 2026 14:44:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
	Jann Horn <jannh@google.com>, linux-mm@kvack.org,
	syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com,
	Lance Yang <lance.yang@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] migrate: Correct lock ordering for hugetlb file
 folios
Message-ID: <aWEUZiKX7QC0xtMy@casper.infradead.org>
References: <20260109041345.3863089-1-willy@infradead.org>
 <20260109041345.3863089-2-willy@infradead.org>
 <509ac447-e5a7-4cba-86b8-e9c0e72fc93c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <509ac447-e5a7-4cba-86b8-e9c0e72fc93c@kernel.org>

On Fri, Jan 09, 2026 at 02:50:26PM +0100, David Hildenbrand (Red Hat) wrote:
> We now handle file-backed folios correctly I think. Could we somehow
> also be in trouble for anon folios? Because there, we'd still take the
> rmap lock after grabbing the folio lock.

We're now pretty far afield from my area of MM expertise, but since using
AI is now encouraged, I will confidently state that only file-backed
hugetlb folios have this inversion of the rmap lock and folio lock.
anon hugetlb folios follow the normal rules.  And it's all because
of PMD sharing, which isn't needed in the anon case but is needed for
file-backed.

So once mshare is in, we can remove this wart.

> >   	if (page_was_mapped)
> > -		remove_migration_ptes(src, !rc ? dst : src, 0);
> > +		remove_migration_ptes(src, !rc ? dst : src,
> > +				ttu ? RMP_LOCKED : 0);
> 
> 	(ttu & TTU_RMAP_LOCKED) ? RMP_LOCKED : 0)
> 
> Would be cleaner, but I see how you clean that up in #2. :)

Yes, that would be more future-proof, but this code has no future ;-)

> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

Thanks!

