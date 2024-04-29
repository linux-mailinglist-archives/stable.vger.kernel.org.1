Return-Path: <stable+bounces-41593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D188B4F9D
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 04:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC601C20BE9
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 02:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7ED79F5;
	Mon, 29 Apr 2024 02:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qt92vWaH"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C28C127
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714359410; cv=none; b=HQdi0T0eBJLINtDh+OuyI6B0uV7I02suLYvbqq8W0s2NfAwnMJVxk1lIBfFzf4Jr+oH5JT5bFaiiqIfqUDugkvBL5lIDs2aDlstnbMBS7nMtgzkzfTIIcFo9MgZYk7e6JhJaSMJmX0mKJvhVgdQuvHOXO6GU49pnoxj1J324Nqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714359410; c=relaxed/simple;
	bh=JZvg+4wtYLhKMgVY7BxmJlpMayfMyzWb5pVYA7DM7zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r86rEL9EX5Vort7p1YXOoN/o4el2kjVVeTgtRj6P1rM5jpqnxLkPzIeUZHA1JsjLtW6oZzy4Ung1NiCQsDXF9QPBk+31Df92ZO1rHFrJeiwPoo6Cp10j8weWkLW87vzGV4jU0Cj+PklgxyZvI+nH+VeHOXGkvrj64x7wDu0AdB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qt92vWaH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HE5Yq1xVJlxSoXB2AOlwu9SQVQ4az5yC/T5U4mM0458=; b=qt92vWaHY3mx1YLnHFHXY2k/5e
	OKDbtI0Fq7B5+yyRlJSQIjuic7hRD16cqTrz4rIbD8xGBFp+7YY02UQdQYDWLDCqsZUbWKMJfuZtF
	eGUzYPg+62PmBiKFRUPNA8IeamSSq9AmyNUHsBYmrXjjhyrR5q1IzG62nS4TPnTB0UeWm9OhFU8EE
	49uPqcHWXtUNxPvjtbLoTKeXXhcr0eRI2/8JmAx3EsQ8p5jBqDWq7BTyOoxozsGdfWxuYrkk8yq9u
	K81SoYNnQJgrxqdM7BAp6EBLGwxERyP+x8pnM05ueSbzuZcf25RuJR8Pb4bIJwC/tbbkTxxy/pjYi
	fx5R+wUg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1HBt-0000000B9f3-40OO;
	Mon, 29 Apr 2024 02:56:30 +0000
Date: Mon, 29 Apr 2024 03:56:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Cc: riel@surriel.com, mgorman@techsingularity.net, peterz@infradead.org,
	mingo@kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org,
	sashal@kernel.org,
	=?utf-8?B?0JHQtdGC0YXQtdGAINCQ0LvQtdC60YHQsNC90LTRgA==?= <a.betkher@rosalinux.ru>,
	i.gaptrakhmanov@rosalinux.ru
Subject: Re: Serious regression on 6.1.x-stable caused by "bounds: support
 non-power-of-two CONFIG_NR_CPUS"
Message-ID: <Zi8MXbT9Ajbv74wK@casper.infradead.org>
References: <1c978cf1-2934-4e66-e4b3-e81b04cb3571@rosalinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c978cf1-2934-4e66-e4b3-e81b04cb3571@rosalinux.ru>

On Sun, Apr 28, 2024 at 05:58:08PM +0300, Mikhail Novosyolov wrote:
> Hello, colleagues.
> 
> Commit f2d5dcb48f7ba9e3ff249d58fc1fa963d374e66a "bounds: support non-power-of-two CONFIG_NR_CPUS" (https://github.com/torvalds/linux/commit/f2d5dcb48f7ba9e3ff249d58fc1fa963d374e66a) was backported to 6.1.x-stable (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=428ca0000f0abd5c99354c52a36becf2b815ca21), but causes a serious regression on quite a lot of hardware with AMD GPUs, kernel panics.
> 
> It was backported to 6.1.84, 6.1.84 has problems, 6/1/83 does not, the newest 6.1.88 still has this problem.

Does v6.8.3 (which contains cf778fff03be) have this problem?
How about current Linus master?

What kernel config were you using?  I don't see that info on
https://linux-hardware.org/?probe=9c92ac1222
(maybe my tired eyes can't see it)

