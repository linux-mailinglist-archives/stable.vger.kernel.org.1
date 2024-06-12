Return-Path: <stable+bounces-50296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21B7905773
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 17:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3B7B22852
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 15:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C73180A77;
	Wed, 12 Jun 2024 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc6tKd7M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E164017FAB7;
	Wed, 12 Jun 2024 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207561; cv=none; b=sx+Orf5KYm5sEmlPpLZy3Arpjleki+6qIQTbSAjTvWZauDIkxJDbtpVHtNzSzbi5uTlzXfO5cHObMFOpjo7DoBP2VJ81QHjC1VN9TJeD6Lx1tPPDDGNT2vF60i65zls6CYIVvqfIt+OXShMeKbKrar9fENPWQBq0BHfRCvwh0nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207561; c=relaxed/simple;
	bh=/deBkPwJYb65DIJMxq1egvJvkHcQ3PDFiBPLscR5X4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRlNG+VsBaqVmHWyuXxqgZqMjVDFEWEWPe0pvF94XW1aY3t0ykezkLlPgntezy7wvJy+xt/dCqyLCKenk/YPH4B5wlIvSjrxCp6pwKnHKQqAo0QLMDUE5/mK31MXnyZhtPz9l7q9rcIrYPVYubOw+Ks7N0VWnRHPOiX1mPGV7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pc6tKd7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E38AC32786;
	Wed, 12 Jun 2024 15:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207560;
	bh=/deBkPwJYb65DIJMxq1egvJvkHcQ3PDFiBPLscR5X4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pc6tKd7MxW1MHd6RyZ3XP8PFXaNvjELNwVTB9hrWamHvObjoIrLfDStYc3RJA2+na
	 XU17qhrkYaYkUDCDjLuYeXIxKRPN4yyvQNamlB0sQnoF6vFiILi7nqrf/Z1iy0JM5N
	 6nEyhpVDQtwDU5S+8PP3hC/G20cTwqZbvsykWctm1p/QFCMBYoJsNNDzf9nCN8zMCU
	 UUP9bG/cbnLj6+puNR9P3MyeYPomyw9NBcKVYadFIG3UqGjKfSCbFOmGOiZqwMbReR
	 sXE+DR5m1lj+Q9Yea8W5xa48rRJOCIuwibSIDtFWXkiCPDZUhW5037iVuSTdJ2gWaZ
	 47BsewNOQDfqg==
Date: Wed, 12 Jun 2024 16:52:35 +0100
From: Lee Jones <lee@kernel.org>
To: Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Clement Lecigne <clecigne@google.com>,
	Tom Herbert <tom@herbertland.com>
Subject: Re: [PATCH net] net: fix __dst_negative_advice() race
Message-ID: <20240612155235.GA2187093@google.com>
References: <20240528114353.1794151-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240528114353.1794151-1-edumazet@google.com>

On Tue, 28 May 2024, Eric Dumazet wrote:

> __dst_negative_advice() does not enforce proper RCU rules when
> sk->dst_cache must be cleared, leading to possible UAF.
> 
> RCU rules are that we must first clear sk->sk_dst_cache,
> then call dst_release(old_dst).
> 
> Note that sk_dst_reset(sk) is implementing this protocol correctly,
> while __dst_negative_advice() uses the wrong order.
> 
> Given that ip6_negative_advice() has special logic
> against RTF_CACHE, this means each of the three ->negative_advice()
> existing methods must perform the sk_dst_reset() themselves.
> 
> Note the check against NULL dst is centralized in
> __dst_negative_advice(), there is no need to duplicate
> it in various callbacks.
> 
> Many thanks to Clement Lecigne for tracking this issue.
> 
> This old bug became visible after the blamed commit, using UDP sockets.
> 
> Fixes: a87cb3e48ee8 ("net: Facility to report route quality of connected sockets")
> Reported-by: Clement Lecigne <clecigne@google.com>
> Diagnosed-by: Clement Lecigne <clecigne@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Tom Herbert <tom@herbertland.com>
> ---
>  include/net/dst_ops.h  |  2 +-
>  include/net/sock.h     | 13 +++----------
>  net/ipv4/route.c       | 22 ++++++++--------------
>  net/ipv6/route.c       | 29 +++++++++++++++--------------
>  net/xfrm/xfrm_policy.c | 11 +++--------
>  5 files changed, 30 insertions(+), 47 deletions(-)

Could we have this patch in all Stable branches please?

Upstream commit:

  Fixes: 92f1655aa2b2 ("net: fix __dst_negative_advice() race")

-- 
Lee Jones [李琼斯]

