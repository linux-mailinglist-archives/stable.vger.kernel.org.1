Return-Path: <stable+bounces-203281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B271ECD86E0
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 09:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A331303C9A7
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FBF311C19;
	Tue, 23 Dec 2025 08:09:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lgeamrelo13.lge.com (lgeamrelo13.lge.com [156.147.23.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D27311597
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766477374; cv=none; b=FxmdpV6Gus7XK+CUrELfNbpN7RR0DyvE+wwzediLHw3ZjBuESmaNcG6DTbPKZOvhShAB8RzCpaRNthTpdUakRdZjZxnGUUARF2GHOx7my41mY6wZSM/BU7dzo33bNRVoKTqPLxTmV4CZryoHMEEj56aQ+wtKRlJL35S50ocu3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766477374; c=relaxed/simple;
	bh=C1hHXfG9yGqOaVz9kLlFeD4izo8MSg0/B7q1kejbQV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k12XY0EM/1IvanmbGTitgFg372vkuyO+3tN/sUFpS47OSzHHr8Rk/9B5Vn64wDEA8roVT+HMdcXu6LuYgb+JtQGr333tEUFNk5cmnSHBrWKcrG+X97WGvBB7odJGc2+iCfBv/fpPH4h1uMFPdqnYxpb5KITbg3yO2gyIK6tomlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
	by 156.147.23.53 with ESMTP; 23 Dec 2025 17:09:27 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO BRUNHILD) (10.178.31.97)
	by 156.147.1.125 with ESMTP; 23 Dec 2025 17:09:27 +0900
X-Original-SENDERIP: 10.178.31.97
X-Original-MAILFROM: chanho.min@lge.com
Date: Tue, 23 Dec 2025 17:09:27 +0900
From: Chanho Min <chanho.min@lge.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Oscar Maes <oscmaes92@gmail.com>, stable@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>,
	Chanho Min <chanho.min@lge.com>
Subject: Re: [PATCH] net: ipv4: fix regression in local-broadcast routes
Message-ID: <aUpON69dFQkgL9w/@BRUNHILD>
References: <20251223065911.11660-1-chanho.min@lge.com>
 <2025122311-animating-lettuce-ed6a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025122311-animating-lettuce-ed6a@gregkh>

On Tue, Dec 23, 2025 at 08:44:32AM +0100, Greg KH wrote:
> On Tue, Dec 23, 2025 at 03:59:11PM +0900, Chanho Min wrote:
> > From: Oscar Maes <oscmaes92@gmail.com>
> > 
> > [ Upstream commit 5189446ba995556eaa3755a6e875bc06675b88bd ]
> > 
> > Commit 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
> > introduced a regression where local-broadcast packets would have their
> > gateway set in __mkroute_output, which was caused by fi = NULL being
> > removed.
> > 
> > Fix this by resetting the fib_info for local-broadcast packets. This
> > preserves the intended changes for directed-broadcast packets.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
> > Reported-by: Brett A C Sheffield <bacs@librecast.net>
> > Closes: https://lore.kernel.org/regressions/20250822165231.4353-4-bacs@librecast.net
> > Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> > Reviewed-by: David Ahern <dsahern@kernel.org>
> > Link: https://patch.msgid.link/20250827062322.4807-1-oscmaes92@gmail.com
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  net/ipv4/route.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> You forgot to sign off on this :(
> 
> Also, what tree do you want this backported to?
> 
> thanks,
> 
> greg k-h


Please ignore this patch. It was sent to the list by mistake.

Sorry for the noise.

Thanks,
Chanho Min

