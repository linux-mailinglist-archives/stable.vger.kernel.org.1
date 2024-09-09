Return-Path: <stable+bounces-74045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBBE971DEF
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 17:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6831EB234BA
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B736738F82;
	Mon,  9 Sep 2024 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcANq64S"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177051C6B5;
	Mon,  9 Sep 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895213; cv=none; b=jRMAQ7RcpIapAqO4Mn3ZbUBW37px2TxryBpOaOZ2oVn6frQTbnFYqVokOpDNljdPWwhX1nA/Y1bjZnEiER06VEuqZFLe61yivCM/nPuuF6A8o+ePsTjZuhoDKVoyszhcAIWes3MrWK84csTeY3EmwkwlMSCSacnmpx1QHsk5HQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895213; c=relaxed/simple;
	bh=VzqAwpmYh2+2vPP8o4PIizhRt2jEBWUZnmMC8B2Ajl8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GWRrMg+rFan6m0IQ74ZdvNOCJlwARR0micBZ3d3jU6bTKqRUT88o/77N1ewuhCqxujYKK6wC0v3sjq5P/pYatW7Gz0gQLt93fngsUmgIYhZsFJ8+YhqS/FYg3ZGXkuCkfjECBIPd26I1myQzmmGnpUka6A/UKMQk0kemFmXXlbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcANq64S; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c3561804b5so22709496d6.0;
        Mon, 09 Sep 2024 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725895211; x=1726500011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwcuGd0IHyCZQTZ2C8mknQx9xe99Aoj6iFaFPOhzKog=;
        b=PcANq64Sk6K48Uq7SkEoXuckmFuYp1RehkKspdhyE1xzQ4BBdBHXwL0zYBU2hNdddK
         W/p2H4WhtE6q7N2YiVqBQbSk+NiKmaSvFhFco9tw7LJ2jhV5mBrLMhMiq78AJJfUB2xJ
         nttWC6NzV/NlX7GRGAmaI8UzZpdQDz7q1Xbs1dsVWkOH7tW48TVnOiIN4EbkmxKDfKjD
         OoJbin5u1nm64voeJ2z05A5+q+U/CEE5yRfxUyIh5nJXTEDY6X3df+zeO0+D9q9Aq9Sp
         GkytAy5IWDI6fnUONjyhWDVlRnGDdA341LOH8j58g9Uba/EYb8p0FlIKoOSxotSbxCmq
         D0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725895211; x=1726500011;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cwcuGd0IHyCZQTZ2C8mknQx9xe99Aoj6iFaFPOhzKog=;
        b=EMaEJvZwFuZi0TkkIN+7KawTuf6phjB3pS50YG5qQcxJSSYh8WAPTb3NbYcpzUTF+C
         qyuY1Gc04s/NJbaPMn2XXrmYZ1gCTX/U6LsQn4WWM+naD6BleIk4OTbU3WRlkiScGPoV
         kdcVQaNO9BTSKPBOMo7ivQeQdgT65hcyk2u8RQFZPlocZGyeNQDp3ir7os6A9ydqAwBY
         bMLWPu4bZpW6q1WXWBqhl2EiN7mlNCl+efGBe3LckaAwDyq9/dKpqks9VCBuL4SHrE2i
         2jnd8LQjy542ZYRs8+JBWnPS0GmxaT2/c849RONINLzZlufj3aWhrwlnbDOX3DE6cpd6
         cupw==
X-Forwarded-Encrypted: i=1; AJvYcCVy9B0ZCBP5d7Mv2OjI/1smsuz7GBsyXCuRz6U6gALBQxzt22ZfsYODZ1nl7cdQDXcUWoNK+SLv@vger.kernel.org, AJvYcCXBoDzMCjVF01WZ4l7oiGIbpqN9yGv6mZATWahULIQDEyWCJMyorUB6dhJrhv9DHLG0AUBOHg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCXcw9i1sZkYjhxyjXJy8Y2MXYvYqECCMtbQTkaF3lFVqN9K47
	/1ny+wsqEisrkZkvLZUAhZxL3IG8Rajllnvf/B0LrZkz84VpLyC6
X-Google-Smtp-Source: AGHT+IFBkkc/48A2PfrggAO5pXxCSFvY4MJYBcZiDojbU6MqGlT9/Nf+c8p/I2TF6ioEnkGh0TFE3A==
X-Received: by 2002:a05:6214:498b:b0:6c3:5a3c:4f8e with SMTP id 6a1803df08f44-6c5283faeaamr158670396d6.30.1725895210690;
        Mon, 09 Sep 2024 08:20:10 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534786b52sm21368136d6.142.2024.09.09.08.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 08:20:10 -0700 (PDT)
Date: Mon, 09 Sep 2024 11:20:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Wang <jasowang@redhat.com>, 
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
Message-ID: <66df1229c854f_38b8b294a7@willemb.c.googlers.com.notmuch>
In-Reply-To: <CACGkMEvpx9D-XVS5xKpzxqgJKBdSfXxZ182PgjRePD1RzNKtVA@mail.gmail.com>
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

> > > > So I guess VIRTIO_NET_HDR_GSO_* without VIRTIO_NET_HDR_F_DATA_VALID
> > > > would be wrong on rx.
> > > >
> > > > But the new check
> > > >
> > > >         if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
> > > >
> > > >                 [...]
> > > >
> > > >                 case SKB_GSO_TCPV4:
> > > >                 case SKB_GSO_TCPV6:
> > > >                         if (skb->csum_offset != offsetof(struct tcphdr, check))
> > > >                                 return -EINVAL;
> > > >
> > > > should be limited to callers of virtio_net_hdr_to_skb on the tx/GSO path.
> > > >
> > > > Looking what the cleanest/minimal patch is to accomplish that.
> > > >
> > >
> > > virtio_net_hdr_to_skb() translates virtio-net header to skb metadata,
> > > so it's RX. For TX the helper should be virtio_net_hdr_from_skb()
> > > which translates skb metadata to virtio hdr.
> >
> > virtio_net_hdr_to_skb is used by PF_PACKET, tun and tap
> 
> Exactly.
> 
> > when injecting a packet into the egress path.
> 
> For tuntap it's still the RX path. For PF_PACEKT and macvtap, it's the tx.
> 
> Maybe a new parameter to virtio_net_hdr_to_skb()?

This is the most straightforward approach. But requires changse to all
callers, in a patch targeting all the stable branches.

I'd prefer if we can detect ingress vs egress directly.

Based on ip_summed, pkt_type, is_skb_wmem or so. But so far have not
found a suitable condition.

I noticed something else: as you point out TUN is ingress. Unlike
virtnet_receive, it does not set ip_summed to CHECKSUM_UNNECESSARY if
VIRTIO_NET_HDR_F_DATA_VALID. It probably should. GRO expects packets
to have had their integrity verified. CHECKSUM_NONE on ingress is not
correct for GRO.

And also related: no GRO should be generated by a device unless
VIRTIO_NET_HDR_F_DATA_VALID is also passed? I have to check the spec
if it says anything about this.

