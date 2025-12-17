Return-Path: <stable+bounces-202750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B92B7CC5D7D
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 03:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 334EA300463B
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 02:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4146275AF5;
	Wed, 17 Dec 2025 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8jYtKKa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkzpT9rj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9121ADC7E
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765940326; cv=none; b=kaREkb+O5hyzoV9Gvgf4gn26O0zGWAHShslvI1jRvXWvuqk8Jp/LDodtvhc2R/Wj5DdCpFcCdEqzJr5IPlb+PP2Qg8WKECjqyCwizjT2h1a3qqBWe7uEJQd+j5Xgn1IgUJYask72+7ZO2yWgOTMaHFTZDZCPo+DqcHrjMqlFx68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765940326; c=relaxed/simple;
	bh=ki4Z6EgMiaLkw7yGdpLQ/t3Ubgyn531LzW9mZUQc2Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSUYWpRuLFHGSWKop2fPWJuD3kIuAWiCVHXuADUbWZyXXxHwBAwryNUYixm1D/Y4gyrLUWEeBeOCOoT8xi9t6M+eqRGAnTUmJ03rbM8bOt6875wfdYBVk3fJIq3nXPvBf/TsQ8nZGlwuCY0x0h4jHrhT8BHqc9UsPM3Bk67vKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8jYtKKa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DkzpT9rj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765940323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+QZEn+Wyweu2+8fmOhOu2NRpSJyl4s22Bb96PRSdiE=;
	b=C8jYtKKa3Q3kirbnuuW+VsoChy1PG5vCgckNe71OkmbxHuJW3ZAgvunPWviC8X/LsmqmmU
	9wq7pBJJu8Ix7x/s61eH7H+b8+s/Tf7ONl899NtjQI3q4QHdJl5bE37bn2poyvsggZyfCS
	r9ANL/kQY6FwSR7QVOqkhutn9Tm597E=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-_htKIWqFNSeAhAOcCU8Img-1; Tue, 16 Dec 2025 21:58:40 -0500
X-MC-Unique: _htKIWqFNSeAhAOcCU8Img-1
X-Mimecast-MFC-AGG-ID: _htKIWqFNSeAhAOcCU8Img_1765940320
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c5d203988so7653322a91.3
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 18:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765940320; x=1766545120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+QZEn+Wyweu2+8fmOhOu2NRpSJyl4s22Bb96PRSdiE=;
        b=DkzpT9rj/oOi5F+VdTruLqqBPhL6SbrdU/aqDTpxpJVoeMdupL2K2xZqTvSzcAL13i
         prrsv6nWtNZv/GGDskhNLKEa3eZtNhf8X3tr3xzq/bM2vmR46nluHK1Q8R4bDIXr7wzz
         y+BbaIh44X14WvBtx8M5uKTcRw83gmmUcjqye/xdpCUmp40VMzeVImpo3Hmj/sdx3Osq
         tx3r7ECJc+6dgCS1un0D8T7fEkK277F66g0ApRDPpL5evvxEueaKvj6BPQDSkgGpHP1A
         /rNri2+/AVW6/8CVQwndGl4RYDWGMKP+QYzSCTmYkNMyvL7QQQQh22DE0Ee6IlIn2Q+H
         ngWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765940320; x=1766545120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d+QZEn+Wyweu2+8fmOhOu2NRpSJyl4s22Bb96PRSdiE=;
        b=QbHhxkC+WSM1ID4tA47o60xTnNjCh+zfRi8qZvc8SFzxSZAkRpvmfBEj5yFbNy0cj4
         iX6a+wVErY2GfRAE5J6pt4JQEBQt8PKz93SfOi9jOnR42kiK+JUFa6kObYFTBp3z0Cp9
         mIlPkMipTpEFXOeXXcCtTStMtOWJ8igPCN/DXMRAtsvjvQ32gnEsEPy5Dd7vIxZbQG6w
         boC5cAYplQFYPKbGUMjiDaefdCtM8tn3Y2eNKXFdWVGdt2X/2jYC5frBjp+m61xOxkco
         Nm3h542phX68GETreWnIfoSJDOmIMX38zPrz/+beSzTDMXn/z8gAbSCR92p0RUeLhMUz
         jcMg==
X-Forwarded-Encrypted: i=1; AJvYcCWvoNmMVT3ZanQicaSRz2JOvwsC3VAYn1Ttg3wOAiI+xSyGW7vPA6XDzZUeZzNsqQD+zdWtf88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7c37i1IFKdEM0KJxnzloUzdBRbKFRsewLwK0aoOsgpRvPfu9o
	/oMS/Qni3FSYWjfvleCsmWvXEuDVFCQH48/u1E9cK/TD1HEf7M4Ij08ZFlypbX9PHbG8c0gGPYA
	+6sBq6BbDhV26R06ph510OelYHncJuMuGfnXlJ4bEcf6GmVZVdCo7Chj57Ir4/5v0iYNZhZBlBO
	Xn01RAb0ade4WJCv7JOIXKfqCEXIyCUtvV
X-Gm-Gg: AY/fxX53/4VV9NWALKCwsvB8O45nRwl3NOqPIjWV5XwZWbnFPyefBFybbiLqbD5Sysc
	pADENB3gSCx5CxO2jbsvgo2+nR9fzinObxORDggGtueLqkmJr37H87Lr6DTdlVvnKky3eHNYbDO
	CWUSa0XbQPk0wOw8w9LsuRxCx/ebx4BdKdSZ0VhtZQFVCjUbRV1JitjyIDaBkKrrPnyw==
X-Received: by 2002:a17:90b:2e0c:b0:341:b5a2:3e7b with SMTP id 98e67ed59e1d1-34abd6cde5bmr14971861a91.4.1765940319834;
        Tue, 16 Dec 2025 18:58:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHBnohIr+ekVzlEsUxGFlh+h5BLD8vynfeT39kKrUW7iKPHJ01VT2DabkqJezH5tQUbEAZNQaas/XipqjSA5I=
X-Received: by 2002:a17:90b:2e0c:b0:341:b5a2:3e7b with SMTP id
 98e67ed59e1d1-34abd6cde5bmr14971829a91.4.1765940319386; Tue, 16 Dec 2025
 18:58:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212152741.11656-1-minhquangbui99@gmail.com>
 <CACGkMEtzXmfDhiQiq=5qPGXG+rJcxGkWk0CZ4X_2cnr2UVH+eQ@mail.gmail.com> <3f5613e9-ccd0-4096-afc3-67ee94f6f660@gmail.com>
In-Reply-To: <3f5613e9-ccd0-4096-afc3-67ee94f6f660@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Dec 2025 10:58:27 +0800
X-Gm-Features: AQt7F2pdpQzR2bvq-MC_OypNwCm121ZG5PfGmSN73KFszst18PHbxcVd2x2bNXU
Message-ID: <CACGkMEs+Mse7nhPPiqbd2doeGtPD2QD3BM_cztr6e=VfuiobHQ@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio-net: enable all napis before scheduling
 refill work
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 12:23=E2=80=AFAM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> On 12/16/25 11:16, Jason Wang wrote:
> > On Fri, Dec 12, 2025 at 11:28=E2=80=AFPM Bui Quang Minh
> > <minhquangbui99@gmail.com> wrote:
> >> Calling napi_disable() on an already disabled napi can cause the
> >> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
> >> when pausing rx"), to avoid the deadlock, when pausing the RX in
> >> virtnet_rx_pause[_all](), we disable and cancel the delayed refill wor=
k.
> >> However, in the virtnet_rx_resume_all(), we enable the delayed refill
> >> work too early before enabling all the receive queue napis.
> >>
> >> The deadlock can be reproduced by running
> >> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
> >> device and inserting a cond_resched() inside the for loop in
> >> virtnet_rx_resume_all() to increase the success rate. Because the work=
er
> >> processing the delayed refilled work runs on the same CPU as
> >> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
> >> In real scenario, the contention on netdev_lock can cause the
> >> reschedule.
> >>
> >> This fixes the deadlock by ensuring all receive queue's napis are
> >> enabled before we enable the delayed refill work in
> >> virtnet_rx_resume_all() and virtnet_open().
> >>
> >> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing =
rx")
> >> Reported-by: Paolo Abeni <pabeni@redhat.com>
> >> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/resu=
lts/400961/3-xdp-py/stderr
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> >> ---
> >> Changes in v2:
> >> - Move try_fill_recv() before rx napi_enable()
> >> - Link to v1: https://lore.kernel.org/netdev/20251208153419.18196-1-mi=
nhquangbui99@gmail.com/
> >> ---
> >>   drivers/net/virtio_net.c | 71 +++++++++++++++++++++++++-------------=
--
> >>   1 file changed, 45 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index 8e04adb57f52..4e08880a9467 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -3214,21 +3214,31 @@ static void virtnet_update_settings(struct vir=
tnet_info *vi)
> >>   static int virtnet_open(struct net_device *dev)
> >>   {
> >>          struct virtnet_info *vi =3D netdev_priv(dev);
> >> +       bool schedule_refill =3D false;
> >>          int i, err;
> >>
> >> -       enable_delayed_refill(vi);
> >> -
> >> +       /* - We must call try_fill_recv before enabling napi of the sa=
me receive
> >> +        * queue so that it doesn't race with the call in virtnet_rece=
ive.
> >> +        * - We must enable and schedule delayed refill work only when=
 we have
> >> +        * enabled all the receive queue's napi. Otherwise, in refill_=
work, we
> >> +        * have a deadlock when calling napi_disable on an already dis=
abled
> >> +        * napi.
> >> +        */
> >>          for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >>                  if (i < vi->curr_queue_pairs)
> >>                          /* Make sure we have some buffers: if oom use=
 wq. */
> >>                          if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL=
))
> >> -                               schedule_delayed_work(&vi->refill, 0);
> >> +                               schedule_refill =3D true;
> >>
> >>                  err =3D virtnet_enable_queue_pair(vi, i);
> >>                  if (err < 0)
> >>                          goto err_enable_qp;
> >>          }
> > So NAPI could be scheduled and it may want to refill but since refill
> > is not enabled, there would be no refill work.
> >
> > Is this a problem?
>
> You are right. It is indeed a problem.
>
> I think we can unconditionally schedule the delayed refill after
> enabling all the RX NAPIs (don't check the boolean schedule_refill
> anymore) to ensure that we will have refill work. We can still keep the
> try_fill_recv here to fill the receive buffer earlier in normal case.
> What do you think?

Or we can have a reill_pending but basically I think we need something
that is much more simple. That is, using a per rq work instead of a
global one?

Thanks

>
> >
> >
> >> +       enable_delayed_refill(vi);
> >> +       if (schedule_refill)
> >> +               schedule_delayed_work(&vi->refill, 0);
> >> +
> >>          if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> >>                  if (vi->status & VIRTIO_NET_S_LINK_UP)
> >>                          netif_carrier_on(vi->dev);
> >> @@ -3463,39 +3473,48 @@ static void virtnet_rx_pause(struct virtnet_in=
fo *vi, struct receive_queue *rq)
> >>          __virtnet_rx_pause(vi, rq);
> >>   }
> >>
> > Thanks
> >
>
> Thanks,
> Quang Minh.
>


