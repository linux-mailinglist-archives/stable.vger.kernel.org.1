Return-Path: <stable+bounces-163242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF4DB0893A
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 11:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABAC27AA270
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56111289E0F;
	Thu, 17 Jul 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XValc/qT"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40457288CBD
	for <stable@vger.kernel.org>; Thu, 17 Jul 2025 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744318; cv=none; b=mp9xitpbkR/czhQL+j4WeGxVQbIX1EWjpOpRGaznYNWjv++jUuR1ts5LFlufQknlkg3cxPSdv9t47rT4lkFwss1LwN8lkJ1EAEY0Xcd3kPBNO+BRGNIGiLIxL40rU4ZhScJ19HNBzZEgVNeW4eegBs7pVYf5py0Dj7DOdlvV19o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744318; c=relaxed/simple;
	bh=mUGblPwGliu3YzskON//m/UU7MFOS7s+Yue1Nej7KOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1XNyGizr1yfwSCCQSCfaRKJSXD1WzW17DVIlxVjz2T8WvSTPMy2Ocw+qQ/fnIGnRo8RXF+yp3MqhETfD4uBxhQdAR2Hsz7JQbvpossjc7gvRYwJVKGYnnQuVdOsUt3zV4qpfIutRyM1no339A8aiZK5EVIatOx4FNL/Pdp6ib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XValc/qT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752744315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqpFHXx++3EMATXriFPKJGfUd3A8yDTgA5DIK5OX6Jk=;
	b=XValc/qTWpkX2E7uxQG3AlzOKtOF2CBNDM3MnB3pb9VdYtrKaqKOPsV9fzB7zxM5JQoCzY
	qoVkyyfMSh/haUauqt/PkRmClZzCJtp2qRB6s+cZTTg3z9N7XucOTxKw8ZCrLe3/6qcoqn
	6AydBeVfZzX5zia0W4pZPb9I8MI7f98=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-_ayQz-tpPAioKUVl-g5anw-1; Thu, 17 Jul 2025 05:25:13 -0400
X-MC-Unique: _ayQz-tpPAioKUVl-g5anw-1
X-Mimecast-MFC-AGG-ID: _ayQz-tpPAioKUVl-g5anw_1752744312
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e8bd1a7477bso1296628276.1
        for <stable@vger.kernel.org>; Thu, 17 Jul 2025 02:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752744312; x=1753349112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqpFHXx++3EMATXriFPKJGfUd3A8yDTgA5DIK5OX6Jk=;
        b=Z4QDY+tH2PFaLeVR81Nxj73ySujB5/pcZrLcp4T7vu19kTGDPgpjfFqPRx6Np+cVdd
         jpeZfDeCFyu5erBwhMe6AabQ9vFOl0qb8ULWBqKhd1yxp/bouB1E/e6NHnWNSuXNxgAd
         M+i3o6+HN1l6aCei2vBDcj1jjRUzqnTW45X8yfG30nQHCCUYHaSC4hxzwzGUqWFLEgEz
         Evr413N+DbrBjMwDqXu1MTQNMAHre6befl47+OW5CIOuI/KCJByeZP4Y/5mFA6XBwAg6
         ECiZd8fL0qS50TvDSs5mmusHmf2hIxwp5Yvuu8U91y+Jat+m/k7prIN3qcv8ADhYZQHf
         0ryg==
X-Forwarded-Encrypted: i=1; AJvYcCXGzEbjbKCg5hQAi6cWZcvSroPka2JX2tjbh5M6FYMXQC82W/yr85pJEL7fzifAcoBHkI1vUt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVN40SzSlrJOsGVuRROhSZntH+i3A4yV7/Xb1IeDuBIYRRGugj
	NOey1+JYYyLyzqZbxfjxWMp3oHGLHCdpwCYJDKmQ7/00lciOlVsWVbn5ceJxSrS8GJPkJp5Y9j6
	l4arymR8Cmut8DTL0ZMSq4hXt7zWg+QBpnzcayCO0Jvnab7IA6Hy5gsBQzPSJZXT5copQCxYCIx
	tIJXdl6dNbbTnDftAwYdC7Qvljpn8OXveM
X-Gm-Gg: ASbGnctLyOd6kf+6t9Zw8Mh8y4znq+A4PZtqLg6xvxPWcA5IvI7WwHISc8u3viAkHRt
	dhZmDf+yiWHsyLTuixD9I5/zULoyWFzIDsb/FA9KKO2CEPV9diF58oL5qBldb/KbSzYeno0ep4N
	TCODAa4Hbo1UCL7SoWSHjM
X-Received: by 2002:a05:6902:2582:b0:e8b:d0e7:3ae4 with SMTP id 3f1490d57ef6-e8bd0e73bdcmr5202986276.22.1752744312275;
        Thu, 17 Jul 2025 02:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsfTvkw1PSMXKHBxuokKzY5S7apDyUaHwD6BT79131/X481c8450D90mHNBs58p1agihhTtDodQFLemqkkQdo=
X-Received: by 2002:a05:6902:2582:b0:e8b:d0e7:3ae4 with SMTP id
 3f1490d57ef6-e8bd0e73bdcmr5202940276.22.1752744311654; Thu, 17 Jul 2025
 02:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717090116.11987-1-will@kernel.org> <20250717090116.11987-2-will@kernel.org>
 <CACGkMEsoBj7aNXfCU7Zn=5yWnhvA7M8xhbucmt4fuPm31dQ1+w@mail.gmail.com>
In-Reply-To: <CACGkMEsoBj7aNXfCU7Zn=5yWnhvA7M8xhbucmt4fuPm31dQ1+w@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 17 Jul 2025 11:25:00 +0200
X-Gm-Features: Ac12FXz6ffoOmDUY3dLdGfR0fllZrD7uhyzojK2JMGGErWflZ9rAZkbEOw8MTDA
Message-ID: <CAGxU2F6jSBM-VKU6vaojvBF_4zTWndmaQ4rFvLxds6gOPjXpcA@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] vhost/vsock: Avoid allocating arbitrarily-sized SKBs
To: Jason Wang <jasowang@redhat.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Keir Fraser <keirf@google.com>, Steven Moreland <smoreland@google.com>, 
	Frederick Mayle <fmayle@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jul 2025 at 11:10, Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jul 17, 2025 at 5:01=E2=80=AFPM Will Deacon <will@kernel.org> wro=
te:
> >
> > vhost_vsock_alloc_skb() returns NULL for packets advertising a length
> > larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However=
,
> > this is only checked once the SKB has been allocated and, if the length
> > in the packet header is zero, the SKB may not be freed immediately.
>
> Can this be triggered from the guest? (I guess yes) Did we need to
> consider it as a security issue?

Yep, but then the packet would still be discarded later, and the
memory released, so it can only increase the pressure on allocation,
but the guest can still do so by sending packets for example on an
unopened port.

Stefano

>
> >
> > Hoist the size check before the SKB allocation so that an iovec larger
> > than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
> > outright. The subsequent check on the length field in the header can
> > then simply check that the allocated SKB is indeed large enough to hold
> > the packet.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_bu=
ff")
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  drivers/vhost/vsock.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 802153e23073..66a0f060770e 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -344,6 +344,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> >
> >         len =3D iov_length(vq->iov, out);
> >
> > +       if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEAD=
ROOM)
> > +               return NULL;
> > +
> >         /* len contains both payload and hdr */
> >         skb =3D virtio_vsock_alloc_skb(len, GFP_KERNEL);
> >         if (!skb)
> > @@ -367,8 +370,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> >                 return skb;
> >
> >         /* The pkt is too big or the length in the header is invalid */
> > -       if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
> > -           payload_len + sizeof(*hdr) > len) {
> > +       if (payload_len + sizeof(*hdr) > len) {
> >                 kfree_skb(skb);
> >                 return NULL;
> >         }
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
>
> Thanks
>


