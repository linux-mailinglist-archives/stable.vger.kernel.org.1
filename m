Return-Path: <stable+bounces-71454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E88996395D
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 06:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321EB285651
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 04:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB73C12E1D9;
	Thu, 29 Aug 2024 04:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKmxUnS6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CB123BF;
	Thu, 29 Aug 2024 04:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724905748; cv=none; b=FJvuG+XBa2KdNL2n1qy8wlH1D/wBtQ0Io+8KZ71Yma90PUYYqi12v2axvlhqAr7IwfUOtiu7BvuwXVoQRO3q41/KsDAz1WHEBCQsB35loQIDYBb9LpUDf4sm3jBhsXZL+Vu7+GOWm4qF0Makl0Geoiua2CfEs4EeR8WS+I+Y3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724905748; c=relaxed/simple;
	bh=YqFdGToztJ7s2NHpwfd42YqwaXqzfLe2dsfA/EIfaHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZwMDeUF82vZHXHPHV8YwwYO6sz4QTBw5PH5v/ZOrQ90mDc9UoMO/+88Uwp7LkfEx3k0GabBfAv5lEGUXK0GDGMv+mTHeOcwQnXL1tJTA9IsjQlRxf/aWEKm7BkNOQ6iZHAzHyN2pk3nL5Eear96BgvMB/PCRfO+hv00HjEf/Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKmxUnS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BACC4CEC1;
	Thu, 29 Aug 2024 04:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724905748;
	bh=YqFdGToztJ7s2NHpwfd42YqwaXqzfLe2dsfA/EIfaHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uKmxUnS6UCK88PgjqCDrL5tHYL9dY+ZaDzjYxUMuH7J+qp/5/v83vj1t3W0LKRcdE
	 p7mmc3jtxALKkWzekkXSNCOUCS4fKllGrLP1GL4J9I3tD9BPv7+bmR6DqtvKZbZ2YK
	 SmTWDWOHzZtREk3k3ppMDRFzJpodw0MJYvKGU9x42Ynjcy4hvkmbUhVdPW140LA0/C
	 kuuyZXZAjnzjCp/BpzfbJ5gKoPH9pPFzBnveQcDv/Xu2IzLOHURunYGqgJf/hf8FJG
	 Jl7V6nMG+JhpVmGyNuNGxjADYhfySNcGO31ZVDUo/pFos5l/BapMdDRaHtk4CKgz5V
	 6iMAnSYqvvETg==
Message-ID: <ed3ca336-7fbb-4247-bdd1-4ee5f3697d11@kernel.org>
Date: Wed, 28 Aug 2024 21:29:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] icmp: change the order of rate limits
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Willy Tarreau <w@1wt.eu>, Keyu Man <keyu.man@email.ucr.edu>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, stable@vger.kernel.org
References: <20240828193948.2692476-1-edumazet@google.com>
 <20240828193948.2692476-2-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240828193948.2692476-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/24 1:39 PM, Eric Dumazet wrote:
> ICMP messages are ratelimited :
> 
> After the blamed commits, the two rate limiters are applied in this order:
> 
> 1) host wide ratelimit (icmp_global_allow())
> 
> 2) Per destination ratelimit (inetpeer based)
> 
> In order to avoid side-channels attacks, we need to apply
> the per destination check first.
> 
> This patch makes the following change :
> 
> 1) icmp_global_allow() checks if the host wide limit is reached.
>    But credits are not yet consumed. This is deferred to 3)
> 
> 2) The per destination limit is checked/updated.
>    This might add a new node in inetpeer tree.
> 
> 3) icmp_global_consume() consumes tokens if prior operations succeeded.
> 
> This means that host wide ratelimit is still effective
> in keeping inetpeer tree small even under DDOS.
> 
> As a bonus, I removed icmp_global.lock as the fast path
> can use a lock-free operation.
> 
> Fixes: c0303efeab73 ("net: reduce cycles spend on ICMP replies that gets rate limited")
> Fixes: 4cdf507d5452 ("icmp: add a global rate limitation")
> Reported-by: Keyu Man <keyu.man@email.ucr.edu>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  include/net/ip.h |   2 +
>  net/ipv4/icmp.c  | 103 ++++++++++++++++++++++++++---------------------
>  net/ipv6/icmp.c  |  28 ++++++++-----
>  3 files changed, 76 insertions(+), 57 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



