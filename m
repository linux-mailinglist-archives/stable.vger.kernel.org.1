Return-Path: <stable+bounces-77753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA74986DD5
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 09:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541A21F22B24
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 07:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D021898F0;
	Thu, 26 Sep 2024 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="GlqYWxa9"
X-Original-To: stable@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AECE1925A2;
	Thu, 26 Sep 2024 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336298; cv=none; b=Pif7XzFdIE76pRLUs8/DbLCILfftyqgxMSbioTkSkmTAff0Ym4ObL8wf1Nn/l4KeDZGf/VkfRy19YSYpyhXhImJlVu+ykiTmaBGWtMUDYeS2wTQjGRGx4c2b6q1f1aH1c1M3F1NJwda9fCeuJJnyBbUVeQqOa9gp2opuAyU0P4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336298; c=relaxed/simple;
	bh=iCCZJrQZDe2xg86gI5ECzRvHL32rTU7ZnkDgQ7YiTvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZExWtpZ4vP+ds69ZNydeO7Jkh45W0jYA+aYQnFaAp7380WP2l0mVh3ngG04dql1jJsexgOyTrhVGGPNsCNwifWJXmFc6lv9TBH/1oX4bFG9lPaeI6PglvDybrE8BfV2dPK5HqF/nZARO6jnH2FkpPjgFbJwF6lK/ozbSZ4qnxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=GlqYWxa9; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oZQidhvB9AiP666SDRLQqqlTZweXQrXgNxzS1i3Nnko=; b=GlqYWxa9dKOx5BFa7BmUI9M5NP
	i/jcaTmU1OvyNF0ZOXNZ1S/Je2YggWXcZHF1w4mRuhhY6X7iZHWkvbPAOA/2sHQ6wqBT6SCKkwkGN
	OzcatGicc3068TfCtouLUIlMrXfekDRgqSED56yZx3dKxAAncFasgQCcQ96t1J453IJE=;
Received: from p4ff130c8.dip0.t-ipconnect.de ([79.241.48.200] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1stj4f-001Huq-07;
	Thu, 26 Sep 2024 09:38:05 +0200
Message-ID: <53360620-839e-49d1-b9e4-6359e7588d81@nbd.name>
Date: Thu, 26 Sep 2024 09:38:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] gso: fix gso fraglist segmentation after pull from
 frag_list
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, stable@vger.kernel.org, maze@google.com,
 shiming.cheng@mediatek.com, daniel@iogearbox.net, lena.wang@mediatek.com,
 herbert@gondor.apana.org.au, Willem de Bruijn <willemb@google.com>
References: <20240922150450.3873767-1-willemdebruijn.kernel@gmail.com>
 <7144e848-9919-44a5-a313-f9b2076532bf@nbd.name>
 <66f46003a38a0_65fdc29433@willemb.c.googlers.com.notmuch>
 <68d4c9cf-f61f-4257-8d98-9a363142cc53@nbd.name>
 <8f0a91a3-550f-46ec-81a9-021656906471@nbd.name>
 <66f50b09cc7a5_7f2c829476@willemb.c.googlers.com.notmuch>
From: Felix Fietkau <nbd@nbd.name>
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
In-Reply-To: <66f50b09cc7a5_7f2c829476@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.09.24 09:19, Willem de Bruijn wrote:
> Felix Fietkau wrote:
>> On 25.09.24 22:59, Felix Fietkau wrote:
>> > On 25.09.24 21:09, Willem de Bruijn wrote:
>> >> Felix Fietkau wrote:
>> >>> On 22.09.24 17:03, Willem de Bruijn wrote:
>> >>> > From: Willem de Bruijn <willemb@google.com>
>> >>> > 
>> >>> > Detect gso fraglist skbs with corrupted geometry (see below) and
>> >>> > pass these to skb_segment instead of skb_segment_list, as the first
>> >>> > can segment them correctly.
>> >>> > 
>> >>> > Valid SKB_GSO_FRAGLIST skbs
>> >>> > - consist of two or more segments
>> >>> > - the head_skb holds the protocol headers plus first gso_size
>> >>> > - one or more frag_list skbs hold exactly one segment
>> >>> > - all but the last must be gso_size
>> >>> > 
>> >>> > Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
>> >>> > modify these skbs, breaking these invariants.
>> >>> > 
>> >>> > In extreme cases they pull all data into skb linear. For UDP, this
>> >>> > causes a NULL ptr deref in __udpv4_gso_segment_list_csum at
>> >>> > udp_hdr(seg->next)->dest.
>> >>> > 
>> >>> > Detect invalid geometry due to pull, by checking head_skb size.
>> >>> > Don't just drop, as this may blackhole a destination. Convert to be
>> >>> > able to pass to regular skb_segment.
>> >>> > 
>> >>> > Link: https://lore.kernel.org/netdev/20240428142913.18666-1-shiming.cheng@mediatek.com/
>> >>> > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
>> >>> > Signed-off-by: Willem de Bruijn <willemb@google.com>
>> >>> > Cc: stable@vger.kernel.org
>> >>> > 
>> >>> > ---
>> >>> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>> >>> > index d842303587af..e457fa9143a6 100644
>> >>> > --- a/net/ipv4/udp_offload.c
>> >>> > +++ b/net/ipv4/udp_offload.c
>> >>> > @@ -296,8 +296,16 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
>> >>> >   		return NULL;
>> >>> >   	}
>> >>> >   
>> >>> > -	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
>> >>> > -		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
>> >>> > +	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
>> >>> > +		 /* Detect modified geometry and pass these to skb_segment. */
>> >>> > +		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
>> >>> > +			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
>> >>> > +
>> >>> > +		 /* Setup csum, as fraglist skips this in udp4_gro_receive. */
>> >>> > +		gso_skb->csum_start = skb_transport_header(gso_skb) - gso_skb->head;
>> >>> > +		gso_skb->csum_offset = offsetof(struct udphdr, check);
>> >>> > +		gso_skb->ip_summed = CHECKSUM_PARTIAL;
>> >>> 
>> >>> I also noticed this uh->check update done by udp4_gro_complete only in 
>> >>> case of non-fraglist GRO:
>> >>> 
>> >>>      if (uh->check)
>> >>>          uh->check = ~udp_v4_check(skb->len - nhoff, iph->saddr,
>> >>>                        iph->daddr, 0);
>> >>> 
>> >>> I didn't see any equivalent in your patch. Is it missing or left out 
>> >>> intentionally?
>> >> 
>> >> Thanks. That was not intentional. I think you're right. Am a bit
>> >> concerned that all this testing did not catch it. Perhaps because
>> >> CHECKSUM_PARTIAL looped to ingress on the same machine is simply
>> >> interpreted as CHECKSUM_UNNECESSARY. Need to look into that.
>> >> 
>> >> If respinning this, I should also change the Fixes to
>> >> 
>> >> Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
>> >> 
>> >> Analogous to the eventual TCP fix to
>> >> 
>> >> Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")
>> > 
>> > In the mean time, I've been working on the TCP side. I managed to
>> > reproduce the issue on one of my devices by routing traffic from
>> > Ethernet to Wifi using your BPF test program.
>> > 
>> > The following patch makes it work for me for TCP v4. Still need to
>> > test and fix v6.
>> 
>> Actually, here is something even simpler that should work for both v4
>> and v6:
> 
> Makes sense. It does come with higher cost of calling skb_checksum.

But only if there is no checksum offload, right? Because the way I 
implemented it, the lines further below starting with
if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL))
will initialize th->check and set ip_summed to CHECKSUM_PARTIAL
Or am I missing something?

Thanks,

- Felix

