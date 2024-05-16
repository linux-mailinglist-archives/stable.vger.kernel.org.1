Return-Path: <stable+bounces-45263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC4F8C744F
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 12:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDF69B24461
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4317143C4D;
	Thu, 16 May 2024 10:02:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CC7143899;
	Thu, 16 May 2024 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853779; cv=none; b=d+FzjIuIqbQXoXQqO2cnnZ3XTquUMzrKqTy+fpPDeZVKIRphnMcLz1h3xe2hJdvfzad8YETsTaLlOrhqfevQ2gkA8TcUhrQxgSgu+z3xWkytQsKS5DHiWY/WGpz7gwkQWZtvqAJNsHadwOGwdrGIJYzLaF3Ar5Ld4aErUG/gVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853779; c=relaxed/simple;
	bh=4iU7fsCDbTgfTvlAlpiuArNe+aWS8SDmjPDXgljdep0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DftsFRjQJi6zzVMxk9XKETUXZiUeACoY9wpCW97/6zl8SLOBaCGttVAlixyN9i6wqkA8rLPqCYx5/8mU7gpOjtr7iR0TyUIqiEpnPnzL8F49KKFmo/y7Y+axxyd3n8gqsdz+7ZiLT6rPoI6v6ZGGCLpTghm/RpJULVy3u23ua6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6763213D5;
	Thu, 16 May 2024 03:03:20 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAEC93F762;
	Thu, 16 May 2024 03:02:53 -0700 (PDT)
Date: Thu, 16 May 2024 12:02:50 +0200
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <ZkXZyijVOdtxu763@J2N7QTR9R3>
References: <ZkRuMcao7lusrypL@J2N7QTR9R3>
 <20240515133844.3502360-1-cmllamas@google.com>
 <ZkXHxhhER-T6MhIX@J2N7QTR9R3>
 <20240516085310.GC24704@noisy.programming.kicks-ass.net>
 <20240516094920.GP12673@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516094920.GP12673@noisy.programming.kicks-ass.net>

On Thu, May 16, 2024 at 11:49:20AM +0200, Peter Zijlstra wrote:
> On Thu, May 16, 2024 at 10:53:10AM +0200, Peter Zijlstra wrote:
> > On Thu, May 16, 2024 at 10:45:58AM +0200, Mark Rutland wrote:
> > > On Wed, May 15, 2024 at 01:37:10PM +0000, Carlos Llamas wrote:
> > > > For ${atomic}_sub_and_test() the @i parameter is the value to subtract,
> > > > not add. Fix the typo in the kerneldoc template and generate the headers
> > > > with this update.
> > > > 
> > > > Fixes: ad8110706f38 ("locking/atomic: scripts: generate kerneldoc comments")
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: stable@vger.kernel.org
> > > > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > > ---
> > > > 
> > > > Notes:
> > > >     v2: fix kerneldoc template instead, as pointed out by Mark
> > > 
> > > Thanks for this!
> > > 
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > > 
> > > Peter, Ingo, are you happy to queue this up in the tip tree?
> > 
> > Yep can do. I'll sit on it until after the merge window though.
> 
> Also, do we really want this in stable? It's just a silly doc change.

I think that we do, so that when people look at the generated docs for
stable kernels they see the right thing.

It *should* be a trivial backport, anyhow.

Mark.

