Return-Path: <stable+bounces-176521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91843B38778
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 18:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9941C20CBA
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DF634A31D;
	Wed, 27 Aug 2025 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRhf9J3i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013D432BF3D;
	Wed, 27 Aug 2025 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310990; cv=none; b=bjdM/CkMqEIqyDL7LlHspl36xrsfw8B5nD+6Ys0qWXbTjaDDJUAgCi/ezSv+T3cAgwqAMNpO84UTXdya7F2qY0H9LP436JaVTMVX+pD+b9DZ+S43+jQ/a7SNGWgpoN9hD6Tan9r54XgR+fvw17aeekhkW4HNXwdiGCVwdFKJ73o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310990; c=relaxed/simple;
	bh=QD3kLgq34CY++IsN8XVnnQSyo5Jh98WQg23u1O6HVYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwedIZfQfNgFj3jgQKgXq1TWp8szWEp7vhnYC4zSciPfIXa0hMTLVs/zXRUhCVd5q0CCUsWvJ3w+7DcNCwmLwL9i6FgblDsuoZmyBN1iTgdcEw5gSf0zyfeppnnhslgY8u4v75L+6ykOXuGEVGqUmUO4iIf+alcxoMD/VnvmUek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRhf9J3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B187C4CEEB;
	Wed, 27 Aug 2025 16:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756310989;
	bh=QD3kLgq34CY++IsN8XVnnQSyo5Jh98WQg23u1O6HVYs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vRhf9J3iQXrjKVnr3uDRMstK2OgzhWUA4lHyIWgFgUgI872SVisQWDx7qfGXJ0mqr
	 pDTSLFOsj1Y2Nv7B0GrumPIbHEmrVn4y/xESSi0vnQBoK8eDfqUbBY5w+oG8nXsnkC
	 clZiRGBbgyWRmU5+IMSuo1kYfPwHrfnD3LoMhbwhJqZ9hNUkYXSgRTtS2YEzBO8xYa
	 LM7YGmcRRbv1xC6az6NAz3QqBXHx2tPnoCYyJM/LVWqdxhn7EBnJaQ+Hyge0Q9jePu
	 uNcYmj2qUmLAHLrXdGbGXvqa0LabETbhqyF1iEeBUd20+Oq5r2UHeXMaf60ToPqFb7
	 hf6hFPFivHUWw==
Message-ID: <a42b28d5-e81e-4131-8c00-8925b097070a@kernel.org>
Date: Wed, 27 Aug 2025 10:09:48 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] net: ipv4: fix regression in local-broadcast
 routes
Content-Language: en-US
To: Oscar Maes <oscmaes92@gmail.com>, netdev@vger.kernel.org,
 bacs@librecast.net, brett@librecast.net, kuba@kernel.org
Cc: davem@davemloft.net, regressions@lists.linux.dev, stable@vger.kernel.org
References: <20250827062322.4807-1-oscmaes92@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250827062322.4807-1-oscmaes92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 12:23 AM, Oscar Maes wrote:
> Commit 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
> introduced a regression where local-broadcast packets would have their
> gateway set in __mkroute_output, which was caused by fi = NULL being
> removed.
> 
> Fix this by resetting the fib_info for local-broadcast packets. This
> preserves the intended changes for directed-broadcast packets.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
> Reported-by: Brett A C Sheffield <bacs@librecast.net>
> Closes: https://lore.kernel.org/regressions/20250822165231.4353-4-bacs@librecast.net
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> ---
> Link to discussion:
> https://lore.kernel.org/netdev/20250822165231.4353-4-bacs@librecast.net/
> 
> Thanks to Brett Sheffield for finding the regression and writing
> the initial fix!
> 
>  net/ipv4/route.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



