Return-Path: <stable+bounces-45255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAF78C733F
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 10:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3371F232DF
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 08:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9A3143731;
	Thu, 16 May 2024 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GD0s952g"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D638142E9D;
	Thu, 16 May 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849478; cv=none; b=eGS0Up21lyVvv6m78e3YIz3Kv7s1gVbEIsMAh1e5+YUuHww1eH9O3rxN6bJzaxlFgoQz6E/1dcs+UYuKaDig4GhGLpL92INGmstvCwwPtLiPJFlr57z8Qjjd5Wvzv8cqdofLN+Zo3pB2T+uEF+YYwVoAi9styqIPePN0BOrKKhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849478; c=relaxed/simple;
	bh=l1HSI/cEg1zk4pGAEgwOlSvrH8Xb5jx7Ymowp4v8X0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhA4BZMC6DtUoWJZc3XVLYQBrmHRP69KxbRNNjR1aTrMEqhvwe+uwB2h1X1LdEn3KGlVcuBx0UJA7h+o44CfwmE4w3lGWbIoh3L6Co/4QhUJ4FawRBIr1vA62uR9ynbfrgn/nnUU1X/UubeluUNU2UuSSHzNUTv2Xy1gCstp76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GD0s952g; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qn1ebukywtbJVzdHqjkWWRPx6suZJNVTQGM79yBPLw4=; b=GD0s952guXP8F9CsAEKYSjANzE
	yRSvQScIDP976RNyxy0nPjBIAyc3ix3Q+BI85QQa0VSSs8DRTppTd8k6L7ZTiDp5+Y4R/1F2jNKdw
	A+FzUgMHt+TCXPvp0yd8Sf4qcdNBZb0i0Wi/YFgyRtzewRuj9MVhQpUOWAAF3DHV6+HRISws8wpNr
	54uZ6LEsdWEQYft0rbIrGkBiUPEO65kjSmpR2idItDrdf3ukS8DanzOYPNzORuI4Iw/FBJIAWrIwI
	g4LYNkeARWhHgI9OuI5tuM8Xp/tKJDjSlR6f7ij3ii6SpuMgf4hkxoIUYUdlPZg17S/pROOTfHBRm
	ErzuZLag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7WpP-00000005NvS-0r7b;
	Thu, 16 May 2024 08:51:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D1A9630144C; Thu, 16 May 2024 10:51:06 +0200 (CEST)
Date: Thu, 16 May 2024 10:51:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: mingo@redhat.com, frederic@kernel.org, mark.rutland@arm.com,
	acme@kernel.org, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] perf/core: Fix missing wakeup when waiting for
 context reference
Message-ID: <20240516085106.GG22557@noisy.programming.kicks-ass.net>
References: <20240513103948.33570-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513103948.33570-1-haifeng.xu@shopee.com>

On Mon, May 13, 2024 at 10:39:48AM +0000, Haifeng Xu wrote:
> In our production environment, we found many hung tasks which are
> blocked for more than 18 hours. Their call traces are like this:
> 
> [346278.191038] __schedule+0x2d8/0x890
> [346278.191046] schedule+0x4e/0xb0
> [346278.191049] perf_event_free_task+0x220/0x270
> [346278.191056] ? init_wait_var_entry+0x50/0x50
> [346278.191060] copy_process+0x663/0x18d0
> [346278.191068] kernel_clone+0x9d/0x3d0
> [346278.191072] __do_sys_clone+0x5d/0x80
> [346278.191076] __x64_sys_clone+0x25/0x30
> [346278.191079] do_syscall_64+0x5c/0xc0
> [346278.191083] ? syscall_exit_to_user_mode+0x27/0x50
> [346278.191086] ? do_syscall_64+0x69/0xc0
> [346278.191088] ? irqentry_exit_to_user_mode+0x9/0x20
> [346278.191092] ? irqentry_exit+0x19/0x30
> [346278.191095] ? exc_page_fault+0x89/0x160
> [346278.191097] ? asm_exc_page_fault+0x8/0x30
> [346278.191102] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> The task was waiting for the refcount become to 1, but from the vmcore,
> we found the refcount has already been 1. It seems that the task didn't
> get woken up by perf_event_release_kernel() and got stuck forever. The
> below scenario may cause the problem.
> 
> Thread A					Thread B
> ...						...
> perf_event_free_task				perf_event_release_kernel
> 						   ...
> 						   acquire event->child_mutex
> 						   ...
> 						   get_ctx
>    ...						   release event->child_mutex
>    acquire ctx->mutex
>    ...
>    perf_free_event (acquire/release event->child_mutex)
>    ...
>    release ctx->mutex
>    wait_var_event
> 						   acquire ctx->mutex
> 						   acquire event->child_mutex
> 						   # move existing events to free_list
> 						   release event->child_mutex
> 						   release ctx->mutex
> 						   put_ctx
> ...						...
> 
> In this case, all events of the ctx have been freed, so we couldn't
> find the ctx in free_list and Thread A will miss the wakeup. It's thus
> necessary to add a wakeup after dropping the reference.
> 
> Fixes: 1cf8dfe8a661 ("perf/core: Fix race between close() and fork()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks!, I'll hang onto this until after the merge window and then stick
it in tip/perf/urgent or somesuch.

