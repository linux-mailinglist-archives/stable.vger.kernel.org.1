Return-Path: <stable+bounces-232974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DqZIP5GzmlQmQYAu9opvQ
	(envelope-from <stable+bounces-232974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:37:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3802387CBC
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8965301FA72
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 10:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C908D3DD51F;
	Thu,  2 Apr 2026 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="JLMZwRa2"
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D29390202;
	Thu,  2 Apr 2026 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775126183; cv=none; b=pxRiHy6xQ0qBXLCZTPDm9gdJqEMDpwMwO5SevF1g2MIDJuFWGoeZ2LBfIQ5PJHOiKfe9fcDNu8R6gLgpdifLS+OwBwkM5MZKOjXBvK1tXr0whQtF/MP8ogTVAekrdS89xoBobBTtEOMG0uQB3out+A9KR+6zrMhQLLaZofhcpT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775126183; c=relaxed/simple;
	bh=9Wc6ROuu5V5/mprEKXHhfQhjY1T4tghAo8keRHUSsgU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMFjS2VoEye28QUm5T1Akl6KFGM1hTANNR3raRPnFwWo1if0nub4f7gCWPBOX0nbSOmm4FCefYoi3y1D3F26G1MG3xIXXpsKxQaHKRepF9t15y2fKsywkNYEo9wKFfwDzldYjB/9w9IM4eP8aBg8nTQuPVBuQVMvEU7vlqjO7lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=JLMZwRa2; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9CB7320860;
	Thu,  2 Apr 2026 12:36:13 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RvzUvPjydIEV; Thu,  2 Apr 2026 12:36:13 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0267A207C6;
	Thu,  2 Apr 2026 12:36:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0267A207C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775126173;
	bh=fWDNKElwiQ/JqB2uB+47rxe5MZP5V8yE3BYukSUhMyM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=JLMZwRa2FmTh4pJywEf3KDKCyTmdm08di2oSjvQ+2bKLELu2KeEbXdzpc/hKvM0hs
	 U5BPn7KLpcCa6fZ6SwLIVlzmTrYPszPlteBAcPnd2DGBeLKGojDpMvairEdPlaFDCr
	 QYQOAyCR75srl1JKgOViC5/ZRucFCQyB4WPWbWSGfbC/6AFyjNjsxM3DPE3ZwcxBxV
	 5mIEhTFmkCojMj6UUtwGTcKRPLrTgpTL6f1PqbHmb2U1qHseKtmQpaQw7JBBxtdwrz
	 Ipf6Oujgk8KmpaOQ0zdYA+x2oiOkGv/O0V36lYkG8E7nI0r0uDdnF8J7qwPMrtnTZc
	 blU6DUzbErT5Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 12:36:12 +0200
Received: (nullmailer pid 3738832 invoked by uid 1000);
	Thu, 02 Apr 2026 10:36:12 -0000
Date: Thu, 2 Apr 2026 12:36:12 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Qi Tang <tpluszz77@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] xfrm: delay dev_put in xfrm_input to after transport
 reinject
Message-ID: <ac5GnMeqSeNlzBp7@secunet.com>
References: <20260331092737.1937-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260331092737.1937-1-tpluszz77@gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232974-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D3802387CBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 05:27:37PM +0800, Qi Tang wrote:
> diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
> index f28cfd88eaf5..9765fdc63ffc 100644
> --- a/net/ipv4/xfrm4_input.c
> +++ b/net/ipv4/xfrm4_input.c
> @@ -46,6 +46,28 @@ static inline int xfrm4_rcv_encap_finish(struct net *net, struct sock *sk,
>  	return NET_RX_DROP;
>  }
>  
> +static int xfrm4_rcv_encap_finish_async(struct net *net, struct sock *sk,
> +					struct sk_buff *skb)
> +{
> +	if (!skb_dst(skb)) {
> +		const struct iphdr *iph = ip_hdr(skb);
> +
> +		if (ip_route_input_noref(skb, iph->daddr, iph->saddr,
> +					 ip4h_dscp(iph), skb->dev))
> +			goto drop;
> +	}
> +
> +	if (xfrm_trans_queue_net(dev_net(skb->dev), skb,
> +				 xfrm4_rcv_encap_finish2, true))
> +		goto drop;
> +
> +	return 0;
> +drop:
> +	dev_put(skb->dev);
> +	kfree_skb(skb);
> +	return NET_RX_DROP;
> +}
> +
>  int xfrm4_transport_finish(struct sk_buff *skb, int async)
>  {
>  	struct xfrm_offload *xo = xfrm_offload(skb);
> @@ -74,7 +96,8 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
>  
>  	NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
>  		dev_net(skb->dev), NULL, skb, skb->dev, NULL,
> -		xfrm4_rcv_encap_finish);
> +		async ? xfrm4_rcv_encap_finish_async :
> +			xfrm4_rcv_encap_finish);

What happens if the PRE_ROUTING hook returns NF_DROP, NF_QUEUE, or
NF_STOLEN before the okfn runs? Looks like we leak the dev refcnt
then.

> diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
> index 9005fc156a20..d4eede5315ac 100644
> --- a/net/ipv6/xfrm6_input.c
> +++ b/net/ipv6/xfrm6_input.c
> @@ -40,6 +40,19 @@ static int xfrm6_transport_finish2(struct net *net, struct sock *sk,
>  	return 0;
>  }
>  
> +static int xfrm6_transport_finish2_async(struct net *net, struct sock *sk,
> +					 struct sk_buff *skb)
> +{
> +	if (xfrm_trans_queue_net(dev_net(skb->dev), skb, ip6_rcv_finish,
> +				 true)) {
> +		dev_put(skb->dev);
> +		kfree_skb(skb);
> +		return NET_RX_DROP;
> +	}
> +
> +	return 0;
> +}
> +
>  int xfrm6_transport_finish(struct sk_buff *skb, int async)
>  {
>  	struct xfrm_offload *xo = xfrm_offload(skb);
> @@ -69,7 +82,8 @@ int xfrm6_transport_finish(struct sk_buff *skb, int async)
>  
>  	NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING,
>  		dev_net(skb->dev), NULL, skb, skb->dev, NULL,
> -		xfrm6_transport_finish2);
> +		async ? xfrm6_transport_finish2_async :
> +			xfrm6_transport_finish2);

Same here.


