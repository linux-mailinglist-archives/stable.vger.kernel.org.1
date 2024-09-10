Return-Path: <stable+bounces-74104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4FC97268A
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 03:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621611F24BDD
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 01:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0446A139D15;
	Tue, 10 Sep 2024 01:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMhURyUV"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D66137772;
	Tue, 10 Sep 2024 01:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725930772; cv=none; b=ccwpWv8xs4yc16GFPzAgCoI3YGFItQiVgekWdqT1e/n8RSqgOkxC5IVcs2X/ohaQX5ivGFWuL4Zs6ezwoMGzenhfk9oChi0GCuOWf3zcH8iE1vGl//NFTGJagjVMZRbvIC9Jl2Ddxtjulh7phX8RclSXcXQ9h7xEghYd78gXdjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725930772; c=relaxed/simple;
	bh=/+gi0Bi+thq/u+ziCp8w+vRN909JNL+QSpro2vx34I4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nk2lbNKwVrwLNrXx+ik/a73xZTYNzdBPPpcKqnEoy6Xqs4jhNW+JbekYfKZ9UZVKV/tKYzcZyhnA1cM7cq9pfCHFHwI7YqD3uxMoh7iwbYKP0HCKJpBhTrAUBSXiDJpLBXg16ACu74JjE7s06R8WfoO9Ov1xhAv+piX1Wv0+L64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMhURyUV; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9ad8a7c63so156338685a.3;
        Mon, 09 Sep 2024 18:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725930770; x=1726535570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HINCAzJlQPxZiw6cH8XY7k9tZ+5Vm2IEo+fWk7r56oY=;
        b=iMhURyUVhI3i5ws0ioezJfOP6qb9MREp1n4NLqm26rpaTwwF3XrKA0PGU1CpHHriLf
         IV/qqUui09aTpxlIl6blrCgDBcw+gIpIn9I2aolOp+pJcotagPOweZipmwCNsm4yTmRV
         mp1rGsgfNyZmWzRmxX4Oam8QAtaf1fKd4zWLNunTzaFkKzqxwC0iSYfrXM2suRcMNKK5
         wFaJfqRhv40cJA2m4O5pmYRnaKSBcG4ARGemD4ayJcD+zifHVbLGWyGHgCLfM/YMqLJy
         IzPqiZNTR2gYEFbcNcAGNqExux06VCZMLDd/W8Rx5xCfsr33XauBBjLnii/CUiXmvsOm
         BpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725930770; x=1726535570;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HINCAzJlQPxZiw6cH8XY7k9tZ+5Vm2IEo+fWk7r56oY=;
        b=aHojq+szk1ew/Uby9UkWUno2cxz+T0n66PRrTfm/GqskcBdqUixYnagVkEnIDQqRWw
         QSRbZcSxS4UVIRawdKkbPXk2r58oUKg71tFpK/99MMcWrD/5vHC51zCGYGTmGgTLym5v
         qR8Gz2ou0VTgW7ks3ph3VF5UcGU+LqApCklf/11Py1OXChODSiF1Rp+fFjtKN37fGXfP
         7rZwljKcsREMj6ljkSvchApCm5kH/qzrz+OcJIqUNc3cgRakHNwtvNHdFn79gs0QB/mv
         ST6gc5i8Lwf4RYpM7TGuUFtHQqh5xUSUO0KDVZvHya5ZgBs6BwTxowOxrSxqYxuf4Eap
         SNbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoC1+bQHOIPycCkjjmOzSH0Sj6mrOYZh5TXmSkLQUHwIwnyQL51oaEB7EDeB1IQowZEtny2zg=@vger.kernel.org, AJvYcCWbgnfsTAssKI+xyrvAveGPuaYX9QdWzCxF3TfNUD0eNd1F0IJ+J2yri/0drDkw16BoyV/dwISy@vger.kernel.org
X-Gm-Message-State: AOJu0YxHbNeotnamEKenlSx4SMhdqHBngm075Sb29LfKtQ3/mTqPPYR9
	oNZFwghOwCldwrlgCXlGowTIWoqFTUocrRUk7DehsJEiVniRh3Bp
X-Google-Smtp-Source: AGHT+IF65R1/LsZL3zGJr4FcZNuHnXdRDsBZi3OgYcu+dlsKvnKxgF6c4h7VxAE0AYxLjWBj0f8BOA==
X-Received: by 2002:a05:620a:178d:b0:7a9:b250:d56a with SMTP id af79cd13be357-7a9b250d81bmr917229485a.1.1725930769768;
        Mon, 09 Sep 2024 18:12:49 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7946633sm265925485a.13.2024.09.09.18.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 18:12:49 -0700 (PDT)
Date: Mon, 09 Sep 2024 21:12:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Szabolcs Nagy <szabolcs.nagy@arm.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 arefev@swemel.ru, 
 alexander.duyck@gmail.com, 
 Willem de Bruijn <willemb@google.com>, 
 stable@vger.kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Felix Fietkau <nbd@nbd.name>, 
 Mark Brown <broonie@kernel.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 nd@arm.com
Message-ID: <66df9d10e88d2_81fd329432@willemb.c.googlers.com.notmuch>
In-Reply-To: <66df641780764_7585d294af@willemb.c.googlers.com.notmuch>
References: <20240729201108.1615114-1-willemdebruijn.kernel@gmail.com>
 <ZtsTGp9FounnxZaN@arm.com>
 <66db2542cfeaa_29a385294b9@willemb.c.googlers.com.notmuch>
 <66de0487cfa91_30614529470@willemb.c.googlers.com.notmuch>
 <20240908164252-mutt-send-email-mst@kernel.org>
 <CACGkMEtchtLYAVgUYGFt3e-1UjNBy+h0Kv-7K3dRiiKEr7gnKw@mail.gmail.com>
 <66de653b4e0f9_cd37294c3@willemb.c.googlers.com.notmuch>
 <CACGkMEtu3c3xVWukFnGriOk4UjKyMVKU7gNQ5v38nHy1q2=DpQ@mail.gmail.com>
 <66de6e0d26a4a_ec892942@willemb.c.googlers.com.notmuch>
 <CACGkMEvpx9D-XVS5xKpzxqgJKBdSfXxZ182PgjRePD1RzNKtVA@mail.gmail.com>
 <66df1229c854f_38b8b294a7@willemb.c.googlers.com.notmuch>
 <66df641780764_7585d294af@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net v2] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Willem de Bruijn wrote:
> > > > > > So I guess VIRTIO_NET_HDR_GSO_* without VIRTIO_NET_HDR_F_DATA_VALID
> > > > > > would be wrong on rx.
> > > > > >
> > > > > > But the new check
> > > > > >
> > > > > >         if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
> > > > > >
> > > > > >                 [...]
> > > > > >
> > > > > >                 case SKB_GSO_TCPV4:
> > > > > >                 case SKB_GSO_TCPV6:
> > > > > >                         if (skb->csum_offset != offsetof(struct tcphdr, check))
> > > > > >                                 return -EINVAL;
> > > > > >
> > > > > > should be limited to callers of virtio_net_hdr_to_skb on the tx/GSO path.
> > > > > >
> > > > > > Looking what the cleanest/minimal patch is to accomplish that.
> > > > > >
> > > > >
> > > > > virtio_net_hdr_to_skb() translates virtio-net header to skb metadata,
> > > > > so it's RX. For TX the helper should be virtio_net_hdr_from_skb()
> > > > > which translates skb metadata to virtio hdr.
> > > >
> > > > virtio_net_hdr_to_skb is used by PF_PACKET, tun and tap
> > > 
> > > Exactly.
> > > 
> > > > when injecting a packet into the egress path.
> > > 
> > > For tuntap it's still the RX path. For PF_PACEKT and macvtap, it's the tx.
> > > 
> > > Maybe a new parameter to virtio_net_hdr_to_skb()?
> > 
> > This is the most straightforward approach. But requires changse to all
> > callers, in a patch targeting all the stable branches.
> > 
> > I'd prefer if we can detect ingress vs egress directly.
> 
> Not doing this, because both on ingress and egress the allowed
> ip_summed types are more relaxed than I imagined.
> 
> Let's just make the check more narrow to avoid such false positives.
> 
> GRO indeed allows CHECKSUM_NONE.
> 
> But TSO also accepts packets that are not CHECKSUM_PARTIAL, and will
> fix up csum_start/csum_off. In tcp4_gso_segment:
> 
>         if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
>                 const struct iphdr *iph = ip_hdr(skb);
>                 struct tcphdr *th = tcp_hdr(skb);
> 
>                 /* Set up checksum pseudo header, usually expect stack to
>                  * have done this already.
>                  */
> 
>                 th->check = 0;
>                 skb->ip_summed = CHECKSUM_PARTIAL;
>                 __tcp_v4_send_check(skb, iph->saddr, iph->daddr);
>         }
> 
> With __tcp_v4_send_check:
> 
> 	void __tcp_v4_send_check(struct sk_buff *skb, __be32 saddr, __be32 daddr)
> 	{
> 		struct tcphdr *th = tcp_hdr(skb);
> 
> 		th->check = ~tcp_v4_check(skb->len, saddr, daddr, 0);
> 		skb->csum_start = skb_transport_header(skb) - skb->head;
> 		skb->csum_offset = offsetof(struct tcphdr, check);
> 	}    
> 
> That means that we can relax the check on input from userspace to
> bad CHECKSUM_PARTIAL input:
> 
> @@ -173,7 +173,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>                         break;
>                 case SKB_GSO_TCPV4:
>                 case SKB_GSO_TCPV6:
> -                       if (skb->csum_offset != offsetof(struct tcphdr, check))
> +                       if (skb->ip_summed == CHECKSUM_PARTIAL &&
> +                           skb->csum_offset != offsetof(struct tcphdr, check))
>                                 return -EINVAL;
> 
> I've verified that this test still catches the bad packet from the
> syzkaller report in the Link in the commit.

Sent: https://lore.kernel.org/netdev/20240910004033.530313-1-willemdebruijn.kernel@gmail.com/T/#u
 
> > Based on ip_summed, pkt_type, is_skb_wmem or so. But so far have not
> > found a suitable condition.
> > 
> > I noticed something else: as you point out TUN is ingress. Unlike
> > virtnet_receive, it does not set ip_summed to CHECKSUM_UNNECESSARY if
> > VIRTIO_NET_HDR_F_DATA_VALID. It probably should. GRO expects packets
> > to have had their integrity verified. CHECKSUM_NONE on ingress is not
> > correct for GRO.

Actually CHECKSUM_NONE is allowed. It just triggers software checksum
validation.

Tun by default does not use GRO, only if enabling IFF_NAPI.

If a packet arrives at GRO with CHECKSUM_PARTIAL, then its checksum is
assumed valid, per __skb_gro_checksum_validate_needed. So that would
be one way for tun users today to get efficient GRO.

> > And also related: no GRO should be generated by a device unless
> > VIRTIO_NET_HDR_F_DATA_VALID is also passed? I have to check the spec
> > if it says anything about this.

Given that GRO handles !CHECKSUM_UNNECESSARY, probably no need to
require VIRTIO_NET_HDR_F_DATA_VALID with virtio GRO either.


