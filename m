Return-Path: <stable+bounces-169569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 333B6B26954
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A99F17FC44
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 14:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A651D63F3;
	Thu, 14 Aug 2025 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XhkljLK6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486915B0EC;
	Thu, 14 Aug 2025 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181310; cv=none; b=Qb4+zE2T8Dum9yex43Eb1zlfp1jfKFCmJN+4VXSXZn6/rR4oz2r4L2eQy2Ki2Rn07ayMDqDw9Y4ZpG2Wi6ZMSFnhCnKpGv2k2b8OXSZxpmwDy2f05tw4CXutcnEe+66IbvkOTWvmp6WEcjPIBhSg1PY5KmPJ6pqQ57JA6H8E0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181310; c=relaxed/simple;
	bh=TQ6PdhDSzw7Dzr1c2UpdagPEGThCspSgUuL/b+/vsVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biXy3vBysSAblrNzdJ8NB9JoVDhyWPr0Jqs6jPyPfk1V16XJjeEa3JH8/dKMx4C0LqwIO7pd8v19E7iMTX1YkODxUZzH8tk63RTWh4lRD9aCr4jcnoGwGvooVKuoAerJ0cc+t1yKwK/KJ0v2pto1jkSzT4uE2JeYGzMX54ccNGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XhkljLK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0F5C4CEF7;
	Thu, 14 Aug 2025 14:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755181310;
	bh=TQ6PdhDSzw7Dzr1c2UpdagPEGThCspSgUuL/b+/vsVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XhkljLK6qCOV4anQ1thdHIA7DE1gIGCQU/qzWxSmuHWiJGJI5lpmz7ZF4RM5aNpFA
	 LifSRFqmgNXX85n1tdsWRMr7IHmqzXjmPOcoDLlle44+1hWLXNd6/ISqDHz9Q2I5Ln
	 Bos+mblFFH63IpRJFyfJXBUnFKUDirDSTqtyQqis=
Date: Thu, 14 Aug 2025 16:21:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Julian Taylor <julian.taylor@1und1.de>
Cc: patchwork-bot+netdevbpf@kernel.org, Fedor Pchelkin <pchelkin@ispras.ru>,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	kuniyu@google.com, edumazet@google.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH net] netlink: avoid infinite retry looping in
 netlink_unicast()
Message-ID: <2025081448-version-excursion-1456@gregkh>
References: <20250728080727.255138-1-pchelkin@ispras.ru>
 <175392900576.2584771.4406793154439387342.git-patchwork-notify@kernel.org>
 <9fa0c0ea-9c5d-4039-856f-222486283a3c@1und1.de>
 <2025081422-monetize-ferocity-fe28@gregkh>
 <2ebf39be-aa26-4863-931b-a32fde9de182@1und1.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ebf39be-aa26-4863-931b-a32fde9de182@1und1.de>

On Thu, Aug 14, 2025 at 04:14:39PM +0200, Julian Taylor wrote:
> 
> 
> On 14.08.25 15:57, Greg KH wrote:
> > On Thu, Aug 14, 2025 at 02:51:27PM +0200, Julian Taylor wrote:
> > > 
> > > On 31.07.25 04:30, patchwork-bot+netdevbpf@kernel.org wrote:
> > > > Hello:
> > > > 
> > > > This patch was applied to netdev/net.git (main)
> > > > by Jakub Kicinski <kuba@kernel.org>:
> > > > 
> > > > On Mon, 28 Jul 2025 11:06:47 +0300 you wrote:
> > > > > netlink_attachskb() checks for the socket's read memory allocation
> > > > > constraints. Firstly, it has:
> > > > > 
> > > > >     rmem < READ_ONCE(sk->sk_rcvbuf)
> > > > > 
> > > > > to check if the just increased rmem value fits into the socket's receive
> > > > > buffer. If not, it proceeds and tries to wait for the memory under:
> > > > > 
> > > > > [...]
> > > > 
> > > > Here is the summary with links:
> > > >     - [net] netlink: avoid infinite retry looping in netlink_unicast()
> > > >       https://git.kernel.org/netdev/net/c/759dfc7d04ba
> > > > 
> > > > You are awesome, thank you!
> > > 
> > > hello,
> > > as far as I can tell this patch has not made it to the 6.1 stable tree yet in the 6.1.148 review yet:
> > > https://www.spinics.net/lists/stable/msg866199.html
> > 
> > Please use lore.kernel.org links.
> > 
> > > As this seems to be causing issues in distributions releasing 6.1.147 can this still be added to the next possible stable release?
> > > See following issues in relation to loading audit rules which seems to trigger the fixed bug:
> > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1111017
> > > https://github.com/amazonlinux/amazon-linux-2023/issues/988
> > > 
> > > I have tested this patch solves the problem in the Debian bookworm using 6.1.x
> > 
> > What is the git commit id of this patch in Linus's tree?
> > 
> 
> 
> The commit id is 759dfc7d04bab1b0b86113f1164dc1fec192b859
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=759dfc7d04bab1b0b86113f1164dc1fec192b859

Thanks, I'll queue this up for the next round of kernels.

Right now we have a backlog of 500+ patches due to all of these being
added during the -rc1 merge window.  Please be patient while we dig
through them.

thanks,

greg k-h

