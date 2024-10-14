Return-Path: <stable+bounces-85056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBACE99D464
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 18:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975B61F22FBB
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FE81AE877;
	Mon, 14 Oct 2024 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OJP4PwIR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998421AD3E5
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922346; cv=none; b=pv3lzFEx4iorjNjJ9KONe/6NyHHFSvrpU9K3HgJcyGbcWK5G6rVjsGNiF7QA1bmdB5Rik+zuV21wOmrU3eR1BjyrMCAhMDfCRHvM5y3MnbWT6YgxRXygifjpJpcjtsTRkwdprt45XdxQGAyeWvCbVr7sTEhMk9Dr3aI7AnDRJQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922346; c=relaxed/simple;
	bh=5L7kHIOqS7iXofOsc0+HftApKRrPF1feDK8QWvNm9ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+g7maEM1kz67rTP2zx5shCc4wrs12HT7RdysXZr1WNUKP4ynEH0+u842LbFtm8UpImOvPUyDfYNAAwhdDMJ1Y1IjVXG+yH6VyfF+s5lx2r2wUDlK7bGJvktSIbc9UAJ5TBp5TWhLCBp0ZDHaSOu3elEKusRFeBOPAb9ByIjhRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OJP4PwIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511EEC4CEC3;
	Mon, 14 Oct 2024 16:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728922346;
	bh=5L7kHIOqS7iXofOsc0+HftApKRrPF1feDK8QWvNm9ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJP4PwIR/DMqwgvBK2+2UTdM65e1iZV9pjz2p96CnsH2FbiPdrqQNWrBwU4c1L/B+
	 WhUuv1+fLb+hXd5Z3Hhsps5f/1b+DjuCcntwWgcf82en4Mdz6tzI/MRzYNOkTJqecG
	 1AVUHwts8MAAO8JQ1hnddz9/+PCVeXrV1fITtks8=
Date: Mon, 14 Oct 2024 17:55:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: stable@vger.kernel.org, Patrick Roy <roypat@amazon.co.uk>
Subject: Re: [PATCH 5.15.y] secretmem: disable memfd_secret() if arch cannot
 set direct map
Message-ID: <2024101410-jiffy-handsaw-43e3@gregkh>
References: <2024101412-prowling-snowflake-9fe0@gregkh>
 <20241014152103.1328260-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014152103.1328260-1-rppt@kernel.org>

On Mon, Oct 14, 2024 at 06:21:03PM +0300, Mike Rapoport wrote:
> From: Patrick Roy <roypat@amazon.co.uk>
> 
> Return -ENOSYS from memfd_secret() syscall if !can_set_direct_map().
> This is the case for example on some arm64 configurations, where marking
> 4k PTEs in the direct map not present can only be done if the direct map
> is set up at 4k granularity in the first place (as ARM's
> break-before-make semantics do not easily allow breaking apart
> large/gigantic pages).
> 
> More precisely, on arm64 systems with !can_set_direct_map(),
> set_direct_map_invalid_noflush() is a no-op, however it returns success
> (0) instead of an error. This means that memfd_secret will seemingly
> "work" (e.g. syscall succeeds, you can mmap the fd and fault in pages),
> but it does not actually achieve its goal of removing its memory from
> the direct map.
> 
> Note that with this patch, memfd_secret() will start erroring on systems
> where can_set_direct_map() returns false (arm64 with
> CONFIG_RODATA_FULL_DEFAULT_ENABLED=n, CONFIG_DEBUG_PAGEALLOC=n and
> CONFIG_KFENCE=n), but that still seems better than the current silent
> failure. Since CONFIG_RODATA_FULL_DEFAULT_ENABLED defaults to 'y', most
> arm64 systems actually have a working memfd_secret() and aren't be
> affected.
> 
> >>From going through the iterations of the original memfd_secret patch
> series, it seems that disabling the syscall in these scenarios was the
> intended behavior [1] (preferred over having
> set_direct_map_invalid_noflush return an error as that would result in
> SIGBUSes at page-fault time), however the check for it got dropped
> between v16 [2] and v17 [3], when secretmem moved away from CMA
> allocations.
> 
> [1]: https://lore.kernel.org/lkml/20201124164930.GK8537@kernel.org/
> [2]: https://lore.kernel.org/lkml/20210121122723.3446-11-rppt@kernel.org/#t
> [3]: https://lore.kernel.org/lkml/20201125092208.12544-10-rppt@kernel.org/
> 
> Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  mm/secretmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

What is the git id of this change in Linus's tree?

