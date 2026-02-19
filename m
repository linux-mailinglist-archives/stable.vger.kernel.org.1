Return-Path: <stable+bounces-217442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBw2KUYil2lAvAIAu9opvQ
	(envelope-from <stable+bounces-217442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:46:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3C415FB8A
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 15:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 595723046091
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 14:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1A633F8D9;
	Thu, 19 Feb 2026 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="p83vKIuU"
X-Original-To: stable@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1F833E363;
	Thu, 19 Feb 2026 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512237; cv=none; b=ixysvwESHXiVo6DcIs9VCvu22WdpO20QCoQDrMglZERTvpCmYF9BHXAp8GLlwN7rXJMtSMjjM6M9HWX1Z2+2Qi06fdGvvUDH1Rnx0tGXU9sodrR3UIdGOGhms4jba1xV7YJf/zeH46Ta5UCR6ffiRKGi6mbhugsR9o2cXUuRgUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512237; c=relaxed/simple;
	bh=wrDcT68tjzWDw0KnopV0KPmRwe4z7FMUImVXdNBcgNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxMhS0NpuBJ9KoBX4c+vffkGfGqj7Sdkqf+WkqC51+KbHwsblvYK0OmUQRngHkYr3wnhFcmvLj2YFJ6Lm1i2GI66FlTM6o6/v3I6qTwxA8nLyGa6zZzW7FcezonOOMQ0KNQKjNoBJSkZmkzvhLvVJU0cGL+FRHkmQ48++Ino2FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=p83vKIuU; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E1A981483047;
	Thu, 19 Feb 2026 15:34:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1771511704; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=fnoCxlXNAvqGXeIlhnynw34rDuzT2dMUswG6JRemf6A=;
	b=p83vKIuUydHuNVBbOdfuYz7q5Og4LiPxeitxVnJzMWMRHnn+C422MJCXZbQu7jAbJMrjf6
	FifXkY1eqc6XEfP8Aa9fr13xMJ7DBWOBKRuqEn6SakF3tQuaa1UuKE8k7W1bWudkxE+z3u
	TwMjZhEV0Y+tDlZlCih/LAveHGGUqPKw1i2UiDPErsl8HN0QxiyXYqqoiXP0KShLgpQIh1
	5gifeQjrIHGqcqdfOz4gt0Z+3M46Gj8uuSIinfZGzjRRnuAJxfKvGTe1Fs9+uw3CzgXJ+I
	5YvADNGj8WEhob0gsgk50elGYJl+Ynobs0MU5D26mQZwKgeKec3NuaqjAUuE7Q==
Date: Thu, 19 Feb 2026 15:34:54 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: pabeni@redhat.com, nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	rmk+kernel@armlinux.org.uk, Kexin.Hao@windriver.com,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH net v3] net: macb: Relocate mog_init_rings() callback
 from macb_mac_link_up() to macb_open()
Message-ID: <20260219-knapsack-thirteen-7d9e83451a40@thorsis.com>
Mail-Followup-To: Xiaolei Wang <xiaolei.wang@windriver.com>,
	pabeni@redhat.com, nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	rmk+kernel@armlinux.org.uk, Kexin.Hao@windriver.com,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
References: <20251222015624.1994551-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222015624.1994551-1-xiaolei.wang@windriver.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[thorsis.com,quarantine];
	R_DKIM_ALLOW(-0.20)[thorsis.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217442-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ada@thorsis.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[thorsis.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,windriver.com:email]
X-Rspamd-Queue-Id: 5D3C415FB8A
X-Rspamd-Action: no action

Hello,

this change leads to a system lockup, see below.

Am Mon, Dec 22, 2025 at 09:56:24AM +0800 schrieb Xiaolei Wang:
> In the non-RT kernel, local_bh_disable() merely disables preemption,
> whereas it maps to an actual spin lock in the RT kernel. Consequently,
> when attempting to refill RX buffers via netdev_alloc_skb() in
> macb_mac_link_up(), a deadlock scenario arises as follows:
> 
>    WARNING: possible circular locking dependency detected
>    6.18.0-08691-g2061f18ad76e #39 Not tainted
>    ------------------------------------------------------
>    kworker/0:0/8 is trying to acquire lock:
>    ffff00080369bbe0 (&bp->lock){+.+.}-{3:3}, at: macb_start_xmit+0x808/0xb7c
> 
>    but task is already holding lock:
>    ffff000803698e58 (&queue->tx_ptr_lock){+...}-{3:3}, at: macb_start_xmit
>    +0x148/0xb7c
> 
>    which lock already depends on the new lock.
> 
>    the existing dependency chain (in reverse order) is:
> 
>    -> #3 (&queue->tx_ptr_lock){+...}-{3:3}:
>           rt_spin_lock+0x50/0x1f0
>           macb_start_xmit+0x148/0xb7c
>           dev_hard_start_xmit+0x94/0x284
>           sch_direct_xmit+0x8c/0x37c
>           __dev_queue_xmit+0x708/0x1120
>           neigh_resolve_output+0x148/0x28c
>           ip6_finish_output2+0x2c0/0xb2c
>           __ip6_finish_output+0x114/0x308
>           ip6_output+0xc4/0x4a4
>           mld_sendpack+0x220/0x68c
>           mld_ifc_work+0x2a8/0x4f4
>           process_one_work+0x20c/0x5f8
>           worker_thread+0x1b0/0x35c
>           kthread+0x144/0x200
>           ret_from_fork+0x10/0x20
> 
>    -> #2 (_xmit_ETHER#2){+...}-{3:3}:
>           rt_spin_lock+0x50/0x1f0
>           sch_direct_xmit+0x11c/0x37c
>           __dev_queue_xmit+0x708/0x1120
>           neigh_resolve_output+0x148/0x28c
>           ip6_finish_output2+0x2c0/0xb2c
>           __ip6_finish_output+0x114/0x308
>           ip6_output+0xc4/0x4a4
>           mld_sendpack+0x220/0x68c
>           mld_ifc_work+0x2a8/0x4f4
>           process_one_work+0x20c/0x5f8
>           worker_thread+0x1b0/0x35c
>           kthread+0x144/0x200
>           ret_from_fork+0x10/0x20
> 
>    -> #1 ((softirq_ctrl.lock)){+.+.}-{3:3}:
>           lock_release+0x250/0x348
>           __local_bh_enable_ip+0x7c/0x240
>           __netdev_alloc_skb+0x1b4/0x1d8
>           gem_rx_refill+0xdc/0x240
>           gem_init_rings+0xb4/0x108
>           macb_mac_link_up+0x9c/0x2b4
>           phylink_resolve+0x170/0x614
>           process_one_work+0x20c/0x5f8
>           worker_thread+0x1b0/0x35c
>           kthread+0x144/0x200
>           ret_from_fork+0x10/0x20
> 
>    -> #0 (&bp->lock){+.+.}-{3:3}:
>           __lock_acquire+0x15a8/0x2084
>           lock_acquire+0x1cc/0x350
>           rt_spin_lock+0x50/0x1f0
>           macb_start_xmit+0x808/0xb7c
>           dev_hard_start_xmit+0x94/0x284
>           sch_direct_xmit+0x8c/0x37c
>           __dev_queue_xmit+0x708/0x1120
>           neigh_resolve_output+0x148/0x28c
>           ip6_finish_output2+0x2c0/0xb2c
>           __ip6_finish_output+0x114/0x308
>           ip6_output+0xc4/0x4a4
>           mld_sendpack+0x220/0x68c
>           mld_ifc_work+0x2a8/0x4f4
>           process_one_work+0x20c/0x5f8
>           worker_thread+0x1b0/0x35c
>           kthread+0x144/0x200
>           ret_from_fork+0x10/0x20
> 
>    other info that might help us debug this:
> 
>    Chain exists of:
>      &bp->lock --> _xmit_ETHER#2 --> &queue->tx_ptr_lock
> 
>     Possible unsafe locking scenario:
> 
>           CPU0                    CPU1
>           ----                    ----
>      lock(&queue->tx_ptr_lock);
>                                   lock(_xmit_ETHER#2);
>                                   lock(&queue->tx_ptr_lock);
>      lock(&bp->lock);
> 
>     *** DEADLOCK ***
> 
>    Call trace:
>     show_stack+0x18/0x24 (C)
>     dump_stack_lvl+0xa0/0xf0
>     dump_stack+0x18/0x24
>     print_circular_bug+0x28c/0x370
>     check_noncircular+0x198/0x1ac
>     __lock_acquire+0x15a8/0x2084
>     lock_acquire+0x1cc/0x350
>     rt_spin_lock+0x50/0x1f0
>     macb_start_xmit+0x808/0xb7c
>     dev_hard_start_xmit+0x94/0x284
>     sch_direct_xmit+0x8c/0x37c
>     __dev_queue_xmit+0x708/0x1120
>     neigh_resolve_output+0x148/0x28c
>     ip6_finish_output2+0x2c0/0xb2c
>     __ip6_finish_output+0x114/0x308
>     ip6_output+0xc4/0x4a4
>     mld_sendpack+0x220/0x68c
>     mld_ifc_work+0x2a8/0x4f4
>     process_one_work+0x20c/0x5f8
>     worker_thread+0x1b0/0x35c
>     kthread+0x144/0x200
>     ret_from_fork+0x10/0x20
> 
> Notably, invoking the mog_init_rings() callback upon link establishment
> is unnecessary. Instead, we can exclusively call mog_init_rings() within
> the ndo_open() callback. This adjustment resolves the deadlock issue.
> Furthermore, since MACB_CAPS_MACB_IS_EMAC cases do not use mog_init_rings()
> when opening the network interface via at91ether_open(), moving
> mog_init_rings() to macb_open() also eliminates the MACB_CAPS_MACB_IS_EMAC
> check.
> 
> Fixes: 633e98a711ac ("net: macb: use resolved link config in mac_link_up()")
> Cc: stable@vger.kernel.org
> Suggested-by: Kevin Hao <kexin.hao@windriver.com>
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
> 
> V1: https://patchwork.kernel.org/project/netdevbpf/patch/20251128103647.351259-1-xiaolei.wang@windriver.com/
> V2: Update the correct lock dependency chain and add the Fix tag.
> V3: update commit log, Add full deadlock log added explanations: because MACB_CAPS_MACB_IS_EMAC cases do not
>     use mog_init_rings(), we don't need the MACB_CAPS_MACB_IS_EMAC check when moving mog_init_rings() to macb_open().

After upgrading from 6.12.57-rt14 to 6.12.66-rt15 on a custom at91
sam9x60 based board with PREEMPT_RT patch, we noticed a complete
system lockup, which I bisected to this changeset.

After unplugging and plugging the ethernet cable, while
running PROFINET, system does not respond to anything anymore.
Last message in kernel log is:

  [  +8.621919] macb f802c000.ethernet eth0: Link is Up - 100Mbps/Full - flow control off

Heartbeat LED does not blink anymore, no network communication,
serial console does not respond anymore.

Reverting that change locally prevents the system lockup for me, but
what is the proper course of action on kernel side now?  Send a revert
to stable?  Send a revert to master?  Please advise.

(I'm aware there were least two more patches on netdev referencing
this change, but if I'm not mistaken none of those made it to stable,
right?)

Greets
Alex

P.S.: adding linux-rt-users to Cc

> 
>  drivers/net/ethernet/cadence/macb_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index ca2386b83473..064fccdcf699 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -744,7 +744,6 @@ static void macb_mac_link_up(struct phylink_config *config,
>  		/* Initialize rings & buffers as clearing MACB_BIT(TE) in link down
>  		 * cleared the pipeline and control registers.
>  		 */
> -		bp->macbgem_ops.mog_init_rings(bp);
>  		macb_init_buffers(bp);
>  
>  		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
> @@ -2991,6 +2990,8 @@ static int macb_open(struct net_device *dev)
>  		goto pm_exit;
>  	}
>  
> +	bp->macbgem_ops.mog_init_rings(bp);
> +
>  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
>  		napi_enable(&queue->napi_rx);
>  		napi_enable(&queue->napi_tx);
> -- 
> 2.43.0
> 
> 

