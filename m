Return-Path: <stable+bounces-81562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3715199458F
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424F428680D
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6EC18B474;
	Tue,  8 Oct 2024 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nmY462s9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B441922C7;
	Tue,  8 Oct 2024 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383791; cv=none; b=CBYQOgpIkd/2BI5CS28lNDBzOuh760NH9UYe3M8VSXrBaHpm8kMAavkwh1At7kIkeC22i10W8WZj1RNPIFd6DhGoFUYPBkcM6ieeQcHkKd4aiFVu4ExwKwGGjVvm1k0B3ZgsgdKl3njWOsvJAdKw9uADrgEWfsbdxB4LezWwyAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383791; c=relaxed/simple;
	bh=CS/nBis3DevjdHne0ekuu1Qk7sJb5okYGrMvd2g5LOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qd3KS0qBGzVbil0U7v9pQFwMTJfHXsnzJmZn3NgDENgo4468SvNlqCV3LghiBm9QKkSeQ/h+Yns9tGgCHPwuZyAY+dnSgkCnl8p2H3l/m+kukMxsTkGBWH80PKsnCQUsoO+B84uAJ0D/CmBnf7sM3j0P0AbTTY/VTJXn9jAm4R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nmY462s9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3E0C4CEC7;
	Tue,  8 Oct 2024 10:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728383791;
	bh=CS/nBis3DevjdHne0ekuu1Qk7sJb5okYGrMvd2g5LOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nmY462s9vX4s3fKO9Gl5njRmQOrTqeze8XRXlWypo2IXI2qyI9VKHUGtu4G4tZCau
	 PQhVMu8Pc0VQtDRXXHh3IDNXiH68Rt1XI9hEOm49kKhzGYUOCo0dxaRkpX3iPxZHDZ
	 /WYDOo6IVaeVtxebNttjVPSMv+YsOrXI2/q5Ot7k=
Date: Tue, 8 Oct 2024 12:36:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sherry Yang <sherry.yang@oracle.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, kuba@kernel.org,
	roopa@nvidia.com, nikolay@nvidia.com, davem@davemloft.net,
	bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH 5.15.y 1/2] net: add pskb_may_pull_reason() helper
Message-ID: <2024100856-skittle-hazy-9569@gregkh>
References: <20241004170328.10819-1-sherry.yang@oracle.com>
 <20241004170328.10819-2-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004170328.10819-2-sherry.yang@oracle.com>

On Fri, Oct 04, 2024 at 10:03:27AM -0700, Sherry Yang wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> [ Upstream commit 1fb2d41501f38192d8a19da585cd441cf8845697 ]
> 
> pskb_may_pull() can fail for two different reasons.
> 
> Provide pskb_may_pull_reason() helper to distinguish
> between these reasons.
> 
> It returns:
> 
> SKB_NOT_DROPPED_YET           : Success
> SKB_DROP_REASON_PKT_TOO_SMALL : packet too small
> SKB_DROP_REASON_NOMEM         : skb->head could not be resized
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Stable-dep-of: 8bd67ebb50c0 ("net: bridge: xmit: make sure we have at least eth header len bytes")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> [Sherry: bp to 5.15.y. Minor conflicts due to missing commit
> d427c8999b07 ("net-next: skbuff: refactor pskb_pull") which is not
> necessary in 5.15.y. Ignore context change.
> Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
> ---
>  include/linux/skbuff.h | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index b230c422dc3b..f92e8fe4f5eb 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -2465,13 +2465,24 @@ static inline void *pskb_pull(struct sk_buff *skb, unsigned int len)
>  	return unlikely(len > skb->len) ? NULL : __pskb_pull(skb, len);
>  }
>  
> -static inline bool pskb_may_pull(struct sk_buff *skb, unsigned int len)
> +static inline enum skb_drop_reason
> +pskb_may_pull_reason(struct sk_buff *skb, unsigned int len)
>  {
>  	if (likely(len <= skb_headlen(skb)))
> -		return true;
> +		return SKB_NOT_DROPPED_YET;
> +
>  	if (unlikely(len > skb->len))
> -		return false;
> -	return __pskb_pull_tail(skb, len - skb_headlen(skb)) != NULL;
> +		return SKB_DROP_REASON_PKT_TOO_SMALL;
> +
> +	if (unlikely(!__pskb_pull_tail(skb, len - skb_headlen(skb))))
> +		return SKB_DROP_REASON_NOMEM;
> +
> +	return SKB_NOT_DROPPED_YET;
> +}
> +
> +static inline bool pskb_may_pull(struct sk_buff *skb, unsigned int len)
> +{
> +	return pskb_may_pull_reason(skb, len) == SKB_NOT_DROPPED_YET;
>  }
>  
>  void skb_condense(struct sk_buff *skb);
> -- 
> 2.46.0
> 
> 

Any specific reason why you didn't test build this patch?

It breaks the build into thousands of tiny pieces.

greg k-h

