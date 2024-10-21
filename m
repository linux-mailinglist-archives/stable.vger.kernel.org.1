Return-Path: <stable+bounces-87639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8278E9A9152
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 22:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9FC0B22B89
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 20:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5884C1FDFA4;
	Mon, 21 Oct 2024 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X6pGH1/t"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131031FCC7F;
	Mon, 21 Oct 2024 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542881; cv=none; b=jSTckC2voOb0eli6FXszUbK/RB62WwIEi6DuOtVXRqgfHoNlCVy/cv1tZcE6JYZbdGmHB0aRCuBj/EJ4N9+y8tbZ1rlgiRWRP9fQPwOVFiVC0/CbOi21sJAlPwDkEgRmCvDaOlfS1lN68IsxFJtp/JDWDseh1064PUqEGWKPGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542881; c=relaxed/simple;
	bh=2aKHCD7HF/BNx/ZMDMdlRAyKmulryR7i/G3Sbf07QTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCYz9kXbYeLxsGvEVNfClJqkdGLduqCZ9KEZxGaACpa9kKBAgxuB+cMbNs0cgV29J8OhvNKBMj0AtvHd0AfZCZ2T6jK4NDl1ODxfWTJqvtdhBY7Wg7dWBZkA8ZcD2JzyVkYUiV+8KJirl40XqKCa9tFTyucIWGtOALVVNemHBWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X6pGH1/t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TCoATayQL6ScqW1XAVqLhkU9X3nCi6KYSYnaGXGM4LI=; b=X6pGH1/t3oiG4Ha7YTPU9ThRaR
	ygQodXSJRJFYQqvjHoIsRj25x+RiRRkkCh98SMXGninHw2E5QGRrfP73EW0Eg1Xi6WrSaBYzqejTV
	CvAkBc4fAV0YQyh/teyiR7+Zt4zvnDRjYIo0GrVNjmNZhth6kIFFr3YPyDQRMOpo4ueREjbweg1Kb
	q7yt0D0xdCcx70ahdamezMTzOHsACXDa2BdvL1Na/3yL1zjIatEvepnLUmove7pSiTYQpiSy5yiGU
	4DWQqBi7TRQGDgEZz5xcdhB2ryFpyddI2DBE7MEQjkrl2yWGpPSnGL1ZwMyaORUQ7ax+tssGchAMS
	WgBEJSwg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t2z6f-0000000Gjj7-0W2g;
	Mon, 21 Oct 2024 20:34:25 +0000
Date: Mon, 21 Oct 2024 21:34:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm: page_alloc: move mlocked flag clearance into
 free_pages_prepare()
Message-ID: <Zxa60Ftbh8eN1MG5@casper.infradead.org>
References: <20241021173455.2691973-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021173455.2691973-1-roman.gushchin@linux.dev>

On Mon, Oct 21, 2024 at 05:34:55PM +0000, Roman Gushchin wrote:
> Fix it by moving the mlocked flag clearance down to
> free_page_prepare().

Urgh, I don't like this new reference to folio in free_pages_prepare().
It feels like a layering violation.  I'll think about where else we
could put this.


