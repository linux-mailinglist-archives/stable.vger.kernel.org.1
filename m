Return-Path: <stable+bounces-45256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B65F78C7348
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 10:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F0C1C22727
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 08:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B852142E9C;
	Thu, 16 May 2024 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lxHgHtdi"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B097142E75;
	Thu, 16 May 2024 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849600; cv=none; b=koTSj5ht9ydvnHCPozktPHBSsmpVJ3++LekZ/+Bqt7h8p3cPrYKfTD19yBxoCbGXPqPPnrkubhDNn7L6ixO1g7TBubElxjF7yQLrdNyusZZhfl6p1MyBav5IfrxsEH4Owk1JmGqQTC+bOiEa2N7UNmJSxB4gCGaDkDjpO4oUA2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849600; c=relaxed/simple;
	bh=7xuFgpJIAorfAq7PwDAhvKMkfq2crDGX5PbqWdYkNiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amM+Dz4J2/tI5kCe5ySyNRVuYD/eeQfsz5SgtPmjMQ/hKwz92A8rHDNdH2pytslX8EYUC6c0BpmMhFfJSjhWC3gd+TvACJJFipyGxcJFfOreQsud7n+0mkcHQ4qE9DEsMHqxBi58ufqUhaESm9v9n9chfRsJz0qAaE54WpyeVl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lxHgHtdi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YRkYJHUYGOGWII6Wxa+fTiXXSEwb5z6ru0bgsR2/vsc=; b=lxHgHtdiNkL8dkqbsBXwvVv84q
	kNzSauw8odEUBgKJgmxXZIUp9kQ0Tqk92AJbDNQ8Kl9ustDU2H8BD8C0CWlpiQHC6QhPrHCpRQbcf
	FrUwPPtRH2Yn1G92Eweg6RginGkqMbE2TfNhwFLZ3EClZX+4l6b2oFvNda/hiRM7hnFjjSgsLg/ck
	K5lh+JElBzg3/lqc2h6SrrP92ZVrT4iCk/VSxPP6ixwlhl8haNBubfievqEpBSaiUCrECqG4Tv5+Q
	fgb59/v7AqvA99Z6sds/1voviGvK7HXgqS2fUNBy9DXsq03gZtjbnxuLLgBGZczE1uQ4JvIsHzhwx
	/U3abuTA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7WrO-0000000BaWq-2JHn;
	Thu, 16 May 2024 08:53:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0FB4B30068B; Thu, 16 May 2024 10:53:10 +0200 (CEST)
Date: Thu, 16 May 2024 10:53:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Carlos Llamas <cmllamas@google.com>, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, Nhat Pham <nphamcs@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] locking/atomic: scripts: fix ${atomic}_sub_and_test()
 kerneldoc
Message-ID: <20240516085310.GC24704@noisy.programming.kicks-ass.net>
References: <ZkRuMcao7lusrypL@J2N7QTR9R3>
 <20240515133844.3502360-1-cmllamas@google.com>
 <ZkXHxhhER-T6MhIX@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkXHxhhER-T6MhIX@J2N7QTR9R3>

On Thu, May 16, 2024 at 10:45:58AM +0200, Mark Rutland wrote:
> On Wed, May 15, 2024 at 01:37:10PM +0000, Carlos Llamas wrote:
> > For ${atomic}_sub_and_test() the @i parameter is the value to subtract,
> > not add. Fix the typo in the kerneldoc template and generate the headers
> > with this update.
> > 
> > Fixes: ad8110706f38 ("locking/atomic: scripts: generate kerneldoc comments")
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: stable@vger.kernel.org
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> > 
> > Notes:
> >     v2: fix kerneldoc template instead, as pointed out by Mark
> 
> Thanks for this!
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Peter, Ingo, are you happy to queue this up in the tip tree?

Yep can do. I'll sit on it until after the merge window though.

