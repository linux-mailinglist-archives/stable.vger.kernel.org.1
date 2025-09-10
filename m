Return-Path: <stable+bounces-179199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2345B516F9
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 14:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BFC165C14
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 12:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE1B313E08;
	Wed, 10 Sep 2025 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="symQNNFY";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="3KONcXgz"
X-Original-To: stable@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46F131D37C;
	Wed, 10 Sep 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507632; cv=pass; b=O4DePFU6X8HELrBNqc7VXL7ov+P5GmrPAUM7GiKRCnrXrbFpzwkYyzLYiF0+ivQ1l/Y2FPn7oRzXUu7Pa76Gp33d+7vm3ZUY5y6DVjDfXeCn+4VfXItNpV6l+XcJNbW6YJxjse2pb46odjD54+lnS/gYYC2FI4gBJizAzele0Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507632; c=relaxed/simple;
	bh=8M2GzYvIA+TpmU2ZecmwBCCAnAMu7eN9RTI1Fh6AveY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DDeryf73aw/8J27O8JuFSAMAZ6CWKb2vggLFcwEwbHp7DbWz7KSG1+IouYpoPBT8ZKXH72aFc3pNnZidUQ2lysIljfiwdrDb04H5lIOiz+DfKEBjGb8FSIgZwW2sPl1JWHEv02ZeBeq8mawEIigvK3mErDT39lQgvU8Il0h71wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=symQNNFY; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=3KONcXgz; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757507609; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZOiyYc7in0uXYUOQbbZOI6rixuJbWgh2YjtprGhj/GP7IK26/a47GFsoRlE8ow8R/P
    rsYCajl+tRXzN0FEc9Vg/u+mEVC6QSG5w0xqynjIQqCq1fXg9Gt9TT5vDVUoqkWdB4Vy
    IO6S4m4IcceRG49b50kKfADuBf3gfoCJAO/C0EG0oVid2E2oVsYLc6e7BuerW9dxhcNz
    xC1pC90eYfglLX0ls2J9s0RLhYU8riw5ryoSnq9Mc3uohJ9C5LwHNUnRj/bvsyGkgUf8
    BIYONdU+cYQwveWRrOA2rsnfGLz9h+Xtde3Y6HaqsaMF/DW3Dw3K/VzllCc2Kb9sXRd6
    NZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757507609;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=uawGsKCcrMWleT592kSxbrH8Xptw/2ObmICJfX6Z9rA=;
    b=nYVou6Z5+88UU8nS71MEvtoCxKcyH7Raw9Q1Pk1xoDa8dgyPY0WaB74LgtZriK3xKK
    /N0FD1GCjW1ze1OV7XVQw50szLhVT4gyElg+gfxL9Y0Q0w8kQF6zBOqqL+97sQzPGQjw
    O3Btp/ia4n9ic2LNs5gI8mpaxilXn4nSMvoQJEuX5ho35bE0wH4+OYww1c24WY73WwQI
    cmYVv8EamQkpX3FYxVGwOpqEapH0ITip2R7knc0GCjf13fxszDBCRA1UO6FnCLz5O0L5
    LTwflK6q83zl/vsky2bcc/RQEJwUNwAf+gGtkfRNuYWcrwQtlhNWGktio5QgY0J1GnJ7
    erIQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757507609;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=uawGsKCcrMWleT592kSxbrH8Xptw/2ObmICJfX6Z9rA=;
    b=symQNNFY1hSPj0DJ8U3LqzoZEbcx57mUd5DuaWQiSHFaZ0SCrJ8zU4vI8jM8by1cpL
    CL+BFUhcKVfPdIgDsBRfTtwqcvwCo8W9+oCpjyTuhL+7wh81yeYj8uQ+S/CwyYQjME3q
    tFZAtmVQqfkHH6WDg/7TKoRl1I8Q38WeV9C9LQneIVZ8zpMBUhGPF41jYStA8I/1tGYu
    Ni4N6hSDhWF6aYc9MZuUvUGj3/MVk+mhhqGgy4o4Psw/DrqVtjNU0pSOcvLhzBxQIF3u
    boXxSU+0uqFAR+SVn80u6xa+o6BhV3sxAnZOQe8B6LjUMs/qquwNzX1iNou89kcsd2WQ
    AQbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757507609;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=uawGsKCcrMWleT592kSxbrH8Xptw/2ObmICJfX6Z9rA=;
    b=3KONcXgzFkubVM55rBcajd4tyBdJIqcx9HGwNoZkQwtv6Z6SOLlUetCse6Mp7EJWuI
    NMTWzZepG+rdPTgDXFDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d36118ACXSuvH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 10 Sep 2025 14:33:28 +0200 (CEST)
Message-ID: <a71b84b1-3dcd-442f-ba22-ca2f3ef90fa7@hartkopp.net>
Date: Wed, 10 Sep 2025 14:33:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10] mptcp: pm: kernel: flush: do not reset ADD_ADDR
 limit
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Thomas Dreibholz <dreibh@simula.no>, Mat Martineau <martineau@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250910-nicety-alert-0e004251@mheyne-amazon>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250910-nicety-alert-0e004251@mheyne-amazon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Max,

I'm not responsible for net/mptcp/pm_netlink.c nor can I be found in git 
blame of that file.

Why did you send this patch to me and having all the relevant persons in CC?

Best regards,
Oliver

On 10.09.25 11:28, Heyne, Maximilian wrote:
> From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
> 
> commit 68fc0f4b0d25692940cdc85c68e366cae63e1757 upstream.
> 
> A flush of the MPTCP endpoints should not affect the MPTCP limits. In
> other words, 'ip mptcp endpoint flush' should not change 'ip mptcp
> limits'.
> 
> But it was the case: the MPTCP_PM_ATTR_RCV_ADD_ADDRS (add_addr_accepted)
> limit was reset by accident. Removing the reset of this counter during a
> flush fixes this issue.
> 
> Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
> Cc: stable@vger.kernel.org
> Reported-by: Thomas Dreibholz <dreibh@simula.no>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/579
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Link: https://patch.msgid.link/20250815-net-mptcp-misc-fixes-6-17-rc2-v1-2-521fe9957892@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [adjusted patch by removing WRITE_ONCE to take into account the missing
>   commit 72603d207d59 ("mptcp: use WRITE_ONCE for the pernet *_max")]
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> ---
> For some reason only the corresponding selftest patch was backported and
> it's now failing on 5.10 kernels. I tested that with this patch the
> selftest is succeeding again.
> ---
>   net/mptcp/pm_netlink.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 32379fc706cac..c31a1dc69f835 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -869,7 +869,6 @@ static void __flush_addrs(struct pm_nl_pernet *pernet)
>   static void __reset_counters(struct pm_nl_pernet *pernet)
>   {
>   	pernet->add_addr_signal_max = 0;
> -	pernet->add_addr_accept_max = 0;
>   	pernet->local_addr_max = 0;
>   	pernet->addrs = 0;
>   }


