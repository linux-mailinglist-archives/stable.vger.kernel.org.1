Return-Path: <stable+bounces-139552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E9AAA847E
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 09:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBAE3BC5D8
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 07:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1E6183CC3;
	Sun,  4 May 2025 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2uXzKB5t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B539633E4;
	Sun,  4 May 2025 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746342949; cv=none; b=lfkG78n46SDqdINq2NHhULBhlctwcV37w1VbiJZ82f/r5WF1ls5qx912ZO+zY4hhM6zun20yUGpYNjGUhPyYvWmSPm79awfS/jIeLvo6BHDQlb8fNFf5rbOrWQBMXi/mhU2i//SMxu/C/0Sr2uRQMrqDjfXwhkVCTLye0AmiFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746342949; c=relaxed/simple;
	bh=VFl4En76y+OpLSujTCsVixWtJLfVBo8Fs18pWu67NIM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=b/VaSgUtart1zN0vBybrzXinlWwsi0NcUBzmeb+n+9HCK81IJ2rXBu64yxrJsWxF50RqHFCHsG45lvJjqMUWY/cB9D1mFAC11tOguhlpLKuhIJUF2UYcPn2EkvTf2eyU0Q+q5s5rVVXYixOS1WabQSbnc3V0XBlZUAsAWmOhZq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2uXzKB5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4ACC4CEE7;
	Sun,  4 May 2025 07:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746342948;
	bh=VFl4En76y+OpLSujTCsVixWtJLfVBo8Fs18pWu67NIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2uXzKB5tvtLWjn/EIY9A1H8ngwh4gxek1y6s8EfSOlGHERXtBEhbis3cIKTA95NjD
	 yjN42znkaYuXQtcC5AV7PmRQ432nN/JjnMJEbs5NSR1otBH6CPfHyYBriZnESpnGbC
	 /m0ml7+nmhQfFTbiTpnqkt55ZUJbHolqqTwmGm24=
Date: Sun, 4 May 2025 00:15:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Petr =?UTF-8?Q?Van=C4=9Bk?= <arkamar@atlas.cz>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Ryan Roberts <ryan.roberts@arm.com>,
 xen-devel@lists.xenproject.org, x86@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: fix folio_pte_batch() on XEN PV
Message-Id: <20250504001547.177b2aba8c2ffbfe63e0552e@linux-foundation.org>
In-Reply-To: <9e3fb101-9a5d-43bb-924a-0df3c38333f8@redhat.com>
References: <20250502215019.822-1-arkamar@atlas.cz>
	<20250502215019.822-2-arkamar@atlas.cz>
	<20250503182858.5a02729fcffd6d4723afcfc2@linux-foundation.org>
	<9e3fb101-9a5d-43bb-924a-0df3c38333f8@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 May 2025 08:47:45 +0200 David Hildenbrand <david@redhat.com> wrote:

> > 
> > Methinks max_nr really wants to be unsigned long. 
> 
> We only batch within a single PTE table, so an integer was sufficient.
> 
> The unsigned value is the result of a discussion with Ryan regarding similar/related
> (rmap) functions:
> 
> "
> Personally I'd go with signed int (since
> that's what all the counters in struct folio that we are manipulating are,
> underneath the atomic_t) then check that nr_pages > 0 in
> __folio_rmap_sanity_checks().
> "
> 
> https://lore.kernel.org/linux-mm/20231204142146.91437-14-david@redhat.com/T/#ma0bfff0102f0f2391dfa94aa22a8b7219b92c957
> 
> As soon as we let "max_nr" be an "unsigned long", also the return value
> should be an "unsigned long", and everybody calling that function.
> 
> In this case here, we should likely just use whatever type "max_nr" is.
> 
> Not sure myself if we should change that here to unsigned long or long. Some
> callers also operate with the negative values IIRC (e.g., adjust the RSS by doing -= nr).

"rss -= nr" doesn't require, expect or anticipate that `nr' can be negative!

> 
> > That will permit the
> > cleanup of quite a bit of truncation, extension, signedness conversion
> > and general type chaos in folio_pte_batch()'s various callers.
> > > And...
> > 
> > Why does folio_nr_pages() return a signed quantity?  It's a count.
> 
> A partial answer is in 1ea5212aed068 ("mm: factor out large folio handling
> from folio_nr_pages() into folio_large_nr_pages()"), where I stumbled over the
> reason for a signed value myself and at least made the other
> functions be consistent with folio_nr_pages():
> 
> "
>      While at it, let's consistently return a "long" value from all these
>      similar functions.  Note that we cannot use "unsigned int" (even though
>      _folio_nr_pages is of that type), because it would break some callers that
>      do stuff like "-folio_nr_pages()".  Both "int" or "unsigned long" would
>      work as well.
> 
> "
> 
> Note that folio_nr_pages() returned a "long" since the very beginning. Probably using
> a signed value for consistency because also mapcounts / refcounts are all signed.

Geeze.

Can we step back and look at what we're doing?  Anything which counts
something (eg, has "nr" in the identifier) cannot be negative.

It's that damn "int" thing.  I think it was always a mistake that the C
language's go-to type is a signed one.  It's a system programming
language and system software rarely deals with negative scalars. 
Signed scalars are the rare case.

I do expect that the code in and around here would be cleaner and more
reliable if we were to do a careful expunging of inappropriately signed
variables.

> 
> > 
> > And why the heck is folio_pte_batch() inlined?  It's larger then my
> > first hard disk and it has five callsites!
> 
> :)
> 
> In case of fork/zap we really want it inlined because
> 
> (1) We want to optimize out all of the unnecessary checks we added for other users
> 
> (2) Zap/fork code is very sensitive to function call overhead
> 
> Probably, as that function sees more widespread use, we might want a
> non-inlined variant that can be used in places where performance doesn't
> matter all that much (although I am not sure there will be that many).

a quick test.

before:
   text	   data	    bss	    dec	    hex	filename
  12380	    470	      0	  12850	   3232	mm/madvise.o
  52975	   2689	     24	  55688	   d988	mm/memory.o
  25305	   1448	   2096	  28849	   70b1	mm/mempolicy.o
   8573	    924	      4	   9501	   251d	mm/mlock.o
  20950	   5864	     16	  26830	   68ce	mm/rmap.o

 (120183)

after:

   text	   data	    bss	    dec	    hex	filename
  11916	    470	      0	  12386	   3062	mm/madvise.o
  52990	   2697	     24	  55711	   d99f	mm/memory.o
  25161	   1448	   2096	  28705	   7021	mm/mempolicy.o
   8381	    924	      4	   9309	   245d	mm/mlock.o
  20806	   5864	     16	  26686	   683e	mm/rmap.o

 (119254)

so uninlining saves a kilobyte of text - less than I expected but
almost 1%.

Quite a lot of the inlines in internal.h could do with having a
critical eye upon them.

