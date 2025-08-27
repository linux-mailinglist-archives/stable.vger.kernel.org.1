Return-Path: <stable+bounces-176451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D931B3784A
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 04:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F5C1BA0904
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 02:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802842E22A5;
	Wed, 27 Aug 2025 02:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+kmSNd0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCCA25BF13;
	Wed, 27 Aug 2025 02:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756262720; cv=none; b=jDcKdymRc7D6yVF1tLRgIlkCRrx4V5fCoo97PCUp5EDmTy/Idv4SOzUaqImiggba7HUwba/I5tx7FY6ufthpFQoNLKx3Dy/pf7WAe9i54PxHJxNEOtPH0gDy3ZjeWulPf0hb19GgZ+NPV8tQ3q66y7imLJFy9MLZybowdJ0YxyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756262720; c=relaxed/simple;
	bh=WYZjGVhbi9PZZbObUWGRV+CpiiLKNvQiFfF1DJ0PfbY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gsj0YPx1a2FBXvYaeohAhjPczpYegpVm7fmh6C3jnBdrpvDGMCqte0vkO01Ghj8apEryI5feGNBqhtloBTMXc+0OI+FeVdzJsxRwXVfjP7dwcYsuOYQ/m2mFezkpSq7KTJ43Hm22n5AteNj6iTtqa0kvW4BMNz88kCOSwpt32Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+kmSNd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A6AC4CEF1;
	Wed, 27 Aug 2025 02:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756262719;
	bh=WYZjGVhbi9PZZbObUWGRV+CpiiLKNvQiFfF1DJ0PfbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F+kmSNd0hNr6jyE/chTdjU47XA4mRJCURDLzABpP6xhbx+WXqS2wQQjqmDRUZWUt7
	 6BvTuZC7ewzl7kUp2GtsBv9TrZUP24nb2FWLWRFQGdtzqRaHSaWPh1o6F7nSZRjw23
	 YqjhV73izlUONt8YCkiO7mT4b1HEvCzUPXFEJhK70MZXZtGLoPcnpdSP08eWFesebx
	 JuEfuheaKTDfFmAhXE7rfjIoZq+KIOhyOf3P1S5NL1ddkQgsDZ0/9de5cPxZYrhAM6
	 /RMytj8ppv/cdoGDKQt/rAuiLgSgu0Dr24Vlwxn0db6sBLo7Ai1Sfgd5rG0o6MTuhC
	 LbL7pX0BgE9aA==
Date: Wed, 27 Aug 2025 11:45:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Lance Yang"
 <lance.yang@linux.dev>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Eero Tamminen"
 <oak@helsinkinet.fi>, "Peter Zijlstra" <peterz@infradead.org>,
 "Will Deacon" <will@kernel.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Message-Id: <20250827114516.efd544acda4e3c0492d893e7@kernel.org>
In-Reply-To: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 12:03:05 +1000
Finn Thain <fthain@linux-m68k.org> wrote:

> Some recent commits incorrectly assumed the natural alignment of locks.
> That assumption fails on Linux/m68k (and, interestingly, would have failed
> on Linux/cris also). This leads to spurious warnings from the hang check
> code. Fix this bug by adding the necessary 'aligned' attribute.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Eero Tamminen <oak@helsinkinet.fi>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: stable@vger.kernel.org
> Reported-by: Eero Tamminen <oak@helsinkinet.fi>
> Closes: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com/
> Fixes: e711faaafbe5 ("hung_task: replace blocker_mutex with encoded blocker")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

This seems good anyway because unaligned atomic memory access
sounds insane. So looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Anyway, Lance's patch[1] is still needed. We'd better gracefully
ignore if the blocker is not aligned, because hung_task blocker
detection is an optional for debugging and not necessary for
the kernel operation.

[1] https://lore.kernel.org/all/20250823050036.7748-1-lance.yang@linux.dev/ 


Thank you,

> ---
> I tested this on m68k using GCC and it fixed the problem for me. AFAIK,
> the other architectures naturally align ints already so I'm expecting to
> see no effect there.
> ---
>  include/linux/types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 6dfdb8e8e4c3..cd5b2b0f4b02 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -179,7 +179,7 @@ typedef phys_addr_t resource_size_t;
>  typedef unsigned long irq_hw_number_t;
>  
>  typedef struct {
> -	int counter;
> +	int counter __aligned(sizeof(int));
>  } atomic_t;
>  
>  #define ATOMIC_INIT(i) { (i) }
> -- 
> 2.49.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

