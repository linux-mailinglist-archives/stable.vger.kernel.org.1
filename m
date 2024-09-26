Return-Path: <stable+bounces-77752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6307986D67
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 09:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1283C2838AD
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 07:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBDB188CB8;
	Thu, 26 Sep 2024 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfMoVFTf"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D718224D6;
	Thu, 26 Sep 2024 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727335181; cv=none; b=ZGPvbFsANX7A4cr0ufogP6bww6nSXGfmeptVvxd2jCH4Gxwx6Dk4gz8HXba8vUvpFu9AMnUaoXImqv4qAum2K3GZSSK1pqHtnco6VEw+wBi5LfoglFK2cU6OyMBRuunLe1CQ1wmcRR5UcJWwdd6AiX7G0kXD+TW6buOtuhYfaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727335181; c=relaxed/simple;
	bh=QT0ZNFOWbxLbNdHUFzQCiC4T8yRdqsBLttLda2kN/w8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Yq/C9y4VbEDrFaopkLDyw4aq3pDma3SMyJM5pJOjbx28tW0WGmDuvs0O+LGCyu5t9niHjJjTnxBnOjCrxF2jIS4A6R3O90dOyIivju/jfGBWMdndkhDc+nZLMbu7GbPFcpbS+2yDUwYdJ9XsrnaHgHGfr15WRWVktKPlldOweII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfMoVFTf; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4582f9abb43so4325511cf.2;
        Thu, 26 Sep 2024 00:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727335179; x=1727939979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDVs7wzUGO2Y7Cpw9eRfpc2vpcHsraO8ALjkyowuSTY=;
        b=HfMoVFTfThjotXzXdiGUj2VV6sWgeuwjmHP5CqIjAT0HnhZ8+CKNA4PJB4AHNqiSko
         8nZtsMC55fD6vsemJcB6Xcr7OBy6qgaXYfWsMQpvtr4lDBo58BzhTWtS4IYXInHEi6eb
         BLZpRGEdtJNAAlEuCR2VP68rnZPaiU9MwvWimgpUUXCLAtCToxn1+tyytimPRwl6KM/O
         7CE63Wy80ur+5gcVmQRqALthOesGcibgPYpKUVNaU7rVXU8hUzUsOCPdi5SpZmCNdKDj
         G3M2VJpqwwYbBTl57UedE2hQ+0NWWSt4Y0q13xEJMSwjd7UfDssOUKFZ8rld4ydpqLQ5
         JEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727335179; x=1727939979;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eDVs7wzUGO2Y7Cpw9eRfpc2vpcHsraO8ALjkyowuSTY=;
        b=K0CSlFs2J78ea1MQ0hSsFPT+oQOszB4tBLfxF0gDFCtkNFiy4/dC0LWuEU1G11MAPa
         2cUBBsiCak8EmVaFzBI78/BrG0cIcxS0s8qqa4taSGcBEK/v/S1CzLxTwTrWt76rn2WS
         mOiM6S2Ozw+ocf538cIiJ6iEdRPAh0s45YEwL3/O5NgbdQVPSYcusRqlrXiSoVYlODn6
         6fWEyQD3nY/LBuLd/KdJ94ufcCYrgnT5u78Jr9OqjwY6zeORocJnVRRUQL+wtwncvXIW
         pYCD3lZY18A27Lz4YeaCtt2L5kv0+900k5Kpm0V8VBxwMxdnU8dpuwtrnTWJUoA+lkHw
         WXPg==
X-Forwarded-Encrypted: i=1; AJvYcCVOf3xcIH2w0ztjzhyPNP6qSgTRLKLut5KAMdzXH+uwQJYeDci6ZLjYanteLwEEulAPkpFZC+Lp@vger.kernel.org, AJvYcCVaq5z8aAPqUVWzM/4KnXdLs6W/487fuPUCmK0GIsEEtNk3tv8YWnK1BZlP+j+RS1/i0T1VU2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7i0o7B2Ce5TmupY3SnNfyNWIL5jTLK1xmdPMG4Nh3jLGDfM8D
	mW29A2cRR0ud//aOT7nF2DWs1GvCzujIqEWgguuFHNRB60UP3DMw
X-Google-Smtp-Source: AGHT+IGvqz6QG+ib2ufeMu3zUC/JIq+w+KlnT0DiKBWUnXZ/X9+E/neceoo2DPtgGbXMlNW15amNZg==
X-Received: by 2002:a05:622a:48c:b0:447:ee3c:9bad with SMTP id d75a77b69052e-45b5def449bmr72990281cf.27.1727335178850;
        Thu, 26 Sep 2024 00:19:38 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b52546980sm23383741cf.4.2024.09.26.00.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 00:19:38 -0700 (PDT)
Date: Thu, 26 Sep 2024 03:19:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 stable@vger.kernel.org, 
 maze@google.com, 
 shiming.cheng@mediatek.com, 
 daniel@iogearbox.net, 
 lena.wang@mediatek.com, 
 herbert@gondor.apana.org.au, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66f50b09cc7a5_7f2c829476@willemb.c.googlers.com.notmuch>
In-Reply-To: <8f0a91a3-550f-46ec-81a9-021656906471@nbd.name>
References: <20240922150450.3873767-1-willemdebruijn.kernel@gmail.com>
 <7144e848-9919-44a5-a313-f9b2076532bf@nbd.name>
 <66f46003a38a0_65fdc29433@willemb.c.googlers.com.notmuch>
 <68d4c9cf-f61f-4257-8d98-9a363142cc53@nbd.name>
 <8f0a91a3-550f-46ec-81a9-021656906471@nbd.name>
Subject: Re: [PATCH net] gso: fix gso fraglist segmentation after pull from
 frag_list
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Felix Fietkau wrote:
> On 25.09.24 22:59, Felix Fietkau wrote:
> > On 25.09.24 21:09, Willem de Bruijn wrote:
> >> Felix Fietkau wrote:
> >>> On 22.09.24 17:03, Willem de Bruijn wrote:
> >>> > From: Willem de Bruijn <willemb@google.com>
> >>> > 
> >>> > Detect gso fraglist skbs with corrupted geometry (see below) and
> >>> > pass these to skb_segment instead of skb_segment_list, as the first
> >>> > can segment them correctly.
> >>> > 
> >>> > Valid SKB_GSO_FRAGLIST skbs
> >>> > - consist of two or more segments
> >>> > - the head_skb holds the protocol headers plus first gso_size
> >>> > - one or more frag_list skbs hold exactly one segment
> >>> > - all but the last must be gso_size
> >>> > 
> >>> > Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
> >>> > modify these skbs, breaking these invariants.
> >>> > 
> >>> > In extreme cases they pull all data into skb linear. For UDP, this
> >>> > causes a NULL ptr deref in __udpv4_gso_segment_list_csum at
> >>> > udp_hdr(seg->next)->dest.
> >>> > 
> >>> > Detect invalid geometry due to pull, by checking head_skb size.
> >>> > Don't just drop, as this may blackhole a destination. Convert to be
> >>> > able to pass to regular skb_segment.
> >>> > 
> >>> > Link: https://lore.kernel.org/netdev/20240428142913.18666-1-shiming.cheng@mediatek.com/
> >>> > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> >>> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> >>> > Cc: stable@vger.kernel.org
> >>> > 
> >>> > ---
> >>> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> >>> > index d842303587af..e457fa9143a6 100644
> >>> > --- a/net/ipv4/udp_offload.c
> >>> > +++ b/net/ipv4/udp_offload.c
> >>> > @@ -296,8 +296,16 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
> >>> >   		return NULL;
> >>> >   	}
> >>> >   
> >>> > -	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
> >>> > -		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
> >>> > +	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
> >>> > +		 /* Detect modified geometry and pass these to skb_segment. */
> >>> > +		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
> >>> > +			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
> >>> > +
> >>> > +		 /* Setup csum, as fraglist skips this in udp4_gro_receive. */
> >>> > +		gso_skb->csum_start = skb_transport_header(gso_skb) - gso_skb->head;
> >>> > +		gso_skb->csum_offset = offsetof(struct udphdr, check);
> >>> > +		gso_skb->ip_summed = CHECKSUM_PARTIAL;
> >>> 
> >>> I also noticed this uh->check update done by udp4_gro_complete only in 
> >>> case of non-fraglist GRO:
> >>> 
> >>>      if (uh->check)
> >>>          uh->check = ~udp_v4_check(skb->len - nhoff, iph->saddr,
> >>>                        iph->daddr, 0);
> >>> 
> >>> I didn't see any equivalent in your patch. Is it missing or left out 
> >>> intentionally?
> >> 
> >> Thanks. That was not intentional. I think you're right. Am a bit
> >> concerned that all this testing did not catch it. Perhaps because
> >> CHECKSUM_PARTIAL looped to ingress on the same machine is simply
> >> interpreted as CHECKSUM_UNNECESSARY. Need to look into that.
> >> 
> >> If respinning this, I should also change the Fixes to
> >> 
> >> Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> >> 
> >> Analogous to the eventual TCP fix to
> >> 
> >> Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")
> > 
> > In the mean time, I've been working on the TCP side. I managed to
> > reproduce the issue on one of my devices by routing traffic from
> > Ethernet to Wifi using your BPF test program.
> > 
> > The following patch makes it work for me for TCP v4. Still need to
> > test and fix v6.
> 
> Actually, here is something even simpler that should work for both v4
> and v6:

Makes sense. It does come with higher cost of calling skb_checksum.
 
> ---
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -101,8 +101,14 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
>   	if (!pskb_may_pull(skb, sizeof(struct tcphdr)))
>   		return ERR_PTR(-EINVAL);
>   
> -	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)
> -		return __tcp4_gso_segment_list(skb, features);
> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
> +		struct tcphdr *th = tcp_hdr(skb);
> +
> +		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
> +			return __tcp4_gso_segment_list(skb, features);
> +
> +		skb->ip_summed = CHECKSUM_NONE;
> +	}
>   
>   	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
>   		const struct iphdr *iph = ip_hdr(skb);
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -159,8 +159,14 @@ static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
>   	if (!pskb_may_pull(skb, sizeof(*th)))
>   		return ERR_PTR(-EINVAL);
>   
> -	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)
> -		return __tcp6_gso_segment_list(skb, features);
> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
> +		struct tcphdr *th = tcp_hdr(skb);
> +
> +		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
> +			return __tcp6_gso_segment_list(skb, features);
> +
> +		skb->ip_summed = CHECKSUM_NONE;
> +	}
>   
>   	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
>   		const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
> 
> 



