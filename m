Return-Path: <stable+bounces-77754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18828986DF6
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 09:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6231F22CC7
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 07:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6B519413B;
	Thu, 26 Sep 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlAplQxs"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C3718A6CC;
	Thu, 26 Sep 2024 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336761; cv=none; b=rKp0ahifVS6+7ob5mtguhhRYsUGTXLjYfZzV7RPwXqhwy0++HdDQd4dGlNFrIXkgxKxvHDtVxiB8AMaupye3gaQeftbqHlJU5U+IO5FtFTvKXgP8JhLnvByDuSvM78svMO5fOUe67sDuTTzj1JeobgyN1a0DtbJ4PdmYVCNf+go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336761; c=relaxed/simple;
	bh=SdqpJwMmXTmzUDDkJQ725mPYMAS1ZliWU81FoHZh0uU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Lf9qetMyL1MJYuss6Ez6WtxywfP3Xt18+O78ri3VkBswEO4jr4MZi4rW8JSu1tBusIykZ98z6mOXi/0EuUfkIDgHbcioXpPti/Ne/1R4cA4YXS9H3s6JKD6pGPPstPMMDSXvfMxVlidsoXg2RhXVHbzYwHY/54dB0vp3EFhJed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlAplQxs; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a9acc6f22dso64151285a.0;
        Thu, 26 Sep 2024 00:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727336757; x=1727941557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOa+qevS88hKr6XJizmSWr1ug3nZN/jBIEw4g6p+wFQ=;
        b=dlAplQxsHUplrbN7v5Szo085xwaeooCqMJl0XWsDM9xTGnJcl7sCu4NK6EExKoqHEs
         HT2pLEmnfk74jrceZf8PLWWAAjcuQelS3AvtvURyAB9Mtl4a4oR4hn/EpqN/KxfP74zM
         lUSbWG4I8krCahI6sogfu8U1vlML+SSbd0oJvlkFZdoRcoMKopwTBTXAm2exEosGE7Fv
         mH/vY+VEq2aYVw7Py8uc2A1zPU/PsowdYksD9cdUo/Ia7alXng88a2It5CiIdV+IBedP
         uCmN+A7ehw/eS/fjjP2HYthTzSSRe7inQfkctkWP7cR3VjGgUQ+xYV+UDMZWCvIkezA+
         7ySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727336757; x=1727941557;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WOa+qevS88hKr6XJizmSWr1ug3nZN/jBIEw4g6p+wFQ=;
        b=ttosNJWvlV7pwJuDANiS86YqFy8ECoZZ1KAkjXFf3MJbnkG5lnvh5+4MiV25osAekP
         kL+y9gb/Mev21OLsGjJDhVy+juVE8JA4PHUon3vhMJw+HwCsgwr8XnVLNk9ZLtbJarNA
         corHIRdYUEdWouYF4SkCwrfKoW4J1U7BoLFcKuP1da4PMAw7hIfLqHgWWgvSk+Cgu+Ur
         Xii4jXkn0/Z+AnsYfAE6XUvDccEkHOxYkORvfoBIDtvIypOdH/16O7f7LH1dd8E8WDwJ
         sx4IGS9/DJTM8wJVUR83ItEJwsqnT4xfUEkICRgdFFfgBKnDsgyffkO0OVNjkMju6bAt
         40Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWNfzaOrAK8Lu80Hx9PTHYtIFhuU2uEnSYZiErHBg6EZo5fz5mCi+jwyeyNvzmzcIoF3DVjagk=@vger.kernel.org, AJvYcCXOREeZx1B4d3EngeNuPfBJCybpyou2bskdiDTqPHNuHdDlzVxVqC0tYToWGIxseRhfJJ54qo4n@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2SaAwtW06QSKER4HfgVJhMwgtooytAmPNpjlq8hlVatlPIR/6
	RcIRDX/FfUP42gYdJqnRXsuHkupqr1P1/DjH3wXZKMC8O4rPxfEd
X-Google-Smtp-Source: AGHT+IFixc9udZ8zRQ781OtK/cEg5/2iQK6vVq3B3ydJPrCSby0LPr6zrU+6jZUSApDNrlGf80tz6Q==
X-Received: by 2002:a05:620a:284a:b0:7a5:1ca:d008 with SMTP id af79cd13be357-7ace7482cf7mr703420485a.66.1727336757366;
        Thu, 26 Sep 2024 00:45:57 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde5fe6cfsm253155885a.100.2024.09.26.00.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 00:45:56 -0700 (PDT)
Date: Thu, 26 Sep 2024 03:45:56 -0400
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
Message-ID: <66f5113434b43_802f9294d8@willemb.c.googlers.com.notmuch>
In-Reply-To: <53360620-839e-49d1-b9e4-6359e7588d81@nbd.name>
References: <20240922150450.3873767-1-willemdebruijn.kernel@gmail.com>
 <7144e848-9919-44a5-a313-f9b2076532bf@nbd.name>
 <66f46003a38a0_65fdc29433@willemb.c.googlers.com.notmuch>
 <68d4c9cf-f61f-4257-8d98-9a363142cc53@nbd.name>
 <8f0a91a3-550f-46ec-81a9-021656906471@nbd.name>
 <66f50b09cc7a5_7f2c829476@willemb.c.googlers.com.notmuch>
 <53360620-839e-49d1-b9e4-6359e7588d81@nbd.name>
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
> On 26.09.24 09:19, Willem de Bruijn wrote:
> > Felix Fietkau wrote:
> >> On 25.09.24 22:59, Felix Fietkau wrote:
> >> > On 25.09.24 21:09, Willem de Bruijn wrote:
> >> >> Felix Fietkau wrote:
> >> >>> On 22.09.24 17:03, Willem de Bruijn wrote:
> >> >>> > From: Willem de Bruijn <willemb@google.com>
> >> >>> > 
> >> >>> > Detect gso fraglist skbs with corrupted geometry (see below) and
> >> >>> > pass these to skb_segment instead of skb_segment_list, as the first
> >> >>> > can segment them correctly.
> >> >>> > 
> >> >>> > Valid SKB_GSO_FRAGLIST skbs
> >> >>> > - consist of two or more segments
> >> >>> > - the head_skb holds the protocol headers plus first gso_size
> >> >>> > - one or more frag_list skbs hold exactly one segment
> >> >>> > - all but the last must be gso_size
> >> >>> > 
> >> >>> > Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
> >> >>> > modify these skbs, breaking these invariants.
> >> >>> > 
> >> >>> > In extreme cases they pull all data into skb linear. For UDP, this
> >> >>> > causes a NULL ptr deref in __udpv4_gso_segment_list_csum at
> >> >>> > udp_hdr(seg->next)->dest.
> >> >>> > 
> >> >>> > Detect invalid geometry due to pull, by checking head_skb size.
> >> >>> > Don't just drop, as this may blackhole a destination. Convert to be
> >> >>> > able to pass to regular skb_segment.
> >> >>> > 
> >> >>> > Link: https://lore.kernel.org/netdev/20240428142913.18666-1-shiming.cheng@mediatek.com/
> >> >>> > Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> >> >>> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> >> >>> > Cc: stable@vger.kernel.org
> >> >>> > 
> >> >>> > ---
> >> >>> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> >> >>> > index d842303587af..e457fa9143a6 100644
> >> >>> > --- a/net/ipv4/udp_offload.c
> >> >>> > +++ b/net/ipv4/udp_offload.c
> >> >>> > @@ -296,8 +296,16 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
> >> >>> >   		return NULL;
> >> >>> >   	}
> >> >>> >   
> >> >>> > -	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
> >> >>> > -		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
> >> >>> > +	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
> >> >>> > +		 /* Detect modified geometry and pass these to skb_segment. */
> >> >>> > +		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
> >> >>> > +			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
> >> >>> > +
> >> >>> > +		 /* Setup csum, as fraglist skips this in udp4_gro_receive. */
> >> >>> > +		gso_skb->csum_start = skb_transport_header(gso_skb) - gso_skb->head;
> >> >>> > +		gso_skb->csum_offset = offsetof(struct udphdr, check);
> >> >>> > +		gso_skb->ip_summed = CHECKSUM_PARTIAL;
> >> >>> 
> >> >>> I also noticed this uh->check update done by udp4_gro_complete only in 
> >> >>> case of non-fraglist GRO:
> >> >>> 
> >> >>>      if (uh->check)
> >> >>>          uh->check = ~udp_v4_check(skb->len - nhoff, iph->saddr,
> >> >>>                        iph->daddr, 0);
> >> >>> 
> >> >>> I didn't see any equivalent in your patch. Is it missing or left out 
> >> >>> intentionally?
> >> >> 
> >> >> Thanks. That was not intentional. I think you're right. Am a bit
> >> >> concerned that all this testing did not catch it. Perhaps because
> >> >> CHECKSUM_PARTIAL looped to ingress on the same machine is simply
> >> >> interpreted as CHECKSUM_UNNECESSARY. Need to look into that.
> >> >> 
> >> >> If respinning this, I should also change the Fixes to
> >> >> 
> >> >> Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> >> >> 
> >> >> Analogous to the eventual TCP fix to
> >> >> 
> >> >> Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")
> >> > 
> >> > In the mean time, I've been working on the TCP side. I managed to
> >> > reproduce the issue on one of my devices by routing traffic from
> >> > Ethernet to Wifi using your BPF test program.
> >> > 
> >> > The following patch makes it work for me for TCP v4. Still need to
> >> > test and fix v6.
> >> 
> >> Actually, here is something even simpler that should work for both v4
> >> and v6:
> > 
> > Makes sense. It does come with higher cost of calling skb_checksum.
> 
> But only if there is no checksum offload, right? Because the way I 
> implemented it, the lines further below starting with
> if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL))
> will initialize th->check and set ip_summed to CHECKSUM_PARTIAL
> Or am I missing something?

Oh you're right, __tcp_v4_send_check then does this, so no need to
open code it.

