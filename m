Return-Path: <stable+bounces-112150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 111ADA273A4
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 14:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378C1188476A
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 13:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2C7217F3D;
	Tue,  4 Feb 2025 13:42:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA171DFEF;
	Tue,  4 Feb 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676579; cv=none; b=EIrb1nIBuqx+Ai1F0bcYXnCpXjiZG8NTftYs/+WIITiLTHhpu90KMCn5iCnneikSuOlm2jFR4LA804QgaHgua6Tcv5QU2vwgWO+TMEjRJDPzM8wiO+zmMO0zVVznZLMZNpGUcuSvI7EY7EPltKca9C5NSw/8EPlF7uGUJuU12GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676579; c=relaxed/simple;
	bh=+SDsNizAczeZ6vHA1lJOUG7oVI1dH3uCBqrk+kJYvsE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Y4py6LX+dKLoYBQhaR/nd6HpZsknj/0Tgm+hhas8wdOr5UpQ5I4G56N9GOLHjBpYzRo+vpEKour0EKm3ri1PiKMWLfieGxTm3fa7Zss9cm7QO7C9H6yG7NT7HrfGrp2QbccvjDPAniD1rJbzTpZ/G8wtfnVz0bagvG+vh7wonw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0345F92009C; Tue,  4 Feb 2025 14:42:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id F154892009B;
	Tue,  4 Feb 2025 13:42:48 +0000 (GMT)
Date: Tue, 4 Feb 2025 13:42:48 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Ivan Kokshaysky <ink@unseen.parts>
cc: Richard Henderson <richard.henderson@linaro.org>, 
    Matt Turner <mattst88@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
    Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
    "Paul E. McKenney" <paulmck@kernel.org>, 
    Magnus Lindholm <linmag7@gmail.com>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] alpha/uapi: do not expose kernel-only stack frame
 structures
In-Reply-To: <Z6D5UyV9Z0demt40@minute>
Message-ID: <alpine.DEB.2.21.2502041233110.41663@angie.orcam.me.uk>
References: <20250131104129.11052-1-ink@unseen.parts> <20250131104129.11052-2-ink@unseen.parts> <alpine.DEB.2.21.2502020051280.41663@angie.orcam.me.uk> <Z6D5UyV9Z0demt40@minute>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Feb 2025, Ivan Kokshaysky wrote:

> >  What do you think about providing arch/alpha/include/asm/bpf_perf_event.h 
> > instead with either a dummy definition of `bpf_user_pt_regs_t', or perhaps 
> > one typedef'd to `struct sigcontext' (as it seems to provide all that's 
> > needed), and then reverting to v1 of arch/alpha/include/uapi/asm/ptrace.h 
> > (and then just copying the contents of arch/alpha/include/asm/ftrace.h 
> > over rather than leaving all the useless CPP stuff in) so that we don't 
> > have useless `struct pt_regs' exported at all?
> 
> Probably that's the right thing to do. However, it implies adding
> 
> #elif defined(__alpha__)
> #include "../../arch/alpha/include/uapi/asm/bpf_perf_event.h"
> 
> in tools/include/uapi/asm/bpf_perf_event.h. I'm afraid that will
> result in too many loosely related changes for this patch series.

 This seems to be the way, but...

> I'm starting to think that the best way for the time being is to keep
> uapi/asm/ptrace.h and apply the fix there (i.e. revert to v0 patch
> posted on linux-alpha). And mention the pt_regs vs uapi issue in the
> commit message, of course, to deal with it later. Your opinion?

 ... I agree.  I find this a pragmatic path of least resistance approach, 
which will keep backports to the minimum and prevent Greg from getting 
rightfully grumpy about it.  We need to get things straight here and BPF 
is the least of a problem.  Let's go for this minimal variant then.

 This will also buy us time to think what the structure format will be 
right for `bpf_user_pt_regs_t' and whether `struct sigcontext' is indeed 
the best fit.  Perhaps we'll want to define an entirely new structure and 
use it also for regset support, which I suppose would be good having, as 
it simplifies handling in debug software.  I'm not sure offhand though, 
which I suppose is a good sign to defer this stuff to a later change.

 NB GCC verification has completed successfully with no regressions (but 
no progressions either; there've been a couple of changes both ways with 
intermittent failures, mostly in Fortran and Go, but none related to this 
patch series), and glibc verification is still running; by the look of the 
progress current ETC is sadly Fri-Sat only.

 The previous glibc run completed in ~25h, but this time the testsuite 
includes recently added 576 extra formatted output `printf' tests, which I 
admit to have committed myself, which owing to their duration I proposed 
to be a part of the extended set, but the community insisted that they be 
a part of the regular set, to widen coverage.  This subset has already 
been running for ~30h and has made it through ~25%.  So there you go.

 For reference the 576 extra test cases complete in ~30m on POWER9 (in a 
serial run; a parallel run is obviously much faster on this 64-way SMP 
system, but infeasible with the UP Alpha over the network, so I need to 
compare apples to apples), which just shows how irrelevant the performance 
of these legacy systems nowadays is and it's just the matter of keeping 
them alive with current software that has been my objective all the time.

  Maciej

