Return-Path: <stable+bounces-65301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A6B94601B
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 17:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCED1F22A3E
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67DC163266;
	Fri,  2 Aug 2024 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hBeoR20Z"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFC916324E;
	Fri,  2 Aug 2024 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611794; cv=none; b=Ee63oqeUrJ6JJH03HmtViWz77xLhCbfr9/u9cujwvX9b6omgU1OqrOVzK2w/nQ62rklksnffStZjOmsEdsjf3KM6p5Avu35W7s5J82YwKI9D7A+tvyW97HmjGJHM4PuMzjswcWc4Ug2siDuqh/en34SADYDgctRtlW+7ZvUQ4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611794; c=relaxed/simple;
	bh=ptw62Dx7KpGz2/SaXqdbK1JlWPfPMFT/x1INY2ZvuQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1F5CiJlj/AGR28sBiNhZkqkNqRCFQ3g2T6etidN77+FUiRNUPBWACCx14jAHq2LifXsiGMJ8H2z+dV7fysctrQXoMWpe5D9u3xfhtmHxGpt5AvbnpQkbPmmkgS9vVc0m/6kTuWWusFX89z3EtHp47MIQ3RRsuqAAVVdsL89uUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hBeoR20Z; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h12L9RnFTRKUmkQS+xsOypuAp4ImvXqJfQcA8Jc/1G0=; b=hBeoR20Z9oh7sc/6fX3SlrsaC/
	M8WBVX96eq4W+Q23JpKKVcrwTYLism+Css0AIB4Zd3hALK0BQCamJ7YStEYzJ8Vnn4c4UFeBvmJnW
	UAQJ3Huwz2Ffd2oDLW+OtgNxw3A68KBhBFmo+a/R52Y93WfJZapOMV2cZrCOcH3U8StX02qypb37T
	LhDHzzPeKV1Neu8f5QyJ+gi9eq0YISxBlolW2svDG9G8DJUgRuGKYlrg/MMTDniHWRSqMxs0P+LgQ
	UsAYrcd/SYdg0qpURuB7FZD0eiyz1ANoUbyvBsZmscyrkvST3FYjiIoc0D4AtmrOKUARDXllcEf8+
	6Nz9K4/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZu0y-00000005jfr-1taT;
	Fri, 02 Aug 2024 15:16:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0785930049D; Fri,  2 Aug 2024 17:16:20 +0200 (CEST)
Date: Fri, 2 Aug 2024 17:16:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Carlos Llamas <cmllamas@google.com>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Stultz <jstultz@google.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Zhiguo Niu <zhiguo.niu@unisoc.com>, stable@vger.kernel.org,
	Xuewen Yan <xuewen.yan@unisoc.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4][RESEND x4] lockdep: fix deadlock issue between
 lockdep and rcu
Message-ID: <20240802151619.GN39708@noisy.programming.kicks-ass.net>
References: <20240514191547.3230887-1-cmllamas@google.com>
 <20240620225436.3127927-1-cmllamas@google.com>
 <b56d0b33-4224-4d54-ab90-e12857446ec8@paulmck-laptop>
 <ZnyS8rH8ZNirufcl@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnyS8rH8ZNirufcl@Boquns-Mac-mini.home>

On Wed, Jun 26, 2024 at 03:15:14PM -0700, Boqun Feng wrote:
> On Tue, Jun 25, 2024 at 07:38:15AM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 20, 2024 at 10:54:34PM +0000, Carlos Llamas wrote:
> > > From: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > > 
> > > There is a deadlock scenario between lockdep and rcu when
> > > rcu nocb feature is enabled, just as following call stack:
> > 
> > I have pulled this into -rcu for further review and testing.
> > 
> > If someone else (for example, the lockdep folks) would like to take this:
> > 
> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> 
> FWIW, I add this patch and another one [1] to my tree:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git lockdep
> 
> (based on today's tip/locking/core)
> 
> I figured I have time to handle lockdep-only patches, which shouldn't
> be a lot. So Ingo & Peter, I'm happy to help. If you need me to pick up
> lockdep patches and send a PR against tip/master or tip/locking/core,
> please let me know.

Sorry, I've been hopelessly behind on everything. Yes it would be nice
if you could help vacuum up some of the lockdep patches.



