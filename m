Return-Path: <stable+bounces-150747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB5FACCD0D
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27A41895976
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6805D288C3B;
	Tue,  3 Jun 2025 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JSWfvysW"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C4C288C1E;
	Tue,  3 Jun 2025 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975363; cv=none; b=jx3AtCQ9k3FCD0Io8OhVwmkGHpygqRGGd8+kysdjVynsh+nwuf/9yPtwSekt07NQjttPLXUqBO4Gh5X7UkK1xuVUC96LzpweqYj1aoXIFJQzYUh/Ak3hbMZRFlx6DnHvkome801vlMufo+NWudV3jK5oOkualC31GUy6KNq5Wo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975363; c=relaxed/simple;
	bh=kHnhBfAIq1RWFsY0IfM3EtnyfnJfWdNf0IMgKqpixhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sh8Ophr2xkcLkOLDGZBG3M42BasMvbElTRXyLULSvmBORLzlVfa36nArCRYeywCcusRnx1X4Z8gP9w1UQTtm7GE/AfILxisoLcFWPgjzC5hQjAkiclfixxc5Z0f0N/boNOvYr6kwPiYM8mxs49GS11jF2kgGQkgZDT+BH1fQifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JSWfvysW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ImMDjWNstCyJ2H7+5mr8HwNgK0oVItP1yOyP4gDpoPU=; b=JSWfvysWoZwUtky/z9A6dmEJbT
	zHv3rNwHjYYwk4Ug41vHosyQmycSxYJrnBgOeARIXNUTe4zAeT45W9PJuLVqqy3UuY9EMBlWNELBR
	DR2JOq212vFGcv9xmBEpxpqu27IXBSu/ATU/ZY9coKzjCwTZaqm5EeAmjj3nvFOnBrp1Jhp7JLSB1
	i7JRvqh31a4iKHfc9p6AJW1Im9Kv1LDEtCTwIsYKXy6ZuHaQcVHlaRmaDomEK0VJWcHiI9GfUbXVD
	v0yVTEXFKzc4qg3YLjc0GUOsyInfdvhRj60OlJ0DHlou8mFK11ouEqFQvRmTQYO0vqJdVbf3Z+4FY
	mtcLrsZg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMWNu-00000002KZE-0qm4;
	Tue, 03 Jun 2025 18:29:14 +0000
Date: Tue, 3 Jun 2025 19:29:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/memory: ensure fork child sees coherent memory
 snapshot
Message-ID: <aD8--plab38qiQF8@casper.infradead.org>
References: <20250603-fork-tearing-v1-0-a7f64b7cfc96@google.com>
 <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com>

On Tue, Jun 03, 2025 at 08:21:02PM +0200, Jann Horn wrote:
> When fork() encounters possibly-pinned pages, those pages are immediately
> copied instead of just marking PTEs to make CoW happen later. If the parent
> is multithreaded, this can cause the child to see memory contents that are
> inconsistent in multiple ways:
> 
> 1. We are copying the contents of a page with a memcpy() while userspace
>    may be writing to it. This can cause the resulting data in the child to
>    be inconsistent.
> 2. After we've copied this page, future writes to other pages may
>    continue to be visible to the child while future writes to this page are
>    no longer visible to the child.
> 
> This means the child could theoretically see incoherent states where
> allocator freelists point to objects that are actually in use or stuff like
> that. A mitigating factor is that, unless userspace already has a deadlock
> bug, userspace can pretty much only observe such issues when fancy lockless
> data structures are used (because if another thread was in the middle of
> mutating data during fork() and the post-fork child tried to take the mutex
> protecting that data, it might wait forever).

Um, OK, but isn't that expected behaviour?  POSIX says:

: A process shall be created with a single thread. If a multi-threaded
: process calls fork(), the new process shall contain a replica of the
: calling thread and its entire address space, possibly including the
: states of mutexes and other resources. Consequently, the application
: shall ensure that the child process only executes async-signal-safe
: operations until such time as one of the exec functions is successful.

It's always been my understanding that you really, really shouldn't call
fork() from a multithreaded process.

