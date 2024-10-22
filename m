Return-Path: <stable+bounces-87656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFF39A9612
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 04:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F7A283E17
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 02:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F25139CE9;
	Tue, 22 Oct 2024 02:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y6HKmPWK"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A4D49652
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 02:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729563287; cv=none; b=AIG8JoycWy1IHtwEceC7EJggsH4E24AiroWzD9J+vAAowiI3yV6zhEVaEHKUJKNxxmoysV2Po0YOQepPqLC/Fy3W29Ha8TDlTX6mWEGqOmo/TEOfLw3Xmo3gGLS7FBGIAmfx7vPt+aprdxPA2tRL6HRSNNEcD5T0aMPKh3RYYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729563287; c=relaxed/simple;
	bh=sTtmY0y13ZexuwFhpN01pstLPxR8R6wNBpSwGWhuNAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gg57dG94InpzmEMbNBbUUYDk3qYhi7gV+UywYyaIt5vkV+W5BU7JNUjaQH4oDegdFKWlceCCHH0/v+xFWgg7unIfYRXULbBMKhtliQTSS1lltAu2/vQcRmd7kBWyjPsLv5h2Ur2uKyY5x6/EtlfsLjF1DWK7IZyev8VzBY8Mce0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y6HKmPWK; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Oct 2024 02:14:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729563283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lLWQY5iRq3tw5HyDjHCxYRkbP33kVvxx/p8GuY2FTmE=;
	b=Y6HKmPWKU2KkRgCLRXbWeSjzoT6zajeNhMF4IgPSPFZPvHNnUAh3mL6JkUEG/+bQHDJWLF
	zbek8/VTkR8iBpoR4wJ/GffP/GP8JZu4JEWRJe0PiJWPjFVCa1wiz4zuWGBZ4RO79dBKo8
	HIu+4jXASzZnNIDX1U+mNG0JJNd2Z48=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm: page_alloc: move mlocked flag clearance into
 free_pages_prepare()
Message-ID: <ZxcKjwhMKmnHTX8Q@google.com>
References: <20241021173455.2691973-1-roman.gushchin@linux.dev>
 <Zxa60Ftbh8eN1MG5@casper.infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxa60Ftbh8eN1MG5@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 21, 2024 at 09:34:24PM +0100, Matthew Wilcox wrote:
> On Mon, Oct 21, 2024 at 05:34:55PM +0000, Roman Gushchin wrote:
> > Fix it by moving the mlocked flag clearance down to
> > free_page_prepare().
> 
> Urgh, I don't like this new reference to folio in free_pages_prepare().
> It feels like a layering violation.  I'll think about where else we
> could put this.

I agree, but it feels like it needs quite some work to do it in a nicer way,
no way it can be backported to older kernels. As for this fix, I don't
have better ideas...

