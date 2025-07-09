Return-Path: <stable+bounces-161375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B46AFDD28
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 03:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C125C7AE919
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 01:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8DD191F72;
	Wed,  9 Jul 2025 01:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5pWlTw/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D1380C1C;
	Wed,  9 Jul 2025 01:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026072; cv=none; b=i+e1VutDjEz/OwmEZRLf9xwezO6ZNcGljLs7uX4J5qzq8UkawDj8uafAdJvLzzBUKRmNzJccdmHRulA0CWUyVt3b/JfBz0gVR//YjqAaFCh2YQKL6o17psEavA6uNNKjSZ2kRaTHACxTNsNW9TFFHMj88EJdtcJ6BV9gAje/bD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026072; c=relaxed/simple;
	bh=asWLqyRRMNPGhcUWpVSdiagdrtMDgHVRskAAx1fw/W4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVoUXWyBobp/kBhxbLPY4xaj9XIPW6sZJuy0SBNzbzhbaElJMeMq1HJp+cvaRvSIUplKFloNyo2nbmma6TmlnCYOYAmE3WufI4QeP8E0REXlumWmfYNGo3+N7kqqeVzMGnO+AiJkJ7/mxoxzibclwjp6vto7VrNWpIKcoLtZjKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5pWlTw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81F0C4CEED;
	Wed,  9 Jul 2025 01:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752026072;
	bh=asWLqyRRMNPGhcUWpVSdiagdrtMDgHVRskAAx1fw/W4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f5pWlTw/XS/MtkpZGkvojs/wlxNHQ374pCmvZoTBYkgzKTGRKxx8S4aigC+tZtIYq
	 1K+n+XNxqkCMM7LmH3saBti/33iSCu8B6xT842NyWauJLSbxnkXlGIhWSnx9gIWZv2
	 TPpgt2fl63wKz8DWtfRCR6o71ySjgf2UsqStZDPbD1VcKH31tCIAChlm3HMN3Pc0sU
	 3qUORESptCEgGTOp50OzHsrvX0FewvuBoR93QoB7APmF0iyV4zbto92rLKXwIGjmhK
	 RV/4jccssWqzTrBcVs5WxzNybyEl6TPmZmc9jIjoW1RdLShx5f/s08wRsUC7LF6jQZ
	 Ih/qc54cmMhpA==
Date: Tue, 8 Jul 2025 18:54:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: ipv4: fix incorrect MTU in broadcast
 routes
Message-ID: <20250708185430.68f143a2@kernel.org>
In-Reply-To: <20250703152838.2993-1-oscmaes92@gmail.com>
References: <20250703152838.2993-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Jul 2025 17:28:37 +0200 Oscar Maes wrote:
>  	if (type == RTN_BROADCAST) {
>  		flags |= RTCF_BROADCAST | RTCF_LOCAL;
> -		fi = NULL;
>  	} else if (type == RTN_MULTICAST) {
>  		flags |= RTCF_MULTICAST | RTCF_LOCAL;
>  		if (!ip_check_mc_rcu(in_dev, fl4->daddr, fl4->saddr,

Not super familiar with this code, but do we not need to set 
do_cache = false; ? I'm guessing cache interactions may have
been the reason fib_info was originally cleared, not sure if
that's still relevant..

I'd also target this at net-next, unless you can pinpoint
some kernel version where MTU on bcast routes worked..
-- 
pw-bot: cr

