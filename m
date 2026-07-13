Return-Path: <stable+bounces-273622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3zxvCKCzVGrxpgMAu9opvQ
	(envelope-from <stable+bounces-273622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 11:45:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93896749705
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 11:45:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="EMh6KG/D";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273622-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273622-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCC4E3025F6F
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A333E4508;
	Mon, 13 Jul 2026 09:45:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EAC3E3C53;
	Mon, 13 Jul 2026 09:44:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935898; cv=none; b=LyRT9NEU8WRtdtQshm0LFSzWUJphXiS0GKDo+j0lsrfWmsb44QejNDLHCoxBcrokyLdVmUktodtuWW7qIhOv6uB0sx3TAu91XS1tlWHHq2OY1V9nG5HSZcpJXOei/pmz3DLgqjPCXF7YjL4ZQb+5O4bv7zxD8C68GdoWS8s5LYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935898; c=relaxed/simple;
	bh=JoBaVgEhbHTYLsmEt/80aTNQLnhmaFaNf1/ZXkIF8M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft7syMcQ6NKVd94MqvZaNMffdU6gfq2x4zNn76YA+eww89nCHp8ayThYWxD5DYRKpyK/vopeTNpy2g+aP/PP3u6B/CDLL+YFqfAs2REbE4Ezxkpqzgp4S4Mq90yEUcOxAUkFJkYNCcn/K/bYaZjSHvSnc68OvHm3j337y5QRalI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMh6KG/D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6207D1F00A3A;
	Mon, 13 Jul 2026 09:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783935886;
	bh=RK8kQ9CKwTFyOXiGePEatq3ie69rBMzdv1AFmy3Ehmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EMh6KG/DgpH04Bn/MwaxmQyidzQ3IuUp308au4kfCvZaUZS8T/UJAGBnzGARzLTa5
	 A5RqsxHTNhPJh20+Gh7+VrFzic0/rn5Lx+k8ZtfsalosdF2WY0zdMP6VVoaverKO+d
	 Q8GwU76C2XaSuI7xkQeuha1OXwUYCw1W8pw+xIOB9Pj1jl2z11hpLdh0k+iaJ0qlXN
	 0a8ienc+RA3PqoroojBmtHM1mZ9eSiyLGgqXPsXFZOouhtR6Pv1Q6HUBmLnXk70p98
	 LU6VJRadk86eut4THrs1JdvPsZ3G3da3PwmY8gdCf6fE2X9FYPu6E9+HUXs1kl5eGL
	 pF+hBCoZOvnWg==
Date: Mon, 13 Jul 2026 11:44:43 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] ila: reload IPv6 header after pskb_may_pull in
 checksum adjust
Message-ID: <alSzDJLwroWRoeB8@kwain>
References: <20260711150648.2915106-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711150648.2915106-1-michael.bommarito@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273622-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[atenart@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atenart@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93896749705

Hi Michael,

On Sat, Jul 11, 2026 at 11:06:48AM -0400, Michael Bommarito wrote:
> ila_csum_adjust_transport() caches ip6h = ipv6_hdr(skb) before calling
> pskb_may_pull(). On a non-linear skb whose transport header sits in a page
> fragment, pskb_may_pull() can call __pskb_pull_tail() / pskb_expand_head()
> and free the old skb head, leaving ip6h dangling; the following
> get_csum_diff(ip6h, p) then reads freed memory. ila_update_ipv6_locator()
> has the same pattern and additionally writes the new locator through the
> stale destination-address pointer.
> 
> Impact: a remote IPv6 packet routed through a configured ILA
> csum-adjust-transport route or receive-side mapping triggers a
> slab-use-after-free in ila_update_ipv6_locator() (KASAN). The route or
> mapping requires CAP_NET_ADMIN to configure, but trigger packets are
> unauthenticated once it exists.
> 
> Reload ip6h (and the derived iaddr) after each pskb_may_pull() before use,
> matching the transport-header reload the code already performs.
> 
> Fixes: 33f11d16142b ("ila: Create net/ipv6/ila directory")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  net/ipv6/ila/ila_common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/ipv6/ila/ila_common.c b/net/ipv6/ila/ila_common.c
> index e71571455c8a0..acedc5a84e4d7 100644
> --- a/net/ipv6/ila/ila_common.c
> +++ b/net/ipv6/ila/ila_common.c
> @@ -85,6 +85,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
>  			struct tcphdr *th = (struct tcphdr *)
>  					(skb_network_header(skb) + nhoff);
>  
> +			ip6h = ipv6_hdr(skb);
>  			diff = get_csum_diff(ip6h, p);
>  			inet_proto_csum_replace_by_diff(&th->check, skb,
>  							diff, true, true);
> @@ -96,6 +97,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
>  					(skb_network_header(skb) + nhoff);
>  
>  			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
> +				ip6h = ipv6_hdr(skb);
>  				diff = get_csum_diff(ip6h, p);
>  				inet_proto_csum_replace_by_diff(&uh->check, skb,
>  								diff, true, true);
> @@ -110,6 +112,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
>  			struct icmp6hdr *ih = (struct icmp6hdr *)
>  					(skb_network_header(skb) + nhoff);
>  
> +			ip6h = ipv6_hdr(skb);
>  			diff = get_csum_diff(ip6h, p);
>  			inet_proto_csum_replace_by_diff(&ih->icmp6_cksum, skb,
>  							diff, true, true);
> @@ -151,6 +154,9 @@ void ila_update_ipv6_locator(struct sk_buff *skb, struct ila_params *p,
>  		break;
>  	}
>  
> +	ip6h = ipv6_hdr(skb);
> +	iaddr = ila_a2i(&ip6h->daddr);

You should be able to reload the pointers only in the
ILA_CSUM_ADJUST_TRANSPORT case.

> +
>  	/* Now change destination address */
>  	iaddr->loc = p->locator;
>  }
> -- 
> 2.53.0
> 

