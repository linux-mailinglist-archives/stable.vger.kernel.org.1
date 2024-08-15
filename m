Return-Path: <stable+bounces-68451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E3095325C
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E81B25AEF
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C7C1A2C04;
	Thu, 15 Aug 2024 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pk7mYOPb"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5E719DF5F;
	Thu, 15 Aug 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730610; cv=none; b=DTDOo4I0L1cPUji55V3p0TA83AmEsu349baRbyoSH4QhucNZJH39skfxTUWFR9QSeykP+MkdQW1vTi6MEfNPojSrZ25Yhjg8+wa/EVqjk+ZCqiqNW3uXT7Fwdy49KZ4ZacAjjsLQsnHUW13QJ4NAJBUoPIw3uegRbyQRIxmBtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730610; c=relaxed/simple;
	bh=nSYpd62r6UtYUdvlWZL2IxTGJ7K336x2V+hzU1pHV6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfjlZBc3Xz+Lq1iWsT7lzbhjjltkklctCjhYPWB6B+KdA+3QuCrDUwvEzq1hITQ7uystOGDEWbxSx0PP+uCS9B+k9T6H68bYeBkhGWDIbVcVL6vSGNYO2nXAb/usPC1uYE8fnnpWSwhglajo45I+9lmCHdVfLB8mAjtgtqQsrSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pk7mYOPb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Iz5zJYVdt2PwlMZw4lGIuy+KJO4O7HSBp8yg91/HUWY=; b=pk7mYOPbmEErEsdPGoK+fJ2D8D
	jT54y+y8r050HsiNPWftlDtFpcY93arSmDhaslI9wVsD0dEzvrfLV4/TtlEX5s9WlsyRwQEVOqvY9
	an4BpyXlPeQcCgWTJYgVP3wZc/ieOjXA0OVwGgUlbwPkg5r6EuyNHHWAxEfL9pp3ltRwQvmd03v9P
	8S6tral/JF2I32ZAQywFC/b7tLr4audaFqv0yq1rauKvxrr6PlmqeBdFGxIuYZcnpuARnIdyLZCVw
	jnvvw/ATYnnWGElsuS4C0CtFcePXlVXcsFUJFUNDgFFab5pgf1Ae8v9Qna/Yqtatjdw8AzuDtQDzD
	yKlk736w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seb4N-000000029R0-11tq;
	Thu, 15 Aug 2024 14:03:15 +0000
Date: Thu, 15 Aug 2024 15:03:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: Patch "ext4: convert ext4_da_do_write_end() to take a folio" has
 been added to the 6.6-stable tree
Message-ID: <Zr4KowVhqnWmmjH_@casper.infradead.org>
References: <20240815122216.72860-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815122216.72860-1-sashal@kernel.org>

On Thu, Aug 15, 2024 at 08:22:16AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     ext4: convert ext4_da_do_write_end() to take a folio
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      ext4-convert-ext4_da_do_write_end-to-take-a-folio.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

I'd think you'd want to backport 83f4414b8f84 to before folios existing,
so you may as well use the same patch for 6.6 as you'd want to use for
those older kernels.  ie:

	if (unlikely(!page_buffers(page))) {
		unlock_page(page);
		put_page(page);
		return -EIO;
	}

but maybe this has already been discussed and I wasn't cc'd on that
discussion.

