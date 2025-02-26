Return-Path: <stable+bounces-119680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A21A461AB
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EA91703A1
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 14:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021CE21883D;
	Wed, 26 Feb 2025 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZwWSHfRK"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884CC22157E;
	Wed, 26 Feb 2025 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578655; cv=none; b=ZMDMVr/ml4ggbboaVSbtuR/cd26tPMqc2UEI4ZT4ijNX7zqnxkoMIVQ4O/yGgrwuwTfpIh/G8Z7nti4JLxaHA7atbLBaMLKNOypOpe+mGLViSWSXvd8BTEWKfTgwKzAjh1Rni9mMPX0jHH4hbkYw9mSVOP387xMc6eTfFJUZCk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578655; c=relaxed/simple;
	bh=DVGs1+fz/SuvgkCvbQyZt1mNBaQJ8m+WuOHAxSzwmTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLUCTGE8gFIIP4vtH4ZudBJmLwesjI8biZdZLITsgEPGjzeZY10PfnyLP0IP4E1PO/ACYIQfzHs4rHIG3dtAWnLiRjRSpmWoS7IOZP3a0mfDV4+SYnpO4No9lalRw055TkZo39b9QFRlHrRLi3YI9vGuwCgEOXQaeeYzImEaDqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZwWSHfRK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3zH5voWFtLFeB3u4kEV7l7Vgk1NEa2IbTHLhLzVHJrE=; b=ZwWSHfRKbiUZ4ClfJC5LJAjtlQ
	5c7nXrVxB0QPtzE16QHRq0qtgTN7eezNu82yIzT8MxlI2Y/D6r/1Lp6j1uEqFHB6J62ywKMIcppPa
	wvB3xGuNa4pqYeirPGvhmBSraqwQZtwWJFo+rIZpvicM9FzBWn2HZz2FRHNF7REhUKySf1Az7tn31
	wGS7S4O+zO5tXDyKDSQMlzzgxE6P5r6QPgqVGmKPyf4DEObJ3CCPh0s3mfPDFmGRBtfeMvKVII4ke
	CwjOfXNqwYZvSzp1JrF9He7nT9LHctkJcBG27kHtMkCmRcBW6Xj3UBKZRqDf+FgMQDJ5lOXHvoejM
	E47B2vAA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tnI11-0000000FXTY-40ye;
	Wed, 26 Feb 2025 14:04:00 +0000
Date: Wed, 26 Feb 2025 14:03:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Brian Geffon <bgeffon@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	Marek Maslanka <mmaslanka@google.com>
Subject: Re: [PATCH] mm: fix finish_fault() handling for large folios
Message-ID: <Z78fT2H3BFVv50oI@casper.infradead.org>
References: <20250226114815.758217-1-bgeffon@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226114815.758217-1-bgeffon@google.com>

On Wed, Feb 26, 2025 at 06:48:15AM -0500, Brian Geffon wrote:
> When handling faults for anon shmem finish_fault() will attempt to install
> ptes for the entire folio. Unfortunately if it encounters a single
> non-pte_none entry in that range it will bail, even if the pte that
> triggered the fault is still pte_none. When this situation happens the
> fault will be retried endlessly never making forward progress.
> 
> This patch fixes this behavior and if it detects that a pte in the range
> is not pte_none it will fall back to setting just the pte for the
> address that triggered the fault.

Surely there's a similar problem in do_anonymous_page()?

At any rate, what a horrid function finish_fault() has become.
Special cases all over the place.  What we should be doing is
deciding the range of PTEs to insert, bounded by the folio, the VMA
and any non-none entries.  Maybe I'll get a chance to fix this up.

