Return-Path: <stable+bounces-192522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D944CC366E9
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 16:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3A5850051F
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 15:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A393534D3A7;
	Wed,  5 Nov 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I3PZw45I"
X-Original-To: stable@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A418634D3A3;
	Wed,  5 Nov 2025 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356849; cv=none; b=Dp4pGhXAhDKRK0qx+uCJfu5d+yrNMu72oaUoKgXF1lOBgXEG48M5BOqUwURiOADHcUadf1eseaQbindoV7vEryhaGHumSRa+07JKR6M9j07kaKk54XLk1jY0F5s/JVubhhNGT+nALuEKThWwZZxktBwV6kdJ0fRIfcbAJbwi4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356849; c=relaxed/simple;
	bh=q+pKX+WhfAfQqw04jCOiyV2QiE94kOQ3AGUO+2KwESE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buPs0KMU+EB6RJZ728/povfSMhszcSiX5SD0vg2WyYcCmVkn49WkQX9dyId9SoMLCab29vfDwjScP/Bt6+Evp8J1WrH1Ldq2oxyLDBs2mKzgbYvNzvQomqoHVquCNJZd+rlJM71eEZspccqMI77dvGEUBFTTKuxuPA9Thqurbi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I3PZw45I; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9FCE7EC02F2;
	Wed,  5 Nov 2025 10:34:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 05 Nov 2025 10:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762356846; x=
	1762443246; bh=81MCj8OUaFvyq48DpTXhMDinPzHeqGz4DiYX34tUCmM=; b=I
	3PZw45Ib2sDjlos/Hc8aftidxUXcYKgMIJRN7FOQQUZlKIrdzo9QV+9euEzullQO
	hasGXMDkUTXak0OjcjY6QAASEQB8h1EtRwjmTgU2z8lXtkDoTMK1JYumkOWBK0N6
	Cyc7dwauoYt7S4KGAdRh4q1Lesyb4aTHncw171Nh8qaXWStu4HVgFzBdbDgKAfu0
	xeZj7kD34OgVWW02fMztF8CHOW/E6c0OmwBMbXKGmd2svcHBhnHtHHfrRsAkM7EH
	Ln+2GJqqaP9YqFSWyOWBwodi1SyYP3snc6Ha+SPQc+1raLjaoqdZ5GbL7EyXPZvm
	30EDwVtz7vfvMzGtqK3tg==
X-ME-Sender: <xms:bm4LaR9c6LIbe3vUvU3_sexr17fvFszcV3uDmEV80gYJium8b4WFhw>
    <xme:bm4LabuKSZfru6pjhHKNFBdBWY6rsIB07QJpTN3DyfeCPfUH0Pn7RmoHOZZgsTh7i
    I8M2glb0jeRnVxEZb26khb58S-c2fsChOBpNUabP6JQlcizfRA>
X-ME-Received: <xmr:bm4LaZ18GB_fwrZ3EOaIbgHTctbDMCVkHCDDza0b2lh66WC5yRWcDYX5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeekgefggefhuedvgeettdegvdeuvdfhudejvddvjeetledvuedtheehleelhffh
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehnrghshhhuihhlihgrnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:bm4LaYQtkAYcPa6_LitcGq9lpsX4IXDXc8a-xWacdABYu5evsIalFg>
    <xmx:bm4LaVe7ckvxyBJAXZGpmLtPStP-rzRPR6AEP7kekEmoa6gyIfMa1g>
    <xmx:bm4LaRd01rxHakIgX0zaV4xXXZI_TB_yELZZ6LGs5WXU48QQ1VJSqA>
    <xmx:bm4LaX1bHgJ_ol8mD0uOMaQ0bIkjTgVNETGakhfITZW9PTbKfTnwFA>
    <xmx:bm4LaeVRQT01S7ZlW574EsGbRj2X4bPUBzwnhYbQ5s0uht22-doXWv3W>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 10:34:05 -0500 (EST)
Date: Wed, 5 Nov 2025 17:34:04 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Eric Dumazet <edumazet@google.com>
Cc: chuang <nashuiliang@gmail.com>, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Networking <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] ipv4: route: Prevent rt_bind_exception() from
 rebinding stale fnhe
Message-ID: <aQtubP3V6tUOaEl5@shredder>
References: <CACueBy7yNo4jq4HbiLXn0ez14w8CUTtTpPHmpSB-Ou6jhhNypA@mail.gmail.com>
 <CANn89iL9e9TZoOZ8KG66ea37bo=WztPqRPk8A9i0Ntx2KidYBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iL9e9TZoOZ8KG66ea37bo=WztPqRPk8A9i0Ntx2KidYBw@mail.gmail.com>

On Wed, Nov 05, 2025 at 06:26:22AM -0800, Eric Dumazet wrote:
> On Mon, Nov 3, 2025 at 7:09 PM chuang <nashuiliang@gmail.com> wrote:
> >
> > From 35dbc9abd8da820007391b707bd2c1a9c99ee67d Mon Sep 17 00:00:00 2001
> > From: Chuang Wang <nashuiliang@gmail.com>
> > Date: Tue, 4 Nov 2025 02:52:11 +0000
> > Subject: [PATCH net] ipv4: route: Prevent rt_bind_exception() from rebinding
> >  stale fnhe
> >
> > A race condition exists between fnhe_remove_oldest() and
> > rt_bind_exception() where a fnhe that is scheduled for removal can be
> > rebound to a new dst.
> >
> > The issue occurs when fnhe_remove_oldest() selects an fnhe (fnheX)
> > for deletion, but before it can be flushed and freed via RCU,
> > CPU 0 enters rt_bind_exception() and attempts to reuse the entry.
> >
> > CPU 0                             CPU 1
> > __mkroute_output()
> >   find_exception() [fnheX]
> >                                   update_or_create_fnhe()
> >                                     fnhe_remove_oldest() [fnheX]
> >   rt_bind_exception() [bind dst]
> >                                   RCU callback [fnheX freed, dst leak]
> >
> > If rt_bind_exception() successfully binds fnheX to a new dst, the
> > newly bound dst will never be properly freed because fnheX will
> > soon be released by the RCU callback, leading to a permanent
> > reference count leak on the old dst and the device.
> >
> > This issue manifests as a device reference count leak and a
> > warning in dmesg when unregistering the net device:
> >
> >   unregister_netdevice: waiting for ethX to become free. Usage count = N
> >
> > Fix this race by clearing 'oldest->fnhe_daddr' before calling
> > fnhe_flush_routes(). Since rt_bind_exception() checks this field,
> > setting it to zero prevents the stale fnhe from being reused and
> > bound to a new dst just before it is freed.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 67d6d681e15b ("ipv4: make exception cache less predictible")
> 
> I do not see how this commit added the bug you are looking at ?

Not the author, but my understanding is that the issue is that an
exception entry which is queued for deletion allows a dst entry to be
bound to it. As such, nobody will ever release the reference from the
dst entry and the associated net device.

Before 67d6d681e15b, exception entries were only queued for deletion by
ip_del_fnhe() and it prevented dst entries from binding themselves to
the deleted exception entry by clearing 'fnhe->fnhe_daddr' which is
checked in rt_bind_exception(). See ee60ad219f5c7.

67d6d681e15b added another point in the code that queues exception
entries for deletion, but without clearing 'fnhe->fnhe_daddr' first.
Therefore, it added another instance of the bug that was fixed in
ee60ad219f5c7.

> 
> > Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
> > ---
> >  net/ipv4/route.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> > index 6d27d3610c1c..b549d6a57307 100644
> > --- a/net/ipv4/route.c
> > +++ b/net/ipv4/route.c
> > @@ -607,6 +607,11 @@ static void fnhe_remove_oldest(struct
> > fnhe_hash_bucket *hash)
> >                         oldest_p = fnhe_p;
> >                 }
> >         }
> > +
> > +       /* Clear oldest->fnhe_daddr to prevent this fnhe from being
> > +        * rebound with new dsts in rt_bind_exception().
> > +        */
> > +       oldest->fnhe_daddr = 0;
> >         fnhe_flush_routes(oldest);
> >         *oldest_p = oldest->fnhe_next;
> >         kfree_rcu(oldest, rcu);
> > --
> 

