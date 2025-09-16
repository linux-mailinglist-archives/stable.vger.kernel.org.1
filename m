Return-Path: <stable+bounces-179682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD240B58DD3
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 07:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEB387AA1F0
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 05:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD36F27E040;
	Tue, 16 Sep 2025 05:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bzm9fMvD"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49D2C15BC
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757999948; cv=none; b=CUCsHkgClA2dlySIen2ijzrJvv5CVhwyLrWXJeAi3ExcDF3eZzCG6z76ADwOm4foNT8HhWysQ2Ym3ReRsPlFcS/OD4Pxo967/IgRYFIm4DIxNw5naDhTSSw3qpzYsZArpCt5DR9TgIQ4CTWFi4apRXqYLqKcUgUfz89s99+nm7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757999948; c=relaxed/simple;
	bh=mYY1Q6a+G8tiWMSHSj+eXVNe+H398j6nOY5cYHrd3rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROCaKhy9jIWg5zY5jn6pmQMPzyPUH4I46vKt/CB9s4AHU2nPtyZAzwy5Q3+O/n+gkgc+T+t4oc/gS38IhV5cQp2OsqGYUBZO4e1sFZfUg8G6sCeRqmYlq4NPqk/kWRdaMABK11Fpo4ycQ3amxvempOPs1P2I91MhbNUSecqRhU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bzm9fMvD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757999945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cqWpCLzeZ7Ek+DqtxOkx2773HtQBKMmlIbsEIMhI1E=;
	b=Bzm9fMvDBPuENJhw+GmkZa6e1W2zqltk7OXVCFrwAU/Oo9pNoIDV8tMuhtviOCD56VLpYn
	6Jss/cDw6Za+rpR7baPZsdSY1HCE3kMZjF6UB9w76dck0jXxq4ztgM8rdYout9N0JHW7q/
	D6N7PgfU9bRGOSzTqQTUJ4vE1YspCvc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-XvlTirIzNs6obRxEuD0fPA-1; Tue, 16 Sep 2025 01:19:01 -0400
X-MC-Unique: XvlTirIzNs6obRxEuD0fPA-1
X-Mimecast-MFC-AGG-ID: XvlTirIzNs6obRxEuD0fPA_1757999940
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aff0df4c4abso674078666b.1
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 22:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757999940; x=1758604740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8cqWpCLzeZ7Ek+DqtxOkx2773HtQBKMmlIbsEIMhI1E=;
        b=kM5yIiSpLQn+sfgJajG5oiN8wKKuYNRRYyhB2M8iojN4EE95iX3WgUB6yyIN0dIVdG
         Zz98MPlQPINyNjYx8iTt7nYVpbc3OBeaIlqOW6josqGpFtr3z3GDiCVqbImADRS9IMvh
         s3SI8U3MPudDZp6VAV3lwELIpUnZjh43vMu2jYwDzFR5qhmWPpo3KMjsR4FLO9Zvgmt2
         hob6fk2X7NCmUtJjHdVuTYKoOFUtjFbwBEEpSuBhYrKD1mAvmCgjvVHGWBeNo0C2ot/r
         H3+5yyHd23/MtPQDVAlqSyz14ZFlUfu+IRh1UVPDSWXo8q9STC8AaLwAlH9IGLOUWjE7
         nRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2sKVkMrUsnOxmg0osjgh+yzXbXJsq8J37OPZW7KEJjiou4q1Y1Tt0VVtqwrawVLBRZNeq8oI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtSMcgqI6oSBSsSxMnRB1kMqrstuWE0J8e+leOdjB1AgKXl4ss
	2hcB4kFWHxY7xEDZrKuXe/o6adZ9hv4NcIFVafUSKubd5AF2OI9+QGMU9r7746tUNjDZtqtUyGP
	C5hDCmIlIz7trsMADxLA5yJLpPpw7ZR3+DM8H90h4OjtOPtOpIek3/kDU4oJlGfWzKQ==
X-Gm-Gg: ASbGncuaTE9d4JCNVPX3RGWYvz04X8+6dWETgNxW+bfjirEgH6mjZFOh/jAO3WSwb9A
	muA72WCoDhJkx8keW728rhTsAa2xs9IcRffV/lcZelHFWgsSclntP3BF42+fOLOmClz9h0TSb6o
	MZ5kUy13FuYYm1mApbtntQ1yCPAmt0xbsb5uo95AtNNvuZy+jRGdbdTMQdQyb3QOERSGq2xbFqh
	QdVFixwP4fmoUNHk3HDrIAGsuLBdOINTc6BVSZ0lTRKKoYv3CmX2AMo5p6YFI36cYQ6tfrM+GdV
	mHPkC6fgjoPM+19cu8sIAOpNdFZA
X-Received: by 2002:a17:907:1b1d:b0:b04:a780:4673 with SMTP id a640c23a62f3a-b07c38292a0mr1470550866b.31.1757999939873;
        Mon, 15 Sep 2025 22:18:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeTBH3RrhB4KX+YqUITKSLlPI9qo0agFX7/p4HwGPFdqgb6XY+aoH+6CU5sr1Y0eG7AGevXg==
X-Received: by 2002:a17:907:1b1d:b0:b04:a780:4673 with SMTP id a640c23a62f3a-b07c38292a0mr1470547666b.31.1757999939378;
        Mon, 15 Sep 2025 22:18:59 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f22b1sm1090360166b.86.2025.09.15.22.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 22:18:58 -0700 (PDT)
Date: Tue, 16 Sep 2025 01:18:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
Message-ID: <20250916011733-mutt-send-email-mst@kernel.org>
References: <20250912082658.2262-1-jasowang@redhat.com>
 <20250912082658.2262-2-jasowang@redhat.com>
 <20250915120210-mutt-send-email-mst@kernel.org>
 <CACGkMEufUAL1tBrfZVMQCEBmBZ=Z+aPqUtP=RzOQhjtG9jn7UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEufUAL1tBrfZVMQCEBmBZ=Z+aPqUtP=RzOQhjtG9jn7UA@mail.gmail.com>

On Tue, Sep 16, 2025 at 10:37:35AM +0800, Jason Wang wrote:
> On Tue, Sep 16, 2025 at 12:03 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> > > Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> > > sendmsg") tries to defer the notification enabling by moving the logic
> > > out of the loop after the vhost_tx_batch() when nothing new is
> > > spotted. This will bring side effects as the new logic would be reused
> > > for several other error conditions.
> > >
> > > One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> > > might return -EAGAIN and exit the loop and see there's still available
> > > buffers, so it will queue the tx work again until userspace feed the
> > > IOTLB entry correctly. This will slowdown the tx processing and may
> > > trigger the TX watchdog in the guest.
> > >
> > > Fixing this by stick the notificaiton enabling logic inside the loop
> > > when nothing new is spotted and flush the batched before.
> > >
> > > Reported-by: Jon Kohler <jon@nutanix.com>
> > > Cc: stable@vger.kernel.org
> > > Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/vhost/net.c | 33 +++++++++++++--------------------
> > >  1 file changed, 13 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > index 16e39f3ab956..3611b7537932 100644
> > > --- a/drivers/vhost/net.c
> > > +++ b/drivers/vhost/net.c
> > > @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > >       int err;
> > >       int sent_pkts = 0;
> > >       bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> > > -     bool busyloop_intr;
> > >       bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> > >
> > >       do {
> > > -             busyloop_intr = false;
> > > +             bool busyloop_intr = false;
> > > +
> > >               if (nvq->done_idx == VHOST_NET_BATCH)
> > >                       vhost_tx_batch(net, nvq, sock, &msg);
> > >
> > > @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > >                       break;
> > >               /* Nothing new?  Wait for eventfd to tell us they refilled. */
> > >               if (head == vq->num) {
> > > -                     /* Kicks are disabled at this point, break loop and
> > > -                      * process any remaining batched packets. Queue will
> > > -                      * be re-enabled afterwards.
> > > +                     /* Flush batched packets before enabling
> > > +                      * virqtueue notification to reduce
> > > +                      * unnecssary virtqueue kicks.
> > >                        */
> > > +                     vhost_tx_batch(net, nvq, sock, &msg);
> >
> > So why don't we do this in the "else" branch"? If we are busy polling
> > then we are not enabling kicks, so is there a reason to flush?
> 
> It should be functional equivalent:
> 
> do {
>     if (head == vq->num) {
>         vhost_tx_batch();
>         if (unlikely(busyloop_intr)) {
>             vhost_poll_queue()
>         } else if () {
>             vhost_disable_notify(&net->dev, vq);
>             continue;
>         }
>         return;
> }
> 
> vs
> 
> do {
>     if (head == vq->num) {
>         if (unlikely(busyloop_intr)) {
>             vhost_poll_queue()
>         } else if () {
>             vhost_tx_batch();
>             vhost_disable_notify(&net->dev, vq);
>             continue;
>         }
>         break;
> }
> 
> vhost_tx_batch();
> return;
> 
> Thanks
>

But this is not what the code comment says:

                     /* Flush batched packets before enabling
                      * virqtueue notification to reduce
                      * unnecssary virtqueue kicks.


So I ask - of we queued more polling, why do we need
to flush batched packets? We might get more in the next
polling round, this is what polling is designed to do.

 
> 
> >
> >
> > > +                     if (unlikely(busyloop_intr)) {
> > > +                             vhost_poll_queue(&vq->poll);
> > > +                     } else if (unlikely(vhost_enable_notify(&net->dev,
> > > +                                                             vq))) {
> > > +                             vhost_disable_notify(&net->dev, vq);
> > > +                             continue;
> > > +                     }
> > >                       break;
> > >               }
> > >
> > > @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > >               ++nvq->done_idx;
> > >       } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
> > >
> > > -     /* Kicks are still disabled, dispatch any remaining batched msgs. */
> > >       vhost_tx_batch(net, nvq, sock, &msg);
> > > -
> > > -     if (unlikely(busyloop_intr))
> > > -             /* If interrupted while doing busy polling, requeue the
> > > -              * handler to be fair handle_rx as well as other tasks
> > > -              * waiting on cpu.
> > > -              */
> > > -             vhost_poll_queue(&vq->poll);
> > > -     else
> > > -             /* All of our work has been completed; however, before
> > > -              * leaving the TX handler, do one last check for work,
> > > -              * and requeue handler if necessary. If there is no work,
> > > -              * queue will be reenabled.
> > > -              */
> > > -             vhost_net_busy_poll_try_queue(net, vq);
> > >  }
> > >
> > >  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> > > --
> > > 2.34.1
> >


