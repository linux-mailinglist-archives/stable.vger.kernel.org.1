Return-Path: <stable+bounces-194573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0138C50EE4
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 08:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D81C1895A6F
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDA62C21CC;
	Wed, 12 Nov 2025 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lNYpv4uu"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D232E285C9F;
	Wed, 12 Nov 2025 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762932539; cv=none; b=NYhlnC8ch6QSL6KqexsyqlWytvIy0+aU/6spxlPw8eKWRyup5RBjR59OV8F6RXa9yBbcqsg2p99LE2uMzIj4m0O382GB4FPO4QeOoT4A9AnoK2jYovpNeLRRyu/CFA2ctM4vYpdO+9cEib7uEDFudMcdnubXWU6PMaXGL4C0jmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762932539; c=relaxed/simple;
	bh=V6wi0kcFw0Q8gGUYw1DFlgX+4CHH6igLN6gf7Xs9mfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFUxt8LpG9PBOWfUUnhWnICHWzXerk/YK4rq9rdZ6ZcypsyoiMdnb/UggHaoytsvx/cWZlvRK8Q/YHBliBFRBrDedaH77I9/YJFgHbbL+w/KqCAFN17o6dFlahtKWnxMS1UkvGrc7F4BMXdx1USj8TuP0Cu3py/cNe10mAi6h10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lNYpv4uu; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F4CC7A01E4;
	Wed, 12 Nov 2025 02:28:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 12 Nov 2025 02:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762932536; x=1763018936; bh=/qRyiDiAt8Ei9aeC9qYnbXqrngQdTyNLTYg
	+pPQSEdY=; b=lNYpv4uuczW9jJ51COZWxybhWMYHt1jnsMOuTNbBjUCB+c///Pq
	tZOQFQ2xr+LxsEAatisVecUuM1vjRoODnMXKjkot7p6NRTEVCLVvCCw31R7SmHgU
	sp2P9SE1HPwWDZHGSGdV82+NbzPe1rFn6W/ptrLzIehk7l3pEFvZ/FWbk45U1IDr
	VASAK90DM/VFhnM1vaUZ4iTKvDF4pe3Jnx8hry5CeSesbiTYzsSELKqd3HguImHn
	g8+lxcj+J60ukdeMY8jXk+DvA3mraKeK26VzHeBslAuycCOd5aDCmsUNliwGn6o3
	3TKhUXWrejyo6zB8GGkj/sCa7revkPnXQlg==
X-ME-Sender: <xms:NzcUaVCIPFnaxmDOyeBkIvxf1XNW4k3BTajYLbYuVLf2RnYIvAKVpA>
    <xme:NzcUaZhhAEQHdeIGnpGj1KlsVs90GzZZaRt7FG9LCEzgtdjZ68EVfQXi015-wGtzm
    MWXGUZNJgsINtk15jM9G6dhGugq_drsxjrzH7Yo1enAA2PcPzL6>
X-ME-Received: <xmr:NzcUabaGuKdvSTjaGpuf4L5iCyojdXmYbGS5YTiAdsY0vgUrOzo7OGvV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdefgeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:NzcUaSnw0vjSTsRlETzAO-f6e9txzJBTexzov_bkv-ajTlSv1vSCdA>
    <xmx:NzcUaZjZ2_KIHPkgLVr9rAP7czoqp57UYhS2_XknATW1q3FC2G1VdA>
    <xmx:NzcUacS7srdZXtMu_XjR68i_0KHfbP7qe2kYO9UOglvF5F0wyVZQcg>
    <xmx:NzcUaSZOytN-o93XqUe2BNWbppfw5msVwglET4mkIgmcRv_igEFAZw>
    <xmx:ODcUaeoyGUVhTGJ-9EHCyB9fs9EJf3a3Ewq0jcW2XYpoXsiCXISEZ9qr>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 02:28:55 -0500 (EST)
Date: Wed, 12 Nov 2025 09:28:53 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Chuang Wang <nashuiliang@gmail.com>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] ipv4: route: Prevent rt_bind_exception() from
 rebinding stale fnhe
Message-ID: <aRQ3NYERGcHJ4rZP@shredder>
References: <20251111064328.24440-1-nashuiliang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111064328.24440-1-nashuiliang@gmail.com>

On Tue, Nov 11, 2025 at 02:43:24PM +0800, Chuang Wang wrote:
> The sit driver's packet transmission path calls: sit_tunnel_xmit() ->
> update_or_create_fnhe(), which lead to fnhe_remove_oldest() being called
> to delete entries exceeding FNHE_RECLAIM_DEPTH+random.
> 
> The race window is between fnhe_remove_oldest() selecting fnheX for
> deletion and the subsequent kfree_rcu(). During this time, the
> concurrent path's __mkroute_output() -> find_exception() can fetch the
> soon-to-be-deleted fnheX, and rt_bind_exception() then binds it with a
> new dst using a dst_hold(). When the original fnheX is freed via RCU,
> the dst reference remains permanently leaked.
> 
> CPU 0                             CPU 1
> __mkroute_output()
>   find_exception() [fnheX]
>                                   update_or_create_fnhe()
>                                     fnhe_remove_oldest() [fnheX]
>   rt_bind_exception() [bind dst]
>                                   RCU callback [fnheX freed, dst leak]
> 
> This issue manifests as a device reference count leak and a warning in
> dmesg when unregistering the net device:
> 
>   unregister_netdevice: waiting for sitX to become free. Usage count = N
> 
> Ido Schimmel provided the simple test validation method [1].
> 
> The fix clears 'oldest->fnhe_daddr' before calling fnhe_flush_routes().
> Since rt_bind_exception() checks this field, setting it to zero prevents
> the stale fnhe from being reused and bound to a new dst just before it
> is freed.
> 
> [1]
> ip netns add ns1
> ip -n ns1 link set dev lo up
> ip -n ns1 address add 192.0.2.1/32 dev lo
> ip -n ns1 link add name dummy1 up type dummy
> ip -n ns1 route add 192.0.2.2/32 dev dummy1
> ip -n ns1 link add name gretap1 up arp off type gretap \
>     local 192.0.2.1 remote 192.0.2.2
> ip -n ns1 route add 198.51.0.0/16 dev gretap1
> taskset -c 0 ip netns exec ns1 mausezahn gretap1 \
>     -A 198.51.100.1 -B 198.51.0.0/16 -t udp -p 1000 -c 0 -q &
> taskset -c 2 ip netns exec ns1 mausezahn gretap1 \
>     -A 198.51.100.1 -B 198.51.0.0/16 -t udp -p 1000 -c 0 -q &
> sleep 10
> ip netns pids ns1 | xargs kill
> ip netns del ns1
> 
> Cc: stable@vger.kernel.org
> Fixes: 67d6d681e15b ("ipv4: make exception cache less predictible")
> Signed-off-by: Chuang Wang <nashuiliang@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

