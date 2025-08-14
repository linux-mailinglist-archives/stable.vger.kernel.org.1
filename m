Return-Path: <stable+bounces-169566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF3AB2687F
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83BFA27E6C
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 13:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A8C3009E0;
	Thu, 14 Aug 2025 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a1S3lmav"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB22FCBF1;
	Thu, 14 Aug 2025 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179879; cv=none; b=uA2iLeqi1j1dHwUPoVQ8A9hlmsWm0pDz29o0qUpmntv3+RgUhXehtMGRtLx9eG8WuxjmhxAgLhDV9gXB8x7k64HDqlJ6wymG5dvGo5nrQE8zDHLr+ZBV60pdvfwpu8E/qD30Lkmv+PKwqPuXRPhgkBxT5z24nW+1CD5AJ6TITbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179879; c=relaxed/simple;
	bh=00L8Plgo1muOZEE6yX/bScl7169HxigOb92OdTXvj6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6XUKk20mP730bi1OnMzMmGXTJX6a7OXpYA6/4+4iJ14WGEj24FinjcV75I4ooE2/sDyTESvrDum0Av4RripQi0LVJ/POJvJIWyk4rUs4T9Egb3kWDJrYLf/a1tRs6V5PILCtAnwo8MokXptIQF4zn9sRz98Z3msK2b+RVy+O6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a1S3lmav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196A2C4CEED;
	Thu, 14 Aug 2025 13:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755179878;
	bh=00L8Plgo1muOZEE6yX/bScl7169HxigOb92OdTXvj6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a1S3lmavTCmHq0GuVZEGqSDcHNBd1421699LqSu1KFIhCZ74Wi7CiX1c8+vYB5s4t
	 NRxg7Kjxc9//LG6eKfDzCB4nmwT9bsRVyX9pvf3Y2XvkxAXC3YM8msbKJ7lx5W/GZR
	 fDt20911pdG30fQfPQ79NtdZNSf8jlTbzFLkd6SU=
Date: Thu, 14 Aug 2025 15:57:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Julian Taylor <julian.taylor@1und1.de>
Cc: patchwork-bot+netdevbpf@kernel.org, Fedor Pchelkin <pchelkin@ispras.ru>,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	kuniyu@google.com, edumazet@google.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH net] netlink: avoid infinite retry looping in
 netlink_unicast()
Message-ID: <2025081422-monetize-ferocity-fe28@gregkh>
References: <20250728080727.255138-1-pchelkin@ispras.ru>
 <175392900576.2584771.4406793154439387342.git-patchwork-notify@kernel.org>
 <9fa0c0ea-9c5d-4039-856f-222486283a3c@1und1.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fa0c0ea-9c5d-4039-856f-222486283a3c@1und1.de>

On Thu, Aug 14, 2025 at 02:51:27PM +0200, Julian Taylor wrote:
> 
> On 31.07.25 04:30, patchwork-bot+netdevbpf@kernel.org wrote:
> > Hello:
> > 
> > This patch was applied to netdev/net.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> > 
> > On Mon, 28 Jul 2025 11:06:47 +0300 you wrote:
> > > netlink_attachskb() checks for the socket's read memory allocation
> > > constraints. Firstly, it has:
> > > 
> > >    rmem < READ_ONCE(sk->sk_rcvbuf)
> > > 
> > > to check if the just increased rmem value fits into the socket's receive
> > > buffer. If not, it proceeds and tries to wait for the memory under:
> > > 
> > > [...]
> > 
> > Here is the summary with links:
> >    - [net] netlink: avoid infinite retry looping in netlink_unicast()
> >      https://git.kernel.org/netdev/net/c/759dfc7d04ba
> > 
> > You are awesome, thank you!
> 
> hello,
> as far as I can tell this patch has not made it to the 6.1 stable tree yet in the 6.1.148 review yet:
> https://www.spinics.net/lists/stable/msg866199.html

Please use lore.kernel.org links.

> As this seems to be causing issues in distributions releasing 6.1.147 can this still be added to the next possible stable release?
> See following issues in relation to loading audit rules which seems to trigger the fixed bug:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1111017
> https://github.com/amazonlinux/amazon-linux-2023/issues/988
> 
> I have tested this patch solves the problem in the Debian bookworm using 6.1.x

What is the git commit id of this patch in Linus's tree?

thanks,

greg k-h

