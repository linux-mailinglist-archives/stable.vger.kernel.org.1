Return-Path: <stable+bounces-75660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E77973A19
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 16:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31DE1B22995
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2671957E1;
	Tue, 10 Sep 2024 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgAimHqc"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FE21940B3;
	Tue, 10 Sep 2024 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979175; cv=none; b=cJHcd+gFFMk36delnIuU2bClMNwKAKM/bKOLSEltbaVvlEZ+XrhqSwopCnsKtFfTpsoxOURBcX2fdC38/3QP70UEL5AAkqfrVcIvrTh6WFLD3pKSSD60caR/5urBn19H0J35XB7CMbL8w6wxAloHAM/K+bF4fLcwgUluDIu0oWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979175; c=relaxed/simple;
	bh=SlCe6zFhYuhwyWnV6gLsdcSUid6440JlIzAgLc1ODdw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=l9GHs5CdyMcmRl37uZfEEK4DfAlbIXCYBrvPj9oOIIOlIC1PGaJKxq4eT4eyJY9PFFI9YUdPr7oT4XPzpWc8E9ZXMmZGTwYJj1I7deb+bpg9VwHFcv249rbnqntMd/hDZpEwWoBzHDVIoOJ8J16ALK8/VXKaPyHnHtbJjCgxGBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgAimHqc; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so6160553276.2;
        Tue, 10 Sep 2024 07:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725979172; x=1726583972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EnJYnk0tWnQ6MzZ6S4uoD2QS0ICJx7Nh5xOxSRk4+w=;
        b=ZgAimHqc8dWJ2wOj/i62b6FS2nmwBAdoDO76kECjCjJ7joS1OtVWqCzC6FYOq3MkVa
         zrsF4eneNl/LLGDz81cGBsqZXhEVzIh88aNWZpyOfQLzH66XJYdqDDt5t7xUMzISRbGg
         OSzGNyCXr3UgS+sPESMYQyy/xIGf8SmGsOIcOxZTalI9feTfNDAK8dtIs/nL+Vm5SawI
         Xu/ElbLm/9WeH2loueCZQbsmui9zYBOW5uDuNJTw3f4U28zKzvbLnYu7Foy8Vojm+n9D
         Ae4dV0ha+IYTh9gYYrq53NWOPXoduu3WzexxmhNYphRDqhcb4PKURmKlRvfpflzS+8N4
         uH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725979172; x=1726583972;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8EnJYnk0tWnQ6MzZ6S4uoD2QS0ICJx7Nh5xOxSRk4+w=;
        b=mks30+bKe7W0hQCJPukmVsIJWhyTju1iAEuiMUbXe/nc1p/RCnuHkUplycUG3SKVk7
         CNEbPXNL8OPZSXK5qNctATS4Ycb+T+pridA1/Uvs5BzdBpxJWpdBvZWztPbEGqBE+7WJ
         l3/+DvhB+ndlb1FQrhSWmCG/uVPvFasQOq2jrBIuIJVazi72bDNx3aFOkwX8uAwuOtZg
         aICzJemD9LV1JNKwEW40oK1nX1vWXjeeiswmKGTrRJI3eTdaoGxiwkH2+syosA1jJY6P
         /du1p0ofR5pEdQdwkguOviTzK83842mTXRa43XcLcprZJzEijjXNLDxmNnPJNplNLzGm
         SIEA==
X-Forwarded-Encrypted: i=1; AJvYcCUaXkkOWqHiN0vsmFe82HE8U2slUYlKYVz3gcec6JaP3KqHw8QEhlIsMatqIXgjvtVYdA8YuCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDCGOlDkp0rIJC4eceqrWqa2iIjH77tg0wG1KsvjuDkQPpOtWQ
	3oVsr3Q/b+jtIAGKzmbvpy125ysRGf7ExxvyRuoBjNMyD8kCSGIi
X-Google-Smtp-Source: AGHT+IHBR0Ey5K3507QZL400N+rwdfsWqvA5Yi+ApgUqoXzAH+EIaRCEFbOsfGWgxbJugstGI1XJtw==
X-Received: by 2002:a05:6902:2785:b0:e1a:8cec:37e6 with SMTP id 3f1490d57ef6-e1d3488d11fmr16531280276.18.1725979171590;
        Tue, 10 Sep 2024 07:39:31 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53433982esm30573836d6.42.2024.09.10.07.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 07:39:31 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:39:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Wang <jasowang@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 stable@vger.kernel.org, 
 nsz@port70.net, 
 mst@redhat.com, 
 yury.khrustalev@arm.com, 
 broonie@kernel.org, 
 sudeep.holla@arm.com, 
 Willem de Bruijn <willemb@google.com>, 
 stable@vger.kernel.net
Message-ID: <66e05a2259919_9de00294f9@willemb.c.googlers.com.notmuch>
In-Reply-To: <CACGkMEsnPmbo8t6PbD8YsgKrZWHXG=Rz8ZwTDBJkSbmyzkNGSA@mail.gmail.com>
References: <20240910004033.530313-1-willemdebruijn.kernel@gmail.com>
 <CACGkMEsnPmbo8t6PbD8YsgKrZWHXG=Rz8ZwTDBJkSbmyzkNGSA@mail.gmail.com>
Subject: Re: [PATCH net] net: tighten bad gso csum offset check in
 virtio_net_hdr
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Wang wrote:
> On Tue, Sep 10, 2024 at 8:40=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > From: Willem de Bruijn <willemb@google.com>
> >
> > The referenced commit drops bad input, but has false positives.
> > Tighten the check to avoid these.
> >
> > The check detects illegal checksum offload requests, which produce
> > csum_start/csum_off beyond end of packet after segmentation.
> >
> > But it is based on two incorrect assumptions:
> >
> > 1. virtio_net_hdr_to_skb with VIRTIO_NET_HDR_GSO_TCP[46] implies GSO.=

> > True in callers that inject into the tx path, such as tap.
> > But false in callers that inject into rx, like virtio-net.
> > Here, the flags indicate GRO, and CHECKSUM_UNNECESSARY or
> > CHECKSUM_NONE without VIRTIO_NET_HDR_F_NEEDS_CSUM is normal.
> >
> > 2. TSO requires checksum offload, i.e., ip_summed =3D=3D CHECKSUM_PAR=
TIAL.
> > False, as tcp[46]_gso_segment will fix up csum_start and offset for
> > all other ip_summed by calling __tcp_v4_send_check.
> >
> > Because of 2, we can limit the scope of the fix to virtio_net_hdr
> > that do try to set these fields, with a bogus value.
> >
> > Link: https://lore.kernel.org/netdev/20240909094527.GA3048202@port70.=
net/
> > Fixes: 89add40066f9 ("net: drop bad gso csum_start and offset in virt=
io_net_hdr")
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > Cc: <stable@vger.kernel.net>
> >
> > ---
> >
> > Verified that the syzbot repro is still caught.
> >
> > An equivalent alternative would be to move the check for csum_offset
> > to where the csum_start check is in segmentation:
> >
> > -    if (unlikely(skb_checksum_start(skb) !=3D skb_transport_header(s=
kb)))
> > +    if (unlikely(skb_checksum_start(skb) !=3D skb_transport_header(s=
kb) ||
> > +                 skb->csum_offset !=3D offsetof(struct tcphdr, check=
)))
> >
> > Cleaner, but messier stable backport.
> >
> > We'll need an equivalent patch to this for VIRTIO_NET_HDR_GSO_UDP_L4.=

> > But that csum_offset test was in a different commit, so different
> =

> Not for this patch, but I see this in UDP_L4:
> =

>                        if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))=

>                                return -EINVAL;
> =

> This seems to forbid VIRTIO_NET_HDR_F_DATA_VALID. I wonder what's the
> reason for doing this.

It tests &, not =3D=3D ?

> > Fixes tag.
> > ---
> >  include/linux/virtio_net.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 6c395a2600e8d..276ca543ef44d 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -173,7 +173,8 @@ static inline int virtio_net_hdr_to_skb(struct sk=
_buff *skb,
> >                         break;
> >                 case SKB_GSO_TCPV4:
> >                 case SKB_GSO_TCPV6:
> > -                       if (skb->csum_offset !=3D offsetof(struct tcp=
hdr, check))
> > +                       if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&=

> > +                           skb->csum_offset !=3D offsetof(struct tcp=
hdr, check))
> >                                 return -EINVAL;
> >                         break;
> >                 }
> > --
> > 2.46.0.598.g6f2099f65c-goog
> >
> =

> Acked-by: Jason Wang <jasowang@redhat.com>

Thanks for reviewing

