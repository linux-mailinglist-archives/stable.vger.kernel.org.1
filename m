Return-Path: <stable+bounces-69853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5FB95A889
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 01:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C75B22A0D
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 23:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6E217DE0E;
	Wed, 21 Aug 2024 23:53:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DB01D12F4;
	Wed, 21 Aug 2024 23:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724284431; cv=none; b=eYiJDOzl2CVw2OF6KiY1RF7nznOXzmSuxCQrHRG1p+J8zApvyTt48Tfk+wMolVGWHNkiPDtii/ctmrD0RZNzVOZAjagU6XajCtbEO2XrN4dgFdE6bYELXSP1Ma2722RWdxxR6EDFrQh9EUlm2uHOKJ/i78G5CTe3YLaHJA9k/pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724284431; c=relaxed/simple;
	bh=8eMDgoPEreItDjLGyakFAlwc7yU6Q7uaeSoJsdMeVTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEk+Xrnl4rp5plenOyq/TJHdSharUmgWZfapFuon6UV/ii7UM6y3Ue4Zxn0FcajuVJWaAHi6WsGDIvVUDtRG0QVjYitFNgFLwuuLPBpw5ud+L7Jdgu9HnCGAbjJ2S60QR/tbYpgU2TSVDudox2BuAyi/N+qNBAjVk2ZwQoMTSr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=41644 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sgv8x-008u5x-7v; Thu, 22 Aug 2024 01:53:38 +0200
Date: Thu, 22 Aug 2024 01:53:33 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, edumazet@google.com,
	Harald Welte <laforge@gnumonks.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: Patch "gtp: pull network headers in gtp_dev_xmit()" has been
 added to the 6.10-stable tree
Message-ID: <ZsZ9_XrOOZApAAUq@calendula>
References: <20240819142022.4154993-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240819142022.4154993-1-sashal@kernel.org>
X-Spam-Score: -1.7 (-)

Hi Sasha, Greg,

Could you cherry-pick this patch for other -stable kernels?

I confirm this applies up to >= 4.19-stable since it already includes
pskb_inet_may_pull().

Thanks.

On Mon, Aug 19, 2024 at 10:20:22AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     gtp: pull network headers in gtp_dev_xmit()
> 
> to the 6.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      gtp-pull-network-headers-in-gtp_dev_xmit.patch
> and it can be found in the queue-6.10 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 70c490935879f95a7d81403d107e7aa9a0bd7b31
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Thu Aug 8 13:24:55 2024 +0000
> 
>     gtp: pull network headers in gtp_dev_xmit()
>     
>     [ Upstream commit 3a3be7ff9224f424e485287b54be00d2c6bd9c40 ]
>     
>     syzbot/KMSAN reported use of uninit-value in get_dev_xmit() [1]
>     
>     We must make sure the IPv4 or Ipv6 header is pulled in skb->head
>     before accessing fields in them.
>     
>     Use pskb_inet_may_pull() to fix this issue.
>     
>     [1]
>     BUG: KMSAN: uninit-value in ipv6_pdp_find drivers/net/gtp.c:220 [inline]
>      BUG: KMSAN: uninit-value in gtp_build_skb_ip6 drivers/net/gtp.c:1229 [inline]
>      BUG: KMSAN: uninit-value in gtp_dev_xmit+0x1424/0x2540 drivers/net/gtp.c:1281
>       ipv6_pdp_find drivers/net/gtp.c:220 [inline]
>       gtp_build_skb_ip6 drivers/net/gtp.c:1229 [inline]
>       gtp_dev_xmit+0x1424/0x2540 drivers/net/gtp.c:1281
>       __netdev_start_xmit include/linux/netdevice.h:4913 [inline]
>       netdev_start_xmit include/linux/netdevice.h:4922 [inline]
>       xmit_one net/core/dev.c:3580 [inline]
>       dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3596
>       __dev_queue_xmit+0x358c/0x5610 net/core/dev.c:4423
>       dev_queue_xmit include/linux/netdevice.h:3105 [inline]
>       packet_xmit+0x9c/0x6c0 net/packet/af_packet.c:276
>       packet_snd net/packet/af_packet.c:3145 [inline]
>       packet_sendmsg+0x90e3/0xa3a0 net/packet/af_packet.c:3177
>       sock_sendmsg_nosec net/socket.c:730 [inline]
>       __sock_sendmsg+0x30f/0x380 net/socket.c:745
>       __sys_sendto+0x685/0x830 net/socket.c:2204
>       __do_sys_sendto net/socket.c:2216 [inline]
>       __se_sys_sendto net/socket.c:2212 [inline]
>       __x64_sys_sendto+0x125/0x1d0 net/socket.c:2212
>       x64_sys_call+0x3799/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:45
>       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>       do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>     
>     Uninit was created at:
>       slab_post_alloc_hook mm/slub.c:3994 [inline]
>       slab_alloc_node mm/slub.c:4037 [inline]
>       kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4080
>       kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:583
>       __alloc_skb+0x363/0x7b0 net/core/skbuff.c:674
>       alloc_skb include/linux/skbuff.h:1320 [inline]
>       alloc_skb_with_frags+0xc8/0xbf0 net/core/skbuff.c:6526
>       sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2815
>       packet_alloc_skb net/packet/af_packet.c:2994 [inline]
>       packet_snd net/packet/af_packet.c:3088 [inline]
>       packet_sendmsg+0x749c/0xa3a0 net/packet/af_packet.c:3177
>       sock_sendmsg_nosec net/socket.c:730 [inline]
>       __sock_sendmsg+0x30f/0x380 net/socket.c:745
>       __sys_sendto+0x685/0x830 net/socket.c:2204
>       __do_sys_sendto net/socket.c:2216 [inline]
>       __se_sys_sendto net/socket.c:2212 [inline]
>       __x64_sys_sendto+0x125/0x1d0 net/socket.c:2212
>       x64_sys_call+0x3799/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:45
>       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>       do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>     
>     CPU: 0 UID: 0 PID: 7115 Comm: syz.1.515 Not tainted 6.11.0-rc1-syzkaller-00043-g94ede2a3e913 #0
>     Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
>     
>     Fixes: 999cb275c807 ("gtp: add IPv6 support")
>     Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
>     Signed-off-by: Eric Dumazet <edumazet@google.com>
>     Cc: Harald Welte <laforge@gnumonks.org>
>     Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>
>     Link: https://patch.msgid.link/20240808132455.3413916-1-edumazet@google.com
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> index 427b91aca50d3..0696faf60013e 100644
> --- a/drivers/net/gtp.c
> +++ b/drivers/net/gtp.c
> @@ -1269,6 +1269,9 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  	if (skb_cow_head(skb, dev->needed_headroom))
>  		goto tx_err;
>  
> +	if (!pskb_inet_may_pull(skb))
> +		goto tx_err;
> +
>  	skb_reset_inner_headers(skb);
>  
>  	/* PDP context lookups in gtp_build_skb_*() need rcu read-side lock. */

