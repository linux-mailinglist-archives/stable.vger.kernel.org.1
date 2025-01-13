Return-Path: <stable+bounces-108367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD17A0AEE1
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 06:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9259A3A6A2F
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 05:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF287230D02;
	Mon, 13 Jan 2025 05:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gvb1JbKg"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAFC10E0;
	Mon, 13 Jan 2025 05:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736747226; cv=none; b=fyRiDa7AR6ppmcJ/R/kaMymxjlU46WJCMg0DvdXY7eLa9Q32bjLxb38YG7kuDnYbsumdEOOh86wZfsT1OJysuv600x47qmbARqaxLd14K6B2+MPjLZNO8nup+GZlwFabR5N0KxHRBMuHmctTqTV4jXKlYImWdwtBVLP6UuWTKAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736747226; c=relaxed/simple;
	bh=WxjPia5DOZxFoTySNZERWmTCb9+dkDfsOBYYwX7BeG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGjv0ur9qpuJb/UpzJNMI8GP/lM15iemAl9/9uvGUTd6CPxOmJuHR+Atdt/Sr49HdL/EYgeJD3Ft7x+w4I7wQsIp9kMrgFyrSYoPidnI3NXYAWfR9zO56WuNe65Iw8TMK8fZy/zaOf8m2FOJ3e5bpu8Dt3yCVqJz2Ybheh6zs/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Gvb1JbKg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ad6vN+9jm5mfnc84bnorTllpfcNEkE7FxLBj4K2qyJ4=; b=Gvb1JbKgM26C8KgKznRbayHR4T
	RYO4Sjlpu6aS5TWw5KLmi7FuzZQGQPqcUfQ0iybSe1ywLqqpx2zHEK2HobZ3ha33sRjO2FFCXDkH8
	nhjEBmGzpu3aHokasNqPKXibiFE4p5gfnnbmjVhIqXHm+TVnISTLoyK7eR/ACXIEB1pmYwHh5R2ku
	+GNqK29IK215mY2MbtGX+2HUgP+bIFxormVDtQ5SqDaj25rjA5lXqaNPiomUaZ9Lp1omAYim66Hrp
	nhXgQNoLHxkw9ux2EhVo37bowO4qsKnzMdDs+KR+UdiVT3CVU1GkhHtXxu7aHSOkZSvUDQOMCRirL
	OWatxAhw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXDHz-000000044tu-44Je;
	Mon, 13 Jan 2025 05:47:03 +0000
Date: Sun, 12 Jan 2025 21:47:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: mark GFP_NOIO around sysfs ->store()
Message-ID: <Z4So1wfnrdf4uSxb@infradead.org>
References: <20250113015833.698458-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113015833.698458-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 13, 2025 at 09:58:33AM +0800, Ming Lei wrote:
> sysfs ->store is called with queue freezed, meantime we have several
> ->store() callbacks(update_nr_requests, wbt, scheduler) to allocate
> memory with GFP_KERNEL which may run into direct reclaim code path,
> then potential deadlock can be caused.
> 
> Fix the issue by marking NOIO around sysfs ->store()

Yes, that's a good thing, and we should aim for more of that for
block layer code that requires NOIO:

Reviewed-by: Christoph Hellwig <hch@lst.de>

