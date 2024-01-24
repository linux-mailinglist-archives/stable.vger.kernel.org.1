Return-Path: <stable+bounces-15608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8AA83A0D7
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 06:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44861F221CA
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 05:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55B6C2D3;
	Wed, 24 Jan 2024 05:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oPWAa+Sg"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152EF53A2
	for <stable@vger.kernel.org>; Wed, 24 Jan 2024 05:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706072524; cv=none; b=kt80gsyMiV6/MbdnoHhKJthpSbRymCw3PQKuYqPt++LsFRRutYAvT0cbWTAGk7t+ts5ZWXUt24pq2Rdp8SLEWwcZ9LVlyD/16OjSHgYhMzAwiNXGjCmsvgktgbTFP/KGyvPr/Wa8NkrG/QsVTlzlYYnF1QJGK3ToXn9DAW2/BWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706072524; c=relaxed/simple;
	bh=P8Myk5NoiglvmRQr4TYEDuB/iWUXak4rWOVWrcE8weo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDdmD16xt+QJXIdEEzblv/VPsWv6/Cr2BRnt98u7Mvr9gBcRCfFiqC34wW43AC4htoWuQCHa77f76mdPM8zlhmljVHjWNHxBJh1MF5JFtR1wsCpTcmEhwD+bNZQpSyUTyX9EFYs5wqPLfZkcI+VhROgycpyNR87t7yn2KzDcY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oPWAa+Sg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dM8PzBTTni6ZPdoQBjm+7nvGl/T2wkEHPjdqyFS7UPE=; b=oPWAa+SgI0mcod0jIinUiLcood
	FX5ybPXLogPG5x59YeWE7oN+FfIYKl3FLsNfoxsYpygnLpROXotxDwbV4oueKcFqDRjv+TI/hO1Ri
	5x4qCaJ6ALn2Fp9svqfH0ReMoSmhtq7JrCs/8RFNTXn9USvcbKbYeHAmTY1ZAuoTzjMOJ3Il9tXgh
	9/JkfxucQWFQ3AmJtX5EDwJ5Psn711juDLb4flB+12Qzw1yW5XhmY9BK1951aQsBhW7upRLkYuF9Q
	msGuZP7VyTPajyxFySUroeCFliwgS7yOOKtXs5wbNpci8IZ9TiSEkTyEb8IUy4Ujen5WIRr2UfxCV
	JTm/i7tg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSVOh-00000005Rck-0S07;
	Wed, 24 Jan 2024 05:01:59 +0000
Date: Wed, 24 Jan 2024 05:01:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 01/15] ubifs: Set page uptodate in the correct place
Message-ID: <ZbCZx10_Yj-TlSdM@casper.infradead.org>
References: <20240120230824.2619716-1-willy@infradead.org>
 <20240120230824.2619716-2-willy@infradead.org>
 <5ad7b6ed-664b-7426-c557-1495711a6100@huawei.com>
 <Za5-UJU0tqT9CYQj@casper.infradead.org>
 <f96965c0-8464-c12c-7e5c-95ba74d10b7d@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f96965c0-8464-c12c-7e5c-95ba74d10b7d@huawei.com>

On Tue, Jan 23, 2024 at 10:36:14AM +0800, Zhihao Cheng wrote:
> 在 2024/1/22 22:40, Matthew Wilcox 写道:
> > On Mon, Jan 22, 2024 at 03:22:45PM +0800, Zhihao Cheng wrote:
> > > 在 2024/1/21 7:08, Matthew Wilcox (Oracle) 写道:
> > > > Page cache reads are lockless, so setting the freshly allocated page
> > > > uptodate before we've overwritten it with the data it's supposed to have
> > > > in it will allow a simultaneous reader to see old data.  Move the call
> > > > to SetPageUptodate into ubifs_write_end(), which is after we copied the
> > > > new data into the page.
> > > 
> > > This solution looks good to me, and I think 'SetPageUptodate' should be
> > > removed from write_begin_slow(slow path) too.
> > 
> > I didn't bother because we have just read into the page so it is
> > uptodate.  A racing read will see the data from before the write, but
> > that's an acceptable ordering of events.
> > .
> > 
> 
> I can't find where the page is read and set uptodate. I think the
> uninitialized data can be found in following path:

You're right; thanks.  I'd misread the code.  I'll send a new version in
a few hours.

