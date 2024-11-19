Return-Path: <stable+bounces-93995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB59E9D26B7
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C2CB274F8
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3281CC170;
	Tue, 19 Nov 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jxFCzFHU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D77B12B93
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732022170; cv=none; b=D11F9SWlOvudSlPT2C+XjMbdshvcX2rtwvGrWFvXm400Ld9REf4A3sajpjE62JhxZgED1NsZmZa49sLam0k04vmCJ2bLiI3fjAbbyi0j6Z5nDF2r8k8KrkhLcqiChig9ITC4xzStyFsAOp0DwFWVp0Grex0giqy4jB8rxMaS5Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732022170; c=relaxed/simple;
	bh=7UFyApPR+NWecMdWD4+jrX545LQNnQFVDvZ6iVtvZqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJhwp+oybL5Jo12Xxm+iyNGbkPI78PBKVp8VxkKinQRGTWqvk+TinOcodmeqJwxLlwqQ9FVHucrfhR4be0uAutWTJaZChHlCdJ8JhMCcilJ5zJ9Ovr2NOO8LILXG6JbD/NAwIM3rq1i4MagBnt+PTwxE4XoG5f4CAAq+2iYow94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jxFCzFHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F0AC4CED0;
	Tue, 19 Nov 2024 13:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732022169;
	bh=7UFyApPR+NWecMdWD4+jrX545LQNnQFVDvZ6iVtvZqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jxFCzFHUHfZt3J7Q9KWYFyJE0bQ+Boiz+TmesM0tTxIr6ESe1LiCKNQEExk43hhCx
	 No2oeDleKBdiY8XtX+2uSk3lsif/AVUKEaS98oPZrIFZUdTxiP8jf94OYpNxNxskJT
	 2r9CkDHFGkACVKa0Q1r9/a+TAOaTc7RlGeBG6kpw=
Date: Tue, 19 Nov 2024 14:15:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bin Lan <bin.lan.cn@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1] parisc: fix a possible DMA corruption
Message-ID: <2024111934-divinity-twiddle-4f33@gregkh>
References: <20241119054933.2367013-1-bin.lan.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119054933.2367013-1-bin.lan.cn@windriver.com>

On Tue, Nov 19, 2024 at 01:49:33PM +0800, Bin Lan wrote:
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> ARCH_DMA_MINALIGN was defined as 16 - this is too small - it may be
> possible that two unrelated 16-byte allocations share a cache line. If
> one of these allocations is written using DMA and the other is written
> using cached write, the value that was written with DMA may be
> corrupted.
> 
> This commit changes ARCH_DMA_MINALIGN to be 128 on PA20 and 32 on PA1.1 -
> that's the largest possible cache line size.
> 
> As different parisc microarchitectures have different cache line size, we
> define arch_slab_minalign(), cache_line_size() and
> dma_get_cache_alignment() so that the kernel may tune slab cache
> parameters dynamically, based on the detected cache line size.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
> ---
>  arch/parisc/Kconfig             |  1 +
>  arch/parisc/include/asm/cache.h | 11 ++++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)

You seem to have forgotten to add the git id :(

