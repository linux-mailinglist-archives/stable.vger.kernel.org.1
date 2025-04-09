Return-Path: <stable+bounces-132016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DC0A83470
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 01:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F2377A9F36
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 23:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCD62144C4;
	Wed,  9 Apr 2025 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vhzk8li5"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D6115855E
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744240731; cv=none; b=uXoNTZrYs70zrLhZKgHJV17QDZPbWb9HDZEvAVoNpFQI44HD6qLurH4Ax2LAYPmSJvCrmZMU3m67uEkFW+1uPAXQ81euro6dpglaIJAuojSEaz1M1EeprAK1jFRTQ00wUqrsYwWKlJhXfATh1AnpH6MX+mqbqbhTEepMDV02ghE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744240731; c=relaxed/simple;
	bh=iuDjoJoK9qNLd32r4c/Sxi7hqHWPnlw/KIwV6mWhCm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utGD17NttJ4IZmvHtpP7Zd+1BuyOmgHNuySmErxUKHEfJgnQk+ZAP0G8uGIzsttpo3hiEhaXtXqwX3iHAAlTq3So0IbTdmjpoPJwI+LL7nEm0AGDDWLwe1yu+eBBOWE936HFSJaSEK+HLlw/LWmcWplSLPK2NH6TX9WxVxrCf5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vhzk8li5; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 9 Apr 2025 19:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744240725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6lnNhCARkmfZPIs4ZCP8cYdUTseSWihASprLxik5U8M=;
	b=vhzk8li5JnfJ4M7pKN1vQ5Vd9ceeh7sSnwuYgnuUo2JUALbiCQXbwLIAsyn3DsoaDn079C
	eeb9N04grTpaIyARLPeTuexg9yb6pspMQ679PB214NppcRhmgnbfnGApvL/CtyLhfPmG8D
	c+OuL0LTOwZRIN8W/XOxVMU3QDfJWnA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, mm-commits@vger.kernel.org, 
	stable@vger.kernel.org, janghyuck.kim@samsung.com, tjmercier@google.com
Subject: Re: +
 alloc_tag-handle-incomplete-bulk-allocations-in-vm_module_tags_populate.patch
 added to mm-hotfixes-unstable branch
Message-ID: <npfuocigbrn7wy25ssezqucz3kd5fjpmiqkeqzzmomz2r6wyrd@pmfig3afweud>
References: <20250409211241.70C37C4CEE2@smtp.kernel.org>
 <hzrrdhrvtabiz7g4bvj53lg64f7th5d7ravduisnaqmwmmqubr@f52xy2uq6222>
 <CAJuCfpGe3cY3yYGB03kTGJR-Dyh02w8spDDRkckjdP+qSKtdXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGe3cY3yYGB03kTGJR-Dyh02w8spDDRkckjdP+qSKtdXg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 09, 2025 at 03:31:57PM -0700, Suren Baghdasaryan wrote:
> On Wed, Apr 9, 2025 at 3:10 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Wed, Apr 09, 2025 at 02:12:40PM -0700, Andrew Morton wrote:
> > >
> > > The patch titled
> > >      Subject: alloc_tag: handle incomplete bulk allocations in vm_module_tags_populate
> > > has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
> > >      alloc_tag-handle-incomplete-bulk-allocations-in-vm_module_tags_populate.patch
> > >
> > > This patch will shortly appear at
> > >      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/alloc_tag-handle-incomplete-bulk-allocations-in-vm_module_tags_populate.patch
> > >
> > > This patch will later appear in the mm-hotfixes-unstable branch at
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > >
> > > Before you just go and hit "reply", please:
> > >    a) Consider who else should be cc'ed
> > >    b) Prefer to cc a suitable mailing list as well
> > >    c) Ideally: find the original patch on the mailing list and do a
> > >       reply-to-all to that, adding suitable additional cc's
> > >
> > > *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
> > >
> > > The -mm tree is included into linux-next via the mm-everything
> > > branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > and is updated there every 2-3 working days
> >
> > I don't think we want to rush this patch, given that it's not fixing an
> > actual crash.
> 
> It's not designed to fix a crash. The issue is that whenever tags
> require more than one page and CONFIG_PAGE_OWNER is enabled, memory
> allocation profiling gets disabled. I missed the fact that
> alloc_pages_bulk_node() can return less number of pages than requested
> and this patch fixes that.

That's my point; "allocation profiling gets silently disabled" is much
less severe than the crash we're chasing.

I just want to make sure we're not introducing new things while we're
chasing more severe bugs, although the patch does look simple enough.

