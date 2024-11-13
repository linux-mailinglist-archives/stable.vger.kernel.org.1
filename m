Return-Path: <stable+bounces-92885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2398E9C6805
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 05:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A7228366D
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 04:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FE01CA9C;
	Wed, 13 Nov 2024 04:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YUznw+NH"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F5C230984
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 04:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731471582; cv=none; b=HHBxewa79HLi5PoK6M+C6imEdsedujlduNqljB/seVaOfNj/lLmChxwcw/yC9aWHeeGcSXnY2yMoIPguh1iS94j4vWnnpzLvUxM+jYzmH+SJ6GP9dfKt9LkIM7unprDfTeDzEmHiMllKSbO5jYYE9lRRHq6ZuhAabo2hJtoWa3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731471582; c=relaxed/simple;
	bh=6xdqilIlugJo3KpcAcH+z6aVAm4wRZO79stdez9H4o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLu8fOXtQQ8nXvuNvRBsO1HXAXgI962Xff/OYHOfn8bJ9l7PVnQSQ1mA7gMxyZKJssNZSqSXzu40xoEAEZAz+zmT+SFv4LV8D/UKrc5/+NtCQn9ouMpfKd8zZ5U/V4/xH0MqTOqYEaa69bcQUJ2yh3AQoyivRSxdk5l4Bgdnfmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YUznw+NH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kTALZnq2T1n7J//36VbyPVK6OXiR60ttmPhQ08LGmhM=; b=YUznw+NHEwKRlmPE75y+3RrIQy
	7bByRM6C60hdBI2iogehPlXa5JTiHPUVCqC50TJW4yihem5iVWr3K10upl0K7Mr7N/U7JlLDeLZVx
	hqTB1MMShMDBD/BeG7pPlAlY3Mrn2ODsTH92lsVEBaL0Xym8wc3ONGne8YtUxiJxbiYr4KzMBAvfR
	T3ysHUHfAkm4jlFbrsvk0wMTdmkNFyPseirnM4h9dSe4q+4iFH3fF44H03fZ3DL9EsrFREw6SU5sP
	/4DYttWAlHb7i3YudQTqYSEOumKMIjhGzl4tTcBsTTkKBXeJaYfqklCfGmg+TgkEv6rcVvqg3prC9
	MqmlvavA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tB4qu-0000000FfmP-1m5q;
	Wed, 13 Nov 2024 04:19:36 +0000
Date: Wed, 13 Nov 2024 04:19:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/readahead: Fix large folio support in async
 readahead
Message-ID: <ZzQo2JrXbGEkpPqb@casper.infradead.org>
References: <20241108141710.9721-1-laoar.shao@gmail.com>
 <85cfc467-320f-4388-b027-2cbad85dfbed@redhat.com>
 <CALOAHbAe8GSf2=+sqzy32pWM2jtENmDnZcMhBEYruJVyWa_dww@mail.gmail.com>
 <fe1b512e-a9ba-454a-b4ac-d4471f1b0c6e@redhat.com>
 <CALOAHbD6HsrMhY0S_d9XA0LRdMGr6wwxFYAnv6u-d7VRFt6aKg@mail.gmail.com>
 <cf446ada-ad3a-41a4-b775-6cb32f846f2a@redhat.com>
 <CALOAHbA=GuxdfQ8j-bnz=MT=0DTnrcNu5PcXvftfNh37WzRy1Q@mail.gmail.com>
 <a1fe53f7-a520-488c-9136-4e5e1421427e@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1fe53f7-a520-488c-9136-4e5e1421427e@redhat.com>

On Tue, Nov 12, 2024 at 04:19:07PM +0100, David Hildenbrand wrote:
> Someone configured: "Don't readahead more than 128KiB"

Did they, though?  I have nothing but contempt for the thousands of
parameters that we expect sysadmins to configure.  It's ridiculous and
it needs to stop.  So, we listen to the program that has told us "We
want 2MB pages" and not to the sysadmin who hasn't changed the value of
readahead from one that was originally intended for floppy discs.

> "mm/filemap: Support VM_HUGEPAGE for file mappings" talks about "even if we
> have no history of readahead being successful".
> 
> So not about exceeding the configured limit, but exceeding the "readahead
> history".
> 
> So I consider VM_HUGEPAGE the sign here to "ignore readahead history" and
> not to "violate the config".
> 
> But that's just my opinion.

We're using the readahead code to accomplish what filemap wants.
That's an implementation detail and we shouldn't be constrained by the
limits which are in effect for normal readahead.

Normal readahead will never create a folio larger than the readahead
window.  It'll get to 256kB (eventually) and then it'll stop.  Indeed,
that was the problem this patch is addressing -- we started at 2MB then
readahead turned it down to 256kB.  Normal readahead will start at 16kB
sized folios.  This patch won't affect normal readahead at all.

