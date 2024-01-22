Return-Path: <stable+bounces-12369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1418365A5
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 15:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846AD2848DC
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640603D554;
	Mon, 22 Jan 2024 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="goqLtilS"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03933D962
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934420; cv=none; b=L9xIgvuvYjUzRVCL4hT6Xr/coTxk4DfQqm2scqKoCcHegVZSJJM8gN1ml7l8vVg9oQyE7+z6NmhD4DPW/087G+ChKpGsIx06OJjK2aIwgKhmFXefZUtFd45Jc6dL/Zj0JWoXJPYI7utmqQo1OLQuR2sabJ+Fp396BNSqR7R6nt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934420; c=relaxed/simple;
	bh=R8e5ARB4KnJAoFGM9STNwmUc2WICDKUXxG5f9RXWZL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1N4lMYY/P50Q1GMTc7xrbhPaJcr2zi+g/2Cx34P5rD45YiBPN8oCMmBbjQCQLUsZsZdncC+CDw/7WCbXSePDA4O+1NvJw0gZQGk540s1D6VSQJNkEwzdGa9ILRsH9j+GZDDDn37MDEw2ANxVKI6k3x4MVbVQyiTM12+KLKH0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=goqLtilS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=6pOMP3fTGt6GWslB2QifweOOL01c/mzedDUrtRY3T6I=; b=goqLtilSaE6t4J2z+NmGiODd+o
	RPNMNw6AG7qeBHkl5biKnujraUhPRIX+fL6Mr0FWZleb26t8bB0WYXGCJ/BLrV0Bxc+ZW4stAR9mK
	4uP2mEf5gR8twhS4yyuQ7UAVtiMHYsmEYgHFVQbMvbVLI5yjP2oPsw6y9ObNnrhv0quQQyTcfN17U
	VMl36EgcoOc5WDCJD5MoN0dvLPCHFRm16N6v02IhnbUwyZIuhFIK8PT+7m1rgp7cEaBaqU9vE+oy/
	/RThNO6mC/PwHw2CYGo1SWxFCY/uOjcB12q7Yin8JKhGOrHxJN98bGIFXUzA6wvzbDH8W+HLqS1VB
	ypO4HsIg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRvTE-000000009sT-0OeJ;
	Mon, 22 Jan 2024 14:40:16 +0000
Date: Mon, 22 Jan 2024 14:40:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 01/15] ubifs: Set page uptodate in the correct place
Message-ID: <Za5-UJU0tqT9CYQj@casper.infradead.org>
References: <20240120230824.2619716-1-willy@infradead.org>
 <20240120230824.2619716-2-willy@infradead.org>
 <5ad7b6ed-664b-7426-c557-1495711a6100@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ad7b6ed-664b-7426-c557-1495711a6100@huawei.com>

On Mon, Jan 22, 2024 at 03:22:45PM +0800, Zhihao Cheng wrote:
> 在 2024/1/21 7:08, Matthew Wilcox (Oracle) 写道:
> > Page cache reads are lockless, so setting the freshly allocated page
> > uptodate before we've overwritten it with the data it's supposed to have
> > in it will allow a simultaneous reader to see old data.  Move the call
> > to SetPageUptodate into ubifs_write_end(), which is after we copied the
> > new data into the page.
> 
> This solution looks good to me, and I think 'SetPageUptodate' should be
> removed from write_begin_slow(slow path) too.

I didn't bother because we have just read into the page so it is
uptodate.  A racing read will see the data from before the write, but
that's an acceptable ordering of events.

