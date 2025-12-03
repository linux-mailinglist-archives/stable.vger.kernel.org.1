Return-Path: <stable+bounces-198190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54903C9ED90
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D01AB342DF7
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E402F25F2;
	Wed,  3 Dec 2025 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IepQj+hL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D524E4A1
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764761446; cv=none; b=iWqaiPhfxmLn4Xjt6qagv+fgf7YGLtNd4ooxQ+IDE/+KRn2mTw5kxvNWuOEuJJ3lcjEcajFt/glOHt0bLPoL0aYVIFu2WNxhzijKimJCdnNgNOMaxupD6gBWy49lfvC1hHYCnFZYVCeqDUon6xmCUBWLqUNWOs/NYOczL/RkESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764761446; c=relaxed/simple;
	bh=JlC29vzYFPhGu+5ZhQQiFj715bUlUVfV6seS8CyKgEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phNl0x87ek3eTdeom2cAZ1LEvXV53PreHL4oSyzlhcXD8Bmac8uu5MrYmL4eSfvCq3VYD3o1Z0jAsG80qH/eR+beVAPscR7zLnHUEyrFCHnw8U5EXJHfLT4JQc327OUFYxXk3gRKUhcg0tp6r5F8MI1u6hwjTHg5/0lTuYOsW24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IepQj+hL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669F8C4CEFB;
	Wed,  3 Dec 2025 11:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764761445;
	bh=JlC29vzYFPhGu+5ZhQQiFj715bUlUVfV6seS8CyKgEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IepQj+hLkFJzluKsJ5H5z3QxZY+8+ZkXg5jSk7V7AloNt5mBgvT3WAiiFIsRR4nQ6
	 qHZDb7DEVLZuMFM13aV3OAjWlh3mPEHm3fW3iuy/YPytHobC+FWNFbV1m/VwSPhBgZ
	 fLZDjyyDOL2VbfkwgAOHJezrZiqsP+mefcwXPDbE=
Date: Wed, 3 Dec 2025 12:30:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: zyc zyc <zyc199902@zohomail.cn>
Cc: stable <stable@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOjYuMTIuNTAgcmVncmVz?=
 =?utf-8?Q?sion=3A_netem?= =?utf-8?Q?=3A?= cannot mix duplicating netems with
 other netems in tree.
Message-ID: <2025120350-encourage-possible-b043@gregkh>
References: <19ace674022.114eb26e714992.3171091003233609170@zohomail.cn>
 <19adda5a1e2.12410b78222774.9191120410578703463@zohomail.cn>
 <2025120248-operation-explain-1991@gregkh>
 <19ae2d0c40c.1304ed0542955.1614492155671387965@zohomail.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19ae2d0c40c.1304ed0542955.1614492155671387965@zohomail.cn>

On Wed, Dec 03, 2025 at 07:05:00PM +0800, zyc zyc wrote:
> ---- Greg KH <gregkh@linuxfoundation.org> 在 Tue, 2025-12-02 19:30:09 写到：---
> 
>  > On Tue, Dec 02, 2025 at 06:39:00PM +0800, zyc zyc wrote: 
>  > > Hello, 
>  > > 
>  > > Resend my last email without HTML. 
>  > > 
>  > > ---- zyc zyc <zyc199902@zohomail.cn> 在 Sat, 2025-11-29 18:57:01 写到：--- 
>  > > 
>  > >  > Hello, maintainer 
>  > >  > 
>  > >  > I would like to report what appears to be a regression in 6.12.50 kernel release related to netem. 
>  > >  > It rejects our configuration with the message: 
>  > >  > Error: netem: cannot mix duplicating netems with other netems in tree. 
>  > >  > 
>  > >  > This breaks setups that previously worked correctly for many years. 
>  > >  > 
>  > >  > 
>  > >  > Our team uses multiple netem qdiscs in the same HTB branch, arranged in a parallel fashion using a prio fan-out. Each branch of the prio qdisc has its own distinct netem instance with different duplication characteristics. 
>  > >  > 
>  > >  > This is used to emulate our production conditions where a single logical path fans out into two downstream segments, for example: 
>  > >  > 
>  > >  > two ECMP next hops with different misbehaviour characteristics, or 
>  > >  > 
>  > >  > 
>  > >  > an HA firewall cluster where only one node is replaying frames, or 
>  > >  > 
>  > >  > 
>  > >  > two LAG / ToR paths where one path intermittently duplicates packets. 
>  > >  > 
>  > >  > 
>  > >  > In our environments, only a subset of flows are affected, and different downstream devices may cause different styles of duplication. 
>  > >  > This regression breaks existing automated tests, training environments, and network simulation pipelines. 
>  > >  > 
>  > >  > I would be happy to provide our reproducer if needed. 
>  > >  > 
>  > >  > Thank you for your time and for maintaining Linux kernel. 
>  >  
>  > Can you use 'git bisect' to find the offending commit? 
>  >  
>  > thanks, 
>  >  
>  > greg k-h 
>  > 
> 
> Hi Greg,
> 
> The error came from this commit:
> 
> commit 795cb393e38977aa991e70a9363da0ee734b2114
> Author: William Liu <will@willsroot.io>
> Date:   Tue Jul 8 16:43:26 2025 +0000
> 
>     net/sched: Restrict conditions for adding duplicating netems to qdisc tree
>     
>     [ Upstream commit ec8e0e3d7adef940cdf9475e2352c0680189d14e ]

So is this also an issue for you in the latest 6.17 release (or 6.18)?
If not, what commit fixed this issue?  If so, please contact all of the
developers involved and they will be glad to work to resolve this
regression in the mainline tree first.

thanks,

greg k-h

