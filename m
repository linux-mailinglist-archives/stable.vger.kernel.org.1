Return-Path: <stable+bounces-77766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE291986F7F
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 11:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4511F24851
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 09:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450A14F114;
	Thu, 26 Sep 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPzSo8Mg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE63208CA;
	Thu, 26 Sep 2024 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341409; cv=none; b=VKA7ENyHCWDEQ7qCJIYeFlQpDYyOYR4f/ZmaiAU2FmjwvpKIW4EByMZ6Rq+hJrQL/QbxQflzH3T3+mwftR2paSUegeMb03OHTJI0OT0g+e0RAyLLW1kyWcUcAcsvQbLgMO56Z8fQG1HYI0bCN7DoHTJKF0BSIQJnc2jNwKhoQfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341409; c=relaxed/simple;
	bh=QezUp3up9aGfm6XQYxPn4r6YhYq7yOsFsc758SdgH/k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GJIwvJROlg4crAT0EMUN3o1D1Nqbj1pXA3np9nyYcz8vSzddCJeK8G7R/gV5EXI025GMI0eqqrU5Vwxn4dQg98I3iUWkB4x53ewVhKU59NrVIwk29CKwZoojlZAVvI8nfwp9KnoCvgeWbGHySJb0xHUmZIV8hErDad3cN55ixw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPzSo8Mg; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cb2f272f8bso5931126d6.0;
        Thu, 26 Sep 2024 02:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727341406; x=1727946206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PqKakWFtLrml0Pz1RbNpMoeVC5nlzibYlr2AvtSgE4=;
        b=KPzSo8MgmngILWoD2Ovlm9nyyORTwmBc4fwMhrKRCm+iU9Q6o0HH2VSsldGFQYg9lk
         YZQC10khyjT/3mrfcJY55FBDgtTAtC30ujhE/DgyNBa0+7dVCYnBpVQN7Y5+hHxNffTC
         a7TxHC5VmOskar2zdacmDN1EPK5EwOTqJ7rGiuk7a1GbJCf/98uV7v8g65WUtcQWMutl
         qUsCppdbluW2EKQ16sEYZgzPENCWnYGzkX6+Y71OFD5SPcjDZ8Tt5nWWY3HLpp8cCjd0
         3j2+7kjpt+x28KgPolHTnkrY8FIV9TTW9desGeK7zc36KNR/vCNOJB0EvT8RK4YxJbAg
         EtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727341406; x=1727946206;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2PqKakWFtLrml0Pz1RbNpMoeVC5nlzibYlr2AvtSgE4=;
        b=Gp8ClNTiRAp8XYt57XLBORnRR8q1xPd3yr2So2B60c1agb/4NoOxaVQ0qVDXcPggOm
         KabKpERSxDFqS0Wd2frHdtx8pbc5jYpD9KkEhf7O/mssnA9Jha0sBOGn1douRMltutjl
         VNqwsmUyUNnSNzSbjE8ZecK0pfdmeRwq5NiqMQXbMuxFGlh6eo90/ZuGb09Lnrlhgv2N
         8+glKpHsLIUxrItfvqg05MeZ4NCpqUtkyM1mjMc4aZKXjbcv4Wic0FRvEZdk4fGzuCqP
         iDw/kRgmFDSaUoyOa33V+0trQDTmSGC+NJUm8zKRcBzj6WszkwIuLIODZs8pkEV2Plkx
         H2Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXie8snW+2suFl6NFW+t3t3qZNqC6loHCkWOyP4I5N0y9aAZb7LS8rh7IzJFNDqTHgavZIsb3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUzzOFotHiTQaLwP/xEJtvPhI5cvDZikxCoEepoyqPRR4aJKIU
	3TVdbixDIJZeywmASlat3oxwnSHsrVBYL7ebO7y7/zdNkeWTuWC39F4l2+UI
X-Google-Smtp-Source: AGHT+IGF2+kPmXLBLxRtRhHiW3xdkTbngOpPdkeg11EPZmUDM5s1DOyrTejOLPxnkqYdSS7z7G92dg==
X-Received: by 2002:a05:6214:5d87:b0:6c3:5af7:4a2 with SMTP id 6a1803df08f44-6cb1ddef39fmr61701156d6.35.1727341406397;
        Thu, 26 Sep 2024 02:03:26 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4bf5a2sm24033026d6.38.2024.09.26.02.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:03:25 -0700 (PDT)
Date: Thu, 26 Sep 2024 05:03:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: greearb@candelatech.com, 
 netdev@vger.kernel.org
Cc: stable@vger.kernel.org, 
 Ben Greear <greearb@candelatech.com>
Message-ID: <66f5235d14130_8456129436@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240925185216.1990381-1-greearb@candelatech.com>
References: <20240925185216.1990381-1-greearb@candelatech.com>
Subject: Re: [PATCH v2] Revert "vrf: Remove unnecessary RCU-bh critical
 section"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

greearb@ wrote:
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

Please Cc: all previous reviewers and folks who participated in the
discussion. I entirely missed this. No need to add as Cc tags, just
--cc in git send-email will do.

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

Unnecessary. Especially patches for stable should be minimal to
reduce the chance of conflicts.



