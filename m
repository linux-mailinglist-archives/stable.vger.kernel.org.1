Return-Path: <stable+bounces-56336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23755923A5A
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 11:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5D21C229D4
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 09:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA03155312;
	Tue,  2 Jul 2024 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gVN9QI5s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D313D8BA;
	Tue,  2 Jul 2024 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913341; cv=none; b=f7ysgVFZFpOarDSqTwQCk9kjdqADcyu2GjWB4hMG8m7sm4GQEm5E1iIFg43l2ylbuKMBWpozR1hHVsMd1Mu2VGxSz2H/IX+ePqfsvnrdHej6dF1+WoxSDHikRAGEmhX+IrC2jRpiHYLdzeuUXVtsLl48/Ju1A86+pahWl7R/iBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913341; c=relaxed/simple;
	bh=IdsBWoTpm6MC5BQctO736Zwu3gL2rlz9Gvm+xB0DvLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McSSagUBSPS5k0szmXXAVPbVlrqt/6rXYSGvAq/oo5Cnxdo1y/kW7jojnf1EITlawohV7bB+d5Jh04CKePKNt0Titte42kKUtomDAhxlmkxhXlRf6bMLPDN0zGPYZ6gETUCSCGcqqaZ9ACwM7AqJJvxqUTs/luIW5sLO/mO1OJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gVN9QI5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4D8C116B1;
	Tue,  2 Jul 2024 09:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719913341;
	bh=IdsBWoTpm6MC5BQctO736Zwu3gL2rlz9Gvm+xB0DvLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gVN9QI5s/ek2EI6v275cWiCBY1KIfITsrBeAeO//UjiznstGnuvKJigGnHkkl3JdN
	 hWm1PTpIbEd1M8x+0xrIgNztlGX8QRfysYUUcUgls8h5JLrA5LBmybR0Oq5gzCPE5d
	 N3XKpu7KgqjOwgVU81LVjO7LRQaf5Q15XBU8so2A=
Date: Tue, 2 Jul 2024 11:42:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, hiraku.toyooka@miraclelinux.com,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5.15 1/3] ipv6: annotate some data-races around
 sk->sk_prot
Message-ID: <2024070241-equivocal-dismantle-5dd2@gregkh>
References: <20230417165348.26189-1-kazunori.kobayashi@miraclelinux.com>
 <20230417165348.26189-2-kazunori.kobayashi@miraclelinux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417165348.26189-2-kazunori.kobayashi@miraclelinux.com>

On Mon, Apr 17, 2023 at 04:53:46PM +0000, Kazunori Kobayashi wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> commit 086d49058cd8471046ae9927524708820f5fd1c7 upstream.
> 
> IPv6 has this hack changing sk->sk_prot when an IPv6 socket
> is 'converted' to an IPv4 one with IPV6_ADDRFORM option.
> 
> This operation is only performed for TCP and UDP, knowing
> their 'struct proto' for the two network families are populated
> in the same way, and can not disappear while a reader
> might use and dereference sk->sk_prot.
> 
> If we think about it all reads of sk->sk_prot while
> either socket lock or RTNL is not acquired should be using READ_ONCE().
> 
> Also note that other layers like MPTCP, XFRM, CHELSIO_TLS also
> write over sk->sk_prot.
> 
> BUG: KCSAN: data-race in inet6_recvmsg / ipv6_setsockopt
> 
> write to 0xffff8881386f7aa8 of 8 bytes by task 26932 on cpu 0:
>  do_ipv6_setsockopt net/ipv6/ipv6_sockglue.c:492 [inline]
>  ipv6_setsockopt+0x3758/0x3910 net/ipv6/ipv6_sockglue.c:1019
>  udpv6_setsockopt+0x85/0x90 net/ipv6/udp.c:1649
>  sock_common_setsockopt+0x5d/0x70 net/core/sock.c:3489
>  __sys_setsockopt+0x209/0x2a0 net/socket.c:2180
>  __do_sys_setsockopt net/socket.c:2191 [inline]
>  __se_sys_setsockopt net/socket.c:2188 [inline]
>  __x64_sys_setsockopt+0x62/0x70 net/socket.c:2188
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> read to 0xffff8881386f7aa8 of 8 bytes by task 26911 on cpu 1:
>  inet6_recvmsg+0x7a/0x210 net/ipv6/af_inet6.c:659
>  ____sys_recvmsg+0x16c/0x320
>  ___sys_recvmsg net/socket.c:2674 [inline]
>  do_recvmmsg+0x3f5/0xae0 net/socket.c:2768
>  __sys_recvmmsg net/socket.c:2847 [inline]
>  __do_sys_recvmmsg net/socket.c:2870 [inline]
>  __se_sys_recvmmsg net/socket.c:2863 [inline]
>  __x64_sys_recvmmsg+0xde/0x160 net/socket.c:2863
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> value changed: 0xffffffff85e0e980 -> 0xffffffff85e01580
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 26911 Comm: syz-executor.3 Not tainted 5.17.0-rc2-syzkaller-00316-g0457e5153e0e-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>

This backport didn't apply at all, are you sure you made it against the
proper tree?

The original commit does seem to apply properly, so I'll go apply that
one instead...

greg k-h

