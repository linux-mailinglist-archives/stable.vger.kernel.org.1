Return-Path: <stable+bounces-45139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C11D8C6290
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 10:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6436B21202
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41B74AEDD;
	Wed, 15 May 2024 08:11:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2CB4EB20;
	Wed, 15 May 2024 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715760699; cv=none; b=WDEMffZ8B7TPCmExacgsp/u5gJc4EiZH5BpHTVw7EPB1eCl2jcukd5F2iTyky7RSMAGkJ8uB0o3yEiVohg7Ownoc9bLjWfe49Ag1NrVFy0HBydmKNikelQ+FxXzfabf3dSkwDAlwQ2O67a19tAjarMDKsHk1RK5i6PToB/p00xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715760699; c=relaxed/simple;
	bh=DtvKFCA4qQyRirdQGXF1yoUoa6pALUM1ZE7B/dqBoB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4yPyl4sxwg+NRSNE4yrTZHVSqC/YDGdbd6FdPg5JD1Q1ehksQw3PUQxYoc3Rk1NBRRk/a3G0evt5JgHtAUFlLREl6MbGupo1XAwEbDR37sLMRZE6VICw7p/jyymlibC3PtmGgqSL9kbyjv2LtRWbs1gmz5YL5pB9n4oME/Qbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A73B1007;
	Wed, 15 May 2024 01:12:01 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE5843F7A6;
	Wed, 15 May 2024 01:11:34 -0700 (PDT)
Date: Wed, 15 May 2024 10:11:29 +0200
From: Mark Rutland <mark.rutland@arm.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] locking/atomic: fix trivial typo in comment
Message-ID: <ZkRuMcao7lusrypL@J2N7QTR9R3>
References: <20240514224625.3280818-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514224625.3280818-1-cmllamas@google.com>

Hi Carlos,

On Tue, May 14, 2024 at 10:46:03PM +0000, Carlos Llamas wrote:
> For atomic_sub_and_test() the @i parameter is the value to subtract, not
> add. Fix the kerneldoc comment accordingly.
> 
> Fixes: ad8110706f38 ("locking/atomic: scripts: generate kerneldoc comments")
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  include/linux/atomic/atomic-instrumented.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
> index debd487fe971..12b558c05384 100644
> --- a/include/linux/atomic/atomic-instrumented.h
> +++ b/include/linux/atomic/atomic-instrumented.h
> @@ -1349,7 +1349,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
>  
>  /**
>   * atomic_sub_and_test() - atomic subtract and test if zero with full ordering
> - * @i: int value to add
> + * @i: int value to subtract
>   * @v: pointer to atomic_t

Whoops; sorry about that.

The atomic headers are generated, and this kerneldoc comment is
generated from the template in scripts/atomic/kerneldoc/sub_and_test

You'll need to modify that then run:

  sh scripts/atomic/gen-atomics.sh

... to regenerate all the affected instances of ${atomic}_sub_and_test()

Thanks,
Mark.

