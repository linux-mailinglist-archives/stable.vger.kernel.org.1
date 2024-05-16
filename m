Return-Path: <stable+bounces-45253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E06F8C731D
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 10:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C72282336
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50A7142E75;
	Thu, 16 May 2024 08:46:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2065C37142;
	Thu, 16 May 2024 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849169; cv=none; b=rLYDVpT8djt9/wJYu4qBFP/tASE/n/KH7CHKfX8YnSWfZ0PY0c8KyKaVmJQ+5dpwZ4QWge5Whs32ebEgeyjBOrfCAbHdMHJgFdssSY5D/zkJRQVUsRgkU8Ckhu7k94D0+mBoIKBeFCx08VWcefHj8OofHx237uayJ20WlI148Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849169; c=relaxed/simple;
	bh=YVevjVRuBtKpw75QsPySW5U+EaVbbAyylawt46tOVqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pna0Gl1TMYMdg3UVUjJsxFWiRhO/exPey0CNIFYCuhIx9aAmW/5v9Adz6oSLKqv8Tg5orpzzHLXCQXvYO5qZ7gz7/YnnbFjm4z3J4iTIt7pUTb3Ht+Ll8rR3EQ+XPfkIcEhxFeqC45q5IYhJ29fJoFXftRRXZ84tE/H/pYONS2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B487DA7;
	Thu, 16 May 2024 01:46:30 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C855C3F7A6;
	Thu, 16 May 2024 01:46:03 -0700 (PDT)
Date: Thu, 16 May 2024 10:45:58 +0200
From: Mark Rutland <mark.rutland@arm.com>
To: Carlos Llamas <cmllamas@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, Nhat Pham <nphamcs@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] locking/atomic: scripts: fix ${atomic}_sub_and_test()
 kerneldoc
Message-ID: <ZkXHxhhER-T6MhIX@J2N7QTR9R3>
References: <ZkRuMcao7lusrypL@J2N7QTR9R3>
 <20240515133844.3502360-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515133844.3502360-1-cmllamas@google.com>

On Wed, May 15, 2024 at 01:37:10PM +0000, Carlos Llamas wrote:
> For ${atomic}_sub_and_test() the @i parameter is the value to subtract,
> not add. Fix the typo in the kerneldoc template and generate the headers
> with this update.
> 
> Fixes: ad8110706f38 ("locking/atomic: scripts: generate kerneldoc comments")
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: stable@vger.kernel.org
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
> 
> Notes:
>     v2: fix kerneldoc template instead, as pointed out by Mark

Thanks for this!

Acked-by: Mark Rutland <mark.rutland@arm.com>

Peter, Ingo, are you happy to queue this up in the tip tree?

Thanks,
Mark.

> 
>  include/linux/atomic/atomic-arch-fallback.h | 6 +++---
>  include/linux/atomic/atomic-instrumented.h  | 8 ++++----
>  include/linux/atomic/atomic-long.h          | 4 ++--
>  scripts/atomic/kerneldoc/sub_and_test       | 2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
> index 956bcba5dbf2..2f9d36b72bd8 100644
> --- a/include/linux/atomic/atomic-arch-fallback.h
> +++ b/include/linux/atomic/atomic-arch-fallback.h
> @@ -2242,7 +2242,7 @@ raw_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
>  
>  /**
>   * raw_atomic_sub_and_test() - atomic subtract and test if zero with full ordering
> - * @i: int value to add
> + * @i: int value to subtract
>   * @v: pointer to atomic_t
>   *
>   * Atomically updates @v to (@v - @i) with full ordering.
> @@ -4368,7 +4368,7 @@ raw_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
>  
>  /**
>   * raw_atomic64_sub_and_test() - atomic subtract and test if zero with full ordering
> - * @i: s64 value to add
> + * @i: s64 value to subtract
>   * @v: pointer to atomic64_t
>   *
>   * Atomically updates @v to (@v - @i) with full ordering.
> @@ -4690,4 +4690,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
>  }
>  
>  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> -// 14850c0b0db20c62fdc78ccd1d42b98b88d76331
> +// b565db590afeeff0d7c9485ccbca5bb6e155749f
> diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
> index debd487fe971..9409a6ddf3e0 100644
> --- a/include/linux/atomic/atomic-instrumented.h
> +++ b/include/linux/atomic/atomic-instrumented.h
> @@ -1349,7 +1349,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
>  
>  /**
>   * atomic_sub_and_test() - atomic subtract and test if zero with full ordering
> - * @i: int value to add
> + * @i: int value to subtract
>   * @v: pointer to atomic_t
>   *
>   * Atomically updates @v to (@v - @i) with full ordering.
> @@ -2927,7 +2927,7 @@ atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
>  
>  /**
>   * atomic64_sub_and_test() - atomic subtract and test if zero with full ordering
> - * @i: s64 value to add
> + * @i: s64 value to subtract
>   * @v: pointer to atomic64_t
>   *
>   * Atomically updates @v to (@v - @i) with full ordering.
> @@ -4505,7 +4505,7 @@ atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
>  
>  /**
>   * atomic_long_sub_and_test() - atomic subtract and test if zero with full ordering
> - * @i: long value to add
> + * @i: long value to subtract
>   * @v: pointer to atomic_long_t
>   *
>   * Atomically updates @v to (@v - @i) with full ordering.
> @@ -5050,4 +5050,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  
>  
>  #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
> -// ce5b65e0f1f8a276268b667194581d24bed219d4
> +// 8829b337928e9508259079d32581775ececd415b
> diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic-long.h
> index 3ef844b3ab8a..f86b29d90877 100644
> --- a/include/linux/atomic/atomic-long.h
> +++ b/include/linux/atomic/atomic-long.h
> @@ -1535,7 +1535,7 @@ raw_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
>  
>  /**
>   * raw_atomic_long_sub_and_test() - atomic subtract and test if zero with full ordering
> - * @i: long value to add
> + * @i: long value to subtract
>   * @v: pointer to atomic_long_t
>   *
>   * Atomically updates @v to (@v - @i) with full ordering.
> @@ -1809,4 +1809,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
>  }
>  
>  #endif /* _LINUX_ATOMIC_LONG_H */
> -// 1c4a26fc77f345342953770ebe3c4d08e7ce2f9a
> +// eadf183c3600b8b92b91839dd3be6bcc560c752d
> diff --git a/scripts/atomic/kerneldoc/sub_and_test b/scripts/atomic/kerneldoc/sub_and_test
> index d3760f7749d4..96615e50836b 100644
> --- a/scripts/atomic/kerneldoc/sub_and_test
> +++ b/scripts/atomic/kerneldoc/sub_and_test
> @@ -1,7 +1,7 @@
>  cat <<EOF
>  /**
>   * ${class}${atomicname}() - atomic subtract and test if zero with ${desc_order} ordering
> - * @i: ${int} value to add
> + * @i: ${int} value to subtract
>   * @v: pointer to ${atomic}_t
>   *
>   * Atomically updates @v to (@v - @i) with ${desc_order} ordering.
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
> 

