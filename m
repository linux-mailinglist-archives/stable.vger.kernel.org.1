Return-Path: <stable+bounces-192510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAABBC3608E
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 15:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0FC44F838C
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3578315D5E;
	Wed,  5 Nov 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sJHJqM6N"
X-Original-To: stable@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FB22153D4;
	Wed,  5 Nov 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352518; cv=none; b=eauiiSOepnHLo4hvzdzUj0FO7IVNnedb+wivb42j8WGn6/IJRRfXhIhZb9ierR9qrLRC0aGguJ2Y0egO2T5tjAcmgx+iWq+lhSbV5L3hNqHbGcE6knym1Ujlx+VanrCUhJX8/WQ2GVMiew2ADDdaZnwXXPp5wvzBWhG8qZjOu9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352518; c=relaxed/simple;
	bh=SxiuZYbronbG3fykgcwb0rvkQEyMSA9GdP11JI9AsVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+p2eNZ9tI1GVR8NW+IIw6Mwukt+8CIAAwTEM9MUCjXjLEIcIs0eDZjeI0xKcIf6YpChN5kWbXI5Xn8qxnVuJ3zfA1Al+ioR5PlIwIqXz5SD8iIGSwl9oCSS7pOHetXGpXAUguaUPgrveahyMt/I+O9+U2F3VrqkS5FPI7+gAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sJHJqM6N; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E95BEC0295;
	Wed,  5 Nov 2025 09:21:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 05 Nov 2025 09:21:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762352515; x=1762438915; bh=IhCa+OykCWBTIFkdHubkKBveQj0ktKP02Y4
	4KQl80GE=; b=sJHJqM6NmdZZvd0+Lv26aV+9S5bpEy0bGB1Sf5kWnpWRfWOWdO3
	5ORwLbIQesxDQzGwHCSuwOLUY8u2dzXqfSWDWF1Dna5Nsn3sKjGqZA4EvEdVr0UC
	AyiP/WQYCjwTdlHCLad0zufUR1PysWxaIbTQiZ94LirJaUUs8/m6BWb+q867H7Qq
	siT9wFLw/0hX8+iG+JF7kVQDxnSZwIxGWqfAQbMqWWTP912PP8HbYCSFHyU4i6LR
	DkLHEytXXPWvs1xKMQN1hClLIvcsJmvtgmideZhwzekDikXoI+XLijFrRLziFS6l
	5I0zoLpBETqbLLPArelk6HdiOW9N5wYVq7w==
X-ME-Sender: <xms:gl0LadT4BQxfQNKsXjaRVGiqhdZsIU73YAhYYsePfZgst33Iz0jQ8A>
    <xme:gl0Laczhi5BNn70_gzzELkABEHwZW7EtjB7cIl6rhK0TB0PXx2KNqKWjXWRmdGbmT
    hyWfFuid3C07jIIo4FbEa_GN3iXQwqhsP_t25ZSE6TpugLGDAw>
X-ME-Received: <xmr:gl0LadrUPNy3pRCo98HYw7LVK6C7LhVtmz8TAN46a96BQxRKsnXhhNDB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeggefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguoh
    hstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehnrghshhhuihhlihgrnhhgsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegushgrhhgvrh
    hnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:gl0LaX2NjHQqm2TYUpl3gybeAu3o75XW50crVAnGsBPLV5hYMVAKNQ>
    <xmx:gl0LaVxOrUXSMDMoykQCuSS3YGeV1Q9kABXascopgdZXvqcZrzs7uA>
    <xmx:gl0LaTiLecYGBdNMrAS6g_vCc-S7c7wJJm6WkKHvfPBHa3ijKIZ5bA>
    <xmx:gl0LaYrawpP4dbjootVBBIiFjlCvKNPRJZ8R7usnsrBWgUqKyPThYw>
    <xmx:g10Lab4x3Av1aZitj4tWNDWssmFe_AeTbT4taPIQzSan2AuiozpDEY_A>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 09:21:54 -0500 (EST)
Date: Wed, 5 Nov 2025 16:21:52 +0200
From: Ido Schimmel <idosch@idosch.org>
To: chuang <nashuiliang@gmail.com>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Networking <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] ipv4: route: Prevent rt_bind_exception() from
 rebinding stale fnhe
Message-ID: <aQtdgLFnZ7Qjsnjw@shredder>
References: <CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com>

On Tue, Nov 04, 2025 at 11:09:08AM +0800, chuang wrote:
> From 35dbc9abd8da820007391b707bd2c1a9c99ee67d Mon Sep 17 00:00:00 2001
> From: Chuang Wang <nashuiliang@gmail.com>
> Date: Tue, 4 Nov 2025 02:52:11 +0000
> Subject: [PATCH net] ipv4: route: Prevent rt_bind_exception() from rebinding
>  stale fnhe

I'm unable to apply the patch:

$ b4 am -o - CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com | git am
[...]
Applying: ipv4: route: Prevent rt_bind_exception() from rebinding stale fnhe
error: corrupt patch at line 10
Patch failed at 0001 ipv4: route: Prevent rt_bind_exception() from rebinding stale fnhe

Did you use git send-email?

> 
> A race condition exists between fnhe_remove_oldest() and
> rt_bind_exception() where a fnhe that is scheduled for removal can be
> rebound to a new dst.
> 
> The issue occurs when fnhe_remove_oldest() selects an fnhe (fnheX)
> for deletion, but before it can be flushed and freed via RCU,
> CPU 0 enters rt_bind_exception() and attempts to reuse the entry.
> 
> CPU 0                             CPU 1
> __mkroute_output()
>   find_exception() [fnheX]
>                                   update_or_create_fnhe()
>                                     fnhe_remove_oldest() [fnheX]
>   rt_bind_exception() [bind dst]
>                                   RCU callback [fnheX freed, dst leak]
> 
> If rt_bind_exception() successfully binds fnheX to a new dst, the
> newly bound dst will never be properly freed because fnheX will
> soon be released by the RCU callback, leading to a permanent
> reference count leak on the old dst and the device.
> 
> This issue manifests as a device reference count leak and a
> warning in dmesg when unregistering the net device:
> 
>   unregister_netdevice: waiting for ethX to become free. Usage count = N

Can you say more about how you debugged this? It seems like a very rare
race condition. I expect netdevice_tracker to only show that a dst entry
took a reference on the net device, but it wouldn't show who took a
reference on the dst entry.

> 
> Fix this race by clearing 'oldest->fnhe_daddr' before calling
> fnhe_flush_routes(). Since rt_bind_exception() checks this field,
> setting it to zero prevents the stale fnhe from being reused and
> bound to a new dst just before it is freed.

Seems safe given that both fnhe_remove_oldest() and rt_bind_exception()
access 'fnhe_daddr' while holding 'fnhe_lock'. Same trick was used in
commit ee60ad219f5c ("route: set the deleted fnhe fnhe_daddr to 0 in
ip_del_fnhe to fix a race").

> 
> Cc: stable@vger.kernel.org
> Fixes: 67d6d681e15b ("ipv4: make exception cache less predictible")
> Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> ---
>  net/ipv4/route.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 6d27d3610c1c..b549d6a57307 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -607,6 +607,11 @@ static void fnhe_remove_oldest(struct
> fnhe_hash_bucket *hash)
>                         oldest_p = fnhe_p;
>                 }
>         }
> +
> +       /* Clear oldest->fnhe_daddr to prevent this fnhe from being
> +        * rebound with new dsts in rt_bind_exception().
> +        */
> +       oldest->fnhe_daddr = 0;
>         fnhe_flush_routes(oldest);
>         *oldest_p = oldest->fnhe_next;
>         kfree_rcu(oldest, rcu);
> --
> 

