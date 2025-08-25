Return-Path: <stable+bounces-172787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C0AB3377E
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 09:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B682169D09
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 07:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363BF28725B;
	Mon, 25 Aug 2025 07:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CrI8d8jx"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F40E189F43;
	Mon, 25 Aug 2025 07:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105977; cv=none; b=RM2EAcnhWGkk7ctjxEZLIZXuy0ciT/cC5UGEUzwzP1Ejioo/4rSKZBiH2ulvdro+oMH3ZuwEck0G7qsqqERKwAbnGdgDThtRzuJfYc7pKm6awRWkJJr7kIPGcASSbK8eSFyUvZSJOHfrE/yLLI1BbA8O+nq4oUc2uLQT02QipPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105977; c=relaxed/simple;
	bh=IVaAyasT9vwk8UxDmhDHOD/accMOWwV9PXxR0d4p3pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XupBVUOE9agSPQa5BhOuNFjn4v/Tlr4Vy32Z7Iv+k9BlwQTREl2Nkt4HHUqb5oQeVWOSxqFt4EBk7A9r2HzwzSfAUOZVvqjpfTq0Dggdyt/o+5/Nqcyiib/a3qJKGPCjNq/7ArulQUzFvoXg28ksj2pFjlW6wX5xpTmkZ8cSoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CrI8d8jx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=87dEfwuDs8a3Bmpg1D5wqvl9OXwHplw3ah1EhMVZftY=; b=CrI8d8jx6gFWsRryHPxs/WVwYu
	/38YoClmiBCt1ji87ST0XIXBdbAFYmtpshiSC1E1NJkxrl49R6mWWhG+MGnxwSHDK8XY9noAlKSlU
	ENqM4P1eND74WKvWP49jMUlf013DdeB/G27dgV30d5Pjl9rpatRlloaOWUaCj3oCHDOactnFj0Aw8
	InnahP0FZf4aPEHHrWolvM6ptLh1dloiqvODJK95P4byXbslbdwfLBlDs99zs7yBW/EJdKRJ8kMBR
	iNnrAgTCt6VDKlZpjg2w0k6BOrTEm7Ake/JHq/KYzeS8cg5djZ+XEvLgfsr3mQ1QnSls4s6UbbTa1
	iQzdY8fQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqRNo-00000001lqX-2zzD;
	Mon, 25 Aug 2025 07:12:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 534F33002ED; Mon, 25 Aug 2025 09:12:47 +0200 (CEST)
Date: Mon, 25 Aug 2025 09:12:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Eero Tamminen <oak@helsinkinet.fi>, Will Deacon <will@kernel.org>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Message-ID: <20250825071247.GO3245006@noisy.programming.kicks-ass.net>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>

On Mon, Aug 25, 2025 at 12:03:05PM +1000, Finn Thain wrote:
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

I don't see how this patch it at all relevant. Let along how its fixed
by the below.

> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
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

And your architecture doesn't trap on unaligned atomic access ?!!?!



