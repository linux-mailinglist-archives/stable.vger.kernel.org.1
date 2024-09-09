Return-Path: <stable+bounces-74088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976AC97243C
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 23:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967EB1C22E72
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 21:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9D818C012;
	Mon,  9 Sep 2024 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERwDth0p"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B2A189F2F;
	Mon,  9 Sep 2024 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725916187; cv=none; b=ShZQaQIlrg7aM92R3WYqlA63IY1ia751yDn+lTEbIbWthr0W5A7kTlKQ86sKIj1jDNiHHtl02vfKPpO0reEAo5wGWm79QSE3sDuOOS55lPwvOvw4CQotujHd4dB6Ubq+Y/8soXiJu6W1JTcxl5q50wSb+4K9KyybfPlQE6r5stE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725916187; c=relaxed/simple;
	bh=w8IFxQX5YWTJSzB+chnohiLD1I+m+PX4MYFOS4ApNJ8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MV6Dq1yf5LP1+ozXb/i5QzY9sjRC+g46/eZbYf3aTY8Ly7wM7M360NjbPuh2wmjkPXbvshEn3Iktut5jLKgXOVudDBDWyhfyGRKBmeuzge1a+cZo7VKuHlsZZJ4jszH/N27odaW3CdJL2g1H1G/AV50Ba7k2TDc38/eOig7PIRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERwDth0p; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-45812fdcd0aso27118121cf.0;
        Mon, 09 Sep 2024 14:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725916184; x=1726520984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB1sLfNUIxF1SuRHAmBARTktsFoKlKzlpMkspkLekfk=;
        b=ERwDth0p0IXwg11COkBKMUOsjLlHxPKPKOqaKGocJoRphotcmtVmv2S7Yj81M3Jczw
         pkCi8mxFylAzXAL4XZjsq4g4a1rrD3bGGl/c0Q0OCYjYVl1WiOkT7i44StOGiIHqEqpB
         yEUF6nq3/1O5P0RMYuTTyH6BSWPfKWNhZMSA5LKSlC/6DbQioZi4PINWLhICVGdRp6DG
         7uVD5uE7i7hK9g2LTJkVpuU7zl9P+E8Ll4vOjTAEa4KYEoWOcHoSaJtcLnbjskC/4Q2k
         RMBAR6cXfynlG6H8B543EprMN56BVrxa0HaFkEcJcMmd0TfXpZy+ulILNlip/pQnIfJR
         N4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725916184; x=1726520984;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vB1sLfNUIxF1SuRHAmBARTktsFoKlKzlpMkspkLekfk=;
        b=qOgyiUVMhK6+38G9Av/TC+cqpRLIULTanBz+ijeN7U7CgelphWIDG9svx2kY2MCgU4
         k8YrE0pxlNV4NnjNooe9PxjFnagK27lHRvmdShmBi80A+nI+7+dPDE5VXcszA4Zqt6S4
         OliDUay7Dye6rO5uzjxGycwn4wUd0K6EK4EYKbktqRCn3Pj2fI0pRc2vurjGXnQ+CB2F
         EYu2PzJsWt9r13pnrnl2pgz5IkEU02GvJxK8lvtgOneCS2KOLY7Wx+Tp673QEki6Tngo
         7KfGPQn9sk1sYyRQG8kdrc+DwJjOWb/11X4gxZAKVWFoiekgFQZdyndq7KRTLw8/9JK/
         Qj8A==
X-Forwarded-Encrypted: i=1; AJvYcCUb+elB4r9Y646qn3+iva9TPSKGGfdOmEt5yOmWG6WTY5G9GqNr0l3c21dQ7bmvFrZ/5h/S6k8=@vger.kernel.org, AJvYcCWIsmH7TwU6rQo01XpWCfh+jvcn4O4BfP3cfZ7Csf1wISuBCyUpa+2fgQPza6hLJXpA5q6tWOp9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/3tHk9zJ2KBe1XcAnhVb6adZBwJWULZCxiFT6dKtzdTkznHJJ
	SO0/M3RGrygKqUXiwbFmNNUrjyLVI0blDYRoWvy2PIkPeZxYLBTt
X-Google-Smtp-Source: AGHT+IGnxp2ZaWp6eHC5weneKJv5KNdurXNsjNpQgJstESoV+PwFxGZgKNxEahdtODj5PA3F9SUlVg==
X-Received: by 2002:ac8:5ad0:0:b0:458:3564:f305 with SMTP id d75a77b69052e-4583c743a3dmr17631361cf.24.1725916184485;
        Mon, 09 Sep 2024 14:09:44 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e9df9asm23716551cf.50.2024.09.09.14.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 14:09:43 -0700 (PDT)
Date: Mon, 09 Sep 2024 17:09:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
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
Message-ID: <66df641780764_7585d294af@willemb.c.googlers.com.notmuch>
In-Reply-To: <66df1229c854f_38b8b294a7@willemb.c.googlers.com.notmuch>
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
> > > > > So I guess VIRTIO_NET_HDR_GSO_* without VIRTIO_NET_HDR_F_DATA_VALID
> > > > > would be wrong on rx.
> > > > >
> > > > > But the new check
> > > > >
> > > > >         if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
> > > > >
> > > > >                 [...]
> > > > >
> > > > >                 case SKB_GSO_TCPV4:
> > > > >                 case SKB_GSO_TCPV6:
> > > > >                         if (skb->csum_offset != offsetof(struct tcphdr, check))
> > > > >                                 return -EINVAL;
> > > > >
> > > > > should be limited to callers of virtio_net_hdr_to_skb on the tx/GSO path.
> > > > >
> > > > > Looking what the cleanest/minimal patch is to accomplish that.
> > > > >
> > > >
> > > > virtio_net_hdr_to_skb() translates virtio-net header to skb metadata,
> > > > so it's RX. For TX the helper should be virtio_net_hdr_from_skb()
> > > > which translates skb metadata to virtio hdr.
> > >
> > > virtio_net_hdr_to_skb is used by PF_PACKET, tun and tap
> > 
> > Exactly.
> > 
> > > when injecting a packet into the egress path.
> > 
> > For tuntap it's still the RX path. For PF_PACEKT and macvtap, it's the tx.
> > 
> > Maybe a new parameter to virtio_net_hdr_to_skb()?
> 
> This is the most straightforward approach. But requires changse to all
> callers, in a patch targeting all the stable branches.
> 
> I'd prefer if we can detect ingress vs egress directly.

Not doing this, because both on ingress and egress the allowed
ip_summed types are more relaxed than I imagined.

Let's just make the check more narrow to avoid such false positives.

GRO indeed allows CHECKSUM_NONE.

But TSO also accepts packets that are not CHECKSUM_PARTIAL, and will
fix up csum_start/csum_off. In tcp4_gso_segment:

        if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
                const struct iphdr *iph = ip_hdr(skb);
                struct tcphdr *th = tcp_hdr(skb);

                /* Set up checksum pseudo header, usually expect stack to
                 * have done this already.
                 */

                th->check = 0;
                skb->ip_summed = CHECKSUM_PARTIAL;
                __tcp_v4_send_check(skb, iph->saddr, iph->daddr);
        }

With __tcp_v4_send_check:

	void __tcp_v4_send_check(struct sk_buff *skb, __be32 saddr, __be32 daddr)
	{
		struct tcphdr *th = tcp_hdr(skb);

		th->check = ~tcp_v4_check(skb->len, saddr, daddr, 0);
		skb->csum_start = skb_transport_header(skb) - skb->head;
		skb->csum_offset = offsetof(struct tcphdr, check);
	}    

That means that we can relax the check on input from userspace to
bad CHECKSUM_PARTIAL input:

@@ -173,7 +173,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
                        break;
                case SKB_GSO_TCPV4:
                case SKB_GSO_TCPV6:
-                       if (skb->csum_offset != offsetof(struct tcphdr, check))
+                       if (skb->ip_summed == CHECKSUM_PARTIAL &&
+                           skb->csum_offset != offsetof(struct tcphdr, check))
                                return -EINVAL;

I've verified that this test still catches the bad packet from the
syzkaller report in the Link in the commit.




> Based on ip_summed, pkt_type, is_skb_wmem or so. But so far have not
> found a suitable condition.
> 
> I noticed something else: as you point out TUN is ingress. Unlike
> virtnet_receive, it does not set ip_summed to CHECKSUM_UNNECESSARY if
> VIRTIO_NET_HDR_F_DATA_VALID. It probably should. GRO expects packets
> to have had their integrity verified. CHECKSUM_NONE on ingress is not
> correct for GRO.
> 
> And also related: no GRO should be generated by a device unless
> VIRTIO_NET_HDR_F_DATA_VALID is also passed? I have to check the spec
> if it says anything about this.


