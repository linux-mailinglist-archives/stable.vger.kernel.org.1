Return-Path: <stable+bounces-77751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F90A986D64
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 09:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A377B21624
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 07:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9048F18757D;
	Thu, 26 Sep 2024 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea0Ngpiu"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55E9224D6;
	Thu, 26 Sep 2024 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727335011; cv=none; b=Smy6lA0hrXvs5jaJ3rbMryAONOmLfpjRYT9DJSxs4/4mUC+N6i/umBL6ROXkQCoF1eYHKh/VI9cv9YZY/wZmQZaB9Cql102Qzv58xw2gjcg246XBupLMTyvOo4m1ywlI+ATkfyeCxEaYreh8oJkUwc8WEis5YXdnZfCUZcB7I4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727335011; c=relaxed/simple;
	bh=LWjGT2Gr+ZMG+tKYbR8nwf4vumpQa+ESYzjftkcf+0s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HbiQP4Bn3CvqfmFhy/o9g3JYJrQAGjjqTGKphWHFtePOrhuEs0C+hqm1w5Uga1ZDniezLDoMb6Th57+ZrkI+zOhPEMQLMG5Kk8/pD4jx46V3s85zfwrydytdShib/+djNCS1nSzdO4ocdmARd/Bv5/QNCPuQiFSw6zlNAAtSLFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea0Ngpiu; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cb2dffcdbbso5530906d6.1;
        Thu, 26 Sep 2024 00:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727335008; x=1727939808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2zsMmhiDr9gq5nStV9876dYsj34DWE3RKg9PEeccy8=;
        b=Ea0Ngpiu8oTj8XTql5pb9modTvm34oJw5wtaF9cKHfYE92CWJvVHOpq3YtR3ZeOJYo
         SGHMSa4DHCcVkJpKT2A3wY3iBKpb6nhTJdiqhxLyHQak8zg2PSGPgxrPex/c59mDvOTv
         e3NZB1jO8u4vxe5RGBwQY6sKRm6bnPST4nKjsMXvqNt//07ccKMnQArg3ct7dAeMtY7f
         a00crQbcPoM5cPaRfMCkBkEgcsrankyKBJeZObc8tWx0LMN3ntU1w0Y21FYvYN2GOjiv
         RBmhde6N8JFHrR3r1JmDfYZBOJBQPeJG+PoXIzCE18JBlWwkrB+X3S8EIcaGNgibQNcV
         v2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727335008; x=1727939808;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O2zsMmhiDr9gq5nStV9876dYsj34DWE3RKg9PEeccy8=;
        b=cXB6pTswlrHyOcJ1ncxJG4Sq1raRwG6sebrMfKDkkH6efizY/jdSJUGDnosFJC7gA0
         caN+mKAp70fiT4YBy/KJ/Sb0/9iHRLdYUBcGFyIYBVqIoGSvlX2ZXGMax3tNY9zsspt1
         fZ/l7MuAlTOzRZpNz4umyXjeKVoLiXEgkIqzFrHmqTNh4ZlWk+ugrtlUDEvVxX4mAL1w
         UtAgeZVPfl3u040Bf1KDi9NqC0kwo/+eE2jJA4184Yp0uyOwbKtAOclW3hd+5VEGac/c
         Q8FTt8t0OBtERYo/kXthJPNKvDSnyw+KkklpihNSZssf354/HfEzTK28zWMp1LLcTysZ
         qC6w==
X-Forwarded-Encrypted: i=1; AJvYcCXQZMc7yxo7t+yHVMEt/QZkdodZ95y26uIXru5w+pdq+GzgppOFlMxKFj6arZOcrzfmt4NUycdj@vger.kernel.org, AJvYcCXurmBlYORSJ7ZqzKHrs5Shx01MFzwkct7gqy0BxjACcxJsh/5x3EWS+lmPqrINfUbooCN3WNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHOLN9xxUI8gXu4mAiSITeUuSv5jYcclB9dVj8p9x9AR+voJJn
	RMBkB0MzGaqJP1HjDgCn+Hadld1inYeq8bmubfud9Rj+7/Nz3LH+
X-Google-Smtp-Source: AGHT+IFj2wbTYbytJjGQlxdhF6xQCwgx0DCmfdPgS9SobUsMJRre/T+kxa5x3iRiqtXB2MjRBmhChQ==
X-Received: by 2002:a05:6214:3c9a:b0:6c5:7b99:cab with SMTP id 6a1803df08f44-6cb1dd17659mr72028356d6.8.1727335008310;
        Thu, 26 Sep 2024 00:16:48 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4e3a9asm23021676d6.69.2024.09.26.00.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 00:16:47 -0700 (PDT)
Date: Thu, 26 Sep 2024 03:16:46 -0400
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
Message-ID: <66f50a5ebe2f6_7f2c829418@willemb.c.googlers.com.notmuch>
In-Reply-To: <68d4c9cf-f61f-4257-8d98-9a363142cc53@nbd.name>
References: <20240922150450.3873767-1-willemdebruijn.kernel@gmail.com>
 <7144e848-9919-44a5-a313-f9b2076532bf@nbd.name>
 <66f46003a38a0_65fdc29433@willemb.c.googlers.com.notmuch>
 <68d4c9cf-f61f-4257-8d98-9a363142cc53@nbd.name>
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
> On 25.09.24 21:09, Willem de Bruijn wrote:
> > Felix Fietkau wrote:
> >> On 22.09.24 17:03, Willem de Bruijn wrote:
> >> > From: Willem de Bruijn <willemb@google.com>
> >> > 
> >> > Detect gso fraglist skbs with corrupted geometry (see below) and
> >> > pass these to skb_segment instead of skb_segment_list, as the first
> >> > can segment them correctly.
> >> > 
> >> > Valid SKB_GSO_FRAGLIST skbs
> >> > - consist of two or more segments
> >> > - the head_skb holds the protocol headers plus first gso_size
> >> > - one or more frag_list skbs hold exactly one segment
> >> > - all but the last must be gso_size
> >> > 
> >> > Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
> >> > modify these skbs, breaking these invariants.
> >> > 
> >> > In extreme cases they pull all data into skb linear. For UDP, this
> >> > causes a NULL ptr deref in __udpv4_gso_segment_list_csum at
> >> > udp_hdr(seg->next)->dest.
> >> > 
> >> > Detect invalid geometry due to pull, by checking head_skb size.
> >> > Don't just drop, as this may blackhole a destination. Convert to be
> >> > able to pass to regular skb_segment.
> >> > 
> >> > Link: https://lore.kernel.org/netdev/20240428142913.18666-1-shiming.cheng@mediatek.com/
> >> > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> >> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> >> > Cc: stable@vger.kernel.org
> >> > 
> >> > ---
> >> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> >> > index d842303587af..e457fa9143a6 100644
> >> > --- a/net/ipv4/udp_offload.c
> >> > +++ b/net/ipv4/udp_offload.c
> >> > @@ -296,8 +296,16 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
> >> >   		return NULL;
> >> >   	}
> >> >   
> >> > -	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
> >> > -		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
> >> > +	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
> >> > +		 /* Detect modified geometry and pass these to skb_segment. */
> >> > +		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
> >> > +			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
> >> > +
> >> > +		 /* Setup csum, as fraglist skips this in udp4_gro_receive. */
> >> > +		gso_skb->csum_start = skb_transport_header(gso_skb) - gso_skb->head;
> >> > +		gso_skb->csum_offset = offsetof(struct udphdr, check);
> >> > +		gso_skb->ip_summed = CHECKSUM_PARTIAL;
> >> 
> >> I also noticed this uh->check update done by udp4_gro_complete only in 
> >> case of non-fraglist GRO:
> >> 
> >>      if (uh->check)
> >>          uh->check = ~udp_v4_check(skb->len - nhoff, iph->saddr,
> >>                        iph->daddr, 0);
> >> 
> >> I didn't see any equivalent in your patch. Is it missing or left out 
> >> intentionally?
> > 
> > Thanks. That was not intentional. I think you're right. Am a bit
> > concerned that all this testing did not catch it. Perhaps because
> > CHECKSUM_PARTIAL looped to ingress on the same machine is simply
> > interpreted as CHECKSUM_UNNECESSARY. Need to look into that.
> > 
> > If respinning this, I should also change the Fixes to
> > 
> > Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> > 
> > Analogous to the eventual TCP fix to
> > 
> > Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")
> 
> In the mean time, I've been working on the TCP side. I managed to
> reproduce the issue on one of my devices by routing traffic from
> Ethernet to Wifi using your BPF test program.
> 
> The following patch makes it work for me for TCP v4. Still need to
> test and fix v6.
> 
> - Felix
> 
> ---
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -101,8 +101,20 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
>   	if (!pskb_may_pull(skb, sizeof(struct tcphdr)))
>   		return ERR_PTR(-EINVAL);
>   
> -	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)
> -		return __tcp4_gso_segment_list(skb, features);
> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
> +		struct tcphdr *th = tcp_hdr(skb);
> +		const struct iphdr *iph;
> +
> +		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
> +			return __tcp4_gso_segment_list(skb, features);
> +
> +		iph = ip_hdr(skb);
> +		skb_shinfo(skb)->gso_type &= ~SKB_GSO_FRAGLIST;

I left this out, because skb_segment does not care about this bit.

> +		skb->csum_start = (unsigned char *)th - skb->head;
> +		skb->csum_offset = offsetof(struct tcphdr, check);
> +		skb->ip_summed = CHECKSUM_PARTIAL;
> +		th->check = ~tcp_v4_check(skb->len, iph->saddr, iph->daddr, 0);
> +	}
>   
>   	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
>   		const struct iphdr *iph = ip_hdr(skb);
> 



