Return-Path: <stable+bounces-164756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57FCB122BC
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 19:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619607BD3AE
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78C22EF66B;
	Fri, 25 Jul 2025 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q6nsBbDk"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C8226863;
	Fri, 25 Jul 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463462; cv=none; b=fCpZXEpyr0Eji2XQlVNMUhek4W1VkEh2b6HjHsrloQWVb1hfHWBe/LYbEJRQAbfNzXcuipebiVjqFhfgR3nJTs1F9Fhi4NWLePZeilIOarp2knyTZwPbrAPZQHZXGpSB5kV25VfwxeNCUxnW+PVu47vTUcATZKCHVEC6Lfh92w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463462; c=relaxed/simple;
	bh=6h7nPOb3zXhqTcv4gANHQ2bvTVhFkIX8nsrG7OgiSdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT00wUe0XtMQXjrF7AnU2EqFHB287xWu2//ntKD+xiabSSGbIAFZtq0ONHKOmqnw3R2owjUdpusyUUcUi8uxVz2nP+dzZEej1JafrR9XcD0EDP6HhBIyMQDWTCd37R2G63eReke1rUH+kHzlbyYpkkZArN08GeJCm0zOK5a1KG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q6nsBbDk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IwEj7tW3R8uCNKLY055BKb1g0sfs5+82uKkf0EViQnk=; b=q6nsBbDkqlaOI6zpV6bJS9CTol
	XAKlVZQqfBwnB2MxRuZJMraL1hXQhohrtGkyp2l9rnDBXoyYn3Sh+LnpRalA0q42B7GYI/SJAAjJw
	PgiHY4WOGExeZoRYvl7Z41eF5QqDaiLl6thfX1Wuw+s3+QyeGBiCJkwUO1k1co1kpn6o0YrFw6Oow
	c3r+5XonilGVfG8f9gAz8TZAPMWgh9EFXqdtpi6LaNBIZcFDZzzQ+mucxd7PwH98CWHZVJK3rZj7F
	wH0HdcOTf10xE07W0zVjM8yCW3RGgOEGaxYy1fuprasrdIFzlT4mbdqQNkyTVnnbKKW5Ik5LLxXPH
	1PmDyyjA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufLwZ-0000000FAKW-3dJu;
	Fri, 25 Jul 2025 17:10:51 +0000
Date: Fri, 25 Jul 2025 18:10:51 +0100
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
Message-ID: <aIO6m2C8K4SrJ6mp@casper.infradead.org>
References: <20250725064919.1785537-1-liqiong@nfschina.com>
 <996a7622-219f-4e05-96ce-96bbc70068b0@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <996a7622-219f-4e05-96ce-96bbc70068b0@suse.cz>

On Fri, Jul 25, 2025 at 06:47:01PM +0200, Vlastimil Babka wrote:
> On 7/25/25 08:49, Li Qiong wrote:
> > For debugging, object_err() prints free pointer of the object.
> > However, if check_valid_pointer() returns false for a object,
> > dereferncing `object + s->offset` can lead to a crash. Therefore,
> > print the object's address in such cases.

I don't know where this patch came from (was it cc'd to linux-mm? i
don't see it)

> >  
> > +/*
> > + * object - should be a valid object.
> > + * check_valid_pointer(s, slab, object) should be true.
> > + */

This comment is very confusing.  It tries to ape kernel-doc style,
but if it were kernel-doc, the word before the hyphen should be the name
of the function, and it isn't.  If we did use kernel-doc for this, we'd
use @object to denote that we're documenting the argument.

But I don't see the need to pretend this is related to kernel-doc.  This
would be better:

/*
 * 'object' must be a valid pointer into this slab.  ie
 * check_valid_pointer() would return true
 */

I'm sure better wording for that is possible ...

> >  	if (!check_valid_pointer(s, slab, object)) {
> > -		object_err(s, slab, object, "Freelist Pointer check fails");
> > +		slab_err(s, slab, "Invalid object pointer 0x%p", object);
> >  		return 0;

No, the error message is now wrong.  It's not an object, it's the
freelist pointer.

		slab_err(s, slab, "Invalid freelist pointer %p", object);

(the 0x%p is wrong because it will print 0x twice)

But I think there are even more things wrong here.  Like slab_err() is
not nerely as severe as slab_bug(), which is what used to be called.
And object_err() adds a taint, which this skips.

Altogether, this is a poorly thought out patch and should be dropped.

