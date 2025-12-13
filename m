Return-Path: <stable+bounces-200954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A34ECBB15F
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 17:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07C8930797BB
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 16:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4862DC339;
	Sat, 13 Dec 2025 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWAWTl/6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6101B1DF736;
	Sat, 13 Dec 2025 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765643226; cv=none; b=nXtqTC3YLD4IDNkbpAl1uQBx99vKewZI/Wd46S66GLKtulGvEf5o7R37MlULu4j39t7GFLJGlRyJXRxzck5CwIe5RhKSTmuOu5uAARMV5NT3HJ//q/WCgEHG5dku92/B4CBE1l9lAFFnRuCJIofnhsv2ti13Hy1S+Y34s0RxKLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765643226; c=relaxed/simple;
	bh=RuSYuEpf2hoURn7aa0FDJJchNpBdFJbBF13tEAR3aAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqdxmkb5eP5YQtq4Vw9OF4Y+dR++tm8x+dp3UubNxSKBh4EQMglcJe3f3BPMDLYJ4iGr7kZ91q9OtGnswLjC6zTIbzuOkolnoEQ1j+/gFw+SJAu7+XiBztbwtfDF+eW0GdsSQJiWEcyEIKGGJXjdC3G8wvNIPM9GgWuMjedtNUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWAWTl/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE72C4CEF7;
	Sat, 13 Dec 2025 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765643224;
	bh=RuSYuEpf2hoURn7aa0FDJJchNpBdFJbBF13tEAR3aAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWAWTl/6+EjJD0lTBxE+DOOYoKiiWAaaASou11WlGXQaXUV9oljb0MOcL3eRFQdwq
	 uwXMLnGQPn3YGxDpddDscFhUzYUk0O8cqozSGffVPqjZyssktFPcPg39VUP0+hj33/
	 VTDgUU8Gqqqy9/HXJP2P9YCwklcajMKmkpj/OMNefHXpFg4jeHF808YZAYRxanC5Mz
	 Tb/ppvsNFuO5Hv4QPssZKVjBKmYPywbbhBWeM3qGFU8rNFahfXRm/I/t88rYQRRIrW
	 NYVFmAi+rcNeUVC1W6OmMQ2SAHzCGQW5egbXctsykqWrJrGQUSURO9QyFT3Au1Ab4/
	 Pvhad2xnPrsQg==
Date: Sat, 13 Dec 2025 16:27:00 +0000
From: Simon Horman <horms@kernel.org>
To: Frode Nordahl <fnordahl@ubuntu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gal Pressman <gal@nvidia.com>, Kees Cook <kees@kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erspan: Initialize options_len before referencing
 options.
Message-ID: <aT2T1GQfKJ3Bj1aj@horms.kernel.org>
References: <20251212073202.13153-1-fnordahl@ubuntu.com>
 <nZEr2jHd7_uGuwbqEiM3iStGK4aQ_EgMoNLBgyJrYmeTlhzT2-qGpuBxKPW6U7k8ZqAr6HExn5ncXLMA5EbRQQ==@protonmail.internalid>
 <aTwxDBODyDmerGAt@horms.kernel.org>
 <bb4f7703-b704-4eb8-942b-d693f64aed63@ubuntu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb4f7703-b704-4eb8-942b-d693f64aed63@ubuntu.com>

On Fri, Dec 12, 2025 at 07:21:49PM +0100, Frode Nordahl wrote:
> On 12/12/25 16:13, Simon Horman wrote:
> > On Fri, Dec 12, 2025 at 07:32:01AM +0000, Frode Nordahl wrote:
> > > The struct ip_tunnel_info has a flexible array member named
> > > options that is protected by a counted_by(options_len)
> > > attribute.
> > > 
> > > The compiler will use this information to enforce runtime bounds
> > > checking deployed by FORTIFY_SOURCE string helpers.
> > > 
> > > As laid out in the GCC documentation, the counter must be
> > > initialized before the first reference to the flexible array
> > > member.
> > > 
> > > In the normal case the ip_tunnel_info_opts_set() helper is used
> > > which would initialize options_len properly, however in the GRE
> > > ERSPAN code a partial update is done, preventing the use of the
> > > helper function.
> > > 
> > > Before this change the handling of ERSPAN traffic in GRE tunnels
> > > would cause a kernel panic when the kernel is compiled with
> > > GCC 15+ and having FORTIFY_SOURCE configured:
> > > 
> > > memcpy: detected buffer overflow: 4 byte write of buffer size 0
> > > 
> > > Call Trace:
> > >   <IRQ>
> > >   __fortify_panic+0xd/0xf
> > >   erspan_rcv.cold+0x68/0x83
> > >   ? ip_route_input_slow+0x816/0x9d0
> > >   gre_rcv+0x1b2/0x1c0
> > >   gre_rcv+0x8e/0x100
> > >   ? raw_v4_input+0x2a0/0x2b0
> > >   ip_protocol_deliver_rcu+0x1ea/0x210
> > >   ip_local_deliver_finish+0x86/0x110
> > >   ip_local_deliver+0x65/0x110
> > >   ? ip_rcv_finish_core+0xd6/0x360
> > >   ip_rcv+0x186/0x1a0
> > > 
> > > Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-counted_005fby-variable-attribute
> > > Reported-at: https://launchpad.net/bugs/2129580
> > > Fixes: bb5e62f2d547 ("net: Add options as a flexible array to struct ip_tunnel_info")
> > > Signed-off-by: Frode Nordahl <fnordahl@ubuntu.com>
> > 
> > Hi Frode,
> > 
> > Thanks for your patch (and nice to see you recently in Prague :).
> 
> Thank you for taking the time to review, much appreciated (I enjoyed the
> recent conference in Prague and our exchanges there!).
> 
> > Overall this looks good to me but I have some minor feedback.
> > 
> > 
> > Firstly, the cited patch seems to cover more than erspan.
> > So I'm wondering if you took at look at other cases where
> > this might occur? No problem either way, but if so it might
> > be worth mentioning in the commit message.
> 
> I did some quick searches which formed the basis of the statement of the
> normal case being to use the ip_tunnel_info_opts_set(), I could expand a bit
> upon that statement.

Understood. Whichever way you want to go on this is fine by me.

> > Regarding the comments in the code. I am wondering if the are necessary
> > as the information is also contained in the commit message. And if the
> > source documented every such case then things could get rather verbose.
> > 
> > If you do feel strongly about it keeping it then could I ask that
> > (other than the URL) it is line-wrapped trimmed to 80 columns wide or less,
> > as is still preferred for Networking (but confusingly not all Kernel) code.
> 
> Yes, I guess it became a bit verbose.  The thought was that it would be very
> easy to miss this important detail for anyone (including future me)
> spelunking into this part of the code.
> 
> I'll trim it down to a single line, which should be enough to give the urge
> to look at the commit message.

Thanks.

> > As a fix for code present in net this should be targeted at that tree.
> > It's best to do so explicitly like this:
> > 
> > Subject: [PATCH net] ...
> 
> Ack.
> 
> > And it's probably also best to CC stable@vger.kernel.org.
> > That practice isn't as widespread as perhaps it should be for Networking code.
> > But it does seem worth mentioning.
> 
> Ack, the intention was indeed to Cc them, I only put them into the e-mail
> header and the stable kernel bot pointed out that the Cc also needs to be in
> the commit message.
> 
> -- 
> Frode Nordahl
> 

