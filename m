Return-Path: <stable+bounces-227451-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOWdOAn7vGmd5AIAu9opvQ
	(envelope-from <stable+bounces-227451-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:45:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FBC2D6C04
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0D773047015
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 07:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3940344D9D;
	Fri, 20 Mar 2026 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wjy2sDMD"
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A33339B3D;
	Fri, 20 Mar 2026 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773992684; cv=none; b=W5AmSKnUd1nxdQGTYchdy35f8jcW1RzSFZUcdO/GsoGd24FovLeYccvY8zlOHFDZ/YHgqMk8PWPjuimAfLy4n3Z0X8p3GbJwcN7oTZ+iaGw71pNpxyJLtLzrMJolZkOaEbsLokYu5SvmkdMyj/LId60d4YrygzfQjiCwfILw3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773992684; c=relaxed/simple;
	bh=pLxrL9VV7nswk13/3ID1ssKSAzHfq6b8p05wEsjm7N8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrUFcVqr9DuxMmhUhFbHSynLiJfq1xzt8FcLMW241qvT55DtqTCc7YK1TyaFNSkBq+G7rwoEayaydK3RhJUytcuEYVWbvOsaFriaJebD7Gt/0o7KsbdDsz7/3KN8ygRb0o12PCHaiCCNb2QAbOAIu7vTuMuLeBse04E0LX16fw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wjy2sDMD; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id DDD18208A2;
	Fri, 20 Mar 2026 08:44:40 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H_WtrpirpxJp; Fri, 20 Mar 2026 08:44:40 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4EB212084C;
	Fri, 20 Mar 2026 08:44:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4EB212084C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773992680;
	bh=6ICJCtOFs9a9L0FKYe5n0hI4T4qrYmh/SbEirbjlFew=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=wjy2sDMDjA1icyMoirf/nsjUPM/kI5nJ399SOyVOOf+I3t1gHqETwQxTXd/f/J8OA
	 C5kXK/LWeij7epl5u3hk2iUNwzju9BN7uHcdCwf3gqdcvH0eeb3wgNFA8sfRBXRQVc
	 AHwjJdowLxlrL8nX1AL2OfbTf3AkqIKqfOpHoLpgp3EI7JQWqCNKDU5bmZlIMUplG4
	 XwaUy8Wcr9qyfuPbCDNDteCABd/UFlLBLdz49IOHAQmt4o4F6kJG4ZBBR9rmS1zuCq
	 WZjB1gnmPAqSnnugZ3vVZW99SZq3oqxwwtZpKiuQNpFnS/SaxEm0ariXMuE9JMN+mX
	 gC658DBcuXxtg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 08:44:39 +0100
Received: (nullmailer pid 608539 invoked by uid 1000);
	Fri, 20 Mar 2026 07:44:38 -0000
Date: Fri, 20 Mar 2026 08:44:38 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Qi Tang <tpluszz77@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: hold skb->dev across async IPv6 transport
 reinject
Message-ID: <abz65sB_1I9ImMx6@secunet.com>
References: <20260320073023.21873-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260320073023.21873-1-tpluszz77@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-227451-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 87FBC2D6C04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 03:30:23PM +0800, Qi Tang wrote:
> xfrm_trans_queue() queues transport-mode packets for async reinject via
> xfrm_trans_reinject(). The queued skb may still be reinjected after the
> originating device teardown has started.
> 
> Keep the device alive across the async reinject window by taking a netdev
> reference when queueing the skb and dropping it after the reinject callback
> completes.
> 
> Fixes: acf568ee859f ("xfrm: Reinject transport-mode packets through tasklet")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  net/xfrm/xfrm_input.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index 4ed346e682c7..4b5147cb44b7 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -40,6 +40,7 @@ struct xfrm_trans_cb {
>  	} header;
>  	int (*finish)(struct net *net, struct sock *sk, struct sk_buff *skb);
>  	struct net *net;
> +	struct net_device *dev;
>  };
>  
>  #define XFRM_TRANS_SKB_CB(__skb) ((struct xfrm_trans_cb *)&((__skb)->cb[0]))
> @@ -784,9 +785,13 @@ static void xfrm_trans_reinject(struct work_struct *work)
>  	spin_unlock_bh(&trans->queue_lock);
>  
>  	local_bh_disable();
> -	while ((skb = __skb_dequeue(&queue)))
> -		XFRM_TRANS_SKB_CB(skb)->finish(XFRM_TRANS_SKB_CB(skb)->net,
> -					       NULL, skb);
> +	while ((skb = __skb_dequeue(&queue))) {
> +		struct xfrm_trans_cb *cb = XFRM_TRANS_SKB_CB(skb);
> +		struct net_device *dev = cb->dev;
> +
> +		cb->finish(cb->net, NULL, skb);
> +		dev_put(dev);
> +	}
>  	local_bh_enable();
>  }
>  
> @@ -805,6 +810,8 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
>  
>  	XFRM_TRANS_SKB_CB(skb)->finish = finish;
>  	XFRM_TRANS_SKB_CB(skb)->net = net;
> +	XFRM_TRANS_SKB_CB(skb)->dev = skb->dev;
> +	dev_hold(XFRM_TRANS_SKB_CB(skb)->dev);

While this looks correct, we take and drop yet another reference
here. This is an expensive operation. We do dev_hold already
in xfrm_input and it seems we just drop it too early.


