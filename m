Return-Path: <stable+bounces-200919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BF30ACB9139
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 16:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3985630141CD
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7923112B0;
	Fri, 12 Dec 2025 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJGsAQ3Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61AF1531F9;
	Fri, 12 Dec 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765552402; cv=none; b=EA+KH0xvvH5FTEAWHEhln4iQKKP1Y67qP11/CT5cFZ4yEbDUYpslKquWKrjqAmxx5g2P9Mi0iSUMDIwauIfJxrKBRSkzYpeuIKQbLwRqZJGkwMdPRMWzenkyunJ727l6RveDSarNTTO42qOI5g3xsJZRnzY5Tktw/5KoTA+otO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765552402; c=relaxed/simple;
	bh=UUNgLmg8kTALS3WP6Kh52zkkNjWHrZxSFvJYZHaby3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzhJaSmsUcAOOoaWATftAyI+xjSPN0Qjb3gWkZv6I4U2bgqpEOFChK3WARf4JJ2iu9wopQsdunHvRUuj3sgYLcnAj5hfnlkxf5A3AWZgXFkcZ8mA1iYmwJxl5g77MhF0tsJ1y49gWeUtCqTf5Alvpw/jkeaeosaRIU51591E7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJGsAQ3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DD8C4CEF1;
	Fri, 12 Dec 2025 15:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765552400;
	bh=UUNgLmg8kTALS3WP6Kh52zkkNjWHrZxSFvJYZHaby3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJGsAQ3QQL6QDhTh4c4OkXjCv4prjEVPM8VY2sUGFIWR8lFzhBv7Or2mcHit4attL
	 ScZh25edONVuyfsIYm2YsdtjTRIY+sGTcoKOpHhR316BBWGZigAk9rfWQWjlA9rRn1
	 Z7F8btFKV0H62oF31b93KJnCShgUxLEdgKPUL7l1VQai3sYNWEJrJfg7XkwJ4Nsc/u
	 ICBdMaCUOX335dLMhcJxDPBed+FqcfwSnZMD7w9YMNeHnoVVJEU7TI45ruAn/N15kU
	 8coH3HF9swN3Z6GIUto7JvjZxuTg/nFsv4+xD4taMZD1s0T1o9pxsuoJcSX4A4JyXO
	 c7JM5FBnULBnw==
Date: Fri, 12 Dec 2025 15:13:16 +0000
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
Message-ID: <aTwxDBODyDmerGAt@horms.kernel.org>
References: <20251212073202.13153-1-fnordahl@ubuntu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212073202.13153-1-fnordahl@ubuntu.com>

On Fri, Dec 12, 2025 at 07:32:01AM +0000, Frode Nordahl wrote:
> The struct ip_tunnel_info has a flexible array member named
> options that is protected by a counted_by(options_len)
> attribute.
> 
> The compiler will use this information to enforce runtime bounds
> checking deployed by FORTIFY_SOURCE string helpers.
> 
> As laid out in the GCC documentation, the counter must be
> initialized before the first reference to the flexible array
> member.
> 
> In the normal case the ip_tunnel_info_opts_set() helper is used
> which would initialize options_len properly, however in the GRE
> ERSPAN code a partial update is done, preventing the use of the
> helper function.
> 
> Before this change the handling of ERSPAN traffic in GRE tunnels
> would cause a kernel panic when the kernel is compiled with
> GCC 15+ and having FORTIFY_SOURCE configured:
> 
> memcpy: detected buffer overflow: 4 byte write of buffer size 0
> 
> Call Trace:
>  <IRQ>
>  __fortify_panic+0xd/0xf
>  erspan_rcv.cold+0x68/0x83
>  ? ip_route_input_slow+0x816/0x9d0
>  gre_rcv+0x1b2/0x1c0
>  gre_rcv+0x8e/0x100
>  ? raw_v4_input+0x2a0/0x2b0
>  ip_protocol_deliver_rcu+0x1ea/0x210
>  ip_local_deliver_finish+0x86/0x110
>  ip_local_deliver+0x65/0x110
>  ? ip_rcv_finish_core+0xd6/0x360
>  ip_rcv+0x186/0x1a0
> 
> Link: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-counted_005fby-variable-attribute
> Reported-at: https://launchpad.net/bugs/2129580
> Fixes: bb5e62f2d547 ("net: Add options as a flexible array to struct ip_tunnel_info")
> Signed-off-by: Frode Nordahl <fnordahl@ubuntu.com>

Hi Frode,

Thanks for your patch (and nice to see you recently in Prague :).

Overall this looks good to me but I have some minor feedback.


Firstly, the cited patch seems to cover more than erspan.
So I'm wondering if you took at look at other cases where
this might occur? No problem either way, but if so it might
be worth mentioning in the commit message.


Regarding the comments in the code. I am wondering if the are necessary
as the information is also contained in the commit message. And if the
source documented every such case then things could get rather verbose.

If you do feel strongly about it keeping it then could I ask that
(other than the URL) it is line-wrapped trimmed to 80 columns wide or less,
as is still preferred for Networking (but confusingly not all Kernel) code.


As a fix for code present in net this should be targeted at that tree.
It's best to do so explicitly like this:

Subject: [PATCH net] ...

And it's probably also best to CC stable@vger.kernel.org.
That practice isn't as widespread as perhaps it should be for Networking code.
But it does seem worth mentioning.

...

