Return-Path: <stable+bounces-203277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2F6CD867C
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 08:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 676BB3013387
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 07:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861352FC881;
	Tue, 23 Dec 2025 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r7o83gEd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436132673AA
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766475877; cv=none; b=RfTTFzHgKXuVL5QA6JD7X6xHD/RIRk8QLcIrUUQu9sMJ53k0bbEp6eTR50h37k37BdelXaRE9Vn5rAJOhXg6t7CZF9sKSP6Q+i7oQF8c+WYCvbLVNUVau8EzRkoxnETSMzi7bFKuoqyV2Bx5juuiR6VumBkZ/HdjYaEgAlDIhlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766475877; c=relaxed/simple;
	bh=aVT3aEwlbAKTCxGdSbWZcWB4adHdoBv73wPkPXl4Bow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raiwy/o7CyrLit7jkVFYQKiJzJbCd3ggdFrKDE7KsAnu0lDkkQ6jQ6ZSpykQGyWlUYkvPCbUVxAqaJsE4pj3OHeHHtjPRdjZ6JluMGgkrQiZmi66p9hKBiu+UIlX63WxBKc3Blh9eU4l4bgX82IMKsQW5DKCXYb9KNerdrjAmII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r7o83gEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72903C113D0;
	Tue, 23 Dec 2025 07:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766475876;
	bh=aVT3aEwlbAKTCxGdSbWZcWB4adHdoBv73wPkPXl4Bow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r7o83gEd5SWefvd8hIMfjfp1ZMFmeaQ+mtEcO5viur+KNytO+4ef2jrXHgPnLK0sX
	 z/PBxvSRsstK4xBo5yHC9DJGotlzmNpliDrDvp3x0X87kpByt89cGwbhccSI7wXH56
	 iL8VrTC87bxP6SRI7yo1hA9+pzJy7mUrshG8BwKc=
Date: Tue, 23 Dec 2025 08:44:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chanho Min <chanho.min@lge.com>
Cc: Oscar Maes <oscmaes92@gmail.com>, stable@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] net: ipv4: fix regression in local-broadcast routes
Message-ID: <2025122311-animating-lettuce-ed6a@gregkh>
References: <20251223065911.11660-1-chanho.min@lge.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223065911.11660-1-chanho.min@lge.com>

On Tue, Dec 23, 2025 at 03:59:11PM +0900, Chanho Min wrote:
> From: Oscar Maes <oscmaes92@gmail.com>
> 
> [ Upstream commit 5189446ba995556eaa3755a6e875bc06675b88bd ]
> 
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
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Link: https://patch.msgid.link/20250827062322.4807-1-oscmaes92@gmail.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/ipv4/route.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

You forgot to sign off on this :(

Also, what tree do you want this backported to?

thanks,

greg k-h

