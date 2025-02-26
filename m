Return-Path: <stable+bounces-119721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 137C2A466C9
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 17:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BAE4420E4F
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 16:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA9022171C;
	Wed, 26 Feb 2025 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o8FrW8zE"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9012144AF;
	Wed, 26 Feb 2025 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587302; cv=none; b=XhWa3B0NHrwI9R2O+jn7QBAKZ5mhTPBto2plI2Vzm4IRiquX2b7FDC6KIL/XwPqOLpozdB9+RWruYVRdXB8AwZlHgD3jxbXA3DhqWHLXjLkXE0qer2F6w7iPawYQpVVadQs49LsWoDe8iXowzOQLGkgcrZ02FfkA5GXEltJTlRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587302; c=relaxed/simple;
	bh=RWgbNGbThZAIvkWf4FQylqpPbMrJViP+t/XR7nzg76w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzQYh4MJJXI4ia4StqUa3VW5ksMUoeZgFUyJdQ+wh+zsV+qPBit+0xsd7w99q+s8ZBLxnahwyvpZdrCqG9hTckhYmu1Y+0TDoLZ+/ixx+wztIdU920snzqP/fAtEGcMqxojPlli4EYPrmAosyGy3zjPpVp/IgC+4WUWUHcvWK0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o8FrW8zE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4RmUbpiZrPYzsk4xFenBE/pyKt10j/v0QGOy+nm2ZO0=; b=o8FrW8zE8bGYGDdg7xo7Qyk7OI
	gfB4DGIvFjlHlatRVJjFyihgwvj3lLUR+Jx9pG2RB9Xukf5r13j4BaW6Q4dYqwYvK/Ru3xbT/ABku
	0EIHZZT7ZVxNsuHnliwSShaVuxknQMUXF/9SSGwxlcNNxNH4pKKoKAWjWbQ4EVdLcugnAbAwLroxe
	67hHiaYqYkN8uyTExhXN6wMnu/zwE324JT5yvclKZkUFAVtF85hs3Zrk/wEaha3z/IdRSnLx7shqt
	wQ9OyxHXYfOG8k5Gr+HtRyVDR+GIsDaxhpHTHxYAYz5jZfKNYWauHzfsEb8nC4zb+47dRARQAtqAu
	eSpyro6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tnKGb-0000000Fv81-0qEB;
	Wed, 26 Feb 2025 16:28:13 +0000
Date: Wed, 26 Feb 2025 16:28:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	Marek Maslanka <mmaslanka@google.com>
Subject: Re: [PATCH] mm: fix finish_fault() handling for large folios
Message-ID: <Z79BHbCL3U5aGS0Q@casper.infradead.org>
References: <20250226114815.758217-1-bgeffon@google.com>
 <Z78fT2H3BFVv50oI@casper.infradead.org>
 <121abab9-5090-486b-a3af-776a9cae04fb@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <121abab9-5090-486b-a3af-776a9cae04fb@redhat.com>

On Wed, Feb 26, 2025 at 04:42:46PM +0100, David Hildenbrand wrote:
> On 26.02.25 15:03, Matthew Wilcox wrote:
> > On Wed, Feb 26, 2025 at 06:48:15AM -0500, Brian Geffon wrote:
> > > When handling faults for anon shmem finish_fault() will attempt to install
> > > ptes for the entire folio. Unfortunately if it encounters a single
> > > non-pte_none entry in that range it will bail, even if the pte that
> > > triggered the fault is still pte_none. When this situation happens the
> > > fault will be retried endlessly never making forward progress.
> > > 
> > > This patch fixes this behavior and if it detects that a pte in the range
> > > is not pte_none it will fall back to setting just the pte for the
> > > address that triggered the fault.
> > 
> > Surely there's a similar problem in do_anonymous_page()?
> 
> I recall we handle it in there correctly the last time I stared at it.
> 
> We check pte_none to decide which folio size we can allocate (including
> basing the decision on other factors like VMA etc), and after retaking the
> PTL, we recheck vmf_pte_changed / pte_range_none() to make sure there were
> no races.

Ah, so then we'll retry and allocate a folio of the right size the next
time?  Rather than the shmem case where the folio is already allocated
and we can't change that?

