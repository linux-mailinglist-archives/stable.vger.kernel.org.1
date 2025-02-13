Return-Path: <stable+bounces-115132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E5CA33F89
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 13:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3C33AA21D
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F9B21D3FC;
	Thu, 13 Feb 2025 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P1+Fhb0p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013C52C182
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451268; cv=none; b=X0vHI0Y3hWV/te6m2wzOUM+jLsfqLmX5Up4xym/zMWlPJHhdv11iDb8B9O77LWb8GuwEcmMzDW/bErZr6DsHjWeF0oHrrL9N8heQlL222B1/1y0qQIjC2AO9DCBrfHJGT3fi3EGCYzjdJfeeVNBPnKVO8z2MSeANPsoN3cJMCG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451268; c=relaxed/simple;
	bh=ZBiOwZDb2bjQaKG5zFfj4dbKZQ+PcfxC3iTAnAW/12k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZAtnk2X5qPdGdzm6xXFTtUEPt14oZfgHQfLgOIpLwX364VuRPAVRdNmI/miIBSpNo4E/FO6tlIlfsDmWwU4tsejuCrklE4PaeBnk22m5YCHMgLMPI/RviAb+c1oll4agbDaWaTru5LEtoT+WfWAQuOSqnYWmccnYRnLerTTfY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P1+Fhb0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFECDC4CED1;
	Thu, 13 Feb 2025 12:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739451267;
	bh=ZBiOwZDb2bjQaKG5zFfj4dbKZQ+PcfxC3iTAnAW/12k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1+Fhb0pjlGhThhbVYqzdO8wrhfVa7+HSc25xxq20MJfwpeUs0wo28IvC71B0GkkS
	 myoqTxIcE+B3K5/xaFsjo0olmsVn7lrOY3zAZ87Uqk9BPAQNAa7UlOpXQL6LaK18Ck
	 H9w/eNsgoOvR1E7/0DC8QkrT+RbtVlOZQ93gYBbA=
Date: Thu, 13 Feb 2025 13:54:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: vgiraud.opensource@witekio.com
Cc: stable@vger.kernel.org, Dong Chenchen <dongchenchen2@huawei.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Bruno VERNAY <bruno.vernay@se.com>
Subject: Re: [PATCH 6.6] net: Fix icmp host relookup triggering ip_rt_bug
Message-ID: <2025021342-chokehold-pulp-3f7a@gregkh>
References: <20250207145657.2504508-1-vgiraud.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207145657.2504508-1-vgiraud.opensource@witekio.com>

On Fri, Feb 07, 2025 at 03:56:57PM +0100, vgiraud.opensource@witekio.com wrote:
> From: Dong Chenchen <dongchenchen2@huawei.com>
> 
> [ Upstream commit c44daa7e3c73229f7ac74985acb8c7fb909c4e0a ]
> 
> arp link failure may trigger ip_rt_bug while xfrm enabled, call trace is:
> 
> WARNING: CPU: 0 PID: 0 at net/ipv4/route.c:1241 ip_rt_bug+0x14/0x20
> Modules linked in:
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc6-00077-g2e1b3cc9d7f7
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:ip_rt_bug+0x14/0x20
> Call Trace:
>  <IRQ>
>  ip_send_skb+0x14/0x40
>  __icmp_send+0x42d/0x6a0
>  ipv4_link_failure+0xe2/0x1d0
>  arp_error_report+0x3c/0x50
>  neigh_invalidate+0x8d/0x100
>  neigh_timer_handler+0x2e1/0x330
>  call_timer_fn+0x21/0x120
>  __run_timer_base.part.0+0x1c9/0x270
>  run_timer_softirq+0x4c/0x80
>  handle_softirqs+0xac/0x280
>  irq_exit_rcu+0x62/0x80
>  sysvec_apic_timer_interrupt+0x77/0x90
> 
> The script below reproduces this scenario:
> ip xfrm policy add src 0.0.0.0/0 dst 0.0.0.0/0 \
> 	dir out priority 0 ptype main flag localok icmp
> ip l a veth1 type veth
> ip a a 192.168.141.111/24 dev veth0
> ip l s veth0 up
> ping 192.168.141.155 -c 1
> 
> icmp_route_lookup() create input routes for locally generated packets
> while xfrm relookup ICMP traffic.Then it will set input route
> (dst->out = ip_rt_bug) to skb for DESTUNREACH.
> 
> For ICMP err triggered by locally generated packets, dst->dev of output
> route is loopback. Generally, xfrm relookup verification is not required
> on loopback interfaces (net.ipv4.conf.lo.disable_xfrm = 1).
> 
> Skip icmp relookup for locally generated packets to fix it.
> 
> Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Link: https://patch.msgid.link/20241127040850.1513135-1-dongchenchen2@huawei.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
> Signed-off-by: Victor Giraud <vgiraud.opensource@witekio.com>
> ---
>  net/ipv4/icmp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 9dffdd876fef..ab830c093f7e 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -522,6 +522,9 @@ static struct rtable *icmp_route_lookup(struct net *net,
>  		if (rt != rt2)
>  			return rt;
>  	} else if (PTR_ERR(rt) == -EPERM) {
> +		if (inet_addr_type_dev_table(net, route_lookup_dev,
> +					     fl4->daddr) == RTN_LOCAL)
> +			return rt;

Are you sure this backport is correct?  Have you tested it?  It looks
different from the original so you need to document why it is different
somewhere.

I'm dropping both of these backports, please fix up and resend.

thanks,

greg k-h

