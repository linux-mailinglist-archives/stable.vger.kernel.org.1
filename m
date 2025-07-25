Return-Path: <stable+bounces-164765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE55B124B3
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 21:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDC93B7579
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 19:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A1F257AF0;
	Fri, 25 Jul 2025 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lk5sxxlB"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9512566D1;
	Fri, 25 Jul 2025 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753471336; cv=none; b=nqgNuJY/8iuOmn1pfEek7RBSJukpd5x0gMqg9MQXuGAyPIHTkn1nSWY/mE3ougrChhs02qecCYssE9/EVmhOhwgF65G8w/GUBZt4s9+w06nyGwLA1PCxA13q4Gsqjk1tfS0Ijf4dgph/9XEe+XR4G60Y7rrJjTZwlaMgvA+dbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753471336; c=relaxed/simple;
	bh=EN0memeWc8zsRmmqQaJN3tydRXI+hElA61INak88DaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5bPvD6wEl24MdTMfpHNqQaLmC7MBpBGLY73kMjabooSRHMaFvm81LPaI94tlo9N+fUZBG9IJbnJxysy9QbwzvqVSTs5hf2acJrG8DLP/R8rcCnCrbx7jqe5dgS7FPBGqhQdNjwJ6v7z4SG9aHcPHAclR95D9FEf55sX4iomCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lk5sxxlB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I09JIX/VR8UzFPSTS0iYzzlehYa6ZqlWHEvSJTEox/k=; b=Lk5sxxlBaxLMJFagMCiKZqdsUR
	yUUw4QhQdsiPB7vCP1L81pqF4ODFPMynDL2BMvbek+zu1WAZCDgMkoYCdkpsYqjS2kORRMU0FWwzN
	9BhN5vNcygaJtEPokCcluYYZv2ezC6OYYWZH2/rRzK7vBa4FOaH/ro+OKi12v5Nusuu+up+AhEXX2
	sNFjpduilWWjvgPbVBizS/CrXhLUNw43Ismd+KKZ+gzJRf9JQaNqKNFdufKY8TvrscDMj23hlJ9bU
	3Kxc7Ms1EYRHq1RHCEcOA+1ldyQmfvjbyrZALPGXfQ2FrrLhy8V6JbCOCLPE/oD79UE4QhSdbIgYv
	+NByrhzg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufNzZ-0000000Gxp1-3gXc;
	Fri, 25 Jul 2025 19:22:06 +0000
Date: Fri, 25 Jul 2025 20:22:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Li Qiong <liqiong@nfschina.com>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: slub: avoid deref of free pointer in sanity
 checks if object is invalid
Message-ID: <aIPZXSnkDF5r-PR5@casper.infradead.org>
References: <20250725064919.1785537-1-liqiong@nfschina.com>
 <996a7622-219f-4e05-96ce-96bbc70068b0@suse.cz>
 <aIO6m2C8K4SrJ6mp@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIO6m2C8K4SrJ6mp@casper.infradead.org>

On Fri, Jul 25, 2025 at 06:10:51PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 25, 2025 at 06:47:01PM +0200, Vlastimil Babka wrote:
> > On 7/25/25 08:49, Li Qiong wrote:
> > > For debugging, object_err() prints free pointer of the object.
> > > However, if check_valid_pointer() returns false for a object,
> > > dereferncing `object + s->offset` can lead to a crash. Therefore,
> > > print the object's address in such cases.
> 
> I don't know where this patch came from (was it cc'd to linux-mm? i
> don't see it)

I've spent some more time thinking about this and I now believe that
there are several calls to object_err() that can be passed a bad
pointer:

freelist_corrupted()
check_object()
on_freelist()
alloc_consistency_checks()
free_consistency_checks()

so I think this line of attack is inappropriate.  Instead, I think we
need to make object_err() resilient against wild pointers.  Specifically,
avoid doing risky things in print_trailer() if object is not within slab.

