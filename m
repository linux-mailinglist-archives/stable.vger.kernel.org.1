Return-Path: <stable+bounces-77727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0649866AA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 21:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DF81C21515
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 19:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF82013D537;
	Wed, 25 Sep 2024 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2UgPLKe"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75A208CA;
	Wed, 25 Sep 2024 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727291399; cv=none; b=FOd9ZJmHXcYlMy/EB4vROdYDmz/RxKeK9GsAXVEzy7CJbnnHbpa3Jps9yc1C1wjZltrOMIGAbsGXiL/2m0UqUY7FotkF9BGCnYYeMYE5K9hpeSue3yLoA50v3t9yIRjWzCP/t3eS/yYrWdfhMXdLIKGI3yjPyn0k+MROx+RPdAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727291399; c=relaxed/simple;
	bh=XgzzO7BvLa1jhrNSJN+s9eHI4nPfs/hHTlS2vlCydYo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZTq+JriplPUxxXLPyA0IC5U7X1+qvR0dWeRS6gK0fLqoI9bmQchjMtg+D9wXccNi5dxSbiE6O/7eaPW8wgy5ccHAc0OnppIoMlD0ySXlJw45rx7XqjO/wFYMoPg0gl1rLScNwSk8Yj4S2ulNXSz9IYfpiej2eYKv0+zsTzht4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2UgPLKe; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1da3677ca7so197967276.0;
        Wed, 25 Sep 2024 12:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727291397; x=1727896197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IXX5hZYX0rd+Vau+2PzwfqSnvCnE5oSpXgKvObg+pY=;
        b=T2UgPLKehdklVliE0Z48zd94m1zGHNnYe6GMXHlYY9sGogZGuVLo9jQBDsdQlb6YBf
         n4jIkms15wNmpr50dShWErkH6sTEfOZlJJMO9Xjvc0Hgy6ZybYcuIXLEYOr+axw6u1P8
         vMUZShDNu6cqruiwvlohi1dZ5JijOlOP3hAakuuDJetCWSNH+Dq4Ay12jFMsLvM4zyCc
         GIglIniMokHNGJhGdmoKVQ/ezjsUvKJGW+389nJDC1l0xK3Wr6dh/JXZZ/Uejl0L3z/Q
         XopXeqgM/sTdtPA1Qn8D4wA0uqTGwdRD3rvMzrdznlqKUlpWFfuacIPNY0MUW/yOfMaS
         6qbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727291397; x=1727896197;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+IXX5hZYX0rd+Vau+2PzwfqSnvCnE5oSpXgKvObg+pY=;
        b=dfGdOtfZGHTiBNlgoYJfx3q93jyEtLgyjsdIRXTmotf6o+LqMI2xLiAjmfSqDyb+Hn
         wP46Sa5r0/S4q0KjNWAuemj1eVJWkDW3fhQeE5SYkxVvkX8+fm+ZSn4PvafEUNQUQ8+y
         oDhmmv+SmzoZMaTfJX4vWl6FlOANHIM5forrhBrxEFrw6FudJnfIviSm1Sd0TS2IE69F
         bmlqA2Icxodqr+Y4DFasOUM4JTGQizGWmlZFtFDhggEmbMUiyFt4Y0j1vCxMFJ//VN3j
         w7bzwssoQWnoXt+0ABVRVNHRvgTXa+ikZxsjapWkNJmaE5gQKKkGK+W7+h/PJp90UbSF
         LK2w==
X-Forwarded-Encrypted: i=1; AJvYcCX+YRPlfOsYb+dAFfD/2EgWCEQKiaTNDwOoxB1p6W1F91jvC9f+TWI8vljCvMEJOSUlRcXL6r6m@vger.kernel.org, AJvYcCXJI5utZYDEmq3Wu691EOpwMX9RmHpJHDYm9vPDStRQT+I1KDypqJDuLGK+Ko+lubGbLJRQX3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhC0VOYWkl3p2eB1soeU7luVw73qyhk0Cq4W53cHTIkjmeKlt7
	r4tFJ4ybZ32Y6bVHAuJe2T0J/M0f6yzBYnhyLDOIkH/KVGWMflKs
X-Google-Smtp-Source: AGHT+IE4wzk1lLYGMrHTjBPl8ZJap2YFrFUo6E0ytdzbnGSA30eZnB8mbmO4eZGbwnq1dd+rOfEH6g==
X-Received: by 2002:a05:6902:91f:b0:e25:bc9e:74ba with SMTP id 3f1490d57ef6-e25bc9e7656mr1841689276.50.1727291396850;
        Wed, 25 Sep 2024 12:09:56 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b53ba080fsm17626701cf.17.2024.09.25.12.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 12:09:55 -0700 (PDT)
Date: Wed, 25 Sep 2024 15:09:55 -0400
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
Message-ID: <66f46003a38a0_65fdc29433@willemb.c.googlers.com.notmuch>
In-Reply-To: <7144e848-9919-44a5-a313-f9b2076532bf@nbd.name>
References: <20240922150450.3873767-1-willemdebruijn.kernel@gmail.com>
 <7144e848-9919-44a5-a313-f9b2076532bf@nbd.name>
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
> On 22.09.24 17:03, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > Detect gso fraglist skbs with corrupted geometry (see below) and
> > pass these to skb_segment instead of skb_segment_list, as the first
> > can segment them correctly.
> > 
> > Valid SKB_GSO_FRAGLIST skbs
> > - consist of two or more segments
> > - the head_skb holds the protocol headers plus first gso_size
> > - one or more frag_list skbs hold exactly one segment
> > - all but the last must be gso_size
> > 
> > Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
> > modify these skbs, breaking these invariants.
> > 
> > In extreme cases they pull all data into skb linear. For UDP, this
> > causes a NULL ptr deref in __udpv4_gso_segment_list_csum at
> > udp_hdr(seg->next)->dest.
> > 
> > Detect invalid geometry due to pull, by checking head_skb size.
> > Don't just drop, as this may blackhole a destination. Convert to be
> > able to pass to regular skb_segment.
> > 
> > Link: https://lore.kernel.org/netdev/20240428142913.18666-1-shiming.cheng@mediatek.com/
> > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > Cc: stable@vger.kernel.org
> > 
> > ---
> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > index d842303587af..e457fa9143a6 100644
> > --- a/net/ipv4/udp_offload.c
> > +++ b/net/ipv4/udp_offload.c
> > @@ -296,8 +296,16 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
> >   		return NULL;
> >   	}
> >   
> > -	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
> > -		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
> > +	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
> > +		 /* Detect modified geometry and pass these to skb_segment. */
> > +		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
> > +			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
> > +
> > +		 /* Setup csum, as fraglist skips this in udp4_gro_receive. */
> > +		gso_skb->csum_start = skb_transport_header(gso_skb) - gso_skb->head;
> > +		gso_skb->csum_offset = offsetof(struct udphdr, check);
> > +		gso_skb->ip_summed = CHECKSUM_PARTIAL;
> 
> I also noticed this uh->check update done by udp4_gro_complete only in 
> case of non-fraglist GRO:
> 
>      if (uh->check)
>          uh->check = ~udp_v4_check(skb->len - nhoff, iph->saddr,
>                        iph->daddr, 0);
> 
> I didn't see any equivalent in your patch. Is it missing or left out 
> intentionally?

Thanks. That was not intentional. I think you're right. Am a bit
concerned that all this testing did not catch it. Perhaps because
CHECKSUM_PARTIAL looped to ingress on the same machine is simply
interpreted as CHECKSUM_UNNECESSARY. Need to look into that.

If respinning this, I should also change the Fixes to

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")

Analogous to the eventual TCP fix to

Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")



