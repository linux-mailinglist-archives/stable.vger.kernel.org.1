Return-Path: <stable+bounces-75662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EF3973AA1
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 16:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02200B22C3B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 14:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F67195B1A;
	Tue, 10 Sep 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpNfWnrN"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D218C34B;
	Tue, 10 Sep 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980037; cv=none; b=ZqL43RPTY/0+c4q1whaCScTE0b1OrZPuh+IAomeM0sUDUAyPEtF8RAqC295p1yyk9gr6BPpeuvE4GhLzGgZL2sRxNPQn4BuEGY67An/FDjASU9Zl3EGWk0vSZZzE48LB4yvoZo/ENZu53trDqLP0Duv/wwzgTfFtr0Snk1IJNLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980037; c=relaxed/simple;
	bh=zKScHZ7ZqaDDUwyvpBIx4rom5y1ZiJkBljuM/JAMBo0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MVTvt3Pdc81GiOker60lxqlhWPwPcgcj4Z5yd3IMQomAV7e1xDi2q6/XmxBsViv2NbtFiGvFauf5TZday5M4Rl1N2TE1Jzi2fpaMJqwriY6dXi6twzHDv6Mvhk2GlBzLCYxU8QvKnzcL3kLoVxcI61GYYheVDWbExdsYRpdUXgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpNfWnrN; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4581f44b9b4so5704391cf.1;
        Tue, 10 Sep 2024 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725980035; x=1726584835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rr1UKDyQ/zeb0p3Tv9UrCdmESCimLucSGCIARwY3ysA=;
        b=GpNfWnrNlpFB1oDQqUKlAmDhwW7LzMOMzrKm6rF3viM/mFKiICxSt9Fr97WqKfMsdw
         1YxkD/8Roj38cLm1JXsyn2xuzW9En1LmhERbVZ2TiZg6cNDDjbrDALpu9Y2kAe9pGlcb
         zJXOyTsS4n4Waz48Fvi3vyP+QpezQW2qYJ7X4Hvn7AE31IgR/EiqIORKZtfG5guMJhuG
         ZKKk5TKnD1ZlXK7qICbrMQjPWdeAdYzHacDzh5J1dIIp3A8IsBL39cFyROq95/ENBVw+
         u5uCturXGZLFp9QmZhkWSFpLFuQehhEFFhsGZmPy8ZyjwEhywgxT2R0PFHDz6LfXu6NK
         +vCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725980035; x=1726584835;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rr1UKDyQ/zeb0p3Tv9UrCdmESCimLucSGCIARwY3ysA=;
        b=r3ndVI45t7ZeDXO62dGAt99/IULU/3qFkJe2ry4embXRajOZl1uugJ85RpfedMFOJU
         px5pJuLmtXAREtTbCqbC+7TLChTQgnI8HU+dLLW6udJzMsXrZrLvrnFxmsseOtlSWoBe
         IU0dPPieTTzv0nEFyZGpQU9pByQw3rJJLEZsA3Yjg7WWxn+LAXGgGPJb2WOwCo2358mr
         AdI1SvWpZYc+pqfgd0D++KqSNP8JUe0fFYH7ka3ycMlo6zEasL8HBq21p9CCsiIB47jr
         d9T/HCobJj3fPNNZh8/FzR6mgpo6bQe13Ziyy/oRknKaBUKhiaTDXnTyu9YHaGQAUp+p
         LZkw==
X-Forwarded-Encrypted: i=1; AJvYcCVDZFJ5OyGXjElSC+DHECDz1SVj9z/xNzRYM2TubBJrTboxUPEoR14AusedeI9huyGvFfj19pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxirljTDEaOLBSO/PM8miNlJ8BIoGm+msUvlaHbnYe81maSXvqu
	3lVcu4mWJwvI2u15aas1y9Oe87GxjY+uV6WSv7r5ovsKuoU6wJOr
X-Google-Smtp-Source: AGHT+IEJRZ+y4qosu/LeEY6jpJXInsEysZJJYz/4Q/d0zNu+H8545m+hFnVrOCGJgOaBnaickkWZTw==
X-Received: by 2002:a05:622a:4184:b0:458:23fc:f345 with SMTP id d75a77b69052e-45823fcf549mr171706711cf.38.1725980034500;
        Tue, 10 Sep 2024 07:53:54 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-458314e05a8sm18672911cf.34.2024.09.10.07.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 07:53:54 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:53:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
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
Message-ID: <66e05d81c04fe_a00b829435@willemb.c.googlers.com.notmuch>
In-Reply-To: <66e05a2259919_9de00294f9@willemb.c.googlers.com.notmuch>
References: <20240910004033.530313-1-willemdebruijn.kernel@gmail.com>
 <CACGkMEsnPmbo8t6PbD8YsgKrZWHXG=Rz8ZwTDBJkSbmyzkNGSA@mail.gmail.com>
 <66e05a2259919_9de00294f9@willemb.c.googlers.com.notmuch>
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

Willem de Bruijn wrote:
> Jason Wang wrote:
> > On Tue, Sep 10, 2024 at 8:40=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > From: Willem de Bruijn <willemb@google.com>
> > >
> > > The referenced commit drops bad input, but has false positives.
> > > Tighten the check to avoid these.
> > >
> > > The check detects illegal checksum offload requests, which produce
> > > csum_start/csum_off beyond end of packet after segmentation.
> > >
> > > But it is based on two incorrect assumptions:
> > >
> > > 1. virtio_net_hdr_to_skb with VIRTIO_NET_HDR_GSO_TCP[46] implies GS=
O.
> > > True in callers that inject into the tx path, such as tap.
> > > But false in callers that inject into rx, like virtio-net.
> > > Here, the flags indicate GRO, and CHECKSUM_UNNECESSARY or
> > > CHECKSUM_NONE without VIRTIO_NET_HDR_F_NEEDS_CSUM is normal.
> > >
> > > 2. TSO requires checksum offload, i.e., ip_summed =3D=3D CHECKSUM_P=
ARTIAL.
> > > False, as tcp[46]_gso_segment will fix up csum_start and offset for=

> > > all other ip_summed by calling __tcp_v4_send_check.
> > >
> > > Because of 2, we can limit the scope of the fix to virtio_net_hdr
> > > that do try to set these fields, with a bogus value.
> > >
> > > Link: https://lore.kernel.org/netdev/20240909094527.GA3048202@port7=
0.net/
> > > Fixes: 89add40066f9 ("net: drop bad gso csum_start and offset in vi=
rtio_net_hdr")
> > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > Cc: <stable@vger.kernel.net>
> > >
> > > ---
> > >
> > > Verified that the syzbot repro is still caught.
> > >
> > > An equivalent alternative would be to move the check for csum_offse=
t
> > > to where the csum_start check is in segmentation:
> > >
> > > -    if (unlikely(skb_checksum_start(skb) !=3D skb_transport_header=
(skb)))
> > > +    if (unlikely(skb_checksum_start(skb) !=3D skb_transport_header=
(skb) ||
> > > +                 skb->csum_offset !=3D offsetof(struct tcphdr, che=
ck)))
> > >
> > > Cleaner, but messier stable backport.
> > >
> > > We'll need an equivalent patch to this for VIRTIO_NET_HDR_GSO_UDP_L=
4.
> > > But that csum_offset test was in a different commit, so different
> > =

> > Not for this patch, but I see this in UDP_L4:
> > =

> >                        if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM=
))
> >                                return -EINVAL;
> > =

> > This seems to forbid VIRTIO_NET_HDR_F_DATA_VALID. I wonder what's the=

> > reason for doing this.
> =

> It tests &, not =3D=3D ?

Oh you mean as alternative, for receive of GRO from hypervisor.

Yes, fair point.

Then we also trust a privileged process over tun, like syzkaller.
When it comes to checksums, I suppose that is fine: it cannot harm
kernel integrity.

One missing piece is that TCP GSO will fix up non CHECKSUM_PARTIAL
skbs. UDP GSO does not have the same logic.=

