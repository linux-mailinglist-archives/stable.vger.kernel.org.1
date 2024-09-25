Return-Path: <stable+bounces-77732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FD2986835
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 23:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441E91F259DB
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 21:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19562158A04;
	Wed, 25 Sep 2024 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="WAD4qmQM"
X-Original-To: stable@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6986148FE8;
	Wed, 25 Sep 2024 21:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727298781; cv=none; b=H26hr0fL/13rKDRuWYBO9mWCxaa3bNGdDtRCWND95bHqa2bROOMacUSnD+VGaH9PPmta9KBNUghZ40YAOCPhOGnMrBnJ7TGYkTbNTorRFGwWOdD3HjFF3LRImpCFOjvEN3zsZ3corwGBFfJLKy95UPz5fXhinMtLl3i+XK3Wp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727298781; c=relaxed/simple;
	bh=CkvqEwcJBrLE67avtB7uqSf6IyzyJvzdXgY+4b72WyA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O+oTqNHOZO1CruIvDt6NhAQN3sSowOAX14Rxc1shUgvHmN1dMAI13b4E0VG3gQvyWo3w/XP2IliiPU8jj0VEW0QUAU4QuYryAcFbxhkKvzu6y4p0HQB982nxyYqFr3Kl+HFxXxcMFUtSeYBRz24/cmHr9yKtyoxrJcaf11jUFRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=WAD4qmQM; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NJERc+E/cBKgLF8vPfJSf3Y8Hq6cUuhgONW7U9FWMM8=; b=WAD4qmQMNoI/ZMFwBWCyFAEFjV
	pDZVxy9kYF2rTsWjfL1JAABMuuWan95eQNFOxrcK4Q8A2d0uLGT73MC0hadnAgDDb15jTGem39HCM
	hJO1S06Uu+fWqYuG3gGqoPiEMgSGCvg8JATbN6MXZfeeMpLHT5CDHz1c1z55HMNpZrDE=;
Received: from p4ff130c8.dip0.t-ipconnect.de ([79.241.48.200] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1stZJa-0015OQ-05;
	Wed, 25 Sep 2024 23:12:50 +0200
Message-ID: <8f0a91a3-550f-46ec-81a9-021656906471@nbd.name>
Date: Wed, 25 Sep 2024 23:12:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] gso: fix gso fraglist segmentation after pull from
 frag_list
From: Felix Fietkau <nbd@nbd.name>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, stable@vger.kernel.org, maze@google.com,
 shiming.cheng@mediatek.com, daniel@iogearbox.net, lena.wang@mediatek.com,
 herbert@gondor.apana.org.au, Willem de Bruijn <willemb@google.com>
References: <20240922150450.3873767-1-willemdebruijn.kernel@gmail.com>
 <7144e848-9919-44a5-a313-f9b2076532bf@nbd.name>
 <66f46003a38a0_65fdc29433@willemb.c.googlers.com.notmuch>
 <68d4c9cf-f61f-4257-8d98-9a363142cc53@nbd.name>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <68d4c9cf-f61f-4257-8d98-9a363142cc53@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.09.24 22:59, Felix Fietkau wrote:
> On 25.09.24 21:09, Willem de Bruijn wrote:
>> Felix Fietkau wrote:
>>> On 22.09.24 17:03, Willem de Bruijn wrote:
>>> > From: Willem de Bruijn <willemb@google.com>
>>> > 
>>> > Detect gso fraglist skbs with corrupted geometry (see below) and
>>> > pass these to skb_segment instead of skb_segment_list, as the first
>>> > can segment them correctly.
>>> > 
>>> > Valid SKB_GSO_FRAGLIST skbs
>>> > - consist of two or more segments
>>> > - the head_skb holds the protocol headers plus first gso_size
>>> > - one or more frag_list skbs hold exactly one segment
>>> > - all but the last must be gso_size
>>> > 
>>> > Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
>>> > modify these skbs, breaking these invariants.
>>> > 
>>> > In extreme cases they pull all data into skb linear. For UDP, this
>>> > causes a NULL ptr deref in __udpv4_gso_segment_list_csum at
>>> > udp_hdr(seg->next)->dest.
>>> > 
>>> > Detect invalid geometry due to pull, by checking head_skb size.
>>> > Don't just drop, as this may blackhole a destination. Convert to be
>>> > able to pass to regular skb_segment.
>>> > 
>>> > Link: https://lore.kernel.org/netdev/20240428142913.18666-1-shiming.cheng@mediatek.com/
>>> > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
>>> > Signed-off-by: Willem de Bruijn <willemb@google.com>
>>> > Cc: stable@vger.kernel.org
>>> > 
>>> > ---
>>> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>>> > index d842303587af..e457fa9143a6 100644
>>> > --- a/net/ipv4/udp_offload.c
>>> > +++ b/net/ipv4/udp_offload.c
>>> > @@ -296,8 +296,16 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>>> >   		return NULL;
>>> >   	}
>>> >   
>>> > -	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
>>> > -		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
>>> > +	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
>>> > +		 /* Detect modified geometry and pass these to skb_segment. */
>>> > +		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
>>> > +			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
>>> > +
>>> > +		 /* Setup csum, as fraglist skips this in udp4_gro_receive. */
>>> > +		gso_skb->csum_start = skb_transport_header(gso_skb) - gso_skb->head;
>>> > +		gso_skb->csum_offset = offsetof(struct udphdr, check);
>>> > +		gso_skb->ip_summed = CHECKSUM_PARTIAL;
>>> 
>>> I also noticed this uh->check update done by udp4_gro_complete only in 
>>> case of non-fraglist GRO:
>>> 
>>>      if (uh->check)
>>>          uh->check = ~udp_v4_check(skb->len - nhoff, iph->saddr,
>>>                        iph->daddr, 0);
>>> 
>>> I didn't see any equivalent in your patch. Is it missing or left out 
>>> intentionally?
>> 
>> Thanks. That was not intentional. I think you're right. Am a bit
>> concerned that all this testing did not catch it. Perhaps because
>> CHECKSUM_PARTIAL looped to ingress on the same machine is simply
>> interpreted as CHECKSUM_UNNECESSARY. Need to look into that.
>> 
>> If respinning this, I should also change the Fixes to
>> 
>> Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
>> 
>> Analogous to the eventual TCP fix to
>> 
>> Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")
> 
> In the mean time, I've been working on the TCP side. I managed to
> reproduce the issue on one of my devices by routing traffic from
> Ethernet to Wifi using your BPF test program.
> 
> The following patch makes it work for me for TCP v4. Still need to
> test and fix v6.

Actually, here is something even simpler that should work for both v4
and v6:

---
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -101,8 +101,14 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
  	if (!pskb_may_pull(skb, sizeof(struct tcphdr)))
  		return ERR_PTR(-EINVAL);
  
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)
-		return __tcp4_gso_segment_list(skb, features);
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
+		struct tcphdr *th = tcp_hdr(skb);
+
+		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
+			return __tcp4_gso_segment_list(skb, features);
+
+		skb->ip_summed = CHECKSUM_NONE;
+	}
  
  	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
  		const struct iphdr *iph = ip_hdr(skb);
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -159,8 +159,14 @@ static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
  	if (!pskb_may_pull(skb, sizeof(*th)))
  		return ERR_PTR(-EINVAL);
  
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)
-		return __tcp6_gso_segment_list(skb, features);
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
+		struct tcphdr *th = tcp_hdr(skb);
+
+		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
+			return __tcp6_gso_segment_list(skb, features);
+
+		skb->ip_summed = CHECKSUM_NONE;
+	}
  
  	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
  		const struct ipv6hdr *ipv6h = ipv6_hdr(skb);



