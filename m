Return-Path: <stable+bounces-77759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F361C986EB4
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 10:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4431F228D7
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 08:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312EF1A4B6F;
	Thu, 26 Sep 2024 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XZYXJPGm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B50135A53;
	Thu, 26 Sep 2024 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339051; cv=none; b=n6L7JtvJQU1wImHGmjguSNI/rsS3XlkUTEwbJvUAnwT2OfTuRivDLbUCU/WqXd6lyTmAKZzBuv/u1A0bLHQ5K4ZRPp017aliejfehw4wP3sqPDiVPUv9XrsXL5qg0/EvjXYDNf8d+NAsRu2iYKziEBrOWFTZ1v3dNt1RZ0jvbBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339051; c=relaxed/simple;
	bh=qn1S5gIZmj+pt/uixqcwFQeYW2j1CqFYmNJS6MoqW/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK6BHQrKKvSv5NGr8JG3o0A6ko+Z07byTLMv+dfLO0M++RTEq7NM0HjD6Nu6My56GQWYk0RRh5eNs5SxtFQCeX1Rkbx52RCEF4RDIXK136SxjAaJ/X0lDLruullRsdCmwm96cjAQ/sLMzQ0RmU/zAdH6As+h+FgdcmTFPY2hG6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XZYXJPGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E028DC4CEC5;
	Thu, 26 Sep 2024 08:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727339050;
	bh=qn1S5gIZmj+pt/uixqcwFQeYW2j1CqFYmNJS6MoqW/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XZYXJPGmJP9/1VQAh5fjYjCEW+S51EIRE6ZSDu6enCJgc6L6W9m0aqV4AjauohoNP
	 2aColS5TodmTbBxJOBdt7QXDE9UIAUj1ZWRslIFYDyjb1XyxsZU0o7yX+R7XmpUzxw
	 9Ky8Toazeve5TwhwUpIQgIhyX2pj8K2xu6KAWBaE=
Date: Thu, 26 Sep 2024 10:24:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: greearb@candelatech.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] Revert "vrf: Remove unnecessary RCU-bh critical
 section"
Message-ID: <2024092650-clarify-marshland-1117@gregkh>
References: <20240925185216.1990381-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925185216.1990381-1-greearb@candelatech.com>

On Wed, Sep 25, 2024 at 11:52:16AM -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> This reverts commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853.
> 
> dev_queue_xmit_nit needs to run with bh locking, otherwise
> it conflicts with packets coming in from a nic in softirq
> context and packets being transmitted from user context.
> 
> ================================
> WARNING: inconsistent lock state
> 6.11.0 #1 Tainted: G        W
> --------------------------------
> inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
> btserver/134819 [HC0[0]:SC0[0]:HE1:SE1] takes:
> ffff8882da30c118 (rlock-AF_PACKET){+.?.}-{2:2}, at: tpacket_rcv+0x863/0x3b30
> {IN-SOFTIRQ-W} state was registered at:
>   lock_acquire+0x19a/0x4f0
>   _raw_spin_lock+0x27/0x40
>   packet_rcv+0xa33/0x1320
>   __netif_receive_skb_core.constprop.0+0xcb0/0x3a90
>   __netif_receive_skb_list_core+0x2c9/0x890
>   netif_receive_skb_list_internal+0x610/0xcc0
>   napi_complete_done+0x1c0/0x7c0
>   igb_poll+0x1dbb/0x57e0 [igb]
>   __napi_poll.constprop.0+0x99/0x430
>   net_rx_action+0x8e7/0xe10
>   handle_softirqs+0x1b7/0x800
>   __irq_exit_rcu+0x91/0xc0
>   irq_exit_rcu+0x5/0x10
>   [snip]
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(rlock-AF_PACKET);
>   <Interrupt>
>     lock(rlock-AF_PACKET);
> 
>  *** DEADLOCK ***
> 
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x73/0xa0
>  mark_lock+0x102e/0x16b0
>  __lock_acquire+0x9ae/0x6170
>  lock_acquire+0x19a/0x4f0
>  _raw_spin_lock+0x27/0x40
>  tpacket_rcv+0x863/0x3b30
>  dev_queue_xmit_nit+0x709/0xa40
>  vrf_finish_direct+0x26e/0x340 [vrf]
>  vrf_l3_out+0x5f4/0xe80 [vrf]
>  __ip_local_out+0x51e/0x7a0
> [snip]
> 
> Fixes: 504fc6f4f7f6 ("vrf: Remove unnecessary RCU-bh critical section")
> Link: https://lore.kernel.org/netdev/05765015-f727-2f30-58da-2ad6fa7ea99f@candelatech.com/T/
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
> 
> v2:  Edit patch description.
> 
>  drivers/net/vrf.c | 2 ++
>  net/core/dev.c    | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index 4d8ccaf9a2b4..4087f72f0d2b 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -608,7 +608,9 @@ static void vrf_finish_direct(struct sk_buff *skb)
>  		eth_zero_addr(eth->h_dest);
>  		eth->h_proto = skb->protocol;
>  
> +		rcu_read_lock_bh();
>  		dev_queue_xmit_nit(skb, vrf_dev);
> +		rcu_read_unlock_bh();
>  
>  		skb_pull(skb, ETH_HLEN);
>  	}
> diff --git a/net/core/dev.c b/net/core/dev.c
> index cd479f5f22f6..566e69a38eed 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2285,6 +2285,7 @@ EXPORT_SYMBOL_GPL(dev_nit_active);
>  /*
>   *	Support routine. Sends outgoing frames to any network
>   *	taps currently in use.
> + *	BH must be disabled before calling this.
>   */
>  
>  void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
> -- 
> 2.42.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

