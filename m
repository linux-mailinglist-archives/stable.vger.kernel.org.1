Return-Path: <stable+bounces-110932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0C1A2043D
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 07:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6733A7398
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 06:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DAC18B476;
	Tue, 28 Jan 2025 06:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3AQEloRv"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30BB291E;
	Tue, 28 Jan 2025 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738044672; cv=none; b=WW0LQddck3EnGrDiHcdsnOIJYytqlzszGYB2ofo/6qMmbqWBmgQvzuBh547umdvghbfs/b3dk5BtRknkwxDCZ+CaS+TI5wyXaHPsNaDeIom475rDCFVsKCZyUWcGVluRnJTpSLnEUrOUuYusqzxn+1GxTnWUnrI8DxT/0bAFWyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738044672; c=relaxed/simple;
	bh=rBHA3Pm2W3BF74liP/qvvi1x7E/mRQQuZ6OGSZGJg2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fr7pBI64gbF7FIRJ+cz7gu7X75P4Y6+FjW/lXCX9ddHMJ7hDaozqkQn5tGuYFVbKAn2bwiL6DLIhH/m44tUAWkdtYI7VDJLBnisW9H3jtXUzQXzscPAd7/bb1w9jlvCtRqeaeslAfOSHzgxrK1lHorudLK7Zsa3Omwl2P2Z8ZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3AQEloRv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c714OJFB7cQM/YtQrLKZKC8DrlDxlJk9GWGGhuUBEb0=; b=3AQEloRvHPjFHzlww1iADuf01d
	WqFQ/d4Gz8TGLh/3wTNfYbnowc65+goVVa+5I8l7FhKBlV9mZSjeuOILcm5K+IbTYJBjE1hjhzPXY
	37F15yKCbtxScvAYojHm5E7u4J2JRpPXCi0ICWRpkRO3DRs6F+/uJHlMal1eOH4dTMjqq4jaGgUgu
	TBSYx/At+2S0npLyB1ikFxiHQXmJFcErYacGHbgxwF8LBZmyflwF+jFk++JBy5xjh5jAJXN86kkXd
	M1+QqJItwc2ZwBshxxfEgBzTt3HvHGb0sF/Xb4Yq1a+SO86HKGeEoDqng4/yDvcO0hNqCTQdOj+or
	A/q4+/Jw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tceoU-00000004C2L-2NtJ;
	Tue, 28 Jan 2025 06:11:06 +0000
Date: Mon, 27 Jan 2025 22:11:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	21cnbao@gmail.com, david@redhat.com, baolin.wang@linux.alibaba.com,
	aisheng.dong@nxp.com, liuzixing@hygon.cn
Subject: Re: [PATCH] mm/cma: add an API to enable/disable concurrent memory
 allocation for the CMA
Message-ID: <Z5h0-qtjQvhhLH6j@infradead.org>
References: <1737717687-16744-1-git-send-email-yangge1116@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1737717687-16744-1-git-send-email-yangge1116@126.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 24, 2025 at 07:21:27PM +0800, yangge1116@126.com wrote:
> From: yangge <yangge1116@126.com>
> 
> Commit 60a60e32cf91 ("Revert "mm/cma.c: remove redundant cma_mutex lock"")
> simply reverts to the original method of using the cma_mutex to ensure
> that alloc_contig_range() runs sequentially. This change was made to avoid
> concurrency allocation failures. However, it can negatively impact
> performance when concurrent allocation of CMA memory is required.
> 
> To address this issue, we could introduce an API for concurrency settings,
> allowing users to decide whether their CMA can perform concurrent memory
> allocations or not.
> 
> Fixes: 60a60e32cf91 ("Revert "mm/cma.c: remove redundant cma_mutex lock"")
> Signed-off-by: yangge <yangge1116@126.com>
> Cc: <stable@vger.kernel.org>

Umm, you're adding new unused functions while not even reporting what
the problem is.  This looks sketchy as hell and surely is not a stable
candidate.


