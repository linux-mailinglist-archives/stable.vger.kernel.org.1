Return-Path: <stable+bounces-191976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 734A8C2745F
	for <lists+stable@lfdr.de>; Sat, 01 Nov 2025 01:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F531897A78
	for <lists+stable@lfdr.de>; Sat,  1 Nov 2025 00:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9741E9905;
	Sat,  1 Nov 2025 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfkMZ9sW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809EC1DFE26;
	Sat,  1 Nov 2025 00:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761957493; cv=none; b=Ta/CQRItgdMpk+Z3UD8ttSaEbgCStiOEr/VxAL6U3ZBNNz6EDXmCOoSmPwlGtYj1oBFTK3ZQdnkNrgv6FlpkcVxqTeD7fbCGpvbIJVTDo6xVHyH0FTsh/rtoQuquqY5d+WDrGEVNOxdQLBdCCsID1gnr0wKgAx02eJbreDr6RlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761957493; c=relaxed/simple;
	bh=F2oSnxRHa/4b3IZKclz9XCbBCnTuPZVJ75m1NK+7tPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPBjagDZi4cKVVMYgqZ5Tt1B9Z2lg/UeqVNUTS0Izit2yRvMoxDOxSlfJOE5934bIbfRYa5gRBqiSjvQWH523PQ23GGkKdfg5fI4l+1F9CzWtl0QV3+6GHR35o/W4brgetQ7HVHirIUXg5sfJK77I3uObS5fvbLUpixrSTNfhTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfkMZ9sW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70324C4CEE7;
	Sat,  1 Nov 2025 00:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761957492;
	bh=F2oSnxRHa/4b3IZKclz9XCbBCnTuPZVJ75m1NK+7tPo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sfkMZ9sW5nBaVwwvOM1pkZciGDXyoM/YalIFfGT61jaQNn5QoxvyjD+tAlKC98UqS
	 Pp0PTJrDhPny8IGXrLf5m5DhvOluaK9+FrZA9/WO3J80Ux7fI37INaQTE96Y96T27S
	 MovJnuNpXC7Up03pBcNxphLqO6EKrJP06H/IS4VZg608uB/ufhw52YN5hOdhTgmwmP
	 CRRpUuet29tNXPfAdDWfujIgNJoxdf//RqZzuaF9uHPcsSlkvw7VPTI+OKtU6Fva1g
	 SzfLrA2uaZqxVwFkO6u5nFRAFSZsTjveP9OJWqkgIkRWlqNRtsbAL1Ps2lLJDnlKmY
	 WVo8JCNjOvcNA==
Date: Fri, 31 Oct 2025 17:38:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tim Hostetler <thostet@google.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Kuniyuki Iwashima
 <kuniyu@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>
Subject: Re: [PATCH net] ptp: Return -EINVAL on ptp_clock_register if
 required ops are NULL
Message-ID: <20251031173811.63bfb9e0@kernel.org>
In-Reply-To: <20251030180832.388729-1-thostet@google.com>
References: <20251030180832.388729-1-thostet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 11:08:32 -0700 Tim Hostetler wrote:
> ptp_clock should never be registered unless it stubs one of gettimex64()
> or gettime64() and settime64(). WARN_ON_ONCE and error out if either set
> of function pointers is null.
> 
> Cc: stable@vger.kernel.org
> Fixes: d7d38f5bd7be ("ptp: use the 64 bit get/set time methods for the posix clock.")

This needs to go to net-next without the tags above.
The check can only help with new drivers, old ones _must_ be fixed 
like gve was. Not registering a driver is a regression.

> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Signed-off-by: Tim Hostetler <thostet@google.com>
> ---
>  drivers/ptp/ptp_clock.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index ef020599b771..0bc79076771b 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -325,6 +325,10 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>  	if (info->n_alarm > PTP_MAX_ALARMS)

->n_alarm check is also input validation, you should probably fold it
into your new WARN_ON_ONCE(). Either that or remove the WARN_ON_ONCE()
annotation below. As is the checks are inconsistent.

>  		return ERR_PTR(-EINVAL);
>  
> +	if (WARN_ON_ONCE((!info->gettimex64 && !info->gettime64) ||
> +			 !info->settime64))
> +		return ERR_PTR(-EINVAL);
> +

