Return-Path: <stable+bounces-179674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 413D8B58BE9
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 04:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4141BC3C0D
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 02:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843FB25A2A2;
	Tue, 16 Sep 2025 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZkQ2nzg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FE62566E2
	for <stable@vger.kernel.org>; Tue, 16 Sep 2025 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757990278; cv=none; b=OidFVAHy3xbJD3i+Z+QgGg4KNkDrRRq2QeOIdG6b922b24FyI+YSBSvcfITG4Rjr1SGAAAPFKKyL+OBkjStWt/wc/UROwRPJCxK5Q9Z5wyoIEnL0yE1IAxvmjbTIZZUtdFPxF92CHPySsrfp/+Y+QVGNIKIIWss82tqGRoiTxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757990278; c=relaxed/simple;
	bh=gUKy4HbgYm51Znbh/ltm0uWLek9Y6A3xzbjPKF8AM7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjtnGK6H5GhU/ngjJt5zIj9+IdjFmePhn8RVY+izjDNFGAIN+B+7inK97AjyHyuaI3RZ21ZHaCzwUf68/Dia9YFoJ32T5OYr8HmVLs6GpiU2a8kTEB+ES6AmqgIVds0uwCBypItSqXTJyZj5lPdNohTsgozfn0i95giRcHN9zKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZkQ2nzg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757990275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAf0tQ+0pz0qPoEfmgoNOjCObM8zSLJwkzhy+q5XJZY=;
	b=JZkQ2nzggbHZFjG/4lyhcpgjNdHOt+rG9dku2AlhxKnTbDt2HIoq57b7nLFqsCLAuDGRxS
	fHJfqX1XFCIat/W0DAlMJm/Fl9IMpnpeZPqLTnxo4KcLr+Z1a1BdSXORc3nQDHeJAYBns1
	bd8oqjPYFfIlQND4BkJCUKyS1dZ3TuU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112--nupNbMMPIiiy0ch2ct1dw-1; Mon, 15 Sep 2025 22:37:48 -0400
X-MC-Unique: -nupNbMMPIiiy0ch2ct1dw-1
X-Mimecast-MFC-AGG-ID: -nupNbMMPIiiy0ch2ct1dw_1757990267
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32e12b59c0aso3240346a91.2
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 19:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757990267; x=1758595067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAf0tQ+0pz0qPoEfmgoNOjCObM8zSLJwkzhy+q5XJZY=;
        b=YNHb3u8hTm0JEsXasbgdSM0fNsJn2DpqnCU7BIucdH11M+Bw0b2eyM0r6uWPYpicYT
         10PKP1x4SzcZBPf8ABmLC+4grQX5YjYdnmEstWaH7Tr0liHnfZx6DyeMef3LJU2fEBR2
         6mmkVkfaD4w4OhXKb+QqwAD9t8v7SL9MAjC4DA3EMGORbr/PpfcaDVQRDMSA2+NAUjPo
         usLZ2hA84gm81cFj0r3VvljHfow8b6Z9paGDVeiBjLfrsrkk9jpor3b5h9UloOSCnZhU
         9r4ezvvVqOaqpn+mBH77Rm5JF+laLFqveeiDZVQGAYvS3LHp0RMfrHL3EeV09gKcaq6y
         11dg==
X-Forwarded-Encrypted: i=1; AJvYcCW1LMhh0hhXBu03niYmq0MF9RXzQs9iHkclY/XJ2y0IrwO8bdgfpHvKo8lWxbzGG7IDVqZSZNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv32Gs9fhMhJlzShgnU5aFhQbwYcLtVGftrtJi9Yo9sO0Rg+1v
	TWWHbKyZu6Hv10i8OIo8yxsufVnIdcYPvYpYlV4KxhGSfE+j7zbC3tMjHnoMvDsUsWX9posHKfV
	ZSuSYuc1GaqQ3yLgU+hWv8iJx1aeOBHpt3Q0QTmkbjXEz2gOfki+Iu+KHGYWwfEM5IfSauln4LK
	X4uLNiAzJZxGWbvXiIc636UsU152wd/cHH
X-Gm-Gg: ASbGncs+4jyzoJwCO6Or30LksSpfdxPnRR8LTnHuEi0eZ64WVpHb9cZmfGNCYJBZvOg
	0rpqKKU6T3dHEtO+x/emNlS8rPt3YEahjp5lXcUF9idbpt6k3HX61pLz5+FUZZxSIP567yTKtvN
	gku3A82B61QgI/HflYdl0B
X-Received: by 2002:a17:90b:4c4b:b0:32e:7512:b680 with SMTP id 98e67ed59e1d1-32e7512b733mr5143744a91.1.1757990266766;
        Mon, 15 Sep 2025 19:37:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb6D27rOwIabYHDbTeq8O+XXMbNT5JV4s9eACQ1ml/K4xuBJXeSZM1vgjCkw2luMUbq+jomkccwDcI0a/C/DI=
X-Received: by 2002:a17:90b:4c4b:b0:32e:7512:b680 with SMTP id
 98e67ed59e1d1-32e7512b733mr5143719a91.1.1757990266274; Mon, 15 Sep 2025
 19:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912082658.2262-1-jasowang@redhat.com> <20250912082658.2262-2-jasowang@redhat.com>
 <20250915120210-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250915120210-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Sep 2025 10:37:35 +0800
X-Gm-Features: Ac12FXwy79u1dZC54rdy_dwlxjFnrMd4oYnP7Kn26CXew35l54L3830n5p1rHL0
Message-ID: <CACGkMEufUAL1tBrfZVMQCEBmBZ=Z+aPqUtP=RzOQhjtG9jn7UA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org, 
	jon@nutanix.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:03=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> > Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> > sendmsg") tries to defer the notification enabling by moving the logic
> > out of the loop after the vhost_tx_batch() when nothing new is
> > spotted. This will bring side effects as the new logic would be reused
> > for several other error conditions.
> >
> > One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> > might return -EAGAIN and exit the loop and see there's still available
> > buffers, so it will queue the tx work again until userspace feed the
> > IOTLB entry correctly. This will slowdown the tx processing and may
> > trigger the TX watchdog in the guest.
> >
> > Fixing this by stick the notificaiton enabling logic inside the loop
> > when nothing new is spotted and flush the batched before.
> >
> > Reported-by: Jon Kohler <jon@nutanix.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after s=
endmsg")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vhost/net.c | 33 +++++++++++++--------------------
> >  1 file changed, 13 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index 16e39f3ab956..3611b7537932 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net,=
 struct socket *sock)
> >       int err;
> >       int sent_pkts =3D 0;
> >       bool sock_can_batch =3D (sock->sk->sk_sndbuf =3D=3D INT_MAX);
> > -     bool busyloop_intr;
> >       bool in_order =3D vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> >
> >       do {
> > -             busyloop_intr =3D false;
> > +             bool busyloop_intr =3D false;
> > +
> >               if (nvq->done_idx =3D=3D VHOST_NET_BATCH)
> >                       vhost_tx_batch(net, nvq, sock, &msg);
> >
> > @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net,=
 struct socket *sock)
> >                       break;
> >               /* Nothing new?  Wait for eventfd to tell us they refille=
d. */
> >               if (head =3D=3D vq->num) {
> > -                     /* Kicks are disabled at this point, break loop a=
nd
> > -                      * process any remaining batched packets. Queue w=
ill
> > -                      * be re-enabled afterwards.
> > +                     /* Flush batched packets before enabling
> > +                      * virqtueue notification to reduce
> > +                      * unnecssary virtqueue kicks.
> >                        */
> > +                     vhost_tx_batch(net, nvq, sock, &msg);
>
> So why don't we do this in the "else" branch"? If we are busy polling
> then we are not enabling kicks, so is there a reason to flush?

It should be functional equivalent:

do {
    if (head =3D=3D vq->num) {
        vhost_tx_batch();
        if (unlikely(busyloop_intr)) {
            vhost_poll_queue()
        } else if () {
            vhost_disable_notify(&net->dev, vq);
            continue;
        }
        return;
}

vs

do {
    if (head =3D=3D vq->num) {
        if (unlikely(busyloop_intr)) {
            vhost_poll_queue()
        } else if () {
            vhost_tx_batch();
            vhost_disable_notify(&net->dev, vq);
            continue;
        }
        break;
}

vhost_tx_batch();
return;

Thanks


>
>
> > +                     if (unlikely(busyloop_intr)) {
> > +                             vhost_poll_queue(&vq->poll);
> > +                     } else if (unlikely(vhost_enable_notify(&net->dev=
,
> > +                                                             vq))) {
> > +                             vhost_disable_notify(&net->dev, vq);
> > +                             continue;
> > +                     }
> >                       break;
> >               }
> >
> > @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, =
struct socket *sock)
> >               ++nvq->done_idx;
> >       } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)=
));
> >
> > -     /* Kicks are still disabled, dispatch any remaining batched msgs.=
 */
> >       vhost_tx_batch(net, nvq, sock, &msg);
> > -
> > -     if (unlikely(busyloop_intr))
> > -             /* If interrupted while doing busy polling, requeue the
> > -              * handler to be fair handle_rx as well as other tasks
> > -              * waiting on cpu.
> > -              */
> > -             vhost_poll_queue(&vq->poll);
> > -     else
> > -             /* All of our work has been completed; however, before
> > -              * leaving the TX handler, do one last check for work,
> > -              * and requeue handler if necessary. If there is no work,
> > -              * queue will be reenabled.
> > -              */
> > -             vhost_net_busy_poll_try_queue(net, vq);
> >  }
> >
> >  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *s=
ock)
> > --
> > 2.34.1
>


