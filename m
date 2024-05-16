Return-Path: <stable+bounces-45262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A2A8C741D
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 11:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED8C2813EF
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8C514388B;
	Thu, 16 May 2024 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kyR698HQ"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D1143878;
	Thu, 16 May 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852969; cv=none; b=scre7D6U6wwZKoqu2x9JqF0Rcg8G/4W2h2WL1tIIfmRdC3K1cgL/O3q13rtiuEq1uJ/MCCk0xfUnG9I4iwXaiiDI9ptI902fe4W3WlA4K/AIp7XOvg7hhvD9EP8pMusCCdU/B6q7OWbioRFQXlG5sfWkN8G3fuB7fLTvbeXPCpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852969; c=relaxed/simple;
	bh=UK/0CLTxn/iRzrJOsJGjbdS1+z1E8q2YacLno3NBJMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxqEX0Rbw7GtNnjKkmC5BwSZssdUTViyNJMeKcIgXsvcHTcBfhCYEsdcek5ZN6qLQ3gWAL2YH1JpyDAM2dWBTW2WDFvCYA9TKMP/my4Vl2e1w7PwdAwC3OQrvsGIpIfa3U5vSd6WkvmLuzky5w/MKqnuWXbzTVGnf66qRN5mWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kyR698HQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZZARwaTTzMN20E//X1keDK94ZjdM/XyvcrPzDeHSLRw=; b=kyR698HQHm8B/XGsyqNYkrXpAY
	Ay9EVr/nNwIDIYAfRzbULAjZKIRK0KmceeVNgKXP6DzdAmpj3+oG2YoXGLwVDW5nuQSQFdEl3fNAK
	ZryYroMCQFILebSrSq5Unm9my8O/e/DLbKC/PKFE+y3vbNPTBJCszGogiv736Vkb3mApERCQfVYFl
	vJGKBHQBsPbTSEwuJpVg/4gddARcKud34SJLaMRWEYva6bj76j9wX+Njq5vsMaqQzVH+HKHTmEqY7
	1gkprredFW3AIB+4Rxyb9WxfLw4MlMP2CUSdYB4aHKRTrZFgAB7EjKq/JNRLxQ8GJVizMTpQOtanL
	VrH/T/EQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7Xjl-00000005OT7-1BpS;
	Thu, 16 May 2024 09:49:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CF4B930068B; Thu, 16 May 2024 11:49:20 +0200 (CEST)
Date: Thu, 16 May 2024 11:49:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Carlos Llamas <cmllamas@google.com>, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, Nhat Pham <nphamcs@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] locking/atomic: scripts: fix ${atomic}_sub_and_test()
 kerneldoc
Message-ID: <20240516094920.GP12673@noisy.programming.kicks-ass.net>
References: <ZkRuMcao7lusrypL@J2N7QTR9R3>
 <20240515133844.3502360-1-cmllamas@google.com>
 <ZkXHxhhER-T6MhIX@J2N7QTR9R3>
 <20240516085310.GC24704@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516085310.GC24704@noisy.programming.kicks-ass.net>

On Thu, May 16, 2024 at 10:53:10AM +0200, Peter Zijlstra wrote:
> On Thu, May 16, 2024 at 10:45:58AM +0200, Mark Rutland wrote:
> > On Wed, May 15, 2024 at 01:37:10PM +0000, Carlos Llamas wrote:
> > > For ${atomic}_sub_and_test() the @i parameter is the value to subtract,
> > > not add. Fix the typo in the kerneldoc template and generate the headers
> > > with this update.
> > > 
> > > Fixes: ad8110706f38 ("locking/atomic: scripts: generate kerneldoc comments")
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: stable@vger.kernel.org
> > > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > ---
> > > 
> > > Notes:
> > >     v2: fix kerneldoc template instead, as pointed out by Mark
> > 
> > Thanks for this!
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > Peter, Ingo, are you happy to queue this up in the tip tree?
> 
> Yep can do. I'll sit on it until after the merge window though.

Also, do we really want this in stable? It's just a silly doc change.

