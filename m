Return-Path: <stable+bounces-161886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D664B04830
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 22:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948C61A680E8
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 20:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476119CD01;
	Mon, 14 Jul 2025 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eB/iQEun"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B474384A35;
	Mon, 14 Jul 2025 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752523220; cv=none; b=iA9zRZwYqNJhjJZY8vwCnldEW7nIlPqIvM6kVkEioxfYh2m3xBKSJTdo2uSsZ/bjBlLX934o9gNpZUvL1xi7/NTCtyRe8ZvlpYgXuepgeSxeGjpOn8KwLg5gHYos/kXHcU2AVn4RQhljwfvZaJd4OmE+ErQxznSsH3+l6H7tnF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752523220; c=relaxed/simple;
	bh=1EuLxQcoalPrJoC0+kKDMPul2uferMAfFFNpnRudPHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shh+bkNB8L/kYVJQCJpse9OJXH0n3jUzPbpQxYLda6oGBu7fgTQbB4KX4LIhvLcE4mWcmGTMFpQIocThsu1MnX5ap1fmP/EmhzPh4pgXZQCS/h9pQ/5f4lYbsFJoDgQpd8k8nJKzCbHwyP/OkR+y+kYHYlnkiBSjQP7NWmN7r9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eB/iQEun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CA4C4CEED;
	Mon, 14 Jul 2025 20:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752523220;
	bh=1EuLxQcoalPrJoC0+kKDMPul2uferMAfFFNpnRudPHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eB/iQEuncCntN2Vi1sK+eMQKX9USnt+MYbYVTV6W4ubG7df0HECYUmwXf3h8uBl5h
	 3+D0Y74sD7ZQ2OxqvBKcaxe7Z0HfGN8MqPCWuaW13bAKgcxmk3dpu7Td/rlWHcK56A
	 Slu9qaMm7yTG2a4cSmwilcoj/4p9rsPpHHWzKbD+5KGISkdcTnThyqLWGFjnj3NagH
	 58FRM29G/yPrnVIZyQTPprUDXv4arfvUol06PIN9H6/SWe40aYQtYXUuu5S23+jEVx
	 B1hI17jKL8pdDt1EXTD34pmP2iSCizqW0fQU4eZ8z98W7wFpHqxXcNDrtP6lmWV/i4
	 dFwgMvJTANRoA==
Date: Mon, 14 Jul 2025 13:00:16 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Rob Landley <rob@landley.net>,
	Martin Wetterwald <martin@wetterwald.eu>
Subject: Re: [PATCH] ARM: Fix allowing linker DCE with binutils < 2.36
Message-ID: <20250714200016.GA3444087@ax162>
References: <20250707-arm-fix-dce-older-binutils-v1-1-3b5e59dc3b26@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-arm-fix-dce-older-binutils-v1-1-3b5e59dc3b26@kernel.org>

On Mon, Jul 07, 2025 at 12:39:26PM -0700, Nathan Chancellor wrote:
> Commit e7607f7d6d81 ("ARM: 9443/1: Require linker to support KEEP within
> OVERLAY for DCE") accidentally broke the binutils version restriction
> that was added in commit 0d437918fb64 ("ARM: 9414/1: Fix build issue
> with LD_DEAD_CODE_DATA_ELIMINATION"), reintroducing the segmentation
> fault addressed by that workaround.
> 
> Restore the binutils version dependency by using
> CONFIG_LD_CAN_USE_KEEP_IN_OVERLAY as an additional condition to ensure
> that CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION is only enabled with
> binutils >= 2.36 and ld.lld >= 21.0.0.
> 
> Cc: stable@vger.kernel.org
> Fixes: e7607f7d6d81 ("ARM: 9443/1: Require linker to support KEEP within OVERLAY for DCE")
> Reported-by: Rob Landley <rob@landley.net>
> Closes: https://lore.kernel.org/6739da7d-e555-407a-b5cb-e5681da71056@landley.net/
> Tested-by: Rob Landley <rob@landley.net>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3072731fe09c..962451e54fdd 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -121,7 +121,7 @@ config ARM
>  	select HAVE_KERNEL_XZ
>  	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
>  	select HAVE_KRETPROBES if HAVE_KPROBES
> -	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_CAN_USE_KEEP_IN_OVERLAY)
> +	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if (LD_VERSION >= 23600 || LD_IS_LLD) && LD_CAN_USE_KEEP_IN_OVERLAY
>  	select HAVE_MOD_ARCH_SPECIFIC
>  	select HAVE_NMI
>  	select HAVE_OPTPROBES if !THUMB2_KERNEL
> 

I have dropped this in the patch tracker with an updated set of tags
since Martin reported the same issue after I sent this to the list.

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9450/1

Cheers,
Nathan

