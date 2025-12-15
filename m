Return-Path: <stable+bounces-201060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95555CBE731
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 15:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B7D43012770
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 14:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2093F312838;
	Mon, 15 Dec 2025 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr7mMcPv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7144314D0D;
	Mon, 15 Dec 2025 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765810693; cv=none; b=dcQ3sGZDYMnQSBTyt4UUJX63YTCxvkfrvDYiGkl8rN4LDE4Xww8pnecXD5lq7DGXUi2P80AUVE0MFp5fgQP3bOASCr5QVc+LTmD9AtATC5Q1PxDMxZD1Zl6oucDtF4C/ZWAcKgQffzljFwzz3uWfYeL795bgRb3meHd5SXuTqS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765810693; c=relaxed/simple;
	bh=9OEkkqZap5ynQAoYmkWtavaoGN0ADPb72Qb5KtRVEA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYpDl7MusVq9ZMZ/u+sRhy4LefUCxkM0MEELuYIcLfGpdQhHJ6KVaU6Tfsqwtm+Vh+soZI+ykqjUtfdTB8bPNmyJ95Bwv3PWgv/XDuhqyjQYn2VrIApzpl1IzbbhFZP4vsdlso7PfgG9NqOWsYKf+DyX99rqLj2ZC7mAIfklz18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr7mMcPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EE2C4CEF5;
	Mon, 15 Dec 2025 14:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765810693;
	bh=9OEkkqZap5ynQAoYmkWtavaoGN0ADPb72Qb5KtRVEA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vr7mMcPvQyuoNlsvKUtwWmrVGsrf0mue6k0l/X+cIdvgNpc9YSHydclrmu0+jEJJi
	 2Fhz2ZxAWQbBaHrvx1NOTzcbvX9n6z4BjaaJyaJZrI7/e6Du818X1JSG0F/MVxnnVD
	 aa0wOBWZyv0XMdHm3a+TOl9sow+NboTnE8WQ1qxk6fcnHf/fOE8wDIdYvg6Yv9VMwg
	 sJA6Jt7Jpd1Mno3pdpPGpQ2MzSpc6qt3O/epavRGsiT1/sDfbtaQ50Q/sPlqJwPMPU
	 5ZUq/XpOJ6idwlNSlWITuiilItVGmTyQz+7X25Y1ZS8Jd8CwdXXgPD4nuOw++P/EEg
	 Mj2IApS3LDT9A==
Date: Mon, 15 Dec 2025 14:58:08 +0000
From: Simon Horman <horms@kernel.org>
To: Frode Nordahl <fnordahl@ubuntu.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tariq Toukan <tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] erspan: Initialize options_len before referencing
 options.
Message-ID: <aUAiAG2QaiM9mnl5@horms.kernel.org>
References: <20251213101338.4693-1-fnordahl@ubuntu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213101338.4693-1-fnordahl@ubuntu.com>

On Sat, Dec 13, 2025 at 10:13:36AM +0000, Frode Nordahl wrote:
> The struct ip_tunnel_info has a flexible array member named
> options that is protected by a counted_by(options_len)
> attribute.
> 
> The compiler will use this information to enforce runtime bounds
> checking deployed by FORTIFY_SOURCE string helpers.
> 
> As laid out in the GCC documentation, the counter must be
> initialized before the first reference to the flexible array
> member.
> 
> After scanning through the files that use struct ip_tunnel_info
> and also refer to options or options_len, it appears the normal
> case is to use the ip_tunnel_info_opts_set() helper.
> 
> Said helper would initialize options_len properly before copying
> data into options, however in the GRE ERSPAN code a partial
> update is done, preventing the use of the helper function.
> 
> Before this change the handling of ERSPAN traffic in GRE tunnels
> would cause a kernel panic when the kernel is compiled with
> GCC 15+ and having FORTIFY_SOURCE configured:
> 
> memcpy: detected buffer overflow: 4 byte write of buffer size 0
> 
> Call Trace:
>  <IRQ>
>  __fortify_panic+0xd/0xf
>  erspan_rcv.cold+0x68/0x83
>  ? ip_route_input_slow+0x816/0x9d0
>  gre_rcv+0x1b2/0x1c0
>  gre_rcv+0x8e/0x100
>  ? raw_v4_input+0x2a0/0x2b0
>  ip_protocol_deliver_rcu+0x1ea/0x210
>  ip_local_deliver_finish+0x86/0x110
>  ip_local_deliver+0x65/0x110
>  ? ip_rcv_finish_core+0xd6/0x360
>  ip_rcv+0x186/0x1a0
> 
> Cc: stable@vger.kernel.org
> Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-counted_005fby-variable-attribute
> Reported-at: https://launchpad.net/bugs/2129580
> Fixes: bb5e62f2d547 ("net: Add options as a flexible array to struct ip_tunnel_info")
> Signed-off-by: Frode Nordahl <fnordahl@ubuntu.com>
> ---
> v2:
>   - target correct netdev tree and properly cc stable in commit message.
>   - replace repeated long in-line comments and link with a single line.
>   - document search for any similar offenses in the code base in commit
>     message.
> v1: https://lore.kernel.org/all/20251212073202.13153-1-fnordahl@ubuntu.com/

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>



