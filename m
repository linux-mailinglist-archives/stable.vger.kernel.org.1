Return-Path: <stable+bounces-154688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72620ADF340
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 18:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB774007A5
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CB02FEE32;
	Wed, 18 Jun 2025 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvSOUZ6o"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479912FEE06
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265851; cv=none; b=todHQfuCcjnQObBpqqJd8duGRSDSD23aUkfGDqemn0U1jEJfZxlbL407a7d3dsFg/G19SybFtOgtzLPrHMOoS5zoPF/drHpFvGG3Vrq34leWQGp2+UIqev2SCjFkn7pobKTBaJ+ibfPYKrcsv2otPpjUsLGi0oOIeKki3Fc6btQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265851; c=relaxed/simple;
	bh=HlN5+9S5eGdiDyPHsMC9uJKGBH7p0TaZHEVAqLeH+YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtEM44MQRgloWBnLgtl/dMeRmZpv7EQjABpwvaragZGgrmJtSheLOX8IAbwidi38LuWSco86GiwPo9GJJn4yscsYtweeIDst9Zgxik4nRdGD/cMMuAXgsh+Ag5/gYs4z3+5WhZ6AiCw2uDgZs2ByPqKJK3wtyNLF/R+Js+ErUK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvSOUZ6o; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso4245668f8f.0
        for <stable@vger.kernel.org>; Wed, 18 Jun 2025 09:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750265847; x=1750870647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dleNRFUdekVlF9RHTinNYJEiWFvu7kS15hxheupXGBE=;
        b=mvSOUZ6oy16D3JKdXY/cyTrUF30Ix9/0BKkDFZXpkBg2bTANY9p667EE0vqRqG2qpo
         9z9r09FsugNlo1cYTdncMhQDLCPuqT11Ngdl9/ez8pt8MPRdF0ZKySpBrWeTdxZRZ43F
         gm1sdpm007oqtrPvyozrSVusCrggsmAUKt7JLEWtrV5XrZxcBwsAVsCnPNWiL88j9AGC
         8s8xwq6J6fddG0wIMB7TYFTj4SHXCml0hE+5oKUXJhfZlHgpi4FVBLxmD+5cMMpEoWpf
         QEnlV9SWGUgo0BY4mT2jfuWzfHQvmiF7Da3P+seH4ReAJgRG79sCuERloacBdhTMLi8u
         XWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750265847; x=1750870647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dleNRFUdekVlF9RHTinNYJEiWFvu7kS15hxheupXGBE=;
        b=aL09p45YEQHmSlYYISWwqT4kWjx6K1BMee7M/8BzuciFebwAop68+QrDugkyNn+yXU
         v/g0qysY5wjXoaYmeqgGVJ4fSWXcWJhxiMXiHbAcQwWgRSNq5oGCzQ3AdvOgA0tAQjOb
         2dXEZRkdyeHuqfgxngpNOIEFq+TzA54/YDXqPSNTwEZNnUc381hicrf97IiDC1XnpQI4
         Yf0EIyIv+7iBQYe+puq3q1gKBWr0mezei1GAe3HtqmYciBSwom/P0icQ6/DkA6/k0H+4
         QuAeUhx3FcPJrCkorOCebALvfgpkM1M6tLyLZPzxN6PUSu6KWWH3ay7ddJ/uPFZqKmzy
         I43A==
X-Gm-Message-State: AOJu0Yw9G4f6EYr6fRUMKkZ3gGKbdbj+HWimyBBUSmj9seHk7Xq3Fh/M
	chfZkMGb+aB0smzOaNl0+coSyh0Dbk3ZYmIZjKJHQX4bTnlz9sj0cbtw
X-Gm-Gg: ASbGncvlWCg1h+LHWrFDPCxHlr+KU6qSWo6hjM1Ky3UhYoRbQ0ARVRmLgxySOIekERG
	NYv7GxL9t3rv9QvAyOqnal7otFRABUImg0FEQ3NVjgN0mNhJvHvQXcgKCsKX/oqdjmq8LXU8nr2
	3zPnMeQom515PNiNWHJ53DVpDOIDj3SFFRqFk6vU+mjJ/n5kGYum1qO8ZmUF3mZou+N0uH3XKli
	YXxX6hgYB6LkZNIVxq5QEn//kfBWhTTebIaVf9/rTXt9uUQqetKEukP+qndN7xBid9NnmkuA2x7
	05/YCMrDRf+L2D1j1ljQJxNC5mXIV4aG6tFOYiK/Pk2ZyrIwmh5Sn1KjZXOSk/NdviezBpHp0VO
	iDHwkEnHu6HY=
X-Google-Smtp-Source: AGHT+IFaiq7gavwDesKhCn8ecomGEm7I0Bss98cy4jUzKliztO2BDLBFMhxRfAGV2vDqJ2cNVwXTHA==
X-Received: by 2002:a5d:5f95:0:b0:3a5:2cf3:d6af with SMTP id ffacd0b85a97d-3a572e2de24mr14245365f8f.45.1750265847191;
        Wed, 18 Jun 2025 09:57:27 -0700 (PDT)
Received: from Tunnel (199.160.185.81.rev.sfr.net. [81.185.160.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54e71sm17163243f8f.1.2025.06.18.09.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:57:26 -0700 (PDT)
Date: Wed, 18 Jun 2025 18:57:24 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev, Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 257/356] net: Fix checksum update for ILA
 adj-transport
Message-ID: <aFLv9Ea6Sh2eXjed@Tunnel>
References: <20250617152338.212798615@linuxfoundation.org>
 <20250617152348.550981340@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617152348.550981340@linuxfoundation.org>

On Tue, Jun 17, 2025 at 05:26:12PM +0200, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.

Not an objection per se, but I've sent the same backport at
https://lore.kernel.org/stable/6520b247c2d367849f41689f71961e9741b1b7eb.1750168920.git.paul.chaignon@gmail.com/
The only difference is that I also backported the second patch in the
series, which had a conflict. The backported patchset should apply on
6.1, 6.6, and 6.12. I hope that was the correct way to proceed :)

> 
> ------------------
> 
> From: Paul Chaignon <paul.chaignon@gmail.com>
> 
> [ Upstream commit 6043b794c7668c19dabc4a93c75b924a19474d59 ]
> 
> During ILA address translations, the L4 checksums can be handled in
> different ways. One of them, adj-transport, consist in parsing the
> transport layer and updating any found checksum. This logic relies on
> inet_proto_csum_replace_by_diff and produces an incorrect skb->csum when
> in state CHECKSUM_COMPLETE.
> 
> This bug can be reproduced with a simple ILA to SIR mapping, assuming
> packets are received with CHECKSUM_COMPLETE:
> 
>   $ ip a show dev eth0
>   14: eth0@if15: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>       link/ether 62:ae:35:9e:0f:8d brd ff:ff:ff:ff:ff:ff link-netnsid 0
>       inet6 3333:0:0:1::c078/64 scope global
>          valid_lft forever preferred_lft forever
>       inet6 fd00:10:244:1::c078/128 scope global nodad
>          valid_lft forever preferred_lft forever
>       inet6 fe80::60ae:35ff:fe9e:f8d/64 scope link proto kernel_ll
>          valid_lft forever preferred_lft forever
>   $ ip ila add loc_match fd00:10:244:1 loc 3333:0:0:1 \
>       csum-mode adj-transport ident-type luid dev eth0
> 
> Then I hit [fd00:10:244:1::c078]:8000 with a server listening only on
> [3333:0:0:1::c078]:8000. With the bug, the SYN packet is dropped with
> SKB_DROP_REASON_TCP_CSUM after inet_proto_csum_replace_by_diff changed
> skb->csum. The translation and drop are visible on pwru [1] traces:
> 
>   IFACE   TUPLE                                                        FUNC
>   eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  ipv6_rcv
>   eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  ip6_rcv_core
>   eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  nf_hook_slow
>   eth0:9  [fd00:10:244:3::3d8]:51420->[fd00:10:244:1::c078]:8000(tcp)  inet_proto_csum_replace_by_diff
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     tcp_v6_early_demux
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_route_input
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_input
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_input_finish
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ip6_protocol_deliver_rcu
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     raw6_local_deliver
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     ipv6_raw_deliver
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     tcp_v6_rcv
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     __skb_checksum_complete
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     kfree_skb_reason(SKB_DROP_REASON_TCP_CSUM)
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_release_head_state
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_release_data
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     skb_free_head
>   eth0:9  [fd00:10:244:3::3d8]:51420->[3333:0:0:1::c078]:8000(tcp)     kfree_skbmem
> 
> This is happening because inet_proto_csum_replace_by_diff is updating
> skb->csum when it shouldn't. The L4 checksum is updated such that it
> "cancels" the IPv6 address change in terms of checksum computation, so
> the impact on skb->csum is null.
> 
> Note this would be different for an IPv4 packet since three fields
> would be updated: the IPv4 address, the IP checksum, and the L4
> checksum. Two would cancel each other and skb->csum would still need
> to be updated to take the L4 checksum change into account.
> 
> This patch fixes it by passing an ipv6 flag to
> inet_proto_csum_replace_by_diff, to skip the skb->csum update if we're
> in the IPv6 case. Note the behavior of the only other user of
> inet_proto_csum_replace_by_diff, the BPF subsystem, is left as is in
> this patch and fixed in the subsequent patch.
> 
> With the fix, using the reproduction from above, I can confirm
> skb->csum is not touched by inet_proto_csum_replace_by_diff and the TCP
> SYN proceeds to the application after the ILA translation.
> 
> Link: https://github.com/cilium/pwru [1]
> Fixes: 65d7ab8de582 ("net: Identifier Locator Addressing module")
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://patch.msgid.link/b5539869e3550d46068504feb02d37653d939c0b.1748509484.git.paul.chaignon@gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/net/checksum.h    | 2 +-
>  net/core/filter.c         | 2 +-
>  net/core/utils.c          | 4 ++--
>  net/ipv6/ila/ila_common.c | 6 +++---
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/checksum.h b/include/net/checksum.h
> index 1338cb92c8e72..28b101f26636e 100644
> --- a/include/net/checksum.h
> +++ b/include/net/checksum.h
> @@ -158,7 +158,7 @@ void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
>  			       const __be32 *from, const __be32 *to,
>  			       bool pseudohdr);
>  void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
> -				     __wsum diff, bool pseudohdr);
> +				     __wsum diff, bool pseudohdr, bool ipv6);
>  
>  static __always_inline
>  void inet_proto_csum_replace2(__sum16 *sum, struct sk_buff *skb,
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 5143c8a9e52ca..e92f3a9017bb4 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1987,7 +1987,7 @@ BPF_CALL_5(bpf_l4_csum_replace, struct sk_buff *, skb, u32, offset,
>  		if (unlikely(from != 0))
>  			return -EINVAL;
>  
> -		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo);
> +		inet_proto_csum_replace_by_diff(ptr, skb, to, is_pseudo, false);
>  		break;
>  	case 2:
>  		inet_proto_csum_replace2(ptr, skb, from, to, is_pseudo);
> diff --git a/net/core/utils.c b/net/core/utils.c
> index c994e95172acf..5895d034bf279 100644
> --- a/net/core/utils.c
> +++ b/net/core/utils.c
> @@ -473,11 +473,11 @@ void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
>  EXPORT_SYMBOL(inet_proto_csum_replace16);
>  
>  void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff *skb,
> -				     __wsum diff, bool pseudohdr)
> +				     __wsum diff, bool pseudohdr, bool ipv6)
>  {
>  	if (skb->ip_summed != CHECKSUM_PARTIAL) {
>  		csum_replace_by_diff(sum, diff);
> -		if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr)
> +		if (skb->ip_summed == CHECKSUM_COMPLETE && pseudohdr && !ipv6)
>  			skb->csum = ~csum_sub(diff, skb->csum);
>  	} else if (pseudohdr) {
>  		*sum = ~csum_fold(csum_add(diff, csum_unfold(*sum)));
> diff --git a/net/ipv6/ila/ila_common.c b/net/ipv6/ila/ila_common.c
> index 95e9146918cc6..b8d43ed4689db 100644
> --- a/net/ipv6/ila/ila_common.c
> +++ b/net/ipv6/ila/ila_common.c
> @@ -86,7 +86,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
>  
>  			diff = get_csum_diff(ip6h, p);
>  			inet_proto_csum_replace_by_diff(&th->check, skb,
> -							diff, true);
> +							diff, true, true);
>  		}
>  		break;
>  	case NEXTHDR_UDP:
> @@ -97,7 +97,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
>  			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
>  				diff = get_csum_diff(ip6h, p);
>  				inet_proto_csum_replace_by_diff(&uh->check, skb,
> -								diff, true);
> +								diff, true, true);
>  				if (!uh->check)
>  					uh->check = CSUM_MANGLED_0;
>  			}
> @@ -111,7 +111,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
>  
>  			diff = get_csum_diff(ip6h, p);
>  			inet_proto_csum_replace_by_diff(&ih->icmp6_cksum, skb,
> -							diff, true);
> +							diff, true, true);
>  		}
>  		break;
>  	}
> -- 
> 2.39.5
> 
> 
> 

