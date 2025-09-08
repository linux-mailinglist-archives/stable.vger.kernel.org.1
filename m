Return-Path: <stable+bounces-178966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B89B49B34
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 22:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D547AD3FD
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 20:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19DD2DA779;
	Mon,  8 Sep 2025 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="SfRhTp1a"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D1B22A4EA
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757364449; cv=none; b=BX5imWE6orAJhcr8H6wXqPZ7xpqJZaHbw/PeskUYe2XqkW2UKSf3fxMj1Opu+VqNF5GZSEoaU0TmM2rb2FpRBhiQr2vHOhU1oAMPOUoozhmxcLdgSY2fiZYXHpteqN62rDphhks1oFGtu2xr33snnoVzXU81G2nMLS7K0If0pyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757364449; c=relaxed/simple;
	bh=YKKxSwyTIBd9mjDB+qKz1REMUGLWEBaGpgrm4p7F3mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzOx5p9OeWN3R8pBOxTKq9czHqzyCFCARlV4T+b1v4J18PMGwjcsY2T5KNXogv9l2fYBdF5p6NSTwmsQPOxufur1VeeK9QLXPiQ1oMmBY70wsdOOKXfEdcpftdFaR5ZonY/9jQ79SscPjbMK2K4Ny4a1qM7booHMrLtwsnxLzco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=SfRhTp1a; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24cde6c65d1so35786865ad.3
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 13:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1757364447; x=1757969247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iP4tQG17FxLA2u0B9bKbrzzkdZjZOjWIZIzpoM1+rjA=;
        b=SfRhTp1aWjGGnwudzM5EvCXwKyCAuJXLLzkSQGnXiLKEV+Pjfq1Rl4V47GJSuUmV+V
         74XKiDVO4QgWRL/bUY+4B5UfD0P5WKmC5pPn5uUKrYRyD0nFg18An+xSQF4XwgZP00I+
         9KBmTZWaahFdBb7dAjOqdpTdrbysmCx6S2VVTr5rqCOpOlBOUKxA5Gbe3AO5CSM3W4Qt
         7xv1X7W5aqHITbM7WlJ/JtbMRCh1pAqzVX2FpUPoIBstmPbrMRo7hu/RL3o9/DxxuyP0
         J4a3y4KrvQVSRn6otixitQGzz8P1AWGKxKlemIFWUeIpvB1c2MC/Wl7Yta2TkHV6D9hw
         OvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757364447; x=1757969247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iP4tQG17FxLA2u0B9bKbrzzkdZjZOjWIZIzpoM1+rjA=;
        b=ec9yQWYTEWoRMOjyACRjiTNdM+MgdbRCbKxJy4NF2BD0xZWBMkyN6ANwXJaJrB5wmj
         exEYkDK6izdhMeULyKUspXCb71XKkzaTPsFphSvPV3Fr0SNR8Ofl3epjr31+p5E1uBK5
         Fj4UE6cwKqdGRuvA/Pbx44njF3RVN5jW2isF3BMU0gqmbgUJGEx5BI1YWenVQOXu/9zX
         c4yQydXoCfoZRBAVMU5F8q4cU1G7hIsLIiVZ4IqzCaej/vCgQh/mbhBM4wjSrZ5UDKL2
         oiRVR7iC+4GfUyTXSYzyOxt+choMHDcqH2bnqk2PyaSeyzjxXdcQrLfRL4buHFIG0oqp
         3Mvg==
X-Forwarded-Encrypted: i=1; AJvYcCV7prVLazIdWIqLN68ZykGRT1Xmiy1a/KjisUNa+ypL0OxvgatTKSg4dOqaxQ7KIfKDZsFCYxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWqoRw8/IQhxMOsi8BSx2JXIOQvFG6UQ4Kc7WovxDAJpZew5yY
	VPh3OK+hvrD8t6QRBbibmZiuhvcKY5dsj831/HHTJnzm8q7b5azxoIB9D7WKAd3PQiA=
X-Gm-Gg: ASbGnctqflWY9s8pchGmz1CWobsxHhn1BZWQN+AB4GQKZSNoe8bYRAcSp2EBZEHYnF9
	Z0je3A/kN+j+7653KMRP+QKaEtYo4R4GshIjC/fh4tFIq10y0rE91gR5AxGJo3TTLYcypcj/AgF
	6tVp4vjfB8WuRU53KWm5Cqdz8ZmGA5qTV+JUId2Q9PSmBngM92ISMvVqUnibGM8E/cmGBx1Cj/h
	KWUs1chDtfCNJejNG626+5dBqkcv91NAMP3ieSE676UJj9DjPE+pyGwnzQltc8RWPUSJoWRrmjF
	afxu9T4OZ8vi2vKJj24WvfbvH2SLweHiLjT5cP7yFnOrORxfd0YX89FBK3kHCswGRJOj4uRqiAW
	PShR/EpKjzmTUtO4V1S+zGEyQ3CxF9rM82to=
X-Google-Smtp-Source: AGHT+IEFBuInL+DneJcr3VRDS17E6y4PwmSKDTAiiJ6BGt+ppjgTDkzNHMg5bs1Pf238HenN9lXafg==
X-Received: by 2002:a17:903:2286:b0:24a:f7dc:caa3 with SMTP id d9443c01a7336-251715f33f7mr111877765ad.37.1757364447508;
        Mon, 08 Sep 2025 13:47:27 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccd655823sm119166405ad.114.2025.09.08.13.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 13:47:27 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:47:24 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	asantostc@gmail.com, efault@gmx.de, kernel-team@meta.com,
	stable@vger.kernel.org, jv@jvosburgh.net
Subject: Re: [PATCH net v3 1/3] netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Message-ID: <aL9A3JDyx3TxAzLf@mozart.vkv.me>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
 <20250905-netconsole_torture-v3-1-875c7febd316@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905-netconsole_torture-v3-1-875c7febd316@debian.org>

On Friday 09/05 at 10:25 -0700, Breno Leitao wrote:
> commit efa95b01da18 ("netpoll: fix use after free") incorrectly
> ignored the refcount and prematurely set dev->npinfo to NULL during
> netpoll cleanup, leading to improper behavior and memory leaks.
> 
> Scenario causing lack of proper cleanup:
> 
> 1) A netpoll is associated with a NIC (e.g., eth0) and netdev->npinfo is
>    allocated, and refcnt = 1
>    - Keep in mind that npinfo is shared among all netpoll instances. In
>      this case, there is just one.
> 
> 2) Another netpoll is also associated with the same NIC and
>    npinfo->refcnt += 1.
>    - Now dev->npinfo->refcnt = 2;
>    - There is just one npinfo associated to the netdev.
> 
> 3) When the first netpolls goes to clean up:
>    - The first cleanup succeeds and clears np->dev->npinfo, ignoring
>      refcnt.
>      - It basically calls `RCU_INIT_POINTER(np->dev->npinfo, NULL);`
>    - Set dev->npinfo = NULL, without proper cleanup
>    - No ->ndo_netpoll_cleanup() is either called
> 
> 4) Now the second target tries to clean up
>    - The second cleanup fails because np->dev->npinfo is already NULL.
>      * In this case, ops->ndo_netpoll_cleanup() was never called, and
>        the skb pool is not cleaned as well (for the second netpoll
>        instance)
>   - This leaks npinfo and skbpool skbs, which is clearly reported by
>     kmemleak.
> 
> Revert commit efa95b01da18 ("netpoll: fix use after free") and adds
> clarifying comments emphasizing that npinfo cleanup should only happen
> once the refcount reaches zero, ensuring stable and correct netpoll
> behavior.

This makes sense to me.

Just curious, did you try the original OOPS reproducer?
https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/

I wonder if there might be a demon lurking in bonding+netpoll that this
was papering over? Not a reason not to fix the leaks IMO, I'm just
curious, I don't want to spend time on it if you already did :)

The discussion on v1 isn't enlightening either:
https://lore.kernel.org/lkml/0f692012238337f2c40893319830ae042523ce18.1404172155.git.decot@googlers.com/

Thanks,
Calvin

> Cc: stable@vger.kernel.org
> Cc: jv@jvosburgh.net
> Fixes: efa95b01da18 ("netpoll: fix use after free")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/core/netpoll.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index 5f65b62346d4e..19676cd379640 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -815,6 +815,10 @@ static void __netpoll_cleanup(struct netpoll *np)
>  	if (!npinfo)
>  		return;
>  
> +	/* At this point, there is a single npinfo instance per netdevice, and
> +	 * its refcnt tracks how many netpoll structures are linked to it. We
> +	 * only perform npinfo cleanup when the refcnt decrements to zero.
> +	 */
>  	if (refcount_dec_and_test(&npinfo->refcnt)) {
>  		const struct net_device_ops *ops;
>  
> @@ -824,8 +828,7 @@ static void __netpoll_cleanup(struct netpoll *np)
>  
>  		RCU_INIT_POINTER(np->dev->npinfo, NULL);
>  		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
> -	} else
> -		RCU_INIT_POINTER(np->dev->npinfo, NULL);
> +	}
>  
>  	skb_pool_flush(np);
>  }
> 
> -- 
> 2.47.3
> 

