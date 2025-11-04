Return-Path: <stable+bounces-192428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03426C322A2
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 17:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5280B18C0B75
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 16:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE4A3375DC;
	Tue,  4 Nov 2025 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSdZ5RaS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="joiY9tT4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5FB295D90
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275352; cv=none; b=HqLAlogJZ60jffXnbkjbkY8rrmHCAVAbCzy56sfr4krVezbLxhxWy3JKib9/5kYxH0aay9rATjwjIeOXzW7gVp81aOBLR+G34nZ5awexe2qpX7VgCbr4+2ZzXLC4imPfurmIPF+hA8nwfuaYH9PHwzXN12nRxfbT9Ww1B6ey/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275352; c=relaxed/simple;
	bh=TiJGFEfQCBCdhtH1YWNIQUQjYRlLTugBZObWYWIa+5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOZan70IP0m2E9jqo4JpGp404ve2wKsBgc7QLTTu3jZGZSYJcMP3BABbzp1iGkd1PfD8z6TvqOVAEOsIMDOkbC0xRPZC4QlwRrfdANM7ASmlpx1xZMtNme7dAHUR2UTy6d+Z7wsckFHXXOvohHWh1IpqVQM1AsgyO4G4ThBlqaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSdZ5RaS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=joiY9tT4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762275349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hm6vQC33e7nqNsZy21fXXBlp96qh8mZG59C0mIsP1cY=;
	b=JSdZ5RaSvjgRJcjXYZYHogy8a13TgUAbO8ZPrgrATlfX/TZ7MrANUqUDS3uXdkoouTz6w+
	weyVfMuAviCLjR4MHbARyZka1/Rs16x41Jn+uX0XEstmMqRBUWiCz/9BnuiKfECiNm7Dez
	jhK7VOhz1HnexnFqr3wPH7smNL9M7NM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-IVI7bMHXNM2BZ-xRy-Txjw-1; Tue, 04 Nov 2025 11:55:46 -0500
X-MC-Unique: IVI7bMHXNM2BZ-xRy-Txjw-1
X-Mimecast-MFC-AGG-ID: IVI7bMHXNM2BZ-xRy-Txjw_1762275345
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b70b2a89c22so3263566b.0
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 08:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762275345; x=1762880145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hm6vQC33e7nqNsZy21fXXBlp96qh8mZG59C0mIsP1cY=;
        b=joiY9tT42xR8e5kN1bhgamlo8HEcW80cigm6MBNvauenA4ePpy0LQ83lvNyN79YIFQ
         ivBrtYsFToY7vg3s/44W68yLuvOJ2QOnNRe5npZjCRV4l3/et2SmRTq1tO/8ktBqHaP2
         1+HBRpX+IGYoDxdSOyPFKxGftw/6kVaTT7DfXuL1D+v/Se+nDPLh9WD8+WDv9burxmRl
         75lC0UtvGpqXgd078+Xgf82hi9DSaS+qb2Kf2fuM3uI/RWjQiDctmmasLXuzEAU3UP+C
         7Ubf3dUD8tWCeYkIg6aCfJIndRlDddWdEgB12q+aneVLntxBgg/O0zziU2xqwjtg7qE7
         1qfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275345; x=1762880145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hm6vQC33e7nqNsZy21fXXBlp96qh8mZG59C0mIsP1cY=;
        b=QCxW+8A8TqbBSde9oxSyfm/nyMENZMJOm8XqmMLKUVhGoKt7Yl0tn4CAiUWbf+MUPx
         dMJ+tRZl4ltoAtQn53RZ3qnz9ltBpZzYWnonpxsPBqZQCQaey9bs5CclcPsIfbOuVocs
         oloTF+WXw+jopBY5/qUTAfY1l4OoY4IGX4og5QEuSvF6HOAYkAbJb8mbsEV+0q3BGBQP
         Q4UGDYIoIfFFigfr3vs3t/cd/xIkPqYwTuiiDH71Yq5XeuSzPMMV2N2XShDWdBOp8HIN
         dfPZlvoO3+n5ZQaQCovZX0Ys1gNVLcWkKZQY2cJ9D/uZW77Jt2A6tbhvWOHuIP0UOtwU
         H6XA==
X-Forwarded-Encrypted: i=1; AJvYcCUpIeISnFj5jmUXlpsjN7GgMHDDUL906yW7sF6pwvPstB3ctFPs/k83PI6RK2ZGHo1yOhTHKzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGsh8+aN9g/GEJcajTFAJ1f9+ro7qWzwPZ+kT4P05xdoRPYw+s
	5OrPl8UV08ecVXUrskRkJsexJhIDIADJa/BzsZmJrh+Uy99uC+qvzbfhSWJH5DyPURBm4Wv/qFQ
	u5bulusaJdTT4GWY0zgV+QcbzHhOAW0ezgPB8yXs9wuCQqH4x2fAclam+HpEjaWKzUmHj8mnGCH
	nPV/MF5DQWeRalWJBK+ZUA+klLCFFlFEXx
X-Gm-Gg: ASbGnctshPSJNpzdwgQlxGyyVz81wUAsCvHJ6vZ0t/QJXfLn39yO7MYKx99tuidtr+T
	HvT+wxUMhH5VsjOQV5AZnKjjR5x/L7xzwkjd2r/h2FtaqT8khYYr5Syo3GAQrEK1LBABMj97dnV
	e1/Sdl4mykW+FJre2jkh9S1qK4JD4QQHfFjX9jFlf806t1edn4KScLZvBh
X-Received: by 2002:a17:907:94d3:b0:b6d:5fbf:8c63 with SMTP id a640c23a62f3a-b72631fdf5cmr29677866b.15.1762275345081;
        Tue, 04 Nov 2025 08:55:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0F6IPtMO6sLF8EVo/ZKpg4T9PTY1cBgQJI1AWgls82FiG7QTQdkTU5cch5q8n9/7j6YmE/dmzTamG16w02RI=
X-Received: by 2002:a17:907:94d3:b0:b6d:5fbf:8c63 with SMTP id
 a640c23a62f3a-b72631fdf5cmr29673566b.15.1762275344567; Tue, 04 Nov 2025
 08:55:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030144438.7582-1-minhquangbui99@gmail.com> <1762149401.6256416-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1762149401.6256416-7-xuanzhuo@linux.alibaba.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 5 Nov 2025 00:55:07 +0800
X-Gm-Features: AWmQ_blI7oSZAo-0MCFKdglnXUXPuueQuOSCwEEpEbibTzqvZtiLszZM2HTCGLE
Message-ID: <CAPpAL=x-fVOkm=D_OeVLjWwUKThM=1FQFQBZyyBOrH30TEyZdA@mail.gmail.com>
Subject: Re: [PATCH net v7] virtio-net: fix received length check in big packets
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Nov 3, 2025 at 1:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Thu, 30 Oct 2025 21:44:38 +0700, Bui Quang Minh <minhquangbui99@gmail.=
com> wrote:
> > Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> > for big packets"), when guest gso is off, the allocated size for big
> > packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
> > negotiated MTU. The number of allocated frags for big packets is stored
> > in vi->big_packets_num_skbfrags.
> >
> > Because the host announced buffer length can be malicious (e.g. the hos=
t
> > vhost_net driver's get_rx_bufs is modified to announce incorrect
> > length), we need a check in virtio_net receive path. Currently, the
> > check is not adapted to the new change which can lead to NULL page
> > pointer dereference in the below while loop when receiving length that
> > is larger than the allocated one.
> >
> > This commit fixes the received length check corresponding to the new
> > change.
> >
> > Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big=
 packets")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> > ---
> > Changes in v7:
> > - Fix typos
> > - Link to v6: https://lore.kernel.org/netdev/20251028143116.4532-1-minh=
quangbui99@gmail.com/
> > Changes in v6:
> > - Fix the length check
> > - Link to v5: https://lore.kernel.org/netdev/20251024150649.22906-1-min=
hquangbui99@gmail.com/
> > Changes in v5:
> > - Move the length check to receive_big
> > - Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-min=
hquangbui99@gmail.com/
> > Changes in v4:
> > - Remove unrelated changes, add more comments
> > - Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-min=
hquangbui99@gmail.com/
> > Changes in v3:
> > - Convert BUG_ON to WARN_ON_ONCE
> > - Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-min=
hquangbui99@gmail.com/
> > Changes in v2:
> > - Remove incorrect give_pages call
> > - Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-min=
hquangbui99@gmail.com/
> > ---
> >  drivers/net/virtio_net.c | 25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index a757cbcab87f..421b9aa190a0 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct virtnet_=
info *vi,
> >               goto ok;
> >       }
> >
> > -     /*
> > -      * Verify that we can indeed put this data into a skb.
> > -      * This is here to handle cases when the device erroneously
> > -      * tries to receive more than is possible. This is usually
> > -      * the case of a broken device.
> > -      */
> > -     if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> > -             net_dbg_ratelimited("%s: too much data\n", skb->dev->name=
);
> > -             dev_kfree_skb(skb);
> > -             return NULL;
> > -     }
> >       BUG_ON(offset >=3D PAGE_SIZE);
> >       while (len) {
> >               unsigned int frag_size =3D min((unsigned)PAGE_SIZE - offs=
et, len);
> > @@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct net_de=
vice *dev,
> >                                  struct virtnet_rq_stats *stats)
> >  {
> >       struct page *page =3D buf;
> > -     struct sk_buff *skb =3D
> > -             page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
> > +     struct sk_buff *skb;
> > +
> > +     /* Make sure that len does not exceed the size allocated in
> > +      * add_recvbuf_big.
> > +      */
> > +     if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE=
)) {
> > +             pr_debug("%s: rx error: len %u exceeds allocated size %lu=
\n",
> > +                      dev->name, len,
> > +                      (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> > +             goto err;
> > +     }
> >
> > +     skb =3D page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
> >       u64_stats_add(&stats->bytes, len - vi->hdr_len);
> >       if (unlikely(!skb))
> >               goto err;
> > --
> > 2.43.0
> >
>


