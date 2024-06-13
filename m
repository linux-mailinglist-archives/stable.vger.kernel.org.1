Return-Path: <stable+bounces-50468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C425F9066E9
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8A01F238FC
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E999513DDA5;
	Thu, 13 Jun 2024 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H75EYSQe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72D213D617
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267526; cv=none; b=quwiYPektoFX+VC3iVslMQ9MzNd2OHGBRrihdrg1IU8s/BNS7ySIvKVQB+eLSyq5Vh/8iPB/Ul4yS6YLVmtuvtcMPwKxHmyUN1DY2umIu+9nKtWHz4l2Wf5xiHOaBl5YIfwzicY51J5IBAq0PhIOuRWoc+sHxa7O25/z/P3zeQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267526; c=relaxed/simple;
	bh=izFK/WyjYQfQt2s0v89scmh19Y+ruahsu+frAIMdL8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+tm/kufved3UQj4qEGs7OqInbYmFEC4wCPEW9k3hd3EdiHnS/PuCestW2Hv9dBEOFbnDG0IKKOk2YHCMcgKQm2vo99GLRVYIJfbGDXr7tdJJC+m6FUYwo6kdepP2Mo/m46GO+1s7HYdrwVRJRkPnOvDziQrU6HuRRlH37vYZiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H75EYSQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9511FC2BBFC;
	Thu, 13 Jun 2024 08:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718267526;
	bh=izFK/WyjYQfQt2s0v89scmh19Y+ruahsu+frAIMdL8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H75EYSQejCdijHc8D4AbBYuM77O7bjxofhJ4gmfCmRB8hbcjTigzKkuh7okvnInUu
	 Ivz2FJmtA5GVhygpgcLTFB4em7tuZsRphdwPLKFxbFs5bFNkDpulzwqfEWi9apw2nj
	 jMQcYBQpzAGToysc/SzpEgD0FVlhvyCY854rPt4A=
Date: Thu, 13 Jun 2024 10:32:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Clement Lecigne <clecigne@google.com>,
	Tom Herbert <tom@herbertland.com>, David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2 4.19.y 1/1] net: fix __dst_negative_advice() race
Message-ID: <2024061354-endanger-earthworm-592e@gregkh>
References: <20240613081254.2492021-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613081254.2492021-1-lee@kernel.org>

On Thu, Jun 13, 2024 at 09:12:44AM +0100, Lee Jones wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
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
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Link: https://lore.kernel.org/r/20240528114353.1794151-1-edumazet@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> (cherry picked from commit 92f1655aa2b2294d0b49925f3b875a634bd3b59e)
> [Lee: Stable backport]
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  include/net/dst_ops.h  |  2 +-
>  include/net/sock.h     | 13 +++----------
>  net/ipv4/route.c       | 22 ++++++++--------------
>  net/ipv6/route.c       | 29 +++++++++++++++--------------
>  net/xfrm/xfrm_policy.c | 11 +++--------
>  5 files changed, 30 insertions(+), 47 deletions(-)

All now queued up, thanks!

greg k-h

