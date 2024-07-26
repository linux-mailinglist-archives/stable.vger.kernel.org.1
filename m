Return-Path: <stable+bounces-61881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0B693D4A0
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 15:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77701B233AD
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFDA17BB0E;
	Fri, 26 Jul 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+aCJbQw"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B50176AAE;
	Fri, 26 Jul 2024 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001961; cv=none; b=VuBxjLsAe4hPFP0OSWvkJ8mTE/4XT9YpJB63l4Ny3LAG1/eRBpp+0f/zE3NJwIVyoh0U4o9vBmL53qgVgdqNVdJAk7y28DRWhUuYXmRy88CwV7Z6qpyix5qJPNeGoJCMi1jMOj+LEvEZBU8svJvfmGux+OZ2lFeymCDF3zjAvfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001961; c=relaxed/simple;
	bh=00jPC0NzM8WT+crfmbyZfGMBPa7rHV0QwOMZ4ik6mvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZha1vcds4pWcve2slzxwINSoe2+ZMV/9k+nYSAxyLTyN066s/W3i7fPNv/S4vV4Ei0fXXkYTSzviS9fakMAD8xTMZK8AetL+GupLTWezQNS11R9wVCmg9dC4UMdBRD3ePVw3fr8rXJi4n0d4vtiuZl5PKMGZOn7/Zyl+OBfkls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+aCJbQw; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4f50dd3eab9so255635e0c.1;
        Fri, 26 Jul 2024 06:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722001959; x=1722606759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rUgT274UyzuAYLpEr+DWJ6fzv3FCcBkjWvzamMxSfs=;
        b=U+aCJbQwLXtnYznVIzaDmwvEcZAE65mU0ktgOLbrV4+wm+Lsih7Yx0bEPPa33Gd6sT
         6iPz+nVp/SYU9o3YEA+XjUHiBdO0SonPMPCUwFbKw18NfdBQ1asgsRGt4BJgzVkdiUwV
         WBcYUdxVcAyJi1gLUMMMabNTbNUhnpjSy3qpSaAI87EJdWmPJTvY4luXsLiy6sUkzbPL
         JnUhLae0GBReX5mS+Yekct/z69hoxzXw+pK+gZ4AXb5XTbvUQSrD8jRPu4okLfDSf1HO
         DqpcaKiQgkZCuVyMjO3kWhzdupRN8jCEIUzZ+Q7ThGDbFpAXhh6dWjaHGeD0kOTYtJ1u
         1Q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722001959; x=1722606759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rUgT274UyzuAYLpEr+DWJ6fzv3FCcBkjWvzamMxSfs=;
        b=umhaIAgCXN68mnMUoWGqzKHFtriDuIybnsn/zpO8iBJnssz6MfQXU36Iu0b/MglSuN
         eYXIpv/2hDpFvh77FBvrBExBkzKOvvv5JV/ZIncxAQhrgEFCmkvdd/mOWwNXTBF60g0v
         t/jsMmADGR2vTP1t8aMmkrwJ+QcC8GWfJNFWJH8QiT/O1mlGXn7mkXfC9HyDnDLuU3Ol
         JEulcHcJ+3UiGklrZVpNcjOQtDkM9yBNbYvBlvceLHoz3LOyq+BS5T/8rtq48bD4jyaT
         DYrovqxaUmR3m/1Ov9UwWKPinJaK8hXIYsoscS0Iunkpx8paCYbXRjlm/RyeEOrwcu9m
         DnyA==
X-Forwarded-Encrypted: i=1; AJvYcCXww3QmhA/45s+Kz87kRIuN91pH83VFGnGQeLeIo2TMU9q42VU+iGPfyGs3pGbQIBatSIR5YEKjX5zBwDGBgR/kauXOtX0P
X-Gm-Message-State: AOJu0YykvATCQZOPxaAkfI6D+qP3gRGwchnZnfBh58XuqZAyjiL0F45j
	/kzS+h9F2MZ64PMJblfbR96SzlaQm9/lHB82CtIuUBZUbPinCJSPxaGXTssHDGLX2EFC4/hcTq2
	HHhOvbzgRK7BPMVugqRXUM6VroK4=
X-Google-Smtp-Source: AGHT+IEkBfAFvYVL07R0WraAMkhFlA00XUjVShNVKuBAvJe+kJf6se5tAuvuoDOvC9doahLl8xoeGFby7Aq2/uRyYrI=
X-Received: by 2002:a05:6122:3b17:b0:4f5:26c6:bf31 with SMTP id
 71dfb90a1353d-4f6c5c71d30mr7396634e0c.12.1722001959110; Fri, 26 Jul 2024
 06:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com> <bab2caf1-87a5-444d-8b5f-c6388facf65d@redhat.com>
In-Reply-To: <bab2caf1-87a5-444d-8b5f-c6388facf65d@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 26 Jul 2024 09:52:01 -0400
Message-ID: <CAF=yD-J57z=iUZChLJR4YXq-3X-qPc+N93jvpCy5HE89B7-Tdw@mail.gmail.com>
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in virtio_net_hdr
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, mst@redhat.com, jasowang@redhat.com, arefev@swemel.ru, 
	alexander.duyck@gmail.com, Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 4:23=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/26/24 04:32, Willem de Bruijn wrot> @@ -182,6 +171,11 @@ static
> inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
> >                       if (gso_type !=3D SKB_GSO_UDP_L4)
> >                               return -EINVAL;
> >                       break;
> > +             case SKB_GSO_TCPV4:
> > +             case SKB_GSO_TCPV6:
>
> I think we need to add here an additional check:
>
>                         if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
>                                 return -EINVAL;
>

Historically this interface has been able to request
VIRTIO_NET_HDR_GSO_* without VIRTIO_NET_HDR_F_NEEDS_CSUM.

I agree that that makes little sense. Until now we have been
accommodating it, however. See the else branch if that checksum
offload flag is not set.

I would love to clamp down on this, as those packets are essentially
illegal. But we should probably leave that discussion for a separate
patch?

> > +                     if (skb->csum_offset !=3D offsetof(struct tcphdr,=
 check))
> > +                             return -EINVAL;
> > +                     break;
> >               }
> >
> >               /* Kernel has a special handling for GSO_BY_FRAGS. */
> > diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> > index 4b791e74529e1..9e49ffcc77071 100644
> > --- a/net/ipv4/tcp_offload.c
> > +++ b/net/ipv4/tcp_offload.c
> > @@ -140,6 +140,9 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb=
,
> >       if (thlen < sizeof(*th))
> >               goto out;
> >
> > +     if (unlikely(skb->csum_start !=3D skb->transport_header))
> > +             goto out;
>
> Given that for packet injected from user-space, the transport offset is
> set to csum_start by skb_partial_csum_set(), do we need the above check?
> If so, why don't we need another similar one for csum_offset even here?

Same point. Sadly it is not set if checksum offload is not requested.

