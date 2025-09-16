Return-Path: <stable+bounces-179709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EE6B5926E
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 11:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6719932012D
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 09:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A74729B217;
	Tue, 16 Sep 2025 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRTbo2F/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7101E47B7
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015562; cv=none; b=BrtILpeycoEoaeCJdoHLzQm3XpZ3gBElKV2DHfphW8DKp40eo7KW6sMh5MYQlQADsZGgbjFeHqdTXGEgnJOfqt4VWlRQhuSQeVAHDIFWzOICwVd0Ld0dDcHxmro/6O1GuZSSSgzcmLyxLlRA9WkHx6RvPq5KfVDdEbntrag3ctU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015562; c=relaxed/simple;
	bh=6DRYBwPSDQW1jpjkTq0DHNAJkPr8od/IdlP5PW4dxXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9YeAt7pbf53n1IN9PAZUICgdOsqYavTpVDx3krFMrajM2U8WJKto9b3gew3vkN2ZF8i1AAaMuK+iR5AtgBk1gb0+1yclCe+Va5aqbwoxJaPz8niDvOf0hnWmx2rVpzfcjmGD4n2brzGK0WVLTyq+VT8JBnY0QUatwk5whP7cPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRTbo2F/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758015559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mg7T0kQEdQ7FBfapeuxsmVNYMds4ObzbW92Zj/OuxmU=;
	b=fRTbo2F/CmhuJKkk5LbxKcf7SHw9FH/7zHIs2NFcGBUurwuUxg4SG5AV+1P+hKurC/WIu6
	EyL1yBd1U/yJgnLKiHv3QrSndwyS/RZHtwaIVbfKzhs9eBbHwqalqGEKqBV5Ikgrk0BpLq
	8zlAPzjTFNXDxe08Q8VakDI8w6zFXEI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-0dvikQDvOemIAnOA474C7w-1; Tue, 16 Sep 2025 05:39:18 -0400
X-MC-Unique: 0dvikQDvOemIAnOA474C7w-1
X-Mimecast-MFC-AGG-ID: 0dvikQDvOemIAnOA474C7w_1758015557
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b0ccfdab405so305257366b.2
        for <stable@vger.kernel.org>; Tue, 16 Sep 2025 02:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015557; x=1758620357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mg7T0kQEdQ7FBfapeuxsmVNYMds4ObzbW92Zj/OuxmU=;
        b=tMVYv2QuFgMKQ/b2yaf4iFipE6M1sYVEblXJfgpBTHRcEgh9OBXeMut5DTfIgWvD8Q
         8LHBgOD/v4byezCkaS9aiMuORqOUvn2y8HcwdgrkC4U3gleSsHVSZBmMGTtt695AEcRF
         w3FlNmNqj8C11hAGPZS3vxafme7ZBNtRvnABcHutYEgpBTQKZoGHocpE9cIZp86bPyy4
         p8k1sbq9mPRpRblHaWRC9RLOPiCQYampRoQPyXe5z2w5H2VrVOguZNtKmEQ2P15nTMcd
         cO6IHAFGNirRMOylzuSsymFkVvqnRolNVMNyyZIiq6fQXMx+u6Uot3qtoLqV3UVsKtJ+
         0otA==
X-Forwarded-Encrypted: i=1; AJvYcCVLg//Pymu4m3GWTy9OY0kw6fgPvy/9VHJkyX2flbBSLiF+XM/+RdA0+qIB1OfR9YN8Aq9AFJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwarP8NpCFGlh+D8PDI5TWpNwJOEAXhWfQVC8CKzw8cUGwBbWeJ
	cbHxvre5BLEgN18vBV0P54itFxUWvh909XM+qDItbGTaFGR7kVjHBweMe/kfC4xtbXHgojBmmJr
	RYsXESSXFOmxQRzXAxcp1kskEepqUpFKGLArFkJzj4dyerXdggiS9KwqtddKy80cpsQ==
X-Gm-Gg: ASbGncudQVo3xSSRaY/u0gJiOvTK8Myjs1N7xDOZl2m+kcQ0ASpyD4qGERx3jjdQEYE
	pSljrOAMjL9Cysqr5On4iPUDogYp7hpr/VJ53dVGplC2YTrZxsUnZGxsSWWOplAGfrJDvvlVjWU
	j5IB1W29Xbut4F9O9F2v2z57SNk2esZRK/NYun3ztAc8GMSljdPOocH8UhWQPUShadQ3xuYFsL+
	0njfSvFBSf4p7ZNtEQ1B6QdxuDlioztjQgvI4qtNlONxZnMxEL/55bnTO8uHiZKX0/B0K/3rXvO
	wyTf5Q3RgtyQIF6YLSsPWAt9HZWs
X-Received: by 2002:a17:907:7e84:b0:b04:3302:d7a8 with SMTP id a640c23a62f3a-b07c3a77ef1mr1835871166b.58.1758015556782;
        Tue, 16 Sep 2025 02:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL9xm1d3rRrWqvJve/PLiCDKmVMyNZWdCqpuRPm8Fk1iVgEX6WsHMd5ecb9Pr8TQ5Xn3WbGQ==
X-Received: by 2002:a17:907:7e84:b0:b04:3302:d7a8 with SMTP id a640c23a62f3a-b07c3a77ef1mr1835869266b.58.1758015556348;
        Tue, 16 Sep 2025 02:39:16 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b08cab32303sm687037066b.72.2025.09.16.02.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:39:15 -0700 (PDT)
Date: Tue, 16 Sep 2025 05:39:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
Message-ID: <20250916053418-mutt-send-email-mst@kernel.org>
References: <20250912082658.2262-1-jasowang@redhat.com>
 <20250912082658.2262-2-jasowang@redhat.com>
 <20250915120210-mutt-send-email-mst@kernel.org>
 <CACGkMEufUAL1tBrfZVMQCEBmBZ=Z+aPqUtP=RzOQhjtG9jn7UA@mail.gmail.com>
 <20250916011733-mutt-send-email-mst@kernel.org>
 <CACGkMEu_p-ouLbEq26vMTJmeGs1hw5JHOk1qLt8mLLPOMLDbaQ@mail.gmail.com>
 <20250916030549-mutt-send-email-mst@kernel.org>
 <CACGkMEt2fAkCb_nC4QwR+3Jq+fS8=7bx=T3AEzPP1KGLErbSBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEt2fAkCb_nC4QwR+3Jq+fS8=7bx=T3AEzPP1KGLErbSBA@mail.gmail.com>

On Tue, Sep 16, 2025 at 03:20:36PM +0800, Jason Wang wrote:
> On Tue, Sep 16, 2025 at 3:08 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 16, 2025 at 02:24:22PM +0800, Jason Wang wrote:
> > > On Tue, Sep 16, 2025 at 1:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 10:37:35AM +0800, Jason Wang wrote:
> > > > > On Tue, Sep 16, 2025 at 12:03 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> > > > > > > Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> > > > > > > sendmsg") tries to defer the notification enabling by moving the logic
> > > > > > > out of the loop after the vhost_tx_batch() when nothing new is
> > > > > > > spotted. This will bring side effects as the new logic would be reused
> > > > > > > for several other error conditions.
> > > > > > >
> > > > > > > One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> > > > > > > might return -EAGAIN and exit the loop and see there's still available
> > > > > > > buffers, so it will queue the tx work again until userspace feed the
> > > > > > > IOTLB entry correctly. This will slowdown the tx processing and may
> > > > > > > trigger the TX watchdog in the guest.
> > > > > > >
> > > > > > > Fixing this by stick the notificaiton enabling logic inside the loop
> > > > > > > when nothing new is spotted and flush the batched before.
> > > > > > >
> > > > > > > Reported-by: Jon Kohler <jon@nutanix.com>
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > ---
> > > > > > >  drivers/vhost/net.c | 33 +++++++++++++--------------------
> > > > > > >  1 file changed, 13 insertions(+), 20 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > > > > > index 16e39f3ab956..3611b7537932 100644
> > > > > > > --- a/drivers/vhost/net.c
> > > > > > > +++ b/drivers/vhost/net.c
> > > > > > > @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > > > > > >       int err;
> > > > > > >       int sent_pkts = 0;
> > > > > > >       bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> > > > > > > -     bool busyloop_intr;
> > > > > > >       bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> > > > > > >
> > > > > > >       do {
> > > > > > > -             busyloop_intr = false;
> > > > > > > +             bool busyloop_intr = false;
> > > > > > > +
> > > > > > >               if (nvq->done_idx == VHOST_NET_BATCH)
> > > > > > >                       vhost_tx_batch(net, nvq, sock, &msg);
> > > > > > >
> > > > > > > @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > > > > > >                       break;
> > > > > > >               /* Nothing new?  Wait for eventfd to tell us they refilled. */
> > > > > > >               if (head == vq->num) {
> > > > > > > -                     /* Kicks are disabled at this point, break loop and
> > > > > > > -                      * process any remaining batched packets. Queue will
> > > > > > > -                      * be re-enabled afterwards.
> > > > > > > +                     /* Flush batched packets before enabling
> > > > > > > +                      * virqtueue notification to reduce
> > > > > > > +                      * unnecssary virtqueue kicks.
> > > > > > >                        */
> > > > > > > +                     vhost_tx_batch(net, nvq, sock, &msg);
> > > > > >
> > > > > > So why don't we do this in the "else" branch"? If we are busy polling
> > > > > > then we are not enabling kicks, so is there a reason to flush?
> > > > >
> > > > > It should be functional equivalent:
> > > > >
> > > > > do {
> > > > >     if (head == vq->num) {
> > > > >         vhost_tx_batch();
> > > > >         if (unlikely(busyloop_intr)) {
> > > > >             vhost_poll_queue()
> > > > >         } else if () {
> > > > >             vhost_disable_notify(&net->dev, vq);
> > > > >             continue;
> > > > >         }
> > > > >         return;
> > > > > }
> > > > >
> > > > > vs
> > > > >
> > > > > do {
> > > > >     if (head == vq->num) {
> > > > >         if (unlikely(busyloop_intr)) {
> > > > >             vhost_poll_queue()
> > > > >         } else if () {
> > > > >             vhost_tx_batch();
> > > > >             vhost_disable_notify(&net->dev, vq);
> > > > >             continue;
> > > > >         }
> > > > >         break;
> > > > > }
> > > > >
> > > > > vhost_tx_batch();
> > > > > return;
> > > > >
> > > > > Thanks
> > > > >
> > > >
> > > > But this is not what the code comment says:
> > > >
> > > >                      /* Flush batched packets before enabling
> > > >                       * virqtueue notification to reduce
> > > >                       * unnecssary virtqueue kicks.
> > > >
> > > >
> > > > So I ask - of we queued more polling, why do we need
> > > > to flush batched packets? We might get more in the next
> > > > polling round, this is what polling is designed to do.
> > >
> > > The reason is there could be a rx work when busyloop_intr is true, so
> > > we need to flush.
> > >
> > > Thanks
> >
> > Then you need to update the comment to explain.
> > Want to post your version of this patchset?
> 
> I'm fine if you wish. Just want to make sure, do you prefer a patch
> for your vhost tree or net?
> 
> For net, I would stick to 2 patches as if we go for 3, the last patch
> that brings back flush looks more like an optimization.

Jason it does not matter how it looks. We do not need to sneak in
features - if the right thing is to add patch 3 in net then
it is, just add an explanation why in the cover letter.
And if it is not then it is not and squashing it with a revert
is not a good idea.

> For vhost, I can go with 3 patches, but I see that your series has been queued.
>
> And the build of the current vhost tree is broken by:
> 
> commit 41bafbdcd27bf5ce8cd866a9b68daeb28f3ef12b (HEAD)
> Author: Michael S. Tsirkin <mst@redhat.com>
> Date:   Mon Sep 15 10:47:03 2025 +0800
> 
>     vhost-net: flush batched before enabling notifications
> 
> It looks like it misses a brace.
> 
> Thanks

Ugh forgot to commit :(
I guess this is what happens when one tries to code past midnight.
Dropped now pls do proceed.

> >
> >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > > +                     if (unlikely(busyloop_intr)) {
> > > > > > > +                             vhost_poll_queue(&vq->poll);
> > > > > > > +                     } else if (unlikely(vhost_enable_notify(&net->dev,
> > > > > > > +                                                             vq))) {
> > > > > > > +                             vhost_disable_notify(&net->dev, vq);
> > > > > > > +                             continue;
> > > > > > > +                     }
> > > > > > >                       break;
> > > > > > >               }
> > > > > > >
> > > > > > > @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > > > > > >               ++nvq->done_idx;
> > > > > > >       } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
> > > > > > >
> > > > > > > -     /* Kicks are still disabled, dispatch any remaining batched msgs. */
> > > > > > >       vhost_tx_batch(net, nvq, sock, &msg);
> > > > > > > -
> > > > > > > -     if (unlikely(busyloop_intr))
> > > > > > > -             /* If interrupted while doing busy polling, requeue the
> > > > > > > -              * handler to be fair handle_rx as well as other tasks
> > > > > > > -              * waiting on cpu.
> > > > > > > -              */
> > > > > > > -             vhost_poll_queue(&vq->poll);
> > > > > > > -     else
> > > > > > > -             /* All of our work has been completed; however, before
> > > > > > > -              * leaving the TX handler, do one last check for work,
> > > > > > > -              * and requeue handler if necessary. If there is no work,
> > > > > > > -              * queue will be reenabled.
> > > > > > > -              */
> > > > > > > -             vhost_net_busy_poll_try_queue(net, vq);
> > > > > > >  }
> > > > > > >
> > > > > > >  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> > > > > > > --
> > > > > > > 2.34.1
> > > > > >
> > > >
> >


