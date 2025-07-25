Return-Path: <stable+bounces-164771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C72BB1262C
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BE03BDA6C
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 21:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1F253951;
	Fri, 25 Jul 2025 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDh04UAA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C87820487E;
	Fri, 25 Jul 2025 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753479739; cv=none; b=q07wq5Al+j/JPFRNW1bqwOU0i7rIPmXvIhBbrHF91xbBrjyoLtlpEBbkL9Ng1NJTla3gs0h0RJd6kCrjevDNmzJ3KZ5JJbZfmSJ9+FnTwBcUfCJ6Kzj38zEcr7M5qnPQO8PcG2WYPXtO/JH6vyjmNz0ERsQYjVLB6UXKTslE1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753479739; c=relaxed/simple;
	bh=WinxX6AYbHEm/FkEU/zisNIu3Co8WMWQ1pz0YSaP9OA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3XaRWQQVz6B2dLfIcxssAtovO5RHWJwaP6hWa9l1FK+GoKl7z7NvWbq4CVL8j8nMXFToMnaXBmuFIxl1sOfAR1lYOoVLUoNQHbT6m/Y0Td7p8LTGWCU7rcSKy1RB3PD4uYZT3JrPIgBreoobBWyXQopGTrZgzeBs5atDfmfbqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDh04UAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A8DC4CEE7;
	Fri, 25 Jul 2025 21:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753479739;
	bh=WinxX6AYbHEm/FkEU/zisNIu3Co8WMWQ1pz0YSaP9OA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qDh04UAAl7Nw6S1W9yKm0UpWMvAjMiMCH/wEu6grNQ24heA8bBKOUb5vM3q3VkBHg
	 E6qqRE5LsweDMV3MYFNUauNrQLDYeFecetNDlqh1y9pTGWFaalTBCCN6b/t0Jr5ibP
	 rEY96S0VBu0cnYGxWtydXxkE7e/4h+6itUbYDf64YC2axSMbzOHHc0NV0AanraPDXO
	 xK0+IYanHoS2xmo/J1ZosoRi6L1cUw/xhes5mQ8y/fUGLoWgWmqXWUdUjDqCiuwjX4
	 ssk9NxCkEwtVEluFwZZr9CX16zpD2OB8JbXUdVnzQHScm1c43beg2CRzbng73mYZ2w
	 ROU5uC01NJpYQ==
Date: Fri, 25 Jul 2025 14:42:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ipv4: allow directed broadcast routes to
 use dst hint
Message-ID: <20250725144217.2617f6bc@kernel.org>
In-Reply-To: <20250724124942.6895-1-oscmaes92@gmail.com>
References: <20250724124942.6895-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 14:49:42 +0200 Oscar Maes wrote:
> Currently, ip_extract_route_hint uses RTN_BROADCAST to decide
> whether to use the route dst hint mechanism.
> 
> This check is too strict, as it prevents directed broadcast
> routes from using the hint, resulting in poor performance
> during bursts of directed broadcast traffic.
> 
> Fix this in ip_extract_route_hint and modify ip_route_use_hint
> to preserve the intended behaviour.

We are wrapping up our 6.17 material, I think this will need
to wait for 6.18. In the meantime, would it make sense to add
a selftest? Sounds like a relatively rare use case, easy to
regress.

> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index fc323994b..1581b98bc 100644
> --- a/net/ipv4/ip_input.c
> +++ b/net/ipv4/ip_input.c
> @@ -589,8 +589,10 @@ static void ip_sublist_rcv_finish(struct list_head *head)
>  static struct sk_buff *ip_extract_route_hint(const struct net *net,
>  					     struct sk_buff *skb, int rt_type)
>  {
> -	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST ||
> -	    IPCB(skb)->flags & IPSKB_MULTIPATH)
> +	const struct iphdr *iph = ip_hdr(skb);
> +
> +	if (fib4_has_custom_rules(net) || ipv4_is_lbcast(iph->daddr) ||
> +	    (iph->daddr == 0 && iph->saddr == 0) || IPCB(skb)->flags & IPSKB_MULTIPATH)

nit: we still prefer to wrap lines at 80 chars in networking
-- 
pw-bot: cr

