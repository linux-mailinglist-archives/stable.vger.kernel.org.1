Return-Path: <stable+bounces-45130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CFB8C61BA
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 09:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C8E1C20F42
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 07:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F005343ABC;
	Wed, 15 May 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BjSVjOf4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC9B41C84
	for <stable@vger.kernel.org>; Wed, 15 May 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758344; cv=none; b=B3wzTvbd0Rh/l/q0Hba29qaDcZbD0tFDBLT5wmInlYbBBquAncOAhpKI8Hy0uOZsOorA0mW4/Mcr7zZDlZjiYpnQbY0JrRXW715vH29P2MMy4FooOh2K5N1FH8IuOnDjgWfl37iO+W9Phq92hhOW+SP4lzyuEpdeCyP5n1hRMGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758344; c=relaxed/simple;
	bh=E6L44s9hAThVLlyi49NVNO3Mv8my6TED++kdqgk6vc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QS+YBPNzAfBgYZtuojYP2cLCS/pgAeHmuQ9kIn13VorTJluxR+i/p/mun/A8D3yFwcgTCERdnT9tzO1FSu5IzMZHe/Y45orXZdr3AUgI+uE8e7qTWqSafxKbrQcaIFBPkIg5xxo2Tg8QvpVaHoRFGOPg1WmQf276yK79qbS9SJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BjSVjOf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFDFC116B1;
	Wed, 15 May 2024 07:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715758344;
	bh=E6L44s9hAThVLlyi49NVNO3Mv8my6TED++kdqgk6vc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BjSVjOf4tjBgzOzo/IcLTcj8ke14wpAMH2x6XQyJb2mqRQXZOS4a8Oqcq4g46dohD
	 EyXtp4HfHmfN36w6nRE4o3dLaRyoP9W6WfY2ORgWUbFGhHaGrJ5ypd0ZS2o4RA6dnr
	 z1RKxkk36Eh0K3lN4aeVeESzPSiumgcyU3PbZxlo=
Date: Wed, 15 May 2024 09:32:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Charlemagne Lasse <charlemagnelasse@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/percpu: Use __force to cast from __percpu address
 space
Message-ID: <2024051540-tranquil-stoppable-30ff@gregkh>
References: <20240514083920.3369074-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514083920.3369074-1-ubizjak@gmail.com>

On Tue, May 14, 2024 at 10:39:18AM +0200, Uros Bizjak wrote:
> commit a55c1fdad5f61b4bfe42319694b23671a758cb28 upstream.
> 
> Fix Sparse warning when casting from __percpu address space by using
> __force in the cast. x86 named address spaces are not considered to
> be subspaces of the generic (flat) address space, so explicit casts
> are required to convert pointers between these address spaces and the
> generic address space (the application should cast to uintptr_t and
> apply the segment base offset). The cast to uintptr_t removes
> __percpu address space tag and Sparse reports:
> 
>   warning: cast removes address space '__percpu' of expression
> 
> Use __force to inform Sparse that the cast is intentional.

Why is a fix for sparse required for stable kernels?

> The patch deviates from upstream commit due to the unification of
> arch_raw_cpu_ptr() defines in the commit:
> 
>   4e5b0e8003df ("x86/percpu: Unify arch_raw_cpu_ptr() defines").
> 
> Fixes: 9a462b9eafa6 ("x86/percpu: Use compiler segment prefix qualifier")
> Reported-by: Charlemagne Lasse <charlemagnelasse@gmail.com>
> Closes: https://lore.kernel.org/lkml/CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=aunFieVqZg3mt14A@mail.gmail.com/
> Cc: stable@vger.kernel.org # v6.8
> Link: https://lore.kernel.org/r/20240402175058.52649-1-ubizjak@gmail.com
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  arch/x86/include/asm/percpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

And also, what kernel version(s) is this for?

I don't see this in any released kernels yet either, is that
intentional?

thanks,

greg k-h

