Return-Path: <stable+bounces-192847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34809C44183
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 16:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E0B34E45D8
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 15:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0992D595A;
	Sun,  9 Nov 2025 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/WDc6+6"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D0F1ACEDE;
	Sun,  9 Nov 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762703317; cv=none; b=Zjj7kC7/TN+96cPdcbATXMZKfC6lXPZA3kapStSfdgBqZlk+Fe0NsBUwL2stz/8DZ9sP2xdCN/NSlbJJo1KeXD5KfGVecTZfMFsc2iHpEyfuTCzbz78JL+zPyx1HyOXVKJgzZ60d9LmlRLMCoMTkvCVPebRyqL4vdhyPh/UPrqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762703317; c=relaxed/simple;
	bh=ofI0MhvTfEk58ryGBbMza+D+MAOY61wnhQ4VuePQ77k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBc9AI0yjG+QVfhYRSSxIloabuyKEyM9jiZV1Sqt5iy5hLXadyK8EVROVrRLI91QstEznD97ygHGHAuuy+icDhPdgjMyRQmd4vghvwYKrkgzwKg0+SuU2hI6uoMAV7ySCXkXEyE7DA88JU8C5kUqBMb+lfQmKjwNBwZ4xyY1UJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m/WDc6+6; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7FC547A018B;
	Sun,  9 Nov 2025 10:48:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 09 Nov 2025 10:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762703314; x=1762789714; bh=b+2LS7UCVaJe+CkDjanB6mvOORphIKM3fSv
	R3+Jtl7g=; b=m/WDc6+6Ro7dPcZjTxoWToWtcC6+jCfGm1WCf9pfjxwUwr/FSIW
	ewwYpj/+b0hfTkrVWKFGDUQ8aBRGxecM6+NQi78orICQUU15IPH88PlejFxUdI3Z
	JP5VYWWsp5nBsS7PZMQDmslWBdNyKsXjdnmZ9cOfYE0ROTzXOw0mebxoOJbcx2f/
	sIhS2rGUSiK29B5fj08os3kzX6c0ScV34HZbd6mB5NYiktwJtRfrbb+HlijGg4/D
	LWv5WRoWIDlLPYLngj+pmmpq94Ve6/GSBQ1IBNLQRsH6yHOcF8KBS+2ObU3P3QPQ
	9gBd9M+9PAz7y3vXZJRqKnsr/J5Jk++g5ig==
X-ME-Sender: <xms:0bcQae_e3WGflVVSw6wgF5b1q0udnz4V_7AKQ5buBPLugluMIE6bFQ>
    <xme:0bcQaUsdGaGvojj7H7zqQuQBP5-bKF8iWwRNsg4-82zPRHj7tKznBrSV5R_D5nV0h
    q7belR1u3gS9F7wY-gJSb7Cf_Agl83B8uhWdUGS4Qt5FO2EgM0>
X-ME-Received: <xmr:0bcQae1D58Z-DS5yoeqjt1Q4enrN0_5bJRULSrIEHFJ5qZpWNsbMBj2u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleehkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeggefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguoh
    hstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehnrghshhhuihhlihgrnhhgsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehs
    thgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:0bcQaZTqbF4U0xtsNyb9PrPJ1IwbYMZCo1HUi7nxocyXI9YgH9SIJw>
    <xmx:0bcQaSebCzE5oqautVHpqLaRTT2tNMMzqCMXkAkZxdbU9rqV2TmXiA>
    <xmx:0bcQaaefwouKTn0pshTixXGInNlIUboMHgJj1iNuQ-umZZw2FeHfhQ>
    <xmx:0bcQac1HkFTIWwqANPmjJoWVL1geH0zMorSL3tc605Bz5VP88GdRKw>
    <xmx:0rcQafXc5DBJSQeGw6k_b44OBj9tTKc4FQ2KrPDvb50a4o_kWilFK3eY>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Nov 2025 10:48:33 -0500 (EST)
Date: Sun, 9 Nov 2025 17:48:31 +0200
From: Ido Schimmel <idosch@idosch.org>
To: chuang <nashuiliang@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Networking <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] ipv4: route: Prevent rt_bind_exception() from
 rebinding stale fnhe
Message-ID: <aRC3zxmpOXXDqSX2@shredder>
References: <CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com>
 <CANn89iL9e9TZoOZ8KG66ea37bo=WztPqRPk8A9i0Ntx2KidYBw@mail.gmail.com>
 <aQtubP3V6tUOaEl5@shredder>
 <CACueBy6LKYmusLjQPnQGCoSZQLEVAo5_X47B-gaH-2dSx6xDuw@mail.gmail.com>
 <CACueBy4EAuBoHDQPVSg_wdUYXYxQzToRx4Y+TSgcBwxEcODt_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACueBy4EAuBoHDQPVSg_wdUYXYxQzToRx4Y+TSgcBwxEcODt_w@mail.gmail.com>

On Fri, Nov 07, 2025 at 05:53:51PM +0800, chuang wrote:
> Thanks for reviewing the patch. I'm providing the detailed analysis
> and debugging traces below to confirm the root cause and exact
> location of the reference count leak.
> 
> 1. Environment and Symptom
> 
> The issue was consistently reproduced when routing TCP traffic through
> a Software IP Tunnel interface (sit0). The traffic flow  is:
> 
>   APP -> sit0 (IP tunnel) -> outside
> 
> This leads to a reference count leak that prevents the device from
> being freed during unregistration, resulting in the kernel log
> warning:
> 
>   unregister_netdevice: waiting for sit0 to become free. Usage count = N
> 
> 2. Enable refcnt_tracer
> 
> Live-crash analysis identified a stale dst entry retaining a reference
> to sit0. With CONFIG_NET_DEV_REFCNT_TRACKER enabled, the allocation
> stack for the leaked reference was identified:
> 
> [1279559.416854] leaked reference.
> [1279559.416955]  dst_init+0x48/0x100
> [1279559.416965]  dst_alloc+0x66/0xd0
> [1279559.416966]  rt_dst_alloc+0x3c/0xd0
> [1279559.416974]  ip_route_output_key_hash_rcu+0x1d7/0x940
> [1279559.416978]  ip_route_output_key_hash+0x6d/0xa0
> [1279559.416979]  ip_route_output_flow+0x1f/0x70
> [1279559.416980]  __ip_queue_xmit+0x415/0x480
> [1279559.416984]  ip_queue_xmit+0x15/0x20
> [1279559.416986]  __tcp_transmit_skb+0xad4/0xc50
> 
> 3. Pinpointing the Unmatched dst_hold()
> 
> To pinpoint the specific reference not released, we added tracepoints
> to all dst_hold/put functions and used eBPF to record the full
> lifecycle. The tracing identified a hold operation with the following
> call stack:
> 
> do_trace_dst_entry_inc+0x45
> rt_set_nexthop.constprop.0+0x376      /* <<<<<<<<<<<<<<<<<<<< HERE */
> __mkroute_output+0x2B7
> ip_route_output_key_hash_rcu+0xBD
> ip_route_output_key_hash+0x6D
> ip_route_output_flow+0x1F
> inet_sk_rebuild_header+0x19C
> __tcp_retransmit_skb+0x7E
> tcp_retransmit_skb+0x19
> tcp_retransmit_timer+0x3DF
> 
> The address rt_set_nexthop.constprop.0+0x376 corresponds to the
> dst_hold() call inside rt_bind_exception().
> 
> 4. Root Cause Analysis
> 
> The sit driver's packet transmission path calls: sit_tunnel_xmit() ->
> ... -> update_or_create_fnhe(), which lead to fnhe_remove_oldest()
> being called to delete entries exceeding the
> FNHE_RECLAIM_DEPTH+random.
> 
> The race window is between fnhe_remove_oldest() selecting fnheX for
> deletion and the subsequent kfree_rcu(). During this time, the
> concurrent path's __mkroute_output() -> find_exception() can fetch the
> soon-to-be-deleted fnheX, and rt_bind_exception() then binds it with a
> new dst using a dst_hold(). When the original fnheX is freed via RCU,
> the dst reference remains permanently leaked.
> 
> 5. Fix Validation with eBPF
> 
> The patch mitigates this by zeroing fnhe_daddr before the
> RCU-protected deletion steps. This prevents rt_bind_exception() from
> attempting to reuse the entry.
> The fix was validated by probing the rt_bind_exception path (which in
> my environment is optimized to rt_set_nexthop.constprop.0) to catch
> any zeroed but active FNHEs being processed:
> 
> bpftrace -e 'kprobe:rt_set_nexthop.constprop.0
> {
>     $rt = (struct rtable *)arg0;
>     $fnhe = (struct fib_nh_exception *)arg3;
>     $fi = (struct flowi *)arg4;
> 
>     /* Check for an FNHE that is marked for deletion (daddr == 0)
>      * but is still visible/valid (fnhe_expires != 0 and not expired).
>      */
>     if ($fi != 0 && $fnhe != 0 && $fnhe->fnhe_daddr == 0 &&
> $fnhe->fnhe_expires != 0 && $fnhe->fnhe_expires >= jiffies) {
>         printf("rt: %llx, dev: %s, will leak before this patch\n",
> $rt, $rt->dst.dev->name);
>     }
> }'

Thanks for the details. I was able to reproduce the issue with [1] and I
can confirm that it does not reproduce with your fix.

Are you going to submit v2?

[1]
#!/bin/bash

ip netns add ns1
ip -n ns1 link set dev lo up
ip -n ns1 address add 192.0.2.1/32 dev lo
ip -n ns1 link add name dummy1 up type dummy
ip -n ns1 route add 192.0.2.2/32 dev dummy1
ip -n ns1 link add name gretap1 up arp off type gretap local 192.0.2.1 remote 192.0.2.2
ip -n ns1 route add 198.51.0.0/16 dev gretap1
taskset -c 0 ip netns exec ns1 mausezahn gretap1 -A 198.51.100.1 -B 198.51.0.0/16 -t udp -p 1000 -c 0 -q &
taskset -c 2 ip netns exec ns1 mausezahn gretap1 -A 198.51.100.1 -B 198.51.0.0/16 -t udp -p 1000 -c 0 -q &
sleep 10
ip netns pids ns1 | xargs kill
ip netns del ns1

